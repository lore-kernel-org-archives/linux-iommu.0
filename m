Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4172FB3
	for <iommu@lists.linux.dev>; Thu, 13 Jul 2023 16:35:12 +0000 (UTC)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-40371070eb7so334151cf.1
        for <iommu@lists.linux.dev>; Thu, 13 Jul 2023 09:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689266111; x=1691858111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0tnBY0Y8/bwKnmLpzTcUU9wCQlG8IWXPXBkGVcnoHw=;
        b=X6GrHI9lGLYu3yPTrOBHhjvdk9rAw/jNavkyOGvzqP57TvSbvU7RdS9Lh9/UbaI7mA
         6EG2s+81o3Og/OD4P0mkdjvdI1aX1HX47fi54BRECAEOiXyjF6ZAQfjczHt/Sq6bLIZi
         DwEMq2zE/ynNCBkmXa8pxFDSKppQ9tLqoyIOeuGnjRRaBfNH83wdC+xdFQeBT3VU4Wbu
         /XYhC72PCXbWNhFK984knIrhHvZHMYOY4jiydh2QB9XzEwmEJeP6NH1Z/zUUqiMdGoY4
         TORxYjZgYIo9rELNS74lYjX++IqjbD6BOnlcU8YqDgE3ioHyiZS0JEDFuWU678Z4TbnG
         igqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689266111; x=1691858111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0tnBY0Y8/bwKnmLpzTcUU9wCQlG8IWXPXBkGVcnoHw=;
        b=F/hEJrYTI4vz0SqQ9Md2k8GoTba+BLLOgP6aX+pCoyAcwij1lULvTmS0SuuKVv6hNO
         PjP+aa9awK7JPW8BMQdXDDvQDl9+6L42uc2rybu+c33GuRvWkAkLjLya/I2rG1yvtcWk
         2+ne7J+DDQ38anJzEFiAcUEAo0CxfBIAhwP+VoBCbXs5JG5lfJMZHj4gvmkWD4p731Ke
         w6I7duSBB0tGfBX1f7D0CDp4yye07Clbeon6IJYVkIR+FQ6Z48uVI+6NRNgmB4OTgNzV
         CAydt6vJEDOdAD8EZgGAFwHCgeweOzuEhqbIy4z2njFEpPd49hgXe0mp1rzaRaJ8EHkP
         BjRg==
X-Gm-Message-State: ABy/qLb/7NQuXVdjAyznB5iBQY47VVnZQnPxfk5Yi/HqHdL0IxoWBB0X
	P2p7/IlAd1E9zV0EApK1QerMJstnPhKh9qEQTJ3QPQ==
X-Google-Smtp-Source: APBJJlHNKfPG76aMpE6PBWeSOZ8u4EIxgpzWc/MltqAh/kYbAk8R7UT9ux0NTmj5EYE3xdx2tInSZNkJ/6BBVhMbzD0=
X-Received: by 2002:a05:622a:301:b0:403:ac9c:ac2f with SMTP id
 q1-20020a05622a030100b00403ac9cac2fmr478923qtw.17.1689266111449; Thu, 13 Jul
 2023 09:35:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com> <20230621063825.268890-3-mshavit@google.com>
 <ZK9RycgNAVrxe343@Asurada-Nvidia> <CAKHBV26wi+xKnNjo-R+QOcVLPH2KJTFP+mF4CW1xE61nOdF5GA@mail.gmail.com>
 <ZLAKQw+DzcpSRSyi@nvidia.com> <CAKHBV25YadRVFiag5z5Yc13L093ScWkCjAOCd=VuGm2RUaDyzA@mail.gmail.com>
In-Reply-To: <CAKHBV25YadRVFiag5z5Yc13L093ScWkCjAOCd=VuGm2RUaDyzA@mail.gmail.com>
From: Michael Shavit <mshavit@google.com>
Date: Fri, 14 Jul 2023 00:34:35 +0800
Message-ID: <CAKHBV25+vOroe+prca2ivSH341A8RLHW+shycyKD5z3UWZVgpQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/13] iommu/arm-smmu-v3: Add smmu_s1_cfg to smmu_master
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org, 
	baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2023 at 12:16=E2=80=AFAM Michael Shavit <mshavit@google.com=
> wrote:
> domains a-la aux-domain). With this change, even attach_dev with a DMA
> or UNMANAGED domain is now just preparing a single entry into this
> common CD table.

I have to correct this part, arm-smmu-v3.c's attach_dev()
implementation does both: it writes to the pasid=3D0 entry of the
owned_s1_cfg's CD table, and then installs that CD table to the STE.
