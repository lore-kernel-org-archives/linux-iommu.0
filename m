Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645E0230BDA;
	Fri, 21 Mar 2025 21:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742593852; cv=none; b=fAvXDDUQ0ZGwOctZ8KIw9izlNDHbbQdPf1DhwD58qK4f08ET5t8iGNB4b4oIa0Tv8pz0PKC68X/GH5OsVbqq5Zsm+3GW25yDo1RSyg23/rQWUD5UMSuj5zrM6FmFOgdc7G36lQb+fll5ZPKDPUzaH9hzqmm2PbGSzKGw5nw1xac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742593852; c=relaxed/simple;
	bh=OuXsCIjww8IGPIERo9jMNo59TtIIO8iDeK1LYXy5qcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0jL5miNklyU3Wb9iHjfDfm6soiKoLqAoUczus+cVNLe+042uHW5mKnAEnEjtoyyoYCuEaGG1Fcnxb3YlqCoP/4JUYBsXe4cOhFRlkAb6tKfphucAMoEjyRX4sTsCJDOfW7uPTwSDNJFxJxl25Bo9BzDBwHV0yZ0NoMKpKpvTY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRXd7UtI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRXd7UtI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F52DC4CEE3;
	Fri, 21 Mar 2025 21:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742593851;
	bh=OuXsCIjww8IGPIERo9jMNo59TtIIO8iDeK1LYXy5qcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mRXd7UtIRqeAPMkVSIWqUxf6NRJDuETi5ei5Xx2ZrXry9WCOECAdPPwt+QM5r6O0E
	 Tgmg1fmyg3MSOvrtuJB/qszgX7onxH6yXKu74w47hxtBK8MOpgeHIJOx5FasxccWDG
	 N15PsR9S61n6PT8yuH5NQkMD+j2FER8vUrn/W6QLIjYCDjCs6Ln1wHf81ZtTcqgmhl
	 YBuOK9VADQqCk6zHzPlrO7N+lH9ykVYO4ulZlzlxZtv+fpu/Ou8kFe9wse4dTEb+tw
	 F+oWlaOntz9e20/mdckQPWqh5zfdYsDpOIBNrZlGzBjr8725fscNL5ZZ7t3Yx3iym9
	 LMgcSbPv357+w==
Date: Fri, 21 Mar 2025 16:50:50 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Xueqi Zhang <xueqi.zhang@mediatek.com>
Cc: iommu@lists.linux.dev,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Wendy-st Lin <wendy-st.lin@mediatek.com>,
	Project_Global_Chrome_Upstream_Group@mediatek.com,
	linux-arm-kernel@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Yong Wu <yong.wu@mediatek.com>, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: memory: mediatek: Add mt8196 support
Message-ID: <174259384769.4178048.13773796481091254405.robh@kernel.org>
References: <20250320073625.25225-1-xueqi.zhang@mediatek.com>
 <20250320073625.25225-2-xueqi.zhang@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320073625.25225-2-xueqi.zhang@mediatek.com>


On Thu, 20 Mar 2025 15:36:16 +0800, Xueqi Zhang wrote:
> Add mt8196 smi support in the bindings.
> Since mt8196 has more than 32 SMI larbs, update 'mediatek,larb-id'
> maximum to 63.
> 
> Signed-off-by: Xueqi Zhang <xueqi.zhang@mediatek.com>
> ---
>  .../mediatek,smi-common.yaml                  |   4 +-
>  .../memory-controllers/mediatek,smi-larb.yaml |   4 +-
>  .../dt-bindings/memory/mt8196-memory-port.h   | 460 ++++++++++++++++++
>  include/dt-bindings/memory/mtk-memory-port.h  |   4 +-
>  4 files changed, 468 insertions(+), 4 deletions(-)
>  create mode 100644 include/dt-bindings/memory/mt8196-memory-port.h
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

