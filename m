Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBB130E853
	for <iommu@lists.linux.dev>; Fri, 20 Jun 2025 20:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750452364; cv=none; b=dr4ybXg+c9L2iCwToOIjMmtf0e/NZSakxzepU3K8PNc2hNYxu4xqx0q1nrsFHA3PR1Q/j5U4sbrVprGvhyCq4aAbiocp4CybZU1usPbdq0nzSaZlyMbKNHL2baw2Ali4Tdh9sruOdWdxDwuoSxiembX41JYRRfdG9ls6Sk8uVpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750452364; c=relaxed/simple;
	bh=mGxKurpsvHmgW89VHzKxiFNLvfM2W4TYEkHDY6+Y9n8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ihay/u8pTcRAHZcyAvOtsGGPnvYPi6i/xqtAiGgB4H8V9yswqgG+1Cf7kxHppBuCI/QCT1+GvlUVMu/lcgVrG3GeOTy1aS6jV+qfJy4ltn6oBYYhER3FAR42iVSbhyEx5xHIrU1S6e6CdPEkocwmerVuIaH2U436/SY0vSjFAD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1uSicJ-0008Gr-KZ; Fri, 20 Jun 2025 22:45:43 +0200
Message-ID: <c7dd8ac53170cafab5489f98d3da13f65cd67a1a.camel@pengutronix.de>
Subject: Re: [PATCH v3 3/5] iommu: Add verisilicon IOMMU driver
From: Lucas Stach <l.stach@pengutronix.de>
To: Robin Murphy <robin.murphy@arm.com>, Benjamin Gaignard
	 <benjamin.gaignard@collabora.com>, joro@8bytes.org, will@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, 
	nicolas.dufresne@collabora.com, jgg@ziepe.ca
Cc: iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, kernel@collabora.com
Date: Fri, 20 Jun 2025 22:45:41 +0200
In-Reply-To: <43276c9a-5434-467c-abb2-dd2806ab81d0@arm.com>
References: <20250619131232.69208-1-benjamin.gaignard@collabora.com>
	 <20250619131232.69208-4-benjamin.gaignard@collabora.com>
	 <43276c9a-5434-467c-abb2-dd2806ab81d0@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: iommu@lists.linux.dev

Am Freitag, dem 20.06.2025 um 20:37 +0100 schrieb Robin Murphy:
> On 19/06/2025 2:12 pm, Benjamin Gaignard wrote:
> > The Verisilicon IOMMU hardware block can be found in combination
> > with Verisilicon hardware video codecs (encoders or decoders) on
> > different SoCs.
> > Enable it will allow us to use non contiguous memory allocators
> > for Verisilicon video codecs.
> >=20
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > ---
>=20
[...]
> I'm especially curious what this "pta" really is - is the comment above=
=20
> just wrong, and you've actually got a 3-level pagetable supporting=20
> somewhere between 33 and 42 bits of VA? If not, then the additional=20
> level of indirection would very much seem to imply some kind of=20
> mechanism for accommodating multiple pagetables at once, and in that=20
> case, is it like a PASID table where the client device gets to choose=20
> which entry to use, or a StreamID table to disambiguate multiple client=
=20
> devices? (Where in the latter case it should most likely belong to the=
=20
> IOMMU rather than the domain, and you probably want nonzero #iommu-cells=
=20
> in the DT binding for the client IDs).
>=20
PTA is short for page table array and it's another level of indirection
to select the page tables to be used for the specific translation. On
the Vivante GPU, where this MMU IP originated, the GPU can select the
index into this array to be used for a specific command stream to
implement GPU client isolation, so it's much like a PASID table.

I have no idea if and how the integration with the video codecs can
select the PTA index.

Regards,
Lucas

