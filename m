Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2351DA58
	for <iommu@lists.linux.dev>; Fri, 10 Nov 2023 16:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JPQ8ls18"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KO3t/iltjfZ2SFXUrAj8Vdj9qmcsnQx17wnBG5KfrImSxIq6qwwo4syP5NWOInJxLXIfa31ie5LGWOmFZm06QyQnT8MUYwCzCOs0AAxYH3FYHXtzdZgUhLFrTPjGddprZ7zxfsp0s+7Z1Plpvp76U9scLUj50uZosQE39Vn6Zc8N7ccSi6SB69If5CGnnzICbGMJpZ/E7G38u3SUHiY9MhAAlHDVN9ZQGYgYrBiXtHF1EtI3gwsewFz6L91QaoiXFlLhEki5tHOgqN4m3+9tJ+Kw8g/0Bff+Yaze2LB1UDHiw70Iy3+OoMVGNQ3attNb/yj/5BbP7QjE1WJzlctGSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNzU4jYkUVC8xkL2P3a0EuMm7IfNzcAdh+7nLB1+s00=;
 b=dpMNRZ+lLB5KFjR12jaAVP1CYa7hXE4QydwlpxvyaxnqGozSSmwYuegs+Vm1DKBE0NENVWk1SAfkuCvNiKcMNXimYe1l2z1RCs1EwkOJsxabjBeagBQTx0M0qgbPwDbyIF+23owr8ciBLS8G1UPg5LFzJ2FY/G7tA3dRDzAg4Gv1ob+WlWnxbrbV+FXvJjlLucno49f0Oe6KO4sheW0f4l/cbKL2QCkv1PfzW0/hDlaPeYpq3isEJNQz4N0WINaGxMy7Ok2WBsxVfVof35L+jRZd0czubunNhpfnd7CtLaaMFO357+AceQNz73kuBmxOtfK3VsLmohEBOGniC1hWHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNzU4jYkUVC8xkL2P3a0EuMm7IfNzcAdh+7nLB1+s00=;
 b=JPQ8ls18ZwRI+RlK0G181fI3W+kqYI96G7ZF+wnzRW4MiShl+YUCCwnURB9yiyfqjoN8zm6vyyXBJC9SBoAM6Z0hva20wHFtURzO77ZiVtyNNlxaTScazWoEm+DCZQVpZXlL6nfx/Js/0kwnOUDHm2BiYwr7JgJYp5ZU0bmzFrXzzJsA+d+Qv6fcsWOM/6KQ3GQHG91eI9/cXxiydVGky9h1YpODLKG1IG7jq0LW1PLTMu5Gr1TayVCsmcBKM0v+saumGQoaGPazPpyra50N/H9zUqoXhnitk9BdAowj0/HgKkBdR9Bk7hT8JJasq//1Qo6y4TuzBuMhM8WDn9EMQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB5517.namprd12.prod.outlook.com (2603:10b6:5:1be::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Fri, 10 Nov
 2023 16:12:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.018; Fri, 10 Nov 2023
 16:12:30 +0000
Date: Fri, 10 Nov 2023 12:12:29 -0400
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
Message-ID: <20231110161229.GA462657@nvidia.com>
References: <20231110094352.565347-1-boris.brezillon@collabora.com>
 <20231110151428.GJ4634@ziepe.ca>
 <20231110164809.270f82bc@collabora.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110164809.270f82bc@collabora.com>
