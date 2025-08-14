Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842D0266574
	for <iommu@lists.linux.dev>; Thu, 14 Aug 2025 16:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755189120; cv=none; b=AGz6msLe+o8rTH3KZplL6XPvz29tDeEDypinjTiW/fRkMpiVesErUADK0yjQI3Mvi5FE361DKG929Rl8RB1MM+wgUmDg1heF50xvjn5a+KoodBb3+WDbHrbyPbtPhG7eQuSJa+Xf3G9kuiNb0I48WPFVdPfRt+mNIdKaDL4jHKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755189120; c=relaxed/simple;
	bh=9Wa5jqPAwkgeEuFRsRyS/7h6RN1g8UcKkO1sNImbBhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NYXjauEjGfN/TGw/g7TTo6aKDAnzdi5sHIkx5QdI73YEOt7fp8O+X7bePhgkLCCRFh9awwVhhxr48WaFCt/+keqJo/nsiTNwwNzE+w9RIGHtpIVbBoKICWssaehSQaoqgB4w2px1q1kf8HT7gfwjtKHAG8EpBo6NZhhhBKMYii8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=cfrdw8qs; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="cfrdw8qs"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7e8704cdc76so110048185a.1
        for <iommu@lists.linux.dev>; Thu, 14 Aug 2025 09:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1755189117; x=1755793917; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lTcvVfxgncNMa1Iq0eQuGoB8h78T3XfCXO2iDvh4lTw=;
        b=cfrdw8qstHwSc4nJAYSmrnIikL4mUQGC64m1dGpNs6COrPSvooLdvNExHHCL7ER7pV
         KZKSbhtunm1QUVTrs9yMfhOrC3jbfFS72bwSccPmSJyV8tFl2clxlR+IlO/Wy+yYOOZW
         PgIXbUphrPHFNZ4Lliu2fjKo/i3bq1Ej43SDRY2l2OmRPkHKtlqD8hv/CzM1Sk6pp85y
         BVb6WMvwvTzHxgH1fPeUnak+/niyKUP2OKKe1Hapr/Bm8SIff7uk+7Cz++lcZivU63P8
         TFH/04HsXICZNKRAVPF0CC3KFI09zd3dSuy8EsRQ/SoumsMwI4En1Y534uqinSZlsSAH
         9RGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755189117; x=1755793917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lTcvVfxgncNMa1Iq0eQuGoB8h78T3XfCXO2iDvh4lTw=;
        b=A4Y7NR6R2tqeufhTuGHPofgRWhSdoYZYSgU6Dw0eRfC/4XIVrX0L3LUYjv3tq6G2rm
         o64qiktgJWTZGjvdxNhIYw/hSUZYZJOhlBslnaytOpZUfnJc19hn0vZ1JACqeLp9pyOi
         B/TNDkIixItAHc/WyEA1OXJt7WalAHfw9IuFxAu8HIvHoY/ZH3zN4zfkDjNM4rrKb0mZ
         T0BVaxrJmdLZ1EtHptx+g0hCR441kzJbPplSSb8+kG9MNTq1jXgAbixBeSwuzfSkN0uy
         3G1oHeGUph26uV/eYxIlYrJaNO61qEWEgvaJK1uwN2UuE+mHXT5hDI6EMcKrw/uiulXY
         8cFg==
X-Forwarded-Encrypted: i=1; AJvYcCXA+PF/ibRlhG9/oSfUeYRbJB0BrVcJ2pV8+yT48fEo+ZJeJNwSqgfPCLOIVXCXUtWGMZKB9w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxg5XD8hr1OC6icI/+2XdKne39vTM6DSWsh+rTXl4/lE4ROgrez
	XpyxRtadljCgvlIiOOpYFKt5C/jwSQ5ozifhMzZr1xIBH5nL07Lwh6qGXovBsY6s4AI=
