Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC743E6DEA;
	Tue, 14 Apr 2026 13:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776172438; cv=none; b=ei0BP5Q/B1nyTKnu8mCEJge6TkT0+MSdDWRohvIjmkzvoFFE5MwAwh+2tOEOFXk/v17dbQ+OqVwYEOLrwmA+RYoNWOtQLHaPqR54vVSxlIB845qLHxuyr8mTE/cHxrty9fGsrb+oGCQVdRdvE/Brr9sFln6itEORcHlXDZF7/W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776172438; c=relaxed/simple;
	bh=JUvlZ5XJ8WhGcDXVq3/vQJIXPNjYUwki5GfpdkqxWZs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cO2dlHGu0sndyuxYeONweojZDGQcSkCufiFyMBGJiDlZOl7S/qP1f6JHG2TlgdckDvEBv7UoXUPILh+eq+fLARlQ/smBngJQPZ87vLNQe6l/GA9qMHTQICaSTBoNVrBHqPE9Y5+5fXOfTvucf0MIxW/cNUCox2F3ZZW7CIj8XNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0HgD2ma; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0HgD2ma"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA11C2BCB0;
	Tue, 14 Apr 2026 13:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776172437;
	bh=JUvlZ5XJ8WhGcDXVq3/vQJIXPNjYUwki5GfpdkqxWZs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=C0HgD2ma1zOidGzRz+JCUe78rxeQtliVp2KWNWen6DY+zSi07NdTHghiejN/HRvw2
	 iRGj5yHD+i0RyMgkd09VeccIHQeQgmLFWEWCTtwwlVrXTuMIRPQT32YAj3SxZYMWf3
	 nARzjK+5IPhiEQLfopl4aWLNiknqek1IF2yxA1cVTSrOxQn9A887gDrarMqqoQpTbl
	 pRO+NnBKPvdU0uWWUl7ONb+fXVYTGH4sair1mJ3VTYjRnAdkQauy5FJt+s6Ki5bvhO
	 PEYBKSOhmtmNlVYVjLl0ECeDFGg2VzMPZi1iQo98rK6UaoLpMGp437EBitHzR6Kto2
	 9vjxTiC4cQNYQ==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	m.szyprowski@samsung.com, will@kernel.org, maz@kernel.org,
	suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us
Subject: Re: [RFC PATCH v3 3/5] dma-mapping: Decrypt memory on remap
In-Reply-To: <20260414122208.GV3694781@ziepe.ca>
References: <20260408194750.2280873-1-smostafa@google.com>
 <20260408194750.2280873-4-smostafa@google.com>
 <yq5atstdanx8.fsf@kernel.org> <20260414122208.GV3694781@ziepe.ca>
Date: Tue, 14 Apr 2026 18:43:49 +0530
Message-ID: <yq5abjflptv6.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Tue, Apr 14, 2026 at 03:01:15PM +0530, Aneesh Kumar K.V wrote:
>> Mostafa Saleh <smostafa@google.com> writes:
>> 
>> > In case memory needs to be remapped on systems with
>> > force_dma_unencrypted(), where this memory is not allocated
>> > from a restricted-dma pool, this was currently ignored, while only
>> > setting the decrypted pgprot in the remapped alias.
>> >
>> > The memory still needs to be decrypted in that case.
>> >
>> 
>> For ARM CCA, we cannot mark a vmap address as decrypted.
>
> Why not? pgprot_decrypted is passed to vmap, why can't it work?
>


I might have confused you in my previous reply. What I meant is that, if
we do not have a linear map, we currently cannot change the page
attributes. We are avoiding that by requesting a non-HighMem address.
What I am suggesting here is that we should document this, or perhaps
handle it as a separate patch as done in [1] by explicitly stating the
challenges

[1] https://lore.kernel.org/all/20260102155037.2551524-1-aneesh.kumar@kernel.org


> Jason
