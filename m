Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841892D1931
	for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 18:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775845977; cv=pass; b=uqmceyfcHTlex5uLahBJQ6mt/kk7X66Xiq8Gu2Pq+2lBXE7DpKeqqBrHPl4BR2sC+iMkEH21kDTXG2aA0UhOy4FN7EjBUiB6tNnH+YW0lLEsq13Pv1Bz+U2PZzgxk0J5FkG97qkXCGmhSzZI7A5LpCFdTa9Zl/nJ9hWSMiXhSIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775845977; c=relaxed/simple;
	bh=wuYI0RLFVZ45HYeDNdgJJ6D8GwLuqkaCkFsDbEpgJpg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=iKuFGJneZh93s5iu+FV4WhQ3xZ8NhILjynWkOWRBgt/VRg7dmINBfCak6UVlh/I1cHpoi9jwMMLlE/10cEI3c9kW4qqHvQlodrQUf53j5i2sKq7CP5xn4eB5grMp0ZmSvGtCdtBL6vMRJV5wdQF6ofA2Y09obNJEvb2sgjFsWXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=e7crVh6m; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="e7crVh6m"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7986e0553bdso24321457b3.2
        for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 11:32:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775845975; cv=none;
        d=google.com; s=arc-20240605;
        b=ju1BGvxJVvpezKVT210b431cFnt6p5OZFYVBi+Osn7jEUqjU6zD3oCcpHlieQ24KuX
         kT6TntRn89AEkikqqjVs70/FqBBiRiiGQvLY0/oD15Wm5d8R15pfiTAKDEpJUpZpiivg
         GtA1wJk+BAcZXL9GTxJ7gqtE9Zb/knBrKzmd2Yf6DsJx5pIq9ZHleqkbIEQDPtbJHt9y
         jPpg/4IBOpos3jXhlyz+uXoj/SMfpIgfQPRD2/K87pM3m2axq3jJ/IV8iqninMTtYWKg
         vAX3wGpWeYO6U/PB+WC/vIOjGoiNUfYmA15q4q9vnl9+8pRkIjWPnPfLF+Y0WNSL8nI1
         CuxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ja5DFvBssG/HcQK4svdiTesOu+yaQKgasZ8owUN2Nvc=;
        fh=FniPRImiwRlzpulo+QsEFy11X09wDOJlxlduS/ECmqo=;
        b=ReuXxTlVcQ2lk9O9yQi0MlclVXlNanIp0yyK0HmLxsQZx8Iaij6SB9k9mgx7wcujSK
         sWUbG4dxes81RwlspIbd3rc4sT0OcyR75xd369muSUx8z4ZSSD7/KqwWmMBaJvsGYh9C
         wofurxKr+PAykIJ1ZTDJ+UE3QiVs4/8LF9a/vwDL3DXFAGdxc46T8RDeKTW6HKMRrLbU
         jqSDomhQOC/FQlotYUf6UpVxnDdnSti+oTdrjhMsxgdfwYmAeKXXJbv2FnTxTGpU0GKe
         nV4IzFPo7M7UqKGBTpBseT1Oe+qQ6AySX8zBC/RA0hYCmhzk/zzGzkHIQmCePMokCN3W
         wEKQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1775845975; x=1776450775; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ja5DFvBssG/HcQK4svdiTesOu+yaQKgasZ8owUN2Nvc=;
        b=e7crVh6mVOhisnqj63obQGkYGoDCpuTrrdClGhtoTfYNd7BBfoGShYJfkMcy/I3MzB
         OP/mD4N4O+NN2c5xnpIMvAvVw4QYbfS/EYX6aZUcj+k3Am2bPPlWpSe+7sTw6gz1M29y
         Zee21tasOLbKL6Nf+FWn4NEXboS5E4WfHTb7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775845975; x=1776450775;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ja5DFvBssG/HcQK4svdiTesOu+yaQKgasZ8owUN2Nvc=;
        b=H3b7p0ZSxBOHWIw+5tT4zKkNv1iJ2dzBHKKBZAoYu1TcQmJedZARcys4/M66JEmxTV
         ZxzCpBZDJdT1xHg7wtO/+CrWaXHRJyDKJjZ3fgJlue1sgRo00VISa4pn4Czq5/hxlOEe
         8pg2depPIFxAZEk5B/e7s23G1UXDXXDrKlM8IWyG5rRgjIV1BWH/3yirK4EZ11HFDiAN
         LoAVA/MUZhEjKnFTqX6ZznV+FWFw7OnJJPiBO8ol6Ac2zfdGNF9XFqwZZljeVO0P250g
         e1r+RTcuV921LhjS1xt9qD23lKXFYVXreC9WlmsgHz3h9qorIODYxRLo0/4wyYiX1zLm
         phAg==
