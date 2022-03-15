Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A26C433EF
	for <iommu@archiver.kernel.org>; Tue, 15 Mar 2022 15:46:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E368460FDC;
	Tue, 15 Mar 2022 15:46:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AYpLe7ZZJ-cq; Tue, 15 Mar 2022 15:46:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DF79D60FF6;
	Tue, 15 Mar 2022 15:46:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AAB65C0012;
	Tue, 15 Mar 2022 15:46:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02EBEC000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 15:46:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E46C740A22
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 15:46:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kph0wqks0qec for <iommu@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 15:46:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1402B40A49
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 15:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647359178; x=1678895178;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9l3zMa1N2Xp5sxnI3YEfCtneKtd5sTYwcoovBFmuHj4=;
 b=arOYZ1uJ5endx+3k+Dlx7y4dL9x/Qh0CG6sX4Tz4WfDuswB18PXMDUEn
 yU0PlDkPf75MeImqt2XFHQO27hPLQUxKToPYk5o7fNNKjKnU9v+vGnWQE
 NLJfizKkIWi0KHkLjGxCRukUGZ4Yd+g0h3OOVlUgUYtg0ZZ4A0PfMeS8z
 xQ7z5lmW8HJUv2XO2611BLOXcFLMCWaL+AEnN8LR2Hq2h4rLx4Q9hHfl4
 vIUd5PmZJ1cHRZSWVWUvIQen8PLu4AgZRl8+HPJFR5X5WAh4Txms8V5Qo
 MpfEWSYXvU4VyUEPmHUfdEdDqWnv+dh1KHGzgPXsKBY03zNowbiwK6wmP Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="342767119"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; d="scan'208";a="342767119"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2022 08:45:57 -0700
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; d="scan'208";a="515921223"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2022 08:45:56 -0700
Date: Tue, 15 Mar 2022 08:49:12 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v2 0/8] Enable PASID for DMA API users
Message-ID: <20220315084912.52f98cf8@jacob-builder>
In-Reply-To: <BN9PR11MB5276F78A62AD159A73868C268C109@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <BN9PR11MB5276F78A62AD159A73868C268C109@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Luck,
 Tony" <tony.luck@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Jason
 Gunthorpe <jgg@nvidia.com>, "Williams, Dan J" <dan.j.williams@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
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

Hi Kevin,

On Tue, 15 Mar 2022 08:16:59 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Tuesday, March 15, 2022 1:07 PM
> > 
> > Some modern accelerators such as Intel's Data Streaming Accelerator
> > (DSA) require PASID in DMA requests to be operational. Specifically,
> > the work submissions with ENQCMD on shared work queues require PASIDs.
> > The use cases
> > include both user DMA with shared virtual addressing (SVA) and in-kernel
> > DMA similar to legacy DMA w/o PASID. Here we address the latter.
> > 
> > DMA mapping API is the de facto standard for in-kernel DMA. However, it
> > operates on a per device or Requester ID(RID) basis which is not
> > PASID-aware. To leverage DMA API for devices relies on PASIDs, this
> > patchset introduces the following APIs
> > 
> > 1. A driver facing API that enables DMA API PASID usage:
> > iommu_enable_pasid_dma(struct device *dev, ioasid_t &pasid);  
> 
> Should this be called dma_enable_pasid() since it's about DMA API? Doing
> so also avoids the driver to include iommu.h.
> 
PASID is still tied to IOMMU, drivers who wants to use this must explicitly
put dependency on IOMMU. So I prefer not to give that illusion.

> Thanks
> Kevin


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
