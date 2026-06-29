Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A96400E0C
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 09:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724413; cv=none; b=MwJFEKZ3hSYZ9Z4sFzZ2l6jx2KtKRqZCtFlmjty6+Qs+Y4Cer/WizsAaTTuZpDtQK/t8XIeo4AnbtMmPy5akXrmKn+tKUnWWsA4tVe14vuOvlx74QVLNXS4ecJGYVKaAOOpLQApGHcWRHTgbBmDuPAf3hSNBdB/qy0+vUfh6dVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724413; c=relaxed/simple;
	bh=1m0AW2cExEyKezaoaqpg9M8Sd9W7xIah4eoQaNoNaio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kHxBfq+AXC98EaDfVHzDoR8TsGFvPm+ca3L2OIwcLIIiQyGmTuindSXdRb7Jbxm0UvkEhSeW1+x5iTNqAmZsE1gTXFET5bM/o+6Cs2dKGx++h1poq8khMMCdOn0wN/FLt0ojy4lOVihz1BHD/6yOd6qo09R8C8CbzmtusRNbyvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YLrjbRzb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TbbJ7ywo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YLrjbRzb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TbbJ7ywo"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T8wV0F2391253
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 09:13:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LiqGJIubV46C/XuNtoDonnq8kzRgQ9Nd2r1gbru07SI=; b=YLrjbRzbBYmFp1KH
	Y2HoZaQbXuGUJvkgTgwOWjtrK9pG9fm3ZuYyicnUF2+5HPB7TscPcag8+n/Xhz5y
	BNojp5k9tclKQ8iF4yUsL34rdrR55sY/ddoFwlEO04saIGrqP9FInTNVnYC3ai+Y
	FE9VgvTn59oOumkLnuvTlpqgSa4/BqV5s7Ec2U1WqL/WSYxX9DQp+tz4URhyC+7o
	NOUNOwgdBb00bTIydhR0xFyvvop0WA++tA67XRWREQeXNWtFULQg47nRtY+0eeVx
	CCweYiv0RHwkM2cKfHAFOgElT44BugsDsURIPYs8OYxNux1HGSPUDuwuN7SfwBjv
	spxv2Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nnw824t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 09:13:31 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92ac0a54110so485548085a.2
        for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 02:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782724411; x=1783329211; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LiqGJIubV46C/XuNtoDonnq8kzRgQ9Nd2r1gbru07SI=;
        b=TbbJ7ywozE72nFeyVlyRwLm0wZkvuBYoHJQ9Qx+mvD8ySRDibHvOBn6G3cT92tTdke
         mRLCx3xkVW5AFXYNb/9DzU/JIHnhdqZKoPDtWZQJBp9Ff8yfRLUKPpStzEcHSV6dXqJe
         yaoJLXlRiKonVo4SYnOlavGbzCVaO3+zGYgAXm1ga0e8KAhxOR1Dj6qFgjQPpZXgpu3a
         x7hoNVjC1YrzVeq/bNDGsD1oJqR3qbgP2cqqYwCSDChr2BfBsPjA5g2uU9n4trcad1Bv
         6cnTO8jCJlsZNA1dWdqhNIotBoXDdUHqkT6t1XrNNoNajNhfu2a3ahNppQF5XHwOO1Tw
         NRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782724411; x=1783329211;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LiqGJIubV46C/XuNtoDonnq8kzRgQ9Nd2r1gbru07SI=;
        b=e5QbgZWPGMYueqiyzEkEEWYSYoCHxyAVTmNwBWJjb8fQjcwmXWT6pQmQcdBdQyZWfE
         EVBAEseo+tAnK9wVELNgt+6w6R2O9E5hsZQ9cGdXdkP+CWxn25GFju59CGmF64/pMAix
         CvB0mKqxKjVw8wJylRXS2iQfE3+UNXOQWxMtu4LHt/jX+bWhwj3rAOEpYzresAYvE5ct
         ctCI2koIJqAEcmDXsabVZWaMO5y2juTGvkANkxPTwahWL8nGyNjliJycxw4gz55gvkx3
         K+0T8zqyyV/pZb1mqqr9gorvVxz1glDgw14t+Unr0/jBy8hof4liBfhLM9EcJIC2USfi
         jPeQ==
X-Forwarded-Encrypted: i=1; AFNElJ83mdJoaAXi3TAy0vP38C1qyY3yVfjtzsg/I3mR8yM2yFhtx+e23QCIjaaUl7HmVVHoJaJo5Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxjxY09mU2jAWHsChlNE+jmvHp728v6n+DQvn2EOTCal8/oIf7f
	zL1enNG3H0PR0OThJNbkY0TvTVFwe8cpzBoYI+9Vk7kALdNclHA1zWv5IbFcLwpYGZPCtiJf2UN
	vbTgxyemAX/JiXSaRtA7nXsIEOWXKkHrvZoDhzKuZJjVwOdZhctaImMvXDg==
X-Gm-Gg: AfdE7ckCTQsUSRK9PW/FG2hxBrHN90yONw94XJsporJ1UUGjXeTIppvKTQnr0Rkr3ii
	Wq4eRtw/GGnjFoY6BzkiCUJrv8gpw672zrKPsBMN8m1CRI+pX3O2bqYR3/qxnqg195j/Asm5d0M
	QQLw+0LFyL1xKbYKfWtt6MA5rbFAbAPok3/ZvHGPI3kbDh1vvcwSqfqBXFSTAqWy9t/VV9EUznM
	uyiR9u6KqX/wfJjDcwbjB7OFUwaILqUROC0kxH/joxwXTRIpsyHDkh7VS0g8o8uUCER9y1522tG
	uzX/TzvIjVpY3Gr65bLpyAQXE9Qj1/f3mKtc0WMKIe9Qyt7ftdOccD3kfxIbf9z0izNWwskTkDW
	mZ0pSKzHkSJIQKmLoSg3Imi+NSN0Gvd2PHfVsuTRP