X-ClientProxiedBy: SN7P222CA0013.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::11) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB5517:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d8ca6b4-3618-4d18-66e3-08dbe207d72d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	McCaZTW1FV7R85YuXsxTQ7FAfEZ4Yfrr2xE9F5UqLkccpiE3dsYOxwvzx8wPErYWdUyq/cBJnPmw9+tNdTAl4t7j6nsuMVHcBskAL6/APpHKCajyljpejHfPkvqwKydjiSsZZPrquSjzLNxRh0qgTqfWmYqA3Vp62/sT9Z8DZDb4iL3FbmZWmIcHF1t3yue+lqzMOa+tCIjlCIaCLobbztL8fUIxy1pv+PIQp5sz9X36mlD+E992/ekxAH/gCymq+ElumPzXHM8FhIhh0qOceoejTxu5I1GWmdVD7uhxTE4jjD748PVgyE44bqHEODBXP4MDTNdL3Tg/tuxePYYcT/RSaLKdIS2JLy0nw+uAJYEU4f0M5/gTy3534JtFRoctrrZ1NsBIelhLScgbXLqanHMJ3KuT+IdzsHGJa/vwFIuXdIpXLzjweKuFfKH2E1aTfIbfYAl/CK2yVvckoW3jOsl2phRg6kv0FPqiNR1ADhiWSK5Odz/f3/tDs9O6YOlxa8D5Sei/1TOSr01x2zoNrYwYHrW3nlhwsyyuZIEuGSuLM0QSeGKVaURnoYaWql7i3Y82J4Ac6u6YFebg6Jl6pxQ8ihfZECpYGxvhU7HbbxYUF0amgAA8j/69gC+BCSYW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39860400002)(366004)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(2616005)(1076003)(83380400001)(26005)(478600001)(6506007)(6486002)(6512007)(5660300002)(66946007)(38100700002)(86362001)(41300700001)(2906002)(33656002)(36756003)(66476007)(54906003)(6916009)(316002)(66556008)(8936002)(8676002)(4326008)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rOKNRgv5YKpBsl9SpfLlyN6awvlVteex2lL6htDwVu4gHPqwPeNUbz9bsTeW?=
 =?us-ascii?Q?j+dDU7qYAoBP3R3kr6g+lOLRGe4p+cwdyMCXRnrHNjUR4cMdkg/xH28B7t73?=
 =?us-ascii?Q?dLMO0WxCjZeAtjIegcJIxlQS6UUvvKh4TSGQmZp2vNme4ohNQ0sqaV19xmZH?=
 =?us-ascii?Q?KqpYS0h+NFXPFr8tnJsCHm+AhFxcnyqsUGWLBj1TPDRN/EFppz89PAL5ipWR?=
 =?us-ascii?Q?SpJT6xCypGbJSWy8wibg0fdtL5iEPOUS9YFnVGb73FN6DxV70FmhqCNZhIuf?=
 =?us-ascii?Q?AO0mjX0ju03r4Rt4bd/98IRXxRAoGAXOCetA7eHAtCwO0GHNdmHTqmiNx6Uk?=
 =?us-ascii?Q?nHjJPK3Li+KqxHyixbl0pcxy4Iix4cE7S4IWZwxK2+yDlQCUkN2Ap37hC3zr?=
 =?us-ascii?Q?qfOXSQZhBnuRJI91gbZ3aRikaaR8+qHzkRYXIGsPizoy8btA1+WWldGyBgX5?=
 =?us-ascii?Q?lBB0HMpPPg7KrvTq11Z0cYRKEor0sI2arhRmzAfty5BITsaLhXRY0nXNmqLH?=
 =?us-ascii?Q?80hkQDNeUWi8B6tfchC1VbtU6rfRokDy/jcJItPEsNmtrcO2OBgAcHZU4nUs?=
 =?us-ascii?Q?YAn4U/lPQwV2DRdGGRxKHVd5L434uyANlCjwcluscS92ZeV20PQeU0jvRGAr?=
 =?us-ascii?Q?ptt8YDZe/Wo9vvVWOugQ47WGD4hOJ+WwzuYbGm89kwUkwjqhePD1VMzGVZpS?=
 =?us-ascii?Q?Kw/wBldjgQnAvMoH8EHOMMbDBnQV+HjL/S8mOJNUjkJskXBC2c+r+or/UZ0M?=
 =?us-ascii?Q?Y5uqFDNjTY/oUOxf4D51IjnA0zTxVY0wc6cNo68ATyyoBZLHvzDaqqvVYYK5?=
 =?us-ascii?Q?KhFXDUOH5cggAU9c1dVNeddtUePstkVPqp5f4AsvjqAki8fMuYDpf4dphQtT?=
 =?us-ascii?Q?1IleSnXmcNhvXTRaFzRVb7HjMoDq/rxuEBa4HuCkGj0WcXXCaH9tIM/GV6wX?=
 =?us-ascii?Q?WRM1riAM+bhHacaH7eE+Nz61bNUTWOOgSYRipmyGxSQCjr/leA2o4Efty+cu?=
 =?us-ascii?Q?xPSpIhzy0mk3I05/Ll9QouTW67ruAcERn977Zd2H8yLGEQ4qrOP7trzOJiYP?=
 =?us-ascii?Q?jCFK8PxkfntoH6CImb2UmgUgodDvhJPEoxu1yE2WD8wpUqgFfHfARYSa9rYa?=
 =?us-ascii?Q?D9LXUn5Gw2LjG7ySsoOvKyTUbfZwQe4QHcFdFh04iXY0Mjo1q5DNDzyLLLV8?=
 =?us-ascii?Q?1Cb0D/JhmjdPJpijaGc/+5QylW4HVQPE5y4sslETd4ksZSnbajNkYamZcFk6?=
 =?us-ascii?Q?cizjDn3cAECZOySLiGGR+qCDvX0t0FpnUSLQ0HweiTRTg5O9V6zWkAU4zRxp?=
 =?us-ascii?Q?r1CLffjQiwjPcgcNIAyrvbsjKZLzPRKLCde18vqP+sgjBSYtH2wKQzjOJaIt?=
 =?us-ascii?Q?KozrurKsr8M9GXCjyrDYnUbfoRk2Z62Mfnr6nZ0FYzhxqAOOViwiWR67TAkc?=
 =?us-ascii?Q?M18Tj3ZsNGHr4ECJIWKcNxvmkDR7yOqIMIkZ+EPaY/07Y6OPZ7ZcIPxhPZm4?=
 =?us-ascii?Q?tN4qDtzbBq4LY+dE8EH12CXrfIbEVjGCXzNsSTvE05oCLf2dvurbylFwA1YD?=
 =?us-ascii?Q?ekLBBJeS9e8n9AqxD+KqYpAubArPqxrRbxn3eLdn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d8ca6b4-3618-4d18-66e3-08dbe207d72d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 16:12:30.9598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D0LhekgLbDz7fv4sCLH5nK1sDx4eXPis3A2Pu6Rhi4URjg0Ov7wb4V0ZmphyyVRe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5517

On Fri, Nov 10, 2023 at 04:48:09PM +0100, Boris Brezillon wrote:

> > Shouldn't improving the allocator in the io page table be done
> > generically?
> 
> While most of it could be made generic, the pre-reservation is a bit
> special for VM_BIND: we need to pre-reserve page tables without knowing
> the state of the page table tree (over-reservation), because page table
> updates are executed asynchronously (the state of the VM when we
> prepare the request might differ from its state when we execute it). We
> also need to make sure no other pre-reservation requests steal pages
> from the pool of pages we reserved for requests that were not executed
> yet.
> 
> I'm not saying this is impossible to implement, but it sounds too
> specific for a generic io-pgtable cache.

It is quite easy, and indeed much better to do it internally.

struct page allocations like the io page table uses get a few pointers
of data to be used by the caller in the struct page *.

You can put a refcounter in that data per-page to count how many
callers have reserved the page. Add a new "allocate VA" API to
allocate and install page table levels that cover a VA range in the
radix tree and increment all the refcounts on all the impacted struct
pages.

Now you can be guarenteed that future map in that VA range will be
fully non-allocating, and future unmap will be fully non-freeing.

Some "unallocate VA" will decrement the refcounts and free the page
table levels within that VA range.

Precompute the number of required pages at the start of allocate and
you can trivally do batch allocations. Ditto for unallocate, it can
trivially do batch freeing.

Way better and more generically useful than allocator ops!

I'd be interested in something like this for iommufd too, we greatly
suffer from poor iommu driver performace during map, and in general we
lack a robust way to actually fully unmap all page table levels.

A new domain API to prepare all the ioptes more efficiently would be a
great general improvement!

Jason
