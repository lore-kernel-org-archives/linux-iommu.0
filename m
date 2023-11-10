Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF222F86F
	for <iommu@lists.linux.dev>; Fri, 10 Nov 2023 19:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RvKPuAed"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nl+6vNu6iBUDSHUijocZT9kKVEB0oPqz112U+LXpPWlAAtIuc55AT7sSDbmyiI20h4WvLRlh6aF5lhKgLv/Cdv+P4NwEbrbE/UlFHsfxFvGiPjxjlmkN+vK6ndhwSb5p4vMeNI1zClo/iJYg5132wpDKIjmjivjeFsOJiRXXG7VPnbqigNIOvxmfdLdHI7xGNgl7NTnnWL/AYNOWibshieWqWJPpNoX9A1yxzbPlBaDm9fif8xb2z/KfIHjHRhztvmlXRI2U2hKpFyaN6E03TpWMMi9/I54Th16P5V5TmGmtZ+lfrIYIY+tJJ+dbxBuaojEI4gPicRxtxCTP0qZffQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMPnLXcW4Ben0MDxAgQySLf+VQ1wrFTs6Uo7/iiVox8=;
 b=NE1TiNqsmUVy2PYD00jjoaK7bzHplriDwZH7Y+UGZ096GhXeMfdoeXA5i57SNpw5LwaClJf9fXL/WOXybvTz+4AU+SghwllTMQ/aWNWnZ49OOM1ncYv49UjEPl3uqB9FRl1D+CIQJ/lwf01iFvYTULG2ZTq9YPgJpEIHnOGY2leR36HedOH92WcwLWsyItll48bggPrQTTagcacuOWV+L8p5khEvx8KvRByWkvy6xOuMSuiACw1FPn3aiEZmze3G+Ddi6CgdimQuB/ya+CqBwUa54J5jmDMZuzycwLdiiL8Lh1FVYr6FKNfbYbZJ6IuOseFm2DJDH1vcqLQ5NxdeMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMPnLXcW4Ben0MDxAgQySLf+VQ1wrFTs6Uo7/iiVox8=;
 b=RvKPuAed4yXmNntxXQKVnkQN0sioCBe2aVr4MFzXK+ASCTA4ugk2vXvMQRN0pjrHbMlfv8Hb3tItcns6ZwwyfqBWteX/DJjyX4RLud8jRlHlyUcMZG+qZ15ZPZEHDCXUAOogyUB0EGLEoj8QLSufbsoXgVMI203xmghYqn8J1Q0scPtPbK3BKnAnYXyaw35SKQiTY9uoTcsaFEeX5r8BImAR/2pMh+yXYn8S31VRHo1ugFHmWuPcd8+Ply1HgbtwzO5Iy0hHJ62bqPjnx1fyP1eQd1hax5ahTe0vYZwqcTltY28hnOyNFgn7B3ITznMlCBKlO/nZnFXvmwZB1bfuNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5086.namprd12.prod.outlook.com (2603:10b6:5:389::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Fri, 10 Nov
 2023 19:42:16 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.018; Fri, 10 Nov 2023
 19:42:16 +0000
Date: Fri, 10 Nov 2023 15:42:15 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Rob Clark <robdclark@gmail.com>,
	Gaurav Kohli <quic_gkohli@quicinc.com>,
	Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 0/2] iommu: Allow passing custom allocators to pgtable
 drivers
Message-ID: <20231110194215.GR4488@nvidia.com>
References: <20231110094352.565347-1-boris.brezillon@collabora.com>
 <20231110151428.GJ4634@ziepe.ca>
 <20231110164809.270f82bc@collabora.com>
 <20231110161229.GA462657@nvidia.com>
 <20231110201652.629b7228@collabora.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110201652.629b7228@collabora.com>
