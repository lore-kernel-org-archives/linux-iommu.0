Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B45C286D7E
	for <iommu@lists.linux.dev>; Mon, 12 Jan 2026 10:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768213228; cv=pass; b=Ltj4vZyI6rNAhysMH+Tka7CakmBlvFiyYk6DvhXk+kBt0X4zj6XV6Tt6O9JYO3O4k3u0BUbnNpnChifTEb7pH15T1V1hbEpR8Lw7Z071NAMJxwZiWh0uQm0N+fLvlkaG4odd4TG/miZjKtsQhxK/pmHRVNJU9gMcVjO93uicSec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768213228; c=relaxed/simple;
	bh=gYHXiFLElUluIbrWA5o6qkz/fX9Z11mOZiGUFzm+f54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RB0bxVWi+EydzLezHdx9IV1QrMN+aN3rWwUKPelMDweMxBf59ZOhbnIiVyvKLpzW8arF8pSD1na4v04QMK1k/2i9CpN0Ld7HSN4fsFYDfgya0F/1SZEYpatN3hpNf7mAJCCV4XWXkXwhES05V2g6vpdVwyNhirzadhu0WQ9uPJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a37JHgoY; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a37JHgoY"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ee147baf7bso768221cf.1
        for <iommu@lists.linux.dev>; Mon, 12 Jan 2026 02:20:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768213226; cv=none;
        d=google.com; s=arc-20240605;
        b=ESC6ahRwbyV9WHtm51yVux/ldpoGhU/NoBBZ00syA4SmisZKxrL1fATwDkfoOIKfc8
         jnfEHu/LS2OGDRiO3d68KXbAffn5YCO6XGhju0Fqql79UEcEyzNwQhSYPN1ry6fqDfck
         dLLHu8Vmf5qDImm3xkifNTgg/WBqwXyjyFSFl/cU37T8FRBQFy7MLCVWBRS2eip+pXRG
         Zkj19GyxQSKOrRvXsGUjcJRrWioho+T7eBwT+bZtl4LPss+UEweDLQmQICnCmbOR8j7P
         U6Uq8J1e4T/t0mLmq4XQyROAmRH1lLlBsBK7JkxzePZtqiTvBgRSQAjCx1cljwCKpXdl
         C2Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K81YAnOXZO5D4mYdCuhOxp178GZoWafY9YiJgFtn31w=;
        fh=znJrNEOjlJ/Nd23B1MWDiIYO+nYSJ+ymOkZfoIViAuw=;
        b=BeVPNpaTsxdOnDNMH9FyIi4oDeiX8riW+Wiy+Yv2OOEXg6I/xaQlLSclU46Fv98RaW
         NX/wtkOHo8l9nKhvT6bmMbRN8z/RZ7JSuDsuxK2/+VfQKed9hPb9dLh+WfF+uwqxS/xj
         hxp3iPvHOunxviYsLRKnKOR9w8yvTk6IBXkPF7wDyYJz3+3i6N7lgp8lC9HvkozKn8bn
         l3DmCPy67HqEG6MFC4tIHXnSSO29mMiApo2pnOf0q+oSXZ58LMgzWbAXQ6EU6NlmokHH
         Itx0DJf3R1mD62giKV7shwrX18qhv37aJaXnFY4KxmPnuMIZsCLW6+E5BoAU9SGmABi+
         xOnA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768213226; x=1768818026; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K81YAnOXZO5D4mYdCuhOxp178GZoWafY9YiJgFtn31w=;
        b=a37JHgoY2jdm1wCE8jXW3trAmZCUOc6eR2jlZ/qB8Q3HYiyG4Z1GNGLER9/Tx25HOA
         LV/uwSayOKdKkLc/2rmzh3uiPerQIRUwRVMYonpeNQlMHr7DcD88VqmsPpgrwixcD2Fs
         DMRrqTNP0l37peP2hEq2aohDEph9+skQoPLIaUQoRlH6NuiLhrVrJA6d3N+R9/KILibg
         oTGIB6a14fEsja6PiohURfCdsenwOfUCNfublxq1WbGz4Yn0bnBMtFcyAdh9zuweS6Q2
         vFgpqpD99MONvrHTnaRTLswy13MU/fpttfjOiW++/4E9ylgjCygP2ZM85NEkBaGk3Obq
         AOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768213226; x=1768818026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K81YAnOXZO5D4mYdCuhOxp178GZoWafY9YiJgFtn31w=;
        b=Rq4x7cKNbPTPyyv1IFHFtt6qvMTvS8+nXiTndmlj9eaZ7Uzg/5aUVwjvviTfqjmaZK
         2Yocqq2u23noIWkSL5s7F48UOshY3OLkXXWdZHUpRyfpmDs8rYpHVLia/K4+upHMq5OH
         C61lzjbp96EM7kIs4OVuAUkMDa074N04UzoZ2zQLHOXOB+9Pk7bXqFrUOoaayv0mjEBv
         lQNXMp7oraJObDgDgQgvCtSkkFNvD8JETarnu1OsNrkGFHeN2T+Li7jI5CoNHGp4XLXk
         0EkjW6C/Q8/z5XtxeWrUvjOQO6tzhw4jcGUjQ8G/MGtDZVklVYPH6fSalVBZJkLjVXDI
         1yXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNRn+GAshiX8ceiz5kWTCvauoBLtPG43qlYAyZkrIkfTJyq13MWUX0OlBi+uiFu2r4+rOMIg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz14EfNgycz1TzxbAFT7YcnIUeiIcTRMrQAAEy1gerLV4ow/Vjr
	kv/iJoLPrr3weUkXGn/18m9Tv8yt5jx0gm8vjRyyZe8W3p2DalExY+mDVrIJloyio+KPQmJhGfw
	6n+WnzC4iRbe2pkQu0Z+Yokly0Gmo5rpBAsNmgJmz
