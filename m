Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A4C33062;
	Sun, 29 Dec 2024 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735482979; cv=none; b=XFjRy6VXgmBkyUQFxunKxtrAwyT2Jzf+sZJE6ntHq2bkM0rA5C7ZJdqV7TY0Sch1FNLbjdugPqWSgBGpbYMHjDL+IdqFzA7Z+tY/h3f8RDKzAbOFppYEG+dXty3Kk+39hWMpnBaL6XfERz9edrWqSn1hJA8dgFYCOI8dgbNEc30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735482979; c=relaxed/simple;
	bh=Pc6YBENrL3gfox19a5Qfr+UZswxTEyvBHnbgbA3queU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VyrhQsrw3EBOAoeGVYTCo4Iwu7DgWOL9A+PKiWR/7wGzEAY3jAApB07I8cWpPofe/27sSxpaWxUb/l/DcpnnlmzZqcnvYmLzzqNU1yaDHPObN2DrKjXTDtXU4PNajXVWdzllf8MoGTyHKzs9nH+o9l5SDnmQVpWPp1+hoIgnO6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=qKVQP+UH; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="qKVQP+UH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xIeTXK2tT8GiOrGH1G6rXzh8bEX4/s2CJjW9ca6ycWY=; b=qKVQP+UHNn1KBZzCZwhZEP+dv5
	JVeHDMjBlFKGne6r2oerhTUo6xr4REMBXAj9Zsp4HrkIFIH5fyvmXDwITnbI0H/wSNZbUu0eqMw3c
	Dlsclx1C5/gKngjj6XIB9hEGZxmX9opOFL0VFztQb7U5WYy5CugnVJb/Nrbzfpr2PQK/oxLm6Jbi3
	mjAx2Wa0FQUFS/0TalNBcMOrAuR6U6AZUmIWyVNCY9QMr04kjj4w5QUesj3v/IrLWQulot4XZvRux
	11daSIUyDraGOB0TtUfHnyo3S9yEeS+FAJfmZuQnI1bVcDSXWVjO8uHj/cGJ6j3s5jRvCXE3GKU0b
	XJD9GaZw==;
Received: from i5e860d12.versanet.de ([94.134.13.18] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tRuOY-000400-7W; Sun, 29 Dec 2024 15:35:54 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Andy Yan <andyshrk@163.com>
Cc: krzk+dt@kernel.org, joro@8bytes.org, cl@rock-chips.com, robh@kernel.org,
 hjc@rock-chips.com, vkoul@kernel.org, devicetree@vger.kernel.org,
 detlev.casanova@collabora.com, cristian.ciocaltea@collabora.com,
 dri-devel@lists.freedesktop.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org,
 Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v2 0/8] Add display subsystem dt node on rk3576
Date: Sun, 29 Dec 2024 15:35:53 +0100
Message-ID: <3330586.aeNJFYEL58@diego>
In-Reply-To: <6ff7470.1060.194112c804a.Coremail.andyshrk@163.com>
References:
 <20241228122155.646957-1-andyshrk@163.com> <4950097.GXAFRqVoOG@diego>
 <6ff7470.1060.194112c804a.Coremail.andyshrk@163.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi Andy,

Am Sonntag, 29. Dezember 2024, 07:48:36 CET schrieb Andy Yan:
>=20
> Hi Heiko,
>=20
> At 2024-12-29 02:36:36, "Heiko St=FCbner" <heiko@sntech.de> wrote:
> >Hi Andy,
> >
> >Am Samstag, 28. Dezember 2024, 13:21:43 CET schrieb Andy Yan:
> >> From: Andy Yan <andy.yan@rock-chips.com>
> >>=20
> >>=20
> >> As the VOP[0] and HDMI[1] driver have already been submitted for revie=
w.
> >> This series send all display related device tree part together.
> >> [0] https://lore.kernel.org/linux-rockchip/20241219073931.3997788-1-an=
dyshrk@163.com/T/#t
> >> [1] https://lore.kernel.org/linux-rockchip/20241225103741.364597-1-and=
yshrk@163.com/T/#t
> >
> >not to confuse you too much, I mainly meant that we were missing the
> >"arm64: dts: rockchip:" patches from this series.
>=20
> Sorry, I misunderstood it in V2 . Before go to the next step, I would lik=
e to confirm it again:
> Does that mean I should:
> 1.  the dts patches(6/8, 7/8 8/8) should be sent as a separate series.
> 2. PATCH 5/8 should still go with the rk3576 vop driver[0]
> 3. PATCH 3/8 should still go with the rk3576 hdmi dirver[1]
> 4. PATCH 1/8, 2/8 4/8  should still be sent separate  ?

exactly. The reason behind this is to prevent confusion about who is
expected to apply a patch.

The dt-binding goes together with driver-changes into that subsystem-tree.
This normally also includes single bindings. So the "normal" expectation is
that the iommu-binding patch goes through the iommu tree, the phy-binding
patch goes through the phy tree and so on.

And of course the hdmi-binding patch goes together with the hdmi-driver
change.


Heiko


> >The dt-binding patches are (already) part of the driver changes and
> >should stay part of those series, to prevent confusion of what part goes
> >where :-) .
> >
> >
> >Heiko
> >
> >
> >> Changes in v2:
> >> - Wrap commit message according to Linux coding style
> >> - Make "rockchip,rk3588-hdptx-phy" const for "rockchip,rk3576-hdptx-ph=
y"
> >> - Make declare phy/ropll/lcpll reset line are not exit on rk3576
> >> - describe constraint SOC by SOC for vop2 binding, as interrupts of rk=
3576
> >>   is very different from others
> >> - Drop Krzysztof's Reviewed-by for vopp2 bindings, as this version cha=
nged a lot.
> >>=20
> >> Changes in v1:
> >> - ordered by soc name
> >> - Add description for newly added interrupt
> >>=20
> >> Andy Yan (8):
> >>   dt-bindings: soc: rockchip: add rk3576 hdptxphy grf syscon
> >>   dt-bindings: phy: Add rk3576 hdptx phy
> >>   dt-bindings: display: rockchip: Add rk3576 hdmi controller
> >>   dt-bindings: iommu: rockchip: Add Rockchip RK3576
> >>   dt-bindings: display: vop2: Add rk3576 support
> >>   arm64: dts: rockchip: Add vop for rk3576
> >>   arm64: dts: rockchip: Add hdmi for rk3576
> >>   arm64: dts: rockchip: Enable hdmi display on sige5
> >>=20
> >>  .../rockchip/rockchip,rk3588-dw-hdmi-qp.yaml  |   1 +
> >>  .../display/rockchip/rockchip-vop2.yaml       |  70 ++++++++--
> >>  .../bindings/iommu/rockchip,iommu.yaml        |   1 +
> >>  .../phy/rockchip,rk3588-hdptx-phy.yaml        |  62 ++++++---
> >>  .../devicetree/bindings/soc/rockchip/grf.yaml |   1 +
> >>  .../boot/dts/rockchip/rk3576-armsom-sige5.dts |  47 +++++++
> >>  arch/arm64/boot/dts/rockchip/rk3576.dtsi      | 126 ++++++++++++++++++
> >>  7 files changed, 276 insertions(+), 32 deletions(-)
> >>=20
> >>=20
> >
> >
> >
> >
>=20




