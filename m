Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E41114AD23
	for <iommu@lists.linux.dev>; Thu, 23 May 2024 12:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716469146; cv=fail; b=A+bCrHpe3EXb68fbRYrmEBPAAqwtdS9rOFjYcnhmtrKpTye1lvdfGCnTztmGeEQPFFFddTZb/JKS7JJkFr2evvlFgZ1T5AFQrlqblqmd6EP73L5Z13G9sE+a3fv2krgoeGz0zjYdZxsZT7xaW0tYPUDleFJmD5iFMERe+5Nhwtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716469146; c=relaxed/simple;
	bh=os6ViHdPrv3GF4pCfp5VC1acPdyBPzJHl/VFnt9zdVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DLyARPj6axNXRNx0EZS5tQvzUFsoB9tDMUqgliyDLw8Cf2Plu9z5LPA/6gW+bM52mBBSzZBFf2spg8rAe09rkXo+UMWPo55md50OmDNzQkP5/e9+FVdp2hEVB//0SQocrHmXTiZFsyZLQFBneVcYf9OSZET3EO8F4SBjdsi2qd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l81PCqNl; arc=fail smtp.client-ip=40.107.236.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l81PCqNl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPiHNQO9Sd25OVFYtFYVR1M/Vs4R9dUt73MtmVtyBrWRgHiZNnMdGv+NFz7aXz28LEr3OxSH7rq1YkaJdHU9HJOJVa354vY9P4zZ/VaS3zGlENVG3BgMno/5v3YglFWUOdCKXaIgKWdMQNav3VYDc+Rmcx3pFbllIWpACDHqB7RezqtiGT82F6+6Yo+A15BZeFtCeG1GzmhKYMO7rVH8F8PmFfNuT7tD/f8IWrdMqFYhDolHWn8Tox0UhM2NZCavdn+NqQW3+ym1QG2v596K4MpL6tknWcnkGRW3hfWLhoBSwADeU3mM5c2tjtdYAKhJukcX4kh+4FPZ6/S9J/WZAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0oRz61xfoQGRM7VmJ9EOSEP8c6YFcRhI5RAEbTLmJN4=;
 b=Y5PK7L7fBxYrHupRwgbfR1OzyvO3cGaPehtXmT40yGX2SsvLfP6tXnfkTvwpEUyemnoGCz0g3xvEIcQH4adxnuPh6QynnydfHa+k/1qnU8Yy0WqbrYAdmBhTgINwB4eJOs7sNK689sP+3Ggu3VLrUr/O62ZJnewbrpu44YAkbTjV+xtRRy6AnptnMjPSgcl6QxxR8YSUqzwmPh7JTlFJE37lfGgc5aLEZbztCo13fjrfrWRfFDarbY/4CV+ihLzV66n3UbQxuNeeDPfP/jbZTGi1fEydQARnfuZlbsAMEQe7Qyjt63cWVeUJMbr1b9CyOZKq82HbedIpa1QEi+Br9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0oRz61xfoQGRM7VmJ9EOSEP8c6YFcRhI5RAEbTLmJN4=;
 b=l81PCqNlQsMFBPUfyeFmgF7RhJp49wbkZGTupA9/cdtZ6ZCN7r066DawZndcRJ9dmIPafILpsLVRm+EKrmX8kuza+IAoBwTWAobJx+DSMUIzG7A2/UY0vN6vRvdcRyrgq2e59+FH5MaWj2MyfIzJ+BK3Yjkp3i97pC+/fyREjPl2naQaHYVjQjcwadBcR7YcS8hbpuY1XNJtVDZ81p9+M4nj5u+P3dUkBNv1xbnhvM7yvF+eeyCbszUwAVmib8pvFvYicIqyhUJicpsecWsOv2M+qPcJSQE2o22Rwpz0Gf7doh/8aG15AJ5bXGuanwnERCgyqRaesnA54Ael8iIjJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by LV2PR12MB5942.namprd12.prod.outlook.com (2603:10b6:408:171::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20; Thu, 23 May
 2024 12:58:59 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 12:58:59 +0000
Date: Thu, 23 May 2024 09:58:56 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"jon.grimm@amd.com" <jon.grimm@amd.com>,
	"santosh.shukla@amd.com" <santosh.shukla@amd.com>,
	"Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH RFCv1 04/14] iommufd: Add struct iommufd_viommu and
 iommufd_viommu_ops
Message-ID: <20240523125856.GL20229@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <8610498e3fc00000e78bb9cef6fac9f6a54978a4.1712978212.git.nicolinc@nvidia.com>
 <ZkDMSfd9BXmsFfb+@nvidia.com>
 <ZkGKKoHnykAdGJq6@nvidia.com>
 <ZkOJgvMNFaZZ06OO@nvidia.com>
 <BN9PR11MB5276423A0BFBDA8346E1ED3C8CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240522133905.GX20229@nvidia.com>
 <BN9PR11MB5276267BB1CC4AA7008AFBFC8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN9PR11MB5276267BB1CC4AA7008AFBFC8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0293.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::28) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|LV2PR12MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: b1f481ec-1017-4c6c-2052-08dc7b281c8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEVpdW5kUXBrSUtXYzhxcUlSUHB3VldnSFNXWUluN0U4eGtzT0ZLa0hpNUly?=
 =?utf-8?B?UHBkVUQwMmhDY0EzWUhXWEltdE5keHZzZGZVUVJka2dPUW9wdU96UTdCRmhV?=
 =?utf-8?B?YUFQL3BCR0tvRllBclNWVlE0aXlJYTZYS3RtR2NnNkRsSnpBRWo2VXF3NVVK?=
 =?utf-8?B?bXZ3SjI0WFkyN3VIQzQxZWMyYlQ2N01aL3kxZ3g1UmxwbXA4TlUyYThBcEpC?=
 =?utf-8?B?ZnM3T1BZUFpDVHRBdGswWE1UeDgxWm9iS3czaGlxRE5ja2NSTHdBcDNmQkZE?=
 =?utf-8?B?UlZVTjQxcUpoOExuMzNFTTJEUEIwYnRlVWsyWk5DMHJGR2dZQW41b0svZWE0?=
 =?utf-8?B?TkRTaVJLaVBvK1pXYjIxYVVlNkxFRUZNVXU2KzFmNE45aUNQWE16MzNZYlJm?=
 =?utf-8?B?dUd6cEdHdmN6dnkvQXN5WlpjcnJQenRjNURvZTlIVlR1dWNEZG9BT2Fzbnhl?=
 =?utf-8?B?MXdpYkhiRkZiandZcnU5M1lhMDhGdFBqR3JiMUd5SlowdWpDU0xZeUxzd1Zm?=
 =?utf-8?B?VzNGTzMvTjg0SDRTelB6cGd1ZmptbnFsRU5pOHN1eUNMZGY5UjUzUGNudHBH?=
 =?utf-8?B?ZFAvaEtaUkZQVndiWGFqQzFTTnhIcVZVRmh3ODZhb1VnS3hlK05xd21FRisr?=
 =?utf-8?B?TzlLSzBrNjB1Qk5DZ2VTcEljTUFzUklJWGZWUnhFdCtJNnNDSHcxdHdCRHRY?=
 =?utf-8?B?ODdGc0dVK0VKTFZtdzZPVmE1c3oydWRFbWNMaFozK01IamJqNlMyUGZ4N3I2?=
 =?utf-8?B?YUdKZSswUmdpanBqWTBjOXE3aDJCSHAvb2NVOStNV2djTmoreXgvN1RIeTFD?=
 =?utf-8?B?QWExV3BOakhqZmN4RVhueTcrRjdsaGR6SDdzRGREekR3NStqVktybHF3UkVV?=
 =?utf-8?B?TDBpcUswY0VobGI0VlpCcUtPUldXcmF5SW9KNWlOMzdUMkJuNHplRHpzKzdO?=
 =?utf-8?B?czhOazZVUUY0T2F2VFc2NzdYZEl4UkxuVE9NZ3Z5V1BHV3FteFM3K3ZiaTZq?=
 =?utf-8?B?MmVxSzZUUk9DSyttanEyOXlsNWozZ0RQRW5ibFd6R0xzTmxrazVBMVorL2t1?=
 =?utf-8?B?ckxmUjdySzZXdkxtbVNiKytFaCtwS2pqM29yWDY4YW9NN042WUUzdjcvbWZm?=
 =?utf-8?B?aXNDaUxGbTB3YVdFdWx2bVM3aXpLTFh5ZzJFZG1WSGJWNFYxWEsrTU1sU0l3?=
 =?utf-8?B?clI3Z1paRGw2SGYxQXdCTmZlTGJBcXdaekRrQW9aUnAwQThuZHZONWRyNm5T?=
 =?utf-8?B?OEhpYWV1a0xUKy9INTFob1ZZVXNGaHZDSms4WnErYVBYcjlQTkJjSHVVNW4r?=
 =?utf-8?B?M0Q4QWFkcktZNzhlczIzQmtyWFlWdDdNb0NXdDRpMDBaQm9mdW9OaXRyVUx3?=
 =?utf-8?B?WHdlMGMzcjBsMUpHNUVYOU9IaDJ4QTJvTjliK0ZZZDREd015RDg1VVdKeVZH?=
 =?utf-8?B?TG5la2toekM5ekhnQnhZSHh0TmZjZ0ZzbFYrMHE2MnVEOGpIVXl5SmMzNTNX?=
 =?utf-8?B?TGNKaDNHSEJCeTlISzNUNlBCbyt3WUswb1E5NUx1d1NmOVovSkZ1Mld3RnRY?=
 =?utf-8?B?UXcyd1NRQ1lvQVVQMy9lYytwZVBQWGRxRElZMHNCNmxOWmRLS3h1LzJCNnI5?=
 =?utf-8?B?QVZsQTJENHRMQUpjbzhUQWdHVmRVV2JiLzlnYk5VMlY0MVJCT0w4OS9QOHpR?=
 =?utf-8?B?dWtvMEh1NVRVTk01L1NNT3RIOGtwbmhqeEZlSVZuSnpjRTB1MXladGFRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dllKaWttUy8rKzE2cHQ0TUY1bGUvQnFwdnpzWmdmSjdjQ01UNnpGSWk5Wm1E?=
 =?utf-8?B?MkhHWStKbFR1clNyN1JRV3B2K2Zzbkg2SmFCMkV3QXZzRlBVakdYbVpGM010?=
 =?utf-8?B?ZUVoYUdhYWFvV3FRMys5TW93dk1FRUUxZkwyN0c1Q1V3NHhqMFdqYTZJTWx3?=
 =?utf-8?B?blNLRHFpdldEQlViSGd6eFFSdHV6U3k3UHJxSmYzaW91T3hhRTY4K290SFRI?=
 =?utf-8?B?QU52d3pxVVJRRjBpem9ad3A4UUk2Ujc1RmIvb0RMQk5zbm5uRWl5RUZ3cmdw?=
 =?utf-8?B?UCt6MnZZclNHdGxwUEVJYmFoOE5malUzUE8yZ1Vrb3hIalpISHNmZllVS05X?=
 =?utf-8?B?RFJIcjNCVHBUeU1XWDgyanBKSEUxWkIwSzR1UTI0cHZNV1g5SW1ra1BiK1lw?=
 =?utf-8?B?M0J2dUtqR3JZblYrWFQ2M3dZMEVYejR1WjBtSStRbjhiQWVCeGZjazEwaXdE?=
 =?utf-8?B?UnhNUUZyRlJQd0hJUWFKTFFSamRLTGZOT29YVzYrVGgzWGRucTB4TEwvUG83?=
 =?utf-8?B?ajd0KzRLelJmZ3BkOGpnb2s1b2U0TExkaFRZMXpWcDgyMmhNL0oxcXM4Mk1v?=
 =?utf-8?B?L3VKSVlLWGtkMjFVRjE5bm04dzNWNWF2MHZLT0ovZ3M4OFBxT3hITm5tNTZN?=
 =?utf-8?B?SG40Q1pHdTBTeUZhNDF0THZ2Nkw0TGZYVUxTc05acUtiY0JoNEFTWFd4UkpM?=
 =?utf-8?B?ek1DWmJvNzRkTHUrRWFIc0JxZVlmZG1NeXV1dWVFQnZhdG9IYm1wdDc2c1Q1?=
 =?utf-8?B?dVdYdERxK2krdWVkSmlMMkh6dTZGUE1mQklZblRHQjdsaGVkaWowVHBIVm12?=
 =?utf-8?B?S0p4cnZ4Z1BUeit0YjViVVZWRk81dTdUYUVXM25KVHY2TVVQQlFmRm1zMkZT?=
 =?utf-8?B?REtGb1MyM2V4VWhib1JIOGNiTUdPL2ZCaXcyK0JPbFpDQjNFVWorTVE2R2Zq?=
 =?utf-8?B?cThIRnZXMEtJWnBXQzFLMFJLd080UlNFemNteEd5ZHFTZzk0N25DSE1ucEo3?=
 =?utf-8?B?RDNXaDB2eko2ZjNucDhEMmlVUXkyd2F0dGFMRXArd05CdXgyVXZ2bkV0WWJZ?=
 =?utf-8?B?SDNsTW45bjY4SHJjTDNuM3NoKytENG9OWEVXM3FsbGRsek5LcGNjQjc4czJJ?=
 =?utf-8?B?dEJNbEZkUHJwOUloRmE0S2c4YnlVOVFOWElsVU9WUXlEdW5KcUpGY2Q5TytD?=
 =?utf-8?B?TlJYbU9CbytMWDF1cTBscjFOMnhYbXVtQ3BsY1Q5QzE1d2VkaW9tSE5RSkJo?=
 =?utf-8?B?RDRyUzRtWVlvWXUrOWpOdnRWRTk1dWhPdkxSa2hFZUJuSnJ5RERCRk11UW1Z?=
 =?utf-8?B?eGNCajN1bEoxNXpQSjBobTQ1VGpISG5PUllXOVlhckJLckpYQlpITU5UbWNr?=
 =?utf-8?B?MEx6WkYyL0VtYk9wWW5uM3NIM2Jhc1ZaQTNLUkRqU2kxa2JHR3BaQWZRR2FI?=
 =?utf-8?B?aVRTaGJBMEJ1SGxYWGlPdVBoM2g2MmRGdFhwVENoL29LdHRrdllyZHk3ejl0?=
 =?utf-8?B?Z3M0Y2JCN3RrUjdEZnJiSkdBU2lWdEtENTRHSW15cHdJRlBiYUttbW5ibDZ2?=
 =?utf-8?B?dzlZY3dabElramF3bmx4WU5tNFJLWGxGNXhzYUt6b2pPeTY3Z0ZxNzYyVkhH?=
 =?utf-8?B?Uk83ZEVhMG14Umt3MEJQOURuRmlqMkRCS3BBMVdKc0FkaGpvV2FNMEVkbXFw?=
 =?utf-8?B?NTl0Z1Y5RlpLaDYzeklRcTFEYXdJZTJqbW5BTlY4SGhWM2RhQjUwTklzWGQr?=
 =?utf-8?B?SlRieWREWHdjNTRJUitRaFE4NDIyaXQ4Q1Z2cEcvRE1VNERxUlE3RzVpY1gw?=
 =?utf-8?B?bmpYSVJFa0s1ZTQvUlhiV0dWWjRKdncvZmVqbVB0d1FtdlRBYTE0Y1Zyd3Ey?=
 =?utf-8?B?bURXdnppOSt2SU5kM2tqU1ppYTRHSW1lOTBxeDc3RkMxL0FaQzlWUVZlRDNh?=
 =?utf-8?B?cTE3RUd2MDczckcwMXpoLzNZVnZ3bHMyTE16S29za05wVHkrc1lNZktUNTlz?=
 =?utf-8?B?elZtS2EvcFFUSkxqNlQ5OEVjR3FkbmdMaE9KYjV0KzZNaCthZEZ1bmVVWWRY?=
 =?utf-8?B?WG9CYzdUVjJIOFJ2clJYdEtoSmZoM2hpa2ovZXVKTEFwTkJ5eTFaODlOZ3Nv?=
 =?utf-8?Q?UPuE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f481ec-1017-4c6c-2052-08dc7b281c8f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 12:58:59.5644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z4D2+8hfBDVwt3EInoStsUptzb55/sIMp79nIQoS95ZCAtnFTs137HTTwO25O43h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5942

