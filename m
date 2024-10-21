Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F90B1EB9FD
	for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 14:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729520957; cv=fail; b=UBUNdswPAydvRntdjmHfkeSRlD53boaUonY1tzU8dRFqdOzDshJkXMkk6Q8qmHLcbop7rqUsNbJBZHXsjjApbA2ScYi7XRIHfJ0J0Q1XAT49O4bCJnNlQ+RoSaLzCOk5NZRD6AFg6ZyHr22fzolvoDUp7maPUkucQ1++3srdT7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729520957; c=relaxed/simple;
	bh=uRHKSR+IDYRhSzmeLchkMo0U04uVKDKI/EQw+JocOcg=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OFoT00cFT/IarOut2u+uonQUqsj5FYTaI/qqYkr/wRVM3nY5ABGvDfzh13sZEgf6JC2He92GlAZP/vYFw+nyh1F6WJ1yEOQe+6mIVyKMBScCsiWx82NlC5yp2AmlbHZX9dDZ0T1r70aRDWF0KT4osQah7SyiUGG5PtG5bU/Pi2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Du0fMXeS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=X4smrzCH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Du0fMXeS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="X4smrzCH"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49L96s3O005585;
	Mon, 21 Oct 2024 14:29:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=TGOogFhvR4DvHWJI4HU/HtvtnPwkQHxgF2VxyQH+Iwg=; b=
	Du0fMXeSZyQQQjzpw1lDYUy2qL27wvswlikAM0X+g+rOJLg/MKOD+ZbcWpNdGYw+
	s6/Daw+/bGE4QTFCicmLwuiIKoEUhEVB3IK6YaJoWI2MN6Em1tvDMc5Oi+40b+RN
	L9YG/6Zh4lWBn7Nlg44fhYvF24b45mtsTuKChTQ3Zx1WIxz12tQv9yZHUjKjGjwr
	8q0m7QZbxNBBFKTS2zfaUaAe4p0eINPjowrmvMEYvZBHblIZfkUDU9t+m0ochTRz
	jujU+iSouAgK1vNZeGLOTfZy+SLjQA8xEmoxl8U2GjU50YWbw3fBwci/N6PPxU/a
	nq+gJMWN1ryUWuwzIT/5VQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ckkqtj6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 14:29:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49LDin9m026219;
	Mon, 21 Oct 2024 14:29:10 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42c376d8k9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 14:29:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AtEYUCwn1JR4bdzmsHfSDT8uNt64QUqRhVJVMjdcV99C10eXrmFzMtjfrryVdITcfcu3kMXEbFY+5ic6Oin66fKKewvjIlLMXHL99L83yC8bFXFuvijEN2IBWhvTF37rbYQyg0bGtQe4JeUxnRkUrBzWPBBf0cOFFYrexSc5SfUU72rbD+p3bR7lMtplueWFpk6ZWnaeEofUzvnK7D7+i+4O9YKHnpAUEsXZ76lbfUR9aCGErPflJpZQeyBFrdhXltvAlzkHveg7FCpUSBy4QAEo02jsjIAmqueqn4gXel6ahHLaeClIqMzsIcU0+SInrWejQknWKWpek+7d10lKqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGOogFhvR4DvHWJI4HU/HtvtnPwkQHxgF2VxyQH+Iwg=;
 b=Q3YMVQJCoD8xKqTwCXGWDURpJxsRtKRbVH+1lYEvRO+iWaOYxCx7//Xg8H50cSGOg1tF6MRYnx3yiC8FSwEYmch0ntOTir3Z86OflwwSAucRa6F3h+EgaA5OgZS34HT9vXbUi+09k3yFScyOLu4ONRc3QxH72q//2dn22bfB2KiSIMzCb0R24blGcga4TQmhkRXBYvkdNpz+Xj+lsy2cmZqBR2LEaZr5SRXEszpC8jrmipnoK6liS75a+qUA6c6yB9QHF2h0jUouLGeY+MNUcQCfAzaEZdCfm3PjDplk0zW/9LD1tyFxdf8a/JxsVRuCNkvGi9HQzPp+jet/hnhYMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGOogFhvR4DvHWJI4HU/HtvtnPwkQHxgF2VxyQH+Iwg=;
 b=X4smrzCHS/xhdlN4+0KiNruh5RA+MNJckZMWx8OfSXqXj+drGTJnk7ok8Z0hAc88hcCgh4RbpfRqePBjcN1GRA9QlaZCWZHN7j9FQ5/8KX5/u50eVJOXUqOvLmwTHdw3gLv4ztvaK4tF6YZ0GHR3kRhYH8E56l6nCcJR/AU3jAo=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA1PR10MB7360.namprd10.prod.outlook.com (2603:10b6:208:3d8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 14:29:07 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 14:29:07 +0000
Message-ID: <9c0f4c03-6373-4263-b389-262f8018ad02@oracle.com>
Date: Mon, 21 Oct 2024 10:29:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 8/9] iommufd: optimize file mapping
From: Steven Sistare <steven.sistare@oracle.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
References: <20241016130001.GI3559746@nvidia.com>
 <6fdad0c2-8b6a-433e-9405-016aaee40413@oracle.com>
 <20241017192418.GD3559746@nvidia.com>
 <c4574487-346a-427e-a97d-6e1ee366ed1a@oracle.com>
 <20241018001046.GF3559746@nvidia.com>
 <279c7e80-1d72-407e-bfb8-d286760a5e11@oracle.com>
 <20241018160430.GJ3559746@nvidia.com>
 <dc59dc36-027f-42c1-971a-8218c658c5a0@oracle.com>
 <20241018175951.GK3559746@nvidia.com>
 <55027ff1-05cb-4ce9-adad-8dca586a26ac@oracle.com>
 <20241018231011.GL3559746@nvidia.com>
 <561a1712-8613-4f88-ae60-7f12a4b7c244@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <561a1712-8613-4f88-ae60-7f12a4b7c244@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::18) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA1PR10MB7360:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f6893a4-c65e-496a-ce75-08dcf1dcb87a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0VSQ291WWQ2ZXlyQjRLU0ljNjZGVmYwd0xLYnlUQXdsQnpxck80OFFnaWlr?=
 =?utf-8?B?ZDlZSGRUVWF1NnpYREY3SlE0bG83eDl2OWN3Z0dNd0hicmRLNCtUdWthMDhz?=
 =?utf-8?B?VElrL3JpMTBXZGVJbEFqc2k0dEdCTXJYc2E1Q3pGQW9wZjNpTnJsUldrV3dZ?=
 =?utf-8?B?cit5YnhkK0QwdkZTYVBkQzFCT2VtUEZXZGp3bE54L3NJdElMSC93SVdVMUJu?=
 =?utf-8?B?eEoxWHUwaE9EMXpJZFdlcUF4alhhNUFWOTFGdEZJNGlscHRwVXlBNVpYWGFY?=
 =?utf-8?B?TnNrcFZ5eUtRU1AzaDRZZU9UeHByOEFMd1hHMzNYRGhJZVpybzVvN2ZYUSts?=
 =?utf-8?B?VWtIeFZoUCtFOEFUUWxZODRncjYvcnU0NTVkejRnWVN0aU5mWHp3RUFpSisx?=
 =?utf-8?B?bmZZbkpSVmlneFNTSDdKNTFzTzlQUTVXUjNXZmJhQUhEcnphTFpzaTRNTWlN?=
 =?utf-8?B?TXZ2MnJ1RGVIOFJ3NkJsTk8wMWN1WVdZOW1JZnVZbkYrTko0anFWaUI4Tkdq?=
 =?utf-8?B?NkRYT3pHR3BzWlU4ZG5jR3RCSlhIZ0MyNFl4UXdHUy8vZENBN3dmVkR2ZEdt?=
 =?utf-8?B?Q1lJdnNyVjA3T0VjWHVNZHB4SEloRk5qMDUyeW54UnBSLzZ6QjRHRHhZZ2pK?=
 =?utf-8?B?ZHFXOEZwNVU2dFVrTFBpUldCRkJ1MkJ0cllLOU9uUHJMZ21mN1ZFV1Z5SDE3?=
 =?utf-8?B?ZE1lNWRBZWZwWThxa04rOEM0eDhLSy9ZNnFWM2N1Q1h4Tm5LNG1YSVNWaTNt?=
 =?utf-8?B?T0xxMjVuVSt2QU53eDQ3NjVIUXJDbFpJRTRhb2lXeXBIdlNmUDFtR05aUUpi?=
 =?utf-8?B?WWgwRVJ1Tlh5ZzN3Q0ZYanA3L3VjL1ZIdVRVN3YrRjB3SWw1cDVJSGxEY1k1?=
 =?utf-8?B?eUptbUV1R2l3SmFjZ1AyRDdZdkpMREcrYnFoS2V1bzd4a0x6S01oQi9SYm10?=
 =?utf-8?B?WjRJWHRHUzU4NCtkckdwVTVnb1AxU05uaGhOc09KcUM3aHdJRGZQZVRGK1Nm?=
 =?utf-8?B?ZWpUeEpYNDhtUlRUc20rNmYxZ3JDV0xHbzJJOGNTMGJyendzN2NCNXh1SU1M?=
 =?utf-8?B?U1ZPNzJjUFl3enNmbHpZMzN4b3NDQU9udXY0TzdMakhrM2lMb20yWFhRMFhF?=
 =?utf-8?B?ZmJNNkhvd01IMVJ2VnRNUXlKWEJCMjRscjRkTzA4d3ZsMDRVbW5pNTdUOFZy?=
 =?utf-8?B?dnBtME1QZElCb3c1c1k3SUV4Q2FRMFhnTnlqMWJsOUluM0RiNWlPNEJocFZR?=
 =?utf-8?B?aHBUQi9ZbHJqSjdxZWs1eTYxbm12STdUamhkakdLdmNicktRRWl6U0h6MWt3?=
 =?utf-8?B?QUM3b1g3d0hOS1Iwbzc5aWxTR0tWU1ZBV2NmRjJJdE01ZlFiSUFsVCtudjMw?=
 =?utf-8?B?b0RkUDZVamorcGxSVkhwNEp0eEFhN3VnQWdqaFJBaFdSdURHMzduNk9RN01C?=
 =?utf-8?B?Sm53elAvTDYwdVgrTGFPTE1FeEZoUjJzMjl3Q3JHbnBWTlFNZzZvYWxnQ2kx?=
 =?utf-8?B?blU0cHlFeU5CME5JTW5lb1VrdHZkd3FSVktLbmdjNDZFZjlzbWhXYW5TYlVa?=
 =?utf-8?B?QXp4bDFFVFU5R2RieXZMcDNWN3ZJVnNZTlRaRm4rRGpxZC9RSnJpU0g0a0Nh?=
 =?utf-8?B?YUQ3cHJjc0ZWU09oSFJremJGOXRnU3NRYXFYaXlNdysvVldRdDJRZGNSVmVG?=
 =?utf-8?B?UExvUkg1YnVoZzBoVmpwZkFycFRyRzUwRDkwZmVNWE9UVFJsS24yUzNXVWlI?=
 =?utf-8?Q?CPjq3eMl3GwiLq8xyjCRc8V98mn1r88fBym5tFz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkMrbFVqZGRoWGxTRDVKMTNZQkVPSjM1aHdDVnU1U3hxcFhmM1B1SGxFUXMv?=
 =?utf-8?B?U0d5V3djeWR0WlBPY05ocWtoR2UrbUM2ZGF0RzlNZ2ZWV2lCcWVBNVF0eDlt?=
 =?utf-8?B?MndGN0paaExWRUY4ZkhxNE50ZUdiZ2FTY3d4YkVDcnUxUTJVZUJrVVJaaGtt?=
 =?utf-8?B?UHdmdGVmSlFkS2w0Z2Vtb3AzRWxwWDhWTjMvNDJRQjliM1kzV0xsQW1JOU5Q?=
 =?utf-8?B?K3I1SGVNc1ZZcWVtK1FLVjBtSFBoTkJ5UkxWeFFxZzdEeW5aR2RKWGIzS1RK?=
 =?utf-8?B?eDRqdTFqTTljN0NwVzNsMXRZaGpxT0d1OXVSNkxLZ3ovbWpHME5PdyttdlVh?=
 =?utf-8?B?L0FVZVVDOTk0bjU2Q1FuSFY5ek5jb3dPWkpuSFRCSWI5amFDbE9BQVU4TzF2?=
 =?utf-8?B?Rk4vVVJZcnFrUFVTWm1OelZPYWxLNFRYYUNuNml3VDdxWk9ST2s5Szg3TW1E?=
 =?utf-8?B?K2JOOUZsYWdvaUhXRjRKeFBLVnQ2ZklNQ240aE5BeXpaZENNYUcraGZJNTFG?=
 =?utf-8?B?bmdTM3U4Y2JVcXFNNkpvdzB0aytGOG9maFlDWFh4dTA0cGIyMkpMZ1plWFdF?=
 =?utf-8?B?bW9aVVlBYitzTVZuanNvU0xiamJwWGh0MTZLKzNFZWJ3Tkx3MGRsV3BZTTEr?=
 =?utf-8?B?dmNSamMyU3A2YVdrREdIZmltVVgvbiswWGo1ZUdiTEtzdGtqZkQyaFpKWmpM?=
 =?utf-8?B?Z1NFSnFTSWdmeEZoL2RKdWNFaGZhQ2FXSGEwVnc1M2s2MHhWVlNNT00yQ0N4?=
 =?utf-8?B?b1FyVEFjL0Jrbmo3MEJWZ1pFcVdxTjJlclh5b043ZDNNR3pxQUdSM2FreHZH?=
 =?utf-8?B?TXU4Q3pwVUZkV0NHN2tkaENoNTcrTko0QUIrd3VRUS9XczUwTkFKV3pUSFNs?=
 =?utf-8?B?RWdjVDVjang4RGJITzNMQ3JnU2Q3d1VaemNOS0dBV1RSWkU4TTU4bHBTYjdo?=
 =?utf-8?B?bUZ2cUcxK3N6SFRtbXJva3I0SFcxOGpOZjMxNHIvN2QzaHJYWVFTSms2eXNG?=
 =?utf-8?B?SmNwanVmeU5PYUtTQmZWUkZkc0lzQTc4cFFnbERYbWg5SzQ0Ti9lRmxSZG5m?=
 =?utf-8?B?S0ZZYVU2WlhHN1J4cVhwdGpGSFVVKzVWckY4YldyZFZQS2JHM2drYWRHYkRu?=
 =?utf-8?B?SDV0Zmh1TW1USDFLWCs0SnRDU3JXRVRTQXdtclp5MWxYZ3NyM1p2QlVnNUk0?=
 =?utf-8?B?aXFRbVpwY0JXc3NPTllKM1I4MUgrNWc3Ry9MaGdwVWl2UHFVZ1FYcDlTL0dH?=
 =?utf-8?B?TzA0NktpcE13VUUzQjMrVlVOWGRQaVdsYndQQTFuSFBKcmpabmR5QjlramEy?=
 =?utf-8?B?ZVpzSGdxWjRLVmhyZHltS3E4NXVrb3oxdnA4Ty9EL2cyaHFLZ0xHWHZkc2RG?=
 =?utf-8?B?NkRDcnAwZ0wxam1jK3BGUWJxL0JmUWhvVW5qSWFNQ3ZvMDJMT2t3blNDdlBE?=
 =?utf-8?B?VndXakdiUTRMTzBBc242Qk16Z0NGSjV0bmZheUNibko2R0ozZ3AyeTBCU3RR?=
 =?utf-8?B?eFVXcU1xZDQxMG95eWxmNmJxVnplOHFYR0ZUaS9YR2lkS1ZlOHN1V3NJVTkv?=
 =?utf-8?B?VGkyKzZ4Ry9hTXNQSWUrRVIwbm5ISEVQUlVSTkJiYmtHeWhhNFRUWU52RFNP?=
 =?utf-8?B?Q0Z1Mms1UVQ0MnFBZzJsZWh4YXl0bG9DSk16RkdzTitBYkdZMXpaYmUvYlNs?=
 =?utf-8?B?NHBRa0NvQ25ZZmRPeG5DZFVjcGdnaklHNU5aUzdCUCtETmxrVXhIekhpUjlx?=
 =?utf-8?B?K0lDUGdZd0xxTHJuSkdKeERiNTBaZ0hTeW8xU09RenhjODVzSDFCcXlQMnBo?=
 =?utf-8?B?QVRwSHVhVzA3Nmg2TlFOTDY2WDJzazlXSDRQMU93dXZIWThQdktPRGJuOWlI?=
 =?utf-8?B?WTRJZ1V4SnB4R0wvWTIxZStzUEt2M21ycG9TMUFrcVY0OVNJSG9Ba0JFK0Rw?=
 =?utf-8?B?OVM0UlY1ZXNGMkdqR096VjlEazgvamgvS0dWdjVFME9ibG1LUGx5SVRTOEwx?=
 =?utf-8?B?ZGdlZE9Wd1JaRVMxc3dDZVpnM3I2MitkblpReWcrYjZBZDdyNmYraEJIdFMx?=
 =?utf-8?B?RWZOQTNPQVllUFN4d0lEOTBtTWJaV2JYdWpKeHN4WkxaMVR6UGdNbEpJVUkw?=
 =?utf-8?B?MTAyV0RNcGpiblQvb0Y5TzV4SUVScUx4WnowSmNnZ29KaEptWWphWHlCNjdu?=
 =?utf-8?B?NlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aFMCZYEKwYItixkyZgfZeogZBFubELsubFozPUKWcFJKltyjqNR/2Pf5uwH26knEtxsX0pOI9Iw+qJb30NhpHxP637dKtZnh0TbB9u8WDEL0RWyqjJ5A6O7jfEsK6R/hk5wYS6S5X/b/SHmX6kelg+pJyPpSjJiYFX34X3LYBzyXurPEQZYmYNnZt6OynAlpXw9hX9pIBTe/k0DpGcC1M5yZi+2NiBoPmD/QW8FlJZigLIUEFACUgnmJo6Zklv6doCG5s+seT9uNhSS9/SWP/pmm+VkSgWdknp0k3FcQfNxKlXaqZoLSslo88BrKR7WODhOQq42KDQTap4+zMvVW0EV9bSDLV4hTsOtvr1ggaJpFL6fQDaKGNr7n6XnsUDyEkpr479lbeqTka9TVjvxbucXu8+Lhqt9JZVDdhFG2OJXsps6lStRqfrLPD/ebxlUzICWXxM4VvNnMVgdyxNAwanzE3nYLxsg+WgFiTueCl727puupDmoMjAqWvTmjjbcrG5hJoJO23AX13uVrkH6zBPm0hZq2guY5iq1fPkuhce4pKCCj0fa36rnz7a/HMfDJO/a7/zfBpQfo3Q8AP0V9o5cy9b8OWanylENgUg4VmQg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6893a4-c65e-496a-ce75-08dcf1dcb87a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 14:29:07.2137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K9gAAgqwFY8vva9hVfWac5jdBi2GaPr2rSiOA5+TSyjnKMTSuy23sXWdGmvMfA9bURXbAg28XIUli6PBJg26WXmA1vV+M5wkpmURQHYw6U8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7360
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-21_11,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410210103
X-Proofpoint-GUID: C9-iKq9bFL6GMhOcMjgRwsATMQ47EI5C
X-Proofpoint-ORIG-GUID: C9-iKq9bFL6GMhOcMjgRwsATMQ47EI5C

