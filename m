Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBD63BED4A
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 08:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352675; cv=none; b=UkQe/DBWtB7PZNywCSMf9iTrRhxNys7VEpdPuzvEI/TVO2ih5rX3XrMM29nM9hgMQL/UJ1r32c/KkY6UX2CwjPvFqPE0tAknSHormLWXv13Tmm9mTGz1fVI9foJw4Ry0eg3QJSwWYLPY/q+iCq6Ct8Kp4unBrlU7yvAUhLDczhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352675; c=relaxed/simple;
	bh=p+fQeVJ2vmWIeCxFE8NZdHeJWd3aLMCiwqgj0JdxAhE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qY1MfWOdfq8mjOCd+lA3CvhRYyS5sSdHSUX/6igxuJvkjR0aFtZ1hKLGrPY3iiY5/YWW4Itxkk0DjDyTp7JKeapNjfrrLxt6NOWSRO0Vhy8h1sNfslBLVbU6uHnjmyTt5ZpydRsxB1Zed/oy4+x3Kg/uBASLqpWmag2/VbMhIHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DaLgqQRJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OYEbVO2v; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DaLgqQRJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OYEbVO2v"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L8KNq3748568
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 08:37:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s8lmlS7ZeqY9udA3IoNxXw/VBQr0EeteGuDX8nsz6DM=; b=DaLgqQRJXv7nSfwY
	SocRU7aywBVODrbHtAfDYAcrqDXYdrxv4YfVOKrs9rMHPQBH4XhyoVJVj8+ftz+W
	l4heq1kv4t0PFEyXUsjQg5h1+NbAc3kQpTkfoR0eyax8su5UAckvnt10Ny/TNRxy
	la2aSjPWMezrt88xiGbTU0ba5+R4S/9lFdzfmKL5pDVL9I+gICRUoV3ToE+2YoYj
	AOLAEskzwK7IR3BZhRO8S6geG5/gXgtR35ZLGBFdufsm+1VDrT6EzeUwWRSFG4hK
	t+CU9A0tvODp85NkcBYdT3HGU8cZqxUvjFFKgDfUvu2ERSl2aaD/ycrVy5jDweDn
	/ebgSQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9fb6kj9v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 08:37:42 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51009190feeso182885851cf.2
        for <iommu@lists.linux.dev>; Thu, 21 May 2026 01:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779352662; x=1779957462; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s8lmlS7ZeqY9udA3IoNxXw/VBQr0EeteGuDX8nsz6DM=;
        b=OYEbVO2v/rzfr5IHRK64g6XnX5vY/zbpHz9Ch6o8GraU6qah2GztUO6wRw84Oe/I5u
         Vbvdh4R/LXjl/x/hWKkr6x7qaBYbH5D616r5t93cf/0oS48JN1QVboDVN2+8V4yWfnJX
         alZ7oIjSJLjrALow9Jmszm3GdG613KxbJlMieQkoJP/xem9+s3UyzyPmyburH4lh4lWd
         lKkBuZF+OF+6i/u/5kTjMnKHB3JZqva71ZXzntLIbDcxZ4fe0OV1kG/wbr8nH53amnLY
         J9guojTMiDNHKvl/4IApTZdb0k6UdINacrhrs3nEz8USAAqMYQmvc1Hi9yhjq6B2st2p
         hOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779352662; x=1779957462;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s8lmlS7ZeqY9udA3IoNxXw/VBQr0EeteGuDX8nsz6DM=;
        b=YxYWW6THWIL3In/nwvsex43eQKj4YyAKiH0KRkPDqLo09hsHiC9XJxTHxpgXOpBlwu
         +NgVLOgLr5djKyAJgUAOhopKvFIytbhfvObxjTZFKszWR3kxUyEjIRGW6rbqNoFmOnZy
         3NTy/cHEmjBiFEKYgHeC7RuJQVW412BtffmLspLVXqDveQO5Ubj1gyWN/eMTwXTdw8lu
         GEBTXsA3iBk7qKZ5NG2DikTPMOzfdGaMD7cyxUTaXqjMSSy8gfks7PWMjlqmL3s5ovD1
         t4/MJm0AwWk/hHALjZC1cy4twSRNyYoXQpyQ2Oyo4BoGliPBXZNx+4EmuMCMGgHkWg0u
         KfnQ==
X-Forwarded-Encrypted: i=1; AFNElJ/wca34SkMcq37EQOIp2uBQiSMFU66qqZqTKPlzKGc2LAlRulkPcJZRBYB9O3RPL7FOWitc/A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz0B4C+JIBR9Ue3qzka/dw2c9M9L0qugWqjILuJMI9LRppqlxJW
	lDVFLK3Zw4uGU/TsajU0N/HvH/fTs2h206nq9Y3T6aIE1Dml/7o1SlIyy20T95Gr4DHZ9xK2cfr
	65X7MfJUKFs1H9zevqP4pzSYfa+6wLdizMLeiCMyUEi1RQPsK5PYn+vo1XQ==
