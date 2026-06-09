Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B74B2472AF
	for <iommu@lists.linux.dev>; Tue,  9 Jun 2026 01:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780967099; cv=none; b=i04hlU250fPOfLNehJ1WcJvqZxuCgx5vGUZLJKAuKwRKobG4gKIpi3ysdAiPACGJMQztFI0WYK7xiPajYKrrhIeALHONwyiSZSg/YwWm81AtHX4ooW+PMw41RO88nKQoqnL2grShR7M6ka6Z3vh8aUmgxGrhYFGVU53kyEpVvdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780967099; c=relaxed/simple;
	bh=BJsUS5COebKS7dR3jpmEyMcYSGCCbCogOF+14q99yfU=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=OfJb246ODfmVYr/nDfCxhVWKUs+O8TMSZIQPPTwxbG4dfqyKYSuDZyGqp+y2D7WjjaceVaDYXkZqZseRbfXtgz9GGN6BDLdeFfPds6ZbhY+GWOqJBPnpSvHJxwIHi5uiP3mdkWZcdW7iF/ere8BvSjOQ0KzHg+P2XDbnYVgwdjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gZ9gB4P0Mz8XrrJ
	for <iommu@lists.linux.dev>; Tue, 09 Jun 2026 09:04:54 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4gZ9g05Yp6z52SGY;
	Tue, 09 Jun 2026 09:04:44 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
	by mse-fl1.zte.com.cn with SMTP id 65914iMY081171;
	Tue, 9 Jun 2026 09:04:44 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from mapi (szxl2zmapp05[null])
	by mapi (Zmail) with MAPI id mid12;
	Tue, 9 Jun 2026 09:04:45 +0800 (CST)
X-Zmail-TransId: 2b076a2766ad011-e86b8
X-Mailer: Zmail v1.0
Message-ID: <20260609090445085Jd6HCOSNMYKdW-T-Gzdzj@zte.com.cn>
In-Reply-To: <CAB19ukFMu1tW5QkCOY2e=DWbKrehEDv_iO5T7vEfKEGkbTFEEw@mail.gmail.com>
References: CAB19ukEzQZktJcBAXi8X2Pwz+hO_FcR+iiaK9nsCAumP9BrHnw@mail.gmail.com,20260608142206426CGB5DlYd1xVlR8wrOawWH@zte.com.cn,CAB19ukFMu1tW5QkCOY2e=DWbKrehEDv_iO5T7vEfKEGkbTFEEw@mail.gmail.com
Date: Tue, 9 Jun 2026 09:04:45 +0800 (CST)
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
X-MAIL:mse-fl1.zte.com.cn 65914iMY081171
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 192.168.251.13 unknown Tue, 09 Jun 2026 09:04:54 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A2766B6.000/4gZ9gB4P0Mz8XrrJ

> On Mon, Jun 8, 2026 at 11:52 AM <wang.yechao255@zte.com.cn> wrote:
> >
> > > >
> > > > From: Wang Yechao <wang.yechao255@zte.com.cn>
> > > >
> > > > Commit 9156585280f1 ("ACPI: RIMT: Add dependency between iommu and
> > > > devices") adds the dependency between iommu and devices on ACPI
> > > > systems. On devicetree systems, the incorrect removal order also
> > > > occurs.
> > > >
> > > Interesting. Why is it not handled by the fw_devlink infrastructure in DT?
> > >
> > > Thanks,
> > > Sunil
> >
> > Thank you. I have noticed that commit e149573b2f84 ("of: property: Add device
> > link support for "iommu-map"") adds support for "iommu-map" to the device link
> > supplier bindings, so that probing of PCI devices can be deferred until after
> > the IOMMU is available.
> >
> > The QEMU RISC-V virt machine currently lacks the "iommu-map" property for the
> > PCIe bus when the iommu-pci device is used, which leads to this issue. Therefore,
> > I believe the correct fix is to add the "iommu-map" property for PCIe in QEMU.
> >
> For PCI IOMMU, the dependency should be automatically taken care since iommu
> should always be the first device in the hierarchy and scanned first.

Thank you for pointing it out. The device is not removed before the PCI IOMMU
device because the BDF of the device I configured is smaller than the BDF of
the PCI IOMMU device.

Regards,
Yechao
