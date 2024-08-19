Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6F63398E
	for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 09:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724058016; cv=fail; b=kFrFLyAHdtU1axNn+F6Fya7Ib40qfUZr8vtjb4+gRqFxdgpHW1xV/B3gp4X2/4rTleMBTsWkasvg2cxF7shoNXzdYO8lkd32pC+AP4Uk3hiANb6ZQ1VAhDF6yLKmr9AW2Muj9iKIaTciiMJzb/EWjm3WSCEYMAxNK144uvAdaUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724058016; c=relaxed/simple;
	bh=k2VtjlT9v8A3ydnBHlrXXRLJT6OZo3Yl2c7rrqyY4Bs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H4pr0z1E8QTn8CXnGDOb42imtGPgX1rlxGZtQAVAbhwQfXcQSgo0rlQb0nhzJo6KWKkCMf21jOaGHFuk+L5Cx0+ADNaReBdlg8rRYrE5H1b315orVzZGinserL4CaX1Cej85O0QzPPMwAML9bVpJRzmOYkZwQLOthbLuJnGkpY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gjjm3BGI; arc=fail smtp.client-ip=40.107.100.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gjjm3BGI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/oUg2xiEXWuDUYBleicPl/sV6VN6iYLjeklRn1CRQatdCRlXr8h6//MuI0dFGirqYinQj6TZpQyDDhGNppB30FaPV6g/dV3KUUJqld5soqNQd3zsL4MCyZKKDWroWU7CSJdaceW0KH8V8AisKkIJmtYpHtQfzhad+4+hEcqppsrmiMMf6Kv439EBlzYyobOuSHJ1ZgWAOuMbzKzkDVKDlvhZyQ47oNL/wTYDCRy4bIEs5BUwsuM/YiwPNeGvjKEOIfCw/o4eBAR3QtF38fV3Y7lVWEwT/nCdt2b4QwOyDkgARNZik/ogVEIWq26/RnMM7ModKEs2RaquHg9gDtHVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evCvIRhIcKt3wUnAykrlT09jRp6yS6j+Dy6RB79mNDE=;
 b=Bm3wmHLFpC9eyS91ehKkXn8X8dFX6DrTPLSCTEXZKclpkcfRVy862zT0MyEvcH7mHNX3Z4mrMv7j8X6bTnc9vzFTfVFQVR1fRniZhaJ3WsAh+H4ruzjFOAHVUDy5tpu9bDAtt6D/Qb4trxalm/VIKdYp6M6/gcI2ARTK5kuwCkltwfzBLU0qGhpBV20jFVbkngfQebaIv1xd6t1D0bmskxnaed6zkn9A6fVi/GxkJYdL3i8usL8wSNgb5xmMJyOTP5pmrYhwGkoXpsGWDWNW3uW9K8k3FUD2SPy7BEH+JYnp4kWKSBvcW5zq6vH/LAXquZ1nEDsm4mM1iUS7idS8Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evCvIRhIcKt3wUnAykrlT09jRp6yS6j+Dy6RB79mNDE=;
 b=gjjm3BGIEL7Ng1HQLSiRIFku3GVr9MqLoOLaybuWilmMrhiJPISQktrN1yO2dBd14dkvOhHJ39yjWFT9ua4TymIokshzi4A+zxEl3C9nWFingaSL9bjxza7Li7dRmNXOq9sJfjD0v/4zKQcb5g8tKx3bNeAEKlDrmtew+N2R9hw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS7PR12MB8082.namprd12.prod.outlook.com (2603:10b6:8:e6::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Mon, 19 Aug 2024 09:00:11 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 09:00:11 +0000
Message-ID: <d2bdff89-d9c3-487d-9f05-a1104ba176c7@amd.com>
Date: Mon, 19 Aug 2024 14:30:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] iommu/amd: Update PASID, GATS, GLX, SNPAVICSUP feature
 related macros
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc: joro@8bytes.org, robin.murphy@arm.com, jon.grimm@amd.com,
 santosh.shukla@amd.com, Jason Gunthorpe <jgg@nvidia.com>
