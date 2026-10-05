Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681043DB997
	for <iommu@lists.linux.dev>; Mon,  5 Oct 2026 21:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791235582; cv=pass; b=WYpU+s+d7IqA0UnZKYQR3Lpc6/AlUHAfTejTiBIp0Oo1Zs+yUeF2C2HWZHnWbkwug8jtszIbCxIE0C7SEc2Enh78LsqH6Gx9RacUkN/IXcLJXjQNj4TXaFs/2SVOjRN7HKNZ3gBAhN7s/hfQ5CUA2Bvy9yGcOgTelIiJeLotTSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791235582; c=relaxed/simple;
	bh=S2vBvVoHVnC1tWQn7yYkVMwt5nPTA4KFwEAWn+1KcrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ICTQ/vg0wlu4OJXjwnUZho51zmr86x5dbtdRtRlWuzc4xwRTHVBlwYPixO0k8o85SlLKfcU789WlfbMgr2ZueuSfALXVpyWxEIT1oJ5CrHQrxxTBnTewgUeyzahddm1EX2sA3Ndnh9nv9pHnROVLnXbEVzYu61Ufhy7MWnLnvwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q7EIXQoW; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q7EIXQoW"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5351f9dbfe0so6431cf.1
        for <iommu@lists.linux.dev>; Mon, 05 Oct 2026 14:26:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791235580; cv=none;
        d=google.com; s=arc-20260327;
        b=KbMQ76hFqSgJilvlhYb/EfGCYJv3qlwNozwLLxeN4dQZbIIqltdxR9K7tGHUnQEsB0
         ztjOEoRuOUIHYoRj96PsCXWm9Wq/C/3jiUuNMjC1EK1T7qqVYUjO2sHHvJ+Hby59zcKV
         qfXdJLiX0WaoZTXFAxHxFXMZcEPAFimYbLHWnsVuaqOKAqJ0RddlSZBSFX2w4vi1HJKE
         2GG4O+zRbuVKHu0f0nzG7PibmMScNhpuo4/VNLdJgCkrrkUX72hJ6GiABca42MN+7jNo
         URm6qcZqnbGGT/o0HxbdTmEH2NVtRsc864hYBdNDVvH5glutBNQc34Sjhm7KYmvUSlxK
         C2rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WKyjO6uz5lI4nCNYOIuplPGihZ8U3rsq+3xZ/QD0AP8=;
        fh=tE67N7RfFyukiUoLNb6goSpOWcOsVAOgwwwl/IFlBL4=;
        b=H4Q3RJ0OEtlHBHgFnl0eI7ootrxzqiiPAstBycrsOz5zEwpYh3FBW5/1W5ZQLgq0Kf
         E6eqOUT4inXkfML9GigIlL3kibgBCOGDY+KxWaS8TMwWm7uL9v3EbwJ/6VrDzeUEiZNP
         xk5ToqW8el6uGPvyTtOnTxRVLRe59PM72pIs1BPx6txUFeMnYS6bIlm/7WUpI3cI55F0
         r1XZZnfFVhexBC9buxFs0FnhjgGiCe9uKcozAHVw4H/DLh29C5KmKQaew5Jrxk6+Vj+h
         mLtyjJQMANebmtO6gdBfp9XB2Q/+VSqc3WjtMo3d7aA6U/xgd+kvERiCNzZRIQNmd35m
         WQyA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791235580; x=1791840380; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WKyjO6uz5lI4nCNYOIuplPGihZ8U3rsq+3xZ/QD0AP8=;
        b=q7EIXQoWBMJh1YrII1IC4BHVhUusEdVsQLTmI2gFsFwbFrzo4kZpTyYXf/s7TMlH/W
         uXIqm6hV6giasc7+4TIsPwckjEqM6DnAiQVQmRJ8eFugztiQTWcliXRrVwLsv3foBr/8
         kcKgvrUCvamhQNoco9qjyur3+nhxKqemPuVNtEaOeTPmGkv+0oadjWxxFQO8AlksoDNh
         zMvCtRhJqmG5tzxtxcXMv9k9/2tJ3HFeWNI8y/mhgMtPw1TvtZCj+42W542L7H2Q+Sxu
         Ab7fXTA24Xm8W5TjQnXAdthAwlZ07Eg5iBlPrz14W2dUsTi5JiKohWCEXL0M3kxDJJDg
         y78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791235580; x=1791840380;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WKyjO6uz5lI4nCNYOIuplPGihZ8U3rsq+3xZ/QD0AP8=;
        b=yKo/qa/jTL9Z4xQjYUbgyfM5x5kPIG+pkFkV7KV7Xb4K8UiOTahgj6gsAT5OkbDirn
         bgvH1CxiKv7S/FtmLbngjGL8SPYUk+l8ak+g2zTuTEwSESf1CUKOr6PnWM5p9zUY2KpC
         DN34D8qiVItCD8VzJFYMj3+07o8mukj24RE/HJdtXFuMDoAg8/Iduz2FAJhBQcAezwMo
         TAFxFpN1c4xOvIOrCmkCsU5Sdc/0QcaMCPt/tLnae+rYrQPc5MC11gYvWkEs386G3gnu
         8CO7RuyffAr7AnW9ks5UjLAsNb2MsnZKTyc6mM9d6CASTcLFrYO9bOeSi2yLLJhp51xL
         b1iA==
