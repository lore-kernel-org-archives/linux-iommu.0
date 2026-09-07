Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FA34FECF9
	for <iommu@lists.linux.dev>; Mon,  7 Sep 2026 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788794233; cv=none; b=LGsKHKtk5OZt6icGa2irgA2qCVvLpLJAufsTA/hHSm4ZPEYu1sa+EUyoiadULD7joPkaH5JIu3dR3l5wLqx3FW93qibSmk6E8VhFXPRdI8ZQZaCpTpM87HxrDlPbAMTZ/uO0lJG8pM4DQQMKVvmjgpjkLLJRNsbW9b76ZBkWRPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788794233; c=relaxed/simple;
	bh=W9soBYUrQs9hrQ3vYMI015rHKFkkfuGC4CrmjKyM3uU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1oLQsjedo/g1toOOq4jHEMdyC6t4CfnrUb248AO2hrunhrpK0eoZYyR1HtOHKvOeajiw5yO4pm8AHE9fuPJtZPQ+eOAA7mCNi4nE7+XTXir7WHhwdOYB8gaQunDbK9JVHLE4bb6rnyAEZr5Dx20yyLmwYKZAaNOmCMXIWbilAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FyLWmHMI; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FyLWmHMI"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a6141a61c0so12943a12.1
        for <iommu@lists.linux.dev>; Mon, 07 Sep 2026 08:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788794230; x=1789399030; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rpQaMoBy+ANddHal2PnUV9pNK1krtVdl6eHRQ/UORPQ=;
        b=FyLWmHMItTGdRDKy++Tvs0Ju+goPt+kR8HB5pdr2N2aqlSLKE0yU/dTPAtYSYSEN9b
         UIP0h758Vz7ARtyq/bi01Vdf0u67lCG5N3rcVYEKar+BTzALZjb/anHLWUALHZ4zSLvq
         zFzyrnp2JgQYJNA03zRey57ShFDfqpqg16Mw26BhYsz67sL7BXuDcb2z9eNJKG8QUz8f
         w5mLuLaDGlSs493ZWpdCI4tOwRYO3mLhMWUJWzE9YbElht5jfkJQNtcKAXOJrp3ONPz6
         c/KaiX9Crz1vioPpzvfc+cFmC1EOCWbmWEilTJD1uL/jOidxIXk7/Hlb8Hk4+x/Ux7Mw
         0i4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788794230; x=1789399030;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rpQaMoBy+ANddHal2PnUV9pNK1krtVdl6eHRQ/UORPQ=;
        b=FGBfYDEVpMpSRxaRpjM5mCsqMkqHnn+yKGcYD/TTp/s7oPZvlNmBgZG4yLiqKnE1U+
         b7lM9e2fTtHyH/cQNoBM7blbWsvpN29K2TB4ywc/UhAQfDfFNGCEjks6/7Byvtowi0iU
         Ysa5SOH/5Va175UiIJFudooRF5scxpM9SlIGepgqlOynALKUcjFRG5P7ASQP0bnar+2I
         D69kzAJVrzhs6ySOgMjTdlp2h6syicmGgzq2lVc/Ityy4m7QPDO/RHX/FFZD3lmq0BxD
         CbgFmDSILwYGbLQHmCS70Ryl/eBi8edFLB+aFCFH3fKh8tc/r2QGlfmUcbUInI3q6s81
         Q6+A==
X-Forwarded-Encrypted: i=1; AKwUvBzRG4ipcycQvKhP5I9Qy8E/MAHUwNlMKI1vCTL6kNroKOS4VPfR8jLRVC9P/JlXKU+gNrjwQw==@lists.linux.dev
X-Gm-Message-State: AFuF++n90syuP3XizRdOMgZlNoctbaHMN7TirDpeBXX07kqjoxi/Ua8G
	SeczUDaGrCz0paB0zYU+PfsBaZkbBl1xm+zRLQEurKfgtxrotf5guCWy/K2g7TxHsQ==
X-Gm-Gg: AYBFou1hXMqjEIWTInC6ODFnxDFoIXNXluTKNDVF74JTunXqYMchMKM8yT/RzHuW3dr
	nplaTLbWG0kPfAYHGbi3MZqHT2aVMwK3ZjJrO2VqabzTRTTu633pKxuHnv6rn/X77WmY+n9T8aH
	rPbR6tN0DzrSy38jnJToeqvsJeuqHJFGyCPRnPlLimgN/p3D5qF6se2NAtqay3uiF4EvHdFRKCB
	eE1i9LxacJUWFKZUwMm5/55MiiQzbHBR7UC/NruayurxzhGD+WUYxfktdBIBFTzs5DYVLsJ4j2I
	DJFUxvsvPg3E4Q8X3yHqVPgkZY8T2TIOPV86FKRYuptBSP2klgF2BCrksKGVhqdW+VQMSmv8k39
	EUQJ3nzQgOLstoKqHIxzjxpEbUSlBpBfXcFaov4g3bQSnSrpzRXQuW+c6YNCxzMf/1ikQHcx2zg
	kuwlnf0z4d4XtxFbEuFdujK6IuLePdxt1X9ioN9oW1Tr/MiBF8w0/OnagdknzvNX5Q5x7LwrXTI
	X18ea7aewoodPh72fxGnZD+oTfclA==
X-Received: by 2002:a05:6402:a288:20b0:6a0:a317:9c47 with SMTP id 4fb4d7f45d1cf-6a7f6887515mr62121a12.3.1788794229526;
        Mon, 07 Sep 2026 08:17:09 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d5b29f3sm482498766b.52.2026.09.07.08.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:17:08 -0700 (PDT)
Date: Mon, 7 Sep 2026 15:17:04 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, David Matlack <dmatlack@google.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Pranjal Shrivastava <praan@google.com>,
	Samiullah Khawaja <skhawaja@google.com>, stable@vger.kernel.org,
	Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Subject: Re: [PATCH v5 1/9] iommu/arm-smmu-v3: Handle ARM erratum for CONT
 under invalidation with SVA
Message-ID: <ap7VcBXG0NyX6acW@google.com>
References: <0-v5-b810cf379bfc+13d738-smmu_tlbi_jgg@nvidia.com>
 <1-v5-b810cf379bfc+13d738-smmu_tlbi_jgg@nvidia.com>
 <ap7IeAfVPZL3Hqt_@google.com>
 <20260907151145.GY4157646@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907151145.GY4157646@nvidia.com>

On Mon, Sep 07, 2026 at 12:11:45PM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 07, 2026 at 02:21:44PM +0000, Mostafa Saleh wrote:
> > > +static bool arm_smmu_cmdq_batch_add_ril(struct arm_smmu_device *smmu,
> > > +					struct arm_smmu_cmdq_batch *cmds,
> > > +					struct arm_smmu_cmd *cmd,
> > > +					unsigned long iova, size_t size,
> > > +					u8 tgsz_lg2)
> > > +{
> > > +	u64 cur_tg = iova >> tgsz_lg2;
> > 
> > Nit: tg suffix is a bit confusing, I guess pfn is more accurate, but
> > no strong opinion.
> 
> I don't want to use pfn in any of this code because convention has PFN
> as PAGE_SIZE, while this is a "translation granule", ie the base
> granule size of the iommu domain. Which are not always the same thing..

But this is an address not a granule size, not sure what that could
be called then :)

Thanks,
Mostafa


> 
> Jason
