Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC826407CED
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 09:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724442; cv=none; b=aAiblUjdE+6byVLWUsbeLSuA00F0aPb4evTlyJntM41F0BReSXLqYpisRm6JjM6eUuUhPWUVAQckRvqY+OTLUUzhBBi1ICUuzbxoW5lhEJZJP40/bj7GWS7dfyUAev30ImM2pGK6Q+uJL4+/RoUETrU1dK44v5uLa5hzTFuxlg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724442; c=relaxed/simple;
	bh=VEyUxYLMr0/kZUc3hQzqiXRE39K4YPDPrI9dGBJJGzo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ABVDvPR61t7LfF962PMmrltcQWLoHxoVuZhdkvGpJv5jRcxIJ3dYRkQplC8W3NaATQrJkYkrm3G0Hj9VaVz+FBVdRmWg2MT5Qif6kUMvawkcThmGdFiNxLrfwBVxtxOlQc3U/H5NHBdeUwu2Qo0ixojTdRUqtC0Y2dU1MEQeG0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jXRgvZnj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hLJlpUP3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jXRgvZnj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hLJlpUP3"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T8wWeN2391260
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 09:14:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p1CXheUuAMODxr2cJ8/mrzTf3yj1wuZdPj+yzX83Vyc=; b=jXRgvZnjw5GcHWfE
	EdU7pqnfu1aWmT1Qn83DNUkYLXZwtGxZctz5Pk3eozOWBd2IJevGjeFy9d+S2RDI
	b3b72IXqCckD20juun7ZhHEfyVD5nJtyyHcSQOMo30hCVGZxHgHELkthlpER1Vz6
	0Eb5Qv15bCrjQT7N9QhM13gtQQB9/4AUtNto0lbiDQOJcoHuuSzbNTdq8XEOHe/G
	c2tEUTwdqe10fVkez/t5upUYrbnnxsM4T48AAdSfvA9y+NZG3EJ0istb+YJ+knp/
	bBGVlhKOwCxw3JF+ZskQRCKUV8AxFXwVEJSQu3IZqDJMPo9bQBuN3xDFCfueJBvB
	aptFDQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nnw82b3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 09:13:59 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92b380149c4so247801185a.3
        for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 02:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782724439; x=1783329239; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p1CXheUuAMODxr2cJ8/mrzTf3yj1wuZdPj+yzX83Vyc=;
        b=hLJlpUP3Bm0R9fdjtw468qoE18Idwr/xfGh6AkVygb2kWcxOpM/U6qc8eX8nqgFLag
         /WtvfEpt2jfPLRV63Ui53J9Dpl4iizbrgKUQDcxNFHROys7YwvUNpebe95uWisFXPCPy
         UOrPUX5CoxSHfpp+Dw8M3Jvoi6R4wtBBIiawctF3zcRvkypeZ5D2cyJem6f8nZ4mGcPm
         lWo5JoDyd9xGXWVhzeqZed+YokNRznBTcOh5wax7GOoriD70ltoS5fhezFj5xYb/5Scv
         Zogkn2d/XQBVRvqKJJlviLjnXnVO4jju0l0rJ0V5Vec0d5E8ugMXSAYwnPwmmIAbz+tm
         lt1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782724439; x=1783329239;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p1CXheUuAMODxr2cJ8/mrzTf3yj1wuZdPj+yzX83Vyc=;
        b=ayoU6Jv2N+KggAWlkYCmzyoUEY4ruFoxpg4VjO4uOH3EE36Z4fmSwim3b2SL7g9+R+
         P//m+xDpgKr9g+u3/c9xOeml7EmCQmfhbuCQBnDBIcXD70nzV6YOgXqq25JchNmFltgG
         hRpEx9egqUai6qPC04QijoRtj51TSPDfckcVkkwBnK4GJU037672IUo94R66GZfLjkZ8
         R6lXqV2V4hW/K9IvJ2IrcV9rtOPyUtrqg5FC4DiPtwWs3dxXRM16/OejKZwgm7ItLrFx
         AWGawFVUU8EvF5vbLM8LZSbDkMCYJ4gJrDZmFwgdRAzVBaMngq4J/1Ivx9DL3LDdcdhF
         NnvA==
X-Forwarded-Encrypted: i=1; AFNElJ8twURkQByLFmFF1nCk0DUXmGe6Ef7G9mbP0ZX0hdlfEYtRl4A4iGx10QIweNR8mEF1r7Z/xw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1v4xZY7HO/tTMf59a3MR613APAbGBOdMd03s1HsmsKdcJIUBG
	N5y5odwRdwgmmd1KnNxhsoQyUul77x21RxFNqObHknp0N//L8c9j55P3OOL5KXxcYxfl9gRLGbr
	5ZI722qW57RurnKj7OqeVJRzofaMs4m40ogBWVm4ZRs6Abbk6XTTW0ryQIw==
