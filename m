Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7CF136337
	for <iommu@lists.linux.dev>; Thu, 26 Sep 2024 14:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727359821; cv=fail; b=rw41RX0wMJ/l7GFwhxxiTU0/O0ToJVMfX+toA7lo+5oeHg3OCQIGpyHJvKYObAi89AiItqgOFQUuDR72yoXuj1I3TK3qPEd4RXp1I0fIpsfcDTBzT/XfTFN35OSMnAZ5fzLaul0LKRpwBup95zkS2fqahSubkeoBa4y4B+FhioE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727359821; c=relaxed/simple;
	bh=lLxhUmJP9CAiNm/3XJhbCOyeXPk7J3KcKm9RhH45spw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c9NaWXCCPzEUe37ndB3u7LYb0ekS+UOErIhQObIkUxMvkz4NAxDMjODmQX7+zk2IGPtuWiU529nrtgZrsvWEVu60UxDRxG+uz86YRype8vnFKd95pazGi7S8VWa96Dr4kcGRy7xaHfwDXvhwVESAwLz/FkbZB9f6kMAQkMRCY/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gplulBT9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pO7YkYBU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gplulBT9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pO7YkYBU"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48QBouVs022102;
	Thu, 26 Sep 2024 14:10:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=0s1QeCnLjxIIEzz5mOdMLExZUuK6C4r9BZeYDhtZpz0=; b=
	gplulBT9iy976U3+hhW+jRdT1KmbF7HNQswWb8fPrprrx6nuIxKpoaUCtYCjLLYv
	+kPHG7TTBbUU+J02DTShNTOavW3YNfTzguoffUYDz7in3Kxbb4hEA9aGWquoLkbh
	V8YqSETNtod7LYEcmamZv5k/pjvaHmamW3g+MApr1MdgGWzzbndPLPlIhVwWxiDa
	6y8aGIP3lSMJgUPQvo+RHgZ8gHKo9HvHnqGKxhujz0Nn2anaRbIDVyeb/3JA9N5k
	UBP4dVQr1dgvfEgoczL1/khGin/GB8BFVsqL8oXtNcEdAsVNrOBPYgUGoPSZ6eJO
	OELYKwfo3qU8stjQyDsFLw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41smx3asp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Sep 2024 14:10:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48QE4WW8026096;
	Thu, 26 Sep 2024 14:10:15 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41smkc4w6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Sep 2024 14:10:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kT3zb5ubVPyXDg5y9uS7aDHk4Ar97vYtR9XNEHoTc4AbcRhDrp8PKu6n2bM4YBjuAuNMtJdCtN1VoX1uAJ+wdC0CuYtFg98RDhs0nGAjB6Dns85xUtC+ALyie9ToE0Ky8965BehwlQv2Tv6g8VimhjB3BfUHQCtLagsCEDtC6rdKL4rW9s75Hzq3Dl4j897/oqXM5uYMXRI4yxkORiuSP+qj/N2/LEl5Owr+RYgWNmGILyYObV/RQFPURk0GdFff7iFkOMehT6nziJBhKxbp795IAComzbeEYlf3tLWuqCOlIEpg2YgAq+Vy6tO37PNQLeeFD1tJa9TeWZNqN9eSng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0s1QeCnLjxIIEzz5mOdMLExZUuK6C4r9BZeYDhtZpz0=;
 b=BeAVd7N7bJ6JLb+TsttsLCDLEsQn+HNNnbhyddjmkk0+stb8nMskzuuPb4DQYO9KCfQTsto3yEz/GDKkOckdPx5Rz8brVuKQhD7t5JZUGTqGFxIiTQVns345u+2g6hqFUato+AeEpqKlGVeA/0bYkPwclcfioVYMb49pLANMZgpJSUTub9oShy0A70CBYaSykzJjqFmdsbTfyWN7RGdxORcHZKPkuVxsoDbUxpVGfxcjmQ42InXPk8sLUbosz0cCCMEnPntk5HCGN42QJ+ABDXS1nVZl8McMcuPfpk1dsZANIjP96bNLZb1Yd9PTOid4Y21qgQFPzpiwuqoA+tE8tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0s1QeCnLjxIIEzz5mOdMLExZUuK6C4r9BZeYDhtZpz0=;
 b=pO7YkYBUM/fzc4V7J3mhtqn6Qd+wRykXEtLVLASISOkOshE9+rf+OjuypyWsohbHcNqFcuG0LmVga+/PlJdFvU1ycT5LeAOrCQg7ij2tsJN2I2PQs0YDORWcs8aiup/6R/wpLiGS2J3yRJIy9xmYWw/4aiD47rP3bqZY2R22/Fg=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH0PR10MB5626.namprd10.prod.outlook.com (2603:10b6:510:f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.13; Thu, 26 Sep
 2024 14:10:12 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8026.005; Thu, 26 Sep 2024
 14:10:12 +0000
Message-ID: <99647cfb-c93a-428d-8e4d-ca7dac594905@oracle.com>
Date: Thu, 26 Sep 2024 10:10:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/9] iommufd: pfn reader for file mappings
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
References: <1727190338-385692-1-git-send-email-steven.sistare@oracle.com>
 <1727190338-385692-4-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1727190338-385692-4-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:a03:505::27) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH0PR10MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ddeb3c7-1592-454b-9f46-08dcde34efd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2dYcUZTQm5jMEZMTEllMzd6UkJTeTltbmNpZ2pxZ0hrd0Z2ZFdIbGl1and1?=
 =?utf-8?B?anF3eGh4N2RrZENSTHozTGwxdFNjTnNLZXNVQTFPakl1Y3BJVXNYN0dIR1Zh?=
 =?utf-8?B?R2d5OFBlVWtJVk9meUhJbWZCeVk4SCt1eTVPSWZMM29iQ0ROSjJvdm10SXgv?=
 =?utf-8?B?eW1HM3M4b1BlaXZPaUtTNlR2cFVDNUQvYlNIZkgvZXNIK2dVanZtMlFnanl1?=
 =?utf-8?B?VWcySHFER0M2OEwxVzFaSVBsU1RNdlJKRkc5bm14WmRFQXpMd0E2MTRaYnYv?=
 =?utf-8?B?bmVoZFJyS0wzWkQ4bjNKWmNYdktHT0N1ZWljSDArcVl1Y1hoRnVRSENTQ2Rv?=
 =?utf-8?B?WnF2Y3NLS0twU2VsZXp0aEJraytuZDlmaHJJZm5BQS9hMFVMRTRjemRJYWpG?=
 =?utf-8?B?WFYwT3V6Mm9LbmxvZDNrbGFLb3REQkhheE5QbmtEc0tvMVJIbFp1TzNrZWUr?=
 =?utf-8?B?K1l4NGRjOGV3d2ZKVk1NWlFjUHN3VUhtbGRjNVp3TXZTenF4TUNiZzZneEhp?=
 =?utf-8?B?aHlLOWZ3bUJSSSs2TDJSSmJZVW1hVmpkUGVuekJPREM1MkJpQTRJRHdHS2Q3?=
 =?utf-8?B?U1VNSVdQdkl0empXQ0hyYXgzMFZ5cElWcTgyNFRsWUVVTC9kWWxtOVhUejdX?=
 =?utf-8?B?WDRGQzgwYXh3dlVMcnlzZzN0K013clRRRllSaTcxeDJZaG55SHRtUlI5RzNU?=
 =?utf-8?B?TXlUSnBsTUNMclg3RC9ZckRFVWhCMi9FN2hxdEorY1prWnI2dk96QnpSQVJq?=
 =?utf-8?B?cEZ3a3hmMG1FQkUwaWxDZjYvNzZGdHNwd1RaRDlCWW1zMFplODBPeDEvYUxI?=
 =?utf-8?B?VFl5eEs4RG5OdlVRQlErSnJWTzU0dmZqbnFDUncvS2ZOU3ExSmxyOEdpRXRr?=
 =?utf-8?B?Qm9aU0gvVmxTdUR3K3ZURkhOVzRnWHhUcTVnU1lHbVBKT0FKeDJSd3NjODJL?=
 =?utf-8?B?VGFYSTNNZEdhUFJEUW8rN0NQUVl4REU2RHJ0eWZwTDVBdlBvVTlxdGFpWnA3?=
 =?utf-8?B?bXUrYTNhTHB5cGx2V1g2dmtmbk5COENOWlArajl2K0hxOWZaMFdZQy8vaWR3?=
 =?utf-8?B?dmFSb1MwTU9tc005enVSLzBkUkMxekxtbGcveCtpTXVmRjNOU0M1bE1USWsr?=
 =?utf-8?B?dHR2SGFycWFIUm1mVFpYcFphb1p5cnZtUURLQ1J4dUl5aTZhWU82YW8zS1JJ?=
 =?utf-8?B?QktVOGVOUW5TVGplY2owZzN5NzNkZUhIOVZGTi9sUVBrU0pFeGorclhZM1Q1?=
 =?utf-8?B?U2d5Q1ZjNlN3M0Y4ZWtNa3RDN0tXS08yMFZoUkZWSzFBL3NVNU1BSzFxQ3JG?=
 =?utf-8?B?SWVrZjRPUVAwRmE4ZWNHSzFaTy9KcnVGcmpnRnpGbUZIR01ILzZraGlwZmt1?=
 =?utf-8?B?U1k1b2V0Um1kNG5GM1BrN014V1lXMjNrSUQ2MGsxZ1FsWlI4TmJuLzJGY2VP?=
 =?utf-8?B?MjR2S1J0U3NjcStqMCsxaDV3cDAvMVZVZjZrTXlmTWdSbWpZUFZkekIxNGZz?=
 =?utf-8?B?d0ZQODlDNTg2N1EwbWw0OGRtVUpkZ2EzZExRdHhCVHNuWllDQ0Q3U0JsMFNB?=
 =?utf-8?B?L1JqMlh6Z3ZkTThINVMvOHBJV3o5eHJGcnltSk8wN3FCYU9WWmFyZ09qZ3VU?=
 =?utf-8?B?Y01vdHpDdHVCVW5SdzBNWUVNdzIwcmlRYmVmZGttTDVEVHpqdmRnYVg0aGlC?=
 =?utf-8?B?MGljRWxFNWNTWXZ4bEt3M3l0OWlHNmw1YkdhUUJWMitRdDB3TC9rdTdSSWpl?=
 =?utf-8?B?OTdUSDhUWnZiaUNweEVxcm9zeU50dmNSKytCVkhpRUkrcmxyZE1DeDlhWlBz?=
 =?utf-8?B?VzhTVVhtRmplQ2lFcmpzUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1ZaeXpqWDYzSU94T3lkNGRMS0FTdUx3bnMwNitUVEIvTmoyNkRuVnpUWURr?=
 =?utf-8?B?bkdDSzFYREk2WldUejFhUlpiM0J3YUFIK2JLVldJUk04UlpNVTVYL3A5MDNv?=
 =?utf-8?B?Vkl3UzIwZHJWUFk2RHFpNUErbk9oaUVPRWJ3RmZFUU50Z243NSthaTd1OTRK?=
 =?utf-8?B?WCtZQ2VXdjJtUDI2cThYRXArRmhORDRNOGVxNzlrYmZrcjFWVzdjaUhQd2JL?=
 =?utf-8?B?Vng0UnNnWHZqTHlQSzluNlZha0dQRmJFeGtlUzlDNitqKzVCUEVKQmRoWEJE?=
 =?utf-8?B?S05zcnhFTDZpRURpNW0zZjZuM1pQNytVMnhiWnhrT3lGZG1DMndmSTZoUkU5?=
 =?utf-8?B?anF4NVBDdzhiWk9zS2lTelFQdzNoWUlhV0dkUTM5bER1cHZqckdPQ3U2T21x?=
 =?utf-8?B?ck9LcE9QYUFVbXI0VXl2V2x3MUR0SjE4VVIzYk5JQzVDV3VQN2UzR3pYMnVZ?=
 =?utf-8?B?UEhrdUR6aDVrZDF5ekRzd1lyRkNPOW0yMi9BL0ZIbSswNGhSbFZMMnlCNFVQ?=
 =?utf-8?B?eTRVZHlERGhEbmhnTE5FdTRnY1ROZk1xbElSYlgrZWRwV29EZE5VbnRtTzdz?=
 =?utf-8?B?UElNQ2VVT1RoTHV5WXE3cUE2Z1NrZVo4cytuMEVvcGRjYks1Q3piaWlpdzZo?=
 =?utf-8?B?RUhPRlN4UmRsNDdzMzU3NzB2YzdNU0ZUZ3pxMUF1b1MxK3BjcUo2U3NtblM3?=
 =?utf-8?B?KzV5MUxVZ3VCSWI2UUV3TGRtSGhrNVRJclFib2Iwa3IyQkZlNzg4QnFHZzlu?=
 =?utf-8?B?V3ZOWEhrUVdFcG54Z0w0NitFWEczb0hMaUh4OGRqcFNCaXB4N0dlK2dkWWFW?=
 =?utf-8?B?ZjF5ZHlRY1VjaEdqNCtBdk04UWo0T1ozL2syYkp1c3BCM0xxdVBnMVhXTWpv?=
 =?utf-8?B?UHlxZEtQNXR3Y1Qyb2x3QVlxT0JGbUJJeHYra2oremQ0NzVVV2s2YVA4YmNv?=
 =?utf-8?B?Q2ZLMXVEeEx1dndXYlE0VXhXbHhHVHp4ZUVUaDhnTkhyUmFOV2xmUkFPeW1I?=
 =?utf-8?B?a3dtSGdTR3VWdnkrUFFqbkN1NnFhSFBZNytjRndUL255dWRPUGFCN0wyaGRR?=
 =?utf-8?B?NUFjemhoRmRueDAvOGo4SytaYThUOVROblduZFBnVmJBWHdGd0R5R3NqdmR1?=
 =?utf-8?B?eTk5VGRWWTkvYllRRFRKUldOMUdJeG94eksyRjVZZWFjbUx4aGx3eVZPQVdi?=
 =?utf-8?B?Wlp0RTdBcGhmcWNjZ3M4MFBJY2RDOHltSFd4S0srbGErWnhINDY2WkFSeU5z?=
 =?utf-8?B?amh0ZkhuLzl5aXRkVU9xaWZJT20vcHRjUmVUZDN3OHIvRUlZTlNXbFFPQ1JJ?=
 =?utf-8?B?N1JSNU1ha0N4MDJoU1l2bUo4VlRyL2FvdXVnNVNVMjNjMXd4cytZc3UrV3Vr?=
 =?utf-8?B?MUJyTmNSS09tYUxYYXdjVmJLeE02R1JwRFpmaTBqUnpFNFpYZTVCNnJTM3lv?=
 =?utf-8?B?TTU2UmZBajZzenZidlo0a3FDdE5wT0UzTWVTNkJJaUpFZlpGQndkRHFMSTk1?=
 =?utf-8?B?ZW1iMVoyVVNVODlHT1ZMaDV1YU9GbnBPSUZmQXl6YUVsUFdZd2tCRnB3ajlr?=
 =?utf-8?B?cFVGL2VyK010R1JVNm4ybTRwbC8rdXNZWGZSdGtoT3Z6VFpuS0M2QmJRREZv?=
 =?utf-8?B?RXh3UytRd08vTnpSQnNVajUxaWRycHJ0YjlYNVBIQkhlQjRuTlBnZ2p0a29a?=
 =?utf-8?B?K09oS1N5NDB0V2IwMmNpZ0FLZWJsUzFEZzhMRUhJcHVHdzBIbUdoMDlwQW5z?=
 =?utf-8?B?WVk0TlNtdzF2R2ptaHd6UjE1U3k4ZEFiS3JjdXkxRkwyY2Mvb0FRckZob0Jw?=
 =?utf-8?B?R2JZMGhSaGQzNkJnbnNrdm5vU1V0TG91elUrVDVyTGNOTmg0ekZtSDNxTWI5?=
 =?utf-8?B?YTdMbkxYcHlocVl0S0RFcTRuM2JSUjQzRVNIREFtMGJjeUt1R1FZR1ZuQ01V?=
 =?utf-8?B?ZkJQdVJLQVNwYjFRNDU1aDFHRy9xVFBNdlRyVXFySVJEM3JwK3dCOVVSbTNh?=
 =?utf-8?B?dFBNUWR5dlFhT2hWMEdpTzhzYUdFSXJRTUQrTWcxZ2FZSnlIbjNGYzcwbVVN?=
 =?utf-8?B?OUtQV1NLY1dFVmtabjJkWW5ONW1yYzBBUkpaYkFHQlhubFIyNVZhWHV4K01D?=
 =?utf-8?B?cTFraXBPUE04TEoveGlmU21waDJTUFFxRWpXdWRrN1JqalFwOEl5anl3Z2Za?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LxeVHC4FYbiAGj/prlQ8t5ZoXXW8pt7g5rkUp9j7GHszdv+ykwKyZ+3uQVBowrs+lPGH/ouc5lWQu3mp3bWqnXhV2VI9qbtWGKutOR5rgCdUX8YcbBukDnaTbsr4tWGLmE4TFw36BRn6Xn9qqguS5t6bgAsnXWawrgI91kTXmVG+cXTNf04+o5stRG7jHsALC3X7msMy00S1Bb6dnBOuzd1h8t50zFah834INNVy+va8liyNTJo46tp6OvmG78kv0M61KIZDPSj9a6YA8EwNeXQJ9huGHtMP2G0Jba/FIPenDOAz62ldn3NYXwC88KDyRXqflAIrH104Ot5jJ1Ry41pxABHiB/w90SHKxXf30yZn8mBy2fVGF2X2ij+4AVsUa8dQkY2oAuU6jM6rYRzg3PD18/w1tZnDLojKLfSor7Gmgbj5RH0XxjlpIV3JapIjJpFV/RyMVfYAlayun3h5TE9FB2ppcc1jP+C24KYJfwgLh/kuZZlp7xogS4a13ZU3apF6Wa4Khxs6wpYV67qxnWHj9Dt4fQTAa1HhFzrKeXMG87ieTCEdJQ0ij06/JhP3iN/6tRlrv3kdjutfiBE/Af9mxfsRFdC6Tz/NuBqCapI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ddeb3c7-1592-454b-9f46-08dcde34efd6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 14:10:12.4796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rVaOPHs54IXbaa89RipjiZbjaNNbsuvw0S5BDkplFfy+v75pzwis8+evo/duLZ2ypqPbV2dCI2hRQuIImNaJ0NBbbCSaNbk6b1z/CV3lCzo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5626
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-26_04,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409260098
X-Proofpoint-ORIG-GUID: 5lLv9yNLEok1BHutvAK9g8sw2l4-9QhB
X-Proofpoint-GUID: 5lLv9yNLEok1BHutvAK9g8sw2l4-9QhB



