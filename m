Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F3423B62C
	for <iommu@lists.linux.dev>; Sun, 21 Dec 2025 21:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766352984; cv=none; b=XPbah8z+MB3pDUzjnmjjgNqzotyYb+iScuhzGZAu5NQtTZJli+144NAojn3CXuyA7V1ISyx5kGjacciukK0TEJuNA7XsErbfdiiedKY3pE9lrH5DbTWYV2+ohrPg72kuMQyHQSGqBUiBoesGMNrgJfv3b9fWeNmVgFaKSpVbTNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766352984; c=relaxed/simple;
	bh=b110ENDdUgcv9jO9PdxYXwCXg9CPeAc4gSTCvASmh3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hVNLGlnd7Riqjt3H1YdEt3ucU6WVys/9Qo8ylXMlGtJal08aVaMWq4cOGlxIWckJZZaCe0LsVt06waxYvrb951rCoyA9PRX4zoYxGsIEcYmSsaeBs9Sgd5DDz5+fcvPxwVQDDKVsw869e2hIvKqJ4d9JusiyJxgKhTlzGTOW80g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J7lyaHVn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fuLlCVk1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J7lyaHVn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fuLlCVk1"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BLKu7CD3889754
	for <iommu@lists.linux.dev>; Sun, 21 Dec 2025 21:36:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Bugy/ehY+LAtGgbSuucEifamuoZZZHBlyip
	0eUiB9DI=; b=J7lyaHVnWr0thJntlo/HSC/3It0cPggFJdULoNHmTOzV51J4Lcg
	rc059s5LdsxWeM9vC+k1h0tmov4+b325Eov+dgrzXIVV77UmvV4mThxTe4XwFmL1
	FQXcR9MFL59EDWeX0uf9Lyblwo5n0+kTwWCtlGSE6tByowfJ19cyvU4ha4ZmQ2qG
	12p/EGNwktVGQXSGJ3JSUM10xOeQ47mIWcyu4nwYuTThuz2At7Bb5p3oUuMLLN5h
	iHHbiGe236W606yZNLuT11ZaPJO0FxjrvaAHNExOSLkDyEyTcpLDmHBtTLYw70N+
	ykJ0I9IlETFvhfJuKy4GbAtdI/dGCeHl77w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b5mvfjw1r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 21 Dec 2025 21:36:21 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34ab8693a2cso9217534a91.0
        for <iommu@lists.linux.dev>; Sun, 21 Dec 2025 13:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766352981; x=1766957781; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bugy/ehY+LAtGgbSuucEifamuoZZZHBlyip0eUiB9DI=;
        b=fuLlCVk15S36ktLaKJ1Uy3eBv/RZMzLtyRoFUoxrmg/Y6WQngGSBt4qkh9rOMn/aa4
         O2J0WEjNy+LECLuvOsV7KD4SW8gbEzcW9nLbZtwXqKq/yIW9iZtdtvV1IHYXxHGW6ZI5
         PAqUHZcpFSurhSrJ0hK0RMShsDMjODiOwBTt6pKOy4viIwbmLiHNqeSTisvng1Nzt7zA
         kEgtJnIz7aOkJfCjzPlcwPYQ4U0rJj7UgjIaXmi1M97GEwiKrs9VfV537SJSzb6Ut5cs
         qG+MgRVx1NQ5QKJvK6SZtIMXPnHpoZ/HYiDv0Ou7xHFFUeJFtoxv53RoCEcs+AeCQApQ
         DoIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766352981; x=1766957781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bugy/ehY+LAtGgbSuucEifamuoZZZHBlyip0eUiB9DI=;
        b=gj+5FYF1QQ+zK/VfBBu1g0w9lcuVlOGMptJXtvqYTz/NHtcHWtVHenEa8HSNqTVRyU
         L4h595RpBkE6AC3/deHafNagwQ5/B/fPLQkFyAsvmfggIAV3sGSARsYwAIHNJvR6QrHB
         UKJP3oZtulHUmzSBrJMlA0Wrk2XFIx7DPLMzCvC+lQ/vUOQK4D1GspbWEVQtks0u5hkF
         tFyqFMjW0Jb2TI0OCl+dTtmogTyCOeK4/9PNnGdUbK66GW8+byiwwXncU26rLg9v+PUz
         QHfaiVbLmcPn3lDyO1DuWCHLqFEw8GKG6RK50aJKKt0JM+N97kZXf9AQjOW64DG/MN+f
         Keaw==
