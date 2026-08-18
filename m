Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2D4442386
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 08:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787043552; cv=none; b=C42LQzpqdExthbueE/4bQYEwGklQzpXRmVmAE2spVD9hE1gVtcFSqSyP/lwwHPj9fKByJr3FlyZf/kL3bpW0NKZsYwynEn2DB41XESHGk5tuWgy5+JxYs4BlrO1yIcSl3Fi02PGG3MZGZB59I3pfaICbVNHDMCJjvBxAOwytS0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787043552; c=relaxed/simple;
	bh=Subz9kQAjDVDz99QceolixIbPPedVcJymvxPaJCPSdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNffzFqqQdpeewRyRAHpadUscDklihdzW8zo9Fh0BeuekYdJMDb6bXdol6L6Yo9W9UnYplptDF3Iz4cupnqQoyygZszKIwAChP33v0EtwtNd6nsBE4jk6KVOo1xiul7vhX7na6w9fHtXbsL3o23GK7T8lhmvVdQbc3X7ZnnOOoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ou+6/z2Z; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ou+6/z2Z"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47f84023916so4155013f8f.3
        for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 01:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787043549; x=1787648349; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q+Aet+yk5wErYuGPUVzhzsTqySNhCGJLGb9Ej6EWM+c=;
        b=ou+6/z2Zj2+kUDyC+6wQyd6IMjB+sVoTqwiGU74O9gpIitYDhz5Vt8sCN8Nkeoc55M
         v9ZJDsr1hV1PMfw9N3Oyv5aBwedek3wtzhJvEQ/JSc7E1VcdlqL2U+Bvh2EG2fGETyXl
         4hUTxJKdiuoA+GYov9nta48rd1t65MqvG4WGjTKUoy6PXPKQzDuhGwLuEgKeSAkv3Zkh
         FJRX+HJIJGNhy1abb2VYfG6B6eNlZFhWcRKxfIS5h8Xww0HUOMKy0V9ZoEzBwhsmHurF
         y+XwJgbkBl8VSVEC2lsrbvnXCGk1rg0milz93mMJJmddrYd7bD3M1ChktThL2O1+PBeR
         yzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787043549; x=1787648349;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q+Aet+yk5wErYuGPUVzhzsTqySNhCGJLGb9Ej6EWM+c=;
        b=kCT/UkuSzJMEkCGOeq2Zm/+Qh78ByveUwW/BHMhxN3cBB24BjDAlHhzxDw3WdSQiKr
         mQRlcBxWxnmWS0LNlZDhAArKvjcGwQBu3j5JlaIXRl7sq9ZdSjQwVm8/PnBXt/57vYAT
         5cK1Ntz1rYaVX7RzW33fC28oU1kF07C1oHWQu8wDtkF8jMCZxIj/yvB+G9v1OKAo0tQZ
         gVIFf2bTSP4kYeCAOnSIAEKv+NtjLmIjLoHHHT7zsNCIm6T1bqcn/2K8znjtRToW2c5u
         N9EXMNfhMgGArd1kjkLClCujJDmi1mD9clYrYPHIo/FD8NToB7NgIwYPfmqjM+oS5TON
         BeSw==
X-Forwarded-Encrypted: i=1; AHgh+RoAGGd/7xaRAznxWS4ixt0CVYHX0UGJ64eaOkA2RuV3SgAZpDAtv5bacaFfKlLG4bFwM1fIKQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwspR//UJrooUOr6FAZzENUC6DRIyC7kQdtnogZ0llw0vNNbJR6
	giVStdO4fprgcFCHTReWMA01HrSKvKH3xBLDs4xjHTVMIFLjKMHvs51tesy8Hnq6VHQ=
