Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5293403AE0
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 09:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724416; cv=none; b=WuhK2zAwvK8Pw3dMRRUxYha8YlT44MDUQEC4qyRXlbO5YlnALhqpPhkoKA+mgjQOQSJpk3Nq50p15wligSXK5PzvZekAzmhzjs4WFRsq4mfxu2S6T64NqsEGa4VSuj+azA1iKg4c5i57OuLa7ts8AiH91cYzhgCDDq/qIAsusEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724416; c=relaxed/simple;
	bh=YiZHp0QI3Ng/8lAx//2O4lFffX7ntR6tJ9zCtpgXyiE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ka9lARfB0eBCJiHugYoi+vrNn52cxM81wQCwXwdVouUF+DL180wP02juQG/5eyQQS5wpvwXN1Ig6niKcMHCBlf0stMr2lOc7HM3WgteQpS0dMACxIdJ5Q/wAsyPEsN83nbKb6TdUFl/LTZYRC78qTl7cQ/e45+yTmS0MBl4trWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nNOiOP5A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HqXI6W12; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nNOiOP5A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HqXI6W12"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T8xmhn2432112
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 09:13:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E7o4Ira/aNei8mna5R2+2B+2M4PuHYmEv2lnl6X+uls=; b=nNOiOP5Atvc+atun
	45mZNhDx7q6EkdNaRDhn5LjMh6TLUjFzUhycSyCa3Z0uv5nBqXMOPxV+uSAke4Ku
	T7lMTA/09AOUgNWuRqRQ+d/zJTddMeOluwU0/40N70wtzyAnneMDXch6BBr7w998
	tDB8wNA5lT2pZlrzedKaDM5b64ztVvjDf0Gbs/SGiB48jRd7ISE1fLOXWLc5zYf9
	Xd4Qzg/SINHf5XYSXSgrtlAjVF/y2vohT5Kc9Yr7j3UtRtPUff6ADT0Wcj9A2m/t
	dgOrs/9D7nyS3eyWoxlNwgPKeCQ+C9ENwgsQy65LkO4wRNDRrDi8kxXeT5Vapuqa
	11H4bg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nper24q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 09:13:34 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e4aeea5c3so110844085a.1
        for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 02:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782724413; x=1783329213; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E7o4Ira/aNei8mna5R2+2B+2M4PuHYmEv2lnl6X+uls=;
        b=HqXI6W12uERZ9stm5trGpFo6sLgP3vWxFzhQy+K/FZ2sMFd/ns0rlRHSNDwbyE2a9v
         7a+0+YRWoulFW2n8mRuDsjUb6Is5DrghzHv4Rr1qpejKUj6Q6G+fItfjXBvgSyhg7nHB
         amyumkSyJNEQMR/D2D9OLHYmfqQ80zzvhOZDBnUUaSa8Eit8SOaqG3uIQPPQ7HoFebZw
         Oe2CEjykbaovXtNw7hFPLZ6eJzRqtPQVhlHRNc+cIajfJkOMkC6Py3ql7yAn0A9P8JwF
         Rl/wg5Ys8ESnjJOOjvhOFVqoriGMe3MNoO8EjiR0emmNY1xsvL+YZZDU6PQr7eN0FcYE
         ZE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782724413; x=1783329213;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E7o4Ira/aNei8mna5R2+2B+2M4PuHYmEv2lnl6X+uls=;
        b=UWeMZACIs7FaspHAoCBjjCjpB0xqB+Mu98nNIfkYg+E6Vaxq0CViC9G+2269Dt1gVy
         yeSQWSowGDGDbixvHZJzgKxiYu3qsf96+Cor9c+DjC2QLJ6IarHZNitrnjLldo+uGaKa
         92LvfiFNpMzyA+OwTnP3S1UPMt0gROvdC1SF1cZEMfKutyuovOVh78Ddy0DyzkYNBzx4
         pebIlBcd1NrjTRl6tiPoVxPQhSXp3VxXAN+8x3e/CNNubOEMirmLISeFkhBaCDNfUTQB
         p15yJpM3RJ7YXumr8u+gzadAI4zZ3Dexjj3weEgdLMcCJI+lXHhq/gf5RasMR4EDfuge
         js5A==
X-Forwarded-Encrypted: i=1; AFNElJ/F7oSbyuxfDVulo7QmBv3a6qVLF1q9NuetlJ76bwFyp90nzEn1rKFVTWhcf7mSLkQ3dkBEcg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+TBcZ0UjhVDDRQeUJ6N0148fU65lDfZn4AOoB+gIKBwyMhB6S
	92Cky0YQo7rj90kDyERIBLYmvH5kjMX4z84oiMTP9im9fS2zfuG9blrRWZMQQ37J06nSuglj/KX
	3/Cs6oAzyCeNNR3s5CFlYBejf/xXgp8GMHgF8UHhKgYpKOIeGX4tLjZ8ZOA==
