Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858CD49552D
	for <iommu@lists.linux.dev>; Tue,  8 Sep 2026 08:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788856752; cv=none; b=QfNMSInLU6kC5qJQ3AEBVPVEqa5tT9XzFZNbQzNmvYapUTJ2sYNz5PSAlqGd1yqG/Wv0Cc7HffUx0p+i+bMInFBN+wZU+6CfDmfRzoxSF/dy3OZ4VYsI7zGaErHqrs6HMtzs8Z+N2FhIGmmoKvgeoIZUV+iXvKoaUJxx3iY9uZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788856752; c=relaxed/simple;
	bh=Z+iz63taKQHo+c7eBYcTnzQttJ5PAsiNF5goSAmhfbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iD4ENxGljVT1VRqlPpL/ogEpNGZekIvPRRWZWkzKlX6khTwYAV8d9qCcecyMkSM/NF875LqtMW7/rYXPdRu7ocjeWFcS0OZTeOfNGDxZUskm2fxYFJE8KON0l912IaSikJ0u5LLgTi1n1ZHkgAxxJVX51crlCa0KUK+KX+SqAhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VXA5Ugh1; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VXA5Ugh1"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cda5e048fso106695e9.0
        for <iommu@lists.linux.dev>; Tue, 08 Sep 2026 01:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788856744; x=1789461544; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X2bt3KrEqZ1UzyjV8hoPZ5E3RfVTbXnZPVm0wr6pv9s=;
        b=VXA5Ugh12zMiOX5TFNl2mIkCueE/6YmNpOromEEyryAEJWlvn4TUV8xudFDH1k5LA7
         IaowLzUowEQQG5oS8DWPpSxYbsIRYPOpIq1BtjSDe21uHlyZxPyhJ4k7RjDOgEvcziCQ
         27PfKzQqlOxtWr8N1KaIis5Jqjn7rpelJFFn13IIPrQkP9/f/FFW1bzd3p098ynSRRQI
         +whn7+ozcH7bEcxVkjlTRcOowIT00BpMvaH04K91nQMxc0KNuygXWJ2/Wq4Q+EcWkn4v
         4yRvgq7JBP4PkpVFudLCyJP2Y8pfMGi0yS7Ro0ZE/YnlTKgM3Nlbvrct6WHvvY8TKTuJ
         rI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788856744; x=1789461544;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=X2bt3KrEqZ1UzyjV8hoPZ5E3RfVTbXnZPVm0wr6pv9s=;
        b=UX4e+8G+nuHk17eRlfgKnIcQPK9fq8+Ej/YtJiD8DRcbVCRFEkLrRLGuXW48QjZ9C8
         RwFsgjJHFgTYdpJEtDAgOqz/EkNxva8G7P8JDBzmnb83QVkM4pjguF9uKYwAyRZxFYx5
         RniN7cwUpP4CUUeKMJlYNd5shdX+jFx8lhjBgJsO+JhRRbsfp9LupbkRTlOQAa0lYGSM
         cP6DZWlhLxedilniaDp9Enrx4IB+bI1uWu7218aP6wUhPZmKZbPCPJY0sTL/PcGmqp96
         UWfxAYpM6zFcl4tRfJ7IH7LV/JlkD3qSNGHiau8P8ImNxNvLiw9Y/7vxB7gRCnHChlyH
         Mv2g==
X-Forwarded-Encrypted: i=1; AKwUvBxmxCvCeUFPhWY4QSwY1keVQ2E7lRQJC5gUwfumwv7Ti305prmOxIyl4LhPwmsyMKul6niAAw==@lists.linux.dev
X-Gm-Message-State: AFuF++kGr8pEPJAF2i/C092+xgiwHqUG6ZAydznPR8tNZ2EafP+eRPZr
	8e+jQLfgzJtCEzgS8Dk+XgyIDa8fr9WCNgdoNoGVY9KudntEPldlBvWYPoafMl0XXg==
X-Gm-Gg: AYBFou1oDldZcpdzRmJZLJln7cdOhslnDzGZ0lBHW68Sf7w4AbrmGlIAG4EjercAJ/c
	+8OqvJIVkaP0g1rJG3nKcc+wm6orfpY3/MIRacvjXd1S39WS/DZLcFDJaXYQo0t7g8ixGUVUBFb
	CPFt4vJPcZix2h5TK0T6up2NSL8hapSD8+WLw70LmQgiSaJjnkVh9oueBslmQs72JsXHfqqOL1W
	Zt1qu4JNAEb+U/pmhMqfyDrosRntIicV1x9S9JbHxE1IbDOAJidirOllNKB19BzdwfS7fUpkd4V
	5DlkuIEeaMzFCFk54lIwvuPGuLdbqt35lbvXfUQGr38QeRMKreMMxqI+3D2AWH+dQ5Bm6GYkOdA
	4c3hSRD0X9geQaqCU52wK1yX71T4HdGyr2LYuCZvjaLJEQk/sTQDVhw/n1bRPlD0n4Kemh06pqU
	Gi/JgQjUTqnhddOxqo7ay0Wg/qvIG+by1bbhEURU8/SuJT2eApKMSP31FBVgr3c0G2zkYF0okTz
	3e85HgoghOTtfoMLblBBcp/niaozw==
X-Received: by 2002:a7b:c054:0:b0:499:c46c:addc with SMTP id 5b1f17b1804b1-49d010d6113mr2292585e9.2.1788856743315;
        Tue, 08 Sep 2026 01:39:03 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d057f4778sm274178525e9.8.2026.09.08.01.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 01:39:02 -0700 (PDT)
Date: Tue, 8 Sep 2026 08:38:58 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, jpb@kernel.org,
	will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	nicolinc@nvidia.com, praan@google.com
Subject: Re: [PATCH] iommu/arm-smmu-v3-sva: Relax ASID requirements
Message-ID: <ap_JokRTsUHtF4dN@google.com>
References: <20260907154928.4012151-1-smostafa@google.com>
 <20260907184513.GA2543240@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260907184513.GA2543240@ziepe.ca>

On Mon, Sep 07, 2026 at 03:45:13PM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 07, 2026 at 03:49:28PM +0000, Mostafa Saleh wrote:
> > arm_smmu_sva_supported() have some residual checks for ASID from the
> > original commit d744f9e6c222 ("iommu/arm-smmu-v3: Check for SVA features")
> > 
> > As DVM was used for TLB invalidation and the ASID of the domain was shared
> > with the CPU process.
> > 
> > However, the commit
> > d38c28dbefee ("iommu/arm-smmu-v3: Put the SVA mmu notifier in the smmu_domain")
> > removed that support.
> > 
> > So matching the SMMU ASID space to the CPU is unnecessary and can be
> > relaxed.
> > 
> > Remove the CPU ASID related code, and update the print for the SMMUv3.
> 
> It is OK, but maybe this could also be but under an if
> ARM_SMMU_FEAT_BTM?  That is never enabled and is a placeholder to for
> eventual BTM support.

Yes, otherwise SMMUs with BTM would regress in the future.
But I’d assume non-BTM SMMUs will still be supported; falling back
to SW invalidation?

Thanks,
Mostafa

> 
> Once we get the last part of the invs code the BTM support can come
> back in.
> 
> Jasson
