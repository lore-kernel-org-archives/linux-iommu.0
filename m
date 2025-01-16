Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC50142E7C
	for <iommu@lists.linux.dev>; Thu, 16 Jan 2025 10:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737022984; cv=none; b=oHQXr/wVqTpw7OdZ5G3bh0kJERG8bGTvpLBD1AxeCA07ehSHc+1QscaDOkF74XlvkxbyofdQPd4uWOYOpxDiqzIr/+Ob3PBjhsfXFgBOltCAWGOzSlIMKJr3lmUJjs3mwR433fngxeHQBfo0SpZGBpdAK1fMj0EzTSAZ1fklYQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737022984; c=relaxed/simple;
	bh=JG8h+uCoDb0V0P9xECJMNPDq9Qp3ydXL1LWFsz986So=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=nIqhLRcgPdrS5neNUjdsQKyAbkMRucz2LO+CR43u7is3AS5JM2Gw/tGl8MMHkPSwLkP6jftzSJceaRwtE4ZY64BLAMXYMrrVfsR3boLjsZEoonDe9SrKaoZiqHkqX5ZFmdT0vsITNE12o+qCy7zS0dG5hXAa6YGA0Eig/wAjYUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=VypJgJuj; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="VypJgJuj"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-387897fae5dso36505f8f.2
        for <iommu@lists.linux.dev>; Thu, 16 Jan 2025 02:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1737022981; x=1737627781; darn=lists.linux.dev;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ZkvdDnyLVGp1IEy4txVMz8RNqPNLFiF+bNPBLcxx30=;
        b=VypJgJujrMcimKNQyYlgX8mpkst0++qzWB8p3VWADucLHPvoCNEcwjQcmATbFTkayH
         o+XEfJA73w/g8kCnfshx+Kos6q9S62ySPhF4zD8SrjNPdY0L3WKWxV4ZiArNKnPmcYQJ
         1ENhjuieKs97BkDyBJAu4/5pr92Urm8ncILBZdHFj5WSHq5ccTV/Lvl73oO2w42ZZTl2
         8LEFhhmHYtmGlgRrCEUcEZPppcCchbQSbWwO7ATKGLPO7tTuTvHIlGR/lWkQWD2Favrn
         XAJEIUhXfkJqSil+9snaOu4bdFQMO2TzS06+mH47dNSqsBiSR8I1Yld8i0BRmQPIHBIR
         U2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737022981; x=1737627781;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8ZkvdDnyLVGp1IEy4txVMz8RNqPNLFiF+bNPBLcxx30=;
        b=COGDUtsM/IK//LFx/l44byVciTTJOxW1F9CjRmYQfrftxAapZ96a4LHdI9/mhlBUM9
         7FeFX0ZbZBjaCehcbiqsOYDz8ySXrHd9WhqoVKQ7sWZdIM9gWddFEWYS3iOaLtHhJoxd
         15myH4ysbipraIaQ3wQWN0/XuHoFOvw48YRsBjCSzmpUwDB4XVWKlBipRrum5Gl8AxBn
         CtSi4yv9oSEuYF4Gk3thnr6LOqnv2vJziS5GvaVeQ8qiG1HwjNvYtKPORgMi9b/5DUPE
         wstYojaUMbKX1RL6DNxVyQhVxk0oBmv+6cgD6dASofUDBekjKKVWfcLvkeyeiRmwKibA
         W7Uw==
X-Forwarded-Encrypted: i=1; AJvYcCUVxW6WxoVSsZaQxMbMOD3Wx85J8rti3lsWaaDjWwjnQz0Ey8ndjZj+wqLGUj6a0VHtuur3lA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQK7CY4qwPvq0RwXLckB9l+axj4YuO3JIxksukDpgUz1429sZH
	aExFgV+xL1wTaWwT6RDfGNdIafJkxKlkAY96VDAmGtQu7bOz5vPgmdkgfSUTWio=
X-Gm-Gg: ASbGncsgMZBuhhkfzQ7paDd6aS7lD69uaDcgiPEi4JOnTAkKaNoKCT0djEhQyEIaN2/
	OrMvT16qC1sgTR72HB6ZJMhThzWCEi0ivll4reEuFK+lExuxqQMnB0xl/hf4aH3GiUMRRfIp9se
	XHzY6MGjNRbO9BwaWjsjQh1oUEVR+/6G9gjq4zTCOqcbfOyNy29KG0/fqJ1uYdMXYMhJe7RSqLh
	zBSXGTbJ6tU9PrhAfj2UJxvSvtumPDsviD2bamb/xNLt7T/5Ve3iEkhAbNa0ZihNSsHPEio+lq+
	0L3CEVKgRUmu9eh8