X-Gm-Gg: AfdE7cmN1IENplYivfvD682AfY0dtamQZaY4NEB4lpDDcZMyZli2gdz01TlGLmzMphN
	2+jWW/OV2Uo/FT5+YomxDL89C6rQX1AtzO8uDCuVkX3nXYsU7pYjQ3SMb7SYyPh+EKqF1IpjDne
	Y1BFI4Zz/sqWPKyVuOkufVV/Leb8XH62/Tlu4MNmOK8sPv0daed3bdtcDawvJi6opakvTNqm/04
	Tf0J9xadX06Ug0kf9pg1sGimurE0O/RCZ0fp/FsT8wjPHNY8Jiyt9yoGXYbg2mi1o/FuW2ylNC6
	t3xPJtEWlgGBpnKTxH9IyJWqZHsIINmkcglNhn+ESmoo4B+n/OR9+s669TnHUucViWg6/chD2kx
	0S5OvHn+H6eTLhTcjSVnhQtpU4EkjKxpth7dCRiR8
X-Received: by 2002:a05:620a:1709:b0:90f:786c:4a82 with SMTP id af79cd13be357-926032cb1f3mr3581738785a.39.1782724412980;
        Mon, 29 Jun 2026 02:13:32 -0700 (PDT)
X-Received: by 2002:a05:620a:1709:b0:90f:786c:4a82 with SMTP id af79cd13be357-926032cb1f3mr3581733185a.39.1782724412420;
        Mon, 29 Jun 2026 02:13:32 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-470f55acda0sm20109240f8f.23.2026.06.29.02.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:13:31 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 11:12:34 +0200
Subject: [PATCH v2 11/19] mfd: tps6586: use platform_device_set_of_node()
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-pdev-fwnode-ref-v2-11-8abe2513f96e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=959;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=YiZHp0QI3Ng/8lAx//2O4lFffX7ntR6tJ9zCtpgXyiE=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQjcRLZEV4wuAyM1XFVhA7zrIOgiuiY2Lgzwoy
 WvXthoR70uJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakI3EQAKCRAFnS7L/zaE
 w1cGD/9752d9n7/+/8T9TqF9iQ7G9zlOuyfPubcVf3N8oYfxQ+0pZy96O9R+C0vx5H1PXXRmjn6
 1MaB3Vt39w1WVmSUyqDJ4n8WB24AjpfYGTwAbI0o1lZERogpod5E3M9QPnnVwD9wPPhllmUPty7
 xj30SvOca8pUgImOxyER+gR75EsHqUPeWQasNVopAFx4mS1lo2/u1kqscnDBeqg6Y87buduJX0V
 uOUtSHuQ7w2vlhQ7NqgZHurmNliUGIpxzWfiGSSX3BK9D3AkZSWvLW8zctTGAHCPG+qBFzRVpQ6
 0FqFad0z86W86hiNnldftd2a9NL8dP7GfTyhmmggP/mzqh8x5/bDltnbVjzYzBrVM31qSvqxNUS
 YPD8Ey0CB/ZX/lcEsaoLCOsAHRQsJE+Pt7xReohmz/oBquTOGfSFv1jtm5jIY03sh44Qnqc35QD
 CAnMCCHblZZB9eCTh3y+FCKJXfxLvwMdtbMKOLf4azEE/0LB+S0PZrFvyocZSoMtKLtoR4aExim
 DnBupTzpN+mh2vq64tVXBcwg38pkExWqxEX1LAQUM/UmS1ByltvukbJRxqlHs8WD1UJ+3oTsxSJ
 w/mPtguXJ2fFOtqgczI61HeMKF4E2nHfhBqpM+JhFX/aZ3O/llYHjqsfXoVg6qzpOOoGiwcLxSI
 BcmB/XQ48OIAacQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX8j7r4QYI5RbK
 RHLKYn1mdAzJG86yCbg/rboJsOKkMWCJm/1lzKhylfYeoTdyTIXz9uBZXyqmEi7PPD/DFhM2olq
 cjTv2LcpuFU76ay+cMM3uTF3qaKaA617YJsYyBJOqtTXZmbLTvdMuAeSOqe/zd0DbMSuEko/j80
 pyCqxyEsJUqcTxTXXOsAwUvbNq/zJMMcD+6+15fmvPJn6A36GQ6Wpxx8gPt9nEM93XL2WZsEkLt
 AilvMGSlnlfKPWiK6gG/Ha9Fs6tY5e6B7uXB4SlhJGWCRgIZMOvcJbBpOHu5KSnTiRFFGvsdibO
 o6sWljNPPljEdEuC+/w1iu+zfNoMbQ9oSKV8J8GKjijdAYwqu5p+BZFZvDSeEwD7/8jl3PUmpiH
 6v0m1KNFQXDcGT7KNy2tvcAwcrInD4psdJI7FGwycVux/SnVXRsiWE5sC+rOoK/D+2Mv4FOKiqW
 a5KadPaKGazQIamXVXw==
X-Proofpoint-ORIG-GUID: Xk49oCbwPT1j10fzzXtyJ-XN8eJ1qPwm
X-Authority-Analysis: v=2.4 cv=T6q8ifKQ c=1 sm=1 tr=0 ts=6a42373e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ESSmVKC5p6WdXJfq0SwA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX754hb8LdNwNC
 Cy3lbsUvzu7Hv8bqhkc5f5CM4HDqghwdw/Dss0PShgV3lWILQgqwQzbaNSxA10C1bp8HZ3Z9Q5G
 TUwDnQder4pB1lTnvLiBKq0qfnMffHA=
X-Proofpoint-GUID: Xk49oCbwPT1j10fzzXtyJ-XN8eJ1qPwm
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

Acked-by: Lee Jones <lee@kernel.org>
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

