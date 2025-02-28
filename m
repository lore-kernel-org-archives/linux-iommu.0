Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2046.outbound.protection.outlook.com [40.107.101.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27512209F5B
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 08:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740731199; cv=fail; b=GA7ejkPUTipXX9hfU5NXeIirFaT25OTT0x5H4nTRfGF+3eA0gBUXzjesqcPrr9F7TPG0SVXxpfdnKaTAW6mGEUMvQSceUdOBUJR5t6rgwiksrWEifd7ESZtR7+TPHQzLlfICn/Af204MeAfoVJXxmWrUYpDHqpYIMG6Jy1qSDMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740731199; c=relaxed/simple;
	bh=5ZZGi0m8gZB2JcuHO0+hjyX2YXVQ8g9wTUL+Ur5Y3lY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FUZUUoeeGiVBDkNYzDbsiutJaFjW0PvQ8b0sEfgRmXAbPYrN7H8TZ7FfBQsyGaqnQpN5AZWAE9gWfwDiZIOnGvrJG4Gn/gwfbyNJEI/zLhnyTLd/5Md9++3ReL6mc/PiAeHUHbKvtqEF8lxIh9zYDJqFbj2MMlVpgtIsBDSRjVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y8OkV1u+; arc=fail smtp.client-ip=40.107.101.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y8OkV1u+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYNcPaAK0J8Tk0KEGh5I6u+FYuWT+HFkbGbbGnylBVAu+QUSyff+e653XCnYWLa/6J2Bg/BTbN2IPcqhSOHva5fGPOULXGa24JYIoE4yUmELt1o/xaDfbHT7lxxZhez7jwSLsIIofUBOx44AK9VJ57kca6UT5SgHCbvyzf7mIIND8g4k5r3tZAG+zvJmg1NvPJ7Jx2uS7xMyrUKuWUTT85xxA3ZifVR0o3/iWM1g9slg9d0W+qKal5oVkntM9ZJ1OSXKPyhbQe/dMD+Cno7oiUxZ38zqazbUGUNqgJlgOWsSBleRmFIgEgzf7n4NnNj7Qtj7Bx71z04hmmFn1PNsQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TT4NtikDMqOf0+rm7ULamrrc3Nlho8u2L6xpl3SMiLE=;
 b=tdQFL4bX2kcaD0ltgKNUoJNi71NqPR8ibxSZsOsjoYoasnK8SJt8mdjf5Kbe1+CpSAzMgwi+NdqfLazvGyP3e5ywCSjQxVFgTGYifBNgf5v9hb2v5zl8EE232pWFwz7F+2/U6/eTboWQGX5eMLED7P74wDNggnmjON7M8gdjrBjYE7eC9vQWcpxlGsFVFqlAVfMjX5r3plMbvRJ8p9HHLPhlz2/SQwQ2ARWXcSJZi+QDZcNNxR3KqhEwbOFFZ2/QC5nPdzP0Ih1yx29RjP2mSz8U/nPKwdOLcpVKLIfxok7PlChhAetioE5NICQqV19IDwCDJc3WFcP0jfuhritpQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TT4NtikDMqOf0+rm7ULamrrc3Nlho8u2L6xpl3SMiLE=;
 b=y8OkV1u+MbZ9MvVcPvUpbKOJxa6ARPjuDF95EwDwskYVk8rM0EbkNCPjKkNmMhBxLorh+Kdqh9bRj2BOuBoYOeGiNK9WgimSlbfq4QCSa2Ov/IDHe+VhCdIbjqw96whitxHKpvWehkzXiGQJOd5d3mmeDwZR8k60nxYsaaXSNww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 08:26:35 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%6]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 08:26:35 +0000
Message-ID: <b3168ca0-62c8-4e9f-8a46-23473a5d6ab6@amd.com>
Date: Fri, 28 Feb 2025 13:56:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
References: <20250225105829.52223-1-vasant.hegde@amd.com>
 <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
 <ce86ff90-377e-49fe-9c4e-d2ad7abeeec8@arm.com>
 <20250225145518.GJ545008@ziepe.ca>
 <BN9PR11MB527624C1DED16B3C049D13438CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250226011750.GB5011@ziepe.ca>
 <BN9PR11MB5276B3E410FD336A3062FA5E8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4fba254e-ca47-4e7b-baf3-0228d9605c2b@amd.com>
 <BN9PR11MB52763A8885AF1678E05E8B528CCC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <BN9PR11MB52763A8885AF1678E05E8B528CCC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0214.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::9) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|BY5PR12MB4130:EE_
