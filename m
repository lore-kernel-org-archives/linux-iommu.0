Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7D13C063F
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747622; cv=none; b=ezUC+1GaVT+iNPl3l3ml74Xrde/8mrC5uONhHytMH1A9qg7wIXfvUWXAUe0/EesQrKvivY8/t36kDXeZSJEd8XDXJDMRXzGQnf9+zuYjN8P97Bl1+XRrdoI9DX0Hjpy/BNMMPj6MH073/fE2Hm49YjNPIKCQmaL3UtrI11pxpyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747622; c=relaxed/simple;
	bh=wTZ867cLvl3NEk7csUy7NtkIFljCREofjieQ4f4eY6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzVs6Th0WRQ296ciSwFOevfolpxPOKpfYTSzdfr/f6wkAxg+l9JnkX45Kh0g2p5x0lSpqXQd2NNO7NvlvbxHheyXsux61TOPOgOqBJbbOKyD7eJ9V917VhLNrzbnYNZr26BHwQiNC8uQRWBNzf+QNtZcZtJW8U39IoFRi2St5G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=dZT4vYGK; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="dZT4vYGK"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-519eedc30a3so33870381cf.1
        for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 08:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782747619; x=1783352419; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VwgemlAWVZOfyfvrJ+7cyHmQGRLai3JgFnH6EFj5//k=;
        b=dZT4vYGKcz19n0TwwHG1zDIsyBQ5YZSd90fIQcZJrGVdUJPF1A78XW5JJHpIAcJdDp
         RMRd7gFoZmDvu99N/EK8T4i5uVPPDczSxv+bFB7yaMi/e7bJPJTw5TJgAI/ieilxgFvS
         pq7q/gy/wuUOWKlFozYd8cnQ6rxnSkwwXyaS4BNuzvIIydhBqM1cQ+foSDbTz59ecL+b
         Oh7NeTvw/u+aL/BNYEA635pa1KDy13LfdHVFXCAFJGIB3/bXDDHBAAb1yiTpBjglwlGj
         X7U1nDQ4cKGkNusLIDSyqWROgZLCQ0/Q1h3tqxkSIqLHM/eBIXSeglzxUoYCymZv+Ge6
         aIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782747619; x=1783352419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VwgemlAWVZOfyfvrJ+7cyHmQGRLai3JgFnH6EFj5//k=;
        b=c2tm1YjNGZo/28Qk2Vk4bXkpZko/n6oJ4FXw2FGKn9xTRUL1VfWjtTR3rbTL+lcVkK
         s8cWeL9luC7EEoF9EpGb4brtOMeNOUlcGukYRMzsNIM0Ka+zYFkUZL0ceQ99kMcoxLgq
         9qSzO4dUNjD17pbBKYOjj8RF13uLV79V5FDPYKRTQ1F87SpMzfhi/2/wnT6+7YC4gaUj
         EFr3CsAMGctGDGJh4t3r2x1N4YLTJWV1v41sXiaj+Pwul+up0GHs9uQlEAqXI1aAIFTp
         DFUujuK7rp+9AttEq91lkVCHDddKSTcVIUW72CWIaFomMTB46TuBdNFYRI/Vps3IQZig
         OUhA==
X-Forwarded-Encrypted: i=1; AFNElJ/8RCSR3GNDUqB18zBsWPIH9XnoMo+9pPD8wgvx1BWcBIV9zoTVjMvyh/RFbGXo4TToOA0B0g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz0+rmuQathIhWp59mceeNMQcykXkuu2SmMLSCxvRRbaoClbprQ
	AwXlI7yDnkP/3c2N9ngR7oyq/39qrVTomRmuWStH2XH7JKGpbHztpaDEMDxUZrY/SUU=
X-Gm-Gg: AfdE7cnYB/uh7uUqrIfHdfC6Kd7T1C5w+u2YBiBVozOxbDA4yWrsXxqpxyF4N8vLvkZ
	DSul8d4obLjlTP0P9r+5J8Ti80TguNX9EVaHEHhtRPXHCxehlYdWzf7BrzTwG+7JicRt1vlSKiA
	bkCA1ncJjcdJZVOo8PIvCQfYglzOYSr0Tzv1WyMePPykbMTmP3PR+MY1gChksNZr3C9/b0UvKlp
	Uz3b5w/Ht+wI+oDUZiA1AcGFGPE79q7tQetwC1T2V0ZYzkN+Gml1Zba5gSaFPgtBVh4epClZq9p
	S3m5WoR8S4n/0DQCKcmh56ylmH4hz5+b4mes+sincFD07cSMqwqydChsgn60s1rgok3WcTh8Kmd
	9yJF8VwC61EjrDPAyZoOqoQWyJPx4hC8w+IkgWUrQYwQzbklr7m0L5198TZHn4nAsmGQomtT08m
	Zs6ZeXqFtC8jZPZjTw54CgUB+8QOjwzLMqNaqeAmi7Uionj1Ybgn9AZa3sXSVzM2yl+TfS
X-Received: by 2002:a05:622a:5987:b0:51b:f635:9aa1 with SMTP id d75a77b69052e-51bf6359eadmr68650541cf.48.1782747619393;
        Mon, 29 Jun 2026 08:40:19 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a876c888bsm78114501cf.9.2026.06.29.08.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 08:40:18 -0700 (PDT)
Date: Mon, 29 Jun 2026 11:40:13 -0400
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
Subject: Re: [PATCH 03/30] tools/testing/vma: use vma_start_pgoff() in merge
 tests
Message-ID: <akKR3bFV7393yOUs@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <b501eca378b9d9734e83838102aadc9276590fba.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b501eca378b9d9734e83838102aadc9276590fba.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:14PM +0100, Lorenzo Stoakes wrote:
> Now we have the vma_start_pgoff() helper, update the merge tests to make
> use of it for consistency.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Question: Should we have primitive tests for vma_*_pgoff() since
the behavior changes depending on file/anon?

Nice to have the cleanup and clarity. Maybe worth asserting no
one ever breaks this.

for this patch though

Reviewed-by: Gregory Price <gourry@gourry.net>
