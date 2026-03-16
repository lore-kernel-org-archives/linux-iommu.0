Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115E038D019
	for <iommu@lists.linux.dev>; Mon, 16 Mar 2026 10:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773658507; cv=none; b=n88rADJCyTe65vMc2nA6T+u/0haR+eyUah44adfS921E3tNhMqqyfEbvkJAloc0hQRXu5W4wQeu5JNvASQJzx7FP41RXbHYLxKp86X9I7GaW1hpok1v6jkwVOFI65eAemccCHJFRxsVYwe3PRawv52XNmF/wfFZ3QK/j4J+EC+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773658507; c=relaxed/simple;
	bh=PENpEpatLH0WgmJ8nuINA9vJeOA32NMCLpwxPNCjmic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SUl1DR7vPGvRAFmUx6aAod4GFpsfNXB2zzjyl196nnKiQAz0vJMRiKyB/llAij+FjnqdePFkwgkOFX/vc1l50aDBKRHQdmOLKMZrYqRHQwm0Gj44cwIYnXD1RhHFNnWTeCjipWA5RtFnJA3+258Ux7J9JDY/NXhpCkrFhnJogng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HaGSGGqy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HaGSGGqy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773658505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j/4AllVOKh8z4TecylNv9BZB3czFOIQzZj3H/I9GZN8=;
	b=HaGSGGqyqNoof3Zy7y+eQNFzjoTXW0vtCtSIvGUpyOha2YVjkbhCCul/gYrsRmYCZ1atdf
	xQ3XqLxoGgvUkxVkgv0wJeZTNJHvCqWSY3Bs0g2oMXhTCyyAR0E/PdM29OP4I/+JHpDGRD
	8jzhMTWWrd68PYOpc4IXtzmwkqkgmL8=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-B4zO4QxTM2utM3WzC2Q84Q-1; Mon, 16 Mar 2026 06:55:03 -0400
X-MC-Unique: B4zO4QxTM2utM3WzC2Q84Q-1
X-Mimecast-MFC-AGG-ID: B4zO4QxTM2utM3WzC2Q84Q_1773658503
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7983f854288so85361107b3.3
        for <iommu@lists.linux.dev>; Mon, 16 Mar 2026 03:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773658503; x=1774263303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j/4AllVOKh8z4TecylNv9BZB3czFOIQzZj3H/I9GZN8=;
        b=CFPiwX3rsHDyxg/AVSSjMJ6kIpup+s9aFbOApQDkipNKZ6tncRvXq23KoKLzqeg4SY
         FAhkNJARAqdTOE/WHJAw97KC2rDkGq5muLFJ5D0ur4p0gmD2th+Md/0xTmHY72dHuk4J
         hy4ToRHryxiym0XpDMp8/WceynQmXWeGSZ6Rb1jcwEEtLVSwCCOEj7Wg5qrdBfylyr+v
         tOxIsVOiy4ccQCO9pYryCixETuSMxl8Aw7XB08N9FtprcYSbkS/zUTl44PdpifKwkBDc
         gUaX6dl9jY4RNy3GLQppW3DUHv9q9J6m6pM0cg7k+TvV81KUzgRk8WKdkcg/B2lMwDyQ
         USKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuhL4JARoqFaRRyJaw0qXaqOXBsfnTWwzu8275ESQEw6UKjAT573HFf/Hbrkl8SLRwdNr3kQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxPLNFwbeT4sByX9aGsbAV1xy+piuvUEe0TnXZj/4OFHHvxRd65
	jYbtEQwNa+FsTN2zvoc9rQsIkrL19eGaM9AUg+TAE6wXoX1Xkq9oehPx7fvHIcWuxGQygpMchD9
	V1Mtwh2RGoJaHyS0RGH5jcC8vKpbnJoXJvE3rUWN1ecuABEr9CAtyDyX/+MzdULEMBWtEVLc4gG
	gLrw94UFCxd7Y9BRNqNT4j2alRPsQYXX8=
X-Gm-Gg: ATEYQzxe0j0guP3/KDEg6RsL9s2IhYN0Wvgf/hIpuvm04o8ivFgHaz+/AXuXbYmkFw3
	yvo0mzoc4WtUsnrmkQ06r2NBwCBTHm/w/96eDpvc//lT3LB8Vi1sqiUk1Rj7ZY4GLjL+tQouerH
	4vlCsBe+um+s27bLzAUaDQrTelEdtlo0u6HsE7qIQAuLCGjodawftGfxB+rgXz1GM+9dCKLBZcz
	w==
X-Received: by 2002:a05:690e:449a:b0:64a:db50:fab2 with SMTP id 956f58d0204a3-64e630d964emr9195123d50.80.1773658503296;
        Mon, 16 Mar 2026 03:55:03 -0700 (PDT)
X-Received: by 2002:a05:690e:449a:b0:64a:db50:fab2 with SMTP id
 956f58d0204a3-64e630d964emr9195107d50.80.1773658502956; Mon, 16 Mar 2026
 03:55:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260306-b4-dmabuf-heap-coherent-rmem-v3-0-3d00d36c9bc4@redhat.com>
 <20260306-b4-dmabuf-heap-coherent-rmem-v3-3-3d00d36c9bc4@redhat.com> <20260313230629.GA3603067-robh@kernel.org>
In-Reply-To: <20260313230629.GA3603067-robh@kernel.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 16 Mar 2026 11:54:51 +0100
X-Gm-Features: AaiRm51o4lEgIIRwy7J8EQU-dh_zU9bcODR7YayBvstmpxh8vjYCQuobudoxI8I
Message-ID: <CADSE00JymMjob5J02bh+YSw+2zyjx8OWxks5aEhuM2GX8ZB7=A@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] of_reserved_mem: add a helper for rmem device_init op
To: Rob Herring <robh@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Saravana Kannan <saravanak@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev, 
	devicetree@vger.kernel.org, mripard@redhat.com, echanude@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cMXlP06ksV4jFGpSRgq0rgA4paYky9BGqRXur6s7tYY_1773658503
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 14, 2026 at 12:06=E2=80=AFAM Rob Herring <robh@kernel.org> wrot=
e:
>
> On Fri, Mar 06, 2026 at 11:36:34AM +0100, Albert Esteve wrote:
> > Add a helper function wrapping internal reserved memory
> > device_init call and expose it externally.
>
> Why?
>
> The diff tells us what. The commit msg needs to tell us why. Maybe the
> rest of the series explains it, but this commit needs to stand on its
> own.

ACK.

This patch prepares for the heap implementation in patch #4, which
uses the new helper function. I will add the information to the commit
body.

>
> >
> > Use the new helper function within of_reserved_mem_device_init_by_idx()=
.
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
>
> Version history?

You mean track it in the commit body? History is already detailed in
the cover letter.

>
> >  drivers/of/of_reserved_mem.c    | 68 ++++++++++++++++++++++++++-------=
--------
> >  include/linux/of_reserved_mem.h |  8 +++++
> >  2 files changed, 52 insertions(+), 24 deletions(-)
>

