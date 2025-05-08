Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF2C285411;
	Thu,  8 May 2025 17:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746723874; cv=fail; b=Td8T0aS4C4Fe/gJ4kziaPhr6cDog8HnU9aRJAWzK6ARfO3MBEd0N+RMtYOzAWF3+7wCffF8RNNAot9GS6IJQa4xO4coSoBkEXA1vFO5emnVPuyUGv6/3GqhvFsB9JUPEizb42sSfMObEpkwul0Ap4+1nUmJW9mUI/sYOLdgvOYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746723874; c=relaxed/simple;
	bh=kGhZneYVNVc4Dt6p5HtwsnTxzCStdZYzm1bbLWOHA4g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bu9yupLS6Zs5dra1JIlohyRu8EFZuYjct6fuL0SFjq6zjOBgaQxhlrWRjanefnC5u1UcAHeQWytIS/4Ac8FcaHz3bcUCZbmk+f0DRHhQvP330X65gpiIgzxmUCxoYuBcq6GoPmSynfRiKaPyRvPf6z5Lz0r18Zc3ZL9FgQi6djg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J+bvBPbn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tl6jbX8S; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J+bvBPbn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tl6jbX8S"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548GME69032714;
	Thu, 8 May 2025 17:03:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=MQo+b2k2wVUlTGaBSU3A+s7+T2Cy93+BFThuv6vnZGs=; b=
	J+bvBPbnfg7jIt70rZ4gdp8sUUuLdCbWxMBbFBF2hvnKcRd/GmTtOia/83gKuTR6
	JqkwyPVwBkqffz7gJaCRQZwXfJ5h2VBHygwFajY8Ej3t6JEas9UMssRAHSK0gY/u
	wp4rwjbWf7I/TjadLMLumH0cxgu6GCLBa0+Ydl9vlkvOP4PY81C6QYHj0vm8LepF
	QOTtPzHHvA239ahNTLPGek8kMCgMGGZfVgG6OYKvSuLdHYp+7GhchzgUeOKf3eWR
	aR8M9f+t0EZukBLTlAXFNSbITDyl7fepyUA74vt7ok/RJSrHfa7bLzMZN77y0Ygh
	Y7fy8GhLM5GDai/KJ9HQ2A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46h02rg37d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 May 2025 17:03:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 548FVTEb025177;
	Thu, 8 May 2025 17:03:57 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kj6j4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 May 2025 17:03:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+gPhakxpSE8qs/zk9rL4956r/FeWsA/IoEyVy0akEUOfAUWG0Sku3rW8kjvLBY9r1t82ozsm+cpQgocXBLkPurT3HMQkilsyIS1VuPnlZci9LLQ1Oh0H6GQe5Yfn0Csf9ISSRK7QDAfq6d3gGs5wq6oAaJ/fDF88kaH5lOL+9a4kozwwPBklbhEz1dYuONsjwj/JoUj1OQJLJT43gvAsLv7VfXSGt9mynSUk10VXdQ8tLvpfcVuBXE5S3TBJmbR/GSrQans8+uJdWC1XDUOtRwvidp18UIymVWKZUjvt+zsHvb3CLMLj3uAHLC+mrY+FD28M/vuGBCZOW46RUl7wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQo+b2k2wVUlTGaBSU3A+s7+T2Cy93+BFThuv6vnZGs=;
 b=DOsQZRNMF7z2x2eGXOo/3hsJy0YXy6VpzDOVaDq88OrkTYCSaa9rhwKgwHobgrdx2hvkPmXF1kT2AGuLp0bfrVsIvI02fSYDl+237xqZmq8BvCVuqOrLZWMRWOyHsKja7MuxdSnY6M+E/Z0na+Mf9pcb1mihuaEd3S3xsoHuV5oNLnQ8Z03oYM7i7caQNM8xIRx+wM0oTBAK408+3Qwy58DPPXSjLzGiIpbafIXpIUrq/WCq7uEhR1aQ4b0yaVncflrAiq/h7Bb4PI4H6v9sUW9ef8hw+KoJKbCTcDQnip7dmLl8fq0GvHlhDHehaT+j5wpS7qPm3Y8pzwMmopKexA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQo+b2k2wVUlTGaBSU3A+s7+T2Cy93+BFThuv6vnZGs=;
 b=tl6jbX8SwXyBKX49MDgC7jyNrDxRlzAoV17aEKXQ3dWl+ql4qphJv7GazAs5B+Lg+PH+VPTInG2lnPFPz81Tqv+mtxgfOxchQXgHy3eOXZDoPZIaMmxFkJxZTrLp+xiudW5UT7g5vyJZIMJ3e8Wfj5/UA1lgj/Z2r7wo6Houss0=
