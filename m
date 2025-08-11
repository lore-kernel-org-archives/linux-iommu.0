Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C7719DF5F;
	Mon, 11 Aug 2025 13:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920281; cv=none; b=tL02H/A4SAOQhrwtWXp4G+pkyHKGtqDGB32roIf6wUhP1mOSHetaAOgovXHA9Oj3GS+bViQMSRbEgzHNN+5vko7XltWJlOD2D52UPnPB+whbntdKv39juXRTJOCb4anTq588KDnFWd0wQY/6Tec7EHge2MaFdXXtsDuJhU5bYT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920281; c=relaxed/simple;
	bh=Oq5GQuC/JNsViijmu3PLBEoA7oCG3f8Cu1LxMk/jNbo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Fh6F2ltG+0b65hCeCGOZydin3s1gOQYRBrj+APABEVfnXw3/XE5hIp7TWqLVanySE64g5lUhK1cpFHuzo4BGbZbRcGTntTuadZbhAVw/WCMvFCvfxA/NQ57lr9/zLses+zNo2p7WyqlsdaTnzt9vLl5IJlWklVFw7a27opt5q1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVO/0L+0; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVO/0L+0"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76bd2b11f80so3872138b3a.3;
        Mon, 11 Aug 2025 06:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920279; x=1755525079; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nklRgqEsHAGsTa1ZY+Tu1pfGAj2pLA2XYPvzJl54xAU=;
        b=QVO/0L+0cxL3yvGUhegIhp+rqNc9TK41AK/cgi9SCpEj1aCgNxUPh3uPWLYmpZl+WM
         SNh0ZxvRDE9EUsetiqVnBIueTUpnQvemfCgaAmVdodK3u42EajWGo8tABXbrrbX+tK6v
         W31K8ArLn+c4xTz0CDG+fRVTRY+ndi+LOERxMjkyGVzsyVG7Iv7355LiiOQX2Tn7bavy
         AlsGVJCDFwcJbNX8BWGYNfxK2l2zoRuGtj9t8HTqB9mRlXoeANiM53cTsczuqcNdP04W
         ZvwJNzRXK/buw48fLemqeLjYlfWBo0XMvKZwTEmSkpPaNf7nSkb363zXEk1F3TsDE3yi
         H61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920279; x=1755525079;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nklRgqEsHAGsTa1ZY+Tu1pfGAj2pLA2XYPvzJl54xAU=;
        b=GWJJglY0jedI+oL2TZtpdRkYgH3ZJGD/abqKfO3mTEL4LkS4q9Ri+WD/acij2L9eSb
         Yqkvi+4l2VDBOJD1PxakypuHZJ+jTh+8IsDs7ixFcmvlrGCDmPGH9X4eHZpC0xr7PSSr
         lbp/uBs2dkmjLdnlHotQRAMSRhhvpVnUBgResj9PQGphFMV8vfpmNGb4iCO3XWyWXJZA
         30gLjJ4fIvZMKrOpCDqay+4PLOKMEp8BuJ7f1SeacdkXkxQuRI52m6yDCvESZqERSrzj
         bzrOraVMJIoRQZUH0jZYdY0nC48VPgTjc583fN+6Wj63msS+VqNpa0ASeMEt5m6Tv24c
         +I0w==
X-Forwarded-Encrypted: i=1; AJvYcCVko+BEreFGRSY8lQQhv0qRuO5Umiw0W1bDvOK9YcoxQdCewifTyxHsXLch2qxMsAXjN4eU7A==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywp6Ov2yW5gwzxHByqyNhJcznhARExsADtysY/EhtqSNi7vLjup
	uh3BkhsWaARCAOvX8K3eDJXARM2OJyKjWN3EGUIDaAOMQ4UJHNK90vy1
X-Gm-Gg: ASbGncsvgz7mJzz0n6xfIg8YZUu/Ju0NLddf8FPFnKRgyKflDVKXhwm37kOXHEkto3Y
	od3TyDgurMzt+NKq5bVhX/o+fpoSo6TWIhXFOC4XMDbHtEuJHsrczAg2uK4PQjl7zqa/11+QToe
	dMiB9FzehOSh5u5Fj7TAtadpnETq3J0JEa/RbfRrn09/cYpdWW8nX+n46QG0Z9jUUDk8TVdrgze
	i0djkZdYMaPGT6eSuOgnXTADkLlOmgkcYJTWUqfn9Qkes/U8US3cwsIAn85I5D5V5G7Vya6Hrf3
	wxUftMjHWM1dl3uAY8CcFuCZ8OqWzQWPpKqeyF2M8BzGVg/Zk0XQ6JxrllhQd64LrWUmLSuSgQr
	YmlBFvqkv0BuLfNWcy80RuguWiGg/a2NZLyMCIjGAzYUxGUM=
X-Google-Smtp-Source: AGHT+IGq94mROq1kQp74KcNsr2aCVZFxAFsqWWVl9F1p61/0vbOTUbqwhFkFA/aTivlG4DM2EdN36w==
X-Received: by 2002:a05:6a20:729b:b0:240:1b99:1595 with SMTP id adf61e73a8af0-2405503b294mr22135196637.17.1754920279511;
        Mon, 11 Aug 2025 06:51:19 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422b7b2700sm23504993a12.15.2025.08.11.06.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:51:19 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH 0/9] Add support ANS2 NVMe on Apple A11
