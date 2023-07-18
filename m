Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AA9C8C4
	for <iommu@lists.linux.dev>; Tue, 18 Jul 2023 08:52:37 +0000 (UTC)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4036bd4fff1so241691cf.0
        for <iommu@lists.linux.dev>; Tue, 18 Jul 2023 01:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689670356; x=1692262356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYiyuxt/N5ReOBp+6DLzcnLSJb59cmexqlxBPjdaU+I=;
        b=CgDv/w4umtpcqM4lU+wjtzqvMOW5k5wCdeUDfhXa/lCNH0hulr4DpFxCOrol2sLw0Y
         wK7ZwWhs/92u9acenAT3PRZOkN2anHV2YA9+EhNwWAu8GTe+piNIWX/ZOmVDjpxg/XoS
         gNaUn5/uisOslv5SOisanOuajIHCT2XAqit2hR5Xdii+IvbI2wodDL+GFJwEK1M+xvQ8
         mve8s6mp6CNpw3m+qTOtxDnGXTJWgeZvU+VRQh78/NablesAbjmgR6fgayTn3m14U5T6
         eNiZtAqZKnE8xly41lvmYJlcdmVDwLM+8oxVyJU384hZ8WUVSpszi+gF4xNqRxrC3FIY
         aDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689670356; x=1692262356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pYiyuxt/N5ReOBp+6DLzcnLSJb59cmexqlxBPjdaU+I=;
        b=IE6QD6mQIvNUMqVFV6EXRRosoAI1+dv5MRgSZIt8rweEYUS3mMH7r4mHi7S6lxY7h1
         V0LrYkpwYQUSE+xLUn66AJGYxyQt2oFWXsFZDiMhpFDsPzhkq4as/ZZXgFjdO70ktdUU
         5ydf1gwEmz6qIWBAmD9o3TfLDwuytLCZt/qwbhCJDuGgnRacEtw/voRR98Cq/oaYbDU3
         C1FUO9DLWTwbFKRxCXEIOIV6sxLXIsNQ7g0rxrXfuJuIom+p8L6nrRWzpH++vjkHqrWE
         Bywx3cWOcKgzODPyrhVjjutbKKCd5NfkjND2SbmuIPSSiS1FFLdFOhsfmD6+Ie0X2QCD
         yq/A==
X-Gm-Message-State: ABy/qLZBiYNWTn3zZiiiVjbX5VOQRy7+/fVqy8+3Q6HryPYhHfIqS4o+
	zQvRNgQxR1pIiNAzm2x5yb9CDhYGbp+AABfnikta5A==
X-Google-Smtp-Source: APBJJlFCj+g3+yVxx0XuWKRe0hkfwk4QruUfGKVc61L++n23uTaYOm9vYpWIeIZwwyFWo8ewaQZirqcfdmjyHbLVtks=
X-Received: by 2002:ac8:5b02:0:b0:403:e1d1:8b63 with SMTP id
 m2-20020ac85b02000000b00403e1d18b63mr207657qtw.24.1689670355892; Tue, 18 Jul
 2023 01:52:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com> <20230621063825.268890-8-mshavit@google.com>
 <ZK+BZhwbo8JLMPI2@Asurada-Nvidia> <CAKHBV27idVJ-8YgpekezaQP2n+Oz6OpKnDmYiu_cSOFh6z1S+Q@mail.gmail.com>
 <ZLHp0r1g1lroGYlN@Asurada-Nvidia>
In-Reply-To: <ZLHp0r1g1lroGYlN@Asurada-Nvidia>
From: Michael Shavit <mshavit@google.com>
Date: Tue, 18 Jul 2023 16:51:59 +0800
Message-ID: <CAKHBV25ButEYJLxqRHo1V+KrwoDAGqfJGSh1G1Pe3f3_djE_TA@mail.gmail.com>
Subject: Re: [PATCH v4 07/13] iommu/arm-smmu-v3: Keep track of attached ssids
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org, jgg@nvidia.com, 
	baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 15, 2023 at 8:35=E2=80=AFAM Nicolin Chen <nicolinc@nvidia.com> =
wrote:
> Well, firstly it's kinda odd to have this optimization hidden in
> a big rework patch. And I am not sure if it alone would work for
> all use cases, as it impacts the arm_smmu_atc_inv_domain() that
> passes in a zero ssid, in which case the affected function is not
> used by a pasid case all the time:

To clarify, we haven't changed anything for the existing flow. Before
the latter set_dev_pasid patch is introduced, there's only ever a
single {master,domain} pair in the attached_domain list. When
arm_smmu_atc_inv_domain() is called on a non-pasid domain, it issues a
single atc inv command with substream_valid=3Dfalse, same as before.
When SVA wants to invalidate a domain, it calls
arm_smmu_atc_inv_domain_ssid to issue a single atc inv command with
that specific PASID, same as before. At no point does the driver ever
rely on the fact that invalidating with substream_valid=3Dfalse would
invalidate all PASIDs.

This patch series simply follows the precedent set by SVA: when a
domain is attached with a pasid, invalidates those specific pasids.
It'd feel kinda hacky to rely on the fact that invalidating with
substream_valid=3Dfalse would invalidate all PASIDs.
