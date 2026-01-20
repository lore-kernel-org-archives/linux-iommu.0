Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71932451078
	for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 18:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768935280; cv=pass; b=CNxDbwWXvJEKLcIiWT4VD4FXr1n3gZHcfDjjLY7rVFQbdl3TEIcvCBqoyPTeBzRBxJ0nScgA/4SCtln58ICs7cFULSvlrliBos1aWVUvvhP7cBSGxpkot7rlxGoal7r5pvhJlObqckNmRZejHd4tgHKNVvuPfG4TAFnKl7g5FJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768935280; c=relaxed/simple;
	bh=V582aYpr/3n+HZxDU1y5caIF8xZLStfe4C1NStSYDjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CR0Tmbh2KFH/Cq0bY5z6zCWvcPhe9q+2GQdi7mMi31EWk7MVmo4P/Yf1UfAouiRsOQqyVYxxR/fagOGmm1ZzvNz/SP/+NPOkEzAROC/58aIDlOiZfNlm68Qt5P9DmT/jTa2bxso/RpB6CzkrzYQnXWLqqpRf/f0uGpZzxIGo1sA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xaavNWja; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xaavNWja"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5014b5d8551so47751cf.0
        for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 10:54:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768935276; cv=none;
        d=google.com; s=arc-20240605;
        b=BNqJ2bhTAUhOUPRFN1xRgzmUmds6GKgTtYBnWl35MMfvB6C/fRfvoUtPBpecIcbmKo
         6trKMTpFoF5+rZsL0NGOXv65Yr5IPnJ2/GzouApN8yGTehaMCVyElssyDaXag30ThrDi
         CYgyHLNsyxzr+LLFV2Y2ZH3eFGXrfeBemCE12aWBu1OmaQtr9P3wXDTAZyofj0GoafzI
         ZxsGQ/zMi/J+toZLPJydXcUxRkCqzffS8nGyGMzaFgdYGTccWvLNbvtSdq47S14C9XhR
         E0f8LQmlvYGYhzhREGRHUbcRtllvcIPiXGwKWszVziIg2tYvNoHfVwL/bdFONhp6Dofk
         glmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2BTFh3swbxk6yii2GbGWRCrQnmABbA33xQ++jpwmXME=;
        fh=h7DOAmzfz+406dSYaXRix5uw5Igx03WgjQgGaNeBpwg=;
        b=h1yn3k0bdXnisLvFM5MEOyuNo7KI9J09h5mzfLEg9vQkoRMX1T6ahVjueFoKkIFJmw
         2ACvm66+xq3nqZlnYP+sIJ8b+A5eUTJtOBzkxHaItyZNflKVidcxzjrX4cKiL8Euew5x
         leuILeRcwLiyWNsMDJM5mfUaMsfDenDCFKqbW7aQSIe9yLr+uUc1LJrITEV17c5t17Ac
         IGOu26l46k9YEP1i70prGpNSHy4MQq3EMYuDYDkWUTTQeKhaa4xOf3Gn92XMm9Zudv73
         aArmw/Ra3pj9GD+X/M6RTyX23ddBcfD9rxu8ladQlridcG7OHrCB4CNG58ky6LJPPpii
         nB6w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768935276; x=1769540076; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BTFh3swbxk6yii2GbGWRCrQnmABbA33xQ++jpwmXME=;
        b=xaavNWja3f94JtKhrZudLFdUKrgxavO/ptOaau53AJjZPM/SSyTFPFR+WO6j1iBnfs
         LoxGaV6Ci7+60abYw1g1A1AdnLqD0iXWxEZmk3K5c2DNoEXbMbsCPmzhWKPUG0eN4UVw
         PO57AmRW3TTubfzXPpPNPbqBW6SdtAu/nG0rJy1D3p17l/OHsPT/RUlizJ1RaPD+wtG8
         qOIdyC0W9TuXnc/EH0wYrKUJmXfsAFl7yDuMOV9YPkpyLYld/HJivtjvJJj3xTucb336
         7rpkHt4hN0vWuUbKYSikkfA4/XnOIvNpym7YW9f3w6aRXvDoAqQmqN1ZRr1cwnNITVc6
         +B3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768935276; x=1769540076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2BTFh3swbxk6yii2GbGWRCrQnmABbA33xQ++jpwmXME=;
        b=w89INjjiSB3OwsX7xWt0ZSnUzuwL14icloXZOTakSR8Xvuk4lduiS0nzJsgHArrGCN
         CYb8KI3bCtp/maEw0Ce5XzfwVq+jriW3DDfmW/g3zF/nFVfk4nGo9A6/RGFas4L8X/IF
         fBQ5TxQAc3mFK+mcmVEVhEldJaMNjiRlfKP0dsv3QMTYfXRHQD/YHKSjgltpcF1D+RX4
         WQVRosHczWghZrrSRTR149i3umE2W70HGC92y9o6eqX04XWVZhLn98ysCrHWl5GdW/ks
         UENAF6MBsoHvfCZbbXBgbOAI/KSk2e7PA/PklG/EVdzdSq3uosMWcjywNR2qXJnQw04g
         Nbaw==
