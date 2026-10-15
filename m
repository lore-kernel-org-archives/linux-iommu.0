Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989E149C4C7
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 07:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792050056; cv=none; b=ABW3tVJX2TqZcNJ+pDEeoO7F2+VFO0EoUYzgTiLwUnswKp5gDe4Hx0WCUtBWBcXKY6pB5GMDhwkRWTGdKbE2WP+ffKZCvar6OinzfR8EzF8hCg4NE6MN9idM5Afo+H+89pXhtWgZH63G9+Rv5t8HpirFmFZIvKhLTBEr0evodvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792050056; c=relaxed/simple;
	bh=KTdIkjaGNgd8M+aQhN1Sliw179pZI7BN3p4JO2Z8Txw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KLKJFyRvtHqzFY9iwD/moQ4/ZQ9w3bX6GsVEBPYv85//vptMFiMjYnze/g6IS2oqo22xCT9qHYaoXE9CI+mxD2IoQF6A+9yIsFTcUJE3Bl3p6J3j8UUDFwW53IHsvkNyNQyHTIGfWsyWBGJyaeQ4CkLTQrqEkuy1lpcXjn0Bn50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PJvwGzEv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YOsX+Xb2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PJvwGzEv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YOsX+Xb2"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F3wgIc1889628
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 07:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5cTNxoUZcqOAxt1GmGEc/9lBQ7YAHi80QYMo0vkxe24=; b=PJvwGzEvtYVYkYTp
	SHinAg5IXPtETn3dk6XSbm/EZUHpWNF6wKR0V38xO96AqMtfvBZDEUTosHkxXwvT
	iV82LGLxtfGUSppdy3nOYnyMBCagh2nxm5eODM+hqOyM0rW2diFTG1Gb4L1mMSYd
	Qpqn1RnEwaEaRJVALNvpTF/1jm6ZbZ5/0+6/5ury5ytEu3L1bX7iWuM4Qb5VNNsW
	Vngc4zM8WzTdjVfXn6kqPNusWUA7SgMrO+IvHU8J0ssKNKMQC37lYK5C91Gz5LKo
	MWpm0nvD+NBYUOL1ZrENIRGv/QKDyavMBQjSOSDvGwW0n3PyOId2oTIjBwubkj49
	JSapvA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqda0spg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 07:40:52 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ab2395f104so1130993a91.2
        for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 00:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792050051; x=1792654851; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5cTNxoUZcqOAxt1GmGEc/9lBQ7YAHi80QYMo0vkxe24=;
        b=YOsX+Xb2wO+oU0zaU0gkTzsU/CZh4OYWdkOY8hVJareZqcuTMeleeVztKz/RzUJYaD
         L9HJCGqOarjBCtPwkEOXIVTx7kgEu3A4TtGaBvfXK4Qzj/a0WhQroOt9jOE1jT0lcq6Q
         5ySZy2LF9ZCnXiV3Gj77fC2ZYsKEQe5BZh9A/XWsXzPrUNFAXuPk2JjWY+TTqkz8r3vr
         u/h8RCCp6i7z/aw1wiJXLiGeBV6wb7/tO/AtNf0X7AmfmN8cCQiOMBanxwHxI7NHRO6C
         7d8utKniWKlckZJE+n8wf7NSHGYWvCKyJmix4IS8E+K8u+JGMBzUKAzRwX16Ez4mVztF
         Mn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792050051; x=1792654851;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5cTNxoUZcqOAxt1GmGEc/9lBQ7YAHi80QYMo0vkxe24=;
        b=ZtXpI8U3DMM6K+ShA1YWbNoHpJBWLLZ5MlUSnCm+rT8XLyxx8EYM3i1iV4Gj1KVmk+
         8hqMRbeHx3ZtTOvlclFyVMY0IhjQZGG6Kv6R22H8mkrAuMpWTfpYCGzIlVNh5zBYCA2j
         hgmiCESGj8otcZH5VxZTOT8nHdNdkeI+Usn6USRVDO11kzcPZp80qw6h6D1zJpE5MZm1
         ZocVYWkHjoa3+WjG4/p2Dxj/mZ3pZealK70GBESfddZT9N3SY5986GkNWJooD/1MGcDv
         ItFGe2Tx63dQqTBGzHY2Svyr6A7opa+RO44WoPaIPIG/oTVUNmtEUkWRIJPMz/Gi6cJK
         AnYQ==
X-Forwarded-Encrypted: i=1; AKwUvBx1bDK8LHo3u2QkXy/fLGUclL5N5iNUP5Qbc/Onzy/wfQSkxyEu2mSOdkBdfUCm7r32e4KHyw==@lists.linux.dev
X-Gm-Message-State: AFq9FYLpLSJwFx7hrEIgb+EFIHqTyJnQcpKxF8XcAcl30u925kp8iibd
	oTV+zLKuMWj0RpdnAOkzaJ1QN4dIOSxv7jIHuOWbA60oTY6WipgUGEM/984o8bY2raBbhsAKkgi
	rIleofi9jG6psQKqJa/zPvfso4tcOPVQZ/zktSWHKiyG7HdRCJDSpUBRD8Q==
