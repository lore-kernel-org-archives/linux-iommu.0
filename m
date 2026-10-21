Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792604337;
	b=eTw2PDAUDD4k4QofMGgF4fYfBdCcC2P8APi7NtXyivaSu3keJOJug0vhT29bHMmnIemO
	 fsXYbWyez9u58deC6ZbXgecTbfFizhMd8umDVUyMic8CcmV3/YBI1+zpFsfNr9ZSLdmEE
	 nalFBhVxUnuLigOJrZf7YtGAaFULkP+yg6g7PJRbRQVdDUFWM/gkXvqGdoTciJXOjRkaM
	 gDw4eSoMvPKC1CAgXb8xw9M8ityXAKJD2aK+Sm9hR51s7Fch5AirIczK7hFEZ3OU/OtmR
	 tIhvJTHPM3qrta5Jz1yNUVyse3ZH/xYHItHRD8FYpWSiA9UYv7CE+xrmAW5kVpCZ21Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792604337;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=csULT7PmXNkTg9HaShgHK/UOyRj2pqW39WBnWQcueFE=;
	b=H5d9B4zLuovvugZy0tr7/x39ez/zYVUj2YMC6eKb/4aM9vXfT5LviCW3SNsnohYZ52j9
	 IBH4cmdKEYNMl3gafRTSfknrkZWVAWG1oKMIPsBDz+Aw4tFx5Zuud121P0y2TGXOZ64uQ
	 wZI5fI138uxUpDprgJH/LWLH62l/X28g/L9WPWMIPuEj5/NPtFspe9ztBetdqZY6FkkKQ
	 bm87O+APQrIxB3p9k4j9vspIYVmO79tzZbE2RGiOSRESZztt9fMEq6R852I8F0uZxc+Rf
	 MO6Ke5g1Isc8a2rjqz5AiuoKgfmAEN+Syhq5T5qc82G7EBQ2fkLa/YoQ2iOy1Pm9Upg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b="R/wfDvdV";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.179
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A723606A319
	for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 17:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A723606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=R/wfDvdV
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3ab3dd9681fso9692931fa.1
        for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 10:38:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792604334; cv=none;
        d=google.com; s=arc-20260327;
        b=kM/4y3LfOeODdSN3OQ4BAQNRMdNYOcsf/da8Xv/SvbN3Des4HLVDl1AiCZNWDeFf0q
         ivYDaLQfUkOE/9LPa3PPfEXCJlycIztJxoo/8VkvJK+M9YyGtULnY5+2X/k3UoeQJR5K
         y6dIRAfEEVKDPJRgOrYOosv8ykQwIHSaJKvWPEWNnMyn3D8v7G301O/mT4GBECklHLPS
         fhFicr7qlTtQxTt57X2JRX93vQE1Z4iCwmYbqQdlAkj6ZZkdjPTEdAvRBDxrIJdSJdc6
         F3PYn2to1IjSbRghB0pk33UDYBESQd5Kds39nRHXU4Al5+EhFmIQrbdnV8oAfZ7j026Z
         rmwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=csULT7PmXNkTg9HaShgHK/UOyRj2pqW39WBnWQcueFE=;
        fh=j8smfqQ2zrXL32awyC6tEz5dxLRKLQS+VjZHeATGQ/8=;
        b=Kbs7GBRargPd73Vasa7yd7suVsIK4eWLhPkOQZQ5tEk5f/q57r80ZtX61mxIYJPYYc
         qT9o3kKikrr/a8p2xJumTplFBDVYz6SuwtJq4sSAkpRe4TzkSBq04FW2eL8Aa2RWniYn
         bICAdW6GMaiaEtASG2A8MHyBDDjNBu/kzp+w70q+kV9XaA5qKOqk/E/CahkQmNRckbEU
         5WH89ex9CM9ANbteGwt2/Cb8qQhDuSyn/pn6qAhxDweph3Mxygzh1m0JsNHIBdDv7T67
         9A24K+epogmnU1bpDeGWiABMJwkJ47UJx+N8Z9sKdXsg4hfMxv9X2dAAiBxRCEnty98a
         UF6Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792604334; x=1793209134; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=csULT7PmXNkTg9HaShgHK/UOyRj2pqW39WBnWQcueFE=;
        b=R/wfDvdVrvYoxRq/P0hL7dIWM53cGYo2XM5VWIuNyxBHA/4uki1P3pUaRl76FNNfod
         2mIEWmjmu8wC0gnNoI885fYYFsjJiefti/EROuTof03fdrWI89gdxH7RfcwVOVqCzxmd
         YVNG5rErKF6ruwuGHNxS1f+12rXnmyR7VQ8lzVaexft4ELXULUVIRSqVWD03Kw+ZlLQX
         hPDWiFUlu49jzUHOPMTRh+6dvnVMnGt2z7T9foSOQPTxTWoxv/GvInZl7uMYyW7Jkok5
         NKgehHsNocX33z/s6dqGORYEZbVrGRSc8lhB+mC1kEAtGnpfg+aG+beE3xhjcj83s6xK
         cohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792604334; x=1793209134;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=csULT7PmXNkTg9HaShgHK/UOyRj2pqW39WBnWQcueFE=;
        b=ifDdteVDeJ4Gf3bsNBCYN2YlZZ+KueKDBx2kWfxbjfLaAfooLiZlSD1BAddqxD0CFg
         uQRxQGN07gZzueOyVofU8LFCGPPQPqBCT/5U1AvbQovZ8hC9TicvkRNZ51HUBOccbW/j
         g6j830DQa7t8viutNnB3DGpKmiM5fLzLAft0aQOrj6JdzXWmCkR0QRNBDLNfLIdfu/FV
         I//mwWTAVT1zH7MgMQXqgrQ3JO5h6q2pEJQWYaQm2tsysIF8OGmdeKnkodKP37altyoU
         BmWRInmoEBrOZ6ui93YCPbBdYBqWYrP31kWYkBA1eFPSs3vMIjinL2Pu7f0wguJTwkDo
         fdHQ==
