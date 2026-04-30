Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E61C2FD1D0
	for <iommu@lists.linux.dev>; Thu, 30 Apr 2026 15:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777562827; cv=none; b=cAC+8W6/EE2CZBY+6WQRW9YiO3KNujUcwtO/1kRRwzsVI9uugmkmitrJUdMB/RsN+4KWwzhTLqdgSFyzgIl6pglJnIEF+ifyoH82rHrYZT3+oFDitanGOCSCP4spCzqN1lLnxxEY6VkPIOVxLH2yzigPyPXQe9nM1y8YgsToC3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777562827; c=relaxed/simple;
	bh=PiAnSonjJaWq5CiJY8X7CDckO8G53n6I27AbF9/GGe8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jju/pyueQ/e5fr8ExXlNQX14fwvR/9JvuM+t6edOohMYRugYvuvpW+LOLSX0WV8GRBxh7H8z/7TWMqzTwa10tVljxo1WNsSwMaMdMFV6/Vdbw+WJKoTxV0hz+FhyRNtcNvtJ/3jCjl4Ncf55XXJ21XBd+frpKUi78GKY+LZ7Wcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LR8VjLZ8; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LR8VjLZ8"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-483487335c2so12162605e9.2
        for <iommu@lists.linux.dev>; Thu, 30 Apr 2026 08:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777562821; x=1778167621; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f73giKg+NEaLkYLxy751gAAtXossjimz4mkZpQ+VXmM=;
        b=LR8VjLZ8cASlsqVIUcjWAi9Va7qm0jZwFZnzxV/TacLZ9d242VZA8iSSsBIokmRfHQ
         3ApKp+q/Vuh+7QU0uW7vO+3d5BneQYDpSCoODqZjkbjNvaYwX+/j+oRoy++4eOBWU2o6
         tK+AvyiH3b3BIIlNFDDSVbXXHOmNc3f9lEW/8JRoMqg0LGuBZ7dSSM02T88h1LMrWs3M
         Cy7Lzb9V0l1S8zCokcVVMFC2OX7dlrr0DAy21OVLTVao+PCKtN/TdrXPLbNOK3BmlA41
         AMGkArKIq+DPE6z5u+hIdZ9W2vwLHtVGr7WDJQZtNZJKcjYWKQwKdjid12KfJDljYBjM
         hM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777562821; x=1778167621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f73giKg+NEaLkYLxy751gAAtXossjimz4mkZpQ+VXmM=;
        b=R4ilZLbQmU9OMFBUwuxHqTuzLj+oP1w+A5iqsbvO25L0ph7yd1yGHPLyflCpd9LPj2
         0R6XcUtRupxX1EDVXRDJfbUhurGbcA03C6KvzlYoBQORpYSmvWBzF6JEj8MjhNhce0Il
         W8i8pkJ+wR4WfxM7KF1cKsH/t7fByYkFDFFMuE3Q14alxVfOcbJ+aKWbU/jO9l9XwCzV
         cERtZyu7qAyIb9kjvtJL+YSV/+qU/9v0l9nYbQsgl7MRPc90z/cWh+DU2qHOx6qduVn1
         3ajCDhlrSOF6Ydq5GyX5LdpfjFDAot7oAhp07bmPwUSu5qTHJ1dhcX8OvA/O8XlHXAPr
         tkYA==
X-Forwarded-Encrypted: i=1; AFNElJ9PnAgJcVdwI6XFspL8cQentDDu7Y85chNH3oARqHIWy5Xo05yrBdPsXSIDqLvI3WufyOqmrg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxtiY0ZWnVPCM87IRs9VmqtS3EQ2uG5SXiUh70VOEm3rl5h3Yju
	AcN1J7P5Tr//UOioryRE6Phg79DozCFoeFwKSXWk8GN6k20A0qODTVO9
X-Gm-Gg: AeBDiesBBynmHIu53+OwqJMNWKwNyJPpOv04mP1/oZ5hPElaDhdnBzoy0tupBLz8oAj
	yl+VnedIt/Qi2iuqa5xgucqLzSTyJ87eWZjoHWOgtbissYrWz78k10dpq8pPGO9S0Su65ZLU1HG
	s/0uDHkF30SRY023sUlSJ6SarhSFS1Pop2tLyFlq4kvgXwtvAntiPinc4e72yRhkcEzTOhk2E24
	C+cLrHgwbs8lyF1eR8dWuZaNEXwpn2d9PWnzf0NQHeMY9BDr0D92G/k6Cf/rGBs2hF1WLKnswL+
	uBIxJow5dYDxo1anJkOYDV1msWBu0g8PkrZ6gBjZJqcetk79gg+VMwOBsaIXHzSyXGCJ5mS/zYo
	rWRzBwz0S46YK1GgwdCAKzbWXBLdiosck/wYl+acKdYlXmwu193eQJu9dYmlIO+cetMZUVG+Nra
	/CKDWKBnICOHfIHWfafUj4NfTuCFUGSfimvt36z3ZisnyqOf0gwQ6Us1n3Vge34Y8iteBxhytkM
	5kGYuh44NSB7Wo38K2OMKbHHFrqI5TnNXTrCw==
X-Received: by 2002:a05:600c:34c9:b0:48a:5565:ec3d with SMTP id 5b1f17b1804b1-48a845291femr61472765e9.22.1777562820856;
        Thu, 30 Apr 2026 08:27:00 -0700 (PDT)
Received: from localhost.localdomain ([2a00:a041:e04f:2600:a0c9:1d35:8283:f96b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a824f9f0dsm68616475e9.15.2026.04.30.08.26.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Apr 2026 08:27:00 -0700 (PDT)
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
Date: Thu, 30 Apr 2026 18:26:58 +0300
Message-ID: <20260430152658.60745-1-95986478+SnailSploit@users.noreply.github.com>
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

