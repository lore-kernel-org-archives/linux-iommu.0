Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B89B42E43A;
	Mon, 31 Aug 2026 16:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788192525; cv=none; b=Cw0aR3go7RDofLydKK+U1aHgHPnDN/BkcFurhCN4CwBZa6s8sziKd2pSmvaQ57ZZ0yc1eCBcA54kInZ0HHBBZINEd+prE1LFPwJxtcT5g2WincbjP329EuK6XVlVigqz36FHPigiol8srBCv6rOL0LW7Do9uaRBB41ggxMIMLyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788192525; c=relaxed/simple;
	bh=oe8jmr5wJN7KLSPGEqvKyY3zqWGyW9eAb4CvXKkR3QI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCbaQZ64ZDR/39Y36pGGP8fDHImwvuVY3N49lX41ImVQH2VuW1Qf+vxEeejpSEKjwUfdbu5iVKSr5rJ/uqDrIbk+2EPkeKe5D0+ZkAEC5Jc2JkvHex5KdbUYFDHJBXIjJg32INtBNaOO8OXnzrKt9etvjS8Rlcs352Sq5vyzi34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IG2rHHMd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IG2rHHMd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1A21F000E9;
	Mon, 31 Aug 2026 16:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788192524;
	bh=oe8jmr5wJN7KLSPGEqvKyY3zqWGyW9eAb4CvXKkR3QI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IG2rHHMdSTN5T8Tscue257j/AYBgXgO1vxmwCSmqSg74pg4cyIAD3KZqqZZ5F/vf3
	 GhA6an819fdRkrPVcO2o3+ze6mvGWzjCDCYUIO8WJBBfflsv5EbWGXPH8B9ES+7CmW
	 XcduBOBhwNnFQkax7JDbhpHVcf092j/rra+jFi358lz/wlIoIxXxconMXc6dWREAOs
	 Al1NetdMpSdv12gJe4+JFUAB9VcaG5CKYG3nBXEj0Q7Kx4AmEGmNlHLlYRaH23j+2M
	 /J/JMrHf8TzDwkjW/ECPDXPPO9VYlkV8/J9+m0TBhRcc02gwbqV/gzeWETTnnNMilh
	 6kw+b9BVMymqw==
Date: Mon, 31 Aug 2026 17:08:39 +0100
From: Conor Dooley <conor@kernel.org>
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, aiqun.yu@oss.qualcomm.com,
	tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
	yijie.yang@oss.qualcomm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm-smmu: Document GPU SMMU on Qualcomm
 Maili SoC
Message-ID: <20260831-vitamins-skirt-735e194dfeab@spud>
References: <20260830-maili-gpu-smmu-v1-1-253e1108ce82@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4L0kw3mIY27epMHI"
Content-Disposition: inline
In-Reply-To: <20260830-maili-gpu-smmu-v1-1-253e1108ce82@oss.qualcomm.com>

--4L0kw3mIY27epMHI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--4L0kw3mIY27epMHI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCapWnBwAKCRB4tDGHoIJi
0qAMAQD9IJt2HJQVc1nSYV2G25O17O5UbEtMYtq8YRnyOeCKNgEArzf/fjuK1gPJ
Rvee7o08VRF2U8h487tRaY6R4mxJxw8=
=SZK1
-----END PGP SIGNATURE-----

--4L0kw3mIY27epMHI--
