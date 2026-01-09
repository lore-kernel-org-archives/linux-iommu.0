Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014AC33BBC3
	for <iommu@lists.linux.dev>; Fri,  9 Jan 2026 11:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767956568; cv=pass; b=pJpHFmkkW2mutQzpHgQDPbddHV/8qrGlDlYTi9vs5rdeR4v6tWsYoeOAZszH874Tc+7WwIvYYAsNw7GjQmqZt6soYPyXbm16NVaYbHfVT+obgqjQrPT4ooZ0k7vbPgYuYhZv9mNay+ek9xmf7zz9QRHVSe56ppz74Y0BVJuAxk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767956568; c=relaxed/simple;
	bh=rFk7TLciArdXVmOhSyBT7/Ns+M/k6PPCPRzU7n5m4kM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WbGDCu+z1ei3QlEBdvWX2MGs09D0+vj8JpfiHl1eYvtHSWwad+RN8K6GmIDU80//vYOejPw7CKVRKPdNB8uVvWjnUgMeNWaKS4fXyn2YNd0uA/1nBTNk5KnsUVLKTDR80N3QkqqRsiCciw1MVYFcaH7TVb6G9/vhlTKmpRXCZjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nYgGcbSl; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nYgGcbSl"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4edb8d6e98aso445031cf.0
        for <iommu@lists.linux.dev>; Fri, 09 Jan 2026 03:02:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767956566; cv=none;
        d=google.com; s=arc-20240605;
        b=BIB7kavgevIvKCGfd8S5+oxQpdncJvDnHxNRg1BDun4Kf8Qt5UlHR4Xr4JF2LVZ0ZB
         zABzMXorJBS8GQw5YWdV5iJb52dTfAvJCobT4duOqDg0s2XaOwJyeKSAeg345e5+dPK9
         487jIXeDjWRiH+UfTghIRoaGc1Vwr6KzGPMBj8RmBfA8UMYr8tnyWAuwQqTDDVTUtiPa
         92oZ0w9VrAh8x0WkgCqn3puK8+QfuoB9hU5zz/wgfc6PNuIRYuhuqmcj+akM0S0coSct
         IDUPULvh76Vrfvm7Iu27tbIfIjHrCqUOdE4hV4DQ63afdSzfxOL4fKxNe7c2oivxdhxK
         VNMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jzCiSHIGOYpa7t9zzF/wcFfKhZV6nLFk0KAKRqVw7HA=;
        fh=nG3islA74pS5EZIabeHc8a7obWmBZacAiGVGHuG5ix0=;
        b=eULoIA+5G75w5DOEWgLIlDDgGa0mvYYjjj8hHUHlIYE2WSOK7UJHEnf4dCxg9XqQmC
         RP4hAlnqa2hU2PXNgICq3wa74J/J4dKP7t7vC/uOvDeKplxbZU+X11q3Q106+7bQVYxu
         Yf12C0RynGydvSP+r8rK5sMkzo/fnEkXICXadMAkDEJJdzKPf8L/1r4fmv4xMZtYBqa2
         5diQAUi+oCQPOsF1Q4XNLT9NiJixlU5IMizP1uC1xewyasMvvKIdmuaREX8jnP1N12Uy
         coDfxjY37St8XvQq5Qe39/k/kiCMZuokUHrCC9V/sQDGGwC7qyZdn+jGsQHQnoCDJ2kX
         uENQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767956566; x=1768561366; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzCiSHIGOYpa7t9zzF/wcFfKhZV6nLFk0KAKRqVw7HA=;
        b=nYgGcbSlBvN2OpR9+AFBe75kEs2k+xCtdnxianNN6AtmJo+Vfasm2twSBU6rMGwSE6
         AZmtohz1lA+Agvvt+1rz5A9/i8nPq+FeUnUy4VvgH/clJbESl9i1BZYUUOawrsTxhn8q
         lz56akGgFuhzJjhLmAoyJkl78GMPL3hAZtUBZWBARTczupGnesZhbWxWI9aA0GpGHjoy
         s+rfWhYyLJfaPHPgc6VEsCtV/sD0FyjJGxfdgFuuHY2JL64K31ZItKZQy4ezPIwh6liS
         2oiMPScB+XKGsk/+zoCzV5T9bY681DeKNX3AU7pCs6LwPHPGiKnESrKtvhvq9mkhCE0R
         0MIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767956566; x=1768561366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jzCiSHIGOYpa7t9zzF/wcFfKhZV6nLFk0KAKRqVw7HA=;
        b=PjDpZrV8csuj3A6QSlNnI7pRk1EzhXXkkMGrPN16UzMWS75hIqA9D6cC21dbwzSS3t
         n24LEdu01qx/RZTqCs5nTA7Z2pmBe1IEh8S+t2vWeHjcwvkHwIcPYA3TQtg+1nuKc6FJ
         th/JeTHa+Wyh9Q9RtLYkRkJ2dr9Vsp3kgra7dlC9JFRAQ2U6yHlLs9PFNz4PP7u4N+jc
         X8LzKl2qKz8J2O5FtK6M1iiBnkpS8MMRU+y9qDtxUvb7NaXUEvtsmm7kmalv/SqOr5EP
         tiPVUSZ2gkPLjSJteoWRKGurbwZJQUYpRg3ca+2JFABsUUdwIssRzN+Mzabte0m+Ay2y
         7pJA==
