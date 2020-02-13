Return-Path: <SRS0=ZJ+1=4B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C20C3B189
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 18:16:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E99AE222C2
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 18:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFwuMx4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99AE222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9574C87EE8;
	Thu, 13 Feb 2020 18:16:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h6euIDgbbuQn; Thu, 13 Feb 2020 18:16:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 82CB685734;
	Thu, 13 Feb 2020 18:16:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76F8BC07FE;
	Thu, 13 Feb 2020 18:16:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9D6DC0177
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 18:16:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B6E6D85424
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 18:16:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id daGZPxE20R7I for <iommu@lists.linux-foundation.org>;
 Thu, 13 Feb 2020 18:16:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B42D3849B8
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 18:15:59 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id g1so7305961wmh.4
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 10:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=5d94ISfAMJsY5/JXuqSKAmxNkAX3S4dFJmeeR7ypVcE=;
 b=FFwuMx4A91uPXpKY8nsucsQTEpphwr5zhH4Oya1D86W+RXvdwACsmlSXhLSexF0NcM
 P9TfFve1ePZB9zAXpfXPJ6pnLIJKiI+vsVdmHMDavStLweUfRWnrTV2MIgQDt/tnTttP
 FrQGvuDP4LCuIFD2h2Vv6QvQSiEUUKhJF+QkXD2j/s44KWLYBWsxLrHYeZer3Z2y0aqz
 RPfiBuphdNVtBahhcdlpnYEKEr+vLrCy1lGJ7aAqfiw6nTeNt7IO1eXjEYH3eL7LBRNt
 K3XIt4YNATmo1Grnqf9PsgDq8/IUaIU45JRkPVo0FI0rVzdZ8pPphyr8n0oNjdxNyj3b
 ddBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=5d94ISfAMJsY5/JXuqSKAmxNkAX3S4dFJmeeR7ypVcE=;
 b=Z/52clWNRa4qGoi2Bb8e3h6U2uq4zxb5cToHt0BFOmGva6rL8h3corZNEd67B0Hcji
 AhzPgz9Pk2xMIiy7adjWETIHwyXs66hwvtkHGIlF/XW10NC3Q0fUgvVve9uDZKYbj7kr
 yhsVEoN93ZdTaNR4m1s64I9yS7gCWutys22IJMra6Mh9iZqCiUwKr+bRu27oQyzpPtUl
 1MBI2z8jf8HSO8HpBAyOhgTmlRRqSXZFlwA45nJB2mp5MDAPoRyCcwjdvfLqJwMUDxU2
 cU0+2fP04j6mXPlTSAMIcXXvIArLE/1XJmPBX1YX61aDDPgbPSdRR/PNqZx32aEKwMMT
 CGRA==
X-Gm-Message-State: APjAAAVEw8Ze/ASAbujJYYCKTJ/S8Wo01zmg+9jkIn/kE+wmH+f/MnMP
 Ur2QHU13XzgPrtRQ1DayjaQ=
X-Google-Smtp-Source: APXvYqxqFNSHf02vz4/vAuR4WVy3yZSGsTnLODcDrddSPmiG/KsfyeRBrRl06AzAZBFk2cOx947e8g==
X-Received: by 2002:a1c:4e05:: with SMTP id g5mr6927099wmh.152.1581617758127; 
 Thu, 13 Feb 2020 10:15:58 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
 by smtp.gmail.com with ESMTPSA id y12sm3896731wmj.6.2020.02.13.10.15.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 10:15:56 -0800 (PST)
Date: Thu, 13 Feb 2020 19:15:55 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v4 0/5] memory: Introduce memory controller mini-framework
Message-ID: <20200213181555.GB1006063@ulmo>
References: <20200213163959.819733-1-thierry.reding@gmail.com>
 <9841eb35-65e4-632a-ceff-bb2ba3b11bb0@arm.com>
MIME-Version: 1.0
In-Reply-To: <9841eb35-65e4-632a-ceff-bb2ba3b11bb0@arm.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 Maxime Ripard <mripard@kernel.org>, linux-tegra@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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
Content-Type: multipart/mixed; boundary="===============8849861690416184097=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============8849861690416184097==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2020 at 05:23:23PM +0000, Robin Murphy wrote:
> [+ Maxime]
>=20
> On 13/02/2020 4:39 pm, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Hi,
> >=20
> > this set of patches adds a new binding that allows device tree nodes to
> > explicitly define the DMA parent for a given device. This supplements
> > the existing interconnect bindings and is useful to disambiguate in the
> > case where a device has multiple paths to system memory. Beyond that it
> > can also be useful when there aren't any actual interconnect paths that
> > can be controlled, so in simple cases this can serve as a simpler
> > variant of interconnect paths.
>=20
> Isn't that still squarely the intent of the "dma-mem" binding, though? i.=
e.
> it's not meant to be a 'real' interconnect provider, but a very simple way
> to encode DMA parentage piggybacked onto a more general binding (with the
> *option* of being a full-blown interconnect if it wants to, but certainly=
 no
> expectation).

