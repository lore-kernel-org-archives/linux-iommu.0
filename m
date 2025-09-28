Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAB52DCBF1
	for <iommu@lists.linux.dev>; Sun, 28 Sep 2025 10:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759055044; cv=none; b=ieLcEty4vxpNKRFq0HoSCs9Jv0yW5GKoK62eFDnxZ+DmMKZ8IeXVpevgy8XOcNjDW5v8h0YUfnm+Ah5JZbr5DfP2pe4vugX1TTVFjE6g4MnuOSlxnrrFgkPvQOZjy6RUVqAHmsMuZiYyUAJd0WcDB27dfntCfsnFblB88CA46m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759055044; c=relaxed/simple;
	bh=D6IUpv1N1uqZnzwjcSW/CDPKsLpnOn0CcSzXGCV/+/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dROfxzNV3xnDIkWcbgx7vtb74+XIixR8w92F2RnkCqplTsK0qh48MjhPNhI3gG50+d2rthcJNzMjn0gGwBvGUcyt9Glf8sT9YOt/JPAeu0QIuAAn7b2aAi2pv8FqgTnt0CnrVVHgffXYXR3u1dDX0EGPdgspipqoIsCIbrsCTfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpWv0CVA; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpWv0CVA"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-62fa0653cd1so5307633a12.0
        for <iommu@lists.linux.dev>; Sun, 28 Sep 2025 03:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759055040; x=1759659840; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LcChJkbyyCyxxnYoZ0h2dgScTYQu8ypUACGdGHRDEY8=;
        b=MpWv0CVAD8Y3AyatiPvXsh8dkk9iFNUSZhbLZ293Yd9Jqna3DYeyNLi67cCULXuE07
         06yeicHFJsroLuXzvqDuBZSDnvG2dyP+VdbC2XfeFcVdt5PxjuH98PdVe4lsKGAK6jTu
         OWOBE5DrZlb+fD5kPuHtgBXGTFGnXcYGvxO6TR04SQdQ0BVrO2ndVF0K2eY0IoodLJKq
         vmcFsPBn8uBLmAN8fE9PBk89ViRqUVtXUN6g6OqUoJ8jbAqqQqj2dAUylL2pURfPQMZS
         4LVGUfPeOKKuteIlmIkLMnXQ8z2ZYJJVxdtuf/Erip+DM7PbXwhi9RRNPbOcZ4k6w7at
         bsdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759055040; x=1759659840;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LcChJkbyyCyxxnYoZ0h2dgScTYQu8ypUACGdGHRDEY8=;
        b=f0DGQivOV2QfmJJxzeGNWqjkgFj5nLdUFmsSmopEmIIO/FvKUJZNMEDSyD81Lyz3PN
         Q385p3DqbCCgu9Z6UgpZnm01fDRd0cyeeIz/scjNW/VmFznOoOkjJT60mZb8ndtaupgT
         mretjn6qNM88O3XfnIoB7g/e4285TiiABykBWZzxZ/E4ksybX5qhu3SDkeXcIIWreqOC
         gL6Fn/thur3LEeHgzeEXwUQ9njdstTRXfiDVy71iM6aV93RQt7wHjY3dGgGR7XXo4PMD
         GQdbOfCbjm3oEfHDMq7tf9ikxChRacYFvBoECzvoK4QgwKOfcSX1PX6Tb4/9iPnoimkj
         NHaw==
X-Forwarded-Encrypted: i=1; AJvYcCWI2K5S8f9edcithwAmsPLQlY9g2/fOagc8XXKa2LtRvPPGVQeu/WtSIu0vtzBggsdp46xDoA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwjYbg2ibuYsCzXILmsd4jef579kK1XQRn65/RsAwi8RNAAZr7r
	SPiirccamZQUOf3AtnpXGYjEyJ67SLenCzZ7xdDwjMPaP2Q8IPYkfZoXXlg/J0x2nXBxFsCmk51
	dHdTvRzEXZfpgvXvmOOajxLDXk2RORHs=
X-Gm-Gg: ASbGncv30ewuU3t2CvWxSePfbnMS9SmPGYdDLF9M4QobLDqmhniX8da5lshe9ftKeVE
	hGkZb6VE7qvpnJIyWhcEfa4UEnYQ9IIcX0GbtWsbzUhFK1zc9lIDVEKR1z9UvQ1qWaTh7le8p9t
	qJUMy6Ak0Y2V4PoY2YdcUOkaioDeQPFs6SbZKPO1LCTcaUexDG/ZpZGTMtXPVuJXg1RWOgxZvkp
	RiBluFb
X-Google-Smtp-Source: AGHT+IGAq0LbOWTh24q9bLB+mXJC5ix6EL+ilnN7HstffL1oa4ImYTxpRTBcFvmhE8oxPjiGws6tJF6LzW8U7U3nO24=
X-Received: by 2002:a05:6402:606:b0:633:8337:da95 with SMTP id
 4fb4d7f45d1cf-6349fa9f661mr8379897a12.38.1759055040002; Sun, 28 Sep 2025
 03:24:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1758219786.git.leon@kernel.org> <0c64474985af55b1aa934b857808068a0e609c6e.1758219787.git.leon@kernel.org>
 <CA+=Fv5Q8dVUFVBh82mAe=fy3mV6mWtQT_0pBPLQwLNBt3f8E1g@mail.gmail.com>
 <20250923171819.GM10800@unreal> <CA+=Fv5SJcQ5C4UeX2+deV9mPAe5QxrocMG8EJ2eVcYjbLE5U+A@mail.gmail.com>
 <20250923235318.GD2617119@nvidia.com> <CA+=Fv5Tg7sQACpeG8aMZF6_E6dbRnN5ifg0aiHityXadxiHoPA@mail.gmail.com>
 <CA+=Fv5Sze_BNmHqzypmCh8p2JO6gytXH4E6hXv3gZdfoSJsMUQ@mail.gmail.com>
In-Reply-To: <CA+=Fv5Sze_BNmHqzypmCh8p2JO6gytXH4E6hXv3gZdfoSJsMUQ@mail.gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 28 Sep 2025 12:23:48 +0200
X-Gm-Features: AS18NWC4Nb9W4XCpYP_OV5Q9pNZrLenXw3hzv9kO6uALa6_OupoUAOrEskTs214
Message-ID: <CA+=Fv5TF+RTPEkQEmVd0_=B9xbqKycLz3ck3UwcPDqacezYfFQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] alpha: Convert mapping routine to rely on physical address
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Andreas Larsson <andreas@gaisler.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Geoff Levand <geoff@infradead.org>, Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>, 
	iommu@lists.linux.dev, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Jason Wang <jasowang@redhat.com>, 
	Juergen Gross <jgross@suse.com>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Matt Turner <mattst88@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, 
	sparclinux@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, 
	virtualization@lists.linux.dev, x86@kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"

> After reverting the above commits, I'm able to build a working kernel,
> that is, no filesystem corruption occurs. I'll take a closer look at this
> after the weekend.
>

Short update,  It is enough to revert the following commits, in order to
have a working kernel on alpha:

e78a9d72517a88faa6f16dab4d1c6f966ed378ae
(dma-mapping: remove unused map_page callback)

d459e3b80ad1c81bf596d63d2e3347cf8c7bb0d9
(alpha: Convert mapping routine to rely on physical address)


/Magnus
