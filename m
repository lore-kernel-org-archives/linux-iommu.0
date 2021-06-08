Return-Path: <SRS0=69++=LC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AA6C47082
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 14:37:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B925361042
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 14:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B925361042
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 71B7C4046A;
	Tue,  8 Jun 2021 14:37:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yHQh5G7H0kSO; Tue,  8 Jun 2021 14:37:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 092954037B;
	Tue,  8 Jun 2021 14:37:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D39DAC000D;
	Tue,  8 Jun 2021 14:37:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5693C0001
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 14:37:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C9E816067F
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 14:37:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v1452H87KCNf for <iommu@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 14:37:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CBABC6005E
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 14:37:09 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id y7so17210543wrh.7
 for <iommu@lists.linux-foundation.org>; Tue, 08 Jun 2021 07:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=7Ue9KAC7qJaW16JeKkEn8iGR0sqX5WDTSVD1v13dL3I=;
 b=Ukj+KDqPTO+UJF/BEvU3KpfMksSB2pQeL/ie4KKl0GFxijjAY4WcmnEWRNTrNrLOaR
 2DHrxG3hpElAs9tZkRP0/ODEDEiC6gBkFv1fpWSr0VMyY7wW+JPwAEbQgknDjgG5FmEo
 C2wvMPYo0K8Hdm4wtWOlJdLDWExLKL+oPLeJuNCXcgWheReYp+hJQ3Gk/cpnchtoXzMC
 MSJWVzuoQc288K3blzLLEYrZvkWVx/tozHUzTKd1zNF1LEZVXU3AhdpyoECle1vQ9J4I
 DDzvd9CzYYUTtfAgl0L3+b5AR0owWjNGEWOzjTWwVPHec8hl8BwT/qF2uxq6svFYXSI9
 Z3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=7Ue9KAC7qJaW16JeKkEn8iGR0sqX5WDTSVD1v13dL3I=;
 b=ZpHIZQ2RTIwxuJDz/5hWT7VP/7YIbSQoomAaclZZVfZ5lRkgBrYK3HYV0u89LCUFqa
 jysRYHiF+p+61jG+vsxtt3oZ0DBholZNTfmW2OTQRxy1MZ80bhcyIm2FanJ+OG02BfYo
 G72ixlUxHfPr255sVLGI3IHYi7K9PjVFLzfGPpl7TxOHCswOqEXfbGOWKnq5tWFevlPK
 1D0HzdbgI5fifWQDmuf06Q/C5owYcm7OgZtRZzc0fTH8iP4LA9K/9z5G/aC6GNkNtQYc
 /AzZSkqBvibxVntH37BOe+xV6SFc9P/S8dA9Qh9xgIgJFmGpug0ZU+oUCt7+HYRtvRjT
 bP3Q==
X-Gm-Message-State: AOAM531Qv5FlFkgA1fZQXiQagERE7xMQE0Mos/cQejAiImJl526IASUw
 2khyXoI1SgP+s27uyadhmWE=
X-Google-Smtp-Source: ABdhPJyNHULCu3Cz5QZT9AskYvCL9LY9HsQM39c8QCo5M9iEBotkmmSMw3983N23quI52NayDR2YUA==
X-Received: by 2002:a5d:5987:: with SMTP id n7mr22858341wri.293.1623163027746; 
 Tue, 08 Jun 2021 07:37:07 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id p5sm21015798wrd.25.2021.06.08.07.37.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jun 2021 07:37:06 -0700 (PDT)
Date: Tue, 8 Jun 2021 16:38:48 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Will Deacon <will@kernel.org>
Subject: Re: [GIT PULL] memory: Tegra memory controller for v5.14
Message-ID: <YL+A+MPjjaa3nSwq@orome.fritz.box>
References: <20210607084910.21024-1-krzysztof.kozlowski@canonical.com>
 <20210608120128.GB10174@willie-the-truck>
MIME-Version: 1.0
In-Reply-To: <20210608120128.GB10174@willie-the-truck>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
List-Id: <soc.lore.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org, soc@kernel.org,
 arm@kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
 iommu@lists.linux-foundation.org, Dmitry Osipenko <digetx@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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
