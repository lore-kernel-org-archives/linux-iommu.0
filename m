Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E46159583
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729689776; cv=fail; b=HZtinO8sUClY+8lKyLus3RzFMdgOD5sbxdBIcLZdhAZY8xhmh3tjk3El+w6nEIVaVp1JnK2T6c3OilwcGR/MH2PgynO/pJua+RAXs5w4xldflKeyEcaTExhJzUT9Jvm2iTk+FkU0bRDtFPQ8DgredsK/ub2Ps2m9vS48v6dv8Xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729689776; c=relaxed/simple;
	bh=+vKV1vQwH5FoYhkYzlZf2G5Mv1v9WRXfGgjp4nRclAs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T73XyQJ52GER93h44jx0A9wW+loGf1NnE1G2IzKxgBWLroEeXCV8ivEm2QQt4wiZ9RHAzMs8zbdg+8f4LjrOdL+XHtF1zVFVpLu/gJGZR7Elv/FVqv/+GdFAn38d0htpMrJ6EV1a2/HVFwPJWc36uYYsPUKSL+0rD8AMX41/mF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FzNni0/F; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ztXMeKvr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FzNni0/F";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ztXMeKvr"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NBQYFr022893;
	Wed, 23 Oct 2024 13:22:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=qnEnkvoguQqJIoEnzvi0h2L7WDSi4apn0aGFmNa7qhM=; b=
	FzNni0/FnG4E9v87UCkxf6aqPkEhz3E8m7BO2gUDfsuoNziNw3tmQ+prFZ7gJ9Ag
	VkVV/+hAd+CPcG3tFVSWf0slUyPSuNHKeWD58WqObsuTYl7/eixJqNOpyaqiqusl
	bcmYhTUEpBO3/JeUsOU+3nkopGsb5loIuFNt0n7ZAJBVLk69HaumaEEByMh9ozDM
	R8qhSIg6F6YZAPtvyFOIgw0uNA4n95uMPGYPgbaHd+D/ixLOsKP0j7fwhCuCjVpq
	3tfE81vXkFjL1/koWOjf2Y/uSEeAFE1SeAm/mN5kfTDWeLxH8tkirZ5mkqk/KI/L
	7dYex4tFH+C2Gbw64hv+6g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ckkqydpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 13:22:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49ND29AS025484;
	Wed, 23 Oct 2024 13:22:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh9h2v8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 13:22:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/5Q/qS+JdvviqUYLGAH7faWzsZeflRpv+SN4h62A7xQDO27pgU6/vFKJpuHlLNP3FhR7pC1+aclqruRYZ6dZP84Ee69DL+seKYuS4FvUbSgiHI6GB3fSpwIgMQFF2kiSirHPMcwTxa6Yj9f8fAf0/9wptqG613i8/OpQlVyWFjqJ0hVmPQsEN0SNylKtIlBRY2rOyYYJpHYncCmI0vXZ/NP0SJT/pRz0VPNWg/17rJdSEYlMOCwnMyq/FK6imY2qTc+kdlJfXEIR3CshFDSRM6B2vX+62h12CIelH7rdHlhxwviX4xvfSvRjl4wucdJ/Re7kyOBLsU70I7Sk1Mg5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnEnkvoguQqJIoEnzvi0h2L7WDSi4apn0aGFmNa7qhM=;
 b=sDKlMYICQM/QsxZY7EvMAuFJaeY5v1vzkdQwkf7ndz+Jm0ySady0D0/RoiC4mmTPbqqpbV31AsqhkSVkKNIh0Am+/3KlmU40AlX8T013nsu79VkaCt1no6Z4/g5EhXW3szSltfb/E5hD5SP9isfej1nrZ5EYEPE3+d7FtsFmpVH/HKYFUEdchgdZxklhGh/3kABJssdO5vdDpvLWeEkMGJJqrOTpVkPrOAB4LrwWv5/pLBaCZ0qLtlTxgOBpUj0XIEbOao2fAhfb//v4z97kwMGjxt0Hno25m59O2CDl9HewYWcAxrWWnbv16h+lCL0Qdd+TDdiQUHn34+Nb/5JOAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnEnkvoguQqJIoEnzvi0h2L7WDSi4apn0aGFmNa7qhM=;
 b=ztXMeKvrDoF8CE0CYqRPKmORT0kNPJ4/omby2yCUKMOPoN0G9pyz/VpenLlRepjvH2ixH8MraWbULvwhfHoYIhMa16h2d/GJOsTyYpjVNuxgBmpeby58Oa3GWZ/OHjL3m4ZaGhSjIDLGK9G2BacqznvDp/0mo78nS3WlHyWGmRg=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by BLAPR10MB4852.namprd10.prod.outlook.com (2603:10b6:208:30f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19; Wed, 23 Oct
 2024 13:22:46 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 13:22:46 +0000
Message-ID: <9450349e-7c27-470f-87c1-66fe6cfb202e@oracle.com>
Date: Wed, 23 Oct 2024 09:22:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 7/9] iommufd: IOMMU_IOAS_MAP_FILE
To: "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
References: <1729630838-24586-1-git-send-email-steven.sistare@oracle.com>
 <1729630838-24586-8-git-send-email-steven.sistare@oracle.com>
 <BN9PR11MB5276B76CD645ECBCF60A8A158C4D2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <BN9PR11MB5276B76CD645ECBCF60A8A158C4D2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: IA1P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:461::10) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|BLAPR10MB4852:EE_
