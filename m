Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C7913E40F
	for <iommu@lists.linux.dev>; Wed, 21 Aug 2024 17:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724262858; cv=fail; b=U7l9ZOGhoKfpIHBCnge8b3IXkDf3ub/jiN7zhuCgC0hh1xvCTkjrCv5xLG4P5nZhoe8VGTehxdBMP82Afok//Cf2c6SKH2hXx8ph69RyrB7Zn5vvrJIyrP15eD/tx+sC5LoEgN7UotDkj8wJU4o+ZWYD/5eGm84yXLE5mtubySw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724262858; c=relaxed/simple;
	bh=1YfDcJySPdac8TUqqWYIN6czr7AVvOYJ2HTMRk6ujfM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SfK23IQKEUhhCTopS7rm2XsPX6/bbvrbjx+9f+bd+DpboBUfGy4MVH1UAqNNFzAuOF22YcpjQfvQhqrejzv0KA0Mitc8y0If0+5AfgCScwkRNRmYdr3XP+gDrfEmY3wRXiDaNkuOpUszOiH/OLw5Ru3dACrta0tI+Jbzf0Yb9ME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ImszSzt9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iI49oe6/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ImszSzt9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iI49oe6/"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47LDIYqr007018;
	Wed, 21 Aug 2024 17:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=WqEjgSFKe+yFjWPUAjIkqj+uPubPJ20Qff5UoJBStyI=; b=
	ImszSzt9i4RpRu/0g3iwlG9aYiZ7oaLrOBafxM+ZBUzwzC3wRlRE/HwrkkRa5e6q
	+tV/0PxqdPOBZo32a1F1FIU/lzSRUS5+ZTYttlQdqAfXIFFCSk9dEf13JNMCTs90
	Jk1zntqJZYyuT0C0vcEyiusxAqt1EDTCMYDCDqMcpsiyyemrBUuCI6ufyd9wtVh7
	UBdIWZ7aX41CBb5SrO9eMd7LiFYbKaHU35ndEPqzi4nhq7aYWi6BAnZnxYwp9ClG
	R4aW0eGyA1xUk9wcOfnRdzFURYy2xT2Qxrof42RvWbMCjy8gPPqi29N/Bnv6EMtH
	PKtHu1tcRWIGoSC4eQCCew==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m4v06mh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 17:54:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47LHEhia026631;
	Wed, 21 Aug 2024 17:54:12 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 415mfcsn2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 17:54:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eddlfthKgBB02/wqPKcCcgU/pRFq/xD41AmnHoUmYK7zwE4OKrpbJqbG6IwKOHDy68oWj3e0ktSKem4bKzlW9PBctH/v0I31VWbasdtBXbt68c8pGgQ4VVjWkE1neTAM2k/5Z9CZrFAzS9W1I/3x3BbR4U6nc4j7lqpXwX+KVIeFXMZpo235g5sMvGRo1kTk5shv/kVZrg6SW4OdyGZ/bKorepBcOvAw/uVkPNCtMJOTP5rE8Ns8haexzhIThrVH5vukzRrXN+WHl/xeJs9RLCGQ8IbjQPSpq5x+NeghHAKuuua43ZVQbIp/EdMmFOdF+G4UcYGk7umxdpREjm55Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqEjgSFKe+yFjWPUAjIkqj+uPubPJ20Qff5UoJBStyI=;
 b=mFg61Or4Y0OIzFgf0nO9pHrh91x0kTDj4n4e6VVbAKy7WBJ/WmEKqlXtWj9gdjR19RrinvsDgPCif3Q32Mr5W+LneTjB6zDM1afogaRPg5vUAzpoUrITiiT58phixSe0Jn3Y0h1jaq7xOteIHFzoNgIIz6Ox8GDany14Srr6fOGZj17zzv5/w+UubPUyxP5u4dv1XR6gXqOoY0ODi/Ye3h+YoeNycyEPZ4Z8MUS4IxPq4Gq5uTIeXoZtzRhUDQuR7ZH6VvLOfvpJtEAX9QGO9N/aJc1D3IBQ/+UlAwtjC9TpBDerh3U+NIkkZ9OtXJoHBWcCMfhkM8md7HfkdV5gGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqEjgSFKe+yFjWPUAjIkqj+uPubPJ20Qff5UoJBStyI=;
 b=iI49oe6/sVOX0w+Sjom421EXAabMJBqDXVB+Ys0lq7oGMooONDN/KMyM/AeuhnFDi6Ca5Dzhhoc57Y/+CpD9G1k4G2GqbArpG4mzffJciFSaqlYTBKCntO95lUfAX52OSEYXxN0QHDnA/WPlTibLK7MuXmWgJjzNQKja7s0rK/g=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DM6PR10MB4284.namprd10.prod.outlook.com (2603:10b6:5:21f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17; Wed, 21 Aug
 2024 17:54:10 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7897.010; Wed, 21 Aug 2024
 17:54:09 +0000
Message-ID: <ffa07fb2-6554-40cc-8af6-e6b3a2cfacdc@oracle.com>
Date: Wed, 21 Aug 2024 13:54:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 0/4] iommufd live update
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
References: <1721501805-86928-1-git-send-email-steven.sistare@oracle.com>
 <20240722155500.GI3371438@nvidia.com>
 <3329e042-e4b1-40b3-9875-623f26386609@oracle.com>
 <20240806125602.GJ478300@nvidia.com>
 <54f33881-26e4-4b7f-bbdb-89f4cb207be9@oracle.com>
 <20240808195252.GE8378@nvidia.com>
 <53e7ab6b-9419-4808-b429-a88faeb3f6a7@oracle.com>
 <20240819145908.GH2032816@nvidia.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240819145908.GH2032816@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0053.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::17) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DM6PR10MB4284:EE_
