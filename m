Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBB31442F2
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 14:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730730298; cv=fail; b=N4u9ursW8gPA404Q0QR9Iz/P+s1/nQu3Ym29B3KJNWzRe9vpdZqtTeTlU5Mgfe/zb/CQYynL5FBuj3pBAjTtR7rrQ8KpJ8mxLmqfxXGksFSlvrRzsg1SH33P4dLbvQxhbMIHDamjKlcNQULVnZvguk2a0yY1Xg8+BlRRMVH+0eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730730298; c=relaxed/simple;
	bh=uFBir/hjmw2PDsE4lB68yKyfn/hQbs+VahsyeTfmhPc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rlC9tpru9py6yhSr7VWcHBs3THBlhluOoYSzYaBSQWmwpHgtYU3fwJncSyqvFSnOaVoMTyFQ1KbQiM3nLMV2qsYxgvd8n4Hg2Ov8ugTs30SnUOvqkLuyweT2X1SeoekAEm0CY6kYhU0T131Y8StHw5JtFbmKiLd47V33BXpDocI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LUtLXKKf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZDxcy+KH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LUtLXKKf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZDxcy+KH"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4DNsxn003190;
	Mon, 4 Nov 2024 14:24:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=9OGpfbRt4XwtjK8Xq66kif1DPexFZKBdG9etthagRXE=; b=
	LUtLXKKf1aA1evt0AnalCB+7qpj7PNnPLc+svcaWjsFNg+rn3B+peOItEVWxiXOB
	NWEYGUYBJfN22JhOIhmhLsZzrtwYg8IwtJxBj4fHwyoB1MJQohxJpb2uekpvcy4h
	A1smyGw8/nJiZkgZLjiIv275Yj6F4FZmRjTcC9rsI2nRGaompu1GPO/bRlpnhm3T
	X5S7cV6JU9h+ck4Nn7s+Lns/1edJLwkotXbt9kEmraAQn5KFhu1Us61ckGtl8dVT
	oDvHwKsmNBTjPE08OL4b9BA26/i2OhPAGM1DSHa9py3h7QXVYvsiWqJdfv2Ko/je
	nwPChhU88deeq1M9ERixdg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nby8tt44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Nov 2024 14:24:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4DxZbB010012;
	Mon, 4 Nov 2024 14:24:53 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42nahc2xsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Nov 2024 14:24:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AANWxrtZK9jX0gENThb7xI/jIkQn3K4wIP0BhNdWjuChvdcqQVr8bVzbtN+zpWtIfy95OtrVAkxF6AOcd5tIUg8PSx6cZEKchJwTT4FPBD7bHVHNTcjtQVaOAfA65ROgxyPfFFRrezl/mStxttB3y2R+h6eC4JztTWe9MPuX9ZxvTJ1b6L6FpNEbGX2tQ+UQltB9SBO5IALKCa/urbeHczaLTI6jTwVVzp/ffMDGEqsliuaenPBd1Ts12JyVH/euGn5kRdirCGhmXVRH7R36H8VDf/t8DIdgJ2Gq+NBCi/a1BquI1+JgZY1wtD5nmhntJlWNUkFPYBYeqc7dUX1fTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OGpfbRt4XwtjK8Xq66kif1DPexFZKBdG9etthagRXE=;
 b=rtYfOkbTyh5DgGjiR6fD9gTRV9YbqjXhmIbVZnManFXMMwkztywhfkIdxytGN1CUfqa1OGrHtDLJ0/JaI0Px9D9C4BKMXcF+S6wUKcW4rAnTLRVe0uFc0bFS2rhJzV/nDLhcBgJspWUISxrKSIX9hDGPKSIbkAyNxVThtwGFDwVW2sFacUPqdIwHmHNXUzLD3qpCKCevfgp5yMrF1IMKDFNypOhEom7aQP7qQNuhtyMAQ87W5qp/GRK1yLzZC+ZyCwn6GjA31jMfa6ms06AESko967YNk9EEYsoMiIAfaooA1MjZL6MyCShWGFInXnmDTx5Gq0s/SPVZCObl1hN+Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OGpfbRt4XwtjK8Xq66kif1DPexFZKBdG9etthagRXE=;
 b=ZDxcy+KH2/llhx/1fnQ/gkwo6AlkD/wbnkgQ6ESsHj1btG+YbFFUGQ+ozKTT7mPY4Fb1qS0qZQOAB2uLcVoIjuziklJLB/MjQpr5hkboZLfXorH9cWsneQ02L5/JuB8CGl7e0FFRrEAqQSdq1/IZiyDmNWCpiKBsU8cEdmIl8u4=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DM4PR10MB5918.namprd10.prod.outlook.com (2603:10b6:8:ab::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.30; Mon, 4 Nov 2024 14:24:49 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 14:24:49 +0000
Message-ID: <17468bfb-3955-468e-8b17-308cafb4cb8f@oracle.com>
Date: Mon, 4 Nov 2024 09:24:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 0/9] iommu_ioas_map_file
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
References: <1729861919-234514-1-git-send-email-steven.sistare@oracle.com>
 <20241030001102.GA251312@nvidia.com>
 <1bde901c-980a-44e0-8f6f-8e1985683349@oracle.com>
 <b4fa2db8-192f-4cfd-880a-5e29bad58f52@oracle.com>
 <20241104141817.GY10193@nvidia.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241104141817.GY10193@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0067.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::12) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DM4PR10MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: b65c9d16-246c-4c2f-83d7-08dcfcdc7085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2tLZUpuNXAxZENkT0FDaS8zVTBrK3lBL0dJYk5lUXZtZFFqZmJOYlRxb0xl?=
 =?utf-8?B?L0RiWXBRN1lCenhGWmhZc2tDdGk2akg0cXU0ZzIxTzJvS3d5WEN6VGNya1BM?=
 =?utf-8?B?T3dKeWhlS21nNjFOczd5YkF4aE5WdEs3TlFheXIzYjRLd1BkWlNOYkpMaW9l?=
 =?utf-8?B?clpFbkpPWExXeW5PVlZrZ2trV3NiUytnOXlrL1dteTQwWDR3ajNURE9ZT1I1?=
 =?utf-8?B?NFExaFZZTzlIMW80YmQ4L0M4d0FJbUVzZi9zTm1HTWZ1Q21lM0IwY2dJc3hJ?=
 =?utf-8?B?c2Z3RjNqUGZ4VGF0MmRlY01GNG11UGZhU2tybGd1b1lTRXZsZndLOXZlTlBV?=
 =?utf-8?B?cFl2UTNhL2NieXYwOWZPZDRlcVRSVEZmT013ZUpWSlQ4RTJwS0E0bjZuRElJ?=
 =?utf-8?B?RHEvRUFvN1NKVllqaE9oY3NZdjVwTEdCdWVvSk1OWGJrYkMrRGJ6MUVuMUhL?=
 =?utf-8?B?cktpdGdDTjhzNC9wSEJSRld0VmIwa0FQVU5nUzFEdXRmWU8wTmRGNmVIc1pP?=
 =?utf-8?B?Um9jdUIxbWNzV2lUbitxelRmN0d0a1BJRllQdEZjRzgyeWNkSzZTOTlSNmdt?=
 =?utf-8?B?R2FKcEZLUnJ0MlFTenZOem5FckF4SnhJT0VZUW9GaFFJTkhrU2toSGhKdEFo?=
 =?utf-8?B?dFJ2c2h0WlppbFJDYTU5NTd2d2JtQURQcFJMQ0ZrazRoOHNVR28xdExVL1pp?=
 =?utf-8?B?MWxrK1kva2NLSjJIQ1FYMTEwb0lVSTk5SmpQSCtUZnZlWTVoeW0xaHlnRmtE?=
 =?utf-8?B?ZUlCRmpGcVRpNnJCLyt3KzZsVFdoZXcwV3BVb2U3M0lLVHFpbXZ4T0hCRU1Z?=
 =?utf-8?B?WndWTy9GNElaV0VhS3ZJMk0wM3hGVCsydTJVRFk4akV6NUY0bk1hTlZFYUlJ?=
 =?utf-8?B?ZWtLVFlCWmU2eDczdERkZlAwelVHTzZDTVJxL2FwYVFyTlhQR3djUlJyZHVN?=
 =?utf-8?B?dVFDbXh6UWFTR3JST2tzUWFYYWxqUDQ1VnFmSmE1TmVxOHpEUXkzTGFpYnJu?=
 =?utf-8?B?eCtTcVkyUmdkSzlLQkpNbFhZa09ZeER0aWd4MEZpZksrODMyRHN5eFZ6QS9E?=
 =?utf-8?B?VDBBQk9RekovbEprUm96RVNpTXBQczRoUGIzWndSdkJlbk1LTHNBdWdDekZP?=
 =?utf-8?B?ZitmcmpiR1hjYU51MElBMm1ua0hZVXAzYnptZ2NnM3ZtQkxmaEtsVS8xYzJq?=
 =?utf-8?B?TzB5Zk5BZTJPZ0pzVkhMNGkyalhNclpIWTBLNWxUaGE1dFNhR25xVUZyd2Rr?=
 =?utf-8?B?bjB4c3N0VnZTeTMzNXViZWdEelFtUEg5ei8wc1ZSQlAvY2ZqWmRzYjVkQURJ?=
 =?utf-8?B?ZE5vK3RVR3JDZU5KOWlCUmRlZW00ak42ZUVXREVuSnVkZGZweStxY1AwSE5m?=
 =?utf-8?B?ZTlrcFJEL0o5VzNTeG4xb2FZeklHWTFwakIrTFA0aE1ZMko1OXYzaURLci9R?=
 =?utf-8?B?QTBPcEMwaUN4SWZWZGh3bzRvZDdvejJheUswMFoybnpTSnJKT1FubTQ0Yll1?=
 =?utf-8?B?bVdYcG91K00vYnpna2pDUDZ3S2plUDA3bVlzOFdQeEZPUGttOWhEekgxc3NR?=
 =?utf-8?B?eVMwNVY2bEJ4bHc0NVVva1lLS0VmRFZZa2VCMzlsckFsSHVlVHZhQmZNSitI?=
 =?utf-8?B?anZRNEJMc2Zyb2dRNktYUFBwMGRkZU44bVIzTUxCSkk0Z05uVU14K0d0Q1hG?=
 =?utf-8?B?cXRRMzdndjFJeXh1c0Z5K2JFNHVmc2NhNnQ3NUppWTYwbGFyUkFGSUw5MXZ2?=
 =?utf-8?Q?X58E0hfq5ro9qu7x1o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vmx5dXdyMXNuNGExdEh1ZHYxUHo3UXVER0p4REYzb2ZxU3lCQXJzV1hHcE9O?=
 =?utf-8?B?MXFEOG05NU1FRTM1TnVwNkRkSm5raG1ITFV4azdSL25uTjlRT05HUlFjamJy?=
 =?utf-8?B?VjRiNHZsQ2ZUNktBVm5UVzZ3K0d5QWxyMFA2dWt6THVxM1pMVW5seTQ1alMz?=
 =?utf-8?B?MlJSbk5ucnhQWTJFZXVybk9xWkRwbXdEUElKSkpyREErNHlpaGFUTUtSRDVG?=
 =?utf-8?B?aVc4OTJzUGhHWEJ3bnQzZGhhUi9jb01JcXh3Q01nVW5xQW4yY1MwMG1tVjQ3?=
 =?utf-8?B?K21tazNDMnlyWk0zd1hteVF5dC9pM2pTZTh0RW1ia3hKMFVjaW55eUdMU3RS?=
 =?utf-8?B?SHByOW54UHVMckRWUkFZbEFOTUxTNGRkNFdPekhzYXkyT3BTUGlLNXo3ZGh3?=
 =?utf-8?B?K094ZFJwSEZ3SEZCVG1hM2ErNzJON2tnemNaSCttVU1yS3c5VkQ2aUdRYkJV?=
 =?utf-8?B?bTl0bjQwNzBDNk9tRXprL0VpTEk3eE8rRHl5bHd5MUZ0Zlc3VTZGRlJ3dE53?=
 =?utf-8?B?TXRTaVNtczBhWVdmQ1RrT2N5dG9ObHlhR0pRK25EN1ZxSWdtdVByMkdtbVVH?=
 =?utf-8?B?MHc4Y3NpbG1uMk5VM2x1OEh2MmRQU21NOVQ0MHp3NmVhZllhUzB0NTIxd3dp?=
 =?utf-8?B?dnVNMDRsVE4yWTJHQVBLalBpRExwL0dWbE5Uc1hhWUxqZTFNTnRXV09VKzY1?=
 =?utf-8?B?WTRPei9pWmQrZi9zN25qMUROK3NKM3lseS91Z1N0WXQ3RWRlT2VCajhPNmpZ?=
 =?utf-8?B?Y21CVHhESHhpQUNSRDhLRGFXc2kwaE9GYkgyaC9wQmRLMEFQOUxRQVFISUN2?=
 =?utf-8?B?MVlIYldmUkdXc2MwWGswaFZaUUIwc2kxSnk2aFgxVlZSM3dnajYwcHZZNmRK?=
 =?utf-8?B?SExUWE1Rc2s2b2JLY3F2dmc3bVl5VSsrQ2lmN1paNWU5L0tGYWFYSGYvQTVY?=
 =?utf-8?B?OEtKWGV3VWJaOWFnUmVWQklCMnphSWtRM3JGM04rTUVlYTlPOHc2ZC9yMHJX?=
 =?utf-8?B?UnllR0RNb3RJbEpCNUlXOXJtRnBkTkFIMjJIUnBoN0VTV3RLRGh0c0ZaenZH?=
 =?utf-8?B?MVk3NVphaGlyUzlCbGk5NThRQnJ4NEkxcUwxeG1Zc0JUWXBHaG90QTN5YXV4?=
 =?utf-8?B?Tmw1UTJXZ0ZpZWN2djNLdXpWS1N3ZEk3cmZRQjVIMjFWVmdBRm40a3M5TGg1?=
 =?utf-8?B?Z00xMXQ2RVFWWllER1ZOanovaFNWbGNLcWd2ZU9UakFSZFFIank5RGVQWGVk?=
 =?utf-8?B?WGI0ejluNjdFQ3kvbzhoeHZNd0xoNkM5WXA1Z2RNaFJMd2tKa3NCVHdXZGcw?=
 =?utf-8?B?dXl3K0t2eWhzVVppQm5POE1CejdaYmt2ejg2MkVFdXlvQ1dZcHpSRFZRTFg3?=
 =?utf-8?B?SkxBZU9LTVBWNkdDVWQvV0tVSXdqUEpYRENMYmNZWnU4ZTNxNGlRejJMNDlK?=
 =?utf-8?B?NEh1T1dPWisrUHJjbElLZDlsZVVJMEQzbzNmZUxPUGtic0Z2bEtqb2lDNHFT?=
 =?utf-8?B?OWxBRVQ3UzJyc043dGpXMFMwUmV0QmJzSVBDUWIxYURtcHlleDc1eU9JQitr?=
 =?utf-8?B?cXQ5VU53RW1vK1V6SEZ4dkRKN3pnYmZNUVJQYmFhSWw1UUwrYjU1Y2dQL2xZ?=
 =?utf-8?B?WmJ6WkpUdVJ2QlUxK2VsVXB2L1U4c3FubElNc3BlRmg0NXRzMGQ5a016dlhz?=
 =?utf-8?B?SEI3Vk5IRE42QjgwaDREdll2VXMvMHRBTDEzNWZBUVNlZTd2WEZLRXY1bnhu?=
 =?utf-8?B?cGphTWgrcnV6NXlEY0JsSGdxRGFnY2F1MjdLdnJJaTE1QnFGY0drWFJsNlFm?=
 =?utf-8?B?SkVJcWduSFFmTVNzY01hcmx1cUMzaURKd1VqT0QzMEFBYlZRTG9NWEk2a1hh?=
 =?utf-8?B?cUxBOFJPcWdCSmFuN0I1eUZkQnd5L2tRUjdYMHg0U0MzREdaWktRdXFsMSsw?=
 =?utf-8?B?dG9vTVNxaGJITDlUNFpIR24xclNrMlZuOXBYelRrWG15b01rWTJWWXdLOVpx?=
 =?utf-8?B?b3k5TXJ0OUVGNTRFMlh6VXN2NmNsaVdaT1lhNEFlS1Z5NVB6dHZrL1dLM0Ry?=
 =?utf-8?B?SENxL1lzTStQbjVDSjRjcGswNjBiNHNIMmxBQnpvQkZuT04wc21FbUs3bXZV?=
 =?utf-8?B?SmtrcEh1TU8yTWpkQnNxeXlscFpWaUNqY1llRFJseXRiSzlJbjhGdyswTkxT?=
 =?utf-8?B?Rmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	R0ztKiK77YwM5DIqSRF8dyUcd7P/UkIdKPz92gBuZoQMsOLuyJCkGPYb/xrGysqJ14oG8KUeNL0oVa2PeY8WoDaFvvzU5tOWI1yWjT4KZtuIkrgSUuQH5b3yUzusTjJNpKtotVfoV0VWVDU2PhaOJ9p8d/C0qqn2XD0MFxLGpIP7vR7rFP2HFh1iNlNghjxmkJot2u6WlpBw9FK3aoGT+7ZMufTFipJqdUNXtTCq3Baiku3MAC3IPBuWsClcShotVDgKXkw38R144DJ7STDX658ibKEYP3dyJjoTC87+fDJ9w3qaNBDeV87HXBsvS3X9E04DhIRtIanB7N7knIPVHkS9A0CiIhXQOcyocDp2f0GJJSAAPB2NX8gUricm0XY3eAB24/p4bbHdDqUBTy3TcIGfo7oaeyaur76WIctMeLn2ioKvGFEVEZZnVHzj5iNFcun9PD4bxARdA3l1m/MfV7bbF2hvXbUi56jtXWFP56fqRWklgCQhxG99/ITG6XMm4C4BQ3qMG+y+owRZAxwmVGLesxz3sgcHDrgTSOHW1XbGyeGM9uXjs6UOLo6z1+8h9L9ZHVKRsEOOmGLHMJ2bb7BiphcM8S/1av8zG3px3F4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b65c9d16-246c-4c2f-83d7-08dcfcdc7085
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 14:24:49.2447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z6D53Xo8JV3tDvS9qfL2FPTObuHMzAxtGsG3Zk98yKS14fyZR20AtrSWxnsRuJvMRXXre94WP0/o3lyxYa4izpb+yEei2iiRWO/w6W5CyEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5918
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-04_11,2024-11-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411040125
X-Proofpoint-ORIG-GUID: VKcUqSxUH693NM9_GcoVlLKzVq84ehZ6
X-Proofpoint-GUID: VKcUqSxUH693NM9_GcoVlLKzVq84ehZ6

On 11/4/2024 9:18 AM, Jason Gunthorpe wrote:
> On Mon, Nov 04, 2024 at 08:58:29AM -0500, Steven Sistare wrote:
> 
>>> It's selftest patch no longer applies cleanly, but I'll fix that in V4
>>> after you review the other patches.  Thanks!
>>
>> Just checking -- are you waiting for me to post V4 before reviewing any
>> further?
> 
> No, just busy with other patches :|

No problem, I understand, thanks.  Just making sure we were not deadlocked
waiting for each other.

- Steve
