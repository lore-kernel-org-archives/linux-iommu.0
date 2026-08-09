Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECBA3D9541
	for <iommu@lists.linux.dev>; Sun,  9 Aug 2026 20:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786306569; cv=none; b=QJU3F7y0ullD8miqMHAYW1jxvKEg0UbwqYRLyGM6my7iMSdz+WdSalHywaA0EIfrI/qKpV15YqYmjCBN+va3IlW2NphNgmJCjQe7JA5Y+dlT4O1ed2nPEGOMxeYeaMuXD1D2blaRVulc90QJc0AcNIP0exhxb5jzXC5p76S8Qyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786306569; c=relaxed/simple;
	bh=laikOYLTOPsJSBO/UZWFxuWPBu+oMI4kCDbCOi9meUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I/h74YHDwUwWwv5RSuT0nPXGECMI0Y0ZZ0VZAypulr1+vzScDDBbn7p2PZB1lF3PdEHzj8thPNivhGezk8hB+HlWyHS4or81VUGK4M3C5i3TlJQTwIET3wZEOmolSTiCwiEjCQRLG55dyxdmITtmZj70ZyfwPxeBQVhkg27YB9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZtYfg3x9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ICjwcPd2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZtYfg3x9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ICjwcPd2"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679I9aPQ3433412
	for <iommu@lists.linux.dev>; Sun, 9 Aug 2026 20:16:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pGguj9r1IdxuLI9hJH3l42uPyd/PQzFXNoZbz9w0Okg=; b=ZtYfg3x9F1NGbIh+
	07sq+oIVUQGoBpVV4hPpk9tIzP7yEPavrTfzz4iv/I6K+0DD1NkiFAc7W58L9uUJ
	7Xw86gMRNnqSI9MVwRL/IXC7Kl6K3XL0ySx4uciuRWHjMC3YIdf1bLFR1lS4DxUP
	Q5uWYzqexts7MqAd8Rw6LrX1cJonz6CPvoZqsUrkGbl2wxbJZimmHUuBE3eVTp7D
	MsT+Az/st564yilQtSXhDrCyGxqDe0Hksk2zvLv7xohszW+3unzv1mEyb4ehB0To
	K3Qfoy3sA9VygUSjGu/Ly1jThVyGKp3z1p/nfaC8Tyjozx3EOt2g9T8NyrDcMgkq
	QGFwjQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwstp3rvk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 09 Aug 2026 20:16:05 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c083f1818so13034351cf.0
        for <iommu@lists.linux.dev>; Sun, 09 Aug 2026 13:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786306565; x=1786911365; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pGguj9r1IdxuLI9hJH3l42uPyd/PQzFXNoZbz9w0Okg=;
        b=ICjwcPd2mjbGz0dVBvu6gLPumrGffPEMicTL1iyXYh2oRJxhbbTmb6Asbj8DWTcqcN
         jfsR7hM9XCUPt99/KjYKsjShIlWTWzhSPfnG1k8cmi6a6ejADiLzs8ByMJgUzNpDaWtD
         9iqBv4W0aHjLE3spdFhSrN9d5T1dTG0bsZ+5DQzcmlW8/qYWaRRgtqKzt0gr2o2lKRZ0
         degeU6XuHPdYdNPUCmz6AcFgl1ObV98bcXUVbk88PJb+Uj0Mz60qk3sIZO0aThuTOxVB
         3yN2ABTBTydLNhONlseuZlYqDcqqRPmg3xjHUHrJhMy3L6BCLPISZx5G0bS4UJNNAkgE
         3CUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786306565; x=1786911365;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pGguj9r1IdxuLI9hJH3l42uPyd/PQzFXNoZbz9w0Okg=;
        b=O7dkD1WjfEuJjIAmJ2FWAUac3rccSz64PnH7+OV8u00U1C1IfO0sL3zDjrDVFG4R9x
         wjEF0KlAuzWwGA00B9RX/q8bE1oS0m2qdTZt0zZWl557pW01ltIH+lF4aF+irAdLipej
         CugWmwobxplQj7nZCQQbRr2ACd261ktuy1Qk2a+Ed66YbHH1MqjnpUOskqZiyXF+2n0l
         9LIlO5IaHueQ4C4T+hf49BDGauDa+uuzZy3/F0IVPUtzdSpPxAsKsrHbvf8H/ff/IDM4
         B7+Xbw00mYKyjxjIzZSQJD0Qu2nAd3MNigR6iiA1CEpwtc7r1KqCxxoTvEKJx8HoexoU
         BLwQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrr/A7uSveEPJNJ/UBVhhCDEYwIj/1HlXU3lvgQuDCo5jMiSN1lZjk8xT1OaENQhAQnaghzRA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxG84L6x0OsXnaLgz9xKxzm7Qno8nZkobeVqCJp4b72TKHp23Gz
	u5MPNKTqcIVJC9Ytemy0cG4CtGAE2WPVxZFbBTDOzcfl9RtGGLuYASEYDnfoESOACy3s4aFVdRV
	eAKf708fVTmp5MjZkypo6M7zv/cMFiWyR5ar+cjU7vR/ky9Lv9vq3tFjDQg==
