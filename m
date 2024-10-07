Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4B21DA0E0
	for <iommu@lists.linux.dev>; Mon,  7 Oct 2024 16:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728317167; cv=fail; b=UKp2K/hGdiFC9uC7P1XG9patXoA4xG9yaJ8hHH7AsA226IrwEkU13ZtmLP4OHZEGCDbq6zQ8MOVhp5pN+VsPbvyc2h5iWQyb7R/O+4icTtTlJV56YsIdGMxZsLl1TWQeTCHu3P7hwSWjbArhJ6d58epmgnktI0CRus9gGK2lVK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728317167; c=relaxed/simple;
	bh=eOsAigPI1jaKT87WcnHGnONyHMQoRjqySX/JB6cRzG4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HU9AeSTVVfO1kvN+6dq/DvBQ0FX/n5w8xa8Vn86arMjcfQpy/PM48GcVt5ChL3e6OWa3cPQ+J6Mv/8792lEqcB2S3F9z1lcRKu4UPpfAD+Uh2PhppfPRLGPjZ8lQAVqihOqLyXoWv3IhyS/w+5sxcJfIP4AIdQj3KcncLH3CiKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B8YEZply; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hKVcs9Xy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B8YEZply";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hKVcs9Xy"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497FMeji016400;
	Mon, 7 Oct 2024 16:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=CahU/5/nVuaAAjlXcTmr/gOWyY88dqvx+VBoYYZfth8=; b=
	B8YEZplyKasFtBHz5nIhIrgqQkazp6AUmjTFyWI/ZsyigpocbhFtk2ovyMZ/9NyL
	EJGWlHgw8fn3+V0vUI0KDzZwBpl276zClNng0R/loWtCBtrxs32B/WWBnL6LU3iN
	OeSVFFyAVtchquj3alZc05s4dwXkrDZ09qvahQj49U5f4z76n26OHvstF3MHVWZx
	ILhY4N0+R78Z51H5USKyYPO4ospnHAtU8cYHA6p4sNUWQAiKVBGVozc7vIkPHgct
	7zWkeS+uofir22UZw2+MIIFYHP3fufS5rv1rh4t59tkthAa7ewH1vnmIFYVcZ8mZ
	b/k56hLNZ4NIMmrQeot4gA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42308dkru4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 16:06:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 497FgJw6003237;
	Mon, 7 Oct 2024 16:06:00 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwc8pcp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 16:06:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CKawVPXNUkR0IR3We8BXmJlEHEKnzDi1dmZOqhHtATjWg4dXpU6qdqHoN7DM4rYLuTMUiD1ijQTF3PZJOXK4RHiw1Hyzgdu7hyTDlBaVpIzEibeZzCPsBUCC/miirJBPRmjXM0sUr/B5lAp34x0xSqzHhxEjA0n7xSHk9rBZHd8smWydfwHWvHayI+MBs0zEBfEtSFykDk8noN3OD3YSiSEWULmvvc/ipVJeEECkYPubb54Iutdb2gEWWvqI2wyM0jxXi/x6j6qoOJd7evm6Q+Xf7J8Zrvewop0yridLpvykisalD61A+rYdS89H54Hm8kSZ/sEbSaAqs3OYONC1zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CahU/5/nVuaAAjlXcTmr/gOWyY88dqvx+VBoYYZfth8=;
 b=vuamSbReRdihemk/UvNXlzs5VopLQ/Adp3otflBQ7dqWZUL8sdFa0Lkr5JzNZIqAfyu4DMInTXX9E3532McwHu25fjBNgfnOcIE8qQ5hKoacsjlCoD/73pm5debPJernOAkZwWD5nPTb3DtihQzs+tTI/+3R6nGJnAfpDonHaTjjSFcvFck46INV9q9K86HKaBX1Yv6elJzdh4Ccy+Oq4SmBSd1vcOZMiQsqH8XVf4zKKQSpCCGfXsJNA+A+xpoM3Upl70PFp/ciqCso7T1QGeBuHdA0IFlgJ57C/mm8WinUvFa81ppjVRfl7h7SOr1W+iCz7f+UDZ89b5XPhw9zBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CahU/5/nVuaAAjlXcTmr/gOWyY88dqvx+VBoYYZfth8=;
 b=hKVcs9XyCAanKeGuaUN9sE7++IiU7KpM4aTrz3R3v1fb7bQnsotnn9ly9sUVl0Vb3r53wm0hPYPsk6IPG96mxGPPHm6pvXdajzW2YGZ7m2wY1eET7+tyNH2s0fle7uR1wYP4U1VOOMxkbjDeFhiJLwzZ50kDixn+86RYFaTmLsk=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH8PR10MB6387.namprd10.prod.outlook.com (2603:10b6:510:1c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 16:05:56 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 16:05:56 +0000
Message-ID: <dc921950-dd84-4796-8ed2-c644b0d10a9d@oracle.com>
Date: Mon, 7 Oct 2024 12:05:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 4/4] iommufd: IOMMU_IOAS_CHANGE_PROCESS selftest
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
References: <1727358828-97791-1-git-send-email-steven.sistare@oracle.com>
 <1727358828-97791-5-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1727358828-97791-5-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0634.namprd03.prod.outlook.com
 (2603:10b6:408:13b::9) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH8PR10MB6387:EE_
