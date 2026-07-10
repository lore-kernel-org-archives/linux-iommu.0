Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C8F3BB13F
	for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 21:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718468; cv=none; b=BJfuErwBQedI1EmpRtCmWFk97CIFIFYOsSq6PICxBCz53M8RiVvgrw0f4fLn1GbWxUeI0jay77YKwQocfn4fCtBGTpTqkBtSwlonYSsO3HFxOw2wPEiQX4B7wgdlrNG0Qx7HFdL/HY1fVfrFOcaywmVdCJEypqRMNuBe0e9E5X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718468; c=relaxed/simple;
	bh=OrArmp546t2joLiGKmZojGNI2jG19j2P4RpxQaXcMQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JB5pL9t2iop2qF1XyvHYcWsJckR6puSaD+it7hEm9yQmGzJs3QBQmOsD8VwawHWMwJNiuW9mCIbZIfjVY5Knm5sOPjNqVzogg+CeTUErUeOkfNMfmVU80yqUzw7S4i1cmBAnV26AqpTsJv9p3zzWgmhd5pXmfBdgJZwnBfCz8pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=CHafMqPm; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="CHafMqPm"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51bfb91795eso9176161cf.1
        for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 14:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783718463; x=1784323263; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kBOMvPUpfjw5N1/s9nVKhxGNiyKZIoN9dPtD8sVM7ho=;
        b=CHafMqPmB4UdrdfrtoDeBwJ8PkDGAFC01KR2CTB5DwMVBsjExgRfzJm9FMakCadVjC
         6XXvAroj1HYLqLETYrdJbPSRp6CioSbj2F+dGlFRBYeEsPbc6Si5/BZ+TtG7wBTXOI1T
         XyxgWHS3boAesXvUnGnqqnLE5Zy1heDGEmLB+YYrGRa69Rr1ovs3UdbVdDV4rhDW3mFq
         xUyjo9TPwxZOvwNW5Gd8z7WdamHao9ptvJWu9+LLXiftRc7WnVJhdRXWObrZKx5fXJKg
         8qV9Jxzkkjg5hszgOw4oKaiJSSBuGcja1UA2dCEJ271jz9bTLH7RDjRy3iXoBjwmzDuc
         R5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718463; x=1784323263;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kBOMvPUpfjw5N1/s9nVKhxGNiyKZIoN9dPtD8sVM7ho=;
        b=HgxviO10RZY3a/rA7sK01Jv21tgoWeho6zQ4Akbe1uoIXUffIkvBJoKqnEFWAEMqfI
         m4vLyN3jb/z7tHd4Br6Qzwo2yUcBHyRJxr5XG0aGaro854w/IVpkLRh7b6PTx2svWdVY
         VgcwhKLLTD11t+8Tc7pKaihABy+QbdgS9PQO8MPFR6Pjcqkw0cnxg8qt65ZCYikRntUC
         iNrQMWuRRpZio4XHx2F4X12O0sfIt/VT/gNhq6/Eo68NauzpoJwwaL4MiQ0pmXtL6vr9
         rugwqWJIYo+WrTgO1iLD0it3qls/MvqpsrPbuoZuT4Iccjir8FtjEIqN8WHopxV+AsSM
         LBDQ==
X-Forwarded-Encrypted: i=1; AHgh+RpQM0hRSzxoRZcdErZTv2wPJA8E5s7ETxijFTzvIFAD7t9nJ2ZeToZZSR2r1DoiEqvq0PjTEw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxgJyN0oD/ESWI+XyfWq8xrW4GpUURJz9+GFJolglP+kTgXcq+M
	ldy+E5pfA4nNRLdHCRVI4tRzoueP+EQWtU670gyev8VqJrQtQUeGzTe5kPlufon127E=
X-Gm-Gg: AfdE7ckqOXKZFFc3w6Jew9rPnIZtWEWMGb9FTad0WwTtbaPaI4GC/6fbiDwiXYqoqKW
	8JOceFoyY6saHWLYg7kZ31gyt9qQRzdFKU7SSqtyxqOM4ySP17gkOSGYZmn72hRT+RQ6CkKQ5De
	EX6H8StXBLkiRSL6sgkNhwTBM7TlBgh4wfMrVio9um2vUj6bCv/rCLwkbq5uBcwHvculFHCyUpz
	KIVLTUD7XBjNMtyJYczVZNH5oBkxLRPsj1n1VxzSYMBB+cYfbHuUrbyKSaQmxvrpf7TuXIJoCCU
	E1A8rLysHfIWYX8R4x8o4jwZrVwM8dFubuZ9eYq69N4fUYmqfLxEB4VtqVaWp4AMhGVPsRH6JJG
	W4twskMyN4uZ4nVS2gcD4WJTTp7yQkVIV2ljlGHDimSX9WptiVZeqhMah2rYKznOz0OtxVU+r0q
	04QOZ+bnKZsH41TBFh0tqnkN02osYHbtz0bZ6owmsNzHvHi/6AhHLuPm6Q/KENXLmt2q01
X-Received: by 2002:ac8:5ace:0:b0:51c:7b11:41ae with SMTP id d75a77b69052e-51cbf2dffb2mr6287721cf.74.1783718463047;
        Fri, 10 Jul 2026 14:21:03 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caaf621e6sm23894971cf.24.2026.07.10.14.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 14:21:01 -0700 (PDT)
Date: Fri, 10 Jul 2026 17:20:56 -0400
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
	Arnaldo Carvalho de Melo <acme@kernel.org>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Usama Arif <usama.arif@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev,
	iommu@lists.linux.dev, kasan-dev@googlegroups.com,
	linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
	kvm@vger.kernel.org, Russell King <linux+etnaviv@armlinux.org.uk>
Subject: Re: [PATCH v2 26/33] mm/vma: update vma_shrink() to not pass start,
 pgoff parameters
Message-ID: <alFiODVaGwd_wYl4@gourry-fedora-PF4VCD3F>
References: <20260710-b4-pre-scalable-cow-v2-0-2a5aa403d977@kernel.org>
 <20260710-b4-pre-scalable-cow-v2-26-2a5aa403d977@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-b4-pre-scalable-cow-v2-26-2a5aa403d977@kernel.org>

On Fri, Jul 10, 2026 at 09:17:07PM +0100, Lorenzo Stoakes wrote:
> vma_shrink() is only used by relocate_vma_down() to shrink the tail of a
> VMA. Therefore neither the start nor the pgoff parameters make any sense.
> 
> It seemed we were passing the pgoff parameter solely to satisfy
> vma_set_range()'s requirement for pgoff being specified.
> 
> Since vma_set_range() is now isolated to vma.c, we can simply introduce
> __vma_set_range() which sets only vma->vm_[start, end], and invoke this
> instead, removing start and pgoff from vma_shrink() altogether.
> 
> No functional change intended.
> 
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Carry over from v1

Reviewed-by: Gregory Price <gourry@gourry.net>

