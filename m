Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C565536D9EC
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 07:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065043; cv=none; b=RDspqPemyIPgBLog6XM34ng+tlUTCcbpV4ycOzLEaAu9JhzSHU3smMzpj9gWmpdvLpRtsgjULlTkKjb8lTuKMQfP1N5hCjLajM5sWrKXI8uvjAV5g9dZ2DEcO7D7P//vJ+Dd+PqMsArHAcqSqQM1HFbd+qitAWmywoKwLLzyztI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065043; c=relaxed/simple;
	bh=U38Exkn5F4K0dBOTHvXgeHPpIHPzDyvOnWH1mlmNjsc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ejs5mZL9mNX6cl580UZ14eXWSXFqPKLP+QklQyyqyHaxC2ZkYyTzwZDhtmZbi44O+ik7WGkKZeyid7AbNOQvZ1inV2lNX9efg+YAoNi1OoHhgIfZuk4OkLbraFQoKp4FYoVHGD9Exyed3LQqHNu7hX1UA7PDFQ0yIZyFhzGl2FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZkSY2tDH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ROfEaEnO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZkSY2tDH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ROfEaEnO"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6635rjdd3108915
	for <iommu@lists.linux.dev>; Fri, 3 Jul 2026 07:50:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=38e/h0rBiS/Qf7sZDXyxGk
	btU/FLkAzEU1CnnW8iABQ=; b=ZkSY2tDHk40SQB4KRiTxhHXS7h8f1FocnhMrWr
	FL5bCRoSftRFfMrnKqiAafOEAs71JnxeqVADyC4YW2DX2y83WMxNbT912QhmIgEu
	8xlVr5+R5bnEh3flKSkK6aVgu+UBPe3Is0VMxL//4dDaDsMXfbRaZxoYmUTYpclf
	2n3NwdJrZLognY13Lyljc1OAV6F1zHa0IXviiL8sqJw9B8N7c3d2zSuZdvbO3xiG
	UFqoSPvNgjv6ylQwxcM3F5G+cdJMRHkd9RLQGT4i1jaFuHTtBC22QM5QdeUfCtyM
	MdaFELLaetQV2XXSMDFtr17ul3j9ZzV2nvmeLHMwd9LKDiCA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f60ey9ygc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 03 Jul 2026 07:50:40 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c88ad1558f4so548019a12.2
        for <iommu@lists.linux.dev>; Fri, 03 Jul 2026 00:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783065040; x=1783669840; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=38e/h0rBiS/Qf7sZDXyxGkbtU/FLkAzEU1CnnW8iABQ=;
        b=ROfEaEnOXlmZVJRcelgyIDLu3i4XcwbQ7QPF5RcbdHL6MMOE09gkLABY0nZC6k8Bxj
         p2XjVKj4VeuQKhriVkflqPbzEXALBoRmPH6kxclRKDBRUvonF6nxqulXehC/L0QqrRL9
         +B2+Eir824SEMWiVJ5eGzhT0YoSEZrL1Zlk17ch2IqjXh/c/sxS/QnHR1ZdONrGMtPCr
         9I8vEMIzYVw0yxsUfUcHznpozHyUFpPs97l71FwR7Dr/XlOfAA1TkMBb9FuphNJdqyfT
         J+l+7lye8igeFmubI8sgxOiiZqpuDmXD6b8mi6GCwI72GgNmOVx3J4wlyTAIgq/gZiEW
         7XBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783065040; x=1783669840;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38e/h0rBiS/Qf7sZDXyxGkbtU/FLkAzEU1CnnW8iABQ=;
        b=YK8hAHQAA7pE1RwDAh/H1vhDqmDjXFVfMYIt9Zv0YlBWE9vBAaJeEcETr2M1NROxXT
         YsYetDng4Y1JU5hd2hwzIw+HmXqz6La0hDkHPXWSQ6ESEPbCVm3MtJu3xJUJtdnnuqoF
         mxoBQqZky2Ttasc5XD4sl/Bist+Pb6kXp3Av9WsobHSPRVMLFUuAq8OvRdlLXMpJriXa
         jOsx5j9ViDirK+RSJiBwJhmG1haXFMG/qlznTjQRjq6FDVURSl7Wa+FjM1NAPs7MFpEN
         jHVQUJC5BALAkP4d7eY42YSOSsWvjfZO68XEhCttn8ZaUPuLem4XtTvLq9F+zMEtuAyg
         J7vQ==
X-Forwarded-Encrypted: i=1; AFNElJ96oJxf7wD6lj2UP2EBkCPpJDs7gmAgV+DPNOCtXs3de4U5fZ/2jYzWMpZBX8TvJ/wySbNDFQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxr1HzLAcButWOo3osqo+QGGNmpB9VcfpJSb2OftHQIf+IpZ/AA
	5RhhYfzWUzQkExhZsjjM/dGUk7i+BoBRJ41Ad7h/GLEGYy36ZjZ7SqgXcwcm9IRCg2ym5YxBCH6
	I8hqUTglu2osFoHrpdLPV0ElitvVpSz2JGQg+Up2Uc9y7sENPIGScKNBvmw==
X-Gm-Gg: AfdE7clH/pvo/l0/pTnRjfrgzD6RQJ50lCfBgcrOtGFeQVREkDZymtDYRApQCRpjvXk
	+nCDHOM/Zhii0NQfkT36ejP6IbFiqg5zQjd/4Y+opyB+USl/ojXspznJytgAoxQjvMU0BLL01j4
	4osVxbkupnQ1XPg2ZGo3kWlWG4jlmo92NHJpu/p1rDhsgMu+ejnk6hU4mNx4AFbZyjqdqSqVJmv
	vDVOuAPYQZPGtoVSTHYqpUvUt7tcLcMYctViWybCstyhQCLMbY3ofGrzBlZXAt5D22cVLOaOx4x
	pxTz7K0wOXAP0mqMp8mU6Io00pY8KRIoGTqsInQGbBvnD2tsfuputY5lTa4awqYIti8+cYMbPdn
	pLLnZwsUJIubg08oZ5dOhaRXMF9m8ECO0wWVfMmJwdfHc384GhfRaUfZgpjIqcw==