X-MS-Office365-Filtering-Correlation-Id: 10bfe30f-7610-4c95-a510-08dcf365c851
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bnMydGlXZWhuQnp6a1B0RkY4QWNhdnowZGxiRUJBSlVaTXQwVjZaTEY2bDR1?=
 =?utf-8?B?djNHRXR1QzBnb2dDTjBvb29ualgzeWNwN0MwakFEcDFRTS8xSjlhZXp0R3Rz?=
 =?utf-8?B?aEY4K0NadEo3NU50RTB2UVRjaW9uTHRHTlphSmFYQ3hqWERUMlZrOEFScDlo?=
 =?utf-8?B?WU40eEVMKzNqYTdkT0Y5KzVsaXVKeXdwRlNjdGJsMEJ2RXp5VWR6enNiRURz?=
 =?utf-8?B?U0srVDIxekd1K1JtSDg1eEk5Mk16WFF3bFhHLzByQW9ERlcyTFhyOG9rZWhq?=
 =?utf-8?B?aEtSK3VPZnFsdmxLdEdwNndzZmkzMFYrakU0QTNLTlFMTG14UncwZmx5UFdl?=
 =?utf-8?B?OXFueDJ3eXhFT0lOb2RFQk9CSCtiM2tONlpoUXdibzhYaktuL0ZXeDBEcjE3?=
 =?utf-8?B?akhjZFR1WmZ2Qll2M3c2YnVXZXp2Z2NEbHlvMmJ1V3FUV2NkN0UrK2w1bFov?=
 =?utf-8?B?MmlONEJHOCt3VGY2UjZpa0pCNVdlYTBGbVk5UHdDNlNXWVpLK1RQTFZaRzBW?=
 =?utf-8?B?dFk1UFA2ZFFibHlHWnBveDBVZmFCOVhXclFmWXRNaFFseVkxb3R3aVpRYk9X?=
 =?utf-8?B?MGppZ2RnSC9NU0dhdnQ2WEVvTDl0R3BWUVFCVzNtY2FVc2RnOWNXMEFsMkpy?=
 =?utf-8?B?REJwV1RwUmNnNmVrRWI5a3lCNXRjNlozSFhFblJHdUhOS0pySnZXSlJFRy9p?=
 =?utf-8?B?QVR1Rzhqd0RBK05MT05USDJxWnlkb3JVWHNqcEdFSndVSFdTZzFzN3Q1V0kr?=
 =?utf-8?B?SXh3M0FqZGtldWpJb3ZhU0E4OTUyb2ZTQlNHdGNMbTYvZE1zdlVjUVMzUU1U?=
 =?utf-8?B?OXdhQk5RN2pTVElwa0U3VDYxRjk3WTJ1UXVsVmZxQjZYOG8ydlh4cmc1NzIx?=
 =?utf-8?B?dWJ0TEZQN214V3M3OEFOOFY2RTZpSEhRZkdvdTVzYXFyMzEva1JXaThxT05j?=
 =?utf-8?B?TldTWVRGejBjVi9YeU5ma0VmTmhNNmZBcUhUZFlNQjludVc3QW5vZXM2Z3VX?=
 =?utf-8?B?Mk5Wb1UxaE81YTZ1dmxqVVJ5Q0Q3TGlZSjNIV0xEU0dUblNYVnJoVFFHdEtw?=
 =?utf-8?B?cklrNFU2SnFZWWM2Q0xEc1J1MnlGRlZkOXI5T2pZYWoxeldYb0phY2x6Lzlz?=
 =?utf-8?B?dTBvRHJUbXRWTlo4aG1jVFl4VFd1Wm1KTHUxT09IZ3BHVUYwT045ay83V3VB?=
 =?utf-8?B?RkozRjJVcDBsQ0U2NW5kZTVTUm9lTGVqY0ZRV3pNbGI2THJLVzU2MUNaTHQ2?=
 =?utf-8?B?d2d2VCs4UjhnYjJ1cy9DNkVXS0ZYaGdhTFhrU1MycEhRV3pScWh4T0xlNHJt?=
 =?utf-8?B?cDJiTWtZSVlkMCt0clZ0Z0lNU3N1aDVxUVFPQkxHaExxNlAzNjUyVS81dVBw?=
 =?utf-8?B?OVJvZnR3REFVUE45Q2hMWU9JbW5RTFJFZW5jc1FmNjAxb0JSbG5yYU9NUVRR?=
 =?utf-8?B?WXF6UjgxWmhUcGM4UVhKbEFIMEJmQk5VbFRTRnZDeDlvcGxaVzZhR1BDNXhE?=
 =?utf-8?B?SnFLdldpK0ZRZDZiM0JYUVRPV2VibTNYOTNLMk1KdkZVYUNwSGw5dnU3WHJT?=
 =?utf-8?B?a28zS1ZzUW9xOHFJNXcxRmNBYWplM2JhOCtrUEk3L2VLN1g1Mjd1QjJORGk0?=
 =?utf-8?B?ZmxzTXUvUmEyNTlQdmNERW9UQkZzaitZRDhzb082UVk5THdncWhueUxQR3BZ?=
 =?utf-8?B?UUN4WGFhSmRueDB3UlRMazFqaWdVT2JYUWgrRnJOSFY0a2FZaWdRY3U2QTBN?=
 =?utf-8?Q?dgOQmMIsaZcp6tBjxZqkhhQzF8npkiHHDD0WDl9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SytCOXptaVZhZzhJcW83QVp2aEE2K095aHFuMzlkb2tScGE3OE5SUTJPdWpI?=
 =?utf-8?B?a0NGVkZtN1I1TnM3QWhaWWJ1K2FKV2lPNUtDaEtvK2tiemhGcE53UTFhZHVZ?=
 =?utf-8?B?NTdBZ3NlQUVoZTcva2JTeGRTQkt3cEdJSFR3dTNwTGVoRDFpUUFXZTBRWWFE?=
 =?utf-8?B?ZmNwOGl4eXRFTkZ6STNDNjB4QzdsVTlZd1FPUFhFYmRmQzE1bHBBNGJQN3Vj?=
 =?utf-8?B?ZlY2TGd6c3hqSVJmWEt5MEZoSlF0VUhvOThrWHg4dk5aMm93a0d0NWhlUnI0?=
 =?utf-8?B?ZGJ6NnNseThXN1ZCang2bytkb0x2Q0tYTXFkMnJjWGNGZU9TNzhBWlV6TTVw?=
 =?utf-8?B?OEFleWZUR0dqOHdqNVR0N0dFRnJLYVkycWloK0hyVEZleFdHV08vUUtENlNy?=
 =?utf-8?B?NUhvc2xHU3ZnVGFwNW9MNFZQLy8vdmlDenp3SjNNSXZnR3kwTW1WVTRiTFl5?=
 =?utf-8?B?WURtM0FZZ1E4RVdwcDBNeEw3RUthQ1BjbVZiekpjQ3BJZnAwWGFsempwWU1n?=
 =?utf-8?B?eTBYNkdISDVjaHFoNnQzWTdjcWh3SkJXWGhqczdLUkp0bmRjZU5WaXZoZXdy?=
 =?utf-8?B?MDJoWG0vZnkzb2ZJczgrK2NDbUkwbHAvL1dRM3d0SHJoU2tPMm80cVowamlF?=
 =?utf-8?B?OHVvOGtGYzNqTVR0UWxrUmhuR0dKcUhrZDYvVm00T3JtdVorcUxsaW1aeDA2?=
 =?utf-8?B?T0Q5YUFlanAvK29HZGMxWk9JdEdyWmE3VGFSNDRKMDdwWlVFRC83NnY0RHdp?=
 =?utf-8?B?ZnpCcGdVNHZUeUJnSXFLMWM4ZlhHSGI0NzhoWEZHOGwzc3I4Z1F2bkJrWUVn?=
 =?utf-8?B?bGRlWjlabjdTUi9qand2RXY1L3lBN0J2VUJVOVpoekVpYjdIaERiaElDQ3Mz?=
 =?utf-8?B?Njd0b2hYdHk3eU1lcHNaZVpoRk83QnEzOHFkWXc4VE9TUnM5UmVQUXBDNVY5?=
 =?utf-8?B?ZDNrRzllRldoeGcwMG5oazdZZW1qWTB2SElPNXJSeVJsVHZVK25QRmtjcmtZ?=
 =?utf-8?B?RkdiTVZMaHEzdXdKMFl0RUxidWg1WXJwbFBBaUpkMm95Tmsvbk0yRndvZVpq?=
 =?utf-8?B?RFc1UXNxcVVjUW9kNVNpYUtXcXRSRTEwNlN3dWp3SFRHZEdlQVg2VjNPLzZ2?=
 =?utf-8?B?a3ZKOHFtUUF6UTducEtZLzl2Vm9sY0NkSUpxN2V5UlZlUitMcC8yMDZGcjdH?=
 =?utf-8?B?eFFwSXlleGdRb2Q5NlBSWE1Mb0YyUEh5eFJoQ1RzeEw1Skx2NjZWeEJJQnFw?=
 =?utf-8?B?bUJCUU45bmZxWkxHaVMwRUtTbVZTK2tCdTlVdkpVdjlaOWxJaUlQUUNXbVJ5?=
 =?utf-8?B?YnN6UG1FMmlEUW12Z1RnbUY5VWd3TlVaTkd5ZGJxeEg4cEx4OXV0dmpuc1pv?=
 =?utf-8?B?ODdEcFVjaDJhVS8vT3d3SVF3TmFmbmJvQ2NhcitidWN5NXBsZlVVbG4zaXpY?=
 =?utf-8?B?VlhiMUhvakFReExYdWMrenUvQnkwaTFKSDluWlVIcVVGU0xYOU5WaVJKSXhh?=
 =?utf-8?B?bG81QnVVeXU4bzRYRm5wWlVqTkFlK092U0NLZE1iSmRwUjB3RCsrR1Jkc3dz?=
 =?utf-8?B?M0pSbVBXbkw2M0VSRTNsQTFSRmxVZzZnMnRzZmQ5QXE4SnJLQVVMS1V1STRY?=
 =?utf-8?B?YTlDTkJXa2pHclNZWjFibGJHRnVEdDVtTks2RWNhbFpZdGVtcFZBamM3YVhz?=
 =?utf-8?B?Y1RMRUZqdW4xRGpncE5GMUZBOC92eDVCTG5zVldCb21jVXZwUndEM0lma0Rr?=
 =?utf-8?B?bUFxeXFsQURSNlF5djFYSnE3MldvU2hZdE9jazlQc1A3bXdXRWpKcFk2c01R?=
 =?utf-8?B?SHBXZlJwemdDUXJkQXk2T3Q4S3UwVlN6WVF3M1d4M3pWa0JKeStoUXhRZkV4?=
 =?utf-8?B?WUp1b1JDYUY2dms0ZVBKSktXbmRWY1BTYjFkNnFhOFlaZ0NXTDRaZG94VERS?=
 =?utf-8?B?YUJuK1ZiQTZuK21VVlVNTTZjalhxU3lXQ21nZkc2Qy9uU3pMMitMdXJ3MWxu?=
 =?utf-8?B?a2VMSkt3ZURKUnVMSXhNNlNzWGFNcUpyb2t2ZFFhcGVqOERqb0RkWDFTZ3Vi?=
 =?utf-8?B?OXJONHc1SmFsaFpFc3l1Z2tUdlcyMmUrTnMrTkhoK0piQVExYVQ5cXB5Y3FE?=
 =?utf-8?B?Z253SXo5TzlRNEZBQ0JWb3RMTHZSQ1B0MlZibkRNcCtqQ3B6dW9NdFIwK3lC?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nf7dwoqA0g14TsG2MLbSevqXCjNRS6XMaijjJgxuiWLTA7+LT5AWbDi8q0Cap3iPv3JIkT4wxl5P1zRBZYySK8y3wT2K4aLGhEZGTFvPmb+bp62XveNQdBdPqJ8vT0lP9DOSQHCajRhJreSYmquGykyAjc4Dn1QSbl1rZylVJiJ/PekqBN/6xUBphc8V5NGnUWOEtYQ0pQIZtD5jhjjuCGCjTG5k3OA0RxTF/OSkJ01zq+kzKxTu8tsHhJbeNnJOHlRVlgY54DwB8vlfVOJmeOved+DhkYz6t8NLHuhKMWFptOdY1eTctMa5/GeoPLpb1MTYz2pcpK0CNJRLMNUy5Zo6YtabgRh6b9qHbe6/FlCgpW8qAY/Q9YuKbYL4XB8MuCfalFMW9+9S02xfMxMiuhqtEaNlgjIcyylnqvrymLB8C+cCNJkxkVJ2VeK2U2yKdFXb3M7YG3EyLSEctaRE1TPSr4AZ+S4wgEncbjiT2EFw44y+Z0pXNsae7LAygvOTi6dkIUmMN2nXKv3/j8bmd45MIrb4vK/kTamxhBOAt11YC6djbGpENOKNh1wHesJ0C0T2dxtq9Hl2SWUiqVxgAjC8HhTD0Slc7yUXTydO+5o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10bfe30f-7610-4c95-a510-08dcf365c851
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 13:22:45.9218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pjz+uZ3AE54iT1Uum3qNv5tEAZupt3yAHuQPAHjC+lGeEvlawX84h5EFrFpjpSWKs8cehmqK7L71Ud06W+x+b+G/eAQkQgkVUty0zFvF3Ww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4852
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_10,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410230079
X-Proofpoint-GUID: 5Cz4q9Un-mdom13GWZyRA-8IJZnKB6MN
X-Proofpoint-ORIG-GUID: 5Cz4q9Un-mdom13GWZyRA-8IJZnKB6MN

