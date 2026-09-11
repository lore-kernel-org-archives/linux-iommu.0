Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1183C0A02;
	Fri, 11 Sep 2026 07:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789111648; cv=none; b=Sn0YppOjw/6XxleIkMbZQs6thVzlDbljH1z7GBiwtugv+ot7PFxsqdC8cnACqgaIzhRty2zlpIpBqXeqHcZQj7W2hei8OhqE/NHFr9OkcqrEoYZQNtY6yV6DWUqnTsVgefevO/Xl8q6TVPA/lEaMOGdeDVldxGhY4EORLAUtu9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789111648; c=relaxed/simple;
	bh=poqSaq7eYvpyqsPiicaLp9CNB7na4y/oTjJatJRK1vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYi2RtO2RwLlNEVag+ZHN/0oLHwJeJRw4HS+uQZq6t4LDSu1twyba8lqpnKqXHT9WTX+KHB9JRCH1peigxmbJhYuhQsefJjX1AShyM2ZxFP9F78mxPnOp0ws69hPw4j8YP9S9NllvJksPh0HxlsKxw1iJuolTSZFCfwhBV+F+yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhVJSvK0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhVJSvK0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C95E1F00893;
	Fri, 11 Sep 2026 07:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789111646;
	bh=x64dhSbRG3976W/AFnDoWQ3i6kbUl3GlicYHKb29MTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XhVJSvK0Wn8UaoKxFrtHGjmyng3OL9S+DoVjRfqoYFJ1H5lsCHwiBTguwrk1HW5pV
	 H/IjBJcpPHR1ZScHQSQlnY/UEOCBN/9tC0xMZuLYJJqe5z9d9UxXWXMZu5GQWhcQ4z
	 AJAi5TZlMb+0G2cCp46CT4A26y188MC1AgmclTsgbQ3XAiJvLjnJrJBL3y+TB07Gr8
	 OaXE05A50TRz9KZbrzojPPcjT6rLNMc4wr0VHA6MO1wdslBwI6oAzK2KxTVBbRa2/j
	 p6JCZ2DrB3mosPY96c56pGYXsg8lTni7mKcVB975lq0FQm6BCe1TXR+/2HqRZEsRBK
	 OhvRGjdccornQ==
Date: Fri, 11 Sep 2026 09:27:23 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Roman Vivchar <rva333@protonmail.com>
Cc: Yong Wu <yong.wu@mediatek.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, iommu@lists.linux.dev, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: iommu: mediatek: add mt6572
Message-ID: <20260911-khaki-squirrel-of-sufficiency-ccd82e@quoll>
References: <20260909-6572-iommu-v1-0-de261da09fb2@protonmail.com>
 <20260909-6572-iommu-v1-1-de261da09fb2@protonmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260909-6572-iommu-v1-1-de261da09fb2@protonmail.com>

On Wed, Sep 09, 2026 at 05:14:05PM +0300, Roman Vivchar wrote:
> Add compatible string and header file for mt6572 IOMMU support.
> 
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>
> ---
>  .../devicetree/bindings/iommu/mediatek,iommu.yaml  |  3 +++
>  .../memory/mediatek,mt6572-memory-port.h           | 26 ++++++++++++++++++++++
>  2 files changed, 29 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