X-Forwarded-Encrypted: i=1; AKwUvBxakbeSI70Fri33R2jhTxMwFqtCcsRCy7kLq4ffnWxwfFk8GxNGv1T5/0CbA/Tsu2A0MhPd+Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYIHEAl+kXcxmJHSES5tY094BKocIwuXErTi+2MlTzrhCSSwKfQj
	BPa7NP85Jwu8ub3og6CE+Gh7c/sophfMu65bp7y16TsjDo7LlGJBJ19b72F5f6SsiUEYWU9ZyZc
	oGHBRP6n2yRL328Vpg+BxELx0Lv4uqroLsYxN+f5dPA==
X-Gm-Gg: AYBFou3n4hMDhTtH1KCLK2ybLNnPyMxPYOrEjLFzU1Vws2u1SF1W9VVW7b5/j3EqVBS
	8hNn+GsetbnH7kqlTTJFzEKdtvEuOTD9II1Ponizz8YGFhxDJvL5qPxnOLrigCjJl/HQP3rV+3K
	0Tum1hBxFsTFlt29ch7CfN6fL8U9/HCDOu1Ve4nLkXRWG2rdtVNYkNKyNqj5OxydRav1rXD/yoU
	osy5EtYpu8lte/4RmeNQjHVJQFlAud00MGxbmFbBP2EghxFSshpqv14b/1xpfGZ69gL2qAU2HjH
	V4mHgqEHPbZOoyXd2roX/VznbNtZqT8hbsSdyHrGW/SLTPhFB+wHHOPtw3NXZQDlTlIGe9+8il8
	95DtxE4gR07+Q5XCcu04C4pxvvx/D021ZwsSD8akxivFWT174aqYtD3wX8PJf1SAe2NI=
X-Received: by 2002:a05:651c:4210:b0:3ab:473f:4340 with SMTP id
 38308e7fff4ca-3ac44229527mr7899791fa.25.1792604334224; Wed, 21 Oct 2026
 10:38:54 -0700 (PDT)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com> <20261021152527.375070-5-tarunsahu@google.com>
In-Reply-To: <20261021152527.375070-5-tarunsahu@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Oct 2026 13:38:17 -0400
X-Gm-Features: AclHuK9EmTvcDrSPqjt_gHIG_UhFcRBGzP6kEtdhbGsx9XevNkAWoOmg1utImw8
Message-ID: <CA+CK2bCWo7ixrNLKPvqETn3JSFwSNaB2UsPgy9RHVAhWroJURQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/4] mm: memfd_luo: Add the 2-bit pair feature header
To: Tarun Sahu <tarunsahu@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, 
	David Matlack <dmatlack@google.com>, jgg@nvidia.com, robin.murphy@arm.com, 
	loganodell@google.com, oupton@kernel.org, kevin.tian@intel.com, 
	alex@shazbot.org, dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, 
	will@kernel.org, Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org, 
	linux-arch@vger.kernel.org, sagis@google.com, linux-mm@kvack.org, 
	kvmarm@lists.linux.dev, iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	kexec@lists.infradead.org, skhawaja@google.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 11:25=E2=80=AFAM Tarun Sahu <tarunsahu@google.com> =
