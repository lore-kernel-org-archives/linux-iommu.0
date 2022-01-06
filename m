Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6627FC433FE
	for <iommu@archiver.kernel.org>; Thu,  6 Jan 2022 03:48:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ECE9760E75;
	Thu,  6 Jan 2022 03:48:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2e2XfjV-PWRF; Thu,  6 Jan 2022 03:48:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D05F860E14;
	Thu,  6 Jan 2022 03:48:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B356CC002F;
	Thu,  6 Jan 2022 03:48:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41D7AC001E
 for <iommu@lists.linux-foundation.org>; Thu,  6 Jan 2022 03:48:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1ABD442868
 for <iommu@lists.linux-foundation.org>; Thu,  6 Jan 2022 03:48:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HwqIR039xtMn for <iommu@lists.linux-foundation.org>;
 Thu,  6 Jan 2022 03:48:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E390B409DE
 for <iommu@lists.linux-foundation.org>; Thu,  6 Jan 2022 03:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1641440916; x=1672976916;
 h=cc:subject:to:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=s88NpyScOH/XjHqT1y7xLL0UmtzfW9rw5bZNtIuacDQ=;
 b=lOxOwoIQ15KuMbql7N6AA6wUn/8h0QE56SMTMYQN0iObfPbvzVXE3RsL
 tdpk8YE82tlUQIlxqgpof0+P4yxfDo5zk0kOXtu0c7KzyMAMz9l4u2kiC
 XW7hQ8104P1HPAekaxqFbuOIus56Fa7imOVWHWxYxurRZluM3Lh2onOi4
 0DfsSEKuXCLKLMoQzN3saDKhAxaLOS1wKGCah2cnHSYtSklqf8NXk+SoN
 ZVxq3z5dSByuNjmLFZx+0jOMNrwmvVzukrciWU0+lcTl16u0bEwcADI7K
 xqCy4qYS//0pyFgvBNbPY2mDm3fE009kLCTvM0R3elDAFmXxfcNd5DJiA A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="242790752"
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; d="scan'208";a="242790752"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2022 19:48:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; d="scan'208";a="526815184"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 05 Jan 2022 19:48:29 -0800
Subject: Re: [PATCH v5 01/14] iommu: Add dma ownership management interfaces
To: Bjorn Helgaas <helgaas@kernel.org>, Christoph Hellwig <hch@infradead.org>
References: <20220104164100.GA101735@bhelgaas>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <8e83da6c-7ae4-b855-ccf0-148d2babfcce@linux.intel.com>
Date: Thu, 6 Jan 2022 11:47:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220104164100.GA101735@bhelgaas>
Content-Language: en-US
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 1/5/22 12:41 AM, Bjorn Helgaas wrote:
>>> Devices under kernel drivers control must call iommu_device_use_dma_api()
>>> before driver probes. The driver binding process must be aborted if it
>>> returns failure.
> "Devices" don't call functions.  Drivers do, or in this case, it looks
> like the bus DMA code (platform, amba, fsl, pci, etc).
> 
> These functions are EXPORT_SYMBOL_GPL(), but it looks like all the
> callers are built-in, so maybe the export is unnecessary?

Yes. If all callers are built-in, we can remove this export.

> 
> You use "iommu"/"IOMMU" and "dma"/"DMA" interchangeably above.  Would
> be easier to read if you picked one.
> 

I should cleanup all these. I also realized that I forgot to
cleanup some typos you pointed out in v4:

https://lore.kernel.org/linux-iommu/20211229211626.GA1701512@bhelgaas/

Sorry about it. I will take care of all these in the next version.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
