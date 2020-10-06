Return-Path: <SRS0=boqS=DN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C2DC4363D
	for <iommu@archiver.kernel.org>; Tue,  6 Oct 2020 22:19:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36EBA208C7
	for <iommu@archiver.kernel.org>; Tue,  6 Oct 2020 22:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="pK2ea/DD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36EBA208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8E7BA2270C;
	Tue,  6 Oct 2020 22:19:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AoC+sGxWg8Ui; Tue,  6 Oct 2020 22:19:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C642A2002A;
	Tue,  6 Oct 2020 22:19:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B980CC07FF;
	Tue,  6 Oct 2020 22:19:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3D58C0051
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 22:19:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B16C02264A
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 22:19:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZuvAhUYGDocU for <iommu@lists.linux-foundation.org>;
 Tue,  6 Oct 2020 22:19:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by silver.osuosl.org (Postfix) with ESMTPS id 9251D2002A
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 22:19:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHWNjGV/BtTptwOTY2Luh8Zb2beLzkmft3OsemzXzWgXbL5iRgjrrbfViO6bko/2MCM9wmUxLtx28qIfDBauQvAyZBnE7O1z4FgZEURIfpJBZRDWxBchSPqImfufQnQwtSlYZqoHQ1344M20hrmg7g2K9nsR33uf/vMgZNZiof43V0jkw5Ody15OcZBNaScN4K/6HXQTPcZaP17EFUlcUOqCBtHrUWk74F/1ebp1d7Q29sw/nxsbHQy6AAN6Zei2Mig2ZNNyiu9j+SiaIHXaQRn4u9av5K9fomTQHstaQaZUWH1flgMmKVYzRal5Rb3G54IPbhsh6Qxe/6gFYQsKuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmXqAuQ4/OV/KkzpSFzwJ+qvuxQ4uQ2Fjmb++dicujk=;
 b=XqLllMQexvCtyGPvgMj616vZD0U6iNfQmSKNQxYmv1xjm+15cO86qhktgDxtxWY4kCzcs5+VTyO9glOtyWPZs/2bUPJFLOw7QjMOnkLfolXRsz5XAThOBs6o+p/LSmMnnB1VM8lIujJ9Z2BxajSDWj5R2XYtCahdtZ6S0ZU/ckkVY27M94EmcRO9Bmzb4WgtMsKaRW0A1Ns6nUyjPEOmQDVa6uywPTehE/91LQIR1I3AuWVv2c5q5SwLy1RcOqTauqo12bCdLg/eBeKTfcu3qUClnC8oJUn3o+1mtbpZ0oleaPulRJ0OA6hH0vPqYBgJYHoLGNPMJn8x/Er2vSVVng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=lst.de smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmXqAuQ4/OV/KkzpSFzwJ+qvuxQ4uQ2Fjmb++dicujk=;
 b=pK2ea/DD/BV519WphjMZ2rlOWM7Sm7T/HC0p1YtMqxEdU9HAoFnSdxQeIah7aUtLfRUj0dy4BXRSNbFYCNe8W1iXQSPUGd4F2ktGUMx+3z8rzaFg6Km8qQ9bwJcz/zKVZOg3sZNYNjIleW314Vk2c28P0NbcrrhXLLqE9RoO1Nc=
Received: from SN4PR0201CA0068.namprd02.prod.outlook.com
 (2603:10b6:803:20::30) by BL0PR02MB3762.namprd02.prod.outlook.com
 (2603:10b6:207:41::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Tue, 6 Oct
 2020 20:46:17 +0000
Received: from SN1NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:20:cafe::dd) by SN4PR0201CA0068.outlook.office365.com
 (2603:10b6:803:20::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.38 via Frontend
 Transport; Tue, 6 Oct 2020 20:46:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lst.de; dkim=none (message not signed)
 header.d=none; lst.de; dmarc=bestguesspass action=none header.from=xilinx.com; 
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT051.mail.protection.outlook.com (10.152.73.103) with Microsoft SMTP
 Server id 15.20.3433.39 via Frontend Transport; Tue, 6 Oct 2020 20:46:17
 +0000
Received: from [149.199.38.66] (port=51248 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <stefano.stabellini@xilinx.com>)
 id 1kPtq9-000439-Re; Tue, 06 Oct 2020 13:45:41 -0700
Received: from [127.0.0.1] (helo=localhost)
 by smtp.xilinx.com with smtp (Exim 4.63)
 (envelope-from <stefano.stabellini@xilinx.com>)
 id 1kPtqi-0001z8-SK; Tue, 06 Oct 2020 13:46:16 -0700
Received: from [10.23.120.52] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <stefanos@xilinx.com>)
 id 1kPtqe-0001yS-ME; Tue, 06 Oct 2020 13:46:12 -0700
