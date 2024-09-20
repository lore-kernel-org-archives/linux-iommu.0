Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4CA25776;
	Fri, 20 Sep 2024 09:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726826217; cv=none; b=N3ncBnIe9NoM1ubAb2O+qHvDo75EwdNDg9Fk/AORWiynG+RANtwntYAit61deTXy3on8tRGyhkfkdbyV/atrmF9duqzQ5+++61XjL48hDaEpigGz0F1iRIsZwuIUi1PGEggIfgkbzbd6qugz+o8l8M1f8IjtzN8C4ucebG4+ujg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726826217; c=relaxed/simple;
	bh=WdDoGFPSTqZbec6YN4cQkS64m6JSU4DnTNwgzcZBjdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WiSZsXYFVV+aqeo2JURO9zWkJlRqmAuX2fgargt0lcGti5vUeDzA7UkecD1ObqzU+DM2RGphbbwgA7bUyEg9HCd8hcURCjTZoOpbzO3QLYkhbvWIoj8bk4WGFP4eZPXjBEwavMer6uBsmqlilf7kyi9K8vRU55UZRurZyEBwPVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=sORopcg1; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="sORopcg1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZjYXtCI4nuFEDAhXrD2uZbQsprc9VRMwkexVscbAyM0=; b=sORopcg130vTP2BE+HEZOFpnfT
	Zs6sk4eDWLQoVWqYfadzyCn7a2sdObvIjsa7Lql16zLwBNvae24aYxECwxyajBps4CHQsZe4cTwDc
	izA6tjN0aAJ4JWz4kj8hmHSICwOj6Xquh9P4jv2p4Id/lxssuqTQFvddtru5NxexjFSeCWOJWHDDo
	NXMJ8VQgG1g3ozMSc0ZReMf5QHUR3MnhMYHc7/9GlAwQlBVkEgHfJLU8+X+QdhaSXzhCjRepcSayx
	QvCShrI3QKj5x6JbTH8hKvHJwXd61yikR5VGMVvp0PlIJxdyNhorXQtf3G98dOmlAfT07NEHCl8Yf
	AehKMy7g==;
Received: from ip092042140082.rev.nessus.at ([92.42.140.82] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sraNb-0000fJ-8O; Fri, 20 Sep 2024 11:56:47 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: joro@8bytes.org, Andy Yan <andyshrk@163.com>
Cc: conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH] dt-bindings: iommu: rockchip: Add Rockchip RK3576
Date: Fri, 20 Sep 2024 11:56:46 +0200
Message-ID: <2220454.C4sosBPzcN@phil>
In-Reply-To: <20240920094947.7566-1-andyshrk@163.com>
References: <20240920094947.7566-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Freitag, 20. September 2024, 11:49:40 CEST schrieb Andy Yan:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> Just like RK3588, RK3576 is compatible to the existing rk3568
> binding.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
> 
>  Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
> index 621dde0e45d8..6ce41d11ff5e 100644
> --- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
> @@ -25,6 +25,7 @@ properties:
>            - rockchip,rk3568-iommu
>        - items:
>            - enum:
> +              - rockchip,rk3576-iommu
>                - rockchip,rk3588-iommu
>            - const: rockchip,rk3568-iommu
>  
> 




