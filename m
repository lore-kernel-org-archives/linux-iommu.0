Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22111F16D
	for <iommu@lists.linux.dev>; Thu,  3 Aug 2023 17:56:49 +0000 (UTC)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4036bd4fff1so32891cf.0
        for <iommu@lists.linux.dev>; Thu, 03 Aug 2023 10:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691085408; x=1691690208;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GtiZwsSABgt+mK1yvfb8u9R5xpab/El+WHboQ+axzsQ=;
        b=u57XpfzCiX3ohGkxPhXVfjvBEIcIBKDB16BfSrMrVtZAk1KpeniZS+lq44SmE/cHMO
         7XWvFZ/cpnlEpg3gageco3dCvWMs7P8j4kuGhqFK0As+mmk8EkUksLMYini0NGWm7qR6
         Q6lyf5zauEmeGJ1QPFbIW5hvQQUPMmEXhKNIPju6yW9LAS8qkv25vaV8PbTMafiZNMGV
         JbauaTHFsD8Q5AV59n7mYZNIqBfd5GUlUjuB8ZkevxHpZZaC0ZuyfUbyDkiVVEuXQWrA
         Im8vOSf1oJBsUEiy9/8FK4Z4rkEyOIhUhUpWo5o3YpquUAit5v/C9UuVACCoVE6Srr6a
         AfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691085408; x=1691690208;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GtiZwsSABgt+mK1yvfb8u9R5xpab/El+WHboQ+axzsQ=;
        b=TAhcaFi+xtdZn4SnB1A/9gpyjJtt+IupvWqbOoenxwb3mKCeCn/aJ2lrlgaECmWYoA
         Knnw64BN7Rr7FMue1BixXivB3n+h3Ji/NFX6kLzR9a/fy1wJtv/Awyj+k7z6gGmqEOA6
         sga6gBPemq5Qk46jaOxhJsu+sv9PXikbT7jPJdZ2gtNMSYPa95QBcGU0cyDR/e0h4Dlt
         byvexAyupEfRlZVee4Nb4/xfcOED+1kldJweGi2fZmQ6fo9ZSZGWW6/1nKQLC/yaE1NG
         IqXqtjO9qG4IGwRZN5Pp0ELmBzijnZnyJTLfmT8OXCAJM4uQDvoj9q7LphpxBJtrXRtG
         tIuA==
X-Gm-Message-State: ABy/qLbeyXMc9KrvKi3AcEgh1zeH1FhVmRARSP+Xt60UPSjc4Snu3sLR
	5lRsyRf51x8sJ+h9E4Vfp2NkzW1fgHLeu36HF9YS2tN8EHjVjxeRRCg82ZSQ
X-Google-Smtp-Source: APBJJlGl35bf2QzbQpBWgDvUdXpFzqk1G3zZk+vXJ2EaPJD5u7BX/byeBmEHUnRs79tVKj42r2plDYVADJIZPS5VRL0=
X-Received: by 2002:a05:622a:13ce:b0:405:47aa:7ffd with SMTP id
 p14-20020a05622a13ce00b0040547aa7ffdmr1629841qtk.19.1691085408201; Thu, 03
 Aug 2023 10:56:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230802163328.2623773-1-mshavit@google.com> <20230803003234.v4.6.Ice063dcf87d1b777a72e008d9e3406d2bcf6d876@changeid>
In-Reply-To: <20230803003234.v4.6.Ice063dcf87d1b777a72e008d9e3406d2bcf6d876@changeid>
From: Michael Shavit <mshavit@google.com>
Date: Fri, 4 Aug 2023 01:56:12 +0800
Message-ID: <CAKHBV26OsQYRCifuD0UjSf5uqcvMSK2tizjFULLv8DTdz0zD2g@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] iommu/arm-smmu-v3: Move CD table to arm_smmu_master
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: will@kernel.org, robin.murphy@arm.com, nicolinc@nvidia.com, jgg@nvidia.com, 
	jean-philippe@linaro.org
Content-Type: text/plain; charset="UTF-8"

This patch introduces a subtle bug.

Previously, the arm-smmu-v3 driver could get away with skipping the
clearing of the CD entry on detach, since the table belonged to the
domain and wouldn't be re-written on re-attach. When we switch to the
master-owned table model, that CDTE in the master's table can get
written to with different CD domains. When the CD domain get's
switched to a new one without first being cleared, arm_smmu_write_ctx
will mis-interpret its call as an ASID update instead of an entirely
new Cd.

This bug was handled by clearing the CD entry on detach in the
"iommu/arm-smmu-v3: Refactor write_ctx_desc" commit before it was
split from the set_dev_pasid
series(https://lore.kernel.org/all/20230621063825.268890-5-mshavit@google.com/).
The change was lost when the commit moved to this series however. It's
splitting hairs a little, but that fix probably belongs in this patch
instead.
