Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560A21C2329;
	Fri, 13 Sep 2024 11:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726227927; cv=none; b=V3TxQTHmg/QluZIh+8cXGKjajPM5BWySNwmnZePg6iSZw4mJMRmq/5fvN07iW7dfpk0Eg3mei36SRm1Kf509aXUlBcEOwrXNc9Nx+XNwxtzLXBa5C8/Hbo3DOV1NxUCetTuxFuQ6TmygwixHnYY/TsOVmHH2CtZjLz8SiuX9230=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726227927; c=relaxed/simple;
	bh=5gCqffEEY+uJVOIxj4lpOmUetPSHP2Ivzv06iq0YMlQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nTgakd0OypU+FGLKAzgc7by43WNJxvCwvgIH5SQsSUevY1cVEgHGhf0Waw27dtnYT7KkNLkXmUyb++RvdX478HIaTn0aFVhfS5EhSVhOmS821RLLjRNmVRL7aoeRPr5kA78hTTLP8rxd8d+WjuGMnapaL5iPhg3IM3R9ghkt6XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4AgQxox; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4AgQxox"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D934BC4CEC6;
	Fri, 13 Sep 2024 11:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726227926;
	bh=5gCqffEEY+uJVOIxj4lpOmUetPSHP2Ivzv06iq0YMlQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=j4AgQxoxGfreELJisMzLb76TVFoJQpkM1ip6AcPaKiadRtCBvo8UhLYp8BEpkyukm
	 Jd+eSLCy6M9fjyd51Y1xNkcM//LsOipbPnCv9zfjlpycH24SupfgxJ2TzTUj2DqBKh
	 lzZTmiUH37hc4wra5M8Q/lAql0HMUdyb4PdASL5YOJmE6I+m0FGR7FrfnMLCifqyd+
	 eYJGTbvIE5AgKIV+4rU/KShuRQXGbqn3LiwAIgUyQagSrB4Elg0+TvK2pVYJG8+fvd
	 f/BUpTAcvWfDFWqX0RqEnV3aDrRl3sD3z5tOQhGxTV8D65nel/amid6pNCV3zyOTSs
	 9ED4aoOQPP+vw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E04EEE26C;
	Fri, 13 Sep 2024 11:45:26 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Subject: [PATCH v2 0/5] iommu: Enable user space IOPFs in non-PASID and
 non-svm cases
Date: Fri, 13 Sep 2024 13:44:46 +0200
Message-Id: <20240913-jag-iopfv8-v2-0-dea01c2343bc@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK4l5GYC/23MSw7CIBSF4a00dywGbmkqjtyH6YCUR69JoQElm
 oa9ix07/E9yvh2yTWQzXLsdki2UKYYWeOpgXnTwlpFpDchRcsUle2jPKG6uXJgYxtEZ5BLRQDt
 syTp6H9h9ar1Qfsb0OewifutfpgjGme0HqRRybVx/y3rNr+DPc1xhqrV+ARfglSCmAAAA
To: David Woodhouse <dwmw2@infradead.org>, 
 Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
 Klaus Jensen <its@irrelevant.dk>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 Joel Granados <j.granados@samsung.com>, Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.15-dev-00a43
X-Developer-Signature: v=1; a=openpgp-sha256; l=5895;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=5gCqffEEY+uJVOIxj4lpOmUetPSHP2Ivzv06iq0YMlQ=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGbkJdFU/EisRbOvZRbt26i+mdh7+r09RVV+/
 WrC2tYQkPa0I4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJm5CXRAAoJELqXzVK3
 lkFPoOIL/R/CtyadI9B7SrUOAfzagNFZns8T/Bj228nT899W8qfMMiD8HP6IjQQNJZQn9Xm7V3e
 2YMqTkmS6DQctaN5G4TC4De+a8p7wrFc1Wowwnv1G6cXShaxWULLoeKyRk4F/EjCagWS4/3pNne
 HSUEU+zYcQMYVTIpvmG4kH/AZwfJg3M5GV3bHo7mdZfygJ8JGPmCKkThoriS7UeOPSApuj0Ykm2
 W9GRoLYiQEAFfrLRmPkThJkXJAHxvNp1LGXfAV72O97UiMHqkxYxLi0HyacfErHul6AUV4dlIvt
 T2vKxtNX6FNQTFcjFvxPjq7v7ORJl8RMgzVamcBMN7BBP6pFKn8QnZqNDAvB6r40RPYpB3Mbpiz
 O9fjaMLqROxr4wOqHHcWFTQX4QHvbxwmG4W0r/bae6ToC2Seyysat2prqPccNENy2Zt4AbS48cb
 +KYnjejxT0E0htHw6AYv/XOQKpHSVqvshCM+1GeMBbiTwA0NOLctx9NtBZ0+SC5QodctGn46Ue8
 UY=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with
 auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: j.granados@samsung.com

