Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0851B274
	for <iommu@lists.linux.dev>; Wed,  3 Jan 2024 15:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kDgzM++w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcMvC2PQXnsblwAUURQQNJQqD7Anv02GSfEoDZdBr58tzqc+ctRqW0kjE2dJH+ss/QNN4lr40fvkUNDptFCw00g8XhbIegdnzkRrKeJvBpf4hx3pJVrIZB2/PidCKUxx2ONlYWuV+HrKTxxtShu0HUDg7TeKsyJ65tiEW8AFEtEQqE6WIOtdluR1c8RjxylF9+qqrmg3Wm7J5r2zvCtULvCeND9RAvyAqGRhncgtLNoToxGQxKdhjzC7DJmNpKRCjYshiQuHK3qsAUKNWKjVN2AOkZagHtjaQH6Gb5Fhyu3ECuIJpJzpGr+QyVLuwyeQe/ZCaPB2ijoeJWV74Xn64w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=liRnM7zZm8OALsWvV0N1e1AnEOhHvwxV+Nsh5l/WtaA=;
 b=NsLj+vpRebCwJHVMPNcwhWJMUw1cQH4m3yqdwilTpjpCcX5r233WHkMzApSydDOz36YaoAILI/aQbj3s2TtJuZauFloBReq0d9QfCXUaxRx7VMXo9DMzr3eTPpLBralqC+b+PoILejOy3rpU41l+yR9SlhsJp3w6dTMoQXxTPnVMBCdsqr06aoEFKMLrNumAyoQODBimPDoJlqrqYdguMiMwRzAGFeVUmef9mh/qp2bJI6vWT0PMd0slBG9nek8S24kwjgubT3bk2P4ZBAelmR6gYE85xibFHpIiZV31jGg7Oa51zfyndkA6QqKATxQCytEylMY6j6SrtRTBZUJzsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=liRnM7zZm8OALsWvV0N1e1AnEOhHvwxV+Nsh5l/WtaA=;
 b=kDgzM++wD+iY7KXVqPY7BfN/kRT+DwmVY+EvAOwpTlUsTBcS2iwfPeCCw9M5Dqq21u95c/s/XbAPXHX/4bQxGHv8vLAwuSMBkttCyuGXcovAJddVRsxkOIjHIF4A7WTPqjim1dlA6jRvPgesTGPQyZgNQtfzlIYh0W/ZZ1F1vZq1eGL9jqMYmNL1S0+qgOuv/rkw04PfTy47rLZZBMWSM9K1M8QtNwzTFm4QqBVXaxJDxUzepdHULBySYr5vHeE7RFRQ2FUXcG/kaBEkEAzuJDSHDTRmczAuPaOgwa8Hf+2dWLTQWmMFqkeFm+WggDPQS28Bc9e8WvCAmtF/u3TOZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV3PR12MB9187.namprd12.prod.outlook.com (2603:10b6:408:194::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Wed, 3 Jan
 2024 15:49:34 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 15:49:33 +0000
Date: Wed, 3 Jan 2024 11:49:32 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH 04/19] iommu/arm-smmu-v3: Make STE programming
 independent of the callers
Message-ID: <20240103154932.GO50406@nvidia.com>
References: <20231018130455.GU3952@nvidia.com>
 <CAKHBV270uJjdj4zeK-NNt+j3TiqoGDdLUQ5uRrLw9PN0ysCDbw@mail.gmail.com>
 <20231020113918.GD3952@nvidia.com>
 <CAKHBV274M-DDD+vJgO-k9s4MF=FLhKajPdphfBVofjyOS3vHbA@mail.gmail.com>
 <CAKHBV24nfdq1q76T+DRQGNYeA-kP7ONnSjDsRFGsQCJVSrSm0w@mail.gmail.com>
 <ZX7xu8jN/rBZ4A/d@nvidia.com>
 <CAKHBV26CRC8eWMuOk6EZYMHOZoR2FauP=NBazzOiWCmQYEa1vg@mail.gmail.com>
 <CAKHBV27qsgjgwPfn8OpSq30z1w203NDqBZ0s66bPgjp1XDnLOg@mail.gmail.com>
 <20231227154648.GB50406@nvidia.com>
 <CAKHBV26v9V7UqqLP+h3yxpPtAewNOOw6zD3DNfDpcejiL1Fr7w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV26v9V7UqqLP+h3yxpPtAewNOOw6zD3DNfDpcejiL1Fr7w@mail.gmail.com>
X-ClientProxiedBy: BL0PR02CA0138.namprd02.prod.outlook.com
 (2603:10b6:208:35::43) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV3PR12MB9187:EE_
