Return-Path: <SRS0=meaX=6A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB29BC2BB85
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 09:56:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B84D2078B
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 09:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="Tq6cqM3E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B84D2078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3FABA861C8;
	Thu, 16 Apr 2020 09:56:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SRunaL3tezEr; Thu, 16 Apr 2020 09:56:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1009085FD7;
	Thu, 16 Apr 2020 09:56:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB68CC089E;
	Thu, 16 Apr 2020 09:56:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4129AC0172
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 09:56:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 291E1220EF
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 09:56:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wF28eDsV0Aoa for <iommu@lists.linux-foundation.org>;
 Thu, 16 Apr 2020 09:56:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
 (mail-eopbgr1400138.outbound.protection.outlook.com [40.107.140.138])
 by silver.osuosl.org (Postfix) with ESMTPS id 32F50220CE
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 09:56:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2AUyEmLDpUwVfXKlB0yCi9Ox909gXH0t4AgqCVK+fSGf3E+JKUOvheMnxkXClgHnOQNBdq7J2z9V95TOM6swr1sCxhyTPK4rDynadb4hbXzu0Lk+Ldq71l3LjA+fIGX3r82zysasUtjjrk2VAj6DpVhVb32Kd7wCGC5MC3IdT6AuCE23tK19agZLqnuCmsq0kUaO7J2gxYRfsDiUcf+YEIr6PqIQTp4zQ8UPUgR/O8KulysACZ9xws+PvrD0qV5l+V72bJKMoo3021X6buwhHTW2RgmS5BluCg0Px5yNVfajN+gmFqeHl9KcNIr8lnsqyvkSw4YnPm2H8enOgRDGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZB6oRNZFNhi4ftFlmS2fnWMOubGrGwHjKXIJ73z8uA=;
 b=bQGuFf02E3tkOimQK7wQGj8YmzM1q+w2Of1lYlQ4JcM3hfQ8nunQoibJuOFrcVuZe3enfkzqwl/om3o56ruUIcbM8t6ZcitPJ9QMWXdsXz+D9ZqaNPpXx9bgPSwTM+nlGyDYet9TGxePNe1Z9Sats37IVGau1oLwovB4M3i/qNzQrvIjJT13GmG+c1G6+pIPG1GickUX5wzXwnOAUqWJ4jGzjFkKsrZslwSxOV5nuY5QJQZkD1mHwftvqmv2u3v4RxG6zORgHg8s01gw7thMN3JjGssJzYT7aNlXFX7lmbbuezL1KAKGQ4GFBqbDYspDCN6vsD50fn4fZduelKxfiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZB6oRNZFNhi4ftFlmS2fnWMOubGrGwHjKXIJ73z8uA=;
 b=Tq6cqM3EwVakGhL6h0hxdXG6cbsbq+7LlFV7YrRRODHiyHTenh+q1ZBAGv8D091mHZrr3/2BNT2Nk2fLquUmPxCNAYXQx/IrBqhmsRvAiJTyd6bbkgMIHwJxH7i7tJs56gIIMqIDc+oGoqJi2kQJvI5KY0mRw8O3r6fuFhEA26E=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB4445.jpnprd01.prod.outlook.com (20.179.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.24; Thu, 16 Apr 2020 09:56:26 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06%4]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 09:56:26 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: RE: [PATCH] dt-bndings: iommu: renesas,ipmmu-vmsa: convert to
 json-schema
Thread-Topic: [PATCH] dt-bndings: iommu: renesas,ipmmu-vmsa: convert to
 json-schema
