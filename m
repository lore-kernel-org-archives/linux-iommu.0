Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D66C46B8
	for <iommu@lists.linux.dev>; Thu, 26 Sep 2024 14:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727359217; cv=fail; b=ROysAHbd2nuzbJd3pmUhpLBV0Fkh+xgB1TrqpnJ5aAYQW/SC5yk/QxJKQAI59PWAzoypyNyf+NVWZE4KrNIF6t38rOpI4Yas71WSHdtGROfrY1BjQXa+v/GDegAI1R4mabhV1hU5BC+fKnVXVBxYWZGs0tGywVT5BU6thHzP+vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727359217; c=relaxed/simple;
	bh=DeTWDTxvoqRDuCHwsIz2e9GQkn2c3+hEYhsM240wm1Y=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cU/f+0LwQNZHX2YQz+s2LkEh5R/aoNTH6oWdx8a5mB+nuiYt9PLcIJdsyvoaWmEyI4cLSynlztiM+CxXqvxkGdxvuS7E6rchNEOFgJxtCvkrm1FdrGFtLrvGRxmSUKJwogDC1jFX5a1u5dOZvKEp1au5sFb3+n8aP7p0ZjviOn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Gx3vgtjm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Q2EVFnB/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gx3vgtjm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Q2EVFnB/"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48QBDlL6008615;
	Thu, 26 Sep 2024 14:00:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:from:to:cc:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=ujeUr8EMvqxW1LJTDLCPTyFFYw2lgRZ+A73M70j/eKU=; b=
	Gx3vgtjmLLZOirO3lPznCRxMCotXpFSCO0zWtq2xzxBiRyvpbYkO6BySLnmxDz8b
	4YlFAoNDhGvOGFLwl4rYqZDDJ6WasVBov1Igtsr/j+GMdvp2BbIlN7NZzKROU5Dh
	eqxtPWulWsZVrtzIT/QKigyDKNQvlfwhd0O/ymVq9G9WAg7/vhnJUyOYnJBgQZmY
	2u4gkvLxvObiQ1CqvtSdvbrSdhVD6NWMOO6zBZf4qjU02HMvZDCb2KvYxjcKLJKS
	7IHy1ouQ0qvlJXyQHkxdxmsfLdl9cp7CGB1nI3aDYu+9FDEYzQgwNKXqydP2Csyo
	Q0g7Yprg3LtlAylbcYZUuA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sp1an4gv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Sep 2024 14:00:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48QDZgFJ030308;
	Thu, 26 Sep 2024 14:00:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smkc80gm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Sep 2024 14:00:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yObspEKEPVwVo4/hWB14fkSwsBbcGNHFlOI2Uk9Igw6yvZs3S73SaX5qr6Ac7uOdPiDwyRVuH/gUSjxW9q4RW55Wf5DpnK7I4h1Mi8cWQVRL0GhhfbGK7oLV07CbsULCS1+i6P9K0VmvIb8WRU7LpH16XxKBmxaUvKesGkoy3ajmo5mx2TwwODFpK3OZt4xuOp6X7Vs4Dj6Ry59LLaGFpPawCj73GjHDYrfoPpOLa7VP4Jir1qDtzwA4IkOohWK2i85eTQ6SKrYU/0i+NdIgQmMQeE69ecEIJPT3ovKy9ricDhSfBoenQzwYT6wd3vdC8nL05a4yOFmX0QAdbChkNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujeUr8EMvqxW1LJTDLCPTyFFYw2lgRZ+A73M70j/eKU=;
 b=n0dCURt0uBDIJ0YnqwE/qtcJqjWRE3UcwFPI1kbIyFKDSJzMtpQcVJR2a0FyHgApJmiT0GfYyfsNatuJXq2LMtWxHSGTzGYQIWwFoLPuP/PC68zwJtUICTmu3qw5nZDo4L7JmaU4zxF4saQywPJO0xvV5k8PvIW20wJ9OmwuLZThQZg1SSFX1Y1+UHFNIURHSHe5I8Hb+3383euoFtxL8rLzkLGc5J2X7oI9Llm4pi3Y9P2MHhnRe3LL3Visb0zZojvHrrnLDsjDSaA2UN771Zr1Gw2trBPT0CCbkEWlLBioW1lo4obalBlJH9O2jyuo02wPgtapMWgE1dTxllbQSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujeUr8EMvqxW1LJTDLCPTyFFYw2lgRZ+A73M70j/eKU=;
 b=Q2EVFnB/V2UQnkexzWKCAwjhfmSIY42TpJfL+Y9aOwquiNPbYlKfa4uQ0vjmJGTpP29n1GnLkSC9/yjKJltb+nIc4YoigG7JHpGBCaCPgOsT4iBiSHs9lOimb0sLk/D2wkKPdfmoYOrlrEHLaQ5ixjZeta4aeu2o2vu7xJ5oEIQ=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CY8PR10MB6825.namprd10.prod.outlook.com (2603:10b6:930:9c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.13; Thu, 26 Sep
 2024 14:00:09 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8026.005; Thu, 26 Sep 2024
 14:00:09 +0000
Message-ID: <d40b88b6-711a-4b65-b947-4118f2a32de7@oracle.com>
Date: Thu, 26 Sep 2024 10:00:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 2/4] iommufd: Lock all objects
From: Steven Sistare <steven.sistare@oracle.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
References: <1721501805-86928-1-git-send-email-steven.sistare@oracle.com>
 <1721501805-86928-4-git-send-email-steven.sistare@oracle.com>
 <20240722153711.GG3371438@nvidia.com>
 <28e86236-8066-4b1d-b201-5fbac645fc8f@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <28e86236-8066-4b1d-b201-5fbac645fc8f@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:217::34) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CY8PR10MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: 7407b890-64d1-48cc-db3e-08dcde33889e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmVpaTJsTm5zUWgxcTc4eDNpbklibDhLdS9vTy8wMHg1NEkydWFwcCtvTm5U?=
 =?utf-8?B?eEE1UzV4VEc1QTFmaW15MWxWUmxOeGc1RDFzSFh6c01laUhHek1FYUtKYUhS?=
 =?utf-8?B?U09aYXZpR2RyUDRCUVBwVGFqSlVnSnZZdEdaelZjaHhRLyszaDRDL1E5QmdX?=
 =?utf-8?B?NkkwZTFBM0RyZmlqU25Hc0xLb0czY2pYcUlUSmtYYmNKcVVHNUFzbEZrSmNm?=
 =?utf-8?B?elJ2SXVpVzdQTUp0Qy9IQ1U2bE1MQTFLaHJyOVRUaWZaRVMvcGx2V0tGWWgv?=
 =?utf-8?B?KzdOMHl5UkJ3L0d2bzZjbURlMHAxSndUcDI3TTU2VU9PcWZYRUdMcDdmRDJG?=
 =?utf-8?B?S2F3UG5mZzN0THZZaDZVZUY2SFh5UXZvSnNDOGpWOVQzK2xIQ0x0V3hDUkVD?=
 =?utf-8?B?ZXBQVXU1VWtSc2IvZzgvTWNQQldPN200Vld0NkQ3ZTViWkZiRVBZQnV3UnlM?=
 =?utf-8?B?c0tTaWdEQTJOOGdjNmEwLzFZRXpiZktYb29rZ1JuL01zaTZhYndjNmMzNnBN?=
 =?utf-8?B?SUtFamhJbXFSZ1hQNEtYM3FWMmdzWjh3d1BnMENYK2p5eFBPb090KzVDNEEz?=
 =?utf-8?B?Y05oUmVWNVp6MVBlVXgrK3RYdkZYeldMZjFNbmp0dFc1OU14WEppMTRlaDlD?=
 =?utf-8?B?NUNpQzk5S3FZY3UycjFqMjJINnp3OEJocVloRFJEb3J3TW9LTnVZY1V1eEF4?=
 =?utf-8?B?enZCQ2lWRTcwTGhHcmwvaSs3bmk0aVZKSlI5YXlKcVlUZGllOTZRNTlqdHZY?=
 =?utf-8?B?dnhqYUJFczhCNmJtczNjUk11d21ya3VUWkhObVZjZGFvZmEzbDhmY0VscCs4?=
 =?utf-8?B?ZkE4WHg1RGFLbUllK0JsVDl6YXZ2TGhXeFRBS2lZWjdQVDl0LzRFMGtJaDBx?=
 =?utf-8?B?QjY1bVNJU1FSNTdIbklNcU55YlJlMFRPODg2YzNXazN4TVB0YVF2cmJIaDcx?=
 =?utf-8?B?a1FWKzZYMW9LQnJyeERJcDJpMzhVc3BsMlRzWVA5b0JySUxEeXE3cUJZMUEz?=
 =?utf-8?B?anRpYWlrNEl4YWFXR2JURitIUktTSlVERkg0YnduQkcxbk0zcWxFVXMxNVFM?=
 =?utf-8?B?eUxYQm83K3VKY0dlVGdFZkNaYWFHZHFlUUdnZ05NMWxYVHN6ek1kcWVLSitC?=
 =?utf-8?B?anZWc3NqYWpHY1U4NDJVSnYxT3N2c0FyS1BHUnNTTWREYlVRaGtYYm1kQU9K?=
 =?utf-8?B?UW1SaWpzSGxGYkxKaEJrWUxHYVE4QlQwbjJUWkJCdm9qY21LQ1BsQkdRVDBH?=
 =?utf-8?B?M2cvbnRuZnhSM3VqVzMvL0Rka1FNVXVuOUI2eWpzNndVSDBqZG5xY011VDZT?=
 =?utf-8?B?d2ZLQmVGUi9yVG9WSitWdDNmNE5Od3lFc3ZSblNCQjRaSTBVRWlZS20yVWs4?=
 =?utf-8?B?dVEwQTJFMENpK1hwUk93K0JOOGZndHF0clZhMVRmU05JMjBCUFRkZEFnSnNy?=
 =?utf-8?B?dTJUZUdMZkRYVTVDaTdYbHpNNHZNZTk4RVBmdm1vYllFcHVJU2lrSEhFcEhu?=
 =?utf-8?B?T3QxUEI4Vmluc3ZWeVpoQS8vaVFlS3lJY29sSkh3dDI1bERqK1dacDJZNVRR?=
 =?utf-8?B?L0JpQllhQ09Ydnd5QnVZVi9sLzVGbnU4MXd0Mk81S0tTLzlZb2xwdEZ4N0tE?=
 =?utf-8?B?TGF5bXJ1UExXL0FnNGg1L21pb0h5amNBaXBDUkplRzNqMGFwbW44bFZYWHdF?=
 =?utf-8?B?d0hNMzMvLytDbUdRWG9oL3dTbnMvTHc4cHNxdnBxTm1rbVhIbCs5dythN3ZO?=
 =?utf-8?B?UnY2a1NlRmVvdk1RbW9UbVhTM2w0Z2l1K2h1MDB6TWV0ck1JN0RPeUx1TW5D?=
 =?utf-8?B?RzlOQ2tGT015OTZMS0lHdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlZQUndTUVA3UFgxMC9PbGZSck94T3FVMXAyYTRHOUpEZXNCa1ZmczU1V1o1?=
 =?utf-8?B?SzVDSUtPVXpFTzkzZllqdUgyc3Yzb1E0WTB5S3Z5MG1aa1kvVVRBaDRxejBo?=
 =?utf-8?B?cmg2bnYzNFhmRHZRQ0hCbHpHTSthaWozdXI1OXQyOTd1cFVObEN2ZHZqcllt?=
 =?utf-8?B?RGdGOThDekpSS0dESXpnNzkyNitPYnVwOVJyWEF1VmkrNHlGVGtIMjJBbUUr?=
 =?utf-8?B?SDNqUVFGTkk3Qk9XUDhVMVRhK1FweWxoUEw2UU1WVTZBSHRnaThnK0EyVGF5?=
 =?utf-8?B?bFZVLzV2V0NMb3BzK0EwZGFab3NRczNQODNSVzQwczdRZXF4TTNnR1ZEd3c3?=
 =?utf-8?B?NjVzZTA3Vnp4K3BsSCt3UytUMkVSOXM3UkxtMFJxUzVrU3NjOUM5UWllU2or?=
 =?utf-8?B?NVE5eHJYMllUVTQ2eEtRSllmdkU0TmVrc3pCbTc0cjNva0VrYnQ1aHpoVVBz?=
 =?utf-8?B?dVlHbngzR0xqUlZvVFk2Rm1YWXZJYXMzSkdLMlN4azErT013NjZzZVV4UVpu?=
 =?utf-8?B?M1FxaWJ1aDF2UEp6aGUwcVg2YmFvMkViMEVlaDRuSGgzVlFsb0srTVpkYmtM?=
 =?utf-8?B?Z3JpOXYzNUhkRGIybTVreXRkT3ZKT0Yva0FKMEZ0bS91UEZlT1hLandaWGhr?=
 =?utf-8?B?YklEaGlOdnoxWHd1bUtTYkhNSmJZaWNnQjRXSjFBUnpJc3RmZ09GY2krS2tU?=
 =?utf-8?B?OGh0Y1Nxa09WbGlSZGh6Tm5Vb0tNYWRVM0ZZZ3RBSEVVZU10TmlqaWFjdTBZ?=
 =?utf-8?B?S04rN2Z0WXY5TWtJckZPblAxWWF5TFRhZEhQTlQ5c0hMNWxvdUUyeHlXdGhC?=
 =?utf-8?B?emFycUtwRXUySHoyM1RpRlZXRlpWY3psR1czZDhlQ2thVFdSUDNNelNVVy9M?=
 =?utf-8?B?aG1QQjg4TnVFRkE1NE9jWHRKRC91eU9aM3h5bFBvclI3bmJRNWUxTWNnOEI3?=
 =?utf-8?B?VGVIYTNQKzFUNUhXOVRGNFovVUZTb2lOandWVmdFRTZ6YmNDbmwyUWhVdkRJ?=
 =?utf-8?B?ejNUSExEWDQwSFl5Qnc2Q3h6eTlnU092dWtZUW0rVU1sYzRZUDY1ZFo3Y2Zw?=
 =?utf-8?B?Q2JmZTNNWms4U3NaVlliUGRpbXJQQzdKTitqQ1BEU2dMaExkQWNaY0gxVFBi?=
 =?utf-8?B?RUhFWWx4aE91RUEzakZaNTVNVFpvblA5VzMyaUY0MjdzQzRzZGFIUXE2RHVW?=
 =?utf-8?B?ZG1UWXd4SUdzZHhoaFJlUzA3dUIxOXNEZVAxZy85MjVWMjhvZzBrVklJT25R?=
 =?utf-8?B?TERCbXVQd1RXbEtMUmZOSzQzM1VXRDRGMkhUTEQ0VzFSVVFESlBnSEc4MVhG?=
 =?utf-8?B?djU1aVlFeEVYRFVDWkVvRlpFejE0dGl3alE1YzVjQllwTDQ2ak9aakV5amZD?=
 =?utf-8?B?RVJnQk96TE5DZjRFM0ZJY2ZiSkNKZkhyWENyNUtnMVJzWWRXRVRrT0Y2WUFZ?=
 =?utf-8?B?aHBUSEhUaDNtQmw2ei9wWWZzVUw3OFJ4aS9Uc3Y5dGF6WmZtQmx4dEZVYnBD?=
 =?utf-8?B?TU02Mll2NDZpZ1hlbU90WmEvd3JnZDlyZm1pM0lUaHdwTEExNnNMZVgrRk5v?=
 =?utf-8?B?aEpkdE1LMnJYaDB1Z2NPVlZYSHpMd1BGV01KZkUyUlNnMVUreEg5ek00NmtF?=
 =?utf-8?B?ZVpZU1htQ0UxS1dQb3Fsb2s5RjlGeWs1Zmg1dlo3alllYTNWY1BDNzBCNi9D?=
 =?utf-8?B?ZGlycFlaM041Q0E0MnFiTmpEbW4rek11U1ZuOGJOYmJZdVVKVmpLSEdXWkFT?=
 =?utf-8?B?U1NhN3ZVQURvc0d3OTJXZW92V1J6STVTNENSRTVsS2tqY0ttWVNCN2ltS29H?=
 =?utf-8?B?bDNlUE5mb2Z5Y0hKNXJGaWhWbWdYM1VTbXVHb0FMeWlvVHVWYnlpdTFFbHVJ?=
 =?utf-8?B?NGNKNUJKSXMxSjI2TzVuV1Q3NzBtdWxZVFNaVSt4T1VYQVhkSU5oTWlTeCtO?=
 =?utf-8?B?WGxmREV0VWU0TWlMSzAvcll3ZEVQK2EyVWl0eVN5NEg1ZmI2UnI1eXhTWVBF?=
 =?utf-8?B?QmRPU3B2SnhBSmN2RlE0MkF3TVJ3d3QyanNnbVFBTGozSTBRd3pGM0tSNXd2?=
 =?utf-8?B?ZnA0Yk5xNmc0eXRiSkhlakJQWWhWK3RmVi9zMVhpNUh6TjhrS2NySk1pbnE5?=
 =?utf-8?B?Q1dKQlIzcWZNUjdubTJITTdzc2VNbU9xMnM1aEZsaXdqbXZibGVrOS8yT09n?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9j6PWJNvzQUt2X6QSUH61nPioyr5+S4aLYsjlEIEwgkp9o3nuz5IjJY/uqnKjvpmcCSwgFnlRFKnPfctv57CNVhgS6FlqR40SjOG5fK39vOSmdXlItbGw8X8cyEe1ckZkgIZFFO/f3LAnIKSUYV7dOCYSUuOWLEi3CG3aWQWTww1lx714YTTeIF4y270LK+plKMCOu2dnB8NCwNA0YkvuXa0T7vlyjyOA0vY6vIDYKpaDTWMbH6821/kkhP7Ww4+eMRec0rhYVK5N0QUhTNxbZAGbvl7r/0yM7OGZ3ep/nyBfj3CTRpxBgr/MnVqn0UtNf1qSVC48ny1Yl5/+j8lbIFNeJHvSeg3NjrBrWFHee1JO/Ui3N9WDOcKo/B+Nb3qjOFCTg3ipy/lgwhXObZFW26SJYOuKaqMXy5rSQJyGT6QNeyn2b4THGTTOwRkjqboSl5ZwbLp/jPjlFaOmTRKq2oHqqQkV6NmJTA8YgS8oWlTO1T5pBaRwUAvI4VcN29E6clqUEWZRZhDJkj69PcqLAGC3lLr0DeWIv/zhjHK5gyl9Ot9VWvjX0ez486qYkTZtaHfcUKF1bVkheQjMaK9Q7ag7EReK7v4n2o/hWFfByQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7407b890-64d1-48cc-db3e-08dcde33889e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 14:00:09.8574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AFqq5cqwun8nAjJbY8yfYo4tHv+81D/nz01OXCnMVlqfk5JKzEJUyXInMy84kyQDy3aeWiw9KDvrDhMWCsXs0mRyjFfqehtomriXkHJLzT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6825
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-26_04,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409260096
X-Proofpoint-ORIG-GUID: U_oSx4ZJQEsAhw_yU-YecVQFFlqCaRWR
X-Proofpoint-GUID: U_oSx4ZJQEsAhw_yU-YecVQFFlqCaRWR

