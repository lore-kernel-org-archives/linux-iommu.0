Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C451A3B95E3
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 12:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780402345; cv=none; b=p2ezKBr2B/nDj6nPL8WmVEmYjQhQ64fXeP78Az8WCnM9+FBtVxtZUquN4zdKQx3HGJiTtqW7Dg+a20Tvd55YVCkF4d90vUStFgZfZ2MkoAcFyIE4qlP6+wevTTu3rkC3LaMQfepg3wHck379CAsHSFai3oaDtYxb0V5sZ/crIcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780402345; c=relaxed/simple;
	bh=ten1Sp9/vQsynOHTzkDBSArSsPQrqyXK7FNX8Rz0PgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KY6cAmHZPOSvCyXTT0wVV57Qu8f7reB2rKCS971xpGCmB3ZZL07s6PF7B7Spe8cTYlUPEkoIup9Y4CQaD1bm3xYAxRnv5fK1yoG8OuIfm1ae3jG7o+/zgZJCyxPTG5gQj2SuZ0rEmPRWamZBRlstzR6SIbXYMolcvMbPAu0hn7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cKqbKLDX; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cKqbKLDX"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bf22c18ad3so715ad.0
        for <iommu@lists.linux.dev>; Tue, 02 Jun 2026 05:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780402344; x=1781007144; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l68RUmvnVcTMObrLGNummA84I2vZ1XwcyaM+Znecl0o=;
        b=cKqbKLDXaSa5T6FER+qhWA5OvdEUEKYOrKB2GiYlxUkj4aNkRx8NCvmGluQ1lvd7EF
         6ou6EW52nzmR5BGYzhc36HXMzWvHUkzR38PZNpOVLg/Qb3KmtGl7jTuDjXUpPYn9Luzq
         KeJgJbMoRisfWCpzwiMuAlVTJMVMD/qk8bHrB+96gSPqHnczy5U6+BRawuKw5yEInrNG
         aBmQvBf930qWz663PaOitBacXvw9QkIeX69ktcre0AelHyi3HE6EPe72gNgiWGj5XpQN
         666bSFM7ooFuTgNN3E8q4ujwx0a/polhfXdnU+4A2f2/cexMLEHuvQMbtdx0+H6BPaoQ
         K0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780402344; x=1781007144;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l68RUmvnVcTMObrLGNummA84I2vZ1XwcyaM+Znecl0o=;
        b=D6Ko0vvGGO9/MObXZyLKPSlgWoxD3zj/qUqSYaP5VP5SSq+OUXNfXkFwNW66+AirPC
         OnqgvISopE1gA5T7P6cp9NEfz7swAeAD5DcRks1fxwMN+wYz/1dkpbywIkvG9FdwvSFg
         eswgivwVvQpqfXtUee4krkpJ6VeDUdXDhpKSZzIsfDvy4xFSnDPhHRBEehCN1b8tsoYE
         oJQRGAp81jYRqMhzWFwbGwVz6ukAw9qrAxLuHPAq1yXNX5dB1RPQy5zTtrdGrzDLFJ+Z
         pUNHfY25ZT8Mwk2c/acTdsKIhkRicbjxl0baPfjnYSB4S773qQfUSmVUj/IUYIeZJT0c
         WJgw==
X-Gm-Message-State: AOJu0YzCyzc1K6FmLaDcR08UwXUWXLRT8d7yUTTK/ihEJxfrzGfECwml
	kYMtKyBl59KvTG3oDcUcy3JNXArfUavyHutuerzzHo6+4QHk+OGjxOD0g+TNQwhFcg==
X-Gm-Gg: Acq92OHKoxR7do23BX8KxqLYUfmsue9Dtoi5u8oSTuWrMO6wdIfYGILR9XvQsS5oQGy
	BIkv5PWSVkSb+z+cw7iIz6xUCBqgdB5bOc7etCaOD55dFdQgJ/zE45B5vW4Z95OEDk07g+DiWNN
	CJO1bE3WwA6M6+b77iw9dpJRRELZec3m1aUwtMZH0BjkFd8yFvdxyC3E/6EZAsUuiAQyvxj4ZaB
	VIapIiQzDoJILC1/VohiSbGn1yJ63xlqEFMcrB2AkPj1fHfAMmIgEGi1Trfqja3f/pc5wW9kifR
	JQD7HHUoljHQTzfqCGt4r90+Dbycxa00sv1InCfrwkchYtCLxuIj7w8KVpoF1kTtprwrtaEqE8i
	jVZ9WfFCaqqPJWikyhDioPCLWC+h7rjWUmS+L5sySRYr0jeWkBQgFLdbMttGKQRpwm9qRmeybXr
	9YETa3COvHuEL147vuclfEx9e0cfRQme5inDxlD2YUfsaN6jXuCJS4EraGyGNvFdbhHEY60rM=
X-Received: by 2002:a17:903:249:b0:2b0:aee4:afe7 with SMTP id d9443c01a7336-2c10e85e5dbmr2816395ad.10.1780402343406;
        Tue, 02 Jun 2026 05:12:23 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8422e712309sm10139561b3a.59.2026.06.02.05.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 05:12:22 -0700 (PDT)
Date: Tue, 2 Jun 2026 12:12:16 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 09/12] iommu/arm-smmu-v3: Implement pm_runtime &
 system sleep ops
Message-ID: <ah7IoJqmRbK7xK5-@google.com>
References: <20260601215909.3958732-1-praan@google.com>
 <20260601215909.3958732-10-praan@google.com>
 <CAE2F3rAYWMq6DO5k20e4iMtPbh_X9JeiU8kUfw8nsS5xs42F_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rAYWMq6DO5k20e4iMtPbh_X9JeiU8kUfw8nsS5xs42F_Q@mail.gmail.com>

On Mon, Jun 01, 2026 at 10:25:41PM -0700, Daniel Mentz wrote:
> On Mon, Jun 1, 2026 at 2:59 PM Pranjal Shrivastava <praan@google.com> wrote:
> 
> > +       /* Drain the CMDQs */
> > +       ret = arm_smmu_drain_queues(smmu);
> > +       if (ret)
> > +               dev_warn(smmu->dev, "failed to drain queues, forcing suspend\n");
> 
> Can arm_smmu_drain_queues() be called after cmdq->lock is 0? I think
> that way we can be sure that no other thread updates smmu->cmdq.q.cons
>

Hmm.. that wouldn't work for impl-specific CMDQs as we STOP and drain
them together in a single function.. maybe I'll factor out setting the
STOP_FLAG on impl-specific queues as another impl_op, gate the queues
first, wait for lock == 0 and then drain_queues?

> > +
> > +       /* Wait for cmdq->lock == 0 to ensure last CMDQ_CONS_REG is written */
> > +       timeout = ARM_SMMU_SUSPEND_TIMEOUT_US;
> > +       while (atomic_read(&cmdq->lock) != 0 && --timeout)
> > +               udelay(1);
> > +
> > +       /* Timing out here implies misconfigured Runtime PM or broken devlinks */
> > +       if (!timeout)
> > +               dev_err(smmu->dev, "cmdq lock != 0, forcing suspend. Polling CPUs may fault.\n");

Thanks,
Praan
