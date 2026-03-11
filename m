Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B02D2DF3F2
	for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 04:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773204200; cv=pass; b=RX6kqpxIWxyfEaS3LMI7MH9H1NWxifaVRvTqkc8vTNk/ymJQ65KG3OkYhQzMHJa2ZwSOsmjoRT/kxtwl1+sd24p1+sN0C41mUPH4S2yQrpfNWEh7Y69xD9GlAW+uj2jXmXHa8Jrg3W35yU5nsMrU1odHoRG7GQUv/DvgZwlWvrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773204200; c=relaxed/simple;
	bh=a8iVo6i4eHgUcnogYdzVithvam2BMdeOEaLsipziq9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O+2NPWBwKgQ/6NMQhqTUpECXgNx0qjB/7C59x0RdhAo2MvfFyNp09uD+j+G3gLV4BVMlrHOnLY+NEDy+YxvcD9HofrGzRXHNnzBgNrN+htJy0SZ3BZhdgG1qdhQjngKpiUI+Titz8VXRKQevtBNtd/iI0nZinnaiVBAgJwVlPrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lFtNvyH0; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lFtNvyH0"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50906a98ffeso386341cf.0
        for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 21:43:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773204197; cv=none;
        d=google.com; s=arc-20240605;
        b=a5CXxpWQRteBq1fTFkLgs32tha2KVY5MYsjA5UAHDp3+WgESoDEi3k4ggTocfQgdqv
         nLkMk2tngg9mDRxhJK6FxYNwKqgEX7FDJdKxqINAucWiGv9FjVe33cCq+XbvLnNB9rUq
         PJYNzieVprWV4MDcyF/jGOltd9ZNWQVAkE9ViD5myVn1Pfk2DUcPVqpTYJP97APuqJHz
         3aqyjBeUXcIxL/MahJEMpT0L9QDYL6ywB8DfyWYqG510tywiVcSkDWy1aX0fIWsR77Im
         CWeisre+54BfrqK4oy9cRxWDnEnNQW9gJ8+ue2PROUNF+ZvLhBi3IVOCJoqOMKriElUL
         sYSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=a8iVo6i4eHgUcnogYdzVithvam2BMdeOEaLsipziq9Y=;
        fh=Cr9Gz+4KxVp4Ci1moPY7g4WpWFGCr0a9bcVWr63STi0=;
        b=EU590NvEwqQ7ajFKS7NIIUPNsIatnbS32rCSVuhT75/FDlMUIZQwyNoZAACDRLZwyB
         pqGdZ7rRiYuuxtNb1W5sIitJK7ogBkuZdjzYT+G6H4LCavPFFs9gBBEVcyBvEGDB5GGL
         jgUWN0TRSutyeqYxrgXYCMj2bn3jBIpOodw+k6djTaqv+h7YG0MDZbOW6yqImqGTdrqD
         cFXG6xiGSoaRfAXwGHd95BObP79MoaoR8ruM4Zn+CYzUmplx4UPVtXJVQQpOkpZ/llpX
         qWWCOlwoTMJOOPr/sIEZ2he46fKL8CgNnJGiR41vtgPWmvs+XJiDGkGHbCJQFeRsld4u
         aJJg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773204197; x=1773808997; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a8iVo6i4eHgUcnogYdzVithvam2BMdeOEaLsipziq9Y=;
        b=lFtNvyH0tPDPJVTqZxJCZc8Feyy9+YAoG4h1oAE0bCPJ+h78Fwa5ZvpRmvKaZZV8gk
         +yclOwAbtqCYAb32r1yTjl9iK7oBpSzq3ihghQUW94aFDVpy5WqlZBl9mmvpjFth81Gc
         fYVr3xYIQehg2VVyFEddSyakcoa/lCXboPrz9RUZKM2a7780K8ePTlvmyFLPO2hNsGuN
         8/HpTHzV9ByLoVVKKqjU+fxtmQ3bgmFwgAXfiBBBp3PaQiFHROH7Ih4Ts7Tj9sHgaVOc
         0ywoGbfUEb2zsQQDVGZJ5V0QKjfWTSkfRt57wpdCkm47MSdb6tn9D7sFHShxKQLhvW9y
         sFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773204197; x=1773808997;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8iVo6i4eHgUcnogYdzVithvam2BMdeOEaLsipziq9Y=;
        b=b40s6bg5iKO4YHHA6YUPQYhXQj/OPiqj6RS01ZGxXl9AiJiwj98gaOHann32NwBGy7
         42VsT7/RrWz/zmJDYWTcDdnzjl+sItidXC8DKV4uDB6aPpR3/ON8Q/m3M6PUbwItWWj3
         aUb+P13DS7458OYp0psv/CHTtjvxpJR/JKzdxCBBUhs+Cix9RJlqdotvUyX8zTkF/tiX
         Y6hVqkfBIbT1cgiiKykQVjdCt+p5T85bi0qXum5nmbRiKOzjiqLclD9tAkkmqtsSFfSW
         q3PXSDBe+/rAdQ/ZWIUznbJfefuB0/aGlsCtYtl2UqBwnpKKXXK8Ts4RIFxvlAUrZV60
         wMdA==
