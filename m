Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8D7487A5
	for <iommu@lists.linux.dev>; Thu, 26 Sep 2024 15:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727365720; cv=fail; b=NS/1D9QSeMLFCicgoeYb1O97HHVoV9YEkLxVOl+HKjREFNv/VqHALY0tJ+zTXd2H4ObzztdJqYJUDNp4pSLLONlLZnk2332Zftdt7JV7mWB7Ozq2kC5XZHZxC5xueFeqkChrg+tBczBrhZkqPXFF8r58aJCPSk1JRz6NPmA9Rn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727365720; c=relaxed/simple;
	bh=RhxW+RAZVdC+iu2w4KV86/Iq7h+kx0MmpbHqQ9rp2KY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hA1qdqPm1kzd5261UPH3Ukx39eKpW2XCJ3vnWnx9KGi/OKYRA9fmd9UE5tkDt2ninYp3/zCXiR4xMWxmjHHbyV3feEu5pzSoMnBfxCV0dHuAj92oCLD3F6GPrhpMv82R4iIa8mNXZ4Dm/XP0BF2ts0ZbPWB12DhXBq7vUrgXGSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BGrizagm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=v0zmdhn8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BGrizagm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="v0zmdhn8"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48QFicEC015243;
	Thu, 26 Sep 2024 15:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=dWg3bfdKqM+NvJPyilOS4m7R5dmtev96c1RTIM9XGrM=; b=
	BGrizagmIUnRdSbibwn4rPf7tk4bQI8eW0mTfdyxd+XzAvevEaiXPFIY4ZNrsmxT
	x6PLHUOYig6PE/zIEwLvry3JvvBZFNzxXybdul7/YwN99deOEx+rMA75A39zkmZj
	fJrRXeiEj/k7/61S2RwDPX4x27NFE3h/yfgIAioBYOy2lNA8Ucu5D3vX+gWMVG2o
	LLQApO0qbOy3kZetrL6/YZ5PwfdfIKEtDuCqPeh80u2/yvixiiScDp74UxqQMWF+
	tGOpm79q6DvXXYpDhIkG4eco72/t9ruE/Oyl092HX791kYvtQQLVbhL9zuDEKFp+
	frACPfZIsXkEqT17ALHa4Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41smjdax9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Sep 2024 15:48:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48QFXdCc009786;
	Thu, 26 Sep 2024 15:48:28 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41smkc1puk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Sep 2024 15:48:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hsRKsI5OO5v0yOyEdvubQEsXigdrLU+gPFpqqkhAs6qkQIYVSSJSz/VQ1DV88wP0vWoYCfjyhI/EBy6DGuILtxhTcWFlG3TCOw0CRR1agSiQpct8tvDRxeaEoCxo2H8fzB1UMlYxBUoH3sjJWJwpecMA6QQvLg94+L9tr95UAqSbBS+3B4xSh/mvIxi1EpLaYF3ivt0Xnv7DCJV0bN4Cc6+NOSwRD5UXYN2IrjVC4m693XiiB8xmY+OvEgg/5fxgpr711BZC2LWXlnVQ4GMPdihuDhXAG1FNUW+jqbbrgBK05QM+AsV2FUHpgRHTZ07OswjOm3arJ5d5t5EjV6B9nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWg3bfdKqM+NvJPyilOS4m7R5dmtev96c1RTIM9XGrM=;
 b=L7gjsVxdo7hD8EKEljQvoJJToXbuI9y2N5eW/uu4N9bVCRif1QHBTFzj+pBVJ0iFpTs9nyQIgKGF78jaefHD38+E0Fv7vtMpM7R5k9W+kC7sIj8JHYtfRNIoEiHMj8xhrefeUUicBgK1gDPOBdo8BbuyxzPbxzdk7LpjkSgAUxCXfyqvd32zdaKBvtqBc/a3WHsTU9vNwzGG7+aEtfgJ9mAUp1W8iofiKjunBlnfRYriOoDkE+mEuu+ivl8jBsagLQU2732c90Ta66+p7HVTmZ9qBFNDB4NRSm4/tvx2zl1UBTt3ROiqaquAOQnhqlEbBCFt7UNSwxAn4Z6+P3hYXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWg3bfdKqM+NvJPyilOS4m7R5dmtev96c1RTIM9XGrM=;
 b=v0zmdhn8q8MBzIkGLl5fGtkYN2SmxLnMBYs7aDHHzpUKK7qxJVm4axncaoRPJZz1g4zXmcIpZOYOBWpmyD30pCiqC+2Zqu3PCNOVQznV6KVB9XZNe3TaAwFldTcY3jiCEIjBNFgI8ZCXs3HoHR19pBtlLNlMsltTb2wJgoynudk=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SJ0PR10MB5632.namprd10.prod.outlook.com (2603:10b6:a03:3df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.9; Thu, 26 Sep
 2024 15:48:26 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8026.005; Thu, 26 Sep 2024
 15:48:26 +0000
Message-ID: <09c89be7-fe26-4439-89c1-1446911da472@oracle.com>
Date: Thu, 26 Sep 2024 11:48:22 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/9] iommufd: generalize iopt_pages address
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>
References: <1727190338-385692-1-git-send-email-steven.sistare@oracle.com>
 <1727190338-385692-3-git-send-email-steven.sistare@oracle.com>
 <ZvMhqXo5MQ24xVND@Asurada-Nvidia> <20240925224322.GV9417@nvidia.com>
 <ZvSW+laS3t/16zEi@Asurada-Nvidia> <20240926144812.GA9417@nvidia.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240926144812.GA9417@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0352.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::27) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SJ0PR10MB5632:EE_
