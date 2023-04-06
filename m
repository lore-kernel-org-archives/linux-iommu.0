Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2083.outbound.protection.outlook.com [40.107.95.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082BC8F53;
	Thu,  6 Apr 2023 16:09:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTc1ekKMfYoPWNxEA0nVDgjCO1kwLwUfs0DmbGZucIP+HN/0nG6NAGZZWMDQtzL6gxREzO6QYIrSt40uRQDwOVNpZvB/DraP8+rshphpLOVFjTH1euiODCIhkHjVSkqsKdvvU/RjWat4qvokP5cb7mf+nlrhNUQ4eJMF1mRoEbiqI4RajDi6GdwIdgYCpcgqBJTEMTb8Yf60a07+f387DvwywYwJLo/sHA6/HFmyqcsg4m1rAYoTAxnmihyT6CBL4Z9Gh3QA7Ba2Zjtn8tU0uhlg/nPagUeysTmfTTkuqsboTv2PFRZFKcmzuPzNGTQC5LQdWsYcjIy4xMPIJGKREw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnqpkXjKOr1ZIOwYoh8EojT+ShwJjXAmX8pczmWbaK0=;
 b=CTzJ2o5OKL64wKEiYBzSBr2QD5SV9Ah9cV51fCz9BY35SQjbevawZjam7KQ/g0XHdfTczba94biA3ZOgwjLiHmQ4Z9tx8b6mfdOEbzjF03XFPObf8zvswMp4myE2BWs23RR7UhdLs1akNboOgVcy0y4ICcVPGHBneI49hdLZykBzaPPYrk5MGjDH24zYF0UQBHffXs5kRvSlHObLM/Lt/m3GZMrNuDltSZnWW1fVouoFg0icm/CqCzj1wwXZQzwBZLiXiTo1PexPYgPTWUi3KLngc3XidbRH3IE6NPak5jaOOLJjsQGMP59Rid22sZltfnbk3YqG+QClUUK+lSDjVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnqpkXjKOr1ZIOwYoh8EojT+ShwJjXAmX8pczmWbaK0=;
 b=A+Ige2TEYXdgdl/WpdmXpFBdDZrH1f4oMU94qvZewORp9CzL5zWPpDJVPZHa6jfObt4MVRdnXHF2tdOSs51lgqcrMb0ozWYDXR6dLC2SVc56YobcwhRE/AMYTvsZpuIkcijgzPdnsUm3CHrBvyLVxqMHOm1t3VHgavD2y3F/CdC56yHGNEucJ/8z2YcypsDOniSGQlvHAOgu29MeOo3cAG4DFcArzjurW0XJ4XoKuKb8XJO7RiddkdVbnJlX8u6aSlsXx+Ix1YOMd36sateotGYwV+1ChbAbe09cznEMP2I4A6G86Ur68x+0Ew5RyjkTwaCyrRR+MANSuQZHTnAtyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4089.namprd12.prod.outlook.com (2603:10b6:5:213::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.30; Thu, 6 Apr
 2023 16:09:27 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%6]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 16:09:27 +0000
Date: Thu, 6 Apr 2023 13:09:26 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Tom Rix <trix@redhat.com>,
	Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v3 07/17] iommu: Make iommu_group_do_dma_first_attach()
 simpler
Message-ID: <ZC7utpUloineTYaV@nvidia.com>
References: <7-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
 <51111b86-97af-b3d2-d3e8-5cebc350f37f@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51111b86-97af-b3d2-d3e8-5cebc350f37f@arm.com>