X-MS-Office365-Filtering-Correlation-Id: b34fcd7f-1747-4c06-ace8-08dc0c7394d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Kv5Fblz0VuZKbR2t8B3qNiQeYWjuy6HQFDKAkMtUqvju3kCIu16cgcWoQg2olQ9u9IlRklV3aIhc1xrwfZVs0Hube3EsGjX6WCbmE6mycPfxTFlaCh2ePb+Vmo1Kt3aUlk9xMCHvnJbdTJiVdvCaYBUcm7TxwdKi4cwZGJsnAaDjtAOS3aDfCMwtOx52lT/0aFsnhTqKtaUng3+OOkSYLXO0VIX+mLW2EHN3hKHj3XEafxbzi3BI/j/Dwlr0uRM2ynYQeErySqnmq8ssbDwuCzZS6U4eDHzeCfQhH+8vq9Rnucs8z4CjroOMDqj/NzJ5NI2qEXk+lNAKID1nBWSOj4Qmg7pvNpjRm1Ye9GUuu65mEXBoH6mea1ZTvqHnj5wGEqxtI26czn6aKXgklBT2ZpHFtCM64q7QitlxRaJwSZCtowpEs4FUj6TGxWSf8dn7kUrRJbiLgUfoMEHzsw2tlJcVc8gkSPkIKh6YJzGGFHcsP1hh097po0TeHOzI6Jdoh2zOPMqMy5YP+y3/fnbLILOkaDpFy6V6JnBCVt17npJObhJdSI7DhRhtaSK4XIpY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(366004)(39860400002)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(5660300002)(2906002)(4744005)(4326008)(316002)(8676002)(8936002)(66476007)(66946007)(6916009)(66556008)(54906003)(2616005)(107886003)(1076003)(26005)(6512007)(41300700001)(38100700002)(36756003)(86362001)(33656002)(6506007)(478600001)(6486002)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnNIREpmS0Z3eHlTSWhGQUtPdjMvcC9sWDR5ZXllcWxUSm1UWkx1cUhpMUNL?=
 =?utf-8?B?RXc5dWJGUEUzMExxNGVDQUJVcUtjQTRhWnd6WkV2cUdZa0sxTG9kcDhnU2RB?=
 =?utf-8?B?ZWtyTWpyd25pb1daWFdWbnR0a1NNRXdFZno5VndvTW45Y05EeWlzbVB3NUJv?=
 =?utf-8?B?RFpXTVArREtNcVltMy9qYlJmWFBERUYzMFI1V2dpaTRwZXRVNGgvc1Z0SzBE?=
 =?utf-8?B?NHBGeUpYWk1nTDdlbDBIbTBMWEZvdlp3YU42aXJxZlYxbnprS2dwZ0wvVWw2?=
 =?utf-8?B?OU1tWlhRZjZhZzJ2MFE2YzVrYzcvWmY5Szc2WjdjNjFiTnE1SmlubkxMSjJN?=
 =?utf-8?B?SGVRQVhGNlFnUUs4RXZLbmM2aFdiemlrb1JFNzhHRDY5Tjk5eVMxM3kwUDR3?=
 =?utf-8?B?KzdDVzVxakhTQWt6UzFUSkpwY3ROMHRWOWdpYUdyRmRpaW1Kc21BVjlFTnQw?=
 =?utf-8?B?d2duTjFMZTVLS25nbDdFRXBGbE1DSEg5VWZoUTlqOWRWWnpiMUVOSW8veTBW?=
 =?utf-8?B?MkVCTGoxYWE2VS82T1k5d3kydDRaRyt2cTNDTERadm5EMlU4RjFkMmdESTY2?=
 =?utf-8?B?RFNBR0xSdkk2empaSFlMQVgyOE45VktvZ3R2akNiVVpxbEtaTE5SZGR2MEJS?=
 =?utf-8?B?ZXB1RjR0Q3kzYlkrcnVBcGhpcWVyaDd4STBkRE5uWjh5YjZMZHpwTzlQcEhC?=
 =?utf-8?B?K2hOTHpHYk5BNU5NU29LN2lxS0NIQ3dsVm16c0hIOC9XU2hrL0psSzhKbDJJ?=
 =?utf-8?B?OTNmZUQ3L2tOS1BPaXRiTC8ybzREemttZUZrNC9mUTY4K2M0MWd3L3ZONUtY?=
 =?utf-8?B?SVVMc2dhcUU3TjNZT2VaeTZKVjhySnptQjNaTHozYjFJRWcyblNuVndVSHBF?=
 =?utf-8?B?UmYxYVRSTEpIdGZUalhlckE3VnpaQW1LdlhPNno1Z002Ly9EK3pHaExDblMv?=
 =?utf-8?B?OEFPUy9RTHdrLzROTVFDbllwTVc4OVNGRkxoWlVsWlNuZVpld285T0kwUDRj?=
 =?utf-8?B?K0xoUUdYSWFJRFlidk5iVWF0OFFENlBQa1FQOFFkUkRKNEJ2WTBkV3Jxd1JW?=
 =?utf-8?B?M1h2QXEwbTJBRVhWMXByY2tVanFTVXREb3dMSjNZU0h3KzJsR3ZmbzdXSCs0?=
 =?utf-8?B?TmZKQkI3RlBLL1lpczQ2SWVlZkZ5VHBidm9adENtakQvN3p2ejJ6cmlWVm9H?=
 =?utf-8?B?N1Z3NXdsRzVVWkFGYVNYdnRpMHdUYnhOSHNxTGJ4eW9EdnE0OTBMYldMRlE0?=
 =?utf-8?B?S2s4cUJiK0R2TDd0OHB4ajloZ05wZG54Nzlxekg0UXgyT3lJV0VhYWNEdmNa?=
 =?utf-8?B?S3hlUkRneEpwa2NZVVpQUjljcy9HckVUOVNzYW1QZkEzclBET2Q5dGJjbTRv?=
 =?utf-8?B?SUxLMVlTOUdCNkxaTzd6VmQvNjVjRHJjTUhYbUhJcncxNnBtVjh3RlBJMWVh?=
 =?utf-8?B?aWlNbzRoYSs0ek8yZUsrbDc5Tlg0NFE5MnZmQkQ3WTdvYU9rVE1ndUZuRFlD?=
 =?utf-8?B?RnlPWUhObGpBY2ExUXpTS1RyUGZSMGY0YVhlMEVzQ0N4UWlSVDZVTlBXdTZm?=
 =?utf-8?B?TzBDbG1PWkVFN01walZGdENiQ0Jtd0hpS3lLbEo5NlUwbVZIUW91Y0FjNCt2?=
 =?utf-8?B?NjcxYW9NcE5aWHNXdDNJS2hodXJVdGx5VjIreEZrZEQ2MnRhTXUzVEpHL2Rl?=
 =?utf-8?B?M1JzUWVRdjBtMUlDY2RoRDYzS2VKZmtJaU55ODJVcWw4ajJXd1U4UDF0MGV6?=
 =?utf-8?B?Z2FrQnpmRUg4RGV5ZFBkSmx0Mm5JVXdjVWV1M2lBbmhRV09qdmhTM2lZd25E?=
 =?utf-8?B?VWRadm11WkJYdU12VWZHQ0V4MFlzaUU3NmxPS2tVdDY0YVRqTEVmU0xmS2ow?=
 =?utf-8?B?SVhRK3pRaTFoOU5LdnZvRWoraC94YWpkbjdkd3h3bERZN1Nrb0tjL0p0bTNo?=
 =?utf-8?B?NG5rWmhsQUhmZ3ZmVmY1SzBsbXFZTlVJbXFKSlZiUDhaeEs1ZmVNbXRTdVYw?=
 =?utf-8?B?KzRZVnVkb21Za0Y1M1JsZDdsOVZkaDJxQ3NrbEJQK1VTZ2lIUS9NQjc3SjBk?=
 =?utf-8?B?SjI5NW9ORHdSS0pjRXN4Z2JPU0tVcnZOOTVBMlNQMUZnbkVrcWJ5K2hKT1hy?=
 =?utf-8?Q?+vN+mp45aW6fEHJKpzZ7Z26BG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b34fcd7f-1747-4c06-ace8-08dc0c7394d6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 15:49:33.8724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +sUSp3C6bkn6tb1BKj3SfCH3k1szZhCjulvtpQ49ItVIh7hRc9iKIy+bP8nt+ifM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9187

On Wed, Jan 03, 2024 at 11:42:50PM +0800, Michael Shavit wrote:
> On Wed, Dec 27, 2023 at 11:46 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> >        } else { // hweight8 == 0
> >              set(qword_start=0,qword_end=N);
> >        }
> About this branch: wouldn't it be more clear to explicitly do nothing
> or warn if any of the bits differ? We shouldn't ever expect to see the
> STE differ in unused-bits position.

Right, it should be impossible considering the used consistency check,
but if we do hit this case for some future bug the right thing to do
is fix it up and keep going. A WARN_ONCE would be good

If we get here and set does actually make a change it will be to
change an unused bit which is 1 to a 0, and we've already taken the
position in this logic that is something we want to correct.

As before since set should skip the sync if no bits change this is
effectively a NOP.

Jason
