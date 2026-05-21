Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E463AE71F
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 08:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352651; cv=none; b=jcHb1tOBH0PbXaYOPMHTJ5uifQ0876OureHcaKk03LGmj5JhIhkSw9o4EXYTAel02soDmmNNlGgAeE5NlZVIkBUDWiDE1Y6LU8nJ4dbBXMIctGzomI7OZ4fB14tSjQ2K1KOQFDEEwItZaSZVEdHxqrk3YJWB1dzTTfI7FRoUCME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352651; c=relaxed/simple;
	bh=wZzo4F+iEv+cqnjZacAyiOQUCIfz9BeD5LEdTUENfEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rzK4id4MDLoxHzICLkKYOV4TmB3KEt1JDyKVy05taHkg58hyXGpdRAjUm2f/qMBjE5yZ1su5cfCXBfF/T7eu2U1aQXhJ74V2jckUNXIswIGo6VrPq8dy2/8VNXcLDoxJiigxTMvZKaip1uXOHG58V4GA2oaUY5q88DGUf8GuJuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TGSv8YHH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jtK5Gsqc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TGSv8YHH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jtK5Gsqc"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L76cor118976
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 08:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m0PJY/EBXaS+NGqlIlXtzUywSQPQ33CG8O0mf5HsOtc=; b=TGSv8YHH2HHm9gce
	LO05rZSE6dZib/XINNl6hu/QvmGJtgVvta9prqDrYEhZLuap803BPNi5UJ6pclC5
	8u54UuNFHHifWzorPhqhoAujRKyfX2pOVUtZwN4/RWtZiEIMKIKCbjA78t55rW4j
	NeAm+13eASkdx3gOsHfhlBsFIp25sLXiXlSJKlr4hMmSH+3icRb13RT2tf2A6xfl
	Khpg0wQCdp2jMuElLBz/vJ1F4RrRglBsQ+G+9NE6yUo2soHkDy+sOzVG0O6oTes+
	tevab/rwt7fnTEpBxDXzs7qe82eYsaXRep86pEQUxvQmJYEi3ALTpInszxXfFbG+
	FnGD5w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ee8c192-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 08:37:26 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51605cf3c60so67355571cf.0
        for <iommu@lists.linux.dev>; Thu, 21 May 2026 01:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779352646; x=1779957446; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m0PJY/EBXaS+NGqlIlXtzUywSQPQ33CG8O0mf5HsOtc=;
        b=jtK5GsqcWdjVc7ggr1QMEJrQ8s2nAeEytchFAOwanD0AvLIEO+1ol+Fedzoe9lqHES
         6FSJ//IJgbtYhZTxF0A6ymb6BYIYux5+1wntDq+hALqT+Tdd+AnJxpIOLHjbj43rX910
         9URrrj3qF4DD9Q0Fbb2I8iyenz+9GfNUC2ENp/Zd5neJcuShfNEiGD5g894un3q0S2Cw
         yl1WvQvPMYvnXjnANAAV56Ut9c0NKkI3Us/obhDvZob1sFK/4EoPz7gyD3CI1GiKELhn
         oWBvcSnDrxkkV2i31sxc7kdnBbRkJmFqdXhzeOCpuChKp+vB7ccIrf86nxNG/IxLV0QP
         mygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779352646; x=1779957446;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m0PJY/EBXaS+NGqlIlXtzUywSQPQ33CG8O0mf5HsOtc=;
        b=jEAuCUW4ys2ko2vuzXA4BtwjfYE8Ho8+hBqG6shJQBJVXHJPDByob+riSBzMGdRXxY
         pW2Z+OkV9YJA7WooTBLdmEzAl+zafKLSVDJ+nvE2OzWKgaRt145mgw29hh8D1PGJxqUk
         OTmiZSA3F6j9vITbeWhhy2Bv7sIXIt4mK9R8A06iKh3iyqF0IiWniSlnMmHZqANADQlG
         ce+u+HrbA4CkK5p+DoP5twEe+cve9nTvaJdNsLKX1N3LpmXhTo1gUg0+ZN7rehtUnVbu
         gQ+tI29MCux1J9K9qulZhVSNRcf2rrAgB/MUYdqwjKPHrvdortdw5ZpUl2Fo2C8oQtBe
         8nYA==
