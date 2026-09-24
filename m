Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1463DB63A
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 08:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790237939; cv=none; b=t0KBqz5UnJ/uWvNs7FhCktopw4bxPDdAhJNAMObfUK9L4A9TyLK6L9v96gxoMg5O/bBMK6rwf9FBhW45/+DmwaQ0NWyNO04TuTYJYuMA/tt0OoRW+wY/eE4NC7m12NcFd05PNRVNwUG7+XDSA8kL3/Ru+SmYPkT6W/hQnEptjfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790237939; c=relaxed/simple;
	bh=wZuq7eC8OrYGdcaqCRFbmsq6ewXm1RrabCWSktmSbEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5CHDKmpFONDhIXc9S59v3SHaajAOY2+DEyZ6pVXFIqcTMaHwOwcQAIjVLsmqt57121JJdzaNouAElz7FySN5XrPh6VnjteoIru9qB2SXoMOIVhcnuRU0HGAUQIxGiZ35VLg8FRj5Xrp07YRADrRIhXwoAPkIwAOInsMVTpcfvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m+8MFMRA; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m+8MFMRA"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49e65a8f70eso26575e9.0
        for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 01:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790237936; x=1790842736; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=To3pmZtljGj4X5rJ/mnIJvMelKkwi9aYdQXapoWl02w=;
        b=m+8MFMRA6F04820zok3/01vRFh3PrF/X4iSpLKZPlmg9baoPXnf1hDxZrzodar+yqS
         Qu0puKf3gb5cOJuKAOTq/UaRg3e4JkZFv4A+lKeKYoLkZYBhN6Qkd5Q9oaC2HuD3CChn
         8MDKKPaxSn5VQYCAQukER5iJw6yA3zc3bf6QcXcl5L+nXLKRna3pi2W/ydpQU7gGGaRs
         n9hHu/7SsecPXP8xqNZ7NcaMPUavb/xO5yS8RABx2cBIgs9mZ9PsXOr644W5V8hYMwSL
         IJbh+UjTTDe97F5vB05lE07ZTtTqQO2Zokry3c0W2TInDG2eQKByJIFhPHOK4/uRr/6p
         qgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790237936; x=1790842736;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=To3pmZtljGj4X5rJ/mnIJvMelKkwi9aYdQXapoWl02w=;
        b=EtJsCYs6cYHuZfJ6iymbU+xkvDptDkzawrLISxZi/gWYzW279rkTC0tfTR/1r8j/zH
         h7+xLopjWE+Z4w02lcjwtYKKwsxJ3fO+hwTTMH28pVtngIXtA7jVqMx18g5vJ8XbEddh
         LW+pTGaPiNT4aymI4ufImUIovtViKq2W4fHo+88LcIj6yKBWt52yik4XTqY1PozFHqpd
         ZaP/CvsrHjKLHmHm4d/OVAAxSXhyIdaj1EgjTWNSi37iPIGIH1UWEuh61Lg/irMjzzJl
         e54dGhRzDWxehtmIKEX0t0MiVTBZ9OWMpYNFHR8Q3hg5ppWQ/LD8kvWLWEeB6pf/run0
         hikw==
X-Forwarded-Encrypted: i=1; AKwUvBxKlLCwxQ5izElamHDJxEG/VaEWb4H3srH5ZUkM+KjSLtvnfV2JCytAFOV04WCt0uf/zfqnKg==@lists.linux.dev
X-Gm-Message-State: AFuF++lDGPzGnW0LfaVG7c+6yYSZa37VzoKSaJo8lXLUDsWGgtIKFujB
	kQcx3/sE7NNd7+SIxpmuyCoC4y3t+o4w3nMPef+nopuz6P4Gu+MO65eruPB+gZAT8A==
