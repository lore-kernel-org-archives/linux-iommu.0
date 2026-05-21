Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE5C3C37AF
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 08:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352683; cv=none; b=gjwjfH6QpuISywdKflczKAiesq1Wryjfgrml927xngK+VHWdP/IhKLk+YCy9U2JISrY4V3t/6c+Maci9LRRNIR2qBvu7bQuTbyzpuqlyRD7AIyTR42dzSJj81vPX1gfQP1tqADfvjyN26WYLrsGWpYArIV6ylwtFptoV+9i+jkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352683; c=relaxed/simple;
	bh=1m0AW2cExEyKezaoaqpg9M8Sd9W7xIah4eoQaNoNaio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pd1Ve05zHUe5hi/k3zNpjRMoDmM64abYGqtH5scvE1RHQbtl49bh/Pr/WRotYwLJfCK2dm5ttsl9eHKCFpI8weHs7bJucFDMXJD7yY7JoM7aVS8/pM/q6layoerF+R2LA6kjlM+Ud4LE9XlZwNjgS0GMxqtbf12sj3gUzcZixCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U38oypav; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZzKNs6C5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U38oypav";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZzKNs6C5"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L8Dj4q748397
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 08:37:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LiqGJIubV46C/XuNtoDonnq8kzRgQ9Nd2r1gbru07SI=; b=U38oypavBMQHX5RM
	5DGo6FDgcziIR+bFjcD66h11aj4Zak1nBWnsmmy4BL0uNyqk4OOoDi8VlViPoqNz
	gcwUjAXUut08G0bW+Jku6vIOsM7mx3MUO9LbNdjuEZdKCkz3D78xRbBA3XGVKW1N
	+EU8lo1LerY6ObmfBqMRLu64nJzLgMwhgfJh3ZiTCZU2WGPZ8qbTCCKXTru3SBCm
	tmaKbCMYgNpPkycbfHHImPSC1aF1Jexy47T8eyH109lN+2ndPMR1gjwtHffYbIcm
	bX7/IKe7UXVgnq7l0bzp1rMYGM4p3cB0TM4ANHgxZM2WX3OtuoEDEOEn+WBO0Lna
	hdw/gA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9fb6kjbf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 08:37:50 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50ea1a7a5d0so167924681cf.3
        for <iommu@lists.linux.dev>; Thu, 21 May 2026 01:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779352670; x=1779957470; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LiqGJIubV46C/XuNtoDonnq8kzRgQ9Nd2r1gbru07SI=;
        b=ZzKNs6C5IHCamKnT56IO5cC31SicY9hSboLzqQd07CwtJCDPAzb5Sh7H70T4GSxTTw
         bCTvXjZ+tnlfezR1JnG5/t5Hx8XLbB3qrsUTcLvbMdd7l4VcIYp5UhgiOfZRieoY8Xzg
         1kqlKEe4tG+fZUM3Q0aOHS7ut7FZN31wVZPslI+aTNWztng/jtzxAcabVpIZ191Lelq8
         VKQUK9ZiTYEGPK8bUdOZX7zJuNeRZGndvSS36LeeRjLLOVOAUNJwUwMaNfwsaA+5OpXN
         I0X3cnleToNauPJEUDQuuUAt/4lIdBnr9jNIefOtSEiwmLSgsblKGkut7VZJMqZn5Tfv
         k/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779352670; x=1779957470;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LiqGJIubV46C/XuNtoDonnq8kzRgQ9Nd2r1gbru07SI=;
        b=nFUEtNKgVW8LOQopJ61kmdYaTlowIUzKAJtcaIe1lJAtOLkKaAC570v+nNs6bH0jad
         BWsV2YAYJPzjpmGqXSRsCWVQ1J513NY9dkr5Nd2B6iqZkCauuHpdJt6Thj62FFoapfQc
         +wVrtOrXnGb2blaOvLt+zWIz1Pz2xppTmBmq8kR7uWiEovBZwcS/RoaDCvXgKNH51R+5
         Vg+YuO3HgDBDBHiaY+TaPdXIyotU5Rlj66h+RTPOuLG4ELEgzwryb/MnPLpxyKrSfjfG
         3UFCoa5CUArNR+swZe0LJ0gZUfvfFIjlpm/nqmzL6jdT7DtLJGg0xk+Wm1poymsEZKBI
         CBXg==
X-Forwarded-Encrypted: i=1; AFNElJ8V5pS6DvI4vIsUVd2s4Yvg/hsBWTm9hxYTVzVHeysTxJGIfPj4hM18/O6d0OXAp5pOJNk8VA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwiiahtU/bDh7Oi0pXpgojsnJA7NbabWchT62eG6RxRTfDuGLtz
	SnDqeJxdX3hYPXmXkTaHhKhWyiwPn3qFebO0OAR2dXYF3S41xRSPVBGEi5ukWFVDSb2qdn7K9eT
	FblI4/oRi8w2U2lssHSk5nLqOIgeBovMccaTw/jEVSJSQ+An4OKernRHyPw==
