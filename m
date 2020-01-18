Return-Path: <SRS0=Kz9i=3H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1283C33C9E
	for <iommu@archiver.kernel.org>; Sat, 18 Jan 2020 02:15:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93FE72192A
	for <iommu@archiver.kernel.org>; Sat, 18 Jan 2020 02:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93FE72192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 649CE871F0;
	Sat, 18 Jan 2020 02:15:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xc1ZvGrGYzgk; Sat, 18 Jan 2020 02:15:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 68835864C5;
	Sat, 18 Jan 2020 02:15:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4EBA8C18DC;
	Sat, 18 Jan 2020 02:15:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F2FBC077D
 for <iommu@lists.linux-foundation.org>; Sat, 18 Jan 2020 02:15:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 768FF86A3C
 for <iommu@lists.linux-foundation.org>; Sat, 18 Jan 2020 02:15:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t1geirDvF1hD for <iommu@lists.linux-foundation.org>;
 Sat, 18 Jan 2020 02:15:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3D91C86A36
 for <iommu@lists.linux-foundation.org>; Sat, 18 Jan 2020 02:15:38 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Jan 2020 18:15:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,332,1574150400"; d="scan'208";a="214686218"
Received: from allen-box.sh.intel.com (HELO [10.239.159.138])
 ([10.239.159.138])
 by orsmga007.jf.intel.com with ESMTP; 17 Jan 2020 18:15:35 -0800
Subject: Re: [PATCH 1/1] iommu/vt-d: Remove unnecessary WARN_ON_ONCE()
To: Joerg Roedel <joro@8bytes.org>
References: <20200116015236.4458-1-baolu.lu@linux.intel.com>
 <20200117095953.GB15760@8bytes.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <b56e8a8f-acd7-b318-5a1c-f32c5a07657f@linux.intel.com>
Date: Sat, 18 Jan 2020 10:14:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200117095953.GB15760@8bytes.org>
Content-Language: en-US
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com
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

On 1/17/20 5:59 PM, Joerg Roedel wrote:
> On Thu, Jan 16, 2020 at 09:52:36AM +0800, Lu Baolu wrote:
>> Address field in device TLB invalidation descriptor is qualified
>> by the S field. If S field is zero, a single page at page address
>> specified by address [63:12] is requested to be invalidated. If S
>> field is set, the least significant bit in the address field with
>> value 0b (say bit N) indicates the invalidation address range. The
>> spec doesn't require the address [N - 1, 0] to be cleared, hence
>> remove the unnecessary WARN_ON_ONCE().
>>
>> Otherwise, the caller might set "mask = MAX_AGAW_PFN_WIDTH" in order
>> to invalidating all the cached mappings on an endpoint, and below
>> overflow error will be triggered.
>>
>> [...]
>> UBSAN: Undefined behaviour in drivers/iommu/dmar.c:1354:3
>> shift exponent 64 is too large for 64-bit type 'long long unsigned int'
>> [...]
>>
>> Reported-and-tested-by: Frank <fgndev@posteo.de>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> Does this need a Fixes and/or stable tag?
> 

This doesn't cause any errors, just an unnecessary checking of

	"0 & ((1UL << 64) - 1)"

in some cases.

> 
> Regards,
> 
> 	Joerg

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
