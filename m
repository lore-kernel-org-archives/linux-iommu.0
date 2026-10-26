Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792995776;
	b=R8aG9s8/cCPeTcp70Uvtdom32cXw7xZ7zpCDNFQOy2bb6ldHIpX6Q8qNbXde/W8Xf6Jw
	 pRFlgnwJnpDv2SfTye0pZOPr5PDmwZASpJF4FIAYg5Ga85jvVoHU+xQWJRmRRNexUQwWP
	 6lyE4RmHQKibQ2MCKOH6BkBP6B9n0N7eBaVqz2gcpl1MhFUiEYPsjfrE5CxsmYbcJsIee
	 N/muES9u6AYb5TXnKZRyMcHlgenWcV4toHzSNNYfVt61PGbXsQ7cKjBU/87FC6tnGQEUM
	 ly2lFS34APtoIFJ9O5wpeZmNYiIxN5d1+/9xAMSF1vGK3dbTHdLZw1yKi6J0ksOF8Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792995776;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=3HnpPLv8wy66pzWRk1gzuYm3lOZgZtPQsBL6ePFeWBo=;
	b=Nf8UANmidYb4BjzYDehMJPf26X6y8ni36opt/qWBdlvAyNDuacjHMIZsNA+/D0lWarMQ
	 YAY8BaC2ZppsJ+XkAFL9Mtt4+S8fyZC76YTv+vFzO/ss1CYtAVs971BJSbToREqvW55O7
	 xIFyHmMFurDzuEXDOBdmSiSjAUq/XotVqGc+R78TtfAPrZ05fROUZ9pMZXqbKog3Aok+d
	 Zkm09l1bzcpU5LdWz1PkwBKimLyVp9TkOVyn76vynswgj0+wFukh+JaFGRxeVvdLFRuoG
	 j8U77Ns12hCBimBLm8D0DXX5vzS1E9XGaCrfa+S7yRxR0lK7g1jRMMp2waEBE30Do/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=G7uFCjp3;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PpGD4yCc;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3F7606A31B
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 06:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA3F7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=G7uFCjp3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PpGD4yCc
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4aSMW1708641
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 06:22:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3HnpPLv8wy66pzWRk1gzuYm3lOZgZtPQsBL6ePFeWBo=; b=G7uFCjp3LSMwZOZ3
	b6O8U9fQNx2RpMwBGo/81JaWxOZz0TyPw+Gq821GO9emD0hFpvSjyz/8ilgavpAi
	Zev+Fs8sF7z1sa0F39lZjr9Lq2RphDAUc+o9Hi9/rWe2ymRX2EP9W7h2DV8qZJUB
	0JQGqoD35a+5GEHFLGOqnPLCBFA9+LHVwm7TFkxeQXNRmmSYboe/JkrNd3NkoMrG
	A7vg8BCjv36+B9OIPME1ddDXJrA5IDH6LxS8pLXK9aaQk2ZqmbOLXTjC6D9nhM5Y
	jLFkJn6PweBnzvYoA/5waxd3g/SANy5VBS3pDFPzZ8BIn+1Ix76ATt14i6CquX8+
	hjkMrw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhsjd9430-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 06:22:55 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e832c03576so52488735ad.1
        for <iommu@lists.linux.dev>; Sun, 25 Oct 2026 23:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792995774; x=1793600574; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3HnpPLv8wy66pzWRk1gzuYm3lOZgZtPQsBL6ePFeWBo=;
        b=PpGD4yCcs+okJthM8XOLyioX715CGpayuzfew0HRXu68nDJCPPRczN7UwEU422I4kO
         P7m6bz4c7dVGshetvrfVUPp0TwMtOpliCZ8R31MGeuAw3yH9oWA0lsC5c/HOLVVCVLp9
         Fjn/dwETzYV+EYxCaJYydlZih4S6GYAKqAIKmUd5ruccSA/gDpSm6i79xAwpyyEL8shb
         eyWn+Rmb2ldN3j0YfjJ+YW7fTOspkEWKzQorWNLYsN+Wv5jISgVjMWNNKjCCIxYlxEjy
         8P3r4szmXAuY8gWFnXYrTlgblOA18AS10oNpGfSl4Gsj1skfBIP1Do0LCv9N2yhDwFzU
         HlWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792995774; x=1793600574;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3HnpPLv8wy66pzWRk1gzuYm3lOZgZtPQsBL6ePFeWBo=;
        b=PDEc+gz5LVTAXIeOGXrNZ2hmz15cnIWbHq5CMPiMeaJU4C9vWD6ca5Neqqchx4UFpf
         y8MsOAzRD1aEeAb+g6m3DAcfznp/b2rNeHZU6RtHJ7fynJJkGKg0zNodOojwNYBtuyUp
         ice8KtjM4reNbAqpQaJ6vTUSnz6HKUq0Zz4kE2cz4x8bXv2F6OLouU8OY5TzsGMagMZL
         YBeWqmHAs4HLSBNG2/Uv2R3ABsiKV8ppWJfYDpLVul432cnG8Ywv1BFuHhtuXM3Mnlxi
         3OvQi5z5vrJQ6RGsi6bOUR7ClxGUUC642Bc8r7abxHTQgoYu8uqY5PRxH/csymkAP+fT
         d5EA==
X-Forwarded-Encrypted: i=1; AKwUvBzoNXkZK/YXjo9Ru2/NPuD1IwBOENQgFqf13FHCvKcHXeAFllENz+lVMRb+e5JBuf9D+n5/MA==@lists.linux.dev
X-Gm-Message-State: AFq9FYLn1njL1DZO3XZd8ch8CmMI0XgEmoUnp80lb2Nf9nmKyrRQVZjE
	sfPz1jU8AE5AnuXUkfofmoYyfbVxI3ofJZrj+C/Qezdh7yIBZrD6wp5sVGJIa3ftrY+eyVMyoDt
	5NhyJE5VZ7usFV6vBy7Y+XwrPKt3ae5PeC0qODzihPoJjDItQauI8RBH09w==
X-Gm-Gg: AYBFou18Rs61pz0F9tbMGO+5pvPEaxDMFAkbmCttQsirAVfISJpFrT4LZdhkYQW7CuF
	LkY8DQl1fziJ7aTZAvw7omXAmOu6Kb5I5tCYapnCa3cBM6qxLfSrqUplM2mA8cTlHQPoj2r5b6Y
	I6G5JGVZNc4kNfoXG37dHiSQXQ6tG8aOVnaqrGWA2T7jsHySWTWfqTZ8HDgTimk2VnN/5TyMJ65
	fOFk7XfT3GUXjPGa/VyIM+QCFdguRfm8CHqetbakfAzii67Lym5Cl5HtD/sxERVtbuD/vwWDubN
	lEFpXQUWFgP94leKP2j5Qmc02D+UJqyKPNK5DiItZdbkBk4/X8vJT+a9AVgaGY60nVoNyaUEAFq
	O6kkE3PXmWw7GHAnWsIvPt7RhYbo78hr5KQ==
X-Received: by 2002:a17:903:46cb:b0:2df:9a4d:650a with SMTP id d9443c01a7336-2ea9c68d0c0mr52257995ad.29.1792995774019;
        Sun, 25 Oct 2026 23:22:54 -0700 (PDT)
X-Received: by 2002:a17:903:46cb:b0:2df:9a4d:650a with SMTP id d9443c01a7336-2ea9c68d0c0mr52257785ad.29.1792995773496;
        Sun, 25 Oct 2026 23:22:53 -0700 (PDT)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1a1c56sm12633415ad.44.2026.10.25.23.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 23:22:53 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:51:17 +0530
Subject: [PATCH v2 07/23] drm/msm/dcp: Handle asynchronous HFI responses
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261026-jshekhar-dcp-hlos-v2-7-7cf014efdee1@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792995687; l=15935;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=OiMozPmQnmLsvyt75pE7b3Slp3h5P6NYxCn1k9FoRzc=;
 b=9m6pcpml0JQDGu6M7g7srWd9wq218FG0TGaeH6Edupj8hVl3fWCemwAhkp8zHAPPS0shVcEip
 ez0c6MP7yyyCDleBNW8/2Y7oU3WT17BRthIatZv5L1RvORXp5BcuGRx
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-ORIG-GUID: jQmy35GEsih-0IbKeRK-3iLIMKfafP9m
X-Proofpoint-GUID: jQmy35GEsih-0IbKeRK-3iLIMKfafP9m
X-Authority-Analysis: v=2.4 cv=a4elZkSF c=1 sm=1 tr=0 ts=6adef1bf cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=N7S9M41rjFJ9e01nWvMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX9gwI3YUzjngt
 QMUXfo32W3D8uwtMNq2n+5wIs9iZ63/v7vHv7A+PplL63m7tLXEfW6KrfulhFreaB2FYbe5gOdg
 nU9wFgB9Gyn0sBruAW0Uv+lhvnU9Idc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfXzU+GDQDbHTSK
 2fNzkmVFlnrUGrXhGvcB+9X/cyHPm1+DYnAVSex7v01M4+3WF7LlwQdP6+RBkw/nMl8mLw40uhc
 L3Pouw4W8XUi6BXdIbF0b+aDDajUXUa0gYbnb99dIoXtS71BI2/DG2EP2DFs/skaY9sv5Nv/QK9
 g1zoaOQ65nA+O3Fm9xVpInFy9QKTiBPxeKim7xKJ9SPQ/n/YtC5RXdEmKk1L/OUD3F1T2XinOco
 bMiTv4c8Q7L2a3tbZ2ZGmnrPby6XlOCV1sr3MDSD5VsYNbq7CfTiONC8BLCnhhuQgoDiuLhvRSZ
 TMytuXdrw7Dbv6rLjdnmN4/lPeHf5ZMQD/5uqNJrj9ZExyGGfEebOPDF3/LMdKhh9Hl6bO5beQP
 3vZ53aT8dkdcWajmmDN9iG8lGHt10e1hteHY9fCicuzqR92GAXNRT4XN7Kr9CXfMdrIutMVWO/Q
 Xv26Y1alERI8YFyXpOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260025

Handle HFI messages that are not synchronous command
completions. Capability discovery, resource voting, and display power
control produce asynchronous responses that must not be mistaken for
ordinary command replies.

Dispatch display events, cache capability payloads, deliver
power-control notifications, and defer resource-vote processing while
preserving the existing completion path for synchronous commands.

Assisted-by: LLM
Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dcp/dcp_hfi.h      |  49 ++++++
 drivers/gpu/drm/msm/dcp/dcp_hfi_core.c | 298 +++++++++++++++++++++++++++++++++
 2 files changed, 347 insertions(+)

diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi.h b/drivers/gpu/drm/msm/dcp/dcp_hfi.h
index 23e1cd39b89d..055e9c584892 100644
--- a/drivers/gpu/drm/msm/dcp/dcp_hfi.h
+++ b/drivers/gpu/drm/msm/dcp/dcp_hfi.h
@@ -19,11 +19,24 @@
 #include <linux/workqueue.h>
 #include <linux/xarray.h>
 
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+
 #include "hfi/hfi_packet.h"
 #include "hfi/hfi_pack_unpack_common.h"
 #include "hfi/hfi_packer.h"
 #include "hfi/hfi_unpacker.h"
+#include "hfi/hfi_commands_device.h"
+#include "hfi/hfi_commands_display.h"
+#include "hfi/hfi_commands_panel.h"
+#include "hfi/hfi_commands_display_events.h"
 #include "hfi/hfi_defs_common.h"
+#include "hfi/hfi_defs_display.h"
+#include "hfi/hfi_defs_device.h"
+#include "hfi/hfi_defs_panel.h"
+#include "hfi/hfi_properties_device.h"
+#include "hfi/hfi_properties_display.h"
+#include "hfi/hfi_properties_panel.h"
 
 struct dcp_drv;
 
@@ -35,6 +48,19 @@ struct dcp_drv;
 #define DCP_MAX_DISPLAYS	4
 #define DCP_HFI_CAPS_BUF_SIZE	4096
 
+#define DCP_HFI_RESOURCE_VOTE_BUF_SIZE	256
+
+/* Wire-format resource vote entry. */
+struct dcp_resource_vote_pair {
+	u32 key;
+	u64 value;
+};
+
+struct dcp_resource_vote_wire {
+	__le32 key;
+	__le64 value;
+} __packed;
+
 struct dcp_hfi_caps_cache {
 	struct completion device_done;
 	struct completion display_done;
@@ -135,6 +161,24 @@ struct dcp_hfi {
 	atomic_t packet_id;
 	/* Blocks new work once transport teardown begins. */
 	atomic_t shutdown_in_progress;
+	struct work_struct resource_vote_work;
+	/* Protects resource_vote_buf, resource_vote_len, and callback state. */
+	spinlock_t resource_vote_lock;
+	u8 resource_vote_buf[DCP_HFI_RESOURCE_VOTE_BUF_SIZE];
+	u32 resource_vote_len;
+	u32 resource_vote_generation;
+	void (*resource_vote_cb)(struct dcp_drv *drv,
+				 const struct dcp_resource_vote_pair *pairs,
+				 u32 count);
+	/* Protects capability payload buffers during event delivery. */
+	spinlock_t caps_lock;
+	/* Serializes capability transactions. */
+	struct mutex caps_cache_lock;
+	struct dcp_hfi_caps_cache caps_cache;
+
+	void *power_control_priv;
+	void (*power_control_cb)(void *priv, u32 display_id,
+				 u32 power_mask, bool enable, u32 packet_id);
 };
 
 int dcp_hfi_init(struct dcp_drv *drv, struct virtio_device *vdev,
@@ -167,3 +211,8 @@ int dcp_hfi_send_no_wait_atomic_flags(struct dcp_hfi *hfi, u32 cmd,
 				      enum hfi_packet_payload_type payload_type,
 				      void *payload, u32 payload_size, u32 tx_flags);
 #endif /* __DCP_HFI_H__ */
+void dcp_hfi_set_power_control_cb(struct dcp_hfi *hfi, void *priv,
+				  void (*cb)(void *priv, u32 display_id,
+					     u32 power_mask, bool enable,
+					     u32 packet_id));
+void dcp_hfi_clear_power_control_cb(struct dcp_hfi *hfi, void *priv);
diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c b/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c
index 9f7ac798e13c..774a5afac0f0 100644
--- a/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c
+++ b/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c
@@ -9,6 +9,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
+#include <linux/unaligned.h>
 #include <linux/slab.h>
 #include <linux/scatterlist.h>
 #include <linux/spinlock.h>
@@ -21,8 +22,13 @@
 #include "hfi/hfi_packet.h"
 #include "hfi/hfi_packer.h"
 #include "hfi/hfi_unpacker.h"
+#include "hfi/hfi_commands_device.h"
+#include "hfi/hfi_commands_display.h"
+#include "hfi/hfi_commands_display_events.h"
 #include "hfi/hfi_defs_common.h"
+#include "hfi/hfi_defs_display.h"
 
+static void dcp_hfi_resource_vote_work(struct work_struct *work);
 static int dcp_hfi_prepost_resp_bufs(struct dcp_hfi *hfi);
 
 u32 dcp_hfi_next_packet_id(struct dcp_hfi *hfi)
@@ -227,6 +233,218 @@ void dcp_hfi_cmd_callback(struct virtqueue *vq)
 	spin_unlock_irqrestore(&hfi->cmd_lock, flags);
 }
 
+static void dcp_hfi_store_caps_payload(struct dcp_hfi *hfi,
+				       struct completion *done,
+				       u8 *dst, u32 *dst_len,
+				       const struct hfi_packet_info *pkt_info,
+				       const char *name)
+{
+	u32 n;
+
+	if (!pkt_info->payload_ptr || !pkt_info->payload_size) {
+		dev_dbg(hfi->dev, "%s: empty payload\n", name);
+		return;
+	}
+
+	if (pkt_info->payload_size > DCP_HFI_CAPS_BUF_SIZE) {
+		dev_warn(hfi->dev, "%s: payload too large: %u\n",
+			 name, pkt_info->payload_size);
+		return;
+	}
+
+	n = pkt_info->payload_size;
+	memcpy(dst, pkt_info->payload_ptr, n);
+	*dst_len = n;
+	if (done)
+		complete(done);
+	dev_dbg(hfi->dev, "%s: stored %u bytes\n", name, n);
+}
+
+/* Route asynchronous events and capability packets before flag handling. */
+static bool dcp_hfi_dispatch_event(struct dcp_hfi *hfi,
+				   const struct hfi_packet_info *pkt_info)
+{
+	switch (pkt_info->cmd) {
+	case HFI_COMMAND_DISPLAY_EVENT_VSYNC:
+		return true;
+
+	case HFI_COMMAND_DISPLAY_EVENT_FRAME_SCAN_START:
+		return true;
+
+	case HFI_COMMAND_DISPLAY_EVENT_FRAME_SCAN_COMPLETE:
+		return true;
+
+	case HFI_COMMAND_DISPLAY_EVENT_HPD_STATUS:
+		return true;
+
+	case HFI_COMMAND_DISPLAY_EVENT_PANEL_DEAD:
+		dev_err(hfi->dev,
+			"DCP: panel dead display %u\n",
+			pkt_info->id & 0xFFFF);
+		return true;
+
+	case HFI_COMMAND_DISPLAY_EVENT_HW_RECOVERY:
+		dev_err(hfi->dev,
+			"DCP: HW recovery display %u\n",
+			pkt_info->id & 0xFFFF);
+		return true;
+
+	case HFI_COMMAND_DISPLAY_POWER_CONTROL: {
+		u32 display_id = pkt_info->id & 0xFFFF;
+		u32 power_mask = 0;
+		bool enable = true;
+		unsigned long flags;
+		void *power_priv;
+		void (*power_cb)(void *priv, u32 display_id,
+				 u32 power_mask, bool enable, u32 packet_id);
+
+		if (pkt_info->payload_ptr &&
+		    pkt_info->payload_size >= 2 * sizeof(u32)) {
+			const u32 *p = pkt_info->payload_ptr;
+
+			power_mask = p[0];
+			enable     = (p[1] == HFI_TRUE);
+		}
+
+		spin_lock_irqsave(&hfi->resp_drain_lock, flags);
+		power_cb = hfi->power_control_cb;
+		power_priv = hfi->power_control_priv;
+		spin_unlock_irqrestore(&hfi->resp_drain_lock, flags);
+
+		if (power_cb)
+			power_cb(power_priv, display_id, power_mask, enable,
+				 pkt_info->packet_id);
+		return true;
+	}
+
+	case HFI_COMMAND_DEVICE_INIT_DEVICE_CAPS: {
+		unsigned long flags;
+
+		spin_lock_irqsave(&hfi->caps_lock, flags);
+		dcp_hfi_store_caps_payload(hfi, &hfi->caps_cache.device_done,
+					   hfi->caps_cache.device_buf,
+					   &hfi->caps_cache.device_len,
+					   pkt_info, "DEVICE_INIT_DEVICE_CAPS");
+		spin_unlock_irqrestore(&hfi->caps_lock, flags);
+		return true;
+	}
+
+	case HFI_COMMAND_DEVICE_INIT_DISPLAY_CAPS: {
+		unsigned long flags;
+
+		spin_lock_irqsave(&hfi->caps_lock, flags);
+		dcp_hfi_store_caps_payload(hfi, &hfi->caps_cache.display_done,
+					   hfi->caps_cache.display_buf,
+					   &hfi->caps_cache.display_len,
+					   pkt_info, "DEVICE_INIT_DISPLAY_CAPS");
+		spin_unlock_irqrestore(&hfi->caps_lock, flags);
+		return true;
+	}
+
+	case HFI_COMMAND_DEVICE_INIT_VIG_CAPS: {
+		unsigned long flags;
+
+		spin_lock_irqsave(&hfi->caps_lock, flags);
+		dcp_hfi_store_caps_payload(hfi, NULL, hfi->caps_cache.vig_buf,
+					   &hfi->caps_cache.vig_len,
+					   pkt_info, "VIG_CAPS");
+		hfi->caps_cache.pipe_caps_received |= BIT(0);
+		spin_unlock_irqrestore(&hfi->caps_lock, flags);
+		return true;
+	}
+
+	case HFI_COMMAND_DEVICE_INIT_DMA_CAPS: {
+		unsigned long flags;
+
+		spin_lock_irqsave(&hfi->caps_lock, flags);
+		dcp_hfi_store_caps_payload(hfi, NULL, hfi->caps_cache.dma_buf,
+					   &hfi->caps_cache.dma_len,
+					   pkt_info, "DMA_CAPS");
+		hfi->caps_cache.pipe_caps_received |= BIT(1);
+		spin_unlock_irqrestore(&hfi->caps_lock, flags);
+		return true;
+	}
+
+	case HFI_COMMAND_DEVICE_INIT_VIG_R1_CAPS: {
+		unsigned long flags;
+
+		spin_lock_irqsave(&hfi->caps_lock, flags);
+		dcp_hfi_store_caps_payload(hfi, NULL, hfi->caps_cache.vig_r1_buf,
+					   &hfi->caps_cache.vig_r1_len,
+					   pkt_info, "VIG_R1_CAPS");
+		hfi->caps_cache.pipe_caps_received |= BIT(2);
+		spin_unlock_irqrestore(&hfi->caps_lock, flags);
+		return true;
+	}
+
+	case HFI_COMMAND_DEVICE_INIT_DMA_R1_CAPS: {
+		unsigned long flags;
+
+		spin_lock_irqsave(&hfi->caps_lock, flags);
+		dcp_hfi_store_caps_payload(hfi, NULL, hfi->caps_cache.dma_r1_buf,
+					   &hfi->caps_cache.dma_r1_len,
+					   pkt_info, "DMA_R1_CAPS");
+		hfi->caps_cache.pipe_caps_received |= BIT(3);
+		spin_unlock_irqrestore(&hfi->caps_lock, flags);
+		return true;
+	}
+
+	case HFI_COMMAND_DEVICE_INIT_COMMON_LAYER_CAPS: {
+		unsigned long flags;
+
+		spin_lock_irqsave(&hfi->caps_lock, flags);
+		hfi->caps_cache.pipe_caps_received |= BIT(4);
+		spin_unlock_irqrestore(&hfi->caps_lock, flags);
+		dev_dbg(hfi->dev,
+			"COMMON_LAYER_CAPS: received (size=%u)\n",
+			pkt_info->payload_size);
+		return true;
+	}
+
+	case HFI_COMMAND_DEVICE_INIT_DISPLAY_WB_CAPS: {
+		unsigned long flags;
+
+		spin_lock_irqsave(&hfi->caps_lock, flags);
+		hfi->caps_cache.pipe_caps_received |= BIT(5);
+		spin_unlock_irqrestore(&hfi->caps_lock, flags);
+		dev_dbg(hfi->dev,
+			"DISPLAY_WB_CAPS: received (size=%u) — all pipe caps received\n",
+			pkt_info->payload_size);
+		return true;
+	}
+
+	case HFI_COMMAND_DEVICE_CALLBACK_RESOURCE_VOTE: {
+		unsigned long vote_flags;
+		u32 payload_size = pkt_info->payload_size;
+		bool valid = pkt_info->payload_ptr && payload_size &&
+			payload_size <= DCP_HFI_RESOURCE_VOTE_BUF_SIZE &&
+			payload_size % sizeof(struct dcp_resource_vote_wire) == 0;
+
+		if (!valid) {
+			dev_warn_ratelimited(hfi->dev,
+					     "dropping malformed RESOURCE_VOTE payload size=%u max=%u\n",
+					     payload_size, DCP_HFI_RESOURCE_VOTE_BUF_SIZE);
+			payload_size = 0;
+		}
+
+		spin_lock_irqsave(&hfi->resource_vote_lock, vote_flags);
+		if (payload_size)
+			memcpy(hfi->resource_vote_buf, pkt_info->payload_ptr,
+			       payload_size);
+		hfi->resource_vote_len = payload_size;
+		hfi->resource_vote_generation++;
+		spin_unlock_irqrestore(&hfi->resource_vote_lock, vote_flags);
+
+		if (payload_size)
+			schedule_work(&hfi->resource_vote_work);
+		return true;
+	}
+
+	default:
+		return false;
+	}
+}
+
 void dcp_hfi_resp_callback(struct virtqueue *vq)
 {
 	struct dcp_drv *drv = vq->vdev->priv;
@@ -297,6 +515,8 @@ void dcp_hfi_resp_callback(struct virtqueue *vq)
 						"HFI error: cmd=0x%x pkt_id=%u\n",
 						pkt_info.cmd, pkt_info.packet_id);
 					dcp_hfi_complete_pending(hfi, &pkt_info, -EIO);
+				} else if (dcp_hfi_dispatch_event(hfi, &pkt_info)) {
+					/* Event dispatch runs before flag handling. */
 				} else if (pkt_info.flags & HFI_RX_FLAGS_SUCCESS) {
 					if (pkt_info.flags & HFI_RX_FLAGS_INFORMATION)
 						dev_dbg(hfi->dev,
@@ -639,6 +859,47 @@ int dcp_hfi_send_no_wait(struct dcp_hfi *hfi,
 			payload_type, payload, payload_size, HFI_TX_FLAGS_NONE);
 }
 
+static void dcp_hfi_resource_vote_work(struct work_struct *work)
+{
+	struct dcp_hfi *hfi = container_of(work, struct dcp_hfi,
+					     resource_vote_work);
+	u8 buf[DCP_HFI_RESOURCE_VOTE_BUF_SIZE];
+	struct dcp_resource_vote_pair pairs[DCP_HFI_RESOURCE_VOTE_BUF_SIZE /
+							 sizeof(struct dcp_resource_vote_wire)];
+	const struct dcp_resource_vote_wire *wire;
+	u32 len, generation, count, i;
+	bool dirty;
+	unsigned long flags;
+
+	do {
+		spin_lock_irqsave(&hfi->resource_vote_lock, flags);
+		len = hfi->resource_vote_len;
+		generation = hfi->resource_vote_generation;
+		if (len)
+			memcpy(buf, hfi->resource_vote_buf, len);
+		spin_unlock_irqrestore(&hfi->resource_vote_lock, flags);
+
+		if (!len || !hfi->resource_vote_cb)
+			return;
+		if (len % sizeof(struct dcp_resource_vote_wire)) {
+			dev_warn_ratelimited(hfi->dev,
+					     "dropping malformed RESOURCE_VOTE size=%u\n", len);
+			return;
+		}
+		count = len / sizeof(struct dcp_resource_vote_wire);
+		wire = (const struct dcp_resource_vote_wire *)buf;
+		for (i = 0; i < count; i++) {
+			pairs[i].key = le32_to_cpu(wire[i].key);
+			pairs[i].value = get_unaligned_le64(&wire[i].value);
+		}
+
+		hfi->resource_vote_cb(hfi->drv, pairs, count);
+		spin_lock_irqsave(&hfi->resource_vote_lock, flags);
+		dirty = generation != hfi->resource_vote_generation;
+		spin_unlock_irqrestore(&hfi->resource_vote_lock, flags);
+	} while (dirty);
+}
+
 static void dcp_hfi_free_pool(struct dcp_hfi *hfi, struct dcp_hfi_buf *pool,
 			      u32 count)
 {
@@ -726,7 +987,10 @@ int dcp_hfi_init(struct dcp_drv *drv,
 
 	spin_lock_init(&hfi->cmd_lock);
 	spin_lock_init(&hfi->pending_lock);
+	spin_lock_init(&hfi->resource_vote_lock);
 	spin_lock_init(&hfi->resp_drain_lock);
+	spin_lock_init(&hfi->caps_lock);
+	mutex_init(&hfi->caps_cache_lock);
 
 	atomic_set(&hfi->packet_id, 0);
 	atomic_set(&hfi->shutdown_in_progress, 0);
@@ -735,8 +999,11 @@ int dcp_hfi_init(struct dcp_drv *drv,
 
 	xa_init(&hfi->pending_xa);
 
+	INIT_WORK(&hfi->resource_vote_work, dcp_hfi_resource_vote_work);
 	INIT_DELAYED_WORK(&hfi->resp_repost_work, dcp_hfi_resp_repost_work);
 	INIT_LIST_HEAD(&hfi->resp_repost_list);
+	hfi->resource_vote_len = 0;
+	hfi->resource_vote_generation = 0;
 
 	hfi->cmd_pool = devm_kcalloc(hfi->dev, DCP_HFI_CMD_POOL_SIZE,
 				     sizeof(*hfi->cmd_pool), GFP_KERNEL);
@@ -784,6 +1051,7 @@ int dcp_hfi_init(struct dcp_drv *drv,
 
 err:
 	atomic_set(&hfi->shutdown_in_progress, 1);
+	cancel_work_sync(&hfi->resource_vote_work);
 	cancel_delayed_work_sync(&hfi->resp_repost_work);
 	while (virtqueue_detach_unused_buf(hfi->cmd_vq))
 		;
@@ -796,6 +1064,31 @@ int dcp_hfi_init(struct dcp_drv *drv,
 	return ret;
 }
 
+void dcp_hfi_set_power_control_cb(struct dcp_hfi *hfi, void *priv,
+				  void (*cb)(void *priv, u32 display_id,
+					     u32 power_mask, bool enable,
+					     u32 packet_id))
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&hfi->resp_drain_lock, flags);
+	hfi->power_control_priv = priv;
+	hfi->power_control_cb = cb;
+	spin_unlock_irqrestore(&hfi->resp_drain_lock, flags);
+}
+
+void dcp_hfi_clear_power_control_cb(struct dcp_hfi *hfi, void *priv)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&hfi->resp_drain_lock, flags);
+	if (hfi->power_control_priv == priv) {
+		hfi->power_control_priv = NULL;
+		hfi->power_control_cb = NULL;
+	}
+	spin_unlock_irqrestore(&hfi->resp_drain_lock, flags);
+}
+
 void dcp_hfi_stop(struct dcp_hfi *hfi)
 {
 	unsigned long flags;
@@ -804,6 +1097,7 @@ void dcp_hfi_stop(struct dcp_hfi *hfi)
 	atomic_set(&hfi->shutdown_in_progress, 1);
 	spin_unlock_irqrestore(&hfi->cmd_lock, flags);
 
+	cancel_work_sync(&hfi->resource_vote_work);
 	cancel_delayed_work_sync(&hfi->resp_repost_work);
 	dcp_hfi_cancel_pending(hfi, -ENODEV);
 }
@@ -829,6 +1123,10 @@ void dcp_hfi_quiesce_queues(struct dcp_hfi *hfi)
 
 void dcp_hfi_deinit(struct dcp_hfi *hfi)
 {
+	mutex_lock(&hfi->caps_cache_lock);
+	memset(&hfi->caps_cache, 0, sizeof(hfi->caps_cache));
+	mutex_unlock(&hfi->caps_cache_lock);
+
 	xa_destroy(&hfi->pending_xa);
 
 	dcp_hfi_free_pool(hfi, hfi->cmd_pool, DCP_HFI_CMD_POOL_SIZE);

-- 
2.43.0

