Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCACFC2C0;
	Wed, 29 Mar 2023 23:52:27 +0000 (UTC)
Received: by mail-yb1-f175.google.com with SMTP id m16so1183169ybk.0;
        Wed, 29 Mar 2023 16:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680133946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2I4mVeIsFv4NvhzxFM6DsmciloOa9w1lq9KBvKFxxY=;
        b=qIk2V6XEAzPnSsAk9n2DEpSi47I02R/uITe+YT9LFoOPfZMlt4y2WoFPmuweb0YlG7
         Jutg/CW+OJyZEGRJg9QYd3OkaMnsYZ9M/SJy+jhiUwqSeFt8SBP93StnHQQLu+sTpaAZ
         6kM7n1aJMBHSoIigsVK5+IsL3Pq2V/7+FF/IIUz23xBD8dxu09I2djaaiYJDDznnv8OD
         1QkpWs16faD1c9X8oTHUJX1O0O3IrFz4xCfUXTObgYDsAlGtkiiVgUw+hPt35vrV5xFg
         M5Xd6Sq32pdVh5tqiLSHZhPRwi2eplr/xspUYEwI7TQyyuVHCVRfMr735FfIO5hpYZVD
         Ugbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680133946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2I4mVeIsFv4NvhzxFM6DsmciloOa9w1lq9KBvKFxxY=;
        b=uLZyHDq7oVhCWzxH3XNaMi8O5M8nMibEHSjEZ4wLMB+D0VtxEXtel665HOvV2JQi75
         UprLu5k0RR2xo/UDYpPHG0XqXBqZumFp7HF7VHNLzSxe20zZ9wMovcNUfeh+u+eNmPCQ
         DT1iN/JLaUb21kPwBeDRMiXNQkU/nP+4SSOHQTqWc4kdbYAuYkkicpJuUw9NCK44X6EX
         2ALROgSO4r1b2l9pZECutv7dJHOZP+F7WrgqKWRunVOr4CQHOS8E1EjTfr7ipwXASHCw
         MxjYuMJ2Cq3LfE2gx/ILMWKaOm6IuFgwA8qDwfM4uIxDKTfZQPZjClZHZhj147XrT+mE
         FyVQ==
X-Gm-Message-State: AAQBX9dxgWdc5i+iFsxWx48qsWb/z5PlRktVUFT3WvmavnQvRlvKPiqy
	W77fdDNM34KVhnOUbAsnhcwH/ogMfNkDkjY2OQc=
X-Google-Smtp-Source: AKy350bThv4CVkT2ffM7VVUB7G8+qhQvtUnv4yQk8ZWFG5VzaK2odHPaHcWTOdvovEKVJTqRL/TtKcK/7nbwcGI1niY=
X-Received: by 2002:a05:6902:102a:b0:b4c:9333:293 with SMTP id
 x10-20020a056902102a00b00b4c93330293mr11486683ybt.11.1680133946697; Wed, 29
 Mar 2023 16:52:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com> <2-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <2-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 30 Mar 2023 01:52:15 +0200
Message-ID: <CANiq72m4sGq10s==TPTjN4L28xgHk1dYsq+o1ves7_c6pho_pw@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] iommu: Add for_each_group_device()
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, llvm@lists.linux.dev, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Tom Rix <trix@redhat.com>, 
	Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Kevin Tian <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 30, 2023 at 1:40=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> diff --git a/.clang-format b/.clang-format
> index d988e9fa9b2653..bece1995f2c159 100644
> --- a/.clang-format
> +++ b/.clang-format
> @@ -254,6 +254,7 @@ ForEachMacros:
>    - 'for_each_free_mem_range'
>    - 'for_each_free_mem_range_reverse'
>    - 'for_each_func_rsrc'
> +  - 'for_each_group_device'

We currently only go through `include/` and `tools/` to generate that
list, so this could easily get deleted on an update. But we discussed
going through more files, or we could have some extra explicit items,
etc.

Since you added it manually (i.e. vs. renaming some entries), does it
mean you are already using `clang-format` for this?

Thanks!

Cheers,
Miguel
