Return-Path: <SRS0=kThj=K4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0923CC47083
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 08:50:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACE42613D3
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 08:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACE42613D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 68DA2835A6;
	Wed,  2 Jun 2021 08:50:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yPGEOtPO2nuO; Wed,  2 Jun 2021 08:50:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id A720B831A7;
	Wed,  2 Jun 2021 08:50:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8549BC000E;
	Wed,  2 Jun 2021 08:50:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A898C0001
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 08:50:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 69CC3401FA
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 08:50:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6bbTbGWR-OAS for <iommu@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 08:50:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0BF3C401D2
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 08:50:43 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id g20so2791418ejt.0
 for <iommu@lists.linux-foundation.org>; Wed, 02 Jun 2021 01:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=jfHhOkr5oRpwhcn/dzyulVUHea2BAf1l3IILcH6GJvg=;
 b=KSXjDeRuS4TDpidd7KGIhkQvk04ZjF/KBg1BT4Qxv+hZNcyVXRU3uHH/uipZrIH9ec
 y/dGrxBi74DxJ0HUDx9ACKMfc461//RGhAYVm8o2CpoQox/z4OSPErtkm4cK5miQCxyg
 TcFpwcpOIqUp+EwfXZoj80zeIf/7oW+KKAeIrPZA1Cr62mPdJNqJAiLVf1h3A3KW5+Ui
 9Xem4RhciT2x6ZoMPPcVVhWVUCrc/Jrf+IqH67vhbjhyMHgRKz1c2AIVNmoviJ+IQvKT
 N61LVyw5VBuFjUs3wlUDzOBuNuY/WZGDq+NWrjv6traDmixoxMcEI53wRDDgztkwUARJ
 qsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=jfHhOkr5oRpwhcn/dzyulVUHea2BAf1l3IILcH6GJvg=;
 b=fvO0ht7AyW4aY9foWzBiYMUQez1sFq6dLJ1nBrRo/2uPIXOC/KQdC+iv8ri0DfRulP
 frCK76I6vAxpCbWxuq2MaoAQ75/Ving4FGc2GnhAj8kmFGlDmgktKcBjoXaFJ+xKxDI/
 Nvn658W2YVXatHfFvq3R53PnphC+saFjOUneyozDBUTS6N2hZfn6BoRGVY6y2LDrYArj
 RFOxK9q6EaT0h+7yVQAzUkl9AkKJfmePNC5QEOMnbmee+zMPJxE2XGFXvcEt44rflzyQ
 4admUeBTHDBxpdXdrHtuhZ+g7NXXY9kwMaXRmtSgk5kT5wFmudW0SJDOtatt/bZvdXOY
 kPDg==
X-Gm-Message-State: AOAM533KlLmplB/laZy0thiLtHKxVVYWuQ4NMjSxt5phcqdTZoQZ2kci
 9hBf048DkwjDiY4C08rvkCI=
X-Google-Smtp-Source: ABdhPJz9iGXnkWDeLG4szjDriiFGBV56UP/M9sFVOQYgpX7ABv7shgsozjzYFxg2+3ipyDvqwwSrkg==
X-Received: by 2002:a17:906:c010:: with SMTP id
 e16mr33534111ejz.214.1622623841920; 
 Wed, 02 Jun 2021 01:50:41 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id gv11sm3061599ejb.13.2021.06.02.01.50.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jun 2021 01:50:40 -0700 (PDT)
Date: Wed, 2 Jun 2021 10:52:16 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v2 00/10] arm64: tegra: Prevent early SMMU faults
Message-ID: <YLdGwD0dxfER4USn@orome.fritz.box>
References: <20210420172619.3782831-1-thierry.reding@gmail.com>
 <YLEi2FonP568wYrE@orome.fritz.box>
 <20210601122646.GB27832@willie-the-truck>
 <YLZ3qPC8ofjsGkPi@orome.fritz.box>
 <6826d892-d1ac-e3b1-ebee-68392d11d7c5@canonical.com>
 <8c70f82f-0db9-2312-7fc4-c079899c25a0@canonical.com>
MIME-Version: 1.0
In-Reply-To: <8c70f82f-0db9-2312-7fc4-c079899c25a0@canonical.com>
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
Content-Type: multipart/mixed; boundary="===============0981570467871310838=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============0981570467871310838==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PzNzpL2lnE7MtP+o"
Content-Disposition: inline


