Return-Path: <SRS0=mFID=C5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF87FC43466
	for <iommu@archiver.kernel.org>; Sun, 20 Sep 2020 06:36:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33F0520888
	for <iommu@archiver.kernel.org>; Sun, 20 Sep 2020 06:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33F0520888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B264A86DB5;
	Sun, 20 Sep 2020 06:36:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LmU7VccnoH7T; Sun, 20 Sep 2020 06:36:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9A66186DA8;
	Sun, 20 Sep 2020 06:36:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F6A2C0859;
	Sun, 20 Sep 2020 06:36:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B34C2C0051
 for <iommu@lists.linux-foundation.org>; Sun, 20 Sep 2020 06:36:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 962638717A
 for <iommu@lists.linux-foundation.org>; Sun, 20 Sep 2020 06:36:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vXPivoAKeKMY for <iommu@lists.linux-foundation.org>;
 Sun, 20 Sep 2020 06:36:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E83A087176
 for <iommu@lists.linux-foundation.org>; Sun, 20 Sep 2020 06:36:53 +0000 (UTC)
IronPort-SDR: jHqp2D/iuaH6KmCLnvVoaVHfcLKMrR2665fxSB8ibBigCCcKJ7GopT5e5kf4gDHJ4Xp5KpJUQf
 b0VVRVFz23LQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9749"; a="157591175"
X-IronPort-AV: E=Sophos;i="5.77,281,1596524400"; d="scan'208";a="157591175"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2020 23:36:53 -0700
IronPort-SDR: jabbN3qQsO/QbcFPJwnrAIPouqbK8zIgTL8nP5gVkx2hTZ+WRQO216CTjg+hH0Rcn4dLkQQA4T
 ixr2XHqNPtSQ==
X-IronPort-AV: E=Sophos;i="5.77,281,1596524400"; d="scan'208";a="308504530"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.213.187])
 ([10.254.213.187])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2020 23:36:50 -0700
Subject: Re: [Intel-gfx] [PATCH v3 0/6] Convert the intel iommu driver to the
 dma-iommu api
To: Logan Gunthorpe <logang@deltatee.com>, Joerg Roedel <joro@8bytes.org>,
 Tom Murphy <murphyt7@tcd.ie>, David Woodhouse <dwmw2@infradead.org>,
 Christoph Hellwig <hch@infradead.org>
References: <20200912032200.11489-1-baolu.lu@linux.intel.com>
 <776771a2-247a-d1be-d882-bee02d919ae0@deltatee.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <fe94760f-3c10-4222-ec87-291c01325fef@linux.intel.com>
Date: Sun, 20 Sep 2020 14:36:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <776771a2-247a-d1be-d882-bee02d919ae0@deltatee.com>
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

On 2020/9/19 4:47, Logan Gunthorpe wrote:
> Hi Lu,
> 
> On 2020-09-11 9:21 p.m., Lu Baolu wrote:
>> Tom Murphy has almost done all the work. His latest patch series was
>> posted here.
>>
>> https://lore.kernel.org/linux-iommu/20200903201839.7327-1-murphyt7@tcd.ie/
>>
>> Thanks a lot!
>>
>> This series is a follow-up with below changes:
>>
>> 1. Add a quirk for the i915 driver issue described in Tom's cover
>> letter.
>> 2. Fix several bugs in patch "iommu: Allow the dma-iommu api to use
>> bounce buffers" to make the bounce buffer work for untrusted devices.
>> 3. Several cleanups in iommu/vt-d driver after the conversion.
>>
> 
> I'm trying to test this on an old Sandy Bridge, but found that I get
> spammed with warnings on boot. I've put a sample of a few of them below.
> They all seem to be related to ioat.
> 
> I had the same issue with Tom's v2 but never saw this on his v1.

Have you verified whether this could be reproduced with the lasted
upstream kernel (without this patch series)?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