X-Received: by 2002:a05:6a20:d52c:b0:3bd:229c:dcab with SMTP id adf61e73a8af0-3bfed274077mr11178599637.17.1783065039645;
        Fri, 03 Jul 2026 00:50:39 -0700 (PDT)
X-Received: by 2002:a05:6a20:d52c:b0:3bd:229c:dcab with SMTP id adf61e73a8af0-3bfed274077mr11178571637.17.1783065039177;
        Fri, 03 Jul 2026 00:50:39 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c870effsm20729977c88.12.2026.07.03.00.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 00:50:38 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 00:50:33 -0700
Subject: [PATCH v3] dt-bindings: arm-smmu: qcom: Add compatible for Maili
 SoC
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-maili-smmu-v3-1-b48de6f5ae4a@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAMhpR2oC/22Oyw7CIBBFf6VhLU2hL3TlfxgXU5haklIULNE0/
 XehLjTGzSQnuffcWYhHp9GTQ7YQh0F7bacI5S4jcoDpglSryIQXvCkaLqgBPWrqjZnpHlXRc8n
 EHhSJhavDXj822ekcuQOPtHMwySEpYr1JsUH7u3XPbTKwFH7ba1592wOjjKIUdcd4r0CUR+t9f
 pthlNaYPB6SRgL/GH7+CzwaRFtVAtqmFSj/GNZ1fQHj9U1+BAEAAA==
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-3d134
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783065038; l=1717;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=U38Exkn5F4K0dBOTHvXgeHPpIHPzDyvOnWH1mlmNjsc=;
 b=/pzt0aDH3YX449O3+iIsthLRn64BLGWMr+/DRFBjwkhN6NDmKQrVxdpjzhWYxZ6/GMr3MGJtQ
 jFu1jgHClwLAFGXkjHXQIczQcnEK++d27l2UNsEZKMVdqt7yhcf2wYl
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA3MyBTYWx0ZWRfX+qzRf3CtwnhV
 j8NFcDK0BQvxt4iCd0TqGMppKf5GNbl7FcFsaHRPpv8l+5Zjt9OUUnHtZ/lDcuCyo+2taRcoTRj
 avjHvnSHxd8uRxrleHbiWd9Rx93FDzhlS9GditWPmMZV6z/nbZwzKzj+YQ7luofKpPZRD/ggLpi
 Fzn8fdgtFBRi8Qfm8pifRqVpFkOU19nx+fAut5ck0yqwqzDB6WXtSvNpIwhDTcSVqlSKBaSSuTn
 rD8w3I8lllDhz662xi2ObSeOp9pSX6sl39aK1GOPNJL6nNc3uG/zQjJLm6DpYgHN/JeMZ6xSh8j
 LrXx6j6cB9KUup+owSKnkTvD/gdLVi1vVeFLhMc3DTZVCth7eM7+pfZW3cZ2UJj+OHwehy3vylG
 02W5GoPb3uQ6Ot/f3rsQLSGq8trzw/XGbfUKbImoFn3YJK0Dfmido0m/QsyKm4tZBaSKbQdgWxv
 Z1DmY84WpcXlH1llB/Q==
X-Proofpoint-GUID: RVhZ6phqJ-mNOYYJ8G_6btq_G78e0X-P
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA3MyBTYWx0ZWRfX/dGaTDLA7lVa
 3M+0cUDiL6rSUTrj7l0CsFZzM5W1aKd0KYoNs3t4kXyzmpsOX9ubE27BboqwJ6CIKeOOEuZXoQA
 vIDHkW0KtMpH+LNlFQvjJXblxRRFcf4=
X-Authority-Analysis: v=2.4 cv=SPRykuvH c=1 sm=1 tr=0 ts=6a4769d0 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=iEDX-NX4Me02MYkbRrQA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: RVhZ6phqJ-mNOYYJ8G_6btq_G78e0X-P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030073

Qualcomm Maili SoC includes apps smmu that implements arm,mmu-500,
which is used to translate device-visible virtual addresses to
physical addresses. Add compatible for it.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
Changes in v3:
- add smmu binding to the block that disallows clocks
- Link to v2: https://lore.kernel.org/r/20260628-maili-smmu-v2-1-87448a7678ec@oss.qualcomm.com

Changes in v2:
- patch rebase
- Link to v1: https://lore.kernel.org/r/20260524-maili-smmu-v1-1-ec85b12fda83@oss.qualcomm.com
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index a701dec2fa0a..fd095161f6be 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -39,6 +39,7 @@ properties:
               - qcom,glymur-smmu-500
               - qcom,hawi-smmu-500
               - qcom,kaanapali-smmu-500
+              - qcom,maili-smmu-500
               - qcom,milos-smmu-500
               - qcom,nord-smmu-500
               - qcom,qcm2290-smmu-500
@@ -621,6 +622,7 @@ allOf:
                 - qcom,glymur-smmu-500
                 - qcom,hawi-smmu-500
                 - qcom,kaanapali-smmu-500
+                - qcom,maili-smmu-500
                 - qcom,milos-smmu-500
                 - qcom,nord-smmu-500
                 - qcom,qcs615-smmu-500

---
base-commit: 3d5670d672ae08b8c534b7beed6f57c8b44e7b43
change-id: 20260628-maili-smmu-9ed0f2c189ad

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>

