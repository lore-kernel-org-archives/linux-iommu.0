Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.246.68.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794438707;
	b=laDjuor40+mmIx5d5zFAkquJO0WVr3lTv5HKJEZmNYORWL7wgItFASu+NSaN7gv45ISI
	 6OvWNPNnYLlW6w+6hCU2M3Z6eI9uiv1CsxiTWg1E5/P1aBiamjlrYGdDEgG7ETbZzfmCd
	 0WzGjOZo/dzpevFC6CFgDMYbRt3qYCLYSSx9lBhLmrGn16wH3vtXd6n/K/rwlqXnd7P28
	 5yq22aqVYY99zxPK9n7huGUH4Tmxgfd0Qp1yZNJvJ4ZU5m04QSoLYOx3PGS4NOSYHr2TI
	 NeOBIPM1pm7DL8vkL/mwhUWFJAxveezAmPPfKqbkhnVkZnvZ42dzJKbOuR3weoEvc2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794438707;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=4rw6//3owvAzMi50fF91ps4G2WAPcINUQLX2klqiClY=;
	b=qGO+RYUnMT5A8jKKqYZznwAzB4VW9EQu1DkKdXJ6CT6dN4kanBhCslQvxaUSaLIP7lNF
	 uiHR7RyJa+uJb8HhPv+CunccpcT0E32qoXM6CLfNIcIkgPJ8+EymhcHTtrEEqRyBDoYT3
	 4jJSUwrLSsGg9i1tuxGwVI5FE7ap6TmHj3JecEHXiHkaJksTA92mJk0XNRJ4S1gHggbaV
	 HfbXMY2RUTnoszIw4c1JIVRlF51lR2uBkaLt9VdRPpXh2PhppzE8Jhbwp+bwnbMFjq196
	 MGWERTC6HJUdMUYFBEtkgQFwSnA5Rbq+14ttaa5ThjuL7a4Ir6n10v+fph/55pqVVKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b="nARrBg//";
	arc=none smtp.remote-ip=44.246.68.102
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584E3606A321
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 23:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 584E3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=nARrBg//
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794438706; x=1825974706;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4rw6//3owvAzMi50fF91ps4G2WAPcINUQLX2klqiClY=;
  b=nARrBg//cKZ/qBbXVPbNJI+zDfnJvc9Fe0G0o7yUsu2PLIu6gmOxFmpA
   LdCq7Eg+9rzpWrCAHPPBZNmBtIq7O+LLHlMHUpvC+LaSr/AQ7B9fN+7qf
   OY3+htJJL4Z8Dh2C/xlG75viOZZQ2TtyfcCdNjpxRZZfvZeJ86C3Uqn41
   BL/n37EPmCaeADloXSC5KUCtECn8CO7e+UHe/l2XlDy+0EiglcZi1a8ff
   D4XMUzRy9232cXqEnO7d+75ILSTCmkjc6dwobygkh10/KOmtkiks05zti
   TSQdF7BcaiJVoluE77876dRODU3Cas7bz7FyXWvKOqHba+N8IYBb+yo9f
   w==;
X-CSE-ConnectionGUID: ehV1khM3R5C3ApiNN9Re+Q==
X-CSE-MsgGUID: E9hUfOB8SvOHk2qgHwwthQ==
X-IronPort-AV: E=Sophos;i="6.27,208,1787011200"; 
   d="scan'208";a="33678994"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 23:11:45 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:6832]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.61:2525] with esmtp (Farcaster)
 id 37a92cb3-4f6c-49b3-9207-5e742ee3e865; Wed, 11 Nov 2026 23:11:45 +0000 (UTC)
X-Farcaster-Flow-ID: 37a92cb3-4f6c-49b3-9207-5e742ee3e865
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 23:11:45 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 23:11:42 +0000
From: Alexander Graf <graf@amazon.com>
To: <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
CC: The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, <linux-doc@vger.kernel.org>, <iommu@lists.linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	<david@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	<nh-open-source@amazon.com>, <linux-mm@kvack.org>, Jonathan Corbet
	<corbet@lwn.net>
Subject: [PATCH 36/40] nitro_enclaves: Add NE_ENCLAVE_PCIE_HOTPLUG_MODE
Date: Wed, 11 Nov 2026 22:59:40 +0000
Message-ID: <61b67a9c8353ce6ad1deddd9bf870e5118dcc313.1794393491.git.graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1794300002.git.graf@amazon.com>
References: <cover.1794300002.git.graf@amazon.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Users want to add devices to a Nitro Sandbox while it runs. The
hypervisor supports that for a slot it sets up for it when it allocates
the slot.

