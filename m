Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C792FE066
	for <iommu@lists.linux.dev>; Thu, 30 Apr 2026 15:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777563667; cv=none; b=tgVi93XH+FSGHwnXGufAuc4r6LFhoD1uRussmjgVhQxd1looXaadgM+fkxc15eoGsZAxNDcZ6MiP5+IBaNXpmN536QJLQjcPWHbVG2lfTHyUrp8AZNpdRVH/KgLlYAq1sFy0FE4IL8uPIq+jRvY6qbvZlt4fne8LLxidjA7FgYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777563667; c=relaxed/simple;
	bh=PiAnSonjJaWq5CiJY8X7CDckO8G53n6I27AbF9/GGe8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IkSrBpnU0/nuNITAICBChwfN9RITqf3HxoL35vagE06X7dt1rGUSgRXcZX/o3AqjOQWWKAxQ0QvHVKCHqCH3gYIrvq+GrGXm2iCEcvXOg0UdlVqa49kxXsLBwyrNFQGkjTU7mt6ytZsRcPqBfvg3wI55cHmQ9ioLYE1KQI8/56Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRV7ru0y; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRV7ru0y"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso6456955e9.3
        for <iommu@lists.linux.dev>; Thu, 30 Apr 2026 08:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777563664; x=1778168464; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f73giKg+NEaLkYLxy751gAAtXossjimz4mkZpQ+VXmM=;
        b=eRV7ru0yiQN1Xsqo9INW/8vy3OTNB/O0+GAXv0F0M77m3X2k/VNuhjmYvxomrpi6WK
         8jF6oyRaM9L2MM97i7umG8CiYFLe+g4vk7vwLgTOU1rJQm35A1mQOfQ4D9DbYhfXRGZS
         v5bkLrWtNL5TflRuJRdxY/HZUYEfNEN66PxrwyTwQ6Vol5okBjh9jF70qlnvtB2d3389
         zlzNMgTfLw9GPMObowNQjxM+9+Uf2xKA9GQTKEew1UQje+IZ+dmOOTvHMEAQ45QQe33G
         RsRovKBkFY6ANBV1+Gkh4pFcqZ6ljgu4SETbtS6v7taah/Mt/v5bySwzrShu1kv/I1Yu
         ueSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777563664; x=1778168464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f73giKg+NEaLkYLxy751gAAtXossjimz4mkZpQ+VXmM=;
        b=HzXX2oTjb6RJKX2MWrh5VVdpbpV3CjSnMIbC0FUh1+WnkcOx0f1vDimSslNcZvYt9H
         4i6297d9FQApgS0Yufgvw+Cn7NCT8b+TkQBUxxAYU3iHxcilENFAGDZdP4ZxAWpplp05
         FkPTctJwf45LjEX8K1gqrtxsgDQjQ/lUWytgNMaaf+hdTp+ldu6bu0KCdUbACLsgGmwL
         nhNuWnRo1F0uQ2P5OjdWFc9M9n1BJFn0ZGh+xLaHmd8C/YpUeVFuI96pAIf8oA8AnXik
         P8WpqW3pqjRKXtZFohpk/nmxP7wal3B4WThAZLcjIIMmYQ+ocjAfmRk/K0AMNEY6p0oU
         5miw==
X-Forwarded-Encrypted: i=1; AFNElJ+J3PAL/7N42xld9wviv4q0q9OfhUtTw4EBJie757Zxk4atikxOyQCaGPM5zI1b+M2XHICTEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGcKkV7xCCaNtXIcc1ptRRf+Suul7DHOCuPv0WDO1QSjBQWZZk
	AuvXZqnCZCWympcvxg16UlBbvfgMIVD497hieNsQyJuKromF+iIzESah
