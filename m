Return-Path: <SRS0=NWqd=2B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D684C43603
	for <iommu@archiver.kernel.org>; Wed, 11 Dec 2019 15:23:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63B7B22527
	for <iommu@archiver.kernel.org>; Wed, 11 Dec 2019 15:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cvk+8yin"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B7B22527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 34DB4855FF;
	Wed, 11 Dec 2019 15:23:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gK41l+Fr9oyq; Wed, 11 Dec 2019 15:23:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0E7158759A;
	Wed, 11 Dec 2019 15:23:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E86C2C1796;
	Wed, 11 Dec 2019 15:23:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB408C0881
 for <iommu@lists.linux-foundation.org>; Wed, 11 Dec 2019 15:23:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 84C18204A9
 for <iommu@lists.linux-foundation.org>; Wed, 11 Dec 2019 15:23:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SDRumN6Ce6cM for <iommu@lists.linux-foundation.org>;
 Wed, 11 Dec 2019 15:23:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by silver.osuosl.org (Postfix) with ESMTPS id 0422B20422
 for <iommu@lists.linux-foundation.org>; Wed, 11 Dec 2019 15:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576077791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w+9VqnBrsqHuMbodZQtPyqOPpoetgzdzJ0VJP1iKXj8=;
 b=Cvk+8yinpTP8uB5D6YqEr6+XyM9nX3xwZvIXONTVooSu40+hO+sJ0kza89iegax27ZneFq
 eQzCaJgpELccLC0ql2GKZtBJoeT2sKpi9RPJBG4YBEsQTKCF1MZZqyX/lzXhWxtc8BlJZz
 xw7oMt+22MuyXzg1OmNLNaDye8TmYQw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-6Igj3Tn6PPGpT8W0FY6oBg-1; Wed, 11 Dec 2019 10:23:09 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A23AA1800D45;
 Wed, 11 Dec 2019 15:23:08 +0000 (UTC)
Received: from x1.home (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9C41560567;
 Wed, 11 Dec 2019 15:23:05 +0000 (UTC)
Date: Wed, 11 Dec 2019 08:23:04 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: cprt <cprt@protonmail.com>
Subject: Re: [vfio-users] VFIO_MAP_DMA error EINVAL
Message-ID: <20191211082304.2d4fab45@x1.home>
In-Reply-To: <8H43uI497jxPZ2Q0aUNLBWF-djbGHynLoblrAzt2KVqgp1cBsnTmVyVGg_wZMRoS0zItTSs76Uja0hUokWtSpv2U_0vMPgHsrWcUPoF86kM=@protonmail.com>
References: <8H43uI497jxPZ2Q0aUNLBWF-djbGHynLoblrAzt2KVqgp1cBsnTmVyVGg_wZMRoS0zItTSs76Uja0hUokWtSpv2U_0vMPgHsrWcUPoF86kM=@protonmail.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 6Igj3Tn6PPGpT8W0FY6oBg-1
X-Mimecast-Spam-Score: 0
Cc: iommu@lists.linux-foundation.org, Eric Auger <eauger@redhat.com>,
 "vfio-users@redhat.com" <vfio-users@redhat.com>
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

On Wed, 11 Dec 2019 13:17:18 +0000
cprt <cprt@protonmail.com> wrote:

> Hello,
> I am using VFIO with QEMU trying to passthrough my audio device.
> 
> I successfully did this operation with my previous system, with a 7th generation intel and an older kernel.
> Now I am using a 10th generation intel and a newer kernel (5.4), and I can no longer make this work.
> 
> Looking at the QEMU code and errors, I can see that this call is failing:
> ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map)
> with error 22 (EINVAL).
> 
> This is the qemu log:
> qemu-system-x86_64: -device vfio-pci,host=00:1f.3: vfio_dma_map(0x7f86fdc7c480, 0xc0000, 0x7ff40000, 0x7f83f20c0000) = -22 (Invalid argument)
> 
> I have setup my system as follows:
> $ cat /proc/cmdline
> BOOT_IMAGE=/vmlinuz-linux root=UUID=5b780644-8382-11e9-a363-1b71c3bf36e9 rw loglevel=3 i915.enable_psr=0 intel_iommu=on iommu=pt i915.enable_gvt=1 kvm.ignore_msrs=1 vfio-pci.ids=8086:0284,8086:02c8,8086:02a3,8086:02a4
> 
> And this is the information of my PCI layout:
> $ lspci -s 00:1f
> 00:1f.0 ISA bridge: Intel Corporation Device 0284
> 00:1f.3 Audio device: Intel Corporation Device 02c8
> 00:1f.4 SMBus: Intel Corporation Device 02a3
> 00:1f.5 Serial bus controller [0c80]: Intel Corporation Comet Lake SPI (flash) Controller
> $ lspci -s 00:1f -n
> 00:1f.0 0601: 8086:0284
> 00:1f.3 0403: 8086:02c8
> 00:1f.4 0c05: 8086:02a3
> 00:1f.5 0c80: 8086:02a4
> 
> I tried (just as an experiment) to bypass the error check in the QEMU code, and the virtualized audio device works as expected for a while, then it stops.
> 
> Do you know what could generate the problem?

