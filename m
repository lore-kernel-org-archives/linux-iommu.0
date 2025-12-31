Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABB9195811
	for <iommu@lists.linux.dev>; Wed, 31 Dec 2025 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767181613; cv=none; b=d+3wlBuCZfCykI+UFgCoT7tWVfxfxu/2tgos9obzEJH6a9FfAaFYscJLLhv2fqd4SKjBJ+Y6veNdE0EQQYmiUzMPOjTrGYACA7OJ4Gs07xeQ2H9xrn7kDI+MGfGnkohl8U2KGa3swMX/86DzGRY38au8pxpX7SePTX9Mwx8NngY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767181613; c=relaxed/simple;
	bh=icq8oBIEZNaQtIkrr06l10gJ4Zw/eBRVfxPi1bY6H4A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZmUNDCFPbAs6cP3rJtbTC386Eg8BN+mVKogwVYO+tekf0CU3TYQtNOaPBwgJMnXVbZTSDq7z3ku5gggUVyFn3P+y/aZVydpBHbd6Rk+kpRVkCg2fMzc6ywa0f7y1rqEG/i+t0rlF6DdzkfvuSipw6uTZ3P7Mf9FyTSB0ZQzhPWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pc/3j/8M; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PsS54rLe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pc/3j/8M";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PsS54rLe"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BV5VMfC3539503
	for <iommu@lists.linux.dev>; Wed, 31 Dec 2025 11:46:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=4wtWHNdnj7HyKUYlv7R3RCMlZrGCa91AdJN
	fLl31hIg=; b=Pc/3j/8MXvYKxrjNdU2v/W/5qOguj97a6O6xODTlvuo9ss+ENAd
	NxOsSQlFJ8fTsevXk23r19kCxnsC91RRlox4RHta42i0n9YEvigjr8SQzgmMIw+3
	zR5wqaiEuyc0arBPelZYKw9yvIbFdnf58f7aK/ND0eMg23YZxZ7zMMRl2pwJGNG0
	pIp9xBd5QKm3i6j5nKp6KLbNN523kh48pED0fPZHv/wtiaTDkBfKb2WiKmQzWFyc
	eLvnzkP8BY/tC4p+g3WkQpvz1gazy4ziEIjZCFVAA1Iducwr7hGnpPIVhCTwHF09
	VL9bzG/GWKtzbpXEAQS2gc4n/sWTqTNFoeQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc88ykfdw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 31 Dec 2025 11:46:51 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7fc82eff4adso9689842b3a.1
        for <iommu@lists.linux.dev>; Wed, 31 Dec 2025 03:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767181611; x=1767786411; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4wtWHNdnj7HyKUYlv7R3RCMlZrGCa91AdJNfLl31hIg=;
        b=PsS54rLeDc0I0UbzNJ7GFi4ROm5ry9t2j18ORovtz5O3F8dDmpe7h9seEyY9HOaQZd
         ALNJJYEOvtsWDMD1kT4VQZPxZVO32Pmo8LiyMC0zmjm/H4j3vk2l1ViW2oCfEWG3EOYQ
         wuFCL8YmxhXaLaUI/gHy8SU09rj4v62Ut5K48ZBr4QIgJY4+XzMReeP+zkvDjhuyyRmt
         D5lymb6uOtIz7GsAqAz6qp21cO0bX/ixc6wAac7Ox3MNTp1u71ze4UILDR7etVxKhgHO
         tw6waqV/V1gwCaMojXO20aeli++Ruo1Rr9TTUdbAYcE/I2M+KUk7NpX/FBMbCG4owuSo
         KWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767181611; x=1767786411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wtWHNdnj7HyKUYlv7R3RCMlZrGCa91AdJNfLl31hIg=;
        b=WRHZW3j8Xjo5q2j+XNSKWVaBt/TSHU30b61jLW5eJ6/3wuUZNLAFeJLU+CpV6EWnGt
         1Wk9Jm9vPkHDpsMQMYNWmehF3tpMQji6o/nEGI01NHcL2MtEa7aucWwAlAcvZpp9e2/l
         PqWsG1Drl94ohEOeaPpnbbiN8uYENUkdvmiYjpBtaJ4SrMMTZRizkjBPiWyfScp7garC
         DbeF4zufv/c2gUOFUK0C2Ay83t8LX7cdPQ/QfFIWplZvqI4k7COHwOYE0PeD0abLy1fy
         NWzpo9Us3e0zK8GwYGSaBTX0z/46z9FNQuxB2WD266U+GiTmBWvDJ8hB6GswX8gWpElp
         j3pg==
X-Gm-Message-State: AOJu0YzJifznN6dWBf2Xnk8qMjv1I4tVpqo4khyrMuWtbjpeLhL+hUJs
	FdDkGU+FRfqh9bSajMoXzD+6f+187SZZLSati/iGTsImdTyge1Ll/USob46/yAwQBY3FzQ3F43H
	mOcSqbhFJpxR61sBqctkuP9nyeuTBaylqEGclNpU3eYiV2N3CZBiGv80q/Q==
