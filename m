Return-Path: <SRS0=v902=AZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862F9C433E4
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 13:16:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26582224B2
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 13:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="ZGmCD41K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26582224B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EB03088F96;
	Tue, 14 Jul 2020 13:16:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0BRgnpKESu7U; Tue, 14 Jul 2020 13:16:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5609788FC7;
	Tue, 14 Jul 2020 13:16:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42D04C0891;
	Tue, 14 Jul 2020 13:16:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46B2CC0733
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 13:16:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 34BD08A1B0
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 13:16:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4DRaNIeJbw29 for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jul 2020 13:16:37 +0000 (UTC)
X-Greylist: delayed 01:34:21 by SQLgrey-1.7.6
Received: from APC01-PU1-obe.outbound.protection.outlook.com
 (mail-eopbgr1320129.outbound.protection.outlook.com [40.107.132.129])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 433048A1B1
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 13:16:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfnCAz8yGyYW+NReN7H9FW5G8IZBREOfIjCRsOv6Sz4PaRaigR7xFmGxsVXwqJGFZzh11KWBeUFI9Mt/75rFOkUbHXfCuZSi0cSifQW0Of9u4hx7G04J5ktDmc5ROJ3KReoQR+eTk/SCAuhoxYOZnyKL845uP247p5djSg591yfY2bDlizMKKYegIPXw+ecvm976dacRjxSL0C7cO3dJ+cWFhHqO2cizjRpSefcTYcMN5TtloHhzL767rnorGQWTKeSKqNFyP4svj70qN9T8C7lSqd404dbiiVh1qScmfCGhRfvdNvcWVSvXHF4Ce50EPil4+tBgkZnHK+f/aE1xnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaumU8bjD36B9WihkPMfdgN0iyWNTMYlNLUEJa8aNBo=;
 b=MoSaeaZHisxM7isEIA5jTSe5Z+6SMkcJasTJrKIBqbNMnUwBo3dAHUXigDyTkvzwhPe1SuYvQuhji8zHQdbdFBD/6R3BSytgh5IDzvXHHRvURdymYOwYhrbU8FUzJ9pRKpK5CXxHdSCPEr8iFuHwwftg+O3oXdbMYK+s+CC6c8JPLXcUUrmp941pG1PJSdXdlVm0cXouEjhDC/KkQPklzfkC0RyzkgbPVZxQxW/ELxYUq3ux1D2DPTj/5sP7nKgj2+JOZTzLgk5LAGopFnJ4+asIAp3GjZDPqBqp6yn00HacsJd+/BkQbh9NA19bgxIc6JpJyuCvCSRdoyTSatYuJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaumU8bjD36B9WihkPMfdgN0iyWNTMYlNLUEJa8aNBo=;
 b=ZGmCD41KWj/Ejcxa4nz8FGKXeEDzsbF8uoBzB5xBMemwKKVy+UoPFAvi6mK+YEZJH5Iyr0PvVo1flN1bDOu59o5aknwNpoTEK6OxWtv1TppidMC7meF4Q58o4Y9ftayvzo80jwfv1xBDj3KMHBhMexW1wVNO/qpgRofiq3XP51M=
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com (2603:1096:404:d5::22)
 by TY2PR01MB4506.jpnprd01.prod.outlook.com (2603:1096:404:119::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Tue, 14 Jul
 2020 11:42:11 +0000
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::9083:6001:8090:9f3]) by TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::9083:6001:8090:9f3%6]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 11:42:11 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>, "Lad, Prabhakar"
 <prabhakar.csengg@gmail.com>
Subject: RE: [PATCH 2/9] iommu/ipmmu-vmsa: Hook up R8A774E1 DT matching code
Thread-Topic: [PATCH 2/9] iommu/ipmmu-vmsa: Hook up R8A774E1 DT matching code
Thread-Index: AQHWWV2MbTXg+hkXBUeG2IKsFpTIWqkGuXGAgAAF1ACAAAM3gIAALMKg
Date: Tue, 14 Jul 2020 11:42:11 +0000
Message-ID: <TY2PR01MB3692A868DD4E67D770C610E3D8610@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <1594676120-5862-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594676120-5862-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdV4zzrk_=-2Cmgq8=PKTeU457iveJ58gYekJ-Z8SXqaCQ@mail.gmail.com>
 <CA+V-a8tB0mA17f51GMQQ-Cj_CUXze_JjTahrpoAtmwuOFHQV6g@mail.gmail.com>
 <CAMuHMdXM3qf266exJtJrN0XAogEsJoM-k3FON9CjX+stLpuMFA@mail.gmail.com>
In-Reply-To: <CAMuHMdXM3qf266exJtJrN0XAogEsJoM-k3FON9CjX+stLpuMFA@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-m68k.org; dkim=none (message not signed)
 header.d=none; linux-m68k.org; dmarc=none action=none header.from=renesas.com; 
