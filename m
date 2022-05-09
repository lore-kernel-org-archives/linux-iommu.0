Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5CE0C433F5
	for <iommu@archiver.kernel.org>; Mon,  9 May 2022 23:35:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 30D8760D88;
	Mon,  9 May 2022 23:35:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Uy48oKuGa53c; Mon,  9 May 2022 23:35:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F22D760DC6;
	Mon,  9 May 2022 23:35:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9728C0032;
	Mon,  9 May 2022 23:35:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C9AFC002D
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 23:35:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6B8DF40190
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 23:35:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0Os1NBfnJ94P for <iommu@lists.linux-foundation.org>;
 Mon,  9 May 2022 23:35:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::606])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5AA77400A8
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 23:35:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZKOgRJkqlVzvf5q7nG00lbQr+vroI/b9LromXqX1WhdYFViK44Ogr6nhE85F9hROtyNuKF5sB2B3Y4AD3Gs5+TSzNhpLz/A6VlQauxxyIWvqJSq9NqOq5qflGVw8dP/yOyqSyJn1hiGB4hs6KKE+VnKqXapqiiJWjhad36co8i64wlnAqYBQz3Lx6+7GyGWmrI9LvAglDuN46cbSl2goYq6EURQ6+2vMH+V1kREqDTq0Guopld1yJrEVyNUGThgqVedUFYsPKfPEg6IYP7Ggx+EyTjkHesUHRGkG7bfSPUNflHz0YVFJcuh/SgCdIsiPWNNMwk9zNbwNVTuTb6Oow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/m9loEa+OE0CO/6UOT6feLPAD6VB9dHnajCC0Sh4Ig=;
 b=Yuz+7JYaLwaUQa1yTxkttrE0DltkXN1BMfONUFtaGX+zuYFkcwoPFLxAczuyOsA8GEWujzSoJsDaAzngje5NAMutloI6sVlS2h6WKVWih9XlcySMKJXU1oUl4aJjAdqB1mPvc/iV2l529EZqsV7/ClJeF4UOJSi2Ai3lFCXKNEIssE2aXkT9osR840psrXkOvgsxPxu4WHwwxqX2jaw+6Cz/jkRku5C5jYDMLOqbkCdmr9tFhLVm150jrnOfQOxHl03iWLBWGY0scj8ossH0ab7utlkWGwIMZMxt9aqpYBw/zkoPP+8yaDi7qZe8BuTP8mY8oSCHfkYsxlTtd1nhBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/m9loEa+OE0CO/6UOT6feLPAD6VB9dHnajCC0Sh4Ig=;
 b=CTu7PY/XwQho2B0YKpKT6IWIHKvedhIj9PyJWsEQ7MIxkKXNvxMuM7W2EDE5qOz7N5BBmPFfEUl624Mm3gMdFK0mtKpcNsqLS4eLlVqjd5Eq0YQi3x4KFJ9Hb8Z6vi3SST519WrUsr3PWA68QzSTskfQ5n3h/RBWO1rssy904af9bfV9MjPLlK1q+V14edtfHeVI72J+rP3ZXk4g50sB8HoC8KPFIthgrUtcfYrsjUeRTFwsJHaUllmw38/oW6jXsyWNoZzJn1fAtnKPO5V7vpDoiTobljdh9cs1bk5FkncjZR8MrD2VLD0rw4UZwzvLykcer4UqU1u+hA32Bf2bog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM5PR12MB2488.namprd12.prod.outlook.com (2603:10b6:4:b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 9 May
 2022 23:35:51 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 23:35:51 +0000
Date: Mon, 9 May 2022 20:35:50 -0300
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2] iommu: iommu_group_claim_dma_owner() must always
 assign a domain
Message-ID: <20220509233550.GA1040383@nvidia.com>
References: <BN9PR11MB5276504B448C715527AD5F3F8CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220505153320.GS49344@nvidia.com>
 <BN9PR11MB5276476BB203D8D61CA8849C8CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <9f6680ed-77b6-8440-078c-623406c823aa@arm.com>
 <20220506131053.GA522325@nvidia.com>
 <27088ae5-05d6-122a-d9de-80e10eecac38@arm.com>
 <20220506135431.GC49344@nvidia.com>
 <0f838b34-460c-ed83-7b98-6cda444b10c2@arm.com>
 <20220509172654.GP49344@nvidia.com>
 <eff13777-bb3f-f1f5-d5e7-e2461c6e9238@arm.com>
Content-Disposition: inline
In-Reply-To: <eff13777-bb3f-f1f5-d5e7-e2461c6e9238@arm.com>
X-ClientProxiedBy: BL1PR13CA0193.namprd13.prod.outlook.com
 (2603:10b6:208:2be::18) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6382225-d16f-4d93-fc0c-08da3214a70b
