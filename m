Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDD836CDE4
	for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 11:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768302673; cv=pass; b=uf6lfaMCMmrddlht3a/aPFavx1zXIVgyI7rTMpP3DUUoEF3gu2vw4QOQdW2W0NpsTPZ0xT3t+oLDH9ZuYy9KF2FcpcnEhbPgwQBuGzaFkrKTCtitaCSJtYFYkesImoO70eLQf4HRqBD20ExGvJfQgEncb3fEOBB0U2PqwF9vSws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768302673; c=relaxed/simple;
	bh=ewyYSu4U4rDrQ6g5eP349UtA4V/L3pb9prshEHmDFQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HszU3xLWrtdt9P4VsPoVDNKfEFWKR1Tpxf+PqcuXxeRV35XzN2a+TTjzFUEJWsmjTFUFQjktwSQdw1O2+nXkz3caIjAWd3MetHF2IemmakLp2e0TneuvjT92UULOZdd2NC+F8gma25iTzqiUWk/R7Cs4qA/kFCMoFT+XM9canv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HPTzGYPF; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HPTzGYPF"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64b66d427e9so6532a12.1
        for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 03:11:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768302670; cv=none;
        d=google.com; s=arc-20240605;
        b=Nkw/0OHa9Snalw2dIEGIZ6dxta4kzcQjUzyhoUPbQsUh37pPaU8uVeoC8K50/0eVuq
         UnnwTSnR0tuH3dymBNq7jIJsrbfcmZwT9LDCwqJVi6jkUaECbEueIE+PqhIVy9X0dyEl
         r9CJsoguIkm0NhaQQ5yJnaVUuHevSvyeEj4JxgA7P6610VaVo1OFWrQ8Qn54dMQfq9bx
         W7EbcfcTgSxtbBBsfG52t1n2AlQ5tnwOXOw5lByytoVsWE/a5pO4RJ+GUtZN5SZ3f0Se
         wgzv8ZTrdLeqhi2ky0AryuDnujQAZaGlhtvUTNgts8taSatI1HXCLbWELJ0iKish0iiS
         lN/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KDqRWolsacePh3UOFidtjakTxzNfCPsnv6damvWujAo=;
        fh=I+P0Rr3Kq0JzmbJwoESGzjXhFI41Aft7dZTE7HgqicQ=;
        b=l0uMChiXBvjKEn6avRE11IH9ijn0n7KlwnMj2o1ZSTBAuylgwPW6sP2kwWra5BqCl2
         8iXGWohtgj6Uvsh2y5ks7ratR6aY5Og1HwS7grlJhDmrDLLpiNnkzkZaBnyB4ij2O6Vt
         88ES4HtOxAau86b+9Hf8UFTvpHRSqFyCZFfi9WOh35FPZFZh/hG0vtLyvwjt13JctbVc
         zCU6qAfDibNrsxzRqfTqvFKz29naLyXAwYQj4QqF9og0uWEnDReRVYpX6ZP7wbpO7HOC
         hEni5VpJWS8aWqJJtIZBDT9i9V0PMDaRKcTHHRYWXZXS12l8mKOu7X9IkZEjN38CYTSc
         Qkmw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768302670; x=1768907470; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDqRWolsacePh3UOFidtjakTxzNfCPsnv6damvWujAo=;
        b=HPTzGYPFx1gNAmP5fm1C+Jgw2B/3cDEX38pMhdCa4uv/eI/oXf6O+JYlJ/S+IoNidy
         8hRoNk63RxKOMT03ePHczLsi145b/TcI1ykwoOnck6Cb/jNjRVoy94LxnS8p7F5MgREX
         R2bo7GY1rQNbxwMj4+Ta6MgXmPlM2dsF4Ur7iU9WAQrnbD0t2mXYCaddbq+SUHRofoyO
         NNzwNW26lPIbDctHUzV2dAK/qnjrMiJgub6oWgBjmt5gNIfccNmTNnMXfLj6YE9Gq/30
         jPrec5j9MmSjKFp/sc7f/5gOwLvrYkfICadUH6n9dh8ERFMWsWrX6O2e5dtqOpnc3Mw/
         DPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768302670; x=1768907470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KDqRWolsacePh3UOFidtjakTxzNfCPsnv6damvWujAo=;
        b=mRfAXcvJ1xZYyQHNxxP3iLwN6/6EJ6wmcNrd/jNkfzvIoGhkBVciM4nIMJ+t+8TbFT
         hQgUuRpOX9aIKDJwi1um1QVhtRqoGEivKwxXbG2RnP87kKJvZfvHdYJkJ1MHbTP+GHbA
         J2tkNtKd/BhFFJ5zFNYQYF6DBXa59Jm6pQc4GIVGHLtWNwCZVL0KDlGxOnw1zzSuqQZ3
         TgIwV6ogIdq1vj6MlS66tBOO245Z51CkMsWq58w0kQjjc0AT5yQiPfMJxRjIZUCSUT/1
         WbkO7GNGnzzlnAeqzCzdu3iuGW2IkURKZ/XQN/WAacODZ0HDaKrBFw2BhFBbzwR4gn2D
         QtIg==
