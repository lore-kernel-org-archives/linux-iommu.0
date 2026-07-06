Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFD24C954B
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 12:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341931; cv=none; b=XUALfSvQ1bEaCgn04Iuateun6/wthbNFS+HnPmGk40qqfaKwUj4Vv8l7oQeZri7tkfQd6iVUiLEco0gM1KdmZCRRhNvErfpbIaZPItIe5GXYcV6iq2J9WYqURENz9XUFt4rAOFTLY5lUcp9aGdHkMFmVRVEmL/QMkS/EZIfKuWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341931; c=relaxed/simple;
	bh=zNlCSBzaa8h9eLrFPJ4Rsk88by0DY6qHl2V8PSoqi0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bQrFyOuPsrmoRXfF0i6OG6F0K88F5bvvM6PbR0A7GV7lqBG1RNA11dWW7wL66nlWyiQ8VXrRlyT98mrUr7w4HcYIYkTyWT6i9wrCkk1KXtOjUEAY7AJ5a0oweTHs+cPar9xtU3ITZhudveBIy/XJDzgjYwIImDLfYb9mvdy+u6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ebOZdHAw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L0SHHM8m; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ebOZdHAw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L0SHHM8m"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666Ax7lH245521
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 12:45:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0bXtMmPvMuVC61lphaB+WyfPoNQ88yrVKYbnm8jwg/Y=; b=ebOZdHAw+6pvz8U5
	guxfBlryTpeglXytQIMDf3qb70gs8OqD+lwFTn+TG66rcgy2RCviTEWtn/ydL5zH
	0LGJgBOBodFF1ycxr4uJ9xW/IQPIkl/yCJQb2iZGsHVpG8AmRZ81E+/eHhWqc1OV
	1HwR4fjhtQkotKRlcShLfUG9IqvbsF/ryqc1sesHzvoZx/JZL/x5Gn/9mRbf5+29
	hitgZGkTaIO/Fvo6JuKOHb89bpnOvrPgF9j7YL6C8VxFb9Id0iA9jcsSgdLMlxVo
	bcDiq1L7xnn3E/Z7cJ3JFI9rteqpICWlCsAbGItPxIo0ZrHZcqb3kqSxbDlCgqHf
	4ZP8xA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a98gjms-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 12:45:16 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e5e38fbc5so264094585a.2
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 05:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783341916; x=1783946716; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0bXtMmPvMuVC61lphaB+WyfPoNQ88yrVKYbnm8jwg/Y=;
        b=L0SHHM8mJuRjl37tMY/ENu3NQ/kri3fNlreW/731eBxnz41VjZmDtkP0fnBWwFVG4b
         Pp9jq3jW9/3enTTSLLqNG1DQE5xFnrCgVG574Qsj/YFbZCdE1IN21JbF43OQHK36pvEP
         RgE4wWNiKh7WI+d/m40rUNlz6N7YpvdraJRmjfd7jn9wrX6kA5sGsTE5VtSDmaJMyR50
         BDCriLGUQcysuZSA2w4Y44lSNzOMg1TcNiOUbjQl0iqCftTaIrCTzTTGWtdLTTyuro+I
         JrbLt78CKUkLeKBDhj0Br9jD2irTYoV7ZMlzjHzTsP0zPQ8eu2nv77CX/ulkyvq2uJCH
         X4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783341916; x=1783946716;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0bXtMmPvMuVC61lphaB+WyfPoNQ88yrVKYbnm8jwg/Y=;
        b=H6RSgTXB8DJdOy4kxIC39c5N2kW0Pfog5hZHh2ucbAWZNMYl44ZCcTYfkmtEftou1B
         Oibe38TwNSeFY0u/OKtaTzKBaE0MbOmeuF8GUgxUz21dcvp2NvHJJADIEHQdYHqyd6Ps
         dLl61qPVnDrFCSgJCsS5ds0NyF5Z1m0/joViN3HWd6I02y8OY/XO1kCzKv4KLgTKLfax
         EX3KlfzZlnkEQBvwmUPR0QUUBm5Mk7nMfLvHUrHA+F1s4mKeJP99TnurBg+DXFSiaew7
         qFw6/DbPVzc686JfiaU0NzuWlZyKpFAFMpyDgryEYXy1vQ5zqHG3aM7M+uKK0btjEbB/
         +2Hg==
