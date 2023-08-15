Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B981864
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 05:20:50 +0000 (UTC)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-40a47e8e38dso117071cf.1
        for <iommu@lists.linux.dev>; Mon, 14 Aug 2023 22:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692076850; x=1692681650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8rldmZbFQsdFeS9GjoqGMHcF+DWT+Us0qlghVZOIyQ=;
        b=0jsmJBp+rB0QHzuCJc+wW+cKrZ99ZF3C5PhU9hnj2pYiKV0RTwO5iPjtRUk+tFIwYz
         qaz6+Km88XGrbKnCMuyMIt62JBK/zCZomIffpie+6l7I07pwx6zoyIwYwnWe7bl4u4vJ
         suu1OKmj+RRoJ5JcdXr0HnTN5GVzbKcRs+9wGFIe57LqPGexwL6yA7o1mSpDCg0dVb3h
         n5cio5sPjIkjYwem+UvovKPjhsZDt9RYZBFGeTmIpYuQdz5knKSxpgtWPmAstmcOPNTO
         yMdku0D10bP9qHUH4fs/HdrJxPtdkOTazLbsbngH6t7J6edMQ/pSKIWpy1ZXGSG1n6hb
         q0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692076850; x=1692681650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8rldmZbFQsdFeS9GjoqGMHcF+DWT+Us0qlghVZOIyQ=;
        b=lETqCOJKtmdl8Dl9dLZnZjChbLk2nILBZkXe9GWjqqIM4qVIhaSvcT6wTvyYjTeBtV
         DT625n4x5fTpYHuU7kbcP24ZZwpUxPNlXkmLPjSGiyl+0HZKjm0u5CAVoKsqPj+B2raC
         bQthU9UmkzmhKmVvIcpToVIXcRQjC+ofp9j13EH4bBwB6qv5PW6de1mI1yaTNChC5YVV
         01IBwyYVwu1wgmUOPXU0R0BJzDffQPUJAQLRnBObFH5vJR0gOn/tbyz0KJ76XjyW2PFV
         hROeQnK7vahbNJO4IzsYV3Jhc6w55JzKTGCnPmQbZVZis2bq6NPn2OxeSOogeCNTyY9d
         HBkA==
X-Gm-Message-State: AOJu0Yw7Vx3efSpKu0TZ+lNjIY8z4+Li3eATTSX2Tlz7GNsVWrS2zZGV
	NG1O44f1YvqKC0XlKWcBI2Vi8lObiqwpY8j4P77RdA==
X-Google-Smtp-Source: AGHT+IFZAtCioCc6H5ESRtOUJNo3u9I3NatUhzr9FskoqmSyhlPqKWZm1LKLKijfMH1VvuR7PEya8GQDPyMrOzHM7ig=
X-Received: by 2002:a05:622a:1303:b0:3f8:5b2:aeed with SMTP id
 v3-20020a05622a130300b003f805b2aeedmr603740qtk.21.1692076849682; Mon, 14 Aug
 2023 22:20:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230808171446.2187795-1-mshavit@google.com> <20230809011204.v5.5.I219054a6cf538df5bb22f4ada2d9933155d6058c@changeid>
 <20230809134959.GB4226@willie-the-truck> <CAKHBV25CQYfqm80a1ztHXn3s6kj7KCuJBwJz4EZk5cog4n6R+A@mail.gmail.com>
 <20230810144051.GD5795@willie-the-truck> <ZNUEuIlPmrckwMyn@nvidia.com>
In-Reply-To: <ZNUEuIlPmrckwMyn@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Tue, 15 Aug 2023 13:20:04 +0800
Message-ID: <CAKHBV24SLBNw-yWn3m6BtvvHUgD0h1e1QkEb1LrUcWSwpR85Yg@mail.gmail.com>
Subject: Re: [PATCH v5 5/9] iommu/arm-smmu-v3: Refactor write_ctx_desc
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	robin.murphy@arm.com, nicolinc@nvidia.com, jean-philippe@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2023 at 11:39=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> w=
rote:
>
> Actually, I don't think this even works as nothing on the PASID path
> adds to the list that arm_smmu_write_ctx_desc_devices() iterates over ??
>
> Then the remaining two calls:
>
> arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
>         arm_smmu_write_ctx_desc_devices(smmu_domain, 0, cd);
>
>         This is OK only if the sketchy assumption that the CD
>         we extracted for a conflicting ASID is not asigned to a PASID.
>
> static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct=
 *mm)
>         arm_smmu_write_ctx_desc_devices(smmu_domain, mm->pasid, &quiet_cd=
);
>
>         This doesn't work because we didn't add the master to the list
>         during __arm_smmu_sva_bind and this path is expressly working
>         on the PASID binds, not the RID binds.

Actually it is working on the RID attached domain (as returned by
iommu_get_domain_for_dev() at sva_bind time) not the SVA domain
here... The arm SVA implementation completely dismisses the SVA handle
(I also have a patch to fix this ;) .  Need to find the time to polish
and send out).
