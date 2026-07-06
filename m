Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2994D98E1
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 12:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341947; cv=none; b=NZm3+7A9t1YHGx4bKbGFgg12OCrDj4XsLZ0689lgpXIa2O9oKMjfzIF4fnLJKlnUQ6J1Prit6YErzvF9OTKkeWZRH2mk9RGhGktBeTZsZxlfWheHfxQvUsXR8T3dreTmIj9y3mAos28+NPx/SVau4fTNgF7CKbR2GMKMxEjIQ8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341947; c=relaxed/simple;
	bh=Zhi+F3sSWgohZECXWnDHQaM+wwr9Sm+ARxs2xrHRhPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XWoz8+ummwx+6gQ9Nu6njAKC/R1IMsfcesHYhQw6rGH5xRjPbsO+ML8T+2LJOw2AO/rUFfsOfZ4cP0ShJy7TFVylniLCfpGhOPIYI8GegbqOvAzT6HZuoP8ZBlvvzPavlJAc6Dn7i79k84BEZquGbzGBcQEchJeDbPfXHI6GIEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mVsoom+I; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UFeYl0mV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mVsoom+I";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UFeYl0mV"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxG8Y387186
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 12:45:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	a7M+qB1wtuA4e6xlSP5UxgmQli1U/aUaTG8atTWdnUA=; b=mVsoom+I8UuemRAx
	R/ZfNmuKeVyyU7qCm1RkTJyHry5NQoN5fYILHYU8u/80eqT660jk7F2fx5b4fsG/
	zDcEWZhwaDjuE5F1BLo/UDOSyn5DHpnJGIU2GYWrZ2X5TlRuAkUa+Fmc/nZ6lZkd
	Czc0v7XG4Kfakwx1c8TbHIvgLVi9Ltj4g6JI+XTc9cNxLi7ext3cI12DYV/oHmAD
	2GDtb4/5k0DrTL7icyFt8bynGV5tAXp4iy0WZyNVK/xusG4kbML2949Yl7shJ2zH
	dDcWOaMsVzDH8ZQeS4yN7Coed1mAYEXBih29SLCoW9NzXF3aPqUjdRfp8t1v+uj7
	4pLhBg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3r0mmr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 12:45:28 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e5e38fbc5so264130285a.2
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 05:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783341928; x=1783946728; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a7M+qB1wtuA4e6xlSP5UxgmQli1U/aUaTG8atTWdnUA=;
        b=UFeYl0mVdwDPQFS7VcM6UUfQxem/zouMQYKl6k3VxzwHVg2AcNqBF3Rcm5pL599546
         D8u5lHUJTeZ0v/DzpHootUuXBjiXF0+5pWXTg3AL6i+ARMtlTLGdKhN0HblgZFSkXdPu
         fTnnRjkvL9fJN0IwJhx4zlvG0hX2fPV7dFvSG0vdXYmgWaR/GOP4B6zcngJAJ6ldmjt+
         8OJi5H8/baLpimTe4Eb2rf57CoC9NqkreYFSHdsmXoMf30e8mWt07Gj2tIvDMqNl75Bi
         cN90vkkP15peaHBEpCdCXZLsAsetdjouyoarUrhPezWH5h1tP7dVVjZeosuJnd/SBJz1
         T9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783341928; x=1783946728;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a7M+qB1wtuA4e6xlSP5UxgmQli1U/aUaTG8atTWdnUA=;
        b=h3W4HuwyZYDVBejbZ2KzcbAwJSv65AwVyQjrTxA3BVyHijEiHDr95yuSY6eFH4OdIs
         VZ8GD/O3Zzu+dis4tk3dO5QRalz714stIwl+j3ibmXlJfMoY/uw7b2kPhNe4MI2OsH42
         nC3G/nsYhqW40MTHruclQsDdDvMI6xnEe2kNR05Ij2TyHhtMuycTn8kWR9JW5oOEyNSA
         YUJ8kk7PXKVP+FikiwA4NV2FQkLEs6FaA0hL4YRsm//jwMKEsNkyKTCaNkp0Rhcxm/EW
         q61x7iKoH7/DiXndya59v9+YjwRxwOYNsvLrPbIqrzicTE3ZYSgwsxI7ISPOYCkWoyx4
         BlvA==
X-Forwarded-Encrypted: i=1; AHgh+Rq9RsHjsfcvyQvZ+bTzST9Nt5AWoWLq2f4fn0bzB0fIO+TQLS4IsTd2XAjx0klgs17DeiyzWA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxEp70Orp1fDcq20lQkGzHZ07dhjYF85zWP9aii+MORSk2e3Dg0
	vNDQ3rDTKbuaZuR6sWyBJo0jkAFIxw/IKKe54BDCJ+2u+IDjmE+k7w5NWXQ02FYg7uQTxctOMS0
	Uxn+I7l9GCj7y8IeUf7LZrcfAVM68x4bmBZJulLQafJqIYEUUGRrzp9bH1g==
X-Gm-Gg: AfdE7cnsHNGh6FNI5wT/Nd3Y5rOF2ccCb5S5S5D/Bw4lBMO89p6Te/1HKIMNBJk/API
	jHKLVnEgdeLnEhSNJjNYJK4pDM72UhUWZB1jncE154exuyC7IMbOCqeNG0unGau/s8ipU+wVbdi
	mbm7BzxvzMKEiVcTiM/FL1xv1w7/C2Ji5zKZBWhCxOWA47tvpqr0eoXU1jdSZblvxoXdepHl2Uo
	SngJG559KmWtQhAcPifA/Duw0HLEGHMq4eHtzzn6ym7FPi9fJGvVnsnyTG1U2GPOej2tWCO9Gfu
	pB2XCLrqCbTZpF1iPJU4Yn9D/KTdjcyCv2iOPbxsqHnulKUBt/iyZ/yruuYykOLWSJ1Lw/IV7Cl
	xb64rFWrVCMAS+bADpnTCNIS4lirNj2nTpMja/MJY
