Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E64235E1D5
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 15:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585564; cv=pass; b=qmpIyRk9Eita87d39MM7yMiM+IFjtLC/HWY4N43NtPfipE0Bg67pzx84LoInAOHQ3T9sRcHRu9c8vMZdfzPF7j9jPAqVnTEVhVEy1jH0hWrrfKgHqiDamgRta/wk4+cSnTT8Hwd34RvYbA2VCTpC80HVKbtl492EJ/4HMUd1VxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585564; c=relaxed/simple;
	bh=pMin6QXf6mzaFI9tqvtNXTL3PhczVNb4o6Q4NA2CycA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DIxfgqR37tOrVUdrDrs+ofs+iYdrMo+bc1QoOgWvvKmIF/9PvTcZQq3dTvo8ZSU/lj6vGeq2KblFSUubz096JExBFE6T+R2yVKhuH4konkYZ/ejLzDQmIhC1WTO18BahiHb7h6Ibel5Ov0qnKrXnEjF8etXK3baTE0LZY33jf44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PS08T1Vf; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PS08T1Vf"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d3b440b97aso175225ad.1
        for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 08:32:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787585562; cv=none;
        d=google.com; s=arc-20260327;
        b=CTCxx2ESsuVwDvdCxHNCVIuasCn+cOyMkGHua/Gk2trkh5I7OlLQZ1YXgtNZsI4Ypg
         yeGDYIcD6UzTzcMJ96xPF0ipiwxzIBKgOjBCuZGWjhJSaAOVNi8jGPnTGqKiTKj6reH7
         vgTPiTz61KVqfUChQ7YxyrNkg3eyYbaghjcPhPX9UXKoVRhQFeqLE6BTkkcW4Qtc6yGY
         xlT/jJ4isdPA4yV9fZ2+HqeVrEgtBA5TGd56gBNPqNllf39pZ7NDyUFgkWzsulUdtdbN
         coe5Hy8kckiecRvpXHjvZ2v29bSpYkX43tiQvaIA+8Gb46S/9lMolXFiB0h2LJP9zDr0
         JEYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pMin6QXf6mzaFI9tqvtNXTL3PhczVNb4o6Q4NA2CycA=;
        fh=lr8nSC56c+VSqcTr16FlwaNsB075kb/4MCcV4CYhmFQ=;
        b=ZllbIg6FD9PN16XEqIz8a1txfj9JKJOL8lB34jnKX6BfpbibGj2LPGut90eOGTXzao
         zwOG3QtsCqYA/VqrBa7TYhej4waYV+jcUeugDEwFbZNFGqyaTtaMzY26yS+fkG0bgUNh
         jFNquZ9CWV+YQagtZed7J2eUmz+FZyz/l7MSlrHXr11RaT6agsSQYyNCltkkwjns5zHa
         37XkVfTApOzT4dfdswzUGE7wipfKbPyhjKjdokaCzVp44SrZlG7aZPxjD7RcIuW1rkQA
         gbjSKtnWwIHtauT6WZ6BqCQhetm1a891rkRcHBE6L69gB25qJk6P8IHnf/pDi3bkZj9H
         LfuA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787585562; x=1788190362; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pMin6QXf6mzaFI9tqvtNXTL3PhczVNb4o6Q4NA2CycA=;
        b=PS08T1Vf1g2Yh9eCp3OTsVqpktg8nxyMW+m0M0Ua3ZcR7O9qNghLKrLt5wLdaKqadX
         IuldXtT4htGm1g83AJZw/6Tfc1ElUqOu08kuogl656A6hBHuwv+0j6AxbOXJH2oPdV+2
         XBzh250qyK9xhn2mdZP/e2f4wuoDIc4W7b0rg+KGk9Ispot5owQd6K7WmwppbPjesVwA
         qOLJXJL891o/T8zC/edjHVdstFOG1I69oOhn/4h9t932dwGVC4kgVMNrc16t5Pide/gF
         2iAQlZO3bW/COh+PTmatqYAeDrtld20MW/ae7bScX7B6icYFww45yV279zH+8lpguqZn
         nlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787585562; x=1788190362;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pMin6QXf6mzaFI9tqvtNXTL3PhczVNb4o6Q4NA2CycA=;
        b=OwGSFcKY8sZC/nIKtI7al6rv2FRFMBLnfImSoZMmeo2YODMihG+TpAbFIXPJojlmxt
         iaEiCtT2rfvoE4410knWWDi85En4Os3LkHI6x6cy08GAuruRJyPXa1WKhQM4MauIyMIH
         puf8nRbvK5Q9IN1MRFfI1TVy7YTU+WmUrVazR2+unNFkoA0GcUM1Zi5UbLBG0bg8DUyw
         qvIY2PNGccS6JafgzAenK/qIJwWrNEVqElw241VZB8pWIHt1tReiVRIzL1t3K7CV4KhS
         Zl1cjgkrvKJNRSypfUOyECO9iEbAkTKZ49sAjDNOhfT98+qpQgjbDALatZjuFHeQCKbk
         Z/Hw==
