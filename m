Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E6DD50C
	for <iommu@lists.linux.dev>; Tue,  5 Sep 2023 13:24:59 +0000 (UTC)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-414ba610766so522081cf.0
        for <iommu@lists.linux.dev>; Tue, 05 Sep 2023 06:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693920298; x=1694525098; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tm3HckoGhR0kOmO+Af+IuBe5cApLGm7dUdHeKiObbD8=;
        b=YeUggxT3Z8jiXXDLH8j2LwZSVlNpyMXougVEC48us0FWg7SdQe04XsQ2wo+6fMODe5
         d8CiqTMLOZKhvvMkNu8HEtflongtS0buBnCFO2aR4BKXH+p+cWdYlsk30Hd5/fKrO4/7
         NrsDCRGiWCI75AjuDu2S83zjzU8bOOvskh4d/sbGHsevtTqkIwFb3Ng+r8sUn3nYKFKp
         l9eiEKW3ZM7qCtf/WDyjyS4fLejANo0D1VGs+8xcO7poSCHO7LfnPz6SCMVhFHTcssFx
         +M1um5I9VBnooOmh5OZvV5vAx8pfVLbAIrP1WyZtZ0pz6LRGxWqonpkB/X+3ac/lx6ek
         qA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693920298; x=1694525098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tm3HckoGhR0kOmO+Af+IuBe5cApLGm7dUdHeKiObbD8=;
        b=ldgQTCghyDMtvE9FRBMmEzxPoQiTUFvyhTwNE61MssAY1VO0JTGLJI9qRIHXwgmhU4
         ms/NShSEqNv5mAre/0BU/tArwPiLlARz/3LhWwFR51g7phb4LSpVzbNyvcuZCNaVCrFE
         ow49asMWFWito6V7N2OXohKqlZqmlHKZ3r2LJJZYyiV+K5e4fm7iSDMwgheBOGM2F8UV
         0UjzN9fUhN7os29smtPBcKGmKIu5ytnKKERglntQlN9shhb9s8U8VINDfBhly7FkI4yN
         VeBiQo7LeOjDoV9HsAVdwCAD0LgW+N87zA05LrXvfLU32S2yhyTodCswBsezeyTTrNMh
         Q+QQ==
X-Gm-Message-State: AOJu0Ywg85+TP3Lc1X4ldpgm1IYtu3FuQBAMKe6f6ETXucOKmlhw/xDX
	4WPHy0Ia+aOx1R0Jp7T6Wq1Jx3Csg5Q0M0JSkeL1Zg==
X-Google-Smtp-Source: AGHT+IHtdxVPUzfXW+56VWtgBUPKNIoSWrDfX4dDhRXBKJt2RAJrcODOZo7O/yqUpi2HbVBDBMBnRzOM6zfFpx+vXmI=
X-Received: by 2002:a05:622a:199e:b0:410:8114:107b with SMTP id
 u30-20020a05622a199e00b004108114107bmr430079qtc.12.1693920298107; Tue, 05 Sep
 2023 06:24:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230905115013.1572240-1-mshavit@google.com> <ZPcgkO7omYremwyV@nvidia.com>
In-Reply-To: <ZPcgkO7omYremwyV@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Tue, 5 Sep 2023 21:24:22 +0800
Message-ID: <CAKHBV27wi53xtDK4JzM6xH0OB7Ps0A8SewN3A0OJdpTuT2856w@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Clean-up arm-smmu-v3-sva.c: remove arm_smmu_bond
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, will@kernel.org, robin.murphy@arm.com, 
	nicolinc@nvidia.com, jean-philippe@linaro.org, tina.zhang@intel.com, 
	Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Mark Brown <broonie@kernel.org>, Tomas Krcka <krckatom@amazon.de>, 
	Yicong Yang <yangyicong@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 5, 2023 at 8:35=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> On Tue, Sep 05, 2023 at 07:49:11PM +0800, Michael Shavit wrote:
> >
> > Note that arm-smmu-v3-sva performs a second level of normalization by
> > mapping multiple bonds (now SVA domains) attached to devices with the
> > same SMMU (if those devices have the same RID domain attached) to a
> > single arm_smmu_mmu_notifier. This is not affected by these patches.
>
> Ultimately the notifier should be per-iommu_domain as well.

Speaking of, I'm questioning whether the multi-SMMU domain patchseries
and Tina's sva domain sharing are really prerequisites to get rid of
the notifier sharing. Is anyone really depending on or taking
advantage of this? The optimization only kicks in if multiple devices
with the same SMMU, share the same RID iommu domain (although this
would be improved by fixing SVA to not depend on the RID domain) , and
are bound to common MMs.