X-Gm-Gg: AfdE7ckXhKlQKa0Yq2YNzxrtAkxy93oKdjSP/pYgadq06FJ7s8zTE2rGwVelgEfK/mY
	PZYD7T6gkGwdYLYQg6WFy2qTXa9tWQMqRLQz65942WpaV53w6EAQwWOLLTXyaEvDFKWwyCmNO6U
	UxGq+OiIILjp1CFRN0SjSeFEYjgk0lWkqvlH4RExcJvU5SDhm7humLZbWOK6ISmbnqsIVLVNLcm
	YTWSOqECDWovluCbBqZumZMQ3ijLEvqR8RiROdWIJwqSEecoYmu/cHQK5PIqIN5KSECSL1uN7Bg
	2o7G5uRhTW3EnesyUvh9w7mJefH9504LZeedB0tZheI04AxTWT1J6k1tRNWYFAesbjHbn3nysVa
	vY1W/uNITK2+QonogS2OibbXFmhvZ2jIBcVn33BT2
X-Received: by 2002:a05:620a:6499:b0:915:9273:9239 with SMTP id af79cd13be357-92b3b6eeaf7mr1315081985a.13.1782724437896;
        Mon, 29 Jun 2026 02:13:57 -0700 (PDT)
X-Received: by 2002:a05:620a:6499:b0:915:9273:9239 with SMTP id af79cd13be357-92b3b6eeaf7mr1315070685a.13.1782724436678;
        Mon, 29 Jun 2026 02:13:56 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-470f55acda0sm20109240f8f.23.2026.06.29.02.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:13:55 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 11:12:42 +0200
Subject: [PATCH v2 19/19] driver core: platform: count references to all
 kinds of firmware nodes
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-pdev-fwnode-ref-v2-19-8abe2513f96e@oss.qualcomm.com>
References: <20260629-pdev-fwnode-ref-v2-0-8abe2513f96e@oss.qualcomm.com>
In-Reply-To: <20260629-pdev-fwnode-ref-v2-0-8abe2513f96e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2549;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=VEyUxYLMr0/kZUc3hQzqiXRE39K4YPDPrI9dGBJJGzo=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQjcV2ZO/mjVvS7fscrieifMk6bWNF2AN6BkT5
 4dxIfGu2nWJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakI3FQAKCRAFnS7L/zaE
 w2YpEACbPZSAaWOfh+OuT1Zwlgz+BsRRZZy6cDhBoTiUeYqKdcPmZxipz2TsAMuIlfYPKLh5abm
 46zQkAaG1vtOnsxm9+NTs1QAQ6xkDAoZzhIZMDHqyOPOoG8Gr+0mG5poyrmzhIJ2gZetsvDhSUg
 9BI4HNO2Ya2KjeYG+sFBfGfeJBAYbg81BgstPscXYSUTtblGBlW3R8dYSpD0xb5mS8spl+VhdDC
 3Eyi1jA28rzmPeRic1GeilgXo2ivpXQ1UGz0YeY2OdeZ5bq39rMU95OrW8kxMNV7LqUcxiPdxrK
 +fmmam/m3oLoXNKVFHp0LsKRGjrxZAtCV1oUDuNsQJqoEgaj695Gpkmr0wyk53BDm+QyBQTKJ5a
 azgRvH9HAuBxKvtCV+7ZH9BC/fDFaMPQ1RHKQWg5aIVDBh6TePB9H7+5enD4z+jF2LEogBad/L2
 GCZHbciAEbPm7xr2qYxHLMIgDFckOP8wAQjTjPZzrk8O6H/L1KbIMZEro0kRYsSBj/ofkZho6tT
 2RFWYf+OCFS23k9vsQNHX6T08a2EQEIL7w6cyBp1iSio1pHhuMvlvnT1iKOkYXSPxDK1FPJmjOi
 NZ2QX1sApJPEihNT9LGA6nRo6KyHttwNCAeYh/bhtKB4gUErD3iL6L6N2RotJIEEZbbdzq5OQma
 y6IZyLYWBBndyZg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX2fpFVzT3DOa+
 HrTsmqua05c1eA1cf+E/1s0BBCFMdXUDOH2qlqGZEqgGipaBs/w5u+FNyv6ytiL1vZu7lwFuYoS
 lK+djDLk53U3mU8tDUZKwPK/4iGhPR8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfXyq4f71cGUYpZ
 oEl3wotLGTN1A1wLtGw77Dc3a8prT5SortgOJu2azC8RShzR5yE7jJsMtXwUo1XW3q4sLCncvPF
 SVOZKVB/+0SZQ/1eAoM6+bDuB0s5vGMJcyTvqlWcMHwJuTj7kU0bX++phQVdUs4ZGR9dK0ls6iv
 wDczwOwLn3MUdiOY81oOkAc0vDhmF1Bhe67PaWU5684Essn2+Bu5r7LBLqSPwwKf2DwzwMTkHIi
 RfWiGWXr4odDsyT5Wx8rBab4psu/Vq6mTbAt/1nev1GwErDJoikrXBCFANUL+nyb8RfXKblF/yb
 OUJHPpw8G8fTD7eUWNzfqgQaVPRcXc2J5f/ugw6JMYH53xkHRwHR2DxaS+KopTVQyQbSNhNqnyr
 K22NKREPkZr4eeXPAkje1AaqGFJk6ihb70DwQOnIew+rlO6zSDzDvn9M4/g5yvRFCzeWyGWjgLq
 G4qTpzVmPppYrraWXXQ==
