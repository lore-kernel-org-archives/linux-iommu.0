Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA526F305
	for <iommu@lists.linux.dev>; Fri, 28 Jun 2024 06:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719557039; cv=fail; b=jNdl/YXFyZtX5hQeIuimNyfj902G9miATf09X8+akfiqfMrqtNbOrdosJzqDWGdgIt5JlmiHxfUyvd4qDceLlcFZ0Z8GpWTIdzAXolM2/WzbGeF8sFtks+cquYX2FYJSWSwZ9luF9MaAaz27V8WxLcUCTCmu0BwQ6fo+KM9Kuws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719557039; c=relaxed/simple;
	bh=h4Sx8y8Krx5m49swtwyq9Pt6m5DJnUwExeLOKS/Y8Tk=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=PaohQe27A8DisNZzYXN9O7hqbpzZjMDpCrJkRVdYyD3QpDNPydJLurqZnQfzXI7aIxFtugaLua9n39gjoN1X8s12BoIanjRIJ1YQAFonXighDfUDPPfh9MTr9fnuqzQlrTcsECEP6vKDsLIXi06UMJNl/J+JRt/9eG/L7RONrbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f+Pr9I4E; arc=fail smtp.client-ip=40.107.244.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f+Pr9I4E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdQL9nRb4jp5LwmLx0hH+BebCMl9PbsPqGlb7xBHmUO3u6fngvkfN/oXAKYSSGlX5h5JQtS+Xn1urKy/mj5UfV1kbqVM8Qi+1qMjd1IH+ybQ3M9/I2oPZRVVjCH75MhiT1/+CxQwkyNSePbgLoQ/Lx/u8c3UowaBWeBlzTlL8mCxSQp4wTV2FICTUvN2XfzLAughMR4L2eSWs4T6X5b2WNQzqM3O3vDZc6mX6E8pCY6cRermRhpqXgW5xqKwxl02bBkT/fGSQtuMZTYO0ipBuqkv1M9Vv/IsZA+TqZWprScc036aNmuADTttvI7JXz4bB0KDiv2hnmRMotFz3P5/7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aK7DJvr1K5Om2b71Jd7BNu9qBwKdl2zemHKHCSZPmh4=;
 b=NaDf1dmKWt6mY3StpEauJSLADBE05JHXqppVg5kerWl2FRZqpt/4bE743dItMeM2GE93jzLrl+zeL5050UooNFjHXIRXCZPELL+yAMRNfWM8MpzVXuIm8GxGEEVxuqOPqUeRd2qjS5RU81t7WT4uOlNzTHiSbGFC+VCbWhjgaonRxQaqW7f9in1Wuzt/K8KDS0I11kq/A8j4kRvB6DXU23vYv7L6iJLZZG2nTV+4Q080smldBPK/SftAl41ZmYUjAEvQbVN7N084YYtFMbPXp06oRwWc7oUWda1uvU5Fgn0UCjt5vIe8oSuDwyg3ONyfWkE0q3zaC70902CdG566lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aK7DJvr1K5Om2b71Jd7BNu9qBwKdl2zemHKHCSZPmh4=;
 b=f+Pr9I4EZVgkdU+zwOTqUUxDJbnvKGHo2YRyPF00XCceBMQAv+CMP6RUUcPU9LRXot4lXo9aibmPUA9muRBI1eNdiOy7caoGvQWLySULk3lHBCdKPg6LJeYaPJ4hiEHJlJS84UavAejjBf8olQIQdgojQMzUBAgafeps3L8VEDA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH7PR12MB7116.namprd12.prod.outlook.com (2603:10b6:510:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.34; Fri, 28 Jun
 2024 06:43:52 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 06:43:52 +0000
Message-ID: <7e249bc6-c578-40f0-aca7-835149a0ad39@amd.com>
Date: Fri, 28 Jun 2024 12:13:43 +0530
User-Agent: Mozilla Thunderbird
From: Vasant Hegde <vasant.hegde@amd.com>
Subject: [RFC] iommu_ops->domain_alloc_paging() enhancement to support AMD
 IOMMU driver
X-Mozilla-News-Host: news://news://news://54.189.247.149:119
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Baolu Lu <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF00000184.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::4a) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH7PR12MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: ffcc11ac-6452-4781-8850-08dc973dac77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RStBZ3A1cWNUeEovSUYwZitoVHNrSS9VTStQUXZ3RTQyOTkxdDd6aUthMmdY?=
 =?utf-8?B?Q1RVUXRFU1pMUU1rNG9URnRuWHhVdjNybTk5YmhqaEFMdlIrc0JsVjl2RXZj?=
 =?utf-8?B?Vncxa0ZFRzRqWTRtRmZoa1BJMlNRUEQ4eHg5cDFkSzZ1Y2dFc1FjVGI5WUpU?=
 =?utf-8?B?MzlSMkJoK1JNdWtCWXVOUlBSeDVBZ2lURzlKS2R2UEs1T0lYQ3VHNmR0eHk5?=
 =?utf-8?B?eW5xOHJJeTc1eDVLZDJSd2tHOHByNmgwRWkyelVQVUluQzhnM3MzVjZ6amdT?=
 =?utf-8?B?NmRvbWpLUGtRK05rMHA2SUdiemtyYWU5bTlaZkJDcTgwYWlBamJYSGhBamxz?=
 =?utf-8?B?N0haWk1xNjVNRUJKdjZUa2ROelRrYStJSGVVUngvUy95Z2NqbGxBRkIrK0Vu?=
 =?utf-8?B?Tm9DZUNxVkdKc3U4RGs3c1dhUFh4UUU5SUp4MllxWnhvTWhUcWJlaE9oNVE4?=
 =?utf-8?B?d0crTjgvTU12VmlXd1FZMmk5RERNWi9RUElFZlJnSFNlUUpZZktYdHJKMFNJ?=
 =?utf-8?B?SnYzNE5CSWZ2UjBoNEFONldhanY1UDdCc05Ga0lHNzgyVENOZjBEdW9FaWNE?=
 =?utf-8?B?VWJuMWdDak8vc0JuN2pzL0NyTUlOMVJKaUhqdFpnQkZLQ3VXL05NUlpyZkwv?=
 =?utf-8?B?azRWWUpkSm1xY09vVUZ2cXFUVk1ZSzJadytWSWwxNjc2cGZ6Z3c2a0xrVWh3?=
 =?utf-8?B?NEpOVDlEUmtyemQwSzR3MTJ0ODQvS0RuR3dyTkZLSkRLcm91NHdlcDI5eEdC?=
 =?utf-8?B?TjFuSW9PTzNYVjdXZGdJVWVVTms5Z1puQXZQT1g3QjZKMmJhUlFMaWFIRnda?=
 =?utf-8?B?RGRwMmJqNm1KU1BxWXVUSy9uODEwY2EvbEpLSkVRZVVneE1zZ0Iva2IyQnND?=
 =?utf-8?B?VVVoTDBYNU91czlQRW4zWDNBSkNxMDVpcU5uUUhRai9vVWUxbVFiNitSK2xl?=
 =?utf-8?B?QTRabGZkQ25hbG1JaEMxbmd1TmVoYnBGbllhVktBT014ckg3bTJiQ0RLNXlF?=
 =?utf-8?B?a1U5SHlZd0V6RmRISzlsM3NEVVBWSy9tR05kRFpOMVhOZ0MwOW8zRWNMWG5u?=
 =?utf-8?B?bGJFTzNoeDhjeWRNN252ZWkxeXFpSllndStFbjR5YzV2WWxFMk5XeUM2M1lv?=
 =?utf-8?B?bWpJSjN3S2V0ekZMMlZHTFNkanhCazlac0VsSytsT3NTN2VMaXNpem5Mclhk?=
 =?utf-8?B?K0lEcFRDVlJ1Y3VWc2kwcTFVd0U3YjlvdWNwVVluT3Jpbkdldkh6bFNFMXNH?=
 =?utf-8?B?aks3QWwwcytEMklpdE5wTVdCNHNnZFRtSXNCTVA0MVE4ZXlQVG53TXZ0bFdU?=
 =?utf-8?B?UWdsSC9iM2hGWTlNUi90a2RKNkdqa0dwOGZub0NjYmsxcXYrVjhnYkU5UWJ6?=
 =?utf-8?B?T3pKaFBkemdtRmV5ZmJROFpjSWlDbDdvRGtaaGVQbHV3SXZob0J1THZqYjJh?=
 =?utf-8?B?eXd2ZUtyQXVMRnJvdlA0TGJlSDBDbHQ0WHBvYTFFMUdoRFQ5ZFlQQ0wwTWRS?=
 =?utf-8?B?clU2V2ZITVZ5QjdLcnhFSG0vZzhsVjNXc3o2MWV3cGIyTDgycnozZ1VZcWIv?=
 =?utf-8?B?WTErUHQwYUVEM1E5VnhFNlRiN1hwS2RPdVVGZk10QjQvZUIreG0rTk5yb2FU?=
 =?utf-8?B?bFNNL0ZkUXVCTDdvSldkcHpUTzlPVFV3Q2lXNWlsRFVXMHgvMkJLTUZRODFt?=
 =?utf-8?B?ZUcvTHhmaTI2bXgxMmpjbW96WG5RMldFckVwTG1Eai9EQmZVOTlSc2RwU2M4?=
 =?utf-8?B?M2hhTmJ6WkxlZ0ZwZjJtUEsrN1R6NVRaWmVIbTVyVXpCQ1A0VkRTSURnSkJq?=
 =?utf-8?B?WS96cWd1a1pyd3JnZmtsUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDNobS9hdGExVmNSTmQ0NTE3bDZaem8wUjFuTXcrNU1FZmpSYVpZYnVaZmts?=
 =?utf-8?B?N0w5d3laSjJXeHgwZWhBYm5rT2VmSlZqWENaOWpleURhcFAyNEJzbDM0WGs2?=
 =?utf-8?B?RU9iZ0ZuY0dpeDVhOFdkRStlQWpaVnRiK0lueEd3UXlrcW8vUTE5QlRkbzRC?=
 =?utf-8?B?YnFxdHVrc1BlN1EzNGZ3dUhoMlFCQkp1cVE2Z0ZocmdWOTkrRkpsTXg4MWVV?=
 =?utf-8?B?Ty91cE9vNnVEVmtZTUVEaktyVjRvQ2ltTDFaOTFsQjdwMDdmTUZCeW9jcmx1?=
 =?utf-8?B?MWZoNHc5bXJ4Q1g0WVhFWEEvOFZ0ZlBhUUtIWGR2VzVMdStNMjR5dkFPS3M3?=
 =?utf-8?B?SXNnMFB1MVdCNnB4UW5ITXZ6NmF4S0VKWlp1T1pNdnluNTR5dVBycGNUcWR6?=
 =?utf-8?B?Z3JlUDNNSGMxNkZnQ1hZc0RseDZSb3R1SDVubHhuT0N6VmZLTERIQWo3d2VM?=
 =?utf-8?B?RnhEcGNESjVPSEQwSHcvaXlET0M5YVNxQ3E4am9CWHVEbFRuWnhVdUpNUllS?=
 =?utf-8?B?NnhHRWN4RlJic1p1RlpncExyUUZRUnpMR0psSWM2emoxZk5NQjN0Z0liSWRq?=
 =?utf-8?B?WkhObjNSOGoyK3A4bHlZaUJNTHFNSmdJRDBmWE91MGtDcUo4aTNsMlRlYnUv?=
 =?utf-8?B?eVU4MlpGZGdkR0dQYTNXZitQRVFIVGx4TlR6ZjhLdis5Qk85bGdrR2ZvVE5F?=
 =?utf-8?B?YWtDZ05DcGRvSzY1ZE9Cc1dDYmk0ZzZ3V1BqNzFWUlR3RHFjN0FOZ0RCdVZR?=
 =?utf-8?B?M2xvVWMwaE5QRWwxeEhBZXU5cEMxaGdkOStyWFVTdFdSN3FGRnhWTmdPditu?=
 =?utf-8?B?VHRVRmY1d3U2bERsVUdYN1Q3M3FnRmcyMUE3VjVsbGM1cEU0d2dGblBoUHY2?=
 =?utf-8?B?WFRTL1Vvb1UxSU11TU9KRSttbmVFVXF5MHB3R1NTRGVFcmxvTjN6Y2JmYzZB?=
 =?utf-8?B?dWRHUG5saC94QkJTQTBRYmNsNjVIUnBjcHlCYUphcWt4ekVjSkVmaXQ1NVYr?=
 =?utf-8?B?Z1lxTVcrbUEyamRHN250RFRrbVE2elBMZVhaWWtLSHNQS3o0SEFVZGRaMk5R?=
 =?utf-8?B?TW82UmJQZ0FXZ1ZUWlUwL2gySUVwVlpkbDJkSDBpVWQ0cVEwOE5Wei81TjdV?=
 =?utf-8?B?ZEE4UHpzMjUvMWFsVmplSm1WK1RKTWpkd3JsOUxad3E5ZjJHaENBcFRmbUVQ?=
 =?utf-8?B?MDhESDdzbjFQR0tCYmZXenFsQ3ArTFdJRWUzV3VyRko0bUZBTGVRRTRrc1E1?=
 =?utf-8?B?VzI3cHJpdWQrVmdoNVZZUnVTb3J1TFpXVG1sV2g5ZXlnRGZFSElzS2lLWHF2?=
 =?utf-8?B?eGZERmxFMW0vMmJYWllyeG1KQXJZV1grZFlhd3BKQWpHeG92eU5yRFZrZDk2?=
 =?utf-8?B?MjFaK2NmL0FOZWdCWmd6WHZMZ3ZFekhwNEhQdFcxWDFCK3J0dXQ1T281NGZL?=
 =?utf-8?B?eHVvYnlLbnNaRGczeHlmMjhIaDRtV2RyeldyZktZbzhqQ28rYk11TDBmc0dz?=
 =?utf-8?B?VmI2cmZISkowOU5KL242cTVtV2VZSHJuemR3UHVrcFlDOFdtb3c2RktKSHRp?=
 =?utf-8?B?ODlYbUlBM0Z2SEl2bld3ODBUTmFUQUNtYjE1cThHL3FHaDdCeUNMYUlGK2hD?=
 =?utf-8?B?VTlGRm1OK1ZwUG9LUjBPMTM5ajhQeXAvMEpIRHFSY2tOcngvUnBxUWZOMC8w?=
 =?utf-8?B?dEpTUUIyaGhtY2FRTHBZdG5ZeXRLVU8zVVhOdXB5cTk4TDZubS9qbmZhZGV1?=
 =?utf-8?B?dWpGQnY3c0hJNTUxWXF5S0RzZU0wWnBwSmtIWTNFNm9EVVRFV1ZnS0NXQ0Zu?=
 =?utf-8?B?NXZ4OFBadU1IVmZDaU4vRllIZTF6dmtEeUExb1pIVmtiSmZid0R3clUyb1U2?=
 =?utf-8?B?elR2RGgvZzZ5UHNRYllXVmVCMDdKMjBXTU9hcWpRaW1nekt6Z2dlazZ2d0px?=
 =?utf-8?B?NHo0ZWl5NGE2VEpTcFMwQm9sS3ZmTkpVUnRLQU8rVzhxU2JsRGg3bDVSRkpk?=
 =?utf-8?B?aW9wSTRaajJyQnhwSjZEUi9GUGRsN2pYRjEyc2JKMEp6Rm9KUmExYU5Fc2M5?=
 =?utf-8?B?UVRoSTVmMW9NMUNoOFVaRkVPVVVTb3dxREZ0cmJ4Mmo5SDJ5VFo0UDcyWGNn?=
 =?utf-8?Q?nzuWAfSFL8HjzRJHG0AvCIDB9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffcc11ac-6452-4781-8850-08dc973dac77
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 06:43:52.5477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/KoOnM6ql11gHJWi8ya4zByhGgYjMfxaoS96FuIsiYkTanFTatNsPsB/cLI9MJ/NhOKDAuOTRA9RHRtYaaP0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7116

