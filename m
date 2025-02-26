Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B9821D58D
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 16:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740586806; cv=fail; b=CGgpL8rgmKWflKmdAhWPQnxHmOD1OZms0xgBtG9FTqlq+g3YrlDT3X/pjF+/PGy96bhP2aoIiAG34GWDdLeXwQxJrwuqygGZKJdwBt8hGBqyA/41PGKo/CteMar0dGbvREuedoYVuv2eR88SgNHLPzDqfcYCyqvK+tlmRtEabxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740586806; c=relaxed/simple;
	bh=RLmgU9IM+1SN3m+CusLp5VwDaKrF9WPEQrtJSUm3inM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LVQ4dVyReD4r3SKZEcOvgd5VkITV3NGGmWcxE1KD60X3/zVjk4+b75MEl2am8K3/Xk0ifGx0oHZkdyx8GaITm7ziK3a8bmRJ7rJxNLFc2yW65ZECkccMt0Pr7G1vryBt40TEXR3GY4dhKd0Wwhc+rIzI4ia/FLZXuKjfUX+ZbkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RPIE2H8x; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iz9r5zJG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RPIE2H8x";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iz9r5zJG"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QEtZOh001148;
	Wed, 26 Feb 2025 16:19:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=wWYMrgK8+OaPhmg1AKsgTQ6AKsPL8iHgqz+VlEg+Sjs=; b=
	RPIE2H8xzCliNft13njQzLVr1UGridIXEh5jZA7Y+Dlw+OaL7au3pbvPP4BjyBhh
	mk6EgSe9IZN1EcqtWJ41k+fLrqZn+c3oAzyYUSlhKg/AZE2cbtrRL+c8AOEEHgcy
	/EZPRm67ljTPfSKGB334le0GVRDzPRF0A0vfnwT38lL1X1s+qs6dvmWQcghYSX7V
	6walHeS22xFDKRO+dPOsWkMfrmNFrHZK4dcz9cq6SFTJmXCwYufqHib9DwjiIXty
	yHXPhwz0DbpqYs3fr+v3NPtgOQrIEHjt5MnUr/jQnh3zut/pBNE065gZpbR3rCdP
	BpVkVhffl7hOeGR4ecbGeg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451pse1jkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 16:19:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51QG8Di0010113;
	Wed, 26 Feb 2025 16:19:57 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51amahr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 16:19:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AgQ1RpPWrkecPePIvdMlidlcUmY+gwSsIvYNwdsI6kcC4+nLIKPnT0KT/epkRqg02O56kVvI5mFPsJymZF1jm17l7wiTqhiDW99yvPnR6eiOKJzCthj1Nt7xz75SoUgvV49+gVgLEEGDBXkj64pQ6D34uA7GGsjR7fGysMQyRLZZ/eStLl2s6/dvDqi3PJ8sXZVdcyay8YBoQriMDLqxB5BRxYp8RXcD7rI3tAOvi7zqr1ybcoICLFtqLti3y5vyf431SzHq/qnt8d1HPAQRXJ9ddWky78LPWcqM5zOvztNqN0XUf9+G+7b/EFb/LzsbWRiDv/mkH1daJurY6AIg8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWYMrgK8+OaPhmg1AKsgTQ6AKsPL8iHgqz+VlEg+Sjs=;
 b=QjK1/lFEtuCV1nKOTOgPzZDtFi4I1FspyTj3XZlofeeaXtGWDleTcR0s9ejsFIBd9qjjJgezFhbuI1DiXN26HQ/MGuiwuLslJoNigHuncAuJB9KYjA0C+cObFJ4pM4Fq2fpy6XStXzykh/TB8L5CeDFFew9rMXF6P/HXGg4YzxBNiVLz+XBwZd8ZQFoIJD5l+JS37xsGPb28bd+EuTT2pE3yB4BcatmEJRJqWDm0eKrxMiJn1kt7RACCucuqz0vcvUN/5S4urMxrA7NnRMKNICNaWFZ4NPeNEp8P66ifVDbNg0+tTX/+AFtUTho3QMASJZSDGkJ/ugKLboLYT3IfHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWYMrgK8+OaPhmg1AKsgTQ6AKsPL8iHgqz+VlEg+Sjs=;
 b=iz9r5zJGa8qlJIE/S+xb0UWfaY9DSCnE24tlhPFtefLi17+B2AagoB/9o/O/V4ukk4et7w0DOmQE1cBSjRn1oa+LHym9QuBiFlDvrFIiC4grzs1a8ks05/U+rgYGq5T0nOXGyRRuFABL+aMoJhocJQNnd/07onk5bDUpFRWKSeY=
