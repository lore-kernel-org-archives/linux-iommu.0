Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1124C7E
	for <iommu@lists.linux.dev>; Thu, 26 Sep 2024 15:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727366400; cv=fail; b=LwhwHAr8EZqUoR8h2b6sxoCO+OrG9edwXCu9Bqkvk545FAfH+Rzy7u8lPEwpuvqyxOcJudmVJUf9Bl5xUsu7Ic2R8eiPBhKY1M2R3bxesaDZJpdSReiqBIYzVW0THaHRSt7SmWPVMLtqUkIoAG00WdfXD3N2YeMP2bA30xqNUC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727366400; c=relaxed/simple;
	bh=D28lHaZ3co4gKqGj6p9j4TiqULA2COqxvHUuRIGoEoE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H65i2kJ6FwYEoqLvBgB2teIC5fum33eY900gmMaCRdUG1BNXkCfdNwSbvffY7onSK0UF8pNRH9hhoKEwUFtjPrFVqibyfPYq6tpei0JyNlRpvPeMWdrlK3clY0smMsrKhM5r8tppTgnJWaww1aLNNTWlLf6GyYBwNBf+CnV8ks8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b8Q8HUWH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=smnVZKav; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b8Q8HUWH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="smnVZKav"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48QFiaP8002947;
	Thu, 26 Sep 2024 15:59:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=VqqCtpDf2w5G9QBsevm+Hj2X87YonEnsM/m6hOTujOw=; b=
	b8Q8HUWH3fBrcAD6YoXE7vjLXsn0FvDkG6tJjdzDKyE0qDnYUF1VcRmDcayOG4KB
	kj8z6vh16jxSb1WPdMxO8EE5M2vl6vdH37OBT+gYynhDZKJ24AD7CpBgJmAqQHjv
	a2doCu8hw9NgslTGp0giaqtZl7CZQCw4FhQCajTkph0sDWEOk0HLskAKY4Rlsd6S
	OLHSZ66t+Smzh8yAS5bQAzZCpnR6So7Q2ncVQT2S6G6uJrZ+Pje1xXVcIRJaBAm+
	LcDJe6G6dfPDJvyWd9BU5vmYXWCvQV+S6hLDvEquw9f+L+cvW4DbJCeZBDfuYu3J
	ELd5eHXgO2OhdNQ7vuEIuA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sn2cwq36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Sep 2024 15:59:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48QEvUcC032896;
	Thu, 26 Sep 2024 15:59:56 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smkjnm0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Sep 2024 15:59:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIMXNohCQqAumG6esWGAgdx06K43FerFUUUdy9ISBefm5DrYmNSfa/pQZL9QJ4V5Ew+LQHaWMgDpl7MAeSA3UgHgWCXHEvm+3Dn67CJe1SzLSKByhgKcVt99fM5uqhLzWG71v5a+oiPBHmXYvF3GCp6m2MDr3Koy6xXC2Kb4REmLMv/lI1y/0/F696lMSi+wPsSb7GOAbcLNkYg6zFhCcqwTpLoz0vppa5gsgVjyXKuNjTwTxPCQDhQaexVrP8or1Fe54fFlVhZpEZVWtx4nG9TH9uFtQv7iA8Xdsdu3h91jRaF46Hlvj+1KiP8dhDeRe1jrf5A1goz9gUv9o0cm+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqqCtpDf2w5G9QBsevm+Hj2X87YonEnsM/m6hOTujOw=;
 b=YY6wlp6AmOm/5XaaI7f4JFtq7RBgmoYCqIjwcKc1ti1QH7vo4z3gm4vRAlp1wf1CX4Lsy9QnJiiDTZkJwDShviiAKSigngiQ4eST9wE/pSTJ9GWN5HdfriJ5Wrm+W4pugiTCN0haWCLkES31DDLMGQBSbSz6+LXFaMiExTJYYctBXkZjlxw1lR+AWIMvAgOgNNjOTjioEnFXzD8FQJLKJpwXZIX5MftVUtDl0KqOfCx6JYwkQZE/ODU0MBi240mh/zniA3wTr4i/C1lt2SPwkCZlrIpLA/HAnsHHPuSCbztHyUz0rF6naGaMFWY04jM4ElXp4p/Bj0b1XccEoCkBJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqqCtpDf2w5G9QBsevm+Hj2X87YonEnsM/m6hOTujOw=;
 b=smnVZKavW0jYMfIv2nUkVB9gtoQjyhvlSTzuzwXKTZfrUdjvJWDorqrhRMhuwlCtAO+mOsIR24onjqR8z3yc3ijml3AGI3YEKXG6Vf+1yFn6uMHD1kg3pTH2K/dvY/Bce3zELO99W+rXqHQzhIxqw8zcVR/wI9PJp/QA6JR2csM=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA1PR10MB6616.namprd10.prod.outlook.com (2603:10b6:806:2b6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.12; Thu, 26 Sep
 2024 15:59:53 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8026.005; Thu, 26 Sep 2024
 15:59:53 +0000
Message-ID: <8cef3a05-5bb5-47f9-9ded-0507354c482c@oracle.com>
Date: Thu, 26 Sep 2024 11:59:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/9] iommufd: pfn reader for file mappings
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>
References: <1727190338-385692-1-git-send-email-steven.sistare@oracle.com>
 <1727190338-385692-4-git-send-email-steven.sistare@oracle.com>
 <ZvMm4xH+2xkeXO0G@Asurada-Nvidia>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZvMm4xH+2xkeXO0G@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0277.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::12) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA1PR10MB6616:EE_
