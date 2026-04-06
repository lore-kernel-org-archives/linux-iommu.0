Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012017.outbound.protection.outlook.com [40.93.195.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B17721B9DA
	for <iommu@lists.linux.dev>; Mon,  6 Apr 2026 03:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775447383; cv=fail; b=PoiporYCB/KqgOv7wq42ofds/tVekDQkemAZzdRocfp+bqsLCu3Q6Vvxsmk7ul65p+9QuNYDc3/Lt2d9RLnQTaAQVO7D+qu4Z117Fnmg9rBgdwU518j20v6/QbwGFi1dWSjsJyPVrIwi2/L+uBxq21ZgSeVGin1qSCHOlTkx9mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775447383; c=relaxed/simple;
	bh=GxAwHbmMqUdY2stRwECrKy/Hj0Qup965o2Zc8AI/+FE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zrhg/9s8hiJ1snw64TkA3PeVwrWo32+WpOw7pLUcUPPKoQiCrroPUC20lY+qMyH1N3G9gD3qz4ugx149ym9z8M4BM0n2bHgtNWvuB8mUZ0tS20RBMVAg5PtJy4VdQiwurovznOBvPGCvHUo1UJMNOy4DVSRlZUuYzY/kj1oUSao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s2ZQ8jIy; arc=fail smtp.client-ip=40.93.195.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s2ZQ8jIy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MEzYeTcpPmx5lPuzBcALJv4p/KAMoF67gQzSY9dWRHbGNoh4XdDzJziAtQB+xMJH1YdelxoM+mrdV0qPx/2vwx4xmE7z6mMAuVX2YrLOyqugCpC+bVoPfg0IsS2iwCDJ3IiEti2UoBJl/rP8p7pOB2SntdDy8EQ11/YaiIb88+N/J503588LBFWs9CN1Jt151MbZWKmJpiHK+HWGPrmD2ki3LDhtDBSwpPVCNOYAiiIeV1chEXODWAytL5eWyn/yw9r//D28gHgoNSn26Xr//m6xqvO3WX61Hw6bHJmYXiuarmiL59mLvKaOg0kTjTnbEQqSVjAm98VpenEQhBCgJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzt+dvTDpxoKdNdlwC/hoIW98b87z+SugEM1W8KP8Bw=;
 b=cSx+5gDZjLakYOQ1ERjVgf73omyX0co7J9OtfwKSIcFr95Ze+KP7lTdbIxa5eCbUsR/EJsIjH8mpPLAZXiOiLYhmBnW4ab2ZweIM3qeTiSRkgfsdaBBZwEpX3FdHM6QFyZEqi/ZwwHZxxBh+unX381MbO+mSSKJFMbsS/sCQlFu37fFuMn6LGrKCSTIbt3wZeDumF8DMxGnelNAXVg1qvtgc+bm4L0La+q9h258Q9lWlkuqH3z3ZJn/w/B65/kKKpSpvf++zWcAPMmT9DuqkXrUp4dWE8BrZA7tit8bWqBlZiLfTZIpBYGMiw1EEAPwMudIu+InB4Gv1mq6nGJKbdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzt+dvTDpxoKdNdlwC/hoIW98b87z+SugEM1W8KP8Bw=;
 b=s2ZQ8jIyGzkRafsba2MJLr6Dqn5y7Bzoh/4gVYXGwIj8/eTXc6Q/oMIZUpn30PyMdQXNAFeVq+q2agaRFZ2KR8erNaALFGuM6WVSruGCznB5BrhJ5g7lxjg7pWainBw6fPxW127SD5Z0YucFeR3CCVX2xWGTEWvGxRRKjp1sBjA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 LV3PR12MB9213.namprd12.prod.outlook.com (2603:10b6:408:1a6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Mon, 6 Apr
 2026 03:49:39 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b5e5:12ea:9815:b7d4]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b5e5:12ea:9815:b7d4%7]) with mapi id 15.20.9769.018; Mon, 6 Apr 2026
 03:49:39 +0000
Message-ID: <c43ffa6a-d535-4a0f-ae3e-88fd2c49b36b@amd.com>
Date: Mon, 6 Apr 2026 10:49:29 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/22] iommu/amd: Introduce helper function for updating
 domain ID mapping table
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
 wnliu@google.com, dantuluris@google.com, chriscli@google.com,
 kpsingh@google.com
References: <20260330084206.9251-1-suravee.suthikulpanit@amd.com>
 <20260330084206.9251-16-suravee.suthikulpanit@amd.com>
 <20260330121701.GF310919@nvidia.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20260330121701.GF310919@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0029.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::16) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|LV3PR12MB9213:EE_
