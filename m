Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814CB324B39
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 08:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763455983; cv=none; b=PXv1NlXROUYJV3Z06z6/VDVO8N324x6RS1Nowb1rnab7G92hvUbsvnytJ9IkVlR5rDBKykGNfHNAhT/1054iAqeDuyt+C1cZl1Fyq/mSjY3HXaB1OnzzjSqlhPbwbmWW5mWAE3A2avqRDeSWjKvfDh27+WPDAQQuxW1C9o7/yqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763455983; c=relaxed/simple;
	bh=DEV55TnpxC+ZAc5oDFgekUuq413l/3/UK41L3U9jZiY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jffNkPbTKZLiOyLtfNsCcB4ti5WoHn+uWDO/MaVUGisPChniYHcTDdOZtoDxYedz6wS39Gbq7R4pVPUjemTTAiWxhAlxCH/6ilookZuD2IxmLOjotiIAmdx3LOOQxH/u8w4YFOTwUFbiyIymg0c/grg3XDE/tQSqhJfcUHam/48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZuqEM5q6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HKFkyYRj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZuqEM5q6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HKFkyYRj"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI6gALN2273510
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 08:53:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gJHpFB1M0Fa2jX7zQfciXysNKzSZz/9fw/KmefWGV18=; b=ZuqEM5q6TvySaIKR
	5lCog14AuSxrpqezfJkboiAtujg9sl2IpLDzPq/IFCefNyrWj+mpQT5e5dYkkZbH
	edfYR5pIkTOel5xq5v8WH8rcxavAU4Xl3JqTeb1Sq0KubAJIQshAFxJkkGZvY527
	DYV/EPcwXYBuHLSEHRPpmFA7x48ogCl2ORCn0ISVNVoTsgijI0gwV9X895SVZ6Ym
	4JLEu9HG1Hzxx1Fy7ub5wIJDs6RRt4S7L2za9za0bb6m1uq4VDmHusCps20xfWVU
	FZvE0eUXiys73xhVMpGj+eWz4JZESZcOvt75/ppyPnhoL5HPSTaDCoIkpYkehruk
	LRYGiQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4agkrmgcap-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 08:53:00 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2955f0b8895so72412775ad.0
        for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 00:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763455979; x=1764060779; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gJHpFB1M0Fa2jX7zQfciXysNKzSZz/9fw/KmefWGV18=;
        b=HKFkyYRjzyh/BTzTGyeJOSsXgODRFLcNbAVilis0lOMdxBfpNClduw/d3QAkkqos2v
         E00HAVPNgyZZydlhs3cmCYIEYTVx4nL4kwce5XwBLQlPuZ54Jpv8dHkZYY++Yr7nHaBp
         tQ5dILrUQtPSXzh27WbBsb03wjOPgfrZcI8BQkNG9P3TwIkKpwUshan/vA3vSWyrx109
         j4oAlgcFBEWChLjB1o6Kmx12n6GmX7vIAFxOoIkH7YaXzAD9klDxxx12M1Sm69Trv1ZV
         2nVFFgZu4EEDcN5uOsy6Wa8jP6px5omLKoMCXZDgYC1Rn3QCtJAkl5Rc0mDB2yIWcbcZ
         iZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763455979; x=1764060779;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gJHpFB1M0Fa2jX7zQfciXysNKzSZz/9fw/KmefWGV18=;
        b=Sml7xiyOMHTbEbOc6Ol5Ymu1L9UXlaqs+oKd8H5JmkhUE6fobsrlzM4AQoxKIczT2o
         qo3c1ev7HvCuT9Nngk7QaY2svwsTepKjWpvHsGBwxeik8UD2VxdHWnmN2jPxCpYB5wm7
         w3nyqD06FlKIC1JutHHgmx4CIGnbJftqokVQV3Mk5IJ5mssg6Kw3Y+G050UD8B4rkl8N
         GNIRDeLpGQ7FeoaT272Ia21zvJ0hOtLPvvF+foN3Y/D61xWLD+fD/cF7bEywq0eKsrgQ
         k0GQPFfIjPitpq6LiYe8ngQRe19WzzkLAupzlL/LPkotDiV5KDkZySfq/6wJ1bCsDmBW
         +yCQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+ZbRZrKO4e0N5DzdinuHNmbTXWsWDsdlaZNDi618TVCvpdYHK7G7NND60BFUU+HwuJxcbGA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywy3wNUnT9m1/k+bohTzCEcoLiSBDiDy2srbpk9JEMdlvWBX39n
	GW2smka+h+F8qqz36BDQ3DJrUwKLLh02t7rrOgECAud+43ucz75wCfNH+l2qfKDXOdCae7Rsh2c
	xoF9LBxVWmJxVt3drcjSreULkUgwY5eAQqB6FUD7G1LW8D/dUEyiB1Z4loA==
