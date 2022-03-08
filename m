Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4211AC4332F
	for <iommu@archiver.kernel.org>; Tue,  8 Mar 2022 13:37:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E7ABE60F92;
	Tue,  8 Mar 2022 13:37:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GSLFbQ0IOzch; Tue,  8 Mar 2022 13:37:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9F93560F4A;
	Tue,  8 Mar 2022 13:37:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 725B5C0012;
	Tue,  8 Mar 2022 13:37:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1120EC000B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Mar 2022 13:37:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E0F07841F7
 for <iommu@lists.linux-foundation.org>; Tue,  8 Mar 2022 13:37:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RlFexf22f7HH for <iommu@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 13:37:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 20DFC84192
 for <iommu@lists.linux-foundation.org>; Tue,  8 Mar 2022 13:37:16 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 513A2139F;
 Tue,  8 Mar 2022 05:37:16 -0800 (PST)
Received: from [10.57.41.254] (unknown [10.57.41.254])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B013C3FA58;
 Tue,  8 Mar 2022 05:37:10 -0800 (PST)
Message-ID: <d8bbe591-b6c3-d44a-7a7d-3187e8377e4f@arm.com>
Date: Tue, 8 Mar 2022 13:37:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v8 01/11] iommu: Add DMA ownership management interfaces
Content-Language: en-GB
To: Lu Baolu <baolu.lu@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>, Alex Williamson
 <alex.williamson@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>
References: <20220308054421.847385-1-baolu.lu@linux.intel.com>
 <20220308054421.847385-2-baolu.lu@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220308054421.847385-2-baolu.lu@linux.intel.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Stuart Yoder <stuyoder@gmail.com>,
 kvm@vger.kernel.org, rafael@kernel.org, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
 linux-kernel@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>,
 iommu@lists.linux-foundation.org, Thierry Reding <thierry.reding@gmail.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Li Yang <leoyang.li@nxp.com>, Will Deacon <will@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>
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

On 2022-03-08 05:44, Lu Baolu wrote:
> Multiple devices may be placed in the same IOMMU group because they
> cannot be isolated from each other. These devices must either be
> entirely under kernel control or userspace control, never a mixture.
> 
> This adds dma ownership management in iommu core and exposes several
> interfaces for the device drivers and the device userspace assignment
> framework (i.e. VFIO), so that any conflict between user and kernel
> controlled dma could be detected at the beginning.
> 
> The device driver oriented interfaces are,
> 
> 	int iommu_device_use_default_domain(struct device *dev);
> 	void iommu_device_unuse_default_domain(struct device *dev);
> 
> By calling iommu_device_use_default_domain(), the device driver tells
> the iommu layer that the device dma is handled through the kernel DMA
> APIs. The iommu layer will manage the IOVA and use the default domain
> for DMA address translation.
> 
> The device user-space assignment framework oriented interfaces are,
> 
> 	int iommu_group_claim_dma_owner(struct iommu_group *group,
> 					void *owner);
> 	void iommu_group_release_dma_owner(struct iommu_group *group);
> 	bool iommu_group_dma_owner_claimed(struct iommu_group *group);
> 
> The device userspace assignment must be disallowed if the DMA owner
> claiming interface returns failure.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
