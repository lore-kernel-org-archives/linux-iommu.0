Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7853C10B6
	for <iommu@lists.linux.dev>; Thu, 10 Sep 2026 22:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789078283; cv=none; b=UnNNMZjqc0miuCtbcOu5gR/w3j7bd3K41jMttd11gKNjWJ5eA+m7yxtcmrFnSvHgAEXkSjtLqu4IE0lE9NRA4onMldqE+woo+//i5v6BpgtS4YmgkdFJGX0B9AF4FRpHJVlf4t1A2zwAmZ9w1YzQMeplSB94XVinASgYGIpDB3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789078283; c=relaxed/simple;
	bh=4UX4QsU0keKJktPln6e0LPXyexMbygZdh3lAcrEKwGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlxBGGZ+Tb+xgJ7nUIU/SyAUDqMGx7tn96NroBz0lgNLSXZUGDaaCB7kSUn7WH0sqFkZ43QNeHlXJrF3L3nBB4gSvTgNL4KU4GtyRAZaFXd6ubHRu+BB8HWt1W7bL7cwNQahawXiTCXK9epRDCXCV2vUKCXqa+Iyvbx8rjrADLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXPkwHBa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXPkwHBa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676B41F000FF;
	Thu, 10 Sep 2026 22:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789078282;
	bh=wWZZV6M2jtgvgSqhCuTmOOsoAMFv5dTKINEq4VrrVro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YXPkwHBa8wk6+BvGiegPvHIC9Juu8B/WxOxoh18kcXtSpPSUeEk8x59doiyU3btI5
	 mjz4X5a+ZIbxW4YuY3n9pqXIeVkx8YbKW906NbJb/nKLonOSaX1z+vtf/iqNyONc6S
	 qgplt/2p21v7Kd/9wKqfBGUASN1APT8GifGix4EE8FFRm8joOl+ZIbwUJPhoFawDCz
	 Yevki3TNreFNGoyCErtj7/azRYMlBLLSHiXQD/o6JCADIgAZACZFa14VyuZUAPjxLt
	 Uju4lvNwQVMwCrikFhy+IiIcjJWpfUc6IBBdaP1IbL4iYVNHs5wji9eA5jdSMFvUGn
	 NqAtCWvzB7c5A==
Date: Fri, 11 Sep 2026 00:11:18 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	iommu@lists.linux.dev, Andi Shyti <andi.shyti@linux.intel.com>, 
	Robin Murphy <robin.murphy@arm.com>, =?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>, 
	Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka <sebastian.brzezinka@intel.com>, 
	Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v6 3/7] drm/i915/gem: Free sg table on failure to acquire
 second folio
Message-ID: <aqMq8d7aEedeBn8V@zenone.zhora.eu>
References: <20260902082525.1149367-1-krzysztof.karas@intel.com>
 <20260902082525.1149367-4-krzysztof.karas@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902082525.1149367-4-krzysztof.karas@intel.com>

Hi Krzysztof,

On Wed, Sep 02, 2026 at 08:25:21AM +0000, Krzysztof Karas wrote:
> We should release folios if the first entry was populated, but
> loop failed before sg advanced (st->nents == 1 && sg == st->sgl).
> 
> Fixes: 957ad9a02be6 ("drm/i915/gem: Avoid iterating an empty list")
> Cc: stable@vger.kernel.org
> Assisted-by: GitHub Copilot:claude-opus-5
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi
