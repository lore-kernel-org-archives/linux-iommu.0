Received: from mail178-22.suw51.mandrillapp.com (mail178-22.suw51.mandrillapp.com [198.2.178.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D4C1FA838
	for <iommu@lists.linux.dev>; Tue, 14 Jan 2025 17:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.2.178.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736877117; cv=none; b=SYJQL3wTWajleBPu+d+HLXveGaTw48qNX1tDs1UVwoN7jkXX6BgLTquwQ5c++1okGcKPrRkjsyv9MmFTJZwwe7mpeTsR9YNo5sEVcGXifankpCH6J0bMlelzgaUPd6sfgtPngQxleh2i2ZANIQo8jTNhp8NBWhZpUkjzDsGR52I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736877117; c=relaxed/simple;
	bh=2jcBvZoNRO5iONp51Cafz2Hc2Sp1Y/yFi0LBvxYLzdY=;
	h=From:Subject:Message-Id:To:Cc:References:In-Reply-To:Date:
	 MIME-Version:Content-Type; b=OkyMTFEoJ5jDtiBiy+3UAmS2IQ50LNgR6O3CKWTwpkfeAsmLYEgqWoNObXrFQ0zkB/Qk0j2vLqQCvrSEeijxiJC3QzHLyq4FrsWk5BplGlB5AfOvvOkC8g5TklZNkWq0Y69iUAq8YF9gq/AopygEWKNZWCeYUEubJID22desKuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vates.tech; spf=pass smtp.mailfrom=bounce.vates.tech; dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b=VlGpXUuJ; dkim=pass (2048-bit key) header.d=vates.tech header.i=teddy.astie@vates.tech header.b=YyNTQjEF; arc=none smtp.client-ip=198.2.178.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vates.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.vates.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="VlGpXUuJ";
	dkim=pass (2048-bit key) header.d=vates.tech header.i=teddy.astie@vates.tech header.b="YyNTQjEF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
	s=mte1; t=1736877114; x=1737137614;
	bh=az8rpG0APRcxLiWSmI+/bj3xR4gqvWnpdGPbdfScdrk=;
	h=From:Subject:Message-Id:To:Cc:References:In-Reply-To:Feedback-ID:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
	 Subject:From;
	b=VlGpXUuJn8Jz2oaK/ZJTwN0W9aMXf793YJWAokZMUSmPjFJwKM8j/ByKpeZs5AUZk
	 zczuJj22N4ZDbsYtqv6N0Y7z58wHQqXthFQ1i3rtL51OtZS1/DlIGM7j6l3mR9C2Su
	 Aw3BZtrqrJo9Tn+E4Uq04wtcaCTFAONz5GFLdvCCnpB3ZkAATbxB7v0Oj31Oek6e6s
	 bQzdKxZ0319KbTJEaEayqB3AP6GUPxGLMj8keOxoUvzzDPNEZ6iG3Fq2o5QLQzyX4X
	 /BwVD+rhyCqLbirP979/6RTnsBwU8jWJAJ7H5E+O1spqWT0sp2TLbkqUVlLhDgerhX
	 xxBZfSjcoLYAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
	t=1736877114; x=1737137614; i=teddy.astie@vates.tech;
	bh=az8rpG0APRcxLiWSmI+/bj3xR4gqvWnpdGPbdfScdrk=;
	h=From:Subject:Message-Id:To:Cc:References:In-Reply-To:Feedback-ID:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
	 Subject:From;
	b=YyNTQjEFcCrEpflceEe0lOYeKaDMVTiRW5SXUCaIVTzXPQvxMrr+yUI5zDB/4e97w
	 4vo58Y7uwgZL+Jw/0bXI1f3nP6+xQIR8ehKzWQipHfQ1tKpUvMgDmBGkOU7S5RfpR0
	 jlkdZlV30mgo9BvdgGtMW2sq1deCDjzg1e7OWDmsci1qriVm01I3SYCqHwdF1bGFli
	 Jxu7PIsBn59BI8XWp8sILKz/eMoaWTLhdlKRJd2k5zxUZH8trrOkMzGN06NXzoOwTK
	 irQfj7NJDURr/rEM6MviOfkPW0eyg2U9Td5iaVdkGEedSTOHYSFreTbj5Hg/uhvSR8
	 /1aXJF9knFBYQ==
Received: from pmta13.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
	by mail178-22.suw51.mandrillapp.com (Mailchimp) with ESMTP id 4YXcBy4gygzGlsvR5
	for <iommu@lists.linux.dev>; Tue, 14 Jan 2025 17:51:54 +0000 (GMT)
From: "Teddy Astie" <teddy.astie@vates.tech>
Subject: =?utf-8?Q?Re:=20[PATCH]=20riscv:=20Add=20initial=20Xen=20guest=20support=20for=20RISC-V?=
Received: from [37.26.189.201] by mandrillapp.com id 53b5c9d2de9d4745b82f09c59357a60a; Tue, 14 Jan 2025 17:51:54 +0000
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1736877112710
Message-Id: <0cac0b13-128c-4d8b-b235-09d7b440ad8e@vates.tech>
To: "Milan Djokic" <milandjokic1995@gmail.com>, linux-riscv@lists.infradead.org
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, jgross@suse.com, sstabellini@kernel.org, oleksandr_tyshchenko@epam.com, Slavisa.Petrovic@rt-rk.com, Milan.Djokic@rt-rk.com, rafael.j.wysocki@intel.com, sunilvl@ventanamicro.com, takakura@valinux.co.jp, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, iommu@lists.linux.dev
References: <e4a649a7fdfc8fcf5f48a0bc4e76e5d546078083.1736868605.git.Slavisa.Petrovic@rt-rk.com>
In-Reply-To: <e4a649a7fdfc8fcf5f48a0bc4e76e5d546078083.1736868605.git.Slavisa.Petrovic@rt-rk.com>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,=20including=20all=20headers,=20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.53b5c9d2de9d4745b82f09c59357a60a?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20250114:md
Date: Tue, 14 Jan 2025 17:51:54 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Le 14/01/2025 =C3=A0 17:13, Milan Djokic a =C3=A9crit=C2=A0:
> diff --git a/test.txt b/test.txt
> new file mode 100644
> index 000000000000..e54267998982
> --- /dev/null
> +++ b/test.txt
> @@ -0,0 +1,21 @@
> +WARNING: added, moved or deleted file(s), does MAINTAINERS need updating=
?
> +#120:
> +new file mode 100644
> +
> +WARNING: do not add new typedefs
> +#808: FILE: include/xen/riscv/interface.h:15:
> ++=09typedef struct { union { type * p; uint64_aligned_t q; }; }  \
> +
> +WARNING: please, no spaces at the start of a line
> +#1006: FILE: include/xen/riscv/swiotlb-xen.h:10:
> ++    return 0;$
> +
> +total: 0 errors, 3 warnings, 810 lines checked
> +
> +NOTE: For some of the reported defects, checkpatch may be able to
> +      mechanically convert to the typical style using --fix or --fix-inp=
lace.
> +
> +0001-riscv-Add-initial-Xen-guest-support-for-RISC-V.patch has style prob=
lems, please review.
> +
> +NOTE: If any of the errors are false positives, please report
> +      them to the maintainer, see CHECKPATCH in MAINTAINERS.

I am not sure you want this here.

 > diff --git a/arch/riscv/include/asm/hypervisor.h 
b/arch/riscv/include/> asm/hypervisor.h
 > new file mode 100644
 > index 000000000000..3a117afe57f0
 > --- /dev/null
 > +++ b/arch/riscv/include/asm/hypervisor.h
 > @@ -0,0 +1,9 @@
 > +/* SPDX-License-Identifier: GPL-2.0 */
 > +#ifndef _ASM_RISCV_HYPERVISOR_H
 > +#define _ASM_RISCV_HYPERVISOR_H
 > +
 > +#include <asm/xen/hypervisor.h>
 > +
 > +void kvm_init_hyp_services(void);
 > +
 > +#endif

kvm_init_hyp_services seems KVM-specific and doesn't seem to exist (yet) 
for RISC-V.

Teddy


Teddy Astie | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech

