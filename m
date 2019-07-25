Return-Path: <SRS0=la/L=VW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF994C76186
	for <iommu@archiver.kernel.org>; Thu, 25 Jul 2019 01:40:49 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C3B821951
	for <iommu@archiver.kernel.org>; Thu, 25 Jul 2019 01:40:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C3B821951
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 588281636;
	Thu, 25 Jul 2019 01:40:49 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 49A8D13E3
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Jul 2019 01:40:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id DAE22FE
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Jul 2019 01:40:47 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	24 Jul 2019 18:40:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,305,1559545200"; d="scan'208";a="181303519"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by orsmga002.jf.intel.com with ESMTP; 24 Jul 2019 18:40:44 -0700
Subject: Re: [PATCH 1/1] iommu/vt-d: Correctly check format of page table in
	debugfs
To: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>,
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
References: <20190720020126.9974-1-baolu.lu@linux.intel.com>
	<FFF73D592F13FD46B8700F0A279B802F4F9354AF@ORSMSX114.amr.corp.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <8d09da43-d0dd-9dff-0cb3-aa93448a7e60@linux.intel.com>
Date: Thu, 25 Jul 2019 09:40:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <FFF73D592F13FD46B8700F0A279B802F4F9354AF@ORSMSX114.amr.corp.intel.com>
Content-Language: en-US
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"Pan, Jacob jun" <jacob.jun.pan@intel.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Sai,

On 7/22/19 1:21 PM, Prakhya, Sai Praneeth wrote:
> Hi Allen,
> 
>> diff --git a/drivers/iommu/intel-iommu-debugfs.c b/drivers/iommu/intel-
>> iommu-debugfs.c
>> index 73a552914455..e31c3b416351 100644
>> --- a/drivers/iommu/intel-iommu-debugfs.c
>> +++ b/drivers/iommu/intel-iommu-debugfs.c
>> @@ -235,7 +235,7 @@ static void ctx_tbl_walk(struct seq_file *m, struct
>> intel_iommu *iommu, u16 bus)
>>   		tbl_wlk.ctx_entry = context;
>>   		m->private = &tbl_wlk;
>>
>> -		if (pasid_supported(iommu) && is_pasid_enabled(context)) {
>> +		if (dmar_readq(iommu->reg + DMAR_RTADDR_REG) &
>> DMA_RTADDR_SMT) {
> 
> Thanks for adding this, I do believe this is a good addition but I also think that we might
> need "is_pasid_enabled()" as well. It checks if PASIDE bit in context entry is enabled or not.
> 
> I am thinking that even though DMAR might be using scalable root and context table, the entry
> itself should have PASIDE bit set. Did I miss something here?

No matter the PASIDE bit set or not, IOMMU always uses the scalable mode
page table if scalable mode is enabled. If PASIDE is set, requests with
PASID will be handled. Otherwise, requests with PASID will be blocked
(but request without PASID will always be handled).

We are dumpling the page table of the IOMMU, so we only care about what
page table format it is using. Do I understand it right>

Best regards,
Baolu

> 
> And I also think a macro would be better so that it could reused elsewhere (if need be).
> 
> Regards,
> Sai
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
