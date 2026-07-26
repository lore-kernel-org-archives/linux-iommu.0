Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE4D233924
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 05:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785045037; cv=none; b=vGNJIlVLBSsNki52qF18/FlJxqOfsK+me502vtyxz9/7Or7O+3BUziqLUBfTaMyOj4ObIve1UbhxNGf5R7cDj+K+r5VnFtJEeplv72oF/CxD+j8C6ep2SgMMYfJ0/Yu3RaH8C0m8feFI3hDHlnklTHXmtXdYPuDDr9qIGW4X1B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785045037; c=relaxed/simple;
	bh=T/iukFLFtoIeZrMrtf31EqO8Y3KZf/oRjtbBK28wfdM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bL/orkDpSGdDhyLy9kaIHexCEho20pa3V3ARC3nSIJQY504R+GHNgmu4AWA5cnKbpTgvnnm9lpvt2KVDXGDfQEM8p0WbQY3cRzRbSKBDadgD5EgsNTbn1nCyLLabWxyqq6TWE+NfWiv4SLz5VovFPPrk/93E6YHmdAAQ0m+gb0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nC+LC0Io; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZrPVTKNF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nC+LC0Io";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZrPVTKNF"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66Q5RH5c4132121
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 05:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=MonxtPBN3ThX3evGE5JnUC
	IYwo7KaJs75M7ykjTHg3g=; b=nC+LC0IovG8vAZiau5loHaR/9gmHWcNfFcgPbe
	V/8+giok5GidkUAntYvzXjkbJCI7vHdBmVDsCES8op/uExOEgC/rH3QvJSdtn09H
	YqgEzHyq8s0z6FAlF36RXNrAHTjj2UWJHDe3EHePXZankcBQATxVChHOhoZ+VShI
	jsN5ARd1Kz45uBD1WWMzKwHQgQEKq01cBAOLNRNmxGoBW6JByxBrYKImkok0IgM2
	rli069cUmQ7Hz3NPRf7O3NPnoAxkkKRVQYEvDJrZhy6/dodoJSREO93lzU2nmBuO
	+KRv2ZhM53sqm+bq8Hnso1LZ9LB32jevIrVcknqC2h/kAgvQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmmqyacp1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 05:50:33 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38ecc48b3c2so2503548a91.1
        for <iommu@lists.linux.dev>; Sat, 25 Jul 2026 22:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785045033; x=1785649833; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MonxtPBN3ThX3evGE5JnUCIYwo7KaJs75M7ykjTHg3g=;
        b=ZrPVTKNFM/gLc5hXxlqfvqivuOrQ2+3aET6jLbKQh320qpVDhvvwYDUmrYWWJLmHsX
         ONMnU9D0/QS9PFUq6F2WKzWCq0iJUk30JSy4IlSLgcJW4D7EhCloUJhfAceJ+U9G5XWq
         GHwjZNCjBFO8ieaz+p8bIe0RhmwRIBoFA/ObIo8v1fS57fMmu0StGGs50N7PUfGd9rNh
         h/6Gax8Ra+dthBdabqjaJSuVLo6rM7eRAxKO5AYJB4B41V9oeB5lNhxEK14KJYynhNu7
         DVJRvo41nn8GTyIvailiKtIa1dcS7QoYc7+b4cgIHYvEFgG33KYeb4vRnqO7Rsp8a7/j
         xDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785045033; x=1785649833;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MonxtPBN3ThX3evGE5JnUCIYwo7KaJs75M7ykjTHg3g=;
        b=GLaEGeeJiOE+3IGlE1nA6HDkibSAoHKBCbXH25htUwSEUK44xeC3TtavIUXV7piACd
         2O2yzePGbgQnWC8oIw9jTKn8Pp2bCKcGIhJFr5hb0xWoXMIt0Ky+8puxN/NLQcIuLnew
         uzn3egwpcoNKm0mLwQtUccyjSKqWVPyVprdxVzfCmNYUeofy2nBviVcxuFOGieffdw7u
         5Ifo07p95+EezoP+MkIqL0JC5I5v5WHCRl7CpFU/SrosxlgT4ON8KqRNqL6XJNiUClN2
         YJvCzaUmrI8mzJpZlAhQg9LfAz6Avq2xCBKOa+y6aHDpTDgDpLyS51oxOf70kzbdUHO5
         A6zw==
