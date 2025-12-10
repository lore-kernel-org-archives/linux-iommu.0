Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3962323BCFF
	for <iommu@lists.linux.dev>; Wed, 10 Dec 2025 07:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765350758; cv=none; b=AYhv2fheySC9FommTSFtTN4XhrYbuZw6vbdiUeN9sRLHfqHr89yMJlmbjZkq6dqfeYgOw8vt/cJmU9/nxbzTmEFPgq9q5o1ectQCtbQw0muzXfBkZHdeJj5urfYFJlmYe/hkBNDDwQL96NWsKSXWmHGhC+gId0JEOGjdQA/ZLRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765350758; c=relaxed/simple;
	bh=mRZaxBGAJWcReD3YHX8AkcmR18B5zBad71ba/qD02bY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g8C3kCk9gUE3XCi9T56+NkelE9QoxhfeyKdOFy3HIiJ83OBoWkCKZUY3+3hEiHNS0/jYYPoJvCnfvvywz/MZq+kkg1l+aQFgNtQHQdzIi+B0bIUPW1np9jkz/uC3g64D62TzjmXjqRAh9wcZ3rvk3pPnlFq2X/l9UV3DRQzJYvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=OzZ2Frb2; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OzZ2Frb2"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-640e9f5951aso960813a12.1
        for <iommu@lists.linux.dev>; Tue, 09 Dec 2025 23:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1765350754; x=1765955554; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRZaxBGAJWcReD3YHX8AkcmR18B5zBad71ba/qD02bY=;
        b=OzZ2Frb2wlsKh4G7UJDJDm5A7FmmnRYLGspCiD76hRMDgrqe3idaex0jU+X44G8CPd
         p6HxFfivzVNSTc61sHSeGf8/ed6yWnCjfnIGG30deEQ9YXKl0xlSlVhOtHQSZaLlTlxd
         SyoWHl20pjepIO9uiBCgggo8HmZ0kc6x0dhD+1uKU5qBFWTdyM6MXw75P7uOUxjC/wtq
         rZ19+/PWFnKZW/I/XtrVpon9YShycuUmgpgAFXiCp979w1hk9yr6lTHL5DttjupzLGTa
         y9vaMiNvF3yqGT5lJUSVkF9pj0RfvUANaj7bUmj2AwLdv/0kbZQ59WLcmgEpobynBA0R
         rL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765350754; x=1765955554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mRZaxBGAJWcReD3YHX8AkcmR18B5zBad71ba/qD02bY=;
        b=Xf1+VJiJh2synp5oVfbCO+4dpEIm0fSJIEh7Inl/ktRKehJEFicD2aeKjLW05qevsk
         vkAjUg9GgGqZRHrij/XiNiITwTDnfBretnJRzoxGppYnpeT5gYPmUFqIM66hhZHRD3FU
         iLvGHlQtsJbLdLLpLELxV2RtMSG21iXzOZG8T40foM5uHXHQIHdR0YYyBRPTjMS2C38B
         hhd3pO2gqEeaKmOXcSaEVHkoHpfWmiCLtDeYgCUy9nhYH7kob6rhBSD133+EPniffSO1
         7PXoNPpeBmQWpIK9OkLwRhdPan3YzQy0W0qx/9EViLl29aMTvleuDrU4AEr6mR7ncd24
         4ijA==
X-Forwarded-Encrypted: i=1; AJvYcCWp0fA9yy4TUEBV2aB5xXyjm0/EfsCx4SALIwjLz+GS9lizjebBuFJuLydLPssWfk8Jq9//kg==@lists.linux.dev
X-Gm-Message-State: AOJu0YztCwSebvVANu3ww0asbw79isrQ2fHus1vq7qI7ag+ph22nfk7X
	eykXhpSEFFwIE5wh1fM78LhRhzQPXoh1NniK8NZiwOvKhPI9qg4pDVT/K3J0to0xDuAb8/qhLg8
	yX13IcAbOT3aILa7dk2j7d0u/nB2I7+jHnRCrDss6HA==
X-Gm-Gg: AY/fxX7EAhKM3yec3PszXGzrADsdiGOz06R5EyMcZ3twEL8mTgNj4NN5D1sied8kFTz
	6zDJ2oM+fYgAdz72/G79VEdi19NTcDGkXK30EdvRlJfrznPdjxhNMcOqwkhV3Hs4xNiJYKJ7/FO
	8i98SpUnkxFbCaZhLjvZohDLAizCtdq8/tVfMz4KhXPPDm3QMc7bscFn8BfMH5Gvkmn8xNTnqlO
	0bosnqaA0YV2GpfFIFVkoEklJMaPBgqqSu8KV4+m7+7JxR/PvkeEVEjnJcXls6k+m+bWOqc1n23
	cKwmoLHh
X-Google-Smtp-Source: AGHT+IE638New4MgR+fdHjtzv1v+bv2HepxoEy8lZmhUN9l3lRlFgm2ujvBWOkK+UHVIcdLbpWKJrYIdlRvuQyDMXfU=
X-Received: by 2002:a05:6402:318e:b0:643:eae:b1b6 with SMTP id
 4fb4d7f45d1cf-64963fcd298mr2821476a12.12.1765350754531; Tue, 09 Dec 2025
 23:12:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAPYmKFt8bu48mi0awW7XWCiQvQqKf0VzcJbx5VR0VmcT0zYZ4Q@mail.gmail.com>
In-Reply-To: <CAPYmKFt8bu48mi0awW7XWCiQvQqKf0VzcJbx5VR0VmcT0zYZ4Q@mail.gmail.com>
From: Zong Li <zong.li@sifive.com>
Date: Wed, 10 Dec 2025 15:12:22 +0800
X-Gm-Features: AQt7F2qapH90QrmLD5cwo3YEDcVfcnFTF_GfEDCm7yLkGsvnAEOXzKZjthDpqGQ
Message-ID: <CANXhq0qeQmDP59J3_j4H1ei3CFqofx0m6vUcX1mL3Y+it6+FXQ@mail.gmail.com>
Subject: Re: About RISC-V IOMMU PMU
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: guoyaxing@bosc.ac.cn, iommu@lists.linux.dev, 
	Tomasz Jeznach <tjeznach@rivosinc.com>, joro@8bytes.org, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, anxu@bosc.ac.cn, wangran@bosc.ac.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 11:23=E2=80=AFAM Xu Lu <luxu.kernel@bytedance.com> =
wrote:
>
> Hi Yaxing and Zong Li,
>
> I noticed that Yaxing has sent a patch series about RISC-V IOMMU
> PMU[1]. The same driver has an earlier patch series[2] from Zong Li. I
> am wondering if Zong Li still plans to update his patch?
>
> [1] https://lore.kernel.org/all/20250915020911.1313-1-guoyaxing@bosc.ac.c=
n/
> [2] https://lore.kernel.org/all/20250115030306.29735-2-zong.li@sifive.com=
/
>
> Best regards,
> Xu Lu

Hi Xu,
Thanks for bringing us here. It seems to me that Yaxing=E2=80=99s
implementation is similar to my previous version. I=E2=80=99m currently
working on the next version to incorporate the feedback from my
earlier series, and decouple the IOMMU perf driver from the IOMMU
driver, and make it easier to add custom events. If Yaxing doesn=E2=80=99t
mind, I=E2=80=99ll send it out later.

Hi Yaxing,
Please let me know if it is ok for you. Thanks
