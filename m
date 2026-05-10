Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C5B325495
	for <iommu@lists.linux.dev>; Sun, 10 May 2026 19:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778439607; cv=none; b=kwN4KATG16en+ZqYWaOBNHLibfUnFezsvN6r16tfhvJ2nZP6dvHxiDxrWzpHZ5nRB/X0unXkmt9A6E6P8BqyRnnDP/0vVcivlC8GHL02Zcii9EaVq5iEdZaxkFxLMRkwHUyUbA9SXw1Z9fNuMyyIDSxuEMwViYlmEryMNUuRO+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778439607; c=relaxed/simple;
	bh=Bvc212FwGt0vxmNS1oiSrfkzUZX2D+Zt999xDLx+UQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Li+4p7NrAtC2dhZG49mGgFGYbkyFuPG7noxkuFbNBUiIstUHjbUTmyF/+QRDvENd6oksvOqZHNTx06lBDejR0SkImqmClMSfklymyu4NpYYSsX29Dl4sk79BRjno5PdNXKArndH8a9Ip0Odx+EjcMkiJWtqnwJQDfmN9aATAaNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N6MDlr4j; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N6MDlr4j"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so145ad.0
        for <iommu@lists.linux.dev>; Sun, 10 May 2026 12:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778439605; x=1779044405; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bMsfc8Zbf8JIkTQeMv/NJIxXAe3vZVoXdywLBqyZ2Qs=;
        b=N6MDlr4jkGBKZUFnFNMZoWq85jJbqoiUuaLXYkyg433Riuf77QzCI0cL0KdwzTVrHp
         4+GpIjeyqvQ+83xml//9iL157IO+Hv+30S+p//ioiRQw2RZMC+0KAEre3G6N85EsR3Id
         FMY6XfpOAeYHEvscpt9MrYBAwa/1EJp5b4pL7Xk5ho1aCHJtU50pjnFt44AhSeF9I0Ki
         iKK1Sfqp3+Y+9/GLd8+0PEyNVsmHh7AF6OVgmQHlMvc2ZvpJTfiNE5vT3yXSCPHumMwO
         sud5ZazCsOEJVtEDDKCEUT8xecEdlZQkjmvQx8od9K5wgwF3ZXeDH/3r3S68pTiDRMmy
         +q9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778439605; x=1779044405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bMsfc8Zbf8JIkTQeMv/NJIxXAe3vZVoXdywLBqyZ2Qs=;
        b=g8f/HZQd3F8JcRvVKw/ER/X2oirP/5xZjXFA5eVp6w77M3/CWGM/LELKzSsR3QWxgp
         E/6/QAvmkL4sE5DWQL7iW7tQUH346KSVZqJd83YI4r7f0JPC0CuI2aFeO4M2MtbCPWrO
         GSB32XDRvDoeifzlc0ePtEgVPBrZDdGGygr8RB1e6SqgCAFh2lf3hUJ9X6J1z3SIP193
         DvWclVKkZFtV8nF2XKaV8W3JG3gjNkQW2+iurLV3BN5iXR1AVZIaVvsOJprXewwivhSx
         7Iqs5sU7dnZaQfhv+X8PSCvqtqaiUKIomA91Er0ncH8959kE8BwSGh4Fn21uiF+SOnmw
         JEJQ==
X-Gm-Message-State: AOJu0Yxt2NXknuzcCDb6CPZns7UnypEBKBDQ/EQusBdKfk5X4ieloKhc
	qBZxjC3Ls7cmi45mOHHIBYJVzVRO5xra4w8a/k6EB3wlqRxb8iG7HArct9Wa/zOevg==
