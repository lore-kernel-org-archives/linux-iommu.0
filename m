Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3242619C575
	for <iommu@lists.linux.dev>; Fri, 28 Mar 2025 11:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743162437; cv=none; b=LpKE/7nUsWKdSSw7FkRWwe6L6uoMawlzLHqE2KwRJ8GfOlRYbLtj1Sj1fFTBPA1QwWIu6tiwItlNuo4PVsr+SwHkr2IfJGlcMWiRkvANxMXIHXUoCXWEfI3ytAeA/Ki87KLCz0avU+MYT3deNe0Ym4G2M5I5wsNhCn9Q2kApsNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743162437; c=relaxed/simple;
	bh=fSDDLJIg1AIFezqeviZx0z10om+VyB30CEwom2stASw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ri9CZGvcxuYx2V91X8Lq7iW3dfkRfuvzngryncC9ZG7t9LjqS0slLxrisDzXdJGUF5EqGoIlyG19oecHyHHP89GTdy/n188jU/3DzNrMrGS00iJFGW6k4TYejt1eynnpKisYl+0IAzPLaehHDFYH+IMjW6oim+t/jIyPuuGSa00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOmDIMJr; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOmDIMJr"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-227cf12df27so30935995ad.0
        for <iommu@lists.linux.dev>; Fri, 28 Mar 2025 04:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743162434; x=1743767234; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hc/xauRBy7/DMinG+JVri98lUK7sMGQwLWf3P4KYn9g=;
        b=fOmDIMJrchcbsrFxKczhXVISgYhfUHTwXXyJaAEZEy0zAro4V1PKM1p/C5XyGkl9Lc
         9YX99ACu12PIwM65LN3qLFr+Wrcuh/s8PLK9VRicfDp5h5UjvdNispp4JVg7u5zfUQpJ
         vn6L1TDZB/xkV/ybHqAk7qElvYQRakXBkCWjIoIjftVZ3/K8ZwUrIRea6MUnCEsoEX4a
         Je0gPeDR/55xX5IDTCDEDlhuDBLzy2bRYfcFTjCbj2TBVpkYBwbXwrnFP9DJTbqbWf43
         dPeZ6+BuceA1+aqkXsnwvqhl6rt/vnwsvR7zv7puh+ZOk4vLnZfbXxUEsbJMfbc21YsL
         yn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743162434; x=1743767234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hc/xauRBy7/DMinG+JVri98lUK7sMGQwLWf3P4KYn9g=;
        b=i7s+guBCQQ9asUEJh5xw1jmFSR/4qEFzHo2IbYiL6jC5ddUn7vfhkexGPrYt01D2yk
         vfE8QIoVMCfwvTv9Cc5lakYL3sNEKKGUHOy6LGICKnMeRUYIX7160DSvfiaD1PLHgELW
         l92RoxYv6BHBHQLfLRbnI6HodIqGH6mw2RSLbuH/HpIdoZTh2PkcxCcduwBwt/FmRUsH
         c4COjS6axo2qSzUkZe2sqHrjdAGaEzwj+VTy2FXyt1IY/3On568USCR08zaEUHwxKwp3
         e6yQDaPmvvM7xP09hpnhroFSdCil7ciEGyTpp4KwgkUkENc+EwE32OecoQF/V6iF/EYP
         VGrA==
X-Forwarded-Encrypted: i=1; AJvYcCUV57EpISHl3qv6WznbZcYHJlzUgFddEmutNTQ0vczLy1avOlO/gpVehOlryZtsqiSpIWHyNQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxn48sds+4qS41q6O5p30wWCeeAnHOenMkJhsEQpayGnd54hvvT
	U5WmBjbeL3NRnVQmLM42rlNcuVVkLIG0wBKr/8AcqPzaCKzU4Kse
X-Gm-Gg: ASbGncuUNaYbWweVyKhcQdC3hlL1qtitX3Q4iZVFSbWj6goOPgbcDZjqG3l+O2ZobMx
	ffSW3RBhqY/BZ0rOAVztA1R4JUILxaVdCJJBGr1E6WNwZ5evtAY1DrUhxkrXckIk8D0TSXgaE08
	59mtr/VREjjhUfNjr1D/SzCXOa0d+pOnJc722MgxyHW+xck9U4I/E9AA/9Hv0/4lEMmG1DjqRbt
	CJJRe7sLkdGuT+uV+Bv46SYKRx+TCFpGlICJXOc4txvQqpkXwu/Oayg434w4UVGE+ibU5oQ6vEq
	a9MQ4NXGsFs5l/cVvirnPDeDqJMisklnB6xfUnjK/uAs
