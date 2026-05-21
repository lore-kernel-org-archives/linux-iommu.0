Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DFF3BC664
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 08:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352683; cv=none; b=mCZ14OU+knOdvK5fycp6g2KaLl/QyHXS7yHBdpeFYwsrJOewws6UqFI8cenWPWFBxZZ9+QJeaRGdB9pOoUhLrjZreCzjjY/S0L48YmNih1NDee4LhF3XbsEWGmhd5SZoYEbr4cCqliyCf98GyAXbDFfNRJbPaFU3jx51QrObmIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352683; c=relaxed/simple;
	bh=6OXt4TN+oyzNJeMucuDRbXfo0ddns7kCLrcZYoYbhVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qgm+8Z5l3SWRQB1nMb4/Uo0MwtdaLh2ozmMTSlzI6aWZhC5vVs5avct9o06pQEW8CWe6frcGdliYmpEqe3o54RVF2/FTT/i31VSFlA3tGj+C3iWMN0CQ3Aa06F++zNmJeb01WxBF1Hu3n6lTaqnsgie3UgH8xBGLfjHfhShh9i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i8AqoLjg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S1D8lBfm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i8AqoLjg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S1D8lBfm"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L7Kq8M119200
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 08:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RXAOBdXd+1ffOftB4RMKqDkV2t2QAsqWzgaXmcfa9Sc=; b=i8AqoLjgiIkq7GcJ
	lsjiR0I4WtIojYGqtVtwF52fR6iHWOrGT+oCUty/GufZbKg1DhFJDfWVn0vJe+k2
	ofk30wp/PmTLE2YxNMSy+M499peRN3Ix32hLCyKX2PqL54mJ4UQ4B7BapeUCkf3u
	oQWGLbTVnQaQhCzmq+IXJuEIC+nlDoW9US9uoJvmozj3/boYnXNd83U+R7S/w8eu
	SKRCBNmW1k206+0pxOW21bjP2ZUCfreImjrKLvY1IEZhxLn+IDe+EL44FFAr/BDX
	Q/yvzzbeIQnIWmRf5SYA6WD8oIjvbPeAEmAhwYIQBtz5Y+zD0dr4ThCpzw+Msqui
	9un7Tg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ee8c1cv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 08:37:48 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-514b5d6bb45so79661341cf.2
        for <iommu@lists.linux.dev>; Thu, 21 May 2026 01:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779352667; x=1779957467; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RXAOBdXd+1ffOftB4RMKqDkV2t2QAsqWzgaXmcfa9Sc=;
        b=S1D8lBfmTx9zZP9Fg98NTRfb+4BsO8FbQSo4SFY42Fn7aPGcn5SdFurSWZmL/Aj6U5
         Rtnm6EAtR7Yn8/WeBKMXMOrrOQrNa+xu1pZiUCxw1HmjXfDU5tEXVF7M/PeGLazWha2g
         l/PLbMVo2xiFA74ossVtz/wgxWR6sKjBaY/KB9eWE5JHa6mNm73AqlxT8yP+NnVHY6QI
         YXnM0UQ9BnlueiHVsL6ox4q7h23/QorqO8TMyfJJOPiuIWq3WoeSGZi6douiNxhDN7ve
         ytGAVtkxSH9KI3UhQELtTgib+ie367G/rlRnsqYzahI9H0JgxrRtICGS09bV8/rZMyn6
         dTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779352667; x=1779957467;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RXAOBdXd+1ffOftB4RMKqDkV2t2QAsqWzgaXmcfa9Sc=;
        b=MNIgKvVR632SLEDvWFjn6dmM0U3Dp3ITSeqOFawL+1HHJPJ5SoEVSKAmpCmuO4KDoy
         eqR1wJioyXhKM0eAw6oMP0JnijbKtiQSTW1q1Rcpk1Wsl3bj8ED5hLifV1faSaHD8y/7
         aqzW5VG72s6QiEEwWPSdPiLJG2iDlPVRIZxab96RBRxO6N4ZTmyvZdx9P8G/GKwXOBx9
         qe3qiPq9NMXgfsNj74U20lURLgV/6hXX12fDJUtoevBC8t9kBUGyKtKBkd4LXXDZKa+b
         6lUu+vqBckR/DLx0g+UzRqFnstYiOjtNU8hFafD3mXlC6aAHVGpjORLDWU5YI8JGSKBm
         z5XQ==
X-Forwarded-Encrypted: i=1; AFNElJ+FrCX7cw0+GsfGBF6daSnoE/LJKwqBwzlQa/chJoXQGcUoP8eQuuQzmyi7MKJ+KoZejrN9RQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YysW7OJS0cB0ZkkhWb0BQzuGJMCnup8j/OJsYPmodGA8PD23yhW
	cagUvot1iAAZW1KUrVYlj71nxPNYYySRbii5raIQ7FdGrAabFuzh1nPdBDSg/aci9MZDHwiVkwP
	e6+MxVQRj1OBYweIzwFaxOaD8IVGAmoTVupbj39gN7d5E8eyO0d+y4nV5zw==
X-Gm-Gg: Acq92OEB0/VvEJSeydDmYpoT1BrjGNgcANA2t1ljUpK+CgRiNWlTJeQ3iftkUNcRJfB
	k3COU0xbsh0+vAr5NzEWG1ZWLRSuaesSjHH8E2ZaD4V3XGkJeL4TUktAodLO3tzYo293dzD7S4o
	7L0itmW4W5ry6dUGJNvkDPPunlNp/Nx8uYXsjJEVK5h2txp2lqVjuKLPqVhgQkBSBp5ykY8STpd
	ckAtm4kWajqVxNdLTGG92IwwehKGHaCFvmMCEL0bsBGTgaf5vWbGvY5sHzW5UIH28binoMziXWd
	qop7KVd3U4CJEXxe9LqaIqvh/uB1sai30lWhj8nE7iDOrKhvNobtEaDgeMWMZW+P0TYdL6tZFVm
	m2xXT5+1qJbO5/c9cMSW/i5ZRU640sxj5IlZHXgmt0vZJafIQhBA=
