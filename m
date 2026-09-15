Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0BB42BEB0
	for <iommu@lists.linux.dev>; Tue, 15 Sep 2026 23:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789514352; cv=none; b=B534VYukaFsayMWKJPTQ9P9aqYw+fmdJs3/R33/wiDG0WHFOD3vBlq9sDbx+m7Igaa3tWmelgIspNIsrbQA2eDiuIlHVL4WUtsVuxu6zqxXa+Kp23FoTvspdqZFi87hxBobUu+PKS3obwTM/DUBMmC/u2Z6KQcOB9EEgJntZb/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789514352; c=relaxed/simple;
	bh=LB2WtpgONiLQ7gm4vgAWhynn32lwn8w7mumONl9R1DE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ec9HBVP81V5Y8dkK2AMKcxvPrSHdiIjy+gWFmFRX+hI+MS91i8U3Xl6istYKyBEu0YwbnWDjgVF6/t6F6RDEo/O/eOVQ+o557Tn31R5vTginj98Qo49Y4KwHm3L7qQEt5UBaMbYRW2mwO2rBGsr0SI5Amguy0McM5ckJbzoFAkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k/QXEAJZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RP4qYjMC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k/QXEAJZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RP4qYjMC"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FM3OZr1933292
	for <iommu@lists.linux.dev>; Tue, 15 Sep 2026 23:19:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GtfgcKKZ9v2ZBngMs3bfVx7nttoh7eLy//n2NDiu6Fs=; b=k/QXEAJZPF8o0hbe
	zJKDfE96pVBa6P6bbffHXgxPf8ByvvwCNLbQnT8jOezZGipe4pQSNCGmZX6SRja8
	s/9qSA3W+q10+k0RWG6A1fN7nTsXKcU7JJTQK8pJfgEic5IZceBfiq/G7j6jw4Pl
	qEI1MTMbuUDn0PJ05QNcU2Mi8jlC0Zoc9UhECS73gMVHhyBVerUWFJPQASwRjnvq
	NScXnu5WeM/LgfqcvMDPKyDNt9/T55bqjZ+k+djBfWZDep2JIUzDzKpCYkRxsXTi
	dkTVzF+P5nstaHlgNeZqW7wrKLfy/uLQa0i3+5pealS2Iu7hagzVSugToGtCx19l
	IGD4Kg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqefp87xt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 15 Sep 2026 23:19:07 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39e18af9f48so742361a91.1
        for <iommu@lists.linux.dev>; Tue, 15 Sep 2026 16:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789514347; x=1790119147; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=GtfgcKKZ9v2ZBngMs3bfVx7nttoh7eLy//n2NDiu6Fs=;
        b=RP4qYjMCtQBKS4dK9BZod64G5gmFzUNTP/YdzdASn1c19Nuqcna1qRZH4yRAsGQY8Q
         jeluSUy3Ymqi5eTrxTMCcTYUSc8eLCpGYLVXT3S0q4kFw4iOtL6zdBe8Vd1bA3lDLcEm
         cRf9c3Yn4JxkC8NwknmGafw+shBV5tbkjZLXTwg4lUIPa/9M1aA1tLUck7ubWVOoAaEp
         Dm7tFG4KBNjC41OyRyAKnYAOeBwi8Ici1NMkhrs3HBLE6LjKP3jC6PijQzFXFoNpGLYO
         FQaV6Z7Gehqr9rXQo4DR+lolWFyF2B8S6+kHDo7kHS1FidgOo99zXMT3O0CWs1pSxyk5
         XLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789514347; x=1790119147;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GtfgcKKZ9v2ZBngMs3bfVx7nttoh7eLy//n2NDiu6Fs=;
        b=aGYOAJjc2XIG/TbiA9kPrDU7G9dOtUUh3SYrXOEeqmotykatNgMLYVUJFOfl7oVBeX
         +H8U9BiSk5WpBqz1ouTXZMw6eKmnQo0PbrqZqzujijSS3ImSSGt/1yW1Vv3T1lZIOHTi
         XJKNhu7uDsoftN77dezzeONGcV5dUouGUbV+lDerxIuE/333jqGvb1LRZVFWYwfsa9+Q
         xHTRBAF5Uv/l0wAszA5Cq4vSfel3XfEkKJ7HC4XKKwNeh6U+jTOSIN0hZrz9Lfhy+Px9
         6+AiTctDOmaewkBT5nrGAV1luAofT9v84yspS4lsTDombb2Cf2B7I72ukBf4koriZw//
         Xq2w==
X-Forwarded-Encrypted: i=1; AKwUvBwtNdYL6Impj3yo3/ZdxpZTnmT155G5lGLj4cOaqEJXyR1J9+FNHg7HQKsjM/BqM6AnC0okCg==@lists.linux.dev
X-Gm-Message-State: AFuF++kveX5gLiHge2BHIIdHpxcZ0O8wKxghb0dJtBMFl5GIZ2OS+rCn
	Uqz46vT18jAaL1/YVZWL/ydlfnwjpfNOsku6Bqv5wbtz8QlZMDsqw+kk/C9Pvhj422vDCc5Unxt
	Y73pc1b5dioeLU24eKFu/1jEi9lgnUd/ubukHJ6AF0Xpp/4IV82f4OUo53g==
