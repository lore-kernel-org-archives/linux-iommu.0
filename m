Return-Path: <SRS0=rAFC=PC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F40BC433EF
	for <iommu@archiver.kernel.org>; Thu, 14 Oct 2021 14:52:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C69A460F36
	for <iommu@archiver.kernel.org>; Thu, 14 Oct 2021 14:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C69A460F36
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7BA604067F;
	Thu, 14 Oct 2021 14:52:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W3FcITk8d38A; Thu, 14 Oct 2021 14:52:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4CC03405BA;
	Thu, 14 Oct 2021 14:52:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2FCFDC0011;
	Thu, 14 Oct 2021 14:52:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73B93C000D
 for <iommu@lists.linux-foundation.org>; Thu, 14 Oct 2021 14:52:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 47B80826EF
 for <iommu@lists.linux-foundation.org>; Thu, 14 Oct 2021 14:52:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mAYEUCqeltdz for <iommu@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 14:52:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3915082430
 for <iommu@lists.linux-foundation.org>; Thu, 14 Oct 2021 14:52:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHJl6t9ZgHXMF96IyacTE3V3/tnct+yOWmmDsIX+o5VuSAu7uFsVD8S5TPNMuPOqvjIz5DucBS/UOx+Yj1IxvVmfsYXijXF4zdwwTVRQX9Np12WETqrfFMEcDJ+TL+Jadtlm0qlW3O7bFieo7qLtlPOliLZ7u+a6zhbudXfk6wXE8LWojeqJVmrpKvwiKj9407pvhaJ+DEaGIBCrFBGMzDCg54s6YAzFKFFC1cAIoSHOOAHRxA0Pqnop1tDa6oLXjNTkj8UCmQkG2AH/3GZfq0rRPf5KLbPn/0X6j2c3Or+5RXZ8LjKbwJQZVkPkkYKm8nx3OF4s/p5LxcXJ8nMEdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qJja2o5VMWdBf5VyZNtZK0pZipkZWr+6j0WTjTehhs=;
 b=O6fiRz3hEd8I/CR0SqOzrUsGf2V9QnqTSG++rX/KmqMo+jKBNWOslsNs8HEdDftCnjP5axl0xjbcrP9i3gLuBiDvfTkRVwczWzuATuUsQqi0G80SJRi4TkcGiGHntEjBn90kgZMMNLmF/NSv+QLfyuOft1KbwK7GKtHQD7+V3vZtHbvNe7/ZmpeCJO8z1/x86hN2FjfchT43575Ob9xrkOdlhpOMkr3ymQ+0W0iI3PG7bQR9vM8asqyHhdheZVGldJs8wde8GB+FyOEKp6JyiE1PSL8CzjZvPFlTrpQSOC7kRflAw7AJIufPedr6uIRZqTL7LH2Ao7g+DiFarVQTzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qJja2o5VMWdBf5VyZNtZK0pZipkZWr+6j0WTjTehhs=;
 b=fEN5iEC4TJ7iPXkGYNq9VEqXqYpd1J5EJTg/v039XBELzdLInFg67qaOYsGbXt/BXw9oVYhLjATMM2IF5wImD0TVurE3wnU/10f+K5F86y4KBWT81jahKUtlcMBpfmUgvrIOcauygMx4RpDTufK7vMwCq3VY+Qs2pwZRZ3frkN1qS//eJwe5Go/3tG9xl+Z0cE7jvNdGBz1jzQBAuPficbNIaQdcNuGNNLG9mqrtQ0u78yNeqYQAeX9WTvL/cDGdQUWkzWx4UHLGnXzkBxyHKN13CTIyXn8IVQakqPwHx7VZF7429qQD6yrthagJCf54Xe4KyY9BIC3lRDe76/Q3qQ==
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none; gibson.dropbear.id.au;
 dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5507.namprd12.prod.outlook.com (2603:10b6:208:1c4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14; Thu, 14 Oct
 2021 14:52:09 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%6]) with mapi id 15.20.4608.017; Thu, 14 Oct 2021
 14:52:09 +0000
Date: Thu, 14 Oct 2021 11:52:08 -0300
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [RFC 11/20] iommu/iommufd: Add IOMMU_IOASID_ALLOC/FREE
Message-ID: <20211014145208.GR2744544@nvidia.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-12-yi.l.liu@intel.com>
 <20210921174438.GW327412@nvidia.com> <YVanJqG2pt6g+ROL@yekko>
 <20211001122225.GK964074@nvidia.com> <YWPTWdHhoI4k0Ksc@yekko>
 <20211011184914.GQ2744544@nvidia.com> <YWe3zS4lIn8cj6su@yekko>
