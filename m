Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28067152196
	for <iommu@lists.linux.dev>; Thu, 14 Nov 2024 18:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731607331; cv=fail; b=fKUmlstWTSuxp4b7J0A1uEImtDrV4/dlxzmIUrUxSGKssVzzygbiDYZ88G3VMYeHrRkGibrirmZR983sGi2ce86o+li7BNjjVQXAalb/f8hT4ClmTDqYSw+xsZwWKriZa5Px03erMoW0XQ9TIr9jJIlZ5EekOkZTrdJzxruw314=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731607331; c=relaxed/simple;
	bh=Zo869RnU1VGMwiD9gsW7ZWpPJ2uwMWKhPZ3Mi4fLhBM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PGMCBTdNuPNDdFXRGyLj6rDBD1I/Vc6ExVd2ScHX3Uq5Fv/PPXexYlTrHu4hpc5U6hIbsD2Oli++WSid6U7AZ5PdIawwOaJrUFP3swchnhEWdCquWNMOkdeQyhgBXqn8F8yq8pYbMhewSj4GZppgamSX/aMxJb+vtcOBvZQQgok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c0ozCdwx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hPeDGszy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c0ozCdwx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hPeDGszy"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEBlUPW015862;
	Thu, 14 Nov 2024 18:02:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=YO+BBRF70SjXqgS+iHa2lpKSJKVsTT49hrB9fkMOtQc=; b=
	c0ozCdwxeuPiQe1L2K1cjoe3Dzq2pVppPmW/SKDdx+Dr6ArSQNw3McxuF1hlTeTH
	QJ2RQg+wXlix7l8ABFNRF+faAnTTy6vx8KRc9iyN5FPFWkfxmm8qxy6lnGaMUyCE
	Qn93aUNISg20u6oYjlSQoIs9jW+h15JjHU0dcTKa7Hx7+kXSJJvN+4gCHCSHwvWL
	wS0Ae5VQ9EUzl5z9gUgZFLuR3SQTta/y+V5L4HmJ+DsWeGaBX9Je6/84jmLY9hFJ
	lwWdHdijox8YOtKj5c+3t5nnzDIZ47a4Zr6YYdBJcGjBWtdNCM62MEOBt/pnQs1j
	LmWkCHkAiSHsun0fm1e6KQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k29ttk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 18:02:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEHDfdB022743;
	Thu, 14 Nov 2024 18:02:06 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42vuw1nfb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 18:02:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQOEHy79+D7Ulp7NaOnSZUcBb2GhKFZKihsllAYNBcN0cgwHMDau6LOi2nQGkIOy95B8FwE4lJP7ppd4JlqwUqA83nyWRNnLLVCQMSWwvRjt2/cT+2timJzfPWRIt8o9Y0BOWpECwevk2HRujXLoV3ghsFV8MKuTngG0mxyTRg1RD23tF1kaOWA2js31N0cKw1Wk8nlp2E8dvaMoMl2UqafUuR9/1NRg9BbAlImVXm3jjU0WVe+3TeonqZN+sNBYUffyG5h17Kbv5KW8q/i4mWDXpaFMu2YffGKzHG/JZ+06O13nwFiQogF8e4utUjOexpn6KEjraVd/90m6jh7D5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YO+BBRF70SjXqgS+iHa2lpKSJKVsTT49hrB9fkMOtQc=;
 b=AAASezBD7U81qzYa9CpcbIzLAPZJ5sbiFsrRFQsqffe26OVcLGHKE/onV1hAh4DK4Iu2YfhFdUvkQ4zIyhv1cuP62Rmo53ltd2Ns7hOFIcqsOnNoGbqtYqAcnUG3azYvHh3lOcKQbyW4ER2Bh2vdpTz14exxRFnEG7ZVfG/uLYizD/an32/cXE8Z2RDH2tNJEdR1d5Lml0eNAVHSW9iZbC01ROubP3Dxb7WQcC5SdHeM8U6aqbTIYerG9yPoos43xW4BzU2BkMiqpUtAbb84HNMWARDK4+WOke/Q/SsvlQFlPUJ565E5GtJRuGKVR4oWGSiPGy7oh8bc7fHBH64wAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YO+BBRF70SjXqgS+iHa2lpKSJKVsTT49hrB9fkMOtQc=;
 b=hPeDGszyn7Lt81xjE/KFe9YE6ETVYcyiuhxcdXX7dY8pIrEcEoQTIHSNMhEIh1EZjJSzPHUzQkD0cS1WRSutX8MK8HrtIJe00z3rppmT5dYhS1P82sm4SaS7VC616GtEuuqSIn0s3NmXqyDsmqJXIowNakBkJ1bn/DNH7ceA1Ko=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS7PR10MB5952.namprd10.prod.outlook.com (2603:10b6:8:9f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.17; Thu, 14 Nov 2024 18:02:02 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 18:02:02 +0000
Message-ID: <84521ae9-a544-4ada-a6a7-abef39ea6cb4@oracle.com>
Date: Thu, 14 Nov 2024 13:01:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 4/4] iommufd: IOMMU_IOAS_CHANGE_PROCESS selftest
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
References: <1731527497-16091-1-git-send-email-steven.sistare@oracle.com>
 <1731527497-16091-5-git-send-email-steven.sistare@oracle.com>
 <20241114174223.GT35230@nvidia.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <20241114174223.GT35230@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0021.namprd07.prod.outlook.com
 (2603:10b6:a03:505::23) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS7PR10MB5952:EE_
