Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9AAC433EF
	for <iommu@archiver.kernel.org>; Wed,  4 May 2022 14:55:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D0DE60D76;
	Wed,  4 May 2022 14:55:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2T-TJEVLCRUz; Wed,  4 May 2022 14:55:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9AD8860C1C;
	Wed,  4 May 2022 14:55:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B447C0039;
	Wed,  4 May 2022 14:55:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5367AC0032
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 14:55:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3BFB483312
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 14:55:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O1zbRFmPZ58D for <iommu@lists.linux-foundation.org>;
 Wed,  4 May 2022 14:54:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::611])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7C70C82F49
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 14:54:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNEhIbdtwRBbd7njD7x/2DfHgyaphIGgMTVE3SaB4alZd70sy2CpfSYPgZkrRCznolBCmxJBBI7l2Xrp2KIimIERxgAecNQSFqvQI7YBr7nKIhzRJUPryct9IZuSWJjIZh3urokeOtWOJ4PvSLT/0kb6EI8ILz2HXoS+V3xCaCyjhDLxKsR2XpFtnzHqr587/90z8IzJn9AOq6Qaj6Vr8kw9CohiGky4bSQAoU23Xmxv7SuezlyZgDfb11quI/tF/j2ElAEG/mYHrtRWOYOXRIVwHF+sK9Ke2/7Iz9+41NZ8NNkCVGMMibuK053UhTibL/EfoXjaB3YuFG3sRDS0vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/vxGiQzeezWhOxYzvzvsVKECD4sD3dHfORKbS+j2rU=;
 b=Pnw4hC/rIidmFnTShL4vvtErDhcTJaV8Fyxakw9Q9DeMTXpb1k/9RRP2ttcgRNDgAdNtWts73GtMcNnGS1K4flQF1qovy8hUsKnIpAZtd5JiWOVuwIDLbVeZFx3/kU2/mH8JVQyRdPoTjEjum3XXcVUiyjyhsXFI+3DBfyHcye+LFLY9dPv/Iu6ugIDV6M/qOJGyA6Uf7UmSqkTyUCdMGRUga3JJxIBJGUUecri6sbZzRaigmX0MZRPkwDQeERHG/uC7FBSfk+E5QanID10fzZYt+GH6tznY7H07eP+GW/tYIhA/4Aby/MMmylDKc8HiQEUxPKJ0IMFBhc90hJyv7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/vxGiQzeezWhOxYzvzvsVKECD4sD3dHfORKbS+j2rU=;
 b=aaREu5M9ihM2LZChgvni08ikYZjphbh06tXniamOTFni0xCAk47sVYYXzN+gNjoCMFAiUiOw5mjZRbPRXdnXCOVsxmRvwT1BgJi0tbCvkGW9S1RkgKxuA0I/lKW9GpTAQC3jvCFX1jjpF/jaXG9oe1fzus0/yWT8cDFRQJlWXyF52fmr9isr8V/kw7FqJG1aS/KxtJdvPaYrJv1y5QROh2gL1FVgstk+1hv6m1skbny3qQ5cznMc5ZktJA/MAat3hXEyZZryVgHGHvrX88GmMELvHFM5cUbDI4yflLPKLnKci8ZBnGwAqAVuh2nJF7hKB3mxPLN/nCNjgqEfRbaI1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB4390.namprd12.prod.outlook.com (2603:10b6:208:26e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 14:54:56 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5206.025; Wed, 4 May 2022
 14:54:56 +0000
Date: Wed, 4 May 2022 11:54:54 -0300
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu: iommu_group_claim_dma_owner() must always assign
 a domain
Message-ID: <20220504145454.GI49344@nvidia.com>
References: <0-v1-6e9d2d0a759d+11b-iommu_dma_block_jgg@nvidia.com>
 <0a8cdb2a-91a3-9953-b7a1-8517ffcadb75@arm.com>
Content-Disposition: inline
In-Reply-To: <0a8cdb2a-91a3-9953-b7a1-8517ffcadb75@arm.com>
X-ClientProxiedBy: BY3PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:254::28) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6a21377-0a7e-46ff-c680-08da2dde0dea
X-MS-TrafficTypeDiagnostic: MN2PR12MB4390:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB439071B69782D4D4D8E766E2C2C39@MN2PR12MB4390.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q4FfRBBixEhVC0IuVsj/+nKAL6NwIvF+7sm4h3Tsjre+ZkP/EiOhTGZ7RCDGOskIxGjIpJ9vRCLA0XyymnqjkhI16UhfvK3jLyc4OyLIXxIu3bWnWCsvpPKiTl8kFHAQp7rhz9JPsUNX4+bGtlig8X7WGUEvFNqlMFU1ufg+KvNmN4WvIlaZC2uQPivG+/fZrYMaDkYPpRMRC6xUUVyQ/Lda3vvG+nLbmsat2f4VZPOVlW3voacaoGdfjTCIpOE0Vtuwvw1Wq/5uhkgINehOk57Fcd8/t3ROyEaV22IkzmVySMrLMyZO//g3aX3ORO5v+rdrDB+YRSCA4bOLQ5pU+cUtgZ2u/XtsQPneSemvfi2AzGIfYnTrU7fOLG298a9TWajM/swyYmF8y7bCS8RdGcN74jWm8BXuSBI1/sskx6sUFEwU1WouhyOvHaOcUsj2H3UaIUEVITeI8H8mMLOrp4bVAq5YKesSRay7gxeLojMYXPQ3ZhpPg8XH3aJp85q7Z+o+cGF3XyHOTdq3vuh9YkkGBEiXKbLgqJ6wwKcVnx3OAKr2opvfypMdyV6q9Ubtyf3wyZHQxN77d08LbD0JRUG6Sk0d6EebmBDZQMkFsVfKbk3qiZfztlW02gjeHzFGE0nP++eAmJn5bpgZ0K2/1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(5660300002)(6506007)(186003)(316002)(6486002)(36756003)(508600001)(2906002)(8936002)(86362001)(54906003)(1076003)(6916009)(38100700002)(66946007)(66556008)(66476007)(4326008)(8676002)(6512007)(26005)(2616005)(33656002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6eAhefx/ioLZqFN/39nySXqIo5Y6LFKZrSVAgwXpRs+gYuW1e+RXVqLEDFg/?=
 =?us-ascii?Q?E1wOwu9Z+pFKCw+fAfRc8ttnweAoYb4grl8CL7B01HGHrOsKvDVIvjaZJxrG?=
 =?us-ascii?Q?FlCbpKdTVsxzGF8oCSGok8UubiaSLbyGgKr6+B11Sjslg8VfhuWWZMdbbnbY?=
 =?us-ascii?Q?vHV1y3kOTFyxsYDNnFI1n7uv4xBOiamDeSgs0kqe0jlAbF2n3SXRwzUuq/nD?=
 =?us-ascii?Q?V1OvYL5Dfz9kTzPuia6Bv+usiSMbvJEPtoR7hr1OuXwgU8SlopIJ8RDbi2Rv?=
 =?us-ascii?Q?dgPEuyVEkcbhn7Q1wSwySn1AyBJll+TyaU7T9hV+0s5a8h/CYpNXlmBVPHpj?=
 =?us-ascii?Q?3YPED5YgtVhnltqZhBH9SMT8GFJd2fzpXD0h08a56ASiVdXPliUjJ8+9Y8JQ?=
 =?us-ascii?Q?7Ep0uoh9katDLSHFQtXO+A3w06jhjB37inW12SPHfrnDq5zvHDnih/0FIKuW?=
 =?us-ascii?Q?4YmVhhw/bjCHmByaNP6z6ojXVjnCC87yWcbXLCsTMy10sKBXXailugoWYfGD?=
 =?us-ascii?Q?oVXj+ABjqUTArKUhiPXOqGiFjGj9fIHDvwZHwAG8SMDrCUPpksT9Uwz+VXj0?=
 =?us-ascii?Q?moOyl3RanqfpEpRQ3yZMhiDQipans7N9bUwBIq9IcsngWGsSV6EdHeZfoUKD?=
 =?us-ascii?Q?2IB/54fteliEhTX80wSFjwRbW8DbcONNlszxvoYk7+x0+IXC5DEP61hT2BcO?=
 =?us-ascii?Q?HsKqsfEoP0tqpDHxqLz6kxp8wwzjI10BF2U5UJNuZc2kPYT6ixDhyOpPY4NM?=
 =?us-ascii?Q?QH4n4MQETJJxuctMP+yTXNzfYhTszf0KzlLEZQhNXu4QnwpAHkwSxq2VHHpb?=
 =?us-ascii?Q?v3igZszruSrLG1upqCArgY/g4aS+bmO9kTcy67GsAbQLIw8hoPGgH9vFxB/P?=
 =?us-ascii?Q?jZjzyAjiOSXKb++lMah1yTl7pj477FTlZErB9C1Ntan7K2dd3k5MjdUzsT04?=
 =?us-ascii?Q?df+NfZVBv7cHsJZeTv3KT9Q5i7BnOSDT9+f5Aq3OQahP5ntjTM8W+JENW+9M?=
 =?us-ascii?Q?RD/G51yTBN1O3Cjp7HDm9GdImEcQtyqLSZNEXd2kelyy9EIvjlN0mMOUBwJU?=
 =?us-ascii?Q?rHeUrQOwRK7EPtGg42xjhnKp1dR4pJyBRyU+I2o+BqwzwMJ/p29DUFrv2dY5?=
 =?us-ascii?Q?YZp6PHA2I9f6OPFtQDhfBfnJxC3MgqF38QtIU7GJro0VEPbRkf5/Hu4ioKzC?=
 =?us-ascii?Q?0+XNozsSNVpljcGdGtM2Xw1yfPnGeYbe8g19HWM3EM9KCPuoJ9WoQJN0VtwZ?=
 =?us-ascii?Q?ee/t8onnxLrHg9NQHWo5j/HDN+F/76XjGswEymI7uXS37ozczpNS/VJLjYUJ?=
 =?us-ascii?Q?RJmOi0XPnDgHZ43AeJ0D70cgwi0JlE5LdM57Xh1ZmO6o0MA3ber2szLJK0b6?=
 =?us-ascii?Q?Xu5LxDq84kcjToD2zO+9VnxmmJmWhcyDruyzzmd6gkq4yNwJfeaiF9pIBBuV?=
 =?us-ascii?Q?ore6p0A/60rPSoGyWFVxG7doNntqRwVp3/opfIYnwuhrpBoCDgcwkEUKzEG3?=
 =?us-ascii?Q?sALg54Es5rsidKOWeAdI3qQoA66VjdBkCSUG//C/U4smwSAetY0Ij57aDoZr?=
 =?us-ascii?Q?SmzNPsUFZB0AKGWVtGs9m7low6iXOovVTg6OP7gLpK5B7kWBrsZSwojW08Xx?=
 =?us-ascii?Q?yUFylu4Dzi3MCn0CnpXVCf8cnHNG70IzCWNADsbaz6rdKPNpgSSu3RbdtwxZ?=
 =?us-ascii?Q?ULsbQBjyLnz1Avg+IIWIZusUfgRxD4A8I9w26tkNCrQM9WI70GlJF/P5z7Q9?=
 =?us-ascii?Q?ppY1TbnQ5w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a21377-0a7e-46ff-c680-08da2dde0dea
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 14:54:56.7388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q4LPtlrsKGhWf6isDXr1e2h0h78s01nFJvsFn00pbePhGFujkZLl4mT69Zs+sNjx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4390
Cc: Kevin Tian <kevin.tian@intel.com>, Qian Cai <quic_qiancai@quicinc.com>,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>
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