X-Forwarded-Encrypted: i=1; AHgh+RrdZqdetbikgEdAUf3tDpIuUrZZo/AxtiJd8R+W4UMog1rosUEn2UsVRCeY8PZVdwqmOmE/4Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwDLqy4pu7qXysx6m4wEX8Ss6S8SgIS9rNvBUY5vD4JtPce5Mxk
	LeOdjCwkGsqHLBCr/8990SpPoUyjcH7BLhkXMW1c41LFVFhCITcuRYeFPiq4bcY8c1OsZgJ25Z+
	GgKlw/jUV1X20snUOuLhGQwz/30Z/YUIsmlgHwhDenAaScTaP5wA/59tPaw==
X-Gm-Gg: AR+sD12IwlAGXv5niEQYrpI4nwwvMS5lhFGsq3oMJUsH6lwn+7uw/FCHtXRUFkIXieM
	4cCEM35PlzOEUamKO7rQmr1ONQZIAEZTaVD1iu1s/UF/CF1JBsGj1DCF1Wn0YvNLL4RIM0i3rc3
	zLUv+EsE8oF0V7Nzen5TMSZZKL4LRXB5tyBTIcWtzZOUanKx7TvZh93KG3ZklGqypNDyn3YGN+F
	vMmGIcpyPQYzE/oDalxBBVU/Yks3dNaCo3pdnhCGaikZEYa7h3eFhI6zCbCtSZNBHny9epkClTj
	XMLLBsvvHids/ESPq+xgQTkpl/ZMLgySBEGYDpkJkDLjn1i2RG9IaYgbFXf3tcn60H/UJWTJyIU
	6O8eRYMD31ythwPfnaJmnbLYONwfaue8avw==
X-Received: by 2002:a17:90b:39c5:b0:381:a766:efcc with SMTP id 98e67ed59e1d1-38f2950e593mr5065453a91.14.1785045032457;
        Sat, 25 Jul 2026 22:50:32 -0700 (PDT)
X-Received: by 2002:a17:90b:39c5:b0:381:a766:efcc with SMTP id 98e67ed59e1d1-38f2950e593mr5065417a91.14.1785045031756;
        Sat, 25 Jul 2026 22:50:31 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130f55c6sm67106334c88.15.2026.07.25.22.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 22:50:31 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: [PATCH v10 00/14] media: iris: Add support for glymur platform
Date: Sun, 26 Jul 2026 11:19:30 +0530
Message-Id: <20260726-glymur-v10-0-de451559e88b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOqfZWoC/3XMSw6CMBCA4auYri3plEfBlfcwLsq0xSZitRUiI
 dzdQgK60M0kM5nvH0nQ3upADruReN3bYN0tLsD2O4IXeWs0tSoeCGe8YAUD2lyHtvM0M6gyVaZ
 cI5L4fPfa2NdSOp3jfrHh6fywhHsxX9dEuiZ6QRmVRso8VwBGs6MLIXl08oqubZM4yFzqyy8Nb
 NNl1ICiqiuVg8F/uvpoAfmmq6hLNBxrDVwy8UNP0/QGd5CJrSABAAA=
X-Change-ID: 20260601-glymur-4fcd4d832ecc
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
        Daniel J Blueman <daniel@quora.org>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785045023; l=22750;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=T/iukFLFtoIeZrMrtf31EqO8Y3KZf/oRjtbBK28wfdM=;
 b=yA8iwqbFCTBhCauF7hVPpOAJ+m7pc/HF2Kxe0x8Rvba8IHX9I5/Cc+RcqNpfqT6lugMz5kM+L
 2j1onD99uofBm8slDe/Di4qPgi6zgphV2W0SuxGWdK31Rv4dEunywRw
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-ORIG-GUID: Ne9mxFpC7Ts4KJ68ydRTaSCcBuMpfCns
X-Authority-Analysis: v=2.4 cv=drbrzVg4 c=1 sm=1 tr=0 ts=6a65a02a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=apL-334RAAAA:8 a=e5mUnYsNAAAA:8
 a=bC-a23v3AAAA:8 a=hqlDjt6WuTLSZAQ4g8MA:9 a=-VUaP2y9mCMkmAfG:21
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=eWIHaOtA_ULHaMmHwLHW:22 a=Vxmtnl_E_bksehYqCbjh:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: Ne9mxFpC7Ts4KJ68ydRTaSCcBuMpfCns
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDA1NCBTYWx0ZWRfX3K5wT13K15T1
 eOltLbwHv4gOCfSunw8me7SkhNpECOAgA7CCJb7gIVmSRQRK9aT/8Yt2YGmdZxfyqInAjMhBRNc
 Qca8oYu0ZiHB9XDBpcMoEe31E5WnxM/M6qdwlM5qzOGkTgDYIGFfk6UwqXKMiFkxUp83MVbQGco
 ybb9/+xU9K9fAxeJwugA1dqC/9moOBu8iYCIfR+nzOGEN9DMyerLIBe0Btgs370zsVekK24F87z
 u+3mQRNopiq92jK/JnFD+bIyyDNUTK1oUo/NdIIS1j94WGpKLzxfis8vEZJ/VpBx2giWzAz0h4q
 btZWiWQMt3WWjox3EtqVZK88TZQIQRLGSqupQqqkypndjQsbnAThuo8SbJS/ugbsHhftsPvUAfS
 ameFJ54yAgRvksIBAXIJV+8gaQ/5b29LKgQZYoWiOGY/WyqlQ8w2mDsibJr+lCBaXzOmhcN0eIL
 5xD7+nUq7bca4AWOI2Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDA1NCBTYWx0ZWRfX8ByzVxt1lqhs
 i8kbosp6WcHVc1GBAR9PFtBu+e+vOzf29jdl6k/i6MabXKkiyom6eG1Xv7r3+KYbA7iGRAbRs1M
 DUT8aTbSR+ZM9qzZ4+7WagIYbVkMBHA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-26_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607260054