X-Google-Smtp-Source: AGHT+IGRoCDvefbFzC6jI8eoiyaJwQY+MVagscMSk1SQP59pQNBBzH+/Z2VgQqY5H4m/ta4tZ/nIKw==
X-Received: by 2002:a5d:5848:0:b0:385:f7a3:fec1 with SMTP id ffacd0b85a97d-38a872dc81dmr10932658f8f.3.1737022980865;
        Thu, 16 Jan 2025 02:23:00 -0800 (PST)
Received: from localhost (ip-89-103-73-235.bb.vodafone.cz. [89.103.73.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c74ac207sm54165545e9.12.2025.01.16.02.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 02:23:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Jan 2025 11:22:59 +0100
Message-Id: <D73F98QBJ4S9.3CN2ZUQ0GSMT6@ventanamicro.com>
Subject: Re: [PATCH] riscv: Add initial Xen guest support for RISC-V
Cc: <linux-riscv@lists.infradead.org>, <jgross@suse.com>,
 <aou@eecs.berkeley.edu>, <Milan.Djokic@rt-rk.com>,
 <rafael.j.wysocki@intel.com>, <linux-kernel@vger.kernel.org>,
 <oleksandr_tyshchenko@epam.com>, <iommu@lists.linux.dev>,
 <sstabellini@kernel.org>, <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
 <xen-devel@lists.xenproject.org>, <Slavisa.Petrovic@rt-rk.com>,
 <takakura@valinux.co.jp>, "linux-riscv"
 <linux-riscv-bounces@lists.infradead.org>
To: "Andrew Jones" <ajones@ventanamicro.com>,
 =?utf-8?q?Milan_=C4=90oki=C4=87?= <milandjokic1995@gmail.com>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
References: <e4a649a7fdfc8fcf5f48a0bc4e76e5d546078083.1736868605.git.Slavisa.Petrovic@rt-rk.com> <20250114-316084c962eb867c0b681043@orel> <CAKp59VFkW8F2xHsgAxiw138ZrpQJL8R5cTkF8f9vY40iEoRbWg@mail.gmail.com> <20250116-aa9eadde9279e66dbc01c705@orel>
In-Reply-To: <20250116-aa9eadde9279e66dbc01c705@orel>

2025-01-16T09:51:25+01:00, Andrew Jones <ajones@ventanamicro.com>:
> On Wed, Jan 15, 2025 at 08:04:05PM +0100, Milan =C4=90oki=C4=87 wrote:
>> On Tue, Jan 14, 2025 at 7:18=E2=80=AFPM Andrew Jones <ajones@ventanamicr=
o.com> wrote:
>> > On Tue, Jan 14, 2025 at 05:09:36PM +0100, Milan Djokic wrote:
>> > > +#define SBI_ECALL 0xE
>> >
>> > Shouldn't this be 0xA000007, i.e. the SBI firmware specific extension
>> > for Xen. Otherwise why refer to SBI? Note, '0xE' is an invalid, legacy
>> > extension ID in SBI.
>> >
>> Hypercall is triggered through SBI and we defined 0xE just as an
>> SBI_ECALL ID on Xen side for hypercall handling (among other operation
>> IDs), so we're not referring to some standard /legacy ID here, just
>> utilizing SBI for hypercall handling.
>
> If the SBI specified EIDs and binary encoding aren't used, then the
> hypercalls aren't "triggered through SBI", Xen is just doing its own
> thing on an ecall. Xen doesn't have to implement SBI at all, but if
> it wants to provide SBI services, as well as its own hypercalls, then
> the hypercalls should be encoded in the same way as SBI functions and
> an EID allowed by the SBI specification for hypervisor-specific
> functions should be used. For Xen, that EID is already specified and
> it's 0xA000007.

SBI specifies a complete calling convention, but it's not necessary for
binary compatibility.  SBI also aims to simplify caller API.

Linux maintainers will want a good reason for introducing separate Xen
SBI call functions/macros (linux already has sbi_ecall, so please try to
use and potentially improve it), but the ECALL is guaranteed to be SBI
compatible as long as a7=3D0xA000007.

a7 is needed to denote Xen's extension space and the remaining
input/output registers can be implemented in any way Xen wants.
