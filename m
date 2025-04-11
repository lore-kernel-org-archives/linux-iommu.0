Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB5728541E
	for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 21:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744407173; cv=none; b=Cp6lIn5+PiFKyG19lsR9asUroU1Gf0gZrt1jTusDbzHjv03awQC/A+0A30edf2hNjtyGZtK+A74ua7R/RoMkaJa7toI+Jk0CyzyoUhZYdLCcSOxZ0esdfKuOIIqFItNe2FrB2q5o/kXqL5OYfGzzgKvD5sWB7p4K4UppwfKLBEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744407173; c=relaxed/simple;
	bh=/3tH8CvukO+vlevVOFlntDYEjBrYdIAzSgCsbqTQLxI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oVjlPfbX/GNc+CiyQ6sXXkSRpyDqTuFxFoDO8KuaV27tILKn/7mRZN+eTzNBH8BU+2y3x8hMNE6/bO5qRyd0KK/p0TlLdDGsPMJzS07h0llEOTZwnafWuhFwI+Bmit06o54nZxNwj6uWQdPuwuFvcx3exh/3jQYIikjt2hIwMlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t3EhT5gM; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t3EhT5gM"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2241e7e3addso22103645ad.1
        for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 14:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744407171; x=1745011971; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K1L8eJTBYOe3IqPq2LCTPLnMwB1yCh94JwNwUb/2VUY=;
        b=t3EhT5gMuj8flHGv9HDh82Vo0h5Hu30KM7iboscIo7NeyT84igyOv568tdGzuEfBuE
         bd1vzsVX9cFLAttWHH9GlUKG/mltg3u12EEmatxmb00iVzk174bLgyzlly4G5bSn69m+
         YPLji6lRwOaCGvRpk/OM0fQrIhzWPTrIsAHBccf1rmcGs0Z+dsloKPpKxY7RsHjZ+AME
         Ieh9IpZK6NwxtWelVIJCa0iM1Hvx3ncE0+xDjdOZzFEOJQrahaWoAgNPZ8jnpfAcZbCe
         FpR5qwI6El5ivUbZB2rPb4WH3jbSBdkNv9doVnMSWDXMNNv4UDaBvbyE8Knjtb5alSyh
         0Bbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744407171; x=1745011971;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K1L8eJTBYOe3IqPq2LCTPLnMwB1yCh94JwNwUb/2VUY=;
        b=nUQ/XhXVLGglzuQLow4PeVUH1DUOCLFhvsPjkc8kzwkwxWdZSOUwAmfqhO88asuxH/
         fPAKt/NjpWN3pcZx8/9FgMgjOXCSdOli+4MqP512gZ1k+mY+tMsiPp1rCsjEzKtmGdF2
         nW+J7U/7Wjda8KqlDlqp2sr9P8EEXYeB8hfFhFuo26Mgm3NE7xyX4e5dwW55Wxcdkj97
         sVhUa133tlqzXqDh1iIOyluF0Ff6aaTRTKCCSTOsoRThwPXCkrVrgpm/I1hCA4GPQF+u
         NOALnPXcLr3HHXCBW6gyhizaR3nKW7CrmbP8tVFA0rAMie0/n558rzSlLxprsBHtTZva
         bcBg==
X-Forwarded-Encrypted: i=1; AJvYcCXjt7OSJF753wtu1QE+S6DSdfpiDTQBGR+OlHg38FCOWos1D9ysnzSiSQkRQTvPuSWTmxIL2A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwneVeg1s4UEx+JirYNd2H8+gMpbUwKdq/crMDBOVaeBFcvucu5
	2l28Arm/1m096+T0NjpDRU00zur4wPkLpMAu2fgeXxmjHzi6rCRTdoagwZA843APv5kvQijUSV4
	XnA==
X-Google-Smtp-Source: AGHT+IGWRveftZO1wji7CvlkOdr/kE0uz4l6esz3nDwfvBuY+d4Ew0jp3EjBMobySbyO9+duVZkiSgztRF8=
X-Received: from pfvf19.prod.google.com ([2002:a05:6a00:1ad3:b0:732:51fc:618f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cccd:b0:224:910:23f6
 with SMTP id d9443c01a7336-22bea4fcc8dmr67226125ad.45.1744407171250; Fri, 11
 Apr 2025 14:32:51 -0700 (PDT)
Date: Fri, 11 Apr 2025 14:32:49 -0700
In-Reply-To: <b06b187a-54e2-460e-8fc5-b440184b6f7a@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250410204149.2576104-1-ross.philipson@oracle.com>
 <20250410204149.2576104-2-ross.philipson@oracle.com> <f816c36c-cb7e-4143-b58c-f96a40699f7a@oracle.com>
 <b06b187a-54e2-460e-8fc5-b440184b6f7a@oracle.com>
Message-ID: <Z_mKgfZznBZgS-Pb@google.com>
Subject: Re: [PATCH v13 01/19] Documentation/x86: Secure Launch kernel documentation
From: Sean Christopherson <seanjc@google.com>
To: ross.philipson@oracle.com
Cc: ALOK TIWARI <alok.a.tiwari@oracle.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, iommu@lists.linux.dev, 
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org, 
	mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, 
	jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net, 
	ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com, 
	trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 11, 2025, ross.philipson@oracle.com wrote:
> On 4/10/25 10:50 PM, ALOK TIWARI wrote:
> > 
> > 
> > On 11-04-2025 02:11, Ross Philipson wrote:
> > > +
> > > + - Entry from the dynamic launch jumps to the SL stub.
> > > + - SL stub fixes up the world on the BSP.
> > > + - For TXT, SL stub wakes the APs, fixes up their worlds.
> > > + - For TXT, APs are left halted using MONITOR/MWAIT intructions.
> > 
> > typo intructions -> instruction
> 
> Thanks for the review. They are two separate instructions so is this really
> incorrect?

From the peanut gallery, I'd just drop the "instruction(s)" qualifier, i.e.

	- For TXT, APs are left halted using MONITOR/MWAIT.

Pedantically, it's the combination of MONTIOR+MWAIT that puts the CPU into a
sleep state, not the individual instructions.

And while I'm picking nits, the documentation is also a bit misleading as the CPU
isn't halted per se.  I'd go with something like:

	- For TXT, APs are left in an optimized (MONITOR/MWAIT) wait state.
