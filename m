Return-Path: <SRS0=NDwq=TC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D656C43219
	for <iommu@archiver.kernel.org>; Thu,  2 May 2019 13:04:14 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C2392085A
	for <iommu@archiver.kernel.org>; Thu,  2 May 2019 13:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=infinera.com header.i=@infinera.com header.b="Geq3ySXF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C2392085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=infinera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E23DA3144;
	Thu,  2 May 2019 13:04:13 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6D2CE313A
	for <iommu@lists.linux-foundation.org>;
	Thu,  2 May 2019 13:03:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
	(mail-eopbgr800059.outbound.protection.outlook.com [40.107.80.59])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A4546189
	for <iommu@lists.linux-foundation.org>;
	Thu,  2 May 2019 13:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=JW4XPgFDsXQJa5k67B4n9DPlHcQfpWP5ZoXLjXxQvrs=;
	b=Geq3ySXFMlALoIABE6L3xoDDLZ7iwzY8tdWH3F9/UMvFZUhqxNoHkTMkOU7yyoJ08fGtSEgo3Q437rIyvXGDjZ5gMvRItIYPMv3iKMr9mlO2a/7cszGXGr54+dndvKTtmDbLOniA7dfzQ5bZ05hFiENQ7Y8sA5MRGgVUXtvbrGg=
Received: from BN8PR10MB3540.namprd10.prod.outlook.com (20.179.78.205) by
	BN8PR10MB3265.namprd10.prod.outlook.com (20.179.138.158) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.13; Thu, 2 May 2019 13:03:38 +0000
Received: from BN8PR10MB3540.namprd10.prod.outlook.com
	([fe80::24c5:ea68:cff3:4a16]) by
	BN8PR10MB3540.namprd10.prod.outlook.com
	([fe80::24c5:ea68:cff3:4a16%7]) with mapi id 15.20.1856.008;
	Thu, 2 May 2019 13:03:38 +0000
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "madalin.bucur@nxp.com"
	<madalin.bucur@nxp.com>, "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
	"laurentiu.tudor@nxp.com" <laurentiu.tudor@nxp.com>, "roy.pledge@nxp.com"
	<roy.pledge@nxp.com>, "camelia.groza@nxp.com" <camelia.groza@nxp.com>
