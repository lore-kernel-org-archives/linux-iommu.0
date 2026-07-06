Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447484DD6FD
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341960; cv=none; b=srQ6etvlWq8+jeMcOoHJ7i8F0/3pkaHOXZCyO0zEC4Sx9LiWy45PSCXVDZeolTVbcrJo0hEvJM8qEHGrO7wVKtDa5SBlVjZS7SSYlzp0EKLA8dFGQtnhybE5qY6Y/Zz81bKVEa9u1d6GUh+eLubKJzqN68iUVBJtkkKhs+gsM9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341960; c=relaxed/simple;
	bh=JInI6IaLUgntKCu+uREg9rT+W4Ko13o9vFl7bGYELR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=grs2KzYN3THgm6FUKQPqBI1oX8qwMvO4DplbdD/aBFJM4C8dQ2v1ft3KgYA/D4o8E7SKcToDLuXRaX+QhDh6xR6UolOal0h20YhSVgAil5wPsHBqXmxyWLCslXmEkX/+iSySAME/ilXls4TTuDuoXUwc71GH3+4Dt9hIaVqn5xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a/7z/rGb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EA7ThLBq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a/7z/rGb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EA7ThLBq"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxCEx238138
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 12:45:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EUfyESzsAY/c9b8SXvRccGqhLUlXVZyUqlQZtD72q5o=; b=a/7z/rGbeBcIvVDJ
	IFDIH+aKe+Rq6bW2ZZywPVfdOBkDjOYZybq/HmQbIxrR9rHxQNmH5uR7ev+okVyZ
	1vs2erWLxD1FRKaVG2EZvA6yZTo/XaVJG26Oi1+1UVqrye048RZy0jMEtXljlM3S
	3wc9rXhHpSBA6KYlGC+2SzdyFMxHjb/pofCugYeM2qC2HMkiWuECBOCv0QPoD4NT
	207QzNR00AGH0LzljPDd9/F4reQ2J9H63QtxytIL+40USJ5acX65rNwpzn/p0eo+
	5t6nrFJ0zECuws7bsV8rEXI0WrWCRZ2JxdrYduR7F8Eid0ozGj6ysP9QrkPsQc8D
	lfVu8w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88t8902t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 12:45:43 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e62e3459fso253061485a.0
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 05:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783341942; x=1783946742; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EUfyESzsAY/c9b8SXvRccGqhLUlXVZyUqlQZtD72q5o=;
        b=EA7ThLBqtcBBrMFaOXGj2qaw3qiAYY79ehyK4X6qtEb58TNctRFdQBxTBAAP/UHxDI
         7sw/S2WP8VDE4T3egG7Ivta2imG3J+RU9qrMoYJb/Ar1CnRKGA5HxCR+dVzjEifCKRLR
         JbR6dBSKe4WMA3s8dIZZbxw4ZsDmDpJNNrxdmRFHjWwZS9mA4poPkN5uCoN1uKwhmlOb
         45jUKrP1Kz4SZikoSQCBjsb24zORfyWwrwfqeIUsaE/jXJ193Ml9RtaQ5JTQ8VjS8s2K
         +oRIUBzLy3TzJQ4+Wnrz0A/utikIrC9+Hyskr9ECmzx2fHkjRLz2DYYKx6Zx74Emg43r
         E6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783341942; x=1783946742;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EUfyESzsAY/c9b8SXvRccGqhLUlXVZyUqlQZtD72q5o=;
        b=mBOso/VWba5KiXomJ7CzjYRCjD4wYK1TZgAxdk3OlH6hHHlZaUQl48wZ1DVL49C7is
         /ES7gBIl4o3Y1R9dJ6ejsA6jBi1qb3zKcfYV6KjorPr58AH91KEBLelncoJmd3YjyAup
         RKSNVHEXjjLDwL0KZ2nFjK3LGt567PA2x0LR8/MU1nALmXMrvFAThJyMITxlyBje4W7W
         J+YyInnALheCG1tOOXhd8vq6B13xSmfi1ocPOY4AVZnlNpdQ2UuA3aq9sESE4XcpNh7C
         /guQGP/8SAWtpht15/22YCAqqACftJweRq3Kjpyo6GHWwUVcT28ZLn7LfEsCqlQ14fKQ
         nrlA==
X-Forwarded-Encrypted: i=1; AHgh+RrRrsNaYtjfIJ3iv6IUW/fkARymUP4JikqCTFB93sdpyd3D7RVyGD1+oDeKe7WPLa0NhwNMug==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3xeO/zRqNaVY/QQd7MJmEU1Pc4/OwlLH6Qy/n9pQeFvyiyyMD
	cxFXFgSJxZmmEAJ6PKE8kadgh501y8FVMGIPwJWY3WsinKYenlsBfAnomlAKb3ZOKL6oiH5EON7
	s3rLkTZN096rbC3rWmSahigFHA/auDFiUFnA0saKYzAQA1cFCuVOAMH+Gag==
X-Gm-Gg: AfdE7cnhz+cwWqTONHO8Pkb/lNOO0/944KmT6LVoOnKFn41HRWioN3fp2GarBLiMWzM
	AhL/7XeSXtaKeVoPetm20vcfc9Mgu+x8m7EF5/d2EYZUWlpcODyLXhcfgY5PG3f51YUjF3oyxUt
	H4etOeki/vBGsM6TEEd+z4AAD9536fN0oiDahr9Iy2EHNBIyRyS9Eiqb3qrHQjygdoe/Qq3ypno
	MHYRpL1cWuzxb5GobL5+3j4DK5X8bEANPkaj0A0rgdKiZVlJR3PclRc5m7e14V3MDAESmM6EtwJ
	0UONoEztT7LQpA1+aB3SM9k0bF+Sg88v4y29R+ujrmAGW+Ka2jMJmsYOaDpoADFONC1izNCTxvJ
	pbSqN/20NAu0ekEy+9zWxs0GMB7dDYSOPTm6agLzp
