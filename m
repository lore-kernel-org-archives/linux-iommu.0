Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2EF3C24
	for <iommu@lists.linux.dev>; Fri, 24 Mar 2023 09:19:13 +0000 (UTC)
Received: by mail-qk1-f173.google.com with SMTP id n137so282382qka.2
        for <iommu@lists.linux.dev>; Fri, 24 Mar 2023 02:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679649552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9OHshIzwpPdXZ+ETy9dUvKhjE3q/i6W2U6caqQqg2vc=;
        b=FjQN6twGo/NqWd7Wm0Nch5D5xsG1UHvaYdZaykMkwha0axL7eCAUqWOeDY1879bqfJ
         XAC9UH2REM4lz68ovQVzlO5RXn5hU9gXtdkZpi/++44xaPw72RjC1c/jbNT0oh5x7jZq
         CkX6qjjzNR2uNYvbjW4Wx3kbhEx1sLSwuNnlPescKBvKOA32xqaTQr9DEc/xzCNh0rdn
         zROZxmyvnVUrBFF4pHEi+TfJTOZLjuJrRWlpdwijH+pFu9YejOXHMW1rBa7So4gOKnwH
         4J/oMGpjqR+SOiY2Vt2B4uHg0UJLIEsrcmgBjUWdkz+uOYCGk5pXHekE8tMr3imnsYG+
         JeAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679649552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9OHshIzwpPdXZ+ETy9dUvKhjE3q/i6W2U6caqQqg2vc=;
        b=ikYZXmnmN46zm6V6LeHBzV7xziiuaoLEeTclGiVn8J7F35xKsEUUiPyV2ZWe7ILXvk
         whEFUBYZ4UCnch8mwOPMl5xoB8y1wM78rtKCHGObJOwFeGew8v/1uLEd7mxNpIcpGf/h
         3zniuaPJ7RJdHyfKzt+ExMnLDB8qZrfTMv9pKcFnXOLCkSNx0uNNyyPDIS1uL9Cwc5hQ
         Q/zJ/mUoGu/IyMrYq3qhuRZliCLh7XeoR3EcPDT63KSPAPBnSzk/Ot+71Da6P3ccGkHe
         z0HFySbkJgygZXKqdUJFFLv8gOB4rjZulI4qIYvS9rLu9htASaHlHNoRHsu5fYG45XYI
         8aZg==
X-Gm-Message-State: AO0yUKV2lNl21GrBWEchmMfCWbvgaVTfs1Lu7HM+NdrOhakre2WnH1KY
	j4MUyJZAY9Iqm0PqNlERboD9AoGhWmUDCrI7hr140A==
X-Google-Smtp-Source: AK7set9w68YfA5Q07QLKo/YvN8tFY/m3v7BikiK3Ew2LpnIRXtQNw580HfkqzKMh/TLZz25g3dVQOEATO59Oe2KPLSE=
X-Received: by 2002:a05:620a:c91:b0:746:9016:1eb0 with SMTP id
 q17-20020a05620a0c9100b0074690161eb0mr482190qki.2.1679649552380; Fri, 24 Mar
 2023 02:19:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Michael Shavit <mshavit@google.com>
Date: Fri, 24 Mar 2023 17:18:36 +0800
Message-ID: <CAKHBV24u9b-=cJCF=Kt=3B4hynOyNr6gmi0F6zpO6b1mHc0Z7g@mail.gmail.com>
Subject: [Design] iommu/arm-smmu-v3: Implementing set_dev_pasid for other
 domain types
To: jean-philippe@linaro.org, Will Deacon <willdeacon@google.com>, robin.murphy@arm.com
Cc: Daniel Mentz <danielmentz@google.com>, John Scheible <johnscheible@google.com>, 
	Mostafa Saleh <smostafa@google.com>, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jean-Philippe, all

We=E2=80=99d like to use the new iommu_attach_device_pasid API to control
mappings on a per SSID basis. To that end, we=E2=80=99ve started investigat=
ing
how to implement the set_dev_pasid callback in the arm-smmu-v3.c
driver for domain types other than SVA.

As noted in your smmuv3 aux-domain patch, the arm_smmu_domain
represents not only =E2=80=9Cthe non-PASID address space but also (at least
for SMMUv3) the whole device context, PASID tables etc.=E2=80=9D Multiple S=
VA
iommu_domains reach into a shared arm_smmu_domain to write their CDs
into a shared CD table.
Is moving to a model where each arm_smmu_master holds this previously
shared device context instead of the arm_smmu_domain a bad idea?

This would allow a pretty straightforward implementation of
set_dev_pasid for other domain types:
    * Attaching a domain with PASID to a device doesn=E2=80=99t have to
piggyback on any other domain=E2=80=99s CD table. The domain=E2=80=99s CD c=
an directly
be written into the master=E2=80=99s CD table.
    * A domain attached with PASID is no different than one attached
without PASID, attach_dev becomes attach_dev_with_pasid(0).

At a high-level:
   1. The arm_smmu_domain would still own the arm_smmu_ctx_desc struct
that describes that domain (translation table, etc)
   2. Each arm_smmu_master would now own its own s1_cfg struct (and CD
table). Attaching a domain to a device would write the CD into that
device=E2=80=99s CD table instead of the previously shared CD table.

From an implementation POV there=E2=80=99s a few other changes and
book-keeping that become required to handle edge-cases (e.g. We need
to find all the CD entries that a domain is written to when the SVA
driver tries to update a domain=E2=80=99s ASID value). Right now I=E2=80=99=
m more
concerned about whether this idea is sane at a design level.

As a first order consequence, when multiple devices share a domain:
    1. We=E2=80=99ll use more memory than we would have before.
    2. The SMMU will perform dma to distinct CD tables to find the
page table; however the page table itself would still be shared.

Is that acceptable considering some users might not need the
set_dev_pasid support this is geared towards?
Are there other consequences we've overlooked?

Thanks,
Michael