X-Forwarded-Encrypted: i=1; AHgh+RoBseFLIRbgGzWN5Id9cK4NGsF6aBnakWWsy+SybTryLm0AHhTSr9NXMDmnoxCBWgELgFe8dg==@lists.linux.dev
X-Gm-Message-State: AFuF++mdPkp8F1oc4D7z0WYNsrTTZsPaPojV9HU9WAjGXhhrxdyVnAeJ
	Jbnm882kKUssd6HEeNjjacfgqa/7TumL8EiZjitbYXqWakuUVmkT4SzzprTlDJqgFMN+9TkZ6WI
	rOoPFRIXdLGf8Ek0RMJUI2owW0QzFKWBinYQCnPHy
X-Gm-Gg: AR+sD10hHqkWLGJISfih6YuKH5Qi/117gk75TQFHhqw0buI5WmS7cf7w1IY82mnfuAk
	M8k3WIvmaBQEMG56DJbE6B9k1Edi4Qpxv/eH7UU/IJzqqsW/MgU/dieOlQNQvoatF9DP5xyjh8F
	ufg7n9p+YdOAJmbi0wtXHlFoynBkc9JvFG1HaNiPFpn+c/zE8Ni1/QVwE4Shmus0mPIagSQJwje
	57hNgpQKy2KOhbp4Lx8JNu1iShxAmq3DutZLvXoAOJj5pIz8DiBHIQQ8WsGe3rOxCPU+lx+LZ+J
	60J78GKH/9gkhOzmwt38mJmNAe/pcIXkVVN9+2eRKiF8gx14no1mSun2B7SHlw==
X-Received: by 2002:a17:902:d592:b0:2ca:bf8e:360b with SMTP id
 d9443c01a7336-2d673b9e9f2mr10182565ad.9.1787585561896; Mon, 24 Aug 2026
 08:32:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260615234220.3946885-1-lrizzo@google.com> <20260615172535.080cf94f@kernel.org>
 <CAMOZA0KAHKsvA9yRcdrjG13S+=rJhw-Cvnw2WdLjGGY0azG0kw@mail.gmail.com>
 <ajEuUZMgS_NRmDcp@google.com> <ac473a83-c77f-4a41-bc86-8a857d2d6e36@nvidia.com>
In-Reply-To: <ac473a83-c77f-4a41-bc86-8a857d2d6e36@nvidia.com>
From: Luigi Rizzo <lrizzo@google.com>
Date: Mon, 24 Aug 2026 17:32:05 +0200
X-Gm-Features: AcwNN1VGtdaRS1g0BYe1RjEgd2mMtkM251D-YEt_DU0VPfQjcinAUbJbvNKEsc0
Message-ID: <CAMOZA0LJ9qTs+d5Mg9CB1Pio-Kw1HDmuVSMiz=zUZdWFC7zqdg@mail.gmail.com>
Subject: Re: [PATCH] swiotlb: avoid double copy with swiotlb on tx socket
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Mostafa Saleh <smostafa@google.com>, Jakub Kicinski <kuba@kernel.org>, rizzo.unipi@gmail.com, 
	m.szyprowski@samsung.com, robin.murphy@arm.com, willemb@google.com, 
	kuniyu@google.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	akpm@linux-foundation.org, david@kernel.org, netdev@vger.kernel.org, 
	linux-mm@kvack.org, iommu@lists.linux.dev, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 10:59=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
...
> An example of this is Jiri's system_cc_shared heap which is a dma-buf
> heap with decrypted memory for userspace.
>
> > I am still looking into this, I was planning to bring this up in the
> > upcoming LPC.
> > I will give this patch a try. However, I believe that we need a more
> > generalised concept for CoCo pre-decrypted allocators in the kernel.
> >
> There is a talk at LPC in the networking track about this [2]. This is
> exactly the type of discussion that I was hoping to have there.
>
> Besides the issues mentioned in this thread we've also found that a lot
> of overhead can come only from swiotlb allocations when running many queu=
es.
>
> I will add information about this series in my talk. Hopefully I will als=
o
> have time to add some numbers for comparison.
>
> Sorry for the late reply but I spotted this thread only now by
> accident.
>
> [1] https://lore.kernel.org/all/20260325192352.437608-3-jiri@resnulli.us/
> [2] https://lpc.events/event/20/contributions/2464

Thank you for the feedback and links.

Do you have some code describing [2] ?

I just sent a cleaned-up v2 of my previous series, if you want to try
it please use the latter.

cheers
luigi
