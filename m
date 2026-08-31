Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3AB20E030
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 06:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788157435; cv=none; b=WaKgNFAL3JUD4e39JD9r1u2ayy3VixXfk232P/SwthonmecXr1DeqkWvQUcqLOLHaQpucdJ+GUrrJYMmHSdYVFD1GkVzWmkLR7R3LUWN3FoynoTFEuGMsskUuHXlrxctwjvseSlL64yZOlLJCEl0MuBo24LPAYz7BYyORGqgsQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788157435; c=relaxed/simple;
	bh=bW1McuOm5MxS/wAvbjdj6DZ0Z5y8yewfsqOqvABux10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qgIoy4A4y+TIGfi0Isl+KOA7v5gTkX9CbXD8GNgYk9bQTQOqAjacfGlYdv88GdfuS/nT0GqNDQ5N4yXnZUCtPqvRDTJt3aoQV6RsRZq8WAySfm1Mb6ablvqmWb93wSfCrxIUWJv5tAHYCMebMJtkvYDr8nlmH0qeqKFDlfie8+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PGyDes4i; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PGyDes4i"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788157425; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=+E8DdiqENzs8Weki0xK0ZO2tQVmeqBTFsbxfE8kGFLA=;
	b=PGyDes4i2uq6lm88oTMtXCAhbRC3sqM3CwKTeyYCcpYpXOVemjCbrELS9p7dBpIskqZ9jcaWQxeOfGaH//FHqUEi+qG2SDKvDuT3b8ADFjyXOFWU40WiV6wLPpP2Yru3rtO1Zb1xn8/lf/qWuBmQMicdUUsVO0NTu+HriWxGbYw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X9tmLy4_1788157416;
Received: from banye.tbsite.net(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0X9tmLy4_1788157416 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 31 Aug 2026 14:23:43 +0800
From: Yuanhe Shu <xiangzao@linux.alibaba.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: Yuanhe Shu <xiangzao@linux.alibaba.com>,
	jgg@ziepe.ca,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	baolu.lu@linux.intel.com,
	kevin.tian@intel.com,
	praan@google.com,
	skhawaja@google.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iommu: Drop IOMMU_DEBUG_PAGEALLOC refs on iommupt domain teardown
Date: Mon, 31 Aug 2026 14:23:33 +0800
Message-ID: <20260831062335.2177025-1-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <apBgOqEP4Fv6cOaV@google.com>
References: <20260827145855.1616223-1-xiangzao@linux.alibaba.com> <apBgOqEP4Fv6cOaV@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Aug 27, 2026 at 04:05:14PM +0000, Mostafa Saleh wrote:
> Which drivers cause this?

None that I can point to.  The trigger was the generic_pt kunit suite,
which frees domains with live mappings, plus a module I wrote to confirm
the mechanism.  You and Jason are both right that an iommu API user has to
unmap, so the premise of the series was wrong; I am dropping it and fixing
the kunit cases to unmap instead.

And from your reply on 1/2:

> But the IOVA can be calculated when walking the table from freeing
> context or am I missing something?

You weren't missing anything - Jason pointed out the same thing, and no
iova_to_phys() is involved: pts->range->va already holds the IOVA of the
current iteration position.

Thanks,
Yuanhe
