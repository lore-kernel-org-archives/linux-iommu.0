Return-Path: <SRS0=meaX=6A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30BCC2BA19
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 01:46:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EAE52064A
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 01:46:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EAE52064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6273C864D7;
	Thu, 16 Apr 2020 01:46:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KyOXiBNkn2Wd; Thu, 16 Apr 2020 01:46:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 42CFF81ADE;
	Thu, 16 Apr 2020 01:46:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36732C089E;
	Thu, 16 Apr 2020 01:46:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64868C0172
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 01:46:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4F813860F6
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 01:46:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o1Jw1bGjOgtU for <iommu@lists.linux-foundation.org>;
 Thu, 16 Apr 2020 01:46:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9B9E7860F2
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 01:46:25 +0000 (UTC)
IronPort-SDR: JtikNjAV5Tgm7oSKE7uphqRNPORFdZqu0xIKBoZ1wi0beN2QekIxuMC6YDBhaypoZrgjY6wbwB
 TECf/e500PgA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2020 18:46:24 -0700
IronPort-SDR: 4ir7BZso7cfJHuzUa1A+4Z7QoZGNfojvIlXnYMd/siRdmlT3Tu+gzm64EBH0YxTbdZN7y6Gu8/
 nMmEFt/mjn5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,388,1580803200"; d="scan'208";a="245845976"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.171])
 ([10.254.208.171])
 by fmsmga008.fm.intel.com with ESMTP; 15 Apr 2020 18:46:22 -0700
Subject: Re: [PATCH v2 5/7] iommu/vt-d: Save prq descriptors in an internal
 list
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>
References: <20200415052542.30421-1-baolu.lu@linux.intel.com>
 <20200415052542.30421-6-baolu.lu@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D8207B2@SHSMSX104.ccr.corp.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <399dd037-b32e-30a7-013c-b68e9a3bbc7a@linux.intel.com>
Date: Thu, 16 Apr 2020 09:46:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D8207B2@SHSMSX104.ccr.corp.intel.com>
Content-Language: en-US
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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

On 2020/4/15 17:30, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Wednesday, April 15, 2020 1:26 PM
>>
>> Currently, the page request interrupt thread handles the page
>> requests in the queue in this way:
>>
>> - Clear PPR bit to ensure new interrupt could come in;
>> - Read and record the head and tail registers;
>> - Handle all descriptors between head and tail;
>> - Write tail to head register.
>>
>> This might cause some descriptors to be handles multiple times.
>> An example sequence:
>>
>> - Thread A got scheduled with PRQ_1 and PRQ_2 in the queue;
>> - Thread A clear the PPR bit and record the head and tail;
>> - A new PRQ_3 comes and Thread B gets scheduled;
>> - Thread B record the head and tail which includes PRQ_1
>>    and PRQ_2.
> I may overlook something but isn't the prq interrupt thread
> per iommu then why would two prq threads contend here?

The prq interrupt could be masked by the PPR (Pending Page Request) bit
in Page Request Status Register. In the interrupt handling thread once
this bit is clear, new prq interrupts are allowed to be generated.

So, if a page request is in process and the PPR bit is cleared, another
page request from any devices under the same iommu could trigger another
interrupt thread.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
