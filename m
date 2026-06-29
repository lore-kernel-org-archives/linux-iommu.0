Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFB83FD970
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 09:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724398; cv=none; b=u2/8ybQSEWRFHPuhUkr/+NEOZvYZay/mg1/X/LaWOnLQz3NtjEdXZwEuMpJj0uHalQxsAgnE+6DPbcuDVV+VrVd5A+hUyLEL0hvLlfCl4d9BETPfA5Auj73dhvP1JTkKf6cLULx0pIoymKQz55S1ij3rcqwkLz2fM3jvKh4xRHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724398; c=relaxed/simple;
	bh=rrDc1Uz6I2aUdO8G3QZmOKFJZ+6purM4q0mZXEAYeWA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=THJW+yKK2Wfem7pjeSvJgC6hVlLrjxuwxh//HRqc50dObirwRujvG9ZgUZpG5OatKnWKWlgX7Ql7/OmDjPlgk25wcM4FdQ3PsGP3KgBOrkwNr44PJI1bSbOjCndmqF7o8pPWMSfFW84tmNGHUkmxSjdA0K0vtL5+g+zD3+Gx+4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q7A1WH+H; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gQTqVsK/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q7A1WH+H";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gQTqVsK/"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T8xgp02431950
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 09:13:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PdwT8nLR+wGOxQU+flamgY8hJjPj2GWlxWbKLJWAUtg=; b=Q7A1WH+H+84NUDVy
	kDlSuaTfa/vDNHD5W+jKXjedHKuT7ZADHpKjsgJObzl6LiN29woI2/c/EVIdiHaU
	ouvLXuPvm3hTZAu8/3JklErXI9fUWdY2naoBi1dOsLbotNAexxbD2MV3NVu77Rnw
	21Wh4Jn+7IES2oRaZoPE4PJz5LXB6ILiYL4Fey3A5DQpRenp+HGt/ConT4BsdQWB
	llBJ9IhMym+GtD1Nw11ufljxY8VJnPyUYPDIONZKGAY1apG6hCEzgWm3W+bTqUEg
	RENXcrOuCvXQer3CV2t2j0K/EmdrtXA4lvG6UReSzTVy+hgcBEp+vs4Q3QujJTs7
	PDaHFQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nper219-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 09:13:15 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e5e38fbc5so10366485a.2
        for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 02:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782724394; x=1783329194; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PdwT8nLR+wGOxQU+flamgY8hJjPj2GWlxWbKLJWAUtg=;
        b=gQTqVsK/POF4LIJEywCnJXOkdkBYcH80AQf38XPw1hSAuVA7SVxITROealUDwO6hfs
         vxyfjBW4oG5B2xpVnIaguqanOGouXNoao0meX05NxVknIc1q+pf4Wkab1XkcOWtQXrOO
         2X13i5mLobE9sy2XiwmSsiYahSe6OqPyC0wyrjNXwWgKonl1+c/aFZYEtENXIakMDItv
         QLqKmPpEK+Wqm55UOPoIU4uSTVjFzr9W3IGRxnf1dbKjQn2o+ynLKA6wOGRMMnmgkDxo
         jFlqJJty4I1JyMG6RnExHCvwCoyn/qkfT3UizdQzqBsQoYVCR1bMPv+n0LTyg913X4w+
         bb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782724394; x=1783329194;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PdwT8nLR+wGOxQU+flamgY8hJjPj2GWlxWbKLJWAUtg=;
        b=JBhervl5NM/vF9mDjWIWq0nWKbiIqXp/CgfuaBByhogiw+vOkRZ3aNMUh96Q0t4KGV
         amYLX843i3rsom4Kcr6LPYneuGRHBbIpn5XdGwSSG7M9y2cujpiN78GeNOkR0Raebwa6
         PxviIAotkhk9oLP5mhcgin9sGY5cTnskuWZclyUeF4yQusksOh9ZMI5VmcQftq7hWIct
         teYKXy1mRzm3k9Bz8ENLs9u8lBzTe1HQRDrK2MdXtZtD0S2NHN5EtLN5ZOP5jvQt/c8N
         P4NBTBe3DVBCkrErmVstjGqAls5LH8bfR+uJMOnqEPBpZN7eQYTutlybeQYLT5IYpATw
         EeyA==
X-Forwarded-Encrypted: i=1; AFNElJ+PhswsqLicAJLJPUNeAUW/+0DRvL61WVV8JpxQfzEpu4A4r1AyWGcX4gG1m7AnPUCupOt16A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/0EZDRjw0bM3m1/9MiFqDGgYrCGf++duk19Zn/hVHd94UVuvj
	cykAbrYdk0akYCOCzGYFVNxjrOTThjnCh9yx5ls4u8qgnjFlvg5SIz/u6Oae2K82O5C/5RKiKfE
	QoWCNtFUIR/y7KTLrug8Wt3lw+Se6iNI6VqkMHUsa44YNSnD8IYXv9/Znhw==
X-Gm-Gg: AfdE7clhY5HjhpX9oKDkWOuxhWDPHkD3E1BvlsUqxO9VnPgyqcgKaj2z8SvitMcQarR
	KpSqNZB2HAvSK/xtvw3uUriItKlYf3KGy/BI6MrZAj08WT11ehTEsMF6711Ckjht9wH9lxf5tAy
	Jm4dHp4p0u8vA9x2kUZsoYemKlw7YtTEFJnRvCQK5o1A6dY6KPSe84rwV9CVxhKqDeU4jXF4QkL
	7d6m7m68cyhFfK/WJr04zhyP5WuKlzP/VoNVch+OZ/oh20eirNes0rT/fzw0PS3fFREuUEEL7KP
	MxIHyOX1VKd26/7xjhk7htjuY3NE/LqDBq1Y7y+VG+C+FteYCBjlJQr/ep3CxrTo3eN8vN3rXlS
	1kUuHdpgBVlc7yuF/aUrTeZHEqx2pf6d3vswRacdX
