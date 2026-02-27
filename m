Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2932E163
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 14:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772201511; cv=none; b=OOA0p++mrmXy8xmEoc8rXiNc8Jghse/Sqal+Lcgwi5y1yNowC7nVYjwRGIrveF206QEXcrueVMjpr9coo/aK8gL93mHKibgZ0nsmqgQ9hHULbyQPTu78zEXmLGTIS0pwaqaZarmKAAC8KRrxNE9HmAvqWssckSqJAVidVzlY03Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772201511; c=relaxed/simple;
	bh=RLDAzGMUWXS021KPM72oLL7GhSjlHGnGQmwf/nf+QgI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nIq2RKgUFJ9VO5++/VKbOwhuk38/MgRyp5Iie0FO5492INXrOdMsnNXrYWjynK/KsauvHaJvTclN2cMqZtoBLJ93/bXSpAwhSbWExGQq/h7y/ZDiMfdESWHh6VUx239NujnEFByIqfSwsl39WcNwy55Zr2K8OpiM4Hj0AOvIvH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZAiQczyX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jm5wWeqs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZAiQczyX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jm5wWeqs"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R9wlEU1600691
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 14:11:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=wy5SNSh1uoxccf5R0tqQwk
	0UdFuzmSmmE82o9oJpPdw=; b=ZAiQczyXoMNZQ6j4iphmappW70QUqTfkwLhZ32
	1O2eC+q/qJQIQyu6PXKhgCIWpcKbDrBqW5SXvrOylF7HAerW/qWMtqKt1IobiFEg
	ZMzRco9M8HcYsT32QmiD1BJE3xJCCyc/zhXdLsVPkKSZ3JtUQ3oLmVPOppI8DEKJ
	l6QtSbpVg7mu2djMAIRRNAwn2z7ZP5LITSD1gpbtsJ/8e6qlKaDSmHY55Ea1V7Tr
	8U8U5JF1TCIvlwUqsBOyLUkByVOw0klOiTgpF5FtjXWbXuGimUEnXwyYAvXO/S4R
	5DvFKXmoO0E+Wj/UMGxYXFUadrIGaH9lByPz111JjTUUSgXQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjt99uvmn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 14:11:48 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2add59d1a5aso7660035ad.3
        for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 06:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772201508; x=1772806308; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wy5SNSh1uoxccf5R0tqQwk0UdFuzmSmmE82o9oJpPdw=;
        b=jm5wWeqs0SDkNllooMpc7+Sobj9tq+rSxJa1V/YF4drOAqFb2oKJy2nnjLClfRSOQL
         Tn4appTI3Hp30uGH10g53bbrertQs593pwPKX1N04Mx7kONMGPnU9DxirPGzqq+G4c98
         NyHlMrcvyCzosEZKIEXdqVn88dZN23NNnmbJChS8yWC48KiyI55QVjhhHuRxKZ4fmEhR
         AJ68loNTAtgbvBsl7cNmyaPsp1D97Za6ioahCBAsZTdoncoGi/7SnC1c9UZeEZydCa9h
         bs32Xv1RWtUiIhlYv0ajFtj+q063s1w0oiYBKeuACtBLzyAzGvPWzBmg579TjSaW1eY4
         KbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772201508; x=1772806308;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wy5SNSh1uoxccf5R0tqQwk0UdFuzmSmmE82o9oJpPdw=;
        b=Zw3Q4ktBsDQZLcsQq9DAaJzk9WLHAmUoBLwFD+tw79Xc3XpUsHyCNRU/U64Mm48mtb
         FWxG/BjOuzj87KvTmZv+2iFPw1PKUELI0xgld1OVO4s1z1HM5VDf1cMHVMFwzDHhWCZw
         JobuSHr+DT2lDHgh4pe5MCGZ+92kCTyiMGSHgloGMeiomgn1qTBy2K78oSR4sEHdG6nY
         zQdGODoDJwWO6xlW6oGow9SfMq0nexXtniqNjJD9aZLNOSv7zPWNkm+Gribl8ciNGxtI
         7G3YTLdEzgytji6Az3s3wEHXaFfaboJha6HHtmGKLS3DRwFwRDrvE/Sr3ilJzCnhulA2
         EqEg==
