Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213862DECA8;
	Thu, 13 Nov 2025 09:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763027337; cv=none; b=oIvSXUm7XfPKPS7pbEiyBdMGi85OpotGtjsla1KSPeEM1BRvVkTvwCntSYtJBvr0a4iRkDlyIR0DUDm68DOS2m3H2V/jrV30dalTbUD7qeouTTNcTObmJEWN/gHE77Pq1tdFypzDKidRp/YMaI3u+mDCrvvmdAK5lBTys9riOdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763027337; c=relaxed/simple;
	bh=/zPy/5nrXeM3rH0WQMBYQ1KrNaP5+75Xxt2Uk8rbmwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spDpIPsV8QFh3Zz/Dlqh09xIC7uTTZG5qDaP0pm7j8diuEIcMmTNl9UQTNcLaOdsv4zIwJrtgdMmDtFpwipiNJGNHVczhyizZkU8y007/amysNVSfuBmvD4f3eSwMnzFgObdOKhgfmffAcqW1vrbuxRGMPCVRbS6IsB5BNZrHQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YN6Ir+5Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YN6Ir+5Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 109E5C4CEFB;
	Thu, 13 Nov 2025 09:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763027336;
	bh=/zPy/5nrXeM3rH0WQMBYQ1KrNaP5+75Xxt2Uk8rbmwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YN6Ir+5ZMjGfmTiRLhKZA0DyIZolgiSZj1hxtYt3XLjTFwDmfytxd0PtvztHxYp9u
	 eJK8JXUI63Bqc6tOiRkQA8pd50WNLBbsd/RMq/QFMbwLChQLKTv2wfzNXnCIv8go36
	 aTdxAEq2uzmqRVbc8jGYOpEMtnhP0heo7rKv/klYYaNO4LQV45twX41F2mGqQ6IFaw
	 MpAyV1EKN2RqEZgMLe1nxBgPI6qDPKuZ4miGa9wlEBLjjTZLBSZCoRaxeTxK66C1bx
	 r4r32dE7YUB0Y/MLGCWhnDWJyhdsOXL068g2BxRtQMdEyNxrIbhZLI5uzyX+pP0p5i
	 v0CVFXJmJ6nUg==
Date: Thu, 13 Nov 2025 09:48:51 +0000
From: Will Deacon <will@kernel.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	jgg@ziepe.ca, praan@google.com
Subject: Re: [PATCH v6 0/4] Move io-pgtable-arm selftest to KUnit
Message-ID: <aRWpg0MXrnVH3E4Z@willie-the-truck>
References: <20251103123355.1769093-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251103123355.1769093-1-smostafa@google.com>

On Mon, Nov 03, 2025 at 12:33:48PM +0000, Mostafa Saleh wrote:
> This is a small series to clean up the io-pgtable-arm library.
> 
> The first patch is a small clean up to reduce the depedencies of the
> test before moving it.
> 
> The second patch was originally part of the SMMUv3 KVM driver support[1],
> which needed to factor out the kernel code from the io-pgtable-arm
> library, and based on Jason’s suggestion this can be taken out as a
> cleanup, and a step further to convert it to kunit.
> 
> The second patch just moves the code to a new file with no other changes,
> so it can be easier to review with “--color-moved”
> 
> The third patch converts the sefltest to be modular, that is useful as
> kunit can be a module and it can run anytime after boot.
> 
> The fourth patch registers the test using kunit, and converges some of
> the APIs, some notes about that:

This all looks good to me, thanks for persevering with it!

Acked-by: Will Deacon <will@kernel.org>

Joerg -- please can you pick this up?

Cheers,

Will
