Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B2453A2
	for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 09:17:41 +0000 (UTC)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-3f9b7de94e7so202371cf.0
        for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 02:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686734260; x=1689326260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NmiRBAcZ9cvxOKeXFRkYv+ik5tUe/PARU9gZbEaPiU=;
        b=LYUQ3HqCYY/8TiB3Z6yqF2jVftbgewi2HgiI06akooT//gxAb3nyPrrpf3yB6UOQKb
         82QwZeiHTj8mlH4qmJwzexlj9Rn/pKp37S/+4qXHxKun61AlIKxmSIzoyZ7HQdBYyn1Q
         6wKz9A9rJejJTem+bwubkAGocVI9MxMmrCP3BkwTFaJkH3XSUqCcFEY3HziBgfKaC+TD
         Xk8zS86HkDprZ0XiVevGL136O4vbre0Ks6uCPMlr5W+Ep/Xh/LiHmU0NOQKC4GpWQ5uB
         n5xgMJeZZjKM7SG1or7ONVz+myczJjYZvnBEHtqXgd+29LnN/16RwqL3aA0Xe02KWlNZ
         eyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686734260; x=1689326260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NmiRBAcZ9cvxOKeXFRkYv+ik5tUe/PARU9gZbEaPiU=;
        b=cgqtw768aAd+N89hrZN1DK+c6v23sh2bPHQrEW+G2yrbfw6v5hGURI5yzvw0hXmCnx
         DTfWOd/sd6ic/M+hRAko4YcqIy8A1olB3O1HL1lBPeWF0ecI6ynyXCLHvXjRhzphfFaE
         ZgDPVLhjpwfrnQzpswnd8pnelIJQg81vg6dF6L7attqSCGkR/vA/PH5LN7R6VW2TYFTZ
         IF1P10nQ6BtSBuO+5iEav5k1qDier5tjfbXfjx+XIP85qhCJlFdHJc4wG4H1H16OXO2O
         4DC8oVDUAoKIiuFVgc/xSzD2TqfhAQxdaKEA0bH2G7E0MoSPPumLZdckf0Qd7n8AwwnG
         QPaQ==
X-Gm-Message-State: AC+VfDzlNPyc29H0IJ6v5ulthlCGaPrsNDORe3mX+GsGTKJntsVyHsQc
	f7BTCJzbCSdRKLpWX7htMxmxMIBjz6CC686HdApGZQ==
X-Google-Smtp-Source: ACHHUZ6qFqzCM8Btqgf8/fKUnENgzMgD7o0VcXeVee1SYR7Rsd46p+9kfWjn+ika7JL8ur8cwhxssPXqimpWLOMcgv0=
X-Received: by 2002:a05:622a:188f:b0:3f9:56c:1129 with SMTP id
 v15-20020a05622a188f00b003f9056c1129mr130965qtc.5.1686734259904; Wed, 14 Jun
 2023 02:17:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230606120854.4170244-1-mshavit@google.com> <20230606120854.4170244-15-mshavit@google.com>
 <ZH9oQMmI8CezMCnx@nvidia.com> <CAKHBV25eDNXEu+6GWDJqpw1h5N-Jq-GPzf81kNH1dyw3Z=KsZA@mail.gmail.com>
 <ZIBxPd1/JCAle6yP@nvidia.com>
In-Reply-To: <ZIBxPd1/JCAle6yP@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Wed, 14 Jun 2023 17:17:03 +0800
Message-ID: <CAKHBV25K4BCewMdp3HcRtaX1iNhVpxL_6dMwp1_fmcQ5RWpKBQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/18] iommu/arm-smmu-v3: Support domains with shared CDs
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org, nicolinc@nvidia.com, 
	baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 7, 2023 at 1:09=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> On Tue, Jun 06, 2023 at 08:07:50PM +0800, Michael Shavit wrote:
> > SVA may attach a CD to masters that have different upstream SMMU
> > devices. The arm_smmu_domain structure can only be attached to a single
> > upstream SMMU device however.
>
> Isn't that pretty much because we don't support replicating
> invalidations to each of the different SMMU instances?

Looked into this some more, and supporting attach to multiple devices
is still very hard:
1. When an arm_smmu_domain is first attached to a master, it
initializes an io_pgtable_cfg object whose properties depend on the
master's upstream SMMU device. This io_pgtable_cfg is then used to
allocate an io_pgtable object, and the arm_smmu_ctx_desc's TTBR field
points to that io_pgtable's TTBR (and ditto for the vttbr on stage 2
domains). So then arm_smmu_domain needs to be split into two,
arm_smmu_domain and arm_smmu_device_domain with the latter containing
a per-SMMU device io_pgtable, arm_smmu_ctx_desc and arm_smmu_s2_cfg.
Each iommu_domain_ops operation now needs to loop over each
arm_smmu_device_domain.
2. Some of the iommu_domain fields also depend on the per-SMMU
io_pgtable_cfg; specifically pgsize_bitmap and geometry.aperture_end.
These need to be restricted as the domain is attached to more devices.
3. Attaching a domain to a new SMMU device must be prohibited after
any call to map_pages or if iommu_domain.pgsize_bitmap and
iommu-domain.geometry.aperture_end have been consumed by any system.
The first is something the arm-smmu-v3.c driver could feasibly enforce
on its own, the second requires changes to the iommu framework.

The arm-smmu-v3-sva.c implementation avoids all these problems because it
doesn't need to allocate an io_pgtable; the shared arm_smmu_ctx_desc's
TTBR is set to the MM's TTBR. One possible solution would be to make
the changes proposed in 1., but only allowing SVA domains to attach to
multiple devices:
1. Domain functions only accessed by arm-smmu-v3.c (such as
arm_smmu_iova_to_phys) can assume there's a single
arm_smmu_device_domain per arm_smmu_domain.
2. Domain functions also accessed by arm-smmu-v3-sva.c (such as
invalidations commands) must iterate over all arm_smmu_device_domains.

> On Wed, Jun 7, 2023 at 8:00=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> w=
rote:
> I think splitting it into a series to re-organize the way ste/cd stuff
> works is a nice contained topic.

Should I explicitly resend this patch series as a v3 cutting off
patches 14 and onwards?
