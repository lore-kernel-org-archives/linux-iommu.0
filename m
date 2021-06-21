Return-Path: <SRS0=Ta7z=LP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918C1C4743C
	for <iommu@archiver.kernel.org>; Mon, 21 Jun 2021 14:10:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3634961261
	for <iommu@archiver.kernel.org>; Mon, 21 Jun 2021 14:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3634961261
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EAA26607A5;
	Mon, 21 Jun 2021 14:10:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PSaxCVE9hfm7; Mon, 21 Jun 2021 14:10:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BAA0D60601;
	Mon, 21 Jun 2021 14:10:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 951E0C0010;
	Mon, 21 Jun 2021 14:10:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B483EC000C
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 14:10:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A26E460601
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 14:10:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WdSKVmeQlN11 for <iommu@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 14:10:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 557CD60017
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 14:10:01 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 j21-20020a05600c1c15b02901dde2accccbso64932wms.4
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 07:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=8kepLA1skYYXxAo8YW3JZV6sp2HsHnw4TxhCp+yjjQg=;
 b=h/9/G+BKEWjlDy3cdYEoizmczLXp8k8O9toVOq6Dnc48Iqq0r+nELVmFqttkJenHOo
 n2j5Idv6Z0CDRsIwKaZhm4xQ/vkIY8xI9Ipvy0R9csY0JiwEjJcmX6MiDjr9TF6ruBof
 I9wBaMgjrWWYA9SFHzCFACRrc29LsSqkVX1rKmzlcM25gkGuCekxVfBhh61S0a2Hcv9M
 4xFlKBEsWluVYnFh0Dw9O/LHIjp8tmv4X7HVeLLBu+AzSuvZI6pxsc4kMHiOBrWusfyg
 TEnOtOujadbTWVKDERUWzTQ8N27HsF4iqqlU2G9GpKhV7aGYYJzKGfofUtsAyC0NPZQD
 nItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=8kepLA1skYYXxAo8YW3JZV6sp2HsHnw4TxhCp+yjjQg=;
 b=sxOEcP73TqR47UZUb1Smq6c4lyg7vZXoR6uUA/YSCZij/sq2wXNNe62D9krCB/w8uf
 Q7eUdcqOXu5bXbInUSJ7ZDQANSy2PDYK+mYkmzRDLp6vSpnlqXnKq18rZfsHxONfI/03
 A2gO5OfStbva+fshDxqy8f3Jo8fDB+ErG8s0KFGzL73c7sqnhVx+6vIeGcphTezPFZ+Z
 gAnpm0spSbRxSfgHMq5/APGju9/bNE39h7Yv58E+rYP5En5Go3Xgii/iYrFdqTNVjJsb
 zo0noGvtqFlyO4UoOaFl7W27I/Yc0IElwA3zaAGCqn7jrbb1F6d+5ktY0dTPV87cXOWR
 K6pQ==
X-Gm-Message-State: AOAM530g6W+fkflx5+dag8ibUB3GSoV6XwCNMX17yrc19bNhPBpd4XqV
 P6nuK5OuqeClP1poNFtKEqk=
X-Google-Smtp-Source: ABdhPJwHv49pYFJDn8vquRM0+2cpK1F0btscoOHXlGyMmv4gAoMpiY01o32Uy1jcbBoDA1Qm2vTxQQ==
X-Received: by 2002:a1c:a3c4:: with SMTP id m187mr15738405wme.41.1624284600021; 
 Mon, 21 Jun 2021 07:10:00 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id m37sm15730023wms.46.2021.06.21.07.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jun 2021 07:09:58 -0700 (PDT)
Date: Mon, 21 Jun 2021 16:11:55 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v3 2/9] dt-bindings: arm-smmu: Add Tegra186 compatible
 string