X-ClientProxiedBy: SN7PR04CA0188.namprd04.prod.outlook.com
 (2603:10b6:806:126::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5086:EE_
X-MS-Office365-Filtering-Correlation-Id: 4df0a139-ae68-4899-5c2d-08dbe22524e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2lyY7zipXsJtwxCPAwfQAlygnxlu0Zg1DxmB19K2BvyOsicHJZIH9LdLmd5zgIti1Hr6Dit4XKbUVO8knX6bwXflqwRBDKOj3rfiZfMZGSvJSbXCg5zRakn1SjSQcyiZ48dULIbOlanM4mACof6r0mGR/SSJpUUoGBuSXdvaqEtE4S7yEZ643XLRqYXwugmkyva3sSC5IrGd00nBHpiyEH2+2acpR/7Q9u180edHlKnwdleWgbn7dWBaYpfxfuRivqkaX0q0ZLv/c7Q+maALA1odLUcaL4+pqP2NiwCMcfPa7TEiBjP224VSggF+/Mb+6+KXSmhovnC2wstpzYTnkZ6Uw5rLxtvpZSeb05EZ6sBAo1jQkb5nzcykvQiPHWPAAMaK49rKdyQ5uWAxzXE9YiXvcvv5IGhj1Ohh3OQbcOZvJSohChpCe4RsbF+avQQBZ98q8pmnzVWWiowck7OVbyR+SboCKBom+R3/J9lfFjDYdbUt9LMSfygnEPfmbc5mPfqRjOs1H6GpepQrzeexns11HECgTKLw5yFySec9qCPy6vh+5NmbbllUh2QmscxS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(36756003)(4326008)(8936002)(2906002)(5660300002)(33656002)(86362001)(41300700001)(6486002)(26005)(8676002)(6512007)(6506007)(478600001)(1076003)(2616005)(83380400001)(66946007)(54906003)(66556008)(66476007)(38100700002)(316002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JTyubRFrCRAsUBoJgN/jmVBFVQMyHwlI5zJ7wJr598kT+tadjr0jTV+X+JZC?=
 =?us-ascii?Q?0JzM2OVCj/tmFtzfirOhemiNvv8tE4j3KshWAM/fiHl39gLYOGKHn9K6ohll?=
 =?us-ascii?Q?6pFxMlseRr6eFPfaDclsKn1IbD7IIfOvJVYmDBWGlUxgwq9b9g4KJ2zxNagU?=
 =?us-ascii?Q?eHk7VKCECp5ocLYcsVlZHxyDNEjBE3xVC7oE0AS1mg5K9O5Ooh6diLORqab2?=
 =?us-ascii?Q?yJ5zhc0LJ5gUqSHmgZj0S+cxQvU8yPs9D3DveJY3f3nbEE3cpyeWSjm2f41t?=
 =?us-ascii?Q?9K1Qd4C7oqkCHGxj8S55J5cH6lUI3P3nzHABr0IrDeDRty1dehVFEXiv4IQW?=
 =?us-ascii?Q?WoXsPyObgVZCwMAb72KgOWN7FvsRCYGe93Oe58h0r6vGxccTUlizxCb/vxdI?=
 =?us-ascii?Q?oypl6ft5M0cCiKwxTgsxzkg2S/5Z8w2WvV943kQDherOzH/6JI4HjEo8Gu4H?=
 =?us-ascii?Q?+8Uf9TMTX6PBWIut1ar1r+3F2V1mX/pyVxEOrpNW/tRfPjRT9Sk9KZMx3/aE?=
 =?us-ascii?Q?kBx6cRgteq6E7R08YLRgIodpOZCM9wVCBKTDP1A6UmKblBLSf41xIDniYz6T?=
 =?us-ascii?Q?f6yuL9gm6m3seamNIeQwq0rYWAfKGbdtQU4xmw6puzi+NxZRVbAdw7qSsI9V?=
 =?us-ascii?Q?UJJC9YnD7xwiUgqAPAscZubmlaIB11GIn7yqV04jFiL9SoLjK+1iyAJ1fMdI?=
 =?us-ascii?Q?DTzxlDa0XgIMk/XeiqlW3113ziiH9Cb+1WvKMc/BeStSpfvcnArURk0myEiO?=
 =?us-ascii?Q?Lab5BwADupYa4euhEFWc7eK38B+WTUyfl4Led/roJCiYum0ap1DYMiy2NkeK?=
 =?us-ascii?Q?8awHjV+z+LQbX01f2TJyU88mi+wi0EkGw8yGd928o91wToL4gipCMsovYJyh?=
 =?us-ascii?Q?qTIlYVwizFy8Oigb0ezBE/xE6EPx13U/waeG1WqCIaGYBJGQcG+oRDOwm2SZ?=
 =?us-ascii?Q?8Q3ICg94MKC2rcGGxS4xVwIMePJ7bqoWOl6ldR1zAB/14a5Sj0YLwh5Uj05a?=
 =?us-ascii?Q?8bnz/0/AbjUwOAFK/AZQxz/y37JJ4JTus9WAKUZGJkk0zndXeVYnSlVw/82I?=
 =?us-ascii?Q?TTvznHu5WarO4bLmWGmC2gV6LVP0L9KPl4pwBcgh9yuaM2jBIM5C/ogioBwu?=
 =?us-ascii?Q?YuRc9t4Vkcp+huvVmTSBkapdcxCO8KVC/ge815zEKtJ2e/D2A1hDAyzUepvA?=
 =?us-ascii?Q?vhxTmD76/9q3BXnpafVE8u7zPucLjNP8jUXM9uoNY3E5WWJMRFxxn8Ro+atf?=
 =?us-ascii?Q?DYKCJUU2w5iBzVeqF2/r4DmEgO8rQ5eupSi0hz2XFri8YetYutItm2e/dMnR?=
 =?us-ascii?Q?n4O1PzX7FVLGIwie6gc8J/jUTxFug04lNBYjefSjdg19CTcUrGon6/JBQtbB?=
 =?us-ascii?Q?SlNd7NuD6vMWSJ01irznx+o5+NNRwHafPyLgy+WGFDi1iwa2Du/NZepYqc2m?=
 =?us-ascii?Q?YtK/3GJolOLNiV0MZ6QsDgJEFP1DqoTBMiiC3TysplzubjTHxoYseQO02ZhC?=
 =?us-ascii?Q?a6kJqHxzBQr/JhLDrDxX1hJcbVt1vwBsmhNpEx8crf2wgls7j9LR99H8rt/q?=
 =?us-ascii?Q?fwTUl8aV5vX3qjdfY/eXwhFYxh7KrxYcat7Yb8ap?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df0a139-ae68-4899-5c2d-08dbe22524e8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 19:42:16.5521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HP59SslpRI+m18+Dkzbv3hE9EW03QLWybgybFBPkFz8DLPJd7sKJ4p1gzQKkvlAX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5086

On Fri, Nov 10, 2023 at 08:16:52PM +0100, Boris Brezillon wrote:
> On Fri, 10 Nov 2023 12:12:29 -0400
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Fri, Nov 10, 2023 at 04:48:09PM +0100, Boris Brezillon wrote:
> > 
> > > > Shouldn't improving the allocator in the io page table be done
> > > > generically?  
> > > 
> > > While most of it could be made generic, the pre-reservation is a bit
> > > special for VM_BIND: we need to pre-reserve page tables without knowing
> > > the state of the page table tree (over-reservation), because page table
> > > updates are executed asynchronously (the state of the VM when we
> > > prepare the request might differ from its state when we execute it). We
> > > also need to make sure no other pre-reservation requests steal pages
> > > from the pool of pages we reserved for requests that were not executed
> > > yet.
> > > 
> > > I'm not saying this is impossible to implement, but it sounds too
> > > specific for a generic io-pgtable cache.  
> > 
> > It is quite easy, and indeed much better to do it internally.
> > 
> > struct page allocations like the io page table uses get a few pointers
> > of data to be used by the caller in the struct page *.
> 
> Ah, right. I didn't even consider that given how volatile page fields
> are (not even sure which ones we're allowed to used for private data
> tbh).

It is much more orderly now, eg look at the slab and net folio
conversions

> > You can put a refcounter in that data per-page to count how many
> > callers have reserved the page. Add a new "allocate VA" API to
> > allocate and install page table levels that cover a VA range in the
> > radix tree and increment all the refcounts on all the impacted struct
> > pages.
> 
> I like the general idea, but it starts to get tricky when:
> 
> 1. you have a page table format supporting a dynamic number of levels.
> For instance, on ARM MMUs, you can get rid of the last level if you
> have portions of your buffer that are physically contiguous and aligned
> on the upper PTE granularity (and the VA is aligned too, of course).
> I'm assuming we want to optimize mem consumption by merging physically
> contiguous regions in that case. If we accept to keep a static
> granularity, there should be no issue.

If the last level(s) get chopped you'd have to stick the pages into a
linked list instead of freeing it, yes.

> 2. your future MMU requests are unordered. That's the case for
> VM_BIND, if you have multiple async queues, or if you want to fast
> track synchronous requests.

Don't really understand this?
 
> In that case, I guess we can keep the leaf page tables around until all
> pending requests have been executed, and get rid of them if we have no
> remaining users at the end.

I assumed you preallocated a IOVA window at some point and then the
BIND is just changing the mapping. The IOVA allocation would pin down
all the radix tree memory so that that any map in the preallocated
IOVA range cannot fail.

> > Now you can be guarenteed that future map in that VA range will be
> > fully non-allocating, and future unmap will be fully non-freeing.
> 
> You mean fully non-freeing if there are no known remaining users to
> come, right?

unmap of allocated IOVA would be non-freeing. Free would happen on
allocate

> > A new domain API to prepare all the ioptes more efficiently would be a
> > great general improvement!
> 
> If there are incentives to get this caching mechanism up and running,
> I'm happy to help in any way you think would be useful, but I'd really
> like to have a temporary solution until we have this solution ready.
> Given custom allocators seem to be useful for other use cases, I'm
> tempted to get it merged, and I'll happily port panthor to the new
> caching system when it's ready.

My experience with GPU land is these hacky temporary things become
permanent and then a total pain for everyone else :( By the time
someone comes to fix it you will be gone and nobody will be willing to
help do changes to the GPU driver.

Jason