wrote:
>
> Embed the fixed-size 128-byte struct luo_feature_hdr at the start of
> struct memfd_luo_ser and define enum memfd_luo_feature
> (MEMFD_LUO_FEAT_CORE and MEMFD_LUO_FEAT_MAX) for memfd preservation.
>
> All current struct memfd_luo_ser fields (pos, size, seals, flags,
> nr_folios, folios) and MEMFD_LUO_ALL_SEALS belong to
> MEMFD_LUO_FEAT_CORE (LUO_FEAT_REQUIRED in memfd_luo_features). Future
> changes add new entries to enum memfd_luo_feature before
> MEMFD_LUO_FEAT_MAX and append any new fields to the end of struct
> memfd_luo_ser so existing field offsets never shift.
>
> Signed-off-by: Logan Odell <loganodell@google.com>
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
> ---
>  include/linux/kho/abi/memfd.h | 35 ++++++++++++++++++++++++++++++-----
>  mm/memfd_luo.c                | 14 ++++++++++++++
>  2 files changed, 44 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/kho/abi/memfd.h b/include/linux/kho/abi/memfd.=
h
> index 371ffd108a79..f0b5235a408d 100644
> --- a/include/linux/kho/abi/memfd.h
> +++ b/include/linux/kho/abi/memfd.h
> @@ -13,6 +13,7 @@
>
>  #include <linux/types.h>
>  #include <linux/kho/abi/kexec_handover.h>
> +#include <linux/kho/abi/luo.h>
>
>  /**
>   * DOC: memfd Live Update ABI
> @@ -21,11 +22,20 @@
>   * reboot using the LUO.
>   *
>   * The state is serialized into a packed structure `struct memfd_luo_ser=
`
> - * which is handed over to the next kernel via the KHO mechanism.
> + * which is handed over to the target kernel via the KHO mechanism.
>   *
> - * This interface is a contract. Any modification to the structure layou=
t
> - * constitutes a breaking change. Such changes require incrementing the
> - * version number in the MEMFD_LUO_FH_COMPATIBLE string.
> + * This interface is a contract. `struct memfd_luo_ser` starts with a fi=
xed
> + * 128-byte `struct luo_feature_hdr`. The relative order and offsets of
> + * fields must remain unchanged as features are added or retired: new fi=
elds
> + * are appended at the end of `struct memfd_luo_ser` under a new feature
> + * flag in `enum memfd_luo_feature` (before `MEMFD_LUO_FEAT_MAX`), and
> + * retired fields are kept in place so subsequent offsets never shift. I=
n
> + * the target kernel, fields of a `LUO_FEAT_REQUIRED` feature are guaran=
teed
> + * present once `luo_feature_hdr_validate()` succeeds, whereas fields of=
 a
> + * `LUO_FEAT_OPTIONAL` feature should be accessed only after checking
> + * `luo_feature_is_active()`. All current fields (`pos`, `size`, `seals`=
,
> + * `flags`, `nr_folios`, `folios`) and `MEMFD_LUO_ALL_SEALS` belong to
> + * `MEMFD_LUO_FEAT_CORE` (`LUO_FEAT_REQUIRED` in `memfd_luo_features`).
>   */
>
>  /**
> @@ -58,7 +68,7 @@ struct memfd_luo_folio_ser {
>
>  /*
>   * The set of seals this version supports preserving. If support for any=
 new
> - * seals is needed, add it here and bump version.
> + * seals is needed, gate them behind a new feature flag.
>   */
>  #define MEMFD_LUO_ALL_SEALS (F_SEAL_SEAL | \
>                              F_SEAL_SHRINK | \
> @@ -67,8 +77,22 @@ struct memfd_luo_folio_ser {
>                              F_SEAL_FUTURE_WRITE | \
>                              F_SEAL_EXEC)
>
> +/**
> + * enum memfd_luo_feature - Feature indices for &struct memfd_luo_ser.
> + * @MEMFD_LUO_FEAT_CORE: Core feature covering `pos`, `size`, `seals`, `=
flags`,
> + *                       `nr_folios`, `folios`, and %MEMFD_LUO_ALL_SEALS=
.
> + * @MEMFD_LUO_FEAT_MAX:  Number of defined &enum memfd_luo_feature featu=
res.
> + */
> +enum memfd_luo_feature {
> +       MEMFD_LUO_FEAT_CORE =3D 0,
> +       MEMFD_LUO_FEAT_MAX,
> +};
> +
> +static_assert((int)MEMFD_LUO_FEAT_MAX <=3D LUO_FEAT_MAX);
> +
>  /**
>   * struct memfd_luo_ser - Main serialization structure for a memfd.
> + * @features:  ABI feature and size header for memfd_luo_ser.
>   * @pos:       The file's current position (f_pos).
>   * @size:      The total size of the file in bytes (i_size).
>   * @seals:     The seals present on the memfd. The seals are uABI so it =
is safe
> @@ -79,6 +103,7 @@ struct memfd_luo_folio_ser {
>   *             struct memfd_luo_folio_ser.
>   */
>  struct memfd_luo_ser {
> +       struct luo_feature_hdr features;

I have not looked into this yet, but I would prefer to use some kind
of macro constructor for serialized structs. That way, they will
automatically include the header, making it easier to search the code
for what is actually preserved versus what exists only in this kernel.

So, I think something like this:
/* Base serialization header: 4 bytes total size, 4 bytes flags */
struct luo_ser_hdr {
    __u32 total_size;
    __u32 flags;
};

#define LUO_SER_INIT_HDR(obj, _flags) do {           \
    (obj)->hdr.total_size =3D sizeof(*(obj));          \
    (obj)->hdr.flags =3D (_flags);                     \
} while (0)

