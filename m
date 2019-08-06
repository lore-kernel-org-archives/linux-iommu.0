Return-Path: <SRS0=bP0W=WC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F86C31E40
	for <iommu@archiver.kernel.org>; Tue,  6 Aug 2019 20:23:59 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21BE520880
	for <iommu@archiver.kernel.org>; Tue,  6 Aug 2019 20:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lPEzfBBy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fXJmxoSS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21BE520880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D79EBDBB;
	Tue,  6 Aug 2019 20:23:58 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1E835D48
	for <iommu@lists.linux-foundation.org>;
	Tue,  6 Aug 2019 20:23:57 +0000 (UTC)
X-Greylist: delayed 00:07:05 by SQLgrey-1.7.6
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E882389D
	for <iommu@lists.linux-foundation.org>;
	Tue,  6 Aug 2019 20:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1565123036; x=1596659036;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-id:content-transfer-encoding: mime-version;
	bh=TifFv8GuHW1K0JgyBSct3ioYa4gjPvt4a8HLP53nD2c=;
	b=lPEzfBBypKs+tHENwOsf7CStXzIgYQ+QKdC4Wk9X11w0xaCAUG0jlCv+
	ZChKfZrwNbnay5vkFZKSIzoDtX0EH1nJTUagZzzCyufcbDPSnMp3kAMa4
	WE0CeSCHV5gUf+ATplL6yj2t0AbRZ49SibMpNQmiWuHYQ11rRT22Zg42l
	BDrZ0yOTOvB/AeUK+l1u/R0z/wtkadABPJ98s/uzRGD2zffJSdRKaWBhz
	+rQY3DDMCXwykFe7EhMYb65inNs9z6sPgRCAe+8KI49ZwWq5ozzIEvwZw
	3q+826p/VVB6GPQgMY9TKTw34HZSwgnjtkbOMjeazAhaQSa94c7uObTYk A==;
IronPort-SDR: H5kMvNZv3As9IHrpI3yd45vO48AIYrBcxH4OKdigpuslGzN78XHWqEIaW2XrwTHQcoSk9Tb5aG
	CIStQDvgdhrNiO0+I8YxeBOyfLbnp+nsuOcsgSwI3lblFKuRMgjQensFHfwxb5lSsb3iHHNxXS
	xgGt/dQ+JutvCQ4c3Gbm7Q4GHNlBIOb76MsFbAe/xVDtQlQ5C4/U+AS91X4fx8adONIOMYHcCb
	YPlvvdmfVl2nfO2Iq1yXAbWlrSWplL/OkqlBROMPlDW++bMtydp5oFaKKQOHhD+yMNKbGMB/o5
	KcU=
X-IronPort-AV: E=Sophos;i="5.64,353,1559491200"; d="scan'208";a="116783507"
Received: from mail-sn1nam04lp2057.outbound.protection.outlook.com (HELO
	NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.57])
	by ob1.hgst.iphmx.com with ESMTP; 07 Aug 2019 04:16:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=CM73cOP/OAIWVEelPcgV3yuZ/sh98mssDhqPRbXdv3Eu9LX7KQTISN4XdBzvz+Vy3XKJAWj4rAa7piQgg8bwYU8fK2Wp58liO7Eh+PZmJpgeVNWQEHl+Ki6rtuU5f+6N0wDvFPXF+CSaGg6NGAzKNZRBuRCD6Za7D7Ex0ay3GHiRHhILcM2mOnvuCGxwKVwAN1VRTTPYZfcTQ8B3jIADqmMk2i5NlLgptUTGcide2NJPmMl6pPjIg3BnvqJzDlla+kJogrqqffBXzl5hlRT8I4wE1ykA4SkDLI4t4NvjdVtJ56d0zAMFOW4sEavRmUttqAP5oH/BjuwPYNlRHPaeQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=TifFv8GuHW1K0JgyBSct3ioYa4gjPvt4a8HLP53nD2c=;
	b=b2epTKHijXL9shlL4viT1i0C/aGycEu2zfceByWGNDQGRMHZPHC+TVgvGrA2oL4aOq1czJOB87j5iHzEP3LymoRrujgS7nmfWkdZcf++ZxS4jHwqDRk84KJBkd54yMYLf8yP9ald8SVKGZ/qtUhFBVTnyiw//npQupE08V1gwh8yTUsReYcgjxoV1j3rvKuknRO1nffiDm6qpEEjEw7/nzxamyniVE+jzcdsJDkYtRbdjUVcLo2wnb3rSYI4ZsbsLoqnyO0l1G8uyfz6Tz+6nrQAln7WOumzfKaRWqBgoBwwthCk8CpHQx8p+JeWSyWYOUHEY8BV94eGHdrOW9sVkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
	smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com;
	dkim=pass header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com; 
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=TifFv8GuHW1K0JgyBSct3ioYa4gjPvt4a8HLP53nD2c=;
	b=fXJmxoSSznOC+r62Ed7/6XrWXoWG32eeBbOvkBbd9Ilhlo24uGzRko9c082Fq4xOymfKzekEpXcisnRi8KTCq5dOiMoXtOguJY4RwkVXx5D8Ra+JwsA7ND0qmM8dr7LJDcgbC/JO5yFSD6SyB1Tj0n1NcyLJdsvqNxfXtZB7Ek4=