This series makes use of iommufd_hwpt_replace_device to execute
non-pasid/non-svm user space IOPFs. Our main motivation is to enable
user-space driver driven device verification without SVM/PASID.

What?
  * Enable IO page fault handling in user space for a non-pasid, non-svm
    and non-virtualised use case.
  * Move IOMMU_IOPF configuration from INTEL_IOMMU_SVM into INTEL_IOMMU.
  * Move all page request queue related logic to a new (prq.c) file.
  * Remove PASID checks from PRQ event handling as well as PRQ
    initialization.
  * Allow execution of IOMMU_HWPT_ALLOC with a valid fault id
    (IOMMU_HWPT_FAULT_ID_VALID)
  * Insert a zero handle into the PASID array in dev->iommu_group when
    replacing the old HWPT with an IOPF enabled HWPT.

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
  The non-svm IOPF interface is exercised by first initializing an IOPF
  enabled IOAS and then reading the fault file descriptor. Pseudocode on
  the iopf initializing and handling is in [3] and [4] (using libvfn).

  Supplementary repositories supporting this patchset:
    1. A user space library libvfn [1] which is used for testing and
       verification (see examples/iopf.c), and
    2. Basic emulation of PCIe ATS/PRI and Intel VT-d PRQ in QEMU [2].

Changes in v2:
  - Remove "nesting" from wording. This wording is left over from initial
    versions that are now irrelevant.
  - Dropped "iommu: init pasid array while doing domain_replace and iopf
    is active" as the initialization of the pasid_array x-array happens
    automatically when an iopf capable domain is replaced on a device.
  - Corrected commit message in "iommu/vt-d: Separate page request queue
    from SVM"
  - Link to v1: https://lore.kernel.org/r/20240904-jag-iopfv8-v1-0-e3549920adf3@samsung.com

V1:
  - This is the first version of the series after initial feedback from
    the RFC [5].

Comments and feedback are greatly appreciated
Best

Joel

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

[5] https://lore.kernel.org/20240826-iopf-for-all-v1-0-59174e6a7528@samsung.com

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
Joel Granados (3):
      iommu/vt-d: Separate page request queue from SVM
      iommu: kconfig: Move IOMMU_IOPF into INTEL_IOMMU
      iommufd: Enable PRI when doing the iommufd_hwpt_alloc

Klaus Jensen (2):
      iommu/vt-d: Remove the pasid present check in prq_event_thread
      iommu/vt-d: drop pasid requirement for prq initialization

 drivers/iommu/intel/Kconfig          |   2 +-
 drivers/iommu/intel/Makefile         |   2 +-
 drivers/iommu/intel/iommu.c          |  29 +--
 drivers/iommu/intel/iommu.h          |  14 +-
 drivers/iommu/intel/prq.c            | 404 +++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/svm.c            | 397 ----------------------------------
 drivers/iommu/iommufd/hw_pagetable.c |   3 +-
 7 files changed, 425 insertions(+), 426 deletions(-)
---
base-commit: 431c1646e1f86b949fa3685efc50b660a364c2b6
change-id: 20240904-jag-iopfv8-1577fd20422d

Best regards,
-- 
Joel Granados <j.granados@samsung.com>