X-Gm-Gg: AYBFou32mO8jdeMYDKYxQq2WuNRtGVHN1QjnIojdIPBh0KeVs1fQ+L8tnlds6HyedDe
	SeZEZ4bTFimhdvUR0V7p2NMiIBYBFFZhIcvDFMPR+AvvM3jcjZhHk4tEOAlbvfBt8fjsfXxErIT
	yI3/r6/3BMyt7UQQjtaeBMCaHUzehj3iRhqRGYJpB2noVxKi4E9v5zX+I4rO4MhmeaiCcgjZuGy
	40UqL7zcmyE2TIuFezoglTA6t3qsQmUuNbEZ3UcyTtxDHrb7B3tOJH6nmJIBsfqYvS0P8gQ9D+4
	9cYvCVn79a5gJ+APH5qYIxerpT9k7fPqDL5q8JmVuwlWV2Mx+TrZNApiWbkRUSaM+NI/U8rAl2k
	Az2tsQA8LR1Dsi2+Ms139S3zmoKIo2se16cZULjh029BwciST9Lt9f8ZFDMYwDqIi2ROCgX35yq
	yC0vgD7JFMvLV6QDeLJXYfKYvOPOWvAEeN9TXHfu+1KJpIEMJlSi9E6XMslsB+SRmNG5Ev7cNUd
	lu4m0scqPjrguQsA3DSLhq3uhN8JigruJsBMvcUhQ==
X-Received: by 2002:a05:600c:4aaa:b0:49f:ddcf:45b7 with SMTP id 5b1f17b1804b1-49fe5632713mr652925e9.10.1790237935405;
        Thu, 24 Sep 2026 01:18:55 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5cd42f2sm47160755e9.15.2026.09.24.01.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 01:18:54 -0700 (PDT)
Date: Thu, 24 Sep 2026 08:18:50 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, nicolinc@nvidia.com,
	praan@google.com
Subject: Re: [PATCH 0/7] iommu/arm-smmu-v3: Fixes reported by Sashiko
Message-ID: <arTc6smwFV3G2rSa@google.com>
References: <20260828125409.1921538-1-smostafa@google.com>
 <20260924000344.GA3560397@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260924000344.GA3560397@nvidia.com>

On Wed, Sep 23, 2026 at 09:03:44PM -0300, Jason Gunthorpe wrote:
> On Fri, Aug 28, 2026 at 12:53:35PM +0000, Mostafa Saleh wrote:
> > While running sashiko locally on the pKVM SMMUv3 driver patches, it
> > reported some pre-existing issues in the SMMUv3 driver (the RB tree
> > corruption and a missing NULL check) and given that this is not the
> > first time a pre-existing issue appears in the driver from sashiko,
> > I went ahead and passed the whole driver to Sashiko which reported a
> > dozen of other issues(except the last one in this series), I included
> > fixes for bugs I believe are true or worth fixing (others were mostly
> > missing NULL checks or bizarre HW/FW configs I don’t think are needed).
> > 
> > I also sorted the patches based on severity from the most critical to
> > the least, so it is easier to apply a prefix if some bugs are too
> > theoretical
> > 
> > Mostafa Saleh (7):
> >   iommu/arm-smmu-v3: Ensure L2 tables are visible before L1 ptrs
> >   iommu/arm-smmu-v3: Prevent rbtree corruption from duplicate streams
> >   iommu/arm-smmu-v3-iommufd: Fix error path in
> >     arm_vsmmu_cache_invalidate()
> >   iommu/arm-smmu-v3-test: Fix arm_smmu_v3_test_debug_print_used_bits()
> >   iommu/arm-smmu-v3-test: Add missing error checks for inv array
> >   iommu/arm-smmu-v3-test: Fix OOB in arm_smmu_v3_invs_test_verify()
> >   iommu/arm-smmu-v3-test: Fix UBSAN error
> 
> Does this need a respin? At least the 3rd patch there should no go
> as the iommufd tree has a different version of that fix now

Yes, I will respin shortly, I will also drop patch 2 as  Nicolin
posted a new version of his patch.

Thanks,
Mostafa

> 
> Jason
