Return-Path: <SRS0=VyMr=O3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D12EC433EF
	for <iommu@archiver.kernel.org>; Thu,  7 Oct 2021 11:59:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14F5C61248
	for <iommu@archiver.kernel.org>; Thu,  7 Oct 2021 11:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 14F5C61248
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D7AD5409EA;
	Thu,  7 Oct 2021 11:59:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ki-LZSBnzM2n; Thu,  7 Oct 2021 11:59:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AD0EB408F3;
	Thu,  7 Oct 2021 11:59:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81AA4C000F;
	Thu,  7 Oct 2021 11:59:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F70BC000D
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 11:59:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1DEC140995
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 11:59:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9deYStewrGft for <iommu@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 11:59:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2C551408F3
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 11:59:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pi2iarTM5j/+aG5woaTM7xD4LoMDj8FHmIc8fj1vaxbSQ4bpuvz2gLHgUBQt/SK+4Kuef7Yci1DLZeJQl7E4BWn1S0VdMnN4nPQuumH5bNgNvrCr2ohnKjSSzF2W/AA00mnbLhSTWqxxoIRB7CukC4e0sd8pyKM8uAFPqXXCl5m9QBXAMmiqSjhTwK7i2uRv4oaXfilpspNJnbK2tjQ0iksMsddlv4aVnjBm7BqqLR4T+lQfD/gFx8yPkbGHjwPsWP9yY+At9HDqJLfO7CccJdn0apWjcMGgY5groyxsvJobvLydUFjwLZ6cI6Zn+ajxOXvA03ugYjOI1352sZu/VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5V8yo7ZLFlO8VRpiR0js9rlccxdm0HxGmUrcfvYldfg=;
 b=MV01CBDo8yY2qHUGu9cjL5HKv46J1oDqfOGU90qt87uock+/fwM8zNJB3oAGd1viGhOn6qq2gnovcPjy/6lJSVXFBMoqv0SsBPGm6YH5V6W9icjUldj1nLqI4VOqT/pk8r5e87MBZbyBzVV5whAUR7A0xovXoOWrF7qKdrIVZjQhB4q+0GhPsC53iA5Jv9uQwtGfCZwe4ckCgNHvutiGfotYY8u0Yz1z8ax6sPSLBTR6P0quj9QvzB6qTC8pQLXf9DWhiLCfVHyuj+QuY367qPFdFmT7jTxDh479gUm4hGUHvXexCl003GSIHrI64UqtZ6Ys3UmYRN/cOWA1KCWHhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5V8yo7ZLFlO8VRpiR0js9rlccxdm0HxGmUrcfvYldfg=;
 b=NdohT6rZXCHv1jZCfXIb1iDL+e2JcDdcQR1ejrorvT8AeFff69zpwn/yZzDH9sv0Tk+YQ5b5wl1Lpo6QV/lgyYIFHqq8a9j2goVSZH35ku1bMgTvtRmHoNdl3i40/s8VjUbiIy9h7OrFroby+qk6N1gbxljoTuVo6/OS8h//x102HbJMNfEwRIxw00C0SPLZlKMRurHtR15wwx/ByL4EeJZGdPeHzWpN7+Rf7NVG8ry9YMYwQP/VtWl+YHjS7x71MERXlqX18ZJr+XCXpmQg7ZzQBNZS5m93Fe7Wl4b6lfXxXbNiOKkFkdVLG9JAIS0uovRJgRt0ICGzW3ueUjvvBQ==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5253.namprd12.prod.outlook.com (2603:10b6:208:30b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Thu, 7 Oct
 2021 11:59:19 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%7]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 11:59:19 +0000
Date: Thu, 7 Oct 2021 08:59:18 -0300
To: Barry Song <21cnbao@gmail.com>
Subject: Re: [RFC 0/7] Support in-kernel DMA with PASID and SVA
Message-ID: <20211007115918.GH2744544@nvidia.com>
References: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <CAGsJ_4z=2y2nVStXP-aAPnQrJJbMmv78mjaMwNc9P9Ec+gCtGw@mail.gmail.com>
 <20211001123623.GM964074@nvidia.com>
 <CAGsJ_4wfkrJp-eFKiXsLdiZCb3eS_zqZtJvXQTBafoTWY2yWKQ@mail.gmail.com>
 <20211004094003.527222e5@jacob-builder>
 <20211004182142.GM964074@nvidia.com>
 <CAGsJ_4w+ed78cnJusM_enEZpdGghzvjgt0aYDPpfwk4z7PQqxQ@mail.gmail.com>
 <20211007113221.GF2744544@nvidia.com>
 <CAGsJ_4x2UEmNXCVhJAVRyB8568VMrTkOLeVCNp8CyP6xZJwCig@mail.gmail.com>
