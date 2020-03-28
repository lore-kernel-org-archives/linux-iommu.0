Return-Path: <SRS0=r/qF=5N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEDBC43331
	for <iommu@archiver.kernel.org>; Sat, 28 Mar 2020 11:57:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 760AB20774
	for <iommu@archiver.kernel.org>; Sat, 28 Mar 2020 11:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDiPft3e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 760AB20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4E28B203B4;
	Sat, 28 Mar 2020 11:57:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TrvgAvH0uz+m; Sat, 28 Mar 2020 11:57:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3BEF32039C;
	Sat, 28 Mar 2020 11:57:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C813C18DA;
	Sat, 28 Mar 2020 11:57:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC170C0177
 for <iommu@lists.linux-foundation.org>; Sat, 28 Mar 2020 11:57:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DAC448907F
 for <iommu@lists.linux-foundation.org>; Sat, 28 Mar 2020 11:57:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j5Zgiad1xSlt for <iommu@lists.linux-foundation.org>;
 Sat, 28 Mar 2020 11:57:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-74.mimecast.com
 (us-smtp-delivery-74.mimecast.com [63.128.21.74])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B839188FD0
 for <iommu@lists.linux-foundation.org>; Sat, 28 Mar 2020 11:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585396671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MlgUgoCS6ugUoJeRRLBbalZpTjLxsTZKRshOClHAQAs=;
 b=HDiPft3eBPJgI6yrQbCZlF57TyR8b0Zb0qOGvnjRBIR4ZhZbmXaA9WoORuMTxH7WyMYIV/
 SyRqCa+M0nw2NM8rlUJ3RSOi3fkbCbBXFepJkPUEk/hjf76BIR4y5s9Ni8Ep4oHK14JwEb
 +acUl8JVLWcplHU8m1BC6d779Qtq+qA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-ikfo-PwRMFC4t_MRjKb6Kg-1; Sat, 28 Mar 2020 07:57:49 -0400
X-MC-Unique: ikfo-PwRMFC4t_MRjKb6Kg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AB0B8017CC;
 Sat, 28 Mar 2020 11:57:46 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-137.pek2.redhat.com
 [10.72.12.137])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8661D90800;
 Sat, 28 Mar 2020 11:57:37 +0000 (UTC)
Date: Sat, 28 Mar 2020 19:57:33 +0800
From: Dave Young <dyoung@redhat.com>
To: Alexander Graf <graf@amazon.com>
Subject: Re: [PATCH] swiotlb: Allow swiotlb to live at pre-defined address
Message-ID: <20200328115733.GA67084@dhcp-128-65.nay.redhat.com>
References: <20200326162922.27085-1-graf@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200326162922.27085-1-graf@amazon.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: Mark Rutland <mark.rutland@arm.com>, brijesh.singh@amd.com,
 lijiang@redhat.com, linux-doc@vger.kernel.org,
 Jan Kiszka <jan.kiszka@siemens.com>, Christoph Hellwig <hch@lst.de>,
 x86@kernel.org, Laszlo Ersek <lersek@redhat.com>, aggh@amazon.com,
 thomas.lendacky@amd.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 alcioa@amazon.com, dhr@amazon.com, benh@amazon.com, kasong@redhat.com,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, aagch@amazon.com,
 Robin Murphy <robin.murphy@arm.com>, dwmw@amazon.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 03/26/20 at 05:29pm, Alexander Graf wrote:
> The swiotlb is a very convenient fallback mechanism for bounce buffering of
> DMAable data. It is usually used for the compatibility case where devices
> can only DMA to a "low region".
> 
> However, in some scenarios this "low region" may be bound even more
> heavily. For example, there are embedded system where only an SRAM region
> is shared between device and CPU. There are also heterogeneous computing
> scenarios where only a subset of RAM is cache coherent between the
> components of the system. There are partitioning hypervisors, where
> a "control VM" that implements device emulation has limited view into a
> partition's memory for DMA capabilities due to safety concerns.
> 
> This patch adds a command line driven mechanism to move all DMA memory into
> a predefined shared memory region which may or may not be part of the
> physical address layout of the Operating System.
> 
> Ideally, the typical path to set this configuration would be through Device
> Tree or ACPI, but neither of the two mechanisms is standardized yet. Also,
> in the x86 MicroVM use case, we have neither ACPI nor Device Tree, but
> instead configure the system purely through kernel command line options.
> 
> I'm sure other people will find the functionality useful going forward
> though and extend it to be triggered by DT/ACPI in the future.

Hmm, we have a use case for kdump, this maybe useful.  For example
swiotlb is enabled by default if AMD SME/SEV is active, and in kdump
kernel we have to increase the crashkernel reserved size for the extra
swiotlb requirement.  I wonder if we can just reuse the old kernel's
swiotlb region and pass the addr to kdump kernel.

> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  3 +-
>  Documentation/x86/x86_64/boot-options.rst       |  4 ++-
>  kernel/dma/swiotlb.c                            | 46 +++++++++++++++++++++++--
>  3 files changed, 49 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index c07815d230bc..d085d55c3cbe 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4785,11 +4785,12 @@
>  			it if 0 is given (See Documentation/admin-guide/cgroup-v1/memory.rst)
>  
>  	swiotlb=	[ARM,IA-64,PPC,MIPS,X86]
> -			Format: { <int> | force | noforce }
> +			Format: { <int> | force | noforce | addr=<phys addr> }
>  			<int> -- Number of I/O TLB slabs
>  			force -- force using of bounce buffers even if they
>  			         wouldn't be automatically used by the kernel
>  			noforce -- Never use bounce buffers (for debugging)
> +			addr=<phys addr> -- Try to allocate SWIOTLB at defined address
>  
>  	switches=	[HW,M68k]
>  
> diff --git a/Documentation/x86/x86_64/boot-options.rst b/Documentation/x86/x86_64/boot-options.rst
> index 2b98efb5ba7f..ca46c57b68c9 100644
> --- a/Documentation/x86/x86_64/boot-options.rst
> +++ b/Documentation/x86/x86_64/boot-options.rst
> @@ -297,11 +297,13 @@ iommu options only relevant to the AMD GART hardware IOMMU:
>  iommu options only relevant to the software bounce buffering (SWIOTLB) IOMMU
>  implementation:
>  
> -    swiotlb=<pages>[,force]
> +    swiotlb=<pages>[,force][,addr=<phys addr>]
>        <pages>
>          Prereserve that many 128K pages for the software IO bounce buffering.
>        force
>          Force all IO through the software TLB.
> +      addr=<phys addr>
> +        Try to allocate SWIOTLB at defined address
>  
>  Settings for the IBM Calgary hardware IOMMU currently found in IBM
>  pSeries and xSeries machines
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index c19379fabd20..83da0caa2f93 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -46,6 +46,7 @@
>  #include <linux/init.h>
>  #include <linux/memblock.h>
>  #include <linux/iommu-helper.h>
> +#include <linux/io.h>
>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/swiotlb.h>
> @@ -102,6 +103,12 @@ unsigned int max_segment;
>  #define INVALID_PHYS_ADDR (~(phys_addr_t)0)
>  static phys_addr_t *io_tlb_orig_addr;
>  
> +/*
> + * The TLB phys addr may be defined on the command line. Store it here if it is.
> + */
> +static phys_addr_t io_tlb_addr = INVALID_PHYS_ADDR;
> +
> +
>  /*
>   * Protect the above data structures in the map and unmap calls
>   */
> @@ -119,11 +126,23 @@ setup_io_tlb_npages(char *str)
>  	}
>  	if (*str == ',')
>  		++str;
> -	if (!strcmp(str, "force")) {
> +	if (!strncmp(str, "force", 5)) {
>  		swiotlb_force = SWIOTLB_FORCE;
> -	} else if (!strcmp(str, "noforce")) {
> +		str += 5;
> +	} else if (!strncmp(str, "noforce", 7)) {
>  		swiotlb_force = SWIOTLB_NO_FORCE;
>  		io_tlb_nslabs = 1;
> +		str += 7;
> +	}
> +
> +	if (*str == ',')
> +		++str;
> +	if (!strncmp(str, "addr=", 5)) {
> +		char *addrstr = str + 5;
> +
> +		io_tlb_addr = kstrtoul(addrstr, 0, &str);
> +		if (addrstr == str)
> +			io_tlb_addr = INVALID_PHYS_ADDR;
>  	}
>  
>  	return 0;
> @@ -239,6 +258,25 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
>  	return 0;
>  }
>  
> +static int __init swiotlb_init_io(int verbose, unsigned long bytes)
> +{
> +	unsigned __iomem char *vstart;
> +
> +	if (io_tlb_addr == INVALID_PHYS_ADDR)
> +		return -EINVAL;
> +
> +	vstart = memremap(io_tlb_addr, bytes, MEMREMAP_WB);
> +	if (!vstart)
> +		return -EINVAL;
> +
> +	if (swiotlb_init_with_tbl(vstart, io_tlb_nslabs, verbose)) {
> +		memunmap(vstart);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * Statically reserve bounce buffer space and initialize bounce buffer data
>   * structures for the software IO TLB used to implement the DMA API.
> @@ -257,6 +295,10 @@ swiotlb_init(int verbose)
>  
>  	bytes = io_tlb_nslabs << IO_TLB_SHIFT;
>  
> +	/* Map IO TLB from device memory */
> +	if (!swiotlb_init_io(verbose, bytes))
> +		return;
> +
>  	/* Get IO TLB memory from the low pages */
>  	vstart = memblock_alloc_low(PAGE_ALIGN(bytes), PAGE_SIZE);
>  	if (vstart && !swiotlb_init_with_tbl(vstart, io_tlb_nslabs, verbose))
> -- 
> 2.16.4
> 
> 
> 
> 
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879
> 
> 
> 

Thanks
Dave

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
