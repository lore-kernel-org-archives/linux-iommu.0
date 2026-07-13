Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE7C3D954C;
	Mon, 13 Jul 2026 09:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783934231; cv=none; b=b4ov/Qs7PP75IDRyj6TBAKFQEtptuDXOyXKBJRbVLs2e34I6lvjDPos/VzgeKli1UsmSKixy8L9BecN1O1SubTJZlYXC8kXtY9xe0JdJwfPmhbKeCF/6jPzpB3hfHdtz74ASI56e73dYW1UaxSa6oznJl2rCOHrKY4rj8Pr+EKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783934231; c=relaxed/simple;
	bh=/MTiVkivWwRkYjG1tPw9Ohi/tITdICz3TxZb9sUAq7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0G+GWax6WvsXLfjIGc3h8kwa9BrUFdDD0+7CKg1gPIxiyPhE59T++pa6sOOfgnmFsvb/KZedbw5ZtCD+2iN6Kjwxduh0VErijuZgP72t6mh4BAASzpwjjuSsYpFjjMW0G5R8rgjJ5z4jXpwrNWiP7a7jwirXxCyW+tbR0YQsuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jN+v1q30; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jN+v1q30"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E6D1F00A3F;
	Mon, 13 Jul 2026 09:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783934230;
	bh=I84JgCkBPA2ap7sLC4w/LE5hx1QYu9euEbpPHYVjIFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jN+v1q30ltie7Wh6ptwJ1B7gxkVDfklLV4GLf1m7y8XNe03qlMPpOi7HjRuyphRqC
	 Sm29JMxfyDm2Z/jYb02RGUrDwJuNALD3J014XdzYLpdr8kXqZn6cEQ2AN++SRFcaMA
	 s6Ajg0zoNftkg0Lr5HBJM1FFCwRn5hgqny3KnQh+cXOH5gcFakS+CDHp3oGI8/5mBF
	 hwLCl8BS2UX3UiKpkXfzJvTEoAKnXpQZtuth8jM8B5Fq5jcrph+4WdVcn08QbgCP0r
	 AwzW3W15DNICL/xRvy6hHYCfqnTrIE4WQ25y1521tMdyQC/GDxg/u9KlBTKfpLyfZf
	 E10XbyNOO7w4A==
Date: Mon, 13 Jul 2026 11:17:06 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Daniel Drake <dan@reactivated.net>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, nick.hollinghurst@raspberrypi.com, 
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 6/6] arm64: dts: broadcom: bcm2712: Add GPU IOMMU and
 IOMMU cache nodes
Message-ID: <20260713-important-prawn-of-health-9d032a@quoll>
References: <20260712-bcm2712-iommu-submit-v1-0-80e10cdde2ea@reactivated.net>
 <20260712-bcm2712-iommu-submit-v1-6-80e10cdde2ea@reactivated.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260712-bcm2712-iommu-submit-v1-6-80e10cdde2ea@reactivated.net>

On Sun, Jul 12, 2026 at 10:18:56PM +0100, Daniel Drake wrote:
> Define the IOMMU and IOMMUC nodes for the Broadcom BCM2712 SoC found in
> the Raspberry Pi 5. Enable use of the IOMMU for the graphics/display
> block.
> 
> Signed-off-by: Daniel Drake <dan@reactivated.net>
> ---
>  arch/arm64/boot/dts/broadcom/bcm2712.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

Does not like built with W=1.

Best regards,
Krzysztof

