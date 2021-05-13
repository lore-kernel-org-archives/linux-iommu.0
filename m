Return-Path: <SRS0=YXze=KI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48AEC433ED
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 17:33:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 316626142C
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 17:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316626142C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BAD9B8455D;
	Thu, 13 May 2021 17:33:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6wJFMJ2tGMRJ; Thu, 13 May 2021 17:33:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id A42598455E;
	Thu, 13 May 2021 17:33:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A6D0C000E;
	Thu, 13 May 2021 17:33:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23D5BC0001
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 17:33:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1F0E0403DE
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 17:33:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Id_c1WoapD_x for <iommu@lists.linux-foundation.org>;
 Thu, 13 May 2021 17:33:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::610])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8D8454026F
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 17:33:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bOPzJo5r4PM1qwLqANUfd7lK0GSHiHB+ermwEfHO7zKJLH7eY/2kuQFHm5rY7EpYhw0FpYPKz9dkru7tzcTT+BkW9owfR35SuXprCzsHdyJ4rw3E2p7f5WTWTtY0kBChsisdpr/zByauwYFTD4v/rBC7k9bq/UHsv/MDsvVzQKM/CFLVlFDFdAiomDEcw/QoQRpnmQYnqbSJDWpkQjxfSSY5Cv9JfQlXGMEsvimAZdaI+yRDbwz/OyaR9d56Uym69MwEnIpBgLJp3x1Q4veU5/d+F4NYcJqhmo3qkcs7KQJ66dClBWRHqvTVfxQytw4t/Gmr1uBh/5YGrqpn27RrzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6gk7OCnWs1PR9hN4AhqkKefxyKid2l90DXeruNiw1Q=;
 b=FBpPNz9n73I5a0ZTIRgxlYP1kT9LeOYBUbvuRtQA7XBpu+47pbfxzCrAn2/KyUY/r4vtW7Yx6FBmz01Hhwmh/m5YS2TjJHE35NdocxgGmKVCKYUqjRwfQf5OtrAwl3RXMtW0V2UdqPErHyLxyZv95/rD6Qk4U5p3RYk+igVGpPO0/2/NlRjvtwe0+xafyiHWFjh4d6vg9/TdCpMrFXAL+YfzHclsM+VBLiYvfCnVuSaXkCZdW14LBs1cUpWL/GUPN/lUvu7W2rW+Kby7yBUWbrFDZJP1bJ86sQV9W+fupaXprucPMI5okzIAtC+FuBxtjZoa/TZ+kw+0W34y3n1txQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6gk7OCnWs1PR9hN4AhqkKefxyKid2l90DXeruNiw1Q=;
 b=DcSrnvaV8TThVxuMns8sNDUfRK591NdYgCxAKxQX9ApcDQ76Jmmn/YHcfpo61d+koGABE0R9VVNPmLI6Gv2SGpwN53aTt7E4k+M+BPjBRZzvAL/3C0S8Ej4Q6hNLPANlU532RiVSyDnJoStlkzneH6WjL5mGJa7y/1CjUJ7NkFL+lT0gMea3ulcFE0YuAc7chAkWSePSbGxiVhMn4xVPxHv++9I8H8eFCwMs76BG/242ObJ2c/Z7AJrQtnnkVjug4HNVdd5aVpG6e2KHdPh3xBeUBWQ3J4RpQwpjuCPeUCP0rkIXzqCEvHET2iuDQ1Cy5H3vJcpkzVkU6aAoXc07sQ==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1433.namprd12.prod.outlook.com (2603:10b6:3:73::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Thu, 13 May
 2021 17:33:05 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.026; Thu, 13 May 2021
 17:33:05 +0000
Date: Thu, 13 May 2021 14:33:03 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH v4 1/2] iommu/sva: Tighten SVA bind API with explicit flags
Message-ID: <20210513173303.GL1002214@nvidia.com>
References: <20210511114848.GK1002214@nvidia.com>
 <20210511091452.721e9a03@jacob-builder>
 <20210511163521.GN1002214@nvidia.com>
 <20210511110550.477a434f@jacob-builder>
 <20210511194726.GP1002214@nvidia.com>
 <YJt3tGlzFK3b4E82@infradead.org>
 <20210513060012.0fcc7653@jacob-builder>
 <20210513133834.GC1002214@nvidia.com>
 <20210513081050.5cf6a6ed@jacob-builder>
 <dd52760ab65a40328b4c1a26ddd0e1d0@intel.com>
