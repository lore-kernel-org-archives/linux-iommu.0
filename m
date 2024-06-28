Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69C51586F6
	for <iommu@lists.linux.dev>; Fri, 28 Jun 2024 12:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719578461; cv=none; b=sbUjHgSBC+kpLgSOio+6Ye9SkoSBJvJAc3ocEvbMhMOhIa2RdauX7AFqSGkKOrXr+8AHLbM6fCTLA0t48H9KpNSTZcutDmsb4A4k3N6yVeoJBBEzI6ny6+IZ7E6Ul3YAjjqkv+qHetT+Y/x3TUJaOEslsVadnXrWKzbSedTyHHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719578461; c=relaxed/simple;
	bh=bICnReZls0MrKkjCA8zJ3u+312ywetkt85F00cBM/Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qD05tUxEgtGMk8qKnmr49CHtUqpbg3QGpNB7ER9b7Wf2f08pdFYiBGhcvOdqPNJOi7QC8N5ha+Gk1gGjjBXCEjJN/FyzS7V3fJnJmLo/+9H+FyQhk98DIjXv5s0QUll7cHL7NGLaQVpsUS1fuhvi8ypak1W1rESYVNT9w/E5NVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=jsoxR+dJ; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="jsoxR+dJ"
Received: from 8bytes.org (pd9fe9dd8.dip0.t-ipconnect.de [217.254.157.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id BBB541C8929;
	Fri, 28 Jun 2024 14:40:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1719578457;
	bh=bICnReZls0MrKkjCA8zJ3u+312ywetkt85F00cBM/Uk=;
	h=Date:From:To:Cc:Subject:From;
	b=jsoxR+dJiA7+31ql8zhFfpfx1G+LXZIzAI/XMmSMjQbrI8K2o0DIveWltbAxwdXJC
	 QaCgrrNErNbl3eEPFXvB+wTgRHKB87eJELnANTjox8HagmNdiQJweCHrImZtM3RN4D
	 EJ50QcQwPmwEtFbtHuwm5YjFmy5LMe50d2vg2MCru5FvQVPU4cFgEk6zC7ktbm3PpG
	 KzRDgHUHmZ7TF8xE6zWMaOeZtJNiF7k0vh/s4BKgZO0gZImZzvy+lEVFbjjRF/CJ1B
	 9TmAHOhhvt+TGY3UQICiLRwMBnAFI+9LaX6qtHn8stExLjQvPB+2gO9QJSiwdFURwh
	 wWO8IMwMQ3Jng==
Date: Fri, 28 Jun 2024 14:40:56 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.10-rc5
Message-ID: <Zn6vWO1Caf6R998K@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WUFP6s1EtIXwIMDM"
Content-Disposition: inline


--WUFP6s1EtIXwIMDM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

A note: I will be off for the next two weeks and Will Deacon takes over
IOMMU maintenance during that time. I should be back in time for the
next merge window.

With that being said, here is a bunch of fixes:

The following changes since commit f2661062f16b2de5d7b6a5c42a9a5c96326b8454:

  Linux 6.10-rc5 (2024-06-23 17:08:54 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.10-rc5

for you to fetch changes up to 09aaa2d0642359fddae607b6950b2ca7bd1cf04f:

  MAINTAINERS: Update IOMMU tree location (2024-06-28 14:31:50 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v6.10-rc5

Including:

	- Two cache flushing fixes for Intel and AMD drivers
	- AMD guest translation enabling fix
	- Update IOMMU tree location in MAINTAINERS file

----------------------------------------------------------------
Joerg Roedel (1):
      MAINTAINERS: Update IOMMU tree location

Lu Baolu (1):
      iommu/vt-d: Fix missed device TLB cache tag

Vasant Hegde (2):
      iommu/amd: Invalidate cache before removing device from domain list
      iommu/amd: Fix GT feature enablement again

 MAINTAINERS                 |  8 ++++----
 drivers/iommu/amd/init.c    |  1 +
 drivers/iommu/amd/iommu.c   | 12 ++++++------
 drivers/iommu/intel/iommu.c | 20 ++++++++++----------
 4 files changed, 21 insertions(+), 20 deletions(-)

Please pull.

Thanks,

	Joerg

--WUFP6s1EtIXwIMDM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmZ+r1gACgkQK/BELZcB
GuPYIw/+JMjA1uBV/L2txL/ZPCTjYwPpqYreORkJuaW/Oi1UMptvedBFbBqRczhb
5uLGsMzlEMEG0I+OJWgsCWf6O8IefVoY9x25y/DMl0EqkCn8vlh+3gpbjt6FPUVN
Nip5G+gXf/T/k/6CCrDL/At0B6Gz457ve5buxfauyxYnLeVCwGjDo0yqjqtnOlF2
AcEZZ4i3gyHuc1GRSIlEKuwM1Sjy0GP+H/T5CxpTVBVNKrT5/nRJtWHq4Dv3NnWo
X7h5z/AfFQZdroeNho/+5+3JUZ28sjtoRb3qlxVlTffMVQrVJW1cCaWC+hQlrhlq
K9FWFyAXBwqA3tPV2QLgXeacJ+tDTOBIqCzdRLe2xlDkdPAK7lmnCiRCBC6wN9kw
2wZfY8t4Iefq1B4rI7arIXAAwcoyS4Zsq9i+rdMQv9mrHcNzB169/w1ld/Vne3Z+
h+HI5u6DrJA1ufS+mIpf2hol0JsAAcd1H/yG6lk6BFfnFFMCZeghf10F2HcClrKI
wWAx7ZSRjVhwcNeDMfchneHkP9JfoEbCh5igLSSx4bGb5lEpqhUoG/zuvPnm7JSW
kGghta33hXUjzuRKaqtPauz8EJnyWF6j05wdFq1uoZVrLQi86Xk3L/5DP7f9SCpK
N/84kOSF6aJ/RyXHaOfm1TsFVPBmi4ka+BQnQBhw6qfNTbUpUb0=
=opjv
-----END PGP SIGNATURE-----

--WUFP6s1EtIXwIMDM--
