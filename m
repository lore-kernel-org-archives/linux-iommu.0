Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D856382379
	for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 19:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783710127; cv=none; b=RFgJXm/shsteiPT46IQ9R5EULD/R6KDA316G0SEN5y1NOLeWMcH/7FXqFWfSz3G8VT5z+hyDPzwWDfgpC1VbW+VrG/5RKl+NnGpVlUwlesUlodm04jPMSjdK6h+xn0pt9nL+wV5vxl4pZRmy5Ldr1T0mS5umvYarEjvYsmk16PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783710127; c=relaxed/simple;
	bh=47yOZh0uL9PiUmgaP7WAHRIYSRvyXRhMxAEwOuVsgWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JK9uMLSHQaKbM0Rdu3qqqwYcakXmhZJrCMQ4VjfsPKbH2LxpAR/M3PXuddre7X/6HWYKey2NtCGrCbkm2Ca962ROMCsT4/VaGWCI4DbWjoTpP8DsvaZ2eEOI4keRk3IaP6+veG7x94EkJBEzES3JF6rSHYdfw/fkFi/25OvnAx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=qj3hG3K5; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="qj3hG3K5"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-73770fd1b65so401056137.0
        for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 12:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783710124; x=1784314924; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pC/3U7Ftz6dY/QSNTLtw6DNyhuKVUlnEMcNANT8zsUU=;
        b=qj3hG3K5GJstRdx4P8mI49geBnx1AwKrEXmFU9weImfE+s8EwYAtVGpMhdHjEF6ULC
         OjFldmI/TWaGd6/W3ciKhkslBUhns04lhs8Xr3V/dVqM8TgxVZkNVIsugi1I4kD9y1Yn
         TsE0ZotCu9FjdZ4ljyYy8vXSS/Ft0QWVcvPNZSPELYD118Te5rgAkDAnpEu/weIfq9uD
         Eo02S4mYfywvXXY60z1BnaLFgT6Efj04lKJOAz82AkDRhgMbS0mdZaZXccngwx1pgJs9
         B4CclEhOyx2CgTKTnJaieib4uy3SQGOSRc6LuWwWVAthKPG6Q1WfGDU5Y21OeOZdYjg0
         xJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783710124; x=1784314924;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pC/3U7Ftz6dY/QSNTLtw6DNyhuKVUlnEMcNANT8zsUU=;
        b=QafKQIkaQeF+Ed6iu9qMzH3qTbZNw+k3YD9n9wd0LATu3aG94IkMdS7jZBndXiAhcx
         6NPvzfqySJvD/FhiK0YC4EJNFNjN6oi3E9sGGTu4MD1FDl4EWfmcGD4Qy4o6KzE421NL
         oJcCz8VLZmzIY0LLctW7c9iL/g/tr+QsqfIeiEbDLiowD6uop7PPwD8VU5itFiK8Y0Ke
         SvsmjP9RLdUOUvfQ6evgUV1OuWanLC8eUJZW2GCzdavNrNUSAOvg5r0MnOKFC4GBzS5o
         Gj67tNFDU9hBqovkQRwQ8xT5gDhvvZ+xxtEgrnxJLl6dztBFFcb2lwFX3r96P0CWYeu3
         bvjg==
X-Forwarded-Encrypted: i=1; AHgh+Rr03skPx1P8YH3MSwjdM6udN6QQ0QZrZ9cL/1FBF0pI9JNcc910ug0RpKxdRjE+UpQ2gN2jHQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzu0E4QaskPG0WWxOST36CZgkpwt4HvF6nqXR+3Dj8srOc7Y7qR
	ZOxcF456rKpAM1uuJQa48N2H/O4NBqDKJLPT0Oyi+bQhoorozlZNk/tJcYQ6yAGDmHs=
X-Gm-Gg: AfdE7clb8sGoYW/TAqPZwIWMACs2X2yA6FJY7S84Z1fo7oiRLuo9TrREikkydG56H56
	Iy3lfO5igynlgfYQGlUtyDQnNoHHx+coFjWZX57k9rT7CEPVEWXRS2pgeWPPr7UrTNUaViSI/Bl
	I+ZtN0AhGmQIWbsikCx6JMyRc0dRSaCY/oBcSfXGIpK+nIuNeiggafoefLjWhEgLsS0Dlm9ccXh
	6TXKI4nLpd0sY+aFIPHvfzUd9MHJZxB6wbXy5C+3Ri85J3cYHKgae/UNnRF6sHJudRtbRswaCam
	pPq6pZbLR88NX3XZYBOzfDHklaj/mCNjBfbhKuxhGXiXqNVYNiT661sXjYmqqIr1F7EPchpKOJ7
	h9Ru04vQYsunn4vqqdgnZCxSbx9nuzRKWBptJtixiGW1g+DpnekY/M0xTt5Zbi2fYyGJqBK96Zz
	iTE6Obm1z3Ed5w14QFTiOsHL0pVl+eAcyZIiGQkIC2G8mgSsIqSO4ga3qE7BDOa79Pd4se
X-Received: by 2002:a05:6102:689c:b0:739:5f55:3c3c with SMTP id ada2fe7eead31-74533d66217mr325833137.13.1783710114831;
        Fri, 10 Jul 2026 12:01:54 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd56c4b91sm48074036d6.19.2026.07.10.12.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 12:01:54 -0700 (PDT)
Date: Fri, 10 Jul 2026 15:01:49 -0400
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
Subject: Re: [PATCH 21/30] mm/vma: add and use vma_[add/sub]_pgoff()
Message-ID: <alFBnZ8RcRN1hlk5@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <794044881e454fd8ac13e59d5ff5fc86fca08b03.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <794044881e454fd8ac13e59d5ff5fc86fca08b03.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:32PM +0100, Lorenzo Stoakes wrote:
> Add helpers for adding or subtracting to a VMA's page offset, exposed
> internally for VMA users within mm in mm/vma.h.
> 
> This is to lay the foundations for tracking anonymous page offset for
> MAP_PRIVATE file-backed mappings, where adding and subtracting from this
> value must be reflected in both the file and anonymous offsets.
> 
> These are used on VMA split and downward stack expansion.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

