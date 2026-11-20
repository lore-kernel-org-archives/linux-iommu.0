Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795188148;
	b=z+FAEBsMZDQJYlD0LIRZC5FIaH4nZ/VU5Qh4EJRPs13RBdF2l+qnqYXptMbdApz5erpc
	 yvM3nD0cnMCR5kC1O30rMh02XWjijctijP31JNt90wIZfvaC3JDYxMQgMGaDmLqfJ6D2c
	 fyDVSO8c67/fN5jGLTaYw/cqRF7xWF7osvoobNrwC6ZtLOzIRi2FzVEQ4EzDX4e5wyiGX
	 rUC+OuGVHn3BxNvPpH+l6ljb4rKcIKtgyof0IJy0Z4+3Cl/Cj9529Q/P8XDOkXeLVSDBZ
	 miqw66P1MVY8ej/FtX1Pjb1WV2YU+JSP6pKf00Qr8hfDQEWlp5FkUl6qUmlfP7PxxvA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795188148;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=aRHH+sAtRFUypl15sibM2v7nfDTia829ulQs8c+9bZs=;
	b=teAlDwsiTSY7Oa0SX6swVmry+v4zD/tkOTs+lPPAZBSGZu8oW0/lgLc3mNsGAutgWf+T
	 QQ9nBZobjLppZMRzW2SPa+Sj/p0GjFwgH8+fK3Y+SQz1GwVXkaTr4TCwFLKY+W+fnyZL6
	 0B6FgfGEuF7ZKzxc0Cy/ySEUW/yiclRe0NEkpAfPfWEXT+j4CanxDZt7w1I4Q0eOnnKOS
	 M7tB6iy57ei03Zs1pl+Wu5flzvqXzX+JdmlryPinBmQyIvhM08p6m3DXg6TC7tPWvX54Z
	 zGGDYIvl3hhomBr+VEro8R/Ff6PDvXwTefT5N6HvDtBRmSBvObB4DtEqe92Mj/MlgBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="JiERA/xj";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416C4606A326
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 15:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 416C4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JiERA/xj
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c5133831027so154959866b.2
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 07:22:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795188146; cv=none;
        d=google.com; s=arc-20260327;
        b=jiCnQyJO/XuY6vaUoCoxQQxtuHbclBpnUsb/S07lO4NSFMY+MNuJPYmoDgM6ualB0w
         1T+ozPe5ibbDqau6X0AM1JOKqbfmBZTLKRQjaLs5iWBi6fVzpo3bDhiZdb+4TBWQ/XfC
         wMDlL2qdsiah7o0SLz+w6r4FApcKAjfsjq6M8q2ur3D2Dad0p4TTRLA40LNp1d2y3rJd
         ZT4jDACPVOe5n6QpXhNAJQwF0Zuo5SgbUzMXJoOJ+GbbbkgnZZGWWX6ECKKNC1+XznQO
         Zolc7mhTQKTYCeWVldWy9qreKDXh9/8YhKG0N72cJZTepLvZjLRU/YqB64+VeFyoz9h8
         X2WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=aRHH+sAtRFUypl15sibM2v7nfDTia829ulQs8c+9bZs=;
        fh=Svzzg+rW4lX3XRl6pIl/Y4p7B41I41DkpakwB53MazI=;
        b=h6sgBE/ZPYqWeTLSRJLhPfqx3+q5gu1qtNUMlqNNmWfEnQXVdUgxmunRImssqEynN+
         Qr99Qje3Ka0+Z4c8H5u4Wey/lsQ90ctt3Sq8GjtVI5IKC9hhzxvgd22XaCPak2n/Igtu
         H6NKHC2UKOhfoI3ha6rQfozTxSZYFTy59ZI5oz8HJH8WFUOIw9SwjlCqJQNCtrNi6dQa
         KnpI0QYckCSbnxcGcLGpyEq0TB35d+X103iOTh4YbDoBHttIA5gwRZjoGFIiql6i8Skj
         5jd8Nd9uXrzVaPNJ8SWY/PeoBoJyhT/MrHFuVZ2VIRJHW5Q363cU7uuSDyzNL6EB8vjq
         XPFA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795188146; x=1795792946; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aRHH+sAtRFUypl15sibM2v7nfDTia829ulQs8c+9bZs=;
        b=JiERA/xjcLx2puoMKJBFrMt+Dn/nj7ChZRnF/WDe6XRoLlAUgaRlFg0uQ57QZUAcdw
         ypbFNm+cHPzEBYO7dmrz+E3ROmpf4xVSu1/96P9sXKtIynG181xp02W/mlyNqj5S4LCD
         6AIFke61pFOk3WAD78xzzamT4ssuiDop36+PDPDlUJbPde8v+tkKOh25HWnP7TK+DX9B
         T6rjPBkSOwcpt1hivhD50PtsFpG6kpyJuy3T3mfC2YxXTt1lybc7E0Xm21sPCUOmB+zP
         Dx8afl02fN5kNe47jo08XfoB96kpVDnnaYXdhbScw8l+0tNWv2wmd5Qa6xSJpPgYEg4/
         pRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795188146; x=1795792946;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aRHH+sAtRFUypl15sibM2v7nfDTia829ulQs8c+9bZs=;
        b=H/nMXCDbQHcIfWeQ7koxltOeGhw6eiQRO9XQA6NmsgK05L9PB0RcTB2e5VyWPQaj15
         nk316SPf8X4bQ2w4CQO92ntjse9jd1yCyQyynq68eC/5T4EV+gEbou5n8I6XdblYwin2
         NgAEJEVhkOH9HDGWaN/4NmS2t5HuTBLXikq3wk8Afs/Z5Nl98AHcX2DDB3cLmtsDgZse
         IGgeSwBiNtySI5GQRTPdBNHzG2pk7aIMTS1bq+LvV8vILtaW/lu3tOo4JrHW9WQhPldc
         hyEGrxXGt4drk1hPzhBWxaM+JGYbDfBhH8GkdXqpHbQBRzEVohYKRdGmVqkwQHyTwkL9
         3XeA==
