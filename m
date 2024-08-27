Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13F01CD31;
	Tue, 27 Aug 2024 12:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724760130; cv=none; b=HFfmvvIqwd7KRKbE5Mkm+daOTFaZUxZOQpFBwQgs7IjQWT5bOpBX/bdZYs1Q26jmp9QNhiLfrT8SNGaFVgIAC8AE6bsK8OoKEfibODrkBw0PPmuJU03DdBPnJXUk+vqs3SxJDl3OVXwDdhQnTHL6eqOZ4XkatAtMDWxBXO+Sf2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724760130; c=relaxed/simple;
	bh=lvJefGmBUmSlw64LI8eUHF1Cj+r57fkcb4QI3ylohP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guOe0jIOvyGk/i71S6cMVqbbvUC2Bh3Cq1yB5AELWiqFfBp9EmQP/up8Oj9PNaA1t3IvE4vP/ta9WU2UY5lWCgwtK/TKMH9UniHCT+evruDUgL7NJug0I0qfotWSyUzq41FbaYNvSVVwHEmsgIPQ2Es/7x7jIutvTKtDiPjE0Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skypSDYM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skypSDYM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A04C6107C;
	Tue, 27 Aug 2024 12:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724760130;
	bh=lvJefGmBUmSlw64LI8eUHF1Cj+r57fkcb4QI3ylohP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=skypSDYMbu1+2MTVFbggWXq2oS7ezSGLc3em2nMWXQmT3mbj+TMz1gmm+BJ+8ikCI
	 /Z1YVuB8vaDQ3dUEOUkDxZ7RCUuUMglhaptNVLZf243mus821c94u3qnaXxctofi4s
	 skjcdsmr07nJ7F3vUvXgRyNiKj9Dg2lJ1otHikESl8BSmbzTb3LDlL7547yV2us+YU
	 i4P/IdcYUqCIGidnxw2T/YHjATzAuVUJhTNv9Kdy6P1q1qYsoMe1RtKN8+ytz1Vm7Z
	 QfhYb8+9rrs+UWear92LM1Yr8GK1XhJDMOwf5aKfWsSLuTUMzV7KLabgr6WCiJCqgS
	 Z8eWNbELUA1IQ==
Date: Tue, 27 Aug 2024 13:02:05 +0100
From: Will Deacon <will@kernel.org>
To: Rob Clark <robdclark@gmail.com>
Cc: iommu@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Rob Clark <robdclark@chromium.org>, Joerg Roedel <joro@8bytes.org>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 2/4] iommu/io-pgtable-arm: Re-use the pgtable walk for
 iova_to_phys
Message-ID: <20240827120205.GA4647@willie-the-truck>
References: <20240826171546.6777-1-robdclark@gmail.com>
 <20240826171546.6777-3-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826171546.6777-3-robdclark@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Aug 26, 2024 at 10:15:39AM -0700, Rob Clark wrote:
> @@ -776,7 +775,7 @@ static int io_pgtable_visit(struct arm_lpae_io_pgtable *data,
>  		return 0;
>  	}
>  
> -	if (WARN_ON(!iopte_table(pte, lvl)))
> +	if (WARN_ON(!iopte_table(pte, lvl) && !selftest_running))
>  		return -EINVAL;
>  
>  	ptep = iopte_deref(pte, data);

I still don't grok this hunk. If the selftest is running, we want to
return -EINVAL here rather than dereference something that isn't a
table, right?

Suppressing the warning is one thing, but this seems to do more than
that.

Will