Message-ID: <YNCeK9cdMPf+serd@orome.fritz.box>
References: <20210603164632.1000458-1-thierry.reding@gmail.com>
 <20210603164632.1000458-3-thierry.reding@gmail.com>
 <CAL_JsqLDKxwANn2Pba0Db6J9337pK0dNL=bBN8ucn-k4DZ3gyg@mail.gmail.com>
 <14551e79-853d-471f-bb5e-0d2d6581a9b6@canonical.com>
MIME-Version: 1.0
In-Reply-To: <14551e79-853d-471f-bb5e-0d2d6581a9b6@canonical.com>
User-Agent: Mutt/2.0.7 (481f3800) (2021-05-04)
Cc: Rob Herring <robh@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jon Hunter <jonathanh@nvidia.com>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Nicolin Chen <nicolinc@nvidia.com>, linux-tegra <linux-tegra@vger.kernel.org>,
 Will Deacon <will@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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
Content-Type: multipart/mixed; boundary="===============0124851076426206582=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============0124851076426206582==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ug2yoxoaj18CzXNu"
Content-Disposition: inline


--Ug2yoxoaj18CzXNu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 21, 2021 at 08:46:54AM +0200, Krzysztof Kozlowski wrote:
> On 18/06/2021 21:47, Rob Herring wrote:
> > On Thu, Jun 3, 2021 at 10:49 AM Thierry Reding <thierry.reding@gmail.co=
m> wrote:
> >>
> >> From: Thierry Reding <treding@nvidia.com>
> >>
> >> The ARM SMMU instantiations found on Tegra186 and later need inter-
> >> operation with the memory controller in order to correctly program
> >> stream ID overrides.
> >>
> >> Furthermore, on Tegra194 multiple instances of the SMMU can gang up
> >> to achieve higher throughput. In order to do this, they have to be
> >> programmed identically so that the memory controller can interleave
> >> memory accesses between them.
> >>
> >> Add the Tegra186 compatible string to make sure the interoperation
> >> with the memory controller can be enabled on that SoC generation.
> >>
> >> Signed-off-by: Thierry Reding <treding@nvidia.com>
> >> ---
> >>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 11 +++++++++--
> >>  1 file changed, 9 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/D=
ocumentation/devicetree/bindings/iommu/arm,smmu.yaml
> >> index 9d27aa5111d4..1181b590db71 100644
> >> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> >> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> >> @@ -54,8 +54,14 @@ properties:
> >>            - const: arm,mmu-500
> >>        - description: NVIDIA SoCs that program two ARM MMU-500s identi=
cally
> >>          items:
> >> +      - description: NVIDIA SoCs that require memory controller inter=
action
> >=20
> > This is not valid jsonschema:
> >=20
> > /builds/robherring/linux-dt/Documentation/devicetree/bindings/iommu/arm=
,smmu.yaml:
> > properties:compatible:oneOf:4:items: 'anyOf' conditional failed, one
> > must be fixed:
> > None is not of type 'object', 'boolean'
> > None is not of type 'array'
> > from schema $id: http://json-schema.org/draft-07/schema#
> > /builds/robherring/linux-dt/Documentation/devicetree/bindings/iommu/arm=
,smmu.yaml:
> > properties:compatible:oneOf:4:items: 'oneOf' conditional failed, one
> > must be fixed:
> > None is not of type 'object'
> > None is not of type 'array'
> > from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
> > /builds/robherring/linux-dt/Documentation/devicetree/bindings/iommu/arm=
,smmu.yaml:
> > properties:compatible:oneOf:4:items: 'oneOf' conditional failed, one
> > must be fixed:
> > None is not of type 'object'
> > None is not of type 'array'
> > from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#
> > /builds/robherring/linux-dt/Documentation/devicetree/bindings/iommu/arm=
,smmu.yaml:
> > properties:compatible:oneOf:5:items: 'oneOf' conditional failed, one
> > must be fixed:
> > [{'enum': [{'const': 'nvidia,tegra194-smmu'}, {'const':
> > 'nvidia,tegra186-smmu'}]}, {'const': 'nvidia,smmu-500'}] is not of
> > type 'object'
> > {'const': 'nvidia,tegra194-smmu'} is not of type 'string'
> > {'const': 'nvidia,tegra186-smmu'} is not of type 'string'
> > from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#
> >=20
> >=20
> > This was not reviewed nor tested since the DT list was not Cc'ed.
>=20
> Ugh, I see now weird empty item on a list... and not only DT list was
> skipped - Thierry did not Cc you either.

