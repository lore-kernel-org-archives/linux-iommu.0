Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198D442314E
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 21:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778275427; cv=none; b=hgUp/irt0HsurnAvfKlu9awPO7IZVVCRUfd/wdMxS+y95e4dVIdZcfQKA1noSBtOezWKHQ8AJT2yNAxu2nAqPT2O7xdfepIQcnTlKsRckpeuHgQ9biDLDelVtM2SpLeNQTk2rCzE1CF6PJrnCHLMmdBMRIsw7oiEo0o2x+wn0Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778275427; c=relaxed/simple;
	bh=/IZ2SyzIYhAo7IR+uF/xwgAs8JJQjeH1lZlwNdEM38g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LdbYEDRbLM/rk4DCdNPq96KmptBb4zWf6jYgJkUExHLYSc4IftLpuhUS9HAWw4ImU4UZnfl2vMEWJF+irEK/aP8FjEl3iRkETtdJOLBvNDZc/HB6Ei+rUBq1F65Uunw8S0ZeMOsdH5P3stMCyYzOo6zXxNA3RojHlPzHdjIO/pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NH0KV81N; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DlweOUkd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NH0KV81N";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DlweOUkd"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648GWPsB2335642
	for <iommu@lists.linux.dev>; Fri, 8 May 2026 21:23:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ahHBby4y07C
	i93vD8Adl4aPO8dzjeBxp/5vUSFayQgg=; b=NH0KV81Nd/X3DKHboSiWwBekc6J
	zgkGNTlCoXFrNCOSmW8Hs/XOJGQ9KV2/1V/EEp0B0+3f2ZfDRZO9dJihp2VCGATX
	gXN1C750vBA2KcZJiDhiM4qVtYhfgynRB++kzuGND+upARSmMeBQTUi0srhLn4ku
	1xPclJFdfbamEqj+tm+kC9DSq7N0bGH3dMF7AAZK8htlIDKJMXvhKgajGYiWWnyW
	FTwcKCNnQOzJDhxtM7AnjfTPRTLZL/VUcsh+0CeJGya51D2sQKUWgH8ugwNUcI11
	iW5lV3bp8+KmpxX0ujG09O0vJAbO7oB+9O98Vxn92MLWLIbbcWiDTSfRnOg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1keh8wyq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 08 May 2026 21:23:45 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2f3ec2e8d07so4633392eec.1
        for <iommu@lists.linux.dev>; Fri, 08 May 2026 14:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778275424; x=1778880224; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahHBby4y07Ci93vD8Adl4aPO8dzjeBxp/5vUSFayQgg=;
        b=DlweOUkda1qs/of5QhEUi7KkVWywbip1JoRVznaeapg7KScHxbBWWdp/T+y5lE0OFp
         Rd7UABQwcAtcV6PRLMWgi8Lwqh9nCwYe5PTm1QTP2Wlyx4yBcAyZUECRhFpjOx483v5z
         ILEaVGMJhjzca+tziOPuwurRuk4DPAUizp89yr3HvQ9Zm/MoGHHdJcJepozUNF4F+GbI
         7AULcysdNA8aBei/OKXhuho3Bu1b3rLG3ilzNemElsRCOC/PBjab3b97RAI4zH6vLBt9
         bBGtrFTeS4hyFMLvFYPGcKm9eys1ndbQQOcKxXETGgnQs0TSAT7uk8tKUgon67wMAEgr
         lfag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778275424; x=1778880224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ahHBby4y07Ci93vD8Adl4aPO8dzjeBxp/5vUSFayQgg=;
        b=pvoCh/PqKUE+5jNJdDTOgIRcVxDtbEL7bhWaFFxRlfTDZlftYvCA9tAYGOpG0ffJfy
         HQJLF0yvlOvRuk0/yVjgPXs2ovpPrkQkq6VpBFhr/CFGCnQgyPdYLmCg1thr9IcTdFD4
         u2PqoEDce6TlpYJE2KR3EqN8lVYg0QqJh5JsXxPtl7f5YqwTeTM8NAZvQtVbUp9R6iEI
         GZOy+T9A/BBptwTfAAs2I9NjUITB4wgCITKPr1DVo+RzfoG54lcSurVngaHrdSrINf1f
         pZGyFCYvcw1EDd4ChmcQFJCKS1rsPEoAhMug2vcVmBHd2ZBWMAuVa9s37rHxFm9S92Hi
         1uRA==
X-Forwarded-Encrypted: i=1; AFNElJ8BbV/T6s+IrVxtPbe5MlMeqLzBtidqpxa+tbNVJBe/d0Ab5evF/mRrdYO/zeeQyUksz2H5aA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxVzM5nXTfWAELPQbo0S0dK1K4CPA416nRwAmD/wjKVvoRIDvLK
	SVsPKqVQyoCnvIl1QfqoYlgsLSh7dqlmGBvez/4qK9i9MqJBjWDzB7R1uyoaN9YksUVWCdUwon1
	X6rMJxe5ZQ3RTDpzirpJ5+eRfXM9tdLkXpR7ZUfJgDQqoZjnwnbRN347tZw==
