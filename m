Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F4C210EC
	for <iommu@lists.linux.dev>; Wed, 22 May 2024 18:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716403210; cv=fail; b=mnGwC8/sZNND96zkoJMmtXb0a4xf1b0wf7glYxUTUT1skRLG/xFwC7XFdvIz+HyNBvHETv+k+LwCZiiIFpgqnApALBBRgXeeLPN2XV958ep0AjdByN+VH48MpHtAK8gGhKeRTTqHx/TcDQZYdchEvN54GfUyTZLNfAh/BsFvyK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716403210; c=relaxed/simple;
	bh=s+qNFCo1+u7ZhtRHReXiVdAAra/xG6dpYx9hYceA6TQ=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g6zN6Jk4Gdz2TSo4ajTcnwDfmiRzjMmNM6Az5/nnkRtcBCHOH6q++2+mB2OpeGInmQ8qN8n+gkR4+t+DheXAF+/NRPfBCj7xGqFkZygc/LaIrfF4t8Snil3adNOl7deN0TuiA4RvLW87IHe3Bf/F5R5johB6ouztC8ItcjTklyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hKPtRET4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=APe/M2um; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hKPtRET4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="APe/M2um"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44MHYtdM025928;
	Wed, 22 May 2024 18:39:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=3Ed7vQjplJycedrHuQbT9fTRBG+fkYQiB/3GSBj+hzI=;
 b=hKPtRET4ZWNzmkFPfoDPEQGy/PW++4ISmLLKh29DdK2VhjLedjCbUB0l/4V2WINaDR6q
 L/2nnUiqUVzHfj69d/4C5gBjisPIm/cu3B5PlHGXZok0t4tPw8LsKipvsCIWHeCxiIGu
 YFNmQF9lIXUMGvREnvq5u3YGz1NJx5td8xHAeWMREDTxbPfZppyuDTwIvfGMobTJn82z
 +9QpAgCj67olBTw/ApSvun0Ywz94ekGdU5AqUk0HSSgLWVDZB38cit1yFQJzyjPjiBHv
 53P7xErSx3HSgnfgB7d/TymOs6TSEHGjYa4BXaXGOy+aGvnZuu4tKHcoeTQNgN7WJQuB iQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6mvv8ddc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 18:39:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44MHtsR4013935;
	Wed, 22 May 2024 18:39:41 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js91w54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 18:39:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVZroJCWoQ8KLwsKdl2dXkbE+RXcRPbFu6vF/kTvoBxORekgz4GKKuTLHhJ1YBqiUNcys+ReD4R5OZq48wHHuSbpAHRTv5BA97XxbHk4ZoOsPvMzj1YhZ3Lm86hQAUnCSg+Q3LADaDIEWD6cvMftZepp1V0jJAbrvpumg9r+Pcf4imXS3/PgPX73Z3dNC3UNpUIxo7OFxWq14/cmd1E16nsV2cengXIdEi5pJfpmDrkU6aoM11zMmEI8kECNMvKPAxW+I7an2sxrFxwlijbjT/CEuMldKnnNouwLiuNrejcqPf7LDRwzK2PqvIH/dAsbogNp8rjQfof7WoWG4vU8Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Ed7vQjplJycedrHuQbT9fTRBG+fkYQiB/3GSBj+hzI=;
 b=YmQb52pk+S5Mj2V24orokmRSTQzmHT1Ne3fy46HaYsISykNuZiiaCca6rDd4iyIZp2My+USkaj7ekThGedkR3H9DoLIH9kJwK+2PNHZFXkHg3L1jtogIWXDlkn9jLHtMG7weEeqErbkn3WQ+gQOgOeP1gJxmc+m22b+vSigzKg7cLVdayFkrxIxXglu5t0s2B9hLko2XWdX7Os5mjyiBybrXuQsbvwbMtRmNi23yoEaKFX3kCTa1GxwyFLDiBb1UMGBcdtt9hby1wTSwAOx2QXChQn28WpFJLmMt66kDMBu1UreQunr2VuP/tBUjvpckBEli/lDREVwJAy8m+DdXDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Ed7vQjplJycedrHuQbT9fTRBG+fkYQiB/3GSBj+hzI=;
 b=APe/M2umE9v/ziqszdPuD/LTTLK1Go2a4llhPJvfCcI4O6kSwnZS0/8cxCgQsS2g4sFlyrqvdQAlnaCryHsSHBXv/OgBjDUMTSndxsbegPQ0O65qzEej1mkEItq5iOBG0W0FtzvuWUlu15AJ1tPfx8LoQrq7EgDqwlP2Ss4Ng/M=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by SA1PR10MB7684.namprd10.prod.outlook.com (2603:10b6:806:38e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.34; Wed, 22 May
 2024 18:39:36 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%4]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 18:39:35 +0000
