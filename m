Return-Path: <SRS0=7g3a=6M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAF5C83004
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 08:22:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05E342064A
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 08:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ndxswZIS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E342064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 142C087B05;
	Tue, 28 Apr 2020 08:22:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8wh81fjS3Zqu; Tue, 28 Apr 2020 08:22:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C6C3A875F4;
	Tue, 28 Apr 2020 08:22:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7ED3C0864;
	Tue, 28 Apr 2020 08:22:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47561C0172
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 08:22:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id F018522008
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 08:22:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TLsYfonMlAzG for <iommu@lists.linux-foundation.org>;
 Tue, 28 Apr 2020 08:22:02 +0000 (UTC)
X-Greylist: delayed 00:24:04 by SQLgrey-1.7.6
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80074.outbound.protection.outlook.com [40.107.8.74])
 by silver.osuosl.org (Postfix) with ESMTPS id 90C702155C
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 08:22:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5H2aIphdnPovewkY4VGFM4sEWxGucBW08FKFscQtKPSo9JzDk83sn//dkPshb8CeHlyiwcMQWK7JlKSFG8m2gPT15fGczgFqHJKnXQrMydMTfwCmRYvE137VjCp9vzSaG2zx5y8ROWCU3wSIH1xlLCVaF0VBnL7BiN5RDU9ejiwwEeN+Gc3aILVhr8ppOqlcwkmHNVLLmK/JGSfrcxWp6h9LwDgo0Ht9va0l5JwI0gXyaZ9KDHx5Jahb3+MQeUBhIh0Y01LTKxDCpODY+lGL+j+7CJEGMmxR9Wk9WL3riy6Yjnv5sECpgr4RStHdaR6wdX09SuXbQQxs/zapVBk9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQixSruRATExyVZtZCrE5ENirdmhwGn1bocmC67jGto=;
 b=JWTlSPsac0kD2VNKVZCJuqVb8yJeVNJrGdMB2QQkeBHzICO4rhsDXXCdamZegwYAI9PymtAvRHupoCXQhG6AHjN3Z8XTFy9CImnCWTy/LFi2Pxd9YjIvjXSO8nPTTEu55yqOIGxyMDgvJqWrojnQiWbW4ewiA0VydSyIn+bF+pqEp50DhmzcrWAaaUWZZf21X/VHRdWzr1FE+dzvIkINks9JygKiWZ3zX56b3O9II45qjrnu9loXz4TJWEJ6SdF2q9+/12dL1DK8pH0YmLE9fRZmviR2iW89hEaLPTm4QQAiK5fkYM+vJ1dRMdB9j/kA/PiGVpFoJz2JymrHkGjn0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQixSruRATExyVZtZCrE5ENirdmhwGn1bocmC67jGto=;
 b=ndxswZISDVn8wI6Z0pa9Aw8u9R77/2lMLv4rcsuApcCCn+mP/W1rpAYxiMQzTd4tb8hOffvPNImYOHoGljIltHbV0B3IDSfINwfj24ABLEO5cSQ8yRPKvcYEYef4Cj8ab5WxMjTdLR3Fv1cNwzn0z0+kwjGYGGkptDJ05hULEhA=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2711.eurprd04.prod.outlook.com (2603:10a6:4:96::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Tue, 28 Apr
 2020 08:21:57 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 08:21:57 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: RE: [PATCH] xen/swiotlb: correct the check for
 xen_destroy_contiguous_region
Thread-Topic: [PATCH] xen/swiotlb: correct the check for
 xen_destroy_contiguous_region
Thread-Index: AQHWHTCUGLGxU19LnkuMxSfwKxPy/aiOLEEAgAAFDsA=
Date: Tue, 28 Apr 2020 08:21:57 +0000
Message-ID: <DB6PR0402MB2760981C819B03D6B5647E9288AC0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1588059225-11245-1-git-send-email-peng.fan@nxp.com>
 <20200428080210.GA25643@infradead.org>
In-Reply-To: <20200428080210.GA25643@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3a00cf67-1e01-4158-e862-08d7eb4d37b0
x-ms-traffictypediagnostic: DB6PR0402MB2711:|DB6PR0402MB2711:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0402MB2711A6F924BF5D255E08D54E88AC0@DB6PR0402MB2711.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0387D64A71
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB6PR0402MB2760.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(66946007)(8936002)(66476007)(9686003)(2906002)(52536014)(6506007)(5660300002)(44832011)(186003)(6916009)(54906003)(478600001)(4326008)(76116006)(66446008)(26005)(86362001)(316002)(8676002)(7696005)(55016002)(33656002)(81156014)(64756008)(66556008)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VM71IWGXE3SwEEh2mDk7gfmURNYDtfOPiQj91KRW0oVO6zySpVZux+pfJsu72Otvr8aotNQYOSehTedrTwzWpe1QoVKsPaxrBS2uJCZRz+k/Ti/FWihC/qhket7/H2A/dMro2leaDWFfiTkyQi86o/3oB3pmCKu8vNgH/IYlbKxN5gpPbHfNmRG5e34YbWRwnWCQFF/QcH8gLKhrPS6VGCYrDwwfUV6BZu/bIJcY2Pb72ldDOY8LcrTM99B4lsLlp8UPK8/bf+pkYiLHmF45rW2YfNHxWUqCKg9Z+OL16I2/K4FhUxIHpylsugUhfh61KPY+KQTkEgSTJT1J08RkMx+hP/LjJtCqlZyFZf56x9eqls093YNM/AgCmP6VCKc6n1+aTJh46jQr/BGhjwKwxV7IJgNfC1PJp/4UYYs+6OGpDK6ZaFoIWdIAP65LFy7t
x-ms-exchange-antispam-messagedata: bYjanyY2rDDlFDlA3j/qvRVrfl4J6802rWDkQ9uV/kKT/zwxdiUtD/47rXKxWNUTmHQrbuCQhq603T2gXVvQzykLu5y60RQ84yZVpOhSallw4eSExSHMZW1XHVbKtLKBEGbUplGBinzav8gLdlwMow8DalH0SJSmqGT+hmj6+dxJYjlL6SgJw8idJG6sPgM8aPuISLKzvThngtJ+Ix26DQ+t+oulWLL/O30DXZY0RSJCrcszh0DLLstawAbkKGBmZJGGj0XvWYkvSFErdSRfWCgJoGtYgkQ2ImGT1Zk5Yx5p+X/Yd2hnQBmbzXep/NIZjqROsLkCe0s4bee8YNggotbfKcsADeoqKqVzlHEHLXMDmAsSELO6OPaH3uCBOcauDGY5IeB/WZU1ubK5Kq4t0+zvyon1lchAHXFvCVPzPP4gjiamBr1uESYi6lJkz71GRGcO2JBreWTWSncwQGIjknVd4HZ8erlKsX/2Io3P2onci7MRpfzoKuVnVCcJSxq+JbnYBJ9E18xw7Mgzz7uOzMrSjYRAaeMl2ZVpUldJ8oKZMu579Zc07Y324gB8bQTIiS9d+ujTCk5NERg3LCppFoI1OaGoBtki8rXtaMIee1wxWTyyZdOcxIkiyp2JboSHiXuQjFXvXhuX8HNmrU9t+cUyw3aU5ehSpRgU0L1Sndha+0H2Qi47DL4G0ervA6cbC6XJRXD7pFDELqg5c9mniNSTdI67onWQMZY/kLSXLSl+P2vUl0yJ0EC42zh4CNCOb+ZpDSnvluQJs7/EcVfk+Hj4DbniN1Y1WRVocXKAIZU=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a00cf67-1e01-4158-e862-08d7eb4d37b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2020 08:21:57.4904 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XDN9/R5qN4ueHEAz+1Qrdqcr+lModtbpD/a/8lw00gnsSqQ6YQ5/jqmVdggcWCIfKhL7RQmhdDqD99sRV+flRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2711
Cc: "jgross@suse.com" <jgross@suse.com>,
 "sstabellini@kernel.org" <sstabellini@kernel.org>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>
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

> Subject: Re: [PATCH] xen/swiotlb: correct the check for
> xen_destroy_contiguous_region
> 
> On Tue, Apr 28, 2020 at 03:33:45PM +0800, peng.fan@nxp.com wrote:
> >
> > In xen_swiotlb_alloc_coherent, if !(dev_addr + size - 1 <= dma_mask)
> > or range_straddles_page_boundary(phys, size) are true, it will create
> > contiguous region. So when free, we need to free contiguous region use
> > upper check condition.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/xen/swiotlb-xen.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> > index b6d27762c6f8..ab96e468584f 100644
> > --- a/drivers/xen/swiotlb-xen.c
> > +++ b/drivers/xen/swiotlb-xen.c
> > @@ -346,8 +346,8 @@ xen_swiotlb_free_coherent(struct device *hwdev,
> size_t size, void *vaddr,
> >  	/* Convert the size to actually allocated. */
> >  	size = 1UL << (order + XEN_PAGE_SHIFT);
> >
> > -	if (!WARN_ON((dev_addr + size - 1 > dma_mask) ||
> > -		     range_straddles_page_boundary(phys, size)) &&
> > +	if (((dev_addr + size - 1 > dma_mask) ||
> > +	    range_straddles_page_boundary(phys, size)) &&
> >  	    TestClearPageXenRemapped(virt_to_page(vaddr)))
> 
> No need for the inner braces.
> 
> But more importantly please factor our a helper that can be used by alloc and
> free to make sure that they always stay in sync.  Something

Thanks for reviewing. I'll take your suggestion in v2. Before that,
I would wait to see if there are more comments in this patch,
because there are several history commits touching this place.

Thanks,
Peng.

> like:
> 
> static inline bool xen_swiotlb_need_contiguous_region(struct device *dev,
> 		phys_addr_t phys, size_t size)
> {
> 
> 	return xen_phys_to_bus(phys) + size - 1 > dev->coherent_dma_mask ||
> 		range_straddles_page_boundary(phys, size)) }

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