X-MS-Office365-Filtering-Correlation-Id: ca31874f-4bfa-4ae9-4b0a-08dce6e9ed38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WlBrTytpNDY5emtqWTgzZGFIbkNDT1VONW9YTEVjMU0wQ3JYdzd2Z3dUVHpU?=
 =?utf-8?B?TWs0WWo2elUyZXlaNjlmYkUvNUN6Y21UeWVDVTErZVczY0l3elhHbVNtTmpN?=
 =?utf-8?B?OHVlbE0xanUyd1NPVGJvRkxrd0NjeXV4eENmbGtLcXVYYmVUWEpTL3Erb2lv?=
 =?utf-8?B?MEsrMUIwdDNYcUtFMkNKMTJwMUhzN1V3dmlzL2kxK28rUVBTUFJvTlk0SW9K?=
 =?utf-8?B?VTJDWndkQk1NVm4xTjBPVENNTUtHUGJkMmYzUmYzK1VLMmd5ZzRXUGh2cDVW?=
 =?utf-8?B?U1MxbWx0YzBxWWFQWTFibW51VitGNm5NL3h1c1RXMVR3QVM5ZFdWZDlsQVM4?=
 =?utf-8?B?d1NyL0tuYnRFNDlIU3crNDY2TUpybnBRRGNnUzRmdTBKOUZqeHJwMVlvZVQx?=
 =?utf-8?B?bSsrWk9QTjh4MkU3K3BmNXdOWGl6N0lreFNYcWFnMVQzYXpGY0grVHpvU3Bn?=
 =?utf-8?B?cHd4STNEb21QTkJDbnNkSlAxYnl5dFdZZUgrNS8wL0RFMngyZDR0NW5MOXRW?=
 =?utf-8?B?Wml1NWJIaFZzYjFNMS9vV1JIWUhxTzFJQWxQd2NDMmFsZGI5WkpIUVlvMzFr?=
 =?utf-8?B?bGVxU0w2UnV3aGx3dlYzQ0VmRVBhd0pTZE5rd2tCZWRVL05NaXhZcloxOHQ5?=
 =?utf-8?B?QXB4WDIvS2dqdkhjbmpDaExCNzhRM1JONHYzVHo4R0lwaWFSVTZCZ2NwenQ5?=
 =?utf-8?B?NE5uL2I1Q2RIUysyNFVid0lOV0N5TS8wdjJ3cGdxTkgxalc3cUhvK1p2WkZm?=
 =?utf-8?B?NjZVclhvVlhuNHZWeEhzVDJPWllYTVE2ZVZGYTBCWEtQNGowNzdTMWVUVjky?=
 =?utf-8?B?RjZFaXI0QXRSaEd3RGxYWlRaTVhSTHIzVHFabEFFWHpjazVHTGtOK2FNY1R3?=
 =?utf-8?B?SC9rY0FETGF3UjZ3RlFGaHhVcXNhdk4wbjYyU3VoY01Qa1Yrb0RJMG14VGkx?=
 =?utf-8?B?NFFESUpiSHZhUFJwL3NCQkhlTEFBRk9sUHhCS1RBRytzZ2JlTGtwaS9UTmh0?=
 =?utf-8?B?eS9OY0ZabmdVOVVGR2VGenNrUVJOY0ZQLytuM1g1Y0FuTi9veXJsSUhxdUJ5?=
 =?utf-8?B?TitJMXoranVwSG40dVQ2dmlXOXhmR2FSek5jUU04dTRnSHlFNldpRkw0b2V3?=
 =?utf-8?B?SDJ3eU5iRDVJZGJjUTFIUkZKd3p2WU0wUGRNM29JbmNDWFdObUtkeTZiaHVM?=
 =?utf-8?B?OXZzZ2ZucUo5NXFQUzl2YW5xTm1SV2VQdWRPY3I0WHBhd0hxdTJaZWw1bVp2?=
 =?utf-8?B?QlNEOE9hUnY2K29lRE04RzJJUGJKVHExZjN4ZFBNNEZGRjA2RjBzWVVBWWVk?=
 =?utf-8?B?dUhBN3NXdWMrQnVocEs5MEIwZm1hY293U3hOR25KMFZIWUlweXpwOGpQVVkr?=
 =?utf-8?B?dTVvaUExQWF6UVR6MCtzYkE3aWpwR05xdmx2NGExUkFuWTF1aGVPUjRHd3RO?=
 =?utf-8?B?SXh2bEFwNHMwbXNrOVFwZDVjNlgyQnBMNnNjcE5USDM2TEltdUJubzhTaHNJ?=
 =?utf-8?B?bG9ETE9MTzJnaXJmcnVGdG8zc2xIS2czOTB3OExmelpsREZUWUJ2VkFodXU4?=
 =?utf-8?B?MnhUcDdVOHQvOTJhUmIrSGprUy9HRzFFSW42MEtnTDVaRFRUN2FKQ0dORy80?=
 =?utf-8?B?SjNqcFlTdU1NUFNlc0h3SS9hNWtBWlppMDZyQ3E1SVBnRUtMR04welI2MXph?=
 =?utf-8?B?YlZRckVFeUVwYUVzcER3M3VyT3FjZ01yamV1VWQ0K2hlUW9uazVRZjZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1dQNFhXSENacjBQS1VkMHlxbERBdmx0ZlpwZUZrSUNkc292QThzdVZmYjY2?=
 =?utf-8?B?aU9UMlprcFBFOTJmVDlEbWpPcUozb2t3eVo2cEs3RVdVNS9ibzFrL00yMElw?=
 =?utf-8?B?clBDN1ROdnJUV3VTN0FqVmMyVzREYzNmSjlpWVVyRTNaMkthMDlucUtwcGYz?=
 =?utf-8?B?cngrSURoVmRaMDJZNnl0S2tGR2o4N0NOa1cxRG9kTmlsWjFib0FOZ2Q4M3Ja?=
 =?utf-8?B?YnVxUTRLVEZ3SGZzWGlFY01mdHBuM2tocExpdDFONEh4N2ovS2VWWEQvZGQ5?=
 =?utf-8?B?R204UlVFeTYyLzltZjR3WGtuNWwzTWJwK3VIVU9TV1pIY2xmRE5JQUMwVlBw?=
 =?utf-8?B?K2xOS2lXUXYvTEVzbHYwdHJPczJndjZza21xYWdXL2JqWUU4VGJ5QXNOYXNX?=
 =?utf-8?B?a25oT090em9abnA2SjByTnowSjZWcE5PUjBBRnZzTnovbnFDVU5NWXhFRVlS?=
 =?utf-8?B?OEI1NHY1RG9uNHZNUmZ2QndkREJHbzJSbmkvbmhjejBENUF0cEdhb29lRmV3?=
 =?utf-8?B?Z2pDZGM1Z2c5RVZvcjVCVVhGZFdYZ1p5M2NleE1YYWVleVYxa1o3Wmlua0RQ?=
 =?utf-8?B?ZkFrT216Y2NNRXlBbmwvWmRlN25PRm4xYW14RG5sNlhGL2xBSVlDVkgrVGhV?=
 =?utf-8?B?d01PNStBWmRvdXc2YUl6YTYwUUdENTJqZTRPWTNDQ0JpSGM4Zmx3Si9vQXU0?=
 =?utf-8?B?bFJNa1VzY1o5cWdrTlNUOEo4amlpZU9jaC9qN1dBS01aQ2ZCeEpKS2U5ZGQ5?=
 =?utf-8?B?c0ljaVovY1kyTk5BUERKaDEvcTU4enZHQjRudlJ4NWdSU2FxNEw3TW8va2Vy?=
 =?utf-8?B?MzllczlxdW04SFdqbXpRQU9uZkg1NElBZTlkNmpOOGI0RHdwNWVhc3pPZER4?=
 =?utf-8?B?ZklXVUl3cWtXY0ZkZDFzcElyOUlWS01xbUlySVlBTHdrR2Znb2l1NXdVSVo5?=
 =?utf-8?B?L3FiRmROVU94Y00zMEVMdDkyZFF1YXE4WXBaVCtTd0FmUjY3Sk1PL0F5RlFm?=
 =?utf-8?B?WHFRS3IxemZVUHZpb3VjYjc2ak1EWnRXRmZ2aEZ6UmJMOVRHSnlQZnJ2cGhI?=
 =?utf-8?B?ak5Ja0FHUHB2cnlweFNzdnRleFNHQUh5VHh0eXp6SytuOUpPRkVWUENrNmdr?=
 =?utf-8?B?K01ZRndFakUzaFZoSDFSbmkwME1hZENjQktPQUZHRG5VcFcwQk9tdHVwbGUw?=
 =?utf-8?B?NktlR0ppYmRlRExnelpQTFZOMUw2VXVGbTJ1N3FpVmsrdHBLV2N2bStENG5V?=
 =?utf-8?B?amQwbUFyUm84UmFSM0xLazNCQkl1NEJnMWhJYWRjNWFxKzJhT0hXVThEdUhv?=
 =?utf-8?B?VjZvcENqOUxvL0dVS2FVaSsvL2UxQUlKOTJybG1pYlAvVnBJUUxuamk5U1RI?=
 =?utf-8?B?WUcxY0c1NlhlOGp5NW9yR0thQ0N4amtodFVwNHBMekhSZmNuNnZSQU5qMFpN?=
 =?utf-8?B?Smp4WkZhSm5lL0hqSkE2OUlJVzNsWnI2ZjV3UEhYQkZmczl6VTdqSmI3ZVB1?=
 =?utf-8?B?QXRaMnFhcFVJeTlLdEY5ZjRkSFdxYmFnWEtEOUtyZzY5cEJnNHpXd3R4dktY?=
 =?utf-8?B?Qi9xZTJPUy9NUVM4ZStsSEVIdENUMHFpQ0hXMUpXdHpZRXY3N2pIalBreVBQ?=
 =?utf-8?B?RWZhYzJZdVo5eHpENzhqdzlQN2xWdDNUTmhVbFNEU1E1a2p1M3ltMHgyZWVm?=
 =?utf-8?B?amN0eCs5QTcyN21HVWRIVnMya200TnRjMStUWitwYytoNmtTVS9mWDk0dG1M?=
 =?utf-8?B?Z2VHVUJoc2VxcVpKc3EyOTB2Vkx3TFdFVlFqK1lnVWZ1NXlhZ09OTWZoWXd3?=
 =?utf-8?B?VWd4bDlCZ2plc3MyTlk2SUNhTnd6NG1WS2pzUVNib0lFNWpUeU0rT2pIODRT?=
 =?utf-8?B?WWNmVStZeGluM1YzRTZwb2l3TlNaTVpPMnJFUDdXOExUUXZXd2h4enhZbkd6?=
 =?utf-8?B?S3VXbHUvV1kwR2h1cGtNNWlIOVRSS3NtL3ppSE96NW41bFZIeHRoTmxLWXpx?=
 =?utf-8?B?S1RNSkFtZVUwalF4VXJkWkVtTHExc25mN0txNTdjR3NZQXRrMlRxWEpHRnlR?=
 =?utf-8?B?MVQwT1VvMUFnbndncExRVzlmSmpFZW9UMkMvOG1VNE1US2xtOUhtRTZJeHFp?=
 =?utf-8?B?RVJoeHVZRU5xb1g0YjAyQWJtTVZLM28rYkxLS3VESThRWW5qUzUzci9ySXFK?=
 =?utf-8?B?UGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EJZi9dL9lYnO+0xLLtRXPjwvnWI+DHGOlNv1yqbJhBGVCO/yqHbHK8nhRKF6dVZc/flJeKQHRnbTerwnTAIiw8i6kEBjZBz+2zAX7Y9OHHy84C1oqcg0//nDA4Fu1fPIa8fgcnSbL7LeVh6HyEiMUfJa1JcHFhgt3wmCh6m8pMlImiy3icjQvYW7dgYTziQJsI8pqGuaXVSWKMnXa00Se7yNezN3DiMhwPBcPQ3bHahY79vme4c+PKxmgmgxk50R1+h9hupmXaMAarYuuXc6LjabwSvxYSTwsp5KegA48uwfieXBuOFn5LZ+3/k3j4Mw/iskbsPW87LYychlqFtVRBSOA5PNSdIdDYnXUoutlIYJ0OkAwQnFki+mDW2t948fMZ+vMUoLSnxvpLtRK0oHfq1EsHxQV3g4lN9lbF0VeelOF3QzrSA4nHXzwXFv1DOrR03m8tWfD6axM/fpbNC+RurnkvlzVqMhWMAvvB1DR0ZLkC8RbwOrE/PRfYEi5uz9EoWbliaSYzgqfhIClERvoMFp0++wafoBgv/o652Y+uRpTAkYQNKRoZpShTB6lej6tPbWfEzDZ7nXgcvyRvtofjIEOnk9hy7wFdLBV+rjmIc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca31874f-4bfa-4ae9-4b0a-08dce6e9ed38
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 16:05:56.3264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40sCvNrG4mc1hc/wO+mtMMJ0rbrarb9h4Fq24w5BgNf+Gd31hLa80r21FVHh8w53BV6Tkq2lwv9YJMjOU+bzyFnzQHhXdIUBNSIaR3jGLWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6387
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_08,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410070113
X-Proofpoint-ORIG-GUID: afNTSCC9TPMms6dV6fi7JidziwlHI3rv
X-Proofpoint-GUID: afNTSCC9TPMms6dV6fi7JidziwlHI3rv

