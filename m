Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA491F81AF;
	Tue, 15 Oct 2024 21:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729026509; cv=none; b=ldIpTPw5qgCAftjbMqUDydxPsZDD3FUF9TZ18sQl3EbymeuS6S5YcnFg/53K7RdOQfE4fwTC/wyQ121wqJBRXOdssm6G84dFdm6S3g0e7Nm+9SuVRkA+QVrZMszvLqB5tCaM0zc3JR+nUOlk5HFiehhUX7ao8Y9b9Zd0sB/XHmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729026509; c=relaxed/simple;
	bh=aSdBveB0RJ5LBbniwGgqbvd0aabvEW6uiJ3pHGBTkt4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YvL57vPUxsMiE9LF1Kdh2bYj9KQUxIK7R+6q7WQ0F4QJ+q22MwTUut+2YzjvN2a+hY9nh8elPir0oaWGxVm6HGHSRmO5HLdSs8G5EeNQEYzJJiVk08GndLGsZkq4ZOxpEmjxLZV4h1+gaQecvFlLzOthqSFBmLuIGOpIYRHVjg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZIVz2U3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZIVz2U3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09778C4CEC7;
	Tue, 15 Oct 2024 21:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729026509;
	bh=aSdBveB0RJ5LBbniwGgqbvd0aabvEW6uiJ3pHGBTkt4=;
	h=From:Subject:Date:To:Cc:From;
	b=qZIVz2U3236+UVqPAv5wY/FBiiPJPp+TwhWuWTiL+qpuawQvGQR/f64DcwKwlBtoD
	 5UUZXlxD77tsWOFW4116BMLch+K/zjZWp8+lByD4CjvuBXEjr8Q26gBr58hSXMNzmN
	 j4Vpi3V3Taj+Dz14muuGmlVivL1GbJu8zTRYMLtVEjlcl5NE0uP9SCeQqXPhZxXfl3
	 Ncbl4S7btqSjnSWhwrlY6sij/jvEAIPumpCgoqkgkOYnbz8amcFZogsjjZ2WvH6Tn9
	 WZRoQ7kZ0CEpwF81z1wbk807igjRgLqPW9i9kqxWtHbDIPhqL0FFrgwuDMNBNYlJLa
	 RBEUucpqbk58g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C54D1D876;
	Tue, 15 Oct 2024 21:08:28 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Subject: [PATCH v4 0/5] iommu: Enable user space IOPFs in non-PASID and
 non-svm cases
Date: Tue, 15 Oct 2024 23:08:10 +0200
Message-Id: <20241015-jag-iopfv8-v4-0-b696ca89ba29@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALrZDmcC/23MSw7CIBSF4a0YxtJcLjS1jroP44CWS8VHMaBE0
 3Tv0g6MRofnJN8/skjBUWTb1cgCJRedH/JQ6xXrDnroiTuTN0NABTUoftQ9d/5q04aLsqqsQVC
 IhmVwDWTdY4nt9nkfXLz58FzaSczv30wSHDjJUtU1gjZWNlFf4n3oi85f2BxK+IGF/MKYsSENo
 kOpZNv9YvnGAqD+wjLj1iishLFli21zojDQufChZ/tpml4fYEX6HwEAAA==
To: David Woodhouse <dwmw2@infradead.org>, 
 Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
 Klaus Jensen <its@irrelevant.dk>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 Joel Granados <joel.granados@kernel.org>, 
 Joel Granados <joel.granados@kernel.org>, 
 Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.15-dev-00a43
