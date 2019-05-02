Return-Path: <SRS0=NDwq=TC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6923C04AAA
	for <iommu@archiver.kernel.org>; Thu,  2 May 2019 09:06:47 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 875E5206DF
	for <iommu@archiver.kernel.org>; Thu,  2 May 2019 09:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rkIIYT8a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 875E5206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 59CE43047;
	Thu,  2 May 2019 09:06:46 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 83730303B
	for <iommu@lists.linux-foundation.org>;
	Thu,  2 May 2019 09:05:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
	(mail-eopbgr140055.outbound.protection.outlook.com [40.107.14.55])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D319B711
	for <iommu@lists.linux-foundation.org>;
	Thu,  2 May 2019 09:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=qdC19H38zi5+A8RC77iYiWFkQGBZunhUFHwr1Ygr+sc=;
	b=rkIIYT8addpS7I+Ki1RBiiRjIhyTvCoM0Z3OeuNNbxzduj29iI4gaIblWxo3h4n0qo0ZnVXInn8FND5TC9UYZKgNo0T36oZ74tQP/JEjKdFZKIOUfPfM3TlInUTO7U+w+cMlQbi03AlQHwpgZKMyrmTv5Mk2IUdoagpl7uSn8GE=
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com (20.177.50.159) by
	VI1PR04MB4253.eurprd04.prod.outlook.com (52.134.31.28) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1856.10; Thu, 2 May 2019 09:05:41 +0000
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com
	([fe80::81d8:f74b:f91e:f071]) by
	VI1PR04MB5134.eurprd04.prod.outlook.com
	([fe80::81d8:f74b:f91e:f071%7]) with mapi id 15.20.1835.018;
	Thu, 2 May 2019 09:05:41 +0000
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: "jocke@infinera.com" <joakim.tjernlund@infinera.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Madalin-cristian Bucur
	<madalin.bucur@nxp.com>, Leo Li <leoyang.li@nxp.com>, Roy Pledge
	<roy.pledge@nxp.com>, Camelia Alexandra Groza <camelia.groza@nxp.com>
Subject: RE: [PATCH v2 9/9] dpaa_eth: fix SG frame cleanup
Thread-Topic: [PATCH v2 9/9] dpaa_eth: fix SG frame cleanup
Thread-Index: AQHU/MhUOSfNbgWjXk28jO3/UbT5S6ZQPsaAgAdTq4A=
Date: Thu, 2 May 2019 09:05:41 +0000
Message-ID:
 <VI1PR04MB5134C0D6707E78D674B96898EC340@VI1PR04MB5134.eurprd04.prod.outlook.com>
References: <20190427071031.6563-1-laurentiu.tudor@nxp.com>
	<20190427071031.6563-10-laurentiu.tudor@nxp.com>
	<2c6f5d170edab346e0a87b1dfeb12e2f65801685.camel@infinera.com>
In-Reply-To: <2c6f5d170edab346e0a87b1dfeb12e2f65801685.camel@infinera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd868a55-ef45-47d3-4c6b-08d6cedd5a3e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:VI1PR04MB4253; 
x-ms-traffictypediagnostic: VI1PR04MB4253:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <VI1PR04MB4253D8E678A58DD5115D9743EC340@VI1PR04MB4253.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(376002)(346002)(39860400002)(366004)(136003)(396003)(199004)(189003)(13464003)(8936002)(5660300002)(229853002)(8676002)(99286004)(256004)(66066001)(25786009)(14444005)(2906002)(6436002)(55016002)(76116006)(486006)(44832011)(14454004)(74316002)(86362001)(53936002)(2501003)(66556008)(9686003)(66446008)(64756008)(7696005)(66476007)(66946007)(73956011)(316002)(54906003)(110136005)(6246003)(446003)(11346002)(6506007)(4326008)(76176011)(71200400001)(81156014)(71190400001)(68736007)(81166006)(476003)(186003)(478600001)(7736002)(52536014)(305945005)(102836004)(6116002)(3846002)(26005)(33656002)(6636002)(491001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4253;
	H:VI1PR04MB5134.eurprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mOmsPNF9QNL8W5itImUGGLc7AK6Em/IIvhIZKNexYmzVGd2mFgHqrZ9peg8anXyPh9GFF1JEpusyNkFlzgotURUbLsemaYx8Kjl+SPvVS2ZsBr7l5v3W+jCc7dW6RmlcxTOigKPpTAVluSWv6UFRxeMdP7Sxj9x65gjSlYWDOGjvBGEx5ZPLUB47XSGOuXPmM0rJye7Jx9YaDh9aHzVP0SVU10p8wxRTbamMo332n6OlOZvnA8e/Vxq4ynopQFF/goVcb9vPUgU25GnyevbvFTK1pGG5S5ljnmO/W8elvuga6k17JWO0K44RyD/cWWXeZvzYwwO9bAiEAKvVVJTQFuayGautV4+N9YNyX81kZDHilDHvs+NNKYH9iiO7GtHuOW+Cl9lOzjc3E61rdSqwrvbgsQW6ief0jHdgvg3cY18=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd868a55-ef45-47d3-4c6b-08d6cedd5a3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 09:05:41.5379 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4253
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"davem@davemloft.net" <davem@davemloft.net>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190502090541.tHMEJoQcWuuhtnquzoNxvUsNDjOfLY1sc6w0f9uwLR8@z>

Hi Joakim,

> -----Original Message-----
> From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
> Sent: Saturday, April 27, 2019 8:11 PM
> 
> On Sat, 2019-04-27 at 10:10 +0300, laurentiu.tudor@nxp.com wrote:
> > From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >
> > Fix issue with the entry indexing in the sg frame cleanup code being
> > off-by-1. This problem showed up when doing some basic iperf tests and
> > manifested in traffic coming to a halt.
> >
> > Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > Acked-by: Madalin Bucur <madalin.bucur@nxp.com>
> 
> Wasn't this a stable candidate too?

Yes, it is. I forgot to add the cc:stable tag, sorry about that.

---
Best Regards, Laurentiu
 
> > ---
> >  drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> > index daede7272768..40420edc9ce6 100644
> > --- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> > +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> > @@ -1663,7 +1663,7 @@ static struct sk_buff *dpaa_cleanup_tx_fd(const
> struct dpaa_priv *priv,
> >                                  qm_sg_entry_get_len(&sgt[0]), dma_dir);
> >
> >                 /* remaining pages were mapped with skb_frag_dma_map()
> */
> > -               for (i = 1; i < nr_frags; i++) {
> > +               for (i = 1; i <= nr_frags; i++) {
> >                         WARN_ON(qm_sg_entry_is_ext(&sgt[i]));
> >
> >                         dma_unmap_page(dev, qm_sg_addr(&sgt[i]),
> > --
> > 2.17.1
> >

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
