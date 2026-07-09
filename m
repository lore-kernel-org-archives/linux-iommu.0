Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7D411CAF
	for <iommu@lists.linux.dev>; Thu,  9 Jul 2026 00:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783555568; cv=pass; b=PXcpAG5pWNHZvyGYSnDPu7cD2UAyasSlQbi6CS2hU9jaSuToE7S/wvCcTasxTs6OA2NG0ygYrunXf1HnnueIdPbGcwy45KcdGQbeP2o4HnwzhYNs52pwpz3+zupq8VfCJF5nOOH1JqrEqLsfwoMfrR/Y95NS4wDedn1Rgxuznhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783555568; c=relaxed/simple;
	bh=yJaHiIAKdt59/nUs88AHXAG1seHCynr9U+jmRjUBOEg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xr8I7gO+FBZwTiL8OSr00MP+2+VWZooOFx912C0lL86rIGo2mBSyp540K2GSgFj8qb3BhxqLjFM0s/A8e5kA9Mu+WIO4IgR5FbHTESxTpmY0WZu3Evb69KzgQiwJ7rjJN+fIHul5UObb8eal5IhQe27HjmpuYpdAmm6PauxsI6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mhJVIkM4; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mhJVIkM4"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cad8076b01so15237185ad.2
        for <iommu@lists.linux.dev>; Wed, 08 Jul 2026 17:06:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783555565; cv=none;
        d=google.com; s=arc-20260327;
        b=ZXej0q50Pvtu28NjSchv4R6qXCcMvfcEi8WqESa7ThTFuOriKtZ8tDwxJP37B+3OSY
         kMIKNATzQ9ggRNIRECyMHr58693ojqEeFtVJeUt2Ye9vs0Gy4mA7+EbarrDUuSCnkQg2
         r6S5kFvqy6pPyF/BbJ1mXhg4uHuJviCy7UIGCKscqrgqW0PpMvSTHIU3JDs5eeYMjoA0
         Gd3RsE7CJjT8epGUQZHjlyxassutan4aD8mLX6TNXPmKqgfVXd6a7TMOZRA6ktEIguAp
         BZ6E8Rv99Hc6rsxiaxobdPoc7agwpPWXmA8O7E8eu+934+lQAqc/Iwlb7U3YX3381pSL
         fYPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=yJaHiIAKdt59/nUs88AHXAG1seHCynr9U+jmRjUBOEg=;
        fh=IqEPXXgVquTZGVSQgg4zc48fdt5zjanX4w8+MfXUA/8=;
        b=JG18o5os/z3/GckxjK5eS86TQ7YHGjFjAnwKC9zhFEYmKKl2qRoA9TxaO8Q8+9031C
         uTYOenjmSz5Gpve/GsaGpjRVX9jBRR4p11QrHfKIPAIY3twE0toTwxlPo6MPDQ8sOvx/
         xl2W2nwBhIJma/+KcS48Jhkfa/UjbJBkGz690HHaB6VFEhTg7iHZylitZ42FpLvyFViv
         +bj2Orkil8ldq0TIBxdJoE03UNycgKwkYTIyHeaP510xYodue42mGE6C885u9+lJ4D28
         7Tw/eOxwzZhEBLh0IoaZbzWkIA2qcbL5mDsFK7JrzOGYBAMPOPcWYLAxb5mSl4Plg7Sy
         mtCw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783555565; x=1784160365; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yJaHiIAKdt59/nUs88AHXAG1seHCynr9U+jmRjUBOEg=;
        b=mhJVIkM45OUDuijRQhJCGxMcU4BVaSp09AqI2hnS8Ki6Y6RNFNMGZ4/s5R5c1f5k7g
         ziB/d0CifLhaaoJPcgMNTX2C4Y5sePITm80rllyzjo18F1N2XBSAFdelBGxCML25Dr+H
         i/IOXVXIVf4nt32cpdS6iwjJ9QA/wGCnpVxulS7vrXczeqHIgpKYKq7NRz8vrh98O7KN
         EUt7H5pa/xxqvKGKFJcdpcFeD/+SbVJVYdZwcEFNbf2iwKW/Kn2h13I/J4BZ13eC0LT4
         DRrg1nj9suGX18iFVRUHlOkjYa0e75X9oxIKH+8iJ8QKKqjLU0//McufwrR9QMK1tg7x
         /CXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783555565; x=1784160365;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yJaHiIAKdt59/nUs88AHXAG1seHCynr9U+jmRjUBOEg=;
        b=adROAkn+M+D2e45PXTQXWFMLM4lRvryiwEDBMaNyQApybtl7WqfBhfJ5gwueoakdNW
         y2Y+I/L8Q+crKzQpgMMHaGUYK+FYoH/O7PEge8nzC7961sjkQ9ZjHHuYibzBxtT2xuWB
         Jmi4p7LgURPZMh/aBDEobhpB2dpxzb0u5xF8wRDo85bFRYRysPiJd0KW7WzNfj1bEaX4
         fdOzIkD+Yeg0ruEdeyw4AO/JeqAyUphFb+/oOXqPH7XnOKflKHbH18OqdFTWTcLerbjT
         DRilBX2dtWNY3QKNwl2ZJUfh56u8FjFtr3bRjui+UexRYFX9hNtjuv9OQ3aG2yXyHtyx
         3c4g==