X-MS-Office365-Filtering-Correlation-Id: 8848a6e9-73e4-4080-3462-08dcc20a41ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ny9EdXE0QmJtN2preXE4YUZOWGQwcUZHLzdOa3A5b2dvV3dJRXhkNmFSeXpB?=
 =?utf-8?B?NHo4N05VcTk1eWc4cE11dGhvNjZKbUduVDRkei9DcXJGSS9ubzl0MU5xeEFz?=
 =?utf-8?B?OXBLRHNyaFppMjR4ejVWQmNJRzlOdndhNFpFT2hzOFpkRk1FVUdCOXh5QllN?=
 =?utf-8?B?UTVJeUJtdGNwRG01b3l0TTh2N3ZYa0tYeTAvdEFVNzZXUFFJRFhpUmU2KytM?=
 =?utf-8?B?ODlQZTF1YWFMRm5qVEJXMTlPNHFvdkFGOEo0M0laeWhPR3lsNDltUEtKWTNR?=
 =?utf-8?B?OHhvNmZUMkdnbEhjdzRwcmp4YnFNZmRVL0ZIQlBxcjJvN3pyWG1HWUU5bXR2?=
 =?utf-8?B?ZHRGZWI2REhMd3hieGlqandSUTRmZm5IL29oZXlOaVNQR1RsbWplN2sxZXZ5?=
 =?utf-8?B?WU0zQzFUUWc0WTJTd25RN2hUb3Z3TzVsSC9rZXllZDB6dUt1bmFaOXdkZURm?=
 =?utf-8?B?MHhzdXJRTzFVUTlDTUpvMlBrY3FEZlU1L1hnRkVJY0FyMTRQMnBXeGhUNVhR?=
 =?utf-8?B?QnU1K1l5dTB5L1NPOXMzVUp5L2Zpck83dWp4M0NJMWw1b3hpMms2Y0F2anVi?=
 =?utf-8?B?c1JvaWdnOW1UUmRwQW13WUlORzd3RjdNcHBUbUFxRTdqbUM3aXpQYk9na294?=
 =?utf-8?B?SE1Va2UvSlVrSDN6SUJsbnh5VHBRdld1Vmg2QlI5aFRCRmNsQUdlYkJMU1Q3?=
 =?utf-8?B?N05SdWNlQWkwU2lLMFYxbXVic0pUOVhBbUttWlpCV253clRrU0JhUlk1a25K?=
 =?utf-8?B?ZEdoaTRMaHR3QnZody9GcE9IcWI5N015T2txbkl0ek0vUlhWaFV2YWxSdm82?=
 =?utf-8?B?VHlmdnM4aDhzekRYd0ttTGxtN2liK3pNNU5sTi85dlJTQWhpQzJzckI5c3Nw?=
 =?utf-8?B?SnpLWUpHNEJ1Q3FKSTFjcTZkQXdmak5UOTdXaE9ZeGRGanh2cU9obkt4MGw2?=
 =?utf-8?B?VEZjSDVsY1FTUWtrT3Nhazg1dkdSMDgzMnJydWlwdXRHMTV6SUk0WVpBZFRX?=
 =?utf-8?B?OUc1ODR4RVpHZjJObFhEVFJjNGtnWExJU2pzMC9FSE9jNjFuTTJrdlZ0Y3Yx?=
 =?utf-8?B?aWFjK1pvbmhhZ2duTDl0WlRNajBWT2tPdURLQVp6emZWUU5IdzVLcGlDRTQ4?=
 =?utf-8?B?Mi8zaWdtZkdGdFZRcWwvNThGL1JSUTJheENkM0cvVFQzWXd6YzE5cnhKOURW?=
 =?utf-8?B?K29KY2FvbUlrcnJublpJREhZRFBic1o3T1ZwUXZKVFhFZ0IvQ01tVGVMQ2ZK?=
 =?utf-8?B?L0xtQjZueThETzFlQ0VFcWhzLzlPam5JZzlnODdCekozVUc2dVRSaWZBN3g2?=
 =?utf-8?B?WkNJZEgzY2l1ZjdzSXF0SmJSdmY4c3pGcnEyTnRyZmlqZGswMUxVOGJ4ZmFz?=
 =?utf-8?B?VzhWSWtvNTNIUFRaWWtScU1HbG5qY2lIblZGckR6R1FoTTRBVnREYWlvcjZz?=
 =?utf-8?B?TkZ5VFFPcnlSTTl4SGhJYXkxYzFONkpuVHBXT0twelA1K2dBcG1kdVdoMzJH?=
 =?utf-8?B?UmExNzVXYmdkbytOeEQ5aEJEU1VxY3NpR1MrV054YXVHNys1M1IwY05LZU8y?=
 =?utf-8?B?NmxLYXNyY3JNNHpCRWxVV1dkVjNNUGR3MnpQNSsrV0QyR09WOUhyQVEvRFdP?=
 =?utf-8?B?SkRuME80elBsSFd2YkhuWitsRDJlT2JZK0VZUFJNU1Z3bWhQUkVUa25sZ21p?=
 =?utf-8?B?S3huMk5nMWlJaUJtcFpGRzN6Q1psdlI3bkJrU2tpVGNEZStaTVphRFhQYk9i?=
 =?utf-8?B?NDRzTVJ6ejQ2TTZzS0gzTjdnRysvZjd2RmRkazVCUHFTVjRGTGt0TEk3TnIv?=
 =?utf-8?Q?JOzOtT5zpFmJVwCCi/TXQpFPn6frLISXgLaYQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXFteVVINmRyQit1WkVzLzROUjR5bkhsV3E3NzEwRDdldzE1VFVTNDZKanQv?=
 =?utf-8?B?RzBsWE1SMzMySEdGMThPT2NqMklKTk9hOVUvN1hNUmNnYm9rbC9UckhOcmdT?=
 =?utf-8?B?b1V2TUxXQTNpcmlucllPTkwzQXBwSVJ5NHVodmxMdXo2R2hBSzV6UjJ1M1ho?=
 =?utf-8?B?bnBjSTNrNjNpc0Vmb2tVcnJUdGVnYlA0ZXFXSzRoN3Vnam04dExLQm1DU2N5?=
 =?utf-8?B?dHRtZWRta2VOWDB3V0lHMzc2MnVOU1hLMXJiQVp3ODMvRk5PMitoRjJGTWsy?=
 =?utf-8?B?bjVYZ3pyZ1hyMU9HRU4zN25wS242VUJFTjUwTy9lZFZmMnNjL044clQvVkMz?=
 =?utf-8?B?dTBYK00xTnpHanFOQTJVZjEvWkZNRW1lRTBnYnBObmx3anJod0hSOUFuU3Vy?=
 =?utf-8?B?QXc2VytuRytOMFh6TE9UWkxYSnY0eFl2MUtQQ1hJc3FXbTBjaHRidVMyN0Jw?=
 =?utf-8?B?RzhFWkRaWFQ0TEVYZllpaFBNYThjYTM2VHhQbTM5a2VVdHh1QlBtV3FqUXpp?=
 =?utf-8?B?dWhEQVRFSy9xdWJBUHRXSDhEZ0E5MER0cktzQUErb0dBVWRsT1QxS3BnOTE4?=
 =?utf-8?B?YzJ5elZqSjJqY1liTzYwT3JPRGFXQTJreFNxaW9mbEY4RzdVdXF2NCt0ZHE0?=
 =?utf-8?B?U0xWVzBXTXBuSnV6SEZVcUZMdkxFVlg5N01DTGV0UW5ZQ3dXMlBLdk9MNEJ1?=
 =?utf-8?B?T0tkMmlBMzFnRHgxUk0vRmpKUFFlL1JVMC9JVGdTSit0T3RTR09hZmdsclNy?=
 =?utf-8?B?d0JCaWl1Y0VsQmpwTno3OGFtMjk1eUl6OTlPbFhsWCtiUWRvdmlJamdlSTlC?=
 =?utf-8?B?cTc2STVsTHFuTFZ6OXJmVFV5NDlmKzl1ODQranQrQkpNTUQ5SHhmenI4cWlw?=
 =?utf-8?B?YVlZamtnZnZvZ1B4bHZxaFRWQlpGemJvV2xjeVh0dlcraWdyeTVSZ1dnYWt3?=
 =?utf-8?B?Ump0YTlMU0RaSUdZUEU4U1ZFaSsvS2w2am9PM0tmK3RaRmc3bnF6MWVBSloy?=
 =?utf-8?B?dWdIcStlQVVmL2tENHpTeEhrVExDMFpPeTBDRm53L256VTRCNmxERkdkMWN6?=
 =?utf-8?B?a3ZMa1Z3UjUwQ0VuN0NjZGFEVTJFNVBjKzVqTFN6NTJPUTNISE9mMThlaUht?=
 =?utf-8?B?cEd6ZWVMQTFxZGFONXo2U2wzL1IwVGtjU3F5UWZnTnpMaVUvMGEySUFIT09Q?=
 =?utf-8?B?K3RYY1VRMC9PMURXdVhxSWxBWUd3Y2d2NFhOU0d5S0F0TGJzL3VXWENJd3Vm?=
 =?utf-8?B?ZkRMSVZRM25DWUpmNHhlZkxHbFlxZFd4UStnYUM5VmZjUkl4cmthdm9PTGpS?=
 =?utf-8?B?WVZXTXR0ZGE3K2VNU2tnb2Y4ay83bmtMdWxaL29JU3NBK3krbEdyOUFocGMz?=
 =?utf-8?B?QUFCR0lCQmJWUDF2UXc5V1FvOFlNZDNaNUk1VmNWR3MxOStSVVpwcm4vOXlC?=
 =?utf-8?B?azRMaE9xVGlPOUNXbENCZW5UUUo4NnlVM2hQbHVRYzljcGF2UCtKRVJKU0hm?=
 =?utf-8?B?WS8zVEplQjVURG45SmNDall6d1Z1RWsyYzJFZVRNc1o0MDYxamdmUTdxTFlC?=
 =?utf-8?B?STdGUUFkWldmSGtSZy9NSXNkbjdYbVV4SXVKSHBEK09USGlieE1ZcDdvVHhZ?=
 =?utf-8?B?ZmpPWFZJMWIxSFg0bm4rbWFPZlRWS29raHI3ZFphbkNYQ2pWcjNhbUFZWUVu?=
 =?utf-8?B?NzNnUksrS0ZrdFZoRnA1Q09kYWpWbUxLOUFKeElmZEdiMUlDeWlZVTdiSncv?=
 =?utf-8?B?WVREbVgxNkw0UFpDTDdWWm1sc1RTU01FZ2xIZmdFUWZhMlZISEQzRmFGbnk0?=
 =?utf-8?B?a0N4R2pFQkx4Vys1SjA2a1dGQTIwcUNHTTR3WXRXK1pTSVpQYWpkektIWUlY?=
 =?utf-8?B?SGpxRis3aVVnbk5zdElxcHg0REZWWHlxYjY5bjc1V1NPbFdTVzlFUWNrOFNJ?=
 =?utf-8?B?UkJtOWg2aVMrcVBKRW90dG8vVC9BU055dEhjcmxCK0ZxclF1VVA3WGZYTVBX?=
 =?utf-8?B?WlQvT09IMDNiRUxmWjB0WGplY2NGU2FlVW1vYWdjL0wzMjRUMCtJSFRBUWp2?=
 =?utf-8?B?U0t1c0p4ZXQ3R0dEeW02aWliVm0vaE13ZjFQeW1QUU5kYmRPeTlvN2lONXZl?=
 =?utf-8?B?RmdHc080MjF3RGlIOGNjRDkxanllUDNKaDBpTkx6ZFk5NFFYQWE3VXpHZUF6?=
 =?utf-8?B?bXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	r0TkYWGzu1L/hDxz+m3zZzS0TgDTyTDBM0/iEpl8OzjVMKDTKP2eVTYO4u0EF1SPcWXrKYNe0GLmo/yoT7MHfyS3bjogw+e3LqgGOnaoc3zlNfTdcgxIfgAb9Rq3oH3XU3nQbzlbC2FZM1+ciHDy4zOg11Gpdfmrmvh7n4ASh9LglY3VbVPHcouFQ8oB443ikXTNl8Q5SA9kL2r61s2ZFIcTO4RCeSlQSC6bU4nuYMjzf/9rDAhRMs6fUCHXnPaq5L22EbHwUICqsAq7O69xD9yARXC6NABlrv8NSGJJTZPbhaBWDCYKbRSEzDRMAUFT+nelu2me5Xmulux++fgNzGYAZsXgH31vU440kPDoHXNj3JHXT2cPDKcQLGxiAoS8RrxMWFlbIhXgt0viW3l6m1nxwP9yCcussbQdqVNwXmJakAqAkGvE4VnkHeWT4QTZXf+B/VlfeHf/b28P/wNNXvUYloAlv6itd3iSH7HGEBD/yqX/hxub3LcdLU0dKU+BV2uxlcgd+iFGqpp+B/nhZM+3Tm+QA86l4j9ouMabwcaa/hFYPqYZ1kC7LpPBb5sKi+AiAsGABlaeu04oEbnKzIyV+u1pJKrlGN7dzoPTmnI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8848a6e9-73e4-4080-3462-08dcc20a41ff
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 17:54:09.4583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Lc4OcJZzhIckCUlPIjnuatv9a43r4Q8XDwGM5hHwocw3z8jcW4VVfkSTRVD/2nrnIdEUC9GBatrZAqq4ANU0/O+5Z8EeRlGtcGYMFIP3oc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4284
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_11,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408210130
X-Proofpoint-ORIG-GUID: _gRPKrkm44usB221j9Hto_xbu6ZBlSBV
X-Proofpoint-GUID: _gRPKrkm44usB221j9Hto_xbu6ZBlSBV

