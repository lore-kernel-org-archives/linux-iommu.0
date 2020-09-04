Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDE9C43461
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 12:20:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20C0F20791
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 12:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsyLT00T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C0F20791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 008E586B74;
	Fri,  4 Sep 2020 12:20:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A1I49v91ZnAl; Fri,  4 Sep 2020 12:20:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9BEFC86670;
	Fri,  4 Sep 2020 12:20:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79C68C07FF;
	Fri,  4 Sep 2020 12:20:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C322C0051
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 12:20:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 36AA8874E6
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 12:20:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RCxjeYv2eMQw for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 12:20:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com
 [209.85.218.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 41DD2874C1
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 12:20:47 +0000 (UTC)
Received: by mail-ej1-f66.google.com with SMTP id gr14so7199040ejb.1
 for <iommu@lists.linux-foundation.org>; Fri, 04 Sep 2020 05:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=7q5C8/jLUItkAZStR962PGtWTqQiplBbNCOmTg7hWgU=;
 b=WsyLT00TMZEoq+18wWgtxZ1dcOZ+WYbmhd12eCiwQIPbsIzoA9LAqSSVgHk2c6dLde
 0sPSQtlnM2rPjCHE02qSk2zcWwuGXekTynYfz0VD6H+7ahI/yZsjlQMJ/FlCIE0+QkU/
 DP/FnaaYvwDOlGgNUBRUFfxMhOa/YyGoIqJK75lmh7uuQo2fFB+OufWTbInVrO15xOr3
 GesFjYn1bPlCkl+amWCCKKKr3/aXeAvOsineO8kpUC3p9iX8C9bZb7odv33uGmc4XVRA
 LdtHrCQ3cMilURSGlYOdVtbAM+FItXdab+DNIHUqjoIf6yr7/m6KwLRvNHLQXU+6sFpB
 08kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=7q5C8/jLUItkAZStR962PGtWTqQiplBbNCOmTg7hWgU=;
 b=CL7mWHr1NrRUEpCCjd1BD1rwvD3ZG6EUNlcJp68juYVozi1nZ8GS3/1fjg9mJayZCe
 S40yA4sY78cE1k3BkIGwCxaZO9ClWNUBBu+uwtSh6g4EgTbl8ilG3e1NiJroKoQTHp4p
 wn/0041HxUgXCVQWcL24HWCDmZ/NC9XPdGEkIaC6HCgqHdFpmW4E4C4h1fS2XSSal+bv
 xB/Ykc4yybBoiS/b/g6SwmAWPNaJcpI5HXhieqHdOWbyCibgyA2IcWjWgDoIfHgXG91S
 mYGbIj7pt5CTsFiVyYKKczvQ+yPXVgccPBnpJEw9FQJpZvOgW6yz/mwa0UXJuUSJD4iq
 TV2A==
X-Gm-Message-State: AOAM5307Tm0x6gGb4SXfWJKEndcHM+PwEyRkxhV1yc4Vpygt+56BM6gB
 8mSndNoDdybb7LtXwC3Roois7nzUtv2KpA==
X-Google-Smtp-Source: ABdhPJzCVpPb1VtJYTDT+SzrKaKMRmuVzIH723SPCX/zt4OLYxw7srtxI5Tvd9U9KDpFbFR8P0rpcg==
X-Received: by 2002:a17:906:4e4a:: with SMTP id
 g10mr6837157ejw.274.1599222045587; 
 Fri, 04 Sep 2020 05:20:45 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id gh21sm5973012ejb.32.2020.09.04.05.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 05:20:44 -0700 (PDT)
Date: Fri, 4 Sep 2020 14:20:42 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH RESEND v3] iommu/tegra-smmu: Add missing locks around
 mapping operations
Message-ID: <20200904122042.GB570531@ulmo>
References: <20200814162252.31965-1-digetx@gmail.com>
 <20200904090519.GF6714@8bytes.org>
MIME-Version: 1.0
In-Reply-To: <20200904090519.GF6714@8bytes.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dmitry Osipenko <digetx@gmail.com>, iommu@lists.linux-foundation.org,
 Jonathan Hunter <jonathanh@nvidia.com>
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
Content-Type: multipart/mixed; boundary="===============5830252465733903690=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============5830252465733903690==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
Content-Disposition: inline


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 04, 2020 at 11:05:19AM +0200, Joerg Roedel wrote:
> On Fri, Aug 14, 2020 at 07:22:52PM +0300, Dmitry Osipenko wrote:
> > The mapping operations of the Tegra SMMU driver are subjected to a race
> > condition issues because SMMU Address Space isn't allocated and freed
> > atomically, while it should be. This patch makes the mapping operations
> > atomic, it fixes an accidentally released Host1x Address Space problem
> > which happens while running multiple graphics tests in parallel on
> > Tegra30, i.e. by having multiple threads racing with each other in the
> > Host1x's submission and completion code paths, performing IOVA mappings
> > and unmappings in parallel.
> >=20
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>=20
> Thierry, does this change look good to you?

As Dmitry said, there's a new patch for this which is better. I've
replied with an Acked-by and Tested-by to v5.

Thierry

--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9SMRoACgkQ3SOs138+
s6GhTg//UlLbZDthSu1hLjh23HngDKBjooAZZJ7K88xkccpzohDGR4lmRSk9RlNk
oBPS01vo9mJh3nZEP3lw8Td/ObOUV9f1cW8ghnvYsxWvPoIjyL9Xr48D0EulHXpY
89ESymAMx9H8EDVwo7b1KfYCZ7/ls6L94PmUYaLIS++2AFKNkUZS7pzk+ISN5sFZ
IdXGUqKc0jbQntzCzcBBGoa76SxNIdXknIiwaAZDfi50CNOisX/H8I7RVoLjfz0n
ssi5eQix/oaPUvsaLF9azDqmOl8+7llhP17Plytso+ZGnUvidawjFepRjpAt+E0n
Borw8eNrjnAYYv7nvfkBA3l62Q1ngghq8Qbr1Psi6ZG7TRahr9PNTTOjKI3vCjJK
DaR+OhIKBAoejiRAXCJy0X0dnEzLianKD0DoazeVYJajo5CmGGx+rbHzOKxqSMUg
qVIxd6h3Wp956BSHwWxIQAXETmCCkRk0joO7bvkrr2soIpigm9mz2/tDGErMs3rU
e76A84X5ysKuhM2+2rAaNaYKRlQw2ljGnVfLjZbLBqz7bZTkwWJ+GIUq92zF2wWD
r/qdWUpmX64sRPL/Z1R5jIqzBEwwdh25EhQHpvlrY6PEIbUtdg+/QpVdAEXmVyLt
ifBgIbg6NC2rdxsaSU4HUDV15YTf7Ux3NnLaXBXliytG8cOy/r0=
=BRoz
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--

--===============5830252465733903690==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5830252465733903690==--
