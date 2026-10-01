Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CA44BD0F8
	for <iommu@lists.linux.dev>; Thu,  1 Oct 2026 09:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846551; cv=pass; b=dX1e0DzPz8s0Pte1K8quiSpwKNpwOx0WVoyKwGnHjaSBJYeUMxl/rs+AmBNLoo9oqNC133B3LjkQUguAEUHVgPtJJKMGkhb0Eskrg6ruZTvQ84/i4pPmi7wwugfvRBqfpMX1Mt5FZZVRVN1C39ehbeJaAOau14ZtYlrT2yCG7A8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846551; c=relaxed/simple;
	bh=V7w9RT6/jMXSvTY9xu/CoLxmXP1gIo0ShSPmI0g1iRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MJ6qTbH3NSeeF4gimqbUW9mGNzMiCZnpOnxh52Luuy9W6bPtdzIQpkj0niJrQr0UeAqR4evYq2cX4O3sOs/q/U8wpGwQooVRvfe0r4nznZgVwhXrybovS/cwNFrXg+9FiWCLjqFnJiq4a0/QOMRKmDdlOP5LRjoh/insQ8M5kJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K98MaJ2S; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K98MaJ2S"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso6820a12.1
        for <iommu@lists.linux.dev>; Thu, 01 Oct 2026 02:22:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790846548; cv=none;
        d=google.com; s=arc-20260327;
        b=AW83FHQiEXNVAPbqh2KJq6u7l4Vg8hnb/igUG6c0DM3nv46i/5ECao2IrWMN+YGcpY
         WAbqnCbuNh+G7hhn5rc1C+r6yiScT3RcikTMduyebSS9TUAjsY+shc8cMnFn48KbZW0d
         gwoSf52Bf7bIpM7IfOK3jTTghWPZJWSnTWQsZuC7PJ7MaLzTPD0cVIG0qJZDB5MAEjJJ
         TeORn9HhpCYVGDhQTADRReJAbZjzGfx5kAflmlUVTzH71qzCUsyLvA86/bb0RTgGZ87y
         b9YxDbHd5K5deETvyMDIKViZVKMkPx5lXdjhUeqLlJCJnL4PHwcxf77bp1PjENsG+Q9w
         JYtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LS+b5QYEZXwj6gFLiXoaj+eb3eB33CZCC4l9qAWQy5M=;
        fh=Ap2hXpdGCOAyhZ/Vlc0FAzbWHFA7f1zt9dxqKay623I=;
        b=WJQ+2i5pj1T5VQ894qpBfTwiDHUIuY74zY3ti2iL5d1I6i6WIexGoKARFN5OSVurEM
         DkJB2UqL+UIizzljjSAmlLsPVYtvD6tTwBBt8EeqYiutdjthMwc5tLp0N+Ycbejoh8M1
         8zyxLy6FuQ/LSFwBpIsYpEfzwx6F22FuS6JcWT8K6TGTBQWzNyFlm9khWJunH+0p4H/d
         cnBHyqAro+pV4Jb3bGzqoklGmT8ldn9LuaM1wIbkCS4JzDpx2+HUVgd0mNcMLjMZ5+Ne
         B/fSPb8rQO6vjkWICZGwkGEBEfYx12kwPwHIl5/bpASsh5fzB8TGao9Gn35KhRo298zo
         kTlQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790846548; x=1791451348; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LS+b5QYEZXwj6gFLiXoaj+eb3eB33CZCC4l9qAWQy5M=;
        b=K98MaJ2SdKi24LmFJECkFyZQWeAAGVDxud0Atk/cNKlC9hPEK40jfu9dF8+28EQTAl
         yYQqDm6vHh2IvY5c32ysYQxwiramm3uY2SxNGU0JtmSW1eYAcXqJ1SxRADJfB2BKp5Ta
         6j61gPeCx32JyxrQ75qmHq2PUFlP0OBcW9NES9BlX0sNyaB2+iBvR1a0WCMyhLnGpjbf
         FVQ4JJo0YIvkwmLt4XtU3uETt0dKNmNF729GsJTxVXi1rHVrw5km3PasKNQAmkSIrQPq
         Kedp1KFZUAmbZ2AEABTAUEupfjCk1R9rZMion/4Oz7l3NvoD9eSJ04PMPQgR+IJnLY6K
         0muw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790846548; x=1791451348;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LS+b5QYEZXwj6gFLiXoaj+eb3eB33CZCC4l9qAWQy5M=;
        b=JNJyr5X2xIIVTTixR9NXEeqmIT3hyYW4S2IwCag1pNm7nLwZlzsl3O4dLDR4TxnRqn
         fqgtVquMutsQZs8rkcBkEBNCoBjVjVZxKBcqLKx+94EM0KSioFlDSv7Te7oftcpGeOG8
         /KFnsjVp7kChlF3NWcnkT2veJgRnMP+K7AHRuMg51yXIGvJDl49aVCx/wnKmRN6MHpK5
         3WSbOHF+01zie54o/+tgvJURa/zX8Goh7ZyaxvkF+0UR79t3YfK8MaPH01qv4DRkQWOK
         WrFAkE+pxCt5SgrgyTNs4QioqJ2O8EjpC/XFCuPootm9xBHq3IwMYRome2/bOT59MmrB
         L28Q==
