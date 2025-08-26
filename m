Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A622D3732
	for <iommu@lists.linux.dev>; Tue, 26 Aug 2025 17:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756229792; cv=fail; b=U9bdC69m2akcP6Tf7DYnCyWTPHCnVWwK3c2NpWZViXURNzkbl4fITuIlDvKjsUxPy9zav0sIZou7yipqoXcdaAUXcejR+Nvf79JnhwXc4MKIbuuMkXpJhEMFkffTjY7MMLZWmpGuXxpboNKPGUgIYy1u08/BAIKwV4vUnLTCRNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756229792; c=relaxed/simple;
	bh=wYAmrrSruCSUDLIKlUy1FB9iitXIul4e9HZbRDKV5is=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PlVWiPQ4fhX8c7WlafDrTL41Zlh/geI4pKzILE7mQWxX0Bw70Pfvs+7XZ/TPlX7FDhFtbTnfnW9bJOTTjyDFke89/Nl3p7JV4GG1S+A3Cb9VsmD/kFHkfsi4l2nov6AestAixR/g9BhfvMxa+ZrL3WKw01fSkPAmzazF1i7m3mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vFYh8djf; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vFYh8djf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gU5nIY25GOxz+YhFCCVAZLobj38uHyjR0CrP5Sme2fUdO/kwOA6K4H9pX5IM24M+8NvHRyfmoo4eWGhmJ3gOck8Mk2LV4JY+520pRPJ9eSP2tzuOCw11Fl/ZVqzGoV9mOGte9qC8dYW5/7GN8+cIhK4RJfpZlKEdmWR6asi3dVkHLJkb0Lv+Qy4MymjydgEHbpqWWOe/aZQI3Hk+J+Dlao8vjTdy5V7j2Vdrlfx/l96OZ60AebEKb2MKjJEIiZhsVPINB4uSNZIPgK0K9HA3ZGOGfQnx7kIEf4zXfyfSE679sGKEvbwDz7UmzglhF86vdUtA+yYCq/Zy3FeKzJ3kDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERLjr65d2EA96Qk4n1ZYRigszuyshUOX5/rDkxFCFAg=;
 b=AvciUbMHSZWATnWlOmmqjkqmSAsec+xjtr0Or29q7NgVNAPpmJr8jy7BiOjlpE8GOp9rIx3ymZBKEyMx+86R8RL/lzup4mhRTD1X4hCAKQMutzhIW3jcQy6nzL65L25rP2iqAPIClbIdYUatuOWvTJny1m2mAIhxRo4OSvfsIsukGpPcOXfKqZSU/6Wtmiy75JLygLIUJmK5XAl3aklk+xQ3rlGpF7eK+MQ6h3hsKflI46tlLtLrCXOvWg4SaLu03pIxNXMdgEQsvHJuyCI5i2aDbT6iLqAphuXUbzOEyKmqYWlRe5XgjHkNV5buOVuaTBSf6ZNvMfkRLjRaWSxBwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERLjr65d2EA96Qk4n1ZYRigszuyshUOX5/rDkxFCFAg=;
 b=vFYh8djfgvG3unkrzidNiwVRGXfmvD+4FF4/3+ACbcVOvIrYcnDvd0x0FEOsjfvEroVWmABiWPP+ys/kjXp5I87nG7v1QZ7FOCVLZZvE8QXOWa26RyYzW/3vvE5vJOC/LsJUk8lGP6jn5MLoAK4PaNkfAIFCqPYvMKmOyEYA2ZQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 BL3PR12MB6571.namprd12.prod.outlook.com (2603:10b6:208:38e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Tue, 26 Aug
 2025 17:36:27 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%4]) with mapi id 15.20.9073.010; Tue, 26 Aug 2025
 17:36:26 +0000
Message-ID: <85c544d7-b274-4696-9fc0-829033eaccaa@amd.com>
Date: Tue, 26 Aug 2025 12:36:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Add support for hw_info for iommu capability
 query
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, joro@8bytes.org, kevin.tian@intel.com,
 vasant.hegde@amd.com, iommu@lists.linux.dev, santosh.shukla@amd.com,
 sairaj.arunkodilkar@amd.com, jon.grimm@amd.com, prashanthpra@google.com,
 wvw@google.com, wnliu@google.com, gptran@google.com, kpsingh@google.com
References: <20250820042533.5962-1-suravee.suthikulpanit@amd.com>
 <20250825134420.GB1970008@nvidia.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20250825134420.GB1970008@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0134.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::11) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|BL3PR12MB6571:EE_
