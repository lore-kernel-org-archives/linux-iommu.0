Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F1A128826
	for <iommu@lists.linux.dev>; Tue, 26 Mar 2024 03:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711422923; cv=none; b=thVimtI+UCZmuuXVkPDGhFxYKpHasJxmYQhzUxTVS5n9/meZfNVXIcoJBwmlRou7ER+WatGgoADPdB4Nu5mvwMPMvwlwN6Ha6Dp67AME2LnlhlJDN+XrXnUnqyoVf5FwrBEVIoSuNzIl0WOl2eX6QeC3ebq6LkKckVooP0QSo3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711422923; c=relaxed/simple;
	bh=uU+SdB9hv9VPV/MPXHQAweqQt038vPR1r3h/RhWxy4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sVHdR3ELPtDhPz8XKVi9POu7rHr/mRfTjP6FAz0aixDD7xuAdN/zXz/Q13lszRYFWfmJC5o2SJyhEODZWfCNlXbMY8pFJUOn3BKyoUzHD15o/PtsRDD5yBfEfmYx7q8nU3qkNrF9gWwfQgtMCfbJOt8oFouaeSOsN6V4SruQ7oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C7nbBrQz; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C7nbBrQz"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56bde8ea904so5819a12.0
        for <iommu@lists.linux.dev>; Mon, 25 Mar 2024 20:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711422920; x=1712027720; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h59Ujb231n94iPcWksCPCK+dVGEbVXi1Rid0ia0yVGY=;
        b=C7nbBrQzzMavQjI/NTfrIIDeB0oDuoMOxYrVLQa9YmH8Ql391TzZYK/lcKbGazB+Sq
         D3i9ho6rHcDmJ4T+gfZcgRnPeD6+Ww8ht8aHEqoRFAaxh2tXUMEyENBadm1NtKemc52+
         NojWgzIEuIAYxI8brqhlTElL3weymo8T81hQSQoTv2eNkZWEz55xcoqwZ0kUJo5sHcFZ
         Dy3BqQINgqma3WAAOoVrAialDEFPwGk4ilMXlAlXxH//hUb1hP6FnHI1ZsWAw4ms4Dvn
         VT8ruFj3hFcKQ5I49pc23NJ9beTR1kKuwIwwwzKUUsNY2ijRWp0EMRIF8tDdoxyXCZIV
         movQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711422920; x=1712027720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h59Ujb231n94iPcWksCPCK+dVGEbVXi1Rid0ia0yVGY=;
        b=HMF/FM3cM67cP0yaRpGuvuRz0sezZTTXMiLJB/MlB+U4elMu2iM10x8fJUDGFXtNA6
         CWOi2naSICOgbj4BiubqGyTndwY4wUbpkdRCbtnrc+llgAGeZrsvqb3nTXRxmvPbwMq1
         eFoxPhc8k/kYt5ZFos0RuP1pPrepZmw+yEqwDR482PSkcKQ1fkdlW/voRY0gArEMZEKu
         Z4iLXXzIkHmyCDiQP513BmjYVP+08PY6MEG6X3PcCnI0npZbVTkmtN7G1GiTLXxYvHr2
         jnObe4RQj0SjnFX8YNJ1pdWi7tS4zaR1QtZyZAj4Y49EcLnKByz2+2IJSHGsPboQu3iA
         dfxA==
X-Forwarded-Encrypted: i=1; AJvYcCUZhXKW3Sw5i+5roUPNUbbMGWpD6MSfwjowEpbETw0Qw9CFg6XVdrSYpRS4b8z2bynL7RzvnTC8nw+U7kMBJUfiWOILMDw=
X-Gm-Message-State: AOJu0YwKvvNidlTkmNmcfQK7fzOILRpgHe9DISssxzUqSkvwbmHPHxXu
	QYxoNcjMRRkI9AAHsNG+CMkPI07nb637GGO2nZW/RTGlhlQs88MoXHbIN7DOklzznNTT/z6LXJR
	T9PT9XRbydbt7GAMbps9ZmSR51kNc10vx0Pxr
X-Google-Smtp-Source: AGHT+IGP6HGOjwqsoe8xIsHMkHVJvmdde3hdIBhpI2QSUDVcMgFZE7xVDsp9PhdopqxGx8UfD/7LwsgDAQgcLR5w+Pw=
X-Received: by 2002:a05:6402:7c2:b0:56c:9ae:274a with SMTP id
 u2-20020a05640207c200b0056c09ae274amr28269edy.7.1711422919954; Mon, 25 Mar
 2024 20:15:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230928150428.199929-1-mlevitsk@redhat.com>
In-Reply-To: <20230928150428.199929-1-mlevitsk@redhat.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 25 Mar 2024 20:15:06 -0700
Message-ID: <CALMp9eSSCUSOpP64Ho16sU6iV1urbjfTafJ0nThAWGHE6oOkLw@mail.gmail.com>
Subject: Re: [PATCH 0/5] AVIC bugfixes and workarounds
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org, Robin Murphy <robin.murphy@arm.com>, 
	iommu@lists.linux.dev, Ingo Molnar <mingo@redhat.com>, Joerg Roedel <joro@8bytes.org>, 
	Sean Christopherson <seanjc@google.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, 
	David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2023 at 8:05=E2=80=AFAM Maxim Levitsky <mlevitsk@redhat.com=
> wrote:
>
> Hi!
>
> This patch series includes several fixes to AVIC I found while working
> on a new version of nested AVIC code.
>
> Also while developing it I realized that a very simple workaround for
> AVIC's errata #1235 exists and included it in this patch series as well.
>
> Best regards,
>         Maxim Levitsky

Can someone explain why we're still unwilling to enable AVIC by
default? Have the performance issues that plagued the Rome
implementation been fixed? What is AMD's guidance?
