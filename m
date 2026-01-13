Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BF634EEFC
	for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 19:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768332465; cv=pass; b=ntlGzB3huqh4e/LRfy9zk1QXxlZdHi9pFOFNaKUp11MTKviNCuI3ykNwVDB01R90WmYXn15Vi8VuRvNCICjjnK0uLbvmA267tbgnULnM5JuPa6wIR/EcIHNGLLQLPVgsMJDtz8xt5GqvxWiOCW8Pc6cTQMmvoxwLKPAtnSNLRcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768332465; c=relaxed/simple;
	bh=DRsD+O/Q90/DG7BNxa1cphbFxBXy2V4XhRj5OOFzD8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uj6hOsrtTrPEieS08iE8R1W2HZ6wh4iCjrsXGTg3X/b+aF23cxTeR303PdJp9iSBGG3TD1ds2MtAYraaMe6BAjr/fRNa4MGwiqGGB0yJOIL5AvmgmHu3dkPYn6vZDcuttjhtX09n3Q9diCoQQz1jPuLIUCgGNRlIJZBAljZtAiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DbvvoFF5; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DbvvoFF5"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-11a247de834so1297c88.0
        for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 11:27:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768332463; cv=none;
        d=google.com; s=arc-20240605;
        b=TkDY+5KVZQNIyRmJWSgYClH2G9cO0f3f0g4w1VJbpOhdaC7AtWSlmFEvLo82qUGlTw
         71HhhBHyUi+5WJDZuAq54uhgfvN1GlpUDL7dI3vClBPiSdDgJWDijyClUMgOiFCJ7Fue
         CxVzyw5AKPWe+ARRnQvVJcMEMRaC0cRiuwWBSmYtQeAXzDM2Im2uwQARRwr14y/UplOl
         lEe7OygJJGitGZEACq9E4eBvXTQEjFinJZQrtfCuokseqVS0DL9YKRO8dXbkSa1mB2OW
         lVd9g/V8szYLvcrFhHQ16paLVZwnJREm3qE7cikp5RJzhaT5+tbX8RjIsgDckIy423Ws
         boEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=493EN+fYZC3l32j+GUSt7UmH+I1OsH8A7/4AZCa3vq0=;
        fh=pQf5dIqv+lPrhWNnmsBKsIc0SGCu2yckX/Qxnfrv1UQ=;
        b=VK4YjnZH+EoyFqSiszIr5b+gTElitacGTMItH3wAPL3riuTwdIl+sAvy92+1+uKm3j
         PvWmsgFTTdOg5Dm8sj+3N9hIPeiPboJyQijOJdtrMTsCPIS/9KBHWasDRUvSTeT5rBD7
         fYCykT/uoNEcGMmoxN6bLJg0jbFV6i/p4lOXd8wve3stJqH8yVsILx2K2I7otYnb92Ip
         JgHCG1+5WUhBiuKkv8UHee0u9mBLV5Nh5PBdN1tnGz24+ZgjsKnIpkgwFZK7Q8+KwE6I
         qSi2IdHzI+zzmBALDfvHCpqyTb7dEnVRRgCZ7J+wZ6DYF128b/6GhqRs6hR1MOISUVD6
         gTdA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768332463; x=1768937263; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=493EN+fYZC3l32j+GUSt7UmH+I1OsH8A7/4AZCa3vq0=;
        b=DbvvoFF5sP86lhtM6wSJLcAkrK035UdzLU6+A8ILiE1MpAQCUy8hEffrsolfcTVpkX
         8KL5fIG3f6N7ADnZQ0yLMsgQn82AyrOzgSMahDCd+QTcfOP65wxhIUcmMESzlrtWiBkU
         o4qIx4+H8NBM8Pa+OPEgZcMx1/Vq07/BpAnm+oEG39cDhzQKEYVinCGD6REw+FmI/WRn
         rkov3DQIquIyA8VuC6N6m5B6lpzgPTbMuo4GAAPQ6Sm50FdZmD9Wqb5eSst/IVztT6LI
         1XG37joroWvUM6tkScdOs7F0J2YAQQbfoamgCaPHfIws92ijgP4fe8Dcjefo1K574p45
         rZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768332463; x=1768937263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=493EN+fYZC3l32j+GUSt7UmH+I1OsH8A7/4AZCa3vq0=;
        b=dk6wlOH5hxLJBUTzxCLsgVsiFZvSWy+5TTtDXm4Gpen06eNomxx8BVVTLrlk+3TSeA
         NukDcFo6dnbwaCUQMjfIRjKthLhkkc7a1t0d1dVSI/qWnGb5oBpJ/4RghzSSp4NB6yiq
         nH0BI5rcQnpPwMNe9tbu+JNsq4SnuFgzNtV6n0cE0n0YVyfylLXQsJrJQ/gtWS66LD++
         smL3Ded+UMGqv7AFGpQwES9DzQj/KgZMfV26yo7yN4hdIGINq6JDWPxr+NsUUvpXl+NL
         rhn6u7YOQkKGotdQK+9PA78VBybNnhCnYVu2g4Mgefi2or0utsRAvKOKS3UTsvg4d6VV
         899w==
