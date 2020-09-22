Return-Path: <SRS0=CZ1O=C7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C85C4363D
	for <iommu@archiver.kernel.org>; Tue, 22 Sep 2020 18:46:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45CA820715
	for <iommu@archiver.kernel.org>; Tue, 22 Sep 2020 18:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="hgbszfn8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45CA820715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id F2926203F1;
	Tue, 22 Sep 2020 18:46:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5t5XVwhYXoYB; Tue, 22 Sep 2020 18:46:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7EBE920396;
	Tue, 22 Sep 2020 18:46:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5FA64C0889;
	Tue, 22 Sep 2020 18:46:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A46E2C0051
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 18:45:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9F38B870D3
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 18:45:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wSXUkeP8bCey for <iommu@lists.linux-foundation.org>;
 Tue, 22 Sep 2020 18:45:58 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0DDB2870D2
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 18:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X7NUEq0ufXOsugZoq6CuHmrSiYQPXwP5Ooq9psOTR50=; b=hgbszfn8Q8M+LUV4fO4UmpVrpo
 W9L10nlBf4AUaJi6wIOyIwMb1CFqMtZY/o9YPR7nGiqdkOmv1tNNRIf5ZhnERq1qVDJh1Nc9vL0nD
 dJqxD7xLNbLfgkEh7EKiYDePwAfQG01lcQHmMnJJ5jiTFq0cpwqA1E2mIuGRHrpQb4tjqdv1ALsZs
 vmVwl83kpB1glfzXJMV2KiZK6XxfrMW9wMHWuwarvQfq7GqHyqSNYYu9JgOnHZUQVZuUBmsOf9Ie/
 p4RgmnFrS92unexkZnUWkGuAIAFVc5EX/1pxqIwTMeQ9QJAqoKDGK/mQj+ZDdpwWf1oUhOiALDh9a
 CILlE2Bg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1kKnIa-0003mC-Kv; Tue, 22 Sep 2020 12:45:57 -0600
To: Robin Murphy <robin.murphy@arm.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
 Joerg Roedel <joro@8bytes.org>, Tom Murphy <murphyt7@tcd.ie>,
 David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@infradead.org>
References: <20200912032200.11489-1-baolu.lu@linux.intel.com>
 <776771a2-247a-d1be-d882-bee02d919ae0@deltatee.com>
 <d75e5c9c-1834-7f77-aa51-666186f3db5c@arm.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <3f50d09c-c9a1-77aa-0228-985c5d1f5b2b@deltatee.com>
Date: Tue, 22 Sep 2020 12:45:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <d75e5c9c-1834-7f77-aa51-666186f3db5c@arm.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, ashok.raj@intel.com,
 Intel-gfx@lists.freedesktop.org, hch@infradead.org, dwmw2@infradead.org,
 murphyt7@tcd.ie, joro@8bytes.org, baolu.lu@linux.intel.com,
 robin.murphy@arm.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [Intel-gfx] [PATCH v3 0/6] Convert the intel iommu driver to the
 dma-iommu api
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Intel-gfx@lists.freedesktop.org, Ashok Raj <ashok.raj@intel.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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



On 2020-09-22 3:51 a.m., Robin Murphy wrote:
> On 2020-09-18 21:47, Logan Gunthorpe wrote:
>> Hi Lu,
>>
>> On 2020-09-11 9:21 p.m., Lu Baolu wrote:
>>> Tom Murphy has almost done all the work. His latest patch series was
>>> posted here.
>>>
>>> https://lore.kernel.org/linux-iommu/20200903201839.7327-1-murphyt7@tcd.ie/
>>>
>>> Thanks a lot!
>>>
>>> This series is a follow-up with below changes:
>>>
>>> 1. Add a quirk for the i915 driver issue described in Tom's cover
>>> letter.
>>> 2. Fix several bugs in patch "iommu: Allow the dma-iommu api to use
>>> bounce buffers" to make the bounce buffer work for untrusted devices.
>>> 3. Several cleanups in iommu/vt-d driver after the conversion.
>>>
>>
>> I'm trying to test this on an old Sandy Bridge, but found that I get
>> spammed with warnings on boot. I've put a sample of a few of them below.
>> They all seem to be related to ioat.
>>
>> I had the same issue with Tom's v2 but never saw this on his v1.
> 
> I think this might have more to do with ioat being totally broken - 
> AFAICS it appears to allocate descriptors with a size of 2MB, but free 
> them with a size of 512KB. Try throwing CONFIG_DMA_API_DEBUG at it to 
> confirm.

Ah, yes, nice catch. Looks like it was broken recently by the following
commit, but nobody noticed and the dma-iommu patch set added a warning
which caught it.

a02254f8a676 ("dmaengine: ioat: Decreasing allocation chunk size 2M->512K")

Reverting that fixes the issue. I'll try to send patch or two for this.

Logan

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
