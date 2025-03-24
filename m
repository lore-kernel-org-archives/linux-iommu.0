Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C079264634
	for <iommu@lists.linux.dev>; Mon, 24 Mar 2025 17:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837815; cv=none; b=L5YzpBtWRy4TRydhTxu5FSIEk2Y9EsuqEqfTm+qsPY60Fv3O++TrMa6XKvaNxSNq2hkzMxqYEuamsD5P+dD7iiHZqQj9Isqle3OO2FTObFeyqjtNCCePcGfiQmjwxCDHXfDeNc7seeIfkz8JLxOLw+gsG+KgqG2gMCHuMqlqUTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837815; c=relaxed/simple;
	bh=tDyGErCKr+wYx5x2ZjbGWPZDPLKJsi1ea37yhUbXn4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIoDtIkOwmt2WsKHCOASbn6QVLzPkVciXnP2V3zNkN0i63Acdbmy+L+jKf+AUNjNLQmUB2IRfNwuFWuZ8rhze+Ke9y9kO218e3ElfHrUfjI3wWg0ydCC63Z/Tt4SWhJiwIwahU5mKFnDgnmoR6WE37B9JA85A/9AWSkBE1k4lPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Re8LjpIK; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Re8LjpIK"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2240aad70f2so18635ad.0
        for <iommu@lists.linux.dev>; Mon, 24 Mar 2025 10:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742837813; x=1743442613; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vo/D2aq2DSZjFd01m+a2s8jPxxOqyHS/3susSDtgw7I=;
        b=Re8LjpIKtLW83lITPg50Lv3mNEzvciPbwhZ6hJub8kdYFatfI1X7eSzJldXTTkpPCR
         CWqa4Oy8WIu0EJ6Y/nOEddDB8pWAdNpdxMgs7rYzCefZVKiFAVO4pMGw51woDfLSewwB
         ceEPTQmdfR/BF8TXTCdD8/FWM2YSMSWeiz4XfgJOdhNLjjeuDSZZQCPoDP79FCZD9lLr
         K0kQqV6K3PNIWzoybQIfnfqsTBShEy3O8EZdn51t0z35VpNixeC2xa8h1U/Sok7Z+D2C
         rwojoqPsf7dqOPHbMFL3uUtBg5Oe8ldCkfHGk2er/NY0ms3XXU7GK1j+KFlwGNtO2qrY
         gz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837813; x=1743442613;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vo/D2aq2DSZjFd01m+a2s8jPxxOqyHS/3susSDtgw7I=;
        b=GWben1Vm4PcVu5aRcQT4zRxL0J1mHYwuMynMbICrOD8XkRtEBFeYdHlL4zwNzbuDhV
         xG1gaWu49y1mlQjA46Jm+zQPKpPjoIUkKzrd7cMIcPMDU1Tj3VrkHlHDJrvJngYG5vnz
         PAU1UNI2ItiG+LByFWZQ58BsUpzJxNZoCyUZPL1lKVJPssVCDHZNER+U8NCZs4CYqvuA
         Xdp81FK/0e6JjN/HYtqqI1zOAuK7kO3NVOptaM1Fghc1tVlq/H9uDYrQQoW8Utd/MAnp
         pGYW7kG9PdiqSWGcw+gGI1SZ3Ylkru7aJgckHVz8najyi2GFYAo0I0ATIt7SwH4czksG
         NJ4w==
X-Forwarded-Encrypted: i=1; AJvYcCUY2HcMbj1fWs7tvX5AB55sZgHrZByqiG9epMj7ix3YuVHowbob2QZiAMzq3eWg75HuFOxLfg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxwpvJsQlRle/Mbys+URI4d9JbSniys+JOi070944g0sxu59iRo
	YzzQB2BNsVlrjNImEMFNUIFMKSV9QHa94t9mZaOOjWGnzuIppRZrawC0d5jfpw==
