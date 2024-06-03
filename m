Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77241136E28
	for <iommu@lists.linux.dev>; Mon,  3 Jun 2024 18:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717440669; cv=fail; b=LuwXp5EB3D7lOjpJHK4aJ7QVo7KPxH9pzXPOV8V2wXcHctqP3wvR6G3NWNlRaPwqMEZ0cY/JsE8VulVQZNOGGaEp4Sx2mG60lvgrJpcWbk3D9M0pkOzqR2axAFmhAWCUA9djNANNV0eVLd3Iat1qnMuTvPTjPqA4v5wbAQOpoMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717440669; c=relaxed/simple;
	bh=GkjuowluGCBZTwBTSYxq7Z2rebqebesNHM3eOB6ZV4o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SVScTB6j0wyG7qJ1mR3uxaiFCTUzGHme0tuV7FpnXq7W/M+vY0TmCtaLjVctAvvlSzi05HtOAogOc4geJkCJ781V0Q8S63ZyA3XNoQ692Q/AvZM7oKPd5SaY44NFFsx8yj5DM3z+oWdFGHwEE9VEKdkIMtuoCTpAqUUcV13/n+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 453CK0Xi009438;
	Mon, 3 Jun 2024 18:50:31 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DTQXHEv65osg0fpJ6UE2531uUSy3xfd2aufacIBLHYNM=3D;_b?=
 =?UTF-8?Q?=3Dd1711Jtrn5ghDeqZBla+kE1367K2KPoSe2q6hdowlFw2EBOKQKWgreKtuvIT?=
 =?UTF-8?Q?KHh2JC4i_RNrCdIA+UvMV96BFk2Wh5fcO0VPmzBC6bIuNVPUX1JRwXO+w1FDxHB?=
 =?UTF-8?Q?d3WNbShZDW11RW_fp9VaVxEpMo+MeG1iX6W+X9miDz+HIPqsc1L5rugwzEIXisx?=
 =?UTF-8?Q?6nxViUApNjvV0PUbZLfG_evkC5PKINUOhpTOHivGAFdfGYyYMMdIlWgf1qAraCd?=
 =?UTF-8?Q?ZmU9dbe3sAWrAN6XtoUTAc/HVG_qwKb14psqI4RCueN5AP008lwdTjCjL6h7zBp?=
 =?UTF-8?Q?wvsu8fySvDMJ4Dq9rj9sFP2UObPBGcRy_cg=3D=3D_?=
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfuwm3g6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Jun 2024 18:50:30 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 453IoQLj005524;
	Mon, 3 Jun 2024 18:50:29 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrmck0an-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Jun 2024 18:50:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjTxmtNWw/NKCruI/HaZuPqUYbDPBorS9HZNKvFQJQwOBTpn1AA10PdK4udNg9yTPqbmi/48FVwg1gbM3+OtcX9iTsQTNEzn+aYZzrWTc5G5uorfezqac1qxD62CTmsB0sT5qvrDNpfTqYvkf0HYY57NN6wBiJc6gr0sdcqY3wvBwrJ+PtfogwIBHIjRoz2npibIX3vcjvpyav7fvViYcUhSHhSj9PlcMrZdq8K65A5jdOu1s07kQX+LWPjhmbCDE4eHOzUOOD68JC7iWEwGtK2DmrXXxPC8x93XVypoLo0kWwRLGPR8JQI9i71v55xUYkqSmR7k0PJy3h1QXHw3AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQXHEv65osg0fpJ6UE2531uUSy3xfd2aufacIBLHYNM=;
 b=J6fGJyMr03C8UBZI8ieCt0CZuNy4xjthcijICuWy+4obck9FTYCSx5lPjCgUmhfXGMD4IqADLVQx3LGrH1zXRk47jhDJGUtEy/LMTJLAhjNV+Xlwd8EB/cvZBj9roMVm9OTonI0ZQ1dFTIHqLB5NLYaV/E2INjX28+FVk/RJlcgZRF4Gpf9E3kl073kasjA9lAlXqY0G1BqHJROlWziJpa5RvALFGsiJZ2kO5YAy8EbK28FCnF/uHFLDgGc7H7/9QSDY66VlSFIv+mar0yKo9BqEWOtgEWDagljxC8DNLwZamOjhCfDk7ng8hwOcK3MBbTaa7eQ1cQT7Y+6F9byDmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQXHEv65osg0fpJ6UE2531uUSy3xfd2aufacIBLHYNM=;
 b=m8MlYZrbtc1aOcZyPEIGEiC8TBk5VuwH54GM7/ADUoyOjG9YtlZ0B9XBOeu5ZDpPTrdtmmPTVhEs9UBCBoZcIiP8F8zqRGaysVEsJeijLgeVCY7nW2sibvyFZo3vDBinBpi2Y30zOexwhUaUq9HDGr5WWEMwchWF6jNyX5fx/Ro=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by CY5PR10MB6189.namprd10.prod.outlook.com (2603:10b6:930:33::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Mon, 3 Jun
 2024 18:50:25 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%4]) with mapi id 15.20.7633.017; Mon, 3 Jun 2024
 18:50:25 +0000