X-Gm-Message-State: AOJu0Yy1V7l9qUHuwRa+2NRZfIGaeOeoiqJ5DTElywS626XG318ZfaPV
	uuL33CTKBpOGfCtmYs7ibK7VbSytDvUKON1DrFL0RiVOflGgaN/6vsfWotlPVR1PZ9ierTsZJsC
	kmrpDpZ6GnM7vo7qa5LhP0p39nAEFkKrVWoWD6pDI3Y8fma1yaTiGv9RWrg==
X-Gm-Gg: AY/fxX6M99F+1xnLrjU/7Ifr8ml3tDFoNUPdbpyfWJ4eKaRkmWBm0MEfQt2zHCcpLrI
	wkLx9aIA612jiUtzOVJdMYdmCFehBgVXO/Va9ZDTg6bS1Jj491m3mh0pagLl2PyqBTwtoncOu0t
	2E8LNhSQ9WShijnhczV/ujX8WEgS+h5Cyx2IvKXApBGq64u8VbG44Wl2memmkmkhDw7QS7CAgQx
	f48HNecHrcpH2Rvelof1ov+iFrH+eN3L3tpwmY8rIiEx7Y8RgCgd7GlV5kJ7OlleIESO+OcYUU2
	tI1BF5Or4g1cInWcrpueJDH4c6IsAAW5yjsmK4tXjnbj4H4nti7d+TxHuFgPuHFW0SDNlbzjE1s
	lM0M5XqXkcLCTmOi22ehiKcNlCF+iC42ctgz+ePg3nC38
X-Received: by 2002:a17:90b:28cf:b0:339:ec9c:b275 with SMTP id 98e67ed59e1d1-34e92121d91mr8051936a91.6.1766352981080;
        Sun, 21 Dec 2025 13:36:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfS6eBZ1q2a9KqwpQ0uemvbQt/xtjJ1P6fFJMLIXJZ3eTW5mCzUy//k9JpPpmjSw8Lx9O9HQ==
X-Received: by 2002:a17:90b:28cf:b0:339:ec9c:b275 with SMTP id 98e67ed59e1d1-34e92121d91mr8051924a91.6.1766352980591;
        Sun, 21 Dec 2025 13:36:20 -0800 (PST)
Received: from hu-vjitta-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70dcc7c8sm10950163a91.15.2025.12.21.13.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 13:36:20 -0800 (PST)
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
To: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, robh@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, bod@kernel.org, conor+dt@kernel.org,
        krzk+dt@kernel.org, saravanak@google.com,
        prakash.gupta@oss.qualcomm.com, vikash.garodia@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Subject: [PATCH v3 0/3] of: parsing of multi #{iommu,msi}-cells in maps
