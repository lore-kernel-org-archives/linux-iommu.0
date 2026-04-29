Received: from mail-10696.protonmail.ch (mail-10696.protonmail.ch [79.135.106.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AD72609DC
	for <iommu@lists.linux.dev>; Wed, 29 Apr 2026 20:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777494622; cv=none; b=Sj0XJsMsxQwogSWsejWDtWJ9fIJIy2exK3bkS31CJULZIEEp2nf3NO3rqKHpNKglia2vwU5wwNahrhrcI+k41o6QGrT9L4R1NoLh9ARx1J8v9ff60BFv8SNzPx0vNlKY6p+wTFE6vkUAgoY566T8aABBqD44hmF3POgI7gLj/Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777494622; c=relaxed/simple;
	bh=Shkopm7iRkiRRvMZTEUfotA/mauOc515ok0LWfExaK0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kaEu+ilUATDFjAHdAtgKN7TPRvlHq85Qndw8eImH/zYGazU3xFLIoHWKwpK8Qx9NMPMeJmoKjU8GunF2qsCTTSGZ92atUZ7ip2wEHBHRnPG24vjwePmfsDsNVUybO2kmwwyAAlYX7HGg9hV0Qn9yKcCjcNqS9wX3W9UkXsi1f9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=F3v2067i; arc=none smtp.client-ip=79.135.106.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="F3v2067i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1777494611; x=1777753811;
	bh=Shkopm7iRkiRRvMZTEUfotA/mauOc515ok0LWfExaK0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=F3v2067idAV3DkW1iU/uKrzToucEw00ALf9F2viEhYN/S941Fg1QBVjMgSEMQsjTa
	 xFaDCoHDiKVrdRSobPyeBIFtbK/VlkI1osj7yT+hh8qiOeJuv4LHFfyfTbzqfpH8Mg
	 f0TPlSCU1sZXyu1fJMlyY6EJNVesjqhbEMBo0ZT1T4g2dE1ZPrb4A9igAPyKXj1BFp
	 e8io6RUHi8ghhVi70uK5ubT0RMNw4y/vP8vJQmmutBNjOTV0UP5RWZDsTIFXpCeNp8
	 4h0r8yMutXh1LTzImpPCLs0ldqJEdh0UOO35sj52lgPiRsd3mZ7cO8oDGfC7etiPEl
	 RUrvi6w7YsgPQ==
Date: Wed, 29 Apr 2026 20:30:05 +0000
To: Baolu Lu <baolu.lu@linux.intel.com>
From: 70sp <70sp@protonmail.com>
Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION] GPU passes into VM improperly after c376a3456d8b or a98db518dde2
Message-ID: <uaUIyysjsnLHVLladjVXkuU63CTRoEzcw3BdlDX2cdkt8T82i0AX79VQAJo08uMKvpnn20xyK0Pu2PrtyMV3hmSgcwutWhV14fgjyTW3aiQ=@protonmail.com>
In-Reply-To: <d6a7f70c-5a8a-4be6-abdd-5b3decbb602a@linux.intel.com>
References: <z7Rkts0EsooZcnCjNfJaK6ursftFU8ubOkH0hcNjzxugEAwGsHLMblOdfoAx-gJzBZ-TMmeUtD7iWBngbFY5UCJCwdSmYqmCVMy-yhbirUk=@protonmail.com> <56ce85d5-e0b9-407c-9a86-708111a8a509@linux.intel.com> <C4BK-Bp_FII0EkxSHQxBS2wO-Age-UxFrp_KfmYzb8cnQ8ZndzBBIPD8S9T86wOifBP0tysQGCFtGQsBsBvG2IzIMw3jb3NF5HGbS3tsawA=@protonmail.com> <d6a7f70c-5a8a-4be6-abdd-5b3decbb602a@linux.intel.com>
Feedback-ID: 144929603:user:proton
X-Pm-Message-ID: 9c6464a690565b6ced3136017c15918f85c54e08
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

So I have tested it on both a working kernel (v6.12) and an affected kernel=
 (mainline).
=20
I managed to get the domain translation structures on the affected kernel, =
but couldn't get them on the working one since reading the file always ende=
d up in a system crash or a segmentation fault.
=20
I also couldn't get the PASID table entries, because the GPU doesn't suppor=
t PASID.
=20
Domain translation structures:
GPU: https://pastebin.com/4EY5Wmsj
GPU audio device: https://pastebin.com/fLf7weii
=20
I've also looked through dmesg on both configurations, and on the affected =
kernel, this was the only data I found to have atleast something different.=
 (On the working kernel basically nothing was reported)
=20
Referenced snippet of dmesg: https://pastebin.com/5e3jQ2BL