X-Forwarded-Encrypted: i=1; AHgh+Rq98yQSsJxBc3Mahk+IRz+1HeLuGZnL8AvZB6MoAh8JoygtKrhT1X2ijrxCciqhpvWHxSQ3bw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyiTk5kYRLRsajiAWkWX39AMOvdlMg+oZPJVk+KednZFAbevfrg
	LBishJvRUjTmVAaqAlrqD1g0Ca/XioL6rfo0Ne7DDhKiJqcRIHASHo2eawROtUuoQGKF6WRwox4
	cwJkltTYczNL7jJk8b4Wimw2emZJDL+jZisMzmbwBWLGEPz1lb1P5xDtYUQ==
X-Gm-Gg: AfdE7ckJ2EgPIaJMi3FvmPFJoR4hFLF/QAl5jDTfLnwXaqEVnNuzsPmUR+ucd+9jcoA
	CAr/WZmLMbkTIrm94P7BCmAY0X8f0TrOtJDfqx20f4HEEdFDqG3p10kbp7FQftb+5Feia4b2YNs
	vl4o/Dqzr1kpx5q9ANss8RgRt6sXva4MDnbK/a05Eqwzo7+ZvQq3AxoVEXlKZy1f3H03/JOFZgb
	ljHmPiDOAVg5AR63PGM+r17kH74Le20AXaepiTVzXgK6FyJTSKLeWw0N5w63h+5YDQuD8PqSOE3
	XFQ4kM0mVH5yehOHyywBBveO8/0BewaISRlXzyl9bXqqm4OkHvslab5eWuj/K0qiyBddaXUF80c
	5LUTLYQsMQHM9oqqu2Z4Knihz/YTTfi+OuZKG6GlN
X-Received: by 2002:a05:620a:2911:b0:92e:61f1:6b72 with SMTP id af79cd13be357-92ebb49ac6fmr50867385a.13.1783341915047;
        Mon, 06 Jul 2026 05:45:15 -0700 (PDT)
X-Received: by 2002:a05:620a:2911:b0:92e:61f1:6b72 with SMTP id af79cd13be357-92ebb49ac6fmr50855685a.13.1783341914299;
        Mon, 06 Jul 2026 05:45:14 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm22126539f8f.31.2026.07.06.05.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 05:45:13 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:44:20 +0200
