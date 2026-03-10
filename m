Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D203B47C6
	for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773161928; cv=none; b=QaLXI1fE7wasTa2oLcCVCYJsET7OhACZX6UexDIKyacgi5ecbOUBfDVmBmjF1yunvUlkN+H/V2Q3IIymNgPLIzITMbBPpXbhy+qs5ytmXeajIPwhxzmbfh5D/sSxQ2R2p099xwE4jOYlruHGMzfm9zYKXgF0B3Lrm8kvTtuISiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773161928; c=relaxed/simple;
	bh=WQ/BPIPNZV9TxS1J+ubGwj7vVGbgqImV6rLezo/Ja/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmGDJKHnkD+PkRpw1DojQQzMj3tMr8+uuAlp4M2gUNHKNBb/u/PQIpbMycsH06Ri39Y0Nf+6HdKumJU7YWNrQUf3ubjVSyuEDqrvE1iEuBGV4MDSxZXKAwhFRuPzVH+p1Up9bOlcv2peeC7ExMb8SPwo8QT6YX26+ooRKC/XFQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bJzax0jO; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bJzax0jO"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ae49120e97so4635ad.0
        for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 09:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773161927; x=1773766727; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tTUkdLHDAVzRAHpbY64MukYVpIHMKSnC6pbTxYLTreU=;
        b=bJzax0jOZY8AiWv6WsV2Vnqxm7T6fKD/Bf0ZB/hoJ98AfenRG1CFiMP/tttOd4RGEm
         gzsh6Rr684VesK8flEHBPlseuHQ5TYceLQCUmhHiCbIGPMOwjVIufIuzrVtoag2uP2UL
         l08jv4gPi8esQ3ikcdhi+mio3cN2eyDsnM5NungAhjNJ0GUK1kALrDIm1zuoLsYm1Vl7
         ubyzSFbudrspFF0EbSYVVS7akk5RbFdut4eT1ToiNc4MpzYRkMCPoV+nyxwGcbrSc0xQ
         WYqgEs00oOW+2h13BK5vKr50dOqfZc0jr/zOBbCM2XR7pvXZPKJaHsr4EWOfDvhgcLA4
         rKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773161927; x=1773766727;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tTUkdLHDAVzRAHpbY64MukYVpIHMKSnC6pbTxYLTreU=;
        b=BxTOLDkOIpZ9lX/nuxK+LLM0c2aEbt32Hy6vCcVE0LhAYdkYdncAJdyb7961N71EcI
         7mgKsm3dDHSWnkRHhHNxnPDPysVgXZTcrYHLTjQEn8vLBromFStOwiZThykrTnGgirTE
         izh9Nx31bwXfUXVzUFnN6XOc9w17XoUwtO7waEHwhD9X0MGqvl01hHPKfwSabFIm/tQI
         BW9ivyRLZMs6fHwaq6N748hbJF2bNQxlUoIc3v3gI5xeYfcMa8+bJqty6aM6+QFx9OxD
         eUUqbjaamM9gzJXvBUXNXA1sUFBl/nNEeaj22hc1DmW1Cr1cDkLm44EqgsdP3y6HL0u+
         Fe1w==
X-Gm-Message-State: AOJu0Yx8uVzWIw7uhQ3Zx/fRcCwAqEnLLEX+N7I/PiyFZo5/IgZCX5c4
	9XcFGbv5XN8O9pSYHoI9/FwhGRjORLroT1e6gPtpK8H+nXUNFeUg+72CNMY/N0U/gYmwzp2k/9x
	SzREN5YUQ
