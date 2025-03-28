Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5293C20E003
	for <iommu@lists.linux.dev>; Fri, 28 Mar 2025 09:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743153560; cv=none; b=j1nWCPPxC/YTL1rClV2cnPlDqJB3n4BX3HXg6MFhvrI1Tn49LLN+mtQzZEFUmOMUr+YiNtNN5yEmc5nv7dDb5JjniO6pjgaQBlQCU5YhhyzebBz7qN+4LOwk83beIRZezdcqV7mkA2o/jN89HBK26aMVu3wyt1OmvpEWfvJp57A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743153560; c=relaxed/simple;
	bh=EhMsW90tBo76YANdNO+y4vYJRL/VCm5T+l6WQpquE44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvwqABZiJKzZZuyKUZojSyO/ec7r++7B3f20iyfBVblj1J+F+X5RRCRrP1wrQJo8TpU/me97JiWQdppL5vu5CptLJYOvpdG7cvyRN44giXMyUhFM/bJRCl93uGCpbAVuWujB18d1N7X/n6bxs42a4K6G95bYYU3khm4rXDXEi3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aip8YRqu; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aip8YRqu"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2240aad70f2so182355ad.0
        for <iommu@lists.linux.dev>; Fri, 28 Mar 2025 02:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743153557; x=1743758357; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cTnsXLwID5o8luA/SSO9HTUDbG8g7fr9SSFbTq9PRAo=;
        b=aip8YRqusQNMHVhIMJIGwbc1VUU31IWtQ5gpZ+xEsaaDx386dfoD+cFUQBFPofJjEb
         u9dX4YnBtF+J/AKmX20BpZ/OXMvl/0mFkftlJn0nIpI71QlWwUUfA+tG22v4P/VO/U1p
         m+ESHXatfgt4qqpjodod7ccQyY2xCL46v6dw3r+aAVbooZkQAhXWQqzRh6Hj6uwS3BuH
         v8tAmZPzoYteJyKjq5yhIZjzm8dzwh6YZ61p0xq7GZq1pcPK9gPOG6erfPq8ki1WFpgc
         cgeQninRcpx/oa7oEYzWAbnVF84WQbZ7pcJHERvuiKD3nbaL+aDJ8YrzTgNtfFQya5Gd
         fBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743153557; x=1743758357;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cTnsXLwID5o8luA/SSO9HTUDbG8g7fr9SSFbTq9PRAo=;
        b=GaJ0bkwttrWLvCRb/lh8mBLAUtlabtDqeHGqnuBAWMgtiH4jD0SRWhx2HOldUUOlbT
         1Pg390BSuSEFY0ukvf6LoWAIQ4p3CpnzYYQI4d81EcI9WKjTjQa715GpgQSb0Th6Fb0h
         B6weKKGEZJdPF8w2vITQEbq8a1wDfa50NrjkCxCUkGaTuPfvPvYSFFQcYOGXIeD/u6xH
         kkliuzBZDFm3EdJAvnBqpyMR1VeC5hq8DTrin7Z7dhyn99WQnoB5P2bsMvDz2f9pIXVz
         6LF8Dy3fT+KNJZNpMJCCboPAxmWBI+z1m7XWm6WYMg4MSWb/Zd/Y/LoTTyxj5VC2RfH2
         nXOw==
X-Forwarded-Encrypted: i=1; AJvYcCWP4UEikLbEe6cmW/DL0i1WlnuMZhzLY2LafiHFOdx3llSwfl7y29mpWmQ+eKin+xkiXvMrkA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/f/p5L9fjFVmf1GIueoSp/eNNAq31KZziEbVuBHJyuaJlt/4C
	/b7SdNrJtDiL2jTmI/IEjFrQUJS0cxxMMQPc2YosrqFvoAlsB0xtbpzJ+MVvMg==
