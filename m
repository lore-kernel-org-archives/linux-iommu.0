Return-Path: <SRS0=Vfdp=LE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A02C48BD1
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 15:03:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EA41613DD
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 15:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA41613DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 28D0F40543;
	Thu, 10 Jun 2021 15:03:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xEb4U94cxEBg; Thu, 10 Jun 2021 15:03:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E660F403CE;
	Thu, 10 Jun 2021 15:03:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9E4AC000E;
	Thu, 10 Jun 2021 15:03:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1542C000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 15:03:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BF93D83C20
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 15:03:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oqEx4nChtIBL for <iommu@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 15:03:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8258683C12
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 15:03:46 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id f2so2686194wri.11
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 08:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=maDX1SqEQGmbJlvnWGoFUMoFJ5cg99gOE1aPzue8sQc=;
 b=CM3OxKfIneIAUiLf5Zk7CX1dZ+8sSdQ76IbHP2tuZgRjPcYy/z1Yv6PUlaqE9NYSBo
 QWw2VAs6hA/Rt5fp6On+lvmLyJXpiGVnNihRdFlPAjoGXJ361gMv8lMt4qkdtZAHUnlK
 +WB8MpPrfSQJoARGfQzv3XE4xtLN2foAvm4fcVvJdrgxn1B++udXsElXnAMJpTewDg2w
 ubV1bzDUShW6GGqKdbh+b5iiVANMa9DBWeBV3ce6k1PXFUK3ich76bw4yYXaTlTf/yY/
 idZsW7AX4esUjWByduaTJLezo70qlY0CUWWXtc/drySh17MBJAT8e/vM4/bav/3ulLIi
 09DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=maDX1SqEQGmbJlvnWGoFUMoFJ5cg99gOE1aPzue8sQc=;
 b=Z+giyKYWjFXOQF7FMPPX2i/mMbD86RMYew6BksbFXkrY4UDpRKi8Uyl9OmbV4xthlr
 T9hvfd+JSnVeBxyubuTba0wO2Ukh0tLethG5MrazQMnYt08sJn0AXSukMIzPINhANbtr
 frygO5pYvWQfXuCRtrQbWLTZXvL2FSf7FsjTRW7YnEmCI+kDMrPeOeKM5+4lH7uWsz6k
 ESpzaJL40hCPJfU/MvWUTySKaFi8rKHKNVbedeW12e2xwZUE1haa91mhKgNAHEpQbOO5
 dcz3BENuiIkVjlelAtDcex+T/FIJcSAGlr09kPLAYZMWzYnkuTdVqictpjZAAoWaxR+M
 T6xQ==
X-Gm-Message-State: AOAM533AoD09LHnsZDuxvHQvDCebqxJVCJhw7CRCuVGSdajpmzEK8nzh
 U2DJZqsvoJeZBIzy/dVgUiE=
X-Google-Smtp-Source: ABdhPJwI0pDe52r2vhAsfmYMLDJnqn5RBM1d0jDdXYIV9WJl4CSRRI62IkWpVAjPBPaE3eD5NbX/ng==
X-Received: by 2002:adf:f7d1:: with SMTP id a17mr6103816wrq.84.1623337424570; 
 Thu, 10 Jun 2021 08:03:44 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id m132sm3222349wmf.10.2021.06.10.08.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jun 2021 08:03:43 -0700 (PDT)
Date: Thu, 10 Jun 2021 17:05:27 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Will Deacon <will@kernel.org>
Subject: Re: [GIT PULL] memory: Tegra memory controller for v5.14
Message-ID: <YMIqNynz29Z9fYi3@orome.fritz.box>
References: <20210607084910.21024-1-krzysztof.kozlowski@canonical.com>
 <20210608120128.GB10174@willie-the-truck>
 <YL+A+MPjjaa3nSwq@orome.fritz.box>
 <20210608164851.GB10994@willie-the-truck>
 <YMHZCaRiQNQCSsVr@orome.fritz.box>
 <8c18edeb-2e3e-9072-6bb4-11637d0ca3e5@canonical.com>
MIME-Version: 1.0
In-Reply-To: <8c18edeb-2e3e-9072-6bb4-11637d0ca3e5@canonical.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
List-Id: <soc.lore.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org, soc@kernel.org,
 arm@kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
 Dmitry Osipenko <digetx@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
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
Content-Type: multipart/mixed; boundary="===============0671210389416832140=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============0671210389416832140==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7mpR+8HugVK1gP7Y"
Content-Disposition: inline


--7mpR+8HugVK1gP7Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 10, 2021 at 04:23:56PM +0200, Krzysztof Kozlowski wrote:
> On 10/06/2021 11:19, Thierry Reding wrote:
> > On Tue, Jun 08, 2021 at 05:48:51PM +0100, Will Deacon wrote:
> >> On Tue, Jun 08, 2021 at 04:38:48PM +0200, Thierry Reding wrote:
> >>> On Tue, Jun 08, 2021 at 01:01:29PM +0100, Will Deacon wrote:
> >>>> On Mon, Jun 07, 2021 at 10:49:10AM +0200, Krzysztof Kozlowski wrote:
> >>>>> This is the pull for you to base further SMMU aptches (prevent earl=
y SMMU
> >>>>> faults).
> >>>>
> >>>> This is a tonne of code for me to pull into the SMMU tree given that=
 I only
