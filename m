Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976973D5241
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 12:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780401855; cv=none; b=aqh2UmBI43a0dzAop9NDUtE8qbRGokajNliVYVe0F7LfIXEwOGz4NNwVMgV6EmZwNUuCFCmKhx7SCl+2J5tuVYWAy2RdpMS/9bZYsnQzpiAnkSpd0vSHf6RqzhIxNyKoOV0zHKPpzyA3RkSa6IkP74IzcLcqK2Xt56bn+gN+Q+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780401855; c=relaxed/simple;
	bh=lA/bAu12EuvwfcvRytW3fcPIrkxeJZw/4JgDumLwGl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evPcssAmpeaFgSR9Z/AT1fgYUZakCCxeEpnD0oJPTCzxuZocJIil0w29jmX5cBzmjQLDQTMNdqoxu4MaMkTnwJCBWxSHVMvVTTIn8OE6CsfPbNIDqPlLfDXYsMWnB4HE5xAVrg9Ca+PcrcwQ8q9oVFhnC02nejuCSlMqp5niT+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O/Ta7HJ/; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O/Ta7HJ/"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bf22c18ad3so565ad.0
        for <iommu@lists.linux.dev>; Tue, 02 Jun 2026 05:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780401854; x=1781006654; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H266dwNV8LtarXcbHsjzhwha05z9KRlXAu/EZP0ytiQ=;
        b=O/Ta7HJ/DC78srCQC6fexEJmpT9XCIuOzz968Q5jZ9cZofOSSECMRlF1SUP6J+Od4T
         g63mvAdediijpJHmZZuP2n2jQx61XZsXysAbhMGbC66ALKVKLsl9kcNoKtHyychvbB2h
         ffkN3lvCvBKBS/QGkBv54MbUQHttXOQSHv4L/oFpo1Mczq2Wkv6z0896D1euQ4qV9MWb
         jDZMiltRwZeR8mUq7Sf2r0OeqTbB3c8+itKchVLZqUh+m9sGenrNGwPGOM8BWTkT/rLU
         ze5FS04mQbvCavudLqklgmSAGC5QjK/ws+b9qMhZl+BbWdqxrwzuBYhoWvbIu27ffvCb
         0xUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780401854; x=1781006654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H266dwNV8LtarXcbHsjzhwha05z9KRlXAu/EZP0ytiQ=;
        b=fQXPkeQQXcpvZfo3Lm5rlg3pX7oBE601yIiDsbU7rNZy703MFhseJE3aY5RWYomyI6
         L7MNwIdLE8X0NLLAAnr/FYUXBjde5brdi83Dj9xPI8i+P75xG1JGC7wANUcwwdZDwFXc
         09HM5YaBrYej1V6L4KcEGZu+6uuMNL+ORN0OYlv5UEGSnGDKten6oGRD0crt5G4CgEzV
         3YffKw/BpNNsUlAhyGZxVGyFrejFO4LokuF0Z2EHQCKKf/LCdpoqB/lS7Tt7VeY3kwzW
         XIrGtrCFXRYYDobq1O5luNQh1OueFxoT1jedR1yHFlWSWjdKobO6GZCj7hsJvJ7PNTkc
         JxfQ==
X-Gm-Message-State: AOJu0YxYkAg48fRRx/TCSgoxsxZCM8FEILlivke2hxEpEf8V2nB0Hvnv
	Icf952JdIOxb26uYkaUcR88V7JHgmH2sf25z70OXqir+zv7ZGKP8s4pWYMyUjnp7pg==
X-Gm-Gg: Acq92OG3vRJcmjAIJlzvceLqb91XJ8m0eaLFhcEU0SNuFkSXwfWEYwZNj6N1YRGaEPE
	1Gsl6CLhvbasdDJ4tF2zk82DsmEiWqVoqeqhQkDEjhtGyRuVDemeANIwKXskw97Ege/6dTCUYIE
	DoLQX603bS0SQAbWI/SHq/Z1K92AC2roDrjIgmf+5aW298yzzQ2rzQ406C38YDQvreI3PswDfYs
	XzpybuEw/jUpnmX1c1Gn1oDBZny+QMEc1C8eiSV9FzuwHOkZUdYUG7MJNmLiQqCyFqyCyXl5IDM
	wVCTXbZvz7a9edJuvB8NBjwoINzvK/cpSgTwSM5Ydsq5NygeLvcgHbwt2eHxjhL0CxotpwIR2kF
	a1LkZXxQIWHrByqdCT08xr70ZQJkd7JZb+xyDDeMReST5MJmgJIrGSqvd3wenSJsxYitBbvztNz
	KN90EPXZrA6t5oCuSHJ5T0cO6rqSYJG33/pQo2OeL1eFfnKoP6812Pj+UpqbFaQyn5mlyBLWI=
X-Received: by 2002:a17:903:2449:b0:2bd:6dad:3dfb with SMTP id d9443c01a7336-2c112c74871mr2048965ad.25.1780401853259;
        Tue, 02 Jun 2026 05:04:13 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c0842esm131835235ad.57.2026.06.02.05.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 05:04:12 -0700 (PDT)
Date: Tue, 2 Jun 2026 12:04:07 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 00/10] iommu/arm-smmu-v3: Implement Runtime/System
 Sleep ops
Message-ID: <ah7Gt8pZbMbbE45X@google.com>
References: <20260601215909.3958732-1-praan@google.com>
 <ah5yPciJTVTjkMfJ@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah5yPciJTVTjkMfJ@Asurada-Nvidia>

On Mon, Jun 01, 2026 at 11:03:41PM -0700, Nicolin Chen wrote:
> On Mon, Jun 01, 2026 at 09:58:57PM +0000, Pranjal Shrivastava wrote:
> > [v8]
> >  - Centralized elision logic: dropped redundant checks from invalidation
> >    call-sites; elision is now authoritative within the CMDQ layer.
> >  - Renamed elision helper to arm_smmu_cmdq_can_elide() and preserved it
> >    only for diagnostic/safety paths (ATC, GERROR, Page Response).
> >  - Consolidated implementation-specific gating and draining into a 
> >    unified quiesce_and_drain_queues callback.
> >  - Updated tegra241-cmdqv to gate virtual queues before draining,
> >    addressing non-deterministic timeouts from guest-side submissions.
> >  - Re-ordered probe sequence to enable pm_runtime only at the end, 
> >    aligning with SMMUv2 and simplifying error paths.
> >  - Refactored KUnit tests for better, addressed Nicolin's comments & added
> >    a multi-threaded kthread race test.
> >  - Refactored RPM helpers to use early-return patterns for improved clarity.
> >  - Collected R-bs from Nicolin.
> 
> FWIW, v8 is still missing a base-commit and Sashiko fails to review:
> https://sashiko.dev/#/patchset/20260601215909.3958732-1-praan%40google.com
> 
> Please make sure v9 patches are formatted with "--base=" and a public
> commit.

Ah :/ that's a shame.. I gave --base=74fa4c177ad0 to format patch which
worked for a different series [1] but not this one for some reason?

I'll ensure to add it in v9.

[1] https://lore.kernel.org/all/20260601134204.2150602-1-praan@google.com/

Thanks,
Praan
