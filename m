Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5114189CC
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 13:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783344101; cv=none; b=RYcA3db9+TKVs9mzssV7qGyLBtnzliyg/DpNgBh/AZCH7orCuC34H9eyKGlz4zhqwhS/OBYIAgtBggmi+AxKsErPweL09wPqux3W3zTtZwuOaN7NaY9WbtMLGefnns+Jbk4y2BRGpu+rEnhLraSB9oZG2haGJNTqbMKqAUXzF3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783344101; c=relaxed/simple;
	bh=myAnAqwQCy13zr91xzLXDTsphXD+fJJQlPI5uzrj/NA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZzO7o8UEoj+3Jby01mWhmgAcavZL2/eH1DpLuieidPmi1znGz/GA7jebTNKQdIV0O3yhXjmqI+wgCrFUDEyrqppt1jHXo+Sj6uDih8KEfOWbiDwJ+lZaYBTWYUJxP7cp8oi4h/UTRUxcgsb3+JBWbmWbusd9xniYEGioU4jQULE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PEZWyDId; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WMJEfYTj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PEZWyDId";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WMJEfYTj"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxOeH369506
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 12:45:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9S/mbrIgVqWqtPP8kmV/asLO7TrMZg/IRbAXVUcN3IA=; b=PEZWyDIdayoRJtJf
	Gm4yCbdBU/Kg4fCwmLvwa54Sk0sJfN3hNtb89B8sTjEQLLb7/NQP1FY2m0eE9nGh
	LdIH/gTsiQ+Wzh8wjGQ2vHc6+RNH3gineRvsHArNGv6/67/yH3ZhWSQLygU2RVUT
	al+kCmSgvmGNhPOOJjv+KVucWx0X4EB21idu1fTE9R/CSLy28ScyY72eHbaYuWhC
	OXDuIkhJVtUuTbzjXakzMsNOMrKY+8+Fw06v1ma+AuvP7I8BiqHsyiSSRZ6WD8YC
	NTN026qYSv+N5mknEhi/Fn7IR2T8k4UjxvMEa3K6XaNFaf2HCmxgQwNVgUCgNKtO
	dPmBYg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h9938j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 12:45:30 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92ac0a54110so334683585a.2
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 05:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783341930; x=1783946730; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9S/mbrIgVqWqtPP8kmV/asLO7TrMZg/IRbAXVUcN3IA=;
        b=WMJEfYTjwR4S5YOOj5eREaJqE+85abUD/oao05bxaCFDKPi7oFf2gCc0R/NXnkwD4I
         FiSdzaANlYI2Bv4rYW+nQz2z8JtQwBOnz9rZS9LTPNaXHfAyor7jXuN+QGrzJdWPOmtI
         CkL56wHWahf/4VX3WLacIOM67qpy/WrEcC4p4VhJM/xyh5B46B/P8bXdkRQ/1o62Dwmz
         lTpqRwCpm/U5f9wOAhxs2H1hTxFI+0db34SgrF1dH/R3ZFPuL4PcmPITsIb6VBX/W36r
         En6njeNG8EJyF9RrN3bDrqBhSkIywLTeBq41bVeplX3JBUs9zl0rcIbKpbClLkLn3yKl
         kF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783341930; x=1783946730;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9S/mbrIgVqWqtPP8kmV/asLO7TrMZg/IRbAXVUcN3IA=;
        b=h2dNeWMUjQD8AWMgx/63StxLrSgIkqA5qqpNwz7wkQumlCbAihp03PPbPs/Lr8uaEX
         FN5w9Q842yEf0N5NkvaI95tk+2YGOFhdbtCig00opgLn4y4dVpMAF+MjxZ6WlKp95kgZ
         WFGm02So5I/44UadYo/WRc2IyG1CXN7XZwS/l69i/M1kqRnr/fm6jkdQpQtyWN6WXdfq
         437iAzJBl9ZRNKLofFCzf4WTYxUc4lIJ5G1dDsuIy3ISo6TtJ5XnE5cTGXUAHAiMMI+M
         +fVSuIiOgxxoAD+yky38fQHwtuOYGE3a4pEq8e8zxJek4/tlYrafFQm8rf4610KPwbRI
         Y23Q==
X-Forwarded-Encrypted: i=1; AHgh+RqgKpOVnKVeFKts7MYIuf5ugEaSFwHsuBVcinOBPVIFQ4s8sptJR5325hmaYS297pTu5ZcZ6g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzNG94J5cQr1Q72Rh4Dzk6VW+L/4lIHfRYaFtFQBpDKwwbtTUCP
	9AWrj5gYrr6Xsew2dfDIOuVtISy608jUpJEwIkGOmhPROd99c74TSc6xXEGmgbR3ByAGqE2R6qh
	SneF3JSpeTkYV0TGJjB+Gp8eKpOgw8glrwgYecuo8g7MsweBbPVlaHJNG/Q==
X-Gm-Gg: AfdE7cm5bY724nqwq266LPGlBctdGpZLsjOB8IV78vSOqzqdjjXX+6N+NHa098WV7b+
	1CZmqnLRnUAxx3LtXl7FIqqTX3tiBfxOquBep2ZlQ9RsJk78Fe+kPxAsw9KGBg2WxHN/bEj7ERu
	kGzc4XK0WdoZfPvWVxrlDdOw9qVwANxdFcONIsIp48VtziErya1LFZBTD+2JzYSaTy3kXTaMkzA
	QmBdjhobNOtRHsQmMvBZQzgc32hpGVe5dQhsP4aqpVp+XqGvDdz94WFuJa108T6Eei2ya0Amdgp
	0/ioCT2g8d+JogKLjvv1b+Z/Unoq+WXBF6ak+Tco/quLV6pmQHnbAkRjGN66p3Js6lw++yfPIT5
	CQAEHZlP0EPIp0VYEdoe5TSirulpc/eTp5Ah2st59
