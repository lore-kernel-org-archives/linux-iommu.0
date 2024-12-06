Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6871C5490
	for <iommu@lists.linux.dev>; Fri,  6 Dec 2024 20:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733517406; cv=none; b=SD6W8uL13Ca2GMS1Hb9ch3VG7bF17IW3LjIH/GxQ7iGQpKfqGcQYNTws6erSDW0NJQ6pOBTJPDy78nJHft9x4I5DbQuXZUat/rlt7KAis2OLpykHPzwgKPaq7RrpBgva4a9jpdHajrPbDsESuYRjHNNuoywRJVTbAqIP4KCD5Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733517406; c=relaxed/simple;
	bh=/id+wG1D9cmIBpBBvP8YZBNvko2ajxmLL0iDo/a53z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ItQTeZL6C8xPgCNUxZm7EyND7kVPz+T+9S5oxiS/aTvrnH1Tk3Xo16yFpl8YhiOyByStGvU512hpU303+6pKgFR84YmQxjJs7EmasfnlcHD0rWUb6kuJD9z+529jIAz1Hj4K8ucDoUrJIwN9u44x4mVdvNqu178z5V6mwTgsRg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OyfcePXf; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyfcePXf"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa53ebdf3caso444682966b.2
        for <iommu@lists.linux.dev>; Fri, 06 Dec 2024 12:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733517403; x=1734122203; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/id+wG1D9cmIBpBBvP8YZBNvko2ajxmLL0iDo/a53z8=;
        b=OyfcePXf6YaIbyL/7J3b5sPCktr62Ra39I16+9kg52UVXzcietb1psfs494em75/k2
         QNmos/a/IPE11fKieonxVKrOGMlb1wfAkANsw3G8m1ar6937M2XEDs9D+TvOfMBopauv
         mOMP5Ly59V76m4ao7fUgiRlmkhxZO+rqRFYlHZaUGHwxMrLFyzaAnbncGZDIS+MGqcVO
         jNHbZujUSEvJZd8l6HbhOrxsXKWZPCqRSi+ny+zpQcaBoNVhp/LXpmJArM0BuBIeoGpS
         SBblBA51lovrsxYSOes7+FUx+E6bdIqXrMDnbIK+23qp1ldydjCik3xz0JZe9R4BBIpO
         0jZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733517403; x=1734122203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/id+wG1D9cmIBpBBvP8YZBNvko2ajxmLL0iDo/a53z8=;
        b=mqgiiHvl6p+4DSorNr6iSsp/woXw0r6hGnlChUVpw1sHSzoQeRJxiSKXCa1JrE/CS3
         GjigxQLBpJ7J3Q53n7zxFW28i2wfVnQQaSEw1rFeHizC/6SpJJpEqwDtRNk4LmwPzBM8
         3RoSt5ynRGJqvyvdk/LAb3ehzIX27msjTeVxSCQdBei4upfmSVhiBCIMIOvLIPfAs2fg
         GHEw4RnCNFY4XJQ67l7ZTOCaIdeQLCdJQfbBaf1K30lcX7JDDvviWtjEdTy1Gz4vRcZZ
         nJYtlJ4i7N8VKEmh1pOUTvZv2Z40qhutCuK+raZtMjCavo8sQC8lfv4PPnrm65BwtHJh
         yC4g==
X-Forwarded-Encrypted: i=1; AJvYcCWEKvJa48OzeaR8QBUrAXQPgNaJcG29qCH7465vRuiKiTf4QucjWxkX3N/utXGIQLnsPbZS/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxTyetjFDbdMI1Nk4MvDOgNDDYQTONr7gBrIDi6DIR1YmScrCAR
	jYTYwz5rDlxYoOzRRsNdR+IGDMYK6OVUpsKaDFTq04KyjejXO8TavQOFqw9Q9dwY/yZbQAL3YyZ
	WE4gG813Tqc0nvur+HcmIj7N3EdA=
X-Gm-Gg: ASbGncshAaw3WLblsmDMpun7Paoy8erizjVFnUSJFT1fEaYhseQd/tm1uNPFRuS00f6
	diwZjXeURli982jA5h0BxgQUJdVEuejSy
X-Google-Smtp-Source: AGHT+IET9rxrpQyDvem/Cv+5KU2pGD5o5DyC1HpeiVmEBQsKWBI1BwLsyavF6bTYJOwCJBonYIoyPpGumUvyFlE4Ies=
X-Received: by 2002:a17:906:30c1:b0:aa6:2d88:ca7e with SMTP id
 a640c23a62f3a-aa63a2c61femr439703766b.49.1733517403022; Fri, 06 Dec 2024
 12:36:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241122191304.4182642-1-bjohannesmeyer@gmail.com>
 <20241122191304.4182642-2-bjohannesmeyer@gmail.com> <3d1642fb-79f9-4abe-8856-0ee67da9666c@arm.com>
In-Reply-To: <3d1642fb-79f9-4abe-8856-0ee67da9666c@arm.com>
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Date: Fri, 6 Dec 2024 13:36:28 -0700
Message-ID: <CAOZ5it1EGwZJYVw42mA=BGwS7LFTo=QMuOuq7trvU5C+u7EiZg@mail.gmail.com>
Subject: Re: [RFC 1/1] swiotlb: Replace BUG_ON() with graceful error handling
To: Robin Murphy <robin.murphy@arm.com>
Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>, Michael Kelley <mikelley@microsoft.com>, 
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Raphael Isemann <teemperor@gmail.com>, 
	Cristiano Giuffrida <giuffrida@cs.vu.nl>, Herbert Bos <h.j.bos@vu.nl>, Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for your feedback and your patience. Apologies for the
delayed response --- I've had some personal matters arise in the past
couple weeks.

I had initially prepared responses addressing each of your points, but
after revisiting Robin's insightful observation below, it seems this
issue has already been resolved in the latest kernel. While I=E2=80=99m sti=
ll
happy to address any further questions or comments, it appears that
additional discussion may no longer be necessary.

On Mon, Nov 25, 2024 at 8:03=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
> Hmm, looking again, how exactly *does* this happen? To get here from
> swiotlb_unmap_single(), swiotlb_find_pool() has already determined that
> "tlb_addr" is within the range belonging to "mem", so if it is somehow
> possible for it to then convert into an out-of-bounds index, maybe that
> does actually imply some bug in SWIOTLB itself where "mem" is
> misconfigured...

Great observation. Upon reviewing the latest kernel, I realized I had
analyzed an older version of the code that lacked commit [0]. This
commit introduces swiotlb_find_pool() into swiotlb_tbl_unmap_single(),
effectively mitigating the issue. Specifically, if addr is corrupted,
swiotlb_find_pool() would return NULL, causing
swiotlb_tbl_unmap_single() to now return without invoking
__swiotlb_tbl_unmap_single(). Consequently, the failed BUG_ON in
swiotlb_release_slots() is avoided. My apologies for overlooking this
recent change and not verifying the code path in the latest kernel.

That said, converting the BUG_ON to a WARN_ON_ONCE might still be a
useful improvement, even if the immediate issue is resolved.

Sincerely,

Brian Johannesmeyer

[0] commit 7296f2301a057493e97b07739213c6e864f76891 ("swiotlb: reduce
swiotlb pool lookups")
