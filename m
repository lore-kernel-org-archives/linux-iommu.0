Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75121D0F73
	for <iommu@lists.linux.dev>; Wed,  2 Oct 2024 17:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727890021; cv=fail; b=OXJvApNugu1Fxab2+y0AQ70jgvWPw8BoNSa+jo/NVdsf6xrz/Bml7PuZRhefhlYnfcuhaTRpZ681VtgmwcRkVH0tJ9UqDo5lf8Y0Gbqi+9EStUKvSRi5OPxc2LRnixcFka1eChY/ws+/kzsG1zoIDrwQt4hlFdXfD+hqV5x7rVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727890021; c=relaxed/simple;
	bh=cMAnPxG+vFt2mWCkWqviVmXX22KZuR0KSqGiSDQ2B1w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CMtf0d2oXYnQKddlK/Esj0S/mdOkT2hKI3ZKKH3hhBi2EZ4aCloJsNlNaIY8FH7LVLhRgQqqT3+ddYM4bhN369NrilrpNf7uIOSSlfRmmQUEu6LuGu+Xd0oWYKSyOl7kzTrWsdkJqjfRa1yoqPTcMa+fFUE7OYaAPxp1uvGV3gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=neWsKRPb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DKjxNR08; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="neWsKRPb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DKjxNR08"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492GMWVR031552;
	Wed, 2 Oct 2024 17:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=nKvfJV2tZbN15y/TG2HgJliah8S9xqzGCnTAmC3apXE=; b=
	neWsKRPbKzKQD0PWtc841DPWzf4aKXEVWyXMUyxnPC0IjqxXm9QRk4oOlwGCqCvV
	w9v5nFyxcyjJ9tjAn3kiuAay8Ya80BT5C7e5gfwUww/bnoY6WQgVrKuswuU0ewWK
	ViANFzOhslnlgyFw6vZXaRh+8gj6VrKiwI7DwvsdC2xKkyegLgpp3ZnpzZkkI1B3
	XkERu2nJ+O0BZ4XHH3Qq00e3Hv2NB16AaLOnTfMsOVbuVdR23nSrrpHGNWdr3mbj
	jS/QP47oShLfOEJo1y59OFE8ribl6guXb/KSIiCpacfnH9pTvPj+hhX90XwvlOQw
	8Hcx9mhDYpdJ3Jkj/9rNCg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x9uctgs5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 17:26:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 492G7JAl028388;
	Wed, 2 Oct 2024 17:26:55 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x889ck9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 17:26:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G8OzwLvKY2fnmKmyOiGU+PpHBWAnP0pvAF3mUMBgYe2Uiqi4tGeYLOeAUml2uSZt60BhlqcYdjalvqpyS6674LKSiFgJqFbGaw7Re6pEIjoidG+Q8FrR/F9BwVGCQ1lkj1N210ACMfoicJ2vTukWvFkD+R8DRFx8WS2gMfxQdNwsfE2/vmSQaLyTlIHZFoAeEF1WKTixBIVHLNvLUNN6xGmJyb0CSFrulxVYyXofL0VJlu/O+z0StIvU/968FfA1xOZHx/2BoUSS+hB6XFaU+3aa47bMibm+5I4P6DXWV/9oHdzEI7K2oYmoHI2BhP5B+yt6KJQkKudgmV4dC18XfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKvfJV2tZbN15y/TG2HgJliah8S9xqzGCnTAmC3apXE=;
 b=om7Vv+sUxhdJ8WTH9t9F17bMksxY8/9s/XXbDUK46ymqsPecIORAxiQcGGMfmPhWHfgfW3v1i0AGFk/6ISwKRElY0U6z7eFrmJVhQ/PkKFce8S8NFvmMyvBC5fvdUvB+FCIqKOXdoregzEOXRQkuyBKdKNqzMzZmLvY3yJ/ssw5G6PGvH6m8VBTS9zwde+me2XRRDcgPvoBpOzYcCeZ6SlgVG638L1skcEXnhj49Q9DFs+pEjN3alEPRMdFCpDbznPiXIJvAkWhiDxoLvCFgP3w7WTiivEWvKySYCU397vKdVNtlNy7RBHt6r2Op8tq5L7Ecz1FwhbEwUMtnBJkakw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKvfJV2tZbN15y/TG2HgJliah8S9xqzGCnTAmC3apXE=;
 b=DKjxNR087Giy5WT30iBaSHyPJg7xfQCn2Je6aJbsosoJKQdvtodKTN+rW8fZD+zksePtSaX+/WvabkLRv9/HbTkTjAuKflK4nYhshK+/oEpzgZL4MldfyDnHPp7+LTVF7lhXd/tz3QFEeMmSEElmpsb2xLLsl0KRCkfAHKqRo4U=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA1PR10MB6712.namprd10.prod.outlook.com (2603:10b6:208:42f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 17:26:51 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 17:26:51 +0000
Message-ID: <d6f0c750-a4d9-4c2a-af15-412dfc3a04f9@oracle.com>
Date: Wed, 2 Oct 2024 13:26:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 9/9] iommufd: map file selftest
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
References: <1727190338-385692-1-git-send-email-steven.sistare@oracle.com>
 <1727190338-385692-10-git-send-email-steven.sistare@oracle.com>
 <20241001210511.GP1365916@nvidia.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241001210511.GP1365916@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:208:c0::25) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA1PR10MB6712:EE_
