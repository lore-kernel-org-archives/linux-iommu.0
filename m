Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6461B13959D
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 00:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792025467; cv=pass; b=iCzzT0t66U+3ramRTI8gLX8ZuLdEE+x6DGLaRaY8fqWUZHKQ0ZZJ4foV6m/7dh3CIoPHUNphcqUTkG9G13G9OzKF5j+8CwNhh8y0HpS2txeFH/Wudv5Cqzn7QIOvDRORgDRhdpRvzHPPmWtSSqac1LsVh0qEGGLf3qn5GC03HeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792025467; c=relaxed/simple;
	bh=rUkvizF94O7wbkK+B9hI74UD1HRMZ0AGrNVXGILC+RA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YBqmLNQIXlYpaacDCGQsVuqT/bFQ+Hl4op9+159RDbeSwBWeZluoeZ1u8+mB/l82NtoqX1T87ErSp4nr57MxDA3dJGxQPLKimbF4F30m6a+sqceWyxJ29wqZuV3twqKtUTgFKYXKkq0J2QGXsoECAfLahIYNtV2hmFMtPn0CQJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhVxHDmk; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhVxHDmk"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b1dae0febeso1940985a12.2
        for <iommu@lists.linux.dev>; Wed, 14 Oct 2026 17:51:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792025464; cv=none;
        d=google.com; s=arc-20260327;
        b=pUMcDExIKqdwVBjDrX9oIkDIGOjOeOEj7S/88dNfvpAqpb/TqsAP/EWsDQ0lGIdYB/
         IVu/UMQKEr/3AF1xIVM60T6fdKou5SnZJWCy86BE8C0+Z+N/H+4KMJ8KWAqp+LJxRPqW
         VJDK0ap8z859oYegR13Fpb0M5/8r13pj45LfomBTgTrBqQURGyfDqYZ8smvLkyoPM4hY
         luZHmS4X1Fod6MrfZ15VJHMtYyaBrbKx8d5kERZvcI7FLAENiq5BVjtmE4ptFFUxouNU
         2NYKgJ2u6vvefZyMjBWmdxVJC4nGN0SJSVXU4H/6LsWz/0aYrZWmm3NStbrCDtV8lJv/
         4wjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rUkvizF94O7wbkK+B9hI74UD1HRMZ0AGrNVXGILC+RA=;
        fh=kjF9BSI3fHmcPekT7zR8DbQ4kMR9IZo8Xv6F6CwZJHg=;
        b=aCf+LNloW+0YFnzUTJ2ydS1JKZ0WgFkSEqleKrLEt4ggS1vm6wj2ZWkqMAuyTCvsD0
         dLUTn6PvpAuDHwdjOYWEY1C2tQYdyVmt+TaZRVRAPpJzrIJVN/dqXBo8sjwDCXYYc5G0
         MLj233SjJp3T7TSw0ZEvf8FclVDAHlo1zJnIUY0TmbX/YJPusVvNf/iifVOd1r+FXn0w
         bQUNFpR0erT1dldkFuAWEyWPm9OE6kqi7s5I8Pk1DXftNHCNGg3QkLpF1IJKQc8OMuv2
         2qvKPMAUT0xLa41Q68IJc+xXwDnzs40mNtQCCxCMfWF6jPfzHvtPNh91R1TbAHaVibGs
         KzCQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792025464; x=1792630264; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rUkvizF94O7wbkK+B9hI74UD1HRMZ0AGrNVXGILC+RA=;
        b=MhVxHDmkJPObCOsh8a/wklvIoDipiXyXcZ/WKtiAcW54GhD311NveUQBp+3n/0Euu9
         YdisYKT9EOUn81RMeasoGm/0WWZra7F9+1gu0dMnvJsTsGfQ6DNPZrBKlyxoDiYQsxaJ
         V50MJLzHlsON4C2P70dDyRUCMikEB50VRirb9BhUediOvp3Y07V2rno+uvSJpKpVcpJa
         EYQhYwLw5kmkgoygfSFdcZq/Z7uBGMiA4COBXtJXbexCO0GhpL/yNSBAoC+7xMwGUTVH
         m501YrshGoZG3xkc0Q1uy2FN+PkZYI/CKnCs7dY6mDGK/kYQhDIXEWcCXWRFeKvq4BR1
         foZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792025464; x=1792630264;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rUkvizF94O7wbkK+B9hI74UD1HRMZ0AGrNVXGILC+RA=;
        b=q4ntNEVlEKcKGOAsvyy3BYNUZ6mSrU5qXsSW1B33SJFFXYxG2ZT49peJQCSBti4azD
         rcdJzS94fbyTsWnnamMVDNdqUOgOXp5Z42QKWnEClHr0+rx8MLf+fr9rRkYKuqJe1vGE
         3+fNuFbvHCl8/Lm4VVKzr2F5JaL5eJ3w/0/si2zm1b1FSp14qFguOmmrSsAY2MZ3kx3g
         YMMhXVwwEi3VYBkMC95lppAAtztn5m1O0PiBAFXjQgm0cAoWOWUfH2KJsBHMeSQSquuq
         8nk2Snw2zL91kqxe++XKLgkU5uolh/ImyL9aGNioE2gUp1Q2HXu8KOJg8pyze42hk5fc
         QRFg==
