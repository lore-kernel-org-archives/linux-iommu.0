Return-Path: <SRS0=58s/=DO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EEAC41604
	for <iommu@archiver.kernel.org>; Wed,  7 Oct 2020 17:48:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7E0B2168B
	for <iommu@archiver.kernel.org>; Wed,  7 Oct 2020 17:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="j8WDry7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E0B2168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6E54386546;
	Wed,  7 Oct 2020 17:48:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FvPFVKe3qCvm; Wed,  7 Oct 2020 17:48:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0CAE18651C;
	Wed,  7 Oct 2020 17:48:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0857C07FF;
	Wed,  7 Oct 2020 17:48:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F760C0051
 for <iommu@lists.linux-foundation.org>; Wed,  7 Oct 2020 17:48:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5E04D86546
 for <iommu@lists.linux-foundation.org>; Wed,  7 Oct 2020 17:48:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 19giba3k-cKA for <iommu@lists.linux-foundation.org>;
 Wed,  7 Oct 2020 17:48:31 +0000 (UTC)
X-Greylist: delayed 21:02:11 by SQLgrey-1.7.6
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750057.outbound.protection.outlook.com [40.107.75.57])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4649F8651C
 for <iommu@lists.linux-foundation.org>; Wed,  7 Oct 2020 17:48:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrN2lXX+T7Udw7Z0jfKYJESY0W1XtHtoOOOgCTYYnkj90d34JIfQ8yyGHrkKROA6cjJADUbXKKu54NQNjtT1HhCUBK8y6fHSkOymiQRDHDrbU8U/t7o3Gv3CYdINF0eTlwkYSKCFaGD1OtOW25I0d/Pnu1XfaNMKP7/bLjA9DQWlC5Hk2/kJ3gTd4q4gKbu04covdHFT78kAEeLotvvM3eNQP9yoIULPqZFPstFK4lg1qK7g8KMnbF9xhdREqlzw0ITn4KkEzPThePRbn4JuSQZxBOvg8Tjk6wgLjte5Obg3wOqGafe7aS5h2zc0qrHeDk7L/rvPymCiCeQ3g+Yp9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfuc7bfP8imoEchfCuXEL9P1/SHk38u2m1zaUF29b10=;
 b=eSsyUMv6MdKEImZXw2X92gM/ebZ72/T1lqakTy1mVNuxF6JDfseRgvqKb4RD9v29EFnXuktTFeLUhfMSSBKSTBiYRn/foy/olPZseQq8mSGNFknYeChoRtRt83u0kXBMt9xhp5HG/D5qC4P5mzl15t2ysDkmemWNGUwKpa0Lx2DCPxekW4vkqEd7+X1gEzQ68VXYTUZqJjAYpYifDLWSb8w35otSAlxEnESLvwAgnirQM0KMsphLHPKy2Stbq56Nn7xZ+kaEvM1gfDc+YWYNc4JJGUlUXxeASwI7zX31yeEkkhURowCcN+SHa3fFIg5hNdC/3gEFUdzxGS8Z8qkdNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfuc7bfP8imoEchfCuXEL9P1/SHk38u2m1zaUF29b10=;
 b=j8WDry7wxrykDfJOwuVRW0rhcHWutBcibIrL2FUMbX/ySoVO6DDsnk6sXjyX/JNxC0e1Ry5hILBKSLObGkC8MRtrS+HEo6EP2NlFIZ4jL6FVm47IfsLZMakQjIBlwxNpRpuduNEd11RqWBR5iVr5JMGOAsfkCT6OGeGYOw5oD0o=
