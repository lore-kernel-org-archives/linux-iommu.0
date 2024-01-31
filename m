Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015A017570
	for <iommu@lists.linux.dev>; Wed, 31 Jan 2024 01:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706665688; cv=none; b=XVCzNn2IQ6gnvMUxfq1CtWiuqQkDvGLVKrblAMEzDcseyRnE+0D1+tXLR9MOSMRtUpXe3X1yvkRe+BgjLLDkGrfi4MGbGx+CGdenlo50BPyYDb7f3HG+HxI3aYK6PkMZTmWVH2l2sCoF6B5NXC3thzl1kOxR62mK8lNBPr8EN44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706665688; c=relaxed/simple;
	bh=z18/1NG1zLW5yoDGt3zYqzrbxZEW6XZZsTCTId9IDzI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u2yP2gVpVhlC8M3P7Bmd1y6ge8rfHC0PIm9nBv+tuYo/SHgNc6bfVpUnt5//AxygD9QQaS+fmpQ7G5c3rR13pgr9zirvZiR98r/MBjw1yBiU5BEOm27+kSbEQlJAULDCPxEfq2Rknu29ZxiZAKk92srVxPXX+pqhzuLAGuPS1gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P2Tof5vl; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P2Tof5vl"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-295aa989fd2so1330210a91.3
        for <iommu@lists.linux.dev>; Tue, 30 Jan 2024 17:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706665686; x=1707270486; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JdG1KVU/njo7PApRXford/HnaGUTjmthKcJoPmpTjfU=;
        b=P2Tof5vlqJTD1uwEuW1YWL3ynFYYzHM+c+g+BrphrQgLvTdvhLYlduNZ3UzLDvxHny
         V6s0KteAbvENF2IfPCY1hGIvSBtlWIvAHyZmMnXhtVotnF35I9nr6Ef5AzsEDtRCbRAH
         ofesFYXgOhOL/XJ6KBuX8urXN4FOQ7l3TvKu07284hSpSg3ggRV0zHaXuQ2wzQrgznaA
         G6Ylf7DlSBjEjUDSSAt/g+1kOd3rnorSnKagNqGNbv8VNm4JLWdhnPa3bkHd7z3xenP4
         eu7ojtRwO6BmTEgr/kZT3RAw6NlXamWS4BDbC2zpgisn7B6SAUs0oQQzMrmwfbohFmWX
         bW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706665686; x=1707270486;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JdG1KVU/njo7PApRXford/HnaGUTjmthKcJoPmpTjfU=;
        b=Y8J8MzAZ18TQ9WuZs+l07cYzSHwR2DYUTeD/qIhWKlyI4vnwS/3jPUr9f+BVCLGpqX
         bEBML6rrjcDuZqotWH3yjcWMs/mZRdklJhyoKNNPEUol3c+IHm7UN1cJQRIBByZHTXOv
         +1mexAwrU55D//ADiTIsPmK8WNRt0XKeDiHpN9LPaysVFYZSe5EuVsW1+ZR+iQFGy2+j
         OtOfEkj575jPKPuR1nZp/v2dXHIlsxZDmAuF6IIVTFoZQ+kne1FgoKddAPZMPO186fP/
         /havD2lx6JooxKyfLuMkK8W/Nea4LqnIJl+hLLoRN3FT/L+8A/xmrvdLs1qmkR5LCRyS
         We6Q==
X-Gm-Message-State: AOJu0YxuTP90fv2XIBmTJCTE1mtRZjxJn2YTgNxkPjTIdDKd9Kr5H0mK
	lJ4VxQc5lX1L8O+DZsYTer28E3SATOoqEer75LseLyKv4q8H2eRW/vjclzZ2yvH8u+efSxNWJl9
	Z0w==
X-Google-Smtp-Source: AGHT+IHkPAPzDQDil9cIn2c+oGBBDcXjd/kr8cTjB0uidyn4CQbS7fkF9Zjbea81BRd2hGwSuMMpPlMakCU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:e550:b0:290:fd51:d7be with SMTP id
 ei16-20020a17090ae55000b00290fd51d7bemr1533pjb.5.1706665686046; Tue, 30 Jan
 2024 17:48:06 -0800 (PST)
Date: Tue, 30 Jan 2024 17:48:04 -0800
In-Reply-To: <20240126234237.547278-4-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240126234237.547278-1-jacob.jun.pan@linux.intel.com> <20240126234237.547278-4-jacob.jun.pan@linux.intel.com>
Message-ID: <Zbmm1DZPmbFm8gan@google.com>
Subject: Re: [PATCH 03/15] x86/irq: Use bitfields exclusively in posted
 interrupt descriptor
From: Sean Christopherson <seanjc@google.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, X86 Kernel <x86@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, iommu@lists.linux.dev, 
	Thomas Gleixner <tglx@linutronix.de>, Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Joerg Roedel <joro@8bytes.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, 
	Paul Luse <paul.e.luse@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
	Jens Axboe <axboe@kernel.dk>, Raj Ashok <ashok.raj@intel.com>, Kevin Tian <kevin.tian@intel.com>, 
	maz@kernel.org, Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jan 26, 2024, Jacob Pan wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Mixture of bitfields and types is weird and really not intuitive, remove
> types and use bitfields exclusively.

I agree it's weird, and maybe not immediately intuitive, but that doesn't mean
there's no a good reason for the code being the way it is, i.e. "it's weird" isn't
sufficient justification for touching this type of code.

Bitfields almost always generate inferior code when accessing a subset of the
overall thing.  And even worse, there are subtle side effects that I really don't
want to find out whether or not they are benign.

E.g. before this change, setting the notification vector is:

	movb   $0xf2,0x62(%rsp)

whereas after this change it becomes:

	mov    %eax,%edx
   	and    $0xff00fffd,%edx
	or     $0xf20000,%edx
   	mov    %edx,0x60(%rsp)

Writing extra bytes _shouln't_ be a problem, as KVM needs to atomically write
the entire control chunk no matter what, but changing this without very good cause
scares me.

If we really want to clean things up, my very strong vote is to remove the
bitfields entirely.  SN is the only bit that's accessed without going through an
accessor, and those should be easy enough to fixup one by one (and we can add
more non-atomic accessors/mutators if it makes sense to do so).

E.g. end up with

/* Posted-Interrupt Descriptor */
struct pi_desc {
	u32 pir[8];     /* Posted interrupt requested */
	union {
		struct {
			u16	notification_bits;
			u8	nv;
			u8	rsvd_2;
			u32	ndst;
		};
		u64 control;
	};
	u32 rsvd[6];
} __aligned(64);
