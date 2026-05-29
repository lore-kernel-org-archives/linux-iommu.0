Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068AC34A3DB
	for <iommu@lists.linux.dev>; Fri, 29 May 2026 00:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780016380; cv=none; b=ZDW7kvxoGHbC2wKYxJkPQjaOteGiaiCxaNtRMBk2B47IXP16xYAi7Zsda6Ol3Awyana7EsKHr6dZ1t9YFVvBKHc1wXUHHorDHU3ionF+AOBkX3XZ+RQMDrtNN9EptpAfjU/rFfbDBOrQTULkr/5CdksAoswG/m/XyGSJLsreOR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780016380; c=relaxed/simple;
	bh=Dkas1iK2Ba2wQu/7/v+v06OiX4DNgNdf6buX7x/57o8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0cvKrVw+RK9Y4suKtzC1GB1ficUZQSRzfJSVaxMqLWrQm7r6+m62m5bEpDZn+Y0FeRyCc8ERM3Kfds+VkdMFsOLyDbjGGWX30niJlW0FG4v67k4KUsqFdw0CELlpntG5I3TkXsMsli4ObgwU6BV/DiAC++SJImyj9cWwz57nwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=DmtTDdgS; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DmtTDdgS"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-913cc4d7c71so1464623185a.2
        for <iommu@lists.linux.dev>; Thu, 28 May 2026 17:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780016377; x=1780621177; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2tFoYpzfMUAkB3JpfkER88CdCEd7iFUbwdJ47mVqnAQ=;
        b=DmtTDdgS1V2YoNunWRpuZo0CnS3rkNUZ/+95ty/NNc7dPqtPla/8cOvRfMJvFNBaxf
         LpkrSnxOaBp2VOFNnJW70rRiiQYHLoVwMaB7b6Chojugm9wpJ9QOeZsW4O6h/Fzj2Ido
         zquUv6G8adziGh/gz1NVknygOvHznYQKVaB4j00WusVDxhj7E5/EHfEh1dShoN2X05Ta
         TMBzotjjT5Oxqv4QvhMVUoTT6yD+IFhGXvyV3RD70hZ4yVi7hy/30gFyAUQ1BHQ/9L2l
         ZLj1E37ciyx2OsOyWIq8iFBj9l+VJKmfGsJgy5mKuTYhd/7TbzLKAPSzaPAVHSwZVLV2
         z6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780016377; x=1780621177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tFoYpzfMUAkB3JpfkER88CdCEd7iFUbwdJ47mVqnAQ=;
        b=QmYgDGZONqtKRStlTajzDXaDOmGicnKPJVO0T2EAlc4FKCoeY5PafGuOOKIdNGyfpD
         EiInwSmtu6CjYwHG8VOX4UmFL7DVdXIoqERP2bt1WmewtzalzpxzOpDmvWm5n5phaEqo
         M0sexLaePl1kvNQPFrOfuB2nXmEHToG0FGCsu+OqWKrgqPaYnpDfp6i4KEqlZhk97YKm
         JIJ4pnscY7MuLzJaoUfqfZsB7RtSiYsCm7Jf1CZrh5beGc+nrPCLIczzToEEJFWcIYbb
         7kEX5Fw9ii7cqfTeOSe0P7+jnJyjr/Ywg80J5eI+SNVMUynnYRjGSoWm/aJQF86Ek9x2
         KHdQ==
X-Forwarded-Encrypted: i=1; AFNElJ9rRuYLbpC9GDT9gSYTlzJ8bYty8fjn6P/PlPz1XlKCuqJQJt1ue3vA2DH7wQx82T8mcnjaRw==@lists.linux.dev
X-Gm-Message-State: AOJu0YywHA1awVok1Xm1j+37GKS8gGLFG2qRDr20nHYqX9oD7rbXd/Og
	nFhEqcKGLm5Z09ivT/DCCFST4RvaS1/TB/7GcK/1rb2NxRnBD/edyocEYeNrZdZ7CPE=
X-Gm-Gg: Acq92OHkUTaBt4qyMDdF7CniwmuzItibYvLMl8Ms5v3hj5k66nCHOWObAZiGsHgzU8x
	dJBfGAmXTKNzwrp8nKUS5G2rhFyhXbCB5zxO8LduIfV1McGJdwB3XnkFAtitR+5QYHyIDxBaoW5
	jhCK20ConOcFx0hHvKYr3JFnaNUPevEi7zsqs5YDritIjUqiOzHdgm0ULHbSkl85kr/hrMHfnHZ
	tBQ52z8HGEvKM5N9F5UC2ncgO5UHB+CLxOr/tQqpdeTnJeI4TD6p8UOYtZOdkNWJFvuLeFxQMxV
	bcBefJuptw5mlMwrxBw4Lfq0GdeDjwEuqlIvEQtP71XYJPhIe5XGfjM0ZrNYegLKNcYDTJFOPiD
	BYQojebdl17nsVUPMcp/CNp87Sv93yRbFti9z/R9SQ3vvETi/AZjDqi1bdK8zCHfTwo6WcZ2ATt
	wS9xBAflY2D+wRmupGyLtZRARKOlXV5fx3l76xnlCsVmPq/joz5MGQjRQTKSZ3GPGMvb/PqoDir
	jc1Q1DhGtedxDha
X-Received: by 2002:a05:620a:6cc6:b0:914:aa0d:aa87 with SMTP id af79cd13be357-9152fd2d425mr108562785a.23.1780016376749;
        Thu, 28 May 2026 17:59:36 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91530135f92sm52883085a.47.2026.05.28.17.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 17:59:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wSlZV-0000000HBjx-3ea1;
	Thu, 28 May 2026 21:59:33 -0300
Date: Thu, 28 May 2026 21:59:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ashish Mhetre <amhetre@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	nicolinc@nvidia.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH 2/2] iommu/arm-smmu-v3: Issue CFGI/TLBI twice on Tegra264
Message-ID: <20260529005933.GQ2487554@ziepe.ca>
References: <20260528101617.4068249-1-amhetre@nvidia.com>
 <20260528101617.4068249-3-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528101617.4068249-3-amhetre@nvidia.com>

On Thu, May 28, 2026 at 10:16:17AM +0000, Ashish Mhetre wrote:
> Apply the workaround for Tegra264 erratum by issuing every CFGI/TLBI
> command twice on affected SMMU instances, with CMD_SYNC after each.
> The erratum requires this exact sequencing:
> 
>     TLBI/CFGI ... CMD_SYNC TLBI/CFGI ... CMD_SYNC
> 
> To get this sequence with minimal surgery, hook the workaround into
> arm_smmu_cmdq_issue_cmdlist(). Rename the original function to
> __arm_smmu_cmdq_issue_cmdlist() and add a thin wrapper that, on
> affected SMMUs and when @sync is true, re-issues the same cmdlist a
> second time.
> 
> A new arm_smmu_cmd_needs_tlbi_twice() helper classifies which opcodes
> need the doubling: CFGI_* and TLBI_*.
> 
> For batches that exceed CMDQ_BATCH_ENTRIES commands,
> arm_smmu_cmdq_batch_add_cmd_p() normally flushes the full buffer with
> sync=false, deferring the SYNC to the eventual batch_submit(). On
> affected SMMUs this would leave the first chunk's commands issued
> only once, since the WAR hook in arm_smmu_cmdq_issue_cmdlist() only
> fires on synced submissions. Force a SYNC on the capacity rollover
> when the buffer carries CFGI/TLBI commands so every flushed chunk is
> correctly doubled.
> 
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 66 +++++++++++++++++++--
>  1 file changed, 61 insertions(+), 5 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