X-Forwarded-Encrypted: i=1; AJvYcCXQOVOIK4DrQN4Jl5Qcn+lE1xJZjMvBLrCuQhY8aAWBfD4GZYWVxiWkgrHJsmqeorU/9US72Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxKmbC7BuGIWP9/4ULicsd4MEmyOpsI1qf0hMHH2X5mrzMxeSKJ
	zv84EgmfQmVqE+pBGzyibsmvCfyhQupNsT3mNKvHQnavm2b0G1N3s/VeGy8LBzTamELuIGxgyXV
	q0KmzF/f0S5oYUW1blp9M2TyjRoTaAcMfsS22J5Yi
X-Gm-Gg: AY/fxX4y9bS4P8QoAlgGDE89ET6O8JH49mNjoFiAzgiqJWPQJME9Xe9NoJSgFHOg2A0
	8nmxUgKapUOfvucyWV52NXhpmNUgPctbx8asSET3CUb9HWxMhPOCqNu28H9oNzcYSmhxEtKlPl9
	3M8fdaY7aLdHEN0op22WoH7MZIGQNOVDPvlKUX4AoOqbhlIPhyJQ1zmWQoTg5D5y9mKWt9cH7z3
	J0iD+Dt8y/w7lq+TmcMu+Dhg7D8gH2tEUnwAP4wKWb9nvhoyU0TZHBTX6k6Y0HcOVrTFtkCXaTF
	CYCnkBGpCNWncPtMT3bxw5omzg==
X-Received: by 2002:aa7:cf05:0:b0:64b:53a1:7b09 with SMTP id
 4fb4d7f45d1cf-652f503ee6bmr32524a12.14.1768302669759; Tue, 13 Jan 2026
 03:11:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260109171805.901995-1-smostafa@google.com> <hf3gfmaq673tvz6lc7mgip3m4y4o62b3nyqlofas252qr5776y@6oekozsrwea3>
In-Reply-To: <hf3gfmaq673tvz6lc7mgip3m4y4o62b3nyqlofas252qr5776y@6oekozsrwea3>
From: Mostafa Saleh <smostafa@google.com>
Date: Tue, 13 Jan 2026 11:10:56 +0000
X-Gm-Features: AZwV_QgEqIamUf-ZRcxgt46xlqga3cO4Nf6E12yZEj_ySpaNDevCFdZsj-pUJ20
Message-ID: <CAFgf54opD5qveK7njnCgkWeNYWSwiPHTxPBL2ouQYFEAL_kYKQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] iommu: Add page_ext for IOMMU_DEBUG_PAGEALLOC
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, corbet@lwn.net, will@kernel.org, 
	robin.murphy@arm.com, akpm@linux-foundation.org, vbabka@suse.cz, 
	surenb@google.com, mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, 
	ziy@nvidia.com, david@redhat.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, xiaqinxin@huawei.com, 
	baolu.lu@linux.intel.com, rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2026 at 9:53=E2=80=AFAM J=C3=B6rg R=C3=B6del <joro@8bytes.o=
rg> wrote:
>
> On Fri, Jan 09, 2026 at 05:18:01PM +0000, Mostafa Saleh wrote:
> > Mostafa Saleh (4):
> >   iommu: Add page_ext for IOMMU_DEBUG_PAGEALLOC
> >   iommu: Add calls for IOMMU_DEBUG_PAGEALLOC
> >   iommu: debug-pagealloc: Track IOMMU pages
> >   iommu: debug-pagealloc: Check mapped/unmapped kernel memory
> >
> >  .../admin-guide/kernel-parameters.txt         |   9 +
> >  drivers/iommu/Kconfig                         |  19 ++
> >  drivers/iommu/Makefile                        |   1 +
> >  drivers/iommu/iommu-debug-pagealloc.c         | 167 ++++++++++++++++++
> >  drivers/iommu/iommu-priv.h                    |  58 ++++++
> >  drivers/iommu/iommu.c                         |  11 +-
> >  include/linux/iommu-debug-pagealloc.h         |  32 ++++
> >  include/linux/mm.h                            |   5 +
> >  mm/page_ext.c                                 |   4 +
> >  9 files changed, 304 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/iommu/iommu-debug-pagealloc.c
> >  create mode 100644 include/linux/iommu-debug-pagealloc.h
>
> Applied, thanks.

Thanks a lot! Based on the discussion on patch 3, I might need to
respin a new version.

Thanks,
Mostafa
