Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7C74503B
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 05:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776142837; cv=none; b=d65s00wPNA9+Erh4xKDw1aVncAonBEtydZ7bnNB07jTt3XSPOrPDueQWMrWXnFv+R2nhFS4t2jA2ZPWsrx/yf6q5gyTPH9O0JGRCtMz1bpSAoa1Swlm1YOXO64lDPxKQaOotD1DbQjQnAecrw7qGgWOxw6ZroEOww1ZHooKlvFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776142837; c=relaxed/simple;
	bh=syjK+wfsZtO1kX5rCepgeoW4nSKRvZKEk0MXeCCU3h4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Qx7E7xi1Xhn4indtYMjR3vVVa6cuV6EWgtip8+XXTxZv86FHTh1esg4B7xATxZe6SoaaOVPv1dA0t/RGJ2Kfjahifb/CfD3Zx/BSqTJ6Ys6FaHx6PZfon5IP3iEPrVgUNfYjspp8EIdxlMOehJUKHoy7QWGdfifIxzJEyogX6pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=el+sBlYG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kwF9dLSi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="el+sBlYG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kwF9dLSi"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DLBAuk3157263
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 05:00:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=qJoJ9PikU/Esk34g9/pgAH
	GZSX+QHgCvc+W45LxFBK8=; b=el+sBlYGkLp50eTPMHcQqTXBBzGgBJRhteKZ+G
	hAYPhPQzyhktw/W13r55cfrG4DkwXOVyXCYXoNCW+6ZhM512/zBpcuEAZ1BHBXvU
	gbGCU0a/YRCcMmmjVwNkc6xPz5jlTyPmuScCCNKQapUeJZKQV2vFmLI//Sx5BjCV
	3TkK+8M08VvfhpASRi9xneUeFQTZ0M4lyMzYYVxIldJ1yuU1Jhu37Cl4KeVpkVGa
	wf6byhC/D0XjJZm1jjOOs5tWO7ln8g8ThidvUfD13SPYUS32IogsKHOLq3a0uB+I
	ocl9YT9ofkDN1FPZEBHzAZRBRK432od74sQwCDcfbnXsBc6g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh86b91ww-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 05:00:34 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b2d0c1ead1so79878015ad.0
        for <iommu@lists.linux.dev>; Mon, 13 Apr 2026 22:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776142834; x=1776747634; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qJoJ9PikU/Esk34g9/pgAHGZSX+QHgCvc+W45LxFBK8=;
        b=kwF9dLSiN21DiwAkx4ZGxw2jaC+UkmPJGoIwWSs/Y7xRBlnZ+Y9tcaENsJ+l5AXJea
         nIgtm6fZTwUS04b/FrG1zlPooe43FCNtW4iDaPuwmP26M0vUnP3v2Qh0cro3Siousy8F
         XvT8omLUnDugBNTgnt3+OCt+gnc9o/LJsacaNJyaA7VwDOTDM/VcRcvUo71fwD0TWdPo
         TRhfZVfIYexQrcdJB5z5hkQAyC1vQFCCeK0SVeviLq9jJgQPuu/wtx2iEW8TQyPkVcQY
         0o9OXK9JQEGE30WDcRWYhPx+HxJrUpS+caWM+5fIGnLEgif1BS0QNka4cqc2+DZSv4Yu
         aBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776142834; x=1776747634;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJoJ9PikU/Esk34g9/pgAHGZSX+QHgCvc+W45LxFBK8=;
        b=VQ0shrNJN+rxixG6Uha2VIvar4LkT1oF6FV+M1ePRGhMXL+e82pe6Tha0Kg0zSs3dN
         aBe2fjOBI/yTra+CdVKx+Y1zO/rqHnk94kpqk73XxwPijdoXiSnva694nfyTI8EtoVbp
         M00deQPSY77I02KSypcE7QYEVszPR3W/aHC7fhkK1vczt0D88OeKl47x5XB4pmFZo8UF
         VwB1EHPNsOZHIm+mk8rbBnlefW9ntS/Fa8DlNLVmG637/qNcF8LUHSxN9m+d9DDea5kd
         CuTMfjVZjIDsdeDYUibKpbmpoAs28li5ItMbn7bxA1HH7kauasz4+JwsZgvBbaDJJyjo
         MNyA==
