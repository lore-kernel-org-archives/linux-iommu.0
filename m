Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02A6428473
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782753089; cv=none; b=Um3KRHa4TjIcNhWX9Fvk8fglmzmbGbkxEQVHcHo5kLdvCz1ccw2LTW5jbMlAeneC8DyjdJO3hbRImjYfAKa3oY8BLIRKRkHR8lObCf/zry5EHsBbx9mo6IQfq+gsEfVYIPT35WrTQb1IHWPlIU4g5ZljtjBwc3WiEohMQtdYB0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782753089; c=relaxed/simple;
	bh=NzS+Cir/zCg/P5bHO1uwaI39NGJ0soZPEUZf3jpz04g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nm9mP7TcADiljmQ711PadDHZooY85PHoJki3p6dUqnYwCMAlSrVJQdqSF8VctfSrZ96aRW+rQbaeJhmXtoWuqNNOYUeOXBT4HPdK/SgkF58EsLojNjvbjhmnugPeZCmCOviF/IJ1PYTUk9QXMFwsLhDxLAVsnt6yb6nPNrhgYzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=g8PmmPVB; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="g8PmmPVB"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-519eced8cbeso52128901cf.3
        for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 10:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782753086; x=1783357886; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C6+KY00whvPT5nv3+mPk4rrEbELgRer0MfbyQfoaO+U=;
        b=g8PmmPVBJXUC+WA1a1KuaoJWJlW0YZkO0lSo9RDk/R4lDOoYLH4juczFtmruYp5+PA
         9x3Fl42R8UPSEjclwnFTjFQha2flVTGd+E7GpuansUTXfn7uaooygXmTse6Hgk9aT0vY
         RfjTE8Jc9uCOz96DOh/cf/jpVT7GZt0ixxzHwIseTcPIJdaM4QGN3UYXDKjRzIHNGxuu
         DiMrJShFgfKRdUisYApd0JcOTUcgM+dVMjGTUpuXn7evlts0QZDWf3ZoMqACwDPNzMU4
         c3dBjiFTZ0XyBr9TScqqMnXVz0U9xSu2REQ4T1cMYL1jRvSbOWE+fbZWjT4vJvRjnVA0
         ysRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782753086; x=1783357886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6+KY00whvPT5nv3+mPk4rrEbELgRer0MfbyQfoaO+U=;
        b=bcG2ZGtSV/ZRgb3YYDk7IlM4ni4Oy5nYwKWh+tv/71B4hpkQvMOHbuB75T9tnWtVFk
         Cee/0WgVP+PL6bPCVSn9ZneAdOC6pVhgMrqoCO5bPqYJupl1uObAu/MgsTmH5Gc41f4Z
         83EUzdpVYN3Vg3/u6gAfqnLTVWQjncxxZASnd6RoqBKa/AQqUH4WIHhmC4gDsyGkt9LD
         KuktMgT+TjD7PGVhHMHAmtOT4mzESxFm7v6E9HP8KUmUTxAQzb8mduNIbU7oCx5KzKYb
         e1xHAEJkRnrLpoiTjbh83AQ0XEZwfy2IVtXj0Hec0k6Tgc2TNly14guz2XPMp5fOtW/C
         HqOw==
X-Forwarded-Encrypted: i=1; AFNElJ84WiQ/2f3A8DtoI7+h9NDE4K7tSyHK7SF+U6qdPq7t4Pd6ik790QTjkB1lfftGeI7+4K4ctQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxnhDDJwXS74Twsz75NU4ZpYurv2vyDvNhQ2ll2zVQJOncvTAEu
	fAwVKQCW1Rox+kV1wmHZ2aVGPrj1Fcb8smDjJt1/jAuqAWEymyur7Sn2LBU0kl2eRtU=
X-Gm-Gg: AfdE7ck9JoogLUUV87QTGmxANRoFeEgJ0OZoMrqwV8Igxd1EK9l/3xDwi9iMqq6T8QY
	WlEEpFO8ZVgVTpCgmjX5f/TsfsSDgPhKw9xVV+Sc10v4MYcwStR+UwSKk9SVpCJhKechvtlAbwU
	ANuew7lAhNL94IRINilFjZeqZzp4py+uBFGOKkOa/r6KQJbNOu+A18cidVaNbGSuuQ026gWqJYN
	z9fLliHWIhYO9D8PElK1hyFFBe0hssw3Yynk1rRQMVFEY/VkMX+hCEUK56HVgYkMT9tdcxX3KDx
	zjFDzMu6WK3KuuVjZzDaYF1hsTNECfSWjs6X3uh5zo785Gi70Zi4uzcXcpy25P14YqenZBNUC0k
	DEYat0Ui5jA/ZOfLqXSknVrX/3xPqrU20SKaIZ6fLPdm7QR3ilgG/qFxW33cUX+NUx4c5g2GzgI
	CvTCkMIlzanY7MdVW+IGt+5WZj5vJ56kHoC0CcMmP3BWdaR1KG92ORB4pCEuNZggkVvJInKMPnV
	T6wlbs=
X-Received: by 2002:a05:622a:420b:b0:517:58f6:29c3 with SMTP id d75a77b69052e-51c107f633bmr2561751cf.32.1782753085667;
        Mon, 29 Jun 2026 10:11:25 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c1080d4dcsm934601cf.5.2026.06.29.10.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 10:11:25 -0700 (PDT)
Date: Mon, 29 Jun 2026 13:11:19 -0400
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
Subject: Re: [PATCH 05/30] mm/rmap: update mm/interval_tree.c comments
Message-ID: <akKnNy64lhNqPtLL@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <80d482a927b2e9862487b812e0ab48ebc1289a70.1782735110.git.ljs@kernel.org>
 <akKWvnU2Ua-8ceSb@gourry-fedora-PF4VCD3F>
 <akKfAl-wdIAbexNR@lucifer>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akKfAl-wdIAbexNR@lucifer>

On Mon, Jun 29, 2026 at 05:41:16PM +0100, Lorenzo Stoakes wrote:
> On Mon, Jun 29, 2026 at 12:01:02PM -0400, Gregory Price wrote:
> > On Mon, Jun 29, 2026 at 01:23:16PM +0100, Lorenzo Stoakes wrote:
> > > Update the file comment to clarify that both file-backed and anonymous
> > > interval trees are provided, referencing the relevant data types for
> > > clarity.
> > >
> >
> > Isn't this self-evident by nature of the function definitions?
> > (one takes a vm_area_struct, the other takes an anon_vma_chain)
> 
> Well you see you're already hitting up on issues there, they both take an
> rb_root_cached and the vma_*() ones do not instantly scream 'file-backed' do
> they? As VMAs are obviously used for buth anon and file-backed...
> 
> But later patches fix this stuff :)
> 
> And I feel it's hard visually to see where one set of definitions end and
> another begins, which was really the motive for this, as trivial as it is!
> 

Fair enough, I scanned the rest initially but trying to wrap my head
around everything as i go through one by one.  Generally this really
screams "fix the apis" not "comment the bad ones" - but i suppose that's
the whole point here.

It's definitely an improvement either way.

Reviewed-by: Gregory Price <gourry@gourry.net>

~Gregory
