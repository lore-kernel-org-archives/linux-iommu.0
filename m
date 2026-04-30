Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A0D477E3F
	for <iommu@lists.linux.dev>; Thu, 30 Apr 2026 17:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777571802; cv=none; b=MB/hvrlGBwSVnyWAbVYetGo+vCTWlIhyNeZF2c5lJZjqeOTkmI+DZ4Sz3rRtXFrpQNzrVn9+ByJt4FRB2jDeZCFo5toLRn6QlgTYaNeukHBq+tIdaTQ7GfE9Ewz5bNnAoIynVcFxdUdfX74XAjb1zOyndY+gj4Jh4k1wkh1Ya1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777571802; c=relaxed/simple;
	bh=PgyIGO4QsM4KV1Du4VlHXHzQFCBNwgKqEe/8D4lHGK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pGovPQ8szuXH2lFwkSkwxLxy4jNZ4po/pV0mcxZ0awiTdzw4xudJMUs3DqglkhI3k7OajRVYjtp0EzDgred8GDc7qofOGDmwVb7GM1LtOA/1dkqIGT59ptf+5kkrERPqn22hPt/tRg7s5dm49kTzG3n7xnD/Et/bsSbiOVy1eZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQaNtswG; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQaNtswG"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4891b0786beso8460795e9.1
        for <iommu@lists.linux.dev>; Thu, 30 Apr 2026 10:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777571799; x=1778176599; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZnlNVGtRIcLKS9B1pTP87NWhA3Tq2w3mutdZXirEiQ=;
        b=kQaNtswGW1HNd3KUcTm+4FeldYkknK+L0dIi7TzssCLJi8MvgatTlDhWrJKtYrLHTM
         dYr/oq2dyGZ5gE5JCC7WfyCZtRN608b02SR7zWpetM8IyGUdE6+TAXLMNJjcuqM2dunY
         AsswrKhlLA0ZXNc0J7FK/QKvSSJMLKs6Ru0ahrhHW3Gltf11HLWQomK1TmWtcqM2Mx5p
         d4mhlWgfGsCNL4U3WesFowsIUS7GhkWhvvmMtC1TzlFHMAdRgUkmtbuEqwsaK7v6TwWx
         UIyBkU9ZOKnWmcidPIHbp+8C+SQkKPJqPhyNjkp88C8IUBb0yWfAXAUu1fBbXBzpTyT8
         0euQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777571799; x=1778176599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZnlNVGtRIcLKS9B1pTP87NWhA3Tq2w3mutdZXirEiQ=;
        b=ObfX5TCxRw2VnH6fUbcu20QGU17igImLRCjHTxNR5MsK3Vh7Vf2JLFiZFymFx9jwgL
         rElFvX5PbgpOrGXCI+EX+zJ0nOvOwgW+UNn0jpcaiJ+IP2kJhMMIkJIEgQd/1gkLujLQ
         gySWSgueIh1gTJS8hL0Nr3QW1DxgstmWaO3OCjBn/kgEPTB8ZcdTh9vyUb5Bc37Tklv0
         kAtvveUvDoGGMelUj0lHwogzX1X9LCaO3w4HH0AMCjwYiBOsC0j/rJAhnuIqYNNjFMws
         cnNpgmdD0+VZSIF5ZMfQ8INDxG3DCBJfeXuAXRk/iEMCeGPXHlMGQMC/EzIobQy0RmIH
         OOZA==
X-Forwarded-Encrypted: i=1; AFNElJ/tUtswGVNmbF341+RtRkQk1TGSK+/zq2LVMg+KkruPuV9E8PWfQ67+CEklqEG6NA210NpNQw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyITvJsawIrW/oYkoRhshaplX1gpEZVFv/DVyfJelvRC/Llj4xl
	4MIG+fKq/gM3mQE9Bi13S8rXNQW6bPL7URlgGK0DbwGRbRF90L/0C8F1
X-Gm-Gg: AeBDiesIeWGDeQChJjqSHbTl9ix7VeXy3hxK4rAPCxsk9IpWjSdyyGxwUMrUbht0n1C
	C+LskW62c4OWwVi5uhthNooPGKJnxgKVN9/doG1hB4hI2lSjqLDiBfPGYrPe1ntwQ42dh9QxK5c
	uFZHyYOIM1u0p3CXYBJq7fJe6vClx3fd/m/jqgr9x9VX5yVeSTX5RDGcLsptmyX5V1re4Y0v+2+
	YzbEzKUNs0BrtOEbbSf4puqiEujUhG1FDfGsvo/7zE58aX91OYPQUOyG55WXKkxrxHv+PFaSSr6
	kEhYTIF+n9egiz+OgEU963ICyNyrSTzxhsMmsisG7T/Tq409oa2fZtv8yN71+8n+0xN1M6MFIh+
	cF4uIqASJZyjp4K/18umB6bhj8Wit5NlgWFN2O8ryjHLv08D48J6gEV4+kLDfdkYEuSFZFgx7I5
	UrCaYPJT5JT+38iBoy2WhEcQaECLrvNnN+f8OYiCi4XpFha4ey0GBghdcyYalVxLa0yRYdNIX4w
	mOMUUb5HV2tRQuiuNdDr4uOIdadlOKZuwC4krTBAwk3F3f6
X-Received: by 2002:a05:600c:8b35:b0:485:4388:3492 with SMTP id 5b1f17b1804b1-48a84452dc3mr64100315e9.11.1777571798476;
        Thu, 30 Apr 2026 10:56:38 -0700 (PDT)
Received: from localhost.localdomain ([2a00:a041:e04f:2600:a0c9:1d35:8283:f96b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8d17269csm1143095e9.3.2026.04.30.10.56.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Apr 2026 10:56:38 -0700 (PDT)
From: Kai Aizen <kai.aizen.dev@gmail.com>
To: jgg@nvidia.com
Cc: kevin.tian@intel.com,
	nicolinc@nvidia.com,
	will@kernel.org,
	robin.murphy@arm.com,
	joro@8bytes.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Kai Aizen <kai.aizen.dev@gmail.com>
Subject: [PATCH v2] iommufd: Use sizeof(*hdr) instead of sizeof(hdr) in veventq read
Date: Thu, 30 Apr 2026 20:56:30 +0300
Message-ID: <20260430175630.67078-1-kai.aizen.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Reported-by: Kai Aizen <kai.aizen.dev@gmail.com>
Signed-off-by: Kai Aizen <kai.aizen.dev@gmail.com>
---
v2: fix From/Signed-off-by to use real name and email address.
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

