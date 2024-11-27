Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2036A192597
	for <iommu@lists.linux.dev>; Wed, 27 Nov 2024 09:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732699534; cv=none; b=MZ5dGCBflAYWwdKCEc8Dl/mV1l5RKS3BaoDD01KOQ3dPQADZVybbvaTikA3RXBdIarSG7QwZbea8dTvRe3xuBryf49P3//1O5UbVplD4Zy7roKj3BlLOj+Gi7hEQCc33J4pRD/DVnH2CPXt6DwEjntjYHckZBwHfAyrsWeFVzQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732699534; c=relaxed/simple;
	bh=seKZdXSX8Foz/8XmR1HR0JaLB900a7S8smhCoEJmj9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGgF9LeiRs6dbSWJ1vDc9H+r6zN5jxeR/S6dp6Fn2+4yt6jN95XA5B698R9EJ6fF2tmLDsufDg9XwUDIjDZzdhDcqJ0uXDd77FXx7jp6v1qSvIibd6mg5r90ZHlZLVfl5T4XnsHA3CRy0pMoLCWZQciZT0KRZSgt2oiZhOmqokg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R5o78qxE; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R5o78qxE"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-211f1b2bf2bso99305ad.1
        for <iommu@lists.linux.dev>; Wed, 27 Nov 2024 01:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732699532; x=1733304332; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HLMAAdov+HGDC29SO3bwIsQ2RjggnUDbABkZmESg5/c=;
        b=R5o78qxEOU3Zza/HZA6ZVe4sklkQZQW4QTgcwuJ6HAMVHBABKvoxFgJ1g9EODO1dD8
         aDICC8yrAOnjhwd2J+68+WvfAVu1mlc22Kj6umJMscapfqSmiXYsT7HltCVAewLU2yGC
         tbzK/lmU2Po6CFUxa2YfqL8Y4ueD0gkGdH5lsHyao/j7AvdqG+jdROsDe6tbr7l38BNg
         zkLszIX1wF4XcJmV6DZ7vYOXtUxtm6UFy+IJyOgN3Ea9uo1klmy2pf6d6xMBPVlpTkg7
         T2C/RbE9pSCTbOpSdhtBNxbmL7TJMOzR+HMV5d+3yUi6wnrXaO6SzywfsSjDVt7pjb4F
         1Sug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732699532; x=1733304332;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HLMAAdov+HGDC29SO3bwIsQ2RjggnUDbABkZmESg5/c=;
        b=nIcISvILcCopXVZXDyHunKqK934Gl0WHXtWW24PfVoVFawwwNYwu64+GUD/TPeqrbe
         Os58mBrRQ769Zst4V53SOFLzul91JWFqI4reWwpgsa2T7WbLWz3L1CcWe/ySuhmeFtdB
         4Ob6mab/EhlXMEFD6OADmDXi6MLMR7AZoAuyGHi67Z6AOw9cSBxvvsFXtwK5o31ikEMV
         Z3TcAXVZ+x4EV3QIgoMX9Jo+A9AYAfDofOiLhtKtiKPELZq6lDD5kIEjSns9x7Apm8Hz
         xo0N7abSLmFMJdgvncOhbYiOCWn0Ec4qrsqWQNFqIr96nE12kX8XvIPdxEVYdlOWxdwo
         YXrw==
X-Forwarded-Encrypted: i=1; AJvYcCVZBAzGCqkFqGzk7BL/oWsZy7hzVtNYCIBX9pNWSYV6bX2Z8T4ej0O9D22HiQNU/Rk6qrWc3Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzFLZr5O5SFDdU8sXLHhfyGAdBOPQQuvWs8QCOx/TZN/lPCicCH
	u5HRrTEZ0MPkeGfck+efAozHoDEnT1J98O9ddrB4iKilzqET8QscuDiyYRS/qg==
