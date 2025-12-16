Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37ADB30E84F
	for <iommu@lists.linux.dev>; Tue, 16 Dec 2025 17:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765906990; cv=pass; b=iBn0KiHYpPdKBpkWbdAoP2SIm72BjHo7O9pkd1sac4kT0R8CGfiAC6SzktmnOePhnL+JMN+BU9R96agzJnzql3N0QDWHMEFRCjDZCiJtCqx1EiAzqAsYqOpZ5G10ElCVy/jvpzUxGYRX+JFq7MH0QRi9WZaaIFrCN3AUurUgJdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765906990; c=relaxed/simple;
	bh=qdN+/T3hdnfEIEp342kUdLFY9kitbvncpOtzuXxRAYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=myZk0SQ9BTzTYwx/VSoo6oX7neTtmbzvnUBTPqTnaKHnsa4nwwTCJr90GIrwSVuS8JGInSmsf/YOzbnsuropHMXbMiqvALXiuyTcf3YZ8rZ8yr6PL7ssF3irdVxc4NUImZd6GKYGuIX7hJZwYrVjYK7EAhbVTMS870CnRMXNclA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gc7YTrEs; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gc7YTrEs"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4edb8d6e98aso8431cf.0
        for <iommu@lists.linux.dev>; Tue, 16 Dec 2025 09:43:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1765906988; cv=none;
        d=google.com; s=arc-20240605;
        b=OvWH7KqjbJJnPKHIQRMWD26vlYk9M0dPbOQ1Ado3A2+iWvthJBag3kHAoSVnyiJH8b
         Wzwe0YGax4Gs29IrkybW+eGw/fPdFfrQFRARtTkBQI51IVmQdfGb/Z+1/d4yf/aUFcI6
         1AOkQgGDEdThawmRXRo8zA9RbdGVHGz5iRe4f4kVdi/lYnmQwmt8SgjpMm5N/nOz4ULZ
         5fSZQhSgSnSY0fDdlF/Jk8gBLrVsLLQ8G991bYFW/Tz0cAMpwcnAmH5EWn21HlBwkX0T
         wna8rpLdYj+irLj7i/UIRKCsadhr7uKD8mcft0KDoHp7Iu8p4SN5uLPxsk3eTQ8PIOko
         i3mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S+M2g7NVjb+Q98XuM7RkaFG+o6mss3wU5tl++i9MeKA=;
        fh=l5/KBh23qdVYIK8l5KoUbIm7+lUvWS+24PzJegw4jIo=;
        b=h74VprS2ZyGuTAUMR6eb/LWdaoZ5q+nZ/HxAYn7dMIN1WMg35Ukzersx+9FQFXg7sf
         PWIO4F4n1MyIFSCt8tgQJQTS1Yj8FYxa3qbiCfQbcwbbL9FX6AL/oBUMBH+/Khmapy6K
         sR75ajMyDzeHEb4rg2cOLLQmPFQr41xKhg6mcLn0jxYCQGd2BW/sfQSVwyIGWAg3RWYv
         DlSOLlW8OrZ+QCheko3tpH/k+b8wlXk05TikIJUyFnynX7ZQ7/eWGI7KDmH+qsi8prKb
         M0D9Lz0H9P5pdppV1zmDF9TOOkX5fdPC/TrvqNhfYiWZMOUGJ2mIL4dhnNl9RfWflrZb
         cBWA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765906988; x=1766511788; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+M2g7NVjb+Q98XuM7RkaFG+o6mss3wU5tl++i9MeKA=;
        b=Gc7YTrEsWEt0Sn46/6+2onuV67OStd3OQ0+R88AMjRj6GX7jy1K3HcCyzhGO/d6WUd
         ggDcPqhA0/ia9ZWzGO7h/42sq9RaV5rcScKejK6AKNb6EJy4vCUMMlbEajByK2BNRTme
         rqKXe7WFLpqcLhCJ0NsIf4t3Xe/E8pKQ04tuwHFSK/ppsOiWsU3Pp1Fr3rweQVua4Vgi
         pe20WMy6dWmBotH1O58KlLp1i33YqYkjlXQzcRzYteq1pWAs5K3KHJ9+SswhqtlbA6yW
         gSiUaUYHbqfEq59FjQI2uHnF7eS4k83j24tNanBupeHvwIBpJGh+Kn1ZU1apPw56ax2g
         L40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765906988; x=1766511788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S+M2g7NVjb+Q98XuM7RkaFG+o6mss3wU5tl++i9MeKA=;
        b=VURLsYoOO03Y77/QwoZaBOWSrBS+2vafeVNKiMCufj7nHdakotmfXfuFDxnvlZq4wr
         S3CeiwuDfDdNzUL5MtC4/G0lnydmDmkDanH3TMqueRGwWBsjfAL45FNeQOs+1RBB9lDI
         TmH8NYDwM3fO7vEhqr2hqJ8B8NKPDO/aXqN/uTnTRZerZwRyhWlFgvWcTnfgpJXwlXGB
         73TK8NZ1usxhT5hJhhISPj9qaOfEP4f0BomUd6VuBnoHCBsf3Nd7JwgSeJwNz7Gk2E+j
         sWbDuisZhaSsE84vzjuODT+3YrxSdYg3KuJbILCBzUcRYMi+g2TB7GTnQL6IDX/uWZYL
         16AQ==
