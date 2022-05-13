Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA67BC4332F
	for <iommu@archiver.kernel.org>; Fri, 13 May 2022 12:49:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C28360EAA;
	Fri, 13 May 2022 12:49:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oaW22ryBOD9m; Fri, 13 May 2022 12:49:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 61CDC60E9C;
	Fri, 13 May 2022 12:49:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39DB0C0039;
	Fri, 13 May 2022 12:49:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13928C002D
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 12:49:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E741441764
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 12:49:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 03YKyAgwynrG for <iommu@lists.linux-foundation.org>;
 Fri, 13 May 2022 12:49:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EB01A4091E
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 12:49:04 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 11085CE315A;
 Fri, 13 May 2022 12:49:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66AD9C34100;
 Fri, 13 May 2022 12:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652446139;
 bh=N6Gs27VquaPY/jfyx7p+uW0mYzfGY1yrIjK7gsqoh7Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aElnBzI2wZCSK/U/Wnscmm/Sf1R+M1wGzU0SZHNmsLcyeDhrq6q7+ygyC0z9PfHR5
 N/ajNj3N6eZZfZ+EylMuobL3/Y77JbKMylxyKVAO5DnQMabg8vlXq614hAoTU0zLlP
 OwxUFo7FINvs9ZH8/v/9RcNsiTStBmfaPbsDNWYzSFyQqCJ8+C/75GEEudBLaGfq4J
 bnunuVr6Fks8yOQ82W/lBrSSdtVf3jiVDNx4x+cTtr61rJzRf4F5t1QVXaCdkXm3XX
 ZH1pPSQmTMHTphNJscauUHBAScWkKa5e5mlFYP/mp6JtlmMiYdidrd9ND6ZcmCSi7H
 WxgHFkTrgee9g==
Date: Fri, 13 May 2022 13:48:51 +0100
From: Mark Brown <broonie@kernel.org>
To: Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v1] driver core: Extend deferred probe timeout on driver
 registration
Message-ID: <Yn5Ts1+56rBip8Mc@sirena.org.uk>
References: <20220429220933.1350374-1-saravanak@google.com>
MIME-Version: 1.0
In-Reply-To: <20220429220933.1350374-1-saravanak@google.com>
X-Cookie: You have taken yourself too seriously.
Cc: Rob Herring <robh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 kernel-team@android.com, linux-doc@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Walleij <linus.walleij@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Kevin Hilman <khilman@kernel.org>, iommu@lists.linux-foundation.org,
 Geert Uytterhoeven <geert@linux-m68k.org>, Pavel Machek <pavel@ucw.cz>,
 linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
 Thierry Reding <treding@nvidia.com>, Will Deacon <will@kernel.org>
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
Content-Type: multipart/mixed; boundary="===============5662914016426011988=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============5662914016426011988==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZVbyQANSq1izx04U"
Content-Disposition: inline


--ZVbyQANSq1izx04U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 29, 2022 at 03:09:32PM -0700, Saravana Kannan wrote:
> The deferred probe timer that's used for this currently starts at
> late_initcall and runs for driver_deferred_probe_timeout seconds. The
> assumption being that all available drivers would be loaded and
> registered before the timer expires. This means, the
> driver_deferred_probe_timeout has to be pretty large for it to cover the
> worst case. But if we set the default value for it to cover the worst
> case, it would significantly slow down the average case. For this
> reason, the default value is set to 0.

This makes sense to me.

Reviewed-by: Mark Brown <broonie@kernel.org>

--ZVbyQANSq1izx04U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJ+U7MACgkQJNaLcl1U
h9AJrQf+O34uAf+WJTRmMJA0R5+muU/Q3+PYEKAnTQ3EJ1R3EpYCuFYr1FlCDe3g
OIg2rZyCYxhlgQ/k1CRFZbdK+R94KNZ5rv47uV1Kt8aC1uY7Rizh+e04jjgYSIOc
TVn7quNTCXOPaNwuz95cURa8W7X4GFXDkdppjmpcYeMaaNsOU4z3Pw9drORQTArc
Vb8M63Rn2/hazrGdt7xRTUU+/UvyOu3R63NeqkBcvvVo+tLXgOFaRsciYs+xMI6t
Lg347Izlc1kBmpHhg5e/tAl5zEj3cZgc6a6gTg69f7i90AnxZw64vwFiv9grHK5S
HLh2BNII8I1elceOYfqYDh3c1Apcww==
=vDHz
-----END PGP SIGNATURE-----

--ZVbyQANSq1izx04U--

--===============5662914016426011988==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5662914016426011988==--
