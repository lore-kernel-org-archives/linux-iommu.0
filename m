Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F50C7082F
	for <iommu@lists.linux.dev>; Fri, 22 Nov 2024 03:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732246476; cv=none; b=mqvDHDrG9pOUo+D7J3pLNYj7uvRJW8sSnkpJ/3/PkcvHMuMpPnZrubocfLZLZY4HrFqFs2EV6C1mtPWTG7+70fc7ciAErHDZKNaHiGpxiLHa1j4CzaubwiWiJZRodyrNefJVUt7SdWUyKG/jIw9P3LyRpJZON1WT+0zBEFWmnRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732246476; c=relaxed/simple;
	bh=9kkSHX5C/Rzcba5jDJqEPRSjF0ZyIB/tw8lBGgd3K04=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c/2hsnLh3G+w+OWo3wAcJPLJ/YKP4YqFckfVVDRSnLOGpqVFyuVuXMYguAtzAS4kj0VSinqmkIIIGJT2uKET4jYiGCO6L3EbFhHdodMLLq71bLfyxRnOtvUCReAYwrUXILvcopw/2NxAynekoZiB63cGKk1I4mVJf9uMzxfOe7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YTYpNNF3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YTYpNNF3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732246473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5owPybl2A6mPLtXeb0GF8SzCVpIuIgw+HHvE5+2/5T0=;
	b=YTYpNNF3MOC/uOe2jRfqt9zZxh6syWclOjnJ97elNoncZ17bpEeYATqGOM4UQiQuxgD6h/
	zu4RIUnUOYXNTE8pkKt2HwCFdBHiB/Iq4q/YFfqZZ8opzzITo4a0Kk+SsmoJqrzJlw+sV2
	WirDz+TjnFHextKUfTlTvOiV4gBXV1Y=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-GzuYXjezOG6QMt3J1xEz6A-1; Thu, 21 Nov 2024 22:34:29 -0500
X-MC-Unique: GzuYXjezOG6QMt3J1xEz6A-1
X-Mimecast-MFC-AGG-ID: GzuYXjezOG6QMt3J1xEz6A
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b15499a04eso314870885a.1
        for <iommu@lists.linux.dev>; Thu, 21 Nov 2024 19:34:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732246469; x=1732851269;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5owPybl2A6mPLtXeb0GF8SzCVpIuIgw+HHvE5+2/5T0=;
        b=i2tS/tl6s/dmTY+cWnfgG4hPnXrH+kiGCgLRiBgdHmCx+bT7k6LQUuxjhHbMi+K4yV
         D1a3vJtvK+4gWvy2dBD6F1rZJXQ1i0d2wVesQfgTy3bP8bSKiHb5c7/mcllxxq/b56My
         kXxneUHP570PvPeQ8PgxqdOIHDt278Kiw+dGUeY6dG7O/gF4/OvIkrFZbnPe2xrFLAG6
         1mgBVz6EQB2xgsliMP/mZCuwzeM6Wpv0LsIm7hVa6OPP2b9m7Zxv0jnxOR0mbyARwSP6
         vd7lnvfAQBVpocDjYSeWEhUleF8Ef7xDAPC9XMeeHknoCedQH3bZFX+3NJ6+SOhjc07O
         R7lg==
X-Forwarded-Encrypted: i=1; AJvYcCW4JuQubnRYjvZohf2okzbFMS6atcVD54zXbEymyNHyCYzIR3OPK8UIkfKZI6KSHrY0s8diqg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzObIIg70ESks/Nyg/J0S37wc8VQGO7IkwAIU2q6RYFsTWukkC6
	a5Ah8+688TeHPkCgXpc4NRlvJ8NuQqpoqxq52tvU7J3p7nevTMlpK37pv02koKWV7e+jrBewmHZ
	wbZmJE2eaxc7W6dnHQ0ypHNk3q4aCAtIIzKMn6oJo/CuzpZdo4FCR
X-Gm-Gg: ASbGncu7DP1zgSAK6sEH+r540iJsfT9zkybUzBnfOX0ILCMHARy/aJSNcUgc+iI2ESC
	n2H7/Mvh6XlYkZGQz+b2v9nT6n4co+iMolZ+/SLG2GgL6dualHigCgKyYPZp45wBUVYQ40tiCCD
	HWN4puuOfd6iMtTCraqxkj9PwFr+iMB5hb+phjmAQaIwl1EH6ctJjGjZ0JcQ0yLXiuMnvhWRI6D
	59xEMjTYsKVNRlvt1Iavml6rCIZOcyG3bJxC1uyHav76EUZTA==
X-Received: by 2002:a05:620a:601c:b0:7b1:21c9:d1ad with SMTP id af79cd13be357-7b50c1bbea5mr922168285a.23.1732246469283;
        Thu, 21 Nov 2024 19:34:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF40kkpOkNoCUj7UXHDVNMT6f685l0ht7e59S+qcPkVWqYBRtbkkFc+AKlw7dYgnr5xBZD8Ig==
