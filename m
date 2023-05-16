Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1E5290EA
	for <iommu@lists.linux.dev>; Tue, 16 May 2023 20:59:27 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-64a9335a8e7so8627708b3a.0
        for <iommu@lists.linux.dev>; Tue, 16 May 2023 13:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684270767; x=1686862767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SM660rXSVcN9oWH/JkR/2dCwZ/0PPpeUcJ1TWBxalsE=;
        b=qle+mMpD5mXwWmxOqRodWKMv/YfMpubGTtXVp2JF0NbGOFRBw2zJWfhe6D6GGITTi8
         7v5SLXHMup7GpcU85gunOv2mT8flrnkSru94QJE7m1KlIkE4S0MaCNFefSdExv4DQYr9
         O0PdGfKuo3yVUE0BuwIJDXWWhS915VGzAQj8npsSHOnGD7KNCdQRJbaCarXC4rmVfNsd
         NT0YJTuBegyDPWU7B9ImsVhR65V4cy7CvyZojlL7bvH7zgDk5WhVlxmVAC3wmZE9awOL
         o+exMTXltftfyIgXB8n8FTlh+zVLR9TxwJVXZcmXssRgFBjr8X/qfZWwjdyTy1bFV5/l
         oOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684270767; x=1686862767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SM660rXSVcN9oWH/JkR/2dCwZ/0PPpeUcJ1TWBxalsE=;
        b=MXmEiw3CTeNAlK6eIwY6ADRUNujnmP5sP387jngLYJUSHrr5BBCMV3g8h1R8I3fFl6
         jIShXspUrq8Yu5r8TlYkcY9B79qE4l8evnUhee9IsSrNzY1dsJvdkibWLFuG1epXAFnb
         ZNpj03PYG+PmLuQU+rHAVrNbF+5COdFE3RmMcab8ug1oBa8zo81g4LNDjGjxHrChP5N1
         LX+9zRePD8Ltj3ICmOZHmYMX0Gyc9jXYRWbyE8OqmkAjy2WcjJAr5m03mJp0Y0ySxgxH
         aV03R9kpzzKuuLa8YJ0/vIeKMbS7/77s7bmzWRxgiPeT32J9p9YmMPz3jbdEL1/wiGg0
         I3Qw==
X-Gm-Message-State: AC+VfDyhWzfc4Rree+vSsOTExZpotJB6uL8BNq1nEYlfrGzLQHguxU+R
	lWx+U1ZyWBdId1rySzqxHxaFha1bqg4i1oW8V4cHoQ==
X-Google-Smtp-Source: ACHHUZ5QkAsHl45WNADB6PJJGmiglZLzPlT8zMnVvlWVAVBBfHt0gSxR11NdcCPUNt8VdKG+KDumJRUxNyGMGXksKY0=
X-Received: by 2002:a05:6a20:3c9e:b0:104:873:c3be with SMTP id
 b30-20020a056a203c9e00b001040873c3bemr75149pzj.12.1684270766882; Tue, 16 May
 2023 13:59:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230426203256.237116-1-pandoh@google.com>
In-Reply-To: <20230426203256.237116-1-pandoh@google.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Tue, 16 May 2023 13:59:16 -0700
Message-ID: <CAMC_AXXgBoRZOaDpCex+g_YeOdPQpKD3moQ8VMsqVEm2nqSrjg@mail.gmail.com>
Subject: Re: [PATCH] iommu/amd: Fix domain flush size when syncing iotlb
To: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Nadav Amit <namit@vmware.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Sudheer Dantuluri <dantuluris@google.com>, 
	Gary Zibrat <gzibrat@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Joerg,

[Cc'ing stable@vger.kernel.org per Nadav's suggestion]

This bug fix seems to have gotten the necessary reviews (AMD and
previous commit author). Is it eligible to be applied?

Thanks,
Jon

On Wed, Apr 26, 2023 at 1:32=E2=80=AFPM Jon Pan-Doh <pandoh@google.com> wro=
te:
>
> When running on an AMD vIOMMU, we observed multiple invalidations (of
> decreasing power of 2 aligned sizes) when unmapping a single page.
>
> Domain flush takes gather bounds (end-start) as size param. However,
> gather->end is defined as the last inclusive address (start + size - 1).
> This leads to an off by 1 error.
>
> With this patch, verified that 1 invalidation occurs when unmapping a
> single page.
>
> Fixes: a270be1b3fdf ("iommu/amd: Use only natural aligned flushes in a VM=
")
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> Tested-by: Sudheer Dantuluri <dantuluris@google.com>
> Suggested-by: Gary Zibrat <gzibrat@google.com>
> ---
>  drivers/iommu/amd/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 5a505ba5467e..da45b1ab042d 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2378,7 +2378,7 @@ static void amd_iommu_iotlb_sync(struct iommu_domai=
n *domain,
>         unsigned long flags;
>
>         spin_lock_irqsave(&dom->lock, flags);
> -       domain_flush_pages(dom, gather->start, gather->end - gather->star=
t, 1);
> +       domain_flush_pages(dom, gather->start, gather->end - gather->star=
t + 1, 1);
>         amd_iommu_domain_flush_complete(dom);
>         spin_unlock_irqrestore(&dom->lock, flags);
>  }
> --
> 2.40.0.634.g4ca3ef3211-goog
>
