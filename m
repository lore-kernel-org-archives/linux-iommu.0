Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A6B148FF3
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 08:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729673263; cv=fail; b=iJImr4hq8NN/BmlEzUm2os4N1EFVl/Fua7931obO2LH02u0luD7Vz96t/ORlMNAkkplAh/G/l+F+OqR+KBjMrtLBiyjNrWz5U7xIQ38AwEkHkzHsSGfVqEafcrqwXUQag0AA56QWJ0i+drpMFoDfMTos4WnC5taEtQPlyoFSrQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729673263; c=relaxed/simple;
	bh=isEtDFtSyijAhtDl9sdo8i1Rdkm8Q9OVkobV5JNxbgw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N1O2O5sPPLGrwwwIjUGJo560aLyohbYIqcy3cmAl06FxquaOagj88bDy1g4KKoDaeG8xh+9tZqTWt1SPbmOKQoai0g+khmhwYUFPcOM+B9FvEW6ynj+jF2houRwqVuNxzseDYx7MsrDVmmbUDfRhaPOekKAoYNG9clcV4yb4EEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kqs1or+R; arc=fail smtp.client-ip=40.107.244.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kqs1or+R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNzVYXk0bopz8yneOeUZUt4iwfy0vYoibG12pBVU4i8MhTAs/gm2Siq/A7WQyFsClWxy3EN8Wpuj4vXWBFyfCV5MMd1Gofr114iWxsHeeXo4pRcFmrrkQSVgMiXrOSpjCcQIoXZPNvhVKYYJwNBYaF+cw1UQXlU9xTXystQuRA8EiJmyaZBjGa2Zl0Wdi3FWa4pi3TOCPxrMyKH9oHgn+Nh+lhvodPwsmqG2IN8q6RjQ1vpAY1yIwF3yG+RbdSP3rJ8TR8anBjCfDjGxFJvR+xIfoAkORD0Jz3K85Q0tiZcrJcoJBZMngRMCM1D7oI8VhlI1oSn4IlNLX4kDMGQnCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kP5etyLRLKiIGkxfyd0Bpg7080wW5nKvY1Ihr9DgH8Y=;
 b=Kk/ymKvVpkzhzb35/jHGd9KY9rmWCfBuYVI+ZsLQAHU3guu20WpNQK4sWCri4uce1uh0Bc7RGRK7+ZHqSu52S+YkNuWIW3OKylsQQZOl60TQCXdvsVRHiq/XGGrXSLemGzUH6G7dRmUozquIpSep+pdttYJafflsvj9h+7F8wxuUFS+CY4/l4LnVfAgIRkON4t/GF1NUJTgH1S0MZnVp+nuTmJqt1tp64CZd4wmCWVZaKTmvLrO6w75mc4mSOQjuRiIOYCJ7ZQzylzytXQkh9brHguNfy9LV43ZwIoWheV6GIRkO/JTlLs8GMTeW/g2W3EcXz4frY0ETFGBq5T/NOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kP5etyLRLKiIGkxfyd0Bpg7080wW5nKvY1Ihr9DgH8Y=;
 b=kqs1or+RHGa/bHz7CqrxQcA4g0lMveJk1FGmX4NCdnT8Fzr8qOEonM/dEMkEbzBxeq8aRkXlds33uBSgCKv2mUz5rjmRqM+wAyD9ehraJe4G3ExDDZtZpCLQWIq1SZpCEuQ2S79j/plLJ2d78UzCH+R7oAkSWyuml20f96EZqrA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SA1PR12MB7295.namprd12.prod.outlook.com (2603:10b6:806:2b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 08:47:36 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 08:47:36 +0000
Message-ID: <2d201519-830b-436d-8284-81caaa9df8c6@amd.com>
Date: Wed, 23 Oct 2024 14:17:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/12] iommu/amd: Enhance amd_iommu_domain_alloc_user()
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "joro@8bytes.org" <joro@8bytes.org>
Cc: "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 "jgg@ziepe.ca" <jgg@ziepe.ca>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
 "jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>