On 10/21/2024 10:06 AM, Steven Sistare wrote:
> On 10/18/2024 7:10 PM, Jason Gunthorpe wrote:
>> On Fri, Oct 18, 2024 at 02:10:26PM -0400, Steven Sistare wrote:
>>
>>>>>> But why is that such a problem? The ufolios_offset already handles a
>>>>>> partial folio.
>>>>>>
>>>>>> If the batch fills you leave ufolios_next alone and adjust
>>>>>> ufolios_offset. The next iteration does exactly the same as the first
>>>>>> iteration and takes the partial folio.
>>>>>>
>>>>>> The refcount has to be handled carefully as the the portion that has
>>>>>> been put in the batch needs to be refcounted at 4k and the remainder
>>>>>> remain a single ref, but that just means adjusting the refcount after
>>>>>> putting it in the batch.
>>>>>>
>>>>>> It seems like it just works naturally and avoids the double loop
>>>>>
>>>>> Yes, I can squash the nested loop in batch_from_folios_huge.  (I was off
>>>>> point because I thought you were suggesting something else).
>>>>>
>>>>> Do you want me to delete ufolios_huge and its special cases?
>>>>
>>>> I think yes, if you can get to one loop then it would be a degradation
>>>> to sweep the folio list an extra time just to figure out ufolios_huge.
>>>
>>> So now I'm confused again and don't know which "double loops" you want me
>>> to eliminate. There is still a loop in pin_memfd_pages.  It calls folio_add_pins,
>>> which I could push to batch_from_folios_huge, but it also counts and returns
>>> pages.
>>
>> This is the one I was looking at, yes..
>>
>>> It must do the count because the caller calls
>>> iopt_pages_add_npinned().
>>
>> Ah, this is what I was trying to get to, if there was some reason why
>> this loop and this pages calculation was needed..
>>
>> So, to fix that up you'd need to adjust the memfd_pin_folios() to also
>> return back the end va of what it returned - it calls it start_idx
>> internally. Then that can directly give the npages for add_npinned
>> with simple math and the loop in pin_memfd_pages can go away.
>>
>> Then you have a single loop in the batch_from_folios(), which
>> is what I am thinking about.
>>
>> What do you think?
> 
> Yes, this would eliminate the extra loop in pin_memfd_pages for the !upages
> case.  However, we still need all of that code when upages must be filled,
> so pin_memfd_pages does not get any simpler.
> 
> But, we cannot change the signature of the exported function memfd_pin_folios.
> It would have been nice if the end parameter was an inout.

Despite this I can make one further simplification of the V4 code.  In pin_memfd_pages,
if !upages, I can skip folio_add_pins and instead call it from batch_from_folios.  This
guarantees that in pfn_reader_release_pins, each folio to be released has only 1 pin,
so I can call the existing unpin_folios and delete folios_unpin_partial.

- Steve

