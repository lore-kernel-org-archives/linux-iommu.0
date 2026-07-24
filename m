Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BB9340D9D
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905947; cv=none; b=J7CAhnFgCBRQHlJ7aRxbBABQ+s2sx2U283sM3OwGkb6hlA+QM032uDsirgiEoBWLs+wtTG2m/3av2mhtfXdnwvWewmELJV51vitAKo8+jwj3aFfXXy2jBX65NblR9s4w782frDT+mdZtg0h49naGap9YcnQXICT5feA+KZ+Em40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905947; c=relaxed/simple;
	bh=CR0bn9QhLQDGMGcl5esTIjVx96cXHUyuzFRUfA1XW9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bKgTEKg7PZlZ1cQNPuQD1BvzmJ4FmJTtUuCJ6cNXSH8FwZvzVsRIdKsmuzFUpMbjZ00fjMktbfOlVjrwcti6PMTcxI9uaJ2AhJ7m0d78gZ4ueN8/+d1P4+/A5BootyZ7OpeeoJiWIGvYbtUxOkKSgvfen0HIhBFQPAvPguxMt/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FWcfKQtG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MxMMHy5L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FWcfKQtG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MxMMHy5L"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODbtnJ3198184
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=HZTaqOfthGVMHlz4UUR4FZopztKLradcCh8
	wOx7NFuc=; b=FWcfKQtGTrOAIZkY0Rghx6vky3N2cD3YEVJyG3fqdsr7Y4Wit+V
	y1ZJ2TPmNGqcp/GYHcW1jO7UZYe/kGx9m6HIa+m+98YJvnuamjfbrdw1tc+WxBnv
	B7vhb1kwS0PVosJ7IdzfYhuuuP7HG+fXpkR/gzKBTR+TaVcBvFW97z+KX9omITQ8
	wenNOwG6eiBPTCO9bvIvZ0WGyer2vGauC5rZfoDt22jBPUnwe3BNoqjLH2XljtHo
	inDN7W+ilEocrcY07ig7cHtOQgwq+4cqxyNYT3vGpfPbPvZEcYIWeg4B7a02hnhX
	cencFVcJrWVAZngVl6vxX6zO004LvD26pzA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm0p52bq0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:21 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c1a97644aso10053891cf.2
        for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 08:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784905941; x=1785510741; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HZTaqOfthGVMHlz4UUR4FZopztKLradcCh8wOx7NFuc=;
        b=MxMMHy5L6tSseC7H87WJLqs2Q7VBzXm0RsQpcS9lnXwN79GkchBXV+0S1H4GGDYW2O
         0IiXpurVJU4AFP00w4ev7iFYqg7LqvAfFkh/k/k4yVVGbWYVXALszmcj1Bi/hmlicvwi
         HuWVCpc63hmFOaU3xo1QmcgfufdlZA5tYxyPkLzH9PJ30j/A6whGC6F9lgNwN6fjm9MV
         X6I5Sx1Q+Mt8RUPS2Vb1j1gSvQW6gm1YeIhpeez9ndYhkvbIMZkEGRlG5QBD3nLObEzq
         z1vVjW/KDVEf26zuriNJKwf58JBqaHjqYsj4TEKV70IfxFL+AqXuUWOlV++nao5nwm9X
         B1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784905941; x=1785510741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HZTaqOfthGVMHlz4UUR4FZopztKLradcCh8wOx7NFuc=;
        b=NQxWlnBc5J6/oF9Bfs0XjUAIYoMswcY1SVZMGua1iCkjLtvr48ImP8oQsxM9kTeW2f
         U9sUt9CoWiyK0lLf6o0m/7mOXG0Ezt1ahjuCAt5WAmoeC1QbIWlVaLyy9YXp1VQSLOwL
         uksahd8Z2br8dOHGew94YXwo4tY3HqXHYe9A+p9Fhtc1gmD0VEpgA5c4mywfa7sTa0D4
         iR8VFJhyR9ZhCxzK+oDKrILBQvB+TopsFXYJJEKEJHBm3sM8r0WcJuHWNU6//CT8CscX
         VtJnYBo71ERTLbwyBi0Gm7OWcZE6SMKZptE3UmEQRVbBvLOxGZZWupIcpkdPJFD10vkI
         UUZw==