Thread-Index: AQHWEX3joQ1TxPqDiku42usLcXTo3Kh6PzwAgAE4wqA=
Date: Thu, 16 Apr 2020 09:56:26 +0000
Message-ID: <TYAPR01MB45440F928F3DDBFCDC0A25CED8D80@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1586773533-8893-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdXvZp5GFY5-SjXP0PLE8MiwYencVMti93wU4E3N2c0QVg@mail.gmail.com>
In-Reply-To: <CAMuHMdXvZp5GFY5-SjXP0PLE8MiwYencVMti93wU4E3N2c0QVg@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6479769d-b651-4367-2164-08d7e1ec6dbd
x-ms-traffictypediagnostic: TYAPR01MB4445:
x-microsoft-antispam-prvs: <TYAPR01MB444526EA3A398329E9A62785D8D80@TYAPR01MB4445.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0375972289
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYAPR01MB4544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(81156014)(8936002)(8676002)(9686003)(186003)(5660300002)(6506007)(33656002)(52536014)(26005)(53546011)(55236004)(66446008)(64756008)(66476007)(71200400001)(54906003)(66946007)(316002)(7696005)(76116006)(66556008)(86362001)(55016002)(966005)(2906002)(478600001)(4326008)(6916009)(142933001);
 DIR:OUT; SFP:1102; 
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ELjp4EQ4X3d94pDhGmzvuvdrptK0r6vmexzUzIO/Mt9uUYhkhHp8ucfJCF61djD9RJuPXBTFf9WhOEyTM9KpIHCwqqctdoE8cs1v676CaFjJouSBNYic2YdUftD2Z4lINFR319ACwGKqUj4ZDJQ1VMQK8XHfy4MpdybOkWLGLFOVJbEjwC5p7BNrFk730ET2YA/nYFWMrELee4yUPvYA1/NKK4NWw9BgplTOdjlJab2zSSc6x4Os19y+xpb76eWXI3hGYvkHcjA9NF5I/4itJWSeBADxQ0jvWl0ZPsIwOQWB85YjwIsOMv/XZkcpiL04cOk2W6pIcQjcVqAsa8SUgZfN5qCF7So9FzIGBYvz55ADWGlgIWWlIz4HkoMSm9O6UC9dypJPrZhhrzp4dJT43bhYHMADcwsj353hxdm9mSD7/0AUVzLLb6GqSkhGGy6wtOMEQIAURMDkX1zvlAxxY0RVziDHPyUxE6XZ9QwPT9xJwegEp/2DU5zS5/dKdLt7faj+8pj+Qe7UWUQ/n5KKZhxPkHbNpilJAX+tq37cIcXHgFnLNckdv+qOzO5ZEAoe
x-ms-exchange-antispam-messagedata: he58nIc/FzhTBg3rr8OEitQwVpldqG6uXBcJXVt/duTs3ZOjD8gqtZyFTt/Gg7C3lfsJqD2fPDqnGSafQfQCcN7TKmt6S5sby1ztTBqG7Xa3n2ofxHOVIh0DHu6A1OyqScmWgrlFhArVAt16o03Hqg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6479769d-b651-4367-2164-08d7e1ec6dbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 09:56:26.3888 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O2DYEe18D4XXcJTEsaQRulIKMy+REO4fkud77yNKVOVEtvbY2xxkBgjz/5BQBQQVqFzXtVwK17hmo+xoza07mytpFXx9ZjV0LXqnIzARRKZvC6EWbdDWlEWFADS5r3zF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4445
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

Thank you for your review!

> From: Geert Uytterhoeven, Sent: Wednesday, April 15, 2020 11:21 PM
> 
> Hi Shimoda-san,
> 
> On Tue, Apr 14, 2020 at 2:26 AM Yoshihiro Shimoda
> <yoshihiro.shimoda.uh@renesas.com> wrote:
> > Convert Renesas VMSA-Compatible IOMMU bindings documentation
> > to json-schema.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
> > @@ -0,0 +1,90 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iommu/renesas,ipmmu-vmsa.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Renesas VMSA-Compatible IOMMU
> > +
> > +maintainers:
> > +  - Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > +
> > +description:
> > +  The IPMMU is an IOMMU implementation compatible with the ARM VMSA page tables.
> > +  It provides address translation for bus masters outside of the CPU, each
> > +  connected to the IPMMU through a port called micro-TLB.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - renesas,ipmmu-r8a7743  # RZ/G1M
> > +              - renesas,ipmmu-r8a7744  # RZ/G1N
> > +              - renesas,ipmmu-r8a7745  # RZ/G1E
> > +              - renesas,ipmmu-r8a7790  # R-Car H2
> > +              - renesas,ipmmu-r8a7791  # R-Car M2-W
> > +              - renesas,ipmmu-r8a7793  # R-Car M2-N
> > +              - renesas,ipmmu-r8a7794  # R-Car E2
> > +              - renesas,ipmmu-r8a7795  # R-Car H3
> > +          - const: renesas,ipmmu-vmsa  # R-Car Gen2 or RZ/G1
> > +      - items:
> > +          - enum:
> > +              - renesas,ipmmu-r8a73a4  # R-Mobile APE6
> 
> I believe the R-Mobile APE6 IPMMU is similar to the R-Car Gen2 IPMMU,
> and thus belongs in the section above instead.

