Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3369D13DDD9
	for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 11:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724672456; cv=none; b=TJYuvxkQelLAGXpPwPb+6SPEDKSdBJhoPIvKZtdrJkW/lxSvmRPPNjugiHoH5InFrfWLLK23CHmMTM1N+ZAS9mmGAb5g+gnYe+jbhdSeDvF2EYjdj305mBvhAACSN+2UP6irs78Jmdx2aWqD5f+0aQx4rVzzwRHhVSRGL59/p4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724672456; c=relaxed/simple;
	bh=AOKCN3pcEInzWzY591sIXcr7L729m4cdv7zQgCLMqQA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UrEZdujb4ro81jGdznq8hvOs4SaJ9Qp3kv++emneUelN3YsMfa2oWLtLw0a+17k+sMYShkx+yWQmx3Mywk5GH/5IAhBV50UAvosq9ho2//KSAt7TWj1YZ4yEh95VmHanOp+u6UF5Q/lnZd6H/rwxHWYbTYYPQ4HpczF1RdPyeE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk; spf=pass smtp.mailfrom=irrelevant.dk; dkim=pass (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b=FTINSCa0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XDgTdXlD; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irrelevant.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="FTINSCa0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XDgTdXlD"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 265171151B2B;
	Mon, 26 Aug 2024 07:40:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 26 Aug 2024 07:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to; s=fm3; t=1724672452; x=
	1724758852; bh=YILOmF+9Yg51GcabLK1dCq9X7yDH0FEOgB9qW8eVdLw=; b=F
	TINSCa0zh1zUacnpki6T9s/QxOFuP5t7DZOiaEmTt9hrWXpm9LNqQgFzYv+Sxruu
	CLn72YVccWrr2HJtwq0AOfVR2HL8oNUubTX2auUzDN2Tqd/z6zpA0Z6USOXSi5To
	/uHg1ziinWqd0eMPHnYRZ/GRlvSMVwKmUumKsyl38T01c8VQYkFqDFaIItJuIpS/
	JHOVE+SNRnAE7HUmZLHWFmHGy6fcYrJrn7bbGtgHjRBdfzB/8/xKleCTLEQPQGxD
	obmXA9I8JAi1FfPjFlZu7+1P/TDi7gDvQaSta3QxaR5G1mMhWzqnY3pW5HIBYsNp
	nqjU2Rh4QlzcKJOy0VZew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1724672452; x=1724758852; bh=YILOmF+9Yg51G
	cabLK1dCq9X7yDH0FEOgB9qW8eVdLw=; b=XDgTdXlDVYWDQ8zy4ZzDwuKhuplZg
	yQQr6OSKzHHbbUCIOrQIsCOqqwyHV7+e/GoeqoZH+nmEA3DwHiPfo0fUKapdrbNC
	cS/syJlgu76jsXUL/cnJxaru0GkjIsHKPp7aObcueM4hw3foiSbMKAuaHMB8kgo7
	X+K8VJ6LTvSJ339vhuB3DTtbnLegLoBAtv0zos/kO1Bo8QwKOXOKMtWCu3ZKHRaI
	sj/hrzPNmY5L5Qog97LdB/gaNApvmH1419QvRN8KdxTOOwGsFaeFI1wnGKlZkANr
	eORBQ4pUoP6HIyF0EuEpKVyuP5ay0ZT/NWr6gyM2C0Or1dXKiW7fkGdsw==
X-ME-Sender: <xms:w2nMZumWPQvLdroEdZXEQ5950cqZv_Fz-HY_YTvYXHHkNVTruBG5uQ>
    <xme:w2nMZl2zkJP7ExVOjt1FJWBqUY4eCdCkdTcfJFZswy_DIQ1-7BQH1PIK6KDwHcAeb
    Ou1ikc7yZjRJkftRGs>
X-ME-Received: <xmr:w2nMZspE3swJHWbh-HU12k1yQjjs04SH-E_vXM6q9hsUGnw2aUyXTzdVr4by42pUDqOYRDpgK64r88WEWiL2fw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvkedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecu
    hfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrug
    hkqeenucggtffrrghtthgvrhhnpeffteehuefhuedtiedutdduledutdegtdfffedvkedt
    ieegudfhueffkeekvefhgeenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhgihhtlh
    grsgdrtghomhdpohhuthgpuggvvhhiugdrphhtnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdpnh
    gspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjrdhg
    rhgrnhgrughoshesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehkrdhjvghnshgvnh
    esshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehkvghvihhnrdhtihgrnhesihhnthgv
    lhdrtghomhdprhgtphhtthhopegufihmfidvsehinhhfrhgruggvrggurdhorhhgpdhrtg
    hpthhtohepihhomhhmuheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehr
    ohgsihhnrdhmuhhrphhhhiesrghrmhdrtghomhdprhgtphhtthhopegsrgholhhurdhluh
    eslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehmihhnfihoohdrihhmsehs
    rghmshhunhhgrdgtohhmpdhrtghpthhtohepjhhorhhoseeksgihthgvshdrohhrgh
