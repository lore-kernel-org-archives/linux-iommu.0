Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014D918E27
	for <iommu@lists.linux.dev>; Tue, 24 Oct 2023 09:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nih3iPf+"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7789577b53fso267407885a.3
        for <iommu@lists.linux.dev>; Tue, 24 Oct 2023 02:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698140920; x=1698745720; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQvE7d2b7lAwzpOL0YoL6j9XfcidTFdyaezbY3znHc0=;
        b=Nih3iPf+bTBeo4utaq5FdY4JdfSPpLfMBrai5VVI+qiWRvoiHVfuUb00FmfFM7o8zw
         scy5mTc7cY8WNLWrovYgzahpVaF9+MtqWIIsN/+SW7bxRivlqI+g/7FtMalKsqx2aEoG
         Z2fMLjKNLtA4jnv/uFTtkFh9fzWY4HWYqaOuOiFXKb9diJJirOzEERD6He5H0jWzY1Dg
         pt6oN4UYKYp/S+s7uNZSqjEdoBxsrTXzyIsvVCJZZNjQIn8l8sRXdq5RUc1s35xBkeAT
         xEVsX08y6cXv4Uw7xljknTUlAVwYlaVT9vN3KSHl2kn72DRp+M0d24+e7pcBIjrN3qNv
         Yvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698140920; x=1698745720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQvE7d2b7lAwzpOL0YoL6j9XfcidTFdyaezbY3znHc0=;
        b=ZWhvFxgEHCizF3K4V5ZTEL+NsseCqNLieBwsGJ/8cmtzF8Hpr+ZuLVUUNBDVQXFPAE
         XVKfUOpmKSO0o7nL0Nz1IiTw1efjwQhiLgJf7Te26kzVynfJEUhXgcYhB+emFk6bWg2B
         ZVGuUrUO8ftImtOx0uM4KoQzKSPX1iTWfOUwrtQYvd3gIO+M2Lwiz7JqiIk3beDh6Swe
         nIsKn2GAT2ugLRFnm+O7G36VZjAA8tnQQGsSV5LaxHOS646SzsmN5qEOVAZGkCBtjZAc
         LIs4k5mVOWuHkvaUQgXK4hrcygPWH+caPLke8ioIYoq5iZ2QuLPovD82r7IYLFiAHXoh
         JQCQ==
X-Gm-Message-State: AOJu0YwYtKRUIQ1Mtzs2341WSLE46odU9wdQIrXC6ZljvWb3oQG8JlUb
	Bg7lfCLj6kIABtZDQI9rULF2S/PB0oyG6CwTsDc=
X-Google-Smtp-Source: AGHT+IFcgRR6qHlM9QXH1zEYR+OdFHh9sebeZzt54eXkQzlMTuLkEyVljloG9krVf4oSYlpFuWdGDuXH8lGlzEsDd+U=
X-Received: by 2002:a05:620a:2a11:b0:779:e517:f425 with SMTP id
 o17-20020a05620a2a1100b00779e517f425mr3850048qkp.20.1698140919569; Tue, 24
 Oct 2023 02:48:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231023103852.28743-1-m.muzzammilashraf@gmail.com>
In-Reply-To: <20231023103852.28743-1-m.muzzammilashraf@gmail.com>
From: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Date: Tue, 24 Oct 2023 14:48:28 +0500
Message-ID: <CAJHePoZzMagaTLdRqmisgKx5arvm_YujyefzeCku1=ETPHWLVw@mail.gmail.com>
Subject: Re: [PATCH] include: uapi: linux: iommufd.h: fixed kernel-doc warnings
To: jgg@ziepe.ca, kevin.tian@intel.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

Can anyone review and approve this patch?

On Mon, Oct 23, 2023 at 3:39=E2=80=AFPM Muhammad Muzammil
<m.muzzammilashraf@gmail.com> wrote:
>
> Fixed multiple kernel-docs warnings
>
> Signed-off-by: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
> ---
>  include/uapi/linux/iommufd.h | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index 50f98f01fe10..2211f1b53d6e 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -419,7 +419,7 @@ enum iommu_hw_info_type {
>  };
>
>  /**
> - * enum iommufd_hw_info_capabilities
> + * enum iommufd_hw_capabilities
>   * @IOMMU_HW_CAP_DIRTY_TRACKING: IOMMU hardware support for dirty tracki=
ng
>   *                               If available, it means the following AP=
Is
>   *                               are supported:
> @@ -486,6 +486,7 @@ enum iommufd_hwpt_set_dirty_tracking_flags {
>   * @size: sizeof(struct iommu_hwpt_set_dirty_tracking)
>   * @flags: Combination of enum iommufd_hwpt_set_dirty_tracking_flags
>   * @hwpt_id: HW pagetable ID that represents the IOMMU domain
> + * @__reserved: Must be 0
>   *
>   * Toggle dirty tracking on an HW pagetable.
>   */
> @@ -499,12 +500,12 @@ struct iommu_hwpt_set_dirty_tracking {
>                                           IOMMUFD_CMD_HWPT_SET_DIRTY_TRAC=
KING)
>
>  /**
> - * enum iommufd_get_dirty_bitmap_flags - Flags for getting dirty bits
> - * @IOMMU_GET_DIRTY_BITMAP_NO_CLEAR: Just read the PTEs without clearing=
 any
> - *                                   dirty bits metadata. This flag can =
be
> - *                                   passed in the expectation where the=
 next
> - *                                   operation is an unmap of the same I=
OVA
> - *                                   range.
> + * enum iommufd_hwpt_get_dirty_bitmap_flags - Flags for getting dirty bi=
ts
> + * @IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR: Just read the PTEs without cle=
aring any
> + *                                        dirty bits metadata. This flag=
 can be
> + *                                        passed in the expectation wher=
e the next
> + *                                        operation is an unmap of the s=
ame IOVA
> + *                                        range.
>   *
>   */
>  enum iommufd_hwpt_get_dirty_bitmap_flags {
> @@ -521,6 +522,7 @@ enum iommufd_hwpt_get_dirty_bitmap_flags {
>   * @page_size: page size granularity of each bit in the bitmap
>   * @data: bitmap where to set the dirty bits. The bitmap bits each
>   *        represent a page_size which you deviate from an arbitrary iova=
.
> + * @__reserved: Must be 0
>   *
>   * Checking a given IOVA is dirty:
>   *
> --
> 2.27.0
>
