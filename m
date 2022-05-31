Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A79C433F5
	for <iommu@archiver.kernel.org>; Tue, 31 May 2022 15:13:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 73EC984122;
	Tue, 31 May 2022 15:13:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cHcBDANOoKJh; Tue, 31 May 2022 15:13:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3ABAA840C1;
	Tue, 31 May 2022 15:13:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DAF92C0032;
	Tue, 31 May 2022 15:13:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8FBFDC002D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 15:13:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 677E640B20
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 15:13:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WspSv9nD2iXB for <iommu@lists.linux-foundation.org>;
 Tue, 31 May 2022 15:13:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::616])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2EA1C40502
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 15:13:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBRuZZp8Qi4CzAvJO2J43pSIodZNYWH3RVEoE3gOf9beNQL17snHGXKgvWwI27tPRIu8Wzvh+VMvJMd5tu7/lHwd4eC4UlWLxelkp0iax+rIv2lNnGZQJXpzzdwalHgHGAUCzBAziydK85rLi7YO9oHUYhoTMPqH5SL4xEnTd86FDSkr3QMMWQ9y+IBSZERASu3+sApQXWku8gWGJHsC/c7yP/VN6de/3ipmYL2X7EPLVns28upqIiDb0RYWROAkDt99NlsVZZNURQGT/mJD+qly1Uzfyai0mqMoTSpLLknPGoGxutBDXYRPvIQ7qmVBzLKeDY+UJ5UJ5B46r0354g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANht1PovPxPmwOS3jhAN6mauRAaC9vpmSzuZCy6I0ps=;
 b=Wfp++l8clHpXv09toGY61zzr4eMkqD8+lW7Kn6RwwOpAeiWgp/ByahxDcYlBv3481n3Y+bJapaPAXmxzwJ6NPvlHnH7IfBknCeVZVA7Rt3U+qCz0UiBeWXK5u3A4XMcXiCP73U337w/HGPXxr8qoZ9eAqcEti51/NESFwI0XJi0WYLyhbLd5/qywFU+09d3DhsAPDqaC5ZbJEFi4NavLo2KJ0RQr5B6uIiohKJoCAAjyYmyBN7XoH67N6UBlt+7mx/0bvZWyqCS9Tb5foisXgVICvoO1oSZiaFKnSxdpgB7buW1b9bdNdL08IFNVxGZoftEcEeS2ZMrZnQPnpFD4qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANht1PovPxPmwOS3jhAN6mauRAaC9vpmSzuZCy6I0ps=;
 b=tgjSUa946Zk11Ab721doNfzENtr0mJ5Sq67ZVB1n5rnxfZAree7dN7xGvjVWYnNvknR8LbbDSO581bDoiKHZsj0XZGgUChjsp4VGF/dPdyOn4HKJGl+jOh9YhlD1QLi0f4mPx3d+zLc95q7ygUKZ2pphly8GGL1iHLDAsdpgvfCHTQGm4j/pkQ5u8fz/q8/pbaL4sAB6Akwb6cisYSlrX1bIGM/yT1Za4tdvp0/GqtyVy9M9mX1r/jLU9I4K7qmWEE3A1tLhZPt3wQEZogQOSjx80LZggnSKwOITwigV6xo7SBUANnT7tzDcTEKwN0pA1AiZmLFsN6BJOiKUZ+l4mQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB4391.namprd12.prod.outlook.com (2603:10b6:208:269::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 31 May
 2022 15:13:34 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%9]) with mapi id 15.20.5314.012; Tue, 31 May 2022
 15:13:34 +0000
Date: Tue, 31 May 2022 12:13:32 -0300
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 01/12] iommu/vt-d: Use iommu_get_domain_for_dev() in
 debugfs
Message-ID: <20220531151332.GF1343366@nvidia.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
 <20220527063019.3112905-2-baolu.lu@linux.intel.com>
 <20220527145910.GQ1343366@nvidia.com>
 <eda4d688-257b-d12a-56c0-0f9d3a10ef8c@linux.intel.com>
 <20220530121412.GX1343366@nvidia.com>
 <42623a73-c288-1c0d-7021-93caff4ffb6f@linux.intel.com>
 <20220531131052.GD1343366@nvidia.com>
 <60318d83-e22f-f922-436f-6c31bce24d59@linux.intel.com>
 <20220531145301.GE1343366@nvidia.com>
 <a7d6d830-cb06-e0d7-0688-028f9af900e5@arm.com>
