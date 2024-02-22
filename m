Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4D84596E
	for <iommu@lists.linux.dev>; Thu, 22 Feb 2024 11:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601926; cv=fail; b=KSJQnFaSplp9FGXk9yzwTXmbuMBHnjhITph5zX508rOXutsPADDxDXVre/YVUAoIQRGyPuW0TMzK0jZXDszZme86ftSAa3PegmyCEAyTjXIWQyVLCmcx5yu8ILO+IM+bOloFORD8jFVoAXYs3xTvu/jh67Di59BHXJONT/Br5GQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601926; c=relaxed/simple;
	bh=VfE3Nd7eFKi5a6BhgVWM8sfnB2YoZC6L8ReXxSiIiDI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jsbSuaeBi3N2yl1pXxA2IwvQZr1r+mLsbTBnjovV2lQTDmkYPDbETStn00BigO0Ubm+AlN4Ujf4FtavK4Qc+8whvDTA0xbMkxlK/bH6AoLBRWXLcqvjh+PWme0HUs4zsmXUMe2dKxUQS/VEgAZpbT7bKj5C6bEN/Umkhhu7lbn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eZlBgHi4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hFlRA/mr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eZlBgHi4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hFlRA/mr"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41MBY4in028019;
	Thu, 22 Feb 2024 11:38:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=UQBaHwldgYUgV/1BcxWmeNvlsbtTTJLIsUeFNTzYgFc=;
 b=eZlBgHi4zOtj9V6erPNHc6ljxeZGl1NCHi7ITrHX2E9ulwE0/d440X4llMkpz0IDow0C
 2G40aalKwM7Cm1XF7XOv4RTv5pSdhaTC/MrmW5odQF6qDTFh7YAzUX9m++aRB3ZtOeKi
 Q/z9C8l/yhQK/waQRjhKkE/B7rSumwK//9bLXvWVU1bXE9hUJyujxeB03u7c9zdsc0V9
 LY2Olvm0weopWCsssQj02wjyyNZx4ldsqQX8D/Ud3m95VeE66BR9vOZhzex0zlhfman4
 3DoP/o2KV9FjfgofXFYBxompnFu8HTW7hG1pJcud0ZcQN37dpnDxUS8Vb4a4T7b2TC3z wQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakk44ged-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 11:38:21 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41MB6YQ8012826;
	Thu, 22 Feb 2024 11:38:20 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8aw9u2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 11:38:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SI9T2WQfjq/6j7zEpdQ/K7U3aeHPSEc4/TH4gsoMTNC8QvfXky4/aXm3L9j0FB2m/cdy4Fy1fhEiCz+FTOYuuva+68yXqsfzmc78ooaI7G3DGEpNApP3ToDK61CyOd5GgYMGgqPWJ+Z3RAg0l+fk+IokMd+KQlvFA0ep4A03TYC4M5Wwv/fNiAHPY5T/3nKUlmRG/PmFWhcUWVdm1vzLc4ZiuyBR40LOptFl+AsrSD3A31Nv5jmPJgTCwO+6bZmZDnoTBlSom4N5oZNDxPKyN4yoHn+IZEeHl6oBpSCWXqdP4i+kvPmd8npgTpEtIsyFp9OCfC0oLfGJ3tC23oN7QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQBaHwldgYUgV/1BcxWmeNvlsbtTTJLIsUeFNTzYgFc=;
 b=NApFd+ZWN/b5rv7DApQshC14+pNiz7fzXomjLcdB2/MbFeq/kJbfd4NAJ4FTWBkHI9bSIG3zWtwk6IU1xi9DShRLCuUDuVyRvrx0b+/atLv0cMMyGOpvmJQ5TdHo4uQdImCaTp+kirQ9CVuTWGQ1BpGidxF1+42tUQCSIDfrj+sR/RfoBw07SeaJFKndNwbxUMFuv3YOICO17T9KCQYKv+328dtbJ1tvLTioFUDkPsPT6va3Gr9rk81gwQh1+6qKHy5qhdFrQOQhRMYCsxwLeoJA7Fdb6oJbMEjjnuM2TUmggvKQ5e5ToE7FewFSPxTIdbzX8wEeU91arecUJWHNYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQBaHwldgYUgV/1BcxWmeNvlsbtTTJLIsUeFNTzYgFc=;
 b=hFlRA/mr4dcEiALbFUoWw5XXMtFKWcZ1WZZCMtYU0wPf5W5fdYWvh6WTm8TamMFZgz2pyGITA0Kyu5iY/B8/0iMb9Ie8z2WJPp97sX+A2k66RwnrI9ska8/DB05e90dNbQwTB0OhmDqbGrGZU8OuZKR2xRor5uecg43TRQ9lc+s=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by IA0PR10MB6913.namprd10.prod.outlook.com (2603:10b6:208:433::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Thu, 22 Feb
 2024 11:37:58 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::3356:4cc1:701e:dde3]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::3356:4cc1:701e:dde3%4]) with mapi id 15.20.7292.036; Thu, 22 Feb 2024
 11:37:58 +0000