X-Gm-Gg: AR+sD13ezXHAIpaQKtUaIRXgvDdfDia61g0i+PWW++8kA5t3EhyslolTqHlSSo/cqt2
	e06yYXSXvtEBnAtoocca/7Y1/t8I91ScyMmq7xh8R/UWYwWxq0uWksRtxcJGTmcJOxVGxW+AUge
	cND191xVdbli87fMyMos6Wxb3RV+UQ0BVjjhfViZH76UgSP3XMx18um47cgLxSciw2JpLlgC1aU
	rXjxkJ7wuKNzNpaR45Zni3ihHbjpfaIPD2uNKk/DUYKehUXHjoaC3NiRSzh6LYXjdtYqZuu2+gn
	8VJJ7nuwh6FN9Flpb6L+FOOjlb3WZ+0BnkJNKg3mc0SyXEg4UjvE09yXcoE6+uI2sQlmFATinbr
	PX3HU1dxoMMJnapNrx0DHWRCkUhHwTuV/J3KnSjpedHU+z4A943uwFE+nlOFUm532uYwiQ85DPt
	L2CdI97O1hYeFmEd8NpvKRKlVxVYknjRLk11TKaIMsJu14OqVmgCJBGY+01SZS8WLz+oyYmw6cb
	zfSQP4YTHSuJYPDtO6mtc9Mwxd2RzP6/8Im1wEP4ioe7xlgHxTl
X-Received: by 2002:a05:600c:848e:b0:499:8156:cd3f with SMTP id 5b1f17b1804b1-4999fb3f78bmr112284285e9.8.1787043548729;
        Tue, 18 Aug 2026 01:59:08 -0700 (PDT)
Received: from localhost (p200300f65f01710416869d85a644e839.dip0.t-ipconnect.de. [2003:f6:5f01:7104:1686:9d85:a644:e839])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49987b278fbsm215087975e9.2.2026.08.18.01.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 01:59:07 -0700 (PDT)
Date: Tue, 18 Aug 2026 10:59:06 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de, ogabbay@kernel.org, 
	zhangqing@rock-chips.com, royalnet026@gmail.com, chaoyi.chen@rock-chips.com, 
	diederik@cknow-tech.com, alchark@flipper.net, dri-devel@lists.freedesktop.org, 
	linux-rockchip@lists.infradead.org, iommu@lists.linux.dev, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 10/12] accel/rocket: add RK3576 NPU (RKNN) support
Message-ID: <aoQdns-GHS3fg5BJ@monoceros>
References: <20260817113603.1436067-1-gahing@gahingwoo.com>
 <20260817113603.1436067-11-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uvayaecgmyelikx3"
Content-Disposition: inline
In-Reply-To: <20260817113603.1436067-11-gahing@gahingwoo.com>


--uvayaecgmyelikx3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 10/12] accel/rocket: add RK3576 NPU (RKNN) support
MIME-Version: 1.0

Hello,

On Mon, Aug 17, 2026 at 11:36:01PM +1200, Jiaxing Hu wrote:
> diff --git a/drivers/accel/rocket/rocket_drv.h b/drivers/accel/rocket/roc=
ket_drv.h
> index 2c673bb99..0096c4ab1 100644
> --- a/drivers/accel/rocket/rocket_drv.h
> +++ b/drivers/accel/rocket/rocket_drv.h
> @@ -6,10 +6,12 @@
> =20
>  #include <drm/drm_mm.h>
>  #include <drm/gpu_scheduler.h>
> +#include <linux/mod_devicetable.h>

Please don't use <linux/mod_devicetable.h> but <linux/device-id/of.h>.

The former is a mixture of many subsystem specifics and thus a
dependency-hog.

Best regards
Uwe

--uvayaecgmyelikx3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqEHtYACgkQj4D7WH0S
/k4U9gf/aUhrYYFY54POvnsxnelsCZk9pbdIP6pqEh4NpwVQM+NfUIh1SYqcLXIf
NqdrFegte49P8wGlByYbp2BP8P+Vh/KdPn+VPTi15o5ivhF6/lS1s3Smp5hwDS1N
lDMzlLblQBoye2bS2VSkmaaJyzaZEARrJK3GOBpmc8PXGkMOFRFgF+ZgXiyEC91u
E3rOSqRX153lKJWaHX3SH4yO0RUjN22sW6htFUwQZTm4iLRG6IzaP2+BM2cpWnCe
I4RwXW6GaPue9NnC/Bf/659cN68fjK7fUU5JJn80cMtfO47GjXmA3ceX28vIB/rm
WKAMBlhKd47VGV36uZrPNREsoz3v8g==
=ee9u
-----END PGP SIGNATURE-----

--uvayaecgmyelikx3--
