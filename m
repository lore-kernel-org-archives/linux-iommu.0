Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCE43CDBB1
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 08:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352697; cv=none; b=R763T5LV+XKFZkhY50vwE2T90ZHEKh8OwLDXO2yJL6d73PfRyOztWuo2Wd+6jgw4yZUaBIhxfNvMsUehasQgW/NKZqeaQio5o3omQQa1AfyRBVjhpfOr+jyXm+FHsYmGlrYQhwjhxDhVi4xoXz3Yiva0ZHf2WKFg1EfDj84xX88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352697; c=relaxed/simple;
	bh=q0BBrKwJivsx1U3q4//iRRQAZdK4Wb2RemSiR718+X0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nwear8RGUq9YCwYavf6nJOSWlOV6FRkR6QcFDIzLGMpc7VJ2Jy83USWZQeogZfc2U3y/NeCc4ae3yjSe9bdOC9fLLUTyxy5uK5oDuOzRt5WWy6sp2yd9a3fno2SpiRE2jnIisuOCmdvAaMWCx4z+KKPsK35Hv1krSRa8ZAvEsi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NaiPPQxC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z+6EQ18S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NaiPPQxC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z+6EQ18S"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L2T2Yx3816667
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 08:38:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3mrpSj7hYO1R358xz6evwVlbQEFwGLz67PRgSKvrF+g=; b=NaiPPQxCTakR9xCQ
	HAOnGWPoSIKRz2a7X0Blbt4DOnPGLT7hgydJRIRPTgOaArMCtJc5nh/f3Q5eL/J4
	tI9pdv0cWJrKRHJPhw8L+NEYjuTpoShPhmDAdtXAfE03RwRURDbROZmSrb0pRogX
	VbKnBSGXer8Hd+VZiTc6auJ2BrxihPdrwhSkImE2aqQzkdT/DXL753GnnCLG2QV2
	xwQ2gNKcpvN4eLDQpn42k9LQ8aujLUEil3XZz9hAfWs7c7nINyrRU3FsJ/ftxhkQ
	phQjh+3NoTmquC3mhpKSUHCxxRQcu994GDZ82TYWHEimad4JRMnRY7kIlz1O6Hk7
	7ef01A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9saa19tf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 08:38:04 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-515224a8aa0so96297791cf.0
        for <iommu@lists.linux.dev>; Thu, 21 May 2026 01:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779352684; x=1779957484; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3mrpSj7hYO1R358xz6evwVlbQEFwGLz67PRgSKvrF+g=;
        b=Z+6EQ18SiIHWtCv0H3msvrYZLKOL43+5WosWwAj9qXBoKY/UeplAnhTcl42opajlMN
         kwMhQj4QVA2CGtglzpFsvAtd5S+FJaulCI/IZBiU4CXL/YSuJ7Zj/POMLeTcafHr2lw+
         98js643UlKA2xnJ8Xn0blee8s+pWZDtWKMPnSY9nrk+0KrU/LyRBqEVU/scVaMtVW9ke
         lzYGRfMT2JUBvbh/zL5IFdKcRbsS1wZYQphs69/MNIeXFzBAQYqoof6zIAIT0l2SlwKd
         aS54To4J3ezJaEM7UOCTZxr6RK78N+MkjzNm7yB4K7/5yvI0rKYfy3LmtYP5SGcAXliP
         Tp8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779352684; x=1779957484;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3mrpSj7hYO1R358xz6evwVlbQEFwGLz67PRgSKvrF+g=;
        b=UzSlll3W4Tj4Z7TXaZ0q0a0JwyWqMYAGxTkAYjcnuOEkUkfhY+YDQCcCJq4MAvupsY
         PV3FMonMhdFWwamYUy1reNPwtm7KN/jjS03DS9YiPqD4bObyb74LLZSXstmjU/uDYX31
         ik/xIgrreqThyeRDkqCrbA9bMYBEK+keE7CBJvm+pvZX+VrJXyT9zlURthRlEDX9OUa8
         jQk9gwXqNDwxyIDP2J3jIRvLQTDAySi90vNe6nDiy34WSNx3JYggGWgUa1n2dTHlPbSp
         GgIsh3f5CXlWdEbQyw/QXF1SX8DxyjSqHrZDLFDGvPdSdxZAzZ10kCFPXxW6RZhs4PoR
         uimg==
X-Forwarded-Encrypted: i=1; AFNElJ81D2potEn01UgV0eWWVrtkn77uCSbja4i9YCvaLWTSLRDtty8juBR4ItCBgloaTaJxnFD0Kg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzsHlex7qrleIxXxJH3AJj6atZxXMiizZbGo+HSiaVEGmp30DuL
	T7XyJGi0/OR3Vv5jwmysYZg2vyU5VJEFfxKyurlH4aJCs6mz26+nCSxPdEfSIT7CimWe0k5+4fy
	le8PAWzfklavPX1YATnj9RAjYnzERkXql7zVUlBj/SjG/BUmnR2/XzJ9t8Q==
X-Gm-Gg: Acq92OGziLDQ0sC9tW4j18xqXWlFd/m9M1OiwkWRIUr3f9BodZp199iMLjKzXs6cctN
	jDBH3p3T8dLOl0ob9qrz+orafw59DO7094SZdtaOWw2TVwMP2/Qbkzfq2DJmBrrp0H7OeWstcz2
	hYsz5G8k5oLgJwA5NC8XB3PwKHlWAED+c9AYABfG0Fsv+6Rv+h+dV0XncGw2VlpOH5boIjJg7Zr
	7tuH0mR5JYO+JvHabiai53J0OV200PstbWH6jlmJDfR8xDhkqHfk8RMZO3DbuOBeig3qiCcKug8
	EKPHi0ztVR3XgWyyaaMaEqapn7MVlrwAt+Qau98Xf1KXl2XFofRL6Pd3IFAWubjhQBKudmj/iZh
	FyP29veidnWUdOBYL3OdgyJGF+0Ul3bS1GrsWbJu9/56bnFkR3wk=
