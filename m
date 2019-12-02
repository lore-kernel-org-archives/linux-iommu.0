Return-Path: <SRS0=Z2AP=ZY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4D2C432C0
	for <iommu@archiver.kernel.org>; Mon,  2 Dec 2019 15:14:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CE5520748
	for <iommu@archiver.kernel.org>; Mon,  2 Dec 2019 15:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="p73Y+i3L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CE5520748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C4CC220472;
	Mon,  2 Dec 2019 15:14:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HBv8JiagcUyG; Mon,  2 Dec 2019 15:14:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id CC4B71FEE0;
	Mon,  2 Dec 2019 15:14:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B068AC1798;
	Mon,  2 Dec 2019 15:14:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 607DBC087F
 for <iommu@lists.linux-foundation.org>; Mon,  2 Dec 2019 15:14:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4B14E1FF11
 for <iommu@lists.linux-foundation.org>; Mon,  2 Dec 2019 15:14:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dgJGMKgC-Wc0 for <iommu@lists.linux-foundation.org>;
 Mon,  2 Dec 2019 15:14:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr150071.outbound.protection.outlook.com [40.107.15.71])
 by silver.osuosl.org (Postfix) with ESMTPS id DE4001FEE0
 for <iommu@lists.linux-foundation.org>; Mon,  2 Dec 2019 15:13:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbfRMt7LxrceG5jOGZJ249IHrBiqInyZSuI3ONjJEmuAmRIfEdBYX++H3/XQVDsplHRaf27l8xdw8GwbrvdToMubcmrPK/PpJ9zzaEy2TyrVIivsrWdclQtFoFcKT890BTPjGQ35p9LRh413AxFrhawATXoGxXPMIfrozLHw0HbUQHYX03BAybOHnFFbmr2jNchFGzRWwsGNG8b+WCXf5G4WM5gwhN52sl0L5ZyciNTAmlp0YDiHJ0qp4WrHgHAvNWJiseg0u0yNhg94j94F7Zxc6JagqweonjIuNzkP+26Dq66H4Pkc2MYQ8k/YKB3U3IGxF4yxoPEx/MaYtbwo7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vE09OtzXsJFEEW42YBsiEeYQCVnAhNFms4j0eDrQ8o=;
 b=JpnKt17GYZB9skH7CRuIzEzZGuPiv2S0t4tcO5x35piRqNHSZ8rrcSPFEmwy9cowWOeP9ueLtA06GTQ+3TvCCjRp2ziHujCFUOew3yfVkuFyQaZPJXBcLbonEkAVsLFuDIrWywY6MYR9qrlbRMTbdwOJZ7IB7wGwVuXEXxzAytTrua/GvtRvag/rVDdibyu364uigI7a2mekXNHODHk2FlXWD4jCEld/XgK0cBsrzEnqGXMfNIQVtEB6cyK3jTxUY9YVQlgEWLHWLGNQbYfL4B1BhOBiwHH2oDvEdJpFwxtjMcptbRU6TTC5a4cvr7HgUrMaVRSk0jgjIatajYUTgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vE09OtzXsJFEEW42YBsiEeYQCVnAhNFms4j0eDrQ8o=;
 b=p73Y+i3Lu/0szmFLVF24Ksxqp2klrXqKc2d84bKsV8YVbt5rl1L2edfOM/MWaR7sw6iPx9ew8fdT0i88fSUUGUv+lDQF19S2JN44xqQtNv7UTzZMjtfd3TcQ5cukVbaYTjJ4k+li1RzT3Un7Dl4CDWRhdnS9PtnWnidPBv8KuYU=
