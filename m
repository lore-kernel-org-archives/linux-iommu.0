Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42163CCFD9
	for <iommu@lists.linux.dev>; Sun, 17 May 2026 18:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779042428; cv=none; b=tm0wHe+qIIqyu3QSbMkPqLQ32AT/2bzDhRTHD0ST1Du8FMTYNi2mf1qSvmI/US60hf0PGYRZjIvo7PdM/t+thTKJq157IQyeVUSWk/ceyfmgvmHkExAeDx4g1qbI5571llqCL0X6xRPC94pz7bSsdzv1QZSxqdhFsp+Z5PVw0C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779042428; c=relaxed/simple;
	bh=KH2q6ukcbp5AaSXp8cEFyogjLF1WV/NKI+JfbIs9Zxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhAlIY6GDjItgSqxHvDYMVfHLmPkcjtubQqnO0pu32of+smDDtq6QFJdkQ2JkPXlFlVFS0GYYh+Jqsre733GaC5hHUE1yyJMAAuOBiVMrijY1Fd+wPajkzcZx94hpf0sL+AuqzSIP8qWQshnwiMc2t0UIuPN668OYepjfGWN7kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SSmJ8zbu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hy2lYJ0p; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SSmJ8zbu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hy2lYJ0p"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64HDjtHJ413777
	for <iommu@lists.linux.dev>; Sun, 17 May 2026 18:27:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	47IgD0Iol6l33UGUteMSnMp1BqqYxxlTxqbsNmGL4o0=; b=SSmJ8zbujuLqmSrJ
	hP4SOwcuU2/B8tj4fWaGfPBNfswDzwWRaUaQMHW70GI3sgVxCVQ7v3ipcL/Pk7Xf
	9ijtK7lEPicROvKX95rXsAi5bd4oB6Mzz3zVyjLv/xXx4axbdrJAB9Su0yCxVfuT
	aqgwaDyVCDhhP73wUZQ2uA+JydvmdKJcyIGFsonoNeh+T1D0K49nhik/l3ThtVb1
	oGRMZNV8mQmfnsT7hUk7OUdc4Km1xVeBqpKPHT6D1xgY0ZSBJfRuEOaPZhmsHa0A
	9O/OhHgFGf7fxFK01WyVOmONmMX+R+of8+EmEeN8mEs/ctRFKjgB4WV8tTd1CDvn
	ejDWNw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6gx6ubbj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 17 May 2026 18:27:03 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-514b5d6bb45so29546191cf.2
        for <iommu@lists.linux.dev>; Sun, 17 May 2026 11:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779042422; x=1779647222; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=47IgD0Iol6l33UGUteMSnMp1BqqYxxlTxqbsNmGL4o0=;
        b=Hy2lYJ0pZnnuUbw9BOTJFDuSMCeVRX4NCQiqkyotiHuEaphExCal+s29zRJwW4fxPT
         TmFsBpw3tnnyDbyihUbDx1zklkNT/Ih5Pxr8zHWvACUrgyk0/mazAmOO453ACFHRnkMK
         o/qzahXtOp/ElezH7tZ5strhICWZ2Iu6vJPprFhD8jTJCp+eCKq73KDFJ4knXX1Eg+c4
         3jrGzucRG+4dQtIxB/GUQfu28QD4BXUmL0WhDpgrS90YEzpgNuO2179LhpZRrFLcpbsW
         Lm2GJn+eGjOrDsbQMlXuKfGBBMh1pJ4A+ytu/u/29+S2sgkHbtzEfRgHLGN//LNfz+oV
         WE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779042422; x=1779647222;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47IgD0Iol6l33UGUteMSnMp1BqqYxxlTxqbsNmGL4o0=;
        b=AYPlBbi/wIKFTbnB+WiCqBkrOeTbmskJyc5AalgwDGXagLEii/JPOOOBWonQ1Cq3Ey
         9vzYqa6OsuwZUmcmFtEtVWq420VSDYer2PSGmeQZMNWDOz88v5rfRuUwG5xnh7nJvNYS
         xTlzcVLtLQMWfK2tIc8s2YDjdxEDl2B/7Ue+Q3HdfeYYlXwf7DMy+E+g9Es4dedr8+yw
         5UhPLPUG3pa69d2NjVZC6RWpe+yf+L3r1IbxPDtrKnRTaP8PQKws7gasms9Fo+/97xs9
         z+rwavErN+4VF8D6EUTi0khMXCMgChnAY3Gyg62nNz1UKXhmKyS8/W3sLbjaQB0zSh/A
         okAA==
X-Forwarded-Encrypted: i=1; AFNElJ84vwHnR/5OmoSzarzARv34cSRDkA3VIk5as8HzAmcrgA41ZNQBJhil63+3Y7enXCtzGek52Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzR7tvXlFCvwXIWufcPMRFDdty4two8ICKz/kiWAtSgtcmjFOZ9
	VXF9Obp35tRCiEJabCblf+TFqKIrLeVSWd2+3pLeDlELAmn9ZCp97olI+8JyqWQbHd19OZEf+/O
	wknpZ7TtHLH71YNmjUng7CyEmak70UrUAsbs0M4umAqNGNia7D9K0hiel0w==
