Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF256404BF5
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 09:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724426; cv=none; b=On5f6+1uBIoHA9GUaAzTn2Vd1L59ht69ZBbo3g2htsoJikgrTb+XicT0tKSpRig9IRiQnlbZ9ldYY/8r5f0k1saR9SOcs5qRq/TFoXh8RbNoCo35Zet2XPo9P/1RfBqD4eW5QrZuoK0RuhM7Su8Db4NYHaYnhnh/Lk6oSozw7ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724426; c=relaxed/simple;
	bh=AwfZgG77y5F6PYl9qwo0/ZCBmtiBmspJvlFnU9x6+ng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MgISRvHJUvgYJB9+Qe2xHcj26Pu5GHMxS4BkDfki37sUBaQ3O1trwXAL/eqpP9hf55uGd2ZGzCmmYicAmYEVELrhTbSvVLNxrlRNhEMH1cUNYRO1xKvEwkjkF2XPt5OlNSH4mjLLUzd0qttqT1EJqVnrZP+jLeCq76MeataT7WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bnbHwr2m; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SnNgLmAE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bnbHwr2m";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SnNgLmAE"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6qxPD2076278
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 09:13:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6nG1Sji42mne2H5wEre1safG9ubwm9+aubw7cimzGYY=; b=bnbHwr2mSRvwhRpY
	T5Fs/qtEPzfnJLoght+lyWjGjZdvsT/Du0by+WEYqMVeHRDStN7RWrbgCO7nPrGl
	M4aulqBeZTNlOK5/1DeV1aK4ffO+kHFYu7AUE3fGhK1+vFuCQ0/sM/kwwaW2xqV+
	dWsjyBGlqaDnSMZWllZdExjlEdI0DJ4t27Zzl0aNRhQH/e6UCLRcq2r7o1F+fSf5
	Cw/VIWryBIdPMFR3FBA1V6fvHP1Fmt4SiKCh12fivPyC5XxkEec1HH71tp12j1J+
	e9YsdRmlxaAHZHhxnxkan14UOGA+daqp//l3w2pRTzBT4kUgmwyw903LhzSYcqG4
	Pi01cQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kp7gkq5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 09:13:43 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92ac0a54110so485575185a.2
        for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 02:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782724422; x=1783329222; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6nG1Sji42mne2H5wEre1safG9ubwm9+aubw7cimzGYY=;
        b=SnNgLmAEMfNgeiX0mOagV3IdMwrTz8qv8o+De9dK8OcXDPIPk7lESf5wn0GYMm3W29
         M31uumbtyXqmc6sUm5iG/RnVFUp5jNoQixOYpbe8aHD39Ox7uBqUABNNLzN18Fn/t8XC
         e2ClcVCdftblCQ2To96OBrgt1kWxr/d7R1IJDxQgnXkEblhegJADBx5h3ed8SAy8Cr5r
         qOUo26639RKZGFgBWJdvbyTXMcx/h9m1umWlRnNt2dkEEl9NddQRG38NdSKNjoWNBfKR
         UigO5aGD9h3FuphECQ3OQA6WPmqaz7Ee6lPI2JMWMw/1vwsqV3TtIeC/+VP0rf4UO8k0
         mDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782724422; x=1783329222;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6nG1Sji42mne2H5wEre1safG9ubwm9+aubw7cimzGYY=;
        b=PrzeuML08AZCZd7sUlsHCpA9VOZLDsl8syLennRK3OSgl6Nu88Lf+8UhKB0aAehdRt
         p98R0tWf8h9gbWR/PSWeKj2hwvnUsJXXd5dDPfksGqpkBoLq6U8mPlc4xR207IvTVUVy
         4l3rcesEpIvm/iJVNXmZ3vofsUNzdiR9+gWlZTjztvIZZ1o5wQ1QOyZSG1p7x3qsYhrQ
         3F36R3w/J42JGMy8wiWIy4NgGo6HO0UdH/CfU0Uk9maehsxJyUlVfLbL5uLTcxLUeB9w
         gEjDdNywnzlWyuYaCWIpKQVV/AsqeomcME3X5zVK5HBgm8kNVzMt6rL3rihXb4NdcvPL
         /lQg==
X-Forwarded-Encrypted: i=1; AFNElJ88N8ImKGHZcRlAicDiPLNSFf+LKCtTyYqIBneB/ilZ2lFaCeHGh8Yk1FZI/ulH1GvOAcuJyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YywF6RLe9T/nFSYzo0o6iq66RZGA8xnWdXr6MS5dnI6ujNIiyvb
	ANY7o/bkL5XpsdO6TvPc8iaY9snJd1n7cMS9ytwB5l5e5kwgqlO3Famvt80RzED0D5AZCzCDbnH
	7qeALCxe10x4foC/riCyzqSv8AIlFzjwN5xdVxLSVXpcjs3bvCGWb8F0ceg==