I think so.
Since the original document doesn't mention about R-Mobile APE6,
I wrote this here. But, I also think R-Mobile APE6 IPMMU is similar to
the R-Car Gen2 IPMMU. So, I'll change renesas,ipmmu-r8a73a4
to the above section and fix comment of renesas,ipmmu-vmsa

> > +              - renesas,ipmmu-r8a774a1 # RZ/G2M
> > +              - renesas,ipmmu-r8a774b1 # RZ/G2N
> > +              - renesas,ipmmu-r8a774c0 # RZ/G2E
> > +              - renesas,ipmmu-r8a7796  # R-Car M3-W
> > +              - renesas,ipmmu-r8a77965 # R-Car M3-N
> > +              - renesas,ipmmu-r8a77970 # R-Car V3M
> > +              - renesas,ipmmu-r8a77980 # R-Car V3H
> > +              - renesas,ipmmu-r8a77990 # R-Car E3
> > +              - renesas,ipmmu-r8a77995 # R-Car D3
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    minItems: 1
> > +    maxItems: 2
> > +    description:
> > +      Specifiers for the MMU fault interrupts. For instances that support
> > +      secure mode two interrupts must be specified, for non-secure and secure
> > +      mode, in that order. For instances that don't support secure mode a
> > +      single interrupt must be specified. Not required for cache IPMMUs.
> 
>     items:
>       - description: <non-secure ...>
>       - description: <secure ...>

I got it. I'll add items.

> > +
> > +  '#iommu-cells':
> > +    const: 1
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  renesas,ipmmu-main:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    description:
> > +      Reference to the main IPMMU instance in two cells. The first cell is
> > +      a phandle to the main IPMMU and the second cell is the interrupt bit
> > +      number associated with the particular cache IPMMU device. The interrupt
> > +      bit number needs to match the main IPMMU IMSSTR register. Only used by
> > +      cache IPMMU instances.
> 
> This property is not valid only on R-Car Gen2 and R-Mobile APE6.

That sounds good. But, since ipmmu_mm on R-Car Gen3 also is not valid,
we cannot use compatible property for detecting it.

However, I realized renesas,ipmmu-main is only used by "cache IPMMU"
and "cache IPMMU" doesn't have interrupts property. So,
I described the following schema and then it seems success.
--
if:
  properties:
    interrupts: false
then:
  required:
    - renesas,ipmmu-main
--

Especially, I could find missing renesas,ipmmu-main property on r8a77980.dtsi
like below :)  So, I'll make and submit a fixing r8a77980.dtsi patch later (maybe tomorrow).

  CHECK   arch/arm64/boot/dts/renesas/r8a77980-condor.dt.yaml
/opt/home/shimoda/workdir/json-schema/arch/arm64/boot/dts/renesas/r8a77980-condor.dt.yaml: mmu@e7b00000: 'renesas,ipmmu-main' is a required property
/opt/home/shimoda/workdir/json-schema/arch/arm64/boot/dts/renesas/r8a77980-condor.dt.yaml: mmu@e7960000: 'renesas,ipmmu-main' is a required property

Best regards,
Yoshihiro Shimoda

> (untested)
> 
> oneOf:
>   - properties:
>       contains:
>         const: renesas,ipmmu-vmsa
>   - properties:
>       renesas,ipmmu-main:
>         $ref: /schemas/types.yaml#/definitions/phandle-array
>         description:
>           [...]
> 
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
