Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1371DE2BB
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 17:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184462; cv=fail; b=Z19A3JJm0Mdl82aFASQDLBLEyKe5hdY1oLNZycZA3vbYm1Gq/qGdclmvS6iy9xNkQpRgL3u2++w6B5cxn8zY67UKw727vTIlWvFjsmVcn/DBpq+3DESur0a5RHhKeex3jC1QVeuZShd3x2I/MKblUpPs4ktudWvIO3NVw2hHqEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184462; c=relaxed/simple;
	bh=584q3VC1d/DLHeTlK/MalWfhk8NyvpHAcjYjaEEVMnc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uVUlHi27uOtqo54/IaoY2cX08LYUNkGgyfKUeRk1dUNvCcUwFfhMmjUECc+drfFDR/qfZOnR180hlcYA+lYu2/eg4knqswHcsMYKzJ1sqHamM8T5ocdVVrrR3ob8GgwNgCNzIvBC+WsEC5BYL4LWCU8plfLUvdEDQ5ft9JVKVSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FfdW7zu/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YxTCdJ0+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FfdW7zu/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YxTCdJ0+"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBnix019219;
	Thu, 17 Oct 2024 17:00:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=mpu0ppW38EDna7KXuESiiGttt/3b2gxBAg7UNdUxBIM=; b=
	FfdW7zu/TVlM/QPz14b1v9+btLfklTa5Ws/6s6awgr3zcFm1Abya/KOlRL8KyrfH
	iomhuaPoCWnkAjU6n5c24SlkSeLJqPagSJM+KNICNsM2EgVeBNcQz8rIldlIutvb
	aSOw20oCw5FygyDDNkt3NQ0YTdOp4k/3DL+D2rkHcArNm0cekAIf2xIrGifPqsl8
	CndYMFGYf8Ww9uwYbVUubSo1sajTuefmPR1a9gs/u2mQxXfyuk6amxCEt7GQAHcc
	45AkXMzOs1ZW8f4iUheYYsOFSS5plYT9br807PcXmJ+2cVnpzUrYC4aYfOryfUSn
	Pw2xi/o3tLYANFAAsZ0XLg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h5cqbrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 17:00:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HGEQjC026429;
	Thu, 17 Oct 2024 17:00:56 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjah9pv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 17:00:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YgiLJx3Pm5cl4aVv9cV58Lgprd73stNPbYgqZiu+PHU2maPxMzAjiGlFkkTbOImoXwsS1TCRLshyr3ZZyvbStCiEB4dl295/hZGrBZUxYJTiTm+SRJL01yfKoWTf1AtKnhTIbXIdkpiL7pjdL7ugOH71F3Bj59CLImMlys1N2MRSEBTyh+AkY3oVv2wUQ2uPxsUjzEvRgjxbuUNrCzv713B0axKDK/wxZwBSqBljjvyIWdFwrohecyGmGH0TT1h6hWqjCqHxhHHHk6lV20hWAtC76D8CnQXx4rn6s0UFvlEjtASpkatBtuglAUX7ckFL8xROzJ1+hjOLyvW6CuktUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpu0ppW38EDna7KXuESiiGttt/3b2gxBAg7UNdUxBIM=;
 b=rJnmvyt22w2mMvlG48LMma1/eAEp/sSG/mzmdHGjRwnppzr7qcqh5g0GOvpwvb5M5JYQYgLpA65G2D7EEWy9MZtroNpW2lOkHS9Z23w5cYJVuojypQiLxEW4q/4SNva7BMM6dZAgR+2Q4DNz2TlRAmS+9R/AWdZ5GyejaDVPz/SbJoFZ3qYQFWtOOIe3/tfFllw67XWlFTZK/Eh1p9i+C6/hvhMNMGJbrdxwLY6PmnNYSMd8j8VW/b/vAbj1QyUQ/CMaUQ/LdxUnkcmMIVoV9l0mNNfTtZ96uUKK3B3FxV9zbxlwcwCcsWbNdfB+n//NCKa1O5iQExsp/P6w8dVn8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpu0ppW38EDna7KXuESiiGttt/3b2gxBAg7UNdUxBIM=;
 b=YxTCdJ0+ruwDSemIeKy2NFN/H5gRALueTPqBFstOiy9O8Od9hRRtVFyKg77ZfdwBa5K+Axv1SG2XxvxzJrTPbZ+K5WV32VCtSR5PnIjZ8XeIsyJakreHZMqH+jPSuZsl3YiuH06oHHEKTBfDOpT9O5BaTuSj+GU1J702jmCT0+E=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Thu, 17 Oct
 2024 17:00:53 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 17:00:53 +0000
