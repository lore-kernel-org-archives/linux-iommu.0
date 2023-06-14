Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78826101
	for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 09:43:45 +0000 (UTC)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-3f9a81da5d7so203571cf.0
        for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 02:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686735824; x=1689327824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qu3MImrtsoFSQo9D12BQh0F1vRw24uhJW9sO5eRWsw=;
        b=Ke9sBRa+YAXRQkgGZB2BAtw/UiC0JslVzSUE6ilG43GOBfoOB7pSJjAHngj0d/zn92
         7TGRmOW/rZ4LBKRoJDeu5so6xf6mGwfmGxFgRnbI+wEUraGpS8VRPTs+gkeeWluhpRYR
         DfaIpb92Q7Kclt87Mt8B8LRFPLbkn61Lq+XuzonNHPiUPS+fopUx2iwzGb924Ojd+AFv
         V93dzyIcA1bWc52Y+EJyxgDVa+2QqFjMWH/E1m9dfr1fY12yI9cPOgaIbzzSsqjl3Dit
         V+dhuLogegraNawK2JGcK/0D8DZhDdm9NPnpXj7PU7Yo0qdJIBzVUoxlRZBD+BI1DrJT
         QFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686735824; x=1689327824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3qu3MImrtsoFSQo9D12BQh0F1vRw24uhJW9sO5eRWsw=;
        b=KBtp9yRLZrR6q9cZKlTfKbDiLNYiDZLg+sxrLM+Fzm/j6vpZD4wz19xRal9DMy8yNN
         ZOcoX3BfyehQc221T1h5G1r+fOyqw8hRCu6KFH6xUWrAU1TcrE/GFtm7sZaJiZeJ/CM2
         m3XNctEsqjdCdvHUmieT+QW1u4u8iOVYv3MZAOnpG4w+b12tD0o2YT3aHFm4ZJwGUrcK
         aw4Y0DAEFJ6OkjAx5ThOpG3gKWgIJMITyNLwTThdDFQFdNd8E8kU6TlbAV6Z6MCOfEh8
         nlLypD+kitW+/88NlPJPbkki+Besy/Ar3cZMxnryy76SdTqRS0ZnMvo46/D9qgg8WNMW
         J8qQ==
X-Gm-Message-State: AC+VfDwz8/q5vzL3tyqhmKUiHkOo0UccomIDSocYKLwiCAsyOGrwT8bc
	K4SBT+QX3Wua7rB7BhIt/WDeykEzjqVauYysrdOz8w==
X-Google-Smtp-Source: ACHHUZ41slMgNxuS4zG5bSvRmQZARD+F3lz3ob/djkBULk2Zy59tAVxnoqZnBBqzA+ArgvDNoBALza90DXs19QLITtU=
X-Received: by 2002:a05:622a:188b:b0:3ef:2f55:2204 with SMTP id
 v11-20020a05622a188b00b003ef2f552204mr202066qtc.6.1686735824346; Wed, 14 Jun
 2023 02:43:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230606120854.4170244-1-mshavit@google.com> <20230606120854.4170244-15-mshavit@google.com>
 <ZH9oQMmI8CezMCnx@nvidia.com> <CAKHBV25eDNXEu+6GWDJqpw1h5N-Jq-GPzf81kNH1dyw3Z=KsZA@mail.gmail.com>
 <ZIBxPd1/JCAle6yP@nvidia.com> <CAKHBV25K4BCewMdp3HcRtaX1iNhVpxL_6dMwp1_fmcQ5RWpKBQ@mail.gmail.com>
In-Reply-To: <CAKHBV25K4BCewMdp3HcRtaX1iNhVpxL_6dMwp1_fmcQ5RWpKBQ@mail.gmail.com>
From: Michael Shavit <mshavit@google.com>
Date: Wed, 14 Jun 2023 17:43:08 +0800
Message-ID: <CAKHBV25CO-tgxCa6_=yZLGD29hNCoP9s3q0tGy3w23j2N4b9Jw@mail.gmail.com>
Subject: Re: [PATCH v2 14/18] iommu/arm-smmu-v3: Support domains with shared CDs
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org, nicolinc@nvidia.com, 
	baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 14, 2023 at 5:17=E2=80=AFPM Michael Shavit <mshavit@google.com>=
 wrote:
> The arm-smmu-v3-sva.c implementation avoids all these problems because it
> doesn't need to allocate an io_pgtable; the shared arm_smmu_ctx_desc's
> TTBR is set to the MM's TTBR. One possible solution would be to make
> the changes proposed in 1., but only allowing SVA domains to attach to
> multiple devices:
> 1. Domain functions only accessed by arm-smmu-v3.c (such as
> arm_smmu_iova_to_phys) can assume there's a single
> arm_smmu_device_domain per arm_smmu_domain.
> 2. Domain functions also accessed by arm-smmu-v3-sva.c (such as
> invalidations commands) must iterate over all arm_smmu_device_domains.

Or rather, arm_smmu_domain would hold a list of attached smmu devices,
but only SVA domains would be allowed to have multiple entries in that
list since the other arm_smmu_domain fields are tied to a single SMMU
device for other domain types.