X-Gm-Gg: ATEYQzx0fTYgGqP3XeMztwzEyckyzZWUy/aQiimcBG0DqopJBcEmMPaP0vaQIoMlr/Q
	o33gDwsbxmfo/IRtcLA9VoV+445NZibORl2CnWLGlQQzF8Duuxym/OUGqXGk5Hf+FveBWD+naDw
	wEEcgT3kp8EJJ9mLMj6s8kudnx2hZFx6sK4WTLujqu4stYFjis53+qh9m74iuPlMkwY10vNBksG
	sCopHe3X/hfVbhv9yMcAX1wxpZDlfetjz9APzKtlgVB5nL9ehXxMWfiaemqID88WHlC+2Fm+JJ+
	chq2e7GG45ViKZSy8UCachKxEI5/Jhc3WL9H4+GwdMhx4Hju/u9XDlZMqMwMogn3D8tZQzPhAQU
	v3f0c4wX0eODQhQVrhrMQIkBbdzF/Aek0iA0QQJPi6qJ0D/PHMwsOVZzg559og36aQj0Q4PldFM
	PKfN69VXBMZFikDdu/vDzmLyOCiE6teqmbNJ3sXOblj97xf5qUG6yoe9qn0Q==
X-Received: by 2002:a17:902:dacd:b0:2a8:fe50:2933 with SMTP id d9443c01a7336-2aead183662mr60715ad.0.1773161926420;
        Tue, 10 Mar 2026 09:58:46 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48b2c41sm13873703b3a.54.2026.03.10.09.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 09:58:45 -0700 (PDT)
Date: Tue, 10 Mar 2026 16:58:41 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	Sairaj Kodilkar <sarunkod@amd.com>
Subject: Re: [PATCH v5 07/10] iommu/arm-smmu-v3: Implement pm_runtime &
 system sleep ops
Message-ID: <abBNwXk2a8v6Zgbw@google.com>
References: <20260126151157.3418145-1-praan@google.com>
 <20260126151157.3418145-8-praan@google.com>
 <CAE2F3rD-rEpizTpc1fo7Y8fXZfZCF2TGUz8H86rUY6RzTWQDQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rD-rEpizTpc1fo7Y8fXZfZCF2TGUz8H86rUY6RzTWQDQA@mail.gmail.com>

On Mon, Mar 09, 2026 at 06:45:09PM -0700, Daniel Mentz wrote:
> On Mon, Jan 26, 2026 at 7:12 AM Pranjal Shrivastava <praan@google.com> wrote:
> >
> > +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
> > +{
> > +       struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> > +       int timeout = ARM_SMMU_SUSPEND_TIMEOUT_US;
> > +       u32 enables;
> > +       int ret;
> > +
> > +       /* Try to suspend the device, wait for in-flight submissions */
> > +       do {
> > +               if (atomic_cmpxchg(&smmu->nr_cmdq_users, 1, 0) == 1)
> 
> 
> I understand we must follow the rule: do not elide any invalidations
> while SMMU is still enabled. Otherwise, the following sequence of
> events might occur:
>  * The driver clears a table descriptor
>  * The TLBI command is skipped
>  * The driver frees the page that backed the translation table
>  * The page is re-allocated for some unrelated purpose
>  * SMMU performs a table walk and then descends into the page that has
> been reallocated, misinterpreting its contents.
> 
> Can you disable SMMU before setting nr_cmdq_users to 0?
> 

No, that'd be racy, if I disable the smmu but nr_cmdq_users != 0 an
"owner" thread might believe that the SMMU is still functional and poll
for consumption.

I don't think that the SMMU would perform a walk as we first set the
nr_cmdq_users == 0 to stop command submissions and then immediately set
GBPA to abort. IF a command submission raced with this, we wait for the
CMDQ to be drained before doing anything, the owner thread would poll
till sync in this case only then the driver would return from the unmap
call and get a chance to free the page.

> >
> > +       /* Disable everything */
> > +       arm_smmu_device_disable(smmu);
> > +       dev_dbg(dev, "Suspended smmu\n");
> > +
> > +       return 0;
> > +}
> > +
> > +static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
> > +{
> > +       int ret;
> > +       struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> > +
> > +       dev_dbg(dev, "Resuming device\n");
> 
> 
> Try to be consistent with these messages.  Here, it says "Resuming
> device" whereas above, it says "Suspended smmu". Also, try to align
> new messages with existing messages in the driver. I believe most
> other messages start with lowercase characters.

Ack. I'll update it in v6.

Thanks
Praan
