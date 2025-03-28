Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9002F3B
	for <iommu@lists.linux.dev>; Fri, 28 Mar 2025 09:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743153193; cv=none; b=TYVCPnUvTHLhaw9h6MKMfA7WC72VxniCr6f9750zQaM0A/PnFDEc8g9TEXXtnuqnobGRpn76ABAnX5EYlYGlTxptTWqC4z5UgW2nLYLBumWvJ0KGxU0urjwYkA+S/vHkCVH5Kwr0qyPJzdVRXG2W2LuaroU6oJwAjMZCO/7VkX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743153193; c=relaxed/simple;
	bh=Ezl6L8AmQhvxgJySppxy33HyLmAvfv42hOWs5fKEeaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeDWwdf8A6dbtDliBrGzCOYt2j4wlNKCE3UNzxJvEQwrfihoNEB6HxGfEnvbELyF1tU2OZfPTfP7UuABda5lbhYfb5cRPSq72f6lc9RaTVScf7ioChGitF9+0KZ2yFRPFbBFCs8DgZQAS4iO0+exOOtg+KEkhcEflhAv87IJbGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gSW6WLqs; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gSW6WLqs"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2242ac37caeso104105ad.1
        for <iommu@lists.linux.dev>; Fri, 28 Mar 2025 02:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743153190; x=1743757990; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5JKFBPhR5AeNgMFaT+PfPc0I3uFMOIr9DJBD0Qk8MXM=;
        b=gSW6WLqs8cG2ONTLY9uPnVIamZUwmhkSF58akolVALJKYoymt4JleWRJHnGYKR9GCz
         IAMXl2b/zjOoweRMje1YRF6fQ1TCmwD0jA5zzFvLzXrOZXs6bkTELlGqg9Nor2AAGnHv
         rPAd7pbNHqas0FYWbxO8S/2X35WYQBEIyEBo5i5A58IFuOpRhHOoTouma76gOvqIWFky
         x33rCP0VidMBPpEfhkRuKkEtkhzknWoWtPvpR2NJyp0vNHuWu2T1/GSb4A6aRvKP+BbY
         tFlAzxzgk13i+iFxz75Feeby7jQDbQ0If11ZC3ZYhDvLJdzXjqHut+gKgttH8e/24KO8
         XsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743153190; x=1743757990;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5JKFBPhR5AeNgMFaT+PfPc0I3uFMOIr9DJBD0Qk8MXM=;
        b=auic87sdtLYJO132f1xiIOrBgNdLc950gyyPzm0fP32W/pQEF7JGC/GKGgmnQjo7fK
         hnhc84JJM4oEFUvJgsFr7GpIraB0LCdgtCej6Eydkevm8APwPWWk3q0+YQulEANe/a/i
         QY+nq+YpO77P3rUTLvy1qnKznesTE+lNYljqQrGL5zz2Sr45l+oB9FkIZz+0shWkCErb
         Ky5kavCEVSe6u2C0NanRhkR+QQS2juDTTiMi/JXtGvYMxnEHbBLp9UudCXbZ74eYYHOn
         lgOSbpMAY2d1r7oMTU+NdKIbvMYNLndAnnovGaaob1lhliIJxQonVvKi82YHkdgZXDkQ
         3SmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzj1ATKL0DRgG1XcEZRQYoySSPe3QAVt/gC/B+U9yOjXRttaO3VnxjfoYz3UR886mWS0mBNw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzdZzyJ79IpNxdG1MZWvlnpdsr/4cvKUw3S2gQhsMuQxo6uT9p4
	BOIiTgpf9HjUpKB6wSij0R6faMvcmXUIhwJ1rzpeUDhcrZxnnB2if8UZLZ5vGg==
X-Gm-Gg: ASbGncuQeyQ+bZUM6e9VGMrOdYtyOMN8QNxvFEFvK0wbdHxod8qwB2TgdkZKflwTC02
	XRrEyogKa7KVRShR/jKaMb3FQ3CKrkyB72r5D2dKfSLYy9k2X+ClVsFwH5BeZf526a26rE+3EmK
	M1IXQ6tNlGKEltP8NZgUdU4SqEKCJMvsiXnWDkaUzy2NN/mRMfzSh0inEb8GbwgVDdjfAq7Cm0t
	ThF1ovNnXulYnraeZkgLS6fy3S5hc1wJhyNkjPDybWmqsg+TgfPXdTAAr04Oo4Xx/FVDJin7UDm
	/rnUfRJa76ZQuAqMlpeeD3kRGon8FE/mRFMwO/2pdgbGgta4S1yMg4tBRUdFblHT2iMv/ZaiL8p
	48rE=
X-Google-Smtp-Source: AGHT+IEFjaoqx9DhouQjPbFREoNHAmY61iOBmmDkQkqnokwA5Cl8Cv/76guE7n2rsa++3xJsN3lvaw==
X-Received: by 2002:a17:902:a609:b0:21f:3c4a:136f with SMTP id d9443c01a7336-22920e42525mr1933685ad.28.1743153189674;
        Fri, 28 Mar 2025 02:13:09 -0700 (PDT)
