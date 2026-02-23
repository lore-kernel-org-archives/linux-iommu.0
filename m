Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C362A36D4F2
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 19:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873899; cv=none; b=U3wxkgoX7FtNmdUIsDfA5SDWsBB65iSJ4Nh5JVfHbU51fmcviBfiYzOBl9k4cJW1evXDBM3qGfoJda4vfoFZzfsB6bjr+X4qpNtADyGjkNaOniyzeCGwQ4lQtml7HMc1aiMYprB1WbeWDS1KwL9uxwaX9P5raXkAy65NFx7jayU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873899; c=relaxed/simple;
	bh=Lyy5sl15dqp/AXuBfl18EdJ2b3DY11ZJbm74AYUuJlc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZZOvgQC49IkMyo5nd+DNfHcWmrp5bxfMxA3377BajjX+0s+KWFiTO3AUT0ntyaVXUzkr1XBo2OeBSJmZ/GDjZqvP+l+KmFKPCTlFO3DLqHy1+EpavZrFvKF3bN+Zbz4KPsI8SQl+QQFdDJOCBWY0tBf4wYxtO2B1xJKMbHVJ6R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pqFA/fbd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=POHlb4CG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pqFA/fbd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="POHlb4CG"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NIWYfE322188
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 19:11:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yRUzuJcFHmAaqmAyK9hpXfuGmZiOZ8PtVGzanUhu6Dk=; b=pqFA/fbd40J7GH0t
	61FyLOwfDSBvbMB0H48uB5tQBf1nMdwKyi7biOEudmKNLtZaCsHYrrY/RnXrULD4
	w4yAWFNMhi50p0mUeEzxYnRpAxzUsKqBh/pCA3yKoiiWVnVijCCw2Lr6ocNjAwS/
	yo/iHekskfL7+jZGq0dYD6AMhCUsw+aYBjxRqJigwofNqsASS6DqjbDCKDNjGeva
	ZhR57O96hFB0Ppr3UBZXQqFPhusEZciHCQ7Q0HMY+qI2KySKOkAPwz4wCWfSFwRv
	gVh0g8+HS7qHnwJT/iBLrycvZyJHCNIIhltkojxsTRyuAREntcMXPozM3Ft9BD7K
	1QpTdg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgn8y1mam-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 19:11:36 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2aad6045810so47861315ad.3
        for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 11:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771873896; x=1772478696; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yRUzuJcFHmAaqmAyK9hpXfuGmZiOZ8PtVGzanUhu6Dk=;
        b=POHlb4CGB/hV4XBtLGwqWJxjFqv3EG+G7jssAQ/UPpI90mnoM6jd91WDDXihPeQu2o
         p9roEBirsnin1VonwHfCGlN75caukImJTmqd6R59FDwlwIWSE2yfy/cdwKbP3ZO2qdka
         of1VaMzYenVrXP/j+LKoXCxGCZ0uZ4nVwL+qaE5CsTCOK/J1RgkqmqSFVDO2enit/EyD
         +E9Rvnc+1ZhT7cYLuUrHBPMCFuiwQPuclTVViNBcQQe+cqgL+oFIgCJXMlf7sHD7K9MM
         XJJff4OkQPJUkvT0d5VAXqJ9zuIabEvmmVMIZArCsXkiik9Th9watdz1ayVf9uh1sv2U
         vz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771873896; x=1772478696;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yRUzuJcFHmAaqmAyK9hpXfuGmZiOZ8PtVGzanUhu6Dk=;
        b=V526d1F3heV5MZflKkfNnGBUni8YcFH3HUaAAmQ5C6WWAEmT1fSqUaWLk+ogBzgSOv
         g6eg6nKC9qr59AY3JVTrcbQFb9vR/XSFjcU0pSLVEenPbRtOy4kzWhLizytr7EUtUeOs
         bbywP1lxTrw+f3NJj9yyTFPmOJYg9mtrg6BtHNTCsofE+BsfRTI2Y4rb+1p3mSGB9Za/
         8/uKvEnoCZPRkDHdQ1ESk0ZDINCom2a7Lz1n35y7lgmotrl8+66rBRP14rf0G/Hl9Ep0
         y/hGXfwSicViDbClu5Vnm2vE5el4d3tRJoX43DLwmSpJtumw5ATlXO8RC+tX79fAsDKH
         4Kmg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ4m5+CruoNTwiz2MvF39nSngt0NSSHc/d/uH5r/so5yUX/P8oJOX4pt/qvG/DKW1XUjpwdA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxu+d9YIN1qjGMGPuXzqWvjeA8z9mAdge5CJnKt8ChkU20lUuvU
	DfboB6hNnKeiQra8TbudCqKFNr6WbLYl+gTCsEtRgfTBrvW4tAAArEG2WzZN2BTgXE67JqvCVdc
	jCDublDl5Wsmcs5KTHugtV1DbVr5p69nciKC3HyCGUY4MEGbwqNn9YAdSnA==
