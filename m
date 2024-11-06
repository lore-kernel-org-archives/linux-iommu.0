Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5680628EF
	for <iommu@lists.linux.dev>; Wed,  6 Nov 2024 18:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730919340; cv=fail; b=ZwQlyG8Pn5H0D7CyxDXtMBJ90UWg5oV7F09N/BCF13ucBvL+tv8t5O6N7/lpXh34j0ZSyIfBcw9ATeeCdAduQVxpkWCvx+dETPJ/xhlqL2v2+hf72r5vQTlAW2HQuOUZiT4MjGPCilL6Bsrf5+DE77u3cLLou0NB/4IurUceVT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730919340; c=relaxed/simple;
	bh=irDgWyW62Q8kOQNqlfoHYtThHdUtHteQorXtFIrJZwg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G6TTEzygD+853daltp80QWzGqx8kqtyHhIiawDvAONkQDCuqgbX7lDexmPg5Q5CoLt/1iZLjLdqFADhOwi2KsSOG3pjQuyrPa9ScJxsySvYKdglkRrchy/m1ENCWP7cuM00OqiO+BTLCpkM3ONM19yPFSPRG2EIBIm4F6vdUtPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZnXpWZWb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cMUEJzZ4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZnXpWZWb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cMUEJzZ4"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6ItZmo018338;
	Wed, 6 Nov 2024 18:55:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=CCKw1vhSBH4AoMp9g1xSrx3/DHIPlACZEKMw1DY1UMc=; b=
	ZnXpWZWbSIesC7s/Ppn9aUq95Q176OWi7lZ2sZEruXjMXLezjplC9oYgQivuszy1
	3uAb+Q22cUIwl/Eo5QAHdl99FMs4+3azvG0JKruik2TSATTnPIyKZYln3/Fygx4C
	GERdSNwHm0nXsG2ml8Afea6wmC7fVQ6zsgJ5ENkXVNp4qh7ilsbq6uyISh6Wr99J
	uUFcfqEEbnPbuCPFqOZF7EuC9x/X9lqz5X5SgZa1CZkqALm2DkQ6vOCjOXnRpP3M
	2Nlg/OylaBXTLLOhoNntpXhq3EUFyDJbcD3+pDIfmj8nc5yX/q0kL+xYr6C+MH1q
	v8jYMMzD21VJORFPkjIKRQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nap00vb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 18:55:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6I6iZW004990;
	Wed, 6 Nov 2024 18:55:36 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42p87cbfyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 18:55:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hvzUZx6ShYfJfWxQEXZuiaxi9JzqeaM+aFvapzcFaTi1FmQhjjxRuqhHApSs1o61dBhQFF6M2OLo7wimurroJWVAriuAQc8XK2P0If8WGTl/MX0rc+tojFAEszPT4L0w5bXBowmhuglVIQ9wU7pRq4XjwRDj8wd19aLu8gNyqTB7qPjKNVi4ou1ps4+9n2X9dkVbg4nEaXaxImS5xLRt4JePKVaVbJ3DOhgyWHqDUgvmLfhF1jhir5oBXJhzFt4kfQc1yRVvoo4t73tNwJSOJWkFgfJT1k24P2bw9cZKADt64E9xMxakYs+mNntok2kt7w0xCOvPmWyzTmh32VvDlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCKw1vhSBH4AoMp9g1xSrx3/DHIPlACZEKMw1DY1UMc=;
 b=YhXdgxCGP1PZgPqT+L2cIKwKTthtcAcpFdZqRq1Bz1honxXruIQbFwzT6L4W4XW5KZLbXqo63n87XamBAqwweAwLkwN/sZYVtT+0UcPNqSE67idAqedgFEi1AnU07T0VB+xUaYsvrMJ1nsuHDtd/POjA0y1MesSTgIHS7YpPLpoVYIVZBmBykb5wvgID0gAkCvs+BbarWCEbMVbHgIVlEUivf13uuG2IEQFooDlfpzveSxYE02xa2Jjmvr7Yb4V9Lf2geBsQ4tK59Eg8rC4wo9qazZpSZcJE7fWyIJtLLH365NemRC8CCp7dVnZK0h727ekwyRMtGeWMfd68/MjI4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCKw1vhSBH4AoMp9g1xSrx3/DHIPlACZEKMw1DY1UMc=;
 b=cMUEJzZ4z5/Axdu+ZxgTd9a0r6ZHUYxvlzDYCri3xgEy3uwXQQMZ8B7BpabLELRdzD3iBR88F1xr5jOUexKY7qQBibhzN5fEVDlho74LTiJdhULPJdnZw+Om95BX3guB4bxDuDhmYPPnYdI439Gvpb/1HmENQh+SbmWG9dbZAQY=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SJ0PR10MB4590.namprd10.prod.outlook.com (2603:10b6:a03:2d1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.32; Wed, 6 Nov
 2024 18:55:34 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 18:55:33 +0000
Message-ID: <02ae7346-63e6-4f88-99a0-6ca182589f75@oracle.com>
Date: Wed, 6 Nov 2024 13:55:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 3/4] iommufd: Add IOMMU_IOAS_CHANGE_PROCESS
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
References: <1728321203-189608-1-git-send-email-steven.sistare@oracle.com>
 <1728321203-189608-4-git-send-email-steven.sistare@oracle.com>
 <20241106180829.GB520535@nvidia.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <20241106180829.GB520535@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0060.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::35) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SJ0PR10MB4590:EE_
