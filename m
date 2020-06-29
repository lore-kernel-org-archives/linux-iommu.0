Return-Path: <SRS0=qe9F=AK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9377BC433E0
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 06:35:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A62223130
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 06:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AmBn7Z1V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A62223130
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3CD37886C2;
	Mon, 29 Jun 2020 06:35:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Iis6AxSXblhy; Mon, 29 Jun 2020 06:35:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A1EE7886B5;
	Mon, 29 Jun 2020 06:35:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74E18C0865;
	Mon, 29 Jun 2020 06:35:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55548C016E;
 Mon, 29 Jun 2020 06:35:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4AF3589332;
 Mon, 29 Jun 2020 06:35:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wk5dSZ7dYnbz; Mon, 29 Jun 2020 06:35:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80074.outbound.protection.outlook.com [40.107.8.74])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E1A8B892A4;
 Mon, 29 Jun 2020 06:35:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gzr/k4oCbcvEW7AiZGYcqOtnZAuZ87sdUvtk2U1+45np+2XqI2wkn+fFSSxJpPvBzvIfY95CTvIOq74St4++o8KZSmmblZNTye/HXpATwTRNThRGDatoR7ljUseNIFLWjftAAYrgrzzhTocZ/TiG3sCYqAeB1r2A0QBTr/A1BuQsislJYxR8T/fhQB79nJpgE5K96HOZEwU801Bn2jlsjNAYE4K+uG3LRDRjpBayLVgvveyp4ZZSzCLH0nB8khiVoZOn2Ld67ikv6ce9mfoHwXG40rdyS7MF+wCGem4kduqbS3hMeLpWkcEFDTQUvYhDSTh8Df04Ob2TLaJwJ8gtaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jt9aKkcohM+VBBAMcQ1zSn0OzkcLoXfaQdNHqrsc8go=;
 b=I19SIRA9E+ml4KlImtDM2f6dT2GjHOpm/8bQAdGCULUf7DUSebu1q6C/JEQQ0ZoD5czHKgShajRH6E8quwskYdXQrzJfn+BWOHsgk/ylOAEslvjCLUXnqiYfrr31rvAWJsumKBYEoB53GLwvctI0j8ms0CZg5nttGNUPix2ZLACLyf8/jdtFuC95JbVqXotqdhbEoV0cgmf+v07H7UuHofCgk1ft3b8hZnXEyEeIUp23T10ZYTN/LgLHpL7WsN/+yuJc5e+M2O/sjq6bnvSKohrrNhgmA8xyXA7NlZAZkvgt3wCT/sr95qbheSpOaRlE434mT7ymF9kj/VMpYltmvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jt9aKkcohM+VBBAMcQ1zSn0OzkcLoXfaQdNHqrsc8go=;
 b=AmBn7Z1Vgx95lJz5b3JxDQb7dpR0/wYgFEuq3Qzew0A79iEejI01TsVFHzD149IWXAhzENJq8qJnyaImapEQolKWf0QRGEawwdDBkZNk1rzw+FT+BwyKqToGmCXB7v+rtFqIIzKTJNTMt9LLg+JmWqc28jUbdUiyQym7kw7s8VU=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4764.eurprd04.prod.outlook.com (2603:10a6:10:15::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Mon, 29 Jun
 2020 06:35:48 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701%4]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 06:35:48 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH] xen: introduce xen_vring_use_dma
Thread-Topic: [PATCH] xen: introduce xen_vring_use_dma
Thread-Index: AQHWSgTusARd8c8cRkWwDit233DtZajneYoAgACU6oCAAC7QAIAAEpoAgAAGSwCAAUK2gIABcSaAgAPk6cCAADgrAIAAAH5wgAAC0YCAAABHUA==
Date: Mon, 29 Jun 2020 06:35:48 +0000
Message-ID: <DB6PR0402MB27606A2A6308135D62476D80886E0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20200624050355-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006241047010.8121@sstabellini-ThinkPad-T480s>
 <20200624163940-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006241351430.8121@sstabellini-ThinkPad-T480s>
 <20200624181026-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006251014230.8121@sstabellini-ThinkPad-T480s>
 <20200626110629-mutt-send-email-mst@kernel.org>
 <DB6PR0402MB27601CA74B85DA5A9F5E5DD6886E0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <20200629022124-mutt-send-email-mst@kernel.org>
 <DB6PR0402MB27602AB2A9A242D79343CE48886E0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <20200629023225-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200629023225-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e07dc2d3-9155-49ce-2410-08d81bf6a91d
x-ms-traffictypediagnostic: DB7PR04MB4764:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB4764AE24947258994AB8A440886E0@DB7PR04MB4764.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fK08amyxZaUi4JckED6/kpeUqMMw5buBVlalapbUcm+JSQK4QI84PEPgIYnkjkipS0xD9ABwB8ZcXtU/h/Y1OsDKtAVt4k4y7yMsyjn1Oa5BSHHepcIY7m4GIwnbEVNJJuthC4iVCMt+doQZU+ZAh26iGubJ/DeuGuOOXyNv4oM6PLJurQOiHffS1g7sdTacZiTsr+zppsy1C/3VBuisiyRVGG4KfeS0ux+2g8v3UsA7a2J/kgVZnBPHi2P5+10HIdKRjvpPPZ6yxmJFe43F3T3WeOuT1xkhR6Zi6ivDSCaAWVO+op7BLHTy95nrWHskMjgKfYQDmudAalEtAL7cIA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB6PR0402MB2760.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(66946007)(8936002)(8676002)(7416002)(9686003)(83380400001)(86362001)(44832011)(26005)(64756008)(2906002)(66556008)(6916009)(4326008)(66476007)(6506007)(66446008)(186003)(76116006)(4744005)(71200400001)(5660300002)(33656002)(478600001)(55016002)(316002)(7696005)(52536014)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 63k2owGulhusPRazW46hh/2a+efDxnw5Ak9iGbwd161buaq9mmMSZvvaGZMS87V5f2GDrg3WF4Oh7JXqPRgBE5SUGQmUoXnhTBOO19GPSMYZt+Lrlj0OpzO0Jql3BMWWSQplbol/Q+Z80+e4LL7EIQWzIhSBfPZjbEjV39ucPFLEIFEwTFsCsyK+6WFjKMeIrepcXL+MG+tAEIdcaugN7F9Y6LGblmbsvcCe/CTmqDsMDIq57bI+0chNC+fJQj24C3V+DPYtwKLJHwkrD0Wc90v8IQhcMJg4hjUp3lDEDbgI6vqOpEIfN4t2Zpxl16NFJ9+EvD5RN4ilnaa84iCF5iOkD+KQIlMPB5ex8az2GvDte+xkV4Mzg2p3SWTOKf0qsk3HKvh74vTDX2Bk1B+Zqsz+Z1harUbTpuDLx2jAEA5kih/aoXOqjQRM5mrc1peNTAo9qYuTNWsaSiK1sRsVD0Qc9Nun+TWq/L5HOWc68O5MhgpgJvac9kppMJ+CTTA4
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e07dc2d3-9155-49ce-2410-08d81bf6a91d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 06:35:48.4429 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NmRyPfTWtT9tmgZRVPpOrkiU+mkQIwuldVriqMockyAX0T7RoLpPgZZtv1zNbSJXKaVO8ByTSQcBW7CQ4G2crw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4764
Cc: "jgross@suse.com" <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

> Subject: Re: [PATCH] xen: introduce xen_vring_use_dma
> 
> On Mon, Jun 29, 2020 at 06:25:41AM +0000, Peng Fan wrote:
> > > > > > Anyway, re-reading the last messages of the original thread
> > > > > > [1], it looks like Peng had a clear idea on how to fix the general issue.
> > > > > > Peng, what happened with that?
> > > >
> > > > We shrinked the rpmsg reserved area to workaround the issue.
> > > > So still use the dma apis in rpmsg.
> > > >
> > > > But here I am going to address domu android trusty issue using virtio.
> > >
> > > My suggestion is to first of all fix DMA API so it works properly.
> >
> > Could you please elaborate more details?
> >
> > You mean the DMA API usage of rpmsg? Or xen domu dma_ops?
> >
> > Thanks,
> > Peng.
> 
> Not 100% sure but I think xen dma ops.

Sorry to ask again, could you explain more details about what issues
do you see of current xen ARM domu dma_ops? 
Or Dom0 swiotlb xen dma_ops?

Thanks,
Pen.g

> 
> --
> MST

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
