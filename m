Return-Path: <SRS0=NDwq=TC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8640EC43219
	for <iommu@archiver.kernel.org>; Thu,  2 May 2019 12:58:59 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5432A20449
	for <iommu@archiver.kernel.org>; Thu,  2 May 2019 12:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mTS8Vp+p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5432A20449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 15F823146;
	Thu,  2 May 2019 12:58:59 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 980FC313A
	for <iommu@lists.linux-foundation.org>;
	Thu,  2 May 2019 12:58:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
	(mail-eopbgr40051.outbound.protection.outlook.com [40.107.4.51])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B3590189
	for <iommu@lists.linux-foundation.org>;
	Thu,  2 May 2019 12:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=RXKzJUgPgE5wSsL1xuganqMQcLHfdvaxVMsbcvTAPIw=;
	b=mTS8Vp+pAqohTzInZHEYm4TuZ3vryiFF2IiAzSlK0f2CSuUO+QZhTFvnSuRavtAAJoZ84538i3x4QOeWm/Z6l0nzuDc9fKyaGwnRhFnRtZakzkElYTQLduNPOyDbInLbQeGLI/fU9O7C6FHFKCPpy2yX3DXvM0UHEOcX6oEvNG8=
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com (20.177.50.159) by
	VI1PR04MB4430.eurprd04.prod.outlook.com (20.177.55.158) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1856.10; Thu, 2 May 2019 12:58:05 +0000
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com
	([fe80::81d8:f74b:f91e:f071]) by
	VI1PR04MB5134.eurprd04.prod.outlook.com
	([fe80::81d8:f74b:f91e:f071%7]) with mapi id 15.20.1835.018;
	Thu, 2 May 2019 12:58:05 +0000
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: "jocke@infinera.com" <joakim.tjernlund@infinera.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Madalin-cristian Bucur
	<madalin.bucur@nxp.com>, Leo Li <leoyang.li@nxp.com>, Roy Pledge
	<roy.pledge@nxp.com>, Camelia Alexandra Groza <camelia.groza@nxp.com>
Subject: RE: [PATCH v2 9/9] dpaa_eth: fix SG frame cleanup
Thread-Topic: [PATCH v2 9/9] dpaa_eth: fix SG frame cleanup
Thread-Index: AQHU/MhUOSfNbgWjXk28jO3/UbT5S6ZQPsaAgAdTq4CAABnMAIAAIyeg
Date: Thu, 2 May 2019 12:58:04 +0000
Message-ID:
 <VI1PR04MB5134872815E02B053B383C08EC340@VI1PR04MB5134.eurprd04.prod.outlook.com>
References: <20190427071031.6563-1-laurentiu.tudor@nxp.com>
	<20190427071031.6563-10-laurentiu.tudor@nxp.com>
	<2c6f5d170edab346e0a87b1dfeb12e2f65801685.camel@infinera.com>
	<VI1PR04MB5134C0D6707E78D674B96898EC340@VI1PR04MB5134.eurprd04.prod.outlook.com>
	<728fe477849debcc14bb1af01e35bc7b184a0a03.camel@infinera.com>
