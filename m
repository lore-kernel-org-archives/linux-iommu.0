Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCB9200113
	for <iommu@lists.linux.dev>; Sun, 18 Jan 2026 10:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768730635; cv=none; b=skaDzlAMVQa+T5C79+ggYpdP60e10qJYu2LlB5oipFxhIOr71BSTIJet/0jfo0Oxp5+marea8nIYI2mh0A4gLJQrQbxdN9ydi31DtJ8nWv30yZeUaFKJ7NV5gy75hok/+2QI+AU1330dVi20UxrOcnLeXJI60nUbRhQAZgjX0Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768730635; c=relaxed/simple;
	bh=bqpBemA091DXlN/orMYNppyD5tZemMhshWgqEG1jNl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guMUf0Dq8Fnr41ROExgXr8/TyUd4/mL1zE7XViQ9nRevbK1/zDyG8oK6mmVgW/TF+4P3w7g7NVulu9kx79atb3wr9TfXlA5AfYLn6f9jHjDlBbTb4dIf+pRuP71gycDfcMKQNwXjER8xqERj6HPoyRlQD+nfd38uDN2J/hVB3j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=TpX99FT/; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="TpX99FT/"
Received: from 8bytes.org (p200300f6af1d960047d77347aeef488f.dip0.t-ipconnect.de [IPv6:2003:f6:af1d:9600:47d7:7347:aeef:488f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id BFD285FD0E;
	Sun, 18 Jan 2026 11:03:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1768730632;
	bh=bqpBemA091DXlN/orMYNppyD5tZemMhshWgqEG1jNl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TpX99FT/eYbfr/RBvkGys6u05cyizYVbzkcc+YUU6McmhkLuW73lU6s844M77nWEB
	 xsxchIyplJcdWe/uXT6eycEk59zJaOMkT7fXCe7kkQ3zXyq3JV11428DIKrziFDz2A
	 7+9UuVjh7IjHObYlyXA0UsrHkTmy65uIL8AbbVUOedPSVFNYHd1K2gRYV18R0093oQ
	 oYorFB0k9w0mMHpNSXWJH6VAuEv/gwc3v32UAE/dVpBMzuVwVmHuI10OVGHwLj1JuX
	 w6hP+WYJ1jAuJPIHPhdcDrs336kJ0zNV7WSE5wiUXxEitaVdWt1RBZGFMGnoXZdyBX
	 Y3NOKzOUYy0vA==
Date: Sun, 18 Jan 2026 11:03:51 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com, 
	suravee.suthikulpanit@amd.com, Rakuram Eswaran <rakuram.e96@gmail.com>, 
	kernel test robot <lkp@intel.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] iommu/amd: Fix error path in amd_iommu_probe_device()
Message-ID: <heyrxjryqx56dghra4tqibhqj7z3mkbou22yshffgxqa5i5mue@tulw2oxzh6hd>
References: <20260116055332.342204-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260116055332.342204-1-vasant.hegde@amd.com>

On Fri, Jan 16, 2026 at 05:53:32AM +0000, Vasant Hegde wrote:
> Currently, the error path of amd_iommu_probe_device() unconditionally
> references dev_data, which may not be initialized if an early failure
> occurs (like iommu_init_device() fails).
> 
> Move the out_err label to ensure the function exits immediately on
> failure without accessing potentially uninitialized dev_data.
> 
> Fixes: 19e5cc156cb ("iommu/amd: Enable support for up to 2K interrupts per function")
> Cc: Rakuram Eswaran <rakuram.e96@gmail.com>
> Cc: Jörg Rödel <joro@8bytes.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202512191724.meqJENXe-lkp@intel.com/
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
> ---
> Joerg,
>   This code path needs some rework. We have to re-arrange PCI feature
>   enablement properly. I will do it later along with other SVA related
>   cleanup.

Thanks Vasant. This patch is now applied for -rc.

-Joerg
