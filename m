Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E483C2762;
	Mon, 11 May 2026 16:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515841; cv=none; b=DpC6AaajrFrZre5uqi9ms/A5vQpTuEQEsT8jAwniCalT04zmS9014ib/vIsLkVlDxQtTaSGMD3iv5wrN+00trW5CgV27nKN+YizECSHzrCddCC33Zjlote/DExcVikW1z3S4JauXvvo0tJ0qjInOtt3/RoyG8M/1dx2lTfOXlFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515841; c=relaxed/simple;
	bh=8PYP68Ax0qTKJX/4LGN4Imt99aMz5xZB+wF4jYydGK4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mZzrs2ENKjwWW+VvnG4h/9S8dakGRVCkMQuGgRUcKbVFSnnS/F0YzXLjL2C24hP1oYPYCw2anpC4Pvx3MwIBfvBKlW1yQlzAijmPdgG00ehY/bKdozSYW3yhcmyuiaO+WW2ql4yRE+oWvJWWGsZucw3dxW5t1UqtNyLjRNUk5Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gc8PZRna; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gc8PZRna"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88622C2BCC9;
	Mon, 11 May 2026 16:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778515841;
	bh=8PYP68Ax0qTKJX/4LGN4Imt99aMz5xZB+wF4jYydGK4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gc8PZRnaPF+8V5h9qCf9CYSjF3uqxx/ErvEXffQLG8Aa3mr/PmAHtlNC+5vzd7vRG
	 HQ3v+rT4ymx/G6C3jy3eZB5YJY1aRvCqOv2Wm0/o08G2dZDb1PG2Uex38MXbNTE3l4
	 AgL+6dT16dGoG4Qn/pumJaUdON3h8dXQSVbpiFLmY9hDICwdc7BEvdDtTB7KszrPqw
	 /r3Azt+23I75un00Dp33OhXB3K04dPacPPp6QYNhOwuHKZDelz5zSxeQ7gyHAm1AAt
	 zM0tw3yBbms+EScs7wv6ybEG0vMhMs0ITApWhD+i3Nh9EPe9oT06Fx7Q4MzeR9jdIZ
	 snP1GPqsLUHvA==
From: Thomas Gleixner <tglx@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Joerg
 Roedel <joro@8bytes.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/2] [RFC] debugobjects: avoid gcc-16.0.1 section mismatch
In-Reply-To: <34af0db2-7a04-4119-925f-3aa3e3ecb683@app.fastmail.com>
References: <20260203162406.2215716-1-arnd@kernel.org> <874ikf9i34.ffs@tglx>
 <d52dcd45-959a-4ff4-9e82-0bae133785f1@app.fastmail.com>
 <87y0hq8lcu.ffs@tglx>
 <34af0db2-7a04-4119-925f-3aa3e3ecb683@app.fastmail.com>
Date: Mon, 11 May 2026 18:10:37 +0200
Message-ID: <87bjem7wqq.ffs@tglx>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, May 11 2026 at 11:46, Arnd Bergmann wrote:
> On Mon, May 11, 2026, at 09:18, Thomas Gleixner wrote:
>> I agree that the compiler does not know what __init means, but this
>> sucks as it leaves an unused copy of lookup_object_or_alloc() around
>> after init.
>>
>> What happens if you mark is_static_object() with 'noinline'?
>
> I've reproduced the issue with the release gcc-16.1.0 build,
> and tested marking is_static_object (along with
> dummy_tlb_add_page and dummy_tlb_flush from the other
> instance) as noinline.
>
> As expected, this avoids the problem as well.

I rather prefer that along with a comment explaining the 'noinline' oddity.

