Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792995712;
	b=oXd+0CFims7UqmFigVmhSGk0qggpFE2Op4zwVcnivd1Mb4HS3q8qVlLS2cCDY84zYkHq
	 suhvys2zAE/oCjVK/Tj6h9e658llkTF+sYW940ntp6ErvldcO88pA5f1babWuA3nFEzOU
	 vFGBKkhbrC+RLb6k3ihRkvZ4I6zb43ta+oaqtzb3TTLdiIfWusAfh/6x99oZr2UZ94oeA
	 A2DqUWLWyeOaSpAk0RXlohhh+yUSPQ+qHuwjWOOSJfuNUuD9XJ+zFnRD7lXg69kZTgO/W
	 Dv4tDZb/c4NXxVuuVJ0hbcp0HVu3iGSFeJFOsN4WvjDfmPt8N+IVubfya/ugrCy3V7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792995712;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=7FZHHcrZ1mJoAVaF75vGJduBM/gojRXxTol/rGNXLc8=;
	b=4Bl9kkrhCJps1zYmaVSix05rsoEhgN7ehTtYUCYqCto4x8p49flMCZ4RNyYuX3ih/pmq
	 6Mx0yIFJhRnAts13HZ+PAh6qQaSpJun0bzfO/zw8nhLqFJMXmmeLRqtbErTpDzkLsGjr3
	 GBO9DCE0RqCFqpuNiZiOId2TK2piFEB1XfUwJ28VQOrLgp0kjxNKY+/GTp5GtJT/Y5oH1
	 3FA6wkfcOAkPPWvAinpnkFOEVDEx6sAIQxqWWPd6fIFF/2UN55GqhTJ6KCkBjOwE7U44F
	 HXYOJ9F2woC11bvsRiaZxhi/7jlweeth58nVELTmibMAtalfY3L7bIZ+GQt5m+FRc2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mgk7a1RZ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XBLfm8QH;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10803606A31E
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 06:21:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10803606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mgk7a1RZ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XBLfm8QH
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4arLn1181778
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 06:21:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7FZHHcrZ1mJoAVaF75vGJduBM/gojRXxTol/rGNXLc8=; b=Mgk7a1RZdCXCGXio
	QbfSnOKislywPPfSv25/GgAcrobRGFgcESsj5E5o+F6Ltlyj0ZlK3a1SBr5TEfYN
	8ZEeRZZXx6WEeMxow9+bMiipzOQz/BnC6bQy3nXyGRloULoAjYCnex9fJ1Wx9ldh
	3TuCT3XnEniY/uZEpt7prcX7JiVgp50U/1kl8FYuxaFYv7tCSxeK04BYalQ7pLMk
	1X0ju6B/As/Z+weWpq/BH3t13dbqqcYD5ey4aR1qbXcbmV5/Cri4AC8wPNtrDNfl
	Nzs+91cQMpMh7eMku7c4zO+mvmRGkztfU2wXZAp1oftG9eVJx+o00C6ZNR31PPvJ
	1l/Y6g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgn27w1w8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 06:21:50 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ab926c236aso2467272a91.0
        for <iommu@lists.linux.dev>; Sun, 25 Oct 2026 23:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792995710; x=1793600510; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7FZHHcrZ1mJoAVaF75vGJduBM/gojRXxTol/rGNXLc8=;
        b=XBLfm8QH+W1eV39P5gEmIKktwJWVYbysOIZlfzAA+2AdGONPG0byrcaxR2gCo/ng2w
         /rOoEpIuIJhpsgjmSkBbUGYyVPcnzhQR0j1UYU1qGtwvlx9CrvDAJghQYj/L5zY9yrGD
         7avRDAU4rU9TPVN1RNlrz5Gxq6M7YomrN8zL9E/yY8RuQuVc4ONOnbggH1ZIZXVyObyi
         SgArshTRbUm9z7oZL9Jy+nsW8zZ8bxO86Xjvu18atexZgdShAPZKLVcq8oESATYvvRq1
         pMPTcrZJe0ausIL1nugO+PlenRDFbZKChl2SVzI8IetlG3EAG8mp9XcCc7UVk61x4XNR
         xsvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792995710; x=1793600510;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7FZHHcrZ1mJoAVaF75vGJduBM/gojRXxTol/rGNXLc8=;
        b=OexXBoIoy9slBRi/Xfct7/GwIjqwQsDuYHWg3XJbpCjIWe42ZN6kka2/G1MkfFSykZ
         nM2xqcoWsD/f1bNmu8kFClRoCY/VQM9rsBkgNCJdSOrW60jUjfffL6EOjpz7n7durAPA
         z6uEqaW97axloG7ZBEXlqVxnTNly2Ck8kzbQ77k6LNoVXNN7Y08rhFYLdG8+NvPEFx1P
         7b6lKACYSdA0vXBch6lpLc7ZrSx1MoNXdHrqIhRpaUs9d/QcHXw1PA/P5SbAMo3OZXMq
         LxocKx0xvLqqqwQDTE2vjpLvPMgmnERXRgh7bzV8W2UisdIkY/qdmJVjSdnx1Pr7zFbx
         rcng==