Content-Disposition: inline
In-Reply-To: <YWe3zS4lIn8cj6su@yekko>
X-ClientProxiedBy: BL1PR13CA0286.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::21) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by
 BL1PR13CA0286.namprd13.prod.outlook.com (2603:10b6:208:2bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.8 via Frontend
 Transport; Thu, 14 Oct 2021 14:52:09 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mb25Y-00EwsF-Fl; Thu, 14 Oct 2021 11:52:08 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd6c44a2-ed30-4e26-65a8-08d98f2232d1
X-MS-TrafficTypeDiagnostic: BL0PR12MB5507:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB550735A0AC4D9BF9160004FEC2B89@BL0PR12MB5507.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z7slMshjxkbPXcFYOty4epdkLeCuey2yysWMVBZAaqoEjOXyU3aWH9a9l1y6pyKRfny4dvkB4A/OynY+haXP2nsIAt2ArrZkiqPh+355bBNRD9TWGH+yNesCt+gnxUkBadli6jo7FeQTbQ6ZE9uW0J3K7sYRMpjwsVoa8PLSFYiq42gGjj/2Fm3Pv68p8eKnlr4AbotdMH7ZpPLy9hrWqbXKkwEhgltG+EzS4m5iHjsQi+Kh4iVdPMZtgEuP25q3Jq7DC8pc3VLPO0sGzhWYniu8vajb20axRDvtIp979X+7mDERB2WA+lmUNZH9UNzNOTAoO1WyHMqVwWb6mf/eV3JPRVSeT8LZYcLzWzytnNwJioip2er5A+848HCCgkI7pSHxwfb1A5wZv+Mt1LHO4wFk1qkhS7W6s90HxQ2TIxubChU38M0xhzQcwWZoiWbud3ihcrRxwAinom1F62LQJytlUEWCqna0ZKd6kStLi9I9FMbA/aHmwpXHADo3rokGF3069tXwtiZgcsUxHkoklnVCY52j2XCZh+T+94WOQOyDVOvFrFy5Xp3w3Oefd5Ww6XZv3TYdlVC7kBT2emv1r8bZxTmm405FlGmyuoDAfJygIL02ucxeLNlgaOS+LGxW+gRTnQrJeH6OzgS3yHa836uNW7XEdq5b1Xedvr63iJL5E8N0SdxNIf/Zcy4CK5AN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(2906002)(9746002)(2616005)(26005)(9786002)(508600001)(316002)(186003)(8936002)(8676002)(6916009)(38100700002)(426003)(7416002)(4326008)(66946007)(33656002)(83380400001)(66476007)(1076003)(66556008)(107886003)(86362001)(36756003)(84603001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZLUhbxa/ovyAmEzuzw+b5zJhIRm20c/Dm9Ca9Sahzl6ybOzxfH00P4bEPmsd?=
 =?us-ascii?Q?kZBya6vxVwr6G8vJ42bkzW6nOHJolbxhH1Lz4ll+rjiY060yhQK4egIEyH9K?=
 =?us-ascii?Q?rpuwledZFOIVbPqF3kZ3qwF8aRBT2xc9BAFIWqT6//67RPA5syZa+z7DTiHc?=
 =?us-ascii?Q?0c2A74/2i/C8tA1Sn2Xfrp8HOWoCzXQ0Rt+dc+FBohDZTwOBxj743sRLlQBV?=
 =?us-ascii?Q?nyj8UCu4LVnNRKfQKIYxu7ki1+Tj9IVRoBUnC/y3VXbUJohz4hDr2kaChGGb?=
 =?us-ascii?Q?R5Bo3zbCRj+6ScQWddk/Oe48VJzr+FikVPgMa4BYHEf/VkE+McPsmXNzmIRf?=
 =?us-ascii?Q?XTpkWybHrFz6wc4IRvNG/tzL/yL2uYx13SIOrArMhEtO3rab2oiBgYhIkjoc?=
 =?us-ascii?Q?0SfyV7fmN/uWNR+WfBai7X3aQp4VRrCkY8TZrpu9C6QJkdXavQpZv+RQmKyh?=
 =?us-ascii?Q?Djtzv5FzH4aCD7d7YZ5ZPxv6IdlGfhbGPPJ28LseSx/3ahVZaQiFYayFboml?=
 =?us-ascii?Q?gb4lWQ15RV32Wy+tuY48TsWaQC6CicPeLvZPEfoi1IJRqNSmJJGbgrBHm9hk?=
 =?us-ascii?Q?++RrczPy7tkxooYbUjI9P45tbk8hZROHuxcsjHSwdO+FVYEH+LPTK4MwOAmq?=
 =?us-ascii?Q?hCdNgX79aS7LlYvYWDeQi2gYoA+1H8kCOidXeB4uksojEadjNWvIa7fFwh9R?=
 =?us-ascii?Q?kQwLTqUfH+OHpyjxu8syp9O/+cvwLdgOjzeChxMLecN7uZEa8+K5S/KL0zf1?=
 =?us-ascii?Q?DHbpSb8oCgQ5Ry37bL+/huxm/Ea7NaTmIX+AFnfrv5HqE+y50IAAIgcR2fBW?=
 =?us-ascii?Q?hmwgz/AsZnbRMX3PJWvY3th5W//oJFehNgQaQ3f7qKgLq7A7MIT1GoK1FGJU?=
 =?us-ascii?Q?9YlTpACnWVrAD9MDKjjX+WbcqBnJRBU/iifP977n7Vzntzn2USvyAh6TfxTd?=
 =?us-ascii?Q?vH130XiccZxpG6YnNKfm2boyscozqA6cSRw0xVoSE7Onp0N7cyMno54YyIbT?=
 =?us-ascii?Q?oYvBZDJamBWyyNRvyzKq9EZ2/1ACVnY7+0RzrEir20cU6uOlLKx5aYjiMlZU?=
 =?us-ascii?Q?mDr34yXij2wIOM96DlqBYXB3bmWCwE5rTvr7iKbD0Bcsn67WGkNyQP1wHHK2?=
 =?us-ascii?Q?6b8GVs1nu6vR8uqhLnCiFypFG2Kda8LfodGWGzbLejgWpJVJO/48+if0VUql?=
 =?us-ascii?Q?Hk7PZ8WW4wVY/5/mGXk5AUc5wvLDSKg/EdsSAaO+bflN9YQIk7owe66Jsa5z?=
 =?us-ascii?Q?Sq6I0zoOItjjeqYGP3nsx0rHWbcg+DatwF0/50tTLTeroCqb0snM4TrEHcGo?=
 =?us-ascii?Q?zlh+4ogJfcZEMzmL5IFQeDvm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6c44a2-ed30-4e26-65a8-08d98f2232d1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 14:52:09.6249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FqiAIJ8eTJkjVu7lVxHKgK3WldzhbYa7an/m2Adi2vA9JOxSw9YhiR/MWLGd/CDB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5507
Cc: kvm@vger.kernel.org, jasowang@redhat.com, kwankhede@nvidia.com, hch@lst.de,
 jean-philippe@linaro.org, dave.jiang@intel.com, ashok.raj@intel.com,
 corbet@lwn.net, kevin.tian@intel.com, parav@mellanox.com,
 alex.williamson@redhat.com, lkml@metux.net, dwmw2@infradead.org,
 jun.j.tian@intel.com, linux-kernel@vger.kernel.org, lushenming@huawei.com,
 iommu@lists.linux-foundation.org, pbonzini@redhat.com, robin.murphy@arm.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Jason Gunthorpe via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Oct 14, 2021 at 03:53:33PM +1100, David Gibson wrote:

> > My feeling is that qemu should be dealing with the host != target
> > case, not the kernel.
> > 
> > The kernel's job should be to expose the IOMMU HW it has, with all
> > features accessible, to userspace.
> 
> See... to me this is contrary to the point we agreed on above.

I'm not thinking of these as exclusive ideas.

The IOCTL interface in iommu can quite happily expose:
 Create IOAS generically
 Manipulate IOAS generically
 Create IOAS with IOMMU driver specific attributes
 HW specific Manipulate IOAS

IOCTL commands all together.

So long as everything is focused on a generic in-kernel IOAS object it
is fine to have multiple ways in the uAPI to create and manipulate the
objects.

When I speak about a generic interface I mean "Create IOAS
generically" - ie a set of IOCTLs that work on most IOMMU HW and can
be relied upon by things like DPDK/etc to always work and be portable.
This is why I like "hints" to provide some limited widely applicable
micro-optimization.

When I said "expose the IOMMU HW it has with all features accessible"
I mean also providing "Create IOAS with IOMMU driver specific
attributes".

These other IOCTLs would allow the IOMMU driver to expose every
configuration knob its HW has, in a natural HW centric language.
There is no pretense of genericness here, no crazy foo=A, foo=B hidden
device specific interface.

Think of it as a high level/low level interface to the same thing.

> Those are certainly wrong, but they came about explicitly by *not*
> being generic rather than by being too generic.  So I'm really
> confused aso to what you're arguing for / against.

IMHO it is not having a PPC specific interface that was the problem,
it was making the PPC specific interface exclusive to the type 1
interface. If type 1 continued to work on PPC then DPDK/etc would
never learned PPC specific code.

For iommufd with the high/low interface each IOMMU HW should ask basic
questions:

 - What should the generic high level interface do on this HW?
   For instance what should 'Create IOAS generically' do for PPC?
   It should not fail, it should create *something*
   What is the best thing for DPDK?
   I guess the 64 bit window is most broadly useful.

 - How to accurately describe the HW in terms of standard IOAS objects
   and where to put HW specific structs to support this.

   This is where PPC would decide how best to expose a control over
   its low/high window (eg 1,2,3 IOAS). Whatever the IOMMU driver
   wants, so long as it fits into the kernel IOAS model facing the
   connected device driver.

QEMU would have IOMMU userspace drivers. One would be the "generic
driver" using only the high level generic interface. It should work as
best it can on all HW devices. This is the fallback path you talked
of.

QEMU would also have HW specific IOMMU userspace drivers that know how
to operate the exact HW. eg these drivers would know how to use
userspace page tables, how to form IOPTEs and how to access the
special features.

This is how QEMU could use an optimzed path with nested page tables,
for instance.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
