Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00774F8BC
	for <iommu@lists.linux.dev>; Tue, 26 Dec 2023 17:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="YLhUBZYH"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4277e7146abso42941801cf.1
        for <iommu@lists.linux.dev>; Tue, 26 Dec 2023 09:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1703613482; x=1704218282; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYH7udRxVOWUuYR1uviT4nzog+O468I+tsZ16QY52lY=;
        b=YLhUBZYHaa+V45secGbMWqoWIuRq/9ZN6jZZYlkd7/j5R69mIu7m0OiaXgAH5AD+Wi
         nJc+Unyv9OByvyqNdmyptTSl7rdmvPbRXwXN/TfL2JKikHVwmAXAwFOC6zmDM7isI7Ng
         Cym4guyUjyz3gy83U6EbQThPHAaWCGoMTHq16oO81ALDhgEyGa4UeBCJAK2AY8u2LbK3
         x9ygnWzwt4X5PMaIvVfcEUKVpWuUMU1CXxeMoXaYBqmF0CZex4/9LQZ4KksJysAt+iNU
         bw6MPDUn3/03BNym8rHq/DtkLam6uzjQ2bqWwU7B4LbQ9TsEoZRK7j2d+Xdv6SwdotVh
         Bu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703613482; x=1704218282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eYH7udRxVOWUuYR1uviT4nzog+O468I+tsZ16QY52lY=;
        b=gwZd82Wk8Dt66ccnKEnd+DGCJy8ora71/sjmiO9UklGHdyluLYCQrTPWT1q3N+x38O
         jFZuIqHFfIzkwVjNUyjTIupmyANyp9Yp82ihhm/+/H5zL+CWX7fEJNn3C066nVMe0Z5S
         n3QdoGDSyvfAxRrSWEMtwWukztLVjib2Sw+cMgSitXdbZesPBtMutYmCs25YiRh07jEj
         QaaWG1RCb/WD7/Aa0d0wf1jE4oMDbMegolrJyA4o2U05rss/7Z+gzdhb6N5cWj8mEds7
         o1x3iliRgzOPKmPYhKn7B2o0aGzjknAbSQA4gP3FRkt7X6LRW21GX/Lh6CqWvieeISSc
         NZuw==
X-Gm-Message-State: AOJu0YxKhop4R3mW8IVLhye34x4cso6Z/zg7pHXmlGLsj5OMCqcSHNaJ
	1Mp6Ei0PxaQJ7bEOC0By6ZNEIe2n5EjRVwjBq6Q4jemUwZgihw==
X-Google-Smtp-Source: AGHT+IF1mJ8zM3mxpNM9KsLehfwPoH0iCOIzFR/lBXLAAhZkeLDmK9jCB4DCOG5yTSpoP8aUapffGpK3Rjo+EEYkWKw=
X-Received: by 2002:ac8:5915:0:b0:427:9fad:896a with SMTP id
 21-20020ac85915000000b004279fad896amr10235427qty.56.1703613481775; Tue, 26
 Dec 2023 09:58:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231130201504.2322355-1-pasha.tatashin@soleen.com>
 <20231130201504.2322355-2-pasha.tatashin@soleen.com> <776e17af-ae25-16a0-f443-66f3972b00c0@google.com>
 <CA+CK2bA8iJ_w8CSx2Ed=d2cVSujrC0-TpO7U9j+Ow-gfk1nyfQ@mail.gmail.com>
 <1fd66377-030c-2e48-e658-4669bbf037e9@google.com> <ZYinEGCdl8mZjmXi@casper.infradead.org>
In-Reply-To: <ZYinEGCdl8mZjmXi@casper.infradead.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 26 Dec 2023 12:57:25 -0500
Message-ID: <CA+CK2bDWRN__FBw1N9j9RD3EE+0pca89ASKROA6tK_CGH17gNw@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] iommu/vt-d: add wrapper functions for page allocations
To: Matthew Wilcox <willy@infradead.org>
Cc: David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	alim.akhtar@samsung.com, alyssa@rosenzweig.io, asahi@lists.linux.dev, 
	baolu.lu@linux.intel.com, bhelgaas@google.com, cgroups@vger.kernel.org, 
	corbet@lwn.net, david@redhat.com, dwmw2@infradead.org, hannes@cmpxchg.org, 
	heiko@sntech.de, iommu@lists.linux.dev, jernej.skrabec@gmail.com, 
	jonathanh@nvidia.com, joro@8bytes.org, krzysztof.kozlowski@linaro.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
	lizefan.x@bytedance.com, marcan@marcan.st, mhiramat@kernel.org, 
	m.szyprowski@samsung.com, paulmck@kernel.org, rdunlap@infradead.org, 
	robin.murphy@arm.com, samuel@sholland.org, suravee.suthikulpanit@amd.com, 
	sven@svenpeter.dev, thierry.reding@gmail.com, tj@kernel.org, 
	tomas.mudrunka@gmail.com, vdumpa@nvidia.com, wens@csie.org, will@kernel.org, 
	yu-cheng.yu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 24, 2023 at 4:48=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Sun, Dec 24, 2023 at 01:30:50PM -0800, David Rientjes wrote:
> > > > s/pages/page/ here and later in this file.
> > >
> > > In this file, where there a page with an "order", I reference it with
> > > "pages", when no order (i.e. order =3D 0), I reference it with "page"
> > >
> > > I.e.: __iommu_alloc_page vs. __iommu_alloc_pages
> > >
> >
> > Eh, the struct page points to a (potentially compound) page, not a set =
or
> > list of pages.  I won't bikeshed on it, but "struct page *pages" never
> > makes sense unless it's **pages or *pages[] :)
>
> I'd suggest that 'pages' also makes sense when _not_ using __GFP_COMP,
> as we do in fact allocate an array of pages in that case.
>
> That said, we shouldn't encourage the use of non-compound allocations.
> It would also be good for someone to define a memdesc for iommu memory
> like we have already for slab.  We'll need it eventually, and it'll work
> out better if someone who understands iommus (ie not me) does it.

I was thinking of adding an IOMMU page table memdesc, at least by
starting with Intel implementation.

- For efficient freeing on page-unmap we need a counter.
- We might also need a per-page page table locking (aka PTL type
lock), if the current approach I am proposing is not scalable enough.
- Access to debugfs (I am studying this now).

However, iommu memdesc would really make sense, once all the various
page table management IOMMU implementations are unified.

Pasha
