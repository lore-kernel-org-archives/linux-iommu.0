Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534E92941A
	for <iommu@lists.linux.dev>; Fri,  7 Aug 2026 18:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786126907; cv=pass; b=oEjW5ZDE7OVMQRLcOZ022PflaeMXvI1my5pEIXm9J6vJ893mRLYimhRdeJCyf48/n0OM998ugJTaIsLhnQzGzZB5MTiY4fPX0/WqQOKzmhLD5pWJE8775wDMJj4JdZkhT1HXi7FTAm/61/LxUudG03U5Mo2xD6PPjUuG7a7UCP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786126907; c=relaxed/simple;
	bh=DFiX/7Q48wo6L4d7tIX2yPIwJYCBwS0h6wyv/X0iH4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hTNqcQGBicqH0i28aPfI9T57aJr1UPczbfWhwoUMVX5rhp9+xJvMxZSwE/r3dLitNXizKtY5rOIOTMvvHAqmFmKg8q+iT9iOS6I9CGEmEp7ADEbYQp5X1lRe/UfikldPaJzSCV828p1VCE0Cqu2i3lpl8ICWmaLBuD4BdNK0NWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V34urBnb; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V34urBnb"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c10ed63c0so29361cf.1
        for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 11:21:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786126904; cv=none;
        d=google.com; s=arc-20260327;
        b=hrnj4IoJu8pE1cu495Jqo+bnfnyLRf1iXYcadU3XjRQ5wfTxk/dgW83jfBmESmZYOe
         pUGq2rQxcEMGKU63f13xi37lYNSk5qIv0qjZ4v025zjTZkqjj7jSHH6LV0O5ng2lNltR
         xLirRe2pZqUSpXAHW9bSEqfFknA5Wn5gLXQRGUmHtVswTUwaqrl/vJKIfeNUWyKKLPeZ
         KcWekm6Babh/O0LMgFXzr6ZA+jNC/wjODjdwFtNxluBuFfhLGCUoKiKe8C9xM86ogzFX
         paG7x9kVXVizG6ofFDGfYnhKfDVCH+WHHR/cYCAu6ZBpwh69xc6xJ+7fXQ48beGkOtf8
         D4Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DFiX/7Q48wo6L4d7tIX2yPIwJYCBwS0h6wyv/X0iH4c=;
        fh=mcbJXME297F/5Y3AP1IEK1gn4Z5nCL+IXbxv70r+FBY=;
        b=E6r3Xmw5WX7mUfd0l49o2E8b485Cgyxr7Yw0p+C36ZJ6JEiDIcGwfo1bYtFxQArO38
         gNB431aXeJy74CFi+SweodotkEhrNTkCE4H/o47aPzAqQXssinQ/L+35pIyCgja/q6LC
         KR2GnsN5hVOLz9gbKdj85v8QJKlq9hdzPoIogRN2pvtdsYs5YJ90yMJbv2tQOZcr/QtG
         dDzQ5X7JN4M1tTWhLlLiGVwYYg+vDovqqc+p+Td0Ta94xImNyrK//3QneXezTH/hLXy5
         tPuUNLBZ+K6NEjicIxAnQYRfaWmnewtEwjUtcPV4FYLZElp7zt8T8jgaDDaVNrZhPG74
         aspg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786126904; x=1786731704; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DFiX/7Q48wo6L4d7tIX2yPIwJYCBwS0h6wyv/X0iH4c=;
        b=V34urBnbNe49kw5wDRKDTDslRYD7gnHZ6414kmUuWxGZr4ECmdiDIPeMWPZJR/RH/l
         G+bfI7/FYSYZGiaVRMQPN47B7U9VclH0Q86DO28qgHoKwXpMir4v6KD5zAIQdw6CqSHx
         TLehC8DDUEghr/UaE/9LyVphDln3ZgVLycQbARq664vu5WgrbRRhVzrQles8DJTG2i7n
         F4G89e6P8psu4duOcdgC89oaqMLjkOZmEujEqtSBmJN5GUiBSNweXs3YIjGJKRU8zqMJ
         Uw5QAFN9zljJCB+Kf9/TXuxqHXaUKhjPtPqbSKGbz6c8TYgZkfDRl/i3ZTA8UDwFWmFw
         k+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786126904; x=1786731704;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DFiX/7Q48wo6L4d7tIX2yPIwJYCBwS0h6wyv/X0iH4c=;
        b=Pm4mSKQDnop5y9ligx4QgJynEHc/KdiISmuSKI6e8JPIKCFdyzFz65zsTJjErdgk9H
         SRzokvVfZNJebmCvhW4eDrLUi4zjFPG2avtkhPxkHX8X5BNZzZHfpDJplJJrViMelggH
         fbBQQmEdzAccjfP8Rq4G4pdKe2cAaBpzTFwJTtUqYlODq/FNkBwYZZQxZWEtm/IHjdq2
         phYBHS7sdaCamnyui+S1Z+Ds1wD5d3+BQ9J0FAickeJe4jX3dc4AVFw9X2yCV1a7FNUp
         RTBrqm1NHeWcZ4klNe6Aol3CX3d7khfYOp/f5t31UqyYgtkiUL4jl1LLd4sAT8vuwpn4
         CLKQ==
