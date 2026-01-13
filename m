Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012047.outbound.protection.outlook.com [40.107.209.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02CC2DCF43
	for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 05:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768280781; cv=fail; b=NfHCCrforWK0eqPZdOGVz1jH1UOgLZcWdcg1Nujnv4BbXilhN+klOcFiwEVcs0i1OytKHkGW8cEbE4xN9/x1EU1dx9KuZeUGpM6p2V9AMVsScspRW1m6UWTzWDoUcQGjy0/VG0qV3eARWNcrAmmOnqYl2336/14NensE1bJrVCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768280781; c=relaxed/simple;
	bh=mbxmgy7hH8LAUMCvtpllHIkPYiw9F9tOo5hx7FKy9b8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KftlbCFwW8VCe5yKLm1UJryQ3V0oEWYcFX+A/xfvOdoHsEPA+vmwpHV1iy6GSqA6QfLAo4tfSgMnf41J5a7X6cbfD3GEj/yTZ5Mprbp19SSYYyJm2vnioO7W7UlY0pKpIcZY7f0FljYd85RX1Bu17ZXRvP/yIsr3Ya8+RCY6Mxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nygir4b8; arc=fail smtp.client-ip=40.107.209.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nygir4b8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rOi3HwOdD3NUfB0LzGx2dX6MoAnWqxI2DPCepo359WwhbG6wFYTor1dL/p4eUaoP3bN1BXf1KRk2pD6fGzBQbVKOvFKti4isgEeW0YwgQ8ts10ME5tTWhsstPOoiCgPAsIihu41WHOHFzchDnJJTzUJJI4/A6FprdNZY1NbpH8a9VtkKP4f7KCVfXshiH7nLvKXvgrfDFibsnv31K0S8Fb56j+1nhZvj9Jm+tbOHz2X8R/gxyjbYPJs9XomW4wT++PYUVTgUr/8GKJ5UIraqZekj42B8wiUv9iqNA/e+j9Ylj+J/sGN0el/rw+rpwX+J1MtAcg02MMcwlrp2CG3fzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUCZOCJhhkH8B/0V9UdF2xTqXrtdusIxmV25vitXOII=;
 b=o1SHT3eCvk+54AP0ffeinoVm2BythDTWTloz4+N/s/2pi9daG0Djz3wkedPTlqPE4Yx2ivPowrFqB+ztWSduHyfBPnoSkMO72tu3kVjH333M9JI1fCSiL/SCBC/Ejpy9+TJif+N6UfgNV8gKSQ5DinuQwhAZaqkxEw89aNn4UN71yPUHTsR4HBXcQsXk8eHck3k8LTHv7lRCcD2isp8wsyaj+Cpe5+YviRl4+zbGFscVQ6m+CNSbhLny0IU++M9tqJJ192+qdrtLzdqVqKFnK/kypyEU/h398YLb9jk0EBdpDiM+0SoPeqSgG3KmKQhW2pjBrX7P39tAAE1LzXg6jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUCZOCJhhkH8B/0V9UdF2xTqXrtdusIxmV25vitXOII=;
 b=Nygir4b89wUodHglOHvV5uXSAyAU0zfF5XIGqlh1QFEEr5pXpg3qp76MQwHIQlh4nMZHtXkN9wlrvPQVMRpn4ScZ6MGhGCJf3z2F8kx52AnCYsr6car3AVRruV+kX73NQRruecYoBfD6gHt3zJoEDVonjFekW89Px8TS7KqO77x+YEDwzljasEiYXpC3DUNp8/M1tsV89xcPt4PamxA66MZPN6H8JX6wIz5XMe653uHzjc0k0KBxkVKOg77qsDsjMdJNnprViZdHjDUPNARp+eZ4gf5KKRXzbaxecrgKN06JV+QO/19z0OaIsRnbFqPPxm7fCqpEHauJEvGC3epPfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 by MN0PR12MB5954.namprd12.prod.outlook.com (2603:10b6:208:37d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 05:06:15 +0000
Received: from BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c]) by BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c%4]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 05:06:15 +0000
Message-ID: <09510976-5f1b-42a4-bc02-2a21c45048c4@nvidia.com>
Date: Tue, 13 Jan 2026 10:36:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] iommu/arm-smmu-v3: Implement pm_runtime & system
 sleep ops
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Nicolin Chen <nicolinc@nvidia.com>,
 Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Mostafa Saleh <smostafa@google.com>, Daniel Mentz <danielmentz@google.com>
