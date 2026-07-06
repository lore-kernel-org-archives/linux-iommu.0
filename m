Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5560943C7D2
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 12:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341905; cv=none; b=Xm7JJUGqHZ5rwF1+fEFk1ptYm/hhQrwENTllTMnqX0b87nxmITJB85BlZqUU8+iRx4tQUPbnj9CbOz4J3WarXpeizgpQP8mYTA71vruc1lFOJn7WsNWDn6Zy4Lwnav+DxXTSUvbNjdXSFqJhibalnIutpZ9S933iZd47mx24ARE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341905; c=relaxed/simple;
	bh=ZvC54swIjtoLdWic7mjkHUk98Z7cygXvR6WiVNV09vM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KpLQ/9W1wk1HgArcCtkH+1MXzwkA6j+qwQyBzc9mc4ZoqOg7+m/akSDd6/RA8IqJc1id/VsF7yYABIWW/3xsS+JfqRfVDy4rUhi/AdCnGgMnnHsq4MshyH73WIyfKPK/JA9KmOyfosXYxLvZO6Pu8j0RCIqbPTtxUss/1uN9aTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jHERcCvS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XauDauaP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jHERcCvS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XauDauaP"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxGIs401639
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 12:44:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9qaZhnJqkpFuXNUQTMvf64DqKP1Gcowxx+UUDue+d/k=; b=jHERcCvSBjEX85+G
	wv+iLnRT6hHpxDdY0dS7R0g8NO+qYXJwcgWGOEQO7ZGvZOxy0Q7dy0Hba2un1PBx
	YmlYOgwY9VTQJpR7MOI1xAGU9FfZOlA+exUr6cSSSKOpYVYiMtNM2Oi81hDyX1lf
	rKokYFp+tnknPpil7j22bPQBqfzVNGQF+MkNqwFAcSDBWFQJvlTIgsN/6YOkjNfB
	2cVS3wfKyk97kCwPoRu+KpyRomaPWnLWCcagvpdzWONQt1gYmYfru2mmiQe7+FzH
	cpGKefaudU3KsN9qiar8tJGKvN6TLHIebow4FloHMH9JoqRDGUV9WltOTCKn9V5d
	TJqHog==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3grkyb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 12:44:57 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e632390d2so561959285a.3
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 05:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783341896; x=1783946696; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9qaZhnJqkpFuXNUQTMvf64DqKP1Gcowxx+UUDue+d/k=;
        b=XauDauaPFFm7WbtxyLX9EM3OVSs2pWYdliJzT9IlHwKrTzzjei6WsKWklJhADzkOqb
         a1iYvxKfksAmKJNgx42DuqlIeGGfTD5yxbS9kuFEHybAdG8tHG2TGfrO2vaD/hFzasf4
         d/RqpifbfiwTa/iUS4PNO4pdDZEd/cMBFvPUwzz6ohrockWHxmY1aCoV157mhIPtzDkN
         geWj1r8pb2ClYYHkNwLkgADLXsnCCqZK6o6vjtIMuh0sGCO2AyGNwI18Z0xNhAp7CsIf
         siYuqFtyJFF9t5rDTzXlVwh/GMVNUXXpigQZHY0QGREDwFrge+EqEWzJo7BFMRtqSvh6
         VMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783341896; x=1783946696;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9qaZhnJqkpFuXNUQTMvf64DqKP1Gcowxx+UUDue+d/k=;
        b=jfzSxuOLgX9LbLwdoBssHe5JwGRi2w2AkqaiehpkVSROtYTnv7suK0U5yXhTAW621n
         tGyOa5xy3WZrtiY7VhApgfoyPgmbTa3VuDeqJyQvVEASXfXLzYHd+lxvyPNgqbFvNDrq
         2sVzmlpBsIAk3gMpQscaATthe6ZvuvLNxUOjTpYamFSa0s3Qi4ghzixAUWgYp2BMssAF
         g7Ac7PSviYp/yMH/CWU4HvTJip7vLsgVj2/ZWWPiHlgWRVKox2PVskI1VAtAQywrGR2h
         jfMJaEAlp99JELDRx5Gmcc3j9FoQFOb2BuRz7/0c8WaALHFslCqt6aOGFq7i2DCwA9ei
         dyJQ==