X-Forwarded-Encrypted: i=1; AJvYcCX2fBenUs/b4pb0ND8eECzfpenfevmV7xUsWGzPked/wcMHF4MZYXtS04zRrGL+nnySHHdDVA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/sge7DZXgRR3MmGFOZR1lF/bv/ESaCdYn22PuTHU94/L+0jth
	IO5pxr1xpagmQROY2CfD7SPoLMGEc/DLg7zpbf9gjtWyWE13UNUR+W0T2WZRWGC3fn/beP7WMsX
	SEJvlQrNzwL66kPjJINRCQXFx8O8dEOerRRBDux4YFhcyzKEb3w7sBUAXJQ==
X-Gm-Gg: ATEYQzwQewcYsHrGhkQkcsXOHe0rqYEcSPn6eK++iO+sdCIpcKXsIUxUjANMkTfHqs1
	ZILVTf3r3LGIHfd0Zc6vogruer8AbX2rDHZVNqDFrqjD7OXPyq3uc0k8wB5xDYPmQIGgvQwgzEC
	ODh1xnCOTkRyfL8E1XqqR8BPxZGDEZPI8wFYzrU0FSTOpEX3CqI6+ulAjW97yxQ5spuewOV1CF/
	epVuY/E0eNY/zROdFtFrRcY7XdjMtqHhsa8aGNKdYDqbjXlnpw4B8OnRplm6CsGCHmk1I8TtCG2
	8pAdY87OvW7nVZzlWlWtDcZ8KICMj6dPr8oxHkFe5qAUXHDAXZG2ugkdmwL66FkXE7iu4cQRgdv
	NHSSXTIG+cdksG/7+WHl99K7bfWrna0oRHdO2BzRuzwJcqkyo9qjAGb+x
X-Received: by 2002:a17:903:240c:b0:2aa:d333:ce84 with SMTP id d9443c01a7336-2ae2e250953mr28576635ad.11.1772201507410;
        Fri, 27 Feb 2026 06:11:47 -0800 (PST)
X-Received: by 2002:a17:903:240c:b0:2aa:d333:ce84 with SMTP id d9443c01a7336-2ae2e250953mr28576075ad.11.1772201506643;
        Fri, 27 Feb 2026 06:11:46 -0800 (PST)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5c183bsm60960865ad.24.2026.02.27.06.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 06:11:45 -0800 (PST)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Subject: [PATCH v2 0/7] media: iris: add support for kaanapali platform
Date: Fri, 27 Feb 2026 19:41:16 +0530
Message-Id: <20260227-kaanapali-iris-v2-0-850043ac3933@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAASmoWkC/3VPy26DMBD8FeRzjWxjjEFV1f+ocljwutkkQGIT1
 Cji32ucY9XDrjSz2nk8WcRAGFlXPFnAlSLNUwLqrWDDEaZv5OQSZkooI6Qy/AwwwRUuxClQ5Kr
 1TlqNyqNm6eka0NNPFvw6vHDA2z3pLi+SjRgjZN2ueM+yKk2jla7LSrRWW8MlX+kEj+Q0ufJEy
 wKfc4zl7Q6XYR7HMq2P3a2HiHxnaOmKxhljpG0qb/paD00t27qxArRIhx5c5bRVznq25zpSXOb
 wyL1XmYP9V3GVXHBURhulTe8H+ScLO2zb9gt4hKJtSwEAAA==
X-Change-ID: 20260126-kaanapali-iris-29fd184e2fe4
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772201499; l=17886;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=RLDAzGMUWXS021KPM72oLL7GhSjlHGnGQmwf/nf+QgI=;
 b=++tqwVroluv6L39GDqR5mQ092PszY5K3gt5YAf8fUonPPzOUHbARPZO/ApmnWrCKGAzB04dnl
 MuY/rxGXdOHD7J7vnZYv7ndccgaJRd2fb+4eQGZnUcGT9pYQZWYjv9O
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Authority-Analysis: v=2.4 cv=IZWKmGqa c=1 sm=1 tr=0 ts=69a1a624 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=apL-334RAAAA:8 a=e5mUnYsNAAAA:8
 a=xUdf3jHjDDVTvoI38tsA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=eWIHaOtA_ULHaMmHwLHW:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: u91FA5f-XGYpAOCgCd7Jy8fTv6S5wrxA
