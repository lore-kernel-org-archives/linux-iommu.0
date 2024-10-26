Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99FD2F36
	for <iommu@lists.linux.dev>; Sat, 26 Oct 2024 19:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729970208; cv=fail; b=pde5Lq+hcPlqVzJjidCUl6o3LVwtSl+dk0bpNzzI84IGxfcF8ij6oSpsqR47EePSnc/GKFIrziMQII3wO6JVhocKmfHQIbEPJS4SNqT0Tm/4bpMcxWm85x7pDB//OWyi95WU+7SzIilzFuwgD7zmPn1KCEkopffBaeQ0lfLLbtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729970208; c=relaxed/simple;
	bh=W17LWUkgvCrRoq4l/lBKiyC388TARrVWnijqnu0DQrk=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rd+4Q5wXWRm5XOI2V1LoEUtiYwFriznZP9wLPMfIZs6Qx+nRCTvFCxQhkXNoTyAuPzQfi8MkRixIDZ1YtXlnotlqi49OuFUMhLUxa9qRqaMK6TSfCIrJfLEIl5hZftCpk6YLZw5/B7XMJFSo8s9ktxxfXCqKF/r0hCk2SF1XnJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DOlNUtM5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QADgwUDM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DOlNUtM5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QADgwUDM"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49QIVwt7030905;
	Sat, 26 Oct 2024 19:16:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=sBAUJSrT8EPJCxPej2BBxz/LDMJEB3AMoEZl1MZJc+k=; b=
	DOlNUtM50TWRPxMgw6SnUh4cUsQFJ5bIiiuRsVvPAzZNX25GcGothld4ZB1bzsD4
	Kgg40dHknHOVnXBjgeiAAoDnEe210r0txmSCoz+N/GbOU+GAPK8k1qtQxNg75DvS
	N9gcQ1gG0FDqFwdYbiNTVrRBOgw4sV0g1+00AkAnFQcCtM7XVZF+GUwB1t2d5vL4
	CSSbnrHsLjXuyTBguilcKst5za03F1V1WV9wcBCnytpvdgr0lEBnDSh61+T281vQ
	xgj3qiy1yTAp1xvPo+96oNgGEFEASCsK1OU5FU3sqaznmgfBJHsWFY/3F8wCJEvy
	vrg+S4lLU92ysyy9x2h4tA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grgm8ktv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Oct 2024 19:16:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49QDeXQ7016354;
	Sat, 26 Oct 2024 19:16:42 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42gpv4e38t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Oct 2024 19:16:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VptcTp/qmI/b2ZzD6/c0QKBa0ml7NF5KS+aNudtUEfnHRvkqF/BThuHS/cx6kFcF4eULcCgU3fzUEzCkyElFQXKq+eiU6JluNkFZsq2pSrg9Nt0hqawqR5GjT22+peAsou54M+ewXNdTesG5yVfGGF7r/KrNjei/yNfn9bPcZssN+S7Z90aLrbsIspvLvPGsqQGKz/68XUbIXCmJDfg6pjI1yG/IXbAPO5MWL24jFcxOXLWqHLEeen2bbQc8gTTbyj5RYzV0TbZH5c4Dhkw9SpN2gb/QnJ6ekmfYDKw5MW4Akg1G2xpFBxKmADhTq+ld9p+fWXVd8morlp42iTCjag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBAUJSrT8EPJCxPej2BBxz/LDMJEB3AMoEZl1MZJc+k=;
 b=DrbXRK7FT5lfno7h1kSRGZ03LLP5V7HKYxqYf+orCglHPILqRR6BpZMMlEb6Mk5Hp822k1GKYoHR7O3EzFSIg42E/+7bkOjjA2fDlEkRNfJ18PzlE7DLNrgf2m5HDHiAhS2XQ404vcIZ+zYxwjnQxQM/QbbHqGJfYfIQAqUcuuzqIYS2bI62f/SNV9TpNvsBY/g/ft0AmlQkReYdrw3D9/GSzFxOGpLBQqvGSu3LUyyA5X8r8Ekp6ZJhFSzDdqSqpqe23HIQa0LNrcL7lF3IaDtW2jnGhbTcvQ7QAdRGfzQLdJkrxuOMmvDk/juz+SmxZH5ltKR2puPhO2VwSLoPfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBAUJSrT8EPJCxPej2BBxz/LDMJEB3AMoEZl1MZJc+k=;
 b=QADgwUDMcp9bmqAaX9rtPK28U7049c7XRXys0KRrm9TKKoEU7cFRZiX1/lPlwwRjdDsk94pdG/DAmX0BON+HbOHwxsNzk0OHOPvw3LQNFLp9NrddUxBGnwMm5OViSPFu+Yd5zKPOkaGsDfu4mnXtygllGjgVgx5J1QLAIkBEh4g=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH3PR10MB7716.namprd10.prod.outlook.com (2603:10b6:610:1ba::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Sat, 26 Oct
 2024 19:16:38 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8093.018; Sat, 26 Oct 2024
 19:16:38 +0000
Message-ID: <1af8d6b6-6640-4299-b279-eaf943707664@oracle.com>
Date: Sat, 26 Oct 2024 15:16:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 9/9] iommufd: map file selftest
From: Steven Sistare <steven.sistare@oracle.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>
References: <1729861919-234514-1-git-send-email-steven.sistare@oracle.com>
 <1729861919-234514-10-git-send-email-steven.sistare@oracle.com>
 <ZxvPhQZOBR7g56eh@Asurada-Nvidia>
 <2c7edd3b-61c7-4012-b825-4972c0efcec5@oracle.com>
 <Zxvl7J0mWkKPS4GD@Asurada-Nvidia> <20241025235849.GL6956@nvidia.com>
 <37483959-3ff1-44fb-b3f5-f1c0859de1ef@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <37483959-3ff1-44fb-b3f5-f1c0859de1ef@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR01CA0026.prod.exchangelabs.com (2603:10b6:208:71::39)
 To IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH3PR10MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: fb46921f-99ed-464d-d200-08dcf5f2b726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDFQSCtHTVgvalB5Qk9tc1BGMEpiUGc2MHRkLzRwRURTOERSaysvcFo1VGJm?=
 =?utf-8?B?eUZhUUMwcEs4TUxyZTh0TUtYdllMWFhLanlOWjNuc2t0eW9XTXhWVExHcXMv?=
 =?utf-8?B?aGZLVTlmaXVjeU5MLy9XcHd5SmFlTDFrZUJSdEE5RUtDUCtyeUxkUUtBZ2Ns?=
 =?utf-8?B?VVhNNU04enRESytKc3JuSnovUzR4Nms1VzF0eHptbFRQallDZFpaM2xpbXVW?=
 =?utf-8?B?MUZDdE1HQWwxbmNGMUhqRndhU1U2RnRMOFo1NUIwT2tkZFBENFNBVmFWd0Q0?=
 =?utf-8?B?M2hFckQyb2RVMWdDMHE0K1pXdUdGR2lpWXQycVBLR0RtK00rRDRDR2JUczBP?=
 =?utf-8?B?K1dtdytPTllFTGFYS3AxcWQ1ZWk5d24yektDQlMwbEszeFBvZTlHWjRFK1py?=
 =?utf-8?B?UlRVZHoybE03NStsU2FXTDB0QkJJK3k2TngwdUZ3RVVsQ0lSZVZFQ1NUVFRX?=
 =?utf-8?B?TXdnbGpNOHFVZHlraC95MFhQaGtKZTRHdVI1MDd2enJiWThmeWlPWXFTck5P?=
 =?utf-8?B?MGMzbGtRd0VFWlJ2QkdZTXZnZzNQOG5GY3dGdktIb1BtUFZrZlpJdXN6bTdL?=
 =?utf-8?B?UjhHOXJXRWFUSFdlWjVKNE9EbitvUnd4YTgvOUVwKytZVWhXQmtVVVpiK2k4?=
 =?utf-8?B?aHg4anFSS3BRb1EvS0EvRnM0TDJsVGdaYmRTNUtFdFFLditJZFhyTEZzNU5M?=
 =?utf-8?B?Y1htczYvUC9jWDV4aFZNOGpKWTlsck1KbDh3QXZwZXAyZk1tRkRMYmJKcFYx?=
 =?utf-8?B?MlRMNjNvbmJpM3JMcGtXWVpIYXp3V25YVlNEWEVSYWV5bFZJSWtCVWJRN2Zw?=
 =?utf-8?B?NUlmZVRHdnBqOTQ4dmtqVGhpRTcyNFlpdkdRRjhsR3RvYXNrcXpxaXZDMVhK?=
 =?utf-8?B?RHVtKyt1NjJ4VFBUdEY2dUNuN3RndXYrMmp5V3FPaGI1a3RsUWhFZzRwS2Rv?=
 =?utf-8?B?SDl4bFBNdjFTQ1pxTUNLMU42S3UwUWN0QmhVcU1XYjI2czB5ajhLdk1NNllu?=
 =?utf-8?B?cW5pQU00Vlg0dTloVjdSSG5LWjR0VXpkS2Vzd2xEK0pjcmNPb3pNSUVmRmts?=
 =?utf-8?B?UDRFWkQ3Q2g4a0ZsUnNYYVRVNFg0NW05akg1YjR3U0hhNTBncHFqbksyaEpl?=
 =?utf-8?B?UFVRYjhuQXUrdjJDckd4ZE1raTdvR1hNMVJZbzJYUWlDZ010bXNIRnVsMU00?=
 =?utf-8?B?S0NoQVdUL2pzWTQxTDhPdzRab0pESmlXc0cvcU55MmNZajJnSys0a0pLQlE2?=
 =?utf-8?B?K0xCbGFNejU3QVliOWZhd01aMTE3T0xFdndXbi9TbThxd0QzcEl2U1VucnJt?=
 =?utf-8?B?Y1l2Z09ZdndQSnMvSW9VdWt0MHFqUHNMeGU0cTFIUW1mWE1USjZ2SCs5dnRv?=
 =?utf-8?B?aitvdXZZZmppbnRtK3JBcUs1TzNJekZ3ellpNXZLaTBRYk1Sa2pBR0htdmRm?=
 =?utf-8?B?eVJacGhCallOSnhqWk02ZGphcjc4dWs4SFZxVEZPS3BVZ2NaTWpiRkZ2SjFu?=
 =?utf-8?B?alRkOHBGaFBVT096cXNiL1dIT0E2SDRYb3dTR1NpbXBKNWk3Sk5TaVZrM3FZ?=
 =?utf-8?B?MG9xblphVW5xOUNWbisyNnJ5bnVDZk5oa1VHWk9saGQ1WG9TYU5PcjNnVzZF?=
 =?utf-8?B?VURDUW9HczlRbUFpbUU5K3phMnU4c0lKeFdHZVY4WTBKTjdqOWtTNDhna092?=
 =?utf-8?B?aVVYWEkxVXI0cWgwa0ZXd1BWMGk2Q1ZUNkhLbVJnTVBUamM0WldGWGN0RDlF?=
 =?utf-8?Q?LEN2r+XFMlGxQCeMD5iLimaYA0zacm3GOrdYCla?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mm5rVzh1dHdMY001RWZtZysvcU9QVHhRRWYyUy9PdE1XTFBOMTU1RUF0YjJY?=
 =?utf-8?B?ZmlodXUyNGUwS1hraFFpUThXc3BPSDZYelpRSXYvVVZpK0hiU2VwMVdPRjJN?=
 =?utf-8?B?L2dqNS9wZlNxbVJmaWF3NFhrTnhBRkpQejNmQVpuM2tTUzhFSjlDeTBLcEFY?=
 =?utf-8?B?aC9YVWhLNExhWGpPK3l0dm1YSlhmL01PU3hibWlYQ29ydnNYd0VMNkczTjhr?=
 =?utf-8?B?cFk0ZzZVeW9oWDhaVmo2MVh6RlNVL0dVSFBSR3FQY2oraXJiMFdtelBPU0ZG?=
 =?utf-8?B?eGp5MWhRTGN6NkFDZkgrSldDMjFxZ0NRTXR5M1QvZ0svSVNoRCtCZWRHVHRO?=
 =?utf-8?B?SDhLbDI0NHlWKzdKd3N5ZWpoSjJpYnJuRThiN1paYWtoVDVxaDl0S2M2RjNa?=
 =?utf-8?B?dk1JUXVxRktobFI1YWlFTzRaVC9qU1poRkdTVDRucDBRd0xkL2dHUk5XRlpw?=
 =?utf-8?B?SmM4Q1BPQVdXSGc3c2ZTQ2VoZEJpZDZWRHRzZ0JKUjBudWFsQzdTaWtDTHFL?=
 =?utf-8?B?M0Q1TjEwT3hHRDB3MG45K3YwZVhkUUVsai82Q2xJT2JqN0FNSnRJK1BOSjhM?=
 =?utf-8?B?SzIzTHQ2UzZuV0JIaE1Scm5lUnRhV2hJb01LS2xYZXdVTEExVTNieGVzUHJB?=
 =?utf-8?B?UkNGbUtsYk9UZno0QzRIdy82TGlpL09NclczK3Z5WFkxVlVaYndMekgvTUVn?=
 =?utf-8?B?SXR6cG1SSEROZy9jOW1pYjJoR2s3azFxOVZFYThWR2JMYmxQbXR2WGNsMXJv?=
 =?utf-8?B?em1QZUNoNkVZZ2lmS09ldXlGR1lBbFdWZEpkSXpUL0lSUFFzL3NDV2RIZEpa?=
 =?utf-8?B?OG9laUlZTCtpZ2JyMnIyKy8yNU1zRjA1b3Z3MjJvN1kyc0hZUnJ5d1dLNGhr?=
 =?utf-8?B?YTJ1SkpuQ2t6dUErREJVcWJuMXhhdENnQ0xuRlhsc2dCRnNJUnpHMGFiQ0d4?=
 =?utf-8?B?Y0tTeFFlZHRleWxKV050VVAvL2V1UTEzVXhjSEFqblZVZjNobXBqM1cxQi9s?=
 =?utf-8?B?RkQ4YlV6NFRyYlRkNE5QZHVBQXgrZUZ6M2IyM0ZJT2swbDBxRFJhQ1Z3WE5a?=
 =?utf-8?B?aWl4VmFTeGhZUUZVOUd5bHlmQzlEQWovOUU0SUw4ejJGNlZua0xrdXdvaGZH?=
 =?utf-8?B?cTQ5SXU4dytEaXZaKzMyWUhGZnNkSmd3dTFCVlluMGsrVTRGZHdMalUyZVpB?=
 =?utf-8?B?VVdsNlRIaFR4YUNCNWVGL2V4bXZrZDJZQnkvTjhtVk5EWEZzNmhwQkZITU1D?=
 =?utf-8?B?YWVod2lySk5ENWtyQ05YUzN0TmRucE5TN2N2QVN2ZGUrQktLRzdaTEtKbFFN?=
 =?utf-8?B?T3lFZzVvUVVxdDhiblBYenY3UGFJSUtZY0hKWTJwb3YrSkwxdnRTNmFKVVp1?=
 =?utf-8?B?MHNEaXdxY2p5bDFRK1FhYzZEYkFNZnB4eFVjWllzNWdMU0FJcFUrSzlsNHpk?=
 =?utf-8?B?Z3FqdHo5OGtYYXBxUVBlWXYvR2Rvb1FXUUdXNCtwRHZveHd2Rk4vd2RUTUhP?=
 =?utf-8?B?eVVud05aVnhiV1NzOU02dkVLeW5CU0laMHowUE51R0Q3RmRLbVQvZkRhQ0t3?=
 =?utf-8?B?cTIrWVRFU2I3WG9CcmJiby9ScVk5UU9Kd1oxZXRQU0Q1SDV6SFJkUnp3UFkw?=
 =?utf-8?B?MVJ6S294aEtOUU03dGxkUENzaVpPLzhpZTY5Q2ZBaklHcTZESGhaZkRJWDFu?=
 =?utf-8?B?UFJodWdGbXI2WTlRVzZnTjBqNUpQemNKY25Mb283WmRleDNMc3E2Vzd1cVd4?=
 =?utf-8?B?ZFRZZnZOTWkrTHFxWC9CaTk1R2Q1eWRNL1JYNDhoUENidVJPMHJVNHNMVXVj?=
 =?utf-8?B?K25PTjhLVXVHMlRwemlHS0IrMDl2RjYxZzlHWVQ0RVZ4RzdLVVpaN1hPOGs2?=
 =?utf-8?B?WDc0cXRIQnlkay9lTjd4N0tVeE5sM2E5alh2dzk3OTVIOE9kREVnZkpuREov?=
 =?utf-8?B?QXBncG05cEhZVkY3RkgzUWNCWVovSnNXcWJ4UXBwamovSkJNTElFMTNqOFAr?=
 =?utf-8?B?WVowTDNzOGhMVWdRWVJRL0lUbzdZd3E5TCtCVDNEV0lYTXl6YzVpNlhKWUM3?=
 =?utf-8?B?cFhyditHTHFnWWUxQmhSK0I3U2wvVjFGK1l5M1g0ejBpRTJFRGZ1SHhETThM?=
 =?utf-8?B?QWNzRG55eVpKY2FPU0N4MG5tSUtFNlR4a0pzS0ptSHJRYU83NCtDT29KMzJV?=
 =?utf-8?B?a2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	I2wt8rH1Hetj9b2i17sE5rqUJ3utBNOeXiGHwf2YflRTAZWTT8DgEak4AQa52AU2jFWkE7q8A+UfhVTKNF867SPPksxwvW4Eccdp+Bm4x1FDa1lqFmuRWI47UBKWGB/3WZ9VBT86aASxWIVCLBuhf1gYjpWMCyLo2bjjzxAEVoGskxc5RBY75Wg5gsUOPcNA/wuMyIQiuOF6hpASGDweFVReO4JQO8Kuv37MuzUZ6RpWqVgqNfEd64+x18xFWs9B2o3SkxkGeC2Sj76FK1ww5XYfetzpBCoCJgFhvKLxjL4HtQc9FSl5m4giGuLqROJ5/bRZ+qeINn0MPpn/a/ZWU6pG8yBHyWLzmVEMFsSMGb3SycniV4bFwoQcAXw5SmQaAMIKxUUkqhx4NDkV0ZuSmZ1H/mv3SFV+Dd89xnumkzcAPqxadOYWpLnejoUHa3c0gBkur9liIYqTm9tvTL6Pek424tnIWuMUjIwX1BLnZr8hhyyLq2p8xdgLf34NRTByl9bFvTnxpcBSdFMXFjBI0FsgEU0wdMJqCXIcR0GHEn/f6d3o4kYTizatD2y7ZdLSzo+7AeqKYwmp6ZiarTyZgLZC3ivyUpBK09rjLOWdnNw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb46921f-99ed-464d-d200-08dcf5f2b726
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2024 19:16:38.4673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Puh8Y8eMcLjySM97NXJ0ExMHIDbHBIhaOs8owqUxwAc+MrCuMib9UWnXalsRuOexxXWMMhNxK8YiVbOlQ4EPTSOuRibRwI6ciEvj8daiKb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7716
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-26_04,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410260164
X-Proofpoint-GUID: wPocjr3_8oH1fW3Qx5vFVkIk2D3AxCWR
X-Proofpoint-ORIG-GUID: wPocjr3_8oH1fW3Qx5vFVkIk2D3AxCWR

On 10/26/2024 3:13 PM, Steven Sistare wrote:
> On 10/25/2024 7:58 PM, Jason Gunthorpe wrote:
>> On Fri, Oct 25, 2024 at 11:39:40AM -0700, Nicolin Chen wrote:
>>
>>>> I will try to reproduce your failures.
>>>> What is your base commit?
>>>
>>> I was using the for-next tree (rc1) from:
>>> git git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git
>>>
>>> And it was failing, so I guess rc1 is missing something for memfd.
>>> So, it should be a false alarm.
>>
>> Oh, that's exciting. So I will have to base it on a rc that works so
>> bisection works :\
> 
> I'll test builds on arm to identify the minimum requirement.

BTW this is likely an arm-specific issue, because I have been using
for-next rc1 on x86, and all tests pass.

- Steve
