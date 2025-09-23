Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40900323F58
	for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758632290; cv=none; b=G9qQFLlzYZ5LFfJ4QM60KZsbfnWFGLUQL6NjLxqT6UlVP3is3CO/sueQEs++zlZxZ7NNUnpMGjXAJjOqgU4wMeTxiQWRZ+Fm2BPKFkAfZMAdXz0ZMrQDbFideAX1776puwnHGbG2vKpvEOOlHq8D1pewSWE6kEPO86pZdfMyxT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758632290; c=relaxed/simple;
	bh=A2IMMdRVOaoGx4CmZT7VA864qaSMJOoHUZNtkeMI/VU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fR3J9PQCIsxhniQsH/zbL0eo+AHo4dYuDgF95L6rWQXJulc2dB1ScJpAwc6FcpTx9v4dzObyMFd4rjSWDOOn4BN9JpCESd+c/9PLc5EuM5HiguY6f75GMwZ7PWywVXV+gusrQQMoHu4a9ut0LfOIiGGxObiuKKdy2pyVduey2hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RunkEksx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RunkEksx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758632287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Tq8eV1TAeYiGLz8ruZSC4SaM9je4JKLFfQxF5hcnMA=;
	b=RunkEksxs9/0cxA3/8usOFHtRjhv0+aYpxdKUYNRRG+JD1AF0yYkHfeZgZqsTtdy2SUchT
	C4z2fLRvhtHig/s8zVK3wVyYA/cb6s5i1Pu306Tf8GDa4zVSRDSK96rcSU3kpTNA8qRRm/
	uvCsqLQGQHRiOwwqTccaIcYUtCSTvBg=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-PgpnYleEMPiPb5y7i81gRQ-1; Tue, 23 Sep 2025 08:58:05 -0400
X-MC-Unique: PgpnYleEMPiPb5y7i81gRQ-1
X-Mimecast-MFC-AGG-ID: PgpnYleEMPiPb5y7i81gRQ_1758632285
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-4257e5a8f1fso2567645ab.1
        for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 05:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758632285; x=1759237085;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Tq8eV1TAeYiGLz8ruZSC4SaM9je4JKLFfQxF5hcnMA=;
        b=PWYq8qpLuCRps/FsbZfMzmouHLP45+Z1BeUiceDzj6B+ZaipbWBpPQr9LBj8+vL4Fx
         7faQLuKGrX1qX6Fx0dDZoKs5bFEs5Cu7LOVz+i5iwWz8rvjwCPC22BlfbagmENq3ICSa
         In3ZXBOF6vR13bGtKi+lgE/t0SkZpYeTDVVAelAEaACqbEHNgq0LNZYbEvX3WvleEhty
         IW7gmNBf/UxmHv4xLvPm8JWMcbvxgRgQ1pujLxhj7ezXImYx6/ToWhsZy7Qh++egxL21
         aaoghaYHRKdpTPAX3iAEAD6umNVxDsm3JJo+KDeGOmKuTvnVpZr9GAxc0sS5i0jA7YNC
         TYvA==
X-Forwarded-Encrypted: i=1; AJvYcCXmsExxqmSlKF9y0hnEBrRizVOOBOtKBYzA0IDKr+JsBlCXTnqGC5edqyY0tQZUtYzqoq1UNw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx1yXq4wuT0HvIOuFBY/Bpp6pjvcaS3UYeHCP10pwV1Hi4QUTvF
	+nCpBCuVkPf+/Y7vl1Y4D9AWcaKlRgVKkjd6l6X+FO5JVoOgy5zZnGHlkMhLbYq/964sdXIY6hC
	zEaw4wxz6OFmIfeOXmkajCb4G4Um81hRPOBImTZNFMo2sg+D3LWA3HkEK
X-Gm-Gg: ASbGncvkMG51Bbm9o+FiytroH4qyrE5nxwCS6COW0pkjXXbkxxwJ1lXD/trQJ9o+y3f
	K241xscVQT2brmrMwqkTlfhrOZHm+aK5iWvwSSP683Se1/IGshzfXigztfTJFsCgHUSxosZL0HK
	XNGznXBdbLFGoAGll66UJuMl+6xTZ3X4CKpBHmDO38WjJIzdfa3sFmXTzLO3SGuAt178ZsLvUXz
	Pe3QIJm0UDmb6KAOWgW47q9VOA1y0g9FcqJpu7pCmxnTkV5ffChACUyLFHuVYo1tAWeoZlMgNp0
	ukpN1457pPCGMiYG8fDfw3A4ZZyBh1YBUAs6Xuk+nUQ=