Hi All,

We are working on adding domain_alloc_paging() support in AMD driver and came
across below issue.

BACKGROUND:
============
- AMD IOMMU HW has two different page tables : V1 (host page table) and V2
(guest page table). Only V2 page table supports PASID and PRI features.

- With V2 page table we have an aliasing issue. Hence we added
per-device-domain-id when domain is configured with v2 page table. See upstream
commit 87a6f1f22c97 ("iommu/amd: Introduce per-device domain ID to fix potential
TLB aliasing issue")



PROBLEM :
=========
With iommu_ops->domain_alloc_paging(dev) API AMD driver will chose best page
table based on device capabilities (V2 for PASID capable device and V1 page
table for rest of the devices).

But we would like to continue enforcing V1 page table for UNMANAGED domain. As
in terms of IOMMU caching, it performs better than V2 page table.

Also while adding SVA in AMD driver Jason mentioned that we should support PASID
with UNMANAGED domain. As I understand currently we don't have this feature in
upstream but we would like to support it in future. Keeping this use case also
in mind, we came up with below two options :

  1 - Pass domain type : domain_alloc_paging(dev, type)
   When we add PASID with UNMANAGED domain we need a way to differentiate the
domain 'type' (See below attach sample code)

  2 - Introduce new flag for domain_alloc_paging()
    Something like :
    #define DOMAIN_FLAG_UNMANAGED	0x01
    #define DOMAIN_FLAG_UNMANAGED_SVA	0x02

    domain_alloc_paging(dev, flag)
    For now we will have 'DOMAIN_PAGING_UNMANAGED'.

Please let us know which one is preferred -OR- is there any other better way to
handle this.

-Vasant


---------------
commit bdf17f429dfb76b5a9a5714045ce3f38a4ee98b3
Author: Vasant Hegde <vasant.hegde@amd.com>
Date:   Fri Jun 28 11:56:18 2024 +0530

    [RFC] iommu: domain_alloc_paging enhancement

    Prototype to show how domain_alloc_paging() looks like. This doesn't even
    compile as I have not modified other driver which has domain_alloc_paging()
    implementation.

    Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c2703599bb16..e401c2d9ab8e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2429,6 +2429,22 @@ static struct iommu_domain
*amd_iommu_domain_alloc(unsigned int type)
 	return domain;
 }