Content-Disposition: inline
In-Reply-To: <a7d6d830-cb06-e0d7-0688-028f9af900e5@arm.com>
X-ClientProxiedBy: BLAPR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:208:32d::31) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a649dd6-77f6-4729-ea40-08da4318211f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4391:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB43911184D602AD3D1EBB0DDAC2DC9@MN2PR12MB4391.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J/AJOyE4+9tYEolfxMkY1RX9b+OMU+dvfLxVuCsDBDu0oGvHxbuvLcg2+oO4IkU3qUcRqcEuWlwst+eDT614lM1M26kfQqoBGC6P/25b+2j69ddiisv8l8JG57h+BvbrqVt876mkYHih3UfBPzRpOU7bl8nP/cnKaqNnKTYsIwJecj8dNcFcZ0j6JYPhb0LZfwycn64ulxqPe6BmKlUw5kLbQ3/9QtIyb+jrwc6zKuPMm6426k4JfhGSkb/I29GLYEaqfFQKYOg+OjGR/aaxbOrexXHPtdBPIExE6VW7kugMe7u1WMbLfyFycw/V1s7KZnKq7nZLnG7+2gGJsYkiY3+OuD7nqwnz+5FwgyCCNK2jIgGNPgWqudeWe+cATJx3esgBwar3GxTO+EEKExmm/UUtavgSx/gHTZ7J2eDHpMAAe/Eco6OLnS98Uc6YpQuAYRVt8jf9yijIGHatTcS/CaKbPQueYh0VbiocJZSMDuEOy2cmhmjCURvEoKld/ethWlkPlVFZDWfXkrZTmVl/AaFee4i6bGpEd4pWSwvPphKnqmzlrCWOCzzDhwr1ScMTCiZMtzr7JA3qJRSqtaWBdKZFSEJPrdA5xBls1cD2QkNSW+GKn/isZLdTKM3mjx8cPaRqvQSzxzdFn2fuoylDuxg617ucyd9cydbVm3/QWQ6WUdn6H2s8snnLK2t3M0ljOWGQOpUuhvDPNq3mq08LjPk292Il7RvZ7/6lBPY31mU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(1076003)(36756003)(6916009)(2906002)(38100700002)(508600001)(66946007)(8936002)(966005)(8676002)(7416002)(316002)(186003)(66476007)(6512007)(66556008)(6486002)(26005)(53546011)(6506007)(4326008)(33656002)(54906003)(5660300002)(83380400001)(2616005)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RGuu19Y3a5+Oy4sHruTOYn9Bzu6uUvHVrW35M9ZeLo0733upjUHOjv13z16s?=
 =?us-ascii?Q?cl6rPRLa9LczWVdI/R43EWrTMF8ZXmaBTOHXDCtTultQhvwwoTMXuJjpyHuD?=
 =?us-ascii?Q?YLWYeYl1V27BONWJTMbhCbkp8H/9FeMHELUSqgyylXoikqwt0G568XHCmvAA?=
 =?us-ascii?Q?NWZI/DlTYAQcsuigmvJB82EkWejxx1IzrIP8SgqNv19lOdywKzCCdAvhSVQF?=
 =?us-ascii?Q?h6GYXnatSGqKHgj/1g8/6TPlQDoIwH871HMHgYKP3bXb8i7nUYwRHQgdnEuO?=
 =?us-ascii?Q?+gSTbaexS3xy0ZzL5D/EcifOvHGXOMCoU0tfhmvZ6rRD0CkYxcbeWcJ0W1/i?=
 =?us-ascii?Q?tpzs9Bg/svwhh+rPJzHSpKmkeoNc4TNAGS4TB2Jd49vqRhG4OgVtDDKcKjFp?=
 =?us-ascii?Q?V+Fg1UeYkrfy7jOOAp0ScPduAbP9YrjgFt4Vu7h1f6yj4Jc6CprqiCHYCB6j?=
 =?us-ascii?Q?uUls8MQq/wfY1AiXMLmYqRQU0WFe42wWH0S+0McNS1JLjKKVoaYiN0vFbWb1?=
 =?us-ascii?Q?B8ra64Z4dkJfvnouZ39KXw5anikZfFfNDCOW8+fKFK3lx14/+DQibePi1fQ6?=
 =?us-ascii?Q?fX2hG8VFOZEiTOmciRCNi4AUVD7wZOyZrsTtr24+wXLSKJqpL3g/YZ8LwVa3?=
 =?us-ascii?Q?2fuIMXK2fNsRdQVNBqK1JVmu91Qt/+fjl1qB6f6EqEfOzPTVi2qhlAt95KSK?=
 =?us-ascii?Q?00+Vkpxkg0nW2/PIco9hmImtCI/SMMegOkARnZUutCFAxf/tAebsYuoZZVId?=
 =?us-ascii?Q?wMC91l2vTHzT8uscviDNYRUDflkNmkWvFuAdwkISJAFvV5oziz6DEATP/135?=
 =?us-ascii?Q?ZMsB2EljqCDqGYWD8qdho7NefNiA31MA6FvjYAQw74xXBaJvIG/2KNnrSA6R?=
 =?us-ascii?Q?MyVpZrn8EasuSAdddVVPOQWC8zCI1zSnLlg+O73WeltV8GHiujHnaQAx+yaz?=
 =?us-ascii?Q?mKs8x+f8Hl7dXMwOBiH1NjAFIih+QAmPdyO+eRbci63hazGGRXRqCPH836Fo?=
 =?us-ascii?Q?BZDckqHwqGsNHdS0RtCpnSd1RQPh/JCYsnaeQKjXeCjp8piHlrAi9PNFv5WU?=
 =?us-ascii?Q?D4wKHAsPREynVDqwlNF7CjdRyDa+c7oFcvoaQCSUBTso5FtU96b7WKDnQZz3?=
 =?us-ascii?Q?rC1+uqZkMmMFwM/fErETiczBIpd4fgAt8pOlm2yXMuS2DwgRv5WI48zG3054?=
 =?us-ascii?Q?Y/TX+MlYjrDcgwdDke4D9fJfHjFErcn0wiG4EG6fNDBDjCItcfoVZAl7FDYp?=
 =?us-ascii?Q?ZHv+Upf3hwdd2QGcsuGh9oCDvsleZpAkLgO3PyvcsIYmRwOYbRlKqrGXDLgM?=
 =?us-ascii?Q?Ywq+zAdOf79EJzC1/daTuNlBhDEYEArxJeZxN3qC7UIj3Yw0u9EKLFMQP1vK?=
 =?us-ascii?Q?hbcsHz+07oVE7/9MrR7XWtj62wGGFNXhsJb+eh/tolHgs/asHxn4RZf2dwtJ?=
 =?us-ascii?Q?mTB2lc/TM6UZdyBZW5K1qBWQ5JQK2pXseUOEo4ewcp2e+PbqnW9Oi8Ynyekk?=
 =?us-ascii?Q?7FlLtFPLXBun3h6F9S2nsifyyntviAW6FehRLKtqQ10JSfVimXCc+E4tH7fv?=
 =?us-ascii?Q?qGW8T3OB98TnfPul+lLJgHdgllD3ZFagWIYMR02KtS2GUHqA0Rlv2KiiUsAF?=
 =?us-ascii?Q?Sa2GVDYo2LPRPHxIRqG/arHpfVhn8SJgEdIgDIxPQJkbO5+lYM5qWGzWZU7O?=
 =?us-ascii?Q?cKU+AhnZ8urvRt1qENgwV4Ug9Ajzde0YmvWgN30UmGdrhBXKN3fAQTykPBuQ?=
 =?us-ascii?Q?yWmytZO+vQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a649dd6-77f6-4729-ea40-08da4318211f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 15:13:34.1299 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ONyiKcUMU0sMtAiWsnnJrqcXGeFzyE4tzw8wZ4rFvPKeryPJAk7zxN1CeG10+pGt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4391
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
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

