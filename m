Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B6F1A76AC
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 13:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729690421; cv=fail; b=SoZgQeBd8pC3TuJOImAXHvkpqUEMAJ24n7SwDlNLvQGdZTCIcGTAO7DoOuHMgf6NYDcgZT1VzqqFtuI4kmcYOIpuJQsPOV/nLCKpzPlUqOclI7ukrebnxUyV1qY70/fenYRbCee11al/ykJZ+Dym2NqCau5+qTwdMjNve47CRrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729690421; c=relaxed/simple;
	bh=hezcmhWddzWlBS034HQUg3t/65TpbFMkZLw1uLTdwls=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JGQLI+eYdMmyvtWvw1wQ9O1jDLwFlN5/y3qezU1j9UzujkBDTp91LlcAvdzFHrKiO1DNYWJmA7M2MTbfIdECgOWCZaSBcx6NTq8CJT1VLgSzm/5B3doWAZa7ymujlufLcXP8+f3Y4B0hcQ0E+WEIXq3VBzRd7sEQXRbY8FlPVWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GKcA/dwG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xJ3fyq4y; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GKcA/dwG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xJ3fyq4y"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NBQWOR017377;
	Wed, 23 Oct 2024 13:33:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=u6JBv4iFGsnYlAeLPp48NUC8CEhxmu/cFfpoj5aFfEQ=; b=
	GKcA/dwGmMcm+PUcqxaLoPZi3wMC3Kt+K9ir51AS1ohx34pv3yK1d4doUrmQE0Pn
	eX1x4ExnMRkH5hfCGSlCMJ7DKiGN13OVi3jYsRBOpFuBIc+w2xXapWHNPCCbl/ft
	vLOWVXVC0d5EPC/AQyB9X2HgM2IVOCmRSEt2RnWF8Em7TRo1j4n2lU5p/0LmwhQK
	KJgpLGot2Eh5o0TLrK3gp3XzwxlkDK1s3J3CATTr5rGvRAsixhQh2b+m9TD2b5wM
	zvnnSDLjNUDP9RZy7nmYHZ1oNrRoKG6jpn68QUM1o8hIWv4VSR0K7a83el2wDqip
	oLofcWIxFpsRKDdsorLZ1A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c545887c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 13:33:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NCD9iT027514;
	Wed, 23 Oct 2024 13:33:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emh2u2fr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 13:33:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNqJOQUvpQpCVSk1Tu6/8tLU/701KRkrklK7hr4P+jl+ccok7T4aSVFem+KDOrCp+an5H0DsLVNSvOxD1y79DmZX80CjmOyn1tth8ghYDxmPn4fekbmE8LYB622MkvA5jmbkdquQt/wR8JJ+acVcHWm1C/xtJ7rf8lx3o/W3rXEejCkpkCqn885ofApaJaWBj4Es86EpgsbwdGXzUptp1MwWcPcfhR4WJ6c8wtgS9q0zdNOq5sC97e7zCAM9hmYhGMt8Evka26qzB3hPY3f18opPOKQ57ybuCcrOGlZGL5hG0gk8v9iTUA6QztZUu1BwT1gv47XGdXuxTNEWOH9Cqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6JBv4iFGsnYlAeLPp48NUC8CEhxmu/cFfpoj5aFfEQ=;
 b=czF30AHJ7mpN9rjlUN+qj2oyhHnpoFHtXGB4aZNMENk0TUA6c7e0QHdKP2S0g8AsyBgwgePOwS4fmFbs/Au5zcaTgBRN2IECjEabK98AYqjW5TkKYjL1+Y89ALUOiRY1Iyuzbcc7hkguTl6T2RkfLXf7wZzZEe7EAhXg/KPTSoMW+iyMXhtwjq+wojjf5KjhNeO1HQnUPynVYY1/nHTTV+ufa1Eu09fJn021/c26Yk88SEa1zLTLO8XYGCryfnyLl/fuNPNaSh6AdEmXRFiN0HGN/RHQNXZWSfnz9k8eH1FCFGrjq0CrmKYmQSxTwPSUQ86AH8csfGfxUbv4tdeSvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6JBv4iFGsnYlAeLPp48NUC8CEhxmu/cFfpoj5aFfEQ=;
 b=xJ3fyq4y+2L6U1zSjaqjWBSV9e68mRAP1LYpQLBmWDqXxd4j/Czhfa29B5YrKFfT9icmTfA50CWIPyZH4A8Dl1/0uFaKKVpu5Pe0sDJdyYnRsPXhO6rggZDlk7fzk6KJ6Rc3niE+SMKhUzS+QLM2cYaTjWlzyjKsJJsQQCP1vLU=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SJ0PR10MB5669.namprd10.prod.outlook.com (2603:10b6:a03:3ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 13:33:25 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 13:33:24 +0000
Message-ID: <4d16e8fb-be9e-4e08-952f-4a55dc197271@oracle.com>
Date: Wed, 23 Oct 2024 09:33:22 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 3/9] iommufd: generalize iopt_pages address
To: "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
References: <1729630838-24586-1-git-send-email-steven.sistare@oracle.com>
 <1729630838-24586-4-git-send-email-steven.sistare@oracle.com>
 <BL1PR11MB5271465D8BC716BEB29A0ABE8C4D2@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <BL1PR11MB5271465D8BC716BEB29A0ABE8C4D2@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR12CA0030.namprd12.prod.outlook.com
 (2603:10b6:208:a8::43) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SJ0PR10MB5669:EE_
