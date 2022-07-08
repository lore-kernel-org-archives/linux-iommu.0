Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC9C2575
	for <iommu@lists.linux.dev>; Fri,  8 Jul 2022 17:08:16 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id l68so12727555wml.3
        for <iommu@lists.linux.dev>; Fri, 08 Jul 2022 10:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rjtnXjJTM76a8uBuPAjTSUIAKlaLeiPacD9QEtS4qDw=;
        b=MDtkeEsInPqXPzZim3GXqcRJnQOfNrk0zyh69sg/F7vVFzZs7k4LbrmXCyoJMhe+pk
         hV6nsVlhB1c8j3aePLXYPVgjfKdkU6l80MZxTr3QLcbG11/Pkn1zcGUlv8v9uLrr+Y2R
         zUbnawCQw1MwEaiv2QUN9UWeC6sUxoBqBUMkGsmZnfBgcqnehNvhJ6lSuElTcEB5F4ov
         fnl76H5vXeqI5YM0r2YMAhMa7Oe2ouD2XUJMLO8XC02bnjHKvz8/Z/bRDT6kP06yvLlp
         E3VxyeGZdW978yMpMTQWBWvM8vblfY6+0by9evAAG1hP2wYpL7l/LhvUnhkHrHW2V5+B
         TUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rjtnXjJTM76a8uBuPAjTSUIAKlaLeiPacD9QEtS4qDw=;
        b=7DySiOEnrWAEG6KsCP1I74/ZDkTAvASHfAJfMM1wXtGVS2PEpEYxlK4v3//1VxGikr
         ZEXZBSdAphCWbJj9xObqqUSGcMRqbE2YmzUgzUaocwmkcR/XlPdEdFZRQDKHCY2Ejkra
         +4j0aKBJq2bDjc3JQYQSOw+t26NvcrWst1M335Ecjpm3lr1BLugWONwwTSYKmEbxoqVt
         FbSl6RQJWLLOWik77bthFgC7np3G9KLnLDlY5LZLqN1vmfpNmQCXhwFnwoX5uVDkY1vi
         2egCF+AgG+GmM7AIjvqotaJw09VkuHZZ+Smk7hUr1jOBMcelKTiRndCabG03jQhJWW8f
         xG3g==
X-Gm-Message-State: AJIora8PbVCZ5y8MEYyzqmGVsMJAJXSxXlexl1t6WzZuvrY3hu13iRfK
	oxKEF3R5RGXEjrCWt4uPqoJTCg==
X-Google-Smtp-Source: AGRyM1uLwrXqWANfQe+1Wila+2ISVN7BYY7M0YDfWZQ2VfUWRzFwS//um4Nxt9sS7P6MX4Tl60U/tQ==
X-Received: by 2002:a1c:7405:0:b0:3a2:de4f:5f07 with SMTP id p5-20020a1c7405000000b003a2de4f5f07mr840272wmc.117.1657300094872;
        Fri, 08 Jul 2022 10:08:14 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id k9-20020a5d4289000000b0021d9591c64fsm92701wrq.33.2022.07.08.10.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 10:08:14 -0700 (PDT)
From: Ben Dooks <ben.dooks@sifive.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	iommu@lists.linux-foundation.org
Cc: Sudip Mukherjee <sudip.mukherjee@sifive.com>,
	Jude Onyenegecha <jude.onyenegecha@sifive.com>,
	Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH] swiotlb: ensure io_tlb_default_mem spinlock always initialised
Date: Fri,  8 Jul 2022 18:08:11 +0100
Message-Id: <20220708170811.270589-1-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the io_tlb_default_mem is used by a device that then gets used
by the swiotlb code, the spinlock warning is triggered causing a
lot of stack-trace.

Fix this by making the structure's lock initialised at build time.

Avoids the following BUG trigger:

[    3.046401] BUG: spinlock bad magic on CPU#3, kworker/u8:0/7
[    3.046689]  lock: io_tlb_default_mem+0x30/0x60, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
[    3.047217] CPU: 3 PID: 7 Comm: kworker/u8:0 Not tainted 5.17.0-00056-g1e9bac738084-dirty #310
[    3.048363] Workqueue: events_unbound deferred_probe_work_func
[    3.048892] Call Trace:
[    3.049224] [<ffffffff800048aa>] dump_backtrace+0x1c/0x24
[    3.049576] [<ffffffff805c5f74>] show_stack+0x2c/0x38
[    3.049898] [<ffffffff805cade2>] dump_stack_lvl+0x40/0x58
[    3.050216] [<ffffffff805cae0e>] dump_stack+0x14/0x1c
[    3.050460] [<ffffffff805c69f6>] spin_dump+0x62/0x6e
[    3.050681] [<ffffffff8004e000>] do_raw_spin_lock+0xb0/0xd0
[    3.050934] [<ffffffff805d5b58>] _raw_spin_lock_irqsave+0x20/0x2c
[    3.051157] [<ffffffff80067e38>] swiotlb_tbl_map_single+0xce/0x3da
[    3.051372] [<ffffffff80068320>] swiotlb_map+0x3a/0x15c
[    3.051668] [<ffffffff80065a56>] dma_map_page_attrs+0x76/0x162
[    3.051975] [<ffffffff8031d542>] dw_pcie_host_init+0x326/0x3f2

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
 kernel/dma/swiotlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index cb50f8d38360..a707a944c39a 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -65,7 +65,7 @@
 static bool swiotlb_force_bounce;
 static bool swiotlb_force_disable;
 
-struct io_tlb_mem io_tlb_default_mem;
+struct io_tlb_mem io_tlb_default_mem = { .lock = __SPIN_LOCK_UNLOCKED(io_tlb_default_mem.lock) } ;
 
 phys_addr_t swiotlb_unencrypted_base;
 
-- 
2.35.1

