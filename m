Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F967B
	for <iommu@lists.linux.dev>; Thu, 20 Oct 2022 11:33:18 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id f193so18985753pgc.0
        for <iommu@lists.linux.dev>; Thu, 20 Oct 2022 04:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tYdfoIPqY+T234/NdafPtOqHMoflIkl5egaJuABTq4w=;
        b=HtmcYdKiTzYM/L6QSAXCk8GBNXg9RCotQXIaq0FXQWN3I53f/salEcpH1a5O6lPzW1
         W7e60lHutJpOqv2sZt9QwhKetUufuFicL4eT+nnL3ygQIh08JasTRNXb2ap+escpk/m4
         RQSFlAAzIWjcyH37Ui/cSJgrs1q/eohLE3mZonCbeyALD2Z3s07LWh9S9L+QE55lFeqn
         GSFd/kaU3Qa1Lyufjz4KjraC1UIf/OcrA+I27+PzXwEb8YPL5oVuft7ZboaY/Tq5QZ5R
         b8m9tRYmn7GnX+rRE5dRurhoeNtyPK9+0KFXdegorAC8NTFtczzOEhkLxAOIADgWZbgT
         TVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tYdfoIPqY+T234/NdafPtOqHMoflIkl5egaJuABTq4w=;
        b=t+bVqg0tJBo9cFt0oDzwE6qsDjCyjRVQpzPgpdRTtPot4ZrSQ236q5/9Ml25ZyEGJa
         UPZ/5YyyrysEocsuE0c0XXOQPZouihgInOlB4miZWX49ST9nCSgCgfNpYdYr0DLlyBY7
         nct59RvIXXbwJEeSm3nePh9Z2HupUQVV56/ypss8mzjD/4UF6q+658oudljh2ByL0szG
         uf+anBCWqRmJvLRupjkv5LZzhjdyVfeCImv9IgCxt6W84zf2Rgwy6u+hMHzTd14fVJXk
         MwHA1LMhlZRct6LZ1XPsSdQ+d17jCzf4gKc/B/3oj5tPb6O/Oq/I1OD9ya/uAJ5ZvRaP
         0Eyg==
X-Gm-Message-State: ACrzQf0m54r20JSvY1qagMaPA3um29Y3u2z9ExmVsrr7yPYUdH/polrl
	AmKovJ4xjhbwrY4ey5+JjlB0JRdDg3ys/RRKlXynQw==
X-Google-Smtp-Source: AMsMyM5MIHc0qsAb61gidhpKGvqVl1pHORPz4Rzt+toUefYZ4KkBzzJf1VnnId2YIqlBwsFGypdatSc41rTgXK/D4CA=
X-Received: by 2002:a05:6a00:181c:b0:563:2c6c:2a7a with SMTP id
 y28-20020a056a00181c00b005632c6c2a7amr13553427pfa.28.1666265597933; Thu, 20
 Oct 2022 04:33:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20221018105149.820062-1-thierry.reding@gmail.com>
In-Reply-To: <20221018105149.820062-1-thierry.reding@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 20 Oct 2022 13:32:41 +0200
Message-ID: <CAPDyKFopppohLJ7ptnQxpBHzMLh2SZObarQRC0bJyTwE=nky4w@mail.gmail.com>
Subject: Re: [PATCH] iommu: Always define struct iommu_fwspec
To: Joerg Roedel <joro@8bytes.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Oct 2022 at 12:51, Thierry Reding <thierry.reding@gmail.com> wrote:
>
> From: Thierry Reding <treding@nvidia.com>
>
> In order to fully make use of the !IOMMU_API stub functions, make the
> struct iommu_fwspec always available so that users of the stubs can keep
> using the structure's internals without causing compile failures.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
> Hi Joerg,
>
> this is a rebased patch extracted from an ancient series that never
> ended up getting applied:
>
>         https://lore.kernel.org/all/20191209120005.2254786-3-thierry.reding@gmail.com/
>
> You had already acked this particular patch, so maybe you can pick this
> up. I've seen at least two discussions where this was brought up again,
> so I figured it'd be worth sending this out again because it can help
> remove a number of #ifdef blocks throughout the kernel.

Yes, this would certainly help to improve the code. To me, it looks
like the current stub functions, like dev_iommu_fwspec_get() for
example, aren't really useful without $subject patch.

Note that, I have a pending patch for mmc that would benefit from
this. To prevent me from delaying that, an easy way forward, assuming
there are no objections of course, would be to send this for 6.1-rc.

>
>  include/linux/iommu.h | 39 +++++++++++++++++++--------------------
>  1 file changed, 19 insertions(+), 20 deletions(-)
>
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index a325532aeab5..e3295c45d18f 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -173,6 +173,25 @@ enum iommu_dev_features {
>
>  #define IOMMU_PASID_INVALID    (-1U)
>
> +/**
> + * struct iommu_fwspec - per-device IOMMU instance data
> + * @ops: ops for this device's IOMMU
> + * @iommu_fwnode: firmware handle for this device's IOMMU
> + * @flags: IOMMU_FWSPEC_* flags
> + * @num_ids: number of associated device IDs
> + * @ids: IDs which this device may present to the IOMMU
> + */
> +struct iommu_fwspec {
> +       const struct iommu_ops  *ops;
> +       struct fwnode_handle    *iommu_fwnode;
> +       u32                     flags;
> +       unsigned int            num_ids;
> +       u32                     ids[];
> +};
> +
> +/* ATS is supported */
> +#define IOMMU_FWSPEC_PCI_RC_ATS                        (1 << 0)
> +
>  #ifdef CONFIG_IOMMU_API
>
>  /**
> @@ -598,25 +617,6 @@ extern struct iommu_group *generic_device_group(struct device *dev);
>  /* FSL-MC device grouping function */
>  struct iommu_group *fsl_mc_device_group(struct device *dev);
>
> -/**
> - * struct iommu_fwspec - per-device IOMMU instance data
> - * @ops: ops for this device's IOMMU
> - * @iommu_fwnode: firmware handle for this device's IOMMU
> - * @flags: IOMMU_FWSPEC_* flags
> - * @num_ids: number of associated device IDs
> - * @ids: IDs which this device may present to the IOMMU
> - */
> -struct iommu_fwspec {
> -       const struct iommu_ops  *ops;
> -       struct fwnode_handle    *iommu_fwnode;
> -       u32                     flags;
> -       unsigned int            num_ids;
> -       u32                     ids[];
> -};
> -
> -/* ATS is supported */
> -#define IOMMU_FWSPEC_PCI_RC_ATS                        (1 << 0)
> -
>  /**
>   * struct iommu_sva - handle to a device-mm bond
>   */
> @@ -680,7 +680,6 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group);
>
>  struct iommu_ops {};
>  struct iommu_group {};
> -struct iommu_fwspec {};
>  struct iommu_device {};
>  struct iommu_fault_param {};
>  struct iommu_iotlb_gather {};
> --
> 2.37.3
>

Kind regards
Uffe
