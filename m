Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010031.outbound.protection.outlook.com [52.101.201.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B9B43B4B6
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 23:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787354161; cv=fail; b=pu9EC59pnM7IE3059YghEvbCZRrIT5CCATBtDPCJ9PE2wrXwzg4NnbkP1DwUoGUEdjBt6Gb7oH6kI4dErudXjWgZK4XFxZH5H9CUlHXjDfGgir2m4jqWyDWlxA6XgyCHOEV48ZB/VEPFVDT34aglpqGkv9xkdql1beqQKwAQ8gQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787354161; c=relaxed/simple;
	bh=6TxYeUH4fF9MAygbr+MQfi9vfAmlZsT7BHhG1xTHdmo=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=Y9ZSr7jpgAEsEgq4aF12OOloapURMnmbTtYawJNOA0fMOqMZQy3qx4ihek7FiofjhpyfBZX2DqYo0fg/fy3ODDz6hhnxBioRF59ktb74WFkivNF4aYd9+bL0FsFlV97GeEBodEITaznn/ne9Iu1GwEDoJkDvQ5Z2Gvex96CJQAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VSim3kAA; arc=fail smtp.client-ip=52.101.201.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VSim3kAA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eP8X/j9R8yqOK5A4gR3NrLPcx0vetWX7S/YaT7lNMfy3Ocom94AXPiB5mGI7IHtB9rTH492Rd6Nq8jPZeZ+ILZGmCUg5+5Ga4om3SQoqUW+M3KyHgi6WhauJZCUh8jgcN6YsOT2DMds3wNNg7Uw8lPglS7qGoCmuLooyksbf9fakm/TCNistFFuSfA+6RWShK5GcagnNnINpUFD6ENOHYakm7CgT9R25jgr8yjiVOdfL7/yvYCPaqDDG1v5UosEi3o98MBS657V51ok4vV02I367+98fsJIe7kMYubkdnDSd5ydR4pF48Psc9UTNO53siRD3dK2fQI00FFgz+V+0kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QqSSUBH2udm6E2uvHuxTSSTpFvBAjqFIn9RutFpi3vo=;
 b=CWhTNdbZhcLoqUrFJHoAXUOxBHoYlqct3S/48a7sP3FwtEjCvxU2vMKfKRqWMcjm+amAjfeFR37LIjckOm/Sp4ZILwidYhbMvaFYytQZzYH3NTcUn/1QNOQNqGTmhJRNcekdwT/VVtWWZbEx3jQaTFcRCB0RVYi1ptRVGLwOD27aKAOIC2IlynN/6QEBlLqZYdzsXxgsznMcwoQlNLRxiO5ygSRkIgAdGUJUkuja5rb6CTwidhKOzPPZsGdziKLKBBFtUMIscXNBDBSGEjFrvwDL0fLw7xHMRbhCTaLC3UB+DfKvgnnzkEe4zudAuMRHbpvPaKkdO9c8jfx6HVyHKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqSSUBH2udm6E2uvHuxTSSTpFvBAjqFIn9RutFpi3vo=;
 b=VSim3kAAN4O8QzdhyXkFRHfnq4S5cgwHcBJzyCdrBjXtNKUEQCbjwqgC1F5hFHnFfAD4qQFnVri6hBtENbFYxX2B/m4tOvYuvVB4xku3M5IdpoC81f+zx7C6lMCnx1VEwS458IRN16DM6wLxrhtZr9MvhM4fun5PDN0GXgj8ZkX07qrB/vz2N40w3Z9xXnZgRvi9FzyZaNbF1RuxGESCIbk+4aiPgoPbJA+7gk6i/9Fa82zACojnDBfGdtpDck7/sTc7AQPSjQdGV/JE4N72pu/z9fRsrzuY0UFw49aqdrMPCYheHrz6OCTLQyydIwig4BAeUwERMqT4TZJw87RPPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BL3PR12MB6402.namprd12.prod.outlook.com (2603:10b6:208:3b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 23:15:35 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 23:15:35 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v9 12/12] iommu/arm-smmu-v3: Detect
 ARM_SMMU_OPT_KDUMP_ADOPT in probe()
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org, 
 praan@google.com, kevin.tian@intel.com, smostafa@google.com, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, jamien@nvidia.com
In-Reply-To: <629e0eeb1dac857bce3ebcf027938888ab95483f.1784663184.git.nicolinc@nvidia.com>
References: <cover.1784663183.git.nicolinc@nvidia.com>
 <629e0eeb1dac857bce3ebcf027938888ab95483f.1784663184.git.nicolinc@nvidia.com>
Date: Fri, 21 Aug 2026 20:15:26 -0300
Message-Id: <178735412604.18212.40717823049657257.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT3PR01CA0115.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::26) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BL3PR12MB6402:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b4ea59f-8436-4c4d-259a-08deffda1950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|56012099006|10067099003|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	2xK4KFSEvvTMJqV8lamUBzOHYO/8HmwpqZ0S9axy8kuqFwFdS+HRrRWvVT4FvWl0n9PAyY/yn1g2kEP20X6y5xxUg6r7sDmNCE6lgTD7WzRx+KWQ9z9foOqFEeZHvo17X/dupT6e/G+BVXkObFGPvj1YSRagrn/pJbhwvo43jHf9m3YyoVsqwjVa3GFhzUhrjgndiLlssuBM2Tlh/I9fOT2ERE9nN84RznYtj9iqzyJdHeuaWmbJYnGh4nHFrWrXkXAKIH+Pz2tljCn4lEXcWYvx64U+vEW69ZyxAgaibJYiI+tI8HjFkc3GomPbfG++Axr03QZKUyiu4T5kjXQDjJlUGtA9qpUu9eTgCwi0H2W5TvSN5j0cOYBtv69dzu3Dbgr6YJzIEF13IqHIWxNZcc0e2TeJ5Vg6y2rxjWZBTq51aMkoiItA0QSh+NfchV8ub0VUkvyAO94BT9b8dlB8DtfZuIMqlbW5ZdQrW9T2RrqVyOFtcyQFe4dD1pzLcfVb8pE2shmpbuE70dAzK/FWEvkI7o+SyR+r8rtq4vwV+ZI3MIAIWK2mfB6DtIYBo0/Doa5Uq5wLvdAByfmxUV8MNc6qoqP3E9229NmlLnBFp4V5Q/qT6ffDnK4HdTMG1OeeuZADxXgz5kdN4fPxUBOuOuzUvOd9jj1+O/ur/tUSRFI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkEzaDlpTVg3K2EwbVJhY2psclNwTHJBYUJRSG1FSGkvTEdXRWdDR1Vkd3Ji?=
 =?utf-8?B?am5MK0pPQjRxVVZPVkNBaERQRndNeWRsQmI3QjROSC9makNLMGVETnhvUmRV?=
 =?utf-8?B?NFcwbml6SVFHN0h1dGNsQjRqd2RPUGgzc21XNjFwcGNsR0lqenpKcFoxaDRo?=
 =?utf-8?B?RVlTMlp4ZTVFQVg3UFQ1T2xrUFg1Q2ZOUGVhakt3SFRVUEpCT0d5c2tsaENZ?=
 =?utf-8?B?THY5RUhUd1VRbnpHOUhaZGM0NXNQaE5LaGdYWXRJcjlXa1p3aU4yZVcwdEpM?=
 =?utf-8?B?YlhIZnZkdWEyZXAyNWc3TjQwRXVmTWhwMm5zbFlqQk9yT3IwNlJiWDIrbEcw?=
 =?utf-8?B?TEhvS0c1OGdOc3RKNXZaWkM3TDR3UCtPTk84OGxTeTlocTk4aWM3QTRMQjNk?=
 =?utf-8?B?Qy9QbkxzS1J6bVJDMWJmWUlSRnRjRHJSS3liMkVxQU5kT0FGK040N3BDSUFP?=
 =?utf-8?B?bW5ieCtvei9IdjloSVhZV3dZWWdQL21WdVQvcGMySzZKWVdLMGpOYm8yTlhh?=
 =?utf-8?B?S2ozNkV5T0tNUjNJRUFSRGNuZEdxT0JlRTdwczc2MEUyMFBVVVl1SC9RWkJa?=
 =?utf-8?B?M3E2R2lydklPYTJ0dTU3d2o1aXlZZkRkM1dDTTdoMVFEb0lUTFdxcGNJN1FJ?=
 =?utf-8?B?L2tmSXRFVS91eTVITklvcjBRTFV2Y1JpTmpYT2tiNFRNd2FDS1pBVW5SSmZC?=
 =?utf-8?B?YURkMTZHQk95QVZ3aGEwcVFnUnRLcWxLeEtBUk5MRmJFaW5PT2FuWDVoZDA1?=
 =?utf-8?B?b1lISnVwRzdCdHdmUnhIaHVaOHNYbDhPREszU2JicjdKUFVPdmJ4Z2d0bS9m?=
 =?utf-8?B?aGhoRUFpYXhlRnd6TnJMZWhLMUx5c1ZvVm9ZRkJNcEpoclZiMmJValZNUEhp?=
 =?utf-8?B?bWJhNDFJQ1pHL0wyaWRScEkwMEVuZ3F1cElkcFBmT2VvU05wNVhjTUJMeGpm?=
 =?utf-8?B?SFpGcUE2VXdPR0ZaMVRJR1o5OGRGNk9HcGkzODJiaHlnV3JzMmNKL1FhZ3Uz?=
 =?utf-8?B?UFIrcDY2dEhJYTVEM050SkMwanVzdVY5Sy9mRjZncFRQOEFRZStuQlJZYlN0?=
 =?utf-8?B?YVozUnRCUENXaW5idTdvd3lBK2FGcTl3LzJjWGVVRWJnaWE4RWJnYUhhUVA4?=
 =?utf-8?B?aGQ1bjdTTEFkc0JjcXRSVEUzbS9GY0RrcE5GZGw2RlA5U1dIeGFkTE16R0JF?=
 =?utf-8?B?cUJjczE0NmRsVG45YVF6aytVZUxqQzA5Y2VVVFhKQzJLV2xuYlVIN3krZVpO?=
 =?utf-8?B?MDRGWExMYmRjaWlSYzFPUHJ0L1RHbDNRMVRFMU9IRnlSSlN1MVg2Yy92dFBU?=
 =?utf-8?B?L21tZGg5bHFTN2F0K3Y3aGNuRUZ0MXI1UURzRDN4c0E4WW04dFk3dEtDQzhk?=
 =?utf-8?B?MHdMajYyV2VXY21tU21GRGRWOEVDd1kyUTRma1NTYk5PQXkxejRIQ1dCUVoz?=
 =?utf-8?B?ZlliU1hTNU43YWF4WVkybHd5WlNNZlFaV2NNRzJzejN1Uk55aVJuMkxsNjBJ?=
 =?utf-8?B?N2pzWEVweVQyMDd4dzdpYkxzWG5xM1BxaXRuM1l6Q0VpRThOOWpoeW8zMHhG?=
 =?utf-8?B?ZHYxTnYwSk1JUHJWZ2FacXp3amRhVFlYcUJ5aG5BSFFjMzlDdTZBTE5jQjJy?=
 =?utf-8?B?RHU3Z3NDNEh3SGFMNEFtd1lmdjF6TnZIMTcvc011ZElPQjdwQmJvOEFRd2wy?=
 =?utf-8?B?clA3RUZyOWwzQ2NnQWxxdU9SU3dmaThJcTRQZVJyMGJNZUFZenM2NVlkOXFY?=
 =?utf-8?B?MDZNQ3ZGMng5MnVaVERBVW5USkQyUTB5d1p4RkczbnJRNjV3OG1rOVBaTklr?=
 =?utf-8?B?eHF5b1hLNzl1N2hETXZxTWppUHpzbjNEMWIvVXZPbXBPZDd2Q21yQWxXTUEr?=
 =?utf-8?B?cms2UVR0UHRpZ3ZxNWdTTHkvREgrODdJTW5vNlh3WTgvM2ZvUWIvTURvU0Fj?=
 =?utf-8?B?TktnMEYxbTdGYTlFVkViMmUwcEVRenJKSUIvK3VkdDdxOXJPVTFLSkZBdno3?=
 =?utf-8?B?WjlRbFczdUcwTUNKb0s4Z3VjMi9VMHVQN3RyZ2xnQUd4Ly9HNW1OV2pnQ0x5?=
 =?utf-8?B?RzdOZWwwS1hTakkzKzNjUlBRclNmRHl4Q3hxajFxME1jQW93OHB0OXZIUDdZ?=
 =?utf-8?B?YnI5eGtJTnFQQUk1cVEzU2pCRCtkeUJsNnhTY2JPZUZncTB3M2lxcVVNamY5?=
 =?utf-8?B?cjMzK29CRjM0bG9IbTZHaWJqajZEcG51UkhMUW96S09Wcy95eFJMc1FMUk90?=
 =?utf-8?B?K0o0ZHNoZ29kVkpTbjQwZDZtYUhKMUQvemxBL0VyS29RNG5kRFd0RkZveHZ5?=
 =?utf-8?Q?1FxrYWWRioJ8zHm69F?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4ea59f-8436-4c4d-259a-08deffda1950
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 23:15:32.7496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +xqgwF+Z3G0ZiS2NxAHzVTaZdholnxO/SbeTHD3LJ1EE0cF9Gp5mRFEPxCiccbVf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6402

On Tue, 21 Jul 2026 14:38:39 -0700, Nicolin Chen <nicolinc@nvidia.com> wrote:
> arm_smmu_device_hw_probe() runs before arm_smmu_init_structures(), so it's
> natural to decide whether the kdump kernel must adopt the crashed kernel's
> stream table.
> 
> Given that memremap is used to adopt the old stream table, set this option
> only on a coherent SMMU.
> 
> [...]

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
