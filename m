Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86C43E0C66
	for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 08:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781686098; cv=pass; b=JAIcdgoxFexgO8Up6YHZ+YfcijfGHq55ABy9Bezharo+JXZ0F75kvzLo9xmwnQ5abfBe4ipiuP11j4uPMmoBYHxcAmS73OHkxuMhR/CgUwIPRiRhjmRP8dAC6HfvX3c1DpXP0kXMiY49Dk8NM/LCdCXPFDmGl9DjcRbVNinpfDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781686098; c=relaxed/simple;
	bh=p1FE8ePybyliELcAtdDczwdwV+c77ced4FMMA0RKG0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hDhuwKXEko/e6qkkOs9Tjvh2kB2ndlqaOMuRFFzoEcv18noycTes1N2C6pmb6eHEYA8F85gKxCelIRL/NZJc4DedBrGD4FWV6ZjUmK16CR6BYICpmlPthSGISaK0/YPAmDrWMkfnvTWcPDqETYTRlvED3q7jwUi3wCS+EYCxvO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MRErrwLD; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MRErrwLD"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5177d1ff061so162091cf.1
        for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 01:48:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781686083; cv=none;
        d=google.com; s=arc-20240605;
        b=USmULwQRhU3nh9maUBDLl+Hh8bMF+2LB864nqNBfl7+B/qnYs/0S+639gKcBkoiYto
         Tm/D3P7Amuhv3+Lsu6SuOVTQmtKvvsJYMbyuuZk3kQ0sOQxXZiJZmVkMTYTGgB5VJFlT
         KtggU0s7dXpYrtQejLbOzo+GHsArGNeS0BpOKDprkV7Vu3P3b+jfYl2XMR4zM0Ric334
         VgrRjhmegBU9xDEIx9lA8/Fo2sfYFAWYQB7HcuhcNRfKKfDp3eOKKb8vSisYljhblB9i
         tC+ThRSlGZR4YSjgbCBxYXMp2lpPNMfvt+Ea3G4NOOKX+tBBso27gBjUsyWfYlKQBN5c
         LSoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WLx8blRS3qd8Iflm+qxwiIWxR7fE6sww6ehyoGaBtHc=;
        fh=XjuRBUEnJm1aUP5C+mLRCCrOBULTwhqdSbv6l43+xhI=;
        b=NXqaDh6dU9ajX0klE0MV6UHoigoPLfj/bcxaQSA22z9PJSqSwI80lGaPrlJ4IJl8od
         1KVf/oDQS/nZV+oFELfEfl9r5z7SvK8RkJB2JDjwew1H2pkvxRc7JfSmgzF6M8sNLDd8
         9QAmvmBJcNKAP3JmMrwaqeUHwDhINZOQJEbCvNOg3mstiyHYxKv5qZ/t/lqUfdbyAvBA
         y0ind5RDxelRyeXaaMvpv9S5hP+qRaOjtD5FemB0Z4lAscRdfIsrKYGrDO66khvfuU0y
         QAk8BqsbtLHr64ifcWIYgBEc5+ku5HsFIj2TUhjzMN78g0Wq+/jiKGVD2kuFK+UW6DVI
         5jCw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781686083; x=1782290883; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLx8blRS3qd8Iflm+qxwiIWxR7fE6sww6ehyoGaBtHc=;
        b=MRErrwLDT2tagu3ECiJ0y0mFeEomxwnrVX7kMgfrNAd+Pt8NaxXCPWFnan+HrJsk9o
         cQ9J9CxRa3aaYlfx5NAf7MuDAXnqwtTOgE6eupc/wUi6mOHYEDmsigsOW0FC1+RfPH9c
         wmUCUQ5W42QdJCdQPoeFbIuTj2bs/4ImSug95VWLHTvjbo5coTX1ViIAjQ4TgciivCEW
         qM2Hnwz8HCJqjanz4kgpM15yhtkur7STmvCt7D4xImSXoMCNc4IipygLl8nuYiyOZUdi
         yvi3gDB8GaNNMGi/4+1bZ3MHTOHDidJ1F3zx3E+02+GTOT9vS/ZUeu2otZlfb52X++V2
         D58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781686083; x=1782290883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WLx8blRS3qd8Iflm+qxwiIWxR7fE6sww6ehyoGaBtHc=;
        b=UOzojCWNrsYbyh5CxnIVFGCqWfGzLou0g1NG2KImuW8nObvdENBmsLKmxlNzVxs1AK
         sVkkuBCddBWwBIzfmrox75d9gm0F6EPmSvIyuwSWWb7U4fi417DQCMap7YWDUDtcpU6r
         A5+S4F6ylhztlp+DkViSSk3tD3gsrSQ6sAnUiGWfITwhhFG/burQoxPajr5jcaYC5P0F
         ceKz0g/9loN9FwIuQicMvYqjN+Zdo8y54fHQy42XfEH0OG7AZZrRKfBBH5Hxz/JlgvuN
         lWfl4B+eqvmc50hO4XJd6EOjE+UtQZYwYo3h/qrYpAGC2erLoMAlGyZQDh6MS50HLd13
         HbIw==
