Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCF63232
	for <iommu@lists.linux.dev>; Sat, 28 Jan 2023 12:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1674908649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=03GFZKsTOOOpaDJp/S3NzI8t/p2gCtQxJMJc4T/9yBg=;
	b=MEDAkj/d07bAHG5tGDSh9Xj6srnUq5YDXKbtDenX1P13k9nQRXDiPflVeOJQSFee5rTVD6
	dPkgE53TX8aC5aBS3l3Y/GPIyc0iCAIp2acxDOwzT6MpKjinI1OdUmHo3Z+rR7AKzRQ0TV
	FDWlzuLNgKeorX/Xr83t5bOtf9TreF4=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-113-Wg0FIwAgOt2aJna24Me6dQ-1; Sat, 28 Jan 2023 07:24:08 -0500
X-MC-Unique: Wg0FIwAgOt2aJna24Me6dQ-1
Received: by mail-vk1-f199.google.com with SMTP id 16-20020a1f1610000000b003ea10940e34so279346vkw.23
        for <iommu@lists.linux.dev>; Sat, 28 Jan 2023 04:24:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=03GFZKsTOOOpaDJp/S3NzI8t/p2gCtQxJMJc4T/9yBg=;
        b=KG37t1NiEPmY+xZBvjh4p1Byk+CeCk7J1xq4sG3EhlH43XAFZjUJ7EwbDouNMmKwxX
         SQZnEid6ougPPfL4Xi4vr8oa00PnHCCHEN7Vf/Vh2l8KqbU3ATp51RiL9jwcFjhyFx5w
         k7PmVzh/GzXYLK9daoxAedxVjnReit3KkEDYPBLQ892V44It7ZhGaUz51YTmggjStTO+
         MyQkywHFeaKINiFmlLdoew6ku3MLZOrKJMw1oOg7PcFuyolIgQY7DAyI4ivTw9UcVbHd
         sCFYO05lFmtC/c+Z8ZEnVoVh/9vDxUdNMerY0F8d5w2xNWq1GiKZDQDPqNtfFHDZ8I/F
         0LRQ==
X-Gm-Message-State: AFqh2koc7WvvZYV3xvKeYMNWr1LvM/bHk1p3dWC0l2li/3ikGSSCdy2D
	lXhlSPpIzufF1lqO3lAD+/YhEvyEwuSzGtdxNeTGh+MBiZRoMJYtp2p6L49SOVGKQwpPQPq1H1g
	U9ajuRECVSnO+92YWKQzzE+wPKT2qdzE=
X-Received: by 2002:a67:ea04:0:b0:3d3:ec78:1d72 with SMTP id g4-20020a67ea04000000b003d3ec781d72mr6956101vso.13.1674908647620;
        Sat, 28 Jan 2023 04:24:07 -0800 (PST)
X-Google-Smtp-Source: AMrXdXujUr3nmTvR4IYft+VhWLaB9CaLr0rUquJiWtbPKQVgUOJtr2ccTZPeu3VmmCd7OwP4b9ukbqxY7/EVlW27Z14=
X-Received: by 2002:a67:ea04:0:b0:3d3:ec78:1d72 with SMTP id
 g4-20020a67ea04000000b003d3ec781d72mr6956096vso.13.1674908647381; Sat, 28 Jan
 2023 04:24:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230128113532.94651-1-sven@svenpeter.dev>
In-Reply-To: <20230128113532.94651-1-sven@svenpeter.dev>
From: Eric Curtin <ecurtin@redhat.com>
Date: Sat, 28 Jan 2023 12:23:51 +0000
Message-ID: <CAOgh=Fw5FXPKde9PtTRRVeJ9eos8wqt72F_TLe_2XjWpKmCZ-A@mail.gmail.com>
Subject: Re: [PATCH] iommu/dart: Fix apple_dart_device_group for PCI groups
To: Sven Peter <sven@svenpeter.dev>
Cc: Hector Martin <marcan@marcan.st>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Robin Murphy <robin.murphy@arm.com>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 28 Jan 2023 at 11:43, Sven Peter <sven@svenpeter.dev> wrote:
>
> pci_device_group() can return an already existing IOMMU group if the PCI
> device's pagetables have to be shared with another one due to bus
> toplogy, isolation features and/or DMA alias quirks.
> apple_dart_device_group() however assumes that the group has just been
> created and overwrites its iommudata which will eventually lead to
> apple_dart_release_group leaving stale entries in sid2group.
> Fix that by merging the iommudata if the returned group already exists.
>
> Fixes: f0b636804c7c ("iommu/dart: Clear sid2group entry when a group is freed")
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---