Content-Type: multipart/mixed; boundary="===============0823224380131988383=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============0823224380131988383==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f7Os7LJ667BkQ0FG"
Content-Disposition: inline


--f7Os7LJ667BkQ0FG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 08, 2021 at 01:01:29PM +0100, Will Deacon wrote:
> Hi Krzysztof, Thierry,
>=20
> On Mon, Jun 07, 2021 at 10:49:10AM +0200, Krzysztof Kozlowski wrote:
> > Hi Thierry and Will,
> >=20
> > This is the pull for you to base further SMMU aptches (prevent early SM=
MU
> > faults).
>=20
> This is a tonne of code for me to pull into the SMMU tree given that I on=
ly
> want one patch!
>=20
> Thierry, if I just stick:
>=20
> https://lore.kernel.org/r/20210603164632.1000458-4-thierry.reding@gmail.c=
om
>=20
> on its own branch, can you stitch together whatever you need?

I'm not sure I understand what you're proposing. For reference, here's
the set of patches that I sent out:

  1. memory: tegra: Implement SID override programming
  2. dt-bindings: arm-smmu: Add Tegra186 compatible string
  3. iommu/arm-smmu: Implement ->probe_finalize()
  4. iommu/arm-smmu: tegra: Detect number of instances at runtime
  5. iommu/arm-smmu: tegra: Implement SID override programming
  6. iommu/arm-smmu: Use Tegra implementation on Tegra186
  7. arm64: tegra: Use correct compatible string for Tegra186 SMMU
  8. arm64: tegra: Hook up memory controller to SMMU on Tegra186
  9. arm64: tegra: Enable SMMU support on Tegra194

Krzysztof already picked up patch 1 and I was assuming that you'd pick
up 2-6 because they are to the ARM SMMU driver. However, if you're
primarily interested in just patch 3, which is more "core" ARM SMMU than
the rest, which are Tegra-specific, then I suppose what we could do is
for you to give an Acked-by on the rest (2, 4-6) and then Krzysztof or I
can pick them up and take them via ARM SoC, based on the stable branch
=66rom your tree that only has patch 3.

Patch 6 touches arm-smmu-impl.c, though it's a two-line change that
touches only the Tegra-specific matching bit in arm_smmu_impl_init(), so
the likelihood of that conflicting with anything else is fairly small.

Is that what you were proposing?

Thierry

--f7Os7LJ667BkQ0FG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmC/gPUACgkQ3SOs138+
s6Gn5Q//XR1WBSTbtSwOrKQWuPDV7tOFjf6dfJEWfhiXlkB+CMwEWcejemQGS1He
S9BFx8JjoV2ILf/+qWqgdtP8M8+mMLoIfhPqrfoV0bHI1leo15FN3+NbbveW6lHo
7T7ZN6GC7AYC5OyQcQ4tF3GecV4U/d8sNUk/LPgLsR8ZLZTFm3ffemOkSC+pYPn9
PtsN2+mpA+Nz8vIhKdA7pnFWb8ctXMndexyeY+Us669c1uKPvAqsK2Y87hl2EU81
HYYVh/5VDp7VGgSMZG2mMiMTFnAKD2pKGTa+W2SqM958xjy7H0I8Fo/nifKOxc89
mWdC56GwCPMjtJgXFtleInwK1gv0Vu6YuhH63XTcT5pjClgDaiYsiYdDU9kkzmeL
qq6QdC0BrzEzeOByhzL5loeRoRja1xQxjBDXcE2zHpSqaXU+pQfAKELDfu1uYCKV
3AUTN6HrUk+btr/7sSPHstUZqsTX6/VuMggMhnJQy25rFejJb0MWoe+C8U1MCtFh
Ab6Nrp6mbJvf2YgMKLrwn1WbmVXd4pUxI7pMwoPRnfjdWJc1C95d8/wIHCsgI+KH
aWasonEd33phX1sPzS0CucADcNfY4PaIkpbW+aM0w3qHdTmS05avnaU/5w2aRpZe
3C5wVdVJffpcBjokYeVnVDm33uORvTdnFZeE7WvcVEUynZl84A4=
=dmMX
-----END PGP SIGNATURE-----

--f7Os7LJ667BkQ0FG--

--===============0823224380131988383==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0823224380131988383==--
