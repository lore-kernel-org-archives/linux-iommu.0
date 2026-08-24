Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011049.outbound.protection.outlook.com [40.93.194.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F278B466B1A
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 17:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787592336; cv=fail; b=WaVNo5mIn2KIyNwl5voNS92qNUYQ6cY0zksu96hn4pCdICovTWLxWs+bS6aRnPGWTOS7WFb9AHjWJks5brm+BtMTw+/fmfJ/4aPTxk8dNCnQ/OIXbtSvjDiYtWpqpjeJRNQIpEhSej+62MaG2XFkOwHNq01//FTSCFhL9kxbP+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787592336; c=relaxed/simple;
	bh=vK2Su5LwOsP1euYgsqiIEVwOSCLFmoLiyktKtH7QbB0=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=Fd4xMDnEB7PZ5zOXv6G+ROKqz/Lau48zH4ZeazIAgscZ79lOM/IHF6a46eSHUX+IKOncD+ibUCniyv0mC2AcwmaHIOVBvNdiYUrm2M43w/9qRO+Je2FU/MIDdvjBAiQzCwPKbvxjvVMk4jSEHvHYqAljDxJvx+N7g/5aoIevegs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EssMh6qA; arc=fail smtp.client-ip=40.93.194.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EssMh6qA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKoCsaf/KGqeFP+wbrLf0hwXv0sIRmF1iivFXesx63r8PRK0FObaG/LcrZw/URo5/eGSlPau+BwY58Mt1bWUQcFapFLDld2n6Z+rtfSclCuMyIecbdQnYsobu+RpUOoYbRFH2TzJIJ4SRd2aP6Pnyr9I3xK0rtWobSxNLDj1f8OQKrXWaRCCvkunQGmCADB7slG1TNBTQBM4zerM8P/MuEelf31LlHaLz6FWKTJgK4m85Uv+wGI1z/yoX5DF9gTUdGbjZencwUFa64GWPH+Y109QDV3K/uj4FlQJ6qVtt6qy0S1+LsqWhfeF0darS7lvPCWiwuCrcoFb/Y1A5a1iKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDiMfhnAqjufBe38BXJVQWNMV+pHZZRprhQabcMKv18=;
 b=cWMrc2tHCEL+OiF8THOztkIkU3P/VP1QU7SYernHCpJ7UzWEwnd9DJKC6VTS0SVh5yeGgB5pJXFrIKNXr0sJ+HpeAwOyQwAAS7wmftO+1qLV4SgQ3OzLUiHKXN54p0jPpe2d34p9djgg7b5xIgXzC3r1JrByGRKT2Y6JMRf14pYuwOdXC4RNLawwagwNNn1JRZCf37Z4DqLh6ceNLsEM4z3Bw63Nwjzx0IsMR7+ApUdmEpYUvDyBOdprTAsdKZ4NOgAqwwiEfZj19Zib+jMbNZf2BsuM/hRLvVDnbDW0HCWceLsJzCvFJOZ34suVs4uuUnW13Bpi97HIjWvdLzfLZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDiMfhnAqjufBe38BXJVQWNMV+pHZZRprhQabcMKv18=;
 b=EssMh6qAt5MVa+hlbNvlbNUuzgHXNNzy5tZqzKMaIn0ZWk3RTwj5KGYc8Wddxn21grnEpNerWZ4lNdIpNtDH5P7Sgb4kvcKPWHrAHpRu34CcpUqhIUTt3GRK4CUWMfXfGeiawz+XpAjWMCMv0+xmGtc2NLlXmYNC4kDu5MeIXWWeUduG/AZkq4ppt1DDE9+555kkjTWKZUEyvSG3kQgEmsqBrMZfaoUgpo7xf5QpNEa/I86GxWTXuvKilUHOr4JqwREyN081vL2lKdflCCxSaRYlKKPv85/CssN7ZsN83gWDSM3UTGclUAcWR+WLaiMTtT3ahtm332S1rHW6LMxR/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 17:25:11 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 17:25:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 10/24] iommu/amd: Pass iommu to device_flush_dte()
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org, 
 jgg@nvidia.com, yi.l.liu@intel.com, kevin.tian@intel.com, 
 nicolinc@nvidia.com, vasant.hegde@amd.com, jon.grimm@amd.com, 
 santosh.shukla@amd.com, Sairaj.K@amd.com, jay.chen@amd.com, wvw@google.com, 
 wnliu@google.com, dantuluris@google.com, chriscli@google.com, 
 kpsingh@google.com, alejandro.j.jimenez@oracle.com, 
 joao.m.martins@oracle.com