X-Gm-Gg: ASbGncsfzAo4zubvGF4/G2AIa8ee9kFQbX58CRPskU5dLn6L7ZgSuXJKcsG65CLdCDZ
	lncsbuIhaVCa42K7IBXCwnppKe4zvhfI1KNLEvz8c15iJGaRQga/XSTM0XBsaBWklI13LQqbYfV
	tNs0hiBNX1LYgzp2DvYKejj+c4ML4WIAdOBE0jJEaauOMWp2jDr7UJyeZyZbk+EapUcImYvUeRI
	C5Kbdk79pLhimZFnY5TsKrR9K+ZTjXvtxH53bGvkqmsdws9X9+ybZFPaVh6VCaTswW+8v32sb17
	xQIXXz6VLnVF54Z7i2yLRlLxDwMD9BECP1LvH/DUFN71xZB9rMWyEkin72IF94cY5uiviM4eIrX
	BQlYIIon0w2nygg==
X-Google-Smtp-Source: AGHT+IHls4OeAqHeepPYCy7WwjQeoktTF03TvpuDFyAdIybf56k04ntg8p2XiZt+TSX1pgypI3J7MQ==
X-Received: by 2002:a17:902:f68f:b0:220:c905:68a2 with SMTP id d9443c01a7336-22799f1db1bmr3707605ad.5.1742837812044;
        Mon, 24 Mar 2025 10:36:52 -0700 (PDT)
