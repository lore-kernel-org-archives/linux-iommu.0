Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A6C20B1E2
	for <iommu@lists.linux.dev>; Thu,  7 Nov 2024 13:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730985707; cv=fail; b=VQ4rmHVt1ZcVolld4Q2Cu7p6gr58s1Vl2J59vdo0fYy815PUaHsZlZTnSemKHkCyuIt/H9JC4yr3vJk1OLFhB0EZx4n9gHWlqROBw69izHD7XWXacetvSvAwBxWMZGDQKSrOyatIWWWyV8/YCatCSFtAnXyqrlLabtQFfpPfMjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730985707; c=relaxed/simple;
	bh=uqxf41Y1PAFUPHnmITquIFx8tcvtXpkxNVCk25AABTY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NkIFAha+kIQj2/deC7/eVxBOSTLCbNwk9tr1kLxddbVU5V5YxWoyzlmloXuo5/C4dQzMxsh0ata/AODgOyw2KRgjnuqeXLcBNWJt1J9iSAXAfG7Lmuwtt6W9egm2nRjx4V/CksCQtcKPUtV3njjJ/Htfo5Twm0fsvvI2Rq1s+lA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FZt9SCDF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GE9b7WAe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FZt9SCDF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GE9b7WAe"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7DCp2W026409;
	Thu, 7 Nov 2024 13:21:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=nOfKlQI/Bm4ejc4KLDMHc9eoRc8h4XsOeAnYk1T6Pds=; b=
	FZt9SCDFNOVFZhWQMwtpfivGQp/ZKi2uVLkFHG604tn+Uh7m8GXI53d8r2ovOmNL
	RQiqB8onPEW8tkyn5ZY2lqbx1ZI3U5kAcGOXge5EC4TRVGNey9qWujDtZSwhT4EY
	JBtbUYATo8atVGvikxGSJHU7ksf45EjnGiuHNKzlmOPFu831QCwkitg/LTN+DlRV
	kLJ3hG5lT24kohc6P7iT5ztFHzrj9TwCOaulSUMASLQVBUU6B/yeBZ40/Fh0Xm6s
	nRHbhr23DPYENYtrh6aNUHgXhubmGAAr9j+vATVAFd9LgsjXPC9Oex5BKu3WTxLp
	bt+ihn8ARgUlMJKRPWSVbg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nap02fnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 13:21:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7CNwfD035232;
	Thu, 7 Nov 2024 13:21:22 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42nahgas86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 13:21:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WBwq8ZxPNOF96+cDXckf56qyp/ovXT1UTD6TBj27f3MFbkuQX02pev+G2Qo7U85CUwH/C6phbjRS5nlI5dSpRoYISDkJgEVmgB+qse8Zx8hClUnTGbVljl6oVXJqumP3Ej767gAQDzB10VEv0qWtVyi/Dq4RGJj0WEtm9mcKnezbXyJ0mDkVgALnS4k/DDyNhKlmhn5EwXw6VGnXL+APrjQ/QLb3O9peG15a4sHJULxgAhzBYpNXE3zFdAgm8wXVV75Fz8NUULAziuNCUhTb5iovJrfK8m0Bg1BadUHuodD3bujzSodsGsQKBOYWYgrM6EuIA0ok58Txwt23ky40wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOfKlQI/Bm4ejc4KLDMHc9eoRc8h4XsOeAnYk1T6Pds=;
 b=cuhumJxo6MfQL+nQE1x7At5suTUkjDQPgEak/HhBCaArCB72sl669aeElKF9DgvzA23faBPBAIcW4dmfDGtBPbx25E9HDNcJxlJKZJ1Qt7DjfwK9DeSH9EgkjSnI9gG5gcaidRAabCZpbhDCH+78WTGnsqLECIUWgUBDgpnRgFtavovCMieZhkS5lLatpiLs9CMvVJQKYgLvIC8jvdm9/u6uYtDCflV3FkHRSDXar7URJcxdz5/0p6DJniJKD6+XG3xZdif93NnBFGN0LOsC8vPxHoeGv2p2q0IhPCcKuSDMr/qkaF8PLVNtYJ0ShChaAdvlZ7r3XIWtCDY5R6Ea8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOfKlQI/Bm4ejc4KLDMHc9eoRc8h4XsOeAnYk1T6Pds=;
 b=GE9b7WAek8kUugannWQPUuhRdSKnG2RlwYR8qSnhP7fAQPyavdl5tz4wRK3rdp3JdCmJpkYyHRevIwph1XMbhebe6sk1hu5hM624d41M3Ct7zb1Eqe/npuDDpgiCOm3aZDYXnZk7/CyiNlI/b8M7VoP6FBEfB1sGMDMGFopeShA=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA6PR10MB8063.namprd10.prod.outlook.com (2603:10b6:806:436::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 13:21:20 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 13:21:20 +0000
Message-ID: <201b3c80-55ab-4ef4-8d95-f995fa63ce03@oracle.com>
Date: Thu, 7 Nov 2024 08:21:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 6/9] iommufd: pfn reader for file mappings
To: Alexey Kardashevskiy <aik@amd.com>, iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
References: <1729861919-234514-1-git-send-email-steven.sistare@oracle.com>
 <1729861919-234514-7-git-send-email-steven.sistare@oracle.com>
 <8f2fadc0-1872-49db-83aa-314352adbb6a@amd.com>
 <7788773d-471d-48ad-9f9c-ddd5671b26e5@amd.com>
 <2bbfb5fa-20e5-4935-b52d-73b5186c6123@oracle.com>
 <5ff5b402-95c4-408a-99f0-2f6ea4e617b8@amd.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <5ff5b402-95c4-408a-99f0-2f6ea4e617b8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0374.namprd03.prod.outlook.com
 (2603:10b6:408:f7::19) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA6PR10MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: d3b67856-f1e8-401c-db01-08dcff2f0f21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVNsSXRHbHFXRHBZTFF2bTVLYmJCM2hQUXBmV2VGWnRNcXFsVGM5RUJ0c0k4?=
 =?utf-8?B?NThtVmhQclZQeDNZdEt6bVhsa0JGUXhuL0ErRWFKNE5KSGx4dmVTQnlvZXd1?=
 =?utf-8?B?VWNpYS9Pd2QwR1I0aTU2YkJXNGhOb1BvUHQzZkVFek0zZzZHZGNrNnZTTGpk?=
 =?utf-8?B?am5qWHZlbWlLK0lHNnllaVB4dW9kMDBjYjFVUU92WVYwcjY2VXhla0MvbGZZ?=
 =?utf-8?B?RTRQZ1hXNEhiRXJwUlExcW9qaVhxbUdTMmF0RnZxNmxmM0J3SEpWd2NvbW5W?=
 =?utf-8?B?a2tRU3FjTXVSazZzUFBKM2RLRXE0MDZhSWx0cUhOYlp1MGFnMEVWTnErSkk5?=
 =?utf-8?B?RmtxdGNRdGhzdnpLZ0xtLzAvanRBcEtGeHlqS0NGMUFFSkIreGF6OWt2azlu?=
 =?utf-8?B?VXZsZHhVZ3NvMkp0WmxqVnl0YWtDeFJFK2thUVZ0UXpvMkZHQ0dRMmdUTnNE?=
 =?utf-8?B?dDZEYWNVVERrYVRqdEExZVdjRzZlL09aQ3RTMFFBenlTc3ZkdmwwN3orU2pr?=
 =?utf-8?B?RiszYXpFN05ZVlpxNXVabHpYbC8zb0xyM01WNkxSZWh2STFoUkFJWU9pa0xy?=
 =?utf-8?B?RE41TW1BbjByRGJWWVI3OE5kbzhLNUlIQ0trOW9JditBTFF6TFMvMHRieFhv?=
 =?utf-8?B?RjUxc3JsOVNhUC96aGtoakhYK2dxcmczUGZBdUU4bHN0cGlCY1ZURTcvV0ty?=
 =?utf-8?B?M2hlbzhiTTFYdFZNRkZkaUtsZ05ta29OVHA4UmxoSU9KU2ZyeUJiTWtXcC9Q?=
 =?utf-8?B?c3dNVVlJRGFEQllFMXlEcDMreFZET1dpZmxDU2NzZWtjSTFnUVRPVnZ6bklz?=
 =?utf-8?B?NHBNQjdsdGU4U1R3ZmFLZXlETnc4R1RMKzk0RWUzYnJlSm1ZOU54RHZGQUNq?=
 =?utf-8?B?WTV2NGpkT050b2RlcEk2RmVVRkpaUndQbVdxQ0V0TG00eUhGR2pUQnRCcURj?=
 =?utf-8?B?dlpnVHlRQ2NoZWFyeElqSWxJaWYyTmdOTm1DREE5VlN0alY5ZXVLaHVYVG5O?=
 =?utf-8?B?YjJ3L1h0V21kVElCdEM5akZWMnFjRkVUS2l4YlpEL1cxL2VVdkp0Q3k3K0Ru?=
 =?utf-8?B?WmpMbDhVVXpHK2ttUld6VGdJSi9zUm1YU2ozOWtWakV4VkFQenZtWWZJZ20r?=
 =?utf-8?B?ZVRMcks2MlF6eUVWNWxFdGVQT20zazV3Z0N3bmZhbkhjdHU0MVpuWUtZR1pZ?=
 =?utf-8?B?RnBPS2ZqYUxOQVZKSHUwTlRmdjA2Z0prK1kwQ1UyYzF3MllZMGxVNzVtejgr?=
 =?utf-8?B?Tzh2Nk1mWkNHUStPZzVMNkl3YUZZZ0o1dlhxWitSWFlsdmlndVo0MXcyOFAx?=
 =?utf-8?B?WEJVVDNpOU90OVRrZ210cGlEQ0NDK2lOalRzVkVWZVRjM3BSMjRFNnFoa2Fp?=
 =?utf-8?B?RlBWMzU5NEsxSWhPNVlmcFUvRllTS2dQMzNtY09qZXBPNzNZNlArclcxdG84?=
 =?utf-8?B?YjkyRGgvcUFrczQxdmRYNHlQZ2lmNmNYWXRuUG4vTEhTenJaeGlBU21VcTlm?=
 =?utf-8?B?N1JmaWxFcWFhbG92RnBmdVRSK1E1NW5oMzF3L2hnOFdqVmErNTVxUlB2b3Uz?=
 =?utf-8?B?Y1NIZEF3dVBmc2h2Zks5R3JOcWhCRFcwOVNTdmJFNTNsaFRMZkJ2YUZFeUND?=
 =?utf-8?B?WDgxd2s1ejY2djRhbmJqVjh1SjFFMGl3UlhMcEx1dXRJVG1GNGZEd0JESXE5?=
 =?utf-8?B?ZXhEVEUvZ2ppVWd2VWFwdEttRUFrbmlXZDVHcW1LcHB0RC96VE5XZ25Tdkhx?=
 =?utf-8?Q?W5v/ABScRmpzvmV8LCHmeeIx/t1pWZOI3ANpLpE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzB0SUVsRHpUUUNsTDVoMm4rTkNReVl6RTBYaGtxVWhTTGlhdkk4RTB3eVND?=
 =?utf-8?B?YVUvS0VIdEs3eG9QRWxMQ2FSMTVvUUNtLzdxSUhIaWRPQzc5N05VK0xuUDgv?=
 =?utf-8?B?dklUdUg4ZmxMK0FhWllWZWFCR2c1NVlZTXVqbE02cXpabHJTMmZHaXBzNDJY?=
 =?utf-8?B?NUlPS21menM5RTRocTVKVTc2MFRueS95YitmL0cwWlFwTXBsdUdJOGxoMitn?=
 =?utf-8?B?L05PV3BqUHM1RU4rRXhyZkpwbkMzSE92UzZDcEJjOXZZZDNXTmE1emFMZ3ZF?=
 =?utf-8?B?cjRNSjNpS2pkcHc4MUNqQ0tuV3cvY2l3d2x0cjFGRnh0MVpxM1kvL1JmeWVq?=
 =?utf-8?B?U2JVenU2Nkt4c0daRlVDY1p5WCtDcjZIbTU3N2t2aklBeFNMdmRQL3J1RVhq?=
 =?utf-8?B?MWZ4UWYydW5SeU8wR2pwSGdBcUpKUTlQQ1NBMDVVYWdhVzFjbzhjMDdpcEdH?=
 =?utf-8?B?NFUrWVV1bmFLYjFiSFZoazJXWG1JUVZsTC9aOWs3b3o1RUFxSSttME9ZOXNN?=
 =?utf-8?B?ZWJNRXRTdWxsendwUDNFTWIzb2ZEV3c5VHRTaVMrejdubkovTGlMYnM0SSt3?=
 =?utf-8?B?RGJQNDNtbjdMRzNxMkZVcEhmYi9NWUNmV0lIV2tRZlB4ejlCS0VNekdHRzlU?=
 =?utf-8?B?OE5RQjJUMDVseUtkamN2aFhheDNzSUlTaHR6RWpybXpsejd0U0R6MTViTllv?=
 =?utf-8?B?dHYvZmUyNnlBTDBqSVgwZk84OG5yME1sbnF5Q2M4R1VGK3d5c0gzaWlsYTVD?=
 =?utf-8?B?RksrbEFmcWdpUkFTT3VXcjFKS2ZrVW5WMXBLcDJDVWVkQkpScTFaNXlJeHdN?=
 =?utf-8?B?SzFSa1dlendYSHlSQTlyNnUwbTJGSUVKcVcvOHl5M2pUNUsvUlFVbTg2ckNN?=
 =?utf-8?B?MTErcVJGQXhFWkcyWDQrTERvYm1OZ1dnMTNXYjcrMWFFYWE2N01UdU1hZFBx?=
 =?utf-8?B?bGVlVDY1TDNtS2xoTUxCWDdGaWNIbDFtbHRtVzlBdEJGaFM5UDJXanRKb3B2?=
 =?utf-8?B?LzJRTGEzbnZNaThjRThFUlhjT09rYkxrd1NVUE9oY2lLcjZFdXFoQWZzWDAv?=
 =?utf-8?B?Q0pGaSs1UFB5d1BXTlNOVnFyYUUyTHdhRG1Kbm9JdFNaQ2Zoc2RuRUVzcmR2?=
 =?utf-8?B?U2FFeWRlZ0xBbEJ1WHljZkNFVEI1ZlZTY1ZGQ3NyaFkxWHo0R2I4V2JqWnh6?=
 =?utf-8?B?RTNHL1JsMUw0RDZVYnkzQlkvU1RDaUdaM21LQTJNVzJCSVlnV1NDcjc1MzB5?=
 =?utf-8?B?djRXVC9ZK3o5WHVVWWRIcXBEeHNMb29BTHU3bHNOb0pqdkhWc0MyZWRlMysz?=
 =?utf-8?B?UXdmU00zVzdmV0RlZEFQbmcvS3RCcWkwMnJZcmVtUERPNS9SblZnOFhlWXcv?=
 =?utf-8?B?N1JMQWk5dm5uVTFUblV6bTZGa0h6bmV6dzdOeEpYVWJ3SUhPZTc4WjRjOEJo?=
 =?utf-8?B?WnBoVWRTeWphaWhkWUFkL0hsWkRDdFVmRFVGVFZjbDEyK1d5NnFmVjZkNit0?=
 =?utf-8?B?cFN2RjAvcE5mdERReGRlOTlSSGFvdHFTazNIWUNmRys2UlZKLzA5Ui9WM1kr?=
 =?utf-8?B?QUlXQllSWW9KYVFJUHNUdEkyVWdvSkcyYWtnRzd2d2VXZ3JBYUF6UllGVFlX?=
 =?utf-8?B?N1Q2NG9RRndCcE01WnhhcG1IVERYTUdzaUhxa0RyN3p4eXN4K3hTWW90WHln?=
 =?utf-8?B?LzB2cU11OUVCRkNvMm9uTTRKTDRMUFRTZWFEWGprQnNvK1lDQVgvMHFpeFBZ?=
 =?utf-8?B?OWRyam8vYmk3NWQzMWhzUCszdEtzL1haWFA0cE9uM0U5ZGVPQ1pjQ2hCSFdj?=
 =?utf-8?B?WkRKcEpTVGxURUg5UDc1M1JadVdxR1ExeDVSRjdsajlmTzd1ZXduTEo1QkZy?=
 =?utf-8?B?RVhScG5jV0tvVEI3RmdLYytjMWpESS9IRG02NTFucXR2ZkJoZEh1Q2ZUQkxy?=
 =?utf-8?B?aTNsSmQ2SlVWdjlDZTB6MFVMZDBTUnJVM2llODhBRXZpTkF3VE5wdUVFc3N3?=
 =?utf-8?B?YjhxR0ZiSktzTnZKNFY3NldRNkVIRjJlSUFlSVFFUnI2eEI1eUs3ZDVPZEpt?=
 =?utf-8?B?Zk45clBRQWhXanBwSzFPTENiQWJLcmp6ZDZDb205TGpvRUNVSGlKRDVmWUdz?=
 =?utf-8?B?cWVPY0hETzJZaWNGQURmbEtNc0twenFqbFNPWHZHTTNLblJGNURvU0d5WjY2?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QWkTl8LM30dScg9BGaAsg9vK7wPahrvw9RdEq+Ohk8GKjzrG5nNp6xpEi832TlJr7RL4K+C+C8SpfiCMVAykD26BII7EDukZtk4FJfvieA7Dj1VbSVvAQSXVUJW9MqgtDIzRY9c5VqM8gsxbazq18yqazIFS7xZamZzvCLCmi6Jpp1HvUgZ3dy5Khd0XC9/57rcG5GMhO1a2kwVMYNjSAYCC5U3lDCLwc7W0lR4LDjX1sUpzzQ5yLKtqZgu/+kBcz7fmbjdk0pDeUrgfZt8tvXozDremBVB6UWc/sbtICtZ6lBrPpKBziaqOiHU9culnfnkncyk7rPvtWfO9PmsM55hs4rEd4ENjzr4YRzo4cPcveoszYccOsX/VsZMaE7H+uNF9S9xElkq1tOmKECuVNaCwxyy9sAt2+/57jj0xxpCFIXB1qIkdNaXfvl29398p8Fz0fbZ6cgOAw59JuvnA8s7SjMCQp4HczADk62Xpm15D1FnSB/2+0yLgp1vhbDMMU8SgZiIzLN0l/w0P7L/0meVGB+LuCjlJ1DTVGJq7/bGNaTBcVy8CafEvOuKnfapNiGHln1SMKyAZCtgiFnImtv4tkb5xKIOXEOmztjCE0GA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b67856-f1e8-401c-db01-08dcff2f0f21
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 13:21:18.3555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ImdxJzu+vLpPU5digAME7/wg5kNpm7shiVaMDG9J2Qai5wbRRXB2aLSgV0TgIVDqMZa1lqva95jLLnZ+vRZd9I/zXRym2bTCRZNmY40BnDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8063
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-07_04,2024-11-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411070103
X-Proofpoint-ORIG-GUID: hyk6d37p3iKUxnkmFt6H7DML2GO6eKs9
X-Proofpoint-GUID: hyk6d37p3iKUxnkmFt6H7DML2GO6eKs9



