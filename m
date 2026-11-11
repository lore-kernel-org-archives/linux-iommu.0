Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.83.148.184
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794438843;
	b=nuvBb3ecgV1g7w5yabuZnP6w+9oLkQJhsZdcLPwc8dl7D/HzA6070zup+tlDgvNusjA2
	 b0/mJDsD66t1rO1ihnkubae9QxJ1Is1bFQVHXROlMUSIlxl/SwkD2O8em/avNEBa6pEBd
	 GT32Qoeb54Zml1FV0MBAK14eT9v3gIYUNGzgvvilBCFrm+P3gcZ/bsFWmMsLb8YAMd0ZD
	 O12e/qVORcx7umIaDbTleWkDE1Jz/swC1VL2CdCLJnh9UQm62iZrQmGcl0R77QPESbhpm
	 LicYNSk71XwOseATfX+d9CAZmTtCtAKOA3ZkY739m+5b0Iqc4rJObSfkiDSg0GzaAPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794438843;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=YE3Omn29rE1S2bQW+kmuZewe1GXmkpcFPI6VWCg3I6U=;
	b=CbdpYs3BDMcpWo868sx8tcm+QylalAx+YIDwHP7A2AfYH1EIHZwTIRQn8O5LLIDPP5s4
	 0t8OF5uFHalWnj7+SAMYG71UrSqUuj/+X1YAf1U4L08IL6O/C6pmEfPbJZK3qciDzAGsO
	 RcQA/yg8hvomAxIrCOkvrR5KnPwPqerDWIpPfYJbmFhUrNFjA1eAFzhqO33ANeuM3/rDZ
	 uGj6qsk7Wsqg/pFTamXNZyzUX5kT2UZ+ZfLSvZHPxMPexxqiwnmXn3y18aZL5IYwsSM4v
	 itasE8L8JTs4QFHNiBs4xqWekW2LgiT+X7RfR7QPna+BED87qr/jzUy0kfF5fR5/WSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=fstaKG2y;
	arc=none smtp.remote-ip=35.83.148.184
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577BA606A326
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 23:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 577BA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=fstaKG2y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794438843; x=1825974843;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YE3Omn29rE1S2bQW+kmuZewe1GXmkpcFPI6VWCg3I6U=;
  b=fstaKG2yd5+E/9l6ifoh1NT2ZroGMf1uuhClwCg/nA84a5skQK7ddPGh
   OivzcojNYEvjjrsnbviHkpx+tYGPQ6zxPUD1zP8WHLN/1TxRwT5nL+xC3
   Az4NKijK887p5DVOZqwr/Wjc7j3t3q4lHyNRdc+OIyCONrPHN6h35Pntt
   ZzBRw5n8Klm6gKSZQHDbq/+AEv5HQ08eAF0uGD0G0ssGNUrb0qKhGCSnR
   sOqNptxhTpDhDYclBilVebXbAtMvJxBTbvnwsj4YVBxtwkcrcNxkRGVOr
   h9H0O4akpSztMaCGOvaBbrM9W5ABfYd17aptxydHKrK3LmiuqiOCp0tTd
   g==;
X-CSE-ConnectionGUID: U8t3y49qRK2yKOTtRsmNqQ==
X-CSE-MsgGUID: qhRG+rLpT4ebH7E5UzMWWQ==
X-IronPort-AV: E=Sophos;i="6.27,208,1787011200"; 
   d="scan'208";a="33551552"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 23:14:03 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:22885]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.227:2525] with esmtp (Farcaster)
 id 5be80b4a-ae4c-4ed0-bacf-81eb9d64e629; Wed, 11 Nov 2026 23:14:02 +0000 (UTC)
X-Farcaster-Flow-ID: 5be80b4a-ae4c-4ed0-bacf-81eb9d64e629
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 23:14:02 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 23:13:59 +0000
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
Subject: [PATCH 40/40] nitro_enclaves: Document the driver side of Nitro Sandboxes
Date: Wed, 11 Nov 2026 22:59:44 +0000
Message-ID: <2d8e0949932082a4730fb094d15b8cf5f3cfc212.1794393491.git.graf@amazon.com>
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
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Users of Nitro Sandboxes and authors of their parent tooling need one
place that explains how the calls that Nitro Sandboxes add fit together.

Document the driver functionality that Nitro Sandboxes add in
ne_overview.rst: what NE_GET_CAPS reports, the launch flags
NE_CREATE_VM2 takes, direct mode, why a slot needs its info page first,
what NE_ADD_DEVICE names and returns, and the two directions an event
travels. Link the public AWS documentation of Nitro Sandboxes for the
user side.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 Documentation/virt/ne_overview.rst | 82 ++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/Documentation/virt/ne_overview.rst b/Documentation/virt/ne_overview.rst
index 3aa33d3f06cf2..dbf9261d0391e 100644
--- a/Documentation/virt/ne_overview.rst
+++ b/Documentation/virt/ne_overview.rst
@@ -270,3 +270,85 @@ The device holds every donated page until it is told to let go, so the driver
 takes the whole pool back when a probe fails after donating, when it is unbound
 and when the machine shuts down, and the pages reach the allocator only after
 that has returned. Pages the device will not give back stay with it.
