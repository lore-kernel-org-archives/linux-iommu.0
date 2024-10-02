Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07951CF7C0
	for <iommu@lists.linux.dev>; Wed,  2 Oct 2024 17:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727891508; cv=fail; b=mUfesDWYWIXJS4BrcnRacyOrRKlHYK/IF1Scco4SL+t/KotBSJmDGiX7rxRH599KNRd4hg3G7mfUnrJ/6LwBnBRTcLDiWhV865bSNTMs/cL9e7iJF4sc/njOXu0HAk1HbBUCxCC75ssaMsezUbO4++k7kfs4jr6RP5lcfZ4kkYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727891508; c=relaxed/simple;
	bh=KjpnqLOJz7DgS5HZ++eODZdkEbBfXxkMdKc5A7Sm/f4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KAtCtVc6uvkxKSn83LmtvXF5uKQtAeZaeIbtLT47fCaFEuqT3e0V0rGk6QiBe/c12T6C6okckoXX+7tJhgyJCgeceE0+Or2WhXBiLs99x4UFn1wlcgFBw40eW+t+GnvzE8ojj8p7MjsRA4mvHmNB5GzioG9bLDgNyym+sFwdfoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IMnrDSOn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dgMjOsle; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IMnrDSOn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dgMjOsle"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492Hfa23025451;
	Wed, 2 Oct 2024 17:51:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=Q2k9xq7SQN8sxCx2F0YmCJuvfBtrmfcBlr/j+QpE1Jg=; b=
	IMnrDSOnxZxIBSSCzTdv6dEv2ZaPs2xg7ZIvBKwb+9WDO5Oy1slvxoQNdbcKfIJF
	xa9scSboHNhDxV+qjeYI6X51Ch3vzmp3ornHUqh7qyTi+ldumS3yh6RPX2t7VpTS
	o1gcFvWFM1cWoW2a9WJJJeUAGq8ja2GIaC9EoQqFNq8ul26rVcq7D6A6ku2FtXXE
	KNLSghiFL95YfcZPCrihbpvXbPvBuB6mV3yUqo8Ec0h3MemVKzRaIwgAgkwpDBYV
	QN2epXxGAVqDTDjIhuXnGkJ5SJ5Ueb1W2pp2QwzsTBh8YJP8GAw/7WNNvhuO4T1l
	aEOfQtyP3p33I9iMkhkL4Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x9dt2cyf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 17:51:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 492GxBMB028561;
	Wed, 2 Oct 2024 17:51:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x889ddva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 17:51:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MDZVvfu4k4IOAr8IZvCC+TyibmDqIETX2Q/AEVsaZaDI72ICmd/LbHrz+pjmazi8S7gbNhqgCYUs2/W/Ll3/0f2OIuh6uUKQeghAVi2QU/aWpeRkZ5ZGBhl8r4IOUwHBKvpHr+lLMzVk6yaxPNBbRHXesCoWE7a/OxGg8PDsOeF19UGH0NjzQQVpEio2IB3HvaiFNc2rDqSoYNNIuDAVYVorp/VEsK6H1p0RxHuE7EJbv56G9DfdN7B0v9MtzDYGMg06fcI1kGBaL9JfEg0BmWUwPIhsKElLVKvRFzvzcnQQA5C1CMnAZ3m/BnsrumRTpC7EszX7bUdf8twWJp/v3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2k9xq7SQN8sxCx2F0YmCJuvfBtrmfcBlr/j+QpE1Jg=;
 b=dstSNzH6ZrIrlQXVEQ3ftRKgXOWvcRyiIccRcOkfN2IMI2g3yxkPG6RDTvcxu1vDegSKhwch5BDsNXs9QPYlUFo4k+DeF0UHkTECg2d1TX+0zha0BjbHAjIi73C6ZYh8yRDtv7ZGrUIIDOCtXnooWusseZrvbp0+j7rttARWJ1DeA2cexLKNAbyQwqPJuR0RovDRDWJ28vpmj8gWwmZbBHvsHeWQSlRvyoQxVb68Y0YgA0bZDanSws5TsoBAPGuz2TJuL+H9BhsT+5qkGTDmKc08VdxwaCS/cPtG3CCVtZG0c+uD63sCcEFtmbRWWj+sncm3uOWMdH9T0AlvH8pDbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2k9xq7SQN8sxCx2F0YmCJuvfBtrmfcBlr/j+QpE1Jg=;
 b=dgMjOsleWNbE9QLiB4NAxY6Up2uTfKXVfOrTFpVnkU1zXDIAoN9jU7/B8NNmNVC1eVvFUAMeD7mUFsQ+ljTY0HV1JhkDVSkox2oZKamv0uIpZlEQKyCoKkmNqu2AeulJkI/d+8MtNo/PPRspwHLQvV1nZq1rGHKCh4V19+ACzs4=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by MW4PR10MB5749.namprd10.prod.outlook.com (2603:10b6:303:184::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 17:51:39 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 17:51:39 +0000
Message-ID: <b11581f1-1b0c-4685-8dac-7a2c330f6b94@oracle.com>
Date: Wed, 2 Oct 2024 13:51:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 8/9] iommufd: optimize file mapping
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
References: <1727190338-385692-1-git-send-email-steven.sistare@oracle.com>
 <1727190338-385692-9-git-send-email-steven.sistare@oracle.com>
 <20241001210356.GO1365916@nvidia.com>
 <a8005da1-6f89-4934-a010-73867b596239@oracle.com>
 <20241002172904.GT1365916@nvidia.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241002172904.GT1365916@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0232.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::21) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|MW4PR10MB5749:EE_
