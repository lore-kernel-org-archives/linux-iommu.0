Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7130FC4727C
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 16:15:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED32B20789
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 16:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vEs2gDaV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED32B20789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 925868721B;
	Wed, 30 Sep 2020 16:15:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V-nafS8GZ-6I; Wed, 30 Sep 2020 16:15:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1B0F08721C;
	Wed, 30 Sep 2020 16:15:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1E83C0889;
	Wed, 30 Sep 2020 16:15:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB9E1C0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 16:15:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CB40C204E4
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 16:15:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QBcAcBaovQ00 for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 16:15:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by silver.osuosl.org (Postfix) with ESMTPS id 9726D204D8
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 16:15:07 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id p9so3647779ejf.6
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 09:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=kE8pUQeSQicwQZVIKpx0wVouaS5mSuVoVumXEb40dpU=;
 b=vEs2gDaVZYsmIz2uXHTT7F2ngJyj01YBJq55PGeSXgHDmGf/n4UsDeXaDm46ygSWl+
 efw+9lrPs9eWvVHSNSjyZ7+KtwpVID96yPPy22qiPjtn/2ACxIo71CkXzJJRBTlmUYgw
 9CfR7CbsUp5mxsRO3P2DCZAoMUE5FhgulKrYIhghlfpFIDnbLClNbrTClv0RIYlF+074
 s8bk2o2ttzVL1idJ8S2+KbWwCgIOI95Gc/j9/yJHMHPTIgmm7Itlvgzwso/5V8W42TxM
 Sbm2Tm2Sv67JwEY7KgLv25inXUuN+0wIeVhUg7esxLG4Pavb4sbI7oyAvM8uRqZKoTPu
 YcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=kE8pUQeSQicwQZVIKpx0wVouaS5mSuVoVumXEb40dpU=;
 b=K5vUizeHz0Tc0lWV20gXb3NUNtJAMnuV0rRbyusX+B2hZB3dPk/96z9Fx/gY0f/tcL
 Q7txpnlR9YoHvhvTQFwxe4xSxFz7VpXaIJsrjz9hLQauIOhKed4IO2eoUZvzma48qbnV
 cguIuXaDi371VlWBe4fZNiXUwXXExTo+HCSQAE/3y3XEHZFFnm742kROLL3FMGG1qUY6
 vE9ZxYj12kSWMiD+vIJAh6ZdXU3Xlz9lEUhv0g9iqdJL47ZOs1ZgzmTalKnrLEjoRiDK
 Kt0tOiLnFsIh2T9pZX8i9oGUN+meRfsybHiophyk1JduunJyFbBP0pwwEnE5t263dUtD
 9Q8Q==
X-Gm-Message-State: AOAM533aNUCmESwZs0zqvmG+29/Et8DUJjJFx6jhlB0Rmom/AQ7vujF/
 x9p0a2uxiTrZu4D4jq2ErZ8=
X-Google-Smtp-Source: ABdhPJw6+D6kvpNUGSeOdQb4MLX0XxcMPxQ+Z1guG4ri+sfmREV9+TL9tPln+WLbWcuDblAdz9OWFQ==
X-Received: by 2002:a17:906:f110:: with SMTP id
 gv16mr3078005ejb.257.1601482506094; 
 Wed, 30 Sep 2020 09:15:06 -0700 (PDT)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id dv25sm1977144ejb.69.2020.09.30.09.15.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 09:15:04 -0700 (PDT)
Date: Wed, 30 Sep 2020 18:15:03 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v3 1/3] memory: tegra: Add
 devm_tegra_get_memory_controller()
Message-ID: <20200930161503.GF3833404@ulmo>
References: <20200930084258.25493-1-nicoleotsuka@gmail.com>
 <20200930084258.25493-2-nicoleotsuka@gmail.com>
 <20200930152320.GA3833404@ulmo>
 <ed7b4375-d06e-2750-e6fa-603ef2b60d36@gmail.com>
 <20200930160355.GC3833404@ulmo>
 <839df5d6-513f-3d77-ba5f-a1afe5d0883a@gmail.com>
MIME-Version: 1.0
In-Reply-To: <839df5d6-513f-3d77-ba5f-a1afe5d0883a@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============2659938164668624617=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============2659938164668624617==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eDB11BtaWSyaBkpc"
Content-Disposition: inline


