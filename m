Return-Path: <SRS0=ZMNw=SJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E99EC10F0E
	for <iommu@archiver.kernel.org>; Sun,  7 Apr 2019 23:31:37 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCD1F20879
	for <iommu@archiver.kernel.org>; Sun,  7 Apr 2019 23:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCD1F20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6CD98A5E;
	Sun,  7 Apr 2019 23:31:36 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BBF379EE
	for <iommu@lists.linux-foundation.org>;
	Sun,  7 Apr 2019 23:31:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4E6B063D
	for <iommu@lists.linux-foundation.org>;
	Sun,  7 Apr 2019 23:31:34 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8B859307D867;
	Sun,  7 Apr 2019 23:31:33 +0000 (UTC)
Received: from x1.home (ovpn-116-153.phx2.redhat.com [10.3.116.153])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E12355C5DF;
	Sun,  7 Apr 2019 23:31:32 +0000 (UTC)
Date: Sun, 7 Apr 2019 17:31:32 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Subject: Re: kernel BUG at drivers/iommu/intel-iommu.c:608
Message-ID: <20190407173132.24032810@x1.home>
In-Reply-To: <8d876549-21da-e027-0157-8737b10e26f8@acm.org>
References: <a523ea10-3dab-fa2c-1ecf-5cf32077565f@acm.org>
	<20190407150650.060cc508@x1.home>
	<8d876549-21da-e027-0157-8737b10e26f8@acm.org>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Sun, 07 Apr 2019 23:31:33 +0000 (UTC)
Cc: iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
	Jiang Liu <jiang.liu@linux.intel.com>, James Smart <jsmart2021@gmail.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190407233132.8sfXGY_HusFVoqZV0qAudAKdtGel8MkRVHSJqDHata0@z>

On Sun, 7 Apr 2019 16:02:31 -0700
Bart Van Assche <bvanassche@acm.org> wrote:

> On 4/7/19 2:06 PM, Alex Williamson wrote:
> > On Sun, 7 Apr 2019 12:10:38 -0700
> > Bart Van Assche <bvanassche@acm.org> wrote:  
> >> If I tell qemu to use PCI pass-through for a PCI adapter and next load the
> >> lpfc driver for an lpfc adapter that has not been passed through to any VM
> >> a kernel bug is hit. Do you perhaps know whether it should be possible to
> >> a load kernel driver in this scenario? If so, do you know what should change
> >> to avoid that this kernel bug is hit? Should the iommu code be modified or
> >> should the lpfc code be modified? I'm asking you because I think that you
> >> introduced the BUG() statement that was hit. See also commit ab8dfe251571
> >> ("iommu/vt-d: Introduce helper functions to improve code readability"; v3.17).  
> > 
> > Do both of these lpfc devices belong to the same IOMMU group?
> > (/sys/kernel/iommu_groups/)  Thanks,  
> 
> Hi Alex,
> 
> Apparently the two Emulex (lpfc) and the two QLogic ports are in the same IOMMU group:
> 
> # lspci | grep -E 'QLogic|Emulex'
> 01:00.0 Fibre Channel: Emulex Corporation Lancer Gen6: LPe32000 Fibre Channel Host Adapter (rev 01)
> 01:00.1 Fibre Channel: Emulex Corporation Lancer Gen6: LPe32000 Fibre Channel Host Adapter (rev 01)
> 02:00.0 Fibre Channel: QLogic Corp. ISP2532-based 8Gb Fibre Channel to PCI Express HBA (rev 02)
> 02:00.1 Fibre Channel: QLogic Corp. ISP2532-based 8Gb Fibre Channel to PCI Express HBA (rev 02)
> 
> # ls -d /sys/kernel/iommu_groups/*/devices/0000:0[12]:00.*
> /sys/kernel/iommu_groups/1/devices/0000:01:00.0
> /sys/kernel/iommu_groups/1/devices/0000:01:00.1
> /sys/kernel/iommu_groups/1/devices/0000:02:00.0
> /sys/kernel/iommu_groups/1/devices/0000:02:00.1

It's not possible to do what you want with this configuration.  An IOMMU
group represents the smallest set of devices that are isolated from
other sets of devices and is also therefore the minimum granularity we
can assign devices to userspace (ex. QEMU).  The kernel reacts to
breaking the isolation of the group with a BUG_ON.  If you managed not
to hit the BUG_ON here, you'd hit the BUG_ON in vfio code when the loss
of isolation is detected there. IOMMU groups are formed at the highest
point in the topology which guarantees isolation.  This can be
indicated either via native PCIe ACS support or ACS-equivalent quirks
in the code.  If the root port provides neither of these, then all
devices downstream are grouped together as well as all peer root ports
in the same PCI slot and all devices downstream of those.  If a
multifunction endpoint does not provide ACS or equivalent quirks, the
functions will be grouped together. Not all endpoint devices or systems
are designed for minimum possible granularity.  You can learn more
here[1].  Thanks,

Alex

[1] http://vfio.blogspot.com/2014/08/iommu-groups-inside-and-out.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
