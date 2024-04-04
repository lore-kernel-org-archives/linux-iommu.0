Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ECE12BEA7
	for <iommu@lists.linux.dev>; Thu,  4 Apr 2024 17:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712250792; cv=none; b=hnTnQ3KmpNJsMuR7xp3gw5E45SSazTV8DyZjI8hkbEsHdbyVmZnqGDEG1GJKog/3BG3WotaxzzR/zBPkHx8tPv7LMoGrppNR0XKS7jOgBTh81cfoCUKV0ysvWJI8OEDcA7USdyUQ3T5A5A9X20/iFZURrKVb/Kwpy5oXQZenK/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712250792; c=relaxed/simple;
	bh=Dlr+aCFuoxfoWJLhEEPEJmaI0L43dBfu9cHqUL4lZ9c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HW7zKNpOGB2XfPj9JiU2DjHRA+RdqtSIpG6RvGXUEgiC+mYNQ6fKG78xnX91qCiHq+RN6OyQTVmqb3UJWOttnYlLJHO2Mzc8GkpWIyTLnx+2VLtmRbCPzmbNNbTgmPhRMaKPjfQkGyADsHoisc4d6g67F+MFiO4FIpGr8ph8GBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lga1EpiR; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lga1EpiR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712250790; x=1743786790;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dlr+aCFuoxfoWJLhEEPEJmaI0L43dBfu9cHqUL4lZ9c=;
  b=Lga1EpiRtfAqsXLK08fO1lDl30cK1LcqSk1S15uEYITkaXTsNrai+SnW
   +jaZyJo+qnr0xLIfDqXAjpuJzEg4W2CHtgo8AHtjWE0nzhLv8hhFIAK6G
   fQxoJzNpVXgr2NGmwMtkfLmJC6J6KSw7QJt1tqKgfJ0G/S0iIliWhlQkX
   rD3CXyf8MMiCgL76M9nz/oqiZW0YhzWeNVYKm3nR9m9+dQb0VV8aPaep0
   sqThTR7WOuumdbYhuRETKhqWt00sbMygQyp5cDQMGKHejTNur7bHACDCm
   D8b6yxIkr9vJTfJcE41BmDUFo6aReHfXNrdtxY9oArn5WL2iyIcwlVz1W
   Q==;
X-CSE-ConnectionGUID: EsuRIcp+R8+ca+OzHUrE7Q==
X-CSE-MsgGUID: pW1wgR3HQxO9BdAEOy0kTA==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="25058754"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="25058754"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 10:13:09 -0700
X-CSE-ConnectionGUID: YvT/tSvUSe2R+yQRAF8VxA==
X-CSE-MsgGUID: eiA5oN3tS7aoaA6Umgebjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="18773748"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 10:13:08 -0700
Date: Thu, 4 Apr 2024 10:17:35 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Robert Hoo <robert.hoo.linux@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, X86 Kernel <x86@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, iommu@lists.linux.dev, Thomas Gleixner
 <tglx@linutronix.de>, Lu Baolu <baolu.lu@linux.intel.com>,
 kvm@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>, Joerg Roedel
 <joro@8bytes.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov
 <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, Paul Luse
 <paul.e.luse@intel.com>, Dan Williams <dan.j.williams@intel.com>, Jens
 Axboe <axboe@kernel.dk>, Raj Ashok <ashok.raj@intel.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, maz@kernel.org, seanjc@google.com, Robin Murphy
 <robin.murphy@arm.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 05/15] x86/irq: Reserve a per CPU IDT vector for posted
 MSIs
Message-ID: <20240404101735.402feec8@jacob-builder>
In-Reply-To: <9734e080-96e4-4119-8ae6-28abb7877a3c@gmail.com>
References: <20240126234237.547278-1-jacob.jun.pan@linux.intel.com>
	<20240126234237.547278-6-jacob.jun.pan@linux.intel.com>
	<9734e080-96e4-4119-8ae6-28abb7877a3c@gmail.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Robert,

On Thu, 4 Apr 2024 21:38:34 +0800, Robert Hoo <robert.hoo.linux@gmail.com>
wrote:

> On 1/27/2024 7:42 AM, Jacob Pan wrote:
> > When posted MSI is enabled, all device MSIs are multiplexed into a
> > single notification vector. MSI handlers will be de-multiplexed at
> > run-time by system software without IDT delivery.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >   arch/x86/include/asm/irq_vectors.h | 9 ++++++++-
> >   1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/include/asm/irq_vectors.h
> > b/arch/x86/include/asm/irq_vectors.h index 3a19904c2db6..08329bef5b1d
> > 100644 --- a/arch/x86/include/asm/irq_vectors.h
> > +++ b/arch/x86/include/asm/irq_vectors.h
> > @@ -99,9 +99,16 @@
> >   
> >   #define LOCAL_TIMER_VECTOR		0xec
> >   
> > +/*
> > + * Posted interrupt notification vector for all device MSIs delivered
> > to
> > + * the host kernel.
> > + */
> > +#define POSTED_MSI_NOTIFICATION_VECTOR	0xeb
> >   #define NR_VECTORS			 256
> >   
> > -#ifdef CONFIG_X86_LOCAL_APIC
> > +#ifdef X86_POSTED_MSI  
> 
> X86_POSTED_MSI --> CONFIG_X86_POSTED_MSI?
Indeed, thanks for catching that!

> > +#define FIRST_SYSTEM_VECTOR
> > POSTED_MSI_NOTIFICATION_VECTOR +#elif defined(CONFIG_X86_LOCAL_APIC)
> >   #define FIRST_SYSTEM_VECTOR		LOCAL_TIMER_VECTOR
> >   #else
> >   #define FIRST_SYSTEM_VECTOR		NR_VECTORS  
> 


Thanks,

Jacob
