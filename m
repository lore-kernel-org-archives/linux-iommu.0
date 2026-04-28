Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCD22E401;
	Tue, 28 Apr 2026 06:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777359166; cv=none; b=OmztismmfazTUC6pQaNDI+VPSSJylLGZlJOhiFffTOPs177lKaBOG/8NtxZ6GN6C5cJIWbIksdV+fazoT/TcNYTyLb7YXZEomj+ABshHjzT5d8xLTEWxnMwvUZyQxheQEPHeE9U5aeuODRtnQcqGo6Yryt0SD3Qh3kn5WpsAOvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777359166; c=relaxed/simple;
	bh=Bucat0/ntK6EVfUjNUeSm7IPyEzTOE1ePpIcpjUt60k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFgFoV+pWg//Mdc+tYz3sNZpQD2iTAlLTXOW+cnOmHQutS+kr97MDzMcGP8ddia1ZGnbGqb0OBCxKP4rno0jRZuvWbxtn0DhTbreLoilaHlTTksUMzQ5NWRHx+QIsul+w5S3iAyowSeF5+7rHpm/Wp2+f65dXXUklV799bk/gUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Op+QLsMo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Op+QLsMo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64401C2BCAF;
	Tue, 28 Apr 2026 06:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777359166;
	bh=Bucat0/ntK6EVfUjNUeSm7IPyEzTOE1ePpIcpjUt60k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Op+QLsMocFB70u31t9hypd8k9ziwRsUoyvAkc9ASHq7J+FLTazK2ChFJ1d93IUB8W
	 uqdT7nMV564C7vrgAQLSkRs2bMUuc7mJBD1HLFFtMu+WgNYkeXZ70wOVvnUR9MPaM1
	 5a/bmWz2FGbny6grzmiHVYxMCb4u03UP2bamW7csYcfLQ7oeIXU76RelUwgOKFj/6x
	 kFNdr1iR0RTATAmPZAYtzefHnepbcUrsyyMIPJ8c+KWzhrL9e0fu2AB4z6OERKcYFZ
	 N1758iz3mdolXnEMO+LRS9/lPxaD6ZynVLhukpVdNsc5+drsIkR/J/eFleG0Y5sXr+
	 pJH8+CwALS/Dw==
Date: Tue, 28 Apr 2026 08:52:43 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alexandre MINETTE <contact@alex-min.fr>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Guru Das Srinagesh <linux@gurudas.dev>, Linus Walleij <linusw@kernel.org>, 
	Rob Clark <robin.clark@oss.qualcomm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, iommu@lists.linux.dev, 
	phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 2/8] dt-bindings: extcon: qcom,pm8941-misc: Add PM8921
 compatible
Message-ID: <20260428-arboreal-happy-coua-da3eb2@quoll>
References: <20260427-mainline-send-v1-sending-v2-0-dcaa9178007b@alex-min.fr>
 <20260427-mainline-send-v1-sending-v2-2-dcaa9178007b@alex-min.fr>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260427-mainline-send-v1-sending-v2-2-dcaa9178007b@alex-min.fr>

On Mon, Apr 27, 2026 at 09:34:48PM +0200, Alexandre MINETTE wrote:
> PM8921 provides USB ID detection through the USB_ID_IN interrupt, which
> APQ8064 boards use for OTG role detection.
> 
> The Qualcomm PMIC misc extcon binding only needs the interrupt
> description for this use case. Allow qcom,pm8921-misc without requiring

Bindings do not describe use case, but hardware. What is the interface
to PM8921? Is it on some bus or not?

Best regards,
Krzysztof

