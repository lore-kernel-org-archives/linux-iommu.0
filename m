Return-Path: <SRS0=NDwq=TC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEEBC43219
	for <iommu@archiver.kernel.org>; Thu,  2 May 2019 10:37:22 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDC102075E
	for <iommu@archiver.kernel.org>; Thu,  2 May 2019 10:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=infinera.com header.i=@infinera.com header.b="KQrnPe55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC102075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=infinera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 685743047;
	Thu,  2 May 2019 10:37:21 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7E8D82FFA
	for <iommu@lists.linux-foundation.org>;
	Thu,  2 May 2019 10:36:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
	(mail-eopbgr750084.outbound.protection.outlook.com [40.107.75.84])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B6DB08D
	for <iommu@lists.linux-foundation.org>;
	Thu,  2 May 2019 10:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=L40Qc+zMat3uNEKq4ePQ2mqCdXjJ4Y1Njlshcn/ZTio=;
	b=KQrnPe55g3nyuZud6KqHH6HsuPH1Nq9qAgZ4Q9u8XWo6zmhr48869C+2aBuyTFtekiRYeFNJh/x+zdUTQDaRUO4ZSiaHkjc+1Mkezqu3AaX0QgX6wBgwrcIUKbLV1fovz6sA4tsO9IuhhH6s6gFPvjWXX2rqjVulHH91NMz0aDo=
Received: from BN8PR10MB3540.namprd10.prod.outlook.com (20.179.78.205) by
	BN8PR10MB3314.namprd10.prod.outlook.com (20.179.139.84) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1856.11; Thu, 2 May 2019 10:36:30 +0000
Received: from BN8PR10MB3540.namprd10.prod.outlook.com
	([fe80::24c5:ea68:cff3:4a16]) by
	BN8PR10MB3540.namprd10.prod.outlook.com
	([fe80::24c5:ea68:cff3:4a16%7]) with mapi id 15.20.1856.008;
	Thu, 2 May 2019 10:36:30 +0000
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "madalin.bucur@nxp.com"
	<madalin.bucur@nxp.com>, "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
	"laurentiu.tudor@nxp.com" <laurentiu.tudor@nxp.com>, "roy.pledge@nxp.com"
	<roy.pledge@nxp.com>, "camelia.groza@nxp.com" <camelia.groza@nxp.com>
