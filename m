Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E22C1C32EB
	for <iommu@lists.linux.dev>; Wed, 18 Sep 2024 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726671155; cv=fail; b=XHX1yJ1fOqvC6QeS845f4sEt/zK2gRSy1gWfvp8zgC1T61DZCPEjAyAF0OwHk18LNplEl7V7jzV4gJpHkPIfBZ6aRaG3hBBOoRtlDXKICMrZ/jzKBVL3i04OIHeu9TEEV/kD0TevMzUDBLDAMA70f64+7S43WXdNdXj51OfKOCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726671155; c=relaxed/simple;
	bh=E7qIxnBn6cZwmfEXRpBDVEjZwxkPJb93XzSWXi2aJFQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gUwyQO3l8N8ZFwsHua3vFoJX4p7Ous0z9b1H6DLYnIbdVlh0YY1JORWuC66AiGi7imXrNQV33boiVr0DHGGMfImdEofzcZLUpHd2KkuVPaR40AtDBSBp1VsPzQqwuJWQyTy7EQKCV69GkNG99VkFasUCpWZaT77i7cuRbgupUUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KXxz+TH3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fFbWQ0ou; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KXxz+TH3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fFbWQ0ou"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48IElFxL029304;
	Wed, 18 Sep 2024 14:52:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=+YgByEW/gYEbU52bP1U4Z2p3S4vmNmq90D7NPaB9qso=; b=
	KXxz+TH3Lk26062IoEhXEhFb9Vtkpfals0sj+mCI2XgnNAgDBdGEYHm1gRdmT55n
	Vbmakaytz2p4P5YpxfJPf/r0GsZZTjw970lF263kFO5zeQS/+xcZX1QHZen1iV1/
	UriXDQQs+WsmRAbgXBU9EBS4v3C9bNE8EfbephQKsN6mD8K5di5IAxV84+KSAqW/
	VNazwpVlGmXAMM69eaYWXEBMCIwLMy5TKTfDvnVAZ+LA9pP0ZJvjzBeob1M08K+A
	U9Bhwtf8eK58Dh8SJTc4RppEKNfKh42CWjd2JRYCmVqc+cADTFg4MT+GCYMMho8H
	Y4PlSqaPf9ej6MTEB4qIFA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3nfsh8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Sep 2024 14:52:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48IDRMhN008263;
	Wed, 18 Sep 2024 14:52:30 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41nyfdfaup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Sep 2024 14:52:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hc+ULbfY+qIfpK/KkyAkoIWWt4Z9ou4SyeI03sO7rO80URbtHyAmZ/vF4zrDIPJHm9WkwFWWSiBRwMrcM90o4OX+5MQRLmzEwAwajJGPoyFcniG5SbJqvALfIvRw1/rcNo39YtIlwM55SwB23ssKzuM8p9wSUTdgj0ocOPLol99KqS8hbUZ9DEByYv2WDiM8fcS8IVquKGy8QEdgeV3dpyOHSk3v+Smjl8nbqB3+xxBs8FGlldA888An+VJ7bl8iigcYXP5fFoxrAz++eJNFQMMozHFJcCmO//ZBnsAWrI8f/CpV1QS7eynWiOILjNPIpu0sE+4Nabs5hcD927hcZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YgByEW/gYEbU52bP1U4Z2p3S4vmNmq90D7NPaB9qso=;
 b=SBH5hYyQgycFv6IvtBaxHqiHTwjALRYImtL9LrtOnu10M8eP9lCNxUhdGHvOjOmT/hR1yOMFAzA4C5kfWuJQsr2lIZHT3mxUNi7Yv+NSM3fUBhcG9X2I6OC+zeu1uA2nts6F43FxOAFLrXSm/fUqBwJRCPGBjgx/DxyROYrXy2tKx3adwHKw1bHntT1FRixl+9yD3QJzZNekiD3ZiZkRo3RPFE6dToET5TJYt7ImTCXJGidpjcJjScGcFegSDqzp60L9oBwdXmrkvUkt72gsD4/HqIChkZyjaUfJtAfC0gTghLet2+vw1DenfRUSeR/NYYPAL9b/cwLZ0lsTip8vbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YgByEW/gYEbU52bP1U4Z2p3S4vmNmq90D7NPaB9qso=;
 b=fFbWQ0ouhhPmL7tkCCXtdMBG803OtUEA0DfXYopvUZzwTbzGmhFHWv11mdy3eZG03jTNJYnPIZImrOEzBFXW4tjKMnECt+PCWrjndhOVI8m2jBuvj0sjm//d4iSdim2U9EviJu88XcUVwWZX8gjpW7qnJIdvPh19eWaxSmQ7zuQ=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CY8PR10MB6825.namprd10.prod.outlook.com (2603:10b6:930:9c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Wed, 18 Sep
 2024 14:52:28 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7982.012; Wed, 18 Sep 2024
 14:52:28 +0000
