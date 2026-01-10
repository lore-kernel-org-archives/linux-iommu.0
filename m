Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EC72FB99E
	for <iommu@lists.linux.dev>; Sat, 10 Jan 2026 10:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768039746; cv=none; b=Spb82gJtuojzciZnTHftn8UobYGsCI1QzBQjs0ZGKqHzXGtubOt62wRj1ZMUrQ9H+bPjfrn/Wv7wfGK/BFC/hXfac4uyD4Jkl3jk553+hMEkqNVL4kq25sHwwWOBV5fd4RuaDqRliMPnoWlTq9fbLEro4Qar7eUp8oNozvDSxqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768039746; c=relaxed/simple;
	bh=DeufMLyP1sqhileqFWtmUJ0UTIXfFe/CoVjZkv23REY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pi8T++lytSSrR6znyRUiuflAk5vQhlRdojDPx9CoKGdedw3HPbO8RZqguvThPIlHtweIJOBYINe3en0BdKDljSAKXeil7+CAvrh6Z/R9sadSD3GH+PHLsV3MdaiFcwyVKkfmj5ZFrufKQZs5bQuuF+cUqb9uNHBJJoBaF2/AP94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=n47OGekL; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="n47OGekL"
Received: from 8bytes.org (p200300f6af1d9600dfc71246d978d903.dip0.t-ipconnect.de [IPv6:2003:f6:af1d:9600:dfc7:1246:d978:d903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id A21EC5EC7D;
	Sat, 10 Jan 2026 11:09:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1768039743;
	bh=DeufMLyP1sqhileqFWtmUJ0UTIXfFe/CoVjZkv23REY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n47OGekLK1vY+SXLmF8wq8AQfPW6sjSsR+aMYTjUm4wvs8sknEVOjVlL74mg1Q3hv
	 JojC5NEmFEandDqFpnL/zv9P1Al2iOkEcFoa8D1I836gHCdhOS0GgJwU5B9WCeFFvt
	 YNY//0+JLYbpI+kkmzWujZ0GUisxqEC92qvTcgyjRsqa8/rr6CErUAxXrbWrAqQnkE
	 6+Sw+K6QsH1DNxYXuQTc0MwaIBg/n/iD0VGJlljeeEM9KPEU7eIxYQ0g2/kUdChOXM
	 TwLWbxUPp8hAmijvMgv33D1A65rH1reldEaRQ8Bz3HMRJ1Hp9K1ASTnK1MeOGD8RF3
	 rpKZZPtD9+cuA==
Date: Sat, 10 Jan 2026 11:09:01 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Rakuram Eswaran <rakuram.e96@gmail.com>
Cc: will@kernel.org, suravee.suthikulpanit@amd.com, robin.murphy@arm.com, 
	dan.carpenter@linaro.org, iommu@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: amd: Fix uninitialized dev_data on probe failure
Message-ID: <ube32gksp3noozdql3bm7stqsmjlijlvldsidhy6js4ub5fhdv@zmhsfnwgjltw>
References: <20251221173416.132656-1-rakuram.e96@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251221173416.132656-1-rakuram.e96@gmail.com>

On Sun, Dec 21, 2025 at 11:04:16PM +0530, Rakuram Eswaran wrote:
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 5d45795c367a..075125f0f52b 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2426,7 +2426,7 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
>  		dev_err(dev, "Failed to initialize - trying to proceed anyway\n");
>  		iommu_dev = ERR_PTR(ret);
>  		iommu_ignore_device(iommu, dev);
> -		goto out_err;
> +		return iommu_dev;
>  	}

This is not the right fix. It makes the function omit further initialization
steps which are needed event when iommu_init_device() fails (which it only does
on out-of-memory).

The right fix is to initialize dev_data to NULL and check for that value before
dereferencing it further down to keep the current logic.

-Joerg
