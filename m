Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E922C964
	for <iommu@lists.linux.dev>; Tue,  4 Apr 2023 19:55:41 +0000 (UTC)
Received: by mail-qt1-f178.google.com with SMTP id x17so11047507qtv.7
        for <iommu@lists.linux.dev>; Tue, 04 Apr 2023 12:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680638140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYNrbv9Lk89FxUMy4c2VkbVl70CzaYp+O0v2KvAFS7c=;
        b=Yekk4vn6hzjxxj5q6FFeW06kCykiirTzKbFYal1QTCBKaprVx5wI8by0rn4HHjPmbf
         1ykRPGQ0dltGc6ck4Ct0duSNi0p7rXGZh6usPEZ7vh3z8W0AkVtAvsqFVRUx+BrPqGe4
         ja0zs8VkEmwQ1LFyp915v4GfkyMnYxdwkavQ/YEU3SqzyrFoM8uQkXvJNbFJR6y5LXXx
         9f9o+7sY4y9x+eu7YAxP90QQuJ8ZxRyevFOpd4cKGhXB+9ac3vuk4WJ38IDhfuC5MRq3
         Hw6X/bDjfQqiNWBuSRWVW5atA4Hrn5edHq0hCW+AQFseyfQrA4cddfo+/p0YF9Fb6tcl
         hQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680638140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYNrbv9Lk89FxUMy4c2VkbVl70CzaYp+O0v2KvAFS7c=;
        b=NRp8bI/8nSzwY3hvPgLAHFOM6w3bOZoEnPj02o51CmZlmt7c2FWvxBpwayfRie8jzA
         GfnUSuLu5XdrBE+yhuZ7//CU0j7r7UUaL7tMOTESNY9+HuisgPMPuTroC2yziwYV08h0
         uqMCWPyPapmxFuGtYtnoiGT7ILHH0XYKVriAT3T/EUCqMBkB/Qei8YePFYudTWn98H5L
         UKHgjVblTj5PsdYlijFf29Gm8f3j7+XmZHHJSmTlUeMhkyT9sY5iIVUjTsQzbviyEli8
         ZSc/YmbQf93PCDniQGMO1tqrbjFXX97MsouysNe5BNn6QiQhwYiS+LYMyqymfiq4VZwF
         PWTA==
X-Gm-Message-State: AAQBX9eHW8MOFtbi0F5lo6PVnXVLmCSaBV10yOw7Xb948Od9OyHKHOFu
	k9Mg5h6HyEZVgLE4fnT3Noc3UR5UbaF2Ul8hjyA=
X-Google-Smtp-Source: AKy350bSAVb0Nq+E8AjjqohmUJnQqw0mM6dHJ2arHwAcU2HLFLIWv0go8i4cXlvnZUd+czjMkmh8oECk3Td54zJCig0=
X-Received: by 2002:ac8:5991:0:b0:3df:375:5102 with SMTP id
 e17-20020ac85991000000b003df03755102mr268613qte.2.1680638140121; Tue, 04 Apr
 2023 12:55:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1679382779.git.petr.tesarik.ext@huawei.com> <c90887e4d75344abe219cc5e12f7c6dab980cfce.1679382779.git.petr.tesarik.ext@huawei.com>
In-Reply-To: <c90887e4d75344abe219cc5e12f7c6dab980cfce.1679382779.git.petr.tesarik.ext@huawei.com>
From: Dexuan-Linux Cui <dexuan.linux@gmail.com>
Date: Tue, 4 Apr 2023 12:55:29 -0700
Message-ID: <CAA42JLa1y9jJ7BgQvXeUYQh-K2mDNHd2BYZ4iZUz33r5zY7oAQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] swiotlb: Fix slot alignment checks
To: Petr Tesarik <petrtesarik@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, 
	Jianxiong Gao <jxgao@google.com>, David Stevens <stevensd@chromium.org>, Joerg Roedel <jroedel@suse.de>, 
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>, 
	Roberto Sassu <roberto.sassu@huawei.com>, petr@tesarici.cz, 
	Michael Kelley <mikelley@microsoft.com>, Dexuan Cui <decui@microsoft.com>, Tianyu.Lan@microsoft.com, 
	linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 21, 2023 at 1:37=E2=80=AFAM Petr Tesarik
