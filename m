Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793389347;
	b=ZO0O1CMYbP/YOcCXKziI2gzccV/oQAz1bKjlhaZyqc9rSMjJMk5H8oeQSAOcnwt2DbmY
	 qXHhX2v/p+djyGOln1n2AQzgojqsmcZYWuIUpaTrQZk/9ae1z+hsKNVrRbirruf+cKCsu
	 sTOtQsxizmhGI4bgXL+WC66VuJ8i/8VNX8gju8IPnKLMONJsUjyDp8oZz0gAnLXr4XoAp
	 av2YTb5bgCe/Pc6OQdLRu2H0UVCcqCgoSnw33JR8ZvYNTY1f2/2+KpTmpCFMKlaoDH0Aj
	 7ciaWvw0RU3kljmLnI3CG261oTYHVaf9e94RB9F15R0iMxOgmNhX3BvlwztBwM6q6PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793389347;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=vK8srcbyjFHPzlTR1mgLENgg8K+rOF0C+tBALqScXrA=;
	b=uk5WwOJjawBF7sGjJWG48gViREziUNgXQ9UEyVnwFl1Hy0+hn4hSulOnmM/6nFynX++G
	 IRLMs5ckiXr2/UPEMkA+HCpLkiLN0XMywOfTwRyT+vZvx+5yFOMq7GOUJ0b4OB2PQGfXb
	 UnjXlp5bl2o4ID0IORjukrNIrXs3tgj/bVXtEwGLyy7ZPYBGbW515KVz1bPUqZHG6+ngv
	 hJrbJJ5EST6Q0ecSe5HSsWnjPR5ODC4q4YLLIAWi3xva21Q6iBcl1yxWFfYCJ6AEeperq
	 DxXzaY2wlSXW2i++T9QEGVH3Cuvw/mlvxjZZ2TnhoYtKsk0ePUkLdlIM2V5kS9OdTJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Yxq0VtTV;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC6C606A31C
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 19:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AC6C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Yxq0VtTV
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e9f6a16afcso11685ad.1
        for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 12:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793389347; x=1793994147; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vK8srcbyjFHPzlTR1mgLENgg8K+rOF0C+tBALqScXrA=;
        b=Yxq0VtTVayC+rGr8ByiECjk+eqKHtWRdETL2LsQK2h28RF47fs1fyOBRQUtX27u9yh
         f63/GBkqEpVbBuuU+IX54P3/2apbT2vX8X/P65nEvZZ32R28Y1BpDIfF0LBJ0K07yNnF
         tZZxF15KgD4tIP4BEjt+OLYH6EYvmCfc4ggoGkn0S7VmKMZah0BJ17Vc2SFDjwXK9bJ4
         AAwAqoDEURy2jD2Dhc1Y0Qj06WPNEPV42SILHersknhWMmf1FnJBeY9cwF67I8os9jOB
         cBW1Xf4P5j+6uxYSTT27GYkhYddm9WMUHMdr12u6lPqahx+FkKMfERuTqGiGRzdQR3Cz
         view==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793389347; x=1793994147;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vK8srcbyjFHPzlTR1mgLENgg8K+rOF0C+tBALqScXrA=;
        b=awyGybtmK+JfrsLWHI3/6A8jPet4ry9AVxMpDuMfdvuFVLfWjb4no4Y8wKDlxID6T7
         w2liQiQPqzY1z/oaQtP5TFbDeHqw3VBp5t22jN4ONa7Ib6rZKNy4QV7SvDCFLj4FCYFZ
         DjzUrWH/LO+tcM1Bzz4Hi85ZjTePKwRcEgk4tg2xedPz3ZcFi/hxRVXEDDIUG/Mh+yZL
         7z2R2nCll8Sv65nx9v6V99VaHGghrMxo8XofumTAE/xBQKB5gBmEZlkmesvCACJY+Q1A
         z/CY9cCK+Xsl+ThYXm9BGCYbi6Ggu3zsjNjUAT05jlA+PHNlWFo8vfx8H6SEg4ounGiD
         LTPQ==