X-MS-Office365-Filtering-Correlation-Id: dbcbfc48-20cc-4ee8-4ab2-08dde4c71552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UTlWNHhJVjRpdmtYVjc3dGtrSnlqRmtKOFc5ZGpURitPY1BMU1FFUlExbGpZ?=
 =?utf-8?B?YldOOHpaVUtHZ1NoUUNFREtZM1ZJeG44TkQ5dnNBdUNxWFVyN2dJOHhtWS8x?=
 =?utf-8?B?MjAwNlhIUks3UzZFaEliaU9COW1DR014UzE1b0lRWUNrYnNEMHhqNkt5Qmhx?=
 =?utf-8?B?NzY5VGFJRDJsWWI3dVE4RDl1WHNVMkkyQ3NSQkQyNkUveklob3lvVERDWEVU?=
 =?utf-8?B?Z0Y1S1dxYWpaUW45OGducFVxN1kyb1lsUjNFaUtuRjVPbXFrR2NJUXd5OUR0?=
 =?utf-8?B?cUUrTklidFhWQUJtRGkzR1V6MnI0MG5LbEtvMlE0S08xTWluZXh0czFnck5G?=
 =?utf-8?B?aEFvUmR6YzFReGlRdkNOWnY5bDlQYVpPQlg0WHZ5dXlwV0MzSis0RjFPT2ZT?=
 =?utf-8?B?ZmVJNVVEay82eFpZSWtnd0R1dVdaZkMwNm9OU2hjcXF3QURxbnpud0lvMVR5?=
 =?utf-8?B?UmNmUGJ3RFpvSkxLVDQwVEJzeUcvMmsrSHo1cE1DMThwcE5TWGtLckpGT210?=
 =?utf-8?B?UEdRK1JtcXhhNWdjWnI0dzJwNlQ1eWhmNmk1VVpiSG1rK0dRaHh2Y0E2UmFa?=
 =?utf-8?B?SXRId2xid3dxOU5Ubm1UVS9Odzl6NXlrMzZpU1c2L0Fqc25mZHFWd3RuTlYw?=
 =?utf-8?B?V0dkWG5sTmo0WmN1MnlzSmVJM2dWcEtObFU1Vml6MHNjYnRJeVM2TWNoMHJ1?=
 =?utf-8?B?WHZQOExCN0I5UG5ueEdPMmNnTno3bm9iRG90dlNFOURmRTBPeVhXNWIwWVdC?=
 =?utf-8?B?MWp4cndteFd3QjZobEVGSXRYSi9XRFhWeTJaeFNuRXczejBaS2lXbW9QR2di?=
 =?utf-8?B?ODVtb1ZMMkk2ZTU4S2xjWENOOXF2VHFhLy8zS0pUNk5maWFrbjd0T04yYjJV?=
 =?utf-8?B?RUNrTzFjd1p2RkhEc0ZOQ0IvUU96b0k2VkMvd0dDYTQwYThoS09neUN1TCtJ?=
 =?utf-8?B?OFJaK0NRQnNSV2FtVVVxSU5scXBvZHUvWDUyNThPMUoxSFhiRkMzZ1IzQW9D?=
 =?utf-8?B?WThWbWtua3ZSSzZiV0hzdTF2V095YjJYTzlWWS9oWmRiYjJsM0I0MVFseG9E?=
 =?utf-8?B?ZkRWdVFRRU5scEd3NjB1TWZ2ZW53K0lOL0VUYmUvUVpwQXdCOFp3YVl2cWwr?=
 =?utf-8?B?aDVrZ2Fucm9VZWFqK0RkMGdLVVB5eVdzVzRCa0s2YzU3dkZPdHJwUkJDKzlm?=
 =?utf-8?B?RkdaV0w4aUhaVnoxU0l1clNlN0VPVFNwcEg1dW41VzJ3Q0xwMlZ0SXVacENX?=
 =?utf-8?B?UHZQTlNnRzJNSGdxc1RqTzFkZ05wOHJDajdEL0FTYVh5eFVlejZybkcxNnl4?=
 =?utf-8?B?T0JDK0hEaTFTM1Z0UTdVdnoxb1hYUGRPRHBoUUxHaEZyMC9CWmRVb3NidGVE?=
 =?utf-8?B?cHcvOWc1TW9hUzE0bE43OXJkTnJaVWliWTBIeFVnamFLSVpqYjhnWlVvWG11?=
 =?utf-8?B?cnl1TnhqTDUyMndkSHJ4TmtNZHZYZmd4WEFtZEI4bCtpQXljWkVLR1ZtZC9I?=
 =?utf-8?B?b1RCSnB1SEdDNC9makZ2R3p5RzV6VVh6L0RHRDZIZ3drZEhMSGRXb3pXNnNz?=
 =?utf-8?B?NFFJT1I2UlNaZXd4eDZqTjFWM1NsNUZlK1FnY2kwRi8rRDcxbk9ocG9VWTZQ?=
 =?utf-8?B?UFZGWmdwQWlvaTd6QWRmdy8wOWV6RkZ0NTlHUGRoR1JFaG5xYW0zSzhRSHh6?=
 =?utf-8?B?WEJ5WjRlOWJyNmRieFJiVXdKcUZJcmgwczN1S1RLZUphZ3EzZTZCclF6bURz?=
 =?utf-8?B?TUowQk1iU0xyQllFMkFROCtQS0NRUngyMVltalZ6YzB6NThjclJCYnJpYkJW?=
 =?utf-8?B?M3d0M3JCc0FpeEliRjVCdE90N2JnTmxuejhubG9VQ1pXTnNDcmRIT2Q2NWdC?=
 =?utf-8?B?THRJUlNNa0M0R1N1Q3JZVThHbkVHcUxka0pHak1tK0Z3STRFcmFFSisxVEtE?=
 =?utf-8?Q?ZrJ+OoAgZSw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjU0ZkJRVUZNc1hyV1JLL0VTdStuekRBQzZjcVZVQXFubHNlMzVVSVBHaEpV?=
 =?utf-8?B?dTJWakYwcDkrbkJrTjBQb0t6WjlrQ1Q1UW03cUJDdnlFdnVINENObC9DbFhU?=
 =?utf-8?B?S0I2THRXblozMkVha2FYVnFHeUFZZnlDNUdUK0QxRGd0Umo2Q3NHSHRNb2Vn?=
 =?utf-8?B?Q2Z1SkNCTXhaTVV6U2dhVXcyYkxsdnB6MWgweU1OMFVNRkpjNk5Xd28zRGNV?=
 =?utf-8?B?S1JWUUVmTURzaS9yNkQzODgrMC9Pa0pPZUorV2RxekxvMnJOeFkrV3pGOEdQ?=
 =?utf-8?B?WEZMQXZBRWE0bkpkSzBCL2tPbHZ1alFlb29sOUxGYkE0R2hEV2Y0N2xFL0px?=
 =?utf-8?B?ODVMS1haQ3dpMGkveGpEWFE4UXAvc252emo0NUVBWHp0NTVXN2JueXJiYkg1?=
 =?utf-8?B?U0dXcTlUZWhKM00xdkUyaU9idCtQTjJ6Nk5xT1NBNGZ6bWRVOER5b1NSZ3lN?=
 =?utf-8?B?RkpyQ000Z2x2ZDRNK3Jld3M0OFIzZytCTTlyWXRuRmpuK2xtK0VTNWhobW5C?=
 =?utf-8?B?YlRMbnhxOUxnRVVsQ1Z2ZWV1SWZOcVdrMEtsc0U4ZEZvTHFNdVhUYVJnRC9G?=
 =?utf-8?B?T3ZsK09FelN3bW1taWl1K3F1QUFBR0Y0V2JFUmo0eVZtWkxmVlhpZC85NVJC?=
 =?utf-8?B?T3dRRFdvYlBtVmhvdGZzTnZjWmpnL0MxR1NMKzVwOEpGRnYxSUlla0x6QlZ0?=
 =?utf-8?B?bFd2c1h5a3FMSDAxSTlvR3FwL0ZITVB0Q2x0RVNqUkJsSEtnTnE4MHB4TVBz?=
 =?utf-8?B?QS9UNWhZNXJGNFdRa0FsWFkxUlJubVgrWnRJZndiVmg5SVpwTkYzeHZJMjdK?=
 =?utf-8?B?WHpzdzEydThaVXk5MkdPYUFZeFhzNEdFcWRyMXdtRk9GYS82Z2diNTkyRjVp?=
 =?utf-8?B?c3djWS9qZkxSRXE5MVYxeWNHQ0YvV2ZTNTdiem9WU24rKzAwVSsvazhJQ09H?=
 =?utf-8?B?MlY0ZElPazNXQ2ducDN4YjFZOVNjSzRkaHA2a1FkejZpWWd6OHk1UXN2MHhE?=
 =?utf-8?B?K0tSbThRQ2VyVzMvZFFnYkZTMDBaUUtKam52Y3pNaGhJdS9sN0tzVzdMZnRt?=
 =?utf-8?B?NWZqSzlUdWEzeVlXZ0VHUFliMmpiWlVjUXoxOVN1NWkyZDBEKzBRTGZjR0p1?=
 =?utf-8?B?S05weWswSzRhK1FVMlVLM2FTUFVpa0FkdnRvR1pWaGZNd3FUbE4ydXhKeWRi?=
 =?utf-8?B?anoyQXNZemZVcmFYcjBVdEE2MXRpZ2s2QW90UXNWWkorWm5JOThtQVdiR0dq?=
 =?utf-8?B?cWsxZHJBSXNPYkNxeE5qaG4vRXl3NnZkWlp2VnlCczJKcTVNcUg4Y000QzVw?=
 =?utf-8?B?aEN6ems5YTAyY1NOb3QrS0xkN3RFVEVGMU1RS0FpWFBRdjlTakJlT3h3MlVC?=
 =?utf-8?B?REhzYzhDZTRkQjZkOFlYYVBuczQzUlIwQjJkZHNrVXNPTlJ0enUvdjMzTmtx?=
 =?utf-8?B?QWVacGYxRWNxcVQ5SFRiTEN1U2IyQk0wSno5ZEhtUk1wL2dBdXdrTCtrNXZL?=
 =?utf-8?B?WEtWOU5IT3h2Z0VYbWZlVmdLcVdvRXI0VDN3Ujg5YmVyajJnZ3JjYWVCVTJq?=
 =?utf-8?B?NmV5Ykd3emdtd1BoeWhkTnlHaDl3YTRMaHphbTlvUGgwbTNsM3R6RXpsTy9V?=
 =?utf-8?B?YUg3MkY1WjZnYzllY1ZXYUhjME1JTGpjNFpoRW0zREQ1MExCZHpSMXRlbUJC?=
 =?utf-8?B?Vit0RTBtQXVrWmRxb0RibUNRV3JnMFQwOFBkUTFDOGxqYWhOTmZCQyt4bG55?=
 =?utf-8?B?ajNWaDYyNlY0WndWVG1xVXZONjBlSUdhV3NoVURta0xtTlNaNGV5UlFhRTc0?=
 =?utf-8?B?RHBUQWV1SDlXUThRVDdkTkt4Q3ZzaGZuMWEwc2J6L0duZGUzNkYrc2VtQ2hu?=
 =?utf-8?B?Nm02WTVTa2xScFB3WGJGVVJ0OVYveXRHcHNOUFBHeHQ4NVNnZ2JjQStNWUJD?=
 =?utf-8?B?M2Q2Q1BEcTNRV3h1eFdpSDdONCtKRkJ5S24rSDZRSzAzWFEzcnpWR2ZlODBC?=
 =?utf-8?B?MlV1bGhzeUpNS2hUVEluRDBSeXo2NlBZbWhFQm1LdmxKRGZJeHd0RWpYeUI0?=
 =?utf-8?B?dlJFZkJZak1kVFBJRktOL203dlVIY1A0OWk2MHFYZjN2cEw5WmFldWVCMVZE?=
 =?utf-8?Q?75fZ81nrv53USotan1VPdTmlG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbcbfc48-20cc-4ee8-4ab2-08dde4c71552
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 17:36:26.5934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+SR8jiw+TW0FVnbGYs4Hr9kBk+dyHfezzwyS087tK2FEy/x437SfSUWhFzeiYWMR5F5boQ4czEIV1/585yFug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6571



