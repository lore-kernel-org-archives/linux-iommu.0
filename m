Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A83A4A33F5
	for <iommu@lists.linux.dev>; Fri,  5 Jun 2026 09:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780650001; cv=pass; b=pOOX7Sr4g+URuuHgzO17VYxWbdl7fjI/TIsvA+ydkpZ0hDsLncxbvNs8Ht+c1KqgkEgogmZljE526YjZnfwS9U/H1O3zUHPQaY9vg7hdZZ1IY/Bah9mzNcZT9w9d7s0E66qP5vS5fwLDaP9QUcS6tiTCellsB6e5/eu4lDy6tkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780650001; c=relaxed/simple;
	bh=+69jET3sPzTIRLxYRfEka88w0addzfcukjBS7PxpxGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PbtEMcKyvXf7iE2n+jdTQ8rFIEB4xug4dtJGjm33IxJnu0v6I61arKS47R78d5VUiBxuyBurIekLQz+GPJ/gQj1F+Nu87/55/+AWWp8faKKRpljI+qZlZhlf9K2MHtrEEvinhLnXxPbaVh0yLkdSxZABt69kumE+tiAL++2fchw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9BTBM3C; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9BTBM3C"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490ac357c55so19532125e9.1
        for <iommu@lists.linux.dev>; Fri, 05 Jun 2026 02:00:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780649999; cv=none;
        d=google.com; s=arc-20240605;
        b=RbaqzSUTi2xZxtD9NsLXIUr4rO7+l9aiFPvAui3Y/13BRyUXZJIHsMchMeI5L39FsU
         QiAcY2jIhqhY36TVv1RfG+Xr0uybTdrE6cy+xJL1wx/AyZSoqUlPJ7kg06QfFXxOP4oY
         1aoUBMgQQeEEWLU4Bt7BNPhpo4B7ixDVPoCo7kFMNEPGudDCcmw4qwV/NIO2SR1IcGPm
         lZWIcWJ3KMyAFgy+AsfyGZWoj/t3ffVTkKbCthfDZc51ls0sdPZXy1FqG0U0H8Cwwo8J
         bJPawb0+Y9hAcqcBtwY/4Sm8ljJPXzB7GbxMIaNJqADM9TisL/Tn7HNuuj2Q+W6SIKl9
         HpTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+9j4C7TDzwMV8RmNmd9sGvuEeJG/67BcTV/Vmljr8lY=;
        fh=ua4c+IT8/0ix02Qvxi2+Tb4qKFSDDxmOW46CTKJPEmM=;
        b=PUSFs6LRGnMrKuRmSV0N/ajsuQOtpqkzn/D8ccfUVWlr02z+XkH+JtAEyxZG+4FXeQ
         iAsvTQfz/pXh3Enk4XS3as0tXMwIuPqS0rO2oKJZ5BWNTVkKv1MPEulYZQeWZPiZmAoY
         GNRjUdBVXj9I0Iu35YnmL5GiuBhA63YOiDzqWzuSDGSCX7xADLYIq0gEGOlie1BBZBDp
         rsokt0ybLFBXVgKKq0E8xQK38gPMNgZSaM+8WFOYWbLZaK3nF9G/1PCuNPw/aVbgOb2M
         6g7O3DSv/gZ6UA3JMJ6omnM2P2XZoTAH3bgccIaNRrNojYvasE4gzzrovzTc5ow3kUCu
         WhAA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780649999; x=1781254799; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+9j4C7TDzwMV8RmNmd9sGvuEeJG/67BcTV/Vmljr8lY=;
        b=m9BTBM3CwhmxUXrSMmhmmT8/PMAPvYy9hGdxd3K5lnaKMiaPfgwD08L8ZixbY1++zK
         r/e075BReav2tBUPk3AB18VawEsu/VmBUUavWnr6aadbfP2UL/xFfv8NECKKLc2J0cB0
         rQIDabPWlsRXlf650JCfFhp48ikkoNlz5blH/LR/oN4kC2OerW4ay2TNwNeGV5Rteo3R
         fojV1UMw/hGgmTXyUL1/BMXf0ixq9QpduYpFxcsPxAtDHiZhTBqehLwUojbrToZw+J3C
         GAe3FP6ZGW4Wrqid5vOGPgY1w0OyVbfOlYFJK1vZIh0Lk4ZcnJZIvQobdm0xy+215dEV
         KaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780649999; x=1781254799;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9j4C7TDzwMV8RmNmd9sGvuEeJG/67BcTV/Vmljr8lY=;
        b=nfkiXRUGWR8agHZacx7yy8hNGj79RgAspNWEBOKyxTirvLwbDtjU7UHy/ywSSX6Fi4
         wvjnBQNTWr9qdiWP9DxOGTtFuuuNsohiG3xLF+ZqAs/hWY/HyZomqdxkIfTPIqYHAAQ2
         fIogDD04bXuCmVjwJES0/AQNzCG8A3NtxfOeg2mSzrkjZCeMgUpeVqwtet3fJUNATYK9
         RjQwd+hWBgCsnAp6Dxh98zt3IRH9v4sm7JpyG7/GQXMgP4QAWo+vl1o4xKXOgEkwNhns
         WR+ancYAZyM2v8AuGHtAHRot3MX4VGTTcP3umYYNZ13nX8qklHcYvBKcNZPdwv9VRgZK
         ka1A==
