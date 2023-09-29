Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBEF15A3
	for <iommu@lists.linux.dev>; Fri, 29 Sep 2023 00:42:23 +0000 (UTC)
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1c577fea3dcso140066555ad.2
        for <iommu@lists.linux.dev>; Thu, 28 Sep 2023 17:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695948143; x=1696552943; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LHnl2CsLxrfQz4bzbwJAj223y7XyxSn5JpaUfYsfSDE=;
        b=QxRbLfX/+PVqLVBF4PYeS4SURQEtbOrG70tf7hM31ltJbrCVSL40bVTJuXNl8AF/oA
         PwG98J1gaofo4NiMEpFHly0GcPFL/d6F6S7eLcLBvk3nQc6XSHupsB75VU6AS93l2iR8
         /ridGq6n6hgFY9Zd1kFuJ9koSW/IfTS6mhF/ytv93fPCJqD2fyACk8T3JjJxQ14V9ARG
         WcNGshHRzrC5axzccPlGagJsnLlObSdSAThU+LZsQLwYiX6ElD2yrbdYFUlXANhNnGO4
         YzS2Egu8M+l1ACdUq8dwcfVGFYyRcUuUtBqKakw55ImbNt3FuC2zXdi6F14OOcBs/Yti
         uK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695948143; x=1696552943;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LHnl2CsLxrfQz4bzbwJAj223y7XyxSn5JpaUfYsfSDE=;
        b=BXQb3OrMNr5p0eSK0kwCq1Mvm/AkH7mQLZGrrySQUM7oKfDg7JCsLEW5XQ/DsafN4K
         i6MgqQvv3akGeFExu99S8ijB1Dh85hFigwm4mthhYUcLnA043JM2yfIzsZ4lBvkLQIc1
         lJ9LbqSwRHyVEDpRHLzcQ+/w6Nua3iouHda4lkyWHMd7+g/FTu6UEuHRAFAZbxEb3wSt
         VBir53TT6oPheDj0nz7E5QFs8vhFlBf0w8ZujaNNjY/dpBW4wbTmQisQkpuOuFdNk5wT
         eFMeHEbSxv7yu77ZCkPGU0DzwP2oiJdZPYWtCQhb9+ktiDm5RwIJz+jnDWqpz/0sh7Pq
         apIQ==
X-Gm-Message-State: AOJu0Yx4OBrxRYTRJgSnCQ08Iqkq9cg9rP6yHfw+eKOuiMVCbDWQpgzE
	xZ/RacnP/qBdOjSNrRxS3zp8GyH5etc=
X-Google-Smtp-Source: AGHT+IHUEPW3H4eE8hL9x01DrF8EV6/qXIdYZHJV+3Ch6SWg/Ia5upLk5S9Kq+TjsAHT50edQJbCK+giAKY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e851:b0:1c6:2b9d:570b with SMTP id
 t17-20020a170902e85100b001c62b9d570bmr34467plg.7.1695948142799; Thu, 28 Sep
 2023 17:42:22 -0700 (PDT)
Date: Thu, 28 Sep 2023 17:42:20 -0700
In-Reply-To: <20230928173354.217464-3-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230928173354.217464-1-mlevitsk@redhat.com> <20230928173354.217464-3-mlevitsk@redhat.com>
Message-ID: <ZRYdbJNY3ldYKgEk@google.com>
Subject: Re: [PATCH v2 2/4] x86: KVM: SVM: add support for Invalid IPI Vector interception
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
> In later revisions of AMD's APM, there is a new 'incomplete IPI' exit code:
> 
> "Invalid IPI Vector - The vector for the specified IPI was set to an
> illegal value (VEC < 16)"
> 
> Note that tests on Zen2 machine show that this VM exit doesn't happen and
> instead AVIC just does nothing.
> 
> Add support for this exit code by doing nothing, instead of filling
> the kernel log with errors.
> 
> Also replace an unthrottled 'pr_err()' if another unknown incomplete
> IPI exit happens with vcpu_unimpl()
> 
> (e.g in case AMD adds yet another 'Invalid IPI' exit reason)
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
