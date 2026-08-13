Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE07E40F730
	for <iommu@lists.linux.dev>; Thu, 13 Aug 2026 06:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786602270; cv=none; b=Hv39WZmbO75YbCrCDIQJ8as2TMEIzIeuA5mAYqlvDF0dVRfU3f0cKWifNPt5/bbWaGe+wGo+B5I1Fh+Zx2WX/KH/sHrEDxQbyJMiWssNTkZ0y/cfAKTSUaGePTwVtgg6WZn7uVi+WhPYlC0JAc/X8o16JQsWs0YgXML4X2zMwTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786602270; c=relaxed/simple;
	bh=UiP03CJmjkmWMctzzihF/O9EmbvM7WIvizStDhaor9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=U1T8ZhW7JX40K1udhDW0RP55qCruK9pS3BABKduRMO51wlr23JoqF6ifjJi7wd1Avrt+kSPvz+Guvi98rDz7dxQckj646zkh9B0EpWXCXSnvxoUlNU74jIYBZnf/iMba4v7V7Li4b6xqE3lyo6xx25bRn5iUq0K0KMjpyNDeIjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=NesKuhV9; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NesKuhV9"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260813062420euoutp018f03b593de2c9fed4e7a43cdceff993b~LSUozA1lB1271312713euoutp016
	for <iommu@lists.linux.dev>; Thu, 13 Aug 2026 06:24:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260813062420euoutp018f03b593de2c9fed4e7a43cdceff993b~LSUozA1lB1271312713euoutp016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1786602260;
	bh=8p2W7UcfXM7X7i/OFCIRFmQXF7gASU5GQw1G6zGcJyM=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=NesKuhV9zto9z9Q7hNwwSJdElqlfz1WYFCUuPhr6BP1aTl5bOC12lO8SuNy23wkBD
	 hn9fHRBoUzDWI5DwsRKlIcQy5iU56ySXurl2yzij+jvGrxQ4bsE1cM/eWN8zzFF3kw
	 PAagWtksyCm5ELa08xZhEjrh+YUndMmVq9na3ET0=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260813062419eucas1p18fe4dc15baf1b052812c6cedb2210ff6~LSUoicpeE2965529655eucas1p1y;
	Thu, 13 Aug 2026 06:24:19 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260813062418eusmtip17804ebe02573fc6bf700e1bea751127c~LSUnS0pLt0282702827eusmtip1g;
	Thu, 13 Aug 2026 06:24:18 +0000 (GMT)
Message-ID: <a35cc67e-5949-4916-8e4c-ea452b2faad4@samsung.com>
Date: Thu, 13 Aug 2026 08:24:18 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v4] dma/swiotlb: decouple high watermark tracking from
 CONFIG_DEBUG_FS
To: Michael Kelley <mhklinux@outlook.com>, Frank Chen
	<frankchen158@126.com>, "hch@lst.de" <hch@lst.de>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "fan.du@intel.com"
	<fan.du@intel.com>, "jun.miao@intel.com" <jun.miao@intel.com>,
	"chenhgs@chinatelecom.cn" <chenhgs@chinatelecom.cn>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <SN6PR02MB4157EA729E64A69A5F41427DD4DC2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260813062419eucas1p18fe4dc15baf1b052812c6cedb2210ff6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260812150132eucas1p1d590a099c084f777127e83267aef3964
X-EPHeader: CA
X-CMS-RootMailID: 20260812150132eucas1p1d590a099c084f777127e83267aef3964
References: <20260622122114.2563254-1-jun.miao@intel.com>
	<20260812070459.637077-1-frankchen158@126.com>
	<CGME20260812150132eucas1p1d590a099c084f777127e83267aef3964@eucas1p1.samsung.com>
	<SN6PR02MB4157EA729E64A69A5F41427DD4DC2@SN6PR02MB4157.namprd02.prod.outlook.com>

On 12.08.2026 17:01, Michael Kelley wrote:
> From: Frank Chen <frankchen158@126.com> Sent: Wednesday, August 12, 2026 12:05 AM
>> From: chenhuguanshen <chenhgs@chinatelecom.cn>
>>
>> Under heavy concurrent DMA traffic on CoCo VMs, inc_used_and_hiwater()
>> performs an atomic_long_add_return() plus a CAS loop on the global
>> used_hiwater, and dec_used() performs an atomic_long_sub() on total_used.
>> All CPUs contend on the same cacheline, causing measurable throughput
>> degradation at scale.
>>
>> Historically these counters were only compiled in under CONFIG_DEBUG_FS,
>> which means production kernels with debugfs paid the atomic overhead
>> unconditionally. Make the tracking boot-time opt-in instead so that it
>> is disabled by default with near-zero overhead via static_call, and can
>> be enabled via "swiotlb=track_hiwater" parameter on demand for debugging.
>>
>> Note that when CONFIG_DEBUG_FS is enabled but hiwater tracking is disabled,
>> the "io_tlb_used" metric reports an approximate value rather than an
>> instantaneously exact one.
>>
>> Suggested-by: Fan Du <fan.du@intel.com>
>> Signed-off-by: Jun Miao <jun.miao@intel.com>
>> Co-developed-by: Fan Du <fan.du@intel.com>
>> Signed-off-by: Fan Du <fan.du@intel.com>
>> Tested-by: chenhuguanshen <chenhgs@chinatelecom.cn>
>> Signed-off-by: chenhuguanshen <chenhgs@chinatelecom.cn>
>>
>> ---
>> v1 -> v2:
>>  - Change the patch title.
>>  - Doing the exact hiwater calculation is dynamic and defaults to "off",
>>    dynamic config would replace being under #ifdef CONFIG_DEBUG_FS
>>  - The mechanism used for dynamic config needs to be one that is selectable
>>    on the kernel boot line so that the exact hiwater mark during boot is
>>    easily available.
>>
>> v2 -> v3:
>>  - When track_hiwater is enabled, we keep the original precise hiwater
>>    calculation backed by the global total_used atomic counter. If disabled,
>>    we switch to the approximate approach that sums per-area counters to
>>    derive the total used slot count.
>>
>> v3 -> v4:
>>  - Change commit message and documentation.
> LGTM.
>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com> 

Applied to dma-mapping-for-next, thanks!

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