X-Gm-Gg: AR+sD11F/DWaK72whvMe5oSfi5dqlvqzwAc4Ut7dokef98AnaZHWjtu50qux6wIC8Ne
	K4iEMh92NTd+uR1yEEO4JP9w8I7rkcpLjn6jLyZrSNNMXhUQonqT/HqWKEQ7pYHA7Q9A95yVaxa
	9B1ag+R5UbEMQCebHl1IobwtRsif5DMHXFmeywyZkVPsQuXMzjQbTwP0Eqs0EK6WRqHmK9oohPB
	lq4Mx4xrkx7lvPvTNI4C8ZrXfNfOmjqVU8t9ecVuOXNsU5fuuaYh1RyIjJbTgAFaDQRD3NhYBfY
	w1LIoZ52brqowAW3WAeun85z+VT2XIFXuSyNw3S3Wt9a+y188sJJZvLsrlNMo9JVvs8R743Ic5q
	6CHoVyYNJaGeDaV/OETXqWvj2D9Rn0VUFxs9voC1/E8F9h/CbmVMRyxG8syUuzDGFfIPGrd227R
	UTAM6Q6EyB/Bs47w==
X-Received: by 2002:a05:622a:90c:b0:51a:ee21:d342 with SMTP id d75a77b69052e-52d20a15f56mr185842131cf.20.1786306565327;
        Sun, 09 Aug 2026 13:16:05 -0700 (PDT)
X-Received: by 2002:a05:622a:90c:b0:51a:ee21:d342 with SMTP id d75a77b69052e-52d20a15f56mr185841631cf.20.1786306564888;
        Sun, 09 Aug 2026 13:16:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b3055f3cfasm1589259e87.70.2026.08.09.13.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 13:16:02 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 09 Aug 2026 23:15:46 +0300
