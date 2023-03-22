Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6E71FB1
	for <iommu@lists.linux.dev>; Wed, 22 Mar 2023 14:32:57 +0000 (UTC)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 04EBB242DAB;
	Wed, 22 Mar 2023 15:32:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1679495576;
	bh=s+7L1226YGyniLAi3NdgOJRlQwqK8vojAHQR+OJMYgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nVWbu39TgEVIkf1MTfy1XuN0hh1A1na6gS1U0J6iVKoQUF7uU07Zr1of28uFtY1+d
	 WvyfbQYwXPDgb5muU+fC7s5E9YcDmIR1J3Ers8UwCTG8lZowgEByQbLcaKUD6SDY+8
	 6NYPgN1f04qsGnFY7D7u9mvj4V9w5fvZAYU47NB9XJDKlax5lRKK1kkFWcW6UzHHTl
	 j9WNaRENM3jIi7ZM+V6fmhERmgeReKMuGA8V+oGXQbiIKB75ec1IntqW6Y9d7bRCVB
	 JEQj70Gnh6O5eWX7GGzhk37bbL4sAIv0pO+opbRT/rYKFXAFrrS4Ql0lstIveQoRKR
	 dERQot6cbraMg==
Date: Wed, 22 Mar 2023 15:32:54 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Yong Wu <yong.wu@mediatek.com>
Cc: Will Deacon <will@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
	Yunfei Wang <yf.wang@mediatek.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, jianjiao.zeng@mediatek.com,
	chengci.xu@mediatek.com
Subject: Re: [PATCH v2] iommu/mediatek: Set dma_mask for PGTABLE_PA_35_EN
Message-ID: <ZBsRlgJIaQieIbzU@8bytes.org>
References: <20230316064251.7346-1-yong.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316064251.7346-1-yong.wu@mediatek.com>

On Thu, Mar 16, 2023 at 02:42:51PM +0800, Yong Wu wrote:
>  drivers/iommu/mtk_iommu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Applied, thanks.