X-Gm-Gg: Acq92OF6jNz+OTWhY+DCRU4MlaLEngnVOsftrXz12POIk4zMBuR0okUS6qUYMH4pkiG
	8fwVqoziDN8RHDQVfnfEFs85zsXNf+QtT4B8Onscnpmm/GJSmSWFqum5aq81Ja/1x2lfAXZbnFA
	1R+98SeEJh43IQSKFPGnHQAk6d5dz5Kpq5sNJ0yOTm1JVmmDgbb4Xpdo27NbYz07c/AAHGPyoHW
	/ivUonpWcbdawROHKwJfhcI+Ly67Gtlrw5gzM6O9rv/zKq2cDKQVtj8Ybe2vbUsCESp9kT02oz5
	3ABNv8zlpFii65imBfBQ/IPAIyesWDMjdoRzdkYqcVu/doydd3W2EhAXht2aChov1zQmC3Vf8Fl
	6ej5V3CxNO48xFma0xanXHsszI7uY8MM=
X-Received: by 2002:a05:7300:bc0c:b0:2c5:ed1b:ca9 with SMTP id 5a478bee46e88-2f85bb72d01mr2298253eec.1.1778275424537;
        Fri, 08 May 2026 14:23:44 -0700 (PDT)
X-Received: by 2002:a05:7300:bc0c:b0:2c5:ed1b:ca9 with SMTP id 5a478bee46e88-2f85bb72d01mr2298224eec.1.1778275424067;
        Fri, 08 May 2026 14:23:44 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88847506fsm4512457eec.18.2026.05.08.14.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 14:23:43 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tjeznach@rivosinc.com, joro@8bytes.org,
        will@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
        anup@brainfault.org, Nutty Liu <nutty.liu@hotmail.com>
Subject: [PATCH 2/2] iommu/dma: enable IOMMU_DMA for RISC-V
Date: Fri,  8 May 2026 16:23:39 -0500
Message-ID: <20260508212339.381933-3-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508212339.381933-1-andrew.jones@oss.qualcomm.com>
References: <20260508212339.381933-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CJIamxrD c=1 sm=1 tr=0 ts=69fe5461 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=h0uksLzaAAAA:8
 a=EUspDBNiAAAA:8 a=69EAbJreAAAA:8 a=hQ6NVdKzidvgU2_XqusA:9
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=MSi_79tMYmZZG2gvAgS0:22
X-Proofpoint-GUID: 6XMA9L6a42mJTEzBUDG32xOjoiImaX2W
X-Proofpoint-ORIG-GUID: 6XMA9L6a42mJTEzBUDG32xOjoiImaX2W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDIxMSBTYWx0ZWRfXwrsdEn1FAPXT
 U1SWL87s2RYLiNXVuNT8BsJCl922BqX0s54tk59SuQRVZfsXTy8BqZZcgB3Yk+jNGxVpK3zCJIZ
 uvZ8miMz+35kZaRtb6dERJAJ72upENeTW08q4Vo0K4b32LCmki8RHea9C0DoCvbw/WiZu23bzGF
 EekrkiQW6ON+uEAKEfD2s+IevACjYohyQZ3wtPQiIrTOLcaAEJI56P+fkz5HB9uVISYvcvUJe6/
 gPR6CbY9EATU0CgM7P57RCBMSXMa55Zy19NJkmc3+yrAFtw1fjMbSWNmq2hJWxZRffbD3qZbVpY
 N+MCBaALdyET/KBh43yPAmwpFar671p4BRG0XfJdfyOfIc0/Kl50fQ/Yypurk86KpohBkbJLq6R
 GPTd5LL/ERljxBtS87FjvRgK00RPibrleWY2MNwp2tI9abJPvpQOo1IdZuZSqj3DsfYX1q0UUV/
 XnoO5M7K8X80vl8fcVw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605080211

From: Tomasz Jeznach <tjeznach@rivosinc.com>

With iommu/riscv driver available we can enable IOMMU_DMA support
for RISC-V architecture.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
---
 drivers/iommu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index f86262b11416..34d8a792339f 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -151,7 +151,7 @@ config OF_IOMMU
 
 # IOMMU-agnostic DMA-mapping layer
 config IOMMU_DMA
-	def_bool ARM64 || X86 || S390
+	def_bool ARM64 || X86 || S390 || RISCV
 	select DMA_OPS_HELPERS
 	select IOMMU_API
 	select IOMMU_IOVA
-- 
2.43.0

