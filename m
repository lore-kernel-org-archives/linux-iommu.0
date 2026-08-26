Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9176B44685D
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787755989; cv=none; b=MAliIwByi1ik77nTZckOENwPhBn0ps4A/zJWuyKvXqTYALteQ5XZgiGqSEZqaWtq1n/QxahvUYVg7pxOHxC1XAtaLCYwCRK92gxPsAY3O62H4ZWYcgF4TS5TfmtqYnQLx+VRscPIQTINYOXRPJS+MRF5ipRXyLq7xrkNasLjG4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787755989; c=relaxed/simple;
	bh=Sy5ZgzY6FQLduAzzhYOlwnqsjFfd4YIfVoRZ0ilt7a0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=czQUIkjQR3/HwjbpGjltiq0Kx63SEdqZAMRAKHzAaiuccH/XUut3lZRr51mxH1HdAq2SinNKRuhgMaTWMAvta8h8/ZoYfom3kDphmb0VBa9/SzcV2ITskwVXpM1JhZDITt4q5zqf5BvYoKdMvV6v1PAAgkPAYjALY999WwLKpso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F+1Je+5Q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YXX776Jq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F+1Je+5Q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YXX776Jq"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QDuYUM2148540
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 14:53:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=z7ZnCSa7tAwp+cP9IUoZgfr7dJPO9GpoqgH
	Fzr9DhUM=; b=F+1Je+5Qhf6sjrW2LGpDMBvkz9kiYwfC7ljZJoFtG19RotT1L4s
	hgROZxtikMbIthb4ZB6JDC3my8cvdaUtsTNI9KE+tf1nNUf3pPCIKQ7Zx1R/v20v
	4/VChZmw20DTSN93XOEvXmh3BBV0nEz527K/1khdLDH8by7frWgGY9RjdA5SguuU
	Jsw79gEzkBN6k/XaE4Vqxbvs9hmnxHF9LhiBm5IjmErYL3j/LbsVD+eaYpUcLDyz
	6hx7ptLKoQU59oYBEYWkkDns4ddTST6m3M8cyMljYTcl5wdcjHkZfdeM8mLb8KQ2
	VfR7jxL5lnMpDbOFp77RfhfCveih86k3e1Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9uq1ssqm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 14:53:05 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c0e702df8so15112461cf.2
        for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 07:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787755985; x=1788360785; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=z7ZnCSa7tAwp+cP9IUoZgfr7dJPO9GpoqgHFzr9DhUM=;
        b=YXX776JqOOnUjjBBF19ifrRJIAMTiJ4DlvAD2iapI9POkSc4Db3GkDOpzVDr4ZR+5R
         h9iKF0BrLQf2lCbnegTn9SAlVH5bPnBNZ85Tj7/Rrzpf6f3loMOg9+N5DuSOHMn3WcaK
         i/n313eITM9YodkcObwtyboD1eb2eCsqjKzn8TCZo42WmKvcv6xU8wDC2SXuP7bXTbDI
         eDZ0+lWc9HD7j+nqRF9C8cedVOAKeh3hblf7C6DOXswznSnKAY6RQ27AihIwy+BZL8v0
         wuS3zqnfETEKsIJ7lUhVJo2gV6ycYhi6g54/nMk05XKjL1EMzQPy8C1twjMtCsf45Vjc
         +yPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787755985; x=1788360785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z7ZnCSa7tAwp+cP9IUoZgfr7dJPO9GpoqgHFzr9DhUM=;
        b=lbJKXX1LFqphSFgaDBvivR2aC5FRHWmUaMAsl/PsJWaKt2jm5Ai9OM1nA/zKDf5vZJ
         /ttsPUp7UeC8VlHyHlFYpYAFBjFGcXX5AI8U8l0ehiXYqdJOnjskPpm7ITEdcuBt0YR+
         zvmzu0CAy817BramH2Qxl2qCyPipRETNYTvIbyvKrUUP8pcVuBeNRckOwKsYJJ/0wHat
         8C8eeKhmQf3Jm7xGVJdHnYf6Iq9JasOOaFYGVf7ZP4Q15pC3gXtRCQlAYdE0rk56ExhN
         fxiyaeB03fFToa9BqUkzsFTKFo5MSST1MwqhgKgbPZsy/1bn24Yj9323tNIPd/8XPzW4
         vcwg==