--PzNzpL2lnE7MtP+o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 02, 2021 at 09:35:13AM +0200, Krzysztof Kozlowski wrote:
> On 02/06/2021 09:33, Krzysztof Kozlowski wrote:
> > On 01/06/2021 20:08, Thierry Reding wrote:
> >> On Tue, Jun 01, 2021 at 01:26:46PM +0100, Will Deacon wrote:
> >>> On Fri, May 28, 2021 at 07:05:28PM +0200, Thierry Reding wrote:
> >>>> On Tue, Apr 20, 2021 at 07:26:09PM +0200, Thierry Reding wrote:
> >>>>> From: Thierry Reding <treding@nvidia.com>
> >>>>>
> >>> Probably best if I queue 3-6 on a separate branch once you send a v3,
> >>> then Krzysztof can pull that in if he needs it.
> >>
> >> Patch 5 has a build-time dependency on patch 1, so they need to go in
> >> together. The reason why I suggested Krzysztof pick these up is because
> >> there is a restructuring series that this depends on, which will go in=
to
> >> Krzysztof's tree. So in order to pull in 3-6, you'd get a bunch of oth=
er
> >> and mostly unrelated stuff as well.
> >=20
> > I missed that part... what other series are needed for this one? Except
> > Dmitry's power management set I do not have anything in my sight for
> > Tegras memory controllers.
> >=20
> > Anyway, I can take the memory bits and provide a stable tag with these.
> > Recently there was quite a lot work around Tegra memory controllers, so
> > this makes especially sense if new patches appear.
>=20
> OK, I think I have now the patchset you talked about - "memory: tegra:
> Driver unification" v2, right?

Yes, that's the one. That series is fairly self-contained, but Dmitry's
power management set has dependencies that pull in the regulator, clock
and ARM SoC trees.

I did a test merge of the driver unification series with a branch that
has Dmitry's patches and all the dependencies and there are no conflicts
so that, fortunately, doesn't further complicates things.

Do you want me to send you a pull request with Dmitry's memory
controller changes? You could then apply the unification series on top,
which should allow this SMMU series to apply cleanly on top of that.

I can also carry all these changes in the Tegra tree and send a PR in a
few days once this has seen a bit more testing in linux-next, which also
makes sure it's got a bit more testing in our internal test farm.

Thierry

--PzNzpL2lnE7MtP+o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmC3RsAACgkQ3SOs138+
s6HVFg//atk6G7hTlv5sn3s/G3YEJyP2SCQhtRd1CLlwU1YkoTgQ0PJ1q99DrE9Z
sWfZAAC+t4ler/ZdWQCwclFLt5H3GXSfbVjMc5bTm7+cdk6XnKJY17xgiOEOTCpr
T75lkHzkY0HWcWqt8g+ZifX2yXlF/y1tmDnIDdNp/sZpwaS2VOMJCl9kZJrv7A2z
bq2hlCdw/Fkw+SpUpsZaoI93ObWIQSXz19zcDChwPWa0yKuQAUgZtMmhyM0oTNyY
TkMVikzE0ff/xoZgdcCby03adaqTZlFWR0AwOsOilK2hnl6SbblnXAUwxRzASLDF
qF2T+jsMYyH2Hg11Q1ZqW68obPUugPiDsetFMMo6WBe9u0Cxlsd1rVZ3jIka6cUq
Njok0m6NhtCi04BTHKt6KEnTmAr9AuuHCnxlWNCZSdlnFKm7ZaH7JjJYIqLKFEMo
jihj17YZwYbJiaZ/uvamjS9Ij5LMlmsQSgaXJkEQoxmYNH1PkC7mYxNPcyz0BsrN
UCANWH2bEOwz51QS/eOdv8vAWBdLDLQ4Yh7n+FIORJapBZtJZ/14iAxwIOq491Mp
ObDkAl9ULvjhfeXhgolCbHG74sBsWcm27c+rhh3iSyknkN4Hb6fc2q1NZMwtQ132
sEPLkhYmGOI0h1mnr06qAliHOoyjQJb6+mfl4QENaRIUeqZyjEs=
=DLjh
-----END PGP SIGNATURE-----

--PzNzpL2lnE7MtP+o--

--===============0981570467871310838==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0981570467871310838==--
