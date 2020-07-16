Return-Path: <SRS0=k4B3=A3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E094C433E0
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 05:15:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5845207BC
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 05:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="KEtm/NyG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5845207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A50748A156;
	Thu, 16 Jul 2020 05:15:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F1WfJeImW1Dw; Thu, 16 Jul 2020 05:15:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B4CFD8A141;
	Thu, 16 Jul 2020 05:15:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4F46C07FF;
	Thu, 16 Jul 2020 05:15:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5943DC0733
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 05:15:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4B6C98A9AC
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 05:15:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DpRsB9WqQs90 for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jul 2020 05:15:01 +0000 (UTC)
X-Greylist: delayed 00:17:51 by SQLgrey-1.7.6
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
 (mail-eopbgr1410120.outbound.protection.outlook.com [40.107.141.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7D2418A97F
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 05:15:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIjgIw/++zk6fGfjfHjnVdbXDgM+cmAh4vG/wTAApGZLquU+42lwKEdgdRsrqqhjCBueLq/erWhX0IzePddeMwbSiEKt6q+JpPztSdJA3+ViBmJNvKmLkiUHZ+Rgk6eBvK929gwHyC5SD3krDq4Srjh9yQ/3AGIaGMgzIdXzxjTfMYqon1KQ9wvgGIuhHv4d+Q/oNJWOQMLullok+f+qhgJlp+JqVJY0veuB/QxboozvRCunWuMO37IaAJFWIPmlslx+XiV6n/CxuVbVPfRqUV1H3Zmvw6iJc46eJwXeyeA9TeQ6bwINo3R7N0hOPZuVCaADsx7Pv/pacRoNxOJldw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DVXuK7GGEsLWJlaOFlMVK7TjEgvAtSeGuZSvF7Sxeo=;
 b=fVUBFBXDvZ+zsperyvp9sRIkTCCLjcd1Tor9JQQ6j2T8WqjYcUcBQVLhzwImphhHR0dLOcGSRoxl3rVGPRiM8OLIzXlmzFTGs2rfsN7W37JYyhqWev4y68qAkSQvi4jrG/YYaz5vz4Q03eM7xGIDVrfC4LKjdH6d10jxBmG+m6tccNJ9jw9cEV7sPhERFQYO0I0OFajvs46p/2upeAu51pHdCkMxFeaFLUS9TCVrZshAUIDPvpmnm8YeTJSMC9zbp0azY8cZcUaaaagaCMh+a+VBCUCGuvzVTas/L8HeQEdHoPHUULpMfjXRy7x/QO/olMxAp1p8dNgCEZR75IzQkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DVXuK7GGEsLWJlaOFlMVK7TjEgvAtSeGuZSvF7Sxeo=;
 b=KEtm/NyGi5hK2HI9ojd+4gDXDjKMIKzBX9A6TTFPNS2MJFutbsUn8J1ixbc6kGNnXLoH1mg6zj/fzUEvgY6zidBeBv29UfIZ4n5HmLq8Q+Y7g0jsuLeLoed9tqcPP1v2fcqFAhzfR7+MT7OYuhkgvNSRcMIkF+6FCgkYKuIT8Hw=
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com (2603:1096:404:d5::22)
 by TYAPR01MB2671.jpnprd01.prod.outlook.com (2603:1096:404:8d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Thu, 16 Jul
 2020 04:42:21 +0000
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::9083:6001:8090:9f3]) by TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::9083:6001:8090:9f3%6]) with mapi id 15.20.3195.017; Thu, 16 Jul 2020
 04:42:21 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: RE: [PATCH 2/9] iommu/ipmmu-vmsa: Hook up R8A774E1 DT matching code
Thread-Topic: [PATCH 2/9] iommu/ipmmu-vmsa: Hook up R8A774E1 DT matching code
Thread-Index: AQHWWV2MbTXg+hkXBUeG2IKsFpTIWqkGuXGAgAAF1ACAAAM3gIAALMKggAAVtICAAp3DYA==
Date: Thu, 16 Jul 2020 04:42:21 +0000
Message-ID: <TY2PR01MB3692CFA8B51F91FB9735026FD87F0@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <1594676120-5862-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594676120-5862-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdV4zzrk_=-2Cmgq8=PKTeU457iveJ58gYekJ-Z8SXqaCQ@mail.gmail.com>
 <CA+V-a8tB0mA17f51GMQQ-Cj_CUXze_JjTahrpoAtmwuOFHQV6g@mail.gmail.com>
 <CAMuHMdXM3qf266exJtJrN0XAogEsJoM-k3FON9CjX+stLpuMFA@mail.gmail.com>
 <TY2PR01MB3692A868DD4E67D770C610E3D8610@TY2PR01MB3692.jpnprd01.prod.outlook.com>
 <CAMuHMdUry12MnLvVgmd7NJ+Gv4mA86qKKfsQobP1o-ohzKm=RQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUry12MnLvVgmd7NJ+Gv4mA86qKKfsQobP1o-ohzKm=RQ@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-m68k.org; dkim=none (message not signed)
 header.d=none; linux-m68k.org; dmarc=none action=none header.from=renesas.com; 
