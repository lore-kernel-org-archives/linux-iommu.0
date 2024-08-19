Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958CE13B2AF
	for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 18:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724092036; cv=none; b=gwjujt+kK/eCpEg57cN2Y+/v0d41fF8Jnvj/7xKdhS8kZHUVjtxutGCF/LnQEa9dSikfTihV5w0Zyy/AuCvwosAjOiElOujv3+RxglBQhpR4qLyLOgs2/h0b9E4LQTtkjP37CBhhz0R42K+7viol3DT9VmFxqBaQybWUwmcCClQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724092036; c=relaxed/simple;
	bh=/tUMaP2vWhujMAMBYU8n0tCigYkSaq/Ngcst40mzvvw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=SJ/czWoVqTTUYQ6SlM40WXVJtcQCaTtNeMaMAW5+xNXO8GwyJ+luwTbq3ae9Y7ovIMllVvJO57+V7pApkDX+XiLk99Km/H1UVHn3GKpQJaubUbe3Csv9EKRbro1h5S3tRDCVAcbbZVLP1biYb5pJFCjZjGjyLtB1B8d3pbbb/Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com; spf=pass smtp.mailfrom=jrtc27.com; dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b=OwIkYN/q; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jrtc27.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b="OwIkYN/q"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37198a6da58so2508187f8f.0
        for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 11:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1724092033; x=1724696833; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKLGgkdxGjwvH7vrkOjUsYvXYfsjWp5LV2FLkOtp4XA=;
        b=OwIkYN/qAHFXuFbi41WRC2IvrsOOgLg9T7q5uWXhjb+cZ9HTmb3NARzqKZhF6Urnl5
         MEEb9MvrbZauK2zAIHNaGNokGUfLvtuktKpz0HYx6L/GrNq5cdSn4PNNzgUSneU6/RcT
         7JO6+/E7AR6wXBa8rjdirzgITeWPkqQE6aKleHASvs1o2GDt/o+DooZ2fYDHkCdlJE1G
         tL0fW/uYtJleKzQrsVl6ZTlwSPwtYLDI8KoXOMHP3OdgCoW0Z0VFtIpi1Pq7C78trun1
         NWFWssaiABYsHUdZK8cmFf9S3c9t/H0EW6WyCPDrhBBabFvfEBtuyNr1CLH6aXgRKsuS
         yeUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724092033; x=1724696833;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BKLGgkdxGjwvH7vrkOjUsYvXYfsjWp5LV2FLkOtp4XA=;
        b=FnjMKJdJ8GAedYUnmhU7vMFQkLe+9WgV6QhlzElbkbMEiNoy+TA13ozCfjOmUSaNof
         KE/Y+iZPIZatxCnkQ7ZTdG1O1DaeF2joXgS8eG0JfaY3UWRT4Z9drKUPvR+ZEbMSctqR
         3Cn+HPszXydRZz9Tc/GNylaTiEXsbmtJx6sxf7lrMvX39Ls+To0SbU3NPoAii8R4ANzG
         ed3A6WqPwD9E6yx3XOD/18+0ZiGiaRNtzVjXLwAvKopcp8xy/ikfVwDIia/JC4As/rKG
         4LSukG+H578jTwhxmH/IjQTnqKUUQCH6QswXoQfoXuOgbPzZQlVQiQQg67/K8VkIsMIT
         LJ/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXZPSv4HHYrp6CRrIMwY6tpx8bZU/c/Besm7FScbpPNKGweVJiUOfNGJY/XMqVPvyGMHMamBDGGHWGjsmD6LRKqty9I87M=
X-Gm-Message-State: AOJu0YzbVX4N4WsegAOapK6OlTMnIoZs/srpOBoaLvD9+5SgufM6wuwB
	HupOGaTIHJBRp+RnSQHvmG5RtmaPs+GvfWOhlbvcgRliI/NDi3qleQCw2p2Ujp8=
X-Google-Smtp-Source: AGHT+IEZO0hM/Eo4qjWitYGYD8gtI1mX/YSCbBZ3xcT3qyrw3QTuw78EQsEo1zsD6MJr9+sfqGczMg==
X-Received: by 2002:adf:a317:0:b0:366:efbd:8aa3 with SMTP id ffacd0b85a97d-3719431575fmr8913958f8f.2.1724092032510;
        Mon, 19 Aug 2024 11:27:12 -0700 (PDT)
