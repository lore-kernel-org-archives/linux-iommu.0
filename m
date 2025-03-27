Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292841DFF8
	for <iommu@lists.linux.dev>; Thu, 27 Mar 2025 17:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743096478; cv=none; b=hV2X1RAR3QkNuzE8tcgvdW2lUeW25tYL9dlcPUI1KjYIypek+WtO1KBAFb2LZfsRQWZ8FxtdGHr1idxcqhQ4MDuqw6Hmed7JjISX+aannZ4zCRVUgFCZuXH6tiCdO2dhDBMp5O/hYUxYeZkERDaO8W3pMewdLxftC/4EvsPXWuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743096478; c=relaxed/simple;
	bh=av541RTbvrQj+HaLqZbz+AqFdsQT364DMEh7VXKn6Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwcM+kLnS3B3amnUk7xp4CaN6hNCxr8nffbJAtWbu8kwwILjNX+mme3eUoC6/xFOAlVcHayZVLbXSxwAwap1j+OnpjPxFqlWyecunz3EGG7lA1rsB6He3F94WqRqjvtKPDsfzJlhs6bdUlBD7EXl8UEr2/BRVb13YusUF50N6iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kH2HVmdi; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kH2HVmdi"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43d5f10e1aaso5055e9.0
        for <iommu@lists.linux.dev>; Thu, 27 Mar 2025 10:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743096474; x=1743701274; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9K74RDz+BCwTqRu+F54T1jLbhbv09OoXq/Jzdg5E2ug=;
        b=kH2HVmdiYMRMcojibZGEyaCw65vJuLMHv2xp7mBd2+ZOrYRWPgtCB92TEgYaYmkhU5
         zkuyMSAHxPrwh5FgEgXKnqEHBlDQV+Z4BzQax0a3DUm0hGtZa+nsQ/oy8+9MGpsFiRA8
         jecAnypZAibQ3GznvBV8PAiy5IgEndXI+z4qwWqyl/E86BmId7QaVPTLPGlQ6N4YOlSs
         9WWCKli/1yyEZKhDPwIbutsBSB0FAteE0K5rKAdICLClxxuWOEZtBCPRYAHWoy2gKEyX
         bnzn3YEVnFRy+uWOerELLiIreVEKZV96uq001HMEFvL8SmOpwFg5PUFv4kLYN8u6Mrx9
         eFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743096474; x=1743701274;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9K74RDz+BCwTqRu+F54T1jLbhbv09OoXq/Jzdg5E2ug=;
        b=Q5GIKw9Qbyi+eY46mEBdm4BfaKNtGFVwzkpvGaEZFwMJGX78YA5qfOlvfqW6OUd+f7
         dwF92NlB1Ku3M7oCr7uzKZnAi31MGg+No78d2xm1dNFhDcHrCEICFfd5h53Gf4SQhS/L
         Rz6lC6Flxg51BPxyRiIGj8IY7SnSqWcXnKHZrMLkDYGWywtXjH8LwjvpKRyuiqmtTaK2
         nhSLFSpMmeISKw4Ve31tanceFAnRbxa7gc6L7zFO/xv9VtVvcMOeza8nXXVkF1IP9blq
         +rcJXXdF8EBVwlQH0HHgqjtgFsGCELDFUaCoEhvfRsIvkzOG5lnBR+WPke/zM17iZ9DZ
         t5ag==
X-Forwarded-Encrypted: i=1; AJvYcCU/064+pLFJLJpEU8r/8JvO74jC59j/vAjGra9t90MWt9zWuUxSUov8JO77wdKajK38eSbSVg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzlYYLtCAK+Sp1NpBc5I4bRiKS2rGq1UjS9MOgmRMlzMJJlMmvZ
	X8NXuCcg4GWr2ZFRNtE2hGWQmPZn+MBkabjl06QXZb1QYPeIdUmHmk++wPkI3A==
X-Gm-Gg: ASbGncsKCXuNy0xnw+fwmRIt6v/ZEdOlKPujh5PhGr1asmOtkaAIWZ5eAVoPci8vFVx
	1Y01sGNImZIsGbsB+I9UnC60sZuuQ7AWmdW6tx9J9jWoM8Vl9efDbygeEDb9lXgZDT4P7hViFLs
	ERjiPFfDDODogSWh3TTAgflNbxzIW6yaPRp67IehFotTeL0SiawOhS72sgoLBk+qRidp9QPnFFi
	KP7AI5XD26bCRrU/o55loUDPeBfamlCyWc10fM7N4k9YMF7mFxgqEUdiU6+O42Kh/YXs38N0gzl
	3q3HqFfZ68BqAmWYxSGaTADrLN8K+vMkd+jIpfT5w9If5EkOnaask62vPLexoA5GmK3g7HWYqNU
	aiqnV