On 8/25/2025 8:44 AM, Jason Gunthorpe wrote:
> On Wed, Aug 20, 2025 at 04:25:33AM +0000, Suravee Suthikulpanit wrote:
>> AMD IOMMU Extended Feature (EFR) and Extended Feature 2 (EFR2) registers
>> specify features supported by each IOMMU hardware instance.
>> The IOMMU driver checks each feature-specific bits before enabling
>> each feature at run time.
>>
>> For IOMMUFD, the hypervisor determines which IOMMU features to support
>> in the guest, and communicates this information to user-space (e.g. QEMU)
>> via iommufd IOMMU_DEVICE_GET_HW_INFO ioctl.
>>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> ---
>>   drivers/iommu/amd/amd_iommu_types.h |  3 +++
>>   drivers/iommu/amd/iommu.c           | 40 +++++++++++++++++++++++++++++
>>   include/uapi/linux/iommufd.h        | 19 ++++++++++++++
>>   3 files changed, 62 insertions(+)
> 
> Can you follow what ARM did and put the iommufd functions in a
> amd/iommufd.c file? I think that worked pretty good.

Sure, I can put it in the amd/iommufd.c.

> 
>> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
>> index 5219d7ddfdaa..efdd0cbda1df 100644
>> --- a/drivers/iommu/amd/amd_iommu_types.h
>> +++ b/drivers/iommu/amd/amd_iommu_types.h
>> @@ -95,9 +95,12 @@
>>   #define FEATURE_HE		BIT_ULL(8)
>>   #define FEATURE_PC		BIT_ULL(9)
>>   #define FEATURE_HATS		GENMASK_ULL(11, 10)
>> +#define FEATURE_GATS_SHIFT	12
>>   #define FEATURE_GATS		GENMASK_ULL(13, 12)
>> +#define FEATURE_GLX_SHIFT	14
>>   #define FEATURE_GLX		GENMASK_ULL(15, 14)
>>   #define FEATURE_GAM_VAPIC	BIT_ULL(21)
>> +#define FEATURE_PASMAX_SHIFT	32
>>   #define FEATURE_PASMAX		GENMASK_ULL(36, 32)
> 
> Please no.. FIELD_PREP is how to get the shift, don't add constants.

