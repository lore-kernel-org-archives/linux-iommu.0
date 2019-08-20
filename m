Return-Path: <SRS0=xQF/=WQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28F7C3A5A1
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 01:42:23 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF04322CE8
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 01:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="Nhvc6WHY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF04322CE8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 72D3DCA6;
	Tue, 20 Aug 2019 01:42:23 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2EB55C64
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 01:42:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
	(mail-eopbgr1400127.outbound.protection.outlook.com [40.107.140.127])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 374EA67F
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 01:42:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=LHrXkRfOyof8zw4GLeNlzQIHOQW2Q5mV+TefLSg5GiU7feJwuDQ6NE8C9g7QR2iDUj/dxSNE/4TiLnhiYtUOizRC+0FWHsYtyIEIuWqemRWzmcOBzC3Zq9E+lN/pxe5xht7bre5M1brUKd43e/JCg2Rbr04zqIU5TIkYlOQsBq3is8mn40GMInOa43Tx5DDStkec4vz28tVJM6LycB5YU/fKnS9za/niRgqAwljJSA3Sl5KNGHtks2ygGU+M17ev37A88R6wgsVST8ZylQaK7PCvz5+a2AwkNW2J4D2Buj/qbcma1G+nni+4aA/EfYA3M3LDy7icKAwrrOsiTVpfNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=VuFsc4QCpeN5MWdsfnCavBMARojnbQftklZ+JYr+nGY=;
	b=QHkqGe2da4CbgBs5F03hqY8DYCCiT7MxqqKT0+/+crpE09pWbHnJtyteEz6a2yLRTxKpF/0Pv5CHT3w3ghyiss+c9dQY+4r5wFWg3RCzTI3J67cOtg0OXSlkDuA2fNeRKMr+YH6osoW+0ZW3tDe+KqzFiValGIDfmhd22NfFC9N3glBUhiLMpOyPs2+n5WsCW4sQENAKAI/+wOwFjM7Ra/1cqYHZJMlKIdIxOGURc1NmkVMVvsNYNPMzOL7g2TvQxGh4xOVAALALCEfAxphxnNI0JXLGC8doSYDqHixCy8HHBQWcyO1te/vDSCDFb7qVhvZKVIom5i44zAN8hxknbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
	smtp.mailfrom=renesas.com;
	dmarc=pass action=none header.from=renesas.com; 
	dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=VuFsc4QCpeN5MWdsfnCavBMARojnbQftklZ+JYr+nGY=;
	b=Nhvc6WHY6PdrZrftwtLxgmLOXISktkD1xCPHrS2IKqyY7I6V45E6JsKoB4mZGw3VS+U8AccpyMMUcOJ89YM4lL2ojk4ZFkjUG6rX5h8O27OD0HnyTKAc+ETKB9bQLKkp6zuPZvDul3WMf2BsVIYfwq3tZXQ+9jVW/iz/PFGiMUQ=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
	TYAPR01MB2477.jpnprd01.prod.outlook.com (20.177.101.205) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2178.18; Tue, 20 Aug 2019 01:42:18 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
	([fe80::6564:f61f:f179:facf]) by
	TYAPR01MB4544.jpnprd01.prod.outlook.com
	([fe80::6564:f61f:f179:facf%5]) with mapi id 15.20.2178.018;
	Tue, 20 Aug 2019 01:42:18 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: RE: [PATCH v9 2/5] iommu/dma: Add a new dma_map_ops of
	get_merge_boundary()
Thread-Topic: [PATCH v9 2/5] iommu/dma: Add a new dma_map_ops of
	get_merge_boundary()
Thread-Index: AQHVQ4ypPSzm8K7UpEaJjj39WHup9acCk4MAgADUWRA=
Date: Tue, 20 Aug 2019 01:42:18 +0000
Message-ID: <TYAPR01MB4544A7A255738624E2A405C9D8AB0@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1564129876-28261-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1564129876-28261-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<312d6e38-5143-fb07-1efb-01e60cafa2c9@arm.com>
In-Reply-To: <312d6e38-5143-fb07-1efb-01e60cafa2c9@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [118.238.235.108]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b87e956-c552-4312-d6be-08d7250fa2f6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
	SRVR:TYAPR01MB2477; 
