Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5201EEE6
	for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 17:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702917; cv=none; b=LjAJDvVocAPGfjiCbjUfB1Ho3POErj01P5nyu4t9+FC2lrcpnaEj/AyjxHhI7rV0s3Yult/nxlImLyYfl4R032tqnpZ67Esz2u3UJ9wGIqGvgGPvPZX8fv/wSnOmBzoVVhan99amUN1g5jMdgqRFB3Thn7koEWAxGHiUCyvmkCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702917; c=relaxed/simple;
	bh=oLlwgxJ/hzRXy8GFi25yVUWtdC3YIOvF2/fOjbuZurw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnbhEJqK2n3nNaR/RRa/6ZGWnD/FvvyAUYlkPWOSgOa2NRTH4a1HFtTCNdsQ+4/2PjGDa+UE4kZ4eHF+IKRag4RjHTYeW6xRilyfONz8gA++4GSJQr2E2/4NYHzkvYG+HV+6+DPWk7zXJWGH40OFn+c5iLNGiSM08yVMRL3oHtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OBwSeVHK; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OBwSeVHK"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c0cea8883so9143061cf.1
        for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 10:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783702915; x=1784307715; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zwCO1//q+s3YukDP/Z5Z7eubEGo+AIobT+lx9B201YY=;
        b=OBwSeVHKYFutOtpmAQIVHyLmS28CaIkY6PEcIl4iXRyjl74dlFdHhKOngvs23OCFRW
         84R4fnMmwECs9e40JfsIWU4wAqCmnareayIwvDUqwRqjP2oUt/0RWlDPguqO2Sh99LYi
         FIu2sQ8j3VW4EWSqgDQOedNFNmjrsFwjZehxe03D3gNPOjvVJP3TV8FX2T26Rpm0jJfM
         vqTWPylAwfr/W3pbbRnQvrrepckxtC7U5TkWzf2jJkA0Z+saOq9HuDj17yrt3qzkrOQn
         ptcxP/DBuxUZWXOs8FtuwjrEdCXMi4hYZn37vSJhbFXDlRJoJHM91hFBF7jhMOPcqntf
         QiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783702915; x=1784307715;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zwCO1//q+s3YukDP/Z5Z7eubEGo+AIobT+lx9B201YY=;
        b=R3Y8Ust8IqZ5B9Szs/Z62DvMnunAbDRsXrDdoj9xcSmczF9FAH40E79jgcvWFUg6L+
         MRYQx71c6OdDk0nzTVLCTGGaGhgTzuXgOqJCVpyNkxWPPv5IgkNu15GCR5WYwn/Mv/wi
         140vQYEXCkDtwg01CmBp01pbSxDfr6xwz/L9p6mSgf2AKvQMAKmiWN+JUJZRPvD88yg2
         T3cPilyLk95XlCxr6BDFT+1pGwc6ObMn6p1jYbczVtokiXnmWavNjvj3gXEaOkiPi7gD
         R3AGZRrBXWsQismzBh0Oj8T2O14ouH2lkcnfGYnGY9qfHwsG8q5MQ3DtSsTs+1wfHDZ5
         yKGA==
X-Gm-Message-State: AOJu0YxL8meXFd+i/Ergb6PkWPCd1ptLDWuWaphaLp+Ntme07VAPjf2g
	OAbOZ11mb1/FNI1FYEkXO5IBl0Kj00WHN11N23UVS8xCXZokn+OAQD4OkSASBubJ1bM=
X-Gm-Gg: AfdE7cmwnBI77gykWoI9I3XuB3hURdIXYWYOlN4iiZ/GUOu81NtvBohHtq2oDW1x4cF
	SdFGdMLbkYU5sTNM67oZRLLPgGO4AYgCGyu4WmaFuOdKJZ6VhltqQ/Tc2ZhKn5iXv351IPaImRt
	Cwawv3V6nLNCq11iYTdKZ3fZzMsMaptZ7wMrL8b3fMpxK9qpSI0ZJGIXvrr6ejDvXgzlNq1IkXK
	usBBnRAgp0I+IUPw2n5J4sLpmC2PIMJcUjDmx3ASICQPoZ9rLcUZTojocl5QO+jZomh+ROeeGLu
	7+uSfQJ7U3sAboey2EM2rx2Blu9RH3zLE2Fb9d0sLU30/BrpmJh8jgLHYeKaLOPCLViH00c3reO
	ATvqLg4muLYz0nSAO5xdCjt700+O9REKsTzk1XU6/fOYNO9oGPI7kuNXZGFuU