X-Forwarded-Encrypted: i=1; AKwUvBzVmMqgmLMDqdzvOG4Ln0bu8YY99nCYR6tI6y89CS2lBTHXNrM44u6r3LIS1gRkQm5rwke0hQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYK/ZhiukZBiEak8M8r4SETpnrQ1pSlrzgi8DOMOcM6TO4eOoY2S
	fOpSvO1KxlEwmuMz3buW+soUkbsBi/wQE+9J0Za863qrmFLUPVwtsJDZ8sLCzvFhWivlImNYGLR
	I433gbS/f/oJsz3ecghCTcz8fWovoauvNIVCa7I14Rfi4Vn43uki6MDHloA==
X-Gm-Gg: AYBFou2Drw+C8RiXCY6RdGpVZFexwmgxfMkMEnGKPJwHxUnvA0N/0XwJbSGk1lCVwcF
	mR2dNyOJyS3w3Na9u4M59kvRCSwSsNnTbYP+2elLE+fa/f8S6I+Auv7llHGnJaOk2McdqZrzaNm
	pvLnwz1JVWGyDhJxSVCDFTh8QbFShpyfLvdO1AE0GWTX4v72taOjXca7hHXwriBplI6/ZLJz+fI
	gRn1v9sfipUvpk7chv7GpBWS/o2FvA8dClYfoxn26/8NWonWDd5bMN+MiTQHUSetXlkgGdRPCdc
	28O78e65OeYdqVC3avFDiJgmH7j53Lw9nj0r+gSyvfk4/wlCo42t2IykhcQu8ZaqotIJQR0fWYp
	W3iGasBCYWMABeubjLzAKWsjHUNuxOEwAjw==
X-Received: by 2002:a17:90b:5105:b0:3ac:9ed8:f309 with SMTP id 98e67ed59e1d1-3adeae71db3mr5213947a91.29.1792995709661;
        Sun, 25 Oct 2026 23:21:49 -0700 (PDT)
X-Received: by 2002:a17:90b:5105:b0:3ac:9ed8:f309 with SMTP id 98e67ed59e1d1-3adeae71db3mr5213924a91.29.1792995709166;
        Sun, 25 Oct 2026 23:21:49 -0700 (PDT)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1a1c56sm12633415ad.44.2026.10.25.23.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 23:21:48 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:51:11 +0530
Subject: [PATCH v2 01/23] dt-bindings: display: msm: Add Qualcomm DCP
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
Message-Id: <20261026-jshekhar-dcp-hlos-v2-1-7cf014efdee1@oss.qualcomm.com>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowangio@gmail.com>,
        =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Philipp Stanner <phasta@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Flemin Jose <flemin.jose@oss.qualcomm.com>,
        Mahadevan P <mahap@oss.qualcomm.com>
