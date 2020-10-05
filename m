Return-Path: <SRS0=BXsX=DM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50701C4727D
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 10:27:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCED22078D
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 10:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWJeKhIX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCED22078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id F321486447;
	Mon,  5 Oct 2020 10:27:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z1nFsQBxpqGg; Mon,  5 Oct 2020 10:27:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id F310D8647A;
	Mon,  5 Oct 2020 10:27:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ADCF9C016F;
	Mon,  5 Oct 2020 10:27:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5251EC0051
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 10:27:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3AA1D85631
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 10:27:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yGzQznQlgWZI for <iommu@lists.linux-foundation.org>;
 Mon,  5 Oct 2020 10:27:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
 [209.85.208.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BAB0885629
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 10:27:47 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id c8so8712343edv.5
 for <iommu@lists.linux-foundation.org>; Mon, 05 Oct 2020 03:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=5KmV2gDNIgSSSWj29BV9SBfsq532geSZKQtqfX0xzgc=;
 b=IWJeKhIX+kos+LH759fRya86SswM6Y+55TCgc7CYYuSqqZyD3eISdLQfWqNUPlv8iz
 I1QdXl1p4vOZQnJq8KjI6DsGKezE165a7f4Eu2gR8hRjPRjWhraWfT1pqT9OlEstHFNy
 vWqf7Za9uBG8qe/DpNkVqwC3DRctaDbRplu0RpJqJysqtVMzGv6U0v0n8nFgxbDbtQB8
 p8jYrYoI0ZjzzYvaxYKOyAO8wy6a/mvhc75Ds4YNfecQbftYbLqm3CHz7Sv+nRH1MWVc
 6S4cFcXLNByeanNs/0vb01p0Y9cvAwi8y42LmQtX40mEsPs2RvH8IBc2fpjs/1PDEUNA
 yVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=5KmV2gDNIgSSSWj29BV9SBfsq532geSZKQtqfX0xzgc=;
 b=N1EXiI3sWCBj7GneX5GRMV79mwO9Px0wNCC/NGK5w8Oz5A9yaLg5dHZQH5ShHC4hGn
 GtpufobFxaOVFtMuV5rbg4aeLTYWBuWHKwrp9//86OdMh/pNeF2u/sMU+LwHe75EwbBM
 6lCEDSNt7A7aRu+U/eP1rh8hkeOWlsK84hEQxUZFZuZcm+emTJjhQpq/VSro4dH5wuJa
 gP8+D5U5K0GEoiaRa1yvWFA7QQrWGOMGhg+FNWgXsS9Jy8T+5XvjTzYkExr7UJLBW10T
 Q7XlKAAFcn2+fexEnGaVnU9rxw+8y8C9sshzF+CQ+KAGEPYvasLQRSWG8fyJ7iFRFcof
 WdeA==
X-Gm-Message-State: AOAM5339LnO7Dp9l4fJqIDdzryzixwpubDQRCtbtU9ov8Yhoq7RdK4Kt
 1XZrpTjJr2tieKw60iqaUCA=
X-Google-Smtp-Source: ABdhPJzC/yBKkW5Vj60He0Lq8p3op1rsl2V7E8B0k/gS5cJ9Eb0A6RXbkq5xQZU07OZozb+SFXY5Mw==
X-Received: by 2002:a05:6402:1c1b:: with SMTP id
 ck27mr10813669edb.218.1601893666133; 
 Mon, 05 Oct 2020 03:27:46 -0700 (PDT)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id m2sm7806717ejo.4.2020.10.05.03.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 03:27:44 -0700 (PDT)
Date: Mon, 5 Oct 2020 12:27:43 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v3 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
Message-ID: <20201005102743.GM425362@ulmo>
References: <20200930153131.GB3833404@ulmo>
 <ece615ad-8d6b-96ae-d8b4-9667aef17281@gmail.com>
 <20200930160626.GD3833404@ulmo>
 <f11d7d8a-8ce6-a53c-6219-ceec05432002@gmail.com>
 <20200930164707.GB3852280@ulmo>
 <35115ac1-fb25-7226-7b50-61193669e696@gmail.com>
 <20201001075811.GA3919720@ulmo>
 <4dbf5bcb-76af-53c5-31cf-880debbcebf3@gmail.com>
 <20201005091610.GC425362@ulmo>
 <1adede6e-ecbd-eea4-bd40-4969cd8719cc@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1adede6e-ecbd-eea4-bd40-4969cd8719cc@gmail.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 krzk@kernel.org, jonathanh@nvidia.com, linux-tegra@vger.kernel.org
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
Content-Type: multipart/mixed; boundary="===============1642782811087716276=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============1642782811087716276==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qySB1iFW++5nzUxH"
Content-Disposition: inline


--qySB1iFW++5nzUxH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 05, 2020 at 12:38:20PM +0300, Dmitry Osipenko wrote:
> 05.10.2020 12:16, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> ...
> >> I think you meant regmap in regards to protecting IO accesses, but this
> >> is not what regmap is about if IO accesses are atomic by nature.
> >=20
> > Then why is there regmap-mmio?
>=20
> To protect programming sequences for example, actually that's the only
> real use-case I saw in kernel drivers once. In our case there are no
> sequences that require protection, at least I'm not aware about that.

True. But I'd still prefer to have a more formal mechanism of handing
out access to registers.

Either way, this isn't very relevant in the case of tegra20-devfreq
because there's really no reason for it to be a separate driver with
device tree lookup since it's all internal to the MC driver. The only
reason (unless I'm missing something) for that is to have the code
located in drivers/devfreq. We can do that without requiring DT lookup
either like we did for tegra-smmu/tegra-mc, or by directly copying the
code into drivers/memory.

It's become fairly common in recent years to group code by IP rather
than functionality. We nowadays have good tools to help with subsystem
wide refactoring that make it much less necessary for subsystem code to
be concentrated in a single directory.

> >> Secondly, you're missing that tegra30-devfreq driver will also need to
> >> perform the MC lookup [3] and then driver will no longer work for the
> >> older DTs if phandle becomes mandatory because these DTs do not have t=
he
> >> MC phandle in the ACTMON node.
> >>
> >> [3]
> >> https://github.com/grate-driver/linux/commit/441d19281f9b3428a4db1ecb3=
a02e1ec02a8ad7f
> >>
> >> So we will need the fall back for T30/124 as well.
> >=20
> > No, we don't need the fallback because this is new functionality which
> > can and should be gated on the existence of the new phandle. If there's
> > no phandle then we have no choice but to use the old code to ensure old
> > behaviour.
>=20
> You just repeated what I was trying to say:)
>=20
> Perhaps I spent a bit too much time touching that code to the point that
> lost feeling that there is a need to clarify everything in details.

I assumed that by "fall back" you meant the lookup-by-compatible. But
what I was talking about is the fall back to the current code which does
not use the MC device tree node at all. The latter is going to be
required to ensure that the code continues to work as-is. But the former
is not required because we have fall back code that already works with
old device trees. New code that is using the memory controller's timings
nodes can be gated on the existence of the phandle in DT and doing so is
not going to break backwards-compatibility.

But perhaps I was misunderstanding what you were trying to say.

Thierry

--qySB1iFW++5nzUxH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl969RwACgkQ3SOs138+
s6G1uw/+POISSA1dSYwJw8XxtVmoFQobW0FgPp8MEtDSZyOea5EwjMXveabSeRTz
nNTOnZ5uvaC6YRvDRaX/8m1vttDVyJvJsh+z+WJVA4HiJjArkZn9xTL7blDLikru
bwhR78xyrBOEDRGFHsYWOWFLSNwhgbWlf10Q6hX3+Y5tZinZ/1j+bGW38AcDpweL
1lCuth97mrmlZX/adEoGXUCzz1P1YdGh35adRXd0GojfZ9wIuVYvPzZkGSC1FuXk
mnXl/h26SIf8mr6wFberNXlqazexCnnfih6hLLPj7F02hupbgJ6So4K8usEaQHZq
UJNz/B6vmapODjYA1runxE50eBKPNV6+33D4h7UaSb0xrwBPWH451Vh4Om6DKJMu
l9I8yLvwR3K0MdhI8kc+PU2/qp3a6HOgI4FtfYuAbWJbbVxb9MbdplWsWhlwqgg+
JIhZ6l8J9nXpM8ExkTOhKgc6LvJDzncdMnNG/QJGUbDP0wSPisIenwR6Cr5UCYOV
yy9R19+JxgPRoDLz/zF5hELJpqbuWogHCWrUSpvYk4cLZabYAtbUSygudC28CnI/
q6zKlWwxbSlPqHVijHrQVJSfVj+qRLPLHYUcGj4V5f544yIwUyRCB2e2XkzwbWTa
BMWVa4uPsvkkgqg6pic/9NA0DELSS25reEYeNcBkc1u07EIb+rg=
=i1Fp
-----END PGP SIGNATURE-----

--qySB1iFW++5nzUxH--

--===============1642782811087716276==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1642782811087716276==--