Received: from google.com (188.152.87.34.bc.googleusercontent.com. [34.87.152.188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390600bad4sm8233122b3a.77.2025.03.24.10.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 10:36:51 -0700 (PDT)
Date: Mon, 24 Mar 2025 17:36:43 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Mostafa Saleh <smostafa@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 0/5] iommu/arm-smmu-v3: Implement Runtime/System
 Sleep ops
Message-ID: <Z-GYKyBi78tHw8Lx@google.com>
References: <20250319004254.2547950-1-praan@google.com>
 <20250319115730.GC10600@ziepe.ca>
 <003f23d7-b829-4611-8dd3-35b56a7ca90e@arm.com>
 <Z9yV8KsdXnZg1Ppo@google.com>
 <Z911UT59UnDzRymF@google.com>
 <63806834-a0a1-41e0-9cca-60087b460f78@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63806834-a0a1-41e0-9cca-60087b460f78@arm.com>

On Fri, Mar 21, 2025 at 05:35:11PM +0000, Robin Murphy wrote:
> On 21/03/2025 2:18 pm, Pranjal Shrivastava wrote:
> > On Thu, Mar 20, 2025 at 10:25:52PM +0000, Mostafa Saleh wrote:
> > > On Wed, Mar 19, 2025 at 04:07:57PM +0000, Robin Murphy wrote:
> > > > On 19/03/2025 11:57 am, Jason Gunthorpe wrote:
> > > > > On Wed, Mar 19, 2025 at 12:42:49AM +0000, Pranjal Shrivastava wrote:
> > > > > 
> > > > > > 3. Invoking runtime_pm_get/put
> > > > > > Given that most of the configuration done by arm-smmu-v3 is stored in
> > > > > > memory, the initial idea is to focus on areas where the driver accesses
> > > > > > the hw via exposed ops, like iommmu_ops, iommu_flush_ops, sva_ops etc.
> > > > > 
> > > > > This seems weird, if the SMMU is suspended doesn't it also fail DMA
> > > > > transactions? Why would ops like flush even be called if the HW is
> > > > > disabled?
> > > > 
> > > > Because once the device has finished its operation, its driver is free to
> > > > call rpm_put() before calling dma_unmap(), so by the time that gets as far
> > > > as TLB maintenance, the SMMU may already be asleep as well if that device
> > > > was the only thing keeping it awake.
> > > > 
> > > > For direct IOMMU API users, pagetable update may be even more asynchronous
> > > > from device activity, e.g. a GPU buffer might only be unmapped once
> > > > userspace closes the last file handle referencing it, long after the GPU
> > > > itself has moved on to other things.
> > > > 
> > > > > flush is performance path stuff, so it doesn't seem great to be adding
> > > > > extra calls there.
> > > > 
> > > > That much is true - this really wants to be using pm_runtime_get_if_in_use()
> > > > nearly everywhere such that at most it's just juggling refcounts. There's no
> > > > point waking the SMMU up just to issue a CFGI or TLBI, if the act of doing
> > > > so is inherently going to do a full arm_smmu_reset() and thus invalidate
> > > > everything anyway.
> > > 
> > > AFAICT, there is no guarantees that caches are clean on system resume,
> > > but as we do invalidate everything that should be fine, but I am not sure
> 
> That was the point - we're definitely going to do a full software
> invalidation *because* we can't make any assumptions about the hardware
> state, i.e. it may come back full of valid-looking nonsense.
> 
> > I mean we do set GBPA.Abort = 1 right before suspending, I'd want to
> > assume that doing so would ensure that TLB hits don't occur anymore. Let
> > me dig into the spec to see if I can find something regarding TLB
> > behavior when GBPA.Abort = 1
> 
> GBPA doesn't matter here, it's about the CR0.SMMUEN=0 behaviour (see
> 6.3.9.6). That says "Incoming transactions [...] do not undergo
> translation," so although TLB entries are allowed to remain present, they
> must not be *used* - i.e. SMMUEN is not permitted to be cached in a TLB.
> 

Thanks for pointing me to the right section. It also mentions: 
When SMMU_(*_)CR0.SMMUEN == 0:
"Translation and configuration cache entries are not inserted or
modified, except for invalidation by maintenance commands or broadcast
operations."

So, it looks like we don't need to worry much about a disabled
programming interface causing changes to the TLB. 

However, another statement in the same section:

"Note: The ‘other’ Security state might still have SMMUEN == 1 and
therefore be inserting cache entries for that Security state. As these
entries are not visible to or affected by the Non-secure programming
interface, this is only a consideration for the Secure programming
interface which can maintain Non-secure cache entries."

Makes me think of situations where we might elide a TLB invalidate if
the SMMU is SUSPENDED but the secure world gets a hit to the 
invalidated TLB entry. The TLBI command could be a result of a simple
non-driver kernel module unmapping a page based on it's communication
with the secure world. In this case, devlinks may NOT save the day...

I know that the above situation is a burden on the SW designer or
implementer, I just want to discuss is if we have something
like the above case, that would not want us to elide TLBIs while
suspended? (I'm not able to see any case where we share pages with
the secure world at this time).


> > > how that works with distributed SMMUs where the TBU can still be powered
> > > with some TLBs that can be invalid?
> > > 
> > 
> > Hmm.. do you mean some situation like:
> > 
> >   |-----------------------|    |-------------------|
> >   | |-------|   |-------| |    |-------------------|
> >   | | Dev X |   | Dev Y | |    |                   |
> >   | | (TBU) |   |_______| |    |       SMMUv3      |
> >   | |-------|             |    |  (TCU -> TBU_X)   |
> >   |     Power_Domain A    |    |  Power_Domain B   |
> >   |-----------------------|    |-------------------|
> > 
> > Now if Dev Y isn't an SMMU client and Dev X drops the ref_count,
> > Power_Domain A would still remain ON whereas SMMUv3 might assume all
> > it's clients are down and try to suspend (power off Power_Domain B)
> > while the TLBs withing TBU_X are still powered up?
> > 
> > To avoid such a case maybe we should invalidate everything during
> > suspend? I still believe that when CR0.SMMUEN=0, it should broadcast
> > something to all it's TBUs asking them to invalidate all TLBs otherwise
> > this is a miss in the arch (unlikely for Arm) as TLB hits should never
> > occur if the SMMU is disabled. I guess I need to go through the SMMUv3
> > spec (or maybe the MMU-700 TRM) for confirming this..
> 
> I don't think this is allowed to be an issue in practice since TBUs are not
> architecturally visible. Certainly in terms of Arm's implementations, for a
> TBU to be powered off or externally clock gated it would have to do a full
> DTI disconnect (otherwise it would hang CMD_SYNC), and DTI requires that it
> must subsequently come back clean:
> 
> "The TBU must invalidate its caches before entering CONNECTED state."
> 

Interesting! Thanks for clarifying.

> Thanks,
> Robin.

Thanks,
Praan