X-MS-Office365-Filtering-Correlation-Id: 925f2786-5182-4e95-b5ba-08dcde444256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R25aTWtBemVsdmZieVd4MmN3NW1nZlJhTlFnMDlZVUNNK2JrbFB6VjBmWjFW?=
 =?utf-8?B?aGxndG5Qd0wvOGh3aHVrNnF3MHJHMUFCbFZlR1V6bG1iazNBcjY0ZFRrSnVU?=
 =?utf-8?B?SHlPZXR3UHduSlFVSWFHVDBKOVoxQy9BQkd3Y3hBSEVFYzIyS1pyYUpTS3M5?=
 =?utf-8?B?RVIyNnAyRldxLy9PbEl6c0I4RnlUemhuYXhrSERtNlBacHhEUk5VTEZNWGJl?=
 =?utf-8?B?OUZUYWhWTGY2SWxRekhmTEg4TXBDZzBsQm1rMWo5SGVFcW9oRjRKNkRHbXNW?=
 =?utf-8?B?QVRRSWF5MmVFZ1hVSVZPZzhnK1lKSkZ5RkgzeWwrNG1RaURpQXVwTWUxYjNH?=
 =?utf-8?B?NkQ5TDdWMVE4cWl0NG13L045OGFramJUU3Q5SnBrNnFFK2lPeVl2T01hUEUv?=
 =?utf-8?B?VGZSWkovcm9vT2VGaUVGSnhPWmdjZkk4N3Y4TTY3VEFHOVFCT0ZWQXZkVmRT?=
 =?utf-8?B?eFZmeDZKZWdJYktnbnFkcTgzNXpRZ2g5ZnE0RHQ2U3R2SzI2dEpDRDA5Smhm?=
 =?utf-8?B?RmlDYVRzSzBzQXJqVzZQWTFlelg5eW5DcjhTUDd4bGZVTStML1RiL3U3Qmtk?=
 =?utf-8?B?dVNRVGMxNE9JZktmK29RZ1VNeXdXVXAwOUtiU0lodnY2K3pPVUxLdlIxLzYw?=
 =?utf-8?B?NGo2aElYN2JOaTBhS0srL3dPRHRGRHIvYnJyWGJLQnBDNDcySERQMDJPL2tB?=
 =?utf-8?B?ajdJcUdYMWZJK3BwaVcrY2Z0aGU5cFp3bUw5YkM2aGxHMy9VSC9rcHlkNktZ?=
 =?utf-8?B?TWxTVlg4SldqS0R6c2tqbWMxeEF1dUpjSlNpTkZNQkgvTDFlWUkvbTA0Zzh3?=
 =?utf-8?B?eWpHSk1UdWVzbXJjZVE4ZUxlTVVCa0RqWm9vRmxsTEJ3VzlZdDg0S1NGdEVL?=
 =?utf-8?B?NnhZdHI5U0gzcW4weXE2WkVncTBCUVc1YXJvc0EyN1krNE4waUdIYkJoaGhU?=
 =?utf-8?B?TTViRmowb1NDMWNwUFJ5VWxSTGV3Mm9CV1Y0d2JoQUdXV0dEVnBMMUU5Q3o4?=
 =?utf-8?B?bFRJY2x1WlBJc21kcWxCcWZxNEdjK2lXa081QVNhLzhwT2xRTXQ3WkNVcGxt?=
 =?utf-8?B?azZvbUdCamdmUm9DcHM5M21lNnJNdEdodGZ5RGZjYVowMlVlR2xaZ28yS2Vj?=
 =?utf-8?B?K1ZFeGRzQzBLWFVJa1JxTmhlalpBMmE5M0M0cmViWkRiZ3UwbHl1Q0hLTmRs?=
 =?utf-8?B?S1BaZmNKT2JvSGwvd1JSclQ0Tm4yN3FDbHhMK0IyQlpPTkd6b1k2NXdtcm9L?=
 =?utf-8?B?ZUk3allvR0lFQzNJc0dUSTRHRFdiY01PSWVGaVM2V0hZb3YwYnVyZUJFVXFJ?=
 =?utf-8?B?VmljWGwvYk1KcWFKT1hWM3pUMkxCYnc4b1dDUHhSc2RzOVR1dVY5WmF3V1pn?=
 =?utf-8?B?NVFWVXBublVRbnZjc25hRHc5aTFmZzdMb0RwS2xsKzRad3J1RklnN1gwM3JE?=
 =?utf-8?B?cHpFY0hSbHpWajlGY1VMZDRqYmxRU2VkWUFVdnRvbUcxUnE4Mk5kbFNCdS9w?=
 =?utf-8?B?R0NYUks3VjAya1FHVm1BSFdpbGsxNE9uRU5IaWMwWmVsS3hEV1VYNGVmTGpE?=
 =?utf-8?B?cExBb0lYamtXclB2WldvY0Fnd0ZtU0ZOSDhFVE1TYlhyVWxSdHhLc2JFZEVi?=
 =?utf-8?B?cnQ2ZjBzTS9ETEd1V0JPMGFndmNRYk1KYUpvWXJ6UTRaSUdENjJkdUNPTlEv?=
 =?utf-8?B?WElOem9KTjJhYlpvV2pOOWhTMzFrZlFWL1ptYTdWUnpyRllhTUhEL3pmMGFl?=
 =?utf-8?B?Q2kvR1JhTEk3MUpMa3hyQUNNV0RVSzYzMHg5SlZMQk9HZi9abmlXU2c0MnB4?=
 =?utf-8?B?ckU4QVVoazBpbWxoalRwdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3Nub0piY3daOWNhTGZBV3NaVWZleGxlWWV5bkY2UFppeFBJbFJvdjFNb1FT?=
 =?utf-8?B?NmF4cDlIV3RENzhNbDFWWnB2TGtpaW9FdEpna0ZpOGxpUEZHUkZIcHpycDlP?=
 =?utf-8?B?czltYy9XcERWTFpmZlpCeVp1aXRvTDQ0YzF3dVdaOVdrcHZpTk94VWFoVkNi?=
 =?utf-8?B?dzNtWnJsVkNuclh5a0JUeE9zRVdSRDZ1NngrN0U1OTZmVU9XalVPZm9ZVWlG?=
 =?utf-8?B?c1JUOHZLR29ZYUtqWFowM2pzRUNCeDhjMUs4aEdhN3JQM3NOcFFIYXVqMEQ2?=
 =?utf-8?B?QUlUK2cyaDdOSTFHY2VxVVRoRjNRZThCL1piNDQ4UnZJRUx2dVpmYTYyaTZv?=
 =?utf-8?B?T3pMYVJiN1BOd0IrNnBrN3NGSEdPbzFmTStMQzNyYkZVczdsVEJGUHlYVVgw?=
 =?utf-8?B?YzFxVmRBZXBrRUdSYThrSjQzZkw3TnRiL2lnTXd3cHBtWmZrbCsxM2dwWTR5?=
 =?utf-8?B?QnMxMUcxbVo2Rk13UXNzYUxTM2dQdnN4bkIvTDllOFUzd0tja2VPb3pJMVlx?=
 =?utf-8?B?WnpiYkdweFNJMFlMVTdKczJ6TmpqZVViNmc1MEhNakxqdlRXVkpnTzJiclgr?=
 =?utf-8?B?RDdaVkFkU2lnd2RmdU5IbDJiTFlyNndOSjVHM1NpZTYzcWRVTXFEVUdscFFQ?=
 =?utf-8?B?YUc5eEhLOW5QYkpFWXJxR2M4TFZhaVlhcjUzbi9oaEJ4MTdoNEhyZjhET2hs?=
 =?utf-8?B?c2hBTUNSL2prNDRXbm5uMm1YZXY0YUR6M2lxTTBXdlBtR3lPeGZkd0hWVWky?=
 =?utf-8?B?VUgzc0hIdnRPeENkdVFNMWphWTVPR1Z2cVNoeG4yTGtCSVI5T1VJaEk0Ukwy?=
 =?utf-8?B?ZjNGR3REbGlBUG5icGpZaGtZVVJ3b0Y0bmFRclBsV3I1TU1vTmRLZXNScVQ0?=
 =?utf-8?B?Q0hjdVpEVUE2bFcxVkRYVTRqd1M4Sm9IWXgrN0g2M1JodXN4Z1hReVJRUitG?=
 =?utf-8?B?b1FjZmR0RlBkdm1sS2Z0Yk5DVFZUUTIrU3BYTnhmRERQN2hqYnErL1ROWEdJ?=
 =?utf-8?B?NzVWVldGVnROVkYvbndKQmZrc2NQaFMzN0FBeE1uOFFSTktUck9Ua04ycEww?=
 =?utf-8?B?QVYyZjlMQlhNMnRucy8weDJZSnhRaHNGdlF5MkEyRlc5VUFLL24zQjgvVXRx?=
 =?utf-8?B?NFpLTnlOb3U1a25mVlRMN2p4SmZjQjRmQW9VY2VOaHZOOWx1UHZNN2JVc1lp?=
 =?utf-8?B?QkNwOURVcHlGQy96OVh3ei9Ia0x3SWE4RlBuSTd1VldNM2J4RkcwZms2UVNw?=
 =?utf-8?B?bmlkQVdqN3UxdXRrZlpGd3N5UmJiWmRXay82ZkxzSlNZN0dGNjVLaXlXeXph?=
 =?utf-8?B?N2NoalhDL0JJTmhrWThTVW9DUzlLbUJCNkRvdFVTTlg3dFJzZXhtYk4vdEMz?=
 =?utf-8?B?eFB3dE92Smx3QnQwcU94cGVmQ1k4UVRjRlp1Ky9OUDNOVEtaTmlWZlFPcUhi?=
 =?utf-8?B?WFJJOXUzaUFUamdyRWJ3ZkwzOURuZHcrNG1JVUJNUTBJSmhZYnNrQlltUlZp?=
 =?utf-8?B?elRPNHdQRFlNcG0vcmVuOEcxcEJKWE9kRXkyeCsxK0U5RDN0bXhlYjZsSDMv?=
 =?utf-8?B?UlZ0RlM5Q1ZCRWZ2UWp2NXVGSHhHak03MlR2eVB3OXdUVTNEb3ZVZklhcHRO?=
 =?utf-8?B?YXN1SURVaFZZR0FIS3Vpak1DMGE5bEU1N3hoQkVQV3hzNkRmazlYeW53MXcx?=
 =?utf-8?B?WFhURE80K2VxazZZa2NxSHgzMGxUM3ZZY2VSOXdLL25CR1h2MkxyN1VVc04x?=
 =?utf-8?B?aXM4M0xnZXEwc0t3S1JYTHZnUXM3K1hQUmRjZy84MTJZWmdkUXNab0JmVlVv?=
 =?utf-8?B?S1cyQUxIMGZucUdpU3JQK05UK2craUFYWjNKMXRhZS9Vckd5UDBhRnlncEtS?=
 =?utf-8?B?ZDlrRGNlOStSYUZrWUtIRkQyS3lKOVZUVXppM1dFTnB5dVliZkZKczZHSklo?=
 =?utf-8?B?SzRMMzNTcElVN21FdU9IYVdOTlZXZEVEWjB0enhFK1FPeDRFNG5oVGpqSDJO?=
 =?utf-8?B?OTBTQS9tM0VVdFUrSUFMdGtlODBDRTB3dlRWcFA0UENhbzJkVHdIQzA2eGQ0?=
 =?utf-8?B?VGp0VzdGcDl4ZkszdStlNVgzY0F3cHY4ai9oVit0QmxaMnFHOGZzNmhSM1FB?=
 =?utf-8?B?Vlh4T1ptSzQ5Y3FER1FXSWpiNDZFOXlhL1Z1ZXROL25YRUVQUXRkTS9MNDYr?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	b5wQzgmIO3+dlpEa4Q5yXrPrZRrkDBl2tYCyoDTw6dYMQsjgxgUBDQhUOHYUxQnIYb5FzjgPVzr8+jYXQINqZBM8ZCNg+dzv/UBnJUyVRAH0v1Yo91PJ/uM1gxj2ShCZmT0l37QNs513CGQmepsk/Lx4Tr5Od98vhuc0vS+acrTvD1zrZ6XaDD50nqZlTE8LcmQqOq9d5KZv7jHjUkpktOsEE4LoXIZcG+cStzk3uil/6zX4ufBc4JET+3vjBXM13B5ZVcaw/iD2FE/9yRFpjpQLSI8P0Zcwk4uzS0VHxLk6TliUsUBvxJtmjFHss2WNjKrZ8Yp2bgBGXHcOZg+TbYOoon2eDAKxLSel4w/OtGFyVoMYJ5MTfmwLzmweMcT3QYWYJFwC/EPYp34nnw1Csx+qZPYB589oE52EpMyovYiJ8Rg1s/C5YK0+2xorbTuCibE+FGFXCPJmbRNk43/6y/VQm5I2fyak2EIb3IZqA1nNUD7OIzIKcoI88SNvSEOtd8dIhbnfBj5ZMhzM3hED7w/TqrvQSN8v+S3XaV7rysFyPV0GFZ3ShpTKbNP97YISvtrtIgOnM+qu+RFNq8lElVfmltpUfmhGghMWKHaq06Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 925f2786-5182-4e95-b5ba-08dcde444256
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 15:59:53.3759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VNuXr0VDmTW93KsOAyLUDfjmMKiD8H3QJvJXnTs+YuDCEIHy2YuHF+gxVpWfzbKOWLBeAnSFXRL34dX+dQedfN+ETDL03gBvPXRplulrDJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6616
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-26_04,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409260111
X-Proofpoint-GUID: bS6OQkVn9OXU-0t62RrHmegfjFJAQ8x3
X-Proofpoint-ORIG-GUID: bS6OQkVn9OXU-0t62RrHmegfjFJAQ8x3