Date: Mon, 11 Aug 2025 21:50:52 +0800
Message-Id: <20250811-t8015-nvme-v1-0-ef9c200e74a7@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADz1mWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCwML3RILA0NT3byy3FRdc+NEk7TklEQj05QUJaCGgqLUtMwKsGHRsbW
 1ANwFyztcAAAA
X-Change-ID: 20250808-t8015-nvme-73a4fcda25dd
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2166; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=Oq5GQuC/JNsViijmu3PLBEoA7oCG3f8Cu1LxMk/jNbo=;
 b=kA0DAAoBAcoIt6bFCCQByyZiAGiZ9UygSJFejRzKvKje7erg2v7F8u8vJytX6bwLURWcvnxWf
 IkCMwQAAQoAHRYhBEtSeHhcl6z3nDxogwHKCLemxQgkBQJomfVMAAoJEAHKCLemxQgk5wUP/3Z+
 IKj6xYJEcai6WXIyhJi7FDyM77bltJK3+PIULBiRtdPo3V8TS7z2nCxFh2D/Om27QtBouxTNhfo
 LZ3JI385XvxrLVy+yrTGJkatN1VQU9Oom7RLzD/pip0MwP98eDlQboPFagc9tg1dHlUt7IuON9/
 /C4vjiAs+1yI+nTTt2p+tbxRE+MSvzjSvJm74RIuHWqYMf9KLb+QFJ56kiwL7P5N1ZpwNyBDoNP
 aYftDDeATWxKvtrhDjTtu86GMny/seIBA7dPAYL2zKcJvIQtm6OmPk9xD/NZylp2zh0SmjpNANA
 TaypNVSb8nihVS+e/c8KKgP9IWkmZOOU3aLXjmANOZtHuMZDH8cFqhMH8Zrh/BcobyKU9YbWqu+
 PlhglO1RC8nNDewJgtl+SHi3l3Rcapf2F1BIDui0QHtuTdEyBCGYscMTU5cuRHmIizl1xvsoj3r
 +qa/SRVfFLyAkJMR1nKzj7esueepkFlFrBy18zYroSKP2npoJuj82i1Xe+4gUpt/3WWdzZ7uG5z
 vjgqILbva16rbaTo/oT4cF1tGc8zlmkhD8KBYVsZVkYhx1ngmh2wgBET6fFTwnG0wTb2B6plO7R
 9TJ9wp4oDLPvERdEW6ohG0GwDfJFpra9woRWnUeQOj4uzZEBknwQVy4KFitG887WtsOBScs3gw+
 OKeg6
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Apple A11 SoC comes with an NVMe controller that is similar to the
NVMe controller in M1, but less customized. Notably, it does not
have NVMMU or Linear SQ.

The controller is wired to an older variant of the SART address filter,
and uses an older variant of ASC mailbox, so add support for them too.

This variant of mailbox is also present on Apple T2 SoC.

This series has everything required to support NVMe on Apple A11 SoC.
However, due to RTKit protocol version support limitation, it will
only work when booted with at least iOS 14 iBoot.

Tested on A11 as well as M1 Pro (to make sure nothing broke).

Patch 1-2 adds support for the older mailbox
Patch 3-5 adds support for the older SART
Patch 6-7 adds support for the NVMe controller found in Apple A11 SoC
Patch 8-9 adds the required device tree nodes.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
Nick Chan (9):
      dt-bindings: mailbox: apple,mailbox: Add ASC mailboxes on Apple A11 and T2
      soc: apple: mailbox: Add Apple A11 and T2 mailbox support
      dt-bindings: iommu: apple,sart: Add Apple A11
      soc: apple: sart: Make allow flags SART version dependent
      soc: apple: sart: Add SARTv0 support
      dt-bindings: nvme: apple,nvme-ans: Add Apple A11
      nvme: apple: Add Apple A11 support
      arm64: dts: apple: t8015: Fix PCIE power domains dependencies
      arm64: dts: apple: t8015: Add NVMe nodes

 .../devicetree/bindings/iommu/apple,sart.yaml      |   1 +
 .../devicetree/bindings/mailbox/apple,mailbox.yaml |   7 +
 .../devicetree/bindings/nvme/apple,nvme-ans.yaml   |  15 +-
 arch/arm64/boot/dts/apple/t8015-pmgr.dtsi          |   1 +
 arch/arm64/boot/dts/apple/t8015.dtsi               |  34 +++
 drivers/nvme/host/apple.c                          | 228 ++++++++++++++-------
 drivers/soc/apple/mailbox.c                        |  19 ++
 drivers/soc/apple/sart.c                           |  60 +++++-
 8 files changed, 282 insertions(+), 83 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250808-t8015-nvme-73a4fcda25dd

Best regards,
-- 
Nick Chan <towinchenmi@gmail.com>