Message-ID: <5607ece8-ce00-4834-9ae9-f4aa16fc4886@oracle.com>
Date: Thu, 22 Feb 2024 11:37:51 +0000
Subject: Re: [PATCH v2 3/4] iommu/arm-smmu-v3: Add support for dirty tracking
 in domain alloc
Content-Language: en-US
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: "joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "mshavit@google.com" <mshavit@google.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        jiangkunkun <jiangkunkun@huawei.com>,
        zhukeqian <zhukeqian1@huawei.com>, Linuxarm <linuxarm@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20240222094923.33104-1-shameerali.kolothum.thodi@huawei.com>
 <20240222094923.33104-4-shameerali.kolothum.thodi@huawei.com>
 <a47699c9-4f3d-4cd0-94f4-f19e117ea6a3@oracle.com>
 <dfdc7daf8bd14b04b9bd29faaa1e6a96@huawei.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <dfdc7daf8bd14b04b9bd29faaa1e6a96@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0457.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::13) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|IA0PR10MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ba27f0c-a047-490b-1865-08dc339ab7d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	WtQ7GFdgb+x7g8mIXsN4nsFnqoG0tAjSJtIJjhcBl5CqZBjJvYa7CdpsSmGypO+dy5qBx99JPgy3mg1gv9p8jIpqwzUBN+yQykHSqruNMhaWiGvfhOmFr9w7xtDB43w3WNYCGOQ4NS0LAqbkOiiwhGRr5qtmvYfC9B1RGPlyrS0/Uq2A8ZI/Up2zu0AVTWzTRhQ2z7+rCqcaaJy81dZmo5CROF6OeA1+m08p4CMasRWBFP6UvRUuEgbfXe47NMvVcGObbMZg0aYw6lm5ipQntBkpcIBlzBiI0m2sAotC124OTm6UwzurhEJYWRKNXoZikxoWaIs6ZX0tsFqnY4K1wi5uiUxB687i6eTiliR2DCE192LndEi+oThbLoNtgcC8nE2ZJo2DznTcDGz2mlFdF1Wa2kiPMCfXyo9aJOroV6HKtio4kliRWpgOAVg+HS27T0jW+iRQUKCc38cxTZ6E//Bj+rHzBrpXjilwrxjk8KRt19Pr6RC9Mvwy5sqH/d/p7oY7va5li5VViUHYv3PhJvYmIEPpt2PYPQbGkbwiAIU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5893.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q3NkOURSYzJ1dTNZU2JkTGlaRFgvT1FBbFJ1Zk1DeHNVZzhVL2JFTkxMOUoz?=
 =?utf-8?B?aDhidUY4L1hmYW1SaGZkR2dRZTdHOWNiYU5CL3NjN3pSUERYUmltYWc0YTh2?=
 =?utf-8?B?RTlCMmo4RDQ4ZkpNMnlXUTdEQ29IU2plWjc3VCt0UkN5SDB4ZWZlR0JTbkVZ?=
 =?utf-8?B?eEJnbzYwSWd5ZzdBQVZFNGRXUDJCMkEzYUtNdjVlQ0w2ZFJHVFE0NWJuaDNw?=
 =?utf-8?B?WEtTN2duNGZUdDdyTERVSmJiT0xwNjFnSUxjRlBma2xpVGNuVlhpR1JmeEF6?=
 =?utf-8?B?VUNBZEZrTkxQNkVVd2pEWXBoMS9iSEtKcnJCYkVlMzdTVTB6V3lxbng1dm1R?=
 =?utf-8?B?TkZCS094NVpJY2s4bTFVanlwRXVBNWxSVVc2TlF1Z1V5N0hscWl5UGtSaE1y?=
 =?utf-8?B?YUZHNzZMRFpoaTFCYTNJMDZnMEJabS9ZK1hHUTM2TmhOZlJqbFJ4Q3hqQkFU?=
 =?utf-8?B?L3ZzandVcXJPSVJkbUY3UzU1Wm15azJndHZ6a3RiVjB1THN3ZTdZVE1aSzhE?=
 =?utf-8?B?QVZyc3RHVHNrdkJkc2FvUHZOb0NVNklkNWtPRjBXSVNRdUxPOTZlZzVlNlFY?=
 =?utf-8?B?SkJEV3o0TFowd2VzaDdGYmRBVFQ5WXJpN3MwOS8zcC92YTdvQmNxL3ZoNm5q?=
 =?utf-8?B?WGN0NTNQUWdyNjUyUzJEUmRJa2hONVRMbWdORi9BOWVTb0R4R3hXVGNldkhN?=
 =?utf-8?B?ZXNjQkJUZlMvRnN2cWVwUE5UUC9YNVczZVFJM0IxUWlldyt0NGJ5ck9laExv?=
 =?utf-8?B?N1BjcDFheVBJZ1dHSlE4SlVnbnV4Znp5NVVqU05mZzJ2QXNDZDNyejExOFl6?=
 =?utf-8?B?MHFTcFhicytLWCtWcGZSb3NaVnF4ZzJ4a2Z4V2ZsOCt3c0tpM01UamlJUXpm?=
 =?utf-8?B?dEpYSkU1Sll3dlM1aTdCQ0QxWlh0c3RTa1REWWFhMWhFeVk3blFLUGthaGVa?=
 =?utf-8?B?emJ6THNRQ2RJL1Y3K3Z4K0Z6MlV5VEpORGFWc2ZHTXp4Q25rYWd1NkNlT1FI?=
 =?utf-8?B?Y3oyVk85TnNqNWRsY1JQSXN6Q3B4T0cxM0trOXBjL1ZtYmxXVWYzTTJXa2JX?=
 =?utf-8?B?a0c3YmM4a1lnUWZWYXQzMnBrb0NaRDRiM0ZWMWtuMUZTaDZMYmJGcXN3SFhp?=
 =?utf-8?B?QXF0YVIxaDI0SWJqTWY3NTYyMENRTVlhZzAzOGlEYVNwNnhaUEk4NWh1UWVC?=
 =?utf-8?B?Z2xiUXZTb3duVVFKbnAzWlpwWDZIanJrWkNRYjVmaGRHc0I2NVJydzMzVHEw?=
 =?utf-8?B?NGRGd3RPOTI3cS9vZUx3U0VyUDh5bDJMTm9qUlZzQ0lwYnR0NnI1ME44bGtU?=
 =?utf-8?B?MjVtKzloeHhDT0g4VnVFT3RodGlQUnp0Tm9TVmFGQXY0UUtxU1ErRk5yQ1Vz?=
 =?utf-8?B?dE42elUyZ0RhOUI1WmRJSzdmQjlHR2huQ3ZKZWdSRkQ5dnBoQytxN1J4elN0?=
 =?utf-8?B?NXdJL29tdlI5U0VRTGlCeWsxUThCc2t1M3dWdnR0NDNLYXpWMFYxRXMyOHpI?=
 =?utf-8?B?TjhYMnpYUS91UDZ3TDVidVdzWitiSHQwVmxkYjU0VDBBeDlXd1k3a3phWWNI?=
 =?utf-8?B?QTV0RTBpaTNWV3pGbkZ6c0IzWUlqYnRxZXdRN0RHZU9xUmh2SHhubnpWLzFX?=
 =?utf-8?B?d2JuTC9VaXZkTFRwbi9HamlWNWVraVpRT2RzK3dKak1ZdTNSL2Rnb0puS0pB?=
 =?utf-8?B?ZFZUZHJaNk5jVTBJTTNxQTNlNENNZVcyTSs1NTgxS044a0Z6R1ZrbFVFR09B?=
 =?utf-8?B?YnorUUlDT2dGRWNZZitkN1JTK2svUytXTmxLQXlBRkdZQlF6M0oyQ245WEUx?=
 =?utf-8?B?Ri90QXNtYVpiT2g3OVFCdWp0Q1V1UlRQSnJjeXN6SEdCemVGajVod2FoZ1d6?=
 =?utf-8?B?Ri94RTV4bC9ZVDJyWWJScFZxb2pKVmhuZzVsVERmcWFzZ3Voa1lVbVZ0OHJ2?=
 =?utf-8?B?dGZaUGlvYW1vUExkQ0drVTlqaDNwblFPZWNsSWwrWU1KSzFJQTNJeE1obldn?=
 =?utf-8?B?SjNHcm5teUVzSXVBYnJLWkRtNW45UUJuY3lmblU0YzFyOFlOUVdiVTNWNUxO?=
 =?utf-8?B?UlRPazAvYjNxR3h0Vis0WHVuemRqL2tIcVg2ejJsc3RIVnIvZWorTERWd1FN?=
 =?utf-8?B?bzBpMkVKTTkwcTVPOXJJWTN0VEg0MEk3V0NDN1prMGY0bkJyd3VZdFVOSWhj?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	EmHeGfXcljtKbtxEXCCBu43XDGB6xAMHRlPdMzUgcyn+747fPl+HJsFt9KF65IHXzg1YHHcuFCGY/x/32ybiwzIir/eLYYSLjNeveA9R+PTPSv8qtI3YW36vCvYrlqmMSNJXkJLkjMgtwAswXaiO8AjFWcEvdRZyMf3eKklBmKKAyLH7O4e/wMPjJZaOtmfJzAD5QHB2HPmuzPcnX6VrfaZJ9YoUqJjUiUi+kQjDvY/x6Sc5Y02CGp5CNfiLiTG8Z9HJMAvE4zc2OEFPQ+8wY0NRCaYxVepMTUwj4kl/t9By1GzYBmE4aLKZL7nUyzu/+Ia9coxZ4xlw8+7bn2FfYnDGr5l9DQE4a1mPDWO2hAcu/45G7aWponFzzN0HHfS3TynNJ8AuCo7l4U/5+Lg2ocq5fw4gnROh5t19N2GfxEE4fyA+XS43gdsq2+f+Rd6DM5Oa574FuCA1nEN+wcSJLAptGTxwYJo7sFGtWMPyDLEGPCf70875HLOPfCg5VUmYOV9fEm02nRBzS2YZh7Pvho5ptZwMTPbofshRif4q37o2Rhy8ABPyqOTsuXEVWYIyuhvm1oKs0BRShg5Otg9Iilh9yXHL85MMg3LuxaFh17k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba27f0c-a047-490b-1865-08dc339ab7d9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 11:37:58.4352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c7Lgo8/ORkaw2SM+vBgU/4N5pMVb5p1rkBziKkkkLFx8qsqRRK9WnkR5RUDq2fCHJECPW/nuHgOkI2jwhLslNCzQqsKGUiiagZQJ6k5Y+SY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6913
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_09,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402220092
X-Proofpoint-ORIG-GUID: Bu8Pv70UAHbSQGlaaArobH_7zDyIPcw0
X-Proofpoint-GUID: Bu8Pv70UAHbSQGlaaArobH_7zDyIPcw0

