Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F56E434E3B
	for <iommu@lists.linux.dev>; Tue,  7 Jul 2026 16:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783441568; cv=none; b=Dy1YG9AVxGFS0PPXkRv5W8BYqeyUpvR/cKlM2bV6Du+047mZmu4RC/nAfNNUVPgjMtz5YbgR0g/YWWb6T3oKGcf4Z9mTEinBZhBfK9dOGlQSJDHUxtfG6iPllqnNPvnp0OeKm9m/7i0KdGoJdsNY6bTVdoDNpo4s4MkjnSMNOzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783441568; c=relaxed/simple;
	bh=lrYSArpP0iVuUgDVG3d1222jafWM2daRLlBprnwN79M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHpBnTLquCq5pNTSYMuZDra01ZbXuvn1TfK0sMbL3cva1JBzaAb0k5fkO7eQtV2mFL9fpjFm+gpAE+OMTiOnu60KXkAjKNoAeWd+weS8FKIUeYllkaTVqTeMZV5mWC6jQVADX9JONh1ipdVaUxKf62EIbCrxBRqd2jaZsEsX6pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=qXqjB2VL; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="qXqjB2VL"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8eeb4508f29so34316206d6.0
        for <iommu@lists.linux.dev>; Tue, 07 Jul 2026 09:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783441564; x=1784046364; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Abd7yWEQE6Vuyzvr8uj66ic6dsI9yDvEtRp+r0f0v0Y=;
        b=qXqjB2VLktT7tWfv4MytgFOAlT42LGEDu9zLMVKSlBpLgozC5MZXASm1CArSwhGpIz
         TX3i0YMt6Ob+kjTkKCfhCjPrYrOwYwEUznyrSwVr5grDjxDjs2a9vM8u7pNYeG8VfKaR
         nJJNip0q168rQo4w6k+CSwly51q1Bupd/rVkI0Kbx7CLyjhaERrxZtYa1k5SkREjewfn
         vI09f5PwVGwxnGjX8ya7VozjDQcosx0hB7lbLHH2UU2NIuXoCjjOiEkm2O/iJl4ThcL5
         Q3UEebgNkyRBLPHBCP7qRaW+QNRzYUk5i1nzetCXo+y3WXrR2FZlZgOlEXvKz0ILyO2X
         ZWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783441564; x=1784046364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Abd7yWEQE6Vuyzvr8uj66ic6dsI9yDvEtRp+r0f0v0Y=;
        b=WTOt6rHmGvKLOf+onW13jO1PW1o+1mg33pYZGTz70t3zaAVgo+k8AxDrXxcch3rUdy
         fnPoIutfb1tf5gI+hv0xeWUPbUQPjCan9Rg44YdRTgG2WvaRWxg9EMkLpoR5/bVKjAjN
         3BX8dNTQd6tobnkiibcgbMCvIBoqRqERJM7nXZerbp6pkw6CiE8/cqSVsVjfHbZMNm8w
         cNe0IKFbk6qUiWYO1elnwk1wS2hiRIUlSQUiMUvYlbsXi7FWIoYINi/S4dTPx73QxCgO
         P1nC41FmGI50FwLMGornoDnR2mkVUlJeQI+T3DZ7cfmTJejGPUtwDhpNbvrRdQdobeLi
         z6Pw==
X-Forwarded-Encrypted: i=1; AHgh+RqSf7uzp+Zn4KBtN/2UBpRI8uwzaznl/t75rbcDumN7gLpE3SnCHAiQRRMFKAYEmtvgJ8z4WA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxYd1rw2QYu8pFwTTo2Ji05MVSJQyT10hEMQfZzAwO6CNe6Vjyp
	S42jkw3yvf1C51kr9ydy+SLlgGVJiSEySJoiZ4kMdjEszZT4ELR3oc5+DRCDCRZ5nVY=
X-Gm-Gg: AfdE7cnnxA0W0i9oCeN1TusZ8LvCnSuu+dBv7UucdgGA5zEe2VDfztbPG19S4VBxj0h
	OtV5QESUB7XZ3rTnn+7GqbmHjo5Z/crYhTW6f3GhSfW3dLWhc6Zkpqxxaw4SNOcNT5UgByj0xBu
	WFgqIzq5Z92HYbjyMe7UL9lXns46GNBmkDgVQRxsNjYKwP6zawsSDsRma7H2/xBmkto44WPnVCQ
	Dzk5/+Mhw9LUctZa0CEpIhM9cwmzAwhA5r5AGfTd2NkE3HglunqX2wrIpesl+1KFNTkvfmgSiNt
	9qPHTfUFDnVORa0P04pPtv6fI85YZEpVwjCSasNUmbS5rON+0WDU4i0n1YNLO85BQGbxidB+Y74
	boF7VJ34CsXvpF/aJeupVuUuLGxX0HTj00DtjS+I6lm6GFLuGNNQusScUXEuxiLjptH7IzC+Qig
	FKjkuTtnJ3QUBlenLwd1fsvsdlh6gEtaOL4bLHhN9UXA/mhV4GUTrPzDyeq3x/eARuZazd7wAL/
	SO+Jtc=
X-Received: by 2002:a05:6214:6011:b0:8fd:6de3:bbaa with SMTP id 6a1803df08f44-8fd6de3be6emr28372996d6.64.1783441563961;
        Tue, 07 Jul 2026 09:26:03 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46f306123sm181382626d6.20.2026.07.07.09.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 09:26:03 -0700 (PDT)
Date: Tue, 7 Jul 2026 12:25:58 -0400
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
Subject: Re: [PATCH 11/30] mm/vma: introduce and use vmg_pages(), vmg_[start,
 end]_pgoff()
Message-ID: <ak0olp9zA6ERCXtO@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <f7b4f8a611ab4d36eb3cf2e394610a3744a93895.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7b4f8a611ab4d36eb3cf2e394610a3744a93895.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:22PM +0100, Lorenzo Stoakes wrote:
> In the VMA logic we often need to determine the number of pages in the
> specified merge range, as well as the start and end page offsets of that
> range.
> 
> Introduce and use helpers for these purposes.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>
