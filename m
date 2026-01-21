Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579F32652AF;
	Wed, 21 Jan 2026 12:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768999790; cv=none; b=CvPchPtwZ4SKwrlzX6qv84Jgjq82WzgLiH5QC+WKZSm4J88sxbEpuSUt/nsZvPWcqpBJ9TKvOoTzZvAAv+x9azfQfk5ZAarqKztXfYw2xyc5VdQKQYP/YR9JPCSNK677Jg8PPkmNdi/4nngP51aTPbt4665spC0Lm0jAOa4MsRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768999790; c=relaxed/simple;
	bh=TZAEE2bfkDW5Y0KfmK3vVKETgPoPS2A62ggI96RDyGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vD/LM0dprgw1hAtGj4qtBp9i+W754OWQ74E1PHJ9ombK0QMiSS7X1Vral7FYD9ruCLHHu2WZh50bgtX4RH+R0GC89CH1a7wEOZK+qHDeXHSYCsPwS10utx9gXgir5WybcsHksLpw/kk3OOFmfatTNSMZJs20pFDwjOpRmA7+B64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLdkND53; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLdkND53"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364A3C19421;
	Wed, 21 Jan 2026 12:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768999787;
	bh=TZAEE2bfkDW5Y0KfmK3vVKETgPoPS2A62ggI96RDyGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dLdkND53LnNmYUSRUmZsI1Be/2lbkgohmEflCSbaDyLSfQaGzCO073YuYsY6p8Z9t
	 hkveIKB5v5gIEQv/12AU8pZO2z6ESa3bsEskVLuRShAE8zGaH99+9+w8a/W31IuTrZ
	 3XORZe0/nKn96/pxJ6Q0DMgQu9vr8OIcBUaA2LmPeFuo2aiiy8T9dXc7CAVVAaKZpb
	 6Z7TNwwA7MKVA3zMEAXwxn0MdXdLjSjnn4sPA1Bgu8TTFDr8CyEJZYMWwV7B9lXoEh
	 V7/O4ucSGetlOxnGHycMn2JBPEhPnhp+eDrFp8rBdU3FuBlSQKXI6O/HpbmBtWMjh2
	 8kf/1V97QXoLQ==
Date: Wed, 21 Jan 2026 12:49:36 +0000
From: Mark Brown <broonie@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Wang Jiayue <akaieurus@gmail.com>, hanguidong02@gmail.com,
	gregkh@linuxfoundation.org, rafael@kernel.org,
	Aishwarya.TCV@arm.com, chenqiuji666@gmail.com,
	linux-kernel@vger.kernel.org, m.szyprowski@samsung.com,
	robin.clark@oss.qualcomm.com, will@kernel.org, robin.murphy@arm.com,
	joro@8bytes.org, iommu@lists.linux.dev
Subject: Re: [PATCH v5] driver core: enforce device_lock for
 driver_match_device()
Message-ID: <789030ba-c5bd-4c1d-a10a-2bed4fd76dce@sirena.org.uk>
References: <CALbr=LYt-MqGM0ua78Rt7M679WR9hNnk0Or-WrB2myZ=KhaN0w@mail.gmail.com>
 <20260121085549.165428-1-akaieurus@gmail.com>
 <DFU7CEPUSG9A.1KKGVW4HIPMSH@kernel.org>
 <DFU7SVI5SYE5.3MJP2ECGGZK5P@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y7i6vWCOV1KV+HTa"
Content-Disposition: inline
In-Reply-To: <DFU7SVI5SYE5.3MJP2ECGGZK5P@kernel.org>
X-Cookie: Eschew obfuscation.


--y7i6vWCOV1KV+HTa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 21, 2026 at 12:02:15PM +0100, Danilo Krummrich wrote:

> I assume that this should resolve the problem (unless there are more drivers
> that register drivers in probe()):

This makes sense to me, I guess we can just fix any other instances as
they arise.  Will you send the patch?

--y7i6vWCOV1KV+HTa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlwy18ACgkQJNaLcl1U
h9Drtgf/XYLyS8FqRMreF6uiXEuWYhBPJSBFe2LwCa2hr96dJVzli2V7oiGuJNIq
HTd5PxJlJ6ZU9wKbCtgxzSypn2Q/gAvMrn6hMV+JnDgaf3BtqWxgrE7U39eWFKTj
ZFBamFefM77wAB4PApe2z/Z1QiETNa0Sjqf9NHYqgbxoAzqfrpzybX0PMH5n9ZqF
5LchljDyacD2zpskQWTf97yyxjV0UFU1pt/qcYn1eMdyXqgG68b/NoWb3/981mo9
4kUmaxMHgzKGWauckjfnhTrr/IX1Tpwyi6r767EJINv4YI6jLiKXdJd8Y0MaAuEz
l4RAphnF/u2b0G2MYifJj77o27izTA==
=gufS
-----END PGP SIGNATURE-----

--y7i6vWCOV1KV+HTa--
