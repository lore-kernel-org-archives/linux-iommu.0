Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BDE433E8E
	for <iommu@lists.linux.dev>; Thu,  2 Jul 2026 15:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783004727; cv=none; b=CSRbacIJr+48ACDIt6NubaWofj0SaUCaROE/Qmdxd7npgbT35MPjHtQQbrd5CTWn6pPFR3fxDFEyCd5IPH5Vv7wObhCoaDjbek8rSuJ1ZFqxBBqMuS+Mx/ywcuj1Il+oXGlU10W7ts2B3vP5Bn/33IOG6ETDNDNHRLlAoVJr6Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783004727; c=relaxed/simple;
	bh=YCpC3z2Mm9LjQyPLfuLvO28v7VtBiXIyE2W8Vn+gKdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PS78OAaPtBTN4X23HZbs6n9njxGEKRjvQNJy7lcy7MJbUQJ1qlmfDxmmjKfQ5NpCnEcJYhfVA7BRHKpDiCFmjFHYrd38CjSEbqQw+RxFmuESe3HiT5lH/LTL2kTW9TwdYDq1E/xpNkBnA/KWZkVhnaBsa84A/lv+Yc5rGJDFOrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JbRr5ZxY; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JbRr5ZxY"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c10e86e52so627431cf.1
        for <iommu@lists.linux.dev>; Thu, 02 Jul 2026 08:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783004726; x=1783609526; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XSio1tefA8hn2ItHYltO++r3B3H0zvF625Ng9n3K4Tk=;
        b=JbRr5ZxYKamber8rbMp3zFYnBfL9tOox2sB49RLzmxS6MVPPf7flLLfbQAik75R49s
         hRQvrvQJbAaj2EOUNDJ3eWxvpvmBBYlthClHBod+n3S6ZgIjqA/Ds8h7PxDkOBkx0aT0
         4P5Cu11dRa9D+F7kfSisXcH/HZwcBT9QHFzSUC7fEt+aVmdr0RSlRIih6xLWP9+GeSOP
         z+8cPMpSREt2a8wP4q0Y8xbRew+lRk6XUbgxrK83liJzGBRB5zmln7rFX/s9ZgJKt+Qd
         Pn4wBpyZPHa/74kK1LZwuTQyM9EipMf7k8c04gWOClotc9NuENR07Xlb0FzJ9Y3uHXZ9
         7rCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783004726; x=1783609526;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XSio1tefA8hn2ItHYltO++r3B3H0zvF625Ng9n3K4Tk=;
        b=EZHrJWP44o9w+Yz66wwgJbFW+xOBFHMmHfjzPzl3+KblhTh0AvfJhNSE8HpWmCXWOy
         e4/5PilI3dD4ayoEX3u9aMesRSA2rP2/mJAxwgLVxPdEL+aBT0rmzcqTnDimm/ZkrpQ7
         WvERGAKS7/ALBLVinNnwPIFlP+SIfdflTw6nufivqYS/rm0OvF3eTexcd4ncyh5iozcW
         108M1XOBmBiFYvpEoQAAELmqc54/z4NoI9la7Z1zqg1xKDFWFp84QkvfgSR85U+bw+kS
         x0vFHI/Z2SL3AnxHtQ9oNQLrj1Fo1hzgXaNv01jNrJtZIx1B8/KJAfZcy404/4WhmsBu
         /Alg==
X-Forwarded-Encrypted: i=1; AFNElJ+iJw0lisLWRrjJnDYLP+fKmhmdMn4LlKedgizS7cIpdyjayZielNlq9if3OVq0QxXYFhgPhg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzSQttSEDg4f6Jrr3r80FLDmpDPAl+7NssCXM66DlqW5wl9q891
	DIRpxwN+MKE4I9dYtqWx5OdWX7Csu7d8PeLS1/2KxTV+hRdn/1jyliCmq1/B7VAG9WxQmJ4iZUM
	8CfgZpA==
X-Gm-Gg: AfdE7clK2F0G37hx4DKzGN7JO2K+lMTiW425r5Jed6GsQV75PGnB5MEGxHeaP1zjp+h
	L7d67HzS76SuuW2klvckrYRAk5z2DIZbbsupulPOVO15I9snF6CbssHe3ARoaCSOp7EFjT1pBwb
	EUrNMRHCAerzszgtwCAi+ELME31SJK39V5avp82GS6V2ZYkDi9Bv3gP3J/pCGpELtQagUKBa7Wl
	LG00CLledVFfuqXliSTmSBd92lzomD0UoKxhW8FQWInZqfrtNOoLBDAwb2RM+YU27Wvpz2FK1zb
	q00Ugrx2Gmx0py0D6VQ5RVWdmqVh+nCoXYavpSSyFsW+D88IFmAgiQo069W70UXDPMk473PF6yW
	HsCDjdZwea4adQ075dmYo/iDwBQBO9o+4N7cSlS52cM4wwTvZDi0MCCr0KWmuTBORDGAWWKOtdg
	6jV4iusdqzXncGDisuD7Aitz80TLyVbmwv1+2bNRcrybo9bgw=
X-Received: by 2002:a05:622a:1811:b0:51c:d16:b48e with SMTP id d75a77b69052e-51c3191132amr7766811cf.22.1783004720401;
        Thu, 02 Jul 2026 08:05:20 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cbec93a70sm3241630fac.11.2026.07.02.08.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 08:05:19 -0700 (PDT)
Date: Thu, 2 Jul 2026 15:05:12 +0000
From: Pranjal Shrivastava <praan@google.com>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>, Kyle McMartin <jkkm@meta.com>,
	Breno Leitao <leitao@debian.org>, Usama Arif <usama.arif@linux.dev>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Shrink command/event/PRI queues in
 kdump kernel
Message-ID: <akZ-KIVJlmP4LEcQ@google.com>
References: <20260702112825.781750-1-kas@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702112825.781750-1-kas@kernel.org>

On Thu, Jul 02, 2026 at 12:28:25PM +0100, Kiryl Shutsemau (Meta) wrote:
> The command, event and PRI queues are sized from the maxima the hardware

A minor note here is PRI & EVT queues are disabled for the kdump kernel
(see arm_smmu_device_reset). We could just mention all SMMU queues are
sized [...] in the commit message. 

> advertises in IDR1, which can be several megabytes each. On systems with
> many SMMUv3 instances that cost is paid per instance and adds up to tens
> of megabytes of coherent DMA in the capture kernel.
> 
> A kdump capture kernel runs from a small crashkernel reservation and only
> has to drive the few devices used to save the dump, so deep queues serve
> no purpose. The queues carry invalidation commands and fault records, not
> DMA data, so dump throughput is unaffected; a shallower queue only bounds
> how many commands may be in flight before a sync, which does not matter for
> the capture kernel's small device count and modest I/O.
> 
> Clamp every queue to a single page when is_kdump_kernel() is true. Doing
> it in arm_smmu_init_one_queue() covers the command, event and PRI queues
> in one place. The command queue still holds at least one batch plus a sync
> (256 entries on a 4K-page kernel, well above CMDQ_BATCH_ENTRIES), so
> command batching keeps working.
> 
> Suggested-by: Kyle McMartin <jkkm@meta.com>
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Reviewed-by: Breno Leitao <leitao@debian.org>
> ---

Apart from that.

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
