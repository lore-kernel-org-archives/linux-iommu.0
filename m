Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EE5406264
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 09:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724428; cv=none; b=UOmgtew/w4glO0v9mnvvg6nggnjm4PFoJI/czlOXu2OBdf5JVxmUJPZUvAeIaazl7wofvHC+IC0Fqm84czclm1pm8h7hxutz2RqHB8P0ScnPohmrzJGGNT0FfTdkWRjnR0mPha4SbD1Oq1XmZD3QWUFotBKnZ3T1kCnE3rQ3H3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724428; c=relaxed/simple;
	bh=y0PJDyn5BtOol8KVSo5zceqlnjltVLUQGrxeuNwB+wE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hzo3y8TRHmtCRyEONAWub/QRTUeE0sAWdAhZaKaEkqs1b6GCrhWzCWdTIB+UGGGWzoLwvIA7W6cWyYDAtLuijQ1UBV5aOqFQksfDQpKUyDJhKjVfBQ1z9c5mjjGuNOWx+jSqUeHB4Woh5E1SinJEfZslNXlG7iJkykVjrid06yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cejr7DNW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SYvipCA6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cejr7DNW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SYvipCA6"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T8xgpH2431950
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 09:13:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/bwPG08eA+O+tY0emjmLQ5tYr9hdOkJorHPeq+vKX9o=; b=cejr7DNWhZEH0b4b
	znkSo96hIsO6dDYQWfJ8576Gf7MAwEr/pqbsotQIRB8AFrf4Mxh9BT8gkaAkdUD5
	dpvW+UEbT0ACo//EVQ3r6K1qH5JQZfEcEXBTHzPGKUMxO/12ItZmXxDEP2Vc1wM0
	vkdRhJlb3sbgETbu+C7irkyQehfu/fQgz9AzLdbU/rwcY0r8FnAuf+yWmzmMHXhT
	Fd1yVRYlEkw+OrGBVfRZXEg/DVE+38M4YVZ6Rp7k1FfsFqxwcxVHEtTwn3cffnyx
	PK6GfFuDR97gVlODkbnBdzMUTK0oudEiqK528VXPciKcOdMa5ndkl62VTdcv5iou
	gaKnsA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nper27m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 09:13:46 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92d1cae5939so299396485a.0
        for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 02:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782724425; x=1783329225; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/bwPG08eA+O+tY0emjmLQ5tYr9hdOkJorHPeq+vKX9o=;
        b=SYvipCA6uuZ3KXLesbnSWoiklak542sZ0woBK8FYu+1+sI6ady0Ic5LZw8lFtYO0Tv
         zv0PfK9Ihyc3B6P0rqFDionWqeaSLHJO4lOALXKoUXXxHKVjVA6fNxhJyMTvQqN9U2hG
         kaNc8jE54kikskMC8ojqflI7ewLwf/2IO8+QJSJXkYnMxErE2sa1fhPEgWBXI4oi887E
         v1qxY707N/a1VPWdYu0ao77VOrxxYZZGbp7hiMKb7DMhYausdCx3cbrM3fK10mgIO4ZF
         WDstFxZHYKPXHTeYvlaO7lzbvyByQUNrSQ/jU2fuoZa/g1jtqU8Na7tfLGahIypNhaw8
         QgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782724425; x=1783329225;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/bwPG08eA+O+tY0emjmLQ5tYr9hdOkJorHPeq+vKX9o=;
        b=K0V0RHbhxIZWhXTj/nXwfOM71wW18Vja+eqZHqcRPpWHdnzyo+TJDr2xD71aIXXsS0
         O6+g7qQTUZbAd3i2HdK4ynaReN41ef9L+2RBfJUd/kYuftcqmJ7n3Mwmx9SCuZMMe/Ct
         YRVSVNzEquGXzwPtg02m9bAgI4uEuOvVg/g99ezYhMXmtd6FR/BSYqHJAvLClbk+YgnZ
         t5DBC3a0sBoC0PKZqDF7pxm+0AYX0OZZhBferb30zDG4JOtTf2NbAsKalCc6KPCSyXcH
         1zMK2+P/VT/aZo0+v+1uWzsEfg8zR/k8oIg4djY0+IOcb3e1UrH3656EdiFL6zupuwMr
         3YcA==
