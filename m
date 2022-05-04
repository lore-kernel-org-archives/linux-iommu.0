Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42095C433EF
	for <iommu@archiver.kernel.org>; Wed,  4 May 2022 11:53:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E196683EE8;
	Wed,  4 May 2022 11:53:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 26fUaFIjBwc9; Wed,  4 May 2022 11:53:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D194583ED2;
	Wed,  4 May 2022 11:53:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA870C0039;
	Wed,  4 May 2022 11:53:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE9BFC002D
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 11:53:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AE0FA60BDF
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 11:53:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mwHFAd6PKb2I for <iommu@lists.linux-foundation.org>;
 Wed,  4 May 2022 11:53:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::61e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E009360B00
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 11:53:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ki12iRoiShtnYZT3ei1bANqDSFdm0UubMU21JlZLPY0tQtzEEnzy8Or+bdwkhnFwX8fvdY7sKdpPIqTyT0dvvNbRBiM8crLwZA9gQm7fBWWO0wgtQy3yPKsu3yovfYHHJUSXAoh6fxUmRHeQbJFUuDlcmkeLdfEezY36gfhhIZnfnR+Dr1fojhDDJbEwC/lf/302CMQBs5a0AitwV5gPK+t9fGa3vM21KIWtFNqlzPARJTiKcc8RHb0zapYxwb6cxomloevLIuNr3k+dG1W1x3uwQW8m7HJf5F4HGeKKokQ3WLJIOCy7n84au+mKmVxd3jdWv7cg2jSLxzNau4acHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z42UpZiaSKKiItW5HXnAUygnK7WLmWMs4DKuXq5KdCM=;
 b=C9n0TltzAsikEKJUMma+eP0jq/Sj1RRYAb/hx6oxkjRFqQaxa4gSzHmqitIncZ0L4XWajT1xRklBatht4+c20fdNuWwtkVdWim70QCTjMlrjGMgu038H0ZuAUczlK1iwKLaE76HJw3kszi2eyB4Ts31XJmY3xebyG+iA61FjHA5DfkcTmvnERwipFstyM+JkM9tbSeS1DnUCCAMle7J93vDgFpP09AEiL5cPm5Krnlfa4WKfuh9svUT8j2O/qA93eHHb73S/4HDYU5QCv6cR/L+HjfkpvSmlZ6WYGBmCy4bN6ZyIyAgVIwSZ+NBAJ+4TwSZa2d+/+JSw/128kwENaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z42UpZiaSKKiItW5HXnAUygnK7WLmWMs4DKuXq5KdCM=;
 b=uX5WOs/2Z6vfdATU7RC22+Yr0JirfYhX09NS+xJ0mUIJviHTif7lgpRUgYxx3+3F+WAiOWi3JPmGdym42GcdS7hgHO7CIbNVXMFxPYRcSo21MsckrqWw8XPt8hfEBnuSM3QLnmMra01FDWhkvbwL2KitTSh5C4Mo8Mfa1IHJvnEo4GmjE6DXdXlZqaFGqycm+2DsdXIlhvIerSi3c7+1U7hJf9M1S94+phGWrNaJZEQMvctjpSu4OzEpAmNlDbZfqgnYfC7UerLdzuskso6hEJQ0qmwUwRVqn/kqvCZU+QdNMGdKAgN0pCQqMQDy/bQ6bCqzb68A1TyrZQlMwCDNwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY5PR12MB6429.namprd12.prod.outlook.com (2603:10b6:930:3b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Wed, 4 May
 2022 11:53:26 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5206.025; Wed, 4 May 2022
 11:53:26 +0000
Date: Wed, 4 May 2022 08:53:25 -0300
To: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH] iommu: iommu_group_claim_dma_owner() must always assign
 a domain
Message-ID: <20220504115325.GA50202@nvidia.com>
References: <0-v1-6e9d2d0a759d+11b-iommu_dma_block_jgg@nvidia.com>
 <f213ba6f-2cbc-e4b2-c510-16ef8ef0a337@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <f213ba6f-2cbc-e4b2-c510-16ef8ef0a337@linux.intel.com>
X-ClientProxiedBy: MN2PR14CA0005.namprd14.prod.outlook.com
 (2603:10b6:208:23e::10) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3665d51b-989e-4c62-cbce-08da2dc4b2d3