X-Forwarded-Encrypted: i=1; AJvYcCXVDfeXujnj2GqgPLdZCbfric8i+LNP4Xv8pGHxHYvtResLAGjxRa/ANK+gL4RTMnk0Z4upgA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZWyzsFywAx/sAVovvMvcxinukZwv4NuDJnec3ZAwZOaLODG/K
	TwXAeodcEzWqTYcU5dmaGdumjmy3UzRunPdGrjY6ejwhf7VSYG6SafYoIT73HoBBP0FkGjJbyys
	G2GUIpAcqMtLI1aXrzmVEQ6u7pWMVuwj5C/SzXb4B
X-Gm-Gg: AY/fxX5mwgDQbVcAYkqziimYm+7aNMyEOuUJuf/YStIsJY9JpGVhVFwQmO/DDNtFgiP
	unoGQiFJ9iSaRspJU/91a0cZ2AhPSf540vK7hKeoda+RQCxB5BLcXjEFywdwW9RnXTGeO8hbJfb
	DnaoKXoQeL6AUh4jFBJFF+xT4v7TA4pnCOLkmyffpeHv29+KO5wZdx8yks2LYQC/iF4qHoeTCT8
	dXToGNor29c2EPJuWNNoiNlLUjL6PulegCtq2P5s256EpSQm1qRpUSskowlqp8zi+2En/+ILuGN
	xLoSQBhYGiq1z6xuKHob04yCoQ==
X-Received: by 2002:a05:7022:608c:b0:11a:44d1:533b with SMTP id
 a92af1059eb24-12336714909mr18498c88.8.1768332462242; Tue, 13 Jan 2026
 11:27:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260113030052.977366-1-baolu.lu@linux.intel.com> <20260113030052.977366-4-baolu.lu@linux.intel.com>
In-Reply-To: <20260113030052.977366-4-baolu.lu@linux.intel.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Tue, 13 Jan 2026 11:27:30 -0800
X-Gm-Features: AZwV_Qhnu8ou1jK_MHPEbHfY-n_CgTPLWVCRtVF6KGvYNKzPNds4-AUft-Rsd1k
Message-ID: <CAAywjhSv56Y9rJLVdqV9N54c7S30ZUjyNh05xc-EW2+dS74GFQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] iommu/vt-d: Rework hitless PASID entry replacement
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Dmytro Maluka <dmaluka@chromium.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 7:03=E2=80=AFPM Lu Baolu <baolu.lu@linux.intel.com>=
 wrote:
>
> The Intel VT-d PASID table entry is 512 bits (64 bytes). Because the
> hardware may fetch this entry in multiple 128-bit chunks, updating the
> entire entry while it is active (P=3D1) risks a "torn" read where the
> hardware observes an inconsistent state.
>
> However, certain updates (e.g., changing page table pointers while
> keeping the translation type and domain ID the same) can be performed
> hitlessly. This is possible if the update is limited to a single
> 128-bit chunk while the other chunks remains stable.
>
> Introduce a hitless replacement mechanism for PASID entries:
>
> - Update 'struct pasid_entry' with a union to support 128-bit
>   access via the newly added val128[4] array.
> - Add pasid_support_hitless_replace() to determine if a transition
>   between an old and new entry is safe to perform atomically.
>   - For First-level/Nested translations: The first 128 bits (chunk 0)
>     must remain identical; chunk 1 is updated atomically.

Looking at the specs, the DID is part of the first 128 bits (chunk 0),
so I guess for the first level the hitless replacement would not be
supported since each domain will have a different DID?
>   - For Second-level/Pass-through: The second 128 bits (chunk 1)
>     must remain identical; chunk 0 is updated atomically.
> - If hitless replacement is supported, use intel_iommu_atomic128_set()
>   to commit the change in a single 16-byte burst.
> - If the changes are too extensive to be hitless, fall back to the
>   safe "tear down and re-setup" flow (clear present -> flush -> setup).
>
> Fixes: 7543ee63e811 ("iommu/vt-d: Add pasid replace helpers")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/pasid.h | 26 ++++++++++++++++-
>  drivers/iommu/intel/pasid.c | 57 ++++++++++++++++++++++++++++++++++---
>  2 files changed, 78 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
> index 35de1d77355f..b569e2828a8b 100644
> --- a/drivers/iommu/intel/pasid.h
> +++ b/drivers/iommu/intel/pasid.h
> @@ -37,7 +37,10 @@ struct pasid_dir_entry {
>  };
>
>  struct pasid_entry {
> -       u64 val[8];
> +       union {
> +               u64 val[8];
> +               u128 val128[4];
> +       };
>  };
>
>  #define PASID_ENTRY_PGTT_FL_ONLY       (1)
> @@ -297,6 +300,27 @@ static inline void pasid_set_eafe(struct pasid_entry=
 *pe)
>         pasid_set_bits(&pe->val[2], 1 << 7, 1 << 7);
>  }
>
> +static inline bool pasid_support_hitless_replace(struct pasid_entry *pte=
,
> +                                                struct pasid_entry *new,=
 int type)