X-Gm-Gg: AYBFou2ysjOjULAb/+wmus4o9xBrOpPZ73buOi6p6s54enGTErOB8v77sgsY7fANXV6
	4iZJAjazX3vFEkvNRbUkwbL32iOiiDUOY7y4qmKc1pfHW9/8EjurupCYaGgCz7i6f3NnDWy1TAJ
	pR1TKtXUKK/UIvx9phKhVrRCIlhTl9mTTCo3NBJqdPmjGgUTOSWkCSNikDkvZhD9pQT9BdwLV/i
	3dzqBM3X/XHqKuibr795WzVZcLXDlg7DF6kP2LzkDg5ddWa9joeJcNqYN0vrX87IT/uo5tCUuEO
	jqPkmilF6jjXoVKJD9x5cJXRRQa0LdBCHtAXj7raqI25/A1bZGG+Bd1hrVmSyd3dHKsCrHgA0po
	cxO3kdkApshoiwuzIMgx+85RvxqCeW12HbLU=
X-Received: by 2002:a17:90a:d006:b0:3a7:bf13:6007 with SMTP id 98e67ed59e1d1-3ab3a9128c8mr15644322a91.14.1792050051141;
        Thu, 15 Oct 2026 00:40:51 -0700 (PDT)
X-Received: by 2002:a17:90a:d006:b0:3a7:bf13:6007 with SMTP id 98e67ed59e1d1-3ab3a9128c8mr15644306a91.14.1792050050596;
        Thu, 15 Oct 2026 00:40:50 -0700 (PDT)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e944c23f17sm14014825ad.27.2026.10.15.00.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 00:40:50 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 13:08:32 +0530
Subject: [PATCH 12/13] drm/msm: Register the DCP backend
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-jshekhar-drm-msm-dcp-v1-v1-12-48aad0fe4f72@oss.qualcomm.com>
References: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
In-Reply-To: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Philipp Stanner <phasta@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
        Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792049920; l=1867;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=KTdIkjaGNgd8M+aQhN1Sliw179pZI7BN3p4JO2Z8Txw=;
 b=gZH8cI5MZKuwSBGLRmM9KBPrUf6xwCojXAgQ86ziJfC23p1ZjpMksabwSdcHJeay6I3FXyCi3
 zeauB9NbyiqBIdzvpbDLVgDbBWtAjLblZlEpRE2DFZ3R2V/NRucRNca
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzMCBTYWx0ZWRfX4gYZfjSD0y+d
 3gl7TDrLKBsXs5GuWjRaSZHnRsmn2crFke5QASuC51zQ5oCMT07455DJERM2GaJzd71BgZsB/Bt
 8U2jY3b1wfad68VXKlWlViFjJ3J+DUo=
X-Authority-Analysis: v=2.4 cv=K9u3jCWI c=1 sm=1 tr=0 ts=6ad08384 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=lVH-uUz8Z5eEn0x1YxIA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: RYC_-h4pqIAuxXKrItUEvRpm02TiRkvY
X-Proofpoint-ORIG-GUID: RYC_-h4pqIAuxXKrItUEvRpm02TiRkvY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzMCBTYWx0ZWRfX8Uv4ga5r6i2u
 TBmzV1prmmA9uxxr7GfFNuWG2jm8Hl06PlT0P9UA6j/NNhSMLcUHzHLLAyRToWhrCpiMNI03MHb
 CZD6JCT1hbD8vraGKOWlQTV/3g2oxg0l3k/ViZiq/da0Q4RB3u76uF9xnS1TJgGX8MuqQrUp4Fh
 9sfLRZHyN3xkD3+HkjGonU0uu03nKA2gcXbQWQ8GMqCfMqR9hADLsjFklN1/qIbwGHnxHP+/JMF
 2+GXd/F2ZbCgTdrrLRlZQ+Zw3MUoZFfBGD86hUtt5rz61Elc+4d4N3yZy/tbSp/6IkAbpueXGYs
 JuDo8cBGSVKU9SeRmiJBDqjYxLNZSot5iw5I5FBoO2vbVPfSAG892PSpzmDk8N4ufZCl+pzTTkd
 hUEfzO4GX905SNCt3MS+H4C9lY4k0gMmt9fiV0kA8iwShL9nmKuUWRV5eKci1s9r5Bw0HJPpe9V
 xYcxSL+2rnhwSrsiAEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150030

The DCP platform driver provides an MSM KMS backend. Register it from the
MSM DRM driver init and exit paths so the VirtIO driver can use the backend
when the DCP function is discovered.

Add DCP registration hooks with no-op stubs when CONFIG_DRM_MSM_DCP is
disabled. This keeps backend registration consistent with the other MSM
display backends while allowing DCP support to remain optional.

Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Assisted-by: LLM
---
 drivers/gpu/drm/msm/msm_drv.c | 2 ++
 drivers/gpu/drm/msm/msm_drv.h | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index f3d2eaa04f14..04c31596d6d4 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -1135,6 +1135,7 @@ static int __init msm_drm_register(void)
 	DBG("init");
 	msm_mdp_register();
 	msm_dpu_register();
+	msm_dcp_register();
 	msm_dsi_register();
 	msm_hdmi_register();
 	msm_dp_register();
@@ -1156,6 +1157,7 @@ static void __exit msm_drm_unregister(void)
 	msm_dsi_unregister();
 	msm_mdp_unregister();
 	msm_dpu_unregister();
+	msm_dcp_unregister();
 }
 
 module_init(msm_drm_register);
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index eb4bbae8557b..39954932b91b 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -415,6 +415,14 @@ static inline void msm_dpu_register(void) {}
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

