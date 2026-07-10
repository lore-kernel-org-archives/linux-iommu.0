Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985063B1025
	for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 21:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783717720; cv=none; b=i4bSkvdSID0MVySK0n4YBs+ONUl0RAE19Tu7Ur/NuQU8kJLF3EGShHhRNnr4xQVxvTl2xwAtzDAkOTrmKYv7WFEZcE+mxwn97SMwYkpsttj836Zd93vAo+y7BlUTqyU4mMnSseRts90cX54p4vcayqQO+bVWOgZR01DotB4R6Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783717720; c=relaxed/simple;
	bh=vkLP3Hlflzof9uJwr1SCvst2pkWw9S7cxcrI8/IWQ40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJ1/9VoW24Rt22cPZ2mpMa8X37TU583WPwebI3EcnAVCn9jOfU89h7+cqiQ7/Bl0hQAR5A6zCGYR7Ta423W3y+3QJ4JGCibdG7uTxIsaKy9OYj8CR5vIKfMsOj8FnRjEaDVARnWPgn4uLZo9DXfudtEXY53Mi/esfEYadWTBumg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Q58jTrZt; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Q58jTrZt"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c8e2e39easo10131221cf.0
        for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 14:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783717716; x=1784322516; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TOF1lWlhGf+OJbHw+J+MIMmbUwopKgG0YAX8LO7BKt0=;
        b=Q58jTrZtLrVxGZEKINiP8+Sql4VQ6ekHw4GiTU4UQcMs4PHY1552mo5Tqt0ag5h/op
         cGYXCdYoKGHKAkzL4NVG2lb1htsGpvpvSTCqhMm2LujvaLfpIgqthf+rezJW/QUURTbI
         1GDXx6dgbbede1QXoc95p9dg0afpPST/VlyCEcRbY5n6pKBX/gdqBV5as0VOj2QVEe20
         ZH0RrtsJNl2MR548IQ087CgpFXsVmvxmdgjHmuSZnVa3XzEnrd7vsWz3wuxJk0sjb5Jz
         jxlmf+4oyEzp7a9HjdOCchnND/QzQ/PmU0cx0/Xf743+hmSsETHd73VLuAGnxih5Swic
         lQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783717717; x=1784322517;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TOF1lWlhGf+OJbHw+J+MIMmbUwopKgG0YAX8LO7BKt0=;
        b=RNpUK+n8hJAtHfkgq9RwKHx8TEtsz7j2Mw8tP/b81cqOGtlRutKpRWXK925RjPI2Nd
         t6Mb42q9AIkeZ2Wpqj4PKMnBlNbeal1XRyhLHqEKvRjSRgDI+eEo66221c29+5bYse3E
         jHM+FNWPWTiZRRcY1UrgWzIewE8JFLjSKb4iCubmtHPYxYNcx81VrJ9Y1LTYuZnC57J4
         dsi61YClb9AwJsr0KvDuwPF3vhiPiZEUAMGmikclSq/omTr7ck3W0M+cqQmw5tpoEj1w
         pbS7tyWdD8jMSuK53s8AUnkqFvqupmEM44/k1efqhDZIX5ViuONqBefBlzN1NsgHvc3y
         DdpA==
X-Forwarded-Encrypted: i=1; AHgh+RrAO3gF7akpBTgaEF5os561Ik78ilype5BSLLs+p3Lib96jwInV+EtHlEYSzojBPdNCpNZZ4A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5AMkMgr1atnsaaF1P4YCxABKzdnWpYQXIeQJa4E4RG4flRNSS
	/VYfptp+vyZN8zR2GwM+cGtZ/KcR1fQK/l6Cnnw45OvmGB2qyk3PlV9XCCQ5s74gkaA=
