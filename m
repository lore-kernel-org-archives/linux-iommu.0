Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC79F3D5C10
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 08:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352705; cv=none; b=UBKcHvq0+vrPseYiOnM0LiSCUwhi4UiHzhlDp0gFALEbLXKkpzslJZzATJ/0Q1BQoTeSrQqWk4Z33zyNtE7EqnZOZe+VPJZh1SQyKOx+iUZ6x0N9ZlQC+AipPyjbQ7+GUX1PTPg0dPDN753ssMIcvAEKt9EIOdL96Pt4VKPPqBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352705; c=relaxed/simple;
	bh=4q74vFm5uja4ZnWq1lcGzJHIM1G0GMuR0uWtoVmzh3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WDHsvj3Dwvpw/zrZzb5j5fZxuviSM5fWzmUTTlI6mm9zADBpwx15k8aa8VAVma9e+a3A1a6HpCYE51X2VK9eQDjWFV2VX18mg4ImYFYiZXuDuzTi5+dB1/Y+riEkXZUNxB31xGcfgAk50VYDxUEKY8doE+TZDWTnHPCVPnm2UF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dp3UWx69; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B9g0rVq+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dp3UWx69";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B9g0rVq+"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L81gES748668
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 08:38:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	69XgShsEeNDkbLdefBHgY7gGgfsPixaRaQOC3zvYX9Y=; b=dp3UWx69oG0Izzqc
	yeVxoq5UdBu7a2A5JsdE3LpwUghGj6zyXyNXxJfVkoK2mT6E0w7BUtcRNvDKJPPM
	TN483t10j4dVSOUPBeYIPB4OEWaWYKpPHDxLi9/U3Cu6Dv5xHACGMEMS/O3C+7pg
	ENnjbDeEoonWTgWTDsEHEF4VPpLACWr8LMfn9DGXinYJqT+0rcYYnGN2vr5rqGlQ
	vKYV2wGiM46rQucyBmu94NmsS80Q4h8NFk6PeJWUG+EEWF+skNymwcjQrsWkEcgG
	47q0scBNIs0YVcoJe9EK27ewNLcZmI2/hO3oXU0N7wi+I5HvNEYxli6o0M5m3zzU
	L3c9Eg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9fb6kjep-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 08:38:10 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50d890580e1so127515941cf.3
        for <iommu@lists.linux.dev>; Thu, 21 May 2026 01:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779352690; x=1779957490; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=69XgShsEeNDkbLdefBHgY7gGgfsPixaRaQOC3zvYX9Y=;
        b=B9g0rVq+suPjw4S3/zpBnFVOOX2G4/2HWSs4CYcM+AncLQ9ryN3Eq73tWD6D3c03/T
         kzISiJpazoWLZZCHDK2NaMsayWoxsffPHNr7Vq2fmr/HgkZA0QZ6XYvAEWgu+XH3dwTh
         ZVW+TYbWo85EatcCUM/3iuODmfsXN1zXN+Q2fyJ/viUG2pJ24tzSpbKd1FOZ2GeL6Hx8
         fNNkDhPPI0hnJHyQQTPmaLU5gx6YltGT5zfXYUldPwXARtwSR61spRgj8f8ERXtzEu6l
         ymF6dz9YqZG7NSHTX8x3AN65g9wOfbJ6zxLl2kvYNvxbmJ1p6V0YwFr9IxicrUMhkXov
         ijCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779352690; x=1779957490;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=69XgShsEeNDkbLdefBHgY7gGgfsPixaRaQOC3zvYX9Y=;
        b=BDUMWvD+Zk3mfg+UgnLZj6Uj0YrtadikWEpTeO0jzGdGH1gedhVOa6q4ysM6EtDyK6
         rkGPYvHk3s+UUJGXWZ5zJd02qB82B65IckOWkRxeNtPKjOCk5fX2b/oB0Uyo+NyoKdrx
         IyD8/U4js1SgNnxdw+loWBuz8SOYiSO5aK9qp7iy+Iy3uQ5rzmUN+kWxwEaKNgchcgKr
         f1obGG4Cw/ZzGR0ciMPkMPjfcwBVdXoYtk/JDZ2LqmHeXpl7Ynv/A8ow0RQuUA1CpWrd
         0hod9S/S+H/Gc24aa/21TEvF8zcIch8JOj/NRCWlKE3UIpLjNQF+BDjPjrAqbqlikEso
         OHzg==
X-Forwarded-Encrypted: i=1; AFNElJ9UuQys23NYZcBr45SPGxcSOThGHQT/j73zkh5NDXRH+0qwAVoARp4Mr0k6RZLb0OFgP15rhw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzO0HLntOlM9InQ8G/8zrF3BIiFyG2aRERfcDcC6/W1PV8mTC4A
	dluvsqqW+HwSh4DmzwLiK31lU8TDQHbtavwMmKjeagv2gfCNgELof9i9eRutpEEfvI1XMYlbeTU
	vfPaqt8iTz9OB3R7UANjzCvdxwK0q5hzFz6FVk4ePdN/aI1kK81himp0egw==