On Thu, May 23, 2024 at 01:43:45AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, May 22, 2024 9:39 PM
> > 
> > On Wed, May 22, 2024 at 08:58:34AM +0000, Tian, Kevin wrote:
> > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > Sent: Tuesday, May 14, 2024 11:56 PM
> > > >
> > > > > > So we need the S2 to exist before the VIOMMU is created, but the
> > > > > > drivers are going to need some more fixing before that will fully
> > > > > > work.
> > >
> > > Can you elaborate on this point? VIOMMU is a dummy container when
> > > it's created and the association to S2 comes relevant only until when
> > > VQUEUE is created inside and linked to a device?
> > 
> > VIOMMU contains:
> >  - A nesting parent
> >  - A KVM
> >  - Any global per-VM data the driver needs
> >    * In ARM case this is VMID, sometimes shared with KVM
> 
> In which case is it not shared with KVM? I had the impression that
> VMID always comes from KVM in this VCMDQ usage. 😊

Not quite, only vBTM needs it to be shared with KVM because the CPU
will forward the KVM VMID to the SMMU during invalidations.

Everything else in the nesting space (including vCMDQ) just needs the
VMID to be unique to the VM since it scopes the ASID that is stored in
guest table.s

For non-nesting cases (ie no viommu) the VMID can be unique to the S2.

