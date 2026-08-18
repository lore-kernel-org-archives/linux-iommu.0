Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D4C448CF3
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 09:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787045091; cv=none; b=FDtahwilXzN857SwUXiSWOlmgA4fv/S0b6HBjJFqDI9YWM9tPOLxfPJYTIHXmL26I0Xs4vV6ixLFEMcWkJteX8BAgWK2/0kwaF2j9lO4ynDhny7DU4e/ssp+pCacsXYMNz9CUEdQcv0nOAbu41NyTF0uPDFENejfqowTeZpOvI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787045091; c=relaxed/simple;
	bh=FLZNlKteUg9CLsgP3hRXGB9XJ1BCIaIuxJcW6YjRPWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t/+hkFuLcXb6+4HndH9NWx/aC6tUjxGalk8u8Mv3UcIm9G8114GGatHByFA4Ts1Hwmq4JAKQM9fMCLsGzinT2KaShpLd/rKyHwdneXd50zkbnPvcBh9wwHg7JRGHTJkPepWksZfHh9LL1rJa0Z3Y/SI2iNiyjuw58LMGTnMRd/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JO0vM+vZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FuA+gQIu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JO0vM+vZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FuA+gQIu"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67I8BIoo1061673
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 09:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=mJn/FZa8W23PTaXnKMduvvzPW2zV73QGReU
	yurQ+/y8=; b=JO0vM+vZpMjE6IaAAGoqlblwJz8Wx6t3z/qfShkhn69GMeyQd0b
	uRedLudiZp0SAQjhRTXQY7FKNYuC5NEvhEp7iJl+F/oiAM1AAzkxrvGR7TX21LU+
	EdIop5mPNio5eI8eu74WBNHGo7VaBTUi35EazplSghF+kYEjoToG1dn+g9lDiOH1
	GtcPD9V36Dx7nvCixGq/lAD4tqY6q/wMyD7QtWWkVtKw7GRAImNEEghPS7KvI2Bt
	x16Kv8slelmYcWXVNbemBFtEE90mR6eA3BZISRNrUEUMe/FZOClJ40y1x2TZQFrS
	XnqfJ+BWYMFbZOWf0G51nR+fpmHN33E45bA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4fvp1a87-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 09:24:48 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-907b38aaad2so39296336d6.1
        for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 02:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787045088; x=1787649888; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mJn/FZa8W23PTaXnKMduvvzPW2zV73QGReUyurQ+/y8=;
        b=FuA+gQIuAPKYKtnivFl6Fd90Dr7opvt8OV5tUeaMUzUo0EMqWZwJ1B+F2sQdR9BjWr
         NiPC7PgfOL1q0ozS1l+O/1P55UA3YSONlFhV3SCCDp527MLVHtCiWf/VttkFQa1DuFze
         T3jxcwx43t8yE0hjeVwVnhCHHTsQZnLkwQpOAOosC75Z2DyxXckVXy3TOkwfbFhymWvj
         uyyjfBVOQXgVDgsYyOULMBoJUW/GCigrKHMJka3mp43yddbVEHGszSkfZ4fxiZYBe5F3
         Ka/TcSSvjagD3t99o6CJGp12m1JYy5yeKeYBuWb579hcoUw7h9HmD3fj+8fpZoKthUjD
         V9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787045088; x=1787649888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mJn/FZa8W23PTaXnKMduvvzPW2zV73QGReUyurQ+/y8=;
        b=sM43pZcAyZr3WByRrec4O0UccpYGyJCgZie+/RXOHCEfHed9EGM1HRR5QxRGtTyN88
         7DILei+u/ynTM0AdaBnE4lfKet9E6r4HCaoFvFslk/gTY2kMQ7iVSut5oyOe/0TR27UM
         Iqa5/BV9YzDmVwooMtZ+PZzy60tnJzjkoGhqpYJF/w4KnzmE1h2z/oxBXEk4yWwNJabO
         Vkq6R97lb8ujHDeVIB7mAZPOQSpmkxJ22y1g9GyGqwZMvkysf5LMMRGILrSC1ySi0j07
         pb7jlEWP4WmLTlkNY2GILdFL+N7v9ZgI+Zk53yIcQXbvXriZJklT9bxo8K+j184q6X7P
         YPZA==
X-Gm-Message-State: AOJu0YwCik6T+2sbqXLWhbRYN2t0zWFeYJUJEKwGTKMHL3yPzbn2zzPn
	aeD1dxXpDtgZaZmgPt6Wc6i+mcM91tyjvDNizA2igBOiVM5qzUbhnJvR1QWVpMJ3z3DnrbbfL5j
	u90PtE4jBpg3mWDgUwd3aieZrB9Ql2BfAgjxB8bfAbDjs73YjJvv32e/lm0tkqIhcvA==