X-Forwarded-Encrypted: i=1; AHgh+RorZTaMu2X50ujbGo5bubLH5AOPLyp3BMlp2Gp7v/A27VUqNE3ihaKtU3Q+wnChjk0j5or8qw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9vjsBN81DjiYCPvnLXC5ZuFq0dwPeKekPRvf1MeMYaiRGAm5D
	2+cTXOpLb0miZgy9sc8Ruz6gm2HUxk5WeLGP6bxx2NFeNX01+AW1pM9DPply/rKAebr1qEC8MyR
	KL1JrNzvlx4bfTFw0XWz6MSP/MygdPh/0vavprAaHX2Y6XzwMXjjn2reJ0Q==
X-Gm-Gg: AfdE7ck7V62jTAn0g/Nw+Z8gjomdRSk+z9H7XLWBDLQClZ8F7M23hY9Wo0LwG1ogZMW
	BkVLL5UlP49AwBO8f/R3OE0p1+0x5nHHcK2b04bu9D1+S9b6a5ncgmrO3NmsFddpIX28cD10Kzz
	5NtWMStpx/ncWVgy4tk9RdhDOeXLgPieGgFWixAtMr4l8N7Tf/+sswyUQNHB2UhQMb+BIS4JYRi
	Te20X0ixpb1HYxxRSvCSdVshjPrS57AZKvyNAKsPw655yQcvE7hLQcsmwfEZ4dVvjdFCSddUJTR
	nqiMFJmZxmFZVxl2cRrEs7ktnn2pRF+pT1caRZNA3PbcBnstVpEylKRJ3jvUAjZmgf+GA/CmBod
	b1KP60KVu+b9FJtLyaoGlsuKN/eWmBUW9Ftesfcg+
X-Received: by 2002:a05:620a:3710:b0:92e:8f7f:e51c with SMTP id af79cd13be357-92ebb60a590mr47340985a.53.1783341896207;
        Mon, 06 Jul 2026 05:44:56 -0700 (PDT)
X-Received: by 2002:a05:620a:3710:b0:92e:8f7f:e51c with SMTP id af79cd13be357-92ebb60a590mr47336285a.53.1783341895726;
        Mon, 06 Jul 2026 05:44:55 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm22126539f8f.31.2026.07.06.05.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 05:44:54 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:44:14 +0200
Subject: [PATCH v3 02/20] driver core: platform: provide
 platform_device_set_of_node()
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-pdev-fwnode-ref-v3-2-1ff028e33779@oss.qualcomm.com>
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
        Manuel Ebner <manuelebner@mailbox.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2837;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=ZvC54swIjtoLdWic7mjkHUk98Z7cygXvR6WiVNV09vM=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6MvV2oOwm8I6DyBnozXcyFSk9osOc4e2GH4g
 DJh76eJhECJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakujLwAKCRAFnS7L/zaE
 w74pD/0f7wh768Ib4M3VSkBLYD7YQhvFxC2RY+MGZZP+VR1ZlemRCg9DeXdDdSnJSRDL3pft627
 DEvgLCBHwMElpwNSxsMWzEZhXl4R8IEAepNXoxVDXBTaHg3jl8EynFQEcWOeyg6HkMutGn3PMWF
 Wjlt68/Dol/bNnDNzQXKwG4dWAGXaKNln2ReAlzp6+08tymfFK0JoWQ+H+6GPkgzlbEX9CcVawD
 DKACpO8oiyAfEvlpIepcdNMc5lgfc3jv8gQ89TMoB5ERvz+ga96oVvwZQ3Q4ZPthgfz3wAkwDaB
 t8HLs9zAF3hupQ1CpfEox0RQEZDOa40SZwCBoEBN13BQBJ6AroiSGotGwZQQQ9aTWFrgZST4gJD
 SjTeZvyidzE87MxKKYkvxt8NanEKGvWihHCfVtXKt9yMdwr+hSGI96PqwLkOZqj3lOfEjy9zaLz
 Hj7GbbORQ7C6CvDBp8MHQJkkDKHKAE76uGcslbyA89nnGeDQPZQs8bXxFe5imODg7O3XpEA4Bee
 zhvO48lmfv/maHlAUdlg9HdHPPrS7lvHqXMB59rQYQQvr9aCZVoPUC/9+l0ig00xy3Q3MYp2FoT
 xOnkjupxjTDlvOP3c50tvOaWQ5NBcYARj08DrQz6gxBMoL8/9250lNxRls8cpxKP9h/3z02yi9F
 7ilBwmbOytfDmMw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: KpBJJKSwI7v984ekU24BCJcrsyfnW8ES