X-Gm-Message-State: AFuF++lDi2Wkjuge7EEcelhgji8RwkyDO71f8W7Sm2k9lA5+FjLpSe5k
	uYFV+a3vTiSbj3AmCx2nua/gn4eb6dre78x3L1i5mWdL/f4X2qnWKNTTfEBtLJSNYyjQbKhFlZ3
	6n0pPf0yMdUVcogfdgopiqb0Rs/LGrFWHuGDdqONB20GJtCi5D3cOWTNmpWH2cK0vQA==
X-Gm-Gg: AR+sD12LgciY+cEVSwnjAW7kg9U+8q+4C1hC3/bZtghJIl76oiR7Nc2vBFdONtCJGgF
	+bYq6cEZo+0p18F4GvNgLVxYvo5ahfEXvXVemQsjYDFwfkUFxrE+uxYj/HBcsGX8fjTcB7OmooL
	J9348oXhL7tc7kuMZOXcb6lUdZKd+ra1h3bixMIZVhIJY3qbQ0Qeix32GixNxyWQohkJ6E//2j4
	Ub6YKGQvXe99j0HN4GQNeBOqm5bh2zE289DAmthcRy21atRYS81KfCXh2a2mio3K37PKurmX6ck
	SxAX0xSTzesPebBSXRkd1L6BXV2FIvQf0FrT/TUjw8YHb76QhXKXYhFaz5OsgFDST6I0m2LaiJ2
	Q/vet0NuZ
X-Received: by 2002:a05:622a:598d:b0:52d:ce1e:cd47 with SMTP id d75a77b69052e-52e42234b46mr81547271cf.9.1787755984924;
        Wed, 26 Aug 2026 07:53:04 -0700 (PDT)
X-Received: by 2002:a05:622a:598d:b0:52d:ce1e:cd47 with SMTP id d75a77b69052e-52e42234b46mr81546391cf.9.1787755984400;
        Wed, 26 Aug 2026 07:53:04 -0700 (PDT)
