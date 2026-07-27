Received: from va-2-58.ptr.blmpb.com (va-2-58.ptr.blmpb.com [209.127.231.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A7E1DDC2B
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 04:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785127755; cv=none; b=R8+eXLkGKHKjn8bwq3e2SSosowW77HEFQVa/pn59hx+rkLYyaYoLbvZ3OOsnmGOfgMXZTYbWchUbob3OmFFYIH2+dxZjOvIXmJ0utPXng2HefdJGWwtunZYr0cuYsezVZddtd1z9tFMYmcdngdOCC54iOoTDExGzI/IjupBjvSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785127755; c=relaxed/simple;
	bh=bosi303J/1xROua7AGX1Zbk0sxcAKHSS+26vo7khsTg=;
	h=Cc:From:Date:References:Subject:To:Mime-Version:Content-Type:
	 Message-Id:In-Reply-To; b=jJMLfDtRJg+xk2bOmgEXWeo/9fq9AQRwAqo3vRLShA3jrKN13gVsDw8HxZ7QDB4LAYQrROe8SunuuJsdX+Y63wGv4wFB2Olonj0kjQCttQdNAgau1F955Ooo4NnNwZU7tEQuUWQoa7sGw1H4SaDu8RvfuRC4FzV4asuIsF0N044=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=liuxiaozhen.dev; spf=pass smtp.mailfrom=liuxiaozhen.dev; dkim=pass (2048-bit key) header.d=liuxiaozhen.dev header.i=@liuxiaozhen.dev header.b=vCGAELQc; arc=none smtp.client-ip=209.127.231.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=liuxiaozhen.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=liuxiaozhen.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=liuxiaozhen.dev header.i=@liuxiaozhen.dev header.b="vCGAELQc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2602171341; d=liuxiaozhen.dev; t=1785127747;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=Q4Nlg3BDUHmTSZuUXvp8ZoQ+dUYLZaAIfzWj7FXIn/s=;
 b=vCGAELQcwUlrrz5TyxsF9jGJ23nBmzUjcLgxX0leL42T/8pZ7WS5ouAuoMohBHSTXBNGTi
 xUhqHGHOgW7KC8cu6RQooF0XqEg+uDy7nWeeiL0txJ/hJnBnOVG52Z/drw2PRl3yBp1Ti1
 pSxUI4lblTQvt9p5n570kT1gvR4Fg2sJxiaLReDaHEW5wqShgPy+X2ylqU9bhga3zeHqbs
 8B9eKLZJ4LyeARlK8BLUvFzHqO33St9i49N7cWMhg65E61mIlWUtuSc8BxWKjc9OVDhJYV
 fwqeZdyBV2IfiykKEEkahzcfO/up6xYTejtq6mkKmeRySpwzoxt60LVrsxGIFQ==
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"joro@8bytes.org" <joro@8bytes.org>, 
	"robin.murphy@arm.com" <robin.murphy@arm.com>, 
	"will@kernel.org" <will@kernel.org>
From: "Oliver Lin" <oliver@liuxiaozhen.dev>
Date: Mon, 27 Jul 2026 12:48:49 +0800
X-Lms-Return-Path: <lba+26a66e341+1c7bde+lists.linux.dev+oliver@liuxiaozhen.dev>
Content-Transfer-Encoding: 7bit
References: <b744ef83-6cab-4f4f-a22a-251e08b62656@linux.intel.com> <20260703092348.17583-1-oliver@liuxiaozhen.dev> <775d3d16-f43d-4a5f-9629-4912a4cabd91@linux.intel.com> <0c9256b0-19ad-4d1d-baea-0ccd3b827d0f@liuxiaozhen.dev> <CO1PR11MB48354FC225C295EFC745EEF48CCC2@CO1PR11MB4835.namprd11.prod.outlook.com> <19be3c19-9711-4cac-bc6e-c2b020588ec8@liuxiaozhen.dev> <CO1PR11MB4835CB1B5633DD1E4F1011428CCC2@CO1PR11MB4835.namprd11.prod.outlook.com>
Subject: Re: [PATCH v3] iommu/vt-d: Disable IOMMU by default on Lenovo ThinkPad P50s
User-Agent: Mozilla Thunderbird
Received: from [172.16.0.2] ([104.28.165.131]) by smtp.feishu.cn with ESMTPS; Mon, 27 Jul 2026 12:49:04 +0800
X-Original-From: Oliver Lin <oliver@liuxiaozhen.dev>
To: "Tian,  Kevin" <kevin.tian@intel.com>, 
	"Baolu Lu" <baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Message-Id: <7017b26c-7384-470c-bf8b-38b667c7d7cc@liuxiaozhen.dev>
In-Reply-To: <CO1PR11MB4835CB1B5633DD1E4F1011428CCC2@CO1PR11MB4835.namprd11.prod.outlook.com>

On 27/07/2026 12:03, Tian, Kevin wrote:
> If it's confirmed to be a hardware issue, it should be (or will be) documented
> as an VT-d erratum. Then a quirk could be added accordingly.
>
> If Lenovo confirms to be a firmware issue, then they should release a new
> firmware version to fix it. It doesn't justify a quirk in iommu driver.
>
> and it is not about a policy "whether this issue should be *treated* as...".
> It needs a root cause first.


Hi Kevin,

I performed additional investigation on the DMA fault.

With intel_iommu enabled:

DMAR: [DMA Read NO_PASID] Request device [0000:00:12.4] fault addr 
0xb7fff000 [fault reason 0x02] Present bit in context entry is clear

However, requester ID 0000:00:12.4 does not appear in PCI enumeration:

- `lspci -nn -s 00:12.4` returns no output
- `lspci -xxxx -s 00:12.0` through `00:12.4` all return no device
- `/sys/bus/pci/devices/` contains no matching entry

I also checked the firmware-provided ACPI DMAR table. It contains scopes 
for 00:02.0 and 00:14.0, but no scope for 00:12.4.

Could this requester ID correspond to an internal platform device, or 
does this suggest a firmware/platform issue?

Thanks.