X-Received: by 2002:a05:620a:44c1:b0:92e:54ad:3d9e with SMTP id af79cd13be357-92e54ad40a8mr234385085a.67.1782724409946;
        Mon, 29 Jun 2026 02:13:29 -0700 (PDT)
X-Received: by 2002:a05:620a:44c1:b0:92e:54ad:3d9e with SMTP id af79cd13be357-92e54ad40a8mr234374485a.67.1782724409249;
        Mon, 29 Jun 2026 02:13:29 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-470f55acda0sm20109240f8f.23.2026.06.29.02.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:13:28 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 11:12:33 +0200
Subject: [PATCH v2 10/19] pmdomain: imx: use platform_device_set_of_node()
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-pdev-fwnode-ref-v2-10-8abe2513f96e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=965;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=1m0AW2cExEyKezaoaqpg9M8Sd9W7xIah4eoQaNoNaio=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQjcQyzurssOLyeyJpbZ44XjlA13nVoOMp4FKq
 5FZ7f2+wTeJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakI3EAAKCRAFnS7L/zaE
 wyWrEACG2jfBFV4TvBfRwgewJrn4MxZY9WNutkVnrkExL+M7S0eJJfGkP3U/Ukk/dDuUejoAZPq
 Sb8SC82gQT++7Px/b+D/TRPwIKXTnW6UmQ8FAi2TIsKTxV7Y0BFWyq3LmTfXizbM2/WWieYNGfj
 q1obXEmNP6PgwvgxLOWFzKk3aQnyMP45KHCH04+Azw3h80o389TeYER396jSTd6J8D1Z0iVTlfM
 kspWO9GmIoBe6xg1eZ7BSif8azWOyC3XZYrMHyM0N2/xr3DOSNw4jR6WbM1ly0g/TOJQyqyZ/bZ
 XK0kk6MV4xzK9uCp1fdLBufhgIo3HnLUprQPj3ypXUDqTXs53DWtHvSaIOPUqBe/e7pyGvPnoBG
 LBo3Z8Ms6GvyC6woMBczrgA1VOaN7rVQmzMhcWTOZy/K7ejTa/fQbduwysKFk8LAjCDSmjrBuad
 dcUiN6hnJHjImb37ruwv+NawTfliRSl2eEIP2fZfY1xjR5bUyjLzDtU5XDwyLvj7po8px8TWAJ1
 1PG5K7rrfKL9XK/lYkC1XTBtvco7sTwy02oSD2cg+YQOUecFEzGzFZTD26WnyMafToduI/mIs1d
 0X5Y/9B8j/BEfdQKBcEanz8PzvHy0mc0uYTjL3aycjoL6wAeXuh4BC/cNLOIJu0l6wQBFFLC7fC
 yDjtPW4DVmx/sYg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX7zvTaUqibjt6
 KD/z1R2vjTjBlKgcTUz+L1Md7ivCyb9RaZ+vgifpAHpSHcEi4ZYGbf4vDajyIwrhNM2bM6AOvJf
 1RqZa8KPFn283EG4ciu8dXdnk2om92M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX644ZtFQcUYYq
 hHtZ+IEDoOEOfjwPDase8tFuEYn0sTsP6B4KI2gWHu3PHz4WvtdFXewd8MfcgjHssuxtkA57Myc
 0sdJmIBFq3mrfHkXBguQDRYVTJgllwXa7PDdbbjbIrvIAyDT3XLuHq3Ae4m0mnSDVoLcEeDUjw1
 SbUaHL059i1CQGathJIvm067ML1rqddIkSOFljQTnHYZ/tJr7VZ3VS1dmrutqfYwSM00LQXJOPY
 InV/OGW9HRSZV6IiV6Sby8iM9fN7c9bd3pvs4EupwHMcbhk52roloBWisGFTp0lAbggXm0Pi4eT
 KHWsi1l/kNlfKelFCdPsyA8KUkNrW434Vd5vyKPD8//KLhkvCk2Uzd59UzPRT1HldIqUZ/aQeQq
 06DGlJroHbJ4Wwj+v8/Gi7f5Q4GGFL7OBVhZrSb8eAgna50KErYOcnky658KaE3bo2GtW1/lMez
 5vPKFLyOzLjvTmo/uhQ==
X-Proofpoint-GUID: EFciBVrJ3NfxnsytUIRX2olJrVSTzoVU
X-Authority-Analysis: v=2.4 cv=cefiaHDM c=1 sm=1 tr=0 ts=6a42373b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=J9-S39C9qTGxOfEZqScA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: EFciBVrJ3NfxnsytUIRX2olJrVSTzoVU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290074

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/pmdomain/imx/gpc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
index 42e50c9b4fb9ffb96a20a462d4eb5168942a893c..abca5f449a226fbae4213926e1395c413160c950 100644
--- a/drivers/pmdomain/imx/gpc.c
+++ b/drivers/pmdomain/imx/gpc.c
@@ -487,8 +487,7 @@ static int imx_gpc_probe(struct platform_device *pdev)
 			domain->ipg_rate_mhz = ipg_rate_mhz;
 
 			pd_pdev->dev.parent = &pdev->dev;
-			pd_pdev->dev.of_node = of_node_get(np);
-			pd_pdev->dev.fwnode = of_fwnode_handle(np);
+			platform_device_set_of_node(pd_pdev, np);
 
 			ret = platform_device_add(pd_pdev);
 			if (ret) {

-- 
2.47.3

