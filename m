Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B392D33343C
	for <iommu@lists.linux.dev>; Sun, 26 Apr 2026 12:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777205769; cv=none; b=jl9y6r2SWhExQz+5vqi7sEi8DrmFl7xNxLT8poa8kWiYg0qYV1/SOAByZ9ZIK2XtadNCcayOQjJiUMf9xJxlR/dRrY4l4MJ5YkEODMItDgpr1tk4lDW6ta0EkHwOoDrCicY0axh/fIZfR7FDHe0iMTnzzeQtBW9SC9mG49gjVUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777205769; c=relaxed/simple;
	bh=sTH6zrHiQgzJ2dn9yyu9ZpKb/zzGMOU6idxjmTf2X0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZaNWcMQpv6k5Tm1HrVPBSbHXf98YxfjfpwNl7Khw2aQB3lz1iTCmHS4HWA4Hwe+C/h1/Dv+Mbzivr+RkAxSxOddHaurTtpwg3vJVWs/gxvecifFMMzBcTm9SMn1IvhaqAuN20ZabxZpHUEu9kPenvgEUxaOjMmSN7EcpiB4o80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eBbizPPP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dgW3ZOJY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eBbizPPP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dgW3ZOJY"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63Q3AH0x1456599
	for <iommu@lists.linux.dev>; Sun, 26 Apr 2026 12:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Eu9oH6bIm++6Uod9f6mbJENn
	f42CEvq9lNDJEscrW7U=; b=eBbizPPPtjcY6DIrYbD6qYZQ/8+0igrIAyTfcwSC
	2yLd3BCGUJpCMiKlxy6zams0+3OjqFHBp0aJjN33GRaonbx/5ebBPOzM+6SzH0Aw
	GMwo/fZHT7+NbrFqpRPXJ9vdPQwqOa9NDGIMFenynmAgcuqgrZJ2YB+/EzpYloN8
	ldDQhuRtuxGtRWGbST7ny9qWjUaTWIi9KYCFCENx1i5M911mk2ig4aYJoy3uWZDp
	6OEm3uysW64A8vJFyXbz1ssVSD7ubC8zOvTikyMqDvt5Zd8gkqa2GExmeVtJrbj0
	Hdkd+dRKBDngFXPSJlkB0z5Ng1h8QTm1Su7eQ85XiJn1kA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drnpw2tgh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 26 Apr 2026 12:16:06 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50ea1a7a5d0so162766411cf.3
        for <iommu@lists.linux.dev>; Sun, 26 Apr 2026 05:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777205766; x=1777810566; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Eu9oH6bIm++6Uod9f6mbJENnf42CEvq9lNDJEscrW7U=;
        b=dgW3ZOJYh1WPj4IFX9aJvQAWj8N9+MkX81It2QjzG+h90fUwoz3selrdoBC/dn8wDE
         8lFwhOOxlrJFG2nXcW7uPvRsa+/qeaf38jxkbIteqryWFFN6XnRiJ7JRE5TGTX8NUgru
         RKsdv1EsFGNWJfptPweSSt9KVafVXl+axZ4ZWAj5nGi8MZoys05ltdIU2Y63GKDq60KG
         s525Vp3gByqG8oqf1PkXrjVFUtzw0VZdZTG00yeXi4DXGije4T+bTGQwjw5G1KJ4Z2/I
         CiKYRQgTunt7SnZydSQxnX0j3dA5VjhEv2LbLKrmK3h+45sX+46/x5u3FHWMNNBBfXGG
         4WMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777205766; x=1777810566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eu9oH6bIm++6Uod9f6mbJENnf42CEvq9lNDJEscrW7U=;
        b=PVgEW4M8LuzZ5/UpzDBNoqkkL8KzraOmxdHR5J3UqG/nUmUjafQ2kBfUEgaJfEWdIv
         ygPSzajLbua5kjGjSuLEBwukJr+WVYgb7Nj7TKVvktmum4O6UTPXZQrOiO8ETbKuQEyz
         RL4qvnmsC7sVq+fBC+j+9/viVny6DHtpUci4gnu3d08/U4Ku5yMvDYEAfAuMt8axIBCg
         xWu5wujN6XkNcYtNe4uZYQvAKHZbiO1tFPcrp2nC2WbLdqzOabeb17iRHk+Ktj5f6JJU
         i9pRWY5T78RykuhL7pMGUds84zmrkvH2MmrQ/IsgQe4kBuOsyq+sGEmEqH0EahCNh4ZB
         e7ag==
X-Forwarded-Encrypted: i=1; AFNElJ+y6SR/2+Xviaw7Q/WPZARgLVRjgjUmhPaj9KCljOXELPv9IrFQdMsyTc7zpafqzYaZ15OFXA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzsmf5EnkyXrxVWrEvThQ5gPLJJCZqzpvVgPSWq5jDucVK4/yEi
	jtosnL/GuC5dN4goFn0gxhKG8LQ7RbPtw+IBBQR9YnB/RU9qHizad6uO8NhFnqY68djcmJoWaPR
	BaIjkF/Yo+V8BNOjm9WGZQlLMKvMqOmxzmVxlXQ1Ksi9/TsRBINperI5ILw==