X-Gm-Gg: AeBDieusbgRxRK75D1c08SQJwYfQmWcspD/aZsyq1VpFfE3taiFsqJNenkY+hjOc4WO
	KhO5KP4FrjsGK7I1PW4yol8fuPRezNKjWM9Mf88LBDcUwgOZvUYIV3nSUl8nV1LsaBzg7j5dBU2
	RDn/80WLFTZrq6HNeCUs0LniCWWa8A5ifmS8MmRtEvQVHmpoofhxxbWZ1NjX65mV/S4EOonjvrT
	0xPKPpgK65/83schoLUw+WS+cOUu/5BMILfk6sfYeDaVIInnrGz+0NfdrFV6TZQlO/tYMyapNla
	t4gXkvtkO3oTm62+6FOb5Wk/OvSo8pVuxkez5Y2Yw31t2MF1XdGOoHBHuevaRxiS0wzRwrODccA
	Km9sDQMaoJV4mAzKfO5sGgj70J4w+Gce/tQblD/Ct7LnrrRrZYKdM9A8pFqLPMmPZSs4YlVnOg0
	KQk3Abpc74ekZRyG5a4KlwCgz8pcf58XainLaO/E/in6F0+xgwentPQPWiZERS6Mz1zhn+wZxkN
	9A5mRwNs2sjWAQu1M4gMu27qDsaRBgazx+bFQ==
X-Received: by 2002:a05:600c:1387:b0:485:3f30:6250 with SMTP id 5b1f17b1804b1-48a84459c6bmr60002635e9.20.1777563663680;
        Thu, 30 Apr 2026 08:41:03 -0700 (PDT)
Received: from localhost.localdomain ([2a00:a041:e04f:2600:a0c9:1d35:8283:f96b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a820c71c8sm118472015e9.4.2026.04.30.08.41.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Apr 2026 08:41:03 -0700 (PDT)
From: "SnailSploit | Kai Aizen" <kai.aizen.dev@gmail.com>
X-Google-Original-From: SnailSploit | Kai Aizen <95986478+SnailSploit@users.noreply.github.com>
To: jgg@nvidia.com
Cc: kevin.tian@intel.com,
	nicolinc@nvidia.com,
	will@kernel.org,
	robin.murphy@arm.com,
	joro@8bytes.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	"SnailSploit | Kai Aizen" <95986478+SnailSploit@users.noreply.github.com>
Subject: [PATCH] iommufd: Use sizeof(*hdr) instead of sizeof(hdr) in veventq read
Date: Thu, 30 Apr 2026 18:41:00 +0300
Message-ID: <20260430154100.61604-1-95986478+SnailSploit@users.noreply.github.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "SnailSploit | Kai Aizen" <95986478+SnailSploit@users.noreply.github.com>

The bound-check in iommufd_veventq_fops_read() for the normal vEVENT
path uses sizeof(hdr) where the surrounding code uses sizeof(*hdr):

	if (!vevent_for_lost_events_header(cur) &&
	    sizeof(hdr) + cur->data_len > count - done) {

hdr is declared as struct iommufd_vevent_header *, so sizeof(hdr)
evaluates to the size of the pointer.  Surrounding code uses
sizeof(*hdr) consistently:

	if (done >= count || sizeof(*hdr) > count - done) {
	...
	if (copy_to_user(buf + done, hdr, sizeof(*hdr))) {
	...
	done += sizeof(*hdr);

struct iommufd_vevent_header is currently 8 bytes (two __u32 fields,
flags and sequence), so on 64-bit (sizeof(void *) == 8) the two
expressions happen to be equal and the check works as intended.

On 32-bit (sizeof(void *) == 4) the check under-counts the header by
4 bytes: a vEVENT whose data_len causes 8 + cur->data_len to exceed
count - done while 4 + cur->data_len does not will pass the check,
then the loop will copy_to_user 8 bytes of header followed by data_len
bytes of payload, writing past the user-supplied buffer.

It is also a latent bug for any future expansion of struct
iommufd_vevent_header beyond sizeof(void *) on 64-bit; the check
should not depend on the type happening to match the host pointer
width.

Use sizeof(*hdr) to match the rest of the function and the actual
amount that will be copied.

Fixes: e36ba5ab808e ("iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC")
Cc: stable@vger.kernel.org
Signed-off-by: SnailSploit | Kai Aizen <95986478+SnailSploit@users.noreply.github.com>
---
 drivers/iommu/iommufd/eventq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
index 710eef0b6..78689fb52 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -321,7 +321,7 @@ static ssize_t iommufd_veventq_fops_read(struct file *filep, char __user *buf,
 
 		/* If being a normal vEVENT, validate against the full size */
 		if (!vevent_for_lost_events_header(cur) &&
-		    sizeof(hdr) + cur->data_len > count - done) {
+		    sizeof(*hdr) + cur->data_len > count - done) {
 			iommufd_veventq_deliver_restore(veventq, cur);
 			break;
 		}
-- 
2.43.0

