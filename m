Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369DE4483B3
	for <iommu@lists.linux.dev>; Thu,  6 Aug 2026 11:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015779; cv=none; b=O+yKDwcqsQrYxVHb30h+toAx+nS/mWANe3EjMnKsKV2JnXDLWIyt6tIxY46D1qu+YFLkxWCWTjAqPJ8xRJci2c/fL5RYAq2AhSe+k0CDX3QGsykwsONPe6d10+eIyatU9CeEPyeMzO1Qow9dDwKepNLYg6P9BQpbylMorjgBcKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015779; c=relaxed/simple;
	bh=AGagm4CCkID0tldTCSY37wN+9c/qS5MOvXIumu0iezA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=oXYnvdrYwcgTFmscitAjtdxzXL077ISAV2fntFCSqNvDmcZEOhvnpvrFlUg48AhnnTUK+7MIiZrmBCenIFJjprylGxSIeTRkD2rxA0fayyhl8EGFgCUnsKqK4teiJp92EP6Y8bw52i1yeomkFmVjRT1zJZdFwhoGxHFAOToOyRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=n5qLcXtu; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="n5qLcXtu"
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
	s=key1; t=1786015764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=felpSIkdk6QTqa6eAv8dEuh25mt0u+aADh0BF20qvVM=;
	b=n5qLcXtuXkYS0rpKRIbv02qJcUNngkhYcwZ+ntbyiLi6oT4MFMB/tSYI22gM1bCcPjLurC
	Zn6BgtaMWwJZFCw4KIuyeZo/8ASpSMkf2Z2ShjDCf6Hc0Om2dY2i7YWOI40p392WwQ9MiC
	SnXxX2r8bzVcxujq/SfpnXPHLyk8BdXtqxvVFu4XzDztHc3de/8uQTIafYp0cG3I581rsl
	0U5XROAavYc4dyiTKLNT+89IdGZDTpd/sMfA+evf3NDV2/8zDae95uBwq8B4IYiCdioJ7a
	5htupH3TR1kTzVm9e3SDexfmZmjnWRxEL2mcy3GKhSPQvwPayzPRUONxIJ7+Iw==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Aug 2026 13:29:05 +0200
Message-Id: <DKHTQQEWO6S1.1IKS244AQ1263@cknow-tech.com>
Cc: <royalnet026@gmail.com>, <alchark@flipper.net>,
 <chaoyi.chen@rock-chips.com>, <iommu@lists.linux.dev>,
 <linux-rockchip@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v6 3/9] dt-bindings: iommu: rockchip: allow the
 RK3576 NPU MMU clock set
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: "Jiaxing Hu" <gahing@gahingwoo.com>, <diederik@cknow-tech.com>,
 <heiko@sntech.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <joro@8bytes.org>, <will@kernel.org>,
 <robin.murphy@arm.com>, <tomeu@tomeuvizoso.net>
References: <20260806063413.350184-1-gahing@gahingwoo.com>
 <20260806063413.350184-4-gahing@gahingwoo.com>
 <DKHR2P0XJF0B.OY937NT39DR7@cknow-tech.com>
 <20260806095551.368456-1-gahing@gahingwoo.com>
In-Reply-To: <20260806095551.368456-1-gahing@gahingwoo.com>
X-Migadu-Flow: FLOW_OUT

Hi Jiaxing,

On Thu Aug 6, 2026 at 11:55 AM CEST, Jiaxing Hu wrote:
> Hi Diederik,
>
>> Now every MMU with "rockchip,rk3568-iommu", "rockchip,rk3588-iommu" or
>> "rockchip,rk3576-iommu" is allowed to have a minimum of 2 clocks, instea=
d
>> of having exactly 2 clocks. That does not sound desirable.
>
> You are right, and it is worse than sounding undesirable, it actually

Yeah, it was a 'bit' of an understatement ;-)

> happens. I gave an RK3588 NPU MMU a bogus third clock and v6's schema
> accepted it without a word. That is a real loss of coverage for every
> existing Rockchip IOMMU and I should not have sent it that way.
>
> Fixed for v7 the way you and the bot suggest, with a compatible of its
> own:

If you haven't already, it's probably worth checking whether Sashiko made
other useful remarks. I don't feel qualified to judge those, so I didn't
reference those. But they made be valid as well. Or hallucinations ;-)

>   compatible =3D "rockchip,rk3576-npu-iommu", "rockchip,rk3568-iommu";
>
> and an allOf that pins each side:
>
>   if compatible contains rockchip,rk3576-npu-iommu
>     then clocks/clock-names minItems: 5
>     else clocks/clock-names maxItems: 2
>
> so the NPU MMUs are required to carry all five and everything else is
> back to exactly two. Checked in both directions: the three clock RK3588
> node is rejected again, an NPU MMU with only aclk and iface is rejected,
> and every rockchip dtb in the tree validates clean.
>
> No driver change goes with it. rk_iommu matches only "rockchip,iommu"
> and "rockchip,rk3568-iommu", and the fallback stays, so the new string
> is documentation only.

I'll leave it up to others to comment whether that's correct or not.

Another thing you could consider is splitting this NPU iommu 'stuff' into
a separate patch set and drop the RFC 'prefix' for that series.
IIUC the RFC is (only) related to the working of the NPU on RK3576.

Cheers,
  Diederik

> The name is the part I am least sure of. Everything else in that binding
> ends in -iommu, which is why I did not use -mmu to pair with the
> rknn-core node it belongs to. Happy to change it if Heiko or Krzysztof
> prefer something else.
>
> Thanks for catching it.
>
> Cheers,
> Jiaxing
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