X-MS-Office365-Filtering-Correlation-Id: c36ce728-7d63-4732-017c-08dd57d19cfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OCtvV2ZLdEJkZFVHdnRreG9qT2hpMU1FcjVBMnA2ZmMvVjNWc1RReGQzRlFP?=
 =?utf-8?B?S3QvNnVDZCtMTFNnVWp4cmFxZVhpMXM2TkZlendaTzR0c0ZMdXhhTXRQZEE3?=
 =?utf-8?B?OVVOeDdDNWFjNzB5TUtzcTc4YS9kQXJ5YkNBWGJZRmFIRzJXV3BVZmtlTUNu?=
 =?utf-8?B?L1FGVEZGeXhQaXRHOFZnc0lRQkVDTVFkK2hVcGN5a1F6MmF3Y0p6VHRsekRJ?=
 =?utf-8?B?MnNlR2Nsc3M2YkZ2d2FPVDd2NkY3RkZER1cxZm5RZDlPR210ZWhBaU9kaG50?=
 =?utf-8?B?UGoySVd5d3hYWVBzUkEyOVJjTHFhZkE4ODVkYmtyWGhtdnhDcHRpK2pJME1q?=
 =?utf-8?B?ZGhuMHdvR0FNakF2UHZWb1VoUWNCNXlLdG9qTjc0Q2VGU0NPZk5yK2JNdGs5?=
 =?utf-8?B?amNyUXZ6c0J5cERwM0ZzcEVPT0VwRTRzVzRtOW8zT3FjK3NGL1hqVW1VaFVz?=
 =?utf-8?B?a2tBa2U1UzFNUjJRNmlHb0QxRG1JK0diL0tRUkN6SDN6dDBZN1JUNzFneU02?=
 =?utf-8?B?RUFFZXNzbVoxMFhhdklEajMybUN3SnRXR25YbzYyOHQ3TjZQeWNlSTdkbDJO?=
 =?utf-8?B?RWdZblI5VTl3RUhxTnVYbHpIK3Q0V0VGQnI0QlRYbUJEcTQ4b3V6Ui83WFlY?=
 =?utf-8?B?a0pLV2s0WllVWU0vTXk2SHRyV09tNmJSYjE3RFI1MkdXUE9QaG9YRWgxWUxy?=
 =?utf-8?B?ZnNRM1dma21STm1KWlh1dCtxSkJ4WnZHSE0zdUF4cUQxWllqQjNwRFEvNzBZ?=
 =?utf-8?B?Rjl5QlgwanVSa0VSd2lDNFF3VWdobndYQkpOc2l3RGlybGh6TEN0aXdZTDZ2?=
 =?utf-8?B?clNOVDdNNk1CdzZPQVNuMHNsZ2xiZFlsdW94RjQ5a0h0SUVFODE1MjZKZ3kz?=
 =?utf-8?B?WjZxWVQ3NnZ2bnFkQkc4OFVIbWFSTXdzczBZeUloOUdzWDQzT3pudWJLOUdR?=
 =?utf-8?B?c1hmS1JlUTlrQWNpc3liWGNXNi9aYzMwem11NkJtc2p6U1kwWVM2UFdJQjRh?=
 =?utf-8?B?MWZUZ2VrSzdjQ1U1M3BxaDVNcERvdS92b0FIL3JDb1BMcXlkTTYwMnpNZkV6?=
 =?utf-8?B?dXNsRlFiakhPWjUxMXVCWCt2S243NFZ4Q1J4ZEk3TlJrWUs4Q3hXK01QcFdI?=
 =?utf-8?B?Zm9jakFmclVEZXA0MlZWejhCTGV1bU5NeWswVWRDeEZ5dTVEMDhXeTRtY3Vl?=
 =?utf-8?B?NTZ5NUwzZGdVUURacFdIdzMrQVhodjFHL0x1TlBGUksrOWY0S2JNend6bFhW?=
 =?utf-8?B?UlNWZzBZZzBYaWtmUjRvTWgzN2FwQmdiWDROSkRRaXJRZktBWGdzZ0pZL2Q1?=
 =?utf-8?B?aEpqbzBYZkwzT1RtWStoeFQyeVRkdHdCeGZrNzU3YS9FaVVxK3B4NmpFa2o2?=
 =?utf-8?B?bW1vTHNRQ1dqaUtBRDVqa2RzQUhldFFnYzFiN1VqNEhNUm5tdW9nVnA3MFNS?=
 =?utf-8?B?UWhwUks4VHVKQjFmRFNNMkQ5bHZscGhpWWp5Z3o2VzlqaGZsWmloemZKWkV4?=
 =?utf-8?B?REQvdWNnK3VGdmpYc3grUVFiV2RhaDZld2ZYclBadDJEd25lbVZlMk5vNnMz?=
 =?utf-8?B?YkdWSGZWdXJrek5zcjlmSEZnR05GM284elhEUmpTYzJTc2VPaXdEaWhKQmZy?=
 =?utf-8?B?ZUFtMDZ4WXlvQWpacmNQRkJkYVdwSG0zVEc3ZnRtTU1TbXk2dnM2SXEvY1NQ?=
 =?utf-8?B?Wm9pWHdDMFdSc1RrUFFucldvYk4yMzZRSHVGRTlpdjdJK2tjbHN0MjVvYi90?=
 =?utf-8?B?amVldkNJRFlrb3BxQmVhL25JeXBKRlFTd1YwbGFmQjNMZkVTK3hFeGxmUmQz?=
 =?utf-8?B?VUc4ZThSbGtVOXd2MFNZRno0YXBGOW9GVHBxci9lU3hsSWphVms3Q0tPYWdH?=
 =?utf-8?Q?QIWw27yDWXOS+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkE0dGJhS3daOWd0VUQxK1JQOFVqL0RXM0lraDUzbUlGNmJjL25xTWs1cUNo?=
 =?utf-8?B?eG1jSGtLb3ZxVlErdXVYL0V6aDQyVTZIdWR5aHJvckVIeTc0TjJQZlc4VGNt?=
 =?utf-8?B?OEpybmVNMEhPaU9EaFo3YXE5b0hENkV1U05HL3RML3RJOVhuUkVHQjBua254?=
 =?utf-8?B?ckpBeEF4NEpBdk16L0xsR3FYMmFOc1QzT0hFOG1WMzNIODRrUlczbG9vWmt0?=
 =?utf-8?B?ZWh0dVdKTjJsUHozRDBUQ1htSlZrdjBMY1VCaDR3SmZEY2tsYVNrNS9kT2Vr?=
 =?utf-8?B?bWhJVkUyNWhhZ2tZK05YbWUzWUxCR0R3ZjU3akpjcy9yclk2UEN3QnRtMGhq?=
 =?utf-8?B?aGdWUEFvQUdtMHRYWlhDQnB2dzhmSVBkbFBQZER6RldnSDh2di9uRzdybEl0?=
 =?utf-8?B?NkFqVE14aDg2QUo4RFhZcEtiUEMxVUZDYTJTeUtjRG54REFRNG04VDJ0S3VQ?=
 =?utf-8?B?R1RsYzNBb0xXVmozTEQ5V1lmbG9vT0NGeW1IVktpWVBJOFUyTWZ6QitXeXE0?=
 =?utf-8?B?MVVuTDNjYkRCVDJLZGZjai9uTDRreGFwdmpSVlhpQ1FPQ0tibmN3YXJBUEhw?=
 =?utf-8?B?MXRHRmRGMHRqWVp4cUZxWllUNjdHN3c5NEh0emJPNWcvcHAzTllnTVZhbXFX?=
 =?utf-8?B?MFJ3TXorWnVvcjFCcmdnOVduTlNmK1RXaXpEOVdXdVNvQlM5eFRPc1Npekk3?=
 =?utf-8?B?LzA5N250NlpGWWV0RDVYbWdMV01xVDZUbjdleEZXUnNpRlQ3emVhMG1lUDJs?=
 =?utf-8?B?am82WXBLK1lQUWZQQjJLY3VFU1M2WEtUMmphTC8rRVRmcFJPN2ZkRlZXWCtI?=
 =?utf-8?B?WkwxYm1jVStmOXJGd2F4SW5ESFU1NzBsOGM5dGxpeFNaOG1IMm5yZnNZYkt1?=
 =?utf-8?B?WWdBdVpSVlhCWGdvVWNuRUphZUUyY0dtNWZ5MHJjYm5CTFhROURtMm5OelNB?=
 =?utf-8?B?SnI2cnJpMitiWTA1Y0dxZE83bStjT0I5R3NTRTUyb01WSkZ3QnROaFh0OUJG?=
 =?utf-8?B?WHZ5UC9CVXRzUmkxNWpDYW9vRllNbUNkL214Uzh3SE1UYWtKVmtDVU5kQWZZ?=
 =?utf-8?B?YlpCaTlDOGozcUJkWjZjOVpyTlhlR0FLYld2U1JETWJRaTlnOTZUYU82WkF4?=
 =?utf-8?B?TmlxQUFwUlFLU3MvYlkzcmRlSG1HdjhLQW5XbXRZMUtNanNaU3FSVFFDL0Jw?=
 =?utf-8?B?eG5idWxacXdVbk9PLzdCdys4Zko1a1hpaXZNTERtRml1N2pUYktiLzBHOWRR?=
 =?utf-8?B?a2tsR3ZUWXpyMWFyejlKMlh0Slk2NFdjQ3NMS21ncHJhWWE3MThCeFBnS2k4?=
 =?utf-8?B?ZUFMajdTRHgvMVFTZ0Y3UFZIaFRPb0xyd29DZnJpY25MWCthelI3ZHphNk43?=
 =?utf-8?B?U0EydEdVN3M1M096NVdNMkJSajRlT1F3ZHJWYllGcEpmdXgrSk1tREh4aXZo?=
 =?utf-8?B?ZjE5YVJWd09mWWVHZk01RldqZ2hmRkhqREpYc0JYbEp6bDFWUkxBbGNKdjZL?=
 =?utf-8?B?ZFQ2akhDMkc5cm1GdHhKdms2UmdzOHVzMmVGWEtyU2RDVWNUdHVQa0FKVkVR?=
 =?utf-8?B?L0JtY2tLekduYTFJTEQ1UkhNeDRYNkdEeVBOei9FWHRMaFdYQnI3RThJYTdX?=
 =?utf-8?B?NUdpUStGV3JldU1DbTRuYmdBVnBuZ2pWSzRDK0pRMVFsM1dhUXprd0pXdy9a?=
 =?utf-8?B?RDJZODZjTUlubWJvZ3hjOEtqd0hKc0t2TkMzL2hiOXNpMGNJV3BFT3pkNk9w?=
 =?utf-8?B?Q2IzR1FyM0JaQjRIekdIeCtWa2toUmE0ekM5NWZrc2wzYi9vTWZMQ016bWFT?=
 =?utf-8?B?c29RbkxJRFlSNkhnMG5HU3R6aVl5NC9jMWg2ZENhSnV0dFEvZnF5dEhwQitG?=
 =?utf-8?B?aFJqNU5FNXZYVWMveFhmR09OWnlrMGwvOUMwc2U3Witxa2xTR1BTZ0M1YVZ6?=
 =?utf-8?B?cENPRjlxMGovSFJQb1kzdGwrd1NVR2lYbHJTM1lhUUN0dlJjMnkzQjBBOXJX?=
 =?utf-8?B?QXc5ZjJabzUzQ21DajdWR21pelNPdElDODA4QzF5RXFqK0hQZ0hzUXR1NWFq?=
 =?utf-8?B?UVN6VytqRCtUK09XN3ZjU0Vab0hDSVdlVE1zcVlTOElPazM1d3IzTTA2R29s?=
 =?utf-8?Q?UurfubDPJN1eOmzbQQxCjvcyE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c36ce728-7d63-4732-017c-08dd57d19cfd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 08:26:35.3404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9J7mTNNfKROeFGvHblT3jSx69snd2hAvRcdjGt/yTmw3mLQL6xt4LRjTzQVBvL6hahBOWaDWlkUF1qcQNBORQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4130

