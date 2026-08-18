Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C532FA0C6
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 03:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787024221; cv=none; b=bcaend6uBKFwFHF6sqMdAYe/QE6RZL/WOa61tULRxeyui+ixCqMY415cSO8VnDI0Z3eEOWhokeMOPu1eXaHb2+XQUVl727UtIcqe2FGYeSJfACvRA6cShnq2lh+h8nLvfp9mTe4uifFyxXl+Kk8B4SI9kZSuWJ9BqrVjodbHSwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787024221; c=relaxed/simple;
	bh=U5F688WMMvNMWhKiW2RyC/Q/4CeRKERs39H6+w+WdnE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uYWZF0kv+1ngCx1pWvn3dFircU9yR9agkIdnJVPFrz94sJJGmE+OJNAj6TXWYF/+kgcpDw9T/QWtdAQT8fNUlQmfNcDzUxFkWwhqpM+gVvpYEZIrtSHBrCISIsODNpQAv0aum7GsF1oCiDnLAKPSE69oWK7E8HJDJTdqmY8WBx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qXAr+DTG; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qXAr+DTG"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cc891373e0so54044295ad.2
        for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 20:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787024220; x=1787629020; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A3H5Iy2sjEmD4HLybLTgVzius4S/Epbm2MlbI5dOKhc=;
        b=qXAr+DTGtV0e5iR2XHTU3i8FHsbb5ip8mRcdW5E4aaRqlxHGCIK/72KHogrTUOI1Nc
         ITHkB8+ujDNcOEXPRI2B1MF/mUE2vlYF7V+laRI4VQAjx+mClZgmGLwA+9qs8R2lY4gU
         ow3VuxdPKXwk15Y21VDJMei16ABblLZGVOxMIXygM40L0kaLmH28PiF4G+C8IjfUvX0C
         zgP5n+NB3UKRMpg9gjlMsCi0CMLrnV3ULt5k0Zdpd4RFXM4JHYZb3WOMM7sfumzEkCTl
         TbpdCFbO7zKO4IfphpYg5KTXNmMPnWFyNoc1BF2YR2Juvg1jWb53D3h1xbeZck/tDTWe
         lHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787024220; x=1787629020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A3H5Iy2sjEmD4HLybLTgVzius4S/Epbm2MlbI5dOKhc=;
        b=OqG45Ja+XAGGR9vkK9pfFgZGiRSwP6Hpo8A5LDZGZd3s58pOKpLepHzWZfjr/M2OIx
         KpwT0nhYT9xla3Z7CjcX9pfMxfOzUQB4d0h9UInI52GJtzq/EcgDilO30cv6Kn8C9WTi
         8jfr4Q1322Ar+2OUWDxE15BpudXlZO05CzDL5QcqUDMNOiwH2PqkX6fy/D6bBP2OBEi+
         wnUyD95KNVzWg9JlOoqh4ag3sttM28DG6VUWS/T1aDiDJ0ONw/ExItHdWjIhrJ6lM7oD
         q7aiWhi6a3T/xwy/eAhBHfpCyigJx87rFyWwlDAWClVTq0eEBcVVcvpEGvp5dRa0GxGV
         UHmg==
X-Forwarded-Encrypted: i=1; AHgh+RpPRdxuqIlUGkUjMQNLWmzundYRWHkPJve12AJyTZVMoBNK+kV4d9mvH46gv4RS7vcPx9nZvQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx57C6OL/dbKgnlZfqSmjZYb25M2dZjtEWJzb4ZFTUrJpaBph72
	Sxa4cdFQQnmLqfp6B9Js1PUxDnD8yTbm6MknoFsYroZBdnpJcop1yivd
X-Gm-Gg: AR+sD10OBJB57LLrURXDmU4zeXbzaA7blsB8kI4O42D6HRVeXvEVQ3D1G57aXnlNDob
	06qEX/TXU7bmKXsVbwiPIO2ZvPU2y4JMAQiUsps8kajB1RVsQiEak5BwvCPD/FPBnCycbJCWCEX
	u/7WU5z7UIrlcSEQAp0mizvI2hUXQ+TXhe9cvPyEE0vjE+FrQUcMbTp2MRjJHH33+SdKwxpmuIv
	UwvPtwMNISIQtDat9rwBISBzV90UOm3VO5QieIJIpMfiC7P+2IB8/50kOOhBjjpqWVitdAiRz4e
	F9BsnGVP2PTNYzjY3WrLgkGs1alC8V8CIpBjsuswml77zViugv3jvi0SPsAGMFhgqd1RAWkBef9
	zHeZyDhSC2yqKtVFaM6Gy8e47m2j+/i/BxJ076C8vLNlw5bX/hEzwkKrBGryfH2t0fwVWmE9PeY
	O2xIjlposa/Pc+EJEacr/guIvSOZyGtWRblCF9aY6XjHLNYGeCBKL6DEvoE+HSIk1ioUK8S9x91
	lC0k1uw1DZp6Sn3d4DJzQwA4c0qhg==
X-Received: by 2002:a05:6a21:69c:b0:3c4:42d9:58e3 with SMTP id adf61e73a8af0-3cc71e182f5mr31030626637.13.1787024219740;
        Mon, 17 Aug 2026 20:36:59 -0700 (PDT)
Received: from deepanshu.. ([2405:201:682f:383f:53b2:c8c7:f2ef:3f4d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3267c388e26sm11654561eec.22.2026.08.17.20.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 20:36:58 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: jgg@ziepe.ca,
	kevin.tian@intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com
Cc: steven.sistare@oracle.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+48637757323884de77a2@syzkaller.appspotmail.com
Subject: [PATCH] iommufd: Fix NULL deref of area->pages in ioas_change_process
Date: Tue, 18 Aug 2026 09:06:50 +0530
Message-Id: <20260818033650.21443-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Areas are inserted into the area_itree before area->pages is assigned,
so an area with a NULL pages pointer is briefly visible to readers.
iommufd_ioas_change_process() walks every area and dereferences
area->pages unconditionally, which oopses when racing with a
concurrent IOMMU_IOAS_MAP_FILE.

Reject the racing case with -EBUSY, matching how
iopt_unmap_iova_range() handles the same window. Checking in the first
loop covers the whole function since all iova_rwsems are held for
write across the call.

Fixes: 829ed626499c ("iommufd: Add IOMMU_IOAS_CHANGE_PROCESS")
Reported-by: syzbot+48637757323884de77a2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=48637757323884de77a2
Tested-by: syzbot+48637757323884de77a2@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 drivers/iommu/iommufd/ioas.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
index fed06c2b728e..71bffece84b5 100644
--- a/drivers/iommu/iommufd/ioas.c
+++ b/drivers/iommu/iommufd/ioas.c
@@ -535,6 +535,10 @@ int iommufd_ioas_change_process(struct iommufd_ucmd *ucmd)
 		return rc;
 
 	for_each_ioas_area(&ioas_list, index, ioas, area)  {
+		if (!area->pages) {
+			rc = -EBUSY;
+			goto out;
+		}
 		if (area->pages->type != IOPT_ADDRESS_FILE) {
 			rc = -EINVAL;
 			goto out;
-- 
2.34.1

