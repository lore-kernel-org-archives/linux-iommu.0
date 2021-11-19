Return-Path: <SRS0=KWJS=QG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C40C433F5
	for <iommu@archiver.kernel.org>; Fri, 19 Nov 2021 15:06:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEB6F61B1E
	for <iommu@archiver.kernel.org>; Fri, 19 Nov 2021 15:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BEB6F61B1E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 859BB826BF;
	Fri, 19 Nov 2021 15:06:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tFaaFd_o1zom; Fri, 19 Nov 2021 15:06:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 689E18268F;
	Fri, 19 Nov 2021 15:06:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 416A1C001E;
	Fri, 19 Nov 2021 15:06:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A0F7C0012
 for <iommu@lists.linux-foundation.org>; Fri, 19 Nov 2021 15:06:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 066E2826A4
 for <iommu@lists.linux-foundation.org>; Fri, 19 Nov 2021 15:06:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3N-K1x_Ylkxz for <iommu@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 15:06:23 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 380CC8268F
 for <iommu@lists.linux-foundation.org>; Fri, 19 Nov 2021 15:06:23 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 204915B9; Fri, 19 Nov 2021 16:06:19 +0100 (CET)
Date: Fri, 19 Nov 2021 16:06:12 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 01/11] iommu: Add device dma ownership set/release
 interfaces
Message-ID: <20211119150612.jhsvsbzisvux2lga@8bytes.org>
References: <20211115020552.2378167-1-baolu.lu@linux.intel.com>
 <20211115020552.2378167-2-baolu.lu@linux.intel.com>
 <YZJdJH4AS+vm0j06@infradead.org>
 <cc7ce6f4-b1ec-49ef-e245-ab6c330154c2@linux.intel.com>
 <20211116134603.GA2105516@nvidia.com>
 <BN9PR11MB5433639E43C37C5D2462BD718C9B9@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20211118133325.GO2105516@nvidia.com>
 <BN9PR11MB5433E5B63E575E2232DFBBE48C9C9@BN9PR11MB5433.namprd11.prod.outlook.com>
 <75100dfd-9cfe-9f3d-531d-b4d30de03e76@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <75100dfd-9cfe-9f3d-531d-b4d30de03e76@linux.intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "rafael@kernel.org" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Will Deacon <will@kernel.org>,
 Diana Craciun <diana.craciun@oss.nxp.com>
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

On Fri, Nov 19, 2021 at 07:14:10PM +0800, Lu Baolu wrote:
> The singleton group requirement for iommu_attach/detach_device() was
> added by below commit:
> 
> commit 426a273834eae65abcfc7132a21a85b3151e0bce
> Author: Joerg Roedel <jroedel@suse.de>
> Date:   Thu May 28 18:41:30 2015 +0200
> 
>     iommu: Limit iommu_attach/detach_device to devices with their own group
> 
>     This patch changes the behavior of the iommu_attach_device
>     and iommu_detach_device functions. With this change these
>     functions only work on devices that have their own group.
>     For all other devices the iommu_group_attach/detach
>     functions must be used.
> 
>     Signed-off-by: Joerg Roedel <jroedel@suse.de>
> 
> Joerg,can you please shed some light on the background of this
> requirement? Does above idea of transition from singleton group
> to group with single driver bound make sense to you?

This change came to be because the iommu_attach/detach_device()
interface doesn't fit well into a world with iommu-groups. Devices
within a group are by definition not isolated between each other, so
they must all be in the same address space (== iommu_domain). So it
doesn't make sense to allow attaching a single device within a group to
a different iommu_domain.

I know that in theory it is safe to allow devices within a group to be
in different domains because there iommu-groups catch multiple
non-isolation cases:

	1) Devices behind a non-ACS capable bridge or multiple functions
	   of a PCI device. Here it is safe to put the devices into
	   different iommu-domains as long as all affected devices are
	   controlled by the same owner.

	2) Devices which share a single request-id and can't be
	   differentiated by the IOMMU hardware. These always need to be
	   in the same iommu_domain.

To lift the single-domain-per-group requirement the iommu core code
needs to learn the difference between the two cases above.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