X-Forwarded-Encrypted: i=1; AKwUvBwja72uG/FP402zfvJvF5757dDBqyHDU3xBqO28LOkS6BgxhDA6RICdBQ6dDo2dymqbwuvoWg==@lists.linux.dev
X-Gm-Message-State: AFq9FYLXEbUE63QcPg+ybwY9nds3zkyOTl76KOlf/3QzdvAfvRBlDO7i
	z44lIq3CKk95nLc9LT9k0/3pXtB2yhzQQNDKUAdXhbJxHTjlcA4xdR2SGKNyMr8pmgopPu4ufiQ
	WTXfGg1cBgQlYwKmu73c3tl8xb++1xr8=
X-Gm-Gg: AYBFou1/ShjL8vwABdfpKTDN/9OYM+7Dt44LjM6fwFJ2915FEgMPszKJuqqx9Fn4tG8
	y/FXzkYKCrnyTqr6HKDN7qBu3Y1XCWDGd7Eg8R9y7k1rkOuGDLHrEX+a3zNKC0sXhpFnNbEF+h8
	0vwuMECH5etP6WPoEvBp+TS/8+KnYMJnuPhQ4cnapQPehFp2nSXEgu7uB0I+nM6E8z+gHk7fVDq
	ZkGmjPRQ7cvxJ+6cug1EU0QJehpbKfC3dU/yz6nTyeGzp+irKEhZbbqPKUCmu/yzu4Owp7vOHUS
	cVQPPNHyD8/7UtwglIAkGpmp7ewcUV6Fnh3fONeW19qoOrphCilyxdZj441S4xt3CoAtRd7ong7
	uHZxB799nyul2
X-Received: by 2002:a05:6402:455a:b0:6b1:e8b3:c3b5 with SMTP id
 4fb4d7f45d1cf-6b1e8b3c65amr4467054a12.6.1792025464368; Wed, 14 Oct 2026
 17:51:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261013165814.3092559-1-samarth.colleges@gmail.com> <20261015003412.GA13920@nvidia.com>
In-Reply-To: <20261015003412.GA13920@nvidia.com>
From: Samarth Narang <samarth.colleges@gmail.com>
Date: Wed, 14 Oct 2026 20:50:53 -0400
X-Gm-Features: AclHuK9892uYyXNXapLy9aok7YxBXJNaRdpJfdG1a3-YNrgC35sKsdI5-DIcB0g
Message-ID: <CAAbz3fSE3cnjRXcdQkx9EPuQwarhH+XasQdaEvh6X8eCg+osQQ@mail.gmail.com>
Subject: Re: [PATCH] iommupt: report the whole contiguous group in read_and_clear_dirty
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks Jason, that makes sense. If it helps, I am also happy to send a
v2 of both patches along those lines.
Best,
Samarth
