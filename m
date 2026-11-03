Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.210.91.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793713898;
	b=jm5G2U+iEbIMmaknWOxpIAZNw6hWJJrXXwrCWqicyHGN5zcUgZlmCfYQm6o85kmK3mPG
	 UXQAaGq1l4I640TrMWR+xUr80COA4iZmXezTuiPL3ol6E82mBYJo384sWQfC1EGnGa1vs
	 lkldSWNhFFYhUa21MQaTqpaTFrHj3AQmy1EAa4Cuki8ELRVsbChfLiUO6rAFqseoHsdy7
	 fx41CqsFaw0TQg0rR2pT6fRfF4PSebC0l6yW7kOWsBg9+oaczZuHuSSx5hf2j5mHsFHW1
	 Kv0Dagv/hWOYkMVqVC09V9pWNjNy0roctl+BHo6zOsWEQtprmcDteh9qXt6JAyrDAlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793713898;
	h=DMARC-Filter:Received:Received:Received:Received:X-OVh-ClientIp:
	 Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:x-ovh-tracer-id:
	 X-VR-SPAMSTATE:X-VR-SPAMSCORE:X-VR-SPAMCAUSE:DKIM-Signature;
	bh=CobYPBDs7z1N+btRZF2lJZ5T4n0PenuOp7YKkuLtHWM=;
	b=hGU3X8HlhMsp+V/GCA5hf1WQ0uRyWNIRWSbPaYyjmcvRy1lZ+RVuHF23F5vjQGVtChwH
	 HnIf6KBbLDh0irh1OceVqmd8gLI/qiBFxX+NUILWVB5IQkjkv1I/9chOp6gOlVFhz3WA9
	 JxbjOx96T8tpQlk9KyznmqSTG181J/mQXvZMGn+GWj3V9vs0g1jMmgd/zJNl2GM+u7SFb
	 ZIiRcq/AIb56Bc7t9sQv39MYLbgOw4JHG/KbLRJ77TfqvukgcPWsOKA/iTPdQezNEco20
	 bSKkDOqcZ6lC4yMQ4Wr4JcdLFMEIHZN5eh/IrxVG7myKS2JC7J5rUHrIRCMh3WFvUlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=guillain.net;
	spf=pass smtp.mailfrom=guillain.net;
	dkim=pass header.d=guillain.net header.i=@guillain.net header.a=rsa-sha256 header.s=ovhmo31693-selector1 header.b=pEbPnjhb;
	arc=none smtp.remote-ip=51.210.91.34
Received: from smtpout5.mo538.mail-out.ovh.net (smtpout5.mo538.mail-out.ovh.net [51.210.91.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C62606EE95
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 13:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8C62606EE95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=guillain.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=guillain.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=guillain.net header.i=@guillain.net header.a=rsa-sha256 header.s=ovhmo31693-selector1 header.b=pEbPnjhb
Received: from director3.derp.mail-out.ovh.net (director3.derp.mail-out.ovh.net [79.137.60.223])
	by mo538.mail-out.ovh.net (Postfix) with ESMTPS id 4jJqjs0NYCz5y5q;
	Tue,  3 Nov 2026 13:51:29 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net (director3.derp.mail-out.ovh.net. [127.0.0.1])
        by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <joro@8bytes.org>; Tue,  3 Nov 2026 13:51:28 +0000 (UTC)
Received: from mta3.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.58.197])
	by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4jJqjr6Wbrz1xpd;
	Tue,  3 Nov 2026 13:51:28 +0000 (UTC)
Received: from guillain.net (unknown [10.1.6.7])
	(Authenticated sender: jean-christophe@guillain.net)
	by mta3.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 1EF8C942064;
	Tue,  3 Nov 2026 13:51:27 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-106R006abbba8fe-fb7b-4693-931e-c20f502f8157,
                    15838527D7D3E0897ACBD919E55849F771FD37B2) smtp.auth=jean-christophe@guillain.net
X-OVh-ClientIp:78.242.14.240
Message-ID: <97e7c46b2c3b8a0af2a458649349798c4ecc55ff.camel@guillain.net>
Subject: [REGRESSION] AMD IOMMU NULL pointer dereference during boot with
 v7.4-rc1
From: Jean-Christophe Guillain <jean-christophe@guillain.net>
To: iommu@lists.linux.dev
Cc: vasant.hegde@amd.com, joro@8bytes.org, suravee.suthikulpanit@amd.com
Date: Tue, 03 Nov 2026 14:51:25 +0100
Autocrypt: addr=jean-christophe@guillain.net; prefer-encrypt=mutual;
 keydata=mDMEaEmXaBYJKwYBBAHaRw8BAQdA1qyia8WH1pu6T8sC99WNMyKXooD/SVqJXsJOcnIux
 w20N0plYW4tQ2hyaXN0b3BoZSBHdWlsbGFpbiA8amVhbi1jaHJpc3RvcGhlQGd1aWxsYWluLm5ldD
 6IlgQTFgoAPhYhBDk2+TsBtH9ETCTubi9QTbKhgBdPBQJoSZdoAhsBBQkSzAMABQsJCAcCBhUKCQg
 LAgQWAgMBAh4BAheAAAoJEC9QTbKhgBdPrq0A/icNhFTYLybFWWq1B42UvJLGs18MNRiT5aLdFv3R
 DfHVAQCvzsLrC/qz4rOyIpDzeb0biOu3fiDTcyvV3kPiu3xTDA==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
