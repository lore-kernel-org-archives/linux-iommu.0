Return-Path: <SRS0=Ta7z=LP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83841C48BE5
	for <iommu@archiver.kernel.org>; Mon, 21 Jun 2021 16:01:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C312610EA
	for <iommu@archiver.kernel.org>; Mon, 21 Jun 2021 16:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C312610EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D4AEC40205;
	Mon, 21 Jun 2021 16:01:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RxK6wosS0Gen; Mon, 21 Jun 2021 16:01:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8998540107;
	Mon, 21 Jun 2021 16:01:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67981C0010;
	Mon, 21 Jun 2021 16:01:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F297AC000C
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 16:01:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D49F76070C
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 16:01:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OPzVhplSYPKp for <iommu@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 16:01:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C439C606DA
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 16:01:17 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 o39-20020a05600c5127b02901d23584fd9bso11477938wms.0
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 09:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ivAWWnxfgtrmvv3mt9r+kn10vF6aZeuh33extDSkaTo=;
 b=uOqWwWQ4WOIl9VuV2Y274ZVEHBTN0BdemWxxZnRE4hduwnBUSKhefHy6iBk+4Zsibt
 GDRyURS5vRNIpHQpbAGKCzVSK93YcqY9v9Z5w8BiX5SGcTNKppe8Wp9r1k2FdlIlOB6I
 2vSaJW+0KGyconEKhQBsYZtNheZfpHLphF1nLeGOhSFBYbRershc8nBGaqvuzwZRT76d
 NL/2twFjbBzLAIerHZApKmg/H7YSv/woTz6gs7E1h5pAl68osiT/Pti4kMdbcbZtl/Wd
 nE/heYSlsxk/HBUIQg0dbbJZl+XZtZvc6/86NWBi3fABFvAWVqXODwyc/yUsfwYykoN+
 T/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ivAWWnxfgtrmvv3mt9r+kn10vF6aZeuh33extDSkaTo=;
 b=XI3TUrr4gKhrm0z4FTop5+w7SLzlpxYMRTlvk0ppBsNVLs3oCTBn7c1EeGmRyH0sqj
 0t1ONO88Ngln8UCt7UYjZ9s4hP6gzfXmXkZFo4uzOwC+m0VCyHQC/pidpwRnKD+vwXj3
 NFVQA0RYcAak+z4dMhpI1D9bFopyfyVOHvnxGlsEsZstTUKQjMenv8X4KvkMW6uDjKP1
 A+kVvSnYd2CSG83842K3hKMlXmVTBnWxJYD0eInHfL1pGtbQ++K1IUl6xoUVuYuUGbD8
 jQgCPpZn/mlh/FhzSLFcyfOUXN+GsjO5Y34LuDr6nIp7hy+v5VfVJdbs5VmUVqZkd/zO
 r0xw==
X-Gm-Message-State: AOAM532/hwhRDzunOIsM5409sph2+JJ2T//flnU0XYsmH6AuzVkW6jiy
 qXYG33OuGFhZiWtDi+FWhMQ=
X-Google-Smtp-Source: ABdhPJx7aPSw8G1VbByNyfHybZXWzG2tegvel5Pn2UV6Pnm1dIobwxNlOc5wlZr/ZS/3wK6c5Iaf7Q==
X-Received: by 2002:a1c:4b05:: with SMTP id y5mr4923971wma.96.1624291275970;
 Mon, 21 Jun 2021 09:01:15 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id c13sm18590628wrb.5.2021.06.21.09.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jun 2021 09:01:14 -0700 (PDT)
Date: Mon, 21 Jun 2021 18:03:11 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 2/9] dt-bindings: arm-smmu: Add Tegra186 compatible
 string
Message-ID: <YNC4PxIqUZb6gtZc@orome.fritz.box>
References: <20210603164632.1000458-1-thierry.reding@gmail.com>
 <20210603164632.1000458-3-thierry.reding@gmail.com>
 <CAL_JsqLDKxwANn2Pba0Db6J9337pK0dNL=bBN8ucn-k4DZ3gyg@mail.gmail.com>
 <14551e79-853d-471f-bb5e-0d2d6581a9b6@canonical.com>
 <YNCeK9cdMPf+serd@orome.fritz.box>
 <20210621155418.GA29488@willie-the-truck>
MIME-Version: 1.0
In-Reply-To: <20210621155418.GA29488@willie-the-truck>
User-Agent: Mutt/2.0.7 (481f3800) (2021-05-04)
Cc: Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Jon Hunter <jonathanh@nvidia.com>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Nicolin Chen <nicolinc@nvidia.com>, linux-tegra <linux-tegra@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
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
Content-Type: multipart/mixed; boundary="===============0003982952642680510=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============0003982952642680510==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+CwF57SIeipNOA+L"
Content-Disposition: inline


--+CwF57SIeipNOA+L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 21, 2021 at 04:54:18PM +0100, Will Deacon wrote:
> On Mon, Jun 21, 2021 at 04:11:55PM +0200, Thierry Reding wrote:
> > On Mon, Jun 21, 2021 at 08:46:54AM +0200, Krzysztof Kozlowski wrote:
> > > On 18/06/2021 21:47, Rob Herring wrote:
> > > > On Thu, Jun 3, 2021 at 10:49 AM Thierry Reding <thierry.reding@gmai=
l.com> wrote:
> > > >> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml=
 b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > > >> index 9d27aa5111d4..1181b590db71 100644
