Return-Path: <SRS0=1/OX=IR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0012AC433E0
	for <iommu@archiver.kernel.org>; Fri, 19 Mar 2021 01:17:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9541B64DF0
	for <iommu@archiver.kernel.org>; Fri, 19 Mar 2021 01:17:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9541B64DF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 51E82833A8;
	Fri, 19 Mar 2021 01:17:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s0W-UNUZ8s0S; Fri, 19 Mar 2021 01:17:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3F8A8832C2;
	Fri, 19 Mar 2021 01:17:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11CABC000B;
	Fri, 19 Mar 2021 01:17:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB2C0C0001
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 01:17:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9EEC5832C2
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 01:17:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zLDuJnRg_LMi for <iommu@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 01:17:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 66AC4831A2
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 01:17:11 +0000 (UTC)
IronPort-SDR: 1TAtwKSl5T5+pard0AXmfYoB/1kubNbwaYFo4gDzpCgiwKn07JfJbvG/mRkskf3G1hfxRI9ObN
 TGract/mesZw==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="253808584"
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; d="scan'208";a="253808584"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2021 18:17:10 -0700
IronPort-SDR: EZxk9hyQ01Dram0VtQCI65jzNEPNaWLaxQpwmj69Fobyw5TK0Be4rvPzSGzUE4pccInPp4Bu0R
 CYyskGyJIL7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; d="scan'208";a="434080025"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 18 Mar 2021 18:17:07 -0700
Subject: Re: [PATCH 1/1] iommu/vt-d: Don't set then immediately clear in
 prq_event_thread()
To: Joerg Roedel <joro@8bytes.org>
References: <20210309004641.3809653-1-baolu.lu@linux.intel.com>
 <YFMm/+JMfySWPzZR@8bytes.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <db5fb311-b4c2-471e-713a-408061a6ba28@linux.intel.com>
Date: Fri, 19 Mar 2021 09:07:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YFMm/+JMfySWPzZR@8bytes.org>
Content-Language: en-US
Cc: kevin.tian@intel.com, ashok.raj@intel.com, sanjay.k.kumar@intel.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jacob.jun.pan@intel.com, Will Deacon <will@kernel.org>
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

On 3/18/21 6:10 PM, Joerg Roedel wrote:
> Hi Baolu,
> 
> On Tue, Mar 09, 2021 at 08:46:41AM +0800, Lu Baolu wrote:
>> The private data field of a page group response descriptor is set then
>> immediately cleared in prq_event_thread(). Fix this by moving clearing
>> code up.
>>
>> Fixes: 5b438f4ba315d ("iommu/vt-d: Support page request in scalable mode")
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Reviewed-by: Liu Yi L <yi.l.liu@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> Does this fix an actual bug? If so, please state it in the commit

It will cause real problem according to the VT-d spec. I haven't got a
chance run this on a real hardware yet. I'll add a commit message to
explain why this will cause problem.

> message and also fix the subject line to state what is set/cleared.
> 

Sure!

> Thanks,
> 
> 	Joerg
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
