Return-Path: <SRS0=6I1K=SK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCE5C10F14
	for <iommu@archiver.kernel.org>; Mon,  8 Apr 2019 15:23:52 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7C2020883
	for <iommu@archiver.kernel.org>; Mon,  8 Apr 2019 15:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C2020883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5CED7CBF;
	Mon,  8 Apr 2019 15:23:52 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 53F50CAA
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Apr 2019 15:23:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C22B863D
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Apr 2019 15:23:49 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 73879307E076;
	Mon,  8 Apr 2019 15:23:48 +0000 (UTC)
Received: from x1.home (ovpn-116-122.phx2.redhat.com [10.3.116.122])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1059E1001E7B;
	Mon,  8 Apr 2019 15:23:48 +0000 (UTC)
Date: Mon, 8 Apr 2019 09:23:45 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Subject: Re: kernel BUG at drivers/iommu/intel-iommu.c:608
Message-ID: <20190408092345.01751472@x1.home>
In-Reply-To: <1554736414.118779.265.camel@acm.org>
References: <a523ea10-3dab-fa2c-1ecf-5cf32077565f@acm.org>
	<20190407150650.060cc508@x1.home>
	<8d876549-21da-e027-0157-8737b10e26f8@acm.org>
	<20190407173132.24032810@x1.home>
	<1554736414.118779.265.camel@acm.org>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Mon, 08 Apr 2019 15:23:49 +0000 (UTC)
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
Message-ID: <20190408152345.yyvta6T7zAAD3_zjDmrlobvwZDxdqe63MLRTbghmzE0@z>

On Mon, 08 Apr 2019 08:13:34 -0700
Bart Van Assche <bvanassche@acm.org> wrote:

> On Sun, 2019-04-07 at 17:31 -0600, Alex Williamson wrote:
> > It's not possible to do what you want with this configuration.  An IOMMU
> > group represents the smallest set of devices that are isolated from
> > other sets of devices and is also therefore the minimum granularity we
> > can assign devices to userspace (ex. QEMU).  The kernel reacts to
> > breaking the isolation of the group with a BUG_ON.  If you managed not
> > to hit the BUG_ON here, you'd hit the BUG_ON in vfio code when the loss
> > of isolation is detected there. IOMMU groups are formed at the highest
> > point in the topology which guarantees isolation.  This can be
> > indicated either via native PCIe ACS support or ACS-equivalent quirks
> > in the code.  If the root port provides neither of these, then all
> > devices downstream are grouped together as well as all peer root ports
> > in the same PCI slot and all devices downstream of those.  If a
> > multifunction endpoint does not provide ACS or equivalent quirks, the
> > functions will be grouped together. Not all endpoint devices or systems
> > are designed for minimum possible granularity.  You can learn more
> > here[1].  Thanks,
> > 
> > Alex
> > 
> > [1] http://vfio.blogspot.com/2014/08/iommu-groups-inside-and-out.html  
> 
> Hi Alex,
> 
> Thank you for the detailed reply. The background information you provided
> makes it very clear why the devices I mentioned in my e-mail ended up in the
> same IOMMU group.
> 
> But it seems that I was not clear enough in my original e-mail. My concern is
> that a user space action (modprobe) should never trigger a kernel BUG(). Is
> there any way to make sure that the sequence of actions I performed causes
> modprobe to fail with an error code instead of triggering a kernel BUG()?

Loading modules is privileged:

$ modprobe vfio-pci
modprobe: ERROR: could not insert 'vfio_pci': Operation not permitted

Granting a device to a user for device assignment purposes is also a
privileged operation.  Can you describe a scenario where this is
reachable without elevated privileges?  The driver core maintainer has
indicated previously that manipulation of driver binding is effectively
at your own risk.  It's entirely possible to bind devices to the wrong
driver creating all sorts of bad behavior.  In this case, it appears
that the system has been improperly configured if devices from a user
owned group can accidentally be bound to host drivers.  Thanks,

Alex
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