Glymur is a new generation video codec that supports dual hardware cores
along with additional power domains and clocks.
This series adds platform specific support in the iris driver to handle
the extra cores, power domains, and clock requirements introduced by
glymur. Add support for firmware loading through context bank firmware
device.
The sub node approach for representing the context banks (non-pixel,
pixel and firmware) was discussed here:
https://lore.kernel.org/all/c7b956a9-d3e8-4e18-b780-5d08f5cd2ca1@kernel.org/
Following that discussion, an RFC series migrating some existing iris
targets to this sub node approach was posted here:
https://lore.kernel.org/all/20260709-vpu_iommu_iova_handling-v1-0-72bb62cb2dfd@oss.qualcomm.com/
This glymur series also adopts the same sub node approach.

v4l2-compliance report for decoder including streaming tests:

v4l2-compliance 1.33.0-5441, 64 bits, 64-bit time_t
v4l2-compliance SHA: 4310f15610f4 2026-01-18 22:09:17

Compliance test for iris_driver device /dev/video0:

Driver Info:
        Driver name      : iris_driver
        Card type        : Iris Decoder
        Bus info         : platform:aa00000.video-codec
        Driver version   : 7.1.0
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

Total for iris_driver device /dev/video0: 54, Succeeded: 54, Failed: 0, Warnings: 0

v4l2-compliance report for encoder including streaming tests:

v4l2-compliance 1.33.0-5441, 64 bits, 64-bit time_t
v4l2-compliance SHA: 4310f15610f4 2026-01-18 22:09:17

Compliance test for iris_driver device /dev/video1:

Driver Info:
        Driver name      : iris_driver
        Card type        : Iris Encoder
        Bus info         : platform:aa00000.video-codec
        Driver version   : 7.1.0
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
        Standard Controls: 43 Private Controls: 0

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

Total for iris_driver device /dev/video1: 54, Succeeded: 54, Failed: 0, Warnings: 0

Fluster test report:

77/135 while testing JVT-AVC_V1 with 
GStreamer-H.264-V4L2-Gst1.0.JVT-AVC_V1
The failing tests are:
- 52 test vectors failed due to interlaced clips: Interlaced decoding
is not supported.
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

140/147 testcases passed while testing JCT-VC-HEVC_V1 with 
GStreamer-H.265-V4L2-Gst1.0
1 test case failed due to unsupported bitstream.
- TSUNEQBD_A_MAIN10_Technicolor_2
4 testcase failed due to unsupported resolution.
- PICSIZE_A_Bossen_1
- PICSIZE_B_Bossen_1
- WPP_D_ericsson_MAIN10_2
- WPP_D_ericsson_MAIN_2
2 testcase failed due to CRC mismatch.
- VPSSPSPPS_A_MainConcept_1
This fails with software decoder as well. Refer the below link for the
discussion happened for earlier platform.
https://lore.kernel.org/all/63ca375440c4ff2f55ea0aa4e19458f775552d88.camel@ndufresne.ca/
- RAP_A_docomo_6
This was discussed on bug report
https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4392
Based on above discussion, the initial error frames need to be dropped in
the firmware or driver. Discussion ongoing with video firmware team on a
way to handle such case. This issue is not specific to this platform, and
its there on other platforms also.

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
This VP9 bitstream contains 20 superframes, and each superframe consists
of three subframes in the following order:
• 180p subframe
• 360p subframe
• 720p subframe
Each superframe is submitted to the driver and firmware as a single input
buffer, with one common timestamp attached to it. For every such input
buffer, the hardware decoder produces three corresponding output buffers,
one for each resolution (180p, 360p, and 720p), and all three output
buffers carry the same timestamp. When these output buffers are returned
to the client (GStreamer, in this case), the first buffer returned is
displayed, while the remaining two buffers are dropped due to having
identical timestamps. As a result, only one frame per superframe is
rendered. Here the expectation of the test result is with 720p, last
decoded frame in each super frame.
Discussion ongoing with firmware team and gst maintainer on how to handle
this case. This is not specific to glymur, and its there for the other
platforms also.
1 testcase failed due to unsupported stream.
- vp90-2-16-intra-only.webm

Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
Changes in v10:
- Dropped reviewed-by tag for dt-binding patch (Krzysztof)
- Updated commit description (Bryan)
- Updated firmware name (Dmitry)
- Removed comment in dt node (Konrad)
- Fixed sashiko-bot reported issues some which are seems valid.
- Link to v9: https://patch.msgid.link/20260715-glymur-v9-0-8cf2cbe12a07@oss.qualcomm.com