X-Google-Smtp-Source: AGHT+IGL+2VkvZUTLK5bh/+zKUx91iBAgtBVleFDA2Cq1ZEhcmX1cqdZcGj78v2l4OVP0YvtefEQjg==
X-Received: by 2002:a17:902:f68f:b0:224:3610:bef4 with SMTP id d9443c01a7336-22921d5fe82mr37434305ad.25.1743162434071;
        Fri, 28 Mar 2025 04:47:14 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73971091ce4sm1548199b3a.132.2025.03.28.04.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 04:47:13 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 0409C420A74C; Fri, 28 Mar 2025 18:47:09 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux.dev>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] iommufd: Fix iommu_vevent_header tables markup
Date: Fri, 28 Mar 2025 18:46:54 +0700
Message-ID: <20250328114654.55840-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4215; i=bagasdotme@gmail.com; h=from:subject; bh=fSDDLJIg1AIFezqeviZx0z10om+VyB30CEwom2stASw=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDOnPuvfMqq4J+PvAebYEx5WAXL26NXcVNoidV9F3auqz6 Hm/t/pNRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACaysJfhn9mW60I9qx4tEbi1 Q1Kg8WKS4MyQN2+Ouf+73JabIWrJ7MTwh/PvpC0zNA/denZUgLmW766oQoGwyHujKcULUw6kxH7 L5wUA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Stephen Rothwell reports htmldocs warnings on iommu_vevent_header
tables:

Documentation/userspace-api/iommufd:323: ./include/uapi/linux/iommufd.h:1048: CRITICAL: Unexpected section title or transition.

------------------------------------------------------------------------- [docutils]
WARNING: kernel-doc './scripts/kernel-doc -rst -enable-lineno -sphinx-version 8.1.3 ./include/uapi/linux/iommufd.h' processing failed with: Documentation/userspace-api/iommufd:323: ./include/uapi/linux/iommufd.h:1048: (SEVERE/4) Unexpected section title or transition.

-------------------------------------------------------------------------

These are because Sphinx confuses the tables for section headings. Fix
the table markup to squash away above warnings.

Fixes: e36ba5ab808e ("iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20250318213359.5dc56fd1@canb.auug.org.au/
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 include/uapi/linux/iommufd.h | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 81c31a36e14a97..fa479700918409 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -1045,21 +1045,26 @@ enum iommu_veventq_flag {
  *            [0, INT_MAX] where the following index of INT_MAX is 0
  *
  * Each iommufd_vevent_header reports a sequence index of the following vEVENT:
- *  -------------------------------------------------------------------------
+ *
+ * +----------------------+-------+----------------------+-------+---+-------+
  * | header0 {sequence=0} | data0 | header1 {sequence=1} | data1 |...| dataN |
- *  -------------------------------------------------------------------------
+ * +----------------------+-------+----------------------+-------+---+-------+
+ *
  * And this sequence index is expected to be monotonic to the sequence index of
  * the previous vEVENT. If two adjacent sequence indexes has a delta larger than
  * 1, it means that delta - 1 number of vEVENTs has lost, e.g. two lost vEVENTs:
- *  -------------------------------------------------------------------------
+ *
+ * +-----+----------------------+-------+----------------------+-------+-----+
  * | ... | header3 {sequence=3} | data3 | header6 {sequence=6} | data6 | ... |
- *  -------------------------------------------------------------------------
+ * +-----+----------------------+-------+----------------------+-------+-----+
+ *
  * If a vEVENT lost at the tail of the vEVENTQ and there is no following vEVENT
  * providing the next sequence index, an IOMMU_VEVENTQ_FLAG_LOST_EVENTS header
  * would be added to the tail, and no data would follow this header:
- *  ---------------------------------------------------------------------------
+ *
+ * +--+----------------------+-------+-----------------------------------------+
  * |..| header3 {sequence=3} | data3 | header4 {flags=LOST_EVENTS, sequence=4} |
- *  ---------------------------------------------------------------------------
+ * +--+----------------------+-------+-----------------------------------------+
  */
 struct iommufd_vevent_header {
 	__u32 flags;
@@ -1117,9 +1122,11 @@ struct iommu_vevent_arm_smmuv3 {
  *
  * Each vEVENT in a vEVENTQ encloses a struct iommufd_vevent_header followed by
  * a type-specific data structure, in a normal case:
- *  -------------------------------------------------------------
- * || header0 | data0 | header1 | data1 | ... | headerN | dataN ||
- *  -------------------------------------------------------------
+ *
+ * +-+---------+-------+---------+-------+-----+---------+-------+-+
+ * | | header0 | data0 | header1 | data1 | ... | headerN | dataN | |
+ * +-+---------+-------+---------+-------+-----+---------+-------+-+
+ *
  * unless a tailing IOMMU_VEVENTQ_FLAG_LOST_EVENTS header is logged (refer to
  * struct iommufd_vevent_header).
  */

base-commit: 899ddafec3b4adeb324ebda146914980137c1553
-- 
An old man doll... just what I always wanted! - Clara

