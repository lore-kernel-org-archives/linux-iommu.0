Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453AD79C5
	for <iommu@lists.linux.dev>; Tue, 28 Mar 2023 13:28:29 +0000 (UTC)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 04315243E72;
	Tue, 28 Mar 2023 15:28:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1680010108;
	bh=N8ejcUWpQfYs16FWNBvAx22Mygy8fNuSfssyZNAHsVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S2J83d/sK5H3vZbLIwLROix4mqLAb2VDHvOFSNiknrxfQKKaKJo0d6rpw9uVZs7XT
	 b9cAav6Wvck0r7qIh2fcfocaENy4y5CIQMW7evRm5h3AcJyeKWSgA0r9QLYehPaOFd
	 JfiBYLs7Zm93B87i7fzVk6yprFq0blc/151RIIB2k9zcqMMfXHKdeYS52TGw4QTu93
	 +SHgeIuCQdR9W6l/YYAR6+f0Ju48+XvZ6Med50yaCi5ImeJffSvsfITt4vNtEnA+Fm
	 exnQ4/+G2YYeQuAc5qSBwalmLudOdhQhc3KFEHWJfcZ67kRHmIEa9/xqilbXxIBXPq
	 Ul0YyTHUQVaVg==
Date: Tue, 28 Mar 2023 15:28:26 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Dan Carpenter <error27@gmail.com>
Cc: Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chengci.Xu" <chengci.xu@mediatek.com>, iommu@lists.linux.dev,
	linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iommu/mediatek: fix a reversed test in probe
Message-ID: <ZCLreuVYNcXtkCHH@8bytes.org>
References: <88c83ce7-5d1a-44a8-b9bf-0d01cfea24db@kili.mountain>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88c83ce7-5d1a-44a8-b9bf-0d01cfea24db@kili.mountain>

On Sat, Mar 25, 2023 at 02:07:52PM +0300, Dan Carpenter wrote:
> The dma_set_mask() function returns negative error codes on failure but
> this code is testing for zero instead.
> 
> Fixes: f4b49c7c5e67 ("iommu/mediatek: Set dma_mask for PGTABLE_PA_35_EN")
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
>  drivers/iommu/mtk_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks for the fix, but I replaced above commit with v3, which I
overlooked when applying it. The v3 post has this already fixed.

Regards,

	Joerg