Content-Disposition: inline
In-Reply-To: <dd52760ab65a40328b4c1a26ddd0e1d0@intel.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR0102CA0072.prod.exchangelabs.com
 (2603:10b6:208:25::49) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 BL0PR0102CA0072.prod.exchangelabs.com (2603:10b6:208:25::49) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25 via Frontend Transport; Thu, 13 May 2021 17:33:05 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lhFCp-0077qy-OJ; Thu, 13 May 2021 14:33:03 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3ad7715-8bb8-41b8-c357-08d916352a7f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1433:
X-Microsoft-Antispam-PRVS: <DM5PR12MB143338859FB5F171AA0B332BC2519@DM5PR12MB1433.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G63U4ALDWK0xusXqJ/ZiINCrcnxOPZ6GUMROVWo610dE618300PzzpTfcFWiHSkTGVTLIyPzZW+kv1MGmm3XJzjZB1BeDKrxy5T499HmoIbrRWmx9Z18LPfm/k1HMeyedglS4jkZ+eZkrNXKCQHZsuE9n0s/tUkX7r+pHmP/rJYHLuqamQgws5uAfb2ur4JSZ7zjqTiOKfwvT5jPh4XQJBESx+RPYo3Acp3bQuxZJyHpF2DD8Mriq9Xqf9lshtFDPjGTF14g9bVRkh1PFApCytOHe29slkU1MUfB1kjZrJgE+1g6LUBTH9/cxv1ftODZUg/g9hjsxf/aPhoxFqQpos93cUSYKA+ymhP7Vb0bEMan7X5hFaWqhxb4f2B/UCPGO2XwRqPPAwU0npNttk/26Ta+5drBlHwvtF2IZa4rHtDWuqgGPoqSH74TRNhsoQhlJR9BUhs239t7ue83pw3H0cEZyuND7VlK805Ngt7l3f7HwJyV4/FYu6+VXHVqXfcAElO6r5zPsWrEY3IHk0nmaB17dM77ILeTeUUYOhZ8jS2ukuvMYKPmJReqPqLGvvxNbDB8mEMmXIbVpAQOrzA8AuznitF374+rGzxdmn+wCEo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39850400004)(36756003)(86362001)(33656002)(38100700002)(7416002)(83380400001)(26005)(66556008)(66946007)(1076003)(2616005)(2906002)(4326008)(316002)(54906003)(6916009)(8676002)(478600001)(426003)(186003)(8936002)(9786002)(9746002)(66476007)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?SrAzC7yBRRsjRDwQOOI0lqKnPsRh6o5eZz/a/E5H22KqzGD/aYDdaxpoPn5E?=
 =?us-ascii?Q?f94eoAl+Gqm7ux8xU0LrZ05n6YflcFNro11BG9c0Yvj6ORTW3PFgsamlwaRJ?=
 =?us-ascii?Q?x9G7IiuE7scr6uCMF6OcfCEM/oLdnojTTozxdqepMr9spRZqkWe08x1WwTjw?=
 =?us-ascii?Q?a5FYVIm+8oznrMxuJcKgHj8FzKnx+OlBjPOdp8OpQRXjxxu2B0outbpy145F?=
 =?us-ascii?Q?58s+mBxeURia1l3BkTfCXAd6zbBpwPpq8O6h2lR8RaMfqBBKHyYDj2KXNBOl?=
 =?us-ascii?Q?fZ4G63OycAajiOQ65EC4OQey6B8bH5iVtmVn/NWo+ZBOjqGpPbs3Qwbm2AaN?=
 =?us-ascii?Q?yuGzFdFAOoC1ptgClzAvAKKu4GCDiWh4hXv8wrUcviMbt6QY7RzLq4VpX7F9?=
 =?us-ascii?Q?JVoxBk075sULw0uYrAPGWpyhSg2CeWxYih133zWtBlmfotRlSzVP13eCDtVB?=
 =?us-ascii?Q?GdFNt6s2rJh/rQ75CGCX8DErqpauPmv1Rru0tLRZpn13fr3xOOiQle33XBcC?=
 =?us-ascii?Q?mRj2LVlWTiqttgivR/YDmPNMhidCuT4nNDy0tntBb9mivHTDEAx9bV7Hi3gh?=
 =?us-ascii?Q?RJc2wHg8fLwWAIGbhkdOVqw1cPbAJDulK07QRTPf3KSASJpuZHC1gfqEwvoi?=
 =?us-ascii?Q?bgp87Ce+Im0Hd0wretRG6f9wRorGdm+BFi6I9OAD6WpiVbDZtgJK4r/K1kdK?=
 =?us-ascii?Q?JrPaBSy/KCMtm+/AbyczXcXgkbpq6HG+7RF6hv1ktkUteynUWCz8LLZF8wej?=
 =?us-ascii?Q?7yIxbo57BHBmS/eTA63ZQLrqtEGL0BikfBIYA+RG1An8hilUMmdUOcQG/5ju?=
 =?us-ascii?Q?Uhf4cETmxlRHuGgJzttMnFr545wZQp8Y2a8VRWzvGYFkCCTL5rwVfzYoFSL8?=
 =?us-ascii?Q?EOFheS3hm1jbxNE0u79f15bCnKYGTmg0s57O2mCi2wxuQr0shzhc0QB8INfg?=
 =?us-ascii?Q?rQEXrA6AwXBdB9srcY8kOY7oLPnRRiU81hNzqrN8VjFnBfg2tRDwY5Huv046?=
 =?us-ascii?Q?824j6wbwqWsSCNJ3IN3r9KarbyX+Y7YH3KaEq5fCZKVSSl9GjQNs3bAaEN89?=
 =?us-ascii?Q?fcdbF2G0EbwoXSpiLrtf0xcHUIG85tWgUBOsIl0yJa7UrCGRkW04TWRazlQh?=
 =?us-ascii?Q?i8/HgntSw9qGKBX+RpaqxN2J+yFzpth4aoGTTrNoPIl9jQgJy4FBzWZAY3FO?=
 =?us-ascii?Q?Cd/gZuLa9vMyuJmoeWq5NCWchHPIvu/eYKvaT0nksKqoLaTvAhqAZ3or3V4L?=
 =?us-ascii?Q?LAajJELpMPpULorTo0Q3xtpLm87mzHNaqJdcecob7ZzWyFlHVR5DFlJKVFFN?=
 =?us-ascii?Q?DQd/W99XKxamN8nZ2RBmTQ5k?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ad7715-8bb8-41b8-c357-08d916352a7f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 17:33:05.3938 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AjX/WMHlmCA0MpiB8BORFY+SrVtyz8djgraqKyvEYGmJFvcC1YFoE0UtevFflKtK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1433
