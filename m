Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8404343E49A
	for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 15:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782833601; cv=none; b=KA3Om3spr+6MS7EAqDWpF3L7a+Qjk7Vqj0QfG1E/0N+OXCtdm1pY4KYmvDtRh1sbkC+M6db4u0orQjxi/dpqolzePNWmy1Txtw95JWByMW6hZIL5unmOQB+UVLhqsjcSY78ooX0W4TUyUBVET/bJrp0FiN7TUKfS7+wSxHSV6dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782833601; c=relaxed/simple;
	bh=u5e4tGlqn778Ahe+mUV5OcGjPTxwzcOru7Knys+GwPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAIDDR9zMUQQebIVoNil7G7ocjyIHydOGZlekhTER3dGRtpIKln0+IUbwiGpa9n3xTkFHMDudjunN+49McuO4vsUjWNE5fDWKWShMoa1DG7SUNCTmIlOC1DZY2GWAWg6juffHdb9foHT4vH3M0SQZcxpDriuu2Yz9nMCGxI/0Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mEgQD5Iy; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mEgQD5Iy"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493b8d92a4eso54665e9.1
        for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 08:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782833598; x=1783438398; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7y23lwVc1qU9pQQZzwFQKSERGQYoPnAW1oWXpZxS+y4=;
        b=mEgQD5Iyu8+I9/jMiZ+trK14cDmHeVU5+wd8gcowMBmgD2lZS+QmijUvWVQw5wLoQN
         JWrlUtmqICh9lAS/ETsciLiS2Lel/pRQRktiDSdGMcsIDgxaST3FJ60QsdJGilDUbnfJ
         JYmlMzFd6unoVPwxJTR0Chkac6sVnaUDVK1PcyBh82IwjUVqMSmJfHfdtA7C3UX2Eb13
         eJGyKvUHaxwgeT7KA0HLg52xzqfzuiyPuzRScKAv6Sieo4RqlWW4PNkIrstiZZgVzu7Y
         GrVvauUjK79iSQQ50kGQpidqFONnT2rqHFkjk9JVGe/mf0/zjLH98uorB0APzJLWd0Zj
         T2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782833598; x=1783438398;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7y23lwVc1qU9pQQZzwFQKSERGQYoPnAW1oWXpZxS+y4=;
        b=oWYA4UOinRz3c4smVb5nT1qHMiQ36kwoSfoUUC50vlZ5/EKWydAGHCPzC82wcwOijE
         wffzfV/9cIa6/IUuCgEkfw10A63YYm8kOhs9ImDnSXLQ+yMTIk6pKY5jnXkL9VL+ONTP
         686IVJXyHyJsQks9ZKMlUM3Vo7H6jQcg9qQuSYsGgJCzKxmrRigkAtQmfbsv5o4Q+pj+
         n1HBnMaQykuL8RV07YDWdDB25GYChiq7Y98hzGeKNF8TThqFsrpp0isKEWf4ClROiwrA
         5B2cZ11tjlpmelUVc04huRowmwP1qUNxdBiXDRR29fzdgmTBN7SrSp2evf9nigVwCgnm
         68Dw==
X-Forwarded-Encrypted: i=1; AFNElJ9Ksteb53DmVJp1FXhy8YopoEKTSPKK6GHDspSSD4Muphg1FVbkrrzNZGxK+UPinrzIkrGTSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyosGT4sXNbH3FVhrzY3+ZYumMZMFU1cOYqwuLSZ0nbYilopHl3
	U5tGcm3GBemMKDw6hExBABX7fKjPwh4THZvZC8DYL1q7vbpReX9VOSvXfaCd6FWgVA==
X-Gm-Gg: AfdE7cnMgA7goxKORI0Agw3eVMu5zYlR1ls/lUS+5RdVHda4XD+uMxUbi12BMQ8emdi
	meFSSOh6x8986ZEe7TSSCL2TUKmDbbOUjQowy+gifTYpyBtGkOwYmQqa06SwgI7rWZ3zwMG1Ex2
	AbAubfvCzTiDqxhJdcihkxyqu7XMQ31MHXijF8+yhY8uKGU3N5evKVG/84snTvwNKrMqgI5+/YJ
	zr+Xkk0wlO00OfRhzwHWSyIHtggr3Rm/yuOD/CplpU5U+XYbVAswtFNBuIjDHqIQNy/TPNCNIyo
	XurVVaV4QdJtpIkyUhT4yH/hTm08m8B4zEQ4UQjeFlUO9BUZ0B7B5hvDXcv1NusZx7D/WOS86Sl
	Fs54D96YPL90ZPcIJDRUcnq3aNsV/f3YTWkZR7Mc67lvuKWz4p7PncLjtveT78fLxsmReHCrmiI
	j4OWSyjiPdlaxbr9ntmIKWFbCvDOMZCQT3ooHGeiEOCcf6aKtqn06Vctg1KBGN6A==
