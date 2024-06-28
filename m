Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A66B1BE256
	for <iommu@lists.linux.dev>; Fri, 28 Jun 2024 12:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719579090; cv=none; b=WLnj+r31rXVYgKXEi+94ua2Hbh0Z8hgOZc2gcHF/MSIT42f8rXy9w1KiOckC1apMgEeKv8yPyHTm6GVsa7cfjwO/E16vDgQF60tsz9FM0MyU/okxJVbqgOLT4Wr0oaY9JYYx9nQdVXo2TG39+az4/nE5i6vpSW8cX3KlrzVptb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719579090; c=relaxed/simple;
	bh=jkrV/tAH1sr9+XAPhzGpfX0Mt3iTbqY9tQPaKBaYCsM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EEhVE05TP7duJnC6wIdkyjM8NPhrJ7whyGnCgHbSB9x/gMcs8kjBAOJsBOEOGRo8p2+cmxGb/95Om6nhxzL5afNetDQliPcZsPTDVB//ZAY3XT3XAsfmniQ84lnCPs6PPYprmxGJBwj8ZAsp5hx6+btrU/x9wDMaOawN8CnSitA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=jx//D+0i; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="jx//D+0i"
Received: from 8bytes.org (pd9fe9dd8.dip0.t-ipconnect.de [217.254.157.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id F40491C8A5B;
	Fri, 28 Jun 2024 14:51:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1719579088;
	bh=jkrV/tAH1sr9+XAPhzGpfX0Mt3iTbqY9tQPaKBaYCsM=;
	h=Date:From:To:Cc:Subject:From;
	b=jx//D+0it9qZ7tnENBUWlBqKMxwRD4rbmAlFtoljUEiz3O7Q+KI0Sp9lV1wHFloFx
	 FE5IuCZDrDpJ/QvKBOV32dKWN4lj8LgdWm2Vnz/vmn2y9gHnwfqCkytOv540IbhWrp
	 jD0Tlr3OHHrxQNhery3pBz9s2hZgROUj54KW8xAhNgXK1xaJV4QUNlpU9Vw1TLcu21
	 0bsL3+85TlgqFABVoy/okjArXYnymYsDtjM0lnacJis/6oY2k+ArJ+Ka6cGkTWWcR9
	 FKkt+1dZFddWw6yGHuHBJvcdKshZZln1ECu5Dwy0bFW8CBxe2rryc5BPhK1kXpT/Yk
	 agriEWHNhfqpw==
Date: Fri, 28 Jun 2024 14:51:26 +0200
From: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev
Subject: New location of iommu tree for linux-next
Message-ID: <Zn6xzkJk95d74Cpu@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="X4bMkUxJLuaFhht9"
Content-Disposition: inline


--X4bMkUxJLuaFhht9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Stephen,

Just a heads-up that the location of the iommu next branch is now in a
new tree:

	git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git next

Please use that branch from now on for linux-next.

Thanks,

	Joerg

--X4bMkUxJLuaFhht9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmZ+sc4ACgkQK/BELZcB
GuPiGxAAgRbx7w7NwOsFlPOimf9xk1DNvnFv6o6PhX3KyvukwhAbaWQ2FzExP6p9
4c1DR+doJAJJEbbJh6JRJQuqbbOrVmfqmKTkin8cXiFSR6vb4s+wJDhsZarm/s9X
KcgxlcHnUu8FImqMjqffVBbZUHrZ39qOkejmYZQq2jaj96nIl6RCscrTdbGcK/RB
Azp/mnaWOQ1I87NrDt5Q2obKd7NJS/EPtmrVbNIfGyqVVvudZ1hKmuWPQG5wBQC6
PHcMSqTGFfXIunE4Y8YVun/XA8M++zPVIzXciYyXBnr9Otx2iFE3FqDqkWR+zN8j
TlY6hEm/6o9RiPqKuu8u00hiVwd0cdkkIy+CJHARlG5+fJ9n9QNI/QcwQmVRcERM
NMEFJ1I5RHBoxXXqIGc2d6OEN75xnOc7ylz9uZlYZA7vSdornphyM5vZyue2SPiT
+Gq7g4YSOXogUmuDq8sAI9dBmB/NooKodk9eB/H7Y2Ezdg2Tzy0buHg7m0GKrNUV
c6OB/kbbsiU5DTHdhREZke/aNiflCS4VsfXImBLZvVbiNoH48COV39c8puKj+jhF
60pmEJhqLKkJsojnnV7f8pwcL9Xkndhcush43rGXLW35FNX0NUHVw6ca7jDF+BzT
Td/AA+tvAQY5RICCLYy2VOrSIqjH7l5JKW1yLlxVZKH5etPibWI=
=ogxZ
-----END PGP SIGNATURE-----

--X4bMkUxJLuaFhht9--
