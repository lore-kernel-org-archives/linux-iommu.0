Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBFD2459E1
	for <iommu@lists.linux.dev>; Sun, 28 Sep 2025 11:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759058847; cv=none; b=pJ4lO4+03wmzAi2nohzhuBpo+NYSVjMOEWLQyF82egq0l7cXRvbL3cW+Qo/p2pGvZR3j7KXUR9CYq+yKOKvEeklrxX0QwrnmmBaGjsWx6nfbOfb/51dZEOaciS74XwsEMA+EnvrySWKGbtrhth5/6Z9LZAe6xtWe/rrLaHU+Ddg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759058847; c=relaxed/simple;
	bh=XnTsRVx2LKHSGCofdfP8cBisj0hnUGCd3CLwMZjXxX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SOvlkBjqU5Na0jlkDcvJxhl6aK1V5ModwyNcEjSKkGT/USbavC1rNN/huBUS7eNiCXYcAHUjwmD56lujfrkdPqICTMiKkKKP/gkKwMVRVhM1DfM5hDBzROBcF3vm0++ZdQKkdnlLrX76EBZpF6GZSqjS/f/FtxZMaeJ+MME3Rbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFyGqXOs; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFyGqXOs"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-631df7b2dffso8019071a12.1
        for <iommu@lists.linux.dev>; Sun, 28 Sep 2025 04:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759058844; x=1759663644; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XnTsRVx2LKHSGCofdfP8cBisj0hnUGCd3CLwMZjXxX8=;
        b=kFyGqXOsnSrNvb3kc9Uyw/2MhcQhEVuK/ACEBWsRxIQP0LuzQPQbxd1LGxjoScnKVv
         QAIrJBjWB/ISkGLnC0VyVwXBybQLlZBkrMlLDRwtKbog2HE3Nwyvqk4rEEDzcyq26VXE
         JLV3S5+pte5evVvr3M4+fHB5pRfg0IYHjL9lNrM/t4fnFS7qASgeV+ANLK9IdeRDODo+
         iveczty521l8pfmjZfSlQSp1arGu5fC9wTEJ38tFquYgjOJ8W4s/B9dmMIeUVzoaIoOh
         UEBOE8mf/T3GU6xznAeUnYnULvSO3YXhm1BytFs9x0mClK+gKQ02YTgfqavHobxx166W
         gZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759058844; x=1759663644;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XnTsRVx2LKHSGCofdfP8cBisj0hnUGCd3CLwMZjXxX8=;
        b=aD3Qv5Pep2YZAWJuH8PfnboC+fVivkPmiMefpVCWJaaZacJZKEntVQnN6e+hM36d/A
         niWQxP9S8R5k6mk1Zi90UyXCgGWrm3BscxSFLb/RzUYnSmU4Rfr0UOgzRnQwQOlr0Imv
         x2dIKySbShAXlxM63vpXw6CFmnfTYM1v41KFwi4+1rqvzTvtpR9QZJhFxQklcCPFVe9C
         TAcSl0uaEDVkdztoEZjXf+wIWzOLn5D5Ak++i/jrgR6Vs4HpwFum2XcVbAW+yG+Uvm5C
         r8csXmv1wlyX5zaREvwmdko9ILPcW7Pa7+M/Fs67zY0ksOefCCrXEpGKMIVLtqAE8VG7
         6xOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNj6j5u8v9LsCWqXgpRnmFXiwc9lBLfPyXsLcgohZ/WMZsvpOSRADJBYw5Uq4sXLmUqp3r8g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yww3bJ+qEH/dtVhsxZ4eoeyTJPQ0KvGs3I2A+uv7GiE4AJcJcm5
	EZM9ur1gbZ1G8fasoHKpmMDZsAL15bfRVU6Pdj5cY4Yw49LCf88mMVKG1dvSa9Pvg1ljd96Z6PO
	N7qsf+GQtJynomtlRVZDlhcB9CN7O8Vc=
X-Gm-Gg: ASbGncsb/d8vWd8tYVWGpX7g0buWR0cJAWUiXAAPYk8VQz+ICtvuGDk+fZJDnX5Q17q
	yw31StnCX+oQHOYXP2cWJdqRJpn2hDOGZjn0pyurl9tj78JNwxlNPTaAm48Pv3WzrFxh1d/mxud
	7pP4JeDuALoN4Igz7Uri9NMVwdBMCjCqiQDMUZgrYxEWE+ymKn5jkP7DVpLq7gqgqO+54ApT3qA
	vZh0s+9Viin7WYE53c=
X-Google-Smtp-Source: AGHT+IEbmR6jFZWeOZACTqVTuyroT1qollOj9im3bB2gCUN08/YU89k9vFmzDRRbDuqGeOLmGGtFiulh5CESx8Sm0EE=
X-Received: by 2002:a05:6402:44ce:b0:633:ddd4:4e37 with SMTP id
 4fb4d7f45d1cf-634a331587amr9387899a12.13.1759058843815; Sun, 28 Sep 2025
 04:27:23 -0700 (PDT)
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
 <CA+=Fv5TF+RTPEkQEmVd0_=B9xbqKycLz3ck3UwcPDqacezYfFQ@mail.gmail.com> <20250928105413.GE12165@unreal>
In-Reply-To: <20250928105413.GE12165@unreal>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 28 Sep 2025 13:27:12 +0200
X-Gm-Features: AS18NWDQy06zFzFA0Tb4sMvL6G-ftUfrOQ8ZIU-yy9wPAEd2O_xZFFnSMKmSHdI
Message-ID: <CA+=Fv5Rnk5RaGU9R_65izNOJOns9w_eEzetH9kBF_MaRgdhLAA@mail.gmail.com>
Subject: Re: [PATCH 1/9] alpha: Convert mapping routine to rely on physical address
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
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

> Thanks for the effort.
>
> Can you please check the following change instead of reverting the patches?
>

No problem, happy to assist. I think this did the trick! preliminary
testing shows
that this now works on alpha! I guess the offset information in paddr was lost
by doing "paddr &= PAGE_MASK" before retrieving the offset, well spotted!

I'll keep running the system with some load to make sure there is nothing else
we haven't spotted yet, but so far so good. I'll keep you posted.

Will you be putting out a v2 of this patchset with these updates?

Regards

Magnus Lindholm