Received: from VI1PR04MB5567.eurprd04.prod.outlook.com (20.178.123.83) by
 VI1PR04MB7135.eurprd04.prod.outlook.com (10.186.158.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Mon, 2 Dec 2019 14:58:41 +0000
Received: from VI1PR04MB5567.eurprd04.prod.outlook.com
 ([fe80::64f5:d1f5:2356:bdcb]) by VI1PR04MB5567.eurprd04.prod.outlook.com
 ([fe80::64f5:d1f5:2356:bdcb%6]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 14:58:41 +0000
From: Madalin Bucur <madalin.bucur@nxp.com>
To: Christoph Hellwig <hch@lst.de>, David Miller <davem@davemloft.net>
Subject: RE: [PATCH v3 0/4] dma-mapping: introduce new dma unmap and sync
 variants
Thread-Topic: [PATCH v3 0/4] dma-mapping: introduce new dma unmap and sync
 variants
Thread-Index: AQHVmh1EAM9HSxnkaEm+5zOWq0YV/qeJiNoAgAvA9ACAEcGhEA==
Date: Mon, 2 Dec 2019 14:58:41 +0000
Message-ID: <VI1PR04MB55678E303E4EF6AB2C416793EC430@VI1PR04MB5567.eurprd04.prod.outlook.com>
References: <20191113122407.1171-1-laurentiu.tudor@nxp.com>
 <20191113.121132.1658930697082028145.davem@davemloft.net>
 <20191121074100.GD24024@lst.de>
In-Reply-To: <20191121074100.GD24024@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=madalin.bucur@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ce85849c-3f4a-40da-4a83-08d777381eb4
x-ms-traffictypediagnostic: VI1PR04MB7135:|VI1PR04MB7135:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB71358A039784CF9C40CCDA16EC430@VI1PR04MB7135.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0239D46DB6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(13464003)(189003)(199004)(71190400001)(9686003)(71200400001)(66066001)(86362001)(33656002)(52536014)(478600001)(446003)(5660300002)(6436002)(55016002)(14454004)(76116006)(99286004)(66446008)(64756008)(66556008)(66476007)(66946007)(26005)(81156014)(81166006)(8676002)(44832011)(25786009)(53546011)(6506007)(2906002)(316002)(305945005)(74316002)(4326008)(7736002)(54906003)(6116002)(110136005)(3846002)(6246003)(229853002)(11346002)(7696005)(8936002)(102836004)(14444005)(256004)(76176011)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB7135;
 H:VI1PR04MB5567.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ohgFxc5fid2ww2GNnMYArieMyFaK1ByDJc7FP2o0TAaiBhJEIM830sS0O34N3BtuqUB03d5l8xYlbMcz0Hyt8PjgWMlTEdq1FjHUzLuLRIOUSeoT0iwCun2Ns0+o1q8BRiO3ktiMAOq0CNe077+X/ewYGDqSEZykrO1Z/nsqNAT5s2a75iY7TgPKekENvbMhSneyngxX1au3vRQYp3z9pOEdEoB0S6gEzosgOYv9UupC0O1SNEEWU20xHeeQt8xBqg+HW2mUscPjuNlJ+idWTix14JH7W6ve8a/eud04JypU0CZLBqChQAb49/02EWdnERlwmjQh+sLYoaN1dIYy+nYykyCXcvSUMf2+dr5UW9GSHTATP1yCw8n0SExk2vrYFD6nJnNJuiPisYccLPbLwXEQfzQJhiN5/1EHDmksqiEqSdBRcM6gSIDJUC2A7l5X
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce85849c-3f4a-40da-4a83-08d777381eb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2019 14:58:41.1911 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3HxSTMlUstwePboW87XjVA22HRpy3rA7bU064VRRLQHPtQYbrgIJXdHwKNFvppQTkRSrAVLO2LHFBzUICMjjVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7135
Cc: Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Camelia Alexandra Groza <camelia.groza@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

> -----Original Message-----
> From: Christoph Hellwig <hch@lst.de>
> To: David Miller <davem@davemloft.net>
> Subject: Re: [PATCH v3 0/4] dma-mapping: introduce new dma unmap and sync
> variants
> 
> On Wed, Nov 13, 2019 at 12:11:32PM -0800, David Miller wrote:
> > > This series introduces a few new dma unmap and sync api variants
> that,
> > > on top of what the originals do, return the virtual address
> > > corresponding to the input dma address. In order to do that a new dma
> > > map op is added, .get_virt_addr that takes the input dma address and
> > > returns the virtual address backing it up.
> > > The second patch adds an implementation for this new dma map op in
> the
> > > generic iommu dma glue code and wires it in.
> > > The third patch updates the dpaa2-eth driver to use the new apis.
> >
> > The driver should store the mapping in it's private software state if
> > it needs this kind of conversion.
> 
> I think the problem for this driver (and a few others) is that they
> somehow manage to split I/O completions at a different boundary
> than submissions.  For me with my block I/O background this seems
> weird, but I'll need networking folks to double check the theory.
> 
> > This is huge precendence for this, and there is therefore no need to
> > add even more complication and methods and burdon to architecture code
> > for the sake of this.
> 
> Unfortunately there are various drivers that abuse iommu_iova_to_phys
> to get a struct page to unmap.  Two of theose are network drivers
> that went in through you (dpaa2 and thunder), additonally the
> caam crypto driver (which I think is the same SOC family as dpaa,
> but I'm not sure) and the AMD GPU driver.
> 
> We also have drivers that just don't unmap and this don't work with
> iommus or dma-debug (IBM EMAC another net driver).
> 
> That being said I hate these new API, but I still think they are less
> bad than these IOMMU API abuses people do now.  If experienced
> networking folks know a way to get rid of both I'm all for it.

Hi,

will this API be included during the v5.5 kernel development cycle or is
there an alternative solution?

Thank you,
Madalin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
