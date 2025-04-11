Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FA221B905;
	Fri, 11 Apr 2025 17:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744392432; cv=none; b=X0/I/6VysX4lVHqcH+bUs5dPElxx+I4Px7kN87o2z3dpKSDTeQmvjksSBaOoMa2Qa6iEpym9qtd8Niw5VmWc3AV9fhmaQ/3/JOhsS9W6jAa2S3xOqKpHcuwSbmarovSbz4xfk1c6SpeIdYOXEuRPqkYmTnpOgI+DnqY8y+Nz/t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744392432; c=relaxed/simple;
	bh=lThX8yUtObxnNNdpSefIo+oWxDYTahO3dx8BUWqqSSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qeS6iUhqSX17KTF6aFEvVFDa8VBAWIta71x3ZK+Vt9L6/BoVtGHPze2LK8jfkDcjy4mJZ0/K4l9xFWrpFS7Qf65pj0B9JMiG1Ua6msc/RrbUQNJtb4/StjDr8PKpWNKVw1h+StRYVueqF8fdruN4hai7zTAwpB78ItoyTyuKPgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ladMjA1o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ladMjA1o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF85C4CEE2;
	Fri, 11 Apr 2025 17:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744392431;
	bh=lThX8yUtObxnNNdpSefIo+oWxDYTahO3dx8BUWqqSSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ladMjA1o8YRPWYkPOAPLpt8mxNrrxG70sZReilZORO7FmT9YqyKf7h27MgnCWGWWx
	 N0Y8qRktCjFX7YyMabYj7xd5MdrwTxUBPaxXcN4svKJVG+3me1cnUZXQ87EWOfjTu1
	 y7DI4GjOhouEO4wZ6ubGUOdiFrcWLRIQZgP/b7tHJw/8uyDfO4srt+Z2rooySBVr9V
	 kKd8kK3vw706rVXMgfJm9LHWN9CZ/mLplbLuGn419d4aGiMnt8CCWkdF2jahFetaqW
	 Pf7+igYe8Dx4w7u5gcellyE7Fh9cR6wpp66fzCqjUy0u1tXBqtZIpXbs2afGNT96FC
	 5Wm5R1i/4O2Lg==
Date: Fri, 11 Apr 2025 12:27:09 -0500
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: yong.wu@mediatek.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	matthias.bgg@gmail.com, iommu@lists.linux.dev,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: Re: [PATCH v1 1/2] dt-bindings: iommu: mediatek: Add binding for
 MT6893 MM IOMMU
Message-ID: <20250411172709.GA3571947-robh@kernel.org>
References: <20250410144008.475888-1-angelogioacchino.delregno@collabora.com>
 <20250410144008.475888-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410144008.475888-2-angelogioacchino.delregno@collabora.com>

On Thu, Apr 10, 2025 at 04:40:07PM +0200, AngeloGioacchino Del Regno wrote:
> Add binding for the MediaTek Dimensity 1200 (MT6893) SoC's
> MultiMedia (MM) IOMMU.

You can drop 'binding for ' in the subject. No need to say 'binding' 
twice.

> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/iommu/mediatek,iommu.yaml        |   4 +
>  .../memory/mediatek,mt6893-memory-port.h      | 288 ++++++++++++++++++
>  2 files changed, 292 insertions(+)
>  create mode 100644 include/dt-bindings/memory/mediatek,mt6893-memory-port.h

Acked-by: Rob Herring (Arm) <robh@kernel.org>
