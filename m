Return-Path: <SRS0=RnLw=MA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9986C07E9C
	for <iommu@archiver.kernel.org>; Thu,  8 Jul 2021 09:28:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 531F261CCA
	for <iommu@archiver.kernel.org>; Thu,  8 Jul 2021 09:28:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 531F261CCA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 029D6405AF;
	Thu,  8 Jul 2021 09:28:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 92XKZXyID7AQ; Thu,  8 Jul 2021 09:28:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D91D640603;
	Thu,  8 Jul 2021 09:28:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B44EC0010;
	Thu,  8 Jul 2021 09:28:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2B84C000E
 for <iommu@lists.linux-foundation.org>; Thu,  8 Jul 2021 09:28:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 84AD382A5D
 for <iommu@lists.linux-foundation.org>; Thu,  8 Jul 2021 09:28:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M8cBdqD61gWd for <iommu@lists.linux-foundation.org>;
 Thu,  8 Jul 2021 09:28:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E597182A29
 for <iommu@lists.linux-foundation.org>; Thu,  8 Jul 2021 09:28:08 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 91EC8312; Thu,  8 Jul 2021 11:28:06 +0200 (CEST)
Date: Thu, 8 Jul 2021 11:28:05 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] iommu/amd: Enable swiotlb if any device supports iommu
 v2 and uses identity mapping
Message-ID: <YObFJREB9/JlcNZP@8bytes.org>
References: <20210708074232.924844-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210708074232.924844-1-kai.heng.feng@canonical.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
 "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 will@kernel.org, open list <linux-kernel@vger.kernel.org>
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

On Thu, Jul 08, 2021 at 03:42:32PM +0800, Kai-Heng Feng wrote:
> @@ -344,6 +344,9 @@ static int iommu_init_device(struct device *dev)
>  
>  		iommu = amd_iommu_rlookup_table[dev_data->devid];
>  		dev_data->iommu_v2 = iommu->is_iommu_v2;
> +
> +		if (dev_data->iommu_v2)
> +			swiotlb = 1;

This looks like the big hammer, as it will affect all other systems
where the AMD GPUs are in their own group.

What is needed here is an explicit check whether a non-iommu-v2 device
is direct-mapped because it shares a group with the GPU, and only enable
swiotlb in this case.

Thanks,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
