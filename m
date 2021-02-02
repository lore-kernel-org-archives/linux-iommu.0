Return-Path: <SRS0=s4mY=HE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD7CC433DB
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 14:13:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CEB164E2B
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 14:13:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CEB164E2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2FBDE20387;
	Tue,  2 Feb 2021 14:13:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pHughjLi26vI; Tue,  2 Feb 2021 14:13:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8C18920382;
	Tue,  2 Feb 2021 14:13:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73182C0174;
	Tue,  2 Feb 2021 14:13:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 062A8C013A
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 14:13:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E8E8185A5A
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 14:13:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K_on5zVzEdtv for <iommu@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 14:13:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6222B85A58
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 14:13:54 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 83B4E3E6; Tue,  2 Feb 2021 15:13:51 +0100 (CET)
Date: Tue, 2 Feb 2021 15:13:50 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH 2/2] iommu: add Unisoc iommu basic driver
Message-ID: <20210202141349.GB32671@8bytes.org>
References: <20210202073258.559443-3-zhang.lyra@gmail.com>
 <20210202104257.736836-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210202104257.736836-1-zhang.lyra@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chunyan Zhang <chunyan.zhang@unisoc.com>, Sheng Xu <sheng.xu@unisoc.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Baolin Wang <baolin.wang7@gmail.com>, Orson Zhai <orsonzhai@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>
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

On Tue, Feb 02, 2021 at 06:42:57PM +0800, Chunyan Zhang wrote:
> +static phys_addr_t sprd_iommu_iova_to_phys(struct iommu_domain *domain,
> +					   dma_addr_t iova)
> +{
> +	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
> +	unsigned long flags;
> +	phys_addr_t pa;
> +	unsigned long start = domain->geometry.aperture_start;
> +	unsigned long end = domain->geometry.aperture_end;
> +
> +	if (iova < start || iova > end)
> +		pr_err("iova (0x%llx) exceed the vpn range[0x%lx-0x%lx]!\n",
> +		       iova, start, end);

It is not a good idea to continue here with an out-of-range iova. The
code below might access random memory for its checks. Better do a
WARN_ON here and return an invalid physical address.

> +
> +	spin_lock_irqsave(&dom->pgtlock, flags);
> +	pa = *(dom->pgt_va + ((iova - start) >> SPRD_IOMMU_PAGE_SHIFT));
> +	pa = (pa << SPRD_IOMMU_PAGE_SHIFT) + ((iova - start) & (SPRD_IOMMU_PAGE_SIZE - 1));
> +	spin_unlock_irqrestore(&dom->pgtlock, flags);
> +
> +	return pa;
> +}
> +
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
