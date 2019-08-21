Return-Path: <SRS0=Juc9=WR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76A6C3A59E
	for <iommu@archiver.kernel.org>; Wed, 21 Aug 2019 17:11:44 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3235216F4
	for <iommu@archiver.kernel.org>; Wed, 21 Aug 2019 17:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3235216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7FB87CDE;
	Wed, 21 Aug 2019 17:11:44 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 42AB3CC1
	for <iommu@lists.linux-foundation.org>;
	Wed, 21 Aug 2019 17:11:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C930B8B5
	for <iommu@lists.linux-foundation.org>;
	Wed, 21 Aug 2019 17:11:42 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
	by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	21 Aug 2019 10:11:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; d="scan'208";a="379015934"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
	by fmsmga006.fm.intel.com with ESMTP; 21 Aug 2019 10:11:42 -0700
Message-ID: <e7233cfe63c66aff4ca5d2e2c96b15f5fc7c05ae.camel@intel.com>
Subject: Re: [PATCH 4/4] iommu: Document usage of
	"/sys/kernel/iommu_groups/<grp_id>/type" file
From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To: John Garry <john.garry@huawei.com>, iommu@lists.linux-foundation.org
Date: Wed, 21 Aug 2019 10:08:03 -0700
In-Reply-To: <0891489c-5753-09c1-ab9d-ee2eb6e175a9@huawei.com>
References: <cover.1566353521.git.sai.praneeth.prakhya@intel.com>
	<414989e92e361ca8f3108956135c1bbfa4ce6788.1566353521.git.sai.praneeth.prakhya@intel.com>
	<0891489c-5753-09c1-ab9d-ee2eb6e175a9@huawei.com>
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Cc: Ashok Raj <ashok.raj@intel.com>, Will Deacon <will.deacon@arm.com>,
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

I don't know why people are being dropped randomly from CC'list. So, adding
them back

+ Sohil, Jacob, Joerg, Baolu

> > +What:		/sys/kernel/iommu_groups/<grp_id>/type
> > +Date:		August 2019
> > +KernelVersion:	v5.4
> > +Contact:	Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> > +Description:	/sys/kernel/iommu_groups/<grp_id>/type lets the user
> > know the
> > +		type of default domain in use by iommu for this group. A
> > +		privileged user could request kernel to change the group type
> > by
> > +		writing to this file. Presently, only three types are
> > supported
> 
> It's unclear whether the following is a list of all values the user 
> could both read and write (which it isn't).

Thanks for bringing this up.
True.. user would never see "auto" when he reads this file. I will make it
clear in V2.

> 
> > +		1. dma: All the DMA transactions from the devices in this
> > group
> > +			are translated by the iommu.
> 
> Why "dma", and not "DMA" (which is what we would read for DMA type)?

Makes sense.. Will change to "DMA" in V2.

> 
> > +		2. identity: All the DMA transactions from the devices in this
> > +			     group are *not* translated by the iommu.
> > +		3. auto: Kernel decides one among dma/identity
> 
> Isn't this the same as reset value, which we could read and remember?

Agreed. But, I think (assuming it's done manually and the user hasn't stored
default value in some script), remembering would be difficult if the system
had been running for weeks together and the user had already changed group
type multiple times.

> (And the kernel could reject when we attempt to change to a disallowed 
> type).

It already does and I see your point.
Since there are only two options, user might try to write "DMA" and if the
kernel disallows he would write "identity", simple enough.

I think of "auto" as an add-on feature. Since it's simple enough to implement
in kernel and reduces one extra step to user.

> 
> > +		Note:
> > +		-----
> > +		A group type could be modified only when *all* the devices in
> > +		the group are not binded to any device driver. So, the user
> > has
> > +		to first unbind the appropriate drivers and then change the
> > +		default domain type.
> > +		Caution:
> > +		--------
> > +		Unbinding a device driver will take away the drivers control
> > +		over the device and if done on devices that host root file
> > +		system could lead to catastrophic effects (the user might
> > +		need to reboot the machine to get it to normal state). So,
> > it's
> > +		expected that the user understands what he is doing.
> 
> I think that this goes without saying.

Haha.. Yes, it does. But, just wanted to be explicit so that new users are
warned well before :)

Regards,
Sai

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
