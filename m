Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D339B396599
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 22:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772576909; cv=none; b=hydzegioq68KlefU9FbXFBLJiiSDgEDsY1rgQz50DuogP5RBxfq81cmYj5Pnxw9xILs8LphMXgygNvaKWz32dFjxt4qCGT9GUppCJVEXj95OH4NfKCihrxovbr8TEy7DNuFf8c73fNxwfPI4QuO26+rj+xBUmLboeuZ1bWcbNko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772576909; c=relaxed/simple;
	bh=43ODfSZcUzBQTYKiiCeti8jxSCEV0BXnx0H9eW8/Hls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WckMYHhmOE/eTAqQjoM63V2ZKz+0GIRBZJqUqs2hZTyMGdVJaDLNpwm2MSUZwz7Kc0czKaxqS819I31Bgk6BV3D1UVayAnBz0WQGiIf6rWitmkL88vrwf/ClyxcBzGQt7FjapCwWFE3A5pYSLqV9i0/ImE+5PjbSkDqIPukBxg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YNkaXJvm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cuow8/To; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YNkaXJvm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cuow8/To"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623H0ZW43670125
	for <iommu@lists.linux.dev>; Tue, 3 Mar 2026 22:28:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=P3sf8FAqqEmrZ3kQlF0AcrpG
	0JzllvKYNW2tsVeXgps=; b=YNkaXJvmnUGbWafXGXjdQMr5vwNDktlZkKxbb6o1
	hUKXbEhT/mB5rZw0N3QUQb7/aUJmEpBInMbdafacN+09i5/Pyj1g5HL1GDpJvQTt
	C4WBz6V/e/7DWsm5rajLO4QIsmDP/1cjx7g58N9IOEKVQ7Xk77eFi2BtO59dFw7m
	DpQvhoYNUBbGjJJKG8udmEDe0YjUbkFI/8ebTIZcMs1ioJ9EK7l7eqioMZYdwfPY
	8VBf0lj3naEGfu2BGfp/zR8sH2tI8XTuPHjtTsKxoB+5HeGtmZJPVayTpWCEvUqW
	Fzvia3AdNApZ7jYqIG8Po+HBApGqG2zvO/yiTr+rfq1WqQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnswe38nv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 03 Mar 2026 22:28:27 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb3d11b913so4006269585a.1
        for <iommu@lists.linux.dev>; Tue, 03 Mar 2026 14:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772576906; x=1773181706; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P3sf8FAqqEmrZ3kQlF0AcrpG0JzllvKYNW2tsVeXgps=;
        b=cuow8/TonOG1eC7vJ6DTqO2pB99NffLzo1Y/nh9+/uBLij2MASxUFrN2LNWFNbczaC
         sA8Eo8q9kamSVSH8rhOXBdAQoaCVPZaRHtd2D2gp/8/zfxHXwf64XpwqqBtUOAVNNTjE
         ySnrIFTG66juCPIorvo6ZXv1ceTumIRKS4sdjuUjjW8GZtZS1Fojmz08cGr3km431x3X
         xcgpJY4kEKEb/HxHOaN58n0B6me3oKIBRWe/TgkPf9kZXvvVjdZwgyz0DUUH0CoNEmeB
         32oYSSka8sjdgJtf+ngb4T9wgARVqZZU6O8jR8hpFolGZNDcXZX5MlOrH22bdPMMrSKp
         Q/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772576906; x=1773181706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P3sf8FAqqEmrZ3kQlF0AcrpG0JzllvKYNW2tsVeXgps=;
        b=ldve6ykozDi1lt4mHOHeZFW1mWo4tbytd/NCKpexJR34G6fB5pxcwgB8HPajlzPWpM
         JLSU6QxXoo8EIAPZSt5EngctwwdGeRJCxpRjg04PQ/thnhtRvre4slxhDDQzW+FNUrgr
         3aZU6TSKs2vorwxUNJVZMjqa9nu+bW6npVQ9QaDm1OOY5aBmMulDVz8RISZbHJTvtX8m
         XIqQVCeDbU+LK9rQRYNWQ5ADxuhLfZEjdeI0S1kLd/9mu5bkru9Ny0M1kKAgnvnBgkOn
         V+Yg+Uv9/T9d9ob8MXKzSKtK63zAm5DBVPg65BRJ9tcGNIUV3u53T7MNAjDIRicbnx8S
         CX8w==
X-Forwarded-Encrypted: i=1; AJvYcCUu6eRg8nKV4mlB+5IvC2SB4qmRJUmzS+0d4F1GfW0GXc0WgBC0Fx6QsFbaVkuGOYHwDZ3Yag==@lists.linux.dev
X-Gm-Message-State: AOJu0YxB3HY6MDpDvwN80Egzd4Vub56gGrjnfzBFpStuJnzySKLuzLUy
	2PFE+EiLScUIauWYD9L3M+ikx00Tag3fAPjw9eg3NyeVH/djKmUhLYmA5sFD08JJD2jJvt2i08l
	bbmQ9fVzFi0jxkuNNnJfc6M49hSyqFW6Tb4sWta9ib8SESJ/g5mcQXnCZig==
