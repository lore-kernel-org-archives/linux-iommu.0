Return-Path: <SRS0=CZ1O=C7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90DBC4727D
	for <iommu@archiver.kernel.org>; Tue, 22 Sep 2020 00:30:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E63223A8B
	for <iommu@archiver.kernel.org>; Tue, 22 Sep 2020 00:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E63223A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CD6592151F;
	Tue, 22 Sep 2020 00:30:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NGxs+JYMawh7; Tue, 22 Sep 2020 00:30:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D2B14214FD;
	Tue, 22 Sep 2020 00:30:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5E61C0859;
	Tue, 22 Sep 2020 00:30:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BCCC1C0051
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 00:30:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B2A9287052
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 00:30:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zLrMt3EVvNaN for <iommu@lists.linux-foundation.org>;
 Tue, 22 Sep 2020 00:30:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1A6C78704D
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 00:30:17 +0000 (UTC)
IronPort-SDR: MjMqgYwdIujbCPLfNMcfU7xGpHJmWT2YlNF8jlC3Mi7LeGoMAcriQqOuSid6Z/kzjb505irN/Y
 ueu01O+j5LJA==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="178564306"
X-IronPort-AV: E=Sophos;i="5.77,288,1596524400"; d="scan'208";a="178564306"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2020 17:30:15 -0700
IronPort-SDR: XxmBwCkFQnBv7el7ENXABUajPFYQWDnkiPSjfIISmi1wsuEYzT/vrKmJd8cKOU0NRqZvl3x64S
 BLc+OSd3zBGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,288,1596524400"; d="scan'208";a="412481384"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga001.fm.intel.com with ESMTP; 21 Sep 2020 17:30:13 -0700
Subject: Re: [Intel-gfx] [PATCH v3 0/6] Convert the intel iommu driver to the
 dma-iommu api
To: Logan Gunthorpe <logang@deltatee.com>, Joerg Roedel <joro@8bytes.org>,
 Tom Murphy <murphyt7@tcd.ie>, David Woodhouse <dwmw2@infradead.org>,
 Christoph Hellwig <hch@infradead.org>
References: <20200912032200.11489-1-baolu.lu@linux.intel.com>
 <776771a2-247a-d1be-d882-bee02d919ae0@deltatee.com>
 <fe94760f-3c10-4222-ec87-291c01325fef@linux.intel.com>
 <e95a55ea-b03f-4b3c-327a-b48d364577e9@deltatee.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <c8bde158-50f6-1656-4a7d-6323573ba501@linux.intel.com>
Date: Tue, 22 Sep 2020 08:24:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e95a55ea-b03f-4b3c-327a-b48d364577e9@deltatee.com>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, Intel-gfx@lists.freedesktop.org,
 Ashok Raj <ashok.raj@intel.com>, iommu@lists.linux-foundation.org
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

Hi Logan,

On 9/21/20 11:48 PM, Logan Gunthorpe wrote:
> 
> 
> On 2020-09-20 12:36 a.m., Lu Baolu wrote:
>> Hi Logan,
>>
>> On 2020/9/19 4:47, Logan Gunthorpe wrote:
>>> Hi Lu,
>>>
>>> On 2020-09-11 9:21 p.m., Lu Baolu wrote:
>>>> Tom Murphy has almost done all the work. His latest patch series was
>>>> posted here.
>>>>
>>>> https://lore.kernel.org/linux-iommu/20200903201839.7327-1-murphyt7@tcd.ie/
>>>>
>>>> Thanks a lot!
>>>>
>>>> This series is a follow-up with below changes:
>>>>
>>>> 1. Add a quirk for the i915 driver issue described in Tom's cover
>>>> letter.
>>>> 2. Fix several bugs in patch "iommu: Allow the dma-iommu api to use
>>>> bounce buffers" to make the bounce buffer work for untrusted devices.
>>>> 3. Several cleanups in iommu/vt-d driver after the conversion.
>>>>
>>>
>>> I'm trying to test this on an old Sandy Bridge, but found that I get
>>> spammed with warnings on boot. I've put a sample of a few of them below.
>>> They all seem to be related to ioat.
>>>
>>> I had the same issue with Tom's v2 but never saw this on his v1.
>>
>> Have you verified whether this could be reproduced with the lasted
>> upstream kernel (without this patch series)?
> 
> Yes.

I am sorry. Just want to make sure I understand you correctly. :-) When
you say "yes", do you mean you could reproduce this with pure upstream
kernel (5.9-rc6)?

> Also, it's hitting a warning in the dma-iommu code which would not
> be hit without this patch set.

Without this series, DMA APIs don't go through dma-iommu. Do you mind
posting the warning message?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
