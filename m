Return-Path: <SRS0=8RI2=CG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8470AC433E2
	for <iommu@archiver.kernel.org>; Fri, 28 Aug 2020 01:40:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D0BD20872
	for <iommu@archiver.kernel.org>; Fri, 28 Aug 2020 01:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="m9c177sQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D0BD20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 305A6867A8;
	Fri, 28 Aug 2020 01:40:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xTollrstecqW; Fri, 28 Aug 2020 01:40:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2961A865D6;
	Fri, 28 Aug 2020 01:40:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A7E6C016F;
	Fri, 28 Aug 2020 01:40:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA572C0051
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 01:40:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B910C20414
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 01:40:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v8049Hk1vq9v for <iommu@lists.linux-foundation.org>;
 Fri, 28 Aug 2020 01:40:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from APC01-PU1-obe.outbound.protection.outlook.com
 (mail-eopbgr1320103.outbound.protection.outlook.com [40.107.132.103])
 by silver.osuosl.org (Postfix) with ESMTPS id E682B20386
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 01:40:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOe2INbAELdLLDzLjPrBylOBIoXZODEREHQtXkJIOP7p7xOpRjjJxrhzAoVqsNnKjl+Ruiy9VY9r465zl63nMbrWofSDTMhZPWu/3SrZMlSVd2hOZj+khPom2vx1w5qU8a3hJs9uR7i//TYbfZ8RxIlc8hj6veqj8xQJYYZ2kP0JRffHv1Fspr6CuoX0hYB8lsnJUxp/jos8DAAKvW7S7kp0nxBhsVhC35BsdJWHAqAxQcymrPl3Wscu7vYkIRyxeHQ7qz8lvCLN52xZ4ntdjGAcKHxXCKBL/qu7/GK3HIL/1M326Uc9fx5MZq/3qNbqwcBKcwOCDX/T9uwv3EVLzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgooAZH/x6JmuAUo1d1P2zvBfAAaOQA/ahrE5+5syP4=;
 b=bKAF8S70pvWQLheGVQkzv6+23b3mmwnx4VipKeyGsCJzsKgzs+o7vgkHNxklY2nHbCkPMlHNhF1hxMU4st5FVK3mlMHPGbKtpdOTWycrAZ8eJ3zm6mUknjh37iWICx/XSg8lWQdtrS6CZ9ocQuaYtY1VqEBqv0LlJlfuf86poAKGV94w4mJaxKzk9fyo+DVncc4RpaBY305QMw9gGAlWdDrJlBqmELAjcUYn0OnrGekMlLyfbX4WdPJDkN3yVXZZ9vYKMtDxOocFip0GCgVaG6wCHZDRPKt5YHw7xaiEjgG7AAJMCQgSB1il9yp6rmWhFHLTzfjBQDha3M2ly5BfFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgooAZH/x6JmuAUo1d1P2zvBfAAaOQA/ahrE5+5syP4=;
 b=m9c177sQLQZV80j6CnK5sUJVJF/YCBLZzFSpKZ7XexxItCEOtErzrPaMhkHmbXJOJlnC3U48a5hP6h2m2iWdfa9IXoV03S0rGs62t0pKXkRdZMx645gAnscVyTqb6dbstMGYVIy3LhWGr+G+d9aDxW1J/TaqiaeSOxbh77V2nS0=
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com (2603:1096:404:d5::22)
 by TY2PR01MB1977.jpnprd01.prod.outlook.com (2603:1096:404:c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Fri, 28 Aug
 2020 01:39:40 +0000
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::9083:6001:8090:9f3]) by TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::9083:6001:8090:9f3%6]) with mapi id 15.20.3305.032; Fri, 28 Aug 2020
 01:39:40 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Joerg Roedel <joro@8bytes.org>, Rob
 Herring <robh+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: iommu: renesas,ipmmu-vmsa: Add r8a7742
 support
Thread-Topic: [PATCH 1/2] dt-bindings: iommu: renesas, ipmmu-vmsa: Add r8a7742
 support
Thread-Index: AQHWeuqxUasJXAzIakucV8XtlZyI+KlMwiKA
Date: Fri, 28 Aug 2020 01:39:40 +0000
Message-ID: <TY2PR01MB369270F4F0F5753A9A7D4919D8520@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <20200825141805.27105-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200825141805.27105-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200825141805.27105-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: bp.renesas.com; dkim=none (message not signed)
 header.d=none; bp.renesas.com; dmarc=none action=none header.from=renesas.com; 
