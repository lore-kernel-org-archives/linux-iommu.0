Return-Path: <SRS0=6I1K=SK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00786C10F13
	for <iommu@archiver.kernel.org>; Mon,  8 Apr 2019 17:10:11 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA73020880
	for <iommu@archiver.kernel.org>; Mon,  8 Apr 2019 17:10:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA73020880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 99FE6C6D;
	Mon,  8 Apr 2019 17:10:10 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 50F2A9EE
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Apr 2019 17:10:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id B83E467F
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Apr 2019 17:10:08 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51DBC15AB;
	Mon,  8 Apr 2019 10:10:08 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FE7C3F718;
	Mon,  8 Apr 2019 10:10:07 -0700 (PDT)
Subject: Re: kernel BUG at drivers/iommu/intel-iommu.c:608
To: Alex Williamson <alex.williamson@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>
References: <a523ea10-3dab-fa2c-1ecf-5cf32077565f@acm.org>
	<20190407150650.060cc508@x1.home>
	<8d876549-21da-e027-0157-8737b10e26f8@acm.org>
	<20190407173132.24032810@x1.home> <1554736414.118779.265.camel@acm.org>
	<20190408092345.01751472@x1.home>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <c5511683-9739-9c74-418b-cf2aed6b294a@arm.com>
Date: Mon, 8 Apr 2019 18:10:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408092345.01751472@x1.home>
Content-Language: en-GB
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190408171005.TYdd-lEMj3SE_OTwX83ZTryQKjYJnWZ-UNYsHClC87g@z>

On 08/04/2019 16:23, Alex Williamson wrote:
> On Mon, 08 Apr 2019 08:13:34 -0700
> Bart Van Assche <bvanassche@acm.org> wrote:
> 
>> On Sun, 2019-04-07 at 17:31 -0600, Alex Williamson wrote:
>>> It's not possible to do what you want with this configuration.  An IOMMU
>>> group represents the smallest set of devices that are isolated from
>>> other sets of devices and is also therefore the minimum granularity we
>>> can assign devices to userspace (ex. QEMU).  The kernel reacts to
>>> breaking the isolation of the group with a BUG_ON.  If you managed not
>>> to hit the BUG_ON here, you'd hit the BUG_ON in vfio code when the loss
>>> of isolation is detected there. IOMMU groups are formed at the highest
>>> point in the topology which guarantees isolation.  This can be
>>> indicated either via native PCIe ACS support or ACS-equivalent quirks
>>> in the code.  If the root port provides neither of these, then all
>>> devices downstream are grouped together as well as all peer root ports
>>> in the same PCI slot and all devices downstream of those.  If a
>>> multifunction endpoint does not provide ACS or equivalent quirks, the
>>> functions will be grouped together. Not all endpoint devices or systems
>>> are designed for minimum possible granularity.  You can learn more
>>> here[1].  Thanks,
>>>
>>> Alex
>>>
>>> [1] http://vfio.blogspot.com/2014/08/iommu-groups-inside-and-out.html
>>
>> Hi Alex,
>>
>> Thank you for the detailed reply. The background information you provided
>> makes it very clear why the devices I mentioned in my e-mail ended up in the
>> same IOMMU group.
>>
>> But it seems that I was not clear enough in my original e-mail. My concern is
>> that a user space action (modprobe) should never trigger a kernel BUG(). Is
>> there any way to make sure that the sequence of actions I performed causes
>> modprobe to fail with an error code instead of triggering a kernel BUG()?
> 
> Loading modules is privileged:
> 
> $ modprobe vfio-pci
> modprobe: ERROR: could not insert 'vfio_pci': Operation not permitted
> 
> Granting a device to a user for device assignment purposes is also a
> privileged operation.  Can you describe a scenario where this is
> reachable without elevated privileges?  The driver core maintainer has
> indicated previously that manipulation of driver binding is effectively
> at your own risk.  It's entirely possible to bind devices to the wrong
> driver creating all sorts of bad behavior.  In this case, it appears
> that the system has been improperly configured if devices from a user
> owned group can accidentally be bound to host drivers.  Thanks,

The fundamental problem seems to be that VFIO is checking the viability 
of a group a bit too late, or not being strict enough to begin with. 
I've just reproduced much the equivalent thing on an arm64 system where 
I have a single group containing 2 real devices (plus a bunch of bridges):

   echo 0000:03:00.0 > /sys/bus/pci/devices/0000:03:00.0/driver/unbind
   echo 0000:08:00.0 > /sys/bus/pci/devices/0000:08:00.0/driver/unbind

   echo $VID $DID > /sys/bus/pci/drivers/vfio-pci/new_id #IDs for 08:00.0

   lkvm run Image --vfio-pci 08:00.0 ...
   # guest runs...

Then back on the host,

   echo 0000:03:00.0 > /sys/bus/pci/drivers_probe

and bang:

   [ 1091.768165] ------------[ cut here ]------------
   [ 1091.772732] kernel BUG at drivers/vfio/vfio.c:759!
   [ 1091.777472] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
   [ 1091.782898] Modules linked in:
   [ 1091.785920] CPU: 1 PID: 1090 Comm: sh Not tainted 5.1.0-rc1+ #77
   [ 1091.791862] Hardware name: ARM LTD ARM Juno Development 
Platform/ARM Juno Development Platform, BIOS EDK II Feb 25 2019
   [ 1091.802535] pstate: 60000005 (nZCv daif -PAN -UAO)
   [ 1091.807279] pc : vfio_iommu_group_notifier+0x1c8/0x360
   [ 1091.812361] lr : vfio_iommu_group_notifier+0x1c4/0x360
   ...

Yes, they're all privileged operations so you can say "well don't do 
that then", but it's still a rather unexpected behaviour. This is 
actually slightly worse than Bart's case, since arm-smmu doesn't have an 
equivalent to that BUG_ON() check in __intel_map_page(), so the host 
driver for 03:00.0 may have successfully started DMA during probing and 
potentially corrupted guest memory by that point. AFAICS, ideally in 
this situation vfio_iommu_group_notifier() could catch 
IOMMU_GROUP_NOTIFY_BIND_DRIVER and prevent any new drivers from binding 
while the rest of the group is assigned, but at a glance there seems to 
be some core plumbing missing to allow that to happen :/

Alternatively, maybe we could just tighten up and stop treating unbound 
devices as viable - that certainly seems easier to implement, but 
whether it impacts real use-cases I don't know.

I guess this comes down to that "TBD - interface for disabling driver 
probing/locking a device." in Documentation/vfio.txt.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
