Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A430382370
	for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 19:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783710520; cv=none; b=Z7CtpeqRZ7TITfG6VYSigotnYch5P4pJGt2X63mvqgFLCdhWLsjLEfvwIuj6/U8bWtYf67rRMdDf9/FeMC4Djvpj9FjA4p5sY/+55xBtE5slRtLUrzrSGKXG/fHs8OZ3GchjvpDxyY3mwcHvGCfkTwr1raw/HM8n+qe4xOs4Jp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783710520; c=relaxed/simple;
	bh=HnhvpODSykZGd0gC/qYJbWWYfTQ/iP5eixsH8/fLwto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4innG9d6q/jsWXxY2pZff8Q8jAlBTpBJR5Xkp+5iPJBy7O2mzWOMc8idQFmYJ09JKa0AOoXutUzDcjgA8ZHRUtnjUGMlbtzHEzx2thfx167Dh/4r6sk1cDMe/3p3Y5+99Ay2Wf01vVbVtGUNQtBKTiewtVLkI/8A798IGyo/bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=U7Y+WUUw; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="U7Y+WUUw"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51bfbe05683so7627041cf.2
        for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 12:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783710517; x=1784315317; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iFtVuusRSG4YUFzvnh+nyLwKm1T7E76ZywXpwPdPfD8=;
        b=U7Y+WUUwcUXj0Ho7v8eb35AK58hWiJ3+WbygjnMIk666WQuKqtV8piYsecYIuPgqis
         LYBXORmjiQzFuqw4akrBICh1LNlB7xtOClSJiYk6jKNOjLbBjS9/1cuAhKmP+1xgzoxs
         jLRW3Ay2PezWyC9kZRaiXepYU8SaFbDNElkekaX2AfHeWQgq0YBkAzxVr4gN1T0IVBKL
         IiMVceKqOOORuNaV7MhQy5oHmmOmKL8VMEAJ+btY3tDh7wrY/tbBHhvHeZlCwTnku7T2
         qKsffvOenkQ8zH4DR5ZpBDC4CIprVe2hHzJu7WUdPbP10Vx5tu/aJoc7hrfuKHPS3c/X
         pksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783710517; x=1784315317;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iFtVuusRSG4YUFzvnh+nyLwKm1T7E76ZywXpwPdPfD8=;
        b=WcSBWVvOIlJbBLG2pBXviy5TQx5JDyf/ZO2EhB0OngyLSGoDeycDY9sLkDx3Q3K872
         w9YW53b5bVtqgB4ZBSbW4bIr/7uRRgo1OurO8n9hY4U0qzqT3SW6GqbFFWuJ8jLOX67E
         3C2C3elhlI7wVXjE0Qmuk9qDNq6+X+VLSjq3rhif7tPblW6xQTRTcr01tNj9De4qr1mk
         9nXeTVOoPoOmcdXXlxZWZsMJ+3ptZCb6Ae0E65MJu+NZHLWhTDg+q/4Y4/4HlwIYo4bK
         GEx3u/+AAxEd7QZG22NRMh6mNtmw6wa3KLpaUS7qrW7ADAz6/nIKglmUCulNsXdlfNdj
         cFIw==
X-Forwarded-Encrypted: i=1; AHgh+Rr1lVKn9y0rczg5wsqCuOWtUCOpteT/ilg9wHgm++vuKwvbR4o248/HTzKj+F2QuJGm4t6O0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwsZyIX7LzNjH73SA1BIrdEuF5DUn8YCcGVK3aGsbSnVqDiTmGn
	aSa6UBCt4XWJyjEzZ7YNQA2ms7/wHYMXfxKzddd3wXVeN/Own80PdMvxFEbpv9Gxcus=
X-Gm-Gg: AfdE7clv9gIGCARjlJjeZhhE25FxApYvyjdAOcgrl1npOlXrSY6O+Kr8MrUmaRTKC/H
	o9VylnW9Q+G/bJ1lSVKFqNgz35QRUHcuqHGbOOXXZpNutaIPC5dPVkXHhxdKqoxavgRecMoTNWd
	LJLXSKDtht+tCMUDLdNDvtnufhzRihNKnkc1tJB5qzMizmQOHU8TMhT3GUvoHA3CbaLrG7suOHk
	3EH8M3sj/a0d/rtasboyZPn9P3gysS+RnrD84OdlgD7XsiekOtlUlLir8hDH6N6D9wu6Esxvu37
	A3r/AtOppOmafPDw8+wLRvfKt247Xdigske8LK/9xJZeqzB/KxICLwODebXtb8Oq6IOy57/wl8i
	t4yeIxqLNVou2wRmpim8PAwhBriNGxKtZWBskCw6XpRRxH+g/T298YRvRNc2q9k+PpnPOAdqx2o
	BZ0i5P87ZkkKNGyjSCj2i5Wn1ubTOSwPuRMGeyRNQ4v8Vz0O4np6vKxV71dZfXUDyWZi4N
X-Received: by 2002:a05:622a:1818:b0:51c:b900:513d with SMTP id d75a77b69052e-51cbf280a8amr2226311cf.53.1783710517321;
        Fri, 10 Jul 2026 12:08:37 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd7c1da1bsm47847566d6.30.2026.07.10.12.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 12:08:36 -0700 (PDT)
Date: Fri, 10 Jul 2026 15:08:31 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Russell King <linux@armlinux.org.uk>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Simon Schuster <schuster.simon@siemens-energy.com>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>, Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Dan Williams <djbw@kernel.org>, Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>, SeongJae Park <sj@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>, Hugh Dickins <hughd@google.com>,
	Mike Rapoport <rppt@kernel.org>, Kees Cook <kees@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
	linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-mm@kvack.org, iommu@lists.linux.dev,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	damon@lists.linux.dev, Pedro Falcato <pfalcato@suse.de>,
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH 22/30] mm/vma: move __install_special_mapping() to vma.c
Message-ID: <alFDLz9_oSSvHTuJ@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <b3254231831037ca3e9757e3e05c90072e04a6aa.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3254231831037ca3e9757e3e05c90072e04a6aa.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:33PM +0100, Lorenzo Stoakes wrote:
> This function is operating on VMAs and rightly belongs in vma.c, where it
> can be subject to VMA userland testing and allows us to isolate it from the
> rest of mm.
> 
> The _install_special_mapping() function will remain in mmap.c as a wrapper,
> since this is used by architecture-specific code.
> 
> Doing so allows us to isolate more functions in vma.c for the same reasons.
> 
> This forms part of work to allow for tracking MAP_PRIVATE file-backed
> mappings by their anonymous virtual page offset, as doing so allows us to
> isolate and keep code that interacts with this together.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>