X-Gm-Gg: ASbGncvQad4CoZkPvoco8NCUvu8ES9hmuS0XD7CZWQqQj1GNn4Yu+ZwFxX3K/lhOiG8
	GbdulkX5kIAq/5S/hffMuBB6p+4H/3laIi+j4MSI4dEaloJkQQ4ikDHz8moK1+uSYoJISOVXdyk
	sJwvNMJs+KTJi2BOPGG0XJnklqg3r6x/1z6N6I1LEJM/8IFd1bdqJo7l+xwb/hW5tnurE81pLKu
	AbIHhiw3v9Hg8uehK1rMRpF+EQz3H4sngFQntVropERVaMYy27x+RyU7kDgjmeC3Pz8Xb2iUcsS
	PUF/cz/p1HpFi+KCpgxsrvvRssorh1Ea7K8XGvnLVNXHKmqVapo/YNMifXbQTnaAVfYKGfwJIEQ
	IwbY=
X-Google-Smtp-Source: AGHT+IGQZoWZJaz3qUY5lcvFpZKG1NTa7nP7AyGO+HVzUrQkoVfIwd9eQBg3SxO4UVQa/TurVwXyQw==
X-Received: by 2002:a17:902:d4c9:b0:224:38a:bd39 with SMTP id d9443c01a7336-22920e43075mr2420095ad.20.1743153557099;
        Fri, 28 Mar 2025 02:19:17 -0700 (PDT)
