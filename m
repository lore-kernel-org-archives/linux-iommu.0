Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086BC6ADE
	for <iommu@lists.linux.dev>; Fri, 13 Jan 2023 12:44:44 +0000 (UTC)
Received: from 8bytes.org (p200300c277327f0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7732:7f00:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id ED600262340;
	Fri, 13 Jan 2023 13:44:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1673613884;
	bh=MscDIF3GsS7zhLNLVm/WiZfXdK2GItkr1gCY7Yuq/gI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rPPebLs22xmYECIA08EQJNTrmdxY/5R/5bZCTMtoBcDNUjONEC2f+5UAg8dAZe75+
	 tqE8v/3rLs7mCO3KLHwvNGsPVWQBtuVvqPwY3CkNFofuCjIbjORA2kfOpk1F+SJqHS
	 vu74z7MbR0+vA3ZD6tOFAUFqsWrOHy3641EGSVcGnfOUn2ROmYiifTNyvZaaOZVeup
	 CHaSNd8Wxg0IAfMYSzJLIyNFFsgFkFpLl3vTxK06O5163O32q9h66/GXsfrk9ouli+
	 wblcy2rD81UzrGfIbXJ5pJIvmpHtRjWubRPBGt7+fMH6SD1A1suPCFFH1DEGwtb3oG
	 3OjlH5HQuawEA==
Date: Fri, 13 Jan 2023 13:44:42 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Honghui Zhang <honghui.zhang@mediatek.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Joerg Roedel <jroedel@suse.de>, iommu@lists.linux.dev,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] iommu/mediatek-v1: Fix an error handling path in
 mtk_iommu_v1_probe()
Message-ID: <Y8FSOqUqQpTa+zAU@8bytes.org>
References: <593e7b7d97c6e064b29716b091a9d4fd122241fb.1671473163.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <593e7b7d97c6e064b29716b091a9d4fd122241fb.1671473163.git.christophe.jaillet@wanadoo.fr>

On Mon, Dec 19, 2022 at 07:06:22PM +0100, Christophe JAILLET wrote:
> Fixes: b17336c55d89 ("iommu/mediatek: add support for mtk iommu generation one HW")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Another option would be to use devm_clk_get_enabled(). This would save a
> few LoC in mtk_iommu_v1_hw_init() and in the remove function.
> However, it would change the order of function calls in the remove function
> so I leave it as-is.
> Let me know if it is fine and if you prefer this alternative.
> ---
>  drivers/iommu/mtk_iommu_v1.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied, thanks.