<petrtesarik@huaweicloud.com> wrote:
>
> From: Petr Tesarik <petr.tesarik.ext@huawei.com>
>
> Explicit alignment and page alignment are used only to calculate
> the stride, not when checking actual slot physical address.
>
> Originally, only page alignment was implemented, and that worked,
> because the whole SWIOTLB is allocated on a page boundary, so
> aligning the start index was sufficient to ensure a page-aligned
> slot.
>
> When Christoph Hellwig added support for min_align_mask, the index
> could be incremented in the search loop, potentially finding an
> unaligned slot if minimum device alignment is between IO_TLB_SIZE
> and PAGE_SIZE. The bug could go unnoticed, because the slot size
> is 2 KiB, and the most common page size is 4 KiB, so there is no
> alignment value in between.
>
> IIUC the intention has been to find a slot that conforms to all
> alignment constraints: device minimum alignment, an explicit
> alignment (given as function parameter) and optionally page
> alignment (if allocation size is >=3D PAGE_SIZE). The most
> restrictive mask can be trivially computed with logical AND. The
> rest can stay.
>
> Fixes: 1f221a0d0dbf ("swiotlb: respect min_align_mask")
> Fixes: e81e99bacc9f ("swiotlb: Support aligned swiotlb buffers")
> Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
> ---
>  kernel/dma/swiotlb.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 3856e2b524b4..5b919ef832b6 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -634,22 +634,26 @@ static int swiotlb_do_find_slots(struct device *dev=
, int area_index,
>         BUG_ON(!nslots);
>         BUG_ON(area_index >=3D mem->nareas);
>
> +       /*
> +        * For allocations of PAGE_SIZE or larger only look for page alig=
ned
> +        * allocations.
> +        */
> +       if (alloc_size >=3D PAGE_SIZE)
> +               iotlb_align_mask &=3D PAGE_MASK;
> +       iotlb_align_mask &=3D alloc_align_mask;
> +
>         /*
>          * For mappings with an alignment requirement don't bother loopin=
g to
> -        * unaligned slots once we found an aligned one.  For allocations=
 of
> -        * PAGE_SIZE or larger only look for page aligned allocations.
> +        * unaligned slots once we found an aligned one.
>          */
>         stride =3D (iotlb_align_mask >> IO_TLB_SHIFT) + 1;
> -       if (alloc_size >=3D PAGE_SIZE)
> -               stride =3D max(stride, stride << (PAGE_SHIFT - IO_TLB_SHI=
FT));
> -       stride =3D max(stride, (alloc_align_mask >> IO_TLB_SHIFT) + 1);
>
>         spin_lock_irqsave(&area->lock, flags);
>         if (unlikely(nslots > mem->area_nslabs - area->used))
>                 goto not_found;
>
>         slot_base =3D area_index * mem->area_nslabs;
> -       index =3D wrap_area_index(mem, ALIGN(area->index, stride));
> +       index =3D area->index;
>
>         for (slots_checked =3D 0; slots_checked < mem->area_nslabs; ) {
>                 slot_index =3D slot_base + index;
> --
> 2.39.2
>

Hi Petr, this patch has gone into the mainline:
0eee5ae10256 ("swiotlb: fix slot alignment checks")

Somehow it breaks Linux VMs on Hyper-V: a regular VM with
swiotlb=3Dforce or a confidential VM (which uses swiotlb) fails to boot.
If I revert this patch, everything works fine.

Cc'd Tianyu/Michael and the Hyper-V list.

Thanks,
Dexuan
