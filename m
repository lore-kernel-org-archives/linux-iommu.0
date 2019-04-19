Return-Path: <SRS0=myD+=SV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EFDC282DA
	for <iommu@archiver.kernel.org>; Fri, 19 Apr 2019 13:42:01 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21775222B4
	for <iommu@archiver.kernel.org>; Fri, 19 Apr 2019 13:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sb2muPTk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21775222B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D6F5A23D4;
	Fri, 19 Apr 2019 13:42:00 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5124323C2
	for <iommu@lists.linux-foundation.org>;
	Fri, 19 Apr 2019 13:41:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
	(mail-eopbgr150077.outbound.protection.outlook.com [40.107.15.77])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1276414D
	for <iommu@lists.linux-foundation.org>;
	Fri, 19 Apr 2019 13:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=bdOMdNJmJGOVzzRDliZ13hYceqbBlu9X588oBQ/37Es=;
	b=sb2muPTk29AUFBD27Emi7Ons964JYJObjoEZ1DvRmbWMLjf7MV4IwcUIFGurqc6aW4Oe3YZfSuUHyHZ2w/WwvI2mx0r8E9zMVyhgVe2bqXnNMkhq8H8NM+9TKYr3hXz67muslkr6Ge+beLdpTieQvQDyHu/BLIdLVANcOqwRogI=
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com (20.177.50.159) by
	VI1PR04MB5919.eurprd04.prod.outlook.com (20.178.205.81) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1813.12; Fri, 19 Apr 2019 13:41:39 +0000
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com
	([fe80::5c9b:12cc:80f2:1f42]) by
	VI1PR04MB5134.eurprd04.prod.outlook.com
	([fe80::5c9b:12cc:80f2:1f42%3]) with mapi id 15.20.1813.013;
	Fri, 19 Apr 2019 13:41:39 +0000
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: Robin Murphy <robin.murphy@arm.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Madalin-cristian Bucur <madalin.bucur@nxp.com>,
	Roy Pledge <roy.pledge@nxp.com>,
	Camelia Alexandra Groza <camelia.groza@nxp.com>, 
	Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH 02/13] soc/fsl/bman: map FBPR area in the iommu
Thread-Topic: [PATCH 02/13] soc/fsl/bman: map FBPR area in the iommu
Thread-Index: AQHU5je+GYAdWERgxkCiU6HsMs84n6YisRcAgCDsguA=
Date: Fri, 19 Apr 2019 13:41:38 +0000
Message-ID:
 <VI1PR04MB5134C8A672CD99F521DBFE7EEC270@VI1PR04MB5134.eurprd04.prod.outlook.com>
References: <20190329140014.8126-1-laurentiu.tudor@nxp.com>
	<20190329140014.8126-3-laurentiu.tudor@nxp.com>
	<b747c418-a495-56e0-c106-a8ec8e82ccb9@arm.com>
In-Reply-To: <b747c418-a495-56e0-c106-a8ec8e82ccb9@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [213.233.110.112]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f1080e5-4da5-4fa6-733c-08d6c4ccbfd8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:VI1PR04MB5919; 
x-ms-traffictypediagnostic: VI1PR04MB5919:
x-microsoft-antispam-prvs: <VI1PR04MB591919C806B5124532B976BFEC270@VI1PR04MB5919.eurprd04.prod.outlook.com>
x-forefront-prvs: 0012E6D357
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(376002)(346002)(136003)(39860400002)(366004)(396003)(199004)(13464003)(189003)(55016002)(73956011)(66946007)(6246003)(52536014)(99286004)(66066001)(478600001)(2906002)(9686003)(97736004)(68736007)(44832011)(76176011)(86362001)(64756008)(76116006)(66446008)(53936002)(316002)(7696005)(54906003)(6116002)(110136005)(14454004)(6636002)(256004)(229853002)(476003)(6436002)(186003)(11346002)(74316002)(81156014)(4326008)(7736002)(305945005)(25786009)(26005)(71190400001)(33656002)(71200400001)(53546011)(486006)(6506007)(81166006)(8676002)(3846002)(102836004)(446003)(8936002)(66476007)(2501003)(5660300002)(66556008);
	DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5919;
	H:VI1PR04MB5134.eurprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BeFY///qE+RmwKpRlRJcQbMDG6Ojm0ES1+M6FnlZDN7AFfwPqkRA68Yel4C5A2BZA38ZKAEfl1itecVa5l+X+os/AuRHbPYLy4ZGAxoUwRyCftMZOOmFpLLFo7yBfLSkHiI8puUkfAts9wEV92UfWF1RxW5MaBabJ5yZv/j9rI7GYMAn5aizHP+ZQTGA6ZKkstQwz8J6iXMVkT2Harme/xs49FxgfnffoYxNnsAmTL5Wc0WJahLAz7Y8rXrIoO6tNp7XOXRSwgoMRh+RX5jO57Q+5wbT31pp0pI1r5Rs91rZ4K0v2PlLJ3HN5rRT9XwITBffXN6+aZrZRbXS3TA5OFFuqf+mdvUv/kgn5bnLfi0dmt09sEwrT00SW+39HTDnRJbfJ+wSEv4TdLIinJMAhtrEpzA9DQxlzKbWvKjsPxk=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f1080e5-4da5-4fa6-733c-08d6c4ccbfd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2019 13:41:38.8808 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5919
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
Message-ID: <20190419134138.5ZkB8H8a46nkTzG_oz9SEMXvshAORyyK5Vn1M7Q50yk@z>

