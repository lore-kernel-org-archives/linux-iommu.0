Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01A715AF1
	for <iommu@lists.linux.dev>; Sat, 20 Jul 2024 19:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721502100; cv=fail; b=mRxAXNowMYtr0/vl1bg/C3nYJhuwoZivPWmu4Xw0eHBAk1uRYolYuNbriHjo58h79Q/jUNBv/i0aBI1260831Hl+p+j6NCzpK4v9+9Pgi1nM9WU2D4xuKJVL+5UcbS4QTV9VOEy8lGnNAT57x8TZKpqeI6QeNiCV5BnbYf9P1sA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721502100; c=relaxed/simple;
	bh=/Z2gcb6p3bwZtEy3mK1Zj1OIWMCCyu6DjC2PLpuwafM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aNPT79wECZuDDBf8QTLYn+nnReu/YMEgvqJih5bPd/7pZaFWRdiA4/Fv3TJGj/CFa9+ChP2z6wDYPP6Rgzlo15ZVvDz1BKRyQxTEwYtnV11MRnun/9pDJdgwK/r3wMIGnDXkcPltqIk4bJ+/teZxu1wbwBS0A1jPvA+gQJ5BikA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J4baJZZK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UqoEhnhr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J4baJZZK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UqoEhnhr"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46KIp93F016004;
	Sat, 20 Jul 2024 19:01:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=kmwR9x0Gbmx4KovmVublBQfMbj94JaXIy7y2/uC/vUs=; b=
	J4baJZZKPUS5j66fiLUv3ROjfIDdT7s3y+IrIVHbZRN0c/dSj4z8vQE/D4kWCupa
	+GmlYHx603/F7c0cKl1TsiP1e5gFGUjA8EfSurfmoh5Etx2mXOGmj4G8AiKcU61o
	1bxpB7BEwP33n9c2MsirmxcCtTwI8iqKlAy4tTigcDp93fFn2AE25IK/BYqN9mV6
	vS9oDWkvqTUAopFMh1cAd1BfwwF9jfRvNnI5y2Q5OFoGeqXvic5GTSGStlJp5iNM
	i9Z68D6V6o33Kl0JBK9WuOA2ED430r92w4xhms9ib58h0ECS9UZv4RsvY2ONQP25
	EEvIJBNVp9Ox9EXqdEwrvw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40gjv8g065-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Jul 2024 19:01:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46KH0bkO009706;
	Sat, 20 Jul 2024 19:01:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40g3p6pqx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Jul 2024 19:01:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EOHoll8+uKC7egyyZr66nmd+sX1DkZ7sStsC1q58y0iMUHSZmkH9vmOubbBgwYlMxmEJ0PkMsFBPPpDXsdkgzxRSh5x4/M7n0iIxjKSvXdkw0+7XrxDp/vpZ2x3RNFrdGWREcp3GTwiGVJGEE9Wjnl8wyjJZ7tqtgD91xXqj0KJG9y3G7yAVev1dVxFZTG/nbX9ZOW3QZ5UMIwuJCpLScE1rySkwjeltYqheXT9TrLFjWtgoOSDzSMwT2qAvHf6nDBNR5yrl70kSokAFvDRIhUkfxfWaxhQOBPuwnkYwTBzGRuQgTOoG+D0F204pmatUxFHgkvZqlJbDAYqyK85Ukw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmwR9x0Gbmx4KovmVublBQfMbj94JaXIy7y2/uC/vUs=;
 b=GOuZPTeeMsf/jY2+cAreP+XD0+Uh1QUT68/Y2GPnCzhlOk7IrmPGq8xNzZOXmsSmKGHrh8HTnJGTnfWOj8ypAi+wRmDUsFaa8jrCTvFwcgo1YtAoA50thShcwzghOS19+TvWA0xe1zjTSNKe9MW28BnpmWiJKV/iI/VNfZ+2Rh3lNw1+3J15oD1rQ7MLgLrsVmiyYCuv5WQkp2uQpWVzNS+auvv+fmea8ybwdmG9cqH6lxV5x4zi32u7mX/X+VL+szSuozw1f5wmOjpgqCk8NeMCIXYy1GStHhLvTMNvs/3nTfnf1EBzmyIH2AEERd04wj29VgnbXrjF5xHDIMt/fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmwR9x0Gbmx4KovmVublBQfMbj94JaXIy7y2/uC/vUs=;
 b=UqoEhnhrG5RiXhtMv8TDawo0x2W9AOkKKV73m/QOXK8ocvc4WX+L84Wpi5bgxkyIhXQZN/YzWfFx1ituybO2Cmmw7S0EjPG2dNmUZysPbPuvorU6u2n28OclfvqWki/fdu9tRuWT68NrAzT2D4sPhMxhxCM3AQqYH/Rwe9WJdUc=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS7PR10MB7191.namprd10.prod.outlook.com (2603:10b6:8:e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Sat, 20 Jul
 2024 19:01:25 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.7784.016; Sat, 20 Jul 2024
 19:01:24 +0000
Message-ID: <5b9c36d7-4ed3-4f5c-961d-5a5ad38d5fa6@oracle.com>
Date: Sat, 20 Jul 2024 15:01:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1] iommufd debug print
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
References: <1721501805-86928-1-git-send-email-steven.sistare@oracle.com>
 <1721501805-86928-3-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1721501805-86928-3-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0011.prod.exchangelabs.com (2603:10b6:a02:80::24)
 To IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS7PR10MB7191:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e8248c8-1e89-4217-49f3-08dca8ee59b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzgvVVZ5R0RCQXg5ZVI3dmxEODR0QzFtV0NJV1VWL3VrU2xkVGxHYm8zZThh?=
 =?utf-8?B?ekk2RjAycEJPZlhtUkFYZjQydGVPald1dk4rV3Y1VjBlZGpib1pLWk1xWkEz?=
 =?utf-8?B?Y0JSZlJGSTZUcmNOQkhBUWFZNU15cGNwS24wUm1UenA2aVpnQ1d0a2hpNXdk?=
 =?utf-8?B?SmFUOW44MjF4NVI0eUNPVVo5WlBtM25sQ0FuelJkZDlSU0FCNm1xT1NmK2NW?=
 =?utf-8?B?WFBCQXNYSW1RODhkY3lRMG5LUUYwWjkxVmRFbkhnb1gySE5jOTBaZU1HcSs3?=
 =?utf-8?B?KzVjOTNiaDBBbFJucFFzTi9sNFB0T3BralZaQ3A2bFhpbGFjU0dqVUdNTldG?=
 =?utf-8?B?UEU2U01hZmdRVDdGbUVvM2hDOG9TMStSTFZjK3JQSHgyR0xlRjZ4d2RZV0JF?=
 =?utf-8?B?S2NON3FFVndaSEpKWFA0NUNVRWNmMmJJU1BTWkNVWHJoS1JYbzJpZEc1N0JG?=
 =?utf-8?B?eWVDdXh1S3FyK1RwbmNEcm93S1g4QXcybTV2OEhuekl5TEFZbkpwZEJERVRY?=
 =?utf-8?B?SlJJeWo3OE9aVzZudjQrd1BYQ3Fpc2JUWnY1elR4OE8vanBTd1pqdWp1NUUw?=
 =?utf-8?B?NUVtREZEc3FrUGdxRTJWMlY1YjRWT2s2aldxamhUaUJvdnNjN3VKbzB2L3pi?=
 =?utf-8?B?NkE3eVI1T0tFc09vRzc5RnhGRkpWZHo4eE9RamVvcVJPdEJWdTBrK2QxNDdh?=
 =?utf-8?B?NE9nVmpjT3hWZkw4OEdpQStxdHJDVi9BVURyWUhrWUo1bE1ydzZyandncERW?=
 =?utf-8?B?NVEzM1NGamRjT1dneUVnUmRhdi9uQ0FDTXRDbldDb0lLTE45S1FLSFpCVlRC?=
 =?utf-8?B?ZVJNdzl0OHRJUVJwdExURUlobGlROGlpVlJENndOYVpvcHlUd2lmT2crdkhM?=
 =?utf-8?B?eFRUT0pCVW1rV3BNVkwxVUllMldsM1dMZFlSekZlcHcvd1piUjl6UWg3UkRy?=
 =?utf-8?B?SnJPMmhVQXRyWGpvUGhUbUJyZmRWcnZObUcvdnlIUXdPNCs2aUpWL3B1OWta?=
 =?utf-8?B?cEFPSnNkT1lkd0pVeGJMSVVzRHNXMGNldC93bkdHU1V1Q0ltMFFpNkNFQklw?=
 =?utf-8?B?TmZKb2NSTEFQTkcxOVA3cDA4T1JvbllJOHFvbm9oT3NQWjRrWm9sc1lyRlNO?=
 =?utf-8?B?V3FGQjRRUUdCQU52ekZhNjRsdkNDcWU1N1praFg3Z0ZTYlJaU01UcVJ6dmdm?=
 =?utf-8?B?eHFVQ3h2TjVpL3U0c3pjZS91MDBOSUhvdVZsZjlROG9sa01FNHFyNU5aR0Zl?=
 =?utf-8?B?SS9FYlNHQ3dCZlpWU0NqOEZXOGlEVk9QZ1l6NE1pK2VncHdRM25RdkFVdVZs?=
 =?utf-8?B?ZGJJdUhOdEpyRmZwbFpZcFJrZmdrWG44WnJrRWRqVlViVG9EY2pqQjJiVERM?=
 =?utf-8?B?SGRaeGZiNndkVzIyallDMTd2RStTbHV3ellyeHBtQWZtT3V0SG9xWGlvTGhl?=
 =?utf-8?B?RTAyd2dpNktUQW96alBOSEtsa0FFTnpqcjdrdCtUOTN6alFFaXVtU0d4eHZL?=
 =?utf-8?B?RGRyQ1Y1dGh1MnN4S1hyV3JmRFJUMloyb0ZUKzlqVWN2YUJKem9WYlFGTnFo?=
 =?utf-8?B?eTdWTXF3TUtWbHlkeEdUQXJCa3I1RGZINTdNTkQrYjlvWDJZeUJlRFEvaWNX?=
 =?utf-8?B?N1lRUGgzQ3RQRUs4ejNZZERxbWgxMjF6b0dRdGdyT2NTZ2N4alJha293TTk1?=
 =?utf-8?B?cEFIRWRWNmp1Rm1RdEorZGlXYXNYWWpTOUZ4YW9ocVcrdEx1Ty9qOWxkQnpC?=
 =?utf-8?B?ZTBCQjhnb0wwbm8vVG9qOEVuUjU0ck9tTm5BMjZ3c1NpU2N5aGRwa3NQdk9k?=
 =?utf-8?B?Z0wvWk9IbC8wNzNmQTlNdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MU8yUlFGc3BZUGZ2UXVrRkh1STQyQzV6V29uMTlDUUljRVhpYUkzR2h0bXpt?=
 =?utf-8?B?Q1VaNGQ1OUJYSUh4ZHpIOGR1NmNWTyswdXBvTTIyT0lIMitHT2R6b2VxaGIy?=
 =?utf-8?B?bzhPaFlOVDZsdThTUHpvcXo5WHFkOFh2dzZjQkNNRkNVS1hWZUpPVFdPM0s0?=
 =?utf-8?B?L1IvaWVTMVhGSDNPRHZrYVNrR2d6QWhzQjhqK3dMaGRLVStkUHlDbHhLRTAr?=
 =?utf-8?B?Z3VPN0wrM1VaOHh1UDRrWEh6aEZDb04vWWVzTUJTRU54MnNNOUJyek4vRkNn?=
 =?utf-8?B?bmZIYUNneWJiSDBKY1M3RlpURWQvMTZvUlJlSDdLRmhGZmgveWxyWmJXVVRh?=
 =?utf-8?B?cjdhbUpnV2IxbTJHYytMQ0Z0R0hSdHdQd3ZJNFZaMjFDdFN2QzM1aFVIWHFp?=
 =?utf-8?B?RklUL3RyT2tiQXE0NmJ0WUc2dXV6QWhqS2E5OTZEOUtMbmU1WlNkSnZrZXor?=
 =?utf-8?B?TXd2TU1jN1kvMmMzWjI0N1NSM3I4L0ppOUF0TkdKQzBZTVExU3NMV2hxTnk1?=
 =?utf-8?B?UVZqSEZ0bExYc2JTaUN1Sy9nZ0FvMGxrdHhVUXJlZHptNExGa3pTSjM1K0ta?=
 =?utf-8?B?c3dLVlZreCtIL2hkVmF5aU1pSmVHWHhjZ0JORW0xOU83dmlpWnA2aUg3OUg3?=
 =?utf-8?B?VDlqMWkybnVRTVh3UnFyNmZJbkZtYmFOczFJR1JFMmt6a0hhcC9zUGs3ZWdV?=
 =?utf-8?B?ZlF5aVRvY0wwaFZTemNmVzZ5Ni9hY3ZEd1hRbjhFNG5jV21nKzJyc0ZuMXVS?=
 =?utf-8?B?VW9GWHNERm5aN0dGVlFxZ2Mrbm1TekY3bHgzdlNPeGlpQW5lYkJEczJ0Tkg1?=
 =?utf-8?B?Y3VxalNVOUxwSG9SZm1qa2piNzExNFNjZ1Z0L3RqUzFXYTF1Mk1YNkNsdkZn?=
 =?utf-8?B?L3NHdnQwb3hlOW0vNVpOeEhLazg4NWd1b2hJMnRLaGJZWS9sK0NEdlNSSU9I?=
 =?utf-8?B?dXlkdDJLZnkzSkc1a2Z0c3JaTnMyQVRteExaUVpQekx2QjJsdFhSOVdkMlpt?=
 =?utf-8?B?K0N5UHpycE8rQnFZOG1saHgyWHkvbFh5S1ZDZHROdmRmTVgwejh6QW9ualBC?=
 =?utf-8?B?Wm5TaHB0STZNNFdwc2RYZ3Zzb0pPQ3l3OFhXSGVndlVBWlNONWV4WU1RN0RD?=
 =?utf-8?B?WHc5WTdGZjVuMnNxditoVHk3V3owQ0d4Y21iaVVKcU1aSi9EUGI2dlFrT2tz?=
 =?utf-8?B?cklJcHY0dlFpcmtSNXEwMlJTOHdGSHF3dW5VMTV1aGRtUGEzdTB0NUd5NDVS?=
 =?utf-8?B?MEgwOWVjMFJFU1hGS0xjbGtUMTZUd1NETzYxaUJOdlVnckNkb2t2SSs1RXNQ?=
 =?utf-8?B?Z0xSdmFvLzNpTXl2MTh1K0hvK2FvWERORnlpYVJIakJETzBxL0U1Y3VLZ2Jo?=
 =?utf-8?B?dWRWcFFKY1ZieUEyQlRPRU10RTBZRWF6dWtrRWJkZFFXQmlMUXgvMzA3VnY2?=
 =?utf-8?B?dlZ1bWZDdGhmUGxEa1hKZXA3dG41NDJ5ZFFiWFhNK0dObUZRYk1rQzBTZVZm?=
 =?utf-8?B?Qy9YcnBQajlCT2U1aXJuNUtyTUtkeC9BOEY2ZHUxS3FUdzliMVBHOXhTMDEw?=
 =?utf-8?B?TC9TOTB3TVUrVHpLQW9FVUd4M21EcDVBbXp1aGJOUWxrSFdhb0p4V2pXNFd4?=
 =?utf-8?B?K05pOGR0WVFGRnRoQ0pWcElsaUZwcjhOVDNCdGh3c1IvR1pUYS9CU2V4cUlt?=
 =?utf-8?B?UURTNnlmTlZWcDk4SUs5VUIyUlorR2V5cGQ0NHNxVUs1NTk4SFpvc0t5VWNO?=
 =?utf-8?B?emJLbG1jTjhURDdXbzJleUdkSmlTTnl4MGo3L0Z1OHEyNUlWa0NkNjBmaFBa?=
 =?utf-8?B?YWZRcmxFdkNudzV5M2pwQWJLbkI1OGdXR0FsQzY2MFBDZ24zd0tTREpTcU90?=
 =?utf-8?B?V1pIclQ1VUNaMFpaWmRBN0ZEUmlhNE9tL0Q5ZWNXRDh0cyt0RWkrSW1MS2pq?=
 =?utf-8?B?dWs5aGgyQUdJclRWdVNTanBtNXJVUU4xNjhlWnYvU01pNndzcFE2S0VVeHNw?=
 =?utf-8?B?em5QVGVRdHJPWWV1WWtRd2hFU1dyeEtxSkdPYTJlWkVqQVg1M3hDSkVPY2JE?=
 =?utf-8?B?WWg3UTNTUUtPNkNWRlBicUcyQmtuWHllVVhoVnZwZThQeHRHZ1B1b0g3VEYz?=
 =?utf-8?B?dlh3QnNYRVVwUi9XT0lMa3EyV1JkZ3RkNUg3V0dHWHpQbjBVTmtRRnlabWNq?=
 =?utf-8?B?Rmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gN+5MR5K2x+Pp60L9sFlOIylqIvia0saYupFcCEg0lJVM5wL8Clny+klPJtF93azOPGz42XhF2kH3QeBy5Rmo0aRew3o22E5nhNYdbPNTLzD/v3oJxJchY0irgmBlHHaJ3i0cbEWnY+G/U+77L00K0hhMbzKMyzNP7rlR/qIRJovMPNfG+deXUzcdukdHtkLHkUcqcFsR/aWulYsh2rDnY3sRYnGVR6pwcVqexmEyl1BTe+Jzl5z4PdQuNqCjpZR4VReL6zLGR5NzEzp86PryD2qCOqZVJTgDBabZlnGAKar4fvvFLB16CDva3LsdWjiyJUSn+ted3ZFWnlw6ifFxYEH2KbFQITQ6OrvURKR9JEzmQKE6mDE0zl4UIIOVZgviq+PC5TGdlAWKedKP9Lv2Xo+Oq8fbxjBcEJfbNZnsGw9S42oiRW2QJd/1E8hwljv4Bvy1VSQmPknWv5lKaERP+RV1rGXZNA9R1X2cARe89pwDRbE3IFjnmaQNDXkJM1OMNDR3uu6uOKn1hLfO9lyK9plGEOU+fKoBBIIlYMk5y3MLsRC4ULaKARnzSlN2tk0CL91hVeOZRFFdx5q7lW0VMvhNCZ4mon/kFa17nFISqI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8248c8-1e89-4217-49f3-08dca8ee59b3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2024 19:01:24.2808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Cp/XysXMK3Lc391aI8eOGcRRafk8klanIVvudOFyQIb0K4xANVs7cE1rfw07jqm9BwywjkcW9r3js6apX2GaNr3shzWtqKUFTCVUTS7zAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7191
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-20_16,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=833
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407200139
X-Proofpoint-GUID: VUFZi0ZPyBujKKVvNk3Qhi54WD85f3Hl
X-Proofpoint-ORIG-GUID: VUFZi0ZPyBujKKVvNk3Qhi54WD85f3Hl

Please ignore this cruft that slipped into my patch directory - steve

On 7/20/2024 2:56 PM, Steve Sistare wrote:
> ---
>   drivers/iommu/iommufd/ioas.c  | 71 ++++++++++++++++++++++++++++++++++++++++---
>   drivers/iommu/iommufd/main.c  |  6 +++-
>   drivers/iommu/iommufd/pages.c | 10 ++++--
>   drivers/vfio/group.c          |  1 +
>   4 files changed, 81 insertions(+), 7 deletions(-)
> 
