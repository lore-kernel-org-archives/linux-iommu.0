Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DBC2C17B3
	for <iommu@lists.linux.dev>; Wed,  5 Nov 2025 10:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762337372; cv=none; b=h+rnm+1X/oXPn1W5btBdZeaHyMPetuQmw0pfTEmX8R30qKxinZwFML0kS+IrjPLubX9P8ILvMpseoiR1MvrxMBjifubOCadqz2ugPofcpaD39MbedClFot1ndYOhao75X7jLj7+MNswVz6nIQIB0xZiDP5fLIa+ZYJJtrgjNEks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762337372; c=relaxed/simple;
	bh=Qyyh0raED7CYSRBSbAaH4gfg6n000acaNazrYxYVUFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Haf3aEV6SU8+6HDy4LpiWg9fShblCk/8qHdOumG4H4FmMfJUr7z9bN+IefCYIkJgoKyGaKFLTcqJeK8oLcaS3Bd5dI7lUMjAM/adk5T10CuB/0UpM/jQ+sgg296F5OEcTXKL09LtjM6/w8OEJZfikLijwhOqdI6UFojhpVw1l/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.105] (unknown [114.241.85.109])
	by APP-03 (Coremail) with SMTP id rQCowABX1Os1IgtpLC6YAQ--.36657S2;
	Wed, 05 Nov 2025 18:08:54 +0800 (CST)
Message-ID: <0a0b8b94-ad94-46ea-ac0d-cbf35dec0f50@iscas.ac.cn>
Date: Wed, 5 Nov 2025 18:08:53 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/7] Linux RISC-V IOMMU Support
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Anup Patel <apatel@ventanamicro.com>, devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
 linux@rivosinc.com, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Sebastien Boeuf <seb@rivosinc.com>,
 iommu@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
 Nick Kossifidis <mick@ics.forth.gr>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, linux-riscv@lists.infradead.org,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>
References: <cover.1729059707.git.tjeznach@rivosinc.com>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <cover.1729059707.git.tjeznach@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:rQCowABX1Os1IgtpLC6YAQ--.36657S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZF47Jr43XF47Ar4rKFWfZrb_yoWkWwc_uF
	Z29r4ktw1UArWxta13KF12vrnrX3s29r10yaykJry2y34rtF4kJFZ8ArySv3Zxtw4fWrnx
	Gw4DGw12vw429jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbsxYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY
	1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x07jDsqXUUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Hi Tomasz,

On 10/16/24 14:52, Tomasz Jeznach wrote:
> This patch series introduces support for RISC-V IOMMU architected
> hardware into the Linux kernel.
>
> [...]
>
> Follow-up patch series providing MSI interrupt remapping, complete ATS/PRI/SVA
> and VFIO/IOMMUFD support are available at the GitHub [2], and has been tested
> with published QEMU RISC-V IOMMU device model [3].

I'm currently looking into building drivers for some "accelerator" style
devices, and I'm trying to figure out the current situation of drivers
for the more advanced IOMMU features, specifically the ATS/PRI/SVA combo.

I see that the GitHub branch has been rebased in May to 6.15, but
seemingly hasn't been touched since. Is this still the latest version of
these patches? Aside from other IOMMU subsystem-wide changes since
v6.15, is there any other code/information that I should take into account?

This isn't super urgent or anything, but I'm pretty new to this, and
given that a year has passed since this series has been merged, I'm not
sure if there's some other development I've missed.

Thanks for your help.

Vivian "dramforever" Wang

