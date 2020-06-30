Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DABC433E0
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 01:55:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 004EC206C3
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 01:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SIUtU52K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 004EC206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B823187383;
	Tue, 30 Jun 2020 01:55:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Pt9V6ayP1KZX; Tue, 30 Jun 2020 01:55:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 04F7086B62;
	Tue, 30 Jun 2020 01:55:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC5A3C07FF;
	Tue, 30 Jun 2020 01:55:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77EDEC016E;
 Tue, 30 Jun 2020 01:55:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7386A885D9;
 Tue, 30 Jun 2020 01:55:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FjBv7D2bT2vb; Tue, 30 Jun 2020 01:55:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80074.outbound.protection.outlook.com [40.107.8.74])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 16B8B885D5;
 Tue, 30 Jun 2020 01:55:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwdYoXgJsqF/Ba6f9pApxpysKoUGdA2aLQE10N31TJ6BUeJLPvHuwOeW7KUYM61WLVknYhH/LXLDFaIkem4FsW30dBiw48r0n5Y08mhgKazIGmUIvepqFQ8q+prHd6cvWf5YpKmIZ/6dY5ckrdkDG+Cb9x3knOnWo62GMscpCpBvyCqmlq72UZE9lGgPRYO9vLvQpt6n6ZBRcvsWw/2PABBkN6uiOgCxK+yOD6XEeu2zf/hUqD12BcIBRlZ6MHN0psOWifZ0MYHWJZTVIAYfqnKQxtv38Tt18LQWQU7j5kF4pZydRkoxYiQG68D6Wct3Uc1Af/IwT6zkWby26Odf9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Os/L3ofogs4QnE3I4j6ChyfYRUtY/PkOePGOECaI4Rw=;
 b=XS0p9SIQbUw2hbz3kgfL9boi2YDEnv4ZfgFcS19SDOU+JTI063UY7mYWCOQ/FAcLo8BYBspe5l3UIDapVXdmjL3V1gxynbJoYaHjxpT4HPExuBh93QVsfsE8bwdc2VoNsEGLzQOsC7h0WcEjPtFqzU33ciheDrRfOX76BjEH01uHMvzkXwBBsvuc217oIF7KdlAKQh32TmpnGxykvPo9BkbHEDZtmpSK0fCSZsNRAEtouSjrM5mqjPuPCjeGpg3GlhblLkQLuAhhGtdRP9w+HNto3NRcVmx2riYUW7geRqfzP36F5qrxjOuiW6iyJa0rsHk6rJqVonGgP4q8KFjz0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Os/L3ofogs4QnE3I4j6ChyfYRUtY/PkOePGOECaI4Rw=;
 b=SIUtU52KmEIjVdAzSMkzw43JN60lwgwW9mb5JEwJZXGyO/ajajW8uoez8Ru40WfHuI20iwoz2VlJWEkTPCd7XGlKH6pZA3GQ0eUYP2eNzY9bfp0qU00+4cuDVuqARY1J6RCjqgmWaW/B2OV+DoSzwvAPclfi9q094UUmqatI6r0=