Received: from PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 (2603:10b6:518:1::7d4) by SJ2PR10MB7037.namprd10.prod.outlook.com
 (2603:10b6:a03:4c5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Thu, 8 May
 2025 17:03:50 +0000
Received: from PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 ([fe80::dfc3:b0d8:d4e:5c3]) by PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 ([fe80::dfc3:b0d8:d4e:5c3%2]) with mapi id 15.20.8699.026; Thu, 8 May 2025
 17:03:50 +0000
Message-ID: <deb1603a-96df-46d8-9cb5-86121f334a88@oracle.com>
Date: Thu, 8 May 2025 18:03:44 +0100
Subject: Re: [PATCH 1/2] iommu/amd: Add HATDis feature support
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, linux-kernel@vger.kernel.org,
        Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        David Woodhouse <dwmw2@infradead.org>
References: <cover.1745389415.git.Ankit.Soni@amd.com>
 <6282a5c349812a311a67a8522dc5e4aabfe3ec3a.1745389415.git.Ankit.Soni@amd.com>
 <596ed125-c995-4e2b-824c-b7929c852754@oracle.com>
 <g3xrnjfs6zekogfohud2s7kdvphx43e6mdh3vfpllynrwokxwf@vvetz2j2nrai>
 <4f04d596-685e-4e48-9038-8aee6c927ebc@oracle.com>
 <lpbeiyyzoxuankxzgcms2iwkoydvj2vcpv5jftiy26nkslliwr@juykyxhdwwzv>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <lpbeiyyzoxuankxzgcms2iwkoydvj2vcpv5jftiy26nkslliwr@juykyxhdwwzv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0235.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::31) To PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 (2603:10b6:518:1::7d4)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPFE6F9E2E1D:EE_|SJ2PR10MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a1daf44-c0af-4fb6-5689-08dd8e524d93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akYzV2VhaHU0Q1pTZFN1MFFscHRFZ1RkNUp4K1QwSjZ6NFYwT21iQjBZMng3?=
 =?utf-8?B?cHF0bkl4QnYvOTNyTWFJcUVLaDFPTm9FV3VDQXdTNkJTd2hjc1FLZXZSRjY0?=
 =?utf-8?B?N3A1VjZOTDNUOG5nbVVGLzE2VXRzTGI4UE12THNSOFd6emVKNTZlQkN6a2gx?=
 =?utf-8?B?UjQ5Q2FxdG13cEs3REo5Q1ZUaXIxSHZuMFo0Ym0yNEs0MTVwdlY1KzhtODJ3?=
 =?utf-8?B?d09VNXRQN2gyaFhZYTFoQk1YbGZRRDdQM0llSXJvS1VhWm1JbHpORDUySitV?=
 =?utf-8?B?Uk45c3crd21QcTlzeHhxS3VzSnQ5ODY2V0NQWEVXdnpXY25HcWZMd3doRkZV?=
 =?utf-8?B?Ri8xVXlFbkd4a1FvUlJoeGNLREhZNDhJVm9oZkVha3hIcy8zejMrV2xVY1Fa?=
 =?utf-8?B?V2M1eXBIV2RHNUl0Qkpod3dmYWRxZ2ZqcFdPQ3ZBcWsxTHF6c1l6RUc4UFRL?=
 =?utf-8?B?aEdCTVN2Y01JOEVPa01zc1VUMHUxQk9acmJ3QlpPMDhCVVpVNE4xZUNMakRj?=
 =?utf-8?B?ejc0Vk82MFZBaytPRDN4bmVOSEtZREUrdFdvWjFlTm4zODM1c0llSk9MaEdH?=
 =?utf-8?B?MEUwaktrbTducHYyQTNFQVhaUVdEUlpMeXdBUXdaVUVUOGJaNWFkWlA4NTlM?=
 =?utf-8?B?cXpZS0xZdmo2dTZRclkydXBNWTlwVnlUd1g0QU5NUGwrQ2ZPWVZIaHRRbmM4?=
 =?utf-8?B?VXljNVBtaHlXYTRHL2kxZXk5VzZpa2oxR0xiK2l3ZklCeExwVit1TTRYSXpJ?=
 =?utf-8?B?YWg3NkV1MU10VVA3YVUwMS8yQnREcmdSRjZGWVlvLzJZN01zQWVMSmErazRQ?=
 =?utf-8?B?bHFFNHpkdjNCLy9UMWZ3cENmRWYxWXp6NUJBeGRhZ2xiSjFWU3VmMnFLMmwz?=
 =?utf-8?B?RlF2UFVHUFVjMndtU2c5d0lEYW53Sm40Vzh3RE10dDV0MjFHUStKbG1PUGtr?=
 =?utf-8?B?TUh6NEFrVjFSY3hsMExhRHJVUWhWcko0NXJLdWpZSis0Rm0zN3lZajdUYzFS?=
 =?utf-8?B?ZFpvcGZaSkJmQlhrUkxsaFZiZmFqQk5XUHFLSHkwRWNDb1lINUZBckRnRWtm?=
 =?utf-8?B?ejFrVGdCaVhWNGl5RytkSnBqRDVzdys5dnFROEdvcWxQYTFnMlJVQVpwSGkr?=
 =?utf-8?B?emhmUURRbDVRZzJxb1RQNDdubkgzSk5vY3AydUxhU3N0aklyazlVTVBtRlFW?=
 =?utf-8?B?WTRrOE9Vd3BLZ1FQM2tzSDI1allkdmo5Y0NVMTlCaE16R0cxSWErRXdhWXEw?=
 =?utf-8?B?ZFZsVnFoREZmdHhtVEZQbHlSZHBrSlcwbGFrSGdnb1lkK1FRTTBEOStOQkhX?=
 =?utf-8?B?ZWxNa3Q1eFY1VnE3TWZkUTNmcDVocHRwSERCZi85T3Nmc0lWUEM5STRoT1Bk?=
 =?utf-8?B?VWZHRkVRaG1Sb0JMMmJSN0hZOU9nZnFaNzRhOVZ3K2NMeWdIUXpSWmNXaVNh?=
 =?utf-8?B?Ny9BS1RubW9JU29Bd3NJMU9xci9obVliSk9mK2lWZTB5WEdwRzFyMWhzaXF1?=
 =?utf-8?B?RzFtMHJ3dk5hQ3cwUnFGZ0tvM3hNZUtZSVpoZU9Lbmtyb0k1ZFdwbWZabldj?=
 =?utf-8?B?eVRXK2o0c3Y0UTdDcEFUYmJ0SEJaK2R1U2Era3lhU3NnZDMxT2FuaDV6MkZ5?=
 =?utf-8?B?NDRkVGVFVzd6SE9BdS9ld1ZqMktaV0JMSHJrUmtVZWdxWWFwZ3BNM0lDTzFr?=
 =?utf-8?B?Y3NKSmJIR21ybEg0d2FsOXlpR010dythV2lybW9nbFdrdksyWUZ4aklyYWVl?=
 =?utf-8?B?QW5YcFVGNHgrVWk3SGI1bVM5SVVhNUlrRURHS2RmOGZXeGczMFQ1cmpsR21j?=
 =?utf-8?B?YW5iSnR0Y1UzMmJ6cnkwVTNyU1R3alQxNFU0end1K2cxdTV3NG1VaXR1MHEv?=
 =?utf-8?B?aUlsRFczdFAwbFJJU1BxcDA5Z1M5dmRRNmhwTTdOakxDdVkra0h5ak15YTBB?=
 =?utf-8?Q?SZdcNiS8A58=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPFE6F9E2E1D.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0NUU1lJaWllTEtiVTFkdFlNSGpLQWlpMnV6THh4WVhiTndweDJvWGdJLzlO?=
 =?utf-8?B?UDk0bE1EY3pkR3IvSGMyN01EWDVwcVp5NlNmRTJIZklEYzY2RGRpd0RBQVhM?=
 =?utf-8?B?Z2lqQ3ozc0ZQSWRDYlpOSmFiZVJmclZKYWtyK1dhRmFoam5NLzBhNEw4TFZG?=
 =?utf-8?B?cFB3ZGpCR0cvQjFUcEpZL0o5ZDkyMVBtV1lISFlFRVlrOXVrZmdpTVh5SXN4?=
 =?utf-8?B?QkRibGhBczVxQkVRMFJ3czI2YTRqYWFMVWZpT1ZqMFBodEt3VkljZWVvOG5E?=
 =?utf-8?B?UGdZRG1JVjQ0MkdrcjF6WERsazJTbWJQNmRZZzVoS1VOK1E3N1NhZjlsU3Ux?=
 =?utf-8?B?dStmOEpmZ09lKzFRTWphdnAxK2NNZlFNdzFoZENRc0N6dTREVlVWUUErRk5M?=
 =?utf-8?B?dnhVRklNNjg5ZVNCNjdNMC9RcG1jMDh1QTB2d2M2V3FmWUkwdVA1Nlg3Z3BG?=
 =?utf-8?B?aVJxYVB0RVR6dTJNM2g1VTlWTW5ncmU2OG9mb0NZNzlJSEFlRU9vODdhSzhM?=
 =?utf-8?B?QUJ5YkNKbGp1R2xYK2NONDkzeFIxWXZYU0hIczVVUktScnVtSE1CRysrT011?=
 =?utf-8?B?WkRvVjVVdTkrRWFNdjVBRFpXOWxzdWltN1JxdHMyaXk4TjFTcEVIOFk1Vzgx?=
 =?utf-8?B?YTRKMTd0bUJ5azdtQ3pzbklzV1FvQlQxZmdIQzZDTmhuVHlua0lJZXZjOG9F?=
 =?utf-8?B?a28wVG1zZkh2VDQwNGJDS1FsRHFRb1IrZkprRktKdjR3SzVRVVBiMXhPTU1i?=
 =?utf-8?B?akZpdkNxSHhyNnlmbTFwakJNZUNiQVN0YTZJS0RxQTBsaW5nYjhjOW5qU0lE?=
 =?utf-8?B?RW5yYkRlNEhMNXVwWENwTlcrdGFXRm4vSFlUUDdHZm1BbzljdW8rMkxua2hM?=
 =?utf-8?B?eFJzTng4d1dhUktTVHQ3aDZNaWRqUE9Wa1ZDNW1MWXFub29FRzlrQ3FHS2FD?=
 =?utf-8?B?Mkpua0pidG1IOTczbDhMWW5rdXk5Nm05N2JNaWhtSjgzRjhTejBYZEtHODlm?=
 =?utf-8?B?Z0hEd0VIZnJyRVk0bkl0bVdhc2FRVHJQVTRxeFN3dlNxOFBqQnJIemRmd3JL?=
 =?utf-8?B?TzY1VS9zS1p6cmMvMklFQlBMRGN1Q2pCMEtCMFM1Q0VlYlRYbWwxRmg5NVRk?=
 =?utf-8?B?VXdDc3hiZ2NGMVdGbCtqWldScHBRZHRsc3Q0U3VNZnZEVUs1SitLVkRjczQ5?=
 =?utf-8?B?Y2JEY05rOVZtUElNNEpsVVg1T042NWtKZ0hSVGo2VTByNm82ZTZ2Tm5TODZJ?=
 =?utf-8?B?N1MvQmZCVktWWjdqb0tGTUxYb3F2MEdwQkpYd0lra1NGSHRLbkZlU2IrUWNq?=
 =?utf-8?B?cUJMMUgvUDdSMk1JdUlVT0htZ2VjcVZVQktmN0xYSDd0NTJMSmdraytYSm9C?=
 =?utf-8?B?R2VVVDI2c1J2U0Zwc2M4WUs3UVBKUFk3c1JkT3FrNVZDV2trNW43YUVCOUV0?=
 =?utf-8?B?V2ZzV0NuKzN0QzBFLzV3UTg4eTdDYWpsN3MrWFZSdUlENEJydlJzb1NnWEla?=
 =?utf-8?B?TEx4YkNLMUVwdk02R1JKL2J3ekFlclRGRG4wdlpmRTRVd3BBeHd5OWJmTGpQ?=
 =?utf-8?B?VGVhU3VKMXc2aXorN2xSRkR0NmhZM1NtOG5yU1Ayd09heDAwd0NkZktSaXpv?=
 =?utf-8?B?VnlCMXdtTDJGM01ueUtpdUZBWWJxais1dUJqS21nMlgzQzVicXY3bUh5Nlow?=
 =?utf-8?B?bC9zSy9aZmwrUEVUQzlZS0o3YWhqc2ZJb3RrZXRrbStNN21DVlROaUI3SzJN?=
 =?utf-8?B?bUp6a1hJVVY4NUplVVJ2S29oZVNrWmh0N1AyV054RTMyejR4TU51OEFaQjdY?=
 =?utf-8?B?Z1NiaTFXdk1OeExhQ3NBRDlhMHJnVVJyOWxkUXNVd3ZLNnVXV0E4RDJpbENS?=
 =?utf-8?B?eDZ5RjVkckFyNklBSXV3eEdkN0VSdVJUNFBudWhqcUpBbzA5cmFxS3ZMKzFC?=
 =?utf-8?B?M0VldVE5TXgybGpWM1RxeUxpSExEemw5aElITGNibDJObERtcU1uS2gzSWZ0?=
 =?utf-8?B?eUtXbmRVOTlwSGU3azlIb2tJSFk4YVFXN1I0NFlTS2VqemhTTDE2WloyaVhq?=
 =?utf-8?B?M0dNcTAzZVdISldMbEFTSWVoOWxoNm5NL2RscnJwZmsrdDFDNGxYZ255aUZ0?=
 =?utf-8?B?ZjJ5eDFEL2IwQTZ2ZTh4ZGpTNWVnblhSZkdOZ0krVFZSeVBqKzdMeVNxWjNL?=
 =?utf-8?B?UUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ThQn85e4K/Eb61RUieLHqPqS6hjtPifXUphUmPee/gkUpS1tdFJ1BEec5R6mUjfkIZTTSVFz9u4UnAN9RYltQjjUtH/we/Z7hQjLQ937gtSugqK5ISK+tbnZnUBjo6rqIsdsc1lAY6TAGFSDc3hwTT6fcpqBWPrls0D3qbo4q0u8qph9ai5HB5iq5Lr5BO4n/Ftjs2EsAxJtb9JjGX5/Zs30bSw/cNipbxTut82ieWV0V4GUhGFaEtLIBILmsNlOYaplczIiAK1gKak/J9YVNSFcmnWoBOTcvPmpYusPvPTThe/MasQubxYEopwq4fB4R6zebqby/idYS9X3SG80sJC3CC2HrzjpGrb/viSg7cgRfPSj4JHTCuzg7OjefVGuuQHv5fq3K3hZUOd/us5bqNCEDwRZLpIRPYn5c/iZ0oOg7n1HulcrFgpf0P9qV2k3js612itu4s5CbGJEIAJqaLTE3q75cD+6x26lz3nq+jYGjkNeUsYcFiSzx5jjT6ZjGpR0adisicpH3pJZp/P1YUk/2v4kZE1G0L2rh0n4yttsOMru9rzxpoA8/OTN3vcU4DSy4vIlTJCpE6hZt7Ec5+b3oKtvHaF8+lPJ/B1BILE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a1daf44-c0af-4fb6-5689-08dd8e524d93
