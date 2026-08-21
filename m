Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012040.outbound.protection.outlook.com [52.101.48.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A100392C39
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 23:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787354145; cv=fail; b=dUFT3l2s9qIoR69PdkMl8evz1gAfYzh4ChAQUczmH0v4/M1jl6goOdfgU6OUysfwMEkOikkwn0IYm3odaDCsNmN3N/j48cg0aJcUC2PNZGYU60NcUb2xCmBRn/dSCSzOzmHzDVyXvusGOLm3cfZ5f+SCFY17NG7WAwRj66u9axw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787354145; c=relaxed/simple;
	bh=WJB5UN7qXMgRWPDue3jQQwrP6vQbuDpZ3X36IUl1uD8=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=jwuvzQEpRO5gBPwfR/l47hFt7elAj2QUs5zSIltg+TJY31AjGPU5WdxbvtCqsL08svHdu+Ceg+QrSNAFaVZYgx9higj3d9k5EKkktV5DIMOquO4ajtvDeJK1It+R4l+W1dYUZjXH+MGe6EvtRf1Uj/IdN+xg+/giDuE7AqhYLUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TERIkAt3; arc=fail smtp.client-ip=52.101.48.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TERIkAt3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LMSASGl3g7aEzO1X+rqea6M6WMdRpXRdHL9yI1GjDZh5YCm2eAiFaBn+6xa+ph/KylaE8V2WZYYlTB/Ue+5AnADH6x0Ak8kjZPnZFabLG5FcqHScKHlGPmG7dPrzYuw7mEMBenWUP6YmYFcwB2gHADDwWQgvn/R4vYIAkCmMXgRFU15HbPMHX0R5ohiQRVC6vGpICgDiQnsoAaP+RzX0sJUbaKezUAkfH/qF7vUMLEFQwY+3RFdSWJXdnYgKDuCc/dmB2xZarpcM7d0juBn4Vgf7q10RvTtWLYodnGSwGTtBpqLbg1qNbVCvFFmqGp3GKZ6d1AiXRC2FS7ZFihWc0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gn/SFFVQsIaSj+JChEMfFqxrx/V0lxGU8zMZEJDZDvo=;
 b=i299/8jCrZT6wy+JgulZZoqHM08IbTphyC+YSM+44GONynWQNeGrHZmgiw3DTjEeRQOs6TbBerXVauNPU8iy/+WOeUqJKRKEoaGsJhttyWfXku97fFgvr6hnAKRhMirCsmoV6cuq8Athq56kl7aU6BgwPMETFvumjNANw926iQ/l4Pe/m5c9CJJC+FAfrMlJtt1SCBECpv9QtqeiRMYXHLbpMU7gt3INcyqGhed2pI8VCNAn/3EqqFp8QNNUHZEHKmtb3b/9+WiUAIchKdDBe6RCUmXv2Gy/xh9weGXEW39y0Ru8Dysa6XZl0qX3+lZVHIb1phJCR2VB8Y3VoMY+qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gn/SFFVQsIaSj+JChEMfFqxrx/V0lxGU8zMZEJDZDvo=;
 b=TERIkAt3b5A7xPqH0gHarSvHuG0XVMGVXEpBnfceJ54GCfYbyHlmu6i3PyV9T9v7ZA02SmWp6y5/RXyHUV7dcmM7E+WSpXynpxmVuOZHjI378QjQd94c5PGsS0owMthCCOZq3LZlQ2hve8YyioOFmCw0soA3xGB+D2ywCtXJn3RzzQASnEprJdcIOFvWrF4PgE1bpjxp26MWUCODz14YzjPg969aDOVBDe3GtmEwNEKONaZuZ0zoginqyz8ZUb0dvk1x7n6mcjsPlFenWVAivmO6C8d/1SqCTXWyukKgyaA/JdCFS8MZnLIyXHhns1BMXSXSxiVPBh3qjSbM2BumVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BL3PR12MB6402.namprd12.prod.outlook.com (2603:10b6:208:3b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 23:15:30 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 23:15:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v9 08/12] iommu/arm-smmu-v3-kdump: Reserve crashed
 kernel's ASIDs and VMIDs
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org, 
 praan@google.com, kevin.tian@intel.com, smostafa@google.com, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, jamien@nvidia.com
In-Reply-To: <28a26f13a91bf26a7b8215a0bea493627cd9c832.1784663184.git.nicolinc@nvidia.com>
References: <cover.1784663183.git.nicolinc@nvidia.com>
 <28a26f13a91bf26a7b8215a0bea493627cd9c832.1784663184.git.nicolinc@nvidia.com>
Date: Fri, 21 Aug 2026 20:15:26 -0300
Message-Id: <178735412602.18212.13784336777302966750.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT4PR01CA0275.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::26) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BL3PR12MB6402:EE_
X-MS-Office365-Filtering-Correlation-Id: 23fd8305-91a2-4902-2481-08deffda1761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|3023799007|56012099006|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	ql1xM1d7ESDCFFtq9h7PWmUxsIGcmGdTL4YSvjiKhjkBaFam/ZGGJROgfNVScYkMPsOxDkLSn04J1ZFIyd2dJPrDwVSVXajqm16Rjic2/+32djYOcSoVlEageoCvenoxLGUfW1LLSaQODygOx6Xil0yLY24THP5vNJgx7JxDKrLlHtnFNpOrlgbZGAlw/FO0f3HLk4uXfPu08dt4Z8DA/+GlHtR5USYY284GPc5OLa7+scccUFJJXxOW/bENqP1lEKXKW0lXZd+86nbD46nyWFJaijgjfgSekJpZVVLRxkV0DSINn+8/2wXR+kOrIlXQv87a6jSZMnsO6yfM0FfKDAZ3uMaEi1wjVvZkxMM2SfLG3RqNfyLbqeL52FQyNa1EdWbwlIv1fS+FqkwZtGWiOAJthgTTZk7Lrwh4mWjJXZ7+EpWdR9v2jzYMCp/yaqKCVFK3I0KiA4CNGY9Hz6+53yLZ4EY8u3lvYQ8f5XFghCRBX/ojuzhUHlF3oGL0vGYdUT1nrv010lCyJ40bPAJVhjmM1l9kXdmhvsFw4opn3eWDl/WS3XFmlwnGQgVPtveIUia7iCc4eVGT3G04IEinAm/lwiPHSvljGLDqKv10cFiNAb+NJ9/VPg2UemHRFdT6b+LMcTInnVXP/MmfDQ1QXEAADw5R4V/j8Gecd1nJhWo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(3023799007)(56012099006)(10067099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?angwTWN0eGdsTk1iQmlubmw5cXpUb3Jqd2NnV0x0Mk1jQW9ZZHJnQUtzeFVQ?=
 =?utf-8?B?TDU2ZVBzMk9MTzV5bEVxVytMSm9xWW8rNmh6MmRTUktOMXpRNHBvRzJROWlS?=
 =?utf-8?B?MUxaS1NlaS9TUVVOeDVOeWhtVVdCZWdtam9vTmd5amNZYXZmOSt4RytqR0tJ?=
 =?utf-8?B?K21Jd3ZwWTJpdjlxWmJxWEZXenAwdzVGTi9EeFVMWk90YTY0R21OemN5blVU?=
 =?utf-8?B?dVBqWWpKb0JSWGk1V1ArSytKdUxZR1JwS1pvOVB1OVVsM3BMWGNFZjhveHZ3?=
 =?utf-8?B?MUE0K0lVN3RtUlVzS2UxQnpjemRRREdpODRhUjd2NmM3Nk1Ec2RYN0Rld05R?=
 =?utf-8?B?TTBGT1E1Z3kyMjlrQ2ZJelpZa0FMVWwrZXJOYVp1bWFiTGI1RGQ2ckhDZUl2?=
 =?utf-8?B?WEdudXpJeHRIV1dXS2lXTHphdGtKMitJTXFHYThSSjRYSnY5OUZQTWE5Ri9C?=
 =?utf-8?B?eVI5YVVaZTFtMkdOQnljMytuSjNGTytVcXBRbEI4R1Q3ZXgybXRXTEl0MVdV?=
 =?utf-8?B?QmdzdFl4NHcwZmJxMU1PRWxhRUpLRnVCS0w2eUYvSFp4NDVLS2ZrQ0FXUGg1?=
 =?utf-8?B?MkhpalZ3MDdORzhvZjNTdjRVa2FHaGZadHd2eG1EaktWbXpsYXEyZmE5clJh?=
 =?utf-8?B?b3JXdURNNVJ4QkJ0QzhvVGhWcVJLNnh5bWdkeE1wQWRPTXJhbGVpODdteS93?=
 =?utf-8?B?Q0ZINVdlaEdqWXFEb2krc0xUTTlJa0pFTENJbjQ5TTQycDdqK0RHQW5teFN1?=
 =?utf-8?B?NFRrS082RVliUmNTSElPLy9FTDdKaXpTc3pVVUxOZUJaSHJWZU95bkFJZWRt?=
 =?utf-8?B?TWVXaElEUXBSVng2NndOZGRZeS9GQU5nb1hjT09lUi9mOFk4bThMd2h2endW?=
 =?utf-8?B?cjd1Nk15VlJ3QzQzeGwwQ2xjblVUTWFIU0tya0I4eURvb2xQZGlJaW5Wdnov?=
 =?utf-8?B?bUE2WnpxZ2hFd0tzb0JJbnRjOXhyQkFFWU9FVHFnRnFPT2gvVWVGM2x3eENa?=
 =?utf-8?B?K1RobGd1NTIrelkxSGFIcmFvRFlGZTdycm0ybHFCOXRGUHh5UmcyM2NUei9Y?=
 =?utf-8?B?WGdHWHVJbGRnaFRWbExDcE9JUzVRMEV3ZzA3VGlLWUMwbHJQTVVDOU1Ea2o4?=
 =?utf-8?B?STgzOGxLTDBUREM4SDNOakhob1plV2hNM3FmY1lVZXNRNVMyR2tuN3VaTmkx?=
 =?utf-8?B?dlJXOU9sTUdzaUZFRDduclhCRXJkTzQwL2FWWCtsbHJCL0RFUGZJM2hpRU9N?=
 =?utf-8?B?RjZ0bDlVTFFIUFNhOWNxU3hNcjk3MVVMSnRheE5iK241MHIvNmdDT2l0eVQr?=
 =?utf-8?B?TmZaZG8xMmp6d0F0L2lYUkpyN25qRHNtNnErUHVWam5GTjZzUFhHODBuR0Na?=
 =?utf-8?B?ZzIwekdDZHoweWtCNSs0SWxiUDBPRHlKN1VkNHVTQTdaZ3NFYnBoaVBid2ZJ?=
 =?utf-8?B?dTNHcGxhVWRILzluK0sxUk94VjVHYVVId3NKQ0VCdE01UTg1c1JndmpXVWdW?=
 =?utf-8?B?MVYvSDlJbDc1RnM5QjNsWG11d29rY2xCUW0xNHJnY2hnVGhaMDBtNGhJNENB?=
 =?utf-8?B?VDhXRGhWL29OeG9NK2RDY2ZwZU0yZXo0Qk0wZXBPY0QwSVpRcWoxaTVEUFF5?=
 =?utf-8?B?M0hVZi9XS0dsY055OFQ4aVlRTGFjUVNxUHEwOW5UQVl5dm16bHhQbWxkUjdp?=
 =?utf-8?B?eHFXTkpBQ2xibTFnYUZ5akppNEMzSGJQbUNMUnljQVBoTnVqeXc2T1JpUHdi?=
 =?utf-8?B?UTdxTElZY1crL01hSjNhYkpsWjVNclRKbFk1dU5qV0hKbnRYc1Vndjc1NTZF?=
 =?utf-8?B?WEpzb1NNdHY3NndIMW9pOGNwRi8wME1MaTRxQjBLd1NQMVpaemZCbXVDWmxp?=
 =?utf-8?B?ZzhqU1pPamdYcDVyaUNrSitCMzA4WnlaQmxRSXNnamRKS09BTjdjdWp1eXhl?=
 =?utf-8?B?WmVMODR6YzFHQ0EwNDhDU0NGcEhzcU03SkNOeDRmQ2Z5b2ZnUzdqUHVkWDha?=
 =?utf-8?B?YUR2aXpiUy9QZEZwWDdjSHprWlBkMUhjQk94ZWk2UnZtL0pDYVRnZ0U5NWs4?=
 =?utf-8?B?MHJaamZMOW5QSVJRU0lQREp1SGM3SGNWTWloQ0wyWkFSakppRExFT1pPdXRM?=
 =?utf-8?B?UWxUZmRtL3lxWXNYcGs1SzZObTN5SHhZR05KY0pqb0Q0OVd1b1VQN29WdWx6?=
 =?utf-8?B?ZUZQTGZiM3k4MG0vR1lvUlVldmNEL09yOHBsMXAzS3dvaER1ckV1LzkyNXp2?=
 =?utf-8?B?V2U3dkFxVnVjYWl6TlhaVVgxcTVyaEExcGdPNENlZHlNZjNZam1wQStGaThN?=
 =?utf-8?Q?urAT+hRJQ2yem7uif0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23fd8305-91a2-4902-2481-08deffda1761
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 23:15:29.7295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r+Cv60v25v/Z57OJyQwEiDbrgIxSutxmeEe3ptCulUfpKHs8caeMWV3nIZDImwz7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6402

> Nested STE's guest-owned CD table is in IPA space and left alone: its ASIDs
> only pair with the nonzero S2VMID being reserved, so they cannot alias this
> kernel's VMID-0 or EL2 stage-1 domains.

This explanation is a bit off.. Nested ASIDs have a unique ASID space under
their VMID. SO long as the VMID is reserved there is no reason to inspect the
(VMID,ASID) list.

The only ASIDs we need to load are ones in the namespace the new kernel will
use itself, which you explained here:

> Note that, on an E2H/VHE host, the kernel's stage-1 domains are tagged by
> the EL2 ASID, and the TLBI_EL2_* commands take no VMID. So isolating this
> kernel by a reserved VMID alone would not work. Reserving the ASIDs covers
> both the E2H and the NSEL1 cases.

That is a nice observation and it would have been really cool if this kernel
could just use a unique VMID and not have to worry about ASID. Oh wel.

Seems fine otherwise

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