X-Gm-Gg: AYBFou3W28rbMGYOPGAGKFVTBxBeqGyqw4fDN3WTkPHl0hPU5XJxJPCsyMIloVBz+7K
	jVWSqz0aukM8DP8gJSBLogEor+gQ1d3QykP+5kezNIEf46l9IYoOUZJHbMQ/1FDQgA777IYblNV
	UPb9T6lT7LcToCCweuc1kxHQTTvYske6hCYCGduwLvH+4REBlV4dEixf0rSnIBvGwXmfFp31xbF
	Lo+9J+lQ2jPRi35LQTi8UKCeQC4onQr1xSuqYlA2eKhmBky3gQMStBXlgmQpYmuSacG5fFLpaQ6
	IFwX4nciv7QxpuVQzb3cqNJy3GwogWv1ZXDv2ONhmpeSdNHcFl2pa0XOTTOaWFDLkQCapac+WxX
	1px20B3STtpizghaUnc+4Yg/JKaI=
X-Received: by 2002:a17:90b:398d:b0:39d:ec1f:b3fd with SMTP id 98e67ed59e1d1-39dfe036be1mr8656435a91.8.1789514346882;
        Tue, 15 Sep 2026 16:19:06 -0700 (PDT)
X-Received: by 2002:a17:90b:398d:b0:39d:ec1f:b3fd with SMTP id 98e67ed59e1d1-39dfe036be1mr8656394a91.8.1789514346415;
        Tue, 15 Sep 2026 16:19:06 -0700 (PDT)
Received: from localhost ([50.35.44.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5a6a175sm2279027eec.9.2026.09.15.16.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 16:19:06 -0700 (PDT)
Date: Tue, 15 Sep 2026 16:19:02 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
        <joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
        <kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
        <baolu.lu@linux.intel.com>, Jean-Philippe Brucker <jpb@kernel.org>,
        "Eric
 Auger" <eric.auger@redhat.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <skaestle@nvidia.com>, <mmarrid@nvidia.com>, <skolothumtho@nvidia.com>,
        <bbiber@nvidia.com>, <harsha.v@oss.qualcomm.com>
Subject: Re: [PATCH v5 03/15] iommu/arm-smmu-v3: Add Q_POS() macro
Message-ID: <20260915161902.00006cd1@oss.qualcomm.com>
In-Reply-To: <1db9d32df4a59dcac286e7a82bc2704cdd69b8e0.1789446520.git.nicolinc@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
	<1db9d32df4a59dcac286e7a82bc2704cdd69b8e0.1789446520.git.nicolinc@nvidia.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDM0MSBTYWx0ZWRfX270oE0tM5/50
 +PF2R0m4GXbnOwm2FohSpqFcHPOVdO3/dhhEbMhx/iSjx28491YzXA7sFuIU/VpucGeViZ7ocF3
 x5obzIJwZwtg3v/Xx/ydqa+DuSrclaM=
X-Authority-Analysis: v=2.4 cv=HrTjiETS c=1 sm=1 tr=0 ts=6aa9d26b cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=aNnz9XPx1a4JIXSYt2cE/A==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=Ikd4Dj_1AAAA:8 a=EUspDBNiAAAA:8 a=39RnTaQb96y4xN-8A7QA:9 a=CjuIK1q_8ugA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: t7BZUshBZszsYinbZWHqvOJOqsH0RIN7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDM0MSBTYWx0ZWRfX2SE4T8TMNESN
 DLI24WMLQ+r+0FVDCJoUmEQ478L1oQqICx72n/vYlfh7cIn++qc0YQe4nueYy6I6XtToudaUR+W
 J+1mrJPFXh6Q7k9wrFz/fw+SbiIXcVT29suAPplSuw6W69Eh8bDIuxlGQQQ7Ez0U3EaCPMk6lH9
 KZ8sNgtHmRjXzpoQ6ZjaaxI7n61HOOZ1zm0No9JJSnUUd7oKyRmhLPjwx53ptHi2ltDGasrcppg
 F3OgA5s40MomyRCcT8yD/oJ7nO3wvXaIbqHRWjQjgPZrOZTPuUV4CDJ1Aaiy3ibY7ocqdWTfiiN
 HdU0JPvdlKdpvUFNV6sNdQK49tvMvnjHha0MY2MqdufD23xQp15P5SKog3tSkP06QaNEHHqSP99
 ZFk9lp8UxCWXFypBQZiGSMGOBBQp06KYjnzSjLUXNqXdh/yj0cIuR7hFE8Lyauo+bq/HVgUgnsc
 ZCIxv2MzD3ep+wTsCMg==
X-Proofpoint-GUID: t7BZUshBZszsYinbZWHqvOJOqsH0RIN7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150341

On Tue, 15 Sep 2026 09:38:15 -0700
Nicolin Chen <nicolinc@nvidia.com> wrote:

> A queue position, the wrap bit combined with the index, is Q_WRP | Q_IDX.
> It is a (max_n_shift + 1)-bit value that wraps at twice the queue capacity.
> queue_inc_cons(), queue_sync_cons_ovf(), and queue_inc_prod_n() currently
> compute such positions by open-coding the two macros at each call site.
> 
> Add a Q_POS() macro and switch the open-coded sites to it.
> 
> A subsequent change will build a Q_DIFF() on it, to count the entries that
> a queue pointer moved past.
> 
> No functional change intended.
> 
> Assisted-by: LLM
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
