Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E2740A924
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 13:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783343828; cv=none; b=X04qfy9u3Uwn3Mk5ISbs+jZN+IC9uCmrIU+GtmCGT3+76bgWfwLyheZ4vRDUAZjRJcJgOUWtor7UDh3xT1NgD8mHKp2acX2O0/FP6iq7n52CxZ34UQZLLdXyg8Efj5Qv1PDsr5WFvh9N56NPd/e8D+Qd0dZap0tvYGV7i2y4e+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783343828; c=relaxed/simple;
	bh=XyyiviFbpKDvWYZ20ZXbahVi66ptZuiXaKVx5fy/wOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zngc9IL6H4g8SFlXZ1FonFL1/iOlWbVbemJUTviYqo/ga14o+QIM9K1yk90yKwu/nsY73/VUAPqjloUlHTUMu8FtLPHtSsmGh3hKBcy0RZLaX3A95ny0A/TenYvbdvjYSjDa/8NLHGB9A5YGXdSEkn0gBuKUpsZPGtcIl0GajHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cAHAxf1K; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ma45KL2q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cAHAxf1K";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ma45KL2q"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666Ax7XO245529
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 12:45:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/bw1TBf3fi+dzITRL6JxlDKqLulHveM6zognFCNzexM=; b=cAHAxf1KaFEH1dEa
	Zhonjd8lqW6rXiguep/wVXHJv97/js8xqR9yyptCdQVInJaPAnBHvZoEKVIGZG/E
	qgSF+FHGlGvU6aovk1R/J/uA0v2CPgen+Z9mAC3t8u33m12/GLMnDgxlwg3pE/nH
	zqY6fTyIULWXeaL6LLn37EhcKQ1K6A+edqKbz+9tIvAfqE02EV14oNcNACqTDRi2
	TM5LzVGESUu+nlBifs0+XJ++JRYAw5ohDvpImiOvmBdIDVK3k0geXaXXB8IvY8Vl
	pDe267XI9IoHGh6Y9KN2BD5bpYAi21o0zNNM7dzMsgizVN/2D2h5RThVAqtgzAKR
	eGj1ZQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a98gjqp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 12:45:46 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e5e38fbc5so264184185a.2
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 05:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783341945; x=1783946745; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/bw1TBf3fi+dzITRL6JxlDKqLulHveM6zognFCNzexM=;
        b=Ma45KL2qmdxNfvU+Q8g8a5O/OTJlY7ktEox+W1YcvCSoZ6k7kTmYsHNvNAraPdGcEs
         N3y2fskKCQQb0/QkmBVCR2oXuBqU2omsOGcGJz6eUuF1Oz6rYFyaRx1EPswU+eqOBMXx
         GEID9ALzP0B3b7jYwcxpmOECGaw7JBWFF0PTN2hRZ2OOKJ7lI16wljZERJspXp4nB/Lx
         t/iiF7Uf6r2/Mf4GfJiqJZ0w43HV/FXu1F7mYqCpxyqUuEvmPltvJrpxS4ucDv+ic3eQ
         z2Uxh1FFNkeKKQwzEgxClBaZtl9tUgvG0tSFsZKVlBHZxK/XkBTiKKLYB/fy/3IJ1Xc1
         Zf3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783341945; x=1783946745;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/bw1TBf3fi+dzITRL6JxlDKqLulHveM6zognFCNzexM=;
        b=CIJiNbkFLJ0VdrIIPzCJRP7jausehXn+TC02Q8Gf3BsV2RnSSIv33aQP60KqPfuLBJ
         SsOn5jbBdg9KnvYXUzWBvd/L07v9cUaPEg2KttKoGz2dn+NMnO5itJvffrNr/6WZGb4i
         1EHvoBvNeYOlKKCaWHyBhJ6gNuEcVOWrboMfs0kxwfN/dDAvINnkPFGMY19w80cZ/I6l
         ncbz3lDh8Xre74I+h03G3hs7kPRS/K/OMwj0PeYRnXzVV+UxlhDMbyFm75e5/vPqfFOx
         vovPADGDL/k6bso9XEPWA2Q9AJMh4c95clmzfucGXzeoDOqWlmQyBoc6iuCf8YjBZ2pK
         /Gew==
