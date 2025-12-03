Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010042.outbound.protection.outlook.com [52.101.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A740C2E3B15
	for <iommu@lists.linux.dev>; Wed,  3 Dec 2025 11:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764760026; cv=fail; b=ZMbr9dGEVKIirhSqyM7nwdvZ8iKZfF0p9UCM4axbILcxxUH+1Mw6u0YN4VSQYFvzliRx12Amah9ky6DKcofVhBOEMRNk2kXIkwCchUbHNY6TiO6+MxvPDAqQ0eYVyCsZpT+GCzikjWYpOqu1gOLWFhZsOzjfUSEDTdJVJzuXLTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764760026; c=relaxed/simple;
	bh=P37uhpKVPCxNLgwwRTnBg2IKP5pHAjPhU3uUXAZu7kI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O9GfC1BWdS5vRnVHhFI1oVq4CElRuus0AW7iVU+6mekMrup3+17bt0s/5RrV8V4UR4q19a0RPcKVR+jggzP9HgC7gAow/JroJVqRX68GuFwWXzlcdvy6RZqP5r/+49H98C78XagMQK0F4BSnJdHR8OzEkxOP2RtUE653QKMOUTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nJwGb9mo; arc=fail smtp.client-ip=52.101.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nJwGb9mo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kXaWqoFZ20bPrhbGGvW2I7CkiMajafPsuhlTPdf2haeIR5JZEPs6QK00T+J0tdrMzZ6WI3cYY7Ci1ISkIU0rbROtnX18V8gWglo1VZLMAMIhWa34q9HnGG4jRWKw1lAzkUbrGph1eozNqv/X6KVLNSbTjTiMw/vgFXgC9DrSHuNyIIesLy2NUeuTpPxLksRr3MmHszMIJYy0P4k0Y3C14NGMJrYwCM6RiRBuQhOLGfjdE9PdXZlS37NqitW+Dz9e6iHLDFLzSFMXcYzXIZ0TaGb7Bb1rEa5dHpyFqDjwYeebNI5lqVzEEjq4WFdDjLxQoQwTFlt9HNvH/WDD81to9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWiZJyT2FyHNj0cXTvfR4D3QuxS/gv9+l4n9+P3YC7Q=;
 b=Qw/Bh6BSFuRmu70xfzTO2MO6uoeh0AT6AITPIDRv+dK5bacBg3ulV2dxTb5pxtUAP2rhukXDAVBa3eRyMeru//dohthrVYgemcA3/2fZgPLhk9fU6ouBhfVVSEqWvUo6dqefmZsflvO2vZEFEX/4EZbBxckaELmpW0ji8ojONCOJya0rWnhULV2Hpxi4HONO6kEXVw0gDLy4x+XTtFNxYJQ0lfAsZxqnnZgT86iMWtdj+/UkObzNTWy15P3XV+YTdb2Zg6XgpP3KTR4xEpTqiy5rrCx82l93lb3agKt7hONJ+UPNOZ+tRcN4F5WMb6F/2HgnvVmP/i5rWVXcE0dmPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWiZJyT2FyHNj0cXTvfR4D3QuxS/gv9+l4n9+P3YC7Q=;
 b=nJwGb9moKEeE228YIK5gQt3FC8CdD8YvMaFtDVYbRAiBm5+6dsR5i9kdM9wfoAMqENappfoPOtjiqTTIr/EYLt2I4nWovoYID1b+ms7fInkV5cmB1fm4aQPsoOsnddLYS/SOnHIq0efCSJQkbU8JpVXmnpH4CtdmZho1m6Y6FqP7408wdHvPu8F+/KxOjbfPcerBgA9lmouhszGRbm3cG/ER2GwKBKEdpAW9r28wHB6K/wsCKwdOZb0KUyCdaCH5Ksrp2N2dOy0ainl0ljesz5tXYrpsmVNwrZ5t9rzjDGFPr/nazkq8nxrcUGXAVZhIR6xQPOeHkn5UX9VvoLKHAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 by PH7PR12MB7793.namprd12.prod.outlook.com (2603:10b6:510:270::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 11:07:00 +0000
Received: from BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c]) by BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c%4]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 11:07:00 +0000
Message-ID: <8e742787-c60d-4f88-9de6-adfce31f7b27@nvidia.com>
Date: Wed, 3 Dec 2025 16:36:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 3/3] arm64: dts: nvidia: Add nodes for CMDQV
To: Jon Hunter <jonathanh@nvidia.com>, will@kernel.org, robin.murphy@arm.com,
 joro@8bytes.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 nicolinc@nvidia.com
