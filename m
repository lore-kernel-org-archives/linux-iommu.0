Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC3C4048A8
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 09:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724422; cv=none; b=uDF9yEZzg2Jy7xfnQsXOdfRBqQSap+7iOyCHdy5uM/Wjlo8cZ+C7uK/OmbfyW6/B1vb5gJp7WGuOTu7sxUuyHrFERfcWlxqkNuslo/Nd0uAXtjvZVlXe1dhkbqCrvyxPs2hCZ4cIDu7C+/JXlkumlLxOCkiAyUh+yJfsZyfOSFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724422; c=relaxed/simple;
	bh=+Q36/R3+axSk26qNg0RKgcggtmrfBcF0QjetixEKu48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dpjS3i4tEme+P2uPl7OwFwza4GCyqqPMH/ER1QJ7TaOUK7BI87RQA7XSyitthQ4+cZg2jtzVLu68S8eCIRCyJwZqOazXQbMMIkTjo9kb80F5mvMPydDd6nKZxhI7z08xeOhJKngwKVnkzb9vEyI0bwEYJB7zYYVZOmg8JQn34i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TJV4dgAM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gP3o0XBs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TJV4dgAM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gP3o0XBs"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T8O9Mi2348351
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 09:13:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EbIXrTuuG3XY7IQyzDipBNefbhJbG5vwiEUXw5AorV0=; b=TJV4dgAMWU/+8Fge
	LhekPmtkirGo2G1WGvWAssawORz+6M0mrlwHcIibOxpoZCVMq+2L7WT6vrJ9+1et
	EP8eV2W8OJx5qateDGni14/OqBOYH7A86vpDd5IN6J3SRx9H1H2Ka4oiJotKHAPq
	UHeT1r9ZDTLYFb8KRJjvJEQ3OOpHEJF4nQGXqoQ/kB6S4SqDPjL79pjN778T4gLz
	s2qvP9JtSlDZ/h4hSLUHXvMk1gOmOOrn5XCfm5kFQ5zhYJx8JhGoEVAAupN+uhcK
	xk6Zt9kFHNw+DCE5JAV4bCQIY3aH7alIM6f4eZ45FgXVRRBjfW08arsQJIKjxk5l
	5HftKA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3n5s07f4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 09:13:40 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e5766dcb9so62612885a.3
        for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 02:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782724419; x=1783329219; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EbIXrTuuG3XY7IQyzDipBNefbhJbG5vwiEUXw5AorV0=;
        b=gP3o0XBsuK83wEnLSG1JNPEIIrFTk2uAC2yc1A8CNUXCteuU0SFPTgeR7xiEfUOgww
         tvppEjTSLzU8QXRD9pLTNOFGjkrxCy4Y2m9uBvFAAR17coutRoJs54tEFm+3oGMe9j6S
         SgIAtN+ZtyRo7+OVxN2o+fd7KifYPSFEltjYaHHaW+m+OfVcgd1hOKDieFuyydPoEw/+
         580lLEXIlWszvHmVcLyBSQFyXm5Wf+l2BBLBOCiP5I5T4WsMFfEiuiQzL2Zo6y/0Dmn6
         hFD1OnCNmbNmrLASC2bxamBxpK8OgSg14JvdE1s3TabYMyKLPGA7uNbINDIklUGNO8Sv
         akbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782724419; x=1783329219;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EbIXrTuuG3XY7IQyzDipBNefbhJbG5vwiEUXw5AorV0=;
        b=BqrH9HI29LeQS3vKTmDVwyidwtSL4s6fjcoA+OgpVx7k/ZbENNwQ7o7Am1hHLjJ6Qm
         aRc1fRQMj9/s/4qz0C81Cp1RGITevtEJ/sTU5KDwkOMcLsy3eoo2lvlK2VxWzrT+qIbT
         6X5YVkG5KosthHB1h5/2h1tUfCUKwkInV24bbpfdflkWHZtqm/kebT31PQYtdkZQQeig
         xj91sbBts4PM65oGJmyGDjD2rAHrc6H1xGytiFKtjowYmspPFKn+ramEC/gQp32UD56t
         3WV8JwLm8bMTQfpRw61Ki1SyWnPttKO7ASkypZEvCChGWpoikEDSbukF6aa4CfBPbK4u
         D47A==
X-Forwarded-Encrypted: i=1; AFNElJ9YE+70gDAkP/5WOOV29vQqjHMFjci/pV8m6BuSKCqMf6G+S9q8b+ceeGXv5+Bhu/a6MUR55g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwPhMIpOnR7ZfOAtRFoA4EL5L8ULLtoXiUoo1ipbGwZj0k015p/
	prvaoKJWVZtbOPM+DOYQfU2AeVs7wDqrTcUPUpl1RRptqUeLVAVseqk4c8HeF9kw/plk0ge1hA4
	SUiXIcYSOZdUb209MaUYvXlQmlc2rHfZkpqneMm5XdbXPpXAp+9RFkVkK5w==
X-Gm-Gg: AfdE7ckt6RMezARg9oJRMNMJyefcgRkLAFNsJOsdyQAR9YH8Yzfct8x7b7o3xBahGB1
	IqjgsfCrcwK+2kihci6lj9YBU4k9hQMWxlJqz7/VucyP7GaXeL1SPJL3TQ5O//yLtwVsT0EyLLi
	8HD/lR/OsWQDqG1/E8dQYt6o9SJ/iiQ0Bjn5odRu9BdSDxxy8LbKMhDJ3GSBY37cegABNLRzJLv
	ZxyyvmA/tVIGn6tIC45PFZ3ncpOijjIT0u15cpDdyxP6ETgtAgGXW6bnH3MmRyYyWcbZ/R8s8+q
	JWkXxa8ZF3jdyfRJeA1CiUWLpRpjfOleWXgGPM6BSjBfDVYjWnbOALmBdHXxTwlTiPfV5kBnySX
	cSxe7JcwQOroRM+diL5FsQhNGAMMTfk0c0xu1Lz0c
