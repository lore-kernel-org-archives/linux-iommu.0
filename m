Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154CE372EFB
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 19:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784318364; cv=none; b=D3evuI3Necmsi1vVladPOHk6dKX3p5YzowD/IPuhRPd7RVFMTvh7mKQux6FdO0yWElW6ynARQohhMNknq7QkOc2rq9K3Jrn4hhay5pjQI5WIrSOxJzowgr2YwUssrGEERXJYKLdEJof3oM6E3BX1bZOkYhi7hbWNUnJ0oV1VhPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784318364; c=relaxed/simple;
	bh=LMQ7fUo3sorzck80ZDANF3wgbQwKbSE7cQhncLMM+/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mM7MfR9aySj7FuJNJ+7aKZITx56n+J5oCiSCBK/IlyPtvIGI6E0KlZj4OdhXxggCx0aiBn7pGakvaPy7J2U84gA2RObPeo48nOqTyNk2ElgiU4F/RLYQmHy3u7yRVHtRkDXXTrYzW+9Xstl/myhax6k6YCkKMyrBP43ZOXJXhPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=LjRlKga4; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LjRlKga4"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51e4ba1cfb4so38888361cf.0
        for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 12:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1784318361; x=1784923161; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qm69cNliseHLFEUcKlQjXlWgyg1L1lRsxj6GO+Nid2k=;
        b=LjRlKga4kBpnfvpAoMmh9dY2utM3k4opnXYNG3eWYRcSGB1CE+iV4q+sebuWUOhzot
         mE1fNadidPl3FE4N7oM1Ss9/Md19PGuBgQSsN/CYLrjA5nq+ph7v7pX9v/5ZimUzLFVJ
         iGsOayNqGWUWbsxGuqvCLq8WkU+pWJNXaRWLsqfWyCdCNFehjwPBb67/b7S7iLPBy5Og
         RQ31pyyA9UFJJjJqNArnoFoargrGertoGtp36XJiiupVALonSg7vgc80/HhRBDN7T2rx
         H9HBOtIvhWZmUGllLq+EPPNKdjn1KVJ+o8w6XxbmggYVa+QLpFD2wZxkQcUFasWc4lTm
         u+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784318361; x=1784923161;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qm69cNliseHLFEUcKlQjXlWgyg1L1lRsxj6GO+Nid2k=;
        b=oqcESfYVWCieNqHmbpT8H2hUObQw4tSamdzQnriJpmHxgPomhb2dMb9xnVJ4QltadV
         DxU/ptqo6w47Sna9cKovxq1xVuUZXGpoS2pRv4kwLiBz55Je6KNc1TziAwoXiLupKrAD
         J+7dmHJVBuFGyY4JzJuARTzcZ/CrOntTxvCHPYhxUWv4fptQe+gqa817QUVkCeZly40n
         ZzEVHYDaZ84byAY1F3TcM1Wke/s3YCBGLViC0Nx/i0A+iieUvYFi5xJOhnOhUx0KpimF
         ZSv3aqjOh51qUQ/sMsw7UEq+RX4Mu5TpzblQ4Nz9cccE4avCWc+n1Azrp4vC8COrCx7u
         97dw==
X-Forwarded-Encrypted: i=1; AHgh+RrCcl3wQUwt5+DJIOSkC+X3StA7YKVntdN8PZhVA2rYj8jiQo8FPk9Sg1vOEScC17B/iWriVw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywi0Y2VIvu2vw9DYnsUF4KyOdKGa+drRl+NmewwsEyw5mLQBRKz
	lyPMP5nDsDzVmp+FEzq+A3ALg5PCsf43asedKVw9MvicB5n+Xj5nBClfBfaX4/rLj4w=
X-Gm-Gg: AfdE7ckxTPTqjTFN/ye9Ac8GLnv83UacXpIIGm4s8kFCy39RWKXB/xDuSJbMfhdrpiq
	yZgapRipSB1Hpug3VksiUFJwmOUPnjkjjm6JTNxyrm8tPsnH5penwkJTqgvTnAkGjVon1iX1wtw
	x2P6azL3eLK7mv9hzDqnj/1CBnTKkBEB3hv8KI//u26JioPSRD9YFUfAp5YY3nY61eGc5T1hYF1
	i5Z4lTeCKLJvVmV0GMty9gtQH+pVF2r+qm8RV1w7COdNaKl6OS9huAfx36S9z9CPr5xYVtLxbxC
	ZGmx4kv4gC+rBjEWUIACjeq8Beh5mH/4RAGxeTGIjni6+0NyM/4EEwoMznf06Mcc6V9StxhKg/r
	40vhocNmL3+Wxm1PGqF8K3pHn5qvwV0tgfoZIthHwHgryuVhrJMOt+Bic6vPG
X-Received: by 2002:ac8:5f87:0:b0:51c:1291:e68c with SMTP id d75a77b69052e-5213b148393mr36523971cf.30.1784318360897;
        Fri, 17 Jul 2026 12:59:20 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5214ffcb2c6sm19444171cf.27.2026.07.17.12.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 12:59:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wkoiN-000000051Gu-1TIS;
	Fri, 17 Jul 2026 16:59:19 -0300
Date: Fri, 17 Jul 2026 16:59:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ashish Mhetre <amhetre@nvidia.com>
Cc: catalin.marinas@arm.com, will@kernel.org, corbet@lwn.net,
	skhan@linuxfoundation.org, robin.murphy@arm.com, joro@8bytes.org,
	nicolinc@nvidia.com, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v7 1/3] iommu/arm-smmu-v3: Factor out CMDQ batch
 force-sync conditions
Message-ID: <20260717195919.GB701389@ziepe.ca>
References: <20260714104202.1664187-1-amhetre@nvidia.com>
 <20260714104202.1664187-2-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714104202.1664187-2-amhetre@nvidia.com>

On Tue, Jul 14, 2026 at 10:42:00AM +0000, Ashish Mhetre wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
> 
> arm_smmu_cmdq_batch_add_cmd_p() carries two distinct reasons for
> flushing the current batch with a CMD_SYNC before appending the
> new command:
> 
>   - The batch's pre-assigned cmdq does not support the new command.
>   - The Arm erratum 2812531 workaround (ARM_SMMU_OPT_CMDQ_FORCE_SYNC)
>     forces a SYNC at one entry before the batch is full.
> 
> Lift those checks into a new arm_smmu_cmdq_batch_force_sync() helper
> so that adding another force-sync condition becomes a one-line
> addition. No functional change.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 23 +++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
