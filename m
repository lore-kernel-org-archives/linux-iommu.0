Return-Path: <SRS0=kdGy=CM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AD0C433E2
	for <iommu@archiver.kernel.org>; Thu,  3 Sep 2020 08:47:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AA15206EB
	for <iommu@archiver.kernel.org>; Thu,  3 Sep 2020 08:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VaTEw8cX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA15206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 00AC286B3C;
	Thu,  3 Sep 2020 08:47:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vgsi0WO6Fac8; Thu,  3 Sep 2020 08:47:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3806186B0B;
	Thu,  3 Sep 2020 08:47:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3086DC07FF;
	Thu,  3 Sep 2020 08:47:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B3C7C0051
 for <iommu@lists.linux-foundation.org>; Thu,  3 Sep 2020 08:47:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 52E7F20498
 for <iommu@lists.linux-foundation.org>; Thu,  3 Sep 2020 08:47:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YzXIEXfY+Abe for <iommu@lists.linux-foundation.org>;
 Thu,  3 Sep 2020 08:47:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by silver.osuosl.org (Postfix) with ESMTPS id CE43720470
 for <iommu@lists.linux-foundation.org>; Thu,  3 Sep 2020 08:46:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jP41bw9LtQjToa3wqAKjeZ0tPMf7bCC2xAOF7YBjibXfzv+BxleVCu27hoShT43MOSQ3D/zK83v15TCZVaHL9iaAq3iBErPpUDH3reaL4VuXU8eF4U94ZYTxIIX6iWgRgPn7p+g55FIm9KP3LBXrgEn4bdaSXeifbk78HGWkuOmzQWj7cWATYFFJ8WKMT5eqEvaHvAoORVFsUotgSDL8cx2ctT8xAA+f3unI78jiIIBAYvNYey9YL+7ObyUfN2Hm8j58u4Scek3km6ydlzaT0KhrQiWYyfLY7j4hm9+mHV6nBz4F7yoAa/KB5FfkTm+cRmxO/JA7euPFCnqZkzPa/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flh+JB97n8qH14lYhpIkUWQmkZlgwzD7d6fgQYe/Zoo=;
 b=dXpGBvSEy2XXlZi5FOAAkVdtsN0XVsUEZiiuR0igy/UHg12OYLcXSeBlBA/J+KI2Spr+0vFxt41HWTTK+udbvWFoodUJzMlaxSkTGyaCRFi7VX2s6xh/er43N4wsoSpN9TC2RLMsWyBxS77A/VxBLDOLrw0urxH8dKQCxjXT2ugIEc22ODTHCHOe7ju9ntk7evRDr1Ac7H7fNL+NKzS+tGI+p2Z3qVyybZT4r6qu0t6IWfmEhCOUdKRm0OHM+89CklhkOBc7AVU/w+4xsZOJ3NK1TjCZ1G3hW3k+8eZmThYZDXHJH0b4eCPLR1ShAdfhHkuwD/32PzJHP1b8ypYr3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flh+JB97n8qH14lYhpIkUWQmkZlgwzD7d6fgQYe/Zoo=;
 b=VaTEw8cX1MaX9qXL1QXXItgvAR4z6b8RUri4jy5EkRdXZwaQt4rs1l7woUfPX5ZSNwhqPjG3RlohNeD298S0JPXmgJFRiju9si6PRBDNwm+SzA6unr5Fd7qrcFyF439skmNLV6aXTdV9zrQxOu6Vr/cogqDg1ewB3/mb97tgSfU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM6PR12MB3274.namprd12.prod.outlook.com (2603:10b6:5:182::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.22; Thu, 3 Sep 2020 08:14:22 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::cc8d:7537:ec56:108e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::cc8d:7537:ec56:108e%11]) with mapi id 15.20.3326.025; Thu, 3 Sep 2020
 08:14:22 +0000
Subject: Re: [PATCH 2/2] iommu: amd: Use cmpxchg_double() when updating
 128-bit IRTE
