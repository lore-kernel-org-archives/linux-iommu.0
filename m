Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96495171A0
	for <iommu@lists.linux.dev>; Thu, 27 Jul 2023 14:04:42 +0000 (UTC)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-40550136e54so314051cf.0
        for <iommu@lists.linux.dev>; Thu, 27 Jul 2023 07:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690466681; x=1691071481;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wro4I9SuyvTTnQF8s+nnyO/Nqnj1OCBzGy+P8LoI4UY=;
        b=OJDYpXYw1QZ7Cg5AQAdCH8DZAa7Q8WNl/ren99kQfwSe09jenn2kbXtQz408Cyyuql
         IMOcJADDxHflTG6QlBd+An7Bbti8OdvcQ1YX5SE0BlAE9o4okAArEymT4PsCa9jON0V9
         KemTA9eqriiBQFFkwXE6Sz0GXtTF2lMEnWHvTpXfuS2g8tGnyZm7/+ZFMtOmWXqP6ZvF
         VJ+yAfBGnYnKCHsDj+tyP5JSIYYHmLd6+m5/iIKQ4Hh9ZQXSiCaoCitW5rNcIvbXehhL
         YG1dnZ2VvxrqSzHtitOs6z6pthtt9hQTrKiAF2tn1eZ8F9DDqHYXeR8Z6WBJWpE0MRJt
         4qpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690466681; x=1691071481;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wro4I9SuyvTTnQF8s+nnyO/Nqnj1OCBzGy+P8LoI4UY=;
        b=VErSEPYPLYK/7CkzdRCGyP4TvnMxKasUoZ8BXDJiHdeYMLPv8+VEq7UTt+wCYHwDas
         hkIgZ2Ww+AG7AsA758D255Ciy4YBAvCKLcr8k/7hLDDhp9Wly/tgtlnZG9GFHFQpRASe
         3AzdATXbExdDvTtdgyy9nCpK1OZGmgAx10PQV1bJPstTCdQoH/WAFHamdFWr3lGz/c6K
         mVRNVHWcGToQMTJCSjIJcaB7dMSATgxe5KX097BfTINkg8dtqRp3nnMqybIbTJ9bCmiq
         ABhS84Jch5l23adu8Qcmf8X33pIE0mS7X5f5aSXXj8auhzFVfCU3Tkh7lahP+uKtpAKc
         Mr2Q==
X-Gm-Message-State: ABy/qLbhDtbGGuf1bOStck79QpMdkhcFJwRHxMNyvcH/IOwI3u24WPzN
	bXAzpqqQLVqHEsS/z4Tex0EPcPu2Tq3GDQMJWV/LTQ==
X-Google-Smtp-Source: APBJJlFbpq9dEBh60onyb4nGTfsAwxbFVxzP9N2IZ58rh+h+naOWkc4TLzSg2cYP3r3qzM+MAE1Nv8ZvTAhWEsNtMZk=
X-Received: by 2002:ac8:5815:0:b0:403:f5b8:2bd2 with SMTP id
 g21-20020ac85815000000b00403f5b82bd2mr191469qtg.9.1690466681153; Thu, 27 Jul
 2023 07:04:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAKHBV26wi+xKnNjo-R+QOcVLPH2KJTFP+mF4CW1xE61nOdF5GA@mail.gmail.com>
 <ZLAKQw+DzcpSRSyi@nvidia.com> <CAKHBV25YadRVFiag5z5Yc13L093ScWkCjAOCd=VuGm2RUaDyzA@mail.gmail.com>
 <ZLApQjaqoOshT2TJ@nvidia.com> <CAKHBV25BRWTxXO0YTGq3q1OdMQHAzop8BqJJaa9CHxdQzxnNbg@mail.gmail.com>
 <ZLFLyh1b+wiqb7Ql@nvidia.com> <CAKHBV24zQ+4waZgsYV08LzeMkjze1gTcwvEv5uL8RM1GcBgrzg@mail.gmail.com>
 <ZLU0IZJr6WSjknHf@nvidia.com> <CAKHBV25QZn9xApRT+=oAtwQRAjCD--S46uXRDwW+E5=at0ESQQ@mail.gmail.com>
 <CAKHBV26sRpFJv8-_f4n2jsTKiOgnHF0_FZ07KBbVaueX+T2kWA@mail.gmail.com> <ZMJa3kGHD2iE0/za@nvidia.com>
In-Reply-To: <ZMJa3kGHD2iE0/za@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Thu, 27 Jul 2023 22:04:04 +0800
Message-ID: <CAKHBV27kr540gTDbgGwzYt6_X7J=NfdNONVe-_y0-XpAQjc4jQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/13] iommu/arm-smmu-v3: Add smmu_s1_cfg to smmu_master
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org, 
	baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Awesome that helps a lot. These are the patches I have in mind:

1. Move ctx_desc out of s1_cfg
2. Replace domain->s1_cfg with `struct arm_smmu_ctx_desc_cfg cd_table`
3. Move stall_enabled from domain to arm_smmu_ctx_desc_cfg
4. Accept an arm_smmu_master instead of an arm_smmu_domain as the
parameter for arm_smmu_write_ctx_desc
--- arm_smmu_write_ctx_desc can simply get the cd_table it writes to
from master->domain->cd_table; this get's replaced by master->cd_table
in subsequent commits.
--- SVA is weird if we cut changes here: it iterates over all masters
a domain is attached to in order to call arm_smmu_write_ctx_desc(),
which ends up writing to the shared cd_table since in master->domain.
This becomes more sensible once masters stop sharing the cd _table in
subsequent commits.
--- arm_smmu_write_ctx_desc is used to sync the cd for all masters the
domain was attached to. Now that SVA is calling it in a loop, and to
break the dependency on arm_smmu_domain, we should only sync for the
master passed in as the parameter
5. Introduce a skip_cd_sync parameter to arm_smmu_write_ctx_desc so
that arm_smmu_domain_finalise_s1 can skip the sync_cd before the
cd_table is attached to the master. Before the previous commit,
arm_smmu_domain_finalise_s1 was calling arm_smmu_write_ctx_desc()
before adding the master to the domain->devices list, which was used
by arm_sync_smmu() to issue sync commands to masters. This
optimization was broken by the previous commit since we stopped
depending on domain->devices.
6. Move cd_table from domain to arm_smmu_master->cd_table.