On Wed, May 04, 2022 at 03:42:09PM +0100, Robin Murphy wrote:

> > This fixes an oops with VFIO and SMMUv3 because VFIO will call
> > iommu_detach_group() and then immediately iommu_domain_free(), but
> > SMMUv3 has no way to know that the domain it is holding a pointer to
> > has been freed. Now the iommu_detach_group() will assign the blocking
> > domain and SMMUv3 will no longer hold a stale domain reference.
> 
> Thanks for taking this on! I do like the overall structure and naming much
> more than my initial sketch :)

Thanks, no problem!
 
> >   	/*
> > -	 * If the group has been claimed already, do not re-attach the default
> > -	 * domain.
> > +	 * A NULL domain means to call the detach_dev() op. New drivers should
> > +	 * use a IOMMU_DOMAIN_IDENTITY domain instead of a NULL default_domain
> 
> Nit: IOMMU_DOMAIN_DMA is the baseline of default domain support, passthrough
> is more of an optional extra.

Can you elaborate on this a bit more for the comment, I'm not sure I
understand all the historical stuff here.

Here we are looking at a case where group->domain becomes NULL - what
does this mean in the historical world? ie what should the iommu
driver do when detach_dev is called?

I had guessed it was remove all translation - ie IOMMU_DOMAIN_IDENTITY?

> > +	 * and detatch_dev().
> 
> Nit: detach_dev
> 
> Otherwise, modulo the other things already pointed out, this looks OK to me.

Done, thanks

Jason 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
