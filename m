Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C40A5C433F5
	for <iommu@archiver.kernel.org>; Mon, 28 Mar 2022 09:28:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6106540249;
	Mon, 28 Mar 2022 09:28:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MIV53VtxoRv9; Mon, 28 Mar 2022 09:28:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 37B4B408BB;
	Mon, 28 Mar 2022 09:28:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3C37C001D;
	Mon, 28 Mar 2022 09:28:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F69FC0012
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 09:28:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 77AE6813F0
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 09:28:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GpICd5jkuYTv for <iommu@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 09:28:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::609])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0E525813E1
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 09:28:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7QYMMWkOI8gScj6l+/IpOww3hC+F3VcmtAak9BwEA19XxgODvPPTv/68FTtWMjzMEOeuh1f6CAmZ24ehGuub8hE1Fj2EqmpiviMJ749Uz69/XzeZ//U8I/df6J2y7k5xxkj8sfomM4XKR/OPZR7ZmxsWmK0aka2h9C+XQ1hdv93KwDpa/C4of7JzCiZAUWeHqJA4SgZokqbRqMTypQR0rrKXF7V5lfXG8KE+B/NHVUHP+9W1lLMPe18A6KpGpczZXsFifdqC4kugcj15z6w32rdjhI/w7tpTWnHMqiPorLi8uuYpzL01jHUKZG3wL/kdQ4tMnfAbRg/udWgxdYhtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8kAC+TH9H8oGur2JVk9YxBEyMmkdeKFTQPj4oA/5Ls=;
 b=BBCOkH3AiTOaWUOQbv1/04hutnkiKKxaGu+8a0CuiNl8Butlm+/a5GmYC1QwrvLfOHGJdGvk/BA7Hstx2iBthKcCWu1ivlB2T6+EsOyPGR1WZ9U9YjIHQ7QKlOT22+rzulFk6PgBg/jUE0VEYx5xyu3kMdVoy6DIShnRTWnWkJMe73YDTqXe9OLsgrBZe45H9qP0si080MNhrAXTAtHVURd22BzqCJWX9xB2yk8nT5VaYpnMSOIMuvfZk1bLkY0KePMBT9tXacZyhDzzeAvH3d2NBKmJtfg4VoRiRVEdThNta/NN/khoUo5ovvfMEkVeaaZhz1AHBhH0FUdKWfxlLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8kAC+TH9H8oGur2JVk9YxBEyMmkdeKFTQPj4oA/5Ls=;
 b=YSD83GhqYReA8GbuaQQa2IFDVUdostWUaoZIoQVdJ0CPOkrpJWAbeSuCwPAAMATxpxX0BFHoAtCu8YXSGdxaoKFqIwYhLXDOV1rq8QEn2npOTQWSfrzxhG/jSyFmfCi79zNUQ7r4chvfVABiSHN5cvb6lg8af+Z4Y5e8hv30pLQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2906.namprd12.prod.outlook.com (2603:10b6:5:15f::20)
 by MN2PR12MB2877.namprd12.prod.outlook.com (2603:10b6:208:ae::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Mon, 28 Mar
 2022 09:28:41 +0000
Received: from DM6PR12MB2906.namprd12.prod.outlook.com
 ([fe80::81cf:b33a:6316:1e94]) by DM6PR12MB2906.namprd12.prod.outlook.com
 ([fe80::81cf:b33a:6316:1e94%4]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 09:28:40 +0000
Message-ID: <8db6b69f-7a33-359c-db74-35df7c115010@amd.com>
Date: Mon, 28 Mar 2022 14:58:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] iommu/amd: Remove redundant check
Content-Language: en-US
To: iommu@lists.linux-foundation.org, joro@8bytes.org
References: <20220314070226.40641-1-vasant.hegde@amd.com>
In-Reply-To: <20220314070226.40641-1-vasant.hegde@amd.com>
X-ClientProxiedBy: PN2PR01CA0008.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::13) To DM6PR12MB2906.namprd12.prod.outlook.com
 (2603:10b6:5:15f::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37492b33-6db6-4793-25df-08da109d5866
X-MS-TrafficTypeDiagnostic: MN2PR12MB2877:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB28774A71D36349A5E4E04817871D9@MN2PR12MB2877.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PDD7WHqqB8yBPY4dw+odpLIWokwSIgdDYppu9KLDnxa2DUs6Ywd8R3XOl+SoYir4hWrGlG0ryhujGcavXhj9Dl5DpoAT7C0E3wrZEQTk6buY2tBZc/fO1i1REFupjzom1kcKlI9BHUYxWTPMBLw4o/JS8fNIlGqDBzLkkJQXzOxE7QFgAj1TGFGbSIc4BG9NbWETeQodgVfEERLva8c30WL1eiFQYBNolBtvubOKu0oRQVFwzt8XLjoQz8iiR2kvUs1h4FnxRckeFCfnwH0astGKTFQv/7PadJOF27P+vLnV61Hg8Y/GoAjnuNykfEcClTvzE35a83ag8g7fkk468/g7Yv6Fb0Tz634/NkImY0BfOtbLuUSJ8a0oC/lN8eyvCVapNLZjdlFRvtFGbiuqu9i2+lGvahYvvvXiIoqCw8GYfJ/ld6xF/ZENk0IQZXimVAhPAkG29tEwNAmyHekZ2TesDCS+r/6pJr12sMM35oC/SU3t76jEElQ039pfBQ+/OgSUedeppVBSvUrN9VxB8qvNYQV+SqO0ET0s19XFVgFrhhoVoxBqYd3uPwj1MWiBWIVMCCGqTsfd8RVRKSRQf+n7ngVR7hgot30hdrtU21cuR6CyjPGXT8vGPMhMEw2VHC+gObtmPIHaX7T2tu8adf3jxDQegrokxtiJYx7JWPyMYFK//kpDVu0n6Vf4VhPuMtPLV5LX+XCe4+cR4R+5TofB5a1++8HKlG8wHEx/xeQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2906.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31686004)(66556008)(6486002)(8676002)(66476007)(66946007)(36756003)(4326008)(8936002)(2906002)(5660300002)(316002)(4744005)(44832011)(6506007)(6512007)(508600001)(2616005)(26005)(38100700002)(186003)(86362001)(53546011)(83380400001)(6666004)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2hDNEg4ZDhnMDZrQVlzbWZxTFQzYkdHWUFrWXRBYVZVb0xKcktQNjUvdVc4?=
 =?utf-8?B?S1V2RHJsWWhQakkrdjczOHpSRG03aGU5cXYyam15TG5iUElnTlFMd3dNZnhh?=
 =?utf-8?B?Z2lSdzcwVXVxT3JIeHhsQVhLZ0xoejhhbDFnMjZZdjJMN2VycmoxUXZPVWpT?=
 =?utf-8?B?OWw5Z3pDZG5PTVR5Y3BnVlNJTDNLVTZSWFp5dnlPdnJCTzlyMFBGSXVQMTM1?=
 =?utf-8?B?SmsxVDlHdy9SdzNSUkRzV0ZhZkI0NStObHBFUCtNa3M3Z25FcXd0c2lQRkVy?=
 =?utf-8?B?bnkvTTZFakV3L29FVWZpamMyd2EzMDMzUWRteFJ0TG1YRllzZzdzdFhSUzQr?=
 =?utf-8?B?ZXNFQVNDR1lwbEtXNWY2UmtJU0tXQmhieFZQeUVwNUwxREVIdzd0TG9YbnRN?=
 =?utf-8?B?bEh4Y093dEFhbkptWDNxTXlBV2FtT2hsdHNCbjI3NnZTNTNzVm5ORHpKaklW?=
 =?utf-8?B?U3QybnZOa1JGaldOVkpuTlJORFBMdFp6ZlB4TS9VK3NRTGhOck9wMXFUR1c2?=
 =?utf-8?B?NVUzb01QMHNoRCtNYWdVQWRJUUVCYUFNS2RDN0NaRkp5RDlHT2RHVThNV1RF?=
 =?utf-8?B?THV3TGxkTWlsZm5Bd1l3Nm8xRzdvOWNzZzdGbVNrOXBvK25aVDBUcHV6ckVw?=
 =?utf-8?B?eWtsSGw0TTU0NmJRTFh2cEl2ZWdWQlp1c3ZmZmJHdmZsZTUwWUY1c0JwdHlN?=
 =?utf-8?B?NFV4Vmg0ZlQvYVkxUk1DZ0h3SHcrT3NocU9WMVd0Vk5JbmRqUWgvNUFIYXZM?=
 =?utf-8?B?M2lVekt5TnN0YWdYN3MxamExMU9zYWpqWTNaZVkxRDg4UG5IaHRGNDk4Nlha?=
 =?utf-8?B?NXBZbG40Q1dZWUtDNmlMNzl5MmhKdkY4enJpeXp4dTVIY2phM0ZXVGhzR0ZB?=
 =?utf-8?B?K0tLNTM3YWRtcEszVm1HNWV1TkFYdVJBeHV4QnB4R2dlL3lIditjcTJXNmRi?=
 =?utf-8?B?R0NQRUxBeUtnWGZPZmMvaFc3WEYxZFNTZjMwYnM5ZE5UakYzWktsWnlKaWRw?=
 =?utf-8?B?RU5PWTFpUXI5a05vaXhHaXlVTktTbWM5Ti94WHRFc010S3BTbnRwWFExNDR0?=
 =?utf-8?B?M0N2bnUzVjU0Uy94a2FENWJIVFNhRVo1bFVTYWN4bHp5WFFNR0V6bDRiYy91?=
 =?utf-8?B?Q0d6ckNJRkhPZHdiNnRkRnpiRmxxejNjNmhMQVp0d09wR25VbnU3NWp5Nm1E?=
 =?utf-8?B?MGZmMStrdTVHdWRyYmY3S0Znc3dHV2NVUVRlYWxSUEVTdDFORWlYRVRobjdp?=
 =?utf-8?B?Zi9KTHZYOW1XMVNtbW5HaEVXT2VaMkNVYkd0OWFscXJPdEN5Y0VvbTBwT09n?=
 =?utf-8?B?OURaN2xvZXJRR01xK0UrYVJVYi9XSm15ZWlBQzhhSEdvZEhKYXM0Y21QdlpM?=
 =?utf-8?B?OWhqUVR5ZDROK0hVcHdiR2kxZjkreDNzallBdUVlK2RWdHY2NkR3OTZjOXRq?=
 =?utf-8?B?QW9OMGhnS3FaYTJSaXVTSE5VTkhhZ1JrZVlzMTBQbjYxZXZlMG9zdk1uakhJ?=
 =?utf-8?B?YXJDc1RyWmROeUJsSkpWc2xLREp3REZvQlNNbm1UQXRYNjZXRlVheEZMeExG?=
 =?utf-8?B?SFhmVDIyOVB4M01JMkY0alFWS0psa3FVUTRIZkJLV05kRWFxbW9ib0NzQmgw?=
 =?utf-8?B?NTc4MDUxWGxJQ2xtWWgzZGsyem1ScXgyNmxSdmUrNllJQTFqSUpURjhlOVFl?=
 =?utf-8?B?UFpic1YvdGNCU1d1TTF1TXppZFp3ekIyK1dWd0dsK2JKU2hIZmdycHFacHhk?=
 =?utf-8?B?T3NleGExaWNoU3U5bVd6a3FRN1lJZTA2a2FpS2RmU1hsRk03b1djNmZpQWZv?=
 =?utf-8?B?dkJPOExDRUJjT0xkc3U3MWo0Vllnc3BEYUk5SkNaOFN3SDRQOVB1VDlZcWtP?=
 =?utf-8?B?S0w0M1g2SFB1VFdZNnZQekxUL0JwT3c5cTVhUXREZUhkcUp1cDlwV2VtTlY4?=
 =?utf-8?B?VjlIb1d5VG52bXV5V2VYUmlwRVU4U2E3VUhUVXBEckNsV2NaWGhwenkvWEp4?=
 =?utf-8?B?a1JJSzFYQkxYbWVLT0NwSTNicTUrWkRMRUdOWGxVTUNyK3dvLytYTXpLUm02?=
 =?utf-8?B?YlVCOWU0NXlnNUhJTjdPTEFBS1lrRWNIcWt1cDU0SWs5SkVXMjVBclZvcmQ1?=
 =?utf-8?B?OE0zV2FNS2V3cTltVSswazdZMGZwWE1GZGM1d0w5MnJyMXo2Q0tCVC94c0Na?=
 =?utf-8?B?R2hpQ2hEelRIbGVFNk9mME5yQUEva0d1MXI5dUNaWXNiQXBQSGtZS0FDYktn?=
 =?utf-8?B?RXlPV1dJNTBidDZlL2l5d1JnUzJLY3ZncTMrK3ljWngwUFd6K1FvS2JKdEFv?=
 =?utf-8?B?MUpNbUpYMDNTNURYUzQzZkhBMThvdXh3L3FNS3BQVWJ0NFJUZzBBUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37492b33-6db6-4793-25df-08da109d5866
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2906.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 09:28:40.8470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0/7OEB/B+lQz6Dkdb1a7yCtUvG1L1aupB/G4LkcmecyOcXguGL2s37fV/JwzVyginkL7VIo5HbAaRPNscgBEGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2877
Cc: Dan Carpenter <dan.carpenter@oracle.com>
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
From: Vasant Hegde via iommu <iommu@lists.linux-foundation.org>
Reply-To: Vasant Hegde <vasant.hegde@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Joerg,

Ping.

-Vasant

On 3/14/2022 12:32 PM, Vasant Hegde via iommu wrote:
> smatch static checker warning:
>   drivers/iommu/amd/init.c:1989 amd_iommu_init_pci()
>   warn: duplicate check 'ret' (previous on line 1978)
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Fixes: 06687a03805e ("iommu/amd: Improve error handling for amd_iommu_init_pci")
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/init.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 2586e589e54e..8ed1f86fe93d 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -2137,8 +2137,7 @@ static int __init amd_iommu_init_pci(void)
>  	for_each_iommu(iommu)
>  		iommu_flush_all_caches(iommu);
>  
> -	if (!ret)
> -		print_iommu_info();
> +	print_iommu_info();
>  
>  out:
>  	return ret;

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
