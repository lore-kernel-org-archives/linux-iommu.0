Return-Path: <SRS0=kThj=K4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1395C4708F
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 14:52:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CA02613BF
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 14:52:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA02613BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 17D85402E5;
	Wed,  2 Jun 2021 14:52:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GihWHVATDm2O; Wed,  2 Jun 2021 14:52:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 74D64401F1;
	Wed,  2 Jun 2021 14:52:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50C17C000E;
	Wed,  2 Jun 2021 14:52:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6876EC0001
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 14:52:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 45D1B403B1
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 14:52:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aR1m2QpMvKLA for <iommu@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 14:52:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1C0304039A
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 14:52:00 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id m18so1515112wmq.0
 for <iommu@lists.linux-foundation.org>; Wed, 02 Jun 2021 07:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Nkt8KPfqDi5TWbmstglfL/OjBRc12eUZyJN6dfxcyYY=;
 b=BDMMSY1r3vq78bjj63/onXAzk5YkXmwDy3/sAEHfpPzBLxNb9fCTeksBW2hODNwTwy
 8wSAi6uKRHoiNsQwvcG7TqA7xxVdYf3N8oQ8mIoXwUBy9IHxNzVs/fcSnzDLBYD2K2F2
 j21MnMC0cCynQ5vNhDGn1prpPjD0A0hOLLGDPIt97H+Gk1nm7ZWZhmitkZLJpPYzE3ur
 Wqei6CiD1o0hFdwF6nCqDrvGUNNVJ+Cw8HQ9b8q/UausgN6FwzgSWLg3fugUbo4eLYo9
 aEEMcHRonggkPeABE5ULJgTf20C3SXejxfjEx4dSSDfWpJCYcQ2iKj7Lif/jWC/bMT1n
 DQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Nkt8KPfqDi5TWbmstglfL/OjBRc12eUZyJN6dfxcyYY=;
 b=Mc2zElJ4xo0KMKu7xWk/M+ohvJZ35ozMQT705C0gamTD7IW49NsgblGzkXBNKuq6HS
 waNhQAuetSb1u+HeAMXvhKKfSk+olFS2oe6GlKmbYtdJCI+Q/iShQdiO+ndW8BCLdl03
 sJw63QfnDWEK6Z4hiwOl0aw/r+H9JmI9bm3kSZrh/8FUZ9V+X91MAG47F4OhRDXt1eAg
 LF1gXhdQVliU9KsfdpSWS7cLsDCB/kDR4K7KdDEfgO6AXmqiPu1dhHgDb5i1A83qkm6O
 oNJvGUyB/4or5a0h1MfWUgpv8Dnp5IEHpeEDAKaefdqJJtUhIMNGquvD7HWT9WzRHgFY
 n28w==
X-Gm-Message-State: AOAM5301HmMYHfDV92CaI9C3LV6AKTbvff6uhVBOGnEi/Kaky+zOfkxu
 QYaAT5rVRdjVvnmqB9cRkb8=
X-Google-Smtp-Source: ABdhPJzGxjKaKFjAqs6BqyH5Kj1Mmxy0tLQHDRb8S3XCS8M8JiNPS0yt/Vl7BSPAGGmUgNtADYcMGg==
X-Received: by 2002:a1c:f213:: with SMTP id s19mr16770790wmc.61.1622645518300; 
 Wed, 02 Jun 2021 07:51:58 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id v7sm189546wru.66.2021.06.02.07.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jun 2021 07:51:57 -0700 (PDT)
Date: Wed, 2 Jun 2021 16:53:33 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v2 00/10] arm64: tegra: Prevent early SMMU faults
Message-ID: <YLebbQZlROtSq124@orome.fritz.box>
References: <20210420172619.3782831-1-thierry.reding@gmail.com>
 <YLEi2FonP568wYrE@orome.fritz.box>
 <20210601122646.GB27832@willie-the-truck>
 <YLZ3qPC8ofjsGkPi@orome.fritz.box>
 <6826d892-d1ac-e3b1-ebee-68392d11d7c5@canonical.com>
 <8c70f82f-0db9-2312-7fc4-c079899c25a0@canonical.com>
 <YLdGwD0dxfER4USn@orome.fritz.box>
 <e2341ca1-7b6d-cc19-8c43-1ada0b1f5601@canonical.com>
MIME-Version: 1.0
In-Reply-To: <e2341ca1-7b6d-cc19-8c43-1ada0b1f5601@canonical.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org,
 Jon Hunter <jonathanh@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 linux-tegra@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
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
Content-Type: multipart/mixed; boundary="===============7180958434012768818=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============7180958434012768818==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="d7meRK8uCRENx+0w"
Content-Disposition: inline


