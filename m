Return-Path: <SRS0=hcXW=7Z=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7132C433DF
	for <iommu@archiver.kernel.org>; Fri, 12 Jun 2020 14:30:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EBDA2081A
	for <iommu@archiver.kernel.org>; Fri, 12 Jun 2020 14:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EBDA2081A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 42477204C4;
	Fri, 12 Jun 2020 14:30:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SRTT4Bt5Y0Oc; Fri, 12 Jun 2020 14:30:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1C443203D0;
	Fri, 12 Jun 2020 14:30:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0666C0881;
	Fri, 12 Jun 2020 14:30:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 900A7C016F
 for <iommu@lists.linux-foundation.org>; Fri, 12 Jun 2020 14:30:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7DB6C897C0
 for <iommu@lists.linux-foundation.org>; Fri, 12 Jun 2020 14:30:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7mEBrfLifAtQ for <iommu@lists.linux-foundation.org>;
 Fri, 12 Jun 2020 14:30:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7202E897B0
 for <iommu@lists.linux-foundation.org>; Fri, 12 Jun 2020 14:30:19 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE90931B;
 Fri, 12 Jun 2020 07:30:18 -0700 (PDT)
Received: from red-moon.cambridge.arm.com (unknown [10.57.14.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4A753F6CF;
 Fri, 12 Jun 2020 07:30:14 -0700 (PDT)
Date: Fri, 12 Jun 2020 15:30:06 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: John Garry <john.garry@huawei.com>
Subject: Re: arm64 iommu groups issue
Message-ID: <20200612143006.GA4905@red-moon.cambridge.arm.com>
References: <9625faf4-48ef-2dd3-d82f-931d9cf26976@huawei.com>
 <4768c541-ebf4-61d5-0c5e-77dee83f8f94@arm.com>
 <a18b7f26-9713-a5c7-507e-ed70e40bc007@huawei.com>
 <ddc7eaff-c3f9-4304-9b4e-75eff2c66cd5@huawei.com>
 <be464e2a-03d5-0b2e-24ee-96d0d14fd739@arm.com>
 <35fc8d13-b1c1-6a9e-4242-284da7f00764@huawei.com>
 <68643b18-c920-f997-a6d4-a5d9177c0f4e@arm.com>
 <828ec7b3-27af-f0b9-b4a6-0886b0c24b5a@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <828ec7b3-27af-f0b9-b4a6-0886b0c24b5a@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: robh@kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Saravana Kannan <saravanak@google.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Linuxarm <linuxarm@huawei.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>,
 "Guohanjun \(Hanjun Guo\)" <guohanjun@huawei.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

On Mon, Feb 17, 2020 at 12:08:48PM +0000, John Garry wrote:
> > > 
> > > Right, and even worse is that it relies on the port driver even
> > > existing at all.
> > > 
> > > All this iommu group assignment should be taken outside device
> > > driver probe paths.
> > > 
> > > However we could still consider device links for sync'ing the SMMU
> > > and each device probing.
> > 
> > Yes, we should get that for DT now thanks to the of_devlink stuff, but
> > cooking up some equivalent for IORT might be worthwhile.
> 
> It doesn't solve this problem, but at least we could remove the iommu_ops
> check in iort_iommu_xlate().
> 
> We would need to carve out a path from pci_device_add() or even device_add()
> to solve all cases.
> 
> > 
> > > > Another thought that crosses my mind is that when pci_device_group()
> > > > walks up to the point of ACS isolation and doesn't find an existing
> > > > group, it can still infer that everything it walked past *should* be put
> > > > in the same group it's then eventually going to return. Unfortunately I
> > > > can't see an obvious way for it to act on that knowledge, though, since
> > > > recursive iommu_probe_device() is unlikely to end well.
> > > 
> 
> [...]
> 
> > > And this looks to be the reason for which current
> > > iommu_bus_init()->bus_for_each_device(..., add_iommu_group) fails
> > > also.
> > 
> > Of course, just adding a 'correct' add_device replay without the
> > of_xlate process doesn't help at all. No wonder this looked suspiciously
> > simpler than where the first idea left off...
> > 
> > (on reflection, the core of this idea seems to be recycling the existing
> > iommu_bus_init walk rather than building up a separate "waiting list",
> > while forgetting that that wasn't the difficult part of the original
> > idea anyway)
> 
> We could still use a bus walk to add the group per iommu, but we would need
> an additional check to ensure the device is associated with the IOMMU.
> 
> > 
> > > On this current code mentioned, the principle of this seems wrong to
> > > me - we call bus_for_each_device(..., add_iommu_group) for the first
> > > SMMU in the system which probes, but we attempt to add_iommu_group()
> > > for all devices on the bus, even though the SMMU for that device may
> > > yet to have probed.
> > 
> > Yes, iommu_bus_init() is one of the places still holding a
> > deeply-ingrained assumption that the ops go live for all IOMMU instances
> > at once, which is what warranted the further replay in
> > of_iommu_configure() originally. Moving that out of
> > of_platform_device_create() to support probe deferral is where the
> > trouble really started.
> 
> I'm not too familiar with the history here, but could this be reverted now
> with the introduction of of_devlink stuff?

Hi John,

have we managed to reach a consensus on this thread on how to solve
the issue ? Asking because this thread seems stalled - I am keen on
getting it fixed.

Thanks,
Lorenzo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