X-Forwarded-Encrypted: i=1; AJvYcCUstDdww+tmY5cnub2fWV5mqfLng/oUQ1lZiqCgi/JoYgcd5HyI4zC31Z8k5uXV/hmo/4TVhA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZ80cOMAlGzIUxW/wtvJ7qYvzBJzWTYN02k/5AsNuAFT1y6bGX
	wzpamAfJSmlZ3sdXvlRKWWnar7uVGHy0m3bOHbTN/63mpUx0TdbC7h/LOzj/9Fr6O/Tls4GGZpb
	JQf6xqOwcMdsmvS+QNv06zGnf+FWQXXrqKtCpxOWA
X-Gm-Gg: AY/fxX70wlPB6xe+NdVp5OA30ORv3BM4qfNAqUaHjkodSw7YUyB3CEJ/25kN1t1nc0K
	N9JzVe1y5pW2W45cy6XXcT3JfqCX3EKUSBck2dW70rn6qr4gV9Aei2q9UIMwBQPqbb/MwwvJJu0
	u+x86D17QWAPOTdrwIryA5xCYwaDGop3T1eMY6cxLvCkZ7I2SP/H8mN3e04lrwXxJ9IlcwcmQa/
	XXPhuSeh1pov8xW1v6tPqUVgEG1ESgX2AboAqE6JPuYG+bHF5R2kWqHP2DulGI2+C3yt4anQlHk
	1LDHpr20WEgSnm0PIosKMPm0bHHG0oGkvl3xKjuK
X-Received: by 2002:ac8:5d8d:0:b0:4ed:70d6:6618 with SMTP id
 d75a77b69052e-4ffca3899e0mr9525541cf.10.1767956565345; Fri, 09 Jan 2026
 03:02:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260106162200.2223655-1-smostafa@google.com> <20260106162200.2223655-4-smostafa@google.com>
 <aV56BWisUQTMK2Gk@google.com> <aV-PvBqQ0Ktiha8e@google.com>
 <CAFgf54o4Ja7jQwxo6XyW+JaT+aUuj3O2dvLqOTb+YSVCKTdvyQ@mail.gmail.com>
 <d6236413-7385-45c5-94ad-8b0f2007f1ac@linux.intel.com> <aWCviSCK7IBddLTn@google.com>
In-Reply-To: <aWCviSCK7IBddLTn@google.com>
From: Mostafa Saleh <smostafa@google.com>
Date: Fri, 9 Jan 2026 11:02:33 +0000
X-Gm-Features: AQt7F2oqTpF_L8hxvj3t4iE4ZAXrurkscrS9S6zaVPP7N-l_qQbRFrZajZBoJoU
Message-ID: <CAFgf54quzFPtfXN0Tw5qO2HU0YExN3FBHK3uG2yiLxkNybfHfA@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] iommu: debug-pagealloc: Track IOMMU pages
To: Pranjal Shrivastava <praan@google.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, linux-mm@kvack.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, corbet@lwn.net, 
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, mhocko@suse.com, 
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	xiaqinxin@huawei.com, rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 7:34=E2=80=AFAM Pranjal Shrivastava <praan@google.co=
m> wrote:
>
> On Fri, Jan 09, 2026 at 11:28:32AM +0800, Baolu Lu wrote:
> > On 1/8/26 19:33, Mostafa Saleh wrote:
> > > I have this, it should have the same effect + a WARN, I will include
> > > it in the new version
> > >
> > > diff --git a/drivers/iommu/iommu-debug-pagealloc.c
> > > b/drivers/iommu/iommu-debug-pagealloc.c
> > > index 5353417e64f9..64ec0795fe4c 100644
> > > --- a/drivers/iommu/iommu-debug-pagealloc.c
> > > +++ b/drivers/iommu/iommu-debug-pagealloc.c
> > > @@ -146,16 +146,12 @@ void __iommu_debug_unmap_end(struct iommu_domai=
n *domain,
> > >          if (unmapped =3D=3D size)
> > >                  return;
> > >
> > > -       /*
> > > -        * If unmap failed, re-increment the refcount, but if it unma=
pped
> > > -        * larger size, decrement the extra part.
> > > -        */
> > > +       /* If unmap failed, re-increment the refcount. */
> > >          if (unmapped < size)
> > >                  __iommu_debug_update_iova(domain, iova + unmapped,
> > >                                            size - unmapped, true);
> > >          else
> > > -               __iommu_debug_update_iova(domain, iova + size,
> > > -                                         unmapped - size, false);
> > > +               WARN_ONCE(1, "iommu: unmap larger than requested is
> > > not supported in debug_pagealloc\n");
> > >   }
> > >
> > >   void iommu_debug_init(void)
> >
> > How aobut
> >
> >       if ((unmapped =3D=3D size) || WARN_ON_ONCE(unmapped > size))
> >               return;
> >
> >       /* If unmap failed, re-increment the refcount. */
> >       __iommu_debug_update_iova(domain, iova + unmapped, size - unmappe=
d, true);
> >
> > ?
> >
>
> That's nice, We could also print the message as Mostafa mentioned, like:
>
>         if ((unmapped =3D=3D size) || WARN_ON_ONCE(unmapped > size,
>         "iommu: unmap larger than requested is not supported in
>         debug_pagealloc\n"))
>
> An explicit "This is unsupported" warning makes it clear IMHO.
> If a driver triggers this, at least we know the sanitizer state isn't
> supported.
>

I guess both are fine, the WARN points to the line which should be
simple to deduce the cause anyway.

Thanks,
Mostafa

> Thanks,
> Praan
