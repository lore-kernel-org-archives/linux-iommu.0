Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795170964;
	b=FGgdytlg9XBMQtddvBISh8u5WChER+5xr7RaaELX6g8P40AO/QdcIbN+RDFcGB9a6NzZ
	 4ub3hMbeQKlrQjtsz41rfndfQcIiYdgTzzfH8WdR5KO+MwTNTFZzWROL3H2SYAvWT04xf
	 0iGxqTC6hzkBGI1pibEaaNGhrYL722uD6kxA08ztEPwmGd67/NJ+JfdZzsnLYu8JY8dTS
	 4W9F78zBXxktDe+8yximD8F1ZmXglQVUGC0dlnitNlmdzEy0VzJN3x7wiFo+7KRkrBetZ
	 kmKxmrtNPAxmCa1+XzJwDyKMa89HDxOnvUMJWTDip2IuwRhX1jM/6jdMm+rE9aQASJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795170964;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=YY/D6NwXvAt8GUNLURk0RoyGVkXYLPKr3FA7NvSrM04=;
	b=ScKMf1EHglzo/kWPvNDhobO1BwVmzWwr8Km7V+6uzDIOQSMnCtEwmIWNBFA1oUhnTk+n
	 1lrXZIJC2cigwpMOytvsaukvaSKvYTHuBLqh/38LyJF4h2ixLSEmRUMzgVZ/+zMeiTaGI
	 yeAeH+5q8cb4CYb/i0sSmpS3FvMhOrEj7c2sA14jSPZKwEsOOvcxcIzhdG+fKmsgwdT3i
	 RTdtUwIAHbUoBIsVmiLyR3psK4FbPfafVmjR8Nj40I5g8TfNbtx2yqgsMmY/07T0TS3ov
	 9nZWMob49bbZAqY3dxrZmLhPY5KXlWjXVt3a+Kfrr2yLC+7m4X8UJVqIHnplnQHSRrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=h4uKSajK;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="SVv/IPgh";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A542606A320
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 10:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A542606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=h4uKSajK;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SVv/IPgh
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7esQI2019464
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 10:36:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YY/D6NwXvAt8GUNLURk0RoyGVkXYLPKr3FA7NvSrM04=; b=h4uKSajKK5dVxUFf
	JIxAtAPjf2a8Sk1VwgoXr6oWF1E7rgxFGbWDsHbolwgPQ9loa26Bwcj3UMHTC1Ou
	MdmwEHJVyune52IBCrXOUA+9xdZyjB3+dTAXrraukG1HHFhee5GMKUhbyl75rwv/
	czornfm6BbkQND6CWWP4Ae9d+uzDHRnTiFGmXQzQ/SxbV/+ck92gR6CXwU42aoJH
	wlurXDUamkqlBbPwXTN7QG5BDAPNKK8k/dkr3RmpnlulIpx8+p7WVZM1il0IeKBl
	Z2Dnlw6AqiHZU8YL94QxIY475V9vUTd/Tayuls2D36bS74pR3XgjjZrNL5B9h8si
	Y5aDOw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2fjj9b8p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 10:36:03 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1b3a348a6dbso1430454c88.1
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 02:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795170963; x=1795775763; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YY/D6NwXvAt8GUNLURk0RoyGVkXYLPKr3FA7NvSrM04=;
        b=SVv/IPghBTKKXS9jMelBnYFaDU9dpIVbIMIKa2spFiuQ799eIu6QMcvLfRhai78xk/
         5x8605czS/+DlXq/c6R+Ma+ipjTpTDnwVztsNTZy3J6FWA1mIW86Ts6+E/zlwMIAjwH4
         OhTToKbszPMFTlvt181Lan9MbAN2YM1jnCH0XPiYhuI7szKAq0Llp8b3xOUJrTHiUS02
         gkR9HlFg7npLNHvPbaAUeHSWnRJt4DHyyWlPUknjFOUwHGbEnA44IDUSjFdZyToNGxzB
         rrUJPWlxQbkriI7Rlc3WBcc2tETtVvTU8RyIVPF0qNNReZgexNLYkZe92fOeZJ1OTH1V
         aR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795170963; x=1795775763;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YY/D6NwXvAt8GUNLURk0RoyGVkXYLPKr3FA7NvSrM04=;
        b=X6sOVOPIRr/HgCMBS3i7+kc8wEcidPYaXJiJ8mgPC4/9Anzi7yYNYncldqVcd09HMa
         1+EggXOe6/8xmUNXbhRdgnLKPYc57zCXjRbBHOsBlA9WqCEjkiFV51mZywPPIWyKuNJP
         D0BOfQsnOLxLFMbgKe9N76ovGEFXO9PvXxYf/SAxXP/R6nYrCRs76aLGJaFIooFG/2zi
         tZwpt3Z78ZBJGD2pDdqgHMas9BUWELr9Sqq3oSjZ+HLiwIdg1uopRpHNKvpCnIiaZSv1
         zaiW9R4KN18Q1tmkrEItPdjF4r3dNwVmkVucPIwoxVnTTxfYb8/c2I2YDmIMC3FmMsH2
         QOIw==
