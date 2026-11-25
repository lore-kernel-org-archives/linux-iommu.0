Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795614339;
	b=pJ6fTE+sCxdwa3o160Q1zFIRoLNJAEW58VBKTF7raMvo0rhZyRUiSyjIDMmyg3akqHP+
	 xD8mKNkOSPkdwrjOxjj1SHl1kmfzx4RqXKvGy+DrukYTC2TsyHhS1Tk+fVBgEQagNYQdx
	 /xz+59O3jX7Vz6V+x7dKK33Xv+QO93F1DDoZ+bWWUCRniS9e6PhsB+/dEl+tFNU3EAQCE
	 S08e+kLiTkfaIhjRZzdNLd8RC6UEYVityJodbGk1TTjVyKPfSOBzKa52psQ4oDXd7Mhf8
	 TKiK9JmFyGxtkMHA6zi1MMpn60zJ0ahuU6Pb8VG1Tm+0yPniVOuzKCYlfU8hfkIEy7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795614339;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=I5CcyHsjMPRsGo6MKL1jcfK65/L0dFfy3XsV56v5xI0=;
	b=1ouq/ecuM6JytBKI8eXzYZhSjY/n5B/JrmRTffi2KdJ+xddjE0wXu8Ra1aiSd79VNetI
	 KXPjvK/WYjNTAgIBtl5gFwaZI0t43QnXVPjckmQ4lrI9MbuC3oyxB6I9kOQ8uXGc+G3x2
	 URfSRG0EgU+6q2cvWZliU/Y5Xqy6VJLWPjLI1kmdIbb/rpOin3B8rdORzeKMVqZoCkPum
	 H+dKsc8YN+mldeupnDekOJdOPoOfAkgkdtOAYX06zGnohTXUIOk58v8HjIPxYB3ak2j2R
	 VtIq/g7KLdoVp3yI7DF7Zcr9uFiK2sqBYhxGrfKzrHQpAdQSRiGViafnY0D4zhPqrOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mgph49aC;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YGHymCSc;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C16606A327
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 13:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61C16606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mgph49aC;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YGHymCSc
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9mHKU4131158
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 13:45:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=I5CcyHsjMPR
	sGo6MKL1jcfK65/L0dFfy3XsV56v5xI0=; b=Mgph49aCrmkJ6eDtCJLPb1VZwwq
	213BhbodPXryHdS+JDlqE5OPay/ybzN1/8q8Uk7nBVUctMWKncZqyvko2dbKnT1q
	loTgaGadTGCh3T1E1jGzm1cQZ8kg2/+HMsmg7X7dmLypkdHY6C8z5P50OkpwhuMc
	HJp1lbH0tIrMG0og9wDGbthSO3IUqjhXO9jc4KBCODXwgK0Wm7I33zXDnN3M8doP
	EbLfyMNKIKk8o4Lf1/RwwYMLFxfnbGbY6zVKKafSljQiWxk8oRGXUb8UJKAX6v9J
	7RxqjJQH4BefAAZTqsNYC9PRUMgW3fclDU474NI0HrSHnfu3IoR+Fy2cWNg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5vuhs3gc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 13:45:38 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3847a8f4e77so795725eec.1
        for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 05:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795614337; x=1796219137; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I5CcyHsjMPRsGo6MKL1jcfK65/L0dFfy3XsV56v5xI0=;
        b=YGHymCScKMHb9Hzxq6WrRdmEtbcg5G6R/1K4icrvBT6fXwQrZGHaUXJddvx0s0vBOG
         tXERZpkBcP8JPg/1FfytjY9d1A2DW0DoPBUp4uBSWSjIF4KFwyvCYLV8SrEnNZcLMG7G
         JXoe3eYzrpjZFv9rBURxoMQp54L3Gj0lWJIpQLSX6cIj7CndTtUjknwEv6v84bH6m9IJ
         JEZpQfQCxUOVPSZdsC5WkZEkruuwN76B17TN+yNHpvwpOywTPoVTkyOor0bv+80qFEZz
         M3sbiB5nNBAQHawn0mXGChkvUl/SoLigWd/yHkGgPM3GqXOln6cbAzsnl13lZu1uER1h
         DwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795614337; x=1796219137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I5CcyHsjMPRsGo6MKL1jcfK65/L0dFfy3XsV56v5xI0=;
        b=R4nFHCYQv2n12d9DYnl4NzoJDJDrrzXs7NZX+Jz5ahJJo+JGyXzkwRAk5+nOZWBJf9
         VSKtsefPVDzNEaz+3hzvZKz2vT0DFg4F8/O+XT8+gshGf+ZG5fQrOv9ER8sMcxFmulKZ
         TYZyT3fQ4xHlIz9pQngcORXWKGvkHxC2Jev8XttOwlbfK3utg9CmhSLH5hLTaRqVnGZm
         j3F05v3Hm9i02hdlnxhsztAbd1Ga4OV3Z8A80VWqbig6nD+cZIxGN0kceMtKD9Fjv58B
         LR9tUh26wcSNRqIz6vfvPkUhae3rDcDdGvPbRxpt8630muCtbXg7FUl+CplBE3qwfwZ+
         +DWw==
X-Forwarded-Encrypted: i=1; AL+hErESUwPd+28WtCWBBw79vdjADzYGu8OJZ/e8+vcpsqM73hgxrKTW58C7R7lhroCu3pqqD1L+qg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8YWOOo0UiIYA8rOw5cXAM/HzeQzRHJVAoicSvWCG2hc5PtTYwC
	5Yic1PNTIyUGIC73jSIER9mkkg6NlQ7Cuys/9TdGonmqAOTPWAGclWseY6RH2ALARPpM+8Kffqp
	vK3RS+WEzC5NTLp+SOiHM5tgDpKzssKpJylVHOHwEZR0QPsoU0Yx5csZQAw==
