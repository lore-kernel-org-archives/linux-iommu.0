Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6380843CE6D;
	Mon, 14 Sep 2026 10:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789382483; cv=none; b=QUEISheEf0hBrKJqrrDwfuVs+8Gve5xS/GF3Up9ZKqqyXg7aEEaIY9ChyxDHg/OzCDUGU9sV2xTBDRcash615iZ3Un3DkvDmdoeJr9LJmwsA4BwBBAN9sgbOw0jPksY9v87Ybx8+SHA8x42AB9EhAUeZJEiHDXR1eY4hQf0iWSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789382483; c=relaxed/simple;
	bh=VD5+dnKwxN3gQ837DuD8GmCLdkSGJUHg5yksucA26Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PEwHfhBINLpUydaBYGcg/M01wBckFpdCYkzK/Ocg83gTZwFrk6+RNy+nCTlqoVvDuwCjQVZAo8VDrronqO7mcQVHY/fqI333lgslLLsafcjP6sn//qvHkRN5p8IELuUXi8qUhwpjNiN1HMJjhnDMErfnuBoc6qgFAS9OSRvGB4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=ts8EaFng; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="ts8EaFng"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VD5+dnKwxN3gQ837DuD8GmCLdkSGJUHg5yksucA26Ws=; b=ts8EaFngOdljHS6oD+Lktxvm6i
	ZsRmoTdkxEyt5HW0rYKBAeQ0yzYn5zzjiokXYmHM4Bxz7YYK+aDk+k6n1p5+ceacoasfsdd1QDmEo
	Z36xzbouEs8+37FhrezG1YVUDXyemEdFmtiWmEIzB1cdZcWSIQsKo0apu7tNAXmrGvTJ6+q3xJbrd
	B112129JJoZBKipZRuKTUvwXRqx7b/EpRoqbcJyMqgZ3hMP692a2hia1gnZdS1lq8gS7ghJVQxlN2
	KpeEakJp+Nvtw1ch3qeF4fzAa30clb3vJAgrcx+olhY9YRBa8CbYK/5M71VlEO5caAxq+QRFFAKgm
	eR5p+nnQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x647Z-003Yeh-1O;
	Mon, 14 Sep 2026 10:41:09 +0000
Date: Mon, 14 Sep 2026 03:41:04 -0700
From: Breno Leitao <leitao@debian.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org, 
	praan@google.com, kevin.tian@intel.com, smostafa@google.com, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	jamien@nvidia.com, kas@kernel.org
Subject: Re: [PATCH v10 00/13] iommu/arm-smmu-v3: Adopt the crashed kernel's
 stream table for kdump
Message-ID: <aqfPKIeO4lWCHlQ3@gmail.com>
References: <cover.1788130528.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1788130528.git.nicolinc@nvidia.com>
X-Debian-User: leitao

On Sun, Aug 30, 2026 at 04:18:01PM -0700, Nicolin Chen wrote:
> To safely absorb in-flight DMA, the kdump kernel must leave SMMUEN=1 intact
> and avoid modifying STRTAB_BASE. This allows HW to continue translating in-
> flight DMA using the crashed kernel's page tables until the endpoint device
> drivers probe and quiesce their respective hardware.

For the whole series:

Tested-by: Breno Leitao <leitao@kernel.org>