X-Forwarded-Encrypted: i=1; AJvYcCXBjDnXco5Z+2XJN6x86YNOsB3gFCHNmyzTuTS7NgwdY4WsyWQ+Xh1RjYYs43PU8yft1BABQg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwxEAsASB2RkTI/P+Te/s/T9I4VjPAWDRmpBbIlGmAbZvt3nu+M
	jO2lk0eFCQ6rnOl9bEZUBq9UpJIhMrAQ8xAlE1ysINZkKKcHTRc2+YL204xzl2jMx3cb//tUgB+
	jBaCv4bzp+iD+lL4RHSzS8EEYiv2jd7tMgChteIQG8w==
X-Gm-Gg: AeBDietbTDbxkhjNyydc6fm/rk/pe+qBEEil5Mh0/hQ4PfhgwtA4huin9u85WbomgnU
	MrAX2MIoBicR0DvbzNYSMuHyzADTZrHX3i/xr1aLcbcUzGXjgpYb0xkMt2s+u0ZpL/lMNoCHWBL
	pp5zjCO1WCUQswpP6RJv5vWwcOmWwQ1Jbrpm+xA/HFSJnd/e2EwK/6Z0gqOnTEzg/PpgsV+KFP1
	kj4VaUYL9iu9W4F+HUg/gCUnHeSIVWDg2oTK7Ef6E07OJRmSzMlqHpz8CK9RJb1hAXjdPG15RWN
	1X2mjucYQzqlMOC2wl9BxUQS6ORp9wJaA3eWtAs9vFL4LlWhMLTyCCSh+/nvCGguQUOyTq4owe5
	AC7OOd+c60r6KD4JZ8gyXx1HYedD8U/p8Y0myYuW0p929Hb8Un4aPSZU91d1Zaog=
X-Received: by 2002:a05:690c:386:b0:79a:c396:bfd with SMTP id
 00721157ae682-7af7282e484mr46611397b3.53.1775845975495; Fri, 10 Apr 2026
 11:32:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Sina Hassani <sina@openai.com>
Date: Fri, 10 Apr 2026 11:32:44 -0700
X-Gm-Features: AQROBzC0kt-YXtizzhgXbBbxbP2jPMd7-xT0-_zTfAyjyTIg0aNxYbMeqSKenFY
Message-ID: <CAAJpGJSR4r_ds1JOjmkqHtsBPyxu8GntoeW08Sk5RNQPmgi+tg@mail.gmail.com>
Subject: [PATCH v4] Fixes a race in iopt_unmap_iova_range
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Aaron Wisner <awiz@openai.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Bug: iopt_unmap_iova_range releases the lock on iova_rwsem inside the loop
body when getting to the more expensive unmap operations. This is fine on
its own except the loop condition is based on the first area that matches
the unmap address range. If a concurrent call to map picks an area that was
unmapped in the previous iterations, this loop will try to mistakenly unmap
them.

How to reproduce: I was able to reproduce this by having one userspace
thread mapping buffers and passing them to another thread that unmaps
them. The problem easily shows up as ebusy errors if you use single page
mappings.

The fix: A simple fix that I implemented here is to advance the start
pointer after we unmap an area. That way we are only looking at the
IOVA range that is mapped and hence guaranteed to not have any overlaps
in each iteration.

Test: I tested this against the repro mentioned above and it works fine.

Cc: stable@vger.kernel.org
Signed-off-by: Sina Hassani <sina@openai.com>
---
 drivers/iommu/iommufd/io_pagetable.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/iommufd/io_pagetable.c
b/drivers/iommu/iommufd/io_pagetable.c
index ee003bb2f647..355f7227305a 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -814,6 +814,12 @@ static int iopt_unmap_iova_range(struct
io_pagetable *iopt, unsigned long start,
                unmapped_bytes += area_last - area_first + 1;

                down_write(&iopt->iova_rwsem);
+
+               /* Do not reconsider things already unmapped in case of
+                * concurrent allocation */
+               if (area_last >= last)
+                       break;
+               start = area_last + 1;
        }

 out_unlock_iova:
--
2.43.0
