Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504511F5433
	for <iommu@lists.linux.dev>; Mon,  3 Mar 2025 11:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002159; cv=fail; b=RF31mlr3QHGrgWupxcbj5srgyIR6KQfhAOsvcng2f6hiXptIMhdssfc8r+GqnBfIHYbV5YIp80PJFV+oa29i3xAEA28rcYkFRh6O+kawzwN2rj9lqoYdqExQ8XIFfFNtnfItr70qsIIInGuG+cm7TeOf6mPsPQTMMxrTye20WQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002159; c=relaxed/simple;
	bh=EWUuOG15CKPUceCUfoyk2lwqSGHldca9LxLqlzjRMO8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hoekrb4WP37S7OcEiGyU31G3kJy0vnveKwGF0txLZQga7orcqYJ+h6JnpiBrTWS/GHSpEAsAUOfb8bEw+j+rCmjekA1F6HwMYwtTB3i65r+4n6h0jOR5CAmk2M3BuVw6PA2ETAn1/Tsr5qSUPp7buO4AqyK43NHohAWdPSGryFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4GRoDjLL; arc=fail smtp.client-ip=40.107.220.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4GRoDjLL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s2E1ctdGAm3jkgMIuazX9fv0P1VmSPZczgywn4eDwFEOEqwFxndW4L7Yi2Of2zxsj3RNUzs6NkzLOjAnf0qlF2jd5l26A53R4yiGIBPUQwj3K7zEMwfsBb13GpuJL5k+in5PEcV42ROs71RmZoa3LAcPrC7zNAS/CSXOzfBq/pOsQ/U9tWtE9EGiUtKYxNaMggyNSzJEL+PNd1iCvSlwLNKSp9BJKaYYJb1KboAgDPJv4fXHq3jGlqf/eFeDvtCPJw9nevHV2QRwbPA+Ums40VVdjuQRd20Psvx6AD9pjYuAttD/7m044fCUXDu7irRa+UvwSovPNpMEkqifNar7ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kR0WFoyXXgIBHtyr0gkMhW+FAfI9h4vpVOXpSrt5Hwc=;
 b=o6Gpr+SaZjf0Ibsa8IFjBnK3sWv+pQGu3p3HuNZU+sWqw/YmUqpR9SYyvgJ0a75W9yF51H6NBGIeSC0Hw0iFrH/uehYzPGJik1JtqQS+dcIRIP/TDN2Dp6Bz3x8NQLRf2+yOZNJJ5yuBt0cq+8G5OaaAWkDAGPRPTSdq3IUZQdTE8BFDancQxk9HVgtcsFRlAcurupEiNmBxGTNYKSRL3/cx2n3SGqBeEN1dGhK/37lfmjMsBKdxcSA+/GF39Xr+hn+yoVTGV95jhLgar6t86fMnVlek+mFkDFrr60PfY6iXIUQBcBwQiz3Ye6CwZnBMdnRtlzTi+/Z+suZDxuLyIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kR0WFoyXXgIBHtyr0gkMhW+FAfI9h4vpVOXpSrt5Hwc=;
 b=4GRoDjLLW/msxZOzm391BYYieUwRiebExYXHWYD0HWcOenc5FFPte7EYkhOdp1mGpkEWE2GeCzo2yVtJRLm6vzVY6/T8e58RbL8rO9pLHTgZHdQjP7+6zF75TEXCmN9dylFs5yKJiWu/TV4Djin/I9npLGQ3AepoW2rocC7y458=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA1PR12MB6091.namprd12.prod.outlook.com (2603:10b6:208:3ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.22; Mon, 3 Mar
 2025 11:42:34 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%6]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 11:42:34 +0000
