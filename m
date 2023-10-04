Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0677A1427C
	for <iommu@lists.linux.dev>; Wed,  4 Oct 2023 13:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696425407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CKB87bTajQH/5HfXBd7T/7DKZGQoywxxIms8WQ1l3Bc=;
	b=M1102iB4eOlk3eFSScUaCprpq7wlgI3PrTUECKyabkZzIPC45irovhMghQHWJbQJgeD/mg
	k1rZ7CRlH5ZujS1LST+ME7njaOkyyj3CIVNh+tGi7togQHyuIUzuRXq2HUoMkeegIoOUtg
	SIYaTDYhaNJckoBoaNNR1w8NMaWuFNQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-tUgKkT4sPKu3AJY9aCLnfw-1; Wed, 04 Oct 2023 09:14:24 -0400
X-MC-Unique: tUgKkT4sPKu3AJY9aCLnfw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9b65d7079faso166719166b.1
        for <iommu@lists.linux.dev>; Wed, 04 Oct 2023 06:14:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696425245; x=1697030045;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CKB87bTajQH/5HfXBd7T/7DKZGQoywxxIms8WQ1l3Bc=;
        b=A8lfww2GXw7QKtXBV004pPsemKU8gBZgNSYQ2lL0eAz/8SMK5aO88hJ8moLBgFgYrO
         NWEkWF3fw4jab6jGeA38DrflHZz9A0fzssKe74E8FCwbXkR9gT54JjvY+RWdN2iUoTxP
         Nz4QbYP4MP/xKwlYRy+v67AhuwL0BI48zfJgTxH/pGk1nDx9lPuT4roRJq06HSsr9Nxk
         Rj25frZOhdA1g1J2YhoG2zssIleWvx+M7E3px/ioJ9dh1Z1EnEd0KJaW6lGLBLCZQIlY
         jdaO65QOxa1pBJ3GY8Hev/5obN5u0tToBJF0p+AyKgOop9tXUD7xd4vK7+46X278e0IJ
         qh0g==
X-Gm-Message-State: AOJu0YwR2kf+ji0MHsuq/yJnwgx65EZkCgOmxZSIn/iya0qOQFxoRsWN
	xXEmIsx3fRBrI6fqlxARAn+wAfK9l3/4cvgd0pqtSkUF/LQ+Y4m8dy38fvdqUsLbd+hkuMon8nt
	YV+2Vi4EqN5L4UFE=
X-Received: by 2002:a17:907:2cf1:b0:9ae:513d:de22 with SMTP id hz17-20020a1709072cf100b009ae513dde22mr1648384ejc.56.1696425245064;
        Wed, 04 Oct 2023 06:14:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC30AVKWCM9IrhyyL18ynsqE9iCne0MTdbHhx8Q+RGfk5sKrumzX45E7UuQGRJoR3t6l1Fjw==
X-Received: by 2002:a17:907:2cf1:b0:9ae:513d:de22 with SMTP id hz17-20020a1709072cf100b009ae513dde22mr1648367ejc.56.1696425244676;
        Wed, 04 Oct 2023 06:14:04 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id f3-20020a170906048300b009b2ca104988sm2824343eja.98.2023.10.04.06.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 06:14:04 -0700 (PDT)
Message-ID: <1d6044e0d71cd95c477e319d7e47819eee61a8fc.camel@redhat.com>
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
Date: Wed, 04 Oct 2023 16:14:01 +0300
In-Reply-To: <ZRsYNnYEEaY1gMo5@google.com>
References: <20231002115723.175344-1-mlevitsk@redhat.com>
	 <ZRsYNnYEEaY1gMo5@google.com>
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

У пн, 2023-10-02 у 12:21 -0700, Sean Christopherson пише:
> On Mon, Oct 02, 2023, Maxim Levitsky wrote:
> > Hi!
> > 
> > This patch allows AVIC's ICR emulation to be optional and thus allows
> > to workaround AVIC's errata #1235 by disabling this portion of the feature.
> > 
> > This is v3 of my patch series 'AVIC bugfixes and workarounds' including
> > review feedback.
> 
> Please respond to my idea[*] instead of sending more patches. 

Hi,

For the v2 of the patch I was already on the fence if to do it this way or to refactor
the code, and back when I posted it, I decided still to avoid the refactoring.

However, your idea of rewriting this patch, while it does change less lines of code,
is even less obvious and consequently required you to write even longer comment to 
justify it which is not a good sign.

In particular I don't want someone to find out later, and in the hard way that sometimes
real physid table is accessed, and sometimes a fake copy of it is.

So I decided to fix the root cause by not reading the physid table back,
which made the code cleaner, and even with the workaround the code 
IMHO is still simpler than it was before.

About the added 'vcpu->loaded' variable, I added it also because it is something that is 
long overdue to be added, I remember that in IPIv code there was also a need for this, 
and probalby more places in KVM can be refactored to take advantage of it,
instead of various hacks.

I did adopt your idea of using 'enable_ipiv', although I am still not 100% sure that this
is more readable than 'avic_zen2_workaround'.

Best regards,
	Maxim Levitsky

>  I'm not opposed to
> a different approach, but we need to have an actual discussion around the pros and
> cons, and hopefully come to an agreement.  This cover letter doesn't even acknowledge
> that there is an alternative proposal, let alone justify why the vcpu->loaded
> approach was taken.
> 
> [*] https://lore.kernel.org/all/ZRYxPNeq1rnp-M0f@google.com
> 


