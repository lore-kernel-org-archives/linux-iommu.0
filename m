Received: from mail-43166.protonmail.ch (mail-43166.protonmail.ch [185.70.43.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65FA28A3FA;
	Mon, 25 May 2026 19:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779739086; cv=none; b=sVRbXj6SLVMI5oe0N3uP68wU0UOIsbuh3FN6qzmyq+3vGZ6F51tsaZNeKlNWlDmkuyKL1IjxDc0P3DBG/W6mpgHCPIVC3PbatO4A1MNHxWxF9c1MnZE43q9SFMsKWt6COPFxtQcWRiLb4i4l0AEhb+UecN775y5lBpa3GKHRFdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779739086; c=relaxed/simple;
	bh=F3sBAHDY3dmezL9//b0IHl4EvGIlwH5Z3hS8+5rg9+k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pqbp8y87b9dXMPMYUr029rgvsK34b9xgkrTelBNYX7f2NKGv6oddEJAuKdDATLnNlKLD0uA5T8A1tqE6EGMwmNEmw+tzXYt56ypVn/ErN1a0VBOLXZTvBK/8N2JRqTUEzCPE4Y1ekfgsCFFI8ejG2cCng8j/1sz+t0zewrmZd+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=VwMWiJIG; arc=none smtp.client-ip=185.70.43.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="VwMWiJIG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1779739077; x=1779998277;
	bh=F3sBAHDY3dmezL9//b0IHl4EvGIlwH5Z3hS8+5rg9+k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=VwMWiJIGywzEHQwpkJ7wXwiKkkodZILNbJIest/eyoRr+2k67cCAHCvx6OAfpSeVG
	 yLci6GkaIwf81MSKD1KhxH/tks1DB4zxprVJp4Q3SRCBgAshxPAo7XJHmHV4JDIh5R
	 WxPe06m/o1/4xTr/dxAoEJaTy5yH5koomqqSuh2q42yclme1RbjtaxCHv7+VJh7Mi/
	 VKK8QOx5D72mTLuzu1yEyeDwFoTdgxRrdT1e5BSQ8MwlRrcXU1pTR1m0bm9KrWe+3L
	 H9evMZICrJxcpIS3+bux/lDyp0l1V9oyZWORdLkuoO8fW8WWHTYE2UrY0QVdozvhWu
	 qdjAKkpDN15mg==
Date: Mon, 25 May 2026 19:57:53 +0000
To: Baolu Lu <baolu.lu@linux.intel.com>
From: 70sp <70sp@protonmail.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] GPU passes into VM improperly after c376a3456d8b or a98db518dde2
Message-ID: <5bVscg7a2_H1PPW3HmVtrYv_Xwtti2hzjD065W4OdwsD9rC2gw7sGVEg-2U596VZn8O2LAEfhWeZklRk63ymqNW9220R6R_jjif7BaWol9o=@protonmail.com>
In-Reply-To: <7ec374cb-9a0a-4e30-8410-3a028e46cacd@linux.intel.com>
References: <z7Rkts0EsooZcnCjNfJaK6ursftFU8ubOkH0hcNjzxugEAwGsHLMblOdfoAx-gJzBZ-TMmeUtD7iWBngbFY5UCJCwdSmYqmCVMy-yhbirUk=@protonmail.com> <56ce85d5-e0b9-407c-9a86-708111a8a509@linux.intel.com> <C4BK-Bp_FII0EkxSHQxBS2wO-Age-UxFrp_KfmYzb8cnQ8ZndzBBIPD8S9T86wOifBP0tysQGCFtGQsBsBvG2IzIMw3jb3NF5HGbS3tsawA=@protonmail.com> <d6a7f70c-5a8a-4be6-abdd-5b3decbb602a@linux.intel.com> <7ec374cb-9a0a-4e30-8410-3a028e46cacd@linux.intel.com>
Feedback-ID: 144929603:user:proton
X-Pm-Message-ID: 25272949be4e0c4c782296e3186657a2dafea950
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> Have you tried this patch? It dumps the context and PASID table entries
> after a domain is attached to the device. Hopefully, you can find some
> clues by comparing the good and bad kernels.
>=20
> Thanks,
> baolu

https://lore.kernel.org/linux-iommu/uaUIyysjsnLHVLladjVXkuU63CTRoEzcw3BdlDX=
2cdkt8T82i0AX79VQAJo08uMKvpnn20xyK0Pu2PrtyMV3hmSgcwutWhV14fgjyTW3aiQ=3D@pro=
tonmail.com/

I did, as I already wrote before. I looked through everything I could and w=
as related, but I just haven't found anything. I don't know where else to l=
ook than I already did and documented before. If you have any idea where sh=
ould I look for something, I will do so.
