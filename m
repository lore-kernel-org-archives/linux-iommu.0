Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA83F15C3
	for <iommu@lists.linux.dev>; Fri,  2 Feb 2024 12:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706877234; cv=none; b=bbtxQoeUAKqlOg92ep0xLovpTwB5Q6E/WvD3aDYLF4kZtEf08jvGIDMgHirhBMCw0mPne8tIC+FyfufiB+o0WVjw/c2SPLmlDj0yChKLwafXtRWJtJSqdFXdrnXnh6pFdDsMvskGfeRWlYge/i1lwYLq/TveEm1z0dS/rN9+2d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706877234; c=relaxed/simple;
	bh=1r710yhBZNExp8AEl6cAK8/0Eo3fc6Hhl983tAZk4Ls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q4m8PhpzXRIpYIHp0pxs4rAJOVDFJhRPrSngrO+5ez6rIwLJnNr2gK/+kUFEtF3Jd2SAy+FLjf9OWPfXosI8jNvVdrsmhjKKzxYM5KUxlZeaU59Jh2lN4BvJ+WqxYGCfQnal1HjyxcPSlDteUqPpA5msgzg3/LL+dusTQQGEKhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dPWr68DY; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dPWr68DY"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-428405a0205so257271cf.1
        for <iommu@lists.linux.dev>; Fri, 02 Feb 2024 04:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706877232; x=1707482032; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MF2JpI2Rz6LA9Ya1UMXjTDWsR6angJPy6uuMzVOlcFA=;
        b=dPWr68DYwS5Am8dcjxZFB2c2yvuMCOOcT5HE3KKO9/8RXiZc1ewjV5cxTnCs9IzKl7
         LrHcx8tXo+mbE9AGnUIxJzDBUpo5kyzTpJlkYfB4fpVzHmWhbu78UK2b9XR/hfyh5jNa
         yOglWH3won2pbH8jlqmIO+y3u/w0R0NQYjRiUW4RR/Ll9XU0O5aPxBe1bR9vJn/MczaU
         v0iIxq9dYyL2pomQ4VEcmcarCzJriNKu7COju6S/diAK8U6QWu1ZDDEViPBonEWPR16r
         OM88UV4JOuR3Wwzb3SEmUAKF4ygMVy7e8czKoFZHuwzX7cqjByMOtRYyqiyg0qMhElsC
         qdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706877232; x=1707482032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MF2JpI2Rz6LA9Ya1UMXjTDWsR6angJPy6uuMzVOlcFA=;
        b=rXgu01T32I6o+Ki53B9F9ZFVspT1imfzLFu1D3oNcTLyLGr+K8sBgx210coez1Ytxy
         awKReHWxrVFh54FW+2DUUrznkjKwiK1OReus7ohFmolbQ62ByiSdCFZtYfm31oHPakV6
         SstNdy30mQefsGxFAkW4M03dGBqbClAZnprK+7VKXlTWSYvHBPY05n1O1qEIK9BXp8Mv
         DWs6zfoEQJbwygPikhcy0qQLAutaxCGBGh1iDbfX9sbpRpKZAGEZnQQLXh2iiscrAxhE
         Qp6gogdO86eFVP4jzy0VlydHrYRTpg0js0n4wyqfDWthU7Uduwl2kpSiDcH2pknIVu0G
         8dzg==
X-Gm-Message-State: AOJu0YyIHFK+dlzOP+e5jinkUsuFTaeiPBp/flnxFs03UfDFTOJh72bG
	SBPd0ydIQfEN5Eh4xhc4ryEaBvNzn77edJl1IK3J87rQGFC2N89Kb9Cfb+GjvKCGeNBQp9IK1/V
	5WU8iILNFh3kznWQkPvEX3BuBxwhbG9pXZlXw
X-Google-Smtp-Source: AGHT+IH7plzkRkdU70rOyf8qn7QyxhQF+FktkF3AMHBySWqjm0H31AGwswFQgImM/MFMx7AkvPYdstb+uVHN3l5r6T0=
X-Received: by 2002:ac8:7f55:0:b0:42b:f2d9:5e4d with SMTP id
 g21-20020ac87f55000000b0042bf2d95e4dmr239531qtk.2.1706877231585; Fri, 02 Feb
 2024 04:33:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <4e25d161-0cf8-4050-9aa3-dfa21cd63e56@moroto.mountain>
