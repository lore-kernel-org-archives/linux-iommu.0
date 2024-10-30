Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850FC22315
	for <iommu@lists.linux.dev>; Wed, 30 Oct 2024 12:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730292231; cv=fail; b=nvSqbCI9QYlqCBnp+zr1g+Vg9o+7uAJMgFXF2Ki/RQM47y4DbBy/+FBS6T9znjqmft28omXcUqFGelB7yOZPud0KWf/lgekSDy+n/UyBygRdz1dGGsWXt80rdIc4p1rJSNNcwNmEq1eSyK3f6j6PNG4kwFbQ1xO8MZe5+DomeMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730292231; c=relaxed/simple;
	bh=IyAB9H59oAj16KJ3MN45pQylBvC+pmphMMCD7YGwwMc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jFq5t7QioTOMre2peBPfJ9qjy4iSjKf8/ouHCbL9bd4Xr1CEubPFXOt3RFEQ/BA4yI40pl0lNAyC/gjcZ9iHL8awjkGMV6raTp73bVryWY9IY/2/+Ps9viGfPe2hMcEhq2jhU5VV4vZ+6ROj8HdyJeFXOzgiS7EGeHwREX5OwhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IggRsCUM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qTTBLuSH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IggRsCUM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qTTBLuSH"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49UCYdvW012557;
	Wed, 30 Oct 2024 12:43:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=SGxTVYEruYVOEtkOwz4je+YRGGpAJ9KhyPoN8ndiWjQ=; b=
	IggRsCUMDVTmcxXi/eQO4BaszA0o70Uue6Dpkgus8Yahc8rEtMQcWJwhvqTFyeEb
	oo5Sm778j4CsqOLG6C6G/lxlxKZd5Mc4fjCtPznrn3tX4g5NVZKnyhCr0EwCQPFK
	FNU2XrNYQTEJZWf/582nKf1gKphSD8Oko/hR1bA4c2olYVxbe/zJaPe69yYs5TN0
	0cJv2//kzqjxMC+P0O+gXbq6zkalld47Pa0eoJO41MoGD8d18WRDhD/dgHY8dw+T
	e6kA1sVlZZJiTKFDDRulW9Znd7+iVpqgZk1+SWmfdLQPSpmuVbRgpXkKV61iH7ZM
	8ph6Ars4+3t6uPpCPe5NEQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grys7x2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 12:43:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49UASfcH011166;
	Wed, 30 Oct 2024 12:43:47 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42hn8y841t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 12:43:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3GlIqIUtVXQGyHm992KVQwOJpmx0ejB2X8mG1q5Muk7md+GL64cotAH+0Kf28juxUc286mka68m4knsk6xCeJ76g7wr/11C3svZnLNYDnJNWzK3AhNkFys83iLReCN/KOugMKxFqhdR4R5aXET7hBikKd/Gb8ujd8Asq9ERAbwPaCaq2VykIkpqtWEibeH6+ZL+KFP0827ysWR0KcDwcjnZvSyg1l94WHrbUqmZUvYHBwUqkO5e9MG1sb/9rPEa9P+09f5j8eTnDCWDJMndASJNOTqHjGJBNOMkQZiR+SYE56jF2GyFUO88LU0BdQtdxcxB4kfkLVVzE+GkbH5tTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGxTVYEruYVOEtkOwz4je+YRGGpAJ9KhyPoN8ndiWjQ=;
 b=QURKNqpkbkO1hw8s9l9vMnhelcCtnKDWaethXu4xYIOslqe5t5EG7kPGFhd9e4Q36Op/lMO6lThhfZxslT7BPcseflJS61oD9vs4OFicqnNQx1GRkpzZmcPg7TMNkPnDERGDDNml5y1oOyRBs+etJI9eUTcnYxphShH7KFkLZEGRFWtAEQGmDN3Sf7yc0b/Evlrvs2bMfdcihpIjypsQMO/UguM0SE9b9WrtYiRgVgxZZbal6v1Xu1hKENbnNSP6k7dyFkUwL1aOR6VeKvJg334XjhmBEeVEbUi4g+L1S6WrBA3S5Hti855OphsoOFJfovYbiBgVMM2HiTClKNhy4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGxTVYEruYVOEtkOwz4je+YRGGpAJ9KhyPoN8ndiWjQ=;
 b=qTTBLuSHNP/YyBvrVlGHBaIE56vhbfsgPaLoQQep3ficYTZq0l7Aki50MN8vv7TrPmTh+PT34eGgk6bcrz3FJZwwPIBDKiaxfXhCnIYlzHmRq/B1SpYGaKoVjD1+0U0KhFQgO/+X8PGh+2mEVs8iSQokZ/ygbY3/qEOuZ8G01iU=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA1PR10MB6808.namprd10.prod.outlook.com (2603:10b6:208:428::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 12:43:43 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 12:43:43 +0000
Message-ID: <1bde901c-980a-44e0-8f6f-8e1985683349@oracle.com>
Date: Wed, 30 Oct 2024 08:43:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 0/9] iommu_ioas_map_file
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
References: <1729861919-234514-1-git-send-email-steven.sistare@oracle.com>
 <20241030001102.GA251312@nvidia.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241030001102.GA251312@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0042.namprd07.prod.outlook.com
 (2603:10b6:a03:60::19) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA1PR10MB6808:EE_