X-Proofpoint-ORIG-GUID: u91FA5f-XGYpAOCgCd7Jy8fTv6S5wrxA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDEyNSBTYWx0ZWRfX2sFDAN3WrnhO
 VJEBqHSfIfCtNSRcbDvtdYKNLfxTBDA1L6I5Lm5zLurWRYrd2+aMhdjl7VvqxFdg3oAWiRIUtp5
 BpDVC8oca35DAnBz7ONk+gh6ehuHNOnQ4nJ6oKG2BQvRY5WMGyXAG112kNvlVIxgOAOfGzcgabJ
 ET2aIx4pBPEFTgnUcmsk8A38PlBLOPzPgQKclb8qW1BRDxVKvy+AU9H3RwVrmG8bAx2efJCslf5
 6SsqBFgN0KHbxtkQdOIXeKQv71qToLtLGPmPBpj/JD3nFfGVQdOPZTpl2nRAJp+PO9RbTsrRxWg
 /BXNgBv50+Muzt4FgperIEEd7kWu+hs0SrMEeUYmxEUI8lH+Yp+D30KdWiD/zfWjiYd84E9vXyI
 9h1c3xhTDte0skagijXXkSWBvrtiAhxDQQ2PGjdsYc7/fWdnJs71y4OCCLrz+Sy3Ql953GKF9iR
 48pjJjdazsjkSuT4xYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270125

Qualcomm kaanapali platform have a newer generation of video IP iris4. 
The hardware have evolved mostly with respect to higher number of power 
domains as well as multiple clock sources.

Considering iris as a client driver, it adds the handling for multiple 
stream ids from VPU via iommu-map.

This series is depend on the below series:
https://lore.kernel.org/all/20260226074245.3098486-1-vijayanand.jitta@oss.qualcomm.com/

Following patches were dropped in v2, as per the comments, and would 
be posted separately. This series depends on these patches for 
functionality.
- https://lore.kernel.org/all/20260126-kaanapali-iris-v1-2-e2646246bfc1@oss.qualcomm.com/
- https://lore.kernel.org/all/20260126-kaanapali-iris-v1-3-e2646246bfc1@oss.qualcomm.com/

Patch #4 is also posted alongwith below series. If the other series is 
picked earlier, then this patch can be dropped from this series.
https://lore.kernel.org/all/20260227-iris_sc7280_gen2_support-v2-1-7e5b13d26542@oss.qualcomm.com/

Following are the compliance and functional validation reports.

v4l2-compliance report for decoder including streaming tests:

v4l2-compliance 1.33.0-5441, 64 bits, 64-bit time_t
v4l2-compliance SHA: 4310f15610f4 2026-01-18 22:09:17

Compliance test for iris_driver device /dev/video0:

Driver Info:
        Driver name      : iris_driver
        Card type        : Iris Decoder
        Bus info         : platform:2000000.video-codec
        Driver version   : 6.19.0
        Capabilities     : 0x84204000
                Video Memory-to-Memory Multiplanar
                Streaming
                Extended Pix Format
                Device Capabilities
        Device Caps      : 0x04204000
                Video Memory-to-Memory Multiplanar
                Streaming
                Extended Pix Format
        Detected Stateful Decoder

Required ioctls:
        test VIDIOC_QUERYCAP: OK
        test invalid ioctls: OK

Allow for multiple opens:
        test second /dev/video0 open: OK
        test VIDIOC_QUERYCAP: OK
        test VIDIOC_G/S_PRIORITY: OK
        test for unlimited opens: OK

Debug ioctls:
        test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
        test VIDIOC_LOG_STATUS: OK (Not Supported)

Input ioctls:
        test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
        test VIDIOC_ENUMAUDIO: OK (Not Supported)
        test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
        test VIDIOC_G/S_AUDIO: OK (Not Supported)
        Inputs: 0 Audio Inputs: 0 Tuners: 0

Output ioctls:
        test VIDIOC_G/S_MODULATOR: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_ENUMAUDOUT: OK (Not Supported)
        test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
        test VIDIOC_G/S_AUDOUT: OK (Not Supported)
        Outputs: 0 Audio Outputs: 0 Modulators: 0

Input/Output configuration ioctls:
        test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
        test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
        test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
        test VIDIOC_G/S_EDID: OK (Not Supported)

