Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98526386C3A
	for <iommu@lists.linux.dev>; Wed,  8 Apr 2026 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661773; cv=none; b=a9K6e6wjjM3+1GnvbcaXTfdAmPm7sv8HYmmp6r1HB9tpbGRetBb3ySYgXMChv2Q5yGgPvbRNhTqILASQqG5JLYLP5Tt5B/a0vOJgrczI1p1mb7kAbSTCZ21J6cp0EgzxlyEGka1Ak6S1axbTaz70LdIYfDoRbf2kqbVf8htKy0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661773; c=relaxed/simple;
	bh=vA240ToEZpV5ABu1bLZJGQn4hXI4cp2DDe6zTQg0jQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NyAY4hjQClkFWo/13UiNNf1z1xfqjevxkENpp4WNn4st6yEoqttNk1KYwFpwBr1V0oNJH+4RPtgvWnY08ZlPaKJvdv3Pb/SXmtHkiZ6Dh/o6wLsb2H5b9aJZqMsfuwCGXj8qj4paXGB45SpCj1fVOJqzBLn7NHVV4EmnzUbdK1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fsKQ48DZ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fsKQ48DZ"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b9d166ed21cso286097466b.1
        for <iommu@lists.linux.dev>; Wed, 08 Apr 2026 08:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1775661770; x=1776266570; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6oB8sWft0bulZQQhndjF41bb2A55hZmeFDzZlsmEc5U=;
        b=fsKQ48DZpcVGTEOGXq+RU2+D7YftFkC+I0++Ln1GogJWPS06palUZlG6PKVVMDuTr/
         o/RNlXqhqNrg62SXq31qF+DqoYgR7WQHqvqT/BbpAPOlB0BCBcHJLalcXs8vVC2G0qG5
         pnlhWTp2nhwj+QK9NiMd9YhLsnqb6q80KhbZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661770; x=1776266570;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6oB8sWft0bulZQQhndjF41bb2A55hZmeFDzZlsmEc5U=;
        b=PoSFzPMek21zFH14oTGlrAMEov2EdXDtV1wWB+yTF7xdqLO8gSgXkzauf+/7niI5VL
         sdVzHsL2BA5RHdSMJc+Wt2HADPkCHK7u/MF6DbE4IIQxeAW/RSUW2gS1Yuxg9PJuhXd9
         kn7CTqrBHwMg6wS5lijBlVGJFcWeDRRtz7J/vpNefdK2b5of9UxvLljB7xH0ZPkoWUDw
         1J3XKEBLFIx4Pm83UjhA0vGWBaah9oNy5Ux/CcCaSCyL1FD5QrW6QKzUDyZhdB9oNRSQ
         KqsxYHd0apbEB7wUNkmUSeWMOw2zbyTjjAY40+nY1VCJFdJMC/ZYoe4RzSl/Vg944xFe
         2Vig==
X-Forwarded-Encrypted: i=1; AJvYcCXBIKRykaYXhZFm2FN076Y/ES+tHzeFeSwghrWWHJQuMpcrT41yUvgKia4Vo6SbqhU7rcOQLQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXfgSvQbbXjgCZnsnnTdmTm7iyKOsSYOrzA/nOvgsq7Q38s2ad
	JVz357RgSEYAeCifjD5T24/tlP9lG+ujLZ2Lg2wJ3CbPoBe96jw424thvZBljMbZmro76zqYa22
	xI8ThzAo=
X-Gm-Gg: AeBDiev7jGJmW7R5VugS9fjqdaYM0XAlu8ZilXR+RTMpjwB2KPUSeoY50w0cAYCwbYr
	mENy/qDH2WTKUed4ju1SER22knrcLchniERI/KQIdgMtcgOjlixDdUDP61ptc5agfNknUcP97WV
	eumqGxQ4dP4yW4BH9vHTi2bgF7im3GozHBovSkEIifdRJwY1VhpK6xQAfjL9XIncuOimucDcOnE
	GnXazyUFHMHfVOd/94c70yuTlxCVDEbLafsTShdHe94CW2f0yq6egykqLabQrdhgzxF3SB9bzB4
	UkSHOXkCWMvrG0nYrOz0uFDW52Vu03mW4da+gqitWS4xvUnt3m+G4zQBmIRih2PwtydbYn/MYw1
	kizxOadTRoqsIe7V+HY9f68OngSWeUv1wPPfCMuWPloXrWLAa2SPjirIg9RY6qXlxiDhADoy0lU
	A71nsoOe6UZqKgAS6PIas42TWsMC6l5CDzIzBtpNHFmTPSrAxkj/HijzPT4uMAi+XvhQQXIQLe
X-Received: by 2002:a17:907:a681:b0:b9c:3d56:e4ec with SMTP id a640c23a62f3a-b9c67978383mr1004863666b.24.1775661769624;
        Wed, 08 Apr 2026 08:22:49 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3cfef4f9sm643279966b.45.2026.04.08.08.22.47
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 08:22:47 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-66bf6aa4858so11770575a12.2
        for <iommu@lists.linux.dev>; Wed, 08 Apr 2026 08:22:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUYRcg3mMURXsMajCVSxBZpkJJ7u6i3/CXupzm/NKKmmdEtb3IgO1w+gaMWfVKBM7S3SbFy2Q==@lists.linux.dev
X-Received: by 2002:a05:6402:5305:b0:66e:aadc:2021 with SMTP id
 4fb4d7f45d1cf-670047bb29amr83427a12.17.1775661767544; Wed, 08 Apr 2026
 08:22:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <adZTGOjjJrVJOcT8@shell.armlinux.org.uk> <adZfTi3R6jtsjXx-@shell.armlinux.org.uk>
In-Reply-To: <adZfTi3R6jtsjXx-@shell.armlinux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 8 Apr 2026 08:22:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi7+6Q5ptBNp6UGrNbgbk9jr1vsY9mJ5O3mH5RPjpBggQ@mail.gmail.com>
X-Gm-Features: AQROBzDMX29dK6Ob4UI8k1Dcez-g32vHwaiLrL1sR7wyjWf7zr7a7LiEfyJC2DA
Message-ID: <CAHk-=wi7+6Q5ptBNp6UGrNbgbk9jr1vsY9mJ5O3mH5RPjpBggQ@mail.gmail.com>
Subject: Re: BUG: net-next (7.0-rc6 based and later) fails to boot on Jetson
 Xavier NX
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-ext4@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Apr 2026 at 06:59, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> > Now building straight -rc7. If that also fails, my plan is to start
> > bisecting rc5..rc6, which will likely take most of the rest of the
> > day. So, in the mean time I'm sending this as a heads-up that rc6
> > and onwards has a problem.
>
> Plain -rc7 fails (another random oops):
>
> Now starting the bisect between 7.0-rc5 and 7.0-rc6.

Thanks. Not what I wanted to hear at this point, but a bisect should
get the culprit if this is at least sufficiently repeatable.

The exact symptoms and oops details may be random, but hopefully the
"something bad happens" is reliable enough to bisect.

              Linus