This seemed like a too trivial addition to waste Rob's time on, so I
didn't add him (or the DT list for that matter) on Cc. The ARM SMMU
maintainers had reviewed this, which seemed like it was enough for what
the DT bindings change was doing.

In any case, I clearly should've checked the DT binding check output
more carefully. It's rather messy for Tegra because there's quite a few
that we haven't converted yet. I'll have to resume my effort to convert
the remaining ones and fixup the device trees so that we can actually
run the DT binding and DTB validation checks more usefully.

> My bad, I did not check that patch thoroughly before applying.
>=20
> Thierry, please Cc folks mentioned by get_maintainer.pl. Either sent a
> fix or a revert, if fix needs more time.

I've sent out a follow-up fix that removes the two bogus lines. It looks
like that was the result of a bad conflict resolution on my part.

> Additionally, why the patch changes reg to "minItems: 1" for
> nvidia,tegra194-smmu?

This is because originally the Tegra194 SMMU nodes were supposed to only
represent a "dual" instance. However, on Tegra194 there are three SMMU
instances in total, with the third instance (dedicated for isochronous
traffic) being completely separate and having only a single range of
registers.

That third instance was previously supposed to be covered by the normal
"arm,mmu-500" compatible string, but given that we really need that
interoperation between SMMU and memory controller for SID override
programming, we need the Tegra-specific compatible for the ISO instance
of the SMMU as well. And since that uses only one set of registers,
minItems had to become 1.

Thierry

--Ug2yoxoaj18CzXNu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmDQnikACgkQ3SOs138+
s6F2uBAAhnU+wroFvGjGTsdCo19Lye7ZwlgYVldxZuzdoI44tNFapF9qTlWT/yE+
MVCOVn2Z85TkKmMWqZh2qFrbBaX4m0tU2QkoIbs5W7Poc6CECTUUsKRSHFWTojgh
1bak/TQdCSFrpwte1XOZ414EFvXRNIEmB2oD8I714MBAlpzSYLFew+1DkLTtBjqa
2Aa80pzR3OEmGhs4h643KHDdDT3RCFLu/h/Xh2h6FCv900D42bLybO0dUyatGbcX
XilHecs9gsLSysXAyVyDOZ0EDBVPeeQi1CKo6coC5nXg355cEvNWtYjyW9Bi/J7b
m+a3TnU9ryd+fZJFiNTzeu2ElYb8JDotBPf9CeDNeSEL7IHy9o8uOsfM4LJQuCfv
1SCDHiMdSEd7rxk3us3G/yHPaTBSLHIouud7cNy0WCD5JPL/fNgCBSLvOOXFr2LZ
kKx3v++QwiLSn+lJrbb5QKyDLIWhUUrV8L2ssf2WdQGGNNKkMzjXgb99NaHHGpZU
8+q90lfktYxoWX6mehBu1luIJ2CPpvlEdX2Nb6zkHcsCwmzSiKDcTLzeBQLSquH+
5z/FCo/510vTm2rD/9YbjGWbOZ+k8/bs+jTV2rGk/gAxeOuXEbScCyAG7UrFHAvt
F6WCjfa4448VFtk0ww2Gm6DMYyrc5VKyn66oCd/xWl/iOQonB4Q=
=3Q5A
-----END PGP SIGNATURE-----

--Ug2yoxoaj18CzXNu--

--===============0124851076426206582==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0124851076426206582==--
