Return-Path: <SRS0=1Id5=UF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CA8C04AB5
	for <iommu@archiver.kernel.org>; Thu,  6 Jun 2019 05:54:02 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E50C2070B
	for <iommu@archiver.kernel.org>; Thu,  6 Jun 2019 05:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="RRfgQp6h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E50C2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 178C8255;
	Thu,  6 Jun 2019 05:54:02 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3C7A52F
	for <iommu@lists.linux-foundation.org>;
	Thu,  6 Jun 2019 05:54:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
	(mail-eopbgr1400105.outbound.protection.outlook.com [40.107.140.105])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4D1F5A8
	for <iommu@lists.linux-foundation.org>;
	Thu,  6 Jun 2019 05:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=CF7dgdLsljFTzBrGIHTax3oqN4WWMt13dT0Gdc6+aYA=;
	b=RRfgQp6hpsTO3dlk2KhJBJEKrLj/QML9LxqOTxTKyvkmzjkC9tQ0lHzTUHeRcT50DZP7yWyHAcyof9cpuCAtk00z7GPVjVPstK8q9+ga3okhe7biKGf/X3OCxQAbat7lAnk1Vs7zrwEI5OgW8TBUJ7edBskV8ycbE8jCNAcwdlU=
Received: from OSAPR01MB3089.jpnprd01.prod.outlook.com (52.134.247.150) by
	OSAPR01MB3364.jpnprd01.prod.outlook.com (20.178.100.211) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1965.12; Thu, 6 Jun 2019 05:53:56 +0000
Received: from OSAPR01MB3089.jpnprd01.prod.outlook.com
	([fe80::19ad:b6ce:a287:dc85]) by
	OSAPR01MB3089.jpnprd01.prod.outlook.com
	([fe80::19ad:b6ce:a287:dc85%7]) with mapi id 15.20.1943.018;
	Thu, 6 Jun 2019 05:53:56 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: RE: [RFC PATCH v5 3/8] iommu: add a new capable IOMMU_CAP_MERGING
Thread-Topic: [RFC PATCH v5 3/8] iommu: add a new capable IOMMU_CAP_MERGING
Thread-Index: AQHVG5AuSNIEYbUj60Sza33KteoVlaaM+2qAgAEa6pA=
Date: Thu, 6 Jun 2019 05:53:56 +0000
Message-ID: <OSAPR01MB3089C968A7434A635AF5B7C2D8170@OSAPR01MB3089.jpnprd01.prod.outlook.com>
References: <1559733114-4221-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1559733114-4221-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<7dfeb7d8-b777-b4af-d892-2829cd05241b@arm.com>
In-Reply-To: <7dfeb7d8-b777-b4af-d892-2829cd05241b@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [118.238.235.108]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e95900e7-74e4-4e02-4c8c-08d6ea435d2f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
	SRVR:OSAPR01MB3364; 
