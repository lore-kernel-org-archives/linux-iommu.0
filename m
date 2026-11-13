Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590949;
	b=SZHWPs+Ypg5ySp5xKY5h2kNmYO1doE/1zyZ/CpupZWEBXNIM+pgusTs3dT3emgJ4yY8S
	 0PCZau76DSZJd4+yP53VVukfLHP41noOlLdlufzGaaixpj4y3NYXQRZFYaknlH1jnw74K
	 OjngLym5rr45zPkd/YPhpkjxc/AuYPNfORqpLK+Y9XlnGWZ+Jhxm/GCY0jfhWpoFCBNoa
	 zpgdfttWtYmX8LXRIKv0GtYcgLr9Er+73L9gC2ZHVrbywxLfy71OrrJ7Lyn6Xnp1Iz/Kk
	 ZIqYqIIycL4Vk/qz+lmtlFUP6SR+a8rgLoHEc0ERw/rj5AppKWB1MqNoJPFrgwkYYmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590949;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Organization:Content-Type:
	 User-Agent:MIME-Version;
	bh=vBhwvnJwnGkD1bnGzWjsQ07Q3jEMP9wwPRehR7yowkU=;
	b=0v+3EC8CuNW+OGUVBjsXw4us325uvZbjkLo9SOiPbgkr/2bLKUxgIpygnFAchXXO8ZcS
	 5/Pjpym34nGKJrE10xyydUAVN1C+YCcp0FS5mEfmHdn2TIxEDFeZorY+Kqzxq9wzv5ymO
	 aCd0FUFVIIntQwZg086/Yxui06Kqk/Aaue9LfhLx2yHvYvpl3xwDIPDMH1M+brmuxmEfs
	 YWgPk/vqBktovcUYr6KlZ2TYjBO/rPWYJxH7seWkngnyWxs20oDyT9OIeQZjj9spRxXvl
	 B4bEf2bVLKhYUsD3jYSHqYu6AZo8rM014/jek5/g8JlG1+sx5yl+2H1knx8vzSD8dNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b="AejoD/JD";
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB11606B460
	for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 17:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CB11606B460
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=AejoD/JD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794590946;
	bh=vBhwvnJwnGkD1bnGzWjsQ07Q3jEMP9wwPRehR7yowkU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=AejoD/JDjkToIWQiFRpmdMjB5o5Ebnp4DTGINsotDpycE2//JGqe68DRdgkmUOFvT
	 HaEx1jaGfhcD4LWL7zJDHE40LqDKXD5nusxhqINjW9b1KWPzLf/U+m7yC38cnIcNjp
	 L+IDGtMOKf0Yb1mY3g8SCzdbTliiRMz/B4binh4sWmYBp2oHFiNcXkmqq/dcPgPjtz
	 3+S91Mq8JKXEqYTCiaOnULObQ/dLWTHZdrHKI64Qv4zhar8O9FyNczcE4k82NlKtop
	 yLC5Fggr21g1QSNN/46q7Au6xg+DZevA5WYuBhcpSUd54h9hy2Z5zMVuSnA3nvKig/
	 ker449JmvX29g==
Received: from [100.64.0.214] (unknown [100.64.0.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 75E9717E0818;
	Fri, 13 Nov 2026 18:29:03 +0100 (CET)
Message-ID: <7691572c6787c3808296094fb97212979c3fb3b9.camel@collabora.com>
Subject: Re: [PATCH v3 02/12] media: verisilicon: Check the match data in
 hantro_probe()
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: aiyengar1990@gmail.com, Benjamin Gaignard
 <benjamin.gaignard@collabora.com>,  Philipp Zabel <p.zabel@pengutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring	 <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Nicolas Frattaroli
	 <frattaroli.nicolas@gmail.com>, Andrzej Pietrasiewicz
 <andrzej.p@collabora.com>,  Ezequiel Garcia
 <ezequiel@vanguardiasur.com.ar>, Hans Verkuil <hverkuil@kernel.org>, Jernej
 Skrabec	 <jernej.skrabec@gmail.com>, "Joerg Roedel (AMD)"
 <joro@8bytes.org>, Will Deacon	 <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>
Cc: linux-media@vger.kernel.org, iommu@lists.linux.dev, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sergei
 Khomenkov <shomenkow@gmail.com>, Tharit Tangkijwanichakul
 <tharitt97@gmail.com>, Sascha Hauer	 <s.hauer@pengutronix.de>
Date: Fri, 13 Nov 2026 12:29:01 -0500
In-Reply-To: <20261113-hantro-robust-v3-2-82383c722ad2@gmail.com>
References: <20261113-hantro-robust-v3-0-82383c722ad2@gmail.com>
	 <20261113-hantro-robust-v3-2-82383c722ad2@gmail.com>
Autocrypt: addr=nicolas.dufresne@collabora.com; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPoicBBMWCgBEAhsDBQsJCA
 cCAiICBhUKCQgLAgQWAgMBAh4HAheABQkJZfd1FiEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrjo
 CGQEACgkQ2UGUUSlgcvQlQwD/RjpU1SZYcKG6pnfnQ8ivgtTkGDRUJ8gP3fK7+XUjRNIA/iXfhXMN
 abIWxO2oCXKf3TdD7aQ4070KO6zSxIcxgNQFtDFOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzLmR1Z
 nJlc25lQGNvbGxhYm9yYS5jb20+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4
 AWIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyyxgUJCWX3dQAKCRDZQZRRKWBy9ARJAP96pFmLffZ
 smBUpkyVBfFAf+zq6BJt769R0al3kHvUKdgD9G7KAHuioxD2v6SX7idpIazjzx8b8rfzwTWyOQWHC
 AAS0LU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPoiZBBMWCgBBF
 iEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrGYCGwMFCQll93UFCwkIBwICIgIGFQoJCAsCBBYCAw
 ECHgcCF4AACgkQ2UGUUSlgcvRObgD/YnQjfi4+L8f4fI7p1pPMTwRTcaRdy6aqkKEmKsCArzQBAK8
 bRLv9QjuqsE6oQZra/RB4widZPvphs78H0P6NmpIJ
Organization: Collabora Canada
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Pk9ID3Lh5PcmffxfFbdz"
User-Agent: Evolution 3.62.1 (3.62.1-1.fc45) 
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

--=-Pk9ID3Lh5PcmffxfFbdz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le vendredi 13 novembre 2026 =C3=A0 16:40 +0000, Arun Iyengar via B4 Relay =
a =C3=A9crit=C2=A0:
> From: Arun Iyengar <aiyengar1990@gmail.com>
>=20
> A device bound through driver_override may have no OF match, and
> hantro_probe() then dereferences a NULL match. Use
> device_get_match_data() and fail with -ENODEV without match data.
>=20
> Fixes: 775fec69008d ("media: add Rockchip VPU JPEG encoder driver")
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

--=-Pk9ID3Lh5PcmffxfFbdz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCavdI3QAKCRDZQZRRKWBy
9L/GAQDFEJMjaukjIL6hsPbVKhY3JdjK2trma5iMW2z5o4dWmQEA0jyOVzJ7q5zj
M7YvozDsuHiLH1Y/S548p4WbG4GM4QQ=
=YkKR
-----END PGP SIGNATURE-----

--=-Pk9ID3Lh5PcmffxfFbdz--
