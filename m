Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4027B2609C5
	for <iommu@lists.linux.dev>; Mon,  8 Jun 2026 06:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780899742; cv=none; b=Nz6/H+JGJqqY0+XSCj+tEQT1bhNWPGynkJ6m1nsZp6rEyfm+ymbb2jeC+mftywtXTJqnVOkfnP+/GAZO0OpoVVDVV1gmg3CUrkGl7fEZhSm3M/4AuEX3yKNXG/i7DJqzakTr+s6iGlwiAuJYXpy160tmG0qgo4xt6HSx7ZmWtMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780899742; c=relaxed/simple;
	bh=7qAmCdAUmowrtnJvbQzXjHqFfTbeuO7/02h2swwvVIs=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=GyAhCN0KGuPoj73/KAWpnFiAWi6C8Ez/i0880wz+x2vSQad3zntSs59i5P0VMaKcsVeIQWoEZvbcfI04JpTYomN5SFPTHNSLfjyV9FlrRiNrIk4K9WtFLcLhibD9CfsTyq+VyLUKPgfK/8jdozNpqTuLrPxDRSX/9ZsCejt/u24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gYhll4jZSz7Qxs2;
	Mon, 08 Jun 2026 14:22:11 +0800 (CST)
Received: from szxl2zmapp06.zte.com.cn ([10.1.32.108])
	by mse-fl1.zte.com.cn with SMTP id 6586M46N071766;
	Mon, 8 Jun 2026 14:22:04 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
	by mapi (Zmail) with MAPI id mid12;
	Mon, 8 Jun 2026 14:22:06 +0800 (CST)
X-Zmail-TransId: 2b036a265f8e79d-24602
X-Mailer: Zmail v1.0
Message-ID: <20260608142206426CGB5DlYd1xVlR8wrOawWH@zte.com.cn>
In-Reply-To: <CAB19ukEzQZktJcBAXi8X2Pwz+hO_FcR+iiaK9nsCAumP9BrHnw@mail.gmail.com>
References: 20260604145510898G2kTwM2Pr25QE5H8T4Wh6@zte.com.cn,CAB19ukEzQZktJcBAXi8X2Pwz+hO_FcR+iiaK9nsCAumP9BrHnw@mail.gmail.com
Date: Mon, 8 Jun 2026 14:22:06 +0800 (CST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
From: <wang.yechao255@zte.com.cn>
To: <sunilvl@oss.qualcomm.com>
Cc: <linux-acpi@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        <sunilvl@ventanamicro.com>, <rafael@kernel.org>, <lenb@kernel.org>,
        <pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <alex@ghiti.fr>, <tomasz.jeznach@linux.dev>,
        <anup.patel@oss.qualcomm.com>, <andrew.jones@oss.qualcomm.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gaW9tbXUvcmlzY3Y6IEFkZCBkZXBlbmRlbmN5IGJldHdlZW4gaW9tbXUgYW5kIGRldmljZXM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6586M46N071766
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Mon, 08 Jun 2026 14:22:11 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A265F93.001/4gYhll4jZSz7Qxs2

> >
> > From: Wang Yechao <wang.yechao255@zte.com.cn>
> >
> > Commit 9156585280f1 ("ACPI: RIMT: Add dependency between iommu and
> > devices") adds the dependency between iommu and devices on ACPI
> > systems. On devicetree systems, the incorrect removal order also
> > occurs.
> >
> Interesting. Why is it not handled by the fw_devlink infrastructure in DT?
>
> Thanks,
> Sunil

Thank you. I have noticed that commit e149573b2f84 ("of: property: Add device
link support for "iommu-map"") adds support for "iommu-map" to the device link
supplier bindings, so that probing of PCI devices can be deferred until after
the IOMMU is available.

The QEMU RISC-V virt machine currently lacks the "iommu-map" property for the
PCIe bus when the iommu-pci device is used, which leads to this issue. Therefore,
I believe the correct fix is to add the "iommu-map" property for PCIe in QEMU.

Best regards,
Yechao