Hi Keven,


On 2/28/2025 12:02 PM, Tian, Kevin wrote:
>> From: Vasant Hegde <vasant.hegde@amd.com>
>> Sent: Thursday, February 27, 2025 11:28 PM
>>
>> Hi Kevin,
>>
>>
>> On 2/26/2025 12:35 PM, Tian, Kevin wrote:
>>>> From: Tian, Kevin
>>>> Sent: Wednesday, February 26, 2025 10:51 AM
>>>>
>>>>> From: Jason Gunthorpe <jgg@ziepe.ca>
>>>>> Sent: Wednesday, February 26, 2025 9:18 AM
>>>>>
>>>>> On Wed, Feb 26, 2025 at 01:12:38AM +0000, Tian, Kevin wrote:
>>>>>> If above understanding is true, my preference is to support a sats flag
>>>>>> in domain alloc (nested_parent only and PCI/CXL.io only, as the start).
>> For
>>>>>> AMD it turns on the sats bit in the DTE. for Intel/ARM the permission
>>>>>> structure is created and updated according to the map/unmap calls
>>>>>> on the parent S2.
>>>>>
>>>>> They are functionally different things, and have different
>>>>> requirements on the PCI topologies supported (eg CXL.cache vs no
>>>>> CXL.cache)
>>>>>
>>>>> I think they need to be different flags
>>>>>
>>>>
>>>> Not exactly. They are functionally different but serving the same purpose
>>>> to the user. From user p.o.v. it's sufficient to have a general flag for sats
>>>> when allocating a domain. The underlying driver decides whether such
>>>> flag is supported based on the domain type and the associated device,
>>>> just like checks on other existing flags.
>>>>
>>>
>>> Chatted with Yi offline. Having untrusted user control a security
>>> feature doesn't make much sense. Probably what we really require
>>> is:
>>>
>>> - IOMMU core exposes a separate sats knob per probed device,
>>>   allowing the administrator to manage the sats policy which could
>>>   be no ats, unsecure ats and secure ats (might be further set per
>>>   domain type in case the hw doesn't support sats for all types or
>>>   the driver doesn't support all hw-supported types in one batch).
>>
>> When you say "sats knob", you mean sysfs interface?
> 
> yes

That means root user can change it during runtime?  And we have to expose
supported combination per group (like noats, ats, secure ATS).
Also runtime we have to update DTE (and intel case create new domain?) if we
switch from ats to secure ATS.

> 
>>
>>>
>>>   It's also checked against the device type e.x. CXL.cache.
>>>
>>> - Then when enabling ats for a given domain type and device, follow
>>>   the policy set by administrator: ats disabled, ats enabled as today,
>>>   ats enabled with hw enforced security;
>>>
>>> - Optionally iommufd may support a domain alloc flag for ats,
>>>   which alone is a performance or functional dependency (by PRI),
>>>   hence better to let the user opt. If opted, again follow the
>>>   admin policy whether it's allowed and requires sats.
>>>
>>> Is this way reasonable?
>>>
>>
>> What I am really thinking is :
>>   - If HW has a enforcement required (like AMD SNP case where Secure ATS is
>> must), enable secure ATS. But do we need some way to inform core layer?
> 
> It's not conflicting. When enabling a trusted device the driver can detect
> whether sats has been opted in by admin for the device. If not fail the
> request. If yes, turn on secure ATS as part of enforcement and return
> -EBUSY if the admin attempts to disable it in-fly.

Sorry. I am not sure if I get everything. When you say "admin" are you referring
to system admin to make choice?



> 
>> If yes,
>> may be have an domain ops similar to def_domain_type() ?
> 
> the domain for trusted I/O will have a special flag.

Right. we can pass special flag to domain allocation. But how does core layer
know's about HW requirement?

> 
>>
>>   - For untrusted devices,  by default enforce Secure ATS (may be a domain
>> flag)
> 
> or the admin may prefer to disabling ats.

Right.

> 
>>
>>   - Have a command line option, so that if administrator wants to enforce
>> secure
>> ATS for all devices, he can do that.
>>
> 
> whether to enable sats depends on various factors:
> 
> - is the device trusted?
> - does the overhead of enabling sats break the perf requirement of
>   the existing ats scenario?
> - different security policy based on domain types, e.g. only requiring
>   sats for iommufd but not default DMA API domain

Also HW restriction (Booted AMD system with SNP enabled).

> - ...
> 
> A global cmdline option for all devices/domains is hard to meet those
> requirements.

We will have default policy and based on global option we can do enforcement.
So that user wants global level enforcement he can do it.

-Vasant



