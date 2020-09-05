Return-Path: <SRS0=R2i3=CO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D989FC43461
	for <iommu@archiver.kernel.org>; Sat,  5 Sep 2020 15:15:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0BF9208DB
	for <iommu@archiver.kernel.org>; Sat,  5 Sep 2020 15:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="l/k2hZ2y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0BF9208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AB70A86937;
	Sat,  5 Sep 2020 15:15:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id abrzhRe6A47X; Sat,  5 Sep 2020 15:15:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2811D8694A;
	Sat,  5 Sep 2020 15:14:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16B04C088B;
	Sat,  5 Sep 2020 15:14:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE62FC0052
 for <iommu@lists.linux-foundation.org>; Sat,  5 Sep 2020 15:14:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DAA1A87537
 for <iommu@lists.linux-foundation.org>; Sat,  5 Sep 2020 15:14:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u0RCe17bHc8Q for <iommu@lists.linux-foundation.org>;
 Sat,  5 Sep 2020 15:14:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CE54587532
 for <iommu@lists.linux-foundation.org>; Sat,  5 Sep 2020 15:14:45 +0000 (UTC)
Received: from zn.tnic (p200300ec2f1fd2003cc6c449b5784611.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f1f:d200:3cc6:c449:b578:4611])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AC2A91EC02F2;
 Sat,  5 Sep 2020 17:14:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1599318882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=eE8W0M9kRhWrkNpvK8xyBhXMehbrAL2sbjtrEES8gd0=;
 b=l/k2hZ2ykWxPS19kfsiW+Iu5kUuKdlUikyLhkjnWFMgbWkEDjorjqCwriPHMgZya3lrq3e
 W/js6xFgwhxo6f7hXPIHpDH5Z4LtrDZWkasneNlA6xg7tiNQ8sWeznjYj7Gfg+LGW1rA2J
 4wk6fPqgr2ZlLBfLhC0fuVZ8QzVDDrc=
Date: Sat, 5 Sep 2020 17:14:34 +0200
From: Borislav Petkov <bp@alien8.de>
To: Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v7 3/9] docs: x86: Add documentation for SVA (Shared
 Virtual Addressing)
Message-ID: <20200905151434.GB28808@zn.tnic>
References: <1598540794-132666-1-git-send-email-fenghua.yu@intel.com>
 <1598540794-132666-4-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1598540794-132666-4-git-send-email-fenghua.yu@intel.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Tony Luck <tony.luck@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Dave Hansen <dave.hansen@intel.com>,
 iommu@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
 Jacob Jun Pan <jacob.jun.pan@intel.com>, Andy Lutomirski <luto@kernel.org>,
 H Peter Anvin <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 David Woodhouse <dwmw2@infradead.org>
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

> Subject: Re: [PATCH v7 3/9] docs: x86: Add documentation for SVA (Shared Virtual Addressing)

Fix prefix: Documentation/x86: ...

On Thu, Aug 27, 2020 at 08:06:28AM -0700, Fenghua Yu wrote:
> From: Ashok Raj <ashok.raj@intel.com>
> 
> ENQCMD and Data Streaming Accelerator (DSA) and all of their associated
> features are a complicated stack with lots of interconnected pieces.
> This documentation provides a big picture overview for all of the
> features.
> 
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
> v7:
> - Change the doc for updating PASID by IPI and context switch (Andy).
> 
> v3:
> - Replace deprecated intel_svm_bind_mm() by iommu_sva_bind_mm() (Baolu)
> - Fix a couple of typos (Baolu)
> 
> v2:
> - Fix the doc format and add the doc in toctree (Thomas)
> - Modify the doc for better description (Thomas, Tony, Dave)
> 
>  Documentation/x86/index.rst |   1 +
>  Documentation/x86/sva.rst   | 254 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 255 insertions(+)
>  create mode 100644 Documentation/x86/sva.rst
> 
> diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
> index 265d9e9a093b..e5d5ff096685 100644
> --- a/Documentation/x86/index.rst
> +++ b/Documentation/x86/index.rst
> @@ -30,3 +30,4 @@ x86-specific Documentation
>     usb-legacy-support
>     i386/index
>     x86_64/index
> +   sva
> diff --git a/Documentation/x86/sva.rst b/Documentation/x86/sva.rst
> new file mode 100644
> index 000000000000..6e7ac565e127
> --- /dev/null
> +++ b/Documentation/x86/sva.rst
> @@ -0,0 +1,254 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===========================================
> +Shared Virtual Addressing (SVA) with ENQCMD
> +===========================================
> +
> +Background
> +==========
> +
> +Shared Virtual Addressing (SVA) allows the processor and device to use the
> +same virtual addresses avoiding the need for software to translate virtual
> +addresses to physical addresses. SVA is what PCIe calls Shared Virtual
> +Memory (SVM)
	       ^
	       . <-- Fullstop