X-Proofpoint-GUID: uBXelCNM3d5ZAu_-vroMRDxdX1NLU6cH
X-Authority-Analysis: v=2.4 cv=cefiaHDM c=1 sm=1 tr=0 ts=6a423758 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=2sGp0kyKjRk1obZUzdUA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: uBXelCNM3d5ZAu_-vroMRDxdX1NLU6cH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290074

When using platform_device_register_full(), we currently only increase
the reference count of the OF node associated with a platform device. We
symmetrically decrease it in platform_device_release(). With all users in
tree now converted to using provided platform device helpers for
assigning OF and firmware nodes, we can now switch to counting references
of all kinds of firmware nodes.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/platform.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index f24a5f406746b53ca9eaab9472f6dd1345e04ad6..bb5f5bddd047d4ec6f238e36dfe4f4ea36b92a76 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -599,7 +599,7 @@ static void platform_device_release(struct device *dev)
 	struct platform_object *pa = container_of(dev, struct platform_object,
 						  pdev.dev);
 
-	of_node_put(pa->pdev.dev.of_node);
+	fwnode_handle_put(pa->pdev.dev.fwnode);
 	kfree(pa->pdev.dev.platform_data);
 	kfree(pa->pdev.mfd_cell);
 	kfree(pa->pdev.resource);
@@ -705,9 +705,7 @@ EXPORT_SYMBOL_GPL(platform_device_add_data);
 void platform_device_set_of_node(struct platform_device *pdev,
 				 struct device_node *np)
 {
-	of_node_put(pdev->dev.of_node);
-	pdev->dev.of_node = of_node_get(np);
-	pdev->dev.fwnode = of_fwnode_handle(np);
+	platform_device_set_fwnode(pdev, of_fwnode_handle(np));
 }
 EXPORT_SYMBOL_GPL(platform_device_set_of_node);
 
@@ -723,10 +721,9 @@ EXPORT_SYMBOL_GPL(platform_device_set_of_node);
 void platform_device_set_fwnode(struct platform_device *pdev,
 				struct fwnode_handle *fwnode)
 {
-	if (is_of_node(fwnode))
-		platform_device_set_of_node(pdev, to_of_node(fwnode));
-	else
-		pdev->dev.fwnode = fwnode;
+	fwnode_handle_put(pdev->dev.fwnode);
+	pdev->dev.fwnode = fwnode_handle_get(fwnode);
+	pdev->dev.of_node = to_of_node(fwnode);
 }
 EXPORT_SYMBOL_GPL(platform_device_set_fwnode);
 
@@ -921,8 +918,8 @@ struct platform_device *platform_device_register_full(const struct platform_devi
 		return ERR_PTR(-ENOMEM);
 
 	pdev->dev.parent = pdevinfo->parent;
-	pdev->dev.fwnode = pdevinfo->fwnode;
-	pdev->dev.of_node = of_node_get(to_of_node(pdev->dev.fwnode));
+	pdev->dev.fwnode = fwnode_handle_get(pdevinfo->fwnode);
+	pdev->dev.of_node = to_of_node(pdev->dev.fwnode);
 	dev_assign_of_node_reused(&pdev->dev, pdevinfo->of_node_reused);
 
 	if (pdevinfo->dma_mask) {

-- 
2.47.3

