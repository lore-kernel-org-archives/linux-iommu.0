Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010048.outbound.protection.outlook.com [40.93.198.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9FA1DE3AD
	for <iommu@lists.linux.dev>; Tue, 21 Oct 2025 01:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761009980; cv=fail; b=oLsoy4Cs7ctDMWU6mqZo+TbOoVR6hp5zYQm0M/Im0zOYAlbbvsLhcOXg34At06QyCm9XiDRxzty87tG0MnWF8Jw+eSWkM/Nne4V9KQQbtKwWSzt3wnezPX/29iDyn0YCZ8k0h8clVahAU2UarfcJhJl7NLIK0G+xvtKsp4iHB8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761009980; c=relaxed/simple;
	bh=LuFNGPQJ0i+gUuE8QF6oXyG7cdUA8V3u9lhrpjJ89rU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gAGpEej8tD9JlC4ptaARAHJbpkrUVyNlWAGofDMXBSEqA7rd3RFaU/C/0pN2r2FyA8gy9kSTzTm1ySZ3Ed8fSL5x31SRadBFC5Jnl098ILv313Nz/mR6O0Xw7/Ut4MGGkqo1Yssj6L/xtK5Nn7IKPhBajfcvkzSw+Cwgip5bnvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BnNZ/GHH; arc=fail smtp.client-ip=40.93.198.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BnNZ/GHH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BXv/sr9m7zJsuvVMCs+Y2BQiHSxGgFg+uIZR9RSeSQDwUS8QbYVa0+f6LQApLrZo3fmxXuEG6d2E33ajXejuDgc16qu+bSYfKo1m2JIS138+3VuQf4cvBjwy6N86QSdRmmSMoPlmKs8rEB43+3OYCBin3bOeFB7WSbxOZnKbGiF2rX0OUy1XbVaOqXEEHttEtJ07LThCibbB83pKqQqa7JFwsHJz6kEBBhSZpavEL3p3JKqMOJ6YUOTGZhr2XiGLFvE/UTxMSyriJTTTXJSanGm99r7zK6/Urvg72nzynM6gyrZKQEI6fVSg3fyDYvImBy0/POhdA6bEPf+qNoFGdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUIZoGaU2YR///AcivnMczoIYiYOYx/HHRityJWR2kI=;
 b=RU082WX9ebl5G7o9DIfe5IXr9zDzr9Dyu9CE5TCDPJvVxwiX3ftz3VhyVeNMob2LkVpH1EpdTKjZok6gBqB8SkW+v2Kyrr6CDFCKsddmxoVgIHtQHfsUrOLBMfDL3XZu7MpFMnoyS7t4y2v7halcj+WqtuNsek+ADkoreeULAXc/+vYH5qZEpOLUTqo4/wjip9I644iExlD4X94lDW8wSOWmsRlU7XX0vNfzkOkJxxRFhFpgUWiSPk7nS602F/I1MTe3GBueROaZAAMhLtpwgqPwwTSjnv85wZ4hB8E1LDvZdCViMrJ9m9JiONN+kvJJ2S0qpymahsOGiFzEDLX6Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUIZoGaU2YR///AcivnMczoIYiYOYx/HHRityJWR2kI=;
 b=BnNZ/GHHVsIDmpDW71Qq2V9Jc2cuWDxtYVIchKxlm+xWnOgVVaS/WIJKfIQHZanzmDfd8pxTWF2D+vUaXvtQY7KMimsRDwMlMgRhQS4Zuk9MMBLJZDs4owfL64BwE5a+IYkaoW/XNEN+PXS5JSktcnNZ6uY6VoelM0mAVBbvXJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.16; Tue, 21 Oct 2025 01:26:14 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%6]) with mapi id 15.20.9228.014; Tue, 21 Oct 2025
 01:26:14 +0000
