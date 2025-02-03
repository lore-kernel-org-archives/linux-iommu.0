Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968561FCD0B
	for <iommu@lists.linux.dev>; Mon,  3 Feb 2025 09:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738573525; cv=none; b=iYnuhFYc2MjF6dT0nOMOKjqzY5WIJ7C/mR5J7W20LBt+BqjDQDKH/U6q25AvRcy3DCqk/OQYDLLnl0821oggCLfPMD8w+pQb4qshBkq+nl1H9ddkK4YxveVQlXpJlaQQVoOPSq00Lkgg80tvTLpr8Auef82TGMK0ZZCvWZ++Fdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738573525; c=relaxed/simple;
	bh=0beenbYykTgMp3pQ+/qj7Qr6Pu0i8oBOXhCtcerZC5c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mVwbFRUf036KRwVG0Id+DShbJGw48McWIJSPm9fRyDowet2glVOLo0ZB4j/KnJ0JjGQMc9/7bOynpTKwIMROG+iqOPmqBvXr43IW9EChxksU+cKvM0+L+FpuCRWgH95ODolXmuz4Rqqau9ETVlV+jv9TVdvT88O+N1y40A7BvNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SY7Rrq3x; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SY7Rrq3x"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4361dc6322fso27568785e9.3
        for <iommu@lists.linux.dev>; Mon, 03 Feb 2025 01:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738573521; x=1739178321; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0beenbYykTgMp3pQ+/qj7Qr6Pu0i8oBOXhCtcerZC5c=;
        b=SY7Rrq3xdXgVIflKEqImGml3ElSST4WknNHutVGNUXS9QpMqo2pwg/5XeHeAR/xTqS
         i9IDisIunj3OUx63FjqBEQh1SBpyQyEhG0wvdDqvRj7X89nGDK6GODPjjpId6PSFygf3
         rnW0m9JqBO4OXAx0emHR6Bu40x8+W11ibOwt3q+cLAgNqnyfHxU2rtLtJol+Ks9Qmws0
         uCgnsu13HQ/kq4bOzqf6uuixJJrgd5G4+Bpn7PNp+volwHQl18qaGNVHm5RdY7YU6Dlc
         ml9ng94ge4hRu1V1sRYr6f5nREoaUqvzrlP5//3OMaKDptUxX2a0bDQZ8TCgYC1yAvcM
         qzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738573521; x=1739178321;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0beenbYykTgMp3pQ+/qj7Qr6Pu0i8oBOXhCtcerZC5c=;
        b=XEsOUrjDp3nTGUs5tFlV06zpC7WSUFr9FTwhwrTmC9S+zGalM2uzEO0/RlRZX9bFhX
         NNTM4nNsPvZUN6UlGPiHXK6plgquGPTMQqq4Eb+CqjjQxtnWph83KKDBiH/hhZJBL1On
         t/tExgbUUQRYBhOOdgIjqLUO5OKG9x9CK6FNvyM1lPt6t8N1kacWbWCPQWx7Ye29/9Rs
         jh2aN84yNv0V/8NrROFnTnpLASqTJgCBemwjTRNnfaWHnO8U1FKOY9JpOdiT/C7NTeuP
         qJJ5ML5pIC+2ukfO07eHusD4YjXo1Rp0sFX3w5SqL9D82ZLimZNJIwym6ma9sbYAFuUU
         I3Yw==
X-Forwarded-Encrypted: i=1; AJvYcCV/7Rkrfd8F1KjDAsMBzxIpnrXYOpO2re9XyHWSSR19Zs/5Ywv5Nnwhw7cbIExEczjrBW27Rw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx1Vt7KbiEJacMIDjiB0OX3GU72pDXEJn27tI/7F8qEdIYenxBa
	6ifZ8ZtlYLV06w7zhePHYwidYEeTe3p6DKJlz7aKgswKqJcqGPAn
