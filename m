Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794743789;
	b=H10wM3CvCG12+ggeQcWd9kv1gYEfCAtfh4ukvwoFx5ItlhwZdUtgwm/RENjrXWT/Gx6R
	 FaePL8pc92xjRxYfS8GgPk24uszC6/9P3R+EiqkdZJhi4xQdVi6pIDcmxODxmJ5wVFdX0
	 EOkeU5kuF63v1RKKFFqWu5fdZ4oKxGLTHkmOUUEwC/FUXaP4Oivj9zUiVmDMTrw7gs+Bl
	 kgmj6z+dKEJENFsRCig5AtI7ZousSTJKXm6l1XpYmWRxK3p96G52B2c5exLbzJwaUrnrP
	 orz/Gl9PphAenQq7njhlEUiOmm1erGUC8NdxRWPlJLlGSnEPheqAfFbhvCKJZtOraVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794743789;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=AGwsqKtd5TiwVVaDum3UgmVwjw2eTki0kyDOuC6K/K4=;
	b=1mNLQstQHCP0x/hljoWbvBmmtSZwkiNkaxNB0Sbs8niW7ZjKeCpS93XNOVudUdKrjt1E
	 8AJ/luECxIwnIAfMtNoJoDhr/eUdebwy865OhXKITo8MhdNngMonwKQPu4LtvsYram1Jw
	 4zVfpBAu9iU+X26i5p9F3Gf4KQxxpLkIW0HbU5jIkAI37+ZGa39xrcGbSFBDCY7h5WCKJ
	 7RSQKcKB6JDMuRembkgXMOHJSuZUHm7Zu68Q4KBwfwD/83/2y3f4BQMmuGld7rS5s1C7N
	 OEU8NKSHGTY1zCn8X7Wj1zBYl9U9AZEsRo6lPswTBR/428s2fSPeUamgAMYQCLX6GqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DxfdtQ27;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.37
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010037.outbound.protection.outlook.com [52.101.201.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C33606A329
	for <iommu@lists.linux.dev>; Sun, 15 Nov 2026 11:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28C33606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DxfdtQ27
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IB9cs0g1+aJ7qz4kg2Em13HOCG9X1oYMmOCm7H7X88dD29kyUOJ0ZVjQLrVI+Oz+6qOaF3m9zmF0JT3PKb53ZLwMlZ36FtCWVY4DRtzyWAwrr31/f8BIKLLkL4261XD1MbKPP2Ud+BWtmjUQy8oRlIAh2KMyNoYWB5VhJh7197iXqTDj4hVH9ezyQPA+0v+ojDUhZt1hepF2uMJDc9KcW4B978VVpupJEROwYJi3u3Tj/eIufL/rDckOrRkUd74c5RPw9HX2zfNA4azN/YzHMibkKGcovkTFPoWRQPEymsmnJvRvzZH5CpFAdKxhUPzHbN+C1YXvgRZOVNfAM9zNIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGwsqKtd5TiwVVaDum3UgmVwjw2eTki0kyDOuC6K/K4=;
 b=p3exC5tp6+6E11M28gguSDB2zh9OSdoXn74VnSNwBsAv81h9PKkOGOOKjPYxqYP/YhvjwalItl5nuFsz6TIZzaRX9Y9D1wwaFsyyMYCOIAAOiqwgOO/5FJpTwBaWuGRWsx5XjK50GUZbrVQV3ORv+Hg72nsRNAxh5QFbwZg4aiY5GQ1HsTn9eeSbmYqJ1SCSwNrTDp7RiXGinQ4z2It0yt1lJC5rC1Sw7EZxo1YKpgzIgLXAvrKgXpVuMbpqqZA4xQ6YZD6vUTsyDf5UvaqXLDo1pTLWPuIxKyOIo/CQ+NWz339FENaNBkUBnOOfQUdBE5xCABRq9rnDVqIlw8/mOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGwsqKtd5TiwVVaDum3UgmVwjw2eTki0kyDOuC6K/K4=;
 b=DxfdtQ27ixbIY5SiEYC8uP/xI2GlhgbM4oPSiQdWCZ0WK07swMXqj4M56AmVQMgC4RCWB3tXrlwZKOTvY6jA8fGB7/Y/S+N8Lx9jBDzrbxII+CzAYeuhZvD5+ZpylEOsXh8nDibrFMZW+r6rY1SZRq+dC1xIbks5lxU9Pw+8BqM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by DS0PR12MB7728.namprd12.prod.outlook.com (2603:10b6:8:13a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Sun, 15 Nov
 2026 11:56:23 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0615.009; Sun, 15 Nov 2026
 11:56:23 +0000
Message-ID: <8af27dcd-72b6-4a16-875a-057d369450b6@amd.com>
Date: Sun, 15 Nov 2026 17:26:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] AMD IOMMU v2 failures on Cezanne; page-table
 flushing helps
To: Nathan Blomquist <nblomquist@gmail.com>, joro@8bytes.org
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com
References: <CACOV87VBwH+R3eSBEOuz8hk7OaT63+A9m6ipPSW5wt1VhHMFPg@mail.gmail.com>
 <CACOV87WpRNEo=7ckZBdcmGnZ17c3w5qPOe5jY9ZJUdr6y_DAVw@mail.gmail.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <CACOV87WpRNEo=7ckZBdcmGnZ17c3w5qPOe5jY9ZJUdr6y_DAVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0238.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f4::19) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|DS0PR12MB7728:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e900ca-de45-4537-ca4e-08df430f7820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10067099003|5023799004|11063799006|4143699003|56012099006|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	RhkEzeXumZVU+tNYQt9DIMEnPN3mfFUPtg7B2fUVujBYRW/IOqXWYFM06nEqYcJGwkGGzSH8ph9uHUKA4u56m8zzpMNXtsG7s/c1DcWI8U9r5u8VI3Ais+NXSXerTlEnl0/Z+IlXaovIYSyu7GqdYGkKtGKd94GdPMFQtAPYDSCsT2+I2/u2kkALgL08myroru0+jO8nYziv9h0rznbSn0c3sPT7ShtVi80ysqLpCDCdZhRe+Y9ynOET8d/HhcVr4sg1h9+Xsv/2FZGSQnkFg4AHKTrRccbDnGusoELFhtRC8CA/W4W9ZLyl6cgNc7hHndhWWneYE+PYEy9g9QStGYIb4ad0KwT8QmlcT9Io/G3E8VrWe5VdxXuaAMvi6zVszzYVdcGlmusddap2cxDv/QxKSRZLao7vKwdD8GzwZoVQyA7Tq8W/aVyK/rjCqgFjQnxKSVHshEJYQhX7PMysv5iA4UvdQIcmeji/TbDCWmxI5lay0q4IkIGroQI6OnpE0DyFEh9CryymtWuRad89isqrsydtC0luc1tft4bWSRKoe8mOlgqiZmRMIso61QEr8mbs4F93jnROsgXq1E52hc8HI3WenRJ6uvfaXNdkPZVt89YuOdsztmvd9Sg4T6m0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(5023799004)(11063799006)(4143699003)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2VMZEF2dlVIanFVd2Z2M0VuMWFpZzNEc0FwMzVoZUdkM1ZNREdHU2ZEU0NY?=
 =?utf-8?B?Rkw4aGhEVHFkeG9FRDV1U010L1JtM3AzRnZTck9ieW55SDBTR2I1WTdvamxo?=
 =?utf-8?B?M2VLRGxTbUJLMUI2Q2t3VmtsbmoxdENyTnB2TkJjS0duRFRaNnMyeWdGd3V4?=
 =?utf-8?B?Um1icjZFYkY5Zi9VSHJSaWRrVnJNc0tFL3ZqZnJrWC9QejE2dXQyRUtXT0lO?=
 =?utf-8?B?clJnMkhFNGVzYXpHa1Q0UERNclZzT3hkc09BazZQRENNZGZwR0pFNWlOUUI5?=
 =?utf-8?B?MEJvSlpuSUNRRmE3akFLRFFpMUk2UUJZQkxvTmhMSFB2YU5GVXZ0UkJOWGdG?=
 =?utf-8?B?N09YUFVRaUVqa1ZwQ3FTdXk4OWhDMWZobUdDYlBtZktDVU1HSFNrRDZJaWdB?=
 =?utf-8?B?Y21OY1U1ZkZFeTBwM0tpVWM5OWRaMm5maHRVRmlIOXhyRXVleFpuUFlwZHB4?=
 =?utf-8?B?aHY5UkY4TXA1UFZrNExHS2NLMmpwZHI4QU5KbXlUbXJGdy9yMHpqaXpMOFNy?=
 =?utf-8?B?Ky9RWE5md000MCt5K0Y5Q2xsSlprVmdoV2V5bllLR0FjQTNycTBTSytxMlcv?=
 =?utf-8?B?OS9hUGhsS1pUZy9HMjlqWDd1SHRSa2NuMjJpRDVVTWYyYkxSTHpQaXRiOUhH?=
 =?utf-8?B?K2cvL1g2cTg1RWExMDQ0cnMwcTNVY29DbzlwMWw0OG5kU2xlUTROZjhGV2tq?=
 =?utf-8?B?eUxJQXFibDFTRDdyRzNnN1puMFlEd0hneVpOclJPODRucEx1a3FVYnNyQ2FV?=
 =?utf-8?B?dEZES0NFTGVuaUlEY0xFaUVtYzRDbUIzMnRsbmtJUFpKak5VbjZmcHJJY080?=
 =?utf-8?B?eThHbzladWxuOGttc3VRaDgyZXppbS9NOW1qZUdOdUdJL3dHU29nSlArb2hp?=
 =?utf-8?B?enN5WmR0QURTSzJMamJJSkYrRmtCNUhzYW9xdnM3UWFManBuUHl2TldrSnZT?=
 =?utf-8?B?QXEwNGFvZlljeEh5QmR6YWlrVnNYcnpJWk02b3NKNlpBQmk0MkU3ak5QWXFm?=
 =?utf-8?B?WDlxWEIrRitUdTUzYUpGUlpzUWc2anErc0g2YXl1MVVGYzRwMzhoOFBoMUpx?=
 =?utf-8?B?azJpVEx0bzlaZEQ3blB3RUpnUHF0RGEwYTAvbUU3aG1qUEhGMk9yOWNUdjdD?=
 =?utf-8?B?STEwV3paZytMakpEZlI4Zy95NUxUUGs5SDJ4aU14Z0tvYmJ5bFRVQ1V6enFh?=
 =?utf-8?B?UjdGOHNpR3pBNGZzeTFnQmRHdlVLUDMzYkZ5NHcrcUtreUZsUFZaWUIwV1VS?=
 =?utf-8?B?Z3EzaE0rdVYwNnA5TG1mSUw0WmdyZy9WSWFxYWVtNVNHMC9lbVNRQklNYlAr?=
 =?utf-8?B?SUVJS2RyWXQrWWtacVJOVzlNUDExVC9SditnTHBVQitkQS9yWlA5M2puWk1n?=
 =?utf-8?B?MGpKdkt2eFphcjQ5S20zMjl2bTlRK3NQME5NcTBPSmlmSFU5US9nb1dXUDZW?=
 =?utf-8?B?U2NUTEVPM1JGQmhYZlVsTkx5d2xCOS9ramErVCs1YUtuWHZDdFJpTzl0bFJr?=
 =?utf-8?B?V1NWZkR0MDFEMFc5Smk1UVladmxtZXZzNDhDVUVOdHlGeVQyallIUCtUNmEw?=
 =?utf-8?B?MVRTa3UvbnlNeklLbjRHYlVzTjlpZWRqOHJHNEl5aWRCWitCWGppQmRHbUNj?=
 =?utf-8?B?bFpmTHlueUtiS1h6V2xUT3hJZW9BNUdtRXdidzBOMVIvSG4xTCtDV25vUmJW?=
 =?utf-8?B?VmR1L3RERUlFN3RPQTFwaFlIMU9qemRNOXlDZGFqNkowTDRiSFoyTll6WURG?=
 =?utf-8?B?M2ZhL0JSUkVkdW1uVlpTQ1NWVEhXcVE3OHJpeDV2RkVRYUhoL3RURzJHNVZF?=
 =?utf-8?B?cmlDRnNvTlhEeVJiOEkzUWVOU1ZVMFhWTERZWWRsWnJPTG9XTlZFVHptbWNH?=
 =?utf-8?B?bVFPZ0xINEdjcDhjL05IeVdLS0M4L2ZieU4yRXROWDdQYlVVRjY0VUNEVU5O?=
 =?utf-8?B?b3VYZmE5VkRoWHB3YWJyU3RIdXEwbE9EVmppMnljeWV1U2pMNzNvamJlYlNZ?=
 =?utf-8?B?TzhJVHd6RVAzdGxmMG13TkxpN0hDOFFRS0RJazhxUGFqUFV0MU02YmFsdnlD?=
 =?utf-8?B?N3poV2ZTemwrUjF2SC93UXplNlBXWDBNbG9JaHBHMGpLMWVvekVZbjFEWFI1?=
 =?utf-8?B?RDlJNkt2N1pvVjZzSVM3UFZiMXFRVVZFRHFqdUJXUEFRRXIvc2V5a2ZFMTdl?=
 =?utf-8?B?K2FXUVVSdzBMdFg5S0VRWUY5VUhxMGt6TjlOb1JuVXVDL3V2T1RwMTU4QUJm?=
 =?utf-8?B?T3BPL3B1dTN1TEVKWGlFcFc5NVRTZDE5RFR6NUhVVjF3NjVNZjFwTkYvOGN0?=
 =?utf-8?Q?ed1gJY1tehJexkkU8P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e900ca-de45-4537-ca4e-08df430f7820
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 11:56:23.2479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +5tKEEJYqqB+ARTSF6vkdtaandDRZBX4HJhaiLJ+k/UTq30pbJtxCufE5kmaiD2MIXM3jL7sapSvZeKEJNosSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7728