Content-Disposition: inline
In-Reply-To: <CAGsJ_4x2UEmNXCVhJAVRyB8568VMrTkOLeVCNp8CyP6xZJwCig@mail.gmail.com>
X-ClientProxiedBy: BL1PR13CA0213.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::8) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by
 BL1PR13CA0213.namprd13.prod.outlook.com (2603:10b6:208:2bf::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.4 via Frontend Transport; Thu, 7 Oct 2021 11:59:18 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mYS3S-00BsBf-1i; Thu, 07 Oct 2021 08:59:18 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c0476ee-3ea6-45a8-7cc0-08d98989e4a4
X-MS-TrafficTypeDiagnostic: BL1PR12MB5253:
X-Microsoft-Antispam-PRVS: <BL1PR12MB52536F12558FC451E6599C01C2B19@BL1PR12MB5253.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PyKmhnZsmDQZpMp763jd5ZPz7HkUQPkeoDaB3nFLCtqKorU8S13cNHaH1RtB8CM5NTxdekoH4oLYQBmxPA29+6MjI1UGK+n2HgGnjY/huPaGwLjcuJ6lLz/qSAD38XRKohqW/gP3U84i8YaYEZpE22FqakUxQih/CoXbZdByLMMETFHbUnQBVtPb2d4N7c3tRBaDd19Rbv0ufULpjc7u16yZggdlmjkyrubOgqX5J/SwM6n4PLPZQ96xiTKdsblytmMSfe1bkrVcaaeLeWAXcG4L7Esr1yeylAzinzZC3Sh3EHRVNHiHVzbeVDH5GH+eD73s93Tlc2wuU9iMIPJY1nYtbuSGSaX6tquvhTuPTlT0O4k+PW2o/Sejaw3uiZWx1yZbhAVS9fmzpEATAJUY3AeRgUUnDorwC62WE2gksVeVeAWKGcXVRU1BlaWp/xgkk5SDdGgYzWSGRlpgxJGW2RnX1OWJMRMKwR1qV+Ziij3wWMvqHYBxJMlIWHa00fLI655XeG+Qn/iYhl28YpwX+u0CBjDObPeotS6JgYld9FRSOB0n0dqQ8b9FtFjyFmxd4jK0xNcEgGJ3PpBUmhs3ADkstnwsJ7E8LJaKlzZefEoEpbWsC2QK7z1udBp5zDdnzUw2Tc4OURJ8RALlZ2C2XA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(66556008)(53546011)(66946007)(86362001)(1076003)(38100700002)(83380400001)(9746002)(9786002)(8676002)(8936002)(2616005)(4326008)(6916009)(186003)(26005)(508600001)(426003)(5660300002)(2906002)(54906003)(33656002)(316002)(7416002)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UELDpzl30IqRfBwkgd/zvc4UhrFjIAE8JxHo0t2B98+8XgLmYd6pMQmPqODc?=
 =?us-ascii?Q?1BLOJngBf3O9zYYJDqTeHucPzO+tkgcWy7Dblp6S5++mDBwji+hAF+bt7UgI?=
 =?us-ascii?Q?nOTzpMw8lUCrf+il5Z5TcaFu7RX/C0lvyKBFTN9vaw0kYZvIRNV4XZTJh2Wm?=
 =?us-ascii?Q?EmIh/1eBX8lR3B1DETouUi5+BPcFNVaGf/uQcBqHf6dX9x01qCZNzesQHlSe?=
 =?us-ascii?Q?D9VDpTTPamaJ3NAGCGIVei6/KBXTJ0s86i2VUJtJZ4kObIrFleCfGdaUkb+e?=
 =?us-ascii?Q?JbseTemkuSLjFWjb7T8G2UUTIo241bNztI+UXWadBrfFthRsnoGbz2T6OzzU?=
 =?us-ascii?Q?UZ2RenrvUkDD2mNHCRskOsxot2fYkuwQp4XAjW13z/1lo5IE52CJzxSjl3u9?=
 =?us-ascii?Q?2uuS25Klakkl6cBdKKQHN8BwWcvBUMXq5PhWRGsBgbvM+/8Yotq+Jsm0YTKp?=
 =?us-ascii?Q?kLWvk/Et6Zos1VkwOzlMLIPADSsBEcSHe7P96T+AwhsafadEAW3nLFauDvrK?=
 =?us-ascii?Q?oGRYRAmIYBI5mrF4l1Ufd55IqVOMg1bw5n4Z94OmvlZ0EMFrCzd/ugH0c4BV?=
 =?us-ascii?Q?7DXo+7lRn4KJjTi7vedCbvmwc6ApmS0TuaE2QpUmzvmKzhpqkkVmJmVHagc0?=
 =?us-ascii?Q?iX+n9HPBworVaLQBZU+/yBrb1ej9HYF2e9BetqrmoNmDS6rItTWo7cUDyMzp?=
 =?us-ascii?Q?5d0Gnj5gCLiBmD/XJxt+jJ2FLuT57teXQGJqsl/av4SM695HiLjDZGe4q9tB?=
 =?us-ascii?Q?0jiUFz2CLInvQo0Z/i3BAWLHW9aB72NRdlivsSalvF3SjWhYZPe44VkJWK0N?=
 =?us-ascii?Q?Thwzgp2kya2OxYiN0oUzB8Rt5088CzO6grlz1tfjFA9D/dAldYo32e8KbWR7?=
 =?us-ascii?Q?lmnRPjVfny6UtDTZNqTca479JGwzDWW1BLgkstFzUkfriQeKxTpsjGyZg5pU?=
 =?us-ascii?Q?8rPqpRDONMSBsqG2LvAm08M/FyfuvjmRMGcasvRcOyB/4Nj16fxjHbhPfxJ8?=
 =?us-ascii?Q?cMaOkxp+uP/weJ2hXskw3tWKA9s2SSrxJjVb9CfKpPXSBy5PQmVz1cLw701h?=
 =?us-ascii?Q?cbot0iItaHydWlIBqMLiWheaojLBIov/tIFTeOkgGbOS0btEyfjCGSMtl1Ev?=
 =?us-ascii?Q?b6tudkL8f+GD4yRxmDM8VC02JjX9yUMy3m8F0TEkEoWGqfY1ahf2juznuzup?=
 =?us-ascii?Q?WI7TSpKJxfMkx0MqihuUhp6tw0TgtOsIHLLxwSVikWamUKll3HuiZOiWY4Ee?=
 =?us-ascii?Q?ENFu/VEDKXu0RrVA8hzNK9CD3BEJSKdM6wYgs70lwM/NqVGc0Vs0Flz2+FuW?=
 =?us-ascii?Q?IffW6n0lZkj2DrVgaD9uio0DLdl0mds6N0ACXdaWOjZq3g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c0476ee-3ea6-45a8-7cc0-08d98989e4a4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 11:59:19.0440 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tJG7hxOIKy16KXlbg+4ejjIEUHRCEnIV8LPPW6NU6N218eZsdR3RA3CaFNHjJh1r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5253
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, Tony Luck <tony.luck@intel.com>,
 mike.campin@intel.com
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

On Fri, Oct 08, 2021 at 12:54:52AM +1300, Barry Song wrote:
> On Fri, Oct 8, 2021 at 12:32 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Thu, Oct 07, 2021 at 06:43:33PM +1300, Barry Song wrote:
> >
> > > So do we have a case where devices can directly access the kernel's data
> > > structure such as a list/graph/tree with pointers to a kernel virtual address?
> > > then devices don't need to translate the address of pointers in a structure.
> > > I assume this is one of the most useful features userspace SVA can provide.
> >
> > AFIACT that is the only good case for KVA, but it is also completely
> > against the endianess, word size and DMA portability design of the
> > kernel.
> >
> > Going there requires some new set of portable APIs for gobally
> > coherent KVA dma.
> 
> yep. I agree. it would be very weird if accelerators/gpu are sharing
> kernel' data struct, but for each "DMA" operation - reading or writing
> the data struct, we have to call dma_map_single/sg or
> dma_sync_single_for_cpu/device etc. It seems once devices and cpus
> are sharing virtual address(SVA), code doesn't need to do explicit
> map/sync each time.

No, it still need to do something to manage visibility from the
current CPU to the DMA - it might not be flushing a cache, but it is
probably a arch specific CPU barrier instruction.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
