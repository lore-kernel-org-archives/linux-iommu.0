Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F2F3D6664
	for <iommu@lists.linux.dev>; Thu,  7 May 2026 10:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778148806; cv=none; b=liytEtqvi7gu7v2vQFDlyDjXL62khdkhS92ZRcW+D9buG0GvTezbYRfId0juGoPe0dIHBXsg+t67Z8soYcMJwTHdepQNsPyclmrJ0r/xYPXPVoJhOXsUhjwdDqKmKaY3j5Kk4os+wublVr9vChSES/9YVGwT0rW665r/aPjp/zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778148806; c=relaxed/simple;
	bh=iHSSMm5XmsR+SC8q2k1hfxidjzifsoc17tRBa7hWxWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p53X7UpFTJoXQvMystPy1hHtpEv0no7/vN1yx8Lcl9SX/xKrLNhmPe1HobbFcWT2+6tksCFQXhgnVfvxVR/W22kM/wdY5g6g60Ke+rHJE8mTQbj5dVG2RTkCqfFh02CsqEMXSQ5NDm3iGU79V5pnTlWaHCJtPvEjND2Q9eZweUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dxyqLO2I; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dxyqLO2I"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488940ccfa6so69925e9.1
        for <iommu@lists.linux.dev>; Thu, 07 May 2026 03:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778148799; x=1778753599; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4DTS0qUVxwfbisiyGTh7vOJzKa4BtZMrsDae9RELKmk=;
        b=dxyqLO2IGpXHLzSkpK97jc7slOwIG4K8DVwjFEsBwKMym23ZJxUBmfuWUeFUsFwz09
         H0neWCLx44ZcMYtXo9AHbPbkefTQJaue+URCUUTHaIfGD/kpbCHmn1Wsl2LXxw6gfyTq
         h3r09ICgmhpsMyOs/aGlX9gzz1QLiJjMg5SS8oEKLUMmUvcjybPLuSSIt8HBq26w9YeZ
         R6MAwJ6p+bMoj/VNJkWushbN5vHfj656tQarkO0uDzJ/skodJCWUX0zuYC1y3DLhe/3Y
         tvDEdsAI6jV97AhjlKM5PKT96SbFZEQZCauOHTXWYAxql548Rck3FxDCvwwB2ifvlQ/Y
         JrRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778148799; x=1778753599;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4DTS0qUVxwfbisiyGTh7vOJzKa4BtZMrsDae9RELKmk=;
        b=J7OVptb/cehyg8Yys8z7U6F5lMydIpnrLYSoKrIViS64h12s28jIo7gxIjNvruhM3E
         PleWAzo8ITmeP3NB7wQ/uKESoZaTH/ur7o8exZJJF7DqXRQW8L3+exoH3APQfFNt3naT
         OAlQ6mDVqNa9nJmztpGWKcrtFAZPJ4XAdtRu4YOsAZhJ8S5rtG3CJGKGkfs7EgWVXzWN
         3FBdTzn0s22aoLdsy9FjLvvcohz23zwR+lXCBj/DkM4RvA84jtfuXiH5JLSgrv+SgrXO
         k1j758r5qPcJs7fU4Ur/Bk8kQH20/vCMr9XJqZMNT54HfW7hSxvOxXLgj8etqMHJYHsq
         UtLA==
X-Forwarded-Encrypted: i=1; AFNElJ8u/uNzne0O8S59DKGFFLU0q7cIItCAVSstOS/jq8TjV2dIt3FhA7CEiyUcFZpigSnrY52YSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw8+bIclUu5pW2/vt77ZiQxcU/9EjkEDgkpc7yxmOy1zFazyXBD
	1BCRjQw2Fgq6AB0chSvEiLQt3A2vN1QccqSNkx5iMfukGNniprZFSyjLPxzjRSelbQ==
X-Gm-Gg: AeBDies9oE9SzZd2SRkCCzMTLMNTE27WWa+5fg5su+IvQu8264FnZwaFqXo86mJdb++
	SN0/JKtl8V6CWDRja2/0U+1lIVmgldhepiQddrAKrHWLG2QzOGL/lcCUNua8lB134Vj5xz9wKMV
	4bp9K63oU7CxpSWPvQRet0RwhOLo6Ok/k/ezdYm8+n90W7FcXSyVxxsqgb3+9Ml0ywvUSJt79cm
	uuSiTllOaT490nubVyz+YF1aV8wSrC0yJuh9wnl9o+mWfqsk8s7tW4YV+La19dQAz2UV6SUfs3T
	kmAG2SN12CTfO3+Q6sYZiejf1s9oeKgEvXQHvu0WV7EDUgwir0e1XpbHQNAw1T95R+pT3ZjaaFM
	CRCmzupO3MgVV3dgrKNn1uN4DBEAbqBHQoVP1WeU9APqPPEHEzkpi9CtUMVU1rL+DOCi89dygZQ
	tzeLOutZ7mnuLchG/YIPTVPOfD+WWWl4cBNoQTlcj50QVCcK3MMY6dMw2cy5GZu38/IUAm+ujjN
	J/Nnw==
