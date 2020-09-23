Return-Path: <SRS0=5N08=DA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD86C4363D
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 14:47:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB185206FB
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 14:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=LenovoBeijing.onmicrosoft.com header.i=@LenovoBeijing.onmicrosoft.com header.b="a4+cTo98"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB185206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lenovo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4BAAE2000D;
	Wed, 23 Sep 2020 14:47:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ULF7zfs7B9P3; Wed, 23 Sep 2020 14:47:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2A3102000A;
	Wed, 23 Sep 2020 14:47:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6F3CC0859;
	Wed, 23 Sep 2020 14:47:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8DABDC0051
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 14:43:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8989887326
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 14:43:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G52spvX6W4xE for <iommu@lists.linux-foundation.org>;
 Wed, 23 Sep 2020 14:43:01 +0000 (UTC)
X-Greylist: delayed 00:13:40 by SQLgrey-1.7.6
Received: from mail1.bemta24.messagelabs.com (mail1.bemta24.messagelabs.com
 [67.219.250.3])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 32E1B87285
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 14:43:01 +0000 (UTC)
Received: from [100.112.129.197] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-3.bemta.az-a.us-west-2.aws.symcld.net id 1D/04-20041-FBB5B6F5;
 Wed, 23 Sep 2020 14:29:19 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSa0xTZxjHeXtODwekcCwVXjrLki4Y060NhS2
 0uiUmXSa7RWP2YaKxnkLhNLSl6SUtJFtAhovtjGhjIhdHbVaLKILMbGMwHEg0FAGtlzVTRzuK
 4baV0ESkQl3bU9327fc8//9zSx4cYXswLq60GJV6LanmY+koNRfYJLx2oFpe6HmMSab8EUziu
 LZTcqytN1Uy425DJHd/bsd2MUuDw98ySu0+NygNDd3HSsN9+XvRMqZKq6ixHGZSc/fvpuqub7
 IM3mtB68FYmhWk42yingEf+qzACtJiwQKAfY4sWmhgwO7jv6XSwXMAfd0nsbgLEC4Ejq+r4wI
 gbqBw6OjXgA56AbRFwokAJQYQWD9wikk37mDAB85aulcAwFBwISbgOEYI4EQfGfdwiPfh7dlu
 RpwR4kcAf/DK4pxNmGHT9C2E9ljg9IqTSXMRdA+vpcYZJQrg7J8TifVYxGF452pj8qAyOBTsT
 uTTiLdhV9Mokz4hB656LiVn5cLfgx0JhgQBvxucQmjeAudnokn/NwA+b8fo/E7oWz8CaOZBb4
 ctyZ/CF1FXslYApyJdKM3V8MyTP5L5bXDw6Wgynw+7jgfQZlDU+p81aH4LOgZWMJrfhOfPLSK
 tidM2w7GWIOoAaBcoUehVVZRRQ6rUQnFhoVAsLhKKi8VCqVhE1glJkckgNCsNRmGRiDQbRIZa
 Tbm6QqRVGvtA7KEqdI0HfgKji8uiEZCHM/hbWOOfVcvZmYqailqKNFByvUmtNIyArTjOh6ym/
 TFts15ZpbRUqtSxt3wpQzyDz2HllcVklkFHagyqKlrygGK8ef6sE8G/P+tyImxUW6NVcnNZq/
 FORNxKmbSvGr18cS/gcbNZICUlhZ2hU+o1KuP/9QWQiwN+NmtvfGCGSmt8NS/2t7ErOKx3wlR
 8FSP5r8StZ+y/mtsj7XyW5VvNM6F73ms5tCTTyLycS0bf6507OLc0y3X3GHZyz4lwwLR7vvgD
 20ez1vHykejl6fbOyKS2IHQ9M/yLrrXq9pXQmfKTX3xesb61J1p3U6AIif/ut/svTx672PZIb
 hP0u3Oo0xHmYm16qGHbxRxLs3ntAuXgNbkrd3ikvBm7TfiuPXvuK0X+0gRj2Nrf+9ruQb+fG+
 Ud4pUEqkuWD7qO7Br7q+PKE8vkxj73nUdrlXJkYZgxNKL80PNiA7khfXb6EyE30/vxqZv7lvI
 fyAoaXP6Dj098OXVuOyZvlL0xIVgXVUKnTCrY4GUVPuw5usIs2/70V3O5no8aKFIsQPQG8h+B
 JtSZXQQAAA==
X-Env-Sender: ahuang12@lenovo.com
X-Msg-Ref: server-29.tower-326.messagelabs.com!1600871357!6136!1
X-Originating-IP: [104.232.225.11]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24009 invoked from network); 23 Sep 2020 14:29:18 -0000
Received: from unknown (HELO lenovo.com) (104.232.225.11)
 by server-29.tower-326.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 23 Sep 2020 14:29:18 -0000
Received: from HKGWPEMAIL02.lenovo.com (unknown [10.128.3.70])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by Forcepoint Email with ESMTPS id 2989397888831422E7CD;
 Wed, 23 Sep 2020 10:29:15 -0400 (EDT)
