Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4589420328
	for <iommu@lists.linux.dev>; Thu,  3 Oct 2024 03:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727927653; cv=none; b=vEk7ZelKr/4TAEpAjU3kVxTDxL+a8KJcqV/Cy0mN8U8UpZfTD3mcFfOUClDd9qVBI1ktUJzmFP73morUXRib1w8h1sTIzMYPlbVI42cN9rJInXcF/Eb648NHj7bZ5RHracoIoIPop7fHTjjC1pXsGXDQI1tOjsS4aL0APht2Qeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727927653; c=relaxed/simple;
	bh=QmeSYrrI24PWcddwX8PrLWtm0wkKceIF+Cz20bFHXtc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ks8c/rHnP3OLebSayBGp/bCOkEXL4lVuRHRwb5hxtXP2jPZIAAUMXqRDOCG2RUSut+rN1wGpNnCeDye/6eEmpzuwxPq580nO5MAg/Ygnmh04fBWUzXFe/L4QVFluPywmoTX8FNVYrlQDT0lDEIzXj9bJPJUQ/PdIL3/ht3ZetqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIRYWMvr; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIRYWMvr"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20ba6b39a78so3016305ad.3
        for <iommu@lists.linux.dev>; Wed, 02 Oct 2024 20:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727927651; x=1728532451; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hHOtVVpxaSz37zmcbp5H7y6KJdcMIRfAVEwysl7iO1A=;
        b=VIRYWMvrOxCs1d10RotRDWbzP81jkhBhX579e1DdQYo2U6410i7YEsA+1z3xUN++9D
         e39ALXh974jgJxEOd8idrAJEplEDqAtuRgKFr8PwCYtCvPBwH0EHWmGM2Eu6xfRBQFU6
         vsvI76hDBgUJNEsbdCd/RAfm9ouHuh55Wp+jr7N9uSm53kujxtp+sVDrOe4TP9kFJKJB
         lwSKlIHOLJBuHb6VSGjD4OPO/OhE4gJNjBT9hPeVa6fg5iUwQ+0Ikd7dyLEodd3Up8s+
         t7O+Xx0qlwpSw2cV35mwKDH4DpgCeO6zOvDV9nqhIxcQ8A30XlcaP/aNmFHdhcbMArkT
         Ldxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727927651; x=1728532451;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHOtVVpxaSz37zmcbp5H7y6KJdcMIRfAVEwysl7iO1A=;
        b=r5/4L30fiIe5Vhu5qxQusTyqSBQOzp7tHxxFNK2eXXt6Na1vdGt7csiNIGom1pCY5q
         Zup9sk8pEQJzEMtm5Tc3wDnXFnfvMvKxkUHVUixswDSRcHf57SqB6Ndea3isGCsxRN2+
         aXl81SZbveCiMFszeAFBLmLkRJXHtvOsCgWJo9FR+mZvwxBzCwoa7aOflsaMUePX2Cnq
         I5/H4Xy/A5IL/k112MK+bmuu6bMVcXxqpIXj2XFOtwmrBEEDqVbJSbwd/6YlQ/qX1uv6
         9cWxkgS2GrRTFsCK+Vx8KI7KWgBdIj6i/RJoO4NMHRu9lBnflqoE4dJf/K3iRkc+e/Nz
         5m5A==
X-Gm-Message-State: AOJu0Yxe7l+fYoZiRf0JiViUVVUH3GQ9Kho8hHzBSHRJs6Bu6rj7qKJw
	NywtNlfjZtCV2uwRar56lHZpKB9xOCdpW8S71j27OMSJsSYUAWIK
X-Google-Smtp-Source: AGHT+IFHg+L2rkL479r/ys+rVampY0Tz/cLk/l2GdysFP7KsfE+ZMCPSsA6gvnNI+6jswnDv5pviaw==
X-Received: by 2002:a17:902:e88f:b0:20b:849d:48fa with SMTP id d9443c01a7336-20bc5a04f8cmr68592895ad.27.1727927651458;
        Wed, 02 Oct 2024 20:54:11 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beead8dc2sm906115ad.44.2024.10.02.20.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 20:54:11 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com
Cc: iommu@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH 0/5] hyper-v: Don't assume cpu_possible_mask is dense
Date: Wed,  2 Oct 2024 20:53:28 -0700
Message-Id: <20241003035333.49261-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

Code specific to Hyper-V guests currently assumes the cpu_possible_mask
is "dense" -- i.e., all bit positions 0 thru (nr_cpu_ids - 1) are set,
with no "holes". Therefore, num_possible_cpus() is assumed to be equal
to nr_cpu_ids.

Per a separate discussion[1], this assumption is not valid in the
general case. For example, the function setup_nr_cpu_ids() in
kernel/smp.c is coded to assume cpu_possible_mask may be sparse,
and other patches have been made in the past to correctly handle
the sparseness. See bc75e99983df1efd ("rcu: Correctly handle sparse
possible cpu") as noted by Mark Rutland.

The general case notwithstanding, the configurations that Hyper-V
provides to guest VMs on x86 and ARM64 hardware, in combination
with the algorithms currently used by architecture specific code
to assign Linux CPU numbers, *does* always produce a dense
cpu_possible_mask. So the invalid assumption is not currently
causing failures. But in the interest of correctness, and robustness
against future changes in the code that populates cpu_possible_mask,
update the Hyper-V code to no longer assume denseness.

The typical code pattern with the invalid assumption is as follows:

	array = kcalloc(num_possible_cpus(), sizeof(<some struct>),
			GFP_KERNEL);
	....
	index into "array" with smp_processor_id()

In such as case, the array might be indexed by a value beyond the size
of the array. The correct approach is to allocate the array with size
"nr_cpu_ids". While this will probably leave unused any array entries
corresponding to holes in cpu_possible_mask, the holes are assumed to
be minimal and hence the amount of memory wasted by unused entries is
minimal.

Removing the assumption in Hyper-V code is done in several patches
because they touch different kernel subsystems:

Patch 1: Hyper-V x86 initialization of hv_vp_assist_page (there's no
	 hv_vp_assist_page on ARM64)
Patch 2: Hyper-V common init of hv_vp_index
Patch 3: Hyper-V IOMMU driver
Patch 4: storvsc driver
Patch 5: netvsc driver

I tested the changes by hacking the construction of cpu_possible_mask
to include a hole on x86. With a configuration set to demonstrate the
problem, a Hyper-V guest kernel eventually crashes due to memory
corruption. After the patches in this series, the crash does not occur.

[1] https://lore.kernel.org/lkml/SN6PR02MB4157210CC36B2593F8572E5ED4692@SN6PR02MB4157.namprd02.prod.outlook.com/

Michael Kelley (5):
  x86/hyperv: Don't assume cpu_possible_mask is dense
  Drivers: hv: Don't assume cpu_possible_mask is dense
  iommu/hyper-v: Don't assume cpu_possible_mask is dense
  scsi: storvsc: Don't assume cpu_possible_mask is dense
  hv_netvsc: Don't assume cpu_possible_mask is dense

 arch/x86/hyperv/hv_init.c       |  2 +-
 drivers/hv/hv_common.c          |  4 ++--
 drivers/iommu/hyperv-iommu.c    |  4 ++--
 drivers/net/hyperv/netvsc_drv.c |  2 +-
 drivers/scsi/storvsc_drv.c      | 13 ++++++-------
 5 files changed, 12 insertions(+), 13 deletions(-)

-- 
2.25.1

