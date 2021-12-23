Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9701C433F5
	for <iommu@archiver.kernel.org>; Thu, 23 Dec 2021 02:08:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4AD17410B0;
	Thu, 23 Dec 2021 02:08:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QA8Z9OUP4d93; Thu, 23 Dec 2021 02:08:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0DA4D4092B;
	Thu, 23 Dec 2021 02:08:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6F84C001E;
	Thu, 23 Dec 2021 02:08:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75A1FC0012
 for <iommu@lists.linux-foundation.org>; Thu, 23 Dec 2021 02:08:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 571B5405C5
 for <iommu@lists.linux-foundation.org>; Thu, 23 Dec 2021 02:08:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GWoqgzUvt1dR for <iommu@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 02:08:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 456B4404A9
 for <iommu@lists.linux-foundation.org>; Thu, 23 Dec 2021 02:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1640225323; x=1671761323;
 h=cc:subject:to:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=U3C5yVoX5E5uvujjF66oQQmBBqdF/yUhDK/aFppaBqg=;
 b=GiyC04BxzNNEiGTWunU/8Rw0AjJgwmeuVrQpDPBuwYC/pBWc639VMaqv
 9AEOBYZOSr8iE99c4W2fEgbgCt7nxLdf4BJLJZhekxfwG5wcfduDoUdij
 cPfk4ByCFtBzTGHNmI0eoCPt1vpu3Xz6k6SwGTgtlM3k3udRyVos1z6+r
 eAkuGQjTGa7iKbqj2LcRmznIAF2gE0WaeQ0T9qKoKehfr0EbLi20zoz0O
 wW/ReYrqjQQCdw7E+t8eOStE2C02BUIjuklyaU0B21tQIDd0sjPVxwXLL
 E8XDkTznsgh9CrLY2AxEcdcPiQpHWRl6fYIM+CEHoIsV2FFw7g/RPSRuj Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="240692027"
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; d="scan'208";a="240692027"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2021 18:08:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; d="scan'208";a="664445608"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 22 Dec 2021 18:08:35 -0800
Subject: Re: [PATCH v4 02/13] driver core: Set DMA ownership during driver
 bind/unbind
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20211217063708.1740334-1-baolu.lu@linux.intel.com>
 <20211217063708.1740334-3-baolu.lu@linux.intel.com>
 <YcMeZlN3798noycN@kroah.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <40d67b07-b56b-d626-f71b-54ef5c80275c@linux.intel.com>
Date: Thu, 23 Dec 2021 10:08:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YcMeZlN3798noycN@kroah.com>
Content-Language: en-US
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
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

Hi Greg,

On 12/22/21 8:47 PM, Greg Kroah-Hartman wrote:
> Which one will actually care about the iommu_device_set_dma_owner()
> call?  All of them?  None of them?  Some of them?
> 
> Again, why can't this just happen in the (very few) bus callbacks that
> care about this?  In following patches in this series, you turn off this
> for the pci_dma_configure users, so what is left?  3 odd bus types that
> are not used often.  How well did you test devices of those types with
> this patchset?
> 
> It's fine to have "suppress" fields when they are the minority, but here
> it's a_very_  tiny tiny number of actual devices in a system that will
> ever get the chance to have this check happen for them and trigger,
> right?

Thank you for your comments. Current VFIO implementation supports
devices on pci/platform/amba/fls-mc buses for user-space DMA. So only
those buses need to call iommu_device_set/release_dma_owner() in their
dma_configure/cleanup() callbacks.

The "suppress" field is only for a few device drivers (not devices), for
example,

- vfio-pci, a PCI device driver used to bind to a PCI device so that it
   could be assigned for user-space DMA.

Other similar drivers in drivers/vfio are vfio-fsl-mc, vfio-amba and
vfio-platform. These drivers will call
iommu_device_set/release_dma_owner(DMA_OWNER_USER) explicitly when the
device is assigned to user.

The logic is that on the affected buses (pci/platform/amba/fls-mc),

- for non-vfio drivers, bus dma_configure/cleanup() will automatically
   call iommu_device_set_dma_owner(KERNEL) for the device; [This is the
   majority cases.]

- for vfio drivers, the auto-call will be suppressed, and the vfio
   drivers are supposed to call iommu_device_set_dma_owner(USER) before
   device is assigned to the userspace. [This is the rare case.]

The KERNEL and USER conflict will be detected in
iommu_device_set_dma_owner() with a -EBUSY return value. In that case,
the driver binding or device assignment should be aborted.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
