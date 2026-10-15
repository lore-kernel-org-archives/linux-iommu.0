Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010053.outbound.protection.outlook.com [40.93.198.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC8D552937
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 19:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792092941; cv=fail; b=IT+G/GtiZ7+2PZDTtnKngIgp19z73INpIajGjEQJ125lryymJ4JuCWKwPaSXQs4HZQce9EsGzkYMezdhh4JEPtwbztZtZJTK/kSPhsicHwr5pKk1BgdgY0l0f0rhWZCch6IoiMdIuMBUIaMG5ynX5zMb1fnDKO0V3kdvR3i83BM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792092941; c=relaxed/simple;
	bh=CRK2mZ9lufI1u7BHLzvFDU6mcFxW8OSaiYsF3nunhJY=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=jmvr2Cp7zl+l7lIMbBLmbm7VHn4zwuERJeMAbDbqxwPqhQuFdIykMxYtPmW1fUIz7hpCWmQsgsEeEsNKwv25ykWhjs7LmFZkUP4gtpoH9xgJZ5Cm2Y7WNQMv2qGP0hLAojaf+9KM74LEKurLOb4zYjuPSi7t4xhUqw53NHrRdf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y5G567rH; arc=fail smtp.client-ip=40.93.198.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y5G567rH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZqyAIM6jvgdSTsmMZ1ktFqVNpLLIoHkcgDmHSNNvS5QQ3cxrfEblrDAmGz0P0U2zm9mayZkVn1QXiZZ6tzkhUy+ZrVHg0eZYmI06DsMZDRkTRMbQlw4rw7VWrvX4+wA05SSLSUPg7/gwDY9/l5Ymey7zIGUIzynioPXSgFtGyZhjev8wvXQnCUlH+JJ0FDQ4pYvgWFB7luj8rQcoOWhbp8kt4ReLe2jChKtKRe8ptZbFzrOzdM2+kocyVeyC4KzwVToOldV4D79Oh/RTNvmTyJrnbPVYlHHmyoSLKiygL385NGysUkcYwwYhvsEMZ7YZWxGF0/p/ssJv3yXNJetfzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGYgelM93/+Gz+YN39xm5gRIadHsBLSuypjgX8D8xOI=;
 b=ijHomD+T0QXsL0Fh+XnGsaSO57Aos7WwJQCD/sm6eHLCDnXk/xl1SGSwGX5zveZ7R5drMlSf8lB9zkfckbA9Zb/QuFINHJBhAZAHfMK6Y3uu1svHMzrLpSbXcAc7G0RU4gmQNl6a6ZcKxVAbVmqgj5eET6JsRUwuAd5XsMB2lFG3yErXwlDQNloV4Lk8eRo4dlbbI84W3KBGz8JqYzv/WhJGwCFJKrInuJtBTsP+JKeFpqFPlz4su0rxMv34gKOrJBB9YqCYOZzWxuz1ivfyOVYD5e2IOkuJUYEMUO/ucToVawlz5SV5QYvjn2dFVTq6eF4ZcS3NlhXL/FYuz3ZqWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGYgelM93/+Gz+YN39xm5gRIadHsBLSuypjgX8D8xOI=;
 b=Y5G567rH0hOIq/vZBpHluYHiEqrpwlE2XVRHOBFN7zqOK4c5po1GQzyY4o2ufup+ulBbUs8SV7ehMIQkPlzs/wnOT4y3aWyNzpvYSYh6wnb6GGqU49rIzKxJ60z+q1AujIzLeci9oW5lr7YZEmjXCgtHWjp6Bx8DxjMV1OOwaPjYJtckAJ68l+YQTs6syEm7/t7O0KYA2UVvlEibAKm9HWlelJlqdbtBJb8N5jMRJ8/v+EULU2h02FLz/Y9aN8SoswT/xpQe1hQ9GOG60ieSbpHrvYMq6nyVNpL8odSn21JUHoZHQzgBRsJicYxGQ4SuqbTkd8ijDt4S6z+XZyY1Lw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by DM6PR12MB4220.namprd12.prod.outlook.com
 (2603:10b6:5:21d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 19:35:30 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 19:35:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 02/16] iommufd: Convert struct iommufd_sw_msi_maps
 to a growable bitmap
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev, 
 tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org, 
 will@kernel.org, robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com, 
 anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com, 
 fangyu.yu@linux.alibaba.com, Nutty Liu <nutty.liu@hotmail.com>
In-Reply-To: <20260925151659.419512-3-andrew.jones@oss.qualcomm.com>
References: <20260925151659.419512-1-andrew.jones@oss.qualcomm.com>
 <20260925151659.419512-3-andrew.jones@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 16:35:27 -0300
Message-Id: <179209292715.4133959.14767250874938909695.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT4PR01CA0097.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::8) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|DM6PR12MB4220:EE_
X-MS-Office365-Filtering-Correlation-Id: 41072eba-bb78-455c-d0ed-08df2af37875
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|23010399003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ck/+a00HG78z7cRZZPjfY3k0dsh9nVBjC/K6cpLQTzRjNvhV3huA5m1Nv96yyqpetgP10KdA3HDRt3gksmMg55Td6DR6djjt8rBpNLMiMINPmxdolZyMrtDYNVGscJr5r25IjWeaSZaMtpgVA2eNuJxzx1eAu8RNTIjSjnPoHYUbwJyic50wcK73Mu6WCMdcdd47PmTElXno8OAoAStux8ok9h+sGh4wRL8IDNiNkj12OQSVxjCs74FkaLtTN/rMmZeoWVjlOQg2wXuErvIeRugKg9JfDmaJEsowU+OlJ5x5NOecE7/1U7AbREbrCjnVLWPZdeJphwRBS6/wNHw8LlxxUWRp+1Oa56UFee7PrcjGqlS9vRKbrZDbNg5mfJt4RLlGbEbxzMFJAR8WCaglWVoZQw0OaYBkjhbJsmltvk7q7mWx1JEsMkJbUGAKtu8XBUdlBWqE4DnGeY210ZvzpMlXxCsc/9KAllIADaX1I1WXeL50dW1esQ1V7tRUy+ottQEYeLVCu3/L8I/KIEezB7UPtdH8M3v6lKRaeZKA3guiH4ooMmpO+MiKtHDTk3QugHJ8Im/4SkPM8UvP+Ne6tRrnGVeEZkLVeYkycECLEm5feLa9hiOvXbxjKNHtFAHsyCYV//xQiDeQ+Whoo7dBrnKYSrgMaKWHcnCxJHFkTE8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N05RQmFFd2Q3cHd1UDhndGZsa09DNUZiR20vZFFDa2h0VERBeThPSHppL1Fo?=
 =?utf-8?B?ZUhIenFnMjYwVitBUEJkVW9OV1JKL01McXBOSjZxWW8rNmZRVUtpTWhocWhy?=
 =?utf-8?B?S25rVThkL1lVWnhxTXRYdkppWFR2bTlIb2V1Y2xhNzRBamI3WlFSYWtOZy9N?=
 =?utf-8?B?MHJtVTdJbVdaQ2l0ZDZ5OG16ZjRKV0dNOTBXdlN4ZERmbWJEYVNobjdmYW1w?=
 =?utf-8?B?ZC9oVDdlQmhFMVdmYzg1TVdqS1dCTms5TW1tYmluODdUZVNhMWI5YytPSmhq?=
 =?utf-8?B?WHZGSUVscEg2dmNkOHVOVDVVUmJJUmM3b05BQUt4OGZ1UlZwTGhGRzNKL1Ey?=
 =?utf-8?B?VXIzRFBYYjBpMFV0RHdVSmVxVTI5WlArd08wTkgyTWxlL3JZKzZWdFV0eFo2?=
 =?utf-8?B?MWxtSWZRUGRvcXZjR0NGbFUvd0Y1Mk9aRmpoSy9lOXVWSytHNGpHNHVmVVY5?=
 =?utf-8?B?N045SzF6dlRMN3dWVjZFOUMwemplVGZrVVdpci9mUDBqYUNGOTVLd080NGhz?=
 =?utf-8?B?ek9oRDNXQTdTb3g3N1o0T1VUNzIwdUN1aVlHUDI0VnFQeFQ1RWpLejRMeHkw?=
 =?utf-8?B?T25UR2JHek1Ja3lUcGVDTk9uWFdzc3ZmZU5xZitUcWMwWm4wMmFOREpDVlFE?=
 =?utf-8?B?Q0ZFWS9GOTdOT3ppQ3NtZ2V3SVFqVnhKT2s2V1FxWUZZcThxcy9iQVZ2YjRp?=
 =?utf-8?B?OVUvcHFTVmc3b1paVUxrSzdMT1hLTE01Zml6V0FYN0lMTUE5UFhiN0hsbTdz?=
 =?utf-8?B?NzZGMkRqUktSbHB6cXVFZzRpanhGdmVXWWc2eDROM2podzZlbERDUGRxYVJC?=
 =?utf-8?B?aTVpeHJOVkszQml5U3JyYUpqS0t6VzR4bjFpOVpKWTA5N0FMSitZMk9LVGsv?=
 =?utf-8?B?eE12c2RSZ29sRzY3S202WU1IN3Q4U3Zxelc3UGxjVUFvRGlURFJSL0pmaEMy?=
 =?utf-8?B?S2d5R0k5VHJ0Vko5RE1jdlhkS0lNdGJIN3N1Mk1DNWhnZ3FBMWVSS1Z2WndJ?=
 =?utf-8?B?MmM2WmMyNURVb2V1TTFvTDRodWlCUndlNDJkMCtvOG1ZOWM3OGxCdXVxVXFj?=
 =?utf-8?B?OUFrNTRQYlhaZWJrcm5aRTlmVm5SREJDZXNFeDRZMk9rRHFHd2RQVFprakJK?=
 =?utf-8?B?cENmZDRVbGJJRGxyYWVNb1oxUGppNEI4Q2Z3UmRoeXZ5RnkralNwYy9MRUJJ?=
 =?utf-8?B?T3RyM2NLclAxT2NLT1BsLzUrR2xBaGhJR3U0YVFtUEFZRzh5aHNJc2MyYWJo?=
 =?utf-8?B?SG9tem5YMTlsYzZ0ekhud2xLemFscXl3RGhmRGJVc1NCZVVRTDFuRHVPMCt6?=
 =?utf-8?B?bXF4T096WTJqVXZNSVFEbkxqY2pWNzlnMzFDWlFMY245NG4rNFBDQjJWWHFy?=
 =?utf-8?B?QWEwNXVPekFBb1ZyRzhOZkw5LzNlVFdNcHJoZXpJM29La0F3ZWJiYVFWSHdy?=
 =?utf-8?B?aGJPcmk0NjhPQUpYSFkyNzNZZ09KeDhvdUo4Z05nNy83dzZJcFJmMURGSDBs?=
 =?utf-8?B?Qi8yRC9RekRpZU5kKzl1YVlhTUg4eTRtc3BOWDZDTDVINHdaUG5BckN4K0dh?=
 =?utf-8?B?MmR4RmxHdkZmUmlrNnFoMG8rQ2MzeVNFUzhUa2FXSEVVa3l1T2NsL2FMQzln?=
 =?utf-8?B?QXE3SDk2MGZkazFyTC9TS3p3ZXZ5NURNMmFwRHBkU0QraEN2KzdTdEpmQ3Z0?=
 =?utf-8?B?OGhRVE1UMHJBNHk4VmplbWp5YjRIak5hVzU2M0QzL2loNzI2eW1RMzhWOUkw?=
 =?utf-8?B?ckIxVmxmZjRuU2NUaThBTE9Nbk84NHpkNnlHQW9zNDZmK3ZDcUpMQW9jRlZs?=
 =?utf-8?B?SlRNYWJrb0Y0VHpRb0hIOW1tVEVWYzRiUmZtRFBzZzB5ajFwSkNBZnJkNFFD?=
 =?utf-8?B?NWpvNHdrUmx6K0I0ckpCRTNUbEpFNC9sRlNOcVo0eDUzOHZVeTRDMWQwTW5O?=
 =?utf-8?B?ZkorVkNBdjZtL2M0RGZicjZiUUFUWkFaOVozSGlNeFV1dWlqWnArOEVnRHFN?=
 =?utf-8?B?Z2R3OHZhR2hZbEF3cmRUL1JBVk1MWVd1R2tRdS9rZ2h2d0F2V1phaDhNOGJ0?=
 =?utf-8?B?TGNsc1RTWGNCdlFQVjVGMGk4ZFpsVDFNc09ZaHRPNzJLNllCTXFCTE5MOWQ4?=
 =?utf-8?B?WTk1RHFDbS9OdFlDc1FpUmFaV1FSTlNSYlBzZ243cllHaEdSaHhJdVdIb0lx?=
 =?utf-8?B?SDRLYVF6ekZUeGhBamphNE9EcUJxaG01OFlIN3p6TG5JUWpmUmRLeDNyZDZR?=
 =?utf-8?B?K1VJdGoxOENhblg4VGhod2pPclBTcmlCSDVmd2hyNCsvQ3BObHlZcUs1TFI2?=
 =?utf-8?Q?wRuAraifXtNAM535FW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41072eba-bb78-455c-d0ed-08df2af37875
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 19:35:29.7581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ibk/b15gUUkk7xwUsvj8X+RivtGtXfLgv+8a59qr3coWnTxwFbO3fkBK4LSkS1h4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220

> struct iommufd_sw_msi_maps uses a fixed 64-bit bitmap, limiting each
> group and hardware page table to 64 software MSI mappings. RISC-V
> interrupt remapping needs a mapping for every possible CPU, so this
> limit is insufficient.

This seems like the wrong usage to me.

The mapping bitmap is supposed to track mapping requests, not pages.

Prior to riscv those were the same thing, but as Robin is going for
riscv really should only make a single request to make a large
non-contiguous range.

Since we don't seem to have a use case for two of these we don't need
to have any of this tracking. If a range request comes in then it goes
to the start of the reserved SW_MSI range and that's it. The page list
is always the same and the start is always the same, so you don't have
the ARM problem this bitmap is trying to solve.

Simplify it away and a bunch of these patches disappear.

-- 
Jason
