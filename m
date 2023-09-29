Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3C610E6
	for <iommu@lists.linux.dev>; Fri, 29 Sep 2023 00:42:37 +0000 (UTC)
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-d81646fcf3eso20939353276.0
        for <iommu@lists.linux.dev>; Thu, 28 Sep 2023 17:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695948156; x=1696552956; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oXtA4CIJkNUO5AsjiezElUAdl6m7M7+pcvajILFIvUQ=;
        b=USeeDVQ1iFqAaMnDOFEeQD1hu1V238OxSGs8RESCcKENWQnZlhjYdFX1v13vXGyAFu
         rEsNZJpMkBySEdGhN4aLREEJLvBsI8HC8pT8zQ5XL+FLMEtrw52X0bIoWWYE6A4msaE5
         6MoFDpqYXvTKdjNHHrnW4/1V1IR/mNR8Ijah0yj1xz4yLdNzmPVedoCZkDPQevR9PxUp
         2Ro1toJcHAV0HC0wFXTvWDUESPsIm1YaWQgqFUvrI3aaUBDNzYoqmkQW14y57LYCl19v
         93t1522r7K4zulz89P32mA6FtoddhpocG6O95m+6N3dNkngH229ClLFCEFAB7uuJI+Ds
         EjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695948156; x=1696552956;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oXtA4CIJkNUO5AsjiezElUAdl6m7M7+pcvajILFIvUQ=;
        b=u7G2WK+Ax8slY1ThJULOPngJ/WH3mXCADxgcfJdECiOB79C587LTvAJJLxsNOqutv1
         U0HxYA3y5frAqZP66gSN24+Hg0lye9G8dTFi93x4UjG1bz3IPQ8s9yVl5gTVCu5AveJF
         IT3e+cKKwP/EihiJaf4Pfm2HYlKLI6DSdDoUs7wRUHfZwUrBHg/LEqNj1voyMnFi36vm
         jI0UdxVQfqWESVe//RhYagN0JhvccJFPRgtuNqBPIzqvI3HlTrUv2GfU1Vq9Y+dUmIjE
         3sPur51kF/WEkWIYj3HC//sZOA2pXtK6uXwhEpsThiRXvJjSxq69kd2g5VuKCnuZiWer
         gaHg==
X-Gm-Message-State: AOJu0YyPz0v8w1F8wrGr/3LRnkGCF3gEaNjDr1f578gKDfcfzKS1EaEt
	dEJLx5XwynxH+4PFJaEt+qYrmYLYAVM=
X-Google-Smtp-Source: AGHT+IHQKL11sXvSD1OxXeiwjG9Teo/hx0bwxPfT/7G9T+4Ho10xF8UFwRp+Kp/lYdliugSW1vqRYpcVA/Y=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:181c:b0:d82:9342:8627 with SMTP id
 cf28-20020a056902181c00b00d8293428627mr42880ybb.6.1695948156573; Thu, 28 Sep
 2023 17:42:36 -0700 (PDT)
Date: Thu, 28 Sep 2023 17:42:35 -0700
In-Reply-To: <20230928173354.217464-4-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230928173354.217464-1-mlevitsk@redhat.com> <20230928173354.217464-4-mlevitsk@redhat.com>
Message-ID: <ZRYde2P413vWOYDq@google.com>
Subject: Re: [PATCH v2 3/4] x86: KVM: SVM: refresh AVIC inhibition in svm_leave_nested()
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, 
	"H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Joerg Roedel <joro@8bytes.org>, x86@kernel.org, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, linux-kernel@vger.kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Robin Murphy <robin.murphy@arm.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 28, 2023, Maxim Levitsky wrote:
> svm_leave_nested() similar to a nested VM exit, get the vCPU out of nested
> mode and thus should end the local inhibition of AVIC on this vCPU.
> 
> Failure to do so, can lead to hangs on guest reboot.
> 
> Raise the KVM_REQ_APICV_UPDATE request to refresh the AVIC state of the
> current vCPU in this case.
> 
> Fixes: f44509f849fe ("KVM: x86: SVM: allow AVIC to co-exist with a nested guest running")
> Cc: stable@vger.kernel.org
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
