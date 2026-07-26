Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB8C353A64
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 05:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785045112; cv=none; b=bP9IKJv9rOOdPn1kN8DhuSBQgZHj0ZHEkGaNrOwhCn3cYeaHsJX8KIW4kcAn8PsuEnqoKppIY5DoJ5L3J6/+1rdcxnqhA7Vk5XLBw2Du/wpmya1b/ZRncEa6+3tpTex1E/Ej7jPjREs92q9yfvy3N9AJgJxhG94TCNossrRk51Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785045112; c=relaxed/simple;
	bh=yra52VS1O1qkG1I7l9t/y7AcQSQcWu6Jk16V4XVt4/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GpwmRY7s7g/JVMvpNOS8Gx0NCnelfwPktJb31xCqNT7f28irVhRgIE2ND+wY5AupUjVMtZTymXNuE++5IFOmqTr751t6Ho0cBkBgzQCFVLy95hX/OLnGOUovNB8AqbCsTDJ5gzyik7JMpd79VgVjwyBhhUfEkMwJqGvdrNZHvOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UH5n4LdV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BL3VZzJP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UH5n4LdV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BL3VZzJP"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66Q5SIu63981888
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 05:51:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0SQUs4I5qKKfvh/7mjQaJqAnzd6s/3FVrnUtL0k1BpU=; b=UH5n4LdV6KVVWStU
	P7NWziaXQ1dzAiR5rezhpD2Mfgy5JRT4eVdzmIt42A3YKzrMtblvwywBKsTIpZlP
	WqeZThHffgU1gNNNeDSLqehF5RTm6ov3lqKLDrawvMNkErAiT/0rqv/wSfRtLIE0
	2zvgd78ZXgkmg59ujMxMQQ6l9E0HOjzmvLOHoo9HHMeM0eQ+0HxdSIgO8kpNroSy
	98oDR7FPR1ST1Okefkpku2UV7ZI39GrAQPvsEUcq7Ygxp9VGZ1TYLlrH9pWei/Mp
	n8gmZoG0vfmv+iFFBQmQG9/N6OjoQucjMP7RqNRewLz0EGl+wSrZ+1dILmDqSMLA
	Hs3u+Q==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmmfgte0y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 05:51:50 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84e375d9736so2369511b3a.2
        for <iommu@lists.linux.dev>; Sat, 25 Jul 2026 22:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785045109; x=1785649909; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0SQUs4I5qKKfvh/7mjQaJqAnzd6s/3FVrnUtL0k1BpU=;
        b=BL3VZzJPmz9aUhYxsiBzflbC1vdwXzQRVaBFsVMYR7sOzzWfAc24Bi343pZAK7z9Fp
         /1Kklc3NLRYESLetnCCz/Bl4zYlJgKOYKfb54aG0hSVqMM0DNtxP0ffvgi9kkEYKD/iZ
         ssoJJcKBBcKzQuvTeeOvqRse6rhwjQdVuDRge97Sz7zc9Jk4TyDw44VgupRYJXY6LFYN
         BN4Ue79Eyzr40NXi7Bu3P6oD8vgi9F4rxGXOJthV5158WYpTWMH2U5LxF29G/mQ0S45A
         05bV7x+f4oNF/J0pB8D4GEV0B7gjBiD9Mr6z6Z4K3dD1IZ9zkD5S8LWPDhy5B/AjXcF4
         IDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785045109; x=1785649909;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0SQUs4I5qKKfvh/7mjQaJqAnzd6s/3FVrnUtL0k1BpU=;
        b=Cq/kF86cYriv3GTNOn+YszQpfCCZigoYZXnmiI1pSxcKO6T3K8Xwzb4CODWK0EiPwP
         84eBeaoIgj5Rt11pEP+W6p5QQMtLmXd2yaOYQDNN1rk865W0Hc3TALRE5VD58D5yLDSo
         tKqQjg68mketR/OqtiulGlQh7dmigMreeEf91UpLqV5mI0yCuIFaaVzYZu2K9QTJFk9f
         yGrPhSAelYe5w62uFoPp2bNvUHhwUW6sHEIf2obZ3ln8/AWUijzARZjtcBKBhVdhgqze
         8R2AFoo+u5YuDWMm/HCaTtwTocYwbD87f0BwQOV3Cjxk/n+yn1Mo8vvJP/qLGwyAvrks
         YYpA==