X-Gm-Gg: AeBDietbL4f2OzhUNBJ4qghsGaIV2EuaK/BGL+91aZ1WIH4bSuEFxHbp6g84lZ5plqC
	P/88UhMZZ8GCW/8cQCySpZ8Sn010HMKrVIM3U3xUxJNHvE0F3AF/rkrApl/vd9So+PGZEH39/Bd
	TYoCbd+a2topLEXedueLRhtLJhoSUUoA44BCI7CNB5XMFH465F+MZ0LIiR9JyAgvHYZD6lqqNUO
	Izr+93veoV8RQZF0wRleuyIXKZp2gcKDs0HYXamzWLX4TUNW8el7OHnarjklM/90wPUZhNk5BNs
	j5+ITqYIk4ssdC+VkPpejhIq1+HUcQ0Nu1b3h+rsqlMw0yyRq8mgqDMHuARe+e/CQrrm4eBEgyX
	gHqEy5XJMmkZ18bT7yAWb2Jz7cCC1+JHOIDb8gxGTkSEkk1hpPaZoLefov+cLD5GCk/+YHdJS5/
	kTl3UMqY6g9B/2Vpyyx8y1eCNLETzZYPmPmQAWpkoQ8ZOI/w==
X-Received: by 2002:a05:622a:698f:b0:50e:5de8:6458 with SMTP id d75a77b69052e-50e5de873a3mr285408481cf.57.1777205765927;
        Sun, 26 Apr 2026 05:16:05 -0700 (PDT)
X-Received: by 2002:a05:622a:698f:b0:50e:5de8:6458 with SMTP id d75a77b69052e-50e5de873a3mr285408211cf.57.1777205765441;
        Sun, 26 Apr 2026 05:16:05 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4187ebfd6sm7326187e87.78.2026.04.26.05.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 05:16:04 -0700 (PDT)
Date: Sun, 26 Apr 2026 15:16:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Bryan O'Donoghue <bod@kernel.org>,
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
        Hans Verkuil <hverkuil@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Thierry Reding <thierry.reding@kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 11/13] media: iris: Select DMA_CONTEXT_BUS to create
 firmware device
Message-ID: <atmot2aw26hrystaxpnjtc6fmep2lsjdbarlfocysghl7db5gc@yrdyk6i6zd2p>
References: <20260423-glymur-v2-0-0296bccb9f4e@oss.qualcomm.com>
 <20260423-glymur-v2-11-0296bccb9f4e@oss.qualcomm.com>
 <2026042305-pungent-urban-c681@gregkh>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026042305-pungent-urban-c681@gregkh>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI2MDEzMyBTYWx0ZWRfX8MyUqo2vGEK4
 fLrZou8FLtNYGiocbWWxgnCHtMutToywx8QN4jrTPjixoBujOEGNfw1lMcD04cob1ppUYKWYIuE
 98IWwVPunzVBpqQn2f3odC4POV4bLPbaJ9w2iVyPlJPV8UOwmr0LrBx7HEiKJgs5ee2dS8VJUNW
 0+/K6zriWXAmEFddXnYWRmRA2XxGv8FHtjxEMm/6vkBKySDvexsfB1WCGr2er1EQTgc3nSaU0dY
 pZwI41Ub6TBUwZc1mUh3RjfRC5AL+l29nEt+hW8t6cZFEaBV9hOqq1fdoAodom4PI4MmZHvCmNb
 FJbEL1wRn83jUj2K5RHuZjSjH9A6KYSw/LhKbx0u9ik3yAYRPJFaq8FiKbYR60Z2w7ux0jzQxui
 DExrF9eWjDfeUv6wrjThnF9b+UQ4O6L4jIdko/bVIo16vnq+kYOHVqNK48PvBZnzXUgIqIGpiuD
 YYXwuWol01R00vRt11g==
X-Proofpoint-ORIG-GUID: KoEmsMEu-7XNtTgCl3A-9FMXfa-dgWTF
X-Authority-Analysis: v=2.4 cv=RaGgzVtv c=1 sm=1 tr=0 ts=69ee0206 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=FZe96GFAMPEOsOiVEGMA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: KoEmsMEu-7XNtTgCl3A-9FMXfa-dgWTF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-26_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604260133

On Thu, Apr 23, 2026 at 03:38:25PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Apr 23, 2026 at 06:59:40PM +0530, Vishnu Reddy wrote:
> > Iris need a firmware device to enable secure PAS (peripheral
> > authentication service) support in case of non-Gunyah.
> 
> As gunyah isn't ever going upstream, why is this an issue here for us at
> all?

Vishnu, this is a nice example of why we are always asking for the
complete commit message, describing the problem that you are solving.
You gave zero context for people outside of your group who don't have
a knowledge of your issue.

Please start thinking from the reviewers point of view. Or consider
yourself being an engineer in 5 years wishing to change that code and
trying to understand, would you break something if you do this or that.
You need to explain, explain and explain things.

For example (please correct it, it is based on my incomplete
understanding):

If Linux is run under the Gunyah control, the hypervisor will set up the
SMMU SID for loading the firware (and protect it from being touched by
te OS). If Linux is running in EL2 without Gunyah in play, it needs to
take care of that setup. Since loading the firmware requires separate
address mapping, corresponding SID is describing in DT as one of the
functions inside the iommu-map property. Create the child device that
will be used for allocating DMA buffers for the firmware and mapping
them to the correct SID.

Please review all your commit messages from this position and adjust /
rewrite them as necessary.

-- 
With best wishes
Dmitry