X-Received: by 2002:a05:620a:601c:b0:7b1:21c9:d1ad with SMTP id af79cd13be357-7b50c1bbea5mr922166285a.23.1732246468905;
        Thu, 21 Nov 2024 19:34:28 -0800 (PST)
Received: from starship ([2607:fea8:fc01:8d8d:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451a837bbsm4922046d6.23.2024.11.21.19.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 19:34:28 -0800 (PST)
Message-ID: <8d7e0d0391df4efc7cb28557297eb2ec9904f1e5.camel@redhat.com>
Subject: Re: [PATCH v3 0/4] Allow AVIC's IPI virtualization to be optional
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>, 
 linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, Ingo Molnar
 <mingo@redhat.com>,  "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner
 <tglx@linutronix.de>, Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>,  Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev, Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 21 Nov 2024 22:34:27 -0500
In-Reply-To: <Zxf2ZK7HS7jL7TQk@google.com>
References: <20231002115723.175344-1-mlevitsk@redhat.com>
	 <ZRsYNnYEEaY1gMo5@google.com>
	 <1d6044e0d71cd95c477e319d7e47819eee61a8fc.camel@redhat.com>
	 <Zxb4D_JCC-L7OQDT@google.com> <Zxf2ZK7HS7jL7TQk@google.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qgl8ZBf8Q-awUC7E889oPL8L_GkhoJmb4GONqKe0lGc_1732246469
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2024-10-22 at 12:00 -0700, Sean Christopherson wrote:
> On Mon, Oct 21, 2024, Sean Christopherson wrote:
> > On Wed, Oct 04, 2023, Maxim Levitsky wrote:
> > > About the added 'vcpu->loaded' variable, I added it also because it is
> > > something that is long overdue to be added, I remember that in IPIv code
> > > there was also a need for this, and probalby more places in KVM can be
> > > refactored to take advantage of it, instead of various hacks.
> > 
> > I don't view using the information from the Physical ID table as a hack.  It very
> > explicitly uses the ir_list_lock to ensure that the pCPU that's programmed into
> > the IRTE is the pCPU on which the vCPU is loaded, and provides rather strict
> > ordering between task migration and device assignment.  It's not a super hot path,
> > so I don't think lockless programming is justified.

If you strongly prefer this I won't argue. KVM does read back its SPTE entries,
which is also something I can't say that I like that much.

> > 
> > I also think we should keep IsRunning=1 when the vCPU is unloaded.  That approach
> > won't run afoul of your concern with signaling the wrong pCPU, because KVM can
> > still keep the ID up-to-date, e.g. if the task is migrated when a pCPU is being
> > offlined.
> > 
> > The motiviation for keeping IsRunning=1 is to avoid unnecessary VM-Exits and GA
> > log IRQs.  E.g. if a vCPU exits to userspace, there's zero reason to force IPI
> > senders to exit, because KVM can't/won't notify userspace, and the pending virtual
> > interrupt will be processed on the next VMRUN.
> 
> My only hesitation to keeping IsRunning=1 is that there could, in theory, be a
> noisy neighbor problem.  E.g. if there is meaningful overhead when the CPU responds
> to the doorbell. 

I once measured this by bombarding a regular CPU, which is not running any guests,
with AVIC doorbells. It was like 60% reduction of its performance if I remember correctly.

So physical id table entries of a VM can't point to a CPU which doesn't run the VM's vCPU thread, because
only in this case this doesn't pose a DOS risk.

Same with IOMMU (malicious guest can in theory make an assigned device generate an interrupt
storm, and then this storm can get redirected to a doorbell of a CPU which doesn't belong to a VM).


Best regards,
	Maxim Levitsky



>  Hrm, and if another vCPU is scheduled in on the same pCPU, that
> vCPU could end up processing a virtual interrupt in response to a doorbell intended
> for a different vCPU.
> 
> The counter-argument to both concerns is that APICv Posted Interrupts have had a
> _worse_ version of that behavior for years, and no one has complained.  KVM sets
> PID.SN only when a vCPU is _preempted_, and so devices (and now virtual IPIs) will
> send notification IRQs to pCPUs that aren't actively running the vCPU, or are
> running a different vCPU.
> 
> The counter-counter-argument is that (a) IPI virtualization is a recent addition,
> and device posted interrupts are unlikely to be used in a CPU oversubscribed setup,
> and (b) Posted Interrupts are effectively rate-limited to a single "spurious"
> notification per vCPU, as notification IRQs are sent if and only if PID.ON=0.
> 
> That said, while I'm somewhat less confident that keeping IsRunning=1 is desirable
> for all use cases than I was yesterday, I still think we should avoid tightly
> coupling it to whether or not the vCPU is loaded, because there are undoubtedly
> setups where it _is_ desirable, e.g. if vCPUs are pinned 1:1 to pCPUs.
> 


