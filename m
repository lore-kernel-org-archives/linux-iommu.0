Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188C42561
	for <iommu@lists.linux.dev>; Wed,  8 Feb 2023 12:31:27 +0000 (UTC)
Received: by mail-qv1-f54.google.com with SMTP id mm5so6901861qvb.12
        for <iommu@lists.linux.dev>; Wed, 08 Feb 2023 04:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2ONYko8lOL1nBDH25lfplxwHP04VK/kwi3k1cUKn+E=;
        b=PQp5h1oc5pSIiwKvZCj1sK3/ln1MutbovvxQ1C1NyhFKNPdXeEGr/ow18JKKL2wTxf
         LMVIxK7H6AegLdykrYg1HvVo2xybmpw5Ncz2bsWFn/5zNWdyybHVBAV/60Er7aryqrrr
         3+RFCLyxAvTR3BBwSdF7ZEvofTaJBwsjAoqdvjBiq/cdfuyOadKlSS+N82JHyvOFXafd
         uugZi8vftI95yQQNcjPOHJtNoFqnfH8zoQ1kz5DUcQ5Vb5N+p2GCnxB1n2c9fSYTIYTd
         u6aZ3acNo9etlUEqbWUPJRWothblIdDcGVP7+nSEOn2fBYWU1X9iv+2NQ7Uv0iGkdlFW
         br6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x2ONYko8lOL1nBDH25lfplxwHP04VK/kwi3k1cUKn+E=;
        b=F+Kas4zd7gyT07FTkv5v6z0Kk1kLaOyzU8uLtMshVtDfWA4K58Qjc0iSb664nfrzF9
         W4o2T2NzFdWsy6ZiEJoad4HkVY2O8ca3AFQoFp5dUzOKMbyKvWhTcuqoscowWn4yPjbn
         VBoqJrcsWiJY626g2JLOhyt8vuG9eYSfXxiAO3vSg1pvGQ4nA8DARL91BxYnGkTIS+02
         csw9ySeaaXR2BMBnRzv1EgKYKysQbwYe0+PVMe/X9mCVa9TjpnynCfNRON9cl3ZhaMPg
         QCkD4ZuF65T9dffVjVWxcrXmCNojDfM1IjcRmotIaQ7VDzL6y4gz/8d+5u2dc8ZTOrTM
         gphw==
X-Gm-Message-State: AO0yUKWm5uyRGt5quxY7hsu0ox0wiCVYwnQ5CVyZEkX+jvw9ua/APg6o
	j7D+fhzTKU9KDDOYqB7Atx6QSt45Dx8aMgVoZy85xA==
X-Google-Smtp-Source: AK7set9fcPkR3BEe44mOMFljqcE5dePAc8nQVXRrv9prnVcoAyBUeN5S8E8QrSNgSMq8cxcr62jPqo+N+5d3nJF6Frc=
X-Received: by 2002:a0c:8c81:0:b0:56c:11df:b0f0 with SMTP id
 p1-20020a0c8c81000000b0056c11dfb0f0mr545525qvb.81.1675859485960; Wed, 08 Feb
 2023 04:31:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230201125328.2186498-1-jean-philippe@linaro.org>
 <20230201125328.2186498-20-jean-philippe@linaro.org> <Y+JOhEfi8mu1RuOt@google.com>
In-Reply-To: <Y+JOhEfi8mu1RuOt@google.com>
From: Mostafa Saleh <smostafa@google.com>
Date: Wed, 8 Feb 2023 12:31:15 +0000
Message-ID: <CAFgf54q+R6nQBUAz9Quj8pQiTgKe7R_7BdQ=PWWay0WqDVzL1Q@mail.gmail.com>
Subject: Re: [RFC PATCH 19/45] KVM: arm64: iommu: Add domains
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: maz@kernel.org, catalin.marinas@arm.com, will@kernel.org, joro@8bytes.org, 
	robin.murphy@arm.com, james.morse@arm.com, suzuki.poulose@arm.com, 
	oliver.upton@linux.dev, yuzenghui@huawei.com, dbrazdil@google.com, 
	ryan.roberts@arm.com, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 7, 2023 at 1:13 PM Mostafa Saleh <smostafa@google.com> wrote:

> I was wondering about the need for pre-allocation of the domain array.
>
> An alternative way I see:
> - We don=E2=80=99t pre-allocate any domain.
>
> - When the EL1 driver has a request to domain_alloc, it will allocate
> both kernel(iommu_domain) and hypervisor domains(kvm_hyp_iommu_domain).
>
> - In __pkvm_host_iommu_alloc_domain, it will take over the hyp struct
> from the kernel (via donation).
>
> - In all other hypercalls, the kernel address of kvm_hyp_iommu_domain wil=
l
> be used as domain ID, which guarantees uniqueness and O(1) access.
>
> - The hypervisor would just need to transform the address(kern_hyp_va)
> to get the domain pointer.


This actually will not work with the current sequence, as we can't
guarantee that the domain_id sent later from the host is trusted, and as
the domain points to the page table this can be dangerous, I will have a
closer look to see if we can make this work somehow.
