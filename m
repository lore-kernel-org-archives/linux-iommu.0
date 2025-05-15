Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B7E288531
	for <iommu@lists.linux.dev>; Thu, 15 May 2025 22:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747346746; cv=none; b=rAXS90dL1kZ5deVozq8Q+Zrnpb4KvwsvtPyaf/MTw66sewe6N8+thf3UO4VNukYxLKJbteU1j5QsiFHRXIsEQDhR//7+HfNEBP6+8bvHStJUCzFtMPSPD1PwiTgioTA+9CMDljYg53GMGhfjYfmpbGArmmwLJfiwB7qBMdJQ2go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747346746; c=relaxed/simple;
	bh=R04t5OP7VoRR7an/K/mH1NZqJb80IHwLckbbrUiaTWY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VZmmG+0DRc0eATjsUdRCq6cDMljLdJsc+5W0X+uzGoMWMZYJ2vMG3tIjTuKqLgsCxYVo7oMyCQaPDPtklnSEo0fzKaYYegQZXsCazVA+ocvKpq0pBTqEiIPwtikPjeTyH6NI+1hiu+OBXGxVKaIbAEV2sdMvEPssfpPt+WLvDpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ph2Hhf4G; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ph2Hhf4G"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b26e278dd1aso537341a12.1
        for <iommu@lists.linux.dev>; Thu, 15 May 2025 15:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747346743; x=1747951543; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Oi7sS9/hL2apZcsFxNVWjiM0xG6d7sH4nOsxyAerdW0=;
        b=ph2Hhf4Ga9UwLLnNkPpLUv+/qpKfHKhLH2pF21FRgHWGzOupozx6FpDLoXw6/X1Hsd
         oyaVnVbChjC38UzOpDcpoSvuRT4kriQ4l0gm8uzjAToXvirtndjQxBkY59FMeBN2u/e3
         OMjMmhNZUxHSrDuIpy/Vaq++vf+gKVYIKpA08l+T4TTbU7j53aYplr/imVRv7A78R8J8
         F/qVSfKJX2FlDlcXvZJs5u/8GPnTsWElWxnxV5JkIURcX5EkUze1vrIoW6duJ4NXiLTJ
         r2JffEI/YA4brH9DSq7LvDHqS2LUkl94+3aAWRIXDXUQnKYNvMAmKMgqyMtH+NJ9K2e3
         Q9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747346743; x=1747951543;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oi7sS9/hL2apZcsFxNVWjiM0xG6d7sH4nOsxyAerdW0=;
        b=v0Eu9jj0trym+EvwBQbpHDv4lBGpUIIMLbn6mloPVQiRVzj79Ya+7DSQt1M326mAqA
         xm1S5N4Er8Uy2lap/wPQ+s/F7lcRWyjzngT5o+EGRMM7uomxhGLdw9RhyTSTjxOfdgQw
         26iFuFzoXPjHoCbJimBOzcZ+B7cguztBIPTuFvuN4w9jm1dUFO5Mh9WG5pNv3gvMDC9k
         PHYN7dyojBT8/ldjxY7zI5tS5ou68+gfPHuEQHT91eFW8OW5hQhnSLzholUGRp00c9dQ
         myI4ogsHf1COG5ERb/7PH0YCbHykrDEeqOyNsTr85TIPNWRZhjOzfjOVcvRoc2+I24jT
         qzLg==
X-Forwarded-Encrypted: i=1; AJvYcCUCLUsSJF/IdN06yCsQtJPgTlNmbTmCGY/jZgtlwepcXCmrFg21ACut5w1G4IKLM8R1BhSwKA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyt5jurPY3AyMKzcn68dLOLLY1GDPb+2AmfZZEM/N6jXkSL24r+
	+2vUxGWAysf/CXKm7YM6jT9DD20YXLgj/GEPjdr0tt2Go7Pw8is8XzHtCRPGP+gNE/eTZ3JMLVp
	4dkgpxg==
