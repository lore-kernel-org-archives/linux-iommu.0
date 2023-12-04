Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12AD33CDB
	for <iommu@lists.linux.dev>; Mon,  4 Dec 2023 20:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hHZwLGIW"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5d3a1f612b3so66814617b3.1
        for <iommu@lists.linux.dev>; Mon, 04 Dec 2023 12:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701720707; x=1702325507; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YpOU2ooCLv1IE731eabYKj790tbuwogyFPv+sco5TvQ=;
        b=hHZwLGIW6YPsvKHk/LaZSPAwrQbi7MzAaJA6AKnHfQ0GnRapeSGvQqJ36dxdfxn0J/
         w8ZvLI57ULgkDE8DOBu6vygKGTUv9WHXrpouqcQWuRLyL7ysCN7222hriYmi1MDDPof+
         OUuhFuBsc6+EHb9XEF2wJT3xFafIdj+NhMeMV6nLkBV2HOoKMtBasKAu0dyPpx9yVPoQ
         /P3XFKCwSEOgyOsyP1YCcHhEAyH7h+AZmLKIypX4j7XP/FLcsYbcf7WEVLIPiAatpuR+
         cW7FiqFmNa5UYhZRn1hRUM4pptxWfzsbznbgbbDyj64PG+slwAmKvKsw0U5KSKBYURhx
         P12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701720707; x=1702325507;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YpOU2ooCLv1IE731eabYKj790tbuwogyFPv+sco5TvQ=;
        b=B0f8j4meUgDZdU7PnSqCHGmJTU/oOAENHT+SF2DqeKSWIY951b1Cy/Q3xmNdJvJDrK
         Is3HCnSdzoH14NxZfEvbBrcgk0yUXix7/2bNk+5qH8ADrrmkil3+aDKs5eUVjaWV+S60
         9hycZyNEvLjv6WSBovgINUPXIHBTLXBmuu6VddtmhaF1AebX4qtGzkFMVNYRVY2AMWtk
         1lel3NRxMODBaCF4H+RdfMdxZa0T3EDUXX/2SeqIQNAhOim2UPRKdvzhRDi5Vx2H1zps
         BEMj/01ADhw0Y6YR5uJpxeEglfYDsJtgOTYRMj4mMYkgphSIvHCInn3lI6ukK42xZIKN
         uocQ==
X-Gm-Message-State: AOJu0Yzn5ApNtyPleHYDCPhpxwPJZpVLmH+uV0V1RKQzC16LK6qBHBq4
	8echFnXYa+ASnPY55fR/DZflj+CHkMY=
X-Google-Smtp-Source: AGHT+IHLvL7F4SnML9BnJOEYkMPzq+JUrdFdxVVPR0p4zxv+RrWuH0X6xOW9Hg/+32yf5Zr0Hl4RQumsq8c=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:b650:0:b0:5d7:3abb:1424 with SMTP id
 h16-20020a81b650000000b005d73abb1424mr169600ywk.6.1701720707487; Mon, 04 Dec
 2023 12:11:47 -0800 (PST)
Date: Mon, 4 Dec 2023 12:11:46 -0800
In-Reply-To: <20231204195055.GA2692119@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20231202091211.13376-1-yan.y.zhao@intel.com> <ZW4Fx2U80L1PJKlh@google.com>
 <20231204173028.GJ1493156@nvidia.com> <ZW4nCUS9VDk0DycG@google.com> <20231204195055.GA2692119@nvidia.com>
Message-ID: <ZW4ygoqOq2JpXml3@google.com>
Subject: Re: [RFC PATCH 00/42] Sharing KVM TDP to IOMMU
From: Sean Christopherson <seanjc@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alex.williamson@redhat.com, pbonzini@redhat.com, 
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com, 
	baolu.lu@linux.intel.com, dwmw2@infradead.org, yi.l.liu@intel.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Dec 04, 2023, Jason Gunthorpe wrote:
> On Mon, Dec 04, 2023 at 11:22:49AM -0800, Sean Christopherson wrote:
> > I'm not suggesting full blown mirroring, all I'm suggesting is a fire-and-forget
> > notifier for KVM to tell IOMMUFD "I've faulted in GFN A, you might want to do the
> > same".
> 
> If we say the only thing this works with is the memfd version of KVM,

That's likely a big "if", as guest_memfd is not and will not be a wholesale
replacement of VMA-based guest memory, at least not in the forseeable future.
I would be quite surprised if the target use cases for this could be moved to
guest_memfd without losing required functionality.

> could we design the memfd stuff to not have the same challenges with
> mirroring as normal VMAs? 

What challenges in particular are you concerned about?  And maybe also define
"mirroring"?  E.g. ensuring that the CPU and IOMMU page tables are synchronized
is very different than ensuring that the IOMMU page tables can only map memory
that is mappable by the guest, i.e. that KVM can map into the CPU page tables.
