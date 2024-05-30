Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EFD186E32
	for <iommu@lists.linux.dev>; Thu, 30 May 2024 13:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717077475; cv=none; b=Z+P+D1hTTnZXV8yvvW/YXLmUQTEZzRlEgxjSTCs1QxTntNARF2q7q0iOhN9DVA7WPVW3joUcFJesV0qRFiKKB/u6Rx8OlBjZ+2ZrCv5ptnGFvKZhIlvJtX+IehN7y6jDUgUNmi6WQ6rxcBnctE6dmYZpSZM5RRQO3hBRld98S7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717077475; c=relaxed/simple;
	bh=QDntA1S0rAkOvUWk+cA+zU1W2OoXJoWTyxaYlclJXLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ns00ovPA8fmIxavFr9oUKUmDbCVUacjZ57TpY8g6X4im4/yLxabvu3XIkT8mH7Pi35kRj0HAXwN3kX8kLXi9Z5Kk4afYaUjvODX5GaBbNgTDxCf1d06tS7lg55BMKM0yw0VvVoaFni+WRKRSurlcMZWoEpnzamIneTOBMMycaqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=tEdvQrUJ; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="tEdvQrUJ"
X-Envelope-To: dwmw2@infradead.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1717077470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=iYx9c1xO6ymLn++WbU9EryJwaaf+Egf1PM7t6JATVVE=;
	b=tEdvQrUJCDGwkhjgDLHFl5013LSVfpYxUEM2V6mB15RlpVz/mJ61stZUY3HwiUaiS6o5dY
	jBffWrjInvuDPufAKBXkY7uQkxel9vH7/VlbxIVbmlYwTtXMsxtnP0oG4G2ZV18TRwHuzL
	2XeaYyPXBzX4JPjqW2+klx6A3Yf0adMBbmhoe5ndCNX8v6lWSLSKv/sXQ+w1aeNxpkORUD
	0O0I4erOTQYs3FM66m6jtek8CT1d952QtfYqzapf8qyCnRiD8O4MZLUwT6gUnjQuHiw0XG
	o4xSA4gqFqFgOvtw88BVWeIo2tgZ3+SzkZK9DdXBXQDILrb0l2piLL2mvkkeBg==
X-Envelope-To: baolu.lu@linux.intel.com
X-Envelope-To: joro@8bytes.org
X-Envelope-To: will@kernel.org
X-Envelope-To: robin.murphy@arm.com
X-Envelope-To: iommu@lists.linux.dev
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: didi.debian@cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Diederik de Haas <didi.debian@cknow.org>
To: David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Diederik de Haas <didi.debian@cknow.org>
Subject:
 device_def_domain_type documentation header does not match implementation
Date: Thu, 30 May 2024 15:57:38 +0200
Message-ID: <14311965.TaHA55BQu8@bagend>
Organization: Connecting Knowledge
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3343604.Wtvs3CB2mS";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Migadu-Flow: FLOW_OUT

--nextPart3343604.Wtvs3CB2mS
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
Date: Thu, 30 May 2024 15:57:38 +0200
Message-ID: <14311965.TaHA55BQu8@bagend>
Organization: Connecting Knowledge
MIME-Version: 1.0

Hi,

While looking into ``drivers/iommu/intel/iommu.c::device_def_domain_type`` 
function I noticed a discrepancy between the documentation header and the 
implementation.

``@startup: true if this is during early boot``
0e31a7266508 ("iommu/vt-d: Remove startup parameter from 
device_def_domain_type()")
removed the ``startup`` function parameter

returns ``IOMMU_DOMAIN_DMA: device requires a dynamic mapping domain``
28b41e2c6aeb ("iommu: Move def_domain type check for untrusted device into 
core") 
moved the possible return of ``IOMMU_DOMAIN_DMA`` to ``drivers/iommu/iommu.c``

But neither updated the documentation header.

Cheers,
  Diederik
--nextPart3343604.Wtvs3CB2mS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZliF0gAKCRDXblvOeH7b
bn8AAQCiDxcxgUIErkiC9QpJNmPLh6SlxKa2ytIrBp/fqzJBpAD+OOGPlgXUq0ch
pUs535Ep1y8OsfvhKt16hBWvJC2dIAM=
=/+oC
-----END PGP SIGNATURE-----

--nextPart3343604.Wtvs3CB2mS--



