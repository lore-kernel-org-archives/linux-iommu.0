Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED123C433F5
	for <iommu@archiver.kernel.org>; Mon,  7 Feb 2022 07:08:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A4BF812D1;
	Mon,  7 Feb 2022 07:08:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kB8BvHiVZyey; Mon,  7 Feb 2022 07:08:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7D22E80C12;
	Mon,  7 Feb 2022 07:08:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F0AAC001A;
	Mon,  7 Feb 2022 07:08:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C58C2C000B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 07:08:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ADCF580C0D
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 07:08:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sVOaybAsgj9y for <iommu@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 07:08:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D3C1E80AC9
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 07:08:55 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id A696E68AFE; Mon,  7 Feb 2022 08:08:49 +0100 (CET)
Date: Mon, 7 Feb 2022 08:08:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v1 01/10] iommu/vt-d: Move DMAR specific helpers into
 dmar.c
Message-ID: <20220207070849.GA23941@lst.de>
References: <20220207064142.1092846-1-baolu.lu@linux.intel.com>
 <20220207064142.1092846-2-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220207064142.1092846-2-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

> --- a/include/linux/dmar.h
> +++ b/include/linux/dmar.h
> @@ -52,6 +52,32 @@ struct dmar_drhd_unit {
>  	struct intel_iommu *iommu;
>  };
>  
> +struct dmar_rmrr_unit {

> +struct dmar_atsr_unit {

> +struct dmar_satc_unit {

What about moving all code that is using the structures to dmar.c 
to keep the definitions local?

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
