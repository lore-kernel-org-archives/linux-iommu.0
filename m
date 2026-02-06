Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC726367F56
	for <iommu@lists.linux.dev>; Fri,  6 Feb 2026 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770385125; cv=none; b=VYzUWfLrcKB8vR+r5P+mWC7cMmWj0EZXtb4T6/GCje8865PilS66pnbPslRkbkvcxHk0PheVVF3HXY1OAploUnE3FM/ztPK1a5leP+9J4zV9P/WS+c6kwwj6Ma1F9KVqhi9BXpDe6IxIGuul9WgXIqZ6Joz77OpYvHaZ7UtRRmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770385125; c=relaxed/simple;
	bh=KU1YABdNd+/uaBrnrntgbyAveorJ8ZAcuiJrd0CgtMU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=U6YpdyfYAS8tXQAQ9cFIhInxAlqBsk5iIOWYDu+aPeDI49Wqghrn9tkoWz7eumSHV5p31H+jDmiXw7qnxwhaLIxlmZukrtq/yeg5xa2N5eYWG6kBPHweacofRedq8QfzmpErnn9vP/sNVfuGKRIQVjcSybq9gk8C+JM3anW4Omg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=okkYD6Da; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="okkYD6Da"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48329eb96a7so850205e9.3
        for <iommu@lists.linux.dev>; Fri, 06 Feb 2026 05:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770385123; x=1770989923; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gMr4rK4OUpc4zqGvHkqL1hsf5l7NXMQg7IzIbQkdIAI=;
        b=okkYD6Dao9UCHdUeLrLQjyjUkeKRs9j0I8z2ib/nizBQC684FY2tyJA6TgYETA4ALb
         872erhHSB7N1R8WKTBGeWlq8ZLzHbmUvYIr85NzhAbdTqWv4Au5TUDC93ktOLnmVNtX6
         5h++aKEDf1ml0uDauzwbh5cSVQcEuFTX+M6ExHMCtlynRvJDwG2+V2Y6WNwc5JXOOkWK
         K4F0PBfwDCs3ZO0J47GOLyOhucstf5JeVQRA+A7/K2/ysVZb/XG9d3JvihJa+o1idp98
         ztohbMgOlL7NshJGQNUw4tPXPZfdaRXq5aIqLnqg61nxeb6iPBISNA509q9U7Cto3Ob1
         Z2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770385123; x=1770989923;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gMr4rK4OUpc4zqGvHkqL1hsf5l7NXMQg7IzIbQkdIAI=;
        b=UMcwkMDvI7YJc3Tln1hq6mworQmKqc9mhUFZEiLujiCQneZ+EuLZVZ6pb880utCzsG
         Jk1mdtLEBb+DiL7swBprnWivtHntBIY5AS/r8eudIkmAmcQc3w5IMjM4UFBCgTXw/IkB
         e9irlffpsitpcRxyQS2eNn/4adCY2TAIYQohBaVdzn8pZMLfchBzhsU2xCVVcup+yGRB
         e0hHOFLHzFyDYwr3ZwwF5qZshqUwOANCYQUO5NJVA103XxLkcKdkKxadBkjmvqHMZGJ2
         nI+H+2dqduHkSAkK9ARTXJqJ+GuWGRatDJUlfPeJtEZAbEI8GbTpjs8EzFeVuKnihuHI
         VLPg==
X-Gm-Message-State: AOJu0YxXKRG7caR+8k59IPcMWY/tXIHMqD7G/LXQQ258P4A5vQ3d7Kcy
	2FQ23b0uVfpTN44FyZ2xVBSXthhUSddW9Iqt5y7ffU+7ZmpTIxS+C6i7EId2QwdV6lY=
X-Gm-Gg: AZuq6aJx5hi0F1rxPffN6iYnQ6UG2kzeo/Av7JzFo1mDYetmGDDCyVbHvjOTTEP8idF
	9vxRIsg7A5d4sXZ2T4DZ6ft19iaoSgqq2iRKFZ1Uax9Bb515976BGgM5/o5DTJaErebgo3YKRIQ
	huiWMb6sDGyIDnpJXpk4/ocGgUvWon+gMqfHkhYD0WYTOC/sy+CElOHQXvtt97jbBURKVQzQkSZ
	2MByAi3hTWMvlY+5E0VEW+mzqOBAyDxMj/hRAscILZrX+Cr7OG+VDeQbP7wqKi1aV/wzDNh+m54
	JhiH4o2D3F81My/nDeHhxWb0+ZFwLy/nnZb+BQAe7DDmit23Yd0Tc1B8YREy9udbAJoO1/nnYwV
	kYsRaLkPXPdhWzawbBOnCCQ2bWcH4XNHpqjNTaGhEk9TxSV+L1lk4197YYy7pxrUnGzTzpvVvt9
	qR/NYDhpPMCMDNEAOw
X-Received: by 2002:a05:600c:19d1:b0:477:9a28:b09a with SMTP id 5b1f17b1804b1-483208b9470mr34995085e9.0.1770385122950;
        Fri, 06 Feb 2026 05:38:42 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48323c12d74sm28249815e9.2.2026.02.06.05.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 05:38:42 -0800 (PST)
Date: Fri, 6 Feb 2026 16:38:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: iommu@lists.linux.dev, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [bug report] iommu/amd: Introduce gDomID-to-hDomID Mapping and
 handle parent domain invalidation
Message-ID: <aYXu33WW8EqbXTlb@stanley.mountain>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caa37f28-a2e8-4e0a-a9ce-a365ce805e4b@stanley.mountain>

[ Smatch checking is paused while we raise funding.  #SadFace
  https://lore.kernel.org/all/aTaiGSbWZ9DJaGo7@stanley.mountain/ -dan ]

Hello Suravee Suthikulpanit,

Commit 757d2b1fdf5b ("iommu/amd: Introduce gDomID-to-hDomID Mapping
and handle parent domain invalidation") from Jan 15, 2026
(linux-next), leads to the following Smatch static checker warning:

	drivers/iommu/amd/nested.c:161 amd_iommu_alloc_domain_nested()
	warn: 'gdom_info->hdom_id' unsigned <= 0

drivers/iommu/amd/nested.c
    148         /* Check if gDomID exist */
    149         if (refcount_inc_not_zero(&gdom_info->users)) {
    150                 ndom->gdom_info = gdom_info;
    151                 xa_unlock(&aviommu->gdomid_array);
    152 
    153                 pr_debug("%s: Found gdom_id=%#x, hdom_id=%#x\n",
    154                           __func__, ndom->gdom_id, gdom_info->hdom_id);
    155 
    156                 return &ndom->domain;
    157         }
    158 
    159         /* The gDomID does not exist. We allocate new hdom_id */
    160         gdom_info->hdom_id = amd_iommu_pdom_id_alloc();
--> 161         if (gdom_info->hdom_id <= 0) {

gdom_info->hdom_id is unsigned.  amd_iommu_pdom_id_alloc() can't return
zero.  It either returns negatives or 1-65535.

    162                 __xa_cmpxchg(&aviommu->gdomid_array,
    163                              ndom->gdom_id, gdom_info, NULL, GFP_ATOMIC);
    164                 xa_unlock(&aviommu->gdomid_array);
    165                 ret = -ENOSPC;
    166                 goto out_err_gdom_info;
    167         }
    168 
    169         ndom->gdom_info = gdom_info;

regards,
dan carpenter