X-Forwarded-Encrypted: i=1; AFNElJ+iK/+V6Nrb/99HsXv2oTvNcvOs3QOw+blQY6c4yWdCl1jh2nVMiMiUh6t8PYTEssv8BQeP0g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwUsnPi/3uj4tP2kirgf2PSoeJ+iz7piynVqMlkYTN//m71/Q8L
	KlQxdkYd3aUA7gIV3o64vLXKnPqr5XWRmgwNzomlAi88SuNPHM5sJrVDTHovQeJFyqqXtZmsen2
	G4FXVJt8l1d0sDjB5DZVnYQrFNIBUAmm7cTcOMv0sP/YQD+8bIrUor4eLGQ==
X-Gm-Gg: Acq92OECv8XvZX9HgcU3MCTULronpHFfOI1kuPK/xMAKKX9zcDKK4xDcWLe+ImFxUxi
	Jmkv+VIUJcJvO0PwEpoeuQQow9m6y9ORDHI0BKYqilnsqn+urn3gkVoz/Z8dFjGlP18uLMNOW40
	OZRCikOYnFP1Ynx6tP16Xx3LEpAyZWSg/iypLEkojrW3+XxxoL61Kc3r+BwhuxFkjcAGUZcKvNM
	qm+TCwU5wSeybyrSQzpwTFgl9e9rRSIq+1B/sKefNipM2kLuq/Nlnb70gupzZQQplSkOH7fUUgc
	UhD4TiBDtgplozhqhOyzvOninv4C3ueDZhN0n2VMa3jhTloGBZvAIgvYlXT03Ok56g3N7cGRbpE
	1m0WnXEH9LeHf/yKEZGZuajskZY99L0Ww7JVrmKBlOqYbPsV12fs=
X-Received: by 2002:a05:622a:5588:b0:50f:817c:2fe6 with SMTP id d75a77b69052e-516c53d8aaemr28109151cf.2.1779352645857;
        Thu, 21 May 2026 01:37:25 -0700 (PDT)
X-Received: by 2002:a05:622a:5588:b0:50f:817c:2fe6 with SMTP id d75a77b69052e-516c53d8aaemr28108511cf.2.1779352645294;
        Thu, 21 May 2026 01:37:25 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903caede9fsm10502405e9.14.2026.05.21.01.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:37:23 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:36:29 +0200
Subject: [PATCH 06/23] driver core: platform: provide
 platform_device_set_of_node()
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-pdev-fwnode-ref-v1-6-88c324a1b8d2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2715;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=wZzo4F+iEv+cqnjZacAyiOQUCIfz9BeD5LEdTUENfEM=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDsQjLvHgEkgDUYcyQqS+YI0tDoWCf94BkOfk6
 vDphiey46iJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCag7EIwAKCRAFnS7L/zaE
 w10mEACuBjw1mRfWGN/zZYles7aGCy04DbiAjWjYefDvcAqjwNHVbQPGTfR9vvDt9Vt3opZlUfJ
 1ytnUuq6dFumO5reYJ78tEy9o+PkI8VY7UoUHI9DX2cKKEeA6fkKzjp3sYJvTgqJELasQOkPH8y
 PlZgKzt0c0z6CLrSP/lqxiiyL6Roc+RIVEg6THFxHR5OoOrX4+KXE7TpYW/+9R6Q2BP2a5mjGKI
 I8sHIVxHMgpemPUcVLU4/uTLyuQeLaADPratIxqvFuTx0AW6AOYaFvaamCkQMd//4qESASqVPxq
 Iqc2iJqP6r0b+IvjJO1nHSUPlB1yTjcDLn+baiOlmwj1skALP2IMeucYdve6oLVmXSGYq6qAYq4
 gC7R+np/sgYQ3f5xLBo/KtwsaKQb6TSf+ZaoZnYHVqW+A9akzduAnNlWFKW0UODQ9PcBDZadov/
 3mRLrzwuMo293FdKXtsUcYpBMNIX1XEo5vV2REkvT+e4lLq2oAkW+Y6KmtTYYkzZs+myeRmoTWk
 ebeqMSKJ7NApWk3IX+x4SN84ESMRkBiuAhe1JJ+h0WQ/IOtxcd82UQCshyJxQ8qXTzoFMc2kEEB
 3KNvxUJHXaBt2BDRHwinv0uRBTS3Qwt835TjvmqeqIrB1g5DU3xqpgR0Yja7mcdp35huKbkn9rN
 lHge5prVxo4DdaA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: 27RoCs74K5GBwBgBvh7W2jkjJ5_oGewg
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a0ec446 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=Q8RKEeUEMY9O-VPP2I0A:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MyBTYWx0ZWRfXxjbllN0CIn6U
 xcSdh5RyyS3x+mwXvF9nacH0mpV3G+Dyd4jg1yFpv9wQ2pGwu/UwlMI7JO+VN3yhxkfE3T7eGGZ
 v23X92f9UplFPSWSwwGEqF9SqTB8QfeevVqM0OYIsr8HMKfDc8ZfggOfvRqmoUsMjnVri9rkqCp
 WaTJuU/Yym13g3XJbNCqJuFaWTA/4MBvInUTpNIFbOUGqwR9+XTtKPFj8plqnjT62xW5+WspAeI
 wMTSvvrpq8WTPNY+SK7JNnS3tIhXH5KY5pA26tWxq0j4G6+rH2sc2phdQHgqYSZb0o67LqRoyjm
 Sg/F/bEUYF3iHdXFHPukQHEQPdKjA/Xpgs05JNZNcCalVR5PqmwvEqw6EPNyfetbJTj7ti0TZea
 Gr5ngzkRoK+50KCLgvxwMqYIlfxRqgygpW9dr85k0I33E1SCUyu/XMoYZQ/hOINhw1QgXQ5GYHw
 262NPO7poP/cOOhThJw==
