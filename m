Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8C53BAD89
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 09:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779268742; cv=none; b=cqelvwxmQ864jFtpyRSNtDxuJntv+J01anzVfdW4mgyxMEuIJy37tALSfzDfZA1Mc5tDd6FOYQLjE/M2hSX86jeGcwntTjeDRzEObu5meMRDyFf4/9Y+cKYv1uIzXxaMy7Il1lVmjRHrdZrmdE760FGJfDwPgNAk7TQzA8KOR9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779268742; c=relaxed/simple;
	bh=VdYMZfmdWGinCscf69KLX3fpX4Qe2QiLkBtyEy1U2/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UZGsavPr60WtOnelktzU5tKab4agOZGr92HOmNQiHUugJ4nP3wkYtasuMF/yL6f+ioh0m3FzfEpnexiEltcJ+JanOA/oTY/eQZbg2zniKPFjvf2mKO9KDRn3eHKlTZdH4hFRg4MuuyXce/0VLKsTFzf7M7mHsjOt1lBN2gHI0fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s5bcefgy; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s5bcefgy"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-82f8893bff3so2117250b3a.2
        for <iommu@lists.linux.dev>; Wed, 20 May 2026 02:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779268740; x=1779873540; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mxzEWL1R2sDou1abx9yR2WoOGdqqnaGEsR/cU7KUoPM=;
        b=s5bcefgy5cHU3TnsAR51TCBfc1g5wXGMLmuVywASn7nSXruBoGkxhNbilzCwq3yHME
         6onJycYOx/47H2olDkTg1083xSeMHTCkWjYFurEKzoRbbiF0EAQg29qpS1aAiANxkK8y
         Ppt9qjx5HpfvwljWTZosmSyCmza83hSKJcE+ALNhsGdbiDxcQMD5fmB5MM+MZxHeuUAx
         yZ0Cgfqy2Ale9PTnkX26W3cKcs9Hc3958QLdn2nG7IifYTqx0PFSgRPVQYmMAwnpxEw+
         TwFpvcfj7CgTEuW8N56Zi5zoURA+YKn/+LYiHIXCdnmeI31TSSrnLTeyZkCHDvXnbx87
         QaIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779268740; x=1779873540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxzEWL1R2sDou1abx9yR2WoOGdqqnaGEsR/cU7KUoPM=;
        b=K5OwOeuDJv1rHsLRYn4PqyRnivewwC213hni+uJ7RSwAuQioZj4mA44ypIBybPS2pP
         NdU2XkuDU2cpXGZSb9V36NajejlQzau8IOCVXZDgXXe+GFkfkfbWTi9PzvUdbFJyG5+0
         u+txIeDaf6A9ziV9ajaI8CZ1JYoBpKhdBS1gBAmyqtsjKw4UDTkyRyvwlNJ2b6J10wjr
         6ImBwjzGpCvjNePDrx7tiRcbREy5JSp8QQFzyjk8BxYYykzhuiZuR9L92C+DnBRdb5qj
         4GRXsJTnA5CZeA/HIII/jK5qhF2KJasNc7kX7VsrhqvHBd4oOrI6dW7tLDRrDoOYAq4A
         asNg==
X-Forwarded-Encrypted: i=1; AFNElJ+oc5TOwqK3Y/wNVgv2mSlz4T8TMrC8zLNjqQdvq87fPxlvGLLcCcovHOwZhum2yAWq2VWO+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQerCBQlUbt2VnNAHsxNRjLUAyaDWtjWCkoicv9JC1HUlXJsb1
	6fJcGPq4131EfMASirhlIvL8v2annwQI5WQ/uIyUOeCQfmxn2pwJh6zV
