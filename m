Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98B747B436
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 11:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778844208; cv=none; b=UTnxNKDycdilcs4wsbv5TWjhXkznw56T7CTycjahMAawVA+IoHhts8THz54ibcCv36Z6OoWgpAXtAMdNHyHGB0bk5t+1txXmOQyQ9IX8zZ8DnkcS4iyEd+NapU+0eC4lYEbn614bkyA9rWRI3JT59hYC1N6LInD4JdAaAtu13jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778844208; c=relaxed/simple;
	bh=9Bb2h9q5w6+07Mm+KDyCZLayJgN0dN5cfANzelCp0DE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eLS2WvAJ1nVAKo8b78Ed1NgwjPXhAJcG1gDTrfrNEIQSq6R3viSWZRwbV4QJkEx9r4SCAVQSL2Y6nhjCF9UpwobaimUtS2tAoevp4YBAR5nngzDmOosuERa2pruRoH+p9NRT/ocy0MO/1+8yRYLHwXsZmUpu7A+ZxAaRXFq4WCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o3Qgt+RD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZCkyR92G; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o3Qgt+RD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZCkyR92G"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FAX4C53199809
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 11:23:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=/4y/4nWy9RfrpkB3oPWfGY
	oT2J9I1K6Nq6He77gLxYU=; b=o3Qgt+RDzTnnrx7JZ72QIjFST23lHdv0RMpEiS
	QMJbDYH/dVLPVBF+Qb7Y6fL06Qhq9/ajh08ezZgKQMucYPlqmdz028GPAlrhJG7O
	/LPvH/JHN7vS9ZaD5x5EtDRtByZER/veyUe6Tv7eqZvOdNwyoTXsmISnaGEJG+F8
	FSpJVxGaDetgLX/0MPyA0zSnrbiubZTagPvFONY9Rv8rYPeNOUpgy4sL9y5fYm5x
	uriVL3jioTYbQSYoIa2tSa/HL929sLKC0DZQlDSnaVRQr28LHmHFjfj+QibQwYfn
	3rzgOsbxY6BXLTXoMs+aQelenjXFwynV1LNozk5iy7kDm4tw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1qtykh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 11:23:26 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3662990c03fso679579a91.0
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 04:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778844205; x=1779449005; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/4y/4nWy9RfrpkB3oPWfGYoT2J9I1K6Nq6He77gLxYU=;
        b=ZCkyR92GmDh5TsUBL91qrSEWD6Sbag8jwZjHKFY7/112WKKWv9G0aC7ppDaV3WEeIH
         tlY4HpjGr915qmjYQABmU0WrI5rgaMW0E/a7xn7SP1vM0e14i4xSzf8xKYgAmgm7qBvY
         jJypK/gnngioW7gS5c4lUK0GQAVllv4IHP2h0rTfdoUBjeU8M0RHQi1PEHowJ0ZIakho
         kfboOBcM37/Vxv7fdIL+nbgWmtxwDEPw+fOgJ+jKqAmVjEbINxHm5K3or4QmzWChoJfb
         3uh5mH434onpaQCTUjN10mE1zxnVxB9gDaC8jGpW3hLIRO+2e1/43VM3aMmMiMM9FUGH
         0NLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778844205; x=1779449005;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4y/4nWy9RfrpkB3oPWfGYoT2J9I1K6Nq6He77gLxYU=;
        b=VwkM11Hvz1JiPdwAYjcFygliGutJrooGxfvB3/3hwEBHisdSUnGuUVQUhQWkqAYf73
         IbLmc5+OxC/lbyYTRrUyM6Qmdie+5wkzeWadYkKJN07bQfIQs9lsIjopWWDtLBhgEOZu
         Ix27Gf4xsdyYmuo08SoJ6LXIQx8XlXCc9ublZKS8XknW/xd4JphMLsURvC8EKtvSo8Sk
         NuVPSh4lnzIlXQKYB2udvW3naewwzimGjf+iQoX6NyVJubgetWI/zcuRS6gX++yYHs9A
         2pIYoMCa3EzsgWBa6eLsgk6jYJCcmk1pWKQNNanGk1MnRWxz0Drqk2eIO4sY7nbq2aFF
         WhTw==
X-Forwarded-Encrypted: i=1; AFNElJ/0Bai6DpGQ7vWgRWJnlIwO9pLhMHBh6RYajNRxfUb2ShDxBpeAdW4FT8kubJQU/ZDbH4hzXw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yya9RJZcXGXbvCK7PQwiyt1lsAnt5enVjsNKa79ycJtBWPfHMyL
	bmPQCJZ1x0XYTqcYij2SMIq/rsgS7OISE3gllprxiRH7Ucw4qgGoxIIsccMjMqL+gwm9Cw4IIlF
	LvHyT7mwcWZj2Yv1AWFRHdWvfrYwdwpEzDt354NQtD6bEm065cGlNLnGaGQ==