X-Developer-Signature: v=1; a=openpgp-sha256; l=6313;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=aSdBveB0RJ5LBbniwGgqbvd0aabvEW6uiJ3pHGBTkt4=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGcO2cj22+IOAGjbpiM+pHvaCkqNf1LT6bso7
 aLmajRVD3GDSokBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJnDtnIAAoJELqXzVK3
 lkFP6sgL/1tZM9jirrW63LVdZ8BiED6a3F0WURHb7xuBgzsK/T2HDVQcd/VectcG5XcGMruyFSa
 GhlFjqCPqupMD4QA+TRxCKtFfQYYm9rpy5yf0WZs+6b/4lAq1bvzveXuPbItc8dfaRgYdjwaPpn
 7MhDZLpc6iLFLSQ8tShuYTSbwW2qH+YbzeiRISF8GXats2i8UVVOS86eXsoA3gIxLTeBcTs14j3
 S+YAwj1tb1cukIOsXFdakmuUaZsftg+J2IqpcHakWwm+h1NzSH+MEhUJLDwEikzaOIFMd/DOnq9
 xDrhd+xLN6GCwrjwTKe8DhbHXHMV2tAs6ZFNzohQ685nm7xIlUOonA7i2JkYNadZ7oJlLtW/YbN
 ghkUxh/qWY7tzP287qLGzzbjHS4tiZ086cYxzfdlIBWxcj1cUMBnJq1aQi7/Im649rp0wbKpZLE
 6jwMbDf7RdGbKNaG3GkTwGkpVdsAxO/hz5zxNvcFyhhdhJX9bX3AGe3TWF2UNDOBNWjHUn9e1y6
 Yk=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

This series makes use of iommufd_hwpt_replace_device to execute
non-pasid/non-svm user space IOPFs. Our main motivation is to expand or
facilitate user-space driver driven device verification by enabling IOPF
without SVM/PASID.

What?
  * Enable IO page fault handling in user space for a non-pasid, non-svm
    and non-virtualised use case.
  * Move IOMMU_IOPF configuration from INTEL_IOMMU_SVM into INTEL_IOMMU.
  * Move all page request queue related logic to a new (prq.c) file.
  * Remove PASID checks from PRQ event handling as well as PRQ
    initialization.
  * Allow execution of IOMMU_HWPT_ALLOC with a valid fault id
    (IOMMU_HWPT_FAULT_ID_VALID)

Why?
  The PCI ATS Extended Capability allows peripheral devices to
  participate in the caching of translations when operating under an
  IOMMU. Further, the ATS Page Request Interface (PRI) Extension allows
  devices to handle missing mappings. Currently, PRI is mainly used in
  the context of Shared Virtual Addressing, requiring support for the
  Process Address Space Identifier (PASID) capability which is not
  strictly necessary. Relaxing this requirement adds to the
  possibilities available for user-space driver driver device
  verification as well as for avoiding pinning.

Testing?
  The non-svm IOPF interface is exercised by first initializing an IOPF
  enabled IOAS and then reading the fault file descriptor. Pseudocode on
  the IOPF initializing and handling is in [3] and [4] (using libvfn).

  Supplementary repositories supporting this patchset:
    1. A user space library libvfn [1] which is used for testing and
       verification (see examples/iopf.c), and
    2. Basic emulation of PCIe ATS/PRI and Intel VT-d PRQ in QEMU [2].

Changes in v4:
- Include the "trailers" from Kevin that I missed on V3
- Link to v3: https://lore.kernel.org/r/20241009-jag-iopfv8-v3-0-bd4271df5b2b@kernel.org

Changes in v3:
- Adjust wording in cover letter
- Include "_iommu_" in the prq Intel function names to be more in line
  with functions in iommu.h file
- Rebase on top of 6.12-rc2
- Update my ID in e-mail, git author and my Signed-off-by.
- Link to v2: https://lore.kernel.org/r/20240913-jag-iopfv8-v2-0-dea01c2343bc@samsung.com

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
 drivers/iommu/intel/iommu.c          |  31 ++-
 drivers/iommu/intel/iommu.h          |  14 +-
 drivers/iommu/intel/prq.c            | 406 +++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/svm.c            | 397 ----------------------------------
 drivers/iommu/iommufd/hw_pagetable.c |   3 +-
 7 files changed, 428 insertions(+), 427 deletions(-)
---
base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
change-id: 20240904-jag-iopfv8-1577fd20422d

Best regards,
-- 
Joel Granados <joel.granados@kernel.org>


