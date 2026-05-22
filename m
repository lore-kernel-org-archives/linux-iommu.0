Received: from mail-10699.protonmail.ch (mail-10699.protonmail.ch [79.135.106.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFAC3164C3
	for <iommu@lists.linux.dev>; Fri, 22 May 2026 20:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779480641; cv=none; b=eZ8YC8tvU9YMN0BFqjjo4NJrJmpJgfR9bJNYTqIdzueO3FjFxq2+kT5Bx/iV1z9wkkKu5kARETeOPbRSvETD4A0DBFxO4Dw9eSzpJ4j5oFiy+pMKI91g9ZgSE9kPmgWqaaOfNIdT8PHilR0HJFLD42AG7qmtaYrGmyhnXUGkhAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779480641; c=relaxed/simple;
	bh=gwlCPyQnlfZ6C+ypPKBAhpSEhysRgEbraH0bXHztLns=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lDlLftDFzp37T5fwsfW/jDRHIf3DBzZ7lRVJsb1FKkeIhU4WMdbY45owo67BbkhiVzQrek8AXrBSBceM2+WzQcbsHGTDZjjGgZWqsopY8D5VHMg2Dvk0p+SCuGwbjE1ukK0YfILldgc6sDId1BDqHcTGUvc2a2S3MmQin/r5vsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Z3zGELNx; arc=none smtp.client-ip=79.135.106.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Z3zGELNx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1779480632; x=1779739832;
	bh=gwlCPyQnlfZ6C+ypPKBAhpSEhysRgEbraH0bXHztLns=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Z3zGELNx1o9YwdnSohwHT2xDom2aU3MBErOIU6Ga+QfqMHulfwQJ+Mdv8WsfOkff4
	 chHyiqouV03G23Syztf+Bh0ULSxau4fJry+ATTUEZ/0ofE4Nq772hc1E3Svlb2BpiR
	 qq8wzsiUHpMpbvTZqzwyjVHTcBt8R0XzOBSNNVVPR0+7LOjb5yf16zFTCu+NiFAmVf
	 p3wJ8WYEKKCUt2luJ6gHCxBSq2Hx0EK7B7eLjUvrl8xwlyqp7JwfioN8k2RCOP5lUr
	 2op1WhEdXWxs9Jgc0L+Y3BYqYfyrzECfPj4uXx0xlt4QyPlLL76EU16+T/+Gt2J2yn
	 9amzpn+zp8TXQ==
Date: Fri, 22 May 2026 20:10:27 +0000
To: Thorsten Leemhuis <regressions@leemhuis.info>
From: 70sp <70sp@protonmail.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, "regressions@lists.linux.dev" <regressions@lists.linux.dev>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION] GPU passes into VM improperly after c376a3456d8b or a98db518dde2
Message-ID: <DiVBrBL7D331mvXES94l23_jPi-W461OfedvslCrIInJNKNm4hoyGadbveZ0nvz7h4A-OGA9ALuQiiMMp2BQHgrB2Dcj07ADOQT29-QxMlY=@protonmail.com>
In-Reply-To: <a2a3fecb-5b9e-4574-bd23-fe7e0ce14bfa@leemhuis.info>
References: <z7Rkts0EsooZcnCjNfJaK6ursftFU8ubOkH0hcNjzxugEAwGsHLMblOdfoAx-gJzBZ-TMmeUtD7iWBngbFY5UCJCwdSmYqmCVMy-yhbirUk=@protonmail.com> <56ce85d5-e0b9-407c-9a86-708111a8a509@linux.intel.com> <C4BK-Bp_FII0EkxSHQxBS2wO-Age-UxFrp_KfmYzb8cnQ8ZndzBBIPD8S9T86wOifBP0tysQGCFtGQsBsBvG2IzIMw3jb3NF5HGbS3tsawA=@protonmail.com> <d6a7f70c-5a8a-4be6-abdd-5b3decbb602a@linux.intel.com> <uaUIyysjsnLHVLladjVXkuU63CTRoEzcw3BdlDX2cdkt8T82i0AX79VQAJo08uMKvpnn20xyK0Pu2PrtyMV3hmSgcwutWhV14fgjyTW3aiQ=@protonmail.com> <a2a3fecb-5b9e-4574-bd23-fe7e0ce14bfa@leemhuis.info>
Feedback-ID: 144929603:user:proton
X-Pm-Message-ID: b4b1e4fcfde354171a8a27fa7f0be844ac11e218
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

To shed some more light on this regression, I've found a thread on Reddit, =
which is likely related to this issue. I would love to get this actually fi=
xed.

https://www.reddit.com/r/VFIO/comments/1qiseii/warning_newer_linux_kernels_=
break_gpu_passthrough/
