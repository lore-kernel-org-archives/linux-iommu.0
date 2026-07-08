Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0364137D13D
	for <iommu@lists.linux.dev>; Wed,  8 Jul 2026 13:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783517823; cv=none; b=iNPEJWNuI9NO3cavG4MH1n9uJevytgrwwCNnQmxGaLllA031SaAD1ouIc0/r17fvCq4oqhm8PzQnKh3OkRUxVJHIn/xhcNDJtjQSlxs47bqeTIlT5nVh44Sfvte3RfAISRFJaUCC/rJc8XEu01Vqwf2CdtlD/RLP74oxKDC9Le0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783517823; c=relaxed/simple;
	bh=ZUfzfufgjJ31Y7uHVmkfFwyDJ0sSSswvR+cTuDCSQLM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ai/+BuR00UMUKznxdw64LiQnm+Cg6eteb62GMci0Alc7dsXR1YI0jcSVvmGU/i29SoELKxXfWchNk/wXPl7a5pglWZQ2qYZ4dgjdWz6M8Zbc+ym9SK7ycZtFv/xzbzGySzO1dB7FwzMwdz+84BoprhJbRAKBIcWaQbb6X/3fIqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pbaPCc7u; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pbaPCc7u"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2cc7e86e7c5so13289895ad.3
        for <iommu@lists.linux.dev>; Wed, 08 Jul 2026 06:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783517821; x=1784122621; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ju8RR0gs85gkVW7Nu9aVEZ9OpFpwktbUMsaRuItgRhY=;
        b=pbaPCc7uquvuLc78T6o1a97cACqn816unpl6Ol4L5V0qDxLDPEts1fvjdmJM+0lW+1
         JGHxLNg+sRDzQydy1ANUXtCtJr9N6SK1d+F+FS2QMIlNmWSWH3tm4bAaXvEButnJb57S
         kLl3bnnXYpotBaRdy3iJgpqMdprKxuRBwIp6uB9Vke8Hqy6MSKnB4cDpNhjJqeQ16DH4
         SUn6W5ZDhhIiMWAyCtQB13eDccGIuO/DK8pBMWTHKXFKIGaAqYtg3V0L1PxSoaMIuHqj
         0UogjdeNVVbNNcTZeqi2/5w935FHvyM49s/z5mSMeeA8JXxKFZLy9iQCxBumos741W1n
         NuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783517821; x=1784122621;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ju8RR0gs85gkVW7Nu9aVEZ9OpFpwktbUMsaRuItgRhY=;
        b=duj4fiiPzrO6jJ17GOIrxpIcPoXoyNSUJBfVvsyMk4DGWyNYlt/EprnOB4+eRz5Ffj
         FMrZ0qxbR0Uo5CZOlwMr/t/Y2MLrOyBVfoUsOuH6v+WHGWTIbFbTYTK6t/KC1t+tYeLP
         N4NaUZJbt5O525DVl1kZR+V0LbAPS7O7Jr/1c7XPrbEIzBatVgiN2HIt5jWTHVLHRgc8
         39eM+jBaNAikGN9XK8HLIUYO4Hqfr27yDkYG/VB0OMzP4sGheJKqLltAaRFuR4I5MWJ9
         KK8LLCFfawLa1kGqDqdI1AD+7H0NNzzhUYa1e3V3d77djFDzkka4yTzkYrs1J/hbF6v6
         AgEQ==
X-Forwarded-Encrypted: i=1; AHgh+RoJ82aq1AytW0fZ2P54TxZD98UeDbI2Rem5NGXPzOCEs6qGraHSmNK2F2PUp7XAx8iRpNKDIg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw15KnWLQtnA1Vbl/R8LCT8GWek5nL101jYm6zGV6Sts6OdW776
	afGvIpWNvAubYCeuU7Ou9uBOXmqoZdD9FTdeWJqcLQHWdAkJKrxFmIKgX6sYwXVCl5h4i36v3v2
	Y30xzKg==
X-Received: from plbkm4.prod.google.com ([2002:a17:903:27c4:b0:2cc:e88e:4245])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e80d:b0:2cc:db71:4db5
 with SMTP id d9443c01a7336-2ccea461f0bmr28965095ad.37.1783517819391; Wed, 08
 Jul 2026 06:36:59 -0700 (PDT)
Date: Wed, 8 Jul 2026 06:36:58 -0700
In-Reply-To: <20260708091408.12106-4-sarunkod@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260708091408.12106-1-sarunkod@amd.com> <20260708091408.12106-4-sarunkod@amd.com>
Message-ID: <ak5SemBa0O0qrfWk@google.com>
Subject: Re: [RFC PATCH v2 3/5] kvm/svm: Introduce per-CPU lock and wakeup queue
From: Sean Christopherson <seanjc@google.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Robin Murphy <robin.murphy@arm.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Thomas Gleixner <tglx@kernel.org>, 
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2026, Sairaj Kodilkar wrote:
> Add a per-CPU list and raw spinlock that SVM will use to track vCPUs
> blocked and waiting for a wakeup.  The GAPPI interrupt handler will
> scan the corresponding CPU=E2=80=99s list to decide which vCPU to run.
> Initialize both in avic_hardware_setup() when AVIC is enabled.

This needs to be squashed with patch 4.  It's useless and unreviewable as a
standalone patch.