X-Received: by 2002:a05:6602:3fc4:b0:897:42c1:bcd3 with SMTP id ca18e2360f4ac-8e20e8ff164mr163409739f.5.1758632284957;
        Tue, 23 Sep 2025 05:58:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWbkj/uISty5Vh6ighMEa8imB4zODbgJ/1fX320gi/1h2UE0ETTQaM30bBEliykOTPs5/KCA==
X-Received: by 2002:a05:6602:3fc4:b0:897:42c1:bcd3 with SMTP id ca18e2360f4ac-8e20e8ff164mr163408639f.5.1758632284492;
        Tue, 23 Sep 2025 05:58:04 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8d7f8f481bfsm138390739f.24.2025.09.23.05.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 05:58:03 -0700 (PDT)
Date: Tue, 23 Sep 2025 06:58:01 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Donald Dutile <ddutile@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 linux-pci@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, Will Deacon
 <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 galshalom@nvidia.com, Joerg Roedel <jroedel@suse.de>, Kevin Tian
 <kevin.tian@intel.com>, kvm@vger.kernel.org, maorg@nvidia.com,
 patches@lists.linux.dev, tdave@nvidia.com, Tony Zhu <tony.zhu@intel.com>
Subject: Re: [PATCH 03/11] iommu: Compute iommu_groups properly for PCIe
 switches
Message-ID: <20250923065801.3c6a23e4.alex.williamson@redhat.com>
In-Reply-To: <20250923123218.GI1391379@nvidia.com>
References: <20250702010407.GB1051729@nvidia.com>
	<c05104a1-7c8e-4ce9-bfa3-bcbc8c9e0ef5@redhat.com>
	<20250717202744.GA2250220@nvidia.com>
	<2cb00715-bfa8-427a-a785-fa36667f91f9@redhat.com>
	<20250718133259.GD2250220@nvidia.com>
	<20250922163200.14025a41.alex.williamson@redhat.com>
	<20250922231541.GF1391379@nvidia.com>
	<20250922191029.7a000d64.alex.williamson@redhat.com>
	<066e288e-8421-4daf-ae62-f24e54f8be68@redhat.com>
	<20250922205027.229614fa.alex.williamson@redhat.com>
	<20250923123218.GI1391379@nvidia.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mhwWuIiH67RS5SYQlfUXeNrkz67qk6YzjilmZQyjqy4_1758632285
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Sep 2025 09:32:18 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Sep 22, 2025 at 08:50:27PM -0600, Alex Williamson wrote:
> > That's not what the spec is doing.  We're misinterpreting it.  The
> > sections of the spec you're quoting are saying that if a MFD function
> > supports ACS it must support this specific p2p set of capability and
> > control bits unless the device does not support internal p2p.  
> 
> Bjorn raised that too, but it doesn't actually say that. The wording
> is meaningfully different from the preceeding section that does
> explicitly say the language only applies if the ACS cap is present.

What then is a "Multi-Function Device ACS Function".  I think we need
to take context from the parent and previous sections to understand
this applies to functions implementing the ACS extended capability.

> IMHO, from a spec perspective, prior to this language, internal MFD
> loopback was *undefined*.
> 
> You are advocating for a very pessimistic position that undefined must
> mean the worst interpretation for everyone. It doesn't, undefined
> means we don't know.

Right, we don't know if p2p is implemented, we're implementing a
security related feature, therefore we assume the worst case and allow
for quirks in instances where the vendor can vouch that p2p is not
possible.

> A big part of the argument here is that in the modern world the HW
> community has aligned that MFDs should not have internal loopback
> because it harms virtualization.
> 
> We are here a decade later and we can choose to require quirks on
> devices that choose to implement internal loopback, because they are
> certainly now the minority of HW.

This seems like optimistic speculation.

> > We've had NIC vendors implement an empty ACS capability to convey the
> > fact that the device does not support internal p2p.  There is precedent
> > for the interpretation I'm describing.  
> 
> IMHO it just shows Linux has the power to convince device vendors to
> do things.

And now we're effectively punishing vendors that have gone to this
effort to expose isolation by hand waving that it should exist by now...
 
> > Are we going to expect users to opt-in to securing their system?  
> 
> Since the grouping isn't working right today we are already
> effectively doing this.
> 
> All this is arguing that the burden shifts from people with modern
> systems to people with ancient systems.

AIUI there's a narrow case of downstream switch ports implemented as
separate slots that is misrepresented.  This should be fixed.  There's
also an effort here to consider both egress traffic (as done today) as
well as ingress traffic (new).  IMO this will inevitably cause
regressions and users may need to opt-in to make their grouping less
secure for previous compatibility.

Requiring users to opt-in to secure their system is fundamentally
different from requiring users to opt-in to a reduced isolation
paradigm.  Thanks,

Alex