X-Gm-Gg: Acq92OEe/ZzzjR1yTJsqRtMB40tRkN6NnUVgLlWUc5hY/4rPvxTO4jwUJv5WU2M5yCe
	Z5rsb5Lkeg3h6wcXjxD5W280TPzohxZeKOyUn34kbYZVF0QjCoLsdUTueoSSjhGQrcdyXYGu3Qg
	Yu/aNac/CxVWW7b/IXpec+IUOctsThZDssNAkV7RSl4nt+XukvxBS62tUrytEKpNIGz7pa6JXer
	5yMGrQLxUznDEV7CJVYJWE8Y9HTQCzbV2IQNIIXodehVmWuz7kD/udEL/8rpiQK7Hos9U0yK1PU
	ZeKIFAhWGXB70mFiLO9c9C6tIj0Qy2zDjz7fhpFqwuWzf/vV5bZoNoAxPsznpggF4OfJhueZuDs
	ZZtaXD/tgxMx2ZJNX//mwtjGoWob5OoyNhUM1z5nqODV4J9kHGh1BrWrXMLilE/gQYA==
X-Received: by 2002:a17:90b:3a10:b0:368:e51b:8fc3 with SMTP id 98e67ed59e1d1-369514e6830mr2763824a91.13.1778844205281;
        Fri, 15 May 2026 04:23:25 -0700 (PDT)
X-Received: by 2002:a17:90b:3a10:b0:368:e51b:8fc3 with SMTP id 98e67ed59e1d1-369514e6830mr2763788a91.13.1778844204686;
        Fri, 15 May 2026 04:23:24 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36951584654sm2476249a91.7.2026.05.15.04.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 04:23:24 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: [PATCH v6 00/14] media: iris: Add support for glymur platform
Date: Fri, 15 May 2026 16:51:15 +0530
Message-Id: <20260515-glymur-v6-0-f6a99cb43a24@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKsBB2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyzHQUlJIzE
 vPSU3UzU4B8JSMDIzMDU0NT3fScytzSIl2zVDPLpGQjU4u0JAMloOKCotS0zAqwQdGxtbUAh3V
 5tVgAAAA=
X-Change-ID: 20260515-glymur-6e69bc258fb0
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        stable@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778844197; l=20882;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=9Bb2h9q5w6+07Mm+KDyCZLayJgN0dN5cfANzelCp0DE=;
 b=ZsDxE4HIkH0nm44oo7+5dywQJU81yu/Ic2ZSeBBkXNHzj3VHbEmce1t3hQlc+pTaOn1J5OKLt
 2scxE89ooCFAGKHsRsi46f20W5fSrR6jg7CDYa7ifon+Rhr1mOvMJ5T
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Authority-Analysis: v=2.4 cv=HbkkiCE8 c=1 sm=1 tr=0 ts=6a07022e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=apL-334RAAAA:8 a=e5mUnYsNAAAA:8
 a=vz760iHb5DeATwUEMbMA:9 a=MCnWtcp10IYZZUvV:21 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=eWIHaOtA_ULHaMmHwLHW:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: Tlep7QdwMOhCZmORtX8Laybt8cGwjVSv
X-Proofpoint-ORIG-GUID: Tlep7QdwMOhCZmORtX8Laybt8cGwjVSv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDExNSBTYWx0ZWRfX0AnvrDBXGO+q
 26hJK153uemhoZqIp4BexBqNirMqAwLl9tBX5oHPRU93mrcX2bn2iG9HrypkpC5ML1023GgSAwp
 K3RHE85MtlgG3SHEyzq3uPpGNYTDmTLPaVS1nhFofNwMve1DV39AMFWextVVeP6+xu45FZDb8u+
 q+EWb+mxxUx50UMajq6lNIEjV+/qAHlLRKm/+Ul19Vw+DYRtNxSharKa94cmxvuhVSE/Ezb639+
 QB6EBGsMHcL9LUMhaa51V9RbNlkCdoIMyUlJ/MC02pwrDL664jxAnR2xFbyFAZmU8Ng1td7nx63
 BQjOxzVFjCnXLpiUc2/6nt6zTLUW9u4T6lLGigl1yahiQRPVyzcvt5+xVXpBb49hy0TiylcB6H+
 KIEsp/slOb834DXfw/Ah0gjcdwmcq7Jwbm7Yiz4TRY8UR5NqkCl5gordBzVPmyxOzt4MptCz/9G
 eOxYTb4+v/U0FCXMzOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150115

Glymur is a new generation video codec that supports dual hardware cores
along with additional power domains and clocks.

This series adds platform specific support in the iris driver to handle
the extra cores, power domains, and clock requirements introduced by
glymur. Add support for firmware loading through context bank firmware
device.

Dependencies and merge strategy:

Patch[1-2]: IOMMU maintainer need to apply and provide an immutable tag
which can merged into media tree.

Patch[3-11]: Media maintainer can pick them independently.

Patch[12]: Media maintainer can apply this once tag for patch[1-2] is available.