Cc: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>,
        virtualization@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        iommu@lists.linux.dev
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792995687; l=11866;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=kncwAIaVcKMmstln86ItLx0LdkQ8IW+1BDRAhbfUNbk=;
 b=xt/h2zpGk0hAsXMwAVDCWzN7PfQtq5ZhiPt4ODWT9FJcC3rJmnXtU30NINFaFtngRfr0yUu8V
 bOq3kzkQOTLDeviYjALpd9plp5w9cLZg7d6GxmYqUqdMkbX1Y80ZOhV
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Authority-Analysis: v=2.4 cv=G7GJgNk5 c=1 sm=1 tr=0 ts=6adef17e cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=Xnps2CMCGwolWMWMphEA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: PLqv7DwBkacz4W8mQ6VDRzcOPpFtIbxU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX+RbEK6SS2TSb
 0H5B5sMwdqTeVem+3rl9LV/LX7SOKE/f90EKLys/t3KygnuQYcMn6pVdoIfZ/r1XCRg1vwGD40C
 m3u1sMa/pZY4hG19Pp+sgqylL194DNo=
X-Proofpoint-GUID: PLqv7DwBkacz4W8mQ6VDRzcOPpFtIbxU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX806qGTisRQEd
 iuvpdoATSeeZ9whUM26Wi5IS7U5VagNHdD7pyZVqGNOJ479i/sYZ7GkJd1sHB6Q9sVQuH8lOLMz
 khAN/XnkBgVHBXKOByprod9BGnx0WFrwAOglTjW22NPdlHtm20/NXWAeu4Dw2/WlGlnap3chCwD
 qiWI/glkr6df68bAJ8QYlvMvy2QwCzcqJvtNkKFv73o6PYsgjg8hl2cpDDhOZOpgAY/J/Dr/cmM
 pN8bUV4n7E5BPjA4QeUQ+pJK22cRxOf3lXsWzUD4wWJutWfr2PxhOaXEPW7jACsqUhP5zdiYK+7
 8tBZ1bD3E4XWa1o7X+5Y/uelvk2HCOjEcCMvEfjyFtyqiYSM3f74StE30yciCc0yjXJcNduZpsn
 Po10xrbehba1c6Xuq0OJrO+ol9wYa+VX6AQ0XY9JuwpWxz+74fDeLuVh7UzsolJatser5J2QAv8
 RpNlHW4Eqn2eaCdWXSA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260025

DCP platforms place the display pipeline under firmware control, so Linux
cannot discover display resources through direct register access. The DRM
driver therefore needs device-tree descriptions of the Qualcomm transport
wrapper, display topology, IOMMU contexts, and panel connections.

Add bindings for the Qualcomm DCP transport wrapper and VirtIO display
subsystem. Document the IPCC power-notify resources, transport and
framebuffer IOMMU contexts, firmware-visible IOVA range, INTF graph, and
DSI panel connections. The wrapper creates a standard VirtIO-MMIO child
after the IPCC power-notify sequence has completed.

Assisted-by: LLM
Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 .../bindings/display/msm/qcom,dcp-dsi.yaml         |  79 ++++++++++++
 .../devicetree/bindings/display/msm/qcom,dcp.yaml  | 123 +++++++++++++++++++
 .../bindings/virtio/qcom,dcp-virtio.yaml           | 132 +++++++++++++++++++++
 3 files changed, 334 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,dcp-dsi.yaml b/Documentation/devicetree/bindings/display/msm/qcom,dcp-dsi.yaml