X-Gm-Message-State: APuU4Z9azHRK+q8xHpueDKJk12nZYrO0doRW1+3iuJNZu9LYrc6RfzUC
	DovZMYWIEPurDp4r2ck22Ctoo/bgb5PkcXmfyzgLSrHn81Kvx/Bn7hel9JE70Tnn8hiZLpLV7Dn
	Lw86aRTItC0utMce5nL6Qq/64eivSbyfHfvg/4FB5kUDJY1xAJaDfSnzdjA==
X-Gm-Gg: AYBFou2IL6VAoae8SLxeZP89AmmTNMQaA22VeZUlELncXPTbg8xjygQLLeOfijDnnwZ
	8RgIQmQxasmM6+BHFDxYd1TZyxWkrABjzT/5zoaoy7CRC3bvFaubZ5bbk2d4z7aeD3U3VvvJ0eF
	Z5ai1QvqEfFPM09CGnyFz72gV5RAkocWKAF56LBHyFL5wGDXw8vo8PUnuHSK8huZiXWt8nnkvo+
	drOt5Yh4k7yKu1D50TErCYL3AQEXEISrQZXFryGgcJjaAyf1BXUcOX7gJ85dGLlk0+EzEtNplC0
	WaQMlv2sjksoDTRvLwok4idu53qjd++sPLS2LLGLIO/NFVjwev8q5JKFPoZDN4SOMBKnkM8Gelh
	sRITqBM1pXPsUoLnKL9/Q2BBNwAFy2hfxxiE3ZmnFwrSHe+G/9XZ1+Yqb0m7S6+fFwH1aZfMJNo
	IoGd45sE3h
X-Received: by 2002:a05:7022:4181:b0:1b0:4272:4282 with SMTP id a92af1059eb24-1b5568ba440mr3940265c88.17.1795170962893;
        Fri, 20 Nov 2026 02:36:02 -0800 (PST)
X-Received: by 2002:a05:7022:4181:b0:1b0:4272:4282 with SMTP id a92af1059eb24-1b5568ba440mr3940229c88.17.1795170962392;
        Fri, 20 Nov 2026 02:36:02 -0800 (PST)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567ffa8csm5751096c88.7.2026.11.20.02.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 02:36:02 -0800 (PST)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 16:05:14 +0530
Subject: [PATCH v8 2/4] iommu: Use resource_size_t for reserved region
 length
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-add_iommu_ranges-v8-2-d90486973b73@oss.qualcomm.com>
References: <20261120-add_iommu_ranges-v8-0-d90486973b73@oss.qualcomm.com>
In-Reply-To: <20261120-add_iommu_ranges-v8-0-d90486973b73@oss.qualcomm.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jpb@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>,
        Eric Auger <eric.auger@redhat.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Joerg Roedel <jroedel@suse.de>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Oza Pawandeep <quic_poza@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex@shazbot.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev, devicetree@vger.kernel.org,
        kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795170934; l=7401;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=lAW81bYzUUhgYHNWMgCQPymvHpXLoor0T9PhGuMwfWc=;
 b=Qco8yvhIVGKE/Rsm7ltl1KXI+gWCZ1vE8QgCc0KLZOIIaad+e1dvDgpsf+st8GRL1OECvOF3G
 nRfsYY0CeClCxBmfzYu2/g4tblcfgkbodiEsV7YMppTP1Q5PbkrcJK4
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Authority-Analysis: v=2.4 cv=FJaOVOos c=1 sm=1 tr=0 ts=6b002293 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=OYu7oO-Aqzh5uGTkRJkA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0MiBTYWx0ZWRfX1h0debj+vnET
 5lUUFEwlV4Iag9li85x88MWTk1nErAjscFYJcDPeTi0xO9kjqc6YJ2RihVWwdSauoulVSISy+GR
 MPaqqSSjs0RygstJc3V1pBJ7irh3/CE=