X-Forwarded-Encrypted: i=1; AFNElJ+8lJPtpdNLjNiNK4Sju1bJgtFxQkQD9uDw2lJgpwibqcIE/lnemJlMNHhQyV7bBxjBuLhk7A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx9te2ylyr0VqV/pFLH9H+NXrq5mWLSJMmjcc51DiXMZNP3LBpv
	Emgdeq2oZKWFLj8bkIqSy/pM+rdMfgLwwGCCMEVJPpWiKjOAxJ8DJLEOnVvOhl+/tgRfBYNVY+y
	tdH7f7534VDNNYjhvXENOknvxpDHXcGlRrMYH/Hz2nSrY4YHuG0R45a4J/w==
X-Gm-Gg: AfdE7cm7R+2/AcqCBbWfM2aPlq8RMCj+lyy6BUXouw9DGx4mWhDQ43koD3Nzq7WiPRp
	BQPx+B9CJQubrB7EyMHNSMOw1FJo9DFtEelyV0nFdmLcptLs5EfT/t0OP5T20QIkNKNboiaQt/0
	OYzwmAFgfF6n09dzcOKgT3P34gB0g25uAg++PlxqaxKiE8R4mYrjmWYjPQW+4D1FUydJuLo8hnM
	zsbbeZErrXXmw/1fp6eRlP0/1uZJJjtE1Q9MOksxyCV2ei8HmSxV5tqHBFXk69dOgVhO050xnxJ
	QbFL0oDQvrfzCwVYDsU1U+y3284q72DeqPkyF+VFkb7sKnA6y7z907+xWgmNHoR8Ngu6uK/X97Z
	xgowkwh+eKLb/Wdyb1KAhWp1xlBnLsidfz7lGKOel
X-Received: by 2002:a05:620a:4142:b0:92e:4927:2002 with SMTP id af79cd13be357-92e492736dbmr624555885a.39.1782724425017;
        Mon, 29 Jun 2026 02:13:45 -0700 (PDT)
X-Received: by 2002:a05:620a:4142:b0:92e:4927:2002 with SMTP id af79cd13be357-92e492736dbmr624546485a.39.1782724424493;
        Mon, 29 Jun 2026 02:13:44 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-470f55acda0sm20109240f8f.23.2026.06.29.02.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:13:43 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 11:12:38 +0200