Received: from DS7PR10MB5280.namprd10.prod.outlook.com (2603:10b6:5:3a7::5) by
 CYXPR10MB7897.namprd10.prod.outlook.com (2603:10b6:930:da::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.20; Wed, 26 Feb 2025 16:19:48 +0000
Received: from DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da]) by DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da%4]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 16:19:48 +0000
Message-ID: <b3ed5d5e-4b9d-445e-8d2b-3b315322ff2e@oracle.com>
Date: Wed, 26 Feb 2025 11:19:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/amd: Preserve default DTE fields when updating
 Host Page Table Root
To: Jason Gunthorpe <jgg@nvidia.com>, Vasant Hegde <vasant.hegde@amd.com>,
        dheerajkumar.srivastava@amd.com, sarunkod@amd.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, joro@8bytes.org,
        suravee.suthikulpanit@amd.com, will@kernel.org,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com
References: <20250106191413.3107140-1-alejandro.j.jimenez@oracle.com>
 <f87e897e-028f-43a7-9557-e65778267fc8@amd.com>
 <20250107180146.GO5556@nvidia.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20250107180146.GO5556@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN1PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:408:e2::29) To DS7PR10MB5280.namprd10.prod.outlook.com
 (2603:10b6:5:3a7::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5280:EE_|CYXPR10MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: e655b8d3-49a4-4cdb-7e43-08dd568163e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzlETXhycUJRNm05RUZiNmx1Z1RPSmFLVDZaSzFqcWJENkJ5M2xqeDRLYm1r?=
 =?utf-8?B?YnB6cEpwWHBFMkJHRWRzQm40T1VyamRNdU5kbmExbzhYUjVzVmlldERzd2Yr?=
 =?utf-8?B?K1Vwb0lxZWJKblp5SEFnaEQ0MGZmNzVlWDR0K3Bhampxb0R6UFFCWEtsT0wz?=
 =?utf-8?B?MDM4cXNUc09ZamFsWW03VGRJTFBkd1pKeUNlNnZlWHZEenBnOFFmRmhYR2k0?=
 =?utf-8?B?a3FBTGd2UGkyS25RYno1RFZ6azdEcTNRMkpwZnhLWUZWRERFNVJSQ21sU3M0?=
 =?utf-8?B?SFFtWHQzdFdmQU5nbkVrMnlLRGE2Slh3cFdsaXlMdGhLK1ByZWUwRkRTM0E2?=
 =?utf-8?B?WkZYT2NFbjFnOEhtekNCNThEdVJweFNQQWVDTnZ4TnlDeU9tSlVVWUNsdXNC?=
 =?utf-8?B?RmpXS0g5a0RjbTM0RjErWXluMzNSaDEvaDN4czlCR1R3MmpXdXIwMjNVS2Nr?=
 =?utf-8?B?YnU1OW1SSnMwL3YySElyTi9nN2tLUTBjQkppWkNQNXhab2ZublNCK0lrdU9u?=
 =?utf-8?B?eGlhRXpKZitqRnF6RVM0TlBtTG43ODdYeUR0ZERlVm1sVitJdTcxNlVyV2hX?=
 =?utf-8?B?TFMvNkd1QUN0WXRpOHM1Q1pzL2wzb3E5Wlh3SGVqMGIrZldtd0lBbGhrRzBP?=
 =?utf-8?B?UWkyZmFGZUhDeFg4MXB3TEdtQkFJS2krY3lXWWgycEczcXpxL3IrWlNQZFhL?=
 =?utf-8?B?MHRkMGwvdTE0bVEyLzZHaExhZ1huQXdJeHJmYWsreUdrK2Y3WGg3Nm5NNENB?=
 =?utf-8?B?UVFNN2lXdWhmelYxZyszRm5XMnpTQTZuano3TEV3MkpFYjJTNzRDYithekpV?=
 =?utf-8?B?bTF0bVNac3BqMm5rU1IzWVNMdFFCVkZZb0VXVnA3VEVSejhXbEdJazlsbUVL?=
 =?utf-8?B?eEorcTBjWkVDOHFMdWQ1VDE3cXNaVUQyS2hPY2RCeWNKOFZIU1RqMEZOUHhX?=
 =?utf-8?B?eU9UTWNBejludHVoU3JUQ2txSmQrSzBDU1hSNzdqa1JJUmNaU1NQYVQ5M09D?=
 =?utf-8?B?RThPVmtMUEFPRnlMT0VlcnRpZWtUaFdSVDBwUzFhekRQVEVWVGhiYkorVy9V?=
 =?utf-8?B?RjhTTU8zS29OTytUMWEraTlJUVRSRUJ0bFJMb0ljWVMrcDhwU3JCdStudVFQ?=
 =?utf-8?B?RmdRNmloeVk1T24yVDRhMjQwOFpqR0k5Yzg1RnllQnJhZUMvVGRESjFsUVMv?=
 =?utf-8?B?U0JtWkdQS3h6RWxNaWh3QlJmSXpvTXlxamd1enVBUFZRS3Z2WmpBalZkeDc2?=
 =?utf-8?B?MDVRMnA2WHNubFc0Qk93eDZzU3pYZkx0dUlvN0o5aGxvOEhER1FaZEJDTFgz?=
 =?utf-8?B?c0N4VU53NlErUmw2WUx4aTFmSTVFOUsxcThMS0ZkUzlod3Q0Z0swQzN3T01m?=
 =?utf-8?B?WXBFUXpzMmNnb2hwbUJEZW5RNnVXSGVUaFpPaGNaUk9lK2F6V3krYzVHU04w?=
 =?utf-8?B?VDh6WStqZmtodG92RDZlNm5DS1JvOHlEdTliK3JHdCsxaFEzZi9RY0tMMzN0?=
 =?utf-8?B?LzIvTnQwczBBcGcvMEJvMk43cFdla1Y3dnBoSy9aMkxtdEoyWndYbWNzbGJU?=
 =?utf-8?B?RW5RMmJNV0VQREp2MW5DTE9KTzJmaW5YbytQM1U4RGhaeWtCaUFjZ0RBWnYr?=
 =?utf-8?B?cm5rTzQ5VS9MNHRFR2gxSWh1M1dWQ2U2aktwSHV1aU51T042Tnc1QVZrWXVt?=
 =?utf-8?B?eVVRUjFDek1HdkJadUY5bzNyZ1g0RW1jUXh2VnByZW8zcjJ0M0l6WVBiWWYw?=
 =?utf-8?B?RDduRFh2aUdQdjZ3cDlSTTc3NDVOUGJIVzQ4MFVoOXlScVhBbEZ1ZGRieUU2?=
 =?utf-8?B?eEhhZS9EcHFLaHh3WXNNTzUzWWwxd1IxN0w2dGlDdC8vWDkrcGp1K0N4K2lx?=
 =?utf-8?Q?GM58vpdCA/DpY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5280.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnVFQlY1OElUSlhlMWNrYmhSaFROdUtEMUhiN0swcHZ5MVlLWXlWQmgvcXpr?=
 =?utf-8?B?RU9NQW9aajNsWmMzVDZtOXhybFk3ZGNHZ2x1ZjJla202bkxWdEN6VzRpU09w?=
 =?utf-8?B?R3FJTTVsaWZvTGl4UlNSZ0xkQTRld1dveDhROUd0S29JaEswYnJhdVZYbWht?=
 =?utf-8?B?WXplRkluQkcwWlc2c29CcVpxbUpMTEFrLzRVRTV1djc3VGQweEcrejZvdUZx?=
 =?utf-8?B?SWg4cUZQdjkyVnN5YlRwOGprd0R2OUFKdlFBemNSdjdzSHVWZHdXazI5U3hH?=
 =?utf-8?B?U0Q0amNrdDJvZTRJQVVFalF0Skh5OWVDcE03VzN0U2ViR1dEVnZ4VnZYNFR0?=
 =?utf-8?B?ZVlUSkMwT0Zvc09BVHB0S3M4OXBEYWNwS3FsR0oxWlFhUUcxeWdqUndyME1k?=
 =?utf-8?B?RkJvY2czSUlEUCtzc3dlb3Q3eWJ4aGdsOWtoem4rUmJDakVySnFzSVJaQ3Ev?=
 =?utf-8?B?eHRQN1daa2NHV2RXZEJjbm1CamNzUHptUlNTL3IzR0VUS3pDT1Z1Z0MxdS9E?=
 =?utf-8?B?SlB3TzZWNEROWW5od1NxQmxob21IdURHam5JQzUvcUp1WXJkZTh5R1RMWGpD?=
 =?utf-8?B?eFBOdGVLclFXbC85aW1EUVZ1ZkxmeTQ4bEdhbUtjRDFyZG80bHdRMlpUR0th?=
 =?utf-8?B?M1Iya0dZdTJpa0tkeVJRNnhPSm42MDBBSFBUUXIrSHk1Tkg4R0pEajlDSGFY?=
 =?utf-8?B?MG1OWnVmRXdsYmRvRjNwNG5GMWRMY25PUkloenRSVUUrUlJ0c1EzWnBvdm4x?=
 =?utf-8?B?UVpRTjcvb3dPeGY1bGJUcFg3czMreWRDcGtRM1BqSi9oMXRRUm0wVUpPWDFa?=
 =?utf-8?B?WW4zWEI4cWtwWFRLOStTM2QwMmpJa3NkK2pJNjdKVldQNDVhSGxucFJNTXFW?=
 =?utf-8?B?WnlqUFdMQmM5WVFzZW9YRkhpTERHTFlCYjBZWWJJYVh5bTBBeG5sa0pLSE1X?=
 =?utf-8?B?S1NmZUdQUk5qQlBJdXd6SjBSckVKRGtxWGg5bGppcnlFaHBrNFNRMThoWWZW?=
 =?utf-8?B?bE55OG1rMGdJbWdZZ0RvcDBEODZKMTdJdWVUY0VlZElkejJ3Mkc5c294aTBq?=
 =?utf-8?B?UmV6cG91MWZBYjFkU3ZwSjRqd3ZYSWVoaEhlZTdsdVVKUmdteFkrN3NjOGNY?=
 =?utf-8?B?WG91VVJ4RmI2L0lZR2ZaMHdyTFZnU25oNXRPUy9GdDloSUxYV3pId0pHK1Ri?=
 =?utf-8?B?akFVMFQrWHk5SktCQW9xdERmNFl6NUZNOUhKMHJOTWM5Rjd3R3BTa2cvbStw?=
 =?utf-8?B?RjZoQ2ZZdUYwb2llZzlWV0xWWGk5dklDZHhzdjNlUERLdDI4YTVVVVErMSs0?=
 =?utf-8?B?Q05oYkdibDhucXJwM2w0SUloVzR5dTZwdHdTc0I5ZEhlL3dhSHZNelJ0NnhQ?=
 =?utf-8?B?dFVHdSt5OHI3YzBacmF1eTBmdHpkc3l5a1FzWElacHVnclRzS3daMld1RWhw?=
 =?utf-8?B?UGRhbi8rdTBRUGdTSWRVV1F1SW9vU2E2R2o3NDFFenFYeldwR05hSzJWMFhq?=
 =?utf-8?B?aHZMTk5nZ0ZydXhXbXZLZXdKZU9yMzhsMi9HT0QrS1FmV2x0Y2VmT3NrOWNU?=
 =?utf-8?B?d0gxRFI0NjB2aWE2QjcwNlQwcHJLeU5Lc1pLaFluSFFhWmxBeG5hMEtxZEtP?=
 =?utf-8?B?MVk5VnZkRnlxTlM0SW9td0thcHhjakV6NWswRFY2TlJLejcveS83cTZLd0hY?=
 =?utf-8?B?Qm9Kd3hmdml5KzNtWDh1VUQxZzRjTlAwbFYyZGVzc3B5YTlKVEpUVUxnRTda?=
 =?utf-8?B?RTV1ZWVyVGVCcEVTemUrMzl6bVZxZUZvNW8xa1Z6emJEZGxidWQwR1hRUjkv?=
 =?utf-8?B?S01JN0hjQXAvbjNubkYxanJmQ2xxUG42eW5PZ0FOYUR4cUxJb2F0elNOWml3?=
 =?utf-8?B?TXA2OG9MOVJvclZFakRsczk1OXNPNlMzSGtDZHhOVTFnNk5mRm1abGFDZEhP?=
 =?utf-8?B?WWpVUk9ucTR5T3JtVUhMeWtTSGRqelllQWF2VHJvRC93QlBNUEljSkhjUGNP?=
 =?utf-8?B?QlhhYnlqNEVvWmc1QXBFN2IveWhXQXJ1V05YWEFISUh6aWpDY0xEZkZJSVMr?=
 =?utf-8?B?R0tEVFpVcTBXaTEvYTlHVStpME9pTTBZanVjYTRZb0d5K0NCWmN0NThQTnI5?=
 =?utf-8?B?dm90YnhnNVZZMEMvKzJwajVjUUkvY3dRdTFnOWZCVDFpNWY4V1gzSWl3REEz?=
 =?utf-8?Q?muZrD+qT7129QQdaVXS/t0I=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fCr8vDwsgB+ud33MLxhFMwaA7VS4UutcgydHrmYbfxZuFMk8uU3VTpMqRj6GW99yssGP56/faGF9k9rKoaPso8/EE8DRjcD2E085JVjI3ei7gDIQ/lHkL7EQ11axiu4Nkk4aN+vsQtVMHK7IRmXznOcXRxXtoHoyklphze1f5TNYsXNqlPPNKs1bmmkW6GGgbLhM1fFT55b5hJXWx/NijNEB0rCQZsifSq3EceTjbp8xgQAqmMJdB+g/uG6KLdNkXj4vYZwE7peF7uslFHPWAP9bQaChfQz+yW1pPZw23N4HiH3b+jyf1EJiqW+lss5eYl7jBq6/ZO3FTy188FNQZWb3sHxk3OlEgRxkxnmypPd8Jbi9yZe+ZXR/1p3kc3HtTi816ilSAzVpbyZf3N4pVAKyZGA6M8tL4dgjfaUHueurBkz4nu+8oZQb9UXM7pFmC44Phpb5aXSmzLc6FqjghRS2KVoQ9rAbFshQX2LiqyDhT9nHD/5GaIo6bcKJ3ppREuiX7etywzvgbSfqvnVT+OJsb+zyf4qH5M4mnK09uOT9PbizWcmwhrepVCUlHYr9G3Tk3UoCxdsq1J0tsLS/DYi4wZqRc4bgFSdoQsV0GU8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e655b8d3-49a4-4cdb-7e43-08dd568163e7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5280.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 16:19:48.5164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OLnwMphkLuFr1bCDZByDS8VO56DSYiM3/yKKOaFNpSzx/yrxOdVGNURWQ6HxXjlzJSD6Yz+Em1owCsLTGpei6iGsMtH4eipK5PTVMebCaFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7897
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502260129
X-Proofpoint-GUID: 75n8yC_lVIZJrJ7bTaTzH4bAy05XvOYx
X-Proofpoint-ORIG-GUID: 75n8yC_lVIZJrJ7bTaTzH4bAy05XvOYx



On 1/7/25 13:01, Jason Gunthorpe wrote:
> On Tue, Jan 07, 2025 at 05:45:38PM +0530, Vasant Hegde wrote:
>>> @@ -2052,12 +2052,12 @@ static void set_dte_entry(struct amd_iommu *iommu,
>>>   	make_clear_dte(dev_data, dte, &new);
>>
>> This fix is fine. But with all changes we have done in this code does, do we
>> really need make_clear_dte()?
> 
>> How about removing `make_clear_dte()` and moving DTE_FLAG_V to
>> write_dte_lower128() ?
> 
> The V flag should just be set by the functions building the DTE,
> write_dte_lower() should accept a fully formed dte as a matter of
> layering.
> 
> I'm hopefull Suravee will come with something like this:
> 
> https://lore.kernel.org/linux-iommu/20241016142237.GP3559746@nvidia.com/
> 

Suravee did say he would implement the suggestions above in the series for
nested translation support, but that might take a while considering where
we are in the cycle. Given that this fix is straightforward and has been
reviewed by Dheeraj, are there any concerns with merging it in its current
form?

Otherwise I can implement and test the more extensive changes that Jason
provided above, and hopefully Suravee's work on nested support can easily
merge with those once ready.

Alejandro

