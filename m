Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C835A271468
	for <iommu@lists.linux.dev>; Thu, 14 Aug 2025 16:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755189040; cv=none; b=o2G9sah0Ebv4F0wPtLLOp20U91e73kERhrt3H75SfLXc9P0qtj8Z0CYRnF2u7U3IuXu2Kp0y8ePEg+ONHlsbSecaWhycec3BXnYVDdB58lKPufPjWumW4YclEsDYsNc0LjY508+ofxqnoAPYEaVffJDskpjt0hFvTlQW40wtFkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755189040; c=relaxed/simple;
	bh=9Wa5jqPAwkgeEuFRsRyS/7h6RN1g8UcKkO1sNImbBhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CW517vyYziq+UiTCpeWPrYLzs6vTc/HUo0d5P0UfCSud3lktY3z9Rl7coI8cb/+1a4TZhbXCywvvArxdTdZD3vH1Rh7L6Gf1eeMhdxhap0otNFPcvidZZTG/cJFX5h5fYsbDe+nZABoBqktxG4BatPoSBX2WHJGbz9Fip9f2xkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=UHQmtOq2; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="UHQmtOq2"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e8706a6863so117176085a.3
        for <iommu@lists.linux.dev>; Thu, 14 Aug 2025 09:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1755189037; x=1755793837; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lTcvVfxgncNMa1Iq0eQuGoB8h78T3XfCXO2iDvh4lTw=;
        b=UHQmtOq2ygVhXxAsz5k6+LfOavxDJ3RyWxy10UIebWaCrnAYCsWN5yBjceb18wLJtv
         Rq55vlCPOU6uvxgRVUe+NzWS1Qj4uEwzIOdAm0TDQ1ioYCBxmuQGVyzRRfflq1Q2ExBJ
         5MzXizHVfcZ3BbBHh491C76eItdTxz8UgdnZLnkytuT+gus1aGhjDbvvmkF3B2dhyVfL
         KQn7fxPF8q/cRNflZrHxF8+cLH8yEeX+A5D+nQVrXZHsRY+iMsc6STrXS1taCaOaSFpO
         TDEhE9WpWo4Wss85GRjSokHQBsEtX9wYXRN/FI4/PAw/iZQMPzk3tKBvLKwEoeVbVl1U
         tTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755189037; x=1755793837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lTcvVfxgncNMa1Iq0eQuGoB8h78T3XfCXO2iDvh4lTw=;
        b=Iq53hBNoUkaIr9M1ciH4Ekuffdjjg34LZKISLvTiadBT5mcBd5BINfwjFamzr3qg81
         D1V9R/dEuhTgEiip9YsrHVB1xBcEvC6Ox8NtaCFIgL/++dhlEL9YvP6Sleb/hAZX8cZ9
         MURo6D/8eZk6ikLNyvaqAg1UwIzFQ+Kr5JlKxxQjlmB7wOCbYW4FnsqPw6Ei9ShIoGiA
         DR6o3uqgsnJv4HpNTcSRSHILXCgEekFg7iLYT4XrhGlFqexTjudDPCv+bvCEdEkeePei
         coMBMPsJKtw0vbUsNhmjsenTD2firBoB3Y6yavgQCcLNI6EA1MntVwhdoVDiq2T52LGX
         YMTg==
X-Forwarded-Encrypted: i=1; AJvYcCVv/Z+/0udZMfYdbr/ifOYMLnXfCqy1ZPo96Qyp5HMUv0soPespupAp4gQuG/JsXVWroc7vOQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxsV8rD4ryjozJhhxC546RRWvyelY5HoYQbQHl51uuGmZVLVraQ
	s4glcsDSYoG1nR4MZKoi+MnX2p6V46I7c/A4rHyEoTPuoRDc6o2dkNkn7wGHMh0IlMo=
X-Gm-Gg: ASbGncuDn0Xuozw5a9fYHIx+i9dOYe0pSmu0rGUXqHzrNHQSMOAyS0AsWnHHGUqid0h
	twuvVCfgW4PUL1eBdESdtfEQ4+RWLY10JxC+iaVzYvCltYeBJLcY6QnQXCwDlnOxHVS9BkW3K3N
	CUfSYVGj5CU9iXs5VznY96pzc+jgiYMz20TQRvqIoWBRGfMGuvli2xXf95mvH7UYSibXuPbw7/a
	AwpIbf48lQ5+1qJtYVKYljde35XqNYaz7PwrFTXGkHQ6nNEvSi8czAA4/JkCqzKFwIgMlHIS6XE
	rZ9acEKyCvg1O1ugFpcdUXKgHR4JZha29X/7jsccbNo3DWhALTeS0H8yfdk7KgcfO05ZFu1fIUG
	+2UzpkZOSyYfuFFP0CWP/GaaCl1tYtKCWbRm3eZEdCK6zpDYU/hrXNj00a0THzs95Se2WKQkY78
	Tu7WYB06A=
X-Google-Smtp-Source: AGHT+IE875VpR9LBaN9clxrcxJ3h9zgxKT9RUmPEPlW6JReinUjgAiko9WQ+nb3Q/3zGXUMFYHDA6Q==
X-Received: by 2002:a05:620a:3910:b0:7e8:6d58:b4b6 with SMTP id af79cd13be357-7e8703c8783mr622951485a.11.1755189037156;
        Thu, 14 Aug 2025 09:30:37 -0700 (PDT)
Received: from vineethrp-dev.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e83075ffa6sm1131637085a.4.2025.08.14.09.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 09:30:36 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/vt-d: debugfs: fix legacy mode page table dump logic
Date: Thu, 14 Aug 2025 12:30:24 -0400
Message-ID: <20250814163026.634182-1-vineeth@bitbyteword.org>
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

