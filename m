Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7275C1C2333
	for <iommu@lists.linux.dev>; Wed, 18 Sep 2024 14:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726671174; cv=fail; b=jq21nHPbIDwicRsyd/Ph+laAwCzNwstz3jHQVMrQs4Ae81xWBpIHfRB6gO6Tw7htWKAcknWi5HZ6HgjgbNSf/wuLwg7SJOC00eK4evGDTqkcoUwFl3+7a9Fym1ncs0yqedDujB9+QbuoDIBQIQj4zJ4cxO2q08UIpSw/QvF2j38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726671174; c=relaxed/simple;
	bh=uIcbpaZ6k4mDnvvcxm6Ns/HIPH5cvjqhmpT3p0LZIW8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RuWBMOOdE8Ra13+lq3ndglosOXBIK18RbdrBemi9eBesXXqDPvYHTp6UW7JSpc3iimZG35Kd0KJN4Qna0DBuKJkySMK6EQMinTmGQTKviAWRTcs0ouU4gySlBxVbzq33lt73mgpV8LeVsbphsch9pTqYH19XhilB148PRExlHHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TQSc+5j+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JFzV494P; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TQSc+5j+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JFzV494P"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48IEl44x023999;
	Wed, 18 Sep 2024 14:52:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=BQE57xh24KbFek2LPqymBNy14J84ASNtko81MuSV7GI=; b=
	TQSc+5j+SUJbUxC050ORMZVHOxnoPA6IZaq/cK29S0MQ7QDqEaHUmX6X46SXftNb
	rF2ujGC5PbpHODq2Ips1eZhynaE4syP6O7kxkKsT5tZR/ZHTVKD/bE9d+0XKqL+f
	qkBfXTCtZE+MIhl5qSW6Q8eILp7cG7yH5p8A0F1d7Ybo5drmVssFTxMLHZVHpuDc
	ILXjHA+ut2DNHZy1QlJOPnGCyoKI+QNgmXddXZTGoHFC26/FIJEXJGDEOrc3dKiC
	hN43or+933a4dy/74bHWF4ch/91v6ww5m9W0f2y+aHScP0xxA1Yx3Qb1PLvbK5CW
	Dyc84m4dY/dnb611mwYhhA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3sd1k17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Sep 2024 14:52:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48IEVSE0018397;
	Wed, 18 Sep 2024 14:52:49 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41nycy5kjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Sep 2024 14:52:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azbUBUfejZg/1Ck0ZytiL+1NyBaUI0lel40up8Bc+i0uinFBedNZEWVvkfQFYJlIeSvVbHPJ3QjDB4QAc/0xCULNiXnCkzAbmazNuAlhM0kkuTYN9yUFrMS5h2+YfFjpezDrcaTdsVlgeKY7LOHYv26xDOeaf6UkafCqZBuKtLNded4NR2le0ywAZs7KFjUOtSTrHlOfJAGZ09fTWw9Iv7nH/8bIRkvOq97jxQkhEl4iJAmDIgUF5PhO9iYza3ySmgyLZxPrRrLFJM7cD/qRf/nVV1siPH5e7HeJQm4rWqLKroO8um9tq0BEg36Q5HJdd6U/eRmtOD1O1ARUMgPFWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQE57xh24KbFek2LPqymBNy14J84ASNtko81MuSV7GI=;
 b=twGMVaKjGyi0jWSkedNZSvfTRbrp0Z6ONfEIBzw5StZr3oJ1ztke5vlc4Aa4yN0fGMqRpjxcq4CGXEIrsKkCHYu5IqYk+8f5ebs2P50ihf+U/x5SuOPxzYV7l+vK77epOeX5TTi8bBqyYR1dtKeNXU7iLl2RqrX/EMM+WG4t9qLKHd1ceLuCtPo0F2fXGdxib9p4IwbA8RH048YAj51hMzwCUThqOBA2Wc7zl42QFaqDzLyYt2oiUFzYcjBeQoMV2l8PDc9qh+E0WWOdC/TYgHUC1TP/jp1gNMaVWFUY6EydQXQwor0vuQD93P4b9U8BFLsVAr63LUFkrDlCyhEKbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQE57xh24KbFek2LPqymBNy14J84ASNtko81MuSV7GI=;
 b=JFzV494PfKGo8KQuAybUUiuwYQ1cGlkh4gBgzvdEe/U/aWPyA/YSDcrMmbdklv3DJvndFn+uC1NMdevxwHVc4FKgumi+RMimH/Aa2J+iHEGxZ6Ha5voGDdHyDZDrCslrtNAAwf9jez7cBiOJxkDWhWY1nykFwhoLM37+KqGulg8=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by BY5PR10MB4115.namprd10.prod.outlook.com (2603:10b6:a03:213::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Wed, 18 Sep
 2024 14:52:46 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7982.012; Wed, 18 Sep 2024
 14:52:46 +0000
Message-ID: <5b422c77-d299-48ed-8a40-e7f584b6bb2e@oracle.com>
Date: Wed, 18 Sep 2024 10:52:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 7/9] iommufd: file mappings for mdev
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
References: <1726319158-283074-1-git-send-email-steven.sistare@oracle.com>
 <1726319158-283074-8-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1726319158-283074-8-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0098.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::13) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|BY5PR10MB4115:EE_