Subject: [PATCH 07/12] iommu: qcom_iommu: restore context bank state after
 power collapse
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260809-msm8974-iommu-upstream-v1-7-87f5cd492560@oss.qualcomm.com>
References: <20260809-msm8974-iommu-upstream-v1-0-87f5cd492560@oss.qualcomm.com>
In-Reply-To: <20260809-msm8974-iommu-upstream-v1-0-87f5cd492560@oss.qualcomm.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2381;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=laikOYLTOPsJSBO/UZWFxuWPBu+oMI4kCDbCOi9meUo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqeN/uG0cDyKR2aok2TJTyzHOzP3um1LRqY9Ani
 w7dGVPzYfGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCanjf7gAKCRCLPIo+Aiko
 1SzHCACG7PZKV6+yM6wpDsbk6vicG4zkkgwjq03pwyL5oFnACN7sLYz/WbsK0l+18ZKvlNMLeBW
 EEUhNOOCq0YbDoP2iNeLSgLYxQUuVBC1urvUqAfaDP3OqkjZaEgNrX8KJOzOj8o95JrjrtWpDQH
 Vy/z1GgHzam9eoQBgKmo3On+turuJSrJLOR1FUteO9GTyL+Ld3v0iNZcmoefwJzJVcH0hR0AwBq
 0yLXTx2t3EB4W2UBh55EbwB+DsShzHBaVZ3Sg/q6F7ZDcrro9rhRnHBUpHXutDjfzN/FasiBdG5
 t/bz6zI2xmO8wJDBOKF3IFVIJSvUiOo8IZh9EefdMcXDMLdc
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: WW2I6ipA_QjT4kelJlv4tKVT8XcwoDgb
X-Proofpoint-ORIG-GUID: WW2I6ipA_QjT4kelJlv4tKVT8XcwoDgb
X-Authority-Analysis: v=2.4 cv=CMEamxrD c=1 sm=1 tr=0 ts=6a78e005 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=DguvtcLGRnFhd48z200A:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDE4MyBTYWx0ZWRfX1CZr4sto2y1w
 IFgw4xnks105neh/dRM0J+LhuFB78D9T50fFxHYspd6iYd7O0/rRYnnDoOZWUWIoZf5B5Vh1dai
 pgG1AvbqjrquH6u/XNtws7NpwqMKznMIiuX70wHLMUFRctGarIauZrn7TndpVdVbsLQ5IQOLoWm
 WaGWtOFhU39xyYyRSPdhkT+wJmAmOdeFE9Z0CXjmOcD5gTJBYFjiS5vPChNUiVrEvAK2rdOrKxB
 hGOXlZDIfxvYRVBR9OeahrJJqvR7djGbpYoT+gCUy3fx6H9Wi7LdxG/St2svVKcTunAeclesJKn
 n4LsiVkFMrXkFRcRJ/H/BuWTOZjtrX/jOiGFSUcrIstMvNM4FqWrv8yREXVyh2+Tg9hcfiGgUNm
 HqWb1CHXiRBwbVOZywtEtRJwetA6OOAT6eTwgLxWTr3L5n/bqp3J54S/ozakHPYWgyD5ZGiCFXi
 z0ClZ2urDt3u87wnmzA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDE4MyBTYWx0ZWRfX+07/evBmAT32
 sdGF6RAwKucAavg8V+F+zL4gvEm24fDCEbM9PF5fPp/wcLgcKWIX6gUWgFTIHTBg/yVqCoGBlov
 xR52JCBr5llIF4xnuDIpE5y57DN3/0E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_06,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608090183

The MSM8974 QSMMU instances sit in MMSS GDSCs: whenever the power
domain collapses, the SMMU loses the global and context bank state the
driver programmed, and the next master transaction faults or bypasses
translation.

Cache the computed context bank register values at attach time and
replay the global reset, stream mapping and context bank programming
on runtime resume, for instances that opt in through the new
ctx_restore configuration flag.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 3b07c4cf23fe..8e9488c47d5c 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -64,6 +64,8 @@ struct qcom_iommu_cfg {
 	enum io_pgtable_fmt		 fmt;
 	/* the walker faults on the AF bit despite it being set */
 	bool				 no_afe;
+	/* context banks lose their state over GDSC power collapse */
+	bool				 ctx_restore;
 	const struct qcom_iommu_sid	*sids;	/* one SMR slot per entry */
 	unsigned int			 num_sids;
 };
@@ -94,7 +96,7 @@ struct qcom_iommu_ctx {
 	bool			 secured_ctx;
 	u8			 asid;      /* asid and ctx bank # are 1:1 */
 	struct iommu_domain	*domain;
-	/* programmed context bank state */
+	/* CB state replayed after power collapse on OS-managed instances */
 	u64			 ttbr0;
 	u32			 tcr[2];
 	u32			 mair[2];
@@ -1063,6 +1065,7 @@ static void qcom_iommu_device_remove(struct platform_device *pdev)
 static int __maybe_unused qcom_iommu_resume(struct device *dev)
 {
 	struct qcom_iommu_dev *qcom_iommu = dev_get_drvdata(dev);
+	unsigned int i;
 	int ret;
 
 	ret = clk_bulk_prepare_enable(CLK_NUM, qcom_iommu->clks);
@@ -1079,6 +1082,16 @@ static int __maybe_unused qcom_iommu_resume(struct device *dev)
 			return ret;
 	}
 
+	if (qcom_iommu->cfg && qcom_iommu->cfg->ctx_restore) {
+		/* Restore context banks lost over power collapse */
+		for (i = 0; i <= qcom_iommu->max_asid; i++) {
+			struct qcom_iommu_ctx *ctx = qcom_iommu->ctxs[i];
+
+			if (ctx && ctx->domain && !ctx->secured_ctx)
+				qcom_iommu_program_ctx(qcom_iommu, ctx);
+		}
+	}
+
 	return ret;
 }
 

-- 
2.47.3