--d7meRK8uCRENx+0w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 02, 2021 at 12:44:58PM +0200, Krzysztof Kozlowski wrote:
> On 02/06/2021 10:52, Thierry Reding wrote:
> > On Wed, Jun 02, 2021 at 09:35:13AM +0200, Krzysztof Kozlowski wrote:
> >> On 02/06/2021 09:33, Krzysztof Kozlowski wrote:
> >>> On 01/06/2021 20:08, Thierry Reding wrote:
> >>>> On Tue, Jun 01, 2021 at 01:26:46PM +0100, Will Deacon wrote:
> >>>>> On Fri, May 28, 2021 at 07:05:28PM +0200, Thierry Reding wrote:
> >>>>>> On Tue, Apr 20, 2021 at 07:26:09PM +0200, Thierry Reding wrote:
> >>>>>>> From: Thierry Reding <treding@nvidia.com>
> >>>>>>>
> >>>>> Probably best if I queue 3-6 on a separate branch once you send a v=
3,
> >>>>> then Krzysztof can pull that in if he needs it.
> >>>>
> >>>> Patch 5 has a build-time dependency on patch 1, so they need to go in
> >>>> together. The reason why I suggested Krzysztof pick these up is beca=
use
> >>>> there is a restructuring series that this depends on, which will go =
into
> >>>> Krzysztof's tree. So in order to pull in 3-6, you'd get a bunch of o=
ther
> >>>> and mostly unrelated stuff as well.
> >>>
> >>> I missed that part... what other series are needed for this one? Exce=
pt
> >>> Dmitry's power management set I do not have anything in my sight for
> >>> Tegras memory controllers.
> >>>
> >>> Anyway, I can take the memory bits and provide a stable tag with thes=
e.
> >>> Recently there was quite a lot work around Tegra memory controllers, =
so
> >>> this makes especially sense if new patches appear.
> >>
> >> OK, I think I have now the patchset you talked about - "memory: tegra:
> >> Driver unification" v2, right?
> >=20
> > Yes, that's the one. That series is fairly self-contained, but Dmitry's
> > power management set has dependencies that pull in the regulator, clock
> > and ARM SoC trees.
> >=20
> > I did a test merge of the driver unification series with a branch that
> > has Dmitry's patches and all the dependencies and there are no conflicts
> > so that, fortunately, doesn't further complicates things.
> >=20
> > Do you want me to send you a pull request with Dmitry's memory
> > controller changes? You could then apply the unification series on top,
> > which should allow this SMMU series to apply cleanly on top of that.
>=20
> Makes sense and it looks quite bulletproof for future changes. Let's do
> like this. I will apply your patch 1/10 from this v2 on top of it and
> driver unification later.

The SMMU series here depends on the unification series, so the
unification series needs to go first. It'd be a fair bit of work to
reverse that because the ->probe_device() callback implemented by the
first patch of this SMMU series is part of the tegra_mc_ops structure
that's introduced in the unification series.

Thierry

--d7meRK8uCRENx+0w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmC3m2oACgkQ3SOs138+
s6E4eg//aFBqXZzywd1NQPNcq3zTATqjd/of/rM4RoIKdQ/wYGhm+Ur8KI4gqdvL
Y0kfriu2nyazB5sOTW8avX9HldBX+Pey5Th0/9c/RnkKmc7Z8KyaL0ojdXt7je/K
HOmKbNn8ndcpZWGQXqMSz6F2v9DQFNr27eJnPBQMCj+RGJeje50FQd9sQz8pedkm
mjaNs9d0aV/oa/poHWYU+R0nIyDYVAaEVZvajtOP4nJo+kacKp1zf5wa0OCHKUed
8VmvD817JVUj7FOSLn6y7pCiJnbZcLsSoL/DwGqv/ehq7dd9bq1iAh+FMX2yggr+
B2Y6fKnLEh+6D75ncsAE7ouD4f3jNNF9tHk3w5e5ci9fV0l6W8J3dlEWTMYurfa7
AIP38eZwDNtxazgYx00CXdHOzPfrDP3oHfLGBo48fmsV5zesLvzZQujxFXpiSzfP
wYdHWCok+79iu4FxO7lqsj3hlCxfAtKrnz/itYbSLrkooe5DrYoLmBHQVBNauQJz
2juAU0hyYP5OSN7T/rtQvj3OR8e/XIX10pJxOPiYTS2/bkWBEvUxM61+oc4OMy4r
AvKuNI70T1vHlfr8EN4X5ucttyoBNqeADiKmzlAD9RaGA1zucEesp8vd5xzDNsBs
8lr2OA03q+sX+VpMHufXXOiLZFDJZ5ADd8Xys+CNfEIfJ6sL/OY=
=FosS
-----END PGP SIGNATURE-----

--d7meRK8uCRENx+0w--

--===============7180958434012768818==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7180958434012768818==--
