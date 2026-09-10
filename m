Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7157549B5A3
	for <iommu@lists.linux.dev>; Thu, 10 Sep 2026 21:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789077339; cv=none; b=nZx4uy5Aiz3MReJcqMLxwFmdYNI/E1qxont7XzXzFCr6lzx98wT39iDCY0bVTq89UF+h3WMhf13pqT/GalYtAMKPs4XMLodnvRp1QSeA66XlLu1E2awF6uPQloRHBeycM9ixo7JVfVESxjYwtp5aXXVfSMs2ktKklfogheFfZIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789077339; c=relaxed/simple;
	bh=GdeIuycwnqvYXWi2BRgAQmROFIC3Gi7GBEy5FcKY038=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHWHrEXMQPH2QBsLdhwNhtVi3cvnUSiQ69Vhblo7vUbR43objkOYNQO84t+99w6XMYk3J9XPGODNNoWNcdoh23ec22TBMuk3xBryadLuT8F7pqHzb8Jfo52vIqiKmxgw5s+F2AMmfJ12L56LReWnoOJGw9dtJTyhPALgwCHbtO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBTpxRtk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBTpxRtk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159721F000FF;
	Thu, 10 Sep 2026 21:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789077338;
	bh=EBcVPm8Ia66oMJBe0Ug4tIUTXe7c6Tm13It7QGHGULo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WBTpxRtkv2QSdS8yesHeKOJERsWP3nFWyvXzoThcm7vLFsfMMqOO6j86gTSz+dS7Y
	 4MYwrgMfOebMjwY65FnK55sOOQu2jLj8OTz+9FbCBG+CAlPTuwyS4rGFiASN/it1HI
	 9BIo81xXqUXCzRZj+4bZs0ANhONHwF7jgVh/J53YCtYBdt545SVHjvWFKgeYyAuNJ7
	 oATUzpCqN9XmVZI4m6EAi1U22DGJuIrYmax5Ci9YP5fLXD/ZP+stRYIJWjLoX5Jxli
	 clsUr95YMWvUCA4UXUCBnXWu+fJR7IrX11tOaOVCJU4crdJMN60MMb6uAJPCnpFJUA
	 LUc1ZawZYiSkw==
Date: Thu, 10 Sep 2026 23:55:34 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	iommu@lists.linux.dev, Andi Shyti <andi.shyti@linux.intel.com>, 
	Robin Murphy <robin.murphy@arm.com>, =?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>, 
	Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka <sebastian.brzezinka@intel.com>, 
	Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v6 1/7] drm/i915/shmem: Validate max_segment
Message-ID: <aqMmx08W0SHX8C1N@zenone.zhora.eu>
References: <20260902082525.1149367-1-krzysztof.karas@intel.com>
 <20260902082525.1149367-2-krzysztof.karas@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902082525.1149367-2-krzysztof.karas@intel.com>

Hi Krzysztof,

> +	if (max_segment < PAGE_SIZE)
> +		return -EINVAL;

should we also check here whether max_segment is page-aligned? I
think the loop coming later assumes that. If max_segment is not
aligned nr_pages can be == 0, right?

Andi