+static struct iommu_domain *amd_iommu_domain_alloc_paging(struct device *dev,
u32 type)
+{
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+	int pgtable = amd_iommu_pgtable;
+
+	/* TODO: Add SNP and other checks */
+
+	/* Force V1 page table for UNMANAGED domain */
+	if (type == IOMMU_DOMAIN_UNMANAGED)
+		pgtable = AMD_IOMMU_V1;
+	else if (dev_is_pci(dev) && pdev_pasid_supported(dev_data))
+		pgtable = AMD_IOMMU_V2;
+
+	return do_iommu_domain_alloc(IOMMU_DOMAIN_DMA, dev, 0, pgtable);
+}
+
 static struct iommu_domain *
 amd_iommu_domain_alloc_user(struct device *dev, u32 flags,
 			    struct iommu_domain *parent,
@@ -2860,6 +2876,7 @@ static int amd_iommu_dev_disable_feature(struct device *dev,
 const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.domain_alloc = amd_iommu_domain_alloc,
+	.domain_alloc_paging = amd_iommu_domain_alloc_paging,
 	.domain_alloc_user = amd_iommu_domain_alloc_user,
 	.domain_alloc_sva = amd_iommu_domain_alloc_sva,
 	.probe_device = amd_iommu_probe_device,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 9df7cc75c1bc..7fb95f90158e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1952,7 +1952,7 @@ static struct iommu_domain *__iommu_domain_alloc(const
struct iommu_ops *ops,
 	else if (alloc_type == IOMMU_DOMAIN_BLOCKED && ops->blocked_domain)
 		return ops->blocked_domain;
 	else if (type & __IOMMU_DOMAIN_PAGING && ops->domain_alloc_paging)
-		domain = ops->domain_alloc_paging(dev);
+		domain = ops->domain_alloc_paging(dev, type);
 	else if (ops->domain_alloc)
 		domain = ops->domain_alloc(alloc_type);
 	else
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 17b3f36ad843..d408eb70e086 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -192,6 +192,9 @@ struct iommu_domain_geometry {
 #define IOMMU_DOMAIN_BLOCKED	(0U)
 #define IOMMU_DOMAIN_IDENTITY	(__IOMMU_DOMAIN_PT)
 #define IOMMU_DOMAIN_UNMANAGED	(__IOMMU_DOMAIN_PAGING)
+/* XXX: Introduce this type when we add PASID support for UNMANAGED domain */
+#define IOMMU_DOMAIN_UNMANAGED_SVA (__IOMMU_DOMAIN_PAGING |    \
+				    __IOMMU_DOMAIN_SVA)
 #define IOMMU_DOMAIN_DMA	(__IOMMU_DOMAIN_PAGING |	\
 				 __IOMMU_DOMAIN_DMA_API)
 #define IOMMU_DOMAIN_DMA_FQ	(__IOMMU_DOMAIN_PAGING |	\
@@ -557,7 +560,7 @@ struct iommu_ops {
 	struct iommu_domain *(*domain_alloc_user)(
 		struct device *dev, u32 flags, struct iommu_domain *parent,
 		const struct iommu_user_data *user_data);
-	struct iommu_domain *(*domain_alloc_paging)(struct device *dev);
+	struct iommu_domain *(*domain_alloc_paging)(struct device *dev, u32
iommu_domain_type);
 	struct iommu_domain *(*domain_alloc_sva)(struct device *dev,
 						 struct mm_struct *mm);