X-Gm-Gg: AfdE7ck4TNvO6LqWjabOiT8xerxiDGeBSQ2YpFMJNuu0NFWMSE8XlKFitjMYHHq24H6
	6s3OaO4ARyQF9MXplTpumasuoIyOxb2pfM8Eom7NrNAXLzulUECkY+IqOS8lZWOf5C7F/w43lqV
	ZkaP1go0CZaPCA4mOC+7Nr5Cu5RD8cnBW+Y3y96tMYhTukT+RgXX4meGtFjDgPQDnQK5w1pKqXe
	cb5gTT+Tn6O9YqPrWHXwqjytzxDDR9hCF/MwIwwwIkCBdNV6OqUa5c7StIaU+9C0ki4Dzm/ZbEl
	K+pDAPuXitXZBciKPd6Vj+Hwz3HmKyshgyB6cYByheCEMMLnbhDB2WI8pu08rjHoPjjfNraiuQe
	e+wJJt3u3sX8+i+JmpcglsquDnEnYlCPnJj6Fajhq
X-Received: by 2002:a05:620a:26a8:b0:914:c226:ece1 with SMTP id af79cd13be357-9293a8a9a21mr2392759585a.13.1782724422115;
        Mon, 29 Jun 2026 02:13:42 -0700 (PDT)
X-Received: by 2002:a05:620a:26a8:b0:914:c226:ece1 with SMTP id af79cd13be357-9293a8a9a21mr2392754885a.13.1782724421604;
        Mon, 29 Jun 2026 02:13:41 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-470f55acda0sm20109240f8f.23.2026.06.29.02.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:13:40 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 11:12:37 +0200
Subject: [PATCH v2 14/19] drm/xe/i2c: use platform_device_set_fwnode()
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-pdev-fwnode-ref-v2-14-8abe2513f96e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=863;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=AwfZgG77y5F6PYl9qwo0/ZCBmtiBmspJvlFnU9x6+ng=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQjcSMKdRKoFVH1MgLNJk3NI477IXVrggM2yrf
 qWMIi3XU0CJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakI3EgAKCRAFnS7L/zaE
 w85gD/9rbl5AkgwjwdNiBcra1438gWnkZ4eAmKSEAAJXU7zcuofXfASHZOd6zPIW+DrV9r1TlxD
 KP0DeIAOqZ20FbPa4NyxJsz30Xni9oH087pgaDFHuDULWlH807p4z5IAByNWwQO401AUTRLZEDh
 pvULOi595BAoeJMAXJniO09FF8cacJPctOpdYnHd55I9oOmtmKFTxrnCVZIsIsYPqaZdiZADWPR
 MaMoJz6zjDB1IFO0JGZAdHalp2rAkmTTrhr0WgrQx1c2MoTAB9hTqKuVrkc89Jc5wP5ebIgPsuD
 qFljQKN6317Sh2FiMmSKEKGVCihn0H/EGe1vz7oCAE5DFhyZ8ofFKPx85kRbjBbmqg8gHi7KbrN
 lyej/lWRwzx48gMqGXqbW/DIlRjdBRiKolImRNHlpBCy79YAgtKvC2CuWTrZaRq9+1po/RT67Tf
 nqTjAXj4XXZKLtNGgDAu+Ifc36Grr7zKcD0+2sIZD8B+aUjQYuPfQxJOzYZqB2zfNsFGxhjQweL
 RBLurhlNBBwIH6X1Pyzwfheudxf8HN3m/QyOHbct5Z6O0IJ7n8oG7Ed4pHsw7m48/K4pPMB5ViE
 G5xtCnPpLGA+nNR7tqS+s3DrKKnkQo0eMI5JgGcUj+jVUodDfAKTd0dDBasosoFU72LcyzV/dVj
 ZVn6U4/QQLq78kw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX3HNpTx0tq56y
 9bcb3YdLjiddHA4QeEjwxS9aDlNc0iY9vHc7fxQZqQ1fKl5UEonwJy+QRkjD5HR3eYUHs4DS8Y9
 zuiNNKulR7iJVBpy3SgTAiKkw1OfOWo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfXwecbSQPrwICP
 XhAtYQFATnWk4agUjEnj76mwhLoJ6cZCG66M8QlKNlUpA+J2bV/yvUjQyG9F7jGhv5XlNNFTWFF
 nE6/28rzntWjJzrelvOOhpgOrF+5Vi9/EEvvGF7d3esD9fnEAcnH5kajV3J8IZiSV/8eQrUMBef
 VYY9OXsEMAUB4cqHV7Z3fX5HM8sFWT/ZJQATVBODxUeeOm6pl0JW7eizDKD3OHv2J5vR6iq/uv1
 VPNmgD1v40P5lNqD2GPzs2qHUlX46UHd5jwJ1pBDdN41IRvqDiq1G/kIF8D9G8kgNCGJzq3F+Y/
 l7Da3jh9IEUME1Dt4cdFkksLlghQGnVhDPo/5Qx5Tn0p8jiLliyVaxtJ7RozJi00LgeSDawkpjv
 8WgG7X7WfOwskio5XW5+uG/rmH/nM1HgkCF/oNLkqpPZKlPMJh+R2FvN/DUBshUZhu4cIHctcwq
 /lqV9ATMcfl5gvt2Kwg==
X-Proofpoint-ORIG-GUID: v8irWdpZR6nx2fxVSO-i4Y-T1FCiRGvf
X-Authority-Analysis: v=2.4 cv=MZJcfZ/f c=1 sm=1 tr=0 ts=6a423747 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=Jb7EFCjKRuSTjX4XlnwA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: v8irWdpZR6nx2fxVSO-i4Y-T1FCiRGvf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290074

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

