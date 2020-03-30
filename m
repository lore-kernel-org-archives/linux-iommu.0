Return-Path: <SRS0=/IpK=5P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A569C2D0F4
	for <iommu@archiver.kernel.org>; Mon, 30 Mar 2020 20:38:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1D8A208E0
	for <iommu@archiver.kernel.org>; Mon, 30 Mar 2020 20:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1D8A208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DE036862D4;
	Mon, 30 Mar 2020 20:38:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0il8-iFMWyfg; Mon, 30 Mar 2020 20:38:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E012786A29;
	Mon, 30 Mar 2020 20:38:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD563C1D89;
	Mon, 30 Mar 2020 20:38:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5ABD1C1D89
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 20:38:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3EDEE2034D
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 20:38:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qTg6dNMUXUH6 for <iommu@lists.linux-foundation.org>;
 Mon, 30 Mar 2020 20:38:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by silver.osuosl.org (Postfix) with ESMTPS id 110D520416
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 20:38:00 +0000 (UTC)
IronPort-SDR: takhaPrN4lbzaaC0PxgR1J3qUoz5JgwVAMZpFPs03kGQs/Wn1KhERF8erNt2GzaEYzUNS2HhYc
 Ab02yY9Rjx/Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2020 13:37:58 -0700
IronPort-SDR: GNn1phKjYeWOy4sUUaIiplUSOvDSBwlmuGg9/S+wrht1OdkbM3gH+KFRSzY7cZghxfpXxVXBg6
 3YrBVAKYLT/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,325,1580803200"; d="scan'208";a="242143832"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
 by orsmga008.jf.intel.com with ESMTP; 30 Mar 2020 13:37:57 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, "H Peter Anvin" <hpa@zytor.com>,
 "David Woodhouse" <dwmw2@infradead.org>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 "Dave Hansen" <dave.hansen@intel.com>, "Tony Luck" <tony.luck@intel.com>,
 "Ashok Raj" <ashok.raj@intel.com>,
 "Jacob Jun Pan" <jacob.jun.pan@intel.com>,
 "Dave Jiang" <dave.jiang@intel.com>, "Sohil Mehta" <sohil.mehta@intel.com>,
 "Ravi V Shankar" <ravi.v.shankar@intel.com>
Subject: [PATCH 1/7] docs: x86: Add a documentation for ENQCMD
Date: Mon, 30 Mar 2020 12:33:02 -0700
Message-Id: <1585596788-193989-2-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com>
References: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, iommu@lists.linux-foundation.org,
 x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Ashok Raj <ashok.raj@intel.com>

ENQCMD and Data Streaming Accelerator (DSA) and all of their associated
features are a complicated stack with lots of interconnected pieces.
This documentation provides a big picture overview for all of the
features.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 Documentation/x86/enqcmd.rst | 185 +++++++++++++++++++++++++++++++++++
 1 file changed, 185 insertions(+)
 create mode 100644 Documentation/x86/enqcmd.rst

