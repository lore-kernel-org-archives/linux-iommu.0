Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2547534DB6C
	for <iommu@lists.linux.dev>; Mon,  4 May 2026 09:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777885307; cv=none; b=BeTLh8ll6bg6L92c7bDYIO4TBUX1X1ZcQQpdcoQvaSJOGuvpOYox1Hdu3rK4Uwq6v75jXWAo3VRiikIrNMLRLuOfgjYwVJSkodj6+nC+83Wxx42JoN8uwZjAnWcWWvHWFydUnOCk897UxWEvVmTs6dCksxKVCVrsWdAkyOxfOEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777885307; c=relaxed/simple;
	bh=Pf37m1mREtD8u5t+yhTjgmvOOcKlOjXv60+mx6sMo+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOf1hiYnCPzXHpyQtK95RdDvrWpnS1YtLYXSi8MW+Oj1k1QhosXIB7U5kBVFoLW9Og6sJs2eiC54p0/Z4o+Igx13hTUrED32lCO6Wak7dADaNQVOGf0d8yZW8lXPXdYjgGKttmPjCYaZdRRHJ9zRcdKplyN+E6Wbc/HMNX5VoJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BOQ98rP0; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BOQ98rP0"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso111585ad.0
        for <iommu@lists.linux.dev>; Mon, 04 May 2026 02:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777885305; x=1778490105; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yJmIPH2q4NOkE3OSjdUBhHno8mkMPxxzEKmgqViWD+k=;
        b=BOQ98rP01h5FNdJ4S3q4/XtsA0mbosU2Slr39fvcza8sRB44oE581Hfjs5DGObTO+Q
         9UEEnDFHaViaW+FvGvuQi6wSLeTwa9pHF70ai+U1Z62Na+5Y5tCmTqE2Kv9to5p08zNB
         D55oLikeX0Tj3suPr97UExpmWUvoMn7tkDRWoaqkFtkxuVVPerHXYy2/3A67Iy5EoS5s
         dCt9HsIo0Z8uNYH7zezuRBxuO8Bt4vpZ1zFtqiijqHEh7C2A66JSo3cqEM0uidh9dr03
         vOg3q4vh5Ev0QZE9JCnB2oZr/GTC86Zhesy6YaLiB2FmHRoEypJ0dXeWQ5RxATfngX4h
         CPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777885305; x=1778490105;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yJmIPH2q4NOkE3OSjdUBhHno8mkMPxxzEKmgqViWD+k=;
        b=gcV+m10nf0veBWuh0G3hAPpPmviFjsKdqHmEhGZpo2Kuy+HFm1+0TKFE/UBTUy0hHQ
         pUxglrp/kJJVFUCF6BiC5aLI/ZeP3XMzFX90LZxS29ZST/Wrl8finTEpGP63d2Qu43y5
         r5im5z6riOshU6FLIfeXKENCQx5Z0+HvhDoUdZHMK5NJy4QkclTc8LZQioy/vhAR8OFy
         Kw0Nz3aCz4JajQGwp5TEVqWK1f5Wxfri+Njcbsn/w4xxb6R83Ut/8dQy2V6oTYo6RXbp
         SpdjUTSO1cOwzE4w55Pgg7i6e+GAaY/kKcS3FeJRJmNB7C30i4mnYqoDQqQ+e2Jq2cM0
         pTFQ==
X-Forwarded-Encrypted: i=1; AFNElJ8OizQ9KZDJshj3/dofcg1cfvZ8EYkIe2bdVLAIHC8ZM0nra3L4kCsXzph0PcEc0gzpqqJZ0g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4+JHs7ixdoMURZEtnLeW9v/cMFAftzr9YduTsym7ZgG3MR1e2
	L3OtaWNUVDoEbNsv20Xh27ATrYkk3DXiRnYOIMIS+K4B63/YjKG1mWgc1LSJzpGiiw==
X-Gm-Gg: AeBDies3Mx/nqyS4dvvfUmowKWlUTcs3c9HrMaQ2Lc89PcgfPFJ8gBrwU/u/44KSvHb
	WBt+GFLHSR7FxAA9RGEwyFMgo+LIzKL2qGaRk+2/PBPl9oWqKxELUjA6ZBjyt7mViwignELOogt
	HnYzg/xSoY8TMrJv9VFbkDNKSXyq1v9UMvPWq2OVbCpbHOHSWIewzNPq6E/xI2LeMUzBI4ymA+L
	63hg5AWopsezwsEc/MekoLP9Sqtn2SElaX1JHCZN++IDosMVgrhxA30/lQXQVTWuzJCA5mhP1Ba
	0z6/LCYAaT4aT6mEfDn2Fech85JiNb+f5WaDDFcdkRouBruylcMoIZoaYDTcwUjc2FieWI00lFs
	L2IOc/L6lFlcxt2pgtN50olS51cVsokJpJbPrcTO28AYjEX5t8CtVWbefYdLnCLUomNI1iBQ4vF
	JLmPexU7Ye5l01BysQesHl3QzW8msTF0SVfwwnBpaK/GO2eM0opPlzFULrcxQf9100lPtes4Bj+
	SQnQXENtJvL9VIcjg==
