Return-Path: <SRS0=A+5j=IY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FC0C433DB
	for <iommu@archiver.kernel.org>; Fri, 26 Mar 2021 16:34:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8548A61A26
	for <iommu@archiver.kernel.org>; Fri, 26 Mar 2021 16:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8548A61A26
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F9FB40E56;
	Fri, 26 Mar 2021 16:34:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3265nLM3pAtg; Fri, 26 Mar 2021 16:34:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id BEA634062C;
	Fri, 26 Mar 2021 16:34:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 822EBC000D;
	Fri, 26 Mar 2021 16:34:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6CFC6C000A
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 16:34:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4E888849FB
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 16:34:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZtzBJ0BUDH6H for <iommu@lists.linux-foundation.org>;
 Fri, 26 Mar 2021 16:34:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 85174848FF
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 16:34:53 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id e14so9280887ejz.11
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 09:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=DYwWzdJEBzx1SFbP6o+W3lvVZLD7xCnLCW3uZibaJIw=;
 b=ra7O7EGO7kua1/vRqLHsWA6AGslJLSFS6SGj+n9mpVKXqmm43fj3AcoyVJppazdtsT
 ZoGVTky868NXpMq7EcIU6oN3cULfQIRRGtldsmAfGaMEAKlYhMF3ZGDbqlpqwoMG38cw
 +OnrADk57TPJt+sNG00lzdPy8fpPQas+VBOggXWtYQtIQHxLSPeNFgMabbwdYdKHf5rt
 pfmlj0d5SJKB0XdfT/fvDvwGAJrNX8k9LmWoaX2OrSq/hx8fzI0lK4nJQUDcRdzxWQV2
 BpX75futHas6xZzXB9cPRxG3Fn8YKx/1127ippw9IxEjxPP587RBotmm4SNKKWcsPabY
 59aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=DYwWzdJEBzx1SFbP6o+W3lvVZLD7xCnLCW3uZibaJIw=;
 b=Hryd66TMoWBf4w2yEq0ibbsdrrBuQac5RfKBTELr1zRm3Eb/D8FSEbGw0moWjy7Ox1
 TS9yQsx94UxhiXV+OfO43U59dfLb/+JA8Vk9KPbX5br27aBFyQ4ohHw2BRfP2S3b+ioy
 w9s03PLz2MD6fj3vDo5buwIK0N4K6wH+tnm/voK7JihhA6Osu01+27DB1RLPr4qEQmDG
 OcWSwMrZYM/XV3qfrnUbPt9IWuGXxmoAPb1BX6/b8CVtNWrlpg9GnVFdIaLZjD3FZeL6
 fiQnh+Rj2Fw/9/Aif+BqugKolbX4hHFWV4Kzs68Nl61oGL6pzFVNV9b1O0EiqfkW0B8v
 vodg==
X-Gm-Message-State: AOAM532fZq7IID7pLFE74RMOrX+3sLWjGdn1/lPHFlJMJdz6lrIgtgj+
 d+DGk5mBQg+fKvRf9Gl+dHw=
X-Google-Smtp-Source: ABdhPJyYe5iQKyUcqU6wM3M1dHZGmNlszMW7R3NcLT8ST52XN6zIOdZSXz/rtW7ufzGmLTUxnHmP+Q==
X-Received: by 2002:a17:906:7257:: with SMTP id
 n23mr3008392ejk.412.1616776491669; 
 Fri, 26 Mar 2021 09:34:51 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id sb4sm4093833ejb.71.2021.03.26.09.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Mar 2021 09:34:49 -0700 (PDT)
Date: Fri, 26 Mar 2021 17:35:12 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH 0/9] arm64: tegra: Prevent early SMMU faults
Message-ID: <YF4NQPee+/Qi6zVd@orome.fritz.box>
References: <20210325130332.778208-1-thierry.reding@gmail.com>
 <197876d1-0046-f673-5d3e-818d1002542b@gmail.com>
