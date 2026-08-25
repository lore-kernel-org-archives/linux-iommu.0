Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2053B27DF
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 18:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787683821; cv=none; b=vDiCSKZswd57r9O7/2xAnwJBQkiioQ1UZwSWCwvDmuLQzBJy6j1++l8kYoAplkK0LWqkB3bWZi4M7qu6wujZaMOQVVv9sbop3vWU7jerCCuuyu9Hn2KlslljY5Xesgcf7PA/F2j2F9UgoGhq/6yDAA64+XQutzBhD5vL1DZvwY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787683821; c=relaxed/simple;
	bh=VbVbcu2V1ddnHmuR2FBbG4jGovCOYAASD0GKTUp396s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSPCk90NoE2NnTnLYcjCMe9H7tI/K6ZFLpxLU1z2NkUZO6UFEWFtzgIlbspM6TBomfIwZG66dmUlpGxLZ+kddVfrtv9z6K8aXjaxLES0SBNk94PusD/NzA8uMhJwTPGafUY6XW4GIY09W6pKfFVz/k3My1qnFZWXCgOz9/Kmaqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k5yp5V65; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k5yp5V65"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ccdf36f63dso22495ad.0
        for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 11:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787683819; x=1788288619; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IRbI2pFTGedpFZKItftg9mg1Y8wfyMX80rcvxCZpP98=;
        b=k5yp5V65KPHKVxpx5zXD6QGzNdVyNCf40uPqkM5C70XBJu5GMDCyvrfU8dBVtDjZn4
         vCbcV0DF5FM1tNnzygRqmwHNa9P/RwGljo+fRczJhwcSNeYPkuw6Nz85Y0/epb0rRW5T
         5e1aPZVyCal32V0qj8qZraPxKe0Kf35hAX0P1LOnvkwMZnr8bhvdZ1GaEiNtCWiuINQP
         zawkkG0zTDDtXPYbj41vl7uga/WA+/ti4bFd/g7cz3BfHV0ISiU7qFtMGgD8VH83c98G
         7GNubpPiS7qDJwWMRdaposBNkFa/2Ui7d5wZxcBUd83S5HliYIQIzAp8WKuInAlwdM81
         ilaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787683819; x=1788288619;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IRbI2pFTGedpFZKItftg9mg1Y8wfyMX80rcvxCZpP98=;
        b=LViCPozI5fKLp1Kqt25guiYhMh6vmDnrDbEwzmDEw/i8fFpx3FoO8J96i/yTyVAgoE
         1HYVZNtk7NVrEEz/w1B4GNjZcKYH1aGSwHa2eiIxQ2Rg1qoGcRahw9MTPLN9GS5FBsAG
         A8uH8uywDptGH3X8PSuZtfCE6sL4XVTKGC1QlhCi9GGjC5o9zkE9/xizcPCfRBFIjgks
         +lJ2/rwjwkQzB++julmcO6m/98lodhNPhIieS7Vgrd57MRI4jKee8Qyu9aRFU6l5nAP/
         L2W8Cl87AQgzTvMSvPsWfYCFyU2NNlVQyTCLLWtRt8U3RlbKR/TakgEfzC19KcU6jSVY
         btMw==
X-Gm-Message-State: AFuF++kVArb1eFl4t9yY6ZhPOmXcYuWMEFXjQsC07IiMRu/2Bx557U1T
	qZhr8BnLmiXjvfPz/LjeytWt7ljtxnVOmtIBy2kI00OWngPrbB0tS9F0JgZ2U3ZvsQ==
X-Gm-Gg: AR+sD10yjTxahBOGhk4iRNaxcbrtkg8RpNDzJ4N9AqsFY5ugvF8vqSEk4BenazDQJ4p
	+nhpAyGSC6/Q8r1P8D/3W5USdhHiVf37ZUBN2qaD4/lfE8ETqFuX7mpssmygLDkS+CCNwhLKus6
	hlzjGyeCvs/tSgIHJchG67rMJrS3KrBZe0eGMqg5ZNMlMjHC+LAFvINCeZG/iuXurxaRVa5Yh5Z
	eA6fUXTSXRZZ/22x6x9ZBicxTvVt+p3cg4u0Z0fssAHA1omVwsh4xzkS3NGgIASCItOwwgatn3W
	/8vENyqk1euJVFrbBo9gyS4rYJGy3h8I4McN4pHfqHnUltIBZ5w3+K+BnDrUUEwK58U038oF3qg
	a84dEEKvuxUqOoOa00r09PH9ipLjKvVH5dKZRkTi95GtJTucKQ8777R5claqHNo26KdnnMNy4E4
	lLFDMlw5WShCAtT3kabgA2wlrLXOWG+o4Ubp5JjgGTShGw8pmALM9LTHz3xDhyQ+Bpm8r4WLh2N
	sx8m95LJ8nYxpV0o+qMRiHdbw==
X-Received: by 2002:a17:903:3c2e:b0:2c9:d89f:fd98 with SMTP id d9443c01a7336-2d707a53b4cmr670105ad.1.1787683818860;
        Tue, 25 Aug 2026 11:50:18 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8535d345ecesm176192b3a.59.2026.08.25.11.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 11:50:18 -0700 (PDT)
Date: Tue, 25 Aug 2026 18:50:12 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 00/12] iommu/arm-smmu-v3: Implement Runtime/System
 Sleep ops
Message-ID: <ao3j5FFfKQsctV4r@google.com>
References: <20260728210928.1050849-1-praan@google.com>
 <20260825133342.GA3332773@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825133342.GA3332773@nvidia.com>

On Tue, Aug 25, 2026 at 10:33:42AM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 28, 2026 at 09:09:16PM +0000, Pranjal Shrivastava wrote:
> 
> > [v9]
> >  - Replaced atomic_fetch_or_relaxed() with atomic_fetch_or() for
> >    correct ordering while asserting the STOP_FLAG
> >  - Moved arm_smmu_drain_queues() after the cmdq->lock wait loop in
> >    runtime_suspend() as per feedback in v8.
> >  - Refactored suspend sequence to use arm_smmu_disable_irqs() and
> >    synchronize_irq() for safe GERROR handling.
> >  - Fixed an off-by-one error in suspend polling timeouts.
> >  - Dropped arm_smmu_cmdq_can_elide() check from inv_range
> >  - Renamed arm_smmu_cmdq_can_elide() to arm_smmu_is_active().
> >  - Removed redundant bitwise masking from owner_prod reads.
> >  - Added comments to explain locking, gating and elision better.
> >  - Added comments to explain secondary cmdq draining and gating.
> >  - Rebased on arm/smmu/updates
> 
> There are alot of scary looking sashiko remarks, are you planning to
> resend this with some of them addressed?
> 

Yes, I was first hoping to discuss them on the list! Thanks a lot for
initiating that discussion :) 

[BTW, I'm interested to know if you used some tool to pull in sashiko
feedback in your replies, such a tool seems helpful!]

Thanks,
Praan
