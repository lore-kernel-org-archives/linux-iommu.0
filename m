Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794861867;
	b=Gbg/nZ9i3x4VfKrjf8eLBjWhAbGi/wTovathAEY9Tnzud+9Tb2BZO5kNYhwEIF6hxvww
	 HsW5geJTMP0cxsP7O85ss6YGuHMVnOR7ELOeczVzPvGJfjxtWHpglEKfkrnVk9m2D4ktm
	 7hvtxxV4gVCzWZE+mtfR+3NrUK103Y7U5lIsFkCsj8RvSogAV/DDiF4UJX+9UDQMTYxwo
	 6uVwWF3ejnSCy6OFoRapRoSz6XAtZEk3nyDim5Q8CsljqvG5360N7xINnSZGZQcb6MzJt
	 n5XykA623FBYKP6WJiF70TZZ1UDIchnpIsOx/U15e44FWYLGF7hYxRoAFkq62Tx0bqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794861867;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=nKc5G/1xaQZOV1LcZtFARpXT6SWD8nwrvFi9/HTR3pE=;
	b=TMlRLE2RPrcpurAKFkNiIrNipYwlM7yhDwTrqWUO9dEkzt0y+2NKvsNKdpNOJGdXWKBr
	 xaFmsgGzNUKcdbYI4a6pHSf72eOqwcVq/tjwxj3Pfq0x+NBiammgrm2Rd+aNK8VxBhhBY
	 YUzpGAfu6uW89H3vDyIZDgzmeyG0mEf9G7c2fX4apETpBo701BgOFtl+kjcIlq6fUwn4S
	 YrY3fTlWjHjqExp3au9XgjnRlgC7zb/j78Qbxb/qa8i34PTMFzmgzj+7lVCVWSJZtKhl4
	 3B5eXpBFSyZvX1PRP5jKFx1H5vh/tE6JNIi21C1Ydblc9NxH71nyJA+0oxsda1dklkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GgPO669F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2E8606A890
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 20:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GgPO669F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA631F000C5
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 20:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794861867;
	bh=nKc5G/1xaQZOV1LcZtFARpXT6SWD8nwrvFi9/HTR3pE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GgPO669F+6Q78oAUnYa4swm/iHTeTd41FDQSdpieCnTH7ZmnxvF+peJRnYtEVMRYU
	 LSvlooM6hhWHCjRAozSKCuECsRYUMiZ5RnvJW4L7U7fTdb/Pv4dNty4LBF3hoiqzGy
	 7MBlgCKjRtpzSGzJPvi8K08uAIEzvAwWHMyaMpPwAYv2Mia/kXtvGNCdVqibk4lBNI
	 UZ5g2sqdBRkUBlypcCxrorsaWQUYt4pQY4I4nqQtSoD9rd36cleBhz7CGILDNMYk/w
	 DOxbSExEZZDTjksv8AcsMhAHYnFYxzAb7Ony6/hjoM6mTfF5PlhySe2USTfrQwbFtX
	 xQ6S8nyTox5IA==
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-930c0f9c1b1so477205185a.1
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 12:44:27 -0800 (PST)
X-Gm-Message-State: APuU4Z9J4vPDucl9xzArgxz1d5GMXcq2eRzXo+BKPFEc58nAuqYyfCiK
	9Ny7EZ2KAjaxynk9ngZzPxAvpYPvKw/vB+VR5Vs6GvbOs+d8Z/pWuLTrEK6Sohojfa83kgasjjU
	D+ASlaKw24Z8IfJIf6P4bcRwWQjx7KxY=
X-Received: by 2002:a05:620a:84c9:b0:93b:c58c:d3be with SMTP id
 af79cd13be357-9494bbdd060mr1720208385a.37.1794861866533; Mon, 16 Nov 2026
 12:44:26 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261116161152.43462-1-zenghui.yu@linux.dev>
In-Reply-To: <20261116161152.43462-1-zenghui.yu@linux.dev>
From: Barry Song <baohua@kernel.org>
Date: Tue, 17 Nov 2026 04:44:15 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zSivK4+9O+p4y4ryTCGDq=6NPQADkzF=bar39B2DH-ow@mail.gmail.com>
X-Gm-Features: AclHuK_vVu-E96xNOYABxmCmitxnUjBDNW7tN9MQ5G5xKeurtqGlpIXQ7B-j2Rg
Message-ID: <CAGsJ_4zSivK4+9O+p4y4ryTCGDq=6NPQADkzF=bar39B2DH-ow@mail.gmail.com>
Subject: Re: [PATCH] dma-mapping: fix stale path to dma_map_benchmark in Kconfig
To: Zenghui Yu <zenghui.yu@linux.dev>
Cc: iommu@lists.linux.dev, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	xiaqinxin@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 12:12=E2=80=AFAM Zenghui Yu <zenghui.yu@linux.dev> =
wrote:
>
> The dma_map_benchmark test was moved from tools/testing/selftests/dma/ to
> tools/dma/ in commit f74ee32963f1 ("tools/dma: move dma_map_benchmark fro=
m
> selftests to tools/dma"), but the DMA_MAP_BENCHMARK help text still refer=
s
> to the old path. Update it.
>
> Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>

Acked-by: Barry Song <baohua@kernel.org>
