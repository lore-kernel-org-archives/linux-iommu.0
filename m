Return-Path: <SRS0=kThj=K4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50047C4708F
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 04:03:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF3D6613BF
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 04:03:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF3D6613BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A600840232;
	Wed,  2 Jun 2021 04:03:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jIVtJXb1IXJd; Wed,  2 Jun 2021 04:03:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 92D3E40149;
	Wed,  2 Jun 2021 04:03:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2488DC000E;
	Wed,  2 Jun 2021 04:03:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08C6FC0001
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 04:03:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D465A40149
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 04:03:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TyEw-4GbEZjs for <iommu@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 04:03:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 041E4401F0
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 04:03:16 +0000 (UTC)
IronPort-SDR: onO+eVZmjdNko2JP/MYpLIgf7nT9JrkjvAZt3TqZ+jwJmAbDC/z0EOW+RWK0TK/gY5S3niMPDK
 /kg5xseIBCZA==
X-IronPort-AV: E=McAfee;i="6200,9189,10002"; a="224979999"
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; d="scan'208";a="224979999"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2021 21:03:13 -0700
IronPort-SDR: V9eBiB+ZDFfyGl+fsz0VEAaNwG6svY2fMybzF6dlHd6Z7lfZQxaLPC0XaesqnjDvvIOCAY1gD5
 /jNmg8dQnM8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; d="scan'208";a="633093086"
Received: from allen-box.sh.intel.com (HELO [10.239.159.105])
 ([10.239.159.105])
 by fmsmga006.fm.intel.com with ESMTP; 01 Jun 2021 21:03:06 -0700
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To: Jason Gunthorpe <jgg@nvidia.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528233649.GB3816344@nvidia.com>
 <786295f7-b154-cf28-3f4c-434426e897d3@linux.intel.com>
 <20210601172652.GK1002214@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <99c765d2-5fd3-002c-7c7a-408a17433068@linux.intel.com>
Date: Wed, 2 Jun 2021 12:01:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210601172652.GK1002214@nvidia.com>
Content-Language: en-US
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Gibson <david@gibson.dropbear.id.au>, "Jiang,
 Dave" <dave.jiang@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>
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

On 6/2/21 1:26 AM, Jason Gunthorpe wrote:
> On Tue, Jun 01, 2021 at 07:09:21PM +0800, Lu Baolu wrote:
> 
>> This version only covers 1) and 4). Do you think we need to support 2),
>> 3) and beyond?
> 
> Yes aboslutely. The API should be flexable enough to specify the
> creation of all future page table formats we'd want to have and all HW
> specific details on those formats.

OK, stay in the same line.

>> If so, it seems that we need some in-kernel helpers and uAPIs to
>> support pre-installing a page table to IOASID.
> 
> Not sure what this means..

Sorry that I didn't make this clear.

Let me bring back the page table types in my eyes.

  1) IOMMU format page table (a.k.a. iommu_domain)
  2) user application CPU page table (SVA for example)
  3) KVM EPT (future option)
  4) VM guest managed page table (nesting mode)

Each type of page table should be able to be associated with its IOASID.
We have BIND protocol for 4); We explicitly allocate an iommu_domain for
1). But we don't have a clear definition for 2) 3) and others. I think
it's necessary to clearly define a time point and kAPI name between
IOASID_ALLOC and IOASID_ATTACH, so that other modules have the
opportunity to associate their page table with the allocated IOASID
before attaching the page table to the real IOMMU hardware.

I/O page fault handling is similar. The provider of the page table
should take the responsibility to handle the possible page faults.

Could this answer the question of "I'm still confused why drivers need
fault handlers at all?" in below thread?

https://lore.kernel.org/linux-iommu/PH0PR12MB54811863B392C644E5365446DC3E9@PH0PR12MB5481.namprd12.prod.outlook.com/T/#m15def9e8b236dfcf97e21c8e9f8a58da214e3691

> 
>>  From this point of view an IOASID is actually not just a variant of
>> iommu_domain, but an I/O page table representation in a broader
>> sense.
> 
> Yes, and things need to evolve in a staged way. The ioctl API should
> have room for this growth but you need to start out with some
> constrained enough to actually implement then figure out how to grow
> from there

Yes, agreed. I just think about it from the perspective of a design
document.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
