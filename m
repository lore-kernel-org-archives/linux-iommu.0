Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99750282F33
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 05:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776142852; cv=none; b=YuMeJzydqU7Baxj5pr6UsGU6yN60MteswP1SiZHoAP3TxwpQDVhaIkAPJJ5UBZJYSI+C1LuCh6aQsoXXSGwDMVs2iOzWmPDmwoKA4kl2wGxiHZl0CU8Mq9VWxZXzBNOC+T514RNukbv3Rw9+7G6gkV7C+N882DHo6tF1kBjMyR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776142852; c=relaxed/simple;
	bh=i6ZmiIhYyteEX9ku3DC5s4Wu1KZIwZCobr9Vm2PQ3dA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MQuVTANaG0kP0joey4A223DfR+LTsvFqKlC/5Bo4xhIqv1LtdqQ1t2qoItM4eWg8VV9FZVAkW0cc0m8A7N7+j0wjTt3mz/Rz45IQQuwGBBcYbdjmhB+77c05qqNzA8yvTwFysZiWvVgCIyKKFEm8EJgPALIQA/iqTOoBmBhzaH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gpih+3HN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iYkoClP2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gpih+3HN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iYkoClP2"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DLCi1e361811
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 05:00:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/V6Rs8rcZ7PWWMWLKnxm5Zkp3zsUGa7EcbO4a5GtxCs=; b=gpih+3HND/I+h2iI
	E0zqieeXjDHZEX5HqWtB5fFp8+ztXhjYpp+BxQA6KpiVtJsLFu266A99rfghPyA3
	CZNBXiYcpMEZ6v55ygSTZwCIEKf7WVVpZljpgWb3BB6GR5cmRBOj9AFDq02Tj96T
	9sg3iE6DqeQ/Us0bcs3pnxzMCBkeC3WnQtUs24HA8LTKMx4mxANkyBGUhWRBro5l
	Gb/kmekTcEnuS1/9ErG/er95B/PF8Z/nymCprb/dsr/aD2EuVWqf/SoYQYhpI+Vf
	QXPlClLSmJKrqjqxyrKw1FMQ+m4so/Fbk/0OTxntujLR9KOlANZGPhDmIauKCGpa
	Pa/RXg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh870s29x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 05:00:50 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b258636d16so51199245ad.2
        for <iommu@lists.linux.dev>; Mon, 13 Apr 2026 22:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776142850; x=1776747650; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/V6Rs8rcZ7PWWMWLKnxm5Zkp3zsUGa7EcbO4a5GtxCs=;
        b=iYkoClP2WZcbM7XkvSMU2MFLkWzDoJvAk1vUM6IV1458r/nGbTWE3OEKLI5Q461M/L
         Iu8wMCQhVNlx6D/qePbNyKjT3C9n2NP/1gBx6pLDYpj/1oNKnd6j7hgx9vdhVUacUToY
         dkVHt9RZaNw4k+m7xpLkLqCijOECUl4DZQ8+tmqc8lqYMktB+xu61U1X/Eb37eNh07EB
         NbzZxQrzcqBr3uYBlmk3gVgkUAWOdhh4U3SEaWPzXB/ipF87CwcBbhk/5meEW3aZxwVa
         N7HHXo1ev8W61jTybU/BeU9H8hzXjS79xVesToYGjMWAr+0KZLcnGKipn1rpFc0eMc4A
         7wRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776142850; x=1776747650;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/V6Rs8rcZ7PWWMWLKnxm5Zkp3zsUGa7EcbO4a5GtxCs=;
        b=c0pgzyfJYLC3679ju/JKKmeyTzPOIHHWjcNoKeiTwAV3IIhxMU0g0AlUEmB+ZCjgBj
         vVgYIVJXjt23AUDv8OP59yW1jtfz1NLi3rICT1sXTZ82s/fUBcVNP6sdBEx+f4Pl2+dX
         EOdo9uoRi5kMRFEM3YeV595rMY4rcE3nGYZph29Db8xvcoLiuK07Ur6x3c+YG21RpqxQ
         /1rUUuzJ+BlLh+YhDgFRvCy7mzsVyEVRbQ5gTGscx1TrtVOtamsVf8EoIHkIWgx+UXzq
         qoT9R5xzd8bbfALU1l2ZZvSTXbAZYN2kCbAw7C12PuirexdviLdz48yvDHLU5SShs1As
         RqzA==
X-Forwarded-Encrypted: i=1; AFNElJ9WMnt7SLXn9mObsCMSK77fDjqfUNi7OV6beYTsLicMhsGLdWXdAZvSHdFOCMxF2D/02rYpig==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5g3NiHR4OIYIIldScl5Kxfuc1WMlGz2CrYYUByFHTWgsABmiL
	1gTK77Q6e/p3b+fRqK4kD0BlcgLYqDb8bbWhdMYS2gUVFxAOYG/bWoE9QVPNpcgJyAVToy2YRwR
	ezIcqPl5PFg4hdot+W36B0YZKi5Un80XWMtrk7WGizohh5/vKWjcKZjcBzg==
X-Gm-Gg: AeBDieuA4B53a3vTLfay072z1zNerLKTuipPMUdXwX7QOim3LHsP3lLBDmFOCvlFqT8
	sEetcx+hDMXUEzEqQLqJrxOi+OWpM/6xUr1+3YMpgJYd0mksQWE9aIKZdvqYsJrNrSgKxbHKgUA
	B+L2YYzWQnuW+iExZxoAOqjFZmXKCUOFjY+rZG3AQSEkeVVL9344gcMPkt8W3zxy88C2ObYMrjT
	7ryNflCLQ+hbQAvTO5OP/eUfviUIdARZiKZACadTRy9Se2K1GAIK2Fh2bM5CO5EfzUf0DK62tfA
	vGwttiyXcQn1UU/IN1e08VcUlBgR40P5+vUUOD7j2z1e/Y4zCdptX1blIxqw3Fp5rV5XrWFh4L1
	ONdFh7zmVUx+UKVIPGFeDQToRDirPA5GA/Gns8BtL+uDxu5WQbiYuklI=
X-Received: by 2002:a17:903:4b0d:b0:2b2:5597:bad4 with SMTP id d9443c01a7336-2b2d5a69f1emr147908335ad.30.1776142849667;
        Mon, 13 Apr 2026 22:00:49 -0700 (PDT)
X-Received: by 2002:a17:903:4b0d:b0:2b2:5597:bad4 with SMTP id d9443c01a7336-2b2d5a69f1emr147906225ad.30.1776142846873;
        Mon, 13 Apr 2026 22:00:46 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4db198asm134678425ad.3.2026.04.13.22.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 22:00:46 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Tue, 14 Apr 2026 10:29:59 +0530
Subject: [PATCH 03/11] media: iris: Add context bank hooks for platform
 specific initialization
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-glymur-v1-3-7d3d1cf57b16@oss.qualcomm.com>
References: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
In-Reply-To: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
To: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776142821; l=3016;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=i6ZmiIhYyteEX9ku3DC5s4Wu1KZIwZCobr9Vm2PQ3dA=;
 b=+2+NbB6zm/k4yanN1JURhnrXB+oAf2ZOIVM4jw6hSDlg8urxTn2L1XRBSID6qg9Tot7pjAl7Z
 FeYY6PQsmWiBH7fqg1XPOijE2WBn/Q5eKdptaSAHhJBvzPYfJMoBCzA
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Authority-Analysis: v=2.4 cv=C9vZDwP+ c=1 sm=1 tr=0 ts=69ddca02 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=hn6c7xJugPWrWid5T_cA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA0NSBTYWx0ZWRfX0eql7xEdj1vc
 IXQBQWWvnLiGUWsJayPit85xBn9XnNxl+OJdPsaTR6pwBYurf3qT29yA5ZQlpsrIaUH4dzOJICg
 4MWidBZya+a+QikVv80aJ1Bcn8zX5CpJKZ4x25uLayBvGQb4gI1GncnSXZhhn7kccOfWTS0zpX7
 E9Biv8AfBl9TsnrMKsAhr75lY29oLfXVXIjC0ImnzLUSD20dMWmAfcqJTtypqb+NG/yu1Du56Jl
 BYhVNhT7q7bMzU9wtM4jck1JJwQprviDrHhhOrkRz6vLW3YEiMxirSl4DXdnzt8XBHnTDudrpiD
 v9aqsPJOFV7uiKURkkkG4c9s15yC4bGNNXx9mxo2rww3GWW1Yp3vgyZX+LEL5GIkWv1stWMxKhl
 hrFJeKWTr3QhLVGiAaacc6UvZscGYUmi2WRbhWFxwBcYIj9A3B6XETmcKb1lvA4Iir7GMsFWYHM
 rlqx/Oc44BBMr/GFSGA==