X-MS-Exchange-CrossTenant-AuthSource: PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 17:03:49.9050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xn+eBowZjC7t6aiM2FxgIL2DdC/WmYnFvM5URMdwOvmeUEoCKQQvbxjxL34LvVi73QG3x2kMFVt6EChL0Uw9J/33Kv7QdL0JMLlLlhsA2zs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7037
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_05,2025-05-08_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505080150
X-Authority-Analysis: v=2.4 cv=PIkP+eqC c=1 sm=1 tr=0 ts=681ce3ff b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=Oe9M_OX1BZfcBDN7BtUA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13185
X-Proofpoint-ORIG-GUID: rqtzzZsFmWCZbAQ2-2p7gsnABrfbd0zz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDE0OSBTYWx0ZWRfXyVSKVEK+97dR NFhTG0aUX6dAbYiP1IBK6IjHr7dNlDgXhD65isHqUkSEn/EGpdbbViQpud7CADB5w3e23Y9CKzz D1GYulvgq72WCfCqkssnFNyeINb9BdPvnnKLKCVgqswmJ5WaRfGhLwPwrhlg/NMKauzCz3EnLhT
 +aiiqLkQMCG2OrMktV53srxEeCD2a74tg23ccsslpWneJsBVrWtYgvQjjIL7EDGiW8H9fPsIWKL 87rNqu1nvZwPRA2ty9/ugeWJLfEbd7SVF/ujil/kxMnNvUCuCQVbMKdm0KGBmsDLvFEjTGmaof9 u7V6x4PsRyxQsSP0SFjjzdwpy/QY3AgpaE06qwLkxHZ88C++N0RA3tkhjqRFKQolY8pQgKZi9DI
 UXZeYMDxQ6NSZ0GqpNOZAQd9DU4GA2/qXK1EXyqHqaQFgXsg1cuUO6oB70LS/2eWCkhF6OM+
