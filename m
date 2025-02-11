Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA42268FEF
	for <iommu@lists.linux.dev>; Tue, 11 Feb 2025 21:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739309523; cv=none; b=QhuB1xlPPhFbPX5TyvWX5RAtNqdvI66NlCQVT1VwP+aRyQRz0K3iKocnxOZ8tNbIXJt0qq1LAUPnzFJuhT5qFzA74gqVKiQB/sBL+9dc9CNTY3Bd1XKqwd98S4dOOuxa2iQfG+jgR9X3DD2HwIkyrTmkXnaq8G//VM9o4hgJAYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739309523; c=relaxed/simple;
	bh=+LUKvtaq5+tVeSV8nn8P/esQQflfMiqhA8o10k5cyOo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rprljLvSpMwL7d0IcGl2JcItEI5KTZxsVTlhJPv7rmaB2m0/9LLkDnNPGIv3hlQaZ6w5q7xiYZ/IwJ0Z7Jb0i7Q9ed0pEE5CKah5lTJvTL8tsiPoVyvoR1ryJoN5gKDvr7KxVTTeQHLwQZYuxyvrXIK0V9yEB2RrKYBiw7Bc3FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m+pUU6lO; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m+pUU6lO"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21f6a47d5d7so107320015ad.0
        for <iommu@lists.linux.dev>; Tue, 11 Feb 2025 13:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739309516; x=1739914316; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VkaRbODbKGzYYO3d8B5U658Dnrd7njXNzj1iv9zbjaI=;
        b=m+pUU6lOYjRWC3QVyxxOIShGpgW80IGDxRXEl6g9GwISPgbvyarkJPrByIhUZvjKMz
         qQE+3NrZDs5qk6STJqV8pNazqmukR0uZdbHOhEsgoE/qfWQjLw4PzIruL7GwGZ/1OMvp
         YWpPljIh76COyT4cHXzjNdng5ZwUdBISHMtrVFZpAAlFbKCHHKjeV947h2WAN4/xHTjM
         aQn6ADL0IpcIgJ6pkSWGGanJ3N/EIC6trK7xMl16UBXhWkDv320KZIHlUxuNlFzACnZ2
         LXbJ+8tQEPsPaWnLEUthPhEQrvkU6/7FA0BsD1y/4q8/Op9lirKC7I48zZPWEwCze6DY
         62Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739309516; x=1739914316;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VkaRbODbKGzYYO3d8B5U658Dnrd7njXNzj1iv9zbjaI=;
        b=XAOGUkwaaVGjcMZJU11g+K6QWzBaPA/EEwbyR5x6CXyIBiPoDLVUBW3Ln2ILcrR9DT
         G20xmfPmA73+fJMleF8ilyW69Eaw/dDH/pTPH8lFkg2D50qDP/OfMJo5RLpewXzeX18W
         19ED1EfAHibR7UtIt1rGJNkwrAHiuBZbGrVsBJA5mTq/3zEEbMNJmK5txRwvJabKbo22
         4g0V1BTk6VwS6sx7jbwqs8AorbjQh+VjWI+XY/zwGDAfQt5qIU7tCUBfXnVv4d3OZ7CA
         cvTrcZPZdZaYpYvjCuahRbfExsprV/LC5pHrYKqSrpVLi6FkCbNxxQS2zhznPVFMNPSM
         xxyw==
X-Forwarded-Encrypted: i=1; AJvYcCWNW0cNrwW0gUA9ZN69C7r1sKZ/Hn6gS3gvc1+rMaH7syWvHgL5aBHg5FlxHXgfvzCvxFONXQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/F5yndkUZ2VhWLp0QcvmkaAXtrh/mu9n4RLV/Y1UOJFxZGXvT
	A2Hf8HKzyMCw7VYeMWATvBLdsHa6Vma+yOpLsKhIn6HWLDh8Cv3u3fYVeTVqeJ5TekehrsbKIGS
	7Nw==
X-Google-Smtp-Source: AGHT+IF0fRIVtQzGjHRyYmnEnH/8CimtcIxuPGCWLPNdmuUYuFVbVgvZHz2rDvO254ixr09jUnGGcU4Rzps=
X-Received: from pfblb14.prod.google.com ([2002:a05:6a00:4f0e:b0:730:8a7b:24e0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2d06:b0:1e4:8fdd:8c77
 with SMTP id adf61e73a8af0-1ee5c733c61mr1455053637.8.1739309515854; Tue, 11
 Feb 2025 13:31:55 -0800 (PST)
Date: Tue, 11 Feb 2025 13:31:54 -0800
In-Reply-To: <cover.1739226950.git.ashish.kalra@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <cover.1739226950.git.ashish.kalra@amd.com>
Message-ID: <Z6vByjY9t8X901hQ@google.com>
Subject: Re: [PATCH v4 0/3] Fix broken SNP support with KVM module built-in
From: Sean Christopherson <seanjc@google.com>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	thomas.lendacky@amd.com, john.allen@amd.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, joro@8bytes.org, suravee.suthikulpanit@amd.com, 
	will@kernel.org, robin.murphy@arm.com, michael.roth@amd.com, 
	dionnaglaze@google.com, nikunj@amd.com, ardb@kernel.org, 
	kevinloughlin@google.com, Neeraj.Upadhyay@amd.com, vasant.hegde@amd.com, 
	Stable@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-coco@lists.linux.dev, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Mon, Feb 10, 2025, Ashish Kalra wrote:
> Ashish Kalra (1):
>   x86/sev: Fix broken SNP support with KVM module built-in
> 
> Sean Christopherson (2):
>   crypto: ccp: Add external API interface for PSP module initialization
>   KVM: SVM: Ensure PSP module is initialized if KVM module is built-in

Unless I've overlooked a dependency, patch 3 (IOMMU vs. RMP) is entirely
independent of patches 1 and 2 (PSP vs. KVM).  If no one objects, I'll take the
first two patches through the kvm-x86 tree, and let the tip/iommu maintainers
sort out the last patch.

>  arch/x86/include/asm/sev.h  |  2 ++
>  arch/x86/kvm/svm/sev.c      | 10 ++++++++++
>  arch/x86/virt/svm/sev.c     | 23 +++++++----------------
>  drivers/crypto/ccp/sp-dev.c | 14 ++++++++++++++
>  drivers/iommu/amd/init.c    | 34 ++++++++++++++++++++++++++++++----
>  include/linux/psp-sev.h     |  9 +++++++++
>  6 files changed, 72 insertions(+), 20 deletions(-)
> 
> -- 
> 2.34.1
> 