x-ovh-tracer-id: 16636297026079509502
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTGsVRszeTgPk2NN8a+Cg96FuZ3AaxnLFPQgchpPWgELqRgveZGx4cLaZMQfuSEhaW9PNnkuQFi7TIN3GlosTEE6BRxaLFNcX0PSveWAoXvh1RPAOVw8zWszBHZUFAaDJ+mnRkyXaH64kci2KXEjizqB1ebVcHfoPx0TlfyqvzMcDs4koDOfpEtby2MprXU6Jq7wkWsvMsRLXmL41nz7auH9KWM8TlMbCTXSI5lpAdc/xgRePNyPN9CC5QvVga3oLIBXHhi2LPxdaZ4XIVE33vk1S5pIoncCb+nLyfIRtLKJV/a53J1g4MWEtulAp9/BAtFp6ztW2SpVtJJhGw1k9489VEIbkVGnlulrTV5W1JXTD7+xvGObeUYSS9DIMIem7a5qyqfwwmfdXqFbet6hno4IYaNCi1SMQoufJBbnBQun07gEMUjBSRVpf6enW43HU3tFL5SAFiCH2S5zCGUf4L32q2nZOb7TEkDEs/B5jrZKagOpukEhN8zuc/CXKABJb8sKUmBNwbzfATnKYepjM07Hgpqr5fngepOOvRQMMiKfwHrN8p7z/t6hSfUFOSbOfLIsylEDz5TBmM79P7+iSGMeuuQbOdjHXG0E+/etD5P2so7ZHg8MgegIzoG0PXcOTbBZJQLfxEBWRA1V8mPyednKkZ7ae6/U/rPpCiixgVcBsg
DKIM-Signature: a=rsa-sha256; bh=CobYPBDs7z1N+btRZF2lJZ5T4n0PenuOp7YKkuLtHWM=;
 c=relaxed/relaxed; d=guillain.net; h=From; s=ovhmo31693-selector1;
 t=1793713889; v=1;
 b=pEbPnjhb+EQtooMKtH8/PkjLmVxDQSGi/Ct04ScOYAnXJVDVzm8H5PC4k52dJm228lwT4ODi
 xEEkgjiCNaw5oyX6YqBhH2KPWwftr8Zr+1qbHVLLyXJV+FyJrPDGop4DqguhIjtgyUkGkgdHM5t
 yVT0zZBHe7aHRp1F2jB1Ws3miOmAJDCKQ4VHzymdvD7tBGOavkuYHMeRhJolHsnA1gtssruZ+Je
 MwoH07lYvBcJhSRkH/yCjvRk2OH86aEipMKplx3eu2W0qkDMoLofrzUDxaBNNyUg2bnSTtjnTMe
 b+fcGWEamJ9P42Ydh8Tn6hMdduSZvtD3bn34CbcuIE+sw==

Hello !

I am experiencing a boot regression in 7.4-rc1 on my computer. It boots
normally with 7.3 but hangs with 7.4-rc1 after "Loading initial
ramdisk...".

My system :
- Lenovo, motherboard 3130
- CPU: AMD PRO A10-9700E
- Firmware: Lenovo UEFI, M1XKT57A, dated 2022-02-10

Software :
- Debian 12.15 (Bookworm)
- Bootloader: GRUB, UEFI boot
- GCC 12.2.0

I added the following kernel command-line parameters to get more
information : "earlycon=3Defifb keep_bootcon ignore_loglevel". It
revealed a NULL pointer dereference in the AMD IOMMU driver :

BUG: kernel NULL pointer dereference, address: 000000000000003c
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
RIP: 0010:amd_iommu_def_domain_type+0x73/0xb0

Call Trace:
 <TASK>
 iommu_setup_default_domain+0x25f/0x540
 iommu_device_register+0x162/0x290
 iommu_do_set_dev+0x11f/0x390
 ? __pfx_pci_iommu_init+0x10/0x10
 amd_iommu_init+0x10/0x40
 ? __pfx_pci_iommu_init+0x10/0x10
 pci_iommu_init+0x11/0x40
 do_one_initcall+0x53/0x310
 kernel_init_freeable+0x202/0x370
 ? __pfx_kernel_init+0x10/0x10
 kernel_init+0x1b/0x1c0
 ret_from_fork+0x217/0x300
 ? __pfx_kernel_init+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Kernel panic - not syncing: Attempted to kill init!
exitcode=3D0x00000009

Adding amd_iommu=3Doff to the kernel command line allows the system to
boot successfully.

#regzbot introduced: v7.3..v7.4-rc1

Cheers,
Jean-Christophe Guillain
