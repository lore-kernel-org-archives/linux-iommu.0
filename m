Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99F830B502
	for <iommu@lists.linux.dev>; Sun,  7 Jun 2026 22:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780871414; cv=pass; b=RfOCJdhMROre8h+GoHskg2q88zqmsaXErzD6EnWHG5f9pUIoYJu3hIyXDGXdNynW6K2NoGD89eiRtrVBcX4ZU4fG6StqtidMKy1JvtMXYsMW8pSHevJaavnvAyLNsonrY9KlcqXZrgRtVBu4rWsNC7QSHxCRHrOJDpeejNtZUxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780871414; c=relaxed/simple;
	bh=SL4VGK6vWPHif5hXbm1zw6mEgN3vVwkp84xHwyHFrT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vGA/NSkSvesff4VET8W4/+abNCTuNZhfWZYQVpRCuYq+CYJPNHvAntlQXMfOVFDZj82nheSfqtdBnLnTXIIlpk3DMwhvnCoFzdKe0vVfHRVFsbBc6K/NTyzglcD4VUtVDvN1zdw2Z77b0lRrq4wgLbTC4TJ5WcOdIM3vRLHt0EI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A9Ptupzg; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A9Ptupzg"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51765331535so1341311cf.1
        for <iommu@lists.linux.dev>; Sun, 07 Jun 2026 15:30:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780871411; cv=none;
        d=google.com; s=arc-20240605;
        b=WSvxGT6Ay6W6Wkk+pu9+KK9IhiXjOPgsZpwuZqMecyr4qLUdtiv0oYM//6arFiQoBf
         39F7xS5Bn1np9PEst1bJXu4p2ZHFv36SGdLRFuIzaqOFEoxzs0DcmsqR7kRduF2Lm6Eq
         /CgSeIcN5BDDKXOnv8N+kxhy+bn30oj3Qbacr9gvBvZu8vjV54QxpXvdhz+ZofLfn259
         g881hX5UQPEuD1YJlRUz5Ysx/FheZvnkqJKUjWyhTkS6TqzRpRGqnrjzMnyixWTlbsTo
         a5hoQaZ00lQxacTkrTPhHQN4COmJEUyMUuZcNXr69iNnLelWda+qkHQhQKqIxgdEST69
         Tz7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s75AHbz4vBuayfk9+70x5zzjz+DkRAGgcB9JhZnUsTo=;
        fh=0u6trxL0zZwA0/1Sge/7uQQnOlSSVTu7AIo0GAZRpig=;
        b=iKzwcKt8vCHeegHxMfMXFEu1T9LgAcoTP2bAjWCAUng+Rw0+qy0W/npx/cuYq2vPeS
         QxeqQy2vvlKZ6s6ksDGJPG1dB9Y4X8tY7cPk3FlTxgKnWwRsp0TXhu5gauG+ZxQz3/NS
         ppnqKKfSdSOR7C0NZ6cjr5HUH6EstLGDIvsMQEemzINcFNt3Y+RmoBFXQz00Kme3zA9L
         zhI7qzzyrvu6jSLTs+fb4WIwIwJdWA5sXyI/ltmVGbS8bBddankWrC18s7go6EMzslIu
         LUTufjn/EkaXDphrnPnmSFshRCLcSTKQAp8O3Vb9Lyr8/r4c1to0mRboZSskIiacIdRf
         IZTg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780871411; x=1781476211; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s75AHbz4vBuayfk9+70x5zzjz+DkRAGgcB9JhZnUsTo=;
        b=A9PtupzggPzqFRQwJNXPLF9zrKAZqx/lZ0kbuO0g/PxP1XVBn2LeaSeffXaMAKHVRr
         ywsluVgsJVV97zpOFdOMDCdxijtehcBZ+WNNOb7OcZL2bbtvyoXyF4lsbTMeTiwTN5s3
         IuUPB3/fQWNbYEtkHxz4WCV7DQJ9EFwbmDvG4JRCGp/a8ZuWxr71Kz+TvnUuYD714EpV
         ua9gxg41PRUO1DKnrfih83q1PX9uN6CLRGJLrCSrk3Q9oL8gLhbrUM8pUodsh3IHvUdk
         CdOs1oLmivS0JYzpuCEWuFdXLpdjDUqcGuApvy6KtedTwdHfJvwRtojml8muAXUqvMl2
         1Z/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780871411; x=1781476211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s75AHbz4vBuayfk9+70x5zzjz+DkRAGgcB9JhZnUsTo=;
        b=G2yYDg8I4K+UwsNVyCNmC2MUePxWoB85VCP3VSc2PjfEgDz0JPxJHbvC5p1ZFANOCn
         TQl2eJpFo7FQEcYmG0glFtz/xfGwZD8BJynDvA7jakfQENWcryHArb4IODQxj3LX+pCj
         SN8e6isyT6f4dhETflniB6RpN9vY+cDtAaGqwFrMx+mFk8gD1XKg7j+is9F1qNPKxjmc
         Dw2W3sXc2I710jukoKGbnMuq6bwncL9WNpCxaLsVcDtwZgIKuYUWdModzxsmFEAlSRyE
         iTUa+J5Geg++/3INqnVZIdfk5+AWawojPP4QacxfqDbZzpywdapk6TyPcni14kGwSDVZ
         qCrw==
