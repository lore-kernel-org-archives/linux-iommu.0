Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A11127E0C
	for <iommu@lists.linux.dev>; Fri, 12 Apr 2024 14:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712932054; cv=none; b=bY1wJI0x3TpWZhDYMOneVqlqzQE1/7i69FSPwqKtcyaQGFa5Ma5Ym0YaN74Ek4966HQ1x3T1iTBPNjdbA7iJWcVtnX4L35shsQR6cA0NPPlcb3YIMjjnduFY3Ogs0DkHo/hoX/YEgM6VN+4x8Ybxm3zSr7TBiT+jq8gJ/8zvCVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712932054; c=relaxed/simple;
	bh=7ZpOjyhJVYHo6veueLDSfC6MEFzr8Ojbs3xFBxi2+W8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GOOe0RgUbh3seyRBvpNa12OiblPQuXaQwALGmDpqn1ye+YTSkGei6PRhRsDVXgCUNuWKgD+dbRp7It+pRlQ08q00Un4SsIZJ8Ic2fJz+D/7DcUYUs6Ng3dJ5EmS2Mz6jPN7biqVVCjPDrOFFaxDakrCy6mL/chHxwZXngkonTho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pTkM1X14; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pTkM1X14"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1e2a5cb5455so11519245ad.2
        for <iommu@lists.linux.dev>; Fri, 12 Apr 2024 07:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712932052; x=1713536852; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CTokiC2mOzeQb1t9UZXBIQTwfHhJ1xAuH+06DQhJnus=;
        b=pTkM1X14tD/akOXUKV2qxCI927+oBSqXx4e0JpruJXIWQbcBSFejG0nMJa09+WKjWR
         dLLLSUoxNh7DdgjopsmZR6CbqXtuYaESNVktiwOiEFVJE26jrtLJbP7iHiP7hEGX/J9V
         ztkH7kOGYzeDRRfqBzinJtm1cli1897XEdAqlHylgcxdSASYTOHKtolFxrHXM3jLlinK
         cmMkpnu+xO9DvHmENHkXCsIXXkI2uXrgHnBkaoxwWQi6GvHBqBu4o8bqW23xX/zZ0Nru
         MEYNZZeX3USo5bv+nX/8Btl4w1sJhFdYCQj3cZ3krsJKT2lSjEzVj9iwHDgsimtLcAkA
         4jog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712932052; x=1713536852;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CTokiC2mOzeQb1t9UZXBIQTwfHhJ1xAuH+06DQhJnus=;
        b=n2GtVRPaMz8XVhJlrpPaXuW9kle91FcY09Ve3xcXu24Lpli8mCCokG8wzKZFuguXb2
         vFGOB1E/wzkIerCxFzUg6z2+tA4mkukrsYDHBH2oTxyFeuR/0ebFzVy5IlZrJRLml+Cj
         W24Vw6U/N4eJwEM9fcIOz3E84hsiDhvqwax0N/DB+7DihoUPuLJXyd4DP+GuasLaVMlP
         naN+adgev5L+Zq+kt7A0FantdbWIkPEE4CW2092HISL460dZKoiTF5+bNgxBo0H7wR+I
         wM6ub5Q/nnqgqh9BcrIjRVTKVEir/IXMUM/gjcrKVkWM72KkA6I+ON9GVM5a1Nl8q535
         MrAw==
X-Forwarded-Encrypted: i=1; AJvYcCVCIraXTqg9vySkIJDB0RCsmlNLyxM26F/LZRejSmPlaoFcVMXQtcW4UaNKqH+jpxv6xN17dmubz4epZK2iRsztWGawmoc=
X-Gm-Message-State: AOJu0Yw1EhwJdUkDU/ep84XfYguy8X7LyhvYWyYF3P0PDFiPuYIKxhl1
	1EwgGAVl9Cm38/ZACLIP64lxLPKZ2ZUzyPW05/gg5mIys/btILafupO6m8f3T8guW3mH06L2dk/
	iIw==
X-Google-Smtp-Source: AGHT+IGLwF+HfzZtGn8zwa1qm1dvlv2UkAX6QqEas4f4AXsrP0etNn5dV5dMejYckrKUvPHWx3YS/a/UIOw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:db08:b0:1e5:10e5:344 with SMTP id
 m8-20020a170902db0800b001e510e50344mr8380plx.3.1712932051773; Fri, 12 Apr
 2024 07:27:31 -0700 (PDT)
Date: Fri, 12 Apr 2024 07:27:30 -0700
In-Reply-To: <BN9PR11MB527609928EA2290709CDB3E78C042@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240405223110.1609888-1-jacob.jun.pan@linux.intel.com>
 <20240405223110.1609888-6-jacob.jun.pan@linux.intel.com> <BN9PR11MB527609928EA2290709CDB3E78C042@BN9PR11MB5276.namprd11.prod.outlook.com>
Message-ID: <ZhlEh7-NoknHcNX7@google.com>
Subject: Re: [PATCH v2 05/13] x86/irq: Reserve a per CPU IDT vector for posted MSIs
From: Sean Christopherson <seanjc@google.com>
To: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, 
	X86 Kernel <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Thomas Gleixner <tglx@linutronix.de>, 
	Lu Baolu <baolu.lu@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	Dave Hansen <dave.hansen@intel.com>, Joerg Roedel <joro@8bytes.org>, Peter Anvin <hpa@zytor.com>, 
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, Paul E Luse <paul.e.luse@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Jens Axboe <axboe@kernel.dk>, 
	Ashok Raj <ashok.raj@intel.com>, "maz@kernel.org" <maz@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, "jim.harris@samsung.com" <jim.harris@samsung.com>, 
	"a.manzanares@samsung.com" <a.manzanares@samsung.com>, Bjorn Helgaas <helgaas@kernel.org>, 
	Guang Zeng <guang.zeng@intel.com>, 
	"robert.hoo.linux@gmail.com" <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 12, 2024, Kevin Tian wrote:
> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Saturday, April 6, 2024 6:31 AM
> > 
> > +/*
> > + * Posted interrupt notification vector for all device MSIs delivered to
> > + * the host kernel.
> > + */
> > +#define POSTED_MSI_NOTIFICATION_VECTOR	0xeb
> >  #define NR_VECTORS			 256
> > 
> 
> Every interrupt is kind of a notification.

FWIW, I find value in having "notification" in the name to differentiate between
the IRQ that is notifying the CPU that there's a posted IRQ to be processed, and
the posted IRQ itself.
