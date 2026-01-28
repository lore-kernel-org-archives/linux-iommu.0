Received: from mail.sig21.net (mail.sig21.net [217.197.84.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA763491C2
	for <iommu@lists.linux.dev>; Wed, 28 Jan 2026 09:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.197.84.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769592686; cv=none; b=qQT4K0QJyp7D0Rd3K1EcS2HHyru9t1b3zKFL6a3Lo7JAcPfNnhXxovci5fVfCaWin7t3Dr88JVLUAGZ8joQPIFitWm85bIkfszppD2UJa4ixA+xnwT5T1RVkIAQQyEpnuvMBgrZRfdY08ZINJGzBCr+UfB9PIlgdYc74fYadWsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769592686; c=relaxed/simple;
	bh=Bs2t6NndeoPUj9ywYUH0i8prBpp2P3jZx+zuGb+VLp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JoES9xH9mbHcUM2GWf6+CpRFDHhN5BVxBnVySlxO2Ozg+iyQghzkiCRMc9MxR+cOmfQ2iwN3VD5gGJ1Ajm4ldG33jSMrJ7xl2BTTT75i31EVwy4lsoMb80cna9OJ/2K+MDukSBMm/onP5ODXOQ+8skhdhJuwQ4vMjIuaznZjAWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sig21.net; spf=pass smtp.mailfrom=sig21.net; arc=none smtp.client-ip=217.197.84.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sig21.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sig21.net
Received: from localhorst ([127.0.0.1])
	 by mail.sig21.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	 (Exim 4.94.2)
	(envelope-from <js@sig21.net>)
	 id 1vl1tK-0002gJ-3W ; Wed, 28 Jan 2026 10:31:14 +0100
Received: from js by abc.local with local (Exim 4.99.1)
	(envelope-from <js@sig21.net>)
	id 1vl1tH-000000005AM-33fX;
	Wed, 28 Jan 2026 10:31:11 +0100
Date: Wed, 28 Jan 2026 10:31:11 +0100
From: Johannes Stezenbach <js@sig21.net>
To: iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: AMD IOMMU issue with hibernate on Asrock X600
Message-ID: <aXnXX0P-XsEFPlJd@sig21.net>
References: <aXeAOtGQUdlNZF6V@sig21.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXeAOtGQUdlNZF6V@sig21.net>

Hi,

I was hoping to get some response.

TL;DR:

> [0.000] [  343.790320][ T4340] WARNING: drivers/iommu/amd/init.c:952 at amd_iommu_enable_interrupts+0x4c8/0x550, CPU#0: pm-hibernate/4340

- is it Linux or firmware bug?
- if Linux bug: please let me know what to do to help debug it
- if firmware bug: what additional tests to run; how to add a quirk

What's the downside of amd_iommu_intr=legacy? Does it only
affect kvm guests? What's the relationship with x2APIC?


TIA,
Johannes
