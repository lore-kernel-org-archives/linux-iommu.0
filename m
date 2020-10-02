Return-Path: <SRS0=7D56=DK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BA0C4363C
	for <iommu@archiver.kernel.org>; Sat,  3 Oct 2020 00:13:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 859C2206E3
	for <iommu@archiver.kernel.org>; Sat,  3 Oct 2020 00:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="iZR3Dod7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 859C2206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1A299873E0;
	Sat,  3 Oct 2020 00:13:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kAX4TPOo4nvm; Sat,  3 Oct 2020 00:13:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4F1C3873CF;
	Sat,  3 Oct 2020 00:13:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F14DC016F;
	Sat,  3 Oct 2020 00:13:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3FF9C0051
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 23:56:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 85E2120382
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 23:56:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G-hIcIVne9cg for <iommu@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 23:56:38 +0000 (UTC)
X-Greylist: delayed 03:35:03 by SQLgrey-1.7.6
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by silver.osuosl.org (Postfix) with ESMTPS id E1F3B2034B
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 23:56:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZOZ9C0uzv7vemfT0tAlbIYPqmCxa5zYSQG2pY0cdAkoCx715LErsisi+UJh256chVRvtOAxpAbKpRj8E4C4HhXSdCXJHWo2kYz/qV2ZlRDC+XTqagGjJL0MgxmE8yS2oEj2cACZPZuunraj4oOlOcu8zofeDk+HD9FBRsR+QpbywcppfnwpYed8Ed6aB96m0Feo1FWp5DQwvTCi4+a8gxqd2bep736t6SFSV03B1fqRW1406kX3b1KjLw8WGal5XFceR30OcrLHLPN56/b6GgnTdKu+gGJf1UEKAMhWzpxiYQagPkwcLY+V3H3Aj4MXstziwKszYy4i9w/PsMyfBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1sKfjfl6E0C1MGRjLxW/Z7cSOfeqva3SvzEf9ONgak=;
 b=Hu5/wln1emNdkIv6dZeGB8NgW7baZojPzkqUXGGmiI7xrFkH+1oK0G/l4aVYRqPBDNcZ6kjkB7lh7SRe8ph1THx23dRIPQl98Iw4t40MpiQJbc8w3OfD2++BTA+1a9jIJje81MVN7nRxrLHVAzDyVeC+6/XhPH8pEiLgP8qhLmTis8ay2M9ufbNsrInX8gpFNNoGjLmQJa5aYOMUXYvf8LPlgIwu5FXVFC9JNxJMet4YsOLEQlhxLSDdtbrW0vpbStc6w6EbGwWx0QFT0ArNack4Q5T7iftx1UHsUm9+8XBmrcY3KCk13UKEVFuWMWyxfcwSUYqfBcA86xkJ7aladw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1sKfjfl6E0C1MGRjLxW/Z7cSOfeqva3SvzEf9ONgak=;
 b=iZR3Dod7hFtywYjczyK2oph4wZxyuH2pmAGz7nMkxqbB7dCDxOvSVslpVtYiY76SeTVYnynsq/3lJgBmeOBGtvbrz90IpDvCO5o5RvqlE1DOrYn4MruFpe03V15HjGJPAJnToqPDuebhjcNVF1DJpJeDVGCoDv9Re7VmqPTDaAo=
Received: from SN2PR01CA0047.prod.exchangelabs.com (2603:10b6:800::15) by
 MN2PR02MB6704.namprd02.prod.outlook.com (2603:10b6:208:1d6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.32; Fri, 2 Oct 2020 20:21:32 +0000
Received: from SN1NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2603:10b6:800:0:cafe::23) by SN2PR01CA0047.outlook.office365.com
 (2603:10b6:800::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend
 Transport; Fri, 2 Oct 2020 20:21:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=bestguesspass
 action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT048.mail.protection.outlook.com (10.152.72.202) with Microsoft SMTP
 Server id 15.20.3412.21 via Frontend Transport; Fri, 2 Oct 2020 20:21:31
 +0000
Received: from [149.199.38.66] (port=57914 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <stefano.stabellini@xilinx.com>)
 id 1kORY6-00067A-3g; Fri, 02 Oct 2020 13:21:02 -0700
Received: from [127.0.0.1] (helo=localhost)
 by smtp.xilinx.com with smtp (Exim 4.63)
 (envelope-from <stefano.stabellini@xilinx.com>)
 id 1kORYZ-0008Sq-97; Fri, 02 Oct 2020 13:21:31 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 092KLPNw003319; 
 Fri, 2 Oct 2020 13:21:26 -0700
Received: from [10.23.123.31] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <stefanos@xilinx.com>)
 id 1kORYT-0008SG-R0; Fri, 02 Oct 2020 13:21:25 -0700