Message-ID: <9701b23f-7494-4dfa-8267-34628346c91d@oracle.com>
Date: Wed, 22 May 2024 19:39:28 +0100
Subject: Re: [PATCH v3 2/4] iommu/io-pgtable-arm: Add read_and_clear_dirty()
 support
From: Joao Martins <joao.m.martins@oracle.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "mshavit@google.com" <mshavit@google.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        jiangkunkun <jiangkunkun@huawei.com>,
        zhukeqian <zhukeqian1@huawei.com>, Linuxarm <linuxarm@huawei.com>,
        "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20240430134308.1604-1-shameerali.kolothum.thodi@huawei.com>
 <20240430134308.1604-3-shameerali.kolothum.thodi@huawei.com>
 <BN9PR11MB5276ABF99FDF6CF0F863501C8CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <13e93238f21b42539097d7e347be684e@huawei.com>
 <4618c24f-aaa8-453f-aa9d-67a864e1c93b@oracle.com>
 <20240522165640.GD20229@nvidia.com>
 <cb2ab7ee-9e31-468d-85cb-71e70d7a7e0e@oracle.com>
 <20240522175053.GF20229@nvidia.com>
 <914149e9-41cb-4ec1-a765-746a17fe4a12@oracle.com>
Content-Language: en-US
In-Reply-To: <914149e9-41cb-4ec1-a765-746a17fe4a12@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0377.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::29) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|SA1PR10MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: f6d2b8b4-c510-41b5-6bb5-08dc7a8e875a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?amlJRWF5ZnNKMy9rSmJ2clg1QnBseFJ0NnpmaUhMb0R2Vk9URm5aOFZSNStL?=
 =?utf-8?B?Qkx6aXJobUlSTklBK2VVeUJqdnZqYlBISFUwL29QM3ppRnJ0b0RXK0lBOGNu?=
 =?utf-8?B?L1lGNWtwL3FDZGhjR3FnREdyVGtsNURXbFdlOWVEM0JLR0c5TlViVjlja25l?=
 =?utf-8?B?UnRIb0NqZFNjY0k0WVlaNit6Kzc4THBGb3hzemNlaTZjVUJDUG4zeldqWW8x?=
 =?utf-8?B?N2c5ZlZOZGluQjdDcDNJY2Y1VzBhZnFsMllCYzF3T2RpRTc2dk44ZzRMWmFu?=
 =?utf-8?B?MnpKVUNjVzl6ZXNIVmVzckFHdzdDaVByS2l1WUJ5RUt3VzdvVlpwaHhmNytZ?=
 =?utf-8?B?bnRsbmFFdmNmUmliSGlQbDJDSWdjaGxRVkFBc1Z1NHBGdjl4MHFOUk9DbTZI?=
 =?utf-8?B?ZWpiTUVKMklrRWYvSzFhdTVyU0xubzRCTjFnKzRhc2JOeWVnamd1N3Z1ZnRl?=
 =?utf-8?B?aXltTnY4ZGtxVDI2dGtFcGVaWlp0T2N2N1pIUFVwSnRtVm12THcrNmNGZEVv?=
 =?utf-8?B?WGJkVXh3Z1daSG1hb0Npc2UvOUU1NFVrUGIrTmQrRTVOaitUdjVpMmFBNFkv?=
 =?utf-8?B?bXZGNnJxTElPdHFhZ1RzWm9TYkNTM1lkWFN0UiszOWxZZXNacWhjVkhPdFV3?=
 =?utf-8?B?STdtRmNoQlUyRkJ4cHZRQTZXOXp2UmVxYXBZdFR2dmxPTitWMU95aVdyRkQ4?=
 =?utf-8?B?ZmlBZFN3ZWVWRklCZEZaTzRUK2Z3TnhpMm5qYVMrM2tKaEJrNkF4RzVrdVZU?=
 =?utf-8?B?UE55RUlLVFdPWk5UZEtiSGpQdXM3UXEzejFMT1FiUTRvQm9FNUJVL0J1cmw5?=
 =?utf-8?B?Q3hISmRoS3EyMDZoN1pLd0pERzRkbHMzWUdRWlc3cFRxM1hpbHZUbmlyTnRw?=
 =?utf-8?B?bTBrcGx1UCtGUVo3QjY0Q010a29WNkFXc05kNUtOWFNQcEJpaXlMMXZaUGFj?=
 =?utf-8?B?bG1SdmxWWEhWRjNVR2lGaFVVbVdJTkhmUVpqRkIyYS81VkhTZWlVYVRNcFBi?=
 =?utf-8?B?Z0RrekpSLzRlOVQ3eEYyK09KR3d5VEFNUkhpUWttQVZvdlNpaUVhN042L2Ix?=
 =?utf-8?B?Y0l6ZnBaMDdSM0FhTWE3NE5nYndpK1g3OGY3Um9uR1Z2RHlCOERJZkhpT2FH?=
 =?utf-8?B?SGE4WnM3a0Y2bTJocWlzYjhEOVpCc1FrWHBEcjZsOXNoZ1FGbW93dHAyU3Zm?=
 =?utf-8?B?cnZxS1pxTkYyVmZtTWNTTnVRL2JXbWxBejZCTWhINU5sTHFRU25aRjNaWXFp?=
 =?utf-8?B?bTBCUjlqcUFGTzFQR3h4R2s5UGpPaGN1M3lZUXk5TG9rSTIzaFlGNkdpY2dj?=
 =?utf-8?B?RFVkNGFYcUVOYlRTMVp5TGJETDEvbjFqTEg3ckJBUlUrMmlKRFZNSE9keWln?=
 =?utf-8?B?KzU3eHVZWkF3UWdSdWt6YjJOMlRGQUludGdnVFNkSmFuOUlldWR1aERGcGlD?=
 =?utf-8?B?OGxjOFI0UVRzR2tscjBMME1hU09YdHV4K0taTnh4RjZobUc3bDRabjVqNUZN?=
 =?utf-8?B?ZGRxbjZHQS9pUERCbEVqSzVhVlNWWkRpODZFKzB3UnZpOVVyY1JZb1ovdmVW?=
 =?utf-8?B?cDJvUkMvRlZoOW9ScTR3cVdZNVJIVytEdS9EaG8xSnRUWWhFdkJNaWE2Vy9T?=
 =?utf-8?B?cHplZngyd3pCMjFNbEk5SHlSRjZYT1p1U2Y3UzQzTDdYdjh3UFltcHVLQURR?=
 =?utf-8?B?a0lPL2hvcDFLME93UWdxbkF6RGdQK1U3Mk9ZZnNLWXdPa2YwYmRUdC9RPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5893.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Zy9CQ2JDNXlicnZ2ei8yREs5bnhTODdndndzdW9pdGV4bzErWU1WeDM2ZXdI?=
 =?utf-8?B?OWFMM3hQUTI1by80dmNLSjlLR3NxdlU2T2lpYzVNc1YxaDlTSzI1UDNyZ0dj?=
 =?utf-8?B?UU9nMGFJaStCcXQxT0d4RkxZem82QmdVZGtMRmVEcVZTRC9ibVZ5OUZCN2c5?=
 =?utf-8?B?TS9zMG94WUlaQ3hQK2RZVDlLSEdwNmpOVFlNY3Q3TXB5cWU2dENmWXRZTi8v?=
 =?utf-8?B?YmE5K0s2ZnZ3MW01QTlBZCtPcFFvVVk3SVU4OG44bGExWmZvV3F5aWlrOUR0?=
 =?utf-8?B?YTgraEhSUDgxQTgyTncyVWdaMHZ0MGg2QnZIazJHL2k3Uzh4bUhWRVZqZ002?=
 =?utf-8?B?cE54Zm9MSllJUU9JaWlocXRRc2lYYzV4dHRTQmpPeHZDWkR1YjFZRFdHWlh5?=
 =?utf-8?B?RTd0UXFOMDJyaDZienYxYVErRUkyWVFCQSsxNzBYR3hvb3VNMjEyZ0ZacFVT?=
 =?utf-8?B?QTZodURmWTJQUE1BN1NrSHJHbHRJc296Q1dhQlIzd2tKU0s1SFpqRDBLMGlJ?=
 =?utf-8?B?Y3hZcE42eHZQL3IzWkJPVVNPRWVuRmhvSGM5M0JrclppL0hyZkV0dUpKdzN1?=
 =?utf-8?B?em5SKzJYT3gvVFVrcHNnVmhQYTFaWXhQekN4SlV5aWV5TlVzWUlha3U2Ujgx?=
 =?utf-8?B?Y0R5T08xalorcjduYWU2SWxFRkN1cEg5aHBOUnM1OEFBVGpCK2k1NHhMUVdD?=
 =?utf-8?B?NW1wakJXK2l3dFVhQkh2V0ZXakdxbUMrNVdzYVEreTVQRlJaWUpEU2orbTVw?=
 =?utf-8?B?Z2dvcGNYaEYzU051NCtRdDFsMm4xUDUveXdBdXVSN20zcjBDTnNKV0FKZzY5?=
 =?utf-8?B?cXR3SzNPV1FOam9WejIzaEZuWE5qWDgrOFhvcUVKWGhGeVFLNVNxcldvYmJl?=
 =?utf-8?B?L2lCTGErcWp0eXROalE3M0VTTGNsRi96V05HbkJJdk5oeXJOOTBaTEhVdkN1?=
 =?utf-8?B?aVh0cXNoVS9NamVWYzJsQWZwZFZ4amVibzFpTzdZcnZ2R3V4Vi9yTlgzY0Jx?=
 =?utf-8?B?SHJpRkNFYStDaEtuQzlGQWZNOFpMcDl3ejhUTlowQkFPS1pnWFZ3R2xRUE5a?=
 =?utf-8?B?Z1BLeFg4ZVVraVF4SENyWnBWZDhMREJETU5yZEhoT2NNK05VVzJLeUt6dEly?=
 =?utf-8?B?cjhXdDdmWmg3ZjVqVmIyakNwQVIrZWlHMDdoUFEzaUc0VkxSN0pzZ3B2dVJ0?=
 =?utf-8?B?OTB0cHA0V2NwQ1djZG5DV1hxb3YwUkhsUVA1eUorc2t4eUc1cVM3bjdOL296?=
 =?utf-8?B?M3VQVG1Ya0o0OWg4ZlcrOGpjK0FyYmlwTi8zMHNVT3F1bjl5ZDRTdWp2bFFN?=
 =?utf-8?B?N2tKWUNWRjZJeTN0KzFuVStIZkJTRWJ1WldQSzR0aW9RMUMwdHgyYVEvU3k3?=
 =?utf-8?B?WkJSaUlmN1RWdVRjWEl6eXZXWk5oeHpHVSs0MzJsU2ZzTjA2Ty9NYVk0dGl2?=
 =?utf-8?B?VVFsQVF0SURPK2dzQUM1akxoMWV6ZFBYTTlmOWdOd2l0c3h1a1JEOHJxdnFv?=
 =?utf-8?B?amV2WEFVemxvb2xNcFJCR0krdU9ZOVlJdHNrY0FRTUJySE1ZYlB5YS9zMU5o?=
 =?utf-8?B?WlBOQzY5WnE3STU4dTBGSUN2N2FyMEpJOWtwVTZ5eTdmbVZZZ0h1VHF2dmJW?=
 =?utf-8?B?azlpQ1NzeXIrNis1ZVpCVU52MXVkTXhTY2FpT1ZiQTQ4SDUxZkMzcnhZRC9S?=
 =?utf-8?B?OThvVC9GSWZXbFBzOUxyM2FrMTdwMlZzNUtHR0VLeGhndXpPTTdxWWxBOTgx?=
 =?utf-8?B?Q0NKakRIckNSK1g3OGtLUUlGOFlJK2RXTm5OelAvTk5vdzRLRHdXVGNBblkz?=
 =?utf-8?B?ZHBqbDhWYmw1NmpUL2lPMUpJcDMxVGUya0MvQ3AvK1hiOW5PVmJPMmJMd09Y?=
 =?utf-8?B?SUx4OXhjQlh4Nythb1ljaDgvM2hrUlpScHo3OUxydFBobU5yeHNIcC9QR2dv?=
 =?utf-8?B?bTRGQTMxVUZkQlpyc0cvZWZVUDBsL2s0cmVLOXRqeCt3NkZHQ3laL3ZQdUJi?=
 =?utf-8?B?SmdaUUlCK1RmRFBSS2VlUE4yRUliaVdjVHBaY0MxZTErOERPMnVjUm9UZ0xB?=
 =?utf-8?B?UVhzNEY2eXFZMFZSUm9VQytNYzY0WSs0Y3YvdWNCTFVralFxd0hKQ0VzR0hB?=
 =?utf-8?B?cHpXMzBmckpYMzdNN3FadjY5aGw1UGNSVU1FYW9TdzdFeGVBNlErRXJKNzU4?=
 =?utf-8?B?ZUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	AfUKNa4s0wbAtT/QsMebuKmadkyvkbEYV9xIrrzVTW1ybdpd+KZTwdpKu5NF2e2PvGuQt57drj75IC5e3rdRzj8E51yH6uYPjmtFIUTa3gwOrfcWnH5WTFXl1fDYLbGmpf7kkrhG82hrUH5XowxG7cp7nJPc69JG2u+YUrZWMPkOBbI/dV11tEzxo7YJ6tT+LAG9iIf+3qRqyLy307rBIqDsXCZODsqTV6Pjm/rrvPrkrM7hvsxkRlU5K16dg9MUpsytNP1xOOaKjZj5Uxp2rP/CunAm4xnjukRjEsvvVxunWpgXryDVZnavQp2AUG9qA7T6oyQDIYnBu+7l/IR5L6I2bHi/Etygfu5232UjwPdXK4/hOC8NyvM6xnojLsnBMbvUohwHjtZm2jm7yE1qjNy8YzWNEuPNWOcqoCvx+hUpaLJs1YzCn04Noy3wjCqXc1Jg7KnNs4FhZOKncCwhseFuUJpLkxz6Vth3hIOEOUcUgd6sILrYNrrA264QJWHz1ZuehX2n9FM+W3BGzwa7A6RUXgTevWSStgesS7VFUks/0eXZiiZi+bgFC03FBhNzjCMNPFslYagscF+r7Z/NltiCvd+Qkjgl6HB7e3WbrQ0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d2b8b4-c510-41b5-6bb5-08dc7a8e875a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 18:39:35.8088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7sIz1R0f2T83DE3EBJvgCqcl6/kFaqssTeLB1XF9VT8NKP9Dc1lPPrDQK/H89WYRwywOMQvvnwg1LfELX7aMxaYyXNpJq30lhK43eyDZLoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7684
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_10,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405220128
X-Proofpoint-ORIG-GUID: sJzjXkT7IJfnx2QQotsePm20loGe2miV
X-Proofpoint-GUID: sJzjXkT7IJfnx2QQotsePm20loGe2miV

