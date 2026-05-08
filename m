Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FD53DD535
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 13:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778245986; cv=none; b=ienb9hCeweVonb2MuU3erXNwFL85CbMRIjLacIkMnCLoypdfLyjqSqrdsKokqXz/YtDR7CTp27FmPm5JrQ7K+qLEV5bpx+Mtqwujjmq/Ap5RJVH5cQro/adTXv/EOISudOKY6PDiiRFWiwMxclsOZJo2+5jB8mZTrnu8vg3U4+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778245986; c=relaxed/simple;
	bh=8SfbiGMsgZU5QY1nGIgVC/Y47n2mBdUgeSCINMu1Odg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvXl9IQU1ziWBagfPQeszAJlMKMzEjlOGG3Mr97+LPJQ5UJ8sjALE2VSJayAhW2GNcH0k4OcHr4Ru43w5QXSmMIUurvXShGSuOnGaWht+8ds+mGE09VbQLam30mNBZk/Vyh/OOvgKRcqDVBzf2XhjRbCwlcJG4m6at2O4i0A2ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KCM/7KJt; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KCM/7KJt"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ba180a022dso82465ad.1
        for <iommu@lists.linux.dev>; Fri, 08 May 2026 06:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778245983; x=1778850783; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UfeHoHYCg5PRUJUcmkq+tWEtCYTcqi8Exur8keQ1cXQ=;
        b=KCM/7KJt3mauJ8l8XnN8Ds1PkLIwsnaQlAwQFKFnQwhWVAp5x65xFfZgbvvYJBxgb5
         7/4YbynA1Vm8ld2/Pkq7/Awu7x/+Cj7u9ZCo1CBeETsqTaY6BSVpvNBCBNcZVTnkCJxe
         6h+2HlQGy0Z8o8pfx+anDuzCcMnmEF+bnrISWbV+TPd8ggy67G2e3qnPKc/cchbMs5uw
         PeD6kWqzuhKX1+55mNDz3jk3JQZOJEecXWBiIWUiKFkAc+gdrEJW7TFLLzctgJ2Ryn3q
         HzNahKyFSjGSQfXKMjLxxy4nfITcKck0Mu7qD8Gkt7YYA+y3m6U4UMqW5hyYPyHmm/9U
         6L6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778245983; x=1778850783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UfeHoHYCg5PRUJUcmkq+tWEtCYTcqi8Exur8keQ1cXQ=;
        b=rP5zsqppt0iA2fRs25Vf7aR+pzWVa78nttrWB8f2QCvv5Jimq8dIWyG4COOhNcnsQX
         oqOiC3zz5rQISMPAbR1PcFSircf9W5c3HrqTa7kFRFzO7Z0qxLj4jZnMop/fHuHafDsB
         AxxAeUJZq5w6m7bsPNCgb0f+Uol/h6INv/ZjmHICuO6CtuAuYHS04roi1vLkFKBp4qvI
         iQLyzJCDNM9f/9f/NusipymmXCfnik46eemveHKw7+rsRKeSwRuaQJQVMU5ICXqrH9Tw
         vgEhhtnNBMndjJx+CZdqBvFWt4QjWobI87COHiDkaJgdrN3HvWUjtDD1QHYGszU1Aah2
         bJ4w==
X-Forwarded-Encrypted: i=1; AFNElJ80n7LAC3/JrK2HHEYBCFvFGYOSl3f+HYulWmRQkrva9H5NLnEgKCNK6+UEKY3oS8+33QgYxw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwNxkwBT2pbOn1Til00UNHndI9qreul47E0c0MOGetyiIhwrqn2
	VVNqfWEE/t3X2QnXV2KZ9OLBjvtz/2gpaD6L8dIhdr1QdONwGDZCeT+eaEDgwb1/Bg==