On 8/5/2024 3:01 PM, Steven Sistare wrote:
> On 7/22/2024 11:37 AM, Jason Gunthorpe wrote:
>> On Sat, Jul 20, 2024 at 11:56:43AM -0700, Steve Sistare wrote:
>>> +static int iommufd_take_all_iova_rwsem(struct iommufd_ctx *ictx,
>>> +                       struct xarray *ioas_list)
>>> +{
>>> +    struct iommufd_object *obj;
>>> +    unsigned long index;
>>> +    int rc;
>>> +
>>> +    /*
>>> +     * This is very ugly, it is done instead of adding a lock around
>>> +     * pages->source_mm, which is a performance path for mdev, we just
>>> +     * obtain the write side of all the iova_rwsems which also protects the
>>> +     * pages->source_*. Due to copies we can't know which IOAS could read
>>> +     * from the pages, so we just lock everything. This is the only place
>>> +     * locks are nested and they are uniformly taken in ID order.
>>> +     *
>>> +     * ioas_creation_lock prevents new IOAS from being installed in the
>>> +     * xarray while we do this, and also prevents more than one thread from
>>> +     * holding nested locks.
>>> +     */
>>> +    down_write(&ictx->ioas_creation_lock);
>>> +    xa_lock(&ictx->objects);
>>> +    lockdep_off();
>>
>> IIRC we used the nested annotation on the down_write instead of the
>> global lockdep_off? See how mm_take_all_locks() did a similar madness
> 
> The code you sent me used lockdep_off but had a comment wishing for a better
> method.  I'll try the mm_take_all_locks method.

Sorry, I forgot to address this in V2 which I just sent.
Will investigate and add to V3 if it works out.

- Steve