Message-ID: <ffeed0f8-a65e-4545-a00d-653de0b28773@oracle.com>
Date: Wed, 18 Sep 2024 10:52:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 3/9] iommufd: generalize iopt_pages address
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev
References: <1726319158-283074-1-git-send-email-steven.sistare@oracle.com>
 <1726319158-283074-4-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1726319158-283074-4-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LV3P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:234::11) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CY8PR10MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f7247e7-44c1-471f-eb94-08dcd7f1842d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dU5ocXYvNU9CNHBmU1JwanBzRGlmTEgyNkRUNWpmOTV1OURnTUxqOEhMQ3ZK?=
 =?utf-8?B?d2VlTFE0cDNYa3FMVkdNZW5OL3JHTWlKODVHNjNJZ1dwU1VsZFpPclg3Y1lm?=
 =?utf-8?B?MHRFT0N4Mk1rN3pMOHVxeDN5aFhjNkJidTZ2MURIUkx4dVhiRTdNTWRwTXpr?=
 =?utf-8?B?eGNxMW94SHNNazgxcXlhTmtHMkMwZUZ3M1ptRjVUSnRPMFFybXVuOWRUMnEz?=
 =?utf-8?B?a0NsTFFZaFVsUXFNQkFqblVTUndoMllKQzlxYk85NWxsRkVYcXYzRCs0dUNT?=
 =?utf-8?B?RnIxUFExU25vejU1NlRGZzVvWjFVYVFZeGtGcGhnYmUyM2hCVUlsVlJPbDQ0?=
 =?utf-8?B?VU4vb3kwU2VRYytzbXZ4MUdUcXpZUngydU9ITXJPa3FWOVZpbnluZDBMejQ0?=
 =?utf-8?B?U3FZRFFCUlVyUGdWcWxZOFVYSkNGT1pKMVE2amhKVXU1UXBUVWI3ck92disy?=
 =?utf-8?B?SHNVYW93ZE03UjFKMXVGc0JyQm15ZWVZckhjN2hmV0M2ckVmUjJPeGlQZjVD?=
 =?utf-8?B?Y01kOWRzcll6cDE5d2ozSEhEVE5nVGNQK3NDNEpXK2lveWdvc21Qd0wyUFFu?=
 =?utf-8?B?UWhzVjloTUxwTEJRVnlleG5UNHFIVm03cUZYcWxUcXZXL283T0NPOERpeUY1?=
 =?utf-8?B?cDIvK1YxUWxieFFXOEtuT3I3cVlGQjkvdEVMVHp3Z1JxUXUxZURsdVd5MXBa?=
 =?utf-8?B?OUtLUkIwdTdIdVN0SktpRVlvWVkrc2x1VDZCQ2huNXU0MkxQUEozL0Rkejc5?=
 =?utf-8?B?aEx3VnlKcFdzbENXMGJEeTEzVlFoT1EvcVNYbzVNYm5ibTdPS2hzRHpoaGZZ?=
 =?utf-8?B?RFk5ZUtqV3A3VWN2YTZ0V3MycnJTMHVLSHkwSUtzZERCYWlkYUw1ZXc1N2hL?=
 =?utf-8?B?YzR2QWhJUUJ3Qm13SXpZK3EyMEZEanViMURGSGQ3LzNaS2Mxb2NYV0RFYmZT?=
 =?utf-8?B?QVI3K003VzAvcVkzZmlaZjhOUEo5T2RtdkptT0R0RFFXeVZYYWxvOEpwUWNp?=
 =?utf-8?B?cjVpRHlCcUpVL3RDc0IxQ0ZvSjI2SDhNZm1TMkRvajdmY3pxM2FtMGlHelpH?=
 =?utf-8?B?cTlQc2NrSktSUnVmTE9pK2I0Q0JrNEpNRWU2cnRFV3Vna1cyMWtVN2RydUMw?=
 =?utf-8?B?VEoySXZjem1iVng2WXg2TnhXS2ZydW5ncUtnWTNHTFJaVWh3ZlBkVTZXV2hp?=
 =?utf-8?B?Z01NdjlMK001UjRzeFV1Q2h0dFRVYmQ5Ym5yaFhaT2hhNDMwc1psZk51amZx?=
 =?utf-8?B?ejBKa05wcTVPWHN3OHpBUTNVVWdjb2MyMVJKR1cxWjV5bldPWlp6LzF1VG9w?=
 =?utf-8?B?M0FsMXRCRlF6bDBiVnpIdVp0NjhtOE9YenB4blplSE9CTW56WnVpd0Zuc1ZH?=
 =?utf-8?B?aFJBZmY0T1lCMVY3K0p3ODFuRmZ5RGJScmJ6b29SZEgwMS9PQ201UzFTV2Nx?=
 =?utf-8?B?ZG9PRUs5SGRkR2ppOE56NFdwRVZwNGNVbE1sYi94TURvS0VVOVllVzV2aUg5?=
 =?utf-8?B?WEFnQjFsdWhEblNoOFF1MmFmUjV4ekkyNmhrNXF1TkZqalA0TVNZSzd0OUlO?=
 =?utf-8?B?ZEN1TDdheWdHdXBNNUVQcWJPN3FxTGZEai9GUWhsQ3AxSVlCaWNBQWZubFZD?=
 =?utf-8?B?cHJjWEpvNm1FQXI0WldWZmlZYmZWeG5mTzkzVVp6STVJeDZXMTYybHFyRmJj?=
 =?utf-8?B?U1JUUVNWdkdDU1hZNW9uM3hoV1YxbGpzY1lkVHV5OGlaVGRUci9pYmZwNVhM?=
 =?utf-8?B?TkxKWnA2SGd4MGV2TklqL0s3dVVTNFhqUjZaYmlCRUNZdnlkR1BhL0VLb0Iw?=
 =?utf-8?B?bDFUdERCTVZhd0ZlOGdEdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VG9scU9nbWJiMEhEUDhlTWo3WkpPVGZKZ29YMXQ5R1RoS1MyYjFXQk9CZ1ZM?=
 =?utf-8?B?c3ZLWldPNGoweVFXekV3SHU3OUNWZXBMLytpZzhqRTlQYVhaRm9UMitlYXVR?=
 =?utf-8?B?S0J5M3p0MDRhbW1PNUpDTll4Uncxd0JnMDB5WWtKaitHK1pmeFRDRUwzWG14?=
 =?utf-8?B?OEdxaW5oNG0wcVZKaXZsZ25lTyt4SGFHQzlqWXY3WFFFTmpxTWlrV2VjR1pa?=
 =?utf-8?B?eWx4UmhzTUhnazk1VFBsc2VlYjVQZ1FBT2p5VU54WEJ5RzlLSi9GVENDeHJi?=
 =?utf-8?B?Uk5xT2dsaUZRbVExdGVhUTUvRXFFZ1BIZzdqL1JKK1NEUGpnTHEreXNaUmI2?=
 =?utf-8?B?MU5vSkhIWEVBN29RdUxWNHlRbnByYUxyRk56ZWt1MDJCME1zVGxQVmJDaS9Q?=
 =?utf-8?B?cFR1MkxzZC9CWk15cmRnc21Wa3pQakVVZitnQXBndkt4dURHZm4yYWtYeVZn?=
 =?utf-8?B?Um5YMUtNOHJEZC9CVnVFb2NGTkc5S3Yrdlo1YXU1MGdlSkhIbElzbzhoSkdJ?=
 =?utf-8?B?Vi9XNFJ2VHd4Ly9WcStNZU1kUjU2c0NkZGlFQ05mWWdldml4dTBpYS84azlC?=
 =?utf-8?B?djZIRC9kRE1mWFcyZlY4aC9UNUtpOEJOaklRQ041emltNWVkYmtZVGFqaUZ3?=
 =?utf-8?B?SjdZcS9GL3VwQ1RhQ1JSYzJYSUQvdjdTMUV6ZzN5K1gzbTdsVTc4R3E2dWox?=
 =?utf-8?B?aFh1MnBZa0ErYm40Mm1BLzEyaUJKZXg4anFmcnBldmNlNEN3dGFBTnNBZzBV?=
 =?utf-8?B?RndtNzlDRUQ3VXFiK1M2akFXNWVMQnA2UUJvUzR6MzRwdWRGTHpjemxEK3Bi?=
 =?utf-8?B?TDR4OW5pNkpVNlNTZ1grY2RWdVlZQXhRVDhKbXNLUElnRXMyVDVGaTlTb1Fl?=
 =?utf-8?B?WVZvblp2aU43WktseWRDN1MySE14UnJ5aGhXWjcvaG11RS9HWkR0Slk1SVRi?=
 =?utf-8?B?Z1B5elpBYjBNZmJIdlpXb0tNcFRPWEtjc1NwUXlsSDVlYVc5dFBETmRydUg0?=
 =?utf-8?B?OTIweENGdXMyNTdsVkxvRU9ZaUZVNDNjRVFtRnlpOFNHeFk4ZGVoeTFwZjZK?=
 =?utf-8?B?MEV0ZldhQUxBbVRaeURhOFZGMjZsNFVDejB4ZDZSOGw1cEFwQThlZ2VUb2tr?=
 =?utf-8?B?MmxPOFBXSGVCeldTY3VRbWx6d083MXpZOUorUlhyZG1VTGVOd01kMmRYVlRK?=
 =?utf-8?B?a0VSSEJTY1ZuNmV1QVpHMElvWEwrRWVkSXFaWnc3WWQ1NEk4bWFCdUJQWVRn?=
 =?utf-8?B?Y2lOYWVOYU0vcFM5TExVUjgxMUU2SC9hRjl0ekxxcnhjTlRBRVQzanZhelNE?=
 =?utf-8?B?Q3RyRTRHREt5ckh5SlNUbFIvS25Bd1BxQlhyUXhnQk5EMkJ1dG52bkI5ZndD?=
 =?utf-8?B?N1FUbHp3c3lXSVQvYU4rOEVBeWpDU1Ixd0R0MWZoNDF5WVFJcGhQK2RTYisx?=
 =?utf-8?B?RjRzdVpGUkcyRHVkajNCSzFiNHJTZWhUTkJtZjlJR291ckRzVkJUQzJuSjht?=
 =?utf-8?B?MVFYcEcwNGtTSFlYWm9oZ3EwaUN1VkVmTWwycG5FZ1pZR01obk14d0lBQzJ5?=
 =?utf-8?B?MkJNVVVPakJ3SWk2Q1dZLzN1R2dDQXplNEdKNzhuZkpnT2U1QURLOFBSS0ha?=
 =?utf-8?B?SlZVVnJwcDdBbDA4YjI2dGRLeTh1eGFGbmZmaERxTWVXbjE2c0FqcCtvMkl4?=
 =?utf-8?B?dXNjNmM4ei9NcWdPU3FCeFlWdkc5eFFWYms3RHZLZzI1THMxMnVyRDFzanpF?=
 =?utf-8?B?NG1PYTlqYjFRbXMyNS9BbHhDdEdHUFE3TTRDS0RUNHRIbHNMcytpZVZWWXFq?=
 =?utf-8?B?SDhBK3FpblhITDV0Nm1VTmRyM2ZRYkYzT3dWUHoyd1BOb2FtdFZYdjYzMERj?=
 =?utf-8?B?M1BScXVWWDJLa1dYVElGMGprTUJPN2JNdkhOT3RkaXFHUDFaTFFLV3hIQ3pN?=
 =?utf-8?B?ZUdHaWY4VVhYa1RqUWNZVDcxVFBWQmJadUZKNk12Y1V3ckRBOW1MbHc4cWZH?=
 =?utf-8?B?TklDQlNLajhITGJtKy81SmorQmVtQ3FYVkVoYmJYNFQrSWljaG1JYUxURHlJ?=
 =?utf-8?B?M3pJYWo2bDdNejdkWmNYZVc5QjMwTzdoclFjNkIxczgzSHhwellVby9udEpa?=
 =?utf-8?B?Zkk2VldqUDRzcXJYQXZoL3dUcnpSbEZweTR5S0tCODlLSXIwcFJHZFNCVDhI?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LeA8GawiKuwuZnHYtfEllSgX5y+sOxxuIHuZKiLjKMDpkcuAvv/tTq0IBXDQakHxEAcp7rWw6olAGpb1oIJT4ztBQls6EoJhSZ95A24G7dmSIwwAq1CbXh9FCea9kB9DIFJRgZKwA6oEIruW8W8z6/nARX0Eo6IaY/hSpXB3+2Zw9NJyPGK7cyeeCF72LW1XCVK+9JjcJH6wL4mpTvyTD7cZKdbKlfZrInJ9ZNKB4V2mAGVYaKpkfbQD1TOXqGOjzXzc3RHpKGwY6Q5L/M2z/XTUs4dZhVzT8fdBMigrJ1Jn5w1FljIulz6avta25taB47+pbgUiIvrJaz75VoAHfYmpyptKYif+iKV6Xiu8rMIgdM6y5XoH9uaLDIiDI+qFBlM1CLcgG6pbDPVvAt4C+CfItMLT7hlQlWk5thJ4BWPHPCM4rIep5bf0FGxQV/qgLiyg9+udnhMoWWdQ+WgfqWwYUI4+/KHgcySK6FSehBT+YG/NQIvs0mg6QS6AD6NHPn2zZ46z3fU4WyGP74hdbYObmCQT+Y1wrBQo+TWnuuIV7H77YyCv7PrbaEPhygSF1QZkyognJwkC4HBsta1dAelNS5xNEnd0xkkbhYSb6yA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7247e7-44c1-471f-eb94-08dcd7f1842d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 14:52:28.5363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJI79YL20K/JFhIv/jldCIGTVYbIRfKu1RdBZs456gZRl2kTkZoVDUqx8a6uXrrWIzVw8YBdM/GLPQwaWK6tijDGFB4B9zUXc54/QnxTdVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6825
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-18_10,2024-09-18_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409180096
X-Proofpoint-GUID: 0GPyUu-dkPwPjapPBlfHo-FjkUkG-Ob9
X-Proofpoint-ORIG-GUID: 0GPyUu-dkPwPjapPBlfHo-FjkUkG-Ob9