X-Proofpoint-GUID: 27RoCs74K5GBwBgBvh7W2jkjJ5_oGewg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210083

Encapsulate the reference counting logic for OF nodes assigned to
platform devices created with platform_device_alloc() in a helper
function. Make the kerneldoc state that this is the proper interface for
assigning OF nodes to dynamically allocated platform devices. This will
allow us to switch to counting the references of the device's firmware
nodes, not only the OF nodes.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/platform.c         | 18 ++++++++++++++++++
 include/linux/platform_device.h |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 4824d9a2edbe9ff86cc9893cd74688e9cbb6483e..ec53383fa17ac29ea3b15b61f97ae65ae8ca22ac 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -693,6 +693,24 @@ int platform_device_add_data(struct platform_device *pdev, const void *data,
 }
 EXPORT_SYMBOL_GPL(platform_device_add_data);
 
+/**
+ * platform_device_set_of_node - assign an OF node to device
+ * @pdev: platform device to add the node for
+ * @np: new device node
+ *
+ * Assign an OF node to this platform device. Internally keep track of the
+ * reference count. Devices created with platform_device_alloc() must use this
+ * function instead of assigning the node manually.
+ */
+void platform_device_set_of_node(struct platform_device *pdev,
+				 struct device_node *np)
+{
+	of_node_put(pdev->dev.of_node);
+	pdev->dev.of_node = of_node_get(np);
+	pdev->dev.fwnode = of_fwnode_handle(np);
+}
+EXPORT_SYMBOL_GPL(platform_device_set_of_node);
+
 /**
  * platform_device_add - add a platform device to device hierarchy
  * @pdev: platform device we're adding
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 975400a472e30e2f98cc8f13bc36a63129bd4fcf..21f7d8a7f4b5c9a47d56d80a69802b3f84457ef7 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -19,6 +19,7 @@ struct irq_affinity;
 struct mfd_cell;
 struct property_entry;
 struct platform_device_id;
+struct device_node;
 
 struct platform_device {
 	const char	*name;
@@ -262,6 +263,8 @@ extern int platform_device_add_resources(struct platform_device *pdev,
 					 unsigned int num);
 extern int platform_device_add_data(struct platform_device *pdev,
 				    const void *data, size_t size);
+void platform_device_set_of_node(struct platform_device *pdev,
+				 struct device_node *np);
 extern int platform_device_add(struct platform_device *pdev);
 extern void platform_device_del(struct platform_device *pdev);
 extern void platform_device_put(struct platform_device *pdev);

-- 
2.47.3

