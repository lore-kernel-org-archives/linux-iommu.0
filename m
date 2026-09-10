Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC5C3537CD
	for <iommu@lists.linux.dev>; Thu, 10 Sep 2026 22:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789079615; cv=none; b=apUWpCMo1btYQxvFI85cCFhANwj/nGHKnTXQRl816R539cpFlo4n1oDt9y1qcMCfnrejl5PH7xPXiJojLA1iJg90+iBufSqw4CukRgmEsbx7a/k5ElOSJLlBcQre0J/+67GO0MCSnRxJM9k8Cl6QDk1L0Ygo+47g21/hwBjpp9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789079615; c=relaxed/simple;
	bh=IMbIGF3ONt+PgVBclPY7W3kz9Euj7kQGHcCFdE4rdrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXUbIFSe/f5VGz+yHAfkffEdLQ/dUzCBZaeUqxkzPpZi7r+6euw/lGZYJ60TACvPyOXEQePcg+9PrwGEHx7w5VAbp0gmWGXiJMSHukEoUsWmgJ1YONcS2MA1R0yRbMfkbtnExY/xSQvYqIkFXmi7MqjvCMfT8hVx53p7nAFz7TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0rsxF3J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0rsxF3J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 886521F000FF;
	Thu, 10 Sep 2026 22:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789079613;
	bh=zJ8BgUiYocvgAL+cnXgVrbEwxr8z4wAo+lXStos3B5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y0rsxF3JeEL4kTSYxZkrv94F+7FDsXhu5+pu9b0sDajVgTvMMSGl82ERGGBuGgUh7
	 R60v7bdQ1/3WrtfbbqK1tuvHNYbDUsFWSQ4SLZw+zvJPvizgHBGIUmFnJNxrXECk1s
	 515jkYTvNVRbHoRidNHQeOb8/SUc76Y6GetxiTU8kikVfMRUUpas549ryWufH5qCrz
	 NpIYhvF9DfChMPoTsr+JKBOtC4kbo9JNf+xiRneN5TOPlAzG/2hcYu/Rsz24+e303I
	 UwSeAxSNy0LqbFreAB7Sj8ejC0Sn7VN6VveEDPIM6Z4BZL6zwFrbpq8YZ3kQDT0WQs
	 pVKKt528SBuxA==
Date: Fri, 11 Sep 2026 00:33:29 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	iommu@lists.linux.dev, Andi Shyti <andi.shyti@linux.intel.com>, 
	Robin Murphy <robin.murphy@arm.com>, =?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>, 
	Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka <sebastian.brzezinka@intel.com>, 
	Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v6 7/7] drm/i915/gem: Remove iterator and use while loop
Message-ID: <aqMv2XxfGhxoWgdK@zenone.zhora.eu>
References: <20260902082525.1149367-1-krzysztof.karas@intel.com>
 <20260902082525.1149367-8-krzysztof.karas@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902082525.1149367-8-krzysztof.karas@intel.com>

Hi Krzysztof,

On Wed, Sep 02, 2026 at 08:25:25AM +0000, Krzysztof Karas wrote:
> Change the main "for" loop into "while" to get rid of obscure
> iterator "i" and use a more descriptive name to indicate how
> many pages were already covered. Detect first loop with
> st->nents.
> 
> Assisted-by: GitHub Copilot:claude-opus-5
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi
