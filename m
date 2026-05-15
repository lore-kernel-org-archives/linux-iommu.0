Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9F247CC67
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 11:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778844221; cv=none; b=lBCEtTndEBCuyqFKmWrXq8kfGvDI0M0f8X0yZFMfuUPlrKroJfxorQkcvDFrL5nae5rY/Lo2qSwI41+WDPy5BGlfS38nQVwzaUZiM7jyWzzP0gc++cWNLURHSXQCh6nKZu6EQJLb1JFnVj4pWaWkrFkr5Iy+eGHp0LdilK3PGCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778844221; c=relaxed/simple;
	bh=R4hyx2wkdaEzOFeos/VVceiifZ41pzNik6VeXo4D/4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fyIz7Vp9yA0IdiS59dq4LSbTsaGzJ9V6sh4uc4tRRWla2zokjYGsNe9kLfK5pCMy/peTmMGy+edr7oNrHcbjbVOImv1bbcLr389IZ/6IyQh0eX6Y0Kfpnh/DN0lq+Lk78JYdXhCEdkBE9agoU5TECTTvXyMV29y+gUOkhMvk2v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZH6r/4P/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Yv0s1IZT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZH6r/4P/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Yv0s1IZT"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F5WiG44008290
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 11:23:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KJAZYj78iKXwM75l/HDp+1jydtLEC0dNPj7aNSYgj0o=; b=ZH6r/4P/bjfihWKc
	MWvcPuD3B8tBa1R0q1RbSZQfNbO71WlEUb7+LlWA1NB4Uj+Ei3K0zu6B0SzNZ3RC
	XY6CCujcEv6Vk6gL6ThGZ1qK6ExE13ZKdD8ljdm2ElJ+okYoeEU3+JfFPj0LghC4
	Tk/J9EvkavnoiP21apqjS+VWijHKIQVy3494l46PzjaVB4N2+zduvI59FRCUVAZa
	PhByS9XHmVX1I3QWFtViIXYrdCppNIBXBaVUxpYl4yfk1dvJhRdqkD8msJRLmVnl
	J6dgdUCPfXlMUkf9F1agxNCJbCB3FM/RZbULEbv+ey/lpIoKxDkeJYPDiXYdIHE9
	C13O1g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1su1gp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 11:23:39 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-367bb9caa54so8368020a91.2
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 04:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778844218; x=1779449018; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KJAZYj78iKXwM75l/HDp+1jydtLEC0dNPj7aNSYgj0o=;
        b=Yv0s1IZTidhwxFxEatfX/WaxIojz2/o96tzKRY2p25OP7FTazj6YOhGoGdMLsNTiUe
         z6ltGgsHv2YsfUQpWFdaQGtYS/CS6aJk/MswMw4WFai4ysr2oLq8bze+Ct7sXkTqko89
         uVBDrPu8eWQ5HKSbC3tpMiKRiIWv6mkkixCMnHsDw5i/6relEtZ7PYRRpAzFQv6NJZ7n
         SCsFMDWk8TLnoERKGLSRG2AHskv7leFiCx7ypDPGF5Xruq1zy4u7tKfg9pOC60GJNr+R
         8uJmteOqlzkaAwoaprWnOuptNadDRdFUDjn3CnkGT1Gm/KhdWnT7IJGcdxXGb+SBNeKa
         4tgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778844218; x=1779449018;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KJAZYj78iKXwM75l/HDp+1jydtLEC0dNPj7aNSYgj0o=;
        b=dYrIWTLaZTqtyGcDoJxXf9plyLdI3w443a9AH7OaT/ZyUo6YcgwaqKgEdD1giNvUIi
         zNfVstdnGdMfLDP+0YXXKOYG1oJJoGGGcS9oXZeGWP1+tfE1S7K9gE8p6Ht+JLtAw3xl
         Q/sYQ8JyApk+Yt1QrB4yOzjk3PSQKFeLtzDkLrCpvNt3GvzAKy/m3/5ABUuWvS6iDmPA
         HP8BIet62Jm01ruYZSLTIZt3mRMEvG1vcYTTW7dp9TCLkj0ds/CSNUGKf6eRaSYWJofd
         pIm1gAeRDUaIzyaOcDk7aJzTOA9VwSFpKSN8RtIVsH1XslNGCQALSIDolOMxwKgbNZD7
         rcWw==
X-Forwarded-Encrypted: i=1; AFNElJ/S/kY+MtP+V3n47Gw/EtqGMIMPZ6lyRyXVu5/drW8/yPYeRpIr2O+4pOnS55OiO98OzDk2pQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YykcSoScGxZyLMiwpWKyLCjAORTb8fGgkPfoKee0USAaHLg7g/7
	jqVmihWMmvgaSzjBNHKJnUrDHJSW1d96YICSx53A1lZ909AR77aoAgto/LnKiBvyAjj3kmB9NJi
	iYhXDJaXUKFewaHtNfOGGxaIBoWZ8OyJsSkMrgbyC6wBhw/QHD5pRBSLLyw==
X-Gm-Gg: Acq92OE2+2MjokReb0IgUAKADTb1smErLQDhTaztQ3FrTb9xYnCYEpYs3qDZRYn70Iy
	z7q3Rc5awMzbk0DvdTrxzwJPu2k63liufLvja/WVO5kixT3p5fCMZxsVJeeuYizn/aZvBx7o4dT
	+ihlAFbT7oMIcC4bvxL2ssHWcrLY0HLf/JmoQHwgqQZiZLVOFQkleSInHhNJCs4nYhEjTYrK75r
	azN5i/sK7dqkgfJgVRGQ7vmittsx+B/P+0IduVWd+0BWyB+CDQvxo6JbpO5RQQCFSC+T5xBTa7O
	sPGXdpNw7nytKACNbMHT/LvHzUcBaXynPbB4eLMe4+HUY4H47h5Er5XkELl1yLFOSsW+ldCFKsF
	MRflO1zzF7GB0i5mOuKPZEtG5cBvFNiAHrqOuTAz/4L6J+rWRt13KWG0=
X-Received: by 2002:a17:90b:5290:b0:35c:30a8:32a with SMTP id 98e67ed59e1d1-369519ffc97mr3758476a91.9.1778844218283;
        Fri, 15 May 2026 04:23:38 -0700 (PDT)
X-Received: by 2002:a17:90b:5290:b0:35c:30a8:32a with SMTP id 98e67ed59e1d1-369519ffc97mr3758423a91.9.1778844217830;
        Fri, 15 May 2026 04:23:37 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36951584654sm2476249a91.7.2026.05.15.04.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 04:23:37 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Fri, 15 May 2026 16:51:17 +0530
Subject: [PATCH v6 02/14] iommu: Add iris-vpu-bus to iommu_buses
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-glymur-v6-2-f6a99cb43a24@oss.qualcomm.com>
References: <20260515-glymur-v6-0-f6a99cb43a24@oss.qualcomm.com>
In-Reply-To: <20260515-glymur-v6-0-f6a99cb43a24@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778844197; l=1090;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=nwLCkv3OjAFGS6jwKQhLZrEXe26RmaJcgKrBgwUePzE=;
 b=7o6m1C3GzJF7wYxJqXejGuZGgG9YRn2+c6vLHEyNya/et9avgtj9sj4z21cH9Kwy0U+ClNAwo
 nWMlX1NqLtBBKhO+bHZJ27Ti0SI3s3mRZ7sHQBp2smRB9uo90nuNlRu
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-ORIG-GUID: M-Lxn50QNOlQR9QNAXAGMh0I0ClmYbrz
X-Proofpoint-GUID: M-Lxn50QNOlQR9QNAXAGMh0I0ClmYbrz
X-Authority-Analysis: v=2.4 cv=cZPiaHDM c=1 sm=1 tr=0 ts=6a07023b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=ZGoT60Gb6PEvP4nDRaMA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDExNSBTYWx0ZWRfX2JljD6fODOYz
 JWEt/Cngfpi1p0q/nokl1PuVUQeS3MAaJtIAhrIX8cIuLbkc7yExDZRZh5QjTvzw8dSZpKclKNB
 lSasLK1uwqTvx1o0m2as7TIxarx+OQ3wKiAc7QNPgShoXAbymbAzMkK9pU4kP0netYgC4d2uQvY
 izJ761NnavBQ8atg83gJXJgBunXBe020qbZof4FPuStdQVX5XDrcYK6s52UB4JliI34ocZNwJ/j
 6gvfI047vdeMazU+UL2sbgySm9YT2eHwncRm9G7Xhr5fU1pG9nR8rQPtyGvyoNrGKGsZvDfhgSD
 tNRHquPGTHx4C3WGjgc2BPSCtX4wdd5IJL01Kw9PfB+qorpwMgmQX83/v1ElbUDLmr9hA73RwYu
 7rNg50hlSCBOhOolaQ28Tdbc11jJxq74DLKw2tO1F9n5lyi2UQ1YyiMDXG0m+Nyv9JbCMw1KK5U
 WG7fNkjpj5B+9KGg6FQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150115

From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

Add iris_vpu_bus_type to the iommu_buses array in the core IOMMU
subsystem so that the bus notifier callbacks are registered for
device addition and removal events.

Reviewed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/iommu/iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 61c12ba78206..d2c67f0de13a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -13,6 +13,7 @@
 #include <linux/bug.h>
 #include <linux/types.h>
 #include <linux/init.h>
+#include <linux/iris_vpu_bus.h>
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
@@ -179,6 +180,9 @@ static const struct bus_type * const iommu_buses[] = {
 #ifdef CONFIG_CDX_BUS
 	&cdx_bus_type,
 #endif
+#ifdef CONFIG_QCOM_IRIS_VPU_BUS
+	&iris_vpu_bus_type,
+#endif
 };
 
 /*

-- 
2.34.1