Date: Mon, 22 Dec 2025 03:05:59 +0530
Message-Id: <20251221213602.2413124-1-vijayanand.jitta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=H8rWAuYi c=1 sm=1 tr=0 ts=69486856 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=eQMVBvNRXY1Htgy04vAA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Yxl07t_SgvgQE86UdRl1xhA_36h_S5HC
X-Proofpoint-GUID: Yxl07t_SgvgQE86UdRl1xhA_36h_S5HC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIxMDIwNCBTYWx0ZWRfX/z7SNT6RwFew
 KmYuRk7XDpRqfGO0WZB1WL1/kmsPHmB3q9GwQetXvj958Em2tlq6qfzgG8CJABibETxJEvi8Czl
 hl3Smi+ku7qTQrgodfa2EV0frLAoE7uQzMfF20SWkllB3TflAM3WrD3YEGyH5IxIxAcYD2aHSdg
 4sVlz2PSrttBA1cMRCy0Z4cXbtD7sYjxu5JFIPArNAvO8PQEM4F/AReDuJQPaBuHVE8/065Hxjn
 Qeoq6sOIkh5otGJl8E1tWh3MqVlvLLasyoDJ4J0gNNwSk7DuznTcLf+51FbZb2iPbBXeiy48rJS
 RCohiIaa91/HU2zmYq8STIE5HIGq/am6goAHNXGAKVLJy1PCuiVHYfs+6xN02Hr90UEFarwgwN6
 QH5ayxX8CFVF6l43CxH2JtWiTvXx6UBvzWpbflv4xiPnEpTaTBt/vhF8tihiEmQ8ncsM9KxaYCK
 uOh6tEbxgtgrUgaNKGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512210204

So far our parsing of {iommu,msi}-map properites has always blindly
assumed that the output specifiers will always have exactly 1 cell.
This typically does happen to be the case, but is not actually enforced
(and the PCI msi-map binding even explicitly states support for 0 or 1
cells) - as a result we've now ended up with dodgy DTs out in the field
which depend on this behaviour to map a 1-cell specifier for a 2-cell
provider, despite that being bogus per the bindings themselves.

Since there is some potential use[1] in being able to map at least
single input IDs to multi-cell output specifiers (and properly support
0-cell outputs as well), add support for properly parsing and using the
target nodes' #cells values, albeit with the unfortunate complication of
still having to work around expectations of the old behaviour too.
							-- Robin.

Unlike single #{}-cell, it is complex to establish a linear relation
between input 'id' and output specifier for multi-cell properties, thus
it is always expected that len never going to be > 1. 

The motivation for this patchset originates from the multi-map use case
described in V1, which will be addressed in a subsequent series once the
current fixes for iommu-cell handling are concluded.

These changes have been tested on QEMU for the arm64 architecture. We
plan to perform more extensive testing based on community feedback and
are sending this series out early to gather review comments.

[1] https://lore.kernel.org/all/20250627-video_cb-v3-0-51e18c0ffbce@quicinc.com/

V3:
  1) Added Reviewed-by tag.
  2) Updated of_map_id_args struct as a wrapper to of_phandle_args and
  added comment description as suggested by Rob Herring.

  Link to V2:
  https://lore.kernel.org/all/20251204095530.8627-1-vijayanand.jitta@oss.qualcomm.com/

V2:
  1) Incorporated the patches from Robin that does the clean implementation.
  2) Dropped the patches the were adding multi-map support from this series
  as suggested.

V1:
 https://lore.kernel.org/all/cover.1762235099.git.charan.kalla@oss.qualcomm.com/

RFC:
 https://lore.kernel.org/all/20250928171718.436440-1-charan.kalla@oss.qualcomm.com/#r

Charan Teja Kalla (1):
  of: factor arguments passed to of_map_id() into a struct

Robin Murphy (2):
  of: Add convenience wrappers for of_map_id()
  of: Respect #{iommu,msi}-cells in maps

 drivers/cdx/cdx_msi.c                    |   3 +-
 drivers/iommu/of_iommu.c                 |   9 +-
 drivers/irqchip/irq-gic-its-msi-parent.c |   4 +-
 drivers/of/base.c                        | 147 +++++++++++++++++------
 drivers/of/irq.c                         |   3 +-
 drivers/pci/controller/dwc/pci-imx6.c    |  10 +-
 drivers/pci/controller/pcie-apple.c      |   6 +-
 drivers/xen/grant-dma-ops.c              |   5 +-
 include/linux/of.h                       |  36 +++++-
 9 files changed, 161 insertions(+), 62 deletions(-)

-- 
2.34.1