Received: from HKGWPEMAIL03.lenovo.com (10.128.3.71) by
 HKGWPEMAIL02.lenovo.com (10.128.3.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2044.4; Wed, 23 Sep 2020 22:29:17 +0800
Received: from HKGWPEXCH02.lenovo.com (10.128.62.31) by
 HKGWPEMAIL03.lenovo.com (10.128.3.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4
 via Frontend Transport; Wed, 23 Sep 2020 22:29:17 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (104.47.125.56)
 by mail.lenovo.com (10.128.62.31) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Wed, 23 Sep
 2020 22:29:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i71ytEpB/CXbrrmOum1CP0KVk3dPRbedWYXzW9/tXaZoyagfIPEVB/2h+Jh+vQCh7edc6MBXdB/hw27hZM/F3Hb9tuqGR9b6YKNSJzaYSa8xxPk3uZ6rFc911WM/wP2Qt3LQw8Aw9ZzBd14wekWthQXg36+BBXNgVrgp2BReLFenbeG5l9sg2URJi9WaKl1S2mPnD15AbCQVm6mTx0ITgjdccSBpmApiTw5fLGmy3vDzLgN186rngmSLcAsdU9KKO3PaegsnBMcd05044ivSeAM7WWKzRsfllEeUA63TwsJ/mC5Q6TVfIq/oBQ/FpsYrG+6Nz/WNm53Ak+Y5ZoRyoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Vaq6LBW7o4JIMHVWJ6ujhddt9YoyIJS+47y/Jxy7uY=;
 b=QGqAJubXMUZMflprTCL1QS+Imta1AH/GO+zS3PyoQ9om/rKv5kGLSLjGy/FI7C9xzAlD34icZi7unKsMCCr+Me5XCvsd/nN0avWArM0xGOE0VjwJdxR1K3cFllNeQXdHh4csViqNSbMcYKFBARtLm6uGpvrexWbfUDgNhE6BwJpsA9DVKz7Uds2I5++NHmTTKYXXTuwg9BNAZrk0OvRFzB7TH7g4zwy7SDzDg9ZWLJOCdm7wuZo+ITo17vf7XgGLz5oC+f6GHE5+7wJMt5zjYXEgyFZVnoNZ5i7ALMsahoeFR40lGzJGHnNPjXnWevkHN+ig1/vnKA6jYcu+BD4Niw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LenovoBeijing.onmicrosoft.com; s=selector2-LenovoBeijing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Vaq6LBW7o4JIMHVWJ6ujhddt9YoyIJS+47y/Jxy7uY=;
 b=a4+cTo98P/pTdDWBiyRz+dN5MXyPmFOu67mvjGG2nIIefidDUCN6imCpzji3piud35d6HB4VpazdY4t/cK+CCPy2elOvxqHLJ37KAT29yIu3D88sfO0erzrdona0Occws9/Z3SWQhqyNOgjxY+M704AfpKMuXhFzdk01rr2nI9E=
Received: from HK2PR0302MB2594.apcprd03.prod.outlook.com (2603:1096:202:c::8)
 by HK0PR03MB4067.apcprd03.prod.outlook.com (2603:1096:203:9b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.13; Wed, 23 Sep
 2020 14:29:13 +0000
Received: from HK2PR0302MB2594.apcprd03.prod.outlook.com
 ([fe80::cf3:6e67:e2c8:4cb0]) by HK2PR0302MB2594.apcprd03.prod.outlook.com
 ([fe80::cf3:6e67:e2c8:4cb0%6]) with mapi id 15.20.3412.020; Wed, 23 Sep 2020
 14:29:13 +0000
From: Adrian Huang12 <ahuang12@lenovo.com>
To: Baoquan He <bhe@redhat.com>, "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [External]  Re: [PATCH] Revert "iommu/amd: Treat per-device
 exclusion ranges as r/w unity-mapped regions"
Thread-Topic: [External]  Re: [PATCH] Revert "iommu/amd: Treat per-device
 exclusion ranges as r/w unity-mapped regions"
Thread-Index: AQHWkVHq0K7SmrxgEESssWwoSA9vZql2Ra7g
Date: Wed, 23 Sep 2020 14:29:13 +0000
Message-ID: <HK2PR0302MB259469A987E70869F5E7809EB3380@HK2PR0302MB2594.apcprd03.prod.outlook.com>
References: <20200923022655.750-1-bhe@redhat.com>
 <20200923023244.GK25604@MiWiFi-R3L-srv>
In-Reply-To: <20200923023244.GK25604@MiWiFi-R3L-srv>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:b011:e002:1525:8075:eff5:54cb:a51c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56c16a34-9586-4f38-f59e-08d85fcd0b2e
x-ms-traffictypediagnostic: HK0PR03MB4067:
x-microsoft-antispam-prvs: <HK0PR03MB40672DEDC347BAFCA41897F1B3380@HK0PR03MB4067.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qYaYt2fPoV+IhvHcfq+gw6x4B/+QQGOwBWwFBtquUHYnw+RAuWDJ7lQ0u5JtgPqv9nv/nNlgvKfvaXUPGM9Ae9E+D+vJhJ4BOb1LiFoEVVhVF44wH6c1rpYgZu84d+DqpMy1b9NnssUmj/ZSs90nW3r+YMcex8l0SqhPqGvv9RBMdX9OTJfc2m/YV8xt++Ax5OpB2sFp3YhZyZkZsMOOJzmN0IiCaF+dSFm8juPEtUWMjj4JSKM6XcoXA16kRnrTi1OIetIsnLIoDGyWvIMwne3/rtmD2vatdCDjzu5PwoTsYJ6R68Px3QUvTCMc3tPV6xg+xufg5PRFcw8eXYp7L8dRnANo06zg0GfOQKTvm/kMWsYm6V2HC1LEqw2gxeso
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HK2PR0302MB2594.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(66476007)(4326008)(66446008)(66946007)(64756008)(71200400001)(5660300002)(54906003)(52536014)(76116006)(86362001)(478600001)(66556008)(7696005)(55016002)(83380400001)(53546011)(110136005)(2906002)(316002)(8676002)(186003)(9686003)(8936002)(33656002)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: zyP+WQmqlEzkMgTxk281/lwzyvCxdpFq6jB+ZZyCYvFyUsDvS0OrvyCktyY0r69KrEmCqu1nx3lzabTEu0Vood15VnfsmdrXEHd8Pz0qbA9kuwC5YUqWfFDvRFaF5DKoPVaDVVV+5QE7jwbJZn1WFLVIrux+fDlL3DO12p5+7grLttYEK6M1nh2MnqwMqDQAzf+CxKXqFhvCZCEBw3nq1uRDn6JfGPw0T1joOqLO8+CtsqRqsaQP6S4wuAE3mdHKhSKeBs7x/PjwMoiTYEkWJioQgpccG6uhG1vl6ZpvDqePOoHf79MNcGhFL1U0YlRnJcngoZMn4GuBVHvhfK4HuCz1y48EfFmOvwOweFAP7Tx3g6aJxDL8X+Al/hPtOkVfmWR4Ec9tNgfX5Pj2kQJN2cvoaa0Ek9RfoxeCEJhGnH94j5uT1a5FSUTwAsT851zykTy7SmPk0T6cMc6Zm7gypiL1tLWO127rzRk/RV+tcc1ZcjDzRwx2bC+hff2ImcAj+MsxJmYTzuQGTFu6dsA9sTkY/WSd/65+Vip4YY5HjyiQBYwuVamFRhP5iAMGO+lbUiH15GW6iS+S5ffKPZdUhFcbKOyY8wtvKH1jAm0aJW0D80NKs0PcKiuoVDQ9DpvD3cDLvN9sc/VSdjjXd4jCl2wXZfFC8rTsUpiUO8tbih5y7VjXhGMjhBvSvt/FxU4vT06ECO8XV7EeKhJ1a4Xr7Q==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK2PR0302MB2594.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c16a34-9586-4f38-f59e-08d85fcd0b2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 14:29:13.2896 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fTERKvaNx0st40RA1LoXcjM2dXkgpx/f3GZbTdhsOD9+xto/WR22/xrj8F9oQpihg5kBme5uTPkDAZbDPPv0zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB4067
X-OriginatorOrg: lenovo.com
X-Mailman-Approved-At: Wed, 23 Sep 2020 14:47:04 +0000
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Baoquan,

> -----Original Message-----
> From: Baoquan He <bhe@redhat.com>
> Sent: Wednesday, September 23, 2020 10:33 AM
> To: joro@8bytes.org; Adrian Huang12 <ahuang12@lenovo.com>
> Cc: iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> jsnitsel@redhat.com
> Subject: [External] Re: [PATCH] Revert "iommu/amd: Treat per-device exclusion
> ranges as r/w unity-mapped regions"
> 
> Forgot CC-ing Jerry, add him.
> 
> On 09/23/20 at 10:26am, Baoquan He wrote:
> > A regression failure of kdump kernel boot was reported on a HPE system.
> > Bisect points at commit 387caf0b759ac43 ("iommu/amd: Treat per-device
> > exclusion ranges as r/w unity-mapped regions") as criminal. Reverting
> > it fix the failure.
> >
> > With the commit, kdump kernel will always print below error message,
> > then naturally AMD iommu can't function normally during kdump kernel
> bootup.
> >
> >   ~~~~~~~~~
> >   AMD-Vi: [Firmware Bug]: IVRS invalid checksum
> >
> > Why commit 387caf0b759ac43 causing it haven't been made clear.
> 
> Hi Joerg, Adrian
> 
> We only have one machine which can reproduce the issue, it's a gen10-01 of
> HPE. If any log or info are needed, please let me know, I can attach here.

Could you please provide the following info?
1. The booting log for both system kernel and kdump kernel by appending the kernel parameter 'amd_iommu_dump'
2. ACPI table (# acpidump > acpi-table) -> Send out the file 'acpi-table'. 

-- Adrian
 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