X-Proofpoint-ORIG-GUID: KpBJJKSwI7v984ekU24BCJcrsyfnW8ES
X-Authority-Analysis: v=2.4 cv=CPYamxrD c=1 sm=1 tr=0 ts=6a4ba349 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=b3CbU_ItAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=Q8RKEeUEMY9O-VPP2I0A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=Rv2g8BkzVjQTVhhssdqe:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfXzwLFoTdgld1e
 G42Fn4WjUWMvRHnwbvfkJnTkPtq4NxfeyK/2nEJ5Rf+LGPUmcuiogWQ92Fnvk+1lcikEWTKwX/i
 1HWirsqPIvtfrtiwKQLArxkBTs7rjof1ytrjErrRMvCZtAWO20kwPuYtkdhpRzg/86TZ5idERv+
 V/4XSt6DtWHIqPl0hx+jMJfRqmqwi8MuifIf+gyEJs4rDOCIGah4FWy5AhHABiZ09ZA05YxSzhA
 NUwCPvz3KcadHRd5EXX+3zF2og4TT3g1HMH0nnbeV1ZSoh49c2rCVFDzgb72QTiAOKPp5ccsXDZ
 5XLQ2QPYv0BIvzN6jXm8zObwx7CwpeEbwiRi/QSj7Dhcsy6BvwCQXOnJryIotZQTKV1YxMgS0PY
 6d7eDnxXLRYu+g0AyYVfHjAo1xLbN5Bcdw2Yd4jxpbgdx/pcGvaKrwD/qKhV3vodXyTK30FKIpz
 Fjg+OQM36uFWeYTPO9w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX19sIkQPO6QNj
 jTt0rvsbsMBQBsooI+iHa8iZeIW80SOtVKs2UvcWwspIsnmEGov8vz60HxtO1SEVL/SQ3AE/ZgY
 c/NCc+CEwjR8OxomBe/eUSPAml0ihZU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060129

Encapsulate the reference counting logic for OF nodes assigned to
platform devices created with platform_device_alloc() in a helper
function. Make the kerneldoc state that this is the proper interface for
assigning OF nodes to dynamically allocated platform devices. This will
allow us to switch to counting the references of the device's firmware
nodes, not only the OF nodes.

Reviewed-by: Manuel Ebner <manuelebner@mailbox.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/platform.c         | 18 ++++++++++++++++++
 include/linux/platform_device.h |  4 ++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index fb9120b0bcfe0e7dd9dfc0d29b91e0ad40a01440..3188d5aba5f90622f821c695049cacda030204fb 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -693,6 +693,24 @@ int platform_device_add_data(struct platform_device *pdev, const void *data,
 }
 EXPORT_SYMBOL_GPL(platform_device_add_data);
 
+/**
+ * platform_device_set_of_node - assign an OF node to device
+ * @pdev: platform device to add the node for
+ * @np: new device node
+ *
+ * Assign an OF node to this platform device. Internally keep track of the
+ * reference count. Devices created with platform_device_alloc() must use this
+ * function instead of assigning the node manually.
+ */
+void platform_device_set_of_node(struct platform_device *pdev,
+				 struct device_node *np)
+{
+	of_node_put(pdev->dev.of_node);
+	pdev->dev.of_node = of_node_get(np);
+	pdev->dev.fwnode = of_fwnode_handle(np);
+}
+EXPORT_SYMBOL_GPL(platform_device_set_of_node);
+
 /**
  * platform_device_add - add a platform device to device hierarchy
  * @pdev: platform device we're adding
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 8c566f09d04efe420d85ffa046f92c44c6d08526..e9f7baceeb4c8269dbc0143c4d8fc9d73ba024ca 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -19,6 +19,8 @@
 struct irq_affinity;
 struct mfd_cell;
 struct property_entry;
+struct platform_device_id;
+struct device_node;
 
 struct platform_device {
 	const char	*name;
@@ -262,6 +264,8 @@ extern int platform_device_add_resources(struct platform_device *pdev,
 					 unsigned int num);
 extern int platform_device_add_data(struct platform_device *pdev,
 				    const void *data, size_t size);
+void platform_device_set_of_node(struct platform_device *pdev,
+				 struct device_node *np);
 extern int platform_device_add(struct platform_device *pdev);
 extern void platform_device_del(struct platform_device *pdev);
 extern void platform_device_put(struct platform_device *pdev);

-- 
2.47.3