On 9/24/2024 4:53 PM, Nicolin Chen wrote:
> On Tue, Sep 24, 2024 at 08:05:32AM -0700, Steve Sistare wrote:
> 
>> diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
>> index 69822d4..df5ba4f 100644
>> --- a/drivers/iommu/iommufd/pages.c
>> +++ b/drivers/iommu/iommufd/pages.c
>> @@ -703,19 +703,28 @@ struct pfn_reader_user {
>>           * neither
>>           */
>>          int locked;
>> +
>> +       /* The following are only valid if file != NULL. */
>> +       struct file *file;
>> +       struct folio **ufolios;
>> +       unsigned long ufolios_len;
>>   };
> 
> I am not 100% sure. Yet, given the comments at pfn_reader_user:
> 	/* pfn_reader_user is just the pin_user_pages() path */
> which FILE doesn't use, I think we might need a pfn_reader_file
> with own set of helpers:
> 	pfn_reader_file_init
> 	pfn_reader_file_destroy
> 	pfn_reader_file_pin
> Then their callers should switch-case pages->type to select the
> corresponding type of pfn_reader functions.
> 
> Maybe USER and FILE don't diff that much. But considering we'll
> next add a PHYS type and none of them makes sense to PHYS, there
> could be another layer of cleanup at these pfn_reader functions,
> v.s. stuffing all FILE-related lines into pfn_reader_user.

IMO the single pfn_reader_user is cleanest given user and file types.
Feel free to rework it when you add PHYS if that additional type tips
the scales.

- Steve