X-Google-Smtp-Source: AGHT+IGG18gz48aQ7M9U4IlE47hCTf2DXPsUT5bxJRnp/x2NZyPwkXOa25gJt41Ipsg0uVg2Co0lYw==
X-Received: by 2002:a05:600c:3b15:b0:43b:c2cc:5075 with SMTP id 5b1f17b1804b1-43d8f3fbd35mr98355e9.5.1743096474133;
        Thu, 27 Mar 2025 10:27:54 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b662736sm129347f8f.22.2025.03.27.10.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 10:27:53 -0700 (PDT)
Date: Thu, 27 Mar 2025 17:27:49 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 0/5] iommu/arm-smmu-v3: Implement Runtime/System
 Sleep ops
Message-ID: <Z-WKlZMBDTJDSfd4@google.com>
References: <20250319004254.2547950-1-praan@google.com>
 <20250319115730.GC10600@ziepe.ca>
 <003f23d7-b829-4611-8dd3-35b56a7ca90e@arm.com>
 <Z9yV8KsdXnZg1Ppo@google.com>
 <Z911UT59UnDzRymF@google.com>
 <63806834-a0a1-41e0-9cca-60087b460f78@arm.com>
 <Z-GYKyBi78tHw8Lx@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z-GYKyBi78tHw8Lx@google.com>

On Mon, Mar 24, 2025 at 05:36:43PM +0000, Pranjal Shrivastava wrote:
> On Fri, Mar 21, 2025 at 05:35:11PM +0000, Robin Murphy wrote:
> > On 21/03/2025 2:18 pm, Pranjal Shrivastava wrote:
> > > On Thu, Mar 20, 2025 at 10:25:52PM +0000, Mostafa Saleh wrote:
> > > > On Wed, Mar 19, 2025 at 04:07:57PM +0000, Robin Murphy wrote:
> > > > > On 19/03/2025 11:57 am, Jason Gunthorpe wrote:
> > > > > > On Wed, Mar 19, 2025 at 12:42:49AM +0000, Pranjal Shrivastava wrote:
> > > > > > 
> > > > > > > 3. Invoking runtime_pm_get/put
> > > > > > > Given that most of the configuration done by arm-smmu-v3 is stored in
> > > > > > > memory, the initial idea is to focus on areas where the driver accesses
> > > > > > > the hw via exposed ops, like iommmu_ops, iommu_flush_ops, sva_ops etc.
> > > > > > 
> > > > > > This seems weird, if the SMMU is suspended doesn't it also fail DMA
> > > > > > transactions? Why would ops like flush even be called if the HW is
> > > > > > disabled?
> > > > > 
> > > > > Because once the device has finished its operation, its driver is free to
> > > > > call rpm_put() before calling dma_unmap(), so by the time that gets as far
> > > > > as TLB maintenance, the SMMU may already be asleep as well if that device
> > > > > was the only thing keeping it awake.
> > > > > 
> > > > > For direct IOMMU API users, pagetable update may be even more asynchronous
> > > > > from device activity, e.g. a GPU buffer might only be unmapped once
> > > > > userspace closes the last file handle referencing it, long after the GPU
> > > > > itself has moved on to other things.
> > > > > 
> > > > > > flush is performance path stuff, so it doesn't seem great to be adding
> > > > > > extra calls there.
> > > > > 
> > > > > That much is true - this really wants to be using pm_runtime_get_if_in_use()
> > > > > nearly everywhere such that at most it's just juggling refcounts. There's no
> > > > > point waking the SMMU up just to issue a CFGI or TLBI, if the act of doing
> > > > > so is inherently going to do a full arm_smmu_reset() and thus invalidate
> > > > > everything anyway.
> > > > 
> > > > AFAICT, there is no guarantees that caches are clean on system resume,
> > > > but as we do invalidate everything that should be fine, but I am not sure
> > 
> > That was the point - we're definitely going to do a full software
> > invalidation *because* we can't make any assumptions about the hardware
> > state, i.e. it may come back full of valid-looking nonsense.
> > 
> > > I mean we do set GBPA.Abort = 1 right before suspending, I'd want to
> > > assume that doing so would ensure that TLB hits don't occur anymore. Let
> > > me dig into the spec to see if I can find something regarding TLB
> > > behavior when GBPA.Abort = 1
> > 
> > GBPA doesn't matter here, it's about the CR0.SMMUEN=0 behaviour (see
> > 6.3.9.6). That says "Incoming transactions [...] do not undergo
> > translation," so although TLB entries are allowed to remain present, they
> > must not be *used* - i.e. SMMUEN is not permitted to be cached in a TLB.
> > 
> 
> Thanks for pointing me to the right section. It also mentions: 
> When SMMU_(*_)CR0.SMMUEN == 0:
> "Translation and configuration cache entries are not inserted or
> modified, except for invalidation by maintenance commands or broadcast
> operations."
> 
> So, it looks like we don't need to worry much about a disabled
> programming interface causing changes to the TLB. 