> > > >> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > > >> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > > >> @@ -54,8 +54,14 @@ properties:
> > > >>            - const: arm,mmu-500
> > > >>        - description: NVIDIA SoCs that program two ARM MMU-500s id=
entically
> > > >>          items:
> > > >> +      - description: NVIDIA SoCs that require memory controller i=
nteraction
> > > >=20
> > > > This is not valid jsonschema:
> > > >=20
> > > > /builds/robherring/linux-dt/Documentation/devicetree/bindings/iommu=
/arm,smmu.yaml:
> > > > properties:compatible:oneOf:4:items: 'anyOf' conditional failed, one
> > > > must be fixed:
> > > > None is not of type 'object', 'boolean'
> > > > None is not of type 'array'
> > > > from schema $id: http://json-schema.org/draft-07/schema#
> > > > /builds/robherring/linux-dt/Documentation/devicetree/bindings/iommu=
/arm,smmu.yaml:
> > > > properties:compatible:oneOf:4:items: 'oneOf' conditional failed, one
> > > > must be fixed:
> > > > None is not of type 'object'
> > > > None is not of type 'array'
> > > > from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
> > > > /builds/robherring/linux-dt/Documentation/devicetree/bindings/iommu=
/arm,smmu.yaml:
> > > > properties:compatible:oneOf:4:items: 'oneOf' conditional failed, one
> > > > must be fixed:
> > > > None is not of type 'object'
> > > > None is not of type 'array'
> > > > from schema $id: http://devicetree.org/meta-schemas/string-array.ya=
ml#
> > > > /builds/robherring/linux-dt/Documentation/devicetree/bindings/iommu=
/arm,smmu.yaml:
> > > > properties:compatible:oneOf:5:items: 'oneOf' conditional failed, one
> > > > must be fixed:
> > > > [{'enum': [{'const': 'nvidia,tegra194-smmu'}, {'const':
> > > > 'nvidia,tegra186-smmu'}]}, {'const': 'nvidia,smmu-500'}] is not of
> > > > type 'object'
> > > > {'const': 'nvidia,tegra194-smmu'} is not of type 'string'
> > > > {'const': 'nvidia,tegra186-smmu'} is not of type 'string'
> > > > from schema $id: http://devicetree.org/meta-schemas/string-array.ya=
ml#
> > > >=20
> > > >=20
> > > > This was not reviewed nor tested since the DT list was not Cc'ed.
> > >=20
> > > Ugh, I see now weird empty item on a list... and not only DT list was
> > > skipped - Thierry did not Cc you either.
> >=20
> > This seemed like a too trivial addition to waste Rob's time on, so I
> > didn't add him (or the DT list for that matter) on Cc. The ARM SMMU
> > maintainers had reviewed this, which seemed like it was enough for what
> > the DT bindings change was doing.
>=20
> Hmm, I didn't review it. I find the yaml stuff unreadable so I usually
> wait for the DT folks to ack bindings changes before I queue them in the
> SMMU tree.

Alright... in the future I'll make sure to always Cc DT folks, even for
trivial stuff like this.

Thierry

--+CwF57SIeipNOA+L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmDQuD0ACgkQ3SOs138+
s6HSvA/7BHYi/gFhpj4KkJ1anrFhbP8ExJoJGbVVjxip0aEE5drYxHHLf9eORDpC
zm5GpLFak8QUqsmQpu3uJDZV5GngAu+Py7MsD/F/sw/NV4sl/P2QaGO94sv3wxGU
8c/4lslxP+tS/1RQRM51y/UJntsHCMfjsFiGiGQX350CBzw8V8vBb1Hvl9DgUQKN
sW4t3nRr8vE3MfL+Bmd3rROk6sKo6oVpLA7txsPfCr3s4PS4bNo1jbEZBysDukSj
7HfGI+e/lbIBQuOcjWRrpTR2vu7cqYFKJgStP4oNcC/jyh2JuUVc4+3Lt8j8WsSD
DKGtySqU73ZLVhmcDi42mKQLRDnkqetdQvaDr91EVXrNhXCZpZOksY86K0C8cLt5
e+0/WTBftQTnSZE/fEOWVm4DtlxJij5HSScAeC3rXd8P+arP7rxlzRoDeospXKfz
rx0epONpi/LWuzCy8hjtU5+A9Tcl4xD31cEVXxwLMUEIdptt9jJj5/QymsLxW2OJ
noa2gxXa3OTutq7h4SJPRb1BW9kIFuC8lut7rVMnMUnSKgmtK/YbR1dHeHDMxzdR
isHDUlPNS+R/6Qh78c0FrUmySfU91YjBg5JuxY0nek+vmY5jHCZYITBItOfBPq21
30xQwGk0iFKRPoqInoz+sHsJ5+OkecFPXmjBmRBktj8DLfQoemI=
=w4gL
-----END PGP SIGNATURE-----

--+CwF57SIeipNOA+L--

--===============0003982952642680510==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0003982952642680510==--