X-Gm-Message-State: AFuF++nozM+xCF67PlboO3u3LDPz4xcZsaT5DYU5TQtoGYPibA+L1EOW
	hxf+9m2PBHzBoVjIF+YfeHmsVXa04WuCwYiiftG5zUKYexItUnp97iV0KfUUJU/Hgpeb9WNdIpO
	FMxMGlChwRzauNNPoHK9banEv6LUcEF9hHeWNyZM9N8hQoU0krv6K3Y0r0/s=
X-Gm-Gg: AYBFou39kGumY+ZoYhPJQrRNp5m8BzbX6F1T2puAGVY6IUBQiG8Jy33owDf1RTiesJA
	UlUULfAeG5tz/p4ieZx38Nc6NGkmrKq5lxkqQySMw+kVpxagVCB4LFhZN+oJZm/J+jRz/3E3kbY
	7aNgCBwQ1TyLhv8zY9PPYwIltzZPzT+/cNvBudQiWH99B7zWngHI0TMz7uvG1HthyDddJJ9hocy
	tUwGHSdkZt+JGQIJS8S9Y14Flsw/UEpUI5Iso23G4CPTLbkL41/2HTRk8hBKvl3ciluDxtIiYaf
	eRvkjuaJ7PN6yCBZJDx8F4Dtc/cLb2FBRMOKsDEPWnD3FsnMnebIeuDLBd6DyvLM
X-Received: by 2002:a05:622a:118f:b0:531:d8:e437 with SMTP id
 d75a77b69052e-5354229a448mr834721cf.7.1791235579527; Mon, 05 Oct 2026
 14:26:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261004195027.227748-1-danielmentz@google.com> <92758f79-d5b7-4c15-a55d-6bea5f84a028@arm.com>
In-Reply-To: <92758f79-d5b7-4c15-a55d-6bea5f84a028@arm.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Mon, 5 Oct 2026 14:26:08 -0700
X-Gm-Features: AclHuK8Ya4qZUHEU4y2SIFN99XMdQR1xv1nuJUxB3fTt2xE4zcFS3toMd_5km7k
Message-ID: <CAE2F3rAJdC9pAqMKcXhxpw1keGzH_kQUNBoPHXjTP8+7TOhfwQ@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Align memory attributes for
 SMMU-originated accesses
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, will@kernel.org, joro@8bytes.org, 
	nicolinc@nvidia.com, smostafa@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	dawei.li@linux.dev, jgg@ziepe.ca, praan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 9:42=E2=80=AFAM Robin Murphy <robin.murphy@arm.com> =
wrote:
> This still isn't answering the question of "why?" though. Yes the
> architecture says some things, but if we were strict about avoiding
> mismatched attributes then Linux couldn't ever support non-coherent DMA
> at all! Similarly while the architecture does permit SMMU
> implementations to be picky about their output attributes, does any such
> implementation actually exist at all, let alone in a system capable of
> running mainline Linux?

Fair point that existing implementations have been forgiving in
practice. My thinking here is simply that a small, self-contained
cleanup that brings the driver into line with the architecture spec is
worthwhile on its own merits, even without a known implementation where
this currently causes problems.

This is really in the same spirit as your commit 7618e4790982
("iommu/io-pgtable-arm: Improve attribute handling"), which aligned the
attribute handling with the architecture specification on the basis
that:

  "Although the SMMU architectures seem to give some slightly stronger
   guarantees of Non-Cacheable output types becoming implicitly Outer
   Shareable in most cases, we may as well be explicit and not take any
   chances."

As I noted in my reply on the v1 thread [1], under ARM IHI 0070
(sections 3.15, 6.3.11, and 13.1.2), a non-coherent SMMUv3
implementation (SMMU_IDR0.COHACC =3D=3D 0) in which every SMMU-originated
access configured with Normal Write-Back, Inner Shareable attributes
fails and records an External Abort (F_STE_FETCH, F_CD_FETCH,
CERROR_ABT, etc.) is completely architecturally compliant, yet wouldn't
work with the current arm-smmu-v3 driver.

It seems reasonable to be explicit here too and program attributes that
are valid per the spec, rather than relying on the interconnect to
silently degrade Write-Back attributes to Non-Cacheable.

[1] https://lore.kernel.org/linux-iommu/CAE2F3rACz6Z7X3NNfLWEfjTD9K9YJyYHHy=
GzcBafEemTFGhgqQ@mail.gmail.com/

Thanks,
Daniel
