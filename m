Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC7D21C16A
	for <iommu@lists.linux.dev>; Fri, 10 Oct 2025 01:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760060593; cv=none; b=blo5RRYxtFhwN1+Le9/10lFLJJIw8VhR5miCZ0gaWxqSyngmNown8n92/aOmX9bq6BFdQNi/Aybvu6AKyFPq/bHUd4Rgx76jXIQY4TILOkDsbhYwCPu68FIVje8G0PSBp2etBenx7IrCnuqQLOt94+xE3mUYFE9h8ds3LbDMCEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760060593; c=relaxed/simple;
	bh=NPtqkvv98yoDXNHLCe00Nr0xHDE7ZeJDXsad4q7/TKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lmZvf2TPOe/6jZXGXe1c96zeKRnabrBG5QrsL8mINKqT67jhM/NHSd507AsXBUy0sReCjwevecamXlv+O3HTJRNwGYN38cox5qNjiff7+zT7psXUNtCfbvdQw2aDrHYY0Cw5DmFu02r4eUATluXMoA/vMGPFG/OjzPTyP2Vzsko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R55QFzaC; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R55QFzaC"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4dcc9cebfdfso81621cf.1
        for <iommu@lists.linux.dev>; Thu, 09 Oct 2025 18:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760060591; x=1760665391; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96az3arQQNj4x6OI7kGaXy8qdPeeaXxUJmGrbGqdnv8=;
        b=R55QFzaCgAHW7IhVQGBq2mU40y+i9u5e70kQIqq5vf4F83uRck7yZlK1jf3KPZSneB
         vA538zozb4g+BMoMi5ic5zKKIPsOBRqvQIGU98fHKghKayrtJUHbxM33tpZjC/CQq8t/
         iUYpkHdhf+43+duTybyrV8Yima7XRJF9YU5goSc7+HgjdRdJPObJG8rhlHfTs1hHVA+0
         CmV04k5WgU0UK+zb9nYMUi0Ykiolc5Oe7EhRRh7cOHLr7ep8VIY1vmG3kyXLEV59Zy8A
         KAEzGtnqgaJpIqYNI8Z1MMYMq/WmfFQtvSQtvEEpuOWEYehdf7WOuQLwYI1QvzG6vBVX
         2Kwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760060591; x=1760665391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96az3arQQNj4x6OI7kGaXy8qdPeeaXxUJmGrbGqdnv8=;
        b=fSiwt/0vpTBldeARkeX3M1/dhy8Ijj8gbwXURmrzD2f0vefXmrp/35lZv+P6dVmT+N
         cZH7vQBya3kDzKAKbO5TFWwKT44v7Q43y8xlXjsquShYjQ72vyF3Sd01bFZO22GTZqxe
         b8NNGACYE9eMCkZxR0mh3Q65g/KPxYeQsHolz7lRWA4VJhUx4Ge0th4jg2g1Cq4PipDR
         U9jJ2ZtcO0H+ggQEcB5LF+SmvK3Rtci7Cp4p3mtzGXZxVhOyA+fBcVEwrnU+O5K03XGJ
         nF4FbcLN7sY5auSytOiYNOQY3WwRkeG4S+K5rW7S9ORaHuqfGa+oXmT8GVnMRkpfJyGa
         dWwA==
X-Forwarded-Encrypted: i=1; AJvYcCXO3boEngSWuWtIH262MqeJRBfwVVlUjItMGXSfZ/50DmEPlD70BXvFhYJjzCdrsXKoHwRfYg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7QRDfPUlksuyeej5SbkLh+n2cSw9GHbcz0SrMBeIMfwBZPprk
	KuHcy/K0s74PXln3drNxZ1/vaPfPgc2nCtEUDEVeFEuFAfh4OP8wkNezyh/qyuDlc9ShgvUleQR
	4INbSMGR6HIKU3Zy/oBObqnRmwpRHUxUOzjjgaTzq
X-Gm-Gg: ASbGncuYYbP5dnPxAr1nI6xRFnLswybTxHqiOnSvmJ8RiIYuyHQ+IUHJrAZnuO3iCYu
	LGWxiIK4Ctof0FFJ08Wzl5RLv44jX34T2tOUAyt6TEtV1AlgOgpyqsQRe6Ncgc8aqsVnC43iIkK
	d1yHVfsOADpg0PXsFCZdTYf5PRwSTthVQPgwWaPesCHfwfiI5s1uNYbAncj6zIa7ptwPr8tFaPW
	gfe+KNWpl7sVCj9hHYF1Ltt0J4jKUL/YqKulLtfvoxQdwTaMHvUOr3jsuEHcR1cpYpDx7pFH5Dx
	fcU=
X-Google-Smtp-Source: AGHT+IGu0DK2CtCxN7hIIonTOKdPg8kH2c5mClv9tYOC7wcuhU0agjHl/Z5qabjh4i0XRN459MUgMBBjudlklfZKzww=
X-Received: by 2002:ac8:590c:0:b0:4b7:a72f:55d9 with SMTP id
 d75a77b69052e-4e6eac2a26bmr18693271cf.13.1760060590253; Thu, 09 Oct 2025
 18:43:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251010011951.2136980-1-surenb@google.com> <20251010011951.2136980-2-surenb@google.com>
 <20251009183145.3ed17cb0819f8b7e7fb4ec43@linux-foundation.org>
In-Reply-To: <20251009183145.3ed17cb0819f8b7e7fb4ec43@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 9 Oct 2025 18:42:59 -0700
X-Gm-Features: AS18NWC-Nnw6mbU0XDp5pk62GdBblSXl-3NkXh8X6HtK-SeNhS47_j3D0edxdNk
Message-ID: <CAJuCfpEPOOFOtd-Vp4VtTJyqxP_5+7h7SaMT=6exY1YZOE9v5Q@mail.gmail.com>
Subject: Re: [PATCH 1/8] mm: implement cleancache
To: Andrew Morton <akpm@linux-foundation.org>
Cc: david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, alexandru.elisei@arm.com, peterx@redhat.com, sj@kernel.org, 
	rppt@kernel.org, mhocko@suse.com, corbet@lwn.net, axboe@kernel.dk, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, jack@suse.cz, 
	willy@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	hannes@cmpxchg.org, zhengqi.arch@bytedance.com, shakeel.butt@linux.dev, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, iommu@lists.linux.dev, 
	Minchan Kim <minchan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 6:31=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Thu,  9 Oct 2025 18:19:44 -0700 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> > Subject: [PATCH 1/8] mm: implement cleancache
>
> Well that's confusing.  We removed cleancache 3+ years ago in 0a4ee518185=
e.

Yes, this version is a complete rewrite. Previous version was a thin
layer acting as a middleman and having hooks deep in the FS code. This
version implements most of the cleancache page management inside
cleancache itself and allows GCMA and future clients to be thin. It is
also much less invasive, limiting its hooks mostly to the MM code.
From the cover letter:

New implementation:
1. Avoids intrusive hooks into filesystem code, limiting them to two
hooks for filesystem mount/unmount events and a hook for bdev
invalidation.
2. Manages inode to folio association and handles pools of donated
folios inside cleancache itself, freeing backends of this burden.

The idea was presented at this year's LSF/MM and RFC was posted at
https://lore.kernel.org/all/20250320173931.1583800-1-surenb@google.com/
earlier this year.