X-MS-Office365-Filtering-Correlation-Id: e74a13c1-d2be-49e2-131f-08dcf8e07d1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bis4ZWsxUkwyUzZ1V0kwSXpFNEE2VE5lRXo5dm4yRmI2bEhZSkhlTTd3THRN?=
 =?utf-8?B?UzVvZTFQKzNqeXZNWk9TSWtDdUpyWVFzdXdmZFd4UFVtODREQVlIVUQ1dXlU?=
 =?utf-8?B?SXJSK1RFeVFKOEhWcmk5dXVFZlg1b2hWZ2NpOGdEd0JkQnQ5blhiUkNwRkp6?=
 =?utf-8?B?WmNraVlmV2dYMXA3REc5S3dnZW1tUzE1NDNmM0xCUHR5NXpzemRNdGVPNWtC?=
 =?utf-8?B?Q2Z5S0d4cGlHVjVOREx4T1hvclZBUmV2RjNTR2FFVlN6ZS9SSWpnd00zZUpl?=
 =?utf-8?B?eVZLQnprWVNXcHpLOHpTeENnS3V5OVgwNVNtRGNLek04K2xhUzVZaStvRWFY?=
 =?utf-8?B?eDMrVXRmbWUrd0JhS3pSbmJ4dTU3R2d0b3h4N2loZm5kbnRCb3RzZ2diajI1?=
 =?utf-8?B?TDcwblBlU0FtUXUvUzV3ZXFpN1lyUWlHZjY4VFpxSjY4SnIxN3Baa2k5c1Nw?=
 =?utf-8?B?Y0Vjd2JQTHBTdXAzaUVJaWZ6YS9IQktOZ0tOVHJCd1BOMVBqcHZHemlCZThR?=
 =?utf-8?B?S0ZVRkN0UGp1eW5tRlFMcGJQS0VvWXdBL3FoOWpNN0lxYzF6ZnkvU1VUNVo1?=
 =?utf-8?B?YjJzRXRGYVB2dDh5dU9PRVl0aDhNYXhOOG1oSEpJeXB3NW9jNTJDRGVqWUdn?=
 =?utf-8?B?aTVSbUtnOEpVRnQ1dmozL3ljcWtvSzhJNUFhbERUMzlOZTdIYzV3U1pLN2d0?=
 =?utf-8?B?Z2k1TC9mZUhSZlp5MUJoMW5nSzFTM3dSU1BZMGRmUUNKc1AwOHY0MzR3N1h2?=
 =?utf-8?B?TklvK1lUQjZUOG9zNzRyTWpBTy8rcVA5VGtKMTVJM1VXeHkwUkJHM05XM0pj?=
 =?utf-8?B?amJwL0J2ajRYODl5ZDB1U2N4UHhrQjMxRFNFcUIwem44Y2xWRktKb3VnMlJD?=
 =?utf-8?B?bzVFOTB4RDBWc1Mxc0lNVXlPY0hObFZXSENxQTd4WkdEY0VOQTdYOU5oeEIx?=
 =?utf-8?B?TUVPN09oK2JYcmprUis5Wk5NMnF5ZW9uUUxMUUI0bEFPMWtJb0VVUDkzdTBD?=
 =?utf-8?B?SVcwQ25WUlh3ZEtRa3dReVR4UzlOV2V4NThUamp3R3FZQ3kzWVd4SnEyZHMr?=
 =?utf-8?B?YVpWNjUxM2R4UlBselpLVjZ4OFhVK0ZFMHh1dXdKL1VVY1lHeGVUaXQ2aGpI?=
 =?utf-8?B?Nmw2dDFjeWJwdHpLR2RKczJwM1JjazBWSTBuRFlNT2trdkF2V1oraThZNlB4?=
 =?utf-8?B?QWU3aTd3Rlc3WmhXMldTNFZhVVoxUnlWMG4zSjlPK0p5VFJhYXVzQmlUQ05W?=
 =?utf-8?B?bzRsc3hMTmhQTWo4b1I2Y0ZyZmNYT1dHMGxLYmRlNWpMRzZ2TnJublVnMVE4?=
 =?utf-8?B?ay95ck12dUxZL1lpT0hKOWk1d0ZsV1BSa3A5VFkxVDJZRmZPaVdtMnJwWkdt?=
 =?utf-8?B?ZEhmMU04M3RaMk1nbkFYYlVTMEJRNWphWGp1eEpPR01kSndJQy9VTlhmTEhN?=
 =?utf-8?B?eHd5M01aMEk1cUNCUEhPMmxSTmMzUkU2Q2tNM1FnVlJVRnFEdDdTODRUaFYv?=
 =?utf-8?B?TU9oQjBuaHBjNDFKWW5GVUxaNE5rMjF4UVVhK1M4YjVLejJnWkNDaEhqMXNY?=
 =?utf-8?B?Tkc1RTZUSEk2TTRwNjFQOTlGN0tWd1k1OWRZNlBQVEU2VHJ4WkY5ZHMxOTk3?=
 =?utf-8?B?d3psSXE4bCs3V2VFbTNBWFFtVDBVNytXRnRQNzA0ZWduN2JOVWpiOVZNKzNS?=
 =?utf-8?B?OTFlMXNEOHpNeVJRa1JwRFMweXRyTlBJTWhlUkRjdnh0WnFOQU9MTk5ucCtT?=
 =?utf-8?Q?j+mXwsHfa0fWxYgh8LIZLBvTo32r9xduie8zeDI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S25YNmNtNjBDbTdPaGtMVHpaeTNUTzBrUkdHeHFuOW5IYzB6enhIZjVWQ0V4?=
 =?utf-8?B?cUlaTUxUMmdubFZqbGlScjhxQ1l6SzhPTjdCYnc3amZrdFlPUG50Wk5udm9u?=
 =?utf-8?B?OXA2aDhRS0xIbHNLMWxtcEhHUmNFcWRITXNOVW5nby9YeWFFb25sQTZaU0ky?=
 =?utf-8?B?OEsvcGpEQVg2ZFNPT0JmUXp1aCtiSEpTZGFzRzdLSEtBMU1rbVZDcllydGxD?=
 =?utf-8?B?VnppZXF3anJUWXNFOW5ZdlNOb1RaMGpVQzdKQWI4YUNQMWhiMmlRSy9oMFRD?=
 =?utf-8?B?UzZFeER4N0JRc0F1VnNmenAwMEZCb2pEemdxQXdnWFlNWWpsM1hEaHFSbTZE?=
 =?utf-8?B?TFJMSEUzVTVvR0ZjNCtZRG45djlJNEdqSm5RZmtzbWtRdXExS3hETldOWm5z?=
 =?utf-8?B?YXRzOCtXUDc2Zk1mSkpmTDVYRWZLTVhrZGRZUk1jRkFtMHB3WkRxbGpsNVM5?=
 =?utf-8?B?eHBtbFhBSTI1VGJ5dlo2NGUyTEFTcDdtMVpjdk8raUVVaE1GbzRYVkJOdUJl?=
 =?utf-8?B?SE1QNWs1MlczdXR1ZURWY3JmOVpBelpaNlFiRkUxNVBTZ09wcU5MRVpRNGNL?=
 =?utf-8?B?aDNyRHdrbHJaWWlkR0F2akZoZnpmZUFxN2wvYU9uaEVranpMVTZiTy9ORXUz?=
 =?utf-8?B?SU9FczNJb05qcU1VK2ZzNzBFR3NRRlZTamR2RU05eHBoa2ZtT2VWRWlPZktP?=
 =?utf-8?B?bllaM09vWW9peFZvbWVHRzFLYVhnWHBiRDVJR2hEMmVFdFZkalRMQ2ExRFJh?=
 =?utf-8?B?N29xa2RUYXNSbHJBdVI1bEliMXpOSWJKVDhuR2xwVDhiZzIvaWNQNHVCVG9V?=
 =?utf-8?B?a281VnpFbFF6UWovbUo4T0lnenM5MFArUW16SUR5MDM4ZVlzS2V6eUNWR2dm?=
 =?utf-8?B?MU4yS3VMbWJ1cUZLMHVjelJzdEZFKzFJRG45SDRBaFNRMmc0MjJ6TEtjMWgr?=
 =?utf-8?B?RSsvVmQ5eDBDYm9yMDZINml1c1ZOZEF1NXczNzJaVFliNTJQeDNaKzVLVGZF?=
 =?utf-8?B?UFNkaGY3UHFjdDdnSWdzNDkwWWJMai9WZEtRUDVtOGJvQTJVZTg0eFJhUXZL?=
 =?utf-8?B?bWpnK2xTZ0JUaUFmd0g5ZHFmaUtZSm5tY3BBcG1mVURaZW1OckpjL2tYajZ0?=
 =?utf-8?B?enFXWkRCYi8rTlBGelNKaWV5ZGxDazZZZDN3ZDk1RmFwOWlDS1JtMTVvQ1B6?=
 =?utf-8?B?UkNMYW40K0NqUk5VV2tvdUIzYVRCdTFLaGZXRVhIcy9BNVNSMHRkQlZLamlp?=
 =?utf-8?B?QlYra3VhZ1lVQjVhZ3c0T2J2S1lBRXFpUGt2MUhHWksvZ3IyZ2RwRjV2Z09x?=
 =?utf-8?B?a01VUG1uSGpiRGhtZWxNWUhYakRwS2tTYkpMUnhjbFJDbjZiVzc5NTVjQnJq?=
 =?utf-8?B?RlVwdWcwNU14VHJZa1U4Wm1jaEhTaVhxQ2R3QnFSWERCb1k1QkRPTUhZd0l6?=
 =?utf-8?B?UmJoaUdmYnk2Zi9RbU9aVXlyNWVYVnhLZ0JMYnNMdjV2RDY5UERlbWQzdm5m?=
 =?utf-8?B?c280VEdOTmNMbWdiUU1lUXg4ZC9LWmxibVA3dEpPblR5dnI4R0o3eFFWSDNm?=
 =?utf-8?B?bmNuRWRxd0ZYYkNrUWM5OVA2VEFZSDVqamYxditZT3IxNm1Td01halZSQTZQ?=
 =?utf-8?B?YW1ncXF0OXRMWVR3bitYTzJKcmcvRHFEZW5kT1VHbmN4VVNoYWJLVmpxSFY4?=
 =?utf-8?B?ZHVrbG9ReFBjYUhBZlp0cmhrMkhrcnNubkRVeWpTTStYOGlrVDJzSlpUZE1x?=
 =?utf-8?B?VmtoWmxZVWp0TUs2K2JFaVpjY3JUcGtaNHk4b3J4MDQrWFR5Qm5ZOHFTVWlL?=
 =?utf-8?B?YXFMeEFvanllODAvLy9Vd2VFb2JGc3ZtdC8wRkwzL29VWGlPd1BLOTkxODQv?=
 =?utf-8?B?Z2tBbStLM3gwVVV6ZWJTdHZYdElDWnd4ZXdENWloWXVhRTVKQkJkVkhyWlRs?=
 =?utf-8?B?TncwMVJNU3doME5SNWg0RGRuZ0svUkhtRGsvbXZ6dWdQTHV2OStqOHkvczkx?=
 =?utf-8?B?QmZPYnFZZ01SbHp2amMzbS9GQUFZTHFsZ2tIMFErTTZ1OWdadnNBZDlHelZi?=
 =?utf-8?B?cGgrc1g3K0JLeTVoTnYveU15MUhERVRkRFJaeExDejREaDhUSW5pVDNiZ1lp?=
 =?utf-8?B?VFREcHoycGlPU0ZWMXZGVnhROEMzSlJMelhOem1YRGd3ejdyS2dYVHVmOEk4?=
 =?utf-8?B?Tmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4CKueKa+EtxJq8qSPIUKCq0YROhKZgl5KKX5/opRY3rKRSvZWUh47EMYhFWUkgs/PW0SzpgWfJ8YnFgmW5hcCdm0ll4i6RaOniGRlj6Wa/cZt9xG0d4a3DgKIAJE8E8zt59kPtvIP6PhnNf+2WvQgvmx4P7IOXLet3DIqOmon94SFLT6sYkKLhiMpKpOT12bMZIFr1UKS1F6jibk3v20UEmfABX95IOtQNqVlRrviJ+Qx6DhxFsX3srmwgPlbw0Z8ebPRayOJY7cqu7DLC5H7C6VHVio48yQ7sbgQF/v1h1/ncGgeDlp+4VL3CaSABIYXMJVoWh9sCpoCw5n8lM5b4cO6cEx4omyUzCdJApW1vIlD1rCTwKAGYING0deaBrxJvrjOUx++wWtXfdjlRTBdeay8EiSLDhMtwdY4RjN5b1sHDJ42Fe3lX4lrmoE7YMYqnTscbCbe7PzDTmj8x7HMCDzRInchfUZsRcloyuOYM7LdW4ej0irh/DBAzkzbdJYr0bAcPGHYXrE8zGqqph00QX0oPguY+Q27N4C2z6PsV8GTo9UUnTPH3FdY58fI+KiUCd/C+okD4Awq+CJ0aeg4FjEGrzz0SD/S9OBri/y+Jg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e74a13c1-d2be-49e2-131f-08dcf8e07d1a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 12:43:43.7236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yHtdTTIwba0p6hu7XnWdgqlhlRlnnsUZI5s5XyfWj8YDi2vGflNYiElbuNNscBrT271RHGZPHg9VI5jaSuRSANcWJHN7y+ZiPBchOKPTQ+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6808
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-30_10,2024-10-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410300100
X-Proofpoint-ORIG-GUID: cZAVs757G8ZzEGkkwH4kFX4S0DOn0SUW
X-Proofpoint-GUID: cZAVs757G8ZzEGkkwH4kFX4S0DOn0SUW

On 10/29/2024 8:11 PM, Jason Gunthorpe wrote:
> On Fri, Oct 25, 2024 at 06:11:50AM -0700, Steve Sistare wrote:
>> Provide the IOMMU_IOAS_MAP_FILE ioctl, which allows a user to register
>> memory by passing a memfd plus offset and length.  Implement it using
>> the memfd_map_folios KAPI, and the proposed folio_add_pins KAPI.
>> See the individual patches for details.
>>
>> Steve Sistare (9):
>>    mm/gup: folio_add_pins
>>    iommufd: rename uptr in iopt_alloc_iova
>>    iommufd: generalize iopt_pages address
>>    iommufd: pfn reader local variables
>>    iommufd: folio subroutines
>>    iommufd: pfn reader for file mappings
>>    iommufd: IOMMU_IOAS_MAP_FILE
>>    iommufd: file mappings for mdev
>>    iommufd: map file selftest
> 
> Applied to iommufd for-next
> 
> Is v3 still the latest for "iommufd live update"?

Yes.

It's selftest patch no longer applies cleanly, but I'll fix that in V4
after you review the other patches.  Thanks!

- Steve
