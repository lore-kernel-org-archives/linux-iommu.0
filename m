Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAF027707;
	Tue, 16 Jun 2026 00:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781569537; cv=none; b=VdRFxLAsavt0G/4QCOUjESNNjpNoS7Ilsbti56hvUGIzBC+nGXCwEmKBF4Y5uQG1yhy5WafmwhZ3wzODqZ3sg3ZHPvD6NijkU3nNMpyLq+BsuGg7EJtrt9J5eO23SuE0TaaD0MTjgPdMTm69rtyWGz4HUosf3KA5Dda3H9fQ9Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781569537; c=relaxed/simple;
	bh=CWFSTFYTiBH76MJ3gjOj6t9+K4Ep3BVEdPwrbvarmng=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DH9VVYKrKTMPV6K6UEZpQnkjUn6WNKkpsxLyvT/j6sNrjwEsJFJRB5zHezzyhwRVqLVyoN55TjVYNTN2Tw0qXPkslziiTkP8LOT6CZXLJzVTnibq2j+sGV8uI3iaXFgYgfLgiGOze3KzBdTAM5ZHEh0vDMaR4TGjvNjzfuHq6z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YD2garaE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YD2garaE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D211F000E9;
	Tue, 16 Jun 2026 00:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781569536;
	bh=hH9/51g//fMBZa4WquaIwRZMdG5lN0iHPMy6YWWkEkY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YD2garaEL559AP5FR7kdfCzIspY2D6tCIEctRlILjopg10F0/GTT+kDRVQgKPNi4i
	 jOlOMhi15o646GxtKpw9p7pQgqrnlLwIHsb0IMt+9MGV0PBbZzUNCiRmRInpXpfJ2u
	 /Qev49XJSvZwsrO6EVbpH64sHbbEkzDu/NlfrK+nMzqJUuLfKYdFKj6cyaigGrIdax
	 RSPiK5jWhzmxwddBDsu69spWt5R4BnX4+emEvw5PAZXMADovD0nxMIdor0Xkxcy9mV
	 rI5Ic367l98uI0FcSWn7K98eh/GbqGxjvPq3W8SZmWVnQrOLS4Hwxsi+DqaGMbjuaO
	 e3v3HJXZKXDSw==
Date: Mon, 15 Jun 2026 17:25:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luigi Rizzo <lrizzo@google.com>
Cc: rizzo.unipi@gmail.com, m.szyprowski@samsung.com, robin.murphy@arm.com,
 willemb@google.com, kuniyu@google.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, gregkh@linuxfoundation.org,
 rafael@kernel.org, akpm@linux-foundation.org, david@kernel.org,
 netdev@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux.dev,
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swiotlb: avoid double copy with swiotlb on tx socket
Message-ID: <20260615172535.080cf94f@kernel.org>
In-Reply-To: <20260615234220.3946885-1-lrizzo@google.com>
References: <20260615234220.3946885-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jun 2026 23:42:20 +0000 Luigi Rizzo wrote:
> The use of swiotlb causes an extra data copy on I/O.  For tx sockets,
> especially with greedy senders, this has a high chance of happening in
> the softirq handler for tx network interrupts, creating a significant
> performance bottleneck.

What's the use case? I associate swiotlb with debug / testing mostly,
so it'd be useful for people like me to explain why you care.

BTW net-next is closed: https://netdev.bots.linux.dev/net-next.html