Message-ID: <41ed7ddc-58d4-4691-b3fc-1da2c7dc41bd@amd.com>
Date: Mon, 20 Oct 2025 20:26:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/15] iommu/amd: Refactor logic to program the host
 page table in DTE
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: nicolinc@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
 will@kernel.org, joro@8bytes.org, kevin.tian@intel.com, jsnitsel@redhat.com,
 vasant.hegde@amd.com, iommu@lists.linux.dev, santosh.shukla@amd.com,
 sairaj.arunkodilkar@amd.com, jon.grimm@amd.com, prashanthpra@google.com,
 wvw@google.com, wnliu@google.com, gptran@google.com, kpsingh@google.com,
 joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
References: <20251009235755.4497-1-suravee.suthikulpanit@amd.com>
 <20251009235755.4497-15-suravee.suthikulpanit@amd.com>
 <20251010230900.GO3901471@nvidia.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20251010230900.GO3901471@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0257.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::6) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|DS7PR12MB6165:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ca5945a-fa5b-432e-4da0-08de1040d355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OU4xMXRIR3gzZk5PMlM3MnE2S05RQTRqMis1WTFMbTNwa3B2R0hDQzhmcXU3?=
 =?utf-8?B?U25XM1JsSWkzR3V1MGZ5TlFsZzhNbGxDWS9KVHI3QnIwWjJwTU9zaFZlQTUz?=
 =?utf-8?B?bXdUZUhmd3dzOW5YL1RWNUp1QTEycERucGFFMGVQVVpBekQyUDBmcTFENEZB?=
 =?utf-8?B?SGtmK0dreDhFMUZ3bXFzeG5EbFhDMkVtekNWNVVVajFOU2MrY3VjbHdIcUJo?=
 =?utf-8?B?dU8ya1B6bVV0cVRsSUl0QXR6VW92cUovK21MU0NvcDZqbHhwb0dJRkdkM1VL?=
 =?utf-8?B?TFc5WUk1VlhEV1JGVG80Ykp1d29jK1FJcjI1MzBab00veG9iVFhwYUxKb2FK?=
 =?utf-8?B?Qm9UZ1pYc1NaRGRmc20wS0JIV0pQekU5VUUyeFU4RjErcEhEYnBCMWJWelJ4?=
 =?utf-8?B?WGlJc3RRSERSSFRvNlNkVitWbkxpODMvTzgyQ21CaVptUklvT2ZCWkpYbmdT?=
 =?utf-8?B?SWE4ZkYzdkpJdzNzemxTeWhGOGdZUEJvN0J2ZUZjclFEbmxNSzRzNmtLdTdW?=
 =?utf-8?B?NjNjVVRVYjcxZ2N0UlhWUjV4QkFrMXNwRkRnWVJockdOaThtYnBiT293T1k3?=
 =?utf-8?B?U0J1SkI2bEx0bkNqNDJWellPamQrT2c0U2V6K2c0RlFzbmpCZDlOdFkyODIx?=
 =?utf-8?B?YXkxOXR6OStCVGlPb2RGU3FpTVMyc21FbHhxZ0RiQmtOcHh2NEErcnhsdjB4?=
 =?utf-8?B?UGl4TEQrN2xrWlNEUlJiSUE4a01sSHRvMFQ2cGpPRTFEY09OTDBlSGliQXAy?=
 =?utf-8?B?d0ZQQUFIdnIzL3JMenNIRm1MSE1QZnUxOTgwK3NjT0w2QnlLZEdpVjRSQkZ1?=
 =?utf-8?B?ZDBHMWVOOTVPUUFwN2hvTE1oa3l5N09lWTZ5UUE5SlgrLytVWmx3VDRuSElw?=
 =?utf-8?B?cWVZbkt0WUZ3b1hNZWNHTnRjZWJmTTEzLzRUTnJaKyswem00Lys2NUVvTVFN?=
 =?utf-8?B?dUVVcmdhNHQ4UndMTHVYTzNBYW0zTkNua3lvZW9yOWpiT3F0UklGTWczL0k2?=
 =?utf-8?B?L2o2NGJUdEkxR1E0SVgvamM3YnFpRUdaSUZoZlpuS3FuQnVOTFJ1OXlDZk1M?=
 =?utf-8?B?aTE1NGdMeTFSQ3hqSCtMajBCbkFYbll4Sk1SSmVJNWh2SzZOZUxUeTI0NmRF?=
 =?utf-8?B?UGRsczdtWjNlTjRFMG14VHlWSm16U1gxSmNLcElBTHVXNGFxZWJMR3FjZFpp?=
 =?utf-8?B?TFNXVUNnM3F1b3FPTFhHZmlTQ1hMQ1UrSmpUSmprK1JDSG9jYVN3eWhEUmQ2?=
 =?utf-8?B?WTZuQ0ZJWExnV0d1TW4rbmRSaExLRWs3RE1VUHhIenZ1c0pxUE5VMU5qckxQ?=
 =?utf-8?B?dnczMkpSWG90RXdmd28rc3d3MVpDR1ZVL1ZLNXZGVjdza09pTktCZTNHWm1W?=
 =?utf-8?B?RzgrR0Y0OXBXbHg0Z2tBV0FBVEVjRTdTcnFIcEE4QnEzcFJUWkkvOG1raUg0?=
 =?utf-8?B?bHNRQ0M3Vi8zNE8wN3dqTWNqdU5Ma3lBdGtPSDE5VzN5QU1JMVJBZGVlbGxV?=
 =?utf-8?B?MUpuejVzOHZZNU1HOTZTbDJEZE1qYWZrZ0RZa3oxZm0rWXRjRVlQaGQ5SWV0?=
 =?utf-8?B?RUxBeFVxNGsxZmlJUTk2dWtjZnlQVHVVSWdtUG9MTXZTaEpJTlZQTkJNYksv?=
 =?utf-8?B?YU5LVHRWbEIwMDJWeXV4NWxIYnlTYXB3UmR2bXFlZi80MlcrK0o1bkthem1W?=
 =?utf-8?B?VXVldGV1ODVtL3ZzN1lFUUZlZG5PNVZLMXdVRU4rZXAxSmRVNW1VR2hkOFFY?=
 =?utf-8?B?NUdodTRGMlYyNE1kWkY1T3IwYys4TGxheW8vR2JheStPTUtGWVk5eFY0M1Vu?=
 =?utf-8?B?L29ZdmloVzlOZEJwZjV6Mkp3aS9EYW1QcHpISS9yeldSMnI3Ym5JUGZ2eElx?=
 =?utf-8?B?QTltaTc5cE5YR2V1YVZVYkxNZDF0bHBIcm5oam93d1BrV3JsTTk2RThEWTdU?=
 =?utf-8?Q?pvM7kBdwLhYmVvLq0qohD+bdy9Y1thHc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDYyREMvOUV0Y2RGa1NpQlRsZ1B0bTBjYWM2ekpRMmZLWVl3QnRjY0hXRE9M?=
 =?utf-8?B?QXZ0L1NORSszYi82RjRkMFdFNVNZZWM3OXVRMDVFMjVERllqY0tlb1Nqd3JN?=
 =?utf-8?B?Y0haaERHdnNwdWhzTU85OStESkNXZjlLTXFEQno0VGhqOHh3OTZ2ZjdrZXlM?=
 =?utf-8?B?MGMzeDZJL1dmamJmOGFQWWJLY0swR0hsY1Q1d2NVQUdlb0ZKMGtyRzFGS2pO?=
 =?utf-8?B?bGtxVWlXY0NqamJiU0lXNE1lK2VOTTM1ZzlNOXdtRmdJSkwxelc5K1gyNXYv?=
 =?utf-8?B?TDkyTU56bVpZZ1ZCVklMdmgwRWxJZHVwN3JXQmd5OHVkRXh4MjNxMnBlUExs?=
 =?utf-8?B?R05iVm43Y2dMdTRVVTUrL1p0WEtVUUpQcXVnMHZ3UVl5RzdLRWwyTlExOGdT?=
 =?utf-8?B?UzRoQVFlcXJkY2JxWDB3TVRsMjY5RWduRytlUFZ2U3hHbG9BNmNTdmVNcE1w?=
 =?utf-8?B?S3dJTUJpWUx3L29jQmF6SXRhS01ISkZXVCtyQ0RyWDhFVEd5amR0MFI2Wkx6?=
 =?utf-8?B?dmszWnJkSDMvYlFFS3F3QXV4RjlmV2dVZDIzMGtGVjZoR003UXR5OGxxWmlr?=
 =?utf-8?B?czdmcFU0SnRXajhzNHdjMmdRQXhUSTBPTTFkODJld2MxMHNmaDlrYkNWY3R3?=
 =?utf-8?B?L2FYUEpjcEpFdHNWN2hsVzVndG5OS1YrV1B1dG5SekxpMXFNTHlkTlVuVzE3?=
 =?utf-8?B?NnZiSWE3UlIwK2JINW1Mc2pUak03Z2ZlZmk2amNTQjJmVnJKQ0p0MmsvTTR6?=
 =?utf-8?B?UGhvK0dac3BJTjRxMU0xZGphUTB4bHV3U1p1TTRESm04b1cvVWJXYkVlTXdB?=
 =?utf-8?B?dXVQb1JXWFcyaitzdnlOZmRUbUZ4c1RybTNaemFiZlhZLzlPTkxEU3pwM2pZ?=
 =?utf-8?B?Ym1HczFKVU85ajJrbGxlMWFQM0tvQm0wZjBFdjNhQ2lSeGw3dDZRUW1nOHRX?=
 =?utf-8?B?WWJZbFhsSTVveEExY21za2c5Vi91ZXMwcmRkT1BmRGRzaCt5V3hHNU0vWHlq?=
 =?utf-8?B?ZHFKeWhoTGdMK24rM1hKdGNuWXRlbkM2MnBpR0J3ZkdKL3RUMng1ek9LR0hx?=
 =?utf-8?B?cWVuNkJuei83cmhESXFjNlV3NTRnMDJHTk8xYVY2cHc5L2MrV2loYktsWVVk?=
 =?utf-8?B?ZndiQWpVZUpOZzVGVTJDRFFza3E2b3FiY2liU1N4czZNMVFVYml0MG1UMFNU?=
 =?utf-8?B?RGd1bzNVMFJhUTBJd1hBSVNkVERDSEYzS0R2bjJnWEhOa1EreXFOTWo4ZHdl?=
 =?utf-8?B?TzBKdGNNbko3MVBZcGVKUUppZ3hqV0tDV0k0RlR4Slp5WDJaRFpKMHlzTXEw?=
 =?utf-8?B?MFZwckx5L0xHaGp6emlpTDhkenlSN0pQSzFGd20vVU5BM2N4ZDJ3TDVZbldj?=
 =?utf-8?B?b1FhSzJicnBwUFk2ZUl0ZVVqbDJyZ0RtTnJ1TUF3SjE5cFNac3hjL2tPOEIy?=
 =?utf-8?B?alZ1TzJpYTF0cFRYK0FtNlNFbi9xWUc1YitjdmpwOFgxbGJLdEExNTNFbFZq?=
 =?utf-8?B?MmRKeGYrY1Jvb3pCMXY1KzdEQ0NoeWUvenhoZHRCTnlwaEQ4UC9uZkxsS1V1?=
 =?utf-8?B?dnV6SVc2UkpvYmVlUitqT0ZXRGdHcjJDQXhLVmVCdktrUGJ2b1BiMzZoYmFw?=
 =?utf-8?B?dFYrRlNDT1hIckNZdUF1UC9GQlh6bEhxcXl3TnQrTysxM2RXaXIyeEdSWkRT?=
 =?utf-8?B?Uzl6djV0eGNkK3p2S1ZucjVkRGY1NGsrVHFVV1JJYndueHlFU1RZOXB5T3lu?=
 =?utf-8?B?R2krQlRyc0E5V2RXMTlZYVI2aTA5UUFPSnpadmk5T2o5YnNCckxZNExDWTAx?=
 =?utf-8?B?dXIvRUtvQnpMbWVpMHVSZENCY3ZxcmlzOHJ1WWdwSTFIUXBzd2loODNoM2RE?=
 =?utf-8?B?ZDZocDZNWXJRNTZWTGZXY1ErNUJHZkh6SXIramlnbDlwTEo3b3Q2cjRPcllP?=
 =?utf-8?B?NTVOVlVIL3dBRWFHSkQ2MFpDQUlhMnY3UUJRMWhWcjlHVUI3N1BHUTVsUk9q?=
 =?utf-8?B?OUxkVG1EOUVpYlIyNHJQVG9VbU5GQ3BmTGRyQ3oxU0dZN0ROdTN3SFN0Tlps?=
 =?utf-8?B?MGhlTDJHTVczekxVTGRDVTV1KzZ1MWo2a3l0cmhzeGpIelRvM1NwTkh3NXhY?=
 =?utf-8?Q?02wg3r9cQqusXpjmFaYXVhXPY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca5945a-fa5b-432e-4da0-08de1040d355
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 01:26:14.5094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QcxfCwvdQ2r3BYAiLztw6uZEYkjRYCM6XMmkTdCGc6JG+q4ygh61ZEUc1+drIGdiNfog1dMVAmzECWo2ckcgXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6165