Date: Fri, 2 Oct 2020 13:21:25 -0700 (PDT)
From: Stefano Stabellini <stefano.stabellini@xilinx.com>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To: Christoph Hellwig <hch@lst.de>
Subject: Re: xen-swiotlb vs phys_to_dma
In-Reply-To: <20201002123436.GA30329@lst.de>
Message-ID: <alpine.DEB.2.21.2010021313010.10908@sstabellini-ThinkPad-T480s>
References: <20201002123436.GA30329@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7ce0efb-933a-43af-1ebe-08d86710c043
X-MS-TrafficTypeDiagnostic: MN2PR02MB6704:
X-Microsoft-Antispam-PRVS: <MN2PR02MB6704143E24A1D6CCD5D1B9C2A0310@MN2PR02MB6704.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r1zBRk3209SYXRmyDcyzGa4vWfwiztIJnO2AAvN03JioxKopFBHwp8SCr8Ac6UNygK5a2OPAbIDrvB5fteZUMQ+XCajwu4bptHTEZ57XAy4s2efXyHDLNv44B3llFLCvVrYtrc6N+jJbAXdudO7gRmCfvM1ndcKSj/PDp3JXYYhRSiOTTDo2jpNVxfDTzen8G+Lzf27Y3dx9dY1vHgg91rlH3s0IJ7O1PkSRL7PVdvhiKCHJ/C6ndIwCIihtZveH6RDQf2/uvu3LtsF/vtUoYlxe4Cb1akJSRnavhvJAFyso9FbJNBhbZSduLRoD+aAq2hb4DE8aYvg/ZOjzOnTYQCO82DYVRZowNvxlo8BLa0OOn07Zt2sApvrm6w+3eI0lsCUuH/exGMQCZqvagU07TbBDLr31aM/JIV6CUUpzZmEQTzvZGFX1ELkiNfGCi4Jc2+zEJfYEaRcuFEqGSXGf0ZyQ6xJhVef5Y/P/vvGFv5pGBG/Y61xZ3mPd1mFRcNvM
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(7916004)(396003)(39860400002)(376002)(136003)(346002)(46966005)(2906002)(8676002)(9786002)(70586007)(70206006)(82310400003)(6916009)(47076004)(4326008)(316002)(8936002)(9686003)(54906003)(426003)(26005)(44832011)(83380400001)(336012)(966005)(33716001)(83080400001)(186003)(81166007)(356005)(82740400003)(5660300002)(478600001)(6606295002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2020 20:21:31.5637 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ce0efb-933a-43af-1ebe-08d86710c043
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT048.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6704
X-Mailman-Approved-At: Sat, 03 Oct 2020 00:12:59 +0000
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

On Fri, 2 Oct 2020, Christoph Hellwig wrote:
> Hi Stefano,
> 
> I've looked over xen-swiotlb in linux-next, that is with your recent
> changes to take dma offsets into account.  One thing that puzzles me
> is that xen_swiotlb_map_page passes virt_to_phys(xen_io_tlb_start) as
> the tbl_dma_addr argument to swiotlb_tbl_map_single, despite the fact
> that the argument is a dma_addr_t and both other callers translate
> from a physical to the dma address.  Was this an oversight?

Hi Christoph,

It was not an oversight, it was done on purpose, although maybe I could
have been wrong. There was a brief discussion on this topic here: 

https://marc.info/?l=linux-kernel&m=159011972107683&w=2
https://marc.info/?l=linux-kernel&m=159018047129198&w=2

I'll repeat and summarize here for convenience. 

swiotlb_init_with_tbl is called by xen_swiotlb_init, passing a virtual
address (xen_io_tlb_start), which gets converted to phys and stored in
io_tlb_start as a physical address at the beginning of swiotlb_init_with_tbl.

Afterwards, xen_swiotlb_map_page calls swiotlb_tbl_map_single. The
second parameter, dma_addr_t tbl_dma_addr, is used to calculate the
right slot in the swiotlb buffer to use, comparing it against
io_tlb_start.

Thus, I think it makes sense for xen_swiotlb_map_page to call
swiotlb_tbl_map_single passing an address meant to be compared with
io_tlb_start, which is __pa(xen_io_tlb_start), so
virt_to_phys(xen_io_tlb_start) seems to be what we want.

However, you are right that it is strange that tbl_dma_addr is a
dma_addr_t, and maybe it shouldn't be? Maybe the tbl_dma_addr parameter
to swiotlb_tbl_map_single should be a phys address instead?
Or it could be swiotlb_init_with_tbl to be wrong and it should take a
dma address to initialize the swiotlb buffer.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
