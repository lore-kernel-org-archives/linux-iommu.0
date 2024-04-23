Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557CB13DDBC
	for <iommu@lists.linux.dev>; Tue, 23 Apr 2024 17:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713893803; cv=none; b=qt7ZZor2gxwgX07+TmeBtQNvhlo469+mq15RQ3n43/542Qsc6X51BrtLyqQhKiibBi4e+JOnsfFU2t0jqiu1hcDodfIfJ7v6pfu+kB5ZZkqugy0mJPBbHbkeUhZuLPuhwndgWeq4phwFBi4jiYLspDYTj0KmubsZ7HHPm7f7TSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713893803; c=relaxed/simple;
	bh=0GX8HhoSt+Bowm5iZvkwyHIzLD8tLG+XNrU90AlqK/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CuWon4luK7JRiOgqo/uYhfgHRqZPnPAjMJahjvSSCGc3Px6+QWTb5EMlv/Ir69CKVnqYeTm3rJPQyuk+M4YK978XbGAU5K/gGK6bZmJscPYTXqZgcSR1Mui+xCw0pm2w9Cd5hCM5XY76BBCAx4R7hWsrNJI+UntU9S/If15h1EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OwIZJBZS; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OwIZJBZS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713893802; x=1745429802;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0GX8HhoSt+Bowm5iZvkwyHIzLD8tLG+XNrU90AlqK/Q=;
  b=OwIZJBZSIcnq2QPBXpMEgsMaqo6Ms8wUTMeyuaKY9LcFEMiYLj9ndNLO
   I3VXMRUzpgj3biToXEB1pYMvrql5kA94q//lx0G+cxrScUHe1Gd87Swmc
   XEnkwSe+wF1CsTiB/Vu8jGNXReONcFX08IFifRg9Y6UN/5VQmoUnuHmj8
   /xI2Ds3Lg0PgjNKo2+RHOt/UPjoTRUpHGjIquDvhAi5DQnT4A+iD6vTGB
   u0K/AwxUp91rh4wOAL/Bn9JxSztNIMlb1noRhZiAqmTNpzq+Q8gDpUJtZ
   JsEZo2RHLD+hLUWQjBKIP8bBsu0aLpmKt4cWPk5tlatWbKyquLxyVlhZa
   g==;
X-CSE-ConnectionGUID: 2bdVoI6wT1Gn7WHUgngaiw==
X-CSE-MsgGUID: xsnA3otzQ7yJg3Rd7DZC0A==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9712308"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9712308"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 10:36:40 -0700
X-CSE-ConnectionGUID: 1XBh1OYvTD60c3BFWsG2bA==
X-CSE-MsgGUID: hdr0CBwaTRaCrNAxFNyDQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="29097381"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by fmviesa004.fm.intel.com with ESMTP; 23 Apr 2024 10:36:39 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>,
	X86 Kernel <x86@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	iommu@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	"Lu Baolu" <baolu.lu@linux.intel.com>,
	kvm@vger.kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Borislav Petkov" <bp@alien8.de>,
	"Ingo Molnar" <mingo@redhat.com>
Cc: Paul Luse <paul.e.luse@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jens Axboe <axboe@kernel.dk>,
	Raj Ashok <ashok.raj@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	maz@kernel.org,
	seanjc@google.com,
	"Robin Murphy" <robin.murphy@arm.com>,
	jim.harris@samsung.com,
	a.manzanares@samsung.com,
	"Bjorn Helgaas" <helgaas@kernel.org>,
	guang.zeng@intel.com,
	robert.hoo.linux@gmail.com,
	oliver.sang@intel.com,
	acme@kernel.org,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v3  02/12] x86/irq: Unionize PID.PIR for 64bit access w/o casting
Date: Tue, 23 Apr 2024 10:41:04 -0700
Message-Id: <20240423174114.526704-3-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240423174114.526704-1-jacob.jun.pan@linux.intel.com>
References: <20240423174114.526704-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make PIR field into u64 such that atomic xchg64 can be used without ugly
casting.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 arch/x86/include/asm/posted_intr.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/posted_intr.h b/arch/x86/include/asm/posted_intr.h
index f0324c56f7af..acf237b2882e 100644
--- a/arch/x86/include/asm/posted_intr.h
+++ b/arch/x86/include/asm/posted_intr.h
@@ -9,7 +9,10 @@
 
 /* Posted-Interrupt Descriptor */
 struct pi_desc {
-	u32 pir[8];     /* Posted interrupt requested */
+	union {
+		u32 pir[8];     /* Posted interrupt requested */
+		u64 pir64[4];
+	};
 	union {
 		struct {
 				/* bit 256 - Outstanding Notification */
-- 
2.25.1

