Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297E22EBB99
	for <iommu@lists.linux.dev>; Thu,  9 Apr 2026 22:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775772635; cv=pass; b=DZeIe5lDqyYvIVhyx1d1dP4lEiwxklWL6HJvF0pTIJvfkwS2OqKw/qz2T269JOUH0gICPz9vb19/zDYehmu9v4SIpQQ77FErEw6c6cKwS1rdSycwKt52lXAz+6ERqlETiA8GmeUqvMzrf2iIkfuukYXeRGfshwB2yfCBZ6YJ1V0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775772635; c=relaxed/simple;
	bh=u6Edix2jXuIS8tFnaNTmah71uMoOsikDpNEPIIstLWo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=A4HMonYCpLCr6wNCp/f2yPw1lDX55N7aPSNmxYZ0mirT5GVslKArXdrOLk3peY8J60mITQ6ZfGLuEOwMLZnsLEhATwJ3mLQtuAnO5TUuCIQc2b9ouIcRaP/RU6JpLqh3lfDXvxXmBW7phto6uwkAISFNzyeu4l+sctn2UeFl62I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=FXtokulK; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="FXtokulK"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7986e0553bdso15295157b3.2
        for <iommu@lists.linux.dev>; Thu, 09 Apr 2026 15:10:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775772631; cv=none;
        d=google.com; s=arc-20240605;
        b=PPGLKWGtVDSVflYypow7lK4GwHsTx1ZkyQGnF8EWyF/LBPrV40ra8awYTUuG2QuRQr
         0a6AaG0A8gGSx3liYD8qL06wWrDUSxE35l1pqOs+wdWVP7RTcESXBweRzYKBBlaZF2R/
         j8KBXRCmdQFE7GekwMZiCyrUynsOvaxX5OxZF28wbfW+iBJlAR0L7e21hhj1Nsrw0w80
         zpshWuv0jcpx5ry619UnbCMn+OuPKjgjEriwIJ/y1QaU3hbuhxABHaBY2uqjCF2DRlUd
         zoh06Yq5W9UR8QnqFODuM85ZvblDake9+zg17YK8Y0g0Me2EBM6jhVtwZDEV25P1rdNE
         VyDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=9OYRv8rvi0/sGy/tiETryCkJVCR2waOffWO1EsBR59E=;
        fh=Qy/4B802nMEqYXJfOtxSS6FwJF5aFPjKpGpKHhumlKU=;
        b=kVMDMmwm/U0tJNINJnlbsR59HWLYL82rkwOnz/bdjURozdRPKs4y0v9e6mX4gyg5kT
         IBNK83CH53gL7IcO3KGgYM3QYAUFwAMK3QvfFUgT8BBSbwSm4fn/+eMKFSnvz+lbMj1T
         re3QRm1VQKCTH2cmI7FsdSbTTzGMqqb4NGNH/xgp23+kqsIusHNLeUIVYcaW4Tnjf0YZ
         krOrLmUJjF/EuPRiBCqJpn0DIv9d6oFbmbUr6gm3LbNdL4tAU/3p6B3QmTXupGZJ841S
         63oFicfLZ4q9yRam/7eKLg0ZAP+HfiWi4pfX9ImYCTgc9i6/OTQeFXJzya2BYW9yI6Ob
         vVhg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1775772631; x=1776377431; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9OYRv8rvi0/sGy/tiETryCkJVCR2waOffWO1EsBR59E=;
        b=FXtokulKTKGtIVqf2DAuBqvw5GhuY8J41npfrjs6wCsZm39bnVE2rOaJD+yc7V4S9F
         d5spvRvBnkLMatVwEHcmUHN53WIxqryIBCshbzka3jPNUiZcFNhxCyTrqfuXVBBh80Vj
         RRK/r8qja7XdjU2fl4ajQ2pu0NA2BDIaC/XSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775772631; x=1776377431;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9OYRv8rvi0/sGy/tiETryCkJVCR2waOffWO1EsBR59E=;
        b=HqU5l83hHGl+xxUkZzPTPjZIs+vH2kg9fj+O/heXOJwgmTrfcRBpuOmiYWE3h11lGe
         moRY7Z8GKf26ZxepBkY+XKVU9ofh0LARCEHj3IZn6GZiryT2kYZfWXCPheoq7AgAS6ju
         V6YnxxysuZ3bitZsid0GHbyH0UAXCnegWY3K2KbgkaCN5HR/SD0o/XEGerQ2tTHY1WfM
         7rbd8HSDk6HTr281zBnznKvqe+bFEsdZ0PNkC/NlWoStFDKNfmWsfJ3bjQ085CnPDfsV
         GPwLaqNCoeePD4IDU9mBOuXr0w9CnaSnf/h7EPNs1qOzBjhTxsjg3FB5eaHLIDB/ceGU
         1KNg==
