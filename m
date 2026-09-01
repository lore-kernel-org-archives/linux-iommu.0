Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011016.outbound.protection.outlook.com [40.93.194.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A2A46C4CD
	for <iommu@lists.linux.dev>; Tue,  1 Sep 2026 07:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788249394; cv=fail; b=ohQ8Gzj+L0/Yfq+A1wMhLfceIdRsyJdmJ951v953rSiYVhsv2MuhZyR9s1cH2fRDRghQwTn/YPflVbZ0A3mmXPZUJ2liOHPwDnrtAlZf46GhCXcxi9epX8zmLWVu8ioH0zrP4TDZWjgbCqUnTj67rhL9T/JUDc17qGmXppzqqEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788249394; c=relaxed/simple;
	bh=qs+Cu+uYZOpcbOQq8mRXC2wgQQ6VrWj4yAu/qd083jE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O7AfYRI3rwU0wSX5Ju/64g8VQd7RapaekxujTpV1hZGEilhiJeok07J/6fPYyXwNPvTypM5/i+ls4aAMKLWtwoJkNLmlHP2f6WOlsZnEkQYz+kzyJfhKYvEvQ6TI0OsF7m9DnfSJ1hNd0KgUkSfAcCVi62Jd76rtR/9i8caQe2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k3rvX6js; arc=fail smtp.client-ip=40.93.194.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k3rvX6js"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UDpZoGpJkKVKQvZHf1IRJBYBhpLtq/Sudu+D2zizlrOAtvQFrAtJQFbSAxPj/tJVYW/fT6rKCouqywIc96GFL1n2HW8wxD+xPeFRXcyKeyJ/ZiqCtQX2xfXVjoQOYz638ZvHoUnJTcicdoKnPVJphIHeYRF15ZLPG1uVaxvFw76QqeHdIZ16sy53xrWk4/DMUtuoyHrSS1dvzi5nLXxPkotgTa5lpjP9Yg0frj+1WNs9dIMaxlNotHncJWtK21lb2l+JenVQLlIhDVwfaQfxa/Rpf7VfcdXtu3a4xyET5yTsf1DdQKg1qaPEDz4a0gT5SeTQIIec/avlsDCwnxpAdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4iyUqK94g23NZLvg0LGVQVFP42usBrQbtnnuW64sIk=;
 b=pntY84sPpa8qjmQd/zIsfHfTGPZBYOdJ2YCN3TpcD6Ls1Ub63dHzi+hoRKSTDihV0QZPjwgmC1kD0GZ1KEK65Rp29oSktRhoNORp2Ngo3IxlplrC1ZCD3z74oD2S/xT4F0MAwbTGRo0E0GvNHqG92ot4aocQaB6dIg7pv8wR5cTovxi16hUhkc+r5zieDSQQqwJWUwAfmPuy1wV0/mCpCnKrqD0BTX7riJOsGz+zVhTChsV5b40iNkI2ZuSN5FC+Atbd8xDzWmi53Aa1CV7mpedjXyWVck/clLrodNSSsKxutZO03d+2UJAQTx7p3X9skmH6q3zxO+TDHwz/8nT47w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4iyUqK94g23NZLvg0LGVQVFP42usBrQbtnnuW64sIk=;
 b=k3rvX6jsa0Wti48IYtaKYmC6jDuPWCNPKaiGQQ85/XyiBGdxlvEn4YQEPaZ8YDzV1pJFHK5rb4+zKQvbjpNRLH8yZOsc9JRgNnCzRtx2YiZXDbP9DnHHL4vFw8vrjVmZdYDVZ/H0jAdsrtqqRT1vcvR17Z00OADImpcHaTNYgSM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999171.namprd12.prod.outlook.com (2603:10b6:8:388::22)
 by CH1PR12MB9719.namprd12.prod.outlook.com (2603:10b6:610:2b2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 07:56:29 +0000
Received: from DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19]) by DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19%4]) with mapi id 15.21.0382.007; Tue, 1 Sep 2026
 07:56:29 +0000
Message-ID: <1659245c-cebf-483b-8aaf-fb277f65f1c3@amd.com>
Date: Tue, 1 Sep 2026 14:56:19 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/24] iommu/amd: Make amd_iommu_completion_wait()
 non-static