Control ioctls:
        test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
        test VIDIOC_QUERYCTRL: OK
        test VIDIOC_G/S_CTRL: OK
        test VIDIOC_G/S/TRY_EXT_CTRLS: OK
        test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
        test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
        Standard Controls: 12 Private Controls: 0

Format ioctls:
        test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
        test VIDIOC_G/S_PARM: OK (Not Supported)
        test VIDIOC_G_FBUF: OK (Not Supported)
        test VIDIOC_G_FMT: OK
        test VIDIOC_TRY_FMT: OK
        test VIDIOC_S_FMT: OK
        test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
        test Cropping: OK
        test Composing: OK
        test Scaling: OK (Not Supported)

Codec ioctls:
        test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
        test VIDIOC_G_ENC_INDEX: OK (Not Supported)
        test VIDIOC_(TRY_)DECODER_CMD: OK

Buffer ioctls:
        test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
        test CREATE_BUFS maximum buffers: OK
        test VIDIOC_REMOVE_BUFS: OK
        test VIDIOC_EXPBUF: OK
        test Requests: OK (Not Supported)
        test blocking wait: OK

Test input 0:

Streaming ioctls:
        test read/write: OK (Not Supported)
the input file is smaller than 7077888 bytes
        Video Capture Multiplanar: Captured 465 buffers
        test MMAP (select, REQBUFS): OK
the input file is smaller than 7077888 bytes
        Video Capture Multiplanar: Captured 465 buffers
        test MMAP (epoll, REQBUFS): OK
the input file is smaller than 7077888 bytes
        Video Capture Multiplanar: Captured 465 buffers
        test MMAP (select, CREATE_BUFS): OK
the input file is smaller than 7077888 bytes
        Video Capture Multiplanar: Captured 465 buffers
        test MMAP (epoll, CREATE_BUFS): OK
        test USERPTR (select): OK (Not Supported)
        test DMABUF: Cannot test, specify --expbuf-device

Total for iris_driver device /dev/video0: 54, Succeeded: 54, Failed: 0, 
Warnings: 0

v4l2-compliance report for encoder including streaming tests:

v4l2-compliance 1.33.0-5441, 64 bits, 64-bit time_t
v4l2-compliance SHA: 4310f15610f4 2026-01-18 22:09:17

Compliance test for iris_driver device /dev/video1:

Driver Info:
        Driver name      : iris_driver
        Card type        : Iris Encoder
        Bus info         : platform:2000000.video-codec
        Driver version   : 6.19.0
        Capabilities     : 0x84204000
                Video Memory-to-Memory Multiplanar
                Streaming
                Extended Pix Format
                Device Capabilities
        Device Caps      : 0x04204000
                Video Memory-to-Memory Multiplanar
                Streaming
                Extended Pix Format
        Detected Stateful Encoder

Required ioctls:
        test VIDIOC_QUERYCAP: OK
        test invalid ioctls: OK

Allow for multiple opens:
        test second /dev/video1 open: OK
        test VIDIOC_QUERYCAP: OK
        test VIDIOC_G/S_PRIORITY: OK
        test for unlimited opens: OK

Debug ioctls:
        test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
        test VIDIOC_LOG_STATUS: OK (Not Supported)

Input ioctls:
        test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
        test VIDIOC_ENUMAUDIO: OK (Not Supported)
        test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
        test VIDIOC_G/S_AUDIO: OK (Not Supported)
        Inputs: 0 Audio Inputs: 0 Tuners: 0

Output ioctls:
        test VIDIOC_G/S_MODULATOR: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_ENUMAUDOUT: OK (Not Supported)
        test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
        test VIDIOC_G/S_AUDOUT: OK (Not Supported)
        Outputs: 0 Audio Outputs: 0 Modulators: 0

Input/Output configuration ioctls:
        test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
        test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
        test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
        test VIDIOC_G/S_EDID: OK (Not Supported)

Control ioctls:
        test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
        test VIDIOC_QUERYCTRL: OK
        test VIDIOC_G/S_CTRL: OK
        test VIDIOC_G/S/TRY_EXT_CTRLS: OK
        test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
        test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
        Standard Controls: 38 Private Controls: 0

Format ioctls:
        test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
        test VIDIOC_G/S_PARM: OK
        test VIDIOC_G_FBUF: OK (Not Supported)
        test VIDIOC_G_FMT: OK
        test VIDIOC_TRY_FMT: OK
        test VIDIOC_S_FMT: OK
        test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
        test Cropping: OK
        test Composing: OK (Not Supported)
        test Scaling: OK (Not Supported)

