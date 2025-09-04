Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2074.outbound.protection.outlook.com [40.107.212.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570372505A5
	for <iommu@lists.linux.dev>; Thu,  4 Sep 2025 19:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757013559; cv=fail; b=aeFx4hut4NGTzOE8SScagCDL5cuBHLGAZSb1eYnIvWdUWMD3tf26X23joVqFAx3Je1ZQbqd5/I6N0/EroEp8PLhrTQWLIcOPOrjgwEgWolFRVWNUVQwOLuh2Mkq0E3xcJIAcSNHfz5nMvWRLWHZcmIu+ViRRxhWkRYrTrucnK+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757013559; c=relaxed/simple;
	bh=BkBZKZSCgdEEvnFILFi8k5QGEG8jI8EFlj5L/5lwSbc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pjx+Y2LHo0B0SGpOto+hTnUqbhEnjYSYzQfBIxpnhN0cYvlhX/nH/919ydtogA3V6hjKazTkpIdPIMRrPV2MMVbMbJKKwXDXrl1R1oVcK2/rPyklJyw7Q2LMqQfEvGOKuZWCc3LuWO6cIZv8agqCqw7CgDlyzQ/Rinf4H6GMTkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hsP8oFcv; arc=fail smtp.client-ip=40.107.212.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hsP8oFcv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=niWVHaGGAfWTLHgn+ee9ouQ/D+VAmyIDmAhjCasmeEUkwnQywuMlJSlKYvjLMfLPklVK5D9zDyRAHCSVMwywu0/O7lkt+mUvm5lcPzcceNaCTowNVdjZWiG5WzFav3lpqzL5t3pG8FNGTlaznUn34jk90FoLIZGO0bHWklkD74+hq8l3NVd7GEhQXCBtNPsxg9AcvFfBSNqDk8pEIGboyslagUF5TOe83nAV/seKuw9HPMLZF5biAWLC2VQvNml944/eHOj6Z5hKeKmhI6kL+Yfjw89c3PdAnh8Lt/Q665iDscZy0vsAT5AdpWU4GhnaphKJzh2zSIvr74Z5IGBltQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhMHq+3qafDJ7jKg5VVtA+vNqbIPdcVp9MTjcWHS8eg=;
 b=gHL0zt3zg9r9CcqPiIzrQ9toC3kaJRv2Nu9t5JoMSKvjH+SYxONJDB9pWx6bcDjI28RLTAqVgbAbhkzLiiM3TORTAA+M9SjGxall2DT89zodxf+VvS+Gmp3Fq9eqDb2hhQQIZl+sdB4kAcU+kGUqzVtkvt6qVOMsn69Hh/faEqfdsbMf9q0EQ58QboRwsP0hh3CRsqIYB+nF480bgNyqJWutc2wVou+9E33SwVEaw14q2vDmdP7fCnsWatB6YKOe8JTvdZoUZZMpZywWMw0Lrjno6nltpOzs+GR9iV0cuPfDmRuODG7xssaPST/c7IpMHibtfakEiQNWFUJtIznCkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhMHq+3qafDJ7jKg5VVtA+vNqbIPdcVp9MTjcWHS8eg=;
 b=hsP8oFcvoHehUI9WYsERcMfSDPkwt7RI4FFGcXYxjWIcCatQv+drqJHbU2zzScpmn49jo+nv0o6woGmTWBneNcmXoco1c3ftiR9e1FJr0oDOf5ejLQjUxLw+Qt30jTUS+B17jKmm0xs5I95CQ6udZnwg6NP7nLW/3sCtonyo/jk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB5452.namprd12.prod.outlook.com (2603:10b6:510:d7::16)
 by DM6PR12MB4058.namprd12.prod.outlook.com (2603:10b6:5:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Thu, 4 Sep
 2025 19:19:13 +0000
Received: from PH0PR12MB5452.namprd12.prod.outlook.com
 ([fe80::ca09:7460:4218:df8d]) by PH0PR12MB5452.namprd12.prod.outlook.com
 ([fe80::ca09:7460:4218:df8d%7]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 19:19:12 +0000
Message-ID: <cb5c0ec0-4255-4345-af1d-3356479c9ae1@amd.com>
Date: Thu, 4 Sep 2025 14:19:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iommu/amd: Add support for hw_info for iommu
 capability query
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: nicolinc@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
 will@kernel.org, joro@8bytes.org, kevin.tian@intel.com, jsnitsel@redhat.com,
 vasant.hegde@amd.com, iommu@lists.linux.dev, santosh.shukla@amd.com,
 sairaj.arunkodilkar@amd.com, jon.grimm@amd.com, prashanthpra@google.com,
 wvw@google.com, wnliu@google.com, gptran@google.com, kpsingh@google.com
References: <20250827162309.50401-1-suravee.suthikulpanit@amd.com>
 <20250902115722.GD186519@nvidia.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20250902115722.GD186519@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::25) To PH0PR12MB5452.namprd12.prod.outlook.com
 (2603:10b6:510:d7::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5452:EE_|DM6PR12MB4058:EE_
X-MS-Office365-Filtering-Correlation-Id: 63f432fe-f759-45f0-19f3-08ddebe7ee29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Si9VQ21tZGpvdHZhaFlodE1DZC9QdktYYVZWc2NnR1p0VmxtdkIxMVNlRjh3?=
 =?utf-8?B?cktTeUNnT0JnekhwV25mZW9tcm0xaisyb25kZCtlTHRXQWRURmNrUDZiaDF6?=
 =?utf-8?B?dTh0MlVDUkFzclpKOUxNOGlRQ0d6MWhIZW1jMHdqeldQRkFEMWJDN05YWXpH?=
 =?utf-8?B?TU1HZWtpU1I0eHUzNWV2UjAxWlVUQzUrMWFqb2h6K1lxT0FVcVhiSmlRNzdZ?=
 =?utf-8?B?azhHd3RNbi9QUE9udkR6ZFV3ekZJRWtXVEIxSkgyS2hhUGNEU1JuMW94OGVp?=
 =?utf-8?B?bGlxRS9rZE94VStCTWg2TWxjRklTc0ExeVZpVDFxT3VBbHdsTDJweGg4dkRD?=
 =?utf-8?B?OGh3UXZWdTc4RHNGR3NoL0p2RVpQN1RHL1krRDFpZnVkUzdKclRhQzlIUmpn?=
 =?utf-8?B?S3IxV3lEQXIrTzNXdXRrL0lRNExBT2dJaEhrVE96b0xleUZrczJlWmYrZnpt?=
 =?utf-8?B?bDdXb2FkK0NDcW9pT1NuZlp3a3NBTTVnZDg2Y0pKbkZYSk51ajBhd1RDM294?=
 =?utf-8?B?aC83RFRJckRWbWZqSzhPQVdLbWdzc04zeEJuai9LSlYvVklEdzlPMVJlUFds?=
 =?utf-8?B?dFVMQ0VTblk0bU82RzFXM0VSZDFhZTlrV3ArbXEzbnNXRE9hZExqS3pIdjVR?=
 =?utf-8?B?U0hRd000UXVHQU5jM0FuV1hvRUZiYThDOXBWNVZ5UkxGSGNvVjY1bm9WWEYw?=
 =?utf-8?B?TE5EQml4TnkwK0RVUFZSa0hXQnowY3phN1FHS2xuMDhLMEtNZVVUQm1mSFlD?=
 =?utf-8?B?QnJSRktXNmZoNnAxTVVzc01tOGR0S0xxaXNJMnUzZ2YyOVF6NnR1MFczV2xZ?=
 =?utf-8?B?MkRiNHNUdkl3N09waTMvdjErRmR3MVlDODEzelR1ZXBEWEJWZ2hsVG4zblNk?=
 =?utf-8?B?Mk5HSC9ycTRhMHdBRTZJVlNQREQzK0RjekFVb01PV1hNOWhhT2taVVFXQjcx?=
 =?utf-8?B?QVB2eVNuYnJ6ZlFoakRMYjhsYnpEUy9SVCt4WTAxN0FuSXpCY3Q4UDFOT1hm?=
 =?utf-8?B?ZExNWDd1cm1pWlpwZEI3dmJpYVcwbW1VOWdZbk1zazZKeGJxVmlBUDVaK3R5?=
 =?utf-8?B?eURtMGJzbWdkbnVuWmxNdk0zTEl0QzJIUTJuTXMzQUV1ZkNYVUNReSt1UUl4?=
 =?utf-8?B?SkJtV0hBOUZkc3RkaDFPVDBjdGhIQ1cyenZGU1JNNk9ncDNxSEFuK1RLL3dV?=
 =?utf-8?B?dUdCS1JvckYwM29MZjlGd1FpNlRnVWJZa0VFa09xNHZ1a0VRQVpQT0pNN3Zs?=
 =?utf-8?B?SWJ3SXpYdEVMYS9uZzkwQlJ0U1lZTGdHQUdFWVNLSUI4NXdyTEF0TWthT2xY?=
 =?utf-8?B?ZXJjSjRxUjZoaWRMMW54T25tR3J6VFZvd2tNRWo2TjZrbUFzSTBxYXgzWEVw?=
 =?utf-8?B?UjU0ajYzTDdVaHBncEpGa2NQdTdwWm5IUzVPcmNUcHJ6SHhuMHlYY3hmMVQz?=
 =?utf-8?B?MjRpMXU1bU5lYjYyWi9LTXNNS1JJMElXU2FrMDlHNGtzTnFmNUNKTjdBSDVs?=
 =?utf-8?B?am5QMmM1N2t2QzU4M3RPaitkN1lJTExTdTNua2FUL0o2bWxDU1FkTmdKa1pS?=
 =?utf-8?B?TGZSRVAzRFJyOXVUM3BLOGZsdTYrWkpvK2xNNDNJckdaNUtuRy96d3Nqb1Jo?=
 =?utf-8?B?NE5JU1dnVkh6M0lZS0FzY3VDVDJSS0NENC93WjV2dGhwOVZab2hHcUdPRDl4?=
 =?utf-8?B?K1JQMkNMZW15UFpEWGJYQk96YjdoaWg3dlNabnlMdzdnM2R3RlU3bHN1d1dK?=
 =?utf-8?B?RkFHVDN0R2hiMEJsR1JxWk1NV3l1RVluL1pBN09CVnl3K0xIVmNudnZxazlG?=
 =?utf-8?Q?iGjCkN9WjFvHdA88zargTtWCxmizfCErJ0Tok=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5452.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEgvbGVocGdldm9pVGRIc2hJVnhNUUJWVGRwb1JNRkJpdDBMWUxXTWF1MGJ5?=
 =?utf-8?B?Yzc5c2ZGckdPd21OVEh6VU1IY0VCQVFJdnBOTG5tS2tWQ0gvTFB3eFc2OW1U?=
 =?utf-8?B?Y0FkSTRCa1FNa0hNdkovMXlYK3diNVZqZUNMeThONmQxTm10NEViUHBuUHI2?=
 =?utf-8?B?emJyQ0ZzQlZHN2FkcHZxaUgzZlpkOUZrOHZZY09LQUJDK0o1dCtMc25aVE5P?=
 =?utf-8?B?Q3dmNUIzb3lqVlpESEk5K2VpY2tBN3NjN3NWV0JDb0ZNWnY1MXdhamNza2hv?=
 =?utf-8?B?Y3o2NnlsaUJEQkhMUEJYZ05yY0hLR2J1OWFjYk1GR0hwbVFndFJ5VXp3Z2Y2?=
 =?utf-8?B?Y2RWTWl2Uy9zV2F2RFN2cUoxSEFING4vVjlOWGpnY3ZsVkRRRGJtZVBmZ1Ri?=
 =?utf-8?B?UTMxUnYzbE9NTk95Yjh1MWlHVzUyUWFrRTFnUFZMb1Z2eW9TSzRaTzRNc3pR?=
 =?utf-8?B?SVlnVEFWV2R2R21xOUNnU3dOWWxtUzRYTWtYUnN6Qk84ZGN5ODBicVgzM1ZB?=
 =?utf-8?B?RHFyM1hjTURrWEttRXJLbU5tRmRiL2dhcGhXQUc2L0t3QytpVWdXM2E0enNH?=
 =?utf-8?B?UEJhL0szMWtJN29QY01FenozSi84N0dGbElMYlpPTzNvOTRWbjFrZERIWGpL?=
 =?utf-8?B?SEt6cTRKTmpMWXVCYTdFeU9JQjE0VW5PYUNhNlEvb3hseVJLUFBBclAvTDVP?=
 =?utf-8?B?a3BLV1VUaTdvbkE3OE5DNzhpc1EyTkV2MTRzMllUQlc3cXFzQktQNlRKSTY0?=
 =?utf-8?B?N0o2eG9oejAvMElVdnBQR2xFdzdzUG1LOTJ2SGRjNDcyTHl1MmMxbU0zdmZ6?=
 =?utf-8?B?NlVUSDJORFl1aGJnWTNPcmU3a2FVckRhbllYNU1RUXlVcGNNLzZhckJNL2VJ?=
 =?utf-8?B?Wi9XbndKWDVXaU4vRVV2cHhkSnpiSXV3Z0YwaVI3UHlYcFE3cHJKZVJWZ3ZS?=
 =?utf-8?B?RDFOYWtmaGZpVUNVb0VJUkV5c1BMOGthMXdtb3dqZWkzbGNJUWRsL1BOTU5v?=
 =?utf-8?B?SzIxbkVTTnd5QVBWY0pHYnQ2SzZkbjRUTjFUemlpL2xPMTdhYWlGY2YrU0Vu?=
 =?utf-8?B?c2VvTTA4V2ZaWkFTN04vNVkrTWxmdENheDFBa21NbVRrS0llVmsrc2ZCT3lC?=
 =?utf-8?B?VXlBOCt3MlV0eWljdmxQWm13Z1R4UUdlRXpGZnlqa2VnNHRZOWcxM1R3YlNE?=
 =?utf-8?B?WFFUdXRUZEt2TTJ2SlRhTnBvdWpybmk3T1l6eXNIYnpyU0pDY0xJUU5FY1hP?=
 =?utf-8?B?c3hpSW5KYkh4bENDMHBWZTBBUGcreUZ5cnJad2V4Smg1bUpxY1BIR04rV2Vk?=
 =?utf-8?B?Ym9IbFM1aXM3MnNsMVQ5SkZUL1E2Z3krc0pRVDNOR3B2Qy8wemw4amFtbm00?=
 =?utf-8?B?Z3RadUczT2lWVHNjMmpHbUpKMnFEc09OVy9udHRrdWtqWEdRc0J1NXVzTUN3?=
 =?utf-8?B?MXYwb2lWTTdLbDUyL2cwNTBjOGVkYVJBeFhSWUlpMGZ0UDdPZDV2MmIvb00x?=
 =?utf-8?B?Q2w1QXdMekl1ckljZTloVmdKY2hQdURja05hU0xGandmYnh5TzdCeDdSeHph?=
 =?utf-8?B?c2hNOFpZQVlRdDN3ZjlQUUgvRDZNYXJvV2Q1WlVhZnhveVgzcmRMaDB4NWdM?=
 =?utf-8?B?YVFmUm9Za1B2WFFvOVQ2Q1RGd0dkRlk1T0lrUVBaV0RXK3k2bHJHTDQrZTN4?=
 =?utf-8?B?TDU1dGlVVWhMSlBNSWgxM2luRjE3YklWZ25WWjdhT2hwRzllOGhFZDhiYVZj?=
 =?utf-8?B?L0RiM0lZT1hOMnk0eThxUjJHNmhVblRLY0pHbThkQXhFQXJDWGZvWGVxbTdM?=
 =?utf-8?B?VUJqRHg1UitJUGlzSVB4ckhEOE5vTm9xY3lZZWpxTmU3MnpTRjRPS1FlZjIz?=
 =?utf-8?B?blpsZVR6U3gzUmVQQUF5Z0VqaGNhSTJDNUI0bDVySnVBZE1RWDBPSWtBM3Zl?=
 =?utf-8?B?WUtsL2RKcGExcFNkc1lMZmo5b21zM3oremoyaWxkSlEzK3RuTjFVYTA1R0Rz?=
 =?utf-8?B?RWxJYTZZcTFmUEQ1c2thSldVdCtxNjVOQTZzQ2RGaFZUWHRkaUFGUkZ3OWd1?=
 =?utf-8?B?VjdmVkliQkJlRmxKK2tmM2RjNGZDZlJhVjd4N213RFRNZkd5cFRZTzJlcVFJ?=
 =?utf-8?Q?p2K7xmyfC64bAXbAHpATyoGQs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f432fe-f759-45f0-19f3-08ddebe7ee29
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5452.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 19:19:12.4750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oCoibbsyfHcUs9aEuHccLwUXyY+uH0tIea1rvA7v9gYtTqyn1I5kp39fyzJa9KiutdTBS/kjz+HFz/65xxXOPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4058



On 9/2/2025 6:57 AM, Jason Gunthorpe wrote:
> On Wed, Aug 27, 2025 at 04:23:09PM +0000, Suravee Suthikulpanit wrote:
>> AMD IOMMU Extended Feature (EFR) and Extended Feature 2 (EFR2) registers
>> specify features supported by each IOMMU hardware instance.
>> The IOMMU driver checks each feature-specific bits before enabling
>> each feature at run time.
>>
>> For IOMMUFD, the hypervisor passes the raw value of amd_iommu_efr and
>> amd_iommu_efr2 to VMM via iommufd IOMMU_DEVICE_GET_HW_INFO ioctl.
>>
>> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> Was there a reason this is not part of the other series?

Since this can be a standalone patch, I think it might be best to just 
focus on this in a separate submission.
> 
>> +obj-y += iommu.o init.o quirks.o io_pgtable.o io_pgtable_v2.o ppr.o pasid.o iommufd.o
> 
> Part of the point of another file is to not compile it when !CONFIG_IOMMUFD
> 
> So you should change the makefile and add some header magic:
> 
> #if IS_ENABLED(CONFIG_IOMMUFD)
> void *amd_iommufd_hw_info(struct device *dev, u32 *length, u32 *type);
> #else
> #define amd_iommufd_hw_info NULL
> #endif

Ok. Good point.

>> +/**
>> + * struct iommu_hw_info_amd - AMD IOMMU device info
>> + *
>> + * @efr : Value of AMD IOMMU Extended Feature Register (EFR) reported by hardware
>> + * @efr2: Value of AMD IOMMU Extended Feature 2 Register (EFR2) reported by hardware
>> + *
>> + * Please See description of these registers in the following sections of
>> + * the AMD I/O Virtualization Technology (IOMMU) Specification.
>> + * (https://docs.amd.com/v/u/en-US/48882_3.10_PUB)
>> + *
>> + * - MMIO Offset 0030h IOMMU Extended Feature Register
>> + * - MMIO Offset 01A0h IOMMU Extended Feature 2 Register
>> + */
> 
> It would be good to elaborate on the bits like ARM does for
> iommu_hw_info_arm_smmuv3 and where some of the bits should come from
> in other places in the API.
> 
> Jason

Got it.

I am sending out v4.

Thanks,
Suravee
