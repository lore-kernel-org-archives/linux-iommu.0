Received: from smtp2.tecnico.ulisboa.pt (smtp2.tecnico.ulisboa.pt [193.136.128.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD9A487B5;
	Tue, 23 Jan 2024 14:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.136.128.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706020805; cv=none; b=JjdJVXo6N6Y4/SWKtmJmLu49tMycuamecS0oXIa2BbO8WtMi+EA/GCEBVj2NmGF2iTLBCyi0x2WrRx6UojQtbh5x+XqacYWvxLgOMfshIGhYoZFHV9qG4vQn2qz2XshBfIVgzL2t6dKsNqAIZy/KZu3KQcEn1NpkEukarV5brSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706020805; c=relaxed/simple;
	bh=geXUTKN6WxvkrQwIGjvwQvSWbrj9fA3lQKc68o2nOPw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eadnukNXGlb14LnjhB541/+Loy5vOea5I5Q3ppdzIw9jDkvkRrZQEsN1CO6tMT4qovRSnAenjYtQMiLjYhNPz2QlzB+iUjModCvn24kwZWaqmWeeDCbMB+gm8VGaHtCjByU35x67fYicBLBKtNCRWR7YV17GM0KbNVRkjC9R8Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt; spf=pass smtp.mailfrom=tecnico.ulisboa.pt; dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b=BOIztV26; arc=none smtp.client-ip=193.136.128.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b="BOIztV26"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp2.tecnico.ulisboa.pt (Postfix) with ESMTP id EBD882454EA;
	Tue, 23 Jan 2024 14:33:29 +0000 (WET)
X-Virus-Scanned: by amavis-2.13.0 (20230106) (Debian) at tecnico.ulisboa.pt
Received: from smtp2.tecnico.ulisboa.pt ([127.0.0.1])
 by localhost (smtp2.tecnico.ulisboa.pt [127.0.0.1]) (amavis, port 10025)
 with LMTP id n3MKfo8jXhza; Tue, 23 Jan 2024 14:33:27 +0000 (WET)
Received: from mail1.tecnico.ulisboa.pt (mail1.ist.utl.pt [193.136.128.10])
	by smtp2.tecnico.ulisboa.pt (Postfix) with ESMTPS id BA775245560;
	Tue, 23 Jan 2024 14:33:27 +0000 (WET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tecnico.ulisboa.pt;
	s=mail; t=1706020407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=/kGm+VtOF1KrX9lmF1tN1QPzLAtucWUIbb06niKSR4g=;
	b=BOIztV26q3HLrunz2dWjmir21AxATLAH481eF458N1Uj6YKiQZpTgrmTDFP+rQ0nlUCA0t
	shmvhsUg+DLfUNmLNzOXAaz0+kR96lL8+HqbQ9fw35OIGetOM+FUB8nyR8Vkeknek4CKg6
	loxEoBq2cvSWlpCq6OFvxnm4wKhqLdw=
Received: from diogo-gram (unknown [IPv6:2001:8a0:7ae3:e700:a921:1147:531c:b1e7])
	(Authenticated sender: ist187313)
	by mail1.tecnico.ulisboa.pt (Postfix) with ESMTPSA id 8316C36007F;
	Tue, 23 Jan 2024 14:33:26 +0000 (WET)
Date: Tue, 23 Jan 2024 14:33:15 +0000
From: diogo.ivo@tecnico.ulisboa.pt
To: thierry.reding@gmail.com, vdumpa@nvidia.com, joro@8bytes.org, 
	will@kernel.org, robin.murphy@arm.com, jonathanh@nvidia.com, jgg@ziepe.ca, 
	baolu.lu@linux.intel.com, jsnitsel@redhat.com, jroedel@suse.de, 
	linux-tegra@vger.kernel.org, iommu@lists.linux.dev, regressions@lists.linux.dev
Cc: diogo.ivo@tecnico.ulisboa.pt
Subject: [REGRESSION] Failed buffer allocation in Tegra fbdev
Message-ID: <bbmhcoghrprmbdibnjum6lefix2eoquxrde7wyqeulm4xabmlm@b6jy32saugqh>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commit c8cc2655cc6c in the recent IOMMU changes breaks Tegra fbdev
at least on the Pixel C with the following error message reporting
a failed buffer allocation:

[    1.857660] drm drm: failed to allocate buffer of size 18432000

This error message is printed from tegra_bo_alloc() which is called by
tegra_bo_create() in tegra_fbdev_probe(), which may indicate that other
allocations would fail as well, not just the framebuffer.

This may be connected with an error in of_iommu_configure() that
became visible after commit 6ff6e184f1f4d:

[    1.200004] host1x drm: iommu configuration for device failed with -ENOENT

Best regards,

Diogo

#regzbot introduced: c8cc2655cc6c 
