Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [178.154.239.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4A531A572
	for <iommu@lists.linux.dev>; Wed, 24 Jun 2026 07:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782285103; cv=none; b=R41PYeCxLbT229a51CE3sEztdMIcCuMgeQtey8gSvR43oHBp6fBbzexU+/x60wwioZb7kJkWbQ134g3aFs4fzo1l5xk3MUUV+MIHINolVMI0QyiwMdvCY3TcFYxM+kHDyCqmTe+JcE5oo7WTHy/Mn9AmqlWtO/5EOrmxSC2Klfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782285103; c=relaxed/simple;
	bh=5nJ8TkO4BdnfINiFuUTCqJlldFQEQ/IVziLqa6Z1kEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yq0fAJ3Oh/H2q81Q/ZCbj1+RrpZpRGHVU5vR5Mdg7h45uqV01B8ys4xzKkNB7vovfmamVK5OExc8CiZ6Tl0IwcHNSVt4XQc58+6zU3661+P84sXXjT9SPMJvc4+txhVZlVIbkvlhXH0m3934bWD+0Qk/fnzpK5N9U4WmcKAlkGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=OJz79ybS; arc=none smtp.client-ip=178.154.239.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="OJz79ybS"
Received: from mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:340d:0:640:ad51:0])
	by forward100a.mail.yandex.net (Yandex) with ESMTPS id 39144C0754;
	Wed, 24 Jun 2026 10:11:32 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net (smtp) with ESMTPSA id JBSaQRJgJ8c0-1F7gwUKA;
	Wed, 24 Jun 2026 10:11:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1782285091; bh=LuZFBZxLg3E6lGM+psPqd+R/jFP24YGj7RALW9XYQoA=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=OJz79ybSiCtPWf3Ua3C+IrWZLIBB68GAeLDZ0M2i2cmm2EBe54Jnl5NQpT8b3PUQV
	 n4J1/LkruEw0D9Id5yNKhJ6EGfYrCiB2TZ8ifXQNYYpmOSQsUKW+wFIY236PV5yz3N
	 rpyfwJmQmzaR5Z/5tIXJHKqFHONJwT8a9oGgW5Ls=
Authentication-Results: mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] iommu/vt-d: use kstrtoint_from_user() in dmar_perf_latency_write()
Date: Wed, 24 Jun 2026 10:08:19 +0300
Message-ID: <20260624070819.773161-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify 'dmar_perf_latency_write()' by using the convenient
'kstrtoint_from_user()'.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/iommu/intel/debugfs.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index 21e4e465ca58..d87408ebb830 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -690,19 +690,11 @@ static ssize_t dmar_perf_latency_write(struct file *filp,
 {
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu;
-	int counting;
-	char buf[64];
+	int ret, counting;
 
-	if (cnt > 63)
-		cnt = 63;
-
-	if (copy_from_user(&buf, ubuf, cnt))
-		return -EFAULT;
-
-	buf[cnt] = 0;
-
-	if (kstrtoint(buf, 0, &counting))
-		return -EINVAL;
+	ret = kstrtoint_from_user(ubuf, cnt, 0, &counting);
+	if (ret)
+		return ret;
 
 	switch (counting) {
 	case 0:
-- 
2.54.0