X-MS-Office365-Filtering-Correlation-Id: 4462810d-4531-4ff2-253c-08dcde42a8ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWhrUk04aGIxSTdUSm1rUm1veVhHY0NYa28wRHg3cEJkNUh0ZjlCUUdMM2I4?=
 =?utf-8?B?YzlOdnhXSWYyQk4rbDV6THltMnljOEFmdndaMnJCcXBSS3lWOVFPMGdqMGk3?=
 =?utf-8?B?T25ZKzRMbnpaV1JxRjdJVDJlNkhmMmxWa3Y4dFpmaEJ1NmdVdWFSL2wrdHdV?=
 =?utf-8?B?QW53b1dQVGkwWVFlT2VlU0VKSWR2K2EvNVc4YXg4TU1YQmF0QjhWeGcwQ0tO?=
 =?utf-8?B?RzdRMjJQV01pbDAyQXZKTkhPSnBNLzVwb3I3cW40Rjg5WEZjS0ZFQ2xoa3BG?=
 =?utf-8?B?ZDV6MlJ3THo3UGpmR2lBK1ZDa3RPUUl6eFJXTVVVK1djOWNtSjRJVEVEUEtK?=
 =?utf-8?B?R2M4bVIxUDRnaUFYU3lNdFVDWDF6K1V3WmRra0NxVmtJK3dHWTd6NGl3YTFI?=
 =?utf-8?B?ZGc3WEx3Rkg5cW5rd2E2NGtMSXhCY1JHQnJ0TzE5dWJ3Q3dvVSsyUWRISXhE?=
 =?utf-8?B?a0UzYXdBUFF4UWFvZUd2eWhySGNsVlhPSDNZZ2FVVW5sUlhkMFd1Rm5XbEhs?=
 =?utf-8?B?QnBtSUl2ZXkzTVI5VDc0TlA0MUdLbGRtVkRUL3VtZHVvb09ld2ZYK3FVQmVG?=
 =?utf-8?B?QnFPOW9seE5SWG56Ky8wV2drdVBFTUg3eFRKQUkrT1RlQXpVRUFyYUpCT1lT?=
 =?utf-8?B?UTMvMEVOY1hvQWMxeXQvbzBNUC9EMmlMOWdMT3I5eGlkVUFoTHlXY1Uydmg2?=
 =?utf-8?B?VDdCeXN1bGdsak03YU5KbWRTQWMyY2VwRE5VMW91K2dEVURERDYzRUl6cE5O?=
 =?utf-8?B?RU4rU2lBVk5WL3Z1bE1EZS9ZSEtCRkc5eW9xTGNHUlROenhRVGVhcFVnU1hm?=
 =?utf-8?B?enFEN3RsTXN4bE1PYXFrZzBBT3gzQi9sWHBWVUs5aXZxL2laRDc1YTVlMzFw?=
 =?utf-8?B?bXNRVkI1bEFrTFlVNm5JSmtzZVMwajZvT0hSaUR3R0FSS0lVcUoxcUVJbEU2?=
 =?utf-8?B?TXRaeFVFaFY0K1FZY1QrZnhmTWxtbk10VDk5bVFIc3hSdW5mZ2N5SVZKMzRp?=
 =?utf-8?B?L0l2RnQ4ZGhqbjJrRjMzVVJRMitzQXNaeHlFLzhSL0U4VVpDK3Arbkt4MEtB?=
 =?utf-8?B?V0RRYzdORUFkUFhtQStwOXRtcVc4VktINW1IZFkvbXRPSkpjK2l3cUhiMFpE?=
 =?utf-8?B?b1JZam9jYW8xL2NMZEZLYVRiN1g3bkFyUEZTNDQyYzZ5N2YwVnR6Y3BSTVp3?=
 =?utf-8?B?Z2dBZE5mN3Rpb3BUb05ISjRDRmRRTFVuMVFkblg3T3F2bVArUmZSekRRWVE1?=
 =?utf-8?B?eGZHZk1KL0J5L01hWGJBOU5hUVB5czdZbHlrS213RDY4S0pnRFhlYU5tSitJ?=
 =?utf-8?B?eHpEUTRGd0pRTTlsV0NKdm9FT2JtY2lSWTBtV1liSWlRaE5VcUpLN2ZWbnFl?=
 =?utf-8?B?all6RnhrL0YyeFhUM251aU1GaS8wbXhuMUtpWDZ0U3FwbWxCMzJmTHlLTEg5?=
 =?utf-8?B?KzlEYlF0K0E5QmpDcnp1ZnBVaVFlNlFicHh1bUJvb3MzT1hLamJpOUpkTnFL?=
 =?utf-8?B?RjRkb3ZvbmhSNm9KeVZnRCtrcVRMZVQ2VEZ6WDBPbXV4N2NWemFubTNCSDdZ?=
 =?utf-8?B?QzlwSlBlZ3ZnWDdpUzF4b1llQVJqbzc5QnYzSDNSenVtYmpUZTJlN1lwRnEx?=
 =?utf-8?B?c3cvVzJSWHQ5dm1YamdTZmlWY2JOZzBYNy9EVXgxRG5oSkpNcGV2UkFmRTlk?=
 =?utf-8?B?WXZuTFEyTllld3VKWXRUZGtXTmROdEwvUVZBV3o3eEV3N0d6TzVkQzczT0JC?=
 =?utf-8?B?a2xOclFmYkdnY29BakNJdHAvNEpweTdoQVB6TWFNdmU2NkQ0UnF0a2pXdW9m?=
 =?utf-8?B?TXV2NXpaTlFTU3ZvTTBRZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEN1djFQSTdrT1R3d2Y2Tk5CUjFmKzhLeklZdk5QS1Z3UTRiVGxGR2xGakJD?=
 =?utf-8?B?RDZkTERtcVJ4cE10V28rN09ITUpVcjZnOFFOeW42dTUvWWxSVG9PK2NWdlpJ?=
 =?utf-8?B?dU51UzRNNm9uaUdEVE5OczliMUF1T2xzQksxa29RRVNUTzkwc2NxSUFYTWJC?=
 =?utf-8?B?anhUVFRHcm13SnlMTDlvc09XUVlIcmQzYUhRRjZ3T3VYeHpXNTVLN1Uwbjlv?=
 =?utf-8?B?SmxiVkhSQ3VySmRnbjBSd0xGbEIzUXplbkp4anYvZ0xJcVlSV2JhYml6cUlY?=
 =?utf-8?B?VXlYaUMxWWFsSEZ2cnA2VW9UNktDMTQ2cy82UjgrRDN6RUYyNFZ1VWZLS2pR?=
 =?utf-8?B?Sk14a1lRcVB6dDVmV2NkdXI2eWE2NWRLc1NpNnUyV0tkM0kzSzIwYm9RZUNQ?=
 =?utf-8?B?MDhBSWFRYzA1SWJsMGJWMkwzc2s2UlFBVjJ1bVVjOGlkQkkyRTBuSmxCa2Y2?=
 =?utf-8?B?ZmlueW5ySTJTbUNWRVNJUjAxZkx6SXlBSFRtSW4yUmZXTnFGV0d5NksxMlo5?=
 =?utf-8?B?MlBVQlJnM2dMaEpqenIyMzRpKy8zdzZWbU01SFNQTTU1emFOMC9sVU5uTW42?=
 =?utf-8?B?dm54UTNOOGsybFZMaTBsZ3E1WnF2eEY3YTRGTGtyY2hnZFJPQkNTQUQyeWl4?=
 =?utf-8?B?dXF6UFpIUThsSU9mNC8rd2xQTHFUWHY1ZUYzWm95bS9lakhsaW0yQXl5SDVG?=
 =?utf-8?B?TUd1S1NnTlJSeFNwM0JmaWtiUVAySVA4QUkwZE1jUW9UVjkzSU5EUFJNb2pT?=
 =?utf-8?B?WWNjTkhicWszMkc5OXd6UWVhR3NtN1NYWnhwbjZVdnpWK0NnbWEyWnVNRHg1?=
 =?utf-8?B?bWNPczdTM1FxdnRvdlRlQ2hHNXBDNXMrL3pkS0lBT3Z2Zlcwd1cybW1DQzRv?=
 =?utf-8?B?eklueTlvYWJ6TmtNSnpoSFZuSGZWRzhGMGZudFBUWEk0cUpMamw3am9ONjFC?=
 =?utf-8?B?ZEpqOUJablhhTUdBTDBrSlRTYXZSRjdacXBmNmIxM0s3Q1VRNlhtSXE1SjhB?=
 =?utf-8?B?d0pDSlVhYm5NVWZZRnZHZ0c1OHprWnNlZWV5T2Nsa2crMXVKTUhnN3JqaUJm?=
 =?utf-8?B?ZUg4TlQzRkxmQ0tRYU11NUQzcmV1cEdxUmFOZ21TOXZadFVFTmlWejN6M0Nk?=
 =?utf-8?B?QitUbjNBMXNESFhVbUlkYU1qRit2aWlteWY1em9yRnhmbmtZTzViM0d2UFpK?=
 =?utf-8?B?Z0dZRVlFRElTY3QyOGp4Qlg3MDYxZXVrQmlGNmxxRnJ0bW9ldFc5ZytTNHJB?=
 =?utf-8?B?cE1LWURRUks4Vk1zZE1heTB4Vzl0RUNlK1djd2NOQlNyQ2FJbi9VbjVIUk1k?=
 =?utf-8?B?bDdWNXIvSW50SzN5V2JKMi9reVdVRjk3bDJMZXVEbVZ5c2QzMThoMXkyS0JN?=
 =?utf-8?B?SUlvKzhXdWJqWS9yK2IrUERCTDF2MGpVQkwyRDJFMkZwZGprZW5DYmxOcFdi?=
 =?utf-8?B?aTVsdzdhUzNZNkdtQkd5L3BMQnY4ekRNNFlaeTdyTlpWWWRsZ0V3Q2wrTnV0?=
 =?utf-8?B?K0Y2bmRtdTZrSzBRV0hmVnk1UGpweC93Q1JTb2pIY05TVlZ3dm1FUXFrM0JX?=
 =?utf-8?B?eGFMbjJaTms2MjZUSm5Pc0o5UmFSS296UUxFQmQxRDFhUTExZmRmYXBTQnd6?=
 =?utf-8?B?QllvcEU5ZU5TeWJkTjZkaDBGTzhMWTZjenNCTGE5akZyK0ozdjJ4YjNZS0p6?=
 =?utf-8?B?V3lTam9ZOGMrMjk1cmJ5MGh2MVNNOHpUMEJRQmQzRTZRQnM5K1hoU3RpTWFZ?=
 =?utf-8?B?dWFwMmd3ajVubStXTXpES0Nib3F2VmlENzg2V0gwZE9aS1lUN2JXbTlFMFZt?=
 =?utf-8?B?d1ZwZnZ2d1N2WFIxUm13L0Z6aG11bnBlanBVVHRDUFJ5S3pmakxaS2ZOeGdJ?=
 =?utf-8?B?T0k3THhUcnhiUU5PWTFNTDNLTEJNZHg5bFM0OWthRlJXVTgyU2x0RzVZcEln?=
 =?utf-8?B?T2RzQ3NDeDFqQ1oyTWh4enRMbm11MVlkQnZqdDA0MzN6Qzg3dmZtWVpubFBw?=
 =?utf-8?B?cmoxQjdYaTB3VWN1VUhIajBUZE9INnl2VGovVDU0RUhjTERQdzFSOGxHa29P?=
 =?utf-8?B?S1JuNkFleUQ5blV5aGNnVDkzWWhXMVhwdGFsWjhKWkhNbFQ1WkZ3RHFKb3dH?=
 =?utf-8?B?MS94cFpzbS8yaHYwZEtjMlo1TGdsK1lzU09BZHNzbzJnU1RGbEVpbmZ2WVlW?=
 =?utf-8?B?OVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WkpCyLPS1QovXlKPZ3M3HxEcR9+XbQDoq4AH/xYHyX0sXHOGNiN1j1tF9mR6+3SAGjLMBoc5Xi/seolULWnrY6y7zc438MbcinK0SPAmVKXNwHc6YKSsQ9QMWXK6SdqmJUuASnICvOshglTaPgQPvCd2dATSLEIxEjo1huq3JckwoAtU6Ur/TzpaAjqjqXjTVHyBHxvOqCpLkS9KckM0G8vB2Q6vkHLd0I9n8lPNCh/BmROViJMBgryWb4wm5cicl/r6F7wXdSJFQWZR3pJft93cfFl5zE3ON9sxaRh817Le+JuyuDni+EICqb28zN2+y//1EKf8iC3BQr0BllaK08KbxEySPHjNus/24AXnqIWcCRs/29362BDcGIAn1wiaM8APZ+Zza73fxFUDLTYNSKxbHhRejft2PSZ9/Mi3CnutlY8fLDchregJr4jHu4moeZp3dckEK+bUn7/q6eDw5eiryYd5pu4dCVbvKUBl2alCaQMaatBV8Zj6phb2LzoMBSwqeH7+ZQPppIiGSsJ0oi2e1yElJ2o6u6PXPHm64kWCRlRQSfxZ1Ocag/SfAy6K35Z1gPjLtvZzDB40tdlWgpRY1JyrjRAWBuS4nCKPvFE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4462810d-4531-4ff2-253c-08dcde42a8ce
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 15:48:26.2892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kVZ/jEpfNljHEsk1WT+sdGTHAj2pkQJmDqBn3UzjgFs109xMA1Tm/q+fH7EDwPfUimXeRgy3jQyqnYu/eIXkC5pT5NVqhGagm9r1rluBjuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5632
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-26_04,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409260109
X-Proofpoint-ORIG-GUID: WQH91dY0WIRINDmPKfTF7ybVD6Bw5PxW
X-Proofpoint-GUID: WQH91dY0WIRINDmPKfTF7ybVD6Bw5PxW