X-Gm-Gg: ASbGncvfogt1HWvhLAVvn0L9BHlYwBOfnIvfIDGGgi9fOj+D3Ql1Uu8aFU34vbkAvEM
	FElLwbKjgFbKy/qp6G4xku8R3GgWX5W2SZ3n91Q4V/S55S1EqILMlAFa0qRRzWG8xSyJkR/MJDf
	PHWuIzj5fztMGAgVAqSd5UTSC2ua6/798g3xmFGu8YNwt/Et14aeeesiLyVdPEO4jWCsLNE/tTy
	hRuSQiWzDdfWAMimGq/kGFQ7OD85Y6h8lat+xb5CsYAolqjsvXKeWVy29p+iHKNBSnl2so2fPhF
	oYHgxowHNiLN6VrcJOe0xZY5jdP+Q/I9+9Fqb+2M8lCkRJ579HWZ/xqOv3vDgUyWMH+CDTuY0OP
	mhUToZij9OAxzxGdkl8XLRyA=
X-Received: by 2002:a17:903:1448:b0:299:d5a5:7e with SMTP id d9443c01a7336-299f5587d6dmr29425705ad.15.1763455979200;
        Tue, 18 Nov 2025 00:52:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXHTTncLm+wwNsQtax/ncNNDvvaKtLHgtViPzEistOPdMAF1zdbYET87bo4fTF9/xDBrWiLA==
X-Received: by 2002:a17:903:1448:b0:299:d5a5:7e with SMTP id d9443c01a7336-299f5587d6dmr29425335ad.15.1763455978576;
        Tue, 18 Nov 2025 00:52:58 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2568c1sm162910695ad.47.2025.11.18.00.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 00:52:58 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 18 Nov 2025 14:20:40 +0530
Subject: [PATCH v4 13/22] drm/msm/a6xx: Share dependency vote table with
 GMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-kaana-gpu-support-v4-13-86eeb8e93fb6@oss.qualcomm.com>
References: <20251118-kaana-gpu-support-v4-0-86eeb8e93fb6@oss.qualcomm.com>
In-Reply-To: <20251118-kaana-gpu-support-v4-0-86eeb8e93fb6@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Connor Abbott <cwabbott0@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763455868; l=6424;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=DEV55TnpxC+ZAc5oDFgekUuq413l/3/UK41L3U9jZiY=;
 b=Qcn9XMDdWDAliWUeS66kttJUuzO6qdmx47XxB3qQH+8k4C9wsMVO8Xz6ePGlqUJFDv5VcDd6D
 evB2LIuW67ZDt97vKaX3ciTLZsHvaQXeTY0kX0vrpmjyAbZsIQznJNf
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDA2OSBTYWx0ZWRfX4ZM5elYIMF4C
 jsTNRlIes0u4ad8STka33l2jGRM++Y20B9NQ0exYHsEn4CHBvejFK5Ro+0Nbn8qnDDqlTBV8tT3
 tMfhjkye6m7AILbG0qn51dAes64+FxG7Cty+JIkBFv1cRv2M9peuV7sXT0sIcuKYqm4jxd6O+q1
 wQGUwNkfS1VU3l2I+PcBkwPL6TqH5n8bjXB239rTCylQt8xGxFn5nElSXU6WNwFpZYnJCf2xbAE
 DyZOWRboaeVF3h10KHvfAbnwBl02mceKiT4gvbaFzpRhn3LyFjl4srujV0V7fXzZN0N/CMpGU6y
 IWQVzi8mOoTaVKfTXMxmyvTjUOo8on3cWkBMaxvsDagVRZwA/AYR0E3UKxPaWRwxUfEncheb9cb
 /XgZFj6dB1Wy41Tk9zdJQ/1+VgCWwQ==
