Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC4843E9DE
	for <iommu@lists.linux.dev>; Thu,  8 Jan 2026 10:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767868952; cv=none; b=oB5rbHdavTFzba02BjBDfVoHvWB87lZrzyEvZzF8wD6V93wJJTC0LiRGAaZVRXUZ0hvmqaz4IURqjV5KgUnyL4B9xZfoYV57XPkY2/PNzC3yhc1uvij51b5pIT10ttLHuRNxSsEdda8GiuuBPvu+oeG9STfYL+tG+HPdfMhIMK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767868952; c=relaxed/simple;
	bh=7jKXaItOB5HW6uJMPUGoE6Z1+rU0TW3Ya6J4u86JvQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nX9BlI6hc5rwt96JJsYStXHuf3MUWJfWzwrm/RZFBpfzepMulggiC36LKjGrPQhLQrcRD3xfzHjO7lTYxaQ8tAJ41wEHAmdkoMsCA9lxEnOQ9ol97ZrjSrWqmLPWpM62Byz7xtmD7XldMlKo1E+kVxXY6pyMB/i9hLEQwN8E7G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yaLn2s5O; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yaLn2s5O"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4779e2ac121so128095e9.1
        for <iommu@lists.linux.dev>; Thu, 08 Jan 2026 02:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767868945; x=1768473745; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iCksppsN2qljq533bVWKBzGPs8aXT6gZzyjV+hGv2Fs=;
        b=yaLn2s5ODKSsHJHtBt0U9fYIpdUEnnwxQCk1nT8DGOObmJHE1vfuMNMh2uczpRHubJ
         S33Urk2h0FKorKwe0/sjjVHheqkNayzdQBWncBCSEzonzLFYYDdcf1ZQYqf6hNgbgz7X
         CVWp7Xn++mxvUmZoFvTPr9LQ8Dvu3Lbo14WDD1hf0gxcaAqbM9hHkRUYgCszhfLeY7D3
         No9GDwzwyp2EwwDmqLUYFo05/vN4qk24qoZj/2Ia0zsM+HZUPxlZ0qY9uzLwmju69CZ5
         pYfes9AO0zIVY5ZMhipD93VdpvILSelifXuVnYOHH37J65Sn0vnVt5e3KyDiCZeNGFga
         Zqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767868945; x=1768473745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iCksppsN2qljq533bVWKBzGPs8aXT6gZzyjV+hGv2Fs=;
        b=dz7SEzBJQoy/rS7LC0rs1kUK0zO8yGvxbeMyfH1+1qcsAMXxrbtA/MvEsMZMM1KGe7
         6j9kLG0s538aazRjqa8NI6AC6SbwD3wcBqTxI5jnrPlsup7MO/Y4MaJYMVDIMPY0D3XT
         3kCTGObCnupTN4jSGUt2pGOn65aD3EwPfB/TCCV5/LIfEpdtKZymC7/1WHm44diqBC9X
         azQYt6YUK9tIb4FHXCWubTSqWRFe8R5As5xKCprzSZJGj3InsB9nqNaMCKFCA1Faulm0
         Dol6egpwOwPTc5UeMmONcsj0sQQqzX26SGlNmQN+WEz3QwTAW5lLk1Ve6lDqSqngZCR0
         t5eQ==
X-Forwarded-Encrypted: i=1; AJvYcCVibVj4XMsNkbZfqaO+IlJNFPUh+RmerKYtzXfyqOYz5CLvaZhQZwWeU95iqoYZBeJ5EVkwIA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwRz/YRfN77z6NpR73lKsBzcEkjVHwD4oKDGMy0xUjqB4msbmEl
	3JanuJ08fQh5PKRWJ1pkB9+BJ5OnsgwmwX9yLp4nDd4U36t7KVLLDrK0GdUkbRo8Kw==
X-Gm-Gg: AY/fxX60xsSDBDLxTyCDeReO/0B+J7vTg9Y7yaO0UY/8Tl68KL/bmEOJKNsPYRnZyBn
	foBu5qEAdeyivw57BvnzDrKZHYpyMbpNWS+dTseqgSQQgrb2eLM4/lmun/SQYI3l2XT5PSzJ04F
	rCpqTL5Q5hxOz62VhMXRHQ5RXvgA0Qs0458gzeF2xXxs5DWj2a2yOMta8thxOad/c4mNbUliPii
	QdPHMezB+yLr+IEUx5SwvfHxqf7/kE+xX2c40DpvAaI8GcS6aFW/iyXbJe6X3RfQ5E8avlhYO6d
	HbhMYP5BZGE2XaeafdDmLrIy1DhH3roz1Z8C2xJK899kguTNPyfrjfpQUXFiCI+4exWEE6cuKIs
	pGP5lrlI4Tm1ezp9Qr8j+rHVBxMMx5nLYVbb3fPRbw896wmRdbLVvjFUoxDJdQR5oAvatniQ2cV
	pAoFoOXYl7LMz8VS2ZEoehm12n2/it8ClV8cXjAgljLldbLAY02rKu
X-Received: by 2002:a7b:ce90:0:b0:477:95a8:2565 with SMTP id 5b1f17b1804b1-47d8ac3eea6mr350785e9.16.1767868944788;
        Thu, 08 Jan 2026 02:42:24 -0800 (PST)
Received: from google.com (171.85.155.104.bc.googleusercontent.com. [104.155.85.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0daa84sm15517528f8f.2.2026.01.08.02.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 02:42:24 -0800 (PST)
Date: Thu, 8 Jan 2026 10:42:20 +0000
From: Mostafa Saleh <smostafa@google.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, akpm@linux-foundation.org,
	vbabka@suse.cz, surenb@google.com, mhocko@suse.com,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	rppt@kernel.org, xiaqinxin@huawei.com, baolu.lu@linux.intel.com,
	rdunlap@infradead.org
Subject: Re: [PATCH v5 1/4] iommu: Add page_ext for IOMMU_DEBUG_PAGEALLOC
Message-ID: <aV-KDEGlplD5EkBx@google.com>
References: <20260106162200.2223655-1-smostafa@google.com>
 <20260106162200.2223655-2-smostafa@google.com>
 <1a6aedcd-34c2-4e26-b07e-6eb8d423b759@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a6aedcd-34c2-4e26-b07e-6eb8d423b759@kernel.org>

On Wed, Jan 07, 2026 at 05:53:50PM +0100, David Hildenbrand (Red Hat) wrote:
> On 1/6/26 17:21, Mostafa Saleh wrote:
> > Add a new config IOMMU_DEBUG_PAGEALLOC, which registers new data to
> > page_ext.
> > 
> > This config will be used by the IOMMU API to track pages mapped in
> > the IOMMU to catch drivers trying to free kernel memory that they
> > still map in their domains, causing all types of memory corruption.
> > 
> > This behaviour is disabled by default and can be enabled using
> > kernel cmdline iommu.debug_pagealloc.
> > 
> > Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> 
> I think I acked it, but maybe too late for you to spot it
> 
> for the MM bits
> 
> Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

Thanks! If my mail client is not acting, it seems that was the
same version(v5) also.

Thanks,
Mostafa

> 
> -- 
> Cheers
> 
> David
