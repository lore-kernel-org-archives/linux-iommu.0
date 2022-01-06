Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E73FC433EF
	for <iommu@archiver.kernel.org>; Thu,  6 Jan 2022 03:54:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 24AF160E75;
	Thu,  6 Jan 2022 03:54:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h0yZqr1-lMJW; Thu,  6 Jan 2022 03:54:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1DB4E605A0;
	Thu,  6 Jan 2022 03:54:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0CD9C002F;
	Thu,  6 Jan 2022 03:54:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F0F0C001E
 for <iommu@lists.linux-foundation.org>; Thu,  6 Jan 2022 03:54:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3DE75428EB
 for <iommu@lists.linux-foundation.org>; Thu,  6 Jan 2022 03:54:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 44BQ6E274NVw for <iommu@lists.linux-foundation.org>;
 Thu,  6 Jan 2022 03:54:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A92AE428E6
 for <iommu@lists.linux-foundation.org>; Thu,  6 Jan 2022 03:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1641441293; x=1672977293;
 h=cc:subject:to:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=Rqej3wXaYOK+xVJk5ty5fNj2P0uGjYEUdNVw2YgTyps=;
 b=I0L/VMUizOP+uYYThVATOWiTF0ENAozgR0D7RdbcNsqTh9rEoSrFEd0t
 2zh3KFEgactrWvQL4zziUn2KyLCVY1htvZFMoC4vaTUTpZBsAZuIrmVJ6
 T4NTYu3cVR11icbuILoua3bFXqcNTIyRz+NpVgybmBXa7ivqqnWwu7ZIR
 ZVTcYXSLCQrSiDxG1D+B0IwHizTx63kYdl50vGegb8AipNpPchVcRL7bB
 pLlNF8PxlS/vZPjCZlmHHVEYnvBzS9nv1hvOajdO5eLLJzayiDmIxODhx
 Rl0d+vbjK8fsG1CTQCE1x1NVE1eqNSJHIxkM4HfOkbWnduCXuMMP+0Q5q w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="266870126"
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; d="scan'208";a="266870126"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2022 19:54:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; d="scan'208";a="526816309"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 05 Jan 2022 19:54:45 -0800
Subject: Re: [PATCH v5 01/14] iommu: Add dma ownership management interfaces
To: Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <helgaas@kernel.org>
References: <YdQcgFhIMYvUwABV@infradead.org>
 <20220104164100.GA101735@bhelgaas> <20220104192348.GK2328285@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <9486face-0778-b8d0-6989-94c2e876446b@linux.intel.com>
Date: Thu, 6 Jan 2022 11:54:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220104192348.GK2328285@nvidia.com>
Content-Language: en-US
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
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

On 1/5/22 3:23 AM, Jason Gunthorpe wrote:
>>>> The device driver oriented interfaces are,
>>>>
>>>> 	int iommu_device_use_dma_api(struct device *dev);
>>>> 	void iommu_device_unuse_dma_api(struct device *dev);
>> Nit, do we care whether it uses the actual DMA API?  Or is it just
>> that iommu_device_use_dma_api() tells us the driver may program the
>> device to do DMA?
> As the main purpose, yes this is all about the DMA API because it
> asserts the group domain is the DMA API's domain.
> 
> There is a secondary purpose that has to do with the user/kernel
> attack you mentioned above. Maintaining the DMA API domain also
> prevents VFIO from allowing userspace to operate any device in the
> group which blocks P2P attacks to MMIO of other devices.
> 
> This is why, even if the driver doesn't use DMA, it should still do a
> iommu_device_use_dma_api(), except in the special cases where we don't
> care about P2P attacks (eg pci-stub, bridges, etc).
> 

By the way, use_dma_api seems hard to read. How about

	iommu_device_use_default_dma()?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
