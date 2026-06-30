Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69F944E049
	for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782834146; cv=none; b=tYCe6ynPHks2uFvITX/zMQDvCJRWeXmFY8uxsCd65DERZq50KpXN+LoqLiFCBPJSb0YkSPIHjvRE5lnYhOA9UgT3HhQ29bdj7GnAqyWAvAfNLWdFD+jU7WplwLaqeAOSsIl20gOD3uWuQheK4ugb0lRQ4xJ0MFufOijrH+mciHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782834146; c=relaxed/simple;
	bh=G7yBa9qRXwqvk5O66eyJS/F0IvVRBRnFUCu+8taoCIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjXOY0qc3oOLR/nT1XXdx5XOfOz84Ecn/5RpDmq3StCrQuPvvBM1Yu8xBopTos+oDxV/yBUjHQ+yzGEGCiYuJGxExM/G9hLA8Huq+HNNLaHnvrIsJQ9lXXtE43iPWVZYIi2hAMYTjcWzs7M0LeXW/qDOdMukQGsobrVdyTN/E8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=jf1e0vbX; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="jf1e0vbX"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e602d2c0fso74959385a.0
        for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 08:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782834144; x=1783438944; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QB3LlP562wM9vhAInyZtqjaYedctMNHlJgLHcqpXNiE=;
        b=jf1e0vbXN9WHA75z7y2uYxs71+5ddmPHth4etxgt04k/1p5i7sLLhabahl3YdJtTvp
         rpc+uGW61RRmBWNp8kDuAOd2ZljKbGChcSgOr7iTvO5IPCs9yc3HuuwSzuhXSF33M86i
         DVaxf0P7Cjh4eZbpElqnurfthpg04+ty0kMBt8XAIKCzHcOp0EYu1IlpbwB5CfpW6QwJ
         Ovp00MLwt4ucDo/iKwAOVSoQnID0L03RYBC/zp2IdG1DJti4RAkjf82k8S9tawFOne8g
         1/TfBGX9+nniM2SBdZS8qzOMl2OcOjtBriP5OM1eHHukvyotZm7NVjUZuduid54TYmp3
         Stxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782834144; x=1783438944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QB3LlP562wM9vhAInyZtqjaYedctMNHlJgLHcqpXNiE=;
        b=skSJGqbCvB2VqOfPqzSbvPBiW66Dk8KOf5YFd1Jjch+Yx3oYNNBZ4/VkSQymZ1XDw8
         VYv19xCKSQgXT2FGOT1cw2jaOsViNV6IxQNmsAv57kHpS6s/tddhD0XA0pqc+5Z20hcm
         LdqX9Zt2lJ27FZupY3lAE4URluvgjLvxRt/BRW5eKGLlMPp/hu8z24xsnVtEHn9WegXZ
         PQMmORLU7IJqhMFP42U61OOsCADoOrWHhD07s/ujoRtCbCLdvSoxXCL7hNgi7Pl+u8kH
         FXTqXe1oKhIQie2vC21pQxyEwIJ+7/1N8D0pIKw5+DVzaTJoDmqMtznb1Xqgbs28OcXh
         A/SQ==
X-Forwarded-Encrypted: i=1; AFNElJ+q+pgWPoknsZM4lebyfypAFNU+bm5OtOOpzyu7bL/78D18zdxvXhvPwXDvb+s1eGQPZBxZkA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwduR0gFElYvdIVJkuw0rXSeIG8KuOZvNzqM0ctntEYXLVYWJ2M
	aw0m1JyHQNP3f59w3c+C0jKXy+FrutNVisnNTLEM/Si6JP6Yk4yzSykX+MwiucHYadw=
X-Gm-Gg: AfdE7cnzPx/n83RF7NAr4tFqQ9tOYTsGwUJfJ/ysM/eW9TEQ6eWStRGkCyW9TGNbCPd
	H8lGo2XlREb8EA1PWuCxCSTbTAhlP1h7oJ4RCCCw8yQvRgAPmPc86BQ5f2WwOZdRbIaeVDLKLhJ
	cTMTepp2Vb6BXKOSjZDJXsPUvtMwJim2C1EHo16/NI/TcACsPJKOmnpVL5JPVjpnsCo9bxBuhYV
	1kGxSZ+2Xp8yHuNBB/3mZ1feHX89FhtU+mM+RS3zEPsQIbc6A8EWN+fq64WrFxej0PaXZfGN2LS
	JtS7T/+B8VTel6B2tvE0b6d5G0Bu92DU4LYke15NltuPVoIC7ZUvPB4rM6QLyFb8/bGEyHeTTYv
	8t9Borw4MWdy8OvLLu95VWCgr3AcEm+s6m6FAE/SKh/QNalekhU5x1EueMTLFpBqB2n3JqwVEaC
	gk/IhaKgCNBvhuhb367BYL8vUraicDK0WyOYu6T/p/jYTYkBdbjy2EY0xucUtfMb5elef9
X-Received: by 2002:a05:620a:271d:b0:91e:712d:f79d with SMTP id af79cd13be357-92e6984d3d1mr270456885a.40.1782834143842;
        Tue, 30 Jun 2026 08:42:23 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e6234dc50sm263249085a.39.2026.06.30.08.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 08:42:23 -0700 (PDT)
Date: Tue, 30 Jun 2026 11:42:18 -0400
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
Subject: Re: [PATCH 08/30] mm/rmap: rename vma_interval_tree_*() to
 mapping_interval_tree_*()
Message-ID: <akPj2snngOp5nOYq@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <f95462457025370efd047b9dfb039e76bbddf58b.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f95462457025370efd047b9dfb039e76bbddf58b.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:19PM +0100, Lorenzo Stoakes wrote:
> The family of vma_interval_tree_() functions manipulate the
> address_space (which, of course, is generally referred to as 'mapping')
> reverse mapping, but are named the 'VMA' interval tree.
> 
> VMAs may be mapped by an anon_vma, an address_space, or both. Therefore
> calling the mapping interval tree a 'VMA' interval tree is rather
> confusing.
> 
> This is also inconsistent with the anon_vma_interval_tree_*() functions
> which explicitly reference the rmap object to which they pertain.
> 
> Rename the vma_interval_tree_*() functions to mapping_interval_tree_*() to
> correct this.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

obligatory "naming is hard", this patch helps, thank you.

Reviewed-by: Gregory Price <gourry@gourry.net>
