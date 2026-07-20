Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C7F3D331E
	for <iommu@lists.linux.dev>; Mon, 20 Jul 2026 09:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784539559; cv=none; b=GfVKkVxt1NXwoHk1JIIiWEhIyJs+0jWivWKGIdXNxZCIMHcjkqh5TCXFdBJtzirPF05axzOAA/SkSu77BvuK2cT3lJxyFyo7Atffws3QFmYTq2GRia36YpVGjb7BjBl7wmo/c5lzdalrDaKWkh49Vhl32OQ/R2clOoBMse90Hu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784539559; c=relaxed/simple;
	bh=xqsPX1hXJ5p8S4DkE8vtCmD8bNryEUzUedAtz3x4vb8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nslmq1JKp1cXiFvszy3x1xQVLyZQ9qxOp99u40JKK14ORk0ufjJSkm6vL5gSTeHjk57yBiSi+Ryv/o//AZtt2QtR60hfe0vg4cy4RWfAdkYG93W7xMTNmqbk86ZxXKK3ttD0E09D0Peavgl+9yM4YnhAcFsi6HNO1/P0eK7cxO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KlqIfYj2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZuGh/LsU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KlqIfYj2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZuGh/LsU"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K7rf272979892
	for <iommu@lists.linux.dev>; Mon, 20 Jul 2026 09:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1C15lnSQu9nB/PyhjrNzGtTe7xWsSDZpgOoprGffw2I=; b=KlqIfYj24yaFf79w
	7Rebwfq6wOB8LJIJfcOSwVzj8iaykOD+BlPcDZSb0cBdWQ/OJ8g/3RUKCH8I84dF
	bTklcwnNbIC8LgFDvh2Zd41sQa4Z4qY1zfhH5zztNgAHUzbG2j33ECwyTCj4sYeg
	2LdXdFfBk8SiLKdVSnwAmEnDPSHtSk4ZVYbojPcQcNWXIcZypczqSyWi9G+LaMkX
	aZkg1tjB1QO21JwFUq0BmbAHIvd8q/a4xCzpwESVMJTdxYAw7vYZo0Rqn+oMRnt6
	2a0leS5KgupFo3792wHUl9yNhKjib47ri1ajCPMMrb4qrUNfn4M+W+Y9eJkYXbyl
	lfcfHQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhfpg0era-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 20 Jul 2026 09:25:50 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c0199faafso144483871cf.3
        for <iommu@lists.linux.dev>; Mon, 20 Jul 2026 02:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784539550; x=1785144350; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1C15lnSQu9nB/PyhjrNzGtTe7xWsSDZpgOoprGffw2I=;
        b=ZuGh/LsUaTC0TtGIbHo35NKppOfmXzIuwvrx1yVnTajj4Mu/L5Udz5morxtQXss1l0
         guyuooiYSEGz8Idd1NzpdK8EYX34OEI2rdj0z9KmDoBsQ/gn0Xn3AD5dksldafVyKvIH
         FTB1XhS9rklxrLwZv7LszZL2AGXtbqBc4dm40haLUo6jMnDa4/0K7P/7sopd/4OJKcDg
         6rxVP/sQxTeW2kXYxlNl/J0vVsJOhKBCuiAuR1o3bor7ajrMCBtpdC+2mNkSthGCx+9h
         681s9m/AWSZkQuI6Ue9Esb4Nhk66JnxNHxYqCVHlabK7Ky/aotvTPBZ0SrMmXQYR3sXw
         7r7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784539550; x=1785144350;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1C15lnSQu9nB/PyhjrNzGtTe7xWsSDZpgOoprGffw2I=;
        b=nmrPimmE1qen1Fdl5jN/1jV7PHtvl1Ux03F+GRl+K98WW2CyYg7zPogSIFPJqRKN2y
         E55Y5VFbblVrfLZSQgek5zWZHHGvdo2IOk1J71HftYZValjmOC8MknEWEx3Sx5n742tq
         xH7fdmPUFnHrvODk56+0ufVg3J+FBsyDPmxPMi9EYlogs2eyVHb5vvVdrN9fdUEVwDYX
         Aq0czdBAGnmPVe9FKOKQY+V6kbl1nG0jovjxe2//iTgnhBHhOBc+w9uJ5lpMfpranZ8Y
         /xDm2wZlF8qSOTC5gxe7fdlAAlT6jUQfQOx8jt+uqoaf5+38D9DJi4nXTirfuEtjpmPL
         aJZA==