X-MS-Office365-Filtering-Correlation-Id: e7a9658e-a092-40a2-8347-08dcf3674535
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elhneDl6YjBUTFpPQ0I3czNtSHV0ck96Q0NobXRPNHRIb2pwdUR2SVdpRG5D?=
 =?utf-8?B?MmdhMWlUMnQyWENJOWhYNURoSUVLekZaaXFuRUJBcWJ3WHdEbTRpaGpnNGVE?=
 =?utf-8?B?cW9aTUdwemZSSVo1Rk84VWlUclNrcElhM1dXNVQ0WXZMVC8zdys2TjlyZkx1?=
 =?utf-8?B?UFJQQ1liK1ZjYmE4Rk5VS3pldTRZVTUyekpoR1pxcEN3K25MNjhMeEs2cVVj?=
 =?utf-8?B?U0FHNFh6YWdlRDE2TTJjekxVd216MDRNa3N5Tk41MnZ3V2crVzZJaFFHdlZK?=
 =?utf-8?B?TGlCa3RrOGxseVU3VGcwajh5QUhvR2ZJRU9xRExkQXhJRWpOYXJvTEpkQ2xI?=
 =?utf-8?B?T3NKY1BTUlpjTkpReEdNenNHZUVoeW11UDJwZ3pTMHZrVkd5dEIyMEx2V1Vx?=
 =?utf-8?B?NDNyR1RuZHlXVDgwOW5tM29Vdm13K1hFaUFrblZ3eGU3YlhpSFAxeVFQNDVV?=
 =?utf-8?B?eWZ6c01tUEc3ZWlPMThDTVJBRUNGaEFnRWl0V0dmekhGQ1ZMRFlpVU9zUTZj?=
 =?utf-8?B?RXkxbFVweUtGTExDVjlDb2o2MVhYaDQ5SXliV2lqY24wNzFQclJsNUQ4RTNw?=
 =?utf-8?B?MWZaMkEwVlVZL3NjL1c0ZGtGWWtQVVZiMkFkYVVkc05XM25BK2x4OCtRczFi?=
 =?utf-8?B?U1lDbWszd2EvYm81eWZIb1oxZVVnMDcrK2hIMTk0ZTV4NXcxUnJXTEFITmd0?=
 =?utf-8?B?NnlCSkZpSGNXU1dGRVdiRW0xTFNwVTNrODVXRjZ0UzdPMS9rb014K2pTdk12?=
 =?utf-8?B?bkhRYjhiL2daZ3BLUU5JRzhkUWtiVkpydyt1L01XYUZSUDVSd000UVRuQ0pK?=
 =?utf-8?B?YmhvL0ZScjVTTTQ5b0JROFBDR1QrSDA3UDl0QkJGN2MxTTRNY1k3bDMxWXF4?=
 =?utf-8?B?WndSS2xNMjVPTDNSRkJzQldXeUV4Z2Rsa2U2TjNiK29UeEZpRUFoT1dmS29a?=
 =?utf-8?B?cWxhajdKRFhsSlRxN2xNdGpLSmFjY2d0WlZmajJPclVuU0xuSllHa2V4Zkxx?=
 =?utf-8?B?Q2dkdTlGMmNlMGlZcHlmODdkVmFLbGwybVhSbHltcGdzUXdiM0xFdkFQZFhr?=
 =?utf-8?B?R1V6dmFqWjNTejFWanpNWHh5Tk9rczdlWGhUbmZzSXlnKzJKYktKdmNxUllu?=
 =?utf-8?B?cDQzeENyVmxIcUt4NUlPdzdEQk0wQmJFVm9yVWp6a2lVSHQycDNmM0xhekY0?=
 =?utf-8?B?UHZsMXBHeElMdk5IZlMvNXh0RDM1SWZsOFRvVk5pNkdrYVhlSUhKbEJVNXBJ?=
 =?utf-8?B?WElKWW43c3UwWXY2amJSMVhRdXdla2dKaDZmK28wb3pQVFIwbjhkdCtQVWpS?=
 =?utf-8?B?R1Vtb0hYVUdJbHZtSCtCWTRVOERWL0lreFh6WW54M2phZlB2eFl1VWdPaXdt?=
 =?utf-8?B?Y2IxTE15dFRzV3NJMGhuSnY4YzlxMG1aTEFaQ3dSZlJwR0tIVjNYQ1prQ1Ix?=
 =?utf-8?B?REhNRHJrMjBCOFZ6Z25KcGRxSisrdUErTjVtSEpIbzF6UkdvVkZVbVFRZlhS?=
 =?utf-8?B?em9EZmorV0dFU3QvYzYydjFVYW9FUUNlNDI0Z1d4Nzg4dXhITkRLM2EvMkNV?=
 =?utf-8?B?Z3R1QnBTbE9jRDJTYS9aT3lvRG1zSDBwNmRnZHYzWEx1NFlZOStOTklCZ3Rw?=
 =?utf-8?B?UkxCSms2WGloUEdGQ2lQQnlwK2haOUZ2VEVqK3JOWWt0dDl5MXlCbUNSZUxp?=
 =?utf-8?B?S3g4bmlJaUU4UG5CbDIweHdYeEZrTk9pT3liZ1hPTlVZTVdDaWZRL21GSlBz?=
 =?utf-8?Q?5EQmkC6P3GmvM0rHG3deny5tvmcffVVfdPNystt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmpVa3FWR1oxWVorZVBEMlU5MFlJNHI5T2I4bnRYcGk3VlIxNitIYTVFS2Nt?=
 =?utf-8?B?RXFQcm4xNTV1eWJNRzNuTDVRekNNNmtacGV1L3hkQStwa1NuZFFHbGc4MGNZ?=
 =?utf-8?B?QVQvK2QrdnBreSt1dUpOZm0vNHpzSHQ5aE54SjgxdjlKc0hKeCtXeEt0Rm5k?=
 =?utf-8?B?UStNYkRsbVgrVWNwZ3ZtV3FEVDM3Vm9LQVJrY25QN0tNWEw5eVZQYW5ISVNK?=
 =?utf-8?B?c01GWm1JcEk4azg1NzllbVMyN20wVUJrWVNseGFYODR2UTF6YitWb3pXV1Q4?=
 =?utf-8?B?QkdlcVZaZER1cVdXSHZWekZJcEF1U1VzR2R6cVlZcm92K3cvak1HV3hwa3Y1?=
 =?utf-8?B?c3ozQ1BRTERHNW5yaU9qVzFnZnYzOU1XVlczNklwajNlQVU3eG02ZUJ3KzRL?=
 =?utf-8?B?N1dCTlNPRWZjUXBWY2o0UEM1SC8zZWVaWkcrTzVzdWxLQzV5Rk94bSs5R000?=
 =?utf-8?B?VG55S0JHUlJCLzkxUUdqOXZFWGZqQVFxdHo4Q3NMaXlERlptekFrZUpJNk8r?=
 =?utf-8?B?VFREMFNrVWFjZGw3ZERwZW92VElMTkNzNXd5dTM1VDBLN0U2UFl3SUN1SVNC?=
 =?utf-8?B?anpUSDR3anVBcHNIQzlXak5uTm9yTEZYMGN3Q0E2ampRWEhsV29XcEorWXkx?=
 =?utf-8?B?WjVvT1RRakVsMjJKNTU0Ujc5MCtNTmgyOEhjZEpKc3dQN1E5UDVlSUhhdlpu?=
 =?utf-8?B?NHc3cGgwYWd3bmUyeTFZSi9STmZMbnVFMndaRmpHdWt4dUJIWXBTc3lUdDJD?=
 =?utf-8?B?SzhiTm9QSnVjVGJJWXp2b3VoYjcxNDRJcmNjTldiLzB1dS9YQUJKaDVDcXFk?=
 =?utf-8?B?MlBxZW0rUUJqdDdoVXhod0FSdHdDTSs0dUh0RlViTG4rWDdRRE1NaEE2emRj?=
 =?utf-8?B?eVpFeHhQNkRPbExwZndnSE9VK01ubEpJWWVxRm5aYlBXeXErd3U1WFhycWRx?=
 =?utf-8?B?Z2orU0JmSWFZRVpyN1V5NUNrS1JHeFhVejBCaVhoZmwvWE05WG5FWVdUb0tR?=
 =?utf-8?B?TDlsZkZFQythNU9WWEFUMFJqVFd4aFpjalN3amUwUE1BS2YzRFh2OVBKdDVV?=
 =?utf-8?B?eE80WHozQnJXU0E2UU5telhjdG43ZCtEZEM4U3FNeU1FdVlKZVB3UmVZZmw1?=
 =?utf-8?B?M3QwWUdySCtjZE1FZXhyVGJ3Ri9MSnJLWFVBMGI0RG1lZEwwVGhBaE9oRHZW?=
 =?utf-8?B?a0JlVmVnVzBRb0E2WUdlbURsU3JTNUQ3d3A5MmhIU213RGpwQTVwaGpFeUxL?=
 =?utf-8?B?bXhQdXpDcDg4RFVURzVaMXlVNFBtbkNlMzdNOXlRWFFmanhTWVVWN2Q3WFR5?=
 =?utf-8?B?TFdxT0w1c3BHSmN6VU5KVFhDNGxMNFQzV3BCenNKTUdEOFRsQzBpcTU4Y1NH?=
 =?utf-8?B?MTRzVGhYM25QTWsyVHVQOFN6aHNFMFpqMjZtTXl3ekttVnoyQ1VOVHBreTZ6?=
 =?utf-8?B?bW5JQnJDVTVaeGxNWWZXK0dtcVlPRDBSN2VHb3NEVi9la2F1WUdWN0Y5a3Bh?=
 =?utf-8?B?STJGZExEbVlmRE9pUDZBNTJKK2tBNkszUjNqb1hNeUlKYi9YNTduNFZpdWVU?=
 =?utf-8?B?K0REc3R6NEdDZnAvQ3Rib2dTL29zSExSVkVXbWhrSFJ0NXRjTVBTN3RoN1FV?=
 =?utf-8?B?Z2ExNGNTb0s4dDJ5QnJxMHNRSjlWcUVRcU9hZHpBZ2xrNU5BT0tlZmtnK2p3?=
 =?utf-8?B?ZmZqbjd1RFBhcEpaVDZpOFNDcS9NckQrNkdMNndMSnRjSHorYmdaQ01FdHFT?=
 =?utf-8?B?MTlja0ZrVFhnYzFvVktZeGZjczVzdjFrbGlMaHVBV1E1emd2dTBGWHlpb3lH?=
 =?utf-8?B?WHBmQThkcDRwK2ZFY2Zpa3NGNkRtR2RIdUtJajI2OC9uLzNFVVVOaXNiZ2Qz?=
 =?utf-8?B?bVJmdzZ3bEROSlBxanlHTEZJbWh2MFRwT1pHTDN4a1R3ZVNxQzFmT0JzMzNG?=
 =?utf-8?B?YzgrL3JpeFh3dDBuSFZldHU2dVR2NVUwNmNSeXVyUmpnSDhDNjI3QVdFRVNS?=
 =?utf-8?B?ZWw4UlI0RldiTndoYXR3bGNkZ1FVSmFRRmxLYnY3d0lGOTBKYzdRa0Q3SnE3?=
 =?utf-8?B?UEVnT3dQRk5VdHZRRnJwMUU4ZW94eU1sWk96aURzNFB5clNBWlBCUStOVDJH?=
 =?utf-8?B?SllRenVoYzZMNnp2V3NuVzgzMy8yTStIVEtjQXp1N0gzbzQzL3BSQUFudVhY?=
 =?utf-8?B?Nnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	n8ibPO3aEtwRxarNiS/6HqXyV4GRMC5dSm0NUkKfrx8rhAW7kxr6qF+lweIIi+mgJrWFkqst42w+6qsQx5gar+GtNPrUlZ0/VdkqisXgZkVNifagNs+zUBScfSL24WPzRfB/4ia/yDFBylWcWqI2fpxdGt737dkZ03RFqC1DWpU01DWKcCThnVub1kRq7uThE3UfPEhFzHHsmWyXjPtuZRpSx653j/erfuJ7EIsShNkKAWk2PVLJCvznvI0rhKsMvXDssu0wGpp4ektR95DM+7TRgnF2+SYcPVWUt5gbZ06ikxsUTLlycd+cu/ToaUNkUR/rgvZEq63u0oH+EE6CYflwspMpgxO+SSu7pFvj32dN9asr/TBW4Ce8I62XcCkh0U42IEzZtqNg3ZHzeHnDO28moGHtfYOFFDvAqMeUjhgX/nNlT2nm+ikiCKdRKJeUN+bNLWV9DUFKDqA4g498E7jBZu8elZS8CTHa83/xVsGrPCgTigdOnYBDfhDDF6eIHadlwM/iLpQ2aZpayhcEIv3UNIIqvVe+BsunZv01vJ9o3i0eye3LoHpsxQFaoNpoI2NnN+OdUxYrMnN4xTsH09neJMOW/sbLoIcNn8pYU24=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a9658e-a092-40a2-8347-08dcf3674535
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 13:33:24.9283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pnk9QFYEB5NK52fOx/RDgUibxMJw5UcnCrixy0OSOXaUehjHLmU4hCb8M22vNwpfNOkGCkI0LoYCcaPOHyY8enClcCnfU4bgYMHZKtoIxjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5669
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_11,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230081
X-Proofpoint-ORIG-GUID: MXAa0KR441RWw0edXrub91RTlnA8iVdB
X-Proofpoint-GUID: MXAa0KR441RWw0edXrub91RTlnA8iVdB

On 10/23/2024 3:08 AM, Tian, Kevin wrote:
>> From: Steve Sistare <steven.sistare@oracle.com>
>> Sent: Wednesday, October 23, 2024 5:01 AM
>>
>> -struct iopt_pages *iopt_alloc_pages(void __user *uptr, unsigned long length,
>> -				    bool writable)
>> +static struct iopt_pages *iopt_alloc_pages(unsigned long length,
>> +					   unsigned long start_byte,
>> +					   bool writable)
> 
> it's more intuitive to put start_byte as the 1st parameter, followed
> by length.

Will do - steve

> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

