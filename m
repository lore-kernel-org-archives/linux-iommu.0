Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD282AD25
	for <iommu@lists.linux.dev>; Fri, 14 Mar 2025 08:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741939932; cv=none; b=Al7hyuWr/V/FUVTY1l9XJOXaE++4rC4iZayjL+bEK9u4Kx4tXFtrDGiXiW25R167EbVkAHzRERrOS4BnZwhzN6bDAJM+O25zMbMMdk2V7i9LtzriefC8UkSE8lRvbeRP6y00mAESpIVkO/E39jGpw389fV6ARk0WS4p6ZU5K8c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741939932; c=relaxed/simple;
	bh=8cylVulYPsuLj2+UhzkDhFzJQRXHh4cjgiNVztEekzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nuiMrQXqYvhbhTOmrTxlpUSUzYx0VZNehO9NaA6OU3Kfude4Vhtymc+/l0f1Ko9jnZ8LVXzJIpu3KhmdzkBqre3jj/P1UGqsXC2gsapmhskyIn05JxOBkfIHQkBsN3sHBJjEKYXctUF/fNM2zxgXKvfTwAwy8WkqIsx+ltwRSDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s+oa1AR/; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s+oa1AR/"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-543d8badc30so2115566e87.0
        for <iommu@lists.linux.dev>; Fri, 14 Mar 2025 01:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741939927; x=1742544727; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8cylVulYPsuLj2+UhzkDhFzJQRXHh4cjgiNVztEekzg=;
        b=s+oa1AR/BSzHd9CbkUN184vLMBJGk3GhnDqjMYeNfn99ZfvDqIr90SjGgfxSuZfU/i
         2XugKqffTMzT59eBlTrayTIDRuOcC5sYPoIpFOSyTC9AZ0VXjRC7g4cMHJ343mdNM/7e
         XTjouAqi2OXEUvYFPpxSccpXBSFftDMG0PfxcXeppjTXfHJ01mk44QvTo406Cdw+IuDe
         mGgYVDcMGErQlcuDgGOiCuDm6oEw634VVo45IqdC13Q+7Twl85TSfZrPPkfQfciqpU9y
         C6jReHMPFskU2szhQwSLzE/6SKAKWwONd1l4vy5IH5mumqccqwPdlmhR8Kb3Y/9xPVSX
         74mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741939927; x=1742544727;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8cylVulYPsuLj2+UhzkDhFzJQRXHh4cjgiNVztEekzg=;
        b=LXs+E4eiro9RfxjfUNVastH9Yn/pqMZ+tn3iva48AYyj9zfhOoNBfiXAVCu6ueRVvM
         UX4mkOTDEeFc92CNDSUlj3l5zo/tQ6NzrGIs1Exm0m5et/ThEZB5ACJJLfzVyf+3x/kH
         OABbEXkAJdV5XFzh6hfuZBt0GJboX6+VO2KnyOuMHMu5u1i8vUtQDp5jU+0tSFuxKHuF
         s0o/pjxr/AiB20rDRsgf4pVbJj1qMc9r14Lb80KKvMD3iMCK7copzIp1lFA1jvfGruK5
         JA5b4lVcsAxYe7umStcXrhA1a6o6Ij4tQqA9UxNRsKpmUGOEusAvrIuTRV42lEzIBMKH
         0FIA==
X-Forwarded-Encrypted: i=1; AJvYcCUAZI9GaFThZVaKFDvuWHhLPNqvryTcKNtjVel/AmKvOyCcGxgxogjRZ5ldezhqaGLrKI/J0g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFEPaKHmw/VNO1Am+QXYB7K2b8bYM0MiH885ar3dH6EZ/rk1tP
	rezpzjp4oW/gtnfJTe2EfOCJfBGs3gUFwADtWMJsiL8MQyQ1GH/ykMzr2AW4cRY+20L/mBxemym
	N2wGDJFzthQ1Ng3LBcEV001aECoqG5BZ5fFWj5w==
X-Gm-Gg: ASbGncs1crQCvRzy5+giq1h/yuCb8RhTk+Q77Cd9e8ECHEXXjxwGIQVbfYoFaanofr9
	l44wO6lN5V5HnejhtZKpMD2cXwL7xCHDrRk5V9H21aGdVAAqu/XovK330M+FOzBGzWZBqWzackX
	oHNdf/Rp5mpf8IyRJXzQNXIj7cQIbxRcU=
X-Google-Smtp-Source: AGHT+IHGGeVJFh8IQpmki3V8LS3prqRn4mV+TlJsniBWV8GinnRd8uZ8FEwuJhvhNULLOQP3lZKdtvLj/4wJYkEQLZY=
X-Received: by 2002:a05:6512:10cd:b0:549:4e88:2e6a with SMTP id
 2adb3069b0e04-549c38f52b3mr415545e87.6.1741939927425; Fri, 14 Mar 2025
 01:12:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250313051953.4064532-1-baolu.lu@linux.intel.com>
In-Reply-To: <20250313051953.4064532-1-baolu.lu@linux.intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Fri, 14 Mar 2025 16:11:56 +0800
X-Gm-Features: AQ5f1JoAIzauNjyPIPxiG7nniTwbUahcmK3Y--Iy4ho8pIyBMKTUSfeN7GKy6pY
Message-ID: <CABQgh9G2kTqWvjDTMupCJ_YNMxTg75PwgooMSsvEuT_hvemvDw@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] iommu: Remove IOMMU_DEV_FEAT_SVA/_IOPF
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
	Fenghua Yu <fenghuay@nvidia.com>, Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Hi, Baolu

On Thu, 13 Mar 2025 at 13:19, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> The new method for driver fault reporting support relies on the domain
> to specify a iopf_handler. The driver should detect this and setup the
> HW when fault capable domains are attached.
>
> Move SMMUv3 to use this method and have VT-D validate support during
> attach so that all three fault capable drivers have a no-op FEAT_SVA and
> _IOPF. Then remove them.
>
> This was initiated by Jason. I'm following up to remove FEAT_IOPF and
> further clean up.
>
> The whole series is also available at github:
> https://github.com/LuBaolu/intel-iommu/commits/iommu_no_feat-v4

I retested this branch, and it works

https://github.com/Linaro/linux-kernel-uadk/tree/iommu_no_feat-v4

Thanks
