Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE67C43219
	for <iommu@archiver.kernel.org>; Fri,  8 Apr 2022 13:37:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DF4A341129;
	Fri,  8 Apr 2022 13:37:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bZJxCTLE52tj; Fri,  8 Apr 2022 13:37:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AC383403C2;
	Fri,  8 Apr 2022 13:37:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C780C0084;
	Fri,  8 Apr 2022 13:37:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D85FC002C
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 13:37:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7C81741C69
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 13:37:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xfd8aETp3nrp for <iommu@lists.linux-foundation.org>;
 Fri,  8 Apr 2022 13:37:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::602])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 907E041C5F
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 13:37:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2kbBm/KEaevsxuyjUoilF8+fuGTKRbT28zyz7TYusVQ/liJMYquAse0qqSa0IpDRgIOlqAEU8yuewvERwsBJ+YnghUkF2K59cruJQgKRMDZUwS+d/9L8dlz0YLngGjbaVxD8Uo6MHJYPnnQr2jRylkZYDUnC2RL5++1/oO6P0VhFJ+VQibHDzL2FdbeYv6QLellie1Cvck/m2iqhQhD7nwGqTM1a/uH1kZj4o/KwuTOP9X8J0XtptWt7dgubIxRtnZwpV3vXwVcrgiqZYycLnLBuGFXkDDXwBSkUqaT3kPQcU5qqNUvXUDnAOBNUGnEJzaiS17Hkzd+fGQ3G4RzQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jbchsfEvzHVGcK6JRykW+TXRFWssmPmZtBExuWcFq0=;
 b=bLxBBfL4SH/gKQgwhEw1kRw4E+lpO/mEILW2dzi7/7jXwSMB/o6awEqGFx/4viXsctxHPjJAa4KsOv50gvUxlZCQJwqahmAoiQ5l96E9q/2FYyD6twTkvXgU9rIXOqSKD2Jw6DlhNEQ/HIciGfeAdeXIQBLf3vrTFdyvQHK1tGPcoUmPUUbCeK6GcMDohyettgXFvy2vDHjxAbYSj6ErZhF02VGStkNRvroPxJhoc1vS/VOtM6DD2OcGDoOXLIbJ0A71ey4BIXJQ9MkyfdNQt5QcSugxpyT3+BaEFy+BsMxZm31WsaEJCcEEnjLKfBb2sTQrYwx2Y6f5b7TwFOADsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jbchsfEvzHVGcK6JRykW+TXRFWssmPmZtBExuWcFq0=;
 b=n4CXnAoEEzgs8VPw9tJToF4QhK3PQtuh48CgZ3wlHOtUJJVONFVCVtbDFVrIWdsJ3hzLwu+9idkMfBV5U5DXTeP/uoDZ1+YN/LN/4dXpcoKi9xG+4ZQYfZXdHEQh3GXagGIxlkUTWN/TtYxw48U6HuKKVheQZ7WUPQHpCexKxHhPsbQAG7GA6L8SmIw54vL5KkQuDAYFZiHlWoDlVgGPBASrRdjoplwm6k7U7qJEcz7hjG4j7RHVbtdaxdx4mCivdFZd1/lkLOGt0m0sksPLbvm8dQG0rT0jRW3hjprLFQErkHrsiTXqRka7jQUm6Sn70u0ygX9Td7qR484qGIyGlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN6PR1201MB2481.namprd12.prod.outlook.com (2603:10b6:404:a7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.26; Fri, 8 Apr
 2022 13:37:13 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%6]) with mapi id 15.20.5144.026; Fri, 8 Apr 2022
 13:37:13 +0000
Date: Fri, 8 Apr 2022 10:37:12 -0300
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 4/4] vfio: Require that devices support DMA cache
 coherence
Message-ID: <20220408133712.GY2120790@nvidia.com>
References: <0-v2-f090ae795824+6ad-intel_no_snoop_jgg@nvidia.com>
 <4-v2-f090ae795824+6ad-intel_no_snoop_jgg@nvidia.com>
 <BN9PR11MB52764BF8AC747D4B2E2B8BAA8CE99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220408122256.GV2120790@nvidia.com>
 <d6b1c72b-c05e-8bd8-c0cb-38e6c7ccfdb6@arm.com>