Received: from google.com (188.152.87.34.bc.googleusercontent.com. [34.87.152.188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73971063d19sm1282053b3a.90.2025.03.28.02.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 02:13:09 -0700 (PDT)
Date: Fri, 28 Mar 2025 09:13:01 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 0/5] iommu/arm-smmu-v3: Implement Runtime/System
 Sleep ops
Message-ID: <Z-ZoHdfgyaZoqJkm@google.com>
References: <20250319004254.2547950-1-praan@google.com>
 <20250319115730.GC10600@ziepe.ca>
 <003f23d7-b829-4611-8dd3-35b56a7ca90e@arm.com>
 <Z9yV8KsdXnZg1Ppo@google.com>
 <Z911UT59UnDzRymF@google.com>
 <63806834-a0a1-41e0-9cca-60087b460f78@arm.com>
 <Z-GYKyBi78tHw8Lx@google.com>
 <Z-WKlZMBDTJDSfd4@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z-WKlZMBDTJDSfd4@google.com>

On Thu, Mar 27, 2025 at 05:27:49PM +0000, Mostafa Saleh wrote:
> On Mon, Mar 24, 2025 at 05:36:43PM +0000, Pranjal Shrivastava wrote:
> > On Fri, Mar 21, 2025 at 05:35:11PM +0000, Robin Murphy wrote:
> > > On 21/03/2025 2:18 pm, Pranjal Shrivastava wrote:
> > > > On Thu, Mar 20, 2025 at 10:25:52PM +0000, Mostafa Saleh wrote:
> > > > > On Wed, Mar 19, 2025 at 04:07:57PM +0000, Robin Murphy wrote:
> > > > > > On 19/03/2025 11:57 am, Jason Gunthorpe wrote:
> > > > > > > On Wed, Mar 19, 2025 at 12:42:49AM +0000, Pranjal Shrivastava wrote:
> > > > > > > 
> > > > > > > > 3. Invoking runtime_pm_get/put
> > > > > > > > Given that most of the configuration done by arm-smmu-v3 is stored in
> > > > > > > > memory, the initial idea is to focus on areas where the driver accesses
> > > > > > > > the hw via exposed ops, like iommmu_ops, iommu_flush_ops, sva_ops etc.
> > > > > > > 
> > > > > > > This seems weird, if the SMMU is suspended doesn't it also fail DMA
> > > > > > > transactions? Why would ops like flush even be called if the HW is
> > > > > > > disabled?
> > > > > > 
> > > > > > Because once the device has finished its operation, its driver is free to
> > > > > > call rpm_put() before calling dma_unmap(), so by the time that gets as far
> > > > > > as TLB maintenance, the SMMU may already be asleep as well if that device
> > > > > > was the only thing keeping it awake.
> > > > > > 
> > > > > > For direct IOMMU API users, pagetable update may be even more asynchronous
> > > > > > from device activity, e.g. a GPU buffer might only be unmapped once
> > > > > > userspace closes the last file handle referencing it, long after the GPU
> > > > > > itself has moved on to other things.
> > > > > > 
> > > > > > > flush is performance path stuff, so it doesn't seem great to be adding
> > > > > > > extra calls there.
> > > > > > 
> > > > > > That much is true - this really wants to be using pm_runtime_get_if_in_use()
> > > > > > nearly everywhere such that at most it's just juggling refcounts. There's no
> > > > > > point waking the SMMU up just to issue a CFGI or TLBI, if the act of doing
> > > > > > so is inherently going to do a full arm_smmu_reset() and thus invalidate
> > > > > > everything anyway.
> > > > > 
> > > > > AFAICT, there is no guarantees that caches are clean on system resume,
> > > > > but as we do invalidate everything that should be fine, but I am not sure
> > > 
> > > That was the point - we're definitely going to do a full software
> > > invalidation *because* we can't make any assumptions about the hardware
> > > state, i.e. it may come back full of valid-looking nonsense.
> > > 
> > > > I mean we do set GBPA.Abort = 1 right before suspending, I'd want to
> > > > assume that doing so would ensure that TLB hits don't occur anymore. Let
> > > > me dig into the spec to see if I can find something regarding TLB
> > > > behavior when GBPA.Abort = 1
> > > 
> > > GBPA doesn't matter here, it's about the CR0.SMMUEN=0 behaviour (see
> > > 6.3.9.6). That says "Incoming transactions [...] do not undergo
> > > translation," so although TLB entries are allowed to remain present, they
> > > must not be *used* - i.e. SMMUEN is not permitted to be cached in a TLB.
> > > 
> > 
> > Thanks for pointing me to the right section. It also mentions: 
> > When SMMU_(*_)CR0.SMMUEN == 0:
> > "Translation and configuration cache entries are not inserted or
> > modified, except for invalidation by maintenance commands or broadcast
> > operations."
> > 
> > So, it looks like we don't need to worry much about a disabled
> > programming interface causing changes to the TLB. 
> 
> I am not sure I am following, but we can’t  guarantee that GBPA.abort
> is 1 after resume nor SMMUEN is 1
> 

Correct. For GBPA, I think Jason suggested to have implementations
declare if an implementation resets with GBPA.Abort=1 in a DT/ACPI flag.
Based on that we can take calls, for e.g. don't suspend when there's
some security sensitive attachement. Although, we need to define what
would a "security sensitive attachment" be.

However, as per the spec, SMMUEN resets with 0 (section 6.3.9).
And if SMMUEN=0, as per the spec, "the Configuration or translation
structures are not accessed". Thus, when SMMUEN=0, the config cache &
TLB, both shall not be accessed.. However, the spec mentions that
invalidation of cached entries is supported when SMMUEN=0 & CMDQEN=1
(which is what the driver does in arm_smmu_device_reset).

Other than that, the MMU-700 implementation spec[1] mentions that 
certain revisions might access config and translation structures while
SMMUEN=0 (through an impl defined prefetch), and one of the provided SW
workarounds is to issue invalidate all with SMMUEN=0 after the SW has
finished all modifications to config/translation structures, which seems
to be happening anyway with arm_smmu_device_reset.

> > 
> > However, another statement in the same section:
> > 
> > "Note: The ‘other’ Security state might still have SMMUEN == 1 and
> > therefore be inserting cache entries for that Security state. As these
> > entries are not visible to or affected by the Non-secure programming
> > interface, this is only a consideration for the Secure programming
> > interface which can maintain Non-secure cache entries."
> > 
> > Makes me think of situations where we might elide a TLB invalidate if
> > the SMMU is SUSPENDED but the secure world gets a hit to the 
> > invalidated TLB entry. The TLBI command could be a result of a simple
> > non-driver kernel module unmapping a page based on it's communication
> > with the secure world. In this case, devlinks may NOT save the day...
> > 
> > I know that the above situation is a burden on the SW designer or
> > implementer, I just want to discuss is if we have something
> > like the above case, that would not want us to elide TLBIs while
> > suspended? (I'm not able to see any case where we share pages with
> > the secure world at this time).
> 
> I don’t think we care about secure world, TLB would be tagged with the
> NS bit, and at the moment there is nothing in the driver that interacts
> with TZ on sharing NS page tables (we change IOVAs all the time and
> there is no way TZ knows that)
> 

Ack. If we don't care about the secure world, I think we are covered in
terms of TLB / config cache invalidations. On suspend, we set SMMUEN=0
and on resume (in arm_smmu_device_reset), we invalidate the caches/TLBs
before setting SMMUEN=1.

The only thing that remains is GBPA resetting to bypass, where I think
Jason's suggestion for a flag could potentially help.

> Thanks,
> Mostafa
> 

Thanks,
Praan

> > 
> > 
> > > > > how that works with distributed SMMUs where the TBU can still be powered
> > > > > with some TLBs that can be invalid?
> > > > > 
> > > > 
> > > > Hmm.. do you mean some situation like:
> > > > 
> > > >   |-----------------------|    |-------------------|
> > > >   | |-------|   |-------| |    |-------------------|
> > > >   | | Dev X |   | Dev Y | |    |                   |
> > > >   | | (TBU) |   |_______| |    |       SMMUv3      |
> > > >   | |-------|             |    |  (TCU -> TBU_X)   |
> > > >   |     Power_Domain A    |    |  Power_Domain B   |
> > > >   |-----------------------|    |-------------------|
> > > > 
> > > > Now if Dev Y isn't an SMMU client and Dev X drops the ref_count,
> > > > Power_Domain A would still remain ON whereas SMMUv3 might assume all
> > > > it's clients are down and try to suspend (power off Power_Domain B)
> > > > while the TLBs withing TBU_X are still powered up?
> > > > 
> > > > To avoid such a case maybe we should invalidate everything during
> > > > suspend? I still believe that when CR0.SMMUEN=0, it should broadcast
> > > > something to all it's TBUs asking them to invalidate all TLBs otherwise
> > > > this is a miss in the arch (unlikely for Arm) as TLB hits should never
> > > > occur if the SMMU is disabled. I guess I need to go through the SMMUv3
> > > > spec (or maybe the MMU-700 TRM) for confirming this..
> > > 
> > > I don't think this is allowed to be an issue in practice since TBUs are not
> > > architecturally visible. Certainly in terms of Arm's implementations, for a
> > > TBU to be powered off or externally clock gated it would have to do a full
> > > DTI disconnect (otherwise it would hang CMD_SYNC), and DTI requires that it
> > > must subsequently come back clean:
> > > 
> > > "The TBU must invalidate its caches before entering CONNECTED state."
> > > 
> > 
> > Interesting! Thanks for clarifying.
> > 
> > > Thanks,
> > > Robin.
> > 
> > Thanks,
> > Praan