Hi Nathan,

Thanks for the report and all the experiment you have done to narrow down the issue.


On 11/14/2026 8:49 PM, Nathan Blomquist wrote:
> [You don't often get email from nblomquist@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi,
> 
> A further test result from the affected Ryzen 5 5600G (Cezanne) system:
> 
> I booted with amd_iommu=pgtbl_v2 and the experimental v2 page-table
> cache-flushing patch described in my original report. The system boots
> successfully, drives/storage work, networking works, and usb devices work.
> 
> Before the patch, booting with amd_iommu=pgtbl_v2 caused widespread
> failures; almost nothing worked.

Interesting. We regularly run tests with pgtbl_v2 on server platforms and we
never saw this issue. I did double check on Turin system today and it worked
fine (it doesn't have GPUs, but it has NVME's and Network card).

> 
> This suggests the problem may extend beyond Radeon initialization when
> v2 translation is selected more broadly on this system.
> 
> The cache-flushing change is still experimental. This result does not
> resolve cache visibility versus ordering/timing effects or establish
> performance and long-term data integrity.

In v2 (guest) page table mode, we don't have explicit 'coherency' bit. But we do
have a DTE.SD bit which is set to zero.

From spec:

0=IOMMU page table walk transactions for this device are snooped.
HyperTransport™ transactions by an IOMMU must set the coherent bit in page table
walk requests for this device.

So far my understanding was we don't need clflush as we don't set DTE.SD bit.

This patch may impact the performance little bit.

I am not aware of any erratum on coherency issue. I will check internally and
get back to you.

-Vasant



> 
> AI assistance was used to draft this update.
> 
> Thanks,
> Nathan
> 
> 
> 
> On Fri, 13 Nov 2026 13:03:53 -0500, Nathan Blomquist
> <nblomquist@gmail.com> wrote:
>> Hi,
>>
>> Resending in plain text because my earlier email included HTML.
>> Apologies if you receive this twice.
>>
>> Could you take a look at this AMD IOMMU regression? Since 7.4-rc1, my Ryzen
>> 5 5600G systems fail to initialize Navi GPUs under v2 translation. Identity
>> mapping works.
>>
>> The bisect points to bf5bdfd1f8d4 ("iommu/amd: Force identity mode for
>> selected GPUs only").
>>
>> I've attached a small experimental patch and logs to this comment on the
>> AMDGPU bug tracker:
>> https://gitlab.freedesktop.org/drm/amd/-/work_items/6081#note_3782405
>>
>> I found that my dGPU stopped working when trying 7.4-rc1 for a different
>> issue.
>>
>> The patch enables the existing guest-page-table cache-flush handling
>> through PT_FEAT_DMA_INCOHERENT. Pristine 7.4-rc2 plus those three lines
>> initializes both an RX 6600 and RX 5500 XT, with no IOMMU faults or PSP
>> errors. DTEs confirm both still use translated v2 DMA-FQ domains.
>>
>> I also tested whether the flush's barriers alone were enough. Using one
>> unchanged kernel/initramfs, both GPUs gave these results:
>>
>> - Cache flushing: pass
>> - No flushing or barriers: fail
>> - Two MFENCEs without flushing: fail
>> - No flushing or barriers again: fail
>> - Cache flushing again: pass
>>
>> The feature's other effects were retained in every mode. Failures had IOMMU
>> page faults followed by PSP KDB-load failure and probe -22. GCR3-only
>> flushing also failed in an earlier test.
>>
>> So two MFENCEs alone didn't help, but I haven't ruled out the extra delay
>> from flushing. This is a diagnostic patch, not a proposed final fix;
>> performance is untested.
>>
>> Is there a known Cezanne coherency erratum or something in the v2
>> table-update path we should check? Full logs, DTEs and diagnostic patches
>> are available.
>>
>> AI assistance was used for the diagnostic code, testing and write-up.
>>
>> Thanks,
>> Nathan
>>
>> Subject: [RFC PATCH] iommu/amd: Enable cache flushing for v2 page tables
>>
>> On a Ryzen 5 5600G (Cezanne) test system, an RX 6600 and RX 5500 XT
>> fail AMDGPU initialization with translated v2 DMA-FQ domains on v7.4-rc2.
>> IOMMU page faults precede PSP firmware loading failures and probe -22.
>>
>> Enable the existing generic page-table incoherent-memory handling for
>> AMD v2 domains and provide its required IOMMU device pointer. On x86,
>> the existing flush implementation calls clflush_cache_range().
>>
>> This is an experimental extraction for review, not a proposed final
>> platform policy. It enables this handling for all AMD v2 paging domains,
>> not just the affected platform. Cache visibility versus flush-induced
>> ordering/timing remains unresolved, and performance is unmeasured.
>> The feature also disables a single-page fast path and sets an ignored
>> AVL bit in non-leaf entries.
>>
>> AI assistance (OpenCode) was used for the diagnostic implementation,
>> test automation, evidence analysis, and this extracted patch and text.
>>
>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/6081
>> ---
>> Base: pristine v7.4-rc2, before applying the c1diag diagnostic patch.
>> This three-line extraction was separately built and boot-tested once,
>> without diagnostic logging, mode selection or GCR3 modifications.
>> No GPU workload, performance, cold-boot or other-platform validation yet.
>>
>> drivers/iommu/amd/iommu.c | 3 +++
>> 1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -2810,6 +2810,9 @@ static struct iommu_domain
>> *amd_iommu_domain_alloc_paging_v2(struct device *dev,
>> domain->iommu.nid = dev_to_node(dev);
>>
>> cfg.common.features = BIT(PT_FEAT_X86_64_AMD_ENCRYPT_TABLES);
>> + domain->iommu.iommu_device =
>> + &get_amd_iommu_from_dev(dev)->dev->dev;
>> + cfg.common.features |= BIT(PT_FEAT_DMA_INCOHERENT);
>> if (amd_iommu_np_cache)
>> cfg.common.features |= BIT(PT_FEAT_FLUSH_RANGE_NO_GAPS);
>> else
>>
>> base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
> 

