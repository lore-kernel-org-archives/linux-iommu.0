Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAEA34C806
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 08:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352691; cv=none; b=bvJ+bOS/4MYE6hQPQUFVuR3AUt74c7JGhPZcet0bvanwMNWTz41t3Q7T6HO20ZZiAe0TU/UChw6EKKrvHVQWtK6nFYZYqBQkjQYZdsTawr/2VjiwGrwSwYyT9Y0if2E35gInhFysEBPPtGJ9VNW3jUC13mWfoeOGK2Xsm3k53fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352691; c=relaxed/simple;
	bh=AwfZgG77y5F6PYl9qwo0/ZCBmtiBmspJvlFnU9x6+ng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sX+D9z/dZ17cQ7Za6m5KYgbGjLBeijqOmogPgS0dm6D9zBZqH7NPCPPFId0MQ+1+A+nYjACRw+NkgB8hLpgMDJn2cgacr/M/py1MmwvYQDqqD1emqZMkq7FHZhETUn775AoIT1NMrrOUoFkC+oAS0D0y/IgZrSs5otZeBvRV9dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ID+Jeg6V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HaNa065G; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ID+Jeg6V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HaNa065G"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L74SPc118977
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 08:38:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6nG1Sji42mne2H5wEre1safG9ubwm9+aubw7cimzGYY=; b=ID+Jeg6VlEGzfzjc
	ABNrWzZHeBx6b0H3uUKq40ilRNX9Lwmp27/eT6p8sqUlI8n7hCN+EsBbS2YzzKop
	JoMypKPL1A0XndiIqoopYstFcCePXRPlk438/kTYwZ0/rhrVjqysUZVUBqa1ZAGS
	sQkLOBN6F40mShMHg9Al1lnYmiEP9xCxd8FE17Vu4IUaTwGuAqmloZcMTCVEjvTC
	4M7WHfnN2yMZri+DObmOK6XPwjjcxgzpYeUcLJAB52rcWBOzxdmg7IVnbtUW3n/D
	dsLaSqGUIY7Ik51Fb/FGLeksa/UgN25CxQ5aBBvosWKNDShAFMB2zveNzJlZhGJq
	Z31BOQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ee8c1fq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 08:38:01 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-514a182b90dso81881541cf.1
        for <iommu@lists.linux.dev>; Thu, 21 May 2026 01:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779352681; x=1779957481; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6nG1Sji42mne2H5wEre1safG9ubwm9+aubw7cimzGYY=;
        b=HaNa065GbJb7z3JZPFzPQozgyfrWFTW/1IIpEw9m93FcndsK2NijV7HZoCbPMzMTzW
         lGbZKDVl17juPYHUGSc2v27HvQCVIUM5lkg3gXPaBsLZdLhycLJBen20IjHveqARqza6
         qrregKTievdBCoSscz+9+jSnQ3zzFw/VwZhk+jeEkNHvuo8RFtsKs6gTD09T7Aha6VOx
         Q9+8ehFQHo7ViesqYtXklDcY8BfTpZ1MTOcE9uJ41ues2NOPVuiVRZ/YVQoFjbGqy1Dt
         JiDwZiXHkF0Sl6HaixNa1RmW5vVdAKoGIs7yjQAt0S02tekPaZa9XpDYBZGON+giaLQt
         Uakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779352681; x=1779957481;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6nG1Sji42mne2H5wEre1safG9ubwm9+aubw7cimzGYY=;
        b=I4Pxzt4hXzaooq4uHUhkfyTcwDVhqRBlj6dOjt7S2cc872cVhwBaZWq3n3f87mj2sa
         Mq0M5ffpu7r0K1WzjIQEGXkrqHb14pjkkvSWrQBcyXh0yvGwH5Y6H8CUC0QkCtYv5OXb
         v9bRjl2m0m7Qo6sNpN7SZlqvKBwmkyI9kmHaNz9MSxqpmVGBX/hSnStKDx5LxiFD9rXS
         YIPyuxwITM7afidQz66s/BB/YId+6O4Q5a2RPkmRnGJOa/DWqzXOrj+9v3eRY61RBbvJ
         UyrsjqbCVkDYc7vjZeCot90+sURrm/FcBhTxpWABQ1fuXUjB0qwroKSaMhp+zJnv/+l+
         wMbg==
X-Forwarded-Encrypted: i=1; AFNElJ+1p+cCRdLX7Bygd5RDi5WlfnraG01DpWAY67L98OXUpYxtGwNLOof3l0NDcv34ZHXPI6tVrw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZuHQ+gbi59BrBmTWEs7ih/+olwtMD7DS49oq/knem6bD+mOfq
	UVjPw8itIr0S6gpbSkOySmq/tun2j8ZTzEN0OdmEPZEQtGRAIgCy0H2MNVgMkIXOTNO3zP0Kaps
	dL4qN2MMbqwq2mi2UnFtsQlk77ni+d6wbba9go4l/5X7XQZgGPBaJz/pTQw==