X-Forwarded-Encrypted: i=1; AHgh+Rqf2QF9G5MkxHB4CaJLkNQ77HKGA6QI2b1BpiW72uUvVQfRcOzhcVfTGGRvxLcAELyTOhQLaw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxjMtQ38VQxYlHgyjfmTqu4tn7bAh8ogcdLVkumBTphU0J8u2UX
	OTrQYLjJyIt3b0lPkfVTuqb1DVMLqHlwnB6wzD19RUlmVoQbT3UfOqDslo7an3MIdjjC9tHuEPh
	WNEgQsX2/dHP7W5sSfR5F5ZUgfXYQnzknAYPTPuQT
X-Gm-Gg: AfdE7cmOJGYNT+Ftj3VJaBcr1urxpQGmy3q5fEccR1/JovmdfzvxU/yVW4teAI4rG01
	lR3yeo24ZZCG/CCZMxjXYI7GPvttGOiw749pbU1dGuSv40PBdHZ8w34FXfE7lrXyHFdElVWIRvO
	dvxJ8Q8Migm0zUPazqG560yJcunYDEbBKXKdwg58UIMqP3tY3C/9vcqtk2LBzm11OjqxwMTKa60
	qiMrE7n8ImkNwTIJvr61D2ZUK8g4Fd0F8tymtAdqzowBJPjBWiCmOW/mzfNlHuwWJhvXblU6fR3
	9IhCckxmYKMKzM6G6+0xelkSwbHm85F8u3CEWDg1Xm+LLIsZTrlYD3o7JbwKpFNyMsChGg==
X-Received: by 2002:a05:6a21:7482:b0:3b4:669c:ee32 with SMTP id
 adf61e73a8af0-3c0bcbc1353mr5760887637.37.1783555564841; Wed, 08 Jul 2026
 17:06:04 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jul 2026 17:06:04 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jul 2026 17:06:03 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <eedf589778aaab33e6df2ad6556dcde536e13460.1782735110.git.ljs@kernel.org>
References: <cover.1782735110.git.ljs@kernel.org> <eedf589778aaab33e6df2ad6556dcde536e13460.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Wed, 8 Jul 2026 17:06:03 -0700
X-Gm-Features: AVVi8Ceg-PSWltTScKU18ZF0mdbBsNHDv0s-VKhIaqzjwQ-q80D6zfZMKk_VWII
Message-ID: <CAEvNRgE-JJAzC0jp+bY8+e1+gYSH+MjT6JqX_DfCcpaxOM-Dtw@mail.gmail.com>
Subject: Re: [PATCH 15/30] mm: introduce and use linear_page_delta()
To: Lorenzo Stoakes <ljs@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@armlinux.org.uk>, Dinh Nguyen <dinguyen@kernel.org>, 
	Simon Schuster <schuster.simon@siemens-energy.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Ian Abbott <abbotti@mev.co.uk>, H Hartley Sweeten <hsweeten@visionengravers.com>, 
	Lucas Stach <l.stach@pengutronix.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Clark <robin.clark@oss.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Thierry Reding <thierry.reding@kernel.org>, Mikko Perttunen <mperttunen@nvidia.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Christian Koenig <christian.koenig@amd.com>, 
	Huang Rui <ray.huang@amd.com>, Ankit Agrawal <ankita@nvidia.com>, 
	Alex Williamson <alex@shazbot.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Dan Williams <djbw@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	"Liam R . Howlett" <liam@infradead.org>, Matthew Wilcox <willy@infradead.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, SeongJae Park <sj@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Hugh Dickins <hughd@google.com>, Mike Rapoport <rppt@kernel.org>, Kees Cook <kees@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org, 
	linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-mm@kvack.org, iommu@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	damon@lists.linux.dev, Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"

Lorenzo Stoakes <ljs@kernel.org> writes:

> It's often useful to obtain the number of pages a given address lies at
> within a VMA.
>
> Add linear_page_delta() to determine this and update linear_page_index() to
> make use of it.
>
> Add comments to describe both linear_page_delta() and linear_page_index().
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

>
> [...snip...]
>