References: <20240816221650.62295-1-suravee.suthikulpanit@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240816221650.62295-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::7) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS7PR12MB8082:EE_
X-MS-Office365-Filtering-Correlation-Id: 77f0b8bb-e128-42a4-3f6f-08dcc02d5527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVdNOFJ1NEhZb1o4RjlidEQxa2VWTUp6eEZFdmhicTVGV0RQbXVDM0xLMlN0?=
 =?utf-8?B?Y2FBVXBsZlM2NGRmeDBzYUlLNEF2dC9FUFA1WW9NekVlRnFuYWVza2Y5U2c1?=
 =?utf-8?B?T0ttcyswVTQvQ25hRFJubXJrUkJkVHE3eThUSU5FUmVzTTlnVGtEekp1NUhC?=
 =?utf-8?B?ZHBRN3ZDdTd5RytpU1BBcWFuWk1maDFEYm53bFl3bkZUN1A5TUxIdmRpbTFp?=
 =?utf-8?B?N0x4NlhGODQ0ZllCSlRjc2Jvb2NDclpkdXI3d1Z3N1lCY0k4RTRjNWVwekhs?=
 =?utf-8?B?cFhPb3pJa01OZU43UGpKZmpuSFJkUVVjdkh2dnR3YmNTZHpjUVljaEdDYm9n?=
 =?utf-8?B?VWt1aTVXbVh4VTljSXJLY0dsRlgrRElSdVpyY2tFZnlKWkpSamZNT0d6b2Qv?=
 =?utf-8?B?MEhXcDlMSnJpWEF5S1ltRktCdy9PNFlOK2lmazlWZGlOd0w0SFUvZ3BsajAz?=
 =?utf-8?B?NE5sK2VkVFZuR2RiZVp3dTBsK09TU0w0dTMxRHNsOGJqb09MNXZhZnJRMERl?=
 =?utf-8?B?MHhYWEFXcjh6eUdiMlZFM2VVaTFkRjE5Wml3TEFvTHFFU3pwL0RxVTdrUjkr?=
 =?utf-8?B?T1FKYzVZVzZPV2hrTFliKzMrNXl6N1NIWFpTRk1LaDRyaHByU281V0dVQnFa?=
 =?utf-8?B?WHZlTDVEWEE2bHZhcUppSVE5NDg0SzAxTDUwVzdMeDd5MHBxZlA1SU1DMkxG?=
 =?utf-8?B?d0E3djZKZ01HM0ZaQnI3Y2VoTVFYZkgzM1BYOFpHNmpDcjJENjBQN2h1cGhK?=
 =?utf-8?B?TFY2ZWgxOThaVlJYMnJDM21UelpQR2VWRkFSakpFUUExMHFwNllFR0hwNXp1?=
 =?utf-8?B?SERaN3R2WXYyZnl3YlpyNDNjNkZ5eFJUQythSmQvSmMwVGVwRVcyYjVWRlMv?=
 =?utf-8?B?NDFON2RtMm4vYTVCSTV5b1d3aHIwZjFCR1RpeWJIVjkxTzIrTmdpVFh4ZE55?=
 =?utf-8?B?MDk1aFJkZnc0UUdrRnlnVWcxWUlvU0tyTktQMGNxUzBSaTF1TXhlZVpsWndv?=
 =?utf-8?B?RUY2SWhkaUNqbXBySVkzcFpZb2FvUHBTNVdkNExkdVJxVU1xbVBzTUtESFox?=
 =?utf-8?B?akgwRGlZM2t5Z3dTeTAyZU40STU5M1h5TWpFdnp1aXhwdHRDZzA1eUxFMzVR?=
 =?utf-8?B?Uk5DOVE4L2g2dzl1K29ORGlTcW5SZmd0djFSS2FEVkczekw2a0RHYWJPRWRy?=
 =?utf-8?B?c3hjNWVPT1VWbGMraXA3aC9EWWp3MFZIdkg0b3pWV085UHNoWW00VURGVzgw?=
 =?utf-8?B?cnh3VnJjVUJmQ1I4YWFsNU1jOXM4UFJQL0dkWjFNYmNxRG0xS05wSmc4U3p3?=
 =?utf-8?B?R3owYUhXWm53Tk1GVnNDbUw4bmpsY0t2OFlnUFAyNXlvQ0hKOWVvVkdJblkx?=
 =?utf-8?B?UUxmWTJIVEFVZzh3aVpsNG5VbEp5T2VxWVdmUFRGZlA3b3Q3dk5nU3Z3ak82?=
 =?utf-8?B?NnR0TG42N2xxeFRwYzEzcEtVN1J1QzdiejBYaU1MN2Vucnh5WlhaWXJHNmE4?=
 =?utf-8?B?MnY4NHlVYmpSZklvQ0hHUUVXZWVNU2Vrb3NwblpMMXBvcVpyV2dmTTJQUlBa?=
 =?utf-8?B?UkNsZ2FFUFhxMnR4TFRjTkl1bUE3SytsdkNxdnZGc0JpNU4ram9yYnZyWXJl?=
 =?utf-8?B?eFJ1T215dllMOGZ0Z1hEQUoyYlVscW9aamdqU3B5UFIvWkZGaHRvOXFGT1Jo?=
 =?utf-8?B?ajZmaXdUbEI2NmxYYTBsWWRqSllBRE1NNk44NFV5T0JXZ2NiQVlLWTFic1p1?=
 =?utf-8?B?RUluRWd5U3ZrNUtVYnN4bm05RHV5RGY1TE51eFBDYzJKMTR6VlVYN05sbGc4?=
 =?utf-8?B?U1V3dElxRjdVV1lIU1EyQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzFCL1JrYU1CS2hhWWNqdTNmODNmOTVPTmNZUnBmU0t2a05uRjM3VTh3cE1X?=
 =?utf-8?B?dHpGL25EY2I3OGZQdWk0WnFHK2swY0VOZnRMUDJPUGFpc3hKNzI2cjFIZ1J4?=
 =?utf-8?B?blNiVXNwU09MVFpVWWE2aWJEbFJwZ2VtZFIrMVY5MlMyV3pzNHlPaStNQUdI?=
 =?utf-8?B?SUlaaCtqcmJ6SUllcVl5OWVzY2M2VlA3azBuNGduWjBYaUE1dmh4RkJ5Qjhx?=
 =?utf-8?B?dzhqT2t6ZmY5TGFDTVNwalVnZHg2bThSUmNUUTVCUE9KdDVIVWh5cGFySWMz?=
 =?utf-8?B?RWJDVDdUd0IvSWora1p5ek1vcHlHeUZLMDRZczNsYm5YQWdKTjdDY3lBMDlh?=
 =?utf-8?B?Ylp4b2hvVGp5MnY5VHVqN1NHQUZlaXVqV1NjeUIraEs3WEx0MTdSa2ZxYUh1?=
 =?utf-8?B?emVlWG9SRlQwWjlUeUFFK0huNndtYUZjMG1rOWdKOXlVSlRwWE1SQk1qSUFF?=
 =?utf-8?B?VVFxOUd2RUR3RGtIM3VQdDd1QXRmWVNkYmVyTDQxVEM2KzZDZmV0SEdvUDE4?=
 =?utf-8?B?K2x3K1hVcmRtUkxuSnd4ZU1uVTFMTFdQaVpxTGVUZU5ydVozdGNmR0wyaEg1?=
 =?utf-8?B?N1l6RWUybWRYVTUyamc0cG5oT3hPZGhuRlUxNXhUMkt6bHhvVERKSk45UDFP?=
 =?utf-8?B?NHBvdFhCcEJuT0d3UU9tdTBzZDNVdmY4Z3pHb0YwNlBJaCtSb0U5Sms3Z3Rj?=
 =?utf-8?B?Wmp1MU1sc21SNlpaWk5FN0NwRS9IOE9QY0J5ZmFWMHI0WTRMUjd0K3NlY2xq?=
 =?utf-8?B?bE5EQW1HOW5obEJkNGVXTEtSekRHWUxmUXdKdS94R1kwWllzVHJHYnh1Q2hE?=
 =?utf-8?B?aEVMdTVlVmlJSTlwdTQxWStJVkZLZm5qRmVHQTVLNzRYTzdGSFc2L2YyZTAx?=
 =?utf-8?B?bUdTM0ZEQ1dacXFkZCtMRmp2WmR3dkRDcEdhcGRYc0dsSmI5a0pRY2h4enli?=
 =?utf-8?B?VW8yOEVWblo4YUlJaGRoSnJCM2pwOW9NTHZHRTE5TkZyNGxNUXorc3VOYUYv?=
 =?utf-8?B?OWd3UE56TmhBUG1rbUNjME92OG5lTmV0YmhJbzBiOHczamc1cHRnbHUzTjJO?=
 =?utf-8?B?WGVvbXhMWDMwKzdCL2JMb045MGtQVmFuUjZ2YWV2RmJmRjNlMUdSQmZYVmFt?=
 =?utf-8?B?MWVQOFE0eVJ4U3ozTTMwUEd0bzZDVEozQ3l2VGdMNlM3aHRhVDBPaGFMT1lZ?=
 =?utf-8?B?M05vOStkQ3JqNWVIb0ljK2NaMWd3RUhYSDNUb0ovNVNhMWE5THVSQzc1WVZO?=
 =?utf-8?B?Q2dDTDd1S04yenkvaDdRdm95VmVYWWd0dU92WGc4ZlhwUVRPbTd4aTNRRW53?=
 =?utf-8?B?T3NiN01YSE9KV2tsVWViWTVjd2FaR203MDR4RzliR1VhQy9VMDRwczRkVDFq?=
 =?utf-8?B?K3FlVUFkY21aZXAvNWNjR20wUGw3em05dVBnKzNjS1lLVWdJcDNTa2pPcnNp?=
 =?utf-8?B?L0NuN21RbFNZYnRqa2JGZzZrSENtQVFOSFJsREkrSVNqTmdvZUI0K2lXaWVL?=
 =?utf-8?B?K09NaDU3NlFHS2NGaG5kZU5KZG5nQjVlSE1lc1dkN2YwbjMxTXlpT1BkOVMv?=
 =?utf-8?B?RTE4R1NwZTdsYU1QMVJLQXo4SG52QVJweWFYM2FvSGlyV0JFVkxyTEpxQWls?=
 =?utf-8?B?RXFoYTMrWG9vbFRYUURQTkJCK25YSUVLekFMYXQ1VWEwMDhKOUhCRW9CSnBz?=
 =?utf-8?B?TTZaZmZpblZHa3JKU3Btdi9oLzN6SHpqODJzUVpnclkrZmhxNUJPSlhFTzNy?=
 =?utf-8?B?Snlrb3pxZUhvRHlaNWM0SE5Ya0hTb2I4dkhyTGlJSndDNDVqSStycno1OUx6?=
 =?utf-8?B?T0lYT0NkMnZoVlVlVSt4WDgwTXlvb3p4K3VQbEY1TWdzZkpZbDJCNDR6Ni9u?=
 =?utf-8?B?c3AvOTJ4TlREZUNGWFZlRzRwa3B0aFpqTnRVcnNQN0xkVExwOHdwUXNKZWhu?=
 =?utf-8?B?TWd3VmRkaXVwQVVKaWppU0U3SVVmVUMrcmxkd0Q2TUwxM1ZHYlF2UHNaWitK?=
 =?utf-8?B?K24yUzNBWjVnb0VWcUtzaHR6RllpYzlzQWlPVHFBSkRJVSt4TmVkOVhZVnd0?=
 =?utf-8?B?dzJvRlltWU8wSld1bmJ0TDF0YVVwNDNLREFITVF5WG5hc1I5dndhT1ZBZDY0?=
 =?utf-8?Q?3pN9OnaQm6K2J+ctGdqMge5To?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f0b8bb-e128-42a4-3f6f-08dcc02d5527
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 09:00:11.7696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PPPUFSNV4SSXcNwK+FYzqpHGjlsJUTsgmbvgrB93Gg6753YZ+2OB1VNPV4tPAllEYFylPs7idStTpGBX8mvsPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8082



