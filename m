Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B71A86353
	for <iommu@lists.linux.dev>; Tue, 29 Apr 2025 13:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745935126; cv=none; b=cWWIiIJpNwpO7+wg6LOAzU7UsKw23xzeDN/r/RDsRYAJtfOJXWcuyGZcs0oA/FGUZIvcMqlG7vC45FhXyshqSeWpDxS4pbB9VxOFdnpKBzPKn6ZtvQAWMW1NdwvdE2WUqaZDklnodaRtN7yJX7c14GuTDqpfpJJFMhY0li//4So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745935126; c=relaxed/simple;
	bh=nvBMgGeZibW7tTb4cTtSNnJdMYbzMXuEkRCa7/y/kAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P0mGzltygC2tbdiQwi/dd22Kf6HqtxQBz6g8Lx3tQnDlcKCKR7JHgXPHrJHED9dnNk3nP3nN4PcN1HfjT+w+2GhMaTKNhFTiRnyDDlJH9EaYtzPFcVwgzKNgY3yJsoKRNvyxHtScaNcNM48fYDCvgnjMV9T5GEYmBWezFmBZWfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0jQjCxC; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0jQjCxC"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d450154245so55294965ab.2
        for <iommu@lists.linux.dev>; Tue, 29 Apr 2025 06:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745935124; x=1746539924; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhJ2H3i1H9QEiQuSDT43T4jVhzfFSUOLYdmYxqiqeBg=;
        b=f0jQjCxCz5e/yCWNSougau/E2OyBdO/ZKMWnHH/OTURKfeOGJEIFGFqlMqhH08+gOi
         bYGdd+hU0Ir5zjkleB2Fbxox086F62mlfLNrpv0onf2tZ44MmcnGFf+KXd4lOay9XO3m
         Hg2bp+mqDkHuLs2FjEgEFrql/n4vOqlcW8srrz3QkQwfLYjOFar7uO5t6ftasSgVIZ5d
         5PVieCk+sJjN4XT6FebNwCGRQCuXdJNCrXJ5VdCbcPN48R8H93sKezbHl58xKe4jSwTe
         XhZaAvFfHy6LP6/W2uQhAzW2n1dgwMphgvv2v7jrS6MFQVAVr1PzqzFA2MPXimwZdzbQ
         xqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745935124; x=1746539924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhJ2H3i1H9QEiQuSDT43T4jVhzfFSUOLYdmYxqiqeBg=;
        b=TCRYKgUGmSUZBEm6NtmoFpQxEfNaD3/6a75pkCDFOB5L3Vma0Bqj3dIWNLCv9WwmIL
         6NG0jc98yN5Bo2Z1fzU0mxb4ZxVofkiDswD5JJkYxrVPp02nL8vCfe/m4hgJR7d4Q6uA
         dC47hdEeVwlKoDzFI7wZPeTpzltTy/yiYWHAzhe/bNYpgTg4C+LdD/6B172Qa31tAJ2o
         MOgN1eCP4kZn1Usm59ECAlHAIAUvL0qdv3X0cQPU8ZtrmxIxdGHcLUwDCjlMjfNRcSTa
         lAwaSrMYVC3w1iS0cYMEHboJ0zIEM9BTY1mjYSbaQFFnLzOSOw1ngHDtv3vzyYuY3mSS
         +9aA==
X-Forwarded-Encrypted: i=1; AJvYcCVG1Urq1aIXaymffT7E4+iEYvN8eKGnQSxyIBEzsUAEK56/Bil0BE6nbiUbKyNbdbTMGeeWoQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZWUjGXXMYVLTsbsVGMeTb5dw2mr9XookC1fKqD1OvJC/NESep
	yI3PXEj4RBm0ZzMxkBMRJbp3x1B7Je9rR7HxtOeWaVa5MQBxEpOmgUop6M9xlvPP7PlOa60gJCD
	fyahT8GpKtiRcilQTaYhCMcXgmn8=
X-Gm-Gg: ASbGnctR5DHcOudZgtyhau+k2syxvlS6XSSAIHzHfCsF132rZeT6Phh6wp+DfgQRBLq
	yfFNZ0Wf9NpGgTGKOvT8ORQpV2CZ1t2/M1zxucZnE17BHspZX5ROj5YEtN8z098QcNGR2xrCoVC
	eDZo2kAMi14qHd8dj2CT+8kcMTh+5MSPj4uDA7bDXEfJ1CjMZI3kGsKOdXdO/QPA==
X-Google-Smtp-Source: AGHT+IH1nUpjoSz6b/R8czY4xnY2bsj4Qtmd4LwhtuxBaf5F+Zjq1Yfe6RP1zEzp5FQni5VkJn1doj3WcQsEWRWuaUQ=
X-Received: by 2002:a05:6e02:194f:b0:3d4:e6:d872 with SMTP id
 e9e14a558f8ab-3d95d262d3amr36052445ab.9.1745935123936; Tue, 29 Apr 2025
 06:58:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250428205619.227835-1-robdclark@gmail.com> <20250428205619.227835-4-robdclark@gmail.com>
 <20250429122834.GA2260621@ziepe.ca>
In-Reply-To: <20250429122834.GA2260621@ziepe.ca>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 29 Apr 2025 06:58:32 -0700
X-Gm-Features: ATxdqUGRQLIGoOBhYNTDnXlEra9K_SUIOqCbRuVfNJ5xIkADqjZJJUiOpnz8BvY
Message-ID: <CAF6AEGt+5cg1CRb4ZSm9poWhq6LGh=N2axfRyKOvKP5PNpVucg@mail.gmail.com>
Subject: Re: [PATCH v3 03/33] iommu/io-pgtable-arm: Add quirk to quiet WARN_ON()
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, Connor Abbott <cwabbott0@gmail.com>, 
	Rob Clark <robdclark@chromium.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Nicolin Chen <nicolinc@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
	Joao Martins <joao.m.martins@oracle.com>, 
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, 
	"open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 5:28=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Mon, Apr 28, 2025 at 01:54:10PM -0700, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > In situations where mapping/unmapping squence can be controlled by
> > userspace, attempting to map over a region that has not yet been
> > unmapped is an error.  But not something that should spam dmesg.
>
> I think if you want to do something like that using the iommu API the
> expectation is for the caller to do a iova_to_phys to check what is
> mapped first? That seems kind of lame..
>
> Maybe page table driver should not not be doing these WARNs at all. If
> we want to check for that the core iommu code should have the WARN_ON?
>
> eg iommufd already has a WARN_ON around iommu_unmap failures so having
> one in the ARM page table is a double WARN.
>
> Don't really like using a quirk to change the API contract.

I'd also be ok to have the WARN_ON instead in the iommu code.  In the
case where this quirk is needed, I'm using the io_pgtable helpers
directly, not going via the iommu layer.

BR,
-R
