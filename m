Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5AE14900E
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 17:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729274064; cv=fail; b=Ev4/WaBbr/CSsE++Ga5W2NJnLTS5IVxUe4ZjW5BHCXw9w6S2wN472di7PZ6OIbeX1iiWqy3/aNSSCn4/VUeBg/lvdWch/fUZUqfDBZoNM6pV46PewLIzjkZOaPMyazHgCyYX/Hlt6snDmn6pK+XIqJtnKCmYUPqKABakrH2zAzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729274064; c=relaxed/simple;
	bh=PmD87PPWxosxmvgFylX5rNomVYk4wV4T6OWrMebUmmo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gRAPvoNLV5S3Bv3v7IQddKzjWsX1gdklcQAYL/pxiQIJMFP4VJgIQ8SpIrEGyBsGLnhX5hv8CgrHoli/T77L/abJZCI6APIKZyRNaqmU4tHfIjz+02m+sQcwiMJFXnPHcTPQFG5p1uVTi4fJkWwgqu8mA850ktP+Y+32q4pfMAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dPjvrSZv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nlZwWzM/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dPjvrSZv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nlZwWzM/"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IEBcVC022541;
	Fri, 18 Oct 2024 17:54:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=9qi/SsYjne9kRoENXAL9lHha3121UKr0uS5mzhp8uto=; b=
	dPjvrSZvPCi8HNr+2vSG3XVPA2dlsS/7C5r1q3KDGYrqdBzzr2h+Vx/D4S33Lgaz
	59ELTDYPfzUWHtCSbjz+6o4y3vOkwyAZkNCfkT4YzfmjiBxvWEpgUp7l33RDTC6X
	UV3oUW6zaAnX6R04s0ZKQRq0lwlPkLK8EIrKs2M8CronXSpCnwqb94rfON+g6VIi
	g0Pf5L3wbrnezUXnXR/BBvppmCYrJ0YHIEXe8/lEd+dI3nPbc5BD4Q1LEdyivGr0
	4Z+R5jE92PKB4Mkyk0OC4rODbaHaXGfxbMBQz32jieU6BefWFodPkySCNiyMTr6Y
	fLTq4PdSPo1EWj6cTrbyEA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fw2sjak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 17:54:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49IHUV6U026232;
	Fri, 18 Oct 2024 17:54:17 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjbw79g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 17:54:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6zlwmkV6bevf/m3811Jg1f20POXcae/XSUqUmf/JGUfYHGAvFOZYy2icBi8bISivcDoqXxmKSzY3kj7n8MiDVMRTAdnYIq0LWP8BIX29dsBl1NSq1WvWc89JPed0ag+l3th+RiL9/uq7ferEwN6Ak6hCP95g54t8jrcqZvCzNgbmgRmlSS+FkygiV3tzAR2OjRA/YJBiTe02PU0DTGq6GNmj8iBD3c/mF2l1xinobbBZeeI/KeicWEHgYhXan3dG9nFbhlFrnVsqlhcqrU93FDVQQj0NGDq6yGg1DZQRNMFIoW/+2yyyuVM432XUK/PqjqdXvDzU+FKGvz2ErfccQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qi/SsYjne9kRoENXAL9lHha3121UKr0uS5mzhp8uto=;
 b=o+J+GsR6I28IOLDEQKxmT1wGaCHhoR1ngdtlmP78QXgZVqeb0RTvZJ/vXpU/ZDmQ4Psq1jl63TUT/9q/tWupuRtbrQRnWAZskcJzA0x4a2gnWBZ+x46V/Cjc+F952g7Eu+jtN0UpYYPwq/nMxv4F9UuQ1g9p7XXfDxs4vNgephnnznUfRCYhlY2g1uvmEmmWbKIMvaGL7qKl9GMnA34d3qVjamLFk29L37Yw3DfmKxhsyg0QNMYGSGcb0snp4zF+avf6NQdagkmH6Q3rNt4bV2l/LiyRCzl94Qu68Ugjv2F8i4RgE99zyH9alcxbj/USfp+LCEwqd4klGRvl497rHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qi/SsYjne9kRoENXAL9lHha3121UKr0uS5mzhp8uto=;
 b=nlZwWzM/widlMTSYFTzH63pwzWxLPDnCWU50wghcjPyTv0zu4t6aJLcbpEhf7Ba8h1XXCmaoKHYOL8TBS4KqeSgj7zCEVw5VTxBEc9bc6dxuD0GGAbwoNwfOr75l4GnN47cBu8lilY8wh9oy3G3nYVjEhbFsXWRrb/nzhBxMd9g=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CO1PR10MB4676.namprd10.prod.outlook.com (2603:10b6:303:9e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24; Fri, 18 Oct
 2024 17:54:15 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 17:54:15 +0000
Message-ID: <dc59dc36-027f-42c1-971a-8218c658c5a0@oracle.com>
Date: Fri, 18 Oct 2024 13:54:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 8/9] iommufd: optimize file mapping
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
References: <1728067700-32092-1-git-send-email-steven.sistare@oracle.com>
 <1728067700-32092-9-git-send-email-steven.sistare@oracle.com>
 <20241016130001.GI3559746@nvidia.com>
 <6fdad0c2-8b6a-433e-9405-016aaee40413@oracle.com>
 <20241017192418.GD3559746@nvidia.com>
 <c4574487-346a-427e-a97d-6e1ee366ed1a@oracle.com>
 <20241018001046.GF3559746@nvidia.com>
 <279c7e80-1d72-407e-bfb8-d286760a5e11@oracle.com>
 <20241018160430.GJ3559746@nvidia.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241018160430.GJ3559746@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0218.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::13) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CO1PR10MB4676:EE_
