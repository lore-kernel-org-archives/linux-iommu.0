Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012012.outbound.protection.outlook.com [52.101.48.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852F624886F
	for <iommu@lists.linux.dev>; Sat,  8 Nov 2025 17:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762622754; cv=fail; b=Ic1aij2NbZegozoeO2f2xgI2tZNULD9MHG2mOOUwtQ04zpUfv57SRkQrOQxScJiSAA9rATa7qZyCPFqCWMA1KOH4Y92H2mny0Ph5nw/lmw017ah/KepMssVZpmC7+QaYi9F8o+L5LSQtagST55w7xZsZ8GpCBip+0OiRYEach88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762622754; c=relaxed/simple;
	bh=Rf/vJ3ZIKHkB/cDh4NOOyLPiIE2XZTl2fY7bpRQNgt4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jHb42r4r/N5ora1C/gWLO8N2RJdtW7XvrCZKM2spUfg0X6JRJU04Ojt3o/R27NeuKpLmq219hFywEDKhecrel8VeUFYyfzSJ7J5ktchBYIYuljLPm5fnIfEctvnghAPJz72ocrhuiYQ1VEtLCyWaFX/2g9BZPwmRg+axTM///dY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eK2Ed4Je; arc=fail smtp.client-ip=52.101.48.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eK2Ed4Je"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c7czVqsD7qL9G1N4vYB66f2FPCk/QrgjgLLTYi37TSGc7fulwV9zXeYh3vj9Jks8bbsrkdyPnW0IWWNQyVkmreBBeqy/Smuc5nU9lJSR5CsG/OraWD5ZOadJgi4ig5exdAGmRMpxTtGXZfDG0fpP6RH5FhsFRwGmrXHXhLLMtuKS/5Ds4qEcKE1eb74jSZIL9TLhUxAa92Nc3oXJQFUTbm6nSHnCHnKB83S0G3atm+hbzHhjSD5SVoVZ1cnQxmDXCKeyPrEtK8tDXYPGh4EEmpo4o57FlBRDlQMrQHScGPOPoGRjgdLgWuL02KGNh3cjpEjx2UU6SDgPuzMgKAwD8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RONyRmgnXm1apyzG+NkARlQdZcHNnnFZBnSb0C17iU=;
 b=U/6hI+59nUeHruTrqMs3TSVWVMjf+qEf+rra9aniYcQjl2G4Z/oHsxGvlMEF9tIDjYdL8+ladL9Tr8c0n7FoQ9k42AObUWNijRJsN3JVRnH6pMjAEKTX9GqwcYC21vHYbVuJ7RDO5PwTqkWCG4HWC6U6dGd2OYh+31xEZAZbqD8zql/7viLhwuJgcQs15EValkrPK6sr5CGvn/8O/XavBYYe81cC6fuVnY0x8hzmR1P9NAmWuNZF8zXl5cuyYD1sC2EJ2raAkaGJmWOzuxDLn9Bt9ulq3u2uYyE7KC8wHOhFm+xBO33oSYZB0HfoDSMW/skvWaD7t+8Z8vyH0tl5Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RONyRmgnXm1apyzG+NkARlQdZcHNnnFZBnSb0C17iU=;
 b=eK2Ed4JelpLo0AkN6pzVkRdPnSQuhSqpGRRYZfYRW8vl8jGyfdBDzDeH0zs5S+IMudlB1SrYk6hP0rw6TUyKOlM22CISsszpZleNzNvPzm+kfjW1+x4c1mbrFhMC5tCaTP7YMBaIY0G2A/l6RGxvAmrNHJDS1Y6EVrM4C8C+jgE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SJ0PR12MB6992.namprd12.prod.outlook.com (2603:10b6:a03:483::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Sat, 8 Nov
 2025 17:25:47 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.9298.012; Sat, 8 Nov 2025
 17:25:47 +0000
Message-ID: <94e36cb5-0f30-47fd-8f8d-b2babdb40aed@amd.com>
Date: Sat, 8 Nov 2025 22:54:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/16] iommu/amd: Make amd_iommu_pdom_id_alloc()
 non-static
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, jgg@nvidia.com,
 nicolinc@nvidia.com
Cc: linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
 joro@8bytes.org, kevin.tian@intel.com, jsnitsel@redhat.com,
 iommu@lists.linux.dev, santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
 jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
 wnliu@google.com, gptran@google.com, kpsingh@google.com,
 joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
References: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
 <20251021014324.5837-3-suravee.suthikulpanit@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20251021014324.5837-3-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0109.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::8) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SJ0PR12MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: 01ae7292-baf7-459b-e603-08de1eebda9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmhxNlI2TUhkU3lrMitBVXFsMFk3TXVQZm10MW5jQ3lDMFNhR25RWXFxbEc4?=
 =?utf-8?B?WGVsRWsyek9ISU1PU3cyRkZJc1h5YTZJcGtLelNDc1ZWNmMxZjI5VkhMc0p2?=
 =?utf-8?B?ZVJzMkJOcGhTNzZyY1VWTnByVnNZVVJ6MEZlejNHbEhxTnpjaWZWRWlXeS9I?=
 =?utf-8?B?MjlFTUxzTjR5SVRCNUZGa0thbjdGa2czRUVxZ1QyOG11dGNwbjRVV21sMmc5?=
 =?utf-8?B?VS9rclpycmdXNEFpUUlZYi95VUV2RzNJd05hYUpDQkw5akkvWGdDazU2bnZT?=
 =?utf-8?B?L2FlSjY5ejF5aUFqbzFSYXFlRXdyN3RJd2RGemVSQXlueERHc2NXb2x0ckZz?=
 =?utf-8?B?SzZLNk00VC9UWVFIbTh5TXVPdmJ4NHF5MnFwTFMrdGY1RkxrQVZiNW96YitO?=
 =?utf-8?B?bkE5d1p4aG5sMDh5WTd6N0lYdjBYOEtZM1Z5ckQ5TUtzanNQNjVTUGU0MnZ1?=
 =?utf-8?B?cmpaT3c0ZHVQZEtJalFHKzdsbnJWTG8yOXAra0w0NFZoOUhucXNJWHVnTDdh?=
 =?utf-8?B?NkdRRHZReEY1dUdqRHEzQ2VzR2tjRytIVnpnZDFSQ1U4NVZZNlFGcHBIK3gy?=
 =?utf-8?B?cEJkYVJyaEptUi9FVW94eTI0bnYwZVZ2Nm9QM2JtMVhwSFVNbkpDSVJ4di9y?=
 =?utf-8?B?bmllY0t6NXpYUW4vVVQ5NThLZ1grTVMxN3lYcnhUV0Yzc09ZdCtqdjk1MUsx?=
 =?utf-8?B?ZTdTOTZ2WjRYTWxNM2MweWlpUzlpU1JZVnBJRDUveEtjVVhVSWpzM2xPR0Jp?=
 =?utf-8?B?T2c4WkM3ZUk2Q0FidEZwTE1NVUkvenBNNXJMYmxEbHBjdnNpNG82NmJLK0xh?=
 =?utf-8?B?OEJlSml2SUlQSUVuYnluOFVFcWZYLzBBNVNPVGhiWmJNWTZ5aWxZRStQOFFC?=
 =?utf-8?B?NEgrUVR5MFpWU1o4NTRDNlp5c0Z3VFZ5b2VKYmhHRGtmazNjUjBqNmtWNk9x?=
 =?utf-8?B?UE1HcDg4K0JGL0c4bmVuandQb1hqYnV1eGpGMlJrcllyQkpDamM5NkVWSXlE?=
 =?utf-8?B?d3kxTGdPQkZ0N05wcjN1QVdTYk5nampybDZSblBIUUE1WXFtdjFYK05oL3Jq?=
 =?utf-8?B?aEgxRmI2SDdJdVRRaVB4UHNiTC9ITnVGaVo5Vnk3QkhwM1A5TGk2eUt2dllL?=
 =?utf-8?B?a1RtV0E3Sy9nMmxWV2ttZEJTOVBCcEJ3VHExYW9xZGtGMVlzdUhSaVRzZXdZ?=
 =?utf-8?B?ZnMrVVMwdzZEcFdxQW1tWXNwN2RacEcvbDdSK2RYbTRZWGRPdlE3REZhSk8x?=
 =?utf-8?B?ai8rclJLM1ZQaGE3SnBmUFZUUGtBdmNSQThOdnhQSnJsZWVvYnhrMEEzblVt?=
 =?utf-8?B?Q2dpTmI4dm0wUm5SS0N1eGhIb3BLT2FkYVgzQlJETyt3RVJ0T1NRZERVaVM4?=
 =?utf-8?B?OHpUMVFoS1FQRWNwZGF2cGJaLy9sTXU2YmticXpCTUM0TTJ6K2NpbzBpYi9v?=
 =?utf-8?B?MDZPdHByL3hXbVppWXBKaFR6QmthQUNob1V3VkZjTUcydk9aMVo5TFhXaWpE?=
 =?utf-8?B?Q1E4R3hndEtIbHpvSU01TnRyTWVKcE44MDVoeHljMllqMDdGdSt4L2tRWVI5?=
 =?utf-8?B?WGhGdGJBMGVJeDAyL0hkWUx3ZFpPdktZVnk5aFJVUTl5TGxVKzF3YjFsdnFG?=
 =?utf-8?B?cnVJL05JdDE5dFl2Nm9KckZjc09vMkNib0FUTzliWlJuZkErOXlabTROcG5n?=
 =?utf-8?B?OVJJcUhlYTZkckJDQUJ0Y3R0N2ZXczFmTTQzR1hxQkkya1pkc2gvT013NHpO?=
 =?utf-8?B?V2s2dm50WkhLYlV3R1RPZ25QR1lUNTMwL0NTOTdpTTB2b2lhcm9kbmtDV1hx?=
 =?utf-8?B?N1R5UU56YXZUZlZoUHJHaE9rK3pkZVJ0eTJTS3orMDJnU2lsV1Fya1dNdHNO?=
 =?utf-8?B?WlgvS0dseW1ac3JmWHFxTE5KOGkrQ0VDeGFNd3VpMEZXZlYzWGxDWWdCWko0?=
 =?utf-8?Q?1AVY3tGS6jd2pUCvjFKdF2RUmdp952MY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkgzRFJqRUsrRDdqRkovejBUa0c1QXIwMVpqSUM0eGZ0cXVleFppOVg2SWtQ?=
 =?utf-8?B?b0s3ZDJSM0dzVC9RTjFYZFZPOFR5NzRYYndwQ1hvR09FeWd3bkhxRVBwQ2R0?=
 =?utf-8?B?aWlHdkhyei80bE1sM3FHQnZYSmFMSnhsNzBDbFoyZ29XdVJxTnl5L25tQS82?=
 =?utf-8?B?TmdwcEd4bUlqdEJ0RFlIbnFVMUJVckxnRFo5eVZHTjhpS3h1R2hqQWpxUlov?=
 =?utf-8?B?blltekRDVEV4dXI1Uk85Q2c2THZvR0gvRXlCdkFOeFljbzJlOXVEUTlOaWZE?=
 =?utf-8?B?SUhsQU85MmFGNnFRYjY0OHVTZVlVRUp3UDVGeEtpV0MralRXNUtjVHhZYzdX?=
 =?utf-8?B?a1J6aFdUZ0JCRXIvazlOMmpXS2pBT0RZazZUenVpaU5NNzBNRXZYRXBETGxF?=
 =?utf-8?B?a3RTVWo0V0VJZHJaT3NMSW4ycVVsaVdHYnBzRXBNWExyVnZOT1g2UllJU3VB?=
 =?utf-8?B?UE9LR0hhZG9YYjRlZmZjVE1ud0tEOXhOZmJHM2NhOWZacFRyWGVidVd6cVhB?=
 =?utf-8?B?VXFsZFF5VlY3eWVhSFV6UXhqK0l6NmRuYjhMMXhoQng5RWZNWEZsczlYWWVI?=
 =?utf-8?B?MWV4ZDBDblcwOW8wcE5jQ2ptN0lhVGZqSTJaN3M3bnRJcUlVZVMreVlUTkU1?=
 =?utf-8?B?K1F3azhxUmUwL2tIQUxxNm5abFF5dTZ3RWJRdDJzQjROVkJyVTlSR2E2RVg5?=
 =?utf-8?B?WG9UTWR0d2x2WHJQanRsNmZOSDluTm1sdmRzRXFFTnk4KzRLaiswZzlBYSs0?=
 =?utf-8?B?K0c4YThuMnlJMkRCd05IRE44YjZQdGtNbnVKWkxjRVdUYmVZTjdEeWlOMU13?=
 =?utf-8?B?ZG5JR041cExZTjlVY2lzTG4wb211a29XTFZHcnlGR0I2K3dZcVljUlBqTGs5?=
 =?utf-8?B?dnJESzMxQkpQM0plbWdLR1V4YlhXQXBHdFpOT0IzYU53d09rZStCRlI0V0ZO?=
 =?utf-8?B?b3prdk9ERTArMlVEMXlJMHJDREx5QWlHNUxhTUt4b1FTMFl2UjFkcEVhcDJ0?=
 =?utf-8?B?UXA5Qy84dlM3SWlXQUlMZ2NaVDhLOXduNU1hRXZ0MkJtOUhmaGFIbDRmQkpU?=
 =?utf-8?B?akxSK29wYWJZT2JWci80MHlPeUtzY0hZVDA5WXNwU2JESktXUmlWVk4rK0lY?=
 =?utf-8?B?dHl1NCtDajdYNnJGNzFiRWR2Wm9XVmR3WnZEbDJwalBoR0Y3OG03UkZLVENo?=
 =?utf-8?B?Z0xPM2dKUG85MS90alN0cUM5NmJKRHdyeFVXcktYZDdSZTJhbmh6NHVFb094?=
 =?utf-8?B?cGd6ckdpSWxQN2hhbW5UcGNRR2lkSmZJV2Q3V01IaG9VVFpVL2x6MjgyMU9B?=
 =?utf-8?B?NTZReFNaaDE0L0hZYmRzNjZCTTk2Y2pqNjM3cFB3TmRHMW5Sa1lVS0dKWWl4?=
 =?utf-8?B?RSs5S3hKeG9tWkFRdlc1aTJqUXNOYVVaYU51UFE5M3RkbW1jYUcxQVUySExl?=
 =?utf-8?B?UmxWOXlxV1JCdmFjTFg2QXByTXFVM3llWWVCQy9McFNOQnFibVZkbExrU0dn?=
 =?utf-8?B?QUdHbVpIS2cvcmF3WUpIQStjNEJIUnRhNkUvUVltYVZhclVPRUVDbnZ5bEFD?=
 =?utf-8?B?UzdPZ25OM2hxTm9EMnhwbzdZclRIMzg2WlVBempGakx1am95cUZGQWdLbExL?=
 =?utf-8?B?dHVhYUt2K0QxR1FWV1JSa283citDc0E5Um5uWHp3WW1aQklRUmpuNHMvYzE3?=
 =?utf-8?B?NWN4bUwvRy81M291RXJWLy9LVzdqUlhQRVJ2NG1vWFY0Yk5PWHY3c2pUdWlz?=
 =?utf-8?B?dXZYcWhWOHAxaERlQU51M3Z2cTh5Vk9RSnFXMExvZGlPUUNlR3NhRGkzRHNR?=
 =?utf-8?B?YTgyWDFnNkpKdnVGUVROYnNQbGlxK2lXeDVZUytVVUlnajBvdTFBRjNoVENS?=
 =?utf-8?B?ellRZGF0bWN4akJHVDFNNG94ZnVKNTh1WGl6UFZ5VnVhMTBWUFlSWFZ4eW5R?=
 =?utf-8?B?bXdzcHIyWTVrczVGS3Y2ZTB0cnRnamVSaWcwM0g1ekhGYU13QjdkMFJTaFlJ?=
 =?utf-8?B?VzhGWTEvU3c4Um95OFRKeitUa1BlWDQ5OWhZd3Npai83VTltZXZ2dCtsT0p1?=
 =?utf-8?B?dk92YTJxNjduSjAwcGl3QlRSRVYzRDF0WkhLZEZBRWppQWYxZ1IwSEx1NHAw?=
 =?utf-8?Q?0wKSTeNyF2XqcQzV8k7o+GmYm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ae7292-baf7-459b-e603-08de1eebda9c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 17:25:47.0943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eZjlF+81e69Xv0KfHUNgHGhA7GfZosFQi+NAy0VNvqTkTmPwHDSt1tHKiFOSsxeaGiIJTUdhcBEYsr4hZI9P0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6992



