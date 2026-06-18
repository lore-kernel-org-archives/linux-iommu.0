Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010065.outbound.protection.outlook.com [40.93.198.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5D831985C
	for <iommu@lists.linux.dev>; Thu, 18 Jun 2026 05:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781761863; cv=fail; b=DnAIXbCaIGUZpxX4ozNSmPw+xnkDgzacsWIB7f5VZD2zHsepLk6lbg5ornDQ8nwWQtBLcq+EuTO8xlbcXVTqtqRjL5zfOFVFmBw42feUynGXlk5aC0GJpGMd2FUVXut6larilgdNwDM/mIADigOFlSxHzUlDbVr1FJph9Y/Xy2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781761863; c=relaxed/simple;
	bh=mxWgTE66LypCGHrQ7L4DO2CpCMc5PI/Ubh+eHKqEiTI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oYXRV2k3CTD9xQhTweL2hXMLNJfgovmoU3ka0S/fubTE5egZetx1r1tC9NE5UCGoF8lPP8G64A5D2crZWhXp0Mwfph15JTFtyIi2CIN0NWQWb5N/buMBAxrvdJJTHXQONinA3HbL5pW1I8hJWm4Nq2/1SCXtekEcne1T7/VSTvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jwehS1P0; arc=fail smtp.client-ip=40.93.198.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jwehS1P0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OnsZ1JUcovwbE0YxiSVcMettPl7PYb/JM1uGqwndEIS47PrSk2bmdLBvWwsz9IEiLEKj1ElabX2r/bkTEcTsljnMTUo1yYHl3JyViE6LZa166ebrLCzkLi+dD6I0zKss38KHTQUsFys65TtbK7TRmGytL1o0OXvVMx+NrueXsMYPzU+9N/312EKsrRjhm0l5hBQcKfPpKgpJs7KqnYGZ8No2FhcOx5Hi22SGZi3Z95AgCd7RBBz76x+W7vx8wsYaXD7RNVhohaYqjLlaHiBWswwCXWK1IRbso6O3sqqeBUI5BbjrYcgVdtk1BJPTQRtNPSTIxsJzlUGarKA9+Hd7iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keLs4lEBDTSdslfUqzrhh3h4x7QNK0KrUQAJyTScJ84=;
 b=gC+QoQZRHysYFePHQjxY9e6f6X5ExjQ6/r+cGe7RSkUKnoPh8KYea/K0kiY72AWGVTgN/orTLIzdZmdAF1rbbU/vveJuk3XWekeg/0SbNQPpkGC4xYgCua3EGP0AqE5wfADv8DN43C14nK3Ld/xWuwEEBKZzk2pWAy4EQVCtTUHmlYGNxKiyKj36g6grAi0N1eiUHhl/J6djhVO4Dtb1P0CA85NEbi2xm10+UEyDB76KqwtGgkYreLT0XQBiTaohwnMKmspvFgPKJaYJ9BT/dhikPHx34+zkNUYE0D++knMTvVzgsa3eOv3B9wkHCSeH0ZCLmJn5pNsOPeeou9MOCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keLs4lEBDTSdslfUqzrhh3h4x7QNK0KrUQAJyTScJ84=;
 b=jwehS1P0bDA45kHB93OxeyPLhpL7Vvri6fTOmUtsdL6Wc8dTb3NEK5EEGJbPPMPE0pkqV9X7Sms1LT/KL5vE4GBOp2+qdFH/OyHOH+uj/mhgOJIICQjWreEUcqCiDOISHXfhjovB0ELUFKd8vRhUlONxuIP1vwiPaQZRiZb+yz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSSPR12MB999236.namprd12.prod.outlook.com (2603:10b6:8:374::10)
 by PH7PR12MB6717.namprd12.prod.outlook.com (2603:10b6:510:1b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 05:50:58 +0000
Received: from DSSPR12MB999236.namprd12.prod.outlook.com
 ([fe80::8a48:f674:71b8:d21e]) by DSSPR12MB999236.namprd12.prod.outlook.com
 ([fe80::8a48:f674:71b8:d21e%5]) with mapi id 15.21.0092.006; Thu, 18 Jun 2026
 05:50:57 +0000
Message-ID: <f07d767a-3e16-4598-b7c8-a36b5315a38f@amd.com>
Date: Thu, 18 Jun 2026 12:50:48 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 21/26] iommu/amd: Map kvmfd to shared translate device
 ID for vIOMMU
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
 wnliu@google.com, dantuluris@google.com, chriscli@google.com,
 kpsingh@google.com
References: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
 <20260528051738.596013-22-suravee.suthikulpanit@amd.com>
 <20260601133552.GO3195266@nvidia.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20260601133552.GO3195266@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To DSSPR12MB999236.namprd12.prod.outlook.com
 (2603:10b6:8:374::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSSPR12MB999236:EE_|PH7PR12MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: fdf970d5-8c89-4aeb-6a83-08deccfd916e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|7416014|11063799006|4143699003|5023799004|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FrP+V2L+H/iOHmh3vQIdZTmHzcdcA/I7br3SZk8LGSCQDUcAWaZco3hFrHyjW6gYYR/5E4kAVmyeM8Ftbaqn40D/GMWIUOMaoXCofJ/gW1iSV965CkJP4t3TYOwn2QBXYgSF1oBC3rY39fGSG+Xrdy4PnTOLoRrWdueceMhHyGTL4l2WF6Z06eSb1JmDEvYCSUIxhi3ISlQVa3o0KP7r2sLEiVM2abaPeI9Jb+yZyaQi3BW0esh1xl9xwWdUiqpnqCo1vGTvOmc2Y0PyMk2ZKyHJnMPvO3rGe+aC8B4LPT4hhbEOcZBJBY4d3F+r4HW9/DatmVSP47a55wZvWSTxIkEOOaUqmJXRcZjXC/2pKX7kWKeA1nhZp1oOpEpEAqgLzb0QlEPyVqDaLnHJWT4w7t7zBd2J+mGmACLkg6e56UxXvn6p+e/DZ+X9fWaXbWQtIWeU4k4JNTcrtUpkTTUDBusymFQgoAx/EBxYfnkrKVfuCOUTCFCFld6J47iRDOA6AwzYWDABGPP8Y+OHJuz68O2E562iXRvlLunN9PqhUoaNXhAtnAynTKm/0k20d8ku84OH292Li/81f4X/maaZ6e0ITJbXTSxhxa/CTiPA7acwij4tiLkK3EIlH/0w2VB7P9ieTriqgWRGIyWsCz/sWZIwh3xYy4R98UWrppgSd3J2xp1e2I1CeVjq+A0r9s7M
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSSPR12MB999236.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(7416014)(11063799006)(4143699003)(5023799004)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0FZaFZ0UG1PR3dMcTQydXh4ZjJFZElKcGIxeWRYRUNGaFZKVE5zYnloeWRN?=
 =?utf-8?B?dTNCK3dIVU1HU0VIM0VMQ2pKQkdXd1ZVS2gzdDJCcklyOUhKVzFMcXAyU29T?=
 =?utf-8?B?dUJZUzlMdWxndzVKUDFWVWVLLzkyK3lWMUtyZ08xblljQkxMWlFxcFNsN3hi?=
 =?utf-8?B?Z3gra3lML1dKN0NCSTlkdkYrNFZVZUtlbm5kVTUvM2ErSmdPYlorUFl2THdw?=
 =?utf-8?B?alMrYzROdElqVmE4VXJ5ZFpqYS9TMzVQZzVVR05pZ0kyUFFVNC9HdE1lM2ZR?=
 =?utf-8?B?OGxBWHF3TUhKUVJDb2E4UkVBZkJ5SmpNL0I3cVdrQk1JVEVPL2w3enBpN2xp?=
 =?utf-8?B?UEVnOWFBNXhEZ296eUtWd1NhdWxjWk82QXByaVU1UkJnVC9tRVN6RGx1c2dH?=
 =?utf-8?B?clM2cnFlZlZyYVFQdkc3bGhvaE9iR200U0w0VjAxQzlpN1A5akFsUTdkdWlC?=
 =?utf-8?B?SzZ5Nml6ZDhIcUdQeHV6RnFkdncwT2poWmJXZXdjM1B0THJXUEJCdWw0aWhj?=
 =?utf-8?B?M2hoMDFJb3lyd01IYlc1K004MFlIczVrMDluY1NnY3VFWGZRVHcyVWp2WXZM?=
 =?utf-8?B?dkc5VG14Q0pMUmFuQk9WalRMcVBvb0xCOVJUaXNUS2RFWTdOLzlQWHMvVE5q?=
 =?utf-8?B?dUR4OXdXaktDRERhWUdMWTZQblQxeGg3bmpZSmtoeFkrVk1kN1lKWGZKUzhL?=
 =?utf-8?B?WUcyWmxOMFRaNjZSQkJuc0wvdHovM1I3Vm5VaHBIV0hLdWxSSDl3SHI2ckhW?=
 =?utf-8?B?THdma0V3WFF0aHVJbVhnNXVncG8yb08yMjBua3dFb3I2T0pvNXBvVFUvNFo3?=
 =?utf-8?B?OTdPakNlVlhYK1ZqU1E3OGN2RGplWjJJdVB2bmhwWG5tQlRiQWVEbytJRXl4?=
 =?utf-8?B?eHVwR1M4OEJFKzNhTFBnTW4zenJWMkxiN3g0N0JaMHlUWXBtT0tlVFBibmhY?=
 =?utf-8?B?UFNwV2UwcnRTSTlZbE14WDRMYVNtenlQTkZCK3ZMSm1MUWhtOVVJV3M4cElp?=
 =?utf-8?B?d0pJcE1aZWQ1ZWhXYzNiakxiOWE2MjJGOEloMGFGTWJUY1hNMDZEN1g2YWwv?=
 =?utf-8?B?cFpVMjNScmxHNFpkNThTcUwzcldUTXJURHV5VFptanVSOG5uamVJQWdvY0Nw?=
 =?utf-8?B?aS9XMVNOajRKOEpSY1lZWnltSkNITkFvVlZFMHlaVWZaK2RPVzh0NFZuT05E?=
 =?utf-8?B?VmxMMVp3QkJ0RFFGaUpaRFJQOG9XT2VudDBuOVFtVDBJeTFxOGxNQlo2Z21I?=
 =?utf-8?B?dUwzU0V6alBvZVpTS0xQZ0NrQTdDbWh0akJkZjV4SG9rME4wWFByRUE4Y3J6?=
 =?utf-8?B?N2hGdjZOVEowNU1LdGsxeTBwdU5rMzdteXdxVHowOUkxSnkwODFlVkdtYVls?=
 =?utf-8?B?OGtNMndxL0c0bkFkV3hLY09Bbk1mYXRVcm5WT3hVMnhDVG9NY2NPWDI1ZjV0?=
 =?utf-8?B?YjdZUWNCMHVHeUtZay9KMlZocHlNWWFFOHBDV3RIVUxLTHExcURIQVRKNUhM?=
 =?utf-8?B?b3VlTkhYbCs2QlhwYm5ORVFxWGQ1UzN4ZjBIdUgrR2JvUXhlRjlRNDZDbERo?=
 =?utf-8?B?dzJwV2dsTDY1bG1RN3orQ3ZnWGNSckxsN1gxYmRTeHNHUUU1NEV2UHp0M3dl?=
 =?utf-8?B?UEl4NVBCbVAxaE1OU1JDSFlCbEdKSHJLSFJ1dElQUUFMcjFIZlNwWlNtSHJB?=
 =?utf-8?B?bnFWRll0Nmp2WlhvRE9jbVI0bjgvblJRVFFUczdCL1JvaUZuNXdyR3lBbEdW?=
 =?utf-8?B?cXVONmlqSHZlbVBCY1RyUm8vQmJyMUUxZzIrVVhjY0hUR1NGNEJib2FRQ28w?=
 =?utf-8?B?YitVR3VoWGdlYWJ5REwxdXBpWkZGbUxoSWtORGs4N2UwMUtuekVGZDVMMFBJ?=
 =?utf-8?B?cVhkSWt0dHJQRWx5K0VsWXdlWnBPeWsvL3BEZkhGdGE3MERYdWdnU2hzSnV1?=
 =?utf-8?B?M1pNVlRQWDgxcUtMeDRTUjNrQWtVTTE1bUIyN21IdEs3Nm9LQktPczlNQjQ5?=
 =?utf-8?B?N0tLL0VlTXFkSUwvanV2bGx4blVJem8yeUhWajlabjlsSzJhMXI4MmE4VGh2?=
 =?utf-8?B?ZThzMWRYL2E4NDBwNjlCam9WRkRMRUw3aVUxdjFnY0RoaTkveTdWL1JvRXhU?=
 =?utf-8?B?UEdISjRUS1poQXgvR1hZVy8wWmtFTFF2U0JFd1dSWUpPczhCWmhEclQvUEU1?=
 =?utf-8?B?UVNBVFlXUGV0TXZuUmxFS3hMMnpXNFBIbDkyd3RvZ2U3aDJHWHdKNHNrSitY?=
 =?utf-8?B?QUJBTVRNUTZRYXpMeXliaHhlQ2c0Mi8wekZHM0dwWVVTVEhTdVBJUklxWmhR?=
 =?utf-8?B?NDI0aG50TDBKdFNsVUo1bmVKUE1MaUpYcmUxdnpDSThDOExuTm5kZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf970d5-8c89-4aeb-6a83-08deccfd916e
X-MS-Exchange-CrossTenant-AuthSource: DSSPR12MB999236.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 05:50:57.7329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: StiBUiNLgzB6vHRqUJvTR+z/GiWj/MXFsIqFcUDaP0SnU+X7lvdsjGBl8UiJzPIrmTruD5rsMzGIeemNHL0ZKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6717

Jason,

On 6/1/2026 8:35 PM, Jason Gunthorpe wrote:
> On Thu, May 28, 2026 at 05:17:33AM +0000, Suravee Suthikulpanit wrote:
>> Add per-PCI-segment kvmfd xarray amd_iommu_kvmfd_trans_entry with
>> refcounted so all vIOMMUs for one VM share one translate-device-id and
>> GPA->SPA DTE.
> 
> What? There should no KVM in the viommu implementation.
> 
> I can't understand why you did this.
> 
> AFAICT the HW needs some unused devid "TransDevID" for some
> purpose. This is pretty sketchy, but OK..
> 
> The ID should be affiliated with every nest parent domain, or maybe
> every vIOMMU.
> 
> It has nothing to do with KVM. You can't assume anything about iommufd
> is constructing the viommu based on the KVM.
> 
> The only acceptable use of KVM in iommufd land is to get some CPU
> specific shared information which this is not doing.
> 
> So no to any KVM stuff in this series.

I will remove kvmfd stuff from this series, and decouple it from 
TransDevID management.

However, in upcoming series, when introduces vIOMMU EventLog and PPRLog 
virtualization support, we need kvm to get SVM AVIC information in order 
to setup extended interrupt remapping for EventLog and PPRLog 
interrupts. Any suggestions on how to achieve this if you do not want to 
pass kvmfd from userspace?

Thanks,
Suravee



