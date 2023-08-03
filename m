Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B54156DE
	for <iommu@lists.linux.dev>; Thu,  3 Aug 2023 10:16:02 +0000 (UTC)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-40c72caec5cso260381cf.0
        for <iommu@lists.linux.dev>; Thu, 03 Aug 2023 03:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691057762; x=1691662562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOr42OTiqwuGgbJm6LEEziFOJyncUa+T/gr4vCNaqGY=;
        b=ceF0aZ1kYRIaCjRP0tTmmcv9Jhn3nKp2gYfVyWfgiTdf1RNanXYgBWp8FEiGOjhcm1
         LfwFPktlPXciFzr01X1Q5xcbAlWhYLsI6rMJCvi9ccMJVdLSoXgGdFAL/LPEN++JCD7X
         Uek/nqFOe+Bl+dSQ54ncOhCUo4B9r/KH3Gx58AGZHZ7lr+150oqpMgSJ+YpCopoYcb4j
         C9IfDSzrJ+rQqSrz7tCS3bIS7IWW+ZRmIH5tP17FhkVOYIrU8H2FzBaYD4UtGPB8pYzZ
         OSVX6FP/C9CYaCeEzj+CVy6hPOOc1AyaAAO9wM9Hhpd2Ju2tW/QCE7hFFK5qc8YbLvYX
         u/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691057762; x=1691662562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOr42OTiqwuGgbJm6LEEziFOJyncUa+T/gr4vCNaqGY=;
        b=GhjAHu9cqHd+c6NieQYf9Dn87oqKj8PbqaG8a0pEMae19z2GrxYviqN58VNUKn//FC
         RXK7AwpUQkmCw4YekOexBzzTAKiUUoay13fNgfX8zWYzTF7XJM5+MGnaDCLflzfcBMQ1
         kVLpj+0O3RcgUKtuduNB4gKRu3trBaGZlqpovu01oGCmLR/Nxjl+mnaHQ0N9fwA34UP5
         eENTwqhwoBavjHGUkLtaB10auVjppqwCNK/f5/k8ShyHE2q/onWVD/oWUFuq7WbGfHtA
         gWTNT2ymK3ATCax83gS7/w+sEoCMd9AecOFJ75hS6T0PuxKH2b16UqS5Y1O6NG058V4K
         pNVw==
X-Gm-Message-State: ABy/qLas4qj9lXVf6sF0kZtxIcsus7OcUjUj+N2XvbTsh67oG3UalRXD
	z8rJCRkeKO531+J+zTb1VUq557no8HhaBg4thWmpvl0eVVhUatQB30kCUDo2
X-Google-Smtp-Source: APBJJlGwUqTyg1oUt5euBh0ut1AeSopxrW/THLJ12+7fGBSLProZNbKZm/LOkBs7PJ1rjxVr7w2pnIqRnnJfjYccDuI=
X-Received: by 2002:a05:622a:1aa2:b0:405:3a65:b3d6 with SMTP id
 s34-20020a05622a1aa200b004053a65b3d6mr1207827qtc.13.1691057761676; Thu, 03
 Aug 2023 03:16:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230803101351.1561031-1-mshavit@google.com> <20230803181225.v5.6.Iff18df41564b9df82bf40b3ec7af26b87f08ef6e@changeid>
In-Reply-To: <20230803181225.v5.6.Iff18df41564b9df82bf40b3ec7af26b87f08ef6e@changeid>
From: Michael Shavit <mshavit@google.com>
Date: Thu, 3 Aug 2023 18:15:25 +0800
Message-ID: <CAKHBV27-fkATKL9OyVgSG4M2vxvT0AyUVFqiwqpV2RUu1OArxA@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] iommu/arm-smmu-v3: Cleanup arm_smmu_domain_finalise
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: baolu.lu@linux.intel.com, will@kernel.org, jgg@nvidia.com, 
	jean-philippe@linaro.org, robin.murphy@arm.com, nicolinc@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 3, 2023 at 6:14=E2=80=AFPM Michael Shavit <mshavit@google.com> =
wrote:
>
> Remove unused master parameter now that the CD table is allocated
> elsewhere.

This almost certainly belongs in the CD table patch series. I'd like
to move it there if this commit looks OK.