Subject: [PATCH v2 15/19] platform/surface: gpe: use
 platform_device_set_fwnode()
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260629-pdev-fwnode-ref-v2-15-8abe2513f96e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=948;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=y0PJDyn5BtOol8KVSo5zceqlnjltVLUQGrxeuNwB+wE=;
 b=kA0DAAoBBZ0uy/82hMMByyZiAGpCNxPIX7sO2Fb0OtIcCoatdP5jodxjCxsQU/1YqFPwbJedd
 okCMwQAAQoAHRYhBJHlEy3ltUYde6Jl/AWdLsv/NoTDBQJqQjcTAAoJEAWdLsv/NoTDHfEP/10Z
 21j+qEaic68CLQuNBgdz4qIRaZIQyRi53HdUwXT8kM6isFULDu5pDNwbBcED/OoC7ALIIyXTpaF
 vEGkyDXAVbzZh5Fpx1BIslvGuXi2wklBdo6eTGN3vz78IUpeb4d6m4VLnRWlfT36IHUS6DT+1h3
 6FUzolZExDbTRa8eUKgTHsZueNoWqtMjRD/6q1ABfXaSpCv5DTIxIqYPnLe/GIZLGFRIV1ivNXX
 hHJYwFz+c9Mz6JzWVJMLuE+fp/iaLBprk8wKW6WLOydKvpF38shDpUBrmdiQsye38mT+aSlL1sE
 Wfr0pqU/u4DS00d6i696v5TbTwWv8mMfteA9JBoEWjLN43gkhGSiRMceHcM27gfGmh4eklHUhni
 BnpeGsmGkYrGhdToZhNobNNjt8LhsrwfY9GQJGpctK8hCY1Eq4RQcHJTuIBLCGFU9PB42Jw7x4K
 XUL4XeOH6TyhaaGfNIVyz/ECTSBWXCOd5Ar0s92Twtl6rjLacXc9B3VPQBabDnNvh9UKshVwjaZ
 kugbHG30Vv/wx4wJXw//jwQ+EdJsZqJkqBZjyrmFdB2yL/M/0/DXU4l9FGFfciBSZGNqtCHNKzc
 d3ts2rLnwq6iYVMApbO94BjIvXf7W4Rpp3GbYF3W/H5y8m4f20s7uAqcwXkMY2RAz16tHXgSG1L
 WCwgE
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfXzNbYL4luUBCu
 N7Nel9FOJNjVXwErHmhyUECtzNG+dmYNHAT2MnilndD09wFjif7LCkHKPwaD1Y8T9Kk8sYHfRhz
 4aecqqUr992Yqw7mf8zQ7+dH74426iX/pUOcGtPN0CSs15w9skIDePQMli+ua6IBqVQ/HfR2u+t
 wqRzaz6JvrMRrw7oJ1aob+fz23BtOBUiD144YtsNVEjeDb1Q6pflCUKMWsc8AeZu9lH81vF3V31
 WgeJajHXV3oJdqpmqHHU8ild5ul39zglZf9bupp6ctS4NEtQJKutFancTKxjgudsZVeqnSUEZVU
 5xb6LlsxsYrvXkvLdPv0i4QipsiK1Mtnleq7lXJSYBKUXcN2lDHNlvpvgFmlVHD7yLIo7K8HPIZ
 GJJTMe20JlGwhcolHPTtZhcP7QFKBnbTB3lu2SsucoG/z7fs9Ze14nX9wbqtd6N9raikSpS48nM
 srKWcDDzdqMLp6XLGcg==
X-Proofpoint-ORIG-GUID: pc0zBGBsM8MFn8l-U1eP8zEoxKMKraH2
X-Authority-Analysis: v=2.4 cv=T6q8ifKQ c=1 sm=1 tr=0 ts=6a42374a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=PjYnKYjuuXkzxcC25kYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX+7Qo7SM4fcjx
 uT9R4ijPUpU8ccs1UsVEACNSr+jyFVJqQYmde5seiAKEZCpAATzfUAfb72toLco32pi5zNQ6XI4
 1vfsKxRE9wu4HXfQy7qaFw9sUPml9gk=
X-Proofpoint-GUID: pc0zBGBsM8MFn8l-U1eP8zEoxKMKraH2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290074

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the firmware node for dynamically allocated
platform devices with the provided helper.

Acked-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/platform/surface/surface_gpe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/surface/surface_gpe.c b/drivers/platform/surface/surface_gpe.c
index b359413903b13c4f8e8b284ef7ae6f6db3f47d72..40896a8544b0a4da4261ea881b1eaed62d93b32b 100644
--- a/drivers/platform/surface/surface_gpe.c
+++ b/drivers/platform/surface/surface_gpe.c
@@ -317,7 +317,7 @@ static int __init surface_gpe_init(void)
 		goto err_alloc;
 	}
 
-	pdev->dev.fwnode = fwnode;
+	platform_device_set_fwnode(pdev, fwnode);
 
 	status = platform_device_add(pdev);
 	if (status)

-- 
2.47.3