Received: from google.com (188.152.87.34.bc.googleusercontent.com. [34.87.152.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1deecdsm13064755ad.196.2025.03.28.02.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 02:19:16 -0700 (PDT)
Date: Fri, 28 Mar 2025 09:19:09 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 0/5] iommu/arm-smmu-v3: Implement Runtime/System
 Sleep ops
Message-ID: <Z-ZpjUHE0-zyj9Lb@google.com>
References: <20250319004254.2547950-1-praan@google.com>
 <20250319115730.GC10600@ziepe.ca>
 <003f23d7-b829-4611-8dd3-35b56a7ca90e@arm.com>
 <Z9yV8KsdXnZg1Ppo@google.com>
 <Z911UT59UnDzRymF@google.com>
 <63806834-a0a1-41e0-9cca-60087b460f78@arm.com>
 <Z-GYKyBi78tHw8Lx@google.com>
 <Z-WKlZMBDTJDSfd4@google.com>
 <Z-ZoHdfgyaZoqJkm@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z-ZoHdfgyaZoqJkm@google.com>

On Fri, Mar 28, 2025 at 09:13:01AM +0000, Pranjal Shrivastava wrote:
> On Thu, Mar 27, 2025 at 05:27:49PM +0000, Mostafa Saleh wrote:
> > On Mon, Mar 24, 2025 at 05:36:43PM +0000, Pranjal Shrivastava wrote:
> > > On Fri, Mar 21, 2025 at 05:35:11PM +0000, Robin Murphy wrote:
> > > > On 21/03/2025 2:18 pm, Pranjal Shrivastava wrote:
> > > > > On Thu, Mar 20, 2025 at 10:25:52PM +0000, Mostafa Saleh wrote:
> > > > > > On Wed, Mar 19, 2025 at 04:07:57PM +0000, Robin Murphy wrote:
> > > > > > > On 19/03/2025 11:57 am, Jason Gunthorpe wrote:
> > > > > > > > On Wed, Mar 19, 2025 at 12:42:49AM +0000, Pranjal Shrivastava wrote:
> > > > > > > > 
> > > > > > > > > 3. Invoking runtime_pm_get/put
> > > > > > > > > Given that most of the configuration done by arm-smmu-v3 is stored in
> > > > > > > > > memory, the initial idea is to focus on areas where the driver accesses
> > > > > > > > > the hw via exposed ops, like iommmu_ops, iommu_flush_ops, sva_ops etc.
> > > > > > > > 
> > > > > > > > This seems weird, if the SMMU is suspended doesn't it also fail DMA
> > > > > > > > transactions? Why would ops like flush even be called if the HW is
> > > > > > > > disabled?
> > > > > > > 
> > > > > > > Because once the device has finished its operation, its driver is free to
> > > > > > > call rpm_put() before calling dma_unmap(), so by the time that gets as far
> > > > > > > as TLB maintenance, the SMMU may already be asleep as well if that device
> > > > > > > was the only thing keeping it awake.
> > > > > > > 
> > > > > > > For direct IOMMU API users, pagetable update may be even more asynchronous
> > > > > > > from device activity, e.g. a GPU buffer might only be unmapped once
> > > > > > > userspace closes the last file handle referencing it, long after the GPU
> > > > > > > itself has moved on to other things.
> > > > > > > 
> > > > > > > > flush is performance path stuff, so it doesn't seem great to be adding
> > > > > > > > extra calls there.
> > > > > > > 
> > > > > > > That much is true - this really wants to be using pm_runtime_get_if_in_use()
> > > > > > > nearly everywhere such that at most it's just juggling refcounts. There's no
> > > > > > > point waking the SMMU up just to issue a CFGI or TLBI, if the act of doing
> > > > > > > so is inherently going to do a full arm_smmu_reset() and thus invalidate
> > > > > > > everything anyway.
> > > > > > 
> > > > > > AFAICT, there is no guarantees that caches are clean on system resume,
> > > > > > but as we do invalidate everything that should be fine, but I am not sure
> > > > 
> > > > That was the point - we're definitely going to do a full software
> > > > invalidation *because* we can't make any assumptions about the hardware
> > > > state, i.e. it may come back full of valid-looking nonsense.
> > > > 
> > > > > I mean we do set GBPA.Abort = 1 right before suspending, I'd want to
> > > > > assume that doing so would ensure that TLB hits don't occur anymore. Let
> > > > > me dig into the spec to see if I can find something regarding TLB
> > > > > behavior when GBPA.Abort = 1
> > > > 
> > > > GBPA doesn't matter here, it's about the CR0.SMMUEN=0 behaviour (see
> > > > 6.3.9.6). That says "Incoming transactions [...] do not undergo
> > > > translation," so although TLB entries are allowed to remain present, they
> > > > must not be *used* - i.e. SMMUEN is not permitted to be cached in a TLB.
> > > > 
> > > 
> > > Thanks for pointing me to the right section. It also mentions: 
> > > When SMMU_(*_)CR0.SMMUEN == 0:
> > > "Translation and configuration cache entries are not inserted or
> > > modified, except for invalidation by maintenance commands or broadcast
> > > operations."
> > > 
> > > So, it looks like we don't need to worry much about a disabled
> > > programming interface causing changes to the TLB. 
> > 
> > I am not sure I am following, but we can’t  guarantee that GBPA.abort
> > is 1 after resume nor SMMUEN is 1
> > 
> 
> Correct. For GBPA, I think Jason suggested to have implementations
> declare if an implementation resets with GBPA.Abort=1 in a DT/ACPI flag.
> Based on that we can take calls, for e.g. don't suspend when there's
> some security sensitive attachement. Although, we need to define what
> would a "security sensitive attachment" be.
> 
> However, as per the spec, SMMUEN resets with 0 (section 6.3.9).
> And if SMMUEN=0, as per the spec, "the Configuration or translation
> structures are not accessed". Thus, when SMMUEN=0, the config cache &
> TLB, both shall not be accessed.. However, the spec mentions that
> invalidation of cached entries is supported when SMMUEN=0 & CMDQEN=1
> (which is what the driver does in arm_smmu_device_reset).
> 
> Other than that, the MMU-700 implementation spec[1] mentions that 
> certain revisions might access config and translation structures while
> SMMUEN=0 (through an impl defined prefetch), and one of the provided SW
> workarounds is to issue invalidate all with SMMUEN=0 after the SW has
> finished all modifications to config/translation structures, which seems
> to be happening anyway with arm_smmu_device_reset.
> 
> > > 
> > > However, another statement in the same section:
> > > 
> > > "Note: The ‘other’ Security state might still have SMMUEN == 1 and
> > > therefore be inserting cache entries for that Security state. As these
> > > entries are not visible to or affected by the Non-secure programming
> > > interface, this is only a consideration for the Secure programming
> > > interface which can maintain Non-secure cache entries."
> > > 
> > > Makes me think of situations where we might elide a TLB invalidate if
> > > the SMMU is SUSPENDED but the secure world gets a hit to the 
> > > invalidated TLB entry. The TLBI command could be a result of a simple
> > > non-driver kernel module unmapping a page based on it's communication
> > > with the secure world. In this case, devlinks may NOT save the day...
> > > 
> > > I know that the above situation is a burden on the SW designer or
> > > implementer, I just want to discuss is if we have something
> > > like the above case, that would not want us to elide TLBIs while
> > > suspended? (I'm not able to see any case where we share pages with
> > > the secure world at this time).
> > 
> > I don’t think we care about secure world, TLB would be tagged with the
> > NS bit, and at the moment there is nothing in the driver that interacts
> > with TZ on sharing NS page tables (we change IOVAs all the time and
> > there is no way TZ knows that)
> > 
> 
> Ack. If we don't care about the secure world, I think we are covered in
> terms of TLB / config cache invalidations. On suspend, we set SMMUEN=0
> and on resume (in arm_smmu_device_reset), we invalidate the caches/TLBs
> before setting SMMUEN=1.
> 
> The only thing that remains is GBPA resetting to bypass, where I think
> Jason's suggestion for a flag could potentially help.
> 
> > Thanks,
> > Mostafa
> > 
> 
> Thanks,
> Praan
> 

Forgot the attachment:
[1] https://developer.arm.com/documentation/SDEN-1786925/latest/

> > > 
> > > 
> > > > > > how that works with distributed SMMUs where the TBU can still be powered
> > > > > > with some TLBs that can be invalid?
> > > > > > 
> > > > > 
> > > > > Hmm.. do you mean some situation like:
> > > > > 
> > > > >   |-----------------------|    |-------------------|
> > > > >   | |-------|   |-------| |    |-------------------|
> > > > >   | | Dev X |   | Dev Y | |    |                   |
> > > > >   | | (TBU) |   |_______| |    |       SMMUv3      |
> > > > >   | |-------|             |    |  (TCU -> TBU_X)   |
> > > > >   |     Power_Domain A    |    |  Power_Domain B   |
> > > > >   |-----------------------|    |-------------------|
> > > > > 
> > > > > Now if Dev Y isn't an SMMU client and Dev X drops the ref_count,
> > > > > Power_Domain A would still remain ON whereas SMMUv3 might assume all
> > > > > it's clients are down and try to suspend (power off Power_Domain B)
> > > > > while the TLBs withing TBU_X are still powered up?
> > > > > 
> > > > > To avoid such a case maybe we should invalidate everything during
> > > > > suspend? I still believe that when CR0.SMMUEN=0, it should broadcast
> > > > > something to all it's TBUs asking them to invalidate all TLBs otherwise
> > > > > this is a miss in the arch (unlikely for Arm) as TLB hits should never
> > > > > occur if the SMMU is disabled. I guess I need to go through the SMMUv3
> > > > > spec (or maybe the MMU-700 TRM) for confirming this..
> > > > 
> > > > I don't think this is allowed to be an issue in practice since TBUs are not
> > > > architecturally visible. Certainly in terms of Arm's implementations, for a
> > > > TBU to be powered off or externally clock gated it would have to do a full
> > > > DTI disconnect (otherwise it would hang CMD_SYNC), and DTI requires that it
> > > > must subsequently come back clean:
> > > > 
> > > > "The TBU must invalidate its caches before entering CONNECTED state."
> > > > 
> > > 
> > > Interesting! Thanks for clarifying.
> > > 
> > > > Thanks,
> > > > Robin.
> > > 
> > > Thanks,
> > > Praan