X-Received: by 2002:a05:620a:880c:b0:92e:5444:9274 with SMTP id af79cd13be357-92e54449803mr246442385a.30.1782724419016;
        Mon, 29 Jun 2026 02:13:39 -0700 (PDT)
X-Received: by 2002:a05:620a:880c:b0:92e:5444:9274 with SMTP id af79cd13be357-92e54449803mr246436685a.30.1782724418509;
        Mon, 29 Jun 2026 02:13:38 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-470f55acda0sm20109240f8f.23.2026.06.29.02.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:13:37 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 11:12:36 +0200
Subject: [PATCH v2 13/19] net: mv643xx: use platform_device_set_of_node()
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-pdev-fwnode-ref-v2-13-8abe2513f96e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1009;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=+Q36/R3+axSk26qNg0RKgcggtmrfBcF0QjetixEKu48=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQjcS4h2j1YriB7udV3KPdGB1WgZYJtyXF3EwY
 kWYyj6tBQOJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakI3EgAKCRAFnS7L/zaE
 w4OMEACpb+VV0xnCo9JBstslWcFSexsJONNn93JsC45mbPVtpAmKkjbrIEiewVFro99EPr3WYy1
 qgyQx0sGC5N8MjJ416HOMzRJxcjEIzd1oDsayga3Hm5jHr3aPET6ovOL2D8pPxKjEWcqcAVrZvK
 sxr4xUzdhk0cBmeaI05gXB2y/pbRlPvE8rcWRYyss8ohjJPNNnVQcjxZUSorQq16LSOFp5CGHPu
 EYwMXOaY7DoYklLTUUSFnqS46yyTgmmlNf7GYefxWF76TS2QcYDOcONjbhH+cs33Alsh6WdkAhI
 1K5Et3oS4k+uV8IeF/MJP+031ZUNWKaS0LSCqyXyYU8d9D6pA1XfEJMd+MrHJalMen+AoRuciDO
 JodmffqqSe8Ht3GT2UM1iwvhKz4qrca+6jtr7gVmieZA9R4w8XoFLLCHP8A1JagcJovYVca3af6
 hJWsCx4YQCUOk15HJeq1vMOPGj1iTQE7ynFI9+KPaPZiW54aTa7nl2ImLTSZGW4d3BWeU7MoWnH
 Qn0jHvQeWz9yhbmxxL7RbsInTMhP0hCO4CsGeuoX+JXUEshiZbxUWBo4YK/bz49AfsewLMLFERh
 N6DyGeSUtUzgNCVW6knWh/9+tzdIqic3hzgHEIXxCBODPiU/grBsnpnpOqfS4ToKqOS91Tkjrms
 2/CqPYQ9mTIKGDw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX2rGXb4iThLJr
 x5bbeqAZS4QMdsuURYGR/cVbHJ93d5Q3sY98csQNGEGzaViKXpVqFNeECTCOcHirCob7SPZDsuH
 EP4dFz6riXV/xAOsiqNZQGxXkSRb0OI=
X-Proofpoint-ORIG-GUID: UUIHga6yxGTJZen5EyODYDYE-o9KbfST
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfXyfAL+xQyjcto
 Zd4G21K8nhLF6UmQU3SW3DJo28FsNxar8wOnncNN2gRU/Aj2grAzgdl5ZPM+l2UmwO15OT/pW44
 IeTLXwPWRdtoLnUkBl7SBjK/CtM9oM7zIA4iM9ndxdiNDZpy2VJhC0i12dU3OnRNrUKvUqOGKVT
 hsQma+NliN82NGeq5cvfWQC6oupsDLqCTLFvYtaTXs5fZH1pd6TGextEYfeOke2RKzXVqt2Abgx
 LXS+1Nt2DcIt7Jo+hdUsXFl6NP0udNFDrtEydkEVXJZJKLEVcSpfWHyF1V33EoXDgN2qxC88OaW
 C2Cm/CbMCefvXQBEpBfDmuGHDxlLPwmyHR9gFTqMQSi/R1tPCj6PMxPHfvnTBKqv3vXkZxmh17p
 EQGuq6pwuLlpKsGIB4OraLM+0thB7iBzeirXRor2oRCbMM2lBrnxz0IEGyQMFLephW+FUjWC2m8
 PAIzbTNVGyj9NKcWRPA==
X-Authority-Analysis: v=2.4 cv=NZzWEWD4 c=1 sm=1 tr=0 ts=6a423744 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=deS-VIKRvcGxR6069T0A:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: UUIHga6yxGTJZen5EyODYDYE-o9KbfST
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290074

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/net/ethernet/marvell/mv643xx_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index 1881583be5ce2e972fceb14c2b8348280c49ad1d..9caa1e47c174c9d7a161b7f2e2ee12a829b813d4 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2780,7 +2780,7 @@ static int mv643xx_eth_shared_of_add_port(struct platform_device *pdev,
 		goto put_err;
 	}
 	ppdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
-	ppdev->dev.of_node = of_node_get(pnp);
+	platform_device_set_of_node(ppdev, pnp);
 
 	ret = platform_device_add_resources(ppdev, &res, 1);
 	if (ret)

-- 
2.47.3

