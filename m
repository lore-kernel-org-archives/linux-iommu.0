Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013015.outbound.protection.outlook.com [40.93.201.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A943EBF36
	for <iommu@lists.linux.dev>; Sat, 21 Feb 2026 14:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771684287; cv=fail; b=oyY7+6oZohH1ty71jNGAz2Wvq98Q2jPRQhmM5Wo/8t7RzwDSNIHN+LP/kUYxhTdwFhjlT+NZwgFRfGSGeqeceXM93N1J6tq/y+LsmOrVTkl+Vd/ZOWKC76mtjOdBI6uUSj5RIv+qlCVLHeURffARxPge/aFRupLhSo0LaYVQ7ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771684287; c=relaxed/simple;
	bh=OWhT6vdmhwMpArndeqMxdv/a6ibV1T9unPVuEWJQ0u8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vFMTBRxLwg2qKFU62h9lwk+bdMk40MmaGP26wyJMc1yRJ+u4eIRVA9qFJ0NnAGGzKDG/6aLj+pqTacy8p355Fpt50mri/VqKtIDO3dpCrRmu0gP5yb4jt0R7+Nsm/gFjlHzNFYJAF3Qq3oIgfYZY7He3uSbWZtG6hjlXt2JzqLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=szcBVYV1; arc=fail smtp.client-ip=40.93.201.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="szcBVYV1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WS2oV5wLsrXJ4ttlx/9Nrr5Qc3YdyTpSe0WFsqQXq2bsRKvaMXa1IJ3BKXfkIe7PjWDfLzIX0EmUM2AbZ6CH7Uc91l/n0cqup0u++tJQPx3fYl1rgOJRDJmWcTDLdMheyVmUyBD6xL2j+ENUxq6ryhC11AsQhG4TZ7GrEWTLWxNK6R/0xlfXcTwX71NaBh06w50KLTXretYn3FmmMm7P8Rku98dhErECVJEhbP3pXmJMVKkSIGHUA7uNz3P/i1Kw+7Tj9vRfhtLX/ZSjQkoq/KKMzREfHORXx0r2CrGCZYuxHAEEtM/ZzcsB2LCMS6NmV34ssMW6zgMvsMDnOjMzmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxV+CL7JGWr5bF/f+cy7Xk7/PbV3iQM5t8TFiuw1jYc=;
 b=xX07Qv2VMfzMr376OScyL492tqFhgkaOBfJ4lAhBIGOADXfh/VRLRqjiQjjzzcyUkWBIOBi1+OURGmm9+fZZt5vejSLbLJXwdowf0sQPFENruSJKiLFDw0R3W5H3UnXhteTE1AlmCUvTmpvZjrfvXr8kt8xFeTocP+VM3VremVhgfK3tAqC+6MbBq/IiJRBRX69WF4gfBMPqUlTCzPCv/qrJ7yiYmzcCKWx6MbXHuB5tF05W5aZlRdri02duqu0bYBFxpbP1XUysduHOsch4sSqBs/d4TVAnL50qLU+Q8nHffL4m9IyYrIHAe8AO5xf8Cvlsu2Kmm7u7o5kseC/WDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxV+CL7JGWr5bF/f+cy7Xk7/PbV3iQM5t8TFiuw1jYc=;
 b=szcBVYV1HsukwTS2HNsyg//d5mpiSrqvzShomZSuMViCFOn0BSACN/bmwtwU3OsAcSK/RaPGMvcM7NIh2HsRlv4d97fiflkHXizswzQjNGWCxB00D5D4vzgDOoUeEo+PWWy1WXzP8ScCEsVSIsTk0MPY3mm8tVxBtTehLibeh14=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5754.namprd12.prod.outlook.com (2603:10b6:208:391::20)
 by DM4PR12MB6327.namprd12.prod.outlook.com (2603:10b6:8:a2::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.17; Sat, 21 Feb 2026 14:31:22 +0000
Received: from BL1PR12MB5754.namprd12.prod.outlook.com
 ([fe80::b080:4c1a:f6e5:4564]) by BL1PR12MB5754.namprd12.prod.outlook.com
 ([fe80::b080:4c1a:f6e5:4564%7]) with mapi id 15.20.9632.015; Sat, 21 Feb 2026
 14:31:21 +0000
Message-ID: <49856fda-3f65-4fc9-a75d-84b29526f3fc@amd.com>
Date: Sat, 21 Feb 2026 20:01:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: AMD IOMMU issue with hibernate on Asrock X600
To: Johannes Stezenbach <js@sig21.net>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <aXeAOtGQUdlNZF6V@sig21.net> <aXnXX0P-XsEFPlJd@sig21.net>
 <52148f32-2348-42d8-95e0-49b30c29da1c@amd.com> <aYHerYcZ-5FOguKY@sig21.net>
 <aYNi4yYA2_Cu359Z@sig21.net> <aYSjoRjnR3N3D8lD@sig21.net>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <aYSjoRjnR3N3D8lD@sig21.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0263.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f1::11) To BL1PR12MB5754.namprd12.prod.outlook.com
 (2603:10b6:208:391::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5754:EE_|DM4PR12MB6327:EE_
X-MS-Office365-Filtering-Correlation-Id: f05256d2-19c6-4ebf-f2ea-08de7155e256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Njc0bVE2UzFkbHJxcTJyb0FST0xFcDY0SlAzOXBZYTBISUZ6azBzZTJlemRr?=
 =?utf-8?B?cEYrNStCK3FZajZteWpDaFEwSGVXYWZZWlRoUWZBNjZTUEhGRTVQai80SU80?=
 =?utf-8?B?UndFRlNlTUhZZlU2eDBrVGppZjdYTjRqS3pyeXMxamZwd0lCdyt0UGs3dy8y?=
 =?utf-8?B?RjM3Vzk1QXYrZjI1RlFORXFJZ005RHZQaHJ2WXVHN3hYRE9qTHJMQkplcVBl?=
 =?utf-8?B?Zlp0MzRWL28rZ3NHcUFvV1ZEZlhubXI0aStHNlN2QTUzRlJJQk14Q2s1bzZQ?=
 =?utf-8?B?M2dTbGs4S1hBRDh5STQ2Vjc0SiszRlQ4UFBTTytsVzVzVFhyNDhnejlWTG5r?=
 =?utf-8?B?VndsTUtnUW10eVJLL3F5ZEhmVWcwUGQzN2ZkY1JyRXd3R0RnZkMxUlpqa200?=
 =?utf-8?B?ZlBrSE9UYXRWZUowQ2llOVlYaGVWazBDbmUyR0QrZ0llME1ES1V4R1UxeWhN?=
 =?utf-8?B?YmY0V2JiUEdzK2cvMmZpZ3dWNlVIRTFGZGtsRWVsZkdCNjNUT2Rpa1FEc2I2?=
 =?utf-8?B?Qy90YTJ3N0lPUTZ5LzVEVWRnUWcvRGVkd0dzU3RFeUJhdldxYjgwd0c1cDZK?=
 =?utf-8?B?ZkhyblgyL29neEFHQUJBeG1Od1NwbWJYUGZPUktST3BnZVFQSWgzeW1UMUwv?=
 =?utf-8?B?VzMrbDNMRXd0TCtyeFpsL0hSTS9KTkxNZmlhVVNhSXlCYVJ6Mm1UKzRReno4?=
 =?utf-8?B?TDNkWDh0YkpUYmVadUladmI3YTMzNk1XaEJHZkZHdjRoRG5BK095QnpJUVh6?=
 =?utf-8?B?ZmorL2tWWEFxeUpER3pwT2ZseWJDTWUyYkpVL05iWTBybDY5cGVNemc2VGFQ?=
 =?utf-8?B?Zm1xRTJmaEFXdVhjSTJvN2xFc1pRcWJiYm83YkVEaWxqTW43d0FjSys1S2lJ?=
 =?utf-8?B?MUt0Mm1KZG04eFUrdTdOS1ZXbUtvVXRpVTUrZlh2VHJqWEttVk9xbTUwR3Zk?=
 =?utf-8?B?bmVIOEhpSkY4NUVUK2xRcVFwekJBNG5pSFBibGYzaE5uQkVxV3dGVUdJbVhQ?=
 =?utf-8?B?OVhuUk1Lek1EYVV6R1I4M1VHTzFYSi9xU0plRlhabUlNTlArcytCZTVaOGRG?=
 =?utf-8?B?MU44TW9jRHUrMk9Mb1VjZnhkcU1yZi8ySjd2RkpER2xWVGhLcTczRDFnRGJj?=
 =?utf-8?B?ZUZSNS80TUJMWFN6WGpsM3NyZDNuenIwL3h6THY1RTQvS0F5dlJQaHJwajBv?=
 =?utf-8?B?ME1FMG5QRnFjT1FXVysza1VySFdCUHh0LzFDb2VjdWszN1BaMHlCeFZVVlFD?=
 =?utf-8?B?RTZFRkRGV1ZVWXpaNUhuWjRPWFpTaDlpY2JBSEU3NDdvVzc0MHgxVWVyNUlP?=
 =?utf-8?B?SXFUNUhUa0ZzbUcrN05ZMW56a0ZoSlF3aXZoL3Y3MjBhN2g4QndzOHdGM2E1?=
 =?utf-8?B?cm1iQzF2Zzk3M2VRbDFSSi9zclR1dGpvNXUrbGFzUWNlZGp3Kzg4MGgza1lo?=
 =?utf-8?B?SEFWYXhYcllXSUFtYW9nRnczaHJMbXJVVHoxTHRXYjlkcllkeVVtT3Bkd1BN?=
 =?utf-8?B?dTdyakZOT0laWU9xVGF2RnBzWFJ0MG92bHJiMUJtNUhZdi9qM1VFNW1ENlJD?=
 =?utf-8?B?blJPMmtXL09mM3JzM24rZUhRQUg0TVEzZGFHcVNZdTdiQUdrSFROTmVYSi9r?=
 =?utf-8?B?QlM3Tm4vMnBLOVJkeGJxOUNLMXIyd2NpRENPV2J4RW9UM1dzczVBTVhTZkxo?=
 =?utf-8?B?YUJIWVNndnErNjFwTVovdWZidHJwT090L0hiclJOTkFISzllSzRPQzJCTG9M?=
 =?utf-8?B?RGI1RnNteUYyMDVmcHVwR094VFZLaFhJbUpyYXRoNXY0aFphY2krdGZSODFr?=
 =?utf-8?B?YXNXOWtVNWo1NnJyN1hvMGc0VlNBVGxlbGdqeTZweE5KYjUwR01mWWgzbGRw?=
 =?utf-8?B?Zi9xZThDSmVTbE9FdThabGJuNnorVkNWZyt3SmUySFUrM0lQam9XcDlVQWtH?=
 =?utf-8?B?ZEVuYnBlQXJYeURoVThyenlCZjZXV1NFb1V1NFFwZVhJcjhUbVN4UEtyRXZh?=
 =?utf-8?B?TWxmU0Q3UngrZDdrcnZTSTlwajRUVWk3MURIVUplaFd2dVM1cll0U2tEV01a?=
 =?utf-8?Q?hNOP//?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5754.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWJiZTVZSzRaQzdEbEw4cGViYmk4OFgyU2txRDlzZ1lINnBYQXFWc09VQ0U1?=
 =?utf-8?B?OW80bW02N01kcjkxRUg3TmZaY29rWnVLK3lnY04vejMxdU9LcEpWM0E2TVBh?=
 =?utf-8?B?V2NSQWJObWVHOU5yZ1pHUStVc1IxenpYTVpqYnNsbkdPUDhyekZKOHBMVnlZ?=
 =?utf-8?B?L2c2TDdaTTBobUZaNUV6WVBJbXN1NXNZeWFTbklIYk45SFhpdmpjUE11UnVH?=
 =?utf-8?B?ZjdpdWFMYlNYOE5weGwzY0pYN1F2aG9OTGUrZmtKeFdid0NGbHJ1aUJaSmRz?=
 =?utf-8?B?SlFzYXVqTEszdkdkc2JTaEhOa2RVWnluc0UzWG5hTzkrUGxmRkRubS9uMmEr?=
 =?utf-8?B?bUJhcU9rZG4wRmpGaU5iaVh0eUQ5aU9CMmpSRWVUUmUrZkk3UDRHTGkzSEt3?=
 =?utf-8?B?enYwaVhnNVB5ejgzTDVzOUZJQlpsamVWazZyL1NWWkcxTzdNVlFsejJXMUtR?=
 =?utf-8?B?bDFjREc3ODZlQ2FrZ0xOM2UwVFNSanlFcGFIMzFpaUlLRkNnVDVHbmM3VUsv?=
 =?utf-8?B?cnNQSzdXZFpOeVQwSUJZYTRKSjh5SFMxUXU0Y0lCNENVVWxMcENWcWU3a0xC?=
 =?utf-8?B?VGQ0TmNDSmErQ3JqRFRXUmJhU3FUMnBkQ0ZPZStQWHdJU1ZOQkNLQzgrYWpm?=
 =?utf-8?B?bS9odkY0d3RTaklMTW9ScUkxTy8vWUtNMEd3S1pkTHM1RjdlTnphMDdZY05t?=
 =?utf-8?B?VURJaUkwRUt1cFZXUEY3M1FSdE14eGpHMkRjdUdPRE56VFF0dEFOZDJ3NFgz?=
 =?utf-8?B?OXVEL1hzU21XclZRalVSd2NKK0crSkwxL1hFcnRGN2dZTUgrczQ1MFdtUE43?=
 =?utf-8?B?TkIwM1Zzenk1YXhlNitpZXI4MVRaRElXcGd6L3JqM3RsTzI2a2dDaTRKakJs?=
 =?utf-8?B?ZVRvL2pQQ1ozMmc2R1VKSks2d3pLZG1aVGhTK00vQThwRjFrV0p5QXcyVG1l?=
 =?utf-8?B?U3JNaWkzQ25uYXhnbVZac050dzV5WTZEYmhsRWVYemp4VlBWcXp2bWJ3NnZx?=
 =?utf-8?B?b2VhYWtzWXpEMUV0NkluMXFzOFhPdUR6Z21hME9hTDhZTWZlMVRBd3p1R2kw?=
 =?utf-8?B?WnlRYlc3aUFGMkROR3ZtaFE2ZGdvV1M2cVY3ZC9mS0ljWWV1YmIzY3gycHJD?=
 =?utf-8?B?dFVhRHJTYUsrbFBmVVZETmREdzF3ODdHd0lxSVVCL2ZkL2E1MW5JWmg3Rlho?=
 =?utf-8?B?OC93Tm9VNnFRN3IwNDVhZUg4RSsrN1NSTURMSTFOUWZwUGFQazNBRDFKVlli?=
 =?utf-8?B?MnhoLzUzTXY5VlhndG1hR2U4ZVYwVTJtcFhHYXF3dnArMkZtRzk0MnZTcHFR?=
 =?utf-8?B?RlFTU3RKbjlnTE4rcVMydGZoYzJUVFZFMHArQTJJN2U3enkzUSs4eUlGb0Rz?=
 =?utf-8?B?OG8xc2FzY0wrV3U4VFgvc2hXcnQrUVJ5QndiLzdKZ0Q3WDVZbWVYZHRQZ1RG?=
 =?utf-8?B?bVFyM0RoZlZEVGhNazd0RFRZaGxmeVBJUWJ3Ry84WDJxcmZ5bFpqWjVUNWhX?=
 =?utf-8?B?SnlFVWNRaFdjVFNWWEV4dStXcDljTkh3cTdJeTZ2MWJDMTdlc1l5cE1pWUVN?=
 =?utf-8?B?UGtKK2Z4TmhGVmNXc3h0UTMvdFZpS3Y1RTBLNE9SSEI1M3VBWGJLN3BpbExM?=
 =?utf-8?B?ZTRlOTVlTzdEamlGK0tzcXpURUlXS2VCYjNWS09sb254SGs0K2VPeitVNUlT?=
 =?utf-8?B?VFFJYW5DaXM4M29veUdGS3dTenFuVTdWVlF5NXI5V0NUd3lIY1VQcTBFcWZI?=
 =?utf-8?B?d2RjSm1lRlFIWGF5bmhvRUpYMTNtdjZGMFZlWEY3dm00VFhyQnFCUzFyYm1R?=
 =?utf-8?B?cnZiREpqdkhPeDNzRHZ3eUpiam9ma1JTTUx3dTBjMENNeDZzVE95ZjNLTEYz?=
 =?utf-8?B?RE1RZnZ4V0JCNTdldlNodmdZdWhFVnlYTHhLQXhOcTY5bEhLN3FqNnJWMUl2?=
 =?utf-8?B?WUgvZnQ3VkFiT3k4cmtnbXpUbGxEVmhwYlhuK2dzOGFPcFkyeDJSTTVIYmRV?=
 =?utf-8?B?aWFtWGxPeUQ5L09mL25rczdtbmZuTTVlU28vNTJmOWMwb1k1eDQ5SjZvbm1y?=
 =?utf-8?B?c3NBOVN0ZU1pS245NVJkWXR3c2hmaitBZW5pcTM5d3dwV09NM01MZmxqU3Ni?=
 =?utf-8?B?TGp4VGN5dGNrL2ZRZ0ZiTnk4YWNpdEpkU0xSNnd4QkJLYnFFZXRrZVJqWnhz?=
 =?utf-8?B?ZG0zQ0FFOUEySFMxV2hWTkdzdzRyVk1YOUNOektSWnNlaGJ4dUQzcFlpb1J5?=
 =?utf-8?B?R3hMSUwwT1FibkhoQktuMUJsc2VxSExCQm5rV0ZjNlpCZ3ZrKzVkVy9KRG5B?=
 =?utf-8?B?dDFRUFhTcENXL25vNGlzSjBUdm1NTGN1THgyNGxyTTVlSVBsVjdodz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f05256d2-19c6-4ebf-f2ea-08de7155e256
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2026 14:31:21.8175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U1ZBlvp3UquvZLiiubIUrZMICJkcSJKl0apVCIiW9C7s5pFn3uxv1jZo8J4ouHyZgqQjWy7wHgXqFPpicFwWrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6327

Hi,

We have managed to reproduce the issue internally.


On 2/5/2026 7:35 PM, Johannes Stezenbach wrote:
> On Wed, Feb 04, 2026 at 04:16:51PM +0100, Johannes Stezenbach wrote:
>> I'm also attaching the ACPI IVRS table.
>>
>> Side note: I wanted to check AMD documents at https://docs.amd.com/
>> but the "Create Account" button doesn't work. :-(
>> (And why do they require an account anyway, Intel and ARM don't...)
> 
> Eventually I could download the "AMD I/O Virtualization Technology
> (IOMMU) Specification" document (link on https://uefi.org/acpi
> is stale, BTW).


Latest public spec -> https://docs.amd.com/v/u/en-US/48882_3.10_PUB

> 
>> [074h 0116 001h]               Subtable Type : 11 [Hardware Definition Block (IVHD)]
>> [075h 0117 001h]       Flags (decoded below) : 30
>>                                      HtTunEn : 0
>>                                       PassPW : 0
>>                                    ResPassPW : 0
>>                                 Isoc Control : 0
>>                                Iotlb Support : 1
>>                                     Coherent : 1
>>                             Prefetch Support : 0
>>                                  PPR Support : 0
>> [076h 0118 002h]                      Length : 0054
>> [078h 0120 002h]                    DeviceId : 0002
>> [07Ah 0122 002h]           Capability Offset : 0040
>> [07Ch 0124 008h]                Base Address : 00000000F7500000
>> [084h 0132 002h]           PCI Segment Group : 0000
>> [086h 0134 002h]         Virtualization Info : 0000
>> [088h 0136 004h]                  Attributes : 00048000
>> [08Ch 0140 008h]                   EFR Image : 246577EFA2254AFA
>> [094h 0148 008h]                    Reserved : 0000000000000000
> 
> So the platform doesn't support x2APIC, but it's no problem.
> GALog should be supported.

Correct.

> 
> I added a printk for the MMIO_STATUS_OFFSET register after
> the wait loop, and a WARN_ON(1) at the end of
> iommu_ga_log_enable() to find all call chains.
> Below are the important parts of the log, it shows on resume
> iommu_ga_log_enable() is called twice:

This is very useful information. Thanks for tracking it down.

> 
> 1. from lapic_resume() syscore_ops via
>    irq_remapping_reenable() -> amd_iommu_reenable()

Looking into the code looks like at this stage IOMMU should enable interrupt
handling and in second call it should DMA remapping support.

> 
> 2. from amd_iommu_resume() syscore_ops
> 
> The first time works, the second time fails.
> amd_iommu_resume() calls early_enable_iommu() -> iommu_disable(),
> maybe this double enable+disable in quick succession triggers
> the problem?

Possible. Let me check with HW folks.

> 
> BTW, iommu_init_ga_log() is called everytime in
> enable_iommus_vapic() and allocates new ga_log
> and ga_log_tail buffers, but the previous allocation
> is never freed.

Thanks for reporting. I am aware of this and have patches. I will post it soon.

If you have cycles, Can you try below patch (untested patch we will test it
internally next week)?

<--
commit fd6196203c8637951e56bf144015c020f57d5a34
Author: Vasant Hegde <vasant.hegde@amd.com>
Date:   Sat Feb 21 19:48:59 2026 +0530

    iommu/amd: Skip IOMMU re-initialization if already enabled during resume

    Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 384c90b4f90a..eb5bff024f95 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3058,15 +3058,23 @@ static void disable_iommus(void)
 static void amd_iommu_resume(void *data)
 {
 	struct amd_iommu *iommu;
+	u64 ctrl;
+	bool enable_intr = false;

-	for_each_iommu(iommu)
+	for_each_iommu(iommu) {
+		ctrl = readq(iommu->mmio_base + MMIO_CONTROL_OFFSET);
+		if (ctrl & BIT_ULL(CONTROL_IOMMU_EN))
+			continue;
+
+		enable_intr = true;
 		iommu_apply_resume_quirks(iommu);

-	/* re-load the hardware */
-	for_each_iommu(iommu)
+		/* re-load the hardware */
 		early_enable_iommu(iommu);
+	}

-	amd_iommu_enable_interrupts();
+	if (enable_intr)
+		amd_iommu_enable_interrupts();
 }

 static int amd_iommu_suspend(void *data)


> 
> 
> Best Regards,
> Johannes
> 
> 
> 
> Log excerpts:
> At bootup:
> 
> [    2.609023] [    T1] AMD-Vi: Extended features (0x246577efa2254afa, 0x0): PPR NX GT [5] IA GA PC GA_vAPIC
> [    2.609036] [    T1] AMD-Vi: Interrupt remapping enabled
> [    2.643865] [    T1] AMD-Vi: iommu_ga_log_enable status 00000118
> 
> [    2.643887] [    T1] WARNING: drivers/iommu/amd/init.c:956 at amd_iommu_enable_interrupts.cold+0xf/0x9d, CPU#4: swapper/0/1
> [    2.644009] [    T1] Call Trace:
> [    2.644015] [    T1]  <TASK>
> [    2.644021] [    T1]  iommu_go_to_state+0xb20/0x1830
> [    2.644031] [    T1]  ? __pfx_pci_iommu_init+0x10/0x10
> [    2.644039] [    T1]  pci_iommu_init+0x15/0x40
> [    2.644047] [    T1]  do_one_initcall+0x5b/0x310
> 
> [    2.644137] [    T1] AMD-Vi: Virtual APIC enabled
> 
> 
> S3 suspend + resume:
> 
> [   55.915000] [ T3615] ACPI: PM: Low-level resume complete
> [   55.915029] [ T3615] ACPI: PM: Restoring platform NVS memory
> [   58.883988] [ T3615] AMD-Vi: iommu_ga_log_enable status 00000118
> 
> [   58.883997] [ T3615] WARNING: drivers/iommu/amd/init.c:956 at amd_iommu_enable_interrupts.cold+0xf/0x9d, CPU#0: pm-suspend/3615
> 
> [   58.884026] [ T3615] Call Trace:
> [   58.884028] [ T3615]  <TASK>
> [   58.884030] [ T3615]  amd_iommu_reenable+0x57/0x70
> [   58.884034] [ T3615]  lapic_resume+0x176/0x260
> [   58.884038] [ T3615]  syscore_resume+0x5c/0x190
> [   58.884040] [ T3615]  suspend_devices_and_enter+0x752/0x870
> [   58.884044] [ T3615]  pm_suspend.cold+0x2e1/0x35f
> 
> [   58.884167] [ T3615] AMD-Vi: Virtual APIC enabled
> [   63.874343] [ T3615] AMD-Vi: iommu_ga_log_enable status 00000118
> 
> [   63.874351] [ T3615] WARNING: drivers/iommu/amd/init.c:956 at amd_iommu_enable_interrupts.cold+0xf/0x9d, CPU#0: pm-suspend/3615
> 
> [   63.874382] [ T3615] Call Trace:
> [   63.874384] [ T3615]  <TASK>
> [   63.874386] [ T3615]  syscore_resume+0x5c/0x190
> [   63.874388] [ T3615]  suspend_devices_and_enter+0x752/0x870
> [   63.874391] [ T3615]  pm_suspend.cold+0x2e1/0x35f
> [   63.874394] [ T3615]  state_store+0x6b/0xd0
> [   63.874398] [ T3615]  kernfs_fop_write_iter+0x159/0x210
> [   63.874401] [ T3615]  vfs_write+0x270/0x4c0
> [   63.874407] [ T3615]  ksys_write+0x73/0xf0
> 
> [   63.874563] [ T3615] AMD-Vi: Virtual APIC enabled
> 
> 
> S4 hibernate + resume:
> 
> [  113.664694] [ T4023] PM: hibernation: Normal pages needed: 594162 + 1024, available pages: 15549652
> [  114.020974] [ T4023] PM: hibernation: free pages cleared after restore
> [  114.020993] [ T4023] ACPI: PM: Restoring platform NVS memory
> [  115.909880] [ T4023] AMD-Vi: iommu_ga_log_enable status 00000118
> 
> [  115.909892] [ T4023] WARNING: drivers/iommu/amd/init.c:956 at amd_iommu_enable_interrupts.cold+0xf/0x9d, CPU#0: pm-hibernate/4023
> 
> [  115.909926] [ T4023] Call Trace:
> [  115.909928] [ T4023]  <TASK>
> [  115.909931] [ T4023]  amd_iommu_reenable+0x57/0x70
> [  115.909936] [ T4023]  lapic_resume+0x176/0x260
> [  115.909940] [ T4023]  syscore_resume+0x5c/0x190
> [  115.909943] [ T4023]  hibernation_snapshot+0x292/0x590
> [  115.909947] [ T4023]  hibernate.cold+0x110/0x491
> [  115.909950] [ T4023]  state_store+0xce/0xd0
> [  115.909954] [ T4023]  kernfs_fop_write_iter+0x159/0x210
> [  115.909958] [ T4023]  vfs_write+0x270/0x4c0
> [  115.909964] [ T4023]  ksys_write+0x73/0xf0
> 
> [  115.910063] [ T4023] AMD-Vi: Virtual APIC enabled
> [  142.633907] [ T4023] AMD-Vi: iommu_ga_log_enable status 00000018
> [  142.633912] [ T4023] ------------[ cut here ]------------
> [  142.633912] [ T4023] i >= MMIO_STATUS_TIMEOUT
> [  142.633913] [ T4023] WARNING: drivers/iommu/amd/init.c:953 at amd_iommu_enable_interrupts+0x4d2/0x500, CPU#0: pm-hibernate/4023
> 
> [  142.633937] [ T4023] Call Trace:
> [  142.633938] [ T4023]  <TASK>
> [  142.633939] [ T4023]  syscore_resume+0x5c/0x190
> [  142.633941] [ T4023]  hibernation_snapshot+0x292/0x590
> [  142.633943] [ T4023]  hibernate.cold+0x110/0x491
> [  142.633945] [ T4023]  state_store+0xce/0xd0
> [  142.633948] [ T4023]  kernfs_fop_write_iter+0x159/0x210
> [  142.633950] [ T4023]  vfs_write+0x270/0x4c0
> [  142.633955] [ T4023]  ksys_write+0x73/0xf0
> 
> [  142.634072] [ T4023] LVT offset 0 assigned for vector 0x400
> [  142.634583] [ T4023] Enabling non-boot CPUs ...
> 