X-Forwarded-Encrypted: i=1; AHgh+RriKBBF9VPPh2PQyfqO0x0wE0FP67X7onADcwBc4iy1TttNpOYyev/enfRpqkhq4m7NczeFDQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YywsJYlEAeoZjLHycdKAPlg8IPwnWc7sn2lHAhh5zr28Fd3fmlX
	2jVOjLtU0cpJBHw/51eyNgLeq4JQhKc6fWcv0j9lBbW0Tt87EdVqevoWtNWqnkJQkdm5BWFoJat
	aTTmg00p9mpDYCr+DifvS6iQr4iZlhQ0evzc7HPBjui9SXs6jGF5IqovcZA==
X-Gm-Gg: AR+sD12y4btbHWPFOVMe94EuDM/6DBfHVUd96OGun3KN+hc19rNTUHQWNI0Zn3XdAyc
	E7b4Mqe62zwe8lp7DQwD8uzRpEfSmkLMo74iBwBl+1gck/EjB23CrFsLjpzFXDBfCvXONRI9b07
	01kFyLAhTPkHLmHIljfvvHC2V7zv4jkJos7YWR83lSguVnueHJd5dNB9m5V84lA+Zqv2Gx47TVm
	wB5HftJDMqB38Phtmvk3AmORh2jaO8428q+LgwZdaZxOaNYpYG1HaJSw40FHFMS6QoX2bo95K/Y
	l3fiyF762wX+vz14Jzo14xzanMfVuI7azbGOuoXq+m9m4q3uqOwAqIyI+DsPEik08q4OdvF+EAt
	MlV4dfdf9Lp/C8EgZvXjzdFMtFLryX3+JliPB
X-Received: by 2002:a05:622a:2b09:b0:519:ef86:127d with SMTP id d75a77b69052e-5283dd9487fmr84249231cf.18.1784905941078;
        Fri, 24 Jul 2026 08:12:21 -0700 (PDT)
X-Received: by 2002:a05:622a:2b09:b0:519:ef86:127d with SMTP id d75a77b69052e-5283dd9487fmr84248451cf.18.1784905940449;
        Fri, 24 Jul 2026 08:12:20 -0700 (PDT)
Received: from localhost (ip-86-49-247-5.bb.vodafone.cz. [86.49.247.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32af244asm357943566b.27.2026.07.24.08.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 08:12:19 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v2 00/14] iommu/riscv: Enable MSI remapping and IOMMU_DMA
Date: Fri, 24 Jul 2026 17:12:04 +0200
Message-ID: <20260724151218.965929-1-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Pq6jqQM3 c=1 sm=1 tr=0 ts=6a6380d6 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=aYZ+cQcEYoLAp2L633VOig==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=SC3fYP8t-DLMrfhBmjEA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: c6uwuDOZZpSDZP3aAw_KaK0jxsawYqcQ
X-Proofpoint-ORIG-GUID: c6uwuDOZZpSDZP3aAw_KaK0jxsawYqcQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEzNyBTYWx0ZWRfX4XSRKsJaOOsu
 vcDsepN+JSsTzMBhmO5yYwqGFdAq97dmBnidnQuenPLX7eR7RX4bTsEPRnmuU5tE1TUoAPNQGbp
 XlhdVyREWPIw1N+miPEk2ydSWZnSek8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEzNyBTYWx0ZWRfXzt692PS4A4p+
 OqcZ+Vh4R5++YjN2Mg96mgRgsn0S8r930qgl3XaB6ykWbax8YsYbOZh/9NGJRCfMQGqnkljvZ5b
 IpvGnjUIy/94I8YQ+VlIOzVFBsJqCklnRJg+ooH6HXB14l1laoUnLTc7TGIa89W5ZAaxqOTOden
 zwR6XSH2C7m3Q6wQj6fz2DDfSi2lNfQUnEYuCxrn0jU1avMgqx2+6Kvr8oWdbo/Y26jqh50e9ba
 qgICdolCD54SHUyhjuoFd7SJdkYC3oJsehD10PDtSgF1AuC2Um/Wt4JV0I1eRTcfYMbg/dMy3y7
 aBinj6fr2YVepVM1GqDoKdbY6IM2rxDj0LPuxJwq9uh8BghCDb/SwY3XLiJjcYUix/IRB6pHCu4
 SLHcnxNbSmRcv6js1bhcl+FHSicMCXP6UKQuMpqjtgCLffmqQ9ov+fQWPyLG40ShdwEUO/xyJ+V
 O4U/Ehm6jXlrjyUd3wA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 clxscore=1011 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240137

This series adds MSI remapping for IMSIC so a device's MSI target gets
translated the same way its DMA does, allowing RISC-V to enable IOMMU_DMA
and paging domains by default.

v1[1] used get_resv_regions() with IOMMU_RESV_DIRECT_RELAXABLE to identity
map IMSIC pages, but that was rejected as only a workaround, and the
proposal for v2 was to follow ARM's approach. ARM calls
iommu_dma_prepare_msi() once at IRQ-alloc time, caches the IOVA on the
msi_desc, and lets compose replay it via msi_msg_set_addr(). This series
follows that structure by introducing an IRQ domain and a new
iommu_dma_map_msi(). Like iommu_dma_prepare_msi(), it dispatches on the
same domain cookie types. Unlike iommu_dma_prepare_msi(), it returns the
IOVA to the caller instead of caching it on a descriptor. That allows the
caller to collect all IOVAs needed (since IMSIC needs one IOVA per host
IMSIC page). Like ARM, msi_msg_set_addr() is used at compose time to
direct MSIs to the appropriate IOVAs.

The divergence from ARM is required due to where the target address
actually lives. ARM's doorbell PA is fixed per ITS instance (affinity
changes only retarget hardware routing, never the composed address) so
one IOVA cached at alloc time stays valid for the descriptor's lifetime.
IMSIC doesn't have a fixed target, the MSI address itself changes on
irq_set_affinity(), and that runs in atomic context, so mapping a fresh
IOVA isn't an option. This series pre-maps every IMSIC page into a
domain-wide PA-to-IOVA table at first IRQ-alloc time, and compose does an
O(1) lookup to pick the right one.

