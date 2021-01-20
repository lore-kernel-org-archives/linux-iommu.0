Return-Path: <SRS0=mF+O=GX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA125C433DB
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 11:37:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D99423332
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 11:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D99423332
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D2F0887053;
	Wed, 20 Jan 2021 11:37:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hMJhVvBjoerK; Wed, 20 Jan 2021 11:37:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 190AE87030;
	Wed, 20 Jan 2021 11:37:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01BB0C088B;
	Wed, 20 Jan 2021 11:37:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3465C013A
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 11:37:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A70DA869A0
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 11:37:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ld-oyGFfQgBq for <iommu@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 11:37:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E37598699C
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 11:37:26 +0000 (UTC)
IronPort-SDR: 81AzR8iOFrGGbrHvP+tEmwHU6Kfw3MT5QnrbCI4pZljn1AAvitQqzxf52qb2Mri24PFmtkkea/
 I/tRXjaPVARA==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="179175629"
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400"; d="scan'208";a="179175629"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2021 03:37:26 -0800
IronPort-SDR: kOe5SkhmWI0NpMJD54sdRoIxoQl/vkoATl0cSlePpD6jvPJ8aouVK7fhyyFL+4xm1DCTFjg+XG
 P/R8PpWrrbLw==
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400"; d="scan'208";a="384807052"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.255.30.217])
 ([10.255.30.217])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2021 03:37:23 -0800
To: "Zhang, Tina" <tina.zhang@intel.com>
References: <20210119182526.2927-1-tina.zhang@intel.com>
 <d084772f-6364-34d9-1c89-e1c3d6a35301@linux.intel.com>
 <BN7PR11MB278667C5A166460CE7CBBD4889A20@BN7PR11MB2786.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH] iommu/vt-d: debugfs: Check irq_remapping_cap before PI
 info dump
Message-ID: <9edd348d-71ae-a061-4a98-8267941b449f@linux.intel.com>
Date: Wed, 20 Jan 2021 19:37:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <BN7PR11MB278667C5A166460CE7CBBD4889A20@BN7PR11MB2786.namprd11.prod.outlook.com>
Content-Language: en-US
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Sun,
 Yi" <yi.sun@intel.com>
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

On 2021/1/20 16:41, Zhang, Tina wrote:
> 
> 
>> -----Original Message-----
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Wednesday, January 20, 2021 10:35 AM
>> To: Zhang, Tina <tina.zhang@intel.com>
>> Cc: baolu.lu@linux.intel.com; iommu@lists.linux-foundation.org; Joerg
>> Roedel <joro@8bytes.org>; Mehta, Sohil <sohil.mehta@intel.com>; Jacob
>> Pan <jacob.jun.pan@linux.intel.com>; Sun, Yi <yi.sun@intel.com>
>> Subject: Re: [PATCH] iommu/vt-d: debugfs: Check irq_remapping_cap before
>> PI info dump
>>
>> On 1/20/21 2:25 AM, Tina Zhang wrote:
>>> irq_remapping_cap() was introduced to detect whether irq remapping
>>> supports new features, such as VT-d Posted-Interrupts", according to
>>> commit 959c870f7305 ("iommu, x86: Provide irq_remapping_cap()
>> interface").
>>>
>>> The VT-d Posted-Interrupts support can be disabled by the command line
>>> parameter "intremap=nopost".
>>>
>>> So, it's better to use irq_remapping_cap() to check if the VT-d
>>> Posted-Interrupts is enabled before any Posted Interrupt Descriptor
>>> info dump.
>>>
>>> Cc: Lu Baolu <baolu.lu@linux.intel.com>
>>> Cc: Joerg Roedel <joro@8bytes.org>
>>> Cc: Sohil Mehta <sohil.mehta@intel.com>
>>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>> Reported-by: Yi Sun <yi.sun@intel.com>
>>> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
>>> ---
>>>    drivers/iommu/intel/debugfs.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iommu/intel/debugfs.c
>>> b/drivers/iommu/intel/debugfs.c index efea7f02abd9..87a4a76866f4
>>> 100644
>>> --- a/drivers/iommu/intel/debugfs.c
>>> +++ b/drivers/iommu/intel/debugfs.c
>>> @@ -516,7 +516,8 @@ static int ir_translation_struct_show(struct seq_file
>> *m, void *unused)
>>>    	seq_puts(m, "****\n\n");
>>>
>>>    	for_each_active_iommu(iommu, drhd) {
>>> -		if (!cap_pi_support(iommu->cap))
>>> +		if (!irq_remapping_cap(IRQ_POSTING_CAP) ||
>>> +		    !cap_pi_support(iommu->cap))
>>
>> With irq_remapping_cap(IRQ_POSTING_CAP), do you still need
>> cap_pi_support(iommu->cap)?
> 
> I guess yes. The "iommu->cap" value comes from the iommu reg. Current code seems to use cap_pi_suport() to check if the iommu hardware supports PI capability, meanwhile using irq_remapping_cap() to see if the vt-d PI support is enabled by user.
> 
> So, the problem here is if a user explicitly disables the vt-d PI support by "intremap=nopost", it would be very confused that the PI descriptor related info can still get dump.

I don't worry about dump hardware data even it's not enabled. But I do
care that the table is not allocated (due to not enabled) but the code
still tries to dump it, hence result in some kinds of NULL pointer or
wild pointer referencing.

Best regards,
baolu

> 
> Thanks,
> Tina
> 
>>
>>>    			continue;
>>>
>>>    		seq_printf(m, "Posted Interrupt supported on
>> IOMMU: %s\n",
>>>
>>
>> Best regards,
>> baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
