Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948AA1A7072
	for <iommu@lists.linux.dev>; Tue, 10 Sep 2024 20:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725999196; cv=none; b=nU53xZi2iuOC9zliTgXI7yVgjPQNU3/hQKVGZ4qkBNLFCI0yUmM+3nD/G+4kMnW/1/iRlbtap2lAzuLpFXZ7IImv9u94UnOia3hYAnIBvivxquu42G+qQpkuECdLzRkeXQCDzFIXDiiHTVPxYlYu9JSqR6hZdCAhq57kT+3GdWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725999196; c=relaxed/simple;
	bh=SmGdKsMeARzok6Efk7DiO3PzMavjkZ1CyBtvfmmY88o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B5Gxwe16b8t2NBziu5OX7uKjPb/Ounf1YwcvdFvyO1ieFGqjWSsnIc0K5fU/Shwsr+++y++3xQ+5NNiPkJUMGuUTUvytHJYnL40/82m0rPfk1/IhGbp46w3hSkhKrlD7gdCvqW4QJM/oPNJgTchmSz+sX6EIZt0OPHIfZc5Nyfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YO2XIs6V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YO2XIs6V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725999193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nDtYyQHUbQoxUf9RtgQfhLfnKwLGRhZtyaZbqqn8Z/0=;
	b=YO2XIs6V7cZyGRx5ycU0y3eynVi4tjye5vArZI9xoVO1fpnSeex5PSeUiOYLE49pcDZuXS
	g2zmh3qyKfzcvJxSbYj4u1nMO1CGVScP4HVEesmLkTiKF3e+AnaOiH952wzFW8FWFbBTeS
	UsGQZGsniCtJ93jyDvWJyon0ql3KsaY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-1HGlz5euP9GpzoLUZNAkKQ-1; Tue, 10 Sep 2024 16:13:10 -0400
X-MC-Unique: 1HGlz5euP9GpzoLUZNAkKQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7a9bb56da15so516333785a.1
        for <iommu@lists.linux.dev>; Tue, 10 Sep 2024 13:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725999190; x=1726603990;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nDtYyQHUbQoxUf9RtgQfhLfnKwLGRhZtyaZbqqn8Z/0=;
        b=kxAJKSIVv1zsa7bzFcqdJIHHtBZZ8WW3jDQQwzl5HUULSpBmnU9YLEbkLPTFaUYFzW
         C4S25nLHanYLuuWW9VctofdtcvBR1DVq0IVpyANcqZDp1a8a4vXXbNGbcoT1Q0OUfaWN
         ZJGF6y4k3IYyzUI6/dAscwVO20qZBDG6gVj3rMKbnOU6whj5ZrUOiu6zbo7ONNqbFqcX
         Gx9FOkesEoZJ7pNU0htO236ZIXNKMxAe0kuzXOWLMpeF6h5xuih76z6ckqgwwmylRCRj
         B1X7tdn3h/zaxG644Om1uulYzdg2m2tWJ/hHcqspki7/u8Y6w5fO9ujGb1L7rwc7ZkBw
         zBmw==
X-Forwarded-Encrypted: i=1; AJvYcCX1I21UUo0mLXUVmDsVNhosA/nM3oymHGdEYWBcT/L39oT3qNOfia6AGqSojczP/T928lZV3A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw8g3eaVcTXGE54D8nvBxwDzZGykvMwjGG98fu2KcQT6XHf59dg
	f9e8BAnNiV49SstQI2tmQQhssR2Ik215URCILpOAnN7K0/NtTm77/Rz3xeDhVyedfU3BGFFNH3/
	3y0XgGA+1jyOLzpRDs1ggUsQxYU2Rr2+B17d+qvO0Fekp8gL5Opzo
X-Received: by 2002:a05:6214:4345:b0:6c5:52cb:eb77 with SMTP id 6a1803df08f44-6c552cbed7emr83953236d6.2.1725999189590;
        Tue, 10 Sep 2024 13:13:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsa80Vfsj+4PZuSTXsmrgG/jjhTRObLUykG/vdN5JeOTBK1I0ZLARmLG+r7hRF7RzLsA44+g==
X-Received: by 2002:a05:6214:4345:b0:6c5:52cb:eb77 with SMTP id 6a1803df08f44-6c552cbed7emr83952686d6.2.1725999189045;
        Tue, 10 Sep 2024 13:13:09 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:760d:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c534774303sm33189216d6.111.2024.09.10.13.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 13:13:08 -0700 (PDT)
Message-ID: <e5218efaceec20920166bd907416d6f88905558d.camel@redhat.com>
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
Date: Tue, 10 Sep 2024 16:13:07 -0400
In-Reply-To: <1d6044e0d71cd95c477e319d7e47819eee61a8fc.camel@redhat.com>
References: <20231002115723.175344-1-mlevitsk@redhat.com>
	 <ZRsYNnYEEaY1gMo5@google.com>
	 <1d6044e0d71cd95c477e319d7e47819eee61a8fc.camel@redhat.com>
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

On Wed, 2023-10-04 at 16:14 +0300, Maxim Levitsky wrote:
> У пн, 2023-10-02 у 12:21 -0700, Sean Christopherson пише:
> > On Mon, Oct 02, 2023, Maxim Levitsky wrote:
> > > Hi!
> > > 
> > > This patch allows AVIC's ICR emulation to be optional and thus allows
> > > to workaround AVIC's errata #1235 by disabling this portion of the feature.
> > > 
> > > This is v3 of my patch series 'AVIC bugfixes and workarounds' including
> > > review feedback.
> > 
> > Please respond to my idea[*] instead of sending more patches. 
> 
> Hi,
> 
> For the v2 of the patch I was already on the fence if to do it this way or to refactor
> the code, and back when I posted it, I decided still to avoid the refactoring.
> 
> However, your idea of rewriting this patch, while it does change less lines of code,
> is even less obvious and consequently required you to write even longer comment to 
> justify it which is not a good sign.
> 
> In particular I don't want someone to find out later, and in the hard way that sometimes
> real physid table is accessed, and sometimes a fake copy of it is.
> 
> So I decided to fix the root cause by not reading the physid table back,
> which made the code cleaner, and even with the workaround the code 
> IMHO is still simpler than it was before.
> 
> About the added 'vcpu->loaded' variable, I added it also because it is something that is 
> long overdue to be added, I remember that in IPIv code there was also a need for this, 
> and probalby more places in KVM can be refactored to take advantage of it,
> instead of various hacks.
> 
> I did adopt your idea of using 'enable_ipiv', although I am still not 100% sure that this
> is more readable than 'avic_zen2_workaround'.

Hi!

Sean, can you take another look at this patch series?

Thanks in advance,
	Maxim Levitsky

> 
> Best regards,
> 	Maxim Levitsky
> 
> >  I'm not opposed to
> > a different approach, but we need to have an actual discussion around the pros and
> > cons, and hopefully come to an agreement.  This cover letter doesn't even acknowledge
> > that there is an alternative proposal, let alone justify why the vcpu->loaded
> > approach was taken.
> > 
> > [*] https://lore.kernel.org/all/ZRYxPNeq1rnp-M0f@google.com
> > 
> 
> 