LLM-based coding assistants were used during development for code
exploration ("super grep" as one of my colleagues calls it), patch review,
test execution, and commit-message iteration, but all resulting code and
commit messages were selected, reviewed, and finalized by me. Per-patch
Assisted-by tags are omitted in light of the ongoing discussion about
simplifying coding-assistant attribution[2].

Thanks,
drew

[1] https://lore.kernel.org/all/20260508212339.381933-1-andrew.jones@oss.qualcomm.com/
[2] https://lore.kernel.org/all/20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org/


Andrew Jones (13):
  iommufd: Convert struct iommufd_sw_msi_maps to a growable bitmap
  iommufd: Add iommufd_sw_map_msi()
  iommu/dma: Add iommu_dma_sw_map_msi()
  iommu/dma: Add iommu_dma_map_msi()
  genirq/msi: Provide DOMAIN_BUS_MSI_REMAP
  irqchip/riscv-imsic: Compose MSI updates through the hierarchy
  iommu/riscv: Add IRQ domain for interrupt remapping
  iommu/riscv: Prepare info->domain for concurrent RCU read access
  iommu/riscv: Publish IOMMU_RESV_SW_MSI region for iommufd MSI
    remapping
  iommu/riscv: Pre-map IMSIC MSI targets
  iommu/riscv: Copy MSI IOVA table when replacing an iommufd domain
  iommu/riscv: Implement irq_compose_msi_msg for IMSIC remapping
  riscv: defconfig: Enable IOMMUFD and VFIO

Tomasz Jeznach (1):
  iommu/dma: Enable IOMMU_DMA for 64-bit RISC-V

 arch/riscv/configs/defconfig               |   3 +
 drivers/iommu/Kconfig                      |   2 +-
 drivers/iommu/dma-iommu.c                  |  39 ++-
 drivers/iommu/dma-iommu.h                  |  12 +
 drivers/iommu/iommu-priv.h                 |  11 +
 drivers/iommu/iommu.c                      |  86 +++++-
 drivers/iommu/iommufd/device.c             |   3 +-
 drivers/iommu/iommufd/driver.c             |  97 +++++--
 drivers/iommu/iommufd/hw_pagetable.c       |   1 +
 drivers/iommu/iommufd/iommufd_private.h    |  38 ++-
 drivers/iommu/riscv/Kconfig                |   1 +
 drivers/iommu/riscv/Makefile               |   2 +-
 drivers/iommu/riscv/iommu-ir.c             | 298 +++++++++++++++++++++
 drivers/iommu/riscv/iommu.c                |  91 +++++--
 drivers/iommu/riscv/iommu.h                |  37 +++
 drivers/irqchip/irq-msi-lib.c              |   8 +-
 drivers/irqchip/irq-riscv-imsic-platform.c |  27 +-
 include/linux/iommu.h                      |  22 ++
 include/linux/irqchip/riscv-imsic.h        |   7 +
 include/linux/irqdomain_defs.h             |   1 +
 20 files changed, 693 insertions(+), 93 deletions(-)
 create mode 100644 drivers/iommu/riscv/iommu-ir.c

-- 
2.43.0

