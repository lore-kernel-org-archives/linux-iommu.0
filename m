Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DE42BCF4C;
	Mon, 22 Jun 2026 16:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782146295; cv=none; b=NE4o3P2D21c08jtcxkYD26hh/jov9l3Km+phQpkKd4GZdakOlj6ebaVFRIVUgnM6/K5CpjzwkuhOGn2+6D5WqPbmGDIrb+00tTgjZdpbuAw29HvwugY2CQmZ52g9dPLsjIefRKeofxlGtVmHOy3w+xn+Z7VrAfMC0HnQ4QYfnV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782146295; c=relaxed/simple;
	bh=MU6NEnvcLJQdqEo/CvT3g7zOZc+phxAEbCp+Y+NUkKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eq9Ni9cJNl/mZFAKTIyWPPElkfpy1AYdVVg+9W7ua1FeCsZds+m66PYaGmGvo1bsXKDKOOje/XlGwvo2NPh2FUq6p4W4V887TP582oi2gytrRgWLtxA35rOsbovyK0jfyfuI16LP6DF7OdOPzywORXbzaLaZ7cYIajl+SvCOiec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8naGZ/z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8naGZ/z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8D91F000E9;
	Mon, 22 Jun 2026 16:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782146294;
	bh=MU6NEnvcLJQdqEo/CvT3g7zOZc+phxAEbCp+Y+NUkKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L8naGZ/zN8Z/ZE7q8bd211dML4/nswb3UZsXt1MJL5Ugq3DvhfWeLKY7tCrKTmOiD
	 IWIILAt5BLFKjxmpGLNxZ5ezMCOM7DVQZ04cNm/gEENa6ovMibbZmJ6CjeHom/6bG3
	 a+RTqJaYUn8QdOvXsJ1bdHjNo373JJs+KQAPjI+NUWKFuQQCr9KgisHUp/9hXxljhm
	 ggwJkojecCgIi6DLvpvp9g4GS/rUy1DoHY4UdPYNsZgp2SIkdlh6y1uxzKNfgnpsMn
	 vr0eMrQvDc/yPAJBKNfSQGZtMkIzZFsJEQqVMuTrn6OPci76Y+83XSLcIrHYQMSuRA
	 4spKOQOXA2mhg==
Date: Mon, 22 Jun 2026 17:38:09 +0100
From: Conor Dooley <conor@kernel.org>
To: Ashish Mhetre <amhetre@nvidia.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, jonathanh@nvidia.com,
	thierry.reding@kernel.org, nicolinc@nvidia.com,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iommu: Fix interrupt type in example
Message-ID: <20260622-copilot-unsettled-36e0d760e648@spud>
References: <20260622065410.2780215-1-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s6/WOd/jhXlza5TK"
Content-Disposition: inline
In-Reply-To: <20260622065410.2780215-1-amhetre@nvidia.com>


--s6/WOd/jhXlza5TK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--s6/WOd/jhXlza5TK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajlk8QAKCRB4tDGHoIJi
0k6dAP9zknucMIytzhaCS0nqL9cl1+PMI5xLFGL0cD9FD1O4fAEA+usVLqK72Zv+
KGNKlCoj0H8xkFD2fOscVAkY5mcB0gs=
=U63z
-----END PGP SIGNATURE-----

--s6/WOd/jhXlza5TK--
