Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A7A45BE3
	for <iommu@lists.linux.dev>; Thu,  5 Mar 2026 03:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772682726; cv=pass; b=DjYWMIZgTrqoy3TARtIztrAeY1ouKqyoFyGEnMKa2IRLmD0PY2FJ9ZjayBT9XBJdeLUfvIXFLIaqAnKnVeYvXrV9ZfYFijdgaxDfY/cQzfAFPT96if4Dkbcp8+07wRzbAaVRUBnJcd0WWFsRBk0TQieY5gesKBJwopz9xKkXLcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772682726; c=relaxed/simple;
	bh=fSMFzKlToje7AHTglujYAfbTU1CEsdNdxVdtm5c4IB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=EJmb3wotrRFzDjzd2ZjVLV2q4gOQW7ILjGSTkTKCN+6hhNgITf56OYmA7BtubzwC1LGeOIQyv/H9Nu4tMN0U61GSc/VoRF5J6lDz/M/4Wew18CAuaQDTNxZAcTT9qIqWrSsD2QTbWQYecHiFPtFNkWTP8s19yEzeFHyqN9lxuvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=OWBAC2w3; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OWBAC2w3"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b934fdced05so1010312566b.3
        for <iommu@lists.linux.dev>; Wed, 04 Mar 2026 19:52:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772682723; cv=none;
        d=google.com; s=arc-20240605;
        b=er/piSXzkfwRygu9sYT/4ppUJxXa+GR0C70aBedSL65EO3QJejHMvQ7sku3ieyBH7l
         Ym9U8yIcd9ar4Hbn5X/Zr/jtHQ8kphRlc++beU/9FmN1FaLqmZ1Rcr2PrsnZc+ltuya7
         alEwdNmSHQqkZiEbCjL9Kgh2I/OjU/NUZaBESL7ajoREwhDamxAhRt7PYpk0xAx2M6DU
         w7uaemxRT2eGzIleuZeoQYfDmcpFV2qQM39/Kslpu0jYjCa/vkY/eX6059AuHTMXshAx
         jBc9qQ3jd28nQse44Mi00Pbq/XcKj9YXG4yMUzTaOh01LKsR8m57wyRNiNh4ihOFUdzb
         5f6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=laQ2AvpCgXuC+R6d2u3IgOfzliLlwjhc9p/ySjCR+uo=;
        fh=sH3LZyMWmwTGfY/avd6bRY5uyaLFVhvWXg8j7hhMRwQ=;
        b=XskWx+knVyLWED3bfqAVFEjNz2NPYb1oCNEa36zlzMu1DuwnVDzWftoMqPrcRPchox
         nTuQJ2e88jr9SvugPSQTj+Uns5MbfhQfsXKjoXAFDeNYmiOwhvKSTtQ3Rx6dYD0wLzyW
         o1ORoLc5sQz/E1/W6qsgHyiztjEVQf3qLX0Xc3ijV6ltOROMecHg0NIb0P2PHVkn8kZf
         EOr+Mhx15y/bK12qw+FG8eEWydFfb04Rm7KMvMOfSf17PAOd/YDy8vgCUczsrAftSG9M
         1Prbd10tYoYL/p7CfPJU5zQpRNTityFO9ev3shmTCORaQwUEGE9P/IdHi2q4SgSlHT1X
         uC5g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1772682723; x=1773287523; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=laQ2AvpCgXuC+R6d2u3IgOfzliLlwjhc9p/ySjCR+uo=;
        b=OWBAC2w3yw0Glk6ETDXXvWfvW1jSWA20TJrs0pb5gWU1FSARykha48IGF13wPSdHmw
         2ndO7+ZsaLXm/GnVGpB8arQe0HCif7/viProZGu36Hz6QF7kz3kCKzC0rQNRgee875c0
         F21Ke/LDveIMKbqlZAov7s5In4y3la3mxgyWQwL2hyOhMb2pdJ2+Hl2BrynfxfdaQL1P
         BJLXUBfedpNvMe3x1Id0gawMu4V+el/QLmnJjXG5WQtzOSGpDDqLqsqsn1XYdTsDERfo
         +xxh+ZnSO7xY31IKNiaeqT4MB+2RV6tu0xTIb4k2kwEaO0jhuazmn072xsxftY1Ah22T
         o7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772682723; x=1773287523;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=laQ2AvpCgXuC+R6d2u3IgOfzliLlwjhc9p/ySjCR+uo=;
        b=qfFK7QYrsVE0f8n3phKqVqMFEcmzXyBPwlM7naRUF7/ZXwaHw8VYN7Z6+hx3q+dmXV
         keOYPjzaDzCFq2wCO4reFx8xiCq6N3ssjAXDpgfYQUHrose/3LMqNKGvWkTIg1ZCZilR
         ACT7V+ARba/Y050s+qZI9KCCs/5QbUGdfkgujWs01iUx8DLD5Wftxjkm5j6gmcCnhxvM
         ztFgl27JaBmfW8+c81jW8oVoydH0AsIG6hLiju9qo1zQwZeI4nJ4XRFSmYHo0vbkFk6D
         Q+A+MNAT3STcYLOMSnTPZe8N6rWF7+DDCv24RXyRodbXJBj5iyUAl4LY0cA5vexWkVNC
         bUdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhr3OydSz3nzsRpuguAenJLGgYhSr12SPeL0VeYZkvJTUxRyuMzTZgjg9v3jgKCH6bpwi6Rw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxEvLkavPss6LpX3RQXKaYdw6NUi0cYqpcO8VjmX650MsSZ0huK
	EHUpwONHp9MawDyYxTeoBzU1TJz6+bgoZpNOMBmMVxib+PiDZmXZASdXbNHu4CYKryY/gckKApn
	JvMFXHJFp4uTYz1CyzJwxrmIE6/Ddw8xd9QxhF4jQPw==