X-Proofpoint-GUID: PwkYl4bY_xnBRON8uRjTbQaZ5l7aJNvK
X-Proofpoint-ORIG-GUID: PwkYl4bY_xnBRON8uRjTbQaZ5l7aJNvK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1011 malwarescore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604140045

Add init and deinit hooks in the platform data for context bank setup.
These hooks allow platform specific code to initialize and tear down
context banks.

The Glymur platform requires a dedicated firmware context bank device
which is mapped to the firmware stream ID to load the firmware.

Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 .../platform/qcom/iris/iris_platform_common.h      |  2 ++
 drivers/media/platform/qcom/iris/iris_probe.c      | 23 +++++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
index 5a489917580e..55ff6137d9a9 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_common.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
@@ -219,6 +219,8 @@ struct iris_platform_data {
 	u32 (*get_vpu_buffer_size)(struct iris_inst *inst, enum iris_buffer_type buffer_type);
 	const struct vpu_ops *vpu_ops;
 	void (*set_preset_registers)(struct iris_core *core);
+	int (*init_cb_devs)(struct iris_core *core);
+	void (*deinit_cb_devs)(struct iris_core *core);
 	const struct icc_info *icc_tbl;
 	unsigned int icc_tbl_size;
 	const struct bw_info *bw_tbl_dec;
diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
index ddaacda523ec..34751912f871 100644
--- a/drivers/media/platform/qcom/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/iris/iris_probe.c
@@ -142,6 +142,20 @@ static int iris_init_resources(struct iris_core *core)
 	return iris_init_resets(core);
 }
 
+static int iris_init_cb_devs(struct iris_core *core)
+{
+	if (core->iris_platform_data->init_cb_devs)
+		return core->iris_platform_data->init_cb_devs(core);
+
+	return 0;
+}
+
+static void iris_deinit_cb_devs(struct iris_core *core)
+{
+	if (core->iris_platform_data->deinit_cb_devs)
+		core->iris_platform_data->deinit_cb_devs(core);
+}
+
 static int iris_register_video_device(struct iris_core *core, enum domain_type type)
 {
 	struct video_device *vdev;
@@ -193,6 +207,7 @@ static void iris_remove(struct platform_device *pdev)
 		return;
 
 	iris_core_deinit(core);
+	iris_deinit_cb_devs(core);
 
 	video_unregister_device(core->vdev_dec);
 	video_unregister_device(core->vdev_enc);
@@ -259,11 +274,15 @@ static int iris_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = iris_init_cb_devs(core);
+	if (ret)
+		return ret;
+
 	iris_session_init_caps(core);
 
 	ret = v4l2_device_register(dev, &core->v4l2_dev);
 	if (ret)
-		return ret;
+		goto err_deinit_cb;
 
 	ret = iris_register_video_device(core, DECODER);
 	if (ret)
@@ -298,6 +317,8 @@ static int iris_probe(struct platform_device *pdev)
 	video_unregister_device(core->vdev_dec);
 err_v4l2_unreg:
 	v4l2_device_unregister(&core->v4l2_dev);
+err_deinit_cb:
+	iris_deinit_cb_devs(core);
 
 	return ret;
 }

-- 
2.34.1