> >>>> want one patch!
> >>>>
> >>>> Thierry, if I just stick:
> >>>>
> >>>> https://lore.kernel.org/r/20210603164632.1000458-4-thierry.reding@gm=
ail.com
> >>>>
> >>>> on its own branch, can you stitch together whatever you need?
> >>>
> >>> I'm not sure I understand what you're proposing. For reference, here's
> >>> the set of patches that I sent out:
> >>>
> >>>   1. memory: tegra: Implement SID override programming
> >>>   2. dt-bindings: arm-smmu: Add Tegra186 compatible string
> >>>   3. iommu/arm-smmu: Implement ->probe_finalize()
> >>>   4. iommu/arm-smmu: tegra: Detect number of instances at runtime
> >>>   5. iommu/arm-smmu: tegra: Implement SID override programming
> >>>   6. iommu/arm-smmu: Use Tegra implementation on Tegra186
> >>>   7. arm64: tegra: Use correct compatible string for Tegra186 SMMU
> >>>   8. arm64: tegra: Hook up memory controller to SMMU on Tegra186
> >>>   9. arm64: tegra: Enable SMMU support on Tegra194
> >>>
> >>> Krzysztof already picked up patch 1 and I was assuming that you'd pick
> >>> up 2-6 because they are to the ARM SMMU driver. However, if you're
> >>> primarily interested in just patch 3, which is more "core" ARM SMMU t=
han
> >>> the rest, which are Tegra-specific, then I suppose what we could do is
> >>> for you to give an Acked-by on the rest (2, 4-6) and then Krzysztof o=
r I
> >>> can pick them up and take them via ARM SoC, based on the stable branch
> >>> from your tree that only has patch 3.
> >>
> >> I think you previously said that patch 5 depends on patch 1, so I can't
> >> take 2-6 without also pulling in the memory controller queue.
> >>
> >>> Patch 6 touches arm-smmu-impl.c, though it's a two-line change that
> >>> touches only the Tegra-specific matching bit in arm_smmu_impl_init(),=
 so
> >>> the likelihood of that conflicting with anything else is fairly small.
> >>>
> >>> Is that what you were proposing?
> >>
> >> I can queue as much or as little of 2-6 as you like, but I would like =
to
> >> avoid pulling in the memory controller queue into the arm smmu tree. B=
ut
> >> yes, whichever of those I take, I can put them on a separate branch so
> >> that you're not blocked for the later patches.
> >>
> >> You have a better handle on the dependencies, so please tell me what w=
orks
> >> for you. I just want to make sure that at least patch 3 lands in my tr=
ee,
> >> so we don't get late conflicts with other driver changes.
> >=20
> > Yes, if you could pick up patch 3 and send out a link with the stable
> > branch, I think Krzysztof or I could pull in that branch and pick up the
> > remaining patches. It'd be good if you could also ack the remaining SMMU
> > patches so that ARM SoC knows that they've been sanctioned.
> >=20
> > Krzysztof: would you be okay with picking up patches 2 and 4-6 on top of
> > your memory branch for v5.14?
>=20
> You mean the iommu patches? Yes, I can take them and later explain to
> Arnd/Olof why they come through me.

Okay, great.

Will, can you provide that stable branch? Or would you prefer if I
prepared it and sent you a pull request? We're kind of running out of
time, since for ARM SoC the cut-off point for new material is usually
-rc6 and that's coming up pretty fast.

Thierry

--7mpR+8HugVK1gP7Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmDCKjQACgkQ3SOs138+
s6G9mxAAvng5nEyjLg9tvjEBYmqVzd3B9QUm5jd6sZZq6YdD6wjrUpmwWSTcP7XI
dJ9T722dGWz3HENw9AIgv4zMj2/ws8g84+1dvjL/eo56PaWLoNdCpm2IokdKjl2G
3sjYPEBPyEr+nqvsu+wIMbYeiXGfK2nndGg+Mw5wBnt/dQ5fYPLtKc/o5XSo5M5R
7qmp3ekHSU5fD/X8F5+bCZajyaVyLFNU58FdsCf0yRTcqED5uWPO0TPp/VwPnlIw
Q19s+JQD+V4XbFMgSadlPF8VP/Dht7W8tiUBl5WpoPMqFpBa8AtkZ6VrAjaM92tf
fTyVdA/fZg04rh3M1yH8QpOOYA2z3YmGj3U2ShYAAQSnoiqLwW2fE+pEqQfmRDPI
2rJdP8aTuXzxdMVFpklP7iTPjOd2aNSZc3gQ9U9xNF9tDd74DDYVJqCt3D3C0bhP
Mk8hioQpf3HtY53fnBcF8g3zGgYrd2ZEQuAp5McB/mbhpmj+kiJs/iUZVVoYfu4H
GWAERzA11dmouEHyWWjtmVGPujs/Jxt6eSJiNvn4WvuS6ezYP55NQ0Z7U+17/QqI
1Xo+q01r+6JON6Rx730qOjuWJqqx8Oo1db+BBN/Tp/g1xlC0YmobTwchCC0RSgho
YOaTy2yuc++OIrpXDJT80MHodI4MBVDJHKqqsOpeH1szjvdGpqc=
=iL3y
-----END PGP SIGNATURE-----

--7mpR+8HugVK1gP7Y--

--===============0671210389416832140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0671210389416832140==--
