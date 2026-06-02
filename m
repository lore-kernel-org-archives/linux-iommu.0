Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CD5279358
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 04:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780375518; cv=none; b=B0tMsYDSUi8AUONuBC2BhanTOnfriNXsX82tpQYKtdHGJlVMG8GWY8Wv+n+QJoxaSZ45lI1dljTkvvRznOz+wikkNdJN+1I2KxvKptOikxxtRdKLCOhtELexNbRsDBg9XML8PQjbLP9udHmAM1SbcaJ2J+gUMyWGIKAfzactN2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780375518; c=relaxed/simple;
	bh=NU2InMd2qFqEIQ3pfIJSmH2p69ilkd+5wYbtLCWISxc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t7jmiSdbtUerCSNT5qdNlO39+oae4jUXmuhBfZc5z1wiNgdYMK0b4FERcoPKDnLGyeTBOS2Hl51B+aGxAhcHYm508eQixU5ev2AKoiLsFMPOnJCsbFVzxlwtf/Jf2Abd1p6YXNlVO+ZCFhXIdqXkEAberF4CziAiWU7EC3ibjoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=G4IeYTym; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="G4IeYTym"
Received: from localhost (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5C21520B7167;
	Mon,  1 Jun 2026 21:45:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5C21520B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780375502;
	bh=0YUGV5AVKYMgyVYyhM0aOMceY+JJ7zFK/zoC3DgTEKU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G4IeYTymkO/bsqSHVdgccQC7wBVed5Hl/boW6p6wS3txFXOS7lN7nuIrvii6Sv4Hk
	 pc3pjsLz2QYk/a9sGNuY4pw9pZeBpeFLr58QxFh5NxHZlPk5vcx7mMkWlmxd9q+pQ8
	 Zlhhz0ETliIj7kVGolcTwmHS0jdndibyiEFgoIek=
Date: Mon, 1 Jun 2026 21:45:14 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 mhklinux@outlook.com, wei.liu@kernel.org, zhangyu1@linux.microsoft.com,
 schakrabarti@linux.microsoft.com, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH V1] iommu/hyperv: Create hyperv subdirectory under
 drivers/iommu
Message-ID: <20260601214514.00003833@linux.microsoft.com>
In-Reply-To: <99bc22c3-0fa9-044d-071c-53cc8c2b7548@linux.microsoft.com>
References: <20260529014148.297154-1-mrathor@linux.microsoft.com>
	<20260601090735.00005f55@linux.microsoft.com>
	<99bc22c3-0fa9-044d-071c-53cc8c2b7548@linux.microsoft.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Mukesh,

On Mon, 1 Jun 2026 14:23:18 -0700
Mukesh R <mrathor@linux.microsoft.com> wrote:

> >> diff --git a/drivers/iommu/hyperv/Makefile
> >> b/drivers/iommu/hyperv/Makefile new file mode 100644
> >> index 000000000000..0053e00e08e6
> >> --- /dev/null
> >> +++ b/drivers/iommu/hyperv/Makefile
> >> @@ -0,0 +1,2 @@
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +obj-$(CONFIG_IRQ_REMAP) += hv-irq-remap.o  
> > Should the name be x86 specific? This file will never be built for
> > ARM because:
> >   CONFIG_IRQ_REMAP depends on:
> >   depends on X86_64 && X86_IO_APIC && PCI_MSI && ACPI
> > 
> > perhaps, hv-x86-irq-remap.c? hv-irq-remap.c sounds like a
> > generic Hyper-V IRQ-remapping backend and may be misleading once
> > arm64 Hyper-V IOMMU/interrupt support grows under this directory.  
> 
> we could, but looking at early version of hyperv-iommu-arm.c, it looks
> very similar, and so if there are very few ifdefs, we could just
> keep one file rather than replicating bunch of code.

With this patch as is, how could you keep one file for both ARM and X86
where hv-irq-remap.c does not build on ARM?
