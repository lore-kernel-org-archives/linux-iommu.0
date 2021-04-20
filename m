Return-Path: <SRS0=gpU2=JR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33F8C433ED
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 11:07:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52E246135F
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 11:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E246135F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E2866402DC;
	Tue, 20 Apr 2021 11:07:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8UEFwfYOeMm9; Tue, 20 Apr 2021 11:07:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id E015D40214;
	Tue, 20 Apr 2021 11:07:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4C33C000E;
	Tue, 20 Apr 2021 11:07:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 266D1C000B
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 10:41:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1565D83ABC
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 10:41:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wrYQgJsyTtEZ for <iommu@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 10:41:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E247A83AB8
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 10:41:28 +0000 (UTC)
IronPort-SDR: HtApHJ0OlGu2lZ12t5osnMn3liQoV/mURALKFTngNu0F+CD2zuSPYbNWnGG1HRYDB7K8YoBZWw
 ZBMYCxHSXbuA==
X-IronPort-AV: E=McAfee;i="6200,9189,9959"; a="175590730"
X-IronPort-AV: E=Sophos;i="5.82,236,1613462400"; d="scan'208";a="175590730"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2021 03:41:28 -0700
IronPort-SDR: zBEE34l19qdqr83AHGBhxQffq+4JvC3ZbYqCOiE4ip4c669xO6weWyCL0VUIfhoj5vmAZi7aFB
 akOfFPKkyhLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,236,1613462400"; d="scan'208";a="523757927"
Received: from ipu5-build.bj.intel.com (HELO [10.238.232.202])
 ([10.238.232.202])
 by fmsmga001.fm.intel.com with ESMTP; 20 Apr 2021 03:41:24 -0700
Subject: Re: [RESEND v2] iommu/vt-d: Use passthrough mode for the Intel IPUs
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bingbu Cao <bingbu.cao@intel.com>
References: <1618886913-6594-1-git-send-email-bingbu.cao@intel.com>
 <YH6q+FCTQheO6FHi@smile.fi.intel.com>
From: Bingbu Cao <bingbu.cao@linux.intel.com>
Message-ID: <c9a0fc75-8b7b-e0ae-572e-8ca030a04537@linux.intel.com>
Date: Tue, 20 Apr 2021 18:34:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YH6q+FCTQheO6FHi@smile.fi.intel.com>
Content-Language: en-US
X-Mailman-Approved-At: Tue, 20 Apr 2021 11:07:25 +0000
Cc: will@kernel.org, grundler@chromium.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, senozhatsky@chromium.org,
 iommu@lists.linux-foundation.org, bhelgaas@google.com, rajatja@google.com,
 dwmw2@infradead.org
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

Andy,

On 4/20/21 6:20 PM, Andy Shevchenko wrote:
> On Tue, Apr 20, 2021 at 10:48:33AM +0800, Bingbu Cao wrote:
>> Intel IPU(Image Processing Unit) has its own (IO)MMU hardware,
>> The IPU driver allocates its own page table that is not mapped
>> via the DMA, and thus the Intel IOMMU driver blocks access giving
>> this error:
>>
>> DMAR: DRHD: handling fault status reg 3
>> DMAR: [DMA Read] Request device [00:05.0] PASID ffffffff
>>       fault addr 76406000 [fault reason 06] PTE Read access is not set
>>
>> As IPU is not an external facing device which is not risky, so use
>> IOMMU passthrough mode for Intel IPUs.
>>
>> Fixes: 26f5689592e2 ("media: staging/intel-ipu3: mmu: Implement driver")
>> Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
>> ---
>>  drivers/iommu/intel/iommu.c | 29 +++++++++++++++++++++++++++++
> 
> This misses the changelog from v1 followed by the explanation why resent.
> 
I noticed there was a typo in the recipient list:
stable.vger.kernel.org -> stable@vger.kernel.org

no code change for resent.

-- 
Best regards,
Bingbu Cao
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
