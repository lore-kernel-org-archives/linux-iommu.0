Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3061046BC
	for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 08:35:16 +0000 (UTC)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4036bd4fff1so158631cf.0
        for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 01:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691656516; x=1692261316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3gXvxbsF3hbjyqhSFUxSmTV+V3aM7IChf6I/fMQUak=;
        b=yPzXBhaOWEa3FxLqIQWK8lADdlX6+gZ9CK6KhlXR8ba/xUuAd2bG4WAoXK5YWI/Wjv
         QpLAkrJ8hZAO+aWBWudsJCfpHZvDTdl1FWqyBStvZcR7vbV8ZDGMZ/6SAG5srES7FNVK
         eprQmkYEY7cPdXkun2KuewHyoVZcxZgTBrk/+Jcw48cAtJf+jqyT3Q+NiKbCHOI9c0KI
         pn8st/Qlm3w5tSYo/6M5apn6eD5k6/P9TGRUwDiJkUAEx/EFVc3lrHDWPaum0ACAobW+
         qo4EokrW2x6sSpjRAGtCKi0A60+etXCWCr+vUCQ5ggmwpJsiAN/RIKmr7lzl80+Sh868
         /l9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691656516; x=1692261316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+3gXvxbsF3hbjyqhSFUxSmTV+V3aM7IChf6I/fMQUak=;
        b=EXl/aBF86lykHgnDtiq9P0kyQk83g2CmUXTs+HC+MxBs4QvJtYEFrotZVngnMF13jT
         rNeziEYErsncTZlMVvnTsrxJXKZhxwEqPR5r0Ox9JVlrV+V6psZBN9QrAFmBMMc7fnkz
         z9Qy06iisKKN/zCbdtWFQbpZBMb2fJT8VfBTDpJlbEAQFDGG1J1uluL7rh9ksYLNXNZD
         Y75vszfOzu7PDsz3/JPoO/bnEe3dXPIe5Yc3LobTRHM0KYs28bKgaJs9omsG6PNd/lFg
         UH7DsSFcNCOaVH4tF9CBUzTKnH2Zc6euyrWRJuyHTxdj+Vl1AOrZ8krda39CSQiPDP0N
         o+kA==
X-Gm-Message-State: AOJu0YzUCTlj1pwlpP97PHPxFviD8Kp7WCzBqlp5pcjz2sC2WJAXLC5t
	jB6OhsxB1eYHDvnINbWa+T49q8301X+jAcTAF95CIA==
X-Google-Smtp-Source: AGHT+IFxpNbZVu1dU4nlN6JPB2xhhbodYZqhZaA7pE4MX5CWbmDuBfSFu+1BuT5QEUOIoNvJithVfpgaD30fXUd1Fz8=
X-Received: by 2002:ac8:4e51:0:b0:3fa:45ab:22a5 with SMTP id
 e17-20020ac84e51000000b003fa45ab22a5mr394510qtw.27.1691656515814; Thu, 10 Aug
 2023 01:35:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230808171446.2187795-1-mshavit@google.com> <20230809011204.v5.8.Idedc0f496231e2faab3df057219c5e2d937bbfe4@changeid>
 <20230809135011.GC4226@willie-the-truck>
In-Reply-To: <20230809135011.GC4226@willie-the-truck>
From: Michael Shavit <mshavit@google.com>
Date: Thu, 10 Aug 2023 16:34:39 +0800
Message-ID: <CAKHBV27LROax9-biR4ius2sXBYM+oJA82GTxsBo_LCd6zxVNgA@mail.gmail.com>
Subject: Re: [PATCH v5 8/9] iommu/arm-smmu-v3: Skip cd sync if CD table isn't active
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, nicolinc@nvidia.com, 
	jgg@nvidia.com, jean-philippe@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 9, 2023 at 9:50=E2=80=AFPM Will Deacon <will@kernel.org> wrote:
>
> On Wed, Aug 09, 2023 at 01:12:04AM +0800, Michael Shavit wrote:
> > This commit explicitly keeps track of whether a CD table is installed i=
n
> > an STE so that arm_smmu_sync_cd can skip the sync when unnecessary. Thi=
s
> > was previously achieved through the domain->devices list, but we are
> > moving to a model where arm_smmu_sync_cd directly operates on a master
> > and the master's CD table instead of a domain.
>
> Why is this path worth optimising?

I have no idea what the practical impact of this optimization is, but
the motivation here was to make the overall series as close to a nop
as possible. This optimization existed before but is "broken" by the
previous patch. This patch restores it.

> Doesn't this interact badly with the sync in arm_smmu_detach_dev(), which=
 I
> think happens after zapping the STE?

The arm_smmu_write_ctx_desc call added in arm_smmu_detach_dev() was
inserted after zapping the STE precisely so that we could skip the
sync. Is there a concern that a stale CD could be used when the
CDtable is re-inserted into the STE?

> >               /*
> > -              * STE is live, and the SMMU might read dwords of this CD=
 in any
> > +              * STE may be live, and the SMMU might read dwords of thi=
s CD in any
> >                * order. Ensure that it observes valid values before rea=
ding
> >                * V=3D1.
> >                */
>
> Why does this patch need to update this comment?

This is a drive-by to make this comment more accurate. Note how
(before this patch series) arm_smmu_domain_finalise_s1 explicitly
mentions that it calls arm_smmu_write_ctx_desc while the STE isn't
installed yet. Yet this comment asserts the STE *is* live.