Received: from AM5PR0402MB2756.eurprd04.prod.outlook.com
 (2603:10a6:203:99::22) by AM6PR0402MB3414.eurprd04.prod.outlook.com
 (2603:10a6:209:3::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Tue, 30 Jun
 2020 01:40:04 +0000
Received: from AM5PR0402MB2756.eurprd04.prod.outlook.com
 ([fe80::c9df:97b8:717f:4026]) by AM5PR0402MB2756.eurprd04.prod.outlook.com
 ([fe80::c9df:97b8:717f:4026%11]) with mapi id 15.20.3131.027; Tue, 30 Jun
 2020 01:40:04 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Stefano Stabellini <sstabellini@kernel.org>
Subject: RE: [PATCH] xen: introduce xen_vring_use_dma
Thread-Topic: [PATCH] xen: introduce xen_vring_use_dma
Thread-Index: AQHWSgTusARd8c8cRkWwDit233DtZajneYoAgACU6oCAAC7QAIAAEpoAgAAGSwCAAUK2gIABcSaAgAPk6cCAAVzJgIAAHp3A
Date: Tue, 30 Jun 2020 01:40:04 +0000
Message-ID: <AM5PR0402MB2756BA362026DAF70E837420886F0@AM5PR0402MB2756.eurprd04.prod.outlook.com>
References: <20200624091732.23944-1-peng.fan@nxp.com>
 <20200624050355-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006241047010.8121@sstabellini-ThinkPad-T480s>
 <20200624163940-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006241351430.8121@sstabellini-ThinkPad-T480s>
 <20200624181026-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006251014230.8121@sstabellini-ThinkPad-T480s>
 <20200626110629-mutt-send-email-mst@kernel.org>
 <DB6PR0402MB27601CA74B85DA5A9F5E5DD6886E0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <alpine.DEB.2.21.2006291647450.8121@sstabellini-ThinkPad-T480s>
In-Reply-To: <alpine.DEB.2.21.2006291647450.8121@sstabellini-ThinkPad-T480s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b75792b5-e5d1-4c0b-081b-08d81c968338
x-ms-traffictypediagnostic: AM6PR0402MB3414:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0402MB3414ED6BCC162E89C32AE960886F0@AM6PR0402MB3414.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7WCT6RiseFesBShkHVBnV2FCzUhsw8gvSHLEH4mVyVFri8AEkPA8XiQbkCXUGwvzDPU96bmzhKzktp9QQ8+2zquY5HE4fNyyop0COeDZ1Yh+ULDSAy2ShKl3GJiDcIIW7LmwPT0Qxen574QCunXvZpNgS7DrgumeytRCOuhAlaQl3xAZdeQd4cq2GghAwMSAICfZkV/OcEprRoY+BEkxCgv8TFPVhgAxDZFmqWzSY3UbshN5yGyifVbcaRYnOrFsVuGH7/2NCumsioPwhk7PChPmh9Ch7tp0rG9Mp2sO9GTyntnrehdCNjzBEkAXCBAXwY3awM6R5m4zsfVLB8oEAw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM5PR0402MB2756.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(4326008)(33656002)(71200400001)(54906003)(55016002)(478600001)(2906002)(8936002)(316002)(64756008)(66946007)(5660300002)(186003)(8676002)(26005)(66446008)(66556008)(66476007)(7416002)(76116006)(6506007)(86362001)(6916009)(7696005)(9686003)(44832011)(83380400001)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: GbS6ZBFkKhkkm1Av9YeK/lLrX4eW+v1S3Pktq12AahC54zKYzQ0h5BG6y1U208oNrMiHKAHpWB5ADzCekfPXNt0MSZvZlXwtkqiSgolUHeRHwU1xOiO8C+NtQbTYvyx5hayI2/pgdqAILf34V6KbeebG1W8js5rAp+u6mbgKXBlz/uj8fv8NqVkoOEVgd93U9MF2tOeBkDDfuUT7i1nxX4xblTqQW6Tshry9o6oFPmf7C46N/6vP4u1/J0oZxfXsiNnHlPkr9R11M1r2NtqkCsiKt/MFxoUvoQYlud2Diw9ozlmUCIxXZGg/pFuGqSpzsa0tcFZoRe5JLF2bqRwfhsfeNo9EXqWlfxGEPvCrlyA/GD01n2p/Lx5ZpWF3sjlp9iTMtMvOy7fKfTSW7Q6zQ8pul+sGAzrNHr/xLKbi9y3OoO7uXsH8fHWRIi+R6x1Gyu9hlZDpBynAOCPsaxDYHj85waI6oCswKUkQvz+LXmcw8aBx3d84IZ8OzExQ40tv
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM5PR0402MB2756.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b75792b5-e5d1-4c0b-081b-08d81c968338
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 01:40:04.4195 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vptcANgzBq7lW9lMrp9tt+P5TCgJqX/u4747fKLCGFJF81+HJ12Z2GtjIoBRNLnsmx9joyCF9ud7c8Ld/2F8Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3414
Cc: "jgross@suse.com" <jgross@suse.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, dl-linux-imx <linux-imx@nxp.com>,
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

> Subject: RE: [PATCH] xen: introduce xen_vring_use_dma
> 
> On Mon, 29 Jun 2020, Peng Fan wrote:
> > > > If that is the case, how is it possible that virtio breaks on ARM
> > > > using the default dma_ops? The breakage is not Xen related (except
> > > > that Xen turns dma_ops on). The original message from Peng was:
> > > >
> > > >   vring_map_one_sg -> vring_use_dma_api
> > > >                    -> dma_map_page
> > > >   		       -> __swiotlb_map_page
> > > >   		                ->swiotlb_map_page
> > > >   				->__dma_map_area(phys_to_virt(dma_to_phys(dev,
> > > dev_addr)), size, dir);
> > > >   However we are using per device dma area for rpmsg, phys_to_virt
> > > >   could not return a correct virtual address for virtual address in
> > > >   vmalloc area. Then kernel panic.
> > > >
> > > > I must be missing something. Maybe it is because it has to do with
> RPMesg?
> > >
> > > I think it's an RPMesg bug, yes
> >
> > rpmsg bug is another issue, it should not use dma_alloc_coherent for
> > reserved area, and use vmalloc_to_page.
> >
> > Anyway here using dma api will also trigger issue.
> 
> Is the stack trace above for the RPMesg issue or for the Trusty issue?

The stack trace you pasted is rpmsg issue.

> If it is the stack trace for RPMesg, can you also post the Trusty stack trace? Or
> are they indentical?

There is no stack dump here. It successfully using swiotlb to do a map,
but we actually no need swiotlb in domu to do the map.

Thanks,
Peng.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
