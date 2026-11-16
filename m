Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794813238;
	b=c2KyMSxuUSgg4ta5bKbuardkjVmgsdwN1Z8sH+5dyB4l9tnHZVZ4KjmHJfN68Pt6kva4
	 RrJ7MyTk/uoA6l/DaFHORP6ET6VFAoUEkeiMs1MVRI3CcslOG+tgC5Rp/LkId6uzuKn8/
	 0yco57Qtlv4v5zfwG8uMWj2P0VR5E7+VnmpeIdXgIT64tylVd4qQ8+uxA1+v+f4OTkPYr
	 MlQCYKgX+efVUD+ul0VLrItkW6Ymfka6j4l2IV72sz0n6XQrQtiNK63dbpZOIE2+FZgfy
	 0lToPgh/zb1VGOTnUGdtLBpNnpTnAHWAc6YWDqYftRMlEhpKhnR7cFJi5OH2mrebiQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794813238;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8CsXHXcl/CTMGZ0Vc+K3+S7p0GgqWl5r8v3bGSKHol8=;
	b=NLX9J6htM7FPQcGCMddn6Q0W4EpggI8FyE2u6e//IlXF9KUuHR0A9Ltzei2ZEHEj4aED
	 v6weDp9O6i+kvvy+oGZ1RsZEaclb0ucl9GAI8dDUPx3ztQGNEE5MTzkcos1Hvqom7Mjfa
	 93Xa4t3Fc40CVevcq4gfu0gMAr+frEZEk/32ve8Wzj4ljm7QxE8cKS4EUU6Z/I9D/b8PC
	 29byB568xJqr2eoKW8HBEga3RwjZtMO1jTCmCo2hus0IO7GZ6hy78tNqZBHf5nB5QrRia
	 T6rPAlDvK4fYrnWoPCqR9idMcGLk8EOCHbIcBCbqEMoGWjGcvUA0eADI01AXKRgNpKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=etbkkYk2;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64160606A335
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 07:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64160606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=etbkkYk2
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-37071c0f42aso4570786eec.0
        for <iommu@lists.linux.dev>; Sun, 15 Nov 2026 23:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794813236; x=1795418036; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8CsXHXcl/CTMGZ0Vc+K3+S7p0GgqWl5r8v3bGSKHol8=;
        b=etbkkYk2oCkazXMHb59zO7uw5EA04NnzKh3Ae3RrtmHnh0VRrZlBSvS9qVi5aCyibs
         FY4YzMQyfo5Cwdz8zMnLeGO0F1lPdtT9/SeLn6RixTGIxzkIwemrKkokcAPxzn2XjEQt
         OCSsgbOkL6UhdoJKrvPFj9AkaSkm1iz6nAU8qlsn09XHgJisPXQREPLKqumSY61E5sKR
         I8Kw5cv81ET+7t7h09Jo+EtRfH5zXF5TVvsPB7CRaI86jqCHzPQnYtfOsAwKxFclQ8KA
         H8mSBRiPf0Zn9d4LwnCvMmRnTZ1/G3PiwGOlw2rXaMh/v9ll8W07nCogdDXXxXGm4fR0
         9wuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794813236; x=1795418036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8CsXHXcl/CTMGZ0Vc+K3+S7p0GgqWl5r8v3bGSKHol8=;
        b=uSJ1UgShKqaL27XhgEjbcrcKpu2m1rufdmsOR48VWTH+3Lo4yXRCWKLIqEQ+0okorr
         mWbVGE9El507VqHxvRgaMCBw1uMHQpqhBdv3d3Mevu1i924qeR5Zp2Dh/xyb8zxn77GD
         H3KvZqWk1EZushCeV5BiCtv5wkD+VBrasLVbO13JQe6/gCCX4CQ00VE3f9U9ebLsJZVb
         gkafTORQPpHISCs8Sc5cSPfPJcGJMb3Ae7TalTymrFMMLkWldgm6qWHuZ6Oqo96bi54U
         hWe7QZdTMhZlSRS3QdY0u8OZhmI/b54dHi84u6WcCPtQ3YKP8IXnbiKDAbhnPs/jitk9
         9EEg==
X-Forwarded-Encrypted: i=1; AL+hErFMcvQOQVnTvb27tSrLBnh6lVrm4y03vSQGW34Rnwsqw7DNKJLWYbPr03CF4mML9VoEn/NtBg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+vtpiwwrhkIE63uc1ct2RMu8FzKS/mRu88w3AmejAkfQnHfQbw
	AcsVhJVga4kkGLZRTPRKeEaw4ZTsWIzgD1CQxZyMYqWOOK/hVrND4Z87zkJxAVzL/Go=
