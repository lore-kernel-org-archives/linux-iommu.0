Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55803433A4;
	Sat, 28 Dec 2024 14:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735394947; cv=none; b=F/N6Qijbipfq/RTorj72EzNeeMcO66Co5S5wsSiGRU/TeeXeSK9QLh2t01wd3mQpgThN0hDvBvUAGvXCzeP7lVj4+EOJC83UKsO4tnjUw7cy8jSygptRm047bgxwugc+FtAnwl8DC8JEpe0n+1gXcZuAgZUBwJjawgEW+ETwk10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735394947; c=relaxed/simple;
	bh=Dkf6FNbmvczR6fwjr8TMuN/izWdItAgYtjp2h3zBUiU=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=OwMEIpyIyHZZkOfrq3+nQGcFgkHupejawuJtw9dc5YcIwMUin6swvu/jc7PzK6Pq4fRB43WZzWJBzmwt9zapVjzK/AwwE30l6zGfIYnUAWty0XOxnXBZJPuoDX5WimFwLCm/1BYicIJIwE+mj9h2V2/kpHFsClVVM+mAaSHXj8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkUtz/tz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkUtz/tz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99235C4CECD;
	Sat, 28 Dec 2024 14:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735394947;
	bh=Dkf6FNbmvczR6fwjr8TMuN/izWdItAgYtjp2h3zBUiU=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=NkUtz/tztIW/PhXP2LF3lMOFGClVFeWa5CrOwlzULAlP5973gEksD+7QteiFALTfX
	 VSrG2ZV1ClfYJDpFKZ/XSzsPFm2GjtPLNXHsKUVmZkcoWAnQBhLqH4L1djr6ivwuzQ
	 CC6JmtEo318beq4yK6HdKuaJ9UuwZpRwaEa96mxruNafNt1TqwFjEW/m7G75atqVpD
	 TnbkkQCn+Sx7zNmI/vIDziT47eiZN+iW/fsCXv6NlpeB2jmRfGWJyA9Ktj38jF2evD
	 aG0lOQ5LaKRaEoQT2DEchPI/mGcC+gG6q7Ee9tX+OGlrm9jeH73dwV2T65TrWBCRmL
	 ICN4mGxILIv4Q==
Date: Sat, 28 Dec 2024 08:09:05 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: vkoul@kernel.org, linux-phy@lists.infradead.org, 
 cristian.ciocaltea@collabora.com, Andy Yan <andy.yan@rock-chips.com>, 
 joro@8bytes.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, heiko@sntech.de, 
 dri-devel@lists.freedesktop.org, cl@rock-chips.com, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 detlev.casanova@collabora.com, hjc@rock-chips.com, krzk+dt@kernel.org
To: Andy Yan <andyshrk@163.com>
In-Reply-To: <20241228122155.646957-6-andyshrk@163.com>
References: <20241228122155.646957-1-andyshrk@163.com>
 <20241228122155.646957-6-andyshrk@163.com>
Message-Id: <173539494517.1967895.2732995549466236200.robh@kernel.org>
Subject: Re: [PATCH v2 5/8] dt-bindings: display: vop2: Add rk3576 support


On Sat, 28 Dec 2024 20:21:48 +0800, Andy Yan wrote:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> Add vop found on rk3576, the main difference between rk3576 and the
> previous vop is that each VP has its own interrupt line.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> 
> ---
> 
> Changes in v2:
> - describe constraint SOC by SOC, as interrupts of rk3576 is very
>   different from others
> - Drop Krzysztof's Reviewed-by, as this version changed a lot.
> 
> Changes in v1:
> - ordered by soc name
> - Add description for newly added interrupt
> 
>  .../display/rockchip/rockchip-vop2.yaml       | 70 +++++++++++++++----
>  1 file changed, 56 insertions(+), 14 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml: properties:interrupts: {'minItems': 1, 'maxItems': 4, 'items': [{'description': 'vop system interrupt, such as bus error, and vsync for vop version under rk3576.'}, {'description': 'independent interrupts for each video port, such as vsync and other video port related error interrupts.'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241228122155.646957-6-andyshrk@163.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