X-Proofpoint-GUID: rqtzzZsFmWCZbAQ2-2p7gsnABrfbd0zz

On 06/05/2025 06:12, Ankit Soni wrote:
> On Wed, Apr 30, 2025 at 12:41:04PM +0100, Joao Martins wrote:
>>> With intel patch you mentioned above, it seems that it is mostly handling 
>>> "second stage translation support" disable, which will eventually disable dma 
>>> translation. And in AMD case, HATDis bit indicates host(v1) translation is not
>>> available, then attempt to use guest(v2) translation, and if both page
>>> table modes are not available then disable dma tranlation.
>>
>> OK, I guess it makes sense if HATDis is v1 only.
>>
>> My other call out was that when we disable dma-translation all together (aka
>> both modes), then we shouldn't advertise the IOMMU groups (internally and to
>> userspace) by not calling iommu_device_register()/iommu_device_sysfs_add().
>>
> 
> Sorry for the late reply. I had cross-checked it; if the probe fails,
> then IOMMU groups will not be populated, and eventually, it will not
> have significance for calling iommu_device_register()/iommu_device_sysfs_add().
> 

It would nonetheless populate a ivhd entry in sysfs needlessly but with an empty
devices list (qemu diff at the tail end for how I checked it; it's only missing
the ILLEGAL_DEVICE_TABLE_ENTRY event being generated, but enough to check the
first patch with sw iommu) e.g. as far as I checked:

$ find /sys | grep ivhd
/sys/class/iommu/ivhd0
/sys/devices/pci0000:00/0000:00:05.0/iommu/ivhd0
/sys/devices/pci0000:00/0000:00:05.0/iommu/ivhd0/uevent
/sys/devices/pci0000:00/0000:00:05.0/iommu/ivhd0/amd-iommu
/sys/devices/pci0000:00/0000:00:05.0/iommu/ivhd0/amd-iommu/cap
/sys/devices/pci0000:00/0000:00:05.0/iommu/ivhd0/amd-iommu/features
/sys/devices/pci0000:00/0000:00:05.0/iommu/ivhd0/devices
/sys/devices/pci0000:00/0000:00:05.0/iommu/ivhd0/device
/sys/devices/pci0000:00/0000:00:05.0/iommu/ivhd0/subsystem

-->8--

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 59593582be23..78801672ee3d 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2326,7 +2326,11 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker,
const char *oem_id,
     /* IOMMU info */
     build_append_int_noprefix(table_data, 0, 2);
     /* IOMMU Attributes */
-    build_append_int_noprefix(table_data, 0, 4);
+    if (!s->dma_translation) {
+        build_append_int_noprefix(table_data, (1UL << 0) /* HATDis */, 4);
+    } else {
+        build_append_int_noprefix(table_data, 0, 4);
+    }
     /* EFR Register Image */
     build_append_int_noprefix(table_data,
                               amdvi_extended_feature_register(s),
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 34abb61e092e..d033d309a210 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -83,6 +83,9 @@ uint64_t amdvi_extended_feature_register(AMDVIState *s)
     if (s->xtsup) {
         feature |= AMDVI_FEATURE_XT;
     }
+    if (!s->dma_translation) {
+        feature |= AMDVI_HATS_MODE_RESERVED;
+    }

     return feature;
 }
@@ -1665,6 +1668,7 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error
**errp)
 }

 static Property amdvi_properties[] = {
+    DEFINE_PROP_BOOL("dma-translation", AMDVIState, dma_translation, true),
     DEFINE_PROP_BOOL("xtsup", AMDVIState, xtsup, false),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index e0dac4d9a96c..b5358dc30533 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -169,6 +169,7 @@
 /* AMDVI paging mode */
 #define AMDVI_GATS_MODE                 (2ULL <<  12)
 #define AMDVI_HATS_MODE                 (2ULL <<  10)
+#define AMDVI_HATS_MODE_RESERVED        (2ULL <<  11)

 /* IOTLB */
 #define AMDVI_IOTLB_MAX_SIZE 1024
@@ -371,6 +372,7 @@ struct AMDVIState {
     /* Interrupt remapping */
     bool ga_enabled;
     bool xtsup;
+    bool dma_translation;
 };

 uint64_t amdvi_extended_feature_register(AMDVIState *s);