X-Proofpoint-ORIG-GUID: selJt1Cw432v5XKi_xYMWS3_XszMlqox
X-Proofpoint-GUID: selJt1Cw432v5XKi_xYMWS3_XszMlqox
X-Authority-Analysis: v=2.4 cv=JfWxbEKV c=1 sm=1 tr=0 ts=691c33ec cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=jvJuTtenM57zLa_9FEIA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511180069

A8x GMU firmwares expect a separate vote table which describes the
relationship between the Gx rail and MxA rail (and possibly Cx rail).
Create this new vote table and implement the new HFI message which
allows passing vote tables to send this data to GMU.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 54 +++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c | 53 ++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_hfi.h | 17 +++++++++++
 4 files changed, 125 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index b76960c6d444..cede210a0a78 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1616,6 +1616,57 @@ static int a6xx_gmu_rpmh_arc_votes_init(struct device *dev, u32 *votes,
 	return 0;
 }
 
+static int a6xx_gmu_rpmh_dep_votes_init(struct device *dev, u32 *votes,
+		unsigned long *freqs, int freqs_count)
+{
+	const u16 *mx;
+	size_t count;
+
+	mx = cmd_db_read_aux_data("mx.lvl", &count);
+	if (IS_ERR(mx))
+		return PTR_ERR(mx);
+	/*
+	 * The data comes back as an array of unsigned shorts so adjust the
+	 * count accordingly
+	 */
+	count >>= 1;
+	if (!count)
+		return -EINVAL;
+
+	/* Fix the vote for zero frequency */
+	votes[0] = 0xffffffff;
+
+	/* Construct a vote for rest of the corners */
+	for (int i = 1; i < freqs_count; i++) {
+		unsigned int level = a6xx_gmu_get_arc_level(dev, freqs[i]);
+		u8 j, index = 0;
+
+		/* Get the primary index that matches the arc level */
+		for (j = 0; j < count; j++) {
+			if (mx[j] >= level) {
+				index = j;
+				break;
+			}
+		}
+
+		if (j == count) {
+			DRM_DEV_ERROR(dev,
+				      "Mx Level %u not found in the RPMh list\n",
+				      level);
+			DRM_DEV_ERROR(dev, "Available levels:\n");
+			for (j = 0; j < count; j++)
+				DRM_DEV_ERROR(dev, "  %u\n", mx[j]);
+
+			return -EINVAL;
+		}
+
+		/* Construct the vote */
+		votes[i] = (0x3fff << 14) | (index << 8) | (0xff);
+	}
+
+	return 0;
+}
+
 /*
  * The GMU votes with the RPMh for itself and on behalf of the GPU but we need
  * to construct the list of votes on the CPU and send it over. Query the RPMh
@@ -1649,6 +1700,9 @@ static int a6xx_gmu_rpmh_votes_init(struct a6xx_gmu *gmu)
 	ret |= a6xx_gmu_rpmh_arc_votes_init(gmu->dev, gmu->cx_arc_votes,
 		gmu->gmu_freqs, gmu->nr_gmu_freqs, "cx.lvl", "mx.lvl");
 
+	ret |= a6xx_gmu_rpmh_dep_votes_init(gmu->dev, gmu->dep_arc_votes,
+		gmu->gpu_freqs, gmu->nr_gpu_freqs);
+
 	/* Build the interconnect votes */
 	if (info->bcms && gmu->nr_gpu_bws > 1)
 		ret |= a6xx_gmu_rpmh_bw_votes_init(adreno_gpu, info, gmu);
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
index edf6c282cd76..2af074c8e8cf 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
@@ -97,6 +97,7 @@ struct a6xx_gmu {
 	int nr_gpu_freqs;
 	unsigned long gpu_freqs[GMU_MAX_GX_FREQS];
 	u32 gx_arc_votes[GMU_MAX_GX_FREQS];
+	u32 dep_arc_votes[GMU_MAX_GX_FREQS];
 	struct a6xx_hfi_acd_table acd_table;
 
 	int nr_gpu_bws;
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
index 206eb204cea1..53cfdf4e6c34 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
@@ -23,6 +23,7 @@ static const char * const a6xx_hfi_msg_id[] = {
 	HFI_MSG_ID(HFI_H2F_MSG_START),
 	HFI_MSG_ID(HFI_H2F_FEATURE_CTRL),
 	HFI_MSG_ID(HFI_H2F_MSG_CORE_FW_START),
+	HFI_MSG_ID(HFI_H2F_MSG_TABLE),
 	HFI_MSG_ID(HFI_H2F_MSG_GX_BW_PERF_VOTE),
 	HFI_MSG_ID(HFI_H2F_MSG_PREPARE_SLUMBER),
 };
@@ -270,11 +271,63 @@ static int a6xx_hfi_send_perf_table_v1(struct a6xx_gmu *gmu)
 		NULL, 0);
 }
 