X-Received: by 2002:a05:620a:4709:b0:92e:520f:1631 with SMTP id af79cd13be357-92ebb528cb0mr55254985a.1.1783341942182;
        Mon, 06 Jul 2026 05:45:42 -0700 (PDT)
X-Received: by 2002:a05:620a:4709:b0:92e:520f:1631 with SMTP id af79cd13be357-92ebb528cb0mr55248485a.1.1783341941714;
        Mon, 06 Jul 2026 05:45:41 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm22126539f8f.31.2026.07.06.05.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 05:45:40 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:44:29 +0200
Subject: [PATCH v3 17/20] usb: chipidea: use
 platform_device_set_of_node_from_dev()
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-pdev-fwnode-ref-v3-17-1ff028e33779@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1105;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=JInI6IaLUgntKCu+uREg9rT+W4Ko13o9vFl7bGYELR8=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6M7wT/WHgW6r/IRJ084xmgiF5frbzCzZ+Ysd
 KzpdXXnNqGJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakujOwAKCRAFnS7L/zaE
 w9ZRD/4qx0uZLuhxJ51kkTfx6+/ADFF5GoEfFNlEUJaWIKNche6TlU9gsv8TAwWOVwjbJrU7/xk
 sOhCAgEztM2nKlx6ujhRKxl+2TjXk2Nj2Bw4ErxTPNWcqaXZ1D3EOtzXJ3LEIh6TWcNXJCdwsGP
 svhpNoB7rI/uxv81g0JAGCh/QKubVkGYKQ/A+iC6UlkliVEVpj6p1u1gu2ULARKemU2hsn6iUFA
 1oRljszB9ML08rf3vVWm48Sov56fj0qlhwFlNhsJc4Fh5RjWbTDkVRumhciCbBeIO9G9C/i7/ln
 WxpGscgFQ1NqoWp3/aek1bpZ7Scu9xsMTp8jTu27iLrG2C81p3vja43xg1htjZOB5gZQOfpcwi5
 EetLn2abLuSiU1vPkjPCFip/qUHPoi+jb9okhj6gHUX6yyIsoLN5g9ifxmgS6NS5OJyVqPs7QyK
 OigCeHoGtjy1bCMPG4Ze2LA711uVJ/GHLSCxqSL2dHGOUpJsWXjreBLn6ahYXEuiyhvPA9QJPto
 Erpf5q8bz8AMXTE3CMDngaXoe5hPQ2YBtHJ+JMsuwTzK96EQrncN+e7YeNhqCC781jl3KUvObTa
 xxNIMne5snlFpSJr4q7dnJofBuyZU8anvtn71Llv/YtoY1RbDUwojYoG/zLeVQfPZRWRgelgizR
 S6rTgyuGX0mjiBA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX1cO1t+gkTKfk
 L8nhqNEKXc3K18iFSFn+QHX/EcZu7f1iPYzQK8ZheiHY+NoOdC8cUzshKEQfDCXCzxvwkoWqC0+
 jc+oKxG9riYzWqHxhiYN7NMO/hbjhX0=
X-Proofpoint-GUID: g8e4eTxi6Z9jJ25C4lgHOmkoJ3C-V4Q5
X-Authority-Analysis: v=2.4 cv=C6zZDwP+ c=1 sm=1 tr=0 ts=6a4ba377 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=kq0kPlqncbyAjjsh9XUA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: g8e4eTxi6Z9jJ25C4lgHOmkoJ3C-V4Q5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX5PlnpJJC2ouM
 QdDfbfSbt500gqPJAMM9C5nIPeuTqM4P97yJId4wlv4sMXymRz+5ktdTqusZMrUn7yIZJN38Bv1
 HzNxyy7GpYkq0x684ecgg8r1mnE1QcXuboaxLVSRLELBL6FJ1KXpjXeSolxjO+7XFKQt3k9RzyW
 WAac2Ta7Kt8rwwUsz+/0hftzUHFfnMifaIw+j+qUYNUfVX0/5H5fq9XHBz8H5nWocUBHwiJMptl
 tIcJk0oeZkf2AbF6NL7m7pAwNFiXDv67M0xw872+MtxROzNT1Q4XzQXVBsZxqpko8WYZsCq4bRR
 5IQsue00Uqj9f6T+VPWTfcNR9fQbpDxv9pU3S6XtPVWm/SkEUAtIsL7vbfCH9yNMI08mybL+DaA
 QRXDivO/iqZuqTMjw3mTbhIEODo22qs/yK0lIEUd268nK59x+ETsWASDzHHh3xLLOiIsXUHFa4E
 49XmRI+ZFJ753iPi28A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060129

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node from another device for
dynamically allocated platform devices with the provided helper.

Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://lore.kernel.org/r/20211215225646.1997946-1-robh@kernel.org
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/usb/chipidea/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 07563be0013f4d28ed6318a0751670ccef01d0a5..7edc512cc37dc24551efe5fca172777a0a4b0766 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -879,7 +879,7 @@ struct platform_device *ci_hdrc_add_device(struct device *dev,
 	}
 
 	pdev->dev.parent = dev;
-	device_set_of_node_from_dev(&pdev->dev, dev);
+	platform_device_set_of_node_from_dev(pdev, dev);
 
 	ret = platform_device_add_resources(pdev, res, nres);
 	if (ret)

-- 
2.47.3

