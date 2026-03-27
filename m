Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F85384224
	for <iommu@lists.linux.dev>; Fri, 27 Mar 2026 19:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774640620; cv=pass; b=cn6pC2SIgrZoasP3rLIn1K9Ss4usugTe+JChbwWSv9gBDzGw9dXsZWsw+k4f1JSR6TMtFDQJtNASBDsQC0h/aoALte397457ql6Ni0a/bTtBLNdYG0mN90xbTblV+6m8Q7lLFMMXARuIoXXILVAz/fNUvzjoL67PjWczQ2CpN4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774640620; c=relaxed/simple;
	bh=mAa0q11vT2K7+sL7S++M6Oz+Ma+owZM4tYL8Ai5PqnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ktba/MhxGq+HDFbUSxRkcWuA5Ng9iR5aOjQGEpHMQSY43jhoDwkyKBjGwGLBgD9Tyuc2mIvV1tfSeEgjkxhvZBUwGegmViCkrYvAlZ9b+mSYrslxM0+nZdc4SUvv6Bgye0xwQf1zifv80uVoI1pvbb7MLNHiRK2YaqQshuthBUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rxF1CPGb; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rxF1CPGb"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4852ef20fe8so2535e9.1
        for <iommu@lists.linux.dev>; Fri, 27 Mar 2026 12:43:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774640613; cv=none;
        d=google.com; s=arc-20240605;
        b=Z3M7z2CQtUnngpNnRdslOOGBqSJyS7iBgfVOig8GM0fF4ajPVM1zjgM8APokg8NJBS
         LuGKxyqNgoot7E85I4P8iodiSCMHYmSmp9dwJPkjgfrtlv3N8Ey9HYwUwlEWTOJWrSGU
         Hd4AwKpNGukymHHKp+mhljJMvmlJwFLGrnIT3mkQLsdUS6c9OJXPk0RSqSjtKKs9WbPK
         sf7Eo/EA89H47d8hUr9KWK/mdNlilX7DPuz+wwrNk1oYNf8x0uCsGUcsbyz4tKhdw+iK
         kU/qAXAU4Orknlf3KZ+I53YsHmc6RLgRt68Mhb/EkH21aqAY+IO5jQXoSKLy1b8VOZFq
         W9ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7tjhOfzQT3ZRSG3eV9w6+z7kzXwwNkzHiubxpA2Yl+8=;
        fh=0m5btCx0jcHAE8LMfCAK6sbs8n1jgQB9qxg3iLVP00k=;
        b=Ucwq0DnbrT3KcARSEmFJ09ZuuFkeSMBrjtXZqV85fLQGMoI8t6NkC2pdHb+832tAZS
         vKYvE3ugfyfkx4HcwlmHQUh2ahqxN1zqVpoxBHXjbXMma1lN+/AQ86XSUFE6ilHVZT6k
         Kinr+IAHk4Ix/utFwjJBG9BJXcaF1+22K4ATfw4LyaXYLs5Lkd9PUmrveb2/mluHvD3F
         dbieyLu/kMNT057CjdyzmA9LQzpk8++fPXlKv7rXJVxYU3axJOtUAWgu3lwOgsEe9CzV
         bSJaj2BNAbp7LGJrXgVzGSvE/bEVYtsi82x0aj1GMRntIX7BZBSOyldLkYLo/JwGjs2s
         k+gw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774640613; x=1775245413; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7tjhOfzQT3ZRSG3eV9w6+z7kzXwwNkzHiubxpA2Yl+8=;
        b=rxF1CPGbcU11kRXQB5N9DS8JQvNNeZXWml+bE+LR2NrLR29DGARZ7d42+VdKQL55Ox
         gL+w5l7A5IaoRRD89Z/XHLq2QYqUu4M8JjPpxcEYroV22+y1N5VrRa7MJjKIAaJ8As46
         orJf5E8qyvIagpywo2sqtXwVmZcfeRZLXGI5chP8wlcW+T+NkW9uBltTdBy70yDfOsmK
         DplUgMmUEXCe1qA8KDxw7G44WSIZSZxiEGjIy9Naooj6RtUFSHrr5EEVzygBVNA3M3uS
         AikiDYvxWKFbn5WDDBzTZZAQ5boBlmlAnJCpyzMsQMeNZU1qGHLSbZE/lpUjvSHwCg1v
         RKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774640613; x=1775245413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7tjhOfzQT3ZRSG3eV9w6+z7kzXwwNkzHiubxpA2Yl+8=;
        b=fUXo7F1ttbBjWawOQ03Q9yFk/y1Li2+7GTBxQ6ByOQB60XDtjZSvNkV+HduT9CSiV4
         xZiUsrWcnnEh4MOXNWFsjaO9l+xdTgNOm8Uto1C1MscMwoZB2KOnJ9MB9s3NLvhkFrC+
         1pudq/yY+CSD2N9gaG0+2WC5boscc+8DrsInvU8hf9fJiKYEa/58OBeInmGWniWA8iSi
         2agscc899o2VFqUCdPP33MLddrJsf1BnDUbo/ylyTKg/VhSHSrfJk7vZjWBVll1pADkm
         ZrOh+zd1/SdNsGMvTbI3ZixnMa1y98y0s3AjmgMKHHl/qEy/WEBA1QXNeFLOiHNxzH05
         C5nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJsbhaV+zsZXtGSlZCSpP75PGNedWpBs/fJUIgLDPrrrxytyX2u84ctJZmbuY41WVUbOvOsQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzi13m2yS+9hTQ6A64NE3acR+cQvOkhByQDsASrI2tff5rOuon6
	H7aRHrOO/hwx7ZwFYJZ55W/ogfIWBRiu3VE5ZouwaovQHGtQIqlJnKomp/AtBmI5cFO+615KBNf
	3kGY0iB3NjTPERPdyaXkdIRLiEQb00S1rO8+z1a79
