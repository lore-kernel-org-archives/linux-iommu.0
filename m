Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16F4364EA4
	for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 17:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777312169; cv=none; b=gkdgZxBNDGhc2eSp0x/vx6ZG9eTFyrJvsi906mGgR/fGDV2JX6iy4E00PCxa/wApEdu5V4ncErgBw/MmqNFc6M+ehDZu7CjCB0Bpzhbl3bIQTQdc5dfZIJwy5EWVMwq18vT8llTGEOHZIAeG+Z/U30QxixAITf+/HdjEV3wiAZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777312169; c=relaxed/simple;
	bh=a3+et9cPbocF4+NCPJZ6wV5DhCcxnHYplWO4owQID/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U7B2faQjHGRvB6vmvum0ukF7GZ4n7Pdma3TfoDDCz7dXEhyMRyObELNo4UCutKuoGhR/VIILMhyWYQWcG7pQPzpBZ9eEOE/YqVXa0HC/APCzlPMvFFZMuHc/B3t21KlpsC42OHIsP3y9hVt+lePdDeI3R0ttUHBNZDYWZuM/E/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JsoPaSWU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B6BVjP3t; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JsoPaSWU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B6BVjP3t"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63REEPXG2913800
	for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 17:49:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=mPZQf9l2Yx8cErRRrYkPxqjTtFZs4BkKr7p
	TWDEvXa0=; b=JsoPaSWUEBLGINmiNmjpT59Op0tQVAupsQpgdMHLN06WzJJSZUj
	65ILntdgXa5ZYOf3BrMYD3mf+FoTSwriK0SCdrMP5zfgy6lJMS7bTcAkRPXxtGqv
	RdYck8wL7clfpQHuvtiCxBc+iRoG3UjMd7Pd86OdS+4yki4uxpwjCk0DOtX0wC1N
	n8mypiz9FLTlGTL3oko0frEClCLxpWJcAMYgEoJNtZsnMjc/vt3DMchNd3wSS8gy
	nhQhPIqweXHAfaEIfQ7GFkqvrGbGfEDIqKYCWO1sYL6eSOjX/wsRUT+TopzqCP6w
	ea0gSOSbQqPubtf0Rww2iqEBwqfa8NaLfnA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt26xjpcn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 17:49:26 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b242b9359aso105158625ad.0
        for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 10:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777312166; x=1777916966; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mPZQf9l2Yx8cErRRrYkPxqjTtFZs4BkKr7pTWDEvXa0=;
        b=B6BVjP3tp+IBefTUQhjExerjSpRj7yrMlAtwIzGxcK7uXspSB7QOaxvCzxKxvME3xc
         1FFrRWo4jAisfGEHBotUl9cc3iPSyAHrn7Byo2W4oynMm0wMrem22Z14AXzvXyy5oLqa
         nBTF/ACbdeuLx4l3cEuHPaIFuQAG8glDpsM+CpZskQPfHvrZgzyE9ZHcHpOnXX+Dh6Pk
         Lq7gZgOC3vbOdi4HkUVGIU52XCoXzl+KjrEOi77i/vMWMc1wlk/AycAkBQC6QOF2F+Le
         5ieALq4qzWqFSvB+Ln0Hb09Fqwcpnbtho2UYLdR7NvE8BNpF9aGOQaEwean9OOVwvic2
         BRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777312166; x=1777916966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPZQf9l2Yx8cErRRrYkPxqjTtFZs4BkKr7pTWDEvXa0=;
        b=Guzx086k06GDBINOSsq6DbyAeHmhrIrKisbaAyV8Cl669uhR0smQ0E9qUsWFF4P4ld
         Wk+KJ/Fyy0xGVFx3nwkLwQ9fLcIWwUi/6QluDQ2g37+23Zwkcvrg3tFfGdJ7cnIkKZGX
         WNIPUt3+pNvBtlfoCJ1FlTXGE1R5/NWs9DTT9M1ve4rcPk5PpaWBLxEE9LL4e5RU69ag
         bTQ7ewZtgw+ck0oHlG8UpGwDXKv6g5RNhH3EYBCdngisciE/1esZK7n5lJ6JhClyEzwv
         cFY2sUY3b/NGOqQfSMwYLeJbvHYxAs8h6hlvZ7Z7PKukFheKrybnhyOddlYzB4Clworr
         /5Qg==
X-Forwarded-Encrypted: i=1; AFNElJ+XL+QNkZL8KOn5m3xWNHwZaf+b2Ij+GXvkUqusfTMPUs8KyngWlbsuEnQr6OpnytsZl+8oQA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxOqlvMrmaI3gd4Q8opvRm9Gv2VD1U6jYH9ojmTT8zHZ/nnRstx
	8sZsrweA2kKf95l/uPumRYnZUm0apwDDc60XqXad3BhsBia7bCsv7VqpU8cDduqEWAo9a3VnSmN
	gmt/JnaQOZwFyua01aHTjUfd1akxNc7+DoWqkr+IlvZmOhXTEryK3YlhRhA==