+
+Nitro Sandboxes
+---------------
+
+Nitro Sandboxes [9] build on top of Nitro Enclaves technology. They provide
+a sandbox VM with parent backed virtio devices on a PCIe bus, so it can have
+block devices, network interfaces and a console like any other virtio guest,
+and the parent provides them from an ordinary user space process. The driver
+functionality that Nitro Sandboxes add is described here.
+
+NE_GET_CAPS reports what this kernel implements: NE_CAP_DEVICES covers
+NE_SET_INFO_PAGE, NE_ADD_DEVICE, NE_SET_NOTIFY_EVENTFD, NE_SET_VRING_CALL and
+NE_UPDATE_DEVICE_CONFIG. The argument carries its own length in struct_size and
+the kernel writes back how many bytes it filled, so a caller built against a
+header this kernel predates can tell a field this kernel never wrote from one it
+wrote a zero into.
+
+NE_CREATE_VM2 takes a word of launch flags, and NE_CREATE_VM is the same call
+with a zero one. NE_ENCLAVE_PCIE_MODE asks for a slot with a PCIe bus, and the
+other launch flags shape that bus or the slot. The flags in
+NE_ENCLAVE_FLAG_MATCHED_MASK are the ones the hypervisor enumerates, and two
+fields answer for them. ne_caps.supported_matched_flags reports which of them
+this kernel passes on, and is the same on every host.
+ne_caps.hypervisor_matched_flags reports which of them the host behind the
+device says it implements. A caller requires a flag in supported_matched_flags
+always, and in hypervisor_matched_flags as well when that field is non-zero.
+A zero hypervisor_matched_flags means that the host gave no answer, because it
+reports no flag or because there is no device to ask, and NE_CREATE_VM2 is then
+the only test. On a device that takes no launch flags at all, it fails with
+EOPNOTSUPP. For the flags in NE_ENCLAVE_FLAG_UNMATCHED_MASK the answer comes
+from allocating a slot with them. Bits outside the matched mask read zero in
+both fields whatever the hypervisor does with them, so a caller masks its
+request before comparing.
+
+Nitro Sandboxes introduce a mode called direct mode, selected with
+NE_ENCLAVE_DIRECT_MODE, in which the parent keeps access to most of the memory
+it donates to the sandbox. Direct mode disables attestation, but lets guest
+kernels that do not place their virtqueues in device-provided memory run in a
+sandbox. A slot in direct mode takes NE_MEMORY_SHARED allocations as memory
+regions.
+
+A slot needs its info page before it can be given a device. The device reports
+how the sandbox reaches each of its virtqueues by writing the info page, and
+NE_ADD_DEVICE reads those entries back out of it, so NE_SET_INFO_PAGE comes
+first; see `Memory pool`_.
+
+NE_ADD_DEVICE names the device with a type whose top 16 bits are the class, of
+which NE_DEVICE_TYPE_VIRTIO is the only one, and whose low 16 bits carry the
+virtio device id the sandbox sees. It carries the feature bits the parent offers
+for the device and the opening bytes of the device's configuration space, and
+names the NE_ALLOC_MEMORY allocations the device works out of. Each of those has
+to be NE_MEMORY_SHARED, because the parent drives its end of the queues through
+a mapping of one, and each is named with the id the sandbox knows that region
+by. The driver puts that id in the top 8 bits of the size it reports for every
+run of the allocation, which is how a device made of several regions tells them
+apart; the parent and the sandbox agree on the numbering and the driver does not
+read it. A device that works out of the sandbox's own memory regions says so
+with NE_DEVICE_NO_SHM_REGIONS and names no region. An allocation is a device's
+memory, an enclave's memory or an info page, never two of those, and the driver
+holds it until the enclave is gone, so closing the descriptor does not take the
+runs away from the device. The call returns the id the device was given and, for
+each of its virtqueues, the interrupt vector, the notify index and the doorbell
+offset. It takes a device on a running sandbox when the slot was allocated with
+NE_ENCLAVE_PCIE_HOTPLUG_MODE.
+
+Notifications travel both ways. Towards the parent, the device signals through
+an interrupt multiplexer built into the nitro_enclaves device: it raises one of
+a pool of MSI-X vectors, and records in a bitmap page per vector, which the
+driver donates, which notifications were raised. NE_SET_NOTIFY_EVENTFD binds an
+eventfd to one of them, which is the kick of one of the sandbox's virtqueues or
+the change of a device's entry in the info page. Towards the sandbox,
+NE_SET_VRING_CALL binds an eventfd whose signal rings a virtqueue doorbell, so
+the sandbox learns that the queue has data waiting for it. Either takes
+NE_EVENTFD_UNBIND in place of a descriptor to release the binding, and binding
+one the caller already holds replaces the eventfd on it.
+
+NE_UPDATE_DEVICE_CONFIG writes the configuration space of a device a sandbox
+already has, naming it by the id NE_ADD_DEVICE returned.
+ne_caps.max_config_update_size bounds how many bytes one call moves, not how far
+into that space they reach.
+
+[9] https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/amazon-ec2-nitro-sandboxes.html
-- 
2.47.1