X-Received: by 2002:a05:622a:9:b0:50e:60b8:347e with SMTP id d75a77b69052e-516c56016abmr24588921cf.59.1779352683745;
        Thu, 21 May 2026 01:38:03 -0700 (PDT)
X-Received: by 2002:a05:622a:9:b0:50e:60b8:347e with SMTP id d75a77b69052e-516c56016abmr24588411cf.59.1779352683250;
        Thu, 21 May 2026 01:38:03 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903caede9fsm10502405e9.14.2026.05.21.01.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:38:02 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:36:42 +0200
Subject: [PATCH 19/23] platform/surface: gpe: use
 platform_device_set_fwnode()
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-pdev-fwnode-ref-v1-19-88c324a1b8d2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=890;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=q0BBrKwJivsx1U3q4//iRRQAZdK4Wb2RemSiR718+X0=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDsQt0KUa/w8xmB04PUNyuE7AG92a7NaZhaUnP
 mJj39PwRpOJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCag7ELQAKCRAFnS7L/zaE
 w6UQD/4rfUM5cMoT5JyGjLafVOFuEAMOc90j4vuFKnQJU0FBGgfkBhxUzbYOhzKrncHxTg6Zkte
 mhYpnojOkwe7oqrccWEFE+o7dOAFDjcWoL0XCGF45N65gk3++u0Yx4L1yZeRX+1/MxFwbvOLw7t
 FwKBQcWM/DFEoUfCz+aXTRNszmzJ4Zj6xYPDsAKrn0IwrPangabw6sMw6uzkisg8PvVArLUnLkg
 4vNKnff31zVgEoVGWoY8esEvtxLgp0RsbEXIiotSTubVLEI21pr4/gKwWV38zgpd6yPPqnTpJoy
 dmxTUwCFDJkpoT3Idq+TVNWcIyn02UHZrRwsDlCVYmVQ51wfypaNz5tTOpMvEgeDcVkvxUIAZ2i
 yULGhW95dkUtEPV0VFi5jg3X1A2b+Vbvd+ViGB+7pn4K8qQVHVRni4OB4DXw0rYFTrU9L6XirXh
 QsuSw7uOuSVF+n2JUZdDkeR4qL6AyLuLXOzO5yrdhEijTNjDhRzOMN0tyEe4gt6eOhkNE8jVJWn
 o61cKiG3FXHChYk9gR+qsT7eb5EbBOtXwgO1X13FwAGQ7Z1KvzlA4EmmqMEwLsauLqOHl/azGVS
 V1aYTijMW3c/SYhdXa4jacKaO5oqpdlh8hIAaLEQB5V98OZNElzsuX53XKqZWBrYixFuWj8HYas
 UtG1L4x3L3xmxqQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MyBTYWx0ZWRfX5ZZkrmV0KOg2
 ef4S5z4pjSYVQgFRQBQKi54yiTzbN/GW9XOQH0G3tKGtSqSw3A0KtPFjTTjtN85Nr14nvB4plYe
 XeUf+jyfre0W+IBOes8o6nH6rcIMmgVnAKzBn2vLpiw+vKZHxvnYCUZ1Lu6uScMQWhrwyQk7QVy
 NHFv/5d1Gr2MFu3Sv93RUjSyLwEeJU23X24NxoLRT4un2Q9uRaf+DqJ7oQ2R+megcl9CpHDhbX8
 LW9xZicPXiCKiIF+S2wnm1NlCr7Tdi+R8/DwM/4Hj9UMUi6ebFj4l9EKkd3vPjgfFiNCbmkGKQN
 bCzV9hSJG7W8DtcsLsMYfon4+TEBrosRWpIi43A40B3z+WGTPTMe1Aj+i+65rsr0sYgjxUhIetI
 R0+wMhjkjdQ9Tndz9anwkbO2RGC2NwGaxeWS5CXIOjzb8XPXFfdbQNeoUZEywvgs2FkyoJhhVF7
 o2m/azYyQanFLxVenkw==
X-Authority-Analysis: v=2.4 cv=Qe9WeMbv c=1 sm=1 tr=0 ts=6a0ec46c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=PjYnKYjuuXkzxcC25kYA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: ArLOdvUcGpBfg298saYwBUI3-KfIR0CE
X-Proofpoint-GUID: ArLOdvUcGpBfg298saYwBUI3-KfIR0CE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 phishscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210083

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the firmware node for dynamically allocated
platform devices with the provided helper.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/platform/surface/surface_gpe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/surface/surface_gpe.c b/drivers/platform/surface/surface_gpe.c
index b359413903b13c4f8e8b284ef7ae6f6db3f47d72..40896a8544b0a4da4261ea881b1eaed62d93b32b 100644
--- a/drivers/platform/surface/surface_gpe.c
+++ b/drivers/platform/surface/surface_gpe.c
@@ -317,7 +317,7 @@ static int __init surface_gpe_init(void)
 		goto err_alloc;
 	}
 
-	pdev->dev.fwnode = fwnode;
+	platform_device_set_fwnode(pdev, fwnode);
 
 	status = platform_device_add(pdev);
 	if (status)

-- 
2.47.3