X-ME-Proxy: <xmx:w2nMZikyjMf3s4nOEeG6TMKzSXiQH2bNVD6m2LraidY3sH3j9YGOeg>
    <xmx:w2nMZs310fN_iwLTJjMxHrvU55d7fzxqlhoewO6bciEj5CV5ZacJNQ>
    <xmx:w2nMZptyHlNajwH9MLxrDietWKGOL0nGGKNDYoiM95FbUdHmuLJPlA>
    <xmx:w2nMZoWfb0I1K1otHze66VoudBy-uQniNqmwaDRb3iKVhol_bJ512g>
    <xmx:xGnMZiOLhozCJlRNlQ9lMjkOF8jxC6yTDSzuDCNn_iX1D4thx7gFDXed>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Aug 2024 07:40:49 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Subject: [PATCH RFC PREVIEW 0/6] iommu: enable user space iopfs in
 non-nested and non-svm cases
Date: Mon, 26 Aug 2024 13:40:26 +0200
Message-Id: <20240826-iopf-for-all-v1-0-59174e6a7528@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKppzGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCyNj3cz8gjTdtPwi3cScHF3jJENLA3PT1LRkYyMloJaCotS0zAqwcdF
 KQW7OILGAINcwT9dwpdjaWgAgz9MbbgAAAA==
To: David Woodhouse <dwmw2@infradead.org>, 
 Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: Minwoo Im <minwoo.im@samsung.com>, linux-kernel@vger.kernel.org, 
 iommu@lists.linux.dev, Joel Granados <j.granados@samsung.com>, 
 Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=6011; i=k.jensen@samsung.com;
 h=from:subject:message-id; bh=AOKCN3pcEInzWzY591sIXcr7L729m4cdv7zQgCLMqQA=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR2JNYWI3VnNXSW9tY2NWZXlJem9sS2QzUnFICmlCalc0RTlTcU9pQUd2VUww
 Z3lpN0lrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKbXpHbSt
 BQW9KRUUzaHJ6RnRUdzNwQW53SCtnTTIxcEQwT1pEcFkyRStEM0N0NldKNXZwWFNBN3d3c3NoZg
 o4ZXozaXZ0ZVpXOHZKdnNJeWhQTGtjODV0RTdMeHNJQmhaemN2WDlGOU53dU5YbWRlaklJTytON
 nZRNDZGUW8wCmQzSnBxR0ZiV1d2b3IwZkNjanp5UGl5SnUwNFdtaklFVlZFbzliNmpoN2JCSDBX
 dy9LM0YwNUlMZXBaT3hFclEKL01PSDZxaDdjdjk1Y3RNbXpFUk4xQzA3SHQ1ZGFvTTF2WDdoYWU
 3QVpiVU91YVlEOXRJdGZzMjlaenEzVmQvawpRWUVzSlhxdnJMTWRtcXJ0b3p4NGtlOTY1K3JaSH
 AvTXpkczZBL3RHeG9NdzJQMzBkTzljNUtJZEo0ZVdtejI2Ci9vTklCUnU2dVRiUnlWUFVBUVV1Z
 HlxZnZ1NUlrMXRKV0xaRUxzRjFlOG50TU12UWYxdThmTENWCj1nR0s1Ci0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838

This is a Request for Comment series that will hopefully generate
initial feedback on the use of the iommufd_hwpt_replace_device to
execute non-nested and non-svm user space IOPFs. Our main motivation is
to enable user-space driver driven device verification with default
pasid and without nesting nor SVM.

What?
  * Enable IO page fault handling in user space in a non-nested, non-svm
    and non-virtualised use case.
  * Removing the relation between IOPF and INTEL_IOMMU_SVM by allowing
    the user to (de)select the IOPF code through Kconfig.
  * Create a new file under iommu/intel (prq.c) that contains all the
    page request queue related logic and is not under intel/svm.c.
  * Add the IOMMU_HWPT_FAULT_ID_VALID to the valid flags used to create
    IOMMU_HWPT_ALLOC allocations.
  * Create a default (zero) pasid handle and insert it to the pasid
    array within the dev->iommu_group when replacing the old HWPT with
    an iopf enabled HWPT.

Why?
  The PCI ATS Extended Capability allows peripheral devices to
  participate in the caching of translations when operating under an
  IOMMU. Further, the ATS Page Request Interface (PRI) Extension allows
  devices to handle missing mappings. Currently, PRI is mainly used in
  the context of Shared Virtual Addressing, requiring support for the
  Process Address Space Identifier (PASID) capability, but other use
  cases such as enabling user-space driver driven device verification
  and reducing memory pinning exists. This patchest sets out to enable
  these use cases.

