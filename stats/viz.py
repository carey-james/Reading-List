import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt

# CONSTANTS
BOOKS_FILES = {'2022': '../2022/books.csv','2023': '../2023/books.csv','2024': '../2024/books.csv'}
IMAGES_DIR = './imgs/'
SNS_STYLE = 'white'

def read_in_csv(file_path):
	df = pd.read_csv(file_path, sep='|', index_col=False, header=0)
	return df

def create_scatter(title, df, x, y, hue):
	sns.set_style(SNS_STYLE)
	ax = sns.scatterplot(data=df, x=x, y=y, hue=hue, style=hue)
	img_path = f'{IMAGES_DIR}{title}.png'
	plt.savefig(img_path)
	plt.close()
	return	img_path

def main():
	# Read in the books data:
	dfs = []
	for key in BOOKS_FILES:
		temp_df = read_in_csv(BOOKS_FILES[key])
		temp_df['year'] = key
		dfs.append(temp_df)
	df = pd.concat(dfs)
	print(create_scatter('Pages vs Published', df, 'published', 'pages', 'genre'))

if __name__ == '__main__':
	main()