Add NE_ENCLAVE_PCIE_HOTPLUG_MODE, which asks for such a slot, and let
NE_ADD_DEVICE take a device in the running state for a slot that carries
the flag.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 drivers/virt/nitro_enclaves/ne_misc_dev.c |  9 ++++++++-
 drivers/virt/nitro_enclaves/ne_misc_dev.h |  1 +
 include/uapi/linux/nitro_enclaves.h       | 24 ++++++++++++++++++++---
 3 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev.c b/drivers/virt/nitro_enclaves/ne_misc_dev.c
index cccfceeb575cc..870b3a6368cf9 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_dev.c
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev.c
@@ -2967,7 +2967,14 @@ static long ne_enclave_do_ioctl(struct file *file, unsigned int cmd, unsigned lo
 		if (rc)
 			return rc;
 
-		if (ne_enclave->state != NE_STATE_INIT) {
+		/*
+		 * A slot allocated to take a device once its enclave runs
+		 * takes one in the running state as well. An enclave that has
+		 * stopped takes nothing either way.
+		 */
+		if (ne_enclave->state != NE_STATE_INIT &&
+		    !(ne_enclave->state == NE_STATE_RUNNING &&
+		      (ne_enclave->launch_flags & NE_ENCLAVE_PCIE_HOTPLUG_MODE))) {
 			dev_err_ratelimited(ne_misc_dev.this_device,
 					    "Enclave is not in init state\n");
 
diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev.h b/drivers/virt/nitro_enclaves/ne_misc_dev.h
index 1fd93bddf7766..ed1b29997e1bb 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_dev.h
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev.h
@@ -26,6 +26,7 @@
 					 NE_ENCLAVE_PCIE_MODE | \
 					 NE_ENCLAVE_PCIE_VSOCK_MODE | \
 					 NE_ENCLAVE_PCIE_VIRTIO_MODE | \
+					 NE_ENCLAVE_PCIE_HOTPLUG_MODE | \
 					 NE_ENCLAVE_PCIE_NUMA_MODE)
 
 struct cma;
diff --git a/include/uapi/linux/nitro_enclaves.h b/include/uapi/linux/nitro_enclaves.h
index b346e0582c5fa..f204d0f6e7efd 100644
--- a/include/uapi/linux/nitro_enclaves.h
+++ b/include/uapi/linux/nitro_enclaves.h
@@ -85,6 +85,17 @@
  */
 #define NE_ENCLAVE_PCIE_VIRTIO_MODE	(1u << 9)
 
+/**
+ * NE_ENCLAVE_PCIE_HOTPLUG_MODE - Allocate a slot whose PCIe bus can take
+ *				  a device once the enclave is running. The
+ *				  hypervisor decides it at SLOT_ALLOC time, and
+ *				  %NE_ADD_DEVICE takes a device in the running
+ *				  state for a slot that carries it. Requires
+ *				  NE_ENCLAVE_PCIE_MODE and excludes
+ *				  NE_ENCLAVE_PCIE_VSOCK_MODE.
+ */
+#define NE_ENCLAVE_PCIE_HOTPLUG_MODE	(1u << 8)
+
 /**
  * NE_ENCLAVE_PCIE_NUMA_MODE - Allocate a slot whose memory and vCPUs may come
  *			       from more than one host NUMA node. Without it the
@@ -701,7 +712,11 @@ struct ne_add_device_args {
  *		   An argument that ends at @vq_info is taken and gets no
  *		   @info_notify_index back.
  *		   The ioctl can be invoked on the enclave fd, before an
- *		   enclave is started.
+ *		   enclave is started, and while it is running if the slot
+ *		   was allocated with %NE_ENCLAVE_PCIE_HOTPLUG_MODE. A
+ *		   started enclave refuses %NE_ALLOC_MEMORY, so a device
+ *		   given to one works from allocations made before it
+ *		   started.
  *
  * Context: Process context.
  * Return:
@@ -738,8 +753,11 @@ struct ne_add_device_args {
  * * EPROTO				- The device replied for a different number of
  *					  virtqueues than it was asked for, or placed
  *					  their entries outside the info page.
- * * NE_ERR_NOT_IN_INIT_STATE		- The enclave is not in init state (init =
- *					  before being started).
+ * * NE_ERR_NOT_IN_INIT_STATE		- The enclave left its init state (init =
+ *					  before being started) and the slot was
+ *					  not allocated with
+ *					  %NE_ENCLAVE_PCIE_HOTPLUG_MODE, or the
+ *					  enclave has stopped.
  * * NE_ERR_INVALID_FLAG_VALUE		- The value of the provided flag is invalid.
  * * NE_ERR_MEM_REGION_ALREADY_USED	- An allocation was already given to the
  *					  enclave, or is its info page, or is the
-- 
2.47.1

