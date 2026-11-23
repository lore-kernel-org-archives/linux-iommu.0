Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795462846;
	b=akKNXwdHJiH46Xk7EsSdwdFQBHsfNVEnpwaAB80lIF7niZkjRqjLftq/BMsqKY/wpRDd
	 zxub25U+sia45Lp4c8x8sMjxo+aU9rm9NaWC3QvAMAWGkCb1PJge3RYQinogqLmDJqXxk
	 mLAec/aHmuBRMK8paPpZg8qRQmX1+IT42brMIYUfRluna3GAPRi9gOy6XhFVLr2xH8gz0
	 nx6nBtKJZFyNzRy2fEjNqxIfB1wQGCihSHClcgjVP3iELVzlEPc1CVO73xOjfnf602+BC
	 B0ajrjwZqQuaMsDuiFelC4rOD9rpg+2mfs2RwGAbkEbb2toVlhrQXkk31N0AQI8prLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795462846;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=63/5soKOfoo4s2XYSXdk8j2rZkMsI8L/GaEuPyPYmys=;
	b=U6D+cUqo3ly4+6qZprS2U7wFYblaPrIhGtqRq0Pbu7UaRV1xD05bTRPjurSmBJvOdD3b
	 mIvsYiU+T2QISCsDTB+k4wkYjSBDw4vYrg9NatL9KvQrIzHuPXE/cAuepA4BA4u/XhM/Q
	 XMlLhiOCjMXrAeVG/nwigMO1CIQ/1CMoI8mgOVQ1FjFZMCCrRXIueBgIIeXL4l3bQPXlB
	 Kd/246zLOFIdNSOLSE78AQHF7eEsseF5LJkbd9S2Ya6EU/z3v8KeF9OsT/3ye5QpMbm5W
	 jys1ypGI1N54I9dT8Z6KKLc141b3O53qTKxfcjNU3Rdyx+8bzEjXjRO020x4JqJs1Yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=La0mMGbc;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RPdZM1Nu;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63A3606A31F
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:40:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A63A3606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=La0mMGbc;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RPdZM1Nu
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANGH33S2340403
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:40:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=63/5soKOfoo4s2XYSXdk8j2r
	ZkMsI8L/GaEuPyPYmys=; b=La0mMGbcDjyRM6KXJZm4Sev/JOtC6OOzb7kNxA7J
	iBvGE0jgSSgg+XzZ/vmXHAQjgvscl5Pn0/AQGorYnlhsTzCpuCbcS66h3yorSYZn
	cU0MIRcbKG6hQHlxVx0EzJryehosH7vGqRnOYCr9jaqxIOwA0ElkT2MFCDD9ycIq
	ccEoQ3tiyhG414G+PFhkZUdDSpWfOzsamRqBYaFGNtzV80IhPcKzch1UD17wiqCr
	wLSemY3/km6mytfTXmxEJ0bvMM71W4FmEPJblxG6RcdbmqcrU9Zkj1RikSUoQa1q
	IzNfVIEfbB9yAOfaxA2ydIaCIg0ePI+eGq/20b7NB0F0Aw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4exx3b9n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:40:45 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f2c0e6653so572973485a.1
        for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 11:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795462844; x=1796067644; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=63/5soKOfoo4s2XYSXdk8j2rZkMsI8L/GaEuPyPYmys=;
        b=RPdZM1Nu8cpsfjpn8e5kC8rvtYN/9AkPXiCT8VG4NGv0HzokGZ46+ibEpzU1zvamcS
         WHjppe90Bx2BZDTyAhGheU2ODrWlOrfj4NHMyhWxNFUPEbqtU1tAfRTd3zukOFHft3qT
         b4cISm9CNDp41WB8Okn/ZZCl3Qm7VoV3KSH2Dt6oXdvWa9XlxcmJ/+zsWnQNA85Vtd0n
         7TbssYDXGhNnFrWtRMAgZr8F2dDQyVy00EIJYdlLbINDIhRjitTN84gPQ/NeJ4r8iUoS
         duOkez/Szfgz7yupIJGM4BK+PKEtNIoF6B3lPLc+Ac4/yFE7fM8rG9xnZM1xMHDQkUdl
         HS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795462844; x=1796067644;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=63/5soKOfoo4s2XYSXdk8j2rZkMsI8L/GaEuPyPYmys=;
        b=JFU58fKK95G7V4JtFjsn1ACuLdOf6p74HLISTeDl6JGen+OSs12qYg67yI2Zk+F2Nt
         ItFG88ZhXfr6mXpvgsjRd1+psY3MPQXPH03EAuDuB4kD+muavvWdgmB8s5aRd2cuMzA8
         9RXaXrzuwLZr4kuTTa4iHcWGZeeeEJeX4XMVnb1fmeQajiLG79fmbFxL0bEEK9+Go2dD
         BpXYpkcnT2L99BCrQanSK9D+UOOfKwmw9Tp3s8O9iSTTybnRAUUHi8ms7Y3bHQCdiuRG
         c0bo05nIJoXC/h/+wdtTtmhcOHOcBp3JISKTOogr3dxODIfwgjBen01d8cdNI9DAUVZ+
         Y8YQ==
