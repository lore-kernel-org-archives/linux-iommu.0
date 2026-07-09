Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AC442CB0F
	for <iommu@lists.linux.dev>; Thu,  9 Jul 2026 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783612563; cv=none; b=BkiNNEvT4Ju+lmHY40PlcqQFx8WUpuRss1WANeSP9lH6a8Ub40cXccBaIqUBkTXHpvpRcs97wpaViRTQw/+58x7kSoEC8Cish+kUsZHiMiTBW17mEFJz34ZgN3/2rX7BeP4Q7VP11chbRCqhfJchR+kenjDIAqIat0G/XgJ8uyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783612563; c=relaxed/simple;
	bh=GOt99IJ7fgZPI8QmxyNzz1MEgzG9KnOmLnnihrfLrQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwXvVs2Z1Z5MJMyBggl4DFiKz0TGAfTJTKld3MAK/QSyKuQno24aGyGGah6VjdAxp9X++ikt2InxblIZs6YLmG3hIOv16D/ZFYHw84a7Hxyn8mqcA1lOCv212viY1Rgsaqx8r2xM5X0q10+coukjrVCGbuljlMwriAudaO1PoII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=dLk059lM; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="dLk059lM"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c04bf4711so16775321cf.2
        for <iommu@lists.linux.dev>; Thu, 09 Jul 2026 08:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783612560; x=1784217360; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QupnWz0oLATZw6wM2bylQaqDWCRhZF5lJVU8oFwJF/g=;
        b=dLk059lMxxwyK4QlxDjO1LvJGsEC935B3ol0R+gg/T5VsrPIzHZl5HpjMQ0C9Df+qI
         Zpcut/0/9q00VKszq0ofXqXr3ms5s5M4AEFRA8Xn5jXKYIPTZliWbpqu4whV1oAeXuQP
         KG+aNqwsixfIXj+pEd6n2PTMGNnUPuhTNMNgpXQ6pLzSmDwGxL+oPRKYIJsxpaGsmcpW
         5f3ENDfNQ8z7EVGphdJ6VM5SNT7ZwKniR3JoU11U1G4Ow/OFr8QLaLtfS/vJj67kvJhr
         Ux/Gji8RDXza/qMamJfD5E2bvZzxtkpVlktMgFKighldEV7aMLADvTwJKUwumZ4kFonW
         DJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783612560; x=1784217360;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QupnWz0oLATZw6wM2bylQaqDWCRhZF5lJVU8oFwJF/g=;
        b=YpouIYw0NIOwm6e/eGtkS0Gg/gUIoWKHn4ihoEOHZRGXqINeBV5FJ9bCGo3MBtDl/9
         MnRDvOUWMHFlQEtGiD9basFivG2lfZ/kuEY+j0O366Y9X5e4tncCK9ZAbwhtNO0pbO0J
         URJ76O4+RmnSoqtY79bwe3p8QVgwY46Reii9fVgGjRFMF6OA5V3gCsWZ9oQL9SFvSx9w
         KH1cecpOdK3afd8d4a5qmicaT1ibWGOuKQeXraldU73/HEL4XDmRfZZ11qUP3X4YCK4t
         huo2yLB799AwQ5tnCyWBr0z0w/rWHghiSryyg0FGUo49DJEy5s7Xwy+2NfwqVie3bjYR
         C+gA==
X-Forwarded-Encrypted: i=1; AHgh+RqKEbd0emYDsWPE83TSAvlXlRr2DwIHaHJdOPQ2Rf3SBl0o2Yw8XpbGmVpuKSzVeun1+6AStQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwQsB6fdGRPbqFe8PrdzmmGrdcZFwiOrdHTfhBuRJx6Ry+j0Uyc
	cUMwJA+E7wL2GRMVemwczFYYggOtLIaYPDbFKcWrUbobJHqIKFCNbmSjXYWw8PyOMWE=
X-Gm-Gg: AfdE7clIFYg3QRHiL8d2eJaa47WY7C4iOfrNtfk62efOOOSErhz9lpQO2Jiyh6lw/Ek
	x6RP90LweiXoV3kYpDhw8uccKJyITOgpJUIV8sFgHHJ8RsLpilnb4z3KuSK9SJOwD0x8Shg5t0T
	PDgCSyiAq+HcAImsCfZEqt8KtgGErhXygOx1To/RkRJSbEwh/Yis6eBoWmXgUrd1uUhq5L+Yced
	WLuzOSWCTqcjML4J7ZrIrcplC3b+kfFyU8N5EKVjphMRc9A6qkvdYMD7fRNSvkC1CHnr89VzW5/
	poj9T6iuZIKskZhDxLyyxBomQ3+gjexou6p/KfztaYYWSFTn3LHrntv4QoX48UWtO6akpXxWcrQ
	YnBLTmvUMYBFUt9wCnx3rfo67OGJTFw4f+KfmAkhzILepNBEFNqQ1nhQUlZ0XZdS+oGFvbuooNF
	ywYVEwlJGXMCXb5IaraYhVux9tI2VwmU3aVNvrvCBUKRZ3Aow2asQdkd+Km25P1TUe7ymu
X-Received: by 2002:a05:622a:311:b0:51c:185b:29e0 with SMTP id d75a77b69052e-51c8b2ae67bmr82998651cf.10.1783612559586;
        Thu, 09 Jul 2026 08:55:59 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41d2d688sm169684691cf.17.2026.07.09.08.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 08:55:59 -0700 (PDT)
Date: Thu, 9 Jul 2026 11:55:54 -0400
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
Subject: Re: [PATCH 19/30] mm: use linear_page_[index, delta]() consistently
Message-ID: <ak_EivwcDDdn1Xvp@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <bf56e2e98b512962a2fb88900d535a0e9e6769d8.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf56e2e98b512962a2fb88900d535a0e9e6769d8.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:30PM +0100, Lorenzo Stoakes wrote:
> There are a number of places where we open code what linear_page_index()
> and linear_page_delta() calculate.
> 
> Replace this code with the appropriate functions for consistency.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

one nit

Reviewed-by: Gregory Price <gourry@gourry.net>

...
> diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
> index c09bbe04be6c..536c25d8dcee 100644
> --- a/drivers/comedi/comedi_fops.c
> +++ b/drivers/comedi/comedi_fops.c
> @@ -25,6 +25,7 @@
>  #include <linux/fs.h>
>  #include <linux/comedi/comedidev.h>
>  #include <linux/cdev.h>
> +#include <linux/pagemap.h>
>  
>  #include <linux/io.h>
>  #include <linux/uaccess.h>
> @@ -2462,7 +2463,7 @@ static int comedi_vm_access(struct vm_area_struct *vma, unsigned long addr,
>  {
>  	struct comedi_buf_map *bm = vma->vm_private_data;
>  	unsigned long offset =
> -	    addr - vma->vm_start + (vma->vm_pgoff << PAGE_SHIFT);
> +	    addr - vma->vm_start + (vma_start_pgoff(vma) << PAGE_SHIFT);
>  

Obviously correct, but was this intended for a different patch?

~Gregory