Changes in v9:
- Dropped iris VPU bus patches (iris-vpu-bus support and its iommu_buses
  registration)
- The below listed patches are added, those patches are derived from the provided
  link and updated the code based on review comments:
  Link: https://lore.kernel.org/all/20260709-vpu_iommu_iova_handling-v1-0-72bb62cb2dfd@oss.qualcomm.com/
    - media: iris: Add hooks to initialize and tear down context banks
    - media: iris: Add helper to create a context bank device
    - media: iris: Add helper to select relevant context bank device
    - media: iris: Skip DMA mask setting to core device when IOMMU is not mapped
    - media: iris: Add hooks for pixel and non-pixel context banks
- Replaced the iommus and iommu-map properties with pixel, non-pixel and
  firmware context bank subnodes in dt-bindings and dtsi
- Updated the vcodec poweroff sequence with proper polling logic.
- Renamed the PAS API usage to the new qcom_pas_* API (qcom_scm_pas_* -> qcom_pas_*)
- Updated the reg address in dt node to 8 hex digits with a leading zero (Konrad)
- Link to v8: https://lore.kernel.org/r/20260610-glymur-v8-0-1c79b9d51fc0@oss.qualcomm.com

Changes in v8:
- Extracted register addresses to separate variables in power sequence (Dmitry)
- Fixed sashiko-bot reported issues some which are seems valid.
- Link to v7: https://lore.kernel.org/r/20260603-glymur-v7-0-afaa55d11fe0@oss.qualcomm.com

Changes in v7:
- Replaced enum-indexed clock and power domain tables with per-block structures (Dmitry)
- Combined venus common schema update patch and glymur video binding patch (Krzysztof)
- Updated CPU_CS_SCIACMDARG3 write value as zero specific to glymur platform (Dmitry)
- Updated the clock and reset names (Dmitry)
- Link to v6: https://lore.kernel.org/r/20260515-glymur-v6-0-f6a99cb43a24@oss.qualcomm.com

Changes in v6:
- Rename function names in iris_vpu_bus (Dmitry)
- Update the venus-common schema (Dmitry, Krzysztof)
- Add dual core related functions into platform specific vpu ops (Dmitry)
- Update power domain enum names (Vikash)
- Remove unused macro
- Link to v5: https://lore.kernel.org/r/20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com/

Changes in v5:
- Remove clocks, clock-names, power-domains from the required list in
  venus-common schema (Krzysztof)
- Update core selection logic (Vikash)
- Add macros for power status bits instead of magical values (Vikash)
- Add new config for iris vpu bus instead of using the iris driver
  config.
- Re-arrage the patches (Krzysztof)
- Link to v4: https://lore.kernel.org/r/20260505-glymur-v4-0-17571dbd1caa@oss.qualcomm.com

Changes in v4:
- Update existing venus common binding.
- Update glymur DT binding required properties.
- Patches are rebased and resolved merge conflicts.
- Link to v3: https://lore.kernel.org/r/20260428-glymur-v3-0-8f28930f47d3@oss.qualcomm.com

Changes in v3:
- Drop generic dma context bus and moved to iris vpu bus (Greg)
- Update commit message for platform data patch (Dmitry)
- Link to v2: https://lore.kernel.org/r/20260423-glymur-v2-0-0296bccb9f4e@oss.qualcomm.com

Changes in v2:
- Update the clock and reset names in DT binding (Krzysztof)
- Update firmware device names (Mukesh, Konrad)
- Update the selection of core for dual core platforms
- Add new generic dma context bus instead of own iris vpu bus (Dmitry)
- Add patch to get power domain type to look up pd_devs index
- Update glymur platform data (Dmitry)
- Link to v1: https://lore.kernel.org/r/20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com

