Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A0F345724
	for <iommu@lists.linux.dev>; Sun,  8 Feb 2026 06:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770532738; cv=none; b=JQtytZ7ATMZO7qc7eYoqWledE/JWid7iqZSeARqNM8ztHZsXaG3rqke03Qy3teauSZJf/dNiXW/VUhsVp+mJ+yyT5bmvRjleJxGl+xvTTuJLWjkrU+qyCVOWIYF928rqbI/qZG1HmQCPSHn45Sm/ojf8qzaqOZTYX28lmszQ5Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770532738; c=relaxed/simple;
	bh=lnMMOUMy31nqFoghRVvX8VIe6miKik5AX/BmRvZnkyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rmsTZEY7mbxJA+rySYOcZbJQY9VtF/02UKlVRs29fRzkd+07ubkM6dmpLwdPnxSK0cEI/rtkn/L+s+p9fBJgPqgtYmskrQ861a8IsftizndqIEdFNqEX394R4CSxpecjaoV/lJN/KsYPeBhptZq97eaRyjQztTQea82erM9CEOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=YBVRNwdm; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YBVRNwdm"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1248d27f293so8838290c88.0
        for <iommu@lists.linux.dev>; Sat, 07 Feb 2026 22:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1770532737; x=1771137537; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cj7VDyEmyttJ6U7k+eNuSHRKVocJsp9GVC83IsF+hRI=;
        b=YBVRNwdm1ehL0S6tgOluZcYAqV7FFUqjHJLIcJRPap+wemFMI21HD0A+5nAsYZiCfv
         oYEg0210mDT3EicpplPjYVl94kDQMQRqC/n24OLXmtJGdOMcUmxup9brvn4Mu0c0fN5J
         pQth7HmLXgr1ytqGew7RepY3XCzp75NItYx34fW8yduhiUROx6Tb9Yd2ViYEbQei6Ruf
         fkh8suwNZ9c+fBkyZBBUZbrW/1VjouNNQNgLgv6WrwN3Bhvx0myffn3Nw4a2CDuArZhO
         54spsJfwMtcBUCaS62ufUTDv4kaMcMzsAZLisVRgRNkV1JBuYRidJ8/d/JglgYwCfdqY
         z5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770532737; x=1771137537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cj7VDyEmyttJ6U7k+eNuSHRKVocJsp9GVC83IsF+hRI=;
        b=kY20+ZbGVnhnkjg3VrVwRjOyHcoVsRKqx2u3CEgRUhK2ZWdhf9RV9dZitFE50t7lv5
         qcZ6IVgZ2VtiexZI+4tPq2jv4bQNn0Yr14GB7t2lqQNV4AsrUZUiy6xkxPviBlf+zzqD
         ceEIAiuTp5oBjPD3lSXmMeyVogtItfn38uhrKBklbI0UWpLHZPBc5UYfglZY/9SCERqo
         BsGAhy6/OEHcTCelr6XZF5JvMN4OLomZuGnGwbUjRcpRagS9PYrhhYY/PM0wvD3FJGc3
         DTDkayYeadkPYnw0At7YGsBHQQu5nALKwAe1spXvdiptckNJNDKxL7PbnUdo4Kn3ETmC
         b/MA==
X-Forwarded-Encrypted: i=1; AJvYcCUhGu5y2jjVguHvUyT//+tA6INVam1/Ry0a/Z5DH1CJFvlm0Y0xg48b/SADmEXGOY6+LLiDbQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyxy1WwGeg0sXacMBfzXd9hG19X6IpN28l5aem51Um6EJrpsX4I
	seuj1hLpAdTmXQul2htM49+tugNdpxOFQ+af6rW1ezyEfnjheF9NaB2Rz0rVUShggLo=
X-Gm-Gg: AZuq6aKoZNr0qqP8huW6Hlq3nqwCXus8ymCp3ZTDHjli+dpkEqVdAVuhm6cN1Gxq2QV
	tulg22dR58jEB/XmWC0COwJQZdLzlw7ysdTcxYU/M97VYu6fSbFDLUdIFhTWJfv0m2H9n3zQ5at
	xUcPcFsRQL6SG9WXca6SL3u9i0HjIDljr4O2G+/kWrIe4puQ1uusXCWHfEbM5VD8NtY56O0eyjk
	OBljRY2nhP+qq02X2KG+SdVO2rz5hG/oX5XnTRrigcoSbNojk3mcLFHGdXiKh7vq/CbBF4PnkH0
	LF6ZLtHJHjghp2JZwCtOn5ln4PIJ9OY13YSHeSrSxHgGT21nFfJ5u+zeQgCDQxziVjlWOHXvuyT
	YCU2+zvS9vosZeatwSHFFFNUFGJufUo1kCoJF+ZQrpcuBg1h7wvyMQsl/6VGdQRA13NCLWhnYYp
	FarHpgJ++aFJRioAOPVsWLKJk=
