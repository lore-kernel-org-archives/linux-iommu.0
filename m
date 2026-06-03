Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3943A1EFF8D
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 01:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780448478; cv=none; b=fMCIwSdradvn0zZyZITH2qlbspfHC3UXkNN1kdaUB15UykQzt3j+s4vyamNFzaFSHbJWp44KtdowFwyR5dD1Sqwbs6pHifYbQb02wH40Fydm6IQ4bq6BmZFSOFd0SQUXZ3NdIFycIbCmspVTOOI5L+9Z32gX73wA6ltdiWKhNXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780448478; c=relaxed/simple;
	bh=UI/i7a3o2twKZmU9gVBMd/iTOYSldALT0tkSLrczf58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMTCKKqeHqQ7Cev/8kCNDuKldS/9iMzTVaIcWMcleigoVmwsJyumNhGRXfrQLJqxMVo/YNRWLgo43g73iSVC6LIUE+TN/n04uF0SUz1H1Pb+OgtfATNVhvdexVwUuvmLWor/8UKoqtbTe5UtYnaeTdI+Sr2CfWXKP0JZdyIUAk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YI55WzBE; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YI55WzBE"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-91550dda53cso455012385a.1
        for <iommu@lists.linux.dev>; Tue, 02 Jun 2026 18:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780448476; x=1781053276; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AkdC3dWZFs3uTmguQZS1ztKpgkqPeW1kWupRwLRFJ1I=;
        b=YI55WzBE/b4xNzJmCH88OmrB5sw8MEUliXAcRZFqQBnt0+OGtQS9MXkfo3lOhoVvu/
         d76IiruTiMf5U++f/kd8O7gVGFsz8ILdsKM9JLODfo8pvmBgiptIn8X2bkjMH+MDpFeH
         qYZL34VyOUu2a6xrDsyR7EL2hu/2M7kun0QVoEgAz460Idxd+/nWZzWQJvpa3+TlMKMZ
         cecLesDYiLpnH/3ui41GeDyGcB++OeGNz6EKty9QSfF0NiRmrRkvkNoTi0zyu6+W0Rnw
         UzbZ3c2lMeJyJB/C1XygBvrS85Y5Z82of+PvGpZRiUqiIBoD9zr/E6BUxkgh6SzcCIpo
         dZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780448476; x=1781053276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AkdC3dWZFs3uTmguQZS1ztKpgkqPeW1kWupRwLRFJ1I=;
        b=HIRHiraPj+2CtD0zLiF1drStAaQ8mZJ/5M1TvXonyrLw99GhPm1ttMEIg+61pWS4Fq
         KCqx9aCoMVBiCoqAgzVHKMa5JhDKqFsAo1Zb6ZAivKtgmIMWincqRDAUUIPO1U+fq6CB
         /y++5md7zu3D0xgtaabqWIwmHX6lqSDlPOkFxv2R7q5TqZN7dl3Gvz7lENxR4ogaZkZK
         XBHf6D/tyjJR/f1HrGhN7/TOEvn9mjRcD56Lvtgp5YzJzWogBw9bxRoVZl6F5nB11kQT
         iGKQuias6QzPanRGkpCKxEaztT1umkgRzvJEvIjErRs7KtEMTBNlMwkCjkh6DlVQ7PiH
         zCbA==
X-Forwarded-Encrypted: i=1; AFNElJ9W3kizRO+Yz4JEWnHVjOHcizAQlvJnniDtI0xbQCOIvS25vyrElPz9LyOrFGvP+EmRYl5Dkw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwdrHdq9tQT6AF3en/Vpgszd4+wNVOBPhb8fU6YZrSbo4ljWsdG
	CjgkrjxEAPYY/hOZBiojmlu1nxCgOIm9YDUvNt7CBUsQz4n4iPRlaXQkaevWuhJoO2o=
X-Gm-Gg: Acq92OFuFOtc58BT4fYR3AFpCwB2hk4funbTRwANqVHXQdUFOzxn92r+mdvnqz3gVG8
	keSJNAPPFemBR3+Yl0P8IUXDdjLfApsEisfp5kldtPKZiLj7whHFNu3Mos1Y5QrqJomqep2hgUz
	fTEWgY5RF9MVsf48s+FQ3rx+xSOXfKP/Zdee69hPpHkMopDEBRJokBjrmqM+ezJCb/O+L4TEfH0
	hnkAhh9SyruiqKi3RBbCAjVaG9/iNgt83pU7ibda4ukrv6YIB+yd1IzUcBYE7uQCGSESpBcExCg
	W3VJDNKfZIHZG6G6nhQusMEONxiXNE4pQZf/926LRqIRtnca6wjj1B1nUEi3GQ1ySK71zjHcxiZ
	UFyMUTFmorUTYxjfZ/BPGARjKRzlH7eyKEQqVgWS/fHz6j8IzqAniO3KHH3kVZVSe+e1jyUDsmB
	SLLuCKM3TAyFNnmogToTpkwZJ6gz91qg1gOumFTws0arvUaHvbLCbuIxoqARqqXOfoGlnGWm7b0
	jYQ/n7E10eVx9zkUtAzTedFYSg=
X-Received: by 2002:a05:620a:21c5:b0:915:6c4b:eb60 with SMTP id af79cd13be357-9158a7b6304mr201153885a.29.1780448476209;
        Tue, 02 Jun 2026 18:01:16 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a00afbcsm101995885a.9.2026.06.02.18.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 18:01:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wUZys-00000004xXc-0zdZ;
	Tue, 02 Jun 2026 22:01:14 -0300
Date: Tue, 2 Jun 2026 22:01:14 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: Ashish Mhetre <amhetre@nvidia.com>, robin.murphy@arm.com,
	joro@8bytes.org, nicolinc@nvidia.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iommu/arm-smmu-v3: Issue CFGI/TLBI twice on
 Tegra264
Message-ID: <20260603010114.GO2487554@ziepe.ca>
References: <20260601104845.995005-1-amhetre@nvidia.com>
 <20260601104845.995005-4-amhetre@nvidia.com>
 <ah87dzHOOTNGBBmt@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah87dzHOOTNGBBmt@willie-the-truck>

On Tue, Jun 02, 2026 at 09:22:15PM +0100, Will Deacon wrote:
> > +	/*
> > +	 * On Tegra264 (see ARM_SMMU_OPT_TLBI_TWICE) re-issue the same
> > +	 * cmdlist with another CMD_SYNC to satisfy the erratum.
> > +	 * Callers must ensure the batch carries a uniform opcode class
> > +	 * so that checking the first command is enough; the iommufd
> > +	 * VSMMU path enforces this with arm_vsmmu_can_batch_cmd().
> > +	 */
> > +	if (!ret && sync && arm_smmu_cmd_needs_tlbi_twice(smmu, &cmds[0]))
> 
> Can you move the arm_smmu_cmd_... part to the start of the conjunction,
> please? If you make it a static key as I mentioned previously, then
> hopefully that should mean everything else is moved out of line.
> 
> > +		ret = __arm_smmu_cmdq_issue_cmdlist(smmu, cmdq, cmds, n, sync);
> 
> Sashiko is also unhappy here if n == 0 because we probably shouldn't
> be inspecting the command array in that case.

That seems like an AI mistake though, we shouldn't actually ever pass
in 0 sized batches? 'zero streams' should fail probe, not get into
this code, that might be missing but I wouldn't add checks here..

Jason
