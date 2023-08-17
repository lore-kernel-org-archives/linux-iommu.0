Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A42E14F65
	for <iommu@lists.linux.dev>; Thu, 17 Aug 2023 17:07:26 +0000 (UTC)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-407db3e9669so8661cf.1
        for <iommu@lists.linux.dev>; Thu, 17 Aug 2023 10:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692292045; x=1692896845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOrR6jLvPvNePyIC/+imo6fGglOwhNPI+mbMxjZ0VQw=;
        b=mbmVCvZpWFNNWlbr5PyQeTm/nq6fYbpjeO9BfgwZxNpukj4mobAKlDUiQHt7H+VrtW
         auYi6sKPedNwPgnshaQiGZn50kRJ3L+uq+AtDp3dN4Hn3DqO4Gdd4FYzguzbCJDsR1ZU
         kn7+C6mGcepD3Nn3SwZiIvqmKoi7Da0UgG7rvfa/GxSHR2Dtd+UuBIr08uR8rpOvGJio
         GhWXowPd/IGl1l1BU4J4SGcYDyYA+sP+1nSae2UnbsoKWTyPE7EKqCIOSWszqYbYL5Gu
         l+/eq6ewzEEuE2VFCqydXhBCswHci6Azi7ktHX11tOD8kXHi1g8lOBOkGeozWk33tcG4
         thiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692292045; x=1692896845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wOrR6jLvPvNePyIC/+imo6fGglOwhNPI+mbMxjZ0VQw=;
        b=hwNuCPlixyx1tcFBxemyajG9nm7SrmKQudIICGgdEO8SqYf8ai1XjKZtEH6pbkahXU
         ntysdscICtob+H9OAqTfYorlFOyNMyQ3uib+Zp3jM/T3looSMGXoUKMsrBEmFlfXkJIJ
         kL2Y/QxqItv6G0pTLtM6ewlR52E0W4vjEmD/PxMri9VvTJ5QTM2ZnW0Tbc3MzESnhfCc
         wp0pnyEGANQ9OqKvaO75WcGLziw9AaF/MIsYSKk4XcqqMXebyq6BCiwqq2LZz1xDIndk
         VY0ry867rpkCVuVy8DIa8blBbDmlPg9c+hWe1CkJk6vV18lfEGugDB8v96QkgYiYsoXW
         Slqg==
X-Gm-Message-State: AOJu0YwIGoPMBlhpwpplJbmDsgIxvmsjBc3bdQLMPhmI1o6p27aO1yYK
	+yqsymriXeX0FFNj43s0f8CjCKXMzkJdQyFo/H0dEw==
X-Google-Smtp-Source: AGHT+IG2FLtDtq9HHsFn8+IjnWSDn8a6ohvAB7pmeSpQ35VRAU2wtAHnE9fn4vA6v1FfKxnHC3jWjVzJpaNgMlwuE1s=
X-Received: by 2002:a05:622a:180e:b0:3e0:c2dd:fd29 with SMTP id
 t14-20020a05622a180e00b003e0c2ddfd29mr12369qtc.4.1692292044789; Thu, 17 Aug
 2023 10:07:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230818000321.1.Ibca43cc8d1bcad3ac3deef5726b9745128aea634@changeid>
 <928822fd-642a-5ca7-7b42-dc7885f3cf51@arm.com>
In-Reply-To: <928822fd-642a-5ca7-7b42-dc7885f3cf51@arm.com>
From: Michael Shavit <mshavit@google.com>
Date: Fri, 18 Aug 2023 01:06:48 +0800
Message-ID: <CAKHBV27bsDWsS_dUsj=xdTfnc0CDhcH+0ZLZ2z481BZMsBQX4w@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Simplify stage selection logic
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Joerg Roedel <joro@8bytes.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Tomas Krcka <krckatom@amazon.de>, Will Deacon <will@kernel.org>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2023 at 12:35=E2=80=AFAM Robin Murphy <robin.murphy@arm.com=
> wrote:
>
> The reason it's like this is because of arm_smmu_enable_nesting(), which
> *is* the additional thing that's going on with the stage selection logic.
>
> Thanks,
> Robin.

Right, but arm_smmu_enable_nesting isn't involved in this computation
at this point in the flow.

arm_smmu_enable_nesting returns early if smmu_domain->smmu isn't set,
and smmu_domain->smmu is only set after arm_smmu_domain_finalise.
So at this point, smmu_domain->stage is being initialized for the
first time. If this code is responsible for handling some special
nesting case, then it's probably not working as intended.
