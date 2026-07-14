Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D1A3043CF
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 13:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784036011; cv=none; b=cBJxtiKAcgyq3mIZpQpMjCca5ufguCvjQGsi8CoqKpp/zCR9YT1JS+93to57WlhG0aLCkRxYXkjgHeOuJq/KKNg4AqTxQjb/Dl+fysHUtlrAVLECvfRtoNdV3D75gkvsn2AY7uFh4S4+ARRhOX/2zghQTyZEDbVsZWdmbSYTDa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784036011; c=relaxed/simple;
	bh=ULDnWMH5nVc0QO2IzjbnmdovlthlsVSlWZXQDnkobP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6zUZBdU4pZnkvYCdW30E4r1bOHxG1eghfPpApisRV4EEvVuHmkCL4DfdqW/b1HnlQ6QecKI83FqbSGOvglKHR1hpjCWitOkk8t54JAacMcpGFxLZdtQGYMnuavp3RgHhg6V0mmyqAXBP6zPJd8juau4CpU6hjStkOrAfLoycTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jY/rUiOv; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jY/rUiOv"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c01c79467so295411cf.0
        for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 06:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784036009; x=1784640809; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZffwBF6hhGkwheo3CTBU68dVv5rF3zKRAqSeKFNznAQ=;
        b=jY/rUiOvb8u//YDftoQObQoLXCTP3vRZfz88USbYQdcVoXjXGe9yIJun2rlpJLja6S
         eOyHi98Sn8ruMDtKeeiT0jFsZgVDUPKX3GL3ZbK5lj73PLVJsoJU34AU6OyyQ7HaWNyC
         GsbAeU2MAVGqObmMAeNfbtxJeJ8qna4PG0XAVkO74iBoMHJDQSvSvoS+FX/eJR6Vh0I1
         7Pw5IHjvqeZ9+dGC51PPQatMQed9ACMh9VZEFzytoXx1lNmnhKJFCBB03BkJaeELanHX
         D3lb1UQDuQ3ZSynNNFkcR5an93MgbagcLznONull61db70Mx1uDwKi4t0eOI7VLt0jE4
         7qlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784036009; x=1784640809;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZffwBF6hhGkwheo3CTBU68dVv5rF3zKRAqSeKFNznAQ=;
        b=BT3fY9MmnCCimMPgMp8hjlg10V6uLdF47/Jc9qGXqdP/cZXjwd/UDkp1h8slksYXdd
         +8uSjhX4n/akLqFkq/k1nDbNW84fqLZGvENAinVeM5Y9+WogfWanUhPAEmpxIJgujJzj
         nu9JOZmW9I7X2Vr6O2YPSCj+v03TDYILs4Y4zrHGzgEe2zCxcwOQSprSYK5ckLb94C9P
         22EIWO6wqYy9VT860eVd1Iao9ORO0VUuVlyrPQfKS5o+wh3pJYY9zsuQ4hxewAqh7h9A
         TxouTtng8AMhksqtOi+Cs06NLmiiSR53bv+P4pAN6iluzXdIYYm3cz/X2TXeOiP/9Szw
         kQiQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp5cmlEUC55S6jq7Lvz0ssShss12Nq41rSIH4m5+BPx2BeVqdt7cMmxjxmjQe61T2LkFCzSUQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxPSrZHWnmPL8TmCmYVYgIcNc3XgXB3uX3Ns5Q05aHYuCwn4h0v
	TTvfYtB9uGpY7mwcLONlVdfW3aFxW5Uj64D5ns4cI3gIOq6TurN/T62IyK8IXEmKIQ==
X-Gm-Gg: AfdE7cmtRTSZjQMkgA3egovZGxo2+nvak14iBDfBk3VSTsu9v7f+jd6nkRwNS3YzwJD
	8gdJfI/QiXqZngMRNSnB8RwDpPcb2HyqamYZ+FWWZs9uDKf+hGozi8VmY1qMurqq1wzq1ud9QYr
	HK2tMQ7PgDTGxmg/5avUQYpibHgoCuiY0pBMhYxmDklpX5GhOTKdsVwXpyAb8P4nmpl9hQ+CYqR
	IC11aCp/UYqO35KaOa+mjPASsW6VuzEmJBoUkkuHSGN6y6K7gVBq3xa61ncAU1e3T2Gv/xes4W4
	USGmM46QRAyqiCpls6PP6BSXIgh3C0mZjcWU3Z5K5keIpkKWw8PEbkfVMWJq56p2bUhBQtEuDrQ
	KCAV6yJfHGDQvqjZ9cx99CsbYvnin9xd5Bvb7PksGGmaMTSNfBkyAjUaPBZok9rLW4Rrg+IGOWZ
	5F0P8d3Y9jTUfgaIrLMaHKGYqJF6KzVbx52+22uOzwl2fPn/4=
X-Received: by 2002:a05:622a:4d:b0:51c:ba4f:9d19 with SMTP id d75a77b69052e-51d7bd752e0mr14354651cf.19.1784036008463;
        Tue, 14 Jul 2026 06:33:28 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-973a671434bsm3864983241.3.2026.07.14.06.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 06:33:27 -0700 (PDT)
Date: Tue, 14 Jul 2026 13:33:21 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
	David Woodhouse <dwmw2@infradead.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] iommu/arm-smmu-v3-iommufd: Convert cache
 invalidation to the core array loop
Message-ID: <alY6oVdehDZeeriF@google.com>
References: <cover.1783539724.git.nicolinc@nvidia.com>
 <e21c0adeb86fcb82238b1f9d29f7ba7ae423ea47.1783539724.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e21c0adeb86fcb82238b1f9d29f7ba7ae423ea47.1783539724.git.nicolinc@nvidia.com>

On Wed, Jul 08, 2026 at 12:44:19PM -0700, Nicolin Chen wrote:
> arm_vsmmu_cache_invalidate() allocated a buffer for the entire user request
> array, walked the array converting each of the commands, and issued those
> converted commands to the cmdq in CMDQ_BATCH_ENTRIES sized chunks, carrying
> the sub-array bookkeeping all on its own.
> 
> The iommufd core now iterates the invalidation array and re-invokes the op
> with the not-yet-handled sub-array, so the driver only has to proceed with
> a single chunk per call.
> 
> Instead of a per-array allocation, use a fixed on-stack batch to copy from
> the userspace array. If the copy fails due to nonzero padding (VMM violates
> the ABI), fail the entire batch.
> 
> Convert the whole batch before issuing any of it: a malformed command is a
> userspace bug, so the first illegal command fails the batch as a unit,
> issuing nothing and leaving array->entry_num at zero, the same way the copy
> above bails on nonzero padding. A batch that converts cleanly is issued in
> full, so the op returns either a handled count with no error or zero with
> an error.
> 
> A zero-length array now returns success once the data type gets validated,
> matching the documented probe behavior, rather than the -EINVAL that the
> full-array copy helper would previously return.
> 
> This also fixes two long-standing bugs:
>  1) On a conversion failure the old code reported commands that it had
>     converted but not yet issued, so user space advanced its consumer
>     index past invalidations that never reached the cmdq.
>  2) A zero-length array was rejected with -EINVAL, although the uAPI
>     documents it as a valid request that only probes the data type.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
