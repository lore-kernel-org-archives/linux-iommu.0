Return-Path: <SRS0=/ROq=YQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B6ECA9EB6
	for <iommu@archiver.kernel.org>; Wed, 23 Oct 2019 11:53:48 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF71120650
	for <iommu@archiver.kernel.org>; Wed, 23 Oct 2019 11:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eW3Ff4wG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF71120650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A70A2D7A;
	Wed, 23 Oct 2019 11:53:46 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D106AD67
	for <iommu@lists.linux-foundation.org>;
	Wed, 23 Oct 2019 11:53:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
	(mail-eopbgr140078.outbound.protection.outlook.com [40.107.14.78])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id ED4BB89C
	for <iommu@lists.linux-foundation.org>;
	Wed, 23 Oct 2019 11:53:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=TSrOomg77Vy30ONNC/PlqR02INUyvfm1bOXCm/9vm42rW58LA2M+7QFsKC5Vixz7KtQbJcS5t+mR7FOOXNplOOLRXuNjgq/lbQtGvfwz3T1VSeIrFEhIKt2+eTcznd/EMDdNx+BK5tk/mhViMTfUcoeq+AYow7frFsuSvUAvh2W3CNHW18BmDDs7L8BILpHv24x7fcic93u56nc6vse87Kk7ONkvy6DuxaHN6zR8j42qLEH5lmPAhbZUTerSzKFkm41diTt3sq/+kH8FhrUXrfK9SOZ+IZGNLWD0R+rplSYSGuxoVE5b90jA98UuBPTpmDMTe1XvVncuWzt+GvDSqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=fNEdv9CnAQB4wIzj3rvG26oICmiCQ4jzPMg6qBZQa5s=;
	b=YyGxAuRjxj/l6dyjWUb9jc5kb2b5Goed6/ciu1l2tDFMUA+l4Z1ge6l3KesHjtFNDgw5Qk3dsuAlHiKm2rKzfHKXzZNqhpr37htGTojclyIIa2BKaYQCBdBL7a3IAOHqJXBc6DB+cL6VRBBySbVaD8KttxsTR38Y7tNUnaS8vXlf7S0KFIZ9/TyLD8n3C+ecb3GEX1YEajvLiaEw9x11qM6ju/MSz0e+WMFpwKbM4NsUFBXr/MsSrYQb2Tvl6auNHfTziEm//Tk1CD/8Qdeev9sj7mvkURcmxAEEbObL9AiXWXISLzNNuqfDdvxoNvwBKyYUzeQWYgeA+RAFqp4u9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
	smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com;
	dkim=pass header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=fNEdv9CnAQB4wIzj3rvG26oICmiCQ4jzPMg6qBZQa5s=;
	b=eW3Ff4wGVZ6h9gLIhMu2fxkog3FT8OeydXeRweCP0i9VCV9unzO3MxiFKtFKMCN4g5wqKPx7eEvrRnq/s1DzFsHA1e/SsiWF8yujFkzJ2zOxpKQT8i7Kqo+YSZ5zdruSnSNSZQZY/zk/TX9YWJPjXePlh771T+xiadF3NkLIfog=
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com (20.177.51.208) by
	VI1PR04MB5358.eurprd04.prod.outlook.com (20.178.120.83) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2367.24; Wed, 23 Oct 2019 11:53:41 +0000
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com
	([fe80::10f0:af2c:76ac:dfb]) by VI1PR04MB5134.eurprd04.prod.outlook.com
	([fe80::10f0:af2c:76ac:dfb%7]) with mapi id 15.20.2347.030;
	Wed, 23 Oct 2019 11:53:41 +0000
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: Robin Murphy <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>,
	"joro@8bytes.org" <joro@8bytes.org>, Ioana Ciocoi Radulescu
	<ruxandra.radulescu@nxp.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org"
	<iommu@lists.linux-foundation.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: [RFC PATCH 1/3] dma-mapping: introduce a new dma api
	dma_addr_to_phys_addr()
Thread-Topic: [RFC PATCH 1/3] dma-mapping: introduce a new dma api
	dma_addr_to_phys_addr()
Thread-Index: AQHViNfyo/IzAF7o50+e1U9qS9i5xadmpruAgAF4mgA=
Date: Wed, 23 Oct 2019 11:53:41 +0000
Message-ID: <50a42575-02b2-c558-0609-90e2ad3f515b@nxp.com>
References: <20191022125502.12495-1-laurentiu.tudor@nxp.com>
	<20191022125502.12495-2-laurentiu.tudor@nxp.com>
	<62561dca-cdd7-fe01-a0c3-7b5971c96e7e@arm.com>