#define DECLARE_LUO_SER(name, expected_size, members)       \
    struct name {                                           \
        struct luo_ser_hdr hdr;                             \
        members                                             \
    };                                                      \
    static_assert(sizeof(struct name) =3D=3D (expected_size),   \
                  "LUO struct " #name " size mismatch!")

Usage:
/*
 * Header:  8 bytes (hdr: 4 bytes total_size + 4 bytes flags)
 * Payload: 8 (pos) + 8 (size) + 4 (seals) + 4 (_pad) =3D 24 bytes
 * Total:   32 bytes
 */
DECLARE_LUO_SER(memfd_luo_ser, 32,
    __u64 pos;
    __u64 size;
    __u32 seals;
    __u32 _pad;
);

struct memfd_luo_ser *ser;
...
LUO_SER_INIT_HDR(ser, 0);

Thanks,
Pasha

>         u64 pos;
>         u64 size;
>         u32 seals;
> diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
> index 64f8b8cb75bd..ea1f4c8cd259 100644
> --- a/mm/memfd_luo.c
> +++ b/mm/memfd_luo.c
> @@ -84,6 +84,10 @@
>
>  #include "internal.h"
>
> +static const u8 memfd_luo_features[MEMFD_LUO_FEAT_MAX] =3D {
> +       [MEMFD_LUO_FEAT_CORE] =3D LUO_FEAT_REQUIRED,
> +};
> +
>  static int memfd_luo_preserve_folios(struct file *file,
>                                      struct kho_vmalloc *kho_vmalloc,
>                                      struct memfd_luo_folio_ser **out_fol=
ios_ser,
> @@ -284,6 +288,8 @@ static int memfd_luo_preserve(struct liveupdate_file_=
op_args *args)
>                 goto err_free_ser;
>         }
>
> +       luo_feature_hdr_init(&ser->features, sizeof(*ser),
> +                            memfd_luo_features);
>         ser->pos =3D args->file->f_pos;
>         inode_size =3D i_size_read(inode);
>
> @@ -525,6 +531,14 @@ static int memfd_luo_retrieve(struct liveupdate_file=
_op_args *args)
>         if (!ser)
>                 return -EINVAL;
>
> +       err =3D luo_feature_hdr_validate(&ser->features, memfd_luo_featur=
es);
> +       if (err) {
> +               pr_err("memfd_luo_ser feature header validation failed (s=
ize=3D%llu, flags[0]=3D%#llx): %pe\n",
> +                      ser->features.size, ser->features.flags[0],
> +                      ERR_PTR(err));
> +               goto free_ser;
> +       }
> +
>         /* Make sure the file only has seals supported by this version. *=
/
>         if (ser->seals & ~MEMFD_LUO_ALL_SEALS) {
>                 err =3D -EOPNOTSUPP;
> --
> 2.56.0.212.g129ede20d9-goog
>