x-originating-ip: [240f:60:5f3e:1:999:df6f:dcad:bd95]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 86c67283-184a-47a2-e326-08d82942a0aa
x-ms-traffictypediagnostic: TYAPR01MB2671:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB26710915A5EDF2C69467A2FBD87F0@TYAPR01MB2671.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M4RkfSw2dSVC0Ylu4gbH8smqKZ1JZ5nYHnfx1DAInZC9j4sYADG5ObrAdZAMl3mtRkvB7OprMG3AJKRWYCSPyQ76yK9OCIEOOlbiYIOrq89jGyYAy/jhjFq2FXw0Y5HLUBvQcsPZ/mYMRGLiT46/sfCYFcll+3Gubt0TmwmaB2aGu/S0XpTlg0RhgJ7Rb1TdK3TI418OVdYSeJ5R8KucXEsBTBqlayvpdE+ZZoc7Qa8buA03KhcTTppzm2WnfGi5oXIg2sKr1F5lrMuvWH5v6V8zKkJ/WgfQt3E40jcDGXOz2iKZgN6XI6kqGMn78a3uE4d0EKM+7u+Z/+OOusn5GfT1zcfL5ijZuG/mREODedYd6NLBAdpzpma+L/m39peEmYPJaiub+wHgYbhjLKyW3A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB3692.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(316002)(6916009)(76116006)(86362001)(66946007)(66446008)(71200400001)(7416002)(2906002)(66556008)(9686003)(54906003)(55016002)(64756008)(66476007)(8676002)(7696005)(4326008)(33656002)(5660300002)(52536014)(6506007)(53546011)(186003)(8936002)(478600001)(52103002)(158003001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: BZQ062kPob81tYpmM06yPo4OBfHiNnEJ8giVl1UFBgDYuTwdu7M5YZDWvNT5KJeG6pXVCLn55g5mkAYx36RmQ7E3Gjx0OnEPMaRdS0prhfvpi0cgwdSaiEVWnAC4QTLXzKh26CxPzOli4cH3RtaNZdNwfe+npuKrsc06/RtMLsQR4kwvpf2toLSEOcDp5moi0OQtvgABmYWwofNEgMXYEF/oYpnzfV09YU9ZZEukQ6T/6g6iuHLIHt5QzMXKrLXpvmnTfQ8tN4am/H9U7lLW/hjrsdZV36OrXh4G0AcTPjUY5d/TPBjG2cgkknHTbITbejmpl82xQAXVtMSnMuQA3WiLE3bIFbixhQkOIzZu9POrgGan7bls5VRycI3Q4itPixUwerBT064vBVH33/bSjNMwhaX3LJFXuRihuu86Ugr+FoBp+MqV90ODVcSmB2p6PV0SqVX9n8xy6+xOWDIvAAgjJPP0AqjrKgMJ2aTEhjmriXq/GH+8rMFedIHReEj5RQV62ow+H7Q9pvp1xFO06bTOo1sRUn5qDkbQS6GdVTE=
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3692.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c67283-184a-47a2-e326-08d82942a0aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2020 04:42:21.1420 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7z1K7SMbli5BPYc4Xt56Di64XGWfm2KzcRHuABMz1c2N0cl7vXzA/k6lasM5dL9KvKFVlSeE6tSb//WFbZoNg66zzlUpdTVp/8P+GlxDkXtAc3LE6MB0kjUCd+65XFIQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2671
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, netdev <netdev@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Sergei Shtylyov <sergei.shtylyov@gmail.com>,
 Magnus Damm <magnus.damm@gmail.com>, "Lad,
 Prabhakar" <prabhakar.csengg@gmail.com>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 dmaengine <dmaengine@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
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

> From: Geert Uytterhoeven, Sent: Tuesday, July 14, 2020 9:40 PM
> 
> Hi Shimoda-san,
> 
> On Tue, Jul 14, 2020 at 1:42 PM Yoshihiro Shimoda
> <yoshihiro.shimoda.uh@renesas.com> wrote:
> > > From: Geert Uytterhoeven, Sent: Tuesday, July 14, 2020 5:42 PM
> > > On Tue, Jul 14, 2020 at 10:30 AM Lad, Prabhakar
> > > <prabhakar.csengg@gmail.com> wrote:
> > > > On Tue, Jul 14, 2020 at 9:09 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > On Mon, Jul 13, 2020 at 11:35 PM Lad Prabhakar
> > > > Also the recent patch to add
> > > > "r8a77961" just adds to soc_rcar_gen3_whitelist.
> > >
> > > Oops, commit 17fe16181639801b ("iommu/renesas: Add support for r8a77961")
> > > did it wrong, too.
> >
> > Thank you for the point it out. We should add r8a77961 to the soc_rcar_gen3[].
> > However, I don't know why I could not realize this issue...
> > So, I investigated this a little and then, IIUC, glob_match() which
> > soc_device_match() uses seems to return true, if *pat = "r8a7796" and *str = "r8a77961".
> 
> Are you sure about this?

I'm very sorry. I completely misunderstood the glob_match() behavior.
And, now I understood why the current code can use IPMMU on r8a77961...
# Since the first soc_device_match() will return false, ipmmu_slave_whitelist()
# will return true and then the ipmmu_of_xlate() will be succeeded.

> I enabled CONFIG_GLOB_SELFTEST, and globtest succeeded.
> It does test glob_match("a", "aa"), which is a similar test.
> 
> To be 100% sure, I added:
> 
> --- a/lib/globtest.c
> +++ b/lib/globtest.c
> @@ -59,6 +59,7 @@ static char const glob_tests[] __initconst =
>         "1" "a\0" "a\0"
>         "0" "a\0" "b\0"
>         "0" "a\0" "aa\0"
> +       "0" "r8a7796\0" "r8a77961\0"
>         "0" "a\0" "\0"
>         "1" "\0" "\0"
>         "0" "\0" "a\0"
> 
> and it still succeeded.

I'm very sorry to waste your time about this...

Best regards,
Yoshihiro Shimoda

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