Good point. Ok

>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index eb348c63a8d0..ebe1cb9b0807 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -3038,8 +3038,48 @@ static const struct iommu_dirty_ops amd_dirty_ops = {
>>   	.read_and_clear_dirty = amd_iommu_read_and_clear_dirty,
>>   };
>>   
>> +#define AMD_VIOMMU_EFR_GUEST_TRANSLATION_FLAGS \
>> +	(FEATURE_GT | FEATURE_GA | FEATURE_GIOSUP | \
>> +	 FEATURE_PPR | FEATURE_EPHSUP)
>> +
>> +static void _build_efr_guest_translation(struct amd_iommu *iommu, u64 *efr, u64 *efr2)
>> +{
>> +	/*
>> +	 * Build the EFR against the current hardware capabilities
>> +	 *
>> +	 * Also, not all IOMMU features are emulated by KVM.
>> +	 * Therefore, only advertise what KVM can support
>> +	 * or virtualzied by the hardware.
>> +	 */
> 
> What does KVM have to do with iommu features on AMD architecture??

Sorry, I meant to say hypervisor.

>> +	if (!efr)
>> +		return;
>> +
>> +	*efr |= (amd_iommu_efr & AMD_VIOMMU_EFR_GUEST_TRANSLATION_FLAGS);
>> +	*efr |= (FIELD_GET(FEATURE_GATS, amd_iommu_efr) << FEATURE_GATS_SHIFT);
>> +	*efr |= (FIELD_GET(FEATURE_GLX, amd_iommu_efr) << FEATURE_GLX_SHIFT);
>> +	*efr |= (FIELD_GET(FEATURE_PASMAX, amd_iommu_efr) << FEATURE_PASMAX_SHIFT);
>> +	pr_debug("%s: efr=%#llx\n", __func__, *efr);
>> +}
> 
> I'm not sure all this masking is a good idea, how do you intend to
> handshake upgrades when more features are supported if masking is
> present?
> 
> Nothing sets efr2?