Received: from BYAPR04MB3782.namprd04.prod.outlook.com (52.135.214.142) by
	BYAPR04MB5974.namprd04.prod.outlook.com (20.178.232.214) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2157.14; Tue, 6 Aug 2019 20:16:47 +0000
Received: from BYAPR04MB3782.namprd04.prod.outlook.com
	([fe80::ac9a:967e:70a5:e926]) by
	BYAPR04MB3782.namprd04.prod.outlook.com
	([fe80::ac9a:967e:70a5:e926%7]) with mapi id 15.20.2115.005;
	Tue, 6 Aug 2019 20:16:47 +0000
From: Atish Patra <Atish.Patra@wdc.com>
To: "hch@lst.de" <hch@lst.de>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>
Subject: Re: [PATCH] dma-direct: don't truncate dma_required_mask to bus
	addressing capabilities
Thread-Topic: [PATCH] dma-direct: don't truncate dma_required_mask to bus
	addressing capabilities
Thread-Index: AQHVTBcemVjwrnDkPUyvkjb4+Jg1habuj48A
Date: Tue, 6 Aug 2019 20:16:47 +0000
Message-ID: <b3aacbda7b6227c0f0bc46b39575f8eb1417a51b.camel@wdc.com>
References: <20190805155153.11021-1-l.stach@pengutronix.de>
	<20190806052325.GB13409@lst.de>
In-Reply-To: <20190806052325.GB13409@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.175]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 203414a9-5cf3-49d6-6c4c-08d71aab0225
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
	SRVR:BYAPR04MB5974; 
x-ms-traffictypediagnostic: BYAPR04MB5974:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5974D028EDA5C5EBDC28DBB8FAD50@BYAPR04MB5974.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(199004)(189003)(11346002)(53936002)(446003)(25786009)(6506007)(14454004)(6512007)(6246003)(8936002)(81166006)(6486002)(81156014)(478600001)(71190400001)(71200400001)(4326008)(26005)(2906002)(76176011)(99286004)(102836004)(229853002)(86362001)(5660300002)(66066001)(6436002)(2616005)(7736002)(76116006)(486006)(305945005)(36756003)(476003)(66946007)(66476007)(14444005)(66446008)(256004)(54906003)(66556008)(64756008)(118296001)(186003)(316002)(8676002)(68736007)(3846002)(110136005)(6116002)(4744005)(2501003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5974;
	H:BYAPR04MB3782.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mcNc64r9943f/V8OkRKLwWjLY7BdMvPL84FE9TtlO+O7UN4aiBzud8M+sMqhBeilDuoQoL5OwCd/uXP+NRZ602XuMNwOwRvFd/U5pXkcQzpnVx0aAW3SmL1yS0GuaA3L2JHotvkpeaLTxIjUpv3jPQ66+cgBrUkBe7crYqeywKR+gErUH0KtTHpsrJrKE1fp3g5AW6vXI02pQ/1zQo9LYnaeoGhT4bVXT0cf6g++12Rv/8shxOybg9kqW9QcfUQlzQA4XIKznUFmQMB39tO3U6waqC7P1c1WF26S+L+PNAAgYC9tAA+S8HfvtgZ2zYgzCDzcuMZtfwk/6FyqVQEzO9Kscbd5A9D5hpayDcyc7Iufg2ahRf6LuuTXAZ0vYHiwIqJm+b5+9UTwXc+zR45+mrngFPFmngOpKIjiRvqt8xY=
Content-ID: <B28F75C6AF228C4198D2E99F8797F6AB@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 203414a9-5cf3-49d6-6c4c-08d71aab0225
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 20:16:47.1962 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Atish.Patra@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5974
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"patchwork-lst@pengutronix.de" <patchwork-lst@pengutronix.de>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>
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

On Tue, 2019-08-06 at 07:23 +0200, Christoph Hellwig wrote:
> On Mon, Aug 05, 2019 at 05:51:53PM +0200, Lucas Stach wrote:
> > The dma required_mask needs to reflect the actual addressing
> > capabilities
> > needed to handle the whole system RAM. When truncated down to the
> > bus
> > addressing capabilities dma_addressing_limited() will incorrectly
> > signal
> > no limitations for devices which are restricted by the
> > bus_dma_mask.
> > 
> > Fixes: b4ebe6063204 (dma-direct: implement complete bus_dma_mask
> > handling)
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> 
> Yeah, this looks sensible.  Atish, can you check if this helps on the
> HiFive board as well?

Yes. It fixes the nvme issue on HiFive Unleashed + Microsemi expansion
board.

FWIW,

Tested-by: Atish Patra <atish.patra@wdc.com> 


Regards,
Atish
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