Reviewed-by: Eric Curtin <ecurtin@redhat.com>

Is mise le meas/Regards,

Eric Curtin

>  drivers/iommu/apple-dart.c | 51 ++++++++++++++++++++++++++++++++------
>  1 file changed, 44 insertions(+), 7 deletions(-)
>
> This won't apply cleanly to iommu/fixes as it's based on the t8110 DART
> changes since the USB4/Thunderbolt DART itself also depends on those.
> That's not a big deal though since it's not possible to run into this
> bug without complex PCI bus topologies which can only be created using
> USB4/Thunderbolt on these SoCs and there's no support for that upstream
> yet.
>
> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
> index a1304ba3639b..02f7a1740b14 100644
> --- a/drivers/iommu/apple-dart.c
> +++ b/drivers/iommu/apple-dart.c
> @@ -840,6 +840,29 @@ static void apple_dart_release_group(void *iommu_data)
>         mutex_unlock(&apple_dart_groups_lock);
>  }
>
> +static int apple_dart_merge_master_cfg(struct apple_dart_master_cfg *dst,
> +                                      struct apple_dart_master_cfg *src)
> +{
> +       /*
> +        * We know that this function is only called for groups returned from
> +        * pci_device_group and that all Apple Silicon platforms never spread
> +        * PCIe devices from the same bus across multiple DARTs such that we can
> +        * just assume that both src and dst only have the same single DART.
> +        */
> +       if (src->stream_maps[1].dart)
> +               return -EINVAL;
> +       if (dst->stream_maps[1].dart)
> +               return -EINVAL;
> +       if (src->stream_maps[0].dart != dst->stream_maps[0].dart)
> +               return -EINVAL;
> +
> +       bitmap_or(dst->stream_maps[0].sidmap,
> +                 dst->stream_maps[0].sidmap,
> +                 src->stream_maps[0].sidmap,
> +                 dst->stream_maps[0].dart->num_streams);
> +       return 0;
> +}
> +
>  static struct iommu_group *apple_dart_device_group(struct device *dev)
>  {
>         int i, sid;
> @@ -881,14 +904,28 @@ static struct iommu_group *apple_dart_device_group(struct device *dev)
>         if (!group)
>                 goto out;
>
> -       group_master_cfg = kmemdup(cfg, sizeof(*group_master_cfg), GFP_KERNEL);
> -       if (!group_master_cfg) {
> -               iommu_group_put(group);
> -               goto out;
> -       }
> +       group_master_cfg = iommu_group_get_iommudata(group);
> +       if (group_master_cfg) {
> +               int ret;
>
> -       iommu_group_set_iommudata(group, group_master_cfg,
> -               apple_dart_release_group);
> +               ret = apple_dart_merge_master_cfg(group_master_cfg, cfg);
> +               if (ret) {
> +                       dev_err(dev, "Failed to merge DART IOMMU grups.\n");
> +                       iommu_group_put(group);
> +                       res = ERR_PTR(ret);
> +                       goto out;
> +               }
> +       } else {
> +               group_master_cfg = kmemdup(cfg, sizeof(*group_master_cfg),
> +                                          GFP_KERNEL);
> +               if (!group_master_cfg) {
> +                       iommu_group_put(group);
> +                       goto out;
> +               }
> +
> +               iommu_group_set_iommudata(group, group_master_cfg,
> +                       apple_dart_release_group);
> +       }
>
>         for_each_stream_map(i, cfg, stream_map)
>                 for_each_set_bit(sid, stream_map->sidmap, stream_map->dart->num_streams)
> --
> 2.25.1
>
>

