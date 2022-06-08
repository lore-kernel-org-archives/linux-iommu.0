Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83283CCA47B
	for <iommu@archiver.kernel.org>; Wed,  8 Jun 2022 11:17:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1AD7583F9F;
	Wed,  8 Jun 2022 11:17:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MsBdryOU6lkY; Wed,  8 Jun 2022 11:17:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EB32983F71;
	Wed,  8 Jun 2022 11:17:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE75FC0032;
	Wed,  8 Jun 2022 11:17:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF05FC002D;
 Wed,  8 Jun 2022 11:17:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AD7CA40025;
 Wed,  8 Jun 2022 11:17:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e7S76um7ZO0c; Wed,  8 Jun 2022 11:17:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::603])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E689E40002;
 Wed,  8 Jun 2022 11:17:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSbljbs6FoLDellRbZpgOPjudv63XU5tmncOfZ+pm2LmPoN5IJ7/UnAUTTbmyhWlELtGtovXauhcXb99qCpD7qccOEr3zmJnQUT5z+0s0lqKtORm9fqGAZSXFXEoOmM3KwxPSt/1UTFOj+hpmwA0kH8NVW4YP4h/39ikIBYvjx+gqrKN41lF5vgIOIoFbphWf44xwi5yub+mDi/s2TS8g/9NVbOmMbH0r/O5BhW5L8XRw2UmoIztNfF8SqcsmZZVLSR0IiqesD4B38pk31CYGFNvZg+fdW7/QIh5M5NpqFrmgu8Xm46HZoPhbIQLz2VfG62dq2KLblDy4QngaJd4Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIfkp8E5KBtvRmW4yi1xoFUv9uv8UQxyX18dwprf1MQ=;
 b=CRFpgDjh5KOmEFwRZAvuPswT3pJrEIBYU3NmY2ePuq/wcM4iRmieaDmarJZSAXGnLQHpD0f4V16/Jlzu9juRre6VKl6uRbm/OyJfIi+vHRo3XcS+8zBenYurV2xx5ti98s6MB9v1UIpGElwQUpqX6RgqKAmB7sagjzBMNd3Ch3dGnIXSJSyyuOpukNovFqjOA2TNv60dW3W1NTAMyGe/TtFh725u0RtSKi90hMmi/0GVtUby9/PnCm3RCRoVu/OomMgjUKDBOX5C+ASn6vdI6S8qnwcgjqgR6SdjTsskZ8QW4lU4O5lfqnfeWjy9MxRrC7uNqQb5MSh2kkXNbibf9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIfkp8E5KBtvRmW4yi1xoFUv9uv8UQxyX18dwprf1MQ=;
 b=k6UJmfITb5ZJlFmT8BY9zNGu99HuopB2bSBnOeK5GvkkZPRTcaFmKIuTQdC3t0Q7ktsaDIkIpQTk7JHCvcr2sjnBIElZQa1w81OURzygTNQGNGT+yFrmfMWHhN2yzq2lRj4reBeWqqtj2X66DzqbMpAUEo0bRtTVx94jFA2uy1C0cEY7Li799x/Koc8GCiPNZ4PcZ4cDxqjaai/qWmVDXonUZ7CgDj5T/vWdohFGmTLsNPiv5JwBucRszICruQwqAdXllmUEzj6L6PfVpFrOs1FLkEM5AeyDIUlkpmSNMJpD62h/fMB2Ey0vUwqRo6eSWJFrecoasE9Ue4K5rYHSbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM4PR12MB5343.namprd12.prod.outlook.com (2603:10b6:5:389::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 8 Jun
 2022 11:17:26 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%9]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 11:17:26 +0000
Date: Wed, 8 Jun 2022 08:17:24 -0300
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH 3/5] vfio/iommu_type1: Prefer to reuse domains vs match
 enforced cache coherency
Message-ID: <20220608111724.GL1343366@nvidia.com>
References: <20220606061927.26049-1-nicolinc@nvidia.com>
 <20220606061927.26049-4-nicolinc@nvidia.com>
 <BN9PR11MB5276DC98E75B1906A76F7ADC8CA49@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276DC98E75B1906A76F7ADC8CA49@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:208:c0::48) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e109dbf-2d78-4e90-7279-08da494077d9