On 8/19/2024 10:59 AM, Jason Gunthorpe wrote:
> On Mon, Aug 12, 2024 at 01:41:46PM -0400, Steven Sistare wrote:
>> On 8/8/2024 3:52 PM, Jason Gunthorpe wrote:
>>> On Thu, Aug 08, 2024 at 03:15:02PM -0400, Steven Sistare wrote:
>>>> On 8/6/2024 8:56 AM, Jason Gunthorpe wrote:
>>>>> On Mon, Aug 05, 2024 at 03:03:30PM -0400, Steven Sistare wrote:
>>>>>> On 7/22/2024 11:55 AM, Jason Gunthorpe wrote:
>>>>>>> On Sat, Jul 20, 2024 at 11:56:40AM -0700, Steve Sistare wrote:
>>>>>>>> Live update is a technique wherein an application saves its state, launches
>>>>>>>> an updated version of itself, and restores its state.  Clients of the
>>>>>>>> application experience a brief suspension of service, on the order of
>>>>>>>> 100's of milliseconds, but are otherwise unaffected.
>>>>>>>>
>>>>>>>> Define the IOMMU_IOAS_CHANGE_PROCESS ioctl to allow management and use
>>>>>>>> of an iommufd device to be transferred from one process to another.  The
>>>>>>>> application is responsible for transferring the device descriptor to the new
>>>>>>>> process, eg either by preservation across fork and exec or via SCM_RIGHTS.
>>>>>>>
>>>>>>> It seems Ok to me, I'm glad it worked out for you
>>>>>>>
>>>>>>> But have you considered using something like the new
>>>>>>> memfd_pin_folios() system so that iommufd is bound to the FDs backing
>>>>>>> the memory instead of VMAs?
>>>>>>>
>>>>>>> https://lore.kernel.org/all/20240624063952.1572359-1-vivek.kasireddy@intel.com/
>>>>>>>
>>>>>>> I've been expecting to add support for that, but does it help this scenario?
>>>>>>
>>>>>> Thanks for the pointer, I had not seen it.
>>>>>> AFAICT it does not affect live update.  The memfd is passed to new qemu, and
>>>>>> the manner in which its pages were pinned does not matter, as long as the effect
>>>>>> on the mm fields that we manipulate is the same.
>>>>>
>>>>> I mean instead of using mmap's() and telling iommfd to take the pages
>>>>> from a VMA you'd use a memfd and tell iommufd to take the pages from
>>>>> the memfd directly.
>>>>>
>>>>> Since the memfd is not part of a process or mm_struct it is not
>>>>> effected by live update's exec() and none of these gyrations are
>>>>> necessary.
>>>>
>>>> The problem is that kernel clients (eg mdevs) use userland VA to identify
>>>> memory when calling iommufd, so we must update the VA's after exec.
>>>
>>> Technically no, they use IOVA too and iommufd translates IOVA into a
>>> VMA and what not.
>>>
>>> So if we teach iommufd how to do memfd it would also learn how to
>>> adapt it to mdevs as well.
>>>
>>>> vdpa does the same, if/when it converts to iommufd.  I cannot see us
>>>> changing vaddr to (file, offset) everywhere in iommufd and its clients,
>>>> up through the mdev code stack, can you?
>>>
>>> That is exactly what I imagine, because it isn't vaddr already, it is
>>> IOVA and IOVA always already translates to an area which gets you the
>>> vaddr.
>>>
>>> It is why this series can remap the vaddrs on the fly without reaching
>>> outside the area struct.
>>
>> OK, that looks tractable.  There are not too many instances of
>> struct iopt_pages uptr to fiddle with, adding support for
>> file+offset.  We must of course keep uptr to continue to support
>> anonymous memory for iommufd, but such memory will not be supported
>> for live update.
>>
>> Do you envision a new userland interface variant of IOMMU_IOAS_MAP
>> that takes fd and offset?
> 
> Yes
> 
>> Or have userland pass user_va as usual, but have the kernel check if it maps to a file,
>> and save the file?  The latter is more work in the kernel but requires no change in
>> applications.
> 
> Maybe this is possible too..
> 
>> Do you plan to work on this any time soon?  Do you want me to?
> 
> I wasn't at the point of this yet, if you are interested I suggest
> taking a stab. Now that the the infrastructure is in the mm it should
> mostly just be changing pin_user_pages() to the other one. It might be
> quite shore

I'm on the fence about taking a stab. It will not be short!

memfd_pin_folios() returns an array of folios which must be saved and
later passed back to unpin_folios().   That's a slight bummer, since
currently you save memory by retrieving PFNs from the iommu as needed,
rather than saving all of them explicitly (with the exception of pinned_pfns).

Also, the current map() call stack uses pfn_reader, which pins in small batches.
This offers no advantage for memfd since we must save all folios regardless.
So, we could short-circuit the call stack above the level where pfn_reader
is used.  Or, add folios to pfn_reader, and continue to pin in batches, and manage
the separate arrays of folios that result.  Or, add folios to pfn_reader, and pin
using a single giant batch.

Also, I must truncate the unmap() call stacks above where PFNs are used.

This is mostly FYI, but if you prefer one approach, let me know.

- Steve'