X-Forwarded-Encrypted: i=1; AFNElJ+OGojYcZ3wSqKW1b1DVuLUE9EV7j9r08hg49tSBTcgPuv25Yx7+wvPohqhNU1kj3iIm7zDAg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/yhgYk/X5v2HNjj5DBuN786kGyJfpetvZy+Yx2eIy/iz3zBCx
	eQVwQR46zRLIg5rfB7qtUKKIPbLsdiA+RdaXEoky6aBiOXe0ALkEGH2X1GfM/KvN6x7Rhi6dOYi
	CXvUb/4VcwECiB8wrT8EqpH15SCmarWBErqbJKoc=
X-Gm-Gg: Acq92OG2Q1qBGg0spebyK4f7VMbNYVKhIUJAp/I7fDsbUfRJw+oNYv9/8xx3+s+XT8b
	uxTxG9Ulh8XIcX228lPufwKAmj8p5liQMJwQWFbqeUgwSiQwsE9vkEiC96CgUqMsb3QlJ9YAvvo
	n9+0iTOrb6d5NOpKUFVYOxyjDdcG7ytHT0E4bfV+D6libwuj3fvOM4FaNp0SnQG8gQNrQJL45Xk
	ZdRRzTeHgUqqgr5Maqd7Vi3PznrQxwds2CxVN7260DEomBOeGDSqMUUTodSRMX7XVfRBd6Mejzj
	b5a7rpOZrdRWIUSz6Q==
X-Received: by 2002:a05:600c:83c3:b0:490:b355:9c70 with SMTP id
 5b1f17b1804b1-490c25a5970mr42347545e9.11.1780649998773; Fri, 05 Jun 2026
 01:59:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAHPEe=G-FZvEXjkE+vAXN5MHXCtsOaUoKwg2RQL6m=om+c20hQ@mail.gmail.com>
 <20260604051816.2976221-1-maoyixie.tju@gmail.com> <20260604051816.2976221-3-maoyixie.tju@gmail.com>
 <20260604160449.GA1619938@myrica>
In-Reply-To: <20260604160449.GA1619938@myrica>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Fri, 5 Jun 2026 16:59:47 +0800
X-Gm-Features: AVVi8CdK0JDSYbPv2SXFkVYgx-B7FQNtdCi4lej63CZ72gfzcG0R9dwk7SuQPw4
Message-ID: <CAHPEe=HV+wpgg3YMQcOxN5M7c+ew6MQRgY0YgW-3KgB91gn_sw@mail.gmail.com>
Subject: Re: [PATCH 2/2] iommu/virtio: Avoid using the list iterator past the
 loop in viommu_add_resv_mem()
To: Jean-Philippe Brucker <jpb@kernel.org>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Jean-Philippe,

On Fri, Jun 5, 2026 at 12:04 AM Jean-Philippe Brucker <jpb@kernel.org> wrote:
> Thank you for removing this hack, though I don't find a contract in the
> list_for_each_entry() doc, and the fix still accesses a cursor outside the
> loop. Since you mentioned C11 UB in another email, do you have more info
> on the precise operation which is undefined in the kernel (container_of
> into an invalid object or the &next->list addition)?  Just so I can avoid
> it in the future.

> Anyway, thanks for the patch. If this is just general cleanup that's fine
> too.

Thanks for the review. You're right.

There is no such contract in the docs. I overstated it. And no undefined
pointer arithmetic happens here either.

iommu_resv_region has list as its first member, so offsetof is 0. That
makes container_of(&vdev->resv_regions, struct iommu_resv_region, list)
just (char *)&vdev->resv_regions - 0, i.e. the head with a different
type. &next->list is the head again. Nothing reads next as an
iommu_resv_region, so no pointer leaves its object.

The container_of would be undefined only if list was not the first
member. Then the subtraction lands before the real object (C11 6.5.6).
That is not the case here.

So this is cleanup, not a UB fix. The typed cursor points at the head but
reads like an entry. That becomes a real bug the day someone reorders the
struct or touches another field. The new pos stays a struct list_head *,
which is just the head, so it avoids all of that. I should have said that
in the message.

If you or Joerg prefer, I can resend the series with the wording fixed.

Thanks,
Maoyi
