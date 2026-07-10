Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708FC3B3C18
	for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 21:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718053; cv=none; b=iG9dIGbPseg7sNVNdxvg4qXZ52rfCdtBKtl9FmajGNis4aHofY5n7TOh3mdUFB9qcxgdn7kGu9qLGXjA3GmahUVs8b8qNMnWM0ACFRdIxnVvMTfmM9Sxa/I8t5JTtUwvY40iw2+sJ5aKo36Dbe9iIIpUKhyRkHe/+8wuT64FZ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718053; c=relaxed/simple;
	bh=K/lBj6p3knKpn1KqMVCf0Kk2GjXtTJbSA446pc7gvzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/dOb1bcyFSvGbt2Bw683YiRmp6gvOWHqihbCQ538b8INyfot1VYI3mhOsCK7Q3B1tQ4kixXqpFiI4U+iMlLYl+BsNHaktXcCChkuNRsvspCZ/SzTnuZed+hy4oZi77f3AnVxd0P1Zfq6fZwxngse3yuiFTKUw5aBb/ufka0sHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gOLzyESk; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gOLzyESk"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92ea24a2dbfso105551185a.0
        for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 14:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783718049; x=1784322849; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gpMGBsh9fToTErr7i3jlVPE4gbDMnqxhA+rLBjZ5wi0=;
        b=gOLzyESkeAZPSkeY/7bQIDMal7eJxN4PFPH4lmigycKJkRp+eCKw9A9m7I4iSmyFX+
         qFvtC5iCKHDrQqRpVh7k819CAenXNz6XspMnTz7uK6H0fgN7hDX7tsGb9eglpkKGom3u
         d3u1Hduht9SO5ZzRR019R73Men22IUZ/dM8hePvp+LwLVcZWs+e7zzWCVa49SeUXHNH7
         5sl9s+ZfEvSjJApUmKg4gdRuolks7owthTjpIZE+p3Ctn6Wwzpmgzdrco7o5KJF9P/QS
         Qc3A4trdbbB05TICBPM2scstHyreUnK7/aPJtTphTzsE4n56KSXWFDyp1UKrYrTyzVBS
         UFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718049; x=1784322849;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gpMGBsh9fToTErr7i3jlVPE4gbDMnqxhA+rLBjZ5wi0=;
        b=mt2By9mWQfimur3OlDGTBo1kELtzoN2VoO0a0qtgCHsgTnM6TsXxw71zH/g0dVd1EA
         QuH7PbDsG0Z69u9ApC65hw+dPVBFRgOpSquEgD+/zQZ4Geo5G/TApoF7TdGZlo6jUzQL
         k9QEyeJ5TYIBDX0vP3hDF1WG9vkIxvPVK21K9/g40hetnv33nfo7D4GtXnt8u1QDCNg7
         Yrs8d4wAsGlPNW9vCfyfBEtnAL+PsdTfnh+sgSuMpVfvsAp4ioh4a7lMBX9hUxDotCy/
         Awc7UTnBqxqVcyGLSN3pP3Vr6O11AeIp1idp/cTEINRipDVL/KG1zlqqOlk3eJblpu74
         nI6w==
X-Forwarded-Encrypted: i=1; AHgh+RqDxZPteC5t+RxYsLzaUK88i7R4n0lCpJqfAkm7L6qvmYowe7OLAVWmmoTDxPra8SRTx547gQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwormWKOvGPFrDpoAEj5SHqjnlLV7nAxFTqqAyN8vB2fYjx4bB6
	EqQ86YvvBIjn3VSCQIs43pZT/9ucb8Wbcw4APBITHTe+qrFyDom3zwnN/6195+RPB94=
X-Gm-Gg: AfdE7ckOXdEr9PwUBnT9f265eUVWTQ9+FwrPSfk7PIvVizU7kRftBWBqBwEnohZcWBZ
	4GP2OzxlXa6XVtzOcKTJdqAMdf8Jpt+6wvOo5pP4Cv+0uGqwuEoZXnlHSMY06cFvEq5SSSXH239
	kvEYVKq3CG0ree2Tg2U8sQNBLlnh0g+YcnsDRQ41w7NtXvxCVW6SmJeghfoXmCl3mJ0RzLKRGuv
	mkSMXdarir9GatkuCB/hwdYH/A3HW+otfQClp5Bc46ghtSuf7evsu2fvLnjTMHrd6OeZC2TYWho
	bK59zt05Um9XHJopaX+2El4elQUkFaP+HxkipaX8fCNoSdzUyB++RI9AA+gwb2BWFduDejjqpxF
	YEq91u3deBiWbBn2b1jj/TEnlXHxytVfnNKblNy3GAcI1CtnLqRFrZ/bv2aN97phV77PwIb49BK
	qKuAEj1GgtEMUMfVPuXRCUJjmsj0pLjczhqyi1mDyiwfSV1Q2bMB32QWOPrFLIHePmp9BM
X-Received: by 2002:a05:620a:458a:b0:92e:c117:9ea2 with SMTP id af79cd13be357-92ef2e264b0mr94774285a.80.1783718049159;
        Fri, 10 Jul 2026 14:14:09 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50e3083sm50604746d6.6.2026.07.10.14.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 14:14:08 -0700 (PDT)
Date: Fri, 10 Jul 2026 17:14:03 -0400
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
	Jarkko Sakkinen <jarkko@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
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
Subject: Re: [PATCH v2 10/33] mm/rmap: rename anon_vma_interval_tree_*()
 params and use pgoff_t
Message-ID: <alFgm58E4G7hWIm_@gourry-fedora-PF4VCD3F>
References: <20260710-b4-pre-scalable-cow-v2-0-2a5aa403d977@kernel.org>
 <20260710-b4-pre-scalable-cow-v2-10-2a5aa403d977@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-b4-pre-scalable-cow-v2-10-2a5aa403d977@kernel.org>

On Fri, Jul 10, 2026 at 09:16:51PM +0100, Lorenzo Stoakes wrote:
> Rename parameters used by anon_vma_interval_tree_*() functions: 'node' to
> 'avc', 'start/first' to 'pgoff_start', and 'last' to 'pgoff_last' to make
> clear what is being passed.
> 
> Also, express page offsets in terms of pgoff_t to be consistent.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

