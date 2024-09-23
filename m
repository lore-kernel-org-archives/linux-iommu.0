Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E85919F104
	for <iommu@lists.linux.dev>; Mon, 23 Sep 2024 16:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727108639; cv=none; b=JMwaBI9qvlxmHh4DHsKjdexDAL9iyD+94CMU+PVQnWC7RPT08GoSa+UJ22AKLRbKfDWmnLrsSATYWTs5eDKUXxkdtPXHpH/Xp8fMdMXYuBpHIMBH3Vt8ZcqhPOGrLAq0DeVNrUv9Y5obZ0mL2SzapmyA483rBG0viAqMMGr6Gr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727108639; c=relaxed/simple;
	bh=pH27xsWg8G6SeVBeYa7PVys3VaHWxE1d41xvTvXeHKo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tsffELrSUBaBVbhBsrETNgGlbIKHqhsb/YQPsP8XZ0uMxDn9tjLnKitCU755R2sR+TxcXyAj1MwPKC0OkxzFN1tOXehyPj/8ckz72cWd0BMzJ0+gEmRqM7KsosAcOcc9RZY/ccj11IbanvzAcQAISrniK5H0VUpOSMLKaI2c6mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JMNRRk6A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMNRRk6A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727108636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xhibzVfiT6YYguU9Zn+WLSPcbkXuFS0jVV+8r0H5PLk=;
	b=JMNRRk6AZv0VhKKLeyJAxwRLHOXJaifbRvqy8TYHWIIwMxlCbfwKMQOkF9AqWyOhHyMElS
	liK44mZn7MHl1idvU9ashNSi5/QeJbfx6TI63IO4eDzSEl+NdqR8fud2BY6IKcdu30P51b
	FM6zzAn9y6lv5vJeR9FhAu2Q6Wppong=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-_62TSHx_O7OWkkoGGXJBcA-1; Mon, 23 Sep 2024 12:23:53 -0400
X-MC-Unique: _62TSHx_O7OWkkoGGXJBcA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7a9b41d95efso886891485a.2
        for <iommu@lists.linux.dev>; Mon, 23 Sep 2024 09:23:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727108632; x=1727713432;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xhibzVfiT6YYguU9Zn+WLSPcbkXuFS0jVV+8r0H5PLk=;
        b=NbPudAnsKI/Czc/3yll5Xab7qIRlJxySecC9IRsA4zyzxIsrjl8imNePDv+/+BW3gf
         UtUsxizjNCCaoHBUfkXJ/L/JdxmKvR8MVMR5wyDeJTHgN7wqFw+vYzHBrSBEJvvPon0q
         eVY5fB/IgsPxsQgse4PtapElvZrcJmouIW7hpGdQRgmNA08iDOCJGmvk0xGgMoeRF46T
         8vwfpDVVxXkbhUZOuZDKCv23LK6nAmHL9iq/XcgFTue9fbjX+haaBzjQtYWdq20maOH7
         s+2koC+hWqzdT0xHC0TUZvwEX8uLkPUStAKXdeVV70ipOcL4pHJfeeVqLTZMDp47wfNZ
         N65Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqCZ2ueiJD3xo1IxsRtY1JM1FD4ZWvqBfchw4Ow3EmWOQZoaPcvGd9A4x4bhzRIp/RVWRatw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwCjKMUTuFJtEy09wggUGnL37/8BijP8aCBoJIYoega+MJ4IYz5
	UUXlZDBG46JpEpMMMHWtDP1B6vAYzJ7Ha7JS5iM5eWlqNg3J+MHm0gQFPZUn2LM/0dFPO2NrE2i
	l1t6WS2b5RLmrCLmpgg0EvFnszTPQGgOh0Gz1ATull1q4VA+2LWMV
X-Received: by 2002:ac8:7f93:0:b0:453:140c:ac60 with SMTP id d75a77b69052e-45b20573d99mr163550401cf.50.1727108631828;
        Mon, 23 Sep 2024 09:23:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGah0EW43b/NHrbQUHUF4y0RDzvpRR/zN6gzuhBBTaJwGY/I9BmVKauh4Q+cH5LrDtlepgfjA==
X-Received: by 2002:ac8:7f93:0:b0:453:140c:ac60 with SMTP id d75a77b69052e-45b20573d99mr163550181cf.50.1727108631502;
        Mon, 23 Sep 2024 09:23:51 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:760d:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b178751casm48368671cf.22.2024.09.23.09.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 09:23:50 -0700 (PDT)
Message-ID: <f36ab05ce7ff3c0823f31cdba85c091ed7211b8e.camel@redhat.com>
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
Date: Mon, 23 Sep 2024 12:23:48 -0400
In-Reply-To: <ZvE06wB0JGWXGxpK@google.com>
References: <20231002115723.175344-1-mlevitsk@redhat.com>
	 <ZRsYNnYEEaY1gMo5@google.com>
	 <1d6044e0d71cd95c477e319d7e47819eee61a8fc.camel@redhat.com>
	 <e5218efaceec20920166bd907416d6f88905558d.camel@redhat.com>
	 <ZvE06wB0JGWXGxpK@google.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Mon, 2024-09-23 at 02:29 -0700, Sean Christopherson wrote:
> On Tue, Sep 10, 2024, Maxim Levitsky wrote:
> > On Wed, 2023-10-04 at 16:14 +0300, Maxim Levitsky wrote:
> > > У пн, 2023-10-02 у 12:21 -0700, Sean Christopherson пише:
> > > > On Mon, Oct 02, 2023, Maxim Levitsky wrote:
> > > > > Hi!
> > > > > 
> > > > > This patch allows AVIC's ICR emulation to be optional and thus allows
> > > > > to workaround AVIC's errata #1235 by disabling this portion of the feature.
> > > > > 
> > > > > This is v3 of my patch series 'AVIC bugfixes and workarounds' including
> > > > > review feedback.
> > > > 
> > > > Please respond to my idea[*] instead of sending more patches. 
> > > 
> > > Hi,
> > > 
> > > For the v2 of the patch I was already on the fence if to do it this way or to refactor
> > > the code, and back when I posted it, I decided still to avoid the refactoring.
> > > 
> > > However, your idea of rewriting this patch, while it does change less lines of code,
> > > is even less obvious and consequently required you to write even longer comment to 
> > > justify it which is not a good sign.
> > > 
> > > In particular I don't want someone to find out later, and in the hard way that sometimes
> > > real physid table is accessed, and sometimes a fake copy of it is.
> > > 
> > > So I decided to fix the root cause by not reading the physid table back,
> > > which made the code cleaner, and even with the workaround the code 
> > > IMHO is still simpler than it was before.
> > > 
> > > About the added 'vcpu->loaded' variable, I added it also because it is something that is 
> > > long overdue to be added, I remember that in IPIv code there was also a need for this, 
> > > and probalby more places in KVM can be refactored to take advantage of it,
> > > instead of various hacks.
> > > 
> > > I did adopt your idea of using 'enable_ipiv', although I am still not 100% sure that this
> > > is more readable than 'avic_zen2_workaround'.
> > 
> > Hi!
> > 
> > Sean, can you take another look at this patch series?
> 
> Ya, it might take a week or two, but it's on my todo list.
> 
Thanks in advance!
Best regards,
       Maxim Levitsky

