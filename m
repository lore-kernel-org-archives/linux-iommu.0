Return-Path: <SRS0=03l9=BB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6C5C433E2
	for <iommu@archiver.kernel.org>; Wed, 22 Jul 2020 01:06:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 337832073A
	for <iommu@archiver.kernel.org>; Wed, 22 Jul 2020 01:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 337832073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D84858710D;
	Wed, 22 Jul 2020 01:06:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vjXOooJcJrOi; Wed, 22 Jul 2020 01:06:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0F3B986FF8;
	Wed, 22 Jul 2020 01:06:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8483C089F;
	Wed, 22 Jul 2020 01:06:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A89B7C016F
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 01:06:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 973D18831B
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 01:06:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id veGqtBI67JRz for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jul 2020 01:06:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D9BA988319
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 01:06:13 +0000 (UTC)
IronPort-SDR: HcZ1JKC6m03l1nWEtMnCrbuWFxGTb2S5TsaAxYOekULkCMxc7SK8WhGtBzrF/wR8tKTbuzaCNo
 bbHD5IHsDlgA==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="130336525"
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; d="scan'208";a="130336525"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2020 18:06:13 -0700
IronPort-SDR: rRK2QOhEswznu82D5O8AVJvsH3HtTfgWnE7Secv6pJtJlwm4qJNo8h8La5U3dnaOd5xK4cQNjM
 GVX7xVlahmiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; d="scan'208";a="462275980"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by orsmga005.jf.intel.com with ESMTP; 21 Jul 2020 18:06:10 -0700
Subject: Re: [PATCH v4 4/7] iommu/vt-d: Handle non-page aligned address
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
References: <1594080774-33413-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1594080774-33413-5-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200721095036.1977e3bf@jacob-builder>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <7a8f70af-f39b-1b57-a9eb-db085ab63149@linux.intel.com>
Date: Wed, 22 Jul 2020 09:01:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200721095036.1977e3bf@jacob-builder>
Content-Language: en-US
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>
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

Hi Jacob,

On 7/22/20 12:50 AM, Jacob Pan wrote:
> Hi Baolu,
> 
> Not sure what state is this patch in, there is a bug in this patch
> (see below), shall I send out an updated version of this one only? or
> another incremental patch.

Please send an updated version. I hope Joerg could pick these as 5.8
fix.

Best regards,
baolu

> 
> Thanks,
> 
> Jacob
> 
> On Mon,  6 Jul 2020 17:12:51 -0700
> Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> 
>> From: Liu Yi L <yi.l.liu@intel.com>
>>
>> Address information for device TLB invalidation comes from userspace
>> when device is directly assigned to a guest with vIOMMU support.
>> VT-d requires page aligned address. This patch checks and enforce
>> address to be page aligned, otherwise reserved bits can be set in the
>> invalidation descriptor. Unrecoverable fault will be reported due to
>> non-zero value in the reserved bits.
>>
>> Fixes: 61a06a16e36d8 ("iommu/vt-d: Support flushing more translation
>> cache types")
>> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>
>> ---
>>   drivers/iommu/intel/dmar.c | 20 ++++++++++++++++++--
>>   1 file changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
>> index d9f973fa1190..b2c53bada905 100644
>> --- a/drivers/iommu/intel/dmar.c
>> +++ b/drivers/iommu/intel/dmar.c
>> @@ -1455,9 +1455,25 @@ void qi_flush_dev_iotlb_pasid(struct
>> intel_iommu *iommu, u16 sid, u16 pfsid,
>>   	 * Max Invs Pending (MIP) is set to 0 for now until we have
>> DIT in
>>   	 * ECAP.
>>   	 */
>> -	desc.qw1 |= addr & ~mask;
>> -	if (size_order)
>> +	if (addr & GENMASK_ULL(size_order + VTD_PAGE_SHIFT, 0))
>> +		pr_warn_ratelimited("Invalidate non-aligned address
>> %llx, order %d\n", addr, size_order); +
>> +	/* Take page address */
>> +	desc.qw1 = QI_DEV_EIOTLB_ADDR(addr);
>> +
>> +	if (size_order) {
>> +		/*
>> +		 * Existing 0s in address below size_order may be
>> the least
>> +		 * significant bit, we must set them to 1s to avoid
>> having
>> +		 * smaller size than desired.
>> +		 */
>> +		desc.qw1 |= GENMASK_ULL(size_order + VTD_PAGE_SHIFT,
>> +					VTD_PAGE_SHIFT);
> Yi reported the issue, it should be:
> desc.qw1 |= GENMASK_ULL(size_order + VTD_PAGE_SHIFT - 1,
> 					VTD_PAGE_SHIFT);
> 
>> +		/* Clear size_order bit to indicate size */
>> +		desc.qw1 &= ~mask;
>> +		/* Set the S bit to indicate flushing more than 1
>> page */ desc.qw1 |= QI_DEV_EIOTLB_SIZE;
>> +	}
>>   
>>   	qi_submit_sync(iommu, &desc, 1, 0);
>>   }
> 
> [Jacob Pan]
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
