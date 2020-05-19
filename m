Return-Path: <SRS0=kGUL=7B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BDAC433DF
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 12:41:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C10B20657
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 12:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C10B20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DCF4E87CA2;
	Tue, 19 May 2020 12:41:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NLIzw56-7jio; Tue, 19 May 2020 12:41:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 44E3B876DD;
	Tue, 19 May 2020 12:41:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D293C07FF;
	Tue, 19 May 2020 12:41:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A31C9C0176
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 12:41:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 92BCE876E3
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 12:41:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KaQDVXUfebaq for <iommu@lists.linux-foundation.org>;
 Tue, 19 May 2020 12:41:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by whitealder.osuosl.org (Postfix) with ESMTPS id DBDE8876DD
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 12:41:16 +0000 (UTC)
IronPort-SDR: j5nUYitujk+Du17RE6CvjthDMHc2GdAMWxNZzYCG4sCIcSrgIA+EJbe+0VhMWRQeMG4XRxfJh+
 Hdte4rzsrGJQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2020 05:41:16 -0700
IronPort-SDR: Re8qdtwAq2f8ket4wEoqTBpCEkciwyBZ/b9aa6+Z5usrSc1/wzCxcoPMWSVeoHZ7YyB9fC+36r
 q04fwq0LGD/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,410,1583222400"; d="scan'208";a="373715219"
Received: from cho2-mobl3.gar.corp.intel.com (HELO [10.249.172.134])
 ([10.249.172.134])
 by fmsmga001.fm.intel.com with ESMTP; 19 May 2020 05:41:14 -0700
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix pointer cast warnings on 32 bit
To: Joerg Roedel <joro@8bytes.org>
References: <20200519013423.11971-1-baolu.lu@linux.intel.com>
 <20200519120911.GH18353@8bytes.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <b99ba52c-70bd-79d1-aa15-83deefc42f7d@linux.intel.com>
Date: Tue, 19 May 2020 20:41:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200519120911.GH18353@8bytes.org>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org
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

On 2020/5/19 20:09, Joerg Roedel wrote:
> On Tue, May 19, 2020 at 09:34:23AM +0800, Lu Baolu wrote:
>> Pointers should be casted to unsigned long to avoid "cast from pointer
>> to integer of different size" warnings.
>>
>> drivers/iommu/intel-pasid.c:818:6: warning:
>>      cast from pointer to integer of different size [-Wpointer-to-int-cast]
>> drivers/iommu/intel-pasid.c:821:9: warning:
>>      cast from pointer to integer of different size [-Wpointer-to-int-cast]
>> drivers/iommu/intel-pasid.c:824:23: warning:
>>      cast from pointer to integer of different size [-Wpointer-to-int-cast]
>> drivers/iommu/intel-svm.c:343:45: warning:
>>      cast to pointer from integer of different size [-Wint-to-pointer-cast]
>>
>> Fixes: d64d47f4f5678 ("iommu/vt-d: Add nested translation helper function")
>> Fixes: a3bea1a35c083 ("iommu/vt-d: Add bind guest PASID support")
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel-pasid.c | 8 ++++----
>>   drivers/iommu/intel-svm.c   | 3 ++-
>>   2 files changed, 6 insertions(+), 5 deletions(-)
> 
> Applied, thanks.
> 
> Btw, I think the PASID and Intel SVM code is pretty useless on 32 bit
> anyway, no? It only supports 4 and 5 level page-tables, not the 2 and
> 3-level variants on 32-bit. Can you make it 64-bit only?

Sure. I will make it.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
