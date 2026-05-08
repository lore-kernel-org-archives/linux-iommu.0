Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530473E5589
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 13:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778248660; cv=none; b=TciC0BjiSg/81nLazK+2hBT7SvpD7oPxcLO8PrdyvO2STkePhjzzVdYuji9llhrPc2MQkwPQdJgPH+GqKQMxparYAe+PCv9lvMQ101lsvT/6Sn1Wui1r3EBOqMG6p3aUfAsYGyBPv629kjMIXajOs05kU7mC+UeRan5RcDwJCH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778248660; c=relaxed/simple;
	bh=7yau3d87sObHanjQIMBqjvHJ1Z5ikCcehMsXFQiWwa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Marz/KTHGdOz2OxZzVUtjaj3lHH+GdnQBT/gv/u+36yxp7dQHPZ4JHkNTTKtmymH6IVRCki1chfYb5nweYFt3DHSytNmsPfN17T8u0JMn9AEfpYJYcJ0LJ48z8vT5fmSz1PAA4FN7yW91BODhYGy/kNEFEWt4q4gfSLCNkAk/UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K/CDjKME; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K/CDjKME"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ba180a022dso87445ad.1
        for <iommu@lists.linux.dev>; Fri, 08 May 2026 06:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778248658; x=1778853458; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2CGBwXFExFaRTA0wwGYcIL+GR6BKdaPP0X35HwC1TKY=;
        b=K/CDjKMExLu3XEzHKacJOS1YlkfY+KntCY839mrY/Q5qA7fK6sOgPHScHtKwb8XLvS
         Z2t2UlomB/1X7YSh4fXR+Kchg2/BsveRDyv8sPSOeHiAtp1W+drQWDEf7nv0OB2AwrGv
         1GOXiBNJZQEH7ec9r3bPMGuvJ+tGV/q22k7KbpryvRafXT0gJv4e/nddJxzIKAWIEMF6
         R/ARICLOWgMnDWZVO9zZYR/zJbh6tFB4LYIzkR6lY+QJS7HYU4BcExhfzjEJd1paoyFH
         trrCECiedLcBYjv11VP/6xnUQKGvchjt8mqiGg7aBN8T5wwNm1Dgw2+vW5RvbmK1s6zl
         lMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778248658; x=1778853458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2CGBwXFExFaRTA0wwGYcIL+GR6BKdaPP0X35HwC1TKY=;
        b=EQtINBTCs0RO8z4Ln29G27ipBTeq/1TNpu0zpNu7H8eGAypGpC0G224wa+OzX4fk/5
         OblTudfrTgjYxq+xq9z3qs13lx8ztrLk14afwrHS006PjXXZNFtkEOeZRbG00y2bfoGB
         RI1R1KeKSde8rRTQU/rD0KhCNlDXjQGCSZ8RH3PYphT7eyHw0n9PPPgFKAZFd4czHvpM
         w4HhEAs9S88bjM7vlFBNYUqw+JRxewb6tF/U1FiAMtuoYT4ST+7+IpB+xqtI69g6wHAq
         2Jxb5LJjExbnyQcd7Fj5j9OeTFivNA/FVNYfg3p/G+l1+5Qv17WbbzxrO2GMmQck7FYL
         pp7Q==
X-Forwarded-Encrypted: i=1; AFNElJ90EBS5JPACKpBcEJwrT1wF2IahyE+vrN3ZDVV8FKf3pFbnTMTFPi56rK7PzFTW+HDSHeOvhw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwLxv8DmTyjEIDW1Ljq9aVCiEE2RWh+n79SfR6rYBjpxb/Rl7ZX
	QQfhsDZril3MwxK0THR+23OB7XL3IgZmKkUDGjXvCxsSkFbdRf6HyWJ1/kzPOTTceA==
X-Gm-Gg: Acq92OHaTJx4zhoq9VfCC1K44E0a/T+50n+Jsm9Y/5rCfTwpTdxDNSV+LO/C6O9zlQW
	fyAV0ZOhtnN8HYa/xLJo+HXRTIgCly7+BZo37df+FbaUgIlcVr9HDPUL6niYWOuLzrcJAIbK1ve
	M54/D3WKRWi/2XSFc21kjUs63ayUfXgqbt1cSgn6y9bSrKBFfwYAuZLDGOWtjsR8L4iKSXwnPGO
	B4sTEF0G6Sao0isN0toePzVEBbpEkI6LPbxZSo0l0p/vteDX1V8CJDEUv77ZKbiKWIoxzCLilhH
	DAGYMFj1/1YZEIQ19JspHyCdMJmbE3E35tQUEeJrP4s033E8tcgCRSO2h7FSeDplKaNYVxAyjpa
	Zzlyq2e1lMKqsl991D85/OllSCCdW4b/OA3FojyuH2ovh3yAOlbOKnqgTjtT3toeEr8iSrrm7fe
	Eq1UCiqYD/Ew1YmtVJSSnJflmn1OrV0yzyc3Lxc2SZ6c3QxwyVUSx2xC6NkYAxYjNhCm+G