X-MS-TrafficTypeDiagnostic: DM4PR12MB5343:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5343F3BADC2C0475E12C087EC2A49@DM4PR12MB5343.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M3khKKea+46b7JZJFDq8fk/7GJsQpPRQVXbPELsmqPZbJhqZ/sGrdnoP82INW7xxhyE0Sh8PwumAQX0xAwCY44DqUTCnQ+j+9NTbAtpMFKSK7hz8CzBnPqd05bJNjRkuREYngOpnXggGeWYw1vyvjLivH7G/ni9oR2IRo2WVvubO1EMofeDKyGpuB0brQn42fNEtSj3gxwBzNMKOXlfRCmPAFUJjd4Bkir/RlB/sfdGoYLclZYjBLA1phqGBrbg/eSDBm3tmAtErbgMHgaqIc6y/dyYmDbY3x5WFWezXPZASOql70g1UF5fQPbEV2zWA5nYu8rANQrp7/SkkkZJfu04Fj7cg9NHS92+7JV/qeN275zU37J7nSC0jR4x5p9dA5cBWHVGCkE8PbzyFM24MZnBGzBxUiiqxsS2NJpnquF3XYPcoEzRPz5LNqrWLfwWTSIDu2vIOAQSUZoOpcvVA4dmV2O1KmWDlYehcmILD1YPcPib2lxxcHFsapcL8y25rVpOxpcz0Ghm8cXVMZSayluNYVYuOIXFHcefbp8LXMhs6U4MSMJHxB7sJ6lRc+PS7V2i8IXhQrx03SU8Vthr2HPou6KdNowOzVFI40nDa+L7uo+KerZ8joQVBOFYFNj6dkB4LE/zDJbQZHHIbn/NAjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(83380400001)(186003)(26005)(316002)(7406005)(6916009)(6512007)(2616005)(508600001)(36756003)(2906002)(33656002)(86362001)(6486002)(38100700002)(54906003)(6506007)(1076003)(4326008)(8676002)(5660300002)(66556008)(66476007)(7416002)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZuxJJbH8qjGIDaAh3SXYcmnbQ48YErF4SCikA3b1V3JaUcRYWCR9Sn0Db+5w?=
 =?us-ascii?Q?VVsZMMHLjVVw/dT0yRZQpvkoDr4v5k+UfKuL+goXQF5HsRmzsx+rUeRVciuO?=
 =?us-ascii?Q?ApUOj44GgQvCoa2InUVqJ4VBWDgPMEn4qWoB0zx6fsw3sb9Y7KCGhg45pQIi?=
 =?us-ascii?Q?Zon8rxAGg2vXNQ+YN3hJRyolw1lxmIVXp5MJtpajlEtEAcHwioQ8tw7dh5K+?=
 =?us-ascii?Q?9vN7dhuMjve4o9j4wrBT5/9afAerVMGspV/qbhGcRjK7KFUeQoehpwTHEyL3?=
 =?us-ascii?Q?nYYyxs8HDiDlSxFtI0ziNU5M12sEN5IHKvQHmyMh9/7eTRQg0/3/ZI+v6EQC?=
 =?us-ascii?Q?mbhdK7qbOrBPZWvOzfniUotHvYpI2albWCRhBQCIYstGu5VvIS8fBjaS3Ttu?=
 =?us-ascii?Q?6MAKqQyQ6UBOrDVlzINFCmVV228vpGsu8TQ5lg7Y0o19AJAc1NkvmFObHOQ0?=
 =?us-ascii?Q?OaQDIPqTrl5fFtV2iRMSo4ceBXGGxOtctuTrhfO2QnPJj0m1t05JJTb2G/KC?=
 =?us-ascii?Q?/WHb3IWSR+N3FrrqSxwYAZcYAlU6FeN+cIlXBzD4gs2tTCmFaQ3hmodBKgDl?=
 =?us-ascii?Q?L3Qbc2s5C6TBppaD69bg4VI/ht+rDDnze0ATW+xulsgx+huqjOU7KwztF2kB?=
 =?us-ascii?Q?fZH5K+iuS43f2gsQ2cekA2UdFmvFZyLHn6uCxDroodhLfehwYurAR6BQXQW6?=
 =?us-ascii?Q?dQwBYDClyVJmcUa47y9uWVY9lCpT0qa+Hx91M6jJYuW+U6GY7qaUVnxh4mz1?=
 =?us-ascii?Q?YMT9fly+eSA4lG6KN/iAWfSLMXyNEvDo6AYXYMQV6hb9bPNbgeaVCpc+wOUi?=
 =?us-ascii?Q?fkOs2CHd0NKUIl3jNn7dobCasoCXw3W9yB3uG4JqW2kMorqqGP95+yxP3N/q?=
 =?us-ascii?Q?QTL8URMR8KHC8aoiPmVLU9TTuRFOffbw2NcjVQcvc0l4moGS+Un4i2BE/zAh?=
 =?us-ascii?Q?BOlFoLeKFe8L9m00Px5jlBPFdBJJGsLmMel7xMO+lz2V8jG7S/XK1zI1ZspF?=
 =?us-ascii?Q?PBennkNHEuzruBnlFhI8B2uOqogw5mlCLxxUgl2W8E9PZPOvjpZRQLUN8wb0?=
 =?us-ascii?Q?SymmRZW0N+gQH1pEa4/5VbCw00K8sTqp5xX5d/h6RxG6U8so3pXc3hFgc1dF?=
 =?us-ascii?Q?iuiNsu6IzJaRKtNF2nznl5J0w8bFSV6aIlz+98kNz8835uWnKgodkgcGKE+M?=
 =?us-ascii?Q?F/tCvQwH4iGGLYbeKBhpQWFh5dsssrwT1fV7VluQWi4VRoHarlU0D4Q9P2wa?=
 =?us-ascii?Q?+QLNlHtfl/btEkD78B83tGt9keL/FyUgUu5KgjS06WvdG8T+ravcgyyabrsP?=
 =?us-ascii?Q?nA7A8kUhp5n0Rfc4CGlJdlk6d/0eEmytSS8gWxJZaDKmxICPfU8IxIWPsza4?=
 =?us-ascii?Q?rx7pSxxY8HzTbfrcMreK6qeJJ36uMqcgU0ltblyMFwucHgec9PzO7jmYHOyv?=
 =?us-ascii?Q?6lwozP2oVdziNIEpwXfYA9s0Earq2mfB1WY+iZHjvvhHLmCLXcv5dfRtmfAm?=
 =?us-ascii?Q?GlG71sQouvV02fTDHncm4iyLuu8lBMaHcoaC+jHZStFiw9A6McRabHNERPAk?=
 =?us-ascii?Q?uTaBHoEnP78LVtptltLmQH1vei7K5GVQAErhawkyaUE54GvrGIeLVsLYncb1?=
 =?us-ascii?Q?q5gt8lY2xnHeaRLkZqhXUaawpICAM9Qzs40wNDCaK3Sgig9NGu5Mu/llotKP?=
 =?us-ascii?Q?BoOGhJmReHMuHKEXwWNJUjvizem2Ah7RXpZGqYHsMKT2Ws8KnKNo0a+7qQl2?=
 =?us-ascii?Q?NI8ZF7G2aw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e109dbf-2d78-4e90-7279-08da494077d9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 11:17:26.5851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NlzeZFRt8LJ1fNvLhsuAFFE01oM4KB5zTUX++2oN79OXPBUrX0li9IRGiFytH7Ir
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5343
Cc: "cohuck@redhat.com" <cohuck@redhat.com>,
 "heiko@sntech.de" <heiko@sntech.de>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
 "will@kernel.org" <will@kernel.org>,
 "alyssa@rosenzweig.io" <alyssa@rosenzweig.io>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 "samuel@sholland.org" <samuel@sholland.org>,
 "zhang.lyra@gmail.com" <zhang.lyra@gmail.com>,
 "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
 "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
 "wens@csie.org" <wens@csie.org>, "agross@kernel.org" <agross@kernel.org>,
 "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
 "gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>,
 "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "marcan@marcan.st" <marcan@marcan.st>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
 "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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

On Wed, Jun 08, 2022 at 08:28:03AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen
> > Sent: Monday, June 6, 2022 2:19 PM
> > 
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > 
> > The KVM mechanism for controlling wbinvd is only triggered during
> > kvm_vfio_group_add(), meaning it is a one-shot test done once the devices
> > are setup.
> 
> It's not one-shot. kvm_vfio_update_coherency() is called in both
> group_add() and group_del(). Then the coherency property is
> checked dynamically in wbinvd emulation:

From the perspective of managing the domains that is still
one-shot. It doesn't get updated when individual devices are
added/removed to domains.

> given that I'm fine with the change in this patch. Even more probably
> we really want an explicit one-shot model so KVM can lock down
> the property once it starts to consume it then further adding a new
> group which would change the coherency is explicitly rejected and
> removing an existing group leaves it intact.

Why? Once wbinvd is enabled it is compatible with all domain
configurations, so just leave it on and ignore everything at that
point.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