X-Forwarded-Encrypted: i=1; AJvYcCVCEHyrAt2RJPbgDs5qPiidAphiqWSwgnE1ANixkSpqbZ/I3mnDuId81u2t3fHmz9+kHLP/qQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwmCUW2Y6854jHDdq7JH83P2D9xL34g7XEGsyAfT5mfQtC4uu1g
	p4pvIoO6ri4mhGMyhUhkfehLS3ueE35N4I4ahGw1XI3AC5FugGyCFpf/hnlXJrNrcmvOm7dna4/
	sUW/u8cH49+HeBcSKZEUMwd9UbR/LnomUZwUNcTKg
X-Gm-Gg: AY/fxX4S+xjR5xjz1TG8k0+R9A6Z1osvUgMIt7SgXHM2NdHJpzgmOpbeN6B/VY7rrdR
	bgMW+KI2VQw71YrSH+9qZkcvoLJurW3t7ps8pCLC3IsVk9DgwIn+tg99uVOVGAFCykkbMH6TJW1
	HRL1WQjMkgNdCeVAS0u5r6jcqhFO+C++GwhgokkyL8FTHrcIAkP+vtzOaa3JBLJ7hwZZ9l3khue
	Dv2/iCVStPdY+e4mQq/WQjBCssqhj3SCKJctXot33qvwsdmiJJ00vhznrTcvFzgbfn430lKWZRg
	ydb0sYNC5+4hKFpQQI0Ikk0h
X-Received: by 2002:a05:622a:89:b0:4ff:a98b:7fd3 with SMTP id
 d75a77b69052e-502e0c0e855mr1082171cf.2.1768935275528; Tue, 20 Jan 2026
 10:54:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260120061816.2132558-1-baolu.lu@linux.intel.com> <20260120061816.2132558-4-baolu.lu@linux.intel.com>
