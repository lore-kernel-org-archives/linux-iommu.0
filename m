Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAE31ADFF
	for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 09:34:30 +0000 (UTC)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-407db3e9669so166011cf.1
        for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 02:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691660069; x=1692264869;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=09uuo1ZPo0trOooZ9N2aLprRug+RrXt+K+nt06yCzbc=;
        b=RRBD145T1zT2odnIQEQhlWRI7J8Xc1aCZk0Dg3j3ogcccaxjEOo/ABl0bZAXvODwxM
         OAcQA431t/WWpS+2upKOkX+dFXyRv/n6bXZuYPWHkG2Sn4R+pFx3SjK8Khy4do7aemvZ
         Pk7b8Pi6K+SYogTsPnqtjOiJy/iD9HHd1vpL1FFoYB9cYsTsEDExS4DNtHmZwCd7jwt+
         0/30r0dTvcsqib3vvoSJyqvXerw1Cwm6+MEjTYduwq8V9YhcUVBXksvUHSh7clIxneQU
         fUsbmTQi8X5O8aFyqYmXSk+p7khf/m6Xa444Q3JaKsy1YjBlbC/WXGYmQW8jVrYBmwTX
         BeUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691660069; x=1692264869;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=09uuo1ZPo0trOooZ9N2aLprRug+RrXt+K+nt06yCzbc=;
        b=AX9WW+rPRFpImzqy0pYpAJaOCYC5EwIW3ZCGhRit85JanmJAqiCFYa9t710ORezogd
         8xoUEvSxP7gTJVW75qgQqBGr6e7ohLc6GDpNbbpBZso/kXPGiaWtZF4sE9xOGc0RfhEL
         Fcgxa14az/FSfd1P0G3JGB7CektacmW2MrJDHcOZyqyesVh4YUp82/BxU/gw6LdBORXZ
         9D8cux1Lm5KxiqT0BC3tHeLYTPhLUbcMME5lME66nLoE/9LwSSJotzOdQQj+AwRQwFlP
         kizDT0fN5mXy0OiYWiwud5NU9+aXAL5uAg8WFRNFB6nFXwQC7d3Oe2NY2ublk61Pwkk9
         MCRQ==
X-Gm-Message-State: AOJu0YwdVVTGNtYS2dIpbfanOXloo5XOdVCeUhGNNKHIM9l4L/HH9/IV
	PPVAa3Thg/3Qvn47vJ74XBwiGzpj9aLVYgfGprhgDg==
X-Google-Smtp-Source: AGHT+IE9AMqIHgN46i95yHR5exOXafGwkQUVSYrKIROqaRv9TnVs9lB4RDlHgQS363gh4fYk6DBYuLFHvkZ6Qp1vL70=
X-Received: by 2002:a05:622a:206:b0:3ef:302c:319e with SMTP id
 b6-20020a05622a020600b003ef302c319emr389160qtx.8.1691660069457; Thu, 10 Aug
 2023 02:34:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230808171446.2187795-1-mshavit@google.com> <20230809011204.v5.2.I1ef1ed19d7786c8176a0d05820c869e650c8d68f@changeid>
 <20230809134941.GA4226@willie-the-truck> <ZNObxeogswAYyDQ5@nvidia.com>
 <20230809145542.GB4472@willie-the-truck> <ZNOr0ggoO9kXHJWl@nvidia.com>
 <20230809162254.GB4591@willie-the-truck> <ZNO+QVkXcHG78KG3@nvidia.com> <20230809162749.GA4663@willie-the-truck>
In-Reply-To: <20230809162749.GA4663@willie-the-truck>
From: Michael Shavit <mshavit@google.com>
Date: Thu, 10 Aug 2023 17:33:53 +0800
Message-ID: <CAKHBV27JAFb56VkHJO2ZBZt=25aVregeiMjO2YJrg_fW9HQbYg@mail.gmail.com>
Subject: Re: [PATCH v5 2/9] iommu/arm-smmu-v3: Replace s1_cfg with cdtab_cfg
To: Will Deacon <will@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	robin.murphy@arm.com, nicolinc@nvidia.com, jean-philippe@linaro.org
Content-Type: text/plain; charset="UTF-8"

> > > Sounds a lot like the existing s1fmt field. Can we keep it?
> >
> > If you are OK with the dead code, I don't object. But let's put it in
> > the struct arm_smmu_ctx_desc_cfg.
>
> Ok, we have a deal!

What dead code? Is the deal here that we keep the field, but still
infer the value to write from (cd_table->l1_desc == null) in
arm_smmu_write_strtab_ent??
