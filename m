Return-Path: <SRS0=meaX=6A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520E4C352BE
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 10:16:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 225AB206B9
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 10:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="pp6SQBhx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 225AB206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id ED27D875BB;
	Thu, 16 Apr 2020 10:16:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NXo0vydYzOhC; Thu, 16 Apr 2020 10:16:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B38A1875A9;
	Thu, 16 Apr 2020 10:16:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A42F1C1AE8;
	Thu, 16 Apr 2020 10:16:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6AB1C0172
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 10:16:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D2D89221B1
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 10:16:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NSaWsOdIokAP for <iommu@lists.linux-foundation.org>;
 Thu, 16 Apr 2020 10:16:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
 (mail-eopbgr1410113.outbound.protection.outlook.com [40.107.141.113])
 by silver.osuosl.org (Postfix) with ESMTPS id 3812E221AF
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 10:16:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjtaIE0p68uHPj4kDLoV8l9AW3Ti5QUZ+e0K8XKhCK0DIHhD4/1u6lp5FurGTBY/+5kJXubmaVNITV1glyR6XC7kfMp8RjZh1Gi9ArY4M54P5YbJxg9CQIv+3JDXMojo45lUBBWO7LCN8tEZD1jGuXXwL5cDER6QIt1u3BiRkIYbsVXvVVCHt304LbT1VH00LlQ3M5eJ2vAe6XZvmYjUiM2HrZzQWsg0YC2ieUvIUSpRG372hLcXe7aiO5fxINSl83pRMeYn9jT8AoIADo16naY10FvrxcpUgZtFAq0cK8SCom6UqjgJJ8CQaHqHYRgThgJNxztFBtTsJA8pG2dwyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpcoxqpRKMG6ogp7hCOTX4SXvHTFwBxBHVT7PrygP/A=;
 b=EYdBOLEZR5nPVH48+n8JCMoElr8XRrBAWqAJa7shibEk9tgKFY/W+iveCcv0hapIbiDky5z5bZYgKp2FDO1+b6kllvct+SBRKJQfWgJlGKEfyXnQQ8epiwpgVqKpfSx39gAtEyn9nrWviJhThTkPT0wjMFGHOUnVosWBUuTggvjw7BcC6YEB9S6w95Y6sAvzv2TJfpyugsbKVAtEsA1KVEalDStKBC7fY4vtRzCjxHpNjz25SVUQWHkTUyjDRWoXOspbL2CTIWGM4xpQyYxNR3JyN7ToKaASwul6D7mH6Wu91nD7q2oa7uJvE9BJCl17CsrnL4AZG5T/mMLVYQdhPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpcoxqpRKMG6ogp7hCOTX4SXvHTFwBxBHVT7PrygP/A=;
 b=pp6SQBhxmM/3rm9ZcMqJ8mpcxrYiMNjMQmw1xglfKjU1smibYlwrt99CvU0e4ZotUpPS6ujDum3VyR8MgSv0Hg6x/6upNo3RXwYBb/YwIPRgtKiX9/UsJQMin2y1hNQ8K1FpADMumFyGQmi/b1TibG8y6Cg0ZCTHjpPIkt6MMwI=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB2845.jpnprd01.prod.outlook.com (20.177.103.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.15; Thu, 16 Apr 2020 10:16:11 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06%4]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 10:16:11 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: RE: [PATCH] dt-bndings: iommu: renesas,ipmmu-vmsa: convert to
 json-schema
Thread-Topic: [PATCH] dt-bndings: iommu: renesas,ipmmu-vmsa: convert to
 json-schema
Thread-Index: AQHWEX3joQ1TxPqDiku42usLcXTo3Kh6PzwAgAE4wqCAABJiAIAAANaw
Date: Thu, 16 Apr 2020 10:16:10 +0000
Message-ID: <TYAPR01MB4544793C572390BFECFC35B3D8D80@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1586773533-8893-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdXvZp5GFY5-SjXP0PLE8MiwYencVMti93wU4E3N2c0QVg@mail.gmail.com>
 <TYAPR01MB45440F928F3DDBFCDC0A25CED8D80@TYAPR01MB4544.jpnprd01.prod.outlook.com>
 <CAMuHMdUvSka3F=3mU0qpjcOxQVftyxjHFhXbx7b+Pun9226L9g@mail.gmail.com>
