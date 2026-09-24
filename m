Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F21941D22D;
	Thu, 24 Sep 2026 19:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790278928; cv=fail; b=Fb1se+3mNcWs4YfvACGTLJXVyicAV7h+iDBPWOUSZirrdnWOFckJfCegfmArP4X7ZyP2+cDkrhVNEBGAy1GbERlw1iD5JRLCrHkNyNOGwUXmzSV8ckl28Yye8/18Uw3lbGLcctl5vOzQs43pvmlmM+L9F76DIAlOdct3/zPu5/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790278928; c=relaxed/simple;
	bh=EHwSWXYQUK0S1nMCih7PW2Y0H/XaTJzBQMWNSPkZWcM=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=rgyienOHmKJ2GD5VlQk9GGNWO2CQ8BLxfGwxTBIbuYrzV65Z4eIS+Je6V6t1LFvTec+exVfYezxkNFJzDhBMNXFjWjMP9VM32QDc36IR3vhgKK79bWHi/mBBskTXcD45Adxz68cGqW1/5wr/aa5LGKkmceGLtVd803VCSh5wZ6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ILMYQfck; arc=fail smtp.client-ip=52.101.53.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ILMYQfck"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qBqmHEySvhd8W5Nd/P1+SZShZmTjtQVY2Yqr4vBGfhFKglMlInCE1N/Nn+J3rFHry6pN7/anX5Lj97X406moGX8sLTthGUalpbgJhwnV8V8L5gpgpDQGc3jST0HkFrDrjv9IAGJbwKj+Pqj1LOTKcMKv0MVeQZp72wtxMKNI+tLOllxjye7to0DCNdq16tDmZrekiZ7ojXolSSU4JlYLSHOtsjzy/XHx/XvqLZjom6sfSC2wfFqqaMC8hdS3gO3adNy3CxxXiHoJ0Jgdr+pIJWKvXnflIIEmV3ng3tCxYx5N7+XIuGs5E7g1tKrIHlHSydVtjHZyaGsy9g8MJoh+2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRmX0QSvAsLWK19U/nDby/C1fVhn4l/29RzzrX3TevA=;
 b=hm69i2VdOVvASKuSeWS2eaMvdMpDEUXWVbs/KWwsZ+5LgAXz4FVothO0dVva+eI9bpFfeO359aAoMc+YmHlzECJRGtCGCBrh2Tt64dnqroNW8DZiXAQydXCdVYEFG4h+KCG1CIo2rwDZqpw5Lwphm+POihhrvisxRlIxQY1F/hJvWbKPOlNf0ltoU9Hx51DRyNHjk4sgNrEx6VFdeHPl3ztJT2EwIT6vQwCFfLJyHjwlKoB6S66y4wcsyCWm8TRhf7jcxTtZ6d0WGFaTVlLvmJeMOwf//3yvhhZOS6Pc3YO1PKm+gTg4LIYc5udno9ahIKIR/fRqt/lyI6k7ThYHrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRmX0QSvAsLWK19U/nDby/C1fVhn4l/29RzzrX3TevA=;
 b=ILMYQfckDlFKM7awhLaAL2TJ0KaoXrYP1TYxrUfz7zzslMau2NFIbk/e/SaEi1zPbWqDOc9ir+QlCdT9l5Fanj1mktuTNvC7R6vmd9KTEUYULKA1sowMvnq0qUdZomP/LKwI2kGBZg6ThsN57Zn/zF3b7GgF3cHpb5Dye3ve/AO+tBvl7QeZF1LBj/rG6QCq2GskkiZJxD6RNsRDhV8tbCFg6NSoLqfIIF8GR/NySplOFK28gYbP6DG0yUcyTujhNPWUYszLKNOjidM7Q/bylpOPhQ/5GaLBzvF+w/fpo61CPrnfNnYqGpI//xSToDaoNBWDMjXx7OML404m+b8oxw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by CYYPR12MB8854.namprd12.prod.outlook.com
 (2603:10b6:930:b8::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 19:41:58 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 19:41:58 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH v6 05/11] iommu: Add a helper to validate a vIOMMU
 parent
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 Jason Gunthorpe <jgg@ziepe.ca>, Alexey Kardashevskiy <aik@amd.com>, 
 Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
 Jonathan Cameron <jic23@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
 Nicolin Chen <nicolinc@nvidia.com>, Samuel Ortiz <sameo@rivosinc.com>, 
 Steven Price <steven.price@arm.com>, 
 Suzuki K Poulose <Suzuki.Poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Xu Yilun <yilun.xu@linux.intel.com>, 
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20260917140159.1163281-6-aneesh.kumar@kernel.org>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-6-aneesh.kumar@kernel.org>
Date: Thu, 24 Sep 2026 16:41:54 -0300
Message-Id: <179027891416.104879.10365675178574704349.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: SJ0PR03CA0072.namprd03.prod.outlook.com
 (2603:10b6:a03:331::17) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|CYYPR12MB8854:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f9a8428-ebfb-42c6-faf3-08df1a73e4e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|10067099003|56012099006|11063799006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	DGdZI+8GzEWQhTxpe10TSDp3zC+OO5+kvQrZe1icPxPWfPer6cWKgHDWJfM/lP2iiHSys7jmcVYuyM4ng5WI6rhHeETNCBNLvnXzg9S+T0OApVkN1Y398yeNKivEoLcy+xM9CTa8iPWd11G3u5oU0lveHQ99BAFRWy4VFeJcaLicS+QTHKiQ7iJT57RFl+1ePuBdLkGujNHAkfjX89p8iSdIkjeq/UrGJlUBoJb4vSja3JiwuL7tuSCyDnMDrZBb+8Ce8Sadp5NZnTB27pteEL2tPV0eZxWU3+vJ3AcVNr7RQqAznQ/Kse96ckf1YWyN5oPq2lsWCMZbdgrMC7OIGJFR5iB0RyzDY/mYgfYIiyUMP1vBwUixwvIdGNgW2HrncvDvZalDQw/fqlpTpZlfxDSr4UQHLSAMBiXisB5PL+vD/4nL+PvBQAUHDMDcxgTFlBFukUrY4Z6lP3dIBuAWT51VihOM56vdy7k+duD1LWAZwgAXaZENXaU7gWRL3Jge6U95Q3vynyaR5IPAHA7GEkG1lCH/gVRRal1i6GPB4r1Lge8jEHP6HISgYO9ZYxnXI7DfvDasRBnEQ7L65BgjCEVwAdYR0UrfERIBv6ZCSJqPsh9VvF9qoUTcaIYHMNzYSWacUDBfOii4PHJDcc6U3wzX886Ic+7syoFDlKARUqc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXVJaGZURW50WDdncys4Mk4xS3kydDQ1eVhzak5ITUtYcno2M3ZWd2FEMHpR?=
 =?utf-8?B?ZkxxUEQ2VFFweDJHRVg4Ly9oQ1owWjVOWkhSQkJXU2NIWk5QcTl3NzlZZHhF?=
 =?utf-8?B?S3dmLzF1ajFvUm5YSmdEN1JTcFZsTkc5akFmeDdmWThRYThGQUNYWmZ0dVpy?=
 =?utf-8?B?YmY2ejBvd2ZFTHpGZUdFa012Uk5RNnpPWkdKRTZjWW0zOStwWUZWQ3FoYjAw?=
 =?utf-8?B?WTBQb2g0MzJRWGwvaFNFaDJ1YUluM3R2MHB1S0xzNjdEdXhwTDN5aEJ4ZnVr?=
 =?utf-8?B?ZmNNZjgrZnkwV0ZXU21TdmV2RHZaNWt0WHk0U0c4SHpoR3BzUXc5VGMzeDVV?=
 =?utf-8?B?N1pnZ3pLMndqN3hOb0w1clhUMnBYUU11cUZsU3h3SVhEZ2dvUFFEVDNZSFVF?=
 =?utf-8?B?RXJCVnVsYlluTjdQc1U2NC92NCtISXFrL2dhT0xkaC9VRGxJL3RkeGZqZjVj?=
 =?utf-8?B?RWQ1UGtFZ2J6cThPOTE5MS8wZWp3aDdnZVR2aER2TGUrN1R2d0V6dXR3ZDMx?=
 =?utf-8?B?TGJPQ0MxM3IwUUEzWFBNRWpLTzFZbUJLREpnV2FHSllRaWFVYUZnK25pUW5Y?=
 =?utf-8?B?b3JSSlNxQWNHejZMQnBMT0JDZ04wcjNla252Ym9ZMm5MV2t1dnJ3aVEwQ2JR?=
 =?utf-8?B?UXdtU1UxdVN1cWRYU2d1WDVEenJXTFdwQTFHVkU5UnZYTXk1SkJKRStybkZs?=
 =?utf-8?B?RndYRnY2WkJyTkl3bE1OSkludCsvYUJhNW9NbXJCUlltcThhZ1R2QjRPVGVW?=
 =?utf-8?B?aWwxQTJxUTJiUkUrd3BiZXg1bDVOL2NyOFhvVTBuckpwSDNrTXd4YmxRSlVq?=
 =?utf-8?B?RVFRcXZqMEZOUDNWUGszZm9oYjcrQVBzaGtLazM1Nm9vWnF2MWFuWTRCS2pw?=
 =?utf-8?B?R0h6Q2txQlVlQVU4WUVmZURsMXBXT3NYSG5JdEd4MTA3bkZtNGZ0akl6aWUx?=
 =?utf-8?B?VDN5TmpGRkZLZnZZZ2txRE1mb3VEWnVpMnJHckNhazI3cGlVdFgyYTBYc2w4?=
 =?utf-8?B?dUhoN3lQZ0tTSTgzZ0Y2Q3lqNXdQWEVyMzYrdHdPMjR4Zm5RSmkzMUZkTXhO?=
 =?utf-8?B?My9OZUJUU0NYeXVIY1VxV2hzRkNXOG4yNzFsaFhHWkJEcklhMC9TZEZVdHF2?=
 =?utf-8?B?MHRUYlpzZ2RGdHBib0k4dnMwc2lXV1VtMGJKc0tQeTVOT2d6aXJwd2lzR3VG?=
 =?utf-8?B?V1A1MENNZ0ZIejlJS3FjUSt1YmRQZDIvL2xTT0IrUjVJL1RVOThhdSsxZmJG?=
 =?utf-8?B?ZW5YN2VEcSs4alNZbXdGeUZEZ2FBdnQxcmZzOEViaWVEQTJhWjRnV24rTC8v?=
 =?utf-8?B?VWVoQ3UwdmpERFFQRVdxNkp1M2ZMZ1IzOEV5UWIwK1c5QjRPOTFQKzd6YTBH?=
 =?utf-8?B?TThFWE94V3p2TGJFcUVFZXJXSnE5SndsTHFlSE9EY0N2QXZ2aTk1emxUZzAr?=
 =?utf-8?B?WGt3aG1BaThnNFBzeDB2RTA5WlBUdklqNXlWVGVQYlJQV0VXMnREMW9odW9U?=
 =?utf-8?B?ZmlNMHBCTlZhSndmak9hU0tvbHlZWXNoVVJEWTlPbVBXM3NYSWVzMUpEWjVp?=
 =?utf-8?B?eE9LRFg2czBRM2pYVm5EUzJZcTBlb2hlUFVDQXZ0MThGZTlyWWNGa1FrcS96?=
 =?utf-8?B?YnVVSHFjN0pMN29OZlhmdk40OTVTc1lFelFxQXYzN1RKRGswRjVmanA3T2Uy?=
 =?utf-8?B?SHZSYVBjMUkxZVd1NElUNS9hK2xEMitMSGs0TTM1ODZwWDJ5dmRnSkkzM1Rr?=
 =?utf-8?B?djA4WTE4M0hoYnBUZzZpa3B0RTl1VXZqOFlpSGFpSzA4L3JHWkFtSGNwSk1N?=
 =?utf-8?B?bVkyUitWMXlFMUUvZURpMWp5dmhWOUN2WVB2S21PaHpmWlRKSXpON2cybzV2?=
 =?utf-8?B?cFNsWFNweHVVbXBpWUE3SUIwbndTTTVzKzVzdUUvVklUN1RnZ2l6OG1WNVBi?=
 =?utf-8?B?c2QxL1hHbXIrTzBnbHJ1YTV4TnB5UGxGQVFvblBvK2lPc3dJOUJaRGt3cXZa?=
 =?utf-8?B?MlVWNkVGRXRNMFRlbGlUT1QxUUVaTVg4Rk5waW1NR1RJSTJsQ0MzQU85NHBn?=
 =?utf-8?B?NVNUaytFQzZIUncxYi9pQWVmbW9nYVA3R0dsMUVDSWxFV3dKcUVqMzdpY0x0?=
 =?utf-8?B?TlF5OWRFZWRTdzdjT3JvMjRCVVpibVdreGRhd08zWjJjdHRCTkF4eXRMR2Jr?=
 =?utf-8?B?dUJGcmltdHdpUXB4VjZUUDR6blNRYWNPY1VlR0lPWmVQcVNUNTNWaDFxV1pQ?=
 =?utf-8?B?UWd1U0d2eVV4QmZnUVZZQXBIMEFmaEh5SS9uRmNTQlkreDYwN0lGbys1TUNL?=
 =?utf-8?Q?3zuuEGZBOdmBoO41xY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f9a8428-ebfb-42c6-faf3-08df1a73e4e8
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 19:41:57.5086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /dMoqyjG4gbgdxQhxx4cSbjSeHBSMHgBPH4PCp3hnW3Sb/+SD0P41PUpz41t8mYX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8854

> [ ... 18 lines skipped ... ]
> +int iommu_viommu_validate_parent(struct device *dev,
> +		enum iommu_viommu_type type, struct iommu_domain *parent_domain)
> +{

I didn't see anything that calls this? I can't imagine what it would
be needed for?

The TSM viommu should use a NULL parent domain, it doesn't have an
iommufd managed S2.

-- 
Jason
