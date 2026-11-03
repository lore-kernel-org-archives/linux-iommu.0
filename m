Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.105.54.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793719452;
	b=ffPR6V0Raqq2pOcKotm6TcmJAWRggHftlDVS+YnRtEPIfgBc4wRjdvn+Zo0N/hgBgyW2
	 Qao4uipaWFzn54nIrFQ043h7wgWZHGPjGGyC0uY5Ox+hd2ZgBVkuVnsbh/d9o1uMC4e3R
	 LMWOeQcv9+oSweUv/xa07uzJQgtclp+U3JY2jfHUpHxmshxojA7Gn5SwWccKkg2Rft+Pp
	 kDvkiesUxfi0lZR0AC14FYRUwcR/M+NzDVQrCeDfz2PC8LpQL0Zoy7oqliXNBljJySorw
	 WOQ7e6SIqT+VeW5g0l5iQ4R/0bH6pIXMNoY4V54ol0sJtP5KP9rRa0tWcwb2zgXdaAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719452;
	h=DMARC-Filter:Received:Received:Received:Received:X-OVh-ClientIp:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version:
	 x-ovh-tracer-id:X-VR-SPAMSTATE:X-VR-SPAMSCORE:X-VR-SPAMCAUSE:
	 DKIM-Signature;
	bh=1L5krIydGmk7xI+Nv0gQEjJfsEfRtPueF98AXg/WfdU=;
	b=IFYLbtMx/J24JKJ4UCeiWOqzB9jPec9m401SQirfPH1qD+RcL+fPOI5riENsWfO1H+v5
	 6a89aQ/RHrJ6O7t5fO0VxT3m5j8uqxIE7hS3RBWkiTJeV/UeAZ1cChxniCnbPbiiPUAQo
	 TnNgcLZ4W4v7DmqnE7mXYaYPirKMQ3tVZBQhT5HaJcHs6gIX8UzS1BV0uy7IpFCK7lH8S
	 HHsL0BwyqAWX+RhMpN66i9Glqq0peGw1YSO/Tev5rAKX9aZqaj0hNrqU6KTg01NFMEe/3
	 3ir7/OKtcAjG/tWMhAS36R/Vvi1rF2r0nIgDoF0rK3x25EEluhU3+jYRAyN+pPEDllA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=guillain.net;
	spf=pass smtp.mailfrom=guillain.net;
	dkim=pass header.d=guillain.net header.i=@guillain.net header.a=rsa-sha256 header.s=ovhmo31693-selector1 header.b=fuoTTZaG;
	arc=none smtp.remote-ip=46.105.54.122
Received: from 3.mo528.mail-out.ovh.net (3.mo528.mail-out.ovh.net [46.105.54.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96E6606A324
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 15:24:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A96E6606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=guillain.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=guillain.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=guillain.net header.i=@guillain.net header.a=rsa-sha256 header.s=ovhmo31693-selector1 header.b=fuoTTZaG
Received: from director4.derp.mail-out.ovh.net (director4.derp.mail-out.ovh.net [79.137.60.37])
	by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 4jJsmh2Ln6z5x6p;
	Tue,  3 Nov 2026 15:24:04 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net (director4.derp.mail-out.ovh.net. [127.0.0.1])
        by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <joro@8bytes.org>; Tue,  3 Nov 2026 15:24:04 +0000 (UTC)
Received: from mta6.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.188.134])
	by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4jJsmh1TZRz1xpl;
	Tue,  3 Nov 2026 15:24:04 +0000 (UTC)
Received: from guillain.net (unknown [10.1.6.10])
	(Authenticated sender: jean-christophe@guillain.net)
	by mta6.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 55B428E2064;
	Tue,  3 Nov 2026 15:24:03 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-110S0041096bfe3-00c3-4564-a5a1-5854ee59d9d5,
                    15838527D7D3E0897ACBD919E55849F771FD37B2) smtp.auth=jean-christophe@guillain.net
X-OVh-ClientIp:78.242.14.240
Message-ID: <11464974726ebbb4b24c1c0ae0eae8d536f60b71.camel@guillain.net>
Subject: Re: [REGRESSION] AMD IOMMU NULL pointer dereference during boot
 with v7.4-rc1
