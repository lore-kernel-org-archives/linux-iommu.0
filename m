Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F2D14F8F
	for <iommu@lists.linux.dev>; Wed, 18 Oct 2023 11:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LM1a1cCN"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-41b813f0a29so191501cf.0
        for <iommu@lists.linux.dev>; Wed, 18 Oct 2023 04:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697627186; x=1698231986; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rP/bLufe0mH5aYuxnfOuVFbWLHRt0YkW/yHuBnBiS/E=;
        b=LM1a1cCNswx3jaF0fQIivUi8C9tIKBjEki+W9OYhPy7BkD3+bGAK9pQVkO9re/r7Ww
         sPlhTcApsY1nlIvhMQEvsM+KjZSlyYr8ekl+Y4R8vhMBRITFRRVcjaAnToEdIQ2craoP
         mvk9gU0qZNaIbihvkSp9xrKV/yHzwQsJOjVw2kFy1Gezy1pfJunih/9oyeErIZoypiyU
         l8Tq7d1x10uT5rwwXc5tFvwU6JymoPJr+pFhWn0aResHSfAwhImN5x0+/wjbpBgFeV9w
         vUMqEWze/SIeB8j++/MGPCbTwT1IkjuRSC3wuERBwQEwzLidF4nBQLleK/3HTIaZtFIr
         bEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697627186; x=1698231986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rP/bLufe0mH5aYuxnfOuVFbWLHRt0YkW/yHuBnBiS/E=;
        b=K9xEN+YEN0mJzFkgFpEAHqONrtiK7MFms2KtGHxTLc67QClTjtlv6XjdqvCswGE+Cf
         nTBkkZrN5m8RAvzWIJPptUB1Z4O6Mn94MO1Ug5sIqvduiv8Edc1DAbUdyQ/nXggVMpnC
         QQGRdk+RJV5ABsraUzK6JWZ0387NgNO3osKZK3Xzg6cIBqOQs1a8Er+G9AXyAjiy3pSd
         dzUKx6NgvzBM4vogmibEDEEh9smTzsba1zE/3KmPfXaFeFu68mgOKo27RFJM+beI4zJ5
         Fv03x61hx3IRZ2mdlwTw+2WXy4pirMF4V/v2MiqiVW4fSog3PYIA5hE9oGVheVbIfx7K
         /DUQ==
X-Gm-Message-State: AOJu0Yx3LyfD4gb9J7D6xVs1r5ALE6R+kGouBuo7Gm++9s01OrGBeUQl
	qRUuOGdB28l1Ej9hizo3wfRYXAk7w983Je4dcZjpAg==
X-Google-Smtp-Source: AGHT+IFQObqo/WhpV6zCaK+9WzuSWhRVIESBbkzxSjuuE951jK4+g9Te3/EHu4uaII+WkxL7UeMkqsNUQwESqCUqvh0=
X-Received: by 2002:ac8:748f:0:b0:41c:bd0a:8013 with SMTP id
 v15-20020ac8748f000000b0041cbd0a8013mr139227qtq.3.1697627185592; Wed, 18 Oct
 2023 04:06:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
 <4-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com> <CAKHBV24UGZuG6+J4cybadJCTyf9hN+e_VgAC0NVOPotmEur7SQ@mail.gmail.com>
 <20231012121616.GF3952@nvidia.com>
In-Reply-To: <20231012121616.GF3952@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Wed, 18 Oct 2023 19:05:49 +0800
Message-ID: <CAKHBV27G1PLZ5gkYkOOCZdD9waZOZypkWqk4_HSR4XXGFT-+LA@mail.gmail.com>
Subject: Re: [PATCH 04/19] iommu/arm-smmu-v3: Make STE programming independent
 of the callers
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 8:16=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Thu, Oct 12, 2023 at 04:10:50PM +0800, Michael Shavit wrote:
>
> > This sounds pretty complicated....Is this complexity really required
> > here?
>
> It is first needed before 'iommu/arm-smmu-v3: Do not change the STE
> twice during arm_smmu_attach_dev()' which is a couple of patches
> further on.
>
> Then it keeps getting relied on.
>
> I don't think there is any simple answer here, the HW has this complex
> requirement. The current code is also complex - arguably more complex
> because of how leaky/fragile it is. There is even a couple of pages of
> text in the spec describing how to do this, and it doesn't discuss the
> hitless cases!
>
> At the end this is only 32 lines and it replaces both
> arm_smmu_write_ctx_desc() and arm_smmu_write_strtab_ent().
>
> FWIW, I found the most difficult part the used bit calculation, not
> the update algorithm. Difficult because it is hard to read and find in
> the spec when things are INGORED, but it is a "straightforward" job of
> finding INGORED cases and making the used bits 0.

The update algorithm is the part I'm finding much harder to read and
review :) . arm_smmu_write_entry_step in particular is hard to read
through; on top of which there's some subtle dependencies between loop
iterations that weren't obvious to grok:
* Relying on the used_bits to be recomputed after the first iteration
where V=3D0 was set to 0 so that more bits can now be set.
* The STE having to be synced between iterations to prevent broken STE
reads by the SMMU (there's a comment somewhere else in arm-smmu-v3.c
that would fit nicely here instead). But the caller is responsible for
calling this between iterations for some reason (supposedly to support
CD entries as well in the next series)