I think this is a result of the reserved region support added in v5.4
which intends to prevent userspace from mapping ranges it shouldn't.
On my system I have:

$ lspci -nns 00:1f.
00:1f.0 ISA bridge [0601]: Intel Corporation Sunrise Point LPC Controller/eSPI Controller [8086:9d4e] (rev 21)
00:1f.2 Memory controller [0580]: Intel Corporation Sunrise Point-LP PMC [8086:9d21] (rev 21)
00:1f.3 Audio device [0403]: Intel Corporation Sunrise Point-LP HD Audio [8086:9d71] (rev 21)
00:1f.4 SMBus [0c05]: Intel Corporation Sunrise Point-LP SMBus [8086:9d23] (rev 21)
00:1f.6 Ethernet controller [0200]: Intel Corporation Ethernet Connection (4) I219-LM [8086:15d7] (rev 21)

$ readlink -f /sys/bus/pci/devices/0000:00:1f.3/iommu_group
/sys/kernel/iommu_groups/9

$ find /sys/kernel/iommu_groups/9/devices -type l
/sys/kernel/iommu_groups/9/devices/0000:00:1f.2
/sys/kernel/iommu_groups/9/devices/0000:00:1f.0
/sys/kernel/iommu_groups/9/devices/0000:00:1f.3
/sys/kernel/iommu_groups/9/devices/0000:00:1f.6
/sys/kernel/iommu_groups/9/devices/0000:00:1f.4

$ cat /sys/kernel/iommu_groups/9/reserved_regions 
0x0000000000000000 0x0000000000ffffff direct
0x00000000fee00000 0x00000000feefffff msi

This direct range seems to be the trouble, your error indicates the
problem occurs when QEMU tries to map the GPA range 0xc0000-0x7ff40000,
which clearly overlaps 0x0-0xffffff.  It seems this reserved range
comes from this code:

drivers/iommu/intel-iommu.c:
#ifdef CONFIG_INTEL_IOMMU_FLOPPY_WA
        if (dev_is_pci(device)) {
                struct pci_dev *pdev = to_pci_dev(device);

                if ((pdev->class >> 8) == PCI_CLASS_BRIDGE_ISA) {
                        reg = iommu_alloc_resv_region(0, 1UL << 24, 0,
                                                      IOMMU_RESV_DIRECT);
                        if (reg)
                                list_add_tail(&reg->list, head);
                }
        }
#endif /* CONFIG_INTEL_IOMMU_FLOPPY_WA */

We can see above that we do have an ISA bridge in the same IOMMU group
as the audio device, so this is effectively fallout from the poor
grouping of these onboard devices.

This code was introduced in v5.3 via:

commit d850c2ee5fe2259968e3889624ad22ea15cb4a38
Author: Lu Baolu <baolu.lu@linux.intel.com>
Date:   Sat May 25 13:41:24 2019 +0800

    iommu/vt-d: Expose ISA direct mapping region via iommu_get_resv_regions
    
    To support mapping ISA region via iommu_group_create_direct_mappings,
    make sure its exposed by iommu_get_resv_regions.
    
    Signed-off-by: James Sewart <jamessewart@arista.com>
    Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
    Signed-off-by: Joerg Roedel <jroedel@suse.de>

The original Kconfig option this relates to was added long ago in:

commit 49a0429e53f29109cbf1eadd89497286ba81f1ae
Author: Keshavamurthy, Anil S <anil.s.keshavamurthy@intel.com>
Date:   Sun Oct 21 16:41:57 2007 -0700

    Intel IOMMU: Iommu floppy workaround
    
    This config option (DMAR_FLPY_WA) sets up 1:1 mapping for the floppy device so
    that the floppy device which does not use DMA api's will continue to work.
    
    Once the floppy driver starts using DMA api's this config option can be turn
    off or this patch can be yanked out of kernel at that time.
    
So AIUI the original floppy workaround created an identity map for the
range 0-16MB.  The reserved region attempts to reflect that reservation
to userspace, however I believe this is a software imposed reserved
region for the benefit of legacy kernel drivers and should therefore
use the relaxable version of the reserved region as introduced in
adfd37382090 ("iommu: Introduce IOMMU_RESV_DIRECT_RELAXABLE reserved
memory regions").  vfio is able to allow userspace to ignore relaxable
direct mapping reserved ranges.  I think the fix is then simply:

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 0c8d81f56a30..6eb0dd7489a1 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5737,7 +5737,7 @@ static void intel_iommu_get_resv_regions(struct device *device,
 
 		if ((pdev->class >> 8) == PCI_CLASS_BRIDGE_ISA) {
 			reg = iommu_alloc_resv_region(0, 1UL << 24, 0,
-						      IOMMU_RESV_DIRECT);
+						   IOMMU_RESV_DIRECT_RELAXABLE);
 			if (reg)
 				list_add_tail(&reg->list, head);
 		}

If you're able to build a kernel with this change, verification would
be appreciated.  I'll post a patch with stable fixes tags unless there
are objections to this solution.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
