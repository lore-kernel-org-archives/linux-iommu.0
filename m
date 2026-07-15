Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7B4481FAC;
	Wed, 15 Jul 2026 15:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784129293; cv=none; b=gF+LQc4JqIx0oiyJ7X/6dBhe9YN8Oba2j5L12tRtf4kxy3DriDJ0sBhhGQ+KBDVWjeaNKy+zB93Nyl7kVv1DzhorL9KTFpA2eY/cCHSEH4EFqbly0wBqeQ3pIYRfQNSoslG4fatb99vp01K0z6yI3exEAuiwv91p8D6cOOufr48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784129293; c=relaxed/simple;
	bh=VGkrAuAGprMnanqYIzVpwyieqYhFTMTE5Z6+8DftIVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sx3jU1QVLpAvCh5ix9/jnQfVzsSTxGMUmzk3Y6lWGxtsAOuLBaf8m33whS4XsOFt2uDzITstCAefM6PWqUNc0AMaXF0Fb1ltt7ETqbGtdvy6yYVHXcpqOsyPJU7fRq61PtiBo3myhJH5nqahZGUCHbBs7+DPyFnUWBOlNJlj5fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRbwdY9m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRbwdY9m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D011F000E9;
	Wed, 15 Jul 2026 15:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784129290;
	bh=PUGC7n8fGCwL2WM8SwWYvftYl78frQSS/VeOZzrtC3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DRbwdY9mgHyXgzIJnybclvahc7/K3eQrS418QRiDDGao7GZ+G85QJYE55zXtm6OYt
	 xnb7h1uEYUu/UCQ9HN6E2wXuZ1NqdhG8y0X+w+PfVcgJ2jQTDfNZdHdhITlSsetg4C
	 Yyul+dONI7uEVe2gQlXdQ1XU2R8mMSV22nMvyV23ppobjxwmsRIet7Z0IveqrpCbh4
	 ZsszXfSxJbscqcfQZnU9XH8GRP+gm99OsAkyPtKnJ/UcrV9v5DCZL1F3BRm6fWNQ7d
	 DA4YSJoWESqfkQNaHSv2Tx8Yp+iPnMzOTmOQroXbCHoFh8RgJo1MgSzL47Y+Lbma6i
	 vxgFZ8+cnvQBw==
From: Will Deacon <will@kernel.org>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Tycho Andersen <tycho@kernel.org>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Joerg Roedel <joerg.roedel@amd.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Fix some nits in nested domain allocation
Date: Wed, 15 Jul 2026 16:28:03 +0100
Message-ID: <178411488533.3739445.7343459129417546274.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709195736.3070536-1-tycho@kernel.org>
References: <20260709195736.3070536-1-tycho@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 09 Jul 2026 13:57:34 -0600, Tycho Andersen wrote:
> Here are a couple of small things I ran across while testing some code.
> 
> Thanks,
> 
> Tycho
> 
> Tycho Andersen (AMD) (2):
>   iommu/amd: Fix IRQ unsafe locking in gdom allocation
>   iommu/amd: Fix nested domain leak
> 
> [...]

Applied to iommu (fixes), thanks!

[1/2] iommu/amd: Fix IRQ unsafe locking in gdom allocation
      https://git.kernel.org/iommu/c/0db3a430d968
[2/2] iommu/amd: Fix nested domain leak
      https://git.kernel.org/iommu/c/283c5c4c34b4

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