---
Mukesh Ojha (1):
      media: iris: Enable Secure PAS support with IOMMU managed by Linux

Vikash Garodia (5):
      media: iris: Add hooks to initialize and tear down context banks
      media: iris: Add helper to create a context bank device
      media: iris: Add helper to select relevant context bank device
      media: iris: Skip DMA mask setting to core device when IOMMU is not mapped
      media: iris: Add hooks for pixel and non-pixel context banks

Vishnu Reddy (8):
      dt-bindings: media: qcom,glymur-iris: Add glymur video codec
      media: iris: Replace enum-indexed clock and power domain tables with per-block structures
      media: iris: Add power sequence for glymur
      media: iris: Handle CPU_CS_SCIACMDARG3 register write via program bootup registers hook
      media: iris: Add support to select core for dual core platforms
      media: iris: Add platform data for glymur
      arm64: dts: qcom: glymur: Add iris video node
      arm64: dts: qcom: glymur-crd: Enable iris video codec node

 .../bindings/media/qcom,glymur-iris.yaml           | 257 ++++++++++++++++++++
 .../bindings/media/qcom,venus-common.yaml          |   8 +-
 arch/arm64/boot/dts/qcom/glymur-crd.dtsi           |  10 +
 arch/arm64/boot/dts/qcom/glymur.dtsi               | 123 ++++++++++
 drivers/media/platform/qcom/iris/Makefile          |   1 +
 drivers/media/platform/qcom/iris/iris_buffer.c     |   8 +-
 drivers/media/platform/qcom/iris/iris_common.c     |  10 +
 drivers/media/platform/qcom/iris/iris_common.h     |   1 +
 drivers/media/platform/qcom/iris/iris_core.h       |  36 ++-
 drivers/media/platform/qcom/iris/iris_firmware.c   |  73 +++++-
 drivers/media/platform/qcom/iris/iris_hfi_common.h |   1 +
 .../platform/qcom/iris/iris_hfi_gen2_command.c     |  19 ++
 .../platform/qcom/iris/iris_hfi_gen2_defines.h     |   1 +
 drivers/media/platform/qcom/iris/iris_hfi_queue.c  |  16 +-
 drivers/media/platform/qcom/iris/iris_instance.h   |   2 +
 .../platform/qcom/iris/iris_platform_common.h      |  46 ++--
 .../platform/qcom/iris/iris_platform_glymur.c      |  78 ++++++
 .../platform/qcom/iris/iris_platform_glymur.h      |  15 ++
 .../platform/qcom/iris/iris_platform_sc7280.h      |  28 ++-
 .../platform/qcom/iris/iris_platform_sm8250.h      |  26 +-
 .../platform/qcom/iris/iris_platform_sm8550.h      |  26 +-
 .../platform/qcom/iris/iris_platform_sm8750.h      |  29 ++-
 .../media/platform/qcom/iris/iris_platform_vpu2.c  |  14 +-
 .../media/platform/qcom/iris/iris_platform_vpu3x.c |  67 ++++--
 .../platform/qcom/iris/iris_platform_x1p42100.h    |  27 ++-
 drivers/media/platform/qcom/iris/iris_power.c      |  20 +-
 drivers/media/platform/qcom/iris/iris_probe.c      | 171 +++++++++++--
 drivers/media/platform/qcom/iris/iris_resources.c  | 143 +++++++----
 drivers/media/platform/qcom/iris/iris_resources.h  |  10 +-
 drivers/media/platform/qcom/iris/iris_utils.c      |  58 +++--
 drivers/media/platform/qcom/iris/iris_utils.h      |   3 +-
 drivers/media/platform/qcom/iris/iris_vb2.c        |   4 +
 drivers/media/platform/qcom/iris/iris_vidc.c       |  10 +-
 drivers/media/platform/qcom/iris/iris_vpu3x.c      | 265 ++++++++++++++++++---
 drivers/media/platform/qcom/iris/iris_vpu4x.c      | 137 ++---------
 drivers/media/platform/qcom/iris/iris_vpu_common.c | 102 +-------
 drivers/media/platform/qcom/iris/iris_vpu_common.h |   5 +
 .../platform/qcom/iris/iris_vpu_register_defines.h |  13 +
 38 files changed, 1411 insertions(+), 452 deletions(-)
---
base-commit: 9eebf259d5352b87080d67758f483583d9e763d7
change-id: 20260601-glymur-4fcd4d832ecc

Best regards,
--  
Vishnu Reddy <busanna.reddy@oss.qualcomm.com>

