Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8664A1E1C0
	for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 17:15:51 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-40c72caec5cso23621cf.0
        for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 10:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691687750; x=1692292550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JR+DvT908I1ICbPFaZN70WEoRAJPsTY/Ml+jiHbe598=;
        b=O+8TJEX29ntsMx49vxz9eDxi5qRTBy/PfPdi6jrhS0S87A8dAfMat1Z/VRsbaJMGf1
         xBhIAvwZJvFA3fR+8a2SG7O8fJN3vHnWf21qEmqkgndgNOJEM87LCgXyOpq+LjsbwWAb
         wDaaT6YZh11NFKOcuoVGMDF1gljVmFxtgW9yspM8EdcB1iK0X1TYemcuQJq0wgq5sH7W
         0S2Y0BY530j6PNoP6zb7FhRmLSa4rLOh1tnpTu5b7ber8Nm+HlPo/FZVNO0ZG1jpj0MI
         GOzouVrrJTlcKHP2kMTp9His7UWWPZ09f9/i2zY4trGe1sD43wxXXQi1vStDPoWoovMl
         AlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691687750; x=1692292550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JR+DvT908I1ICbPFaZN70WEoRAJPsTY/Ml+jiHbe598=;
        b=T2kR+KnGn/1jFjXDFQ6UCFrKjhMxurovD+IlE0iux76hV86Bu+pWbqrNJ6ojq/4tTH
         3KuSWC2G4BlLBLlA+AS7RjcprUgCBF1II2/M0va3Bo7DQWYNvcQE1NZqk06TDBroyeXq
         lUL9lrqakxb1W2QrcgHsDjnRv3H6xHSHlswVR+jwZ+tfdybd5DP8x/2WomPWj8k+CM1n
         UR6JcVsvnXyJvfc+fEbBAvjFB3G3sbxZVp87kyJ3UYIxDwvI9bimqvMwgsonNDvY7ryA
         wF32ssA5YA0FC0bTZEGmSH3Z7leMvxTZGfxDQ49WmemTu6EkiGFaEtQn+qlpfVX9bReg
         uJQQ==
X-Gm-Message-State: AOJu0YyGxZ0Nj5NASs/h3w5tbKNx6dJEShEYaWM9ZLptcPUSNsY6mv8c
	qG+Co15xpIe7nKTlPIsJ+VQUNYBu/wbZoS6CEuTnMQ==
X-Google-Smtp-Source: AGHT+IF2w8NqxF/8920Zh5iOHLtA/IWiK7hewBUqrSrDqDeLZHZICGqLq8Oz6cl/5J93KUbEpTpBSh8nrJDJ2iyZikU=
X-Received: by 2002:ac8:7f86:0:b0:403:96e3:4745 with SMTP id
 z6-20020ac87f86000000b0040396e34745mr11341qtj.20.1691687750089; Thu, 10 Aug
 2023 10:15:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230809011204.v5.2.I1ef1ed19d7786c8176a0d05820c869e650c8d68f@changeid>
 <20230809134941.GA4226@willie-the-truck> <ZNObxeogswAYyDQ5@nvidia.com>
 <20230809145542.GB4472@willie-the-truck> <ZNOr0ggoO9kXHJWl@nvidia.com>
 <20230809162254.GB4591@willie-the-truck> <ZNO+QVkXcHG78KG3@nvidia.com>
 <20230809162749.GA4663@willie-the-truck> <CAKHBV27JAFb56VkHJO2ZBZt=25aVregeiMjO2YJrg_fW9HQbYg@mail.gmail.com>
 <20230810094323.GC5365@willie-the-truck> <ZNTSU1Jm6OsauygC@nvidia.com>
In-Reply-To: <ZNTSU1Jm6OsauygC@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Fri, 11 Aug 2023 01:15:14 +0800
Message-ID: <CAKHBV254QmO3iXyEL6w0PqvVofm_UCDd13LKmpbhU-cEORB5ww@mail.gmail.com>
Subject: Re: [PATCH v5 2/9] iommu/arm-smmu-v3: Replace s1_cfg with cdtab_cfg
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	robin.murphy@arm.com, nicolinc@nvidia.com, jean-philippe@linaro.org
Content-Type: text/plain; charset="UTF-8"

> > > What dead code? Is the deal here that we keep the field, but still
> > > infer the value to write from (cd_table->l1_desc == null) in
> > > arm_smmu_write_strtab_ent??
> >
> > Keep the field and write it directly when populating the ste (i.e. don't
> > infer anything), but the field moves into 'struct arm_smmu_ctx_desc_cfg'.
>
> Yes - the 'dead code' is that we introduce storage for a field that is
> always a known constant (STRTAB_STE_0_S1FMT_64K_L2).

I'm not sure we're on the same page here. s1fmt could contain either
`STRTAB_STE_0_S1FMT_64K_L2` or `STRTAB_STE_0_S1FMT_LINEAR`, and this
value will be directly copied in arm_smmu_write_strtab_ent.
