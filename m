Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 674BCC433F5
	for <iommu@archiver.kernel.org>; Tue,  4 Jan 2022 05:23:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EDE66400BA;
	Tue,  4 Jan 2022 05:23:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jeeBKkcWrTGP; Tue,  4 Jan 2022 05:23:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6602E400F5;
	Tue,  4 Jan 2022 05:23:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3AABCC0030;
	Tue,  4 Jan 2022 05:23:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4F66C001E
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 05:23:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D1B41825CA
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 05:23:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MidOcnDgRiBv for <iommu@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 05:23:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CFED5825C7
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 05:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1641273826; x=1672809826;
 h=cc:subject:to:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=uXKPyRWOnxNU5FJs1OVLLK8xkyzVa8K8E1f+yzjqR1k=;
 b=EwMkS0K0QGzIOb8kKa3Y6vhCNpPowM9TeZwQn+IpRffRvPzl3BESkPGX
 vG6I8qraTfzgUO4924hd5mUdL/s/6Ns3LNOEn5ZEsveSQLMQiqMHMJLfn
 5ItZVvrM/shkzT59+ZSlugJaNG4rywQB56CnsBc1aDKnlHNJ8Z+O7ckgH
 SNBI49mUhwLZanzooju0lfAHvV9iCF3ReE2YDXSQriCCHJWZnyUyQveSf
 MRaMyL/CSXpKbtvHpaLJDTNj5YFIgF7M4WCIuNSuQUUpRRBpBp0dJu0RB
 iX9aRdB4Sy5iArY8z47jI0reMVsJSdqJEaOjXcLYybWcCG/EA5oV7f8SX A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="222151242"
X-IronPort-AV: E=Sophos;i="5.88,260,1635231600"; d="scan'208";a="222151242"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jan 2022 21:23:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,260,1635231600"; d="scan'208";a="525866862"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 03 Jan 2022 21:23:39 -0800
Subject: Re: [PATCH v4 00/13] Fix BUG_ON in vfio_iommu_group_notifier()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>, Alex Williamson
 <alex.williamson@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>
References: <20211217063708.1740334-1-baolu.lu@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <d7ca046e-37fe-937b-d7cf-55af3839f0a0@linux.intel.com>
Date: Tue, 4 Jan 2022 13:23:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211217063708.1740334-1-baolu.lu@linux.intel.com>
Content-Language: en-US
Cc: kvm@vger.kernel.org, rafael@kernel.org, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Stuart Yoder <stuyoder@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Dan Williams <dan.j.williams@intel.com>, Cornelia Huck <cohuck@redhat.com>,
 linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Daniel Vetter <daniel@ffwll.ch>, Robin Murphy <robin.murphy@arm.com>
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

