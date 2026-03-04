Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFA334A78F
	for <iommu@lists.linux.dev>; Wed,  4 Mar 2026 16:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772640519; cv=none; b=KEUiQXWQcplxZl6uxp9MCyQxl8d8P//jL2zvfBbU3Fm12S9V3/DaJhq1vXAe33dSx7+TZwc4faBzw0SSjxlTvaz/othUbGznTKkIW9LOapjfHOrnWiyRgIH26+swDqC3NXW28ehC1gV4FNeUTCAxkjWVgoRaXq4jdFjuzyuDdy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772640519; c=relaxed/simple;
	bh=XuIJEyuPZseimNyB1dClJ9+gsbn4gJI4NK41evppQNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BC2huksc+eS8SiOj+ftoJv32CBddqWgD4BY/vCKBAuvd0vdojAab1K1REzeyqLsJLM9QimDz6qCU2BeUtJF5E1Zyvd2U9ohbqwK4OkpHV5vRq+CwmoStbrFeA7J3N0sXby3KT3pesHVa6yEdnHDDm1tYFUPDcHPeqjCQoJsKvkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ct9G1qwy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ct9G1qwy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772640513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XuIJEyuPZseimNyB1dClJ9+gsbn4gJI4NK41evppQNk=;
	b=ct9G1qwyXb6Qu9SaTz9/l9IoD9eMtqV3ykvPYkw3n9QLfiPK4++z3nMw003XneUp+pSNNW
	YxFIZcKdapRxHrOTG+s5a+s+HEj1ZbBprVso7HGRXaxp5PERbyRoVZJ5xHIomHvjwOXqYz
	X+eNHwiPuibk9/sCri/XD97z/9YDTtM=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-fs_igGG2MNS5hv2Lub2hzA-1; Wed, 04 Mar 2026 11:08:12 -0500
X-MC-Unique: fs_igGG2MNS5hv2Lub2hzA-1
X-Mimecast-MFC-AGG-ID: fs_igGG2MNS5hv2Lub2hzA_1772640490
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-679a409a175so122876589eaf.1
        for <iommu@lists.linux.dev>; Wed, 04 Mar 2026 08:08:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772640486; x=1773245286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XuIJEyuPZseimNyB1dClJ9+gsbn4gJI4NK41evppQNk=;
        b=DivgA4b3LVVE/tgiaKVTwM5q9h6IyWlM8xY2EZuow2+v5t31PXpecG8va5uPYgQo2h
         hQBtADl5rgIq77BRsLzdu7v+7PGlzqEkZVP2bBnhEzLeWG5cXCZYbFpi+WluV4PRIX62
         AKMvb65qEuTHWOMA2TzyhljdjiI9xq4eUphQxIZRz9Nqjw+XjaBx8x2jnAO+un6MqMtd
         YJQ7XqmEKeIGkJXyiB6DmNCCAd4hLPDsjYaDDQZfZTW9V/1YkQh4v7nfnmfUNTphPIqw
         cHolGm2vPrp42CbSEd/aMom9W7syiUnd700lCepHkzF5iEC333O5JhlNPEzRin4q58eW
         DDLw==
X-Forwarded-Encrypted: i=1; AJvYcCVGxUv2iY6tRQMlflsoI/si8WF3ii/pSdgqVSlIMosTxsvPTY1Hl8eTXM53FYIxqnL0YvcQNQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzt6OD+et2aiLLdkmoIlfa5ey74KGVyU0H27AjTzeNOPgYFMgmC
	3ppkcbpAER6441WRXq/d6WHY2ilsq///rdy1MYVpkQ8s5liSSjCaVMpHtbGYL+T+BmqL1dGTojB
	wqLyv/KT/lldn5Ox9PBkxYQjR7fvYLHyry7bX2FOco9rEr4n+lP4a1EiNn0hiyc53hYEi+rPHs7
	j9ZM7nVnBoRRhr6x8tXA7ti1rq6vX/154=
X-Gm-Gg: ATEYQzwDJwBewgfJTlyPtZ+J/PrOkhmfRP1pa1y/EBFKotD9/PuLKag/llWJtEH0AQU
	ILKoDF2KcweSs1VVsgwYqFRelqkZt3IsD5wVRfypPnkx58OHC3LUlQdMANdh70Tiwk0O3sI4NBz
	VC3KWucFsgPw0/QigidzXd/U+SiBDjqepSZUJko73NYXxwcQvNLsYgvorfgV3yCzCvyfALAA9l6
	g==
X-Received: by 2002:a05:6820:1ca4:b0:679:e68b:f95d with SMTP id 006d021491bc7-67b1776bde5mr1385791eaf.53.1772640486022;
        Wed, 04 Mar 2026 08:08:06 -0800 (PST)
X-Received: by 2002:a05:6820:1ca4:b0:679:e68b:f95d with SMTP id
 006d021491bc7-67b1776bde5mr1385781eaf.53.1772640485669; Wed, 04 Mar 2026
 08:08:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260303-b4-dmabuf-heap-coherent-rmem-v2-0-65a4653b3378@redhat.com>
 <CANDhNCrVVGsxEjgRcVJSn_E9WPUVY_9zpd+t0X_Jy7JqbcHDqA@mail.gmail.com>
In-Reply-To: <CANDhNCrVVGsxEjgRcVJSn_E9WPUVY_9zpd+t0X_Jy7JqbcHDqA@mail.gmail.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 4 Mar 2026 17:07:54 +0100
X-Gm-Features: AaiRm51Q5GvpC48eWrWjCC8xCsFxsretWrNgIwHjulMNxRdjdZzE0CFF6Jj-oi0
Message-ID: <CADSE00KqF-7m+ZMYLzzgL3FzZv3P_G-v8ycYdXBj_WE4=P2_jw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] dma-buf: heaps: add coherent reserved-memory heap
To: John Stultz <jstultz@google.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	"T.J. Mercier" <tjmercier@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev, 
	devicetree@vger.kernel.org, echanude@redhat.com, mripard@redhat.com, 
	John Stultz <john.stultz@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qsDA2CBMp_D2L7wx7_XqNW1mvr4dpnl6MQekI_w6VLA_1772640490
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 9:55=E2=80=AFPM John Stultz <jstultz@google.com> wro=
te:
>
> On Tue, Mar 3, 2026 at 4:34=E2=80=AFAM Albert Esteve <aesteve@redhat.com>=
 wrote:
> >
> > This patch introduces a new heap driver to expose DT non=E2=80=91reusab=
le
> > "shared-dma-pool" coherent regions as dma-buf heaps, so userspace can
> > allocate buffers from each reserved, named region.
>
> Just a nit here: Might be good to provide some higher level context as
> to why this is wanted, and what it enables.
>
> Also, "shared-dma-pool" is also used for CMA regions, so it might be
> unclear initially how this is different from the CMA heap (you do
> mention non-reusable, but that's a prettty subtle detail).

Sure, I will expand this for the next revision and try to clarify the
points you mentioned here (and add these points to the relevant
patch).

BR,
Albert

>
> Might be good to add some of the rationale to the patch adding the
> heap implementation as well so it makes it into the git history.
>
> thanks
> -john
>