X-Gm-Gg: ATEYQzyKP1giMvfEyXclbNyHnlKkJiq/v3ld+0h1ZAGmQ5YaARHIEFEsU/z3B/L8iql
	MdyGo+lhpoDPfLviRtcbCi8ymDM+/K9lQLQCplVSj5XRrU2DVumcbgWvBa+TUek6pTNH050o7V3
	1ScR5YxlxZ4lfO4pHs7BnG4t1/LgoG93tQmZdzLxehYp3KSmhmKTGnENbl2gBykxlWebJ4YwGzn
	ZIgi3VC/CelvgdDpdxZCrFve+bvCf/0Ox0XWZwLbPd3qsdmEMSM7Jzq8alAJiWYAduS8mYMeb/8
	3svqWpuVab5vdWf0wJVNbkCPJwmKyWORAbVOmm7Fx2b3Myf45J55G2EIBjBCUUMCgSFGb6eMJ2o
	1Fcs60/TZG5Do5xnUDdGfroXTvNC83m0P779xJSBvRseJ9/+ShjRm4g==
X-Received: by 2002:a17:902:db02:b0:2a5:8c1c:744f with SMTP id d9443c01a7336-2ad74525046mr99741305ad.40.1771873895865;
        Mon, 23 Feb 2026 11:11:35 -0800 (PST)
X-Received: by 2002:a17:902:db02:b0:2a5:8c1c:744f with SMTP id d9443c01a7336-2ad74525046mr99740985ad.40.1771873895387;
        Mon, 23 Feb 2026 11:11:35 -0800 (PST)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74e34e18sm83501505ad.10.2026.02.23.11.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 11:11:34 -0800 (PST)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Tue, 24 Feb 2026 00:39:12 +0530
Subject: [PATCH RFC 18/18] MAINTAINERS: Add MAINTAINERS entry for QDA
 driver
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-qda-firstpost-v1-18-fe46a9c1a046@oss.qualcomm.com>
References: <20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com>
In-Reply-To: <20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com>
To: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>,
        Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771873753; l=1237;
 i=ekansh.gupta@oss.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=Lyy5sl15dqp/AXuBfl18EdJ2b3DY11ZJbm74AYUuJlc=;
 b=U2RuZmqfnOzXIV4uEy/q/+tEABjRAyjmepjpnCpXNvRPVQEY3N8FyXUwnOR4IQspDW9EJCN6r
 /BSlCMecuL/A6nXKoi/ZCcCSKbs/ob1ERp+7UwIQROKZVvMOxgaov2G
X-Developer-Key: i=ekansh.gupta@oss.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE2NiBTYWx0ZWRfXyvedoWN+DRrm
 dIobu0ZD/q8sMkunnsDjh+2T46D4Bhs0VfxoONqBlMNXaoiw8l4+tZeZrp8OsENOtNQbsYeWeW4
 oojiA958RdgJlzjaXAOEaiq0nrQlrcG+o6Cd35IcPn3InAQUXNqnRhoTcLfjiefo1YjZw7fRB7v
 /fF2So/NVWTtYookz6D1HIwTtnmsUqTuoxQpxVlJGqFDueEVKEqpziVXT4jk+20WQG2vSrh3mzt
 EME9w1ehHGE5LegE3908ZcnZDFbbTVHLbQ6Wt4jeu54E8yShl1DfuakIfkWgea3yHyX5vtBYwYs
 +p+sED5/W+YxheJ+GrkL9L2wFcws8Ti4OHj6T72eHnj/YDBp5DJjB6hNVmg6/8GZF/ttK8sSsjz
 cksimmbLXUkRw0d2TQGAByZCyjVBEGxxNQDL/wXITieT6DACFhMXPmuExI1vDt8bhhexL5kizwW
 JHJZ4lnnoDHF6y/YfEg==
X-Authority-Analysis: v=2.4 cv=edYwvrEH c=1 sm=1 tr=0 ts=699ca668 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=e5mUnYsNAAAA:8 a=DP9mDQDU2fd_VHYdcv8A:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: J06rClnlgZFRIKwnNmLNI5e_fevGsNDf
X-Proofpoint-ORIG-GUID: J06rClnlgZFRIKwnNmLNI5e_fevGsNDf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_04,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230166

Add a new MAINTAINERS entry for the Qualcomm DSP Accelerator (QDA)
driver. The entry lists the primary maintainer, the linux-arm-msm and
dri-devel mailing lists, and covers all source files under
drivers/accel/qda, Documentation/accel/qda and the UAPI header
include/uapi/drm/qda_accel.h.

This ensures that patches to the QDA driver and its public API are
tracked and routed to the appropriate reviewers as the driver is
integrated into the DRM accel subsystem.

Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 71f76fddebbf..78b8b82a6370 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21691,6 +21691,15 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/crypto/qcom-qce.yaml
 F:	drivers/crypto/qce/
 
+QUALCOMM DSP ACCELERATOR (QDA) DRIVER
+M:	Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
+L:	linux-arm-msm@vger.kernel.org
+L:	dri-devel@lists.freedesktop.org
+S:	Supported
+F:	Documentation/accel/qda/
+F:	drivers/accel/qda/
+F:	include/uapi/drm/qda_accel.h
+
 QUALCOMM EMAC GIGABIT ETHERNET DRIVER
 M:	Timur Tabi <timur@kernel.org>
 L:	netdev@vger.kernel.org

-- 
2.34.1

