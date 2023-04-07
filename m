Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6170D2F33
	for <iommu@lists.linux.dev>; Fri,  7 Apr 2023 11:02:19 +0000 (UTC)
Received: by mail-vs1-f47.google.com with SMTP id cz11so36613083vsb.6
        for <iommu@lists.linux.dev>; Fri, 07 Apr 2023 04:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680865338;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bnCi5DBbL//BFemZj9EDRYcS9Oqr6pXGT5Uu+07pyKk=;
        b=aV/aYyprtSnWL4muzZnzLHlQdD35/t/nvaA4DOkq6dFqaqCATbFCE2/Dy5MtRonktp
         00XRF0D3D9qIDYFTa5VzWyJOEQtXVk8sciz6XZ83pEY/IhHEMNhqUI1LnUQgbpu7+8YJ
         9leeeASejyW9yiNjrsKJRNpxOGQjiO3jLilc1MRrR/jJwUq/qGGFkgt8N+rwlXaXmC4J
         xjczL5O/cJB+H/vsSLfaosO5YxcuuEscubMOjS1i4g52pnST/ntXMW/pj/YKuuBDujD2
         0EKV+aNXGAW03Z6BJ7lJedi54LNHLxOhirml9MtP4QV5+JvA+ZWP0tXwaMgAb/WJivV3
         AuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680865338;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bnCi5DBbL//BFemZj9EDRYcS9Oqr6pXGT5Uu+07pyKk=;
        b=4LGuayWZc6Ms7ExLmWtzaX9r63H1kJ9ta7auZrZb+5/1VtNYDtiOgBbLcLlernDeb/
         w6+y3iXd8bw0Vnewc+geZPb+fLbowJcSOi4rGlTasYRuOjYzm7miVYB7UNHXVcKZQ0F0
         BVlrdaTFh32OB8QZ99WsE4lYm+4DrIDxmj2+MPPqdYj7FY6LfnGUuqFcA+eZ7YzRpyZT
         SAPEwTI8V4vaBPWA4LNN0fXKN5uuc4QO34aGfcZ9mU0HI+tYXHVI2/VcS0itxZ8T5sWF
         dPNxk6rr5XQe3iJhtX+NlKtqwJRBBJdqS8QcSJnpY2z3MB08RXjARQN8rkpIXflAsj40
         pWgw==
X-Gm-Message-State: AAQBX9cEMkqNdNvSieXgj4chirfnqmtxIzDyDTKK7jvX0gQg322C7iNS
	MO0xnznJEpZpqYLIiu8PoIsDPgORS3tnfdOEkn7a4A==
X-Google-Smtp-Source: AKy350Z7UGgAxoTM2bAaFDH958W4LskrIA22pCWjsXBTJ0e7MWJbwaqa/crYxsuPwS1CuZZIgu29047Zrt9yWzGcs9Y=
X-Received: by 2002:a67:e018:0:b0:425:d52d:f5cb with SMTP id
 c24-20020a67e018000000b00425d52df5cbmr864797vsl.1.1680865337976; Fri, 07 Apr
 2023 04:02:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 7 Apr 2023 16:32:06 +0530
Message-ID: <CA+G9fYufcvZwx4wUfQGE70Aw0KgBkx5he0z4wxe_3v6KNVRJxg@mail.gmail.com>
Subject: Re: [PATCH v3 00/17] Consolidate the error handling around device attachment
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, llvm@lists.linux.dev, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Tom Rix <trix@redhat.com>, 
	Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Kevin Tian <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Apr 2023 at 05:08, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> Device attachment has a bunch of different flows open coded in different
> ways throughout the code.
>
> One of the things that became apparently recently is that error handling
> is important and we do need to consistently treat errors during attach and
> have some strategy to unwind back to a safe state.
>
> Implement a single algorithm for this in one function. It will call each
> device's attach, if it fails it will try to go back to the prior domain or
> as a contingency against a UAF crash try to go to a blocking domain.
>
> As part of this we consolidate how the default domain is created and
> attached as well into one place with a consistent flow.
>
> The new worker functions are called __iommu_device_set_domain() and
> __iommu_group_set_domain_internal(), each has sensible error handling
> internally. At the end __iommu_group_set_domain_internal() is the only
> function that stores to group->domain, and must be called to change this
> value.
>
> Some flags tell the intent of the caller, if the caller cannot accept a
> failure, or if the caller is a first attach and wants to do the deferred
> logic.
>
> Several of the confusing workflows where we store things in group->domain
> or group->default_domain before they are fully setup are removed.
>
> This has a followup series that does a similar de-duplication to the probe
> path:
>
> https://github.com/jgunthorpe/linux/commits/iommu_err_unwind

This repository and iommu_err_unwind branch built with clang-16 and
boot tested on arm x15, arm64 Rpi4, Qcom Db410c and juno-r2 devices.
All boot test and LTP smoke pass.

>
> v3:
>  - New patch to do iommu_group_create_direct_mappings() before
>    attach on the hotplug path based on Lu and Robin's remarks
>  - Fix to return 0 if the group has conflicting default domain types like
>    the original code
>  - Put iommu_group_create_direct_mappings() before attach in setup_domains
>  - Split up the alloc changes from the setup_domain patch to their own
>    patch, implement Robin's point about how the iommu_def_domain_type should
>    work
>  - New patch to optionally do iommu_group_create_direct_mappings() after
>    attach
>  - Reword the setup_domain patch's commit message

<trim>

>  .clang-format         |   1 +
>  drivers/iommu/iommu.c | 636 +++++++++++++++++++++---------------------
>  2 files changed, 325 insertions(+), 312 deletions(-)

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


>
> base-commit: 3578e36f238ef81a1967e849e0a3106c9dd37e68
> --
> 2.40.0
>

Best regards
Naresh
