Return-Path: <SRS0=BRyA=YI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE1FECE58C
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 05:17:31 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA1742089C
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 05:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="D9csnlfj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA1742089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 74725949;
	Tue, 15 Oct 2019 05:17:30 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A76DE3EE
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 05:17:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
	(mail-eopbgr1410092.outbound.protection.outlook.com [40.107.141.92])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BBC2E5D3
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 05:17:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=hc43Yh2qHpvEluJGKc/q5N0EsTyhnG/UtQEmyLjKYprd3WI50M6hahmn4yj6/hXQrtnzw7BFSj7JUA2Cx7Z1znJwgesS/SVf3Av+XBwZSQLhTfhLehvzCIPMX1P2hAps4K778BsYPvSWGazL1y7HUfrEFXVwMbGMbSgCgh7ib7HqWFBz4/f7NprmQ1hKI2rsrwg81C6Wy6hEUrX4JQro5Q9gjvWI9K2umMsfSIObdlna2ckyUZXLCREkPhXHJHbkG/K/bGPLBeKJZ+Qxcv3ayyuWyV+ZrEQZD3BM3ZGXyWOzlOtl6NnqalufowDx0GBq1Kc/iAA9EH0x/TjuJrO7AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=M8/KRecnhWuT/zs+4X5+2FBOvwO4o2oN0baGlaj/jbQ=;
	b=Lv9heihlLBALKocGYyU+R2Zu8sL3wWxo05BrB1+OBZsgT0s8dUJcx4P5XsWT287dTaCxn1a43nzdOllFFzWRyxuNtA8r5ewMlSQXIDrIVcMRCZEgKsEXJVjhUejFV5vxCMhMu3+c8mahymh0YcucQUCVJb+Mn4uoA/zOyQ1dbToID+5tIuqrN02oMqYgYrVURKoTB+xd7BpIKJkK9xwo2HCXTFz4Tgll9lR/J9iqMOnjsg0d3lPuDiRZXID99VH6P/T8jmyVE4PAsGbhAyeRN12VV+eKRojr6vJDQnGS8Jbl8Ldr0+YmjEI16DaJhLihh0FL3GJTasGgjWnDP+TlGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
	smtp.mailfrom=renesas.com;
	dmarc=pass action=none header.from=renesas.com; 
	dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=M8/KRecnhWuT/zs+4X5+2FBOvwO4o2oN0baGlaj/jbQ=;
	b=D9csnlfjw/qPZRTMi+/92sIPWFAZfDsi35sSTRhBcrFBLHwZ0XKBEHOWcRJB551Zc4IKSnYRSP3YC8zVpa/JQP7YytjOW20bVBcFbtcI+XpUXycgFSvVZQhnPYNOwmLFMOy7ueDvk1YE/Iqu4JZRDh/j1/N2y/nlrOi6rh8VVAY=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
	TYAPR01MB3534.jpnprd01.prod.outlook.com (20.178.137.79) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2347.16; Tue, 15 Oct 2019 05:17:25 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
	([fe80::548:32de:c810:1947]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
	([fe80::548:32de:c810:1947%4]) with mapi id 15.20.2347.023;
	Tue, 15 Oct 2019 05:17:25 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: RE: [PATCH 1/3] iommu/ipmmu-vmsa: Remove some unused register
	declarations
Thread-Topic: [PATCH 1/3] iommu/ipmmu-vmsa: Remove some unused register
	declarations
Thread-Index: AQHVfntOozqAfyzDl0yYqMh+u83hVKdVXOgAgAXRHJA=
Date: Tue, 15 Oct 2019 05:17:25 +0000
Message-ID: <TYAPR01MB4544CF27B1D041472CC5D5B8D8930@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1570609609-1332-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1570609609-1332-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<CAMuHMdWfHYDOKSJBUCVLG6yNKxbv=jUd9E1B_fiBOQajwi_wEg@mail.gmail.com>
In-Reply-To: <CAMuHMdWfHYDOKSJBUCVLG6yNKxbv=jUd9E1B_fiBOQajwi_wEg@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [150.249.235.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af8abc84-2fe3-4fe1-6e28-08d7512ef74b
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: TYAPR01MB3534:
x-microsoft-antispam-prvs: <TYAPR01MB3534CDE6C21898B95227C23DD8930@TYAPR01MB3534.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01917B1794
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(199004)(189003)(6246003)(9686003)(7736002)(305945005)(5660300002)(14454004)(53546011)(33656002)(66946007)(76116006)(86362001)(66476007)(66556008)(71190400001)(71200400001)(4326008)(64756008)(66446008)(8936002)(55016002)(186003)(76176011)(25786009)(6916009)(102836004)(6506007)(229853002)(26005)(6436002)(11346002)(446003)(478600001)(486006)(74316002)(7696005)(14444005)(99286004)(8676002)(476003)(66066001)(54906003)(81156014)(2906002)(81166006)(256004)(3846002)(6116002)(316002)(52536014);
	DIR:OUT; SFP:1102; SCL:1; SRVR:TYAPR01MB3534;
	H:TYAPR01MB4544.jpnprd01.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: renesas.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9mYQNfxqL4Dh5ZaTVQi5ZIhLaxygy4lmA9yowlWnI07Y5O0/WZKjn+3YxPLwr5XcUUUux2e/aYsVciwKId7qQIRm45mcdU2PK/0eP3GfsjE/eYL6V6uLTxPLy8B/cMFJYRGnJBs5mpgcLSVtMebCzIkVkzCWn/VqN0OR/OpW+u/Gt9pHesIU/jN2YTVIkBBgKJHg7lVYpCKhxnMgnpXyD+POchCDBI6kYrPXRxaBLQYRAvf5GehuC+ueyEjVi09npyNAbLMGnBD3S9/svJDq5nOg3Y8bHgSwI0bpjjGCb4zd/c5U71Vc3+ybZMh+GnOA1h+Y+A56TXuSD50YYQGynweQsPs0KXn7H85z0K9vvKt5+tPH1YvuwVcgTmwYcmb7dvqVNezZh63tl59XJArXnL1lOQ21G7V3Me7HJEY1jB0=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af8abc84-2fe3-4fe1-6e28-08d7512ef74b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2019 05:17:25.2357 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vMadipa3QuARPbvCdNXXZ5HOWvzjDW1KrnYRruxVhvfLuUh1ril1OOCI7+2Zrhg12oeuf3QpsAL/okK5Qy06voakPt225VtI95QVx9kJgE+PlvW5Qa+GrB+t5Mij6lWX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3534
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux-foundation.org>
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

Hi Geert-san,

> From: Geert Uytterhoeven, Sent: Friday, October 11, 2019 9:11 PM
> 
> Hi Shimoda-san,
> 
> Thanks for your patch!
> 
> On Wed, Oct 9, 2019 at 10:27 AM Yoshihiro Shimoda
> <yoshihiro.shimoda.uh@renesas.com> wrote:
> > To support different registers memory mapping hardware easily
> > in the future, this patch removes some unused register
> > declarations.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thank you for your review!

> While I can confirm the removed definitions are unused, they were
> still valid (but see comments below).
> Perhaps it would be better to add comments, to state clearly to which
> SoCs or SoC families they apply?  Or do you think this would be futile,
> and would add too much clutter to the source file in the near future?

I think adding comments to the declarations are better to avoid
incorrect implementation in the future. So, I'll make such an incremental patch.

> > --- a/drivers/iommu/ipmmu-vmsa.c
> > +++ b/drivers/iommu/ipmmu-vmsa.c
> > @@ -104,8 +104,6 @@ static struct ipmmu_vmsa_device *to_ipmmu(struct device *dev)
> >  #define IMCTR                          0x0000
> >  #define IMCTR_TRE                      (1 << 17)
> >  #define IMCTR_AFE                      (1 << 16)
> > -#define IMCTR_RTSEL_MASK               (3 << 4)
> 
> FWIW, this is valid for R-Car Gen2 only.  On R-Car Gen3, the field
> contains 3 bits.

That's correct.

Best regards,
Yoshihiro Shimoda

> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