X-Gm-Gg: Acq92OHXnlWulqljKElrRe3HXuk6nNFZrP4aeWAFtVlUvzQpHoYwA0mwbRg0t/BFocu
	7PswZv6h9eZFMl3n/UY6QlNaYjotB5xf8f8PQ5MVfT5C8KGhEcZFjUSyhi86TVTwWALvHBLkL7a
	ugqavsGCivw8RL0SBw0bg1rnCcK/0FYrX3tQn5ku95Y7KFPSD9NXFfTbNz/x92xhLEjc3h7lG/P
	ZIk0Pdbx16aaMLsqlJDKS13oKhOTGVGwYTL/Sv4vioM3f7M2kXx5cO5lTDwhiUhQsbax2hEyfrx
	V3z+LTiSlzpavcFSvCB6//tugQrAQx6sVjvc28ugvCMJ+LIfvb22bePzTaejjtYz2Jr1rskxuDm
	L/l5xIPfP2xKxdAVDl3fO4GyHMpAlVL8WXBCfxOKSkh7ejb4WgctQV6JJ16AnKU443pgJCSwQCS
	LGQSW9Nkh2Fx3/L+Pk6KNrV3x1vAzJ/hDGo24RflTCc/xX75akvegMAu6DtF+gXHv3A0c2gWfzo
	6lVxUc=
X-Received: by 2002:a17:903:388b:b0:2b9:e831:5e5c with SMTP id d9443c01a7336-2bae9ab0216mr3382075ad.4.1778245982914;
        Fri, 08 May 2026 06:13:02 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3664db4f5fbsm2341255a91.15.2026.05.08.06.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 06:13:02 -0700 (PDT)
Date: Fri, 8 May 2026 13:12:56 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	=?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3-sva: Enable Hardware Access and
 Hardware Dirty bits
Message-ID: <af3hWGp3etGOIdEn@google.com>
References: <20260503135413.1108138-1-nicolinc@nvidia.com>
 <af0SdkjQOZxnnaQb@google.com>
 <20260508123550.GB9254@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508123550.GB9254@nvidia.com>

On Fri, May 08, 2026 at 09:35:50AM -0300, Jason Gunthorpe wrote:
> On Thu, May 07, 2026 at 10:30:14PM +0000, Pranjal Shrivastava wrote:
> > > @@ -92,6 +92,16 @@ void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
> > >  
> > >  		target->data[1] = cpu_to_le64(virt_to_phys(mm->pgd) &
> > >  					      CTXDESC_CD_1_TTB0_MASK);
> > > +
> > > +		/*
> > > +		 * Enable Hardware Access and Dirty updates (DBM) if supported.
> > > +		 * This is safe to enable by default, as PTE_WRITE and PTE_DBM
> > > +		 * share the same bit.
> > > +		 */
> > > +		if (master->smmu->features & ARM_SMMU_FEAT_HA)
> > > +			target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_HA);
> > > +		if (master->smmu->features & ARM_SMMU_FEAT_HD)
> > > +			target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_HD);
> > 
> > IIUC, we should be setting these if IO_PGTABLE_QUIRK_ARM_HD is present?
> 
> SVA does not use IO_PGTABLE at all, and it directly constructs its own
> CD.
> 
> No relation between those two flows.

I understand that but I mean we need to know if the system supports
HTTU ? Like for SMMU we use the IO_PGTABLE_QUIRK, shouldn't we be
checking if the CPU's tables support HTTU?

Are we assuming that if the SMMU IDR presents HTTU capability the MMU
would also have it? I think an unconditional enablement is risky as we
may not have system-wide HTTU support.

If we look at arm_smmu_master_sva_supported, the driver already 
maintains a strict agreement between the CPU and SMMU for SVA.
It checks sanitized CPU ID registers for things like PARANGE & ASIDBITS,
and it uses system_supports_bbml2_noabort() to decide whether to enable 
FEAT_BBML2.

Shouldn't we follow this exact same pattern for HTTU ?
We should probably be checking cpu_has_hw_af() (from asm/cpufeature.h) 
in the SVA support check or here if we wanna enable HTTU.

Thanks,
Praan
