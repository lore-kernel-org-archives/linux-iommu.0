Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7820C43C7AA
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 12:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341902; cv=none; b=ouP1X0Lt/lZYJRqTIVup8CCkZ0IBiy0xa4T2GGQuZiKT9EAw9DuQ0JJRAGV4oqyuYWaA8my9putondTiat8QT5CgF2fR22p1+UPdTj9cmpbIHnvulW0oHtpcJnQ/pYp99q2OWCJlxldbEsrvsyern32DPFZ+OZQCwAah2qM622U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341902; c=relaxed/simple;
	bh=aDGbbnz+wzV3twb5feb+QvbOP0I73Nzbv6atplL3wzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OzcBfPUueav0oheDHZ5GB53tiwNKxT2PCUblH06XW96tK3g8vOngsg4P2ebp7ElhD+I44o910NH9EdtzftbFeUWcI/Go8zKWES8ztLwJNMXPK0kkMt9ffKfQPRO9JpTxUBtX0LV4KhSj+eyyBjfblchxtkR98l+n/KJVIHNfDTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dx4jTolU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ggl0XPWx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dx4jTolU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ggl0XPWx"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxJAr316469
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 12:44:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UAsGd5ApODao7ya5c+v4THHQP6gUJNMav6AFOuVH/oU=; b=dx4jTolUOG0UpNFm
	MhBn5F9xncEGRrD1T/WbYOIOs3i3znC4K9HgDJ61gDB6xdRp65m00l5wnZldKlsq
	UGKJyHYuRgj2rx1yWFj98+JVTvIWD8D1tW2a7NNrmZD+Omhoi2ZzFx+iTqY3BhlR
	bQmeEoKzIflfUDGPi2qT41yIeKOQOyGQ69C+JZVj7HLmBDYemJKOwPFP4nMySxMW
	pNU+tFMx9q2xdwoKZI//juImwOVohKqTD7WpP3Iz5UKAc32CYWiU4tF5Z6Zs3Ifh
	Us2AaUOVjlI4TsxDMCWcZKl7cPWFLrvNrmcTpAowAidmXbdRF8YY19EhLdn7H4iX
	z+F4rA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87q7h8xg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 12:44:54 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8f1e4e0eac1so34404566d6.1
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 05:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783341894; x=1783946694; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UAsGd5ApODao7ya5c+v4THHQP6gUJNMav6AFOuVH/oU=;
        b=Ggl0XPWxBllPDaYkQ3vaYzwI8IlRG/iAwgyKUOMByN7tnMohqm57v4rAb4tsdK83LL
         XIvwwYcHC6nhwX5WiWdhyVaYEAfAFMdLGiviCx+pkasanCkuN68suzbgYjFogJyLmITs
         vzU5jSRPJxOE3irCBMsUIjdphuCoFHBDjxvYTsb9+AYMN0H60hRJakqb4KC0o1MFjLOH
         DEqYHT4JJMQ8gJwWoi1rgRuLzZ3efm0pQOLmtYQ8VRsH4fsro3K/f0nVmows0matgGSz
         aLTHhQhi4wEh43Zt4O5fihAdCjLkKVwi69nin12QIvF9HsGTCtAWceO2Zvw50VdkXsik
         0EnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783341894; x=1783946694;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UAsGd5ApODao7ya5c+v4THHQP6gUJNMav6AFOuVH/oU=;
        b=MYdgCnn8yfsspODcgyNxMy+8PFOTucqxTqRwQ4Yus9l8BYtgBA5s+j1PAlFXmrsZuN
         2zz7LrcXw9bQ5EbeTHxnoQ7dxMm3YuE/IE0YBZeGl+nyqT12rrRhQqp5CroJWcl709si
         ECQdz/6PjxjzRx/pY8UL9hGoUodlcidRcsg2xuoVhcO7JJbsQ37J7HSnTL/PdL+/yFXh
         3uu/wtfv9TLzszfKAJPaBPK5+NcC7wi61rzYbeaKCGbbSKKY7X8kgopbBzyxrKut/Wh4
         DaCCKxoem+ZT1l1Czx44Zm+devs/3EDiz14tGNdGWocxgFPig4vjzHTCONQJMaGxemVF
         +jEQ==
