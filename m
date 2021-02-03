Return-Path: <SRS0=gtiV=HF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47E8C433DB
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 00:23:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14A2964E46
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 00:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A2964E46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B69E4204D4;
	Wed,  3 Feb 2021 00:23:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LUV+QVEAADU4; Wed,  3 Feb 2021 00:23:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id EA8712037E;
	Wed,  3 Feb 2021 00:23:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3493C0FA7;
	Wed,  3 Feb 2021 00:23:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2A01C013A
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 00:23:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 867EC854A0
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 00:23:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qMqL1qEaS6ie for <iommu@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 00:23:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 76E038506F
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 00:23:43 +0000 (UTC)
IronPort-SDR: j7D8of3dSI/LYJ+08G5dHltfdZcCLyO2qmCeqNg/xBy1uej7HVAAqobI7eyvngZ154nlKOuBBV
 8Hx3OeNjGmmw==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="160124221"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; d="scan'208";a="160124221"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2021 16:23:42 -0800
IronPort-SDR: 1ykg705sIja9b9AQIo1Q7F1qWP1UNi9q4rK2gxd6XTTufpFXg5thWZad1Dz+CFV7v5mOdmTVmB
 4G7fALrQa4CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; d="scan'208";a="406357919"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 02 Feb 2021 16:23:40 -0800
Subject: Re: [PATCH 1/3] iommu/vt-d: Add new enum value and structure for SATC
To: "Raj, Ashok" <ashok.raj@intel.com>
References: <20210202044057.615277-1-baolu.lu@linux.intel.com>
 <20210202044057.615277-2-baolu.lu@linux.intel.com>
 <20210202160203.GC39643@otc-nc-03>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <2d623a51-f9ed-b955-4bc0-aed5ad6a4cef@linux.intel.com>
Date: Wed, 3 Feb 2021 08:15:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210202160203.GC39643@otc-nc-03>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

Hi Ashok,

On 2/3/21 12:02 AM, Raj, Ashok wrote:
> On Tue, Feb 02, 2021 at 12:40:55PM +0800, Lu Baolu wrote:
>> From: Yian Chen <yian.chen@intel.com>
>>
>> Starting from Intel Platform VT-d v3.2, BIOS may provide new remapping
>> structure SATC for SOC integrated devices, according to section 8.8 of
>> Intel VT-d architecture specification v3.2. The SATC structure reports
>> a list of the devices that require SATC enabling via ATS capacity.
> 
> nit: s/require SATC/require ATS for normal device operation. This is a
> functional requirement that these devices will not work without OS enabling
> ATS capability.
> 

Yes. This looks clearer.

Best regards,
baolu

>>
>> This patch introduces the new enum value and structure to represent the
>> remapping information. Kernel should parse the information from the
>> reporting structure and enable ATC for the devices as needed.
>>
>> Signed-off-by: Yian Chen <yian.chen@intel.com>
>> ---
>>   include/acpi/actbl1.h | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
>> index 43549547ed3e..b7ca802b66d2 100644
>> --- a/include/acpi/actbl1.h
>> +++ b/include/acpi/actbl1.h
>> @@ -514,7 +514,8 @@ enum acpi_dmar_type {
>>   	ACPI_DMAR_TYPE_ROOT_ATS = 2,
>>   	ACPI_DMAR_TYPE_HARDWARE_AFFINITY = 3,
>>   	ACPI_DMAR_TYPE_NAMESPACE = 4,
>> -	ACPI_DMAR_TYPE_RESERVED = 5	/* 5 and greater are reserved */
>> +	ACPI_DMAR_TYPE_SATC = 5,
>> +	ACPI_DMAR_TYPE_RESERVED = 6	/* 5 and greater are reserved */
>>   };
>>   
> 
> Think Joerg spotted the comment update.
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
