Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EA64BA1EA
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 18:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790275811; cv=pass; b=Jp3qqMdb6O5V4kEWaCe55weC+H5eKnqXac08I+JWktDW8rPLaJpAFQS78TpWSrJSy6J/KVJyNxHBhkx9XuRBu+YdyALzOz8AziqJib0gbcjXflAbh5BdG3yCttzd77UzjH87J21zdLTP6UCtiof2fX9+XEs5e13nAPg6OXvcS0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790275811; c=relaxed/simple;
	bh=ovV3+8HhIOogBXh04yQPFlm05GeVlvyXWO/9SfNBaaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZafhaRT1YplkQUGfpvBhUcyOB6ojbP55rogPeXMHBaKrKnbjOlKonxCkRbNYDGi2cjKXUcO8jBhPqHk1hJp0iXyl4QL744n8A9bFvXiLFoNcCZ0+I2+35C4KvYfTO4DpMz1khm0Y1ABDSQDVP06tGRU8B5T5AsVaCvaDVvxPGAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EN9yU9/Z; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EN9yU9/Z"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-532e9ad9a1eso50851cf.0
        for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 11:50:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790275802; cv=none;
        d=google.com; s=arc-20260327;
        b=lk84PCYDnKwYT0WdTyG6fSGLU3cc8yEoeMIrSIVXrbXRS6+2xlcDf5ghN8ljGp4G5W
         6ne8828tgHEiVRZoLbjmoVBZFn7Uov0xs6TwolSk7WTMSfH+YtpmuvKJSMr4vy6yhvkt
         1XP7pNfabYhAe/FEICwt+9Y9QHQDu7PXgqKFAxUnO+p7XJw/jMTeb+zDMdw+fVjvLUty
         NGFOGe5xt0J3vrCSpwieEQxXKvNuVi/1X5ocjVtqLL4Q1tlmD4LyRwIeB0qLRKPfd7mk
         CRIxaeoU74jJQYbo86vb/baA1uXCHx/Q0Lu4jJiMaEcWWTkm/bu0HiNrCnPah+/05nDm
         l+KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ovV3+8HhIOogBXh04yQPFlm05GeVlvyXWO/9SfNBaaI=;
        fh=PTSk0X1LhrPdKTiKYuMpbc8puiukiZPa/h24vPmkm+A=;
        b=hhv4Lv++xMZuf/0j8tL4QaM3ojQkKXgaveRGYzCGTz5QI3cmtchfmDTA26mSUgE26d
         5KOw5JrJWLGkH5ACelTE1dITl+3cUocDSFPZvbytt3e2eCiewTvYVXwvT+gRnzlRjDo3
         LS4M64Smjjw8l2axBiMx9bm1ISTS2b7IPCq63zs9OKVOedRbT/GaeP0AKrW6BYbFuqbM
         5YqInDKuo/YeE+a7j2dAe8kN6PzB+jVbZg36LOuJUsS7VBXHOpPzBawdYCoi1iOJq9mf
         ncxpbjRMUsmpHiYzgVAPSTU/GAnkpffOF4iN7ffCOcDAjdz2p30OvUNzLcegoNlGtzhJ
         MsHA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790275802; x=1790880602; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ovV3+8HhIOogBXh04yQPFlm05GeVlvyXWO/9SfNBaaI=;
        b=EN9yU9/Zhe+fEMZxsTe+ruKzSW024s945FaTGFh25xITpkA9NYenT9vOonWZBq+fWY
         5jLd0Hmhqp1I2fGyKqkajxGpvID6GapTlgGx5lNUPMlm3ZzGvZXfH2JuLK2Tz+jk81bL
         C/1J5IFGkJR3tuXJuV9jusU5TvZJqWfcqLrBXV8/Q48XrXkTe+E7R5iGDOMyOHZqXlFa
         AhFzuyMZ5dTbwwvHosTTcARmHCfl07tyPVRhdHUSsnk2GkKFsIskFfgo5Qk/2E39FHZ0
         w9m2CyH2rHxYD+l0LmPTlzFjBeHdgf1CuaNxzJcCysTTJekykoBALgXdjaW5IOLUi1Xp
         RoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790275802; x=1790880602;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ovV3+8HhIOogBXh04yQPFlm05GeVlvyXWO/9SfNBaaI=;
        b=Mi5VvUX//PEukSj6zVeMN9UZ89kZLHBSf9sTpn9T3Euw0gBkuBpYmOfqxPgs5lNNIm
         wExa5s58LT7n9qzKW2t5pNc4Dh+O5DTG8RkwH4hwZS4JEyWSzUBg973cx/JI0f4h1CRm
         IWgy5XsKgX/fRi7i9xvE8n0aGHyLhTeHL+hhQbCoaUW1hKYSrQHDjWJRJxrjrH6E1CXe
         RZIbmr6uUg8zH630cfuu1vFFItCw7ttSLVuWYWc2N9VIOFYs5AGbFVJBfK83Eggwxmnd
         pLo15dSF/0zb0KLEl9RT0z7wmJTKFYPJlKXYwwwjOZoU5qFG4yhD5+UaVK0/6TTOUSUF
         iXPQ==