Testing?
  The non-nested/non-svm IOPF interface is exercised by first
  initializing an iopf enabled ioas and then reading the fault file
  descriptor. Pseudocode on the iopf initializing and handling is in [3]
  and [4] (using libvfn).

  Supplementary repositories supporting this patchset:
    1. A user space library libvfn [1] which is used for testing and
       verification (see examples/iopf.c), and
    2. Basic emulation of PCIe ATS/PRI and Intel VT-d PRQ in QEMU [2].

Notes
  Patches 5/6 are added by Klaus for testing against the QEMU test
  device (which does not support PASID). They are very much RFC.

Comments and feedback are greatly appreciated

Best

Joel

PS: I'm on PTO, so my answers might be delayed (back September 2nd). But
    I'll give priority to answer any questions or feedback when I see
    it.

[1] https://github.com/SamsungDS/libvfn/tree/iommufd-fault-queue
[2] https://gitlab.com/birkelund/qemu/-/tree/pcie-ats-pri

[3] Initializing
```
  int iopf_init(struct iommu_ioas *ioas, const char *bdf)
  {
      // open vfio device from bdf
      int devfd = open('/dev/vfio/devices/VFIO_DEV', O_RDWR);

      struct vfio_device_bind_iommufd bind = {
          .argsz = sizeof(bind),
          .flags = 0,
          .iommufd = __iommufd,
      };
      ioctl(devfd, VFIO_DEVICE_BIND_IOMMUFD, &bind);

      struct iommu_ioas *ioas = ioas;
      struct vfio_device_attach_iommufd_pt attach_data = {
          .argsz = sizeof(attach_data),
          .flags = 0,
          .pt_id = ioas->id,
      };
      ioctl(devfd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach_data);

      struct iommu_fault_alloc fault = {
          .size = sizeof(fault),
          .flags = 0,
      };
      ioctl(__iommufd, IOMMU_FAULT_QUEUE_ALLOC, &fault);

      struct iommu_hwpt_alloc fault_cmd = {
          .size = sizeof(fault_cmd),
          .flags = IOMMU_HWPT_FAULT_ID_VALID,
          .dev_id = bind.out_devid,
          .pt_id = ioas->id,
          .data_len = 0,
          .data_uptr = (uint64_t)NULL,
          .fault_id = fault.out_fault_id,
          .__reserved = 0,
          };
      ioctl(__iommufd, IOMMU_HWPT_ALLOC, &fault_cmd);

      // This is a re-attach
      struct vfio_device_attach_iommufd_pt attach = {
          .argsz = sizeof(attach),
          .flags = 0,
          .pt_id = fault_cmd.out_hwpt_id
      };
      ioctl(dev_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach);
  }
```

[4] Handling
```
  int handle_iopf(void *vaddr, int len, uint64_t iova) {
    exec_command(CMD)

    int iopf_fd = fault_cmd.fault_id;

    struct iommu_hwpt_pgfault pgfault = {0};
    if(read(iopf_fd, &pgfault, sizeof(pgfault)) == 0);
      return; // no page fault

    ret = iommu_map_vaddr(__iommmufd, vaddr, len, &iova)
    struct iommu_hwpt_page_response pgfault_response = {
      .cookie = pgfault.cookie,
      .code = ret ? IOMMUFD_PAGE_RESP_SUCCESS : IOMMUFD_PAGE_RESP_INVALID,
    };

    write(iopf_fd, &pgfault_response, sizeof(pgfault_response));

    return;
  }
```

Signed-off-by: Joel Granados <j.granados@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
Joel Granados (4):
      iommu/vt-d: Separate page request queue from SVM
      iommu: Make IOMMU_IOPF selectable in Kconfig
      iommufd: Enable PRI when doing the iommufd_hwpt_alloc
      iommu: init pasid array while doing domain_replace and iopf is active

Klaus Jensen (2):
      iommu/vt-d: drop pasid requirement for prq initialization
      iommu/vt-d: do not require a PASID in page requests

 drivers/iommu/Kconfig                |   2 +-
 drivers/iommu/intel/Kconfig          |   1 -
 drivers/iommu/intel/Makefile         |   2 +-
 drivers/iommu/intel/iommu.c          |  29 ++--
 drivers/iommu/intel/iommu.h          |  40 ++++-
 drivers/iommu/intel/prq.c            | 284 ++++++++++++++++++++++++++++++++
 drivers/iommu/intel/svm.c            | 308 -----------------------------------
 drivers/iommu/iommu-priv.h           |   3 +
 drivers/iommu/iommu.c                |  31 ++++
 drivers/iommu/iommufd/fault.c        |  22 +++
 drivers/iommu/iommufd/hw_pagetable.c |   3 +-
 11 files changed, 389 insertions(+), 336 deletions(-)
---
base-commit: 3d5f968a177d468cd13568ef901c5be84d83d32b
change-id: 20240823-iopf-for-all-3b19075efc32

Best regards,
-- 
Klaus Jensen <k.jensen@samsung.com>