Message-ID: <df52c300-b36d-4ecb-81e9-49fd05066194@oracle.com>
Date: Mon, 3 Jun 2024 19:50:17 +0100
Subject: Re: [PATCH v3 2/4] iommu/io-pgtable-arm: Add read_and_clear_dirty()
 support
To: Jason Gunthorpe <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
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
References: <BN9PR11MB5276ABF99FDF6CF0F863501C8CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <13e93238f21b42539097d7e347be684e@huawei.com>
 <4618c24f-aaa8-453f-aa9d-67a864e1c93b@oracle.com>
 <20240522165640.GD20229@nvidia.com>
 <cb2ab7ee-9e31-468d-85cb-71e70d7a7e0e@oracle.com>
 <20240522175053.GF20229@nvidia.com>
 <BN9PR11MB527660CCD250C176DF86F9EB8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
 <2d949dfb-ea40-418b-81f2-f2711b796d4a@oracle.com>
 <20240524140754.GZ20229@nvidia.com>
 <BN9PR11MB52761D4122B818A05B508BB28CF02@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Zltus2S3qf0I4iaA@nvidia.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <Zltus2S3qf0I4iaA@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0359.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::35) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|CY5PR10MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: 6132ec6c-e568-46c6-48a2-08dc83fe07cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cnJSRmxjVXZuSEJ6K283UjVDTTFOTVQvWktybG9XSWZxRDR0aDVlSllXUlBM?=
 =?utf-8?B?UDBpWFFoeDlqMWt5cC8xbHR6UTRMcy8wTmJpL2FGb0R4SUJlVlRsYmdCZm9H?=
 =?utf-8?B?OXZUUGtwbHRtWWZqVk1BUEthZEFzSjFPbStzNW1YSU01L3U1SGlrSmRCVnZO?=
 =?utf-8?B?YitvellTUmlYc3dSTlUwMGoxcDAzN0htSmVWVWo2djdicUZ0WkpKeW9aVkxF?=
 =?utf-8?B?VW8zNEVOWXQrWnNxUEhzYnJwejFwcWN5ZWtJVVVadkZadlphUzU4NENhYXNp?=
 =?utf-8?B?TXQ1ZktRdEc0K2JKQUJrK3dTTVE0K1hpbktXTUJ6NDIzZ2phbmVoQVp3cEtn?=
 =?utf-8?B?ci9hS3d1eDlSNmVWR2RsOWhzT0lQWm93OWVMbUhzVmJLdVF0Z2VZY285elVC?=
 =?utf-8?B?RUxDTXZVRjZhL01OdDFtd1RkME01bkVkMjd1cytJRHpLQ3FnSmY1Qms2cmNL?=
 =?utf-8?B?K2tzcW9iSHN1a3ZKb05xY0RoK1Bickt6SXRVRklkSDNaQU5XZ2RiZUZjdnVh?=
 =?utf-8?B?b1MrbnlrR3J4VnViU2ZjQWw1RWxMWmRvUEIvaW9xNVJiNklLaU5CUGJDdFZZ?=
 =?utf-8?B?MU42R0ZzZ0p0L2NUMCszSENUNWtaSjVhSktKMkJMRnpIb01mTmRDVlAyaThS?=
 =?utf-8?B?YU8rZnRWRSsySFY2U1lFcDdlcXlxeGxRTm81MEtQbXcxT0t3dDJRUzcrRzFJ?=
 =?utf-8?B?WlFKcm4yRmZnd3E3bFZ0ZHhiNkJnalpuZ255ZnhrMzZZNXgyd2VEWkgxTUhz?=
 =?utf-8?B?alVkVnAzOWhrNXVhb2hCR2djcXdqalZ5WlBraTZhbG9TSFdPZWhWMmJQajhv?=
 =?utf-8?B?ZWtVWnkrbVlidm9MNXJ3aUVGbHRTeWdEalVsWDc4T1kyQzBGU3VHbjVpMjBT?=
 =?utf-8?B?UzhKMjhNOGlPZXZvT2drbHh5dGsreCszVzNXd1UzOHFxRU9kY3A4U1N1OGln?=
 =?utf-8?B?cXU4QmZNQW1OOUlkZ2MzZ0xtL3ZpbkwzQU5KNnhPallWczN2Q2xmZndPTzZw?=
 =?utf-8?B?SVBRZEtPNUI5Mm1qL05KMHNHeE5CRnVJRWlmb3o0dUxKdndPZjYwb2gwT2JO?=
 =?utf-8?B?dHFTb1hOZWdPNFhCczV2SkNyMlNGclRzVmdZdFJNa2MyaXpDNDZscmZYaHgw?=
 =?utf-8?B?cTdUQ1JjOXRKaXFHUUFMMUJoUDRlN0tyV1V0N0hraURkYlJLVE1NRkllYTQ0?=
 =?utf-8?B?VzdiRGFVUStiNHdMYlFsUWZ5SStjMThTQlZldG40QUU2VzhvaDZYbSthRmo1?=
 =?utf-8?B?emVoemFlbjJ0UjdzaGpNSHNEVHhHK3JzajZFWFB5TzNRZ1JLNnZzVjBXNDBT?=
 =?utf-8?B?SUMzcUNFUmlveE40ajh1bG9oOXhTeW5CWmYvdmYrWC9oaVlBZ0pIZEpLTENx?=
 =?utf-8?B?UTVmMzhaOVBaYVEvOUgvc2N1SkIrMzd3N3VUUEhMMkwvV0JYYlNCSWp0dFZO?=
 =?utf-8?B?a3Vab3plRzRQR05FYmhjMG5DSW5ocEpmQ1ZrRlY3SFR0THdPellJTTIrSGpO?=
 =?utf-8?B?M0VUdDhvZ04yMHR3MzNpVnVLeFVqUUpXa3dQVTRmRktUYjJwbEhicGordnR0?=
 =?utf-8?B?OFIrVTFiSDlNWmtyMnNqbmpiUC9PSTUxQ3NVRVZRcHBuelNIUGoreERxbWNR?=
 =?utf-8?B?cGFRMnBvRTdCMWRIdDh5eGZMb0xZcS9aMzU3OS9HSW02TlZ3RVFpVHhYRGFI?=
 =?utf-8?B?TGo5NEEvd1dDUGpxYzZKTjBWcTVINnlTUy9PSEhPS1NrcEZZTW9PNnFnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5893.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c2hkZ0VUMGowV0w4RGRIcUFEdVp1RzdVbHUxdDhEODBwWEd4T0VYMlc5NnNp?=
 =?utf-8?B?U0Y5bWs3cmNGZmlsNDRBRUcyUEpscXJUOFp1bEdFek8yeEY0WTIvRWo5UWJo?=
 =?utf-8?B?V01ndVMvcTZONncxakZHcTNCeXo5WWtDSkpTT3ZPNmk1RW9CR0krVW9sUTV6?=
 =?utf-8?B?cVNEenY0STRYV1hQU2lWK3VXOFlCLy9iK3ZzeWtPc3Fnd0Jna25HT3MydWtz?=
 =?utf-8?B?Nm4wVys0azJuUDhBU1RjQ3RqbHF3ZXROdEhyZHBxOHFPeWtsMjJrd1k1UEVI?=
 =?utf-8?B?YXFEYWdJKy9vVUo2bjlaUlhjVnRvckxPVEtnbzRtYmIwSmphNnR6V2xRWW1j?=
 =?utf-8?B?Kzg4b3lhOWptZkx4aW11ZG1oSXRsUGtOenVCeC81YWtBRkdXc3hTaXVwWW82?=
 =?utf-8?B?b3d0UWFUSmJjYjFPZ0g2bTFpYmtYV01WQmdSN2VlMUtYcTczcXJSbFRtWUtN?=
 =?utf-8?B?dEtjc05BVDVMNWlVb2hFanh2MGIwQ2VTeE00Q1hJUFU0NTFqK2VBY0ZSeDVV?=
 =?utf-8?B?Z3BjTlZwSGpMYnVid1V1RnNCUFVGVlJORlJJaTRDQU9hL1lzV1A2eElHY2hh?=
 =?utf-8?B?Um1iKzBpTEZSc2VETmxJOEtHT01MUExvRkhrelZKaWxiRmh1T2JKajBjU2t3?=
 =?utf-8?B?eXpaR3FhNjZxcDZQd3RTV2pBbDN5TmxoSEMrQlUrclJQbHRvZHNtZUd4UHNR?=
 =?utf-8?B?bWhONk9uQWdKSDc4VXYxcEc1UXA3S1VxN01TZFlkRkVZRUtJaURyTWdvNUdH?=
 =?utf-8?B?VXM4RTVvbTh6Q1VXQk5vTm13bjRHQjBvVVFKamlYM25naGg0TzMrTS9QaEk1?=
 =?utf-8?B?cnBKZGlHZTQxSFM4UjdabkplWDdqWCt3c1I3bEJjeFpxc2RvTUZhUmJ2TW0x?=
 =?utf-8?B?bGp4SXEyazZucjNWbE80aUlUMlhGSWFHL1QvZEZPRFV1YndtVFpQcElMR1FJ?=
 =?utf-8?B?NWpVNUFycFB0WHlHVGM3NnZROHhwRmZaUjlXdVNnTnFMVVJRbWljM1JtY0FB?=
 =?utf-8?B?bWk1dnpOOWhhaDNzRHdjZ2UyN1VZUkNqRUhGN2FoOGtROFpXYlFkSjk1bklC?=
 =?utf-8?B?UWVScnV6ZTgrNDI0NTNNQStQM1p0cWNxQ0pac0E0MXU0ZTdvVXlBa3BVZVpY?=
 =?utf-8?B?U3Jra2gvUFRuNE5xNGEzSERJNXdZVlg1MWFiN2hScG9KaXhWRG1rOXdoKzZ2?=
 =?utf-8?B?VU1sR3BIM21maEcxZmlDSVNxUVN4aU9BallGYTBLWjBmaStLam4vNHBDbzlS?=
 =?utf-8?B?dkYxc0tzN2ZCRzVRS1VjK1QyWDBoS3JrRk5wVVdxT2tVMUtMT01mZktaWHcv?=
 =?utf-8?B?dno4ZUFlSVZHb3N2OEVRczU4OVpDUUQzWHFybGFCamJPd1RaTW1RTkR6bVFs?=
 =?utf-8?B?UXN3UkZUQVJhMGpSdzMvNWVkdnpPVWFVMUxwWHlMaFdYMFBCSml5VHRscHhJ?=
 =?utf-8?B?SCtNbFBGYWVYT2x2WlVCWkE0VzJZMVdPRXFiczJZSzdkaURVckhVQ0hCQU0w?=
 =?utf-8?B?bWxtSmZRNFRtWS91Nm5XbUtac1VVR2hMMXNValBLZTNJWExEMEprZWlNanh5?=
 =?utf-8?B?SmIvN1F2b3kveEN1MzZESFdZV3NuTlZxNzhoUzlLdUNnc1NVbFpVZllwcCty?=
 =?utf-8?B?THIrRnR6dy9Uc0k0SU1xL0hzYnY5cDVrREZGVHZoandsUW5TYU9vSzljTWlv?=
 =?utf-8?B?ZlJXNjd1QVlPYU1COHRGNjNVSU4yMGRDcU4rYmg2MWd2elVyQVFsQ1ZIUFJn?=
 =?utf-8?B?M0lUUW55cnlTN1NNR1grbldDY2FTa2tjR0p3anQ4MmJwZVhSRWRTOVJmUUxn?=
 =?utf-8?B?bDJvZ1hWUjJsWHpMNDdPZ2lVVGxkK1NzbzBmUTBBVkpXcmNiOXJXanIySFVu?=
 =?utf-8?B?Z1JHRmlJaTRmS3dkYXZKOC93dElmNUIvZmJQVEhtM2pwK0N1ZTg3MWFPWmdV?=
 =?utf-8?B?a3I1d3dGQW9GYTY0V2dkM2ZFSWs4Qlp0QWd0UG9ScDBrNmVEWVpVZUg5RnpC?=
 =?utf-8?B?eU9HUkxrc1NKN2lUV2tjQVhQSDlYYnpOYW9HTCtjWkJoSEJNeWVrdTRMQy84?=
 =?utf-8?B?cWpCeTVOV2tyZ2xJKzdqUlhVR1NvM0ZVSW9lVmdiQnJDVkh6RGU0KzNjVVZy?=
 =?utf-8?B?RFM0bXl4MFdKbjJkY0FyYXFiN2xlUWZ2TWoyQkNGSnlFbmtOYmwrQmVjMmw1?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Z3FGDRk25ljNDYucHYxMhOx1UHhjPJ//ceYRgnfaQ6BIx4Ge4ePsoiqVKufmpUpSIta2dCx5hbCdQ1cl/JvTCcZ0zx4ZocucyiPUivxIv8wQK1UPWrsAnqsSsurmYLkytTtEgRD471e74TQt2N7qjrrMfjsxXbXik7LB3x1XbpDUrvN52pzDUkNPGAzvNulCITYEMS2XisLU0UxWuBpMiSXWIvsSN8feOvD3V4k7rdoqQJM+8coBgCWKhluQR0czvSyRrLzoAufALhzk/32QAxYOJJKoX1p5ZKoJoPyVX2T25RuPe9UdG+2BKTcrNL2Fw6fWVFLwHkOWzQ7T/r45aCVi2faP96NYcMsGQTgKMMZnmI53MjNMVoaq0S8CyM2h5jGi597WVJao7LX5cIG+vvUtLq0+nLsDUNV1ik5+7znQbrlZdFDsioWqHSddmV2SCbOoMbKYLdDJnO7oaLMKdQjPHUd6ZbRrDjW14yROcm15/jIAZdfjWTkNr4VDfBzNr4g689taId03EWeGorHH8hAT5hVjnVU6/cS2kYHEbygvzBs38e4SvPqCLwr6Mg5UbC3FNza5HtrulqU4KRBFRoCArkiv1IEzcrTV4DY1hLA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6132ec6c-e568-46c6-48a2-08dc83fe07cf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 18:50:25.7951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o/JNRim6jFtYNSkHkDshZHEspgxR2b7waYRAuN9HpceBMBsq+F77MYhUD7LGp3dThcDL7cJHXnt+21++1ULLrouS9PXg2uhNaglJPJh59lE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6189
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_15,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406030154
X-Proofpoint-GUID: CtnbKeduCshZYJ9hrArMvmvSXkPhpU1M
X-Proofpoint-ORIG-GUID: CtnbKeduCshZYJ9hrArMvmvSXkPhpU1M