X-Gm-Gg: ATEYQzweqnIUfNS5ULMpQuHiDfhvX6uH97JuHHFSWJIbpuKxd05isBjAzjhf6bQasD+
	IDAbpGMMgt9UregVuXQnjpQIs3uv/QRKaZxf/uRlIj2G52BwujjzhXhJhjxPykNiv3W0fqt7nWn
	98XqkylJ9tUHZ4pjnRpHaFeUVl3Lb951+eRHadin1+2Ex0GSn5BB6FOeJwjRsUJ2arHyliRj6JA
	PSZ8ShkDobgqKZcK2mrLWguC6wur1TjWDCeNF9mkQJ37nEuaLB5n9O21iDVbKkjXKh9wc7C/+FA
	WN1oWw5VJFIX7EonXUDk1XlSE3HwHUkHxMe9OuEvKxvjTYVHj8esXFdtMVXfJXbW8g/R
X-Received: by 2002:a05:600c:898:b0:483:6a76:11a6 with SMTP id
 5b1f17b1804b1-4872fb4af58mr49025e9.5.1774640612616; Fri, 27 Mar 2026 12:43:32
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260325192352.437608-1-jiri@resnulli.us> <20260325192352.437608-3-jiri@resnulli.us>
In-Reply-To: <20260325192352.437608-3-jiri@resnulli.us>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 27 Mar 2026 12:43:20 -0700
X-Gm-Features: AQROBzBYesqFRGc3W9I0GrvLQe43hwnK276StdxFy-fmLYpUjceKHOTqIZ5lfxQ
Message-ID: <CABdmKX2G-RavjPxmeTH4iiawNqN8ronj5dytYxKTYRJvtDXoFg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] dma-buf: heaps: system: add system_cc_shared heap
 for explicitly shared memory
To: Jiri Pirko <jiri@resnulli.us>
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	iommu@lists.linux.dev, linux-media@vger.kernel.org, sumit.semwal@linaro.org, 
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, jstultz@google.com, 
	christian.koenig@amd.com, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	jgg@ziepe.ca, leon@kernel.org, sean.anderson@linux.dev, ptesarik@suse.com, 
	catalin.marinas@arm.com, aneesh.kumar@kernel.org, suzuki.poulose@arm.com, 
	steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com, 
	ashish.kalra@amd.com, suravee.suthikulpanit@amd.com, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 12:23=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrot=
e:
>
> From: Jiri Pirko <jiri@nvidia.com>
>
> Add a new "system_cc_shared" dma-buf heap to allow userspace to
> allocate shared (decrypted) memory for confidential computing (CoCo)
> VMs.
>
> On CoCo VMs, guest memory is private by default. The hardware uses an
> encryption bit in page table entries (C-bit on AMD SEV, "shared" bit on
> Intel TDX) to control whether a given memory access is private or
> shared. The kernel's direct map is set up as private,
> so pages returned by alloc_pages() are private in the direct map
> by default. To make this memory usable for devices that do not support
> DMA to private memory (no TDISP support), it has to be explicitly
> shared. A couple of things are needed to properly handle
> shared memory for the dma-buf use case:
>
> - set_memory_decrypted() on the direct map after allocation:
>   Besides clearing the encryption bit in the direct map PTEs, this
>   also notifies the hypervisor about the page state change. On free,
>   the inverse set_memory_encrypted() must be called before returning
>   pages to the allocator. If re-encryption fails, pages
>   are intentionally leaked to prevent shared memory from being
>   reused as private.
>
> - pgprot_decrypted() for userspace and kernel virtual mappings:
>   Any new mapping of the shared pages, be it to userspace via
>   mmap or to kernel vmalloc space via vmap, creates PTEs independent
>   of the direct map. These must also have the encryption bit cleared,
>   otherwise accesses through them would see encrypted (garbage) data.
>
> - DMA_ATTR_CC_SHARED for DMA mapping:
>   Since the pages are already shared, the DMA API needs to be
>   informed via DMA_ATTR_CC_SHARED so it can map them correctly
>   as unencrypted for device access.
>
> On non-CoCo VMs, the system_cc_shared heap is not registered
> to prevent misuse by userspace that does not understand
> the security implications of explicitly shared memory.
>
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: T.J. Mercier <tjmercier@google.com>
