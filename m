Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96BFC433FE
	for <iommu@archiver.kernel.org>; Tue, 24 May 2022 15:13:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B28C415DD;
	Tue, 24 May 2022 15:13:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wB1QvjOFCinV; Tue, 24 May 2022 15:13:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E42B6415D5;
	Tue, 24 May 2022 15:13:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ABDC1C0039;
	Tue, 24 May 2022 15:13:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31B74C002D
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 15:13:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0BBBB60E28
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 15:13:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oLcAGU_pjdaO for <iommu@lists.linux-foundation.org>;
 Tue, 24 May 2022 15:13:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5C9B360E13
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 15:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653405215; x=1684941215;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Tk27iwpVLwZhrAdYRAP9PXSjtSwimSeDsovqZPPM1B0=;
 b=L6HbKekScTgGHuCNnisNh58guVMP+bOQgs52UBY7ucjDS97M+A46Zwkg
 R8aIolMyGd5k9UV5xuDRGIqhCQWisyIQrM+D1BO7Z7OzzFjDXlAG/MpiZ
 JhZpALRFSqs7EfULAx0smGLnBZ2sdRxWLZ8a2oyuBkmhGih2C2KcSm2e4
 WgZNinVlUcRghPfwIhFMlthweWZ120SEDaXrM7eKUUo14AfQwFbu3Rj+g
 uachqsJ5ErIiYDukg7wnr72bBUsBIV414IUjTnSr5+ajWbt1C3O6aIM1A
 THj8WOPMH3TZDfJikCQ/5qp5TbLyjdpON1DkV9i09N3iStGBDTHmnvKt1 g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="261165692"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; d="scan'208";a="261165692"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2022 08:13:34 -0700
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; d="scan'208";a="572702343"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2022 08:13:34 -0700
Date: Tue, 24 May 2022 08:17:27 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 1/6] iommu: Add a per domain PASID for DMA API
Message-ID: <20220524081727.19c2dd6d@jacob-builder>
In-Reply-To: <20220524135034.GU1343366@nvidia.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
 <20220518182120.1136715-2-jacob.jun.pan@linux.intel.com>
 <20220524135034.GU1343366@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: vkoul@kernel.org, "Tian, Kevin" <kevin.tian@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 will@kernel.org, David Woodhouse <dwmw2@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, dmaengine@vger.kernel.org,
 robin.murphy@arm.com, Jean-Philippe Brucker <jean-philippe@linaro.com>
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

Hi Jason,

On Tue, 24 May 2022 10:50:34 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, May 18, 2022 at 11:21:15AM -0700, Jacob Pan wrote:
> > DMA requests tagged with PASID can target individual IOMMU domains.
> > Introduce a domain-wide PASID for DMA API, it will be used on the same
> > mapping as legacy DMA without PASID. Let it be IOVA or PA in case of
> > identity domain.  
> 
> Huh? I can't understand what this is trying to say or why this patch
> makes sense.
> 
> We really should not have pasid's like this attached to the domains..
> 
This is the same "DMA API global PASID" you reviewed in v3, I just
singled it out as a standalone patch and renamed it. Here is your previous
review comment.

> +++ b/include/linux/iommu.h
> @@ -105,6 +105,8 @@ struct iommu_domain {
>  	enum iommu_page_response_code (*iopf_handler)(struct iommu_fault *fault,
>  						      void *data);
>  	void *fault_data;
> +	ioasid_t pasid;		/* Used for DMA requests with PASID */
> +	atomic_t pasid_users;  

These are poorly named, this is really the DMA API global PASID and
shouldn't be used for other things.



Perhaps I misunderstood, do you mind explaining more?


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
