Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD96A1DFE4
	for <iommu@lists.linux.dev>; Sat,  2 Nov 2024 03:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730518046; cv=none; b=tVEyduvaTZF3UeiD7/m3oY8uWTvyfQ3qlAlVTmwOKMFAgjMFIJLvg/fhVGA60WCaINB9SLvjt3nEPwBDAKUs/iw9C6Ux4jgnz3taRagmmG7ii+psT8v94stANEd+u2ktBjTjRzRVFEpEu4D0sav5Q5oqKyag4wrgKZFr/wVeCIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730518046; c=relaxed/simple;
	bh=wOopVkqPDz89zHO/MT7aRO4B5QbAZAlomriP4waWOFI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=be8aCXtvrbq32RauAcinssIxXU6+lPNETmTRk+SFj90LTMFDn07t8XzVEMpuqztPV1VfuLlmjKFt+W6ullsfEzHsfL+B0p+psYH2JA+ngCxyI9M7JoO+lQFTIoDBKMoI10exCZPNnI9MwoLRdbmLRGV3SaBuaLhJhxdoXdhKDU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=REoosbxb; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="REoosbxb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730518044; x=1762054044;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wOopVkqPDz89zHO/MT7aRO4B5QbAZAlomriP4waWOFI=;
  b=REoosbxbvQxbxwyUmsXuqfH1Ll/lkicTyStxHM+nbKBocpGgW1SrtJgn
   heZU3yqtpITvtJ33Z+6fai/oiPetghNqRDGJYKsrm2NzXwOS2ho+ySynI
   KY0GlJ33K8D5ag1DoOVliqLFZXw8GJXFZc2vAUkPLj/WZR7zuk/XBWtDy
   XlFSizdu+djbBEW7szc5LCI3VxGvT2EtJEE9oC3KfOc7GKrefgSFrBn0R
   YV3h0kfHtgC6BcD+WX66n9IHwWFg0+NVEGNL44aIEVwvrpdy8u+KUCz9Y
   5non7Y9stpNK5luD5idHFjhStVlBxbzv7R4ISACrWj4qJQMQyd/xXIuzu
   A==;
X-CSE-ConnectionGUID: icU/u478Rwe6PAAtTrs9MQ==
X-CSE-MsgGUID: mgigOHHnTr+SWaqx+F0wzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11243"; a="40921803"
X-IronPort-AV: E=Sophos;i="6.11,251,1725346800"; 
   d="scan'208";a="40921803"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 20:27:23 -0700
X-CSE-ConnectionGUID: cddgI1dpSXWJfNMBTxTIaQ==
X-CSE-MsgGUID: k26PeHabSPiRHConRbKTZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,251,1725346800"; 
   d="scan'208";a="83241772"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.228]) ([10.124.240.228])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 20:27:20 -0700
Message-ID: <eaea5743-e41a-4055-98e8-5b83e6e3d2dc@linux.intel.com>
Date: Sat, 2 Nov 2024 11:27:18 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH v4 0/5] iommu: Enable user space IOPFs in non-PASID and
 non-svm cases