On 9/26/2024 10:48 AM, Jason Gunthorpe wrote:
> On Wed, Sep 25, 2024 at 04:04:26PM -0700, Nicolin Chen wrote:
>> On Wed, Sep 25, 2024 at 07:43:22PM -0300, Jason Gunthorpe wrote:
>>> On Tue, Sep 24, 2024 at 01:31:37PM -0700, Nicolin Chen wrote:
>>>> On Tue, Sep 24, 2024 at 08:05:31AM -0700, Steve Sistare wrote:
>>>>> +static int iopt_map_common(struct iommufd_ctx *ictx,
>>>>> +			     struct io_pagetable *iopt,
>>>>> +                          struct iopt_pages *pages,
>>>>> +                          unsigned long *iova,
>>>>> +                          unsigned long length,
>>>>> +                          unsigned long start_byte,
>>>>> +                          int iommu_prot,
>>>>> +                          unsigned int flags)
>>>>
>>>> I think we should follow the existing coding style by combining
>>>> lines that could fit within 80 characters each.
>>>
>>> To make life easy the "coding style" is mostly whatever clang-format
>>> spits out. "git clang-format HEAD^!" for instance will adjust the
>>> current patch.
>>
>> I see. That's useful. What's that exclamation mark at the end for?
> 
> Manual page git-rev-parse(1)
> 
> REVISION RANGE SUMMARY
> 
>         <rev>^!, e.g. HEAD^!
>             A suffix ^ followed by an exclamation mark is the same as giving commit <rev> and all its parents prefixed with ^
>             to exclude them (and their ancestors).
> 
> It is the syntax to make a range that includes only a single commit (HEAD).
> 
> Though HEAD^ probably makes more sense since it is computing a diff
> from an absolute point.

Sure, I'll apply this to all the patches for V3.

- Steve