x-originating-ip: [240f:60:5f3e:1:b16e:b7b1:d350:3c9a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 46368cc6-7a78-4a9a-b0d3-08d84af33b7b
x-ms-traffictypediagnostic: TY2PR01MB1977:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB19770D7EDB631C888C791599D8520@TY2PR01MB1977.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dFpJFfI4xudFciGKler4JxrJwvSz0wyuZmyOjV22Qg3bbwcgQUQu8NaFkYBiWuptJmFke8KcMH1IsuHzIKm0S4xdh5FvZ9J8vfNMsJAUVzK1oc9iCT+XyL+3bT6XW/LYQCJR5TN83LhRL1EWp/vGXICj09vLapPB8UXXvfl7cQqk8ldS1xjV5vV6OIJvO/pK+1ytdg7rnEgSHuDW406V105sg3eF8tpNU418VkBvM4+Tj5WIoGcA/Np6imS6HfauvAQ9TyGu69cC4vGXHB0EnTWD8UcNvj3v6eCXf+fn0yGe+JwTh/Od6Qx3OLx1Xoq2lA5imbp7Mt6VnHHOAsQW+6eBnk1OQHFsz0h2/uNljjaogbCouQcngaZFTMFQ0Aa1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB3692.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(86362001)(4326008)(110136005)(8936002)(8676002)(54906003)(316002)(9686003)(52536014)(71200400001)(2906002)(4744005)(55016002)(66946007)(33656002)(6506007)(66556008)(64756008)(478600001)(7696005)(76116006)(66476007)(66446008)(5660300002)(186003)(142933001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: aA3VKCNUqCcF1WRqEcCbAXjDPd/S5afUjhaB2T7oWVuXOMpeG7t/EYHmaNa38SI/l50nZQG4Zs28RO68MYVOuVcQjOAQmIiIxLApJazMxZrztQFicNKvSBH182U55N7I0z6cR4iGeGwR1ygFn6aSyCDZLstQPiwiRXMF+6oSF8XcfI2Eqb0Ne7XaytfTyixSXrNgStwq/1/CgLk6/Cyl5oZd/67W905Rmc+6lV1XrB269D0UkOZ1sZqWv+ck5AeTgVCzY0fN5CbpmOWR8n0FpF82Wlmbpiudogeg61LANeVRdMK4QGYXyZuY+OsiiS3qd6TT6aMqtKDDg/9xw7PxIvAFhVQahf3SKp35aBZQf/dwnA2XNpXxxKuxm8wB1HkmqCP3CtOdGCdvubdhrpP4546AbeQquYdfFcYMfuBhViaNyjg+YIZ6APQSXwVUZUuGbUPaKOWYIZha45Y3AEYQ5KFCbHTA/4Rsluy2J8Tt60Yx7FuwcMJw7UwdA8FKEXydUl6/H3JCCgodLiFzUrwj2y1yzWuN0/rctFMO/1l08ZgXc/kSDbbIHJRZm3UyeYviITH59/4grOs1p1ZIpdfyKPVD9dobGjkDVcUZveNT6AU6qcle/u0F0bFj3OxRC+YWcTsFJuHN77l87YaRhJp+mXOVCfgxNuO1mZnlqnFQl1DI2AgV+0Ts9tJfPOWx3fgVrBw1JePrpT/vviTFOxUrqw==
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3692.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46368cc6-7a78-4a9a-b0d3-08d84af33b7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2020 01:39:40.6656 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WUS5sT7zF/db6ov42my904PiInMl4KJNSrSkpDStc1j46Yythlurn1swNHJVVdGBtuVKqYAbaCZoEjf5k9v+GUUcnlcAxX2+ZWePSVdhF6SeSDuN62bSCtvixPGupfXa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB1977
Cc: Prabhakar <prabhakar.csengg@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Lad-san,

> From: Lad Prabhakar, Sent: Tuesday, August 25, 2020 11:18 PM
> 
> Document RZ/G1H (R8A7742) SoC bindings.
> 
> No driver change is needed due to the fallback compatible value
> "renesas,ipmmu-vmsa".
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> ---

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