> +
> +In addition to the convenience of using application virtual addresses
> +by the device, it also doesn't require pinning pages for DMA.
> +PCIe Address Translation Services (ATS) along with Page Request Interface
> +(PRI) allow devices to function much the same way as the CPU handling
> +application page-faults. For more information please refer to PCIe
								^
								the

> +specification Chapter 10: ATS Specification.
> +
> +Use of SVA requires IOMMU support in the platform. IOMMU also is required
> +to support PCIe features ATS and PRI. ATS allows devices to cache
> +translations for the virtual address. IOMMU driver uses the mmu_notifier()

		... for virtual addresses. The IOMMU driver...

> +support to keep the device tlb cache and the CPU cache in sync. PRI allows

			      TLB

> +the device to request paging the virtual address before using if they are
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +not paged in the CPU page tables.

That sentence is reading strange and needs fixing.

> +
> +
> +Shared Hardware Workqueues
> +==========================
> +
> +Unlike Single Root I/O Virtualization (SRIOV), Scalable IOV (SIOV) permits
> +the use of Shared Work Queues (SWQ) by both applications and Virtual
> +Machines (VM's). This allows better hardware utilization vs. hard
> +partitioning resources that could result in under utilization. In order to
> +allow the hardware to distinguish the context for which work is being
> +executed in the hardware by SWQ interface, SIOV uses Process Address Space
> +ID (PASID), which is a 20bit number defined by the PCIe SIG.
> +
> +PASID value is encoded in all transactions from the device. This allows the
> +IOMMU to track I/O on a per-PASID granularity in addition to using the PCIe
> +Resource Identifier (RID) which is the Bus/Device/Function.
> +
> +
> +ENQCMD
> +======
> +
> +ENQCMD is a new instruction on Intel platforms that atomically submits a
> +work descriptor to a device. The descriptor includes the operation to be
> +performed, virtual addresses of all parameters, virtual address of a completion
> +record, and the PASID (process address space ID) of the current process.
> +
> +ENQCMD works with non-posted semantics and carries a status back if the
> +command was accepted by hardware. This allows the submitter to know if the
> +submission needs to be retried or other device specific mechanisms to
> +implement fairness or ensure forward progress can be made.

						can/should be provided.

> +
> +ENQCMD is the glue that ensures applications can directly submit commands
> +to the hardware and also permit hardware to be aware of application context

			    permits

> +to perform I/O operations via use of PASID.
> +
> +Process Address Space Tagging
> +=============================
> +
> +A new thread scoped MSR (IA32_PASID) provides the connection between

	thread-scoped

> +user processes and the rest of the hardware. When an application first
> +accesses an SVA capable device this MSR is initialized with a newly

		SVA-capable device, ...

> +allocated PASID. The driver for the device calls an IOMMU specific API

							IOMMU-specific

> +that sets up the routing for DMA and page-requests.
> +
> +For example, the Intel Data Streaming Accelerator (DSA) uses
> +iommu_sva_bind_device(), which will do the following.

					   ... following: <-- colon

> +
> +- Allocate the PASID, and program the process page-table (cr3) in the PASID

							    "%cr3 register"

write it out so that it is clear what you mean.

> +  context entries.
> +- Register for mmu_notifier() to track any page-table invalidations to keep
> +  the device tlb in sync. For example, when a page-table entry is invalidated,

		TLB

Do search and replace in your whole document: s/tlb/TLB/g

> +  IOMMU propagates the invalidation to device tlb. This will force any

					"... to the device TLB."

> +  future access by the device to this virtual address to participate in
> +  ATS. If the IOMMU responds with proper response that a page is not
> +  present, the device would request the page to be paged in via the PCIe PRI
> +  protocol before performing I/O.
> +
> +This MSR is managed with the XSAVE feature set as "supervisor state" to
> +ensure the MSR is updated during context switch.
> +
> +PASID Management
> +================
> +
> +The kernel must allocate a PASID on behalf of each process and program it

I hope this is not "on behalf of each process" but "on behalf of each
process which will use SIOV" or so. The text further on suggests that
but I sure hope you're not allocating this unconditionally for *every*
process. I'll see in next patches.

> +into the new MSR to communicate the process identity to platform hardware.
> +ENQCMD uses the PASID stored in this MSR to tag requests from this process.
> +When a user submits a work descriptor to a device using the ENQCMD
> +instruction, the PASID field in the descriptor is auto-filled with the
> +value from MSR_IA32_PASID. Requests for DMA from the device are also tagged
> +with the same PASID. The platform IOMMU uses the PASID in the transaction to
> +perform address translation. The IOMMU APIs setup the corresponding PASID
> +entry in IOMMU with the process address used by the CPU (for e.g cr3 in x86).

							"... %cr3 register... "

> +
> +The MSR must be configured on each logical CPU before any application
> +thread can interact with a device. Threads that belong to the same
> +process share the same page tables, thus the same MSR value.
> +
> +PASID is cleared when a process is created. The PASID allocation and MSR
> +programming may occur long after a process and its threads have been created.
> +One thread must call iommu_sva_bind_device() to allocate the PASID for the
> +process. If a thread uses ENQCMD without the MSR first being populated, it
> +will cause #GP. The kernel will update the PASID MSR with the PASID for all
^^^^^^^^^^^^^^^^^

"a #GP will be raised."

> +threads in the process. A single process PASID can be used simultaneously
> +with multiple devices since they all share the same address space.
> +
> +One thread can call iommu_sva_unbind_device() to free the allocated PASID.
> +The kernel will clear the PASID MSR for all threads in the process.

I'm guessing it is iterating over each thread belonging to that process.
I'll see later.

> +New threads inherit the MSR value from the parent.
> +
> +Relationships
> +=============
> +
> + * Each process has many threads, but only one PASID
> + * Devices have a limited number (~10's to 1000's) of hardware
> +   workqueues and each portal maps down to a single workqueue.

"portal"? This is the first time you're using that term without defining
it. An unenlightened reader like me can only guess what that means...

> +   The device driver manages allocating hardware workqueues.
> + * A single mmap() maps a single hardware workqueue as a "portal"
> + * For each device with which a process interacts, there must be
> +   one or more mmap()'d portals.
> + * Many threads within a process can share a single portal to access
> +   a single device.
> + * Multiple processes can separately mmap() the same portal, in
> +   which case they still share one device hardware workqueue.
> + * The single process-wide PASID is used by all threads to interact
> +   with all devices.  There is not, for instance, a PASID for each
> +   thread or each thread<->device pair.
> +
> +FAQ
> +===
> +
> +* What is SVA/SVM?
> +
> +Shared Virtual Addressing (SVA) permits I/O hardware and the processor to
> +work in the same address space. In short, sharing the address space.

Make that: "... work in the same address space, i.e., to share it."

> Some
> +call it Shared Virtual Memory (SVM), but Linux community wanted to avoid
> +it with Posix Shared Memory and Secure Virtual Machines which were terms
> +already in circulation.
> +
> +* What is a PASID?
> +
> +A Process Address Space ID (PASID) is a PCIe-defined TLP Prefix. A PASID is

/me wonders what a TLP is.

/me duckduckgoes...

TLP	Teacher Loan Program (South Carolina)

nah, that ain't it.

TLP	Texas Latex Party

I hope not.

/me searches "PCI TLP"

Aha,

"The Transaction Layer Packet Format is defined as:"

Do you see where I'm getting with this?

> +a 20 bit number allocated and managed by the OS. PASID is included in all
> +transactions between the platform and the device.
> +
> +* How are shared work queues different?
> +
> +Traditionally to allow user space applications interact with hardware,
> +there is a separate instance required per process.

What separate instance? Hardware instance?

Also, formulation: "Traditionally, in order for userspace applications
to interact with hardware, there...

> For example, consider
> +doorbells as a mechanism of informing hardware about work to process. Each
> +doorbell is required to be spaced 4k (or page-size) apart for process
> +isolation. This requires hardware to provision that space and reserve in
> +MMIO. This doesn't scale as the number of threads becomes quite large. The
> +hardware also manages the queue depth for Shared Work Queues (SWQ), and
> +consumers don't need to track queue depth. If there is no space to accept
> +a command, the device will return an error indicating retry.

Newline here.

> Also

      , <-- comma

> +submitting a command to an MMIO address that can't accept ENQCMD will
> +return retry in response. In the new DMWr PCIe terminology, devices need to
> +support DMWr completer capability. In addition it requires all switch ports
						 ^
						 , <-- comma

> +to support DMWr routing and must be enabled by the PCIe subsystem, much
> +like how PCIe Atomics() are managed for instance.
	    ^^^^^^^^^^^^^^

I'm sure this has a more descriptive name for unenlightened readers' sake.

> +SWQ allows hardware to provision just a single address in the device. When
> +used with ENQCMD to submit work, the device can distinguish the process
> +submitting the work since it will include the PASID assigned to that
> +process. This decreases the pressure of hardware requiring to support
> +hardware to scale to a large number of processes.

"the pressure of hardware requiring to support hardware" - I have not
the faintest clue what that means.

> +* Is this the same as a user space device driver?
> +
> +Communicating with the device via the shared work queue is much simpler
> +than a full blown user space driver. The kernel driver does all the
> +initialization of the hardware. User space only needs to worry about
> +submitting work and processing completions.
> +
> +* Is this the same as SR-IOV?
> +
> +Single Root I/O Virtualization (SR-IOV) focuses on providing independent
> +hardware interfaces for virtualizing hardware. Hence its required to be
						       ^
						       , <-- comma


Also, audit your whole document for wrongly used "its" vs "it's". The
latter means "it is" while former is a possessive adjective.

> +almost fully functional interface to software supporting the traditional
> +BAR's, space for interrupts via MSI-x, its own register layout.
> +Virtual Functions (VFs) are assisted by the Physical Function (PF)
> +driver.
> +
> +Scalable I/O Virtualization builds on the PASID concept to create device
> +instances for virtualization. SIOV requires host software to assist in
> +creating virtual devices, each virtual device is represented by a PASID
> +along with the BDF of the device.  This allows device hardware to optimize
> +device resource creation and can grow dynamically on demand. SR-IOV creation
> +and management is very static in nature. Consult references below for more
> +details.
> +
> +* Why not just create a virtual function for each app?
> +
> +Creating PCIe SRIOV type virtual functions (VF) are expensive. They create
> +duplicated hardware for PCI config space requirements, Interrupts such as

Hmm, that's strange: Virtual Functions create duplicated hardware??!?

> +MSIx for instance. Resources such as interrupts have to be hard partitioned
> +between VF's at creation time, and cannot scale dynamically on demand. The
> +VF's are not completely independent from the Physical function (PF). Most

							 "Function" - capitalized.

> +VF's require some communication and assistance from the PF driver. SIOV

> +creates a software defined device. Where all the configuration and control

These are one sentence, not two.

I'd write that like this: "SIOV, in contrast, creates a software-defined
device where all the configuration... "

> +aspects are mediated via the slow path. The work submission and
> completion happen without any mediation.
> +
> +* Does this support virtualization?
> +
> +ENQCMD can be used from within a guest VM. In these cases the VMM helps
							    ^
							    , <--- comma


> +with setting up a translation table to translate from Guest PASID to Host
> +PASID. Please consult the ENQCMD instruction set reference for more
> +details.
> +
> +* Does memory need to be pinned?
> +
> +When devices support SVA, along with platform hardware such as IOMMU
			   x

			   <--- no comma


> +supporting such devices, there is no need to pin memory for DMA purposes.
> +Devices that support SVA also support other PCIe features that remove the
> +pinning requirement for memory.
> +
> +Device TLB support - Device requests the IOMMU to lookup an address before
> +use via Address Translation Service (ATS) requests.  If the mapping exists
> +but there is no page allocated by the OS, IOMMU hardware returns that no
> +mapping exists.
> +
> +Device requests that virtual address to be mapped via Page Request
> +Interface (PRI).

That sentence is strange.

> Once the OS has successfully completed  the mapping, it
> +returns the response back to the device. The device continues again to
> +request for a translation and continues.

That one too.

> +IOMMU works with the OS in managing consistency of page-tables with the
> +device. When removing pages, it interacts with the device to remove any
> +device-tlb that might have been cached before removing the mappings from

That must be "any device TLB entry" because the IOMMU cannot really
remove a device TLB.

I'm sure there's more booboos but those are the ones that sprang at me
during the first reading.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
