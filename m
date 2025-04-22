Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117D127CCD9
	for <iommu@lists.linux.dev>; Tue, 22 Apr 2025 13:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328984; cv=none; b=NvCzfSoOp4rCvaQ4eZP+vtmYNLI/H+qaLZU+iBrZVCtBsiwJ01PDYLuZQQPjUqLqupEIxP9bHjcgGIWb/238GFbLdUjrhPbTsjkWfXAwUGcwryhCS1TloP77dxdfErMvSTpNzEcWN7PCdJnRCXP8qIEcZrTvXCoi46UZIEzFsao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328984; c=relaxed/simple;
	bh=sdH+VjupayGjr8Si4qDTpbjAgN0JHVoh6DQWet9OPHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=X0jQqqUQpXrypLa+pQvLVUYStU1bnG3cWGvZ7Ky8qhos/2r2m9j8bU9OHTaDD4slpnT/sySmn6X4uCs7+sT0PyyP6oCLNc86v57yF8fnMUrcCpOenq+wPZOHx5yUcpYDjC8krenWyYFVMdvO4p+JpOlaXqOQ5k+3P62BijHwoOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Gp6ny44H; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Gp6ny44H"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250422133617euoutp0251d412593aa6bd7e315f4d7496f938b2~4p3VK96ak0509405094euoutp02d
	for <iommu@lists.linux.dev>; Tue, 22 Apr 2025 13:36:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250422133617euoutp0251d412593aa6bd7e315f4d7496f938b2~4p3VK96ak0509405094euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1745328977;
	bh=ivUKiIe1ZDOjpJ6R1MorOBTNDfFmHbvlsgeXFk9j3g8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Gp6ny44HK+rkZ1x2Qilios5RuBJ0vWUtlD+J5AVsfuRWONcjc/65lXqvmxo4umIc5
	 dGe+ee2xuCeO0Wn810ZNLNfMlqKESFhMSEBK55K9+yw5X3BQXMMK4i8rBGTRLeqlaV
	 Ssany6nKJWVDry7Z/6ciwpnfrkoHPI/OYfs0yLeA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250422133617eucas1p291be38e1533ba29a276e0a084d1c30bd~4p3U-CCWW0946609466eucas1p2Q;
	Tue, 22 Apr 2025 13:36:17 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 79.88.06072.15B97086; Tue, 22
	Apr 2025 14:36:17 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250422133617eucas1p2c3b7b2e53d897ca7a89753ca02d32765~4p3UtwMhj2220922209eucas1p2l;
	Tue, 22 Apr 2025 13:36:17 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250422133617eusmtrp15dd049b2a2a373c55bab70ae8977147d~4p3Us44So0566105661eusmtrp1A;
	Tue, 22 Apr 2025 13:36:17 +0000 (GMT)
X-AuditID: cbfec7f5-7f7fe700000017b8-73-68079b51e455
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 71.47.19920.15B97086; Tue, 22
	Apr 2025 14:36:17 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250422133616eusmtip2d436fbc25661833076afb1a65aaeee73~4p3UBzTtR3067230672eusmtip2g;
	Tue, 22 Apr 2025 13:36:16 +0000 (GMT)