X-Received: by 2002:a05:620a:268a:b0:92e:755:d962 with SMTP id af79cd13be357-92ebb5d4187mr48764085a.38.1783341930413;
        Mon, 06 Jul 2026 05:45:30 -0700 (PDT)
X-Received: by 2002:a05:620a:268a:b0:92e:755:d962 with SMTP id af79cd13be357-92ebb5d4187mr48755485a.38.1783341929743;
        Mon, 06 Jul 2026 05:45:29 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm22126539f8f.31.2026.07.06.05.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 05:45:28 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:44:25 +0200
Subject: [PATCH v3 13/20] slimbus: qcom-ngd-ctrl: use
 platform_device_set_of_node()
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-pdev-fwnode-ref-v3-13-1ff028e33779@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1030;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=myAnAqwQCy13zr91xzLXDTsphXD+fJJQlPI5uzrj/NA=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6M5z0Ug8HOo/mkHEdX5hdHAVCCSCQf4Zf3oX
 n3oOYxuHpOJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakujOQAKCRAFnS7L/zaE
 w3iPEACZdFohB8aZuD4IW+KDeK1lug9YxM4fLxuZ9O6Yfb33xfInCQVl2ApM5yjOlYR1aCd0+Qa
 AbVaSInI3iaPi+SncEH9JMf7ZTeRmER/WgArjBmflL+CIM7gxLSQU6xLWGauYhQcgoT1sTgEB9Y
 dpaBCfKeYebINsFU5fXn3qZlFgPcwdZmhf/B5Xaqrzgev8Nia3f6SMW97i5ZEbJ1h28CZk9ZgJP
 9RrwhDRTVnaeug7Ijoymji1apZrmeLx7lOhjnkCGfWU1TaiNKmD9k02kNyDV87OE3sfgIldLUYg
 q3QORtezKqe3rjZ4tcZuK3SWxhXWnH+8XsmALd9gO/Z1sKlu2aNRuw+1VB6RyeiYwpzdpW/DBLA
 49Bb3wFrM1kV8E0mDSJwkFGZxFntMCoOMzdNpwfy1pgqN0F1w9EeBAITB0EpppPvfmP1oXDxj9Y
 rc1Fjv7Ynb3T9JjeP27MuOV/9qSxIf+yRFC10bWS5y9uwjhG65wQxbKen0HeyfOX0EWaFySASEl
 dU2UpVJHwYe1sFJzHyEsuYDOzfI2jkOt1+X6qHmvI0pROFoHdTZqwqdKNc5nrfE5rqfAKcyBojj
 cXlCgI+BzXTtkebexgsr97tfEB9ov7RHoUHR+zYPli7W0sLhdqgM3IOYnY+jcAaRHOC6xkOGXTj
 WJkCB4LVwH2aUgg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: 2yDO-PKmnhCjq0oGJAlwKE_22j-NX298
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX9yHsVgFqP5Fo
 zp5KDFgJBaRtcwLo8TaFcX7exYK4O0AyMoPoO0JfyRZtdZGZWM4Vd2ZFonj1JewhziI/1hZewiU
 8XtR+7womXpxavOe6kW//Iyaec5UCwM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX8grrYSQe9/58
 Gh3bobynOKLdmiGO99pEc+Z0GdCwK5zvlqlNJnY3xOyWDabTxZ00/kz970Demu0CZrYUxLT7JZq
 GfYVzht6rZm5uCTu+mtKH3YkNXb0eJ4ruDq+j0dAHs4pHVh1yw0vR1a6k5110HbXQMaBjTaxED7
 UV+UA1vuTLvrymqCf5ShCmEnn/bqectL3IqaaC+SC3rAQV5CXc3haB7rnDbcGECONGe3byqMp0w
 1ZSFpqWOOpkIZK3DIYd+Q3NrIsY+gRR8Fl4RKT9NIILFUTPZokBgAMrJCeKSm31dk/slnUvUL7Z
 4xYvvr+VZma9EhYGosT0UCuU0lK/Fx6mx1HmEv7OA9v8N+BHoRsS9JSG1ATVEja4pCAGRncovsp
 ayXEZ6DbhH7L6ev9iYd0+atPTB3Pu4R9sJY6OUbxrlHfXr2uXo3ydJrswHYUS/QghWtxwLJj5qn
 A7LZVgmpfoo0Dy5eNRw==
X-Proofpoint-GUID: 2yDO-PKmnhCjq0oGJAlwKE_22j-NX298
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a4ba36b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=NrPIdse2iluhyRvnZrkA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060129

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

Acked-by: Konrad Dybcio <konradybcio@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 3071e46d03beaaae2321e858c564b512c22e820e..6e89415712ce1a7a7781af6bd0eaf0d6879da52b 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1539,7 +1539,7 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 			kfree(ngd);
 			return ret;
 		}
-		ngd->pdev->dev.of_node = of_node_get(node);
+		platform_device_set_of_node(ngd->pdev, node);
 		ctrl->ngd = ngd;
 
 		ret = platform_device_add(ngd->pdev);

-- 
2.47.3