--eDB11BtaWSyaBkpc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2020 at 07:06:27PM +0300, Dmitry Osipenko wrote:
> 30.09.2020 19:03, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Wed, Sep 30, 2020 at 06:53:06PM +0300, Dmitry Osipenko wrote:
> >> 30.09.2020 18:23, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>> On Wed, Sep 30, 2020 at 01:42:56AM -0700, Nicolin Chen wrote:
> >>>> From: Dmitry Osipenko <digetx@gmail.com>
> >>>>
> >>>> Multiple Tegra drivers need to retrieve Memory Controller and hence =
there
> >>>> is quite some duplication of the retrieval code among the drivers. L=
et's
> >>>> add a new common helper for the retrieval of the MC.
> >>>>
> >>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >>>> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> >>>> ---
> >>>>
> >>>> Changelog
> >>>> v2->v3:
> >>>>  * Replaced with Dimtry's devm_tegra_get_memory_controller()
> >>>> v1->v2:
> >>>>  * N/A
> >>>>
> >>>>  drivers/memory/tegra/mc.c | 39 ++++++++++++++++++++++++++++++++++++=
+++
> >>>>  include/soc/tegra/mc.h    | 17 +++++++++++++++++
> >>>>  2 files changed, 56 insertions(+)
> >>>
> >>> Let's not add this helper, please. If a device needs a reference to t=
he
> >>> memory controller, it should have a phandle to the memory controller =
in
> >>> device tree so that it can be looked up explicitly.
> >>>
> >>> Adding this helper is officially sanctioning that it's okay not to ha=
ve
> >>> that reference and that's a bad idea.
> >>
> >> And please explain why it's a bad idea, I don't see anything bad here =
at
> >> all.
> >=20
> > Well, you said yourself in a recent comment that we should avoid global
> > variables. devm_tegra_get_memory_controller() is nothing but a glorified
> > global variable.
>=20
> This is not a variable, but a common helper function which will remove
> the duplicated code and will help to avoid common mistakes like a missed
> put_device().

Yeah, you're right: this is actually much worse than a global variable.
It's a helper function that needs 50+ lines in order to effectively
access a global variable.

You could write this much simpler by doing something like this:

	static struct tegra_mc *global_mc;

	int tegra_mc_probe(...)
	{
		...

		global_mc =3D mc;

		...
	}

	struct tegra_mc *tegra_get_memory_controller(void)
	{
		return global_mc;
	}

The result is *exactly* the same, except that this is actually more
honest. Nicolin's patch *pretends* that it isn't using a global variable
by wrapping a lot of complicated code around it.

But that doesn't change the fact that this accesses a singleton object
without actually being able to tie it to the device in the first place.

Thierry

--eDB11BtaWSyaBkpc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl90rwcACgkQ3SOs138+
s6EaixAAqbOV/ijTS5FkR08q2KCQomBCj0Q4t0RdougoBkbNGOffkJbO06l69JQP
S1o6d+r6P1rpZj/2K6/7VyzCqLCa5zpA19R7/GDyBJ+DO0TSQ93WxBIf4XgVoprP
igWzDkJiEFISjKNl3MP2KjxkYFDMC/ZQy4GF3bJvRpjFq4tVCYggaAAU7aeMutxa
DnChwV37zJvFT/6bIFu4gI+VJaBjfxzn36ahS4iGUQkOgF8z7dKcXK9tUwheomYb
sdayQ1WlKlrQQ8SnrodoFDNooEhBPZeLC3O4iNonxnetZbgmoZ8xt0M0OaMnFi/M
/xSqK1eJSn7RVL0+x1hajlsuJdYYhrnKPzUzLZIdBWFcJCIXrMIZ08dpwnkTbzjv
45JoaaQlyOg4HQgSuWi/p0p709nzuY9lJID+/2R4HwkKDgVC/NdCtHJHgoZBHqyF
khK3kGeXhfQfsNjPfjbbZoADbymdTAt7W5VebFpIjtXooXmeyTX1uBVGRgrpnBD/
WIi1Z8GO3slDFlGk7RukIUqgvzwy/YJopV/E7oLsg/4V6SloATkgVCPNUrGiBmVu
5x3n9/ES2Uye/ALQa1TPJ4Jg155hqPrnxA6EYicSiVfHOjfMsECZGXinGiAIo6rX
4JKNpEcoJan0+1BcPKjTfXVMzU6pZcjbqgBbTi4qViDSxtYKkGQ=
=u6UA
-----END PGP SIGNATURE-----

--eDB11BtaWSyaBkpc--

--===============2659938164668624617==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2659938164668624617==--