X-MS-Office365-Filtering-Correlation-Id: 56a8fbe7-fa43-4202-cfe3-08dd04d67112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckZaVUt2c3AyN082N2ZqVUgrK1NoQmZVOWVRTXNsaUtOSUJDODk3TW5sVHlZ?=
 =?utf-8?B?QkhjVjdyRzRXRmczNENhdmcxS1pmS1JLMlIxdnpIeHRzOW1zaHhCMU5Rdm8v?=
 =?utf-8?B?K2ZYUldlU3dXRU11YjZ6YlYweWdSZ3cxK1VlRm1NOTRHQnQ2ajM2bTI4cEVH?=
 =?utf-8?B?UUxZR0h0a21Pak5VV3VnSmRsTml5UUgwVGJvWVgwQnBUeHdaak4rUGdJNk4z?=
 =?utf-8?B?VmtWME12bjlaUXZPdW5raVl3TDg3dHI3aHp4Sjg1NTNkSkhMRWdkSVBINkFU?=
 =?utf-8?B?bGVBWEVIOVVRcjhDNWV1bmxWV0hBcFBOYVQwSXZ2N3ovaU9WMldHaUs1WHpi?=
 =?utf-8?B?akREaG5weVJtcEtqZnFicVhWSVFtM0t0R051Y3NaSWR0R25pcHRUa2llbmow?=
 =?utf-8?B?cXZHTzN3ZjhRRVhWdUk0VllpWGl0YVFqakFGZ1ZvT2lzaFZybFhuaDM2SkJn?=
 =?utf-8?B?TGRuQW9zREdwSVl1R3BsVDBwbVYwd09GT01iWWx2bFMxOEJWMjRZb05WK2E3?=
 =?utf-8?B?M0haTEt3U3BDMlJMYnZlbHNTSXBtdzJvZUlVdFQ3SXk4SUJpNEY3b2R2ZVZk?=
 =?utf-8?B?cEZLVHRwVGw3bW5zcndBd1QvakozZ3hQRWZaSlRoWUQxNDJkd1dnQ3Y5WjRT?=
 =?utf-8?B?T25CekoxZy9VOEZUNVgyclRqN3ZISDhaRFN6emQzbHhwUndBMm40d1J3dDVE?=
 =?utf-8?B?VVUxSzhYdkJ5Q0VVbkcyQ0kzNmd6NEx3eEFUeTB3WGw3TlBOUHV0TlllZ3Ur?=
 =?utf-8?B?L0F3MzBnTVNRdG5YVitZYUxkVUxJTGtVMW5SUEJoNnBzWUlTdjNIaSt0YUpB?=
 =?utf-8?B?clRJVE5CbU1ZVkQwN1k0Zno0L3J1SXJpK2Q3MklrMTVzVW9TUEFSUHNxUkVS?=
 =?utf-8?B?MTB5MWt6bkc1UFcwaHVoOWpKaVUzYjlPM3YxOWZmN0JKRTcxS1pDZmwxMlpJ?=
 =?utf-8?B?ZWhYTkFrK2UwMTZCMHBraEFsbzQwOGs3STBOWEl0TlVTdkd1ZzNvcENleW44?=
 =?utf-8?B?N1dMVmRjQS9kTWtsMkE4aVg5eWJCYXV2bHBQNGNWempQQlpSU2JKMGVzL1Vx?=
 =?utf-8?B?b3hPSlBPa0tINWprU0o3WDBqMzRwY1ZWdW10cCs0N1pKUGpIWS8wTW4yUnRv?=
 =?utf-8?B?VHRxNUVJVStxZGdXRmhrRGhZZDliLy8zV3BONGNBNjg2R0hGTWEvWGNRd2Q3?=
 =?utf-8?B?dUVGcGw0djlURTJ2M09lM3Rpa1Vyd1N4RlZXRC8xcld6SVAveHI3cFVzb3hv?=
 =?utf-8?B?WmhLZk5OU1VUS2s0MWprVHlCOStrWndraDR0c1IyTCsxTGdCM1ZtQTJjZ2xv?=
 =?utf-8?B?TFYwQXpmaXFwY1Q0aEtrcXI5RXVRSGFuSHpBL3RqdDVMZU9KSjFjbHkyRkRk?=
 =?utf-8?B?SWh4anhQZHBmaVdybW9ER1dKN2djRlZveVpUSmF2ZUZidWczNGlVUzRBZUN4?=
 =?utf-8?B?aW9ydmh4NUNvUmtWWU1RbGF1MFZjdmg4SHFOUnlVOG1CMXI2Uk55N25qbDNu?=
 =?utf-8?B?N0N2NDFxcytjSVFBNXYyWnNtRDA0WHp4aUVuV3NRdk5uOURHMm1mNDJ2K29O?=
 =?utf-8?B?OU9sZnkrOVM2MDhqUmRSejBOUnNtV3c2WmNXd0ZSdzVzU1Q3QlRVOUVUK1Rw?=
 =?utf-8?B?OGswOElXSUdGQ25OT2FyNnFUVkZhbkpZT2lMb05NWVZLVjlEMVB0M0hyUloy?=
 =?utf-8?B?dnVPdXNtWG5ycmdrUy9lR0FMaU9WK1hoY0xpYjdYUFdnTThHQVRyallLMUZ4?=
 =?utf-8?Q?h83NqMw8T1IaWN+x7A8sB2AV3CSXWe50PHcarz2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnlUR0lyckFnN0FlTkJRbE15WklNU0xsdmp4ckRKM1RMQjAwNmxxYXNUUitI?=
 =?utf-8?B?T0JlaVlqVnlJdGhtd1pISnYxdjNubElpVW1JaGpBR0N0RmtuSUY3RHZqVDZ2?=
 =?utf-8?B?UThoKzhBZ3dPMEs5WGZ4eTc1bkloY1FqSnVnbVVHLyt6bDRrWW9obkJuOERs?=
 =?utf-8?B?VWFpaWRrTGZFMlFuZDdEbjh0NEordHhjMXEzMjFiamQ4TUJXQVk5M0lTQld6?=
 =?utf-8?B?T1k5dkFadUY0WTFKY0NRU3J1N1JJcmxQTkpsbXlVc2Fwd2ZZWjNzV2d0RVQ0?=
 =?utf-8?B?czhzQVVnSCt3cTE3bEpnMzZGTkZJd2lPNTVKQjRZUkpQbG9TOGtiaHJsckcr?=
 =?utf-8?B?ZEU4aVFTV0xnUzl5NEpLcFdONVZYRDc4NXBSY2R2UWc2NGRIWVEvUS8xenBS?=
 =?utf-8?B?SCsreGxjMDllOHNHWURoNXhpaEVoME9GVmhsMGVQeXNMRUpMeGd5cFlKcEhG?=
 =?utf-8?B?aGVTOUhCaUppb1RsTDVvWWNMa29BK3lHb0hmQVBjRHUrZ2RQYjViYWxmRTJH?=
 =?utf-8?B?NjJrOStEREN3d0tPNjNrazRoVEhVYnhvYlI3Lzllb2ZVcnJLNmppR3VxaXBq?=
 =?utf-8?B?ZWQ3clE4bytvcjNwazRBUDNvTGpsYWRTbU5LZWRycTR6SGdIRjJ1dC9NNUJS?=
 =?utf-8?B?dmxKZDJJdkVQK0VXbWVwZHZBTkp2L1FSQ3ozQnZTbWZ1SEpwU3UrRHBkUjQv?=
 =?utf-8?B?dzVrRUVoTWE1OHZMdDl5cnZNOVlFaWYrMnVKWkZKYzRzYjlnOERJL0x0c1VB?=
 =?utf-8?B?N29ReVpybTlwS1daNTYrb1BzRzJjWlMvV2ZUM2tzYzYwZUs3bnNud2JJRGRL?=
 =?utf-8?B?Y1ArUHpuaEQ0QlV5N0MxcmxsWWZkWmdaL1FqcFZia3RlYVVxUjBwLzFhUzVI?=
 =?utf-8?B?bDlCVHVaMkRNZkZpUlFyYUNjdHRpcHJGdHZteE5qQlJLY0hDMEpzNVQ4Snlv?=
 =?utf-8?B?bStHSUtLU2JaKy9rTVFkeUhFNWcvRmJFekphUzFXR3V4Z2VKK09rbjMzRnlY?=
 =?utf-8?B?SFBERFlpdVloRUlFSW1peVNvSlh3N1lxTnE2bzBEclpPRWZVZHhoS0pZbTNE?=
 =?utf-8?B?ZlJkb08vU2Q0ckMxQk5zMnRHREQvemdMZmQrU2xNNmQrSzVmanNIOEdUbUU3?=
 =?utf-8?B?dWJRSGw0UGZuVE1LVmN4WEpBSlR1cXVpUVEwQmZsdkZJbjlnVDdoWVhjdGJ6?=
 =?utf-8?B?NWVhaHZERWdWcVFVMWtua2llU0RNRlZWZU5TVkFnRXk1OFhNSThlanNpWDZH?=
 =?utf-8?B?MGJubk5CYXVVeW1DUzNZbzB6RGVBNWJha01Qc1NkY0lZUStVQXN5N2ZXTGI1?=
 =?utf-8?B?RjhwSnpVTnVUUGJlRW1kNllzUUlNa3d3YzIxbWRacUxqV2svY29FRWFKQ3ZU?=
 =?utf-8?B?eHNvU0tOS2s4VVZvVXBZdldtcUJqU2l1QzZ5YVU1ajRtd1BxQWFWTG96UTJw?=
 =?utf-8?B?b1ZnK1NsTXZ5S2ZKMzhQVTdtUWdtV2hkMzJjdHdRK2xnbEdjZk00Rm85cXA3?=
 =?utf-8?B?VnNpTkY0QW5naTg5cE8ybVVGOENvMHJ6dnFLZWcxeW4zbnVQcjBraTBSaTFi?=
 =?utf-8?B?TzZuRmNsbnFEL2lrVWVQYWIveTcvNUZ0WVZtMks3VVNyVXpsV2Y0OEtETjFT?=
 =?utf-8?B?RmlCdmtQMmc1c2pxRVVFaGN2T0luNEdkNWhDUklOYjF1R2VlVmVsZ1FFNEdS?=
 =?utf-8?B?cHNFMHhpM3lmVUlwM0JUSXZmT284bDM4UUpkNnJWOVByeElOM3JnR0NEMjdl?=
 =?utf-8?B?b0srRVBmR2gvS1dhNUtzSkR0dGY0ZHVrVWFtL0JVNDBEM1A3QUNHTUxJUWZu?=
 =?utf-8?B?alAweGdKZHNmN2E4TzB6VWhRSkJpc1ozUHdoc0pVb01hV3c2QWdqd1B1eEpa?=
 =?utf-8?B?cWFmOWZFZUl0VkF0akdSWUs2MWxzL1ZCUkJiNGY4N0t1T1FXNU00TEJhRmNF?=
 =?utf-8?B?aXhHakZuT2FBRmtNSUFMWDdxMy93aTFBc2dES1FtWTZhNjR3dnZLb0RDSlJI?=
 =?utf-8?B?a0lRTUoyMU5tMjBzYmJjUXFMUWMwQ0Mxd3IvcGt4cWtkNnZmYjByS3Vra2JP?=
 =?utf-8?B?ZWNqckcwWldMam9RamJuVCtHUkZaSy91WDM5cVhqSFdoY2ltbWQycEtKd29n?=
 =?utf-8?B?Mitoc3RZV3RnVlZVM0pSeHVnTW51MlNVaGZvQ0ZmdTJ6VkIyUmd4KytONWFT?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	anEeqQ2iQkWS56Ts3gGAJ9RlKFAeAwZHTK7+J41qAhEvzM3eRUgvD0TsGZ6GGhr73rMu8ZMZHjcGL+klFidlCsncMf9mFSwCz40i0nwGKcH/TMdY0zMaJTSAYFE3XKP3uojfh6VXfKBFyHNKcq0lh8i24ijY9hN1NzBc5TqikyhO1qkrEz+nSWT1XvkH+ZZOX/G1FopOpBHqSqqEnkd11oSZ6LS2qfTUMDI8eICUYW0BEgh88ngShUfBdJEsQczd/2qaEXS74e3UkwL78TLR0hw6Xo7hRKf7IYHGB3IF/S8xI6RSglu7ZfW5T0XPjWVborluzbSNX/FuHrU1ZH9MeWu6PqoFTtI55lpKV4bC+WiuB4cI9OhJfmSqaFxMxeWRVTsNCaAC4DL82jkBP4xGQdkesg+gQFPkZf9fq18GVAE8Q4skwFWio4moxPymEPjIDMG6o4o9Xhd5bx4TB0owd1aYP8K/vWmSfz+dgvIuhzxgoauyrrqD6hPOu7v0vyDXDHWZhhPiE5MMCg2KCFJ8kjFmT1K6HHDM9CrRvYVJaN+z/N0S81U5aa/4LruQdhuzqDdKkeqj24tJ+irJ5YQ/LxTRWA4wyYGvEaZXpI0q/h8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a8fbe7-fa43-4202-cfe3-08dd04d67112
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 18:02:02.5620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ZQAsTLGeZHYcSLyc0mv866kQyBtna0bdl+/PuR4s/WW0NoFEZlc9S8nF+i0qQhdxAd407KHiNxRb8n0/FloCOTftWdXKEhC3hmXfTi8/34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5952
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411140141
X-Proofpoint-ORIG-GUID: pIAbFmASM3X8PeCKoKJ9AWXRnRVrC8xM
X-Proofpoint-GUID: pIAbFmASM3X8PeCKoKJ9AWXRnRVrC8xM