Message-ID: <664df84b-f2ef-4e0d-89ee-68bf5ee08c83@oracle.com>
Date: Thu, 17 Oct 2024 13:00:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 5/9] iommufd: IOMMU_IOAS_MAP_FILE
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
References: <1728067700-32092-1-git-send-email-steven.sistare@oracle.com>
 <1728067700-32092-6-git-send-email-steven.sistare@oracle.com>
 <20241016124147.GG3559746@nvidia.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241016124147.GG3559746@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::34) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DM4PR10MB6229:EE_
X-MS-Office365-Filtering-Correlation-Id: a4fcfbb3-6f4a-49b8-f68f-08dceecd4286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U01aak93Rmx3MElFajgxSFBlNDF3STVQVnVEMEE1THlLKzZzTWVOQ09kQ0dp?=
 =?utf-8?B?NEtFdHU3VHRyLzlscGwwc2ZrU0JiVXdleFBLL3N2Y3RSYkU3S01XaVdpdms2?=
 =?utf-8?B?clVjbC9QSE5WZWludkQ5S0d6QzVxRmFVLzNsRDI1WFZsRk52cGp2dTJKME9i?=
 =?utf-8?B?bXJzQ2lmMXFxUGNEQVdHdWtLdE1MdnExQ0hrc0o1VzhUR0g1SDkwNzRHZTY4?=
 =?utf-8?B?QmF6RHZLMEZxRjRabS9nYllaUkVWc2FEVXVUYnBjNDFKU2Z5WGVpSjJLVjBu?=
 =?utf-8?B?aHlhclo5NUdEbGdvSExTZWJIVnZ6NU96MkVCT0hFdDlGNm1heDFNVWE4ek9m?=
 =?utf-8?B?Z2FPekN1OEZBUnM3enJvTGpIWVRLd1RDSUlwUFlnblZVU3h4NDMvRjZyelY1?=
 =?utf-8?B?aVBORHE1bkhiZy9sMVk4ZnpJSEFvais1NzU4WHh0K0xRMUxjT0lteEduSWNK?=
 =?utf-8?B?OVhXV1JqV0dxTHV2U3ZLMk9YTHQ3KzQyY0ExOUVvNWpxMTZncHdleHo5ZGhn?=
 =?utf-8?B?VVc2ZnJ2VW9MaWxvaGxPWjd6L3k2VmxsUUFkVlkxcDIvaVJ1ZDhrK0NKTFNk?=
 =?utf-8?B?YkJZNnF4M0ovY01JZlpicFpPZTY2cWcwUVpEaDluRWZxbzRBVUVNY0ZrOVdy?=
 =?utf-8?B?OHJFNHI0YzQwVnl5SGo1Z1V0RXN3U0xVS05YRHo5WVhqSG9iR041N3RUN1dW?=
 =?utf-8?B?S0NEc1lLQ096eGlIN3Fyd1hwd1EveGVuMUNIeFRqVERzR2ZCVlFXbHZia0R3?=
 =?utf-8?B?cndROHpNZU5uT0ZveXUvdCtHWHBYWUlRUzdZeGpiNDBxUEI4cGhTMXJRcS8w?=
 =?utf-8?B?YkFieCt3VEE0NkRYQTh3b0RyVVJWRVlJajgvTGtKZEZjQk81bDV2VUR3NVJN?=
 =?utf-8?B?Sk1IZzZ0QS84Vm0xcGdzSEcydTlqUlJQbDVBK3hnMnR0NTZjU1h5SUo1NUt1?=
 =?utf-8?B?UFV5OXpxelc2MjZqK05DYlNRNUw5a0RxNTRMUnRVM3lSbmpvM3NxTnBmVGtB?=
 =?utf-8?B?d1YwWGg2REtXYmRmeCtVcVVXMXZFU1cwVk1aQjNoeEtna3BQZzRVNUdkaFNS?=
 =?utf-8?B?UG5rOEVaN09IQWVXdDBuVEhJS0h3dGNaT2t6TXZ5M1ZqdW5GNWlXMHpPUXFr?=
 =?utf-8?B?Tm5LZy80MlR6TGYxVXoyU1R0OG9CR2pUTmJEU051UDFQUUtxYjFKRHR4Rm1H?=
 =?utf-8?B?WG5DWDNNNDk0ZHMzcUoxdjRKb3NENTQ1eDVuS0tzOEZyM3R4dnc5cGFBMGo0?=
 =?utf-8?B?SjJZZHV3L2poYjBCeVZZKzl2S0hkMGhOMDUrVGpiejRVWTBWZmUrZmk5dCt6?=
 =?utf-8?B?N1NXZ3Y1SjhsME5QYUx0c0lNalRlcjViQkFiRUthVmtOSDdSb2xsOEdHWnhJ?=
 =?utf-8?B?L2lQUk5obkJJSm1JTjB5SWFuaEh4Q1k5aUJFQXloa3VzSGtzU3o4bUs4bm9Q?=
 =?utf-8?B?SHR2WGEvNHp6bndVbDU3TW1GeWVhM1dINEV1TUFOWndoeUVXdkdGZ1VIenhL?=
 =?utf-8?B?OVBCSWxOa3NvVlVrbkU1a0RLNWEzcjQ2V0hKOUx0elMwNGRnWTU3ZEcrMEcz?=
 =?utf-8?B?TktHMkd3ODN5SkNyUkI5OW1pdkFlckZHbDhaNzM0dC91WVJTNkxWaVlaQmRt?=
 =?utf-8?B?eW5KYWk0aHZJcUdTR2xZWDd5bzNMRlZkNXh0NkZRNzhVakh5UUJJUHB3dGY0?=
 =?utf-8?B?U3g5amJHTHQ5WHJOUk1pTnI1a1ZpcWorSy9zb1RxMXFLRnU0TXFSNmdDS0hV?=
 =?utf-8?Q?hVrtP5hLGsFkRUU6MI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWtqemtLNStRMzcxT0NZdTZvTnlVaUZhUENwOWxWVk9hVFFBR0k3dHBkOEZi?=
 =?utf-8?B?dks0OEEvZ0ZZM0s0TzFQamNHZXozQ0JaZVdqTnRKYS9MWk9XekZteEV2VnE1?=
 =?utf-8?B?QTFlcmF2Wk9KQ1RqTkE2cjRTclQ4SHA0Zy84UlBzOFlLYlhielE0d2cxNTY4?=
 =?utf-8?B?aTNHUkp6RHVuaTd2cFJWcjg2TGxTV0IxeWFXU09zS1puTlpCSzNPdnZHNWts?=
 =?utf-8?B?eTNMN0duUGZsSTN1TjFBRjhCSk9ISTA5NXgvbUk0RVM5d0JueElpZ091RS90?=
 =?utf-8?B?UlZVZFc2dEVuVmxhZTdVb3FGbVcycThsWDgwS0wzWC9EU3NzSHBUOW1BaE01?=
 =?utf-8?B?aW5UaFl3Vml3a1VBSlR6dnZVUEt0Qk05c285dlIwK0tlb0tBV3daQStIRjJh?=
 =?utf-8?B?a3FhZ2t1NTVDeVpBS2xxbjd3WVByTE5XTWdoY0ZsSWlqWjJFMnFTK2pQTWV1?=
 =?utf-8?B?RjlSNHAwbUJiVDRVeDRTZ3k0SkhZNVRVU2lvYm5tOXFham1lV3BVL0FUSCtJ?=
 =?utf-8?B?TzZyOWozUDIwNTU2bFEwU0tXVnVqTFBvS2pYZUx6ZVJGY3BKa2g1UzQwN1F4?=
 =?utf-8?B?T1BVZ3NleUJtVlQ3RzdCOXU2Z3NPZUphZWUyOTRJMFNpZnZtOUxaenZCUFEr?=
 =?utf-8?B?MHRtcnFTVG45TmtBSDF6SlNseUVzU09lK09aVlh2MlJnaGhEa1lZQ1FLeFpt?=
 =?utf-8?B?clJ1WWoraENZUndBRHc4bmowSHg0OW5UWi9vanNlMzJwQ0x2OTZzSXFMaGc1?=
 =?utf-8?B?dTVrMFdnS21xamR1Q01OTzRIemVjVDBPN0pKZ3hnV0tnUzlNcE4xdWR4Sm52?=
 =?utf-8?B?N1UxVG9Nc2tZdjFtUDVOcU1GcW80VmNPdHVSM3JLVXJPbEM3Q3BMZEcwZDhP?=
 =?utf-8?B?UElwRjZ4Q1g3L3NxbkJwN3pWUktnaFRLUGRVZG1RQm04OEJ2T0NlL3I0bmsw?=
 =?utf-8?B?a1V2RXcxVmNHVFV4eDUxUG9YVm9xM012bk1ZTXdjalRQbTBTQ2Uzc0NzK1NX?=
 =?utf-8?B?WXJyTnA4SzZiTTRGbDRIR2VJNllydXA5SXRZTHpHeVVYalZhcUFHZnZLSFRZ?=
 =?utf-8?B?eFBLTVZFa1lvYndWTEs2RXdMK1lQTG9vSmpOOFp3WUFRRTc4Znc4YUIrQWhD?=
 =?utf-8?B?ckJZUXl5U3ltMGs2M09MK1hOQkhJNXhrcWZVUkVTWFdQUWs2ZytEaWFhTjFX?=
 =?utf-8?B?NWQ1dFVKanVVbzlaTkU2TE1ZUktMRGFuRGhuaGxVTmp2K3E2elc5RXJxOUdH?=
 =?utf-8?B?TXAzaEdTcnJwK1E5alJlRHFxYVBsbW4xenJjWmJxaGRyREwybk81YjE5bEdC?=
 =?utf-8?B?YjV5NWtuVVA5UnZJWkpMZmlxRU1jamZoUXh2R2g0V3BaTG5ZOFZkTmVXaUc4?=
 =?utf-8?B?a1BncDFSUzdBUmFhSnlHSk9Rd0h6cEJZZ2FyUVZqSjU5aWlyWXNGWVJ3UVl2?=
 =?utf-8?B?TERYUlFuRHlyQjVzL2ZLZzMzN21pdE5oK2FxdVVvMXAzajIxUEZkV0VrZlh1?=
 =?utf-8?B?blpLWXFLWTZUUGtwTTVhL3Y4VzV5RWZaQ0RIZHFoaXNJVnZ2WGFYNUpCa2xw?=
 =?utf-8?B?Q21waVRsM1VhZ254TEtoZEtxZmlJZkQ2QmlUSTNUWnVublJKdlY4ekVjMjlu?=
 =?utf-8?B?NG1iaC9rZi95OFB6SUVVNEdweHVQMTB5TDN3cEwzVG9KT0dFSUFHeEhBMHBY?=
 =?utf-8?B?ZkIrSmdHR0dTVExjcHdWNjhmNjJ2azA4WjNTN2Jrd1pRa2VEWGJSWW9mSWs4?=
 =?utf-8?B?N3VWQkhGN1puK3RFZ3Z0bFUyb1IwSDRwUTNoeVNVRURBVGs0ZGRPM2FybjdN?=
 =?utf-8?B?Vmc4MVREd0xDdXBZMVFyTHRvQlNSbE1uT255L05hYk5la1FCN2NyQkhlSXNZ?=
 =?utf-8?B?QzQ1cFQ4TXpTdVZLcWpJUWNMTzk5cTlPcjVFTGxWWERjYmM0cTRCSVF3RHRC?=
 =?utf-8?B?Vm9LYzg5ancyc1hKTXJCNVhwWVp2eVB5U21wOVF5SURtb3EzUHZpRFdRdmxm?=
 =?utf-8?B?OUZtQndtYnQ2eXFxOElLWDI4akR1MGVZZUVxaTMxY2ZTQzFaMFJzd2dZdjVw?=
 =?utf-8?B?dkl1d0U3MWh6QnEzNWxqY1ZjWnZYTUdwOGFzSDdFV3gxNDJ1TFV1VWwzVEsy?=
 =?utf-8?B?Q0pWTjFDNnYrRWM1OWpQM2NpYTZpVklmUGE1L01oSDVTQ3hRRDFVODhxb05Z?=
 =?utf-8?B?UWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8xnQAZHxrBv0OnDGG+aGDGYRimGoC/I3F22it/c7M+TNBr1kJMOqzvxdk/DDq3H7J9Q0x+EmhZz/+Nq9gVOVk+HoO3Xy+jfM+p27KjnngqMbCXEVnL6jhyktERSF1WymKm/tO3sYjIBeP/4NOt1Wmwa/xZ7s/zfyIMtk7DQIAEzbFADK5n7nyMBWg7+fIEYACvoyuRQ6N3jhXPW6AlA3QSSyyweDCvj5WP7lR7demz4JAim9reCm5u1rJxFNv2giFqiVJLIc9LSi4Oa+8e3OILM9fgoTzlaN7bbbGOiibzUObelqFIAEia5n4wrqo+Nv3FxNgw7hL8uOBFJk/mOs/euSmPjdQkAW+1SjlFOgrkF5ks6TfMVuxIgaTXLKDodLbEIHqkZj04ehVthuC+HFJIE6sP+jY4GidH/KHdua0GZDBo+9nq8srUhu8ulrgELPMTO95Nu5Gv8Ixu6ku0nVcQmrAVyDytTCqkFp8wc3jsmsmDVK7k2URHod3so6KKo6scdErt2DU+R4hOVuq24u1yYk9LVY3mq6YG1GSlt0QlfUfVSO82Wx6ff6iAkDEV+lYvxKBia+B8jRv6ENI/A2oxR+tuYGCv16BQy9HRSuO+c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4fcfbb3-6f4a-49b8-f68f-08dceecd4286
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 17:00:53.3522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oxu//QTU/L81UAalsyNBTv7Vc+ZxsY+qBgeOGxjkR8FnDrEUJSN7EjvNGjuj9s9rV9xYV7d9P+X0sT+BF+fM1pMy+1+YrL2sUYRzlmGKukc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6229
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_19,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170116
X-Proofpoint-ORIG-GUID: MYLSmd8wwOyqS1QR8-8NZ07PyhZhlQ_o
X-Proofpoint-GUID: MYLSmd8wwOyqS1QR8-8NZ07PyhZhlQ_o

