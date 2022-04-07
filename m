Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D1CC433F5
	for <iommu@archiver.kernel.org>; Thu,  7 Apr 2022 17:03:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BBB4041840;
	Thu,  7 Apr 2022 17:03:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BO3xGD1jCzzt; Thu,  7 Apr 2022 17:03:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2B6BE40509;
	Thu,  7 Apr 2022 17:03:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05E2BC001D;
	Thu,  7 Apr 2022 17:03:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81FDEC0012
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 17:03:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 53F0141840
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 17:03:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zmp046kyxjsN for <iommu@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 17:03:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id DA89640509
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 17:03:45 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1156512FC;
 Thu,  7 Apr 2022 10:03:45 -0700 (PDT)
Received: from [10.57.41.19] (unknown [10.57.41.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13CC83F5A1;
 Thu,  7 Apr 2022 10:03:42 -0700 (PDT)
Message-ID: <f5acf507-b4ef-b393-159c-05ca04feb43d@arm.com>
Date: Thu, 7 Apr 2022 18:03:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 0/4] Make the iommu driver no-snoop block feature
 consistent
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, Cornelia Huck <cohuck@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org,
 Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>
References: <0-v2-f090ae795824+6ad-intel_no_snoop_jgg@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <0-v2-f090ae795824+6ad-intel_no_snoop_jgg@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Christoph Hellwig <hch@lst.de>
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

On 2022-04-07 16:23, Jason Gunthorpe wrote:
> PCIe defines a 'no-snoop' bit in each the TLP which is usually implemented
> by a platform as bypassing elements in the DMA coherent CPU cache
> hierarchy. A driver can command a device to set this bit on some of its
> transactions as a micro-optimization.
> 
> However, the driver is now responsible to synchronize the CPU cache with
> the DMA that bypassed it. On x86 this may be done through the wbinvd
> instruction, and the i915 GPU driver is the only Linux DMA driver that
> calls it.
> 
> The problem comes that KVM on x86 will normally disable the wbinvd
> instruction in the guest and render it a NOP. As the driver running in the
> guest is not aware the wbinvd doesn't work it may still cause the device
> to set the no-snoop bit and the platform will bypass the CPU cache.
> Without a working wbinvd there is no way to re-synchronize the CPU cache
> and the driver in the VM has data corruption.
> 
> Thus, we see a general direction on x86 that the IOMMU HW is able to block
> the no-snoop bit in the TLP. This NOP's the optimization and allows KVM to
> to NOP the wbinvd without causing any data corruption.
> 
> This control for Intel IOMMU was exposed by using IOMMU_CACHE and
> IOMMU_CAP_CACHE_COHERENCY, however these two values now have multiple
> meanings and usages beyond blocking no-snoop and the whole thing has
> become confused. AMD IOMMU has the same feature and same IOPTE bits
> however it unconditionally blocks no-snoop.
> 
> Change it so that:
>   - IOMMU_CACHE is only about the DMA coherence of normal DMAs from a
>     device. It is used by the DMA API/VFIO/etc when the user of the
>     iommu_domain will not be doing manual cache coherency operations.
> 
>   - IOMMU_CAP_CACHE_COHERENCY indicates if IOMMU_CACHE can be used with the
>     device.
> 
>   - The new optional domain op enforce_cache_coherency() will cause the
>     entire domain to block no-snoop requests - ie there is no way for any
>     device attached to the domain to opt out of the IOMMU_CACHE behavior.
>     This is permanent on the domain and must apply to any future devices
>     attached to it.
> 
> Ideally an iommu driver should implement enforce_cache_coherency() so that
> by DMA API domains allow the no-snoop optimization. This leaves it
> available to kernel drivers like i915. VFIO will call
> enforce_cache_coherency() before establishing any mappings and the domain
> should then permanently block no-snoop.
> 
> If enforce_cache_coherency() fails VFIO will communicate back through to
> KVM into the arch code via kvm_arch_register_noncoherent_dma()
> (only implemented by x86) which triggers a working wbinvd to be made
> available to the VM.
> 
> While other iommu drivers are certainly welcome to implement
> enforce_cache_coherency(), it is not clear there is any benefit in doing
> so right now.
> 
> This is on github: https://github.com/jgunthorpe/linux/commits/intel_no_snoop
> 
> v2:
>   - Abandon removing IOMMU_CAP_CACHE_COHERENCY - instead make it the cap
>     flag that indicates IOMMU_CACHE is supported
>   - Put the VFIO tests for IOMMU_CACHE at VFIO device registration
>   - In the Intel driver remove the domain->iommu_snooping value, this is
>     global not per-domain

At a glance, this all looks about the right shape to me now, thanks!

Ideally I'd hope patch #4 could go straight to device_iommu_capable() 
from my Thunderbolt series, but we can figure that out in a couple of 
weeks once Joerg starts queueing 5.19 material. I've got another VFIO 
patch waiting for the DMA ownership series to land anyway, so it's 
hardly the end of the world if I have to come back to follow up on this 
one too.

For the series,

Acked-by: Robin Murphy <robin.murphy@arm.com>

> v1: https://lore.kernel.org/r/0-v1-ef02c60ddb76+12ca2-intel_no_snoop_jgg@nvidia.com
> 
> Jason Gunthorpe (4):
>    iommu: Introduce the domain op enforce_cache_coherency()
>    vfio: Move the Intel no-snoop control off of IOMMU_CACHE
>    iommu: Redefine IOMMU_CAP_CACHE_COHERENCY as the cap flag for
>      IOMMU_CACHE
>    vfio: Require that devices support DMA cache coherence
> 
>   drivers/iommu/amd/iommu.c       |  7 +++++++
>   drivers/iommu/intel/iommu.c     | 17 +++++++++++++----
>   drivers/vfio/vfio.c             |  7 +++++++
>   drivers/vfio/vfio_iommu_type1.c | 30 +++++++++++++++++++-----------
>   include/linux/intel-iommu.h     |  2 +-
>   include/linux/iommu.h           |  7 +++++--
>   6 files changed, 52 insertions(+), 18 deletions(-)
> 
> 
> base-commit: 3123109284176b1532874591f7c81f3837bbdc17
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