X-Gm-Gg: ATEYQzw2zzYhYGcR52lJ++I2Zonetum1kFWKFrWxxVgai4w/1h9/kF13hXG0ds1LRD/
	aHdjgG+3Fud/9H0kcvm5IdVBxEZxe9CjZyHZpjUxxmvwwMqCEbQumpfBQHHK/cODdOx7kMEuaF/
	MQaWheKd7aCpfLiodO8NU1HdVEGxrt3xwWKIECRA+PT376LtzxHxQ8Ntiu/xFbf5ORnOG8CR1x2
	siyN0PRlukWzInyDmdwRYAjfW2iAf2zTG8wLIO+NfN5/DwVht7LmDC43iRnwu+flX/YmNdUJlQQ
	X4yWgb/6Vu9kd93WTYRzMyPQKaX9dAH9GMwkCVUcbRqsbwsRUbtcuxwbHFgUlC1lvZn48PbQxoq
	A1JIR814Wu+bU0j97HGMlO2dGi0FjKlfEijI6LiMuWpytw5W+BLp/2Iyb1SpOm4ntm/pH9sAen6
	lgHmw+Hd43ILBsZ2aR0DMek9E6KscPvBiWaYo=
X-Received: by 2002:a05:620a:199f:b0:8c5:3256:2f47 with SMTP id af79cd13be357-8cbc8e7885cmr2266681985a.68.1772576906181;
        Tue, 03 Mar 2026 14:28:26 -0800 (PST)
X-Received: by 2002:a05:620a:199f:b0:8c5:3256:2f47 with SMTP id af79cd13be357-8cbc8e7885cmr2266678585a.68.1772576905724;
        Tue, 03 Mar 2026 14:28:25 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a12356ff44sm847928e87.87.2026.03.03.14.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 14:28:25 -0800 (PST)
Date: Wed, 4 Mar 2026 00:28:23 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
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
        Hans Verkuil <hverkuil+cisco@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH v2 6/7] media: iris: add iris4 specific H265 line buffer
 calculation
Message-ID: <hrjwyqz4r6usqvxhnsvtap4byfu2zvumji6whudda55vuym5yk@u6s4heswm4rc>
References: <20260227-kaanapali-iris-v2-0-850043ac3933@oss.qualcomm.com>
 <20260227-kaanapali-iris-v2-6-850043ac3933@oss.qualcomm.com>
 <cbwz5wtd55enswdi2zvvy3d66nsxlemyzdypheibvljnewmkax@kybx63aveepn>
 <ce80e60e-90ca-415d-83af-4fe2e86ffd91@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce80e60e-90ca-415d-83af-4fe2e86ffd91@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: uy-lfeL-WBcRe7Uk9Sq9yk2Wzu3Suaxi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE4NSBTYWx0ZWRfX4PJ7bslN9Syh
 /Kj8tZnRLZ1fyyhUGORZpUjOvWx1qLKRQDS0SOnIo34qMkP+jJwuisIbk2XkyyGe7RYd1yGnbSA
 DOrF/GfqlDu/7B4Nm4MzAMFQwyEMfpQRnNRgb1FS0ymqVBHFWAh4PzBQRzKx2MdAU1kB9tWSMRO
 RGlt0mdDvH93Nfsn+NsDvvrl8zyFm1RKh57DHpWijz1vXD+l8LkAWc6O1/bXb0J1cFj0YZwH2UZ
 Q7F75qDLrAZDpTdutvVc9LSN7ediKAZYmmqDabYQxufpXDxXSvvQfUZXQAAJ3WPRq4J9zhQGpy5
 STAB8L9CE1sNi3AmH1qMw/ur5EIFnrvKruIn4reRTeidZTisBHwihdBcsHiYZNojhD5LCDh15q1
 p0juQTjJASPSD8QitMLMrQ3dB4dJCpBbcKx8iANoKrsYsfS91SMCsFmfBXVu6sjg3D2eYGqdiQ1
 yk1Sn3VYDY/VY12WYSg==
X-Authority-Analysis: v=2.4 cv=TtHrRTXh c=1 sm=1 tr=0 ts=69a7608b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=l8RJfLSqy8S6moWSJ7UA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: uy-lfeL-WBcRe7Uk9Sq9yk2Wzu3Suaxi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030185

On Wed, Mar 04, 2026 at 12:18:58AM +0530, Vikash Garodia wrote:
> 
> On 2/28/2026 1:58 AM, Dmitry Baryshkov wrote:
> > On Fri, Feb 27, 2026 at 07:41:22PM +0530, Vikash Garodia wrote:
> > > The H265 decoder line buffer size calculation for iris4 (VPU4) was
> > > previously reusing the iris3 formula. While this works for most
> > > resolutions, certain configurations require a larger buffer size on
> > > iris4, causing firmware errors during decode. This resolves firmware
> > > failures seen with specific test vectors on kaanapali (iris4), and fixes
> > > the following failing fluster tests
> > > - PICSIZE_C_Bossen_1
> > > - WPP_E_ericsson_MAIN_2
> > 
> > This reminds me of the commit fixing SC7280 support. Should SC7280 or
> > all VPU2.0 platforms also use separate formula?
> > 
> for vpu2, there is already a separate formula

It was more of "do we need separate formulas within vpu2".

> 
> > > 
> > > Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> > > Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> > > Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> > > ---
> > >   drivers/media/platform/qcom/iris/iris_vpu_buffer.c | 51 +++++++++++++++++++++-
> > >   1 file changed, 50 insertions(+), 1 deletion(-)
> > > 

-- 
With best wishes
Dmitry
