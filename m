Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF5A3749F6
	for <iommu@lists.linux.dev>; Thu,  3 Sep 2026 07:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421774; cv=pass; b=fnrzQX/rrZ2Dz8tYp48h2k334dC7SWreXMrStgKzjTG+FavBCB219RlZsAwXgMVfhecBRtisWsq79szw7I2s3EcMeEgPMQgQ0zHPfc+AXni4zmkHLPaHxL6UOugYquRO3QTpkBpAV6qMyF9CXWTOjqfK0Xyalw+7Ur5KMNHJygI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421774; c=relaxed/simple;
	bh=Z+NPJm3/F4Yvk7odWAe7EADRWFhaUf6x0bt93hbRKNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JjplMrRU8uNHRWm8QLCDWnGdF1KMAOESarHeD/aADIRaaqU6lOQaCG5oCzhUG0bWEh39UUXIR6aJSEoyoIzSReukKmhu0fdGyyIowUzNS+Yp87t/YsJbvZXPbWp+yGjRzOsrEst7ZNNuhDxKmFaY8JFKr5DEe/uWyNdqMth45so=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0ubAkuN; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0ubAkuN"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-85590c5aeabso1757724b3a.3
        for <iommu@lists.linux.dev>; Thu, 03 Sep 2026 00:49:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788421772; cv=none;
        d=google.com; s=arc-20260327;
        b=W89TRsEGT9kt9GWQkpxWBMnZl6wcIRdZ4MnFcbmcvdQrgHXRB++ZkCGQp8ChMrmhYy
         yXKmBqXgOFd9rgcFFRZeGrirC0zSJUVeQFn/nl3UDqqWazoxAt9k8y9R7lowv3oEsAXp
         ucXIkrtKctt1oZmg78u9EQlg/3zhvaxUZqYImKEHm9Xk10jcnPhvXxLrENL8jliv5ps2
         0fY24GUVjSbkw0oUwyTcp6PdDRGNpEHwQvbKL1uMlG1jm0rtHnFfZVj29kpYMCfhbX9g
         S5y+0/dpiCYTlv4GGyXLBXLKwufNdRTw/L7ixMoNFOilGOvYBAulqD4w8fQyV6l+MUdC
         /0ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Z+NPJm3/F4Yvk7odWAe7EADRWFhaUf6x0bt93hbRKNQ=;
        fh=JYa2gFigYFMC+1cPNRTsdwZuV94wQ3RrAEBR4qYviak=;
        b=e47vBwxrrbetVk+yIQeyoLUHUj3bpDSSoR78rTBo6675fJwCCgzAGY1nlGPWcCSn4G
         uhjcKzWbH8w6lXj6RifT3l4kGugatgMXSr1LvHM5qkH2A6ewC+TTXXUISRJdIACgij6z
         5SuUj5BmpNVkSvVvvganga7bgwR6t9NjPnMYW/xs2Y5fxE79bi9sf4seUX2/bF3o3/aN
         YuK1lhpJoleWC1CcwHeINOiR9EVvAV9fUA0dGhfN3uTGYagPGOZ/JbLA1xZgkowNwwR7
         1qmULF4RKu312cVju/C0HBsEWp+NNHO6IIrJqLhwZcXjPjTHQVAtsChndKWOq1T6GjDJ
         +CWQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788421772; x=1789026572; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z+NPJm3/F4Yvk7odWAe7EADRWFhaUf6x0bt93hbRKNQ=;
        b=R0ubAkuNAWlUzvz70Ogh2t2NGPSXKT6ggyPxYkDjjTPDCMrTdSUHGAtBe8XPD/9Gog
         4i0sHn5ReJ35HPkDxDZcrUg4bmd5rWJY33Qdqfj1rCmxe3MxHf2zsazKUcp8o11verkH
         8Z0JL8UZw3XbeJW8pgHcb2JCBDwwQGiswbsGks1RrXDnbMrppW50B0rDWaPZUUoLDNhB
         3bOD0gjMZ7V1hVyq4ahizF8ipbUyENP73nYe3FlR42GuBIgr4bN9e4bPw+7lG2HdzGxZ
         IOEoix0tTZSfZcGgxRGDYNb2234oDOgFk3yKoUhpMLsAv/qi+mGoRJMaGb2GgphbC9n6
         y8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788421772; x=1789026572;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z+NPJm3/F4Yvk7odWAe7EADRWFhaUf6x0bt93hbRKNQ=;
        b=T4dM09jQMiX92jyKFfRfyeeZmfeFn/s5XFg4DXgbS+RKVkY5NvskQUNZyppvvYHkZ2
         nKpWxxpCzW7I8F2z3FygKoZOhMJWF/B2AGgl4nlijAiLP/yOhc8BHsCeCn2Lq2GG1WQ1
         3q6O6QiHPTYbdBAWw5IOvQBU0JRtVr+2vO47EL5YWDH4ywXIIRxXwler7ppZDrZ/LvS6
         rh8hTsN0MCoTnQ70uX+XnRoV/Xdy+UPkSvZ5Avw/47+YlBCEomb2nayq0dyUEhxtw8ij
         VHcB8gU9xsHX5Xup4LRx8FcOg4XnbAsL29bzmDD7xja8pugHJW/8M0rhSHtrJmAWeEaO
         iTGA==