On 10/16/2024 8:41 AM, Jason Gunthorpe wrote:
> On Fri, Oct 04, 2024 at 11:48:16AM -0700, Steve Sistare wrote:
>>   
>> +int iommufd_ioas_map_file(struct iommufd_ucmd *ucmd)
>> +{
>> +	struct iommu_ioas_map_file *cmd = ucmd->cmd;
>> +	unsigned long iova = cmd->iova;
>> +	struct iommufd_ioas *ioas;
>> +	unsigned int flags = 0;
>> +	int rc;
>> +	struct file *file;
>> +	unsigned long end;
>> +
>> +	if (cmd->iova >= ULONG_MAX || cmd->length >= ULONG_MAX)
>> +		return -EOVERFLOW;
>> +
>> +	if (cmd->length > 0 &&
>> +	    check_add_overflow(cmd->start, cmd->length - 1, &end))
>> +		return -EOVERFLOW;
> 
> Why is this here? iopt_alloc_pages() does this validation and I don't
> see math on these values between here and there?

Since the refactoring of iopt_alloc_pages into iopt_alloc_user_pages and
iopt_alloc_file_pages, the former checks for overflow of start + length,
but the latter does not.

To make it symmetric, I could push the check from here (iommufd_ioas_map_file)
down to iopt_alloc_file_pages.  Or, hoist the check from  iopt_alloc_user_pages to
iommufd_ioas_map. Your call.

- Steve

