Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A092355F4E
	for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 18:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772129017; cv=pass; b=LPC1KIinR6zPJ64MOeg/9a91IkMwnKEaV3u3991U/mZH8grw9YkgClHOukl5ooezwpdTgoW3+KJvxSiSymfsQJuEGFL/FTFgCglGNJuDoWm5ZGV1ByAPQ1COvtQnCdMYSw0C3xV2BCIDxpv8SXxfzz115Ld9knFF8MIMvjdaIyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772129017; c=relaxed/simple;
	bh=/VdG3rC0gGwM5+sHi4tU9peTW/HaTVJcFc8R/yRCdTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fe89V4IKeyO2D5r437g9AymrXMBCS80KHVJrnLUbTwSh8lHBeXLrfgcE1Ya2gEGstFO6efi7IvIDZumUo5NLPOyKwNErcXAdhLDzEw505pCfx3lFS+iybfSiarzDV/skcFIOId5ma4510Xg91aJRKd6S45cK3/mlUbLAKnpdpEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qxvR06ap; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qxvR06ap"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b936b85cc71so59850466b.2
        for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 10:03:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772129015; cv=none;
        d=google.com; s=arc-20240605;
        b=NaafXj65zOYdTZ0wjlzcF2kWnFK7mvLEcg3bWtWfn0WT4YyL4YvHWYTxvQ+TonetpJ
         Xt/PQUpH5tT9AuSrW28UegUkIP3rMvPg4IlSComKU91z0gNe3kfw3/zQU19nJG5zG6py
         O295FO7aiK9Yk8zIjdmdjL1aSnJdmdywlmbF7+OVXR19/ZdjzRw7pd6Ag13swEufxqq0
         xlTrqY9GWxMWFa4iOekKFYqIwxEE8JUeuG5x0baVACLRkc5J6PmaTIYkUZMu+SHmgOEy
         PKUAv+tO+dowyj5gp2BUA5+SYHcsPP0sVbi1AXt5QfpKq5KVpVj5HYxMhssHN76pya6F
         zTIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9Qnm2oa0MVzHK3SlIdevV2oCNgF9I6YsjdLLXN+h7bs=;
        fh=Sqs4qn8wJSOGnP0QzSBXgIyNtAZ3GVX52UFEAVzccTs=;
        b=Ovq+SK/K5DprfOeyLMKNgl51/fxHPatHXpCIc6mgKP4ioBXD1FClSu/Gfl1j7Hspdo
         HNSGg09OvOsKK75VfSKMo/uI6JzIsDKP5eFj4kxMmGOVR6ozXnSLm7mmCzYiUCSFx2H9
         l18lAYbTakbxuBaIGfwEk4MOihz5E90POe/IKXMvdvImVC/1jWHPyBC6KODOJDdtT7ur
         OrbsP5Pkzp8HBuLV6BGb3eMVUvNtToHsiHLbffNgb/MkDo70WMlAzQO9jiovXgR1DBDv
         4WMm7LV9nqA18+vWK16sOqIfgVodFqQZ0tSKxjYK7ZBhx8mxUHT+ipqAwoZ8WALMBf25
         lxBQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772129015; x=1772733815; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Qnm2oa0MVzHK3SlIdevV2oCNgF9I6YsjdLLXN+h7bs=;
        b=qxvR06apTuQPvhfvuTYS/o6yIwSfEO82nfgHdF61wY8obUMKcpMMVRUKB2yJ3zroSD
         XijIW59M+WiM219dCnjqa/1BNKhWvnZNxQdmDbNUVrZdbSLxIWfKfHtwEQzCy2VJpc1d
         8vDeQ0GftP9A6DEXJeJoo1MvNxR26++Zp+bQvX9tsOYq22jHj9pHgbiL9Qgt23aZt6Zp
         hfKXHN4nVTW7Laz7BuhoPhKrhbzZ1552aDbZuhN9ubW4o0TVPqEUURlcL1yigiZD4o4+
         3nLavAaH5qlTzXYSKwraShGPN0Yw2fCBLzQ4R3PntBsfBhmdKuRmEFriRFBcfmHQCAb2
         0fPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772129015; x=1772733815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Qnm2oa0MVzHK3SlIdevV2oCNgF9I6YsjdLLXN+h7bs=;
        b=FKuNtP4T4F3JSICJiHeTWDDwAz7sFsx089++SjIgJFEYsrwI9wF63mHgSNSY1FrlKg
         l7bE1iujEKlUQwiEgO6W2SHREjHDVTskHuJkDCuX2AyK3UStHgsRrOV15sHoXgzpQhkB
         Q77UFO5tlceiF2m1ZmmK/m+Zf8QmbBzQHF0IXX76lzh4lXr4Kgc65vzffnJyOXmOU7sV
         49HkwDw3Es+Ie4qGWng9WYgL/Bdxp5SaOJz3Ng4D/jxhEAnkB5V9gHBNWCr5GFqNTlne
         /2Q95ZzZXjFor6XMOxDEY9h87GJ2hY2yrF+hehfqdGMOm3E4zkoFl1fIrl5g1ADYNuha
         0I6g==
