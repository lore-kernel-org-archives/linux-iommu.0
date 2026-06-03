Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD96325B0A3
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 11:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780487108; cv=none; b=gbYxsprxaFsGDLOWisBVGgSK6OjlSt7J97kUQgsKa6ShReqvlNhgAy2AKU2waYROL8I0yS/k5YSLdRHGXCjGOHjFidXAaiQ3+1KbTThzCFar9ga6AjMkh+6L9DaS2ZWU5QwLlLRj1fBCs+/ZaQHaQxo427JTkJx13jEX4bd0hqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780487108; c=relaxed/simple;
	bh=ZKAY5U6qFK9gJVXhCRZ6KMlEXHdamLalmZH4JQCNrqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hRINbP0XnaL6b2Ch5mI8AJCV2FwWrL+jeKQawsHf/I/aQAA9M5k9MC13lMiTYIDMfX/TAde04BjVN/Ot1/L5lFDRKXc+TVAeOPdjgrO866MukqzV8b0RiXNur62QhulqpFJ0JYx7QjwP1D0AMJS1S54xGeQcP7SGfJPH/yY1xDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GXJcqgvH; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GXJcqgvH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780487107; x=1812023107;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZKAY5U6qFK9gJVXhCRZ6KMlEXHdamLalmZH4JQCNrqY=;
  b=GXJcqgvH/ywG3aw0NfLCHNd3/YOZ6OO21QeqQavLxBKwM/2ZfWY9UaXN
   I/GnG9sDc9ycpxqq3xLha2YIDCADIUyb4Jxw5o1Ri0HEANF/HbMNPYBgr
   hywxej5jwT8758Uc2qHSZdUEeQajy/w/KNIe5W3pyDJYUHPD37pz5mC3q
   1y2FEs3Op882mPYTyHeelbMvjrGt3UOpYk47Kt0OmelnY1ygY+BCfCizv
   3E/POZhaP5i8ODMvHpETR4yj9VxBp3XV4fwJhXBsBrj+Pfeu1QXK3fqLM
   DiBOgUZD4z/ltFw+BNZXclSc30DRAU7CFFyMCvXTAOSkk7sVyucbASPwv
   w==;
X-CSE-ConnectionGUID: TI+nau0JR3y+Fxfu8QQ+9Q==
X-CSE-MsgGUID: IthV9s4gR/6QcNoVvkYqlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="85179979"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="85179979"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 04:45:06 -0700
X-CSE-ConnectionGUID: LMVs8tv1Slq7bg2uF50cfw==
X-CSE-MsgGUID: kC5CDkoSSwGY5P+cETjnbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="243355882"
Received: from gklab-103a-104.igk.intel.com ([10.91.103.104])
  by orviesa010.jf.intel.com with ESMTP; 03 Jun 2026 04:45:03 -0700
From: Michal Camacho Romero <michal.camacho.romero@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>,
	Ning Sun <ning.sun@intel.com>,
	Thomas Gleixner <tglx@kernel.org>
Cc: x86@kernel.org,
	iommu@lists.linux.dev,
	tboot-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Mateusz Mowka <mateusz.mowka@intel.com>,
	Adam Pawlicki <adamx.pawlicki@intel.com>,
	Pawel Randzio <pawel.randzio@intel.com>,
	Michal Camacho Romero <michal.camacho.romero@intel.com>
Subject: [PATCH v1 0/2] x86/tboot: Add Intel TXT Protection Regions (TPR) support
Date: Wed,  3 Jun 2026 13:44:58 +0200
Message-ID: <20260603114500.2771319-1-michal.camacho.romero@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Intel TXT Protection Regions (TPRs) are a new hardware mechanism for
DMA protection that replaces Protected Memory Regions
(PMRs). TPRs are configured by the SINIT ACM and managed through the
DTPR table in the TXT heap's extended data elements.

This series adds kernel support for detecting and disabling TPRs during
early boot, allowing the kernel to take over DMA protection management
via the IOMMU.

Patch No.1 adds the TXT heap parsing logic to locate the DTPR table and
disable each TPR instance by setting the enable bit (BIT14 in TPRn_BASE
register).

Patch No.2 integrates TPR detection into the IOMMU initialization path:
skipping force-IOMMU, when TPRs provide DMA protection and tearing down
redundant PMRs.

Tested on Intel platforms with SINIT ACM supporting ACPI DTPR tables.

Documentation:
- Intel TXT DMA Protection Ranges, rev 0.73
  https://uefi.org/sites/default/files/resources/633933_Intel_TXT_DMA_Protection_Ranges_rev_0p73.pdf
- Intel TXT MLE Developer's Guide, rev 017
  https://cdrdv2-public.intel.com/315168/315168_TXT_MLE_DG_rev_017_7.pdf

Michal Camacho Romero (2):
  x86/tboot: Add support for parsing DTPR table and disabling TPRs
  iommu/vt-d: Disable PMRs and skip force-IOMMU when TXT TPRs are active

 arch/x86/kernel/tboot.c     | 146 ++++++++++++++++++++++++++++++++----
 drivers/iommu/intel/dmar.c  |  12 +++
 drivers/iommu/intel/iommu.c |   8 +-
 include/linux/tboot.h       |  10 +++
 4 files changed, 160 insertions(+), 16 deletions(-)

-- 
2.53.0

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

