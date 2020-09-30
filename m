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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED37CC4727C
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 16:04:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69646207C3
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 16:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PA0vKez2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69646207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E616885381;
	Wed, 30 Sep 2020 16:04:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CbCRL-6rylK1; Wed, 30 Sep 2020 16:04:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3EB6A84ED7;
	Wed, 30 Sep 2020 16:04:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1246FC0889;
	Wed, 30 Sep 2020 16:04:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4362C0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 16:04:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CBB1785040
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 16:04:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0TRDHQH4CNuC for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 16:04:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com
 [209.85.218.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D3F3184ED7
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 16:03:59 +0000 (UTC)
Received: by mail-ej1-f65.google.com with SMTP id o8so3591523ejb.10
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 09:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=HkhKHMINiSKqraOzIt5AxpBzpOhikgq//AotPkRaIHM=;
 b=PA0vKez2xLCTX95LNGOxIfgXhECvVxQWPz9lTjS8LRwfyNeNFGu2aC9k+fWUANP5i+
 CyfIiWv03oxjhmcTPAvXyWnDS1ElIY5rdfxye5KC89MQ2zgRxyuXu2nlJwv7J9YjH5KO
 TVSjIndlsxvUCj0CIhqDSsK/ymQ0sy4WZE7/cqs9VS42PGAOSeWCv0GzGC+ZxOYdwhFr
 /NpIG/X/n3SxrRiz6H4rVNLiBgv51Kzg19FK4QMlz0KWA7I0pbBrGUUw80Kzo/VV6bSq
 TPtGtqRRdSY5Hfeuo1f+8eqd3CT95PUoXBvKNv/z+qsFzgIocPu8CTQvcnhKUkz0Jy+E
 YDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=HkhKHMINiSKqraOzIt5AxpBzpOhikgq//AotPkRaIHM=;
 b=ePVLbdYT2ZH8vuVKl20Cd8XLpXTPLFp04e6hvPUIj3TMyXLvPVKeuZvW2pOUIjiaKZ
 VBJOK0lQzZOTLh5JslgHL70zsG9pvcceOSTdSetROEgh4yQDueZyPBf1NG7RYGkkaB3B
 R/f8xp9kITgtbYqHIL0U7z5YpTj5O49MCs4l8OycRMw/sycGBMAODu/3r1VwGH0n/gY2
 VUpUlLvCbRAlUnrBmBwUlab+tdVW1Pq2F1BRIfGPWNv0gu/+2IAVIBIihbcV//HLJAZP
 N2FotCC8EIBrMNd0tvSs5y0SZEH5jBHaW7eg3jbfz0ce94wwTogGoK2U6k4D23ZsneqF
 eY0g==
X-Gm-Message-State: AOAM5314EI6+HhwpgoGMTp9MhGARgmtV+2N1Hyh/Nnss00Oj9cMzQnXb
 OKp00piIDk/HQyeC+Jc5ea8=
X-Google-Smtp-Source: ABdhPJztk+9riNAmQmBHmoVtNpIQJe2sCTHfApl0Io1rReAg/lC07AvYf4F+aedZqiTec8nxyuiHAQ==
X-Received: by 2002:a17:906:c10c:: with SMTP id
 do12mr3442838ejc.527.1601481838354; 
 Wed, 30 Sep 2020 09:03:58 -0700 (PDT)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id va25sm1535615ejb.72.2020.09.30.09.03.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 09:03:56 -0700 (PDT)
Date: Wed, 30 Sep 2020 18:03:55 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v3 1/3] memory: tegra: Add
 devm_tegra_get_memory_controller()
Message-ID: <20200930160355.GC3833404@ulmo>
References: <20200930084258.25493-1-nicoleotsuka@gmail.com>
 <20200930084258.25493-2-nicoleotsuka@gmail.com>
 <20200930152320.GA3833404@ulmo>
 <ed7b4375-d06e-2750-e6fa-603ef2b60d36@gmail.com>
MIME-Version: 1.0
In-Reply-To: <ed7b4375-d06e-2750-e6fa-603ef2b60d36@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============5606102794744187095=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============5606102794744187095==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Md/poaVZ8hnGTzuv"
Content-Disposition: inline


--Md/poaVZ8hnGTzuv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2020 at 06:53:06PM +0300, Dmitry Osipenko wrote:
> 30.09.2020 18:23, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Wed, Sep 30, 2020 at 01:42:56AM -0700, Nicolin Chen wrote:
> >> From: Dmitry Osipenko <digetx@gmail.com>
> >>
> >> Multiple Tegra drivers need to retrieve Memory Controller and hence th=
ere
> >> is quite some duplication of the retrieval code among the drivers. Let=
's
> >> add a new common helper for the retrieval of the MC.
> >>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> >> ---
> >>
> >> Changelog
> >> v2->v3:
> >>  * Replaced with Dimtry's devm_tegra_get_memory_controller()
> >> v1->v2:
> >>  * N/A
> >>
> >>  drivers/memory/tegra/mc.c | 39 +++++++++++++++++++++++++++++++++++++++
> >>  include/soc/tegra/mc.h    | 17 +++++++++++++++++
> >>  2 files changed, 56 insertions(+)
> >=20
> > Let's not add this helper, please. If a device needs a reference to the
> > memory controller, it should have a phandle to the memory controller in
> > device tree so that it can be looked up explicitly.
> >=20
> > Adding this helper is officially sanctioning that it's okay not to have
> > that reference and that's a bad idea.
>=20
> And please explain why it's a bad idea, I don't see anything bad here at
> all.

Well, you said yourself in a recent comment that we should avoid global
variables. devm_tegra_get_memory_controller() is nothing but a glorified
global variable.

Thierry

--Md/poaVZ8hnGTzuv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl90rGgACgkQ3SOs138+
s6GNCA//RmVL3YPvq5/wzuzC1PrFzor/z7ya4L8jXrY6RgwgFYvK0hZnd6ahOBf9
DZIzr/0k5igUwAL7vrDTk3tJKvQDLf1Eqwg7QtEuEC4KXJcZbjynCcZsUepoaQFz
S2EQK7GfB21xSjCwhbIzOPgiqY2XajMbsjlDheK5qey7L2HASK1YxdIRyxPoHOHB
ixLUH1IAi+LQjnv8j8HZqiEaod0X2r28NvUdFPH1Ch2UbCqR8peyfScJIfM4ZoKo
u4s0G2Yi8znwKlU8YQ5aNjHc0LBlgH3kDvhB6p2ShK5o9w8oq7XiY5NMIHWrH7yI
HNGOhsppRt/qQXh1aoqOyKv1VVqFwqTfq/meCETwIuOpeV0OQPcDFHS6alg+unvS
E3jQPojcULvadHcWqStW5GnkomQC47VCB+1h71vfUQIPZkdd1XfaxohfsXMleSrN
6hKlnsTl6Y1cDDx6BMfHpgGGEOfv3GGUX9gq5eD9FoSzRTs497eazwClGHxSiHTp
fixSVclWwdwLDt0RtpMw9KE2T69sUrhwhxihjXzZ6RawvJNfRLE1GvHgJJnaZo+Y
0p+o5WVy+Rzsyg5CvFkYE8XMr/dwtyociFCSZmSYj9L+QywvKot5eFB0MCZJinwd
aKoG26J4OB3vJbtiYZDiNOlnjxRRG45ha6wivOJML11+viSNyII=
=Bu7G
-----END PGP SIGNATURE-----

--Md/poaVZ8hnGTzuv--

--===============5606102794744187095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5606102794744187095==--
