Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711121940A1;
	Thu,  7 Aug 2025 16:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754583143; cv=none; b=OhfYvIkCDb8s/Fkbu+oxm2x03WShb9qcR6tmuzqaxs7X4V1va5bD5Yv7XEm11fd6qfxkRt2F6L74MZaLZcTVd1LdTHUpjIzCZMQ+ChFyi1DY5Nt/MAQYg3J78PXadJNMewIOvau8fhx1vl2TB8PquEFNQUJvR+4ck7ZXAcQkYKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754583143; c=relaxed/simple;
	bh=/+q2AXnRLzK5aHvJtG93842Ok5qFRiN8TlO7/PVAyCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdX0UMMMt8dsmaTwK1/X5dcyJcS3iP5G/9UJ9G16cKyKoVm5Bhqw9xRsx53sqyCp+aJMHmdotTS/NIrbYoNLDBk70Ylz4fstEWHlLUWdyfrHB/nMdZ78gpim0dl3lyj9WDyy1+R/RR1UamjjVdFfyj43P/Gbrtw5z1Ff24zIzEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3T5VzEt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3T5VzEt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A474BC4CEEB;
	Thu,  7 Aug 2025 16:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754583143;
	bh=/+q2AXnRLzK5aHvJtG93842Ok5qFRiN8TlO7/PVAyCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U3T5VzEtIh+hNzmZhjgfrgodQNsfOY/3H5x63x+/3sbJqPd1WSWki9++FG90oi7Bz
	 Nzgdh+EB9lMSZvxDb95HUf37bGE3A2Wars+2ykplCTyGe44EtVP9lz8ndmfM4q6Dmg
	 GcHnb5qDCXPkiXdQCbPKu5B1LeNJR9f1NS0JsKNv+cz3KxGZ/7UtoNxrf0cLNGSiSi
	 /C1f886TtPDq1Mro5sfiYdONzTb36nYXx09rxibt5gIfXJhBUE4Jiz3ZEjepyM2AH8
	 Bne1INAwJeSK6PUvJAvYevY9VQGjf042XU0U5b0rybZSTyJF1woZ36HNZGvZpGDGfM
	 ixdrs684ITpiQ==
Date: Thu, 7 Aug 2025 17:12:17 +0100
From: Conor Dooley <conor@kernel.org>
To: zhengnan chen <zhengnan.chen@mediatek.com>
Cc: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH 1/3] dt-bindings: mediatek: mt8189: Add bindings for MM &
 APU & INFRA IOMMU
Message-ID: <20250807-wreckage-lagoon-0751eb9c53e0@spud>
References: <20250807095756.11840-1-zhengnan.chen@mediatek.com>
 <20250807095756.11840-2-zhengnan.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XfGVipfyRV1J9smt"
Content-Disposition: inline
In-Reply-To: <20250807095756.11840-2-zhengnan.chen@mediatek.com>


--XfGVipfyRV1J9smt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 07, 2025 at 05:57:46PM +0800, zhengnan chen wrote:
> From: "zhengnan chen" <zhengnan.chen@mediatek.com>
>=20
> There are three iommu in total, namely MM_IOMMU, APU_IOMMU, INFRA_IOMMU,
> Add bindings for them.
>=20
> Signed-off-by: zhengnan chen <zhengnan.chen@mediatek.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--XfGVipfyRV1J9smt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaJTQYQAKCRB4tDGHoIJi
0tXRAP9w3SZ+Wbqif+YI4QTQtgl2AqYaAYFFNJG3eEk/UF2fZwEAiE3AAdpOKChr
c7VmkXEwQgqn44SMpM3XoKEhlOX+pAE=
=2DLy
-----END PGP SIGNATURE-----

--XfGVipfyRV1J9smt--