On 11/7/2024 5:00 AM, Alexey Kardashevskiy wrote:
> 
> 
> On 7/11/24 00:19, Steven Sistare wrote:
>> On 11/5/2024 10:18 PM, Alexey Kardashevskiy wrote:
>>> On 31/10/24 14:34, Alexey Kardashevskiy wrote:
>>>> On 26/10/24 00:11, Steve Sistare wrote:
>>>>> Extend pfn_reader_user to pin file mappings, by calling memfd_pin_folios.
>>>>> Repin at small page granularity, and fill the batch from folios. Expand
>>>>> folios to upages for the iopt_pages_fill path.
>>>>>
>>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>>>>> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>>>>> ---
>>>>>   drivers/iommu/iommufd/io_pagetable.h |   5 ++
>>>>>   drivers/iommu/iommufd/pages.c        | 128 ++++++++++++++++++++++++++++++-----
>>>>>   2 files changed, 116 insertions(+), 17 deletions(-)
>>>>>
>>>>> diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
>>>>> index 8e48266..5ac4eed 100644
>>>>> --- a/drivers/iommu/iommufd/io_pagetable.h
>>>>> +++ b/drivers/iommu/iommufd/io_pagetable.h
>>>>> @@ -177,6 +177,7 @@ enum {
>>>>>   enum iopt_address_type {
>>>>>       IOPT_ADDRESS_USER = 0,
>>>>> +    IOPT_ADDRESS_FILE = 1,
>>>>>   };
>>>>>   /*
>>>>> @@ -202,6 +203,10 @@ struct iopt_pages {
>>>>>       enum iopt_address_type type;
>>>>>       union {
>>>>>           void __user *uptr;        /* IOPT_ADDRESS_USER */
>>>>> +        struct {            /* IOPT_ADDRESS_FILE */
>>>>> +            struct file *file;
>>>>> +            unsigned long start;
>>>>> +        };
>>>>>       };
>>>>>       bool writable:1;
>>>>>       u8 account_mode;
>>>>> diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
>>>>> index aa79504..5f371fa 100644
>>>>> --- a/drivers/iommu/iommufd/pages.c
>>>>> +++ b/drivers/iommu/iommufd/pages.c
>>>>> @@ -752,19 +752,32 @@ struct pfn_reader_user {
>>>>>        * neither
>>>>>        */
>>>>>       int locked;
>>>>> +
>>>>> +    /* The following are only valid if file != NULL. */
>>>>
>>>>
>>>> Are "struct page **upages" and "size_t upages_len" still valid in this case? The code (kind of) suggests they are not... Thanks,
>>>
>>>
>>> Ping?
>>
>> Sorry, I don't recall seeing your first email, but others asked this same question
>> and I answered.  upages and upages_len are still used when file!=NULL for mediated
>> device access, to point to the pages array returned to the kernel client. 
> 
> This would make a nice addition to the commit log :)
> 
>> Maybe
>> "u" for user is not a good description in that case, but changing that and still
>> using "u"pages elsewhere would complicate the code for little gain in clarity IMO.
>>
>>> Also does "user" in function names mean "userspace addresses" (as opposite to "file"? 
>>
>> Yes, except for mdev as noted above.
>>
>>> If so, the patchset makes many names misleading then. Thanks,
>>
>> The new stuff I added is prefixed with file.  I left the existing upages names
>> as is.  That made sense to me, and made the maintainers happy enough to accept it :)
> 
> Fair enough :)
> 
> I was initially pointed at this patchset as an example of how my guest_memfd pinning of private memory (CoCo VM) should look like. And so far it's been good except the actual pinning part - memfd_pin_folios() - expects the file to be shmem or hugetlbfs and guest_memfd is neither (well, last couple of months). Is there any plan to add those? If none, I will then, just wanted to check. At the moment I do what KVM does which is calling filemap_grab_folio(). Thanks,

I have no plans to implement guest_memfd pinning.  Not sure about other folks.

- Steve
