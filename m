Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147EC2C21E8
	for <iommu@lists.linux.dev>; Fri,  3 Apr 2026 08:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775203811; cv=none; b=hFiRUGkXvuIQZgnXDfRpZeLP425KcYRHjoMfiGyJMHvXsLHrL614DyRR80qWXJ2XoK9iPU1VmjvarOipIxCog4IA9+gomDldfqwOWoCT0+KShIsCkTyOFN2wEWyykDnI+wOfrmsrcHfovkVH4n3sRq+Zn/otZ2vGMm+8OnW3T/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775203811; c=relaxed/simple;
	bh=w4iloriSlK8kznmyqJnVQZrzmn3qqOsRH37L7AvSFdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qnYCAlLeyj90TGMN3LP2HA1ARiUnA5T0VM4ZN8gbRuV6LPoi1bVoVr/4hUGHcEiPAA0irwhXHrqaKJFoOuf82bLe5n7gY70CBzChlyo7j7eS85ySVHvf5RQWzR1kvkFX1QM/ng/U+fWmYlF/knk3irHHXTniwDtY29Dz3tGllJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SAlay7OM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gxt/EDge; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SAlay7OM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gxt/EDge"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6337EcaH948829
	for <iommu@lists.linux.dev>; Fri, 3 Apr 2026 08:10:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=3yxxuGjGRSktiOSFeurkfNMNMudjTni1PnN
	qFP61cks=; b=SAlay7OM5cJHl5zc5svK6HLlTmllvm6qvO8B3OEMGUNL2vx+R/m
	9imWmfELIzjPpHzsJi0lgYxXqhlxKY/2nG/4oRTSl5MYmvTyj5yunplFH8vYf4Za
	WMsIFtieSLkpiorWwQyj/O/bF/sgvkcnZ/8zEQKhXBbVSbMxdYrCdul1yubbc+Ly
	2oGl8U8jqB+/iCbcCPCTVWVlAo7mzT/+whJNxd+zjxD7xvSSzS6kBhppmUCKXZbU
	StM2x2oKzmdMTeszpDl2b+QMvwdWUfpNHDqrk77Lou/toiBH9kSJKpI09DqjkDzh
	DDcXi1c8jfRJaG+n0BeWrA672wkxfSSoZVA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9xwfhtx9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 03 Apr 2026 08:10:09 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c76bb22a8ceso2175678a12.2
        for <iommu@lists.linux.dev>; Fri, 03 Apr 2026 01:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775203809; x=1775808609; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3yxxuGjGRSktiOSFeurkfNMNMudjTni1PnNqFP61cks=;
        b=Gxt/EDgeiwIXIlNKT1KJZXMzX+4pmaNYz/g1jGbUVrDGsvWHb585qZTag7OVjM18cT
         v3s0Hwf9JLYdYh3G/TscNedcnO26OEoFi4em/DCHxdcjKxZ2sOxo0KX+SGEnIL2Egql8
         WtQSgua/bWPZt7t5dRbrusdgGE5WwPwBRiWsHT8v2pSD/0uCaWRavQot3QfQZ9Yk66I2
         ++eMQL288a0BtphHaDxETla6ZE0Io1eHdxqCbrt6IbCQU2NPv+YclzwfkUPv+jp4HmoH
         0WvETlcKAQiV3JdVG/LvdVUwoM3h8zvJQ/s+MSJDgS6L1hNMCX0loNScEXVizJUZtO/A
         IZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775203809; x=1775808609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yxxuGjGRSktiOSFeurkfNMNMudjTni1PnNqFP61cks=;
        b=QXvpG1GTOfjKQzCrCXsGacel5pI8o3v7+MjJk+I0Kwkl5MvO2AZV6y0mMrOIbQVWQQ
         1HrbHfbMF38Q0q7SgIPhRzTUrmVXDKMOnw+EeikFAFCkAZEmYZ/XWaf1ySSUr2v3cYvf
         HkeMTfwDanDd5CXSpGyJHy/6eyYbt++esNcAPwor80nk7pvy9C4+fTnI2oOmfpt9+lXL
         bo3aFLwsh1UOQtwiTlyjHuLEpcl1PRVKJ4DgT/7C6Vx604/7YVN3ZY4VJAWjz/1MvKdB
         BRzFMyMBIWUvfT0bJ1tJrGSR8K/dlaut43X7t4niECk/L/3v6oSrHxkzmobXDM6JAu/W
         EV4A==