X-Gm-Gg: ASbGncu55pf/Ay1XAmscwCPPPddGEeaFaCt5+Va5bViSHyAqwtwqupvs1hrEdEEqN2k
	/XSg0iphrSx+IlHcduqen1majYfEVHOr33cPIr5TrHHg/DUEFJRbsCZZEPcdYg1F5oeo0iIlFNc
	VZVtZ4Q2OoQDr9LE0oB8tkGG9V/Oj9mOE9lXE2/kLooM9GgnAwKnPBoENJ56OrGHUYHs79IN+4O
	96++17jumHXgyNA/WjBRbWSgmA9SLHVsK3ffm3QBVGaK4IhnVFweUDvkIhtaJO5oySEJJw6BJcD
	LKVhCMy7VzKUWioR
X-Google-Smtp-Source: AGHT+IE6gxn55yZy2Z47rpZ+vSyenHE4aXEvc6e6Pk1WMs0UwJgnCaEXq6Ejaux9WMrIE78Z9gaJ6w==
X-Received: by 2002:a05:600c:190e:b0:434:f2f4:4c07 with SMTP id 5b1f17b1804b1-438dc3c820bmr186887475e9.15.1738573519960;
        Mon, 03 Feb 2025 01:05:19 -0800 (PST)
Received: from Red ([2a01:cb1d:894:1200:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38c5c1cf853sm11992565f8f.84.2025.02.03.01.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 01:05:19 -0800 (PST)
Date: Mon, 3 Feb 2025 10:05:17 +0100
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
	robin.murphy@arm.com, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Subject: iommu: flood of ahci 0000:e6:00.0: AMD-Vi: Event logged
 [IO_PAGE_FAULT domain=0x0055 address=0xa14a4000 flags=0x0070]
Message-ID: <Z6CGzUSV7llweytQ@Red>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello

I have a supermicro server which is flooded of kernel message:
ahci 0000:e6:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0055 address=0xa14a4000 flags=0x0070]

The server works perfectly anyway.
It happens with official ubuntu kernel vmlinuz-6.8.0-51-generic.
I tried also a custom 6.12.6, same problem.

I tried to update bios, no change.
I tried iommu=soft, no change.

I dont know what to do next.

Regards

for d in /sys/kernel/iommu_groups/*/devices/*; do n=${d#*/iommu_groups/*}; n=${n%%/*}; printf 'IOMMU group %s ' "$n"; lspci -nns "${d##*/}"; done
IOMMU group 0 60:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 100 c2:00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD/ATI] Device [1002:14a1]
IOMMU group 101 c3:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AMD/ATI] Vega 20 [Radeon VII] [1002:66af] (rev c1)
IOMMU group 102 c3:00.1 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI] Vega 20 HDMI Audio [Radeon VII] [1002:ab20]
IOMMU group 103 c5:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Function [1022:148a]
IOMMU group 104 c5:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PTDMA [1022:1498]
IOMMU group 105 c6:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Reserved SPP [1022:1485]
IOMMU group 106 c6:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PTDMA [1022:1498]
IOMMU group 107 a0:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 108 a0:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 109 a0:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 10 60:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B] [1022:1484]
IOMMU group 110 a0:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 111 a0:05.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 112 a0:07.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 113 a0:07.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B] [1022:1484]
IOMMU group 114 a0:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 115 a0:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B] [1022:1484]
IOMMU group 116 a1:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Function [1022:148a]
IOMMU group 117 a1:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PTDMA [1022:1498]
IOMMU group 118 a2:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Reserved SPP [1022:1485]
IOMMU group 119 a2:00.1 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Cryptographic Coprocessor PSPCPP [1022:1486]
IOMMU group 11 61:00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [1022:14c7]
IOMMU group 120 a2:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PTDMA [1022:1498]
IOMMU group 121 a2:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Starship USB 3.0 Host Controller [1022:148c]
IOMMU group 122 80:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 123 80:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 124 80:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 125 80:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 126 80:05.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 127 80:07.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 128 80:07.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B] [1022:1484]
IOMMU group 129 80:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 12 62:00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD/ATI] Device [1002:14c8]
IOMMU group 130 80:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B] [1022:1484]
IOMMU group 131 81:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Function [1022:148a]
IOMMU group 132 81:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PTDMA [1022:1498]
IOMMU group 133 82:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Reserved SPP [1022:1485]
IOMMU group 134 82:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PTDMA [1022:1498]
IOMMU group 135 82:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Starship USB 3.0 Host Controller [1022:148c]
IOMMU group 13 63:00.0 Display controller [0380]: Advanced Micro Devices, Inc. [AMD/ATI] Aldebaran [1002:740f] (rev 02)
IOMMU group 14 64:00.0 PCI bridge [0604]: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge [1a03:1150] (rev 04)
IOMMU group 14 65:00.0 VGA compatible controller [0300]: ASPEED Technology, Inc. ASPEED Graphics Family [1a03:2000] (rev 41)
IOMMU group 15 66:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Function [1022:148a]
IOMMU group 16 66:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PTDMA [1022:1498]
IOMMU group 17 67:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Reserved SPP [1022:1485]
IOMMU group 18 67:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PTDMA [1022:1498]
IOMMU group 19 40:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 1 60:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 20 40:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 21 40:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 22 40:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 23 40:05.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 24 40:07.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 25 40:07.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B] [1022:1484]
IOMMU group 26 40:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 27 40:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B] [1022:1484]
IOMMU group 28 41:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Function [1022:148a]
IOMMU group 29 41:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PTDMA [1022:1498]
IOMMU group 2 60:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 30 42:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Reserved SPP [1022:1485]
IOMMU group 31 42:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PTDMA [1022:1498]
IOMMU group 32 20:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 33 20:01.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse GPP Bridge [1022:1483]
IOMMU group 34 20:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 35 20:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 36 20:03.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse GPP Bridge [1022:1483]
IOMMU group 37 20:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 38 20:05.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 39 20:07.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 3 60:03.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse GPP Bridge [1022:1483]
IOMMU group 40 20:07.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B] [1022:1484]
IOMMU group 41 20:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 42 20:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B] [1022:1484]
IOMMU group 43 22:00.0 Ethernet controller [0200]: Broadcom Inc. and subsidiaries BCM57416 NetXtreme-E Dual-Media 10G RDMA Ethernet Controller [14e4:16d8] (rev 01)
IOMMU group 43 22:00.1 Ethernet controller [0200]: Broadcom Inc. and subsidiaries BCM57416 NetXtreme-E Dual-Media 10G RDMA Ethernet Controller [14e4:16d8] (rev 01)
IOMMU group 44 23:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Function [1022:148a]
IOMMU group 45 23:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PTDMA [1022:1498]
IOMMU group 46 24:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Reserved SPP [1022:1485]
IOMMU group 47 24:00.1 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Cryptographic Coprocessor PSPCPP [1022:1486]
IOMMU group 48 24:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PTDMA [1022:1498]
IOMMU group 49 24:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Starship USB 3.0 Host Controller [1022:148c]
IOMMU group 4 60:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 50 00:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 51 00:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 52 00:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 53 00:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 54 00:05.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 55 00:07.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 56 00:07.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B] [1022:1484]
IOMMU group 57 00:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 58 00:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B] [1022:1484]
IOMMU group 59 00:14.0 SMBus [0c05]: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller [1022:790b] (rev 61)
IOMMU group 59 00:14.3 ISA bridge [0601]: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge [1022:790e] (rev 51)
IOMMU group 5 60:05.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 60 00:18.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Milan Data Fabric; Function 0 [1022:1650]
IOMMU group 60 00:18.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Milan Data Fabric; Function 1 [1022:1651]
IOMMU group 60 00:18.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Milan Data Fabric; Function 2 [1022:1652]
IOMMU group 60 00:18.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Milan Data Fabric; Function 3 [1022:1653]
IOMMU group 60 00:18.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Milan Data Fabric; Function 4 [1022:1654]
IOMMU group 60 00:18.5 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Milan Data Fabric; Function 5 [1022:1655]
IOMMU group 60 00:18.6 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Milan Data Fabric; Function 6 [1022:1656]
IOMMU group 60 00:18.7 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Milan Data Fabric; Function 7 [1022:1657]
IOMMU group 61 00:19.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Milan Data Fabric; Function 0 [1022:1650]
IOMMU group 61 00:19.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Milan Data Fabric; Function 1 [1022:1651]
IOMMU group 61 00:19.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Milan Data Fabric; Function 2 [1022:1652]
IOMMU group 61 00:19.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Milan Data Fabric; Function 3 [1022:1653]
IOMMU group 61 00:19.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Milan Data Fabric; Function 4 [1022:1654]
IOMMU group 61 00:19.5 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Milan Data Fabric; Function 5 [1022:1655]
IOMMU group 61 00:19.6 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Milan Data Fabric; Function 6 [1022:1656]
IOMMU group 61 00:19.7 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Milan Data Fabric; Function 7 [1022:1657]
IOMMU group 62 01:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Function [1022:148a]
IOMMU group 63 01:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PTDMA [1022:1498]
IOMMU group 64 02:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Reserved SPP [1022:1485]
IOMMU group 65 02:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PTDMA [1022:1498]
IOMMU group 66 02:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Starship USB 3.0 Host Controller [1022:148c]
IOMMU group 67 e0:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 68 e0:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 69 e0:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 6 60:05.2 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship PCIe GPP Bridge [1:0] [1022:149a]
IOMMU group 70 e0:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 71 e0:05.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 72 e0:05.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship PCIe GPP Bridge [1:0] [1022:149a]
IOMMU group 73 e0:07.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 74 e0:07.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B] [1022:1484]
IOMMU group 75 e0:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 76 e0:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B] [1022:1484]
IOMMU group 77 e1:00.0 PCI bridge [0604]: Pericom Semiconductor PI7C9X2G404 EL/SL PCIe2 4-Port/4-Lane Packet Switch [12d8:2404] (rev 05)
IOMMU group 78 e2:01.0 PCI bridge [0604]: Pericom Semiconductor PI7C9X2G404 EL/SL PCIe2 4-Port/4-Lane Packet Switch [12d8:2404] (rev 05)
IOMMU group 79 e2:02.0 PCI bridge [0604]: Pericom Semiconductor PI7C9X2G404 EL/SL PCIe2 4-Port/4-Lane Packet Switch [12d8:2404] (rev 05)
IOMMU group 7 60:07.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 80 e2:03.0 PCI bridge [0604]: Pericom Semiconductor PI7C9X2G404 EL/SL PCIe2 4-Port/4-Lane Packet Switch [12d8:2404] (rev 05)
IOMMU group 81 e4:00.0 Ethernet controller [0200]: Intel Corporation I350 Gigabit Network Connection [8086:1521] (rev 01)
IOMMU group 82 e4:00.1 Ethernet controller [0200]: Intel Corporation I350 Gigabit Network Connection [8086:1521] (rev 01)
IOMMU group 83 e6:00.0 SATA controller [0106]: Marvell Technology Group Ltd. 88SE9230 PCIe 2.0 x2 4-port SATA 6 Gb/s RAID Controller [1b4b:9230] (rev 11)
IOMMU group 84 e7:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Function [1022:148a]
IOMMU group 85 e7:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PTDMA [1022:1498]
IOMMU group 86 e8:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Reserved SPP [1022:1485]
IOMMU group 87 e8:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PTDMA [1022:1498]
IOMMU group 88 c0:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 89 c0:01.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse GPP Bridge [1022:1483]
IOMMU group 8 60:07.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B] [1022:1484]
IOMMU group 90 c0:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 91 c0:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 92 c0:03.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse GPP Bridge [1022:1483]
IOMMU group 93 c0:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 94 c0:05.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 95 c0:07.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 96 c0:07.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B] [1022:1484]
IOMMU group 97 c0:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU group 98 c0:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B] [1022:1484]
IOMMU group 99 c1:00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD/ATI] Device [1002:14a0] (rev c1)
IOMMU group 9 60:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]

