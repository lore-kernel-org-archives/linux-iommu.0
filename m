Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D65721E097;
	Sat, 30 May 2026 11:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780140109; cv=none; b=lbMIwMnOum0gry/EJp0k004vGeB5Ylc+7t4I5GyGudc8sLJaCmvb1rfABv/fWffwnbkpyLENlgyWkHJfhFYA1ryBhux8vMZpSrmuEn/4U8umO5L2OjzMuypMSL/1AXzs2mMGsCVOhv5fqVqEZmmNrCpx1X0mKalGI+lB5tSs6mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780140109; c=relaxed/simple;
	bh=ACnkmOYAUmjYtX3gH78VndQzbA925Gr2bwpgP4+4IsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7S+x1+VoTxvMRqOZop10tSbbPa3nChZN0VmGI3h3Tb6vbVgv52immE/HxcnO5fVTMvBummtsVNtZSOeOY8sEGx37hLO42S347pxbFCmPBhJxq0LaViGPN7uSZbGWUH7+Ccf4rfkFexndR9bI1v0GK0RiuV27sHMSexpnlkqZ8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5XFGMMN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5XFGMMN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070561F00893;
	Sat, 30 May 2026 11:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780140108;
	bh=/PKIUPzKZultVLVuDEshDOuPNkVRnRPKWDlFHZcHgBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e5XFGMMNxepVlF0/oJxZsyKEE0iKf5a9QQNSu1ZUZxh6mJwXvRhE25rYLnJ4vfONa
	 XaMyjSqBe+AIJEFhfFQPYfemmMlilA3TnIPyjgKhvp2grF/diRalawoS62X+Y3/qZH
	 bhF+NFaVVmTyB9uwfW+iZ1s5B526gAmyyUH3TrCoo6AaZqk9u+HlgjUs9TCeNB8OIp
	 qvOzkgjFtkK9iDjqMVzVlssA09nNAndEe1g8c1af7LmqaR8ktEuUfbscuT3F/F/tCV
	 +mI2nHp+iLiYtrfUdLfsm8aoxOzagSr0o1UyAvlDWsYAAZCRdpUB3CP+MWhRDdUmsU
	 rwmOaHYIWlAFw==
Date: Sat, 30 May 2026 13:21:46 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, aiqun.yu@oss.qualcomm.com, 
	tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm-smmu: qcom: Add compatible for Maili SoC
Message-ID: <20260530-blazing-copperhead-of-gallantry-c1dd23@quoll>
References: <20260524-maili-smmu-v1-1-ec85b12fda83@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260524-maili-smmu-v1-1-ec85b12fda83@oss.qualcomm.com>

On Sun, May 24, 2026 at 11:17:34PM -0700, Jingyi Wang wrote:
> Qualcomm Maili SoC includes apps smmu that implements arm,mmu-500,
> which is used to translate device-visible virtual addresses to
> physical addresses. Add compatible for it.
> 
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
>  1 file changed, 1 insertion(+)

Same comments

Best regards,
Krzysztof