X-Received: by 2002:ac8:5a95:0:b0:50b:4b3c:7554 with SMTP id d75a77b69052e-516c5489cadmr25663621cf.10.1779352667057;
        Thu, 21 May 2026 01:37:47 -0700 (PDT)
X-Received: by 2002:ac8:5a95:0:b0:50b:4b3c:7554 with SMTP id d75a77b69052e-516c5489cadmr25663371cf.10.1779352666534;
        Thu, 21 May 2026 01:37:46 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903caede9fsm10502405e9.14.2026.05.21.01.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:37:45 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:36:36 +0200
Subject: [PATCH 13/23] net: bcmgenet: use platform_device_set_of_node()
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-pdev-fwnode-ref-v1-13-88c324a1b8d2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1245;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=6OXt4TN+oyzNJeMucuDRbXfo0ddns7kCLrcZYoYbhVE=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDsQptve0VPcHpfn+e8CyDZ9KcfXURx6hUsS4v
 XFGh941uXeJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCag7EKQAKCRAFnS7L/zaE
 wyw5D/42tCVAUl2uN4fynwbhyfyAyJgpscqW776mT+6TzShiQ1UGxlOeIgCoWTORPdoxwAORBgi
 PPFLgP8bYFnocTq4h5weZ5vNP/hv2g/J9Lmb/zt927UW8vXxtOottjnSBfTm0u0U/GJ8rgc88T9
 mpUOe+BfoixY7hzEMo1fIyF3WIaT+57oPDmyTNSED0/c4zBG0NtfjvfR+gbfyw+PuIfqaYcqeJk
 tuNS1ok36qM3GOUcpctRgzg3Gcj1c+Iom9FxP0Bxk1yxox6RfTH4YztKKst7Mak64vyUiHCbs8M
 cE6y1P6VvOYN9ijA/4JECYo7OgRJXtVQi1bQi2sofdLn4SkbV9PZe5fLALG3ChG2z+5CM6DLxnM
 ZTA0eltoOvmsMrE2KZKeX1cvWCqDNo1HP2xCCVBojp0pJ8mz7D3yTBHU0hPu6gxae8kQbUK/6PH
 xu98r6TPU4z+Rqt99oM/SiN9eDH0DJrtNLwXfnG3TvI60P81jYDEL0d3DAeVHomaowjoVNIef+L
 drTrKdaF+coQ6GqegTUdvOp7QizyZZfUuFufo6Io50ykK1jKebxa6rHDPedMyGM5//lsygsV7ZP
 qrz3VtMmHLMLX+azIV7Z/k3f6O6HZOx+2rpYF+AVt8E7wZbqRkNX3nvyQt+iEqoBKw3npAZOhCa
 vgpklhyoZwDkrzw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: PyqEgX0awj2K75X_VH220GAjed_HdG9X
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a0ec45c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=_l4veLwUkFW-k-pZneUA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MyBTYWx0ZWRfX0YNjIy1rE3v/
 bc/r2Vol+1uwTv8fioMjswTXllSxIVli/SRS0z05X+my6uQVhspYVtG3D92bR7/kOODZe7Irkte
 2W0U61FqEh7hvq226LiUMWcZhu+zTgJ3Guo+sdq+7r9NyWP6D9H7aKOGDyBur80BHyNLvh4PBz2
 lmjRHo2azvDX1+60i1nsqtcEU6FQAwgIqA02yX+ZOndqdcSC+4SBwgynxzrKYdhlX+FdJUtoSWk
 W8ztdd0aqDjQinAsGa6SguRx8HCQVHvVetrd16/FsoeBiR9ORJPkdvuXQglCaBHTCieu+R2K856
 7FRXMDU7Sqm31RExq3431N8Nxnrele19ThLbh5oSXSW2KVJQ5TiyC2ctJedNovwCZWeoix0qgz6
 EzFDim+aEaC/IjI5rFtVvQUiC6V60f2UZ6hIiG+dkguVfWC228p64BBWOCbhD6MoYebftUjeUTG
 ADu4LXa7bSuYuiA/cog==
X-Proofpoint-GUID: PyqEgX0awj2K75X_VH220GAjed_HdG9X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210083

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/net/ethernet/broadcom/genet/bcmmii.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index a4e0d5a682687533a1b034ccf56cdb363d6b7786..451b23a039cebb777f356f64924838230052dc45 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -490,10 +490,14 @@ static int bcmgenet_mii_register(struct bcmgenet_priv *priv)
 	/* Retain this platform_device pointer for later cleanup */
 	priv->mii_pdev = ppdev;
 	ppdev->dev.parent = &pdev->dev;
-	if (dn)
-		ppdev->dev.of_node = bcmgenet_mii_of_find_mdio(priv);
-	else
+
+	if (dn) {
+		struct device_node *np __free(device_node) = bcmgenet_mii_of_find_mdio(priv);
+
+		platform_device_set_of_node(ppdev, np);
+	} else {
 		ppd.phy_mask = ~0;
+	}
 
 	ret = platform_device_add_resources(ppdev, &res, 1);
 	if (ret)

-- 
2.47.3

