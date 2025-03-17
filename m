Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2120514A4C6
	for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 06:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742193796; cv=none; b=nF29eAW1bN9euHKdJ2hoAWWQZHHVbkbswdBOMI853Ma2LY5LOtSbfAlvFi4zqB4UGxVNzTG3INqfRhEWVyV+IEhD397cuIsSmmDKOzfexl6cpSdmB2sROL3iSc5IoFKPL5IhOy9PepL/Gtch1b1TmpJE6A8tMj+NuN2ZkkqquGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742193796; c=relaxed/simple;
	bh=i71WKjub0uG0+Ui9Q92aOw37mAkL9kfGbCp6bztHV4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gWstzB+h+RA+lbMEuSmk20zSdIRSpqgRIY708kxPWKOYXJI+9CO+ax2MRsGy8BtE326hhmuNZ+gfNeImZK6/MPLnjhY/xU06K3XTwMVTRkx+indyVZmCP4XIVS6h+zk8+LlQB91Z62KDAUprx2nRHF4cVCRVPxxXZWq2KMVM0Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XEfHmmBQ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XEfHmmBQ"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3913b539aabso2512373f8f.2
        for <iommu@lists.linux.dev>; Sun, 16 Mar 2025 23:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742193792; x=1742798592; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4zYZVPweRynX4DyzyYoh+BnMU6gj3wjwqz97fLhpSHg=;
        b=XEfHmmBQY5jVX9K/NTjOA3bQUa3HUAGvq9KAfCqVwKMoZ9GD/6uKPVisvIA16yFZ8a
         Qj11XIn5w+Yj3Xv9xaM88+kNfon1c2py/+D29A6EQU7c+bGZTov5kyRAlpCjHqwWL+e+
         AHQHbHRxo7c83Oa92wzbn/fLQ6EyBodpFeukm9I3tSuJ4HlAOZI1ThLgh9o+p4nXfB6H
         Bk4OPztu/v3n6446Ron/RQOCG4Op4EAbMc87/gjCv+U1pdKJx5XiwyNSePaCZs3857D5
         ybJmHHYsDvvpbpkgHHJ4R3xJ9nx/AlUmL+mI5S2M8Upmgt3nyCcX6eArgKMfcVuZm+/T
         QGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742193792; x=1742798592;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4zYZVPweRynX4DyzyYoh+BnMU6gj3wjwqz97fLhpSHg=;
        b=njr3NZmNXRbwtkKdEnKqW/XHlhRUx0dX1im02v0+VfLBPjzum5tEto20P9Lr0kQA0O
         JO2wQTtv6rKcGq8mv1giQe/liKwHEi7ES9FyS7rSdSHW/TxMG/1H/gDVTNrQfeuWiw3J
         wonA/K8NrSCkGZlwwahpbuOwL028yC8A7M1PRpRtCEqQN/9wyqYpEk1eqKr9gs6rQKqf
         nBWhRK+3u/1O50BngmqvudQT/Mx4nc9pSYCEz0ZNJ3wU5zVIW/QO7gsLkXrO+w31SoGn
         FEucyiCUNPzff2xcmGkMXgl+Yrs1QAb1i4ebq8tlAGBG534mLJgsmJpRInj6gTnbXIwt
         1j4A==
X-Forwarded-Encrypted: i=1; AJvYcCWdC51IkrykZv/Qo23qdQv+y85BJiBm3LTr+hM6gmzqKrTxPqorFDAc03gf5N2oigTV76zZDQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxyMtM3iuw23Jx20wgFJ6VqDtQbguoTFzLxpALHxbOwn6hjpmam
	wIiCol+Ue71eGzc4jTyQ9yAxpldlq8JeyOuEtucomen7YTlJUczgNbmDzCgSMZY=
X-Gm-Gg: ASbGnctHZgsr+XQQYkTblWw8PBb9vxRbwF3XV6FQXz8k+E0okQGs4ObQ9+uLX7/5A5p
	qVt+fAUvsAE1dgVnUrGSmCqFwsuSmtBrE9rLq1DQjEwx1Bxh7KDW7AleBmCyhDgRAAAfGHuetWN
	AN/3CO6iFLvBFdyBkTJ5ZVgA4odw5wYAPZK2hdapE0AsKzdK72cz+8DzEDHdI/6BHTUhhi4EMn0
	OS1oDS+GOkVjYaB6Q/ecBkla5ekRyA6nnHHwh5K5uM1cX2XvlTkyRe36/pZIv2YsWZU841rWJnC
	+envx8w6GIJLIFgDQoZDt8X6w9xesa7Ok7kL7Q9lIhyhjHbTJA==
X-Google-Smtp-Source: AGHT+IElbtx2TAWZbzDNN7Ov+FaGcRS5ExJpOr0ieMaeHlcgQx5UZbMz299N1BJzxKUjSd/nTUx/6w==
X-Received: by 2002:a5d:64ab:0:b0:391:4674:b103 with SMTP id ffacd0b85a97d-397209628f1mr13971307f8f.39.1742193792478;
        Sun, 16 Mar 2025 23:43:12 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d1fe658d4sm95398255e9.33.2025.03.16.23.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 23:43:12 -0700 (PDT)
Date: Mon, 17 Mar 2025 09:43:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iommu/amd: Delete unnecessary NULL check
Message-ID: <d9e17a6f-a8f3-4272-91b6-0ee7e7808c8c@stanley.mountain>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <960a6d1a-63d6-49e8-890c-5e8a66e50c45@stanley.mountain>

The "iommu" pointer is always valid at this point so there is no
need to check for NULL.  Checking for NULL triggers a Smatch warning
because it's dereferenced without a check a couple lines later:

    drivers/iommu/amd/iommu.c:3200 alloc_irq_table()
    error: we previously assumed 'iommu' could be null (see line 3195)

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/iommu/amd/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index be8761bbef0f..ce2626801ddf 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3192,7 +3192,7 @@ static struct irq_remap_table *alloc_irq_table(struct amd_iommu *iommu,
 	struct amd_iommu_pci_seg *pci_seg;
 	unsigned long flags;
 	int order = get_order(get_irq_table_size(max_irqs));
-	int nid = iommu && iommu->dev ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
+	int nid = iommu->dev ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
 	u16 alias;
 
 	spin_lock_irqsave(&iommu_table_lock, flags);
-- 
2.47.2