Cc: "vkoul@kernel.org" <vkoul@kernel.org>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 David Woodhouse <dwmw2@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, May 13, 2021 at 04:44:14PM +0000, Luck, Tony wrote:
> > For shared workqueue, it can only generate DMA request with PASID. The
> > submission is done by ENQCMDS (S for supervisor) instruction.
> >
> > If we were not to share page tables with init_mm, we need a system PASID
> > that doing the same direct mapping in IOMMU page tables.
> 
> Note that for the currently envisioned kernel use cases for accelerators it
> would be OK for this system PASID to just provide either:
> 
> 1) A 1:1 mapping for physical addresses.  Kernel users of the accelerators
>   would provide physical addresses in descriptors.
> 2) The same mapping that the kernel uses for its "1:1" map of all physical
>     memory. Users would use kernel virtual addresses in that "1:1" range
>     (e.g. those obtained from page_to_virt(struct page *p);)

Well, no, neither of those are OK.

The page table under the kernel PASID should behave the same way that
the kernel would operate the page table assigned to a kernel RID.

If the kernel has security off then the PASID should map to all
physical memory, just like the RID does.

If security is on then every DMA map needs to be loaded into the
PASID's io page table no different than a RID page table.

"kernel SVA" is, IMHO, not a desirable thing, it completely destroys
the kernel's DMA security model.

> If people want to use an accelerator on memory allocated by vmalloc()
> things will get more complicated. But maybe we can delay solving that
> problem until someone comes up with a real use case that needs to
> do this?

If you have a HW limitation that the device can only issue TLPs
with a PASID, even for kernel users, then I think the proper thing is
to tell the IOMMU layer than a certain 'struct device' enters
PASID-only mode and the IOMMU layer should construct an appropriate
PASID and flow the dma operations through it.

Pretending the DMA layer doesn't exist and that PASID gets a free pass
is not OK in the kernel.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
