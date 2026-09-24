Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1CD49F13A
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790262047; cv=none; b=RPBS9JNcrit0lXDnDWJd4PGOctGqFw4NjAhA2La/1qiK4de/5kSihnFGMbcZHrlYrhxBHaCtYBpbFftvd3KkkHvZN4YNrhGk2c+rx8PzAIsKdk2PEl+NRPgWUPnmK1XYKlCG0BYnzZxkucvQItNMhxq63t7CGlB3yIeEqZYy+0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790262047; c=relaxed/simple;
	bh=iuUfA02SH2tSSicml2K0I3xqm9pZO7ThoY25b+dKE6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YFUCGjZyKxj7jSukii2P4OvOZ5b1f1hSd3q8zW+S7LghWL4numZpiUVHD1JqfuRAcsSStOG7mGf7GXyLevQ8d0FE749S0dSEza9SZdJgyOmmSYv0urCY+YALJO25UjHHeP9e1m4MkCV59SwQVDOx/M+/dOErSyVHPOVIVehDL4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h/tUKF+G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/tUKF+G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790262042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YKTy1DV5Z8HP/0nQigR4wkQdWVD6m+LzXDtQhSwKE3c=;
	b=h/tUKF+GjUa0Y1mVfe+yVQYzqWASfzm5/7k9EnciidAxox34sO54UF/voll/xmfgUGq8aH
	2EuBMW79l/Z623eXVcIWgACtfc3pUpSLhU2X0CCIjiSoAnZNr0R9gBnRC0wKqcY3lHBoz7
	YK/Z34l3bpo15gnKhX3liV6LGOef2uo=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-X1--lt7aNfG0vv6603BnDQ-1; Thu, 24 Sep 2026 11:00:41 -0400
X-MC-Unique: X1--lt7aNfG0vv6603BnDQ-1
X-Mimecast-MFC-AGG-ID: X1--lt7aNfG0vv6603BnDQ_1790262040
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-87014338e7aso20650337b3.1
        for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 08:00:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790262040; x=1790866840;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YKTy1DV5Z8HP/0nQigR4wkQdWVD6m+LzXDtQhSwKE3c=;
        b=ZYgjIXRr5tOiyD1yEYLWVPJAk6oFjM4D2tgymlW98d8PGTFsaUTOwCwcfZI3xgaFfy
         6Z8Ho3+SH5lufc4i8z5QmB5ur/C6AKPTmdro0B/XVpM0y/dXHzG616fWhbqisErNcNjD
         8KXJDLEBajCY96ueV9bwZoLdzFcMu4ntssMhRCAY73hjPhAJFh1WYFf/BwKViokYqb0R
         YxH0gyeR8UU1xzIXZzxhwIh7ifqhb1429sgiVBK2+phcQjpw6SOvjhur4201Vme6tbxG
         B9XYzxa2FrRy/Bf3thDNqPFm7F94TiZvf8G9iWwhbgR5JRe9WMvZkjPINfJNf/u0roz+
         d1LA==
X-Forwarded-Encrypted: i=1; AKwUvBzN2Juma1joEdiT2XBNdRPqpl/ci7oWcVJPL74w7GZSPJPYOUTUTsw6bbVztj3nNEpExjswaQ==@lists.linux.dev
X-Gm-Message-State: AFuF++n/TN7gfBtgOPxZI9zfQ8MdebSdQaLOSjr7eD8Jw/2qE1oGYiEY
	ePJgUI65Fq8LbgLmUJMz1HHHGMAmKPD3ZJMDDw2EbIOzzj7KPdOwqHDnzRgimaNOWR+oIN3/7ui
	WvsXudtP7Ju4r/EUrFzQ7HPO2j/RPyUWxmkkpEjxBKxMFjbfDBZYXaBrVLIJvAf3/zBcgmUSlR9
	T/Aq8Vu49tRQuVWti3i4mQFAkovTwirIM=