X-Forwarded-Encrypted: i=1; AHgh+RrSWbQC586h1vSd8NfiZBTdon8M0okpxQx8Fi3ExmPc35POW0d5XIfrrNzUTMpNoG1zRah8+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCm7Ph1Sgeq3EEzQp/FKSLFtkiCjeT2JEz+RBDsVXqcQ3ojnrZ
	YXog5ZKm0J1fK5E+CHlmVVDxWHI8StXi3aKZ/YurvG7/AQGmO8R3ZN1YkaTxIxi1oaIvHuD0awI
	Lw5Uszry49a1AaHrvs9F2BWCvucQ3PFP9a6bypno5axiaaj3vmW1J/oPmEQ==
X-Gm-Gg: AfdE7ckUI4IZMhuXsI4RpsET0kwZzxj9BlsxK8+gDbfj+uDDtboSxgzi+TncgZG3SfA
	VySMF9gh3/7dBC78GJf8jUobnX3NQTFG5Dcx6yQew+v4QWh7foBy+xpbjUh010S4KjT6IMjW68h
	sQHOC5XcburxsIme4UKjlmJBWwJt1jNCE2saxeG0yCeZcdbWu248yhQRDGjDButPgZDioc8kOmv
	jiM92191vBALylDMNTV/zJnqvhOfVIZ9vDDrar2Ra9cSZgxYiNUAcsivXalxuWOHdXptDbklsuA
	cOpzygaKclRZ57fCU3kgSMcy06CTHvonbtAmKPNtcZiqb1SCvLjBcMSVHfrNCHipWTXI/lpkEWJ
	IvnoAdioXK7r2QElMxWP29uHBNO4q07EYmj/o1r3W
X-Received: by 2002:a05:620a:2b90:b0:92b:67e6:8ab5 with SMTP id af79cd13be357-92ebb5a355cmr48465585a.63.1783341893747;
        Mon, 06 Jul 2026 05:44:53 -0700 (PDT)
X-Received: by 2002:a05:620a:2b90:b0:92b:67e6:8ab5 with SMTP id af79cd13be357-92ebb5a355cmr48456285a.63.1783341892757;
        Mon, 06 Jul 2026 05:44:52 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm22126539f8f.31.2026.07.06.05.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 05:44:51 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:44:13 +0200