X-Forwarded-Encrypted: i=1; AJvYcCVxA3gxcdT4oDfpqdZcAhMNtuQj8upm3ponZ5nEXYo7PDU9OcR9JCLi8BAALwJK1/ISAdMhhQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxvW4+F7Qv82wS92WblQgPtzDC5QQ9AsbU1fTqr+HB50pvrudHs
	u83zxYsd4s5zBilEV/UHC8jl6vp6IpAPRNLGC1haoHwfrdGkZ4u1o5LjYXOPtVlg+S9X64cNujZ
	58+WnamjwqzM/ZP8wjmSu4fCt6YI1YjyOdY2Lmcc=
X-Gm-Gg: ATEYQzzzx8beAMms52rXSkyeBKfCSu21I+9PUb84EIXivUpvFdUqyN+RDrj9B1XXGGb
	k+UoFrRepBkZUaeepgVhXH6vBVBAba6HxeCQHH5atOGVnPFQyc1UlqkaqROJ4OR4VqWoU1xvjs/
	bZSU/tDmK8+B/jMG9lqz0VVDHkLyz/2wTUi6XI+h9vOnn4SbIBbPnooObSkp2t8JTVRn9jyK4Le
	Mr7NhmR7mF+FafszJwtf+GFYMMmqQ5jXdCkupsKeNc7dkyP7j08JGczsJqep3roGARF1lLXlFGi
	o/m5devdHhBpdbepAjthJN3Nwuf5xPfMcwVh
X-Received: by 2002:a17:906:eec7:b0:b87:d255:39ff with SMTP id
 a640c23a62f3a-b9081b37fe6mr1411724466b.32.1772129014224; Thu, 26 Feb 2026
 10:03:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260225-dma-buf-heaps-as-modules-v1-0-2109225a090d@kernel.org>
 <CANDhNCqk9Uk4aXHhUsL4hR1GHNmWZnH3C9Np-A02wdi+J3D7tA@mail.gmail.com> <20260226-adaptable-vermilion-nautilus-0aa6f0@penduick>
In-Reply-To: <20260226-adaptable-vermilion-nautilus-0aa6f0@penduick>
From: John Stultz <jstultz@google.com>
Date: Thu, 26 Feb 2026 10:03:21 -0800
X-Gm-Features: AaiRm538ftOfa1UyUjDoV9Yd7b0SRwtnSHBghCEM_shajRcZSxbK21W611Pqdkc
Message-ID: <CANDhNCrpNU7QJgu+0CZRvdxLwKp8VNxZoG_zDo7qqxaE0mjoTw@mail.gmail.com>
Subject: Re: [PATCH 0/7] dma-buf: heaps: Turn heaps into modules
To: Maxime Ripard <mripard@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	"T.J. Mercier" <tjmercier@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 2:18=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
> On Wed, Feb 25, 2026 at 10:51:30AM -0800, John Stultz wrote:
> > So heaps-as-modules is common in the Android kernels, and was
> > attempted to be upstreamed long ago:
> >   https://lore.kernel.org/lkml/20191025234834.28214-1-john.stultz@linar=
o.org/
> >
> > And it got a fairly chilly reception, but maybe having the additional
> > optee heap (as well as other proposed heaps) might sway folks on this
> > now.
>
> I didn't know that Android was using heap as modules only, but I'd say
> that it's even more of a reason to upstream it then.
>
> > There is also the kref bits you might need (which Android still carries=
):
> >   https://lore.kernel.org/lkml/20200725032633.125006-1-john.stultz@lina=
ro.org/
>
> I'm curious about this one though. It looks like you add refcounting,
> but never really get the references anywhere. What was your intent, that
> on every allocation the buffer would get a reference to the heap so we
> avoid removing a heap with allocated buffers?

Oh, apologies I mixed this up. You can ignore that suggestion.

In Android, once folks were familiar with thinking about dma-buf
heaps, some (out of tree) drivers wanted to be able to internally
allocate from a given heap (somewhat of a hold-over from the old ION
drivers). So we have a convenience patch to provide that:
   https://android.googlesource.com/kernel/common/+/8e1ec97355ef9927e82ec18=
c98312bdcd80bf289%5E%21/

And since we return a dma_heap to the driver to allocate against:
  https://android.googlesource.com/kernel/common/+/fc1310ebf8fe25ea7b983400=
e6fa41f5a6d11966%5E%21/

The kref bit is to make sure we're doing proper reference counting on
that shared pointer.

This ended up getting bundled together along with the heaps-as-modules
changes in our out-of-tree changes, and I just confused its use here.

thanks
-john
