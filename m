Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43D4253928
	for <iommu@lists.linux.dev>; Thu, 17 Apr 2025 17:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744911472; cv=none; b=GMev2Fgc24oWBtrKAedBnHKuDJB/qcEecuNzcnj7q5CQ6CiTqdmXg8OPWnuDDZOTOwfiyY/vsTZTON8hA+p5bkzl0blbt4e985S85qtjztHRP9JjG0xd4/sjcIFlHGjlnkwRSCFvZ1z+BKzaoFxl8+kzbjpl6C8eqo+gxfr5N1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744911472; c=relaxed/simple;
	bh=Z0sFzb5brbKQVaF0C8OLPsVeNcVcEevptZnWFDnVwVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S7sVcg6QfZOgUrH3N1/eY73F2K45NzoTp3l5RyUDqTn/gr/jFpjI0DcxuSPJh+tWvPhvo94ogJ2tKhUEebm9xJARo2vPdlWlMZVfvbiZ2S5LdAt7+02kBptZ1YhQ7ELY3YSmyp4QC4+fa8x66jnCksr+lQcKEu8XWFYKSoh6lcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hGWGHyv6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hGWGHyv6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744911469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0sFzb5brbKQVaF0C8OLPsVeNcVcEevptZnWFDnVwVA=;
	b=hGWGHyv6DFvRgckJ4Zn6FLvvrJ+gX3WsDg92DVgoqCCeorrHJkZ9GnPQEW0Nf1i6hv5GYf
	oqJLEa5fCBtUSTgTMjBo/cD0SmWVkKNC8lsKWHti6MTxpmTysZLa5txvfZ51+llXT6hfE4
	KoH1w9c2DDmyNYBnhP54gbO3g4YFxYY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-obs65rAMMZ-Z0I3Q4112kg-1; Thu, 17 Apr 2025 13:37:48 -0400
X-MC-Unique: obs65rAMMZ-Z0I3Q4112kg-1
X-Mimecast-MFC-AGG-ID: obs65rAMMZ-Z0I3Q4112kg_1744911467
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cf44b66f7so5714855e9.1
        for <iommu@lists.linux.dev>; Thu, 17 Apr 2025 10:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744911467; x=1745516267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z0sFzb5brbKQVaF0C8OLPsVeNcVcEevptZnWFDnVwVA=;
        b=mXEEI6myajtYSbVSe3M4ia4Ufia+arVp2xiDfUVo650lo6+4gyM8AtW/AcFGDWOdO3
         TQsDl1aGd3SaM6xF5zwuIk5aJt1HSkTlIP6yO198sld2KwbYAAjp6OVK+dELc+4GJ/kr
         V9t/iCJt/dBUvSyO8QZ+oPC/mk5lwkY0SiEgXyQA3P2DIAjBZEgG/wyRyMgqEGoqv4f+
         P5htCkaqZA7Ybrh0De3PossM2Q9fE1Y2UyE96DzOiFzirmrcZ7zb18w5A1UMScJRgabs
         y8PPdiR/ynA2nu2kPO7j1may+9W/uzkEvfaVwbqvCj5DvI8FmVXJo/UFE3m5Uf0ytRUu
         zbCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbw9MFSswnd6aTMm+Qsn7yKULEeOvvkQf8UAIXzHfit6zj3+Z+bw5J0BfSYIgJQd5IAhT6jQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxMUSpP8+kRY8Z7995y0d/GNlYgSCTakbETbmXFvR0yP8ufVYgF
	qggUuVLZrRfTZ7UZmFMBtJvnD46sIIQDM+RT1ghzNkJJcJFJJTS8QaWJh6MkghhuudWgBUX9LMw
	1vN336aSIc9ubMAON4zdAXdN0h3MS9O0ToI9SRQMZIxd3qQyn/ZPpVS+pz7owsig5s2LHw24XeU
	iCzw6FNS3Vdh7DlMKJsce4Uh8xd7Y=
X-Gm-Gg: ASbGncvxZf7wnBxDgKH18mYJ3q1IyjbawGKGIDpsXA1mmYz36igsGeijfKwP+jWVm9o
	qklKJ/W7YritRGX+vFeCM+Z/6anzg1zpDtY8ZA8hKUC4wrxNMsirDbllkC5laKzqRtrZ7mQ==
X-Received: by 2002:a05:600c:384b:b0:43c:e7ae:4bcf with SMTP id 5b1f17b1804b1-4405d5bdb1cmr78617465e9.0.1744911467342;
        Thu, 17 Apr 2025 10:37:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEB6JNchYDi6dPBvFLX5ceNDlu/RLfP5VkTWs33YKOj+4WfauYjEYQ8SROPk+2SXPnT+n9TJHZTcIOdUpA2GS0=
X-Received: by 2002:a05:600c:384b:b0:43c:e7ae:4bcf with SMTP id
 5b1f17b1804b1-4405d5bdb1cmr78617165e9.0.1744911466985; Thu, 17 Apr 2025
 10:37:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com> <20250404193923.1413163-7-seanjc@google.com>
 <0895007e-95d9-410e-8b24-d17172b0b908@amd.com> <Z_ki0uZ9Rp3Fkrh1@google.com>
 <fcc15956-aad0-49ea-b947-eac1c88d0542@amd.com> <Z_7X3hoRdbHsTnc8@google.com> <de563c32-b124-433e-9d16-2544c41e2be6@amd.com>
In-Reply-To: <de563c32-b124-433e-9d16-2544c41e2be6@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 17 Apr 2025 19:37:35 +0200
X-Gm-Features: ATxdqUFeNPvQVED7_AzqwVcYqyNzFA-G-bDhGMcN4bAaQKzHQa7gq22ssnm_MNc
Message-ID: <CABgObfb5QngpP_DGLx_6Y+wD+-3aSOnYUsdHCpym+V6VxY8krg@mail.gmail.com>
Subject: Re: [PATCH 06/67] iommu/amd: WARN if KVM attempts to set vCPU
 affinity without posted intrrupts
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: Sean Christopherson <seanjc@google.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>, 
	Joao Martins <joao.m.martins@oracle.com>, David Matlack <dmatlack@google.com>, 
	Naveen N Rao <naveen.rao@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fsDJHqEmaXRaV7GyHZV-T_Arvp1Y7i0YZ1hYiGiVVTc_1744911467
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 11:47=E2=80=AFAM Sairaj Kodilkar <sarunkod@amd.com>=
 wrote:
> I think it is safe to have this WARN_ON(!dev_data->use_vapic) without
> any false positives. IOMMU driver sets the dev_data->use_vapic only when
> the device is in UNMANAGE_DOMAIN and it is 0 if the device is in any
> other domain (DMA, DMA_FQ, IDENTITY).
>
> We have a bigger problem from the VFIO side if we hit this WARN_ON()
> as device is not in a UNMANGED_DOMAIN.

This does seem safe, but its more of a VFIO/iommu change than a KVM
one so I'm not too comfortable with merging it myself; please submit
it as a separate patch.

Paolo

