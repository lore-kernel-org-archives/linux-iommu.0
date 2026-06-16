Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD6F36F42B
	for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 15:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622481; cv=pass; b=D9jFVZ47uAGb7LP1W5XPYq4PzYTbuJxHsrDUU82YI25YXz97DJnKmc06L84E6agy7iGf2rpkQLR8fD8MluzQ1t5CP/gbvtKmkGnHQOnItEblqPnDfYvFBSl1GHIu07y2nDSz4Vjkil4q3SfP6sqsM8r3UjAgvYvRfJ2a7BwZgoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622481; c=relaxed/simple;
	bh=tgJVBXAPvKOADMatPH6dObPtPwnXbB9HGcTOWlZ+8D0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nZd+Y2qSGkKw8koTZqnoFIz5RjsJ2gqRDCxAYS3Z3L/UMgvXmAMsvCSPZoI+CyMB/IZj9Ppmyr3UwQiu4MITbF6q+4qicuriCdvYbtqg7nRyKbjGeOPH+khWVEeAPGjPEXPSqL7295MWZswm+BW8O3yZ5mBvmttZ/OJe4rTeaXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MpyjXWYI; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MpyjXWYI"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5177d1ff061so144731cf.1
        for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 08:08:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781622479; cv=none;
        d=google.com; s=arc-20240605;
        b=iWK4/sT8002y8VWjsb9uIR3Nn+IN7UZ2cXXkJvlFMCXwpM/zdTnGICh5pPlxZrjBtq
         mjFHvT45GH3GThviUxKZ9RpDQPGp5bdKBKHV6bDabUm/hAyuDPVocQONzqcmUP/VgV7M
         6Ii6HVPLfINKMv4x+C5tAuDgOiqMzLsKxktdLTaIA1DjRZococ/6hdkfoUmDaFeH1aKQ
         38EAMTEVPnpBuEGlSG2JfJAxLBbSPmVBPLQAUgSoJ4XUMyfNg+QnXepbjuM8PghbWj7o
         5wSaDx9JQ0tK+u2wmyt7gXgBCEsILj+Ck2ebal9X85h6gXF5OixORRxmUWD1piXRfL1W
         ioYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fqq5dKUgw8U/2JqRQThbBU/bf6oLY395y2woLL4ZjX8=;
        fh=Xs6bssNm0S1EWlhHWyv9EHYZuuMlZXgHDEWP94jUKqs=;
        b=UiYaNg3SZFtBtPq6ExxBHaEJrVyc/wSvrjJuzQbUMu3IGj6fSAETfDqJWFWOg+5UtQ
         P6GxkUR/aYFse/ImkKxVtxs3+2YVixgcHLgl4HqmFxI1rIgZikBUPmX73vMbBi2hbBED
         DuoHdm4NkcUs8L0g/AMi/m7ZhFQZLQt6c0NNk6i4h1+mHV8tQZwo6TJ18cJ9PpNdpgA+
         ionJl0ACSpVcFTv+9K6zs04aDqQqDlmNPPbIw5AIS4lX3P8f6rVhOoh7CvnpsVBsflB8
         7OmdHHgHy8DPjF0d+ZrUdoWKQht9WmLHwAz7GczbZ2v8muy+w4Xjr2vje2BQdri1Ntsv
         7xtA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781622479; x=1782227279; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqq5dKUgw8U/2JqRQThbBU/bf6oLY395y2woLL4ZjX8=;
        b=MpyjXWYI9MiUczp9nKmb8/OaaREUYrbbDzBNwbiol6nTluhlQIJFDgHq+AP7YwDnzk
         3EDuDRn1CKbVBgQsxabDi2xjqkH4wSVL43sO0OrjUB62hEoL/G7mFT9hrpde49AcrK8F
         Eq+Ox4T/3O/tautRz1KhgGFlxDdYgqAl+boLMklIFzRV/s228jWQS1k3K0BV+A//t2v4
         qzJKZUJmtY1cI205YnoeicYqv6/y9IQt8k5hyb++LKHdnXCCSIu6GwluD7hd0XmioaJH
         BausjJT+X2vl6LdX2aY/DkV6DJak2ubv8XE3sNp03FBrSVuxpMLQG6gRiiNMW8In8Rug
         LMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781622479; x=1782227279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fqq5dKUgw8U/2JqRQThbBU/bf6oLY395y2woLL4ZjX8=;
        b=dZ2IbFkQmnZM0C/xlctI72Pbczp+fsuOTtrxPLzhpMZU7XuWAljWfjrgqopObf8E/Y
         WVhK1+EEy9DRg8LOGG3/6kq9VAZxye0B4If68ZZLnqLfzSCMTsZ5MBDGA6n7SX69YTWa
         Cy4IGw7ZTgABwoSKrY2A83Bn0fgdAnzpvtHKUtknywQ4dgU9o+k1U55cNUi2trqZUedO
         OuctbPRC/IFUmybCB9bYt5HTWvDMtDFy0z06t46/XEQ6tbQmkO1ScENORmJb9V5Ogkdd
         S34Wot29Ht2Kc20SD5bsLkvxZY0oZA97pmCL0DDXxCJ47AuT5BU5aPBMTD2cSznVCCI7
         4AYg==
