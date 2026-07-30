Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D013644CF52
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785435170; cv=none; b=GmnToQgOLalYTU46tJdNss/jVKEDK1cC21TVcABZ0Xh3RSWUYPq+ELO0sbFBMYo1qQ9RFyr5ZZXu5d3tbeKF1ON+pB+1t/UlVPx4a/XROtbfs4aWAT924xDfHXi/Ir9xJuz5fpaOknXZu+LUlXr1HrnqMKin6Q5a+9K2gXi+mmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785435170; c=relaxed/simple;
	bh=Nh/9Tq9TA4iDVGO+eIh0VU42ygzP4tXd3XwrvqZFpMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GHT7xl9f+aSORqWo5mKlsgkS2lVrnRnM9mtbGWV0MXymXv1070yJNWskQiddJwkdNr0dAL8KJI+b0KrwvVVX/2cSLeitEhfhc/h9mUMDQY9k6CZgjmpuEXd9ZR+3vJQd+tjYWOYdc+cW4nFybPYt3+HdPY3rJnhjRKJnoDg8f6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmEevP8D; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmEevP8D"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso51745a12.2
        for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 11:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785435162; x=1786039962; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iOaF3ZXO4NAKK9OaRMocQnwJ3uO4yIZBEYzzq3ZGTvg=;
        b=jmEevP8DURHBWVY3vJg5J++09fr5SBmnDoGGsPej3iVdHHIV/dJWLv/du7RbXy9lM+
         75J4whJBc9fuqra19NZ3SaYZNL/dHd7yUrwrxVlq9wentKWxFlLT6wAyFqQY+b9fEcOC
         wh7GIMNlnVkcscOunfmS9RQgOVSi5NdOXuM3SSnXjuReo9wE8ARJZ542OH4D8R/NpXXl
         ClWBZ9BEG0cu+DdYO/+UvVFUUsvjGe8VSD7kZ7pESuLwvzjaQPu4qEjGmtZZC4JyXVSd
         3paDVfZrist8mNZDefVM1E327S+hvZ9QvRdxCQzXeVJdvANgrul78M+sbxeHIb6LYz0Y
         Ic1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785435162; x=1786039962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iOaF3ZXO4NAKK9OaRMocQnwJ3uO4yIZBEYzzq3ZGTvg=;
        b=lDBwpLId1Td/yb3ca39373Xjw6aKSqj7FJTOwRUmJ+dJTr2Z9Ffjz4mDYSyCVjwDFF
         n8cSzqLFU/L7YHgtR/H5Wq4woKvHdbcBtS73toSC+Xy/mk51ntvNoo0MdqtrFILTtWZ6
         T3c12yInDe/pRbmHJHUPO9/qjDeAFEti+pkFQQekpNLdtAVjtfoFAU5aHI+jUxg+pkgY
         adxelBJOu3yLtU9dgcCt8lvpJX0Vk1vqvLIOH3WyeTdOWqPzQI28LTPS/j8ojKZUuqfJ
         g5aC1ulDrQek60LETesvO3fFqE5cpelhtnn6vrzECYN111fEWBgs8GXie3DH18DefTel
         e7JQ==
X-Forwarded-Encrypted: i=1; AHgh+Robyqhc59/sSbJH1OIar3fZnfeF66SZSvxhSwGLrLlC059Bk+62B4dJXX9Ej6NZFe+/BJBIPQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKk6M2WTCQqi2sRlMYFFMHZ2RA3ZCQG8N/8E0s3kKpng6OLFqJ
	HcQqCVCtoqlZX1iVXCmdn2VkjdAveYRr+MbwbZWgPqniQDvMmS7g21su
X-Gm-Gg: AR+sD12vKvDUgd6lwO6iDTi8NifCvE9sCpyQnmv1z7oKk6NRAwz5ljCNc6igdo4UHPH
	/W6n3b0WO9G1voziE4oRFE9yl3M1FC5USO1TBNwhQHUdK0CBSx8TpoPVf8rO17UwZgC4DDVA5VE
	o6lTWT8pvddfhNCZFTOxt0ZTOb/7cV+q7HzI0sK4lDjuyGRcHOn6UJ3/se1pparKqE+dGAuD9PD
	aukO1cRkr3vi/l9gqd2DHMXWUSO853DMLx+WpwSUWhnlB5btB9LjMIyND14VmbwMqKG2V+Q0up4
	8DtacFOVzFKHYNb/xAuyc8fwOw4mLclKMlNz9d/9/Nh4G+vHwdwffx/ZyBTbSRs4DaAB/Z07CDR
	HxsIimrnGBVRAkRZBmNCYsTXmigndG+hLqWPUjcXXrR/mvbsuDZe+E4uFB1EimiDOcgP5CkDHyc
	vQ3DzBo7CzLbhj3ml4iSmVTQKYA0QdFXulQ5aNoGzO05gzic76RfbFPV/zDar8rJ63nwiYfmA7d
	Msw8m6+qkiUUQRkuHUiz6q5m2dZpvNfOrNXehp13RBtmr1Po6wzh+hx2bE8aq4=
X-Received: by 2002:a05:6a20:6a2c:b0:3c3:bee9:8eec with SMTP id adf61e73a8af0-3c9004c829emr3373312637.19.1785435162443;
        Thu, 30 Jul 2026 11:12:42 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com (131.197.81.34.bc.googleusercontent.com. [34.81.197.131])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b124e4sm21998197eec.6.2026.07.30.11.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 11:12:42 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: will@kernel.org,
	joro@8bytes.org,
	akpm@linux-foundation.org
Cc: robin.murphy@arm.com,
	nicolinc@nvidia.com,
	cychu@google.com,
	hhchung@google.com,
	amitamishra@google.com,
	marscheng@google.com,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 0/2] lib/sort: Clean up sort_nonatomic() and sort_r_nonatomic()
Date: Thu, 30 Jul 2026 18:12:14 +0000
Message-ID: <20260730181216.2709088-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the sort_nonatomic() and sort_r_nonatomic() APIs from the kernel
library.

Currently, the arm-smmu-v3 driver is the sole in-tree user of 
sort_nonatomic(). Because the array size being sorted is small in
practice, there is no real risk of triggering a soft lockup. Therefore,
the periodic cond_resched() calls provided by the _nonatomic variant
are unnecessary.

With the only in-tree user updated, the _nonatomic APIs are no longer
needed anywhere in the kernel. Removing them effectively drops the
wrapper function and eliminates the may_schedule branch from the
innermost loop of the core sorting logic, slightly simplifying the code.

Kuan-Wei Chiu (2):
  iommu/arm-smmu-v3: Replace sort_nonatomic() with sort()
  Revert "lib/sort.c: add _nonatomic() variants with cond_resched()"

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   6 +-
 include/linux/sort.h                        |  11 --
 lib/sort.c                                  | 110 ++++++--------------
 3 files changed, 34 insertions(+), 93 deletions(-)

-- 
2.55.0.508.g3f0d502094-goog