X-Received: by 2002:a05:620a:29c6:b0:92e:45e0:2588 with SMTP id af79cd13be357-92ebb5903e4mr47956985a.55.1783341927393;
        Mon, 06 Jul 2026 05:45:27 -0700 (PDT)
X-Received: by 2002:a05:620a:29c6:b0:92e:45e0:2588 with SMTP id af79cd13be357-92ebb5903e4mr47947885a.55.1783341926531;
        Mon, 06 Jul 2026 05:45:26 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm22126539f8f.31.2026.07.06.05.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 05:45:25 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:44:24 +0200
Subject: [PATCH v3 12/20] mfd: tps6586: use platform_device_set_of_node()
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-pdev-fwnode-ref-v3-12-1ff028e33779@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1025;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Zhi+F3sSWgohZECXWnDHQaM+wwr9Sm+ARxs2xrHRhPk=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6M4FydUTb0fLA7v8UHs4cH/yNkk78x4q5hdy
 wJhY/6umy2JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakujOAAKCRAFnS7L/zaE
 w2xvEACFL1p1phfk9S+82M3HHVOICD8gtkblfhA2UFHpFsY7LhbJmM/RpC8etf2XcuDnH2Wjsaa
 7ugVGwdlyrP3oStrvCOD8hXv34YlCuu9r15uW7DIuBMUQ0lVsP5/RhYk6rI4lX2yJ4Mb61Yu4yk
 +ekCe2PEQIApK3zi45KvVkl+eD1Yz5aiXqc1aNNOVzgJVlYnGoowk8R2OceFSR9D/OSqK6etbgK
 Kg2OSZHlSosDeDMFHTbBcdfL85jRxwk2wyu2+M/V/7sFis5TmdnqjShyf7zAbDJVmKw3zdjM33b
 TgzYM80W7O0nZf0BT8iFML0Ky3MuTWgC8pt+K0WOjpadEZ3I5GmWZCRFFwbpJLIy3NXFM0Du8Zy
 DC4PlcROsGtdVB2hZRMg7Zy1kZXbx0x6NmiuaKrVjT43h8GUkrK0nG6Ap60o9hUG1/pm4deMDq2
 0nz9SGlgZKIm7UqZtXAYo6WvpHEhEswZBQXybaG6a8CaFgZCeitbc3tH1tofpjPSXP39Iqxq40+
 T0I2ZAKLZFj9oQfyLF86bX3ET1D7rwiFZXwxCvzfI/YomTynpdYJ53ELWCvRBMznaosXCTH3BE1
 /qjZfJ+jeUZHYjhdjxciVXxitOM0ZToEZzwj1w4IfNVjBkOJPCYMMfz2wrFiRzmUMDZrKrI4lh1
 J5/eCP0vP9uobig==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX+sKKIS5KXvl9
 4HsZXe4B4+itRGZB+EcYiJKCiU6foWtle78SHQGnSEGX8pncspfhBJiW6nLo5A0r+p3jxmQDNDG
 95FgjTw8ONDtmifN/oeqoR3Ffgh5gZyWghhOpljhwe7Cx7T6frF3cRYMftiMDSIRaSvupDcN9q8
 6kwA51CkPMdL2P1NcmZ5KIe51tIurr0OyypBiiFVpy1ZOKRhS+MQZ7D1q5yZyrAwibLLuLZuUk4
 jpcSDyf97tsK+ovNk/gQq9vF0g0AtXKf4JjqdEzSp11mrnGDrW3L4R5xxZiq8QWadD97Q3DqdM0
 pdZ6QVrSNroM2kl6Tv6IKj58macCM9WyWBDcxcBZ1fAeuCDAWbhEjHgdSbiLpm6g4AmwbxHCSbS
 V8IYVFoQMjr65dZn2bWWYV8YSI4iowbbqOjYxktXceuoR7Id9BMA2kX4vUAMBXJ22C+3AkBHeNK
 QVEQSZxIqRq3w9jxPXw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX+bfCE0oBoxa9
 OcpwYo+4XKcZY9P7ZC8eXFCvuegesrcrYEbHoz97+GGTXUX8fmdF83WkR6tJZnaEcHh746aav1l
 b4SYHVnNzEgZwqegVLWme5ZrFOey8P4=
X-Proofpoint-GUID: D3I4ybviApVRSyvPxIS3Az7KAQcO9BH2
X-Proofpoint-ORIG-GUID: D3I4ybviApVRSyvPxIS3Az7KAQcO9BH2
X-Authority-Analysis: v=2.4 cv=OKcXGyaB c=1 sm=1 tr=0 ts=6a4ba368 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=ESSmVKC5p6WdXJfq0SwA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060129

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

Acked-by: Lee Jones <lee@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/mfd/tps6586x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
index f5f805446603315ba76ce1fc501c908f1cec0d16..3cfd2f02b62f3cc370e0d970ec2643b638fd0fec 100644
--- a/drivers/mfd/tps6586x.c
+++ b/drivers/mfd/tps6586x.c
@@ -397,7 +397,7 @@ static int tps6586x_add_subdevs(struct tps6586x *tps6586x,
 
 		pdev->dev.parent = tps6586x->dev;
 		pdev->dev.platform_data = subdev->platform_data;
-		pdev->dev.of_node = of_node_get(subdev->of_node);
+		platform_device_set_of_node(pdev, subdev->of_node);
 
 		ret = platform_device_add(pdev);
 		if (ret) {

-- 
2.47.3