X-Forwarded-Encrypted: i=1; AFNElJ/F2wzfqYu350/nBSSTUHX3ONS3qIGV4AX6ZxfNQcVb/7mrttf36SAFWu5RHbrpycNw1s15lw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3jylFoaAO72IuExe1XXKverp3fihjrW8l2Bkn3XaM7BngKdSC
	M87QyNGz/FQUUkPEHVLtXV+d7ZFwNt9fJkP+LMBOyYyDqQZ7sf0oqY5VSRkokS8L9JfuVRhs78R
	tZjO8IgHjg9mlrDHFnzrpH/cMqSLzJ1FijFyuJ2lS
X-Gm-Gg: Acq92OGe1Ow5q4Xkgoj2XcCS5S7mfDhO+2h6P2DilO09KIiXWVK6UzVW1ArMpKElbst
	7gqT0yMMe66ard2LTPXBKL79+g8U/2uhCiGXmshDo8gfX0j418XEySU/OcZ1ygjKMAgZXF4y3XJ
	7ux0CXJWZmlxsRqRq0WI/pd/CpIZX9W5fBuZHv0wgkC8NoqBlp2JiWJbtd25FZrJzpUkhdJJWph
	JvRc9K34Z3d8wDBCUPQMGjSkl9/bhKFmQK4x4dF40Eu4B/cp2DkiEIlF45GnyCXmwL5BpTunMYL
	RgyNmlIhwq5PQ5FGJQRCPPYOBjk=
X-Received: by 2002:a05:622a:428a:b0:517:5c70:46bd with SMTP id
 d75a77b69052e-519ad98ab60mr5711321cf.11.1781686082925; Wed, 17 Jun 2026
 01:48:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260617-swiotlb-v1-1-abfee3faf4ea@oss.qualcomm.com>
In-Reply-To: <20260617-swiotlb-v1-1-abfee3faf4ea@oss.qualcomm.com>
From: Mostafa Saleh <smostafa@google.com>
Date: Wed, 17 Jun 2026 09:47:49 +0100
X-Gm-Features: AVVi8CefnbdGizQByy8DeFLif-IOhZOotOQKuAbe1j0-90hAInTE9M5SkprE9v0
Message-ID: <CAFgf54r0oXgaFMQeBOV+jm70XoMUKFAOkRhNLM2FrFa_JhmwKA@mail.gmail.com>
Subject: Re: [PATCH] swiotlb: introduce Kconfig option for compile-time
 default pool size
To: bibek.patro@oss.qualcomm.com
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Jagadeesh Pagadala <jpagadal@qti.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 10:36=E2=80=AFPM <bibek.patro@oss.qualcomm.com> wro=
te:
>
> From: Jagadeesh Pagadala <jpagadal@qti.qualcomm.com>
>
> The SWIOTLB bounce buffer pool size is hardcoded at 64 MB via
> IO_TLB_DEFAULT_SIZE with no compile-time knob to adjust it. On
> memory-constrained embedded or mobile platforms equipped with a
> hardware IOMMU (e.g., ARM SMMU) covering most DMA-capable devices,
> reserving 64 MB at boot is unnecessarily wasteful =E2=80=94 the SWIOTLB i=
s
> only exercised for devices that bypass the IOMMU or have restricted
> DMA address ranges.
>
> Introduce CONFIG_SWIOTLB_DEFAULT_SIZE_MB, an integer Kconfig option
> (range 1=E2=80=9364 MB, default 64) that allows platforms to set a smalle=
r
> compile-time default. IO_TLB_DEFAULT_SIZE is updated to derive from
> this value when CONFIG_SWIOTLB is enabled, preserving the existing
> 64 MB default when the option is not configured.
>
> The runtime "swiotlb=3D<nslabs>" kernel parameter override remains
> fully supported and takes precedence over the compile-time default.
>