X-Forwarded-Encrypted: i=1; AFNElJ+w5BA+QO+MS+SikqZamd1wZg5m7XuVqtHCCm0/+B2XiOqdlN489LwlqUsuiKeXgc/BNm76xA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxgomDKO5iqj8cviQ3CtDCKWicxEG7uV0dh9kmS8fpCnSXtws9F
	gsfeLP2EEaDm9ZdEk0VI4izcpclMpnbqa3Yd6ZUwCxXhL83XFmDJO5IcajqIFez2k0qUeFF50KB
	gT29dZv+/9hc7owamFo4ShthQjaIziP9xn8tt6VGNQ7LhvhyS1kmjzdwE+w==
X-Gm-Gg: AeBDiev5lxKjczi14Ed14/oRpZzc3ZNK75MCuhLNsVM+wwMH7+HA8dWKhUfQDKv96yK
	caoGTkbx3fFE7d0bZJVEWBiBoNmn29Q5ZmPSzhvNn6N2Bl8aY2jgN2D7e2q8q8qwLNXJHLiGGl6
	nIOW/+U+32QesxHrJ/4J9UpWV3aPzpok4rSLsV64wxYBBNnB7E8jweVHgwITIDdFrs+Mi59YncL
	B0syPh/h+Z6W1HrD2KjTr8UDZpmdsa3aG5btwVKquvPhPW5O23//GaU1RZNZm6q5TnDvAay70FP
	LzZEzBV0IKViUcWDNfMi7QDbZTJwKZyk4LtDHPNs6YUDzUz1vW3k6iY5qhTaYraoPZU4aG8Cg+F
	WDrKrILEwcI6c+uUVBp/16UPAIQ97OUO8sjDawvZ16V+mckjMZEbuuTk=
X-Received: by 2002:a17:903:1aae:b0:2b2:4e1a:aff9 with SMTP id d9443c01a7336-2b2d5a95dc2mr162438205ad.44.1776142833470;
        Mon, 13 Apr 2026 22:00:33 -0700 (PDT)
X-Received: by 2002:a17:903:1aae:b0:2b2:4e1a:aff9 with SMTP id d9443c01a7336-2b2d5a95dc2mr162434725ad.44.1776142828010;
        Mon, 13 Apr 2026 22:00:28 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4db198asm134678425ad.3.2026.04.13.22.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 22:00:27 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: [PATCH 00/11] media: iris: Add support for glymur platform
Date: Tue, 14 Apr 2026 10:29:56 +0530
Message-Id: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMzJ3WkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEwNL3fScytzSIl1DE4PEJPPkRANLQwMloOKCotS0zAqwQdGxtbUAwQB
 FklgAAAA=
X-Change-ID: 20260409-glymur-140ab7ca0910
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
        iommu@lists.linux.dev, Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776142821; l=18045;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=syjK+wfsZtO1kX5rCepgeoW4nSKRvZKEk0MXeCCU3h4=;
 b=q1rJNbHG2+iIJZlVgzWLj4NFsHJ49YkE1qKp8QPjO+Q9kq27VpHmJ43wE+OW3IpkclIalj5/4
 yLF2Rf9oruuC5CuYRwkPo0nt3EluyetcPLZZLsUtyVpseELdgi0BYd0
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA0NSBTYWx0ZWRfX+lFydle4tqjy
 iliIA4EfJ3l0jnm7enlqoRD+Pj++SZAjSXmG1dnQYxtwpjXskInixTNu1oEWa+5US/WC6EyQktx
 ckAR/7UXtsAquLk16dFFdx1bM0f/D379+rY2uQEHmKXm+MBYVJir4gNJHM/lsmh63Q0geDvTGNA
 I/PQujYJFDVVTih3PTig9Y2q4K+G6UMG3dzdpQOmNfqpeGd6PDTudgiAfowHX1GKyuI0XQTUWbu
 Y/R4qnKgk/WtuYSHCUIHsisN3eRME/IoLL4QhafmkR4xbMu9yaxL/RdYKuXw5MoM7CiSmiaFKuR
 J1PNxhr/KBnqoicPPHZ8dbUazB63mldo40Wc+USRYn4I0esq2Ed5j0Y/K5gcxSQn1NdZ1U9F903
 EWiBeay6DjQmlPdyiX+mgmgJF1vfReQEV0l1kKMIMj2ZxEMYLvjHRJaVg1ugzbnnpfXlveT9Bxx
 yWx3i5NDHdB3TtnALig==
X-Authority-Analysis: v=2.4 cv=MahcfZ/f c=1 sm=1 tr=0 ts=69ddc9f2 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=apL-334RAAAA:8 a=e5mUnYsNAAAA:8
 a=mI4aUcGMY0OTypOOqssA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=eWIHaOtA_ULHaMmHwLHW:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: AAUmzc7ONkDOopm74k-ERGPxMIt5ucev