diff --git a/Documentation/x86/enqcmd.rst b/Documentation/x86/enqcmd.rst
new file mode 100644
index 000000000000..414ef7d24028
--- /dev/null
+++ b/Documentation/x86/enqcmd.rst
@@ -0,0 +1,185 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Improved Device Interaction Overview
+
+== Background ==
+
+Shared Virtual Addressing (SVA) allows the processor and device to use the
+same virtual addresses avoiding the need for software to translate virtual
+addresses to physical addresses. ENQCMD is a new instruction on Intel
+platforms that allows user applications to directly notify hardware of new
+work, much like doorbells are used in some hardware, but carries a payload
+that carries the PASID and some additional device specific commands
+along with it.
+
+== Address Space Tagging ==
+
+A new MSR (MSR_IA32_PASID) allows an application address space to be
+associated with what the PCIe spec calls a Process Address Space ID
+(PASID). This PASID tag is carried along with all requests between
+applications and devices and allows devices to interact with the process
+address space.
+
+This MSR is managed with the XSAVE feature set as "supervisor state".
+
+== PASID Management ==
+
+The kernel must allocate a PASID on behalf of each process and program it
+into the new MSR to communicate the process identity to platform hardware.
+ENQCMD uses the PASID stored in this MSR to tag requests from this process.
+Requests for DMA from the device are also tagged with the same PASID. The
+platform IOMMU uses the PASID in the transaction to perform address
+translation. The IOMMU api's setup the corresponding PASID entry in IOMMU
+with the process address used by the CPU (for e.g cr3 in x86).
+
+The MSR must be configured on each logical CPU before any application
+thread can interact with a device.  Threads that belong to the same
+process share the same page tables, thus the same MSR value.
+
+The PASID allocation and MSR programming may occur long after a process and
+its threads have been created. If a thread uses ENQCMD without the MSR
+first being populated, it will #GP.  The kernel will fix up the #GP by
+writing the process-wide PASID into the thread that took the #GP. A single
+process PASID can be used simultaneously with multiple devices since they
+all share the same address space.
+
+New threads could inherit the MSR value from the parent. But this would
+involve additional state management for those threads which may never use
+ENQCMD. Clearing the MSR at thread creation permits all threads to have a
+consistent behavior; the PASID is only programmed when the thread calls
+ENQCMD for the first time.
+
+Although ENQCMD can be executed in the kernel, there isn't any usage yet.
+Currently #GP handler doesn't fix up #GP triggered from ENQCMD executed
+in the kernel
+
+== Relationships ==
+
+ * Each process has many threads, but only one PASID
+ * Devices have a limited number (~10's to 1000's) of hardware
+   workqueues and each portal maps down to a single workqueue.
+   The device driver manages allocating hardware workqueues.
+ * A single mmap() maps a single hardware workqueue as a "portal"
+ * For each device with which a process interacts, there must be
+   one or more mmap()'d portals.
+ * Many threads within a process can share a single portal to access
+   a single device.
+ * Multiple processes can separately mmap() the same portal, in
+   which case they still share one device hardware workqueue.
+ * The single process-wide PASID is used by all threads to interact
+   with all devices.  There is not, for instance, a PASID for each
+   thread or each thread<->device pair.
+
+== FAQ ==
+
+* What is SVA/SVM?
+
+Shared Virtual Addressing (SVA) permits I/O hardware and the processor to
+work in the same address space. In short, sharing the address space. Some
+call it Shared Virtual Memory (SVM), but Linux community wanted to avoid
+it with Posix Shared Memory and Secure Virtual Machines which were terms
+already in circulation.
+
+* What is a PASID?
+
+A Process Address Space ID (PASID) is a PCIe-defined TLP Prefix. A PASID is
+a 20 bit number allocated and managed by the OS. PASID is included in all
+transactions between the platform and the device.
+
+* How are shared work queues different?
+
+Traditionally to allow user space applications interact with hardware,
+there is a separate instance required per process. For e.g. consider
+doorbells as a mechanism of informing hardware about work to process. Each
+doorbell is required to be spaced 4k (or page-size) apart for process
+isolation. This requires hardware to provision that space and reserve in
+MMIO. This doesn't scale as the number of threads becomes quite large. The
+hardware also manages the queue depth for Shared Work Queues (SWQ), and
+consumers don't need to track queue depth. If there is no space to accept
+a command, the device will return an error indicating retry. Also
+submitting a command to an MMIO address that can't accept ENQCMD will
+return retry in response.
+
+SWQ allows hardware to provision just a single address in the device. When
+used with ENQCMD to submit work, the device can distinguish the process
+submitting the work since it will include the PASID assigned to that
+process. This decreases the pressure of hardware requiring to support
+hardware to scale to a large number of processes.
+
+* Is this the same as a user space device driver?
+
+Communicating with the device via the shared work queue is much simpler
+than a full blown user space driver. The kernel driver does all the
+initialization of the hardware. User space only needs to worry about
+submitting work and processing completions.
+
+* Is this the same as SR-IOV?
+
+Single Root I/O Virtualization (SR-IOV) focuses on providing independent
+hardware interfaces for virtualizing hardware. Hence its required to be
+almost fully functional interface to software supporting the traditional
+BAR's, space for interrupts via MSI-x, its own register layout. Creating
+of this Virtual Functions (VFs) is assisted by the Physical Function (PF)
+driver.
+
+Scalable I/O Virtualization builds on the PASID concept to create device
+instances for virtualization. SIOV requires host software to assist in
+creating virtual devices, each virtual device is represented by a PASID.
+This allows device hardware to optimize device resource creation and can
+grow dynamically on demand. SR-IOV creation and management is very static
+in nature. Consult references below for more details.
+
+* Why not just create a virtual function for each app?
+
+Creating PCIe SRIOV type virtual functions (VF) are expensive. They create
+duplicated hardware for PCI config space requirements, Interrupts such as
+MSIx for instance. Resources such as interrupts have to be hard partitioned
+between VF's at creation time, and cannot scale dynamically on demand. The
+VF's are not completely independent from the Physical function (PF). Most
+VF's require some communication and assistance from the PF driver. SIOV
+creates a software defined device. Where all the configuration and control
+aspects are mediated via the slow path. The work submission and completion
+happen without any mediation.
+
+* Does this support virtualization?
+
+ENQCMD can be used from within a guest VM. In these cases the VMM helps
+with setting up a translation table to translate from Guest PASID to Host
+PASID. Please consult the ENQCMD instruction set reference for more
+details.
+
+* Does memory need to be pinned?
+
+When devices support SVA, along with platform hardware such as IOMMU
+supporting such devices, there is no need to pin memory for DMA purposes.
+Devices that support SVA also support other PCIe features that remove the
+pinning requirement for memory.
+
+Device TLB support - Device requests the IOMMU to lookup an address before
+use via Address Translation Service (ATS) requests.  If the mapping exists
+but there is no page allocated by the OS, IOMMU hardware returns that no
+mapping exists.
+
+Device requests that virtual address to be mapped via Page Request
+Interface (PRI). Once the OS has successfully completed  the mapping, it
+returns the response back to the device. The device continues again to
+request for a translation and continues.
+
+IOMMU works with the OS in managing consistency of page-tables with the
+device. When removing pages, it interacts with the device to remove any
+device-tlb that might have been cached before removing the mappings from
+the OS.
+
+== References ==
+
+VT-D:
+https://01.org/blogs/ashokraj/2018/recent-enhancements-intel-virtualization-technology-directed-i/o-intel-vt-d
+
+SIOV:
+https://01.org/blogs/2019/assignable-interfaces-intel-scalable-i/o-virtualization-linux
+
+ENQCMD in ISE:
+https://software.intel.com/sites/default/files/managed/c5/15/architecture-instruction-set-extensions-programming-reference.pdf
+
+DSA spec:
+https://software.intel.com/sites/default/files/341204-intel-data-streaming-accelerator-spec.pdf
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
