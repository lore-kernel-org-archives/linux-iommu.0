Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792995937;
	b=x0BXdJ24fhWol3VcA48zxYPFxjaVQYLQ1yPirZPZuV1Y+Cn8/pIS91HZoklzjFWVnfuL
	 Sh2EZBXCpkxMI51ipHnl2mLOSloQpb+Q10E0MGFPcqwbvVZJInggli8+E3Ss5m4kltLcu
	 ojgZVPmFhskgdz3DzGW+CBh5Gc8/PkBzlvpydw3i3QQQpDeONP46ZnQgeDF0NDk3UBgtC
	 utjV3wuvyM0tB3rtMQlEkeJsp5N0fsnjTUQfxL/RNbm37pocwHCkXhGEb56Yt0gkBt93C
	 WsaOboCWjBsdkFR1KhfLW/wS+hF05iKLDFPi8WOwdQV6Vlg+u8JO7qQHUSczilKJLXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792995937;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=X+yqLfO39gj/H74c+0JuxaYjS95aZYaE8hMGc6dAOLI=;
	b=5efD9clV8RSzSYaVAd4ivaiCW6W9olQ42uZUO588azUqNPpwA7gdvo6wT0751yV59Bwa
	 Y1VN4SDDwkHgs5o93jfTIR0hiGyL+bzv0r/XB05F3hV619ZSKCVyvhn0b491Raz01DR39
	 LmEjUUscdcIB22eBJKus/T2QaaoIZVeYK0hntV7RMkQCpKBeQPN1A1z7FjkvBqV8O6G1n
	 6SFXUe3htdbSdJy//p35wYozlWrPxsggLs0gSDZLmB8h5GXswulv8q/SdeZ//33mqRIM/
	 QrQfmLpTupAEcLm5PQ4L5YxhmAh5vpW5NwIPnmcHMTLZ51rZvZkycUSEUuBYQELv7xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d6jUNACE;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AbHcBUmP;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942C8606A322
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 06:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 942C8606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d6jUNACE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AbHcBUmP
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4aSNF1708641
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 06:25:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X+yqLfO39gj/H74c+0JuxaYjS95aZYaE8hMGc6dAOLI=; b=d6jUNACEdMZOAneb
	efc/lmRa0ouqmtZPn6+Lmoacckw5QKLPorWHW4OB6TWz/6dvAfcL4m1WDtfznd0/
	ICcLtZNS6b6JuiLKehMPapqK0XJsrbbmgRHvTAIwtvwZtP2wE1s4xTZ9ajwUCjkN
	YFWqESrQ7CIZ3WoQURT/1XMXMTOx8cm2OdPGdBFYnrROzceKLxgy4PjYxvaR+PAq
	ap0JCgeSelkq9r9Kx/mX8M1U4XV0z8HOiA0SSt+mnjbiexaAT0DpabYJ+4KEPVda
	cBrcqlp4m1v3mtoL7YbfppntANJNpzQFWBN4xBUjoIJslJriDxA+zLbfod2FcQZ2
	gBpCBA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhsjd94fw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 06:25:35 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ac77c3ff6aso4153217a91.0
        for <iommu@lists.linux.dev>; Sun, 25 Oct 2026 23:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792995935; x=1793600735; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X+yqLfO39gj/H74c+0JuxaYjS95aZYaE8hMGc6dAOLI=;
        b=AbHcBUmPfels+ng9/uRYApaNvbcYi8l+tnqGVhIuSJDAXuPENguaWpCVV2nRuDaCpf
         5B4LRBUpo7qyuDRgIs/AOJCHQE+ofTeBWYv8X+Dy08wZ8tPK2Z2AX3Utw7TAGDGKIKA2
         +aRASsDjs2o7LL09YcyWVGgLp4g6x0nUgejbc8e7o1SJGHNXbClqQSLaNBc48QuSq9Yt
         kSCMJSdAgFi4UvhDWGvo/y4PbzvFjXC9wEvw431/G5yEVMEykhF1fMOfXWpim8IkonDq
         dAvT47D4nF2XVggjxr1xFGYfcfoOLxabnSgO5Pva8GEDgUeWuWvTc7QL4YuvSy3i/Fkd
         fnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792995935; x=1793600735;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X+yqLfO39gj/H74c+0JuxaYjS95aZYaE8hMGc6dAOLI=;
        b=fSm93jgM5fcgVEG4BlXgZQMcZMGfOt/7tkmtdOCKaQiEkJglvmJZ2H+3pmEpkFc2Sj
         ev6wFXiIGgII+FjS4VDJ+UV/8ORJkFPOUHuJoDgjlHEnOOf+6ImHfupqoIX/gI8GvS9O
         MQJfTZokqM1xAbu6aw1qKSwDjLQAc7OmBcFiHuIoP1Bvzxiq/7djBF8khK52sReY3Xsl
         rPFcJoxN2SYHFkMOeXJUvSvBKD6MEK5cv8kexJr24C95bU7jQ3miwDT/qbEYQa9YKBHL
         q+mYJFWny53GUB5q91iT9JMNfH9MvaJaEXCsrkzBuAu/Uxt5n5gJClCcXmQHiT0PDXN9
         M8eg==
X-Forwarded-Encrypted: i=1; AKwUvBygb316Og0sscfLEktvTckS6ul4xqjb57E7u9JYNJ6NNU+lOraOTcE8H7/SgNV61Dhw7Kv2Hg==@lists.linux.dev
X-Gm-Message-State: AFq9FYLsR6k+yvX9LOHf15A2R81mTghR48Mfd1SzV18qktp60LhKJPg3
	cZHwVRDsTVUkdqUavr9tCFLBG8ohpzNgzTJUo0/wrfRKVesTMlEfWdyLAjlnoy3v27bmFGHnE3k
	OlvHwv7Kq/8APUYabWgbb92Et8yCe+ECoVAvOsIhchiLJPyBhZVvyyeXyjw==
X-Gm-Gg: AYBFou2hyh79xjzvAnyvOW1Ee+VdzpmIXh1w2zgZYlBkLkOQ9aEuVl/hmgxJUE4l1YL
	rIyDjLzuCwdpULQL0SyohMLZLrC5R5d9nAlSWrvLQRfYAZXCdzK+MAL/JDlm9Ymfcj67LSj8MOW
	gSFNzuxd7BKUoFsClsdsTjpgx6GiDsCaSoWODn+rmkFR4emw1WWS2vCmYV6sL0Sn8Bnd/tGWjm+
	MdcCZZ9IBJV3Ubl8rCv9DVxcCvbW2aq0qvow/QllERVuVjbRETDJDvsw2Lfu1jAmDM/298h3cj/
	4ACM7/+dHcFqhaCPTOI4VNw0ui6itBrclp/cCwn+wQHMXD0WGHCmK+xEIjDXJybiuuBinhEfmMl
	/J0N9P0dHeOZO2k9urQoXqNX0sK8ZfLekKg==
X-Received: by 2002:a17:903:1246:b0:2dd:9b53:f9ba with SMTP id d9443c01a7336-2ea9c03e626mr53707785ad.1.1792995935089;
        Sun, 25 Oct 2026 23:25:35 -0700 (PDT)
X-Received: by 2002:a17:903:1246:b0:2dd:9b53:f9ba with SMTP id d9443c01a7336-2ea9c03e626mr53707485ad.1.1792995934668;
        Sun, 25 Oct 2026 23:25:34 -0700 (PDT)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1a1c56sm12633415ad.44.2026.10.25.23.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 23:25:34 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:51:32 +0530
Subject: [PATCH v2 22/23] drm/msm: Register the DCP backend
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-jshekhar-dcp-hlos-v2-22-7cf014efdee1@oss.qualcomm.com>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowangio@gmail.com>,
        =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Philipp Stanner <phasta@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Flemin Jose <flemin.jose@oss.qualcomm.com>,
        Mahadevan P <mahap@oss.qualcomm.com>
Cc: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>,
        virtualization@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        iommu@lists.linux.dev
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792995687; l=1867;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=DnOVMMMul1WJd1CWK5XVZuD8++FkNWwJHoR8dINot9c=;
 b=QG83X9aBE4jBa1DAS4wPcmTipRI+XMBqCLy0NmwgeS2ERiIBadYlckpX6pOlVddmoKAl5KzcE
 g7G+3CHykn2CWWGLoyNuBrJN0+MFb1zULSaZ+b7RPKVSseb+q1g9A9G
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-ORIG-GUID: F6yoxzkSe8rExP2kr5ZBWH1RAM10B9ox
X-Proofpoint-GUID: F6yoxzkSe8rExP2kr5ZBWH1RAM10B9ox
X-Authority-Analysis: v=2.4 cv=a4elZkSF c=1 sm=1 tr=0 ts=6adef25f cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=lVH-uUz8Z5eEn0x1YxIA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX7VDvStSLADj/
 TBH2zWoAvzfvNtshLVZxodftTqHZiJSKsOOb7WNrGx8v7vGb/KjpGjqBO4bFWIKza6VQHI1vn83
 oumnQ8v2AadqnR35DyO+7xsJd7yA10E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX+0y7biKMb/vs
 2pa9GDHzQyU2EpVm9ShJLdI4KHnOm3FhVXjBBrtLFwvCyMQxU2dc66dz2GT7CGkjjeQ9X+rjGTG
 B+wo/K8vn7NCeyRPiF5+EpDsrMWK3/+KeCYtMKVJlyNijKAXYHIlXB2KJGXfEbXXESvcxNyBhgW
 UIPMRGy/VO7Bqk1ZbSYBUN1fFOTqLaeJPJHT9E6e3kkFg9MEO0oN+t9G8hnxhGnUEETWB/o/eft
 wIj0oH5xrky4+1UaCoTJIk5gaxDUmmSynpkV3qtEJ8FNe7PPWShyL7UeGz9W3IBpcySOxr5xL0j
 VjyY9juwmp9uv9x32AFg1as2b4HO9dSMhucPCGeWd4IetXdEKz/gjuAYgZF2HVwMosbHDhEUeb0
 XOzvdVXMdemYGo9LweXYMTYZmqxJILgOd1UyaIJv6oXwyYhfhQ2EJIjMzmDJINpr2/SWGFrPfLz
 sMh3H1xaxo1MDhxLubQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260025

The DCP platform driver provides an MSM KMS backend. Register it from the
MSM DRM driver init and exit paths so the VirtIO driver can use the backend
when the DCP function is discovered.

Add DCP registration hooks with no-op stubs when CONFIG_DRM_MSM_DCP is
disabled. This keeps backend registration consistent with the other MSM
display backends while allowing DCP support to remain optional.

Assisted-by: LLM
Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_drv.c | 2 ++
 drivers/gpu/drm/msm/msm_drv.h | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 5816c64d7ce7..d413c361c442 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -1208,6 +1208,7 @@ static int __init msm_drm_register(void)
 	DBG("init");
 	msm_mdp_register();
 	msm_dpu_register();
+	msm_dcp_register();
 	msm_dsi_register();
 	msm_hdmi_register();
 	msm_dp_register();
@@ -1229,6 +1230,7 @@ static void __exit msm_drm_unregister(void)
 	msm_dsi_unregister();
 	msm_mdp_unregister();
 	msm_dpu_unregister();
+	msm_dcp_unregister();
 }
 
 module_init(msm_drm_register);
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index aa5dfd82ac6f..befaa9f2cb5c 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -417,6 +417,14 @@ static inline void msm_dpu_register(void) {}
 static inline void msm_dpu_unregister(void) {}
 #endif
 
+#ifdef CONFIG_DRM_MSM_DCP
+void msm_dcp_register(void);
+void msm_dcp_unregister(void);
+#else
+static inline void msm_dcp_register(void) {}
+static inline void msm_dcp_unregister(void) {}
+#endif
+
 #ifdef CONFIG_DRM_MSM_MDSS
 void msm_mdss_register(void);
 void msm_mdss_unregister(void);

-- 
2.43.0