X-Gm-Gg: AY/fxX5uOQXIJvRc5/dtkvwpz1w+xlTGgS8pU3vmaq+QQiVaVOF5kILF+K/hcCmOGf+
	NRgiTXPOv38rVbJmJMe7JpJw8vAx4mO1/kMtTzRqE5p+30Ja6ViSe6OHf/962sX0LkeqiQmDowr
	xnmvzEMjq0tFrfmvyw/GGTlrB9HDJ9bzO3dN11MFWl0sHIiCtyfEMq8KqBIZmkY+wG+PzaPqq+H
	imhem+LhUxOKFPFFf3fNe2EdrCg0PaMvRU3QkuoUgfauz0viUE+ec8eR8FYNPrdLC6rZ533W4rI
	XBwqVF7tg+KKOGbw3Ep0FHYL7w==
X-Received: by 2002:a05:622a:350:b0:4ff:cb86:eec2 with SMTP id
 d75a77b69052e-501197697e7mr18829141cf.5.1768213226233; Mon, 12 Jan 2026
 02:20:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260109171805.901995-1-smostafa@google.com> <20260109171805.901995-4-smostafa@google.com>
 <20260109195111.GQ545276@ziepe.ca>
In-Reply-To: <20260109195111.GQ545276@ziepe.ca>
From: Mostafa Saleh <smostafa@google.com>
Date: Mon, 12 Jan 2026 10:20:14 +0000
X-Gm-Features: AZwV_QhBZadnJiyUFvTjuypzRI_tAKalJjtR7zhOZQkOyHcxgKv9-680wPv8WNg
Message-ID: <CAFgf54r_au6isA10Nrve=MHL455X=tKhNsSwH1ej-TX08J3xLA@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] iommu: debug-pagealloc: Track IOMMU pages
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, akpm@linux-foundation.org, vbabka@suse.cz, 
	surenb@google.com, mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, 
	ziy@nvidia.com, david@redhat.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, xiaqinxin@huawei.com, 
	baolu.lu@linux.intel.com, rdunlap@infradead.org, 
	Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 7:51=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Fri, Jan 09, 2026 at 05:18:04PM +0000, Mostafa Saleh wrote:
> > +static struct page_ext *get_iommu_page_ext(phys_addr_t phys)
> > +{
> > +     struct page *page =3D phys_to_page(phys);
> > +     struct page_ext *page_ext =3D page_ext_get(page);
> > +
> > +     return page_ext;
> > +}
> > +
> > +static struct iommu_debug_metadata *get_iommu_data(struct page_ext *pa=
ge_ext)
> > +{
> > +     return page_ext_data(page_ext, &page_iommu_debug_ops);
> > +}
> > +
> > +static void iommu_debug_inc_page(phys_addr_t phys)
> > +{
> > +     struct page_ext *page_ext =3D get_iommu_page_ext(phys);
> > +     struct iommu_debug_metadata *d =3D get_iommu_data(page_ext);
>
> You cannot do this - phys_to_page() can only be called if we already
> know that phys is a struct page backed item and by the time you get
> here that information is lost.
>
> Probably the only way to resolve this is to somehow pass in an iommu
> prot flag that can tell the difference between struct page and
> non-struct page addresses.
>
> But I have to NAK this approach of blindly calling phys_to_page().
>

The callers to this, first will check "pfn_valid", which is the right
check AFAICT (looking at similar patterns in page_owner for example).

Thanks,
Mostafa

> Jason
>