In-Reply-To: <20260120061816.2132558-4-baolu.lu@linux.intel.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Tue, 20 Jan 2026 10:54:24 -0800
X-Gm-Features: AZwV_QjgqKV8oYZr0d2F4SsF0CaOFMuX-UxeG4p1D8LUmz3xj5udvUQtTCKBJ4s
Message-ID: <CAAywjhS-e_SpPTDWx3zYvVWQBor2P79AHU4SfO-k+ipVGx6-MQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] iommu/vt-d: Fix race condition during PASID entry replacement
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Dmytro Maluka <dmaluka@chromium.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 10:20=E2=80=AFPM Lu Baolu <baolu.lu@linux.intel.com=
> wrote:
>
> The Intel VT-d PASID table entry is 512 bits (64 bytes). When replacing
> an active PASID entry (e.g., during domain replacement), the current
> implementation calculates a new entry on the stack and copies it to the
> table using a single structure assignment.
>
>         struct pasid_entry *pte, new_pte;
>
>         pte =3D intel_pasid_get_entry(dev, pasid);
>         pasid_pte_config_first_level(iommu, &new_pte, ...);
>         *pte =3D new_pte;
>
> Because the hardware may fetch the 512-bit PASID entry in multiple
> 128-bit chunks, updating the entire entry while it is active (Present
> bit set) risks a "torn" read. In this scenario, the IOMMU hardware
> could observe an inconsistent state =E2=80=94 partially new data and part=
ially
> old data =E2=80=94 leading to unpredictable behavior or spurious faults.
>
> Fix this by removing the unsafe "replace" helpers and following the
> "clear-then-update" flow, which ensures the Present bit is cleared and
> the required invalidation handshake is completed before the new
> configuration is applied.
>
> Fixes: 7543ee63e811 ("iommu/vt-d: Add pasid replace helpers")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/pasid.h  |  14 ---
>  drivers/iommu/intel/iommu.c  |  29 +++---
>  drivers/iommu/intel/nested.c |   9 +-
>  drivers/iommu/intel/pasid.c  | 184 -----------------------------------
>  4 files changed, 16 insertions(+), 220 deletions(-)
>
> diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
> index 0b303bd0b0c1..c3c8c907983e 100644
> --- a/drivers/iommu/intel/pasid.h
> +++ b/drivers/iommu/intel/pasid.h
> @@ -316,20 +316,6 @@ int intel_pasid_setup_pass_through(struct intel_iomm=
u *iommu,
>                                    struct device *dev, u32 pasid);
>  int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device *d=
ev,
>                              u32 pasid, struct dmar_domain *domain);
> -int intel_pasid_replace_first_level(struct intel_iommu *iommu,
> -                                   struct device *dev, phys_addr_t fsptp=
tr,
> -                                   u32 pasid, u16 did, u16 old_did, int =
flags);
> -int intel_pasid_replace_second_level(struct intel_iommu *iommu,
> -                                    struct dmar_domain *domain,
> -                                    struct device *dev, u16 old_did,
> -                                    u32 pasid);
> -int intel_pasid_replace_pass_through(struct intel_iommu *iommu,
> -                                    struct device *dev, u16 old_did,
> -                                    u32 pasid);
> -int intel_pasid_replace_nested(struct intel_iommu *iommu,
> -                              struct device *dev, u32 pasid,
> -                              u16 old_did, struct dmar_domain *domain);
> -
>  void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
>                                  struct device *dev, u32 pasid,
>                                  bool fault_ignore);
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index c66cc51f9e51..705828b06e32 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1252,12 +1252,10 @@ int __domain_setup_first_level(struct intel_iommu=
 *iommu, struct device *dev,
>                                ioasid_t pasid, u16 did, phys_addr_t fsptp=
tr,
>                                int flags, struct iommu_domain *old)
>  {
> -       if (!old)
> -               return intel_pasid_setup_first_level(iommu, dev, fsptptr,=
 pasid,
> -                                                    did, flags);
> -       return intel_pasid_replace_first_level(iommu, dev, fsptptr, pasid=
, did,
> -                                              iommu_domain_did(old, iomm=
u),
> -                                              flags);
> +       if (old)
> +               intel_pasid_tear_down_entry(iommu, dev, pasid, false);
> +
> +       return intel_pasid_setup_first_level(iommu, dev, fsptptr, pasid, =
did, flags);
>  }
>
>  static int domain_setup_second_level(struct intel_iommu *iommu,
> @@ -1265,23 +1263,20 @@ static int domain_setup_second_level(struct intel=
_iommu *iommu,
>                                      struct device *dev, ioasid_t pasid,
>                                      struct iommu_domain *old)
>  {
> -       if (!old)
> -               return intel_pasid_setup_second_level(iommu, domain,
> -                                                     dev, pasid);
> -       return intel_pasid_replace_second_level(iommu, domain, dev,
> -                                               iommu_domain_did(old, iom=
mu),
> -                                               pasid);
> +       if (old)
> +               intel_pasid_tear_down_entry(iommu, dev, pasid, false);
> +
> +       return intel_pasid_setup_second_level(iommu, domain, dev, pasid);
>  }
>
>  static int domain_setup_passthrough(struct intel_iommu *iommu,
>                                     struct device *dev, ioasid_t pasid,
>                                     struct iommu_domain *old)
>  {
> -       if (!old)
> -               return intel_pasid_setup_pass_through(iommu, dev, pasid);
> -       return intel_pasid_replace_pass_through(iommu, dev,
> -                                               iommu_domain_did(old, iom=
mu),
> -                                               pasid);
> +       if (old)
> +               intel_pasid_tear_down_entry(iommu, dev, pasid, false);
> +
> +       return intel_pasid_setup_pass_through(iommu, dev, pasid);
>  }
>
>  static int domain_setup_first_level(struct intel_iommu *iommu,
> diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
> index a3fb8c193ca6..e9a440e9c960 100644
> --- a/drivers/iommu/intel/nested.c
> +++ b/drivers/iommu/intel/nested.c
> @@ -136,11 +136,10 @@ static int domain_setup_nested(struct intel_iommu *=
iommu,
>                                struct device *dev, ioasid_t pasid,
>                                struct iommu_domain *old)
>  {
> -       if (!old)
> -               return intel_pasid_setup_nested(iommu, dev, pasid, domain=
);
> -       return intel_pasid_replace_nested(iommu, dev, pasid,
> -                                         iommu_domain_did(old, iommu),
> -                                         domain);
> +       if (old)
> +               intel_pasid_tear_down_entry(iommu, dev, pasid, false);
> +
> +       return intel_pasid_setup_nested(iommu, dev, pasid, domain);
>  }
>
>  static int intel_nested_set_dev_pasid(struct iommu_domain *domain,
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index eb069aefa4fa..4b880b9ad49d 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -416,50 +416,6 @@ int intel_pasid_setup_first_level(struct intel_iommu=
 *iommu, struct device *dev,
>         return 0;
>  }
>
> -int intel_pasid_replace_first_level(struct intel_iommu *iommu,
> -                                   struct device *dev, phys_addr_t fsptp=
tr,
> -                                   u32 pasid, u16 did, u16 old_did,
> -                                   int flags)
> -{
> -       struct pasid_entry *pte, new_pte;
> -
> -       if (!ecap_flts(iommu->ecap)) {
> -               pr_err("No first level translation support on %s\n",
> -                      iommu->name);
> -               return -EINVAL;
> -       }
> -
> -       if ((flags & PASID_FLAG_FL5LP) && !cap_fl5lp_support(iommu->cap))=
 {
> -               pr_err("No 5-level paging support for first-level on %s\n=
",
> -                      iommu->name);
> -               return -EINVAL;
> -       }
> -
> -       pasid_pte_config_first_level(iommu, &new_pte, fsptptr, did, flags=
);
> -
> -       spin_lock(&iommu->lock);
> -       pte =3D intel_pasid_get_entry(dev, pasid);
> -       if (!pte) {
> -               spin_unlock(&iommu->lock);
> -               return -ENODEV;
> -       }
> -
> -       if (!pasid_pte_is_present(pte)) {
> -               spin_unlock(&iommu->lock);
> -               return -EINVAL;
> -       }
> -
> -       WARN_ON(old_did !=3D pasid_get_domain_id(pte));
> -
> -       *pte =3D new_pte;
> -       spin_unlock(&iommu->lock);
> -
> -       intel_pasid_flush_present(iommu, dev, pasid, old_did, pte);
> -       intel_iommu_drain_pasid_prq(dev, pasid);
> -
> -       return 0;
> -}
> -
>  /*
>   * Set up the scalable mode pasid entry for second only translation type=
.
>   */
> @@ -526,51 +482,6 @@ int intel_pasid_setup_second_level(struct intel_iomm=
u *iommu,
>         return 0;
>  }
>
> -int intel_pasid_replace_second_level(struct intel_iommu *iommu,
> -                                    struct dmar_domain *domain,
> -                                    struct device *dev, u16 old_did,
> -                                    u32 pasid)
> -{
> -       struct pasid_entry *pte, new_pte;
> -       u16 did;
> -
> -       /*
> -        * If hardware advertises no support for second level
> -        * translation, return directly.
> -        */
> -       if (!ecap_slts(iommu->ecap)) {
> -               pr_err("No second level translation support on %s\n",
> -                      iommu->name);
> -               return -EINVAL;
> -       }
> -
> -       did =3D domain_id_iommu(domain, iommu);
> -
> -       pasid_pte_config_second_level(iommu, &new_pte, domain, did);
> -
> -       spin_lock(&iommu->lock);
> -       pte =3D intel_pasid_get_entry(dev, pasid);
> -       if (!pte) {
> -               spin_unlock(&iommu->lock);
> -               return -ENODEV;
> -       }
> -
> -       if (!pasid_pte_is_present(pte)) {
> -               spin_unlock(&iommu->lock);
> -               return -EINVAL;
> -       }
> -
> -       WARN_ON(old_did !=3D pasid_get_domain_id(pte));
> -
> -       *pte =3D new_pte;
> -       spin_unlock(&iommu->lock);
> -
> -       intel_pasid_flush_present(iommu, dev, pasid, old_did, pte);
> -       intel_iommu_drain_pasid_prq(dev, pasid);
> -
> -       return 0;
> -}
> -
>  /*
>   * Set up dirty tracking on a second only or nested translation type.
>   */
> @@ -683,38 +594,6 @@ int intel_pasid_setup_pass_through(struct intel_iomm=
u *iommu,
>         return 0;
>  }
>
> -int intel_pasid_replace_pass_through(struct intel_iommu *iommu,
> -                                    struct device *dev, u16 old_did,
> -                                    u32 pasid)
> -{
> -       struct pasid_entry *pte, new_pte;
> -       u16 did =3D FLPT_DEFAULT_DID;
> -
> -       pasid_pte_config_pass_through(iommu, &new_pte, did);
> -
> -       spin_lock(&iommu->lock);
> -       pte =3D intel_pasid_get_entry(dev, pasid);
> -       if (!pte) {
> -               spin_unlock(&iommu->lock);
> -               return -ENODEV;
> -       }
> -
> -       if (!pasid_pte_is_present(pte)) {
> -               spin_unlock(&iommu->lock);
> -               return -EINVAL;
> -       }
> -
> -       WARN_ON(old_did !=3D pasid_get_domain_id(pte));
> -
> -       *pte =3D new_pte;
> -       spin_unlock(&iommu->lock);
> -
> -       intel_pasid_flush_present(iommu, dev, pasid, old_did, pte);
> -       intel_iommu_drain_pasid_prq(dev, pasid);
> -
> -       return 0;
> -}
> -
>  /*
>   * Set the page snoop control for a pasid entry which has been set up.
>   */
> @@ -848,69 +727,6 @@ int intel_pasid_setup_nested(struct intel_iommu *iom=
mu, struct device *dev,
>         return 0;
>  }
>
> -int intel_pasid_replace_nested(struct intel_iommu *iommu,
> -                              struct device *dev, u32 pasid,
> -                              u16 old_did, struct dmar_domain *domain)
> -{
> -       struct iommu_hwpt_vtd_s1 *s1_cfg =3D &domain->s1_cfg;
> -       struct dmar_domain *s2_domain =3D domain->s2_domain;
> -       u16 did =3D domain_id_iommu(domain, iommu);
> -       struct pasid_entry *pte, new_pte;
> -
> -       /* Address width should match the address width supported by hard=
ware */
> -       switch (s1_cfg->addr_width) {
> -       case ADDR_WIDTH_4LEVEL:
> -               break;
> -       case ADDR_WIDTH_5LEVEL:
> -               if (!cap_fl5lp_support(iommu->cap)) {
> -                       dev_err_ratelimited(dev,
> -                                           "5-level paging not supported=
\n");
> -                       return -EINVAL;
> -               }
> -               break;
> -       default:
> -               dev_err_ratelimited(dev, "Invalid stage-1 address width %=
d\n",
> -                                   s1_cfg->addr_width);
> -               return -EINVAL;
> -       }
> -
> -       if ((s1_cfg->flags & IOMMU_VTD_S1_SRE) && !ecap_srs(iommu->ecap))=
 {
> -               pr_err_ratelimited("No supervisor request support on %s\n=
",
> -                                  iommu->name);
> -               return -EINVAL;
> -       }
> -
> -       if ((s1_cfg->flags & IOMMU_VTD_S1_EAFE) && !ecap_eafs(iommu->ecap=
)) {
> -               pr_err_ratelimited("No extended access flag support on %s=
\n",
> -                                  iommu->name);
> -               return -EINVAL;
> -       }
> -
> -       pasid_pte_config_nestd(iommu, &new_pte, s1_cfg, s2_domain, did);
> -
> -       spin_lock(&iommu->lock);
> -       pte =3D intel_pasid_get_entry(dev, pasid);
> -       if (!pte) {
> -               spin_unlock(&iommu->lock);
> -               return -ENODEV;
> -       }
> -
> -       if (!pasid_pte_is_present(pte)) {
> -               spin_unlock(&iommu->lock);
> -               return -EINVAL;
> -       }
> -
> -       WARN_ON(old_did !=3D pasid_get_domain_id(pte));
> -
> -       *pte =3D new_pte;
> -       spin_unlock(&iommu->lock);
> -
> -       intel_pasid_flush_present(iommu, dev, pasid, old_did, pte);
> -       intel_iommu_drain_pasid_prq(dev, pasid);
> -
> -       return 0;
> -}
> -
>  /*
>   * Interfaces to setup or teardown a pasid table to the scalable-mode
>   * context table entry:
> --
> 2.43.0
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
