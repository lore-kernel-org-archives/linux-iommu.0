Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA99FC43334
	for <iommu@archiver.kernel.org>; Mon, 20 Jun 2022 04:04:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4397740A9A;
	Mon, 20 Jun 2022 04:04:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4397740A9A
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=l0QqY1ne
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IzbhV4whDQmi; Mon, 20 Jun 2022 04:04:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 10B5D40A95;
	Mon, 20 Jun 2022 04:04:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 10B5D40A95
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E150CC0032;
	Mon, 20 Jun 2022 04:04:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 951D1C002D
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 04:04:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 517F74148A
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 04:04:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 517F74148A
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=l0QqY1ne
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1qwWK_JL2wFR for <iommu@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 04:04:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 56572410B9
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 56572410B9
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 04:04:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LhNaj+Qx9+oxBedJmnl8ixt2r0nQlYGh6wADagIIJ9/RE9ejhPTMqqfMADVFXn3GLKTRMbf8pPMEgeyBuXRWCAYepLbq4FuW4DplGRCHOyyH9i8bf0CALkxrPItTbRUnwZAwEuPGh0BXLqOrw3WtILeP6hGkfcTPfsjbs0lGinr0JHr3b/LJbO+/qaQNBmlyDaeq9lVvU9PlqindwKzLd/hht+5wnXbmdUJ7Dfwc56rIHrYpeh2wBs4UzjDDkE3tGkpITW+VJCp0QDAEaas6wMlPYPedDaGUIIpkq3udxcdQlC3PqNIE1TJurI+BZcDNxhjT0JJjkILxNSDWREyceA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EgDw4NMsj1gvem99xdvcTDQdxEi2vYfRDkB4HwVD+wc=;
 b=VveJJS4yXbg6cwJAz9k6eh7VSS8idmQTjnU4AhIsxs3DFLQ3RH3M2sTKok63+RMNBJa8UcnfDof3oSGRmzi4S4mvrJVNWt5WD7xsfweiGJwQMxhIrDKafxgYFjyH09bb2JS7L8MAqUgvrAe7UEu3dXdylT6nraVwbd/WpuOjGivfIpXR6B2Ycm9cg16ahWvnboDHiA3YcKhTMIHTMpPuUsLExsyjH7B5mZ81X1wAYqYYfQNexWvDcRHKA169v/CDWADbDRZUPRvTHWScSR+28M1ckwM5TbCeb5KkiSC9lGtrDlPedbP01TtTtVqnj2tsxvP92/PQm9qYswJPCTqtzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgDw4NMsj1gvem99xdvcTDQdxEi2vYfRDkB4HwVD+wc=;
 b=l0QqY1neuDY7qUXexsLdsGWP1b4+o3rJZjQjTZuPX6mpWY4D5XjLPRAJQoeBMAqWK+/FtJpUt++xFour4VDY26SDyBxmFoh32l6zx3w3llK8SpDPOwuxjflCLQXJxsyIbUEx0og3r0gzAQoVwaw9cjLdxqsvrlqUAfuQnRZfFA4Ydr28yi591tZdacFluiITj9UY/L1lhHlCOM6a/HjmjEqcY+Z5oBxSOdVs3bqYNw0xhBJN218b5oiLnI62+G0GAS/ErmwLfz/XB+b14pPh+bEJWA7PlGotZuQT3CRdYwVvvYxwCU92YhY5PA20UroGT66SPY5YyXJsz5bBMbHAKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DS7PR12MB5743.namprd12.prod.outlook.com (2603:10b6:8:72::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Mon, 20 Jun
 2022 04:04:39 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5353.022; Mon, 20 Jun 2022
 04:04:39 +0000
Date: Mon, 20 Jun 2022 01:04:36 -0300
To: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [RFC PATCHES 1/2] iommu: Add RCU-protected page free support
Message-ID: <20220620040436.GE5219@nvidia.com>
References: <20220609070811.902868-1-baolu.lu@linux.intel.com>
 <20220609124934.GZ1343366@nvidia.com>
 <bbada5b7-737f-03dd-7d42-2ebad442a2bb@linux.intel.com>
 <20220615154040.GA4927@nvidia.com>
 <6b8a4728-62c0-edb2-7b13-c4f01f5dc41a@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <6b8a4728-62c0-edb2-7b13-c4f01f5dc41a@linux.intel.com>
X-ClientProxiedBy: MW2PR2101CA0026.namprd21.prod.outlook.com
 (2603:10b6:302:1::39) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6d60658-472e-4d4f-2f0a-08da5271feee
X-MS-TrafficTypeDiagnostic: DS7PR12MB5743:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB5743471D81B0AA28180715A9C2B09@DS7PR12MB5743.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3k2tEHOKZN/LCOmlNQhTVf3SY41f8z+TjkRNGFAUjulwjpmO/6JviAGSTgxGnb7E+JAapEFgpf2JlXmbkVUYfP1VhIi8xpO/+Ei9gAT8UcU9KqccWdL+736/Sa+MRQVk8+KwY7gXhq/AGGBJRR7c+oGZfr81MR3jPJe1fsZgsNLWHc8eMsZOTVd2/aESQGIhyXypRjp7jhO6uZklb2DJDZCHHBaOog3Tl/kPyujlr8Z77U/Y6hCSRVsOykbpB9a0+gIhIjwlPS9tRtjUpF4FDI3I8U/MWiL3HrMTkYrVEY7WH9/luJnS/b6PArVwv8WkbBvTjTV056b6k8Vug6TRcUc2TsRgCHSCmtYotLLyg1XsbkRSCGfuuHOhe7aPCHrxCRVwuQ/h6SdOP4GPo79vhsE1awFyj4F9/46ZdUbJ9S825sWJQ4A/rd8C6bQ2xs4Z6GTfqGGx265HJALPEZkHrAJrKtBVDv2L5nD9MrxYv29UvS8R9A+1JyFhAs5R4LPAXdDFKy2w3CthZkrdPglRZXybFQS+mVz/vIdz41cjcrjzFDaJRS5DDYXdgFxPGTch7PCcDxGrTYTpKshH/D5PGLMFOVARtFLINdwWITBrtv43q29G8OMajt1M8qy4hnFpr7c838ZHgnidZDUr6QkJQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(6506007)(2906002)(66476007)(66556008)(4326008)(8676002)(478600001)(8936002)(36756003)(26005)(316002)(6666004)(6486002)(53546011)(66946007)(54906003)(6916009)(38100700002)(86362001)(7416002)(5660300002)(6512007)(2616005)(1076003)(186003)(33656002)(41300700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3YTvcOz9bMLQI0l0tqbmgTBa4PBbOVa3DnvrLJQVIyEdnvvW9hqqcL+ksxZQ?=
 =?us-ascii?Q?gwi+vhkM51q37CKPctWT6+6rvVgFYnxdaB9PLNZuBeNij2w+8kWBMWCA5r/t?=
 =?us-ascii?Q?zVBfJk5bFLdxHQlKpjDhKKQTJG6cUtM6iSPYcS9TWbfRgbBGPy16O6QwjmI5?=
 =?us-ascii?Q?KAfRT3okJUrT52NR/uPxub2SrUKXruiXbAqB+autGw9cRcIw8rFj+NmWbGCj?=
 =?us-ascii?Q?jziE0I+ZZnjCsfMwbgHDVeaGD0DA6HJlVxgX7rTRNVO57CSbFXnvicsSEwB5?=
 =?us-ascii?Q?cwrmuj0WGcNQk1wKHvC/vr8Kgk41zQm1Cftq87o85jf8lEXMiHeVPgsu0prN?=
 =?us-ascii?Q?6zyVORmJv3zdjZI+DDGRCcgO7N6WJxpPOnf9TFIQ5F89z7utkyfh026DxrNa?=
 =?us-ascii?Q?DxD/WDrNVrbLzuYaPhWBiltXpD7E/37IhJC/4TMjL1P/jIzUGgyOkHuPvNCd?=
 =?us-ascii?Q?g+Eq57g8Tfc+t47Jwmz845VUFRESh2dmo6EIZGaRzOLHQMoGAme8tpz7FL5N?=
 =?us-ascii?Q?AGQUD+3IYALNcHTvOi2L6Acrv1XFi8PoOR9wmvY6qVTfwjfwKe8vb8cdQz3a?=
 =?us-ascii?Q?2ENurwFtu9rWqYJb7QjSCQp+cK+G6bIUIKsEr/KmGM5mJuIxka25FLNFnNEz?=
 =?us-ascii?Q?jtdyNQFFKqPSAE2hS8wjv0d+mYjtnm7NBSkBT+BDDmW4ondL6hYG7JSLGGlO?=
 =?us-ascii?Q?WQGVvdXzM4D7IQcD6QIGLGhYTz731aWsblb67LTzKVxRRUC1pxmRfwtnvJvk?=
 =?us-ascii?Q?TQkG7SuKygRzeV83Pz7Vn3Gnku57Xz+P0CSf2toVsnwiLMkS+Uukb65/Ux6Y?=
 =?us-ascii?Q?/bFUDL6c7VQGBIY5OcR/g/q6FpztjFvXnw+Dd0dSbAUTR724wULmPapk8y9v?=
 =?us-ascii?Q?m1pQ5EyaoMrJtaGJ/kXgOT7Z2b1EiVvTrYUokmcDr7w6NkmCioHhE9+1GI7M?=
 =?us-ascii?Q?EeefZVzrdfRvqS2bRqc+BURjjPsAU14jXGIMf1j+XYFuyPlPvHR/fmzJ87Ni?=
 =?us-ascii?Q?ZvOwZAhF6LZ3y5EyAQDwtT0CUNCyZFLy3X2Wm3JwrsNpP/GXiSN5zySI9Yxi?=
 =?us-ascii?Q?cH1HQWv+NTXLusCKsbMDtECUHSfiJWkv7HVdYSnumwZVkfIRpBTYx7Yn9R9E?=
 =?us-ascii?Q?dfD2w+bIWVFv6OVOsddxxun0jWqjojDjF/EUBw5uEGZiY0yL1nFEff90uBao?=
 =?us-ascii?Q?b0lcodkqiHv6CyMz7gOs5UFmjzD3TNJuJFMrWkd8VSXN+YJ04B+HZBNLy7t/?=
 =?us-ascii?Q?/Nw/kAmO/7Yk7OroeoHp/UC4yGPn+UNzU+1K/UlbZa5XlW+gL582/eVlSEz+?=
 =?us-ascii?Q?b2Gv4XQ9SeY+wwr3eAIqyYLe+LAnH8FH2WxB/XAW7za7+GkaeQHFg4XGF6Fy?=
 =?us-ascii?Q?s8aD+3tJE3zu9MDSEXZxIiCZJVax4QsQZ/QO3vzn7Ox4aw2JdlEgO+mqD2pa?=
 =?us-ascii?Q?+wtjOORp4EbFS5L2xjRg580AaV1JpH0zwv1k1ltkhoH0t/Rw39Kgrn4XewoC?=
 =?us-ascii?Q?Ui09k8EbCHhzVDO8JImV6j9t8uJdgHfhMNHz0vogQDWB2GDl3vT8MY1Cr8PG?=
 =?us-ascii?Q?opuwpKB6i4pi0v4HkeRmXh+JmiMPudvqH01xd8VdhYuunwGV6IaYTDOadyTM?=
 =?us-ascii?Q?jYOGqkE78JqAXDGEJk4C2pFaHT/LnYvlBy9y8bkwxwW+es8iLW4vSF5819+p?=
 =?us-ascii?Q?f0X/MLsl4Ho9ayHPQUme8rS5Hnrd4GKlQ8mtn8UEFMe5c6zcfWqsQvsQBoT/?=
 =?us-ascii?Q?2yQH9TLzcA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d60658-472e-4d4f-2f0a-08da5271feee
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 04:04:38.9869 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m9fha3YSxuYbkEsXwFlKhrCjHKsFbaSjYYD0RUEUOMpnEnNE7kvXy9OAfDFf33tY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5743
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 Joao Martins <joao.m.martins@oracle.com>, Will Deacon <will@kernel.org>
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

On Thu, Jun 16, 2022 at 10:27:02AM +0800, Baolu Lu wrote:
> On 2022/6/15 23:40, Jason Gunthorpe wrote:
> > On Fri, Jun 10, 2022 at 01:37:20PM +0800, Baolu Lu wrote:
> > > On 2022/6/9 20:49, Jason Gunthorpe wrote:
> > > > > +void iommu_free_pgtbl_pages(struct iommu_domain *domain,
> > > > > +			    struct list_head *pages)
> > > > > +{
> > > > > +	struct page *page, *next;
> > > > > +
> > > > > +	if (!domain->concurrent_traversal) {
> > > > > +		put_pages_list(pages);
> > > > > +		return;
> > > > > +	}
> > > > > +
> > > > > +	list_for_each_entry_safe(page, next, pages, lru) {
> > > > > +		list_del(&page->lru);
> > > > > +		call_rcu(&page->rcu_head, pgtble_page_free_rcu);
> > > > > +	}
> > > > It seems OK, but I wonder if there is benifit to using
> > > > put_pages_list() from the rcu callback
> > > 
> > > The price is that we need to allocate a "struct list_head" and free it
> > > in the rcu callback as well. Currently the list_head is sitting in the
> > > stack.
> > 
> > You'd have to use a different struct page layout so that the list_head
> > was in the struct page and didn't overlap with the rcu_head
> 
> Okay, let me head this direction in the next version.

I'm not sure it is worth it performance wise, would be interesting to
know perhaps. But see my prior email about how slab has a custom
struct page.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