The way that this works on Tegra is that we want to describe multiple
interconnect paths. A typical device will have a read and a write memory
client, which can be separately "tuned". Both of these paths will target
system memory, so they would both technically be "dma-mem" paths. But
that would make it impossible to treat them separately elsewhere.

So we could choose any of them to be the "dma-mem" path, but then we
need to be very careful about defining which one that is, so that
drivers know how to look them up, which is also not really desirable.

One other things we could do is to duplicate one of the entries, so that
we'd have "read", "write" and "dma-mem" interconnect paths, with
"dma-mem" referencing the same path as "read" or "write". That doesn't
sound *too* bad, but it's still a bit of a hack. Having an explicit
description for this sounds much clearer and less error prone to me.

Thierry

> > One other case where this is useful is to describe the relationship
> > between devices such as the memory controller and an IOMMU, for example.
> > On Tegra186 and later, the memory controller is programmed with a set of
> > stream IDs that are to be associated with each memory client. This
> > programming needs to happen before translations through the IOMMU start,
> > otherwise the used stream IDs may deviate from the expected values. The
> > memory-controllers property is used in this case to ensure that the
> > memory controller driver has been probed (and hence has programmed the
> > stream ID mappings) before the IOMMU becomes available.
> >=20
> > Patch 1 introduces the memory controller bindings, both from the
> > perspective of the provider and the consumer. Patch 2 makes use of a
> > memory-controllers property to determine the DMA parent for the purpose
> > of setting up DMA masks (based on the dma-ranges property of the DMA
> > parent). Patch 3 introduces a minimalistic framework that is used to
> > register memory controllers with along with a set of helpers to look up
> > the memory controller from device tree.
> >=20
> > An example of how to register a memory controller is shown in patch 4
> > for Tegra186 (and later) and finally the ARM SMMU driver is extended to
> > become a consumer of an (optional) memory controller. As described
> > above, the goal is to defer probe as long as the memory controller has
> > not yet programmed the stream ID mappings.
> >=20
> > Thierry
> >=20
> > Thierry Reding (5):
> >    dt-bindings: Add memory controller bindings
> >    of: Use memory-controllers property for DMA parent
> >    memory: Introduce memory controller mini-framework
> >    memory: tegra186: Register as memory controller
> >    iommu: arm-smmu: Get reference to memory controller
> >=20
> >   .../bindings/memory-controllers/consumer.yaml |  14 +
> >   .../memory-controllers/memory-controller.yaml |  32 +++
> >   drivers/iommu/arm-smmu.c                      |  11 +
> >   drivers/iommu/arm-smmu.h                      |   2 +
> >   drivers/memory/Makefile                       |   1 +
> >   drivers/memory/core.c                         | 248 ++++++++++++++++++
> >   drivers/memory/tegra/tegra186.c               |   9 +-
> >   drivers/of/address.c                          |  25 +-
> >   include/linux/memory-controller.h             |  34 +++
> >   9 files changed, 366 insertions(+), 10 deletions(-)
> >   create mode 100644 Documentation/devicetree/bindings/memory-controlle=
rs/consumer.yaml
> >   create mode 100644 Documentation/devicetree/bindings/memory-controlle=
rs/memory-controller.yaml
> >   create mode 100644 drivers/memory/core.c
> >   create mode 100644 include/linux/memory-controller.h
> >=20

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5FklsACgkQ3SOs138+
s6GcqA//Q5OUVYrdcTeux/f0EWBv1/pwht0ee1aUsnP4Um8quhAz+gMOpMLLq0Tr
Lxv4wuLKKSd59BfF48NUk7fU91iMLKJTzT1yBxSWvsEc0MIfUPre8PalEToob4oj
TfLrNwEulquUL4aUAEdXUzfpSibr+2cf0Vf0oQMXDIj4TQ5LNc8WtRssWU/joa1Z
jTNrXQ8B0+gA9KXf9/5jA4tzsrFfpxaVQ2oiPBJTxaBS6a1VSGhCfk64Fv1Xezv6
NIffcn67mdt2rtI59Pz1YTVEgUqG9E47S+9qwqfgtcRvqE2UoiPHGoOpOevDI2El
LO/muVw5xyROk4X23lhbH9q1IZ8wDefRP0Nt2e5/Fgi1jj899n3GBpFrp4tLIZQ4
OKzxA/yoHOfWqPQkYmE8LY9OZZKYv5vX1E0l7aY7OR78rUpc0oXPptkedP1JVHnX
It3t3YvecvstIl0UxC67b9OlZC4h2kPzqlqF3fc0xOdV1eeLI1G58UzC8phSfoEo
qCOps57BTHR2i4BMXirkvKkb5bbDhGA3qrgX068xGIsw4SDvnQ7y4c5SFTqybqql
eplj55UYCk+JP85/gJ6+sXjEqAnyMIdv6lnGCxmfncIXheSDw0c/D8t00IzpovmO
PX1pak4k8xe0Ub8R6Vg9HRM0IsCSQ8lDrt/whJVWXKU1M74PJlM=
=gwzY
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--

--===============8849861690416184097==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============8849861690416184097==--
