Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FD94AA400
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 11:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595376; cv=none; b=e05e65BRGQ2+xUecUBLYhkZxWT6w/6TvKNk+l5XzrjEUfgYNVXA+JRVKTnr5v5OPEqIWMPvdKOt4o33JE1tCE2CF+lYUok3MK7eWJyxBDMorH3u3KxPF3bCYnT7bucfc2ebpU+knI3CZiFQCwJOD4Bu8rovQ6g7M6igzKn2JgbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595376; c=relaxed/simple;
	bh=szkmBZw5tkv9QIb3MfF0UTg+9Z/SIDMcAeVrvWmsXDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeY6FocTmOAguSJhifr9FT69aR6cNKlrw09Q5+CQT4Y3LFkcVU4qQpE/UcbcG4yiqnVy/VLn7AEMrRu78fY+HpdNNyvTaN8A78CDXboyoDGGOdUwI4vPTmZYf8IiCNuejrKnKpbdbMlImJeCeR73sPSaEUPhh2juekR9Sjf1ZUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ux9+EahI; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ux9+EahI"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d3b445a84fso67615ad.1
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 04:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790595375; x=1791200175; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2virUEPJU+T2t2fxsSozm2l7j+QFgng63b99urpUcvQ=;
        b=Ux9+EahIg0DfsKFWVNBpa2TKrW8/xJiV/6ZdFPtZku4rY4tmCCyNZC4c/BqwG1weJJ
         GA855gGOgo6gemLHUMRKOLpnCaQq/76mV1kXs50BsZDNIuF8FgrLAdwZLyJwbz1HMWjB
         6VJda7Xq0KwUeLIvhfAK2W1HKRcauovx1sdTnjBtTATndilvcvFae4ZuZQG2gziYagnQ
         1HvlZ2A4oa4vgBgIurPADxIkLdOukf+oTnxHfWVfsC5EL6BNx6XcUr5tCg/0ikvQkDHl
         h8Jzg7jRwKOyHphX3xJynelLsdMxCI3kVt1B6RJuYpnDRSdk3JNw0Z5dfZqbibnhQuoR
         EuxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790595375; x=1791200175;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2virUEPJU+T2t2fxsSozm2l7j+QFgng63b99urpUcvQ=;
        b=O4Cyv9WDuv3o7mkjF7mOVxRSUACwRHraKZ5krLDaaDEHJ5rYYkI0mV9NVo3e/sXoRM
         m32y8UihHR++UdAMmR3/14RGNQCE3pSOQNTrhRAsgd200qlGwLp3/54xPR3EFAfdN5MU
         4uxF/K0xs7h5erANkBbrcpgVKdLo1VFftnG4JHH04KBCZBSyFlgKTohWF4vha3fDXbcw
         iwNUA2DD4mkOOqDtFn1JiZVHHzwhEdEpNSox482sByJ8WPHBEbnyIXXC1OqVfkB8S6Qr
         6EJbmnhPNeLWzOUpFUzFcBq+9ZtXdBvj44xCZ7QoxQcx5TvryJ2CfeOQOg4qQfWnDJpi
         ObRQ==
X-Forwarded-Encrypted: i=1; AKwUvBxBBIWXm7lK1nTOr+pM0GQwfQvmLRlBfQm/DuO4KFImKsl3ms2G/jEZDDRbYlzctUL3uRZTgw==@lists.linux.dev
X-Gm-Message-State: AFq9FYL7be0dtnZa4AzmlbJIZZgXn51sJ89Q8fxTeLJIYlqWY3D8YkpO
	gxaVWKh0Pz5a6Q2na8GgNZ549IZH16VaM9J2yGFRngXApQ6F2MAcRPxWo+HK7F3C6Q==
X-Gm-Gg: AYBFou2bBYhv4INgml8vjYoHN+GlYT6G2hYCOrIS1COYM54f7yedLBf1M9P46K0N7Oq
	ltgOc0GysH0lKW60HFYs1ti3uc6GCgZSF3NXezIwFxzl7GMEpmDLW+3qnneBa80R21wbn63LIc0
	B0tG2nE1eH+3CaZ4Ioj/0M4wO/5kFyF5L5CNU7qOKGya1FrOo2pKek2oTR9IGOUZBvSY2Lo4IP1
	8hRi4+xi55NI6PfvxxCpFcqA+0D/lqXc0cX/mbcOmZpd+Q35/DqSxw+2tW3ydG1GtBNIl+uq9mk
	dNBmJIygYJTO7Hg3N6NOSNoB6l5gK8+9JpXBCV2I02O03QHLooddCjiyWw1JpOAHiQ3KJL/K+ol
	jrnddTvjUXJkxJAGXWhVCJAVZUHHjVkH8P9jQ0v9rQEmlLsXzzlzvT6AbMtZF7NV36F2qD1Btp5
	z5QZnjruEplHxTOwLUM8ywpmZRqZq9RJe2fcqU2or8/erXriIqIq4S0VTvcUD/9T4BszN1GJpAz
	TrJ0XHVmAHmg+zrvz7D3uWEzPED9IQcvRNq
X-Received: by 2002:a17:902:fc8e:b0:2df:83ce:7271 with SMTP id d9443c01a7336-2dfa624aac2mr6638095ad.10.1790595374074;
        Mon, 28 Sep 2026 04:36:14 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df9142bafesm39086245ad.51.2026.09.28.04.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 04:36:13 -0700 (PDT)
Date: Mon, 28 Sep 2026 11:36:05 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, David Matlack <dmatlack@google.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Samiullah Khawaja <skhawaja@google.com>,
	Mostafa Saleh <smostafa@google.com>, stable@vger.kernel.org,
	Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Subject: Re: [PATCH v7 3/9] iommu/arm-smmu-v3: Move pgsize out of arm_smmu_inv
Message-ID: <arpRJQHAKMKIcX-w@google.com>
References: <0-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>
 <3-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>

On Mon, Sep 21, 2026 at 08:55:11PM -0300, Jason Gunthorpe wrote:
> pgsize is a constant property of the domain, it is the base translation
> granule of the page table (4k, 16k, 64k) in log2.
> 
> Store it to the struct arm_smmu_domain based on how the page table was
> created.
> 
> Pass it around in the tlbi.
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Mostafa Saleh <smostafa@google.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