Content-Disposition: inline
In-Reply-To: <d6b1c72b-c05e-8bd8-c0cb-38e6c7ccfdb6@arm.com>
X-ClientProxiedBy: MN2PR15CA0027.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::40) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c349c36-206f-4d60-87d8-08da1964e36d
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2481:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB2481D45DC01F64FCE01B5B1FC2E99@BN6PR1201MB2481.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jjtdb1UBZx43YQlhUXQ7gQXUjliPHR/E725mGDFflH90FbD4VP8JY2tuFBpU7VAxOPkeR9f3MLQsKTmgYW/CQW7kS6tjFWubGbUit0O6hDyJZn+96HZKLYpkPT4rfxyqWBNPeuthm6orisYtBul3D3wt37chJTEOlRJP42nF7VR36De1cYkkgBqJV1R5c5ZLei8mcI0YjKIutBhAXZxj/wPqyge9bE7h8zRdlQUSvSuNd+4oJ8XG54ID/Ph9Isb4lo295ciGS5oR53ufY/yxQpUHLEVtplPoiMdyqKgvjeZNI0FwREW8GW+e2ZNUsJx8oJqFHz+ihNxcgYvbtJrlERZibv9saEH6AYuEUKM+2gD52AkBoWHYRoRoO44nZIlrIFpokJJFi9aE69FTtySA14QL+kGJmgf9l3zZe+QiBNTgFih+YpePe3nxf41cd+VoD6RceVpKVYqbqIX+5ZlDirbsPBzVW2RKsdVwpLYRpcDpvY9emZHa/qVavwqU9UWAXwUsYz4sS79xlnvTsX3dOVOMWljynAcjna/mmw2wFAxTwk5DYDBu/c21Pg0vN6qf7uIvaQXfEvdA3XrNw+Tgiqnp36JsifnJKahMu1fIe5LIDrk70c4yYVS4zShPGMswhyP7SvaUKHbvNl8Lo65w/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66556008)(66946007)(8676002)(4326008)(66476007)(5660300002)(6486002)(508600001)(4744005)(83380400001)(38100700002)(6506007)(7416002)(86362001)(2906002)(8936002)(33656002)(2616005)(26005)(186003)(316002)(6512007)(6916009)(54906003)(1076003)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4Fhlb2NkZLVMbBvTEButFOcItzHiJK0M3Ur0HyZQAflgJG7vKEZwQIykW+Cq?=
 =?us-ascii?Q?TJCqUL3QyF8TcFh9D6K0gCIFoIbZnUnqEgQ+af5dFLDPimXeRAJDsI/AoK1l?=
 =?us-ascii?Q?UHWNDlu6F1F1Y9QHnKkq3rFm+RNJlSQ7CO7kHpvZyY2fR9YquNSJylyDjrf/?=
 =?us-ascii?Q?1X6Q2N9ZKrhv8kai+ikSFflt7p4K2Y3izVlUG4v+39KsvLrWtTPcXJC96LMW?=
 =?us-ascii?Q?VJtPe9wCVUh8d5cGqryOMLRo/HJzErC3ka3CINvy752j7hhermuYFdUeAcMg?=
 =?us-ascii?Q?7QgZi6bT3OJ73aQoLZyreqngrxwhTqS4SDrdml+Nhal1E+2dkyP97wupG71B?=
 =?us-ascii?Q?RBE5NoWD3PTp0cLsYPsBap8AXIgjvLBxEx7Nb1etrmMdllIDNGVVtmqT/L0k?=
 =?us-ascii?Q?yqnGXsy5FIzQTipeDSiWYR5uQbyy/t53LZXjRqYZK76HR1zAviu0Gks+NkKU?=
 =?us-ascii?Q?0W4cg/cbVkgimHZK1LReqXuU8aL+layRHr5zugiBAJpTCITU3tuCymAMwnpw?=
 =?us-ascii?Q?zugsK0toxNX+buDCLBf2O4v67XfqekqAB6GN5UOl1dyMmhXEujiVimpNBqRM?=
 =?us-ascii?Q?k6DnJfrLwsvT1EK6hNytUnO7FdXAvNJEX87zF/a2n2zXbR15rezawRDx9zmF?=
 =?us-ascii?Q?xN0dXhIxonZNmdUBBQMxPIrFT48BQhxe0RNG32jyUzrUJxNsAVrHcfnYR+zv?=
 =?us-ascii?Q?1sTtaywQpNg3E7dEDKvJ/Pczn59nIFIy/ChpRjwYfYAyde5sGhhcYPxJLjlN?=
 =?us-ascii?Q?Y0Y9LEF3Vv7nnX3wjasJsBUSqprTxcpQAWYB+xJcm1jSu1SjSk9//s0Owejh?=
 =?us-ascii?Q?QFymfSo1/06HPqYs7eO98iFNnoTlCzxNX7hSwhFVZlpZAoKDivEpeeJHBtrn?=
 =?us-ascii?Q?S7iri1Q0wAhU0zRgTW4czBYUtXhdszZx51ujWAy4yCSMNrDY+nwOmFVFr/kz?=
 =?us-ascii?Q?jlfIZVfDiE0pFdGrdwgTjAEfVME7bSNtSMDi7El24dHl7PPbboPOmMA/ov5p?=
 =?us-ascii?Q?CAAU+oUzpx7v88vbZU7f2DCcB6jJ+HqT2oxIkVVo+xy2MiHND2/ZKs98TDYR?=
 =?us-ascii?Q?3e7n4E/O4KEvyst6M8KGTQmuN2J0xKk8oTlkIQBGggQkQ6ROaD8/MjjrdGuc?=
 =?us-ascii?Q?XlVbCxj0DoBExJ0UJaAIX61vDGYO8rUut9sbQDZLk8CDZwDV17hnvD299JAu?=
 =?us-ascii?Q?dYZz3bsOgAweQbxK7TEWHUp1kAFSBtO8gkAJ0tqFu0xv+xau6MGlR/MOlN00?=
 =?us-ascii?Q?WhzzfLBZgu1bjgLQ+iLVZ8en6k7y/dmsG3fd3NmDIq6j0BbA5HZ0sKMCJ/7l?=
 =?us-ascii?Q?Kf6Liacq8Z4B+IyIgD1ZU4e6UXAD3a03cfJvl6gMXtuyUruiICpvxHg00vK4?=
 =?us-ascii?Q?IVebE53vsnWMrTCqaVuDBwsubMT7woMlKD744dCHwDx03EPYrd6vZH+oAuiS?=
 =?us-ascii?Q?bBpyZ14fPHExyjaLwAiRscoRbDKjGhtWcftdGyzPSOyT46c5OJemaf8QAaF1?=
 =?us-ascii?Q?r1kAb4iptR+e6P6NC1v64htmr0OQOXitfdK6iFvkVOPx24zChFoHjW3EuOfb?=
 =?us-ascii?Q?+jU8PX7+AhoZ07aMy4mmN9EV2DPwWnY60a3AZJWQYvIQDtQLA1snW0NlcBDz?=
 =?us-ascii?Q?+ntVFeadjb96OH45HKk1EjvWgDIZmxgmPtgYCKKwSrmJv+G/DIQcsvcN4U0c?=
 =?us-ascii?Q?uulp3LpyroIwXuO3sigGQDPOadzmDjObkYHD9tdXcFk75ofr3hvUfx35o86n?=
 =?us-ascii?Q?MEa4F4wjdw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c349c36-206f-4d60-87d8-08da1964e36d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 13:37:13.0470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LvBiMn07iTwJX/OHMswiSrNyOZ6At7Y6FoKuTn9xlWoOlhYqLET0XpTd+UqKPrhe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2481
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>
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

On Fri, Apr 08, 2022 at 02:28:02PM +0100, Robin Murphy wrote:

> > > One nit. Is it logistically more reasonable to put this patch before
> > > changing VFIO to always set IOMMU_CACHE?
> > 
> > For bisectability it has to be after
> > 
> >      iommu: Redefine IOMMU_CAP_CACHE_COHERENCY as the cap flag for IOMMU_CACHE
> > 
> > Otherwise Intel iommu will stop working with VFIO
> > 
> > The ordering is OK as is because no IOMMU that works with VFIO cares
> > about IOMMU_CACHE.
> 
> The Arm SMMU drivers do (without it even coherent traffic would be
> downgraded to non-cacheable), but then they also handle
> IOMMU_CAP_CACHE_COHERENCY nonsensically, and it happens to work out since
> AFAIK there aren't (yet) any Arm-based systems where you can reasonably try
> to use VFIO that don't also have hardware-coherent PCI. Thus I don't think
> there's any risk of regression for us here.

Right, I was unclear, I meant 'requires IOMMU_CACHE to be unset to
work with VFIO'

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