X-Received: by 2002:a05:620a:2591:b0:927:59bf:46ca with SMTP id af79cd13be357-9293cdca63cmr2440340985a.40.1782724394292;
        Mon, 29 Jun 2026 02:13:14 -0700 (PDT)
X-Received: by 2002:a05:620a:2591:b0:927:59bf:46ca with SMTP id af79cd13be357-9293cdca63cmr2440337085a.40.1782724393838;
        Mon, 29 Jun 2026 02:13:13 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-470f55acda0sm20109240f8f.23.2026.06.29.02.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:13:12 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 11:12:28 +0200
Subject: [PATCH v2 05/19] of: platform: use platform_device_set_of_node()
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-pdev-fwnode-ref-v2-5-8abe2513f96e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=924;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=rrDc1Uz6I2aUdO8G3QZmOKFJZ+6purM4q0mZXEAYeWA=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQjcLD++JnQrIX2VzO+dYdToOeDwQeKJ2LBgA2
 f41r81v332JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakI3CwAKCRAFnS7L/zaE
 w2WfD/wPpjTQ5122QbfNMJ1ncEqmky0pkCQKc8KgH16BI/YYrf6YCDYbVXp4OOhlfZ+AA0amozc
 YlbIHZr8yW/8Ww61zaZ/f24+kXP5qnHaraGtL08YSswqy+bgiy6DYHDY5qUo73sVcHKO5sUkyJd
 VNvTzMspkd/CSHW9IobLoZY+2kWm8E31AIOO/hfDyyS3EQifk8vhfUoNuOK4JQ+Udl2MocgNcXK
 gyJcW5wP7/teYAL5yUwNwHOW2goa4bkxNwYhDjV1m2ha5HM7wBmjMo4nxKPRhHknE26NmoUY/3V
 MVt/rrRKu9cMEw0bVUAg5LpMWATwm6DGIvMMdyUGdCYJ3FOdpR2oNyAPt7c1w6VQ9hw+yemoMsB
 GM0rf3wL6NxEZ2U3n2TMFLsq04TUPNcmqkCPxGoNBe4WDfEoJQOjWTqr6QhpKRhjanbvLUCLhnG
 C24dqO1si0SdYnqmqfdJAtp2HtSOy3jb3n0S4scELZMX/cUKTCUyKAyESPlXE12RQk4Y4kjHrQF
 klKXae+vS4MilI8Hxo1/p0tl31WhBiLnQx0NO9E8f895BW3R7CYmGU7OAlRsZlXZaJb6J2MAl/p
 N3t1e8+eIs5bngjp6talt1GoO0x1cZpCIGKELGViK+k99s1krS/BpZ+cZiesq+H5lGbn7cCw0vr
 wkNrdcAeGiShgow==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfXyl4iT5CYDVe+
 92NgX1zPyRs5eeotWwZBd1QFZuz5owx4HSDHb2+Or7hdZwtmBDuaOwQWQTpI04lakcgnUzCQxet
 WpNQeLguXpZ1/S8b5XxcI7jNIsZrMhogEyDAVNCS3vboqHXAiqQphJzwvnqx5HnMs/KSeiWrFTv
 MmYP98El5NFWl4ezd2ZrDlkCPdMCRv2gZTXS+VFOPlsS4+TBmL4CtXDdkkkvyInhteiGHmrt8BF
 KLtchs0+A/SJ25AKCkkCWYTLulyt701htIymTFDF2TlBMyQtq/MzmOfM7NYh1O1lpZLYSNEURON
 kWMPJ0vXc/nHSn12DUh7QbJS9YelZ5yh4Dnglomi78zeGKe22D13O0BmIzT+ahVleY9mT71V1bz
 NgEXUDFMgRAjuLvDB+feBNfGPtmZ+l1QJLlB7b/PrTumXaxGCVnxIgAV+uGU8gyr1GB5etAiN6z
 BnngcD051oQEk4N//7A==
X-Proofpoint-ORIG-GUID: oBX-nxOVWpcTC8bOcqdefcI8wA9eVEEV
X-Authority-Analysis: v=2.4 cv=T6q8ifKQ c=1 sm=1 tr=0 ts=6a42372b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Jb7EFCjKRuSTjX4XlnwA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX1ONVCEaRiBIn
 8azTGO1433yCC8MOJaeHy6nOIxylpBcO5ckkOsssbEmKMrHkXEzjsumO8WQN3gqGtQspcS49nNS
 7eXuOxV/q8xwCSF2iV3FxHZ9s2iujWU=
X-Proofpoint-GUID: oBX-nxOVWpcTC8bOcqdefcI8wA9eVEEV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290074

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/of/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 53bca8c6f7810ce2235b4d084a361626b1d2da33..8b1e7640778253492c080085b4015e1423389d83 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -126,7 +126,7 @@ struct platform_device *of_device_alloc(struct device_node *np,
 	}
 
 	/* setup generic device info */
-	device_set_node(&dev->dev, of_fwnode_handle(of_node_get(np)));
+	platform_device_set_of_node(dev, np);
 	dev->dev.parent = parent ? : &platform_bus;
 
 	if (bus_id)

-- 
2.47.3