X-Forwarded-Encrypted: i=1; AFNElJ/Coo1MZlbjcpoVxttem9EE5r3SaFi0NdKXZW70ij3+e26mJ3ihSd1OHdiOzEeWLa+69EpFyA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx80ng159Nj28bGpoGbwPSu4dcOEVRj84J5UMZAIOT7oNXv6/Fb
	ZHJcfjf5One4UmGa4YGIg2fHBOj0ZeYgTzpQ9aVYm2gxwj6INeD+YoT9oGuKL2Dx7o4Zx3Qcufd
	ofjwmGFLYEzLOohUc+QOnVN11OduQLkIwqJGRiWbK
X-Gm-Gg: Acq92OFuUxq42NgwQvOHPzYt4XBp9+tROEBX410WhN7gu4SvF6eQRb6srXAm0ceaDj/
	eN4HOxllR35q/pe7sBY8pT8JqYeAAu+b53Zit+LKO3yx8q2/AblurxH6ZcQD7uppZNf++ZJMZBw
	ve4ATDy6KerWPUDT4irPuKRu52mRi2VEMFXPzZ90haoZYlz0CBzvO5FXQb3RdY4mIJjPExKRYmo
	S6C6nXJONaK3D4eHKoYAxpwZxUfie/TPYhUFifkql3WVG5i//AEbjdbgpDgTAI9CwsADMbrp+bB
	oCuens8zjcYnKxE=
X-Received: by 2002:a05:622a:8c0e:b0:516:4f62:85e8 with SMTP id
 d75a77b69052e-519a34e7b85mr2617721cf.19.1781622478631; Tue, 16 Jun 2026
 08:07:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260601215909.3958732-1-praan@google.com> <20260601215909.3958732-10-praan@google.com>
 <ajBCazla1VoJX9Ms@google.com> <ajBWGSs6RrkRTcSY@google.com>
In-Reply-To: <ajBWGSs6RrkRTcSY@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Tue, 16 Jun 2026 08:07:44 -0700
X-Gm-Features: AVVi8CfqcSeUYuDAEnTPMC0DtKy0TtaDLxdPPAnI0OHRksFAMPBLMu228VtVFLM
Message-ID: <CAE2F3rCmGS0Q+fZkJXRfStQt0MuoRGE8Nk4PCtvFb5Vj5ZxKEg@mail.gmail.com>
Subject: Re: [PATCH v8 09/12] iommu/arm-smmu-v3: Implement pm_runtime & system
 sleep ops
To: Pranjal Shrivastava <praan@google.com>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev, 
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, Ashish Mhetre <amhetre@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 12:44=E2=80=AFPM Pranjal Shrivastava <praan@google.=
com> wrote:
>
> On Mon, Jun 15, 2026 at 06:20:27PM +0000, Mostafa Saleh wrote:
> > On Mon, Jun 01, 2026 at 09:59:06PM +0000, Pranjal Shrivastava wrote:
> > > Implement pm_runtime and system sleep ops for arm-smmu-v3.

> > > +   /* Clear any flags from the previous life */

I'm wondering if this comment can be improved. You are clearing a very
specific flag, not just any random one. How about "Resume command
queue insertion by clearing STOP_FLAG"?

> > > +   atomic_andnot(CMDQ_PROD_STOP_FLAG, &smmu->cmdq.owner_prod);
> > > +   atomic_andnot(CMDQ_PROD_STOP_FLAG, &smmu->cmdq.q.llq.atomic.prod)=
;
> >
> > Should not that be done from the suspend call?
>
> I'm not sure if I understand? We're just clearing the flag here?
> We set the flag in suspend to close the gate and clear it in resume
> to re-open it. Clearing it at the end of suspend would be wrong as it
> would allow new submissions while the SMMU is off..