X-MS-Office365-Filtering-Correlation-Id: 69e181ca-8400-4643-7f50-08dcd7f18eaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RVBlcThiMUxIL3diSHh0Ykw5NGxLUlc1RFhHbGZBYktRbE9pM0FhaHdYVVNr?=
 =?utf-8?B?S0pPWi9iTjdJc3cxY2ZvNlZpVnpvMDZ5UDNpcFp6NGJTZExwU1dWV1czeGZk?=
 =?utf-8?B?UFF4cVNmb2FTQmtXVzBENG1OdUloY3dYVHU5dHdmWjVSd09iK1NzdjArdXd0?=
 =?utf-8?B?Zkp2REdvVmI4YzZJd0ZhOWk5NHVaeTluTW9hYlpPdThPVDFJMFRtT1ZkMi93?=
 =?utf-8?B?RjA2WGJ1WThrdmgzdjdsVC91QWMxdnlBMXQ3SU5GMFJodnJaMncrVTJPMVdC?=
 =?utf-8?B?cnRYeDIzbTdSRzZTbmxDb0lGREppelhhWmgrWEsrZUxwOXoyMnRFeFovSDc4?=
 =?utf-8?B?MXIvQWxCcGpPaVFnZkh5TVZVZ3RzODZ4dW13cElIZXB3d01pZGhBTGh3dndq?=
 =?utf-8?B?WjlhQiswUlZCZFloZkFiWWNRdmRzSjBvRndLd0JRYlBRWG1WbWJxcmdSbGZj?=
 =?utf-8?B?MDNNMFY2bUVXRWFlcS8rbEgrNmQrN2owcm4zWW5BVUpydVp1bFlqVVd2SXVI?=
 =?utf-8?B?RlB2bWlqdEVtV2pKM3cxQzRXSkZ3K1dLRU9oMUhjSmNPTW1MZUZodFlwLzQv?=
 =?utf-8?B?NDZnckRtRG5kZXdBVEp0MGJNSnVrU2hwajBGUDluSGloaUJVN1BKaDdaNzZz?=
 =?utf-8?B?bTl5cU14UEpKM1VaVHluZ3piS08rbXlSck44V3pZNWZqbEVGUXc0UHZYNzJp?=
 =?utf-8?B?QXZVdHRIWWsvbEk5Q0oyOVM0eXJtc3hjZVFid0Izd3g5QjM0T2g3aS9HOVpB?=
 =?utf-8?B?RHB4c2FreS9iOFIwYUgrS0pEcDJzMHVCR204clJnVE5INmdjMnN0bURDTGNR?=
 =?utf-8?B?ZzBiWXJBdGxxc0xHVmk0MFhrVGNxU2pwSjgzSU1USnd5UzNlVE8zOVVaTXIr?=
 =?utf-8?B?QTRuNkgzbGRwaGFKR0hiVXFRR3ZRSUdpWmZHeThVUHZzczdnV3c3eUFBUjY3?=
 =?utf-8?B?bUJJRDJOZHF5MWlxbU52QmFmcnNTajhaRVROVjVVV1dEMkIzQ3VURGhHK0Y4?=
 =?utf-8?B?NHJ3dW5YT1JtMHQ1ZllCT25MK2k1eFlzRGZ4WUJzSktacVpzOEEzRHNZNGZP?=
 =?utf-8?B?Vk02ekNpMmJFek4vWGdHaTdiSTB5Qm5xbU9KQng5Sm0wUDVhb1pXeURCVi80?=
 =?utf-8?B?cWpQSXdQMFM4Z0hxVnFnNUxiQTIxQVdYVVRHTjVPdzBscHVJM3RYWWZ1Nkgz?=
 =?utf-8?B?dHVEQ09nNFNnaldzcTRuWU5Hc2cvN0l0MnAvUWJra3VzK0E1dE1wdG12RkNp?=
 =?utf-8?B?bzBqcnJ0bFJPaUFsaE5Rb1hsUHNTbUlQVFlHaWFheEl3cElEUFNhQWlEUldX?=
 =?utf-8?B?dUdqenJhTkFEcGJ6RERJVVF0VkdENFYwUVoyenZGNk82ZC9xSjl1MDlaZWpI?=
 =?utf-8?B?ZjVkcU56SkxaSjZiMGxUYVBKczdrUUx0VnYwbGpBMnA3cmpvWnZNenN2YXdv?=
 =?utf-8?B?L2tWY0hITjRkUG9PMm5DU0dxOHkzZnZJUkxxUTNtaTBlNFBJOHQrd29NUHhY?=
 =?utf-8?B?d1htZmdNZWxzdnJwZ29VcWpRcnZUaUY2aDhJSzdiUDhWN250YzFBdHlUUUk3?=
 =?utf-8?B?VnlCemNSZW9GZGN6N1ZIdWxMR056YmlWd2l6S21sUXYyNnpXVk5KVFVtYVZl?=
 =?utf-8?B?UVdLdjBEU1laNlY5NzkyZWROazY2UlVxNkNyNnhzVGwxaU13bkRFNVNpZk1z?=
 =?utf-8?B?ZE8vOEEzem9tWFE1U3ZoOTIweVRRTmFWWnhib1IyendKQ3N5SjlPSUhQN3h5?=
 =?utf-8?B?bktiRjJYaVhKeG9xNi9jcVR2dFFGK090bmxvWVUvVkdxQVY3cVdOdGZKSlBV?=
 =?utf-8?B?L3NOKzltRnVkNnpHRUNQdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1RJeGRPdjJzQjMyc1pMejMyL2d2TVh3OEtmdXhNN3RFajZJSDFvMnZ4U0or?=
 =?utf-8?B?V0ZNTUMxWXg4a2tmNTNFeU5qU0FIcFNNTldhVWV6RHBwQjFJTHo1TDgweW1W?=
 =?utf-8?B?bXBDbVJXSS83cUlHdUxTTDNjTUZBTkJTWjZpRVZmMVlZb2JJTU5NbHplNjNT?=
 =?utf-8?B?VWEvNjBON3Y1ODRXcTVLTzNpSUtzbjF0NEovNGd5ck9SNUFpM0NHWjliQith?=
 =?utf-8?B?MCtacjE0S0xZOGIxM2gyeE5qczY3enh3TStsU29VSno4VjczVURZTDdPNG5X?=
 =?utf-8?B?dmhEcGo3V0MzWk8rbHpuYVExaGErVityVHhSeTFpOWluUDEvS0lRMUFmbjkv?=
 =?utf-8?B?bWhKRGNHNVlnV0ZiU1dSUUREVDd1SDM0UGpaVzFHbi9OaVZKSEZtTXRmTDlC?=
 =?utf-8?B?UVBWVDY5WWV5RE5NbkN6OVpCbXdTODNUUElDL2ZqM0REd3lZNGUyYmdvM3Zu?=
 =?utf-8?B?Qm10YXUrTDZmTHB0d2I5TUVENURVS09BOFRZMndSS2lFWlBuWVJxRU12Umgv?=
 =?utf-8?B?eEpwNmphdjFrWUY2K0M2VU1EM0xWRmlibHh5VGcxRmVxSDFtdTluclMzcFJ0?=
 =?utf-8?B?VFpaYTdFQ1hrQVMvT0VoOXYyOXJuYlhTRVh1UFFGVCt6UEVaN0dpN3UvOVZi?=
 =?utf-8?B?SXExMElrUjIzVzNReVJQK21VSk9Ud2hqVFVoOC9vTjlYUDJ1L0l5a3QwRjFx?=
 =?utf-8?B?QUJwR0xYNkE3T3RhRnJLeU9Fbm9QMjVySG5BQ1EzZnY2QzZhM1Y1S1hJcjRm?=
 =?utf-8?B?a3pQenZST2JoczgySW42R0VxV2RXTDJXd1RGKzZBaVlFdkFTVzFXaCsvcE9Q?=
 =?utf-8?B?QkJYWUFobS9ud05vWW1XYk9vTkpnMVRYcWJtbnFTYmh5aExkQnhmcXZEekV1?=
 =?utf-8?B?ZGhqZ3dQSEVhS3BWMThVYjR2SitBcmFxSjJBdWZLWGdubWdSSy9aUEd6SVFT?=
 =?utf-8?B?THd1U096WXU3ZE9aVHVXZGd3d01uYkZzd3Nlb0dPbHdRNFlwdVZoOHlKV2tu?=
 =?utf-8?B?YnZuRkNFT2NNSmQ3SlZPUWc2QXcyR0ZCMS9kT1B1MURvOTUvL3lVS1pkVUFF?=
 =?utf-8?B?SXBzNzNxaHNUOFRaVVplOHlHeEVBMzJ6VzlIZzNvdWdLdWtYRkdyT2FFNTRN?=
 =?utf-8?B?WFVPNkU4ZUVVZXNPTWkzWHJLRG9YdDZlbVZwL1VUSkx1eS9tTGFjcE9BRnRZ?=
 =?utf-8?B?TWFGZ0NTWU5rbkxXNHVDbWY2NFVSTVQzT0ZNTUMvMHpCQ2c0L3BOZEkzMnQr?=
 =?utf-8?B?cDRwQ1ZyditDbk9yVjZ0SVJsQUdXeTNBM29hUHJxeWpETmY4eE95dzdnN2Vl?=
 =?utf-8?B?aEp1M0YyZ2xTR0swV2dNUG1WeG5za29WNFBQOEgrU3VEZnY5V3BTSjdYbTRJ?=
 =?utf-8?B?dy9Bd2tPc0ZRd0I5OTNiYjRIMGlranNCOVJEYlBYaFQ3alQ4SUVJNWNuQi8w?=
 =?utf-8?B?Y0I3eGs2enRZUzlMMlRYcFhzQjdXRVFHM3g0bW00ZFQ2eEJvNktRbGRxTnJK?=
 =?utf-8?B?aFFadTRPSlJSdTNOSFNGRlBveGd1ZGtHMGZWQkdVTHMzL2RNdUtYL09JdEVj?=
 =?utf-8?B?azdpU09ZWWxKejBndDZLcE9ncEQyZWhXRmdlaHZDT2NRQVBrZTBCMStEVzlT?=
 =?utf-8?B?VUZMWVhkaklrODJMMEptdWZkVDBFemxsaDZnc0hBTDUwLzNUWkVmUkRMSGJJ?=
 =?utf-8?B?QnNyTHp0NWlGN0MwWktDOWJpTUVXVVhsTEp1MHZTbFNKMVRiSHhPQ1FieW4x?=
 =?utf-8?B?QTJMU3JEZjVSQng3K0tTWVk5Tno3dWVmZWVzMXhONDYrQXF6YWgxNVVhVExF?=
 =?utf-8?B?bG9Id0tOUUpBNGlycTlGVllkMS9FTWxlNTE5aytER1Z3L0tacElMNHp3Vkli?=
 =?utf-8?B?SUs4OGNHL2ROZGY5ZDVkNzBlNXZCNHpiM204bXRIZ0Ura09tYTYxTWQ3ZnlU?=
 =?utf-8?B?YVVzSElCdDNrN1VsUjR6Qm05Z05vbHZCL0krWjEwQThDYXhuNnYzbnFEbHJl?=
 =?utf-8?B?MUNQMnd0ZDJLeFdzZmZVT3JYbUNwK043UVdyWHBCaHpHMnViSXFXeHlMRVp4?=
 =?utf-8?B?NG4ySENnTGlEQSt1YWtMT0xMOHhrY3pabG5GYnpxc3poZDd0bVhyd2dDK01r?=
 =?utf-8?B?T0Y0eG9NMWZwb2ordUVqaTE0eVJFc0N2RXNKZHEzK2g1OUIyVmgxWmJzdFg1?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	F8CSpNxFQkwnnGQqb4rh32YBzc593Lp4IKJK2+5xcZ60SqoB/FZonq59rAVj4AXXn8WdJcmuMpZMbNQk8lRB/iBBttDGGF2FxBa+BvPRdup6bxpoI/3ECJLDIZXn29eItFvKLpabSoNjyKF9yaYOS39cB10VOmgWytLNmR6GEeB7kcStONYvprBPTzQ914Leskv/ImDujBpXldpCEQ2VCl+BG9/+b6yCJD507uUO0Skl98iQ3lYMOnEnDashgXplez0us6g8kb/g/4a+yOAdyhu7/Cag7n3zuGDq530C+Uzp/443+IA1uJ7hG4bDw1e1kKDfm8G4Xtv7wOnbheFTdfNhBKS5fGP4XI+tEdmN9uoexmO+/XEqQ9Bi5TSsEtyTBr0jz1zyI2ykmcuriyJWHSlQuK7oJD5TTVSQs2cDjrwxs+fC95vJCE7mIHTp3TUMPfrlbroT5taS+S4oo2fiWXujar9smGtFZz/KSIpzHsfiS0E6FzDZIvflN4CCIRdwznUBFwUjZclYbNp5RNqhE5KrD/bZXe2+t0xSccN2yFOJ5jCuvH8oWGnC482LJ+aDXmio8Dno+F3W+BF+qgk54hL1c3TrAGbd3B99H30g6P0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e181ca-8400-4643-7f50-08dcd7f18eaf
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 14:52:46.2277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2n4bKu1EfzIYapk+WYmYEiPjUsAIT8m/a5KW3/xJurQ7mGyq1AblIQGm0+pC9UhgnVdQWQLKyHWUN+f1Wy+h4A4kwIivB2PUhr0KetHaw38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4115
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-18_10,2024-09-18_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409180096
X-Proofpoint-ORIG-GUID: 0gpCSFzO3hbVTCAJMN5RySKmhOb5BJTQ
X-Proofpoint-GUID: 0gpCSFzO3hbVTCAJMN5RySKmhOb5BJTQ