Received: from smtpclient.apple ([131.111.5.201])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898aab44sm11152375f8f.91.2024.08.19.11.27.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2024 11:27:11 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [External] Some feedbacks on RISC-V IOMMU driver
From: Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <CAPYmKFs7ZyHyKo8uULvYp3YK8ABOJo8+FWDG_cr2YU_cXgfRww@mail.gmail.com>
Date: Mon, 19 Aug 2024 19:27:01 +0100
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>,
 Anup Patel <apatel@ventanamicro.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 linux@rivosinc.com,
 Will Deacon <will@kernel.org>,
 joro@8bytes.org,
 LKML <linux-kernel@vger.kernel.org>,
 Yongji Xie <xieyongji@bytedance.com>,
 iommu@lists.linux.dev,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 wangqian.rd@bytedance.com,
 linux-riscv <linux-riscv@lists.infradead.org>,
 robin.murphy@arm.com,
 Hangjing Li <lihangjing@bytedance.com>,
 baolu.lu@linux.intel.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <A75E5C30-F062-43A3-A9AF-BB205632C7EC@jrtc27.com>
References: <CAPYmKFsTcurrUiWqM8cFj+GgqfRiaLqPDGOTSE+RLyKJGSKE2g@mail.gmail.com>
 <B0C91D33-8C1C-4C67-B9B4-41206EFD8ECF@jrtc27.com>
 <CAPYmKFs7ZyHyKo8uULvYp3YK8ABOJo8+FWDG_cr2YU_cXgfRww@mail.gmail.com>
To: Xu Lu <luxu.kernel@bytedance.com>
X-Mailer: Apple Mail (2.3776.700.51)

On 19 Aug 2024, at 08:49, Xu Lu <luxu.kernel@bytedance.com> wrote:
>=20
> Hi Jessica,
>=20
> On Mon, Aug 19, 2024 at 1:17=E2=80=AFPM Jessica Clarke =
<jrtc27@jrtc27.com> wrote:
>>=20
>> On 19 Aug 2024, at 04:56, Xu Lu <luxu.kernel@bytedance.com> wrote:
>>>=20
>>> Hi Tomasz,
>>>=20
>>> Thanks for your brilliant job on RISC-V IOMMU driver. It helps us a
>>> lot for what we are doing. Below is our feedback on the existing
>>> implementation[1].
>>>=20
>>> 1) Some IOMMU HW may only support 32-bit granularity access on its
>>> control registers (even when the register is 8 byte length). Maybe =
it
>>> is better to provide a 32-bit access method for 8 byte length
>>> registers like what opensbi does on ACLINT MTIME register.
>>=20
>> That OpenSBI has to access MTIME piecewise is a workaround for a =
vendor
>> not implementing what the spec clearly intended, even if it wasn=E2=80=99=
t
>> explicitly stated (but is now, in response to that). Repeating that
>> situation would be a pitiful mistake.
>>=20
>> The current IOMMU spec draft very clearly states:
>>=20
>>  "Registers that are 64-bit wide may be accessed using either a =
32-bit
>>   or a 64-bit access.=E2=80=9D
>>=20
>=20
> The spec's description about this is pretty confusing.
> "The 8 byte IOMMU registers are defined in such a way that software
> can perform two individual 4 byte accesses, or hardware can perform
> two independent 4 byte transactions resulting from an 8 byte access."
> It seems that there is no requirement to implement 8-byte access.
> It's OK then if we think this is not a problem.

I agree that part is poorly worded. The part I quoted (from Software
guidelines) is clear on the matter though. My interpretation of the
part you quoted is that the spec has been written such that software
can choose to break 8-byte accesses into two 4-byte ones and things
will work, but if it doesn=E2=80=99t (which is a valid driver =
implementation),
hardware can also do so should it not want to support an 8-byte
interface (e.g. you have a 4-byte I/O bus).

Jess

>> Jess
>>=20
>>> 2) In the IOMMU fault queue handling procedure, I wonder whether it =
is
>>> better to clear the fqmf/fqof bit first, and then clear the ipsr.fip
>>> bit. Otherwise the ipsr.fip can not be cleared and a redundant
>>> interrupt will be signaled.
>=20
> By the way, it seems the irq handler must clear ipsr.fip first to
> avoid missing out some faults no matter whether a redundant irq will
> be generated.
>=20
> If ipsr.fiq pending via fqof/fqmf is implemented as edge triggering,
> then ipsr.fiq can be cleared at first. In this case we can not clear
> ipsr.fip again after clearing fqof/fqmf bit, as it indicates a new
> fault to be handled.
>=20
> If ipsr.fiq pending via fqof/fqmf is implemented as level triggering,
> then ipsr.fiq can not be cleared at first and a redundant irq will be
> generated after this handler's return. But it is OK as no fault will
> be missed. Otherwise it is hard to detect whether the ipsr.fiq is an
> old one or a new one.
>=20
> Please correct me if I have any misunderstanding. Looking forward to
> the subsequent code.
>=20
> Best regards!
>=20
>>>=20
>>> Best regards!
>>> Xu Lu
>>>=20
>>> [1] =
https://lore.kernel.org/all/cover.1718388908.git.tjeznach@rivosinc.com/
>>>=20
>>> _______________________________________________
>>> linux-riscv mailing list
>>> linux-riscv@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-riscv


