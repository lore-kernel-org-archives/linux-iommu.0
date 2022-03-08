Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D0EC433EF
	for <iommu@archiver.kernel.org>; Tue,  8 Mar 2022 13:40:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5AC2B81971;
	Tue,  8 Mar 2022 13:40:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nqFe2zRNZriv; Tue,  8 Mar 2022 13:40:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 24361818D4;
	Tue,  8 Mar 2022 13:40:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1841C0012;
	Tue,  8 Mar 2022 13:40:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5F3FC000B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Mar 2022 13:40:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9CCCD408FB
 for <iommu@lists.linux-foundation.org>; Tue,  8 Mar 2022 13:40:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2L_dQbszsHm0 for <iommu@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 13:40:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 923C3400D7
 for <iommu@lists.linux-foundation.org>; Tue,  8 Mar 2022 13:40:03 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 756F3139F;
 Tue,  8 Mar 2022 05:40:02 -0800 (PST)
Received: from [10.57.41.254] (unknown [10.57.41.254])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD2C73FA58;
 Tue,  8 Mar 2022 05:39:56 -0800 (PST)
Message-ID: <400b2dd3-120b-9728-3990-801b53447a2b@arm.com>
Date: Tue, 8 Mar 2022 13:39:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v8 04/11] bus: platform,amba,fsl-mc,PCI: Add device DMA
 ownership management
Content-Language: en-GB
To: Lu Baolu <baolu.lu@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>, Alex Williamson
 <alex.williamson@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>
References: <20220308054421.847385-1-baolu.lu@linux.intel.com>
 <20220308054421.847385-5-baolu.lu@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220308054421.847385-5-baolu.lu@linux.intel.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, kvm@vger.kernel.org,
 Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Jonathan Hunter <jonathanh@nvidia.com>, iommu@lists.linux-foundation.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Diana Craciun <diana.craciun@oss.nxp.com>,
 Dan Williams <dan.j.williams@intel.com>, Li Yang <leoyang.li@nxp.com>,
 Will Deacon <will@kernel.org>, Dmitry Osipenko <digetx@gmail.com>
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
> The devices on platform/amba/fsl-mc/PCI buses could be bound to drivers
> with the device DMA managed by kernel drivers or user-space applications.
> Unfortunately, multiple devices may be placed in the same IOMMU group
> because they cannot be isolated from each other. The DMA on these devices
> must either be entirely under kernel control or userspace control, never
> a mixture. Otherwise the driver integrity is not guaranteed because they
> could access each other through the peer-to-peer accesses which by-pass
> the IOMMU protection.
> 
> This checks and sets the default DMA mode during driver binding, and
> cleanups during driver unbinding. In the default mode, the device DMA is
> managed by the device driver which handles DMA operations through the
> kernel DMA APIs (see Documentation/core-api/dma-api.rst).
> 
> For cases where the devices are assigned for userspace control through the
> userspace driver framework(i.e. VFIO), the drivers(for example, vfio_pci/
> vfio_platfrom etc.) may set a new flag (driver_managed_dma) to skip this
> default setting in the assumption that the drivers know what they are
> doing with the device DMA.
> 
> Calling iommu_device_use_default_domain() before {of,acpi}_dma_configure
> is currently a problem. As things stand, the IOMMU driver ignored the
> initial iommu_probe_device() call when the device was added, since at
> that point it had no fwspec yet. In this situation,
> {of,acpi}_iommu_configure() are retriggering iommu_probe_device() after
> the IOMMU driver has seen the firmware data via .of_xlate to learn that
> it actually responsible for the given device. As the result, before
> that gets fixed, iommu_use_default_domain() goes at the end, and calls
> arch_teardown_dma_ops() if it fails.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Stuart Yoder <stuyoder@gmail.com>
> Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Robin Murphy <robin.murphy@arm.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
