Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1674440C
	for <iommu@lists.linux.dev>; Fri, 12 Jul 2024 15:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720797403; cv=fail; b=SrSRC1fGM1Vt1wzX9P2sOe9bLDuygeeCHNzwkU00fR211ivqI+gJhAvD9B6iClTZKHfPIx14XesdXmnb8i3nraIyb6e4yKjZcad13I1TRdLUHlO5If5tu5X1ViNvGq3uknuBv0F0gzSKK3Wv1hAI84gE0aPF1QtHttmurLrOwEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720797403; c=relaxed/simple;
	bh=mjE9djoH4w+pcwyfNTTADK5eUdvWi4rYo3YIqaGxvf8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QqleuPbijOvK1/eyShHGtW0LbD5QMXRL4sw8TYKmSjf/X8Yp7kF6wZGfbpi7fc6BmlKt1lFv5r+tJ8j/NcmxUf2ygNYP9d04RqFcSS4xNJECszs2yJdfxouvxt+T6kEOY5xRVTwHP4t6QGOvQz7xilsdkbpccPXJp/9gjpXtIz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RgEsPhze; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iAOcZzVt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RgEsPhze";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iAOcZzVt"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CDIL1k023678;
	Fri, 12 Jul 2024 15:16:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=Ls1TxM0YnkOZYDYP8DkNowkNU1kvJPhOB/fOqeXCGb4=; b=
	RgEsPhzeCq68z4siI+nAa+BTKxgt95pP8vdV660u4Y+6KKFYnYj686Mv3U3QnmRu
	Pke+oNo6vQR1EV1t75bKOuWHi3N54QcJcagNO235xHiKDDa4DBSTeeyYu/IZIxQQ
	fE+BZr3Kmtvr4TGQPrXKGjOqAVM6N57N8TXD1qYHf2NnoYm92aX+2rHTsNa11r57
	tNt1D2l+NWl+/U5vNYXxGf1LRJCccVn+ScsGD0diFN6AdZQ2BXhl2ouGAXttEHWI
	xqM9YGfRiRPxclmCCzLCAfFsUUfObruGEY7b6EyN2KcmEIJAFfoC/uCbvZOEfv4V
	/Gfe7OMRqTEPQr5VaRIyzg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 407emt3d8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 15:16:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46CFEvMC029905;
	Fri, 12 Jul 2024 15:16:14 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vvcqhw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 15:16:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DsCFQ2+08w7ABZsWODU80Vu15yi9bTRdNSxfFkd3ANSzwML9PlwQzZzgdvVPnd7NdYQSl6EwLwUhtPW11XFJ4oNr4AN+l8SDk0IMrGlx5WuYocNt8Um2r+m3N5pTWFf1G/W+33u7dqlwLsah5YhD6mriJck5cp50a54VSmzwpPCOFnWprb4H8U8l1lFp7FJZ1pmrDRXsFWSK24r1vN/2whRitZfrDXRooGEfg9YVpAEBULzD3LosPd836Ku6PCoDcIrVbI/o9/GcpqTmcHJxZiNoG5rPQAGBIGtuSMmnVndFkhq0yP9tiLDkucNYu+bCvTRAdgTgIiw0Z1KZNt8mfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ls1TxM0YnkOZYDYP8DkNowkNU1kvJPhOB/fOqeXCGb4=;
 b=jracpio8SO823kTNPwr5wTOPjnQXfNm08CV5X/LuLb5cxAngDDkPvg/oYHESFb5/PoLNpIP0IsEXz+QZvHKcUu8jJIRFASdkv5z4C9LkXq0Fm4O5ecA9PiGszUW39YHHnho/3al3RHjY23TzGxhsU0JKcdr3VAc/lzpiZ6a6tlcQhT+y9ZUZBjhiHuTcXGvKdZgkl7sEe6V2TK/8vJR97taT2RJYQksOdkfcfkldmfMlDkYvWFO59/JtJC+jRpDXgW3b/VaJZGzaL3TLrkDrHGs7x5/h3SecpWwmigv8xbIHb0WahekfUPRGlvRMhZYEhzABhCWnMUa3bBbwUKyXRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ls1TxM0YnkOZYDYP8DkNowkNU1kvJPhOB/fOqeXCGb4=;
 b=iAOcZzVt9hkwt2DDepn1XAPXFrq8S2QOVY4bSMX2PPaQLxq3Ob5tlkF93yBz4UaaMrm4sOEJsZ6reLPuGkPaQwzdvidmk1zp8dZc0Pxfv2nzRTVOKYCge0LDugB+8+8R5KKf5zUWspo3MIEJZvClAL/U0lisSJRGz44IYirWHzE=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by IA1PR10MB6169.namprd10.prod.outlook.com (2603:10b6:208:3a7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 15:16:12 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 15:16:12 +0000
Message-ID: <2cf74cca-8519-49d1-adc2-284bb850f52b@oracle.com>
Date: Fri, 12 Jul 2024 16:16:03 +0100
Subject: Re: [PATCH] iommu: Move IOMMU_DIRTY_NO_CLEAR define
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: robin.murphy@arm.com, joro@8bytes.org, jgg@nvidia.com,
        ryan.roberts@arm.com, kevin.tian@intel.com, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev, will@kernel.org
References: <20240712113132.45100-1-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20240712113132.45100-1-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0042.eurprd04.prod.outlook.com
 (2603:10a6:208:1::19) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|IA1PR10MB6169:EE_
X-MS-Office365-Filtering-Correlation-Id: e388c636-8073-4479-cfde-08dca2859065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NDl3bEZqWWJ3Zk1QQlBhMXRDNDN5WG9pamRvL3NlVUd4MFdhNnF6M2VLQjAx?=
 =?utf-8?B?NDl3dlhQZHM1NmQwU0dYdm9QOFAwb01PY24rbkFVd2dGeUZFb2wvQTZOUjIy?=
 =?utf-8?B?NDF4cjUxQkpSa2VCMXM5d0pFT2t1WHNvbmphMzdIRlZIL1NLSzROYzdjenFh?=
 =?utf-8?B?eWh6UWkzdWVvai92T2xBTkVmbCt4NC9FSm1JeUZwUXZXUHh5VVN3czFvL2dm?=
 =?utf-8?B?K3hNVTlqUkswbHFKd2pUS1VKdTJYWVRSUHF5WnV2REI4N0d3L1lQaGYzNk1K?=
 =?utf-8?B?SXJhZGhtTklJMkNkQ2ZPN0UrblNkSzZ5MGp1dWszOTB5Uno3dzJDbjBYYXlN?=
 =?utf-8?B?U2hJei9zSy9NdXBkckMyZ1FzSWNTQzYvRzVSdDVSbThLMXR2TnlOM2tjeVJF?=
 =?utf-8?B?RDhySlRwVm1IZkFQQlptTTd0dGxZNkhGQlk5NnJvckFiOTJUNUJXaGZkcndH?=
 =?utf-8?B?a2NvRjFCajZveUg5bG8wY2toZlU5cDU2eTN0ZGpmQllNMXVuRE8ya0tBcHBJ?=
 =?utf-8?B?N2dCcGpYV2hXeGtNTkhjNUNOWnBxM1BJV2ZZTDhhN1E0VDV1MmU4V0E1ZUky?=
 =?utf-8?B?anM0eFZleFBZcG0xcDNsTXV5RCtHYVpOQnpIdzJkZFREYjV3cjBFbDJMcThI?=
 =?utf-8?B?eDVwd2I0alk4OWxwS1NwM2NpM1pIZ3FNa0plSHplUmI4S2JxY0hQY281dGNK?=
 =?utf-8?B?enhDcEFNY0VzVnRzRTlkUEF1MFp5SGlKTmJzWUhkWlpIaXBsL2x3ZUJXVEdp?=
 =?utf-8?B?dk1zaVdhbDNzYlFtWjBuR0Y2MkZqMEV1UVNKZDdrL1JqZG16Wnp3L0MvV0g3?=
 =?utf-8?B?U0pjQlpleGl4eW5GdjVBbjdHVW5DbXJwYzJoRmFONXJRZ0hDaFRPM1l0clNV?=
 =?utf-8?B?dXZhaTdNdjR2SlhFc1ZhY3QwcjZyU1ArNFIrdjQ5QnBFWDhLK3ZOcjVuenlK?=
 =?utf-8?B?THFnZ1lUb1pUd3M2dzZNZ2ZRY0VvY3NFMGFZbzN0UkFiZWN3STFDeHNXenJq?=
 =?utf-8?B?MnlFSkZUK0w4N01PZjVCeGN1dDYxS01mTmFuSXRyZUZnRXpvcWhnZnpqSUdR?=
 =?utf-8?B?WEs5ZXljV0k2OTdGOVNEZmE3SGxDZm54bFlBbWIwN3dVdjdMVWdTSFZ0YkJh?=
 =?utf-8?B?bFgvTWRzM3h2eHJjWkpwaXAvaHR4VTVjSGEzY1YwWTF6cUE0TEdXLzBFOGEy?=
 =?utf-8?B?emR4cWxJcUMxZytlV1RWRTRQdUlUTXU1OXZKb1dlQnU2WTZwTE9adTVTTUcv?=
 =?utf-8?B?dzZCdkxDK0V5Y3dRZ0tkUG1SREIzOGQ2WEpQbmU2eEQ0bjRzb1VTZEcrKzZ4?=
 =?utf-8?B?elFFc1V1ektseUdDQWluN1N2TmNKbE5tekZydEdFbWxnRVptOHpaSEU5bC9Z?=
 =?utf-8?B?NjhqcVhPblE4Z0dRKzVNcGpZSkJDTHhCR0JuZVhoT0FjQnorb3UwK2Q5SWJQ?=
 =?utf-8?B?cmNpYUY5WEE1QjkxUkdnSVdkdmlsU0VTNk1QbTZpckRiT0dqL1I5UEpPZUZ4?=
 =?utf-8?B?VlliLzlSNkc4TU5PLytqOU1NN3dPckVrTkhKdnJwV0JOWmNmTVVweFh5NEpy?=
 =?utf-8?B?SEtVckZPTDBYZWNvd0dvakFEWHA3aTZXUHMxdFZXaFN5ZnV6SjNhWW5UN0Rr?=
 =?utf-8?B?T0xHQlBTKzg2NG5BK0ZYcmM4WkUrNW9iNnZkdjRjSmN5MUtRUVp1dlZYVlRw?=
 =?utf-8?B?RFZTNlZ0eUE2U2V6V0pPY1FQZGVsRGo4SVZlR1BYMEN3SUVnSERpZ1hROVQ4?=
 =?utf-8?Q?e4OWNiTu/P2ye5LUac=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5893.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Vk4rZUJOdWFhUjcwU3Npd01KenRJTi9VWmhxa1VmZ3dCWEM2VG5BTG40d2Nh?=
 =?utf-8?B?bkJIQzhXdExOVml6Y0t3OHZPY2NmQjJ4Qm5WZE5DWjllYnhscDdYVjRwS3Rj?=
 =?utf-8?B?UklTc2MwM0tMdjhLdVMxRC9FUzFWbU5mY1E1VUpnVlE3Ni9QNm1rV1pOK25s?=
 =?utf-8?B?TUZscWd4U2ZIcnNiYm8vVUN3eDdmOWVtUnNxaXRYemhsWUx0UFZ1Y0w1SWtL?=
 =?utf-8?B?bEhFcHBtUVJSUGF6amg3Szh5QjVwOTQ4WUVuY1JNVE1NYmlEY2ZPckx1bEUr?=
 =?utf-8?B?OVNBNjhyNU82R2J3Y1JDQkNsNXVSU28xMEFxWnM2VGdkdTlLZ0M4Y1pOTytK?=
 =?utf-8?B?cFl0d0lVc3dqbnhjSytEOUVtQzJoOG1QK0s1ZmVjWlUzQnVESDZXd3d6ZWQ5?=
 =?utf-8?B?WWxGWFQ5L1J0T2hkaXZYK2xneUdKNTArZmVmZy9zYmdKeCtXUTBydDdiNHY2?=
 =?utf-8?B?dS85YXB0dWJ2Vis3dC9wYWp4Z2FDbjNPQmNIbXBaK3kxT3ZvbkFMb0pzZHRS?=
 =?utf-8?B?S3NKdGdINmdCdEs5amFtS05Pc0pxZnpkaTYrM28vN0twWTl5V2JnVDhqQzZm?=
 =?utf-8?B?T1lNQlZGMFI1OVN1a0s5c0ZmbzRNUk9vSE9USWVXNTFROW5FTFVPZjc3ZGN3?=
 =?utf-8?B?RXNYTVBhRXlNYTYwdkdZaW9UNjVxVnNnZ3pncSt5SFVmb2wxV09PZVIxTEpk?=
 =?utf-8?B?cEtsaFdDNXBNVGVNUzV1Y0hScEJxbHhvUFcweW5hMmFTTjNvWG1KQzQvcVd4?=
 =?utf-8?B?QW12UVZOcWg3R2JMNUx4Smc0emtzYjl0TWdaY0ROM3lWWitVTVpZQ0Q3andC?=
 =?utf-8?B?L240RTltQ2huaTR5ZzRwbEVYU1pkNDJWOWNJczV1NDB5b2tEcUVEeUpGamIx?=
 =?utf-8?B?SlZlczVVQWVSUW04N3M1c3lXWS9zVldJNUxrT0Ric1hDR3NLUGJSN28zV1Qr?=
 =?utf-8?B?T1YrQmhBUlk3a0NsYm1NeXdYdW4wYXBKajN5ZkZ5S2pjT25DNTRXVWVFSkxr?=
 =?utf-8?B?aGtjUmt6ZlROUk94NEZtejAxbmdjczQrNDlROEpVWGt2bHVSUmxRb01OQVV3?=
 =?utf-8?B?MWN5N0o1MlpNdU9aVFlRLzlIc3VXcVFFUFZYeFB4NEp0ellxTHdkUmJLNUpG?=
 =?utf-8?B?U3hLaFRXZFgyYVNpMEd2QXNDK0VlQzdxcnpzZkcwSmtaaGpNNzVpelB4TmZw?=
 =?utf-8?B?SjRIaFljQmMzK29Gb2tyK2Z5QkxnQkNnc05OWHh5c2dyOUI4UnVPNXVnTW8r?=
 =?utf-8?B?K1VsQTM3dHpVVXFtNVJITFEzcXBQaU5NbTJHRktDalREUG9jaStwV205WlFo?=
 =?utf-8?B?eWtURU5pZlZiNVh1NmtCRGN1ODVsY1R5UEc2dzI5MXhFNWJaRjNtcldKMTF0?=
 =?utf-8?B?STRNSFE2b3ZLSDhCOVVaNlA4NHovSzJMYytuVzFyZU1MeUczdlRYQ29ZTmY1?=
 =?utf-8?B?d09ncUJXdzhoSHIvMXpISTVzaXNRT0VCUnl1cStYejNBWFRtN2xOcElFUGRT?=
 =?utf-8?B?T2JoYWc1NmEySURuWXU1TSsxaTNUK0VMV2Q4ZUMzcUtzWkZLcXEzRG5hNlU3?=
 =?utf-8?B?VWQxN25GbHltN1VjS1NCU2NoVHhrd3lDV1BrUHh4SW04QlJ6NmROZm9LbXJu?=
 =?utf-8?B?WGJQaDhPaHlEZkhMZ1QvZ1B4NEpBSzBSZFpoZXNTclFaWlRvYXROVWQrdmxO?=
 =?utf-8?B?Z2tHTjFrbnVOUTM3UGprSVFhRG9JTzUwNlNTOGtic0l4NzJmSDhLWE5QMmdH?=
 =?utf-8?B?MlZJbDBtdUt5QVFxUWxyWkpEVU51VWx6bURRTEZyNkROeGZjRHQzR3QwWWpP?=
 =?utf-8?B?b2VyVHJSeXFxYnRjTDdrUkorUmViWkFySmFpZXVseGJuUDd2aUJDY2hzc291?=
 =?utf-8?B?L1lQOWg0bGpUU0dGVWlDNGZ2Tm5NeWJETWQ5WXFpYUxmRkFZcXQ2OFo0MWh4?=
 =?utf-8?B?VnM3VnYwYXVTRlNvckQxYkZxNWlXMnROeUJjSDRmRk5LNVRIMy92dUx6YnRV?=
 =?utf-8?B?a1J4ZmZTNVNLZDdPdnVMM3FDdE5mMzFCNmc5eHJKT3EwdDE0N3AxRkpMUS81?=
 =?utf-8?B?dGZCcDBFOWN3MVpwZXlIQzBXTVNBcXBadldVdU96b2h5cEtCTHNYdHM1WGtx?=
 =?utf-8?B?bmhRbkdHOTVYT1kyYXVLY0pBaXpEYXdUSmpWZkZ4NEU2Y3d5L1F0djJrTkd0?=
 =?utf-8?B?RFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	WDT7lQsQqvoull7OW4CcoNtGmV2YGDBL1PZZXi4qWLd6JB4PQSjyUbO51TIn9VxI8titz8RkWbowGl4Sd9xlFkxZRJ3n+t2oN0cokWA+x4XTaF0IfTTdujzaDE5lPZdCqR+sNh311Qt6lsSRRMggGi6vFlk3hLoRtB0UIjdsPdO1pWVnc1FdxKfq/cx8kJ/Nl5d/uWh0Fo22d3U3fi1BXG2h3p/rSSFbRS1D7OlLIuHPUCCx4XI+LFmem0MMHNzHtRJhos2GrpslzLH6wCMRotMdr0UhkygltXnTnZ2dF3t5UESHNLONVGq/FIZufeAQfXlgdaapZNGklL//iMcA88dFMNVXNiN5Q9nkt8VzCP9d4EB1/L6ZvWzYpgODa/L1Ynj4K/7eEdd2p9LyiCpcOlV3dLZUIRturqg9nHafk6g8P4TdMJxHNTnvMy5Kui4z46M7oCPwo5+e0bv+83/Wrr/wPFM22dBMKerWCU81XyjDKvanMroZ/7Pxfr5Dspy7mRl2zp8ZduOBtTUTHHSM4MVWmcsspNN4uK4Ybxjmmu1AorASMYxl4H+BPwY1+GvHTctZBjEj/uGwD5XQ137VhAwPgXq6VL2sUnbePqDgy7s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e388c636-8073-4479-cfde-08dca2859065
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 15:16:11.9400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qh8PaHU3zLNwfim7UvaeuXXZjOLcJu7drXXPabRHhVEbGnkfYnKUzunmq5CJEfehu6s60Wo6Q25wZ6tuisDXspUDDku+FAnVYz/On6yVQBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6169
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_11,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=839 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407120104
X-Proofpoint-GUID: yr2z-9S5lOFAvGRgllES8WI2HWuqEML3
X-Proofpoint-ORIG-GUID: yr2z-9S5lOFAvGRgllES8WI2HWuqEML3

On 12/07/2024 12:31, Shameer Kolothum wrote:
> Fixes the compile issue when CONFIG_IOMMU_API is not set.
> 
> Fixes: 4fe88fd8b4ae ("iommu/io-pgtable-arm: Add read_and_clear_dirty() support")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202407121602.HL9ih1it-lkp@intel.com/
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
