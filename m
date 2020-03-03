Return-Path: <SRS0=fiLh=4U=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CDCC3F2CD
	for <iommu@archiver.kernel.org>; Tue,  3 Mar 2020 06:47:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC14B20726
	for <iommu@archiver.kernel.org>; Tue,  3 Mar 2020 06:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC14B20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7652D81F85;
	Tue,  3 Mar 2020 06:47:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qkS+DZW2A4O1; Tue,  3 Mar 2020 06:47:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A48A481EBC;
	Tue,  3 Mar 2020 06:47:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97B44C1AE2;
	Tue,  3 Mar 2020 06:47:09 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45517C013E
 for <iommu@lists.linux-foundation.org>; Tue,  3 Mar 2020 06:47:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3291920026
 for <iommu@lists.linux-foundation.org>; Tue,  3 Mar 2020 06:47:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c9T-jwWCDs7m for <iommu@lists.linux-foundation.org>;
 Tue,  3 Mar 2020 06:47:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by silver.osuosl.org (Postfix) with ESMTPS id 1F72220008
 for <iommu@lists.linux-foundation.org>; Tue,  3 Mar 2020 06:47:07 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 02 Mar 2020 22:47:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,510,1574150400"; d="scan'208";a="233659825"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.73])
 ([10.254.215.73])
 by fmsmga008.fm.intel.com with ESMTP; 02 Mar 2020 22:47:03 -0800
Subject: Re: [PATCH V2 3/5] iommu: Add support to change default domain of an
 iommu_group
To: Joerg Roedel <joro@8bytes.org>,
 Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
References: <cover.1581619464.git.sai.praneeth.prakhya@intel.com>
 <5aa5ef20ff81f706aafa9a6af68cef98fe60ad0f.1581619464.git.sai.praneeth.prakhya@intel.com>
 <20200302150833.GA6540@8bytes.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <7fcadd2a-76cd-2114-bb5f-c916fd14e1cb@linux.intel.com>
Date: Tue, 3 Mar 2020 14:47:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200302150833.GA6540@8bytes.org>
Content-Language: en-US
Cc: Ashok Raj <ashok.raj@intel.com>, Will Deacon <will.deacon@arm.com>,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

Hi Joerg,

On 2020/3/2 23:08, Joerg Roedel wrote:
> Hello Sai, Baolu,
> 
> On Sun, Feb 16, 2020 at 01:57:26PM -0800, Sai Praneeth Prakhya wrote:
>> Hence it will be helpful if there is some way to change the default
>> domain of a B:D.F dynamically. Since, linux iommu subsystem prefers to
>> deal at iommu_group level instead of B:D.F level, it might be helpful
>> if there is some way to change the default domain of a *iommu_group*
>> dynamically. Hence, add such support.
> 
> The question is how this plays together with the per-device private
> domains in the Intel VT-d driver. I recently debugged an issue there and
> I think there are more. The overall code for this seems to be pretty
> fragile, so I had the idea to make the private default domains more
> general.
> 
> IOMMU default domains don't necessarily need to stick to the iommu-group
> granularity, because the default domain is used by in-kernel drivers
> only, and the kernel trusts itself.
> 
> So my idea was to make the private-domain concept of the VT-d driver
> more generic and move it to the iommu core code. With that we can
> configure real per-device default domain types and don't have the race
> condition with driver probing when changing the default domain of
> multiple devices. We have to limit the ability to change default domain
> types to devices with no PCI aliases, but that should not be a problem
> for the intended use-case.
> 
> What do you think?
>

Theoretically speaking, per-device default domain is impractical. PCI
aliased devices (PCI bridge and all devices beneath it, VMD devices and
various devices quirked with pci_add_dma_alias()) must use the same
domain. It's likely that we have to introduce something like a sub-group
with all PCI aliased devices staying in it. Current private-domain
implementation in the vt-d driver was introduced for compatible purpose
and I wanted to abandon it from the first day. :-)

On Intel platforms, there are only rare devices which require a specific
default domain: some graphic devices (identity), a specific model of
AZALIA (identity) and external devices connected through thunderbolt
(dma). They are not supposed to belong to a same group. Hence, if we
are able to configure per-group default domain type, we don't need to
keep private domain anymore.

Probably, we are able to configure per-group default domain type with
below two interfaces.

- (ops->)dev_def_domain_type: Return the required default domain type
   for a device. It returns
   - IOMMU_DOMAIN_DMA (device must use a DMA domain), unlikely
   - IOMMU_DOMAIN_IDENTITY (device must use an Identity domain), unlikely
   - 0 (both are okay), likely

- iommu_group_change_def_domain: Change the default domain of a group
   Works only when all devices have no driver bond.

[Sai's patch set has already included these two interfaces.]

In iommu_probe_device(),

dev_def_type = ops->dev_def_domain_type(dev)
if (dev_def_type && dev_def_type != group->default_domain->type) {
	ret = iommu_group_change_def_domain(...)
	if (ret)
		return -EINVAL;
}

This should work during boot since iommu_probe_device() always happens
before device driver binding. We need to further consider the hot-plug
cases.

- Hardware initiated device hotplug
We should always use DMA domain for devices connected through an
external port to avoid DMA attacking from malicious devices. And
such devices shouldn't share a group with internal (trusted) devices.
Hence, I can't see any problems here.

- Software initiated device hotplug
The default domain type won't change before and after device hotplug
so there's no problem as well.

This is what I have for the private domain in vt-d driver. Just for
discussion.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
