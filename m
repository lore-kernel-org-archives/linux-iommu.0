Return-Path: <SRS0=j+PZ=S5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8910C43219
	for <iommu@archiver.kernel.org>; Sat, 27 Apr 2019 17:13:27 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7EE220693
	for <iommu@archiver.kernel.org>; Sat, 27 Apr 2019 17:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=infinera.com header.i=@infinera.com header.b="TCzeSQ/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7EE220693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=infinera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 58AA81A74;
	Sat, 27 Apr 2019 17:13:27 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B30371A70
	for <iommu@lists.linux-foundation.org>;
	Sat, 27 Apr 2019 17:10:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
	(mail-eopbgr800043.outbound.protection.outlook.com [40.107.80.43])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D2EF8786
	for <iommu@lists.linux-foundation.org>;
	Sat, 27 Apr 2019 17:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=FQtJl4bY1DuoaHrUkMBL7N6xDJZq7S7FIB5cMjqNewg=;
	b=TCzeSQ/vHhbIDdZwDmat/CNk2Nks6JGOkm4QXPM87FOppZvRCHQjbYBMhIoga/95SmoZZe3o+XIWSWjHb2csURwpMV7Ophuzvy0KG8330XDsPJfORWGB2YXkfHEz0uGGb+ydgnHuCdarrxrH6YORUBT3MNQ9VUxdSlkxVZBpATA=
Received: from BN8PR10MB3540.namprd10.prod.outlook.com (20.179.78.205) by
	BN8PR10MB3490.namprd10.prod.outlook.com (20.179.78.20) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.13; Sat, 27 Apr 2019 17:10:53 +0000
Received: from BN8PR10MB3540.namprd10.prod.outlook.com
	([fe80::51e7:a757:afa8:f4cf]) by
	BN8PR10MB3540.namprd10.prod.outlook.com
	([fe80::51e7:a757:afa8:f4cf%7]) with mapi id 15.20.1835.010;
	Sat, 27 Apr 2019 17:10:53 +0000
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "madalin.bucur@nxp.com"
	<madalin.bucur@nxp.com>, "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
	"laurentiu.tudor@nxp.com" <laurentiu.tudor@nxp.com>, "roy.pledge@nxp.com"
	<roy.pledge@nxp.com>, "camelia.groza@nxp.com" <camelia.groza@nxp.com>
Subject: Re: [PATCH v2 9/9] dpaa_eth: fix SG frame cleanup
Thread-Topic: [PATCH v2 9/9] dpaa_eth: fix SG frame cleanup
Thread-Index: AQHU/MpTw42IuR0fykCaI1+07jqDiqZQPr+A
Date: Sat, 27 Apr 2019 17:10:53 +0000
Message-ID: <2c6f5d170edab346e0a87b1dfeb12e2f65801685.camel@infinera.com>
References: <20190427071031.6563-1-laurentiu.tudor@nxp.com>
	<20190427071031.6563-10-laurentiu.tudor@nxp.com>
In-Reply-To: <20190427071031.6563-10-laurentiu.tudor@nxp.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Joakim.Tjernlund@infinera.com; 
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a2bf90b-4bf3-4692-cb14-08d6cb334df7
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:BN8PR10MB3490; 
x-ms-traffictypediagnostic: BN8PR10MB3490:
x-microsoft-antispam-prvs: <BN8PR10MB34905036363513E5A4F02C68F43F0@BN8PR10MB3490.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0020414413
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(39860400002)(136003)(396003)(346002)(376002)(366004)(189003)(199004)(3846002)(6116002)(2201001)(68736007)(256004)(81166006)(6512007)(54906003)(8676002)(2906002)(8936002)(110136005)(81156014)(36756003)(6246003)(66476007)(64756008)(66556008)(66446008)(316002)(86362001)(229853002)(102836004)(66066001)(53936002)(6486002)(2501003)(14444005)(91956017)(66946007)(73956011)(76116006)(6436002)(2616005)(305945005)(486006)(6506007)(97736004)(71190400001)(478600001)(4326008)(7736002)(5660300002)(476003)(76176011)(14454004)(118296001)(72206003)(99286004)(7416002)(186003)(26005)(25786009)(446003)(11346002)(71200400001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR10MB3490;
	H:BN8PR10MB3540.namprd10.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: infinera.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: h1A6YhzC8ddJWf79OUo4YI/37lwKzz8kkCAzI+Wvbmn5Qx4PsFp4nPg9K3eOvMV+EDsPamR4VQJR1EOLDeiY9zZhWvyGuaFoosGt3gwvF6z+mrcgvbEAv7j2fhNpdEAzxvlACB47/r5G3aLx5Tmd2ojN4flnheSHbj6XMYpfXs0X30YArUPatOeeApeZ/ubrqp1Z2tFm/eXA6VEHTKq0mBvGV/M2fzdrUK3D0FFK3GG/fPoflzEEM3j2KR/C1zlboXh33rBFaBbUtYurndgwBd8/0ALu2EkTZUve+x7T05sYy0WXkBqzoMX0aKm/0jXsuXcyJhucTTKg3CdzN0718JJb0p8zuVJ3mfIi/Q4wg2VON6ws+1QgQ/nUBeIYRChn8NNw2h3pZtKqS8lcTv7Hb7M/6Z4FmqcBqMFuYkwNRnE=
Content-ID: <4A981E3F453F6540BDBD9A24364D128E@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2bf90b-4bf3-4692-cb14-08d6cb334df7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2019 17:10:53.0418 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3490
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
Message-ID: <20190427171053.m08uagbsIPJtIKOejavyJFx2fw6mgB0N1ClL7QaYqbs@z>

On Sat, 2019-04-27 at 10:10 +0300, laurentiu.tudor@nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> Fix issue with the entry indexing in the sg frame cleanup code being
> off-by-1. This problem showed up when doing some basic iperf tests and
> manifested in traffic coming to a halt.
> 
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Acked-by: Madalin Bucur <madalin.bucur@nxp.com>

Wasn't this a stable candidate too?

> ---
>  drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> index daede7272768..40420edc9ce6 100644
> --- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> @@ -1663,7 +1663,7 @@ static struct sk_buff *dpaa_cleanup_tx_fd(const struct dpaa_priv *priv,
>                                  qm_sg_entry_get_len(&sgt[0]), dma_dir);
> 
>                 /* remaining pages were mapped with skb_frag_dma_map() */
> -               for (i = 1; i < nr_frags; i++) {
> +               for (i = 1; i <= nr_frags; i++) {
>                         WARN_ON(qm_sg_entry_is_ext(&sgt[i]));
> 
>                         dma_unmap_page(dev, qm_sg_addr(&sgt[i]),
> --
> 2.17.1
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