X-Gm-Message-State: AFq9FYIXbmltdIPmGfBmHVl/qgWBXhDDkgNYaoueIMzCWOhJ20fHTQF9
	AQofmfttqK0NZ0PN+EqKOb4ybEX+LzcGQMt5tfM+vchGVmSqFAlhQT7GIrOOTHP2FQpGla9HChm
	vIaHF5pgrciAemC9PLRz44ABhA9G59Uo6aghA4ykrL11BSAVW2BkYowv2
X-Gm-Gg: AYBFou0c5CIxXNd2XzUAFwkKWtMVZiWKKR/cAAG3YUaqX3+kUzKIBdyi5h5I4py3kcZ
	7je3HNVvAXYr4uqo5MX+ot6mF3us4+C/WRu4mDPlECGRYOnp840lYNT5B+Unw5oItqiQoP6mHRc
	a2NNa1OiwJS0lgxXt4xw8wqYazLVKdQaiBB/WEujK7OD9God61MCTchvP/F2kE1QKO+oWrD3Lfs
	9OHEK6MO5zxaTEvEvluYZYIitNI8pjuW3faTXTr4HpA4RAjue8f7u22hhaK2deMMZdbAaynd+ki
	WFVVjNDNEglOaLx6pzpC1WPqcYV58xMLp+eWWMau7W/CRjXOzyYuhB5vrHKa2a75RwKWyV1P9Wx
	9ChHj/6Xpp9zr0HahK1LT
X-Received: by 2002:aa7:d491:0:b0:6a6:7dff:61ab with SMTP id
 4fb4d7f45d1cf-6aec2a88556mr22585a12.15.1790846547632; Thu, 01 Oct 2026
 02:22:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260929032229.3532247-1-danielmentz@google.com>
In-Reply-To: <20260929032229.3532247-1-danielmentz@google.com>
From: Mostafa Saleh <smostafa@google.com>
Date: Thu, 1 Oct 2026 10:22:15 +0100
X-Gm-Features: AclHuK8DyRo1kOX0yEzwjP3x5xBaVxPUeUIKTbhx-ET7ExOLyAfpUtxdkVDAPSk
Message-ID: <CAFgf54p=0wy9vAJKf8U_B9r27Z8UfqoNCXCeMDPdVETK9m5kAQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Align memory attributes for
 SMMU-originated accesses
To: Daniel Mentz <danielmentz@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Tue, Sep 29, 2026 at 4:22=E2=80=AFAM Daniel Mentz <danielmentz@google.co=
m> wrote:
>
> The SMMU specification defines several types of SMMU-originated memory
> accesses, including Stage 1 and Stage 2 translation table walks, stream
> table accesses (L1STD and STE fetches), CD table accesses (L1CD and CD
> fetches), and queue accesses (CMDQ fetch, EVENTQ write, PRIQ write).
>
> While the memory attributes used for Stage 1 and Stage 2 translation
> table walks are configured in io-pgtable-arm based on whether the SMMU
> is coherent (ARM_SMMU_FEAT_COHERENCY), the attributes for stream tables,
> CD tables, and queues are currently hardcoded to Inner Shareable,
> Write-Back.
>
> On non-coherent systems, however, memory for stream tables, CD tables,
> and queues is allocated via dma_alloc_coherent() /
> dmam_alloc_coherent(), which provides CPU mappings with Normal
> Non-Cacheable attributes. Having a non-coherent SMMU access these
> buffers with Inner Shareable, Write-Back attributes results in
> mismatched memory attributes between the CPU and the SMMU.
>
> Configure the memory attributes for tables and queues in
> arm_smmu_device_reset() and arm_smmu_make_cdtable_ste() based on
> ARM_SMMU_FEAT_COHERENCY, matching the attributes used for translation
> table walks:
>
> - In SMMU_CR1, use Outer Shareable, Non-Cacheable for non-coherent
>   SMMUs, while retaining Inner Shareable, Write-Back for coherent SMMUs.
>   This applies to stream table accesses as well as queue accesses (CMDQ
>   fetch, EVENTQ write, PRIQ write).
> - In STE.{S1CIR, S1COR, S1CSH}, use Outer Shareable, Non-Cacheable for
>   non-coherent SMMUs, while retaining Inner Shareable, Write-Back
>   Read-Allocate for coherent SMMUs. This applies to CD table accesses.
>

A similar patch was posted previously, and Robin highlighted the
reasoning for keeping it as is:
https://lore.kernel.org/linux-iommu/c25309d1-0424-495e-82af-d025b3e6d8c8@ar=
m.com/

It'd be great to highlight any changes since then.

Thanks,
Mostafa
