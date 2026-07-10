Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E93312803;
	Fri, 10 Jul 2026 13:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783690987; cv=none; b=qI5GKOQ2R9wNIYlGWRlqfnNj7N5Zh4uWzjPglOhzJMYrP7kWZ4/aNGhIzFQrjwSzTco9yWXdq2ylP3jG9g4/OT4pqZi7gh0IONLlhTGYnZcJ/fNNZH6DIlwGjW9DG8KD46z8+8bVptM/4fFCZonIk0kLRtLBADm7ODs6O8VMKq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783690987; c=relaxed/simple;
	bh=zHLextF0hlViXQEw26iOsQoHcF59cLfw5bLkeCkrWn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DoajxIOLH+pIhVvX0wtR1kEcNh5eMYYRe9aSpmFEqRL7RBGNlv71tB7REKNfXBZoNvpmdQVutkOvAPmsa5mQsBPR1xyN1T+STcBmV5spdUAP4zpArBUgKqjmQIdJsCs/tkLV0oSbaEBe/XFyv/Z6/NiFpen5Fpp74WLelSy9AdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=MU+fLHrC; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="MU+fLHrC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=VTWLYjdgbzHqJpZ1UgqhE3ddioxPi+X5APCbgrRIKAM=; b=MU+fLHrCTy5vRdOMD9FH3w2RGN
	hECCq8uevcPfomhKkp9eRAadvXsDVWPPbK/nRKSMYi99uhcRuaO9qpkdlYA4eJHrJpDQEeGXWQtAf
	gXhGEed22qTptnsXusJbntmkMNb6zkBLm/UygpjYHgAmU/qEYlztvwlSNLBqBG0cRBSBVRf+7r9gK
	S12opPlv+soMAE+FLbnx7UbO8aOa4BGcyAVp+uhd6L6Lm6/NVahgQhhqLENxKnkICszFNhp89qeYk
	/3J+l3LlhzCXxlj+jl6yTt888um3CCDdSh9zlfzJK9IRa64JVv0I+eY+jljXzjAE+uqfNT+5NqYFS
	jIZU4AKw==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Will Deacon <will@kernel.org>, Jiaxing Hu <huhuvmb88@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/rockchip: implement .flush_iotlb_all
Date: Fri, 10 Jul 2026 15:42:46 +0200
Message-ID: <12654012.zAa99ISigo@diego>
In-Reply-To: <20260710111508.917486-1-huhuvmb88@gmail.com>
References:
 <20260710060513.863714-1-huhuvmb88@gmail.com>
 <20260710111508.917486-1-huhuvmb88@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi,

Am Freitag, 10. Juli 2026, 13:15:08 Mitteleurop=C3=A4ische Sommerzeit schri=
eb Jiaxing Hu:
> On Fri, 10 Jul 2026, Will Deacon wrote:
> > So I think this is the wrong direction. We should try harder to remove
> > the function rather than add new implementations of it. I'm assuming
> > you're only adding it for some out-of-tree code that calls it?
>=20
> Yes, that's right. The only caller is the out-of-tree RK3576 NPU
> (accel/rocket) bring-up I mentioned in the commit message. There's no
> in-tree rk_iommu user, since the in-tree consumers all invalidate through
> .unmap and none of them call iommu_flush_iotlb_all().

accel/rocket is in mainline, so I guess the interesting question is, why
are you expecting your changes to be (stay?) out of tree?

When you show your changes - even as a RFC - on the lists you might get
helpful comments - like the ones here for the iommu change.
That might also prevent you from going too far in a suboptimal direction
and thus could save time.

Additionally, you would show you're working on that, so that could
prevent someone else starting a duplicate of your work -  or at least
pool resources.

There are a bunch of people working on the RK3576 for different projects
so there is a pretty high chance of getting valuable feedback.
(like what happened with this patch ;-) )


Heiko