X-Gm-Gg: AYBFou11C9CXbK/bdGsubAM7XreS4LiZff7xMCOMZyzqsHyzLXVzVjsFyQPYIqK4iwN
	D14+cpo5Hchl9pGp0wl91Kf0dRsZs6yT/9uLMq0Ao6WkM17/c0RerKBuR93EWXeUWSpTdaMu/xU
	GoCKJzCfH4gzmmuzxzJsFVVnKUyIIFfO5Ls3VlWauWet1cDjPt1t9R2+NRa2Vh4eDdJz9HJsTsv
	wi0gutxApozz9fYL/xsjHFRkNsUHnOZT8yzke1XG7kDzxfxG6DqcQUjx+q4Zrchi6HNjsu0XF7G
	OsfLqthkaU1eo4haY3KlK+Y7Am2ktbbWovcCSHcd3A7/WmP0hzkMayrhr/CrFhvbi0d40QGr00K
	boZEsO24KI7a32EPtTQ426zJNT4gctWdoBDmmuigIf/05SV2/ELfPd+qUuS+6NQbhb1Oe2NOteB
	NVUYWNNRSfOYhyVjnKSXm6/WEq2IyoRJui4qU2vMCLR9Uf8fxj7DrFl6jNQzS+SDsFTKCHvp5UE
	k593oEvy5Bafz1Qujk1veoZa15Neatnm1ldsy6KtmHuUYpcuSY04QNKlRzGzqhzMydmdf240OgC
	VDVRql3STjd4lXRb0az/3Cr+0HIUlfQXc60ucOD43s2Z8+UTobLGaoKA3gjgG6FnaTbD1/sm5eW
	algjbdA==
X-Received: by 2002:a05:693c:8813:20b0:376:77e6:a66 with SMTP id 5a478bee46e88-37967315a29mr9334631eec.16.1794813236238;
        Sun, 15 Nov 2026 23:13:56 -0800 (PST)
Received: from FJ7FR2JRQ3.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955332ae7sm47858505eec.8.2026.11.15.23.13.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Nov 2026 23:13:55 -0800 (PST)
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
To: joro@8bytes.org,
	palmer@dabbelt.com,
	tony.luck@intel.com,
	reinette.chatre@intel.com,
	tomasz.jeznach@linux.dev
Cc: fustini@kernel.org,
	jgg@ziepe.ca,
	james.morse@arm.com,
	ben.horgan@arm.com,
	xiaqinxin@huawei.com,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	Dave.Martin@arm.com,
	babu.moger@amd.com,
	kevin.tian@intel.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	shuah@kernel.org,
	randy.dunlap@infradead.org,
	cuiyunhui@bytedance.com,
	yuanzhu@bytedance.com,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	x86@kernel.org
Subject: [RFC PATCH v2 0/4] resctrl: Assign registered devices to resource groups
Date: Mon, 16 Nov 2026 15:13:39 +0800
Message-ID: <20261116071338.35991-6-zhangzhanpeng.jasper@bytedance.com>
X-Mailer: git-send-email 2.50.1
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

This RFC lets resctrl groups include devices as well as CPU tasks. It
uses the RISC-V IOMMU QoS ID extension as the first provider and builds
on Drew Fustini's CBQRI resctrl v12 series [1] on Linux v7.4-rc1.

RISC-V QoS tags requests with a resource control ID (RCID) and a
monitoring counter ID (MCID). On successful translations the IOMMU
supplies the device context's IDs to the I/O bridge for device requests.
Those IDs also tag IOMMU accesses to context-specific metadata, such as
page tables. IOMMU accesses to the device directory, queues and
IOMMU-generated MSIs use the per-IOMMU iommu_qosid register. When the
IOMMU is in DDTP Bare mode, device requests use that register too.
The IOMMU supplies the tags; downstream controllers apply the policy.

In v1, the unit of assignment was an IOMMU group. In v2, the driver
responsible for tagging explicitly registers supported devices with
resctrl. Here that is the RISC-V IOMMU driver, so endpoint drivers such
as NVMe do not need to change. Common resctrl code handles token
lookup and group membership. When a device is assigned, resctrl calls
the driver's set_ids() callback to program its device context. The
devices file remains separate from tasks.

  resctrl control group
     schemata  ---------> CBQRI controller: resource policy
     tasks     ---------> CPU:              task IDs
     devices   ---------> IOMMU:            device context IDs

For example, for an independently tagged PCI device:

  mkdir /sys/fs/resctrl/p1
  echo pci/0000:00:03.0 > /sys/fs/resctrl/p1/devices
  echo pci/0000:00:03.0 > /sys/fs/resctrl/devices
  rmdir /sys/fs/resctrl/p1