X-Gm-Message-State: AOJu0Ywr3bmq7ChGdbYVQI0khpfiIUJejDLV7OO/s6gRm5z8AtiOf9sK
	ErpfMRYI5eugv5gSnSLxKWt9nA7T3I1Yt0bpa1jaKTzpgpy9iYOI7DnSZSHpPZbZlWzZn1Q9MvJ
	cYKQoaGDIYV3N9rJfUWMEKh4ceTeOPL8BuYnuznr9
X-Gm-Gg: ATEYQzylhBbjXHNnhL9gA1IurZrTyfQE0JyIRGa9NWEQ1E9D/5UHffCbcdupH+ELlug
	4VzMdyyKyITjpyq5X/0nisa7n5xZSxahRjUojGHUhnIye1P06CbhwDPFanBorMoqJoJGyLGeav1
	89pxCxg5rubrgSHNbmr23ZBsVru6aGjgGD0nZyHZfq4OlNayhXxRcAECXr1uUfnf0ae/TNu8GzY
	+GGOWZLThxpuqfzTHTx0teV2h2SesyGaXquxHAsc8k8L+tJ3xE016dOIK5FaC7BftlbPT2+ZGe0
	p3Iu
X-Received: by 2002:a05:622a:c9:b0:509:208f:3876 with SMTP id
 d75a77b69052e-509382cc3e9mr7712341cf.18.1773204196698; Tue, 10 Mar 2026
 21:43:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260126151157.3418145-1-praan@google.com> <20260126151157.3418145-7-praan@google.com>
 <CAE2F3rD0aoTXJBnS4SPHLEEst6cTvoUxNywRZ1RhdgwNA_0JTA@mail.gmail.com>
 <aa8jkLD0l2WqMnyG@google.com> <CAE2F3rBFRSTC7bFCYTCit1-OKrT3jB-fwYGu_UJbwX+7aE65eA@mail.gmail.com>
 <abBMy5MgrrOlofDF@google.com>
In-Reply-To: <abBMy5MgrrOlofDF@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Tue, 10 Mar 2026 21:43:05 -0700
X-Gm-Features: AaiRm51lq5QmG2ufBTfyxBLGgTLikSPASuLqFdCAAQxSL4-PE0bFSyUz0jt5iVE
Message-ID: <CAE2F3rA_uyYGx2PCHMpFPWD6B4_2WxK-ahpoRHioXfuNf5Mpxw@mail.gmail.com>
Subject: Re: [PATCH v5 06/10] iommu/arm-smmu-v3: Add a usage counter for cmdq
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Ashish Mhetre <amhetre@nvidia.com>, 
	Sairaj Kodilkar <sarunkod@amd.com>
Content-Type: text/plain; charset="UTF-8"

Hi Pranjal,

I have thought about this further and would like to propose an
alternative design.

A key difference in this design is that no commands are written to the
command queue, and the producer index is not updated while the SMMU is
suspended.

Similar to the existing CMDQ_PROD_OWNED_FLAG, we could define a new
flag, CMDQ_PROD_STOP_FLAG, stored in cmdq->q.llq.prod.

In arm_smmu_cmdq_issue_cmdlist():
Perform "old = cmpxchg_relaxed(&cmdq->q.llq.val, llq.val, head.val);".
If CMDQ_PROD_STOP_FLAG is set in the variable named old, return from
arm_smmu_cmdq_issue_cmdlist() immediately.

In the Suspend handler:

1. Clear SMMU_CR0.SMMUEN.
2. Set CMDQ_PROD_STOP_FLAG in cmdq->q.llq.prod.
3. Wait until CMDQ_PROD_OWNED_FLAG is cleared from cmdq->q.llq.prod.
4. Wait until cmdq->owner_prod matches cmdq->q.llq.prod (excluding the
CMDQ_PROD_STOP_FLAG).
5. Wait until cmdq->lock is 0.
6. Clear SMMU_CR0.

In the Resume handler:
Follow the same logic as your patch, but clear CMDQ_PROD_STOP_FLAG in
cmdq->q.llq.prod instead of setting nr_cmdq_users to 1.

One benefit of this proposal is that it avoids adding a new atomic
variable that multiple CPU threads might compete for. Instead, we
reuse existing atomic operations, which should reduce the performance
impact for server use cases where many CPU threads compete for command
queue access.

Daniel