X-MS-TrafficTypeDiagnostic: DM5PR12MB2488:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB248881066EFECBBBEE54399AC2C69@DM5PR12MB2488.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SIDJLeOSryJJYTDN47K8kZ2ZQgSRrp7c7K6S7nPUoYd5srrOQf2HcmpJc+QWpbJm4kdu+/4rORywnfvi6ykKZmEdHu+CfpuxEg2bZXEq9ffgRUxR+CfEiBFe+3gclftoMCjtGamjzmijJ8CG4IszmPpEW7uzpCNN709/d5o0O45PlzArJUAdeqAzdUMMyvZSvvcq8uPeqaocXFFArgk9esyA043hnysdmpEd/+DF0lyWgSthNUpxK56QFpgbgvEKdZny1BENqihEDYnwyl06u9AYYIXvsJNpJoPyKlrBmDIMBiOuR0S3ka+AWKMibUPtJ35czN/xyE923Q6sDxAP5X591/bTnTh7bbIkzCWGfioRA9dOaPcAlq9bQ1jTyKuyTSkUeYfrBSjk5Rbvh2jCAjB3SzrO5DZ9szpdrwvkDxix9HLi2STdXcAqf36i2juosqdxjwGsitv3YGvffEXlBvOhrPY1xv6PJ49zjYH1Ac9e7u2CY//TZQGq5F4eXDQG8aLhIbUaxtBCTYM2/bP//bcXHabDsx4uUbqLks1g0lMtS5OOSwdgUzYiG4P1LKA7GsiYTnqwWsuzPfVfcHysrHQUZLewjDU2hEAHDjQAOKVW1WQSEy4FZtsglx4iFjm/KAeQVvPjRHMPN8YMw5Yb6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(6512007)(26005)(83380400001)(2616005)(1076003)(186003)(33656002)(316002)(8676002)(66476007)(8936002)(66946007)(66556008)(4326008)(36756003)(5660300002)(2906002)(508600001)(6916009)(54906003)(6486002)(6506007)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9cxr6Xvuu2wj74npPGH7PDhMQxqsHwexTrGfVKQ30rhPuMhY/f8Z/nJPTMiG?=
 =?us-ascii?Q?evynHFb+5SXlPRZsYCLY3YOPo9Yea8d8hMK2LYfv9F5D/66JIfONVpsnVswD?=
 =?us-ascii?Q?AwEcwo6TXmKxYaB89R1V2glYIRr8Ri/M7G8wj8rv9+27KBijt134qa3atbMH?=
 =?us-ascii?Q?4uTgNhjJRj5aSzbc4deS/SpqNo8zI/Qz4dhw7Pfa8a+MaS0MukFFGingPADb?=
 =?us-ascii?Q?qvPvDLe1FAXQLdykpE8pZxJzQPoNgQdPH6c2FjuOwPSxyT2p8Evo1modBELq?=
 =?us-ascii?Q?ofKrgV4d8VezDtrorGVZrkv0YjbzNRrXzuxN5Kbw7GuteTfvU/a0sS53IrpX?=
 =?us-ascii?Q?YHUxMzMneLY5K2I5mnkU3Q2NYmi6Nmp3aGahzFcJsF0WhzKGJjor8dW1Czq6?=
 =?us-ascii?Q?YYOApC+2NDFYarJoW7M4ggayC18MgIZ6Ejlawc34IoCCFuqxAMhwxMgp+EtG?=
 =?us-ascii?Q?Flv27WRpLAluN7/aIor8j+q2agJxbxccXS73Gwbd8q0WvOf4T2qmGjhmJce5?=
 =?us-ascii?Q?Pq3YUBTHxlKZatIvTNXffU6fUhQWHvDA3rJaZJs8UzaPZ8eRAat6AYetKkq7?=
 =?us-ascii?Q?IYwt2HY6RAAPfGmULhPZC8SalpPUzLbiFF3ZKwgNXk+C5pEBeiO65X7tYj3q?=
 =?us-ascii?Q?CdJXE4uOkvqC8Mb98hl/MHa/3mwkg32dnOI4/j+4rv21eUmtBQSwUENggp8J?=
 =?us-ascii?Q?22J9MIt7bJiBMTHX5xmoblfOpf26dqto7KLDNAWr+5RWqR2E1yBe83RKzdKi?=
 =?us-ascii?Q?WiExCXTpMwXJCV78aqTK9C5zU13SI5a5/djn7lXRGfQMvWacru7wvZwKgWAE?=
 =?us-ascii?Q?BMz1AGrbzFD1XSXxVLPGbcLrkRCJsfwlwx+WxHYemCtAy2IVEH/ViOBmy88K?=
 =?us-ascii?Q?ObB9xDMlhRQf641WaAUN19lcFM/inxFqnq0s63RkkV17mMtyZKLx712b1zW6?=
 =?us-ascii?Q?OBulNPjQ1nPDg4h4Tf5iSGPalzfbKbM9H7gpWZQj9RgU7uLiN1dFmzW7uAkG?=
 =?us-ascii?Q?8MoVBzZ3J5ussZhvjIuGTNCnBqAd4FgKvJqxovz6mv8OSI9Kgsp23IJG5KLO?=
 =?us-ascii?Q?97K2QYCm128fFzgsJOGPkva7Y7opLyl9Xvwe1QcTf+iPS26tOkMPDNMiCGp/?=
 =?us-ascii?Q?JlmvB4dUmf3PupclgfLfYGsKq167yWSn4o8l9sUXzGb5d3AphQjcr7hHWg0i?=
 =?us-ascii?Q?8tyFwq6CdW4zkty9Bb6hih5B11dyGvOrLoXUqYHAGRaER9PDb2dGlf3S71ZT?=
 =?us-ascii?Q?SaecTtTsyl7bG1oNFm5dNGZc8/YlKCM98MUM7eJxCwTz3wmes6D4lUh87Wcy?=
 =?us-ascii?Q?RcnPy917QLDA+oi/60pJCtQ7ttCWKQ34OGZQLIt+YkunYcGdfIXBbVrYjcwJ?=
 =?us-ascii?Q?d9SQmPysuPAOMR04PiSgMAmNFbZblvycb9NB9smC8echGZ1dwC4M1u8D8sui?=
 =?us-ascii?Q?/tWpyUSzl2mky/Nf00OYlHZ24hvxDFEanbktpE+FXbwXnEkcvVVbA9pgZPD4?=
 =?us-ascii?Q?S6qtaKE8SDlde7YfQtDijm78fmd6lrEXy2FkwrAZTuwShAI3+0zeTyxZmuaH?=
 =?us-ascii?Q?Z7s5W2Rocb/KWbNdG+a7r/1a2J5eXECQyK4QXbOvWsqvwbIiqVSEL4fiQAeR?=
 =?us-ascii?Q?nSIF2ZB/c1cOLY+2ieeOC58mxuhpg5DKsA9U6sVrcQ/fs+UzgmZnkKW3BsNz?=
 =?us-ascii?Q?9kicy05zggMAt2dtszH9f6lZJR8OR/KMo/nyJKtftPhMTXSs3I5jzMlmVL0Z?=
 =?us-ascii?Q?8M/Wn9E8Aw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6382225-d16f-4d93-fc0c-08da3214a70b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 23:35:51.1067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z45owuB6160ucoYRcd+iRiY7NoHlv3oazOcgaK/LwwBe3j9Mf9KDHBBHHkj2xUJU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2488