In-Reply-To: <20260727132913.22475-11-suravee.suthikulpanit@amd.com>
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-11-suravee.suthikulpanit@amd.com>
Date: Mon, 24 Aug 2026 14:24:56 -0300
Message-Id: <178759229633.3131778.3376863099875917252.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: MN2PR15CA0044.namprd15.prod.outlook.com
 (2603:10b6:208:237::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4302:EE_
X-MS-Office365-Filtering-Correlation-Id: ba6ca16e-9a12-48c2-3f7e-08df0204a51a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|23010399003|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zeBGeJ3BfNi7wlwry6FeI8UcoVFkK9avEDRTk6hAU2tbtGpJmaly0BYl8jGoV1sLJEbFt4MyUrsD55SUHYBAxnvmddQyQB4mHk73UFfMtXlATxfDNoLJSop8t9jefEJBGyc2re6d3oDtzPh2QSYzIJwBM+kfmmEG5sQ+LI4nDEBSEdQyaW6KCNJilT9nQ3D5rwisloXXH0bArjrlNoYVPkS2NQg7Pq17sQSU4yV1Eshh5rjmLopRECImgZyhn2/7GAuzRR1I2PUjhBZNa24sq7kPzyDHObUQhAXVqITvPmdtW+gzRfiBwxeYiTaBPWlepQW0qCC7v43TR7CtkI6cOdbgYKf6a7TnfDKV+wiKZBGMB4JQJ60+HD+RahpzQpp1JClNA/JaXXNkohtRWmDBRdcvwwxDjXpF8TpC4zXJJa1TuBtkluOayEYQCCir9uUC55FoEoyMDk3TgWF8YUj7TdHW2r5NPQnT7hsgz981xlpoBYyL2woZe2x+dqGIUNdOyJ57gdIJJToeVR+M2NZuAZ4SiIdj0AqjX9QTOpZzMO6uTU09tW+BT44kPWEI+dcMEPUmByq7Pgcb4EKxU4y0g5kuFV1Hsw5vhsO6CxObRHHajUK5bO3WCteg6td21X9f/E17Vhm8CIxq7YIr4bR/nGwmv6RujS5xMSaEEEWVRSM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(23010399003)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHNFSEVDRXdaaGIwR3pBUno0RTByRjFhNkh1Y3JINzM5NVAwbWhtbEJmUHlH?=
 =?utf-8?B?c3h0cm85TE4vbU8rNU5VVUxRZlhXS05KR3lRTUFyK2hSQkRCZGFLZWxXckgv?=
 =?utf-8?B?OFlOWDY4N21iaVVzSTVBd2p3aldxMTVpWmtNMVA1SFEraXdFeDVXQ3F0YWpo?=
 =?utf-8?B?UDJjcFdTb2JVaWxpTXRhY00yZFo4WDNLUlJaMGNoRVhWMEIya1lWS3dJS2RY?=
 =?utf-8?B?akZPdWc2bk12a1FGVFp6UTZVWThTaEtBWExNWURKS3lLQjZ2VUxRb2JDWVZQ?=
 =?utf-8?B?TE0rWTJTbmxPRm41N29zSHBuMDRIWWJJQVlYYngzbGlSaTVUbmFueWZVU3RQ?=
 =?utf-8?B?Z3ZGMHdibUswb3lvV01BZjZRT0xVY1lPa1g4czQ2SGVwQzg1a1BjK2FlV0Q4?=
 =?utf-8?B?ZmhGTXFnR3dhSzNkSlN1WnhQSmRuSm4xVUlrN1FPSUNWQ0ZzdjI0RllvTG4x?=
 =?utf-8?B?bG5Pd0EyQUhIYTVFczZmemZpaXFnYm1Tcm9QaTQ0eEJHRVhUWis3QWxsS2h3?=
 =?utf-8?B?YXBlRDRHN1BPQlJSczMrWVFPZVpab1FxUXFyMTcrOUU2amFMQVR0aUYyVXYx?=
 =?utf-8?B?aDVpWUJnWUI0cmh2RVgzempZRlR6emtkU1BLZFZUNm5MSWx4UUNjTitrZ2hK?=
 =?utf-8?B?U1QwMUlNV1Z1NU9VWFlmaCt3VUwrR0hDeW5tWUhUcU5zVmxjdjROQmwzU21F?=
 =?utf-8?B?S0E0b0k3MEMzZHRwcGg3QkJNa3Q5anNYa21ZOEFZaGliOUlQUUdHNjZ3UG9W?=
 =?utf-8?B?WnZWSHE5aDBCUWtsU1dyQlFORkhTckVETzhmWnR5VnViK0pTS3grcFpGY1g4?=
 =?utf-8?B?SForUDBjTGM2ZC9kUytiYzhjQUNMVWVEZ3pVcUdNWWpURlQ5VGZIeTZKcnBn?=
 =?utf-8?B?cU9CcEk2UHVabytkeFc4TGVrOGgvdnhLZWU1Tm14czZBTGZkYkJ6SWlubHpK?=
 =?utf-8?B?MnVrOFBJNkVZSXdvNjJmemtRdDFKdG5OamdSbWNqQmxMUTdYZ0RnQmlia29O?=
 =?utf-8?B?V1M0OGtFckpHSVJ3ZFViVFN3V1JTUXJqMVlEYVcrbC9WODRJYzRaWXVKQ2tV?=
 =?utf-8?B?cnl0cUZ4NnljclVSOUUycnVseEk1NjZJSk1XLzI1OUpZN0N4cHdhQnFpMFIy?=
 =?utf-8?B?ZnBGOW1zSzU3alJMV0EyL2I0ektjMFpKd1Q3KzNHOENPUUVNMnZQSi9MZWpO?=
 =?utf-8?B?TjI3S0dqUTZPakdvcVkyRnFFNkphZldtQndXUE4rMnpMUXJxOW4rbjhlRGd6?=
 =?utf-8?B?NnI2dldNMnBJWEhiWmN0UjRDK2tSTTN2L0w4Y2FhNldjVzZPWnJLYjZZb3N2?=
 =?utf-8?B?SEI3cGkrMjlmU0w2azRuTUNlcVhtQ0NLblkvYzN3b0xMa3lmVTA3RjJXM1M3?=
 =?utf-8?B?MnZGaWVscnMwc1RGT0lsdU1tbkRhNllVajB5amJLTHRzZ0picnI1cktyUDRk?=
 =?utf-8?B?UTFtTGtKbGhvRkVxQnlUWmpWc3NFQ3ZGbE5CU0NTK3o3NmZIUkVaekVYOWtB?=
 =?utf-8?B?N2NiRG5HTlVWSlk3TXEwN2lSeW5vNDRpNWcreVcwUnFHZkF0TjlNQzNQV0d2?=
 =?utf-8?B?VExQQWtDOHJQaFlvMnVOMG54a0tOTmwvTVBqeTNxK09Sa1Z5b0xwd2k4QTcr?=
 =?utf-8?B?bVhxVUp1Z3dNYm04OVdwY0FtTEtxWkdIanFlMys1cy83ZG50QlpzZmcrOUtX?=
 =?utf-8?B?WmpnQmN6My9jL1AveTdlVk4vd0t4eUt3dHZIWDdROHBlS1R4U1pVd3VWZUpC?=
 =?utf-8?B?dkNmL3pFaEpUWjFSWUV1YkNDa1g5Q04rOXRhYVZiV1lXaVpWZWZ3amVSb0Nt?=
 =?utf-8?B?cUpPd1Vqa2djT3NlY0U1WEdndU1IUXhCYmFWdEtGOTB6YmNuSnRLRlVXSFlL?=
 =?utf-8?B?SkwvT2dhZHJZcUJoV1BncTdkZjJ6ZVUxSVZ5M2NXNVBiUFVtQ2Q4UWZCa2lN?=
 =?utf-8?B?ZXEyeThkZzRDYWtwY1hNOEY1S3RORDhUS1FqSkpyS1BiOUM2VDZKU3NmdCtP?=
 =?utf-8?B?bHlzUkVYcjZEVzl0NGZvSnpFSzFXRGRCZDdhcU1tRkhWZkNmMmd6WE1zY3Z6?=
 =?utf-8?B?eS85QXA2TzhIb3huc3kzZlhLL1hBcW16SGdycnRscUhYaEJRUE9vamtwaE9J?=
 =?utf-8?B?Z0lNcU9tbk1qLy9NVnpDYyswT1RxOGZaUnAvOUh3Ums2dFVNMG54N090MXZx?=
 =?utf-8?B?clRHOVpZcjhCbnZXSHJpa0U4aytXOURYUm5xYk0xanY2VWx2Z0xaZDFsVVFv?=
 =?utf-8?B?aUpUblFLbk9xeXVwTURYckxIZEVscnJaOUF2a3NWRkdiSVAxamltNlF1OHU5?=
 =?utf-8?Q?neSrE8qFonbWymFKzu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba6ca16e-9a12-48c2-3f7e-08df0204a51a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 17:25:08.4833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQ4HTHZy6F9miXR2tPRxHjOgQW2oLYX4kK6Gpf3/D+j2MRXnBY1+fbrCDIUO4brN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302

On Mon, 27 Jul 2026 13:28:59 +0000, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com> wrote:
> Take struct amd_iommu explicitly so DTE invalidation is issued on the
> same IOMMU instance used to program the DTE. Also, flush each device in
> amd_iommu_change_top() immediately after updating its DTE.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
