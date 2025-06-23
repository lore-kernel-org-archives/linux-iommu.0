Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2E528E607;
	Mon, 23 Jun 2025 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750695305; cv=none; b=jOqNGhbuG2UdrRuF6rhrkiYpEFCe0PmOp7uh7Jo5Awuj3dLLX8hzNHa2OmwJedUAXfdPr1TMXoHTXAD4j9jZ3TFlZRnRbx08bbDleKWJ7oQbGF1YZ4R7rq8SjxKBhWPkdWyEXOYXsiUYF3yLvXV3e64ZairgfDv7oNE7FNo00l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750695305; c=relaxed/simple;
	bh=V2trAmon8nMb/3Uqjyt7L8fDFnJFLh9kd6estMca12A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPW6JX+0voBpiuvwJqY5su+pOnvLWI1COu2lQOSbWGMEEdtCwfz4f6ke/VJbzcVvcgUSZ0lK0o5hSxy1uynD+fslVzmESJrH5RJIBs/AKjgEdYqt4r2I6idoRVstpfgHHgt7hq6UwuHFdnleOKF09Niy1VnZ1ovco2tm2fSIQ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUAHjfHZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUAHjfHZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A605C4CEEA;
	Mon, 23 Jun 2025 16:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750695305;
	bh=V2trAmon8nMb/3Uqjyt7L8fDFnJFLh9kd6estMca12A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oUAHjfHZ7wP9z4uLcLWdCsGlRAA4mxsqG924jEqzyw2M4VNvHQLkW7/XaK7eikRNx
	 nuWsZ4xTYXzcS1qpM0N9dUaJ5KvuHA9WdHnn+AfPFA9M9TNy0FWPw7mfibWHHaEnWs
	 0dVf7wJFCv8zWmjdrMg08ri9taKDKJFerpwqYC0Qq/4xJnmX8Hv4EVlbbJuWIWGC3V
	 aZ2uG/9IAJkd3CvKEU5RPBpEXiqNVnaHrc6udpbJ1s6JVTLew1crDKD2WQ/LYiRCYB
	 qCYU/TGhbcHB4MaAX6QB7kQXaHSAZuBSKB/QUcE8iZm+78j+xLUA5And5xhy37VDMc
	 kbKr417JlXlZw==
Date: Mon, 23 Jun 2025 17:15:00 +0100
From: Conor Dooley <conor@kernel.org>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
	nicolas.dufresne@collabora.com, jgg@ziepe.ca, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v4 2/5] dt-bindings: iommu: verisilicon: Add binding for
 VSI IOMMU
Message-ID: <20250623-squiggly-unopposed-8b0ca15adbdb@spud>
References: <20250623153931.158765-1-benjamin.gaignard@collabora.com>
 <20250623153931.158765-3-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RBUMPEX8/HmZilKF"
Content-Disposition: inline
In-Reply-To: <20250623153931.158765-3-benjamin.gaignard@collabora.com>


--RBUMPEX8/HmZilKF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 05:39:26PM +0200, Benjamin Gaignard wrote:
> Add a device tree binding for the Verisilicon (VSI) IOMMU.
> This IOMMU sits in front of hardware encoder and decoder
> blocks on SoCs using Verisilicon IP, such as the Rockchip RK3588.
>=20
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
> changes in version 4:
> - rename and reorder compatibles fields.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--RBUMPEX8/HmZilKF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaFl9hAAKCRB4tDGHoIJi
0jBSAP0QEA7xsWu1uTUJGvGMxKQiDolLdO1bwbcDbNWauJJweAD+MeNwvPqaJfCo
UGWS8QtxVnFJeDPlL0cimI/NBdYjFAM=
=8bDY
-----END PGP SIGNATURE-----

--RBUMPEX8/HmZilKF--