Received: from SN4PR0501CA0087.namprd05.prod.outlook.com
 (2603:10b6:803:22::25) by MWHPR0201MB3484.namprd02.prod.outlook.com
 (2603:10b6:301:77::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.39; Wed, 7 Oct
 2020 17:15:58 +0000
Received: from SN1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:22:cafe::ab) by SN4PR0501CA0087.outlook.office365.com
 (2603:10b6:803:22::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.15 via Frontend
 Transport; Wed, 7 Oct 2020 17:15:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=bestguesspass
 action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT057.mail.protection.outlook.com (10.152.73.105) with Microsoft SMTP
 Server id 15.20.3433.39 via Frontend Transport; Wed, 7 Oct 2020 17:15:57
 +0000
Received: from [149.199.38.66] (port=59910 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <stefano.stabellini@xilinx.com>)
 id 1kQD29-0001sT-2M; Wed, 07 Oct 2020 10:15:21 -0700
Received: from [127.0.0.1] (helo=localhost)
 by smtp.xilinx.com with smtp (Exim 4.63)
 (envelope-from <stefano.stabellini@xilinx.com>)
 id 1kQD2j-00072d-BA; Wed, 07 Oct 2020 10:15:57 -0700
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 097HFkS7009243; 
 Wed, 7 Oct 2020 10:15:47 -0700
Received: from [10.23.120.52] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <stefanos@xilinx.com>)
 id 1kQD2Y-0006zR-Nc; Wed, 07 Oct 2020 10:15:46 -0700
Date: Wed, 7 Oct 2020 10:15:46 -0700 (PDT)
From: Stefano Stabellini <stefano.stabellini@xilinx.com>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To: Christoph Hellwig <hch@lst.de>
Subject: Re: xen-swiotlb vs phys_to_dma
In-Reply-To: <20201007060008.GA10125@lst.de>
Message-ID: <alpine.DEB.2.21.2010071015220.23978@sstabellini-ThinkPad-T480s>
References: <20201002123436.GA30329@lst.de>
 <alpine.DEB.2.21.2010021313010.10908@sstabellini-ThinkPad-T480s>
 <20201006082656.GB10243@lst.de>
 <alpine.DEB.2.21.2010061325230.10908@sstabellini-ThinkPad-T480s>
 <20201007060008.GA10125@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6ca9106-6562-430c-564d-08d86ae4a7f4
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3484:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB34842EC02DEAA7D400D61E77A00A0@MWHPR0201MB3484.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yzYTur9nZ4FvMFeVhNmdtaTBjdXA3LM3bYkQWfibGQYBM9RZGRALHQSljY4k+FTY3Ym9raREQyJrUlr8gHYDk5+Ts2cDnyRRMGZvs5dhY6Z4CRHq14j+TT5cJ2mO5NyGx2MBoVAkwECQqIt51X/CIOHZL/ckzLHOoiiM7dV9nw6iE6jdPOjBFNbPOJgyBatuWE7zqs0zwhugbQGB0PS4Vp3D4edzK5LsQ95F1j1/scKlFIwTnWgK/2XS68JSJgLB0E22oAuTIEdVF1ZWPd8LFpn+3v0gnjq1TxoFH7291cjkJXEpQurhcXLgpqbJbpp3iBt4JYfrygzMfu77cGITM3CjzjE0ROOpvBS0JehbpPhoNqnbB4HkXoZiutz7z0p0T6aaAxDkLI/8gs8a9+Ohkg==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(7916004)(39850400004)(396003)(136003)(346002)(376002)(46966005)(33716001)(2906002)(4326008)(82310400003)(478600001)(426003)(81166007)(5660300002)(336012)(70206006)(8676002)(316002)(47076004)(9786002)(44832011)(356005)(186003)(54906003)(4744005)(8936002)(9686003)(82740400003)(26005)(70586007)(6916009);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 17:15:57.5760 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ca9106-6562-430c-564d-08d86ae4a7f4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT057.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3484
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

On Wed, 7 Oct 2020, Christoph Hellwig wrote:
> On Tue, Oct 06, 2020 at 01:46:12PM -0700, Stefano Stabellini wrote:
> > OK, this makes a lot of sense, and I like the patch because it makes the
> > swiotlb interface clearer.
> > 
> > Just one comment below.
> > 
> 
> > > +phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
> > > +		size_t mapping_size, size_t alloc_size,
> > > +		enum dma_data_direction dir, unsigned long attrs)
> > >  {
> > > +	dma_addr_t tbl_dma_addr = phys_to_dma_unencrypted(dev, io_tlb_start);
> > 
> > This is supposed to be hwdev, not dev
> 
> Yeah, te compiler would be rather unhappy oterwise.
> 
> I'll resend it after the dma-mapping and Xen trees are merged by Linus
> to avoid a merge conflict.

Sounds good, thanks. Please add

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