On 10/23/2024 3:45 AM, Tian, Kevin wrote:
>> From: Steve Sistare <steven.sistare@oracle.com>
>> Sent: Wednesday, October 23, 2024 5:01 AM
>>
>> +int iommufd_ioas_map_file(struct iommufd_ucmd *ucmd)
>> +{
>> +	struct iommu_ioas_map_file *cmd = ucmd->cmd;
>> +	unsigned long iova = cmd->iova;
>> +	struct iommufd_ioas *ioas;
>> +	unsigned int flags = 0;
>> +	int rc;
>> +	struct file *file;
>> +
>> +	if (cmd->iova >= ULONG_MAX || cmd->length >= ULONG_MAX)
>> +		return -EOVERFLOW;
>> +
>> +	ioas = iommufd_get_ioas(ucmd->ictx, cmd->ioas_id);
>> +	if (IS_ERR(ioas))
>> +		return PTR_ERR(ioas);
>> +
>> +	if (!(cmd->flags & IOMMU_IOAS_MAP_FIXED_IOVA))
>> +		flags = IOPT_ALLOC_IOVA;
> 
> any reason skipping other checks in iommufd_ioas_map()?

No reason, just an oversight.  I will add them, thanks.

> 	if ((cmd->flags &
> 	      ~(IOMMU_IOAS_MAP_FIXED_IOVA | IOMMU_IOAS_MAP_WRITEABLE |
> 	       IOMMU_IOAS_MAP_READABLE)) ||
> 	    cmd->__reserved)
> 		return -EOPNOTSUPP;
> 
> 	if (!(cmd->flags &
> 	      (IOMMU_IOAS_MAP_WRITEABLE | IOMMU_IOAS_MAP_READABLE)))
> 		return -EINVAL;
> 
>>
>>   /**
>> + * struct iommu_ioas_map_file - ioctl(IOMMU_IOAS_MAP_FILE)
>> + * @size: sizeof(struct iommu_ioas_map_file)
>> + * @fd: the memfd to map
>> + * @start: byte offset from start of file to map from
>> + * @flags: same as for iommu_ioas_map
>> + * @ios_id: ditto
> 
> s/ios_id/ioas_id/
> 
>> + * @length: ditto
>> + * @iova: ditto
> 
> prefer to duplicating "same as for iommu_ioas_map"
> 
> also adjust above lines in the same order as following fields.

Will edit as suggested.

- Steve

>> + *
>> + * Set an IOVA mapping from a memfd file.  All other arguments and
>> semantics
>> + * match those of IOMMU_IOAS_MAP.
>> + */
>> +struct iommu_ioas_map_file {
>> +	__u32 size;
>> +	__u32 flags;
>> +	__u32 ioas_id;
>> +	__s32 fd;
>> +	__aligned_u64 start;
>> +	__aligned_u64 length;
>> +	__aligned_u64 iova;
>> +};
>> +#define IOMMU_IOAS_MAP_FILE _IO(IOMMUFD_TYPE,
>> IOMMUFD_CMD_IOAS_MAP_FILE)
>> +
>> +/**
>>    * struct iommu_ioas_copy - ioctl(IOMMU_IOAS_COPY)
>>    * @size: sizeof(struct iommu_ioas_copy)
>>    * @flags: Combination of enum iommufd_ioas_map_flags
>> --
>> 1.8.3.1
> 

