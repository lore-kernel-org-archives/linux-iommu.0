Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCBE17745
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 21:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780005482; cv=none; b=MlhH4tnghw7T/DI68N7cGa1288GdkygZMbX2ptMBSYQ/YmTUCADYN6eusSg0hARR6u8nSqxY0TBD919kRHKYpW6FScudTJcQGcilgSVHIS0GdJ279OHBBkeZ97aK09OJ/jUT7TvPmF0VJxyaa4gcjFSiHV/HwBynEgUHfXLDmrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780005482; c=relaxed/simple;
	bh=3ywHycKquNtOTUyz6p8agG4v01Qkr2SAMkv5GwA3ivs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqQZx0cgZSSrzAvuuB2Y3LHDCckploCXtWaASn4NEhkCXwfK4+5levvQjOoHrOVk1snHdT9J/Mz8vKDAnsPQKOnW/go0rFmRjEUZODUgu6Wlv3+eFCTD/Spz3eLrrtajcPpvar+Exk9AZ1m+C63dPVVHAoEEZemuScqPL232yMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fvj3dmcr; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fvj3dmcr"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b46da8c48eso1195ad.1
        for <iommu@lists.linux.dev>; Thu, 28 May 2026 14:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780005480; x=1780610280; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XoyeFNyeO4llx95lndb6Ryz5Ip3RITBdTtIpINeqybQ=;
        b=fvj3dmcrSMmTlWhiYYtuMTpYy7L5cLKYvMGKuv2aOJaqV1pxqm5jGdVrJugycoDv0t
         DCoz/LT8/AYtkyu7G7xeQc8asjTuXcwThR5Clqv6JGdwDjHuAW98JKNkeippuV5WqCuK
         pEZH3hC/aiKew3+BYHRgaTf4jtABR3J8PJaXvZV+Id/0IlcII5CVXgWkJ/+7fPFrLh4d
         aHc0t4bNjzwGxKYa3OUqvZed95d1tptk/ysGmgZxypIE/vENN0iXlQNkcUdCDzXaKJRO
         RS3cMqjZq/2wbC1Ye0OI1x/Ly+2FtgcS2Cdd2lr7kulWQUVL4/eDTUluz4v7z3T0d3gb
         Q+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780005480; x=1780610280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XoyeFNyeO4llx95lndb6Ryz5Ip3RITBdTtIpINeqybQ=;
        b=VSe0MCICzqojmfEA/yiIPs5175JHlngQ4J3GZUAHEYz3eJwN6xziw+Q/CBy9e8Dcqb
         U7iWiYbdTUIx9iRjytScB/wqCx46OW3iYCF1cHh8PWmJImOOkCypBbjv61enQeRdh/cX
         5gy6wSkhVacoNunzyvmcghi71mxQn/XNVuP7UqHEcnvQj8olHJxjkdbwFsIvqzAPrO4F
         G92qlIbNMwSp8qxqgoavsTHJNKaa2UY4lFPWVz5j3s4j6MfL14F/pKtLQwV51k7dm3LE
         k9zszmtqcCZt5qdUloQRp8seSYw1s1rPG5VBcxQ/ib+7Maj4oyw9jm1tFVMY/+qA62ox
         FXYg==
X-Gm-Message-State: AOJu0YwjB7Xb1QWvNn1l/SjPRAhqqWFI7mGp96xpsPEw65XiuGchZVJt
	qK101lBqx69a4gT/bgTv+N+98G2wxLDUcvUHK0Wr7sooJeD6h7k1wuwZ4yz6/r/0Dw==
X-Gm-Gg: Acq92OF5LfVwV4Pe6deVtR4pyum+f/LKeHA08Fv+bODheUrFZW/UMYknvuLa7tYNa5y
	spYf2nWxuvc/vWPd4Ec7P7wVbUDFul2C+sw/oXqIyVh4nuGsTivtFyjE8C0ltx9OdshWCk5qoLT
	Uqs48FURsdD6veFqKVupGEauvV2ZLh0MBoYdk1mSZdCGOZh6MBzrYkzazXEm6FK5npabBxBvEXT
	w5ClowwNJIxKepBWIYXdYldh+fKJpc348MrCljIRMh9HdJptQhF9MZ/MgYJMTw4QfLiy64udDVn
	p3bPn+7Y2Cf+nmK9a+42i8Jh9nHMhV+tPw0/BPzFiAhvC3AFDgtx0skBzFKl2O0eyoqOmlZwpnp
	RdbZILooSvTUBQu0DlWd+1YNS8oevR57Si3AdPMovtx5bQUPRSV95soCNTY7g4y+XrAxOkBNMky
	nAZ2t9yaURM/kaDYQ8GDd0AOGwfSeoUNHB98uowoeFfYvXCDYoip6sG5Zb5yKmDIQQSgAK
X-Received: by 2002:a17:903:110d:b0:2bf:1ae5:2c51 with SMTP id d9443c01a7336-2bf20d81bf6mr227635ad.1.1780005479653;
        Thu, 28 May 2026 14:57:59 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf218a2535sm343525ad.29.2026.05.28.14.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 14:57:59 -0700 (PDT)
Date: Thu, 28 May 2026 21:57:53 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 07/11] iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to
 gate CMDQ submissions
Message-ID: <ahi6YeIypLKYyBTJ@google.com>
References: <20260527221407.1756491-1-praan@google.com>
 <20260527221407.1756491-8-praan@google.com>
 <ahiabwoaBdYwbtar@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahiabwoaBdYwbtar@Asurada-Nvidia>

On Thu, May 28, 2026 at 12:41:35PM -0700, Nicolin Chen wrote:
> On Wed, May 27, 2026 at 10:14:03PM +0000, Pranjal Shrivastava wrote:
> > Introduce a new bit flag, CMDQ_PROD_STOP_FLAG (bit 30), in the command
> > queue's producer index to safely gate command submissions during device
> > suspension.
> > 
> > The flag embeds the suspend state directly into the existing global state
> > The flag checked in the compxchg loop in arm_smmu_cmdq_issue_cmdlist(),
> 
> s/compxchg/cmpxchg

Ack. I'll fix it.

> 
> > which acts as a Point of Commitment, ensuring that no indices are
> > reserved or committed once the SMMU begins suspending.
> > 
> > This prevents a situation of "abandoned batches" where indices are
> > incremented but commands are never written, which would otherwise
> > lead to timeout during the drain poll.
> > 
> > Update queue_inc_prod_n() to preserve this flag during index
> > calculations, ensuring that any in-flight commands that successfully
> > passed the point of commitment can proceed to completion while the
> > flag remains set.
> > 
> > Suggested-by: Daniel Mentz <danielmentz@google.com>
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
>  
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

Thanks!
Praan