X-MS-Office365-Filtering-Correlation-Id: d6ba5599-33bc-4be5-3ece-08dcef9de143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkhXTm1wNEcxLzhPV1ZxaDRuMjJNWWZUcUlMM3pLbmhrK0Iva2FYUmdCNitS?=
 =?utf-8?B?cUh2VmtKOVE3SFMvYWJyWFZnK0ZPeVEzTTFYNzFtTFpXcVN3dWtpc2luUGFw?=
 =?utf-8?B?Tk5TdXBUK1A0UUJHQXJWaWRnR2J3SGhxRTRPYUJrTUZJWjZjQTlaT3dyblZy?=
 =?utf-8?B?QVFZaHhxR0E3UjI3MkcxZ1BEdEVyb1VncG1ZUVhLVmR4K3o4dlZIVzFSZjlS?=
 =?utf-8?B?S0cyZmhZRDdsYnhxa0JyR2hoRXNYZWhYRkpuK25QeDR2c0kxS0l3VVpOWjEr?=
 =?utf-8?B?YnZRUW5SQjVPYy9scDNNMWhkaWhFQ1I0clg3clZaV3RpQ1VFczFxeTVoQm1D?=
 =?utf-8?B?VGpuZjV1dzBPd3Jvb0phZC9ldDlXbjRZeUNvSVJyZHd0VW1Ia3RmVStBR2pT?=
 =?utf-8?B?RWhLZzVNWUVvUG9MTHQvNmpORllzRUNBNWM0VmNCTTUzSTgrbk1xVXJhcnBG?=
 =?utf-8?B?OUdNbUtmSFZkOEhhMEJrbEdVcHY5aHppbFVWOE5aa0tEWXhndS9JV3kyY1RC?=
 =?utf-8?B?Q28zcTBPbktVU1hNRHNwRGJUSkNoYit2R0x5SjNJeVJJYVhEQnFWUlRPR1VN?=
 =?utf-8?B?OE9Qam9UeitVUDRPVS9GMDl5MXZPanIxeUVNVVlMRFRIdXpjNWZSdTNGSmh0?=
 =?utf-8?B?NW03bDhrQ3NMcU9kNUVRQUZvcERrOGk4ek8zYW85T2hMV3d4bVoyTjllSHNl?=
 =?utf-8?B?U1NPQVFxaXBaNDdWY2gzREc2Y05rbzBlK3FzdVBHZFB1M2dYeHNVMW9tV1ZD?=
 =?utf-8?B?czlJMVFCTTU1a2FwdC9SOEx6czU1NVFjbXBIam1YSmE1aHI5WWdHUUYwVW5L?=
 =?utf-8?B?ZnlFVWdPbGtycFJSSXA2QUpHRTUwZUx6YmNTdVMybnRoeFplay9GcDZoN1pL?=
 =?utf-8?B?L3d3bFhuOEpIUXdKL2t6Z2FtK3ZxZ3hzbkpNdFZqMFdIVS80V0JBRERyVS9S?=
 =?utf-8?B?aTkwR2EvMnVzdUhiTzhadmFSMkJOOVQxTFd2d29NZWxFaXZtNUlpOUp5bkdn?=
 =?utf-8?B?SFhCOHpjK2tZbWNBV3IxL0xCU2daT2x6NjBZRFJCRTdTZFFHOTRkaVErVjVY?=
 =?utf-8?B?eXJteW41eGNHRU53SldSU0M3VkF5S2oyQUM3Q3dXZVBtT0pVUDNFOWg2Y2xM?=
 =?utf-8?B?OHpEbnN1ZXJWYng1NGZ1L1NMaVdDNkpPUDZFRjlEUnZGZCtVakFlZFFpT3dC?=
 =?utf-8?B?a3ZHTnFFSnVmbTUrbHIwMWVCRDVYdHI0T2hnNHpwY1R2NnJXSjZkbk5wVCtF?=
 =?utf-8?B?YzRqRFpwVVBjSXkvVm5ZSzJtbW8wVlBFcU4xZnk5MkgrOHYzaWlpRDNlWU13?=
 =?utf-8?B?VjBwUEZSd21pSnZtcnc2aGd1WkRpdVEyQjFGY0xqL0pPUHdGblR2Tk4yZktz?=
 =?utf-8?B?alB4WExWR1NNbi82R2VXckQ3dkFlYkNxcEhmUGxybUwvSUloMTFLTTN2am5R?=
 =?utf-8?B?WEJGWjg1Q2tmQnpwNEZiZlFjV0NCSWRGcDU4UFI4TXJxdStxNXk5SFVRVWlZ?=
 =?utf-8?B?dk5lQ1JxR3lQRThiLzJZVG5Fa2ZITlFyVmJleDBuS0dQbjBJMFBqcjFWSXgy?=
 =?utf-8?B?QUNON3Y2YlNUaGdyWHo2SFMzc1luU1I2aTFScTlwdjhSR01HMjc4R1hHQ0JH?=
 =?utf-8?B?d1ZnYXEyUXVuOTVjeGJ3aDFjMklEWjhRZkoxWURzUURoN3VRSW1YRlpKb1Vq?=
 =?utf-8?B?M2hQQk8xUE93M2dGOUpoUDFpdDRRR0F3ZDR5NkkwN0NBbWViTkpJZW0zZXNC?=
 =?utf-8?Q?rRIZFDY29fZW7nIGT0AseyEU1Wexd0Ervh8s4W7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajFmMUI5QWVxUy9MKzg4aHFYRC9jVXU0bkJSZjV6dHI5cWVkN013Z1E4eUM4?=
 =?utf-8?B?NHRsRnBDd3pqbGg2YmlBZzE1Zlg5TGpJamdkK2tvZDNBMnluWTZlOFkvZytE?=
 =?utf-8?B?Um1jTjdjWFN3b3pvbW5GQXB5blpJenIvMUQwN29vc2pKVlB6N1Qxd0NYQ1Zt?=
 =?utf-8?B?Ry96T2ZGZWs1UnV4dlpSQW9wV2g3SHVacmw3TTJFVTV6T3JrSEJER3ppK21s?=
 =?utf-8?B?cGk0QjRtM2NnWTl4a2V6Z2NTbjR0emhVcnhNTWI3YUk2SnI0Y05XbzRqTEtM?=
 =?utf-8?B?UVVuZ0hNU0pvUXg5L1lEcHJHMmVVaFh5azYwWE5qa1UraEMzVllBeVIrNTNw?=
 =?utf-8?B?dVJNZVp1UTJrWHJUbGJZWTViczk4MTZFRW9QalE3RnhaK2FMRytTUEV4S2FD?=
 =?utf-8?B?cHJ2U21wS3hFVmtWTUpuNUhoV1Nyek5sUUs1YnUzYVFKYzMxdTZYRDc4R1h6?=
 =?utf-8?B?MFM3MDVvdkdqRXNDNXdBeUtBTkJWYUlPME5zeUZnd1F1ZmlRbVd1UitraWM3?=
 =?utf-8?B?VWkzSnlqaXRtdTRENVRwdlBrNmJockZ3dis1UlMvSFJMMU83UDkvZml2MytL?=
 =?utf-8?B?ZkhiQ3Z1M055UmkxNXhsSGlHeDVDMm1FQVRPZ2ZlYkNrZis0Sk1mdTVFNEZG?=
 =?utf-8?B?ck1zNktMaWFOTWc0anNKcmkrK2VjRnptL2JBcWJpcTRmaGU3dEZZMUREWWY1?=
 =?utf-8?B?bnI2aURsYzJGYU93cGVwcGNUdFRtWGJxQmVUaFlvMU5SVnp4NDVhL2dKc1dZ?=
 =?utf-8?B?SjVwU2ZYTEpTYmtacG5aNkFFa0xRUEJXbndNTTN0NmR3SjY5MmxqRlZmV3Zl?=
 =?utf-8?B?djBjb0J4K09waUpXaHFpZzNpV29JdmwrWlh1aE1waUxmWWYzYTZ6WjJIVjl2?=
 =?utf-8?B?eFA2Z3pUZ25WWWYxWksxbjlKU2lWZGlvZS8wWEIrWHRjTkg2QTBDZy9YbHJv?=
 =?utf-8?B?NS9pL2hPQUtBR1VycnFtQWs4YmVTUTdGdDRDYmF2ekowNStFMVNJcjc4TGps?=
 =?utf-8?B?QU1acjdHSThDL2czTlc5SlFTaUFVVUFuaDlZQ2FQWEZuUUtnakJITzVTdjVz?=
 =?utf-8?B?bCt6R3NIRUhTcXk4bENKYVFDUFNGcnZoNE5vc3IwNkZwQlRNUGpnSzlHQWty?=
 =?utf-8?B?SjBWbGppR0xBMEJDcHlZTTNOTE5MSWlPeUpDTnhIUWM0WW5lWG1JVmw5RjRN?=
 =?utf-8?B?VlRCUno0eFFQUVVRdHVwbGNLcUFNOC9sYXFqT3grUjBmblRUUU5oMVdQNmRL?=
 =?utf-8?B?UTMxUHhiS1ZTekxwT2VjNVNYbTNJR1JQVGRWemFJSFI3UDl2TlYwdnVqTjRK?=
 =?utf-8?B?SlNWbDUxV0hzOWtxOThnaVF5RHh5RmliN2NseCszVDl5QTRjSHpoS2Zqb2tC?=
 =?utf-8?B?MmtlMnpyQm94bTR5RFlXNFBZaEQ2bklpck50RDZhMEZiclJmdTJSemNib2sv?=
 =?utf-8?B?UXR5Qk1WbkphMm5YenFHS0xDRjBzYVh1Ymt3MGJYalJobWF1WS9KbDlBMDlD?=
 =?utf-8?B?cTViYUxoMWI5N2dVWXJBUlVaZ0Fkb281SVplT1AxNzVNR3VQdWZ3YlpWelF0?=
 =?utf-8?B?WndsdXhjeGJJWEViV1FUQWorNVhXQ1MvaHhqcFExeis3M0JMWjhudTRnaHRi?=
 =?utf-8?B?UkMxdExlSXZDYzhYZ1pFVnFoaDdFR25rLzNFYXdHWG1LU205RUFZcWE4WVpj?=
 =?utf-8?B?eTJWYUU1VGdjN05vVHlxL1Z3TTBvYWpoVkZ2NzdJOE9zLzBtV1NTTzRXL1ZX?=
 =?utf-8?B?cUxNRnJzRHpaeHNNMG4zK0JXWjZmaWtpWWZLa1hHYjJRYWwzR09JTGpHMHM0?=
 =?utf-8?B?eVl5K2oyRVI0Z2x0bUpFM0RrUlc2UGhoQlRTMjdHMUZVbm9UWWlhU0NzREZX?=
 =?utf-8?B?aktpQmFZcVFDUVlwaVJ0YWdCNGFmWkJ3Sm9wUFc5bjNVN25oU1hRMy9HOUdJ?=
 =?utf-8?B?QW0rOG8rWGdRbFM3L1VkRHlIQ2VzRCtxMzRVQUFtcmVndm1BTGNNaVRFZjRT?=
 =?utf-8?B?NXFjNmRTRVVFTmV1d2pVSEhiYVVmdkRWeThFKzNhN1duTW1pL214YkJ0OWJ2?=
 =?utf-8?B?TjR6cEJQWEVKL1JSWWVVWUp2UkUzR0hjd2pGeVh0T1dUYUdQSC9XZDFKZ2FW?=
 =?utf-8?B?ODlyQThrSDRXZno3Wi8ybE5MVERTOVZjMGx1TkRiUllISkhTa2t4UE1lWkZo?=
 =?utf-8?B?aGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	b52D3aBElxGCNz6IkT0zHFa3tJKfZo5sGKLqM88Antnrx/WyWA699NAwoe5dgm1UjlVpAQuyDkoUQq4s/Uvhj80v89BzK08lW+VQ4chLrPD/BfePeRlMiEioWI4Khvw+WsW+ppLZ0Hjb/FEHtPnuM59+QN6puxcThnuIYtJeTo2l7DF+R3IDg7rqGV6/6Gw0tchdW8ALRl/03B7FoAffeQ3dicCw1tST2f6/oqO/pOG1Y+bjRi4P09IB2lJ9TRH3BOJuzFOIwZuirM8QuqeUHMKxAOZ4cdVgaSzyRP2zUeku8FXnscpLX1tcnugYLMayvIjxKuzZ2cCSOKfDAAPcQaN6jc2rO+yNGRHZCzni2UG53QkMkqmfho68NcdcOxy7PHllcrRKZgfXK10Yf0wQjjYD/qgEGKKdOmblyOvCnpi3CGpJjY4uzIhW1o6gsGxNRJgZtauV3jctBsllsN3dVeDIXsrhauzk3oYyU6Gjedz/pLari6AxJgu175k0crpuDsk7Xc1xC+JxvdzgKpwTrxneYe8uojYkPGYzPxQio+p9etplspJZiLm7XZo/7XPPEbDwsT5cf0H6R0zGmYS1O6Kh2um6IyP0uidUt9GKWAU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ba5599-33bc-4be5-3ece-08dcef9de143
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 17:54:15.0045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F8JoG/urR8rsQUtbJbS3k08B+pJvoMHueqeIxaPxFir/Apm/HVVJD4DkWsd9OhGopwXsxg6Yi6Iv6yfObv//yi+9+v27XwzGRLDLqFV634o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4676
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_13,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=805 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410180114
X-Proofpoint-GUID: tl-Io13b3ByYPF8WfOk8N8uRobrhV4hV
X-Proofpoint-ORIG-GUID: tl-Io13b3ByYPF8WfOk8N8uRobrhV4hV

