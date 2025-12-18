Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DF2286D7E
	for <iommu@lists.linux.dev>; Thu, 18 Dec 2025 09:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766051745; cv=none; b=S4ar8Wbl4i7zriUYSJsB73rjin5oX+2ZjEM6BBIJtFd7YLJrpiF7EB/FYqCEH/w3MKnOfTJbmI+Srt53W2ha32v1l1m0LuYli6JuNliY4gw87IX3st/RiiylI0Jwbh/9bFVzRuRa9gpqDeC3NNlL79C6kMSRxw+Tp306VaeX708=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766051745; c=relaxed/simple;
	bh=O/EDAEC7PTsvd+iT1GULzhYfUKmQ+wrOGzrHzgoRFz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=PNO2kN0bj+IVcdnhpWnaECFO6ipOuujlst4AL1e86lQDj83r4WTErusG4UgeK10Wq2SAq+5CKoIJZpAbavNYdfVGxNeYgCL+ERQSOTVUhVEKMI1kLB+9qgfAkxzeGaY6nB3pVsSA3ba0Y82nraKp3DwZR06Khtdzs5ysFHesvFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=vf+N+HZy; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vf+N+HZy"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251218095541euoutp028e0ffadd1d1903193170516c17673843~CRrO_bwdN1648916489euoutp02N
	for <iommu@lists.linux.dev>; Thu, 18 Dec 2025 09:55:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251218095541euoutp028e0ffadd1d1903193170516c17673843~CRrO_bwdN1648916489euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1766051741;
	bh=d+zvG+8e11n24pJutZahktO9rCuNJt6S0wGRGf9V6C8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=vf+N+HZyDAEGEWfu9J9gaf5Bj8YdEQ0Eo1YJM42hBxIqalmnJHaFk4r1miBih2b6+
	 oDDzqFXu90kFDpGbSMxXRpc3yf7AffyTPEtVfr4nWdX/3QKLoVd3nB+ElIsJzFI2Qi
	 pnFdGYVUHE4/VxIMhM3iPyAEwMMs/7bUgrHkze/k=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20251218095541eucas1p158c5660f096a107393085fe89f5bdd6d~CRrOeW8ch1259512595eucas1p16;
	Thu, 18 Dec 2025 09:55:41 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251218095539eusmtip2689dadc5b8a592c5508b1a1b9a94aaf1~CRrMzcUAy0481204812eusmtip2N;
	Thu, 18 Dec 2025 09:55:39 +0000 (GMT)
Message-ID: <99dc91c9-59fd-47c5-b1d9-157bda86ad59@samsung.com>
Date: Thu, 18 Dec 2025 10:55:38 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] of: reserved_mem: Allow reserved_mem framework detect
 "cma=" kernel param
To: Rob Herring <robh@kernel.org>, Oreoluwa Babatunde
	<oreoluwa.babatunde@oss.qualcomm.com>
Cc: ye.li@oss.nxp.com, kernel@oss.qualcomm.com, saravanak@google.com,
	akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
	mhocko@suse.com, robin.murphy@arm.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux.dev,
	quic_c_gdjako@quicinc.com
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <X-TH#1.CAL_JsqL6VVQ7K_ZAbHJ8Gb7ei_jusLx6wRn=AdOVgV50dX0ejQ@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251218095541eucas1p158c5660f096a107393085fe89f5bdd6d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251210002053eucas1p1d1408ad0fb49a49bf4371687f8df7395
X-EPHeader: CA
X-CMS-RootMailID: 20251210002053eucas1p1d1408ad0fb49a49bf4371687f8df7395
References: <CGME20251210002053eucas1p1d1408ad0fb49a49bf4371687f8df7395@eucas1p1.samsung.com>
	<20251210002027.1171519-1-oreoluwa.babatunde@oss.qualcomm.com>
	<X-TH#1.CAL_JsqL6VVQ7K_ZAbHJ8Gb7ei_jusLx6wRn=AdOVgV50dX0ejQ@mail.gmail.com>

On 10.12.2025 15:07, Rob Herring wrote:
> On Tue, Dec 9, 2025 at 6:20 PM Oreoluwa Babatunde
> <oreoluwa.babatunde@oss.qualcomm.com> wrote:
>> When initializing the default cma region, the "cma=" kernel parameter
>> takes priority over a DT defined linux,cma-default region. Hence, give
>> the reserved_mem framework the ability to detect this so that the DT
>> defined cma region can skip initialization accordingly.
> Please explain here why this is a new problem. Presumably the
> RESERVEDMEM_OF_DECLARE hook after commit xxxx gets called before the
> early_param hook. And why is it now earlier?
>
> I don't really like the state/ordering having to be worried about in 2 places.

I also don't like this spaghetti, but it originates from 
commit 8a6e02d0c00e ("of: reserved_mem: Restructure how the reserved 
memory regions are processed") and the first fixup for it: 2c223f7239f3 
("of: reserved_mem: Restructure call site for 
dma_contiguous_early_fixup()").

It looks that it is really hard to make reserved memory 
initialization fully dynamic assuming that the cma related fixups have 
to be known before populating kernel memory pages tables. I also advised 
in 
https://lore.kernel.org/all/be70bdc4-bddd-4afe-8574-7e0889fd381c@samsung.com/ 
to simply increase the size of the static table to make it large enough for the sane use cases, but 
it turned out that this approach was already discussed and rejected:
https://lore.kernel.org/all/1650488954-26662-1-git-send-email-quic_pdaly@quicinc.com/

Maybe it would make sense to revert the mentioned changes and get back 
to such simple approach - to make the size of the static table 
configurable in the Kconfig?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

