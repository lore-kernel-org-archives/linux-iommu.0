Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795094011;
	b=15w6UReEqgvHC+ADYwMZHtcVk5vGw/fNCTiQIrvZ0gdPDtRMt/am4GD2CKneuIxK28Ii
	 RQ0XHNqHpt32HdPL9+FdqWFKvYzNH8ThUHHxjWKQmgtpbnd7E5Nqc++Axs4PTfLLb5r57
	 +4sxLjsflQrzvmNtTiRlc25XtK5GJ8EZDf17lIpS3Sj6VxcLWM6NphiDsS1uYuXiYPwVp
	 AljLOIOG+FhUaEIqSmWYWf/7s+M8HoTugtsdbyteVmw29c3NH+aKyf+8SG3A6p+LFqTH4
	 jvHH/1jQq08TVwRe317jhz8ZWVBuXVKTXFczm+PRhPy0mm45K7X6LxvXFIPc1sRUSeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795094011;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=p/gxGOGIabTvhDzdnoS76sqroBvMTDVJ3mpZsoNp2Vw=;
	b=pr9q3grUHNWBQmtyknY5mbCDWle8VhDwOKxy2XKf0K2qjkh4Wu/lSzQCKOlnYoB59R8f
	 6leWzcAhuH6tbZ3MTN49+QK9FmSL07L6QyhXu2+BHLXZ+z04Hu87oyXkpgLDJL4892jFD
	 VWwLmHE0OgX/FA61qTt9qhVvA9IcMFULTYx4bFV9E+7ZKSvL2awmzBK+46aQidGP6YaBE
	 lLFXbYUEjOSbJES3WV0JpjXoooSIXpsfzo+OiKCSxSLamKRJ04KDN+g6weFTD56fd/1xl
	 mnP10PHe85F9ZkpsL90GqOvcn9q4eI1qfAMlA7rKPMRP3Ua/Q8GzgtC29kVzykrIFfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RHLiv7Yy;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36C3606A32C
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 13:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C36C3606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RHLiv7Yy
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4a7b8abe209so1250752f8f.0
        for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 05:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795094009; x=1795698809; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=p/gxGOGIabTvhDzdnoS76sqroBvMTDVJ3mpZsoNp2Vw=;
        b=RHLiv7Yyma8Se1fDu7Ht8X1SMZNXwbG+UVOV15vME4OlokgQHfVGMvnQsrIlfm+56f
         B7p5aG/JpYJjcWd/vATkqW/50QUAj77ugmRJ9FAzAE54kWFs2sgBTwziL5FfkEcnxluU
         a1TVwwGAyoWXBaI5foF2Gaaul/VtocrPLNIzxCmGDv32AJShvT5pctURzFTazzIRzOuo
         4YXr8CQv8GXJY/S6q5sZJrUJF4TZJu/7xCS6qoQ+KcAkmql/aOz5/AyArNNoVYVpw2lo
         s7x3EXYQs4WbyaPIEPghVESYQ/Ch9PzaKfRG2mrFLfRSKYWqMzEq+h8R+QH8GX+mXFeG
         YAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795094009; x=1795698809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p/gxGOGIabTvhDzdnoS76sqroBvMTDVJ3mpZsoNp2Vw=;
        b=a4bWIy3CBdHjLbJDjHXm1E0iGMmo0ZyIPxCzap2PqNeQEJj5wwMU2wpF6l4dcNjYdl
         orJsMwycw8JfabAL9aiZLaeXY1yV38o3Fie21EXtC6PskVbEWISAy1eiHnXqoGpU/yB8
         IE8LZzO2KJ46G6c/Twzl/apJvvWG8H3XF+Y79mYZXaQgxcc9Ujd8TqJIt2QZJTP+SGJ9
         XAZOkvILsAdnNYw2WACBcYLg0qj0Qh4mKMVu9py73oMxD201NjZystHmpn4o1AkhZ4pV
         Z4h6yrByanseNqMXOW6gCIpvUwpF7lujy4XxtJwCwbHTqHps4Zuu+hddEqCEm+8qolYc
         qpRA==