X-Forwarded-Encrypted: i=1; AHgh+RoYbnhRmvaY90nljE0xyWf6d+FBJLOppPojJEb/qc0Wc8QKr3kR4bpLLPkmTFl68ZUsIFQHMw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwdZi6brGMX2wxiw08SK3PTm6pSrhwOaqFWWGrBywAFEP+AZYaa
	FB2Hl1ZYHkmXKQVLhjUEfu/6lk05zB809sfJioM7DS2KZUzgqxbulb4t7bLzP03gn88LtB75Dbb
	UQ8O7/Z5faaiHiBTnbqjBgn2/C39nNF3KEQWfYRFZVXl/tCNX8OuDac6pSQ==
X-Gm-Gg: AfdE7cmdq1A+DNDRgJwIrdLqIoDWOm4YAeVFnefaZD7Fzs52XeH5Gl1HJ6LnTnDy79F
	b8e6fAk3yeTUluBj7AKoN+Q0DaaoAgEk5Sc/8jUY2zA6gkRTZ3NUZA99p6pXZPHbDSivo5TXtBn
	fmTV70XsVku3cKpojB8d36x4ha7Xxvp0sPEl1/rHvVe5St0p2HxFpovMIfCizUuVLhm+UURnEKn
	KR+ozrzlpAXVJcAQ47COG3FZQvvn4XTu8DyMGkI9rD4lLvrJDxNUvgh2XwJiOmcBxWT6h9CDYqA
	285mbtXRsiD1M5T7QJYoerOA6OzWjVqWBSO5HAcaEbiDVKK0ZpP6vSElul1sqzJAWI1Ry7waT/i
	6JtgxZx0Lr9rbbxibMFuMTl57XnYppA==
X-Received: by 2002:ac8:7fd5:0:b0:51c:22c5:daf8 with SMTP id d75a77b69052e-5213e886569mr118276971cf.59.1784539549678;
        Mon, 20 Jul 2026 02:25:49 -0700 (PDT)
X-Received: by 2002:ac8:7fd5:0:b0:51c:22c5:daf8 with SMTP id d75a77b69052e-5213e886569mr118276431cf.59.1784539549156;
        Mon, 20 Jul 2026 02:25:49 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:65fa:60cb:c205:d511])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4955de88951sm62228205e9.3.2026.07.20.02.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 02:25:48 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 11:24:54 +0200
Subject: [PATCH 7/8] net: mv643xx: use platform_device_set_fwnode()
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-pdev-set-fwnode-instead-of-of-node-v1-7-2dee93f42c54@oss.qualcomm.com>
References: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
In-Reply-To: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Ulf Hansson <ulfh@kernel.org>,
        Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Lee Jones <lee@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Srinivas Kandagatla <srini@kernel.org>
