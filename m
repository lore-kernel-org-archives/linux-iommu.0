Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66227C433F5
	for <iommu@archiver.kernel.org>; Wed, 23 Mar 2022 18:15:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 06C0D400E2;
	Wed, 23 Mar 2022 18:15:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z4aFziCxtplf; Wed, 23 Mar 2022 18:15:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 78C9E400C4;
	Wed, 23 Mar 2022 18:15:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A412C0012;
	Wed, 23 Mar 2022 18:15:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC881C000B
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 18:15:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BA174848E5
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 18:15:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tvXl_2lTTDmN for <iommu@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 18:15:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::630])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 08DC8848D1
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 18:15:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7d/3kIQzJRSBJPrg7X1bm+VuKTTEx07H27DszMTVpWvLgi0K7KJo1lbDL8wFczY1LVJE7mDaCA43HJJahFhh6Mv29ufIo3/MqWuKQPrQYDDtH0c3zHzqxhQL5TjKtqF+iAT9tcLlSq2zwoous6khlx1YLFx3pJMIX0S+Q3xoANhNSVEl2zKs9WtgFx7ocH8hkTkAR9E/j9XMn9t7Ylhmjsmky85nPTycgaRQYeBdupqRL8itUOgGIG4MyYyrTtxmJFFiv5sh9H1v6xIYH5x22HRK0pruLBWMR+roePSSV6X1lW5vVe5RsZYDqhBap8rUtxzH8OqWMXwNCJbySfzlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gw+m/dcHrtw7HLfFhTweiaF0pGhckGcu05r3x4xBjtg=;
 b=muL2JQjf18fY5SO/SWjbGmLNUdAe0407DvJTO6kk9iIYo3yRDwQh5bRKReBOFj2prDshu/1dvjQztKsGEwrrlz8bCld9JSCn19sdtTDTBswg75DmABi2JvGbFn1YjFxhKD7seiF5Fqy0tn5KMP4PXdeFd62wZuT2qXrxtRMKquW3z0uMGboCrQgVlDZ/OW7PuwsgbPs4QNUGLKBfOyGS4tJhLOt+T38rU1YlFs1UchlT8EjwFj0OnjcAualXGj2HbjwckSxnsvzCLkc4bVLo/LMwXVmKerk/NfnVL6mFBvqC4UYYrQvCtf0BESpHrbpRuEj1szWA2OIZhlhABQjKBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gw+m/dcHrtw7HLfFhTweiaF0pGhckGcu05r3x4xBjtg=;
 b=p0l0T7zo1BI0ffGvjx/IK827Js6jSy68lcui1OBOSlTGbp4rhD20WIhzt3uXZVrjwcZeJnxJw5gkShdVBveoGsc5wGTrGqG8/4In99GtWtizFsMg+n/Sa+7v5i1XPdgveJbR1mYTls2hNQOTTw2BdtAVGaIpJBZ33HVWNDmmJBBJZOEZWTi8MygFYs4ZRPbSngWCHQcW5Hh7z4XCPmcSsSTcdmThIfRYM/X+fJbSBzWgBKP+hYAtg5nDPjLc8vtnh5zeMF4QyjvQ61Rih4gX5K0nHaT0hq6IpJZyGKrzUFskBJ1HeSFthBh/VmUCaaWw56j7iPVi6pZL8zrDoTmbyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SN6PR12MB4751.namprd12.prod.outlook.com (2603:10b6:805:df::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 23 Mar
 2022 18:15:05 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%6]) with mapi id 15.20.5102.017; Wed, 23 Mar 2022
 18:15:05 +0000