Hi Jason. Do you have any comments or RB on the selftest?
I am ready to post V3.

- Steve

On 9/26/2024 9:53 AM, Steve Sistare wrote:
> Add selftest cases for IOMMU_IOAS_CHANGE_PROCESS.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   tools/testing/selftests/iommu/Makefile        |   1 +
>   tools/testing/selftests/iommu/iommufd.c       | 148 ++++++++++++++++++++++++--
>   tools/testing/selftests/iommu/iommufd_utils.h |   8 +-
>   3 files changed, 150 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/iommu/Makefile b/tools/testing/selftests/iommu/Makefile
> index fd64779..bd23ac9 100644
> --- a/tools/testing/selftests/iommu/Makefile
> +++ b/tools/testing/selftests/iommu/Makefile
> @@ -1,6 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   CFLAGS += -Wall -O2 -Wno-unused-function
>   CFLAGS += $(KHDR_INCLUDES)
> +CFLAGS += -lcap
>   
>   TEST_GEN_PROGS :=
>   TEST_GEN_PROGS += iommufd
> diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
> index 6adf84f..5cb8b28 100644
> --- a/tools/testing/selftests/iommu/iommufd.c
> +++ b/tools/testing/selftests/iommu/iommufd.c
> @@ -5,6 +5,7 @@
>   #include <sys/eventfd.h>
>   #include <sys/syscall.h>
>   #include <asm/unistd.h>
> +#include <sys/capability.h>
>   
>   #define __EXPORTED_HEADERS__
>   #include <linux/vfio.h>
> @@ -215,6 +216,144 @@ static __attribute__((constructor)) void setup_sizes(void)
>   	EXPECT_ERRNO(ENOENT, ioctl(self->fd, IOMMU_OPTION, &cmd));
>   }
>   
> +static void drop_cap_ipc_lock(struct __test_metadata *_metadata)
> +{
> +	cap_t caps;
> +	cap_value_t cap_list[1] = { CAP_IPC_LOCK };
> +
> +	caps = cap_get_proc();
> +	ASSERT_NE(caps, NULL);
> +	ASSERT_NE(-1,
> +		  cap_set_flag(caps, CAP_EFFECTIVE, 1, cap_list, CAP_CLEAR));
> +	ASSERT_NE(-1, cap_set_proc(caps));
> +	cap_free(caps);
> +}
> +
> +static long get_proc_status_value(pid_t pid, const char *var)
> +{
> +	FILE *fp;
> +	char buf[80], tag[80];
> +	long val = -1;
> +
> +	snprintf(buf, sizeof(buf), "/proc/%d/status", pid);
> +	fp = fopen(buf, "r");
> +	if (!fp)
> +		return val;
> +
> +	while (fgets(buf, sizeof(buf), fp))
> +		if (fscanf(fp, "%s %ld\n", tag, &val) == 2 && !strcmp(tag, var))
> +			break;
> +
> +	fclose(fp);
> +	return val;
> +}
> +
> +static long get_vm_pinned(pid_t pid)
> +{
> +	return get_proc_status_value(pid, "VmPin:");
> +}
> +
> +static long get_vm_locked(pid_t pid)
> +{
> +	return get_proc_status_value(pid, "VmLck:");
> +}
> +
> +FIXTURE(change_process)
> +{
> +	int fd;
> +	uint32_t ioas_id;
> +};
> +
> +FIXTURE_VARIANT(change_process)
> +{
> +	int accounting;
> +};
> +
> +FIXTURE_SETUP(change_process)
> +{
> +	self->fd = open("/dev/iommu", O_RDWR);
> +	ASSERT_NE(-1, self->fd);
> +
> +	drop_cap_ipc_lock(_metadata);
> +	if (variant->accounting != IOPT_PAGES_ACCOUNT_NONE) {
> +		struct iommu_option set_limit_cmd = {
> +			.size = sizeof(set_limit_cmd),
> +			.option_id = IOMMU_OPTION_RLIMIT_MODE,
> +			.op = IOMMU_OPTION_OP_SET,
> +			.val64 = (variant->accounting == IOPT_PAGES_ACCOUNT_MM),
> +		};
> +		ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &set_limit_cmd));
> +	}
> +
> +	test_ioctl_ioas_alloc(&self->ioas_id);
> +	test_cmd_mock_domain(self->ioas_id, NULL, NULL, NULL);
> +}
> +
> +FIXTURE_TEARDOWN(change_process)
> +{
> +	teardown_iommufd(self->fd, _metadata);
> +}
> +
> +FIXTURE_VARIANT_ADD(change_process, account_none)
> +{
> +	.accounting = IOPT_PAGES_ACCOUNT_NONE,
> +};
> +
> +FIXTURE_VARIANT_ADD(change_process, account_user)
> +{
> +	.accounting = IOPT_PAGES_ACCOUNT_USER,
> +};
> +
> +FIXTURE_VARIANT_ADD(change_process, account_mm)
> +{
> +	.accounting = IOPT_PAGES_ACCOUNT_MM,
> +};
> +
> +TEST_F(change_process, basic)
> +{
> +	pid_t parent = getpid();
> +	pid_t child;
> +	__u64 iova;
> +	struct iommu_ioas_change_process cmd = {
> +		.size = sizeof(cmd),
> +	};
> +
> +	/* Expect failure if non-file maps exist */
> +	test_ioctl_ioas_map(buffer, PAGE_SIZE, &iova);
> +	EXPECT_ERRNO(EINVAL, ioctl(self->fd, IOMMU_IOAS_CHANGE_PROCESS, &cmd));
> +	test_ioctl_ioas_unmap(iova, PAGE_SIZE);
> +
> +	/* Change process works in current process. */
> +	test_ioctl_ioas_map_file(mfd, 0, PAGE_SIZE, &iova);
> +	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_CHANGE_PROCESS, &cmd));
> +
> +	/* Change process works in another process */
> +	child = fork();
> +	if (!child) {
> +		int nlock = PAGE_SIZE / 1024;
> +
> +		/* Parent accounts for locked memory before */
> +		ASSERT_EQ(nlock, get_vm_pinned(parent));
> +		if (variant->accounting == IOPT_PAGES_ACCOUNT_MM)
> +			ASSERT_EQ(nlock, get_vm_locked(parent));
> +		ASSERT_EQ(0, get_vm_pinned(getpid()));
> +		ASSERT_EQ(0, get_vm_locked(getpid()));
> +
> +		ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_CHANGE_PROCESS, &cmd));
> +
> +		/* Child accounts for locked memory after */
> +		ASSERT_EQ(0, get_vm_pinned(parent));
> +		ASSERT_EQ(0, get_vm_locked(parent));
> +		ASSERT_EQ(nlock, get_vm_pinned(getpid()));
> +		if (variant->accounting == IOPT_PAGES_ACCOUNT_MM)
> +			ASSERT_EQ(nlock, get_vm_locked(getpid()));
> +
> +		exit(0);
> +	}
> +	ASSERT_NE(-1, child);
> +	ASSERT_EQ(child, waitpid(child, NULL, 0));
> +}
> +
>   FIXTURE(iommufd_ioas)
>   {
>   	int fd;
> @@ -1548,13 +1687,10 @@ static void test_basic_file(
>   	buf = memfd_mmap(buf_size, prot, MAP_SHARED, &mfd_tmp);
>   	ASSERT_NE(MAP_FAILED, buf);
>   
> -	/* EFAULT half way through mapping */
> -	ASSERT_EQ(0, munmap(buf + buf_size / 2, buf_size / 2));
> -	test_err_ioctl_ioas_map_file(EFAULT, 0, buf_size, &iova);
> +	test_err_ioctl_ioas_map_file(EINVAL, mfd_tmp, 0, buf_size + 1, &iova);
>   
> -	/* EFAULT on first page */
> -	ASSERT_EQ(0, munmap(buf, buf_size / 2));
> -	test_err_ioctl_ioas_map_file(EFAULT, 0, buf_size, &iova);
> +	ASSERT_EQ(0, ftruncate(mfd_tmp, 0));
> +	test_err_ioctl_ioas_map_file(EINVAL, mfd_tmp, 0, buf_size, &iova);
>   
>   	close(mfd_tmp);
>   }
> diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
> index 7bc664e..14c9f9d 100644
> --- a/tools/testing/selftests/iommu/iommufd_utils.h
> +++ b/tools/testing/selftests/iommu/iommufd_utils.h
> @@ -22,6 +22,12 @@
>   #define BIT_MASK(nr) (1UL << ((nr) % __BITS_PER_LONG))
>   #define BIT_WORD(nr) ((nr) / __BITS_PER_LONG)
>   
> +enum {
> +	IOPT_PAGES_ACCOUNT_NONE = 0,
> +	IOPT_PAGES_ACCOUNT_USER = 1,
> +	IOPT_PAGES_ACCOUNT_MM = 2,
> +};
> +
>   #define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
>   
>   static inline void set_bit(unsigned int nr, unsigned long *addr)
> @@ -617,7 +623,7 @@ static int _test_ioctl_ioas_map_file(int fd, unsigned int ioas_id, int mfd,
>   					       IOMMU_IOAS_MAP_WRITEABLE |    \
>   						   IOMMU_IOAS_MAP_READABLE))
>   
> -#define test_err_ioctl_ioas_map_file(_errno, start, length, iova_p)	     \
> +#define test_err_ioctl_ioas_map_file(_errno, mfd, start, length, iova_p)     \
>   	EXPECT_ERRNO(_errno,                                                 \
>   		     _test_ioctl_ioas_map_file(self->fd, self->ioas_id, mfd, \
>   					       start, length, iova_p,        \

