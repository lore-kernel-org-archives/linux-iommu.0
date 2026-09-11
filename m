Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798CE3D6663
	for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 23:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789168811; cv=none; b=nWdAotlvGspcLgm/LJPvg74tIzB0RoJRLFG5Tf+0HBft+PeIeXVTJPUqtT1mwxE2bpKb99XEX9UoEPgnS5FNx7BCf8N4shxOKUJq0r/qmLCoqo+V6QEN0SAriLGoWa3XABRQo8U/uLx9LggfO4lywkZuW3gECIcBbCXzAPVEJ1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789168811; c=relaxed/simple;
	bh=M4YbOXcrDd5ognpBvia/Fl8AplmHnd7AcjxPujAzF5o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wkzw6bi14bz1chOnmvYqX65DlOyZuogdfCcrYJTvenCnBNGQUPONeYcPj9lRQwhKdLPUT6RDLspApAVwuqpzS9CJiwdSO4//5nk46iRnu8t6fe3h0jtzpFXsOeAjnsfqmQmcIvc/tKC+1fMwVVuhcF9OJBRqE+9T5lyQhjfeGqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYrpf8Ml; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYrpf8Ml"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b965f447cso723785e9.3
        for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 16:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789168809; x=1789773609; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3flXmSiNWtRzfY212ck6RZAm3iuAZm9IH6KLXSNuCfQ=;
        b=YYrpf8Ml/7uHsHPaDw6CnZpzlAn3Io2nqhsXMP+i9UCzrd3+GZR8vDhTR9BQN2ADBO
         GrSBko/02t68z8gzerW73UpRkgrtQZfP1yr41T7GOza3CWNHiLCv5lHVZIwx6LreI6Va
         JEdNV0RXWWuORBIKeAS6MjMdlDzfWZQjv1cYoybSGiiYUy7vYazqXmLtXD7eZ3oOm6rk
         x0rqHKhB/5N1f83PljA1mYaPclEHbUsP+EYqt6hMyQ/MLCbWwFMHgD9vkmv/o+5TBZ60
         +Off0MfOXX8XQDo7SXhF40WvR42GgF1UZkcol6dk+J54kl00se4FgvbF5T0mSYnA670/
         aQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789168809; x=1789773609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3flXmSiNWtRzfY212ck6RZAm3iuAZm9IH6KLXSNuCfQ=;
        b=Sq7FH9FIL+weNsc4Dhsv19iJUBo8ubn6Y3HE5ZhGBRD8CA64SgTDWYjDyek3JGRPpI
         cwwmle/4cYACNZJs1l3ExuQOaw2T4bOgjFdyZKrq7BafYq7faX3supMrmy5thc9B/mUh
         67YqByXSPtoDNJaM9DEzAAjjAF0qbFIfmOg30rEK0/xPupggMLmY0vYabhc1TD9RS9BE
         wEEwcudOMEhYfUaw1TqYG7Ftvv/0nSOVnEI69iKn9DHX29Vopi4FYD1NSM+0YlzCmPX5
         y0y9faeDJn6PnLz8z4zP1Fj2C80BnItPEFYReD77owtOKAam7B0IoF2zFQ5gvCoJ65ZR
         HpdA==
X-Forwarded-Encrypted: i=1; AKwUvBxZXV9jK4V+zhPsvQvT8fIilznACGB9Qw4eHHu6dxqJTky/BZ8DNmuTF8kmTmDJsiZ0ZJ3bMg==@lists.linux.dev
X-Gm-Message-State: AFuF++nEebQlQPMqUrwtRdSgD4jzJemJH4NF37WFLt7Fze/kd4/gjknN
	IOo2vx0HMmAUvlFXltgi/IzsvkTnfL6lxwqxekJxRMH6ZFsEwUuPME/D
X-Gm-Gg: AYBFou1lvQdtCZewE0kHhSucZEpYsm74XYfYZWxVYoGmBZILWxEAgohRA5bYLQBfWyC
	9PczlY4MZ2B38ZPagKZJZvqwnRLMlWsSkOb5B8by0xp1LdD9TIt61uH+xiBoiMi0CnXH0o11sBh
	iBUyzRcdJrthhyFdKc9xNsUePOLj/AN7VMxyU5AxF54JjHgnlL/6KknIdBr1nIIXzkxd7TRd6sx
	tU+LFQEMiyHgzRh1cwWB9s81c9+1Bj0k1La3scOxsJ1DEhWeERqosM8WHPy1YTw84iavtTuYnUn
	gw/WejyNkgDIQfKgsIaTsFMfaRlO4kR4rZl+PVkrjdQG4wIQNfJ6N2EyZrF4FqRuAcDjZ6Jb/on
	900GvwQstUgHHkDXPp+OCaTXVxeVU/atBAzTrpJddeZUa0VdYJcMoN9k8jdcQFnS4k2Q3aaUxrR
	wplCmKj2uR8X0TQa067BgqveP1wYp0JAbdZo2wnCRqM/UvRe/DiHbnVWJnhHJWnjsK/+1dQoHXL
	mLzLNoMEen3luGVc74ZasC4okJEp4q95dza74GSUOn/mJ9VmdhKQPQtbYEnMnGM5CFraJViCgs4
	SxoEU2bNoogNh1xdJ/F4RZjlzlB5c5m/kFE4
X-Received: by 2002:a05:600c:81c5:b0:49c:fa20:cc0a with SMTP id 5b1f17b1804b1-49e6cc282dcmr2185375e9.33.1789168808635;
        Fri, 11 Sep 2026 16:20:08 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-114-033-154.95.114.pool.telefonica.de. [95.114.33.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e5765152asm149048805e9.11.2026.09.11.16.20.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 11 Sep 2026 16:20:08 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommufd: Fix iommufd_hw_capabilities reference in kernel-doc
Date: Sat, 12 Sep 2026 01:18:50 +0200
Message-Id: <20260911231850.20737-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel-doc comment of struct iommu_hw_info refers to
iommu_hw_capabilities, which does not exist. The name is
iommufd_hw_capabilities. Say iommufd_hw_capabilities.

Fixes: 7623683857e5 ("iommufd: Add capabilities to IOMMU_GET_HW_INFO")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 include/uapi/linux/iommufd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 206fa667c782813488bba2195155b4871b729005..bef6a2665c2b6f42149b5e001f38209764905207 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -776,7 +776,7 @@ enum iommufd_hw_info_flags {
  * @out_data_type: Output the iommu hardware info type as defined in the enum
  *                 iommu_hw_info_type.
  * @out_capabilities: Output the generic iommu capability info type as defined
- *                    in the enum iommu_hw_capabilities.
+ *                    in the enum iommufd_hw_capabilities.
  * @out_max_pasid_log2: Output the width of PASIDs. 0 means no PASID support.
  *                      PCI devices turn to out_capabilities to check if the
  *                      specific capabilities is supported or not.
-- 
2.39.5 (Apple Git-154)