+static int a8xx_hfi_send_perf_table(struct a6xx_gmu *gmu)
+{
+	unsigned int num_gx_votes = 3, num_cx_votes = 2;
+	struct a6xx_hfi_table_entry *entry;
+	struct a6xx_hfi_table *tbl;
+	int ret, i;
+	u32 size;
+
+	size = sizeof(*tbl) +  (2 * sizeof(tbl->entry[0])) +
+		(gmu->nr_gpu_freqs * num_gx_votes * sizeof(gmu->gx_arc_votes[0])) +
+		(gmu->nr_gmu_freqs * num_cx_votes * sizeof(gmu->cx_arc_votes[0]));
+	tbl = kzalloc(size, GFP_KERNEL);
+	tbl->type = HFI_TABLE_GPU_PERF;
+
+	/* First fill GX votes */
+	entry = &tbl->entry[0];
+	entry->count = gmu->nr_gpu_freqs;
+	entry->stride = num_gx_votes;
+
+	for (i = 0; i < gmu->nr_gpu_freqs; i++) {
+		unsigned int base = i * entry->stride;
+
+		entry->data[base+0] = gmu->gx_arc_votes[i];
+		entry->data[base+1] = gmu->dep_arc_votes[i];
+		entry->data[base+2] = gmu->gpu_freqs[i] / 1000;
+	}
+
+	/* Then fill CX votes */
+	entry = (struct a6xx_hfi_table_entry *)
+		&tbl->entry[0].data[gmu->nr_gpu_freqs * num_gx_votes];
+
+	entry->count = gmu->nr_gmu_freqs;
+	entry->stride = num_cx_votes;
+
+	for (i = 0; i < gmu->nr_gmu_freqs; i++) {
+		unsigned int base = i * entry->stride;
+
+		entry->data[base] = gmu->cx_arc_votes[i];
+		entry->data[base+1] = gmu->gmu_freqs[i] / 1000;
+	}
+
+	ret = a6xx_hfi_send_msg(gmu, HFI_H2F_MSG_TABLE, tbl, size, NULL, 0);
+
+	kfree(tbl);
+	return ret;
+}
+
 static int a6xx_hfi_send_perf_table(struct a6xx_gmu *gmu)
 {
+	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
+	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
 	struct a6xx_hfi_msg_perf_table msg = { 0 };
 	int i;
 
+	if (adreno_is_a8xx(adreno_gpu))
+		return a8xx_hfi_send_perf_table(gmu);
+
 	msg.num_gpu_levels = gmu->nr_gpu_freqs;
 	msg.num_gmu_levels = gmu->nr_gmu_freqs;
 
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.h b/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
index 653ef720e2da..6f9f74a0bc85 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
@@ -185,6 +185,23 @@ struct a6xx_hfi_msg_core_fw_start {
 	u32 handle;
 };
 
+#define HFI_H2F_MSG_TABLE 15
+
+struct a6xx_hfi_table_entry {
+	u32 count;
+	u32 stride;
+	u32 data[];
+};
+
+struct a6xx_hfi_table {
+	u32 header;
+	u32 version;
+	u32 type;
+#define HFI_TABLE_BW_VOTE 0
+#define HFI_TABLE_GPU_PERF 1
+	struct a6xx_hfi_table_entry entry[];
+};
+
 #define HFI_H2F_MSG_GX_BW_PERF_VOTE 30
 
 struct a6xx_hfi_gx_bw_perf_vote_cmd {

-- 
2.51.0

