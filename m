Return-Path: <SRS0=UGJ5=K3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960EDC47083
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 01:26:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2115D61287
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 01:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2115D61287
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE9E960A57;
	Tue,  1 Jun 2021 01:26:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hIkGkl8r3d0d; Tue,  1 Jun 2021 01:26:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id A5494608AB;
	Tue,  1 Jun 2021 01:26:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80AB2C000D;
	Tue,  1 Jun 2021 01:26:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D0FDC0001
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 01:26:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1E258608B5
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 01:26:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 22cwehtCaB60 for <iommu@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 01:26:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C05C5608AB
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 01:26:24 +0000 (UTC)
IronPort-SDR: 6Q/bVr3IvrWaUi9zloh/X7l8q2jkmwWVN6/P9LnO6X9Bm+iH0lOmsl07K29t1DG6xIKFWxqjwm
 p/GgIlBR+Yow==
X-IronPort-AV: E=McAfee;i="6200,9189,10001"; a="289066917"
X-IronPort-AV: E=Sophos;i="5.83,238,1616482800"; d="scan'208";a="289066917"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2021 18:26:23 -0700
IronPort-SDR: 3ISgzlIM9qswXjZQDHBeANiitu0fX8s7d+7JTlBEqDv2NaJfFaUxOX4F6EkXR8+6aF44ke+Lvp
 1iqskwpkwaAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,238,1616482800"; d="scan'208";a="632703400"
Received: from allen-box.sh.intel.com (HELO [10.239.159.105])
 ([10.239.159.105])
 by fmsmga006.fm.intel.com with ESMTP; 31 May 2021 18:26:19 -0700
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To: Liu Yi L <yi.l.liu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528233649.GB3816344@nvidia.com> <20210531193157.5494e6c6@yiliu-dev>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <576ab03b-3f2b-512f-7c29-f489ed9576f6@linux.intel.com>
Date: Tue, 1 Jun 2021 09:25:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210531193157.5494e6c6@yiliu-dev>
Content-Language: en-US
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Robin Murphy <robin.murphy@arm.com>,
 Jason Wang <jasowang@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 David Woodhouse <dwmw2@infradead.org>
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

On 5/31/21 7:31 PM, Liu Yi L wrote:
> On Fri, 28 May 2021 20:36:49 -0300, Jason Gunthorpe wrote:
> 
>> On Thu, May 27, 2021 at 07:58:12AM +0000, Tian, Kevin wrote:
>>
>>> 2.1. /dev/ioasid uAPI
>>> +++++++++++++++++

[---cut for short---]

>>> /*
>>>    * Allocate an IOASID.
>>>    *
>>>    * IOASID is the FD-local software handle representing an I/O address
>>>    * space. Each IOASID is associated with a single I/O page table. User
>>>    * must call this ioctl to get an IOASID for every I/O address space that is
>>>    * intended to be enabled in the IOMMU.
>>>    *
>>>    * A newly-created IOASID doesn't accept any command before it is
>>>    * attached to a device. Once attached, an empty I/O page table is
>>>    * bound with the IOMMU then the user could use either DMA mapping
>>>    * or pgtable binding commands to manage this I/O page table.
>> Can the IOASID can be populated before being attached?
> perhaps a MAP/UNMAP operation on a gpa_ioasid?
> 

But before attaching to any device, there's no connection between an
IOASID and the underlying IOMMU. How do you know the supported page
sizes and cache coherency?

The restriction of iommu_group is implicitly expressed as only after all
devices belonging to an iommu_group are attached, the operations of the
page table can be performed.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