Date: Wed, 23 Mar 2022 15:15:04 -0300
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH RFC 10/12] iommufd: Add kAPI toward external drivers
Message-ID: <20220323181504.GQ11336@nvidia.com>
References: <0-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <10-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <20220323121001.5b1c8c5d.alex.williamson@redhat.com>
Content-Disposition: inline
In-Reply-To: <20220323121001.5b1c8c5d.alex.williamson@redhat.com>
X-ClientProxiedBy: MN2PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:208:160::30) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07f2f11f-4ecf-4b69-cebf-08da0cf90e59
X-MS-TrafficTypeDiagnostic: SN6PR12MB4751:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB475188AE344CD097F8ACE9BCC2189@SN6PR12MB4751.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ojl5RhiTGGpSpbhFwqB6xTgbDazh0+oqpuOFx69/k4k3UWjNVjhPWbhaGqzVZWEGm7Zrojf76RZlLsCXAuFV+Tyvk4FAZ1dyRs0MJ8poS6pl6uVL0jJbG9Hu2LkJy/W48iN6UVDh45fy5lVCUtHzpLX3auXcwhh0WGCYKtUzV0gbADyQZ6xxLrVoSPpY+Q27h0p6pDH9FpnzLHLEYicdkZmpsgWFtPbnjXvu7uKEH4nN08SJyaYuV5aPlIRJKTAghMSFKosV69B5u4EQqKU5CMNNlDHB9q6jPGmOHDcIlJvwsAknfcI7ZUJfpJbOutx542a+scn7S1ASIH15DnLKpowRSabaULOgq1ZRoWgTWVZU5aq5VRBPCAYLKFzD/pk0PdoDlq/wEHN7O9PE6ZxGY5Zc+h+6oRMaZA+oWbAML1ffIdhEzCc5FVhOGm49A4IoeyHPDrXL+c/i+Gk2ZpxDdQmle4RrAp1djlpea5dIltG2eLwWMMipXvvpoqNWEFT5sbJxcD1ltl/G4v0VzMe5JH35i9oC+MAOVtaNpLVw77EDKg48JrjDbEgOmpk25JXAy+ZDO6jtKeOFZQiFNNMPiXkxrldMDsbZlIBWqyNOhQAF00pNiqktzJOs2nKdhM8zxmzGQR4YGH7JnPWwuaxoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(26005)(33656002)(1076003)(508600001)(2616005)(38100700002)(36756003)(6486002)(7416002)(8936002)(4744005)(86362001)(2906002)(316002)(5660300002)(66556008)(6916009)(66946007)(66476007)(54906003)(8676002)(4326008)(6506007)(6512007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QEi1kiUQ9uzYv/lwZa27FoUOy+ONs31AB54EalXtJuCOZ2S8f7rRZylZerLt?=
 =?us-ascii?Q?uyfdqzU5Tz2ICLT0NUb7e8kOkBsVov2Vp6ImQsGzDySUR/blX5AK50BN7iSK?=
 =?us-ascii?Q?X8OOKX8I0silrKF41XuqF+gZg2rY3/OEKQpU1BHdG5h3AzewNkZXrvH5axc2?=
 =?us-ascii?Q?HlbpZ6Jil9jOTwIOS6omLADYocQDJHJHRmxAx2x7UyFo58iVx9x9BSXCFpl8?=
 =?us-ascii?Q?Pf3raKX+WlSBR08OoGa7M55mWymvliy+oQkd8516km7Vvn3ZpnYgZ/GEuOdI?=
 =?us-ascii?Q?RQGtvDmOWxIdTVw/Pj1wqChomeUO4HV8wyTCI3R7ZsU4M7kFXlJZ1lst4/hL?=
 =?us-ascii?Q?g7Zd2v+K9hII60fz8iCZWXsxoj3oCa3I6/xxtm5Hw+6ExdSvF3ttlTOt153E?=
 =?us-ascii?Q?5+2N0y1go6Nh9wVmqOzASWuiFz0H1F17aUW5MCDU527eXtUcuQFB6Ko6Viek?=
 =?us-ascii?Q?tsvK7W8GeFvssneIgMrRN1gVVbK27Ne+6T9ulCd65bmAiaaE8Y9hcR24zeFJ?=
 =?us-ascii?Q?zSxaNHzrdcTCvuLAlTW3njxWtqZFjC6fmjx2W7gqYznaGV6YAOuoR7ifBwmQ?=
 =?us-ascii?Q?fjJPRo8nsQiVn2GgfxPMT7BFmyvAxS8Qv/2Hs+cafp+3aKDlCcRpEEIHIqSK?=
 =?us-ascii?Q?2zlw02m8sh/r94fnqykP8Cg1k1oFhufZ/yTm75ZeCooiU/+HudZffiyiZqfI?=
 =?us-ascii?Q?NC0MutmagugW5y/4MI6chcCpv+7gb1Ro+Gj4ltRsUTrZY8BIaxLZ3S/Jvn1Q?=
 =?us-ascii?Q?EPg1lmstWyoMHr0s3TMVOi7dhQh9ZhUJ93S34A69LmlC5JG347LCxyprYebD?=
 =?us-ascii?Q?KGgih1lziO9MgTHmi37oP68sXskJloeRJGu0pLUljdfZvq4sYaYAnxwn/G4K?=
 =?us-ascii?Q?oz2WI0M/GwaSiRhxQj8zV2O9Jg2CRKGVJ+VHL7N/dDneXgMp9PRNEWbRj4YZ?=
 =?us-ascii?Q?xkL8wvpA3hBNJvuRgOvA++songHB0WYP7B5uu+MwlprTanzHBQuupMY/j+F7?=
 =?us-ascii?Q?orty4BUeYdNub3Qy4SQuOZAHFwm8+qwF1bwF+hV7BiAmSCH3fBBcN2M23fUa?=
 =?us-ascii?Q?Z3arHHH5zGQlFH9NEMvGqcL2MO1hZI3DepagpLT7WOjxJF1Ao0YivVby9EkD?=
 =?us-ascii?Q?EgYai9r45aEMf36MOVKFn2SfsYyJL1SCWlli1YGzwgw0+Q/KhoYAis2KQ7Nm?=
 =?us-ascii?Q?5dAqDJ3QgPuegRyu6yeaHOLrkDS4hVuChCo0uk+YkOM9F090rwyd8Gi51WfA?=
 =?us-ascii?Q?vfnckjvmd83rCtbgQtKRG2/pgiwqj/+HtA39QD6dA6G7uck0bErfTSWfGxiB?=
 =?us-ascii?Q?p1yQmhSSYfnM7g44LXfQXoqZ0CC2crANzqZvvq12c3w0r4pFwmblYAFgcqts?=
 =?us-ascii?Q?1d1/f+N71v6B5wn5siaQCnI2jJb2wrFS2lJ7yToi0Rg+IO8EMDkUHPEVKX8E?=
 =?us-ascii?Q?CWVxPExdwHYdd9J6A1QJNQsdzI5E8Xkm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f2f11f-4ecf-4b69-cebf-08da0cf90e59
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 18:15:05.5702 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJd3zKgtF7lGdb1u6sew8o7hxzqsfuuICeDKLihQ+S0q39i73fR4xZ6sFL/KxhYn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4751
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 Kevin Tian <kevin.tian@intel.com>, Daniel Jordan <daniel.m.jordan@oracle.com>,
 iommu@lists.linux-foundation.org, Joao Martins <joao.m.martins@oracle.com>,
 David Gibson <david@gibson.dropbear.id.au>
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

On Wed, Mar 23, 2022 at 12:10:01PM -0600, Alex Williamson wrote:
> > +EXPORT_SYMBOL_GPL(iommufd_bind_pci_device);
> 
> I'm stumped why this needs to be PCI specific.  Anything beyond the RID
> comment?  Please enlighten.  Thanks,

The way it turned out in the end it is not for a good reason any
more. I'll change it

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
