Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2059.outbound.protection.outlook.com [40.107.95.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AC422B8A9
	for <iommu@lists.linux.dev>; Mon, 10 Mar 2025 14:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741616024; cv=fail; b=Pbsbh3EMAwWuxhntcB+bNIJlGENXC4vgUp96ikl6QRJDo0Zh71xBv9Syk4t0J64YCrAvgX47fAQXK72Ehj8idtaORZXCBrtR7+Jif294L8+9ljIUMRIbJLuJjoF/FasDI17omcYnbmMmyBPVBqYr+M8f9atM5oZpLVJfQYEIhVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741616024; c=relaxed/simple;
	bh=nUn25iZ65ntehUMRUNXcPN+8HGKIXf+RhjZrQFSELpQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SNUqyahRvwjB+xmiWpIkLSeSd/5I+DJaJ+JVLSaJUABTWc9eY9hXDmjbxadFmizJiw4ajh/ybCqMIS4KMp8Xfp/o99fZ3ql1K+Mfh4FkqhV6ZbwmlKc0Mqn9QrLF1ylQRyg8QBTL9O2g1RC4ykjLgPFL2hsBXzsFXnKuTwy6FPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NWUn7gQZ; arc=fail smtp.client-ip=40.107.95.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NWUn7gQZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iso12l+4s8bQDiU9q+cf9N/POwYdr9pWEY24EgRpY/FWmAQHncDo/C8YIJ+GR4g0QohlENIRXmVAYHYTebcm8GvbAZtx6+RZkAOrlUePiDM8FkCaCJohXuS1MCJGPvbv6Dewp6vKNJOLcUa6E2UspQ62JPcmRsERF3InpKyV4t8ocpjv7tzYvJVhV1D/HuKuek6qlNnBbbaKE897VLsfK7LFyQRpJq5ycVLTKaMYf9JbVHe1WtCHebWtK0e1g26Q0NodSHgEAJN0MAS9HUD57sqTd4nQq127GYv1BsSDkh7nfHTS6rPxCU7ovt2ix/HnWt68WM+CCSebGnYywKm4lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2AkHX60WxZcjxMQOGJhw0bPH35mhGSiIxWd4ui/ss0=;
 b=Ca0aRtCqNYJ/EzhMqj5cBa3dT90KfI31vix26HJJnzEkVWPn28mFWapUyf0badrfScGOoKeH0wANqwXPJGju8v0U0ee7/KjHk9Pc4PDbJRpZQhZRj+tI0dmWHUM+fvemIE+FIRRcrkk0NvhdNTkGJHqM5Ozabk9wgiZ6CAXYtYZosEsshXgX8HChcU/X+aB7+PWJgAFq9T2QxUnlbge9c5CHSvW74QHNIduTIeqs4ZNVNvju8qU5hcPRXm4ViylggeLG3svkh24G4bPYpHBop2baf/HXIXjco7J1gnBkHVtlw/T93zoroyHscL9otnkSqLzqHQ6RGEF7YrlksMjJ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2AkHX60WxZcjxMQOGJhw0bPH35mhGSiIxWd4ui/ss0=;
 b=NWUn7gQZ9TAKnHiUMetm9qXui5XXeMBlpAkKl1GfYyGgjmLfnquMMLiX5bfhQU4C10emOT92/ofP0CA3yZoIljcszvf+t3i23muvdgOJzmj5GqNj10xMnsxNE1FlRIx7vtgnvh8hS8PffNm3Rmr6698icCmKpH5FPY8MeSqS/aw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CY5PR12MB6275.namprd12.prod.outlook.com (2603:10b6:930:20::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Mon, 10 Mar 2025 14:13:39 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 14:13:39 +0000
Message-ID: <921dbe7c-1079-461f-a9b6-49afa4c035f8@amd.com>
Date: Mon, 10 Mar 2025 19:43:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
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
 <20250228145636.GL5011@ziepe.ca>
 <BN9PR11MB52760B287D6878AD98A1D1598CC92@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <BN9PR11MB52760B287D6878AD98A1D1598CC92@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::33)
 To IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CY5PR12MB6275:EE_
X-MS-Office365-Filtering-Correlation-Id: 3347948c-21c5-4ba4-20be-08dd5fddc0f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Um8zaG9mRE5iNlNNWGkyVWVqTFRVRDN4U2JzdTYya1hLNVpmUDM4R2NucG9B?=
 =?utf-8?B?VHV6YngvVFZWaSswLzRwN2t6REdEZU5TUE9MSlZEd2dTUHdRbG0xN1pPWmpk?=
 =?utf-8?B?QUM2U2p5TUF5M2VMdFJkaGhCK2VzL0pvK29wMXpHbUd0WGFORzZyR1QrQ3Rs?=
 =?utf-8?B?ZVJneHE5RVQ5V1Bub2xnTnJKNDRsUnlRbnl1MXFzaWZkNlREbGcvZlpmOGFD?=
 =?utf-8?B?d2UyYjBWdWhsaHVyY0t2eGdnN0FNbTJybzRtRnZQR0c5KzBZazI5b1hvWFZm?=
 =?utf-8?B?UVNsR2E0R0krMnN5c0kwNFR2VC9MeG9wRnh3N2Zja282K3NONkFGSVZwcG1D?=
 =?utf-8?B?N0ZtYmFubkYyZVdjbWQyN1Z3TDROTzg4R2t0c0o5K042cG0wYVFvUzYySjdU?=
 =?utf-8?B?N2ozUTVrNEtHWURMMGtrNVM3dThJMGFkOTlSSkVLbW5nbnBieTVSYWw4WjRn?=
 =?utf-8?B?VDNpQmt4R1puNGFDRE1ZRDRFNUVmUzV2cjJpTnlNVDhNUnNqV3h0b2EyQkJL?=
 =?utf-8?B?cHJVWGRRb1IrYSsyMVArRjZJWEJMUVJFZmZIUU50WlFXS2h0WmR2UFJyTHdE?=
 =?utf-8?B?SlBqR0lUakZPbkx4d2JTU2w3YjhsQzNoMW14QWZ0c2J6WUVlNEVVeDBxbllU?=
 =?utf-8?B?bDVza3FXczVVTWtKUFJBcjNTMGpHU2ZZcVlWTWVMTGpPQ1kzM0ZRNEFpNE9p?=
 =?utf-8?B?cWI1SjNBbDVJeW85SGpPWlRZV1dwVStySkhzUm9sc3NrYWltdmVHOHZkWkM0?=
 =?utf-8?B?L3pqMHkvcXd1SE5ISVJUdkZtRk1HRXVzeXMrRGZjVG1FVGlkME9ZZVgzRUNh?=
 =?utf-8?B?TUdBSzJudThBdXZxdmlIYjZwTytEQzcvSE54SXZiaWR1WDZmNUxmNFh1bHFr?=
 =?utf-8?B?NGJVamRFUUE5Ukd1bXZ4dTFab2hhQ1ByWnBkYTVmSWlaQ1BwL05IQ3pxYU11?=
 =?utf-8?B?T3J6RW5KNnduY3FrVS9IRm56RzVQVW1xdllRcXBOVzNIbWZ6OGkzdXpEM1l3?=
 =?utf-8?B?QnE1NksyUFFuU1BCSnRrK0VJNU1JdkMzMDFwRGhXSFV1bVpleC9iR29hTHJK?=
 =?utf-8?B?WUN5Rmx0UjlYWTV5VFhTWWYvVjE3QXU0UnlFMUx5Y1JOVnpEa3pFYWRyZHp1?=
 =?utf-8?B?ZEl3ZnkvYU9MRjAxRWZqWDh1cEVnNkpvVjRUeHpZYldQLzFhVlEzcWJvMFlC?=
 =?utf-8?B?Wnl3TndkaVdMYUYzNmdwQWlRSDFmR090anhYYWk4dWJxeFkyRXBtdDVSUloz?=
 =?utf-8?B?bFJXQXk5Z3dEZXFHVlphdi9rQnVQYThmSUxZRW1JQjJ1a0kvc2JBQjN4eFJI?=
 =?utf-8?B?Tm9HT3VEY3RpM0w0Rzg3d2NOSkNlUjBhclJsRnpXNkZNSUFtK2pQSGxCM21l?=
 =?utf-8?B?b3B5SGhLSitHVDgwZjdwcnJ5Y1o3R0FvbER1UWQ0ZC8vaUNsSmxEdTFjakZ3?=
 =?utf-8?B?ZFpKb0YxNDE4MVY2bEZOV2pJZzR2cGpIUWVrR3MrTmxmZkNCMSs4ZUI3Z0RF?=
 =?utf-8?B?WC9WY2U0OXl2di81TnBHMjVYdUVjak9sK2syK0NVbUxkNzZUMmtNeThHUlhZ?=
 =?utf-8?B?YVllNDV5MXZha0hodlo0OTlPd0JTTkozKzYyQzJSQU40ekZvUEt1R0xhVkEy?=
 =?utf-8?B?TDNhS3RpSDJwQzlVSE01cTNIaU93RmhuTmVHREFWVFdic1BjS29HamlhZ3lX?=
 =?utf-8?B?NDMxQjNZRlMzSVJ6dDlUMlF1UkpJNW5xcnRVUTVEV1o2eUNydlo1ZittSjh6?=
 =?utf-8?B?RnB6UHdsTFpBT3dUK0xpVGlWVGxBNSt5a0lXbU9ncW5kbEFRYzNvSDZkaDRn?=
 =?utf-8?B?Rko0Ynp3M2hKbTVHSmJBMmxDZCszVURVSHdHczVkckZiUDlvUXAwODY4eEhV?=
 =?utf-8?Q?UkoD5qukGZGMA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azJCaHQ3UHUxdjR1am5CVDZDNlo4WEQ4N1J4aTNWY2U5bjduVHlFNHR3Tmdh?=
 =?utf-8?B?N1lyM0VsdnNRNm9OM0ZqR3dXUWJ5Q0pTeDdIQ2xocmYxVTV1RHNnaElwRW1y?=
 =?utf-8?B?cTBvYkZnNUE4d0Rhb1c0b1ozclNmZmVoUTJKcGZSdnF4a3M4N3RCSlVmZFY1?=
 =?utf-8?B?Z2tlUjBZSEwyR0wrRUdCRE9Bd0FvSkFNMzBtNVB2MS9saFAwQXdKeXUwcCtk?=
 =?utf-8?B?T3I3RjU4TlBZQmlYN25yK3NjeTdHSXJkZlUvbE15VHYzTW1lNHdVR1ZXVERE?=
 =?utf-8?B?Wlh3YVJWNDI0VG10Vkxtbnl2ZGs0WEpDbUczRGpDTThRdXRDVHRUZ1NNckFL?=
 =?utf-8?B?bXBmK2prY2NPVHVYR0RNeUVndDJDSVZiOG1KRnc1QXRSdllYTlNQazJYQXYv?=
 =?utf-8?B?VjBTN2ZpUk5OSkh0RHkwQWpGNGxvRU1WNFFpRmJITzJldnFJTlE1b0p3clJE?=
 =?utf-8?B?QmpjQS9XNXMreTNlMVhVdUh5ZlJVUUg3aXNJb29maHB5YTVqcTluWFgxdnNo?=
 =?utf-8?B?T2dTdjZFbXZsME5lTi9XV3VMTHlNZ0dzeXF0ZDRnV0V4eE05YjB4UjAwTlFv?=
 =?utf-8?B?S1pOVEt6L2FRKy83N3FOSDFjQzZCK3owelIvQWhpdUpidEsvZldZSU9yNjZM?=
 =?utf-8?B?MjZ4TUVPaXA2UGJ5TzdEcXVtYm9nM0hlVnk0elU3b2pUVFlQdys2eHJieGtW?=
 =?utf-8?B?TGU5U3VNcksrSG4yQ0RzbmxOclpQOC82Zk8xdlFqTFJmYURIeEk4eFZnVXg1?=
 =?utf-8?B?TFk3NzRnallqNmN6V2M5UUdYckhwem8xdXJ5bzkvUm1YbUR3WGliTjVmNGxS?=
 =?utf-8?B?bWxpOVdDT3ZzUlJRUzVoc3VqMkdzK2c2YUh0QXh6amtWWCtvMk1Oc2Q0RUZJ?=
 =?utf-8?B?cXVOaFRXaUsxZUNaOWJnclZLaVdtUTFMcEtEelN1YmRXN3BlVmdrcTdRZGJ1?=
 =?utf-8?B?dlNJMFI2d0t3eldJOXNoM2pxc0hLSEIxL3dIUDJEN1RSTXdxbVJqYld4WUNF?=
 =?utf-8?B?UDc0VlVKUWY4NTNzUW5jUXpLNkp5VFozS0g4VjA4QUplZmhvcGt3Qks4VHRI?=
 =?utf-8?B?cXdwSUtqS01lVUtSYVdYMHNKaEJRdVE3ZTduRGEzaG9pYWJTUjdXdWlIWDJp?=
 =?utf-8?B?QnhxUVVkbDVXbWVibWVCdG5adWlLcU55dXlPeWVFV3FTVWJVajN4SFhnbFpS?=
 =?utf-8?B?OVlSbU1tNjZmcU1GWTNLQmFtRmlFTEFJOWhqNXQvUHluMDBaNGRKMWRlczdx?=
 =?utf-8?B?K3YwZWJveFdHQ3E5cFJDdFZaMEZJSkVZbzMxZFN4RU5lUml3UFc1RjhsSXNQ?=
 =?utf-8?B?YmtWNTlCT1lXWFp0ME9KdnBoZzkxc2pzRlBSMW0va1REUUEvOHBRMGNFNjg1?=
 =?utf-8?B?WTJkcW15M3pReVJHMlBteitucWdwU3drckR6RSsvT0E2bTFDaEtYTzUwOGFt?=
 =?utf-8?B?STZSbHR3R0lFTmdJalBxaldOTFMrSnQ4RkJiWHlSeC9sUVZwMnBtL0tBaEpI?=
 =?utf-8?B?SUx6NWoxbXlPdDZDb2lLZGtydStHY0JPdG1hUzhKNHpkNWFEVkRFUCtON0cz?=
 =?utf-8?B?UFJsd3FiYzNiTzdVZVo4RXZ3ekRJU3dvREEybi8vZ1locW04Z20xQk1CM3Ra?=
 =?utf-8?B?dXRFazdaZmdVZzIzaEZPN2xRQkVkdU8wbnFzTXVyaHA1MFEyd1YyUXJHTEFS?=
 =?utf-8?B?dDhhZ0FuNTdJVjc2c2ZTYUo1YXpEemhjc0ZmZVdIcm5JaDFML2pQV1JYNEN6?=
 =?utf-8?B?WStIRzhnQUw1RTZIQjNJVEdvOFJ4VWxWdlhsZVRMREtieDNVS1VqL3JKUWRv?=
 =?utf-8?B?WjljbXIrMmIvTWNvYVZJNDhWVTg1djhhU2w0NEdIR3JWUkVLTDBRb0xBckdk?=
 =?utf-8?B?ZHlCdkd4TW5RN0F6NW0wY2R4SUVMWCtjMnE5SThrVVBod3ljS2VNTUp6a2Mr?=
 =?utf-8?B?MXN3WlRIQ3JqUHdERlpPemVicGI4Q0xyV0dxcTF1Z1l0dkdFeVNUbGlRRmdh?=
 =?utf-8?B?VlU0YThZMVhBM2VobWFTNHk4bEdod24reFU4QWdjQ3JLUlNnbEdGUlZxTU0w?=
 =?utf-8?B?Vjh2eEcrQXY2YmhQQk5GVzJDa3FrcFQ4ZDZjTHZ5Q0szcm42dHZxRUpUejJw?=
 =?utf-8?Q?1faxL2A6D8DaXrnSHibRSuEnI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3347948c-21c5-4ba4-20be-08dd5fddc0f7
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6043.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 14:13:39.5542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KT1cBDVHGzO74zuxhtJ8erC28Vv61ODw4KRYTl/MnWlXfM1NRfbyPowq6AHxVD998A4JkL/5bCWgouQIwfzOxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6275

Hi Kevin,


On 3/3/2025 8:25 AM, Tian, Kevin wrote:
>> From: Jason Gunthorpe <jgg@ziepe.ca>
>> Sent: Friday, February 28, 2025 10:57 PM
>>
>> On Thu, Feb 27, 2025 at 08:57:45PM +0530, Vasant Hegde wrote:
>>
>>>   - If HW has a enforcement required (like AMD SNP case where Secure ATS
>> is
>>> must), enable secure ATS. But do we need some way to inform core layer?
>> If yes,
>>> may be have an domain ops similar to def_domain_type() ?
>>
>> Yeah I think that is probably the best option, some kind of callback
>> to the drive to check if a platform forced secure ATS is neccessary.
>>
>> I assume if you need forced secure ATS then you also are disabling
>> IDENTITY and disabling PASID?
>>
> 
> Out of curiosity here. The host is untrusted in SNP case. What would
> happen if untrusted host disables secure ATS after SNP is enabled?

Once SNP is enabled, if host disabled Secure ATS for device , but keeps ATS ON,
then IOMMU will log ILLEGAL DTE Entry.

-Vasant

> Is the bit locked down once SNP is enabled?