X-MS-Office365-Filtering-Correlation-Id: 42244934-62d7-455a-14bc-08de938f8757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	4gXSrXdFbZHkVnIIE4varf/3911+J9vUpWrwVKm76XictbMH3dulYer/gqkevs37iHIeQrFY5XKGFP5Zr3QVFmH5MgQwVuoPR8YxMrcy82gsg20IlSutl9XQ6cZPDVj9wgM2eSXA/KGXyXRmJ7U8kjA2BkRQep7te9eUUNl/u00eDey+NuvxNOuXvMqfDoEbfwuD7Tw5BvP3sWA2HMj/dHKR3Z2MIRl0zwdBwhNbcnihMq3bWitGrZOBKcY8yqMO+Y2/Yt9QqeotjhzYOgdRLCMchak1RJaxgG7UJJKIfG7NN4SDrcBbQHzFaKxYC+KhbnOxvCcHEAHQHeaS7UX6y6kFSuSGn1bw79u2OwAFrDFc9kt8z/rZMecFMZHzkBeBM+gLkDDIGzIvGcKIXKfXJtlN9Iqqb4yeaKLW1j0upoH5vsp5lOh+V9S2Q17QiqgZO/d592dY7x6JcEsR/0kGlLNyjROVW9OpqVwCl/pWomKeBOBTFXQhYKIR2fjulpVY5yFVddusgk7vGe4cAW8E2eFHUDbTEoZlQORyWlTzp4zSBeA7Q1EqUfoxECd4MuMJeCpZD4QfARtvhzAdgq53k+xZPCZLJ+P8/mhX36tJt07o6BS7FEMcPMtR0EM0e4Uqy/Cwsd420Ow09PidKpLTku3wZ0Vz8EG2pUipfFd85R4s9RU0M0gDXfTv3l3apnYqw+AOOeOmpZ8NquQ5Ypg6t3X0rTxC/6D6pvRkB5DdbUk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YU9GU3krelgxZVJSditZWHpzQVJGMW9EbkVXYklhditIZ1E4dERtYVBCbmtI?=
 =?utf-8?B?eWErdmxHSnYvODNUekM0TG44OGhwT0FsNE44UTdWYWNpTDBRUUtKK0JrMUhO?=
 =?utf-8?B?MElFN2ZLWnFVSW9lcUkrei9kczNWOFUzd2VKcitGK0w4Y3JmYU5sRDhLQnIz?=
 =?utf-8?B?dFhlbzhvK2xJTUlEbjRFcGtGQU52YWhRc3VoK2gxaTBzaG5wOUxMNFBLblZv?=
 =?utf-8?B?WW95OC9pNENrSk4zdFB5UmI1bEMxQ0Z3enZkaEYxVVBtOTJ0OVNtb1VhMkxk?=
 =?utf-8?B?anN2MHVjZGYveVNlRndZWWM4WUJ1ZkN2YW5wZjRpcTdiYjRSZllqWlErS1Nk?=
 =?utf-8?B?YWE2eG5LTExjK1ZpY3RhWXIzSjROTTlDKzk0ZUlwWjBDQjJPazFDSUFiZ0JV?=
 =?utf-8?B?NnZnNHJEMHBhc1BBbldibEFTaDcwQ0hrcHJKYWszZFgyQmpUbW9wNmtMQ1VD?=
 =?utf-8?B?Y3BaYmNnMEVJQTAxaGI2Yzh0VkJjR3NHVkdRSDdlOGxVU29kY0Z3S3E2aTZw?=
 =?utf-8?B?ZzB3Z3EvRC9VSGEzR3BaNjBOeGNNdkx5MXZWeUNzOGNZNmJmalJLR0VLU21q?=
 =?utf-8?B?OE9YRytMa1pxa2N4eE94aDhZV0VzSWs2YnlueWNBT1VLWmlsSjRKcFMzYnRK?=
 =?utf-8?B?QWtXMk1BL0NrWnRWdElKTkVzMzI3M0ZUcmpKYnlxSExrYnRrVzJrY2ExdmJ0?=
 =?utf-8?B?cFRhVFlNdnQ5bzl1WFlSQXoyT1QxV2haRVEweWNXV3Z3alVrU0NlQnRzMEU0?=
 =?utf-8?B?SkNXNGhoS1hmM25DNStDMlFpSUFPdHVRQlQwR3hYd2Q3WnExSWFJcDd5OVhz?=
 =?utf-8?B?ODJ6YlhlMTVaYitlVWNvcHhaRjVXcHhsSXJWRk9oVzVPeEVrWUxJOEIyU3F4?=
 =?utf-8?B?bWNvZnpaTVNBd2FrSDBiWWIvRlJ6SGZ5b0ZrMUVzQStiVUEwc0hXbTRKckVK?=
 =?utf-8?B?enQvbUU0L2E5UEFDckJpaEhVVVBxK2NaTlg0S0kvRWk4OUxoeE1XTlo4V2FL?=
 =?utf-8?B?dzB4dFVuMlpUWVppd2M1Y2cvSXU1UUhsMmFnNG9pRTRlWitJL0o1VCttTEdT?=
 =?utf-8?B?ZFp1cDRHNk15WFJHcFRraGJzK1pmUkVnU3F0VzBpSE1QUDVubDJmT1Q4UTdS?=
 =?utf-8?B?TFB4SnVTRkovb3FZK1NSMnBSR041aFZoZjZUZ2I0MXJvTjVrOTJKRVpscDdh?=
 =?utf-8?B?cWszcFpodEpjSDF1MEFzNlIyQ0UzRWJaNUU3ZlphbE1hS2VIZUc4bUhkZmZT?=
 =?utf-8?B?SnNEbUxDckF4Y1VCQmRPK1QzbjgwT1JFNHZTN25VMVhkT1ZER3V3UDFXNmJM?=
 =?utf-8?B?Y1E4K2t1dzV1WlZzK0xwRzdQdWdiRHlXNlQzdkFscTZEdWJMc1hJWHN0aWV1?=
 =?utf-8?B?ZGhYQURFclk5MVFLRkNNcnR3OVViaUdGcUY3RHQ0Y0t3MzhFd01RemZrR1pQ?=
 =?utf-8?B?aVFwcEZ5MVMxTU0vSGNjMUp1K2tSZ0JkVHE4Kzc1NlpOMU9MV1o5WkErMHFU?=
 =?utf-8?B?Y1p5c2lRRk02WXZyMndvd3RPL2NBWG1MZXZ1MThtRjRVTThGOTdlUXNFZWJL?=
 =?utf-8?B?WWNWQW1CczN4ZG9vWHlGR0ZYMWhYV0tGeWZyTXFQNi9GaEozckNLUjBqbEJR?=
 =?utf-8?B?Nk1oK3JuRElGeGJoelVEUlhmeE0xWW1mS1pSV0V6RVB4TlRmRTE0UWppVWVi?=
 =?utf-8?B?SXpGVWg1NWZQTFNuOUhxSGZjRGtvRXgzSUxocnhyVzk5Z3RiWUo2OU1CWUpp?=
 =?utf-8?B?U0xPTjBIQXZjcURYam5Zc2FmWFpXREhMeEtKMFBlYzNkMDhZMzNBbEpOb214?=
 =?utf-8?B?MjFrMVVnY0N4aGNOSHUyZjJjazJ0Y3JDTVROUW1HZ2NXZkVwaTZtZkYxeWR4?=
 =?utf-8?B?UmhKR3ZMWUJrZHJjUUF6NFFJcXdvTWRYU29pTUdoRXVJc2VyZ1RsejJ6T2NW?=
 =?utf-8?B?WXJQV0loa3hSTHpTbzhpbTdkTEhEOE1Bbk5kQWQ2ejJtSEpDL2dVS01mWGdW?=
 =?utf-8?B?S3BKNi9wN1cveHdvT2huS09PTGwwUHN4VUdreGxHbXNPeXJUbWlpWHdWdllE?=
 =?utf-8?B?bUJiOGtVY1FLK253UTBia3h4Q0pkZHpmWWJGTm83U0kzbTRORFZVbWJlaUZj?=
 =?utf-8?B?c3JFWkJCeGdLZGg1S3FET25zd2dBNEQrczAzYzlpZWpzTG5QSy9YVFNNckVB?=
 =?utf-8?B?ZDFhMjJuRkxCK3JROTRTTEZUdGxoZDc4b0xTc1Q1OG5EME44ZTRQM3A2bUtD?=
 =?utf-8?B?eDYrYVBGMnhGQWlPZkh0a0FjUDdEY0tFaEFraHVGaXRHZVcwaGlSZ1M3d0dV?=
 =?utf-8?B?VWJ2NHRVV2ZOZ2dyOGMyTVFjeGJ6UnZDZEtaTFMvNHoreUhodDNuUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42244934-62d7-455a-14bc-08de938f8757
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 03:49:39.6753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2KyzHKyhGvNNNM6azSsYZpvjU/uM1pYE68Puuzow7LmeF8ep+6I2CJ7NlZDxCOT1if6bXRXHh2Np/f+IIJTcGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9213



On 3/30/2026 7:17 PM, Jason Gunthorpe wrote:
> On Mon, Mar 30, 2026 at 08:41:59AM +0000, Suravee Suthikulpanit wrote:
>> +int amd_viommu_domain_id_update(struct amd_iommu *iommu, u16 gid,
>> +				u16 hdom_id, u16 gdom_id)
>> +{
>> +	u64 val, tmp1, tmp2;
>> +	u8 __iomem *vfctrl = VIOMMU_VFCTRL_MMIO_BASE(iommu, gid);
>> +
>> +	tmp1 = gdom_id;
>> +	tmp1 = ((tmp1 & 0xFFFFULL) << 46);
>> +	tmp2 = hdom_id;
>> +	tmp2 = ((tmp2 & 0xFFFFULL) << 14);
>> +	val = tmp1 | tmp2 | 0x8000000000000001UL;
>> +	writeq(val, vfctrl + VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL1_OFFSET);
> 
> Use genmask and field prep. Check all the patches for stuff like this
> and fix it.

Got it. I missed this one.

Thanks,
Suravee