X-Forwarded-Encrypted: i=1; AHgh+Rpw9I44G6qU9tFyCRHJoGEl8TvM8vKilFYRT2qpB12JDcUvub+6MsRmIIgl5e16nIP6mya/yg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxdfCVNTe4lAfzsV2iaHBu6x+qbQKFbpJ1E/2Gyla74NpNhBCi2
	A4Y8KdEs0t0XyUHEEXTJloRHvIYsomUgn+NWYgl66vHEayLvh5tYhbBqxnrPQQ095lRRzW7F8xw
	zJnpZ7UuVW6RGQh/i84cjpTOLSiiFzgAySOJSIyi7Fls+KSCS3YLXb59viQ==
X-Gm-Gg: AfdE7cnqsqi/rasRYhEbqwnJFrLHVWSvSLuWIilZSNReSyyilnb0P/+J9YBhdVwSvqo
	+ORq3g86uhmF/G32a8U4TH1fc6AmTk6MmIzA71sx/9A76jf9aVT3g/GJn/TO//xhIVffnBQzTZh
	/9ZT4VG0i7FJAM1idn1+XejwGZlcCJ8oWBSU6GWICrBlPO9myCO6gJedvZY/FxFsOqYwK067zPv
	mxIHht+MhQsYpyXUio2OgXvac/IpP8MHc6H3j/CnkoxM6dJsu23ZP+PtNyBNJywR5meAPAzPbsU
	nbnqRkot61V5ntL8L57BdO50JoWYA8R2Lfna9o9q+YCOYvzC73hyjDjjwk+tebE3Oh4nOM7Uu/5
	KcM+f+deOOh5z2+ya/Le3hY3n1jNbDvEap/prsGhY
X-Received: by 2002:a05:620a:1a19:b0:92b:7420:bd5c with SMTP id af79cd13be357-92ebb49abf2mr55504485a.5.1783341945055;
        Mon, 06 Jul 2026 05:45:45 -0700 (PDT)
X-Received: by 2002:a05:620a:1a19:b0:92b:7420:bd5c with SMTP id af79cd13be357-92ebb49abf2mr55493985a.5.1783341944411;
        Mon, 06 Jul 2026 05:45:44 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm22126539f8f.31.2026.07.06.05.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 05:45:43 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:44:30 +0200
