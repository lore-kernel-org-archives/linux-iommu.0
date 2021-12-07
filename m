Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15974C433EF
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 09:48:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AA2EE40264;
	Tue,  7 Dec 2021 09:48:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kWqB5S3TnkLb; Tue,  7 Dec 2021 09:48:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3E78E400DE;
	Tue,  7 Dec 2021 09:48:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A032C001E;
	Tue,  7 Dec 2021 09:48:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C38CBC0012
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 09:48:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B12FD41C2A
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 09:48:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hqOd34x4o7Pq for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 09:48:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6BABD41C16
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 09:48:29 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 63B4BB8169C;
 Tue,  7 Dec 2021 09:48:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9FEC341C3;
 Tue,  7 Dec 2021 09:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638870505;
 bh=vU8wO38cP4NaOW9H1aLEKq1y2IOx0CaMh4iBi218CjU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JKxmAVaxRiMthinPzyb/GcsePkjpJw8O/mteJcgWW9g3zif2K+CfLAKjdwJxdrV6h
 4r+MXtfN5+JID54y4/Z+GKX2EX/usLdo1iXgniGYgujBHcGZc07NhBk21P9XvCGVlq
 zkrpag/zlD0PM6BVrhCHBl6pwYe2FhBlTvxhDzgDgM/cl1+FIm4eD/claqL9k6ZFXW
 uJtDSGZ9uWSd7+DrynFCx74rwtQdFsEbCkAwGIzqhM+/s1NzaIys5E/1aNOlJprNGx
 Hkv8fd7EG7o4HrkIHd3IKyHz0/FpXfUhnFrQmD1SVMoYx/Dy5w6RjfHfcqFeP87Hol
 50IdLUEtOQDqg==
Date: Tue, 7 Dec 2021 09:48:18 +0000
From: Will Deacon <will@kernel.org>
To: yf.wang@mediatek.com
Subject: Re: [PATCH] iommu/io-pgtable-arm-v7s: Add error handle for page
 table allocation failure
Message-ID: <20211207094817.GA31382@willie-the-truck>
References: <20211207024723.25751-1-yf.wang@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211207024723.25751-1-yf.wang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Guangming Cao <Guangming.Cao@mediatek.com>, wsd_upstream@mediatek.com,
 open list <linux-kernel@vger.kernel.org>, Libo Kang <Libo.Kang@mediatek.com>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, Dec 07, 2021 at 10:47:22AM +0800, yf.wang@mediatek.com wrote:
> From: Yunfei Wang <yf.wang@mediatek.com>
> 
> In __arm_v7s_alloc_table function:
> iommu call kmem_cache_alloc to allocate page table, this function
> allocate memory may fail, when kmem_cache_alloc fails to allocate
> table, call virt_to_phys will be abnomal and return unexpected phys
> and goto out_free, then call kmem_cache_free to release table will
> trigger KE, __get_free_pages and free_pages have similar problem,
> so add error handle for page table allocation failure.
> 
> Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
> ---
>  drivers/iommu/io-pgtable-arm-v7s.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> index bfb6acb651e5..d84240308f4b 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -246,6 +246,12 @@ static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
>  			__GFP_ZERO | ARM_V7S_TABLE_GFP_DMA, get_order(size));
>  	else if (lvl == 2)
>  		table = kmem_cache_zalloc(data->l2_tables, gfp);
> +
> +	if (!table) {
> +		dev_err(dev, "Page table allocation failure lvl:%d\n", lvl);

I'd expect the allocator to shout loudly on failure anyway, so I don't think
we need to print another message here.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
