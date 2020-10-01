Return-Path: <SRS0=MyXX=DI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92810C4727C
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 08:00:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C7372145D
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 08:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEWWAXxy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C7372145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id DEE7287329;
	Thu,  1 Oct 2020 08:00:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SgaqBZG+Riqn; Thu,  1 Oct 2020 08:00:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5AE7787307;
	Thu,  1 Oct 2020 08:00:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38DF3C1AE1;
	Thu,  1 Oct 2020 08:00:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1BDBC0051
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 08:00:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id CD3848730D
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 08:00:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eI8XhwN4BOrr for <iommu@lists.linux-foundation.org>;
 Thu,  1 Oct 2020 08:00:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
 [209.85.208.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D24F687307
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 08:00:02 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id dn5so759837edb.10
 for <iommu@lists.linux-foundation.org>; Thu, 01 Oct 2020 01:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=kJDll8669MgwGkGlatIF8vY03H/D/9DxkpS4HR8psz0=;
 b=mEWWAXxyBizecMRZilDRasV4hyuAjJCc3TEa7CNG5P+0EUX0/qpkD0U0sDer0i/frK
 58ijdsTThYNUFvgAhSJnI4I8I92FrBQodvuOHLJGtDna6DrLRp0089kJSXTGVEJ5+ob4
 yyaTlpOXHNvU5+dQEhWbjdjhdO5zE/3AeJjEouHsL91WqdFDxb0tDBKGw3qGNVVblWri
 6aytBAy065XQfrdtAteH1cDyx9Et2wbSl2MAMGZJKD/6RR4ELMO/5k512H1Zmd/4S2Xf
 WUIR3uhFwfSEFWmNMSVauf0uNqvXgwKx0CzSsB3vaqAwaFNaYKfJqJB063cCba23kZnK
 7dig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=kJDll8669MgwGkGlatIF8vY03H/D/9DxkpS4HR8psz0=;
 b=W2Mh/gBvyv33s+muDjDNm9sLkNrl0S6uZgqZFdjNdO2mk57lPKvLxzc5M6ih4Ncqf/
 9fMCLfaFW28xVxuM7yxFaqLah+tc4higOj6g/r8B/UQUBcAyPqGYeFKcvk7d0EJ3HbGm
 AvHdeer18NT17W36TUfXiHapG3ZCJ1ceNibZRCf2QgZaAbAxcZbYAxCXQvgCJXxI6aMn
 S6s6ZLCQ6bUnYaa1D1+C4rAGxX+0KeK9wTrWCNZoxfdNQVyz4HSJtPrW5QIl5sSRCWc5
 ctgRb8jr2A3sxNOJ/heGQ6z1vdfkLaM1qeGjVqk7I+Z8TCRnzeLJz+/DrZAlCffCg+zF
 fPVA==
X-Gm-Message-State: AOAM533lC0IhnCWFfTKu4JYfra7FHYWgvyFiATCDzIWZ7j7jlQM8pu5C
 NSrJbE7FqmtptKJFy7Qdgi8=
X-Google-Smtp-Source: ABdhPJzhr4TJ1Eipm/gKkHKCZgtc6Id22KJDdtB+FTrQfwP5iA5E8tm55OszIG11/sEletKyVEZS7w==
X-Received: by 2002:aa7:c1c3:: with SMTP id d3mr6962876edp.228.1601539201381; 
 Thu, 01 Oct 2020 01:00:01 -0700 (PDT)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id t18sm1230119ejg.76.2020.10.01.00.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 01:00:00 -0700 (PDT)
Date: Thu, 1 Oct 2020 09:59:58 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v3 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
Message-ID: <20201001075958.GB3919720@ulmo>
References: <20200930084258.25493-1-nicoleotsuka@gmail.com>
 <20200930084258.25493-3-nicoleotsuka@gmail.com>
 <20200930153131.GB3833404@ulmo>
 <ece615ad-8d6b-96ae-d8b4-9667aef17281@gmail.com>
 <20200930161033.GE3833404@ulmo>
 <36946786-38c5-54d4-07f5-2407c39aa01c@gmail.com>
MIME-Version: 1.0
In-Reply-To: <36946786-38c5-54d4-07f5-2407c39aa01c@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============3968467013892098229=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============3968467013892098229==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2020 at 07:29:12PM +0300, Dmitry Osipenko wrote:
> ...
> >> Secondly, I'm already about to use the new tegra_get_memory_controller=
()
> >> API for all the T20/30/124/210 EMC and devfreq drivers.
> >=20
> > Also, this really proves the point I was trying to make about how this
> > is going to proliferate...
>=20
> Sorry, I'm probably totally missing yours point.. "what" exactly will
> proliferate?

Making use of this lookup-by-compatible mechanism. If you provide a
function to make that easy, then people are going to use it, without
even thinking about whether or not it is a good idea.

Thierry

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl91jH4ACgkQ3SOs138+
s6HvIQ/+JbyTifAB7AT15uE5vSsP5C4aDS4Zf+b3yMzEClBY7F2gR7gZNz0tKeJ5
3j2SNVw4pxFJiyxSIHP+YCwCmVEOoEBOuDhARo76U1nWKNSMlIxXFyi/xOso1OaG
HNhILPmvmk4Y41LQ96VzKpHtf4NvafW4oQ244t1E15ZlT2nR5+OQzFKN6xDYhujR
LkXGrv5EdRYL9QkAoZ/cTxfb1hsqmviebkVXWJTBPS2cErsg+HtVRXChFLAlZgNL
RXVMivkZ7FdCHqMSpaypAaUDGKLWI16DjPu1woUeXjHh9CjbL+YRa5eC78YgLye9
B5uXXzLBCE8SrxR7xjTSnDd+ZBAKQ2Z7N+cz1EzbxBI79bZ9lFqwONt1Cjr3+3pW
Im1mGMr0hjveQK4JPdgT4bGyLKXKf7Jfau5bTLTI+UxZyHXCUfqsuP+yU0aHNRiP
dp9X8+rMuapK+jG9NKEXj0a/qgLvr3DXV5pN2cCjFHBM7MRHO+oPsAE22rd8gkaP
EsNbJ9o5Fpxn2nqyKX5GOzzpyPmhaPM+xLoKVl+YYJdaueMvAw5wGq+sZsdbrT5n
KqLTZicexxYUhofOLI0hZJJikHWY4y0UB9IbJDOuhrit61cD57UqGtvPmfIcT4gP
2rO0fNqtBsHuXrWhjk4fqQL9PATsQLENdxB0TMX+0zIVyfJTuTA=
=wRou
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--

--===============3968467013892098229==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============3968467013892098229==--
