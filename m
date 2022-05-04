Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6889CC433EF
	for <iommu@archiver.kernel.org>; Wed,  4 May 2022 12:09:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 15CA783F1B;
	Wed,  4 May 2022 12:09:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y3yeULspuZCY; Wed,  4 May 2022 12:09:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DC49683F0E;
	Wed,  4 May 2022 12:09:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7493C0039;
	Wed,  4 May 2022 12:09:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57E44C0032
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 12:09:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3F27183F0E
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 12:09:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h0KcsRSqdwjk for <iommu@lists.linux-foundation.org>;
 Wed,  4 May 2022 12:09:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5158283F0A
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 12:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651666142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PaKDp0AYChF2TvU0gnmgAfapbqSSfeuarNmx4DaDCMY=;
 b=OpJxlDRGe7gBORTjFv9hPQdyx2vH92okmPJy1BCgkAYiV576fZfANrvyzDPEA0vjDy8/9d
 /ac186R+LFy1FekYGUhPGmUzw8zHZ1qSxYuPkRnq7MtXsDj6y8vU5/o1bC1ZuR4eP25ia/
 uzRhgkwTMs03OgnlipyoT/BQxSAp7Mk=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-395-DK1fPwSlNb-yxvQRpEytdQ-1; Wed, 04 May 2022 08:09:01 -0400
X-MC-Unique: DK1fPwSlNb-yxvQRpEytdQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 br16-20020a056512401000b004739cf51722so543652lfb.6
 for <iommu@lists.linux-foundation.org>; Wed, 04 May 2022 05:09:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PaKDp0AYChF2TvU0gnmgAfapbqSSfeuarNmx4DaDCMY=;
 b=IdLG5fkV7j6xLImEgbeNwqR6Spu9JLorqwyB5LgiVZpdASsF/gXAYzzVwWvuxqPwdl
 mxmTGSTwNapb8pkgmTlb08OQsjTAI76+4PuCtYGfkmrIcE3nl5iSMJ3TD/aWSW+LVrgW
 hDlTExPL364yajTWmgtsfNR2CsvtVnQEjj5A09xawEIjnEAGUX3tyi4HHZr8Y7wL+kfR
 wWFH+dZSVy4I7EZxUOlMRbny/k/wjHUxzAcyPJq6OkaGIzQcPiIzURgGuVBJo1OcfA87
 N5o8042oaUet632EayOIZUkC4t1U7kv9nUJGxhEO2r32DLEMysvU5bV3WEXvQC21jQyZ
 P8Gg==
X-Gm-Message-State: AOAM532i5HAX6GG/NU/3mykrX1U+l18m5kkWewMM4hwZ3RzOyMd2ehIz
 BwbDCvC+VWa0UETPV+PgWFlanGb96uekPePLaCsUK6Xsi49GnSb9NfTx2T4SKaI14JdztD50U5c
 ZglAFKqrr+d/S/bsMUgW1b4EGX532ZedH4dAYK0lqF+7WUQ==
X-Received: by 2002:a19:640d:0:b0:472:75e:7373 with SMTP id
 y13-20020a19640d000000b00472075e7373mr13561747lfb.46.1651666139921; 
 Wed, 04 May 2022 05:08:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwP4/TVUhuStPAtOdkhRDyMe0PvYAgIbFywWQjkb0/8vXRf7mlfrFI8l+7CxK/ewd/JXpCbla/6BaNya6gu4bQ=
X-Received: by 2002:a19:640d:0:b0:472:75e:7373 with SMTP id
 y13-20020a19640d000000b00472075e7373mr13561730lfb.46.1651666139723; Wed, 04
 May 2022 05:08:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220216025249.3459465-1-baolu.lu@linux.intel.com>
 <20220216025249.3459465-8-baolu.lu@linux.intel.com>
 <20220504075356.GA2361844@janakin.usersys.redhat.com>
 <8d6c30e0-dcf7-56f8-c44b-2d8bdb1dc04c@arm.com>
In-Reply-To: <8d6c30e0-dcf7-56f8-c44b-2d8bdb1dc04c@arm.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 4 May 2022 14:08:43 +0200
Message-ID: <CAASaF6zc=6Mxo6uq1m7OMkXGPHmqeb=92uE8uERo9ze-GLndfg@mail.gmail.com>
Subject: Re: [bug] NULL pointer deref after 3f6634d997db ("iommu: Use right
 way to retrieve iommu_ops")
To: Robin Murphy <robin.murphy@arm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Bruno Goncalves <bgoncalv@redhat.com>, David Airlie <airlied@linux.ie>,
 lkml <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Christoph Hellwig <hch@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thierry Reding <thierry.reding@gmail.com>, Ben Skeggs <bskeggs@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Daniel Vetter <daniel@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, May 4, 2022 at 1:14 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2022-05-04 08:53, Jan Stancek wrote:
> [...]
> > Hi,
> >
> > I'm getting panics after hunk above was applied in this patch
> > on ppc64le KVM guest, dev->iommu is NULL.
>
> Oof, this can probably be hit with vfio-noiommu too, and by the look of
> things, `echo auto > /sys/kernel/iommu_groups/0/type` would likely blow
> up as well. Does the patch below work for you?

Thanks for quick reply. Yes, it does.

# cat /sys/kernel/iommu_groups/0/reserved_regions
# echo auto > /sys/kernel/iommu_groups/0/type
-bash: echo: write error: Invalid argument

Tested-by: Jan Stancek <jstancek@redhat.com>

>
> Thanks,
> Robin.
>
> ----->8-----
>  From abf0a38563bb2922a849e235d33d342170b5bc90 Mon Sep 17 00:00:00 2001
> Message-Id: <abf0a38563bb2922a849e235d33d342170b5bc90.1651662442.git.robin.murphy@arm.com>
> From: Robin Murphy <robin.murphy@arm.com>
> Date: Wed, 4 May 2022 11:53:20 +0100
> Subject: [PATCH] iommu: Make sysfs robust for non-API groups
>
> Groups created by VFIO backends outside the core IOMMU API should never
> be passed directly into the API itself, however they still expose their
> standard sysfs attributes, so we can still stumble across them that way.
> Take care to consider those cases before jumping into our normal
> assumptions of a fully-initialised core API group.
>
> Fixes: 3f6634d997db ("iommu: Use right way to retrieve iommu_ops")
> Reported-by: Jan Stancek <jstancek@redhat.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/iommu.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 29906bc16371..41ea2deaee03 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -510,6 +510,13 @@ int iommu_get_group_resv_regions(struct iommu_group *group,
>         list_for_each_entry(device, &group->devices, list) {
>                 struct list_head dev_resv_regions;
>
> +               /*
> +                * Non-API groups still expose reserved_regions in sysfs,
> +                * so filter out calls that get here that way.
> +                */
> +               if (!device->dev->iommu)
> +                       break;
> +
>                 INIT_LIST_HEAD(&dev_resv_regions);
>                 iommu_get_resv_regions(device->dev, &dev_resv_regions);
>                 ret = iommu_insert_device_resv_regions(&dev_resv_regions, head);
> @@ -2977,7 +2984,7 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
>         if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
>                 return -EACCES;
>
> -       if (WARN_ON(!group))
> +       if (WARN_ON(!group) || !group->default_domain)
>                 return -EINVAL;
>
>         if (sysfs_streq(buf, "identity"))
> --
> 2.35.3.dirty
>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
