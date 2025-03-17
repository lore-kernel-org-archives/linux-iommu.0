Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30750219A94
	for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 06:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742193819; cv=none; b=EO7/OLnKW9sQ8zRdFOvyz06RRnzxDrszXmwRGE2y8oYkoVCaPCU53w+MGrA8qoc2k281m+OuXng1rt0galnCZcSVPfZ7p+DDSJEOqVNxs7EjodxIpKB2ZOHL9hVZ8yoVJL15FDbiGyeyhUZUdhfA7oHM0YiZhUqyK5+C/r3tkKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742193819; c=relaxed/simple;
	bh=SAXd+tnqhgdMVTCsrjIAySmhK5q7c0gBaTWPfdUM8o4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qw0re5i+gM0kAJlrsnYnPq+vvtw+Cv1IwAQsXkOHKfj7Y2CWBL+YQpot0YEN1SDj1Lpn4shFOzZB0uJoBpRVD1qNFbR1CkhQJqKYYOx8oEpmx8sy0+1kCl/n/r1osbWuQMHqzGKQCy1JfGUxfMa5BoI8v6fRI1otISO6yYMyUrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=odxyBhHW; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="odxyBhHW"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so18324315e9.3
        for <iommu@lists.linux.dev>; Sun, 16 Mar 2025 23:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742193816; x=1742798616; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N/vwN5dNyCUi97uHAKHSyt9c9XHXLZW11g/S5VxieqU=;
        b=odxyBhHW0+x7MLzt65WNRwWj/UZLarr7bPKSeN1X8aWrlxkOp4u0emcKDkZh4c1lqa
         ckkuf4SzAOxeCQA9fq/Hv+NDYh2XlxsSqv7XkFsvMNksZ5FFcj22s9tTSp5CfBaqGtgM
         acfKIEGBbIx0nFqBUuRpf0uqjUeEjr+BzNLMBZY592de4SVaEtxjTUwis+akiPrF9WFN
         EPMuNmihBcjaR5xSzVJ+LmSUa58EbERIE4LtWTTUVzLsmzOdutGfbD2MPhRJlKwHonJg
         OA/3gXDdvZz3xIk6fhqXUJadF7KW9Bl3DbDJVTCwX8bJGEhfQKSFA/EcheQ7FxGoppjJ
         1OjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742193816; x=1742798616;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N/vwN5dNyCUi97uHAKHSyt9c9XHXLZW11g/S5VxieqU=;
        b=MNQpQ82lBZaQqdCbLlTT1kGYesp5vFNo2+I4Q8wFhW9aM31fZ7a1L4aV35kgUa6JLc
         ylPhOer+g0FDpB6qMR086P3YZZsBibLhxZmwq8JLQOdCXSJ/dtSSg7gGG4KququuiFD4
         QsG7gz+Wstkb4nAZhTdMlSsS52n+proCJFAhAb8gK/Xo19YDmmij04O33zRdLAKJ+N9W
         hCtnAeRvebwDBWaffvVvyr6gXSji/aY3Ny/f5sfwXLbn1+kGQYbwcsZolF96bYvpGhTf
         JYiadrXzAfDFN2+bqLma/juYwSzAFnX9C0TfRwIvU0pzutQWZNLMIfRUfrpPP7QG1gJg
         hjhg==
X-Forwarded-Encrypted: i=1; AJvYcCXMvg3yOiP3hSe2PfFT37OlEeqHxIf7MX2pZ+wSBd/rzBjKdtfv3EQQCff32G0rQBCemKNekQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEvNNa/n+xbMy4bu6YN3N3MizZuVJE+VbYdSL1xRECVOa1zena
	R7ktGKAi7JwDwCEkTA/wDax3vfcC9+OT9+ey0lde8G9pr3ftktKbZRJRAqoUVk/3F5dqN0LvwUk
	t
X-Gm-Gg: ASbGncvZlSCmYwrflPkhBci7P52dQ1tM6djNSSgfVe0eboI6rEAmHFybe8VKZX0xf6K
	yXCnE1Mom8TtIa8+M14NhTvw5ls5aOR2i+XbFKb5FvF0XE+E91AW8ItKm6Or7fZt779xIFLLeGf
	/1c1e4m+mLvioSv2KavBeH9PUeYdVVapUUC1fdc+/BRhFxRemQpTj/dw+dgUky0QyDUpFG5ikHK
	lePS/NtmXRX/ERMKGWstj2/szxLIxXNdmmnzdcJQ1kpba+dYq/49glDkLZTHe1pSyEop/shMZ9z
	YjLQR6qww+DgJW4hWK2Ixom3wYlxPVLlDIyvHEFA6zsZClAmCA==
X-Google-Smtp-Source: AGHT+IHpbojnLnFsF4gaCO7LQYp8D156la7rfBOhhig4+j9+OQo9S59WfIE2bg6beTxHHhT//jo+xw==
X-Received: by 2002:adf:8b59:0:b0:390:f699:8c27 with SMTP id ffacd0b85a97d-3971d616b99mr8376465f8f.12.1742193816417;
        Sun, 16 Mar 2025 23:43:36 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-395c7df413esm13717850f8f.20.2025.03.16.23.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 23:43:36 -0700 (PDT)
Date: Mon, 17 Mar 2025 09:43:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iommu/amd: Return a literal in init_gcr3_table()
Message-ID: <faa7edf4-a757-4390-8226-2604ef6476d6@stanley.mountain>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <960a6d1a-63d6-49e8-890c-5e8a66e50c45@stanley.mountain>

This code intentionally returns zero but it does it as "return ret;"
Returning ret looks like an error path where return 0 is more
clear and looks more intentional.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/iommu/amd/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index ce2626801ddf..7cbcc4933c8b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2150,7 +2150,7 @@ static int init_gcr3_table(struct iommu_dev_data *dev_data,
 
 	/* Setup GCR3[0] only if domain is setup with v2 page table mode */
 	if (!pdom_is_v2_pgtbl_mode(pdom))
-		return ret;
+		return 0;
 
 	ret = update_gcr3(dev_data, 0, iommu_virt_to_phys(pdom->iop.pgd), true);
 	if (ret)
-- 
2.47.2

