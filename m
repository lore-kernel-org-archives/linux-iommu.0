Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BFD3FB32
	for <iommu@lists.linux.dev>; Thu,  1 Feb 2024 22:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706826579; cv=none; b=W1QQBlrwpDtPiO4ZYE2PKndWUkJoFt6iE4i2fHSWFzLzqbZT3mqBMPjD6zb98sfTrsUn8PDRuUg3AcTWNm2XVC+V8Vlo7PRe2qSrEzoEiAgYyb6uXGtqooExHBNwkrIG+bT2L61QCBcJnZ2fSde/iwlSKfSwahf2cV6G8S5ltDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706826579; c=relaxed/simple;
	bh=dEloljQr9NL2fQj+p5tojv6uWV6NH/+lSQT7Nh2TvXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rIRQboZYupUvdAgA94FO+dJDqRh1XxIPhC9qegnc8IaT3LCfGf1Aauc3q6ZqZx66QKMFp6COD6mDkizJ5gxbHa2q/AuLRTMGEWE+BXwpNTQco5k3QXgVS819vn7MvbhUxVeh1HKVPzk6/M12uRuiNtOOSWMirBiFjOLczf473w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eu4dV9AA; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eu4dV9AA"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a354408e6bfso444360466b.1
        for <iommu@lists.linux.dev>; Thu, 01 Feb 2024 14:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706826576; x=1707431376; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGDKw/IQ4kdSzFRMSnxN+nzueWWpVC66gEX7pOJuy80=;
        b=eu4dV9AAhMS0LtPxgoFptC7k7hfLizajvQtcYL38aAQh7OfWnKw1rB6ghSDnXpHXeH
         Qonm2eFNeeh0fZG33FZPFs9Vmo/VKr10mdoyILoJP5/eH6Sk7o2XbD5msoBsIzbr32nV
         RkN08vjsP01Z404RmFtGV7H1TphWLCHc5onYHZu+HviE274aWuconkLmGL2bocjDjFE7
         YP1MZSiI/vkBA/QGQLOrQWL1/bNQ8i1wpA3qdQpIVPzYzzdST8MZVxrl0tT4KkEvAMmW
         R9ZtMYcQeF70s+zgEhfR09xfPVJo7QZkpsaI8LNjFxV1uicfHJ/YSSq1gRTFMckr4/tg
         ZdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706826576; x=1707431376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGDKw/IQ4kdSzFRMSnxN+nzueWWpVC66gEX7pOJuy80=;
        b=G2ru9hX4nlKtrOq+tvGacDdejoTXzoc/RMoU7RkdkJTEowvHZ7Tk+F2xjwo5DLECdg
         KPwb/UxUO9IZbxhoVnGu+PknfaHi5mDoOLChLDPUXR5xyTiuHEhmyelSK3QLOiN5Tmyt
         4YeNE+sGu8ca1Xx0yVnU5Oo3nG2ixhm5o64a0DFEmH3MJHZ1PwvhpcKjrLIzSwsQx5KK
         kvU2M/Sm2jgwPesxgBlrOG6OgXC2iQDiqNbS3n+DxWGLLSJqdVNtELNY7+ZscndAFRa7
         hNx/zen7SiDxQoq40PAiw8k76UM0fAmdIO32uQ0xSQaWSIkW4P0Ax58ajO6sb2XOG9xL
         2/Cg==
X-Gm-Message-State: AOJu0YxtGSTyOe3B3LHbG7YrmzGAULfOH/OwtAzczui6RCHwh2ZQINC2
	vOyBviY5zW+EU9yhY0yDZi1lVl/oLOidjNAlxN7RKQdjNAqec2Mj9wsKmIdTA9l7CZtBPu/vHpM
	S587DQyQDC+qPIeAcLlz/cIlIxewOXJejF88z
X-Google-Smtp-Source: AGHT+IEuhiZvixWFGymGW7m4qj1dTBRZUXAhAcduL9snVjgqkWJ4xtPr92++LvjpCa9nwtPiSV2wXnbN3Xjfiu/tP6M=
X-Received: by 2002:a17:906:43:b0:a36:c8fa:45a2 with SMTP id
 3-20020a170906004300b00a36c8fa45a2mr320163ejg.1.1706826576073; Thu, 01 Feb
 2024 14:29:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240201193014.2785570-1-tatashin@google.com>
In-Reply-To: <20240201193014.2785570-1-tatashin@google.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 1 Feb 2024 14:28:58 -0800
Message-ID: <CAJD7tkbDwwzTfm5h6v5f8XSN8KduBy6h7EVuQt0CAfX--Nb0gQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/iova: use named kmem_cache for iova magazines
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: robin.murphy@arm.com, joro@8bytes.org, will@kernel.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rientjes@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 11:30=E2=80=AFAM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> From: Pasha Tatashin <pasha.tatashin@soleen.com>
>
> The magazine buffers can take gigabytes of kmem memory, dominating all
> other allocations. For observability prurpose create named slab cache so
> the iova magazine memory overhead can be clearly observed.
>
> With this change:
>
> > slabtop -o | head
>  Active / Total Objects (% used)    : 869731 / 952904 (91.3%)
>  Active / Total Slabs (% used)      : 103411 / 103974 (99.5%)
>  Active / Total Caches (% used)     : 135 / 211 (64.0%)
>  Active / Total Size (% used)       : 395389.68K / 411430.20K (96.1%)
>  Minimum / Average / Maximum Object : 0.02K / 0.43K / 8.00K
>
> OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
> 244412 244239 99%    1.00K  61103       4    244412K iommu_iova_magazine
>  91636  88343 96%    0.03K    739     124      2956K kmalloc-32
>  75744  74844 98%    0.12K   2367      32      9468K kernfs_node_cache
>
> On this machine it is now clear that magazine use 242M of kmem memory.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  drivers/iommu/iova.c | 57 +++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 54 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index d30e453d0fb4..617bbc2b79f5 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -630,6 +630,10 @@ EXPORT_SYMBOL_GPL(reserve_iova);
>
>  #define IOVA_DEPOT_DELAY msecs_to_jiffies(100)
>
> +static struct kmem_cache *iova_magazine_cache;
> +static unsigned int iova_magazine_cache_users;
> +static DEFINE_MUTEX(iova_magazine_cache_mutex);
> +
>  struct iova_magazine {
>         union {
>                 unsigned long size;
> @@ -654,11 +658,51 @@ struct iova_rcache {
>         struct delayed_work work;
>  };
>
> +static int iova_magazine_cache_init(void)
> +{
> +       int ret =3D 0;
> +
> +       mutex_lock(&iova_magazine_cache_mutex);
> +
> +       iova_magazine_cache_users++;
> +       if (iova_magazine_cache_users > 1)
> +               goto out_unlock;
> +
> +       iova_magazine_cache =3D kmem_cache_create("iommu_iova_magazine",
> +                                               sizeof(struct iova_magazi=
ne),
> +                                               0, SLAB_HWCACHE_ALIGN, NU=
LL);

Could this slab cache be merged with a compatible one in the slab
code? If this happens, do we still get a separate entry in
/proc/slabinfo?

It may be useful to use SLAB_NO_MERGE if the purpose is to
specifically have observability into this slab cache, but the comments
above the flag make me think I may be misunderstanding it.