Cc: thierry.reding@gmail.com, vdumpa@nvidia.com, jgg@ziepe.ca,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20251201163219.3237266-1-amhetre@nvidia.com>
 <20251201163219.3237266-4-amhetre@nvidia.com>
 <516f57b2-cdf1-435c-8de4-978ac8b03f62@nvidia.com>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <516f57b2-cdf1-435c-8de4-978ac8b03f62@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::33) To BN5PR12MB9511.namprd12.prod.outlook.com
 (2603:10b6:408:2a9::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PR12MB9511:EE_|PH7PR12MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: e2c9d6c3-528c-4c69-0747-08de325c14c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXA0QVQ5NWwzNUtwSjNsRjd0bW1nNzhOb3k1djJWQktkNENtSGpWVGUrekVP?=
 =?utf-8?B?WFp1SkJMbkVDZmwyS2x0M2dOYkhyL0tMV2Z1OFcwaDAxUk9aMExLL1BIck5a?=
 =?utf-8?B?eW5nWEdUVW5oQS9IdE9wZXRhMkJWbVduQzArZUtkVHdybzdpNUNDUitaV3dn?=
 =?utf-8?B?MEhRN2RPWWxYRE5qT2dQKzRrYXBOQmdSZCtEU1NJM1ZzbThLeWRobVo0NFRy?=
 =?utf-8?B?TjNqUGpDa0djSW9ZaWl4QVBZMjNwSm1nUlpDc0x5ZEFIcFBsVVBUZ2xaVURN?=
 =?utf-8?B?RjRtUXp0T1o2ZTZiNlRNbEMrd096QThtU1dVeVpkbjUrMjU1YXZvaE1IcVdF?=
 =?utf-8?B?OHJpRGRIcThVMVRCYlFPUmNCY0ZaYmNsdVlaMjdJZ2o4aE9wZEREU21HN0RD?=
 =?utf-8?B?OVFwLzMzZjVqUmRkRTI4cTJyYnMyTEFNdFJ0N1B0MkRHak91VzdkUWVsUnRG?=
 =?utf-8?B?WWswM2tIQy9EQWVrMXdSamJUYzh5MlJzSXNDUUhYNTZtRVVKcCtvK2ZnQTk4?=
 =?utf-8?B?TnNnejZXeVhBSzhjMWx0Yi94NlZCY28wcE1KR2lHTnljUkxMczFSSXI5TFRh?=
 =?utf-8?B?bWZwN2ppdUsxc1ZkOFIzZWFjdjRnb2l0WnVkZlNweDRGUitUOE85dlB5QlE4?=
 =?utf-8?B?eGg5MEdWd0NiN1NiOHU3ZUlrZGJtQ3FEeDJsOHY4RU1GTUN5OEZqNldyT1RX?=
 =?utf-8?B?Wm8rSTlLOUU5ME9pMzlBQUJDK2JJbjVPQ1ZDVzJ3NzFxdXZCN2hPY1JkdVRj?=
 =?utf-8?B?azNjWFpxMkN2KzRGcVU4Wk5KUUdRSU51cGZiQ0V3YXdDcFEvREhVV1JZcUR5?=
 =?utf-8?B?MVphUmtvOHJOOWZqZEVjcFpMNnpZdERLWGs0K0d1WFZkazNaMjBXR0xLcS9t?=
 =?utf-8?B?bG1KM0RlWHlRVTNCZlg5QVR3bEFGSGUwSEhNVkxDeUxKdHd3T3NDTmx1YW9P?=
 =?utf-8?B?dEpYeFVZOWRUTStFS3JyRUNiTXo4WnF3NlVablovc3ZqZUxlQU5BTmpNSndj?=
 =?utf-8?B?QTIvZmdiVG5WZXFVOW5xcVBCK3BGTDNpYnlXRzBYNDdMY2pjMTFhd1Ywa1Q2?=
 =?utf-8?B?Z1pUOThybWJJZ29ZVjU3Skt0Y2dHU280NkRia0NPV2F3eXlHUTg4NTZmQkZG?=
 =?utf-8?B?N3JVK0ovU0Z0MVJ3d0x4cHJEUFpNTjk5TU5zQTlNWWFsZVBWUStwVWw3Qldn?=
 =?utf-8?B?NFJkODQ4MHpBelBDaHJ2VFJFdkZ6Snh4ODF6c0haSDJHVWk1dHpQdE9zRkhE?=
 =?utf-8?B?ajZmZ0lUUHN6WHNqV29LN0piMHNQQkVxM2s3T28yNFB2N2JLaXU3WG1YZVdL?=
 =?utf-8?B?WVBob1ovdktkYzBXTlVPdDI2bW5GaHFSYjFBRFg2ZDFiR2I1c20yVmpVV1Ns?=
 =?utf-8?B?R29wTnRJbjB0YlNXZFdmVjYxaFRsSlRTWjdiK3ZwNVF5Q0lSM1dwQzhhMGU3?=
 =?utf-8?B?SGhOalJ4bWhYZHFITERhQ3Z0dlV1YXZ2VjZ2VDlxMXR1Q01lazAxT1BqY3Vw?=
 =?utf-8?B?QWFZbFFKVElFLzdpRjNOZ0NIUUpNRmQ2YWlZVS9aQW4yNDZBbHI4dzhuSHFQ?=
 =?utf-8?B?azZ4ZXUrYVFRZ1NJdTI5MHVGMjRSbmoxVGF2MjN1Rk9iVWJnVjF6VDZXVnRD?=
 =?utf-8?B?TGdvNjl5YzY2SEJlWTlqTXlBZ3pMZzdlTzdxajJ1R1VKM2tBeFBlak5rVXJo?=
 =?utf-8?B?K0dIVElzV2lCMHQrTnd6MTNsTVBtVDVyWTY4eTlrWnNsa1FIcjkwdDY0YVZP?=
 =?utf-8?B?M01CNjltRUVQeGo1UnFXWFEyMUh3bGd6RDRlS0pSc0FQc2JjQTBDODgvNXhD?=
 =?utf-8?B?Mjc3d1lxZDhmTllacFJTeTRKMzI4R2NIZmN2SXZLZ09VaGVLRk1nemxjMTRN?=
 =?utf-8?B?dEd6VU52UlRDSFU0cGp4OW8wWVMyTExxM2hzekJuOG1TZDFpc1ZIYzBWVWU5?=
 =?utf-8?Q?74qqhIcNpNJscxcuLopgr5SKZlUQso9r?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN5PR12MB9511.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkdrRVFiSVVxQ0JJNVdBeGRITGd6bmRXUmRadFJMaU5ObGVKL0FkcHpOMTlX?=
 =?utf-8?B?Y1NQdnFTZ2xOZ1F6YVhQNUxuMU5peGFVSVYyUGpDRFhESHhFOWtzdFRiWWMw?=
 =?utf-8?B?bmg5dGNOdUo1WUY3ekhDYlg5SExOWlBXM3d4emJsT2RSc3RGU2twODgxaklk?=
 =?utf-8?B?TVp6b294MjZDZDRqSTZ0V0d5alZYcjZDZUlLMWdWVnA0R0loK21yK0ZBVmRK?=
 =?utf-8?B?bTNaUG1rLy9CRTN0VlRIMVl6Wkd2cDRFejVhV2ZjR044aE5HMk5qczRRL1ZI?=
 =?utf-8?B?SGZMRzgzZXd6UEV0Rkp5VHBDcHY0VXpiM2xzK296eE04dERXTVRsakl3NGNI?=
 =?utf-8?B?dVQ4WE5leVZBQkNaUkFtUDJUU3c2QlBzTHhlcjdxdC8rNEVIZXAwVTdoTUdt?=
 =?utf-8?B?czloS3d0MVdXQmd3SVNXMEoxMzM2MUoyU0NFLzVlcjZ1L1ppVUt5NWVkTUU1?=
 =?utf-8?B?MmNxdjg3bFVZQ3Y2Mk4yZHkrS1BnWXJKc0o1UDlqeWd2dHM4dDVKOUJBQW94?=
 =?utf-8?B?RG1iUlhLdWJBZVpwRnpta3QwVktmQW9LbXk0RVlTclBuVmY3Uk53LzBndGIv?=
 =?utf-8?B?Yk9KKzcvWVg0d0tVQURGUHk5RGk5Y3ZiclRsSWQvNmdmVnNreEtzbm9rYTl6?=
 =?utf-8?B?cWpFUVVoMGo0M0tiQVlXR1hzS0ErV09UZEdNbHFqSkxHZlRsVm82bFFLa3Va?=
 =?utf-8?B?YjdZcXBrSHlJSk8yU3h5d1d5Q0FIRkt2WlZ5eTk2bEtkYkNIdENGZ2t1S3Yx?=
 =?utf-8?B?ZytyWFNXcXlickVjYW9rd3IyaE00NE55MWlWQVZlUE9SQ1Z2dXVPZC9LcGlO?=
 =?utf-8?B?ekNTQmZhQmRkNjUrKzU0bjhCTWN3c0pVcVliS2JKaWlKcitqaDBvd2VvT3JX?=
 =?utf-8?B?d1lyYTMzaFZSVmI3dHdhVTJUOHFNSXc2WkRFTmFQR2RjRTY5UGx5Rit4S1pv?=
 =?utf-8?B?Q0lLWjUxdzJXWGxBTjB2T0poUW9GYkd2VklJS0I5N2p4TjhOQXFDRk51T3VT?=
 =?utf-8?B?YTdPbk5JM1dsSTBDdFpnYk1pUURVK2NTb2FHRExiVFdUQmN3T1dKcktaWTl6?=
 =?utf-8?B?QVRRY1JNT1JvUkF1Ti91enAzYldrRXBkSFJDUTZBMXYvVk9BVVhNeDdESUl4?=
 =?utf-8?B?a1hJTG1YVStQRkp3d0dIZENRa3RneFhmTkV5TE5MQzZGQ1dvUEdGVnRxeUZN?=
 =?utf-8?B?THgwallFV1BnNUNUU2tBR1dIejYwK1FGbXRPbGJIRHF4SlBidUZaTGc1ZjA0?=
 =?utf-8?B?dUo2NWJkcDNsMG5LY0dXQVVVQ1RpVVl5dEZQR29RaE5QQjhSM1gyNFBoNnEw?=
 =?utf-8?B?ZG4yZGhjK2l5RnphU0JkSnFIUW1IOS9FRUJFZFZneUQ2SW9YMU94R3ZZaTJP?=
 =?utf-8?B?eXFGZkhkbkx5cnpuWGpteTJ0RGppRHZ6M3NLYWZUTDk3RGp0L2NuS2E3Wjh4?=
 =?utf-8?B?Q3hULzlhVUg5b1dQWktQcWpiUFZqSHFQOTY2ajNFa2NEVTloNFZZRjh5clJX?=
 =?utf-8?B?WWtXSUhEK1VIOC9FOXdmKzhwYmhvcnJ0dHQ5Wk5HOFRxYkI5QzEzQ1l4Q0di?=
 =?utf-8?B?VUtGU1hUVURiS21jZGRZNHFtTFVPZkV3NlZ0UllOVVZpWDk2b1FmZTBBSHlx?=
 =?utf-8?B?UWVxTGZncGZFWjRmRi84RHlzUGxtWWRqSlB3TDZtUTRRNXovUUVqN3JoWFl3?=
 =?utf-8?B?U0Fvdjl2VUExWDQ2YlVpS2NXLytXQ2EvU2QyK2JzMEhqdnBKdklkRytDY3NV?=
 =?utf-8?B?eHJUYXU4cHhadCtJQW5NMjJ3RVFOQTBTMTl2V3dnczhhN3drTU16VktGVHBG?=
 =?utf-8?B?djcrZTl5NGFqbTEvanE0bmgvYjJteW8vK2dzR210eUg0aDY2eURJSDRjT29M?=
 =?utf-8?B?Yy90MUVrWU1JM1gzVThhSzZNN1dvb2FWK2lVM3d2eEZoWjlJbllQOUo3VEl5?=
 =?utf-8?B?NFUvUVpZNUFwM1N1b0hzbHRpYXc3ZG9iZ1hyL21uaUd2RHNjeUd5dTBIWXJr?=
 =?utf-8?B?TGE0bWRWVTJZM1ptaUJhSy9zRTR0MTVBZGdvLzVlSDBQL3Y1cVdlM3hhR2Vu?=
 =?utf-8?B?UnV6TEtld3RFVFl1ZytKOTdlMis2a2RBRHdzN3BiMHF5enFiL3BpOExQR244?=
 =?utf-8?Q?NiaM0ZmToW1rluJIDCHI7cNht?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c9d6c3-528c-4c69-0747-08de325c14c1
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9511.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 11:07:00.2538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nIOfnf1p38SwUF7dF7syGt5noflowvwlWNCVsBWGMv58cdw35XZ0KOECNLdwjwXGh30gPd8mjxaa+3LFti8JVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7793


On 12/3/2025 4:14 PM, Jon Hunter wrote:
>
>
> On 01/12/2025 16:32, Ashish Mhetre wrote:
>> The Command Queue Virtualization (CMDQV) hardware is part of the
>> SMMUv3 implementation on NVIDIA Tegra SoCs. It assists in
>> virtualizing the command queue for the SMMU.
>>
>> Update SMMU compatible strings to use nvidia,tegra264-smmu to enable
>> CMDQV support. Add device tree nodes for the CMDQV hardware and enable
>> them on the tegra264-p3834 platform where SMMUs are enabled. Each SMMU
>> instance is paired with its corresponding CMDQV instance via the
>> nvidia,cmdqv property.
>>
>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>> ---
>>   .../arm64/boot/dts/nvidia/tegra264-p3834.dtsi |  8 +++
>>   arch/arm64/boot/dts/nvidia/tegra264.dtsi      | 55 +++++++++++++++++--
>>   2 files changed, 58 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi 
>> b/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
>> index 06795c82427a..7e2c3e66c2ab 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
>> +++ b/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
>> @@ -23,8 +23,16 @@ iommu@5000000 {
>>               status = "okay";
>>           };
>>   +        cmdqv@5200000 {
>> +            status = "okay";
>> +        };
>> +
>>           iommu@6000000 {
>>               status = "okay";
>>           };
>> +
>> +        cmdqv@6200000 {
>> +            status = "okay";
>> +        };
>>       };
>>   };
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra264.dtsi 
>> b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
>> index f137565da804..5124715caeb3 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra264.dtsi
>> +++ b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
>> @@ -3361,7 +3361,7 @@ bus@8100000000 {
>>                <0x02 0x00000000 0xd0 0x00000000 0x08 0x80000000>; /* 
>> ECAM, prefetchable memory, I/O */
>>             smmu1: iommu@5000000 {
>> -            compatible = "arm,smmu-v3";
>> +            compatible = "nvidia,tegra264-smmu", "arm,smmu-v3";
>>               reg = <0x00 0x5000000 0x0 0x200000>;
>>               interrupts = <GIC_SPI 12 IRQ_TYPE_EDGE_RISING>,
>>                        <GIC_SPI 13 IRQ_TYPE_EDGE_RISING>;
>> @@ -3370,10 +3370,19 @@ smmu1: iommu@5000000 {
>>                 #iommu-cells = <1>;
>>               dma-coherent;
>> +            nvidia,cmdqv = <&cmdqv1>;
>> +        };
>> +
>> +        cmdqv1: cmdqv@5200000 {
>> +            compatible = "nvidia,tegra264-cmdqv";
>> +            status = "disabled";
>> +
>> +            reg = <0x00 0x5200000 0x0 0x830000>;
>> +            interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
>
> Like for other devices, the typical ordering is ...
>
>  compatible = "nvidia,tegra264-cmdqv";
>  reg = <0x00 0x5200000 0x0 0x830000>;
>  interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
>  status = "disabled";
>
> So let's follow the same approach here.
>
> Jon
>

Sure, I'll update the ordering in next version. Thanks.