X-Gm-Gg: Acq92OEwA71vszF5EWpZQbV8j7BxxiSrtbQJ6Tq1DI9iR/TqkYKQ7cytKBKXWLWNrkQ
	ldAEkITBC7ZsqQLdWg5Wf7UbF0sLU6iVwaqXlXbPOvuXIhpf6oMOcspmP1LAjIYMg8fx4woHdu8
	u87gVbL+/yiAPflHepMfodqGzPDO2MZTkY8kZ3+14drBfP1VQbyoM0EE/PdUt1/XMBE7wswvBWR
	BrOQ3RUzbyMqH+M+NNxM22CnJ44cSomQtN+WfQMLb+5XEBRJV7BvDo2v41f5irx4jLr7XeTIOA2
	VUJYf+adNxA8EkDMW+j5XFhgzVkaWmFx6hlw3rl7KNnlMfXuO7RMjzjxWZbcYRTI0qzvv59VDe/
	Pa3bMbgVM4jS9hzUaa/ceJ9WpASJmEOk5TcH9glll2vBRkvaqP6rSJ1mlPa/m+ctJW/5pxyLExE
	bAOTfrlMJmSn+8FoXd1sl7dCYCkufRr1B+1ovZuA==
X-Received: by 2002:a05:6a00:2c95:b0:82c:e816:4135 with SMTP id d2e1a72fcca58-83f33de9724mr22532227b3a.47.1779268740373;
        Wed, 20 May 2026 02:19:00 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f63bb986dsm10208967b3a.48.2026.05.20.02.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 02:18:59 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
X-Google-Original-From: Wandun Chen <chenwandun@lixiang.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	iommu@lists.linux.dev,
	zhaomeijing@lixiang.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	robh@kernel.org,
	saravanak@kernel.org,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	leitao@debian.org,
	kees@kernel.org,
	coxu@redhat.com,
	tangyouling@kylinos.cn,
	songshuaishuai@tinylab.org
Subject: [PATCH v2 0/8] kdump: reduce vmcore size and capture time
Date: Wed, 20 May 2026 17:18:36 +0800
Message-ID: <20260520091844.592753-1-chenwandun@lixiang.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v2 of the vmcore size optimization series.

The original v1 [1] contains two parts of work:
 - Bug fixes and small cleanups about reserved memory.
 - A vmcore size optimization that excludes reserved memory out of
   vmcore.

For the convenience of review, I have split it into two independent
patchsets. This patchset focuses on the vmcore size optimization.

Motivation
==========

On SoCs that carve out large firmware-owned reserved memory (GPU
firmware, DSP, modem, camera ISP, NPU, ...), kdump currently dumps
those carveouts as part of system RAM even though their contents are
firmware state that is not useful for kernel crash analysis.

This series excludes /reserved-memory regions from vmcore by default,
and also for /memreserve/ firmware regions. The corresponding kdump
time has decreased, and the vmcore size has become smaller.

v1 --> v2:
1. v1 added an opt-out DT property ('linux,no-dump'). Per Rob's
   feedback [2], v2 drop that property and exclude reserve memory
   by default.
2. Split some prepared patches from the original patches.
3. Address coding-style comments on patch 5 from Rob.

[1] https://lore.kernel.org/lkml/20260429065831.1510858-1-chenwandun@lixiang.com/
[2] https://lore.kernel.org/lkml/20260506144542.GA2072596-robh@kernel.org/

Wandun Chen (8):
  of: reserved_mem: handle NULL name in of_reserved_mem_lookup()
  kexec/crash: provide crash_exclude_mem_range() stub when
    CONFIG_CRASH_DUMP=n
  of: reserved_mem: add dumpable flag to opt-in vmcore
  of: reserved_mem: save /memreserve/ entries into the reserved_mem
    array
  of: reserved_mem: add kdump helpers to exclude non-dumpable regions
  arm64: kdump: exclude non-dumpable reserved memory regions from vmcore
  riscv: kdump: exclude non-dumpable reserved memory regions from vmcore
  loongarch: kdump: exclude non-dumpable reserved memory regions from
    vmcore

 arch/arm64/kernel/machine_kexec_file.c     |  6 ++
 arch/loongarch/kernel/machine_kexec_file.c |  6 ++
 arch/riscv/kernel/machine_kexec_file.c     |  4 +
 drivers/of/fdt.c                           |  5 ++
 drivers/of/of_private.h                    |  2 +
 drivers/of/of_reserved_mem.c               | 92 +++++++++++++++++++++-
 include/linux/crash_core.h                 |  6 ++
 include/linux/of_reserved_mem.h            | 15 ++++
 kernel/dma/contiguous.c                    |  1 +
 9 files changed, 136 insertions(+), 1 deletion(-)

-- 
2.43.0