References: <20241017140137.6028-1-vasant.hegde@amd.com>
 <20241017140137.6028-10-vasant.hegde@amd.com>
 <BN9PR11MB527625CF817D73A8971AE9988C4C2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <BN9PR11MB527625CF817D73A8971AE9988C4C2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0194.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::21) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SA1PR12MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: 0657b7f3-6e43-4ccb-4c2d-08dcf33f57c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nktoanp3WGtsOVNNRngzQUhTNFl1SzZxUlRvaXJ1MmIvaG0yQUFCY3BjSWUr?=
 =?utf-8?B?NTdhaVR2OGVlQXF0czhud1EyakxEN3JpdUZXUU5idEcwN2lRODRMcEtlRmR5?=
 =?utf-8?B?M3dTcXFnVkNGdDVwY0tXNTczY0VydXJ0K3ZHeXlUYUNHelcrY2ZHdlE4VjB4?=
 =?utf-8?B?S0IxQUFMYzdFeWxyTUNPUnAvQUw0d2FLd2psRStJL1RIc01xRkd0aVhWSVRh?=
 =?utf-8?B?U053eWRCVThPZFhzV0hZL3dtR0dpKzQ5OWpodDZtSG1meGdCRnRkSi9UVTA1?=
 =?utf-8?B?MzV4dkloMTVTYXlSMDBlS2JlTTRJQ3JYVVNTT29Ib1dxRXJjWEdzdktKN3Jp?=
 =?utf-8?B?ZlhKakNNVnZDRTM5aDkydy8rWEwvSGo2THd5eE5ROG1tZnhUWm5KRE9NSHY2?=
 =?utf-8?B?S2tjMVJSUW96UGFvcFoxc05iaE5nbHhDVHN4Q08yeFRPUTgydHB1bkIvZHAx?=
 =?utf-8?B?NUQrc0tpbncvOWRVUURmcEp2WG5QSEx6SXhVM0ZOWFRFZWowcUhWNU1WTjI5?=
 =?utf-8?B?YkFacUtubk9vNVdFK2YzVUZGc0ZoZnJwVDV4K3ZkZFRnTFZMN0l2bURUbjFM?=
 =?utf-8?B?aUU4Ly9nR1NKWWhCMEFzOVUyTWw4bFlBR0tJSVl6bWJuL2pOU291K1BPUlk5?=
 =?utf-8?B?WjVIMklrN2gvRU5Gbzl5K3k2WWZINGVOUHFHRDBIN1Q1cWNVQU5iMVh0SHhO?=
 =?utf-8?B?YmFMMGg4VVNuMDdJN2g1UnRJVVplMXpZcFpDcnFKMTI2S2p5bEdaVU04d0FR?=
 =?utf-8?B?YkdubUxMUnEvV0toZGE5dEEzMEVuMlRsVTFLWmlTb3g1b0xaaVl1cklhaWxv?=
 =?utf-8?B?WUpJSVZOZ0g5TTdvSmQ5UHZxQUtqMWE0MnhrVnZpOWJ0dTliVVVlZVU4M2p1?=
 =?utf-8?B?TDVlcHdsS21jZ2xVUEFnOEZqWGZJQzU4ODZMQjZ3LytiZWdVNk9tMjQ1SFFY?=
 =?utf-8?B?d1Z2TnV6MkpCK2daY2hzd2J2R3ozOFFSdHZ2Tk9uSUhUT3FYT1RkcnYrOTZO?=
 =?utf-8?B?a1Y5bmV6UEtkR3U5R3FYVVBVQ2t4bG9tOGI3Y3RLN3dGOTNMenZrNjlQa2tv?=
 =?utf-8?B?dFRiNUc1QjVTcnpHWFg1ZVN2TmFKMUlQOHdhZEtBVXA1RkpYK2tvTjZ2Y1BN?=
 =?utf-8?B?ZjMrNDdta0Zkb2I1SjBKMHpYYjYxL2lrNHJBTGpvVExyRFZhMmYzNFgwTWF6?=
 =?utf-8?B?Y29WdzFBWVBnY1FkbUNrcjJVWUptci9WS2MyS2lzbzlPWnVlSEQ0bzBlR3h1?=
 =?utf-8?B?Uy9JT0JJNmFSSlFhK3Nwd1R4REU3UWZtOURaenprSEZyUTJuWmxIbllwQXJZ?=
 =?utf-8?B?NXo5ekxwemQrM2hLdUdGT0JlY2Nid3paVUdudmUrbTNsSGVOUkF3ZFFoU1B5?=
 =?utf-8?B?WUFwakdWdEp5YnhZSkZUVGc4dFdYaFZkWWdyc2xrWVVpYThpbmh2N1JpN3lQ?=
 =?utf-8?B?NXBLUUZTK2xpa1FYcURVZkNrSmM1WUpiRXVZZGtpMGI2dmRwVXlhVHBDeVBi?=
 =?utf-8?B?VmVDd1NTd3AvaXNocVdSa0pWOHRLQlVvMVh6WVN2OENnRVpHaHVpVmJUbHpm?=
 =?utf-8?B?TS9uV2tFeE93MkZxNGgxMzNod01VWVIvYmJiN3dubU43akIweUxMcE1iOWk1?=
 =?utf-8?B?bkcxek5RVkdjRFJRSlRnZVowVkdBMkp2N3EvNzllQ3lmUEoyNjZ2a09lTE4x?=
 =?utf-8?B?RFlsTFJ1UWowTVlNRVdkVW9ROWs0RHk5eFB2djJKcElqMzl6dFNrUG9tOThr?=
 =?utf-8?Q?nDPnzaVFhO3Wq5xTAP3ceJhoT03Z8aT5n2UuNRy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFhIRXJhT2FsTGErZnZqT25TdGlHZnVBR29KNCtUMmI5RXdScUZzYStLVDdE?=
 =?utf-8?B?bHYwMVZOZnZwV2pwdFlPK2V3WWx1VnNhOWFwTmNlNEZ1cUVjV1pJR04wdE1M?=
 =?utf-8?B?bmlYaVhSOE1mWmZldlBZeHNoVEhjbDlzaHhZSWo4cXg5aUhnSWxGRExYN2xx?=
 =?utf-8?B?akZKa2VQRnJ3eG93MEZUWGVhUWFTWVMrNERDYXBpYkIwTVNjVzMxZUl3Skxh?=
 =?utf-8?B?aGZnQThsKytTRG9iNnVVQUpBSTNjZDlOSCtDOGVQNjNrcWRqM3ArUDFwOFd6?=
 =?utf-8?B?RFJjMlhpWS9BRzc5V200STluSmp0bTZ4WlhueHQrNExqVXBrMnhhdVlGRGFV?=
 =?utf-8?B?TjA1cjFRL1RFOWU5NmwxMGdIQ25aRlFOMVNZMHJ4NlFiaEV1V1lkZlRlUUZN?=
 =?utf-8?B?VUhpZkxmWVhZRXYzVWFRR3p0MThLQUkyeDJ3RTQwSWovSnlTcjVtdW85bVQ4?=
 =?utf-8?B?SXFoRXo4eVBMZnlwNWk3TXhlTG1EVFpHd2NIdG9wQ3ZnYm5zMTlzZFFqdmtD?=
 =?utf-8?B?LzJ3T3R0MmxpZkRFc3A3ait5NExZS0RyRkt2ek12RzNMRzB3TnpmYnV0Zkdu?=
 =?utf-8?B?RktWajJIZlBaN3UzeUJXK1M2dE1iWjhPVG8yTFlBY0dCL0xjOThnOVJkUUNi?=
 =?utf-8?B?RlVCSnZ3QWp4Wi94RGdMaFBsQ20xSDhtM3hxZTQ3UGY3Zi81ZHQzeUp1ZEov?=
 =?utf-8?B?eE4zLzl6c1NsWTdpK3hpRk5uK01hMTlwREZZdVh1cXlDaWFPUDVKVDJGcERI?=
 =?utf-8?B?MlNqUC9ZVjBxYVJacmNsV1JRbHRMR2VUaWVuQ2FkWTRHT2ZBUGtCeVkwUmp2?=
 =?utf-8?B?THFZNFd2amJxMDRjYXV6UUVneFRkYkV3MHM5QUc3RGNWdG82Nm56clNJQjNX?=
 =?utf-8?B?aGtVMmF0VTBrUzh4VFlvaC9ZRWVFYXZkSjBURzJ2bjNFT25zK2ltMHJNYXA4?=
 =?utf-8?B?MU42Tm5TMzY3Yk90RHdjMmNDZGdQbGdTaHdCcUpHS1AxWW1vYTFMQjVlQjh0?=
 =?utf-8?B?bnpLcllyT29rTDJpMG1OcWVqaCtIUkFBV1hyQzFJUUFxZTZkSGtxTlpNMFBW?=
 =?utf-8?B?VFR6Q2Fycis5L1paSFBxSDZsVEdZRjJkYkFtcXhnRTlXNnc3c1Y4MzUrOW5B?=
 =?utf-8?B?VnplcHZybHpRTkVOUUgxTEVlN3FxcE5HQ2pQUXd6VmJYQTlhcXMrSHliVUd5?=
 =?utf-8?B?Tm13Q2I4d1pFR0hTMFNVbm5WRFVaelJBWUZjWnFKWGpZVkU4Nm1KSzVLMHBt?=
 =?utf-8?B?SCtXcVlqSG03M2FzeGdXQmdQTG5zaTRxOEVtcU1NUnlpZDBpTnkxYWdENXNZ?=
 =?utf-8?B?WWpYaEdheGhxNHYyeXMwZEJSZy9JNzc2YnNZV0N1b09iTk1pd0ZrRDdjRzA2?=
 =?utf-8?B?VU92c0xqeDBuZGVuUE92R0tjREo4MFpLQWdwZDM0U1VRaHduUXlrSkJpd2ly?=
 =?utf-8?B?SlVFMzMweHd3WHNBY080MTdnU2pMQ3NmS0NlZDZWV09qTUZWSTVyVEdaMGd4?=
 =?utf-8?B?WTliK3NLaWlCNlFCd3ZFUG1PbU5DSmZ3ZVBtR2g1MzRXRGZRVXpzUWxzWnFX?=
 =?utf-8?B?NTJ1YmgyYU1sUEVrL0YzbGxwL3czUVFIVW1YOE9mWGxGNzJ0V1haazRsc2dX?=
 =?utf-8?B?Rm1YVkJZaVVlczFXSWRzY25ucWYyVmR1b0x3MlFTbGJTQ2swMnF4eWsvQXd2?=
 =?utf-8?B?NjVLbXhlN3lWUElIRk9RYklwVVFaSDNDblE4NGtsRUJCeUZrTlptZGhaSWNZ?=
 =?utf-8?B?Z3J1dW93ajZJVnhqS0lqcDNqSUdLUVlDY2ZSMFhzcVNUeUpkcDI0RGJpdk85?=
 =?utf-8?B?OWdrdDJtYi9WMjMzYXp6YTBObmdSNTVEWjE1Zll0YU1YSHQ2SjdGTkw1aHBm?=
 =?utf-8?B?U1M3ZmJpT3F0d2c0R0J2bmc0clNIMWcrQmJ6dVJWWGM4eFcwb0EwUTlWTUMw?=
 =?utf-8?B?amgyQTI0dnp3QitvS1pXOXlNcnpQZStvMDh2TENFRDAvREd2SUdldWJ0cmVs?=
 =?utf-8?B?bFEySThTQTZ4ZGIzM2FWc0tSRTJ2N0RYU3NoQmRoS1dwNGdmenBxR1NPb2FS?=
 =?utf-8?B?OUtmdGFmcjVjODduZ1dGTUIwMmdQZk5qR2VOZDRGTGFQVVNqUlFjZ2RVR0sv?=
 =?utf-8?Q?z5TIR5QLlh38+AerbYexv6MYL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0657b7f3-6e43-4ccb-4c2d-08dcf33f57c3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 08:47:36.4145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qG4PFF4fDp6soSEPvKXz7KQQNtQrZLrlESPeQEeCavlL9JfzI/WeAJrjJjKK1j5uu6RGXj1lX14x5ISvfJBpuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7295

Kevin,,


On 10/22/2024 1:18 PM, Tian, Kevin wrote:
>> From: Vasant Hegde <vasant.hegde@amd.com>
>> Sent: Thursday, October 17, 2024 10:02 PM
>>
>> +
>> +	/* Allocate domain with v2 page table if IOMMU supports PASID. */
>> +	if (flags & IOMMU_HWPT_ALLOC_PASID) {
>> +		if (!amd_iommu_pasid_supported())
>> +			return ERR_PTR(-EINVAL);
>> +
>> +		return do_iommu_domain_alloc(type, dev, flags,
>> AMD_IOMMU_V2);
>> +	}
>> +
>>  	if ((flags & ~IOMMU_HWPT_ALLOC_DIRTY_TRACKING) || parent ||
>> user_data)
>>  		return ERR_PTR(-EOPNOTSUPP);
> 
> swap the order and enhance above check to cover _PASID too.

Sure. Will fix it.

-Vasant