On 10/10/2025 6:09 PM, Jason Gunthorpe wrote:
> On Thu, Oct 09, 2025 at 11:57:54PM +0000, Suravee Suthikulpanit wrote:
>> ...
>> @@ -2061,36 +2087,14 @@ static void set_dte_entry(struct amd_iommu *iommu,
>>   
>>   	amd_iommu_make_clear_dte(dev_data, &new);
>>   
>> -	if (domain->iop.mode != PAGE_MODE_NONE)
>> -		new.data[0] |= iommu_virt_to_phys(domain->iop.root);
>> -
>> -	new.data[0] |= (domain->iop.mode & DEV_ENTRY_MODE_MASK)
>> -		    << DEV_ENTRY_MODE_SHIFT;
>> -
>> -	new.data[0] |= DTE_FLAG_IR | DTE_FLAG_IW;
>> +	old_domid = READ_ONCE(dte->data[1]) & DTE_DOMID_MASK;
>>   
>> -	/*
>> -	 * When SNP is enabled, we can only support TV=1 with non-zero domain ID.
>> -	 * This is prevented by the SNP-enable and IOMMU_DOMAIN_IDENTITY check in
>> -	 * do_iommu_domain_alloc().
>> -	 */
>> -	WARN_ON(amd_iommu_snp_en && (domid == 0));
>> -	new.data[0] |= DTE_FLAG_TV;
>> +	set_dte_v1(dev_data, domain, domid, &new);
>> +	set_dte_gcr3_table(iommu, dev_data, &new);
> 
> This seems weird, I would expect this to be written:
> 
> if (gcr3_info && gcr3_info->gcr3_tbl)
> 	set_dte_gcr3_table(iommu, dev_data, &new);
> else
> 	set_dte_v1(dev_data, domain, domid, &new);
> 
> It is nonsense to call both gcr3 and v1 in this function that does not
> setup two stages.
> 
> So, I'd just put this code in both the v1 and gcr3 functions:
> 
>   +	new->data[0] |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_TV;
>   +	if (dev_data->ats_enabled)
>   +		new->data[1] |= DTE_FLAG_IOTLB;
> 
> (does IR/IW apply to GCR3?)

IR/IW apply to both host and GCR3 tables. I'll add comment to the V4.

> And then WARN_ON(domain->iop.mode != PAGE_MODE_NONE) as it should be
> illegal to call set_dte_v1() on a domain that is not a v1 domain.

I'll rework the logic in the set_dte_entry() as you suggested in V4.

Thanks,
Suravee

> But this is overall the right idea and direction.
> 
> Jason

