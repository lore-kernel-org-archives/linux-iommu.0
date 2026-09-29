Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com [74.125.227.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8473FFF8E
	for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 03:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790652525; cv=none; b=pQqEJ2tOf1Tw6R9/6Kmi8kORxuPiidIJ02nQAyvDNCeotu0XB0nD/9dzkC6VX5HNICImhjsH+CWb6InDakEEkdWzy53aDsLmU+pyMEzfAQtrcL/gj5KxCfkkoX6IU1fjkF426h7uYPNAMeGfuvr3RbYHghqfdiUUsqEV2KdPEMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790652525; c=relaxed/simple;
	bh=Ppa/5bvyDHu70Z7WWJJ5TYTAyJSoEiJO45Y9vEXZ7Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X9EUpMunfkjs65HwK7Iz0tG82UOQHMF7BCZs38i4fMy98WD2pJxxU7I7wMYAmhNmhTRecDeHnTWK+KO+/T/R186WtcS3exPdRwQsguNHiY6shELKHfo9aRJW+UVmvzK3wJt97nqLZFV0aZI8kEuOnqrezVJQQ1bm8FYwez2scY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJiATysj; arc=none smtp.client-ip=74.125.227.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJiATysj"
Received: by mail-pj2-f39.google.com with SMTP id 98e67ed59e1d1-3a49902b607so60061a91.1
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 20:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790652524; x=1791257324; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ppa/5bvyDHu70Z7WWJJ5TYTAyJSoEiJO45Y9vEXZ7Jg=;
        b=TJiATysjm7Hg5uba7R69+nZrQ9sSdpfvit0SRIihpidFu+n/R+C2SWEONqBZkFw4BV
         ZcnwIzCSmLKRtuyBVxm+/5skaWdoC3wARpQv6jbe5mwGDWsQdGnbQmc1VO0WU4B4tyLT
         a0PgB+1A+XUeHe9IKwJdMhhjKTalirnwZIZRsiMoGDgWl1GSmJrukRDXL7qmd3vBv2cX
         psNhVDox53O7nR0PJn60X79Gp9FMLKyGeDlUuqsDjD6Hj2+tijUxwJZKV0pahX1KVu+R
         rwjfiprHgXbn8l06UJ7NUn95B//ch4i5aVdI3gCICSWT250PzG/e6PVYDm6mxJlo0EG/
         cAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790652524; x=1791257324;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ppa/5bvyDHu70Z7WWJJ5TYTAyJSoEiJO45Y9vEXZ7Jg=;
        b=maN5l2SgV2+Zxs9H9McMlEVco2C5giOUvjeyPIXOLnn7R+lCRsp5OuqSMkUJ1tppeT
         wyfR0UORSEoGqj0w78IbnUIfV3spMPq653GqTuSDbfib0bNDYwiZUjOe/2vTdxIM+Dds
         G6IfsQKiBMhyJlZ/xw2isSRgV1vjmJLJ5PNq7JAagdjjIEwu2OZaErOLCz3Vzh8a2oyZ
         vSsojpFrJP0tI2Z+kBRqEu7gkAb2Xr2ITxZfLuRH0CGqF5Iyvw/7t/yUL32xSIgsZLhT
         1PEDYdQb5qf6RB6XhtE8TB8bKivnR+dcivL2hoG3OZIrq2rOvzdrglJH+C7RCzAV/KDX
         CJhg==
X-Forwarded-Encrypted: i=1; AKwUvBwAx5dPXIwwjRiSqzEQNX6fYfGlhVnadgXoBMTAWShAGH9jNZwVe7P3vEYeIsI/SzWzOsLCbQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLzOkSxei76MVjQ+JV+gKQfqQVeWpDoQ0vywBxpzmaCJmJldn8i
	WxogTHtrncbzg8FTBPK/B6vhQ/4EYKmOixcS4ZvUDeAsYaO4CbrPywL/
X-Gm-Gg: AYBFou18jIj2NMbyooqPgBeCOWkTXh+L8p8eesdFeSuTX92teldbOh2FnnFDWtuaXXS
	5j3ZrQ4/vx59+tvmGd1G0sQujy4R5YnXrxycACMZ55Wvb8VLhWO4djLC4UZ/ulPYH0SJTaraGzg
	83lWOi5QF+yggzWspCsJRDELOqL+wTOZEGbqUwXLTPUYXKdYaBHub9JCXKhgms/geVfZbu29+Si
	rt4TbZCqialznY4ph52HorRFP8VUfVcidWRQAzA3mxHsELD1JxUUtmt1z/Z9U4xla4fYDk8nUlv
	KvWTbyPw4EcWrdutPvdUPKfO9GnQG7cJTT2DEKJ1SI8lrNGHgU1nBvAC/MISdo4p7V2yZzGSV2H
	FfdxhO4rhUAlJj8sU+p97W0WZ5G3p7N3yT1TG6ShsLHpMCtzaArcnvK76ig0nFeb5BMjNHZBhV8
	3DqqS419X5U9NDm7PT4oX0ZydWZ0+IutrPqnAbgL7LgpCjCqrWby3NvE2rPh9N8DtgQ20yOr0Lv
	vryUrBBUvieq6c=
X-Received: by 2002:a17:90b:3c4e:b0:3a4:88c2:32b8 with SMTP id 98e67ed59e1d1-3a488c245e0mr4141496a91.1.1790652523654;
        Mon, 28 Sep 2026 20:28:43 -0700 (PDT)
Received: from jfliu-sfa1411.. ([129.227.183.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4986e9656sm934089a91.0.2026.09.28.20.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 20:28:42 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jianfeng Liu <liujianfeng1994@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Rob Clark <rob.clark@oss.qualcomm.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	iommu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] iommu: export iommu_get_dma_domain()
Date: Tue, 29 Sep 2026 11:28:35 +0800
Message-ID: <20260929032836.37312-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <47bf9a4c-2a47-4e93-bcdf-8d953c9a5ab8@arm.com>
References: <20260928053901.7270-1-liujianfeng1994@gmail.com> <20260928053901.7270-2-liujianfeng1994@gmail.com> <47bf9a4c-2a47-4e93-bcdf-8d953c9a5ab8@arm.com>
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Robin,

On Mon, Sep 28, 2026 at 12:26 PM Robin Murphy wrote:
> NAK. Read the comment - this is an internal helper for iommu-dma
> (currently the only IOMMU_DOMAIN_DMA implementation) and is definitely
> not for random drivers to abuse. In fact it should really move to
> iommu-priv.h now that we have that.
>
> If you want to do sketchy things with your device's DMA domain then use
> the public iommu_get_domain_for_dev() interface like everyone else.

Fair enough - I'll drop the export.

For the record, if the msm side of the series goes anywhere, the plan
is to capture iommu_get_domain_for_dev(drm->dev) before msm takes the
device over with iommu_attach_device() - at that point the device's
current domain is still the DMA domain, so no new export is needed.
(Christian is pushing back on the msm patch itself, so that may end up
moot either way.)

Thanks for the pointer,
Jianfeng