Patch[13-14]: Glymur iris DT node, depends on videocc.
https://lore.kernel.org/all/20260410-glymur_mmcc_dt_config_v2-v3-1-acce9d106e72@oss.qualcomm.com/

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
Changes in v6:
- Rename function names in iris_vpu_bus (Dmitry)
- Update the venus-common schema (Dmitry, Krzysztof)
- Add dual core related functions into platform specific vpu ops (Dmitry)
- Update power domain enum names (Vikash)
- Remove unused macro
- Link to v5: https://lore.kernel.org/all/20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com/

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
- lInk to v1: https://lore.kernel.org/r/20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com

---
Mukesh Ojha (1):
      media: iris: Enable Secure PAS support with IOMMU managed by Linux

Vikash Garodia (2):
      media: iris: Add iris vpu bus support
      iommu: Add iris-vpu-bus to iommu_buses

Vishnu Reddy (11):
      media: iris: Fix VM count passed to firmware
      dt-bindings: media: qcom,venus-common: Raise maxItems for clocks and power-domains
      dt-bindings: media: qcom,glymur-iris: Add glymur video codec
      media: iris: Add context bank hooks for platform specific initialization
      media: iris: Rename clock and power domain macros to use vcodec suffix
      media: iris: Use power domain type to look up pd_devs index
      media: iris: Add power sequence for Glymur
      media: iris: Add support to select core for dual core platforms
      media: iris: Add platform data for glymur
      arm64: dts: qcom: glymur: Add iris video node
      arm64: dts: qcom: glymur-crd: Enable iris video codec node

 .../bindings/media/qcom,glymur-iris.yaml           | 208 +++++++++++++++++++
 .../bindings/media/qcom,venus-common.yaml          |   8 +-
 MAINTAINERS                                        |   1 +
 arch/arm64/boot/dts/qcom/glymur-crd.dts            |   4 +
 arch/arm64/boot/dts/qcom/glymur.dtsi               | 118 +++++++++++
 drivers/iommu/iommu.c                              |   4 +
 drivers/media/platform/qcom/iris/Kconfig           |   4 +
 drivers/media/platform/qcom/iris/Makefile          |   2 +
 drivers/media/platform/qcom/iris/iris_common.c     |  10 +
 drivers/media/platform/qcom/iris/iris_common.h     |   1 +
 drivers/media/platform/qcom/iris/iris_core.h       |   9 +
 drivers/media/platform/qcom/iris/iris_firmware.c   |  73 ++++++-
 drivers/media/platform/qcom/iris/iris_hfi_common.h |   1 +
 .../platform/qcom/iris/iris_hfi_gen2_command.c     |  19 ++
 .../platform/qcom/iris/iris_hfi_gen2_defines.h     |   1 +
 drivers/media/platform/qcom/iris/iris_instance.h   |   2 +
 .../platform/qcom/iris/iris_platform_common.h      |  43 ++--
 .../platform/qcom/iris/iris_platform_glymur.c      |  98 +++++++++
 .../platform/qcom/iris/iris_platform_glymur.h      |  17 ++
 .../platform/qcom/iris/iris_platform_sc7280.h      |  10 +-
 .../platform/qcom/iris/iris_platform_sm8250.h      |   6 +-
 .../platform/qcom/iris/iris_platform_sm8550.h      |   6 +-
 .../platform/qcom/iris/iris_platform_sm8750.h      |  12 +-
 .../media/platform/qcom/iris/iris_platform_vpu2.c  |  18 +-
 .../media/platform/qcom/iris/iris_platform_vpu3x.c |  62 +++++-
 drivers/media/platform/qcom/iris/iris_power.c      |  20 +-
 drivers/media/platform/qcom/iris/iris_probe.c      |  31 ++-
 drivers/media/platform/qcom/iris/iris_resources.c  |  43 +++-
 drivers/media/platform/qcom/iris/iris_resources.h  |   6 +-
 drivers/media/platform/qcom/iris/iris_utils.c      |  58 ++++--
 drivers/media/platform/qcom/iris/iris_utils.h      |   3 +-
 drivers/media/platform/qcom/iris/iris_vb2.c        |   4 +
 drivers/media/platform/qcom/iris/iris_vidc.c       |   7 +-
 drivers/media/platform/qcom/iris/iris_vpu3x.c      | 226 +++++++++++++++++++--
 drivers/media/platform/qcom/iris/iris_vpu4x.c      | 108 +++++-----
 drivers/media/platform/qcom/iris/iris_vpu_bus.c    |  61 ++++++
 drivers/media/platform/qcom/iris/iris_vpu_common.c |  58 +++---
 drivers/media/platform/qcom/iris/iris_vpu_common.h |   3 +
 .../platform/qcom/iris/iris_vpu_register_defines.h |  10 +
 include/dt-bindings/media/qcom,glymur-iris.h       |  11 +
 include/linux/iris_vpu_bus.h                       |  25 +++
 41 files changed, 1214 insertions(+), 197 deletions(-)
---
base-commit: 93931287641b189248a512abd8045eb4440ca6e1
change-id: 20260515-glymur-6e69bc258fb0

Best regards,
-- 
Vishnu Reddy <busanna.reddy@oss.qualcomm.com>