X-Gm-Message-State: AOJu0YwuvxpzL4YbMkI5HGvATnajGwLUmYqZR8BHaFTrSyy6nGdhJaES
	EQvB02vmgJYGyY1NWb5tQ7YgBvQ3BKjUo7YYZxxzH16bZspkCagTUCYzJ5PhgWGCoVSGzXPjs8s
	pW+wVQxVsreVzIFBiq7YCSAifh3UJGPkbdXr9kJzYckJxtZdM8W03KwHnss8=
X-Gm-Gg: Acq92OE8ILTxEM45tcb/SA/j2Kp8fbkgK3ayh7FpOjOx8LDL/+0X9hhm2NS45hcnE18
	BrKx8Q5yOT3iqB2qT8KJD4Gm6wBq1bMgnRybj4PelkcXlwoB2hshgY+UXCF5MGWrmmUqIh/+dot
	WtunUDQVu/h6Ub9TB1Gl5UMrD4IDGNIGwBU4L8CP2RjCBdr3uj/RBeE9A7Vi9hjSnpBNoWytTno
	0+TYOk6kNTcHPL8uehaOMVFzcDnnGKNe/kAdLxB05L/Ywsvg/Dbf67leDop4++CuPjolByRix4d
	h7K2qWIMWMJD14o=
X-Received: by 2002:ac8:5ad1:0:b0:517:99ea:ab7e with SMTP id
 d75a77b69052e-51799eac04dmr21324091cf.24.1780871411109; Sun, 07 Jun 2026
 15:30:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260601215909.3958732-1-praan@google.com> <20260601215909.3958732-10-praan@google.com>
In-Reply-To: <20260601215909.3958732-10-praan@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Sun, 7 Jun 2026 15:30:00 -0700
X-Gm-Features: AVVi8CfILy1w6zPPcSCqno87gNyBXrRqpCu4Tsw4twa-VACBxAdN7lY1rhDrUoA
Message-ID: <CAE2F3rC4a55Hfg+JZZora4UYxJyz9WgUV_kqBt_ejUy+9RLzYQ@mail.gmail.com>
Subject: Re: [PATCH v8 09/12] iommu/arm-smmu-v3: Implement pm_runtime & system
 sleep ops
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Ashish Mhetre <amhetre@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 2:59=E2=80=AFPM Pranjal Shrivastava <praan@google.co=
m> wrote:
> +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
> +{
> +       struct arm_smmu_device *smmu =3D dev_get_drvdata(dev);
> +       struct arm_smmu_cmdq *cmdq =3D &smmu->cmdq;
> +       int timeout =3D ARM_SMMU_SUSPEND_TIMEOUT_US;
> +       u32 enables, target;
> +       int ret;
> +
> +       /* Abort all transactions before disable to avoid spurious bypass=
 */
> +       arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
> +
> +       /* Disable the SMMU via CR0.EN and all queues except CMDQ */
> +       enables =3D CR0_CMDQEN;
> +       ret =3D arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0, ARM_=
SMMU_CR0ACK);
> +       if (ret) {
> +               dev_err(smmu->dev, "failed to disable SMMU\n");
> +               return ret;
> +       }
> +
> +       /*
> +        * At this point the SMMU is completely disabled and won't access
> +        * any translation/config structures, even speculative accesses
> +        * aren't performed as per the IHI0070 spec (section 6.3.9.6).
> +        */
> +
> +       /* Mark the CMDQ to stop and get the target index before the stop=
 */
> +       target =3D atomic_fetch_or_relaxed(CMDQ_PROD_STOP_FLAG, &cmdq->q.=
llq.atomic.prod);

I'm wondering if we need the non-relaxed version of atomic_fetch_or()
here to benefit from the barrier guarantees. Otherwise, how do you
ensure that CMDQ_PROD_STOP_FLAG isn't set before SMMUEN is cleared?

> +       target &=3D CMDQ_PROD_IDX_MASK;
