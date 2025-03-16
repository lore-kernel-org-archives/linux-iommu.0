Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EB428E8
	for <iommu@lists.linux.dev>; Sun, 16 Mar 2025 05:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742101775; cv=none; b=J+i+MW6qjUd6n3iXFCI5+7XJO0OP2bhLYaYACW1iWOz4lx3P/wg6G3r1O9qxnWo/DKMHCURAN6f/h7gRL/ycy+L9E3O8o0wFlQBgYGmyfRSFgSd6NZHJH5qeVGMAhanDFRJQP5OYkBq6dHfZU6K81j+hHrB7unonREwzTceAclA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742101775; c=relaxed/simple;
	bh=lLozEeBLlgV86HlgPg18pz4OFD1viZMm++QDeHafczU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S+HUSwA9LsSssVmmj5jm2xiOxNpPlk8HzEJYPYlYyN9fpjGhdiPTYLZWMetTHcBocVU0cJbEjybpq1eI3Ipa7WcRJpw5Ft3n8sjMGf6mK70UdiblXT2gYmREakthuDjnZ5n4O3KKvD60VrqE5uuvjmKLqSZ6e7IZzWlScWrrtDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=rATON2Wr; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="rATON2Wr"
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4ZFmGr5jwHzDqLs;
	Sun, 16 Mar 2025 05:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1742101445; bh=lLozEeBLlgV86HlgPg18pz4OFD1viZMm++QDeHafczU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rATON2WrIr3NZdUK1s84wWU0dJErmcUiGbauVGOR+SWUamvwpPyoiiVIONPhngaPD
	 n+EVodYWlUjQ9MWoWA8XFnOXVsaoUxtsN/u1MT0q5Qd19agTgA+DJyuM8IKe4O5vtx
	 6gpI5T5RY6b02kDYStgsoiXbhAq8kCflfp8PYBVw=
X-Riseup-User-ID: FA07B3CEF15B9BF855EB57A064CA13396EA4C9B9044372EE883EE87E4D753941
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4ZFmGb3mRlzJqbv;
	Sun, 16 Mar 2025 05:03:51 +0000 (UTC)
From: Dang Huynh <danct12@riseup.net>
To: joro@8bytes.org, will@kernel.org, Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, heiko@sntech.de
Subject: Re: [PATCH 0/3] Rockchip IOMMU fixes
Date: Sun, 16 Mar 2025 05:03:43 +0000
Message-ID: <7951915.lOV4Wx5bFT@melttower>
In-Reply-To: <cover.1741886382.git.robin.murphy@arm.com>
References: <cover.1741886382.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Thursday, March 13, 2025 5:31:03=E2=80=AFPM UTC Robin Murphy wrote:
> Hi all,
>=20
> I was expecting my DT probing change to flush out issues, and it seems
> some weaknesses in rockchip-iommu were the first to show. The first two
> patches here get things working again for me on my RK3399 NanoPC-T4
> (with a console on HDMI exercising the VOP MMU), the 3rd patch just
> finishes the cleanup since I was there and could test it.
>=20
> Thanks,
> Robin.
>=20
> Robin Murphy (3):
>   iommu/rockchip: Allocate per-device data sensibly
>   iommu/rockchip: Register in a sensible order
>   iommu/rockchip: Retire global dma_dev workaround
>=20
>  drivers/iommu/rockchip-iommu.c | 61 +++++++++++++++-------------------
>  1 file changed, 26 insertions(+), 35 deletions(-)

Tested this series on a RK3566 device and this fixed kernel panic/oops on b=
oot=20
since next-20250314.

=46or the whole series:

Tested-by: Dang Huynh <danct12@riseup.net>


