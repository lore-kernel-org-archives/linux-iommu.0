Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839F079DD
	for <iommu@lists.linux.dev>; Thu, 13 Jul 2023 08:35:33 +0000 (UTC)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-40371070eb7so177831cf.1
        for <iommu@lists.linux.dev>; Thu, 13 Jul 2023 01:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689237332; x=1691829332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUiEY1fSBTwYVk97ONcADqRi9c3ar1khFfmJ+HnVmuI=;
        b=gyanBDz/w9wX5l7O7NXT48CRH/6WxciJmda5d9B2FPcbw0+Gq46F1tkWLT74J78W/X
         mVGSg1kDkkO4CaFX1TK16spI+QMaC/5ySbVBT/E46wzmRpLFQPAEmyblcP5hEZxqaPbJ
         /6aqM6jyOSVYK/J9EDxvU3NQFqRWjiyXnqL5gF6Mn59jAuO5M2o/L5oDi3f2DnNmQMVZ
         7aFhnT7eeLSbohY7HpBsfSR+1L+/QZ5Tn+Ap2hDLgYTBz6wKpbu0XeAonfxXt4Pk5UHo
         jUnEwrpN3PRA9rCxxZq1vo7nAfaECJBfSrti5GFE8rWa76KI2+hjdfuBzV0xeJpHQRry
         BzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689237332; x=1691829332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CUiEY1fSBTwYVk97ONcADqRi9c3ar1khFfmJ+HnVmuI=;
        b=MDuHMjNFs8IcsqihOX2jgxJzuDtkD6k7zHzTNd9Iyt00hEx5hStOTzT6dZSsVi0VxY
         0CAPHSwAtqyq7aL+2qNykQO6MuIqui2QRAf21ksfuSYLUFJO1aHYjVvBDpkiZG4IQxtl
         s+oQRGlfOB+wVdsv4tOZS+PhrZAaAMl5Ji6qVAGdPQKZw+sBr23tlyev7zsqScVTb94v
         CteYeDtjw4j0at4yG4dPhT5EYOinnMaMEoh/2FDh0rnmhtbEbzg7trv7KoIJ5I2ZjHfv
         guVOG1tG0P7TD3q4xIaBXIeuDUvBgkjde+96ZNF/OCIM/rzj+Ku/ZegrXuU9MixllO9L
         Yifg==
X-Gm-Message-State: ABy/qLYILpb410GFwIR+2ESwAX3UE0hhOagQf5bZwSjm2SzY3Z0XTU/h
	YnQeveUoTSg97kTJVw95atHw85KymxmUzNf0mt+LHQ==
X-Google-Smtp-Source: APBJJlE8ZmsIj2Hzla7BztX6LrHSwBFzu2OcKKW8iqQh5D4S5j3zr68JLR331RxxDu7qRE6yXsUYFC+y34hqT56X5Qk=
X-Received: by 2002:a05:622a:245:b0:3fa:3c8f:3435 with SMTP id
 c5-20020a05622a024500b003fa3c8f3435mr435860qtx.27.1689237332162; Thu, 13 Jul
 2023 01:35:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com> <20230621063825.268890-3-mshavit@google.com>
 <ZK9RycgNAVrxe343@Asurada-Nvidia>
In-Reply-To: <ZK9RycgNAVrxe343@Asurada-Nvidia>
From: Michael Shavit <mshavit@google.com>
Date: Thu, 13 Jul 2023 16:34:56 +0800
Message-ID: <CAKHBV26wi+xKnNjo-R+QOcVLPH2KJTFP+mF4CW1xE61nOdF5GA@mail.gmail.com>
Subject: Re: [PATCH v4 02/13] iommu/arm-smmu-v3: Add smmu_s1_cfg to smmu_master
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org, jgg@nvidia.com, 
	baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2023 at 9:22=E2=80=AFAM Nicolin Chen <nicolinc@nvidia.com> =
wrote:
>
> > Except for Nested domains, arm_smmu_master will own the STEs that are
> > inserted into the arm_smmu_device's STE table.
>
> I think that the master still owns an STE when attached to a
> nested domain. Though an IOMMU_DOMAIN_NESTED iommu_domain is
> an opaque object to the STE in the guest, the host still has
> a real STE for the nested configuration somewhere -- and it's
> likely still to be owned by the master that's attached to the
> opaque NESTED iommu_domain in the host kernel.

> I am a bit confused by this naming. If only master would own
> an s1_cfg, perhaps we can just make it "s1_cfg" and drop the
> s1_cfg pointer in the next patch.

Could be that the naming is causing some confusion. This owned_s1_cfg
is very different from the s1_cfg set-up by Nested domains in your
patch series. It's better to think of it as the default s1_cfg used
for DMA/SVA/UNMANAGED domains. Because stage 1 domains represent a
single page table, it doesn't make sense for them to own an entire CD
table. In contrast, nested domains map an entire CD table and it
therefore makes sense for them to own the s1_cfg representing that
table.
Would renaming this as default_s1_cfg make more sense?