Codec ioctls:
        test VIDIOC_(TRY_)ENCODER_CMD: OK
        test VIDIOC_G_ENC_INDEX: OK (Not Supported)
        test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)

Buffer ioctls:
        test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
        test CREATE_BUFS maximum buffers: OK
        test VIDIOC_REMOVE_BUFS: OK
        test VIDIOC_EXPBUF: OK
        test Requests: OK (Not Supported)
        test blocking wait: OK

Test input 0:

Streaming ioctls:
        test read/write: OK (Not Supported)
        Video Capture Multiplanar: Captured 61 buffers
        test MMAP (select, REQBUFS): OK
        Video Capture Multiplanar: Captured 61 buffers
        test MMAP (epoll, REQBUFS): OK
        Video Capture Multiplanar: Captured 61 buffers
        test MMAP (select, CREATE_BUFS): OK
        Video Capture Multiplanar: Captured 61 buffers
        test MMAP (epoll, CREATE_BUFS): OK
        test USERPTR (select): OK (Not Supported)
        test DMABUF: Cannot test, specify --expbuf-device

Total for iris_driver device /dev/video1: 54, Succeeded: 54, Failed: 0, 
Warnings: 0

Fluster test report:

77/135 while testing JVT-AVC_V1 with 
GStreamer-H.264-V4L2-Gst1.0.JVT-AVC_V1

The failing tests are:
- 52 test vectors failed due to interlaced clips: Interlaced decoding is 
not supported.
- cabac_mot_fld0_full
- cabac_mot_mbaff0_full
- cabac_mot_picaff0_full
- CABREF3_Sand_D
- CAFI1_SVA_C
- CAMA1_Sony_C
- CAMA1_TOSHIBA_B
- cama1_vtc_c
- cama2_vtc_b
- CAMA3_Sand_E
- cama3_vtc_b
- CAMACI3_Sony_C
- CAMANL1_TOSHIBA_B
- CAMANL2_TOSHIBA_B
- CAMANL3_Sand_E
- CAMASL3_Sony_B
- CAMP_MOT_MBAFF_L30
- CAMP_MOT_MBAFF_L31
- CANLMA2_Sony_C
- CANLMA3_Sony_C
- CAPA1_TOSHIBA_B
- CAPAMA3_Sand_F
- cavlc_mot_fld0_full_B
- cavlc_mot_mbaff0_full_B
- cavlc_mot_picaff0_full_B
- CVCANLMA2_Sony_C
- CVFI1_Sony_D
- CVFI1_SVA_C
- CVFI2_Sony_H
- CVFI2_SVA_C
- CVMA1_Sony_D
- CVMA1_TOSHIBA_B
- CVMANL1_TOSHIBA_B
- CVMANL2_TOSHIBA_B
- CVMAPAQP3_Sony_E
- CVMAQP2_Sony_G
- CVMAQP3_Sony_D
- CVMP_MOT_FLD_L30_B
- CVNLFI1_Sony_C
- CVNLFI2_Sony_H
- CVPA1_TOSHIBA_B
- FI1_Sony_E
- MR6_BT_B
- MR7_BT_B
- MR8_BT_B
- MR9_BT_B
- Sharp_MP_Field_1_B
- Sharp_MP_Field_2_B
- Sharp_MP_Field_3_B
- Sharp_MP_PAFF_1r2
- Sharp_MP_PAFF_2r
- CVMP_MOT_FRM_L31_B

3 test case failed due to unsupported bitstream.
num_slice_groups_minus1 greater than zero is not supported.
- FM1_BT_B
- FM1_FT_E
- FM2_SVA_C

2 test case failed because SP_SLICE type is not supported.
- SP1_BT_A
- sp2_bt_b

1 test case failed due to unsupported profile.
- BA3_SVA_C

131/147 testcases passed while testing JCT-VC-HEVC_V1 with 
GStreamer-H.265-V4L2-Gst1.0