X-MS-Office365-Filtering-Correlation-Id: 61ed9f57-0df0-4d8c-456c-08dcfe9497e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkNkbjFWUHhBLzc5Z2dEcFU5eloxM0QzbVp6NHQ0L1lJNlRydERCMk00ZUlQ?=
 =?utf-8?B?S0tSdzhPU1VwMnYwUkZ2b29QVUlYK3lmdnM0RHlUbGQ0QWdnSlJWTTcwMG12?=
 =?utf-8?B?bjF3ZE1aVmVrWmRWUmVyMW1JckYzelhJMyt5UkxVaHdkSVRqWWFWd200SWVW?=
 =?utf-8?B?cmZzV0oyUEhiNzZrSUp0QURjMjR3Mzg3b3VJTkdGZWdUb2NrcXlXM01zWDB0?=
 =?utf-8?B?V05ISUI2OEtVbCtzYmRpTHpCaXJtMjJZaUtWampyVWpwczdhTWFSK2xqaUgw?=
 =?utf-8?B?eW12TzVUZnJPME5lcTlLUzhpSkRkMituUTRPR3pLUzM1UHI3NExLUG1oT3Fl?=
 =?utf-8?B?dzZpME9DVURWY0lVU2pVcUJNQmhreWE4SGJWRWRXRHVrZGtpRlJRa2ZUMWxy?=
 =?utf-8?B?Tlc0TmZ1b29XR2J0Qk05WnNHbFlhNDNtSU9Ddm9WbUxsUTBaM0lkRzBMVFZq?=
 =?utf-8?B?T2xOamgwTU5Hb2ppUEdYS09PdDRqN1JCdTl4R2ZjSjFTNExWVTgxRlA3RXVt?=
 =?utf-8?B?Y3JTOEo2NVNXVkdMMVZyNEx1VFBnQVBMTXcvQ2RudmpvU2IwSjJRb3l0ZGlh?=
 =?utf-8?B?NGxKVElWSy8zZ3pRbkVjUXZ6RDVjVkpsSSs4bFpJeFJ5U1FDeERJcHJsRDkv?=
 =?utf-8?B?OWlwdGZFVWo0cFFKNExlUGQxaWhoRWZtUkQyamgwaWplWVo2Ym12ejJrM0x3?=
 =?utf-8?B?K1lPSGU4WXpYZkM0b0lOU1EweGVQc2VGd29GaHJCTjR6VTRvREdFSjh2RE9V?=
 =?utf-8?B?M2R6Q0VnbllicW10dkVuZVNvdkpjbGk0NHZOckUwSDlVRHYvWk9mSXNpVk1G?=
 =?utf-8?B?R0hVaXB2ZUhySVJMNHdkOHZvdHRtWWF5R1ZMNy9PNDlJTXhIK3V5MlJoZkYy?=
 =?utf-8?B?MWV1dDZVRkowNWIwNy91R2dtZXlRRGVPa1lvSHNxL3BIZ3lCRlFCZmY3M3pT?=
 =?utf-8?B?anFhUFdWbDExYjVFSGYzeXpCbXFQK0t0M2ZBMG5tbmVYeFp2UVQwT3RVMUMr?=
 =?utf-8?B?Q3BrS0ZITUFRb25OaHR5RHRtSDVJeWpuZytrNFBENXFkVjF2RndkdEJyaEw0?=
 =?utf-8?B?VllJdWNlMUsyTkFqS1FNcGZ2OU9wc0xwNm1mZjFWNktDMklJY2E1NStUUy9k?=
 =?utf-8?B?ZnlOZ2xLL0hBaXVJZ0gwaTBoVzVqSEVnWXBud29BTEUrMU1EeGZvV2xtOTkr?=
 =?utf-8?B?Y3ZXRTB1U0I5ak01djFFcThFQzBWdi81cXpDSU5aaDQwRklXcjl4V2ZXMWRr?=
 =?utf-8?B?ZEh0K25yQWJZWnFzRjlBU0FqdjhvODlzMHNHRWdyRDByeDAySnk0WHFjNGVh?=
 =?utf-8?B?TGQvcCtpMWZLZTFOTU53WWpmWkhxQlQ5R0pWZHdmUmQxaXBHNWpWUHNuazNU?=
 =?utf-8?B?M0s2cXN3NmtFREk2SjROelk2VW9mUEsrTmFMa1lCd2dyQUJxdjVXYjdCUWhS?=
 =?utf-8?B?T1RsU1I0czE5UEt0ZW5qNGxvQk5FeThLS3p6aVFhZ2cxWWFPSmVjZ1NaM1Zh?=
 =?utf-8?B?SURnYm5GeXorVmVrd1pUeVlaZkNRK0JlY2FBcjRuY0Z2bkNSTU5kQjV2Ym5M?=
 =?utf-8?B?bWpRMC9xdmhCcTFrNStJVHFHTlArOHlvUlJYdmZ5TUp4NVdJcHNaZDBXZmg5?=
 =?utf-8?B?RnVUMWdXU0U0V3V6Q0ZLWW1ybzZJOVplaDc1dTlsSVhkNlpjbTNFRExVZlpK?=
 =?utf-8?B?NnY4VHVMb1hKRDhkU2YxamtJSTRnUHdGWklVODczUEhkbFlFbitHdkVrcFNL?=
 =?utf-8?Q?ZHrSzwWO6bFpuW0b9JIKWtWBpD1MWGgbsc0yG7O?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnpxMDBhd0F1c3FoUE5mRlJ5UXB0OElCaTZXNFk3bUxldE5CeXdnZm1UM09k?=
 =?utf-8?B?WU5Wcko3M2ZSZ0U4dWJaR1VUV0UzUWtvM3EwM1MrWEVEeFZyTktQbDBCemFv?=
 =?utf-8?B?aDZNSE9WcS82WnM4V1ZtVjdPZmNTUnl3Q1lndjA0Ni9PVE80L0tqOUdQSVkw?=
 =?utf-8?B?R0ZmSk1SbGdYOVF2anpETVJtZEFibUtZRXYrZDUrYUNzTkNUdjJDOHE0QnlZ?=
 =?utf-8?B?aG5WK2pYam1VSUE0WGhYVE14dUlJYWdsdjY5Mk1Xa3BYREkzMTdpN3hUY0o1?=
 =?utf-8?B?NWtqYVFvR280aUlQbS9MMnpmWkcrWTFaR3FuY3oyU0hVUnJvR05LUGR2R1NF?=
 =?utf-8?B?V3JwK0hvcUxESzBidWMzcUQzZzBURzB3TVJkdXNJVlExUVZBQkVLZmlsNGVK?=
 =?utf-8?B?clRJYlVGemthcXUxbjFFSEtLeWQ2dnpiMGNldTZSRTlUekYyRjdQSTRxc25i?=
 =?utf-8?B?eTNzUXVacjFYT1BmWHFVcDJuWEtnSEQyM2ZuOU4xN2hWMVFsQlRUdVhuNE9j?=
 =?utf-8?B?MHNIcjhoM3lGR0s3bFdnNjcvWUI5bVJUVlN2RXBuekZtQVJTNnFOcUk0ZG1M?=
 =?utf-8?B?MWUwSkJCL3QvMEM3ek9LODdYZGcwKy9oelJydGNJeFNObVJwcnhjNTB5VGlF?=
 =?utf-8?B?UnJTYjVDWFNvdGRyaUFDaHI1bWNjbEMweVVwNFBDM0hCNXQ5OTRyMnNHZnBR?=
 =?utf-8?B?cWRwVXVUaG1wQ1ZuSlo5QkZhd1JXWmtTL2tuT2RKNHQrZmVJcEN1c1dpMEhH?=
 =?utf-8?B?azNMSmxUeGNBc242aTFuVmtZUk50TTh6TmNXbGZacDVLbG5VNnpyZE9vcHI5?=
 =?utf-8?B?WjlFNkdGSlJENDI3TzJOTE1SSHY1OFBrY2lmMkpaUnFxanNWVUEwT1NJMGE0?=
 =?utf-8?B?VGhzdjRMZGwxdEkvZmI0ZU1tWkU5MlRIa2dEdkhmNDEzMHFKZlRXa2hmVGFh?=
 =?utf-8?B?N3dZeUFzd2dCNm9KVlUrb3ovTUxnd21BYWdzUE8vM241TmNIS0dpNW1TdWVq?=
 =?utf-8?B?akkxN3NnQkxoQncwVHh2bURaNzZ1TGF4VktaRjZlekNzeXJIcmd0ckxqNUZk?=
 =?utf-8?B?YW1TblA5dU1OT3M1b1d0S0xnRzZjSVdLQ1FISk01V3YzcjI4MndObzFwMzN3?=
 =?utf-8?B?UFZBUW9GbzFkbmJoQUI3ZG5VbTdnWGgwaW9KcnluV3BrZkdtL0M4NVpSOUpP?=
 =?utf-8?B?QXIxWDBqYkpucmJJY2hmUElwdDZYcTZEeWEzcEhEbFNyWDRtQTBOd2lWOVp4?=
 =?utf-8?B?a0xPa2cwamhuYklwTWRNZXp0cURaUnRFakZzajZwekRONTY5eFFldm5yWkpn?=
 =?utf-8?B?VTlVVk1tdjBjWG9kaThyRDhJWlRvbWdBMlBqTkFxQ0ZUUm9LR3k5TExYUHpa?=
 =?utf-8?B?NXNUcHN2cndtYkZkTWZTMWZvVWgwWTZZbU1peEM0OStoTGs1MFFRbml1dmF0?=
 =?utf-8?B?cDVkSHpTSWp6ZHozU0JITmk1SEVCT0dPbzNUZmhoeGJxWXBaOWZGaktUelJu?=
 =?utf-8?B?YjBCT1ZUa2wzc2FJbzkzMUlCbi9Sd2xZcmZaQ0tEcys3TGZ6dFp2VWFGcU41?=
 =?utf-8?B?SlV0V3ZQeDd3NWk3YU45WjlrLyt4NnE3dzlUTEJ0QkJ0RE1IMXF3Q2pYd2c2?=
 =?utf-8?B?ekhvUFdYeGgxMWNDY1FQUkdkVVppSExqWFZKM1NQZkRqYW9BTFp2ZDlEbFBl?=
 =?utf-8?B?dWU2enc4MlZSeU9DNjh3dFJuNUhqeGp6TTZkVnRjNzlDUkZSZXpCY1dsL1Na?=
 =?utf-8?B?Y2xoSWdld2pSb0VuQjFzNlNxT3RNK1pVSUlqbmVQeTZKQTA0WWFyak92dGFY?=
 =?utf-8?B?NVJnOFBzbzBQSXFSbzN2SXpzdEFGK2NER0RUbkd1WCtKOU45QlVpMjN0UEk0?=
 =?utf-8?B?bzBoRFpDZjY5Um9xSXFsYnV2dUlmQ0V4OVNpaS9KZTlITXk1WnZmdlZaZTVT?=
 =?utf-8?B?a3luY2xWMVpRK1d1TUgydjBIbFhydjZBcDVUR05tRjEwZkhkaTUvbTl1ZjJ0?=
 =?utf-8?B?OFVQUGMzNGsxYko1NjRKbnVBdkRjVUNTRnA1dnhkVDFoUW5UZjhBRU1SMnQ1?=
 =?utf-8?B?Q2ZuOUxPMmxjdlRET0tyTGNGd1pjc3M1bXpJL3EveTlYazU1YVV1UklTTFJw?=
 =?utf-8?B?NmtnbTcyUjExQ2ZjRkdBOHVhd1MxMWZFVTBjY0FQTmJqR25zbmIwT0pwcjF2?=
 =?utf-8?B?Z2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JZyCrxeggsDrTwq7WljC0abEUH1Ri+CI6uL4RgDT+DfxfUyYPjISkTvidx6yX9/EoJT8q5sQT72kKqcJcRvhpLHMaRBSNkWsj3mreBVSbIwIx1BUEJTAv0j4dJfSymYvDqcSfCtbGrXMuy89rpaO4gkd7zo6mmgGNovAeVevlSlX4tGKFn/JLBZlLYnQZdKmu09D/aL3Vdt4BXHrVpQQnL6h6NfbKNX5AsHmkvMGyb3CP/kd8a0H57oXjEvVhVep2al1kkoOaZmtn79u0ej/+rDZdkXQIeVRfqyloqlCBLJQzgzH3gaUbB3BZ1s8/CS6xa5BsNOAQNxi02uqhckrJ+dRt4oZz12YGihpj8Lf1UiUTN8e0aFG9KMoyMdgleolSJ41e5Rm1ulSN4vw1JJ64V1rMtgos1r8AUTnBeIJkg4yLv3jkA3i7WjoZy12+Y/VdMeo4u885xx5oho6WCuqiNtlpttGnb29NX3gzJZWeh+ur0+kN5xZx52s5K8VeCarW3soXIDqkRe6SyXzStoSBTPbsgfn/EWsGEdNjm8nBmw2fX7w/mcI5PcbRWnuMnYNQRQHBBYCiqjEBH+NPQXdQDFxJJpSJf62BK9uXSNE/fQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ed9f57-0df0-4d8c-456c-08dcfe9497e1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 18:55:33.8739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tjTncNCRSSx1vRePdxax9XVyodx/wWdQC3R5LXbMu6oz688qqxp30rphW+a0gZVv7PjSehvmLjtliWpA1yXuJWBcIAZCy1Pi+u1271IK2/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4590
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-06_12,2024-11-06_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411060145
X-Proofpoint-ORIG-GUID: aw_kGd54FNKdihXBcPx14oAE_746jK8D
X-Proofpoint-GUID: aw_kGd54FNKdihXBcPx14oAE_746jK8D

On 11/6/2024 1:08 PM, Jason Gunthorpe wrote:
> On Mon, Oct 07, 2024 at 10:13:22AM -0700, Steve Sistare wrote:
>> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
>> index c484981..523de8c 100644
>> --- a/include/uapi/linux/iommufd.h
>> +++ b/include/uapi/linux/iommufd.h
>> @@ -52,6 +52,7 @@ enum {
>>   	IOMMUFD_CMD_HWPT_INVALIDATE = 0x8d,
>>   	IOMMUFD_CMD_FAULT_QUEUE_ALLOC = 0x8e,
>>   	IOMMUFD_CMD_IOAS_MAP_FILE = 0x8f,
>> +	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x90,
> 
> I'm going to give 0x90 to the nesting series
> 
> 	IOMMUFD_CMD_FAULT_QUEUE_ALLOC = 0x8e,
> 	IOMMUFD_CMD_IOAS_MAP_FILE = 0x8f,
> 	IOMMUFD_CMD_VIOMMU_ALLOC = 0x90,
> 	IOMMUFD_CMD_VDEVICE_ALLOC = 0x91,
> };
> 
> Can you use
> 
> IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92

Sure, will do - steve
