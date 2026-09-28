Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33952EEE9E
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 23:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790636631; cv=none; b=jkOG8xWBNaY2RlWo1j0fi8exXxsQISa630slvyfXANXEwapZVHc/6GX7Mch1VgLD8KuHqTcKsEYD7JStP02RflM+2yLyAvwJYb5c52u9nmPI0JD8MQUVk5hahGmIcl6ebicOta4TdZRGAOsEww6ENyhdiPhBZXuoMYKqmH0E04I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790636631; c=relaxed/simple;
	bh=+NbROVe4afASwW55xJJaNok12pyEvCa8CWrMaS1gt/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Idlxm5prRxQWagGMu3vwGokljWsDi844x/7V2tc8N7Ma6UbqhIuhw2hJSHhF/4EPV2/PxwDt3c5cfSaN1NsUXSmqeUcKBUncbV9Wv7hXTd9JCgc2kUoHbKYyIor9kOXzDWwNRy3HY+kbH41FHQczEvxApOk8uiHxyQ8ewf4Y6rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CX2Vh6mW; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CX2Vh6mW"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2db33db4de9so22265ad.0
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 16:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790636629; x=1791241429; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OMftjJLAh8xtsCYYhvQzmmzmnj+Oz+ZcLlSPeG/s0X0=;
        b=CX2Vh6mWLxK+P2GwlsvBpsX/37qV5YkHAYdQiuc3+M7AWk1b197sJhpXGZ3i1QX0Tw
         QEu0Bi4idJOLFetY8cJR5YZnCuctnygYXvesU3W9b2VOSU1DN8AHKEKWxhYAshSC2phq
         7rBUoVlVP22fKcJsckdgD/gJcqVhDwED7uL4VBQ8oMcbnulQOD2eLKT9n8sqIGGVj0jL
         dLS8cwdrmGoqqacETJ245apVgQuQ5cuBdDNpKJZohQ6N4NfPBsRsXbSr2meibgzlWCkV
         SM3L+pGOs8MAp5KykP+/owcEoVIdnLo5PwJx7uNJfqjuitKuWoJcosKqRXzKToPXXaKj
         sfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790636629; x=1791241429;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OMftjJLAh8xtsCYYhvQzmmzmnj+Oz+ZcLlSPeG/s0X0=;
        b=lhf5+zLZrPA7m5S5U+aaPOYNW97feqV3dHbBLUUqKpKfOoGyqCMk5Ols5d++5yrXja
         g8o/u0/Etp9rYG0iRLasuP9/8nNE5rxOPj3FnOlDGZW9IdkGLisoEl6WR6N4MWHQLV83
         VFzhaRwUe3H06UgmgabvQegQmXi2b+IEPKCJNY7Al8Ht/ClctIraQFSrZRC6NF0orlj4
         MlbnvIe8AW1XTA2Vs4OuLL2NRJdOTX7iYgdZ5/R1vVAK4YdTaiOgh/zUeAh7QS2kYodk
         b6IB55ZrK42z08ImnaPeZ56x6bNyRI+RcjvujVZ9K3Dnop/nYNvgDG43I4kTjdxt/AuH
         uY3Q==
X-Gm-Message-State: AFq9FYJHGfIg0F2OQ8G6RhDp0G4Uo0k2UkD0iAOeht2Jj2m1djkdgLpH
	I7USJD9RBDpYta49lY3hfNuUyIUVT9NGOLsPRHMtKjS1yboJkQZJu1Z8F4xvBE5cQA==
X-Gm-Gg: AYBFou1ipX/NLJxMOrsjfZ7nyRB+mmrsvbiF2WtPZoKK3kb2JEqaMSevsyPD93yxmA6
	KQb5PvU/OUpXcqR5eZ/m35jCgsqbUy5Ld/VaP3/h/OPd65RphQb+H/8F4CUZtYyc01EEMdTxklV
	aGoLb423vfN9WFtdrp4/rLf5aDhNXCDPbszpGe7/HC6elNmFC2LX2sDg978JcL1TBVVLs1i60RY
	7xSHpRWZko0Qz+9nLNrLdDz70C9KqhBw/tSfkYxzG4nsGI+a0ZLpf+HD+33lbBbfpel948vRHKz
	qHUuxrMYa4Ql6WOxj3xArBQwpOWczVwgSkyHkGWKzMRZFJLFqmiqh/gWog9k8jMmwNIDr89c+gy
	M26TWkA9g6Cp9WrySvqvP6Y1/Ad1j7T8kcdb7/IT6oFPr84GBW45fU4tKaso/rbjHL+g1ziltqT
	dN3IDxOnkeneB9kfY2LjjPFgvWqJ2mxKiyZtSLMj3Tmh3d0iAVLojLBv8zSukNJeBPzZ5E9WKZF
	rAIZCBecsbju/L+Nmr7nyYUL0RDm7EQctFi
X-Received: by 2002:a17:902:f707:b0:2c7:f688:f22f with SMTP id d9443c01a7336-2e2c79fbdd5mr691405ad.13.1790636627971;
        Mon, 28 Sep 2026 16:03:47 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87feac93380sm4714358b3a.33.2026.09.28.16.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 16:03:47 -0700 (PDT)
Date: Mon, 28 Sep 2026 23:03:41 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	David Matlack <dmatlack@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Samiullah Khawaja <skhawaja@google.com>,
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH v2 1/9] iommupt: Remove the sanity check for
 pt_num_items_lg2() at the top level
Message-ID: <arryTf6sRapjC1uW@google.com>
References: <0-v2-563ee63886f0+1209-iommupt_armv8_jgg@nvidia.com>
 <1-v2-563ee63886f0+1209-iommupt_armv8_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1-v2-563ee63886f0+1209-iommupt_armv8_jgg@nvidia.com>

On Wed, Aug 12, 2026 at 05:09:17PM -0300, Jason Gunthorpe wrote:
> This was ill conceived, the existing formats work OK because they
> happen to support pt_num_items_lg2() at the top level. However the
> documentation is clear that is not permitted because ARMv8 has
> concatenated top levels and we do not want to calculate an exact
> pt_num_items_lg2() for the top level special case.
> 
> The logic to compute the number of items of the top level is shown in
> pt_top_memsize_lg2() which is:
> 
> 	num_items_lg2 = common->max_vasz_lg2 - pt_table_item_lg2sz(&pts);
> 
> Which is pointless to try and sanity check.
> 
> Reviewed-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