X-Proofpoint-GUID: AAUmzc7ONkDOopm74k-ERGPxMIt5ucev
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604140045

Glymur is a new generation video codec that supports dual hardware cores
along with additional power domains and clocks.

This series adds platform specific support in the iris driver to handle
the extra cores, power domains, and clock requirements introduced by
glymur. add support for firmware loading through context bank firmware
device.

Patch[11] is dependent on the below patch.
https://lore.kernel.org/all/20260410-glymur_mmcc_dt_config_v2-v3-1-acce9d106e72@oss.qualcomm.com/

v4l2-compliance report for decoder including streaming tests:

v4l2-compliance 1.33.0-5441, 64 bits, 64-bit time_t
v4l2-compliance SHA: 4310f15610f4 2026-01-18 22:09:17

Compliance test for iris_driver device /dev/video0:

Driver Info:
        Driver name      : iris_driver
        Card type        : Iris Decoder
        Bus info         : platform:aa00000.video-codec
        Driver version   : 7.0.0
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
        Driver version   : 7.0.0
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
Mukesh Ojha (1):
      media: iris: Enable Secure PAS support with IOMMU managed by Linux

Vikash Garodia (2):
      media: iris: Add iris vpu bus support and register it with iommu_buses
      media: iris: Add helper to create a context bank device on iris vpu bus

Vishnu Reddy (8):
      dt-bindings: media: qcom,glymur-iris: Add glymur video codec
      media: iris: Add context bank hooks for platform specific initialization
      media: iris: Fix VM count passed to firmware
      media: iris: Rename clock and power domain macros to use vcodec prefix
      media: iris: Add power sequence for Glymur
      media: iris: Add support to select core for dual core platforms
      media: iris: Add platform data for glymur
      arm64: dts: qcom: glymur: Add iris video node

 .../bindings/media/qcom,glymur-iris.yaml           | 220 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/glymur-crd.dts            |   4 +
 arch/arm64/boot/dts/qcom/glymur.dtsi               | 118 +++++++++++
 drivers/iommu/iommu.c                              |   4 +
 drivers/media/platform/qcom/iris/Makefile          |   5 +
 drivers/media/platform/qcom/iris/iris_common.c     |   7 +
 drivers/media/platform/qcom/iris/iris_core.h       |   4 +
 drivers/media/platform/qcom/iris/iris_firmware.c   |  71 ++++++-
 drivers/media/platform/qcom/iris/iris_hfi_common.h |   1 +
 .../platform/qcom/iris/iris_hfi_gen2_command.c     |  19 ++
 .../platform/qcom/iris/iris_hfi_gen2_defines.h     |   1 +
 drivers/media/platform/qcom/iris/iris_instance.h   |   2 +
 .../platform/qcom/iris/iris_platform_common.h      |  25 ++-
 .../media/platform/qcom/iris/iris_platform_gen1.c  |   6 +-
 .../media/platform/qcom/iris/iris_platform_gen2.c  | 106 +++++++++-
 .../platform/qcom/iris/iris_platform_glymur.c      |  93 +++++++++
 .../platform/qcom/iris/iris_platform_glymur.h      |  17 ++
 .../platform/qcom/iris/iris_platform_sc7280.h      |  10 +-
 .../platform/qcom/iris/iris_platform_sm8750.h      |  12 +-
 drivers/media/platform/qcom/iris/iris_probe.c      |  27 ++-
 drivers/media/platform/qcom/iris/iris_resources.c  |  33 ++++
 drivers/media/platform/qcom/iris/iris_resources.h  |   1 +
 drivers/media/platform/qcom/iris/iris_utils.c      |  68 +++++--
 drivers/media/platform/qcom/iris/iris_vpu3x.c      | 148 ++++++++++++--
 drivers/media/platform/qcom/iris/iris_vpu4x.c      |  30 +--
 drivers/media/platform/qcom/iris/iris_vpu_bus.c    |  32 +++
 drivers/media/platform/qcom/iris/iris_vpu_common.c |  36 ++--
 drivers/media/platform/qcom/iris/iris_vpu_common.h |   1 +
 .../platform/qcom/iris/iris_vpu_register_defines.h |   7 +
 include/dt-bindings/media/qcom,glymur-iris.h       |  11 ++
 include/linux/iris_vpu_bus.h                       |  13 ++
 31 files changed, 1039 insertions(+), 93 deletions(-)
---
base-commit: 1c7cc4904160c6fc6377564140062d68a3dc93a0
change-id: 20260409-glymur-140ab7ca0910

Best regards,
-- 
Vishnu Reddy <busanna.reddy@oss.qualcomm.com>