X-MS-Office365-Filtering-Correlation-Id: e0a88bbe-14a1-4623-0dd6-08dce307675a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHkxM1QxcjlobE4rSWFTVzM1VngrMEJBcTlQVmpFaXdjZkVTUzdoZnJsaGNs?=
 =?utf-8?B?LzdtTVlBL0dVbkpSUG1NVlBySmZ5eWkwRnVidXpQdnhMWlZId09nTVJ3YUI4?=
 =?utf-8?B?ZDFvNWNLa2ZneUVuVmI5RkFXRDlwRHl1WWN4d2ltTGlVVTBnU1hCaWV6WUc2?=
 =?utf-8?B?N1FnNnNBdHA3MG5vQWpJZEYyU2JXQ2FOdkJCdXlsTDZudG85VmYxNllLcVdZ?=
 =?utf-8?B?NGE5T3YzNUlIcXc2TVFXRnFSRDlZUHc0M0RQQk1ESktob3dYRnVVbDViZExm?=
 =?utf-8?B?NlYvUmQ2L1lDa2txd0J2dWU1K0w4ak05SW5GcWxoSlNxZXFGWldoWDRVV1BZ?=
 =?utf-8?B?bjZmNWI0RkgyK21DTGhoUkVJTUlGTUo3Uit2WlN3QmJrc0J2WmlOZzBxa1VH?=
 =?utf-8?B?YlZkc05hRDRDMkEwMDF4TjdCYVZWaWZZSU5YRVF5K3JSTjdYQTlxazFlZFdQ?=
 =?utf-8?B?cDJjRDVwMXVXQkhRNUJkUmVKaXBEcHBsQkpIZ1l6Z2lyTXBwd1hMS3ZOSGlK?=
 =?utf-8?B?Q21jNUN6czFsU0F6aWZzdmF2N0k5eGxid21kOWZCcWlqb0RSc1doNTRwUlFX?=
 =?utf-8?B?YVE2VkFGR3ZIQW9ZTmpUbFY1UVdTdUlyNCtOT2xPdWs0cGZzU3RybHpxeGdD?=
 =?utf-8?B?VEM5aXM5dExGclFYaWtmM0s2bVN2Rnk5ZW5KUUZnQlVvMzFzU2FzTlRhVmV5?=
 =?utf-8?B?L3JyNVhjR0JBK1RpUnJSa1JSenFtSndwbkZsOXRvdFhOcWFVTkNHQVBSRXJP?=
 =?utf-8?B?QnFKbVd6UFBpNStjT3AwUnZtWC9nNm96VjRyWXJBU2ZuMXFWbUlZSHpkdWFU?=
 =?utf-8?B?OFNZZ1N2Q3A2eGtnTkRHTmJHTHVaVndWdlE2NW9GMEJDbGdlalFpWWF2WHlR?=
 =?utf-8?B?NThDTWhMbS9BaU0yd3Y0Mjl3MDNrSURoN1FsbjNFcVliVmpOUkRkZGRody8z?=
 =?utf-8?B?ZU9uVFZQTzZDRHZNM2hwL05GK0dVeWt3b2ZwYjJaZlIxSjY4SDYwMkE1dlpW?=
 =?utf-8?B?T0k4ZlFsSkJ6ekNRMXQ2UVVsZjNsWjZ2Z296WDhtcE9La2J2d21jMDc1aFdD?=
 =?utf-8?B?cTRNNXMrbWFFaTkwR1h5ZENmZC9zV3M1TEViWjlEVE41V1JOTmxLdkd2Qzg1?=
 =?utf-8?B?dHhzdHZESWlHMEFWeGJva3djQitjbU1WcUtpVlp2QlB3SkhpV0E2Y2wwRVhK?=
 =?utf-8?B?KyszT1VXcTFBeHlmNGN3L0daeG9JY2Q3TnBlUW5WUUxCNG1pd05wUE5JcWND?=
 =?utf-8?B?S2dpWUtIZzRhM2daQ25xeE9EUW95aXF6cmRkQkFFaVlLVm9RVVZndmNla0dQ?=
 =?utf-8?B?UXA2TWFZOTVCYi9KNlpPeDlHNGgyYS8rSWl6aGU1TGRYalpPK3c1RHc4SG8z?=
 =?utf-8?B?TFBRWWJtdDJlYTdPbjRYU3ZpZDRsdjNCbXh0UDk1d2ZqcnVDOVNjUGh2NDN1?=
 =?utf-8?B?RU1kTlZzSEhJWXZHQmRVdDQ0MkxsRG9IWGVDWTNiMFBXU2FOUGpUOHk2Z2xa?=
 =?utf-8?B?RzRuNGhqYjFBRHdUNTJDalZSODllNEswNG1PekpOWWxncDZBQmNlUXRCWTNn?=
 =?utf-8?B?ZjFKZDluK3MrQ0JKNWVtMkJhRmx3SHI4WUw3MnFXd1lIU0lpb0xLSDdaVysy?=
 =?utf-8?B?cVNISUNvZE9EMmkzOS9CbFZYRi80OHZNRGpSNWNjQjFwb1NjKzRlYy80cUVu?=
 =?utf-8?B?TXVpYjVISXhHQit1cFJsNU42SkhmZzd0UUwwM2VhbWpCQzdUQmx1a1FnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2d0MnlIT0d3dE5TdUNETjhqQ1dIZUF4bGhUSGFwN0ZKRHE5anBtYTBEdjVJ?=
 =?utf-8?B?RGxRMnM1Y21MZFZtSEdHcWVFMGVvU0I0ZE8xQm1QRzVYRFlBSE1OcUpCUjhQ?=
 =?utf-8?B?dHEyNE9obWhSY0VqMnM2OVFBRmpuMnUxNHVKeDNTMGpPcTNnc2h6SXJhbStV?=
 =?utf-8?B?VmlaL0pCUW9TUmpvSDhyc3dXSTlVTUY3S3lXRkJwVTJQR1cvbVRSakR4VVBJ?=
 =?utf-8?B?S2VaSk0yMkZ2VzRzanFDaFY3R2hWdnJNTTJNdk83anZ2QnZrcldrdCsrRTV3?=
 =?utf-8?B?Vld5dkdNRXpuSFFRZWtkOHc2Slp2Nm43dy9YMDFEU0VyN0RqYVZmTjYyeHFk?=
 =?utf-8?B?TE93ZCt2Qy9vMkZFajIvb2RmVWVKSGdqR1VPQTFVaWgxbHBmbmdOczdPUDVC?=
 =?utf-8?B?NytBMFIxakhiaGh5enJwck1YMDNNbVc4b2pQbmI5YVpuTTF4RU50RWRpczJt?=
 =?utf-8?B?Z3I3c0J0QVp5Q3hLakg2RERUNDg2cDRkMm43U3RzQmNWVDg5eENoRTN1U09x?=
 =?utf-8?B?blBXMzZJbERKcnV2Nm0xcXNVMG9ZVzdSV0w2SGNRdWVWODlsRjhiczJPR3BG?=
 =?utf-8?B?c3Z1WGZOeXl6aEZRRFZ2bXFnTFNzWlNoOXRPQnVtRWtkeDVicTJlQWZoeGNr?=
 =?utf-8?B?Mm9kL2ZGTGIxL0MvTnBEeW9nMXVBWnIzSU5KRzZ0UHhHMmZnRmVDY3NwbmdJ?=
 =?utf-8?B?N2I5QlU2QzB6SHRPTVpYaXUwaUd4S3I4bkt4c0ZHU0JNMVlENVBkNHRNTXNs?=
 =?utf-8?B?WS9HZG1XL1p6ZEpobFpnMkRwQjREdUxQMFRGaktiK29ybGQ1YzI3eS8rekY1?=
 =?utf-8?B?aWZvRHBFN1ZoS0JST3pMUEN3dWVROFRlZXNIUkZWRXU5SmVnajh2bitMT09t?=
 =?utf-8?B?ODFRNVZJTG9HOW05Z2JmYzRPWVlCdkd1WWRlVk9weHpjbWVzc3pvMlozRWFD?=
 =?utf-8?B?TmpJNHc1bDJoWHg1WVpveGdrd2x6RlZyWmdjbUUra0NYQXVRVG03OUZBYWVK?=
 =?utf-8?B?Q2kvclBKRnFvVlptKzIwRVVhcWpDcnFNWkYxSUU0ODAyS2ROMUp1SHFqVTR4?=
 =?utf-8?B?RjZFREVRM1U0TGhDTFk3dW9aVFIvWTAySUgrNXJNaUV4UVFQVHZiZXozWldy?=
 =?utf-8?B?OGY4cDJMcWVGUVdTRTU4azBEZTJFK2pacG8xK2gvRUxISUI3ZE9uR0VKVVgx?=
 =?utf-8?B?U21HSklrYnAxbDlpb0YyUmt6S0lUSmxITlE0WVVCMTBYbExWUkNwSGo4Umhz?=
 =?utf-8?B?WStGNTJGYWVvUmdjVy8rK0ozMTczakJSYWJ5dWZ0Zzl3WmZ5eWE4WFVXa2dT?=
 =?utf-8?B?T1R5WGJ4S0I0ekVUeXUwY2pDRHZ2N05pdnhjVHZNZTlLbTJSK1JvWWNLQllx?=
 =?utf-8?B?aHFoKzA2SzlNcStNU3F3ZTFVb1ZHaVM0cjJ3dkhhSVgzNWUvbXRMY3JzeVlK?=
 =?utf-8?B?ZmR1VjIwdkwvWXdCWHFwTHI2ZlRKZVRtb0pJQ3lYdTZmbXZRWENBUTh2aGd2?=
 =?utf-8?B?UytXVHZrK3BlYXpsQXZQMnZhOURjUmZGTDRkcng1dUJJbS9DbWxlWEpOMHBS?=
 =?utf-8?B?dnZDK3Z4OEF3OW9WdnEwdWZYWjlOOS9FZHBGTmoyYnlVaGlOc29lOFV0dk1J?=
 =?utf-8?B?TEZsY0xUWmV6dXdueGd3czdKOUxjWXJCZDVEYk1xSHNtbS82cnd6ZmFLN0No?=
 =?utf-8?B?dUczYzdSZVlvOU11UGdxRDVtQnJwbCtRU0ZkMDNaNGNjdjNOZndGOXNyaHc3?=
 =?utf-8?B?TEJacXZRVWFQUElBcjNuYXV4SENwUTJPOE5lb2I4OGQyNEpPUlVzbFlzbFE4?=
 =?utf-8?B?eFJSYmIxTUNMSVpiS09nWnFIYjJCWEtOUUZ5MnMySnlzWUM3Q3VoRkVqL3o4?=
 =?utf-8?B?TkVCaUZEVTRBbERRZ21HekxvTW1WMHVJa0FkM292dU0rWlRoVlFUa3dCTjh0?=
 =?utf-8?B?M1hEcFpySzB5aVJ0Skw3dnZSTHdPL2NmVVFUZG1FcmJHVjVVa1IrVXJ2UG81?=
 =?utf-8?B?UjArN1dERmlxc01VM3cvSFk1aFpJa3MxeW9xajFPUFkvL1QwSUl1STlnZHpO?=
 =?utf-8?B?aXpNMk5KWXU1OGQwdnk2Q3lpYmRuRHozSkwwd2c4cjlGWUY5cmc3Q1JHSmRm?=
 =?utf-8?B?VUtjbUs1TGF5T1d5VnhRcTNCcjZEVXdOVjZLWU91ZlRrUlRXVkJ5QjRDZ3cv?=
 =?utf-8?B?RFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VD1r79UiJfF2b5Qd93w5G/8Ahvh2h1v+aKYZTIcIFp8C3sYRhTBnXb+jRswHwRWZqUC3U+IZcZNG6/s6ndldbplFFO9na2Xy8O3hhHITOL7mqwTFWJEI+j5TzkozIGy219IuPWDVVa2P4sF/mmX4O5nItIYpdz+8sjyh2giij/j2o6Qf/kgzdCxjHEdOmcc3z7Ipus1KhOuIJWnR7dKHcK16DS1frQ2yWCMaXlW3pvVjol73JnQd4Y+pRTmkZccz/mnliVlFBeaWt80xw3PlckCQRs1fuG++2HLsqUdmQiVxr6SQnDJRWLw9/KDVUXV1BQ9GmYarN308kVzDNrgOpisPwu2e8BAOtBebhL+qUfbMJdrf2DWF0uTLx3SD/X+4M0dppXSJSf2gCNnyahRB0YcwdIxBgTyqjoioHUCLq/4DOtI3zII4gZnGAhXEnVyc4XtKLpc50fmAEe9VxFOgZs3/vpYdJIjuuaScsz0/tLrMBa2urFwRFDgV/28hU+/xQe9ayva6soVin7rimK3XS53Hgi6VuqdIsOgvppI9cqPtM5tMbU0BtHW7znpgt9GpSWRgLD9ViAim6ajP57vzckJYuUHUl75fJ3b9rQUVdao=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a88bbe-14a1-4623-0dd6-08dce307675a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 17:26:51.8883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nEra+Uaxuyr5oh6Sd5SIjzzAqJbUpngkOcV+mCKE0Ywd7VZTAxK7e7nBSf31yhpy3z55YNCoy24LdWLwRfAPBY4rrbJspWHlB1fezVrmIAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6712
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_17,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410020125
X-Proofpoint-GUID: z1hOdXTY5JYrwC015YMi2SIMdrDvskfO
X-Proofpoint-ORIG-GUID: z1hOdXTY5JYrwC015YMi2SIMdrDvskfO

On 10/1/2024 5:05 PM, Jason Gunthorpe wrote:
> On Tue, Sep 24, 2024 at 08:05:38AM -0700, Steve Sistare wrote:
>> @@ -33,6 +37,24 @@ static unsigned long get_huge_page_size(void)
>>   	return strtoul(buf, NULL, 10);
>>   }
>>   
>> +static int memfd_create(const char *name, unsigned int flags)
>> +{
>> +	return syscall(__NR_memfd_create, name, flags);
>> +}
> 
> I think we should just use the glibc definition, or is that an issue?

Older userland distributions with older glibc do not define it, but maybe
old enough that they are never paired with newer kernels that support iommufd.
Your call.

- Steve