Just curious, why is not "swiotlb=3D" enough in your case?

Thanks,
Mostafa

> Signed-off-by: Jagadeesh Pagadala <jpagadal@qti.qualcomm.com>
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> ---
> The SWIOTLB bounce buffer pool size is hardcoded at 64 MB. On
> memory-constrained platforms with a hardware IOMMU (e.g., ARM SMMU),
> this reservation is wasteful as SWIOTLB is only needed for devices
> that bypass the IOMMU or have restricted DMA address ranges.
>
> Introduce CONFIG_SWIOTLB_DEFAULT_SIZE_MB (range 1=E2=80=9364 MB, default =
64)
> to allow a smaller compile-time default. The runtime "swiotlb=3D"
> parameter override remains supported and takes precedence.
>
> Before (default 64 MB):
>   [    0.000000] software IO TLB: area num 8.
>   [    0.000000] software IO TLB: mapped [mem 0x00000000fbfff000-0x000000=
00fffff000] (64MB)
>
> After (CONFIG_SWIOTLB_DEFAULT_SIZE_MB=3D2):
>   [    0.000000] software IO TLB: area num 8.
>   [    0.000000] software IO TLB: SWIOTLB bounce buffer size roundup to 2=
MB
>   [    0.000000] software IO TLB: mapped [mem 0x00000000ffdff000-0x000000=
00fffff000] (2MB)
> ---
>  include/linux/swiotlb.h |  8 ++++++--
>  kernel/dma/Kconfig      | 22 ++++++++++++++++++++++
>  2 files changed, 28 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 3dae0f592063..1665a9ce8f94 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -32,8 +32,12 @@ struct scatterlist;
>  #define IO_TLB_SHIFT 11
>  #define IO_TLB_SIZE (1 << IO_TLB_SHIFT)
>
> -/* default to 64MB */
> -#define IO_TLB_DEFAULT_SIZE (64UL<<20)
> +/* compile-time default; overridable via CONFIG_SWIOTLB_DEFAULT_SIZE_MB =
*/
> +#ifdef CONFIG_SWIOTLB
> +#define IO_TLB_DEFAULT_SIZE ((unsigned long)CONFIG_SWIOTLB_DEFAULT_SIZE_=
MB << 20)
> +#else
> +#define IO_TLB_DEFAULT_SIZE (64UL << 20)
> +#endif
>
>  unsigned long swiotlb_size_or_default(void);
>  void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags=
,
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index 0a4ba21a57a7..3830a63ae032 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -86,6 +86,28 @@ config SWIOTLB
>         bool
>         select NEED_DMA_MAP_STATE
>
> +config SWIOTLB_DEFAULT_SIZE_MB
> +       int "Default SWIOTLB bounce buffer size in MB"
> +       depends on SWIOTLB
> +       range 1 64
> +       default 64
> +       help
> +         Sets the default size of the software IO TLB (SWIOTLB) bounce b=
uffer
> +         pool allocated at boot time. The default is 64 MB.
> +
> +         On memory-constrained embedded or mobile platforms (e.g., those=
 with
> +         a hardware IOMMU such as ARM SMMU covering most DMA-capable dev=
ices),
> +         a smaller value such as 4 or 8 MB may be sufficient. The SWIOTL=
B is
> +         then only needed for devices that bypass the IOMMU or have rest=
ricted
> +         DMA address ranges.
> +
> +         The minimum allowed value is 1 MB. This compile-time default ca=
n be
> +         overridden at runtime using the "swiotlb=3D<nslabs>" kernel com=
mand line
> +         parameter. Refer to Documentation/admin-guide/kernel-parameters=
.txt
> +         for details.
> +
> +         If unsure, leave at the default value of 64.
> +
>  config SWIOTLB_DYNAMIC
>         bool "Dynamic allocation of DMA bounce buffers"
>         default n
>
> ---
> base-commit: 4fa3f5fabb30bf00d7475d5a33459ea83d639bf9
> change-id: 20260617-swiotlb-c215ce0b23f7
>
> Best regards,
> --
> Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>
>