X-Gm-Gg: ASbGnctkM0WmOjB2tWQ5xTRMfDUmpT/4Arjqg56kZOaolDBDErJnMaFwoBNW14mmter
	pjSaSs+2yXBa0BiRdR0cAcI5G5nRUL3r5G5z0isq5++JLEiTmbur2DI04+a5p7DPm17q5l+LMj8
	WJTygyDm94F/Vr2kFjHZiTsJJNNU9goIRSH4L6mOPuApg5zDMEJ1xbTe+rLsHuS6C/Ori/ZH/hy
	oZQrA+h8r2/uZFbm/Tm9rf3GuF4gQ36ckc7s643bh18wAAIhO13PBUyot+O3ha7J5fdIUai1UjX
	szZNS0wSkiSAzNP7ZckGsCWZnuOyHYpqwW7fIrWFABQs3o/4snfW/HmaOmkc3+BMck5w7diVm6t
	g2ZCi9AcJRoBOWnEal9j91+7JkWIYgjyLcQjH5V15sBWPqhIyJL+4RREP0pAGHmlZPbbhrr2Q
X-Google-Smtp-Source: AGHT+IGbI/dL3O4lK+AB9+uWgN01ynO7vfbJIS46vI8nywFNU3aZvLm4Hh/hg2gSbWXDC4HQ7N2wKA==
X-Received: by 2002:a05:620a:4727:b0:7e8:6402:aeb4 with SMTP id af79cd13be357-7e870426c07mr560417685a.18.1755189117053;
        Thu, 14 Aug 2025 09:31:57 -0700 (PDT)
Received: from vineethrp-dev.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70af5bff7c3sm14747576d6.78.2025.08.14.09.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 09:31:56 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/vt-d: debugfs: fix legacy mode page table dump logic
Date: Thu, 14 Aug 2025 12:31:47 -0400
Message-ID: <20250814163153.634680-1-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.51.0.rc0.215.g125493bb4a-goog
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In legacy mode, SSPTPTR is ignored if TT is not 00b or 01b. SSPTPTR
maybe uninitialized or zero in that case and may cause oops like:

 Oops: general protection fault, probably for non-canonical address 0xf00087d3f000f000: 0000 [#1] SMP NOPTI
 CPU: 2 UID: 0 PID: 786 Comm: cat Not tainted 6.16.0 #191 PREEMPT(voluntary)
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-5.fc42 04/01/2014
 RIP: 0010:pgtable_walk_level+0x98/0x150
 RSP: 0018:ffffc90000f279c0 EFLAGS: 00010206
 RAX: 0000000040000000 RBX: ffffc90000f27ab0 RCX: 000000000000001e
 RDX: 0000000000000003 RSI: f00087d3f000f000 RDI: f00087d3f0010000
 RBP: ffffc90000f27a00 R08: ffffc90000f27a98 R09: 0000000000000002
 R10: 0000000000000000 R11: 0000000000000000 R12: f00087d3f000f000
 R13: 0000000000000000 R14: 0000000040000000 R15: ffffc90000f27a98
 FS:  0000764566dcb740(0000) GS:ffff8881f812c000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000764566d44000 CR3: 0000000109d81003 CR4: 0000000000772ef0
 PKRU: 55555554
 Call Trace:
  <TASK>
  pgtable_walk_level+0x88/0x150
  domain_translation_struct_show.isra.0+0x2d9/0x300
  dev_domain_translation_struct_show+0x20/0x40
  seq_read_iter+0x12d/0x490
...

Avoid walking the page table if TT is not 00b or 01b.

Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
---
 drivers/iommu/intel/debugfs.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index affbf4a1558de..5aa7f46a420b5 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -435,8 +435,21 @@ static int domain_translation_struct_show(struct seq_file *m,
 			}
 			pgd &= VTD_PAGE_MASK;
 		} else { /* legacy mode */
-			pgd = context->lo & VTD_PAGE_MASK;
-			agaw = context->hi & 7;
+			u8 tt = (u8)(context->lo & GENMASK_ULL(3, 2)) >> 2;
+
+			/*
+			 * According to Translation Type(TT),
+			 * get the page table pointer(SSPTPTR).
+			 */
+			switch (tt) {
+			case CONTEXT_TT_MULTI_LEVEL:
+			case CONTEXT_TT_DEV_IOTLB:
+				pgd = context->lo & VTD_PAGE_MASK;
+				agaw = context->hi & 7;
+				break;
+			default:
+				goto iommu_unlock;
+			}
 		}
 
 		seq_printf(m, "Device %04x:%02x:%02x.%x ",
-- 
2.50.1