Cc: Will Deacon <will@kernel.org>, "Tian, Kevin" <kevin.tian@intel.com>, "Rodel,
 Jorg" <jroedel@suse.de>, Qian Cai <quic_qiancai@quicinc.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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

On Mon, May 09, 2022 at 11:06:35PM +0100, Robin Murphy wrote:
> The main thing drivers need to do for flush queue support is to actually
> implement the optimisations which make it worthwhile. It's up to individual
> drivers how much use they want to make of the iommu_iotlb_gather mechanism,
> and they're free to issue invalidations or even enforce their completion
> directly within their unmap callback if they so wish. In such cases,
> enabling a flush queue would do nothing but hurt performance and waste
> memory.

It makes sense, but I think at this point it would be clearer to have
a domain->ops flag saying if the domain benefits from deferred flush or
not rather than overloading the type

> > But then what happens? This driver has no detach_dev so after, say
> > VFIO does stuff, how do we get back into whatever boot-time state NULL
> > represents?
> 
> Shhh... the main point of the arm-smmu legacy binding support is to do
> whatever the handful of people still using ancient AMD Seattle boards with
> original firmware need to do. Clearly they haven't been reassigning devices
> straight back from VFIO to a kernel driver for the last 6-and-a-bit years
> since that's been broken, so I'm now discounting it as a supported
> legacy-binding-use-case. Don't give them ideas! ;)

If everything is converted to use default domain what will this
return? NULL can't be a valid default domain..
 
> > It feels like this really wants a 'IOMMU_DOMAIN_PLATFORM_DMA_OPS' set
> > as the default_domain meaning that when that domain is assigned, the
> > platform's DMA ops are handling the iommu? If I get it right..
> 
> Nah, we just need to actually finish introducing default domains. I'm OK to
> tackle the remaining SoC IOMMU drivers once my bus ops work meanders into
> the arch/arm iommu-dma conversion revival; it just needs people who
> understand s390 and fsl-pamu well enough to at least (presumably) bodge up
> enough IOMMU_DOMAIN_IDENTITY support to replicate their current "detached"

Hum. Looking at s390 it is similar I think to smmu - when NULL they
expect their platform dma_ops to work in arch/s390/pci/pci_dma.c which
looks to me like a version of the normal iommu support through
IOMMU_DOMAIN_DMA. The good conversion is probably to move s390 to use
the normal dma API, the lame one is to use a
'IOMMU_DOMAIN_PLATFORM_DMA_OPS' and save it for another day.

fsl took some looking at, but it looks very much like IDENTITY. The
defconfig does not set CONFIG_DMA_OPS and there is no dma_ops code
aroudn it's arch support - so it follow the direct path. It seems like
there might be an offset though.

The two tegras look OK, they both look like blocking domains. Theirry
has been helpful at tegra stuff in pthe past.

Someone who cared about fsl tested a VFIO patch of mine last year, and
the s390 team is actively looking at nested domains right now.

> behaviours and force CONFIG_IOMMU_DEFAULT_PASSTHROUGH on those
> architectures.

Or should the iommu driver return IDENTITY from its ops
def_domain_type() ?

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
