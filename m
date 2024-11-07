Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101E71DFDB8
	for <iommu@lists.linux.dev>; Thu,  7 Nov 2024 14:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730991446; cv=none; b=cwPFFRQ/Rzq6UmxXza2YvY6/sFrO1Dh+RjDtKVczgkZEMkqameMcKRPzc3Fh/XBCfozSYtJy3BVWxE2QEPPIqVUiXbTXQTvGGwpBANi2WvklwwzsYgGsvz4n/1EU5SLSoiHky+D2YW0Mtzs3asdn+CEGTPBVtMnHzAxh1dBxRJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730991446; c=relaxed/simple;
	bh=4oQe+Icej/2WNW5vCCaIXNMbpk4hD3Avw8uhpLKdGlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=soTgt5hu5d003U/o9omklwVYdsmbgdgisuc6bKAS4O14Y4mNMBCRcuMMcheia7f7qjkX7E25G6wbwpsZ6G0vvY5vnXDvWwbQz4nx8XdkaltqNTwEAxZw2Tb2WVnHwHfgeIvbI3S9HewDh1m+4quE7rXwaUgFA6aLHBEOIUGrDbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jJOuVQri; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jJOuVQri"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20c8ac50b79so135095ad.0
        for <iommu@lists.linux.dev>; Thu, 07 Nov 2024 06:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730991444; x=1731596244; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H3IP9H2GeN6H9bRsrKXSg6cXOMMhpL5odgIORp8g2OM=;
        b=jJOuVQrinK05OAywt0WZgFUhtTMh2R0SiHftyou4vYh/YfNcDWr7qc8tjAbXNoYgqv
         zJzIqjQvIXFhYSIdFlBaBCWY0P7fRPra46FLSo9xmyq69SGRYN9DTiVCq9mT0wfQhUDY
         Q8NA05Q8XtlF277dzIgYvTaifZUjomzir4wMwZXwzZHHrg0bqKL9BSjAdcjyDGgJruo9
         mU/2A5mdXaPNS5mDRGLWyRhxWwHpi7SHu52WKyQ+fjvZ/SrTPAi66anbJn9Xk68+R7yT
         SoKNc8QCTCUr5z2G4z2vVDJNBdSs6m6lsMi8IN9PSUuyhdIkw7ZDbkHIwfBtJS7KV5d5
         JyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730991444; x=1731596244;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H3IP9H2GeN6H9bRsrKXSg6cXOMMhpL5odgIORp8g2OM=;
        b=xEkI8KSL18TcESFdQf9kwuah68xcnhXebF7LEE8VKsi5V0mVp7cNlE7on92tevYKvi
         jcyq37KRqKG5E2Ck5eaTqK3K9AsH7kpicT7vy4zv73AbZ8xZtGRhzjGkZckLOI78MkYh
         ZW9HYzmWQTQrw2o74RtWe3vdDaE8lQZij1b4Rb/bH9idRWRu5TTZW76SbULQg47QCCpf
         BiCqg7vxwspmn90V1yxEgg+V4+w9xmLhafvyf1sBPr5U27PmE0wwZkdNrUe4h7Ht5Vqc
         6T5HtoVf3YJXDaCHQjH3LlKMs5vY8C+8AOneHO1xOsWiGOgp7M4Kl3uwVej2w+R2RwK5
         Yl5A==
X-Forwarded-Encrypted: i=1; AJvYcCUDg4Xs/rBb+Yp0PYZyD48ZyP3XeGGSwCAZImEHYRvOX/TzocblY3Xmmlx5cc6LtdD3E7e2oA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWNK09a9GrXKGOnJRCACLb74BqJS2RfDDL1POtKotC5EFKCkZ+
	5pah9eSqXnPdkULVMwl14XqvpQpx/1iJkQU6XRNyWFXnhS9PcqQRAr99EGfzUQ==
X-Gm-Gg: ASbGncu1vRK710A5ai5GT+/2dpb/gIxDbEpNGiTPArMgjKk+gCkICqgytjPsxgeunJK
	4E+hHv5+m8i3g699tYOEQ4ZunOFfw826NszZMg94WMzmoUz0mrMpVmJBNN+5AfHN22Fta4NP8v0
	QmoQyVC5s0n+dtVeoXEJrOX1dvY9QvaLXtvhnBVm1gms2Avur7c8Cobvc5Thg+Z/3JBOdX/P706
	XR6SBnXjAeSjKtYqYOXur/2ehsEZNcf4sYGyVbTmMODzsfrytchFoBNW1Xj5/fgUv0lSaOLi2ot
	WtMvzji/wYs=
X-Google-Smtp-Source: AGHT+IF7sFW+3Eu7E9/NGdaVWYzg0mAjhpddGGiJTnKATwh9rAZalWZBEU1WwjMIeVbkfkhllN2A0Q==
X-Received: by 2002:a17:903:1249:b0:20c:8a97:1fd with SMTP id d9443c01a7336-211749a553amr3141425ad.19.1730991443958;
        Thu, 07 Nov 2024 06:57:23 -0800 (PST)
Received: from google.com (146.254.240.35.bc.googleusercontent.com. [35.240.254.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a571b3sm1672143b3a.181.2024.11.07.06.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 06:57:23 -0800 (PST)
Date: Thu, 7 Nov 2024 14:57:16 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 1/3] iommu/arm-smmu-v3: Introduce struct arm_smmu_event
Message-ID: <ZyzVTG8ffcFD8YFR@google.com>
References: <20241018180022.807928-1-praan@google.com>
 <20241018180022.807928-2-praan@google.com>
 <CAE2F3rCZALbQQUNeaAqShgXz6UNnSQAagqE7RA9kAewBFJNenw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rCZALbQQUNeaAqShgXz6UNnSQAagqE7RA9kAewBFJNenw@mail.gmail.com>

On Wed, Nov 06, 2024 at 04:16:19PM -0800, Daniel Mentz wrote:
> On Fri, Oct 18, 2024 at 11:00 AM Pranjal Shrivastava <praan@google.com> wrote:
> >
> > Introduce `struct arm_smmu_event` to represent event records.
> > Parse out relevant fields from raw event records for ease and
> > use the new `struct arm_smmu_event` instead.
> >
> > Signed-off-by: Daniel Mentz <danielmentz@google.com>
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > ---
> 
> > +struct arm_smmu_event {
> > +       struct arm_smmu_device          *smmu;
> > +       u8                              id;
> > +       u8                              class;
> > +       u16                             stag;
> > +       u32                             sid;
> > +       u32                             ssid;
> > +       u64                             iova;
> > +       u64                             ipa;
> > +       u64                             raw[EVTQ_ENT_DWORDS];
> 
> Consider removing the member named raw from struct arm_smmu_event.
> Compare this with struct arm_smmu_cmdq_ent and
> arm_smmu_cmdq_build_cmd() which keep the encoded and decoded versions
> separate.

I had a similar implemntation in v3 [1] but it was decided [2]
to keep the "raw" event array within arm_smmu_event itself. Since
otherwise we'd have two variables, one pointing to the other when they
have the exact same scope and lifetime anyway.

Do we have a strong preference here?

> 
> > +       bool                            stall;
> > +       bool                            ssid_valid;
> > +       bool                            privileged;
> > +       bool                            instruction;
> > +       bool                            s2;
> > +       bool                            read;
> > +};

Thanks,
Praan

[1] https://lore.kernel.org/all/20240928005143.2378938-2-praan@google.com/
[2] https://lore.kernel.org/all/5eda3ba6-c35a-432b-be87-48bd8a0a3bf1@arm.com/
