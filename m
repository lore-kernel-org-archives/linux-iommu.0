Return-Path: <SRS0=pxo5=UG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45DAC2BCA1
	for <iommu@archiver.kernel.org>; Fri,  7 Jun 2019 06:01:06 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC6F820825
	for <iommu@archiver.kernel.org>; Fri,  7 Jun 2019 06:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="hGttlxd7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC6F820825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8F836B7D;
	Fri,  7 Jun 2019 06:01:06 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6408FB49
	for <iommu@lists.linux-foundation.org>;
	Fri,  7 Jun 2019 06:01:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
	(mail-eopbgr1410129.outbound.protection.outlook.com [40.107.141.129])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C81D1A9
	for <iommu@lists.linux-foundation.org>;
	Fri,  7 Jun 2019 06:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Tsxk6Lqyiv5wia7JMYpnMyS2BQcmPgvxu7gzRzXFg8I=;
	b=hGttlxd7BDoILYQCaPVNoTE9pMsJBWiwIkLAiMhv786dWGv/5jPGD83Az+5yoBo7LsHNYl5frtmDqnKq9R12zUCnROaSxkuxepCFu7x642aPbO4tab8aed97U309w2DxIexkP9SjMsS+tAXXFFGCdzwefMJnpPM3SB8+qovfuY0=
Received: from OSAPR01MB3089.jpnprd01.prod.outlook.com (52.134.247.150) by
	OSAPR01MB2948.jpnprd01.prod.outlook.com (52.134.248.143) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1965.12; Fri, 7 Jun 2019 06:01:00 +0000
Received: from OSAPR01MB3089.jpnprd01.prod.outlook.com
	([fe80::19ad:b6ce:a287:dc85]) by
	OSAPR01MB3089.jpnprd01.prod.outlook.com
	([fe80::19ad:b6ce:a287:dc85%7]) with mapi id 15.20.1943.023;
	Fri, 7 Jun 2019 06:01:00 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Christoph Hellwig <hch@lst.de>
Subject: RE: [RFC PATCH v5 3/8] iommu: add a new capable IOMMU_CAP_MERGING
Thread-Topic: [RFC PATCH v5 3/8] iommu: add a new capable IOMMU_CAP_MERGING
Thread-Index: AQHVG5AuSNIEYbUj60Sza33KteoVlaaM+2qAgAAEhACAASFw4IAAErKAgAFoAcCAABZegIAAAprg
Date: Fri, 7 Jun 2019 06:01:00 +0000
Message-ID: <OSAPR01MB30894702972EB047D1EF2938D8100@OSAPR01MB3089.jpnprd01.prod.outlook.com>
References: <1559733114-4221-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1559733114-4221-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<7dfeb7d8-b777-b4af-d892-2829cd05241b@arm.com>
	<20190605123808.GA12529@lst.de>
	<OSAPR01MB3089448A3D44BE61B127AA73D8170@OSAPR01MB3089.jpnprd01.prod.outlook.com>
	<20190606070059.GI27033@lst.de>
	<OSAPR01MB3089E3E79B0BDF24610FBEC2D8100@OSAPR01MB3089.jpnprd01.prod.outlook.com>
	<20190607054933.GA8267@lst.de>
In-Reply-To: <20190607054933.GA8267@lst.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [211.11.155.142]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6969671-67c2-45b8-d48e-08d6eb0d846d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
	SRVR:OSAPR01MB2948; 
x-ms-traffictypediagnostic: OSAPR01MB2948:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <OSAPR01MB294833003401BE4E2CEB2E6DD8100@OSAPR01MB2948.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(346002)(39860400002)(366004)(136003)(396003)(376002)(199004)(189003)(966005)(99286004)(8936002)(66946007)(66476007)(64756008)(66556008)(76116006)(66446008)(81166006)(81156014)(305945005)(14454004)(478600001)(8676002)(26005)(446003)(74316002)(486006)(11346002)(476003)(102836004)(76176011)(6506007)(6916009)(7696005)(186003)(25786009)(73956011)(86362001)(68736007)(4326008)(6116002)(66066001)(3846002)(6436002)(71200400001)(52536014)(6306002)(55016002)(9686003)(53936002)(71190400001)(229853002)(5660300002)(54906003)(316002)(6246003)(33656002)(7736002)(256004)(2906002)(14444005)(6606295002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:OSAPR01MB2948;
	H:OSAPR01MB3089.jpnprd01.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: renesas.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hlh7wZvTIwmwREaiB/TliScx+ofQM9w3p6g8QZe7OlfdbgRuJUFbcG8Mld7SQdwisW/4jv500Tg5vTA5YRulWlkNibmE4B8ZU0WBU31dwh3GASKexGMzY2SxmmdJLtEXx3uf8kIiUjIjV+vLZSe2HkUUE5SwYemecJ6u/PHbsFFjFikg60hLI/DxAOFJbBXLn5DaDbEUM6Up0NhqvOL1ZQOiNeH1uRhWm3j63iu+8X0dh8YzdVQ2AQmUxZtiHrx1YGNxdW4dQLqvu0zymlX7OeaGISvFz7xAADTxvvH5aBe1MVEPK+avV8L6H1RhMAac3QYyFOpN1yx4dSPICTnVW07lFkXYF/UTI5kmlPy3IsQbWpwHr1AFXLHI2M9zLP/IlUJ9I5GqFxLulrSgOfdnD62+2EKRiPrxo9eGNc4uvXs=
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6969671-67c2-45b8-d48e-08d6eb0d846d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 06:01:00.6627 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yoshihiro.shimoda.uh@renesas.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2948
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Christoph,

> From: Christoph Hellwig, Sent: Friday, June 7, 2019 2:50 PM
> 
> On Fri, Jun 07, 2019 at 05:41:56AM +0000, Yoshihiro Shimoda wrote:
> > > bool blk_can_use_iommu_merging(struct request_queue *q, struct device *dev)
> > > {
> > > 	if (!IOMMU_CAN_MERGE_SEGMENTS(dev))
> > > 		return false;
> >
> > As Robin mentioned, all IOMMUs can merge segments so that we don't need
> > this condition, IIUC. However, this should check whether the device is mapped
> > on iommu by using device_iommu_mapped().
> 
> There are plenty of dma_map_ops based drivers that can't merge segments.
> Examples:
> 
>  - arch/ia64/sn/pci/pci_dma.c
>  - arch/mips/jazz/jazzdma.c
>  - arch/sparc/mm/io-unit.c
>  - arch/sparc/mm/iommu.c
>  - arch/x86/kernel/pci-calgary_64.c

Thank you for the indicate. I'll check these codes.

> Nevermind the diret mapping, swiotlb and other weirdos.

I got it.

> > > 	blk_queue_virt_boundary(q, IOMMU_PAGE_SIZE(dev));
> > > 	blk_queue_max_segment_size(q, IOMMU_MAX_SEGMENT_SIZE(dev));
> >
> > By the way, I reported an issue [1] and I'm thinking dima_is_direct() environment
> > (especially for swiotlb) is also needed such max_segment_size changes somehow.
> > What do you think?
> >
> > [1]
> > https://marc.info/?l=linux-block&m=155954415603356&w=2
> 
> That doesn't seem to be related to the segment merging.  I'll take
> a look, but next time please Cc the author of a suspect commit if
> you already bisect things.

Oops. I'll Cc the author in next time.

Best regards,
Yoshihiro Shimoda

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
