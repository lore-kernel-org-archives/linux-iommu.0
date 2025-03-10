Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAC0230BD5
	for <iommu@lists.linux.dev>; Mon, 10 Mar 2025 17:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626441; cv=fail; b=SzxzNEVvlmlJxbuoIYJbZHPeR+vv2NGtRAmWlTAxKWcG9r4aRDsaA9zdzb572yFqlSiZBlcjv8QoNBw0rRvkyVmHSpq2eNIdHpptafHYk6xXM/ZUc2WLxy/IXjmYOFzoIc4RJTo+IwYJossBmxHEU72VBHM3MxdWP9v26NcZ93s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626441; c=relaxed/simple;
	bh=s5py0egJZSzLhGlOzE87tsLbFgdnDcu79C7ggpyNTR4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rlREnQaJiurifMJJBoh6gN1PxIHIZPAVgyMkn5xc6lgvsh/L1QGKPu9tSuoTzHhVyDwTKUNCXd/2bsy4/FUnn3JaQdj26Uz4bRR3mTXPKz11DS560H4P7d6lMUqOW0EH75yvX40U3TDChREuANnppvT/mPOg6i4DQlQRbZfciw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b9XG64ni; arc=fail smtp.client-ip=40.107.237.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b9XG64ni"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6MR/WeYtvErFktM/Q1RieYaCqFXTlTeBpk5CCGorZBUlVa+HcMrV5TxMgSlGnKiojOtLC5pjHIEG8OjTLZOn6N8Z7t8ZliHzgSUKO3zp/z7l6E+JQhE2G0ZC2J1vYe+D/QuZ+JfEJvIHp3f7N0QN+0NcsNwzqoETMZisVGUsS+X/ywFaTA4Uzir5Or5rn8YFBVStgTtgNSbMR87M1ML9sutufieDeP3tKKSZjqTT4TeErSuqI3Bij9KiPYAEcFSHD8yug+x2b1K29gwn6mURN+i8K+F/ydug4MtoBElC2QWPRk1ZxEIfXhONRmt+TfPg7BEqPULeQRMlWld6H/P7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXziLmzD5NxYaWMTNDrabahXX/JNg7OCzE9c2NBCVLY=;
 b=vYNCfAQket5S6946HGTRs/071XceGntwFwRQgKdkscsB0EgHeWbwp1tfWoInODUA2MGKREwzTGOvdr9btkyDgCsSQbyX7IllIt/m8HaHHZpEXgqeaH4n0v371mPFCSnuplsWb4MWg38V4PHV6IQJzInEiCeny5MURvO4P4EK/z9fkhaIn8u1oLCiAybYxldpHi4iTT5BEoShbjk/ecR9buoWj7biMqX10YE51kWrlaKqev66aIDpPtjHbyD0GOfHaQpVvc2C1qdMvhe0A8WC8aC8OrTSvKleRzi85gJR8g4ZhYbVBDNdUriN20LZV8qs0ZR3zud2ki8diVBhY0gwRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXziLmzD5NxYaWMTNDrabahXX/JNg7OCzE9c2NBCVLY=;
 b=b9XG64niSAUVL+eRdTNYSYUya4iqdreucfuAdBYpiifigk+V4O7qRNNc/IYQlvItaRnv0jpSTl94SL5OAKoEIsUWqxxK6nDvpVs/2BHN1G75iPElKKM/qx9onzG3unX5xSykYTaa3o5nvoZgirYbCEdMJFpcqGfSMLyGP1chKPg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH8PR12MB7445.namprd12.prod.outlook.com (2603:10b6:510:217::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 17:07:15 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 17:07:15 +0000
Message-ID: <f728d10e-97d0-44eb-ab2f-0e40d7d5f810@amd.com>
Date: Mon, 10 Mar 2025 22:37:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
To: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
References: <20250225105829.52223-1-vasant.hegde@amd.com>
 <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
 <ce86ff90-377e-49fe-9c4e-d2ad7abeeec8@arm.com>
 <20250225145518.GJ545008@ziepe.ca>
 <BN9PR11MB527624C1DED16B3C049D13438CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250226011750.GB5011@ziepe.ca>
 <BN9PR11MB5276B3E410FD336A3062FA5E8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4fba254e-ca47-4e7b-baf3-0228d9605c2b@amd.com>
 <BN9PR11MB52763A8885AF1678E05E8B528CCC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <942a1a66-5c18-43e2-886e-df38cb3e7258@intel.com>
 <54db17d7-b150-4579-a33d-f1b5cc8943bc@amd.com>
 <6eb0ec90-5859-4605-8a2e-657f6f711d61@intel.com>
 <825ddadd-6770-46b5-936e-f17988534984@amd.com>
 <13e1e1d8-5870-44ea-a800-e5b25bafd344@intel.com>
 <4a0e64e9-57c5-4f30-97bf-00c3eafe0b8f@amd.com>
 <BN9PR11MB5276786C4BF482199872BB2E8CCB2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <BN9PR11MB5276786C4BF482199872BB2E8CCB2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0138.apcprd02.prod.outlook.com
 (2603:1096:4:188::12) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH8PR12MB7445:EE_
X-MS-Office365-Filtering-Correlation-Id: 45b3b133-6bcb-4335-d1ad-08dd5ff6015f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWh6ZGE1MjU3bnlBNnNwVHJlTVUwL2c4UnB0Uklmb25Uc3I1SGJMYWxieG1H?=
 =?utf-8?B?V3ZJanJvWEdmcm9kT1pPeWkzRzg3WVVzME0yNjBRWnJ6TkcxU0dBMGpZRjY0?=
 =?utf-8?B?LzllTkpPbXBWRDNrRjBsa20zQkw0aVQwSzc0WTdJemNkQkZBWnk3SGJjTTdm?=
 =?utf-8?B?c2c3Qmdydm5ZUml5Zks3WDNVQ1JydnJDSTlBN2J1Uzc1TGtvOWRScW9CM3hu?=
 =?utf-8?B?cFZwRFZQZDZ1amRVVytKeDlFTldLZkxQNXpHZEFpUStsMWtxSWl1K2U2a1N4?=
 =?utf-8?B?ODlrcUpuOXZmZFFyZWhTYU9XYVVTUmgyOEllbkJjUDNWKzl5Q016TW9Hc09J?=
 =?utf-8?B?d3dSSVVwK2lhUVEzZ2pUQ2NoOTNSaFZNK1Y5eFh6UjJ4dDNLYzRkZ0x2L2ht?=
 =?utf-8?B?Z3c3R1E1MFZXRTJZRkNoYzI3MkhIaiswa1VReG43ZXVLVDYzWFl1Z1d0VGZ4?=
 =?utf-8?B?TE4vQ2djZE9XUGZTREVISEJtbllBSWlBUlNoSHhjZFRQY1VYWU01bXNjbVRH?=
 =?utf-8?B?TDliNVZ4ZHdMNUVJVmwrNWFYRVVMaEhJOGR2T2t2YnZWaURPSGU0WGRSSzJi?=
 =?utf-8?B?NlJLK0pxcGJzd2VELys3L1RJdUhSZEVFMVg5M0huYmp5U1JueVFnNmFLMTkv?=
 =?utf-8?B?T0ZBOHRnYkJuRm9yT2pYcVVzNWNVVkoxcjNLeVN4QmpTbkhBa2RMNS85UXVG?=
 =?utf-8?B?N0JGa0JkWUtkaUNPSjQvZ1h1ajRwYVN3OEZtdnN3NUpvZUkyZG14VENOdWhG?=
 =?utf-8?B?N2U0OFc4UzI0SGFudHhXbU1uN2tNMkpyVEJ0U0cwSzV2RVJzdnN6YVJmbVU0?=
 =?utf-8?B?WVU1aGl2SWw1K0JIUVVTaE1NMnZXcE1Ba2g5ampoVXF0N1hqUUd4WG5TMGRM?=
 =?utf-8?B?OWZ5QTFDOEV3TnJKUDQvUUlhTXp2RmRhMmpRenN2RWtybmVtVlYzV1ZYNmdM?=
 =?utf-8?B?V09BSnFoOUV1ciszVUhSMGpLYVRlWmtmNkxxNDlNMVBscnUwS2tmbDdNUzhL?=
 =?utf-8?B?OUFzRzVUcGovVis4UmRnVEtpS1hYYTJtSE4yRGZaeExTMHVsZnU0cnNzelc0?=
 =?utf-8?B?UEMzbk1IY0d6dVIrR2dvSzlldmJ2d0V5clJwUTd5bTV1c0JDVkx6Ym9NbSto?=
 =?utf-8?B?a2x4Ly9MSWF5Y0lKVHpod3drTzdXbWtvdXBaUTRpeFZLMVBNNzE3ajlTUlJu?=
 =?utf-8?B?WVp1dzhvaWx4bytrNHpMbnRvdThlbk1EaDNpaVN0amF2c1NhWURPNGUwZ2Ji?=
 =?utf-8?B?MTRoRFVyOWNsM01QdE50N2ZBcEZ1RmpGMDNJUE1NUW9ZeW8remsyT0tpc2tF?=
 =?utf-8?B?VHR3VjBPOXlTUkNlQjc1M1oxWThMSnN5ZjkxcWY4cGsxKzc2dm9aZjlYSzM1?=
 =?utf-8?B?SGlwVGVMR29wdDdaWFZYNmhLTzZEcVdxdDRKOUlZT28rcHg5b080cFN4QVlQ?=
 =?utf-8?B?TjZSL2FwaWh5eFhZMitGSGxFMTd0WWZDWm55TTEwVkVLVHFvVkJ0dzdyTTg4?=
 =?utf-8?B?OTF0V1pmWDRkNU01blZuaC9GNDNEbFhDTzlmMnkvOGpNeEdvS3NPekRndTd3?=
 =?utf-8?B?MGY0cmZpNmFDOVFsVGNrbXFqOGlPM2QxT20zcy84VjdQaXNzV0tHSktLOE1y?=
 =?utf-8?B?dFFoMWhyYUlBZUVpTjQrazkvR2xMWFp5dDQ4R0dNbHFwZ2xRSmtpQTJ6OExa?=
 =?utf-8?B?bDBOSS82UE95WHdJMXU5VGRPUTZTb083eldZUHFIbHZOcWVsR3Z4THFrSURF?=
 =?utf-8?B?S3JnRCthaDN2aEI5NDllTXY2cmZCSVc4dmp2VVllL3VHR3NLSzlhK2pWbmp5?=
 =?utf-8?B?VU9heXYrd2xlNEZZbFZ1eS9uWU0remdyNUd0OFF0cDRCdFZrbWVJU1dhU295?=
 =?utf-8?Q?LUramDWIfmqI7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SE1QWGJ1cURYMzRBakZYYThlMlJVUTRBWVFKUThsT0FOL1RMZWxhQjhxUkpV?=
 =?utf-8?B?ZmJTSjFjbk0yRzNPcURoaGJ2WE1VUUNzQ044eXlSRmdOTEZudU84K1FMQ242?=
 =?utf-8?B?RnpwYU5ZRXZzSkM3Z0RrM3lkc0FsMzBXeGRST0tUem9XaFFoUXhKd3ova3Vn?=
 =?utf-8?B?aExhZXRacC84UWxjcVVZdkUveHZKRG5pYmF4RUI5eE9vQ3FrdnVpUlJQa29N?=
 =?utf-8?B?YWtTOHlrV01kUjhuV2pOcnBmeDlzV1lXdkFBT25UbnhQUE5mMFhpdnRuaWVH?=
 =?utf-8?B?UlladHAxdWl0OTlFOC9BcjFROVAyU1V3NTFCanhNQXJhZVRFekdrVXdhdytP?=
 =?utf-8?B?OFZBcFZGNDdkdy92SzUxUC9ydGNCZzh4NlMxeUFwN0ptUGt0cjMzdGR0YmFI?=
 =?utf-8?B?SXFZVjhObWJZR3laZzdFc3FXemYrRzlHZHlieis5VW50WXRMWGU5NWdMc3pK?=
 =?utf-8?B?OUFNZEFaOERLZ0QzOENYS3I4bk5FNzJDTWFXaVFyZ3NZQ3VVMklDSmNVUCtT?=
 =?utf-8?B?TjJ4NmtKc014TERXVXNwTmY1bHM1RHp0U0ZIZTNkSmlFSFdwT3RTN3RzZkgy?=
 =?utf-8?B?dzlZL3hDd0V0R3U4QnhLUXpQbHNuT3VlWXR2SzFRTXplL09BVWFGUnNkenlW?=
 =?utf-8?B?cEJRRjQ3RWNxVmswYzloK1orUi9HOUlaYS8zczB1Q2c3Y2tudm4zaEFYdHJM?=
 =?utf-8?B?SE1odlhJL2VQZjV6bFJHemtxZmxwNXI1OWd5OFA3cmUxZU1yQUtXSWNoQ2Yz?=
 =?utf-8?B?UmQyY1Zsck9sMG52ZTVMRmtuUzlqZ2VxUTdaaUQyNEtUZ2d2M1pLUldUcC9r?=
 =?utf-8?B?eHBLM0R5RWg3V2p3dzFWaGxDZXhsRDZuWUNaK3hvREh0ZmhnNjFEaFkzc1FN?=
 =?utf-8?B?dWJsZVhBK2p4N0ZCV1BXUVNqSjdrbkM4bEtZZlpJSE9KTERKM2tYZUxIcnNM?=
 =?utf-8?B?bTNYNDF6cFpDQ2wzNjRieVk3cEJOVFhFb213OWNLQjZKZjAvTmpSdXIwQ0Fw?=
 =?utf-8?B?Q3c5SC91R1JqeWtVYUFqQjExVmFXbFI0d0xaeVVmSm9teFowV2RkcXZNQWpk?=
 =?utf-8?B?WHVpaWkxSEdKUDNlY0FNUTVJamxlR2ZRYkszZnp1YUw2RnhHdHRRY01QUTJZ?=
 =?utf-8?B?b3I3UExJSUxCS1AzMnM4dzNCTjByTEdITXlTU0JlazdUU25WWHlCTFEwcmRC?=
 =?utf-8?B?R3ErRFk5Vm0xZmVwWG0vRVVVQTdjdzFkNlVJWlRwRk5yY3FucDYvYkdKZmlC?=
 =?utf-8?B?WHJrbTllK0kzSG5OQVM1M0lMcjNweUJOdjNRV1lOVGxFank5M3U4SmdqeE9l?=
 =?utf-8?B?WlluWXppbkRGdEs2cmlXdHg0NS81SjFwM1AwdzhZSW9GVnBkcVJZTzNJUzIr?=
 =?utf-8?B?dHdyV1FIVUlOWWtrMGh4NFJJeGhwRldWZ3ErRnhINjdpRjBHN3VxaGF0b1ZP?=
 =?utf-8?B?L1lhZ1o0bzRSMGFpV3VyVDVaVCtBME9vSWlieU5KVU1xa29zN3hVYkp5YzNk?=
 =?utf-8?B?TUsvam1yWjZCOCtBOHBuc2xTbDYzdXZuREZSaHJMWjUzL2JmbmtSL2FCK3Yv?=
 =?utf-8?B?WkVod0d6WnhlbEY3RkxVcFFKc1RqUEFvdU1MbzNSZW5rbWdoODZkZkdqS2pC?=
 =?utf-8?B?Nk54Q1hoSURESENRSXQzbjZXNHJ3SGZVUFdnK1pKd29CMEUrUzVVc0MzRzN4?=
 =?utf-8?B?Mm85NUxNSjBKaTQ4eWVJQm42ZXN0cDRGT1VHNS9zajVucFhWOHU3MnMxdkZK?=
 =?utf-8?B?V2dsS1RHaVAvSnFuQnB0MlhYVFZKSVpkWnVVL2FQcjRLUVQ1aFY2SmJmRWdN?=
 =?utf-8?B?aXlzMktXK1kzR2tiZ1hncllzcEtRRlhnaGFVOWdGaVUvWHB6YUgwZ01ybXZW?=
 =?utf-8?B?RWpjeUxBckdEYTBMZTgwek1NM1ExTzBhcldLZmFxcFFtbHhOUDhmTG1ha2Np?=
 =?utf-8?B?eTlLdEJydjJUNDhsSFhEWVZLc1lld2pyQUs4TGFreFY0UjJvODBPT3VhZ1la?=
 =?utf-8?B?M1JOZ1h6Q2FCUnBYeGI3Tk4xQ2tqM0xSV2VXaWhmVTF1RkRDdFlCV3NDbUpR?=
 =?utf-8?B?aFVhbTdkbGZpd01QUWY4cVlkUnZrbzFSdFlCVWl2VnR6aXpLWmx5Qk1KK2lQ?=
 =?utf-8?Q?XA1A5SswVvSYkpdCrfXBK3Orx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b3b133-6bcb-4335-d1ad-08dd5ff6015f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 17:07:14.9855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FEhGQKqF69H0uuHedfJmugSepQQhmEpIgpO0G0XDwR6XLnz0DuZ/1OV9WHke7P1p/nvPvnRvmcADiHnzhnJk4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7445

Kevin,


On 3/5/2025 8:54 AM, Tian, Kevin wrote:
>> From: Vasant Hegde <vasant.hegde@amd.com>
>> Sent: Monday, March 3, 2025 7:42 PM
>>
>> Currently AMD driver enables device ATS and configures IOMMU DTE (per
>> device
>> setup) during attach_device() path. There was a discussion to move device
>> ATS
>> enablement to probe() path. We will move it to probe() path soon.
> 
> Based on discussion in this thread I'd expect doing it during
> attach is the long-term direction.

AMD does actual enablement of ATS per device (via DTE setting) in attach device
path. So I see this as default requirement. Of course some of policy enforcement
we can implement later.

May be we should document full flow in detail and make sure it takes care of all
HW requirements. Then decide when to do each part.

> 
>>
>>
>>>
>>> On the other hand, we may just define the knob as sats required or not.
>>> This is just a knob to let kernel know if the iommu driver needs to enable
>>> sats or not. While leave the ATS enabling policy unchanged. This means
>>> we need to probe the sats capability of iommu hw before creating the knob
>>> in sysfs.
>>
>> Right. Lets see if below flow covers all the requirement
>>   - Define new flags
>>     IOMMU_HWPT_FLAGS_SATS / IOMMU_HWPT_FLAGS_ATS
> 
> SATS policy should be managed by the sys admin, while ATS feature
> itself can be opted by the user.

"user" you mean like iommufd during domain allocation?

> 
>>
>>   - Enhance 'struct iommu_device' to include ATS flags (NO ATS, ATS, SECURE
>> ATS)
>>     iommu_device->ats_flag
> 
> as commented by Jason this needs to differentiate domain types,
> either due to hw lacking of support for certain types or the admin
> imposes different security levels across different types.

Right.

> 
>>
>>   - During probe() driver will update this field (similar to max_pasids)
>>     If (IOMMU needs Secure ATS always)
>> 	iommu_device->ats_flag = IOMMU_HWPT_FLAGS_SATS
>>     else if (device supports ATS and IOMMU supports Secure ATS)
>> 	iommu_device->ats_flag = IOMMU_HWPT_FLAGS_SATS |
>> IOMMU_HWPT_FLAGS_ATS
>>     else if (device supports ATS and IOMMU supports ATS)
>> 	iommu_device->ats_flag = IOMMU_HWPT_FLAGS_ATS
>>     else
>> 	iommu_device->ats_flag = <NO FLAGS> (May be have one more flag
>> IOMMU_HWPT_FLAGS_NO_ATS) ?
> 
> Here the device->ats_flag should be more an ats_policy thing? At
> probe time it's assigned with a default policy according to device
> type, platform requirement, etc. and later exposed via sysfs for
> admin opt.

Right. We can call it as ats_policy (expected/desired mode by HW driver).
So now core knows HW requirement. Also default and global policy enforcement
(via kernel command line).

During domain allocation, we can enforce required domain specific policy.


> 
> Actual ats enabling/enforcement is done at attach time, according
> to ats_policy.

Then during attach_dev() we pass those flags as argument?

> 
>>
>>
>>   - Based on default setting, kernel command line option and probe() data,
>> core
>> layer can adjust ATS capability. i. e.
>>      - If we have kernel command line (say iommu.ats=<x>), use that data for
>> all
>> ATS capable device.
>>      - If not, apply default
>>       untrusted device -> force secure ATS or no ats
>>       If HW needs Secure ATS always , enable Secure ATS
>>       For all other cases use ATS
> 
> this is an interesting one, i.e. whether we still want a global iommu
> option to enable sats for all applicable devices/domains. the pros
> is that it is simple and allows underlying driver to add sats support
> before a more flexible sysfs interface is ready. the downside is that
> it's unclear which device/domain types are affected by sats on
> different platforms w/o digging into the hw detail...

I preferred global option (that's why this patch added amd_iommu=sats) because
as you said its simple, can be enforced at global level. Also w/ sysfs interface
we have to update for each device/group indivisual. Another drawback is, w/
sysfs first we have to unbind the driver (which may not be possible always),
modify ATS setting, then bind driver again.

In Summary, I visualize it three level:
  - Default policy implemented in kernel
  - Global policy enforcement by admin via kernel command line
  - Per group/device level enforcement via sysfs

Do we need something for iommufd/vfio? Where user can tell desired mode while
allocating HWPT domains?

-Vasant