X-Gm-Gg: Acq92OGefq+ZjCeiMhdLHgG5UKonkSvzMbBuT+ePwt7dLJSZGCzxS7yad5mlDXEAvFs
	TxeorBOUNeNatVNKFIQTd8Osymrf04gwXzdoewzc3zLmm2XVlVb81xAAglSoLwyX9DpONpNT4Tt
	TqlGlZYlvXzk1hOU4Px1fSfs/hqxgJzL7mrROpG8XRvG9IpsRoVJyRHa7aCfUR4/PQDN1BVztGY
	VmVvA8Ex5tfVyC/kTkKAUkZjTkxMLuMbM64iT8OqmSl1ngcWDYub1LVxjwgfrLgZSpJF0+FJopx
	QgYGFJSmP1EFHviENwEZPrrhKvQliJIvy/2TDmMV8a5XgSn5X7YaQS0K+gIV6V+73Yt7tmtXA/D
	qBmy68glAnaRVwHZob5uYhjQ+Orsu2zf2AOXi4aZCRsmKM7MdC6A=
X-Received: by 2002:a05:622a:588c:b0:50f:bd51:f1d2 with SMTP id d75a77b69052e-516c55aa333mr23589501cf.50.1779352689760;
        Thu, 21 May 2026 01:38:09 -0700 (PDT)
X-Received: by 2002:a05:622a:588c:b0:50f:bd51:f1d2 with SMTP id d75a77b69052e-516c55aa333mr23588731cf.50.1779352689012;
        Thu, 21 May 2026 01:38:09 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903caede9fsm10502405e9.14.2026.05.21.01.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:38:08 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:36:44 +0200
Subject: [PATCH 21/23] usb: musb: use
 platform_device_set_of_node_from_dev()
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-pdev-fwnode-ref-v1-21-88c324a1b8d2@oss.qualcomm.com>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
In-Reply-To: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=976;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=4q74vFm5uja4ZnWq1lcGzJHIM1G0GMuR0uWtoVmzh3w=;
 b=kA0DAAoBBZ0uy/82hMMByyZiAGoOxC6iyQxs/Rjohg22JgwSDvEJ4Zjh10SaAJTOCBC7F8EF9
 YkCMwQAAQoAHRYhBJHlEy3ltUYde6Jl/AWdLsv/NoTDBQJqDsQuAAoJEAWdLsv/NoTDzugP/i9A
 ryldFb9FSAmLemEO0qiGBJZcIslmI4+zSHLUyf3mJErewenQEkrJ67YaF+/3EQ5MKNyh9GGap4N
 HtGBX+rVKJiaLObdha+gBxpyS6ODT5vek1/ttYbafQUROxyO4O/xUTmjpefynxigMDNr0fgL1I/
 MWZCvQgTDxHHhtsDCDBN1+NUaRZxPWR+JJL1w8kNd4dDzckYCA58SP9ww5I7ra7aru1xMOrrwGl
 gs7ae1gcBWZ8xKrE27WxLDTib5j2LSaEH/HzjVB2moA+g+rRDXavYwEeiK5D8TWPW9yL8zD258S
 zCxRfgNNv1zSpQWkB8N8I+VinrR92PjRSlXon9wPiLEzKpKNC0nINH13V5/sg/3aHqKNLCCgyKI
 b8aSrCdHIpqpUTfORHm9i5ite+y9BjPMj+rIMrXi2RUGIsI994PQUL7w5QFe6P8YPwzHLJh/NGx
 /buuLbTuDArWEIxlY7UzZiJjOApMS4cf4UOi0dqDtt7b2z3XxceszldqYh+NVfxhtU98dhFizvw
 esErqQwHHDTfVZUB0S9c76YGbrNCfYAx2dsfizUx6MiEPZhYlZzigAfT3rvXR37GSjkWEUP9YMG
 2ZTKMdi/8fO5AG36zxqYmmFE69pEP1X1dEk6R0yl6Zg7ycYddoesnbfoQSrg+iX/XgrEqUYYUz6
 XAXwV
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=do/rzVg4 c=1 sm=1 tr=0 ts=6a0ec472 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=-E7rG7sKBpYtUKygALQA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: FrNbkiOrHl7-1Zx4G756vtA9Q2QEhm7m
X-Proofpoint-GUID: FrNbkiOrHl7-1Zx4G756vtA9Q2QEhm7m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MyBTYWx0ZWRfXxzYZRiH6a3E7
 ddSetR+ZJtgEVEwhVssxBDHI9Ssq2p5tY/mHuXNzsaQgQ5ufsvK+WXpmyDTHILZIQEJKPmnaQMY
 ShNA6z6E1lZIuWJHeLZkEISJytXCv8YWyBrZW4l4K7fCKi4HEU7K+45GyV+Fje5DxHJZK4WJtLx
 Q4fNA4PFqpcoF2wcM+WibuQ52elgJ8jeLEw4siV6Bs/fAZOkWboKwmUSGnUF8TJvkZlx+/Yj3ZL
 YNLZnjJH8NrJmfGFDekO+YUMsjlBvRDN0ao5ZahyFdJdJnTWMR1RII7t8CBUVhSN04Q8LsH0FT7
 np1XEZNYPIpY+GMQbpmsBjKy8a/CUhvTqas901B9nNumLQsEye6hmYeUC/oNfrdn9hnT972lIOx
 P6SxWmvt4b3QVQIyleGSeNBgzeq7ENYvIJSucILUWTeBEBselDglFiIjTnI7Hdij0bPlZ/5Oo7D
 cQm3Ow2azIq4htVJfHA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210083

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node from another device for
dynamically allocated platform devices with the provided helper.

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

