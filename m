Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7032031984C
	for <iommu@lists.linux.dev>; Tue, 26 Aug 2025 09:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756201490; cv=none; b=nIewyQKXzL5+kHQ0xVvvGNh4suDbAg6Z1yR9c7y5kdhtq87/g8wrt6eML44VnuWJwltOYBzvSCRrUJ/c7CkB2QFLZvBCJbrfm8a3RUYZOooZPP/NvMmNT5vwnC7uxjgbdnT6De9Pg4I63P56ZerB3lTzKrJXAv5m7iTRxTXrU/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756201490; c=relaxed/simple;
	bh=bKJ0fjdJCipGCZZemVQf2NFUT5zLKcT9eIte7Z7ZuQc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=aLrQuuhmbPKaW2dA4ODul3FKYUaPVmXzSEA3OdsZGjRpu7AJDtH2cYAV/qTKP0bmQ2bTPqwu3iWog9RZ7ND0GLIIABhdEE+iq80bar5x8u9dXXodWHWEQIuq5RPlBcCL4WIwl1jfmfQZMdrvcVuZ/VfB9Sy7Bs8Txn/Nj22pFhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g4+QgYUC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g4+QgYUC"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q8eGlf019189
	for <iommu@lists.linux.dev>; Tue, 26 Aug 2025 09:44:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=THXD3tlh8eUkNhfT5PZNJh
	HY5CcdeoTK49zbedmEjuk=; b=g4+QgYUC8d0fGdy5J1db+XMkqGsk83v8dKbpP0
	vrEBj3W9YYImfOLv2+Wo8BIyei98A5TR5lp9jvA9M86MqcGtcUEZml27fg2y0Dk2
	vo3ri2btmuN8mw5Lh4yRN0ZuuKE/J91YsI0ycvr9JNVYrJ//8fMHfZX9lL/uzSpe
	NUAQuUTQ4oJ/I9jAY+YVa4sE9b/TxXLZq2NiSyDm/G2aW6bX+W0/ZrZRj9uBPQ2Z
	xS9sOSrStM15Ko4iRccxLqfpAXVhHkVFX9os05DyEIE1jYiwFUUuiILuNO3EJXkl
	cAl/uvU31ubvcHxGWhEFGvMSxfZsZCx8Y2km9BMOGEkP1JDQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5y5g58j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 26 Aug 2025 09:44:48 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b49de53348aso1538281a12.1
        for <iommu@lists.linux.dev>; Tue, 26 Aug 2025 02:44:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756201487; x=1756806287;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=THXD3tlh8eUkNhfT5PZNJhHY5CcdeoTK49zbedmEjuk=;
        b=s08SKwa+DXP0RO0gPW9RPni1yStQ03iejvQSkNkyuoOPagIsxgP1YVVgfXi+M3ENvl
         jnN6/4dQ6WnUn07HN1IzX8j4EvHB6zkXiLacEAXFhMc5UpErjiL2WBAmSTRxXgdIuMcf
         J9th9PFngv8VafJq8sm0dSuJkfEQpwpQonn0Y2gE7du1PfrWBNTrMjbJb5QyzOr77rXv
         GW8DB6YWXFnUNbDPqfaiQEwo9JJs9Nuu9+7FGR7bqobKg572li/uQk8SerNLYIb2I7QT
         z3eA1aMZxtc6sisKfUOhTz4YFIxe2uqqWbyyAzUCSP2g8Q+VYXNV32PGqaOZ/YXAoGX2
         VhYA==
X-Gm-Message-State: AOJu0YyQKYq9I/LUTP2cpmzewuUu9cR5SO9gFmgdRXgjsnAYy8ggFCy7
	jY9U6Xq11jn/HsfYHN5OID5OiIlYekiaez0QHUw17u10NqKOFxvpgSWvDgN7wqdBRPpqpB/yX3X
	RN/kk1Bc09yK1f8iCjkUU4MHBd/7xBXJkMyqv9I4cAsFy0Vk/szs847et/Q==
X-Gm-Gg: ASbGncuz8QqkP/+xRy359p9nUzHRqyxgsNDWpdo3dfh2ZRo77nR748x7fHnsJe11ePH
	MeIGRlzX0pXvPioHQSHynpwOrNnxWiVsZNS4OdL7+8gCObM332B35X+vbjq3taSfCz/GyVeuYP1
	0VAAKdGpCMCJhy2iVz3cgt9InNWN5Gb1WC+5b5X0nuqjYYySpxMj3xsc2tj0IThwNrNMtIwbM3G
	hDhwftbeqd8HLVnbK40CAc3+rRxIuYIKvsOGksW+/sw5KpgLrojtrm6dkgopqrPIjTJXR/eORLl
	BB6rnG8nadnqDoZ3enCuPTMaSb0N8yiQ7Uxbh71JFbj0wRbhzVI9xzFCRhqGRhDm5PP7zdDYL2z
	bME+mko0jjbR/aqUBKUef0ekUZw==