X-Proofpoint-ORIG-GUID: -EU93Mt-gYR6VqNAYedBPI0d50YpZwCk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0MiBTYWx0ZWRfX6gaiW8UaaAfl
 C3DQTI4kedlwYhcIR3z0FqbA1azD9eORzZuPPXVQHPt74o7LiUr6+BjjVz4qQ/JTIz7zyuhYwoW
 jXp9JvVKUhj1YmKlpKSu5ueIC/y1wcxgf9mGTFuGKrlmFW9HzbvK/H1nVEWzTBPrTtYft0wg1de
 TEkTIkGyUWS40GII0rpgRLiIcxXPgZDJXUstZTaIu4aHlU34FYkDx5bfe9u/yaKnBPRtzwCMc94
 +F8UEECOCJdjieQOSeE7WYOrdTJeMlGQ6J9fiHup8gPjicTUStHzZ0zi2yGZRmNYNeIVSw/I3cY
 5tl7rXB9OdHn2n2dOfvY9crsPTuYLmeBhkEKeND8F6BbOiQpE0kzISeDNeeN0hfY39pLz2HFp8D
 H4TohfjRn63kVZIrFcVlOgpmKQfF9BH6CvbTfEu2jUVDxfwR3CfZVLnl6CduOPrKQlSHtpcgw7e
 HwNLHqst4cJpEFhSdeQ==
X-Proofpoint-GUID: -EU93Mt-gYR6VqNAYedBPI0d50YpZwCk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200042

On 32-bit systems with LPAE, physical addresses are 64-bit. A reserved
region can be larger than 4GiB, but its length is stored as size_t,
which is only 32-bit there. The length gets truncated.
Use resource_size_t for the length so it matches the width of
phys_addr_t and holds the full size of the region.