Subject: [PATCH v3 08/20] i2c: pxa-pci: use platform_device_set_of_node()
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-pdev-fwnode-ref-v3-8-1ff028e33779@oss.qualcomm.com>
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
        Wolfram Sang <wsa+renesas@sang-engineering.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1123;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=zNlCSBzaa8h9eLrFPJ4Rsk88by0DY6qHl2V8PSoqi0Y=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6M26fTgmFzEcwV6TgLmONhrXHSg1JSo5rARQ
 cIEm8brQ2iJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakujNgAKCRAFnS7L/zaE
 w4FQD/4xlrZKVrDsxMxMDylskkXcnlp/TO8AFqhtcIAfJPLix//8WtkgYU8BoNMp1g9Xn0gqxcf
 Mqf4MoSZUM/9N4F6rrhsUS/fyZ8JjetftBgldbi42hSBBzlfigoXf7c7XsBd9RGYeEc6bF6Tvuk
 BeJBj7nTA7F/4P00u7JX8G1/EeAtOw+bRQp/bw49wlB2BMUcu7ymW7ZraPoAKhBLVQ3rfni2ggd
 v7fQ91AkgPqnXxlC03UumTZYRoodacvcu3K2/OHWjJ0tNZDijDmUhbLuEo5YxD2+r6fe9V7u6S0
 1AIHBEWJKLNycrCiocP2fSza0iVf1XHu6s3E0WBNJBpHEngK+P+XhEETCzEVV5hM/s+NO28XuUL
 BwdgBkheFv01xR0OIIv2htjsf/BOvFDkVUAE4mRwAAeBbUIlO3d1Gc/xIBw3P5sIyC/K1IP6Mpa
 29UAXyfBBm/QY0Eka/LOQnWf1rHBt/qWrcr+P5wHlLfPBPVvN7hFRXyJSSRrT3ZERQqDvupO8Qj
 ptCFfm9nvHLamnlGUxzUrLNpAP0Oxg4KP9I1Ee5OxwE6+tf7mtUlBPB89eKW+UNWpBN9GIYK0ZA
 yeTbyImJwaYxdcjvOhmsd7QN3u8NfTNp2Q6n3JTwHbo5apELLjJoObnNQc0x01jWKh0+xRyswe/
 xFrtfFeb09kS2tg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=SpigLvO0 c=1 sm=1 tr=0 ts=6a4ba35c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=LDBv8-xUAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=OZ2e4d8rXakbCkRG61MA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=DZeXCJrVpAJBw65Qk4Ds:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfXxyuzSb6CB93Q
 sHHv9lkKmyrKl+JSl0ccoLbBusGUJOIfSF77/z88Z9mo1DgF0Bh7n4p2tsZHbcEW9TddpEWuA88
 K8ouNOGlqMlw5SGBYYkxYlauB9kuA3UoGZeN++OBNjnD7aCGFQ5aI6vhqsJkn6LG5kxsbDoxjsg
 4nfmJQFnOIYvgUFSX8WqAPFTkaLGdE53nku+cwn2ClEe0ESbhe/Jpgvxn3h+PFy1WaQwQsZLveU
 IIbnoPKcyNwDUvhrh5L7xQ8y2ingSRmq7bM9AXO6vrnQBXGYo4FdEzIBO/UcXIb6z2sbOIWOkzS
 80jplvgv2DWca4G3iaDyj1knhtZmMykYaU6dGVGm7r7iMqRDM28fgH3sHfc0okG+qY1ftTwMoCz
 TLa64OhVdS9KtP9Ssa9ua5PhvDZOxySr9GXPZsqWFBUeqsmnKypmbDTFPTjrMbp8kOObXqiZ0nO
 yi7HoSKBj23320ebUtw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX97lLqmqaCffn
 UwTlmF+HKtW3zE8TET9/XFbL6FymwDa1t6ws++80MJAV/6zAsjfUyIfrzw9PBKrP+UsSOY3Pro2
 piAZlDC8aaCpyPPwbsDs+TiTx9uL7bM=
X-Proofpoint-GUID: WrIkOzEB3iaZeEB4duq4Bl0bQUQGfbsp
X-Proofpoint-ORIG-GUID: WrIkOzEB3iaZeEB4duq4Bl0bQUQGfbsp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060129

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

Acked-by: Andi Shyti <andi.shyti@kernel.org>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com> # for I2C
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-pxa-pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-pxa-pci.c b/drivers/i2c/busses/i2c-pxa-pci.c
index dbd542300f80043c6bc65a69fa27ca7b3d5fe787..92a0647f08c69f841ca99caca757c1728b3f6fce 100644
--- a/drivers/i2c/busses/i2c-pxa-pci.c
+++ b/drivers/i2c/busses/i2c-pxa-pci.c
@@ -76,7 +76,8 @@ static struct platform_device *add_i2c_device(struct pci_dev *dev, int bar)
 		goto out;
 	}
 	pdev->dev.parent = &dev->dev;
-	pdev->dev.of_node = child;
+
+	platform_device_set_of_node(pdev, child);
 
 	ret = platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
 	if (ret)

-- 
2.47.3

