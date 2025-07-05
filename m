Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D1C238C1E
	for <iommu@lists.linux.dev>; Sat,  5 Jul 2025 20:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751746344; cv=none; b=VKoQ6cOwyi/D/HTdwcmnk6py82KRHqYGg8ivtppWyh2NSBJFpQSM9wo2GRWCF9sCyhZTsCFBapVK0oOtpppMvLbgWPGpFSkjJDKQPynYrLYBOA61s4in6iwKZQZlFHvH7JlqIhLWZUqHdjcW9pYo0pLLT7D1WXj0hKVBA0N2ilc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751746344; c=relaxed/simple;
	bh=9z08aVLb91ru0Ot02TohgmJftasWTWVr+dxaYwP4DqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gOWGY/O75xqmjGwbZdoBN470XpoJQ8ETKvTSgzpHG35XnPJHyn9EY8C8nNxOUY4REfC8qlghHzmvNmZF+uiO9AlPVkKKBy7YpzU7NZJAqQnF5Q80uNVfOvdCXpgfymGZTmfTt84tVEhpXPAfxpMuyLvyQmGhCQVJ2gnV36CDDrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y4LiTK+j; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y4LiTK+j"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6098ef283f0so31092a12.0
        for <iommu@lists.linux.dev>; Sat, 05 Jul 2025 13:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751746341; x=1752351141; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9z08aVLb91ru0Ot02TohgmJftasWTWVr+dxaYwP4DqM=;
        b=Y4LiTK+j+4LcVfZYCdZCs/2IVy0Y9IbhiitUhDqxwEQ2qCjPfOfTZO6U3vDdjhYAdI
         rfglyf0N3/cAW9/1xvRAhP/80s0RUuJXviH0IBPYPayyudbaLNGNm1B3fkKZGna4Qj6b
         /oBin9qjSyP6z4YBAvGA3omMd+1q7VhkWYdzDfDY/JebRFMzeaRI5KFjVBDj0JUh1hCT
         K5xhX7avhvUiHm55abay6Lv00zE6O48sr5HEIiGzJovZybajfWUKtwXgOsav8NHtO00V
         9MloKGUxlfIuqlV854ftX7mqZqvoLXUnoSG3/rFJLCMmddkeSVzTkfChGGGD0jQ5bHjZ
         R98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751746341; x=1752351141;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9z08aVLb91ru0Ot02TohgmJftasWTWVr+dxaYwP4DqM=;
        b=O2kHv/AN1evad0LJP3qOYxmlRlrrs/FnfJ5ZM7yWkgWAfu0vGQK3x5fg6g8bd7cDhH
         ttEZJ/Pvf/f02iat+rvufRV2dY7meN3cbF7rFFn5lYFlcDKfqhpFAes66cTG3BQ3YTPc
         ZIeZqfP6b1LRVnmdEDMwqdo/sC7bZhvEiEM4qVESD+PKdb1chw+3pAQCU5js9l4L16Qv
         BK8fW4qK75I/MFijS5xVs214o4qzu6etZ8RYpT+KTFJ+RpIfwxGf4P0Mtr3salf7T1xi
         JpDW///CpyuO4FxCvOshAT5MqsMPqu/WF7S+cW6p8/DI2mmALMbjroz8xSQthHsjF9/D
         j8Vg==
X-Forwarded-Encrypted: i=1; AJvYcCWlvRNXfFsN+9CA7Dhx/KrSKgGaBk8GmgEWwe47JHeraMjZoUeclrSB+4MdTbnVslztMFAcyA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyufUBTXXiYUaL2jAG8LN3Z2XGvz2b/0t2ptk3mIwaSq/Eb3Tiv
	ve92PBbcRy8VeNteHIeNK4059XEQS6olj9VWKRbW1dZFc6RsAJXHvzhE96q28vdz+tCFDso85Lr
	Bf1VgpZ+L/u11x43/3DNggAPIoD47sFvM1/ePvft/
X-Gm-Gg: ASbGncuhy4F14wYmY5SlPs0Af2I/ztqLksC2yeqUQrrJYDVS5CrA22m8nHFQEOMpuff
	sR/wswKQy+w8mBwc4jA8k3oVgjoZ37dlz7hJ1ItGynn/QFAR3JqIkDVNiRBWcic4oNvT4fjfEc4
	XLQx/2UDc2lembfEBfZgPxToPw8XwXkqU+S0N7N4jo
X-Google-Smtp-Source: AGHT+IGJer1bSae1hTy+VdVDgBmIxrnrLy6/1vEbuh3ihuiTHeYj5NRruSmZ30W23oHspApAquJQsquajOdAT1S7J30=
X-Received: by 2002:a05:6402:5107:b0:60c:bf83:65fd with SMTP id
 4fb4d7f45d1cf-60e73d1b918mr259571a12.7.1751746340448; Sat, 05 Jul 2025
 13:12:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v1-8c5f369ec2e5+75-arm_no_split_jgg@nvidia.com>
 <20241101134005.GA109739@nvidia.com> <20241104113237.GA11481@willie-the-truck>
In-Reply-To: <20241104113237.GA11481@willie-the-truck>
From: Daniel Mentz <danielmentz@google.com>
Date: Sat, 5 Jul 2025 13:12:09 -0700
X-Gm-Features: Ac12FXzjkeaKni9wvVsiCi9BzDFbIznXFt9RbbGeY2UoHjBPMAYPOLioSuEBQ6M
Message-ID: <CAE2F3rDcq-BQYM1yYq6RNSYSOovdoyRcbYw8Jy+BXCHLkrWN3g@mail.gmail.com>
Subject: Re: [PATCH] iommu/io-pgtable-arm: Remove split on unmap behavior
To: Will Deacon <will@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, dri-devel@lists.freedesktop.org, 
	Liviu Dudau <liviu.dudau@arm.com>, patches@lists.linux.dev, 
	Steven Price <steven.price@arm.com>
Content-Type: text/plain; charset="UTF-8"

With the removal of arm_lpae_split_blk_unmap, I believe the following
macros are now unused. Is there any interest in removing those as
well? If so, I can draft a patch.

#define ARM_LPAE_PTE_ATTR_LO_MASK (((arm_lpae_iopte)0x3ff) << 2)
/* Ignore the contiguous bit for block splitting */
#define ARM_LPAE_PTE_ATTR_HI_MASK (ARM_LPAE_PTE_XN | ARM_LPAE_PTE_DBM)
#define ARM_LPAE_PTE_ATTR_MASK (ARM_LPAE_PTE_ATTR_LO_MASK | \
ARM_LPAE_PTE_ATTR_HI_MASK)
#define iopte_prot(pte) ((pte) & ARM_LPAE_PTE_ATTR_MASK)