X-Forwarded-Encrypted: i=1; AJvYcCUBqZ5lJ/baYE3Fa5FgmB7t0KrP/qvdiiDB96EYKSdE9eNzLZu32wOWgK7YnvvnFfawwiTqiA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzmKAWL3QYq00wS69zrszjwcz/VMx6+URfbjNptIQ2XBoJmAS9O
	s++/7KkD8VXYE3UCuwGAmlE8I+3eQfoPoTqp2yEUhlDDZWUVXaVk+p9s5GBWFnWyKKRc0QFNL3i
	UK8FUC2i4xwT9tEsdfuW3et3FFRU6kUSPgjPmtMNVUde41gDSa0jOTl555Q==
X-Gm-Gg: AeBDieubQYU7Rlyxxm5Qaqhyi8vC9yo0hnv5C+waEBRWfu9VT7MNJf3QzMx+ToUFuo2
	n/euAYWhiHxcXzs5uhWfU6zIzca3E+T5pVryLDqRUkDRRqdk3/OBwEwZLyWw9LA9sN7LWByKA+x
	tXp+rXARTvd8JrEzwA7YOefIjnVDFOfshEWRKzfq9Lv8MMNFCPMHZ2WyRPObNB3z5Gm6Nob3m1i
	OmgVR1hkytR+9pT6kpnno1qceOTRxE5WipnzbbW77XbUYj7vWyCsBKXU/9Lt74qOnTZlBx4pohd
	Tin5ZJVqQ9Deo5hqOrSrR9F15cNR8DNaAO3WY48oHxdMZLSNlfOMg9fHnIMv/BrqgcYbXfSNvnU
	XSpwyJ2QyWJYwSu85qd3ALIpkKz9mF8vTPbge/EdJfNrWH0h7
X-Received: by 2002:a05:6a00:2e85:b0:82c:6aee:b21a with SMTP id d2e1a72fcca58-82d0dba215cmr2162809b3a.45.1775203808253;
        Fri, 03 Apr 2026 01:10:08 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e85:b0:82c:6aee:b21a with SMTP id d2e1a72fcca58-82d0dba215cmr2162769b3a.45.1775203807745;
        Fri, 03 Apr 2026 01:10:07 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b23c6asm6989864b3a.10.2026.04.03.01.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 01:10:07 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Robin Murphy <Robin.Murphy@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH v2] dt-bindings: arm-smmu: qcom: Add compatible for Hawi SoC
Date: Fri,  3 Apr 2026 13:39:56 +0530
Message-ID: <20260403080956.2714415-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2lao5RPPz-U-X1pT4aq57Ou7PwC_31H2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDA3MSBTYWx0ZWRfXzDSnkX1l8DQH
 3tvmHoyX8/HysobbyqR8Ibk8KHO+Wf+DLQhJHqSprgU5KGQJagYrsZLny00/qS7croKoCXawxyB
 WkEiBqgMTlRzK7zbSo4tO+mfHRL9V8eMlkMifoeXlIymuwVutqqLNUNqWY/dLgPU/Cmrb0k1ACA
 ye4lXFKxkea/NJ5Huac9hbZhlpP+QXc2EVxpXRuwIbmqB+jYlo9+cMdvih6yKeydT4FX6julQdM
 QFQWE1YwTp48I5ejYXSsUIp53Ix0qEmHC1eSdBVZrmXISKBdmlIi6/tVtSfJzAhEerEW5+0rIvb
 zF5+2pOpzNxfvdVSxpYzbR6F51j86iYx2rKz0yqhmufiDZFaMXcMRDWPtVSZ9n6PzwAOmrqM5tU
 53zxbeXVtTCcgRNc4HG22A6j4NSwAX2ws3DylyDLkimHg4RvGflpmTAYvBxbPIbQfGWJDsFwMyi
 ZoZbkn972eW5iutLeVQ==
X-Proofpoint-ORIG-GUID: 2lao5RPPz-U-X1pT4aq57Ou7PwC_31H2
X-Authority-Analysis: v=2.4 cv=fOo0HJae c=1 sm=1 tr=0 ts=69cf75e1 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=V65sNsENKvr6zZljLJ4A:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030071

Qualcomm Hawi SoC include apps smmu that implements arm,mmu-500, which
is used to translate device-visible virtual addresses to physical
addresses. Add compatible for these items.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
Changes in v2:
 - Added qcom in the subject as Hawi is a Qualcomm SoC.


 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 27d25bc98cbe..06fb5c8e7547 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -93,6 +93,7 @@ properties:
         items:
           - enum:
               - qcom,glymur-smmu-500
+              - qcom,hawi-smmu-500
               - qcom,kaanapali-smmu-500
               - qcom,milos-smmu-500
               - qcom,qcm2290-smmu-500
-- 
2.53.0