To: Joao Martins <joao.m.martins@oracle.com>
References: <20200902045110.4679-1-suravee.suthikulpanit@amd.com>
 <20200902045110.4679-3-suravee.suthikulpanit@amd.com>
 <6f65bd13-08fc-45d9-8e80-b64499f010e0@oracle.com>
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <010b1461-654e-e055-97f4-f80f0c8fce65@amd.com>
Date: Thu, 3 Sep 2020 15:14:10 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
In-Reply-To: <6f65bd13-08fc-45d9-8e80-b64499f010e0@oracle.com>
Content-Language: en-US
X-ClientProxiedBy: SG2PR0601CA0011.apcprd06.prod.outlook.com (2603:1096:3::21)
 To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 SG2PR0601CA0011.apcprd06.prod.outlook.com (2603:1096:3::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15 via Frontend Transport; Thu, 3 Sep 2020 08:14:18 +0000
X-Originating-IP: [223.24.160.83]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3612101a-e1e2-4017-d4f6-08d84fe15d44
X-MS-TrafficTypeDiagnostic: DM6PR12MB3274:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3274B6016379CA8452BEBAABF32C0@DM6PR12MB3274.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oB08zw/b0uBzusmHvrPJ9nX4LTRIZZbwORuROB+Is66Ne2e1zqsF0yneMiiKU5tQOwfZaZUFl9WwKo/mGr6THnSf3mkbeP6yLWApu/rh2gDxMqErp8lsQyZLGHRER6DjjOHsVAjin9WpMWuh5HhO6DpjCym2bpFhqRC+JQ6sfTAiEcEbJHPBiq7f7J3sv0tdzMstFNviZgfb0UuxTNefTw/Kcb0a39cIbReq2ZccLDBF/0fjLEWIGHlIPH3qzrGmMO6vrIk5gTfhQRMfnoVZ+jWpNv3LwhxmeKxhwaYzNT62VwiqkjFGhQOOfI2Ar0N2cKXg5Z3582EXWopGInD/nblYKIjH9SbJlQOXRReNYVJtSlfXtla11o5QX2Fwplhd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(66946007)(478600001)(31696002)(5660300002)(8676002)(26005)(4326008)(2906002)(8936002)(66476007)(31686004)(52116002)(6916009)(186003)(66556008)(53546011)(2616005)(6486002)(44832011)(86362001)(83380400001)(16576012)(36756003)(956004)(316002)(6666004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 97RN7yJLN5mLuATyVULFKC3oNigHOhlDduwN+Wrs9ifNze/72LuQvrzETg/JhVz04fx11NWYZjugSSgqJHBEyoLXrV7cFR9MKjnYk4hoipXdheNYYxYNCMD0tBjlVQHIXRQSu5xyrEHjy0lyhASPHDaqmx1KHKfyZrCId+wwZR+Q3oXH+j2DsEPC+iHcrcQjtALs3Kks62iKYxqcJk9xBhO2LzY7aHUOzzyE09ihZ46eJJpK4nl1wpx0zpV5bChqfFT0VQc3lE46UHs/CXgnAi+k82sD3N5d7XrWODAB5PSFLx+wrLY24lP5lR+7OSgxF22QtxamBDUQI64bc4XLHaxQ14jSjqEIMTAJgbAQjNZlXywOau68a3dXjWgMElbDYjdg4t8b3y/dmYx7QBT/kwJYSlCmfdkL1m5WkhdhIXpi3OC8ht1pekSIG738J6RrSGQujAIBwOxffTCSKuKoYjHkmukvyD9ac7WjdWIsVlLyUTK1YsZngsUctR2IzduhB5WBGwqm4/Tq3v/EZyO9n1Oi1i2LZw9pVUS1aZcguwPqPy31ph0m09CxygB6RlJPfyq92YM1ojNbw4D/GQA2cz5jBr26HVF7yT0oWd2ZF45EG/YZC8JCXFuTVRcWcDhdvCXmelWhE76L59vp2+S71w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3612101a-e1e2-4017-d4f6-08d84fe15d44
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 08:14:22.6891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bC+JirMnSEzDZVLdDi2CZdvflDtZfge3LZNx5C/B3gRsj18kbjd3vrIjwo4ArI8bsG1p9Hx406K5FRxUbvTbbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3274
Cc: jon.grimm@amd.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, james.puthukattukaran@oracle.com,
 boris.ostrovsky@oracle.com, sean.m.osborne@oracle.com
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

Hi,

I'll send out V2 with fixes to the review comments below ...

On 9/2/20 10:26 PM, Joao Martins wrote:
> On 9/2/20 5:51 AM, Suravee Suthikulpanit wrote:
>> When using 128-bit interrupt-remapping table entry (IRTE) (a.k.a GA mode),
>> current driver disables interrupt remapping when it updates the IRTE
>> so that the upper and lower 64-bit values can be updated safely.
>>
>> However, this creates a small window, where the interrupt could
>> arrive and result in IO_PAGE_FAULT (for interrupt) as shown below.
>>
>>    IOMMU Driver            Device IRQ
>>    ============            ===========
>>    irte.RemapEn=0
>>         ...
>>     change IRTE            IRQ from device ==> IO_PAGE_FAULT !!
>>         ...
>>    irte.RemapEn=1
>>
>> This scenario has been observed when changing irq affinity on a system
>> running I/O-intensive workload, in which the destination APIC ID
>> in the IRTE is updated.
>>
>> Instead, use cmpxchg_double() to update the 128-bit IRTE at once without
>> disabling the interrupt remapping. However, this means several features,
>> which require GA (128-bit IRTE) support will also be affected if cmpxchg16b
>> is not supported (which is unprecedented for AMD processors w/ IOMMU).
>>
> Probably requires:
> 
>   Fixes: 880ac60e2538 ("iommu/amd: Introduce interrupt remapping ops structure")
> 

Yes, I will include this in V2.

> 
>> Reported-by: Sean Osborne <sean.m.osborne@oracle.com>
>> Tested-by: Erik Rockstrom <erik.rockstrom@oracle.com>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> With the comments below addressed, FWIW:
> 
>   Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
> 
>> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
>> index c652f16eb702..ad30467f6930 100644
>> --- a/drivers/iommu/amd/init.c
>> +++ b/drivers/iommu/amd/init.c
>> @@ -1511,7 +1511,14 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
>>   			iommu->mmio_phys_end = MMIO_REG_END_OFFSET;
>>   		else
>>   			iommu->mmio_phys_end = MMIO_CNTR_CONF_OFFSET;
>> -		if (((h->efr_attr & (0x1 << IOMMU_FEAT_GASUP_SHIFT)) == 0))
>> +
>> +		/*
>> +		 * Note: GA (128-bit IRTE) mode requires cmpxchg16b supports.
>> +		 * GAM also requires GA mode. Therefore, we need to
>> +		 * check cmbxchg16b support before enabling it.
>> +		 */
> 
> s/cmbxchg16b/cmpxchg16b
> 
>> +		if (!boot_cpu_has(X86_FEATURE_CX16) ||
>> +		    ((h->efr_attr & (0x1 << IOMMU_FEAT_GASUP_SHIFT)) == 0))
>>   			amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY;
>>   		break;
>>   	case 0x11:
>> @@ -1520,8 +1527,18 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
>>   			iommu->mmio_phys_end = MMIO_REG_END_OFFSET;
>>   		else
>>   			iommu->mmio_phys_end = MMIO_CNTR_CONF_OFFSET;
>> -		if (((h->efr_reg & (0x1 << IOMMU_EFR_GASUP_SHIFT)) == 0))
>> +
>> +		/*
>> +		 * Note: GA (128-bit IRTE) mode requires cmpxchg16b supports.
>> +		 * XT, GAM also requires GA mode. Therefore, we need to
>> +		 * check cmbxchg16b support before enabling them.
> 
> s/cmbxchg16b/cmpxchg16b
> 
>> +		 */
>> +		if (boot_cpu_has(X86_FEATURE_CX16) ||
> 
> You probably want !boot_cpu_has(X86_FEATURE_CX16) ?

.... Ah, sorry!! I forgot to change it back after testing for the negative case. Thank you for catching this.

Suravee

> 
>> +		    ((h->efr_reg & (0x1 << IOMMU_EFR_GASUP_SHIFT)) == 0)) {
>>   			amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY;
>> +			break;
>> +		}
>> +
>>   		/*
>>   		 * Note: Since iommu_update_intcapxt() leverages
>>   		 * the IOMMU MMIO access to MSI capability block registers
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