X-Gm-Gg: AY/fxX7fNsZYEKVy+osjP+M5LyIN1ogpg7J4jVq6E/NbWOjGlMrkvvB8MhRbDynI0Tu
	eSqNdgetU2wjdYWMft3PM3oTyFztIU7jntqrjmw/B2kmwvgog6VVm7juUZ88WPpCqopuF6iSDDO
	R78PPZhxUzuyWUqqTCBfaLbXiE5PGK9zJG7PwlsdiusXBR1NcS5bhBVnkIvMEF+x2okP7Uc+Xmo
	KQMe3zbvEqRq4rLh9i5tga1b6ujqv6fAESnaH6lqBYy/BoTEyw1qnQ06ZTz/L/F7LIxhmEAfUcp
	WqjkewyVXJgwyAVCE9m8TGczJ+yiUBGP/VNKeKYXRrOwSN64HFlzdFuDILWeL1RSa4CbHPTGMWH
	m/sRUu8ZVwvUIH2uAt/+xKGmJZiM4LsJY1Vy/8rYZ20f1
X-Received: by 2002:aa7:9903:0:b0:7e8:3fcb:9b0b with SMTP id d2e1a72fcca58-7fe0e8319bfmr26682348b3a.33.1767181610552;
        Wed, 31 Dec 2025 03:46:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEX6tTbQ8KPqPgNAZDRaZLP755a6vpD2bOtPWLbcWFcrVkWypmZyp5jk16RRr/0AuUA24MjKw==
X-Received: by 2002:aa7:9903:0:b0:7e8:3fcb:9b0b with SMTP id d2e1a72fcca58-7fe0e8319bfmr26682339b3a.33.1767181610001;
        Wed, 31 Dec 2025 03:46:50 -0800 (PST)
Received: from hu-vjitta-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7b5236b5sm34815656b3a.29.2025.12.31.03.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 03:46:49 -0800 (PST)
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
To: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, robh@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, bod@kernel.org, conor+dt@kernel.org,
        krzk+dt@kernel.org, saravanak@google.com,
        prakash.gupta@oss.qualcomm.com, vikash.garodia@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Subject: [PATCH v4 0/3]  of: parsing of multi #{iommu,msi}-cells in maps
Date: Wed, 31 Dec 2025 17:12:54 +0530
Message-Id: <20251231114257.2382820-1-vijayanand.jitta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=POcCOPqC c=1 sm=1 tr=0 ts=69550d2b cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=bPDH9HW4QdDYPu8zaOwA:9
 a=zc0IvFSfCIW2DFIPzwfm:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 82CWqWEcvYWJWErfCFYHEy-VYRDSz9iu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDEwMyBTYWx0ZWRfXy9xtamFzyed3
 drwK6EueTKHFX4YJKoIUKrZ5S9thzw0XwamOyg5KID6B8OnUBmn+QTXcN/lMp9gueI23U3SRA3a
 LWRYbM3eXKCe7AO1/eHO+BHennYiEhy75QaVO+CW0Dzx9chz1rJlmErQ+K4e/255D4oTabvzWZ5
 hVqzBozOaa3y6U1Rl6z1YFlLku14sHd8vrF5UeN0SGFC0lEI2G9WOacqk/AJ0FyiNoVj6TtN7Uk
 pr22k5G/fVWlA5HU77PZ+QOaUQlMtJ+hrM0U/RRgF6+hb7ZUpLCDxifMc2bcSMSFlXx81+KByGg
 qa7UYFyzt5+oPFJdrbUFilSCtyFQPPkqyBBchVLKNvSNaM8SFJPXP70l4DCKP38SK2sIo2xhTYm
 UMe2mV4Tsmu2LK1nLJ4SKi7xR9cIjT79S503YKBrw0woIB7mTbyMW9gM5Mpg6HV1B+0VqXJ9qDj
 r/qS+U6tMGzej1Pf+9w==
X-Proofpoint-GUID: 82CWqWEcvYWJWErfCFYHEy-VYRDSz9iu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_03,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512310103

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
plan to perform more extensive testing based on community feedback.

[1] https://lore.kernel.org/all/20250627-video_cb-v3-0-51e18c0ffbce@quicinc.com/

V4:
  1) Added Reviewed-by tag.
  2) Resolved warnings reported by kernel test bot, minor code
  reorganization.

  Link to V3:
  https://lore.kernel.org/all/20251221213602.2413124-1-vijayanand.jitta@oss.qualcomm.com/

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
 drivers/iommu/of_iommu.c                 |  12 +-
 drivers/irqchip/irq-gic-its-msi-parent.c |   4 +-
 drivers/of/base.c                        | 145 +++++++++++++++++------
 drivers/of/irq.c                         |   3 +-
 drivers/pci/controller/dwc/pci-imx6.c    |  10 +-
 drivers/pci/controller/pcie-apple.c      |   6 +-
 drivers/xen/grant-dma-ops.c              |  21 ++--
 include/linux/of.h                       |  36 +++++-
 9 files changed, 169 insertions(+), 71 deletions(-)

-- 
2.34.1