X-Gm-Gg: AeBDievzFCE9c6FL3YYj988bLRUfRH5fw46aDMHmU7X/352rOVqLTdCet2esFa+D9xV
	32VYmF5GeIyZhy+cGa5tROlED+niQ1VQqtBbWcC9G53Evz/Eb6a/VO24paxkCnzrqSrWsfn0Fy1
	/C2g9r+MHHKdhHhteuaxT17BnsS/GYg1cufFkKBnldWYXVwop2DjKLvYLzQbwSSD8J/PECjTL0J
	7C5+qlRHoE/deU7CfbIxerUqYbJTEw08pT9mYxlSJJ95befSGtQPwmrTP59NDIxUT+tYXz/Bngb
	YhXsdLsiglXIZGgmSp4GZGm5vhO7QqIk/M3uuo/A6ST3ee/BzHAtWqMD8oe7udtiwN32sQZGBcK
	wgE034aFQy7H9jgqC56olhhrRO7pUEAKSWvqO6/eQOK0le7S3vtYmchkdByY=
X-Received: by 2002:a05:6a21:6d9c:b0:3a2:e8f1:b86d with SMTP id adf61e73a8af0-3a398df00bbmr395891637.31.1777312165782;
        Mon, 27 Apr 2026 10:49:25 -0700 (PDT)
X-Received: by 2002:a05:6a21:6d9c:b0:3a2:e8f1:b86d with SMTP id adf61e73a8af0-3a398df00bbmr395849637.31.1777312165225;
        Mon, 27 Apr 2026 10:49:25 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976f9dfc8sm27824123a12.12.2026.04.27.10.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 10:49:24 -0700 (PDT)
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
Subject: [PATCH v2] dt-bindings: arm-smmu: qcom: Add Hawi compatible for Application processor
Date: Mon, 27 Apr 2026 23:19:15 +0530
Message-ID: <20260427174915.3639641-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: uyj3aJGxAMihjbob-1AwHYVdXTwSwNnW
X-Proofpoint-ORIG-GUID: uyj3aJGxAMihjbob-1AwHYVdXTwSwNnW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE4OSBTYWx0ZWRfX3PN7/lI/1EOD
 pDgJ9C1vVze/RrCKb8fIhOn1CMOGniBmPfx3WTT7+Mud/AhYNlLGD/XH0bi5ZrUs4AR/kTxIfic
 CO5AbZ5jLFkQnlKustkmUYQaT3WJKT6OYlm79RqG3f7kcjl8R46N35ZwMdOXIL9rqoh8gjJF4Yk
 0fal3fC/2czzn7zNXM9a4iQl1fVJkbkSyPTomfXFsRyCHioydjcf3ztMyXEsmhw/XCgX8qhmyy1
 xnF/TTLRPbdiIzqmZvdTvigxDjPtmXhjmzLbAwq9lnyq9+Z/rUpp0vdTmsd4nIXe8jr9915Vjhw
 mjMffpxnVbbZrtSIJ6MmAGxOL9tQB2UHS1Sw+KTfPpMKYxe1hsnBnqOzbcM+0dAA4zGhC9bgh6w
 TWorQsHW7eAaKLAVi/pOoBJFxQQ/PLA4whTEgIqx77+DLV+gUlqH664ebCYVj1SGUJfXZl0z5QX
 MGqNPUr509lmn6uzu8g==
X-Authority-Analysis: v=2.4 cv=FM8rAeos c=1 sm=1 tr=0 ts=69efa1a6 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Fuqji3Hwj9YOp--83a4A:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270189

Commit 5e8323c3d528 ("dt-bindings: arm-smmu: qcom: Add compatible for
Hawi SoC") was intended for the APSS SMMU but was mistakenly placed
under the Adreno GPU SMMU section. Since that compatible is also valid
for the Hawi GPU SMMU, keep that commit as-is and add proper
documentation for the Hawi APSS SMMU here.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
Changes in v2: https://lore.kernel.org/lkml/20260422083329.885979-1-mukesh.ojha@oss.qualcomm.com/
 - Not a fix commit after discussion.
 - Not removing the earlier commit change instead add one for APSS
   SMMU.

 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 06fb5c8e7547..07b71b347205 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -37,6 +37,7 @@ properties:
           - enum:
               - qcom,eliza-smmu-500
               - qcom,glymur-smmu-500
+              - qcom,hawi-smmu-500
               - qcom,kaanapali-smmu-500
               - qcom,milos-smmu-500
               - qcom,qcm2290-smmu-500
-- 
2.53.0

