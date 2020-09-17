Return-Path: <SRS0=xf59=C2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B2BC43461
	for <iommu@archiver.kernel.org>; Thu, 17 Sep 2020 12:04:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56947208DB
	for <iommu@archiver.kernel.org>; Thu, 17 Sep 2020 12:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56947208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BC7542E107;
	Thu, 17 Sep 2020 12:04:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jwoP7ep+09Ba; Thu, 17 Sep 2020 12:04:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 43E8820431;
	Thu, 17 Sep 2020 12:04:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28C2FC0888;
	Thu, 17 Sep 2020 12:04:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7102C0859
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 12:04:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C589587520
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 12:04:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EyT7FB55zC+n for <iommu@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 12:04:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C0F0A8751C
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 12:04:03 +0000 (UTC)
Received: from kevin (unknown [IPv6:2607:fea8:55f:a950::68f4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: alyssa)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C9FB029AEF5;
 Thu, 17 Sep 2020 13:03:47 +0100 (BST)
Date: Thu, 17 Sep 2020 08:03:37 -0400
From: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH 0/3] drm: panfrost: Coherency support
Message-ID: <20200917120337.GA1684@kevin>
References: <cover.1600213517.git.robin.murphy@arm.com>
 <d109e9da-feb3-c09f-2b7f-98c92ce39593@baylibre.com>
 <20200916170409.GA2543@kevin>
 <CAL_JsqLGO4YYPjQsjnzZCW5iT6n+keZw9G9mFALJip0nDo42Hw@mail.gmail.com>
 <d135f546-41aa-a6e2-52fe-7707d379c793@arm.com>
MIME-Version: 1.0
In-Reply-To: <d135f546-41aa-a6e2-52fe-7707d379c793@arm.com>
Cc: Rob Herring <robh@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Neil Armstrong <narmstrong@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, Will Deacon <will@kernel.org>,
 "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
 Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Jerome Brunet <jbrunet@baylibre.com>
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
Content-Type: multipart/mixed; boundary="===============3415913113789652897=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============3415913113789652897==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> The DDK blob has the ability to mark only certain areas of memory as
> coherent for performance reasons. For simple things like kmscube I would
> expect that it's basically write-only from the CPU and almost all memory the
> GPU touches isn't touched by the CPU. I.e. coherency isn't helping and the
> coherency traffic is probably expensive. Whether the complexity is worth it
> for "real" content I don't know - it may just be silly benchmarks that
> benefit.

Right, Panfrost userspace specifically assumes GPU reads to be expensive
and treats GPU memory as write-only *except* for a few special cases
(compute-like workloads, glReadPixels, some blits, etc).

The vast majority of the GPU memory - everything used in kmscube - will be
write-only to the CPU and fed directly into the display zero-copy (or
read by the GPU later as a dmabuf).

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ17gm7CvANAdqvY4/v5QWgr1WA0FAl9jUJAACgkQ/v5QWgr1
WA2dWg/+OmkKrIz3I3zxUDFk1aW47mEA/JzLjdkrFq+J1K67FPajUIaqzgLjYq1b
wB3a51QSJoN70Aw9O9jrV/GkEbpSf8QWObN4NtZqYcD58fECprh5oXmEfgD0u5gZ
6Gkoijp15utLoOirt2LkEJpYAxrOjfA9n5+WQLn8qQY1QPwO2AjtNxXWlWNhYqvh
CQwDQGoO9FiWNSRPZpx1yHEYP/aDMTW8MqwQ8JsQu2G42TS6ErQUC9OMMZjJ/TYS
GLKA4ybkdSnlNwQH0h+7g6LX0Y3WGUUn1xxbd4P7OPFZapV+87+cQS8sottqH7tS
Rrja9cH4d7/DjKmn1xjT5ftnagxGkzoJ9eYf13DTedymUAQxMGV5TdZhCeUT0HFz
5es9SnkTjOFAQyKZbjiM5t5Sia0eUHLIKUwX6FFKnWxMTtLF4z8XGhizHQrZ8M5I
tQW8f7BzInUEGN5H3FV6spp+P5tL7AkdTEGJ4p87EnoyJfTq2mxWAfTxxN9R01FQ
3yDMyx9bUXif0CNnJjAyTN0WJt17twGKuqAnGu5+oLtK6BXuC5wv9yPyQZ5Zvwgv
HnXnb+s10WYXgdOHRNebUvFnDYsIZTp8/qFXiAdKaHT/r7aL/UKm2XQqwz48O40W
doi8CBItWk7+SxVkj3w5nxnyl9vhu0Md9HkBvGZEH3wfnPGu4/w=
=k8jL
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--

--===============3415913113789652897==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============3415913113789652897==--
