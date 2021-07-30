Return-Path: <SRS0=GV0T=MW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0639CC4338F
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 13:01:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C65460F46
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 13:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8C65460F46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4FD6940673;
	Fri, 30 Jul 2021 13:01:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EocL4vVQh5nc; Fri, 30 Jul 2021 13:01:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3012340652;
	Fri, 30 Jul 2021 13:01:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EEC3AC0010;
	Fri, 30 Jul 2021 13:01:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48F62C000E
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 13:01:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 210B74048E
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 13:01:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mgQz6CtlIpde for <iommu@lists.linux-foundation.org>;
 Fri, 30 Jul 2021 13:01:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5CFB8403A0
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 13:01:46 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10060"; a="209979852"
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; d="scan'208";a="209979852"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2021 06:01:45 -0700
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; d="scan'208";a="476949523"
Received: from jxie1-mobl.ccr.corp.intel.com (HELO [10.254.211.228])
 ([10.254.211.228])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2021 06:01:43 -0700
Subject: Re: [PATCH v1 1/2] iommu/vt-d: Move intel_iommu_ops to header file
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20210729163538.40101-1-andriy.shevchenko@linux.intel.com>
 <3c7663db-5b1e-3e00-3ff1-381c7a107ac9@linux.intel.com>
 <YQOyzka9VDJU3NhU@smile.fi.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <17a2b3f2-747d-2798-7fea-5846eec0b1fe@linux.intel.com>
Date: Fri, 30 Jul 2021 21:01:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQOyzka9VDJU3NhU@smile.fi.intel.com>
Content-Language: en-US
Cc: Joerg Roedel <jroedel@suse.de>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
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

On 2021/7/30 16:05, Andy Shevchenko wrote:
> On Fri, Jul 30, 2021 at 10:20:08AM +0800, Lu Baolu wrote:
>> On 7/30/21 12:35 AM, Andy Shevchenko wrote:
>>> Compiler is not happy about hidden declaration of intel_iommu_ops.
>>>
>>> .../drivers/iommu/intel/iommu.c:414:24: warning: symbol 'intel_iommu_ops' was not declared. Should it be static?
>>>
>>> Move declaration to header file to make compiler happy.
>>
>> Thanks for the cleanup. Sharing data structures between different files
>> doesn't seem to be a good design. How about adding a helper so that the
>> intel_iommu_ops could be a static one?
> 
> Whatever suits the purpose.
> Can you apply patch 2 of this series, please?
> 

Yes, I will. Thanks!

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