x-originating-ip: [240f:60:5f3e:1:2d25:f7bf:9b71:7e0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6097b998-8199-4d15-95ad-08d827eaf28c
x-ms-traffictypediagnostic: TY2PR01MB4506:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB450618B750931E3B7AB7CDD0D8610@TY2PR01MB4506.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GiDvEhjEHo9m/Mq2c5p/QHtl3xx0GiVkWWCb5AIDS2OlbOmDNeFqLJ/pEjPdo6QpdIyzEudL/lGBSyKxmPXXresq0dm21jFF+d/+lwoV3kOn0cS7FuW4c8QclCLGax6dtzYN9YfyIg5waMMqY28HI+0biG2uC7irj51CuNWIVV0I3sKThsztb89pd50U5+6ucvF6C/zMwrJHMKoKP35zqGATp9we8ShGE6LLCt+mn0nYNh37YdIsVWHh4ZhyVCUvrnNrbY7vOg8wp4n0LYbLcSDwK31yIKyvv58u5mJ1Y5d8VaTt+LVxBUqVCUlb00q0AkotqhQYPFJHa9DGyaFA8l3s/uvb1V1MZWhXA0NG8gTy/7cxyl+WNEZvyIwIT3X/dXOhQSOPHK4aIniBrwKcwQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB3692.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(66556008)(53546011)(6506007)(64756008)(66446008)(66476007)(86362001)(186003)(71200400001)(7696005)(54906003)(8936002)(110136005)(76116006)(4326008)(66946007)(52536014)(9686003)(2906002)(8676002)(55016002)(5660300002)(33656002)(498600001)(7416002)(83380400001)(52103002)(158003001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: loXaNbR5PEQBHs+48101/R0kj/aaSAkDAlI3RMZyOAL8XTOARGC0TOk58B4Fbz/aWiXDQt6wrKrCn+ATdFMJhNTbTm9etxtmPeqEjUgEOkNVaKBluB5X1dbs9uPJ9YCrrcC1T+t139hYxvNPoAuwxV2tKfXGDkHiazCuba4O/o+kemDRNidnz/6ez0A5khR7d4J54+F7Jc/pDA+KDVpffJ4I0y44BptzVaRRD1B4ymdv6suE8/Z49f687HqhTDemkda6OAOSDgdXBzDTwdWVs+5mI4I1RVDlukugnBG+yLCjJGCN6Kwzsk+aCWjO7gB8DgMTAyiIRpTApDIxrlZbNp+m+DkOCk5brg3bkQ2xOWQZeaaj3jx2lJQAgUMKE77cvYgXpNT7m8HCzXJybB0XxcqPoYcEikWKIHaLr9zi899QuQa0ev/GajUQOxiZspmhIWyDh1aqxu3lcgCw6tEGq17oCEtbmOezEQTddLAKJS8U210fx7dMWeeHAqN1LSnd1ZvWdvSMIqFOq99CRQ4p1L0P0xV3nS+mGWztLpCHiHU=
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3692.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6097b998-8199-4d15-95ad-08d827eaf28c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2020 11:42:11.6846 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ScZmrTio0vecAJe2vVQVEn3xs81LsK5HX1ocHzsHI/1PJ1FoAOqBbJ4vWkLl1H3JNNXTbjQKtb4olM9kL1BfLn5B7LBj94p9rEyb1I3J3MeElL2TKHCqn/CdB4sOS/G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4506
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 netdev <netdev@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Sergei Shtylyov <sergei.shtylyov@gmail.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, dmaengine <dmaengine@vger.kernel.org>,
 Jakub Kicinski <kuba@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Hi Geert-san,

> From: Geert Uytterhoeven, Sent: Tuesday, July 14, 2020 5:42 PM
> 
> Hi Prabhakar,
> 
> On Tue, Jul 14, 2020 at 10:30 AM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Tue, Jul 14, 2020 at 9:09 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Mon, Jul 13, 2020 at 11:35 PM Lad Prabhakar
> > > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > > From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> > > >
> > > > Add support for RZ/G2H (R8A774E1) SoC IPMMUs.
> > > >
> > > > Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Thanks for your patch!
> > >
> > > > --- a/drivers/iommu/ipmmu-vmsa.c
> > > > +++ b/drivers/iommu/ipmmu-vmsa.c
> > > > @@ -751,6 +751,7 @@ static const struct soc_device_attribute soc_rcar_gen3[] = {
> > > >  static const struct soc_device_attribute soc_rcar_gen3_whitelist[] = {
> > > >         { .soc_id = "r8a774b1", },
> > > >         { .soc_id = "r8a774c0", },
> > > > +       { .soc_id = "r8a774e1", },
> > >
> > > Adding an entry to soc_rcar_gen3_whitelist[] doesn't do anything, unless
> > > you also add the same entry to soc_rcar_gen3[].
> > >
> > I think the comment "For R-Car Gen3 use a white list to opt-in slave
> > devices." is misleading.  Booting through the kernel I do see iommu
> > groups (attached is the logs).
> 
> Indeed. Without an entry in soc_rcar_gen3[], the IPMMU is enabled
> unconditionally, and soc_rcar_gen3_whitelist[] is ignored.
> That's why you want an entry in both, unless you have an R-Car Gen3
> SoC where the IPMMU works correctly with all slave devices present.
> Perhaps soc_rcar_gen3[] should be renamed to soc_rcar_gen3_greylist[]
> (or soc_rcar_gen3_maybelist[]) to make this clear?

I think so (we should rename it).

> > Also the recent patch to add
> > "r8a77961" just adds to soc_rcar_gen3_whitelist.
> 
> Oops, commit 17fe16181639801b ("iommu/renesas: Add support for r8a77961")
> did it wrong, too.

Thank you for the point it out. We should add r8a77961 to the soc_rcar_gen3[].
However, I don't know why I could not realize this issue...
So, I investigated this a little and then, IIUC, glob_match() which
soc_device_match() uses seems to return true, if *pat = "r8a7796" and *str = "r8a77961".

Best regards,
Yoshihiro Shimoda

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