X-Gm-Gg: Acq92OGEAKaojogGhMYGi2o0xzOAnXtA+JJh5Uauqmtk5jlk7XrAvjijo/1WStsGkz5
	fFBx4E6Eo67sNgd5ZN7fQ9rUOYhqXfNPTRpfrULGrzjhHbFCzX4xHHzp8OejDpyvqeDhVZUJSLP
	lBxfDSDoyS4FuuImlyJJmNdjB8ZFNNvKEpwLUTXOMEBrdJIF3J06O1KHlIEfoH5Z26u6YaeXrwn
	9Zi6I9SFHQV0CWJR3F5EqSPR0ZnylJzo/TUL9FNsUa4K5FPyWS2k/ACdtGophLY8Qa07KB7a2kv
	PuqtXVFpccfjSHQVgTK6VE4TDPgRm87mzu+Pogs+BqiqZMUxVxE1t5SXCxxLw8xMr/V3xSO+f3+
	87ObtVLwNNwqjlf2VtE2x7bhManF68QSXV9sVTZ0ST9UV6kK/OA4=
X-Received: by 2002:a05:622a:4a8b:b0:50d:7f66:dca with SMTP id d75a77b69052e-516c559259cmr24616451cf.33.1779352669691;
        Thu, 21 May 2026 01:37:49 -0700 (PDT)
X-Received: by 2002:a05:622a:4a8b:b0:50d:7f66:dca with SMTP id d75a77b69052e-516c559259cmr24615921cf.33.1779352669133;
        Thu, 21 May 2026 01:37:49 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903caede9fsm10502405e9.14.2026.05.21.01.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:37:48 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:36:37 +0200
Subject: [PATCH 14/23] pmdomain: imx: use platform_device_set_of_node()
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-pdev-fwnode-ref-v1-14-88c324a1b8d2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=965;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=1m0AW2cExEyKezaoaqpg9M8Sd9W7xIah4eoQaNoNaio=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDsQpYiqSx3VXdqiHIpIBUXjGa5jIwrjLGwoyq
 Gc54yDrEJyJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCag7EKQAKCRAFnS7L/zaE
 w87wD/4ovbkfGrByBExY1MPjO+ImreTVfGSAkWmqsKw88uLrhkyEKGHDAQSZTZE3i+FHGY/E2yW
 vuQTwIIwn0C7jebh/ZrW5OyqlKI4SfaTV8SUVza9v/w9itsoAjqdwFfTCAYtkNU0wl3z6zPIVZW
 eC5a4J3DiTbAuwujwfo0CkVMKKHGy6dNnhLhd3c5wk59h91vvRJDexswgzczEKYHYVvQ5PwEm4e
 1v1iYFCMc+jXWVLyMZMWL3qxn2LKbLI3uzw2KaE5pLc6qjG7WxuULz1fW5kc1tPHEt2UjXdtXoB
 Bu7Z+OiX94cgaD4jcN5Qf59TAYUWoTBWptl6Az7wCYIDSl4Zd4dfb/jPCgTBcEaoQMRxdT7wBp6
 04C+yAy6ZZFgQPV6NKQYtrhr10zYyMFhXjVosvUBV+a6Ji0EiFri1X1eKbRIDWPoxE/pW/NgzA2
 EIK/OJH+xDImj3AWv689ACL46miN6U4MXZhQgeeo20WrtwVz6rOsNHISp9VfDNfODARqNyRDH4y
 gYdC059xHRA7PTGRRZGWyRdRrxEDYxRds5O0j5sxjShEOV3/CBXZC7cr7dJk55o60cuiR1C1RSD
 DTE3n/guGYAoDroJBWU9vFEHo/tJTqZkDlWp9VK5ukHDUrBufG9yMNLg0PxfB2qf+8O/s29Yr1k
 PBNeRIDE8C5ssiQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=do/rzVg4 c=1 sm=1 tr=0 ts=6a0ec45e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=J9-S39C9qTGxOfEZqScA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: lUayQw1JvkKBTiJKTD4scxzDHws7nhbk
X-Proofpoint-GUID: lUayQw1JvkKBTiJKTD4scxzDHws7nhbk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MyBTYWx0ZWRfX/+esc3BMjHIv
 8AbejWCULpjTgfG6RQC5jvb6uboz7OPoeiDdsS1XLXqF2PNNOolR41MauxTggp3eJ/ueB5CYmGP
 +v2GDJwxMIgAxpwRPK+o+ShzaeNCcu9L0g/Vv7hYF/Tj8U3CjEUz9OUbUYMqYu58JvRELQHbV13
 BtpDjaiK3zabLzxnpZshCwFiHRBFv7ZdiEba/kjPvbzMw9hKshrxAY2OaWgryCMMda9ECNlOjUY
 1FX1ONqjlnaBo82uEa857gCNYhnYZM8PoJa2pd2YGoIF7XT4SlghzG7p4OuGfyKG0A+fOh9aUwM
 nDYdIcssiJjyn4dxSYT7DXiIgnHvHO48Y669IX//gt/S+tMFUn2JyyTL9EYwVAVDv8b6OXl//Tu
 jK6pBHTZ3cEmBKZ87+JsHw4nn/qWOCV/sfhnwoik1MXaNpZwB+9c0KsuCHtYqEJoKpF1ZbRhhHv
 +YSHSrYZ17Zoj8ZZ3Og==
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