From: Jean-Christophe Guillain <jean-christophe@guillain.net>
To: Mario Limonciello <mario.limonciello@amd.com>, Vasant Hegde
	 <vasant.hegde@amd.com>, iommu@lists.linux.dev
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com
Date: Tue, 03 Nov 2026 16:24:02 +0100
In-Reply-To: <18bf71fb-df45-478b-a625-2f6dffef47e7@amd.com>
References: <97e7c46b2c3b8a0af2a458649349798c4ecc55ff.camel@guillain.net>
	 <aa03a31a5d700da89d2d20ce92a16c9629d20702.camel@guillain.net>
	 <6a3cf464-6c1b-460a-9ee5-5468ded48e0a@amd.com>
	 <18bf71fb-df45-478b-a625-2f6dffef47e7@amd.com>
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
x-ovh-tracer-id: 18200171995602504702
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFYTvyY2w4CHdhzpfj531hDY1NaqeHuljM8FZSBKn0L2RIvsZIBSWp5YLUNmFn/oXD9KRE2/aOWC8/J3SwPC0r1iLXedypEdU0QgumnzTlrH278UaDAL+ISmOfksC4zhL5IVSRe6mx81ohNLEnpBGmnOBCt1Zy5ucaJw4/eGEdFTp56PtEF3j/wf5WSPEvzpr5XXiY9bldt5dRrte8TctD0fKeyCW+mpChGVinyWmSPMXSCa0hYLM2LVcNbUAcl2AJmqmhoJttALBLN6bkZ+d5J4+AM6AZYBD/OyB8N8Bweg64GQ7APoPfzJc/9WuSbkwLfa2Twge/ExMfbSHSlmKHdk0rjEAQeTFCZDXtfjNbqLYOpfB9fa/p033w4elRb6gXLyO3My4vd0eV/C6Jimd/olNzOEz6yEqhlimTYEFySVD3A3z4V0pCGvO2cSCsR4RxVrk5YtVlXPxzYuOXZgRa+unXkiwj/d00UwBi4C1X0pgyX4+27TRYeXHkJKAepuuGchbR9lHCmQtOhnl5flYd+Z9FJ0A2d7lQ+4UVQUIEK1FHm9v7r5/o8SCt9UNecZ5Fhkd7jEVTbtIlZS4j1OmeHv+paL1IX9mDsKm6RjKzEcDHdRd+AkwQJSbGjgEJStou4+E+vvBk9aY2NRhtUmy12OehvC32FqrXXlX63jWFmPA
DKIM-Signature: a=rsa-sha256; bh=1L5krIydGmk7xI+Nv0gQEjJfsEfRtPueF98AXg/WfdU=;
 c=relaxed/relaxed; d=guillain.net; h=From; s=ovhmo31693-selector1;
 t=1793719444; v=1;
 b=fuoTTZaGSpHAUDUc9Euxl8c5/GPlaNpBGOEW4oiUtGYfLBinx6YDjkRJigqb82D//U+0PPQr
 jWrGH0VHqmhGWxAZ3fPxbk6EWh5onx4DbVDZaZjFP1RiCGazA5KRC8dGIR7an+0jQQTBjelFgRc
 fQhnljZNSGPRLeXo4+jrhgmrqDYD9vZdAW/c8pV9EpQMxMgfIus8Se/w73F/Uq5UjiWYS90pdai
 Rf3Q5uMGKGuqFEYzrVw2KoAgbVTW0J/7e16icsrqUqhdmR4t/49UfKdRwLKqYsVNgby5sNwMup4
 s5rgSFSIURN/AQoNqOb5bb4JA4ZZYruL7PHx5rS/6/aRw==

Hi Mario

> Can you please also share output for:
>=20
> =E2=95=B0=E2=94=80=E2=9D=AF lspci -nnttv
>=20
> This is a surprising combination to me too.

Sure !

$ lspci -nnttv
-[0000:00]-+-00.0  Advanced Micro Devices, Inc. [AMD] Family 15h
(Models 60h-6fh) Processor Root Complex [1022:1576]
           +-00.2  Advanced Micro Devices, Inc. [AMD] Family 15h
(Models 60h-6fh) I/O Memory Management Unit [1022:1577]
           +-01.0  Advanced Micro Devices, Inc. [AMD/ATI] Wani [Radeon
R5/R6/R7 Graphics] [1002:9874]
           +-01.1  Advanced Micro Devices, Inc. [AMD/ATI] Kabini
HDMI/DP Audio [1002:9840]
           +-02.0  Advanced Micro Devices, Inc. [AMD] Family 15h
(Models 60h-6fh) Host Bridge [1022:157b]
           +-02.1-[01]----00.0  Shenzhen Unionmemory Information System
Ltd. NVMe 256G SSD device [1cc4:17ab]
           +-02.2-[02]----00.0  Realtek Semiconductor Co., Ltd.
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:8168]
           +-03.0  Advanced Micro Devices, Inc. [AMD] Family 15h
(Models 60h-6fh) Host Bridge [1022:157b]
           +-08.0  Advanced Micro Devices, Inc. [AMD] Carrizo Platform
Security Processor [1022:1578]
           +-09.0  Advanced Micro Devices, Inc. [AMD] Carrizo Audio
Dummy Host Bridge [1022:157d]
           +-09.2  Advanced Micro Devices, Inc. [AMD] Family 15h
(Models 60h-6fh) Audio Controller [1022:157a]
           +-10.0  Advanced Micro Devices, Inc. [AMD] FCH USB XHCI
Controller [1022:7914]
           +-11.0  Advanced Micro Devices, Inc. [AMD] FCH SATA
Controller [AHCI mode] [1022:7901]
           +-12.0  Advanced Micro Devices, Inc. [AMD] FCH USB EHCI
Controller [1022:7908]
           +-14.0  Advanced Micro Devices, Inc. [AMD] FCH SMBus
Controller [1022:790b]
           +-14.3  Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge
[1022:790e]
           +-18.0  Advanced Micro Devices, Inc. [AMD] Family 15h
(Models 60h-6fh) Processor Function 0 [1022:1570]
           +-18.1  Advanced Micro Devices, Inc. [AMD] Family 15h
(Models 60h-6fh) Processor Function 1 [1022:1571]
           +-18.2  Advanced Micro Devices, Inc. [AMD] Family 15h
(Models 60h-6fh) Processor Function 2 [1022:1572]
           +-18.3  Advanced Micro Devices, Inc. [AMD] Family 15h
(Models 60h-6fh) Processor Function 3 [1022:1573]
           +-18.4  Advanced Micro Devices, Inc. [AMD] Family 15h
(Models 60h-6fh) Processor Function 4 [1022:1574]
           \-18.5  Advanced Micro Devices, Inc. [AMD] Family 15h
(Models 60h-6fh) Processor Function 5 [1022:1575]

Cheers !
Jean-Christophe Guillain
