Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAEC27CCE4
	for <iommu@lists.linux.dev>; Tue,  1 Jul 2025 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751389922; cv=none; b=ULXMbZw1iQaFwEqsG86hUYcQfE+H+3W/B/MWuLsaMNIM2oIqVAfTgdjH1HSHJPAPDQYGDpVys0X3brS13Vs7+qccfvUDlpMn/f5GmYdLIw6WeBSCt2XTsNra4rCJgCF0Xa8KQ8VE+DrWpIOA7DSor+8FMrIQx+K3xTS+rEVWuX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751389922; c=relaxed/simple;
	bh=SX2heC/Qk6afxGMZKjrW09kyPvYeBI0adPXbi3Fnvpc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=k97T/jy/5F/JshydD/74Ikfm3BqxDkKO+zceuj5IrPwl/UJaqW5zGsXgQfMpF2Irgp9WGNmUIER9tbo6j4SfTKIqYfHC43I2nexB9loOv/K3vt1ojYb76NW8ZpKV1TUwSSV4Ia2t9x+hBHqnUsN0j0h1DQcMJgTwYyhyaeGFoik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=V112o1VV; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="V112o1VV"
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 003663F718
	for <iommu@lists.linux.dev>; Tue,  1 Jul 2025 17:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751389919;
	bh=sU2Tqd6bdvzOLtqB6osCLzx8U1+d3a8Z2ezfvd4F1oM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=V112o1VV2QxMLTvcTGpeF/WYRTKUJkMo5a/+qa4o3v9f6RqdsSEtqNtErNMvfRnNC
	 b/msaHiZdTukqAshsKHKbvFmZZAbycV+T9sRWit1X55rRisAJUBXmgWD0uBgMZwt4L
	 i84Rt7gR6Gafbw/MPa8YuHkDrw6wpn3ZJjWT4M08QoCx98WtOKscVCx0R+K+DXdVTg
	 0CyLd5gEAIWxLz6HLjT2Zd/zrr94qLjeURt7pf1BFOCXbpvI1ilpBtnozbLkqGnbtx
	 QL8tFmbW9E/jZgoebywGyppgGsQPiXfDrBWMFseZiz90NO7XaAYPI9UQZmnYPgyDLE
	 OBpn5+y5QnQrQ==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-60c776678edso5783974a12.1
        for <iommu@lists.linux.dev>; Tue, 01 Jul 2025 10:11:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751389918; x=1751994718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sU2Tqd6bdvzOLtqB6osCLzx8U1+d3a8Z2ezfvd4F1oM=;
        b=LjmLMXx/uLmRm+jkoRT3rv9LGvHajJDKUyURlAjlW6RNUFxMQjk7voEkScASXeotOz
         r0vmJIZ5wc6mHQ1tQATKH595cMqsVRpdFT1+RJP63HnZDgZnaqo+bkr/R6JUryQfsStA
         nqJ1SG39Hew9SFuT2KaikrRaKS1W/l/jMk0QKI21GRLvsHYEnlbzmpuhzry/uZsZ8wCp
         NvSxp5mcof0ibAecP3cdj7IWFpMQgKyWolCutnahX+1x3cqd7SQqGam1rPyxQlmHHGMb
         tN5hGK32PPPqZNV9KVPhbcl19aVwJS/EjJjlOfffO756zZmXdIGHdVHZAGJCLQgNRNIB
         VGDw==
X-Forwarded-Encrypted: i=1; AJvYcCWKANfc/LcnJyQlC8QAqsK57oCKgDOFMopeDnbEvrQBVWlyRZFhiOqthl9kz/duKx7SELpN8Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzYCfDVgezcGqaJUQ/AB/v2CwJqUcKCDT9i13ElblGPriszTeho
	n5dQfXuwdJk1Af6AyAi+xUA5ZgWgo5nSSkjR0pi/nLLAcyipg0yeS3pmVJqWYwR/TY2x5v2UgmY
	AB4q00Cxo7KyrrDU3WWVCHB4y+GiiGykGC/zRHzcA78bKxAoHeoFeUm8NSOpaNOvJRSViPeWc+S
	ejkMal74k=
X-Gm-Gg: ASbGncsGl0rPOZSnJnN88b18Tmvr0q6p8otbxmWeBMefHYLJ2q5RF8Pt4NS038Cr6H9
	beloX5uSu5VLDRbllpJiISJy/1eceqX/T3CG1KeKNB/KZ6EFOSkaGYLPL339iuqI3bpPD8tJC8Q
	xwr/nWeG+QRTjeNqOnPHpKsBhEfCz44zbTf8nPuNT6KhxYNwYLZHuDg5xSTISgCCxbbHZAmL8Ok
	1TTq8ZggKm4J0qC9VIytWJREN9U0GTXBw/6iHSVZGf3LQNpQA6Xi1kGpoC3IC2BaxXupqlMQmyf
	AzPOruyeCd3gE5Sh3B8z2vX8yciKxxJtHEvGuMMaIkwL6bGZtbru5UzRV7eIjGEV
X-Received: by 2002:a50:ed87:0:b0:608:40bf:caed with SMTP id 4fb4d7f45d1cf-60e3a8f3b4cmr2512624a12.7.1751389917970;
        Tue, 01 Jul 2025 10:11:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEu8J6lVnS+AjHzqRmWb7aXWSa8lc+z3NV7ufWDiI84tWqPRb7bwIpffBsf/O52QDBXHBTQ1w==
X-Received: by 2002:a50:ed87:0:b0:608:40bf:caed with SMTP id 4fb4d7f45d1cf-60e3a8f3b4cmr2512601a12.7.1751389917513;
        Tue, 01 Jul 2025 10:11:57 -0700 (PDT)
Received: from t14s.. (adsl-6.109.242.31.tellas.gr. [109.242.31.6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c828bbea9sm7818156a12.1.2025.07.01.10.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 10:11:57 -0700 (PDT)
From: Ioanna Alifieraki <ioanna-maria.alifieraki@canonical.com>
To: baolu.lu@linux.intel.com,
	kevin.tian@intel.com,
	jroedel@suse.de,
	robin.murphy@arm.com,
	will@kernel.org,
	joro@8bytes.org,
	dwmw2@infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: [REGRESSION][BISECTED] Performance Regression in IOMMU/VT-d Since Kernel 6.10
Date: Tue,  1 Jul 2025 20:11:54 +0300
Message-Id: <20250701171154.52435-1-ioanna-maria.alifieraki@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#regzbot introduced: 129dab6e1286

Hello everyone,

We've identified a performance regression that starts with linux
kernel 6.10 and persists through 6.16(tested at commit e540341508ce).
Bisection pointed to commit:
129dab6e1286 ("iommu/vt-d: Use cache_tag_flush_range_np() in iotlb_sync_map").

The issue occurs when running fio against two NVMe devices located
under the same PCIe bridge (dual-port NVMe configuration). Performance
drops compared to configurations where the devices are on different
bridges.

Observed Performance:
- Before the commit: ~6150 MiB/s, regardless of NVMe device placement.
- After the commit:
  -- Same PCIe bridge: ~4985 MiB/s
  -- Different PCIe bridges: ~6150 MiB/s


Currently we can only reproduce the issue on a Z3 metal instance on
gcp. I suspect the issue can be reproducible if you have a dual port
nvme on any machine.
At [1] there's a more detailed description of the issue and details
on the reproducer. 

Could you please advise on the appropriate path forward to mitigate or
address this regression?

Thanks,
Jo

[1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2115738