X-Forwarded-Encrypted: i=1; AL+hErF2D54dP9bUEyQBp3Mo1XU/Blm57JcsCHW3HX26Zm2iaAyAhBnmw8EIXUl9nMrxeqDEAg2sgA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+ijIZN7fSZXrGI31TTZfkDZtkXGv1YSGkcNHrCJbU17JCRY7ok
	VvqoJHvovuyWT38gfaNbS+D4F0Nggzlxvsx0/M3UgRfKLVDYqFKyM5azJRpqIR2QSijuRh12o79
	BJ6uEdtP4PC/AXFxwogrHdSJ07JK29NFCc5Rx89+90ruYHd/u8B2JJ8QjYQ==
X-Gm-Gg: AZFdTZfUcZfCdVCZBl8dZvi5EFOo/VoWIgprqJKwQsK5evKKmiCAUEOTkPmQpQH/+jf
	hEubMyPzykV2TzNhGLZ2gsPVMumF/mUiZMJx4eqogxZcrIufDvNhimhwW0BO7uSV6iSX2QizNjE
	xZg5ceXVNj6ZOZtzybXq7arSMTDsnTex7zqiB98YAtmkUiiCu7GsXhofJIOuelWJE2jK5oXAZs/
	zw4qRubMi9uBWxFQXImYIyN5R8180qiRpF1svENMkWNsyyQJCeAJnR0Tqb12iTlIBRGlzTlN3pH
	s5PfzggYF3CACI/s2CAcmBzfbMXQbF+IB4MBw+rDmTxk9SnfK5VThfxVPGaAXZei0a7Ir5t1LVt
	HyNUU2Mp9d4hwVMAP3TVuJ+4oDkt4O9IoCJhF1tsLW03LCt3hR8BS5hCgFjCKnE/P
X-Received: by 2002:a05:620a:318e:b0:93f:59b8:e28a with SMTP id af79cd13be357-949ba9b8046mr2258825985a.28.1795462843736;
        Mon, 23 Nov 2026 11:40:43 -0800 (PST)
X-Received: by 2002:a05:620a:318e:b0:93f:59b8:e28a with SMTP id af79cd13be357-949ba9b8046mr2258819585a.28.1795462843184;
        Mon, 23 Nov 2026 11:40:43 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab65cb42absm25447645f8f.1.2026.11.23.11.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 11:40:42 -0800 (PST)
Date: Mon, 23 Nov 2026 21:40:41 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH RESEND v4 10/20] arm64: dts: qcom: sc8180x: Add GEM_NOC
 interconnect for adreno SMMU
Message-ID: <izxzijllmqsw7hswyhtyir35dltvgue4ahwn56izi4ez2p2nv2@qyz5ugzrhg2y>
References: <20261120-smmu_interconnect_addition-v4-0-be30526391d9@oss.qualcomm.com>
 <20261120-smmu_interconnect_addition-v4-10-be30526391d9@oss.qualcomm.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120-smmu_interconnect_addition-v4-10-be30526391d9@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=FKKOVOos c=1 sm=1 tr=0 ts=6b0496bd cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=jAy75CqWmSRsgNc4pWAA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: ZW3Up2nNtuDzdbTKJGocT6GJpCua1z1Z
X-Proofpoint-GUID: ZW3Up2nNtuDzdbTKJGocT6GJpCua1z1Z
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfX5vRwinB8MtVz
 IORfchA/E2ZoHb66Yk54ZuLkNvNuCKjZqwpKKUn1fss1tCPBn/i/BAJyscjjQPmSKitPRTwsu7f
 +/r8zPWGxDVTWOUo14XgowsNMGhoKUQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfX9Fkp6H2gyDVf
 Zd1dGBUvqPa3QrcE7/sIcnFIMuLFQVZJb/s5WMzF1FJWJg+PNk3BWlA1x0kPg6q4Y9gz8pUnfLa
 04inHzTdn5xRzWC9lmzB8gu7Cew6qnxnJzpbejf7boQzhu+wRMBEUf2N3TeHpFQsVQvkCcqt6Fo
 HotM6iH6M/NdNn97lK7jCfLwxlD20Qf83jj0zW2Q9ND1ZfNQgrld+c7Ze/lk9pFgX76t/AIHb8H
 ge11pBmQMETzHNsDpS5AEhEAgDPArDLIicbSDubLA38xgE4U5tflw5FKFG5t1zH3mtf+1Rxby/b
 eaEMnM75uSKJkZyN08EIebHk9NuT0T+jX1WJR7aJKFp7OhLi+rGSmmBxu68SYwjRcecZBk4WopU
 w1e2igRLSL0pfkiH+rGQ4MQrav7cR0jkegE4qz2io4sV+7nsfkpcyDsj6xTQSYLGdgwx2ANzRI9
 O3kJiyDb+EYCboJ2rgQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230078

On 26-11-20 19:11:41, Bibek Kumar Patro wrote:
> On SC8180x the Adreno SMMU GPU TCU is a separate hardware block with a
> dedicated alm_gpu_tcu master port on GEM_NOC. Without an explicit
> interconnect bandwidth vote, the GEM_NOC path to DDR can be left
> unvoted during sleep/wakeup transitions, causing intermittent SMMU
> register access failures.
> 
> Add the required interconnect to ensure reliable register access.
> 
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