X-Gm-Gg: AYBFou05VViaEHnAILG/HfAuxgUXX+uG9GlJ8ruw/XM3CzL68HojLFNuBdYTrj9bK5a
	DpMgiU4tSftgsYpNQ3X3WD+OinaofORzhjMmotG3AjDaB7LACthp2wh+LJh4Ai4LEHGZhj/8RpA
	cO8PysEA5QnMfbLQ4hUaMLtD/R3a9VlnhAk30ta4g307cGhu4FR0RI+Q==
X-Received: by 2002:a05:690c:f04:b0:8a4:af43:6941 with SMTP id 00721157ae682-8a64e5d7328mr16132207b3.20.1790262039547;
        Thu, 24 Sep 2026 08:00:39 -0700 (PDT)
X-Received: by 2002:a05:690c:f04:b0:8a4:af43:6941 with SMTP id
 00721157ae682-8a64e5d7328mr16131377b3.20.1790262038827; Thu, 24 Sep 2026
 08:00:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260914-scm-device-api-v1-0-3573e2596c51@redhat.com>
 <EKwbCgCnxbNX4p95qJ3xoytzeNBBLc2L_HOVWr-S-y8n7pNOIToj37TyoXRcLyIK1gjq_IvbreQ331gw6jIK9Q==@protonmail.internalid>
 <20260914-scm-device-api-v1-1-3573e2596c51@redhat.com> <b1340496-1ff3-4ad7-87c3-36d2162efbfa@kernel.org>
In-Reply-To: <b1340496-1ff3-4ad7-87c3-36d2162efbfa@kernel.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 24 Sep 2026 17:00:27 +0200
X-Gm-Features: AclHuK_S1nrFMWot6v8DC6klfULfaNk07isgmJtfP7BYAekyrR84kzWx2Uw9qhE
Message-ID: <CADSE00JhFYhDV2cuVxZwVTX6LTe8zH0-BR=-Fhv+6UXeFxq_Zw@mail.gmail.com>
Subject: Re: [PATCH 1/3] firmware: qcom: scm: pass qcom_scm to internal helpers
To: "Bryan O'Donoghue" <bod@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Russell King <linux@armlinux.org.uk>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Christian Loehle <christian.loehle@arm.com>, Maximilian Luz <luzmaximilian@gmail.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Rob Clark <robin.clark@oss.qualcomm.com>, 
	Sean Paul <sean@poorly.run>, Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Jessica Zhang <jesszhan0024@gmail.com>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, 
	Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jeff Johnson <jjohnson@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Jens Wiklander <jenswi@kernel.org>, 
	Sumit Garg <sumit.garg@kernel.org>, Amit Kucheria <amitk@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Brian Norris <briannorris@chromium.org>, 
	Govind Singh <govinds@codeaurora.org>, Niklas Cassel <niklas.cassel@linaro.org>, 
	Kalle Valo <kvalo@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, iommu@lists.linux.dev, 
	linux-media@vger.kernel.org, linux-wireless@vger.kernel.org, 
	ath10k@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, op-tee@lists.trustedfirmware.org, 
	Maxime Ripard <mripard@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oOajz43EhuBm5sKV76SmDjYjQyNKKYDUrobhe8UjWfI_1790262040
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 11:00=E2=80=AFPM Bryan O'Donoghue <bod@kernel.org> =
wrote:
>
> On 14/09/2026 13:41, Albert Esteve wrote:
> >   int qcom_scm_pas_auth_and_reset(u32 pas_id)
> >   {
> > -     return __qcom_scm_pas_auth_and_reset(__scm->dev, pas_id);
> > +     struct qcom_scm *scm =3D __scm;
> > +
> > +     return __qcom_scm_pas_auth_and_reset(scm->dev, pas_id);
> >   }
> >   EXPORT_SYMBOL_GPL(qcom_scm_pas_auth_and_reset);
>
> Why make this change at all though ?
>
> It takes a pointer to the file static _scm
>
> The reset of the patch looks straight-forward to me but this change
> caught my eye.

Yeah, this change isn't useful. I aimed to avoid passing __scm to
function calls but it does nothing in this patch, it'd be better to
change it directly in the next patch that changes the signature.

BR,
Albert

>
> ---
> bod
>