Subject: Re: [PATCH v2 9/9] dpaa_eth: fix SG frame cleanup
Thread-Topic: [PATCH v2 9/9] dpaa_eth: fix SG frame cleanup
Thread-Index: AQHU/MpTw42IuR0fykCaI1+07jqDiqZQPr+AgAdUG4CAABlegA==
Date: Thu, 2 May 2019 10:36:30 +0000
Message-ID: <728fe477849debcc14bb1af01e35bc7b184a0a03.camel@infinera.com>
References: <20190427071031.6563-1-laurentiu.tudor@nxp.com>
	<20190427071031.6563-10-laurentiu.tudor@nxp.com>
	<2c6f5d170edab346e0a87b1dfeb12e2f65801685.camel@infinera.com>
	<VI1PR04MB5134C0D6707E78D674B96898EC340@VI1PR04MB5134.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB5134C0D6707E78D674B96898EC340@VI1PR04MB5134.eurprd04.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Joakim.Tjernlund@infinera.com; 
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59f6c7b0-0605-4284-c375-08d6ceea0a1b
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:BN8PR10MB3314; 
x-ms-traffictypediagnostic: BN8PR10MB3314:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BN8PR10MB3314BDAF20A30D8A5603C850F4340@BN8PR10MB3314.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(39860400002)(136003)(366004)(396003)(346002)(376002)(189003)(199004)(13464003)(316002)(118296001)(186003)(6246003)(11346002)(305945005)(66476007)(73956011)(2616005)(64756008)(66446008)(66946007)(66556008)(53936002)(91956017)(76116006)(446003)(476003)(486006)(66066001)(3846002)(6486002)(71190400001)(71200400001)(86362001)(6436002)(6116002)(5660300002)(2201001)(229853002)(966005)(14444005)(8676002)(6306002)(256004)(68736007)(54906003)(110136005)(8936002)(81166006)(81156014)(7736002)(6512007)(7416002)(4326008)(36756003)(25786009)(102836004)(6506007)(76176011)(72206003)(2501003)(2906002)(14454004)(478600001)(99286004)(26005);
	DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR10MB3314;
	H:BN8PR10MB3540.namprd10.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: infinera.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: z1YXU6qwY4gFgNMUgdv6tNcgJcx0akvl9NOnrooCO3wJkEL7lQLeI1wnPht93EPWP+t9WGumHzcxkq2D+4fIhxol5Dbgnql+M/m4y99DaKVSRDuuxMwzdMomXay/IIumcWZtmioQoZTP8rvtcjGgGmBNBsY44L4si3ob6rp+30XdbWjpEqRP72UYTOAkMPmh1I/aGLTHs2kgpD7JWWynf3zXQyXfKshyUn2Ki09g6LCDvlMIyCj2jy2A08ThRHYyfc9Mb4YKvTjMEGrbm2/Pk+PCsEyv9Fm1Oh9KARKFPgJlp5AR7cJUPoIasqudgADddZWTBCd3BBsI/PH40QugrjH+asTGdGXS3cOqzr42unqcD3DreaOrx3Fo9jPyBnoo5DDbaj4Wa3BqGdCf6Om+TLuzmsqx0/zwODN6xP1DLpc=
Content-ID: <1F9602CDEA854A469D9C83B5DEC64BBA@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f6c7b0-0605-4284-c375-08d6ceea0a1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 10:36:30.5005 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3314
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
Message-ID: <20190502103630.lLCeikAGfcdIhJY1uxwefH5nPCXOeZfj4SSfngi-gWU@z>

On Thu, 2019-05-02 at 09:05 +0000, Laurentiu Tudor wrote:
> Hi Joakim,
> 
> > -----Original Message-----
> > From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
> > Sent: Saturday, April 27, 2019 8:11 PM
> > 
> > On Sat, 2019-04-27 at 10:10 +0300, laurentiu.tudor@nxp.com wrote:
> > > From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > > 
> > > Fix issue with the entry indexing in the sg frame cleanup code being
> > > off-by-1. This problem showed up when doing some basic iperf tests and
> > > manifested in traffic coming to a halt.
> > > 
> > > Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > > Acked-by: Madalin Bucur <madalin.bucur@nxp.com>
> > 
> > Wasn't this a stable candidate too?
> 
> Yes, it is. I forgot to add the cc:stable tag, sorry about that.

Then this is a bug fix that should go directly to linus/stable.

I note that https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/drivers/net/ethernet/freescale/dpaa?h=linux-4.19.y
is in 4.19 but not in 4.14 , is it not appropriate for 4.14?

 Jocke

> 
> ---
> Best Regards, Laurentiu
> 
> > > ---
> > >  drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> > b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> > > index daede7272768..40420edc9ce6 100644
> > > --- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> > > +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> > > @@ -1663,7 +1663,7 @@ static struct sk_buff *dpaa_cleanup_tx_fd(const
> > struct dpaa_priv *priv,
> > >                                  qm_sg_entry_get_len(&sgt[0]), dma_dir);
> > > 
> > >                 /* remaining pages were mapped with skb_frag_dma_map()
> > */
> > > -               for (i = 1; i < nr_frags; i++) {
> > > +               for (i = 1; i <= nr_frags; i++) {
> > >                         WARN_ON(qm_sg_entry_is_ext(&sgt[i]));
> > > 
> > >                         dma_unmap_page(dev, qm_sg_addr(&sgt[i]),
> > > --
> > > 2.17.1
> > > 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