X-Received: by 2002:a05:7022:6894:b0:122:153:d161 with SMTP id a92af1059eb24-12704001972mr4399912c88.17.1770532736689;
        Sat, 07 Feb 2026 22:38:56 -0800 (PST)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1270c9ff2bcsm5114647c88.1.2026.02.07.22.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 22:38:54 -0800 (PST)
From: Zong Li <zong.li@sifive.com>
To: tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	robh@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	mark.rutland@arm.com,
	conor+dt@kernel.org,
	krzk@kernel.org,
	guoyaxing@bosc.ac.cn,
	luxu.kernel@bytedance.com,
	lv.zheng@linux.spacemit.com,
	andrew.jones@oss.qualcomm.com,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Cc: Zong Li <zong.li@sifive.com>
Subject: [PATCH v2 0/2] RISC-V IOMMU HPM support
Date: Sat,  7 Feb 2026 22:38:34 -0800
Message-ID: <20260208063848.3547817-1-zong.li@sifive.com>
X-Mailer: git-send-email @GIT_VERSION@
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series implements support for the RISC-V IOMMU hardware performance
monitor.

The RISC-V IOMMU PMU driver is implemented as an auxiliary device driver
created by the parent RISC-V IOMMU driver. The child driver can obtain
resources and information from the parent device, such as the MMIO base
address and IRQ number.

Custom event support is not included in this series and will be submitted
as a separate series. The idea is that custom events will be defined
through the driver data of the auxiliary driver. When the parent IOMMU
driver creates the auxiliary device, it should pass a vendor-specific
name as the device name in order to match the corresponding auxiliary
device ID.

After my initial RFC and the v1 patch series were posted, similar patch
series also appeared on the mailing list.

One was from Yaxing Guo:
https://lore.kernel.org/all/20250915020911.1313-1-guoyaxing@bosc.ac.cn/

and another from Lv Zheng:
https://lore.kernel.org/all/30C7AD351DB55276+a8b03dac-c5af-4034-8631-ac1c352a469f@linux.spacemit.com/

Yaxing has agreed to pause his series, as discussed here:
https://lore.kernel.org/linux-iommu/2ce9d8be-10b3-48dd-b99e-7358347fc171@bosc.ac.cn/

The motivation for sending this v2 version is not only to address the
feedback and suggestions from the previous round, but also to introduce
a major structural change: the PMU driver has been moved under
drivers/perf/, which has been mentioned repeatedly by several people.
This results in a different driver structure compared to my earlier
version and the other two series, and I'd like to gather feedback and
suggestions from the community on this approach. If the community would
prefer to go with Lv Zheng’s version instead, I am perfectly fine with
that as well.

Since I did not follow up closely on the patches from Lv Zheng, Jingyu
Li, or Yaxing, it is possible that this v2 series may miss some important
features or fixes from their work. Therefore, I would really appreciate
it if everyone could help review this v2 series and point out any
additional fixes or feature support that I may have missed.

Changed in v1:
- Rebased onto v6.19-rc8
- Pick all suggestions and feedbacks from v1 series
- Add cpu hotplug implementation to avoid race enablement
- Move PMU-related definition from header to c file
- Change PMU driver to auxiliary device driver

Changed in RFC:
- Rebase onto v6.13-rc7
- Clear interrupt pending before handling interrupt
- Fix the counter value issue caused by OF bit in the cycle counter.
- Invoke riscv_iommu_hpm_disable() instead of riscv_iommu_pmu_uninit()
  in riscv_iommu_remove()

Zong Li (2):
  drivers/perf: riscv-iommu: add risc-v iommu pmu driver
  iommu/riscv: create a auxiliary device for HPM

 drivers/iommu/riscv/iommu-bits.h |  61 ---
 drivers/iommu/riscv/iommu.c      |  20 +
 drivers/perf/Kconfig             |  12 +
 drivers/perf/Makefile            |   1 +
 drivers/perf/riscv_iommu_pmu.c   | 661 +++++++++++++++++++++++++++++++
 5 files changed, 694 insertions(+), 61 deletions(-)
 create mode 100644 drivers/perf/riscv_iommu_pmu.c

-- 
2.43.7

