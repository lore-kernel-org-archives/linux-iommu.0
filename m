Return-Path: <SRS0=NT7l=KQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA63C43461
	for <iommu@archiver.kernel.org>; Fri, 21 May 2021 07:03:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F13361006
	for <iommu@archiver.kernel.org>; Fri, 21 May 2021 07:03:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F13361006
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 48C5284549;
	Fri, 21 May 2021 07:03:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VOkcxFRe_Y2u; Fri, 21 May 2021 07:03:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 40D718450D;
	Fri, 21 May 2021 07:03:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1306BC000D;
	Fri, 21 May 2021 07:03:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2ADBC0001
 for <iommu@lists.linux-foundation.org>; Fri, 21 May 2021 07:03:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B851840207
 for <iommu@lists.linux-foundation.org>; Fri, 21 May 2021 07:03:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rAZMVSPonY61 for <iommu@lists.linux-foundation.org>;
 Fri, 21 May 2021 07:03:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 19376400CA
 for <iommu@lists.linux-foundation.org>; Fri, 21 May 2021 07:03:18 +0000 (UTC)
IronPort-SDR: kFe4qlZAq8TgnCK2Vx5o17OCbbkk3F8r83stJ9hhTvMF07Qovvju0PC7guRjPHzm51B5gaWebo
 TUkFgtpqFYLQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="201458761"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; d="scan'208";a="201458761"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2021 00:03:17 -0700
IronPort-SDR: 5UNqd8GbHaSlRSFz7jFi0GD2g7d7HT+PElXXnbCro3PtL6H1P0R5p8l+ung57gYdebTdzQIZfj
 jwKH9GDiBUoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; d="scan'208";a="462371543"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 21 May 2021 00:03:15 -0700
Subject: Re: [PATCH] iommu/vt-d: Fix sysfs leak in alloc_domain()
To: Rolf Eike Beer <eb@emlix.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
References: <1716403.SmlLz2RZUD@devpool47>
 <17411490.HIIP88n32C@mobilepool36.emlix.com>
 <b13c4073-5976-b4e0-4dc7-4e07e68cbb5f@linux.intel.com>
 <1889881.5hqWi3GpDC@devpool47>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <29767d37-f8ea-b201-bef8-3bb2f6933bc2@linux.intel.com>
Date: Fri, 21 May 2021 15:02:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1889881.5hqWi3GpDC@devpool47>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>,
 linux-kernel@vger.kernel.org
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

Hi Joerg,

On 5/21/21 2:53 PM, Rolf Eike Beer wrote:
> Am Donnerstag, 22. April 2021, 07:34:17 CEST schrieb Lu Baolu:
>> Hi Rolf,
>>
>> On 4/22/21 1:39 PM, Rolf Eike Beer wrote:
>>> iommu_device_sysfs_add() is called before, so is has to be cleaned on
>>> subsequent errors.
>>>
>>> Fixes: 39ab9555c2411 ("iommu: Add sysfs bindings for struct iommu_device")
>>> Cc: stable@vger.kernel.org # 4.11.x
>>> Signed-off-by: Rolf Eike Beer <eb@emlix.com>
>>
>> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> Ping. Who is going to pick this up, please?

I forgot to put this fix in my last pull request. Could you please pick
it up? Or, I can send another pull request the next week.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