X-Gm-Gg: ASbGncvktBteWhaUvffnbrkdSWWc5cM4RP6shA4HlNJz0Me7u9mCyWaSmMWX+y3/vUT
	VlhACq1hR2sARDe6zqbe7XYqQln/gHyq3imzqBKSc2KaMXed6Rcm8eIE+Wb1VH6kqg3JUR4yWHI
	4gZl46hPJgFKcVYZJ3SIt9cvwFo7f2Wx7t/q4tM37Nkzq+46qLgr9ApgeFwdjEyhMS4jNPv4a24
	EFhCxYzeoKsGThlGsP0DVh3yXdp6YbXhFBF5irjn1lasDEx8pVDL1oxnDaxeDKa2wPH8W9Uqw5A
	IfxdWe2O2IE=
X-Google-Smtp-Source: AGHT+IHhBwfE8lX/Ai7+LWC3x7UH49RUSH2b8UDwvDmK3Eh9S75DoDkr8g37LFJbMcbk/53kxCoZ1w==
X-Received: by 2002:a17:903:1788:b0:212:26e:1b46 with SMTP id d9443c01a7336-2150641c57fmr1414065ad.23.1732699532175;
        Wed, 27 Nov 2024 01:25:32 -0800 (PST)
Received: from google.com (104.132.143.34.bc.googleusercontent.com. [34.143.132.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de454a96sm9780505b3a.40.2024.11.27.01.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 01:25:31 -0800 (PST)
Date: Wed, 27 Nov 2024 09:25:23 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v5 1/3] iommu/arm-smmu-v3: Introduce struct arm_smmu_event
Message-ID: <Z0blg7wbWr05qp3w@google.com>
References: <20241112083018.1662104-1-praan@google.com>
 <20241112083018.1662104-2-praan@google.com>
 <CAE2F3rCO1PbzMEdJB1zRFK+FsbYa0w2TWrGL-XV6y9A9vrqytA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rCO1PbzMEdJB1zRFK+FsbYa0w2TWrGL-XV6y9A9vrqytA@mail.gmail.com>

On Tue, Nov 26, 2024 at 07:25:12PM -0800, Daniel Mentz wrote:
> On Tue, Nov 12, 2024 at 12:30 AM Pranjal Shrivastava <praan@google.com> wrote:
> > +       event->stag = FIELD_GET(EVTQ_1_STAG, raw[1]);
> > +       event->stall = raw[1] & EVTQ_1_STALL;
> 
> Any particular reason you're not using FIELD_GET on EVTQ_1_STALL like
> in FIELD_GET(EVTQ_1_STALL, raw[1]); ?
> 

No particular reason as such, just wanted to ensure a bool value as the
current usage in `arm_smmu_handle_evt` fetched the stall field similarly

I'll update this to use a FIELD_GET 

> > +       event->class = FIELD_GET(EVTQ_1_CLASS, raw[1]);
> > +       event->iova = FIELD_GET(EVTQ_2_ADDR, raw[2]);
> > +       event->ipa = raw[3];
> 
> Shouldn't this be
> 
> event->ipa =FIELD_GET(EVTQ_3_IPA, raw[3]);

No. For this, there's a reason for not using the 
`FIELD_GET(EVTQ_3_IPA, raw[3]);`. As mentioned in the cover letter, this
was the root cause of the IPA truncation bug, i.e. FIELD_GET only
fetches the IPA field without trailing zeroes, truncating the address.
For e.g. IPA = 0xfffff instead of 0xfffff000 which is faulting address.

Also, since the definition of the field is GENMASK_ULL(51,12) it doesn't
work for events like `F_STE_FETCH` where the Fetch address field is:
GENMASK_ULL(51,3).

Since the SMMUv3 spec ensures that the bitfields NOT representing an
address, i.e. fields other than GENMASK_ULL(51,12) or GENMASK_ULL(51,3),
are zeros. It's safe to read the raw[3] dword directly.

I think this wasn't discovered until now as we are NOT using the
EVTQ_3_IPA mask anywhere in the `arm-smmu-v3*` source files.


Thanks,
Praan
