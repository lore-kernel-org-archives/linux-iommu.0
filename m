Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D417C1F941
	for <iommu@lists.linux.dev>; Thu, 30 May 2024 16:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717085203; cv=none; b=dMHv+0t2/J1+S3Z9Ckuhbl9omjB0Z+TG4jzh6hYIMCRQodIIr/dzSgj45OEMvYfOC6PEoOPK+9a64JacLAjSJMHFh4dqAvwOkN2X6p7dWhM81S81FPV3Xv7C5+98f9x8nPAA9hhu6m2LaDv8pEaCJ0AooqpgpzTdM2hWh7S0HpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717085203; c=relaxed/simple;
	bh=igK53oKZs0m3P4rVmp44qLs1z5GN+0iaY7oPimwHm94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PPxnVYVGiOW4itl+6SQaAfPYAtu6/QPk/x5VgUlIPeK7dpJhHx5XgRwtSWDsPJptfLnw8ntWuvFdzBKLl7MSjpsniBtVx6F/avFMV9F1AKCerSbuW6svjTpOSDPSNigGSgQNF/v5IrNdZhieBAgSI8Ptq19qwiAP49b+hX8QqtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=wJUjrLy3; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="wJUjrLy3"
X-Envelope-To: dwmw2@infradead.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1717085199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IkpVVDRX1kDDM7sB/ftX6eW70ixX7+jS9JUBqKb15n0=;
	b=wJUjrLy3+2YiSEmerSzsjcDhbkaXpdtrpPwmGMMDOZDkItwg70GrvtwzxJK0wKVgh0e7/m
	3ce3L7Chl6StsARzeBpqpB6y7AdPIMjMgvmEkdbJuu1ttXUSsuJfgWdTOF/bYBpFpu0IbT
	wePPsWbPsc0sa8cN4HC2lbixG02k3CRNnib99bHrTewWIox6YYQ1Mwa5e4mV/qGwIQHpnk
	2E1MRk7Ka6tKfqOV+dfQU5pdMauHluYpAJn+0RMyQ0mOi8+DoDcRLmfIh4oaZUbNLcq+yY
	2CCJ+rkKB7vQiZCMYv6qFuFkgfL4Vnw14SoCvcL29/J/VI+g2q80RJZv9tKDmQ==
X-Envelope-To: baolu.lu@linux.intel.com
X-Envelope-To: joro@8bytes.org
X-Envelope-To: will@kernel.org
X-Envelope-To: robin.murphy@arm.com
X-Envelope-To: iommu@lists.linux.dev
X-Envelope-To: linux-kernel@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Diederik de Haas <didi.debian@cknow.org>
To: David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject:
 Re: device_def_domain_type documentation header does not match implementation
Date: Thu, 30 May 2024 18:06:28 +0200
Message-ID: <4190999.HFuNgkhpQd@bagend>
Organization: Connecting Knowledge
In-Reply-To: <32921840-43d6-4ad9-99eb-aac32e67e04c@arm.com>
References:
 <14311965.TaHA55BQu8@bagend> <32921840-43d6-4ad9-99eb-aac32e67e04c@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1915108.mHXZh0l9D7";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Migadu-Flow: FLOW_OUT

--nextPart1915108.mHXZh0l9D7
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Thu, 30 May 2024 18:06:28 +0200
Message-ID: <4190999.HFuNgkhpQd@bagend>
Organization: Connecting Knowledge
In-Reply-To: <32921840-43d6-4ad9-99eb-aac32e67e04c@arm.com>
MIME-Version: 1.0

On Thursday, 30 May 2024 17:49:17 CEST Robin Murphy wrote:
> > But neither updated the documentation header.
> 
> TBH it could probably just be deleted now, since the
> iommu_ops::def_domain_type callback is properly documented in iommu.h,
> so individual implementations shouldn't need to repeat that. It's also
> never been actual kerneldoc either, since it's a regular "/*" comment.
> Feel free to send a patch :)

I leave that to people who actually know what they're doing (I'm not a C dev).

Cheers,
  Diederik
--nextPart1915108.mHXZh0l9D7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZlikBAAKCRDXblvOeH7b
bsBxAP47912RndyJocsLNJoEMtgERD+mtcFij9xDHF+dH6cfXgEAjHH7PN3HG1To
57bH4sJEkpYWrgJAGoLMm8LJRjfkwg8=
=3PQZ
-----END PGP SIGNATURE-----

--nextPart1915108.mHXZh0l9D7--