Hi Jason, Nicolin, any comment or RB on this before I submit V2?

- Steve

On 9/14/2024 9:05 AM, Steve Sistare wrote:
> The starting address in iopt_pages is currently a __user *uptr.  Generalize
> to allow other types of addresses.  Refactor iopt_alloc_pages and
> iopt_map_user_pages into address-type specific and common functions.
> 
> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   drivers/iommu/iommufd/io_pagetable.c | 60 +++++++++++++++++++++++-------------
>   drivers/iommu/iommufd/io_pagetable.h | 13 ++++++--
>   drivers/iommu/iommufd/pages.c        | 30 +++++++++++++-----
>   3 files changed, 71 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
> index 1c23a59..3f8f0de 100644
> --- a/drivers/iommu/iommufd/io_pagetable.c
> +++ b/drivers/iommu/iommufd/io_pagetable.c
> @@ -376,6 +376,38 @@ int iopt_map_pages(struct io_pagetable *iopt, struct list_head *pages_list,
>   	return rc;
>   }
>   
> +static int iopt_map_common(struct iommufd_ctx *ictx,
> +			   struct io_pagetable *iopt,
> +			   struct iopt_pages *pages,
> +			   unsigned long *iova,
> +			   unsigned long length,
> +			   unsigned long start_byte,
> +			   int iommu_prot,
> +			   unsigned int flags)
> +{
> +	struct iopt_pages_list elm = {};
> +	LIST_HEAD(pages_list);
> +	int rc;
> +
> +	elm.pages = pages;
> +	elm.start_byte = start_byte;
> +	if (ictx->account_mode == IOPT_PAGES_ACCOUNT_MM &&
> +	    elm.pages->account_mode == IOPT_PAGES_ACCOUNT_USER)
> +		elm.pages->account_mode = IOPT_PAGES_ACCOUNT_MM;
> +	elm.length = length;
> +	list_add(&elm.next, &pages_list);
> +
> +	rc = iopt_map_pages(iopt, &pages_list, length, iova, iommu_prot, flags);
> +	if (rc) {
> +		if (elm.area)
> +			iopt_abort_area(elm.area);
> +		if (elm.pages)
> +			iopt_put_pages(elm.pages);
> +		return rc;
> +	}
> +	return 0;
> +}
> +
>   /**
>    * iopt_map_user_pages() - Map a user VA to an iova in the io page table
>    * @ictx: iommufd_ctx the iopt is part of
> @@ -400,29 +432,15 @@ int iopt_map_user_pages(struct iommufd_ctx *ictx, struct io_pagetable *iopt,
>   			unsigned long length, int iommu_prot,
>   			unsigned int flags)
>   {
> -	struct iopt_pages_list elm = {};
> -	LIST_HEAD(pages_list);
> -	int rc;
> +	struct iopt_pages *pages;
>   
> -	elm.pages = iopt_alloc_pages(uptr, length, iommu_prot & IOMMU_WRITE);
> -	if (IS_ERR(elm.pages))
> -		return PTR_ERR(elm.pages);
> -	if (ictx->account_mode == IOPT_PAGES_ACCOUNT_MM &&
> -	    elm.pages->account_mode == IOPT_PAGES_ACCOUNT_USER)
> -		elm.pages->account_mode = IOPT_PAGES_ACCOUNT_MM;
> -	elm.start_byte = uptr - elm.pages->uptr;
> -	elm.length = length;
> -	list_add(&elm.next, &pages_list);
> +	pages = iopt_alloc_user_pages(uptr, length, iommu_prot & IOMMU_WRITE);
> +	if (IS_ERR(pages))
> +		return PTR_ERR(pages);
>   
> -	rc = iopt_map_pages(iopt, &pages_list, length, iova, iommu_prot, flags);
> -	if (rc) {
> -		if (elm.area)
> -			iopt_abort_area(elm.area);
> -		if (elm.pages)
> -			iopt_put_pages(elm.pages);
> -		return rc;
> -	}
> -	return 0;
> +	return iopt_map_common(ictx, iopt, pages, iova, length,
> +			       uptr - pages->uptr,
> +			       iommu_prot, flags);
>   }
>   
>   struct iova_bitmap_fn_arg {
> diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
> index 0ec3509..7c4a338 100644
> --- a/drivers/iommu/iommufd/io_pagetable.h
> +++ b/drivers/iommu/iommufd/io_pagetable.h
> @@ -175,6 +175,10 @@ enum {
>   	IOPT_PAGES_ACCOUNT_MM = 2,
>   };
>   
> +enum iopt_address_type {
> +	IOPT_ADDRESS_USER = 0,
> +};
> +
>   /*
>    * This holds a pinned page list for multiple areas of IO address space. The
>    * pages always originate from a linear chunk of userspace VA. Multiple
> @@ -195,7 +199,10 @@ struct iopt_pages {
>   	struct task_struct *source_task;
>   	struct mm_struct *source_mm;
>   	struct user_struct *source_user;
> -	void __user *uptr;
> +	enum iopt_address_type type;
> +	union {
> +		void __user *uptr;		/* IOPT_ADDRESS_USER */
> +	};
>   	bool writable:1;
>   	u8 account_mode;
>   
> @@ -206,8 +213,8 @@ struct iopt_pages {
>   	struct rb_root_cached domains_itree;
>   };
>   
> -struct iopt_pages *iopt_alloc_pages(void __user *uptr, unsigned long length,
> -				    bool writable);
> +struct iopt_pages *iopt_alloc_user_pages(void __user *uptr,
> +					 unsigned long length, bool writable);
>   void iopt_release_pages(struct kref *kref);
>   static inline void iopt_put_pages(struct iopt_pages *pages)
>   {
> diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
> index 117f644..69822d4 100644
> --- a/drivers/iommu/iommufd/pages.c
> +++ b/drivers/iommu/iommufd/pages.c
> @@ -1139,11 +1139,11 @@ static int pfn_reader_first(struct pfn_reader *pfns, struct iopt_pages *pages,
>   	return 0;
>   }
>   
> -struct iopt_pages *iopt_alloc_pages(void __user *uptr, unsigned long length,
> -				    bool writable)
> +static struct iopt_pages *iopt_alloc_pages(unsigned long length,
> +					   unsigned long start_byte,
> +					   bool writable)
>   {
>   	struct iopt_pages *pages;
> -	unsigned long end;
>   
>   	/*
>   	 * The iommu API uses size_t as the length, and protect the DIV_ROUND_UP
> @@ -1152,9 +1152,6 @@ struct iopt_pages *iopt_alloc_pages(void __user *uptr, unsigned long length,
>   	if (length > SIZE_MAX - PAGE_SIZE || length == 0)
>   		return ERR_PTR(-EINVAL);
>   
> -	if (check_add_overflow((unsigned long)uptr, length, &end))
> -		return ERR_PTR(-EOVERFLOW);
> -
>   	pages = kzalloc(sizeof(*pages), GFP_KERNEL_ACCOUNT);
>   	if (!pages)
>   		return ERR_PTR(-ENOMEM);
> @@ -1164,8 +1161,7 @@ struct iopt_pages *iopt_alloc_pages(void __user *uptr, unsigned long length,
>   	mutex_init(&pages->mutex);
>   	pages->source_mm = current->mm;
>   	mmgrab(pages->source_mm);
> -	pages->uptr = (void __user *)ALIGN_DOWN((uintptr_t)uptr, PAGE_SIZE);
> -	pages->npages = DIV_ROUND_UP(length + (uptr - pages->uptr), PAGE_SIZE);
> +	pages->npages = DIV_ROUND_UP(length + start_byte, PAGE_SIZE);
>   	pages->access_itree = RB_ROOT_CACHED;
>   	pages->domains_itree = RB_ROOT_CACHED;
>   	pages->writable = writable;
> @@ -1179,6 +1175,24 @@ struct iopt_pages *iopt_alloc_pages(void __user *uptr, unsigned long length,
>   	return pages;
>   }
>   
> +struct iopt_pages *iopt_alloc_user_pages(void __user *uptr,
> +					 unsigned long length, bool writable)
> +{
> +	struct iopt_pages *pages;
> +	unsigned long end;
> +	void __user *uptr_down = (void __user *) ALIGN_DOWN((uintptr_t)uptr, PAGE_SIZE);
> +
> +	if (check_add_overflow((unsigned long)uptr, length, &end))
> +		return ERR_PTR(-EOVERFLOW);
> +
> +	pages = iopt_alloc_pages(length, uptr - uptr_down, writable);
> +	if (IS_ERR(pages))
> +		return pages;
> +	pages->uptr = uptr_down;
> +	pages->type = IOPT_ADDRESS_USER;
> +	return pages;
> +}
> +
>   void iopt_release_pages(struct kref *kref)
>   {
>   	struct iopt_pages *pages = container_of(kref, struct iopt_pages, kref);
