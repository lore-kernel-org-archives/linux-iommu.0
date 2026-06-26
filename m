Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A499931AABC
	for <iommu@lists.linux.dev>; Fri, 26 Jun 2026 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485683; cv=none; b=EIwhihO6YwQjHXpL9eYmCcikTFEd6KaRZj5+Cc1imUKV1Tser4MTzd4oYX4BL8UpyNOSBK9wpR0AT1M5W9YjJbt0tkUjOkHqhRDesaHmZSlOfRRzjaKSgOJIPvxskZPDRLz8pt7FLbpMxN74FwiQHaoPCddeob7A5hiMHXTuLx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485683; c=relaxed/simple;
	bh=UCwkJAe8P1pYFdk06PaNaKtvagHVUYsw8cugPruxH2E=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WDPKEa8I6booUNhcPoSHDqixG16t4ctCbjluVVX0fwtk9eLUfvJi5WiwW3AXRBL1xbj5OBxc7fj8idwMTUEUfDBU1FaTRrNu47E7wSYlx1VyhmT7n53aFsb9FgKOKOlBkQK5vgLXBK/r3NuOy8QlRjfIW1pdT4krHa/G8YtrKjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nZ1SMgbC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WD+tBAxp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nZ1SMgbC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WD+tBAxp"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65QAchFg1143743
	for <iommu@lists.linux.dev>; Fri, 26 Jun 2026 14:54:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mYWJkhNIK4vEw8z7nhJCveZpwInyCIrXGAzZOF/vmPE=; b=nZ1SMgbCdM6XOVR1
	iinWb5Si+AAILW4f57MbZ3eRlU/0q35t64nBbizVTVbZNFoCH6nvIkJw6hJbEHtW
	5JVJwD98DI77lkVNqJYPkXVJrvDn32XrCQKSSL6DRJyBW4AjxnXz2xgVJibIytrg
	XyJgoblrtq6VLyEn1JzepHwFwNgBz7bjPYJSzoi+v/HMjobPLtCLK4lqG5+mkO5e
	v7pWy6tPs55DZate5bFbwqrP5j1653J4BDTV/diUTNIHTyKEanmzCmPJeVtKTCOu
	hnkIY9O9h0VSxqx5Oq9mNrT+wH3y8zSeLobSTP5OUTjIbYtQxtoTyhpqi9V24eLU
	p4KcMQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1eewb728-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 26 Jun 2026 14:54:40 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c7cfa17fe6so15010905ad.3
        for <iommu@lists.linux.dev>; Fri, 26 Jun 2026 07:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782485680; x=1783090480; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mYWJkhNIK4vEw8z7nhJCveZpwInyCIrXGAzZOF/vmPE=;
        b=WD+tBAxplhy0dghC5YboQYdnyotm6tW5YX/AWnupNWKrU78a8Ky7a1ceM1n2CKVcHd
         5RwZ7ofOHk8l6cGRMNkwRJmEaAxZxDIvd37I2sbYHjRQ9pPDGpPkXHklNU1MFhdAgkDC
         dEvMh2G02WH7GbTqDkZ6UTtwOtnMU+upd9rT347i/EE5XWMZczrH6y0w9QkVkYWLGvCC
         tq57oSdX6rUA3G3AjmBjMuvi6kM4TWuxbbafpE6Pj1lEhprT9a0Py65F2Jn/PywLNIpU
         cOwD5K/tO9YMqLp5Yzsp0AIIoZkIUITIqRkM+Cy0nKvgrGe4Ew/2qghgUkO3peVV8QWr
         lj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782485680; x=1783090480;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mYWJkhNIK4vEw8z7nhJCveZpwInyCIrXGAzZOF/vmPE=;
        b=hE1uma9Zgr8Z8qAeKuZWKArFllOFKNd74Q/KiD4lyIY+8BjcQtp+lu4HWA2QXYcbFb
         mJxaJzFXEIhvac/DliUbiYXcuEc19UE6LHM/+wIdvsigxFI87VZkV9NJmq5begNG0MDT
         V4hyx3TE7iKp9VsSELijhXohfsqw15Cyi8wXqzAvlTaUE8x8HQ+w0jTRGkS5I+EseRhj
         23TmXe38/lDv/mFJNQtF/8p7a6FR943qRA9RwOp9Fbb/TXf17eVTC0yH203kqAKGfVwB
         IhPHe6nF1XrnX91meLxIQ0qaoAKgXPhRlpQWoEgpFlhHtpO+wVFrFGmZifFDnXmdGvl7
         jDow==