On 10/21/2025 7:13 AM, Suravee Suthikulpanit wrote:
> This will be reused in a new iommufd.c file for nested translation.

s/iommufd.c/nested.c/ -OR- something like "it will be used in nested translation
support".

Ditto for next few patches.

> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

> ---
>  drivers/iommu/amd/amd_iommu.h | 1 +
>  drivers/iommu/amd/iommu.c     | 8 ++++----
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index 9b4b589a54b5..6ea549816a1f 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -26,6 +26,7 @@ void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid);
>  void iommu_feature_enable(struct amd_iommu *iommu, u8 bit);
>  void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu,
>  				  gfp_t gfp, size_t size);
> +int amd_iommu_pdom_id_alloc(void);
>  
>  #ifdef CONFIG_AMD_IOMMU_DEBUGFS
>  void amd_iommu_debugfs_setup(void);
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index a9b17d31a969..78b3e5485006 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -1818,7 +1818,7 @@ int amd_iommu_complete_ppr(struct device *dev, u32 pasid, int status, int tag)
>   *
>   ****************************************************************************/
>  
> -static int pdom_id_alloc(void)
> +int amd_iommu_pdom_id_alloc(void)
>  {
>  	return ida_alloc_range(&pdom_ids, 1, MAX_DOMAIN_ID - 1, GFP_ATOMIC);
>  }
> @@ -1906,7 +1906,7 @@ static int setup_gcr3_table(struct gcr3_tbl_info *gcr3_info,
>  		return -EBUSY;
>  
>  	/* Allocate per device domain ID */
> -	domid = pdom_id_alloc();
> +	domid = amd_iommu_pdom_id_alloc();
>  	if (domid <= 0)
>  		return -ENOSPC;
>  	gcr3_info->domid = domid;
> @@ -2489,7 +2489,7 @@ struct protection_domain *protection_domain_alloc(void)
>  	if (!domain)
>  		return NULL;
>  
> -	domid = pdom_id_alloc();
> +	domid = amd_iommu_pdom_id_alloc();
>  	if (domid <= 0) {
>  		kfree(domain);
>  		return NULL;
> @@ -2681,7 +2681,7 @@ void amd_iommu_init_identity_domain(void)
>  	domain->ops = &identity_domain_ops;
>  	domain->owner = &amd_iommu_ops;
>  
> -	identity_domain.id = pdom_id_alloc();
> +	identity_domain.id = amd_iommu_pdom_id_alloc();
>  
>  	protection_domain_init(&identity_domain);
>  }

