Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.162.73.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437068;
	b=EX1Fr0+c9gvijeWVLYR/wJf2/xMat1TfhKVSfv29h/v6Apt7Hw0/Tx7lL8ITGIQ5HSKX
	 X2MsOnu7t5Mhqp9ofU1FTJHHCYq9L+DNzU3IBA1wh1ojM+cbawcUEBEdZ0ueGrByh6vJF
	 xuRHZBbFZjIJjfexOdjxZI9uqnN6hzloNsEVU3+6W56qzYmiC+oEFLiVtNnE5vMrNdqdd
	 1cEsAz5RuzGil5jCJuENN1krvEhpl1gjZqq6qaAV/aueyL5c5WfLGzb0QVEGDMn4HaCbi
	 6p15M7XYDvv/bxN5PVJz9jOxeelvZDIonkgH3Tpankje+wXIPjO3z3qwFWkPiFU9+1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437068;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=RikZQ1odxaSHdwBKe1B1T6fN0JY99txMaqyijCLq4Tw=;
	b=UsiXSqljYlC1y6pXe05WiYz/tA9g2uKgmU6UnYDx51Rk+qz/K3dXq6Np9Vr5CkyMRtR6
	 XBCRk65r6XY9HjEyPIjOwwiQ6qCddQwFph51H53sQolUalm07OeBy03FX/4QNCLygySzV
	 GmBMQCsVviOjadJ44IriXB/UFjfUDe3lLB19+hFYc+zs6alNQSctxFsBpf4/SQi3+z9Pb
	 b99TufjVVnITqdUxjRTCaSzycySvM7tWUS21n5hJGfx2kHmOD3AFSSBV9Fb5hV6b4ZIkX
	 HJ59yyQakOgKmUPfJdVUu+Oix69EoSNMRY8wWPXtLgGorGmGiAw4RNgkc7yDZDJqRmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=iKHNcQ5Z;
	arc=none smtp.remote-ip=35.162.73.231
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5405B606A33B
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 22:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5405B606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=iKHNcQ5Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794437067; x=1825973067;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RikZQ1odxaSHdwBKe1B1T6fN0JY99txMaqyijCLq4Tw=;
  b=iKHNcQ5ZWF1UlVjHWKQxHynEraPfkooWcJyoDcvj3AjAOHo2XFHapXzj
   1pRxal89oZPd/ovv9LPvjOb3YsE9/R9/TpchqM6q2vGMKzl8DVuxD9zDe
   zuiLDlaYoxs9AQj2unWedFyrOprhPRGPB1IIymVeRrXFYofz0Y34FiQiI
   3wxBrD9MZvfEKrlJEvxRbeGxAoZ1aFJPOwdlXsDS+KLvV6xKT1S9HxdOq
   /3hgyYGEJPsPQ0Edh4fshIqQZke+PY+kNZQptpcIgQ1vTSqqAI3cHzT0m
   ZoOME0glXcJ3SNJ1dMOTEfdHNKAVRCrNv2Se61kmSYX0OK630/uPDZtZ6
   A==;
X-CSE-ConnectionGUID: WTNM8apySkiSNhJ16IVtBw==
X-CSE-MsgGUID: kpqw3RAmQTm0n4HuTKIUtA==
X-IronPort-AV: E=Sophos;i="6.27,208,1787011200"; 
   d="scan'208";a="33572346"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 22:44:27 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:30085]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.227:2525] with esmtp (Farcaster)
 id edac81ec-ae2d-4f54-a2dc-5d8fd8cdc477; Wed, 11 Nov 2026 22:44:26 +0000 (UTC)
X-Farcaster-Flow-ID: edac81ec-ae2d-4f54-a2dc-5d8fd8cdc477
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 22:44:26 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 22:44:23 +0000
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
Subject: [PATCH 12/40] nitro_enclaves: Name the device's error codes in the UAPI header
Date: Wed, 11 Nov 2026 22:41:57 +0000
Message-ID: <5ef0d84ef7ca12328f6debd41d3bcdbf07315450.1794393490.git.graf@amazon.com>
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
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

The nitro_enclaves device refuses a command with an errno or with an
NE_ERR_ code, which ne_do_request() passes on to user space as it is.
The codes of its own that the device returns start at 276, after the
driver's, and we want the device to be able to add more of them later.