X-Forwarded-Encrypted: i=1; AKwUvBxF0FpAPr84X8E1zW/FJdnyXpu6pSfhYXs/WBsgvjjLge8tvKOQWI6Z/26twZDhUt4vPurS8Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYICMdDQpMT0toFAC/329I4MPKkGq6X6bM20aAIJR42g2y+zhiCd
	nRyyHnf9Dn92Rjvwxf8f6n3h9bfjqFvpsHJq/BxpynPCtKYGHU39N7uCDv3684lQnQ==
X-Gm-Gg: AYBFou0PuL7eBEIlAga98sOTqHYpojiYY1+7SN9F6ioTPrSWM2gGVXR8nrU5Vlc2suz
	KXHd08tnrqRtdalG8C5Rvf1QC/lSapaA4KscDWGtijHYYHlZ/yzFSIRK9boVwYpfMnzcywQcLQe
	RNInZkZe/IFoaZjk2S3p4r+y1ZNT/T3BhnrQuA7KfZawymIhvaacO4N7tr1o6rLEbJ/3Fpbz3Yk
	g3JyxdbDnRDEn+bTQq7oiRU8Jpk48WvdzNgDUezORBDYzcWabNkltiv3zt79xkriexwObP+HA8+
	vi3ux3h81QtKgrMf9Y09cqHTICY4Uh9rk6IYCEo6fbKw0PIyJ6IhFyeNq7IBGE537bjM4irjr3D
	sqXe0YNA3PdPaLD97ATSxu9PrmEQB68GKQ/guQcPNYVVAZi6I5JtwKA1Xl8wXKuQWEP7z4TVqoL
	lkCJh25IFRC3YnIwxCxSYqlz/zpGLRtdt8kpYIqRrm+8iqvMhUdayUK/Qd/kK2X+y8kWt97cUzK
	kqWE2i+mZjXiGoUYBfWJ1soyS2f+JNRICkrJJtd6/bLRu4NuEVYw90fWzarb4IDtNxbCsajIiSA
	RV2o9aDFqf2D17b0No6CB5NmFA95PJblunTRAevI6hTRz59uohuvq3bPlOT98138jVxFbMg/Chn
	Yty5YRaHBqUTYULnHQ4gcM3iwlOfeAN17FwdX+I75BPc=
X-Received: by 2002:a17:903:19cb:b0:2e6:23e5:4934 with SMTP id d9443c01a7336-2eb1ec7beb1mr12096545ad.14.1793389346146;
        Fri, 30 Oct 2026 12:42:26 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39052bb1sm12148735ad.1.2026.10.30.12.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 12:42:24 -0700 (PDT)
Date: Fri, 30 Oct 2026 19:42:21 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, David Woodhouse <dwmw2@infradead.org>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Ankit Soni <Ankit.Soni@amd.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Subject: Re: [PATCH v6 03/18] iommupt: Implement preserve/unpreserve/restore
 callbacks
Message-ID: <auTzCsfpkxOWRPHJ@google.com>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-4-skhawaja@google.com>
 <14cf71cd-35cd-45b1-a0fe-94d4a76e9e06@linux.intel.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <14cf71cd-35cd-45b1-a0fe-94d4a76e9e06@linux.intel.com>

On Fri, Oct 30, 2026 at 11:07:20AM +0800, Baolu Lu wrote:
>On 10/25/2026 10:19 AM, Samiullah Khawaja wrote:
>>Add iommupt ops for presevation, unpresevation and restoration of iommu
>
>... preservation, unpreservation ...

Will fix.
>
>>page tables for liveupdate. Use the existing page walker to preserve the
>>ioptdesc of the top_table and the lower tables.
>>
>>Preserve top_level, VASZ and FEAT Sign Extended to restore the domain in
>>the next kernel. On restore, the domain has only the preserved features
>>enabled and all the other features are zeroed. This is ok since the
>>restored domain is made immutable and can only be freed. A kunit test is
>>added to verify that the IOMMU domain free can be done with trimmed
>>features.
>>
>>Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
>>---
>>  drivers/iommu/generic_pt/iommu_pt.h       | 155 ++++++++++++++++++++++
>>  drivers/iommu/generic_pt/kunit_iommu_pt.h |  30 +++++
>>  include/linux/generic_pt/iommu.h          |  30 +++++
>>  3 files changed, 215 insertions(+)
>
>This patch looks good to me,
>
>Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Thanks for the review,
Sami