X-MS-Office365-Filtering-Correlation-Id: bab20e60-e26f-4e53-cfaf-08dce30ade00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUxrVzZwZG9XZkt5aTdVdGx4bThCbFN1T3ZpU2FleEtNWU1UZ3FQek9lemRm?=
 =?utf-8?B?djJFOFczRitFZWYwNVVhNUdaOGs5NXFzNzNmSVdLaG5Xd1lYcjd5QTI5a2Zx?=
 =?utf-8?B?Y1BCZTFZazFRQ2dLNjFuMWNoRU9tWUo1U2owOG5WR0dESXhLNUxVSUdDTmxp?=
 =?utf-8?B?T1lGNENNUkREdGg1T0tzQnBVUUZUQkE5MGdFci9ZVXk0VDBmRVRtc1M1SG1x?=
 =?utf-8?B?dFR6UXlTVURTRGhWWEFPMkRzb3VMSmdOZXJobnVKVFFqd2tSblJPd1A0TlNh?=
 =?utf-8?B?WVpWaVB5cW1JeW52UmhJcGUrS3hBNU5UZ0o1SjlQNmZxS2NSbHFIZnRvT1ZK?=
 =?utf-8?B?TldUNnJWY0NKZkFCcElkeXd6dHg5WXFEclB3TTQ5bjVyaVNhUlNVdG13QmtT?=
 =?utf-8?B?VWNLeUt3K3QwM25GaDE0YUxqWWpOYXZ3RXFxOGUxZnJ0UTFrNE1MN2plQ0Jv?=
 =?utf-8?B?OTZBRGFMOXI1V1IwbXpYNGVUSFJPaStEcFdXdTZjVGpjNU43Q3drTWNoS2RL?=
 =?utf-8?B?N1F1ajZabC8wWnhVeTRLbHJGMTBXL2Q1T0tFbE13TVQxaTQ3cHhnVmtadUNh?=
 =?utf-8?B?NDZZSjZvaGY0ckJNcHpjQUlNZDBiYXhYK0tUaFdqR1FLQndSRWpoUFM4V2Fi?=
 =?utf-8?B?V09tN001dEtBQnZaNndPSUQ0ZFh6OUV1blJ0UUNQSDlBZDZlSGpWZFpEMVgr?=
 =?utf-8?B?MVlKTTc3SE9pS2ZWUzcxVmt3YjZKY2NMOFVzY2xtQ2FPTC9KOC84OGVBbDE4?=
 =?utf-8?B?cXdPTE5RUE44akFxRkFsMHNLZyt0VW1OcTNTWTBaRHlCUHE2SVRZWS9SdHRW?=
 =?utf-8?B?Z3JsVVpIYWVVclE4TDFxMUVTR3VuV1lMdTdZb1B1a3VLR3hIS3pmWi9aazBR?=
 =?utf-8?B?L3lXay8vWFNnOEJ6a25XYUtoaEQ0RllBWWo0R2VWb29TSGNtcW01MUxPRlZs?=
 =?utf-8?B?eUR4blAvSDBVdE1EUkVDR24xVGp1bTVpVlRFYXVHckhMTmVyRFFVUmRzOFpO?=
 =?utf-8?B?N2ZFek1MUEZpU01mSzNOK2RqREJyQm52Sk9QUXlKdnQ3TnFpVTFMSE1TSFhT?=
 =?utf-8?B?K0w5U1dOdk9HclJGcGJ6VU5QdHE4RnM5YjhRZnYwUGJLSHF3R1g0MUVJbWlZ?=
 =?utf-8?B?Z3BBdHhkMUlFbThldHlQMUJzQSsyZzdCL3ZSMFlHL3pKNEtmQkhlM0dYZTV0?=
 =?utf-8?B?dlFGMzdyLzlYWlVKRXl2YUdIZFpXU3BJREdab3o0alF2U3RGMjAxQmU4N0dk?=
 =?utf-8?B?cGpCOHhZVFVtbEp3T2hWWlJlTkpDak9lMHExc2g4YmxWQUp4MlQ2UWpoMDdJ?=
 =?utf-8?B?UWl4VWhINlN6WGsxUkFLMFZEMDJyQzRvWlI5MCtybmdqM3lqV0YxWXdmV2tZ?=
 =?utf-8?B?VmMzUjFOa3hGRXErdFplWVRXS2tZeGhiUzI5VWZweW5JMmlDY1dhcnJ2SVNl?=
 =?utf-8?B?cmRoajVNcjRwbWlZWndIdDdXajJxS0dyWXo2VWRsWXU0by9MOTZZV09aYThu?=
 =?utf-8?B?UWpYWGgyWXg2S3EzR2ZZWmh1dERyekJRWi9Zdmo2ZXhNTFJQVGZzK1JJOE5H?=
 =?utf-8?B?OWQwT2RsR3ZSbmpPWXdGZXoyQjl3elRPWTdxZWJ5dVNmaHpvQWZwMjE1dmhD?=
 =?utf-8?B?TW0xSE51Lyt6eGdybVVFZTNPeW1TVWxsck9FTExLbjZIc0d4ME1jKzF4ODR3?=
 =?utf-8?B?UEJuZXRiUzhJRHVmenREWGNXS2k2em0rdGFaTHRmSUVlTUl3ZmIxRWdnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3ZtUHNlaDhPUEtDZklFTUVXV1NwSXNPV3Nzdm02YnFxTVh5OWV6WStabHky?=
 =?utf-8?B?ZU94akNweFFWZWN5RGhObzYwMzJmOU1jWnkwVmdiVTdLTTdISFdUMWtpSHhs?=
 =?utf-8?B?Zy9TbjRHVkYzYnFVNFZHZk5pbnZ5YlpPMTNWZkhOUDBwMlIyQ0FaNjhGWnJh?=
 =?utf-8?B?VlY1b2hzVVdLMWZ0Wi9TNnNmWjRCT05Dc3k2cDdoQkk0TFpYK0Exa3BZOGdE?=
 =?utf-8?B?SkFjQzlwb3NRNk5qSG02SjZBSkorZkhEU21HZGxleUk4VzFZQ0ttd2JxaVc1?=
 =?utf-8?B?K29pVWhzcm4zSldMUUR4OWYwNThlU0pKbkJlaWFPY1BFeS9LZHFsZm95dkZF?=
 =?utf-8?B?WThlQmN6aTFCUWd2ZXhEdHdjTmJvWXpPbGNYeEhCVkhKb1FrZHFKL0dNWUpz?=
 =?utf-8?B?SDRVakV3MVNEWjdQRytOQ1pMWWhnOEZ4M3h5S0Y2S2VHODFxQlp4eVRjelhX?=
 =?utf-8?B?bGJPcHJ3TENwTEZNUks3QldNQzNHU1FzQWJwOVFGSkRBS1FKSTVqRTg4WGYy?=
 =?utf-8?B?eHZlK2NRMC9ob05tdS94cDJVQlBrcDAzQXpic01ZL2YwaEVCZnhUY2VOQ0h1?=
 =?utf-8?B?VjFIclBaR0JVNlVqbUljNzZRZWxLS05VQWlrcFBVdTFLb1VSTGNxcmFyNyt4?=
 =?utf-8?B?bVhrdEl0ZFVpSkFPMTBPQ1JlajM0NHdyNjBqQ2JCNUdIb1Y2SFZ2WEdJTW5t?=
 =?utf-8?B?NVVoWFJqZitOck4xd3BKR3orRWQ5SzZBRTY0Ulp3SUZLQ3RFeEw4QlN2RnI3?=
 =?utf-8?B?Ty9QQUFLMmhCMHhRTkxCR0xkNEhzWkplcjNKYWV1QVhSK1N3SURFMXdHVzJx?=
 =?utf-8?B?UDExcGFNalhEVGJlTWY0cE9LU3hqelU1UUJLWkVZZ2NYclNzVDgyNHZTaDZp?=
 =?utf-8?B?dmpIU0pBeWFOSGY1YmthRzc4ZDQzSXlScmNnRHk5UXVTQStNNERlV0VyRE51?=
 =?utf-8?B?OWpGR25pWU11UzllTngvVWJrVFYybDhINmFQeThnOUZ0RThma1RHVFJaNkJF?=
 =?utf-8?B?b2NoNGtaYXc3ckF3NnFNaU1xVlAvTElKQTlCSTdhbFphdndDcmtCdFN3SURH?=
 =?utf-8?B?dnZpWGhhVkZPRnpnSDhHbmZKYlhsWnBFWll6ZWloRFhpU0xGZzBodXlpb0Nv?=
 =?utf-8?B?WiszTnM3L3B1OHdlclp6M3pIZTA0QTRlMjlvNUVtUGJadUZiUU9od2p5TnFJ?=
 =?utf-8?B?eXZrRDROY2NETlRoU2lLTHdydXY4V0ZUMWNiVVlncEVLMmovaXozZk5Eb1E5?=
 =?utf-8?B?ODN0Nkowbk81SGJNU1A0b05OR3pRTDdCMndWOWVVNlg4anhTMGUydHltbnE0?=
 =?utf-8?B?TTdwb3N1UFN2ck9XZldUMExvQmkxajhNdVVkNTRoSmliOEl6Qm93bSs2a3hP?=
 =?utf-8?B?SkNLUnlhK3NUUjFYZi9CNm5UVzJ1RWVHWTQ2OXBGdUoycVNFdlF2dFdaVzlE?=
 =?utf-8?B?NXlJellidXVGVG5UUjNOejFIelJrdnJQTS83Wll2aC93cUlGc3hCdFErQ0Ni?=
 =?utf-8?B?NHJ0VXZXOTJmaG9MSnhrRVZuak1RM1EyL0ZvaE9GdW9udW0vZDY0NTQ5Uysz?=
 =?utf-8?B?TTRDeFpRZk9YQUNvNERqWTdkdHRtakVCTzB4bTlxdktvVGlsaWlPOFVieDJt?=
 =?utf-8?B?dG5NVm1leDZsaStZeGErcFdkR0Nuc2UrSXFja2lCSWdTdndBb1Rrb3h6eUsv?=
 =?utf-8?B?Q0tZMkt5SUcwSDV0VVZKdktVcllhYldkTkZoakQ1bDJMUXl5WXgzRHBVeXV3?=
 =?utf-8?B?dytHY0NZNmxWVGlHWHVQbzJ1enlNV25qTk5CTTN5d1hjUUhqRGtyMzhMSTUv?=
 =?utf-8?B?bFpnbDZtRlR6ZEVpUGtWWkpsM3Fya1Y0RmdSWlh4TXFGWWM0b3d6NVNob0Fk?=
 =?utf-8?B?QnhzcUdVMWtYOWVJZmJuOVB3N0tlMktha2hBQ1hCazBOS1ZQUFp0dXVYVTE0?=
 =?utf-8?B?NURWVWtyK2dUMnJqbjVyMXJJQmN0TnMzaThwMUFHbmFXU2xmcENYRm9YTEtQ?=
 =?utf-8?B?T0NpbFhVSHJtNzJkUXRyR29mWUtNR2l3TE0zU3pWNmlmR1hvK0RmNU9GMjJW?=
 =?utf-8?B?Uy9xdXQ5TWN5NWk4aUFRaWM5YmJXMXpDNUVqR0JWeTJQZVN1S1pxMHpGNTNZ?=
 =?utf-8?B?YlU4UUdrb1JLVVNRZDJHNGRVbVo0VkJtdXZkNWZPckJ4a2Q4SHNXVThmcGhP?=
 =?utf-8?B?TWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gDawnO4fEiZB1UmweNWa+yM9JzffuEMO48dsiQqH2pwuxIl6KAqh/PbYOUVraplV5sSf8bnrXnKJ1PkCETBBFoKfQERIz10zhbgB5ii39+PmTeWPGvTbXxCaVOwnR8//tfn8JBsoBwIia59LwZb4XVhh3BJrOUJFtdRkAfrZeo2i2iQq/bxhVUcfZWIOruGPJfg8Nrk8gtC1qSbobr7JOQnsDTw0aKA4Uqsxf2QZjTKDWS8FSm1QixltVAH55Zcwd2h9vfgmTu43yBCNtCsNXdjmYvQZBWbg53H3rfAE+SStmFQHzIKw6I0vMOZZ6nR0Mj7X7FFn6a3RWBjra5/h2e3AWIFNVrWmrW4oxKxGAPiWKN4L6UCKWBsPlNhewlNLGiDiuNszsvPCOoQVsFHMD2EhJ3EwhocUPtBjCakLszSdP6aLT94WXJ3fr9NjujPMivCT7x6AWFOzHHDNSg55styHl0/bVOD7/IE7uPGt2Hrft4sz/HTHeUIyFL7rh/08rOWKcEDEEoh5AyQJrC79C6XAuC0pGSEfEzQyiLfl/mVD68hteFM/0Y8KNrkgjp99lhMDo2Le5o4TDiSm+H7H/3p9dAYipC8TZVnbGRz4MmY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bab20e60-e26f-4e53-cfaf-08dce30ade00
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 17:51:39.5024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u5v7e17xQbixQ5iVN+rDhbJZ0ESq1gq59IzXifClxrMcTNDiYGpu0VscmGzdUtzL+uMsKwknU9130eGmR7Ut4+M8q1U5aL4fCbPvZw5tHoA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5749
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_18,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=845 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410020128
X-Proofpoint-GUID: B9ThU8gKdb928s-HyhWaPfxKZNe-t7J8
X-Proofpoint-ORIG-GUID: B9ThU8gKdb928s-HyhWaPfxKZNe-t7J8