Name the device's codes in the header, so that a caller can tell for
example a refused flag from an invalid slot, and document three ranges:
the driver's original codes from 256, the device's codes from 276 to
511, and codes only the driver returns from 1024. That way new codes on
either side never collide. 511 stays below the kernel-internal error
codes, and 1024 well below MAX_ERRNO, so user space reads every code as
an error.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 include/uapi/linux/nitro_enclaves.h | 142 ++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/include/uapi/linux/nitro_enclaves.h b/include/uapi/linux/nitro_enclaves.h
index 8ccf16e9cf5fb..6dd00c41c07d5 100644
--- a/include/uapi/linux/nitro_enclaves.h
+++ b/include/uapi/linux/nitro_enclaves.h
@@ -567,6 +567,148 @@ struct ne_add_memory_region_args {
  */
 #define NE_ERR_INVALID_ENCLAVE_CID		(275)
 
+/**
+ * DOC: NE error code ranges
+ *
+ * The NE_ERR_ codes come from three ranges:
+ *
+ * * 256 to 275 - The driver's original codes. The NE PCI device also
+ *   returns NE_ERR_MEM_MAX_REGIONS, with the same meaning.
+ * * 276 to 511 - Codes the NE PCI device returns. The driver passes them on
+ *   to the caller unchanged, and the device adds new codes upward from the
+ *   last one defined here. The range ends below the kernel-internal error
+ *   codes, which start at 512.
+ * * 1024 and above - Codes only the driver returns, added upward from 1024.
+ */
+
+/**
+ * NE_ERR_INVALID_FLAGS - The command's reserved flags field was not zero.
+ */
+#define NE_ERR_INVALID_FLAGS			(276)
+/**
+ * NE_ERR_INVALID_ALIGNMENT - An address or a size the command carries is
+ *			      misaligned or too small.
+ */
+#define NE_ERR_INVALID_ALIGNMENT		(277)
+/**
+ * NE_ERR_INVALID_SIZE - A size or count the command carries is zero, too large
+ *			 or too short.
+ */
+#define NE_ERR_INVALID_SIZE			(278)
+/**
+ * NE_ERR_INVALID_SLOT - The slot the command names does not exist.
+ */
+#define NE_ERR_INVALID_SLOT			(279)
+/**
+ * NE_ERR_INVALID_DEVICE - The command names a device, an address or a memory
+ *			   range the device does not accept.
+ */
+#define NE_ERR_INVALID_DEVICE			(280)
+/**
+ * NE_ERR_TOO_MANY_DEVICES - The enclave already has as many devices as it may.
+ */
+#define NE_ERR_TOO_MANY_DEVICES			(281)
+/**
+ * NE_ERR_TOO_MANY_VQS - The device already has as many queues as it may.
+ */
+#define NE_ERR_TOO_MANY_VQS			(282)
+/**
+ * NE_ERR_NO_RESOURCES - The device could not put together something of its own
+ *			 that the command needs.
+ */
+#define NE_ERR_NO_RESOURCES			(283)
+/**
+ * NE_ERR_ALREADY_EXISTS - The slot already has what the command gives it.
+ */
+#define NE_ERR_ALREADY_EXISTS			(284)
+/**
+ * NE_ERR_MISSING_INFO_PAGE - The slot has no info page, or the one it has is too
+ *			      small for what the command writes there.
+ */
+#define NE_ERR_MISSING_INFO_PAGE		(285)
+/**
+ * NE_ERR_INVALID_FLAG - A flag bit the device does not know, or does not allow
+ *			 here, was set.
+ */
+#define NE_ERR_INVALID_FLAG			(286)
+/**
+ * NE_ERR_RESERVED_FLAG - A reserved flag bit was set.
+ */
+#define NE_ERR_RESERVED_FLAG			(287)
+/**
+ * NE_ERR_MISSING_PCIE - A flag that depends on the PCIe flag was set without it.
+ */
+#define NE_ERR_MISSING_PCIE			(288)
+/**
+ * NE_ERR_INCOMPATIBLE_FLAGS - The flags asked for cannot be had together.
+ */
+#define NE_ERR_INCOMPATIBLE_FLAGS		(289)
+/**
+ * NE_ERR_EIF_FLAG_MISMATCH - The image's matched flags are not the ones the
+ *			      enclave was started with.
+ */
+#define NE_ERR_EIF_FLAG_MISMATCH		(290)
+/**
+ * NE_ERR_DEVICE_DISALLOWED - The device type asked for is not allowed.
+ */
+#define NE_ERR_DEVICE_DISALLOWED		(291)
+/**
+ * NE_ERR_HOTPLUG_DISABLED - The enclave does not take devices once it is
+ *			     running.
+ */
+#define NE_ERR_HOTPLUG_DISABLED			(292)
+/**
+ * NE_ERR_BAD_EIF - The enclave image is missing, or did not pass validation when
+ *		    the enclave was started.
+ */
+#define NE_ERR_BAD_EIF				(293)
+/**
+ * NE_ERR_MISSING_PCIE_VIRTIO - A flag that depends on the virtio-PCIe flag was
+ *				set without it.
+ */
+#define NE_ERR_MISSING_PCIE_VIRTIO		(294)
+/**
+ * NE_ERR_BAD_PAYLOAD_VERSION - The request's payload version is one the device
+ *				does not take.
+ */
+#define NE_ERR_BAD_PAYLOAD_VERSION		(295)
+/**
+ * NE_ERR_INFO_VECTORS_EXHAUSTED - No notification vector is left.
+ */
+#define NE_ERR_INFO_VECTORS_EXHAUSTED		(296)
+/**
+ * NE_ERR_TOO_MANY_ENCLAVES - The instance already has as many enclaves as its
+ *			      quota allows. A terminal answer: neither
+ *			      resending the command nor donating more memory
+ *			      changes it.
+ */
+#define NE_ERR_TOO_MANY_ENCLAVES		(297)
+/**
+ * NE_ERR_NO_MEM_SLOTS_ON_NODE - The memory budget of one NUMA node is used up,
+ *				 which -ENOSPC does not distinguish from the
+ *				 budget as a whole.
+ */
+#define NE_ERR_NO_MEM_SLOTS_ON_NODE		(298)
+/**
+ * NE_ERR_NUMA_SPAN - The enclave's CPUs and memory span more than one host NUMA
+ *		      node, and the enclave was not set up to span nodes.
+ */
+#define NE_ERR_NUMA_SPAN			(299)
+/**
+ * NE_ERR_NUMA_ALIGNMENT - The memory of a guest NUMA node other than the last
+ *			   is not a multiple of the guest's memory section size.
+ */
+#define NE_ERR_NUMA_ALIGNMENT			(300)
+/**
+ * NE_ERR_LOW_RAM_TOO_SMALL - The lowest contiguous run of enclave memory is too
+ *			      small for the boot layout the enclave needs.
+ */
+#define NE_ERR_LOW_RAM_TOO_SMALL		(301)
+/**
+ * NE_ERR_ZERO_REGION - The enclave's memory layout has a region of size zero.
+ */
+#define NE_ERR_ZERO_REGION			(302)
+
 /**
  * DOC: Image load info flags
  */
-- 
2.47.1