To: Vasant Hegde <vasant.hegde@amd.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, joro@8bytes.org, jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, Sairaj.K@amd.com,
 jay.chen@amd.com, wvw@google.com, wnliu@google.com, dantuluris@google.com,
 chriscli@google.com, kpsingh@google.com, alejandro.j.jimenez@oracle.com,
 joao.m.martins@oracle.com
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-2-suravee.suthikulpanit@amd.com>
 <be2f6b1d-69cc-4a5c-9de4-f3fab9a5ad1a@amd.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <be2f6b1d-69cc-4a5c-9de4-f3fab9a5ad1a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU2P306CA0051.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3d::12) To DSVPR12MB999171.namprd12.prod.outlook.com
 (2603:10b6:8:388::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999171:EE_|CH1PR12MB9719:EE_
X-MS-Office365-Filtering-Correlation-Id: 64503f56-f846-4088-4555-08df07fe878d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|4143699003|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	iosKZpnvf5lCZ5S5al/KKWlUdKvthRx2mEwpg6lTQ8r8jBNJK5DYNJg7D12pTkHvqrphhX6+ST0z1WdXsKwxqsH7LA8os2Ur0AXSpUdeykyBmBkdZfFa/Ig2+0pedOezeLrWDu58dKlPZ0MxFLV3uCnP3OxprgTtBUzs1fy0Bkih7CkgDhQQrgY3XKC3xuIRal73CAUYHZNW1ZYsRRuE+y8wvTt0hoNo+4TzkDnG+n0STERan4USwa17J0I0ddRoh/6iHsdIb4ETmP8lBreXeSwts5zta65Bk/tptm5bPcsmz3hwDRYfmgFJ6yhOFLf5OsPhuw3dfUJW7MKrtK+1sjdLNcWeGC/Q/2VvYtGJxWzVJmucsNQPfi42wkYx0AqwCEv+hC3p8/kT/2tb/XDxdz+naPL9fPukqreTC0Qy+AvfztfqmM4RlsZjdt5r2BN3FZ6sJ/MwrO/sZ9FtIDsmRw18wtgKG1jpcJn/wFVil02xo9is5mPSGS9FaZodVQvRdF96STpGN1ymlXRykEf+hjd2BWAvAWXi910J9gYDrjov9r2bdN96t662aLofXV6YhzxVFMI2F4my2eC0PIRFxKtaCHqmUwSEVbIfgoZmoRdJsYF+Dq0tVLfLidrQ0TfLscAVJekSrM7A0q9voLNUcVCpexjbvEtfJR7qWxVAeeM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB999171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(4143699003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eStzdVh4SW1zZy9IRWYwcHdWdU4ra0RzRGZCVGFwbmxhK05NUkErdHlxOUR2?=
 =?utf-8?B?cmpZNDR5d00rQlg0NktQZzJCdUVsSngwNmxyQUhRZFIrYkd3dEtnMEQ4djcr?=
 =?utf-8?B?VHFKRGZnMGFjVHlJczhmWEpzNDVISWRaUVNoc2NIUkNGaXB6alZxYVRTVVp6?=
 =?utf-8?B?SEIyT0lsbFNtUEI1SnFPdWRGVllTUDArVTR0R2h5SURybHF2dEFOLzd0K1hO?=
 =?utf-8?B?MXJ0TzJZSkdDdlY2NEloSW9wdTNEVXBJZUt3VXJKdmdTc0tPU2laYnpQOWZl?=
 =?utf-8?B?ZTFxc2ozQ1lPODM4WWk1aG4weWhXRkNZY2FNeXRQa3JzUWg0aHdjUXdYWTBv?=
 =?utf-8?B?S21taUsxZVMwS0cyNE16dmtWbkJHR0JjNlN2TTVTN0lJZzdkcEZzRUlBZmNV?=
 =?utf-8?B?cEVBQTJ2SFZoTHowZ3NCUFVqeU9JUXEwbll2SHdrUWllTzlEUVBkL2t1SHRD?=
 =?utf-8?B?T3JOVFE1eUJENnVKTEhFQjFCaGtpSURnL2YweG1oK0tlVlZqOXBaRTIxNHVT?=
 =?utf-8?B?VE1MaWVkWUl2TTFXS1pBNVZHSEc4Yzk0RHMxUUlNdmNDelFyZnd5eDVmYVhx?=
 =?utf-8?B?Y2I5TkRNQ29jRmRxZ3lUenJwRmowd1ZnbzhWYy8yKzVreGYxN2ErZTBmZitB?=
 =?utf-8?B?SWptNllnaWhDdlRxU1o5RU1ySUJ5akRYT0ZlUVpOSTV5NTZldDA3cXd2ZVJR?=
 =?utf-8?B?bC90Q2g2OHkyZHRaUWNLQVlubDF5bXl0WlJKRGRzZjBYYnl5aGNwdFIyTlV2?=
 =?utf-8?B?Mmk0Y0xYOHdNWkxZTFpRMEcvYzY1SVZJRmRwNUhTOUFwa0VZQ0wybVRhekhN?=
 =?utf-8?B?SnNUSjJRTXVSTEg0NFZYcGJSMHdaMmNMYm1OaWdzekxqQkkwOUxOODVlWWRO?=
 =?utf-8?B?dkpQNjhINWVZdjZyTWFwTlZuUXJEdjBVRmxvUE1LdmRHZWlqeWl4LzBSZFlO?=
 =?utf-8?B?TTBCV0REeWNHQUxITHVic0xuOExXbmwyNCthSjNaRHQ2T3d3NmZTMVg2dk44?=
 =?utf-8?B?OE94WmVYSzB6aHZpZ3VxbGtmayswM29SMG81bzRiU3ZndThKVzZMaFdkWitq?=
 =?utf-8?B?QVBGWTQwdzZKcDR4SlJoekZPSHhFMEpLUXdvRTJYbDQ0Y3BlUlk5Tks4STlm?=
 =?utf-8?B?M2lXMVl1VWJMeXNQRGE4bWo3bWNnbm0xWW1vR3BYNlhJSS9iYlpEd05RNWgr?=
 =?utf-8?B?d2NnQTl5M3VMUW96V1grQUdhVVRiakIzMWtrZ1N1d2JUVHdjYk4ra2FJQmVv?=
 =?utf-8?B?NjA5MFRNNUVUa1JHMmplT2NDSDdyZWpERlE0eExUQzZyQnFCNmZyUXg2WnEx?=
 =?utf-8?B?NmpTN1RYcHpNd1lhazg1c3N0NVdYNmxPOWxnaUtSaVRUSzlYaUhrL01CZGQ3?=
 =?utf-8?B?ZzQvTkM2eTE2R3cxYjJ3QjlCNGs5dk5ObjBpM0RFMkhFS1I4OCs5QlhicG9x?=
 =?utf-8?B?Z2E1dytyVVpTKzJpaHNhUUVPa20rYXJ2MmhiYlJzWVduTXdTNFFDV0l0dHJE?=
 =?utf-8?B?aFk5TU5YanVOQXZvblFHTTdLenRPQWV2ang4cGJ2MTZKeWVNWUg0dUlLTm91?=
 =?utf-8?B?SHRRTnBpYWp3eUtlRld1UFRXeUNzdFJkVmxHZm1HelFERjVNbGJQWkt1Z24r?=
 =?utf-8?B?a2RRVW41YmVUcEkzWjg5WllXT09zU09nV1lVKzVwNVJmMU50RmxSanFtdjdU?=
 =?utf-8?B?OWpkdG9QOXQ0QUNFdFkzOGk5V0tZcUt0NmNtUHBRMW5VU01VVUlQdVAyamY5?=
 =?utf-8?B?REJ5TjNRaFhDTUs0UnZISCtETHFVL0hHaWlCeDRLS3FxS1hielFFOTh0cDJp?=
 =?utf-8?B?VU5YYlYxT2NlL1JaUXNaSDdRTExhNmdoRDhkY043QW9vWVcrWU9EYTQ5RU00?=
 =?utf-8?B?bzRYS1NYMUVGcjk3T0VKQjl3bWJONW5aS3BETWRhOEliWTY3Sk1rMzJXNXQ1?=
 =?utf-8?B?Nk1IWU11ZURPOTZLK2NiU2RVWEtaSWU2UDFqTTZBQVdlOGU1NHZiU05jRXVl?=
 =?utf-8?B?WXJpUi9tRCtyRTI1WVZhNk85eGtuVVBybTh3SFovZ2IwMXZ6ZEp6cW80dEVI?=
 =?utf-8?B?QjNCN1d1RkV2NDlMSE40T0YraXZGbXVhdFIrVCtydEdJdVpsTjE1cjgyQUk2?=
 =?utf-8?B?V3RwdkZDdWRhazAyQXhXaDYrKzQybE9PODFpcEd1Zk1BVStQRVhHTWRYa05y?=
 =?utf-8?B?ckQvWkNGZjhpZHRXUnpiNWRrczhCYTQxY21obGMwbjdvWHJPVW5tOG5pSHU4?=
 =?utf-8?B?ZUxpYlQraTR6TWl4OTFCa29FOVlETE9Hdi9NR093ZnVOVnNWMjB2KzVhVHdX?=
 =?utf-8?B?WStCNEd2TGlVQ0ErVGlTanlxUnRUVlY1TjZuakx1ellaVjlKZzFoZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64503f56-f846-4088-4555-08df07fe878d
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 07:56:29.0480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hpl17AKR1QD0QLX92u8DRyfxhxyxBnvXv+ZUb41fL4xR1+FPDjBtmiyXUAdGjmsqmNviuqNCf83TlvkIRxxqYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9719



On 8/6/2026 12:01 AM, Vasant Hegde wrote:
> 
> 
> On 7/27/2026 6:58 PM, Suravee Suthikulpanit wrote:
>> This will be reused in a new iommufd.c file for nested translation.
> 
> With all the changes, looks like amd_iommu_completion_wait() is not used outside
> iommu.c. May be drop this patch?
> 
> -Vasant
> 

Good call. I'll remove this patch in V5.

Suravee
