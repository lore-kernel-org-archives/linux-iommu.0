Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44778147C89
	for <iommu@lists.linux.dev>; Fri, 26 Apr 2024 13:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714139403; cv=none; b=chUJWc8Ut+B+eDxB0aGsMTcQkRSn/F9gc4sn2n3GfnbC0tAzvMWKi97PKIR485U42g8qTuNtC/r2pWS30DZyLYBhw2ZrWHganbFCChPDgSXu7hkWf/ufBhaOapAZ64KkhDhAPLACGEl8G49u+pmDYbbfskC3hRMbFkRnqXfbyYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714139403; c=relaxed/simple;
	bh=yEHETsmy6A3pdmED7LIQsgDNKtWVkTM6epIFSP8k2Pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EMhfBsY0yM1D5QKuW8O8oYvCZQDXOxmnL2tEXEWxybcXo1ENwgEUn9LlW6rOdnMncma68zuVWDU272TxVUVotjtiOHjE/o+wsQoedxMMfv7h/i7vI8oB/pziBPi8LVWnlX6UGEKoeg7kJHzYsjdT6T2lQR90Am5dcw6uVzlmrFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=xFls+NBw; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="xFls+NBw"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-43a5715f71eso8778851cf.0
        for <iommu@lists.linux.dev>; Fri, 26 Apr 2024 06:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1714139401; x=1714744201; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hww4hDlFqZRQuN2jVnVqsCqso/mW8GodRjS6lEQgT4E=;
        b=xFls+NBwAg5miJ/celYvO4gSwY5f4oqVVQTznCt27K/CE0Kk0HojkSymuZlbK8eOwD
         aKPEODzXdCKOcdi7lsGZgKztwM3a+V4Bx0lpKbtI+RZMWRNrb5gKSrWDGrsoXrwQPg2z
         o1C5oG3ES4xaQBaTWy+In+UQjrdplffWPm+G7xOsXlnhBZmM9WrKzuOU2wlZnYjKzaH3
         iX5ypHESORIr37akMpBTU1vduy3NkMW65Vm8C+IN9kil69w7bEFGbvdH7bIC3pyPPNuU
         n+IaKLgrC9t5fOuVLf5YlNT5A/2c/vsfb83c2mVvz7Wp5c3dJtVEtgT8mZ2u0uxRo8GQ
         2xjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714139401; x=1714744201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hww4hDlFqZRQuN2jVnVqsCqso/mW8GodRjS6lEQgT4E=;
        b=Hg2voRdoeAOLdbaUcYYXrsYBhmT/wTFkoGnlLmW+47bySmR1EgX+ZwB9kAn8rc99sW
         IYZEfUk/mXb7J4p7mINHYwCwukF4Lyd9Vt6UJMQ46v9TNha3gWS6cCuytB1KBz/pUBc6
         d8EFOILydkEhBiKTnQN1m0MTm5Z9KGzWsbIKrpUiipaKb3MDbdYjkzGx9zsxKJbThxm1
         qVOSYrdLOgZhe8mOJaCGx3HguthJIkQBfzZFcCSFpg4vlW2pgaaTwOABhQkBVkMw6NKY
         C1Kud9cJq9MFCpTkG0GzKpes+e8vGiZCcyoCndPZUGApQItRYDP5DuL9xo8L10EmQSuX
         URZA==
X-Forwarded-Encrypted: i=1; AJvYcCUkVd5D7y3hEe4iCKUNvDAuLKv5fVNESh+55rH6yXWoA1qUnCQTyVinDWqVKwnrFzrc9FEksmC+mkDMBAEQIZxeyHWc5sc=
X-Gm-Message-State: AOJu0YxBoQjt7Vn+sC4cWOZPzMs4fumQJXUnSrhz3yuSFmiLoiGWw0Na
	L3aqWBibC7xrRDt+71iDIxvXzpFf0gbinJ6GtDlDpNQAkCDqIUOINloT2DGWvsrNaLZxgTGtlfF
	O9Bu/ZDdrFryeN7H0HraiiLvBrtoweviRE1tkFw==
X-Google-Smtp-Source: AGHT+IEQJm6kYqJSWyv4kAgbHk6X+OT2P1LduO5vFa6/5g2dJaFsMcv+gi7fN2vALs5HFxFMrnRXLC5G51Qg8kIXMJw=
X-Received: by 2002:a05:622a:5286:b0:434:9991:6498 with SMTP id
 dr6-20020a05622a528600b0043499916498mr3263799qtb.43.1714139401100; Fri, 26
 Apr 2024 06:50:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240426034323.417219-1-pasha.tatashin@soleen.com> <2daf168e-e2b2-4b19-9b39-d58b358c8cd9@redhat.com>
In-Reply-To: <2daf168e-e2b2-4b19-9b39-d58b358c8cd9@redhat.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 26 Apr 2024 09:49:23 -0400
Message-ID: <CA+CK2bC4SWTCG2bnA16Xe+gX7=N=UYWB1wSns-K-jNqC1yrdvQ@mail.gmail.com>
Subject: Re: [RFC v2 0/3] iommu/intel: Free empty page tables on unmaps
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rientjes@google.com, dwmw2@infradead.org, 
	baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, iommu@lists.linux.dev, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 2:42=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 26.04.24 05:43, Pasha Tatashin wrote:
> > Changelog
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > v2: Use mapcount instead of refcount
> >      Synchronized with IOMMU Observability changes.
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > This series frees empty page tables on unmaps. It intends to be a
> > low overhead feature.
> >
> > The read-writer lock is used to synchronize page table, but most of
> > time the lock is held is reader. It is held as a writer for short
> > period of time when unmapping a page that is bigger than the current
> > iova request. For all other cases this lock is read-only.
> >
> > page->mapcount is used in order to track number of entries at each page
> > table.
>
> I'm wondering if this will conflict with page_type at some point? We're
> already converting other page table users to ptdesc. CCing Willy.

Hi David,

This contradicts with the following comment in mm_types.h:
 * If your page will not be mapped to userspace, you can also use the four
 * bytes in the mapcount union, but you must call
page_mapcount_reset()
 * before freeing it.

Thank you,
Pasha
