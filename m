Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267A534BA39
	for <iommu@lists.linux.dev>; Mon, 22 Sep 2025 21:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758575061; cv=none; b=hc2b3U/kTobbQdYzUi1oTPTN0kq60xs9xtQD+dW1jdvqXFlY68uEejEFHDMULbelz8c8gWiF2TWLqcN3mx/DXqg9JdSp51DuYAAq73354lwnNPA2XmanDOYwTbzENTABMYsvFLxqL/p5p+qgUAcdRLSxuYsSJQuSFtxTokr+MyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758575061; c=relaxed/simple;
	bh=IR27taLTFITOYV4B00ku0qQKC4bEZ+4qpChrvPMvsvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DE9wa3bXQ84mwE+dERTFfAM/aLcHkP+7r4MyhV1qbPeqsQvLm84l7ZmNFNtCDYJTVpuhZCKvvLVOz3qbid2tFigrSm/15oZmJDQbjVax/erS1hKxtbYhqPAT9kbbKUBHkzHP1sTBenAGci6hv/RyWX/jbdkDuXbz/n1gkJdodrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6A5L/gu; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6A5L/gu"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b07c081660aso881602866b.0
        for <iommu@lists.linux.dev>; Mon, 22 Sep 2025 14:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758575058; x=1759179858; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uh7Hyul+h5lwAcNtxj/DI9qojjFccIciQ/b88SlaL0g=;
        b=H6A5L/guerjaTzh3j8frLW5EuLlykJfbup0oFDVHTQdXs0HroXAupLsnN/l+pKLeR4
         csV+0ftR8apyUIsUfAS7YESsSkPpID8smdILTRUEvJVzbjvkOlDlI9Kv50NT6DIqO+r4
         6aJ5qjBBD4TshzW3hWGHo18uCoMvZsqET5hn/I1aM40MctQMP+Z1c6SpPIR9yri7uoTF
         pyJo6i3u2q/LZU8A/HAY45M9UXKTGBDNTnC9kzwVpiM2Qmt8SL/taOuPmQxGX0uk8v7n
         5ZAD9lum9KqnUdcDNC9gTanwsci7ShTxCJLdKVW6PV/ExL/ctm6eMf3BJfhihfnXcHVK
         90tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758575058; x=1759179858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uh7Hyul+h5lwAcNtxj/DI9qojjFccIciQ/b88SlaL0g=;
        b=Z35mCPRRMZXrYrv2inRAo3jtcf/Kj9x+N1IkkvI9onANiUwTDHwdUD9KhSrQBHFLjC
         uBmOyxG/vdpt6/J583Vt89MJaiTfnpH6p7Nv40iSLyAU96Czgeh8HC/aJTmcPIl0IGUJ
         aLAkRbrOGtQ5xEBv7gs43kMcFdq77qTeVzUiFtzyUmH7GdC7+9lf8z+rOh/zE9e5t5q4
         vsDPAm8JcCbhYR5pbAyUPrcqkY7Vu/BrW4s3OGYZehT7+lLbviXY0XsZrdJ18NLxM4g7
         2mXHo0J8mKkxR9Ndy4bHGQF/ZYKWbF+b5ecD8I+OiH39lgHUz0gthiBiy5YmupweJN6f
         751A==
X-Forwarded-Encrypted: i=1; AJvYcCWwlHjAlJpTFWgYXMB5WZPd3uPEeZSJ2ceNO2NsMsG8TKKex3L1AnFiSkGKqeSgATuLv12vUg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwozpsYVvxEpNa4wlaCu8SmbPs3tcuXBlEJjqXXcq4zO2s9TWUb
	U0fPPsujvtcIC44Wwl7W6uXW9j3QRAcs/wjZiOEl9GFScxpnfYUPDk3TEMqflxzw211ngd4POnb
	zVv1lqmifmG2BIw/fqc9qMW8BP4jTCAM=
X-Gm-Gg: ASbGncupvD8ygC9N29C088Zy/tqnaeQnh8zkpQFBAAMl/JyjvNeJcWMtDqwEkGt9CCw
	0S7CxM8grMSMqxilvMse9toS4INzRK1SxkSF1T2bhb3n8h/PsF06EJJppfST1fII+XFApT6alAD
	bfcWp0ionipwLe6IQ/XyybCgZgRUwSSlLtXC55mFs/zB5yGz+/tcgXSlnRD4eYwPIMGpNEbBd11
	A2o9cTQvPm8nGcbMSU=
X-Google-Smtp-Source: AGHT+IFr06URzpJ6aUp4DpRFc3gqIF/QKzvPatkXOguRNAK+5vyBht27Wi77YYUi7cw/QJFO8eHWzN6Nc8/pR3lh7aU=
X-Received: by 2002:a17:907:72cb:b0:afe:d590:b6af with SMTP id
 a640c23a62f3a-b3026c84e0cmr5356866b.20.1758575058272; Mon, 22 Sep 2025
 14:04:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1758219786.git.leon@kernel.org> <0c64474985af55b1aa934b857808068a0e609c6e.1758219787.git.leon@kernel.org>
In-Reply-To: <0c64474985af55b1aa934b857808068a0e609c6e.1758219787.git.leon@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Mon, 22 Sep 2025 23:04:06 +0200
X-Gm-Features: AS18NWDVFMZZnWEreuo7vPXyYUB8RQkWA0R_TESbZnVi7LcEMvax5dEHcVzVJVI
Message-ID: <CA+=Fv5Q8dVUFVBh82mAe=fy3mV6mWtQT_0pBPLQwLNBt3f8E1g@mail.gmail.com>
Subject: Re: [PATCH 1/9] alpha: Convert mapping routine to rely on physical address
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Andreas Larsson <andreas@gaisler.com>, Borislav Petkov <bp@alien8.de>, 
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
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 8:45=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> From: Leon Romanovsky <leonro@nvidia.com>
>
> Alpha doesn't need struct *page and can perform mapping based on
> physical addresses. So convert it to implement new .map_phys callback.


Hi,

SInce this patch affects the Alpha platform I got curious and decided to
try it out. The patch series requires some preparatory patches. Leon
provided me with links to his dmabuf-vfio branch, which had the
patches (and some prerequisite stuff) applied already.

Based on the dmabuf-vfio branch,  I've built a kernel and tested it on
my ES40 Alphaserver, the kernel booted fine but after a while of
moderate filesystem load I started seeing some ext3/4 related error
messages in the system logs. Rebooting with my old kernel into
single user mode, I was able to recover the filesystem using fsck.
Clearly this set of patches breaks things (at least on Alpha).

I haven't yet dug any deeper into the root causes of the file system
corruptions and I've only tested this on Alpha, maybe there has been
more testing done on other platforms targeted by this set
of patches?

Regards

Magnus Lindholm
