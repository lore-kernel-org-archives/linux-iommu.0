Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF44A1922E3;
	Wed, 10 Jul 2024 12:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720615153; cv=none; b=YHQdF1yzcJTbc3iOAQtbAGaV21yhjKrO2Wa/JxlTfVmD1oZnsrIMqXMLOxIPBUQmCdaSjBK1EtwMwrgCIDkzpqy3lGHFH+7pjsW82vyjR4vbia8HbVy6023yBhNghFxbS7gIFmLujyR4S55uGMF1TM9MovN7W/zSfCLkFff7AbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720615153; c=relaxed/simple;
	bh=TY4sY5oPjVbGQAENFz0Pqdu8obOb5jPNxo+VfH0FRYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h4ZdYNKQlJ9KNuJQT3OW33rM2+h5UvmXSbzW2FJfO91e8vFDZBvbg1fzbXJtwg85fiu7QkxGtR5bHWU9JGWSJnaEQeoA6o7FzshCoD1WmqedZJ3EhlXlzHlVyhmfrNFJZshZANMSDEZDDjIRCotpLkSKZTzIH+A8x5/9C1mdg5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgOTl8Hi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgOTl8Hi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA14C32782;
	Wed, 10 Jul 2024 12:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720615153;
	bh=TY4sY5oPjVbGQAENFz0Pqdu8obOb5jPNxo+VfH0FRYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NgOTl8Hi98oOvg9/W8Zhn7iI6SoavNvy3cQuT63uzjYmFDgFKVGivaW4FNiSIRyOb
	 JtXVwLpk6GXGfW/dT5gM1LbCS3bEuLZlIpv/TAqwB3vWKbza4D/N7EkdrtdYpq7wgP
	 AsBBz3a0qdT4PxCW8DxubFhNUhuc6C8rgaAqNBY9D0hDR7/RNYQtktiUdg3/HFoCUn
	 gGIU5ckQFjUs8HYEj979XYtrwpZltRIq4iCSrp94khyE53NFHqs2BIm6Z4IJhub3YM
	 5rEPIEdbkvP2BHZDtXGAdoM+4ZfjRawQ+b7+zTUx+XAVEJiz+FRe6I5TFKAdO8v5jz
	 6jFOKgBN8jOTA==
From: Will Deacon <will@kernel.org>
To: Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Heidelberg <david@ixit.cz>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v7] dt-bindings: iommu: Convert msm,iommu-v0 to yaml
Date: Wed, 10 Jul 2024 13:39:04 +0100
Message-Id: <172061359238.625684.18062139914170368860.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240705221520.109540-1-david@ixit.cz>
References: <20240705221520.109540-1-david@ixit.cz>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 05 Jul 2024 15:14:54 -0700, David Heidelberg wrote:
> Convert Qualcomm IOMMU v0 implementation to yaml format.
> 
> iommus part being ommited for the other bindings, as mdp4 one.
> 
> 

Applied to iommu (qualcomm/msm), thanks!

[1/1] dt-bindings: iommu: Convert msm,iommu-v0 to yaml
      https://git.kernel.org/iommu/c/b577060ac7ba

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
