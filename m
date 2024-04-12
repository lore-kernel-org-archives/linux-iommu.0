Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904FE14D44F
	for <iommu@lists.linux.dev>; Fri, 12 Apr 2024 18:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712945941; cv=none; b=OGLgOgzSRkSng0pavjcpsHtHXvjZnImVKphI7vTY/ZBkURMiVFCkAJX4/C1A8RDc2lziMN7VlP2Fy4AqT+e52GZZu+7gZhwNigvukwQtpDq0ONcmRqerX7dlCNHAz2CgsCK9epEmK23wklroYhsKMVZIMKgoNx+Ln41TclSZ3+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712945941; c=relaxed/simple;
	bh=qcfdW48aCV8kl2oRwl5wUXBZK6N010eZxw0UUUS0LKk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ienWCaW78/eDv/yW6BINJ9TjeVx2kk9Uz2t9c7sReELIGBnQyiMu5B+CCbGgbPHtbxjkUveaS42C6pweuVx+bWWMrvYctqjGuRPRMvuhzbdxEHPk1FV803op7je8kOjCFRmLW4CBZ8OCYSqqGkVtR8sTkuH+d0WO8FiHjyfGCSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K/aj0R8O; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K/aj0R8O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712945940; x=1744481940;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qcfdW48aCV8kl2oRwl5wUXBZK6N010eZxw0UUUS0LKk=;
  b=K/aj0R8Oigo8kB/u6g5F8z3pAWu7f8DEhTl+pKIPsY7h4C/b+cm3wsOx
   yYwxYCSObhJGjxfUMzOpyYKhQXuB3pVSi0mwgt7abBx6YY813Nuc47TzX
   Yed+5pJ11dOVg8LipbO5O2LBHj2kyWEpXBaeCA4YF+0Pw14NCfWLZz/HO
   NGRSOzhtytiqueiN0ihQkGxmqYeMtT5MGHobKdNJGmgTXjEZzIsZBnNr+
   kaZH1f825rf8Qp70KvUSepoi+Y6nRjj4DC/CLXjSRceYPmyl6TIpPrhSZ
   l5Af8PKpmkayB6nJxtx79RVQ4QNyK6nlawglKINXeKiKCfjkCj3Y+uGf0
   g==;
X-CSE-ConnectionGUID: 47kVlU4vSQOtil1ri6O97Q==
X-CSE-MsgGUID: RQ1O0capSF2rCGOSOeNUrQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="12261429"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="12261429"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 11:19:00 -0700
X-CSE-ConnectionGUID: taCPYSIGSIW2vzeZM8SWig==
X-CSE-MsgGUID: uApujCAuS+uPPT+UvKgEGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="21869422"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 11:18:59 -0700
Date: Fri, 12 Apr 2024 11:23:31 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, X86 Kernel <x86@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Thomas Gleixner <tglx@linutronix.de>, Lu Baolu
 <baolu.lu@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Hansen, Dave" <dave.hansen@intel.com>, Joerg Roedel <joro@8bytes.org>, "H.
 Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Ingo Molnar
 <mingo@redhat.com>, "Luse, Paul E" <paul.e.luse@intel.com>, "Williams, Dan
 J" <dan.j.williams@intel.com>, Jens Axboe <axboe@kernel.dk>, "Raj, Ashok"
 <ashok.raj@intel.com>, "maz@kernel.org" <maz@kernel.org>,
 "seanjc@google.com" <seanjc@google.com>, Robin Murphy
 <robin.murphy@arm.com>, "jim.harris@samsung.com" <jim.harris@samsung.com>,
 "a.manzanares@samsung.com" <a.manzanares@samsung.com>, Bjorn Helgaas
 <helgaas@kernel.org>, "Zeng, Guang" <guang.zeng@intel.com>,
 "robert.hoo.linux@gmail.com" <robert.hoo.linux@gmail.com>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 10/13] x86/irq: Extend checks for pending vectors to
 posted interrupts
Message-ID: <20240412112331.5a3c1d18@jacob-builder>
In-Reply-To: <BN9PR11MB5276215478903C50701D05498C042@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240405223110.1609888-1-jacob.jun.pan@linux.intel.com>
	<20240405223110.1609888-11-jacob.jun.pan@linux.intel.com>
	<BN9PR11MB5276215478903C50701D05498C042@BN9PR11MB5276.namprd11.prod.outlook.com>
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

Hi Kevin,

On Fri, 12 Apr 2024 09:25:57 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Saturday, April 6, 2024 6:31 AM
> > 
> > During interrupt affinity change, it is possible to have interrupts
> > delivered to the old CPU after the affinity has changed to the new one.
> > To prevent lost interrupts, local APIC IRR is checked on the old CPU.
> > Similar checks must be done for posted MSIs given the same reason.
> > 
> > Consider the following scenario:
> > 	Device		system agent		iommu
> > 	memory CPU/LAPIC
> > 1	FEEX_XXXX
> > 2			Interrupt request
> > 3						Fetch IRTE	->
> > 4						->Atomic Swap
> > PID.PIR(vec) Push to Global
> > Observable(GO)
> > 5						if (ON*)
> > 	i						done;*  
> 
> there is a stray 'i'
will fix, thanks

> 
> > 						else
> > 6							send a
> > notification ->
> > 
> > * ON: outstanding notification, 1 will suppress new notifications
> > 
> > If the affinity change happens between 3 and 5 in IOMMU, the old CPU's
> > posted
> > interrupt request (PIR) could have pending bit set for the vector being
> > moved.  
> 
> how could affinity change be possible in 3/4 when the cache line is
> locked by IOMMU? Strictly speaking it's about a change after 4 and
> before 6.
SW can still perform affinity change on IRTE and do the flushing on IR
cache after IOMMU fectched it (step 3). They are async events.

In step 4, the atomic swap is on the PID cacheline, not IRTE.


Thanks,

Jacob