X-Received: by 2002:a17:903:1b66:b0:2a7:6c4e:5914 with SMTP id d9443c01a7336-2bae9ab0221mr3968545ad.6.1778248656937;
        Fri, 08 May 2026 06:57:36 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3664da41fcasm2594450a91.2.2026.05.08.06.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 06:57:36 -0700 (PDT)
Date: Fri, 8 May 2026 13:57:30 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	=?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3-sva: Enable Hardware Access and
 Hardware Dirty bits
Message-ID: <af3ryl7G58D2GeWr@google.com>
References: <20260503135413.1108138-1-nicolinc@nvidia.com>
 <af0SdkjQOZxnnaQb@google.com>
 <20260508123550.GB9254@nvidia.com>
 <af3hWGp3etGOIdEn@google.com>
 <f31043cc-45dd-457f-8031-0cef51c9470e@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f31043cc-45dd-457f-8031-0cef51c9470e@arm.com>

On Fri, May 08, 2026 at 02:31:11PM +0100, Robin Murphy wrote:
> On 2026-05-08 2:12 pm, Pranjal Shrivastava wrote:
> > On Fri, May 08, 2026 at 09:35:50AM -0300, Jason Gunthorpe wrote:
> > > On Thu, May 07, 2026 at 10:30:14PM +0000, Pranjal Shrivastava wrote:
> > > > > @@ -92,6 +92,16 @@ void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
> > > > >   		target->data[1] = cpu_to_le64(virt_to_phys(mm->pgd) &
> > > > >   					      CTXDESC_CD_1_TTB0_MASK);
> > > > > +
> > > > > +		/*
> > > > > +		 * Enable Hardware Access and Dirty updates (DBM) if supported.
> > > > > +		 * This is safe to enable by default, as PTE_WRITE and PTE_DBM
> > > > > +		 * share the same bit.
> > > > > +		 */
> > > > > +		if (master->smmu->features & ARM_SMMU_FEAT_HA)
> > > > > +			target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_HA);
> > > > > +		if (master->smmu->features & ARM_SMMU_FEAT_HD)
> > > > > +			target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_HD);
> > > > 
> > > > IIUC, we should be setting these if IO_PGTABLE_QUIRK_ARM_HD is present?
> > > 
> > > SVA does not use IO_PGTABLE at all, and it directly constructs its own
> > > CD.
> > > 
> > > No relation between those two flows.
> > 
> > I understand that but I mean we need to know if the system supports
> > HTTU ? Like for SMMU we use the IO_PGTABLE_QUIRK, shouldn't we be
> > checking if the CPU's tables support HTTU?
> > 
> > Are we assuming that if the SMMU IDR presents HTTU capability the MMU
> > would also have it? I think an unconditional enablement is risky as we
> > may not have system-wide HTTU support.
> > 
> > If we look at arm_smmu_master_sva_supported, the driver already
> > maintains a strict agreement between the CPU and SMMU for SVA.
> > It checks sanitized CPU ID registers for things like PARANGE & ASIDBITS,
> > and it uses system_supports_bbml2_noabort() to decide whether to enable
> > FEAT_BBML2.
> > 
> > Shouldn't we follow this exact same pattern for HTTU ?
> > We should probably be checking cpu_has_hw_af() (from asm/cpufeature.h)
> > in the SVA support check or here if we wanna enable HTTU.
> 
> It might make sense to depend on CONFIG_ARM64_HW_AFDBM - when that is
> enabled, then IIRC we already expect to cope with some CPUs not supporting
> hardware updates, so it should still be fine for an SMMU to make them even
> if no CPU does. However, if it's disabled then I'm not sure if missing
> access flag faults (if SMMU HA silently sets them) might be an issue - for
> dirty, we'd just never put down the Writeable-Clean permission so enabling
> SMMU HD wouldn't do anything anyway.

I see, so IIUC, you mean if IS_ENABLED(CONFIG_ARM64_HW_AFDBM) but CPU
doesn't enable HTTU, it is perfectly safe to let the SMMU do HTT updates,
Since the fault handlers are already expecting HW-triggered updates?

Which means our check would be something like:

   if (IS_ENABLED(CONFIG_ARM64_HW_AFDBM) {
   	if (smmu->features & FEAT_HA)
	 ...
   }

instead of cpu_has_hw_af()?

Thanks,
Praan
