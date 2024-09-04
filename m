Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586564778C
	for <iommu@lists.linux.dev>; Wed,  4 Sep 2024 16:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725467088; cv=none; b=Jem25IbC+upHV1QmChdsVVyzl6rtFSdLHMR2HbN9xT/fCuW9gdFDsX6alcAYzkcDD2deDhTgHHZ/XrykR0leafNH6gAI+bOEJFNwbe57ucpqWz1pN60ey8vvYaWnNH29pKAFqKP4mcNjhTrtNIaW19M3YuPep8oK6e9WK9PlyTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725467088; c=relaxed/simple;
	bh=/7cDYAlEqe7bWicn0Va7ROpOHLi0iVmUDmVo+jOORyY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=n7QwOQlsoENaiqX0eNhSYtZjthf4XZDi5IEQGDCV9VIdfg0m6Yoz7aTsh4j2ToYpY6zIc0161Mq3TVUxCKHL8k7kd0WnctBjoPjT7KyBVxjAg1eaVm8xPpCoL7vmngtGXW+MfQ4Adz9qfufuyx9XZ8BLJKsZUZesXyZjSL3XOIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEjfCA1G; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEjfCA1G"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-39f4827a07aso18330385ab.1
        for <iommu@lists.linux.dev>; Wed, 04 Sep 2024 09:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725467086; x=1726071886; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+KkAQjjotCRZ4CfWuR8BuZVWPds5hg7Zc/7KBaAAyJM=;
        b=CEjfCA1GJUU24Ek31mXvCNcuKOLdStaX+Vnn5IVQSN5djWhsWeOOxFREti5/HdSqfJ
         Kqu8IE7EaQYQ1FThROFBAs2kovFnG4sy6hFoycjlQSbD3QaBqtiQwhwDvdVoD9bYRk+C
         aQmH6DyrX9++hvhD/hzQb90FEX16QTKP+Q2ZRUa9KRZbhXxraBuQjOVVK8b5QkobG15R
         G2lFzH1bQ8U9/o4SubJ1BboO2jE2rmpgrGd27fenceR0MGNfHwy4hfk/GJmFQSUPcWhh
         V+bN/I0tmWWMuIiLkshncV3cnax4ocDKCFZ7xq2n+Bo5DbBfd9Ul/Wufcxxz6yUHLBx/
         movw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725467086; x=1726071886;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+KkAQjjotCRZ4CfWuR8BuZVWPds5hg7Zc/7KBaAAyJM=;
        b=aooTYBbXblv25qk0VdafDbGiHs/NI8KGoX+M/eYrIcEeUH6orL3rM+qeMJL/1jt+5j
         HxDKsGDqa2WQHpiafxFgg4xKq/ynKt2t2H/5xZI9Vq8Ygc6fVVDdckV5msJOLEQxy02j
         NEVXYxHFIx3kWicfxfbtJkop+X6WNzJlAcC9r6X21ONen7oTO1ijOjhHHxkMKX3eg1Zt
         rvM4O0UcysWIhMoGVFza7GFM98jfp7ncCcYhqvqDkh/Cpmrfq5KuZjA/WZtEHoRq8FFx
         bXwBhd/AJkZWUpp6Kse2eH1650xAHwUtbB9sT1D+JY5RpF/rhYdASl2VVkQCI6f0fixe
         R85Q==
X-Gm-Message-State: AOJu0YyVG/2SCjO1CjVYgEo7vsxqat6iWQynFmnUrE5x41NuwUW8GKwq
	7CM1iMXDT0lCSHXdSCwKl+00zJljvvhmDrjS8dJZg8H4U7K0Tn8pzm55LyidA9Ux2EifR3mwECW
	mU6H4KJ4/Pcfuu3J0611ui6OzW+U=
X-Google-Smtp-Source: AGHT+IG7Vz+T5qXl228WIdHsyu+M/jpDgswlSvzOewXBN7HGjjAubTwZpX8iIycVwNxPh5j/KRpzh0cJdVcgtU6Cnww=
X-Received: by 2002:a05:6e02:b2c:b0:39a:e9f4:87b7 with SMTP id
 e9e14a558f8ab-39f4f6ca345mr177420315ab.26.1725467086333; Wed, 04 Sep 2024
 09:24:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Rob Clark <robdclark@gmail.com>
Date: Wed, 4 Sep 2024 09:24:34 -0700
Message-ID: <CAF6AEGvAEgFeoaxpkNw52fkt73RFg4g8+nhdR++m0ZhVsis=mA@mail.gmail.com>
Subject: Re: [PATCH V4] iommu/io-pgtable-arm: Optimise non-coherent unmap
To: amhetre@nvidia.com
Cc: "open list:IOMMU DRIVERS" <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>, 
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	"open list:TEGRA IOMMU DRIVERS" <linux-tegra@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Rob Clark <robdclark@chromium.org>, 
	linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Btw, this seems to be causing iommu faults for me for what (according
to a sw pgtable walk) should be a valid mapping, indicating
missing/incomplete tlb invalidation.  This is with drm/msm (which
probably matters, since it implements it's own iommu_flush_ops) on
x1e80100 (which probably doesn't matter.. but it is an mmu-500 in case
it does).

I _think_ what is causing this is the change in ordering of
__arm_lpae_clear_pte() (dma_sync_single_for_device() on the pgtable
memory) and io_pgtable_tlb_flush_walk().  I'm not entirely sure how
this patch is supposed to work correctly in the face of other
concurrent translations (to buffers unrelated to the one being
unmapped(), because after the io_pgtable_tlb_flush_walk() we can have
stale data read back into the tlb.

How is this supposed to work?

BR,
-R
