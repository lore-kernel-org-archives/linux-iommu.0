Return-Path: <SRS0=sMz+=LM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26273C48BDF
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 05:23:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC05A60C40
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 05:23:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC05A60C40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5EBE240146;
	Fri, 18 Jun 2021 05:23:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6f8ktrJSki0Q; Fri, 18 Jun 2021 05:23:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 475FE40003;
	Fri, 18 Jun 2021 05:23:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18655C000D;
	Fri, 18 Jun 2021 05:23:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2EE80C000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 05:23:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 143C5414C6
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 05:23:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BrHYPaoDC014 for <iommu@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 05:23:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B5CEA40409
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 05:23:22 +0000 (UTC)
IronPort-SDR: ou5nSDm7glyqDlTsgKxCifFfPJtXNESkWqir4wyWTO9es6mU8RUK0XsUvQ0XSQSAS9ifM/g4ff
 CxkT6zNT3FFg==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="203474710"
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; d="scan'208";a="203474710"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2021 22:23:21 -0700
IronPort-SDR: 4NGXo4KjN3kz+xI8wopVyXJfV6B9U5dgiyrFssRbBVsZnBC+5BLY00MKKQNFZOy06EeRcJ8FJr
 9RnOGfuyridQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; d="scan'208";a="555469079"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 17 Jun 2021 22:23:16 -0700
Subject: Re: Plan for /dev/ioasid RFC v2
To: David Gibson <david@gibson.dropbear.id.au>
References: <MWHPR11MB188699D0B9C10EB51686C4138C389@MWHPR11MB1886.namprd11.prod.outlook.com>
 <YMCy48Xnt/aphfh3@8bytes.org> <20210609123919.GA1002214@nvidia.com>
 <14d884a8-13bc-b2ba-7020-94b219e3e2d9@linux.intel.com>
 <YMrcLcTL+cUKd1a5@yekko>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <b9c48526-8b8f-ff9e-4ece-4a39f476e3b7@linux.intel.com>
Date: Fri, 18 Jun 2021 13:21:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YMrcLcTL+cUKd1a5@yekko>
Content-Language: en-US
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@nvidia.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "parav@mellanox.com" <parav@mellanox.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
 David Woodhouse <dwmw2@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Shenming Lu <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Robin Murphy <robin.murphy@arm.com>
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

Hi David,

On 6/17/21 1:22 PM, David Gibson wrote:
>> The iommu_group can guarantee the isolation among different physical
>> devices (represented by RIDs). But when it comes to sub-devices (ex. mdev or
>> vDPA devices represented by RID + SSID), we have to rely on the
>> device driver for isolation. The devices which are able to generate sub-
>> devices should either use their own on-device mechanisms or use the
>> platform features like Intel Scalable IOV to isolate the sub-devices.
> This seems like a misunderstanding of groups.  Groups are not tied to
> any PCI meaning.  Groups are the smallest unit of isolation, no matter
> what is providing that isolation.
> 
> If mdevs are isolated from each other by clever software, even though
> they're on the same PCI device they are in different groups from each
> other*by definition*.  They are also in a different group from their
> parent device (however the mdevs only exist when mdev driver is
> active, which implies that the parent device's group is owned by the
> kernel).


You are right. This is also my understanding of an "isolation group".

But, as I understand it, iommu_group is only the isolation group visible
to IOMMU. When we talk about sub-devices (sw-mdev or mdev w/ pasid),
only the device and device driver knows the details of isolation, hence
iommu_group could not be extended to cover them. The device drivers
should define their own isolation groups.

Otherwise, the device driver has to fake an iommu_group and add hacky
code to link the related IOMMU elements (iommu device, domain, group
etc.) together. Actually this is part of the problem that this proposal
tries to solve.

> 
>> Under above conditions, different sub-device from a same RID device
>> could be able to use different IOASID. This seems to means that we can't
>> support mixed mode where, for example, two RIDs share an iommu_group and
>> one (or both) of them have sub-devices.
> That doesn't necessarily follow.  mdevs which can be successfully
> isolated by their mdev driver are in a different group from their
> parent device, and therefore need not be affected by whether the
> parent device shares a group with some other physical device.  They
> *might*  be, but that's up to the mdev driver to determine based on
> what it can safely isolate.
> 

If we understand it as multiple levels of isolation, can we classify the
devices into the following categories?

1) Legacy devices
    - devices without device-level isolation
    - multiple devices could sit in a single iommu_group
    - only a single I/O address space could be bound to IOMMU

2) Modern devices
    - devices capable of device-level isolation
    - able to have subdevices
    - self-isolated, hence not share iommu_group with others
    - multiple I/O address spaces could be bound to IOMMU

For 1), all devices in an iommu_group should be bound to a single
IOASID; The isolation is guaranteed by an iommu_group.

For 2) a single device could be bound to multiple IOASIDs with each sub-
device corresponding to an IOASID. The isolation of each subdevice is
guaranteed by the device driver.

Best regards,
baolu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
