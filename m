Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035681FDC
	for <iommu@lists.linux.dev>; Fri,  8 Dec 2023 23:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BekHBSob"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702077388; x=1733613388;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lrkQgErWxcsZqBk5WmhIoSbSMmbYCndRvIe0pEDMALU=;
  b=BekHBSobLZraC6ncHb7g6OINonqvji0EUe//7QrpfpUVRUylSY3T7nTA
   uDP9JLgLR6uUoBMFs9ZBZj26vvBck0EdO+7nkCENZy2NJ0WLtce72goI6
   0BWgx/dmsv9EHEI2JAWCvrn8jgfdQBlI9HxWp3wiope59kj2TFGK8ROv2
   +mkNAz8zGO60XcsfXIeQb5UT16m4RkWJtvWQsKarED/8vRBT4DcY0oK7k
   uxceqFPImdbMXSfB2LRkMN3hnU4PXN7fDlyklwqJohGW5hk1tWTZ1Zpap
   u1OUUmisYGEpOW6gITFlKOiT0HGi8ugsUpdmj7DNUlanaJ6h/LImyTmkK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="1328111"
X-IronPort-AV: E=Sophos;i="6.04,262,1695711600"; 
   d="scan'208";a="1328111"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 15:16:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="1103722427"
X-IronPort-AV: E=Sophos;i="6.04,262,1695711600"; 
   d="scan'208";a="1103722427"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 15:16:24 -0800
Date: Fri, 8 Dec 2023 15:21:16 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, X86 Kernel <x86@kernel.org>,
 iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>,
 kvm@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>, Joerg Roedel
 <joro@8bytes.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov
 <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, Raj Ashok
 <ashok.raj@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 maz@kernel.org, peterz@infradead.org, seanjc@google.com, Robin Murphy
 <robin.murphy@arm.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH RFC 01/13] x86: Move posted interrupt descriptor out of
 vmx code
Message-ID: <20231208152116.1c09a17c@jacob-builder>
In-Reply-To: <875y19t507.ffs@tglx>
References: <20231112041643.2868316-1-jacob.jun.pan@linux.intel.com>
	<20231112041643.2868316-2-jacob.jun.pan@linux.intel.com>
	<87wmtruw87.ffs@tglx>
	<20231207205431.75a214c2@jacob-builder>
	<875y19t507.ffs@tglx>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Fri, 08 Dec 2023 10:31:20 +0100, Thomas Gleixner <tglx@linutronix.de>
wrote:

> On Thu, Dec 07 2023 at 20:54, Jacob Pan wrote:
> > On Wed, 06 Dec 2023 17:33:28 +0100, Thomas Gleixner <tglx@linutronix.de>
> > wrote: =20
> >> On Sat, Nov 11 2023 at 20:16, Jacob Pan wrote:
> >> 	u32			rsvd[6];
> >> } __aligned(64);
> >>  =20
> > It seems bit-fields cannot pass type check. I got these compile error. =
=20
>=20
> And why are you telling me that instead if simply fixing it?
My point is that I am not sure this change is worthwhile unless I don't do
the per CPU pointer check.

gcc cannot take bit-field address afaik. So the problem is that with this
bit-field change we don't have individual members anymore to check pointers.

e.g.
./include/linux/percpu-defs.h:363:20: error: cannot take address of
bit-field =E2=80=98nv=E2=80=99 363 |  __verify_pcpu_ptr(&(variable)); =20


Thanks,

Jacob