x-ms-traffictypediagnostic: OSAPR01MB3364:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <OSAPR01MB33649590CB859A99E54D00DAD8170@OSAPR01MB3364.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(376002)(346002)(39860400002)(396003)(136003)(52314003)(189003)(199004)(5660300002)(74316002)(305945005)(316002)(186003)(11346002)(26005)(4326008)(486006)(476003)(25786009)(73956011)(14444005)(76116006)(66946007)(68736007)(446003)(478600001)(256004)(52536014)(8676002)(81156014)(86362001)(81166006)(7736002)(66446008)(66556008)(66476007)(64756008)(76176011)(54906003)(6306002)(6916009)(6116002)(3846002)(229853002)(6436002)(8936002)(14454004)(966005)(66066001)(71200400001)(71190400001)(53936002)(6246003)(9686003)(55016002)(7696005)(33656002)(99286004)(6506007)(102836004)(2906002)(6606295002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:OSAPR01MB3364;
	H:OSAPR01MB3089.jpnprd01.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: renesas.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hcGinsUpvTax+GpQ+JKZxQEx25r6H8EKpmq8wtT6a4/T1DcRoNGrxYB0CF426TijEb9G8pPcKfAe2CaWQ1CfJ9+KRz8y0v8rRK0IlNmvZK1ml0C7cMuMr92h87x3dydWBeRV0qTAd6VXWYHH6OSnWXXh8/ScTXzDlNA7xcYuDPrDZ7WOQThFqdPoHQQSYpx/d81oFMwQ/nB6xWDJ6syuknfbDXJaPvUea9o0/OdRqeln8tfbVXLPrL4MaUiZVAGxAkt0BrsbhZz3wqCQUfw7PHGpEE2xL4t7DmVpP3XBdCxvDDomVILCzdLR521sA9JrSb5NlKXB0OXTxAGpIEZWs0Y+kd8hfPPvVHXaT8ZvcOrlBmRoWvMPVCUo+We0Wbs7OqnplDeD+muLJgGpcXd7FQmv9IXesL2/MNvf7+wT5JA=
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e95900e7-74e4-4e02-4c8c-08d6ea435d2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 05:53:56.4904 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yoshihiro.shimoda.uh@renesas.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3364
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"hch@lst.de" <hch@lst.de>
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

Hi Robin,

Thank you for your comments!

> From: Robin Murphy, Sent: Wednesday, June 5, 2019 9:22 PM
<snip>
> > @@ -902,8 +914,18 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
> >   	if (iommu_map_sg(domain, iova, sg, nents, prot) < iova_len)
> >   		goto out_free_iova;
> >
> > -	return __finalise_sg(dev, sg, nents, iova);
> > +	ret = __finalise_sg(dev, sg, nents, iova);
> > +	/*
> > +	 * Check whether the sg entry is single if a device requires and
> > +	 * the IOMMU driver has the capable.
> > +	 */
> > +	if (iova_contiguous && ret != 1)
> > +		goto out_unmap_sg;
> 
> I don't see that just failing really gives this option any value.
> Clearly the MMC driver has to do *something* to handle the failure (plus
> presumably the case of not having IOMMU DMA ops at all), which begs the
> question of why it couldn't just do whatever that is anyway, without all
> this infrastructure. For starters, it would be a far simpler and less
> invasive patch:
> 
> 	if (dma_map_sg(...) > 1) {
> 		dma_unmap_sg(...);
> 		/* split into multiple requests and try again */
> 	}

I understood it.

> But then it would make even more sense to just have the driver be
> proactive about its special requirement in the first place, and simply
> validate the list before it even tries to map it:
> 
> 	for_each_sg(sgl, sg, n, i)
> 		if ((i > 0 && sg->offset % PAGE_SIZE) ||
> 		    (i < n - 1 && sg->length % PAGE_SIZE))
> 			/* segment will not be mergeable */

In previous version, I made such a code [1].
But, I think I misunderstood Christoph's comments [2] [3].

[1]
https://patchwork.kernel.org/patch/10970047/

[2]
https://marc.info/?l=linux-renesas-soc&m=155956751811689&w=2

[3]
https://marc.info/?l=linux-renesas-soc&m=155852814607202&w=2

> For reference, I think v4l2 and possibly some areas of DRM already do
> something vaguely similar to judge whether they get contiguous buffers
> or not.

I see. I'll check these areas later.

> > +
> > +	return ret;
> >
> > +out_unmap_sg:
> > +	iommu_dma_unmap_sg(dev, sg, nents, dir, attrs);
> >   out_free_iova:
> >   	iommu_dma_free_iova(cookie, iova, iova_len);
> >   out_restore_sg:
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 91af22a..f971dd3 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -104,6 +104,7 @@ enum iommu_cap {
> >   					   transactions */
> >   	IOMMU_CAP_INTR_REMAP,		/* IOMMU supports interrupt isolation */
> >   	IOMMU_CAP_NOEXEC,		/* IOMMU_NOEXEC flag */
> > +	IOMMU_CAP_MERGING,		/* IOMMU supports segments merging */
> 
> This isn't a 'capability' of the IOMMU - "segment merging" equates to
> just remapping pages, and there's already a fundamental assumption that
> IOMMUs are capable of that. Plus it's very much a DMA API concept, so
> hardly belongs in the IOMMU API anyway.

I got it.

> All in all, I'm struggling to see the point of this. Although it's not a
> DMA API guarantee, iommu-dma already merges scatterlists as aggressively
> as it is allowed to, and will continue to do so for the foreseeable
> future (since it avoids considerable complication in the IOVA
> allocation), so if you want to make sure iommu_dma_map_sg() merges an
> entire list, just don't give it a non-mergeable list.

Thank you for the explanation. I didn't know that a driver should not
give it a non-mergeable list.

> And if you still
> really really want dma_map_sg() to have a behaviour of "merge to a
> single segment or fail", then that should at least be a DMA API
> attribute, which could in principle be honoured by bounce-buffering
> implementations as well.

I got it. For this patch series, it seems I have to modify a block layer
so that such a new DMA API is not needed though.

> And if the problem is really that you're not getting merging because of
> exposing the wrong parameters to the DMA API and/or the block layer, or
> that you just can't quite express your requirement to the block layer in
> the first place, then that should really be tackled at the source rather
> than worked around further down in the stack.

I'll reply on Christoph email about this topic later.

Best regards,
Yoshihiro Shimoda

> Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
