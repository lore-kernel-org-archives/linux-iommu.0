Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2952F6188
	for <iommu@lists.linux.dev>; Tue, 11 Aug 2026 00:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786409292; cv=none; b=OiXQeDpy/MUcmB8y0fHkNyL24wxoEpAHg7r5r2+4SW3MwZB9kNyY+2TJlKc86Nq+A3wobKXX83zgh4NJPtRTXE0dyLrp5OWd+yHLZNoUM+PVhobVK3ckV0cbmqsSNGsf7kevrMKjhOICchnIH3UAaFgTBeU6i8JqAbEimbI7g4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786409292; c=relaxed/simple;
	bh=SW0ZwvYoKhM6FW3ut7EHho8mS7J5qQPyYhcgYTaD0w4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QjK9JVD5l2torxKpVlF4AH+TYvxamxUmPTaLGRkJPhXi+qRb0440GswHZ45EEREJCflzGU23YLr8+stgWz/3WaslY22+olfF+DwsaYAem5e42YRamrWna8v2CqlJU8Wd+SDpAUuna77KlPe1UJ/bTWMAWPJCBy3UBUAJrZeb94o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NRsuR89c; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NRsuR89c"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb733fc5024so497622a12.2
        for <iommu@lists.linux.dev>; Mon, 10 Aug 2026 17:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786409290; x=1787014090; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=57qFiioTiYY05WIjQzEmLqwAbaTdR8MUfRFj4mAMGpo=;
        b=NRsuR89cc9ITuRQt504cj9p/OiXEKhVExfvQGGVFi9gO9v0Xh04ZZ9RPMxgyBDdPGk
         r6tZlankuL8WMh7CZZwAK7ZEeOE2or/Ij0I0IrHZPlF0wPLHoKNLDRucNV2G4DN5/OZ0
         +gQuMYNGLZQFuxTkcNJvnJDcLAzH/6ONS//32lp+W6I7SdBXJ29nLHB1wiQ19U9rnenw
         fWIohHL6acoBdORca931wzQttOtK1GPqY6w07VHSnk4Lng8Bj/WKdA7lwLjZ4xtcdhOO
         5Kza1RP5OCaaDR3pPhVjb+bJ2tOELNfzQjGnsHh6ThV/pN5BpZcAqnm2678grpQNHhP3
         76JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786409290; x=1787014090;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=57qFiioTiYY05WIjQzEmLqwAbaTdR8MUfRFj4mAMGpo=;
        b=Rq6C0OPrx4iMrNmnPhqHZzV3vTyRwiGdMQas1+CYfmLPJ4ybxQIwUql+WhAih1OmNR
         eNrBaDiAocnO37JEZfo0VrNdKi5A4jxXgDZCT77I8p30UMDWSt+iWbIPCYGTZM/42tMs
         ujdUevcpoIz5Sslmi+4dpB2QI+OhulX2Nk/zdgMVfscT0eiaLy2LxOeg6qo950NV8Yfy
         Xs8lkl7vfWV8wEGzAJ1I4L0r05EvgtdMNk8bV14bRvvo9YKqkIOBJX0O4WZ5Odgyxdtl
         5bg95Tgi/WBP6gSqzcbUhCS0wNLSot81wlaXvaKkhja+q87sBkcM5MLb0hbkuJLk+NGc
         31sA==
X-Forwarded-Encrypted: i=1; AHgh+Rq7ukQXIoxpXT03tx7/JLJ3g5wcjU9weAhhr1bNKnxqSVZOOCueK85QS0ykb/Vd417IAKI8DQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwgWK6Tj5YcoXHHtiOXDN011hzxt5sBznRYLO1qCZAWwWyzRlcb
	LW2E3OLVDXI/AH6PlORi2BBHlaFsxuYrTiCZp1CiTSQSRh9IK2GnZMTOEs4mlqX9pYQXZDepG++
	8jtYMdA==
X-Received: from pgbgf7.prod.google.com ([2002:a05:6a02:2cc7:b0:cbe:9522:2c9d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4519:b0:847:968d:b101
 with SMTP id d2e1a72fcca58-84f2e03916amr55995346b3a.21.1786409290016; Mon, 10
 Aug 2026 17:48:10 -0700 (PDT)
Date: Mon, 10 Aug 2026 17:48:09 -0700
In-Reply-To: <20260713105033.15405-1-sarunkod@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260713105033.15405-1-sarunkod@amd.com>
Message-ID: <anpxSbwbYzyJ1SQQ@google.com>
Subject: Re: [RFC PATCH v3 0/6] Add support for AMD IOMMU GAPPI
From: Sean Christopherson <seanjc@google.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Eric Biggers <ebiggers@kernel.org>, Feng Tang <feng.tang@linux.alibaba.com>, 
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Li RongQing <lirongqing@baidu.com>, Marco Elver <elver@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Thomas Gleixner <tglx@kernel.org>, 
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 13, 2026, Sairaj Kodilkar wrote:
> On newer generations of AMD processors, IOMMU AVIC/x2AVIC guest-mode interrupt
> remapping can use Guest APIC Physical Processor Interrupt (GAPPI) as an
> alternative host-notification path when device interrupts target a vCPU that
> is not running (IRTE[IsRun] = 0).

Why is this still an RFC?  I mean that in a good way.  I haven't looked at this
super duper closely, but the patches all look to be in generally good shape.
I.e. this seems well beyond RFC, unless there's a hard blocker or something,
e.g. known bugs?

Another bigger picture comment: I'm very tempted to say this has a hard dependency
on KVM's irq_test[*] adding support for AMD.  I know it's being worked on, but I
can't remember who is doing the work, or when it's expected...

[*] https://lore.kernel.org/all/20260626213534.3866178-1-seanjc@google.com