X-Gm-Message-State: AOJu0YxQxtHMWtfZi8rLNOO7ymTEOQqYmKkjdU+ffpUr0QmP2AKZ4XB9
	u7CiCdi4KMP3967oVlAvXRvAuuZCf0LEda7szbS97jeHhz90Lz3DIKUSv/RrmVbZ7jlAsTxFWYd
	mXj0BkLMKQwOB4E1IcZpKyTWeue7ozS2FJ7RAdWfo
X-Gm-Gg: AY/fxX4TBgfOC9HRX5WTbYJA7NBG3gLW6zhfbZAhvmGXH1TgemJBO+2q2xXyJtDPdo5
	kf0l3dKjwLgZ6Hh+Gv2KSl93VI6fQ/3xMNH6D71G1LY/13p82Vqf72FGtnwVY/21DcuKjJO99Yi
	qo1Uaenasapm45XRSUP3QBTup/ElsSKXJvMzO4ehJ79G1bllFdCoQm1Gg86KzmWWZytu54EazpK
	Yl0go6p2k116/8LUAXGE8DnH78slEJ9ZBYiSJ5pyzJvz/jHfCyLs9TDRUE0nl5Ef0NCC1uMkmpu
	lL4APhsJCUnbD0l432AE0hyIUUbvW0sDQeBgpQ==
X-Google-Smtp-Source: AGHT+IFFYwYz5lb1UiltQsx4DpnRWa8o6scoNJhIMT8mvh/fT0XuoATXijv41fsf+D8/QerFrM9u5fgbhtCFV/o9ROE=
X-Received: by 2002:ac8:5d14:0:b0:4ed:a65c:88d0 with SMTP id
 d75a77b69052e-4f34a9a6098mr8710501cf.6.1765906987654; Tue, 16 Dec 2025
 09:43:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v1-cd99f6049ba5+51-iommufd_syz_add_resv_jgg@nvidia.com>
In-Reply-To: <0-v1-cd99f6049ba5+51-iommufd_syz_add_resv_jgg@nvidia.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Tue, 16 Dec 2025 09:42:56 -0800
X-Gm-Features: AQt7F2rm5JAA7BEaV5eUIbjINlL49jAhyqMynyodmR7eSsrtt6kmKreym_HBf-k
Message-ID: <CAAywjhSXf6+b+PHCecBH7JBA-Lv6P9Jev36Bco5kwqLJsm39rw@mail.gmail.com>
Subject: Re: [PATCH] iommufd: Check for overflow in IOMMU_TEST_OP_ADD_RESERVED
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	Kevin Tian <kevin.tian@intel.com>, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Eric Auger <eric.auger@redhat.com>, 
	Matthew Rosato <mjrosato@linux.ibm.com>, patches@lists.linux.dev, 
	syzbot+57fdb0cf6a0c5d1f15a2@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 9:15=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> syzkaller found it could overflow math in the test infrastructure and
> cause a WARN_ON by corrupting the reserved interval tree. This only
> effects test kernels with CONFIG_IOMMUFD_TEST.
>
> Validate the user input length in the test ioctl.
>
> Fixes: f4b20bb34c83 ("iommufd: Add kernel support for testing iommufd")
> Reported-by: syzbot+57fdb0cf6a0c5d1f15a2@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/69368129.a70a0220.38f243.008f.GAE@goo=
gle.com
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/iommufd/selftest.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/sel=
ftest.c
> index 86446e1537949a..550ff36dec3a35 100644
> --- a/drivers/iommu/iommufd/selftest.c
> +++ b/drivers/iommu/iommufd/selftest.c
> @@ -1184,14 +1184,20 @@ static int iommufd_test_add_reserved(struct iommu=
fd_ucmd *ucmd,
>                                      unsigned int mockpt_id,
>                                      unsigned long start, size_t length)
>  {
> +       unsigned long last;
>         struct iommufd_ioas *ioas;
>         int rc;
>
> +       if (!length)
> +               return -EINVAL;
> +       if (check_add_overflow(start, length - 1, &last))
> +               return -EOVERFLOW;
> +
>         ioas =3D iommufd_get_ioas(ucmd->ictx, mockpt_id);
>         if (IS_ERR(ioas))
>                 return PTR_ERR(ioas);
>         down_write(&ioas->iopt.iova_rwsem);
> -       rc =3D iopt_reserve_iova(&ioas->iopt, start, start + length - 1, =
NULL);
> +       rc =3D iopt_reserve_iova(&ioas->iopt, start, last, NULL);
>         up_write(&ioas->iopt.iova_rwsem);
>         iommufd_put_object(ucmd->ictx, &ioas->obj);
>         return rc;
>
> base-commit: b80fab281349f107a07e841eb412a86e2877ae88
> --
> 2.43.0
>
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