X-Forwarded-Encrypted: i=1; AHgh+RrTS5wp+dFMGW5VkWkLDQwUehEFaMUqKZ3/51TS89j/Sb6bwmRcpZvBgpFC2FzXEIuTNc0K+g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJxYQzD8uJTKVAdzeOOAB98dH3Em/nKnU4qhLiksnOnN4BBhPa
	zJUpxdiwQqLLPoDgnWAZti27iSgA5B93FuODVFcw0PcUGoVc41vMoIcOK3kER28tBJZmct+rwvx
	Zfmi/Hvhp0Z+Fadw4YW13QSM9IOR6DazGxQ3Ig0hr+wPIgWsp7dLu1G/rvQ==
X-Gm-Gg: AR+sD10nkyMOH894xrgx+M/XTKYjA9+YxMLV0KcPSzL1YVPTY/aBLyUOxOA+ISi22iY
	ycqw4YxLDova2J0qkHB6V2K7NtDfczmyWWrZuSGFxPZnj8gp3eVpMliCRd/ZGFWkPLrD7u4dZpC
	837CdPlJItqr/gcjXou+jlDEV5Bq+3g9vQpddz+pjmxu/BUU9Ezj+kBRKJfi1nnKVmK0VDt/twn
	HXFBzdsts4zzVwKD9HlWSLIBlcdVOUhhiZZBGHvCkBeQBR+hH5NPJodTYk7BsgTUFQmXioMISqx
	dEUCNmP3/WVt5z7hNL0OfEfiGOr9wmKD3C8poRJMEDM/4IQ0ZFVZDiZj9ITK7R0csjgIseENyk3
	5OyYXnFrvZ1nVIiQfoq+fOrhCIbb0/Klwzg==
X-Received: by 2002:a05:6a21:389:b0:3c3:812a:2198 with SMTP id adf61e73a8af0-3c67d9b3db0mr4004707637.4.1785045108977;
        Sat, 25 Jul 2026 22:51:48 -0700 (PDT)
X-Received: by 2002:a05:6a21:389:b0:3c3:812a:2198 with SMTP id adf61e73a8af0-3c67d9b3db0mr4004694637.4.1785045108571;
        Sat, 25 Jul 2026 22:51:48 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130f55c6sm67106334c88.15.2026.07.25.22.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 22:51:48 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Sun, 26 Jul 2026 11:19:41 +0530
Subject: [PATCH v10 11/14] media: iris: Add hooks for pixel and non-pixel
 context banks
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260726-glymur-v10-11-de451559e88b@oss.qualcomm.com>
References: <20260726-glymur-v10-0-de451559e88b@oss.qualcomm.com>
In-Reply-To: <20260726-glymur-v10-0-de451559e88b@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Daniel J Blueman <daniel@quora.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785045024; l=2514;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=vjoXIXSIylRH2fiaYGsEYPpNKIneMt8pHF7X283MGzM=;
 b=mPYkk58CGSOUSQzXB3LCiBnaFBZA8JRcjBwQ0JXCIyx3uG5uj554SAFqQjcitU9HqICilzkoJ
 PMFhWSnbbR6C2pdLIHxZH4TYsmdGLz/WRrEIx38ZnC1r3F2ykCmLOEu
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-GUID: -387xmEdI_VTc1gu3S5F13047BD_iUhp
X-Proofpoint-ORIG-GUID: -387xmEdI_VTc1gu3S5F13047BD_iUhp
X-Authority-Analysis: v=2.4 cv=GdYnWwXL c=1 sm=1 tr=0 ts=6a65a076 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=t9ty7G3lAAAA:8 a=Ysd7Cdeu6pd1DDnCSN4A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDA1NSBTYWx0ZWRfX/6QGd+RJND0e
 D/ov7idkdT0b4U9qaZ4OOnaE2HXKkJKK3IZW0gbcamGQg5gUrllbeyCQQlqUpffsMru1JkOcQgI
 1Cuda238q7NdtUI4ve4MvelBCq+f3nw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDA1NSBTYWx0ZWRfX+0vjiCjnfZlr
 EytDA7iH2HDsTZ6VoSxE7y6PmZAlQhDD5rRRdcMsNvadnBqvtF6A2gyAI7tjB2dSi75N1z2YrER
 lklgrGeiadJTcQNqSg70bkxacTaQgV5nfYc716bFSmnCObESGp2ppRlK6dSvvai7nNDBaxZIkh5
 ZAHhLhzj7NShnR4zHVGwLxgsvRtQ7/A/nMbvxqNlbd5nPOuia4lIkC5l/D9xjkiG3NImdbE8DrI
 Hr99vZ72Owj97e/lnni9P2ZODq7P32boQQ6KllmEct4GsszVV6yoOvFr8lTJtdrPeRB6FJL+NEl
 84ZlyjD0IjbPgmh6X20Aa6ytORiGcJCsfD/tUX0/fkYBjMGB4jWOkUhke4DAma2m5AOvaYoi4fl
 ns2xOFe2aEcbpBZj+JgBHdMNKBgOu9gQc1BIYhad0SvqhJ9yTgtkGr+ZlKMr0q3j+YJG/j1CzD5
 8iAYHyQEM7b4k5ZEc0g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-26_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607260055