On 01/06/2024 19:55, Jason Gunthorpe wrote:
> On Mon, May 27, 2024 at 01:21:14AM +0000, Tian, Kevin wrote:
> 
>> emmm there could be multiple domains under a iopt while the dirty
>> tracking toggling must be done per domain.
> 
> For some reason I thought we had made this per ioas, so yeah it is not
> right like I showed.
> 

Something like below instead?

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 721ede5a1faf..9756ff18b5f2 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2645,18 +2645,10 @@ static int amd_iommu_read_and_clear_dirty(struct
iommu_domain *domain,
 {
        struct protection_domain *pdomain = to_pdomain(domain);
        struct io_pgtable_ops *ops = &pdomain->iop.iop.ops;
-       unsigned long lflags;

        if (!ops || !ops->read_and_clear_dirty)
                return -EOPNOTSUPP;

-       spin_lock_irqsave(&pdomain->lock, lflags);
-       if (!pdomain->dirty_tracking && dirty->bitmap) {
-               spin_unlock_irqrestore(&pdomain->lock, lflags);
-               return -EINVAL;
-       }
-       spin_unlock_irqrestore(&pdomain->lock, lflags);
-
        return ops->read_and_clear_dirty(ops, iova, size, flags, dirty);
 }

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 15411d8d1b3d..6db733f73922 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4799,15 +4799,6 @@ static int intel_iommu_read_and_clear_dirty(struct
iommu_domain *domain,
        unsigned long end = iova + size - 1;
        unsigned long pgsize;

-       /*
-        * IOMMUFD core calls into a dirty tracking disabled domain without an
-        * IOVA bitmap set in order to clean dirty bits in all PTEs that might
-        * have occurred when we stopped dirty tracking. This ensures that we
-        * never inherit dirtied bits from a previous cycle.
-        */
-       if (!dmar_domain->dirty_tracking && dirty->bitmap)
-               return -EINVAL;
-
        do {
                struct dma_pte *pte;
                int lvl = 0;
diff --git a/drivers/iommu/iommufd/hw_pagetable.c
b/drivers/iommu/iommufd/hw_pagetable.c
index 33d142f8057d..de3064ee849e 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -331,7 +331,9 @@ int iommufd_hwpt_set_dirty_tracking(struct iommufd_ucmd *ucmd)
 {
        struct iommu_hwpt_set_dirty_tracking *cmd = ucmd->cmd;
        struct iommufd_hwpt_paging *hwpt_paging;
-       struct iommufd_ioas *ioas;
+       const struct iommu_dirty_ops *ops;
+       struct iommu_domain *domain;
+       struct io_pagetable *iopt;
        int rc = -EOPNOTSUPP;
        bool enable;

@@ -342,12 +344,35 @@ int iommufd_hwpt_set_dirty_tracking(struct iommufd_ucmd *ucmd)
        if (IS_ERR(hwpt_paging))
                return PTR_ERR(hwpt_paging);

-       ioas = hwpt_paging->ioas;
+       iopt = &hwpt_paging->ioas->iopt;
        enable = cmd->flags & IOMMU_HWPT_DIRTY_TRACKING_ENABLE;
+       domain = hwpt_paging->common.domain;

-       rc = iopt_set_dirty_tracking(&ioas->iopt, hwpt_paging->common.domain,
-                                    enable);
+       ops = domain->dirty_ops;
+       if (!ops) {
+               rc = -EOPNOTSUPP;
+               goto out_unlock;
+       }
+
+       down_write(&iopt->iova_rwsem);
+       if (hwpt_paging->dirty_tracking == enable) {
+               rc = 0;
+               goto out_unlock;
+       }
+
+       /* Clear dirty bits from PTEs to ensure a clean snapshot */
+       if (enable) {
+               rc = iopt_clear_dirty_data(iopt, domain);
+               if (rc)
+                       goto out_unlock;
+       }

+       rc = ops->set_dirty_tracking(domain, enable);
+       if (rc)
+               goto out_unlock;
+       hwpt_paging->dirty_tracking = enable;
+out_unlock:
+       up_write(&iopt->iova_rwsem);
        iommufd_put_object(ucmd->ictx, &hwpt_paging->common.obj);
        return rc;
 }
@@ -356,7 +381,7 @@ int iommufd_hwpt_get_dirty_bitmap(struct iommufd_ucmd *ucmd)
 {
        struct iommu_hwpt_get_dirty_bitmap *cmd = ucmd->cmd;
        struct iommufd_hwpt_paging *hwpt_paging;
-       struct iommufd_ioas *ioas;
+       struct io_pagetable *iopt;
        int rc = -EOPNOTSUPP;

        if ((cmd->flags & ~(IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR)) ||
@@ -367,10 +392,19 @@ int iommufd_hwpt_get_dirty_bitmap(struct iommufd_ucmd *ucmd)
        if (IS_ERR(hwpt_paging))
                return PTR_ERR(hwpt_paging);

-       ioas = hwpt_paging->ioas;
+       iopt = &hwpt_paging->ioas->iopt;
+
+       down_read(&iopt->iova_rwsem);
+       if (!hwpt_paging->dirty_tracking) {
+               rc = -EINVAL;
+               goto out_put_hwpt;
+       }
+
        rc = iopt_read_and_clear_dirty_data(
-               &ioas->iopt, hwpt_paging->common.domain, cmd->flags, cmd);
+               iopt, hwpt_paging->common.domain, cmd->flags, cmd);

+out_put_hwpt:
+       up_read(&iopt->iova_rwsem);
        iommufd_put_object(ucmd->ictx, &hwpt_paging->common.obj);
        return rc;
 }
diff --git a/drivers/iommu/iommufd/io_pagetable.c
b/drivers/iommu/iommufd/io_pagetable.c
index b40eab6ebe4c..25547d79f294 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -532,19 +532,17 @@ int iopt_read_and_clear_dirty_data(struct io_pagetable *iopt,
 {
        int ret;

+       lockdep_assert_held_read(&iopt->iova_rwsem);
+
        ret = iommufd_check_iova_range(iopt, bitmap);
        if (ret)
                return ret;

-       down_read(&iopt->iova_rwsem);
-       ret = iommu_read_and_clear_dirty(domain, iopt, flags, bitmap);
-       up_read(&iopt->iova_rwsem);
-
-       return ret;
+       return iommu_read_and_clear_dirty(domain, iopt, flags, bitmap);
 }

-static int iopt_clear_dirty_data(struct io_pagetable *iopt,
-                                struct iommu_domain *domain)
+int iopt_clear_dirty_data(struct io_pagetable *iopt,
+                         struct iommu_domain *domain)
 {
        const struct iommu_dirty_ops *ops = domain->dirty_ops;
        struct iommu_iotlb_gather gather;
@@ -576,31 +574,6 @@ static int iopt_clear_dirty_data(struct io_pagetable *iopt,
        return ret;
 }

-int iopt_set_dirty_tracking(struct io_pagetable *iopt,
-                           struct iommu_domain *domain, bool enable)
-{
-       const struct iommu_dirty_ops *ops = domain->dirty_ops;
-       int ret = 0;
-
-       if (!ops)
-               return -EOPNOTSUPP;
-
-       down_read(&iopt->iova_rwsem);
-
-       /* Clear dirty bits from PTEs to ensure a clean snapshot */
-       if (enable) {
-               ret = iopt_clear_dirty_data(iopt, domain);
-               if (ret)
-                       goto out_unlock;
-       }
-
-       ret = ops->set_dirty_tracking(domain, enable);
-
-out_unlock:
-       up_read(&iopt->iova_rwsem);
-       return ret;
-}
-
 int iopt_get_pages(struct io_pagetable *iopt, unsigned long iova,
                   unsigned long length, struct list_head *pages_list)
 {
diff --git a/drivers/iommu/iommufd/iommufd_private.h
b/drivers/iommu/iommufd/iommufd_private.h
index 991f864d1f9b..9f946df4ca77 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -78,8 +78,8 @@ int iopt_read_and_clear_dirty_data(struct io_pagetable *iopt,
                                   struct iommu_domain *domain,
                                   unsigned long flags,
                                   struct iommu_hwpt_get_dirty_bitmap *bitmap);
-int iopt_set_dirty_tracking(struct io_pagetable *iopt,
-                           struct iommu_domain *domain, bool enable);
+int iopt_clear_dirty_data(struct io_pagetable *iopt,
+                         struct iommu_domain *domain);

 void iommufd_access_notify_unmap(struct io_pagetable *iopt, unsigned long iova,
                                 unsigned long length);
@@ -301,6 +301,7 @@ struct iommufd_hwpt_paging {
        bool enforce_cache_coherency : 1;
        bool msi_cookie : 1;
        bool nest_parent : 1;
+       bool dirty_tracking : 1;
        /* Head at iommufd_ioas::hwpt_list */
        struct list_head hwpt_item;
 };