X-Received: by 2002:a05:6a21:9990:b0:1f3:31fe:c1da with SMTP id adf61e73a8af0-2438facc696mr1246057637.11.1756201487030;
        Tue, 26 Aug 2025 02:44:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvRL2Fy9sI3oGMG7jx+6nF6YDFCIRE8NYEdNTyKm+HWJTBqahFHayZ4KaRSOkfwszakqi1yw==
X-Received: by 2002:a05:6a21:9990:b0:1f3:31fe:c1da with SMTP id adf61e73a8af0-2438facc696mr1246024637.11.1756201486520;
        Tue, 26 Aug 2025 02:44:46 -0700 (PDT)
Received: from [10.133.33.184] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771f9f289c3sm1329536b3a.19.2025.08.26.02.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 02:44:46 -0700 (PDT)
Message-ID: <ff6c1fe6-820f-4e58-8395-df06aa91706c@oss.qualcomm.com>
Date: Tue, 26 Aug 2025 17:44:42 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Subject: is dma_mapping_error() check necessary for dma_alloc_noncoherent()?
To: Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: iommu@lists.linux.dev,
        "linux-kernel@vger.kernel.org >> linux-kernel"
 <linux-kernel@vger.kernel.org>,
        "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX/VWp/ejgb3RH
 8Uw051yVyymjpX92KMWhiH+uUTRTHzLejDfsSKhxNjp2nuo36XFWRA+dQqAmCgvD1wjdT8G0Mm7
 xnpBitS8tGgvZ2ioBvO46CR3BpHGFc1kWnH473pucSzkldPwrZMD2jlgYUxv9BER6rqemADN/O3
 8UObJRi++RF5r7qiejxfmV1B1UAEymw4NLkuWdk8GzzeTLbKIdlB/DucsCmkLOSwAV5/Kc3/e3x
 vcIu512jrjfKxzI1ypWFM55A3cYmmn4BMenBE5B7IaC1LGG5yOovo0HonzgRu6CUVePxbXLUkMw
 LRpn0c1okpI2k6k7yV9JpGHWB3pt82Sr54QD4sCV07U/BtSfb1LOgCpeI1sK77LoZzy4ZIFa3UX
 mZMuvwwr
X-Authority-Analysis: v=2.4 cv=Lco86ifi c=1 sm=1 tr=0 ts=68ad8210 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=Q74vz0maYr0LruRLZiwA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: iYX7GHxkKixUwZo7srP18QJexvOxQ7KB
X-Proofpoint-ORIG-GUID: iYX7GHxkKixUwZo7srP18QJexvOxQ7KB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

Hi guys,

I have a driver which allocate noncoherent DMA buffer and get the returned CPU addr tested:

	vaddr_unaligned = dma_alloc_noncoherent(ab->dev, rx_tid->unaligned_size, &paddr,
						DMA_BIDIRECTIONAL, GFP_ATOMIC);
	if (!vaddr_unaligned) {
		spin_unlock_bh(&ab->base_lock);
		return -ENOMEM;
	}

while free the buffer

	dma_free_noncoherent(ab->dev, rx_tid->unaligned_size,
			     rx_tid->vaddr_unaligned,
			     rx_tid->paddr_unaligned, DMA_BIDIRECTIONAL);

I get below warnings:

 DMA-API: ath11k_pci 0000:03:00.0: device driver failed to check map error[device
address=0x00000000f3ad7000] [size=639 bytes] [mapped as single]
 WARNING: CPU: 15 PID: 64303 at kernel/dma/debug.c:1036 check_unmap+0x7e2/0x950
 RIP: 0010:check_unmap+0x7e2/0x950
 Call Trace:
  <TASK>
  ? free_to_partial_list+0x9d/0x350
  debug_dma_unmap_page+0xac/0xc0
  ? debug_smp_processor_id+0x17/0x20
  ? rcu_is_watching+0x13/0x70
  dma_free_pages+0x56/0x180
  [...]
  </TASK>
 ---[ end trace 0000000000000000 ]---
 DMA-API: Mapped at:
  debug_dma_map_page+0x7c/0x140
  dma_alloc_pages+0x74/0x220
  [...]

Checking code gives me the impression that I should do dma_mapping_error() check as well.
And indeed with below diff the warning is gone:

+       dma_mapping_error(ab->dev, paddr);

However this does not make sense to me since IMO testing the CPU address is good enough, I
can not imagine a valid case where DMA alloc/map fails while returning a valid CPU
address, no?

If I was right, should we remove invocation to debug_dma_map_page() in dma_alloc_pages()?
