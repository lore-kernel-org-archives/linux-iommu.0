Return-Path: <SRS0=m4IM=CF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37F5C433DF
	for <iommu@archiver.kernel.org>; Thu, 27 Aug 2020 04:31:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E98D20786
	for <iommu@archiver.kernel.org>; Thu, 27 Aug 2020 04:31:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E98D20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1A1FF86B24;
	Thu, 27 Aug 2020 04:31:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HPjVqLQpZgGr; Thu, 27 Aug 2020 04:31:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6ADF986B09;
	Thu, 27 Aug 2020 04:31:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F9EFC016F;
	Thu, 27 Aug 2020 04:31:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7D80C0051
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 04:31:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9A22420417
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 04:31:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FDHxwsGYMP1x for <iommu@lists.linux-foundation.org>;
 Thu, 27 Aug 2020 04:31:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by silver.osuosl.org (Postfix) with ESMTPS id C038720412
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 04:31:33 +0000 (UTC)
IronPort-SDR: ENqcoECxgie/fuAyUBL2EZnlNYhKbmF2yNNdmFkTHWLYvToKGlY0frjfcICL1c92zTJ4IRTo8S
 3pyUhDNPouLg==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="157450646"
X-IronPort-AV: E=Sophos;i="5.76,358,1592895600"; d="scan'208";a="157450646"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2020 21:31:31 -0700
IronPort-SDR: bHWjCkjSs3ij0pzEkwnq09bJzovba8n8j3KqSXNFlO05CtkIkCL9wYgGG1/K5Xryipxub56dM+
 BIQ1ZQyMey3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,358,1592895600"; d="scan'208";a="323450235"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 26 Aug 2020 21:31:30 -0700
Subject: Re: [PATCH 1/1] iommu/vt-d: Serialize IOMMU GCMD register
 modifications
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>
References: <20200826025825.2322-1-baolu.lu@linux.intel.com>
 <MWHPR11MB16457C6EC72943EF615AF2538C540@MWHPR11MB1645.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <3d7b8176-5535-26a5-a423-18de27c97424@linux.intel.com>
Date: Thu, 27 Aug 2020 12:25:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB16457C6EC72943EF615AF2538C540@MWHPR11MB1645.namprd11.prod.outlook.com>
Content-Language: en-US
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Andy Lutomirski <luto@amacapital.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

Hi Kevin,

On 8/26/20 1:29 PM, Tian, Kevin wrote:
>> From: Lu Baolu
>> Sent: Wednesday, August 26, 2020 10:58 AM
>>
>> The VT-d spec requires (10.4.4 Global Command Register, GCMD_REG
>> General
>> Description) that:
>>
>> If multiple control fields in this register need to be modified, software
>> must serialize the modifications through multiple writes to this register.
>>
>> However, in irq_remapping.c, modifications of IRE and CFI are done in one
>> write. We need to do two separate writes with STS checking after each.
>>
>> Fixes: af8d102f999a4 ("x86/intel/irq_remapping: Clean up x2apic opt-out
>> security warning mess")
>> Cc: Andy Lutomirski <luto@amacapital.net>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/irq_remapping.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/irq_remapping.c
>> b/drivers/iommu/intel/irq_remapping.c
>> index 9564d23d094f..19d7e18876fe 100644
>> --- a/drivers/iommu/intel/irq_remapping.c
>> +++ b/drivers/iommu/intel/irq_remapping.c
>> @@ -507,12 +507,16 @@ static void iommu_enable_irq_remapping(struct
>> intel_iommu *iommu)
>>
>>   	/* Enable interrupt-remapping */
>>   	iommu->gcmd |= DMA_GCMD_IRE;
>> -	iommu->gcmd &= ~DMA_GCMD_CFI;  /* Block compatibility-format
>> MSIs */
>>   	writel(iommu->gcmd, iommu->reg + DMAR_GCMD_REG);
>> -
>>   	IOMMU_WAIT_OP(iommu, DMAR_GSTS_REG,
>>   		      readl, (sts & DMA_GSTS_IRES), sts);
>>
>> +	/* Block compatibility-format MSIs */
>> +	iommu->gcmd &= ~DMA_GCMD_CFI;
>> +	writel(iommu->gcmd, iommu->reg + DMAR_GCMD_REG);
>> +	IOMMU_WAIT_OP(iommu, DMAR_GSTS_REG,
>> +		      readl, !(sts & DMA_GSTS_CFIS), sts);
>> +
> 
> Better do it only when CFI is actually enabled (by checking sts).

Yes. Make sense. Will send a new version with this changed.

Best regards,
baolu

> 
>>   	/*
>>   	 * With CFI clear in the Global Command register, we should be
>>   	 * protected from dangerous (i.e. compatibility) interrupts
>> --
>> 2.17.1
>>
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