From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

Iris platforms use separate context-bank devices for the pixel, non-pixel
firmware domains. Add platform hooks to create and destroy those
subdevices, providing a interface for their lifecycle management across
platforms.

Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Tested-by: Daniel J Blueman <daniel@quora.org>
---
 drivers/media/platform/qcom/iris/iris_vpu3x.c | 48 +++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/media/platform/qcom/iris/iris_vpu3x.c b/drivers/media/platform/qcom/iris/iris_vpu3x.c
index ec35ad4f8610..bc95be22ed96 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu3x.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu3x.c
@@ -397,6 +397,52 @@ static u64 iris_vpu36_get_required_freq(struct iris_inst *inst)
 	return max(vcodec0_freq, vcodec1_freq);
 }
 
+static int iris_vpu3x_init_cb_devs(struct iris_core *core)
+{
+	struct device *dev;
+
+	dev = iris_create_cb_dev(core, "non-pixel");
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
+
+	core->np_dev = dev;
+
+	dev = iris_create_cb_dev(core, "pixel");
+	if (IS_ERR(dev))
+		goto unreg_np_dev;
+
+	core->p_dev = dev;
+
+	dev = iris_create_cb_dev(core, "video-firmware");
+	if (IS_ERR(dev))
+		goto unreg_p_dev;
+
+	core->fw_dev = dev;
+
+	return 0;
+
+unreg_p_dev:
+	if (core->p_dev)
+		platform_device_unregister(to_platform_device(core->p_dev));
+	core->p_dev = NULL;
+unreg_np_dev:
+	if (core->np_dev)
+		platform_device_unregister(to_platform_device(core->np_dev));
+	core->np_dev = NULL;
+
+	return PTR_ERR(dev);
+}
+
+static void iris_vpu3x_deinit_cb_devs(struct iris_core *core)
+{
+	if (core->fw_dev)
+		platform_device_unregister(to_platform_device(core->fw_dev));
+	if (core->p_dev)
+		platform_device_unregister(to_platform_device(core->p_dev));
+	if (core->np_dev)
+		platform_device_unregister(to_platform_device(core->np_dev));
+}
+
 const struct vpu_ops iris_vpu3_ops = {
 	.power_off_hw = iris_vpu3_power_off_hardware,
 	.power_on_hw = iris_vpu_power_on_hw,
@@ -435,4 +481,6 @@ const struct vpu_ops iris_vpu36_ops = {
 	.set_hwmode = iris_vpu36_set_hwmode,
 	.check_core_load = iris_vpu36_check_core_load,
 	.get_required_freq = iris_vpu36_get_required_freq,
+	.init_cb_devs = iris_vpu3x_init_cb_devs,
+	.deinit_cb_devs = iris_vpu3x_deinit_cb_devs,
 };

-- 
2.34.1

