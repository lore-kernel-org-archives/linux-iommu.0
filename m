Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A98F4687
	for <iommu@lists.linux.dev>; Wed, 17 Apr 2024 00:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713314080; cv=none; b=rrXGnxLZbEGSYPGE5JW4IdTJMXfjkV/bvUaxNhPKMQXw683ZAuVX0m1ZI+5+KK6d3/0JT00pwGHe/fHBZ3LjltAJytj7b5HpjF89eBJM8vx50YqR1YhSKtD8kvexSRwvHKqy6pntKUlgd2BUDBr6wMFkqdzANUrtjzjUR5dyba8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713314080; c=relaxed/simple;
	bh=QcQ5CwIdJPBpAiEUOMxmQT8OLzK8+XohcwiHGYdlD08=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sOqNr4BRYk2WmnvtWognj5qC/udSCnpxZ1gO+X95JBe+7e3ly/+NfM75+B4Id/RchG8BW+t0aDs7qkg4+lZxYNvOI6+t9yCqqnXJJrHLb6czXUx25GQfVPzjuWSzfRz90fp/Wh2V0yeyJewrexBpTEWTHR0FwwilMZDl8ogh2d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YPNH2Q2x; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YPNH2Q2x"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61afa79081dso16302997b3.2
        for <iommu@lists.linux.dev>; Tue, 16 Apr 2024 17:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713314078; x=1713918878; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yKCPeGd9SYcDB4rlgTO3GZ6PUnpW3Lm5DsYKGNpWRYU=;
        b=YPNH2Q2xSQlTbFtsy8Hm+1dGAJ0HdwGuoLNOL2kmYoUkgK1AtYgJG6Z9Qm4N9Low2+
         ttUrlNNE39O7xQXXw8qZfwmMciAQIxPN0CvNOmbceu3N6Vnmk1kUCIcYfSR7C+MDzPDD
         VL8UWJ4VUzPiZmNrkjYch2zFMH8IxRUi7iIXSZd0sNicELjbMhD8Uj3S0me2ap6sS5ez
         FxazABJ7/TrCMzb1GBBCru7qnL1TF8ZqSzP+6IWvrohtJzHjn4RDZtAL8rHUQOOlZVWF
         oYUrVJ3okr50yUXcevCOlG3G+ENrQF/CxK2HKmUeRNVaAldCG0wrAx15urn5MLn7vv0J
         FaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713314078; x=1713918878;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yKCPeGd9SYcDB4rlgTO3GZ6PUnpW3Lm5DsYKGNpWRYU=;
        b=U/dF4xXrskHuTGBPjpGBGyM3xhlyaHBzCl0jGzcC1eDiHB/5CnR9BYuyFCgwyGpPrw
         KfAK8b1S1JZK9cciyonnbDcsrQ6jhIE2j1HBwg17yBhfZgAXarRl6I9oiEsTa2nxrnlZ
         ipqT8R9LMLSUcYb44AtD6AFoWaFqeTz6WVbnNpzzo8hCfGxUfHzKtkZlLKakXT27glOH
         c4qLoR3Rt8uNCPHAGf0DQDeci+81taOQk8AdLNaztf15joj+QOGiwZWtdXySEJKv8/3E
         db9N91AamKurdxDwRgzBVdeMBckOKkIUNqL7B5phV3+LEInC0hzC0NaRFKqsgJNmJUhZ
         jgoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKuHo0U/ap97AjKqyvwDzZffEN20Nmmf7eazn/dy7uQsgvc1jwGTRtJHFbcy6vyezV0Zg7Rki6647x6za3glCmyHD9HUk=
X-Gm-Message-State: AOJu0Yzke9KvkJUOmMGWCAjEdT8jn0ZY4T0zSL/Bcl7IuKBA7juQpPUw
	nt030pueVw0uyY6TUrCEcs398XgZRb45GZKs1x3HAItW5kqK6L0YWrIaBTLVzSfYbGWEy5N9lEj
	w/A==
X-Google-Smtp-Source: AGHT+IGEjrPNgrfTQIQLaRwbEsHxol7QnWaKIZ3J4/4PrcaZUAePBGJtWepwBEycSYnoXivT9VAJAYBVrW8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:1883:0:b0:dd9:312c:83c8 with SMTP id
 125-20020a251883000000b00dd9312c83c8mr1574843yby.10.1713314078597; Tue, 16
 Apr 2024 17:34:38 -0700 (PDT)
Date: Tue, 16 Apr 2024 17:34:36 -0700
In-Reply-To: <20240405223110.1609888-2-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240405223110.1609888-1-jacob.jun.pan@linux.intel.com> <20240405223110.1609888-2-jacob.jun.pan@linux.intel.com>
Message-ID: <Zh8ZHPUlQk4niS7k@google.com>
Subject: Re: [PATCH v2 01/13] x86/irq: Move posted interrupt descriptor out of
 vmx code
From: Sean Christopherson <seanjc@google.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, X86 Kernel <x86@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, iommu@lists.linux.dev, 
	Thomas Gleixner <tglx@linutronix.de>, Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Joerg Roedel <joro@8bytes.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, 
	Paul Luse <paul.e.luse@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
	Jens Axboe <axboe@kernel.dk>, Raj Ashok <ashok.raj@intel.com>, Kevin Tian <kevin.tian@intel.com>, 
	maz@kernel.org, Robin Murphy <robin.murphy@arm.com>, jim.harris@samsung.com, 
	a.manzanares@samsung.com, Bjorn Helgaas <helgaas@kernel.org>, guang.zeng@intel.com, 
	robert.hoo.linux@gmail.com
Content-Type: text/plain; charset="us-ascii"

"KVM" in the scope would be nice.

On Fri, Apr 05, 2024, Jacob Pan wrote:
> To prepare native usage of posted interrupt, move PID declaration out of
> VMX code such that they can be shared.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  arch/x86/include/asm/posted_intr.h | 88 ++++++++++++++++++++++++++++
>  arch/x86/kvm/vmx/posted_intr.h     | 93 +-----------------------------
>  arch/x86/kvm/vmx/vmx.c             |  1 +
>  arch/x86/kvm/vmx/vmx.h             |  2 +-
>  4 files changed, 91 insertions(+), 93 deletions(-)
>  create mode 100644 arch/x86/include/asm/posted_intr.h

Acked-by: Sean Christopherson <seanjc@google.com>