Subject: [PATCH v3 18/20] usb: musb: use
 platform_device_set_of_node_from_dev()
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-pdev-fwnode-ref-v3-18-1ff028e33779@oss.qualcomm.com>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
In-Reply-To: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
To: Lee Jones <lee@kernel.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Thierry Reding <thierry.reding@avionic-design.de>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Matthew Brost <matthew.brost@intel.com>,
        =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Peter Chen <peter.chen@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hansg@kernel.org>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: brgl@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        driver-core@lists.linux.dev, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
        iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
        linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        mfd@lists.linux.dev,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1042;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=XyyiviFbpKDvWYZ20ZXbahVi66ptZuiXaKVx5fy/wOE=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6M8unH/9uMVuERAbDU7JQgdVNpF477whb/qV
 h2sU1vkV0eJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakujPAAKCRAFnS7L/zaE
 w3ASD/917v/2dp9sMu0sQ8gKP5j4d3vmNIIb1xOTgzEHqv0OsHo3Lb9hyL7cLuo7aJkCdKEhLC+
 tyJ8mOcyTKIzMIjnNz7P46mrgIH/Ez2a8MsJaJNtUn2vm/TdGDsp6oD0Z27+aqXvIIBJ1x982k9
 tYW1zaY82nmZD4doBZESwvmet+CCcH4uFFNRXKjknczQUi4PR2ati7XYXfrvn2JAvTNfnOxiFXu
 +SrK4u+NByEBmygBJuoyXbcpqkhQ09hZTQeyT+0mwp4oX468xnNL3RXSyFpg3qy9EUoDtozrmej
 1/cpGxHdGtr++fX6VPEA7p4WO/hAcEgCd5MjXs2Yrc2PMwYDQivAniA5hYQofIrg5nZQKJmLY9F
 QNE9IhjwU2eo8lhVzgaG70/sH3LAdFOXIcZgF0m8xyobA/nfvsy2ZISzyb6muZr016il2N5Sk+r
 r5qk3BMaeykc+A5j6xoNzT5gz+bPiK3MPqOyAq6iir97S7ZSS+X/+jwqd7uHtBp2xLe7bxNAHQk
 N+3c/OzFA1YPhT67cX60BoP9wwOAw3IRlBD23N8m1G8nEzViIeMSygW12u1/EWimFokxYzbDni6
 pz5ci1zOxl74U6f0ojOB2Tsdx5nRwx125VBcJdikdRrs0oLWZAgJnw7SnYRMJAAW4u4FC5vZxEw
 bhsT20MM2rZ7M7w==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=SpigLvO0 c=1 sm=1 tr=0 ts=6a4ba37a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=ndL-XpQVcrS1Utx7N0IA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfXxz1/B3zrxTLN
 ihfkXaP0k8GEGzladf5ACrcXrsIAm1l/ha5DBpeHI7V3fO8dzWoYtwW9Aq/sEoIWF5WA6gQV2Po
 X97uraKU5qj/TJCVatvCtw38jr4seFCXeR8JnnbPSYVVKPktO2z6INYYuLTQVC8aGlvBX+RhFvM
 l4vjLOHZcwUBnxbQll25cMyejWQfx20Os9UICgRaKg/gYbfuo2x4QTweRf5qPD2MIuocKXuKTyi
 28L+LCtX/cuQcwyaE1Os7A7QyZ5mfTQu/JXNKJm2+SOZ384ZU2jK9g6Fjeu7SanHMgcGHMQODyJ
 Holk86TlVEXi0LJk8QM8jOJ+9BmIow7DitHylLDv0oCgLxCt0/fUIQewW7ZcufysJ7tiy8/cD0i
 pQxuZ41P/7+KnBX1grw4AdyFQblx7E7OYHk7W8iRTjUHDe66qsaPh/T4w/qDM0zzUpzjpLksEFW
 cimpwhNL4YawsCcW7+w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX1LDEkSFxnEqC
 QZ9IITlz4/Cxy3kYIiCe9E13ExeYe4iYWXJQy300j5R7tyeGDHRHlj7VPWTUP4V9V3NANhHFm9z
 M+PIjCO5hVkLHYMCwIgufztYrcBTDCU=
X-Proofpoint-GUID: Ze-apbOzcRnUoeB6xPdm9-aGRGZIrpOp
X-Proofpoint-ORIG-GUID: Ze-apbOzcRnUoeB6xPdm9-aGRGZIrpOp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060129

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node from another device for
dynamically allocated platform devices with the provided helper.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/usb/musb/jz4740.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/jz4740.c b/drivers/usb/musb/jz4740.c
index df56c972986f7c4f5174a227f35c7e1ac9afa7ca..c770ba576f05b6b672836753cd9b696b752d017a 100644
--- a/drivers/usb/musb/jz4740.c
+++ b/drivers/usb/musb/jz4740.c
@@ -273,7 +273,7 @@ static int jz4740_probe(struct platform_device *pdev)
 	musb->dev.parent		= dev;
 	musb->dev.dma_mask		= &musb->dev.coherent_dma_mask;
 	musb->dev.coherent_dma_mask	= DMA_BIT_MASK(32);
-	device_set_of_node_from_dev(&musb->dev, dev);
+	platform_device_set_of_node_from_dev(musb, dev);
 
 	glue->pdev			= musb;
 	glue->clk			= clk;

-- 
2.47.3