X-Gm-Gg: Acq92OEONWzwzY1vc3m7rKGAnhTPTFGLjHrLCfxX49/kY/vfTdDszQTaDBDWWckYZIz
	oRlPq8OdXFT5Iq+7urCgKxSHMLLDtYEyl1ruLNYVv+TgvLK8RnsydnGJR5XqTrOYqOD7d2YvoHn
	ga6Ows9K9/iNNwTV0OeMrvlJ4REKViJMQP9yZQ8931ARuqh3Ye+VwkYO47CXnYygK9X5iC81P5F
	PUrsfojS6Q2vD+DPV3IoQ85eQIKs81S6qE9knrUI04EguCVssAcH9PwFgSsBQpZXkNfXdfQbyxJ
	9JrOxuwM/BMEi4gCq5YVimmUc4xkvhjh66djniE/ImZPgIQjeJ7mrgioOhz+9tdJWHokadlSH+f
	fUjWiFVDXEGR0ewuLVfR69P3kJ40yHpPOicp6R9hdaTdV4aUw6yT+81rBnoyKQWRqGWXMv9jXow
	l7woXy5wmWZBGSn8H3B1DUWEgH78+Un2YqEe0=
X-Received: by 2002:a05:622a:901b:b0:50d:7d8a:5d45 with SMTP id d75a77b69052e-5165a2754a0mr151817711cf.36.1779042422417;
        Sun, 17 May 2026 11:27:02 -0700 (PDT)
X-Received: by 2002:a05:622a:901b:b0:50d:7d8a:5d45 with SMTP id d75a77b69052e-5165a2754a0mr151817231cf.36.1779042421835;
        Sun, 17 May 2026 11:27:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a90f10c885sm2814535e87.11.2026.05.17.11.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 11:26:59 -0700 (PDT)
Date: Sun, 17 May 2026 21:26:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 6/8] arm64: dts: qcom: kaanapali: Add GPU cooling
Message-ID: <vjdz65uy4pxlbt2e4wlwvdu5llwazyopeqb3caswvejenm5iv7@3s3p7iz4otef>
References: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
 <20260512-kaana-gpu-dt-v1-6-13e1c07c2050@oss.qualcomm.com>
 <iun4ziuei3tzvr75qbbqgxytto6vptvtd7j5mr5ol5aqviaafz@5m4yxgnqjavc>
 <e6572f5b-3686-46ca-956d-c06a7363cef2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6572f5b-3686-46ca-956d-c06a7363cef2@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: Ghx5_U2BopBLxmRbyBXg2qBRvAgLiGUp
X-Authority-Analysis: v=2.4 cv=f614wuyM c=1 sm=1 tr=0 ts=6a0a0877 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=yUhn81BH2gEySD1AKRsA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: Ghx5_U2BopBLxmRbyBXg2qBRvAgLiGUp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDE5OCBTYWx0ZWRfXxJWD+9rY63yQ
 DVwAJaE0OFd55jgel6YW9WLr4HVBKh1wre51mPadpfKFV07wkTGYyOmkm89dGv8i8J/xmUgu+eo
 suEcEvroSnSECojX7mwMsw3pgFSS9jcuEb7O+iTr/inBrCMEwn2WfRr7MY0MPq1/YGwpiudu+1s
 hJnverr7UfrybwRCXfRmqennbsWDUl52UtFN5r4V2qwQ9xZV3+ekl40/JrWMmCjYkr0Jndl3GfL
 1Q7I9kgZ+5JHcqXNx8H6DRrCwSbIkR4E8v7P+GH5WRZsOSNay/e3tZVbp0yeO548aHA4JRWnySv
 MKLqHYSBueD4vwTjpeYh8exhDBB6Tjjk9Fr9DPaJhzHCoLaL389FYYo1Mf4EFgs7wHLEAcNV2ra
 D/97QhDeiJIgFlvUaNzHBTkkpsgHcbvM9LRAJBxW/66tyZDrHhnlzhJGiKSf8cyqxyn+ryUHo1F
 f9XrUBdJvZ3zfb8/tzg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 spamscore=0 suspectscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605170198

On Thu, May 14, 2026 at 12:17:54PM +0530, Gaurav Kohli wrote:
> 
> 
> On 5/13/2026 11:23 PM, Dmitry Baryshkov wrote:
> > On Tue, May 12, 2026 at 03:53:20AM +0530, Akhil P Oommen wrote:
> > > From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> > > 
> > > Unlike the CPU, the GPU does not throttle its speed automatically when it
> > > reaches high temperatures.
> > > 
> > > Set up GPU cooling by throttling the GPU speed
> > > when reaching 105°C.
> > > 
> > > Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> > > Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> > > ---
> > >   arch/arm64/boot/dts/qcom/kaanapali.dtsi | 165 ++++++++++++++++++++++++++------
> > >   1 file changed, 135 insertions(+), 30 deletions(-)
> > > 
> > > +
> > >   			thermal-sensors = <&tsens5 0>;
> > >   			trips {
> > > -				gpuss-0-hot {
> > > -					temperature = <120000>;
> > > +				gpuss_0_alert0: gpuss-0-alert0 {
> > > +					temperature = <105000>;
> > >   					hysteresis = <5000>;
> > > -					type = "hot";
> > > +					type = "passive";
> > >   				};
> > 
> > Why don't we keep both passive and hot trip points?
> > 
> 
> Need guidance here, we are keeping passive at low temp so still hot trip is
> needed for such cases.

I think we are saying the same. Keep both passive and hot trip points.

> 
> > >   				gpuss-0-critical {
> > > 
> > 
> 

-- 
With best wishes
Dmitry
