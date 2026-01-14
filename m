Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A5039A7E5
	for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768405770; cv=none; b=iMb3BWkaI9m1XDbXImJoDrZUw9OiF0HleSU62E9hBMHtlgrXsCfJBvmuAUKlDgdcbDg57SC282jet9IyiKY4sAi/Vyy/fd+MSaig8x45Zaiu/eeTGgS8gs4Ll9UB5qJGKrQo2ObhdpkExUePNkXUQ7A7uA+3yvR0Q2Pt1Td856g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768405770; c=relaxed/simple;
	bh=ObB6mNLZxrOwdkLeI7B4S8nJCj6vaP/E1/Gjfy932w0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWodmRm/xnt+pyTQ2lW2zr0sFOxkEvyTtGiJlqc8TZwr3Fypf29zpnoXYTos0YOiYRvJfr4mDYWyJRETJza44TqSd2rHtwuDLGaJU4/w5P9pCdV1d6vezxpboDW1IPhxOk9Fmw6Z1DOezLo0r7uIC0puIWptVBjfNAT8/O/R/70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SkqMbgAb; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SkqMbgAb"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a1462573caso84465ad.0
        for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 07:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768405768; x=1769010568; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hewq6sKfyqMWuY04fEC1TGPKE79y9zR1LTOJeM3Fj4A=;
        b=SkqMbgAb+S3ZHsQKknSEFwahqGTfINXrQOB5ZI5oxWoeymDJU3+Ycp1sPZZNGtDrtn
         mwTxCADxxUk6Af6lbLYfEiTN0QS8+dDWiOgJR7hlVsM6vrHw4QFEYJxM2gmHo+PxfpUj
         6CTYYMdrQUKkBv+YCQ27XSG2n1+McW14NHbgslTFh4caLkMrPItIR71UoQ40oNHwbony
         OzSvNhBq3bKTmJ8sIsNE7cdMVCCiXvBIgyypK4a4vV6bOMNGu+Tj393L/KRCjAv5pboW
         BBXi2wHTf1q6Had0tye8dcfKuR6P1uQbljt4EFKS1hD1DJ0lJkx217ug1LCp+so08L0h
         2AkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768405768; x=1769010568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hewq6sKfyqMWuY04fEC1TGPKE79y9zR1LTOJeM3Fj4A=;
        b=OzE3kM9OlOg1ztLAwPBFIm+ZEte5IsDh7IQKozHHzL5RhD19gXro1yO4HgOzMr3O84
         V+b7jZ5xYUwOM2UhpZyQc04r1s/xKnZ+gpKZMmKYjuMndFGjSDybJ6z0RwMz010SKLD8
         OoF+hySJC9XaAmoH3NXBhym+GjUw8kEgebRk2bozSRzvzB1LbhAY30rJGgJpu7p31RuM
         OIzZMmlFq4ueRVnugI3y8gsrONQPVNfOtpp7VTGykF6eGdc/lJAZ7LNeRXFipmDOfLNp
         blRv3UHt2S2c9yfmKLZSDQ97li4omCFXXR+hX7vaek59v+8Y3aUc/Mm7d3SNvOx5knq/
         E/wA==
X-Forwarded-Encrypted: i=1; AJvYcCUNZC/ydNtXsMuhUJB7EnR34z/x8W1fXfMV5Q1jwdgFsP+dJpvEqaRTHnatNeI8APiWlUOKkg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyROhMkJ6/v1cSqoUilVC4EEb89VuUr6ymXGx38oES3koa7tpuu
	ebMecQ1WjhhV7Y7URAdpUo+CfmIgMF0KdT60UytoVai9pnavhR1hrU8HPabzdeceXA==
X-Gm-Gg: AY/fxX4jw0HF//kN6z4vSQsCY/PAz8ftdTEzHlClYyCQZtZxMDo2hyzLqksIRdB9Uxz
	thr1UDYVt7/GU7nQXVcs70OgexXYPU+39uUTP6EQe8kB9DD4jztrvLcnaIVZrtTgK5qIxm6oak0
	1Fi+ONVx3dFQ/XE8PB0Qbd4ty0NsAsMK1mUH1nYFOqRVBh4VxYRRda+UnVLKLLvEck01p3Y/L07
	9Choo/WdK99E5oqKr0Cr/dxV64xWxbNn/ZS3d9mIM8Zws/o2JgG04U3PpznpHZncBmj20/cKTjH
	JIae0ha1IDLKi7kFmiuz1LRTKmP6x2u7vBrSs1wC2mXRmysHQgNLg3aHLM+lcnSXxJpc4PAkqPJ
	FRdXnQVGkCMXsk3P2JfH4LTs0HmizTqQXo0OwcSVXpl6aVjs+lXK68PzX405Qu/JIjakbBzGBNN
	J/W+ORNuw2zy5HqPyS4F/Y0vx7OjjHHL8ET3eXTgdejVg3z9cd
X-Received: by 2002:a17:902:d583:b0:292:b6a0:80df with SMTP id d9443c01a7336-2a599aec680mr2522025ad.10.1768405767789;
        Wed, 14 Jan 2026 07:49:27 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c530133csm23442851b3a.31.2026.01.14.07.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:49:26 -0800 (PST)
Date: Wed, 14 Jan 2026 15:49:21 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, jgg@nvidia.com, robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, skolothumtho@nvidia.com,
	xueshuai@linux.alibaba.com, smostafa@google.com
Subject: Re: [PATCH rc v6 1/4] iommu/arm-smmu-v3: Add update_safe bits to fix
 STE update sequence
Message-ID: <aWe7AUG7PPGX7mkl@google.com>
References: <cover.1768248467.git.nicolinc@nvidia.com>
 <b80ddc54f439a239e74bd7c0bf33ffb73e2eed1d.1768248467.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b80ddc54f439a239e74bd7c0bf33ffb73e2eed1d.1768248467.git.nicolinc@nvidia.com>

On Mon, Jan 12, 2026 at 12:20:14PM -0800, Nicolin Chen wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> C_BAD_STE was observed when updating nested STE from an S1-bypass mode to
> an S1DSS-bypass mode. As both modes enabled S2, the used bit is slightly
> different than the normal S1-bypass and S1DSS-bypass modes. As a result,
> fields like MEV and EATS in S2's used list marked the word1 as a critical
> word that requested a STE.V=0. This breaks a hitless update.
> 
> However, both MEV and EATS aren't critical in terms of STE update. One
> controls the merge of the events and the other controls the ATS that is
> managed by the driver at the same time via pci_enable_ats().
> 
> Add an arm_smmu_get_ste_update_safe() to allow STE update algorithm to
> relax those fields, avoiding the STE update breakages.
> 
> After this change, entry_set has no caller checking its return value, so
> change it to void.
> 
> Note that this change is required by both MEV and EATS fields, which were
> introduced in different kernel versions. So add get_update_safe() first.
> MEV and EATS will be added to arm_smmu_get_ste_update_safe() separately.
> 
> Fixes: 1e8be08d1c91 ("iommu/arm-smmu-v3: Support IOMMU_DOMAIN_NESTED")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks!