References: <20251117191433.3360130-1-praan@google.com>
 <20251117191433.3360130-7-praan@google.com>
 <6afc3e46-489e-4741-96d5-8a2f72a8b431@nvidia.com>
 <aWS10XTF20qqvnBf@google.com>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <aWS10XTF20qqvnBf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::7) To BN5PR12MB9511.namprd12.prod.outlook.com
 (2603:10b6:408:2a9::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PR12MB9511:EE_|MN0PR12MB5954:EE_
X-MS-Office365-Filtering-Correlation-Id: cacc6d7c-a1a8-44f6-3b7a-08de52617a4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0F5SmFFajNxT1d3djJxVHFlQkRmRUxDSjhvL3cyNXZCN09POWtTUDk2UGV3?=
 =?utf-8?B?amJFL2ZVeldxRkI5WUNoa2VUMEIxTVZIam0rRkI2QzM1M3czbndBTjhtSE9V?=
 =?utf-8?B?dVFoY1ozQTdmVlpvZDIvOVprVXlMelk2NTdMZEFQTXlDL0hkUlphYTJDcU9M?=
 =?utf-8?B?VTk3R1ZQN3luTytxUkxnSFJJQVViVzlodGs0dzBBVEtsN2RhN2tZVnNzWnhX?=
 =?utf-8?B?U3YwSEdaUjdwMkNRZ09BbUJRNG8rNUlmT3F6VkN0SzBETVZIY0NlUVA1MmU4?=
 =?utf-8?B?WG1veW5CWnUwbGsrOWFiZjI0VUtTUzdzWmtqS0haSXp6UjVhRUZxTktzYXhZ?=
 =?utf-8?B?MXZRRWhsTk43VEJKTUV6UGxzaDR4SHJXN2lpNHJhRE8zUWorT0hQTU9FTGtY?=
 =?utf-8?B?a3FLcEVFaUlmQ3BBdnBMQm5qNS8yZG41bUJab1BzSFJuWUNXRlF6YjJBeksy?=
 =?utf-8?B?OHFmTEh4RkFKOFFrOXloSCt2Rk54MUFqaWFlZlllaUNxMHZXcU1BYUg0MEFH?=
 =?utf-8?B?dTEzR0ttRlViMk93ZVUzdnY0R2p6d2krWTRQS3dTQnNZY2VqWE9FYTdQTGhG?=
 =?utf-8?B?eXFLL1E3ZlkwdEYyclVzK0w0WG03UklSaHMwZEw3RjF3YWZGbDdwcUxoMFgw?=
 =?utf-8?B?emtyNjN6WG1zYTJ6Tlo5eHpwNjNoRDFmTHlvU29FT2pMN056bWxqaVR5ejVp?=
 =?utf-8?B?Z2htVTNmSVp3Y0dKKzd6Q2JFby9weER6SlhQWWU5eVQ3UlkxU3ZNMTh2Znhr?=
 =?utf-8?B?dVFKR0hOSVk1MGo0U0xFb2w1QTkvcTFhQVpwY2xycS9kajIxT29SUzlqSVhu?=
 =?utf-8?B?VkN4V3k3aUp4VFpFM1owMzhON0NOejBrRG9LanM1TjhYcDFFdExCYnZYWGZP?=
 =?utf-8?B?K3gxdFJ3aldhaVZoSTFZeklET1JKVVZ1VlhOSDVtYkI2SVVJT3AyVWp2bXZH?=
 =?utf-8?B?VnlQbVN0RFRhczlUeHBWVjY4NktRbEQzekdFVTFDOFNnRmRQUk5pb3hKczN4?=
 =?utf-8?B?QUVocDhPMmJXMnhJQzN6Z1pBMVQxbjhTTzZkb3BkY1JpWnFuUmwvQTRSWjk2?=
 =?utf-8?B?amxSZ0psWjRSRUZRUnpVWndFSzlJRTc3d1Q0QURhRDlLZ1JZVFZGOHFqcWhF?=
 =?utf-8?B?OG90V1RYeU1vVXd6QnZVVEJzNTA4QW1FUmxIN3ZwcHBxcHp2YW9rUXB0cnJD?=
 =?utf-8?B?eG1ZcldvRFNNMHhsUjByZzlLOFJYVUs2NWhZd1orUWZWVmoxcGpsZS9uOWJZ?=
 =?utf-8?B?MUF3T0lEUkRnbUhESVlCWnVTaGV0Rm51RmZjTGVKSWNCWXdGWFF3ZG1PV1Mr?=
 =?utf-8?B?SG5wMklZN1NjMHFENCtLY3RoOUZKb0lFcXpvMWVDS2ZrejhoMVpUOG41MVda?=
 =?utf-8?B?MW1RS2xaYTVDb3JGZCs4MVlxTERPRG1HMFhCRHBRMVRYRmNaVDB4cUxtNHVn?=
 =?utf-8?B?RnY4Z2I2YThhaEtvODQ2SW9WQmNwd2JYbzczSmZzVlRwekE3M0V4MTYvaGdl?=
 =?utf-8?B?QU9rckl2LytzMjViOWhsNUx4ZEtDZUdwU2lYbDdpSnN2ZncyU0NicFZLblBs?=
 =?utf-8?B?dEdlS0tMY0UrYXkzTDVhcloxbVRIaVIwejAzSEQ2RmtzbWlGcVhkdkQ2aEZs?=
 =?utf-8?B?eklHU0U0NjE2N0ZBbDUvWFE3KzVmRmJuSkRWV1JpZk5KWEdVWkVZenVxN2xF?=
 =?utf-8?B?Rk9EaXhiRFB6eHQyc2pKK2JwMUIxblM4aWUwMTNNMjRVeEgwVHR6djJaWFM0?=
 =?utf-8?B?WWdwcW4rMFJaWHR4c3orY013Vit2SUxFd3N0SmhFUEZ6MDVqMi9VNGtka2JL?=
 =?utf-8?B?UE9LZXZDcHdiRUcrTk9Ya3dQYVhLUXFEQ0FMQXJidnBJUXNaN0VDRFFKRFMy?=
 =?utf-8?B?WGlHRlBjQ1hvQ2xpcW1JNjVZOTRmLzVMSE53UWhJMXMzRHMzNmlyUlR3YXl0?=
 =?utf-8?B?d2h3dG0vZnpFVlpmUUVjVmVmdmU5REhFNlRmRkJCemRnYXMxbmY1bTVJajdB?=
 =?utf-8?B?ZVZOY1UzL0RnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN5PR12MB9511.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDltc0FVYzdhNFFNQmhwYXJ5dktYZklQUWsvaGhoblFVd2liWFEzZjRMQ0R6?=
 =?utf-8?B?aGo5dnRiNzRmRWJiSE9Oc250eDBMNkEyZHNPUkppL1lpU3poeFllN0NGbUVM?=
 =?utf-8?B?ZnRwYTFyQkxLY0R3Wk8wSEpFQnJVZGVKcG40cTBBUjh1NDVuQ2ZxVmV0ejhL?=
 =?utf-8?B?N1dYVVJOU202ckl3djZJcGFUWW9sbWFtTVdoRFJxL1JjUmtJWk5INXlMdDFU?=
 =?utf-8?B?a0pURks4anBzUWFHTlFrSzlGTTRwSFNQdlo1N0RFSGt3NG1ienpGcTlBVXIr?=
 =?utf-8?B?dURwSEVDL29jampHMHZzakNTOG9oYVdGNTY1dWxoYURQRy9CckpmZlJlU1JT?=
 =?utf-8?B?LzVqdWdVdDJJVmFCWmwrWi9jYms0TmFtSjI1aUFpeWdaRWN4cThuZnNPTG9B?=
 =?utf-8?B?d25WdHVxKzRvaVpoSEtEZ01LUTFiM2RIWVo5aWs4MmJGVE1abFZOMFJKS1Aw?=
 =?utf-8?B?K2d0MktqZjZ6OWYrM3Z5Z2xwUDcwcFk3dmxhREdVYzkzSDZFS3hwOUFka2U5?=
 =?utf-8?B?WEZRMU16TGdBUlhUTGJEMXZvbDdrSnJVYnc4Z0FybjFYZnMyWTdUWEZGM05V?=
 =?utf-8?B?THlUTm16STZtVjJ3bHViR2tTVGJEc2ZMVTBOVXpMVFVPSUREMzJFQUI2US82?=
 =?utf-8?B?eHdTQXJqWnpoL25zNDJxdTd1cTdKQ2RqM0FTK1cwSjZ1UmQ0cFJkZzJKN3gr?=
 =?utf-8?B?a2c1V3MzbSs4c0JoeGNYY1hPYlRjOW4yb3FaUFJCTk1DNDdJMTR4eWRoTXRa?=
 =?utf-8?B?dGNJeHNQSUxxdW9CNW82djE1eUd0YTRiK1MwYk5UMGJ1OENBRG1GUG91Z0JL?=
 =?utf-8?B?b1FhRHZSVFFwdVN0c1YrcHE2VWMreG5GOW1YRnQzSURGbmJ5ZHpLZnNuQXN5?=
 =?utf-8?B?Z1EzK0ZYYyt0NDBMcHpMZnVKU1JHMUxoc0lsdTVoY1NrUFdFUVVJVE93Z294?=
 =?utf-8?B?dXpOb0dQaGhONXBLK3hPK0hlc1A1NDBPQjRFR3lrcVdpM3ZhbUdUSyt0SUFF?=
 =?utf-8?B?NTh4SmFVUmRIMVE3NzNibkpwMWFPVnFPRmN6WmszcTJ0YlpTeEZLb0tlZVZ4?=
 =?utf-8?B?R2ZTTmhWK1lsY1BFU3RqVlNnK1ZDTzZqdHFaa1d0OTJlUDNEV0IwcDRPNTRh?=
 =?utf-8?B?UTE0NSswVGhqL09MZGNHQjRxZUwycDVZMDBlS0JUQ285M1lCTDRKVmQwSndp?=
 =?utf-8?B?NkJzZTZlbW5KUDZaNmE1UnZjVCtnTjd2bi9OMi92VUhML1NKTktmQU5UM1V0?=
 =?utf-8?B?RWhLWGpsMmw5RDB1cUdLY25vU1ZhZ2I2ZVNuWkk0VUwycTQycThUM1l3Ukxr?=
 =?utf-8?B?d3R6b3VPYXZ2NC9YQ1JSbUNNQjhybjNnU0JlaDdIMWd6QUt2azNsSldUY3Bu?=
 =?utf-8?B?OEo1ZVBCanNHbXNkL3FQM2N0dHBpOWJhSFZ3dHFVdW0rSjh3VTAxcHBVOGYw?=
 =?utf-8?B?TWNZQjAybU1oZXhpZDl2bVBPNDBnempoREFyZ0JDYnAzaVY4MllqSjdLZklw?=
 =?utf-8?B?ajFoVEh5amVqRUhPcFg3NTVYOWUvODR4ai9DdVEyd2oxMGdwdWhWT0dKcWNO?=
 =?utf-8?B?c3RvZFVqM1hnT1JBQkx3VkZNQzQybzNQQkZsNHZnakNDcko1WlVNTC9xbHRV?=
 =?utf-8?B?TTZtd3ZMc1U1WkVXaTJoODd6TG9xR1F6RzdJS1RibGkrQ3l5MW9lYTgzN2FC?=
 =?utf-8?B?WUdxYjNWSzhnM2lGWTM3SEMrdEJRazVkL0NVdHJSL2pzdGFEeWhPYTBxbWFR?=
 =?utf-8?B?a1pLRmQ1TDM3eXZ2SHpVWjFXR05zRVQ4VEQxL3NhekFRRDBjdE8xZjQydlZk?=
 =?utf-8?B?WkpPVGZmUjN0d2gyL2UxbkxvL0J0ZlJ1c2dpMkhobVByTlcvTDAzNnZtMXJX?=
 =?utf-8?B?NlJoWXVwTFIzZktTeGYxSGpoREhhWmZBaGRKOXFqK0N2TXZiN0l2Y0xCRUha?=
 =?utf-8?B?ZTFuMGFUV01BK2NSUWk2Q1g2V0hmZU5HTnYxbGEvYU1rZkhUMmQxMjFzK3Zz?=
 =?utf-8?B?QTlScTJPd2JxZjFYTXcwd0FMdTJuLytGd0NuM0EvVDU4UFhqZno4TjFYS2ZU?=
 =?utf-8?B?OGhVRWZwdGNZZzNGaEY0RTUvejBpV3RzTG9teUREbXNPQlY1bHk1ZzFyLzJn?=
 =?utf-8?B?T1hiNzN5VGNOOGlwSVZ3UncvQ3BwdG9rVUQrNW93U2RVYWcyY2JaczlTZ3RB?=
 =?utf-8?B?cUlGdllyQXdaV2V1c0lhQll1bGdQOHJFRjVjV0RLcEZUZ1RtY2hSY1BtQlRU?=
 =?utf-8?B?RGhQR1publQ4dWs2TVdjRExYcmp5YTVDakVqQXk2a0ZSSjdOa21mQTJkVzJ4?=
 =?utf-8?B?OWpTbVlIZFRmcnlsclF5QmdNcEd3Y1REN0U2dnhOWHJVN2Y4OExhZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cacc6d7c-a1a8-44f6-3b7a-08de52617a4e
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9511.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 05:06:15.3559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qP02HNIE4xr3hyFPDAoG8PHkh/eWskgQ2toRY5sT147gz9ifgYKdwjxYD+a+txefvdpTfgz9Q8QlKLsAVsPjyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5954



On 1/12/2026 2:20 PM, Pranjal Shrivastava wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, Dec 24, 2025 at 01:09:32PM +0530, Ashish Mhetre wrote:
>>
>> On 11/18/2025 12:44 AM, Pranjal Shrivastava wrote:
>>> Implement pm_runtime and system sleep ops for arm-smmu-v3.
>>>
>>> The suspend callback configures the SMMU to abort new transactions,
>>> disables the main translation unit and then drains the command queue
>>> to ensure completion of any in-flight commands.
>>>
>>> The resume callback restores the MSI configuration and performs a full
>>> device reset via `arm_smmu_device_reset` to bring the SMMU back to an
>>> operational state. The MSIs are cached during the msi_write and are
>>> restored during the resume operation by using the helper.
>>>
>>> Signed-off-by: Pranjal Shrivastava <praan@google.com>
>>> ---
>>>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 109 ++++++++++++++++++++
>>>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   3 +
>>>    2 files changed, 112 insertions(+)
>>>
>> Hi Pranjal, Nic,
>>
>> I tested these patches on Tegra264 with CMDQV enabled and 16 vcmdqs
>> assigned to guest. I found an issue in resume path of CMDQV.
>> In tegra241_cmdqv_hw_reset() function, the PROD and CONS pointers for
>> VCMDQs are being set to 0 on resume. Because of this, commands from
>> VCMDQs we not being consumed post resume and I got CMD_SYNC timeouts.
>> We need to restore the prod and cons indices for VCMDQs on resume.
>> This is similar to what is done for SMMU's physical CMDQ.
> Hi Ashish,
>
> Thanks for testing this with Tegra, I'll include this patch for CMDQV.
>
>> Also, current implementation uses pm_runtime_force_suspend/resume()
>> which requires runtime PM to be enabled, but runtime PM is only enabled
>> when dev->pm_domain exists. I had to use dedicated system sleep callbacks
>> that directly call arm_smmu_runtime_suspend/resume(), bypassing the runtime
>> PM dependency to get suspend/resume working on Tegra264.
>>
> Thanks for pointing this out, I'll revert to the approach I had in v1:
> https://lore.kernel.org/all/20250319004254.2547950-4-praan@google.com/
>
>> I got it working by making following changes on top of your series and
>> validated that after resume all commands are being consumed and SMMU clients
>> are working fine:
>>
>>
>>  From 8ead50a7e2fbdfa30fbe2c927c47a440b447c864 Mon Sep 17 00:00:00 2001
>> From: Ashish Mhetre<amhetre@nvidia.com>
>> Date: Tue, 23 Dec 2025 08:42:31 +0000
>> Subject: [PATCH] iommu/tegra241-cmdqv: Restore PROD and CONS after resume
>> X-NVConfidentiality: public
>>
>> PROD and CONS indices for vcmdqs are getting set to 0 after resume.
>> Because of this the vcmdq is not consuming commands after resume.
>> Fix this by restoring PROD and CONS indices after resume from
>> saved pointers.
>>
>> Signed-off-by: Ashish Mhetre<amhetre@nvidia.com>
>> ---
>>   drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
>> index 378104cd395e..00ec684fe3a4 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
>> @@ -483,6 +483,8 @@ static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
>>
>>          /* Configure and enable VCMDQ */
>>          writeq_relaxed(vcmdq->cmdq.q.q_base, REG_VCMDQ_PAGE1(vcmdq, BASE));
>> +       writel_relaxed(vcmdq->cmdq.q.llq.prod, REG_VCMDQ_PAGE0(vcmdq, PROD));
>> +       writel_relaxed(vcmdq->cmdq.q.llq.cons, REG_VCMDQ_PAGE0(vcmdq, CONS));
>>
>>          ret = vcmdq_write_config(vcmdq, VCMDQ_EN);
>>          if (ret) {
>> --
>> 2.25.1
>>
>>  From 51a11812bb40d341e11233129a01ce248957bd25 Mon Sep 17 00:00:00 2001
>> From: Ashish Mhetre <amhetre@nvidia.com>
>> Date: Tue, 23 Dec 2025 09:30:04 +0000
>> Subject: [PATCH] iommu/arm-smmu-v3: Fix system suspend/resume when runtime
>> PM
>>   is not enabled
>> X-NVConfidentiality: public The current implementation uses
>> pm_runtime_force_suspend() and
>> pm_runtime_force_resume() as system sleep callbacks. These generic PM
>> helpers are designed to bridge runtime PM with system sleep by forcing
>> the device through the runtime PM path.
>> However, these helpers only work correctly when runtime PM is enabled
>> for the device. In arm_smmu_device_probe(), runtime PM is conditionally
>> enabled:
>>      if (dev->pm_domain) {
>>          pm_runtime_set_active(dev);
>>          pm_runtime_enable(dev);
>>      }
>> On platforms where the SMMU does not have an associated power domain,
>> pm_runtime_enable() is never called. As a result, when the system
>> enters suspend, pm_runtime_force_suspend() effectively becomes a
>> no-op, it does not invoke arm_smmu_runtime_suspend(), leaving the
>> SMMU hardware in an undefined state during system sleep. Fix this by
>> introducing dedicated system sleep callbacks
>> (arm_smmu_pm_suspend/resume) that directly invoke the existing runtime
>> suspend/resume functions. This ensures the SMMU is properly suspended
>> and resumed during system sleep, regardless of whether runtime PM is
>> enabled.
>> The pm_runtime_suspended() check ensures we don't double-suspend the
>> device if it was already suspended via runtime PM during normal
>> operation. Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>> ---
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 20 +++++++++++++++++++--
>>   1 file changed, 18 insertions(+), 2 deletions(-)
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index b1c9c733ed8d..4707adc63d86 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -5180,9 +5180,35 @@ static int __maybe_unused
>> arm_smmu_runtime_resume(struct device *dev)
>>          return ret;
>>   }
>> +static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
>> +{
>> +       if (pm_runtime_suspended(dev))
>> +               return 0;
>> +
>> +       return arm_smmu_runtime_resume(dev);
>> +}
>> +
>> +static int __maybe_unused arm_smmu_pm_suspend(struct device *dev)
>> +{
>> +       if (pm_runtime_suspended(dev))
>> +               return 0;
>> +
>> +       return arm_smmu_runtime_suspend(dev);
>> +}
>> +
>>   static const struct dev_pm_ops arm_smmu_pm_ops = {
>> -       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
>> -                               pm_runtime_force_resume)
>> +       SET_SYSTEM_SLEEP_PM_OPS(arm_smmu_pm_suspend,
>> +                               arm_smmu_pm_resume)
>>          SET_RUNTIME_PM_OPS(arm_smmu_runtime_suspend,
>>                             arm_smmu_runtime_resume, NULL)
>>   };
>> --
>> 2.25.1
>>
>>
>>
>>
>> Please see if these changes make sense and squash to the series if they do.
>>
> I'll include the CMDQV patch from you as is in my next version and
> revert to use the SLEEP_PM_OPS as in my v1. It'd be nice to have the
> `Tested-by` from you for the next version too!
>
> Thanks!
> Praan

Sure, I'll test the next version on Tegra and provide feedback. Thanks 
Pranjal!

Thanks,
Ashish Mhetre