Received: from localhost ([193.165.40.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e279eb11sm3089351f8f.8.2026.08.26.07.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 07:53:03 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: jgg@ziepe.ca, kevin.tian@intel.com, robin.murphy@arm.com, joro@8bytes.org,
        will@kernel.org
Subject: [RFC PATCH v1 0/8] iommu: Add contiguous MSI mapping support
Date: Wed, 26 Aug 2026 16:52:54 +0200
Message-ID: <20260826145302.449904-1-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7vyEKumaCc_v6MDm7kwOZ5_px97vunol
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyNCBTYWx0ZWRfX2oC1C+ZSlsup
 jdHB02zqH00f6E7Wdn8O7If+jhuzd8U9zvdHPjC5SomQBo5bBC71hh/3Z7jb163h44l74xq/o+L
 evWPKMJ3ZEjWCgs/ejZHh/po4FGwZ4Bg7IZMj+DieKkQ9acYmBwx30sI7890zlAoSrpn8gg+UFT
 BfwqxfjEjfK5RMg1FGDoLV/frU5Z9/81GZRQ3UD09MZ+c9g/rTrY30CCejN6pQMHY+FyGYzG88V
 D/+ZgBn2HQDuliSx9gzKmgL8qtkZQvqz5rkLBi3Y8JpCullamlKiLW+nfcvFxxZj7rcYIXUz0SF
 6DOIOkHA/03mrQRU7XomnFgPP2mFiHKfa457nBeHke6F4w+ehT2vXoP1ddcGgryT60hFpc2i9dx
 c6aK1K66TTsAWr7FP/xXnUUfKgbYuQzV097bNIB6TeuyqPawJGIGL12jaRPEgb3lRP3gjcBQC+t
 MBmzKxksLcCnPz338+Q==
X-Authority-Analysis: v=2.4 cv=Y77IdBeN c=1 sm=1 tr=0 ts=6a8efdd2 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=CzrpMg+lqiTzknPDBj2tlw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=qVCPVaEg2bWtLysX0cMA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: 7vyEKumaCc_v6MDm7kwOZ5_px97vunol
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyNCBTYWx0ZWRfX1YSW6CdsRxZ8
 1ERB8N/AV8+me7P4AYqvnpQHGiD6BIu3dEwqx7IUM/wsSFw8JR55bPnCNpW81xUaVUpKofvJKT2
 +kvBmqyr3ApTnzFhm6zjjP5rx1x1vjo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260124

The RISC-V IOMMU MSI remapping series [1] needs to prepare mappings for
every possible IMSIC target before MSI composition may occur in atomic
context. The previous approach mapped each physical address separately
and kept a driver-owned PA-to-IOVA lookup table.

Jason Gunthorpe suggested passing the complete list of physical
addresses through the existing MSI preparation flow. This series
implements that idea as iommu_dma_prepare_msi_list(), which maps the
ordered list into one contiguous IOVA range and records its base and
granule shift in the MSI descriptor. The interrupt-remapping driver can
then derive the IOVA for each list entry without maintaining a separate
IOVA array.

Both DMA-IOMMU and iommufd backends are extended to support these list
mappings. The existing per-page mapping objects are retained, while
the first object identifies the complete range so identical lists can
reuse an existing mapping. iommufd allocates and installs a complete
range atomically and grows its software-MSI bitmaps beyond their
previous 64-entry limit.

This is being posted separately from the RISC-V MSI remapping work for
early RFC review of the common DMA-IOMMU and iommufd interfaces. The
RISC-V adaptation to iommu_dma_prepare_msi_list() is still in progress
and will be posted later.

LLM-based coding assistants were used during development for code
exploration, patch review, test execution, and drafting and editing
commit messages and this cover letter. I reviewed and finalized all
resulting code and text. Per-patch Assisted-by tags are omitted in
light of the ongoing discussion about simplifying coding-assistant
attribution[2].

Thanks,
drew

[1] https://lore.kernel.org/all/20260820214150.545737-1-andrew.jones@oss.qualcomm.com/
[2] https://lore.kernel.org/all/20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org/

Andrew Jones (8):
  iommu/dma: Prepare MSI physical address lists
  iommufd: Convert struct iommufd_sw_msi_maps to a growable bitmap
  iommufd: Split software MSI map lookup and allocation
  iommufd: Bound software MSI mappings to the reserved range
  iommufd: Prepare software MSI maps for address lists
  iommufd: Install software MSI map ranges atomically
  iommufd: Prepare software MSI installation for address lists
  iommu/dma: Introduce iommu_dma_prepare_msi_list()

 drivers/iommu/dma-iommu.c               | 116 ++++++---
 drivers/iommu/dma-iommu.h               |  13 +-
 drivers/iommu/iommu-priv.h              |   7 +-
 drivers/iommu/iommu.c                   | 109 ++++++--
 drivers/iommu/iommufd/device.c          |  20 +-
 drivers/iommu/iommufd/driver.c          | 315 ++++++++++++++++++++----
 drivers/iommu/iommufd/hw_pagetable.c    |   1 +
 drivers/iommu/iommufd/io_pagetable.c    |   9 +-
 drivers/iommu/iommufd/iommufd_private.h |  51 +++-
 include/linux/iommu.h                   |   8 +
 10 files changed, 528 insertions(+), 121 deletions(-)

-- 
2.43.0

