Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0921C1BA89B
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 13:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729084195; cv=fail; b=JYTxudUCZC8WMMuDsLdPqrb6eE36UO7BL7qJkI8rhEbY8ukRaQPQXz4FcPU1jOQ4fvYSpz0LHD1JJAREXwxFnz6K4CXe9Eqd4U5WBR5tB0jYachaxPvKdI/AwJ2r1yd8RpoCOzI/prISgjIQ0rn0Plh49nXLdH/VQ+xQbYmOhC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729084195; c=relaxed/simple;
	bh=LAwXftRQ2dra0OJexBG1lXJ4blO9rb8e/o3c+BOAAdM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UI7icPjW7Do3zot7Hvuxi+xhTxX4+FxLaIFXcEhFS8jtrYzXoCh9+2dSHlj1IOyPMaRqMO4reD/oudgX4Odl0usyyfTQWvaBzjzL63UlUKC2IBC3Clb8p/tRJWBSXbiunP8cGsRt6Bav2LMOB4qA2POTFwfbzqMjRK5gxzx+EwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VfTXGmQI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rTMV236t; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VfTXGmQI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rTMV236t"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GD3pDe015161;
	Wed, 16 Oct 2024 13:09:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=m+8tKb1owLWXyMp6vVQlhzOeiu3ZQMM/BR3b5xhx4x8=; b=
	VfTXGmQI/mBP2rlQW+Oh3Ewhg7JC3e+reUYHCm8GWLNondZDDskiegh9qdaAmPrh
	jTgM+TC3bPzb1BEBKNawEjkoaEyE9J6qqk9pDXB2dBv5JlHUojQyrw1GIgXrB2ei
	TiX4IjHYTlo73SbGKUr9OAWZoPoUn0lmprfzviWW4sc0yfBYRuy7BjLKpNq7XpdP
	V9XchJnEFEtUNnL6UBA6wv6epKs2jreLFLmtbR4znejuWGziIQINDZK5sXwmYzna
	XVKFeGJNxX11/L9jIghvk8TJZ1uTgqtfdPBb8oTcPvxhmScadhkue3e+MLT98pDC
	ZUCVLfctHuFdW6TlsLNxdQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h5cm10r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 13:09:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49GBe7N9035993;
	Wed, 16 Oct 2024 13:09:44 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjf6x21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 13:09:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jjjpDFYCGwe5uyL8E+5HpymrlUbl+z34SiI/dMnHTLilDMSM2uPN3Coqy4UMuWi1MbwmJQGw6C569FLTI0rS1haqpQZFc2y6RISwePAHqRElRGOAyzkFoC6Tbq3ZvqtELfgz2mZSKD/7R1dAPvdhAJk6pF94+TKn4DJjJ8Nn3H8NS0Mvrzhy6AcPnmsstv/to7PI5OrxJPWQ0hZkTjYuf7lwCcsryFUNdT975avG5cn+3h2AwivutXFcsCl9/WCgy6MepwTA0Vamcx5k/mREVtO8LLar4gDHLkpRoIJQApphznIWpcMxWoAUK4+csAZw5rjkhzPMKnVhzVt6MPGWQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+8tKb1owLWXyMp6vVQlhzOeiu3ZQMM/BR3b5xhx4x8=;
 b=d1IJCpCfj/lnrqBroeWiPljXlXTs5y4JDwgYk42hG6gibahC8H+c8x2SLzzNtD9AT/uB8j7gKBZPAyyI9JjiW4u2vxSOmjVdMbwL7SU3tXiIcH62uG0r8Ke8yiTkNk8CF2paOtnpztYGpIldNv2DFkbjr+0Oh7y46iS2GwkEbVrcrp+bXx5uJpM5xyMeXiutm+ersv2f5Ckp89jOO4yjJSxanH0FdTf6lAKofztqG+hfcVjDlTLCq1uOM8NybQV1WURu1SgLliZlKKGyLXm6vToPNaJEPVeEL+n2ZgW/+/gh1gqckzbpq0HIG6RnG4I1Y1eprT9Bw/1DRXXauuuS7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+8tKb1owLWXyMp6vVQlhzOeiu3ZQMM/BR3b5xhx4x8=;
 b=rTMV236tphjuUvsmt8RBskUgHK8oRxzxMmMIjACnh2JaTKizyqH6g2aD425ZMDfMnAV82d9OfzilaQNmQWvYt58E3NvcG3DbK6ucs+42dmAmcCVPZ7mcmkFFjU9L4rdqXrSS8TjOMY7cSKnHlDBsY3BLyBtNBUapPjmFcHUzKX8=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA0PR10MB7642.namprd10.prod.outlook.com (2603:10b6:208:481::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 13:09:42 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 13:09:42 +0000
Message-ID: <0220fd36-2f4f-4b24-b248-824d20d0045e@oracle.com>
Date: Wed, 16 Oct 2024 09:09:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 8/9] iommufd: optimize file mapping
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
References: <1728067700-32092-1-git-send-email-steven.sistare@oracle.com>
 <1728067700-32092-9-git-send-email-steven.sistare@oracle.com>
 <20241016130001.GI3559746@nvidia.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241016130001.GI3559746@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0176.namprd04.prod.outlook.com
 (2603:10b6:408:eb::31) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA0PR10MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ce0469f-2fbd-415b-f397-08dcede3cc24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVFBK3NPSXV6bnkzdklON3FtbjV1Z1MxL1pld3g3MEp1aWEzNDlwQzBPYThp?=
 =?utf-8?B?VHFveW8xNGtOUTNWYUg3UzYyNE81ZCtTQkFaZEFyeC9OL3BSZkQzRUkwSGtO?=
 =?utf-8?B?dkN1UHBZUVpVZWwwL3BwbFdCUUl1ZGkrZmdtQ0dYZ3dWMmVjRURWOTdGTXY2?=
 =?utf-8?B?Yld6am9saHZaNGhnMVNaeHZMS00zeUp3cTR0MEpwQWFrVVNWY05MQW9heE1W?=
 =?utf-8?B?aEM2NFFYSE4vU0xqQjlWS3UrZTUxY0VXYi9qd01WMmFuUGtQQzlZNzN2b2pi?=
 =?utf-8?B?MDRsM2F5MUtRcXh3NmFIeThJK25vSWI3RCsrdER6WXlsZ2NiR2NMQXphelZi?=
 =?utf-8?B?dmZzVDdla3NNeE41dEoxYndPKytRRmRWKzdPeTJXUlZMUTVxL2MvbUZscSsz?=
 =?utf-8?B?L2F2OElTRzJMNFhFcmtCbWRWY0JKNmF4Z09CcllpTzFKcitMSkhUN3ZwYnkx?=
 =?utf-8?B?K0R2aC9LekRlZTlJTSs3KzJDbnAyK3NKdU1UMXdZUlROK290ZW9SNk5RMzl4?=
 =?utf-8?B?SndXSE9NSzFpZFRHK2srOExBVm9ZM25LRExKVnFXTEJJL1dIYWxOOUpMZzgy?=
 =?utf-8?B?ODBQR0UxOXFqRmYrNWpLWHBPR3hqMFVrUzFQd2pENm1VS3ZzK1plOVdRbDc5?=
 =?utf-8?B?c0tpblpxVDZRbGZKcE80eDVnaFU4Z1k4VUJjeDRJM0NLb01QMjNLUno3Q1FJ?=
 =?utf-8?B?aGMwekF0WEZSSWI1M1kwKzZFSTVGNnhxWFNYNE5icTEyUnMyQVNIVDRaL21h?=
 =?utf-8?B?MXlmUWZ1WVRvSkxoWHAvaXBzOG9hWm9mbHFRcmJ3d25rRTFUWkxJSG1sZVNn?=
 =?utf-8?B?bnd0YmM3ZTkyS2dEZVdlUDNUdENodXVhMlVRVHFWbVhDOWVZQTBORzRGbmJx?=
 =?utf-8?B?WGpSMDV2MEUydm12ZGJhTzk2S1JzcDBlcmIwdDJUQmRueStaam5GT1E4L1cv?=
 =?utf-8?B?cDZveVNVUXg0L21qM3AxMVh2dWFwc0c5ZlI5ZU9MUkplRTIrZ0dDc0JRU01Y?=
 =?utf-8?B?RWhkSjdXdGV3aEM4MVZERkt0Q1ovTUt5N29naHlNTHpORnhFUEVZNUtaSUNo?=
 =?utf-8?B?Znd4alBYTEg2akJ1OHBjWXFmWUZiL1pYUjVGbmMvOHp1dC80QU1hbUprSHB2?=
 =?utf-8?B?bmg3TkI0ODBDdStNV09IZkkvVjdKNU1NanQ0eTA4cVoyTUR4VjU5S2lWdDZx?=
 =?utf-8?B?ZGJVS0tManFlNTFPelBhb1dzZk5QL2kwbngydlVlVnVsUmdTRG92cGlnTE4r?=
 =?utf-8?B?SXpRemRzYWUrenB6K3hOSE1pWGE5QW5SQTVkUnhGVUMwMzMxQmVmNHU0OXZ2?=
 =?utf-8?B?RG9nbTQrMW5FQ2tXV29OeVhvNjNHcHpoYlV4NEErRmFQb2t6QlJ2ekhSclBU?=
 =?utf-8?B?WXIyUWEwQ2dLdVBQNlZhb1gvU2pGV0tGaG5yaXFmS3p0NDc2M216NlhyTFJX?=
 =?utf-8?B?K3dXRXNocFJtRHNUZ0hVWTVFRHdMKy8rdG5SV2NxL2w5dCsvOXMraGcxL3VE?=
 =?utf-8?B?aGVVNzMvVTF3QlM2ai9IMXY5OStxZ1paWC9wRnFTdEptTmNvRTlBZ216ajVZ?=
 =?utf-8?B?RFFSSW1ESjBYR29uazNkb0RLSVlZWExROU4zNmEvZjFwMXRyZXY1OENRT21s?=
 =?utf-8?B?WWVTRjBUanVmVjZiYVJrTGZzbUlueHArZUQxdW1ib0tCNklsNXRLaVlxQnhC?=
 =?utf-8?B?Zis0c3Nxem1Nck5Hak5wa1V5dC92MkM5V2k1MlN0ZTNDRkIzcm9YYnZ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEthdGFRa09QZmhIV1YzMytjVjQwampsNDlnRWkvbVJ5QW81TC9rLzk0ZXRx?=
 =?utf-8?B?eVQrQWtOQno4UldJOHA3Yy9PSnhEbW5SKzlCR3FxS1FBRm5JUVU2OGZuMjIv?=
 =?utf-8?B?c3V5cGFDaDAzTVJFMUwwTUR0dDJJT01VNlc5eXFaSFhRL294eGFGMmNZR2Q5?=
 =?utf-8?B?SDN4RnVSK0lVT2ZsQTlaeXZHTG4zS3U0TnpvT0dLVTJJYTl3Q0NCK0JKS3ZI?=
 =?utf-8?B?L1IxTHJoV2I5Z2Q1Umxud2pZeGJhU0h1MHlaOE5vUWxRcnVPYXgwU1RyWkhJ?=
 =?utf-8?B?bmRhTU1NVmk2RlVERkJJN3Z4ZVFYNENMOXluNUd4cUw4YXdoTzNNQTBlcHV0?=
 =?utf-8?B?SjVWbm9vMks4ODhnTjAwSU9KZk9yajYvdGNlc256STJKWTh6RlJEbjFaVnUv?=
 =?utf-8?B?UVhDTEhIV0pST1VSTndRaDNxU3M3bkc3dHh3RFB5Q0hwbzJkWjVuWHcwVG1W?=
 =?utf-8?B?ZXRsWUsybnNtSytFdzc4cDFzSS94QlpBQXYzeHJHRVZaMW82V2I2RWVScFVm?=
 =?utf-8?B?OE11RnBkWkFWbzlVUVVHUFp3alJGcFNmYk9vaDRDTTY1Njd0SEFFM2d4SzVk?=
 =?utf-8?B?UGphMjJ4T2xaZ1AwYzJTaHE1aksvcFZIN3BvbHZSNnZuc3JLaUE1UDFoUUhR?=
 =?utf-8?B?YW9DcDIza3RBZTMxSzBIZDlwTHUzaHVjMTNJSkVzdURDcFUxTW9CeUpUaHRh?=
 =?utf-8?B?VkJJNXFqWDdLZzVHV1NQLzF3TGp1a1k1dVNtMm1ta2M4S2hEVGhLcnpTRnl4?=
 =?utf-8?B?WDRYUDhzd3o5OW9nQ05DVlhVbEdmSStFYjJVK0FpUHU3NDU1VTl5em5RcW9k?=
 =?utf-8?B?NnVjaWp5bmNYbklVeDZLSzJWTFpjRzNQWENUVlJ2c2xxNHRqQjdMamdzVTZi?=
 =?utf-8?B?cHhKZHB2MVBMVDY4VENEd2RVZ2tGMDQ4cWMzZjNCU0tQanBXRS9jc2lOdWda?=
 =?utf-8?B?OW55RkdETzFvVWdFZzhnSDdHQjFsbTl5eGYvc3J6dkRYTHNJMnRYcFZ1aTVB?=
 =?utf-8?B?cnNBemdweHhJQ2dhYVBteW9zZ015MEZmUEFLdSttS01nd0lLeGNiblgzaXVM?=
 =?utf-8?B?YWR0RW1oQ29wa2VGdFpBMWNuS1RpaG5uL1RvREk4MUEzYVozS0dwa2FTTFRq?=
 =?utf-8?B?eGpUSitDTnRLbFZhUG5OaGg2TmJzSTF4dm1KaWw1ZnR6dHFuMkJGWllUekha?=
 =?utf-8?B?S01BYklZdUNFTUozeGM3L3JlTDlRZzZDcGRTdUYzN3l3bXkzUGl0MGx5MzQw?=
 =?utf-8?B?QnFvQjREUmF1UndERkZPUUdHTDNxZXUrd2Y5MkhETjJjVGh1SHpnSlRKZ1lU?=
 =?utf-8?B?UWhsVzVZejdqcGc5UDZ3T1pqM2lRL1k2cE5HZ0lLeVAwUUU5YUhsZW9ZZWFx?=
 =?utf-8?B?NnVIbGhVY3R4bTcwL29rN2FlSnl2OVJ1ekphVytvYi8xSkxyelRvaHFObTdt?=
 =?utf-8?B?MU55Z2Y5TW1xNjFTRnMrQzZrVlpBdlgyQktwUXI3TC9ua1dQRXR0K0cxeWdR?=
 =?utf-8?B?WmtTTWd5ZU95Vk1UcHU1VlN1V2sra0toUXp2dUd2SGUwdnRNOWlKVnJUUEZC?=
 =?utf-8?B?VjZ2TjJwR2d2QnpscHJad3NtbndzRW94UG95Mm1CRTU2T3ZGRnNDdjNkTzVG?=
 =?utf-8?B?WHNMbmxmeEtvSFltSlZicXhhMithUkhQNEh5WVBnZ2ZYWEJRamRjVENYVGpx?=
 =?utf-8?B?TS9jd0luelRzblBZcDhaV05xR01hWjhEdHduQ1d5NWFKeFgrV2g5dnJCZHZK?=
 =?utf-8?B?QjE1NEtKSzJaNGJCaE5XM0FmRTBZZzY1aGJjNEFDQmdrQitzWHBjOTI2S01l?=
 =?utf-8?B?MHZuWVdYSklPV1I3RnZUZzQxMmhuVjFyMkU4Y1puYnN1SDZCNDFwaGRJN2tt?=
 =?utf-8?B?MDUwVjJjZytNTGtpUHlRZFU4aXdDUWZKeVdoblorWmZuYWZVK29MWGtaN3gv?=
 =?utf-8?B?Mjh0UUJHazlITmNnRHRvdzhMNWRVdUNoUmVrdzAzcU8rRG8zOURGeUxjTjRX?=
 =?utf-8?B?UVZqckcrQVJwSWxtRW9ZcXhGSlBmV0VKaEtSaHVhNW01Q1k4NEVWaTJhOS9F?=
 =?utf-8?B?a0dwTlFrQ3RKelNDSmVTZzlpdjZiWmI2eUk2UkU2U3RKMSszZEEyM0FrYzhH?=
 =?utf-8?Q?3Q6uD0X5PcCIGuahy/l+AR7yK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RCrR1pcqpSRMpkqK68A3Vysg7DeA1k3yuhc435eabD4KxLjHVEbTxkCU3BuSVTTUfviNOybi76y4l7aJeen+cgn1FHwQ0NthMPFVrTvIzmLC3XGpQWXiZ2+MMJ2lUE7g1EZmwrs8UWQumGxtryilJ6miZqweRH1zxdAIq3BROMRHeyr5K2WZ8RhYAQX23O87z4FxJ+sq3VnK/bAhrKLLpL5fACD9U/5BSV7nKGBORyN4iNg70JDKTAe8SVAchi1eSOMWDRmecW0u9DNu9Bbzx8YMwY03FQCj6X+05d6hWH7udlz+PO14xuSyRB2gAuopml0gGBRk8aTovgHUPQjklnckxu3PhfJcvFGfdXA4DpsDY3OcWKxhlVXIUXwyu8w+pz9Ir1EtGLWDAl3pXi6B1wRthmDojd+MTKHZj9+u5R2tVVs8ZUhfTsDw8Z8QpV3uSR/d2Lznl6Ze2u8i20kOFzBEATsoShpkjE7J8h1QA89zdSBwNxkc2LYIK13uobP5CPJl4hD6KYd/d+u6ZxN3qVCJNKoUTmOIJ3xPXI2S8fQZz4r6xg5/El6s8tNgGhq3tpgcCFaJHz5lzMb59kEBzRr8bn2OYYp0Jp3EwuxqejU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce0469f-2fbd-415b-f397-08dcede3cc24
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 13:09:41.9524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lBpaR8nqx5VPUn/oiQg+4u+9CVk3/N61N/trr0qAuoHQ3lyG3oFrFwSnPl06t905g2bYchD2tMGCAMgdi6vfRQETSJs85ENZfhhBRf8+pl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7642
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_11,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410160083
X-Proofpoint-ORIG-GUID: Hq3C2mKUFkLBIKkxzI-i9-Y6sQxETxnw
X-Proofpoint-GUID: Hq3C2mKUFkLBIKkxzI-i9-Y6sQxETxnw

