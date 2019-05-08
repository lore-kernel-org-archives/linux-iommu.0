Return-Path: <SRS0=jTem=TI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F5EC04AAB
	for <iommu@archiver.kernel.org>; Wed,  8 May 2019 18:31:44 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBC86216C4
	for <iommu@archiver.kernel.org>; Wed,  8 May 2019 18:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC86216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 907ABE34;
	Wed,  8 May 2019 18:31:44 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5C382DB9
	for <iommu@lists.linux-foundation.org>;
	Wed,  8 May 2019 18:31:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 47C7B87B
	for <iommu@lists.linux-foundation.org>;
	Wed,  8 May 2019 18:31:42 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD66F80D;
	Wed,  8 May 2019 11:31:41 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A02F23F575;
	Wed,  8 May 2019 11:31:38 -0700 (PDT)
Subject: Re: [PATCH v7 11/23] iommu/arm-smmu-v3: Maintain a SID->device
	structure
To: Robin Murphy <robin.murphy@arm.com>, Eric Auger <eric.auger@redhat.com>,
	eric.auger.pro@gmail.com, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu, joro@8bytes.org, alex.williamson@redhat.com, 
	jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com, will.deacon@arm.com
References: <20190408121911.24103-1-eric.auger@redhat.com>
	<20190408121911.24103-12-eric.auger@redhat.com>
	<e3b417b7-b69f-0121-fb72-6b6450e1b2f2@arm.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <ecb3725c-27c4-944b-b42c-f4e293521f94@arm.com>
Date: Wed, 8 May 2019 19:31:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e3b417b7-b69f-0121-fb72-6b6450e1b2f2@arm.com>
Content-Language: en-US
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, vincent.stehle@arm.com,
	ashok.raj@intel.com, marc.zyngier@arm.com, christoffer.dall@arm.com
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

On 08/05/2019 15:05, Robin Murphy wrote:
> On 08/04/2019 13:18, Eric Auger wrote:
>> From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>>
>> When handling faults from the event or PRI queue, we need to find the
>> struct device associated to a SID. Add a rb_tree to keep track of SIDs.
> 
> Out of curiosity, have you looked at whether an xarray might now be a
> more efficient option for this?

I hadn't looked into it yet, but it's a welcome distraction.

* Searching by SID will be more efficient with xarray (which still is a
radix tree, with a better API). Rather than O(log2(n)) we walk
O(log_c(n)) nodes in the worst case, with c = XA_CHUNK_SIZE = 64. We
don't care about insertion/deletion time.

* Memory consumption is worse than rb-tree, when the SID space is a
little sparse. For PCI devices the three LSBs (function number) might
not be in use, meaning that 88% of the leaf slots would be unused. And
it gets worse if the system has lots of bridges, as each bus number
requires its own xa slot, ie. 98% unused.

  It's not too bad though, and in general I think the distribution of
SIDs would be good enough to justify using xarray. Plugging in more
devices would increase the memory consumption fast, but creating virtual
functions wouldn't. On one machine (TX2, a few discrete PCI cards) I
need 16 xa slots to store 42 device IDs. That's 16 * 576 bytes = 9 kB,
versus 42 * 40 bytes = 1.6 kB for the rb-tree. On another machine (x86,
lots of RC integrated endpoints) I need 18 slots to store 181 device
IDs, 10 kB vs. 7 kB with the rb-tree.

* Using xa would make this code a lot nicer.

Shame that we can't store the device pointer directly in the STE though,
there is already plenty of unused space in there.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
