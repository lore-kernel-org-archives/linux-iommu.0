Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4803C156
	for <iommu@lists.linux.dev>; Mon, 12 Aug 2024 18:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723486163; cv=fail; b=MALsGgcsUbLm5X/LuHhhxlrrYo4lQF78nXwSWUdLbo531pCJ9kDjYsSJXa5Mb6EvUQcesEn4HBsVuSU2E4tlEOvwW2l9/inwKImPe2fMa/SNNqJgJJeEnSCzoJpACkyakofGqkIUK2lq5clp4KSsNkq7BtKaXCasKELXukrrbNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723486163; c=relaxed/simple;
	bh=IFUb2hsaex2x3yANnePm6c41eYHubFSRnMyc/2SAswg=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=jK3q/k3rLlWyjWT3BJH7mkEypjxjBy6Rq5a5auVZG85rvAkXodBY83vUg+GW5Qe2UDRXMI5Mx4t8qFj5zooydHMhxKOScNAh0ThRySlTZOOeyHtQ5r3z8lTkV1vYOBQ4U4emug+JH0FClLrFJ/Sizyg+XnsAjaod0uq2JejBXM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HZdUGlOB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w8Thp5zB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HZdUGlOB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w8Thp5zB"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47CHXWEI007086;
	Mon, 12 Aug 2024 18:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:to:cc:from:subject:content-type
	:content-transfer-encoding:mime-version; s=corp-2023-11-20; bh=D
	N8P6po5rHuBlat3wtihUxb2SN5Ru3LHEYQLDDUYfXg=; b=HZdUGlOBhesmmVJqk
	qMvf70Xqv7UTw6W/ORpcC8EiiWBAf+LXpcMUqIuw8ASF2vv3uAkcwKmtFnTAaYge
	7pzMBzFktcEzn1W1lux6plL8o7YOQdUbvFnwvH6KDSQdkTOj7S636hZzCjbIc/6Q
	tl884F7ed/gaSb3Fd1PfsPmQA7h13bwGYm4wTgQrrXDoUXdaO+/ov2AaHihRzfvB
	FtGpYs9DliED2aUPY8mlgt6+gNAwqOaQ/sBd1R3W1vZ0iMFXrqevADdU3kHqrGTM
	zaTvjlYWNd2xFxtUg+3poDNaZjQsrShH+ahBmq+bUIaD2pWntMaYrWYL2ySFYdmc
	cqW3Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wxmcu8f0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Aug 2024 18:09:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47CGnTmg003356;
	Mon, 12 Aug 2024 18:09:19 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40wxn7eu1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Aug 2024 18:09:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UGCEeri5UFN+2UQmhOB0XVyOYgWJdfye7lUgc2d9QJLgNrBWeloo9xF/R83MZbHna7hphA5WclIv4dZJ4LwBHDoSk7+N6vmZxnI3p5LWfmPWFo7k42aXPXR2XGDNSni+GDsx/5bjE2fd7F5dQHk9bQPqqpqcMEdWjGYGNg/yeWKafysnjse0CsgJdUQi8oHOOI3RKywefpHTqJfQ1/jJTxbNOcGxdhe6kl9QpkBCK30dn8nk1dItv6kP/D18UoXLuw9stXL6MdTfoKsxTgQK/Sn0pppmkEoBC1raNhhSFVR+l6BqbUQTsnJKMBsKjAkU/H8tV2f/9ESTdI3bha1nYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DN8P6po5rHuBlat3wtihUxb2SN5Ru3LHEYQLDDUYfXg=;
 b=HHq132HWS9QKEjclLkUPw5UqCvvP5CFbDMcVQ/bmJ46AAoJqzT9eziWhD9BH3n3bMwBR0OrmhsXZw5eXzD/j7ULMw+f76dgarfAn9++vQHnK9KtSbPrTM9KvY2EBTvRib8lOJz1eoxx2KH8+/8GIgEqeuJOxzQzkHnBpPLGznUzYqPxgdP03YfBSXvnBv2ikXD80ZhtxDA35pxYWR/RMipVPeRwwR/m8fq+kECqJw0hkFd9ff48gl+RJHnqI/w7GW48JRF4G3ZN9IUswFKNYFV6838wb59zMbwDPDgArVWsieFStABSuTysrwouHugHg1HO6ZsaAoB5O1C4Bp2y2Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DN8P6po5rHuBlat3wtihUxb2SN5Ru3LHEYQLDDUYfXg=;
 b=w8Thp5zBUo0YaK5dw79GYLpcJrQo3pzjYjfNZKn5n3/C501J8DAlVpy1rN9kwgFFdL5JjYNUPliYF6qPmx9IhlcFr2mk3iAQSARdqL54BXhjOZ1LptQ6OBU4r0PMvQZeNX37GnzOK+/fRfG0+QdFE8mxXlXsLMbAyBlSJDwwBLY=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CO1PR10MB4420.namprd10.prod.outlook.com (2603:10b6:303:97::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.15; Mon, 12 Aug
 2024 18:09:15 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7875.012; Mon, 12 Aug 2024
 18:09:15 +0000
Message-ID: <a745cabd-5e38-4242-b3b1-da02c1e670a8@oracle.com>
Date: Mon, 12 Aug 2024 14:09:11 -0400
User-Agent: Mozilla Thunderbird
To: Alex Williamson <alex.williamson@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Content-Language: en-US
Cc: iommu@lists.linux.dev
From: Steven Sistare <steven.sistare@oracle.com>
Subject: mapping files for iommufd
Organization: Oracle Corporation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0404.namprd03.prod.outlook.com
 (2603:10b6:408:111::19) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CO1PR10MB4420:EE_
X-MS-Office365-Filtering-Correlation-Id: fdd4ae95-80f4-4e63-7f3f-08dcbaf9dff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TzNTeWlHeU5Ia1lPN0pwRG90VmlzYWdGa3VKU1FmWi9aeVhmK2ovcWExcmFT?=
 =?utf-8?B?dVQvdlQ4b3V2SkZ1Vmp5RTdQUVV1N2pCNlZLR1Q1NnN5R3BlYmliWlZDZkRw?=
 =?utf-8?B?VXAwMmo0b1RyS1J0ZWp0cENtNklUWHZSZ3IzcncxS05Ob1NMeE1abldDeFM0?=
 =?utf-8?B?TmNFSE91U1pHaVJuYi9CQXlZd0t6ZnVnUUJrNTN4TXpHL2dPZ1FheDhmS2p6?=
 =?utf-8?B?OFpndHRLMkdMbmcrRG9wbjdoMk04cHNqMDJvV2FwRmdYVjdxOU9XZ0JLbGJC?=
 =?utf-8?B?bG5vdU81VHEzdUQzUXducmhOMitScStKajNSVU5vMjNidzdkL2MwRy9EdDRa?=
 =?utf-8?B?QjlQS3dHaHE4Tk1QVEwwSFJRcElQMVAydjJkL0NhbGJJbGhmbndlVE5mNFpy?=
 =?utf-8?B?WHBMUmRDeHgxUDk0RUIyMm1iZG1JelQwdU4wQUUzWEowM1dQbDRRcEh4UE9T?=
 =?utf-8?B?dEdEdXNicHhWVkpYa2ZUMXIwRHFtU3hMSkVjd01pS2ZOWk1JZGtaTG85UFA0?=
 =?utf-8?B?bmdUTnhKSnBxd3hXbS9LWmExcUo0M0hlNEVvOTRnd3BXYnQwMHRsTzhKYzVw?=
 =?utf-8?B?dUtEUW8rRTlsRFIrYzc4Y3djWGhKYmhJOFhhUFpqUEtHWjhQS0EvUVpxQTBp?=
 =?utf-8?B?bzdUS29iTXZVVDhzd29UczJSbnZ6U1ROS2ROL1piTVNCNWZnU2RTdkFyQXBa?=
 =?utf-8?B?MzhPY0xLb1grbkJTbmFyMHJET1ZXSHI4ZE9hQ21pWG13VjB3eUJxOVYxWTRW?=
 =?utf-8?B?QTUxWVcrYzB0YkhKMEdZK0FYT2xmYUdmVkFXdm5aNGhLNzQzelBJRnpYYXFj?=
 =?utf-8?B?Rkl2UVI1QWR3dGhyYmFGNzVkNGRSc0JyYUsvcUpkSkVtUkM0NEVYVXFzc29l?=
 =?utf-8?B?VTAycTFKZTE3Qzc0eWYrNmhOUHNINzV6aS9hdkFhK3g3blpWUk8wZ1NJSE1P?=
 =?utf-8?B?RVIyWFlvUTlGNjFlNUNZMU8yL20rZ0k0emZLY2xuRmxtSDFyQ3p3K1ZhYXor?=
 =?utf-8?B?djdkWUdjenZsNXFpRzlhcWVDdkRSeXFRdjZJMk9pQ29Dcm5jOVAvOFZDMmt6?=
 =?utf-8?B?dUgxRHlUZ2NzRDZCa3FKQ3B3MElRVEdxS3R2bk9DbTdTd1FuNm9idkppZzZB?=
 =?utf-8?B?M0tLY2JyTzBrdWl6dzFpazBOU2tqZGM5TUVJbjV0cHZhS3JmYVZ6cmVSSWlx?=
 =?utf-8?B?NjFiRFljN3RBcGJRMWpnbVVhb3U1cm1RS2tTLzFEOFRTbE90WlJocitVK2ZJ?=
 =?utf-8?B?NDhjOVgrNFQ3elBSNjhTN25MRXVCc3VJMnl5SktlaVRSeExRWnJsdjluSnRI?=
 =?utf-8?B?clFzdHdyN2pzRExGdSszZExiVjc3aVUzMCsyMC9iYVNtdU9jMUFNK0JIVEFN?=
 =?utf-8?B?bUdkQStHMFRsMWZJazdDYjBNRmZEbC9VcS9WNU1udnRQZnROYk5pNVV3SGQ0?=
 =?utf-8?B?NUFOYmladmFsN1NGSk5sR1c0Q3FIYTZHaTBkZ1dmYnFOZU4rWnUrWCtHM3p1?=
 =?utf-8?B?THZzbzQvcjRpOVBybWtHa2daQVJBcjkvTUhaNkovSi9CU05VTmd4ZFFXcTNm?=
 =?utf-8?B?dnhSU0dKVnR1YXdhZXNXMTB5QlY1VGVmbmhnbi9PL0lITmhQVWsva2dKYVda?=
 =?utf-8?B?d3BhMEw3UVArUVdhOElPUUh0TDBnVDhsWHJuMThWWm1MMjlGc3Yvd2pEcC9v?=
 =?utf-8?B?M2RiR1pFNXdDN054dDE5MUtaRU8rNkpibkhiYzhleFJaT3k3L2lEeElWemhL?=
 =?utf-8?B?RnVJd050cEh4V2t6TGpYMUFDM0NBcjNaTndKUXpYa1FlczZZbWNmc1pSRE9k?=
 =?utf-8?B?Tjd2dGY3UXFiR2tTbFFIUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnAzREJQdjA1RFJmdXhyUnI4a3FBQ0IzQkRzT0Q0T1lYM3pvYzFVL1NZVDIr?=
 =?utf-8?B?aDgwNm92cmN1ZjZRTGNSVXF3VjdtT2hVZDhsQ0VTcGNoaXhVVTE5RUFLYzA3?=
 =?utf-8?B?MHJMbUZEM1FVRDVhRE1KNXUvc3hVYXZaL3haRWovQ0xoSlN5YW8wbWYrbUdG?=
 =?utf-8?B?cGJwZnJMK1VDNDc4MjVwMkRMbm1PUllzN2lNVHJtVHBGenJwN3h3Mkp0eFZw?=
 =?utf-8?B?NFFJQm5kdDhCTlEvS2JVdUxFbldCYkpxeUtyUlptRVI5aUZ2VzU2Y0I5Snl0?=
 =?utf-8?B?eHhXY3VydmVXWkRyWllvZVo0UVd3ZFZtTkdnc2J4bjA1QW9ZUm90bElFOFpV?=
 =?utf-8?B?dCt4ZGt3YzZDVjhoZnNUQzBhUXQvTDdyS3dCcEdXb3NiMGQ5a1plSWIwMk5S?=
 =?utf-8?B?S0FDaGZoc21WbjhuYWcxc3o1TnBvK1lTaDk4Mk02M3FncnEyRTRwUmJHS0Yv?=
 =?utf-8?B?QzhJWDhvODZyNTU1d1FUTTZoNTVjUmZRRWp6Y3djNFBBa2ZVcnNXd2VqTm0r?=
 =?utf-8?B?WnFSOFFDclNFZWcxdmM1eEJwQU1JM0lZck02bmVGdG1qSFRhbUY3MVRhcjdZ?=
 =?utf-8?B?YkFQV0Rhc3RvK3BkNUdLcFIyMUdxTnB1eEpTOU5CWXZrT3JHVVhIU2orY2xH?=
 =?utf-8?B?WlJMRTBpdmpEZWlpSStNSWJ2NzRmaGRqZG1mcDdoa3dpbUJnaFpBR1N4cytF?=
 =?utf-8?B?cVdVWmdBSGhRUmszUGtWcVpCcC82WDJ6UG9LdjJSSUFVbFQ3MVNqbjhZM04y?=
 =?utf-8?B?UkU4Nk9yZ0RpRmI1dGp5dmFRSEEzMGVKVEUyUnhPTDVVMUsrMWZmS25IS1No?=
 =?utf-8?B?S0ViRGRJQmdwL09ZNSswTU1UclMwYVVQQ1UxU3RDNGg0UWpwYnRsUTBuZnd1?=
 =?utf-8?B?OHo2OVh2ZGMrMnNnaitCdDNZMk9kNUNoQVl2ZC9NN29QZ1A0VnZNWWs3VUhY?=
 =?utf-8?B?alVXcE9lNW5BMzM5S3ZQMjJ4SVJaSTU1bGEwcXhTdGUxTTZQVVd6TTVDNDY4?=
 =?utf-8?B?dDA4YTMrNmx2MThnMVlDNEoxUlZsbW1xMzZZQWpPKy9ZN08wRUV0UklFZlhk?=
 =?utf-8?B?ZjJzNGF4TStvRlN6a2xHYjdKYnlXalEzNzgycnlHSW52Y2k3VWFDejBSV1Vu?=
 =?utf-8?B?VDJ4NFZmeU9QU0QxbDlGelMvSjFod3BZZENtOHAvZlNsd3REVDdwaXAvMmlC?=
 =?utf-8?B?SmlzL2I0ZXB4MmZWajZWQWlEb04rb2hBQUxzYU9GTWExMkpDYU52L0dLMlV1?=
 =?utf-8?B?NHUwUzlNbGVYbjcyMi9ONll2a0tWTVh6NzlHbjFlai9oQzFOSTVxQzJqQkJF?=
 =?utf-8?B?cXl4TkxKaWNQNUpmNkdxWnZ3MitsYVhXUTlsT2dRRWdTbEQ1WlNhRmtBc1hD?=
 =?utf-8?B?L29lY1RRWnhJVzlFUmpzZTl5cDFzS0lTaWtzWFR1WVdBTkpzdFBJOWVzWnIx?=
 =?utf-8?B?bE9sajZzdVRjQllPUzI0R1l3em1sOFhZTy83NDRvVU1ISkZEWFRXMkZSTTJF?=
 =?utf-8?B?aHFkdmpETHdFUjUzRk5la01KZFJhVENxcjNWWnpNL0VoS0pncEsvck83c1o0?=
 =?utf-8?B?SzNKa1NhOHJacitTY1Rnd25IUW42SjYrMjNQY1ptYnNmTTZhWFg1aURCVDUw?=
 =?utf-8?B?eWRNTFJvN0dJamV1ODJpaTJObFlFNkozME5uUXZBVUZZcVhOQXNVRmJSMHd2?=
 =?utf-8?B?TmZaZ1FuOTZsTkwwRHJ6b2dUVm1CcXdmMTlrd25xckpYZ3Z1aHNYNTBqUlVG?=
 =?utf-8?B?YzNYNHNKZU1UdDRvRnBINEloL3BLSU5ibDh4MDBRaThFRVNUa1R6MGFYMUlw?=
 =?utf-8?B?YlZEUG9haXhiNkZoMkRWaWt4ZFkvNHVkeFQ4Z3hTYmw3M1JKUTRpVDc4UUhJ?=
 =?utf-8?B?TnZwUGZFTmVLaWQreUVmbXFpSno1UjNMcW1ETndyYTRUNFdGZUJoUWg3TzVw?=
 =?utf-8?B?RERPT2YrTko3cE9HZEprWEtuM1AxS21WWWprNG43MThZZFRhOTlCaVR5eVJp?=
 =?utf-8?B?VGFnZFh5ZDhydFVENmRBdk5jQ2dsU2daSFViR21rdUIxMm9WR2xNQWFaWjNi?=
 =?utf-8?B?K1ViVmFVRzFhZjhhSllFYS9oVWsyVDVQQmlvL1dybUFpM0E4bTA0STF6Vzk5?=
 =?utf-8?B?djBvUzg3eGJGQ0k4aU9ETGIybmZzZU56SzZIVTBhQnk1aytvUnEwOGR3N05n?=
 =?utf-8?B?TlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NEH9SxO2FFTdkvnBqYujre52v7rfYAs2MAbHErY4SpntPYDZHbTGu0BiwpWokEavo8g7g0pg2qatSrxpuHV+H7mRuNUw1sDg6PGoaFtQhbsQ/i/b/fxXt0vcezfky/xO8CgNCiff/zmjOBG52trBVaO7mYowHEAW1RK6Zd+hB09jR3bT/jz4+MMC195l9z8F8NckgPZdG8Y42iPrag3Hg947dIPnLFKuNNeSNG6G5vs86CvUwKSktYGBVKXuk5iCYBb7i1GpCzQtNM+7bWcOi1KU8ZnTquqr3HoeCJjpMIrCvdwzDPL2gx+gSauHSFJgfS1GWkwd64+KtsvtROoaCYmxuveykdtY4fj7WlIRVl1u5OSqpqXjsstle26gSOYm5FEXC20WVIGCQOCjTDi50wcdodfVD8szPYBsv9FSgWGBwtPBrkVa/zUPb11H/vDC5yD+SGtCghL+rxmuc9MLLdiKyyQ2+mImD5vU5p9MtytVuCyQa6gtIW7uN4trMeObcLsxQYm+ZewRwne0Uoq/SmXiuLtxjFgIvs+3zBoPk+Dor9+vUu8uDucRl+Vw4SUzS3B/H7oQLyKCC+S2Dh0Im5iKNEIyfxFeW0q2pkLzmi0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd4ae95-80f4-4e63-7f3f-08dcbaf9dff3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 18:09:14.9041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bB9M8eEMJYGl6orwWhQACuYa7Cut5YQ5BulkNGbfIU8ZoCIXWQeoDhl+Nq+NEsoMoNZhf6oK1NOZyK/iJsaJctjocbT5oX1G4eWBtV9CUSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4420
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_11,2024-08-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=996 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408120134
X-Proofpoint-ORIG-GUID: LsjHZy1MYuaPXBR-ooaev5ANzhZUlPmD
X-Proofpoint-GUID: LsjHZy1MYuaPXBR-ooaev5ANzhZUlPmD

I have been using QEMU to test legacy vfio vs iommufd compatibility vfio.
I find that backing guest memory with an ext4 file /root/guest.ram
succeeds for legacy but fails for iommufd, with EFAULT in
IOMMU_IOAS_MAP -> ... __get_user_pages -> check_vma_flags.  Ditto for a
hugetlbfs file.  This is with unmodified kernels, no live update changes.

Is this expected?

(a tmpfs file works fine, as does memory-backend-memfd).

- Steve