X-Forwarded-Encrypted: i=1; AHgh+RpEXfWqQXELarKjsMvMfB//K2DKoBBXVmVbO5hvrhKxxNOAPs0EOPTG75QMbNWE5g+l6CTqDQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyglCM1be3eaASHq0NfeZHsP2htyEJr0pvM6wJKWLeplTCqPNw1
	jjxpa6OtGfs2waQVtE5/gFlEj6S9JA3TTHOEBM8znQD0IYOq8mnQ856r8kA3OvO13IgG/IO6fqE
	JvtpPhjQiUoFLGjTpc6oTUos8H/0bPEv+eockRJFww12ijeGEzZAsUDoNKg==
X-Gm-Gg: AfdE7cn/pDHlqXzffJKWSrTlgfojUWUSwN3bSIeWsHhq0rean12zxlcqgcEW2m2VclA
	jSOYg6zLPBxMXO6DU+1gPS0yGXT98GLajuP8b/uouzLkhOsU31YDMD98LsUIs/40FyJaJlpQK29
	iPnovpOZm81XZhhxrhAjlLUOCQXNv3HZgIU2AfKKrTaULT6ugoD9qBGKK+Iy0jvP8JZnfJcPTyo
	QcMNdrEJpvory8nuZRQsgcTQPVyH6aT06+MsYUAIQj3jL620+HyarT9EYic+X6oFOGbGMdQNt/V
	R3+eh+EWP4X5JYAixlBTV6rRCm/nOVlgjP5pAVuc0nq/3LrBkTZ6Nfzcwgym/zgutTC/ty6mo8f
	L9pkW92g0N+2soYxO+oSKXA7r93wYMUqihvo=
X-Received: by 2002:a17:902:c40a:b0:2c0:a555:80e6 with SMTP id d9443c01a7336-2c7fc654109mr75502965ad.6.1782485679555;
        Fri, 26 Jun 2026 07:54:39 -0700 (PDT)
X-Received: by 2002:a17:902:c40a:b0:2c0:a555:80e6 with SMTP id d9443c01a7336-2c7fc654109mr75502655ad.6.1782485679097;
        Fri, 26 Jun 2026 07:54:39 -0700 (PDT)