Subject: Re: [PATCH v2 9/9] dpaa_eth: fix SG frame cleanup
Thread-Topic: [PATCH v2 9/9] dpaa_eth: fix SG frame cleanup
Thread-Index: AQHU/MpTw42IuR0fykCaI1+07jqDiqZQPr+AgAdUG4CAABlegIAAJ48AgAABjYA=
Date: Thu, 2 May 2019 13:03:38 +0000
Message-ID: <da2c4ec6e08d39aff6fb3baa39e84e0f3966d84c.camel@infinera.com>
References: <20190427071031.6563-1-laurentiu.tudor@nxp.com>
	<20190427071031.6563-10-laurentiu.tudor@nxp.com>
	<2c6f5d170edab346e0a87b1dfeb12e2f65801685.camel@infinera.com>
	<VI1PR04MB5134C0D6707E78D674B96898EC340@VI1PR04MB5134.eurprd04.prod.outlook.com>
	<728fe477849debcc14bb1af01e35bc7b184a0a03.camel@infinera.com>
	<VI1PR04MB5134872815E02B053B383C08EC340@VI1PR04MB5134.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB5134872815E02B053B383C08EC340@VI1PR04MB5134.eurprd04.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Joakim.Tjernlund@infinera.com; 
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82caffae-9918-4a35-2597-08d6cefe97d0
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:BN8PR10MB3265; 
x-ms-traffictypediagnostic: BN8PR10MB3265:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <BN8PR10MB326539BEBBFBF4667553E1CCF4340@BN8PR10MB3265.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:989;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(396003)(346002)(136003)(366004)(376002)(39860400002)(13464003)(199004)(189003)(7416002)(66946007)(54906003)(68736007)(110136005)(316002)(6306002)(2501003)(86362001)(476003)(45080400002)(446003)(71200400001)(11346002)(2201001)(256004)(5660300002)(71190400001)(2616005)(478600001)(6512007)(7736002)(91956017)(14444005)(66476007)(73956011)(76116006)(486006)(66446008)(64756008)(305945005)(66556008)(6116002)(81156014)(6436002)(6246003)(229853002)(3846002)(4326008)(102836004)(25786009)(8676002)(2906002)(36756003)(26005)(186003)(118296001)(53936002)(14454004)(66066001)(76176011)(99286004)(8936002)(81166006)(6506007)(966005)(72206003)(6486002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR10MB3265;
	H:BN8PR10MB3540.namprd10.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: infinera.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iaU6lYL+GJbgbD4A6ntM50Fg1kNUjByUjOEtSUVQ1wsu/0q331h5Ovm/5hCzIuL/e6VrEDV/MeXTNnFghn5Nla7i37POaBuLRbljgh4m31ad27rxPSmdXbuxgn8pUbf9BUcTDidK60dyvMSOt22r9MG68jPvzQT9lWcaNszWyLf5/AmRaU+9Jq6ePQ4isAgDW3ExZeYA+BXc5kNaciLn6AYSJWYtOzUIsN1SAu18aeW9ebr9tm2ijtA8DzFjdnpPSlu/jsQXsJDmc3+sFecn8UnRyGufASDuGOtipiaqbyDTf7wYWEfc/CLgPOz3ha/r/LKZ/rCcflmB/T3ULy9lKOJrnPvwQgVDWpF1kRlk6+4Ds/bt2ukEknJrNrYIsTMe8gg+Rf4diNIp4oufO3dbgX1sUAUnijCTHShMJS9GwCM=
Content-ID: <08443AE914E9FA43B03F2C49BA1D8A6C@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82caffae-9918-4a35-2597-08d6cefe97d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 13:03:38.2220 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3265
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
Message-ID: <20190502130338.ouz3HOWg6sl-zboiYZ492U-N0amn0bDTdj03Pq3ZHY4@z>

On Thu, 2019-05-02 at 12:58 +0000, Laurentiu Tudor wrote:
> 
> > -----Original Message-----
> > From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
> > Sent: Thursday, May 2, 2019 1:37 PM
> > 
> > On Thu, 2019-05-02 at 09:05 +0000, Laurentiu Tudor wrote:
> > > Hi Joakim,
> > > 
> > > > -----Original Message-----
> > > > From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
> > > > Sent: Saturday, April 27, 2019 8:11 PM
> > > > 
> > > > On Sat, 2019-04-27 at 10:10 +0300, laurentiu.tudor@nxp.com wrote:
> > > > > From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > > > > 
> > > > > Fix issue with the entry indexing in the sg frame cleanup code being
> > > > > off-by-1. This problem showed up when doing some basic iperf tests
> > and
> > > > > manifested in traffic coming to a halt.
> > > > > 
> > > > > Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > > > > Acked-by: Madalin Bucur <madalin.bucur@nxp.com>
> > > > 
> > > > Wasn't this a stable candidate too?
> > > 
> > > Yes, it is. I forgot to add the cc:stable tag, sorry about that.
> > 
> > Then this is a bug fix that should go directly to linus/stable.
> > 
> > I note that
> > https://nam03.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fstable%2Flinux.git%2Flog%2Fdrivers%2Fnet%2Fethernet%2Ffreescale%2Fdpaa%3Fh%3Dlinux-4.19.y&amp;data=02%7C01%7CJoakim.Tjernlund%40infinera.com%7Cb88ecc951de649e5a55808d6cefdd286%7C285643de5f5b4b03a1530ae2dc8aaf77%7C1%7C0%7C636923986895133037&amp;sdata=ueUWI1%2BmNBHtlCoY9%2B1FreOUM8bHGiTYWhISy5nRoJk%3D&amp;reserved=0
> 
> Not sure I understand ... I don't see the patch in the link.

Sorry, I copied the wrong link:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/net/ethernet/freescale/dpaa?h=linux-4.19.y&id=0aafea5d4b22fe9403e89d82e02597e4493d5d0f

> 
> > is in 4.19 but not in 4.14 , is it not appropriate for 4.14?
> 
> I think it makes sense to go in both stable trees.
> 
> ---
> Best Regards, Laurentiu
> 
> > > > > ---
> > > > >  drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> > > > b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> > > > > index daede7272768..40420edc9ce6 100644
> > > > > --- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> > > > > +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> > > > > @@ -1663,7 +1663,7 @@ static struct sk_buff
> > *dpaa_cleanup_tx_fd(const
> > > > struct dpaa_priv *priv,
> > > > >                                  qm_sg_entry_get_len(&sgt[0]),
> > dma_dir);
> > > > >                 /* remaining pages were mapped with
> > skb_frag_dma_map()
> > > > */
> > > > > -               for (i = 1; i < nr_frags; i++) {
> > > > > +               for (i = 1; i <= nr_frags; i++) {
> > > > >                         WARN_ON(qm_sg_entry_is_ext(&sgt[i]));
> > > > > 
> > > > >                         dma_unmap_page(dev, qm_sg_addr(&sgt[i]),
> > > > > --
> > > > > 2.17.1
> > > > > 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
