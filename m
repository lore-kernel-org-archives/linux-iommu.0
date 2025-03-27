Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CC913DDAA;
	Thu, 27 Mar 2025 05:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743054297; cv=none; b=IqA6AMr1cl7RIC2tIgO7uzKm/44/d2z9sIJYa1WNoVhNJE7eU/xDcBltuz2HMlhwVdjoVvcREH2be4gblGyofjN7OhkO3+g3HIgZFk0J2Aqf81FQ63jZq+sQBnyTwukt/yrr2ZKO2P64uu4nGCJAFU61HDilRVyBBJcZpfYa2IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743054297; c=relaxed/simple;
	bh=QLmbrKmAd6h0fd+I9quZv7EdyPeLJ2iTZ2AFB70/Paw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSYwRfK2BZ41OxzlEQdqs2g5VMix2djyleyoIvIsIgp+QkouI8/hSYnNrmZphM/P8ALLCyVkIFAn1E4xz21SI1o0lg+50Pejdq3cTMcvZv5h/TZ3/oG858luFneTGgnv3BmxHTAM6Vom/SLPJq2wtDkRKXf34Oz9koRL2RsXY4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBmbqLvA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBmbqLvA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7EFC4CEDD;
	Thu, 27 Mar 2025 05:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743054296;
	bh=QLmbrKmAd6h0fd+I9quZv7EdyPeLJ2iTZ2AFB70/Paw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kBmbqLvA40PrskS69xA3UD0YTDkzEiXUpFg00+as92TTE9HtnlWP700pyGOM7+KaG
	 oooeJsLL6sYjcrK3A1slpBVSgpUV7ATURNFQ7EKUK0dIdI3nZXB6mhbB5wGKQsZMoS
	 VqFqmC4DU37K/MqnPyGKXII/Xa/3PE8Yy+rdHne8eBJ9uY06hVRoQImBOWR5pDxi6J
	 MlWjFqHoHo8QsYp5iEq57SIz2GQQ8ZZ6NMOT6N4FKpadOPJG6iMvREju3gJjw7h2l4
	 uY7w7HBKZ1eYgQK+PJk6umi2Co+a0jq3aEdStvpMTpUvujRh73NteBl1qsQo6EG1HS
	 U168oUxsWtXDQ==
Date: Wed, 26 Mar 2025 22:44:54 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Subject: Re: [BUG] vmlinux.o: warning: objtool: iommu_dma_sw_msi() falls
 through to next function alloc_io_pgtable_ops()
Message-ID: <6iqec5chiqlsysp2vb7qlfkebzyrdreb3rtm7t7nx3ppiywqya@xj7w7y5r7twh>
References: <5dd1f35e-8ece-43b7-ad6d-86d02d2718f6@paulmck-laptop>
 <88ef4efd-9736-4c37-9b05-212e65602322@paulmck-laptop>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <88ef4efd-9736-4c37-9b05-212e65602322@paulmck-laptop>

On Wed, Mar 26, 2025 at 04:45:52PM -0700, Paul E. McKenney wrote:
> On Wed, Mar 26, 2025 at 04:18:51PM -0700, Paul E. McKenney wrote:
> > Hello!
> > 
> > Building next-20250326 using clang version 19.1.7 (CentOS 19.1.7-1.el9)
> > gets me the following warning:
> 
> Apologies, but make that gcc version 11.5.0 20240719 (Red Hat 11.5.0-5) (GCC).
> (Hey, it has almost always been clang in the past...)
> 
> Also, the runs that have this problem are the ones whose kernels are
> built with CONFIG_DEBUG_LOCK_ALLOC=y, but that do *not* enable KASAN.
> For rcutorture, these are scenarios SRCU-P, TREE02, TREE05, TASKS01,
> TRACE02, RUDE01, SRCU-T, and TINY02.

Thanks, I posted a fix here:

https://lore.kernel.org/0c801ae017ec078cacd39f8f0898fc7780535f85.1743053325.git.jpoimboe@kernel.org

-- 
Josh