Subject: [PATCH v3 01/20] powerpc/powermac: fix OF node refcount
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-pdev-fwnode-ref-v3-1-1ff028e33779@oss.qualcomm.com>
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
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1473;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=aDGbbnz+wzV3twb5feb+QvbOP0I73Nzbv6atplL3wzc=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6MtHvr7AjECn8mAtK9ST5QYxQLH8uISzpy7v
 3pFnQl8r+GJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakujLQAKCRAFnS7L/zaE
 ww39EACYQC5v8jyh4RLJSmX9+Q2699EIwQw+LmnX2JTHZ37xaKZXSio5WtzBHutNcZGaaogpFoW
 WKEriZZ/dcQFmhZ/Q14nI9ShukRdTjBSVb6URMZkC1nyYuTj0FK0Sz2ESh9uqDHtN1HEUUv43ap
 cFmOY2eE+QXR8J6C5ZBAhBLzsJ9Ho77iM0WbapO+IFoLyWbJF/U41qJeW3ZaDdaFuDjoJdCbnNX
 gMHxWiSQ2aBucXdIz6hl4TU2MG7RWtc9WdKn3gzGFtuJESiaQzDHNAWeBjPRgvXNbcClk4qW2Rs
 FeY8+K5ONOw43nUF4+Tafg7FLvTlNoIHcbDtV7PSYq3pCNj+Z+hruIi8sXud/6W9vYKvPexKYG9
 5kWYO1Gd0GLkI5D4vudHVM74Gzan4Z0qMnQqPsUY3w57ZVVptL+DJDoOPoFTu9yy3tngTcrLrPK
 ZYgBxuAbV9NLePon1E9TCA8u0rQNn5//N6zpmGXBMEBeOBAU5yqkaPPANddk1al+fGPFzWtNGyk
 OP8WpDK8KBzFhXFC+cIDyJWlPptoS7D9Tcv3k6AoN1yq3qRx8ZSAQ6elAkAJ7Oed1RGDyMUTECX
 3wb+Lar7gwItQ0ahNLdLu95tpxenqJRi+oF6ATIp1WJ3NzZhbRCqA4YKV7ztDBsgCxH6Dpk8aa8
 Y07Wc/MmeOsDD3Q==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX/Kx+hTLSFpyM
 qEafJoF0GNzW5duhki5At0cObAzi7QnbRxyHiB3TCFqaMjAcrljdxL9vVhgV8IAJd7VzGCgZYCV
 MfMe8t/GmhjjqsbfzJz05itb/Vlriv1wgnyrCqOEu49HYPVKfEZ8dQzvKmht+3rWWL4txI2dGx2
 ykOFU/D/CWj9pA5Dkv8ih0yWm2RH7d4MJiYnX4x75WKF7SipAsgif6kx9p+L33aOlRcgi0gD6K4
 MuJEADaKY0t/xIezphlyCS9tZJZvP5yf4hUS5H7y/qaxmCrD13iYTMMDulHumEWrPfd9ntSQQ9d
 X9PEMMZmvzjmwSq1mFvZ80RQyS+yDQewxUA1B5ORM5UrwlhhMMwmo2Rp0ESyFQ19NR3bnuF6QKu
 aSljq1mPna1wFCEcjvPVSJFzFZ+hVEG8BD8ef2nGwkkzUuMqlUx2GH2A7mRpv3yb8vdzDbvVAXQ
 v3VkJdeElMTPEGGGcww==
X-Proofpoint-ORIG-GUID: OR4R6fUYCTMMcHjCiyQC_IkEpv_uHaxO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX7qStyRfL/v4I
 eYTx3Zot8QxGPvjX48wNyPcwsTcVZOEgfZZQHfPIKhH2ZSM/r2/aP6AgX9bsrqClXaG3gLx9lah
 WLg6HAZ4AeBpbtfL/yLyYhm9+m9NaKw=
X-Proofpoint-GUID: OR4R6fUYCTMMcHjCiyQC_IkEpv_uHaxO
X-Authority-Analysis: v=2.4 cv=f9N4wuyM c=1 sm=1 tr=0 ts=6a4ba346 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=lFaTzyIiLygvDfm8gxsA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060129

Platform devices created with platform_device_alloc() call
platform_device_release() when the last reference to the device's
kobject is dropped. This function calls of_node_put() unconditionally.
This works fine for devices created with platform_device_register_full()
but users of the split approach (platform_device_alloc() +
platform_device_add()) must bump the reference of the of_node they
assign manually. Add the missing call to of_node_get().

Cc: stable@vger.kernel.org
Fixes: 81e5d8646ff6 ("i2c/powermac: Register i2c devices from device-tree")
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 arch/powerpc/platforms/powermac/low_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
index da72a30ab8657e6dc7e6f3437af612155783d8f9..973f58771d9636605ed5d3e91b45008543b584d3 100644
--- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -1471,7 +1471,7 @@ static int __init pmac_i2c_create_platform_devices(void)
 		if (bus->platform_dev == NULL)
 			return -ENOMEM;
 		bus->platform_dev->dev.platform_data = bus;
-		bus->platform_dev->dev.of_node = bus->busnode;
+		bus->platform_dev->dev.of_node = of_node_get(bus->busnode);
 		platform_device_add(bus->platform_dev);
 	}
 

-- 
2.47.3