On 8/17/2024 3:46 AM, Suravee Suthikulpanit wrote:
> Clean up and reorder them according to the bit index. There is no
> functional change.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

> ---
>  drivers/iommu/amd/amd_iommu.h       |  5 -----
>  drivers/iommu/amd/amd_iommu_types.h | 16 ++++++----------
>  drivers/iommu/amd/init.c            |  8 +++-----
>  3 files changed, 9 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index 2d5945c982bd..52e18b5f99fd 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -121,11 +121,6 @@ static inline bool check_feature2(u64 mask)
>  	return (amd_iommu_efr2 & mask);
>  }
>  
> -static inline int check_feature_gpt_level(void)
> -{
> -	return ((amd_iommu_efr >> FEATURE_GATS_SHIFT) & FEATURE_GATS_MASK);
> -}
> -
>  static inline bool amd_iommu_gt_ppr_supported(void)
>  {
>  	return (check_feature(FEATURE_GT) &&
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 2b76b5dedc1d..c9f9a598eb82 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -8,6 +8,7 @@
>  #ifndef _ASM_X86_AMD_IOMMU_TYPES_H
>  #define _ASM_X86_AMD_IOMMU_TYPES_H
>  
> +#include <linux/bitfield.h>
>  #include <linux/iommu.h>
>  #include <linux/types.h>
>  #include <linux/mmu_notifier.h>
> @@ -95,26 +96,21 @@
>  #define FEATURE_GA		BIT_ULL(7)
>  #define FEATURE_HE		BIT_ULL(8)
>  #define FEATURE_PC		BIT_ULL(9)
> -#define FEATURE_GATS_SHIFT	(12)
> -#define FEATURE_GATS_MASK	(3ULL)
> +#define FEATURE_GATS		GENMASK_ULL(13, 12)
> +#define FEATURE_GLX		GENMASK_ULL(15, 14)
>  #define FEATURE_GAM_VAPIC	BIT_ULL(21)
> +#define FEATURE_PASMAX		GENMASK_ULL(36, 32)
>  #define FEATURE_GIOSUP		BIT_ULL(48)
>  #define FEATURE_HASUP		BIT_ULL(49)
>  #define FEATURE_EPHSUP		BIT_ULL(50)
>  #define FEATURE_HDSUP		BIT_ULL(52)
>  #define FEATURE_SNP		BIT_ULL(63)
>  
> -#define FEATURE_PASID_SHIFT	32
> -#define FEATURE_PASID_MASK	(0x1fULL << FEATURE_PASID_SHIFT)
> -
> -#define FEATURE_GLXVAL_SHIFT	14
> -#define FEATURE_GLXVAL_MASK	(0x03ULL << FEATURE_GLXVAL_SHIFT)
>  
>  /* Extended Feature 2 Bits */
> -#define FEATURE_SNPAVICSUP_SHIFT	5
> -#define FEATURE_SNPAVICSUP_MASK		(0x07ULL << FEATURE_SNPAVICSUP_SHIFT)
> +#define FEATURE_SNPAVICSUP	GENMASK_ULL(7, 5)
>  #define FEATURE_SNPAVICSUP_GAM(x) \
> -	((x & FEATURE_SNPAVICSUP_MASK) >> FEATURE_SNPAVICSUP_SHIFT == 0x1)
> +	(FIELD_GET(FEATURE_SNPAVICSUP, x) == 0x1)
>  
>  /* Note:
>   * The current driver only support 16-bit PASID.
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index c89d85b54a1a..6b15ce09e78d 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -2042,14 +2042,12 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
>  		int glxval;
>  		u64 pasmax;
>  
> -		pasmax = amd_iommu_efr & FEATURE_PASID_MASK;
> -		pasmax >>= FEATURE_PASID_SHIFT;
> +		pasmax = FIELD_GET(FEATURE_PASMAX, amd_iommu_efr);
>  		iommu->iommu.max_pasids = (1 << (pasmax + 1)) - 1;
>  
>  		BUG_ON(iommu->iommu.max_pasids & ~PASID_MASK);
>  
> -		glxval   = amd_iommu_efr & FEATURE_GLXVAL_MASK;
> -		glxval >>= FEATURE_GLXVAL_SHIFT;
> +		glxval = FIELD_GET(FEATURE_GLX, amd_iommu_efr);
>  
>  		if (amd_iommu_max_glx_val == -1)
>  			amd_iommu_max_glx_val = glxval;
> @@ -3088,7 +3086,7 @@ static int __init early_amd_iommu_init(void)
>  
>  	/* 5 level guest page table */
>  	if (cpu_feature_enabled(X86_FEATURE_LA57) &&
> -	    check_feature_gpt_level() == GUEST_PGTABLE_5_LEVEL)
> +	    FIELD_GET(FEATURE_GATS, amd_iommu_efr) == GUEST_PGTABLE_5_LEVEL)
>  		amd_iommu_gpt_level = PAGE_MODE_5_LEVEL;
>  
>  	/* Disable any previously enabled IOMMUs */