X-ClientProxiedBy: MN2PR16CA0012.namprd16.prod.outlook.com
 (2603:10b6:208:134::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4089:EE_
X-MS-Office365-Filtering-Correlation-Id: 14c7d8af-01bf-48e3-c942-08db36b94bef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	n3eynoVwCYqZGHWNEmN2tXv0ckCCgm0vnH3A7xhE/8SrCfKf2e5oS0kIsey26hQhE0KJ0UU5e3AfKNXGKd0XLB8BGTuU1F4g33VXRWx9krghuUpXv7IlomnHfAoRJjHKv4zCQCEUkUGz5HQoEIL6YFo80Q9BKVhYgasITC/0hpU5/5EvlvZfTEMGl4aTUiy76XIv3z+HwzWbIN3zCkG8tqDjQmf200NrjjsBZ6NvB6HYQvmTrlUFkQ/3pNts0nZD6M4IjcA9w3gPci2D17gK6cIxHzmD9yiBQ1trXV+vUkHi8lhl5fYrmwOizuelQ8TVhO6/QqXLOs74wcSqwHEmQNBLA2MR3nJGqOL/8ejr8bKSt38Jew8axYOeMmxZAciUNPfi6J3777Bj82q34FpRCQ2NFEz8NM17DDQiP/4n3gyKcmSoJMl4Sts1cgVG6Wp0DpzRmgy6gVFBofzosHUxzKBjoplaglm//zqTw17LLAyIKyhBy25gt2ilDxzu5rGGT6x6fvj+AJCbhvtKo5xh2uLukl39jP+f9ti1nIqczZ7WJWTf3xqUd53fn7jHtLMg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199021)(41300700001)(2906002)(8676002)(36756003)(107886003)(66556008)(6916009)(4326008)(66476007)(6486002)(66946007)(186003)(53546011)(6512007)(26005)(6506007)(8936002)(86362001)(7416002)(5660300002)(38100700002)(316002)(478600001)(83380400001)(2616005)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mX/qCmONx/yARhmGy+86cLCGiQhMiRwN7WBVSWhnTlGk0A7MibvYWCGh/Wrv?=
 =?us-ascii?Q?+uAKYtLdZhKHb7uetWRvQ0G0zHxLIEhjY9pQsgDl7Qqmm7+RHvmiq+rn8hFi?=
 =?us-ascii?Q?T2QfRzWRFUXkaR7FIeYY5B0/acVZbO+MWyInBG6/oaayyqqTSvmn0Do9gl9f?=
 =?us-ascii?Q?H0W5YhJVZ6ABXlekNVM+55yvnWfZUqO/xgk3kMUTeQ8LjLDQfwDGbypfItdo?=
 =?us-ascii?Q?nCSVHGwqoxEdsHzlRiLBMrOaVrLlBL+Js37ea2VQk1QXiiscT12/rf9h7hmN?=
 =?us-ascii?Q?Uvx0YmJTlQCnp55k6OdIfwezGqM5GT89C/xQF4HKwLsSQ3dIFlOrtjTHrU9s?=
 =?us-ascii?Q?A7T9W4q6+n3aVnGZnjCJt1le1X+VjVdBSDOqIugOUursBJuR+8AiZxydSQpr?=
 =?us-ascii?Q?ByqnvC2+k0QfmXfoCwC/vr/fy/aYYevLjwa50vZ4VJT22cCNS2hmfoMRs9TJ?=
 =?us-ascii?Q?JSdwKg69gA7q28PYELyaBd4ao2RwPc4lOwiLaRCfxpXOk7iYt+07AyRuCoL2?=
 =?us-ascii?Q?MIKadiK4il5Z2Cb4XYXUw+YQKtAwY2zisYy2Q2L8l7s4Hj3ZKrw2B4kBMUsm?=
 =?us-ascii?Q?Z8KKAD20A6qrOMLUJ9rfYfVUC1b+qJRoirirY9XmV6xZW0AZZ61Lf+M2F5Cv?=
 =?us-ascii?Q?i7PoObcQrb62riaZirvqx61AEOG2Ns96cwJlXyWpf6TQwI3hpEO3CubjYRcC?=
 =?us-ascii?Q?9xYy5Wn7XR2efqizpYnFLGTBk/wyYXxG8ayjvYrpqdcStM5rsd67/BrWcV5s?=
 =?us-ascii?Q?rffXMcxOBka6XDaVnA3tmRcfgX6E07+K/sRE6GTmWClOfC6/zP8ZJ+Dnk1Mg?=
 =?us-ascii?Q?qFwaCKfuTavEmTzqwfFKLiCGY9KHbaVK2wiETXr7KqbRlLMnTfeCW5FF3ucl?=
 =?us-ascii?Q?BfJrMd7xuUa8+rCzr61JldBS6F80dN3V88Jwni8t1qFGi5g8pGjIl9ZNqoIs?=
 =?us-ascii?Q?JMMr7WfJrUxPCfcU+4TrXHLof2ylVSPsh0xeqfe+mknpeeWTDcuZ5BFR7S7O?=
 =?us-ascii?Q?0JJvPUtuYGbkXoGOoYO5q5hS8EXThLAHm1tMbEYp3IX8zwvP9aIJdCH+CKyy?=
 =?us-ascii?Q?g8zjd3r4p1gAuin6zz602b+TMFwHHL3jELVriJj5XZtlnWwmz9ABQmetO6wD?=
 =?us-ascii?Q?mpiS066D/4bimy3Rcp321B8dq09CXKWfcEDG7qjVj3YCiUCSaOp0JFJTtRjU?=
 =?us-ascii?Q?YBKiarkXuiNF/NhBoSOBBOFrF/9B1fuKJNeOJ8FhvnbdiJw8zF1Ty9MET7/u?=
 =?us-ascii?Q?sQbU4m7Fa0+JT/vd3Jq2ssNUTscB43nApBA1b57qQnhKu4SODXT4AEJrcYVL?=
 =?us-ascii?Q?6FG0wBWxBTvcHlhkPOdkThxcdZW/xIKUu6uh/GceWjJsH4ERuY1lBAcYgAeI?=
 =?us-ascii?Q?9MYrq1nCnQDMiCsUsRSMi66A5WjCNDxXp6un4t61LBtr/gZWLUYUzH/Kp/xq?=
 =?us-ascii?Q?hnjYw3J5DTQnvoLMqp36CMzR7o+/64byAjXoBLMd6snoJ4LKp8aMrf1rNiwb?=
 =?us-ascii?Q?elRjr6+3BV5VKScr9ANosmWzvh0yHazHqTQjZbZjsJaQpMfc4FwLfgUai+yB?=
 =?us-ascii?Q?vgHoqeKnaDazE5SIYQlqZNH/37+Q466KuLvAAGvx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c7d8af-01bf-48e3-c942-08db36b94bef
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 16:09:27.5424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dUWl/3XHCE4pt5dfUi8FUELN62pNh/UvDYz8iGtj4LHZyZ/CzvPgiFib4QIprNcC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4089

On Thu, Apr 06, 2023 at 04:44:57PM +0100, Robin Murphy wrote:
> On 06/04/2023 12:38 am, Jason Gunthorpe wrote:
> > It should always attach to the current group->domain, so don't take in a
> > domain parameter. Use the __iommu_device_set_domain() common code to
> > handle the attach.
> 
> Hmm, why do we still end up with this in two places, and potentially called
> twice in the same path?
> 
> iommu_probe_device()
>   __iommu_probe_device()
>     iommu_group_get_for_dev()
>       iommu_group_add_device()
>         iommu_group_do_dma_first_attach()
>   iommu_create_device_direct_mappings()
>   iommu_group_do_dma_first_attach()
> 
> Seems off to me... at best it's confusing, but at worst it's plain wrong
> (it's the one in iommu_group_add_device() that I'm most suspicious of)

Lu and Kevin pointed to this as well, it started out that way.

I made a whole other series tidying the probe related flows just based
on this observation.. 

I can pull one patch into here since this seems to catch everyone.

AFIACT it is harmless at this point since we can safely call
first_attach twice?

> Not to mention the slightly different open-coded variant we still seem to
> have in iommu_setup_default_domain() via the "else if
> (!group->default_domain)" path :/

Yes.. Humm. More parts could be moved into a function but I think it
would obfuscates what iommu_setup_default_domain() does.

Oh, I see another mistake:

	if (group->domain) {
		iommu_create_device_direct_mappings(group->domain, dev);
                                                  ^^^^^^^^^^^^^^^

iommu_create_device_direct_mappings should only be called on the
default domain.

> (BTW if any comments seem misplaced, it's because I'm really looking at the
> end result at the cover-letter commit in your branch, rather than trying to
> review each patch independently)

That is probably best. The patches are OK but it is hard to see the
final arrangment

Thanks,
Jason
