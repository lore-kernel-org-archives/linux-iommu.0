Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793674325;
	b=uRmbMx0XpuMutMEH6+Epp/Dz5sGc9MnsReHar55dx/4k9D6I7SpX4SSkxt4kLP/5OKq2
	 p8R3Z5ps3pN851RG9pfEUiz58aP3HQUBxTDKrajHe4xztqRRXwprVkmwcpTn9a0kYp3nG
	 rAzsNeqnkEBgn9b5+087XENJvW8cJT0tb5DB1aAMQmKqVu4Nlrs1j78ec0/ebox5Gmkp4
	 dyZoYHwdJsYMZcCBK6e/oG40xIdolPsPHwpNB6v8wIKFs1YYTkAahu7dtYjNQZh3yKTnl
	 3y3i+nua37OrkYOEqnCSJe5uHz8ha8sE8+mD/mlCni7kgIbUcF1g8mes0WpsQjLWP+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674325;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Spam-Status:X-Spam-Checker-Version;
	bh=LB7T7mSGj7gb2NVvd8ZxKJtsbTjQrh+GSEJ00NJnkNE=;
	b=PrpgBIC7jq2CPfAyZpMyCm5K/4FoiBiFBhjRoRG6iZyfmJqnFSL5Sgxh67c2rF1nyUTv
	 P39yp0U7oOTxmKm1EN0GG4TXt7uGtPeQslu7J+VGzcQBosL+y2+opGavFR+jg2PYnb3sX
	 SPNR62eNVLQIuj8ddr3NUripDE3R+y5pN1yG20ParnJ/sGlzDaXZPnUmFDaNPq7oVFqpf
	 fFTbQEsikwh2mAC2VAjUEefEvhYNzSNkq0RWRBpB/PpbVov++f8W5Ebi0ImkYqKLKOerb
	 jNGm/xNz1mCBQK20asNcq+7CmqaBHjuG95Lp1e17hZP5tbtEEnvC2piKO6RbfFeXM6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b="MKO4cDK/";
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE56606A324
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 02:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FE56606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=MKO4cDK/
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 408FD20B7166;
	Mon,  2 Nov 2026 18:51:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 408FD20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793674309;
	bh=LB7T7mSGj7gb2NVvd8ZxKJtsbTjQrh+GSEJ00NJnkNE=;
	h=From:To:Cc:Subject:Date:From;
	b=MKO4cDK/yIH2vLLKmfvTwAGoD4Xfny4JkVP+YYiLrV0OxxxpYIzwrgDFi9ETrWFiA
	 AISttQrJCgVFazCcxLjzTFYRFbR4fNWDRCN3+W4/vmZghaDELE8lGy3JiafI6M6wUN
	 nAgGLdslM9vuCB8hT+GYZ6woJomni6vIQSeI1hbw=
From: Mukesh R <mrathor@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-arch@vger.kernel.org
Cc: jgg@nvidia.com,
	jacob.pan@linux.microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	arnd@arndb.de,
	mrathor@linux.microsoft.com
Subject: [PATCH V3 0/5] Hyper-V: root VM iommu kernel only driver
Date: Mon,  2 Nov 2026 18:51:45 -0800
Message-ID: <20261103025150.3192119-1-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
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

This short series introduces hyperv root VM iommu kernel only driver. This
driver acts as liason between the hypervisor and iommu layer. Details are
both in the actual commits and in the comments in the file implementing it.

Thanks,
-Mukesh

V0: based on upstream hyperv-next commit be0cfab740e5

V1:
 - change order of lookup tree deletions to appease all AI agents,
   carving out hv_iommu_hyp_unmap_pages() from hv_iommu_unmap_pages().
 - change unique_id to ida subsystem management so we never ever run
   out of domain ids.
 - change hv_max_iova_width to hv_iommu_max_iova and generate proper
   mask.
 - some other minor changes.

V2:
 - Add patch (0001) to allow gfp_flags to be passed to deposit pages
   function.
 - In last main patch:
     o remove hv_iommu_setup_skip to skip devices being managed
     o remove hv_special_domain()
     o Add comments around pgsize_bitmap and IOMMU capabilities.
     o Add to lookup tree before mapping iova in the map callback
     o Unmap iova before removing from the tree in the unmap callback

V3:
 - Rebase to rc1 tag 6628e7d4c6b2 which contains both pviommu and the
   deposit memory redesign patches.
 - Add a tiny patch to rename hv_iommu_init() to hv_pviommu_init(), and
   only call it for non-root.

Mukesh R (5):
  mshv: Add gfp flags to deposit memory logic
  PCI: hv: Export hv_build_devid_type_pci() and change return type
  mshv: Import data structs around device domains from hyperv headers
  iommu/hyperv: Only call pviommu init on non-root VMs
  x86/hyperv: Implement root partition IOMMU kernel only driver

 arch/x86/hyperv/hv_init.c             |   3 +-
 arch/x86/hyperv/irqdomain.c           |   9 +-
 arch/x86/include/asm/mshyperv.h       |   8 +-
 arch/x86/kernel/pci-dma.c             |   2 +
 drivers/hv/hv_proc.c                  |  20 +-
 drivers/iommu/hyperv/Kconfig          |  13 +
 drivers/iommu/hyperv/Makefile         |   1 +
 drivers/iommu/hyperv/hv-iommu-guest.c |   2 +-
 drivers/iommu/hyperv/hv-iommu-root.c  | 602 ++++++++++++++++++++++++++
 include/asm-generic/mshyperv.h        |  17 +-
 include/hyperv/hvgdk_mini.h           |   4 +
 include/hyperv/hvhdk_mini.h           |  15 +
 include/linux/hyperv.h                |   6 +
 13 files changed, 683 insertions(+), 19 deletions(-)
 create mode 100644 drivers/iommu/hyperv/hv-iommu-root.c

-- 
2.51.2.vfs.0.1

