Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795084412;
	b=M1+hVZXzDKlVzo/L14RpJqFDdWxVjg9QyuAyk/Fg0vflR8R/o6obXzTg0coSBhbgiP0E
	 WvxRg3EB/vTlURWsI39fvgwoN4MiL+YPlGa9hW2ge2mRI8kJCv7/CpQ9z0rxH11wzpC6R
	 WvNCGgXkcPY4rHcCRHvpcEebOdwnbfX62kdvH+lb7L/mBGpU7VgyrwtJbQD5GAEJbn97G
	 Mh8f9hxVrLgIotEQXtmccZbTLyuNUpqMNongz8H0DfJW5uErVguqgiyyoMu3xEYutzOKS
	 TSz0cPCkWaMHdhbSl8Ksu9whbedmypL9McusWr6wP6kiTafZNLXNDdpoJlvCn48kuaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795084412;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=AbhIExdnNVQaXKmn5rB1MANMqxiDuTToiM/aLoPhPik=;
	b=jMvbzkujEJ4Gdqfi4bkp2S3EssNaqDgylNgOAVVEWilakTsA26JjOwq1mudF6uEGlbG9
	 UQEdF6xcSaL6bggv6YI2P22hvzzzsMHITSfiCtJsTOa2Ik4nvNoiF0PnA5rwMJe1NH1Y5
	 35VQ6g/Pk2lXqAs/j8clk9Kg9GeyC4TrVGOhG2mDT9M1x1HMoPSWpq+GLGLd3U5MeCmhX
	 WT+hcXAmmSPzJIdLvSZDVbnrmO90inOcQWXaYQKK0w2gvckYSo1DL5KxROgrdaDHmGyiQ
	 jjT0Q0XMlWvB8yIrdcyUbP0wSHxWiqhkcq/61GHlKDNtUy+fR3aPXe1DrGzbYbW9GMw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TSRau9N3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2DE60A2601
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 10:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB2DE60A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TSRau9N3
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-67db23d8892so2400779d50.2
        for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 02:33:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795084411; cv=none;
        d=google.com; s=arc-20260327;
        b=i6BKuYirqUAoyOy8q9j6JTTtK7vhruUfVR321nzj8oyDZVLiYqA+G+Mqt1ag0nMLud
         qHBdV1VbdKA+52ePaxQxWzZnSX/ELl8ZXY8XY7C0IrwJ6GEvEvHl6pNrbZowDH7AuIUP
         xhg1OE29AlIHCQlyn12z4Gs1LnzwIprdWJloBWBa0OieN/EiF2NTgAEAVHNZ7za8j1ai
         Ag4QDKChJn77MBikEQzTUVdnUXxz1H1gUK2ukUpIdNZPs5htCfIs+EoEAnmY29mZOsmZ
         mjD0kTOO0RwlkD2btchvXY+CR5FnDWuuKmKmOnFcFUnMzV1hrZmYtbRIill4v+84/d98
         C1dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AbhIExdnNVQaXKmn5rB1MANMqxiDuTToiM/aLoPhPik=;
        fh=ctHvVkF8Uamunr9l5eU73omDauo2eA1F2zaoCL3/ous=;
        b=hIuj0EMZH3XfTTVxBoEqdjjv7QFgCUIhybtot0EmkLfFGyp8iIzuUjJcvJBj/t7OW3
         PLmz7tr9GVYKWTM0AUzad+Sly4pP4uIOSx5YLlgL027VITqYUCjBpR640sy/2ZCqcQGS
         2QYKFmo3rQRabsJi/bMdMb4l1efgP2VsLxSOAHj5772aAIqORd30TbAx40c8u3d9cIS9
         Mm0TWf9swPiIFVReICKXg7snx032YgF33GpM5dRvoZjDMvfkr8LceeLjoQs0VC2tfE1m
         FqQdwTiimMhpZV+J1UQFSxt6qXt4KSY3PGAVS/h6jEimcDxhNOx+Z77nXQ5IH+fY9P7A
         clNA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795084411; x=1795689211; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AbhIExdnNVQaXKmn5rB1MANMqxiDuTToiM/aLoPhPik=;
        b=TSRau9N34m1nH+yOEeBuTMpyoIvzRuovRjycoIHvUPUGy9c2Mdyb5fqki9o338DUYp
         FdpqReKfpAjvenKGPtnI9MC8/GXnIBKtjSMMzUI3519iaJwisE0esWUBU0ZnuQMjbZCf
         28pIWs4HNgwwOXpB5OMZ/2YV+5VM7da5a4Da7SkfjDv7iybAxm93XYj+4Un46HTuUmDL
         3ereO5RP+dMAtcdcghdyj1mSCm9NrccGlCSB/ddZ08hMGzgUhR+kd3i9/RTvfqigU5Eh
         h289z3aLY6FJLILtMB6/+sfxfPogONF7ae++s0CiTvIZbaGAFeCRvhK4q5BBPW+i8GZ7
         RgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795084411; x=1795689211;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AbhIExdnNVQaXKmn5rB1MANMqxiDuTToiM/aLoPhPik=;
        b=m2o2llCmE0pCctuG5mC1D59qQZBHUS7rYj+WmXz5nwiBfI61VFeKB9N9NaSFrJG3E5
         ZdcpXPMr6mvc6XRa12pW4ukiRE2PNaym8FCXK5EQ/W6+ym0tkNwL36z/+fJ2FEhK5I65
         Fbb65Pdh/ral+LnWrZxmG9DjDnvAA2UampL56ElazhxVdbv7C3+gCa/nlBZHoj9WxvUM
         bTW76XNKfZRKhXvAb30WxwPKymjzxV8MpJYrQYhRigaBGFLK4rT7lfIrmC6FOwH6KKyX
         PZMgv/37jLeqH/FfuKLYG+i6ZeefvsnLXYwuVcj3gtBFgyxN2uBYj5/IovXAeP3HkF+2
         BlFw==