In-Reply-To: <4e25d161-0cf8-4050-9aa3-dfa21cd63e56@moroto.mountain>
From: Michael Shavit <mshavit@google.com>
Date: Fri, 2 Feb 2024 21:33:14 +0900
Message-ID: <CAKHBV24oM7JpenJfGXymcxkRdW=49dVWS72oCuTxt-FEguSueA@mail.gmail.com>
Subject: Re: [bug report] iommu/arm-smmu-v3: Refactor write_ctx_desc
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: iommu@lists.linux.dev, Jason Gunthorpe <jgg@nvidia.com>, 
	Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 9:18=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro.=
org> wrote:
>
> Hello Michael Shavit,
>
> The patch 24503148c545: "iommu/arm-smmu-v3: Refactor write_ctx_desc"
> from Sep 15, 2023 (linux-next), leads to the following Smatch static
> checker warning:
>
>         drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:1036 arm_smmu_get_cd_=
ptr()
>         warn: sleeping in atomic context
>
> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>     1022 static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_master *maste=
r, u32 ssid)
>     1023 {
>     1024         __le64 *l1ptr;
>     1025         unsigned int idx;
>     1026         struct arm_smmu_l1_ctx_desc *l1_desc;
>     1027         struct arm_smmu_device *smmu =3D master->smmu;
>     1028         struct arm_smmu_ctx_desc_cfg *cd_table =3D &master->cd_t=
able;
>     1029
>     1030         if (cd_table->s1fmt =3D=3D STRTAB_STE_0_S1FMT_LINEAR)
>     1031                 return cd_table->cdtab + ssid * CTXDESC_CD_DWORD=
S;
>     1032
>     1033         idx =3D ssid >> CTXDESC_SPLIT;
>     1034         l1_desc =3D &cd_table->l1_desc[idx];
>     1035         if (!l1_desc->l2ptr) {
>                      ^^^^^^^^^^^^^^^
> I don't know if l1_desc->l2ptr can be NULL for the call trees in
> question so this might be a false positive.  You'd need to enable
> CONFIG_DEBUG_ATOMIC_SLEEP=3Dy to see these warnings at runtime.
>
>
> --> 1036                 if (arm_smmu_alloc_cd_leaf_table(smmu, l1_desc))
>                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Sleeping allocation.
>
>     1037                         return NULL;
>     1038
>     1039                 l1ptr =3D cd_table->cdtab + idx * CTXDESC_L1_DES=
C_DWORDS;
>     1040                 arm_smmu_write_cd_l1_desc(l1ptr, l1_desc);
>     1041                 /* An invalid L1CD can be cached */
>     1042                 arm_smmu_sync_cd(master, ssid, false);
>     1043         }
>     1044         idx =3D ssid & (CTXDESC_L2_ENTRIES - 1);
>     1045         return l1_desc->l2ptr + idx * CTXDESC_CD_DWORDS;
>     1046 }
>
> The call trees which trigger this warning are:
>
> arm_smmu_update_ctx_desc_devices() <- disables preempt
This call is a false positive since arm_smmu_update_ctx_desc_devices
only ever updates existing CD entries, which doesn't require any
allocation.

> arm_smmu_mmu_notifier_get() <- disables preempt
> -> arm_smmu_write_ctx_desc()
>    -> arm_smmu_get_cd_ptr()

Thanks for the report Dan. This call tree looks like a true positive
if SVA is used and s1fmt is set to STRTAB_STE_0_S1FMT_64K_L2.

Jason's "iommu/arm-smmu-v3: Lift CD programming out of the SVA
notifier code" patch would resolve this by moving the
arm_smmu_get_cd_ptr() call that causes the allocation further up the
call tree (although the intent was to prevent handling of failing
allocations).

Jason, should we consider moving arm_smmu_get_cd_ptr() further up the
call-stack as a standalone patch to remediate this report in the
shorter term? It won't make this static checker happy, but should at
least resolve any true positives.

(P.S: on vacation 01/26-02/18, scanning and replying to emails on a
best-effort basis so apologies for any delays)

Michael Shavit