X-Forwarded-Encrypted: i=1; AKwUvBzyj7LJig1zINzn34bjzo9XVTYIN/uqGbGYaRuNNSRdtaulqbeTDuW0WlJIOJS7kbCk7ZCpPA==@lists.linux.dev
X-Gm-Message-State: AFuF++m3GeCLZbcccBn6WLaiP3b0KeGJTqZ9GoCFKK+eshVLRJBaityN
	31fE/UGNTxmBzjEe138Mdu3aj54QFPuI6Rj2LM/C3y+DpwFVUGYmbQwBbEetOsJlR1SaLTCZ5z8
	FCvaEqZF1awxgK9oxFcgoayZ+Y1t5RRg=
X-Gm-Gg: AYBFou1YlDpTP59gzpUaOIhX9TlXmUJ2XknMEmK3nkP5DwhgmDiukQg5f5dRVAN6SRz
	7U9SACimM6Tx8LWLwfZ146hQI80agaYHQM/5ij8Omfdm1wC5wBa9SRCJ5u1zO1ivQP81AOAAIB+
	LDFLRaL2svn7ksYaFCj5J1gKKsQOT8+mF++8G1C5Xaevd9jO+rrnFTam+leUDYMTP3ChD6IFnUD
	ZVmYDqYhzWH9Oa7z8DUXNKq+67S50W/Mz/FLLKxqPRQuRQu8n2rR2jlQhGPz1vrrnkPv8/ZUEXG
	pkR3UIqkqPNCOAIp4sfKFyyLQHsufzt95ZpkLievdOZQLYTUkA7F6h7y+A==
X-Received: by 2002:a05:6a00:4397:b0:857:7317:cff8 with SMTP id
 d2e1a72fcca58-85ed4b21177mr15299064b3a.25.1788421772181; Thu, 03 Sep 2026
 00:49:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260903072419.1485256-1-yi1.lai@intel.com>
In-Reply-To: <20260903072419.1485256-1-yi1.lai@intel.com>
From: Yee Li <seven.yi.lee@gmail.com>
Date: Thu, 3 Sep 2026 15:48:55 +0800
X-Gm-Features: AcwNN1X-vSoSXYVOWj3GC5Kk__19V18MGkeSjvgHea1GqX_QFYbmP-LQSIwPwb0
Message-ID: <CALX8JfQ6dT2gV2xbSf+_9j=P2i+0K5pXVQ2YdCs+zoxp_QaC=A@mail.gmail.com>
Subject: Re: [PATCH] iommufd/selftest: Fix wrong return value in iommufd_test_dmabuf_get()
To: Yi Lai <yi1.lai@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, joro@8bytes.org, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Please refer,
https://lore.kernel.org/linux-iommu/20260902085414.549830-1-qinyuntan@linux.alibaba.com/