X-Forwarded-Encrypted: i=1; AL+hErG0SLFJamrdqJiSvawG667vMULUD1MF9aGBMAbapn6WUqDvbP3v162Se9eitZBiByTG9BCUjg==@lists.linux.dev
X-Gm-Message-State: APuU4Z85IV17DXEhbNUE8LBlYXQBx+B8j/d2CIC78ntyBEQa2cBG71fY
	dFy7odyeMCOoCiP1wuSHAuWHu9BJ2ry5WEtnqHQMAdyLaTOwT+LSwYJWamQgWfVIA9p47NmNBuP
	kOFPAu27nOGcjcPFUOVoOvLo7A4cpPHY=
X-Gm-Gg: AZFdTZc8nWu+1umuNcjEH4w5G+1SBHrXAmnZoI3ktDe4T3Qi80dZgU0O0rbYCfz65vZ
	SBUQQ9pRwkGxCnsZWj3WlaCEXYgy4jfHk4rPWHpOdzHO2ITSRf3IPrGVGZD/dNW+GlRk76+Vvs9
	NR5m+txALHoNZriS9+JtQLE60YTIRhFxHM3PCnNtXiAXGpqdDI84AyOgKlOjE+LC5/8YqQcd8Fa
	5CjfIwg8/sSEbyVTMN3pVYk6wZcsN3IP2F22GbgwTkyUyeEG0T0Y7pZReXjreNH3eP7fIsjybsI
	lLKIp4ZXgtOrsq5YnWbqqKvVs391L4vXRbSHFQtiEHGJdkUgkxfucy+W21mOdYmoyJmeZbBKtHX
	lcEEFbX9mNECKs8jaTeiV7861sBWV/axqyxePKfACNaz/e0iNa5NgVt/57eI7f6hSVEoFdg==
X-Received: by 2002:a05:690e:4145:b0:67d:e4c3:d850 with SMTP id
 956f58d0204a3-67de4c3e795mr1296491d50.80.1795084410833; Thu, 19 Nov 2026
 02:33:30 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261115082505.2012573-2-thnkslprpt@gmail.com>
 <E9412813-7A76-46D0-94E5-0537E9FF5DB8@suse.com> <CGME20261116134536eucas1p1b30ea07e1a1e3be753ff25a653be59a6@eucas1p1.samsung.com>
 <609175e0-4e1c-4130-a9f1-0cfc7815c134@arm.com> <05c05ec4-b321-49d4-acf7-b9fa4223dba9@samsung.com>