x-ms-traffictypediagnostic: TYAPR01MB2477:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <TYAPR01MB247747EE531DE19F6EFA8AD7D8AB0@TYAPR01MB2477.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(189003)(199004)(55016002)(7736002)(6306002)(9686003)(33656002)(229853002)(478600001)(74316002)(6116002)(6916009)(3846002)(966005)(305945005)(316002)(6436002)(99286004)(256004)(25786009)(66446008)(64756008)(66946007)(66556008)(66476007)(76116006)(86362001)(26005)(8936002)(446003)(11346002)(81166006)(81156014)(476003)(8676002)(186003)(76176011)(53546011)(6506007)(7696005)(486006)(52536014)(102836004)(71200400001)(71190400001)(14454004)(54906003)(66066001)(7416002)(5660300002)(2906002)(4326008)(53936002)(6246003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:TYAPR01MB2477;
	H:TYAPR01MB4544.jpnprd01.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: renesas.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kl8OpN7lYzC4vbOThP5DN99YVOHxr2MpBWv1ST0JWuzAqNa3hZMvPIUzegR0dZh/7THk2FnTmY7nfDk7j+3SpvO2YaqfKzz0Gg7Ur8j64k+knXkRCSNmmirESz5KuAjeVQNMnCYO8g0waCDD72uzd2WNLTcmBtDDN1WSolwb6fVPiNJJJ2L4Diy26z8/OWkxqg1HBUjvDg+JmJTTEFofnuPPVoAeXJ9+EFJcGlq0+iVENHTs1cXyBL0HGoOm+CcBdBpOhd6J9W7GpLnuLzAvZyepuNw+rgGEKSB79elOOYYH9bmD3noZLY20FTVQEtmFye3OJd9JPhnMfa3ub9rZSEemXs6o000E6pvTzC0tj/OCr6fOzhWoQzgV1Ubf+Xl0GbKulGgei0WhPOw46R8nPjCa8Hcbds+t1U8kvu1Vlfk=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b87e956-c552-4312-d6be-08d7250fa2f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 01:42:18.3318 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F63FI09Ne1LiuvNJ/MAdzxBa4naQ1Nt0yEMnKijpDCX1friPSVRV3fSlnNQ2dZrkY05J1DWj0QOgo/ibqOl+/jQbNOlgoV6gSK+7nNXuScExIsZ9Z/vCEtjW+BWNRaHo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2477
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
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

> From: Robin Murphy, Sent: Monday, August 19, 2019 9:55 PM
> 
> On 26/07/2019 09:31, Yoshihiro Shimoda wrote:
> > This patch adds a new dma_map_ops of get_merge_boundary() to
> > expose the DMA merge boundary if the domain type is IOMMU_DOMAIN_DMA.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >   drivers/iommu/dma-iommu.c | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index a7f9c3e..2992ce4 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -1085,6 +1085,16 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
> >   	return ret;
> >   }
> >
> > +static unsigned long iommu_dma_get_merge_boundary(struct device *dev)
> > +{
> > +	struct iommu_domain *domain = iommu_get_dma_domain(dev);
> > +
> > +	if (domain->type != IOMMU_DOMAIN_DMA)
> 
> Did you actually need this check? In principle, if the default domain is
> not of type IOMMU_DOMAIN_DMA then the device should be assigned
> dma_direct_ops rather than iommu_dma_ops, thus it shouldn't be possible
> to get here. If you did manage to hit a case where the domain type
> didn't match the ops it would be interesting to figure out how.

Thank you for your review! You're correct. The current dma-iommu.c sets
the iommu_dma_ops to the device dma_ops only when the type is IOMMU_DOMAIN_DMA
like below:
---
	if (domain->type == IOMMU_DOMAIN_DMA) {
		if (iommu_dma_init_domain(domain, dma_base, size, dev))
			goto out_err;
		dev->dma_ops = &iommu_dma_ops;
	}
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iommu/dma-iommu.c#n1118
---

So, I'll remove this check.

Best regards,
Yoshihiro Shimoda

> Robin.
> 
> > +		return 0;	/* can't merge */
> > +
> > +	return (1UL << __ffs(domain->pgsize_bitmap)) - 1;
> > +}
> > +
> >   static const struct dma_map_ops iommu_dma_ops = {
> >   	.alloc			= iommu_dma_alloc,
> >   	.free			= iommu_dma_free,
> > @@ -1100,6 +1110,7 @@ static const struct dma_map_ops iommu_dma_ops = {
> >   	.sync_sg_for_device	= iommu_dma_sync_sg_for_device,
> >   	.map_resource		= iommu_dma_map_resource,
> >   	.unmap_resource		= iommu_dma_unmap_resource,
> > +	.get_merge_boundary	= iommu_dma_get_merge_boundary,
> >   };
> >
> >   /*
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