Message-ID: <fc2e30eb-2ec7-4795-a2a4-077b7fde7fd5@samsung.com>
Date: Tue, 22 Apr 2025 15:36:15 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] swiotlb: Make IO_TLB_SEGSIZE Configurable
To: huaqian.li@siemens.com, robin.murphy@arm.com
Cc: baocheng.su@siemens.com, jan.kiszka@siemens.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250422063719.121636-1-huaqian.li@siemens.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRjlt3u9uy42btPwQ8tqofTSjMRmWVRYrEDoCdH7mtfNUmd79E5X
	4CozsFlZcywn6SolyzTzUaFQPlYyLE3n0Gb2XJabvbSHNa+V/51zvvPxnfPjR2JCnZc/mZCs
	YhTJdKKI4OG3Hw42h6zJ5crCvmmnil8a0glxj/YoIR76JBZ3dXRg4idVBkJc29/rtYSQFBuL
	keTNrYtIUtGo40gGSgNX45t4UXFMYsJeRjFn8Q6e7F5TAzdlkNxvv9FMaJCJm4G8SaDCIbuz
	EGUgHimkriDQ2XNHyScEZ+q0GEsGEJR+PEn8XXlkN48OzAgyi1q4LHEhGHbqcY+LTy2G6sEy
	zINxKgg6y4e9WH08NF7sHfFMoCZDt+3CSBAfahlUdpb+uU2SvlQYvDBs8kCM2gWZxg0eB0b5
	ga33EseDCWouZPRljOTxphZBpVvHZT2ToaLPMJINKCsJ1barOBs6GvKNJzEW+8C7+rLR/hPB
	kp2JswvHEeR97+awJAuB5rUNsa6FYG8eIthEM6Ckag4rL4WiX+W4RwZKAO1949kQAtDdzsFY
	mQ8ntELWHQz6+uv/ztZaW7AsJNKPeRT9mJr6MXX0/+/mIfwa8mPUyiQpo5yXzOwLVdJJSnWy
	NHSnPKkU/fk2ll/1n++gK+9coXWIQ6I6BCQm8uUPreDKhPw4+sBBRiHfrlAnMso6FEDiIj9+
	/v10qZCS0ipmN8OkMIq/Uw7p7a/hBF61u8ONz2XvU29ubjH1GIqav/T9CLb81GgcAdUC9XDb
	E562yhkc+xVOC46UWQcum4NioipzP2yLLLw0eHaL7/rAn1nFPVxnnK9pnbVC0rV2aZz74VPl
	Ni+ho2aB49Dyw6LN6S5TxKt4lcuV1pmWdDA/z+FYFbJbiJn3pC7vz5aljvNveuzXdiqk0ebe
	FeUUyDnRAW8jVPebZmieWVonlXSkNe2c/nVjTeO5yHY3c+7xMmM057R1fkxB3qlpoQO8lfIV
	W1PeOs/PdJr7zx4rLyyLl17rfSC3aRsqNKoGxSxavS4yJyFi9t3DtCX2dUtiQMnEjddN9/ZN
	aX2ZU1sQQotwpYyeOxNTKOnfvEyxNaUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsVy+t/xe7qBs9kzDPatErB4OqeVzeJRWyOb
	xa8vFhb3bt5ktri8aw6bxcEPT1gd2DzWzFvD6PFi80xGj+0nJzF5fN4kF8ASpWdTlF9akqqQ
	kV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJex79QJ9oKfHBV3Npxj
	a2BcyN7FyMkhIWAicebOcuYuRi4OIYGljBKLdjcwQyRkJE5Oa2CFsIUl/lzrYoMoes8o8bp5
	OVgRr4CdxO6fW8BsFgFVidtb/7NCxAUlTs58wgJiiwrIS9y/NQNsm7CAk8TO25sYuxg5OEQE
	DCQez4kCCTMLZEm0fWsHaxUSmMAoMfNkBERcXOLWk/lMIDabgKFE11uQGzg5OAVsJXZ+msQO
	UWMm0bW1ixHClpfY/nYO8wRGoVlIrpiFZNQsJC2zkLQsYGRZxSiSWlqcm55bbKhXnJhbXJqX
	rpecn7uJERhd24793LyDcd6rj3qHGJk4GA8xSnAwK4nw/nJjzxDiTUmsrEotyo8vKs1JLT7E
	aAoMionMUqLJ+cD4ziuJNzQzMDU0MbM0MLU0M1YS53W7fD5NSCA9sSQ1OzW1ILUIpo+Jg1Oq
	gcn3wlvHW0f2/9YtfTqVb1+PlbrXh6qqN7MTT5Xx/n142zjvrH5pCzP37Y77EetTL1+X+JGk
	1u102OJE5fQZEan2Lo07fmqsm1SaK6Zs/WLmvM41jt7acQfjPj1u++BwpWrSXKuJ4s9EffRE
	+itWd9WXHpbWCUtdeKnuZPeKWZcPvLknG+lxVOd5mOjehQxHg0JDem+/ennu56aueU+t3gsJ
	/e7fxRK2Ujdd97+ez6KnXGcv5WcUZ/1xuCbf9ZUh/vLRA5/bL2gyeZ5c2MExy2pKX2nvjPAD
	+3g433tPfadur3DdsSPabKF0bZNCibMhR6b6O7vn+X7Kq00uLHvZGnn8aajehZXTFYq3NYdY
	/lRiKc5INNRiLipOBACB7cwGNwMAAA==
X-CMS-MailID: 20250422133617eucas1p2c3b7b2e53d897ca7a89753ca02d32765
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250422063734eucas1p2561ad6f847f6824c9c79a842fa458e41
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250422063734eucas1p2561ad6f847f6824c9c79a842fa458e41
References: <CGME20250422063734eucas1p2561ad6f847f6824c9c79a842fa458e41@eucas1p2.samsung.com>
	<20250422063719.121636-1-huaqian.li@siemens.com>

On 22.04.2025 08:37, huaqian.li@siemens.com wrote:
> From: Li Hua Qian <huaqian.li@siemens.com>
>
> This patchset introduces a change to make the IO_TLB_SEGSIZE parameter
> configurable via a new kernel configuration option (CONFIG_SWIOTLB_SEGSIZE).
>
> In certain applications, the default value of IO_TLB_SEGSIZE (128) may
> not be sufficient for memory allocation, leading to runtime errors. By
> making this parameter configurable, users can adjust the segment size to
> better suit their specific use cases, improving flexibility and system
> stability.

Could You elaborate a bit more what are those certain applications that 
require increasing IO_TLB_SEGSIZE? I'm not against it, but such change 
should be well justified and described, while the above cover-letter 
doesn't provide anything more than is written in the patch description.


> Li Hua Qian (1):
>    swiotlb: Make IO_TLB_SEGSIZE configurable
>
>   include/linux/swiotlb.h | 2 +-
>   kernel/dma/Kconfig      | 7 +++++++
>   2 files changed, 8 insertions(+), 1 deletion(-)
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