X-Forwarded-Encrypted: i=1; AKwUvBwzkojQF/pJMNWJsG9A4AyySc4fbTuAKJ7YTMJBv+HDygmetqiogHXScy3x9qko5MiEQJo12w==@lists.linux.dev
X-Gm-Message-State: AFuF++niufc3QqAm2vbbGJqgYBavxzo1ONCpYVVr7WjwNPd/01u4TIsi
	0IFkMrHF+Vg9yshQnUApmXwjsS1zrBucMbULHLVtnSM4RZPJwhbRVopg1ipYcLvljjkLgyPgP24
	jVlSNmnpHWMHW/P9sXuvFD550QUkNN9mUMv3TFSIE
X-Gm-Gg: AYBFou25f4aWE6qNREiUv2rZN+SHXySAbkjgVmcCHGnd3qm7gLN0RVGKrF9Bd8482C2
	5QnYYhSydhrzyTK2piZIgu8GS1b5VceqEvpt2X53/VSyAHDCsS5gdKly9gx9pYfqcI/0w9EG5P/
	Vd+Cn7AMsETAjmdqINWPoH8afBPOR1v0raXlrhE/6P8N82L1FbeMHRybgO1svRbD+GqzMWQZ8Rn
	Ir6EFdgnAbh7qqjCDTfu2dXCzDd2WSme0G1vjMh2T4IJcGvLQE8PYGLOW9GhBs1f5JQxC5nagSa
	SxX9o1o9vaDAMjoLvGz42yHz2YcPFj02ON0Inpm+zOZQl7vrkmra
X-Received: by 2002:ac8:5a47:0:b0:52f:9ed4:8d75 with SMTP id
 d75a77b69052e-5330b91b69amr764001cf.15.1790275801917; Thu, 24 Sep 2026
 11:50:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260921-iommu_contig_hint-v5-1-e7fbd1c3774d@oss.qualcomm.com> <20260924001502.GO1540250@ziepe.ca>
In-Reply-To: <20260924001502.GO1540250@ziepe.ca>
From: Daniel Mentz <danielmentz@google.com>
Date: Thu, 24 Sep 2026 11:49:50 -0700
X-Gm-Features: AclHuK8NxjjK4LAAInZh9B-AiWvxMmczV1znpTfWeKjoAyhZX_I7iFt3P7YZv3g
Message-ID: <CAE2F3rCVh0CmW6+a__PcCrBgsMJVompKJX_qYBdQ=exj3bYtCg@mail.gmail.com>
Subject: Re: [PATCH v5] iommu/io-pgtable-arm: Add support for contiguous hint bit
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Prakash Gupta <prakash.gupta@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 5:15=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Mon, Sep 21, 2026 at 04:44:07PM +0530, Vijayanand Jitta wrote:
> > From: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
> >
> > Add support for the contiguous hint (CONT) bit in ARM LPAE page tables.
> > When a set of consecutive PTEs map a naturally aligned contiguous block=
 of
> > memory, set CONT on every descriptor in that group so the hardware can
> > combine translations and improve TLB reach.
> >
> > Advertise the supported CONT group sizes in pgsize_bitmap. Callers sele=
ct
> > those sizes through the normal page-size selection path; io-pgtable-arm
> > then installs the corresponding tagged descriptors directly. A partial
> > unmap of a tagged CONT group is rejected before modifying any descripto=
r,
> > so a rejected request cannot leave the group partly unmapped.
> >
> > The IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT quirk allows SMMU drivers to disa=
ble
> > CONT support for hardware with implementation-specific errata.
>
> smmuv3 has this errata, it must be disabled there too. I didn't notice
> it in this patch?

SMMU is an architecture specification. I am not aware of errors in
this architecture specification that would preclude the usage of the
contiguous bit. I understand that Arm MMU-700 has the following
erratum

3777127 Under invalidation in TBU possible when using contiguous page
table entries

The recommended workaround is described as

"Ensure that contiguous page tables are removed using a single range
invalidation. Arm recommends using range invalidations to remove
contiguous entries anyway for performance reasons."

and I believe we are already doing this.

Which specific implementations of SMMUv3 do you have in mind that have
errata precluding the usage of the contiguous bit?