X-Received: by 2002:ac8:5fcc:0:b0:517:5ed7:d28f with SMTP id d75a77b69052e-51caa476931mr43472331cf.25.1783702914518;
        Fri, 10 Jul 2026 10:01:54 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51cba49439dsm6020111cf.27.2026.07.10.10.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 10:01:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wiEbn-00000007aTw-07zw;
	Fri, 10 Jul 2026 14:01:51 -0300
Date: Fri, 10 Jul 2026 14:01:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, nicolinc@nvidia.com,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	nathanc@nvidia.com, mochs@nvidia.com
Subject: Re: [PATCH v3 2/2] iommu/tegra241-cmdqv: Fix CMD_SYNC use-after-free
 on teardown
Message-ID: <20260710170151.GC1803712@ziepe.ca>
References: <20260629094106.251694-1-skolothumtho@nvidia.com>
 <20260629094106.251694-3-skolothumtho@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629094106.251694-3-skolothumtho@nvidia.com>

On Mon, Jun 29, 2026 at 10:41:06AM +0100, Shameer Kolothum wrote:
> arm_smmu_impl_remove() is registered as a devres action in
> arm_smmu_impl_probe(), before arm_smmu_init_queues() allocates
> smmu->cmdq.q.base. On a devres unwind, whether a failed probe or an
> unbind, the queue is freed first and arm_smmu_impl_remove() then runs
> tegra241_cmdqv_remove_vintf(), whose VINTF deinit issues a CMD_SYNC on
> the freed memory.
> 
> Observed during testing with a QEMU hack that makes the VCMDQ fail to
> enable, so the impl reset fails and probe aborts into the devres unwind:
> 
>  platform NVDA200C:00: tegra241_cmdqv: VINTF0: VCMDQ0/LVCMDQ0: failed to enable, STATUS=0x00000000
>  platform NVDA200C:00: tegra241_cmdqv: VINTF0: VCMDQ0/LVCMDQ0: GERRORN=0x0, GERROR=0x4, CONS=0x0
>  platform NVDA200C:00: tegra241_cmdqv: VINTF0: VCMDQ0/LVCMDQ0: uncleared error detected, resetting
>  arm-smmu-v3 arm-smmu-v3.0.auto: failed to reset impl
>  arm-smmu-v3 arm-smmu-v3.0.auto: probe with driver arm-smmu-v3 failed with error -110
>  Unable to handle kernel paging request at virtual address ffff8000891e0098
>  ...
>  Internal error: Oops: 0000000096000047 [#1] SMP
>  ...
>  Call trace:
>   arm_smmu_cmdq_issue_cmdlist+0x320/0x6fc (P)
>   tegra241_vcmdq_hw_deinit+0x98/0x168
>   tegra241_vintf_hw_deinit+0x5c/0x1b0
>   tegra241_cmdqv_remove_vintf+0x34/0xec
>   tegra241_cmdqv_remove+0x40/0x9c
>   arm_smmu_impl_remove+0x20/0x30
>   devm_action_release+0x14/0x20
>   devres_release_all+0xa8/0x110
>   device_unbind_cleanup+0x18/0x84
>   really_probe+0x1f0/0x29c
> 
> Drop the VINTF deinit from tegra241_cmdqv_remove_vintf() so the unwind no
> longer touches the freed queue. Quiesce the VINTFs earlier instead. Add a
> device_disable() impl op and run it from arm_smmu_disable_action() while
> the CMDQ is still up. That handles a live unbind. A failed reset is already
> handled because tegra241_vintf_hw_init() deinits the VINTF on its own error
> path. tegra241_cmdqv_remove_vintf() is also used by the iommufd viommu
> destroy path, so quiesce there too.
> 
> Fixes: 4dc0d12474f9 ("iommu/tegra241-cmdqv: Add user-space use support")
> Cc: stable@vger.kernel.org
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h    |  1 +
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c    |  2 ++
>  drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 15 +++++++++++++--
>  3 files changed, 16 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