In-Reply-To: <CAMuHMdUvSka3F=3mU0qpjcOxQVftyxjHFhXbx7b+Pun9226L9g@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0f3b3dee-b9e3-4e1b-5655-08d7e1ef2fb7
x-ms-traffictypediagnostic: TYAPR01MB2845:
x-microsoft-antispam-prvs: <TYAPR01MB2845A3EC67F29C9D8D4766A8D8D80@TYAPR01MB2845.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0375972289
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYAPR01MB4544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(2906002)(55016002)(55236004)(9686003)(4326008)(33656002)(86362001)(6916009)(478600001)(186003)(71200400001)(52536014)(316002)(64756008)(54906003)(26005)(6506007)(81156014)(5660300002)(7696005)(66446008)(66556008)(66946007)(66476007)(8936002)(8676002)(76116006)(142933001);
 DIR:OUT; SFP:1102; 
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y4vOpgo8ERpwUQ+nAadbGnIgmuZErEmvi2yW1V/m0+NSub6YtpS13iObDtfj2T7NZeyh6Ssdzu2hVag7NXwjTHYa7t3AsvOKRkilTlaZAiVnge/mhRZzfFzVDnYtTfI0L9/b0md0qonjzJp/SuCIhfUE4gsxFXLL/U2gPjosG8xb4IDOK8FIcMz4FxxdCRtHoLYBN5TfydVPPD1smqBP1ZT1z3UfIPOt424C2iWe22MNME4Wz25coDLPQVO80chK3j7+OM0BuZkzt39d7U08ocB9oh15oFivVvY7EcemfQxbX3n3lYtlcogwumRnnYkaGgJE82gosoEKw9n88xpeTDKTG4v1Coiun8KK/QT138CJkn0vjgpTPQ/6YjGy5z86a2ko/nTUrsE/gIoBMklvg/ilKNxFs58qNFHli2lWABrMfFX0AotrPhoPdHHMSrrqisSx3ABOFGvTRNMsSmELbhxxQkaS/gH7rSFziPCf+/CKSblrfsTlJoKSFSdZZbU0
x-ms-exchange-antispam-messagedata: nVFJmugVIHcY1lEGB5BhFvEGVRVj9/oiRhu8IykQzPLahxDWHcJqsIw5Ala2wABPjbT+fqtOOBbFa/ijo2AxGeS5psukHRUXZGNtZQDQWhN9xSVKEYdjoN3uj2oSn6Ir319ftPEhfO2rX0REhhoKlA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3b3dee-b9e3-4e1b-5655-08d7e1ef2fb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 10:16:10.8143 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lGmVP9RThtYoZoR9TGiCGXWPApr/YrSCrykKf+nCrty/LRG4Dc76A8F0jZOXT8RSHiAszxXkav4XsnJ4DePzfs2w9q6Vtm8prnIdNe8KvvZYdoyHbfLaY8vko2xovACg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2845
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND
 FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>
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

> From: Geert Uytterhoeven, Sent: Thursday, April 16, 2020 7:06 PM
<snip>
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
> 
> > > > +  renesas,ipmmu-main:
> > > > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > > > +    description:
> > > > +      Reference to the main IPMMU instance in two cells. The first cell is
> > > > +      a phandle to the main IPMMU and the second cell is the interrupt bit
> > > > +      number associated with the particular cache IPMMU device. The interrupt
> > > > +      bit number needs to match the main IPMMU IMSSTR register. Only used by
> > > > +      cache IPMMU instances.
> > >
> > > This property is not valid only on R-Car Gen2 and R-Mobile APE6.
> >
> > That sounds good. But, since ipmmu_mm on R-Car Gen3 also is not valid,
> > we cannot use compatible property for detecting it.
> 
> What do you mean by "ipmmu_mm is not valid"?

I just wanted to say that ipmmu_mm node on R-Car Gen3 cannot have
this renesas,ipmmu-main property.

> > However, I realized renesas,ipmmu-main is only used by "cache IPMMU"
> > and "cache IPMMU" doesn't have interrupts property. So,
> > I described the following schema and then it seems success.
> > --
> > if:
> >   properties:
> >     interrupts: false
> > then:
> >   required:
> >     - renesas,ipmmu-main
> 
> But all other nodes should have interrupts properties, right?

Yes, that's right.

> So they are mutually exclusive:
> 
>   oneOf:
>      - required:
>          - interrupts
>     - required:
>         - renesas,ipmmu-main

Thank you! Now I understood it and such the schema is better than mine.
I'll fix it.

> > Especially, I could find missing renesas,ipmmu-main property on r8a77980.dtsi
> > like below :)  So, I'll make and submit a fixing r8a77980.dtsi patch later (maybe tomorrow).
> 
> Good! ;-)

:)

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
