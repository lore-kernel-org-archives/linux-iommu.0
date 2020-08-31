Return-Path: <SRS0=U/E5=CJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D93C433E2
	for <iommu@archiver.kernel.org>; Mon, 31 Aug 2020 07:05:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 545852072D
	for <iommu@archiver.kernel.org>; Mon, 31 Aug 2020 07:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 545852072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 204A185DA4;
	Mon, 31 Aug 2020 07:05:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EBaSjQmFsmz1; Mon, 31 Aug 2020 07:05:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 732D885C3B;
	Mon, 31 Aug 2020 07:05:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59B22C07FF;
	Mon, 31 Aug 2020 07:05:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8032EC0051
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 07:05:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6422985C3B
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 07:05:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xq59dboDhDyc for <iommu@lists.linux-foundation.org>;
 Mon, 31 Aug 2020 07:05:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D178A85BFA
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 07:05:02 +0000 (UTC)
IronPort-SDR: HeQ7cqQAHB8ELgurIvFp5KcrxpApI2ZSFuDTfVfUTToCrnSeYgMjvIfY4VDlnaTrzrHDCS9LnZ
 gVNsg82tuhTA==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="144601286"
X-IronPort-AV: E=Sophos;i="5.76,374,1592895600"; d="scan'208";a="144601286"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2020 00:05:01 -0700
IronPort-SDR: LUiPJ+blEmu6/+ALpOfRuk4de8zShxR/8l7ENsFUx65F3KGi2tRQ/CV/EfjbcjFGgDpmvnkWkR
 Ynmv40fQQ0hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,374,1592895600"; d="scan'208";a="501756910"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.84])
 ([10.254.212.84])
 by fmsmga005.fm.intel.com with ESMTP; 31 Aug 2020 00:04:59 -0700
Subject: Re: [PATCH v1] iommu/vt-d: Move intel_iommu_ops to header file
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Christoph Hellwig <hch@infradead.org>
References: <20200828160502.65695-1-andriy.shevchenko@linux.intel.com>
 <20200829065846.GB31681@infradead.org>
 <20200831063038.GV1891694@smile.fi.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <402afdc3-3b5e-8c32-e9b0-612d1cd2bafe@linux.intel.com>
Date: Mon, 31 Aug 2020 15:04:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200831063038.GV1891694@smile.fi.intel.com>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>
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

Hi Andy,

On 2020/8/31 14:30, Andy Shevchenko wrote:
> On Sat, Aug 29, 2020 at 07:58:46AM +0100, Christoph Hellwig wrote:
>> On Fri, Aug 28, 2020 at 07:05:02PM +0300, Andy Shevchenko wrote:
>>> Compiler is not happy about hidden declaration of intel_iommu_ops.
>>>
>>> .../drivers/iommu/intel/iommu.c:414:24: warning: symbol 'intel_iommu_ops' was not declared. Should it be static?
>>>
>>> Move declaration to header file to make compiler happy.
>>
>> What about a factoring out a helper that does iommu_device_sysfs_add +
>> iommu_device_set_ops + iommu_device_register and then mark
>> intel_iommu_ops static?
> 
> I am okay with this proposal, but I think the better if IOMMU folks can answer
> to this before I'm going to invest time into it.

Thanks for your patch! I am okay with Christoph's proposal as well.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