On 10/2/2024 1:29 PM, Jason Gunthorpe wrote:
> On Wed, Oct 02, 2024 at 01:26:32PM -0400, Steven Sistare wrote:
>> On 10/1/2024 5:03 PM, Jason Gunthorpe wrote:
>>> On Tue, Sep 24, 2024 at 08:05:37AM -0700, Steve Sistare wrote:
>>>> @@ -622,6 +630,67 @@ static void batch_from_pages(struct pfn_batch *batch, struct page **pages,
>>>>    			break;
>>>>    }
>>>> +static void batch_from_folios(struct pfn_batch *batch, struct folio **folios,
>>>> +			      unsigned long offset, unsigned long npages)
>>>> +{
>>>> +	unsigned long nr, pfn, i = 0;
>>>> +	struct folio *folio;
>>>> +
>>>> +	while (npages) {
>>>> +		folio = folios[i++];
>>>> +		nr = folio_nr_pages(folio) - offset;
>>>> +		nr = min_t(unsigned long, nr, npages);
>>>> +		pfn = page_to_pfn(folio_page(folio, offset));
>>>> +		batch_add_pfn_num(batch, pfn, nr);
>>>
>>> I think we technically need to cap nr here as well?
>>
>> Do you mean cap nr at max-unsigned-int and loop over the folio?
> 
> The max that can be put into a batch entry

Yes.

>>> Why does this exist? I would expect you'd call memfd_pin_folios with
>>> the correct offset so that the first folio was the right folio, this
>>> is how the pin_user_pages path works?
>>
>> We need folios_start for the case where the 'if' branch below is not taken,
>> so the folio was pinned by a previous call to pfn_reader_fill_span,
>> so the requested start_index for the current call does not necessarily
>> fall in the first folio of user->ufolios.
> 
> But that should be handled by keeping track of where we are in the
> array, not searching it again..

OK.

>>>> +static void folios_unpin_partial(struct folio **folios, unsigned long offset,
>>>> +				 unsigned long npages)
>>>> +{
>>>> +	unsigned long nr, j, i = 0;
>>>> +	struct folio *folio;
>>>> +
>>>> +	while (npages) {
>>>> +		folio = folios[i++];
>>>> +		nr = folio_nr_pages(folio);
>>>> +		if (offset == 0 && nr < npages) {
>>>> +			unpin_folio(folio);
>>>> +		} else {
>>>> +			nr = min_t(unsigned long, npages, nr - offset);
>>>> +			for (j = 0; j < nr; j++)
>>>> +				unpin_user_page(folio_page(folio, offset + j));
>>>
>>> Don't loop, we have unpin_user_pages() for this
>>
>> Cannot call it, I do not have a pages[] array in hand.
> 
> Ugh, still, don't loop, this needs a new mm helper then

unpin_user_page_range_dirty_lock will do.

- Steve