In-Reply-To: <728fe477849debcc14bb1af01e35bc7b184a0a03.camel@infinera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80670efb-ec53-4f70-4c2e-08d6cefdd122
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:VI1PR04MB4430; 
x-ms-traffictypediagnostic: VI1PR04MB4430:
x-ms-exchange-purlcount: 1
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <VI1PR04MB44307FD8A6DB5FA45E44F0A8EC340@VI1PR04MB4430.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(346002)(396003)(376002)(136003)(366004)(39860400002)(189003)(199004)(13464003)(66556008)(64756008)(7736002)(99286004)(5660300002)(6636002)(26005)(478600001)(8676002)(110136005)(54906003)(186003)(2906002)(66446008)(102836004)(2501003)(76176011)(316002)(229853002)(52536014)(25786009)(66476007)(66946007)(73956011)(76116006)(7696005)(4326008)(6506007)(6246003)(44832011)(6436002)(33656002)(14454004)(6306002)(66066001)(81156014)(55016002)(71200400001)(71190400001)(81166006)(305945005)(8936002)(53936002)(446003)(486006)(3846002)(74316002)(86362001)(11346002)(6116002)(14444005)(256004)(966005)(9686003)(476003)(68736007)(491001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4430;
	H:VI1PR04MB5134.eurprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0LPv1EluzdhCWa85usBocVjm6uEOT0wlatyrvLOoS8VQKA6lbazybzkM3heUWLIGNQcBJoYsGGtKn1hi9xRUVCZOqjI9rGb1bT599gTk/FRLk+snMt/EyPlS7B+P+DWwSVs5RZKzygOGySe5TtC1wegh1AEe6ccQXAqM3sEZpANdpkDzC8zHY2BBBov7+wAosd9cAye1pg4/CuhU8mxizcvUQHLOeB4yTZADM06+ugjksjWhvXMubKMe2RSScskczzJrEEiO9+mjJF7WcorsPhr6nwiJJbYTdWGMpcIZcftlYR3LVUYuXurAODamAmZDTHFlEwCAILbaT+r5kJDf3EUSPz4iq/+63FMIn5tcLQjFyTBA0qPlO6+p/Ri6AZ24mkPHj5j4pbpTtMnuZkihqj2QrP2r9W2ckoqii3WYhZQ=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80670efb-ec53-4f70-4c2e-08d6cefdd122
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 12:58:04.6674 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4430
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
Message-ID: <20190502125804.0GyWCtKsBHv2nPPU-p570-scTpgjLTtU0ghka0i75Xw@z>



> -----Original Message-----
> From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
> Sent: Thursday, May 2, 2019 1:37 PM
> 
> On Thu, 2019-05-02 at 09:05 +0000, Laurentiu Tudor wrote:
> > Hi Joakim,
> >
> > > -----Original Message-----
> > > From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
> > > Sent: Saturday, April 27, 2019 8:11 PM
> > >
> > > On Sat, 2019-04-27 at 10:10 +0300, laurentiu.tudor@nxp.com wrote:
> > > > From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > > >
> > > > Fix issue with the entry indexing in the sg frame cleanup code being
> > > > off-by-1. This problem showed up when doing some basic iperf tests
> and
> > > > manifested in traffic coming to a halt.
> > > >
> > > > Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > > > Acked-by: Madalin Bucur <madalin.bucur@nxp.com>
> > >
> > > Wasn't this a stable candidate too?
> >
> > Yes, it is. I forgot to add the cc:stable tag, sorry about that.
> 
> Then this is a bug fix that should go directly to linus/stable.
> 
> I note that
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/drivers/net/ethernet/freescale/dpaa?h=linux-4.19.y

Not sure I understand ... I don't see the patch in the link.

> is in 4.19 but not in 4.14 , is it not appropriate for 4.14?

I think it makes sense to go in both stable trees.

---
Best Regards, Laurentiu

> >
> > > > ---
> > > >  drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> > > b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> > > > index daede7272768..40420edc9ce6 100644
> > > > --- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> > > > +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> > > > @@ -1663,7 +1663,7 @@ static struct sk_buff
> *dpaa_cleanup_tx_fd(const
> > > struct dpaa_priv *priv,
> > > >                                  qm_sg_entry_get_len(&sgt[0]),
> dma_dir);
> > > >
> > > >                 /* remaining pages were mapped with
> skb_frag_dma_map()
> > > */
> > > > -               for (i = 1; i < nr_frags; i++) {
> > > > +               for (i = 1; i <= nr_frags; i++) {
> > > >                         WARN_ON(qm_sg_entry_is_ext(&sgt[i]));
> > > >
> > > >                         dma_unmap_page(dev, qm_sg_addr(&sgt[i]),
> > > > --
> > > > 2.17.1
> > > >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