In-Reply-To: <05c05ec4-b321-49d4-acf7-b9fa4223dba9@samsung.com>
From: Avi <thnkslprpt@gmail.com>
Date: Thu, 19 Nov 2026 12:32:52 +0200
X-Gm-Features: AclHuK84_rag6BmioJeNu-IKBL4AqRWRqNEzc2nSn_WJYtEjEDMmHtXvraCuXx8
Message-ID: <CA+jvY9GZGhAU48dquqh_qZj-vDShXmmO1zXX8EZf-OwAWQKvaA@mail.gmail.com>
Subject: Re: [PATCH] dma-debug: Avoid uninitialized hash traversal in mapping dumps
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Anthony Iliopoulos <ailiop@suse.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

OK.
Will do.

On Tue, Nov 17, 2026 at 3:35=E2=80=AFPM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> On 16.11.2026 14:45, Robin Murphy wrote:
> > On 16/11/2026 12:09 am, Anthony Iliopoulos wrote:
> >> On Sun, Nov 15, 2026 at 10:25:06AM +0200, Avi Weiss wrote:
> >>> Booting with dma_debug=3Doff causes dma_debug_init() to return before
> >>> initializing the hash buckets. The debugfs dump file is registered
> >>> independently, so reading it traverses an uninitialized list and
> >>> triggers a NULL pointer dereference in dump_show(). The
> >>> debug_dma_dump_mappings() helper has the same unchecked traversal.
> >>
> >> So the debug_dma_dump_mappings() issue seems preexisting (the risk was
> >> there since its introduction in commit ac26c18bd35d, given that it
> >> doesn't check if dma_debug has been initialized), and it is not relate=
d
> >> to decoupling the debugfs init.
> >>
> >>> Skip both dump paths until dma_debug_initialized is set. Check the
> >>> initialization state rather than global_disable so that mappings
> >>> recorded before DMA debugging disables itself at runtime remain
> >>> available.
> >>
> >> I suppose this makes sense for debug_dma_dump_mappings, but I am not
> >> sure we need this for dump_show. See my next comment.
> >>
> >>> With CONFIG_DMA_API_DEBUG=3Dy and CONFIG_DEBUG_FS=3Dy, reading the du=
mp
> >>> with dma_debug=3Doff triggers an oops in the unpatched kernel. The
> >>> patched kernel returns an empty dump, while dumping with DMA debuggin=
g
> >>> enabled still returns mapping information.
> >>>
> >>> Fixes: 173735c346c4 ("dma-debug: fix debugfs initialization order")
> >>> Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
> >>> ---
> >>>   kernel/dma/debug.c | 6 ++++++
> >>>   1 file changed, 6 insertions(+)
> >>>
> >>> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> >>> index 36c1f7cbb2ae..2f487246d8ce 100644
> >>> --- a/kernel/dma/debug.c
> >>> +++ b/kernel/dma/debug.c
> >>> @@ -543,6 +543,9 @@ void debug_dma_dump_mappings(struct device *dev)
> >>>       int idx;
> >>>       phys_addr_t cln;
> >>>   +    if (!dma_debug_initialized)
> >>> +        return;
> >>> +
> >>>       for (idx =3D 0; idx < HASH_SIZE; idx++) {
> >>>           struct hash_bucket *bucket =3D &dma_entry_hash[idx];
> >>>           struct dma_debug_entry *entry;
> >>> @@ -576,6 +579,9 @@ static int dump_show(struct seq_file *seq, void *=
v)
> >>>       int idx;
> >>>       phys_addr_t cln;
> >>>   +    if (!dma_debug_initialized)
> >>> +        return 0;
> >>> +
> >>
> >> I think it makes better sense to skip creating debugfs files altogethe=
r
> >> when debugging is disabled, which was also the case before 15b28bbcd56=
7.
> >
> > TBH there's probably an argument for just getting rid of debug_dma_dump=
_mappings() now too...
>
> Agreed, remove it completely and register the debugfs entries only if (dm=
a_debug_initialized).
>
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
