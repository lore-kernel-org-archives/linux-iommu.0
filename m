Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F99C334681
	for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784216684; cv=none; b=IlIuXZ9PHd2/YR+Sa8kzmRHYOObZy59iOQqLn0wr4oGuxPnhtE7cJ5wuxL+H4ELxUC78m4F2qm3Fbz+vWxNy7wCz4mS9AN7hLR3s6332OVmPhQltXyNJJ7WzwP7GJLxiFtLNJ8HJMHdQlREv2YwEWg8xbGn+UaAguBLs4VZniVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784216684; c=relaxed/simple;
	bh=MBNT4RmlhDZXOrdqScjFaMpobET3nW3VaZ0iff2/mQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lspJvpJ0QPp3dTzz1kPvftnH70aQ4XnrQUoYWg+ktWU1qEvAj3j/3dVnoiyUIMBUamEnF0HFOM+01W98+h2S1LP7AB9pmEZFW0g2Drmj7WtXu0k5K4jIHQNTehzTHnO29jD8OtsZalAQKG2osVMtalR7uRxJs+CHwhd6YL3+l5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=skUuWjIs; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="skUuWjIs"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cede6375caso14815ad.0
        for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 08:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784216683; x=1784821483; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RZnPgAsegwq5RNUmT4pZ5ZYEwWcgYfPlPFNTQ6BdGMM=;
        b=skUuWjIsHHQyIpry3RQPV4vloR14rfXGzXzpqddxgBT863NagBsgbknI5ZxVTB1RL9
         G+ojpJv2lOQDqzw9UkjCUixxZSdLDvabh2X/B0Q2+dKX6s3+bq/HLYn5sC/in4S5ofJh
         lUgHryRat9dCYqETDy7oB3xxekByonEmJailKnItxc++rIvEhC8wrbP2jTSUJq/ef4m3
         h/5j2MjSiolrBhOPXXSa/TS5wxLdnBwOxeSmgyMONnEVwUe+1ykPI0WYsg8u38zYDKD9
         AVnsQqtNywzlCvJ4QRu6TP2wW+kw355EtOqj73gAoTeiIwYVa3HYaskGpX+Sz50iz4Sz
         GCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784216683; x=1784821483;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RZnPgAsegwq5RNUmT4pZ5ZYEwWcgYfPlPFNTQ6BdGMM=;
        b=grH4M/jgatJlGhDYxK9MbwIzWxSPEJyax85nN4bMlttoR4NjO1UqLAMu1k8QPecLtR
         W+d4YOmToRavXJnRDH2dnqZzjmiIllezAZcgrHr8o6BUpnfXWdfC0HCpZ5QYXNFCDwIe
         dUf3kc0vgvMUK/ySfDo+E9MhJCEA3xiGPPbEyk8qDhP8wueb5fOSi4I5PwuF5zOgdzuk
         SjPcFvvQxQpThTeaPtMW+7OI+PyhnD9qAgyS0lh3K4vumkhNQw0ZV8qmGvWJK5qTX3tj
         Mw0y8m4iR0pafJi7EGfqYX0tGe+Xq0L5HPvmQzz2n+o/14HWHE6p5qt9IdoRcOZCL/39
         Y2hw==
X-Forwarded-Encrypted: i=1; AHgh+RrkaCGCIxH2a9ZwYPXMHxl7ysoxWdjmD81bZlzEXJftdulXdEviF2oli7RRs++STzxnhIpOTA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyUphvmcM1fe63UHmlrjw8qDdh8wfO3HRn4s8X8/NqnZkrk3sVF
	QiDB61pjSNoRFJDfQHmJhNQEpTyX9Hb5Z6o3NBEt/H7P6UGOyamkYCNbwH/tmpa82Q==
