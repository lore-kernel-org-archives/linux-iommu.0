Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011029.outbound.protection.outlook.com [52.101.62.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192DF271451
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 18:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762972864; cv=fail; b=P6UblrlUPeRu2xp50OPDjfnbnFy/XThCbJ71IKejknDf70pEX2MZJtwcKBQmvWP0sbP9+7D+V5G8QQlyb/pavBx1vYiHypgPvBzp8ZRTenV6iPHhaZUh/1mWnXweJoBIM+IPp2Ogzd3QPbQ7dNon+Az0Mnq5loTOODthygWbwn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762972864; c=relaxed/simple;
	bh=80P/B3sAnF626HZrog7tiYGASUT2H3MKNUdWbiFeKts=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ydo6XyBaAnHUDHg7DWq68tWySOR3mH6mjaE9O8wm6LRzP1zsvP+IDzzJINjm973u/VDG9QPa+MP5268bvrdUl7520BKRMuoz/ed/3avnVHmAvrH0IOJgFDXd7u3G/49qKvnTx4vM+tVU8AkEvkmp3DvHqseMLpVmKjMJh0T3gME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H0qqIlvc; arc=fail smtp.client-ip=52.101.62.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H0qqIlvc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UinMhRKPLnod+X2FeGFSk7BZMT6jDaK6dkPB7LQk8HWKlg0F4L8Niqk4aw/UnZ/zbKejFep0J67ap41Jx2IyAZ9AYNBH78R+W01OW8JJ2JOjfW1Zhm5y0HqBccIrVJ4F+jDs4zuSXkzIsSK1kWHHuNpTva4eZhvmq4VlFENs4UexfoCnwzW4KizGd14d4vwbIYzGr8Lvaev7HZ00LvsM0P4CsaeRkQUo8aD+zrE9zS8MSTpr/98FIr775UgYHwWy4jbjtfwsP9MgD7hTWPtuJNhbONd4PeRu2T7xvuixlhDZyNFm6iKPCCqL3ED7uW911BeIgEw0dNjiecWYAFq0oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eM4RVh7geEFk2TR43SoeiFjJcrODaxMHEpVGLbjA4RE=;
 b=GLLwOr2hEjfgfWThJmJM16tjUsT4S3tGQGif1glYi7lTQfCzq5M2P+/C9L27I3dpFJh8EzazPQkEx3Q/0KdrfWzHnZRQ5uw7tTnsSrhgbFHZw3Lxy1Pr6rHaWufNKTibt8Uqakhp3lHnqsvFN0pohqAYM9FdBU4tKdeRCDq5cH8Gsen6isEALqwWSH17qakaBUPbD0VpjD2ubnl/gLXBVvfWXFZ1d4YSZKNcEZ32Sq3NZiMZf219ScS8p2eDO/9QMp+iZ65xzcch7Hix7pIHT4cdqnisC31VEqyxJS0YpbiQ/Sgg6yP+ra5zTkPqB55XfKF/1hfwlJgSGygqS49jyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eM4RVh7geEFk2TR43SoeiFjJcrODaxMHEpVGLbjA4RE=;
 b=H0qqIlvcjWms0h6vBV7evYbtqBUve7u9hjNQKj6DEH2gdKyNuhF8s8ZADUfHZsckTOjBn3Fkn8pERM4GSvWrEnurT01nrZhtak39K5MaToBdnKeP+StqpSXdp+mvDixgmsZMx3oaFLGU4caH67Tw+ZDBr6zcIHhejgP2KjYtSmQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 IA1PR12MB8537.namprd12.prod.outlook.com (2603:10b6:208:453::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 18:40:57 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 18:40:57 +0000
Message-ID: <8c534f45-80ee-4537-93b5-2643afccde8c@amd.com>
Date: Thu, 13 Nov 2025 01:40:47 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/16] iommu/amd: Refactor logic to program the host
 page table in DTE
To: Jason Gunthorpe <jgg@nvidia.com>, Vasant Hegde <vasant.hegde@amd.com>
Cc: nicolinc@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
 will@kernel.org, joro@8bytes.org, kevin.tian@intel.com, jsnitsel@redhat.com,
 iommu@lists.linux.dev, santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
 jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
 wnliu@google.com, gptran@google.com, kpsingh@google.com,
 joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
References: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
 <20251021014324.5837-16-suravee.suthikulpanit@amd.com>
 <20251023130833.GF262900@nvidia.com>
 <62ba61a5-d172-400e-beb5-e593297129ef@amd.com>
 <20251108230348.GJ1932966@nvidia.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20251108230348.GJ1932966@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0187.apcprd06.prod.outlook.com (2603:1096:4:1::19)
 To DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|IA1PR12MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: d3017787-a210-4a65-e3b4-08de221b0499
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2FGWXJzQ2x5QjZiZVhwcXc4TnhoNlVHY0EwVjNhYlplUjlkSlRTdmlIK0pP?=
 =?utf-8?B?NXNkVmJ6aG53NHRRV1hYNEQyR0JlWWxtbkZZZ2oveGhjMDNlRGVVcGlON3FO?=
 =?utf-8?B?NjYzTjZCSVFSY3BvNXhCNnhUMkQ0dThNZks4b0hGSDRZUS94Y2VVc3kxNEVO?=
 =?utf-8?B?UXAyVlpUZ2RxclJSQ2pnWjJSa3NlTE53bDlZeDh4VFJQcXRqNXZpQW9FVVFY?=
 =?utf-8?B?Y3Njbko0eVNGRmxHWjdZMmpQb1pZdWhhUUh1OFpoeVJXcG5CUWIyNHQvYUhF?=
 =?utf-8?B?SE02RmMrT1BJN29nMFVsSVpZbWlXYXUvb1hWa09Gbmhaa3ZScENXUkVNQzNw?=
 =?utf-8?B?dUJBMXdEWFlpc1dIdWRxS0ZSWDJ3OStKMUwrUWs4KzhSckRpaUU2NEIyWnQ5?=
 =?utf-8?B?ODltZzFaV0ZEQ3RCSVRyaGxFY2VZTElMVVhRRXJoZU5nd0owQjJCNnlwdzJH?=
 =?utf-8?B?NXB5cWZITzRHdWpxYkNPRzZNVGgvZDRrSlNNL1owZTFCUzQ1T0pqUWhTNlVL?=
 =?utf-8?B?ZS85QWpJV2JnTWFlRjVRbFIvKzNINkpYZ0RvSHRuVkdsVGxsT09yUUxJc0x2?=
 =?utf-8?B?c29td3BNNEd6QjlXR1F0dkJjQ1pmOVVKTzU5bUkwQitsaElBaURxTExVdmxM?=
 =?utf-8?B?bS82Mm1sRDRlUzdoN1RrbmtscUFDRUVkd0R5eDlJVnNiMTBERHVlQmszUVAx?=
 =?utf-8?B?UElpR2tBdG9uV3lBVVNTaDhPVTdvVytBK0g0SW1ZMEh2ckVURXl1Qy9Gb3pW?=
 =?utf-8?B?ZWpSc2liaW1LZ3g4dzhWUkFyTHZ2YjBnZHhuVjJTYTYzVW9OdUFMT1VBTDNt?=
 =?utf-8?B?NXBkZVdKelJQV1krdm1QcVVaaVZUWUZJRHNsMWI4U0NwaTRDQU41eUczSjdW?=
 =?utf-8?B?LzBiRHhtbll2dktEM2hIUE44eVp3Q3owRVRPT01VZnJaVllERDBEN1dnejZ2?=
 =?utf-8?B?UEdwQmN5djNkakEwRVdkSFB4RVVFY21wVjk4bUdjd2dYZTZLTVZoRUZsN2Vl?=
 =?utf-8?B?RU11dDlRL0RsNTRYRW5ML0lWSFZacHhiemVpN1hJMGRRUjJYelVpRXNtMHY2?=
 =?utf-8?B?K09CUUhxVVVLR2pnMXErTmhBREI1UVhPcTI3a3lIRnJabnk3VEtpaU5YM2xX?=
 =?utf-8?B?WVFkcXBycHRUWWlqeUNKclZtNlJmdExKQkMxZEdrd3VnanZYWjFmUWVMc1RG?=
 =?utf-8?B?QlBRVUI5Y3Z4WmJ2V1NMVlhzYS9EYzd5TExpWTQrMVZtZENOcUsvMzVLT2lt?=
 =?utf-8?B?VW0xNmRKSkkzOFZkeXdNWFljVzhNN0xFTWZPQis4eGFidGJ4bDhQZ3d5WDcy?=
 =?utf-8?B?ckpua283VGlRYUdXR0c2NjQ3M2d1SC9KZE1VYlc3b2hQMkZGOXJ4R21sSVdR?=
 =?utf-8?B?OTl0bXc1M2hzdkRSRTM0c3J4UGZ1QUt2RnRxV1RQNURIaXZSbEhYTzZlY2Vn?=
 =?utf-8?B?VUU0V3VQWnRGTWhYNkJjS2tQUkpGeUdFUTFFajQ0QjhIL0Y1NmNGMlREZU1G?=
 =?utf-8?B?c3ZIczlLKzYzanZlUTVFNXd6VmdML2wzVG8wd1hzNVhCZElHZ00wZzE4aXFG?=
 =?utf-8?B?ZmpwTzMwcDkvSjRobTlibnJ5YmNpT2drejQxdlpid0VocGdBYk9hWXhZQTNU?=
 =?utf-8?B?dW5HUlJMQWlEZ2ZuSVl6TktVaGc1S0FOamdHVVljQldFWUNZbnNocXZFUXhx?=
 =?utf-8?B?aTNOc0dLaXlzTDI1TisrY2k5NGNXYXFhbFFQajdIcVJMWGExRS9VOFV0UWg0?=
 =?utf-8?B?ak91SmxMRSt4Q1BLa2FuRmVyOFpSRUJGNTY5dm12eGtqVThXbyt4Z2hzYnpl?=
 =?utf-8?B?MmRxaHhUeGVHSHR5Q0s0anZDYzVVaGxlWFZNTG8zdmlTekFHNzZ0SytvOVZM?=
 =?utf-8?B?clVyQkdMMkFNSHl0aUltQW1NMWJCSkprcjA4VDZwVlNyTE9TR0IyQy9DekNn?=
 =?utf-8?Q?3yd1Nno2CX5yUjKMpBNNSFvrndjJbKso?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2dvV1h5TGVEUVBWMWNsTGprbTBtVmVOWGg4ODJnQmhaVE90NTM0WU1zYVp2?=
 =?utf-8?B?d1NLSG5CYnlrUXkwRnYvU2hXd2UyOEwzOTVnOXZpVUdpbWc2ZHp2Qmh4dXZw?=
 =?utf-8?B?eG9NVUlkWWl1aDY1MnVLZkJoYVRoNWZIU1oyQm5Zaks5UDJiOVQxUG10b2Vq?=
 =?utf-8?B?cCtsemNNYXdhUFJtcWdKTzVsZm9iaE9yaGx1ZkMvWmV2VzhXaUJYbnFyRmN5?=
 =?utf-8?B?MGhnUnFuQnV3WWp6cnFoZDcrVis2bzVucGpKdkZUL21TYmNBNi9ac1Nndi9j?=
 =?utf-8?B?NWMveTR3UUhFb2FvRGFlSlJCUDRXUEROV2svYlpSRzN4YkxkVElsNXZsZUY0?=
 =?utf-8?B?ZWZ6bnFJbVV3ZEYzVFJhaFJVRng1ejlBTHdJK3hkaFhDYXBJN2RMZnNxMUZs?=
 =?utf-8?B?RkhaM2s3U2ExaVR0SURxdzVCVHhIVUZybHF6TTlzNk8za0pZK2NIREp1TmQ2?=
 =?utf-8?B?WFJDRWZ0SVVxMnNFR2lBMDVsRWhtSEJxSDVhYXBLRmEvblhlTDhaNEtnYnBk?=
 =?utf-8?B?RDhNcVRJTWpuclBobGJMcjJhaEhhZEo4SGIyd0F0VUtUc0FCUXdNOHhNUFda?=
 =?utf-8?B?cmR3VHVNZXRuTHFEbGF4MEh5UGwzclp1WW9lMG1jUy9BbFZMVmMyWmZCWjZk?=
 =?utf-8?B?RGJHM2E0WS9aMFlnemhsZ1lHU3pKMWpCYzZHUmRNK2hQdnUyVUpoaWN3dUQv?=
 =?utf-8?B?NHovN3dCVTVpK2cwZWowb0RSQWVEeGJxVW1ZUFVSaCtWQUR6Q1pNYWgvNDJY?=
 =?utf-8?B?RFVlQi9NRzcyaFNaQmhmQzczYzdobXFCb0UwVDdPSVR4d2xHZ0RnUEdZVXVv?=
 =?utf-8?B?Q0hXRnJPYkdGbkNITFVWWXlCd0dYTktyVUx2Q0lIWEpGY3g5UHpEK2o4RTdJ?=
 =?utf-8?B?Z3BYWXcrYm05WVFLRkxiNjJNWkdWWHZvZFBoanNTaDdNRGhRd0dXdUJKdjFD?=
 =?utf-8?B?MFJING4zanlwcXRQOWJEWkNFVTlqODlubFlLRjY3b3hxSXVtVWJEc1pTc1RK?=
 =?utf-8?B?bVo5VXF6TG9FSUpPYzZLQlFJQkZWWldUWWtrT3oxTVdJWFphcnVabDNCUzdm?=
 =?utf-8?B?bStKOHMveFU3eWRPYU9Bd3ovcy9KTUpCcWRKdzY5M3YxWGpOZTlWWlhpSWh0?=
 =?utf-8?B?MmdmdzNCNVVmOFZKWHhZYktYVlZURDEzcmgxT2xvaHB2OTg0cVNzMmZBeXVS?=
 =?utf-8?B?ODd6NUh5SmJqdE5nRzNTQ3d3NnNnYTMxR1p4U2NQL0dua2hHdDBBamRGTEJ5?=
 =?utf-8?B?WWs5ZVVZcFNsdHNwaEd5Yk1rd2hCUW01Vm9uUGd2QkZmSGY4ZjE4VytVL3Nq?=
 =?utf-8?B?ai8yUzREU0VtZSsyNUlzRnFLc21aM0NCUVZ6NFlidFhjVXN6NFlNYS9meEEw?=
 =?utf-8?B?cUUvaXdSemxGbks4WVgxdGVSVEpqa2xDZ2FYaXpzWnhqcHh3VkVsQ01wMzB6?=
 =?utf-8?B?SVBTRXRlalIyZmNVRDJQZUlMSEVxZUdXUWRlenpEdUhOa0JTVVZ3SDVjNDBp?=
 =?utf-8?B?Rkl3V0Q5bGtHRmVVWWwyNllmUERWTjB3cGt3UWw0WElGWGd4YjFnUTJFTldh?=
 =?utf-8?B?eFpJMjFGdmorVGNJQzAwaU9QTlUrTGhkSGpQOFZOaUVBMXJYY1FyTFRjOHlB?=
 =?utf-8?B?b0QrWGR6OFl2TUY0N21xNE1aRnM4OElidE45U1kwNW5hNkxjRUs0bDUzc3Zu?=
 =?utf-8?B?SkJNeDBNb1FSNVdramNmdkdSY04yNUFCR1ZqUHljY2pwVVFzWFlWSVo4N2NO?=
 =?utf-8?B?UHJmUGlvcHlweWU0Nkw2dXhjL01hQ3l0aVM0SnRRWUJKcHd5TFltVkM5d0cv?=
 =?utf-8?B?RFAzNGIwSWp4STVLMTRHRFY5YUszeW1tdlZaUnJ3NnZzZitMT0dOQlVSVUIw?=
 =?utf-8?B?dHZaSlRad0lBallPMVhhZVY2eU1qempZYjd0TjBEdVAzV0trcDV5QXJEYU01?=
 =?utf-8?B?UGQ4V2RrL3VyU3M0NCtyRjlhTExjbzdjTmZPSjZ2aDJJWEhqcUpremdhV0Ji?=
 =?utf-8?B?QXJROFdwQ3lydzAvUVZmblZUa3dRU055dVVQS2QzTXJ5K2x3dkdvbmNkaUZD?=
 =?utf-8?B?dmF1bWpKbDBFMVpORGErbVc0VTZ1OXdiSDdBb1JsNXdQaDBCRytYRFlwWTVO?=
 =?utf-8?Q?xorZUE50PMlOfPlT8Nwo/Y8o6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3017787-a210-4a65-e3b4-08de221b0499
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 18:40:57.3716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4YKXsoBPe6G0oFULVk4WwsAbumH9Wz+9Xg69SlvctB5DcT62ZeOV+jK8ksEtHd8e80DyfUSPD+R2I0VxYhvgPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8537



On 11/9/2025 6:03 AM, Jason Gunthorpe wrote:
> On Sat, Nov 08, 2025 at 10:56:38PM +0530, Vasant Hegde wrote:
>> On 10/23/2025 6:38 PM, Jason Gunthorpe wrote: 
>>> On Tue, Oct 21, 2025 at 01:43:23AM +0000, Suravee Suthikulpanit wrote:
>>>
>>> (though how does IDENTITY on a device with a PASID installed work?)
>>
>> Probably set_dte_identity() should call  set_dte_gcr3_table () and update
>> relevant fields.

Actually, PASID would not work with IDENTITY since it has no page table 
(i.e. iommu=pt means DTE[Mode]=0 and does not have host table pointer).
PASID only work with GCR3 table.

Therefore, it does not make sense for set_dte_identity() to call 
set_dte_gcr3_table(). Each one should be stand alone.

Thanks,
Suravee

> Yeah, maybe so, though it might be best if the caller can detect it
> and have it call both functions instead of trying to bury it.
> 
> There is a fair number of variations here as you have
> blocked/identity, RID/PASID attach and PASID detach to all consider.
> 
> It would be nice if it worked properly, identity on RID while PASID is
> in use has a strong real use case.
> 
> Jason