X-Forwarded-Encrypted: i=1; AHgh+RpPZ4kv+Qt0dQ0BsJ24E7s1m5g10dDCaCsVgmFUUfwDuLiPiXtY578gu4X0FyW7RaWllc86lw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxcf58FsCw7vA/CPYf7p18cj0Rlwvok30kZWkrjt4TkClwZox58
	BVcHxGuQdJbNmrroJ8mhCjCWueOUL2sKCilHSbXjF0lkpsqIWWP+k6hFMsR91csgmrn9vY+p7Db
	n/1fGwb3N3pEoSSy/3jw05eMG9faPM8Tp33NtdyTU
X-Gm-Gg: AR+sD13zqg+oVZ5QcCBSAv5kGfkmUzMlzXUnVdEEbewTpMXpdZxTcJIeO4W9TBm4jGU
	SUeuhwJwkvm1kkCPN0Uw6bMI6RJIDBqqEIz4Ieb3q4Qdk3R1OhgD71QWDUBkEeOFW2/BhL0QjG8
	oeX/4BACBjVHcpi/SMsi/uqbxBmwHQZzSJbVQIUhdH2CR25lGpxZockvSHcWGJwJGwhAr0BhsXl
	Z0zCBtxIDV4PFuI/L6oFkcuIEl/PKd5rXlGYbNEzq97nISLCfINClWMAVBg2n7saK+hb/pXr0/n
	93v+zKNOE803NPIploMvIqJP6mURgqKrgti8FD6c3Q==
X-Received: by 2002:a05:622a:1b90:b0:50f:b69a:f4a8 with SMTP id
 d75a77b69052e-52d23e4c482mr1477201cf.7.1786126903631; Fri, 07 Aug 2026
 11:21:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260724-arm-smmu-v3-instcfg-override-v1-0-e7acf4a8a525@linaro.org>
 <amYIuhYenP4-qHyV@willie-the-truck> <0b7c0272-5506-4aee-82b3-76a78f2b39dc@arm.com>
 <CADrjBPqZFDvyLFpDy1YP9qrMNUCtZYtJhiaDd0iTnmB4ZYO8GQ@mail.gmail.com>