Hi Robin,

> -----Original Message-----
> From: Robin Murphy <robin.murphy@arm.com>
> Sent: Friday, March 29, 2019 4:51 PM
> 
> On 29/03/2019 14:00, laurentiu.tudor@nxp.com wrote:
> > From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >
> > Add a one-to-one iommu mapping for bman private data memory (FBPR).
> > This is required for BMAN to work without faults behind an iommu.
> >
> > Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > ---
> >   drivers/soc/fsl/qbman/bman_ccsr.c | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/soc/fsl/qbman/bman_ccsr.c
> b/drivers/soc/fsl/qbman/bman_ccsr.c
> > index 7c3cc968053c..b209c79511bb 100644
> > --- a/drivers/soc/fsl/qbman/bman_ccsr.c
> > +++ b/drivers/soc/fsl/qbman/bman_ccsr.c
> > @@ -29,6 +29,7 @@
> >    */
> >
> >   #include "bman_priv.h"
> > +#include <linux/iommu.h>
> >
> >   u16 bman_ip_rev;
> >   EXPORT_SYMBOL(bman_ip_rev);
> > @@ -178,6 +179,7 @@ static int fsl_bman_probe(struct platform_device
> *pdev)
> >   	int ret, err_irq;
> >   	struct device *dev = &pdev->dev;
> >   	struct device_node *node = dev->of_node;
> > +	struct iommu_domain *domain;
> >   	struct resource *res;
> >   	u16 id, bm_pool_cnt;
> >   	u8 major, minor;
> > @@ -225,6 +227,15 @@ static int fsl_bman_probe(struct platform_device
> *pdev)
> >
> >   	dev_dbg(dev, "Allocated FBPR 0x%llx 0x%zx\n", fbpr_a, fbpr_sz);
> >
> > +	/* Create an 1-to-1 iommu mapping for FBPR area */
> > +	domain = iommu_get_domain_for_dev(dev);
> 
> If that's expected to be the default domain that you're grabbing, then
> this is *incredibly* fragile. There's nothing to stop the IOVA that you
> forcibly map from being automatically allocated later and causing some
> other DMA mapping to fail noisily and unexpectedly. Furthermore, have
> you tried this with "iommu.passthrough=1"?
> 
> That said, I really don't understand what's going on here anyway :/
> 
> As far as I can tell from qbman_init_private_mem(), fbpr_a comes from
> dma_alloc_coherent() and thus would already be a mapped IOVA - isn't
> this the stuff that Roy converted to nicely use shared-dma-pool regions
> a while ago?
> 

Finally found some time to look into this, sorry for the delay. It seems that on the code path taken in our case (dma_alloc_coherent() -> dma_alloc_attrs() -> dma_alloc_from_dev_coherent() -> __dma_alloc_from_coherent()) there's no call into the iommu layer, thus no mapping in the smmu. I plan to come up with a RFC patch early next week so we have something concrete to discuss on.

---
Best Regards, Laurentiu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