X-Gm-Gg: Acq92OGoZPoEb3lSJ3oTkHu/oMcI64WiEL2Xpse6fa6qOEm8RCJyBL2R0EzgaAF1NS6
	IiGbGPefKcKoOVPGal3HGELYSkvsRwkTPOsiBxN3BY19u2XZMWdhgSvNtr+Ae8VZSCrQFlc6ikt
	AdgQZyX4cNKLmXKM5EzW/Tz5VIiokXm/JgrX+Eiy1xRLXGyGKbcF/wrgEk8NeOqlp0BolU87feU
	We7Ie7ovfiQnWrd2PnZ7QRVsy+l+B1mSepvFScNy1YjUVKNlQ/KxLJD8qUe4kEo60ejnv5TW2ld
	fMjJU2MbUFotQvVMOQZTEgtCyIRIPlDuyBbmeR01ceSg0qLIj+1eVOElPbdRoDUMWMK57NsMZ7W
	cTLTDjcDDOgwt7JATAsMqmjLxPtT2L9qwxuZMuttYScqvkww6AX86A9gK+HaJ/SKVtYO9xl5/ly
	rxyc8uu7yPS0n8Y8GA6Sfnp5ZCiqKWgFnta2O7Z6lgP5BXWXVPGwxT99svhs/ISm3VASe/
X-Received: by 2002:a17:903:8ce:b0:2b4:641a:6b7c with SMTP id d9443c01a7336-2bc7868490cmr2499495ad.13.1778439604484;
        Sun, 10 May 2026 12:00:04 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839685a8125sm18060689b3a.61.2026.05.10.12.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 12:00:03 -0700 (PDT)
Date: Sun, 10 May 2026 18:59:57 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Jonathan Hunter <jonathanh@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Krishna Reddy <vdumpa@nvidia.com>, Will Deacon <will@kernel.org>,
	David Matlack <dmatlack@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Samiullah Khawaja <skhawaja@google.com>,
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH 6/9] iommu/arm-smmu-v3: Directly encode simple commands
Message-ID: <agDVrTUTAIt1DpZ6@google.com>
References: <0-v1-b7dc0a0d4aa0+3723d-smmu_no_cmdq_ent_jgg@nvidia.com>
 <6-v1-b7dc0a0d4aa0+3723d-smmu_no_cmdq_ent_jgg@nvidia.com>
 <af3KDBt8vhClSKEF@google.com>
 <20260508173736.GH9254@nvidia.com>
 <af5C_ax1a3LbtL1Q@google.com>
 <20260508233629.GI9254@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508233629.GI9254@nvidia.com>

On Fri, May 08, 2026 at 08:36:29PM -0300, Jason Gunthorpe wrote:
> On Fri, May 08, 2026 at 08:09:33PM +0000, Pranjal Shrivastava wrote:
> > > > > +static void arm_smmu_cmdq_batch_add_cmd_p(struct arm_smmu_device *smmu,
> > > > > +					  struct arm_smmu_cmdq_batch *cmds,
> > > > > +					  struct arm_smmu_cmd *cmd)
> > > > 
> > > > Nit: Same here, why not  __arm_smmu_cmdq_batch_add_cmd? I understand
> > > > that _p just means we'll aceept ptr.. but the name's kinda wonky.
> > > 
> > > Which becomes a fairly widly used public entry point, so I didn't want
> > > to have the __
> > > 
> > > Though there is no external user of arm_smmu_cmdq_issue_cmd_p()
> > > 
> > 
> > It's just that we're calling "arm_smmu_cmdq_batch_add_cmd_p" at one
> > place and using `arm_smmu_make_cmd_<cmd_name>` at the other. It makes
> > one think what's "_p" in issue_cmd, only to realize "_p: pointer variant
> > 
> > I guess I didn't like the new _p ones but I guess it's fine. Happy to
> > leave it at your discretion.
> 
> I don't much care for the _p (and yes it means pointer variation) but
> do like it better than __ and failed to come up with another idea :)
> 

Yea, I can't come up with much either (without __ or _p), maybe we could
leave this as is..

The only alternatives in my mind are arm_smmu_cmdq_issue_cmd_ptr() which
is similar.

Thanks,
Praan