On 22/02/2024 11:31, Shameerali Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: Joao Martins <joao.m.martins@oracle.com>
>> Sent: Thursday, February 22, 2024 11:04 AM
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
>> Cc: joro@8bytes.org; jgg@nvidia.com; kevin.tian@intel.com;
>> nicolinc@nvidia.com; iommu@lists.linux.dev; mshavit@google.com;
>> robin.murphy@arm.com; will@kernel.org; jiangkunkun
>> <jiangkunkun@huawei.com>; zhukeqian <zhukeqian1@huawei.com>;
>> Linuxarm <linuxarm@huawei.com>; linux-arm-kernel@lists.infradead.org
>> Subject: Re: [PATCH v2 3/4] iommu/arm-smmu-v3: Add support for dirty
>> tracking in domain alloc
>>
>> On 22/02/2024 09:49, Shameer Kolothum wrote:
>>> From: Joao Martins <joao.m.martins@oracle.com>
>>>
>>> This provides all the infrastructure to enable dirty tracking if the
>>> hardware has the capability and domain alloc request for it.
>>>
>>> Please note, we still report no support for IOMMU_CAP_DIRTY_TRACKING
>>> as it will finally be enabled in a subsequent patch.
>>>
>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>> Signed-off-by: Shameer Kolothum
>> <shameerali.kolothum.thodi@huawei.com>
>>> ---
>>>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 95
>> ++++++++++++++++-----
>>>  include/linux/io-pgtable.h                  |  4 +
>>>  2 files changed, 77 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> index bd30739e3588..058bbb0dbe2e 100644
>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> @@ -43,6 +43,7 @@ MODULE_PARM_DESC(disable_msipolling,
>>>  	"Disable MSI-based polling for CMD_SYNC completion.");
>>>
>>>  static struct iommu_ops arm_smmu_ops;
>>> +static struct iommu_dirty_ops arm_smmu_dirty_ops;
>>>
>>>  enum arm_smmu_msi_index {
>>>  	EVTQ_MSI_INDEX,
>>> @@ -86,7 +87,8 @@ static struct arm_smmu_option_prop
>>> arm_smmu_options[] = {
>>>
>>>  static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device
>>> *smmu);  static int arm_smmu_domain_finalise(struct arm_smmu_domain
>> *smmu_domain,
>>> -				    struct arm_smmu_device *smmu);
>>> +				    struct arm_smmu_device *smmu,
>>> +				    bool enable_dirty);
>>>  static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
>>> static void arm_smmu_tlb_inv_all_s2(struct arm_smmu_domain
>>> *smmu_domain);
>>>
>>> @@ -2378,7 +2380,7 @@ static struct iommu_domain
>> *arm_smmu_domain_alloc_paging(struct device *dev)
>>>  		struct arm_smmu_master *master =
>> dev_iommu_priv_get(dev);
>>>  		int ret;
>>>
>>> -		ret = arm_smmu_domain_finalise(smmu_domain, master-
>>> smmu);
>>> +		ret = arm_smmu_domain_finalise(smmu_domain, master-
>>> smmu, false);
>>>  		if (ret) {
>>>  			kfree(smmu_domain);
>>>  			return ERR_PTR(ret);
>>> @@ -2445,10 +2447,11 @@ static void arm_smmu_domain_free(struct
>>> iommu_domain *domain)  }
>>>
>>>  static int arm_smmu_domain_finalise(struct arm_smmu_domain
>> *smmu_domain,
>>> -				    struct arm_smmu_device *smmu)
>>> +				    struct arm_smmu_device *smmu,
>>> +				    bool enable_dirty)
>>>  {
>>>  	int ret;
>>> -	unsigned long ias, oas;
>>> +	unsigned long ias;
>>>  	enum io_pgtable_fmt fmt;
>>>  	struct io_pgtable_cfg pgtbl_cfg;
>>>  	struct io_pgtable_ops *pgtbl_ops;
>>> @@ -2459,31 +2462,31 @@ static int arm_smmu_domain_finalise(struct
>> arm_smmu_domain *smmu_domain,
>>>  	if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S2))
>>>  		smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
>>>
>>> +	pgtbl_cfg = (struct io_pgtable_cfg) {
>>> +		.pgsize_bitmap	= smmu->pgsize_bitmap,
>>> +		.coherent_walk	= smmu->features &
>> ARM_SMMU_FEAT_COHERENCY,
>>> +		.tlb		= &arm_smmu_flush_ops,
>>> +		.iommu_dev	= smmu->dev,
>>> +	};
>>> +
>>>  	switch (smmu_domain->stage) {
>>>  	case ARM_SMMU_DOMAIN_S1:
>>>  		ias = (smmu->features & ARM_SMMU_FEAT_VAX) ? 52 : 48;
>>> -		ias = min_t(unsigned long, ias, VA_BITS);
>>> -		oas = smmu->ias;
>>> +		pgtbl_cfg.ias = min_t(unsigned long, ias, VA_BITS);
>>> +		pgtbl_cfg.oas = smmu->ias;
>>> +		if (enable_dirty)
>>> +			pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_ARM_HD;
>>>  		fmt = ARM_64_LPAE_S1;
>>>  		break;
>>>  	case ARM_SMMU_DOMAIN_S2:
>>> -		ias = smmu->ias;
>>> -		oas = smmu->oas;
>>> +		pgtbl_cfg.ias = smmu->ias;
>>> +		pgtbl_cfg.oas = smmu->oas;
>>>  		fmt = ARM_64_LPAE_S2;
>>>  		break;
>>>  	default:
>>>  		return -EINVAL;
>>>  	}
>>>
>>> -	pgtbl_cfg = (struct io_pgtable_cfg) {
>>> -		.pgsize_bitmap	= smmu->pgsize_bitmap,
>>> -		.ias		= ias,
>>> -		.oas		= oas,
>>> -		.coherent_walk	= smmu->features &
>> ARM_SMMU_FEAT_COHERENCY,
>>> -		.tlb		= &arm_smmu_flush_ops,
>>> -		.iommu_dev	= smmu->dev,
>>> -	};
>>> -
>>>  	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
>>>  	if (!pgtbl_ops)
>>>  		return -ENOMEM;
>>> @@ -2491,7 +2494,8 @@ static int arm_smmu_domain_finalise(struct
>> arm_smmu_domain *smmu_domain,
>>>  	smmu_domain->domain.pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
>>>  	smmu_domain->domain.geometry.aperture_end = (1UL <<
>> pgtbl_cfg.ias) - 1;
>>>  	smmu_domain->domain.geometry.force_aperture = true;
>>> -
>>> +	if (enable_dirty && smmu_domain->stage ==
>> ARM_SMMU_DOMAIN_S1)
>>> +		smmu_domain->domain.dirty_ops =
>> &arm_smmu_dirty_ops;
>>>  	ret = arm_smmu_domain_alloc_id(smmu, smmu_domain);
>>>  	if (ret < 0) {
>>>  		free_io_pgtable_ops(pgtbl_ops);
>>> @@ -2811,7 +2815,7 @@ static int arm_smmu_attach_dev(struct
>> iommu_domain *domain, struct device *dev)
>>>  	mutex_lock(&smmu_domain->init_mutex);
>>>
>>>  	if (!smmu_domain->smmu) {
>>> -		ret = arm_smmu_domain_finalise(smmu_domain, smmu);
>>> +		ret = arm_smmu_domain_finalise(smmu_domain, smmu,
>> false);
>>>  	} else if (smmu_domain->smmu != smmu)
>>>  		ret = -EINVAL;
>>>
>>
>>
>> I think we are missing the domain attach_dev check for dirty tracking.
>>
>> Something like:
>>
>> if (domain->dirty_ops && !arm_smmu_dbm_capable(smmu))
>> 	return -EINVAL;
>>
>> But that helper is only introduced in the last patch, so maybe:
>>
>> if (domain->dirty_ops &&
>>     !device_iommu_capable(dev, IOMMU_CAP_DIRTY_TRACKING))
>> 	return -EINVAL;
> 
> Ok. But do we really need to check this in attach()? As dirty_ops are added only
> if it is requested in alloc_user() and there we return err when hardware doesn't 
> have the capability.  So not sure how this matters in attach() path. May be I am 
> missing something.

That's when you create the domain with dev A. Afterwards that dev A is attached,
but later on you can attach another device B to the domain. So this check is
there such that a domain with dirty tracking ops set will only have devices in
there that support dirty tracking.

	Joao