X-MS-TrafficTypeDiagnostic: CY5PR12MB6429:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB6429D18DE542DC4208FB1D80C2C39@CY5PR12MB6429.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5dCDOMSYlZgQ14+N8j6El79aHCg9TN/7Ng1t2cqK5yCYQw8yguArdUxcA+Nwsti5krAx08oLIMIJmXQgRKqLM8Qp4lzV1ree7BqZ5KX27iVeHYuFF5Hb1D6bX+FyHWGkGQH+UcPAhMeWDZLa7BoGqbAy8Z1RIbow8WMzWag5q/Xo0hkmM3KCmEUOYZBmQCznOIwC/AJKkuphhDXw4AR2honORsVZbdULBXIZj1TSKFYJMo1tLcbK6ziXS2KqY/fKxMHN1snT6ZooZpWJJC3zJikROYP0/sQI07bX+NZlGz5ki0By0n3ogVEmp6OlhfmDVCrvrDpdBvBDtEubxYo4M5vYPDsJR7vTba1xPxN+tvDeVQ0Ue7BD8FFlRl9bcXG8TKX0h5KZyw1gK11WE4Y4154u4UrYrybiCiJpRSVHIorPn6Xl8q1hEkobbqgEaOxoJMRoopOKvEqRlmZVawQoLe3VnqK5IN6ucm71mJAR4hz6n5TV+cTRk6YVwMBQGjmOjP/iBTa+SwLL+8glzBEaDEGjQr+cRFlFPZ2QEwO5uwATbNPnH4t1byvbWibykb6pnLgTDgFQ8TCk2JRhPcXMj1gIuY8XOdqM3KPOJLgl7+FXuuBXZ5eDIEfbAiCCnhiuh4X33ZOWyAFyh8SDRN0gjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(33656002)(36756003)(316002)(1076003)(83380400001)(8936002)(2616005)(186003)(4326008)(6916009)(6506007)(54906003)(6486002)(2906002)(4744005)(5660300002)(508600001)(66476007)(66556008)(66946007)(6512007)(26005)(86362001)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6rW5YPSX7bbZXgIUVugisD4B7wdTDRmgd9tB1N6xBnTvZj66+VDJ/hCwzNAC?=
 =?us-ascii?Q?JvL6Ln8TaFcyD37FHESlBy31VRlRe+kTzm6sCkqT0vOPIhqe+FJfuy5nTM5p?=
 =?us-ascii?Q?ijkMBr/F5Gif/w9meT51nwGsXmVV0GxswFGo9+n9o2yl3QZsXIjqceNQLnKt?=
 =?us-ascii?Q?RJMC0rEHRR/XwF9G2aUl5bXk9nIsuoeme3bG1/JpGkhuwXSjCG65Zm2BMRpZ?=
 =?us-ascii?Q?xIEg6Rf9pRr8TTkHhNP23yxkZrFFUpT9CeHHebB4EI7S3xVRKlFwvHAQku+p?=
 =?us-ascii?Q?6gO/yoCONvV41WdqwtKXStOVttmwmNfehoCMd4EScUNhjZm+4Cg7qs3yJyrv?=
 =?us-ascii?Q?mPp9uQgx/WUUFHamNQG+iapxOiEzcBVlvRDpxGWceXI9FEycqVqTfA/oDZ2R?=
 =?us-ascii?Q?kZXEyT9ypRsCMmTiSMISHJ9P/s843TZOFZFYAx8tLBpT55yUOkubq+fxwgip?=
 =?us-ascii?Q?MSnl+N7THk9D6mwUGPo8YE3fa57WJdH2i1b/0vYEvVDbUCUZlR0FDf6z2GO3?=
 =?us-ascii?Q?5xQZZKHBLpb0IV/jjgWPl8PMireqJfgQFzq3Hqk2p9QphSsLjEWaOcWdeFyo?=
 =?us-ascii?Q?OKo7D10a9lGUYAxRrU3rKRh1JWzPCFAYETccQde5217vIJxaFr+SQ7ci1EJ7?=
 =?us-ascii?Q?GEIjZ1IvJBadv6xNSLZ6Wti41rQVJjOzU6HYmopgNKQveXzSNcVcksFwHll5?=
 =?us-ascii?Q?PdVC4o8cYz0If1ItEg5c5VA7U0eqg9AHgnsQwdh5CtxbQjiDs7W2AsGGaRdV?=
 =?us-ascii?Q?uwZyKlsbc0F6govjyDuFR0B6sUJ3Xac8jrmqT6I/ffOXvO2DFFZrtyQsRmYY?=
 =?us-ascii?Q?JviG9JJvLzavTwVTUnn0khhB0UqHX7iotKVK6OSa3txsxTHdcRSbaVPyglBr?=
 =?us-ascii?Q?CLeyLxdIaLABeNyXlihLRFOBrPJZwpH5TNiXarI2ph4VaIZsiQztmAzXgPly?=
 =?us-ascii?Q?H6jwJRk9tNiyOcRwtNYqNIoN3YUYZgy/WP7BN8gBGHI1O94JgLd9YEzX1itn?=
 =?us-ascii?Q?PX+H2P6SVW2YAvPLVVWkl/kfSMMH6B3yamGn9CenZFzir2+/v25yO0tSwmG4?=
 =?us-ascii?Q?nBgrfiq34FGFO5NrXV9OqLimxfN55t8o1Qo7FppZUpcEm9Z2tYSMUCMBgMhU?=
 =?us-ascii?Q?zxfzSdssO7MjjMVbgCXNcx4+sJPzJj/GyHe3PrEuL+jNbOTIYBlMmmSptggs?=
 =?us-ascii?Q?5X5yDj8kL09madircdaq5YNmSA0vz9BrVyQK3Wxy6MqOZCW43FQGu4u81/UI?=
 =?us-ascii?Q?c1yz4NAmnODj3ODL7w2t+P/EJMm6Dvutp93eXycQXDz8DsWbpq8Lc+tWOJXw?=
 =?us-ascii?Q?m+fV27XS8kt9x9N4cAOGv/LVvZjZ5O3QL7Kp3fBwXZbZENKUgQ4vkRKXuYSa?=
 =?us-ascii?Q?dGVKVlv2M7kjcicXPxoi2717OGAUP6qYEJrcmUBSn+SiQ0F1Y7NCGcyiVVfN?=
 =?us-ascii?Q?jQ3Ee6mTUL7m6SQ6dFxS0AO3NzPCFPVc91WCZm0hD2IZCVvn+fIi3gR0uQeS?=
 =?us-ascii?Q?/frKNSCvcfV6eW6Hef1gS7hdfCiuWCat+ytZ/MYBnFUNu1rpJeZ8ZSR6Spp/?=
 =?us-ascii?Q?4Wml3JFyW1UbgQc1753uHMwY8v9Sy3zevXEmwkR86cKRcC0iQCErgAEVMXiE?=
 =?us-ascii?Q?rMPPpFUW5Dm5lHEsTGecPgZza2Tl17/iA56q0LUNbUSDVNZ/WRTrHuh7dDX3?=
 =?us-ascii?Q?ZpVKfYrsady7BtIjO33QsHfHkpyvvoo18I/AaMJE3j1rA8zSOFHNrxXP0Unw?=
 =?us-ascii?Q?YGnuAjqSQA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3665d51b-989e-4c62-cbce-08da2dc4b2d3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 11:53:26.4493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ugaRcA8/TRJb7bnTT5BmlzuJsXCk+OxHVOxQX9JCGd6N4hNR9yKnKYc7ABcObBHc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6429
Cc: Kevin Tian <kevin.tian@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Qian Cai <quic_qiancai@quicinc.com>, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>
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

On Wed, May 04, 2022 at 07:48:58PM +0800, Baolu Lu wrote:

> > +	/*
> > +	 * New drivers do not implement detach_dev, so changing the domain is
> > +	 * done by calling attach on the new domain. Drivers should implement
> > +	 * this so that DMA is always translated by either the new, old, or a
> > +	 * blocking domain. DMA should never become untranslated.
> > +	 *
> > +	 * Note that this is called in error unwind paths, attaching to a
> > +	 * domain that has already been attached cannot fail.
> > +	 */
> >   	ret = __iommu_group_for_each_dev(group, group->default_domain,
> 						^^^^^^^^^^^^^^^^^^^^^^
> 
> I suppose this should be @new_domain, right?

Yes, thank you

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