On 12/17/21 2:36 PM, Lu Baolu wrote:
> Hi folks,
> 
> The iommu group is the minimal isolation boundary for DMA. Devices in
> a group can access each other's MMIO registers via peer to peer DMA
> and also need share the same I/O address space.
> 
> Once the I/O address space is assigned to user control it is no longer
> available to the dma_map* API, which effectively makes the DMA API
> non-working.
> 
> Second, userspace can use DMA initiated by a device that it controls
> to access the MMIO spaces of other devices in the group. This allows
> userspace to indirectly attack any kernel owned device and it's driver.
> 
> Therefore groups must either be entirely under kernel control or
> userspace control, never a mixture. Unfortunately some systems have
> problems with the granularity of groups and there are a couple of
> important exceptions:
> 
>   - pci_stub allows the admin to block driver binding on a device and
>     make it permanently shared with userspace. Since PCI stub does not
>     do DMA it is safe, however the admin must understand that using
>     pci_stub allows userspace to attack whatever device it was bound
>     it.
> 
>   - PCI bridges are sometimes included in groups. Typically PCI bridges
>     do not use DMA, and generally do not have MMIO regions.
> 
> Generally any device that does not have any MMIO registers is a
> possible candidate for an exception.
> 
> Currently vfio adopts a workaround to detect violations of the above
> restrictions by monitoring the driver core BOUND event, and hardwiring
> the above exceptions. Since there is no way for vfio to reject driver
> binding at this point, BUG_ON() is triggered if a violation is
> captured (kernel driver BOUND event on a group which already has some
> devices assigned to userspace). Aside from the bad user experience
> this opens a way for root userspace to crash the kernel, even in high
> integrity configurations, by manipulating the module binding and
> triggering the BUG_ON.
> 
> This series solves this problem by making the user/kernel ownership a
> core concept at the IOMMU layer. The driver core enforces kernel
> ownership while drivers are bound and violations now result in a error
> codes during probe, not BUG_ON failures.
> 
> Patch partitions:
>    [PATCH 1-4]: Detect DMA ownership conflicts during driver binding;
>    [PATCH 5-8]: Add security context management for assigned devices;
>    [PATCH 9-13]: Various cleanups.
> 
> This is also part one of three initial series for IOMMUFD:
>   * Move IOMMU Group security into the iommu layer
>   - Generic IOMMUFD implementation
>   - VFIO ability to consume IOMMUFD
> 
> Change log:
> v1: initial post
>    - https://lore.kernel.org/linux-iommu/20211115020552.2378167-1-baolu.lu@linux.intel.com/
> 
> v2:
>    - https://lore.kernel.org/linux-iommu/20211128025051.355578-1-baolu.lu@linux.intel.com/
> 
>    - Move kernel dma ownership auto-claiming from driver core to bus
>      callback. [Greg/Christoph/Robin/Jason]
>      https://lore.kernel.org/linux-iommu/20211115020552.2378167-1-baolu.lu@linux.intel.com/T/#m153706912b770682cb12e3c28f57e171aa1f9d0c
> 
>    - Code and interface refactoring for iommu_set/release_dma_owner()
>      interfaces. [Jason]
>      https://lore.kernel.org/linux-iommu/20211115020552.2378167-1-baolu.lu@linux.intel.com/T/#mea70ed8e4e3665aedf32a5a0a7db095bf680325e
> 
>    - [NEW]Add new iommu_attach/detach_device_shared() interfaces for
>      multiple devices group. [Robin/Jason]
>      https://lore.kernel.org/linux-iommu/20211115020552.2378167-1-baolu.lu@linux.intel.com/T/#mea70ed8e4e3665aedf32a5a0a7db095bf680325e
> 
>    - [NEW]Use iommu_attach/detach_device_shared() in drm/tegra drivers.
> 
>    - Refactoring and description refinement.
> 
> v3:
>    - https://lore.kernel.org/linux-iommu/20211206015903.88687-1-baolu.lu@linux.intel.com/
> 
>    - Rename bus_type::dma_unconfigure to bus_type::dma_cleanup. [Greg]
>      https://lore.kernel.org/linux-iommu/c3230ace-c878-39db-1663-2b752ff5384e@linux.intel.com/T/#m6711e041e47cb0cbe3964fad0a3466f5ae4b3b9b
> 
>    - Avoid _platform_dma_configure for platform_bus_type::dma_configure.
>      [Greg]
>      https://lore.kernel.org/linux-iommu/c3230ace-c878-39db-1663-2b752ff5384e@linux.intel.com/T/#m43fc46286611aa56a5c0eeaad99d539e5519f3f6
> 
>    - Patch "0012-iommu-Add-iommu_at-de-tach_device_shared-for-mult.patch"
>      and "0018-drm-tegra-Use-the-iommu-dma_owner-mechanism.patch" have
>      been tested by Dmitry Osipenko <digetx@gmail.com>.
> 
> v4:
>    - Remove unnecessary tegra->domain chech in the tegra patch. (Jason)
>    - Remove DMA_OWNER_NONE. (Joerg)
>    - Change refcount to unsigned int. (Christoph)
>    - Move mutex lock into group set_dma_owner functions. (Christoph)
>    - Add kernel doc for iommu_attach/detach_domain_shared(). (Christoph)
>    - Move dma auto-claim into driver core. (Jason/Christoph)

Thank you very much for the review comments. A new version has been
posted.

https://lore.kernel.org/linux-iommu/20220104015644.2294354-1-baolu.lu@linux.intel.com/

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