X-Received: by 2002:a05:600c:8886:b0:483:6a76:11a6 with SMTP id 5b1f17b1804b1-48e52d0a2cemr1856915e9.5.1778148798935;
        Thu, 07 May 2026 03:13:18 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e530fdc50sm57573975e9.5.2026.05.07.03.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 03:13:18 -0700 (PDT)
Date: Thu, 7 May 2026 10:13:13 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
	mark.rutland@arm.com, qperret@google.com, tabba@google.com,
	vdonnefort@google.com, sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v6 05/25] iommu/arm-smmu-v3: Move IDR parsing to common
 functions
Message-ID: <afxlufh3t3hRe4-G@google.com>
References: <20260501111928.259252-1-smostafa@google.com>
 <20260501111928.259252-6-smostafa@google.com>
 <20260501124716.GD6912@ziepe.ca>
 <afiODW2sVMeOj3Ag@google.com>
 <afoagb/wVBJD1IX+@ziepe.ca>
 <afofSPQbepd_fpom@google.com>
 <afsQTwO3eW+Ks2fe@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afsQTwO3eW+Ks2fe@ziepe.ca>

On Wed, May 06, 2026 at 06:56:31AM -0300, Jason Gunthorpe wrote:
> On Tue, May 05, 2026 at 04:48:08PM +0000, Mostafa Saleh wrote:
> > On Tue, May 05, 2026 at 01:27:45PM -0300, Jason Gunthorpe wrote:
> > > On Mon, May 04, 2026 at 12:16:13PM +0000, Mostafa Saleh wrote:
> > > > On Fri, May 01, 2026 at 09:47:16AM -0300, Jason Gunthorpe wrote:
> > > > > On Fri, May 01, 2026 at 11:19:07AM +0000, Mostafa Saleh wrote:
> > > > > > Move parsing of IDRs to functions so that it can be re-used
> > > > > > +unsigned long smmu_idr5_to_pgsize(u32 reg)
> > > > > > +{
> > > > > > +	unsigned long pgsize_bitmap = 0;
> > > > > > +
> > > > > > +	if (reg & IDR5_GRAN64K)
> > > > > > +		pgsize_bitmap |= SZ_64K | SZ_512M;
> > > > > > +	if (reg & IDR5_GRAN16K)
> > > > > > +		pgsize_bitmap |= SZ_16K | SZ_32M;
> > > > > > +	if (reg & IDR5_GRAN4K)
> > > > > > +		pgsize_bitmap |= SZ_4K | SZ_2M | SZ_1G;
> > > > > > +	return pgsize_bitmap;
> > > > > > +}
> > > > > 
> > > > > I think this should include:
> > > > > 
> > > > > > +	smmu->oas = smmu_idr5_to_oas(reg);
> > > > > > +	if (smmu->oas == 52)
> > > > > >  		smmu->pgsize_bitmap |= 1ULL << 42; /* 4TB */
> > > > > > -		break;
> > > > > 
> > > > > ie it should return the supported page sizes by inspecting all the
> > > > > idrs and don't leave this tricky bit to be open coded..
> > > > 
> > > > This way was easier as each function only returns one thing, otherwise
> > > > we have to pass stuff by address as we can’t pass the smmu struct as it
> > > > is not shared between the drivers.
> > > > But no strong opinion, I can change that.
> > > 
> > > Could you share the struct? With multi-compilation you do get two
> > > structs with the same name and different layout, it is OK?
> > > 
> > > That would give a cleaner setup too because you can just shove all
> > > this into a function and have it setup the same struct which is more a
> > > copy and paste than break up into little functions?
> > 
> > Yes, that’s possible, but I didn't want to contaminate the main struct,
> > also we can’t compile the main one for KVM because of things such as
> > “struct device, struct mutex...”
> > May we can do:
> > - struct arm_smmu_device_common: Basic stuff (ioaddress, features,
> >   oas...)
> > - arm_smmu_device: For the main driver which inherits arm_smmu_device_common
> > - arm_smmu_nested_device for KVM which also inherits arm_smmu_device_common
> 
> Less keen on this, it would need more usages to justify it
>  
> > What do you think?
> 
> I was thinking more like
> 
> #define arm_smmu arm_pkvm_smmu
> 
> Before the pkvm compile of the shared code. 

Oh, so we rely on arm_pkvm_smmu and arm_smmu having the same field
names and types?

I don’t think that’s better for maintainability, I can look into it
if Robin and Will are OK with that.

> 
> How does pkvm compilation work anyhow? Is it all rolled into a unique
> link, or do you have to worry about symbol conflicts with the main
> kernel?

All pkvm symbols are prefixed with __kvm_nvhe_ in the main kernel.

Thanks,
Mostafa

> 
> Jason