On 10/16/2024 9:00 AM, Jason Gunthorpe wrote:
> On Fri, Oct 04, 2024 at 11:48:19AM -0700, Steve Sistare wrote:
> 
>> @@ -347,25 +347,41 @@ static void batch_destroy(struct pfn_batch *batch, void *backup)
>>   		kfree(batch->pfns);
>>   }
>>   
>> -/* true if the pfn was added, false otherwise */
>> -static bool batch_add_pfn(struct pfn_batch *batch, unsigned long pfn)
>> +/* returns the number of pfn's added */
>> +static int batch_add_pfn_num(struct pfn_batch *batch, unsigned long pfn,
>> +			     unsigned long nr)
> 
> This return type is truncating unsigned longs to int..
> 
>> @@ -623,6 +639,67 @@ static void batch_from_pages(struct pfn_batch *batch, struct page **pages,
>>   			break;
>>   }
>>   
>> +static void batch_from_folios(struct pfn_batch *batch, struct folio **folios,
>> +			      size_t npages)
>> +{
>> +	struct folio **end = folios + npages;
>> +
>> +	for (; folios != end; folios++)
>> +		if (!batch_add_pfn(batch, page_to_pfn(&folios[0]->page)))
>> +			break;
> 
> This function is really weird, why would we have a function adding
> only the first page of each item in a list of folios?
> 
>> +static void batch_from_folios_huge(struct pfn_batch *batch,
>> +				   struct folio ***folios_p,
>> +				   unsigned long *offset_p,
>> +				   unsigned long npages)
>> +{
>> +	unsigned long nr, n, pfn, i = 0;
>> +	struct folio *folio, **folios = *folios_p;
>> +	unsigned long offset = *offset_p;
> 
> Let's make more use of scope local values please (put folio, pfn, etc
> in side the narrowest loop scope) and the style in iommufd avoids more
> than one variable per declaration
> 
> I would like to see this patch when it is applied but I can't apply
> it..

The series is based on
   baeb9a7d8b60 ("Merge tag 'sched-rt-2024-09-17' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")

I will respond to all your comments soon.

- Steve


