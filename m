Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD874288C02
	for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 11:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752667050; cv=none; b=Hfgp0L+BB2UArhfajWLV/k3B7qE5cbFAMKFFhK94ttw2av2BZQdV/Uns0IddtdSS4EP8bjJAQugbMTl0S5LvKjZghzFSMpn0GFKDWFDPopfm86ETDw40N8bcoFNkk639OoDm/GUj3yt+NlrMwAQw2NTzrsv1RPGS302KXSIm1hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752667050; c=relaxed/simple;
	bh=ahNvfh6VoJDlKv5Gqc6oO3rXFasM7n3WmOyQr7d6Gm0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rb8IKEdJqPwCX8kc++YcwLyv82iadk1zU1mNkrmfKOtGMGkqVOIbXCOMS47Nun2dKhG/pHC5pzo7e4TA+MENlP0Zee135zYsQWdIJWtiBS7VR/MLrh1esUgRDQM6fIv3WVDGJVKMmc1ERFyrl86b+Sm9FioLVLWILrS2B3yf/aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcWRENvC; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcWRENvC"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-455b00339c8so37144185e9.3
        for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 04:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752667047; x=1753271847; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sus59UsnbuGi6q2O4dZ/OSI0C7+7vrhcajwM1ATb9Ko=;
        b=CcWRENvCACCa/jEgpGGJHR7n1H7vyrKZCy5HXse3FqYikYusmnUJsZqZfS8GoGTxKS
         wtB3SU0+qdC8QAYKtJUq2t9s4rAP9rf1j867NiqcWQ8MlNzNdSors6gGV0EkZ52dWxHH
         FsOtGt6vhPvEq6P2A7x6qY/+/wYZy9rg9zhPEdUmsi8hjdNMvoKpo6DXSAo081hItY1l
         nyoQ/kFUOyFdmYNajWuECX6DYX360FYQA3pCejpRtPlY3v3HVP5IKAUnviH9khbTnPN3
         vIA7hO/Zuucgi3itviyUqpOSaGYn2hVMduBiTTwZn/UpgIqkpx6vgDZMvds744QjzR9g
         VFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752667047; x=1753271847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sus59UsnbuGi6q2O4dZ/OSI0C7+7vrhcajwM1ATb9Ko=;
        b=wqWsa+DuotTpD097+kK6LSWXiYDRVJDDReHO6UOUfCjO5eNmCMwhSbqUiR4ozsMIjG
         9KOBx5HknL3pZawEb2GgqZSR/dlpR2kFq6PT8RpgWV6NQwz6OHhGR3qbwm11u9oCwA13
         AgJ2iPuqqy4Wv15fjJiRrbIRRPhLJflBPe/yurQWmgsauhn4aehnUQvZsgeJC/gAUQ0r
         fAyV5+pYsBTDc8+e4/EbauGd7+ACFIL1fwshf6SZkiJKbaSowCE3HUVMKOAR27QF4SW0
         +Nl5DtMk4tbQdhs9LhOBXtkZRrWHmqEplXKLT6jzqh4Kn9vtAtJY0Pfp7c83kgmhUodV
         YSTg==
X-Forwarded-Encrypted: i=1; AJvYcCW9rgtI5xkmX7jNgMtwK8QsNin8HEh8D/W4hf4nXLHByhSpusaZyv+4NmSQzNWknd4UpWjjmw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTKEcQ5DiuECkT3siOSMvSNWCJ4Qy4OpIv0VO1sg3fJUJay8NG
	jlFguV0SOHCmTgf91xlb7jJk5/PdCQirbIbSRrPCDdxsCX4Y2kGfZlPX
