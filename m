Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2052.outbound.protection.outlook.com [40.107.96.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B481B299
	for <iommu@lists.linux.dev>; Mon, 25 Sep 2023 15:57:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ar2Uk6ixVd0S2UUByovF36yRHSNgXdp8iPeRMVIMM3hK6+AZCKr+HDY/BfOAcD4aZNrLElbsdcaceVN/Bro8X96qpreF+jbczyaHvmsG0ikzsog/dS/rU3+C04q23P8FthzS6na4t1Cj9OeT3j8HGJU5mbeA53kh+AwKJj9evse9L0vQRJCphonGpk3OnukM3+GNfx4l7CHYyHHWXMwkifwdKDudf5MV+V9bt43ICtRJbonl45Lv0ailvlz0z33A3TEBx9gjDiZAh6F6jeb8YhuJXjiZSn4+nN7734+I4f2SJAuYLoA5lqT8Fa7FrZFA/qnpzq8lPAeWOjDykVVKjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5UwjJO9AaviWf7vKa5ho0jS5TuMT+tvQyq+8GDfE4E=;
 b=FLPTxLkkSavLJXBruDgJlLqrLxHAuC5EaDvw7LyUSvhuOwzj6LWG158WhJJDcYrZcJNOD8VkThqRN2JoaTE/0ht3izPwGEZ6KVw7n1Kezs9dcwbxbDOOjsN2DVDcf9LRs9buQeC/J9Bf14P0X9Ib/DG5x/N764yq/uikQUwe+fcGcUGRTy1JkLbe+EBj8bifOP1T4tyAYQBZtLGbdAw3E1KNqb/Pu+UwFTtusUnZQdlFVyEVvOxer0fTBYhSNaf547+OYUN89x43X0Tp5j6bpwkAULqsbbiBqK7+gXHiXjH6x1M9NqYBgbSQ6F+iRDShuYcpEZW0JkG4e+uNMnIh8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5UwjJO9AaviWf7vKa5ho0jS5TuMT+tvQyq+8GDfE4E=;
 b=Pna837r/QbKGfXwLPc8ThRIXz+H30DocT18yER6Nr5n/8QQrZFaH9d34auvLlYJg0NH2aWx8uJlC0THHw1SDCRUort88nOevGvPu28Nt4DIAVLN4i06mOosi0SYtITseV4uo9U/NgcTLHVBdUbtBXTYzEo4+UGTZhYt6t1Xu7pcZaOmfn47asb5LE3ngvLJJf+mU5E+CppwL/SuPgNL8CdhUOsfD9Bip09SyqLlepU+3wxrDuqsKCJ90K32PFkGOur7vA9k7kHpCbtT+XwSwhPMl6duQTInzz4N2o/uoKGApD8EGllGgkySfYSvQq5aDR0HVQ8594uRaHHyJWQpPFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB8893.namprd12.prod.outlook.com (2603:10b6:208:484::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 15:57:11 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Mon, 25 Sep 2023
 15:57:11 +0000
Date: Mon, 25 Sep 2023 12:57:09 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	"Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
	"Huang2, Wei" <Wei.Huang2@amd.com>,
	"jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH v3 1/5] iommu/amd: Remove iommu_v2 module
Message-ID: <20230925155709.GG13733@nvidia.com>
References: <20230921093140.6162-1-vasant.hegde@amd.com>
 <20230921093140.6162-2-vasant.hegde@amd.com>
 <BL1PR12MB5144C5ADC106D450EA73C511F7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20230921141415.GN13733@nvidia.com>
 <BL1PR12MB51449627A11B2BDA55B97C8CF7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20230921163154.GO13733@nvidia.com>
 <19c7c139-b002-384f-5766-b87a8013029e@linux.intel.com>
 <f738e94d-1c1f-94e1-c4e3-752671af3c90@amd.com>
 <20230922120002.GJ13733@nvidia.com>
 <c7014abb-2c8e-fc3f-5cae-75060c8dcaf5@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7014abb-2c8e-fc3f-5cae-75060c8dcaf5@amd.com>
X-ClientProxiedBy: MN2PR20CA0033.namprd20.prod.outlook.com
 (2603:10b6:208:e8::46) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: ddf1979a-a8e3-4d97-7be4-08dbbde01437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	V8k+PqxcsOXWOx1pGUroztifkRwmAVsoqeeHwV3hEfedgkYV8aj0ojoLI4DYecIiHS1q4T8zUGj/MuzH+G6eMVi5e7o6ZmLFP0OZkfuuaRWAQy0s57IM8TxJPuOSLbdov8vXAymsHgdzVlw8jgyY3fX4VsTUFCPN9ynTyVXz/zaeg1az/4VKj6nz4uZ948pPRzFBQeQ3gGH48ryhW4LicwjoUOlW/ZdfqUWZgOsCqzOKqJ2jhPgmTH4B2CVuk1Y/+Ih+ZGxBnwzmpiv1YdxkXifSn5f1HZY6ias3S6bIbLYAUYg0TWdZ1EgNTHIXtDRuLYGHAfSNx7xpuEaetOBG19Eb0e5EXqZSIZkC+/7fKcAYdkNXdC68D603RyW9XCloDKJESm7JlMZS8oCcjKwhAu/Qvz2X1Ci0I5p71FMz/00/NPTdjNhwT/S046V9mMTgQ1SKfjY+R2J0YqSePlq5TcLYuWFLUDm0ukFMNBjgKz/7QHdu9F/27a0eg6Yx69kvwKTuEdKoCO9xiZBzod5Ft6aKWDVJyEY18l711XVLJSDq9aFV117ET3BoilyDtO8b
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(39860400002)(376002)(346002)(230922051799003)(186009)(1800799009)(451199024)(6486002)(2906002)(83380400001)(4744005)(38100700002)(6506007)(6512007)(66946007)(66556008)(66476007)(54906003)(5660300002)(26005)(53546011)(1076003)(41300700001)(316002)(6916009)(8676002)(8936002)(4326008)(478600001)(2616005)(86362001)(36756003)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFJsVHFOSUhPNzh3T0NBY1dvZUphU29xcVRtcm5LV0xuVkxhbXRQKytHSW5a?=
 =?utf-8?B?Q0VqcGYxbWxmSkdpOFVxT0U4UVhYYktBNTRQbldSQVBlTi9kc0FUa3NMdWI4?=
 =?utf-8?B?UENTM1craDh5amY0ckxYVFdUakhrcko2MGhOd0x0N1FJdllGNzBsUW9QZ0hr?=
 =?utf-8?B?OHpwZzJnLzZ0NUszV3dLdFhRQmlRNUs5U2p0MUhyNnRuOU1rYkZFZEttL2tj?=
 =?utf-8?B?SEJKWUdqakhpa3M2RTNZSmVzUlVYcFhTc0Q4THptZDNvUWZUYVIxYTNFSTF3?=
 =?utf-8?B?RTJTZyt5NWdjZUtIMFlQZnJFUng4eWpSZDVBZVdnaUxiUTBJaS9VOEh4dVRR?=
 =?utf-8?B?azdNb2lWWU1SWDdVZ2tSSVNSTzJnZC91SHlOOUt1cVFUb25FejdodTZuM2pl?=
 =?utf-8?B?Y08vdmY3SFMweTlIbkhmYmFnUE1UcXh5OEZpWndLZUJGaWxWS0tpUXFXYzhu?=
 =?utf-8?B?L3RlT3Q3TDFLb2wvRmxFaHdpYnpVTkxrWHI3YWhTb2o1SDJReU1WNUtvVlQ3?=
 =?utf-8?B?RUU5OUU4Nk55M0VFZ2Q0WEhKbzN5REZKdVFVcncyQklTL0tyVzY1QzlKTXJi?=
 =?utf-8?B?QVd2ajZpMUxubU90bXV3cnFwdWxSMlhPSDREUDROM20rNTQrM29uekJkQmJt?=
 =?utf-8?B?dWRFaUJOV09DdGFWYWdGSmlnbmpmTmk2UzhtSzc3dFJXUFNQa1FKNW1hbFQ3?=
 =?utf-8?B?cnQ1QVh5ejhTNjdxMFdPRTBteTZtNmYzN3N2Ky9FUFlPaWlhMmx5K3l2QmJi?=
 =?utf-8?B?dEdXd09XMDVxcHE2Zk5QRWJuT215SWhMYS9sN09obTJkZ0xyL3kxdTJrNWlR?=
 =?utf-8?B?ZEExY2NKalVFMDJreDhONFRrYWI5OUN3T3RSSXlDTEZkbWJ5N0pEb0hhV1Jt?=
 =?utf-8?B?bkhzZm1zYUljUFpBNnZVaTJVaDRHYkNTNU9Dd2k4ZHVhalNaMHYwcHNsZ0VV?=
 =?utf-8?B?T3FUb2MzQXJRRmw2NEZUVC9yTjFtcUhrd1RNYWZuYTlYS0xuVXVnVG5UVGVT?=
 =?utf-8?B?MDBFeHB0UVJMSDMzWDlsVmFiSWk4RW40ZktyQnZ3MlRXejRkOXdMZ0E0SVZQ?=
 =?utf-8?B?VWRvcHR6L3N4UlMzeEZlVWpQZUNXbGpkUllaajUxeGwxd0k4bVUxeGFSbSs1?=
 =?utf-8?B?RkJuMm5pTHNhMU1yRjZHanNFNlBxVC9raGN3WTVvNDFxZTNxZm9jZ2Uxd1pq?=
 =?utf-8?B?cHJGWFJYMC9aRzh3VnM2NWpKY0k1N1dMeUgxYlRrRU05TlN4Y1ZZYVoxUE5k?=
 =?utf-8?B?N2RVM1RGT3ZRL1lXUHVrMVRXL1ZVMTl3eEZKT1hUa2I3QkMxcTBSWU4va3Zo?=
 =?utf-8?B?UjVZRy9oamxZTHByK1hiN2xHQk00TGRoVUEycSt1aTZ6WFNoR3VNUUF0dVNk?=
 =?utf-8?B?Rm4waFVjS3dHNFFFZmVFNWpTM1E2SG9QRVpGSmRrQXFoOHF6SnNjZU9kWlVo?=
 =?utf-8?B?bnRRSnBRM2hHMzA3ajN0RzAwRGExS0NhN2NPNW1XMnVCVVA3OWtlSjN0REdT?=
 =?utf-8?B?SnhxOUIwcDB1U0E4cHJ3NlVHKzlnUkFxbUNIeFA0bERxOGllL1JiV3p5bzdL?=
 =?utf-8?B?K3FTU09QcUJBcmsxNUg4T3ptT1cyV3ZoMmE5UXBrSjk4NVRPUERKeU5iMnNn?=
 =?utf-8?B?dithMkxnb1ppSk1pczJXLzJRZ1VHM0txNUsyQXN6Nml5YkFrN1NJSUNyODh6?=
 =?utf-8?B?TTNUZTdtZkRsNzBUQlk1TVh2UUxVTG12OTNibkdFeTM0SElWTFJPOHZtMEJs?=
 =?utf-8?B?U3pXQ3dSOVBHYkQ5SDFpMWduZHZ5NGJmMlRNdzZQOGpGbm91dFBzSTFJS3Ni?=
 =?utf-8?B?T0xWVUxMN2FFclBDb3BRVFdjWDkyd3JEK2YrQ3Rzai9qVzU5VWFWOW56TFRJ?=
 =?utf-8?B?UjJhQ3lJa3JtajBPUlQweEV2Q3k1cEM5VjJFQWxoR3kxUlZHeUx6S2VReDlH?=
 =?utf-8?B?Vlk4cVliVGl3SzB6VXVBOTR6V00weG5EbmRRVCs0SWY2azlRVk1qVzhwQXIz?=
 =?utf-8?B?RTYzNGpmcVZISkNOL1VpbEtKVXhkdnVJYTdBVitRdEhzQUxqdFE3VDVyQk51?=
 =?utf-8?B?NWpYaWlMa0dYc0d2WGROcXROQ045RjFNTEcvLzJXV1cybXQ4MkNzSUlNc1FS?=
 =?utf-8?Q?uiH2Gltza7njTlIwciLvYpn4Z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf1979a-a8e3-4d97-7be4-08dbbde01437
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 15:57:11.4108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qKecZliI8w/41iFjxcLyXL57WOP4UUrdP2tOrQQXZehOTaxJzXkJlZtvqhOc7CUt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8893

On Mon, Sep 25, 2023 at 08:41:41PM +0530, Vasant Hegde wrote:
> Jason,
> 
> On 9/22/2023 5:30 PM, Jason Gunthorpe wrote:
> > On Fri, Sep 22, 2023 at 02:22:11PM +0530, Vasant Hegde wrote:
> >>> 2) PCI device supports ATS and PASID
> >>>    In this case, ATS is required for PRI, so we should enable it even if
> >>>    the default domain has been configured to PASSTHROUGH mode.
> >>
> >> IMO we should enable ATS along with enable_feature(PRI).
> > 
> > Definately not. ATS is valuable and importnat without PRI.
> 
> I get that. But I am not sure whether I understood the usecase when domain is in
> passthrough mode. Do you have any usecase to enable ATS when device is in pass
> through mode?

Yes, we can have the main device functionality running in passthrough
and still support SVA on a PASID. This requires ATS to be globally on
for the function.

Jason