We are planning to extend this function to advertise additional flags in 
EFR/EFR2 once we add guest support for the corresponded features in the 
hypervisor in the future.

>> +/**
>> + * struct iommu_hw_info_amd - AMD IOMMU device info
>> + *
>> + * @efr : Value of AMD IOMMU Extended Feature Register (EFR)
>> + * @efr2: Value of AMD IOMMU Extended Feature 2 Register (EFR2)
>> + *
>> + * Please See description of these registers in the following sections of
>> + * the AMD I/O Virtualization Technology (IOMMU) Specification.
>> + * (https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_IOMMU.pdf)
>> + *
>> + * - MMIO Offset 0030h IOMMU Extended Feature Register
>> + * - MMIO Offset 01A0h IOMMU Extended Feature 2 Register
>> + */
> 
> Need to document the masking and explain what the forwards/backwards
> compatible strategy is here.

Sure, I can add a note that certain EFR/EFR2 are masked based on the 
available support in the hypervisor.

> I think you should probably just pass the raw HW value through and
> require the VMM to figure out what bits it needs based on feature
> flags elsewhere.

The problem is some of the features are virtualized by hardware, which 
needs enabling from the Linux AMD IOMMU driver. We cannot just provide 
all flags since VMM would not know if the kernel has the support 
enabled. Some of these bits are also propagated to guest AMD IOMMU 
driver. If we don't mask them, the guest would detect and try to enable 
unsupported features, which would cause failure.

Thanks,
Suravee