X-Gm-Gg: ASbGncuRGzji4Saq+/DxrcXGxXxsCtI0GB3o76zDcZjq2RpADoHEn12j7AUf2NQkcwv
	/BayZiyJtH0m1t91v5lq3lvYCfGTxsJ74BV7+AjE9mw69lPVzT8sMYhBeYRKEh6YiKA4xj4wlWO
	gws2evO9q8msoMxF//tTItslNK0rgs0HvYIDzbVRBj5m6IEws40oG9HmxOOsljtiC/8wk6wmQWV
	00LasDbaYv2A9RM+dUfjvfNei9xJqdSTFw15SkuWm4wsZEME2CAHH5DSvqFBcF7mTxpnKpLVIZi
	sVjsmEtrMxZSW5Omn4yp+g6/3f4PmvHQk17U97uVh9eqzvTUf+UuIFltEsXZ2BBwNmUtPWAzTvt
	PfGN06bJWpqn6GioIAIJfyIvsEsG/4mz4NY3vNRfpJCjhPKZljxv8ou25Fq4C
X-Google-Smtp-Source: AGHT+IEO9Zt2BvzXTefjIV22N0YGVdjcWPFlq7BQGPADENKmKRWYWRGtIPb+nG6tBkrVVWdxVbs8sw==
X-Received: by 2002:a05:600c:5492:b0:456:207e:fd83 with SMTP id 5b1f17b1804b1-4562e330ff3mr22640315e9.4.1752667046936;
        Wed, 16 Jul 2025 04:57:26 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd1a2bsm17916359f8f.14.2025.07.16.04.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 04:57:26 -0700 (PDT)
Date: Wed, 16 Jul 2025 12:57:25 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Kevin
 Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Jann Horn
 <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>, Dave Hansen
 <dave.hansen@intel.com>, Alistair Popple <apopple@nvidia.com>, Uladzislau
 Rezki <urezki@gmail.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, "Tested-by : Yi Lai"
 <yi1.lai@intel.com>, iommu@lists.linux.dev, security@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
Message-ID: <20250716125725.37aa3f38@pumpkin>
In-Reply-To: <20250710155319.GK1613633@noisy.programming.kicks-ass.net>
References: <20250709062800.651521-1-baolu.lu@linux.intel.com>
	<20250710135432.GO1613376@noisy.programming.kicks-ass.net>
	<20250710155319.GK1613633@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 17:53:19 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Jul 10, 2025 at 03:54:32PM +0200, Peter Zijlstra wrote:
> 
> > > @@ -132,8 +136,15 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
> > >  	if (ret)
> > >  		goto out_free_domain;
> > >  	domain->users = 1;
> > > -	list_add(&domain->next, &mm->iommu_mm->sva_domains);
> > >  
> > > +	if (list_empty(&iommu_mm->sva_domains)) {
> > > +		scoped_guard(spinlock_irqsave, &iommu_mms_lock) {
> > > +			if (list_empty(&iommu_sva_mms))
> > > +				static_branch_enable(&iommu_sva_present);
> > > +			list_add(&iommu_mm->mm_list_elm, &iommu_sva_mms);
> > > +		}
> > > +	}
> > > +	list_add(&domain->next, &iommu_mm->sva_domains);
> > >  out:
> > >  	refcount_set(&handle->users, 1);
> > >  	mutex_unlock(&iommu_sva_lock);
> > > @@ -175,6 +186,15 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
> > >  		list_del(&domain->next);
> > >  		iommu_domain_free(domain);
> > >  	}
> > > +
> > > +	if (list_empty(&iommu_mm->sva_domains)) {
> > > +		scoped_guard(spinlock_irqsave, &iommu_mms_lock) {
> > > +			list_del(&iommu_mm->mm_list_elm);
> > > +			if (list_empty(&iommu_sva_mms))
> > > +				static_branch_disable(&iommu_sva_present);
> > > +		}
> > > +	}
> > > +
> > >  	mutex_unlock(&iommu_sva_lock);
> > >  	kfree(handle);
> > >  }  
> > 
> > This seems an odd coding style choice; why the extra unneeded
> > indentation? That is, what's wrong with:
> > 
> > 	if (list_empty()) {
> > 		guard(spinlock_irqsave)(&iommu_mms_lock);
> > 		list_del();
> > 		if (list_empty()
> > 			static_branch_disable();
> > 	}  
> 
> Well, for one, you can't do static_branch_{en,dis}able() from atomic
> context...

Aren't they also somewhat expensive - so you really want to use them
for configuration options which pretty much don't change.

	David

> 
> Was this ever tested?
> 