X-Gm-Gg: AfdE7cm0CXVbrXacEVidCk6P8uirSXIdUgJtv+piDtZGUQ9xUWmdrRrZ+KHqEQpCGcH
	s+ahGOuI7u/g5mDyl+2kCE5QLSyV4V5qm9PTYJHmuDokL7xtPfzjghE9NhJrvyVmtzu2pXU6hZp
	s+SD/hWwVnQhDShqITgmCjzapTiupKLQELLtm/t9a3o59nlWOQj6P9Kc7G/9xL0QLDDKovAEvsO
	BrmzwHd5aWI+1JxC51/psMBqPp3lwc9d3hjOia+yscLV2bwJ903v++hIu4JQSeoHiYfa3cq/VvE
	fKFzDL8NZZOf0K5gYyOTSMq3PTcVu+od2urShvhc12SydLD0OiHwsRfOkl5qu6aJVJPlOBSubiT
	3Btp9PKtkmnwVaQL1BdpYh+QI1KUbp2/bjXGg2aWbhnWNhvm5cojUHVkFawD+rs+eofYCIoSOqw
	u9k9xAHx/7nvZxvKbcW1WDpbC6wn97TD0TR7pjwIJEpA2UUkCciviO+dU6rBaGan57NgYn
X-Received: by 2002:a05:622a:2c2:b0:51b:feae:3576 with SMTP id d75a77b69052e-51cbf14a68fmr7022661cf.26.1783717716605;
        Fri, 10 Jul 2026 14:08:36 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caacad30asm23910591cf.9.2026.07.10.14.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 14:08:35 -0700 (PDT)
Date: Fri, 10 Jul 2026 17:08:30 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>,
	Lance Yang <lance.yang@linux.dev>, Pedro Falcato <pfalcato@suse.de>,
	Russell King <linux@armlinux.org.uk>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Simon Schuster <schuster.simon@siemens-energy.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Dan Williams <djbw@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>, SJ Park <sj@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>, Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, kasan-dev@googlegroups.com,
	linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
	kvm@vger.kernel.org, Russell King <linux+etnaviv@armlinux.org.uk>
Subject: Re: [PATCH v2 32/33] tools/testing/vma: default VMA, mm flag bits to
 64-bit
Message-ID: <alFewd7j_uiNP1Vw@gourry-fedora-PF4VCD3F>
References: <20260710-b4-pre-scalable-cow-v2-0-2a5aa403d977@kernel.org>
 <20260710-b4-pre-scalable-cow-v2-32-2a5aa403d977@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-b4-pre-scalable-cow-v2-32-2a5aa403d977@kernel.org>

On Fri, Jul 10, 2026 at 09:17:13PM +0100, Lorenzo Stoakes wrote:
> With all of the sanitisers turned on, setting the VMA and mm flag bits
> depth to 128 by default results in overly long build times.
> 
> Reduce this to 64 - we can always manipulate these later for testing of
> larger bitmaps as needed.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

I've never had a "too main recipients" error with my email client
before.  Bravo.

Reviewed-by: Gregory Price <gourry@gourry.net>

> ---
>  tools/testing/vma/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/vma/Makefile b/tools/testing/vma/Makefile
> index e72b45dedda5..ef6cc558afe1 100644
> --- a/tools/testing/vma/Makefile
> +++ b/tools/testing/vma/Makefile
> @@ -10,7 +10,7 @@ OFILES = $(SHARED_OFILES) main.o shared.o maple-shim.o
>  TARGETS = vma
>  
>  # These can be varied to test different sizes.
> -CFLAGS += -DNUM_VMA_FLAG_BITS=128 -DNUM_MM_FLAG_BITS=128
> +CFLAGS += -DNUM_VMA_FLAG_BITS=64 -DNUM_MM_FLAG_BITS=64
>  
>  main.o: main.c shared.c shared.h vma_internal.h tests/merge.c tests/mmap.c tests/vma.c ../../../mm/vma.c ../../../mm/vma_init.c ../../../mm/vma_exec.c ../../../mm/vma.h include/custom.h include/dup.h include/stubs.h
>  
> 
> -- 
> 2.55.0
> 