To: Joel Granados <joel.granados@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Klaus Jensen <its@irrelevant.dk>
References: <20241015-jag-iopfv8-v4-0-b696ca89ba29@kernel.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241015-jag-iopfv8-v4-0-b696ca89ba29@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/16 5:08, Joel Granados wrote:
> This series makes use of iommufd_hwpt_replace_device to execute
> non-pasid/non-svm user space IOPFs. Our main motivation is to expand or
> facilitate user-space driver driven device verification by enabling IOPF
> without SVM/PASID.
> 
> What?
>    * Enable IO page fault handling in user space for a non-pasid, non-svm
>      and non-virtualised use case.
>    * Move IOMMU_IOPF configuration from INTEL_IOMMU_SVM into INTEL_IOMMU.
>    * Move all page request queue related logic to a new (prq.c) file.
>    * Remove PASID checks from PRQ event handling as well as PRQ
>      initialization.
>    * Allow execution of IOMMU_HWPT_ALLOC with a valid fault id
>      (IOMMU_HWPT_FAULT_ID_VALID)
> 
> Why?
>    The PCI ATS Extended Capability allows peripheral devices to
>    participate in the caching of translations when operating under an
>    IOMMU. Further, the ATS Page Request Interface (PRI) Extension allows
>    devices to handle missing mappings. Currently, PRI is mainly used in
>    the context of Shared Virtual Addressing, requiring support for the
>    Process Address Space Identifier (PASID) capability which is not
>    strictly necessary. Relaxing this requirement adds to the
>    possibilities available for user-space driver driver device
>    verification as well as for avoiding pinning.
> 
> Testing?
>    The non-svm IOPF interface is exercised by first initializing an IOPF
>    enabled IOAS and then reading the fault file descriptor. Pseudocode on
>    the IOPF initializing and handling is in [3] and [4] (using libvfn).
> 
>    Supplementary repositories supporting this patchset:
>      1. A user space library libvfn [1] which is used for testing and
>         verification (see examples/iopf.c), and
>      2. Basic emulation of PCIe ATS/PRI and Intel VT-d PRQ in QEMU [2].
> 
> Changes in v4:
> - Include the "trailers" from Kevin that I missed on V3
> - Link to v3:https://lore.kernel.org/r/20241009-jag-iopfv8-v3-0-bd4271df5b2b@kernel.org
> 
> Changes in v3:
> - Adjust wording in cover letter
> - Include "_iommu_" in the prq Intel function names to be more in line
>    with functions in iommu.h file
> - Rebase on top of 6.12-rc2
> - Update my ID in e-mail, git author and my Signed-off-by.
> - Link to v2:https://lore.kernel.org/r/20240913-jag-iopfv8-v2-0-dea01c2343bc@samsung.com
> 
> Changes in v2:
>    - Remove "nesting" from wording. This wording is left over from initial
>      versions that are now irrelevant.
>    - Dropped "iommu: init pasid array while doing domain_replace and iopf
>      is active" as the initialization of the pasid_array x-array happens
>      automatically when an iopf capable domain is replaced on a device.
>    - Corrected commit message in "iommu/vt-d: Separate page request queue
>      from SVM"
>    - Link to v1:https://lore.kernel.org/r/20240904-jag-iopfv8-v1-0-e3549920adf3@samsung.com
> 
> V1:
>    - This is the first version of the series after initial feedback from
>      the RFC [5].
> 
> Comments and feedback are greatly appreciated
> Best
> 
> Joel
> 
> [1]https://github.com/SamsungDS/libvfn/tree/iommufd-fault-queue
> [2]https://gitlab.com/birkelund/qemu/-/tree/pcie-ats-pri
> 
> [3] Initializing
> ```
>    int iopf_init(struct iommu_ioas *ioas, const char *bdf)
>    {
>        // open vfio device from bdf
>        int devfd = open('/dev/vfio/devices/VFIO_DEV', O_RDWR);
> 
>        struct vfio_device_bind_iommufd bind = {
>            .argsz = sizeof(bind),
>            .flags = 0,
>            .iommufd = __iommufd,
>        };
>        ioctl(devfd, VFIO_DEVICE_BIND_IOMMUFD, &bind);
> 
>        struct iommu_ioas *ioas = ioas;
>        struct vfio_device_attach_iommufd_pt attach_data = {
>            .argsz = sizeof(attach_data),
>            .flags = 0,
>            .pt_id = ioas->id,
>        };
>        ioctl(devfd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach_data);
> 
>        struct iommu_fault_alloc fault = {
>            .size = sizeof(fault),
>            .flags = 0,
>        };
>        ioctl(__iommufd, IOMMU_FAULT_QUEUE_ALLOC, &fault);
> 
>        struct iommu_hwpt_alloc fault_cmd = {
>            .size = sizeof(fault_cmd),
>            .flags = IOMMU_HWPT_FAULT_ID_VALID,
>            .dev_id = bind.out_devid,
>            .pt_id = ioas->id,
>            .data_len = 0,
>            .data_uptr = (uint64_t)NULL,
>            .fault_id = fault.out_fault_id,
>            .__reserved = 0,
>            };
>        ioctl(__iommufd, IOMMU_HWPT_ALLOC, &fault_cmd);
> 
>        // This is a re-attach
>        struct vfio_device_attach_iommufd_pt attach = {
>            .argsz = sizeof(attach),
>            .flags = 0,
>            .pt_id = fault_cmd.out_hwpt_id
>        };
>        ioctl(dev_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach);
>    }
> ```
> 
> [4] Handling
> ```
>    int handle_iopf(void *vaddr, int len, uint64_t iova) {
>      exec_command(CMD)
> 
>      int iopf_fd = fault_cmd.fault_id;
> 
>      struct iommu_hwpt_pgfault pgfault = {0};
>      if(read(iopf_fd, &pgfault, sizeof(pgfault)) == 0);
>        return; // no page fault
> 
>      ret = iommu_map_vaddr(__iommmufd, vaddr, len, &iova)
>      struct iommu_hwpt_page_response pgfault_response = {
>        .cookie = pgfault.cookie,
>        .code = ret ? IOMMUFD_PAGE_RESP_SUCCESS : IOMMUFD_PAGE_RESP_INVALID,
>      };
> 
>      write(iopf_fd, &pgfault_response, sizeof(pgfault_response));
> 
>      return;
>    }
> ```
> 
> [5]https://lore.kernel.org/20240826-iopf-for-all-v1-0-59174e6a7528@samsung.com
> 
> Signed-off-by: Joel Granados<j.granados@samsung.com>
> ---
> Joel Granados (3):
>        iommu/vt-d: Separate page request queue from SVM
>        iommu: kconfig: Move IOMMU_IOPF into INTEL_IOMMU
>        iommufd: Enable PRI when doing the iommufd_hwpt_alloc
> 
> Klaus Jensen (2):
>        iommu/vt-d: Remove the pasid present check in prq_event_thread
>        iommu/vt-d: drop pasid requirement for prq initialization
> 
>   drivers/iommu/intel/Kconfig          |   2 +-
>   drivers/iommu/intel/Makefile         |   2 +-
>   drivers/iommu/intel/iommu.c          |  31 ++-
>   drivers/iommu/intel/iommu.h          |  14 +-
>   drivers/iommu/intel/prq.c            | 406 +++++++++++++++++++++++++++++++++++
>   drivers/iommu/intel/svm.c            | 397 ----------------------------------
>   drivers/iommu/iommufd/hw_pagetable.c |   3 +-
>   7 files changed, 428 insertions(+), 427 deletions(-)

With the issue discussed for patch 2/5 addressed by this patch:

Link: 
https://lore.kernel.org/r/20241101045543.70086-1-baolu.lu@linux.intel.com

Queued this series for v6.13. Thank you, Joel.

--
baolu
