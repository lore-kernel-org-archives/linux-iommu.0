Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DD728E6
	for <iommu@lists.linux.dev>; Mon,  9 Oct 2023 23:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QI47SbSl"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-533cbbd0153so8763379a12.0
        for <iommu@lists.linux.dev>; Mon, 09 Oct 2023 16:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696895348; x=1697500148; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWFBDu8ko+Lwn2b6W5QF7+wg6DRHPxWmFe2xYb2aiM0=;
        b=QI47SbSlZsQ1+UffBpIf0dXpJxIPMNV9SqBQcesVhgC5QlM5bz1hICyDEZ8QuXl8mG
         fBWxJbi90PjkkQDGM+yROaeStaimitWEYs/FVx04AnrRdexesXqRpJhhZMqapDeTCT0g
         vCtp16ZhtRUnALTZHk4Rh0PgrOaLzQMZ4mXbXuuwlY40ppXNW4UyJCHovQU+6dyPHQ4H
         WEsa4ZJIFBNg4ZeYeIWmvCyW8IKGwh9dM6D/1/l8SpSiF05I13MZh2w6ILxu2I14otNP
         EFwZFdds7aR0OrsmJp5ONaI3EMXpyUF63yl7tS6ZaIrWhhnp5+KgqUo27UUSRy/ZSTAs
         8sCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696895348; x=1697500148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWFBDu8ko+Lwn2b6W5QF7+wg6DRHPxWmFe2xYb2aiM0=;
        b=Pzp/bO8tYrZC2XydRtLdAAWFcoT5wJive3WTYZh9sRGj8eibcE8dR/O8H+S+pt58jy
         vu5xuzFbM3YfO/SOdEi8usSPGuRbksSzmr23JRsbC+dJPRBcCAer/y26hjMRzodaNaRY
         J78ekH8md+V6OY1ym+poBAK5UAEHrgfCYiT5Pj6d+Go1mk67LBmtnOCAxzCecO2Nc98f
         YUMjXOFTwX/2g2SOMqpmCxFbjxOoQ/KK9cjT7YiAODJ/f3OiYE6FKzrGGRVSRmawzpvh
         O03OfL39cvmbYK+R1mPTFnGjjNXT+YaNqUld5a0ho/+SFDaAa7duiSjSEobjC6uOxilg
         o4Jw==
X-Gm-Message-State: AOJu0Yyq6zY/cUFGLazQ1R4m5mYA6mHL3tSQxUGpjkn7w354ZZHzAs+B
	au4MJrv1kfhoVy8la3s4HwbvmqTeAX6WENd9IPGXXg==
X-Google-Smtp-Source: AGHT+IEZU4Sz3NJ/tlAQJLXA8SAjvhWPvXTbQLHBmKyfF8fk76AwoUyvKdaafL4oQUOV3CPkS9uDRtezaI9Fz4xlEyI=
X-Received: by 2002:aa7:df86:0:b0:52a:1d9c:83ff with SMTP id
 b6-20020aa7df86000000b0052a1d9c83ffmr15150271edy.1.1696895347954; Mon, 09 Oct
 2023 16:49:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ZSRFW0yDlDo8+at3@work>
In-Reply-To: <ZSRFW0yDlDo8+at3@work>
From: Justin Stitt <justinstitt@google.com>
Date: Mon, 9 Oct 2023 16:48:55 -0700
Message-ID: <CAFhGd8obPWF5469BwFAXmZ7czOB6f68gdOGqCPFL+dbs5KzDyw@mail.gmail.com>
Subject: Re: [PATCH][next] iommu/virtio: Add __counted_by for struct
 viommu_request and use struct_size()
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	virtualization@lists.linux-foundation.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 9, 2023 at 11:24=E2=80=AFAM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> Prepare for the coming implementation by GCC and Clang of the __counted_b=
y
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
>
> While there, use struct_size() helper, instead of the open-coded
> version, to calculate the size for the allocation of the whole
> flexible structure, including of course, the flexible-array member.
>
> This code was found with the help of Coccinelle, and audited and
> fixed manually.
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/iommu/virtio-iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 17dcd826f5c2..379ebe03efb6 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -85,7 +85,7 @@ struct viommu_request {
>         void                            *writeback;
>         unsigned int                    write_offset;
>         unsigned int                    len;
> -       char                            buf[];
> +       char                            buf[] __counted_by(len);
>  };
>
>  #define VIOMMU_FAULT_RESV_MASK         0xffffff00
> @@ -230,7 +230,7 @@ static int __viommu_add_req(struct viommu_dev *viommu=
, void *buf, size_t len,
>         if (write_offset <=3D 0)
>                 return -EINVAL;
>
> -       req =3D kzalloc(sizeof(*req) + len, GFP_ATOMIC);
> +       req =3D kzalloc(struct_size(req, buf, len), GFP_ATOMIC);
>         if (!req)
>                 return -ENOMEM;
>
> --
> 2.34.1
>
>

The __counted_by annotation and the usage of struct_size look right!

Reviewed-by: Justin Stitt <justinstitt@google.com>