> > On ARM the S2 is not divorced from the VIOMMU, ARM requires a single
> > VMID, shared with KVM, and localized to a single VM for some of the
> > bypass features (vBTM, vCMDQ). So to attach a S2 you actually have to
> > attach the VIOMMU to pick up the correct VMID.
> > 
> > I imagine something like this:
> >    hwpt_alloc(deva, nesting_parent=true) = shared_s2
> >    viommu_alloc(deva, shared_s2) = viommu1
> >    viommu_alloc(devb, shared_s2) = viommu2
> >    hwpt_alloc(deva, viommu1, vste) = deva_vste
> >    hwpt_alloc(devb, viommu2, vste) = devb_vste
> >    attach(deva, deva_vste)
> >    attach(devb, devb_vste)
> >    attach(devc, shared_s2)
> 
> I wonder whether we want to make viommu as the 1st-class citizen
> for any nested hwpt if it is desirable to enable it even for VT-d which
> lacks of a hw viommu concept at the moment.

I think we may as well code it like that, yes. It is easy to get the
S2 out of the viommu and feed that into the intel driver.

> > The driver will then know it should program three different VMIDs for
> > the same S2 page table, which matches the ARM expectation for
> > VMID. That is to say we'd pass in the viommu as the pt_id for the
> > iommu_hwpt_alloc. The viommu would imply both the S2 page table and
> > any meta information like VMID the driver needs.
> 
> Can you elaborate the aspect about "three different VMIDs"? 