X-Received: by 2002:a17:903:2f0d:b0:2a9:5ef5:399b with SMTP id d9443c01a7336-2b9f58ae74fmr3802555ad.19.1777885304666;
        Mon, 04 May 2026 02:01:44 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae363d9sm99598225ad.57.2026.05.04.02.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 02:01:44 -0700 (PDT)
Date: Mon, 4 May 2026 09:01:38 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Ashish Mhetre <amhetre@nvidia.com>
Subject: Re: [PATCH v6 07/10] iommu/arm-smmu-v3: Implement pm_runtime &
 system sleep ops
Message-ID: <afhgcog-Cizp_Rag@google.com>
References: <20260414194702.1229094-1-praan@google.com>
 <20260414194702.1229094-8-praan@google.com>
 <CAE2F3rCaBWtRruBbZcedrsLnkkETSniTWoxxYn+Lkac9ttsshQ@mail.gmail.com>
 <aejP5Yk72_FtZnIo@google.com>
 <CAE2F3rBeqrTkgqwYcY7SPiUaPap6y8Hj95T0KqWCnaG59VB_hw@mail.gmail.com>
 <20260424151639.GE3611611@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260424151639.GE3611611@ziepe.ca>

On Fri, Apr 24, 2026 at 12:16:39PM -0300, Jason Gunthorpe wrote:
> On Thu, Apr 23, 2026 at 10:24:30PM -0700, Daniel Mentz wrote:
> > On Wed, Apr 22, 2026 at 6:41 AM Pranjal Shrivastava <praan@google.com> wrote:
> > > > > +       /* Clear the STOP FLAG to allow CMDQ Submissions */
> > > >
> > > > Clearing the STOP flag here seems premature. I propose the following sequence:
> > > >
> > > > * Set up command queue (SMMU_CR1, SMMU_CMDQ_BASE etc.)
> > > > * Enable command queue
> > > > * Clear STOP flag
> > > > * Enable SMMU
> > > >
> > > > By clearing the STOP flag, you allow arm_smmu_cmdq_issue_cmdlist() to
> > > > write to SMMU_CMDQ_PROD which then races against
> > > > arm_smmu_device_reset() which also writes to SMMU_CMDQ_PROD.
> > > >
> > >
> > > I agree, IIUC you're suggesting to clear the stop flag before the
> > > TLBI_ALL and CFGI_ALL commands are issued by device_reset? We'll need
> > > to clear the flag before device_reset issues the  TLBI_ALL AND CFGI_ALL.
> > > Thus the sequence should be:
> > >
> > > * Set up CMDQ
> > > * Enable CMDQ
> > > * Clear STOP flag
> > > * Issue TLBI_ALL + CFGI_ALL
> > > * Enable SMMU
> > >
> > > Right?
> > 
> > Yes
> 
> This is making a very similar fencing argument to how Nicolin's series
> works.
> 

The invs array series? 

> After clearing stop but before enablie SMMU you have to acquire all
> concurrent threads updated data structure memory into this thread
> because as soon as enable SMMU happens it will start reading that
> memory and it must be 'either we see the latest copy' or 'we see an
> old copy and guarenteed to see the invalidation'
> 
> Exactly the same as the reasoning used for attach with the
> invalidation list. So I think you should look at the barrier design
> there and ensure it exists here too.
> 

Hmm.. I see your point. We need to ensure that any structure updates
(like STE/CD or page table changes) made by concurrent threads are 
globally visible before we send the MMIO write to enable the SMMU,
i.e. we're talking about memory ordering between other CPUs and
the Resume CPU (CPU running resume), without a barrier on the Resume
CPU, the SMMUEN=1 write could potentially beat a client thread's memory
update. If the SMMU is enabled and fetches a stale configuration before
the RAM update lands, it could cache an inconsistent state.

I guess I'll add an smp_mb() before the SMMUEN enable to act as a
system-wide synchronization point.

Thanks,
Praan

