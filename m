Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F951864
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 05:05:28 +0000 (UTC)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-40a47e8e38dso115061cf.1
        for <iommu@lists.linux.dev>; Mon, 14 Aug 2023 22:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692075928; x=1692680728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhwGPIQfuuKo3NNMbjP7kxl9NVjQk4SHNCBif9DoxSI=;
        b=Za459b0URO2IDkQkjP1F7f+tgXuFkwfyFEhSwJ9HXLHHOyI6fL5IJU0SpTtUkFEMLr
         XxfyJIj8lgzjtbryZgniTwPoe91JOIHZ7cttRlhX4FQp8+mGdy/jpvOzH/eKlEoRX1uE
         6o0Inb+WSyPTKS2nza4MsTkv7NStjZSp42FRESxz+zkLI3J6xW7vAb/pkVT23uxaWZ/i
         RGCFQggEvEniTCjcrdXpGM2m+M5YOMgApyLS2jSlTyhgbVNT9zPaEF61R7o4n3skqCMq
         7SPWgmlOnuAKqKjQoLBtP0N2SHGjxJuCbv+UlikO9R1XcR8OB7fvPs+g9iYQKDS8ThCj
         v86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692075928; x=1692680728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DhwGPIQfuuKo3NNMbjP7kxl9NVjQk4SHNCBif9DoxSI=;
        b=NCFhVB+TeZLpwusOE6g9VQhdO3A24NSblOpS5oJyKwgW7dKJb8ahB8iaCs94/9IfSq
         E5gvGcUJg9+ACbYUtutCv+7N+hCFdofPj+DJ8wRVMU0KP4Kfp/aLByeOtJGoxZIE2cYt
         +ycpRAwg8TSfDuxmKqOw6glvP/YZaLZF3Zv1u+LXKSQAo08/icGC6kdS8iaqcb5MkPwh
         OMFNTIYoaxyj0rXJ0fNIGBoGgExi+RT8gsEnqbyq1HBMMTFzWU7p94cCDCdGiTTVhPuB
         Vrn6CdhlMebaICBXSTiYUcIfy3oEMqtPt/pH14DGnCvEseZFHFERXZwGS7X9Q47bmD2L
         qzQQ==
X-Gm-Message-State: AOJu0YzGq60neKgSPBPQ74f48w/s8PdyQrTXcBAvE0MXCh2O7ZNwbWjf
	PjIhOAf2W9qwWGm/5dctaxIowWuhv6SvTWfigpPDqA==
X-Google-Smtp-Source: AGHT+IHnwvWbPv/kxcDDpMRDBg+QeL0+2NygibehL9WzHNY+3kg6opMG79eNUDV7b6rQ/6Lr44smm2jb/Y+g9aFKZ6w=
X-Received: by 2002:a05:622a:1b8c:b0:403:affb:3c03 with SMTP id
 bp12-20020a05622a1b8c00b00403affb3c03mr753428qtb.10.1692075927853; Mon, 14
 Aug 2023 22:05:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230808171446.2187795-1-mshavit@google.com> <20230809011204.v5.5.I219054a6cf538df5bb22f4ada2d9933155d6058c@changeid>
 <20230809134959.GB4226@willie-the-truck> <CAKHBV25CQYfqm80a1ztHXn3s6kj7KCuJBwJz4EZk5cog4n6R+A@mail.gmail.com>
In-Reply-To: <CAKHBV25CQYfqm80a1ztHXn3s6kj7KCuJBwJz4EZk5cog4n6R+A@mail.gmail.com>
From: Michael Shavit <mshavit@google.com>
Date: Tue, 15 Aug 2023 13:04:43 +0800
Message-ID: <CAKHBV27iMDaU3RgJSVFva0UBmyKD8oJEtzDU7PJ4LuPGWAjCCA@mail.gmail.com>
Subject: Re: [PATCH v5 5/9] iommu/arm-smmu-v3: Refactor write_ctx_desc
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, nicolinc@nvidia.com, 
	jgg@nvidia.com, jean-philippe@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2023 at 5:15=E2=80=AFPM Michael Shavit <mshavit@google.com>=
 wrote:
> On Wed, Aug 9, 2023 at 9:50=E2=80=AFPM Will Deacon <will@kernel.org> wrot=
e:
> >
> > Since you're dropping this and relying on the lock being taken higher u=
p
> > callstack, can we add a lockdep assertion that we do actually hold the
> > devices_lock, please?
>
> Will do!

I spoke too soon; the point of this change was to remove the
dependency on the arm_smmu_domain, piping the devices_lock would
defeat this. In fact, this section is really depending on the iommu
group lock not the devices_lock.
