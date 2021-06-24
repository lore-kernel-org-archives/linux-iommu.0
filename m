Return-Path: <SRS0=kzsj=LS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E7DC49EAB
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 13:42:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B138D61057
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 13:42:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B138D61057
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 80CBA605E3;
	Thu, 24 Jun 2021 13:42:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pVJaHnMJcpka; Thu, 24 Jun 2021 13:42:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 507DA605B7;
	Thu, 24 Jun 2021 13:42:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C029C001A;
	Thu, 24 Jun 2021 13:42:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17B69C000E
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 13:42:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ECF8282735
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 13:42:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FCSKTjDcvUSN for <iommu@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 13:42:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1DB8A8271A
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 13:42:47 +0000 (UTC)
IronPort-SDR: +5sI0ugQwAsRUyc3qmduXdaxJtP+bVRbGKASrwfl1sL1qcSk+WMWLVqbL8pvAkmdbsKxY/PAJq
 7qs6m0gBR+Zg==
X-IronPort-AV: E=McAfee;i="6200,9189,10024"; a="205641351"
X-IronPort-AV: E=Sophos;i="5.83,296,1616482800"; d="scan'208";a="205641351"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2021 06:42:44 -0700
IronPort-SDR: YVydjBX0YkVAhLh+YMD18XTmbFpHR21zKnhNrxE0oaEHiBi9/M3tMpJYUok7tlhXE14j+MwZ07
 jTfscbHMjaxA==
X-IronPort-AV: E=Sophos;i="5.83,296,1616482800"; d="scan'208";a="487758610"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.211.177])
 ([10.254.211.177])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2021 06:42:38 -0700
To: David Gibson <david@gibson.dropbear.id.au>
References: <MWHPR11MB188699D0B9C10EB51686C4138C389@MWHPR11MB1886.namprd11.prod.outlook.com>
 <YMCy48Xnt/aphfh3@8bytes.org> <20210609123919.GA1002214@nvidia.com>
 <14d884a8-13bc-b2ba-7020-94b219e3e2d9@linux.intel.com>
 <YMrcLcTL+cUKd1a5@yekko>
 <b9c48526-8b8f-ff9e-4ece-4a39f476e3b7@linux.intel.com>
 <YNQEClb1nptFBIRB@yekko>
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: Plan for /dev/ioasid RFC v2
Message-ID: <b77b9ffc-166e-3019-0328-59d20a437fd5@linux.intel.com>
Date: Thu, 24 Jun 2021 21:42:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNQEClb1nptFBIRB@yekko>
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

On 2021/6/24 12:03, David Gibson wrote:
> On Fri, Jun 18, 2021 at 01:21:47PM +0800, Lu Baolu wrote:
>> Hi David,
>>
>> On 6/17/21 1:22 PM, David Gibson wrote:
>>>> The iommu_group can guarantee the isolation among different physical
>>>> devices (represented by RIDs). But when it comes to sub-devices (ex. mdev or
>>>> vDPA devices represented by RID + SSID), we have to rely on the
>>>> device driver for isolation. The devices which are able to generate sub-
>>>> devices should either use their own on-device mechanisms or use the
>>>> platform features like Intel Scalable IOV to isolate the sub-devices.
>>> This seems like a misunderstanding of groups.  Groups are not tied to
>>> any PCI meaning.  Groups are the smallest unit of isolation, no matter
>>> what is providing that isolation.
>>>
>>> If mdevs are isolated from each other by clever software, even though
>>> they're on the same PCI device they are in different groups from each
>>> other*by definition*.  They are also in a different group from their
>>> parent device (however the mdevs only exist when mdev driver is
>>> active, which implies that the parent device's group is owned by the
>>> kernel).
>>
>> You are right. This is also my understanding of an "isolation group".
>>
>> But, as I understand it, iommu_group is only the isolation group visible
>> to IOMMU. When we talk about sub-devices (sw-mdev or mdev w/ pasid),
>> only the device and device driver knows the details of isolation, hence
>> iommu_group could not be extended to cover them. The device drivers
>> should define their own isolation groups.
> So, "iommu group" isn't a perfect name.  It came about because
> originally the main mechanism for isolation was the IOMMU, so it was
> typically the IOMMU's capabilities that determined if devices were
> isolated.  However it was always known that there could be other
> reasons for failure of isolation.  To simplify the model we decided
> that we'd put things into the same group if they were non-isolated for
> any reason.

Yes.

> 
> The kernel has no notion of "isolation group" as distinct from "iommu
> group".  What are called iommu groups in the kernel now*are*
> "isolation groups" and that was always the intention - it's just not a
> great name.

Fair enough.

> 
>> Otherwise, the device driver has to fake an iommu_group and add hacky
>> code to link the related IOMMU elements (iommu device, domain, group
>> etc.) together. Actually this is part of the problem that this proposal
>> tries to solve.
> Yeah, that's not ideal.
> 
>>>> Under above conditions, different sub-device from a same RID device
>>>> could be able to use different IOASID. This seems to means that we can't
>>>> support mixed mode where, for example, two RIDs share an iommu_group and
>>>> one (or both) of them have sub-devices.
>>> That doesn't necessarily follow.  mdevs which can be successfully
>>> isolated by their mdev driver are in a different group from their
>>> parent device, and therefore need not be affected by whether the
>>> parent device shares a group with some other physical device.  They
>>> *might*   be, but that's up to the mdev driver to determine based on
>>> what it can safely isolate.
>>>
>> If we understand it as multiple levels of isolation, can we classify the
>> devices into the following categories?
>>
>> 1) Legacy devices
>>     - devices without device-level isolation
>>     - multiple devices could sit in a single iommu_group
>>     - only a single I/O address space could be bound to IOMMU
> I'm not really clear on what that last statement means.

I mean a single iommu_domain should be used by all devices sharing a
single iommu_group.

> 
>> 2) Modern devices
>>     - devices capable of device-level isolation
> This will*typically*  be true of modern devices, but I don't think we
> can really make it a hard API distinction.  Legacy or buggy bridges
> can force modern devices into the same group as each other.  Modern
> devices are not immune from bugs which would force lack of isolation
> (e.g. forgotten debug registers on function 0 which affect other
> functions).
> 

Yes.

I am thinking whether it's feasible to change "bind/attach a device to
an IOASID" to "bind/attach an isolated unit to an IOASID". An isolated
unit could be

1) an iommu_ group including single or multiple devices;
2) a physical device which have a 1-device iommu group + device ID
    (PASID/subStreamID) which represents an isolated subdevice inside the
    physical one.
3) anything that we might have in the future.

A handler which represents the connection between device and iommu is
returned on any successful binding. This handler could be used to
GET_INFO and attach/detach after binding.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