In SMMUv3 the cache is tagged by (VMID,ASID) where ASID is completely
controlled by the guest.

Every time the guest observes a SMMUv3 instance it is allowed to
creates its own private ASID number space for that instance. The guest
could re-use ASID #1 on two instances.

So every SMMUv3 instance plugged into the guest needs to have its own
unique VMID so that the overlapping ASID's are disambiguate. The above
would create a VM where:

 deva -> vSMMUv3 #1
 devb -> vSMMUv3 #2
 devc -> No IOMMU

> tegra241_cmdqv_viommu_alloc()
> 	vintf->vmid = smmu_domain->vmid;

And same here the 'vintf' is processing ASIDs directly from the guest,
it needs to understand the VMID they are scoped under. Every vSMMUv3
instance in the guest must get a VMID, vintf, and vCMDQ all to its
own. The above needs revising in a viommu world.

> > Both AMD and the vCMDQ thing need to translate some PFNs through the
> > S2 and program them elsewhere, this is manually done by SW, and there
> > are three choices I guess:
> >  - Have the VMM do it and provide  void __user * to the driver
> 
> this sounds redundant to what S2 already provides

Yes, but we don't have to track invalidations here..

> >  - Have the driver do it through the S2 directly and track
> >    S2 invalidations
> 
> this makes more sense to me. Just like the driver already needs to track
> S2 invalidations to flush any nested cache related to the affected S2 range.

I'm a bit worried about 'track invalidations' though..
 
> >  - Have the driver open an access on the IOAS and use the access unmap
> 
> it requires adding more iommufd awareness into the iommu driver. I'm
> inclined to do it only at minimal necessity.

Yes, it is certainly annoying because of the modular/builtin problem.
 
> > Hmm, given we currently have no known hardware entanglement between
> > PRI and VIOMMU it does seem OK for PRI to just exist seperate for
> 
> Isn't AMD vPPRLog for directly sending PRI request into the guest?

I think it is, but that would be a vQUEUE on the VIOMMU not adding a
VIOMMU to Lu's patches, which is what I ment.

> > now. If someone needs them linked someday we can add a viommu_id to
> > the create pri queue command.
> 
> I'm more worried about the potential conflict between the vqueue
> object here and the fault queue object in Baolu's series, if we want
> to introduce vIOMMU concept to platforms which lack of the hw
> support.

I assume the vPPRLog will steal all the PRI before it reaches the
kernel, so once this is turned on Lu's path won't see anything.

I don't know if AMD can turn vPPRLog on individually or if it is a
whole package once they switch on VIOMMU..

Jason
