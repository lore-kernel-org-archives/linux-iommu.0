Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D81817CE
	for <iommu@lists.linux.dev>; Fri, 29 Sep 2023 02:09:03 +0000 (UTC)
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-d868842eda1so17009123276.0
        for <iommu@lists.linux.dev>; Thu, 28 Sep 2023 19:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695953343; x=1696558143; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iRifG0kMrpXqEfz+mDuKDe9tCj6ju9DW+Z80pWDEPIg=;
        b=3XVJYdsRweYoD185on/NudjXjoApBONB9jiOBUqaw61OeZt+LlgoZhkFpb4c80lZZw
         iclSlCqkAb9/RV+dZCE7mw2yI+bh+9r9C2jTg/gyC2rnE16IjWoOoEP7OpOK6WoR3GDS
         oScOSm6I/KXbMKL9sketKPy019/ZMCLY3m0ulRHWqxEHH8lim3ZsQGnb9zEP7JsxIPLP
         Qetsu8HjFIcdAkImXFA59FQEUIweWEiHBDqEb7mvJ/qaTyBl8laXgdAeWfD5URweB+vo
         YYNwF7nly4cmJndPuhmg3lVv0LCu4BLhk3lBz04woX1lcgX51TLScwOuGJeWqwTuL1oD
         od9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695953343; x=1696558143;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iRifG0kMrpXqEfz+mDuKDe9tCj6ju9DW+Z80pWDEPIg=;
        b=UYdf9u5zm51j/nK25g582Si4ukH2410YiY4u9Uc6rb6UU6wxryOcnEZBMtrCasJGmS
         3OQvcN4op5wvka2WLPCF17Fxt0s3Zlk3RDkt8i2Fub4Y1R4XoTpEepKli6msuIPmdrQw
         XHEEUo4/Jn9QtQxVZXSK7Bf6DjnH60EMhsQy/f4LYKcIAYVtr4x4LmrFUqgOGwAyn9Ix
         hN2jCao1IZsJHeLRQbu5NixUb/qn1t1Wyao99xgVnsT7nYEqefXvR/xuuRlsFH+TT0gL
         S+8EKedXOf7KCfbZ+51UOlH9MDEn8QVhRKSDSi0qB9IZejicDbNlKiL79prBk2tDPrFH
         2iVg==
X-Gm-Message-State: AOJu0YyslLSEAuCOerba7le1ILNh5F/piUjx0SqWkMVzfdLKmIDJE6cN
	D0uRMKtwlDOx74YX2oQ+7FL9fngnvLo=
X-Google-Smtp-Source: AGHT+IHSABCyhHlqkH3QYwh23b9HPcWYdRzvnPf4l9PM6ESO2KCiEZOquFC+M7OxKxdHxatj23bPR+UdpeE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ad50:0:b0:d0e:e780:81b3 with SMTP id
 l16-20020a25ad50000000b00d0ee78081b3mr37853ybe.2.1695953343145; Thu, 28 Sep
 2023 19:09:03 -0700 (PDT)
Date: Thu, 28 Sep 2023 19:09:01 -0700
In-Reply-To: <20230928173354.217464-1-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230928173354.217464-1-mlevitsk@redhat.com>
Message-ID: <ZRYxvdmHpjxr3QKp@google.com>
Subject: Re: [PATCH v2 0/4] AVIC bugfixes and workarounds
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, 
	"H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Joerg Roedel <joro@8bytes.org>, x86@kernel.org, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, linux-kernel@vger.kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 28, 2023, Maxim Levitsky wrote:
> Maxim Levitsky (4):
>   x86: KVM: SVM: always update the x2avic msr interception
>   x86: KVM: SVM: add support for Invalid IPI Vector interception
>   x86: KVM: SVM: refresh AVIC inhibition in svm_leave_nested()

Paolo, I assume you'll take the first three directly for 6.6?

>   x86: KVM: SVM: workaround for AVIC's errata #1235