X-Gm-Gg: ATEYQzwdklxq0iUe1YdHMWWM07VZoJlZSHN/48AED9QEl0lm14Gg7MJRR87eQt6o6W+
	JOId8Iz0B4at8rOvWm4JjOVuzlQjkHD4ZkfZrmz92yFmEoxYjQCKbxkkpXC/pKzo4Df9OTaVAMe
	APYo38NhfrQGZ1jeHxIKVvexu4S4IbSU1jAUshh303knZf78GR0ZbTMv8Zxl0Ioj0+Mr/QHycOc
	emOeWyf1MLuVwNrBEbD68c6aM1lnfqzGSoxlrQnRynpN+yerybxNIau5/lHKr7cyiW/LJb1A13X
	QdVRJa2HHA==
X-Received: by 2002:a17:906:f59f:b0:b93:c5a9:a5f4 with SMTP id
 a640c23a62f3a-b93f1171a50mr230933866b.9.1772682723178; Wed, 04 Mar 2026
 19:52:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260208063848.3547817-1-zong.li@sifive.com>
In-Reply-To: <20260208063848.3547817-1-zong.li@sifive.com>
From: Zong Li <zong.li@sifive.com>
Date: Thu, 5 Mar 2026 11:51:54 +0800
X-Gm-Features: AaiRm52-PEQgHfjyPwhUeK2thl3vuXWbRxSFi-k5ctXKrtEiXxfPbnakyP7RYIc
Message-ID: <CANXhq0rLQYL3hVhirV09nQKjnFy2wR+TFr5E=_YMQJPYU25QkQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] RISC-V IOMMU HPM support
To: tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, robh@kernel.org, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, mark.rutland@arm.com, 
	conor+dt@kernel.org, guoyaxing@bosc.ac.cn, luxu.kernel@bytedance.com, 
	lv.zheng@linux.spacemit.com, andrew.jones@oss.qualcomm.com, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	Jingyu Li <joey.li@spacemit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 8, 2026 at 2:38=E2=80=AFPM Zong Li <zong.li@sifive.com> wrote:
>
> This series implements support for the RISC-V IOMMU hardware performance
> monitor.
>
> The RISC-V IOMMU PMU driver is implemented as an auxiliary device driver
> created by the parent RISC-V IOMMU driver. The child driver can obtain
> resources and information from the parent device, such as the MMIO base
> address and IRQ number.
>
> Custom event support is not included in this series and will be submitted
> as a separate series. The idea is that custom events will be defined
> through the driver data of the auxiliary driver. When the parent IOMMU
> driver creates the auxiliary device, it should pass a vendor-specific
> name as the device name in order to match the corresponding auxiliary
> device ID.
>
> After my initial RFC and the v1 patch series were posted, similar patch
> series also appeared on the mailing list.
>
> One was from Yaxing Guo:
> https://lore.kernel.org/all/20250915020911.1313-1-guoyaxing@bosc.ac.cn/
>
> and another from Lv Zheng:
> https://lore.kernel.org/all/30C7AD351DB55276+a8b03dac-c5af-4034-8631-ac1c=
352a469f@linux.spacemit.com/
>
> Yaxing has agreed to pause his series, as discussed here:
> https://lore.kernel.org/linux-iommu/2ce9d8be-10b3-48dd-b99e-7358347fc171@=
bosc.ac.cn/
>
> The motivation for sending this v2 version is not only to address the
> feedback and suggestions from the previous round, but also to introduce
> a major structural change: the PMU driver has been moved under
> drivers/perf/, which has been mentioned repeatedly by several people.
> This results in a different driver structure compared to my earlier
> version and the other two series, and I'd like to gather feedback and
> suggestions from the community on this approach. If the community would
> prefer to go with Lv Zheng=E2=80=99s version instead, I am perfectly fine=
 with
> that as well.
>
> Since I did not follow up closely on the patches from Lv Zheng, Jingyu
> Li, or Yaxing, it is possible that this v2 series may miss some important
> features or fixes from their work. Therefore, I would really appreciate
> it if everyone could help review this v2 series and point out any
> additional fixes or feature support that I may have missed.
>

Hi Robin,

This is the next version of the previous series. It seems to me that
this v2 version addresses all the suggestions you mentioned in the
previous series.
https://lore.kernel.org/lkml/20250115030306.29735-1-zong.li@sifive.com/

I talked with Lv Zheng, we'd like to know if this version looks good
to you, or if there is anything else that could be improved?

Thanks.

> Changed in v1:
> - Rebased onto v6.19-rc8
> - Pick all suggestions and feedbacks from v1 series
> - Add cpu hotplug implementation to avoid race enablement
> - Move PMU-related definition from header to c file
> - Change PMU driver to auxiliary device driver
>
> Changed in RFC:
> - Rebase onto v6.13-rc7
> - Clear interrupt pending before handling interrupt
> - Fix the counter value issue caused by OF bit in the cycle counter.
> - Invoke riscv_iommu_hpm_disable() instead of riscv_iommu_pmu_uninit()
>   in riscv_iommu_remove()
>
> Zong Li (2):
>   drivers/perf: riscv-iommu: add risc-v iommu pmu driver
>   iommu/riscv: create a auxiliary device for HPM
>
>  drivers/iommu/riscv/iommu-bits.h |  61 ---
>  drivers/iommu/riscv/iommu.c      |  20 +
>  drivers/perf/Kconfig             |  12 +
>  drivers/perf/Makefile            |   1 +
>  drivers/perf/riscv_iommu_pmu.c   | 661 +++++++++++++++++++++++++++++++
>  5 files changed, 694 insertions(+), 61 deletions(-)
>  create mode 100644 drivers/perf/riscv_iommu_pmu.c
>
> --
> 2.43.7
>
