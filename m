Return-Path: <SRS0=kzsj=LS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF17C49EA6
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 12:22:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1F96613EB
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 12:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F96613EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 645954052E;
	Thu, 24 Jun 2021 12:22:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sKLRRWYKyoE2; Thu, 24 Jun 2021 12:22:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1E8E640504;
	Thu, 24 Jun 2021 12:22:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD8D7C0010;
	Thu, 24 Jun 2021 12:22:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5A1EC000E
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 12:22:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B70A9402BF
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 12:22:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2dQ2LcZ5dTOl for <iommu@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 12:22:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AD5DF400C4
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 12:22:25 +0000 (UTC)
IronPort-SDR: MntVkbn9fkxEjWiQK5PkR0/jDzB/qQn/G9OyWNNMry++GkUBpD1ShaoThtIQiNDkTyv3Idlzzq
 3tNkQn0FGFWQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10024"; a="271304392"
X-IronPort-AV: E=Sophos;i="5.83,296,1616482800"; d="scan'208";a="271304392"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2021 05:22:24 -0700
IronPort-SDR: q7SXO0zUj+MLdVTAzPX5Ffcx7ypQVhI54W2wkx/ktyNNnEWHQjIqGctUmmQL2fRKVQbSq4Cdee
 JUv8iZfyRIhQ==
X-IronPort-AV: E=Sophos;i="5.83,296,1616482800"; d="scan'208";a="487737745"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.211.177])
 ([10.254.211.177])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2021 05:22:18 -0700
To: David Gibson <david@gibson.dropbear.id.au>,
 "Tian, Kevin" <kevin.tian@intel.com>
References: <20210614140711.GI1002214@nvidia.com>
 <20210614102814.43ada8df.alex.williamson@redhat.com>
 <MWHPR11MB1886239C82D6B66A732830B88C309@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210615101215.4ba67c86.alex.williamson@redhat.com>
 <MWHPR11MB188692A6182B1292FADB3BDB8C0F9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210616133937.59050e1a.alex.williamson@redhat.com>
 <MWHPR11MB18865DF9C50F295820D038798C0E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210617151452.08beadae.alex.williamson@redhat.com>
 <20210618001956.GA1987166@nvidia.com>
 <MWHPR11MB1886A17124605251DF394E888C0D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <YNQJY2Ji+KOBYWbt@yekko>
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: Plan for /dev/ioasid RFC v2
Message-ID: <8e55d3c2-82ac-9be6-5c15-181b459c7893@linux.intel.com>
Date: Thu, 24 Jun 2021 20:22:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNQJY2Ji+KOBYWbt@yekko>
Content-Language: en-US
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@nvidia.com>,
 "parav@mellanox.com" <parav@mellanox.com>,
 Alex Williamson <alex.williamson@redhat.com>, "Enrico Weigelt,
 metux IT consult" <lkml@metux.net>, Robin Murphy <robin.murphy@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, Shenming Lu <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>
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

On 2021/6/24 12:26, David Gibson wrote:
> On Fri, Jun 18, 2021 at 04:57:40PM +0000, Tian, Kevin wrote:
>>> From: Jason Gunthorpe <jgg@nvidia.com>
>>> Sent: Friday, June 18, 2021 8:20 AM
>>>
>>> On Thu, Jun 17, 2021 at 03:14:52PM -0600, Alex Williamson wrote:
>>>
>>>> I've referred to this as a limitation of type1, that we can't put
>>>> devices within the same group into different address spaces, such as
>>>> behind separate vRoot-Ports in a vIOMMU config, but really, who cares?
>>>> As isolation support improves we see fewer multi-device groups, this
>>>> scenario becomes the exception.  Buy better hardware to use the devices
>>>> independently.
>>>
>>> This is basically my thinking too, but my conclusion is that we should
>>> not continue to make groups central to the API.
>>>
>>> As I've explained to David this is actually causing functional
>>> problems and mess - and I don't see a clean way to keep groups central
>>> but still have the device in control of what is happening. We need
>>> this device <-> iommu connection to be direct to robustly model all
>>> the things that are in the RFC.
>>>
>>> To keep groups central someone needs to sketch out how to solve
>>> today's mdev SW page table and mdev PASID issues in a clean
>>> way. Device centric is my suggestion on how to make it clean, but I
>>> haven't heard an alternative??
>>>
>>> So, I view the purpose of this discussion to scope out what a
>>> device-centric world looks like and then if we can securely fit in the
>>> legacy non-isolated world on top of that clean future oriented
>>> API. Then decide if it is work worth doing or not.
>>>
>>> To my mind it looks like it is not so bad, granted not every detail is
>>> clear, and no code has be sketched, but I don't see a big scary
>>> blocker emerging. An extra ioctl or two, some special logic that
>>> activates for >1 device groups that looks a lot like VFIO's current
>>> logic..
>>>
>>> At some level I would be perfectly fine if we made the group FD part
>>> of the API for >1 device groups - except that complexifies every user
>>> space implementation to deal with that. It doesn't feel like a good
>>> trade off.
>>>
>>
>> Would it be an acceptable tradeoff by leaving >1 device groups
>> supported only via legacy VFIO (which is anyway kept for backward
>> compatibility), if we think such scenario is being deprecated over
>> time (thus little value to add new features on it)? Then all new
>> sub-systems including vdpa and new vfio only support singleton
>> device group via /dev/iommu...
> 
> The case that worries me here is if you *thought* you had 1 device
> groups, but then discover a hardware bug which means two things aren't
> as isolated as you thought they were.  What do you do then?
> 

Normally a hardware bug/quirk is identified during boot. For above case,
iommu core should put these two devices in a same iommu_group during
iommu_probe_device() phase. Any runtime hardware bug should be reported
to the OS through various methods so that the device could be quiet
and isolated. I don't think two devices could be in different groups
initially and then be moved to a single one.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
