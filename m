Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D25821CA0A
	for <iommu@lists.linux.dev>; Mon, 21 Jul 2025 11:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753096477; cv=pass; b=CqtyIGIDVe2UXR3cdFyRuvljGNek3P+rvD56eJeiW8ALsHjtJ3hko7qokkxn28aHPTymc8sMC2e1Q1K7r4dtpYcpwXr5MI9LbOykaXGAy5oJ/Y8W/C4OY10Vo9DgoHxaDZCFrHZEY8KIFXpsPb5ndKdX0ifTy+CHFPdy26zCgLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753096477; c=relaxed/simple;
	bh=apcXxEnb0qJg1v9Cl7JQ6npH3CzfQYbUnRtZrZ2JRQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jmuDXA5FmBeNUl4Y8K4RjGhqZFBdCa8VqkIo0dJy8jDmk+s/ffwHCDKcsrrw+YjgR1FQMLoE+i/BbEgq+P8PtcYGWG+zJH/xsVq+OX/dh4lMjYos5nPX9r6j1f+dPnykVwpnpWRS7jiyEw/0lOarSGHeUSajzay/0ZPNKX6f8T0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=benjamin.gaignard@collabora.com header.b=Ng8qHnwK; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=benjamin.gaignard@collabora.com header.b="Ng8qHnwK"
ARC-Seal: i=1; a=rsa-sha256; t=1753096461; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jYDbMhT8vW1zZ55sI4R7g1B58Oih9oqWj6/OHCkN7i3soW0oBjrysLGZCIOIwKpbi/S4R9R6I9DzaB3/a/jfCHc0jge426lJOeXddipzWya2vUv9BJR51q/V5Ym2hd6Xn9XhbIccR0vCC1hhPJZp8pixppyUATKFwpUQMuTxQx4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753096461; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=apcXxEnb0qJg1v9Cl7JQ6npH3CzfQYbUnRtZrZ2JRQo=; 
	b=DtIObIS9tuE0ada0VjeUzVrB6+WAlE06f1oeU6I4KkV87vFL40WUPjQkWn0Qvkk+z/tZ+6ikJFy0J8KzcQ5xIFLHApyCEqyFnQQKMzI3t6NyqUtKahukCqEiCOiFghfwduWM2LKZhq6e47wNS9VpVwcFtxfkHF+Am+V/Z49XFrg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=benjamin.gaignard@collabora.com;
	dmarc=pass header.from=<benjamin.gaignard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753096461;
	s=zohomail; d=collabora.com; i=benjamin.gaignard@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=apcXxEnb0qJg1v9Cl7JQ6npH3CzfQYbUnRtZrZ2JRQo=;
	b=Ng8qHnwKp0kseIgsBGNF47L3UKdRF5Gn/rEgrTYuEvTl8P3sWznvC3DDRjddwmj/
	MrPA+UxXE8ZA3+nMRDuFpZDlOLPlg8RZ57XhLM8Pjv+PN+NFaBihL/2tuYAEDBCTEsB
	N3aDH1R05bBv2dMGMnp79lTpx9sLG7SNaiWUlAz4=
Received: by mx.zohomail.com with SMTPS id 1753096458959568.7003735740404;
	Mon, 21 Jul 2025 04:14:18 -0700 (PDT)
Message-ID: <e96b1d2f-bff8-4b79-9995-6929648a810b@collabora.com>
Date: Mon, 21 Jul 2025 13:14:14 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] iommu: Add verisilicon IOMMU driver
To: Jason Gunthorpe <jgg@ziepe.ca>, Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
 nicolas.dufresne@collabora.com, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 kernel@collabora.com
References: <20250710082450.125585-1-benjamin.gaignard@collabora.com>
 <20250710082450.125585-4-benjamin.gaignard@collabora.com>
 <aHTzPwTob8_5rtBS@willie-the-truck>
 <baa1fcde-f167-4a1b-afca-0a2957a688cc@collabora.com>
 <aHozv0NG1OBlAH6c@willie-the-truck>
 <b4169471-fcd0-4415-8281-c5bd722e5f2b@arm.com>
 <aHpQXy-bnwW56rCn@willie-the-truck> <20250718141401.GD2206214@ziepe.ca>
Content-Language: en-US
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <20250718141401.GD2206214@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 18/07/2025 à 16:14, Jason Gunthorpe a écrit :
> On Fri, Jul 18, 2025 at 02:47:11PM +0100, Will Deacon wrote:
>
>> Just because the existing drivers are a mess doesn't mean we should
>> proliferate it!
> If you want to insist on something here it should be for this driver
> to use the new generic page table code I've written.
>
> Otherwise I don't see the point in trying to improve this in some
> lesser way.
>
> If this had come in a years time I would probably insist on that, but
> right now it isn't merged yet and it will still be a little bit before
> people have time to review it.
>
> Perhaps a compromise where Benjamin comes with an iommupt format
> header that works for this and we can progress this series and be
> ready to swap it out down the road?

I have take some time to try to understand this new framework and I have
to admit it isn't super clear in my mind how to use it right now.
I don't have catch the benefit behind the macro and the nested structures.

Anyway, if VSI driver need to be updated I could, at least, validate the
changes on my board or make the fix make self (but I will need to see
more example of drivers using this new feature.

Benjamin

>
> Jason
