Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44516189916
	for <iommu@lists.linux.dev>; Sun,  4 May 2025 20:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746390520; cv=none; b=cWa0c+QRYFKA2YKwQ4MvxzOPQP6jUupX5dbjZygDB2BZIk0141wLanqjwyYzPeSyDME+5YIdQlbVcpaHZqlpRj0mW4Bq1DTlEkfMIxLWTglygm18TmxBiRy7qC5+EgQZ4zdz9iCXKk4bIZQGLTypnV54Ap6to1q00qiEsXy2zyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746390520; c=relaxed/simple;
	bh=p7RH8jPe5ju48EG0FmAqRqqzhn2zmzM6yRKS1IDNiQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pSTkmG+FymgJ6e2c9lU45k/Pf9zO6YMtLzfmhf0Mi7K5c+7bzYys2LozjHKeow0CzMki4PjAPAYHHlVsfYqoEW5/kaZkvQ3tWs4ZtfUUShkwnsI2NwTyadPFnIjXczKHQYXhHMGQq7NPQBmhD+jI6HDFJRjQ21boz5hua/LMnTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3E8WfHZc; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3E8WfHZc"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5f632bada3bso6421a12.1
        for <iommu@lists.linux.dev>; Sun, 04 May 2025 13:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746390517; x=1746995317; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LNxlsHkuWr26TqkPPMmOz/C4Ovd29j8T7M8QIAWC3g=;
        b=3E8WfHZcuQjiPxHuMUlEEh/z0pKuTliYSmbOk8lS68faQmmALDotoY73Ll/4LbFzvk
         g4AYPkx9ZHOnuOMfuJDny/ZSwGOJmNo1snQ3i405vXBTil/rreB6AkpYRLL1IFfNGACj
         JOMT+4+keLIS/1RRhBs1BI/Po5r9w2Rd+CJvPUKH4CPK/o9tYydMx7aAR5xzD56np/kv
         nOhuBB6YZHkObGLm1aVjVkpx4vpNx2XT/CfOwMxrjek/s5/GJI6JA1a1huwQphW7HtqR
         tpfUzn35mTtDhkKdWli3454PEKIXip0OvbSG39U7yj+IoJzzs+PSpZI03ZAktQsifTOw
         74Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746390517; x=1746995317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0LNxlsHkuWr26TqkPPMmOz/C4Ovd29j8T7M8QIAWC3g=;
        b=al0OKuNbTLhgfTG08Wxn7unuGxD0kZsSLgP3At3LZHiXki3Yrq42zxqUnsB41VSE9u
         UB7PZBmN3CFY/GAjpEfx9Bz6Ct5dGUji4btApl3FmYEJYD/rAP7KM8lVvqEBFyvsXhK6
         kL7zP2ieRAy3BJjfMLOJRCAw9EyBqJHHwXb5MJcsyRXDgRZqdPDSAKL2SpK4l57lkXFC
         W0oLSAMqtg83dBjbJT+ZBGsTom2DDcCZnZUsSEXJgKml4qWt571oxLGd3kLLaZG6RngN
         +5KQvmVwm/RRT6rEx+MCJTrDgGoQPdnmEY7u+96WQWt1bwsZjZkdm3aRXJAmChCWhNTE
         qF3w==
X-Forwarded-Encrypted: i=1; AJvYcCWwcl7Iq/GTHflkMFDMXzJPEqnqFlJmU00LFXVaX8g5JAjOMMpcRLHx30fqI9JfcY6pKq1dgg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyhvB0UPE3tZu4VBDOgA060uq1xeGPJqVMimiEvd2ixFnEwyZed
	pxlBI2y0zSEUyMJWX78Yj7h/pbghuKOti6VCiM7VVFUZf4FiLaIeczehxrOZ6qlwHs/cmC9wupy
	ZOKMoGJRCGqnMPZZ49gmWc8b+j8T3B3yJKe4S
X-Gm-Gg: ASbGncvs+vyH4ySKiUzw/ChW/divvAQ52170Af5WqdJinGMYiqfH7fKSeGFqhzIgW0K
	eFJrv7c2hOcar9OoZ7Ex4Do6aRdYebK8QNeWoNVZgNmRqhMp6DHpOYlulTZ0t3D6nWibGD+oM/I
	yPlPtRrHY7VDA1r4nKf5SHGXp2UlP+vg==
X-Google-Smtp-Source: AGHT+IGmpdA2wmWxaZxctzBfwZ9neJuZ4UBP1c26mIWnHDPJQtzYOhQii3kXYnE/TFRMkOAW9hDgb6NacJhnJLko8vo=
X-Received: by 2002:a50:935d:0:b0:5fa:ad69:6e44 with SMTP id
 4fb4d7f45d1cf-5faad696f5emr51762a12.0.1746390517408; Sun, 04 May 2025
 13:28:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250418233409.3926715-1-praan@google.com> <20250418233409.3926715-9-praan@google.com>
In-Reply-To: <20250418233409.3926715-9-praan@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Sun, 4 May 2025 13:28:26 -0700
X-Gm-Features: ATxdqUHl4yS7JePATbvPgENtvXNMBiTf7L7w4ENbvZSSOj5stm7voIW4L20zSw8
Message-ID: <CAE2F3rA5TbXBj0JDPNnu0L+qfwO6ESaieg4VRnQre4s_bRDA8A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 08/10] iommu/arm-smmu-v3: Avoid suspend when user
 owns DMA
To: Pranjal Shrivastava <praan@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, 
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 4:35=E2=80=AFPM Pranjal Shrivastava <praan@google.c=
om> wrote:
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -796,7 +796,7 @@ struct arm_smmu_device {
>         struct rb_root                  streams;
>         struct mutex                    streams_mutex;
>
> -       /* Insecure Attach handles */
> +       /* Insecure attach handles */

Move this to the original commit that introduced this comment.



>         struct list_head                insecure_attachments;
>         /* Lock for the list */
>         spinlock_t                      attach_lock;
> --
> 2.49.0.805.g082f7c87e0-goog
>