X-Gm-Gg: Acq92OFnOEc8JI3YqjNsBc6GjyRBXCQ83yYxgvpeoAXnlUHIMEyIaiZsE2vEB9gAuDa
	hc0SR+Twzc1q0V3fRrkBDwpDWKG9CCF1OS5YJq1i77FZ75rXV1XnmF0u53gU7Xg7fpPotxXIriY
	QxNp0yIXjbXyQAl8EaqPjvcAZM7qoWnKyMXNjDJWXgWlhXZTAS+MkILzKDF8ssurKDvE87JHNvY
	ziJP/WY8+VYrKqJMNjHRBM2uVHoEf4lqn3hcgci31Y1j4ry/Nk5FtHLaV1y9nthLdh/ZH4jVTwP
	DC88psP+ppFZcDrbNXOFhnCeHxxxZcfypINSpUX0i8/XelCCi9Q4U4znDAPIHYH4uVyMdrR2qRl
	g89jxP8tJkcLAGbmYZoPlw8UonRkmZfDmhbRfG+z60lHWVbACTuA=
X-Received: by 2002:a05:622a:428f:b0:50e:6139:492b with SMTP id d75a77b69052e-516c54d36ffmr25861141cf.23.1779352680523;
        Thu, 21 May 2026 01:38:00 -0700 (PDT)
X-Received: by 2002:a05:622a:428f:b0:50e:6139:492b with SMTP id d75a77b69052e-516c54d36ffmr25860891cf.23.1779352680022;
        Thu, 21 May 2026 01:38:00 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903caede9fsm10502405e9.14.2026.05.21.01.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:37:59 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:36:41 +0200
Subject: [PATCH 18/23] drm/xe/i2c: use platform_device_set_fwnode()
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-pdev-fwnode-ref-v1-18-88c324a1b8d2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=863;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=AwfZgG77y5F6PYl9qwo0/ZCBmtiBmspJvlFnU9x6+ng=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDsQshnSHdAuFYcbx8TH9pg/aRRhueDfp7T805
 pLQ3jVO1maJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCag7ELAAKCRAFnS7L/zaE
 w0AcEACkcrfqqJKu08qKaQURCEwjaC0VPahU3S9U3283GXeiErM5IYNu5JJrjea3QZl8MlfmXb5
 SFTYfrLXmYI6JIuyjgl2TQzUA263xOXlZUOeO8SGMopYyTxHYNvv0ONqcLCGyUZySI2ty6bUgNG
 64YtY7WTwOy4+CDzbAma+vOVRDXqdOvNAAPCeIIBTW2y4caXnY98e0qOBSTRtTkck3h89oRImpT
 zDeeYJeFsOuex54YCWKWOplr8Z+ZwwRzreIOMcRxLpmtDDQHcj+SLjNhOsRhyY7oq1RQ6w3odA+
 M4QLbO8O/ZdydOkb2886HADgldVNoch8RXYxlFkPIBNDG7rGsFtgDuiLI6onxjFzFjIzEivvkWd
 avWAoE1QA6es190q5P1u4C/pxi8SEtsUnGt/wQjIuHwT9eyxV4235FPNkaI8ZMSLwxLILuNUADT
 XGLV766TGSDRYeqcHDnHwlX0C425iCJgB7nmpY7EU65lHm6EazqmjATmUWaIolfry29pp2gk9Nm
 rpVpkLIugd0sErp4t0xihwMkR+IuTy/CAtj/yLudnWxJByNNrQrz/qqIhuS7qEoDNxaMKfwKf2K
 y/swBz0CNPMHxovuMxz/G1myVahNG5fM9v2kTWQJ4UOGn3hfxvNb9LgbWFZ4spA/hRyzjmlCapB
 4qJ6Lt9j4lxYQ4g==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: GTR6Wnj8EoNpKnaDa-V6H7G_w7xYQRZ5
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a0ec469 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=Jb7EFCjKRuSTjX4XlnwA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MyBTYWx0ZWRfX+u86WKly9//X
 4PEPl+z8Wd093iOgdvSB595AmWL1qCqGbA61t+C3s2VE6FrMd0aFvtE311J+xlmQb6X46SJ9M3/
 RmDYzixKVlsYwvKWmlHdwEEDjvx8H60hgyZmRwVW8qMuw7v8/JLaUbVn+/q2zwgr5o3c+mj4dSG
 x4X0wCGf5IBXgkX6g3iUptSCtWER2phsvn+ycaecmqsnNOGICmFNPVkToQ70AJwlBllQp1Yi6I4
 79fmqghWLn2VwZTDi3zgdLZhLPXP8N5EtUx2dL3sWWXiIpC8TkCu/9ScD7nyYVW5T1lQ5f7oAfq
 ffH/i8uUoLDeRECDJ2spLryE6Il6SDdCuywlz9rshTQqo8qsiQh3YK4eTLxBqrISrp2iuc58etn
 AaptzJXWmvLq6XkhdQ1wPoYM5UjCHGKUVgUdHA1Pp1b6m25M5AAOBxfApFmskZyO2hqZADvfDp9
 DCzbx/ij/jvpB2JSs+Q==
X-Proofpoint-GUID: GTR6Wnj8EoNpKnaDa-V6H7G_w7xYQRZ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210083

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the firmware node for dynamically allocated
platform devices with the provided helper.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpu/drm/xe/xe_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
index 706783863d07d66b4685005d6649b3cd143ecc3b..af4ebd93ad8e68c95a14cdf99de0959fbe080354 100644
--- a/drivers/gpu/drm/xe/xe_i2c.c
+++ b/drivers/gpu/drm/xe/xe_i2c.c
@@ -123,7 +123,7 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
 	}
 
 	pdev->dev.parent = i2c->drm_dev;
-	pdev->dev.fwnode = fwnode;
+	platform_device_set_fwnode(pdev, fwnode);
 	i2c->adapter_node = fwnode;
 	i2c->pdev = pdev;
 

-- 
2.47.3