MIME-Version: 1.0
In-Reply-To: <197876d1-0046-f673-5d3e-818d1002542b@gmail.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Will Deacon <will@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
 iommu@lists.linux-foundation.org, Nicolin Chen <nicolinc@nvidia.com>,
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
Content-Type: multipart/mixed; boundary="===============8827677929120950167=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============8827677929120950167==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="E3RehJV1Q5CrEkmM"
Content-Disposition: inline


--E3RehJV1Q5CrEkmM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 26, 2021 at 06:29:28PM +0300, Dmitry Osipenko wrote:
> 25.03.2021 16:03, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Hi,
> >=20
> > this is a set of patches that is the result of earlier discussions
> > regarding early identity mappings that are needed to avoid SMMU faults
> > during early boot.
> >=20
> > The goal here is to avoid early identity mappings altogether and instead
> > postpone the need for the identity mappings to when devices are attached
> > to the SMMU. This works by making the SMMU driver coordinate with the
> > memory controller driver on when to start enforcing SMMU translations.
> > This makes Tegra behave in a more standard way and pushes the code to
> > deal with the Tegra-specific programming into the NVIDIA SMMU
> > implementation.
>=20
> It is an interesting idea which inspired me to try to apply a somewhat si=
milar thing to Tegra SMMU driver by holding the SMMU ASID enable-bit until =
display driver allows to toggle it. This means that we will need an extra s=
mall tegra-specific SMMU API function, but it should be okay.
>=20
> I typed a patch and seems it's working good, I'll prepare a proper patch =
if you like it.

That would actually be working around the problem that this patch was
supposed to prepare for. The reason for this current patch series is to
make sure SMMU translation isn't enabled until a device has actually
been attached to the SMMU. Once it has been attached, the assumption is
that any identity mappings will have been created.

One Tegra SMMU that shouldn't be a problem because translations aren't
enabled until device attach time. So in other words this patch set is to
get Tegra186 and later to parity with earlier chips from this point of
view.

I think the problem that you're trying to work around is better solved
by establishing these identity mappings. I do have patches to implement
this for Tegra210 and earlier, though they may require additional work
if you have bootloaders that don't use standard DT bindings for passing
information about the framebuffer to the kernel.

Thierry

--E3RehJV1Q5CrEkmM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBeDUAACgkQ3SOs138+
s6FTLhAAsms9EhZS86Rj5VNrBEWU74zsV3diOV1Hmg6TmT6zHATv0FZVRT15AZFk
fzSOBlfxyKFYvXBmMfJtgF0SkEuVGWeCL9NAnwEMPRcDM0gQ9ULvswFqzGe68oRL
8AMMfi3/2p+E6h+SLOxF1v5Is2lYE8Uc3c0AzWUr6d6WYeZL2FUQKd83pF5CMp4A
iTHAVSzBdSAmrnyDOHAQVX/UZ/01LpJEwFvYXXJLWAHZNhjWTbF4VDSL6S9OzLkd
oWeNf8CXgmwwtg6JTDVdYYz9/YAQQBYrFWVqkcXbJKn1AzcqCh2N2eWqgdBkMNWj
8qmpxrNSqBnnrpVAX9tVnSZFOCW3QhMC86DGch0PS7x4Uj1uhByknghn7LIH2/9H
nCrUBK6OccS/4RTNHKIyPMrcrGpB0CbgjJ6M8suEKmtDS4JNxn8JWu7b5FvkRENe
AYTxhOxRW1//Lmo2pKpjo8pIh+odd48h2jTjRqvhqtIxIUkAkRsFWvceWmmxZ6bH
OELd0Xnk1w21GrKNWlMInSkyGZNFQbXPYDcnybOrpf9olj/QFNtxS+OAgOAIstt9
SSMDamnz+l7sIV5mKo2LNkuUHxiosiU9KaDGGjT/MgIJEAFCRHlPFq2SeqAI8HUO
53EDGC2Cf4chVLtUiA0vxQkry3Vyj5ELz7dP+XLkjwhXKUOlGZc=
=+uZ+
-----END PGP SIGNATURE-----

--E3RehJV1Q5CrEkmM--

--===============8827677929120950167==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============8827677929120950167==--