Hi Jason, any comments or RB on this before I submit V2? - steve

On 9/14/2024 9:05 AM, Steve Sistare wrote:
> Support file mappings for mediated devices, aka mdevs.  Access is initiated
> by the vfio_pin_pages and vfio_dma_rw kernel interfaces.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   drivers/iommu/iommufd/pages.c | 22 +++++++++++++++-------
>   1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
> index 8c8d0ff..4cb532e 100644
> --- a/drivers/iommu/iommufd/pages.c
> +++ b/drivers/iommu/iommufd/pages.c
> @@ -1706,11 +1706,11 @@ static int iopt_pages_fill_from_domain(struct iopt_pages *pages,
>   	return 0;
>   }
>   
> -static int iopt_pages_fill_from_mm(struct iopt_pages *pages,
> -				   struct pfn_reader_user *user,
> -				   unsigned long start_index,
> -				   unsigned long last_index,
> -				   struct page **out_pages)
> +static int iopt_pages_fill(struct iopt_pages *pages,
> +			   struct pfn_reader_user *user,
> +			   unsigned long start_index,
> +			   unsigned long last_index,
> +			   struct page **out_pages)
>   {
>   	unsigned long cur_index = start_index;
>   	int rc;
> @@ -1784,8 +1784,8 @@ int iopt_pages_fill_xarray(struct iopt_pages *pages, unsigned long start_index,
>   
>   		/* hole */
>   		cur_pages = out_pages + (span.start_hole - start_index);
> -		rc = iopt_pages_fill_from_mm(pages, &user, span.start_hole,
> -					     span.last_hole, cur_pages);
> +		rc = iopt_pages_fill(pages, &user, span.start_hole,
> +				     span.last_hole, cur_pages);
>   		if (rc)
>   			goto out_clean_xa;
>   		rc = pages_to_xarray(&pages->pinned_pfns, span.start_hole,
> @@ -1865,6 +1865,9 @@ static int iopt_pages_rw_page(struct iopt_pages *pages, unsigned long index,
>   	struct page *page = NULL;
>   	int rc;
>   
> +	if (WARN_ON(pages->type != IOPT_ADDRESS_USER))
> +		return -EINVAL;
> +
>   	if (!mmget_not_zero(pages->source_mm))
>   		return iopt_pages_rw_slow(pages, index, index, offset, data,
>   					  length, flags);
> @@ -1920,6 +1923,11 @@ int iopt_pages_rw_access(struct iopt_pages *pages, unsigned long start_byte,
>   	if ((flags & IOMMUFD_ACCESS_RW_WRITE) && !pages->writable)
>   		return -EPERM;
>   
> +	if (pages->type == IOPT_ADDRESS_FILE)
> +		return iopt_pages_rw_slow(pages, start_index, last_index,
> +					  start_byte % PAGE_SIZE, data, length,
> +					  flags);
> +
>   	if (!(flags & IOMMUFD_ACCESS_RW_KTHREAD) && change_mm) {
>   		if (start_index == last_index)
>   			return iopt_pages_rw_page(pages, start_index,