In-Reply-To: <CADrjBPqZFDvyLFpDy1YP9qrMNUCtZYtJhiaDd0iTnmB4ZYO8GQ@mail.gmail.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Fri, 7 Aug 2026 11:21:32 -0700
X-Gm-Features: AUfX_mwDnipayqqhz_vuvH-F5cw1FS42rqk5A6i8RcOd5oIHDgvQ1fDjMyBedVI
Message-ID: <CAE2F3rAHM2oTVM03ud0SQH2mjVXGU7Ns3gfc_YT4sTomNLjb_w@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add arm-smmu-v3 support for instcfg data override feature
To: Peter Griffin <peter.griffin@linaro.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Pranjal Shrivastava <praan@google.com>, Mostafa Saleh <smostafa@google.com>, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, tudor.ambarus@linaro.org, andre.draszik@linaro.org, 
	willmcvicker@google.com, jyescas@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 8:25=E2=80=AFAM Peter Griffin <peter.griffin@linaro.=
org> wrote:
>
> Hi Will & Robin,
>
> Thank you both for your review feedback.
>
> On Mon, 27 Jul 2026 at 11:53, Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > On 26/07/2026 2:16 pm, Will Deacon wrote:
> > > On Fri, Jul 24, 2026 at 01:39:41PM +0100, Peter Griffin wrote:
> > >> These two patches add support for a new "arm,instdata-override" DT p=
roperty
> > >> that enables the override of the instruction/data attribute of incom=
ing
> > >> traffic to Data by setting the INSTCFG override bits.
> > >>
> > >> It is intended to be specified when the smmu can't guarantee that th=
ese
> > >> attributes are provided correctly from the client device.
> > >
> > > This is going to need an in-tree user and a much more detailed
> > > description of what is being worked around before we consider this fo=
r
> > > inclusion.
>
> Regarding an in-tree user, I haven't sent the Device Tree (DT) patch
> yet for Laguna SoC which adds the smmu nodes and this property because
> 1) I want to land the initial SoC/board DT first
> 2) I want agreement on the DT property name. Currently I used
> "arm,instdata-override" which is what downstream used. However, since
> this is intended to work around silicon errata something like
> "google,lga-instcfg-data-override" might be more appropriate?
>
> For Laguna SoC the first in-tree user of this is the amb_smmu smmu
> instance which is used by the Synopsis dwc3 IP. The Laguna dwc3 glue
> driver is already upstream at drivers/usb/dwc3/dwc3-google.c
>
> > >
> > > In particular, if a particular client is emitting data reads as
> > > instructions, then a better work around would be to avoid mapping its
> > > domains using IOMMU_NOEXEC. But I can't tell what's going on from the
> > > limited description provided here.
> >
> > Unless it's also emitting the privileged bit and thus falling foul of
> > the implicit Unpriv-W -> Priv-XN rule, but then we also have the means
> > to deal with devices which actually do that themselves (hello pl330...)=
,
> > so that would seemingly only leave the case of some innocent piece of
> > AMBA-interfaced IP which doesn't expect to need special attributes, but
> > the system integrator has gone out of their way to tie the AxPROT bits
> > to some wacky value, which I would put in "erratum workaround" territor=
y.
> >
>
> You're correct Robin. It is an erratum workaround for the Laguna SoC
> due to some custom usage of the AxPROT bits which differs from the
> standard ARM SMMU handling for Privileged/Unprivileged and
> Instruction/Data transaction attributes. The effect is all
> transactions appear to the SMMU as "Privileged Instruction" accesses.
> The software workaround in this series enables the SMMU's INSTCFG
> override feature to ignore the incoming value and treat all SMMU
> transactions as "Data".

Due to the specific integration of the MMU-700 in this system,
AxPROT[2] is always 1 on all TBU subordinate interfaces, regardless of
whether the transaction is an instruction or data transaction.
Consequently, client devices have no control over AxPROT[2] on the
input side of SMMU. AxPROT[0] (privileged vs. unprivileged) remains
unaffected. As Robin suggested, the override is required to avoid
inadvertently triggering F_PERMISSION faults due to the VMSAv8-64
requirement that EL0-writable regions are treated as Privileged
Execute-Never (PXN)

Drivers are already avoiding IOMMU_NOEXEC. I prefer handling this via
the SMMU configuration rather than patching individual client drivers,
as this is an integration issue, not a client device issue.