On 9/24/2024 11:05 AM, Steve Sistare wrote:
> Extend pfn_reader_user to pin file mappings, by calling memfd_pin_folios.
> Repin at small page granularity and unpack pages into upages[] to mesh
> with the existing code paths.  This is sub-optimal but simple, and will be
> optimized in a subsequent patch.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   drivers/iommu/iommufd/io_pagetable.h |  5 +++
>   drivers/iommu/iommufd/pages.c        | 86 +++++++++++++++++++++++++++++++-----
>   2 files changed, 80 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
> index 7c4a338..3a28f46 100644
> --- a/drivers/iommu/iommufd/io_pagetable.h
> +++ b/drivers/iommu/iommufd/io_pagetable.h
> @@ -177,6 +177,7 @@ enum {
>   
>   enum iopt_address_type {
>   	IOPT_ADDRESS_USER = 0,
> +	IOPT_ADDRESS_FILE = 1,
>   };
>   
>   /*
> @@ -202,6 +203,10 @@ struct iopt_pages {
>   	enum iopt_address_type type;
>   	union {
>   		void __user *uptr;		/* IOPT_ADDRESS_USER */
> +		struct {			/* IOPT_ADDRESS_FILE */
> +			struct file *file;
> +			unsigned long start;
> +		};
>   	};
>   	bool writable:1;
>   	u8 account_mode;
> diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
> index 69822d4..df5ba4f 100644
> --- a/drivers/iommu/iommufd/pages.c
> +++ b/drivers/iommu/iommufd/pages.c
> @@ -703,19 +703,28 @@ struct pfn_reader_user {
>   	 * neither
>   	 */
>   	int locked;
> +
> +	/* The following are only valid if file != NULL. */
> +	struct file *file;
> +	struct folio **ufolios;
> +	unsigned long ufolios_len;
>   };
>   
>   static void pfn_reader_user_init(struct pfn_reader_user *user,
>   				 struct iopt_pages *pages)
>   {
>   	user->upages = NULL;
> +	user->upages_len = 0;
>   	user->upages_start = 0;
>   	user->upages_end = 0;
>   	user->locked = -1;
> -
>   	user->gup_flags = FOLL_LONGTERM;
>   	if (pages->writable)
>   		user->gup_flags |= FOLL_WRITE;
> +
> +	user->file = (pages->type == IOPT_ADDRESS_FILE) ? pages->file : NULL;
> +	user->ufolios = NULL;
> +	user->ufolios_len = 0;
>   }
>   
>   static void pfn_reader_user_destroy(struct pfn_reader_user *user,
> @@ -731,6 +740,45 @@ static void pfn_reader_user_destroy(struct pfn_reader_user *user,
>   
>   	kfree(user->upages);
>   	user->upages = NULL;
> +	kfree(user->ufolios);
> +	user->ufolios = NULL;
> +}
> +
> +static long pin_memfd_pages(struct pfn_reader_user *user,
> +			    unsigned long start,
> +			    unsigned long npages)
> +{
> +	unsigned long end, nr, i, j, npin, offset, npages_out;
> +	long nfolios;
> +	struct folio *folio;
> +	struct page **upages = user->upages;
> +
> +	nfolios = user->ufolios_len / sizeof(*user->ufolios);
> +	end = start + (npages << PAGE_SHIFT) - 1;
> +
> +	nfolios = memfd_pin_folios(user->file, start, end,
> +				   user->ufolios, nfolios, &offset);
> +	if (nfolios <= 0)
> +		return nfolios;
> +
> +	offset >>= PAGE_SHIFT;
> +	npages_out = 0;
> +
> +	for (i = 0; i < nfolios; i++) {
> +		folio = user->ufolios[i];
> +		nr = folio_nr_pages(folio);
> +		npin = min(nr - offset, npages);
> +		if (nr > 1) {
> +			folio_split_user_page_pin(folio, npin);
> +		}
> +		for (j = offset; j < offset + npin; j++)
> +			*upages++ = folio_page(folio, j);
> +		npages -= npin;
> +		npages_out += npin;
> +		offset = 0;
> +	}
> +
> +	return npages_out;
>   }
>   
>   static int pfn_reader_user_pin(struct pfn_reader_user *user,
> @@ -739,7 +787,8 @@ static int pfn_reader_user_pin(struct pfn_reader_user *user,
>   			       unsigned long last_index)
>   {
>   	bool remote_mm = pages->source_mm != current->mm;
> -	unsigned long npages;
> +	unsigned long npages = last_index - start_index + 1;
> +	unsigned long start, unum;
>   	uintptr_t uptr;
>   	long rc;
>   
> @@ -749,14 +798,25 @@ static int pfn_reader_user_pin(struct pfn_reader_user *user,
>   
>   	if (!user->upages) {
>   		/* All undone in pfn_reader_destroy() */
> -		user->upages_len =
> -			(last_index - start_index + 1) * sizeof(*user->upages);
> +		user->upages_len = npages * sizeof(*user->upages);
>   		user->upages = temp_kmalloc(&user->upages_len, NULL, 0);
>   		if (!user->upages)
>   			return -ENOMEM;
>   	}
>   
> -	if (user->locked == -1) {
> +	if (user->file && !user->ufolios) {
> +		user->ufolios_len = npages * sizeof(*user->ufolios);
> +		user->ufolios = temp_kmalloc(&user->ufolios_len, NULL, 0);
> +		if (!user->ufolios)
> +			return -ENOMEM;
> +
> +		/* Bail for now.  Be more robust when we optimize for folios. */
> +		if (user->ufolios_len / sizeof(*user->ufolios) <
> +		    user->upages_len / sizeof(*user->upages))
> +			return -ENOMEM;
> +	}
> +
> +	if (!user->file && user->locked == -1) {

During further testing I found a bug caused by this code. Elsewhere the code
checks "if (user->locked)" and breaks because locked is -1, as it was never
initialized here.  The code here should be:

         if (user->locked == -1) {
                 if (!user->file && remote_mm) {
                         if (!mmget_not_zero(pages->source_mm))
                                 return -EFAULT;
                 }
                 user->locked = 0;
         }

I will fix this in V3 (but will not send it until V2 is reviewed).

- Steve

>   		/*
>   		 * The majority of usages will run the map task within the mm
>   		 * providing the pages, so we can optimize into
> @@ -769,18 +829,22 @@ static int pfn_reader_user_pin(struct pfn_reader_user *user,
>   		user->locked = 0;
>   	}
>   
> -	npages = min_t(unsigned long, last_index - start_index + 1,
> -		       user->upages_len / sizeof(*user->upages));
> -
> +	unum = user->file ? user->ufolios_len / sizeof(*user->ufolios) :
> +			    user->upages_len / sizeof(*user->upages);
> +	npages = min_t(unsigned long, npages, unum);
>   
>   	if (iommufd_should_fail())
>   		return -EFAULT;
>   
> -	uptr = (uintptr_t)(pages->uptr + start_index * PAGE_SIZE);
> -	if (!remote_mm)
> +	if (user->file) {
> +		start = pages->start + (start_index * PAGE_SIZE);
> +		rc = pin_memfd_pages(user, start, npages);
> +	} else if (!remote_mm) {
> +		uptr = (uintptr_t)(pages->uptr + start_index * PAGE_SIZE);
>   		rc = pin_user_pages_fast(uptr, npages, user->gup_flags,
>   					 user->upages);
> -	else {
> +	} else {
> +		uptr = (uintptr_t)(pages->uptr + start_index * PAGE_SIZE);
>   		if (!user->locked) {
>   			mmap_read_lock(pages->source_mm);
>   			user->locked = 1;