10 testcases failed due to unsupported 10 bit format.
- DBLK_A_MAIN10_VIXS_4
- INITQP_B_Main10_Sony_1
- TSUNEQBD_A_MAIN10_Technicolor_2
- WP_A_MAIN10_Toshiba_3
- WP_MAIN10_B_Toshiba_3
- WPP_A_ericsson_MAIN10_2
- WPP_B_ericsson_MAIN10_2
- WPP_C_ericsson_MAIN10_2
- WPP_E_ericsson_MAIN10_2
- WPP_F_ericsson_MAIN10_2

4 testcase failed due to unsupported resolution.
- PICSIZE_A_Bossen_1
- PICSIZE_B_Bossen_1
- WPP_D_ericsson_MAIN10_2
- WPP_D_ericsson_MAIN_2

2 testcase failed due to CRC mismatch.
- VPSSPSPPS_A_MainConcept_1
This fails with software decoder as well. Earlier discussion on this 
here https://lore.kernel.org/all/63ca375440c4ff2f55ea0aa4e19458f775552d88.camel@ndufresne.ca/

- RAP_A_docomo_6
This was discussed on bug 
https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4392
Based on above discussion, the initial error frames need to be safely 
dropped in the firmware or driver side. Client does not have the 
required logic to drop them even if marked as error.
Discussion ongoing with video firmware team on a way to handle such 
case. Note that the issue is not specific to kaanapali, and its there on 
all platforms.

235/305 testcases passed while testing VP9-TEST-VECTORS with GStreamer-VP9-V4L2-Gst1.0
64 testcases failed due to unsupported resolution
- vp90-2-02-size-08x08.webm
- vp90-2-02-size-08x10.webm
- vp90-2-02-size-08x16.webm
- vp90-2-02-size-08x18.webm
- vp90-2-02-size-08x32.webm
- vp90-2-02-size-08x34.webm
- vp90-2-02-size-08x64.webm
- vp90-2-02-size-08x66.webm
- vp90-2-02-size-10x08.webm
- vp90-2-02-size-10x10.webm
- vp90-2-02-size-10x16.webm
- vp90-2-02-size-10x18.webm
- vp90-2-02-size-10x32.webm
- vp90-2-02-size-10x34.webm
- vp90-2-02-size-10x64.webm
- vp90-2-02-size-10x66.webm
- vp90-2-02-size-16x08.webm
- vp90-2-02-size-16x10.webm
- vp90-2-02-size-16x16.webm
- vp90-2-02-size-16x18.webm
- vp90-2-02-size-16x32.webm
- vp90-2-02-size-16x34.webm
- vp90-2-02-size-16x64.webm
- vp90-2-02-size-16x66.webm
- vp90-2-02-size-18x08.webm
- vp90-2-02-size-18x10.webm
- vp90-2-02-size-18x16.webm
- vp90-2-02-size-18x18.webm
- vp90-2-02-size-18x32.webm
- vp90-2-02-size-18x34.webm
- vp90-2-02-size-18x64.webm
- vp90-2-02-size-18x66.webm
- vp90-2-02-size-32x08.webm
- vp90-2-02-size-32x10.webm
- vp90-2-02-size-32x16.webm
- vp90-2-02-size-32x18.webm
- vp90-2-02-size-32x32.webm
- vp90-2-02-size-32x34.webm
- vp90-2-02-size-32x64.webm
- vp90-2-02-size-32x66.webm
- vp90-2-02-size-34x08.webm
- vp90-2-02-size-34x10.webm
- vp90-2-02-size-34x16.webm
- vp90-2-02-size-34x18.webm
- vp90-2-02-size-34x32.webm
- vp90-2-02-size-34x34.webm
- vp90-2-02-size-34x64.webm
- vp90-2-02-size-34x66.webm
- vp90-2-02-size-64x08.webm
- vp90-2-02-size-64x10.webm
- vp90-2-02-size-64x16.webm
- vp90-2-02-size-64x18.webm
- vp90-2-02-size-64x32.webm
- vp90-2-02-size-64x34.webm
- vp90-2-02-size-64x64.webm
- vp90-2-02-size-64x66.webm
- vp90-2-02-size-66x08.webm
- vp90-2-02-size-66x10.webm
- vp90-2-02-size-66x16.webm
- vp90-2-02-size-66x18.webm
- vp90-2-02-size-66x32.webm
- vp90-2-02-size-66x34.webm
- vp90-2-02-size-66x64.webm
- vp90-2-02-size-66x66.webm

2 testcases failed due to unsupported format.
- vp91-2-04-yuv422.webm
- vp91-2-04-yuv444.webm

