Return-Path: <SRS0=BXsX=DM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A19C4363A
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 07:24:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6071B20756
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 07:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VND59Zbe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6071B20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A428885466;
	Mon,  5 Oct 2020 07:24:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id muXPkX5nX0kL; Mon,  5 Oct 2020 07:24:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id ADF418531D;
	Mon,  5 Oct 2020 07:24:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96764C07FF;
	Mon,  5 Oct 2020 07:24:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55F58C0051
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 07:24:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2672C8531D
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 07:24:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nEk5O1GETYTX for <iommu@lists.linux-foundation.org>;
 Mon,  5 Oct 2020 07:24:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com
 [209.85.218.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A4396851C2
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 07:24:33 +0000 (UTC)
Received: by mail-ej1-f68.google.com with SMTP id lw21so6417914ejb.6
 for <iommu@lists.linux-foundation.org>; Mon, 05 Oct 2020 00:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=MOoMUNrkhGZILoIhNc/dlvzV5zVbmrqMoAnmuY4eMSA=;
 b=VND59Zbet/KRWzmur5rvDuze5kYvzLamPTqto7EYeIVjVjun97JRANNXnmN52xtJPS
 V6cno2OJpkk7CV/Kcmq5nCC7ceCHiVaWUNqeZR+0DZofRafS2yTI3Lazx9z7Tvlzq1Cx
 +RSpSL63uzHVlhCFVxDg8D11qeH/psJBVZ8FigMu2q6StL8FqWi9S844dq/lejD/LrF3
 7HeAZE7RBhT2Vz37yDItncQ2B5maD8KAmX9Hk1zHWaAPX1eJ9tBafuUSTAIOK76/ICSM
 pDGI4ll3t7YJDIU7SpQc4AbTvr9FigdbbZZkZET8A8VwiKJqz5QD36JeCtZhP7U9mYa7
 es+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=MOoMUNrkhGZILoIhNc/dlvzV5zVbmrqMoAnmuY4eMSA=;
 b=G+FNlYLqM2x9Mf/ATEuhEVKrEiWZFXZGsyRcF0fo9w/rtvQVCYKPE1G3JGIY15a0w4
 Nt8IOojJ6wzBkjA8YRHu1qd7EmrBQ6jbEhy3zGg/VEqU/UlcTRCHei3DUuJ3uLPJ4AkD
 IQZsaD9CJtuBjN5vMkGktFOd0/nVxMQboF8BL57HQlMcIX+Qg52ixsuN2/gd+ZZJKOw/
 7/5jkMYbpYnOapfPOUkT6IqtPnQi6ixkSYGtbVxlrT2rsm0P5fes8vJxiP1PwgHbndZS
 rkRnNw0ANmk4mwcXSUZd+yWHFLHLCoWu8RV35P7TNhKUbyHpv40zSf/mFYKmZTwtm+V9
 hcuw==
X-Gm-Message-State: AOAM530cMJU462ydTyY2jR9kmaX7UcPgcMVw39atetfGQJYJukZkJqZx
 YzHPINHtpcAb+xkFQZ19eas=
X-Google-Smtp-Source: ABdhPJyaprDj3vNIgEstQkI1/gr5T0mTsIn0lSpxJf7kACCbHJqVocFVarVQSfPQCXbaaBIZbAOcHA==
X-Received: by 2002:a17:906:f1cf:: with SMTP id
 gx15mr13922584ejb.241.1601882672006; 
 Mon, 05 Oct 2020 00:24:32 -0700 (PDT)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id 92sm8020654edm.30.2020.10.05.00.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 00:24:30 -0700 (PDT)
Date: Mon, 5 Oct 2020 09:24:29 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v3 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
Message-ID: <20201005072429.GB425362@ulmo>
References: <20200930213244.GA10573@Asurada-Nvidia>
 <5945a63e-79d8-e3ae-ab53-cee8c220ac7d@gmail.com>
 <20201001012630.GA28240@Asurada-Nvidia>
 <72b11925-5857-8ce5-d084-cab01ca1b396@gmail.com>
 <20201001024850.GA28456@Asurada-Nvidia>
 <20201001102316.GF3919720@ulmo> <20201001110425.GB1272@Asurada>
 <b966844e-4289-3ff0-9512-852f8419a664@gmail.com>
 <20201002010751.GA26971@Asurada-Nvidia>
 <1b621b9d-cdc3-c7aa-2fa2-d728ae2bbc5d@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1b621b9d-cdc3-c7aa-2fa2-d728ae2bbc5d@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============1976663026068352465=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============1976663026068352465==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
Content-Disposition: inline


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 02, 2020 at 04:55:34AM +0300, Dmitry Osipenko wrote:
> 02.10.2020 04:07, Nicolin Chen =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Thu, Oct 01, 2020 at 11:33:38PM +0300, Dmitry Osipenko wrote:
> >>>>> If we can't come to an agreement on globalizing mc pointer, would
> >>>>> it be possible to pass tegra_mc_driver through tegra_smmu_probe()
> >>>>> so we can continue to use driver_find_device_by_fwnode() as v1?
> >>>>>
> >>>>> v1: https://lkml.org/lkml/2020/9/26/68
> >>>>
> >>>> tegra_smmu_probe() already takes a struct tegra_mc *. Did you mean
> >>>> tegra_smmu_probe_device()? I don't think we can do that because it i=
sn't
> >>>
> >>> I was saying to have a global parent_driver pointer: similar to
> >>> my v1, yet rather than "extern" the tegra_mc_driver, we pass it
> >>> through egra_smmu_probe() and store it in a static global value
> >>> so as to call tegra_smmu_get_by_fwnode() in ->probe_device().
> >>>
> >>> Though I agree that creating a global device pointer (mc) might
> >>> be controversial, yet having a global parent_driver pointer may
> >>> not be against the rule, considering that it is common in iommu
> >>> drivers to call driver_find_device_by_fwnode in probe_device().
> >>
> >> You don't need the global pointer if you have SMMU OF node.
> >>
> >> You could also get driver pointer from mc->dev->driver.
> >>
> >> But I don't think you need to do this at all. The probe_device() could
> >> be invoked only for the tegra_smmu_ops and then seems you could use
> >> dev_iommu_priv_set() in tegra_smmu_of_xlate(), like sun50i-iommu driver
> >> does.
> >=20
> > Getting iommu device pointer using driver_find_device_by_fwnode()
> > is a common practice in ->probe_device() of other iommu drivers.
>=20
> Please give me a full list of the IOMMU drivers which use this method.

ARM SMMU and ARM SMMU v3 do this and so does virtio-iommu. Pretty much
all the other drivers for ARM platforms have their own variations of
tegra_smmu_find() using of_find_device_by_node() at some point.

What others do differently is that they call of_find_device_by_node()
=66rom ->of_xlate(), which is notably different from what we do in
tegra-smmu (where we call it from ->probe_device()). It's entirely
possible that we can do that as well, which is what we've been
discussing in a different sub-thread, but like I mentioned there I do
recall that being problematic, otherwise I wouldn't have left all the
comments in the code.

If we can determine that moving this to ->of_xlate() works fine in all
cases, then I think that's something that we should do for tegra-smmu to
become more consistent with other drivers.

> > But this requires a device_driver pointer that tegra-smmu doesn't
> > have. So passing tegra_mc_driver through tegra_smmu_probe() will
> > address it.
> >=20
>=20
> If you're borrowing code and ideas from other drivers, then at least
> please borrow them from a modern good-looking drivers. And I already
> pointed out that following cargo cult is not always a good idea.
>=20
> ARM-SMMU isn't a modern driver and it has legacy code. You shouldn't
> copy it blindly. The sun50i-iommu driver was added half year ago, you
> may use it as a reference.

That's nonsense. There's no such thing as "modern" drivers is Linux
because they are constantly improved. Yes, ARM SMMU may have legacy code
paths, but that's because it has been around for much longer than others
and therefore is much more mature.

I can't say much about sun50i-iommu because I'm not familiar with it,
but I have seen plenty of "modern" drivers that turn out to be much
worse than "old" drivers. New doesn't always mean better.

> Always consult the IOMMU core code. If you're too unsure about
> something, then maybe better to start a new thread and ask Joerg about
> the best modern practices that IOMMU drivers should use.

This doesn't really have anything to do with the IOMMU core code. This
has to do with platform and firmware code, so the IOMMU core is only
marginally involved.

Thierry

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl96yioACgkQ3SOs138+
s6GDnhAAhlKinPut4FcB4WuAdyApdRrVDRVNZ3iJ23ac44Pu91Fo0+HN9gZo6F+v
/riVDr5JjARTFFDLvwSbDTjnVRFTXSr1QDQBtJX6IOd/awV5zFgwu++UO80tYbUL
+qc9IqXpYBYBYgBhBwlQGsuicr2UoNWdJYYuEgwJ+7pUlSKfHtwkSgi23uA0KRKT
NqMS1loug5GviocVllqGNoqzLEiVybAFWubk/LsNEPgTbEiKYfGuGf0dDbthhM84
o81pZADWgCE5y0KQrQJo+BI5TZCCF13DBks/UhF9jnZaS3lY74/uXnbpinY393Bx
DcinRV4pmg9haL0rItHA5wgeslmf0CnXACY3yGzdRaCiclciI/n1oGcf+qV2wN5+
Qm08xdUopMCGpEhxq+yBZtlVTdFED0QueerN/PZgSzCev9RJmqccHyY3MTmV7uiK
pEe2SYSPORQRAJAgYyUHe6ydx5Nz4sIceCYsAjieHVT3me+MyoXkkqKMBKG5lHrc
t63/fR7b3zcejf9JEDJ8lxa/F7cFV/FtblT8mqEWJ2R1WMVC56aiUBAdVuTqWPJd
D2NI3UkXdQQliOTCn0M1Fsg6X6hUM91ksYxNFZSclQ7IcG+u3ba4Lh4V9xKL8+2C
G7dhftDMDr6btNmxmWsyftIBcy/g3p0SCMCS2Hf0zjfGqrdoNkc=
=WdES
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--

--===============1976663026068352465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1976663026068352465==--