Fixes: 2b20cbba3390 ("iommu: iommu_alloc_resv_region")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/d223ee9f-b262-408a-a201-8b16d310bbe0@oss.qualcomm.com
Cc: stable@vger.kernel.org
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 drivers/iommu/amd/iommu.c       | 2 +-
 drivers/iommu/intel/iommu.c     | 2 +-
 drivers/iommu/iommu.c           | 2 +-
 drivers/iommu/of_iommu.c        | 4 ++--
 drivers/iommu/virtio-iommu.c    | 2 +-
 drivers/of/address.c            | 2 +-
 drivers/vfio/vfio_iommu_type1.c | 2 +-
 include/linux/iommu.h           | 4 ++--
 include/linux/of_address.h      | 2 +-
 9 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 41ee4ad1dcf826cc765c6f198d487620be60281d..f9f8ef919236a28c6514609d2710b7801a67834f 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3146,7 +3146,7 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 
 	list_for_each_entry(entry, &pci_seg->unity_map, list) {
 		int type, prot = 0;
-		size_t length;
+		resource_size_t length;
 
 		if (devid < entry->devid_start || devid > entry->devid_end)
 			continue;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5a2e705a2f2e025245d4b42c4a9f765c67d708d4..70e210ca085ff52519376358a3e3b7a01619d7a8 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3535,7 +3535,7 @@ static void intel_iommu_get_resv_regions(struct device *device,
 					  i, i_dev) {
 			struct iommu_resv_region *resv;
 			enum iommu_resv_type type;
-			size_t length;
+			resource_size_t length;
 
 			if (i_dev != device &&
 			    !is_downstream_to_pci_bridge(device, i_dev))
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8da858154949e849ef6bc1d303271883fa4762fc..4412dc39a5e87900f3a22e824a99babdcc9f695f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3010,7 +3010,7 @@ void iommu_put_resv_regions(struct device *dev, struct list_head *list)
 EXPORT_SYMBOL(iommu_put_resv_regions);
 
 struct iommu_resv_region *iommu_alloc_resv_region(phys_addr_t start,
-						  size_t length, int prot,
+						  resource_size_t length, int prot,
 						  enum iommu_resv_type type,
 						  gfp_t gfp)
 {
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index a18bb60f6f3dfdba853b6e16dd2a8616f6a731c7..5c266511db78910d6fd221af5437cecff4931c22 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -170,7 +170,7 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
 static enum iommu_resv_type __maybe_unused
 iommu_resv_region_get_type(struct device *dev,
 			   struct resource *phys,
-			   phys_addr_t start, size_t length)
+			   phys_addr_t start, resource_size_t length)
 {
 	phys_addr_t end = start + length - 1;
 
@@ -246,7 +246,7 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 				struct iommu_resv_region *region;
 				enum iommu_resv_type type;
 				phys_addr_t iova;
-				size_t length;
+				resource_size_t length;
 
 				if (of_dma_is_coherent(dev->of_node))
 					prot |= IOMMU_CACHE;
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 7fde3ddf231af7fcb6571e3daeaf227552eb17bc..37c48d05c73bf9bab85ed134eac6c6998191405c 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -483,7 +483,7 @@ static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
 			       struct virtio_iommu_probe_resv_mem *mem,
 			       size_t len)
 {
-	size_t size;
+	resource_size_t size;
 	u64 start64, end64;
 	phys_addr_t start, end;
 	struct iommu_resv_region *region = NULL, *next;
diff --git a/drivers/of/address.c b/drivers/of/address.c
index 499d37ceae210ac844eef853aeecbfabaaa5e138..f665432638a6d1cc1ebfc0d2356b813c8c584910 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -655,7 +655,7 @@ EXPORT_SYMBOL(of_translate_dma_address);
  * Returns a pointer to the cell immediately following the translated DMA region.
  */
 const __be32 *of_translate_dma_region(struct device_node *dev, const __be32 *prop,
-				      phys_addr_t *start, size_t *length)
+				      phys_addr_t *start, resource_size_t *length)
 {
 	struct device_node *parent __free(device_node) = __of_get_dma_parent(dev);
 	u64 address, size;
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index f7addfbe1aab4f6fb662b8b2fa66bc02d98b5f03..9f508143505ad9e603af1730e811c30bd5edce16 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -164,7 +164,7 @@ vfio_iommu_find_iommu_group(struct vfio_iommu *iommu,
  */
 
 static struct vfio_dma *vfio_find_dma(struct vfio_iommu *iommu,
-				      dma_addr_t start, size_t size)
+				      dma_addr_t start, resource_size_t size)
 {
 	struct rb_node *node = iommu->dma_list.rb_node;
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ef5043752a3651419679316c5a20cdf049efeaba..1d8f9381a358ec2309503bfe2866f08a1f236b2b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -306,7 +306,7 @@ enum iommu_resv_type {
 struct iommu_resv_region {
 	struct list_head	list;
 	phys_addr_t		start;
-	size_t			length;
+	resource_size_t		length;
 	int			prot;
 	enum iommu_resv_type	type;
 	void (*free)(struct device *dev, struct iommu_resv_region *region);
@@ -968,7 +968,7 @@ extern void iommu_set_default_passthrough(bool cmd_line);
 extern void iommu_set_default_translated(bool cmd_line);
 extern bool iommu_default_passthrough(void);
 extern struct iommu_resv_region *
-iommu_alloc_resv_region(phys_addr_t start, size_t length, int prot,
+iommu_alloc_resv_region(phys_addr_t start, resource_size_t length, int prot,
 			enum iommu_resv_type type, gfp_t gfp);
 extern int iommu_get_group_resv_regions(struct iommu_group *group,
 					struct list_head *head);
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 0cff9036539168b0cf2826ee34417738a4836ace..ae6d96c8c110adad966f2c1bad2cbefaf55e5c57 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -56,7 +56,7 @@ static inline int of_range_count(const struct of_range_parser *parser)
 extern u64 of_translate_dma_address(struct device_node *dev,
 				    const __be32 *in_addr);
 extern const __be32 *of_translate_dma_region(struct device_node *dev, const __be32 *addr,
-					     phys_addr_t *start, size_t *length);
+					     phys_addr_t *start, resource_size_t *length);
 
 #ifdef CONFIG_OF_ADDRESS
 extern u64 of_translate_address(struct device_node *np, const __be32 *addr);

-- 
2.34.1