On 22/05/2024 19:15, Joao Martins wrote:
> On 22/05/2024 18:50, Jason Gunthorpe wrote:
>> On Wed, May 22, 2024 at 06:10:59PM +0100, Joao Martins wrote:
>>> On 22/05/2024 17:56, Jason Gunthorpe wrote:
>>>> On Wed, May 22, 2024 at 03:37:57PM +0100, Joao Martins wrote:
>>>>  
>>>>> This is just to catch the case where IOMMUFD can call into read_and_clear()
>>>>> without dirty tracking enabled and without a bitmap structure to clear dirty
>>>>> bits -- in order to ensure a clean PTE data snapshot after start(). 
>>>>
>>>> Is that broken then?
>>>>
>>>
>>> It's not: The check errors out the caller ends up calling read-and-clear with a
>>> bitmap but without having started dirty tracking. the iopt_clear_dirty_data()
>>> passes a null bitmap, it goes through and it walks and clears the IOPTEs
>>> *without* recording them in the bitmap.
>>
>> It is not "without recording them in the bitmap", saying that is the
>> confusing thing. The purpose of that 'if' is to return -EINVAL if
>> dirty tracking is not turned on and we query the bitmap.
>>
> Right.
> 
>> More like this puts it in the common code and writes it in a more
>> straightforward way with better locking:
>>
> Yes, This snip you pasted would be the equivalent to the current way indeed.
> Looks good
> 
> I think I was trying too hard not to duplicate 'state of dirty tracking' between
> iommu driver and iommufd core that I unintendedly ended up convoluting with this
> check in the driver :/
> 