On 11/14/2024 12:42 PM, Jason Gunthorpe wrote:
> On Wed, Nov 13, 2024 at 11:51:37AM -0800, Steve Sistare wrote:
>> Add selftest cases for IOMMU_IOAS_CHANGE_PROCESS.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>> ---
>>   tools/testing/selftests/iommu/Makefile        |   1 +
>>   tools/testing/selftests/iommu/iommufd.c       | 141 ++++++++++++++++++++++++++
>>   tools/testing/selftests/iommu/iommufd_utils.h |   6 ++
>>   3 files changed, 148 insertions(+)
>>
>> diff --git a/tools/testing/selftests/iommu/Makefile b/tools/testing/selftests/iommu/Makefile
>> index fd64779..bd23ac9 100644
>> --- a/tools/testing/selftests/iommu/Makefile
>> +++ b/tools/testing/selftests/iommu/Makefile
>> @@ -1,6 +1,7 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>>   CFLAGS += -Wall -O2 -Wno-unused-function
>>   CFLAGS += $(KHDR_INCLUDES)
>> +CFLAGS += -lcap
> 
> This should be
> 
> LDLIBS += -lcap
> 
> Otherwise it doesn't compile:
> 
> iommufd.c:(.text+0xe54a): undefined reference to `cap_get_proc'
> /usr/bin/ld: iommufd.c:(.text+0xe57a): undefined reference to `cap_set_flag'
> /usr/bin/ld: iommufd.c:(.text+0xe596): undefined reference to `cap_set_proc'
> /usr/bin/ld: iommufd.c:(.text+0xe5b5): undefined reference to `cap_free'
> 
> Because the -l option is in the wrong order

Yes, should be LDLIBS, thanks for fixing it. For whatever reason it has
been building fine in my workspace using CFLAGS, so I did not catch it.

- Steve