X-Received: by 2002:a05:600c:5290:b0:48a:5d55:c194 with SMTP id 5b1f17b1804b1-493bde1e099mr224345e9.7.1782833597416;
        Tue, 30 Jun 2026 08:33:17 -0700 (PDT)
Received: from google.com (140.240.76.34.bc.googleusercontent.com. [34.76.240.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be4c9f78sm3528615e9.5.2026.06.30.08.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 08:33:16 -0700 (PDT)
Date: Tue, 30 Jun 2026 15:33:12 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
	kees@kernel.org, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, jamien@nvidia.com
Subject: Re: [PATCH rc v7 0/7] iommu/arm-smmu-v3: Fix device crash on kdump
 kernel
Message-ID: <akPhuF9pAWaBXzpi@google.com>
References: <cover.1782799827.git.nicolinc@nvidia.com>
 <akPB6l-fuJUcg4a2@google.com>
 <akPX_N0P2EcI_jbV@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akPX_N0P2EcI_jbV@google.com>

On Tue, Jun 30, 2026 at 02:51:40PM +0000, Pranjal Shrivastava wrote:
> On Tue, Jun 30, 2026 at 01:17:30PM +0000, Mostafa Saleh wrote:
> > On Mon, Jun 29, 2026 at 11:15:33PM -0700, Nicolin Chen wrote:
> > > When transitioning to a kdump kernel, the primary kernel might have crashed
> > > while endpoint devices were actively bus-mastering DMA. Currently, the SMMU
> > > driver aggressively resets the hardware during probe by clearing CR0_SMMUEN
> > > and setting the Global Bypass Attribute (GBPA) to ABORT.
> > > 
> > > In a kdump scenario, this aggressive reset is highly destructive:
> > > a) If GBPA is set to ABORT, in-flight DMA will be aborted, generating fatal
> > >    PCIe AER or SErrors that may panic the kdump kernel
> > 
> > Can you please clarify more on those errors, what conditions will
> > trigger that?
> > For example, patch 4 disables the EVTQ to avoid events as there might
> > be a lot, why are they not fatal also?
> > 
> > > b) If GBPA is set to BYPASS, in-flight DMA targeting some IOVAs will bypass
> > >    the SMMU and corrupt the physical memory at those 1:1 mapped IOVAs.
> > > 
> > > To safely absorb in-flight DMA, the kdump kernel must leave SMMUEN=1 intact
> > > and avoid modifying STRTAB_BASE. This allows HW to continue translating in-
> > > flight DMA using the crashed kernel's page tables until the endpoint device
> > > drivers probe and quiesce their respective hardware.
> > > 
> > > However, the ARM SMMUv3 architecture specification states that updating the
> > > SMMU_STRTAB_BASE register while SMMUEN == 1 is UNPREDICTABLE or ignored.
> > > 
> > > This leaves a kdump kernel no choice but to adopt the stream table from the
> > > crashed kernel.
> > 
> > In many cases the patches assume that the CDs/STE might be corrupted,
> > but still attempt to retrieve them with some validation
> > (log2size/split...)
> > However, the base address might be broken, TLBs state is unknown...
> > 
> > IMO, although that might improve the status quo, there are still
> > heuristics, in addition to noticeable complexity to transition the
> > stream tables. I wonder if FW can deal with AER in that case before
> > booting the kdump kernel.
> 
> I guess we're reading the base address from the HW register itself so
> that should be fine? CDs are in-memory so that's why they could be
> corrupted?

For example patch#1 verifies log2size and split and both are read
from HW registers. Same for the base address or other addresses as
the page tables, they  might be corrupted due to a buggy driver.
My point is that, it is really hard to assume that the previous state
of registers/STE/page-tables were valid or even consistent, when the
kernel crashed and did not transition the state gracefully.

> 
> About the TLB state, I'm not sure what might pollute it, since this is a
> kexec, I don't expect any non-kernel entity to gain program control
> before the kdump kernel.. Hence, IMO, we can't configure FW to deal with
> AER here..

Similarly for TLBs, the kernel might have panicked in the middle of an
unmap or free domain. (not to mention what that means for RPM where
a device reset with unknown TLBs)

Why can't the FW deal with it? As I mentioned above in the previous
reply I am not sure I understand what situation leads into this, when
does a device trigger SError to the system vs when not which is observed
as an event in that case.

Thanks,
Mostafa

> 
> Thanks,
> Praan