To this point above (...)

>> diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
>> index 05fd9d3abf1b80..d116179809042d 100644
>> --- a/drivers/iommu/iommufd/io_pagetable.c
>> +++ b/drivers/iommu/iommufd/io_pagetable.c
>> @@ -536,7 +536,10 @@ int iopt_read_and_clear_dirty_data(struct io_pagetable *iopt,
>>  		return ret;
>>  
>>  	down_read(&iopt->iova_rwsem);
>> -	ret = iommu_read_and_clear_dirty(domain, iopt, flags, bitmap);
>> +	if (!iopt->dirty_tracking_enabled)
>> +		ret = -EINVAL;
>> +	else
>> +		ret = iommu_read_and_clear_dirty(domain, iopt, flags, bitmap);
>>  	up_read(&iopt->iova_rwsem);
>>  
>>  	return ret;
>> @@ -580,7 +583,11 @@ int iopt_set_dirty_tracking(struct io_pagetable *iopt,
>>  	if (!ops)
>>  		return -EOPNOTSUPP;
>>  
>> -	down_read(&iopt->iova_rwsem);
>> +	down_write(&iopt->iova_rwsem);
>> +	if (iopt->dirty_tracking_enabled == enable) {
>> +		ret = 0;
>> +		goto out_unlock;
>> +	}
>>  

We have a similar check in set_dirty_tracking iommu op of intel/amd iommu
drivers that could be removed. Though I am not sure it's right to remove it even
as we move this up the stack

>>  	/* Clear dirty bits from PTEs to ensure a clean snapshot */
>>  	if (enable) {
>> @@ -590,9 +597,11 @@ int iopt_set_dirty_tracking(struct io_pagetable *iopt,
>>  	}
>>  
>>  	ret = ops->set_dirty_tracking(domain, enable);
>> -
>> +	if (ret)
>> +		goto out_unlock;
>> +	iopt->dirty_tracking_enabled = enable;
>>  out_unlock:
>> -	up_read(&iopt->iova_rwsem);
>> +	up_write(&iopt->iova_rwsem);
>>  	return ret;
>>  }
>>  
>> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
>> index 991f864d1f9bc1..de3761e15cab54 100644
>> --- a/drivers/iommu/iommufd/iommufd_private.h
>> +++ b/drivers/iommu/iommufd/iommufd_private.h
>> @@ -52,6 +52,7 @@ struct io_pagetable {
>>  	/* IOVA that cannot be allocated, struct iopt_reserved */
>>  	struct rb_root_cached reserved_itree;
>>  	u8 disable_large_pages;
>> +	u8 dirty_tracking_enabled;
>>  	unsigned long iova_alignment;
>>  };
>>  
> 