> +{
> +       switch (type) {
> +       case PASID_ENTRY_PGTT_FL_ONLY:
> +       case PASID_ENTRY_PGTT_NESTED:
> +               /* The first 128 bits remain the same. */
> +               return READ_ONCE(pte->val[0]) =3D=3D READ_ONCE(new->val[0=
]) &&
> +                       READ_ONCE(pte->val[1]) =3D=3D READ_ONCE(new->val[=
1]);
> +       case PASID_ENTRY_PGTT_SL_ONLY:
> +       case PASID_ENTRY_PGTT_PT:
> +               /* The second 128 bits remain the same. */
> +               return READ_ONCE(pte->val[2]) =3D=3D READ_ONCE(new->val[2=
]) &&
> +                       READ_ONCE(pte->val[3]) =3D=3D READ_ONCE(new->val[=
3]);
> +       default:
> +               WARN_ON(true);
> +       }
> +
> +       return false;
> +}
> +
>  extern unsigned int intel_pasid_max_id;
>  int intel_pasid_alloc_table(struct device *dev);
>  void intel_pasid_free_table(struct device *dev);
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 4f36138448d8..da7ab18d3bfe 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -452,7 +452,20 @@ int intel_pasid_replace_first_level(struct intel_iom=
mu *iommu,
>
>         WARN_ON(old_did !=3D pasid_get_domain_id(pte));
>
> -       *pte =3D new_pte;
> +       if (!pasid_support_hitless_replace(pte, &new_pte,
> +                                          PASID_ENTRY_PGTT_FL_ONLY)) {
> +               spin_unlock(&iommu->lock);
> +               intel_pasid_tear_down_entry(iommu, dev, pasid, false);
> +
> +               return intel_pasid_setup_first_level(iommu, dev, fsptptr,
> +                                                    pasid, did, flags);
> +       }
> +
> +       /*
> +        * A first-only hitless replace requires the first 128 bits to re=
main
> +        * the same. Only the second 128-bit chunk needs to be updated.
> +        */
> +       intel_iommu_atomic128_set(&pte->val128[1], new_pte.val128[1]);
>         spin_unlock(&iommu->lock);
>
>         intel_pasid_flush_present(iommu, dev, pasid, old_did, pte);
> @@ -563,7 +576,19 @@ int intel_pasid_replace_second_level(struct intel_io=
mmu *iommu,
>
>         WARN_ON(old_did !=3D pasid_get_domain_id(pte));
>
> -       *pte =3D new_pte;
> +       if (!pasid_support_hitless_replace(pte, &new_pte,
> +                                          PASID_ENTRY_PGTT_SL_ONLY)) {
> +               spin_unlock(&iommu->lock);
> +               intel_pasid_tear_down_entry(iommu, dev, pasid, false);
> +
> +               return intel_pasid_setup_second_level(iommu, domain, dev,=
 pasid);
> +       }
> +
> +       /*
> +        * A second-only hitless replace requires the second 128 bits to =
remain
> +        * the same. Only the first 128-bit chunk needs to be updated.
> +        */
> +       intel_iommu_atomic128_set(&pte->val128[0], new_pte.val128[0]);
>         spin_unlock(&iommu->lock);
>
>         intel_pasid_flush_present(iommu, dev, pasid, old_did, pte);
> @@ -707,7 +732,19 @@ int intel_pasid_replace_pass_through(struct intel_io=
mmu *iommu,
>
>         WARN_ON(old_did !=3D pasid_get_domain_id(pte));
>
> -       *pte =3D new_pte;
> +       if (!pasid_support_hitless_replace(pte, &new_pte,
> +                                          PASID_ENTRY_PGTT_PT)) {
> +               spin_unlock(&iommu->lock);
> +               intel_pasid_tear_down_entry(iommu, dev, pasid, false);
> +
> +               return intel_pasid_setup_pass_through(iommu, dev, pasid);
> +       }
> +
> +       /*
> +        * A passthrough hitless replace requires the second 128 bits to =
remain
> +        * the same. Only the first 128-bit chunk needs to be updated.
> +        */
> +       intel_iommu_atomic128_set(&pte->val128[0], new_pte.val128[0]);
>         spin_unlock(&iommu->lock);
>
>         intel_pasid_flush_present(iommu, dev, pasid, old_did, pte);
> @@ -903,7 +940,19 @@ int intel_pasid_replace_nested(struct intel_iommu *i=
ommu,
>
>         WARN_ON(old_did !=3D pasid_get_domain_id(pte));
>
> -       *pte =3D new_pte;
> +       if (!pasid_support_hitless_replace(pte, &new_pte,
> +                                          PASID_ENTRY_PGTT_NESTED)) {
> +               spin_unlock(&iommu->lock);
> +               intel_pasid_tear_down_entry(iommu, dev, pasid, false);
> +
> +               return intel_pasid_setup_nested(iommu, dev, pasid, domain=
);
> +       }
> +
> +       /*
> +        * A nested hitless replace requires the first 128 bits to remain
> +        * the same. Only the second 128-bit chunk needs to be updated.
> +        */
> +       intel_iommu_atomic128_set(&pte->val128[1], new_pte.val128[1]);
>         spin_unlock(&iommu->lock);
>
>         intel_pasid_flush_present(iommu, dev, pasid, old_did, pte);
> --
> 2.43.0
>
