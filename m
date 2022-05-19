Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D2AC433F5
	for <iommu@archiver.kernel.org>; Thu, 19 May 2022 20:06:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ADC0C61317;
	Thu, 19 May 2022 20:06:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Szy5Txsf7C2P; Thu, 19 May 2022 20:06:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 81BC060B9B;
	Thu, 19 May 2022 20:06:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F49FC0039;
	Thu, 19 May 2022 20:06:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 039A7C002D
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 20:06:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E0A8182FA5
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 20:06:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GVGaRT3l1PEO for <iommu@lists.linux-foundation.org>;
 Thu, 19 May 2022 20:06:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E929082F8B
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 20:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652990808; x=1684526808;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=em9680kU19oyJd12oVrtmjdy90mEXzPAGRZB1JnG5kg=;
 b=IQsva6CgijlYEakSsI241Yzx56Qfn44SoROmGLUZfA9ZWoHFzlv648Kx
 hpQfIH9MVdu2bUyombMS7itP8Ex/k1f6yjZ/8cvnWoPF+4/QyWnmQye7P
 ZMcOOtqK7r6hI02dtfDZq9oSOWXT4QxVtuR0oa7X/GSYSaglVAQOrIJUm
 UDGfyozweQO4IMhHCiCrlNMsLsx77S4isz8P3ZY9yQxFlEOEb1/Oc3LxD
 Cm8jxNK83HTv0Xqv/wDG20zf3TbGa6pFGljTmqxV3E2mTT7Soi9v6v0DY
 z8z1TDeMrF0lcMhlIzDUfvjoyCkpw6ynAk/DzmpJLyQ44yqJDxFBMKqDp w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="272323855"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; d="scan'208";a="272323855"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2022 13:06:47 -0700
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; d="scan'208";a="557094209"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2022 13:06:47 -0700
Date: Thu, 19 May 2022 13:10:37 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 2/6] iommu: Add a helper to do PASID lookup from domain
Message-ID: <20220519131037.08d7590f@jacob-builder>
In-Reply-To: <41c717e3-2965-67ac-9140-72f4b071cd9a@linux.intel.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
 <20220518182120.1136715-3-jacob.jun.pan@linux.intel.com>
 <41c717e3-2965-67ac-9140-72f4b071cd9a@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: vkoul@kernel.org, "Tian, Kevin" <kevin.tian@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 will@kernel.org, David Woodhouse <dwmw2@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, Jason Gunthorpe <jgg@nvidia.com>,
 dmaengine@vger.kernel.org, Jean-Philippe Brucker <jean-philippe@linaro.com>,
 robin.murphy@arm.com
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

Hi Baolu,

On Thu, 19 May 2022 14:41:06 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> > IOMMU group maintains a PASID array which stores the associated IOMMU
> > domains. This patch introduces a helper function to do domain to PASID
> > look up. It will be used by TLB flush and device-PASID attach
> > verification.  
> 
> Do you really need this?
> 
> The IOMMU driver has maintained a device tracking list for each domain.
> It has been used for cache invalidation when unmap() is called against
> dma domain.
Yes, I am aware of the device list. In v3, I stored DMA API PASID in device
list of device_domain_info. Since we already have a pasid_array, Jason
suggested to share the storage with the code. This helper is needed to
reverse look up the DMA PASID based on the domain attached.
Discussions here:
https://lore.kernel.org/lkml/20220511170025.GF49344@nvidia.com/t/#mf7cb7d54d89e6e732a020dc22435260da0a49580

Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