X-Forwarded-Encrypted: i=1; AL+hErELcXlc2jmi8hfI6DfUatcqodFZYu5vRiBQrTruu9KjNQNYYZXjig6DEQDKLgEVgFLF7Gs4dQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+ABmTp/TekhPiDrOJHnH0iggCQiUj/O//ufX85fmtgY+atSTnt
	jbGBUNnbZemShig48LM4pfYOQLh8HzS7HP0+QA28U/ECfvevVvgrDm1d
X-Gm-Gg: AYBFou3CT82ocMOganeC6KTgGkNln33voB8SQzIxikKh9Mbf/eb6osdaueTZaDSopIs
	4B69p2giQpwrMK0axL9vMq3Qdohcd/4bdUCAokOg6Eq4898YQLOTUPBhEtzPhWT1MXJoPIdeXma
	hcNKonquUtGG7ZBtXM91HzmWojN5typ5+ng93fx1L5gBW9GmBYpwBAY7mIpTKRLiCfaSWVjXElx
	nMq84e/2GOsovcoII2yOZnHErFrUphYe9yJg4fUGTKrNpN4iNtSfRh1wxvMbdiN4n5H39EzKY6v
	0lkTN5avNfgytUyu9fQV0mPtE6j+SNoRJD3zJGY9SvBLhLVfabL5dG7M2VYC//1PHdGCcF5Zf57
	f+ldigqxHSndSJRF/qP9Kro2unqSPNrcywQkPaZK0eFrbbvquAeYXnzix9XNJciup81SA0iHY4L
	PaYS2takcyq985RP7J3l8c03uXnRjv0WpeXCjRS7dC4GQpZre8JQx8j4pV+5jeSWjE5azDt5lWV
	cil1Ld9S55U7wY3Eo1xHsu3JyfXVx3Cl4s4Zdvedvvy1VRTb8wkYuSrpKkf59FqQobpkjoFsfHL
	z59gYSVu15XL/CzpPgdWzQ+gru6EwiCCoroy
X-Received: by 2002:a05:600c:3556:b0:4a1:dda8:eb73 with SMTP id 5b1f17b1804b1-4bb7da26d70mr121120125e9.27.1795094008771;
        Thu, 19 Nov 2026 05:13:28 -0800 (PST)
Received: from LAPTOP-AVI.lan ([2a06:c701:477f:ff00:c2fd:f9b8:4971:d270])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb84e5edf5sm18258045e9.4.2026.11.19.05.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 05:13:28 -0800 (PST)
From: Avi Weiss <thnkslprpt@gmail.com>
To: m.szyprowski@samsung.com,
	robin.murphy@arm.com
Cc: ailiop@suse.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH v2 0/2] dma-debug: Avoid uninitialized mapping dumps
Date: Thu, 19 Nov 2026 15:13:23 +0200
Message-ID: <cover.1795093513.git.thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Booting with dma_debug=off leaves the DMA-debug hash buckets
uninitialized, but the debugfs mapping dump is still registered.
Reading dma-api/dump then traverses an uninitialized list and
causes a NULL pointer dereference in dump_show().

Patch 1 skips debugfs registration when DMA debugging was not
initialized. Patch 2 removes the obsolete debug_dma_dump_mappings()
helper and its only caller in the legacy AMD GART IOMMU code.

Validation on x86-64 QEMU:
- baseline with dma_debug=off - NULL dereference in dump_show()
- patched with dma_debug=off - dma-api debugfs directory absent
- patched with DMA debugging enabled - mapping dump readable
- both objects compiled successfully with W=1

Changes since v1:
- guard debugfs registration instead of the dump paths, as
  suggested by Anthony Iliopoulos
- remove the obsolete mapping dump helper and its AMD GART
  caller (due to feedback from Robin Murphy and Marek Szyprowski)

v1 discussion:
https://lore-kernel.gnuweeb.org/linux-iommu/05c05ec4-b321-49d4-acf7-b9fa4223dba9%40samsung.com/T/


Avi Weiss (2):
  dma-debug: Skip debugfs registration when uninitialized
  dma-debug: Remove obsolete mapping dump helper

 arch/x86/kernel/amd_gart_64.c |  1 -
 include/linux/dma-map-ops.h   |  4 ----
 kernel/dma/debug.c            | 40 ++++++-----------------------------
 3 files changed, 6 insertions(+), 39 deletions(-)


base-commit: 97d73c8251226cf27cc6656b4c542869bb8c69fa
-- 
2.43.0