On Tue, May 31, 2022 at 04:01:04PM +0100, Robin Murphy wrote:
> On 2022-05-31 15:53, Jason Gunthorpe wrote:
> > On Tue, May 31, 2022 at 10:11:18PM +0800, Baolu Lu wrote:
> > > On 2022/5/31 21:10, Jason Gunthorpe wrote:
> > > > On Tue, May 31, 2022 at 11:02:06AM +0800, Baolu Lu wrote:
> > > > 
> > > > > For case 2, it is a bit weird. I tried to add a rwsem lock to make the
> > > > > iommu_unmap() and dumping tables in debugfs exclusive. This does not
> > > > > work because debugfs may depend on the DMA of the devices to work. It
> > > > > seems that what we can do is to allow this race, but when we traverse
> > > > > the page table in debugfs, we will check the validity of the physical
> > > > > address retrieved from the page table entry. Then, the worst case is to
> > > > > print some useless information.
> > > > 
> > > > Sounds horrible, don't you have locking around the IOPTEs of some
> > > > kind? How does updating them work reliably?
> > > 
> > > There's no locking around updating the IOPTEs. The basic assumption is
> > > that at any time, there's only a single thread manipulating the mappings
> > > of the range specified in iommu_map/unmap() APIs. Therefore, the race
> > > only exists when multiple ranges share some high-level IOPTEs. The IOMMU
> > > driver updates those IOPTEs using the compare-and-exchange atomic
> > > operation.
> > 
> > Oh? Did I miss where that was documented as part of the iommu API?
> > 
> > Daniel posted patches for VFIO to multi-thread iommu_domin mapping.
> > 
> > iommufd goes out of its way to avoid this kind of serialization so
> > that userspace can parallel map IOVA.
> > 
> > I think if this is the requirement then the iommu API needs to
> > provide a lock around the domain for the driver..
> 
> Eww, no, we can't kill performance by forcing serialisation on the entire
> API just for one silly driver-internal debugfs corner :(

I'm not worried about debugfs, I'm worried about these efforts to
speed up VFIO VM booting by parallel domain loading:

https://lore.kernel.org/kvm/20220106004656.126790-1-daniel.m.jordan@oracle.com/

The DMA API should maintain its own external lock, but the general
domain interface to the rest of the kernel should be safe, IMHO.

Or at least it should be documented..

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
