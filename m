Return-Path: <SRS0=0CRx=UH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF03C2BCA1
	for <iommu@archiver.kernel.org>; Sat,  8 Jun 2019 01:48:47 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9C4620868
	for <iommu@archiver.kernel.org>; Sat,  8 Jun 2019 01:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C4620868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7A8531D56;
	Sat,  8 Jun 2019 01:48:46 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 115DF1BD8
	for <iommu@lists.linux-foundation.org>;
	Sat,  8 Jun 2019 01:47:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2D9DB6D6
	for <iommu@lists.linux-foundation.org>;
	Sat,  8 Jun 2019 01:47:50 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	07 Jun 2019 18:47:49 -0700
X-ExtLoop1: 1
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
	by orsmga008.jf.intel.com with ESMTP; 07 Jun 2019 18:47:49 -0700
Message-ID: <12f8c572074b7963705ba066fdde0f9fdf0bfc62.camel@intel.com>
Subject: Re: Device specific pass through in host systems - discuss user
	interface
From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To: Robin Murphy <robin.murphy@arm.com>, "iommu@lists.linux-foundation.org"
	<iommu@lists.linux-foundation.org>
Date: Fri, 07 Jun 2019 18:44:43 -0700
In-Reply-To: <3fa16135-b2bb-03b5-833a-bce8cc68f35f@arm.com>
References: <FFF73D592F13FD46B8700F0A279B802F48DA796E@ORSMSX114.amr.corp.intel.com>
	<3fa16135-b2bb-03b5-833a-bce8cc68f35f@arm.com>
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Cc: "Shankar, Ravi V" <ravi.v.shankar@intel.com>, "Tian,
	Kevin" <kevin.tian@intel.com>, "jroedel@suse.de" <jroedel@suse.de>, "Raj,
	Ashok" <ashok.raj@intel.com>, Will Deacon <will.deacon@arm.com>,
	"Pan, Jacob jun" <jacob.jun.pan@intel.com>,
	"hch@lst.de" <hch@lst.de>, "Lu, Baolu" <baolu.lu@intel.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org


> It's interesting to see this from a fresh angle which isn't clouded by 
> other SoC GPU details - thanks for the proposal! A couple more thoughts 
> jump out immediately...
> 

Thanks a lot! for jumping in and providing your valuable insights :)
Sorry! for taking time to reply on this. Did some quick testing on
unbinding/binding stuff.

> > Since, this feature could be generic across architectures, we thought it
> > would be better if the user interface is discussed in the community first.
> > We are envisioning this to be used both during boot time and runtime and
> > hence having a kernel command line argument along with a sysfs entry are
> > needed. So, please pour in your suggestions on how the user interface
> > should look like to make it architecture agnostic.
> > 
> > 
> > 1.      Have a kernel command line argument that takes a list of BDF's as
> > an input and puts them in pass through mode
> > 
> > a.      Accepting BDF as an input has a downside - BDF is dynamic and
> > could change if BIOS/OS enumerates a new device in next reboot
> > 
> > b.      Accepting <vendor_id:device_id> pair as an input has a downside -
> > What to do when there are multiple such devices and user would like to put
> > only some of them in PT mode
> > 
> 
> c. Not all devices are PCI in the first place.

Agreed, maybe we could limit this feature only to PCIe devices :(

> 
> > 2.      Have a sysfs file which takes 1 or 0 as an input to enable/disable
> > pass through mode. Some places that seem to be reasonable are
> > 
> > a.      /sys/class/iommu/dmar0/devices/
> > 
> > b.      /sys/kernel/iommu_groups/<id>/devices
> 
> Note that this this works out a bit tricky to actually use, since 
> changing the meaning of DMA addresses under the device's feet would be 
> disastrous.

Yes, that makes sense.

> It can only safely take effect by unbinding and rebinding 
> the driver and/or resetting the device (as a side note, this starts to 
> overlap with the IOMMU-drivers-as-modules concept, and whatever solution 
> to this we end up with may be helpful in making that work too). In most 
> cases that's probably viable, but not every driver supports unbinding, 
> and either way what if the device in question is the one hosting the 
> root filesystem... :/

We would like to propose something like this

1. User will first unbind the device driver by
echo "BDF" > /sys/bus/pci/drivers/<device_driver>/unbind

2. Set the Pass Through bit (this is to say the intent of the user that upon
the next rebind, please make this device as pass through)
echo 1 > /sys/class/iommu/dmar0/devices/<BDF>/pt

3. Re-bind the driver again
echo "BDF" > /sys/bus/pci/drivers/<device_driver>/bind

So, if the driver doesn't support unbind then the user cannot put the device
in pass through mode, in which case he has to use kernel command line
argument.

I did unbind on my device that has root file system and after that I was
unable to run any command (like cat or echo), which made sense. So, it's upto
the user to decide which devices can go through unbind and hence can be put in
pass through mode. Since this feature requires sudo privileges, I think, we
can assume admin does the right thing.

Please let me know what you think about this and also please do suggest if you
have any other better ways to deal with this.

Regards,
Sai

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