I am not sure I am following, but we can’t  guarantee that GBPA.abort
is 1 after resume nor SMMUEN is 1

> 
> However, another statement in the same section:
> 
> "Note: The ‘other’ Security state might still have SMMUEN == 1 and
> therefore be inserting cache entries for that Security state. As these
> entries are not visible to or affected by the Non-secure programming
> interface, this is only a consideration for the Secure programming
> interface which can maintain Non-secure cache entries."
> 
> Makes me think of situations where we might elide a TLB invalidate if
> the SMMU is SUSPENDED but the secure world gets a hit to the 
> invalidated TLB entry. The TLBI command could be a result of a simple
> non-driver kernel module unmapping a page based on it's communication
> with the secure world. In this case, devlinks may NOT save the day...
> 
> I know that the above situation is a burden on the SW designer or
> implementer, I just want to discuss is if we have something
> like the above case, that would not want us to elide TLBIs while
> suspended? (I'm not able to see any case where we share pages with
> the secure world at this time).

I don’t think we care about secure world, TLB would be tagged with the
NS bit, and at the moment there is nothing in the driver that interacts
with TZ on sharing NS page tables (we change IOVAs all the time and
there is no way TZ knows that)

Thanks,
Mostafa

> 
> 
> > > > how that works with distributed SMMUs where the TBU can still be powered
> > > > with some TLBs that can be invalid?
> > > > 
> > > 
> > > Hmm.. do you mean some situation like:
> > > 
> > >   |-----------------------|    |-------------------|
> > >   | |-------|   |-------| |    |-------------------|
> > >   | | Dev X |   | Dev Y | |    |                   |
> > >   | | (TBU) |   |_______| |    |       SMMUv3      |
> > >   | |-------|             |    |  (TCU -> TBU_X)   |
> > >   |     Power_Domain A    |    |  Power_Domain B   |
> > >   |-----------------------|    |-------------------|
> > > 
> > > Now if Dev Y isn't an SMMU client and Dev X drops the ref_count,
> > > Power_Domain A would still remain ON whereas SMMUv3 might assume all
> > > it's clients are down and try to suspend (power off Power_Domain B)
> > > while the TLBs withing TBU_X are still powered up?
> > > 
> > > To avoid such a case maybe we should invalidate everything during
> > > suspend? I still believe that when CR0.SMMUEN=0, it should broadcast
> > > something to all it's TBUs asking them to invalidate all TLBs otherwise
> > > this is a miss in the arch (unlikely for Arm) as TLB hits should never
> > > occur if the SMMU is disabled. I guess I need to go through the SMMUv3
> > > spec (or maybe the MMU-700 TRM) for confirming this..
> > 
> > I don't think this is allowed to be an issue in practice since TBUs are not
> > architecturally visible. Certainly in terms of Arm's implementations, for a
> > TBU to be powered off or externally clock gated it would have to do a full
> > DTI disconnect (otherwise it would hang CMD_SYNC), and DTI requires that it
> > must subsequently come back clean:
> > 
> > "The TBU must invalidate its caches before entering CONNECTED state."
> > 
> 
> Interesting! Thanks for clarifying.
> 
> > Thanks,
> > Robin.
> 
> Thanks,
> Praan