Cc: brgl@kernel.org, driver-core@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, iommu@lists.linux.dev,
        netdev@vger.kernel.org, linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, mfd@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=995;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=xqsPX1hXJ5p8S4DkE8vtCmD8bNryEUzUedAtz3x4vb8=;
 b=kA0DAAoBBZ0uy/82hMMByyZiAGpd6X+h/ifYFhQyBjNRAMZp3sKfs2dOQQAGWOSJWeEWTFT5/
 okCMwQAAQoAHRYhBJHlEy3ltUYde6Jl/AWdLsv/NoTDBQJqXel/AAoJEAWdLsv/NoTDaPwP/RCK
 7Pwxf8vZOh5uaFiaUylNW9sFBv0DTkc12XbVDBYvSH/UfZrhZNMpdObQiVZ0SMsBjpcFYp/1AZB
 bv/F5eIASG2zBoN057E5VLLCsx82l6r/JbeVQgw5sCPYBDfaFMn5uPaQXGHdfCtVzj107jr0atg
 MpQOTuIilyBFr3uTKuOU7pU31UrvyYd/WaJ9iIF6yscrWH/v4Qs1NgyuD5SXNzXQy3CdXMuZWPw
 OfBtGBf6WPhpJYK8SJ8cxHXNTC3mp02VZHt8QJoXG+UcIywc7z9x2aIXBI2wqX000BykBPNlSWC
 mY3n3CcQ2YJPZstI6l/D5a5Ag1tvZyjFn23kZX27b2b+0vfEWAo3XxJs4LD96b8ru1CihZM4DNr
 J7ePsCpJxshz8tCUh/g8vlubXLhRCQuMOCve6JfkiVWeFuCbbrtw/uB+qI4BX6ItSyElc3Pkd9A
 zqucZ40Ol3KJyC0Hpqxv0yAHDnt73BHlxnotHkeJUkco+UU572qEZp2P/tHBng23kf7VdgJKzfM
 0Vmj+kL6FAYBqwOZUqDULhVWTcaepaa6iM5W9ZkRvjLWWBLCdYGzVZKBmU+3X/B1u1vnRuKOPdc
 vNkkEAD4/hll03aBOJFx5J4KIfwjuuLHfYesAeoCPVMULek6L0iDo1ICKKxFU2N/ZGUpG50fB24
 46Qsg
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEwNCBTYWx0ZWRfX9z78exa6O1SX
 CyD7MUKRiGcHLgK8T7y/BODrWBEkGFM638g5SMdY41G/W6T5euiytpIXl2tX36SsFB6aS7/qEcH
 Q2xm+BMCWqqSwaM5tIVzNnfYFoCK9bM=
X-Proofpoint-GUID: mx943caW0UZySCqbh_7oiNBI5kp9Ph3z
X-Proofpoint-ORIG-GUID: mx943caW0UZySCqbh_7oiNBI5kp9Ph3z
X-Authority-Analysis: v=2.4 cv=c+6bhx9l c=1 sm=1 tr=0 ts=6a5de99e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=Ue-CkOehRSWfgkZZKZIA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEwNCBTYWx0ZWRfXxZUH/jMFQsbm
 nibVEd3xX2iyUBlFwg8rLFXIvQ+9kEZn6KqL1xCI5lLsdGtahS1ZQ+hW+ZJaF2z+xDS9gsyOKAG
 SZ7067g72vtJ+rm3RTYiuZ2JvVl1bWHpBcQOL+RmBBaPkblRNdD//pi8QKjSqQ0DU0IUBteNj/q
 2SCnJpNqPgIi/NZ28bAxFylwVuox94DA4Qo7WM1smUQb3+uvtXoaRzst9bzltGurCkJGUpSzWs8
 MvKEPKZtOWqZeP3YOa8fkLFH3lEMrB0uPShapfEjZm2YFxfIfszEoSWCPLTTtsi3J8pspdD0lH/
 c/r8cRQHnMM+hqr693W8A78nQKPAoCvcewhlmFQxyW7IIUeq9Zz4SdbVUqrkuCtGk7unfiJRFVS
 Y7j7/10OSjyk6FeM1Zzpce4Qdj1AFHMfkCX3Fu7F+sDXVTMMSLe95f7Bn5kKHt0LK8Gih7SKZOJ
 7xsIlvquwmKXjJAvwKg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200104

Prefer the higher-level platform_device_set_fwnode() over the
OF-specific platform_device_set_of_node() for dynamically allocated
platform devices.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/net/ethernet/marvell/mv643xx_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index 9caa1e47c174c9d7a161b7f2e2ee12a829b813d4..2f2d6cce8d852b9ec3ab42678a04a7915d1f00cc 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2780,7 +2780,7 @@ static int mv643xx_eth_shared_of_add_port(struct platform_device *pdev,
 		goto put_err;
 	}
 	ppdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
-	platform_device_set_of_node(ppdev, pnp);
+	platform_device_set_fwnode(ppdev, of_fwnode_handle(pnp));
 
 	ret = platform_device_add_resources(ppdev, &res, 1);
 	if (ret)

-- 
2.47.3