Received: from [192.168.29.96] ([49.37.170.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f5ac899esm41390565ad.7.2026.06.26.07.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2026 07:54:38 -0700 (PDT)
Message-ID: <2a52ecb1-be8a-4522-aa23-f3277f0555fa@oss.qualcomm.com>
Date: Fri, 26 Jun 2026 20:24:31 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: harsha.v@oss.qualcomm.com
Subject: Re: [PATCH v2 00/11] iommu/arm-smmu-v3: Add PRI support
To: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org, robin.murphy@arm.com,
        jgg@nvidia.com
Cc: joro@8bytes.org, bhelgaas@google.com, praan@google.com,
        kevin.tian@intel.com, kees@kernel.org, smostafa@google.com,
        baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, skaestle@nvidia.com, mmarrid@nvidia.com,
        skolothumtho@nvidia.com, bbiber@nvidia.com
References: <cover.1779944354.git.nicolinc@nvidia.com>
Content-Language: en-GB
In-Reply-To: <cover.1779944354.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDEyMyBTYWx0ZWRfXyEre93tDZTbC
 c6zsgRHaqp6qvVXMgBSfmokMQSA/eKn+zVZjBXbtOBt7Rw4XWrl7HA1q/3nEK3X/pm0ySgJgzRZ
 kbzKOX1ljP00s8iZqtEvN8KnWHAdRyc=
X-Proofpoint-GUID: MIhpmGAN7Ko_DUrybAF8w_tcFZdxVeX5
X-Proofpoint-ORIG-GUID: MIhpmGAN7Ko_DUrybAF8w_tcFZdxVeX5
X-Authority-Analysis: v=2.4 cv=P7UKQCAu c=1 sm=1 tr=0 ts=6a3e92b0 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=asHclmMlXTalQ/2ShlWtEQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=XZ8z-I0mWLgmP2cXQ10A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDEyMyBTYWx0ZWRfX6HSlrenlrmTC
 Elo/XmfkW+Ch0feE+1DJsJL992Dgh4wUbydwgyDrLDMxIMy6cjjC3tgckO/tL4ZlHs25e4U72D7
 MS8Gz7+mLAaueFzWdPXBza1nkWo+CKFk73tgw723gFL69Q/UMINq7lLvnBzF8E3ifkGEL2r3R+7
 I//Dqg0mIEPUhGaTrb6lQMzPiORh1k8Evd3hlC10MeC0TozN8zWSUuqmLosD/5l1cl1+9pUNkl6
 gzCadiHy1t5NPtDWH719DCxo1jbvxe1aquzdKAaD9UQw8bIhe1QsJVQmiRUJ6UUXflEp9p2FinA
 ljT4Crpuh0HtcAIB1vGI9C+9pNLf7hd24ot221eG8FcqfizCl/xbXHgVyhUx0ZPgLS2xj+jxrFu
 7RM4aPpRODCTVwHX4p8BSRDfGAp6ab4C444bcTRyFchyiRhHHIuKvnvSN9HzhBD/Kn0WhnXf+ro
 o59nOkr1UqQ97hljL+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260123

Hi Nicolin Chen,

On 5/28/2026 1:29 PM, Nicolin Chen wrote:
> The SMMUv3 driver doesn't handle events on the PRI queue or respond to IOPF
> faults. This series adds the missing pieces, using the IOPF infrastructure,
> to convert PRI page requests into iopf_faults and issue CMDQ_OP_PRI_RESP.
> 
> The iopf_queue_flush_dev() contract requires the driver to first drain the
> hardware PRI queue and synchronize using a threaded IRQ handler before the
> IOPF software flush. This drove the additional commits compared to v1:
>   - arm_smmu_drain_queue_for_iopf() drains the hardware queue to the PROD
>     snapshot
>   - arm_smmu_attach_release() moves the teardown outside the global lock
>   - synchronize_irq() closes the gap before the final flush
> 
> This is on Github:
> https://github.com/nicolinc/iommufd/commits/smmuv3_pri-v2
> 
> FWIW, engineers on the NVIDIA side have managed to verify the PRI feature.
> 
> Changelog
> v2:
>   * Allocate evtq.iopf for ARM_SMMU_FEAT_PRI
>   * Pick up Jean's PRI stubs and PRI export patches
>   * Enable PRI for PCI devices in arm_smmu_probe_device()
>   * Add arm_smmu_drain_queue_for_iopf() for EVTQ and PRIQ
>   * Add arm_smmu_attach_release() to rework the IOPF drain
>   * Add IOMMU_FAULT_PAGE_REQUEST_STALLS_TRANS for STALL mode
>   * Gate pci_enable_pri() on FEAT_PRI plus a non-NULL evtq.iopf
>   * Deny unrecognised-StreamID PRG_LAST in arm_smmu_handle_ppr()
>   * Disable PRI when no IRQ handler is registered (unique or combined IRQ)
> v1:
>   https://lore.kernel.org/all/cover.1772568590.git.nicolinc@nvidia.com/
> 
> Jean-Philippe Brucker (2):
>    PCI/ATS: Add PRI stubs
>    PCI/ATS: Export pci_enable_pri() and pci_reset_pri()
> 
> Malak Marrid (1):
>    iommu/arm-smmu-v3: Submit CMDQ_OP_PRI_RESP for IOPF event
> 
> Nicolin Chen (8):
>    iommu/arm-smmu-v3: Add arm_smmu_attach_release()
>    iommu/arm-smmu-v3: Factor out __queue_empty() and __queue_consumed()
>    iommu/arm-smmu-v3: Add arm_smmu_drain_queue_for_iopf() helper
>    iommu/arm-smmu-v3: Drain in-flight fault handlers
>    iommu/arm-smmu-v3: Support PRI Page Request in arm_smmu_handle_ppr()
>    iommu/arm-smmu-v3: Disable PRI when no IRQ handler is registered
>    iommu/arm-smmu-v3: Allocate IOPF queue for ARM_SMMU_FEAT_PRI
>    iommu/arm-smmu-v3: Enable PRI for PCI device in
>      arm_smmu_probe_device()
> 
>   drivers/iommu/arm/Kconfig                     |   1 +
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   3 +
>   include/linux/iommu.h                         |   1 +
>   include/linux/pci-ats.h                       |   5 +
>   .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |   1 +
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 244 +++++++++++++++---
>   drivers/pci/ats.c                             |   2 +
>   7 files changed, 221 insertions(+), 36 deletions(-)
> 
> 
> base-commit: 74fa4c177ad09800b007cba043370c887bb1b4e3

One thing I noticed while reviewing: when arm_smmu_priq_thread() detects
PRIQ overflow, partial faults (non-LAST pages stored via
report_partial_fault()) whose LAST page was lost in the overflow remain
permanently in iopf_param->partial. This is a monotonic memory leak —
it grows with each overflow event.

Intel VT-d handles this in prq_event_thread() (drivers/iommu/intel/prq.c):
     if (head == tail) {
         iopf_queue_discard_partial(iommu->iopf_queue);
         writel(DMA_PRS_PRO, iommu->reg + DMAR_PRS_REG);
     }

iopf_queue_discard_partial() was written for exactly this scenario.
Could we add the same here arm_smmu_priq_thread()
(drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c) ?

     if (queue_sync_prod_in(q) == -EOVERFLOW) {
         dev_err(smmu->dev, "PRIQ overflow detected -- requests lost\n");
+       iopf_queue_discard_partial(smmu->evtq.iopf);
     }

At this point all surviving entries have already been consumed by the
loop above, so discarding unconditionally is safe — implicitly matching
Intel's "head == tail" guard.

Best Regards,
Harsha Vardhan V