2 testcase failed due to unsupported resolution after DRC.
- vp90-2-21-resize_inter_320x180_5_1-2.webm
- vp90-2-21-resize_inter_320x180_7_1-2.webm

1 testcase failed with CRC mismatch.
- vp90-2-22-svc_1280x720_3.ivf
Discussion ongoing with firmware team on how to handle this case. This 
is not specific to kaanapali, and its there on all platforms.

1 testcase failed due to unsupported stream.
- vp90-2-16-intra-only.webm

Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
Changes in v2:
- Described iommu map in a better way in binding (Dmitry, Krzysztof)
- Defined the function IDs as ABI instead of hardcode numbers (Dmitry)
- Added iris vpu bus and configured callback for dma_configure (Robin)
- Remove parsing of iommu-map from driver (Robin)
- Fixed fluster issues by adding H265 line buffer calculation for vpu4
- Dropped iommu patches #2 and #3 from this series. Those would be 
posted separately (Bryan)

- Link to v1: https://lore.kernel.org/r/20260126-kaanapali-iris-v1-0-e2646246bfc1@oss.qualcomm.com

---
Vikash Garodia (7):
      media: dt-bindings: qcom-kaanapali-iris: Add kaanapali video codec binding
      media: iris: switch to hardware mode after firmware boot
      media: iris: add iris vpu bus support and register it with iommu_buses
      media: iris: add context bank devices using iommu-map
      media: iris: add helper to select context bank device
      media: iris: add iris4 specific H265 line buffer calculation
      media: iris: add platform data for kaanapali

 .../bindings/media/qcom,kaanapali-iris.yaml        | 261 +++++++++++++++++++++
 drivers/iommu/iommu.c                              |   4 +
 drivers/media/platform/qcom/iris/Makefile          |   4 +
 drivers/media/platform/qcom/iris/iris_buffer.c     |   7 +-
 drivers/media/platform/qcom/iris/iris_buffer.h     |   2 +
 drivers/media/platform/qcom/iris/iris_core.c       |   4 +
 drivers/media/platform/qcom/iris/iris_hfi_common.c |   4 +
 drivers/media/platform/qcom/iris/iris_hfi_queue.c  |  16 +-
 .../platform/qcom/iris/iris_platform_common.h      |  19 ++
 .../media/platform/qcom/iris/iris_platform_gen2.c  |  90 +++++++
 .../platform/qcom/iris/iris_platform_kaanapali.h   |  86 +++++++
 drivers/media/platform/qcom/iris/iris_probe.c      |  64 ++++-
 drivers/media/platform/qcom/iris/iris_resources.c  |  96 ++++++++
 drivers/media/platform/qcom/iris/iris_resources.h  |   3 +
 drivers/media/platform/qcom/iris/iris_vidc.c       |   4 +-
 drivers/media/platform/qcom/iris/iris_vpu2.c       |   1 +
 drivers/media/platform/qcom/iris/iris_vpu3x.c      |   9 +-
 drivers/media/platform/qcom/iris/iris_vpu4x.c      |  24 +-
 drivers/media/platform/qcom/iris/iris_vpu_buffer.c |  51 +++-
 drivers/media/platform/qcom/iris/iris_vpu_bus.c    |  32 +++
 drivers/media/platform/qcom/iris/iris_vpu_common.c |  16 +-
 drivers/media/platform/qcom/iris/iris_vpu_common.h |   3 +
 include/dt-bindings/media/qcom,iris.h              |  18 ++
 include/linux/iris_vpu_bus.h                       |  13 +
 24 files changed, 791 insertions(+), 40 deletions(-)
---
base-commit: 7d6661873f6b54c75195780a40d66bad3d482d8f
change-id: 20260126-kaanapali-iris-29fd184e2fe4
prerequisite-message-id: <20260226074245.3098486-1-vijayanand.jitta@oss.qualcomm.com>
prerequisite-patch-id: 421e3bb43ae0dbd6a1ba02acd02592d260456eb1
prerequisite-patch-id: f4b9b5e59b3d37407941f7fee05ca4996ad3d9ba
prerequisite-patch-id: 4556a2b44275b120be0faa86bde0b55593065476

Best regards,
-- 
Vikash Garodia <vikash.garodia@oss.qualcomm.com>