new file mode 100644
index 000000000000..9a0acaf00bb3
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/msm/qcom,dcp-dsi.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/msm/qcom,dcp-dsi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm DCP DSI host
+
+maintainers:
+  - Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
+
+description: |
+  A MIPI DSI host exposed by the Qualcomm DCP VirtIO device (see
+  qcom,dcp.yaml). It follows the generic DSI controller binding, with panel
+  devices described as child nodes. The DCP INTF graph endpoint connects
+  directly to the panel; the DSI host node is not a graph endpoint. The host
+  node uses the dsi@N naming convention, and its reg property identifies the
+  DSI host index.
+
+allOf:
+  - $ref: /schemas/display/dsi-controller.yaml#
+
+properties:
+  reg:
+    maxItems: 1
+    description: DSI host index matching the DCP output port.
+
+required:
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dcp-subsystem {
+        compatible = "virtio,device34";
+        iommus = <&apps_smmu 0x400 0x2>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                dcp_intf0_out: endpoint {
+                    remote-endpoint = <&panel_dcp_in>;
+                };
+            };
+        };
+
+        dsi@0 {
+            reg = <0>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            panel@0 {
+                compatible = "novatek,nt37801";
+                reg = <0>;
+
+                vddio-supply = <&vreg_l12b_1p8>;
+                vci-supply = <&vreg_l13b_3p0>;
+                vdd-supply = <&display_panel_vdd>;
+                reset-gpios = <&tlmm 210 GPIO_ACTIVE_LOW>;
+
+                port {
+                    panel_dcp_in: endpoint {
+                        remote-endpoint = <&dcp_intf0_out>;
+                    };
+                };
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,dcp.yaml b/Documentation/devicetree/bindings/display/msm/qcom,dcp.yaml
new file mode 100644
index 000000000000..96f6c2a17e9e
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/msm/qcom,dcp.yaml
@@ -0,0 +1,123 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/msm/qcom,dcp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Display Co-Processor (DCP)
+
+maintainers:
+  - Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
+
+description: |
+  The Display Co-Processor (DCP) is a firmware-owned display subsystem.
+  Linux communicates with DCP over HFI through VirtIO and does not access
+  display hardware registers directly.
+
+  This node describes the externally connected display graph between DCP
+  INTF outputs and attached DSI panels. It is assigned to the VirtIO device
+  by the Qualcomm transport driver and is not independently enumerated.
+  Firmware capabilities and internal resources, including pipes, mixers,
+  CRTCs, and clocks, are discovered at runtime.
+
+allOf:
+  - $ref: /schemas/virtio/virtio-device.yaml#
+
+properties:
+  compatible:
+    const: virtio,device34
+
+  iommus:
+    maxItems: 1
+    description:
+      SMMU context used by DCP firmware to access GEM framebuffers. This
+      is separate from the HFI transport context specified by the
+      iommus property on the parent DCP transport node.
+      The child context is used for framebuffer DMA performed by DCP
+      firmware, while the parent context is used for VirtIO transport and HFI
+      queue buffers. These contexts represent distinct firmware-visible DMA
+      address spaces and must not be used interchangeably.
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    description: |
+      DPU INTF output-only ports. The port number matches the firmware INTF
+      index. The corresponding DSI host is the child node whose reg value
+      matches the port number; the graph endpoint itself connects directly to
+      the attached panel. Unused INTF ports are omitted.
+    unevaluatedProperties: false
+    patternProperties:
+      "^port@[0-9a-f]+$":
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        properties:
+          endpoint:
+            $ref: /schemas/graph.yaml#/$defs/endpoint-base
+            unevaluatedProperties: false
+            required:
+              - remote-endpoint
+
+patternProperties:
+  "^dsi@[0-9a-f]+$":
+    $ref: qcom,dcp-dsi.yaml#
+
+required:
+  - compatible
+  - iommus
+  - "#address-cells"
+  - "#size-cells"
+  - ports
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dcp-subsystem {
+        compatible = "virtio,device34";
+        iommus = <&apps_smmu 0x400 0x2>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                dcp_intf0_out: endpoint {
+                    remote-endpoint = <&panel_dcp_in>;
+                };
+            };
+        };
+
+        dsi@0 {
+            reg = <0>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            panel@0 {
+                compatible = "novatek,nt37801";
+                reg = <0>;
+
+                vddio-supply = <&vreg_l12b_1p8>;
+                vci-supply = <&vreg_l13b_3p0>;
+                vdd-supply = <&display_panel_vdd>;
+                reset-gpios = <&tlmm 210 GPIO_ACTIVE_LOW>;
+
+                port {
+                    panel_dcp_in: endpoint {
+                        remote-endpoint = <&dcp_intf0_out>;
+                    };
+                };
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/virtio/qcom,dcp-virtio.yaml b/Documentation/devicetree/bindings/virtio/qcom,dcp-virtio.yaml
new file mode 100644
index 000000000000..6020e848ce25
--- /dev/null
+++ b/Documentation/devicetree/bindings/virtio/qcom,dcp-virtio.yaml
@@ -0,0 +1,132 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/virtio/qcom,dcp-virtio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm DCP VirtIO transport
+
+maintainers:
+  - Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
+
+description: |
+  Qualcomm DCP VirtIO transport. The IPCC power-notify channel and
+  associated interrupts are required before the transport can access its
+  MMIO registers. This is a Qualcomm-specific transport and must not use the
+  generic virtio-mmio driver. The DCP VirtIO function is described as a child
+  node and is assigned to the registered VirtIO device by this transport.
+
+properties:
+  compatible:
+    const: qcom,dcp-virtio
+
+  reg:
+    maxItems: 1
+
+  interrupts-extended:
+    minItems: 2
+    maxItems: 2
+    description: The VirtIO-MMIO and DCP power-notify interrupts, in that order.
+
+  iommus:
+    maxItems: 1
+
+  iommu-ranges:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      The firmware-visible IOVA range, specified as a four-cell tuple
+      containing a 64-bit IOVA base followed by a 64-bit range size.
+    items:
+      - description: IOVA base, high cell
+        $ref: /schemas/types.yaml#/definitions/uint32
+      - description: IOVA base, low cell
+        $ref: /schemas/types.yaml#/definitions/uint32
+      - description: IOVA range size, high cell
+        $ref: /schemas/types.yaml#/definitions/uint32
+      - description: IOVA range size, low cell
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+  dma-coherent: true
+
+  mboxes:
+    maxItems: 1
+
+  mbox-names:
+    const: dcp-power-tx
+
+  dcp-subsystem:
+    $ref: ../display/msm/qcom,dcp.yaml#
+
+required:
+  - compatible
+  - reg
+  - interrupts-extended
+  - iommus
+  - iommu-ranges
+  - dma-coherent
+  - mboxes
+  - mbox-names
+  - dcp-subsystem
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/mailbox/qcom-ipcc.h>
+
+    virtio@9be8000 {
+        compatible = "qcom,dcp-virtio";
+        reg = <0x09be8000 0x1000>;
+        interrupts-extended = <&intc GIC_ESPI 956 IRQ_TYPE_LEVEL_HIGH>,
+                              <&ipcc 13 5 IRQ_TYPE_EDGE_RISING>;
+        iommus = <&apps_smmu 0x15a3 0x0>;
+        iommu-ranges = <0x0 0x84000000 0x0 0x04000000>;
+        dma-coherent;
+        mboxes = <&ipcc 13 5>;
+        mbox-names = "dcp-power-tx";
+
+        dcp-subsystem {
+            compatible = "virtio,device34";
+            iommus = <&apps_smmu 0x400 0x2>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    dcp_intf0_out: endpoint {
+                        remote-endpoint = <&panel_dcp_in>;
+                    };
+                };
+            };
+
+            dsi@0 {
+                reg = <0>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                panel@0 {
+                    compatible = "novatek,nt37801";
+                    reg = <0>;
+
+                    vddio-supply = <&vreg_l12b_1p8>;
+                    vci-supply = <&vreg_l13b_3p0>;
+                    vdd-supply = <&display_panel_vdd>;
+                    reset-gpios = <&tlmm 210 GPIO_ACTIVE_LOW>;
+
+                    port {
+                        panel_dcp_in: endpoint {
+                            remote-endpoint = <&dcp_intf0_out>;
+                        };
+                    };
+                };
+            };
+        };
+    };

-- 
2.43.0