In-Reply-To: <62561dca-cdd7-fe01-a0c3-7b5971c96e7e@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 662831db-6016-4aa9-8de4-08d757afa617
x-ms-traffictypediagnostic: VI1PR04MB5358:|VI1PR04MB5358:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5358FB3DBAEE4B32D3B63CACEC6B0@VI1PR04MB5358.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(189003)(199004)(2616005)(446003)(476003)(186003)(11346002)(316002)(71190400001)(54906003)(44832011)(36756003)(6116002)(3846002)(2906002)(71200400001)(6636002)(31686004)(66066001)(110136005)(561944003)(26005)(486006)(5660300002)(2501003)(66476007)(81166006)(6436002)(229853002)(6512007)(305945005)(66946007)(64756008)(2201001)(6246003)(7736002)(66556008)(81156014)(66446008)(8676002)(8936002)(76116006)(4326008)(25786009)(478600001)(6506007)(53546011)(102836004)(256004)(86362001)(99286004)(31696002)(14454004)(6486002)(76176011)(91956017);
	DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5358;
	H:VI1PR04MB5134.eurprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8zF8o+RwJ1QDiYONjx9ZcucusaWvvrl5iZ9aPe0/leaPEn+ClNHc0PadCrNB97VGgByMxNdeMLe5QRH9YtUl0Uj6aTZqtN+UASAnWc+rt2rKiuXGdANzfmKee24PE5HksyptS3RBraPJ7EIpzdh1uVnkuC4sEIBPMIknFPHRTjrVAPlTm8tdREfxfLCbX17stVz6aGznjYd/yAq4lKLhcZDMfG0Fet5rZUEFRyncnHPDxb6RWx7gKY9ytzN4MkLYnn+Il/ZQNFGQbaFxFTHCkAbr4MeFlFR5kNcqPnH1ZtS4jpF+gwbRjyHsQFQI6rR9HPHSlO9JcSWhUAtWq0s7W7vs1gxzNceJgHqQ8D8/QIRONeA+9YNK4O4HebEmJicQGr3xERAAFvaocQ6vhagE50UQW5hocObUrDB9GNxFwSmZkYiCFd79WQv30l/MUGW0
Content-ID: <2679FB9EA0E4F3418A83611381CF1016@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 662831db-6016-4aa9-8de4-08d757afa617
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 11:53:41.2130 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rZ9b3MBn2MpIjNUt7THnaogG+u+TbUAQlMHHKaO8tFPkZPKhlq208xycloTKIqFU45/SGb1WfjlP/LHI6JAuoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5358
Cc: Madalin-cristian Bucur <madalin.bucur@nxp.com>,
	"davem@davemloft.net" <davem@davemloft.net>, Leo Li <leoyang.li@nxp.com>
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

On 22.10.2019 16:25, Robin Murphy wrote:
> On 22/10/2019 13:55, Laurentiu Tudor wrote:
>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>
>> Introduce a new dma map op called dma_addr_to_phys_addr() that converts
>> a dma address to the physical address backing it up and add wrapper for
>> it.
> 
> I'd really love it if there was a name which could encapsulate that this 
> is *only* for extreme special cases of constrained descriptors/pagetable 
> entries/etc. where there's simply no practical way to keep track of a 
> CPU address alongside the DMA address, and the only option is this 
> potentially-arbitrarily-complex operation (I mean, on some systems it 
> may end up taking locks and poking hardware).
> 
> Either way it's tricky - much as I don't like adding an interface which 
> is ripe for drivers to misuse, I also really don't want hacks like 
> bdf95923086f shoved into other APIs to compensate, so on balance I'd 
> probably consider this proposal ever so slightly the lesser evil.

We had an internal discussion over these points you are raising and 
Madalin (cc-ed) came up with another idea: instead of adding this prone 
to misuse api how about experimenting with a new dma unmap and dma sync 
variants that would return the physical address by calling the newly 
introduced dma map op. Something along these lines:
  * phys_addr_t dma_unmap_page_ret_phys(...)
  * phys_addr_t dma_unmap_single_ret_phys(...)
  * phys_addr_t dma_sync_single_for_cpu_ret_phys(...)
I'm thinking that this proposal should reduce the risks opened by the 
initial variant.
Please let me know what you think.

---
Thanks & Best Regards, Laurentiu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
