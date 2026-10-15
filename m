Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013042.outbound.protection.outlook.com [40.107.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7226F3E0220
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792083855; cv=fail; b=WN+yKkrYCohHDyeF2US27FfyVLkev25m6E3gR3ww73oPo5HXTXDVUKEJsxAO7WI6JsWHjYF1G2EiMyUGrP4MdyOlQaWWrxg5uKMXObFgm4S6ks4AJlQudWIR3enqm3Ny61RZh3pg/md6uQtnN0DERq1xDrOfDLCqW1pzGAEOf3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792083855; c=relaxed/simple;
	bh=XIb6vOeFbVoO6usa8Vr5r/wCCoDkPbU/5vKVZh7LaKw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 Content-Type:MIME-Version; b=tDrXrFh9AAj4enNAN0yeR9Kfcx2r9D+yt8qrFc/sfjGgkL+6ZiLRQ+9yCsNISWpAJmEXhm4/N89ob8EVl10zgkQ3wEPoHvQmzdv/uoS5RcsRpNe72cXBfNRMd7mdeEPJy3rzUafGB5n343snTcoRqZH3+IbLx5F2g9kAHryeTXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eI9GNgKo; arc=fail smtp.client-ip=40.107.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eI9GNgKo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0dbR/OjhNCwYEJm89FSEWIq4pSyqggaHHZ2SjNAhxWWTc8+Zg5b/7shedlyDrI7JN+ohKFFeG2v0HgH1nkiKb+MBALEHc88XtmvUdagoJluTryqX10EHqh4VloDABsVtpxmEmqK7Jwo7HkRTCd6Jksd8qDyawMDtiXGcfY0HsXoYITJgUY/2f/SvvwPomqOAgyhJgMdUDcwiJHXtdGS4CBaiu5GZiK2vGBpPflCp/rXegD9LcdMd0F4t9GuXPn38t0AsAc3pDLZ36VZqiP7FTUb/vWSC5G0ptt6mAoN/s+NQwmyNPt/5C4LNg2Xyx8pOPWIIRiuFnYGQZezUaEU3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVTCCxA5/LaKpDe3nl3FE0vSfuFzVG5I7D8Fjt30Pak=;
 b=aq9rnd+BH1ex6Ofx1W/unQBOxfQfcg6f6FOzk4GeQjh8oclz+vEEx8v5XtWAzsp0pm/ChTT4XugOLi9ObI6s3ILVGdUlEcKtkEEAW8lywMtYQ2qH1Je1M/QUuGw4LYmxaN0DcS6JLUVIgqRvkNaMgnl8H7jtveSsmEV0LyITsUTtwSyvLFRs9e9rdXAezhw3ZsLinZ9VSonMDt1xCjBfM/MPq9Wr680Oc/UFOXzvdnc9JBGY4qDxzSLerarvLsa2YctxtiYnGdcSAMCpRayrDvT4iIF+WR6Px0IA6lxcCs8YemVW65xGFkaskV8JBhXc9+pf6IX3ooHH3pnbE6xXug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVTCCxA5/LaKpDe3nl3FE0vSfuFzVG5I7D8Fjt30Pak=;
 b=eI9GNgKo933kD1iMIIqvmLHomq6r/fxmAyUh25KTtAFPWmgkG4x7bSIYwyznEcXbpPVNLfIsAWLdDL/Xyv/6d/KnOsiRNZBy0zYVZgNxAUK9Vc0sT8UyY6HeTq/+Vd+oVtT/7fPuCBxKNDCkJi9mCHqhtfc1KRnn6nTquwbpk/xO+mDmJz8IvKeeMUbff4c/kyg0gieeUCMj4PF8P7LU80gi2oewq///mlmjbvp6IShl1DTbgpndeJfzCtqdcCdBcT+kN/2K7aPJplRWtsH7ZtT75Kvykow06zpvwkUa/tlDeqvX+eeAKPhMUIiD9dKcawQ8Hm0WCe88kiHUMnCvwA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by DS7PR12MB6069.namprd12.prod.outlook.com
 (2603:10b6:8:9f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 15 Oct
 2026 17:03:39 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 17:03:39 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
 Shuah Khan <shuah@kernel.org>, Andrea Parri <parri.andrea@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, 
 iommu@lists.linux.dev, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261008125206.11990-1-parri.andrea@gmail.com>
References: <20261008125206.11990-1-parri.andrea@gmail.com>
Subject: Re: (subset) [PATCH v2 0/2] iommufd: Keep dmabuf MMIO attributes
 in domains added later
Message-Id: <179202508944.3602487.15486364906703222388.b4-ty@b4>
Date: Wed, 14 Oct 2026 21:44:49 -0300
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT4PR01CA0110.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::6) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|DS7PR12MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: 06b106dc-d7b8-4284-3264-08df2ade4196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|7416014|366016|56012099006|11063799006|18002099003|10067099003|22082099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	VQ4jLqGIVsZd0I4aKsWsFQAsff9Mc0W+LSNBW7Mnehnj8ViNbd9fgIWfzjsiLg9A0MMMsV1ZSJ9GYFmuHQ51c+Mclu1LZ1dUCz2ZbM14kXegFskly/FmN5HRhWje/ZN5Tw2qs2BegmFuwVBRVvm6Q9vXsn0B4um+KiueWuayy0Ay0Xksp59Tr84hDnp8q5SW0Cy1y1crawLenunawj23iv5d7zW2M3uul6TuvH3jx6ve88ODhMBK8FfPyaFyMerZ+fYnIOD9DqTZ+7IGmaRej5csd7AIDXQUPtP677DJuzUqF9bv6zi/kBq0MLK4lNCpkW2nY8tVb1WiGm/vX+hlZ+AytUdeDDMRqXp+oIPuGUxU6/85ta87SY2oOA6Q3dOHuwWPHgyPpQ5pXSUaq9stYdyHbiJ+s8S62UPuNDGvTb9DtP7nW27Cig4Uz6UA8BKucXoKgwaOffyqIIuzPBN+TcoosYoDAthEZENq4icMtVCQ7Dwd+sTn7ZoX2u/tMpyyJH1sJ7VlM6XY9zTsd1oHHgaRegFaExPxO+HNPjIg8uMuhd6dkrus/UikMKTrSt14v3iv6LiJ3d3rVosP6Naxvac3iqnS3j1c0LWVPS43WeZlJcsoOp2ygY9pBdPXR1bcEvZg+W50GPhn8wQCZU/dVt8Zxa1dSfj9PVCY37MS+pM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(7416014)(366016)(56012099006)(11063799006)(18002099003)(10067099003)(22082099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTR0RStKQkJLSjRDSnFUcS8xUFovWmE4STBQcm8vc3V6TGJDZDFVQ042WXFy?=
 =?utf-8?B?WE80RDBvR1F5ejJ3R0JoY1BJcFAyd2hYdFNMWnlCNTJSUEdneXQySnhhT1pL?=
 =?utf-8?B?TkRBVHplcGJQZklzRUZjSWlXaGFiNHhGUkxXNnFtZ1d1RHBSeWM2L3N5MEZF?=
 =?utf-8?B?blc2L3hwQldXYlBWYjJ6Y2VqU3g4SEdtd1FtS2cybXAzc3NMdGpvTXVLK0F4?=
 =?utf-8?B?enJITk8rRHZwZUFEZVMzYjgrZE00c29HajhNWlRxR0d3d3FFWk5hVEs2OThh?=
 =?utf-8?B?OWVGMzV1NC9BSVdOWkxPK2JoTU5qcG9YbUd0VFJWVXg0MGpvRmZWZUY2UmNQ?=
 =?utf-8?B?cmM2VzIvUlR2VDZBOHVoTDlmUlRRS0h2UmQ5RFJPN3R1S2JmSVFYQ2JLSTY0?=
 =?utf-8?B?enoyVUM0ZGJMbjhKTkRYVTEwcW40S1pmVXQ4TnZvSkI2TUF6YVVMY0lhTjg4?=
 =?utf-8?B?elhoakNxY0xaU05DQy9FeXF1cjh2SHlFUnNTWGRvS29IK1ZZajZxb3VNN1k3?=
 =?utf-8?B?Um9kSHMwWW5xTkh6VDVXSS9nWit0Z0VRN0FvZERrQXdYa2Q5VjdLRGh3YXY5?=
 =?utf-8?B?Zk5TdWJOTnVtUXVwakorL2J1UmdLbHZpbW11UXU4TjE0SGs3OE9UYk5RcVJF?=
 =?utf-8?B?ekxla2xMZnUvS01YMWtjSEdTVnFBNlc5Z2gwaW05YVJ0czdrc0NrOXgrQloy?=
 =?utf-8?B?RVlRL2ROSkt4RVpjNERidFFQcVNuenovWlErSGZtNTNRajFueDNVaEkxV0Q3?=
 =?utf-8?B?dk1LbTZjR2JWdE81U3JOcGtabHdWVmxjL21ZK3hJSUFvdjRHTzR4dkZNeXVO?=
 =?utf-8?B?Zm1RamFoemtqNUp4TlZNNEdYc2dyOU9MdW01bTA0RXViRW93YzMyT1JJL3VV?=
 =?utf-8?B?SjB6VWdPYWovV1ZWamFUR2UvTndPUlBJZGxSSEUwcDdSaDF2WXdvVnpYUGRr?=
 =?utf-8?B?aVFaQTRyclpQazFicXNjdHhlamk4bW9Da1VNR2pqVjI0ZzR0QmZXMlo0cFlo?=
 =?utf-8?B?c29ZM1IwdDd2UkprWG81OGNuclpRTFpNVHdCTmZUL0xRQkhmSjZJMGdJcENp?=
 =?utf-8?B?cVh3SzA5QUhVQkxKWGVFNGJ4MDZ2R2tURitUOWJlNFBuMDUxcVFxcmVWVVUv?=
 =?utf-8?B?c2xtTVU1RjZWeHhtNTBPaFVrTXVHRldzSUlkZ25IRUQrbUdvZUVzU0Y4Q3lK?=
 =?utf-8?B?aUlIQm00dnFldFhibkFoeEx5WW9kV3BDZGtFZ0RJalJ4WXdmL1dNOG1lNWpu?=
 =?utf-8?B?aVhQU0tSKzNIdjhsN1JGS1hWS2tXLzRFVkZmS2tBRnk1SjZWcUFybk00MS9u?=
 =?utf-8?B?aTNxeDR3YXRwVG1GQXB3dmNFcjA5OG9kZ0ZFOW95dUVDQitYWStMVHRyMkdt?=
 =?utf-8?B?OEsvYkEreGN5Vk9xblhQeFZCS1JQbWZYYnd6VGlpQm9hMjY1YndYVzEvL3RO?=
 =?utf-8?B?V2kybGpzRllJQWZaRDYxUFJhQVA2VjV3d0I4VDNqRkh1VnVmNU1VQm9mT2Mv?=
 =?utf-8?B?ZXVGNFlCTGZnQ1BtNGlQVGI5eXZtWU5Bd1JaWFVka2xyaUdhTEtsMWFoOGQv?=
 =?utf-8?B?c2VpTXBKeExQSWkrK20xcGJlY2UvWExTWFZtaEFUZllXdEs3ank1MHhBVDdY?=
 =?utf-8?B?Q29XTW5CQ3BaWUZmOXFzMldvS3A3TEZkNGRhL2k3MXdYZjZOejQza3l5R0c5?=
 =?utf-8?B?V2VtM2JnamJQYktlYllEL3BldDJMTTl4dVlYTUFtRnBSZFRuOEpackc5bEx0?=
 =?utf-8?B?Um1FTTVUdGtobmM0SWFrWkw2VWNiNHFORVdXMzJXamM4QlR6MTVYOUF5U1gr?=
 =?utf-8?B?SmcwVDVrUytFaW1CbWZJVUluNllzeHQ0UzlLYkhTNHdtb2lpcmpyMDRnM0Vs?=
 =?utf-8?B?V2c1ZUErSHJ4Njh6WVNEc0p6ZVg3NTFtL09Kc3d6K1NQbUYxZ2NjT0lqMDNq?=
 =?utf-8?B?N1BaNkkzb3hPMEVUVk9BcklxdjRSK3RsZVJGZVR0czJPcnNVMXZpRlo4OTF4?=
 =?utf-8?B?a2FIRm5uTE9ETDBDYVZ1VjJjS3ZUU1BuZGV5eml2MjBUb1NlQTZmQzVGN0Js?=
 =?utf-8?B?YlFMc3Z5NXlGR2R3b21uMGNEdFZTSUZGTjBTWkdiSnZTdlViV3ducE1KQ2tu?=
 =?utf-8?B?bkxCRjZXY1cxNGhVTkdQLzhRa2FqZ1NrUHh3OUZIaCtRR2ZjM1pmYmNzZWU2?=
 =?utf-8?B?U2lwK1RmZFFwZUtFYlVWNW1FRHFyZ3NjSmZRcXFzaElzUE1KY3ZlcVBwODZZ?=
 =?utf-8?B?R3MxL2hXSFYrQlVLVDZLSngwaVF1Wmw3aTljbEY1THZtbVQ5K1VnM1BldWtU?=
 =?utf-8?Q?GTJIqL7AD30muhKwBm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b106dc-d7b8-4284-3264-08df2ade4196
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 17:03:38.2260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OcnGP1viSz2ea68blBIFxj7HVFp8YCfM3XPmw09K+oHFmO8/8fdusJdxNx2HhVN3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6069


On Thu, 08 Oct 2026 14:52:02 +0200, Andrea Parri wrote:
> iommufd: Keep dmabuf MMIO attributes in domains added later
> 
> A VFIO PCI dmabuf mapped into an IOAS gets IOMMU_MMIO only in the domains
> that exist when it is mapped. A domain attached afterwards, or an
> IOMMU_IOAS_COPY of the area, reads the PFNs back from the existing
> domain and maps the BAR as cacheable CPU memory. Patch 1 always takes
> dmabuf PFNs from the recorded phys range instead.
> 
> [...]

Applied, thanks!

[1/2] iommufd: Keep dmabuf PFNs MMIO when filling another domain
      https://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git/commit/?id=769f2cd9226c96619d77fa16af84de74cae41b6b

Best regards,
-- 
Jason