X-Google-Smtp-Source: AGHT+IFsAyQHkBD9JIcdxXmgn3lyYCeVd2u7vwK18dv1Rs4/Dq4Q7I3Qiz7gFrycKUxrAq6vHuxsB5iwTcg=
X-Received: from pjbqc9.prod.google.com ([2002:a17:90b:2889:b0:2f9:e05f:187f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1dd1:b0:2ff:784b:ffe
 with SMTP id 98e67ed59e1d1-30e7d522171mr1418806a91.11.1747346743464; Thu, 15
 May 2025 15:05:43 -0700 (PDT)
Date: Thu, 15 May 2025 15:05:41 -0700
In-Reply-To: <20250515120804.32131-1-sarunkod@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com> <20250515120804.32131-1-sarunkod@amd.com>
Message-ID: <aCZlNYlhSKXRFvnc@google.com>
Subject: Re: [PATCH 00/67] KVM: iommu: Overhaul device posted IRQs support
From: Sean Christopherson <seanjc@google.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: baolu.lu@linux.intel.com, dmatlack@google.com, dwmw2@infradead.org, 
	iommu@lists.linux.dev, joao.m.martins@oracle.com, joro@8bytes.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mlevitsk@redhat.com, 
	pbonzini@redhat.com, vasant.hegde@amd.com, suravee.suthikulpanit@amd.com, 
	naveen.rao@amd.com
Content-Type: text/plain; charset="us-ascii"

On Thu, May 15, 2025, Sairaj Kodilkar wrote:
> Hi Sean,
> 
> We ran few tests with following setup

A few!!?!?  This is awesome!  Thank you, I greatly appreciate the testing!

> * Turin system with 2P, 192 cores each (SMT enabled, Total 768)
> * 4 NVMEs of size 1.7 attached to a single IOMMU
> * Total RAM 247 GiB
> * Qemu version : 9.1.93
> * Guest kernel : 6.14-rc7
> * FIO random reads with 4K blocksize and libai
> 
> With above setup we measured the Guest nvme interrupts, IOPS, GALOG interrupts
> and GALOG entries for 60 seconds with and without your changes.
> 
> Here are the results,
> 
>                           VCPUS = 32, Jobs per NVME = 8
> ==============================================================================================
>                              w/o Sean's patches           w/ Sean's patches     Percent change
> ----------------------------------------------------------------------------------------------
> Guest Nvme interrupts               123,922,860                 124,559,110              0.51%
> IOPS (in kilo)                            4,795                       4,796              0.04%
> GALOG Interrupts                         40,245                         164            -99.59%
> GALOG entries                            42,040                         169            -99.60%
> ----------------------------------------------------------------------------------------------
> 
> 
>                 VCPUS = 64, Jobs per NVME = 16
> ==============================================================================================
>                              w/o Sean's patches           w/ Sean's patches     Percent change
> ----------------------------------------------------------------------------------------------
> Guest Nvme interrupts               99,483,339                   99,800,056             0.32% 
> IOPS (in kilo)                           4,791                        4,798             0.15% 
> GALOG Interrupts                        47,599                       11,634           -75.56% 
> GALOG entries                           48,899                       11,923           -75.62%
> ----------------------------------------------------------------------------------------------
> 
> 
>                 VCPUS = 192, Jobs per NVME = 48
> ==============================================================================================
>                              w/o Sean's patches          w/ Sean's patches      Percent change
> ----------------------------------------------------------------------------------------------
> Guest Nvme interrupts               76,750,310                  78,066,512               1.71%
> IOPS (in kilo)                           4,751                       4,749              -0.04%
> GALOG Interrupts                        56,621                      54,732              -3.34%
> GALOG entries                           59,579                      56,215              -5.65%
> ----------------------------------------------------------------------------------------------
>  
> 
> The results show that patches have significant impact on the number of posted
> interrupts at lower vCPU count (32 and 64) while providing similar IOPS and
> Guest NVME interrupt rate (i.e. patches do not regress).
> 
> Along with the performance evaluation, we did sanity tests such with AVIC,
> x2AVIC and kernel selftest.  All tests look good.
> 
> For AVIC related patches:
> Tested-by: Sairaj Kodilkar <sarunkod@amd.com>
> 
> Regards
> Sairaj Kodilkar
> 