On 10/18/2024 12:04 PM, Jason Gunthorpe wrote:
> On Fri, Oct 18, 2024 at 10:34:39AM -0400, Steven Sistare wrote:
>>> Ie instead of things like:
>>>
>>> 		batch_from_folios_huge(&pfns->batch, &user->ufolios_next,
>>> 				       &user->ufolios_offset, npages);
>>>
>>> Where npages is the total number of pages inside the folio list, it
>>> would be nfolios.
>>
>> The problem is that a batch may reach capacity after accepting only part
>> of a folio, a condition I forced in testing by reducing array_size and
>> MAX_NPFNS. We need to track which folio is partial and what is the next index
>> to use in the folio.  That is ufolios_next and ufolios_offset.
> 
> But why is that such a problem? The ufolios_offset already handles a
> partial folio.
> 
> If the batch fills you leave ufolios_next alone and adjust
> ufolios_offset. The next iteration does exactly the same as the first
> iteration and takes the partial folio.
> 
> The refcount has to be handled carefully as the the portion that has
> been put in the batch needs to be refcounted at 4k and the remainder
> remain a single ref, but that just means adjusting the refcount after
> putting it in the batch.
> 
> It seems like it just works naturally and avoids the double loop

Yes, I can squash the nested loop in batch_from_folios_huge.  (I was off
point because I thought you were suggesting something else).

Do you want me to delete ufolios_huge and its special cases?

- Steve