Date: Tue, 6 Oct 2020 13:46:12 -0700 (PDT)
From: Stefano Stabellini <stefano.stabellini@xilinx.com>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To: Christoph Hellwig <hch@lst.de>
Subject: Re: xen-swiotlb vs phys_to_dma
In-Reply-To: <20201006082656.GB10243@lst.de>
Message-ID: <alpine.DEB.2.21.2010061325230.10908@sstabellini-ThinkPad-T480s>
References: <20201002123436.GA30329@lst.de>
 <alpine.DEB.2.21.2010021313010.10908@sstabellini-ThinkPad-T480s>
 <20201006082656.GB10243@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b7a1933-3135-4d5a-aa1f-08d86a38df61
X-MS-TrafficTypeDiagnostic: BL0PR02MB3762:
X-Microsoft-Antispam-PRVS: <BL0PR02MB37620C11D97A71AEDEE37FFDA00D0@BL0PR02MB3762.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kAUNYMKZDY1KI8q7XCOOwCL+JOe5ueQCshNmIRay4u7EmS6PSMjPzV9WcAxcYjNuHAH/lqNCkrx9L9xxcxaHRM4qk33OZEcyVo2LjkAEk6IgG4q9qNsmcx4roXq58pvYea7pidA6c9/fLvkDbxzF0GQjmz/EW50e4Sy5XvDThw4WSUxi+RSQe+bmxMHy+tmEWcmz4+XQTM6/9Ugt/goDv43L25Y2OJgO+8lcaRTGIti2SBmNhz4jfyjdNTUzVnQJvjF0gPUj//UKe8eVZ6rorBy+auAW/Bs8koekqlj1/JUzM94qBJtWR8LdM4qIVtp3fKw5Ag+rKlqAvCK5BGjXkyO6dEM8UAoc5SG+Qg2yvavJkQDrN/0vhtTVauTepHTp7pFOt2a0yP4XmHsRXayYpD4RIWNUZKgLc9qy8Nx1n+K57zkALVDZ+ZFTOtSYxdBrtCJbXjyK340zJF/PuWzsQKhuCoajYF733YGdiAmlP1AiOt2DOgfNI9Raxy5+a6KG
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(7916004)(346002)(396003)(376002)(39860400002)(136003)(46966005)(2906002)(81166007)(83080400001)(83380400001)(9786002)(70586007)(70206006)(82310400003)(356005)(47076004)(82740400003)(9686003)(5660300002)(966005)(6916009)(33716001)(53546011)(4326008)(336012)(8676002)(426003)(8936002)(478600001)(26005)(186003)(316002)(54906003)(44832011)(6606295002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2020 20:46:17.1297 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b7a1933-3135-4d5a-aa1f-08d86a38df61
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT051.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB3762
Cc: xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
 Stefano Stabellini <stefano.stabellini@xilinx.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
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

On Tue, 6 Oct 2020, Christoph Hellwig wrote:
> On Fri, Oct 02, 2020 at 01:21:25PM -0700, Stefano Stabellini wrote:
> > On Fri, 2 Oct 2020, Christoph Hellwig wrote:
> > > Hi Stefano,
> > > 
> > > I've looked over xen-swiotlb in linux-next, that is with your recent
> > > changes to take dma offsets into account.  One thing that puzzles me
> > > is that xen_swiotlb_map_page passes virt_to_phys(xen_io_tlb_start) as
> > > the tbl_dma_addr argument to swiotlb_tbl_map_single, despite the fact
> > > that the argument is a dma_addr_t and both other callers translate
> > > from a physical to the dma address.  Was this an oversight?
> > 
> > Hi Christoph,
> > 
> > It was not an oversight, it was done on purpose, although maybe I could
> > have been wrong. There was a brief discussion on this topic here: 
> > 
> > https://marc.info/?l=linux-kernel&m=159011972107683&w=2
> > https://marc.info/?l=linux-kernel&m=159018047129198&w=2
> > 
> > I'll repeat and summarize here for convenience. 
> > 
> > swiotlb_init_with_tbl is called by xen_swiotlb_init, passing a virtual
> > address (xen_io_tlb_start), which gets converted to phys and stored in
> > io_tlb_start as a physical address at the beginning of swiotlb_init_with_tbl.
> 
> Yes.
> 
> > Afterwards, xen_swiotlb_map_page calls swiotlb_tbl_map_single. The
> > second parameter, dma_addr_t tbl_dma_addr, is used to calculate the
> > right slot in the swiotlb buffer to use, comparing it against
> > io_tlb_start.
> 
> It is not compared against io_tlb_start.  It is just used to pick
> a slot that fits the dma_get_seg_boundary limitation in a somewhat
> awkward way.
> 
> > Thus, I think it makes sense for xen_swiotlb_map_page to call
> > swiotlb_tbl_map_single passing an address meant to be compared with
> > io_tlb_start, which is __pa(xen_io_tlb_start), so
> > virt_to_phys(xen_io_tlb_start) seems to be what we want.
> 
> No, it doesn't.  tlb_addr is used to ensure the picked slots satisfies
> the segment boundary, and for that you need a dma_addr_t.
> 
> The index variable in swiotlb_tbl_map_single is derived from
> io_tlb_index, not io_tlb_start.
> 
> > However, you are right that it is strange that tbl_dma_addr is a
> > dma_addr_t, and maybe it shouldn't be? Maybe the tbl_dma_addr parameter
> > to swiotlb_tbl_map_single should be a phys address instead?
> > Or it could be swiotlb_init_with_tbl to be wrong and it should take a
> > dma address to initialize the swiotlb buffer.
> 
> No, it must be a dma_addr_t so that the dma_get_seg_boundary check works.
>
> I think we need something like this (against linux-next):
> 
> ---
> >From 07b39a62b235ed2d4b2215700d99968998fbf6c0 Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Tue, 6 Oct 2020 10:22:19 +0200
> Subject: swiotlb: remove the tlb_addr argument to swiotlb_tbl_map_single
> 
> The tlb_addr always must be the dma view of io_tlb_start so that the
> segment boundary checks work.  Remove the argument and do the right
> thing inside swiotlb_tbl_map_single.  This fixes the swiotlb-xen case
> that failed to take DMA offset into account.  The issue probably did
> not show up very much in practice as the typical dma offsets are
> large enough to not affect the segment boundaries for most devices.

OK, this makes a lot of sense, and I like the patch because it makes the
swiotlb interface clearer.

Just one comment below.


> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/iommu/intel/iommu.c |  5 ++---
>  drivers/xen/swiotlb-xen.c   |  3 +--
>  include/linux/swiotlb.h     | 10 +++-------
>  kernel/dma/swiotlb.c        | 16 ++++++----------
>  4 files changed, 12 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 5ee0b7921b0b37..d473811fcfacd5 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -3815,9 +3815,8 @@ bounce_map_single(struct device *dev, phys_addr_t paddr, size_t size,
>  	 * page aligned, we don't need to use a bounce page.
>  	 */
>  	if (!IS_ALIGNED(paddr | size, VTD_PAGE_SIZE)) {
> -		tlb_addr = swiotlb_tbl_map_single(dev,
> -				phys_to_dma_unencrypted(dev, io_tlb_start),
> -				paddr, size, aligned_size, dir, attrs);
> +		tlb_addr = swiotlb_tbl_map_single(dev, paddr, size,
> +						  aligned_size, dir, attrs);
>  		if (tlb_addr == DMA_MAPPING_ERROR) {
>  			goto swiotlb_error;
>  		} else {
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index 030a225624b060..953186f6d7d222 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -395,8 +395,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
>  	 */
>  	trace_swiotlb_bounced(dev, dev_addr, size, swiotlb_force);
>  
> -	map = swiotlb_tbl_map_single(dev, virt_to_phys(xen_io_tlb_start),
> -				     phys, size, size, dir, attrs);
> +	map = swiotlb_tbl_map_single(dev, phys, size, size, dir, attrs);
>  	if (map == (phys_addr_t)DMA_MAPPING_ERROR)
>  		return DMA_MAPPING_ERROR;
>  
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 513913ff748626..3bb72266a75a1d 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -45,13 +45,9 @@ enum dma_sync_target {
>  	SYNC_FOR_DEVICE = 1,
>  };
>  
> -extern phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
> -					  dma_addr_t tbl_dma_addr,
> -					  phys_addr_t phys,
> -					  size_t mapping_size,
> -					  size_t alloc_size,
> -					  enum dma_data_direction dir,
> -					  unsigned long attrs);
> +phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t phys,
> +		size_t mapping_size, size_t alloc_size,
> +		enum dma_data_direction dir, unsigned long attrs);
>  
>  extern void swiotlb_tbl_unmap_single(struct device *hwdev,
>  				     phys_addr_t tlb_addr,
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 995c1b4cb427ee..8d0b7c3971e81e 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -441,14 +441,11 @@ static void swiotlb_bounce(phys_addr_t orig_addr, phys_addr_t tlb_addr,
>  	}
>  }
>  
> -phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
> -				   dma_addr_t tbl_dma_addr,
> -				   phys_addr_t orig_addr,
> -				   size_t mapping_size,
> -				   size_t alloc_size,
> -				   enum dma_data_direction dir,
> -				   unsigned long attrs)
> +phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
> +		size_t mapping_size, size_t alloc_size,
> +		enum dma_data_direction dir, unsigned long attrs)
>  {
> +	dma_addr_t tbl_dma_addr = phys_to_dma_unencrypted(dev, io_tlb_start);

This is supposed to be hwdev, not dev


>  	unsigned long flags;
>  	phys_addr_t tlb_addr;
>  	unsigned int nslots, stride, index, wrap;
> @@ -667,9 +664,8 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
>  	trace_swiotlb_bounced(dev, phys_to_dma(dev, paddr), size,
>  			      swiotlb_force);
>  
> -	swiotlb_addr = swiotlb_tbl_map_single(dev,
> -			phys_to_dma_unencrypted(dev, io_tlb_start),
> -			paddr, size, size, dir, attrs);
> +	swiotlb_addr = swiotlb_tbl_map_single(dev, paddr, size, size, dir,
> +					      attrs);
>  	if (swiotlb_addr == (phys_addr_t)DMA_MAPPING_ERROR)
>  		return DMA_MAPPING_ERROR;
>  
> -- 
> 2.28.0
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