Message-ID: <4a0e64e9-57c5-4f30-97bf-00c3eafe0b8f@amd.com>
Date: Mon, 3 Mar 2025 17:12:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
To: Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>,
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
 <942a1a66-5c18-43e2-886e-df38cb3e7258@intel.com>
 <54db17d7-b150-4579-a33d-f1b5cc8943bc@amd.com>
 <6eb0ec90-5859-4605-8a2e-657f6f711d61@intel.com>
 <825ddadd-6770-46b5-936e-f17988534984@amd.com>
 <13e1e1d8-5870-44ea-a800-e5b25bafd344@intel.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <13e1e1d8-5870-44ea-a800-e5b25bafd344@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGAP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::33)
 To DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA1PR12MB6091:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fcf19c8-30f2-4c89-8a1f-08dd5a487cfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlBIdGRMNjF4WWNid2tzZ0ZQNEdZNFd1VWZzcUNHMm9wVHVmUTRKV3pHVmlY?=
 =?utf-8?B?SlZ0K1BBaUU2UnpwZGZBdGRhTXhKYnRoQndDR2VSanM2ZFdKREtYMEszNFJq?=
 =?utf-8?B?ZDVYZEJFbC9KYnBSSjlGNERxalB3TEE5WmYyVE1tM0p0dUg2VFhLOUFVNzdm?=
 =?utf-8?B?amZsMlZBSzFzTldxL1phcmh6MFl0cmVUQms1djhta2lOWTdWTTNubHhCSXZp?=
 =?utf-8?B?enc5MUI1TXpabEpSSERvTE9QRW9MUXNqckJEd0JPYXlQRjJtMFRxTWpoR3V5?=
 =?utf-8?B?WGhPNk5yblJDYnJtWFZ2U1kyMkpjc2VxaDBSQlloVE02MzB2bFJHUTR1azl6?=
 =?utf-8?B?RHVxL2ZjRDB3NUxoOEZhS0ZhR1pJSGJlQXBIZUdyaEh1TVNxR1NwaGJYWGZX?=
 =?utf-8?B?RmZObVhCS0NtU3hRY3JiTDNRNTJiQkkxL29VUEIzUzQrb0p5eEtpbHdOeVpy?=
 =?utf-8?B?VlE5eHlYb2Fvb283K1dhbS9mSDQzZEs1UWh6M2YzOE1md2YrWW1Xc1oxZzZV?=
 =?utf-8?B?MCt3cGNEUTM1MDIycnZKNlMvTnZWcUdpdDIyZmdrOU5SeVJvaGd1Ri80M2x3?=
 =?utf-8?B?S2NSQmxTNHZxdGVDa0RoZE1EMkY0MklyVGV5Y0Y5WmZiTVkzRVhSalQva2pL?=
 =?utf-8?B?cFp1NUhla3JKeVl3MWNCN2hSUjJabWZFdnhSMytMcTAxTktRU0hRRnlOWUpn?=
 =?utf-8?B?aUJETUoxdXdEK2ZuRnhoblJiZ1E1clo3ZDg3K0FrbllkQWxpQkRwWTFUY0Q5?=
 =?utf-8?B?bUUxcy92dGoxWTdjZ2pXWEp6K2VBa3FFeFl5enEvZzYzUU12SWptc3RXc3B3?=
 =?utf-8?B?VlJhTlc1V0U4d1VOK0E1aEwyayswOVlLQ0F3UEpveHpUQWdVakw1S1RMYXhp?=
 =?utf-8?B?SitncHN6d00yS2ZMbzBvcHg1ejNsbUFxVXdpb3FCWHhGN043cXpCUmJRVWlZ?=
 =?utf-8?B?Y0lvY1JMNFp1dGlSdU85OFh5eEk5SWNJZnhBRTNOVlBkRWpMQlh0S3ZsNWRi?=
 =?utf-8?B?UVNQS3hDK1h4N2hBOFJHUDk4dXhLZExpMTBxaTRsSXBrekJ3bjNiMTErNndP?=
 =?utf-8?B?MXpzWDQ5a3JoZTdLeURFSXQ0Zis3SXFjN2NrV0VwbldoeFJRRUd2U2xQUGRy?=
 =?utf-8?B?N0RlMFNmMEdkNHVzL1VjYlkzWkxoc2lkNjBCUW9oWjJyOURVdzhkbEsrbU1m?=
 =?utf-8?B?dWhwSlB2RXBRbzVVM2ZqWElaN0R5akhSdytmYlh0aXl3M3ZVMUd0RXpRTjZ1?=
 =?utf-8?B?eE52Y2gwWFdsR0ZxdmVKZHlMS09qSC9CYmxEU21BQ3JWbmtId05qbkgxRnVr?=
 =?utf-8?B?QXVGRExZR3dNMFZCUEg0RXAzU21QdjBEMUl4WEJWT1BYZ2NkRzd6VkRvMS91?=
 =?utf-8?B?REkxc0R2YzBGQUhEeDVKR0JpSnY3aXA1Y3RtRmpCaGVkSDQzTXNqK3A2TDdL?=
 =?utf-8?B?L1FGYzUvSkJRZFg4UWgvcnZZWDRSeFVqTDFiNXBaRXFpUSt1SEgrQXZCdG9n?=
 =?utf-8?B?VVBTS0RZUVN1aTVpLzJ1VGlyNHByMktyUjFVKzZvN01lbklFWEhvV0VPMmhZ?=
 =?utf-8?B?TFJHSmZabzNmbC90OTBpVERKUUo4b3J3eEJ4UjFYSHl1VXVSblRDbWFIWFN3?=
 =?utf-8?B?MGwyWWJ1V0lIei9mRnc4LzY4VEZjRm1xb0ZGWXYwbmh0UUI0WlFQUWFyMEFj?=
 =?utf-8?B?QmhWZVp0ZTB4VFh5dlJWbjdud3Zwd2xJckIrVGErZjA0NFdDY3NiTzJETzBS?=
 =?utf-8?B?Zjh3UG5mZWxJb29tY2R0K3ZWL25SRVlIQzVLWmM5QzIzTHZmTUM4bEVxckE2?=
 =?utf-8?B?dTJiMmVzRzhkMzA0SUs5bHpJcTlMb2Z5UG13TmFodUdYc0kzTHNHZmRZa0E4?=
 =?utf-8?Q?3fDE2ozLbmFSO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SU9qSFFYYVBNYmJQY3d5bC9rMmJCSlU5d3ZYeTdGYWs1V3pnQ1VBWHNRNjIr?=
 =?utf-8?B?M2J0NnJHZmh1MFd5MXZUWHcyblRJcTZXRDVrS3JEdEhjdEEvOHFUVHprbVNZ?=
 =?utf-8?B?OHNQNmU0NzE5dG9GMnpUc0dZWUJrc2Q3M3drTXpTT1pMN1JuNEhKQ1ZBRExX?=
 =?utf-8?B?bGQ5ZFVUTXBHQUNKSEZxQ0JQZllRMThNNUVYejZpUzNPbUYxaGhEcWV4bFBu?=
 =?utf-8?B?dFBWTUNtV2JqRWttUXhTOGtsYW1FbEpJRkNHU3ZRRFlvcWhIVXU4em9FanFP?=
 =?utf-8?B?Y0RrNFhhN3NPbVIwRGtvUG04NnRJTlpjamIxTUhpZmJpNEVkem1qQys1ZlRV?=
 =?utf-8?B?Qi9HTDVwWmRaSnN1WFhVK09XdVdpZ1BmbnpPYSsrRWFsTU5kd091NFBTMktL?=
 =?utf-8?B?Vy9aNjlCZHB2cnJkcE5vMG8rOU05WVcxTHVqS293ZmRKdmFYNUNMdlRxY1FG?=
 =?utf-8?B?Q2ZzUXhBNVNEbUFCc2J5azJNdzhjR0NJSlRaZzM2RkhrZ1BheTVjMTZPaGVk?=
 =?utf-8?B?S21pckJ3VDZKS3FMYjdhRkNZQ2hiR1lldk1EL0doeEZ1bVpMNkVmbVZFb0dZ?=
 =?utf-8?B?cThZWDNscy9sZ2orVXlvcG1WbTBIc2RxTWJWRE5Tc3VNaHRrOXYvdGNHcUJN?=
 =?utf-8?B?ZTBaL3NTUnBhenVLN3VZN3lDUU8wNkdhaVRlcnhVdjQ5dFJnMDlKNVY0dkda?=
 =?utf-8?B?d0NkajlZaGo4bmZNMVJRU3B5citTenRxSEg1Nm11RitoUFRpQVJ2YnNPWm1l?=
 =?utf-8?B?R0ZXTmc3eFNmdzF6R1E5Mlc5SDg1VGtkeWZveVhDTVljRk9TVTR4TFlqR1RO?=
 =?utf-8?B?TFZqaXFSTWtvc0V6UWFtYjM2QzFwbEpzQ003VkJralVTS0lZMTArNDJSZ0l5?=
 =?utf-8?B?MGJMVU5QWTJaNVU4REI5WFFrK0M5MEdXY214WW8wS05RUDg1OGVNNUYrWTVh?=
 =?utf-8?B?YnU0OGFBeVhZcVBGbGNEdDB4clBpN3VVNGp1eGtYdXJ1dSszRlpVQnpVNU9Q?=
 =?utf-8?B?R1U5SUU5YmE4RHRtWmFyb1Nmem03SUowcFMvYkVJL0g5eEF0R2RFQnBCQWw2?=
 =?utf-8?B?NGNVQkd1VjB4TXVUVXQ0ajZVckFRV2hxLzd5UDFEOVpCV212T24wQ0ZuQ09Q?=
 =?utf-8?B?akNPenpUY1dSaFByejF6Z2V6YWZtbEd1SlBrbTBKK2k4Q2Y5dnh1K1d2b3Na?=
 =?utf-8?B?b202emFaejI2NFpLcm9JZ0VSQTNlUitndFE2ZW56Zmo0S2ZHQU82blgzRXRC?=
 =?utf-8?B?YVU3TSt4d3hvNU5teDRObDhGMFRmUHhYSFh6eHpLL3lmVVJldnpUNjh3cUEx?=
 =?utf-8?B?SEJkRDNRSUFMd0tJRnphTjlOR1VFdUJJL09tQmtFUWZXYUZTWG9uaGthb3pt?=
 =?utf-8?B?bkFRTnRrVVVDdkRZL2x2b0E5ak5oeGlVZ3QxdHhnRzVPaEI1UlgwUEVWOUxz?=
 =?utf-8?B?STZNSlliSG95UUJWS3czQWswek1IYWdibWJlbU1wRTRXODlvUVRKTDh3T1Vn?=
 =?utf-8?B?RjdmcXV4d29TUk03bktzZGxoaE9PeDk2V1dNOVdiTy9MS0U2SzBHNkdQTGRu?=
 =?utf-8?B?WjU5QSsvZWtXY1k3enVLUklUVmpGUGN5SWYxRDFXRWNDczVqdXY0TnVKK05Z?=
 =?utf-8?B?b0xvRDMwUDNBZVNxZ1BQMmxFMGduS2VPejlHRGFaRytxT2lTYVJob0ZrTTJr?=
 =?utf-8?B?OUN1NU4xbEgyTGFuMHBQeEJSWFRlOG5yQUtVM1pDdm1LTkFqQ3B3ZlFFTm4v?=
 =?utf-8?B?NlQwZ3VUSWZzNExqNVg4cE1PYnh0Y3ZYYVhzdFpOTE03NzJYLzlVZXR2TGlw?=
 =?utf-8?B?NFVyMTgrUGNLYlBldmdOSGpwSG1ncm44RGF0RTJ5WFdrT3JPRTB5ZWdKbGpv?=
 =?utf-8?B?dzdGcytWMGUvQll4NGxEZUVpbFdHY0M1WWlMNkZ5Y1AySmthRjFkOHVSblJ4?=
 =?utf-8?B?b1VCM3dUdDlYbWFMWmhmL2F0Y1pyV3M1eE4rRG5XbC95MDEyZEQ2WEphaWND?=
 =?utf-8?B?b2pCQ0N6NkRrZFZ5aXA2bVlhS0owc3YrUjVCVFl2Snl0VlhxSXNDRXd3R2l6?=
 =?utf-8?B?ekMxZW9jTUdROXhreHM0N3MxMVpDaWcrNzJSd0dKNnZDNzhZaE01OU9yL1Jl?=
 =?utf-8?Q?Q4IKlqeFCoCe4T15dFueyy5Ba?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fcf19c8-30f2-4c89-8a1f-08dd5a487cfd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 11:42:34.0984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eigJF9K3gavkSgGQl9IimZw1uE67kZFxd4HJSsPYuUMZXgJJbH9ryx5iLp6AVNPn2xSu75aAmhG48VDQngtv5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6091