The devices file appears only if at least one device is registered at
mount time. A device being present in sysfs does not make it assignable.
The IOMMU driver excludes shared hardware contexts and requires known QoS
ID limits before registering a device. It probes those limits only with
DDTP set to Off and all queues disabled and idle, and rejects out-of-range
IDs before changing a device context.

The separate qosid/{rcid,mcid} attributes under the IOMMU class device
configure the global register independently of resctrl.

The v12 dependency provides cache capacity allocation, not monitoring.
Nonzero device MCIDs require a monitoring-capable dependency.

Changes since RFC v1:

  * Assign devices rather than IOMMU groups, as Jason and Qinxin
    suggested [2]. Drop the IOMMU core group lookup and walk helpers.
  * Build on James's driver callback suggestion [2] with explicit
    device registration. Handle token lookup in common resctrl rather
    than in each architecture, as Drew suggested [3].
  * Keep devices separate from tasks so the existing ABI stays
    unchanged [4]. Following Drew's runtime visibility suggestion [5],
    check for registered devices at mount time.
  * Split the global sysfs setting into separate rcid and mcid files
    [6], and introduce qosid_lock in the patch that first uses it [7].
    Thanks to Drew for both reviews.
  * Rebase on CBQRI v12, check implemented QoS ID widths before device
    assignment, and test task and device membership in the same
    control group.

Feedback would be particularly helpful on:

  * The provider registration and lifetime contract, including how to
    represent devices that share a tagging context.
  * The bus/name token versus using an existing sysfs identity.
  * The scope of protection after a command queue failure. If an update
    leaves the hardware state uncertain, the current code prevents ID
    reuse by blocking group removal and future mounts, including for
    groups unrelated to the failed update. Would reserving only the
    affected old and target IDs be sufficient?

PASID assignment and recovery after an uncertain hardware update are
outside this RFC.

[1] https://lore.kernel.org/linux-riscv/20261114-dfustini-atl-sc-cbqri-dt-v12-0-6ef1f627072d@kernel.org/
[2] https://lore.kernel.org/all/arKx__kOPe4B5gDW@agluck-desk3/T/
[3] https://lore.kernel.org/all/an4CRRXt44%2BPhHgy@x1/
[4] https://lore.kernel.org/all/7cf591e8-e182-447f-9808-d8e328d28f79@arm.com/#t
[5] https://lore.kernel.org/all/anvYGuNF3MC%2F%2FQ94@x1/
[6] https://lore.kernel.org/all/andiub47zsUsL4qh@x1/
[7] https://lore.kernel.org/all/andiWrKhz5rLPVuq@x1/

Zhanpeng Zhang (4):
  resctrl: Add registered device assignment
  iommu/riscv: Register independently tagged devices with resctrl
  iommu/riscv: Expose global QoS IDs in sysfs
  selftests/resctrl: Exercise device assignment and IOMMU global IDs

 .../ABI/testing/sysfs-class-iommu-riscv-iommu |  27 ++
 .../filesystems/resctrl-devices-prototype.rst |  43 ++
 MAINTAINERS                                   |   8 +
 drivers/iommu/riscv/iommu-bits.h              |   8 +
 drivers/iommu/riscv/iommu.c                   | 398 +++++++++++++++++-
 drivers/iommu/riscv/iommu.h                   |  16 +
 fs/resctrl/Makefile                           |   2 +-
 fs/resctrl/devices.c                          | 233 ++++++++++
 fs/resctrl/internal.h                         |   8 +
 fs/resctrl/rdtgroup.c                         |  28 ++
 include/linux/resctrl_device.h                |  53 +++
 tools/testing/selftests/resctrl/Makefile      |   2 +
 tools/testing/selftests/resctrl/devices.sh    | 205 +++++++++
 .../testing/selftests/resctrl/iommu_qosid.sh  | 119 ++++++
 14 files changed, 1143 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-iommu-riscv-iommu
 create mode 100644 Documentation/filesystems/resctrl-devices-prototype.rst
 create mode 100644 fs/resctrl/devices.c
 create mode 100644 include/linux/resctrl_device.h
 create mode 100755 tools/testing/selftests/resctrl/devices.sh
 create mode 100755 tools/testing/selftests/resctrl/iommu_qosid.sh


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
prerequisite-patch-id: 492fe81aa4f3c885ac5bb48252def2fdc5527275
prerequisite-patch-id: b4f0bd4bf660c92dbf4ca0c7d871c1550b66df0d
prerequisite-patch-id: a2e36f0788f8e11c708d162dce653351dd99c4f0
prerequisite-patch-id: d1d359c5cf89b2b5018d64ca8f320892f6dbcca2
prerequisite-patch-id: 5b7fea6f1ad8f2137ffe45681d56b83e17f7cb2a
-- 
2.50.1 (Apple Git-155)