X-Forwarded-Encrypted: i=1; AJvYcCUsZbeEo1uagZLewSLdFaFNGV1M7IJkyy60+8Sif2c0wTey76x9lgdFNp1hysQrNfNKEWsOAg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJQM84IirhQm9v+HOh8B3MXMJQAwXE1cEThSmDM0UuFWwqsjxY
	06bIzW2ferNvyCbQr5vNPn3Ec0EjKCbgYkA6hcuGUBeoT8wfj+WL37pcZ18pNjOFxUUfBwySQTE
	579YM0NsE2ZZPukQ38rqIjfbWwuqiPM0Fz9jfQqCi4A==
X-Gm-Gg: AeBDievyrV+Z+0wH1NTBrwOsh4cE7+oVPJDpdXNdICyx6cKCzp4EpTEVqBes7pcMnIu
	h8xu+ciylKNAJyiAS2BqVPhUsGEQqVQtio6febGQR67o7+RLMX3cBc1qj9ufs7hNrhQw59WwnGW
	RAslQzpCGDDCGMp70mPTgUQ9aI7fN63KSuDbds/KHiZOp6Y1FAlsarWFORwSmX3uQ0Px5VO6fQ5
	pDnoURoQxYHbXZCELAgsnkhQOVF2MbRO346wAKPP+hXr8a4fMqBYEWeZa5Uc6Mc9UYK07YQFv1J
	B4d7WIrt1Fyim4Id+oQJenccioVnCyEAl63RGLV4GsmTzwrmUkzoSPnnJhmUWslhQRLC5dFuL4V
	0GmKNU3xxhx43taw9KHE2v6PuR/HJiVRLBiXgkcVh/5cobRAKwZDJCCeTRrwmIpQ=
X-Received: by 2002:a05:690c:101:b0:79a:d067:1b4c with SMTP id
 00721157ae682-7af6f22b14emr7813727b3.7.1775772631395; Thu, 09 Apr 2026
 15:10:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Sina Hassani <sina@openai.com>
Date: Thu, 9 Apr 2026 15:10:20 -0700
X-Gm-Features: AQROBzCM67wdyRTF025m1tdh9-7YRagOsrTvvnfPYDG5A2v0aHgobJFekGQYxnM
Message-ID: <CAAJpGJQ4VyeaZyVwh0Y-tanUCAqiY8v=rmiGr8cp_XmFph=SGQ@mail.gmail.com>
Subject: [PATCH v3] Fixes a race in iopt_unmap_iova_range
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
 drivers/iommu/iommufd/io_pagetable.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iommu/iommufd/io_pagetable.c
b/drivers/iommu/iommufd/io_pagetable.c
index ee003bb2f647..e306871de06d 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -814,6 +814,14 @@ static int iopt_unmap_iova_range(struct
io_pagetable *iopt, unsigned long start,
                unmapped_bytes += area_last - area_first + 1;

                down_write(&iopt->iova_rwsem);
+
+               /* Do not reconsider things already unmapped in case of
+                * concurrent allocation */
+               if (area_last >= last) {
+                       break;
+               } else {
+                       start = area_last + 1;
+               }
        }

 out_unlock_iova:
--
2.43.0