Hi Yi, Kevin, Jason,


On 3/2/2025 1:40 PM, Yi Liu wrote:
> On 2025/2/28 16:47, Vasant Hegde wrote:
>> Hi Yi,
>>
>>
>> On 2/28/2025 2:17 PM, Yi Liu wrote:
>>> On 2025/2/28 16:30, Vasant Hegde wrote:
>>>> Hi Yi,
>>>>
>>>>
>>>> On 2/28/2025 1:13 PM, Yi Liu wrote:
>>>>> On 2025/2/28 14:32, Tian, Kevin wrote:
>>>>>>> From: Vasant Hegde <vasant.hegde@amd.com>
>>>>>>> Sent: Thursday, February 27, 2025 11:28 PM
>>>>>>>
>>>>>>> Hi Kevin,
>>>>>>>
>>>>>>>
>>>>>>> On 2/26/2025 12:35 PM, Tian, Kevin wrote:
>>>>>>>>> From: Tian, Kevin
>>>>>>>>> Sent: Wednesday, February 26, 2025 10:51 AM
>>>>>>>>>
>>>>>>>>>> From: Jason Gunthorpe <jgg@ziepe.ca>
>>>>>>>>>> Sent: Wednesday, February 26, 2025 9:18 AM
>>>>>>>>>>
>>>>>>>>>> On Wed, Feb 26, 2025 at 01:12:38AM +0000, Tian, Kevin wrote:
>>>>>>>>>>> If above understanding is true, my preference is to support a sats flag
>>>>>>>>>>> in domain alloc (nested_parent only and PCI/CXL.io only, as the start).
>>>>>>> For
>>>>>>>>>>> AMD it turns on the sats bit in the DTE. for Intel/ARM the permission
>>>>>>>>>>> structure is created and updated according to the map/unmap calls
>>>>>>>>>>> on the parent S2.
>>>>>>>>>>
>>>>>>>>>> They are functionally different things, and have different
>>>>>>>>>> requirements on the PCI topologies supported (eg CXL.cache vs no
>>>>>>>>>> CXL.cache)
>>>>>>>>>>
>>>>>>>>>> I think they need to be different flags
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Not exactly. They are functionally different but serving the same purpose
>>>>>>>>> to the user. From user p.o.v. it's sufficient to have a general flag for
>>>>>>>>> sats
>>>>>>>>> when allocating a domain. The underlying driver decides whether such
>>>>>>>>> flag is supported based on the domain type and the associated device,
>>>>>>>>> just like checks on other existing flags.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Chatted with Yi offline. Having untrusted user control a security
>>>>>>>> feature doesn't make much sense. Probably what we really require
>>>>>>>> is:
>>>>>>>>
>>>>>>>> - IOMMU core exposes a separate sats knob per probed device,
>>>>>>>>      allowing the administrator to manage the sats policy which could
>>>>>>>>      be no ats, unsecure ats and secure ats (might be further set per
>>>>>>>>      domain type in case the hw doesn't support sats for all types or
>>>>>>>>      the driver doesn't support all hw-supported types in one batch).
>>>>>>>
>>>>>>> When you say "sats knob", you mean sysfs interface?
>>>>>>
>>>>>> yes
>>>>>
>>>>> in case this is the direction. This might be a per iommu_group knob. do we
>>>>
>>>>
>>>>> want a default value per some info that can be probed by kernel?
>>>>
>>>> I prefer kernel probe/setting default values so that we can enforce HW
>>>> restrictions (like SNP, untrusted device etc) and then....
>>>
>>> I got untrusted device. How is SNP probed? Is there any bit for it?
>>
>> Yes. There is a IOMMU feature bit. see iommu_snp_enable().
> 
> sure.
> 
> I'm also thinking about the impact of such a knob. How should we define
> this knob. Should we allow it to disable/enable ATS? Especially in runtime.
> e.g. if the device is identified to be ATS untrusted by the admin, while> the
hw does not support SATS, it seems reasonable to disable ATS for
> such device. This might change the driver behavior on ATS enabling. Intel
> iommu driver enables ATS as long as it's available in the probe_device()
> op. What about AMD and ARM?

Currently AMD driver enables device ATS and configures IOMMU DTE (per device
setup) during attach_device() path. There was a discussion to move device ATS
enablement to probe() path. We will move it to probe() path soon.


> 
> On the other hand, we may just define the knob as sats required or not.
> This is just a knob to let kernel know if the iommu driver needs to enable
> sats or not. While leave the ATS enabling policy unchanged. This means
> we need to probe the sats capability of iommu hw before creating the knob
> in sysfs.

Right. Lets see if below flow covers all the requirement
  - Define new flags
    IOMMU_HWPT_FLAGS_SATS / IOMMU_HWPT_FLAGS_ATS

  - Enhance 'struct iommu_device' to include ATS flags (NO ATS, ATS, SECURE ATS)
    iommu_device->ats_flag

  - During probe() driver will update this field (similar to max_pasids)
    If (IOMMU needs Secure ATS always)
	iommu_device->ats_flag = IOMMU_HWPT_FLAGS_SATS
    else if (device supports ATS and IOMMU supports Secure ATS)
	iommu_device->ats_flag = IOMMU_HWPT_FLAGS_SATS | IOMMU_HWPT_FLAGS_ATS
    else if (device supports ATS and IOMMU supports ATS)
	iommu_device->ats_flag = IOMMU_HWPT_FLAGS_ATS
    else
	iommu_device->ats_flag = <NO FLAGS> (May be have one more flag
IOMMU_HWPT_FLAGS_NO_ATS) ?


  - Based on default setting, kernel command line option and probe() data, core
layer can adjust ATS capability. i. e.
     - If we have kernel command line (say iommu.ats=<x>), use that data for all
ATS capable device.
     - If not, apply default
      untrusted device -> force secure ATS or no ats
      If HW needs Secure ATS always , enable Secure ATS
      For all other cases use ATS

   - For domain_alloc_paging_flags(), send appropriate ATS flags

     Q : We need to find a way to send this info to identity domain?

   - sysfs knob : core layer knows supported ATS flags. We can expose them via
sysfs. Then as Kevin mentioned, we can make sure changes happens only when
device in unbind to domain.

Does this flow works fine?

-Vasant

