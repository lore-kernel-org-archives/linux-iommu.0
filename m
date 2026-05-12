Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7193655EC
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 19:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778612595; cv=none; b=cUwe84f4E1rrO0gSw9Hy52u5TcslNR+NW9txbOoeHwDgk3MB3qQnDBcr0MEYoX5p0RF8kCZeBsYgn1caWpSNk62mPMpH0t/wgwWc8fyWfrTO6M5QKC2TQqFNBPBUOnGfxdPIPVMK+d6retefzylrFShErr04+pYkrQg3kdCXn2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778612595; c=relaxed/simple;
	bh=uvFMS/Wl32PAwZ/51GhVZ2aXGYJ7UOXVmsDziu17/t4=;
	h=From:Message-ID:Date:To:CC:Subject; b=TFGeKAlKF4yyozCWIFyJ6V9ScIhf0SS8Jg/dd3xEmFRpgnnIczQZ74G73hos4Day7Kz5uB0gyRp9oDsA7Noce+KJEZIHF3TBqS/UtMMpTJXi5nlCDNiQSVEvMS036W2LheBMoNWJQ1s7RaEIvq8yVIOfSeLmYlBVa9i4FHvWxp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X8bm9m1G; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X8bm9m1G"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778612591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=xwwG6JH2PL7eqhShQsglVQeokcXkqtFymm8/VUhv+o8=;
	b=X8bm9m1GzKeUlozR2gBQo/gcJ30rP+2aVqXEj5ibEbouuVfeyVN7gI5iTXpslFo/7khC4R
	DGtRPje3Y2KUDxAVDAo4UdvynQgbvCAWXcG9vy5CKsfPVkY+7W7kj6Jtwz5th3XlrB5fsp
	dj1OIP3dbfRyh2fIgB1mC2IFNj3g/Ys=
From: Tomasz Jeznach <tomasz.jeznach@linux.dev>
Message-ID: <41c3c83de6e2d8422261b57609425d43@linux.dev>
Date: Tue, 12 May 2026 10:37:44 -0700
To: joro@8bytes.org, iommu@lists.linux.dev
CC: tjeznach@rivosinc.com, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: update Tomasz Jeznach's email address
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Switch from the previous work address to a linux.dev account,
as the work address is no longer actively monitored.

Signed-off-by: Tomasz Jeznach <tomasz.jeznach@linux.dev>
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index b78aa092b4bb..f409ad927143 100644
--- a/.mailmap
+++ b/.mailmap
@@ -856,6 +856,7 @@ Tobias Klauser <tklauser@distanz.ch> <klto@zhaw.ch>
 Tobias Klauser <tklauser@distanz.ch> <tklauser@nuerscht.ch>
 Tobias Klauser <tklauser@distanz.ch> <tklauser@xenon.tklauser.home>
 Todor Tomov <todor.too@gmail.com> <todor.tomov@linaro.org>
+Tomasz Jeznach <tomasz.jeznach@linux.dev> <tjeznach@rivosinc.com>
 Tony Luck <tony.luck@intel.com>
 Trilok Soni <quic_tsoni@quicinc.com> <tsoni@codeaurora.org>
 TripleX Chung <xxx.phy@gmail.com> <triplex@zh-kernel.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index 882214b0e7db..aacab143a697 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22940,7 +22940,7 @@ N:	riscv
 K:	riscv
 
 RISC-V IOMMU
-M:	Tomasz Jeznach <tjeznach@rivosinc.com>
+M:	Tomasz Jeznach <tomasz.jeznach@linux.dev>
 L:	iommu@lists.linux.dev
 L:	linux-riscv@lists.infradead.org
 S:	Maintained
-- 
2.54.0