X-Gm-Gg: AR+sD10m2sXHVAKnl+/4MuvyiOmvTNIHWP94UekAOyz+FhR9EE/YSy4ypkKLtQsZvYJ
	CKRhyA5o5DrM3Gqn7SQyrvT9EKNW8h2I/LD6D2OFhRbdOTOvNlmvvgZNfu9QNOf7uAxTnslXFJ5
	0s946VCJVy+t4KRn/DVgeGPXRCObSpz0F+U2gq+UHXd6cY/9WxWo4VAG8kLnA90N/FMndEbEqSU
	8qgig4U67fKY9RjKHYjInz/HkoHstxHiSYgyvFQGIc9Hn/5B1tudVQkGDXlEz0KdgWismhOASmu
	2De0w9jsgDvqNkDrW7OkHc3RW3A9jAEJjY6UJvDJxG3Rc39ZqbRV15U0tK9VB83/Yny7MUOYYwb
	T54xwPoen/535W4UTg7lBrTPSaUnQbA2KtN0=
X-Received: by 2002:a05:6214:5545:b0:907:c056:d648 with SMTP id 6a1803df08f44-90c4b2a964dmr83876676d6.2.1787045087872;
        Tue, 18 Aug 2026 02:24:47 -0700 (PDT)
X-Received: by 2002:a05:6214:5545:b0:907:c056:d648 with SMTP id 6a1803df08f44-90c4b2a964dmr83876096d6.2.1787045087340;
        Tue, 18 Aug 2026 02:24:47 -0700 (PDT)
Received: from localhost (ip-86-49-251-7.bb.vodafone.cz. [86.49.251.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a31396sm10813064f8f.2.2026.08.18.02.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 02:24:46 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: fangyu.yu@linux.alibaba.com, tomasz.jeznach@linux.dev, jgg@ziepe.ca,
        oro@8bytes.org, will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com
Subject: [PATCH] iommu/generic_pt: Fix the RISC-V supported feature mask
Date: Tue, 18 Aug 2026 11:24:44 +0200
Message-ID: <20260818092444.42755-1-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: IW12sGIkm0jiNtHLWi71Q72x6hHroEMZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA2OCBTYWx0ZWRfX14JLjH4WYkXK
 vQMhnioOXiKMdMRuuaJt/6LvIWlgAfMxK+/o1RnIDapar7WNedD1BFw/fD82wUJkdwLQXVyBY+o
 AkYkjzCMZrP+RZthrgJz2lYbqqme/fldATqRiH5vUL02ZVO96uImVIIMsrE82bSZFB0lg/tgUVf
 IxB8gZwuG4ni23ycFXBn6N/lmBhHXneconJ1NgVFjr71mQ69dvV9Dr6HhZUS/k9mWjM42VjMzGU
 9R1wQZ1I7aDL1lJ4zX8NR2dwePXxhQhuXu+5GSnmoMtnoscYkHUeyBXVd2T3ZUkJ1exYRAK/ksc
 jhi/eDqLfZ7Bzwv8L7PLgZK2d+1eDbFQ0WBJ9euO7gzKlTxqt0636CCg2UkAWFuksIAQoXinmtz
 yNaKim2CtxsUpWCfvUaqDhwINSeM5oDa8UPbBKa68dJXK0gttNh8KyPRRfw/sJdnGtg9JyCImel
 7yfhJ9cKVeZwSBlu5Ag==
X-Authority-Analysis: v=2.4 cv=K/IS2SWI c=1 sm=1 tr=0 ts=6a8424e0 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=on9AXyaqQ0RhfYpiXjjEXA==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=YhUPgLupSSQvV9JAn3kA:9 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA2OCBTYWx0ZWRfX1dCsnHj4EtKV
 DYis9J9ZeaTFgXkmKD7lFWuK9OjThlIH3NVmrxTjI2KqaszB/0lQ8dtS+tK2WHFrPbXNAXKG8I4
 u7jNLiv6fe21qghAyuIL4C9JQG1RNHQ=
X-Proofpoint-GUID: IW12sGIkm0jiNtHLWi71Q72x6hHroEMZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180068

The RISC-V format advertises Svpbmt to its users, but omits the feature
from PT_SUPPORTED_FEATURES. Add it there so configurations which enable
Svpbmt pass generic page-table feature validation.

Fixes: f196a8668797 ("iommu/riscv: Advertise Svpbmt support to generic page table")
Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/generic_pt/fmt/iommu_riscv64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/generic_pt/fmt/iommu_riscv64.c b/drivers/iommu/generic_pt/fmt/iommu_riscv64.c
index b18fc4d109f5..1bb74114fb02 100644
--- a/drivers/iommu/generic_pt/fmt/iommu_riscv64.c
+++ b/drivers/iommu/generic_pt/fmt/iommu_riscv64.c
@@ -7,7 +7,8 @@
 #define PT_SUPPORTED_FEATURES                                  \
 	(BIT(PT_FEAT_SIGN_EXTEND) | BIT(PT_FEAT_FLUSH_RANGE) | \
 	 BIT(PT_FEAT_RISCV_SVNAPOT_64K) |                      \
-	 BIT(PT_FEAT_DETAILED_GATHER))
+	 BIT(PT_FEAT_DETAILED_GATHER) |                        \
+	 BIT(PT_FEAT_RISCV_SVPBMT))
 #define PT_FORCE_ENABLED_FEATURES BIT(PT_FEAT_DETAILED_GATHER)
 
 #include "iommu_template.h"
-- 
2.43.0