X-Forwarded-Encrypted: i=1; AL+hErHXYbJ55zTp2PMi4MHDcOCAOPlmb4qtF+m1FVket+DnIAFE5vSQC05Eb0oMNAKWcsU6gZZuRg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+mDZW53mEQdueoFA8PRq6OWPunhyoRFo6utx3ethAR66ELZX3m
	iCdyY7VEYVAGH3rv71Df3QCGUW9dZGH8ZLry25ex/rq7qN5XXcG/O63ze5rSfx+dCSQ43TQ8WtN
	vRg5749OjfMvAQ1kCTsqZ456TVtVbGQWiK/J9E5o=
X-Gm-Gg: AZFdTZf/posZruPJwD3cGAJhE9gttriAhJ8twf5rGW65kWhZbnAmffS9FqquK81l4/D
	K0SA2QfiDZMyPj68NX2BUEaDkSdkhDyq/potfsGvsyIo1SRjOxaOu/Q9/2vpDCCPke2WTCMynUl
	HHEVKZ2jion7W8GqFSME6/8VN082O7Z5kcPL4lFItZ8rNnJjjjj1lxX4QZJbiEuEa2PtK+jswQy
	ECkOYZlkreGj1W043lWIGm3oyR6OYZQKRMGOeeflsodyeR06g4Da0cD92wBImiznBt28bpWFBr5
	baIh0ke80yRZ8qDq94Aa/yn5fm5f9fmkIbAS6R0waEtWTIfLXWSeAdFdl/b//kTYcPx4UlI8EJt
	3gbblxzE4hvOTwpey4yGcDk+D2mQKbJ7Gm/Fco4Pc4t73di3xRsvwRf0a8ZI=
X-Received: by 2002:a17:906:9fd0:b0:c50:a2f1:f200 with SMTP id
 a640c23a62f3a-c513a5da8e7mr358445866b.16.1795188146447; Fri, 20 Nov 2026
 07:22:26 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <CGME20261120131146eucas1p2d05549af0404d6af77ce3e9385e91fa7@eucas1p2.samsung.com>
 <20261120-upstream2-swiotlb-rmem-kvzalloc-v1-1-1c5f9b503223@gmail.com> <7cfe91c5-4053-44bb-8c18-612fcda90e4d@samsung.com>
In-Reply-To: <7cfe91c5-4053-44bb-8c18-612fcda90e4d@samsung.com>
From: yzddMr6 <yzddmr6@gmail.com>
Date: Fri, 20 Nov 2026 23:22:14 +0800
X-Gm-Features: Aa3M54rK5DMeMpHLCfSfWl_qJSt25BT20Yvx5W-0uuT9RvDVQDOYBPvqh2JYtGI
Message-ID: <CAB63uaFw9QjjN131UjiJvpp6qHM+xw+-9wEcujuNoYVzhmXtOQ@mail.gmail.com>
Subject: Re: [PATCH] dma: swiotlb: Allocate the restricted DMA pool slot array
 with kvzalloc()
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On 20.11.2026 15:18, Marek Szyprowski wrote:
> The change looks fine, but according to kernel rules, the patch must be
> signed with a real developer name. 'yzddMr6' doesn't look like a real name.

Hi Marek,

Thanks for looking at it.

yzddMr6 is the name I use consistently for my kernel work, and mail to
the address in the From: and Signed-off-by: lines reaches me. Since
commit d4563201f33a ("Documentation: simplify and clarify DCO
contribution example language"), submitting-patches.rst asks for a
known identity rather than a legal name, and that commit notes that
nicknames have always been accepted. Mark Brown applied a patch of mine
under this name to the sound tree earlier this week (bd6e011c8121).

If you still need a legal name in the sign-off, mine is Zhendong Liu;
let me know and I will send a v2 signed off as
"Zhendong Liu <yzddmr6@gmail.com>".

Thanks,
yzddMr6