X-Gm-Gg: AZFdTZeKwh5UBkcfjkoS+n7aYLnZh3arL1GHm7NBb9IqmzXEMTu5N9FMcPtRfHJvrwB
	cKf3lszkWpDR/svf33m+bWHjtMYRj/CH48X38TQJ1ecSV1inIVULVVwAVbIpqEMeDWNet4/2HIm
	SEiqwFxMqhJjpiLQULbtD63dXhCHuxR/H+YzbJm+snCH+RUqhdOMLx6szl93o6yhDK4fzUpWR7B
	DT6nVi+Qg7A2taeY3ItW8ZDHWCqgCqf/gUMjaygwzWNB4lnZ2EEIG0uJ3Gbka3GABcFkh5lybWH
	zf5ClBHjOKT7A6KYIhbeiCRPlQUzR9S1YcxJoHaSVbUehmqN75rXOizv2VsGaLldokJ/pfNVxVf
	j1jRfUZX6IpAAJa9Ne7zyv0/PiU3EWjNnR47dUb9rPXaqbEw9NNjmq5q3oGFQNtPFVR+c/nMh+R
	wimNEKaIQNucCYCWHEYZefRViazYMZRk12pcYqnVP/VFKOWNoYnrgjd6vPHGHwgdYMfQ==
X-Received: by 2002:a05:701a:cc90:20b0:146:ffa9:2117 with SMTP id a92af1059eb24-1b5697a0445mr18891265c88.1.1795614337149;
        Wed, 25 Nov 2026 05:45:37 -0800 (PST)
X-Received: by 2002:a05:701a:cc90:20b0:146:ffa9:2117 with SMTP id a92af1059eb24-1b5697a0445mr18891175c88.1.1795614336326;
        Wed, 25 Nov 2026 05:45:36 -0800 (PST)
Received: from hu-ninanaik-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556829d31sm68870217c88.9.2026.11.25.05.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 05:45:35 -0800 (PST)
From: Ninad Naik <ninad.naik@oss.qualcomm.com>
To: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Connor Abbott <cwabbott0@gmail.com>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Pranjal Shrivastava <praan@google.com>,
        Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iommu/arm-smmu: Use pm_runtime in fault handlers
Date: Wed, 25 Nov 2026 19:15:27 +0530
Message-Id: <20261125134527.2427608-1-ninad.naik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260806-smmu-rpm-v4-1-8183d007331c@oss.qualcomm.com>
References: <20260806-smmu-rpm-v4-1-8183d007331c@oss.qualcomm.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FPmOVOos c=1 sm=1 tr=0 ts=6b06e682 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=zxn-vXfs4R3W1Tx4-PcA:9
 a=ZXulRonScM0A:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: tG7jL6JJ4so-nRqNZS7qjC3MZfFWQwM9
X-Proofpoint-ORIG-GUID: tG7jL6JJ4so-nRqNZS7qjC3MZfFWQwM9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA1NCBTYWx0ZWRfX/ef7gY4qRIGC
 H7USqV8KQhgqIOHAFBVkygQHILCM/ym4YeJyDcKG9KdOpE7DIB4jEz+ehCjbmukxQvu23RdTEib
 RY34N13Zvgtsekt29cwJgB1lg1bcFU0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA1NCBTYWx0ZWRfX61BJ26oAvFlC
 xw6gx2tpmPQzoM/9krxokGR1AVnM2rQG5wJ4q1uJ57XQqDYWdTFcHL3L7fGf2aTA6JxaaoYVAOg
 wIGKKLdd5jhAfZmO90x3luKeqpeaVOf3ZqVz5RbFmr6FdyveGQW47nX+Mq02I+QdX4ZQBMoWXfH
 3VkrZRqLTIqqXLMvzaoGm6vojjERq4N5+SvE9HJSMx2jWn/rBMmMxqWYCy/l8otaDcg7kiEvlcZ
 fxPIN8rmtRqIion55M6FzVY1uCcFpGGHbJb5QZ09jQqTouOqFCd/IeEqbQjsvp6YSrmR/P6z8dP
 E60QK5hiohFv5y4yYU+98QIaZq/1K/EzQS8yiTUm9BGywZq6pLlOyYEGF5b/dQnQ+gol6wIuJ8a
 I2iW0XuSDLEG4DAzz4Dnz0AIpQK7pEIPGW0liJ3o2UTWd2xn+KeKHeubXehTqbI3/CKQJ9oTLb/
 hyPf+F01Xye0TWDLSbw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250054

On Thu, Aug 06, 2026 at 03:52:41PM +0530, Prakash Gupta wrote:
> +static inline int arm_smmu_rpm_get_if_active(struct arm_smmu_device *smmu)

arm_smmu_flush_iotlb_all() needs the same treatment. It's called from
the iommu-dma flush queue timer, so arm_smmu_rpm_get() there can end up
sleeping in softirq context if the SMMU has suspended in the meantime.
With a firmware-managed power domain the resume actually blocks, and
we see an RCU stall:

  rpm_resume+0x18c/0x768
  __pm_runtime_resume+0x50/0x98
  arm_smmu_flush_iotlb_all+0x94/0x118
  fq_flush_iotlb+0x3c/0xa8
  fq_flush_timeout+0x54/0xd0
  run_timer_softirq+0x28/0x50

Skipping the flush when the SMMU isn't active should be fine, since
arm_smmu_device_reset() invalidates the TLBs on resume.

If this looks right, can you fold it in, or would you prefer a
separate patch?

Ninad