X-Gm-Gg: Acq92OGlywUcuqomPPHXDF8gscIKEttZ0XQogJ8xXI2zlYEVobRjyf5rA7KV7rMaj0G
	udIcf3mtw3dBTyR7wLyLDMUcbW7WVnK5zF7iMk5C0ldFpXtmEt0DWkSe2A6/ZOnD4/tcnoTwb7R
	8XNHqFW2XeTxEUIlBkTM3NKkMtda3ECQY1ks5uUzw3caWVdN9grsHbycJOKlUNvp312gP4k2+Ld
	rn1X3sDUa4BKC2ZG9xL98grYDr/TLkV2hoj2f/2mP4QsnTbXOG02kFrGo3/IfSzv3817rqJRK37
	oX33ofo6rFaO0OnBs2MSpQe2MU7+Bj8abQiXvfx9cfY8664OOQ/UhvFG8rNl5LwKV9vH4l3nk/u
	640p2z66MwoDCZLLQOATx1ynMZUPhrwMpcyhE5BjsWEdIEav0gRI=
X-Received: by 2002:a05:622a:1e93:b0:50f:ba44:ce5f with SMTP id d75a77b69052e-516c54a13fcmr24203661cf.22.1779352660963;
        Thu, 21 May 2026 01:37:40 -0700 (PDT)
X-Received: by 2002:a05:622a:1e93:b0:50f:ba44:ce5f with SMTP id d75a77b69052e-516c54a13fcmr24202871cf.22.1779352660361;
        Thu, 21 May 2026 01:37:40 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903caede9fsm10502405e9.14.2026.05.21.01.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:37:39 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:36:34 +0200
Subject: [PATCH 11/23] i2c: pxa-pci: use platform_device_set_of_node()
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-pdev-fwnode-ref-v1-11-88c324a1b8d2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=942;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=p+fQeVJ2vmWIeCxFE8NZdHeJWd3aLMCiwqgj0JdxAhE=;
 b=owEBbAKT/ZANAwAKAQWdLsv/NoTDAcsmYgBqDsQo4KNVL307DNwR+/EfAcS03uVuTfyMcVo5R
 Ddt4Kdh/uWJAjIEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCag7EKAAKCRAFnS7L/zaE
 w5nKD/jttCuRwjJL5Z4Il89d2N0A4tqyEE0nA9nXREA+66qoEbjqQyieTedDwGD7MsX/6MSPxWV
 5CG3DD9FTc9h/ClROUNg/GH2d7w0kmkUywGwm9JyvBvlzAtQWqhuj075sIa5tYyeQQyFKPC34Xk
 RnsOL1rVgTEuFPw7IDDHaHI1wZ9tgnujchxPW/lP3+3NQe03UfCKxaQCxAG1ynKA8raoCqq+t2k
 tDuwqhRGAwWDfLmmH+F5oJMBzQm1CP16i+5iXRXocTOr5qSp23nOk1Z0Q3UloRClQzplCgq37L3
 K3IsTU3OSaWhfpVZjZDVu0OjtCMJSs1504goCjTXsrMMAehTj8kA5H2Q3oCJ1ybTPTXCrMu/8zx
 w+UhqGCrcQOhqlnF0W19dC/7abRToVks9nrDn5Nfe/sPPCCMCkx8LdnTYZg26piql+IHqJyhggI
 RkLs/3wvevoUmIlQEEGS88N+eHstmcvVdxGfGKcsK5B24XL9VaFYBNJEgnodc32ODuzo+Syqaku
 ZvCejLw5tSb2aNz/ngtwFBWmsvToRd+AshtUjUtEull4jHEwNa8fuhJk1yBf1zRRFEGMAvVSQ9D
 2oogJMuOeGt9NYmDMDCE4lV3vTJHw/hkkS0pvxsEB3/vQzc0MTZu850MXdoOqqqDJ26YedDWmog
 ilIGvILVlz2uM
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=do/rzVg4 c=1 sm=1 tr=0 ts=6a0ec456 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=Jb7EFCjKRuSTjX4XlnwA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: tcCAZQOcFFCXOUXxCl6_sBchWbU1PdHk
X-Proofpoint-GUID: tcCAZQOcFFCXOUXxCl6_sBchWbU1PdHk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MyBTYWx0ZWRfX7irf35XKvgRp
 yvM9A1a1pfQsyUF2skMmnShNaO6omsO41gV2ua0/QIGtrKrlhgDvQuS7HsJpVDWJza7tMxklUu/
 Gyqay1G4m0u+2dkQmHFkRYqfokmd9wCnwnsfPx4TG9Kyifhk+o+iEkngqHl5I9r8Rb8VRwH86MP
 9+uUviWvvhwiblQyZgXLxiRqABobIXf5XjES99Sf/l4TYF0HBeDpWLGTNa8+ywPqmN5F/MkEHtf
 agUIMcSwj46rgl587bK3WEFtxLPHNnNv8ZHofRpi2lSQN4ftiI9/MrMHwtCapNQxUFXIghxs4rp
 qlcBg9oCKSG4f65cBdxVLFcIiKxNg1N5NYepFPlAylVsP+Fv91uFv+IY+dg28hJbKLzoANGUJC0
 UptVpd6t+tdZLyMv0vBExctysBvQRqyeputOgIWdPtYIr3r/N3aYUeKaf7ZS2Yz4d5SjuVivqPK
 /esSbdZDMvnciu90QPQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210083

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

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

