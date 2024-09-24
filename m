Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57E1139CE9;
	Tue, 24 Sep 2024 20:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727210018; cv=none; b=fSm6xXtIxuHIPPSdeIrBaEb+5ghUpa4NxtN9cqcgUkNUGmESjq+ggL2Ngm+XmTD1aVoXoan5pUQtMZ6SPD0btgrPkSbPVGtbbXjCU9RP+kewCvQzKPFcVLPs3kqq/qUU7UZDLti2sGPTxHEAHdG5+YJtgJMS/LMi4zuncC2quOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727210018; c=relaxed/simple;
	bh=vIbuZ+ZMJIXtuHtEu0Uxq/wiaFCGkBym9byGH31f1Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=av0D11HtIOQPBksjs5HvKOHDmXg15/cXqtZQ5RZpo+Ii3F3+zwS/DlCK1fR6uTfvovI/TlhRfzukK+8hYV9cQLgWMg4SQPNBHJdHvSPWzZVwFSkOAfS/EgmW/5nYTYzmJ3pRfz/MCWIJOMgnlRHLlBIJkG+fYSqTgPhfZOKrBq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Syi51eA1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Syi51eA1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D2FC4CEC4;
	Tue, 24 Sep 2024 20:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727210018;
	bh=vIbuZ+ZMJIXtuHtEu0Uxq/wiaFCGkBym9byGH31f1Lw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Syi51eA1lj1ubFJ0LT4O6ridE2NqmnwzIXklsi8x5mr7S24c0CruC8+Qc655+hqAz
	 SHWhmck67BYNUXbVA0tGPyFHrAAzqHk4ViQBAzoT93knZZrB8IqreuIKm6VESgayxO
	 Ldyajoh8wpNB9+vzRHa6Hwq2XmLeS/pIcANQHb8D9+jjHzcF3RpW1Amwf+ZnzqoDI7
	 2mwfL1XuFhvOHZUW2Se67rS4xG47X5Sh0YkQ8ualdgwP5ksC4DAZ0uUFuBS0Azj/21
	 /PCvi5KF6cBS+KqSeceMjvQMlEKUviVTbckMfwTSE0ct6gl76OCVra8nGZ9q6LqDqP
	 O4ZEpGgPQkTUA==
Date: Tue, 24 Sep 2024 15:33:37 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andy Yan <andyshrk@163.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, krzk+dt@kernel.org,
	joro@8bytes.org, heiko@sntech.de, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH] dt-bindings: iommu: rockchip: Add Rockchip RK3576
Message-ID: <172721001667.289647.10163147936752673484.robh@kernel.org>
References: <20240920094947.7566-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920094947.7566-1-andyshrk@163.com>


On Fri, 20 Sep 2024 17:49:40 +0800, Andy Yan wrote:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> Just like RK3588, RK3576 is compatible to the existing rk3568
> binding.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> ---
> 
>  Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

