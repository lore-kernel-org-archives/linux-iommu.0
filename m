Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345FD18A6A6;
	Tue, 31 Dec 2024 08:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735633423; cv=none; b=mF+s0kHt0ID+1H9ftoUkOicxMGeBxaOwM/alCelJgrHcY2gRDsuK6dUmvals8qIGgTtg8uwbD4o3l210PdLYgQoNcJO8sE66uBUPyqXLH9sjMxJYkRnf8QyNW9V4sykHy/kIA1vDoxVxk6XOCAs5BTXz3iiAFlQ2K4dCDna3jpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735633423; c=relaxed/simple;
	bh=8k7A7pn5KKxr1hAtXg6k+QrsCY9z/C72vgdY+d0asXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5bjNpsHQWfhKWV/vzfBmFL8hQe+blPAUS1X7Ds/5Q1ljmwilM0IOW5eYrtfGKvlwfq+wXm7vUjUsZS2LvSlvDW+ygU3w3Qqxd7RKwczvNQDfjzDeUFLTHGvk0QY2vIICiYCrvSNYLijqeWb+Q6AMzjPMea+LzGlJ4v48wHb43E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aywhAM9C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aywhAM9C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF944C4CEDC;
	Tue, 31 Dec 2024 08:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735633422;
	bh=8k7A7pn5KKxr1hAtXg6k+QrsCY9z/C72vgdY+d0asXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aywhAM9CB0qyWKi9qwSfMfwPQayyzhqdqeZOI+brEmTbnRfv8wGj59BYjIGtg0Y/x
	 Ggiowx+uGTybxmDi9KF0rMUJnhFXkOtDV7Ng6XZB45Ah7/u/p5sgxCS5N6s9P0VYpn
	 ekzAjtcvrTKiyadrSuV7Pxsl1xdqktIQNfP1zh9GPEiJVGCctIj/4D0+oDUlr8Apv/
	 s5d3q6C0Tp9Z34xi5nMTirKOL6hwS9VYVl7TH5Ip1YVPYGFJs3czHcZn5i0SNq5pDH
	 VlZs9UrLMkeZVnJt/ZQmKrn0YhagLrAfsYECognXKukpo0T6UbcX2wfv8vqA/OOLrM
	 Iof2vBIg9nWew==
Date: Tue, 31 Dec 2024 09:23:39 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andy Yan <andyshrk@163.com>
Cc: robh@kernel.org, iommu@lists.linux.dev, heiko@sntech.de, 
	devicetree@vger.kernel.org, joro@8bytes.org, hjc@rock-chips.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	vkoul@kernel.org, detlev.casanova@collabora.com, 
	linux-arm-kernel@lists.infradead.org, Andy Yan <andy.yan@rock-chips.com>, 
	linux-rockchip@lists.infradead.org, krzk+dt@kernel.org, cl@rock-chips.com
Subject: Re: [PATCH v2 5/8] dt-bindings: display: vop2: Add rk3576 support
Message-ID: <6pn3qjxotdtpzucpul24yro7ppddezwuizneovqvmgdwyv2j7p@ztg4mqyiqmjf>
References: <20241228122155.646957-1-andyshrk@163.com>
 <20241228122155.646957-6-andyshrk@163.com>
 <ihvrdnntfuvvycnlhysnm43wylotovvnivu4wxcne3bwc6etpj@n2rq6n77lmma>
 <4847f6b1.1c60.19412092a7a.Coremail.andyshrk@163.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4847f6b1.1c60.19412092a7a.Coremail.andyshrk@163.com>

On Sun, Dec 29, 2024 at 06:49:38PM +0800, Andy Yan wrote:
> 
> 
> Hi Krzysztof,
> 
> At 2024-12-29 18:13:39, "Krzysztof Kozlowski" <krzk@kernel.org> wrote:
> >On Sat, Dec 28, 2024 at 08:21:48PM +0800, Andy Yan wrote:
> >> From: Andy Yan <andy.yan@rock-chips.com>
> >> 
> >> Add vop found on rk3576, the main difference between rk3576 and the
> >> previous vop is that each VP has its own interrupt line.
> >> 
> >> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> >> 
> >> ---
> >> 
> >> Changes in v2:
> >> - describe constraint SOC by SOC, as interrupts of rk3576 is very
> >>   different from others
> >> - Drop Krzysztof's Reviewed-by, as this version changed a lot.
> >> 
> >> Changes in v1:
> >> - ordered by soc name
> >> - Add description for newly added interrupt
> >> 
> >>  .../display/rockchip/rockchip-vop2.yaml       | 70 +++++++++++++++----
> >>  1 file changed, 56 insertions(+), 14 deletions(-)
> >> 
> >> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
> >> index 2531726af306..f28cea4a6d82 100644
> >> --- a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
> >> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
> >> @@ -20,6 +20,7 @@ properties:
> >>      enum:
> >>        - rockchip,rk3566-vop
> >>        - rockchip,rk3568-vop
> >> +      - rockchip,rk3576-vop
> >>        - rockchip,rk3588-vop
> >>  
> >>    reg:
> >> @@ -37,10 +38,22 @@ properties:
> >>        - const: gamma-lut
> >>  
> >>    interrupts:
> >> -    maxItems: 1
> >> -    description:
> >> -      The VOP interrupt is shared by several interrupt sources, such as
> >> -      frame start (VSYNC), line flag and other status interrupts.
> >> +    minItems: 1
> >> +    maxItems: 4
> >> +    items:
> >> +      - description:
> >
> >That's contradictory. min/max say 1-4, but here you list two interrupts.
> 
> There are 4 interrupts on rk3576, and the other SOC only have one.

But you listed two interrupts, so where does the "two" come from?

> I am sorry that I am not familiar with this schema language; I have read many
> other YAML bindings these days and try to write it correctly.
> 
> Maybe I should not list the interrupts-names here(then list the interrupt-name by soc at allOf:  part),
>  like the clocks handles in samsung,usb3-drd-phy.yaml  ?

xxx-names are supposed to be fully synced with xxx, so something needs
to be fixed here. You can of course remove interrupt-names *completely*
(but not partially, because all properties must be defined in top-level).

Best regards,
Krzysztof

