Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09BC629
	for <iommu@lists.linux.dev>; Thu, 11 May 2023 15:27:25 +0000 (UTC)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-3f38824a025so805841cf.0
        for <iommu@lists.linux.dev>; Thu, 11 May 2023 08:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683818845; x=1686410845;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nZwryojbiiF9EvUp77SgYE7ffGG2HOXgxsgQSk0SW90=;
        b=XK8dfVDhUlD9RY5tIA5pURuiFv0LK0d/fEHTNDlORCZ3wJNn8katgQwGUbN9OG3zsa
         4AneP7QJfPKD97VihJ1s010ULU11wzJ9t3Q9nV0Cq6rIrtmMp3euuGqzNVEYdMYI2xYR
         svwCI+JUp5n7EdS/utV5KL29taeW9gN0WcfHOjKVAUr1h0+2OTEyrUsQQVu1jMUfrF/M
         zNa7bxzir+x581m6XbrcVWIJedGMUdw+UL7VequbRtMpAfmnJD8rU96JjlvUtsupTs71
         oA8SqmJEsK6WzMhxHjg7UMAFs1/mZzIYrQ8LO3AyuQQxhw/Fie4Z7QV43sBSC9Lbe2x/
         /L4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683818845; x=1686410845;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZwryojbiiF9EvUp77SgYE7ffGG2HOXgxsgQSk0SW90=;
        b=aSZ7L3IA1EiIfoRYbjc2DOK0ze9qbhBErdGJNf6fdgn25Oz2HzmKK/q7QAzsFs4/SS
         HzbpgiZhd7Ff8dV0gbdeLwgcGqBcHJpzefWibrOuV1L5UEwA+1UHe6FiDe/daxEFWHrf
         zxcgsCLzkK+wDdZs7k8O1TJtZ06vUT2wSnUjUQSq1i9ytOQ4N8trFGxl1N8H2viWb8jS
         YNUsmoad7p7Yh8YMjVSKt7FwyOZPFpJipH+bmmeI/I6Tc7nVmv2ZKzNsdhRQb9aLF0Hy
         FA6969mTsNhfHPVTphIth2X/BCgSg5+1lwMz9prGgZg3BnnKyAuSYbE9XoiafvmSvRpV
         WAaA==
X-Gm-Message-State: AC+VfDzDtwBpO9x72tDSLv4RVUR/abHU0/GfKhh8RA1jkG6baReXCnua
	W+8aIWQostq06Jh2csEz1iJdAX0uwhObJhS/oxSGGw==
X-Google-Smtp-Source: ACHHUZ6S0b7lDho6w2zD7BoNTHa989m/4tZ6Vf7LXlYaNaMEH99xHjgRjwBKMYW1er0VEh19YV+pCd4yp4igyw0ZPYY=
X-Received: by 2002:a05:622a:111:b0:3f3:a373:c9d5 with SMTP id
 u17-20020a05622a011100b003f3a373c9d5mr367906qtw.13.1683818844527; Thu, 11 May
 2023 08:27:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230510205054.2667898-1-mshavit@google.com> <20230510205054.2667898-5-mshavit@google.com>
 <ZFwLph9WXByeHxAW@nvidia.com>
In-Reply-To: <ZFwLph9WXByeHxAW@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Thu, 11 May 2023 23:26:48 +0800
Message-ID: <CAKHBV2535Dsbm_w0LQYi=NuyqrYmXdPLjd1JrUVEHo+DiO0=ZA@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] iommu/arm-smmu-v3: Keep track of attached ssids
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org, nicolinc@nvidia.com, 
	baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> You should be getting rid of mm->pasid in this series as well.
>
> When each domain keeps track of what STE/CD entries that point to it then
> *ALL* invalidation should iterate over the list of pointing entires
> and generate the correct invalidation for that pointer.
>

Completely agree. The arm_smmu_atc_inv_domain_ssid function introduced
by this patch is a stopgap to decompose this patch from the SVA
refactor that's required to stop using ssid in these calls.
I also agree that such a refactoring probably belongs in the same
patch series. @Jean-Philippe Brucker and others: is there any way I
can about testing or at least exercising the SVA flow without physical
hardware that supports SVA?