X-Gm-Gg: AfdE7cnhD2xkWE8qtISGDrZVjKtnXWr59s+utpBdN16QlUQQ3VOI5LELmAs39LJdHo2
	EtaBvTaewVoqTGTdVK5lCHe8aWONID5cecRp3JPt43kPRt4zGLUKKZ0twoBEvWnEIAzIYxrtGKF
	2KFLP5cq6WOaHhnuYdvaD4XxfLdVM5BxkFGRPvRKYGW+eha0gXjaDDVkGkq748cY54CPcj4sHqq
	3pq/gFECYQVJrVmIuheZ5GIkFV6H1/P7ZGHWCGM14aHf6TjMfrJ4eqh0W0upf9cErLS+D6FlcN1
	sdwuo46Z2LxaDiTRz4A/t9RhTnL40No6Ly9QaOu1UV9DWa027/PiIPdVKW1VooONGoxcC8Jmhd6
	Qi1Py7zPX8zHQVWjm2HBVr0S2bEWK54a4yQJKknSnfqG2lvCvi/e3XjCd/TzcYcYZTlJ3hbRsAF
	mMrjO53mqsyEe4mZ/8lJftI+0r88vqjHoDMPSq8lg9+5NoXFdE0euVL36p0WW5gEx/YlGGrppA
X-Received: by 2002:a17:903:440c:b0:2ca:e0db:3cc with SMTP id d9443c01a7336-2cf1dafe691mr2849285ad.11.1784216682206;
        Thu, 16 Jul 2026 08:44:42 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a532eab84sm4717586b3a.0.2026.07.16.08.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 08:44:41 -0700 (PDT)
Date: Thu, 16 Jul 2026 15:44:38 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v3 07/18] iommu/vt-d: Implement device and iommu
 preserve/unpreserve ops
Message-ID: <alj7u3eCPvPYofPs@google.com>
References: <20260614233728.2212104-1-skhawaja@google.com>
 <20260614233728.2212104-8-skhawaja@google.com>
 <f3e2fef9-4f8c-4032-8d7b-007f47b3fb61@linux.intel.com>
 <ajl7xfcoKsohfpPJ@google.com>
 <847f0e2e-abfa-4d6b-98a5-5e25ffe66d8f@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <847f0e2e-abfa-4d6b-98a5-5e25ffe66d8f@linux.intel.com>

On Sun, Jul 12, 2026 at 03:35:39PM +0800, Baolu Lu wrote:
>On 6/23/2026 3:19 AM, Samiullah Khawaja wrote:
>>
>>>>+
>>>>+static void unpreserve_context_table(struct intel_iommu *iommu,
>>>>+                     struct iommu_hw_ser *ser,
>>>>+                     u8 bus, u8 devfn)
>>>>+{
>>>>+    struct context_entry *context;
>>>>+
>>>>+    spin_lock(&iommu->lock);
>>>>+    context = iommu_context_addr(iommu, bus, devfn, 0);
>>>>+    spin_unlock(&iommu->lock);
>>>
>>>The spinlock is dropped immediately after reading the address pointer.
>>>If this is guaranteed to be safe, please add a comment to explain why a
>>>UAF or race is avoided here. Otherwise, the locking scope needs to be
>>>extened to protect both the pointer lookup and use.
>>
>>In the Intel VT-d driver, context tables are never freed once they are
>>allocated during runtime, as they can be shared across multiple devices.
>>So I took the lock here to protect against concurrent allocations inside
>>iommu_context_addr(). Once the address is read, it is safe to use
>>without holding the lock until the DMAR unit itself is torn down.
>>
>>I will add a comment explaining this here.
>
>As part of this series, I think this is acceptable. However, there
>is room for further improvement in iommu_context_addr(). We could avoid
>concurrent allocations by replacing the code below with try_cmpxchg64():
>
>                phy_addr = virt_to_phys((void *)context);
>                *entry = phy_addr | 1;

This sounds great.
>
>At the same time, we could also replace the spinlock with an rwsem to
>eliminate the spinlock critical section. Consequently, the GFP_ATOMIC
>allocation in iommu_alloc_pages_node_sz() could then be replaced with a
>normal GFP_KERNEL.

+1 to this also.
>
>Thanks,
>baolu

Thanks,
Sami
