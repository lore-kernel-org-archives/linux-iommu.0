Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7449519A298
	for <iommu@lists.linux.dev>; Mon, 14 Apr 2025 11:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744630645; cv=none; b=Hf6KVl5iiZdiPecY0bnRO4iB7f8+3M2wGqPHEHIssgf1dy1WrPEkZjcAqXiYQeBXII+1mVRYlN9o1rRTuGW9TsD3tSLRQJ1BKxamgELDEfuu30nqLxR3pnsEEyKe44AssZ/8rCOxDoglXAV8ijZQgLbKiVOidxW0zlOJV7Al5RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744630645; c=relaxed/simple;
	bh=oGZ6xM8AWaXT8X3mogpWhv7okTX7LwNl+X1QYCAsue0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2w+VToaC0qm/d5nX8wonPxUz2fR1FmUbCaodY85oYnvmcNsOwamzeZzZP62mMOyHyiyIuwXnKUKvO4EXdp5BMONzu9+WZd0J1mHzv3FKUK8qbSs5m0GADdthvIakgI26Z9aDlNwAhs4bpR5devf/Rpr827hL+wtjYQemoaP3ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FBlrnFEB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FBlrnFEB"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53E99pBx015763
	for <iommu@lists.linux.dev>; Mon, 14 Apr 2025 11:37:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=m+XZ5UGJ/cw2rjUWCkVkP2GZ
	xzsxlJK/WCISXUsWDgk=; b=FBlrnFEBEUZZeLsBrt4qkNM8rnE0w0y81jObOsym
	2jr5tnCrgDgIFWI5rb+uWYIIeYsCicDsYMZ+Hp8EgXn3D2e2M6wDu7sVJM33UMhO
	0hWOMuerdNbmkIBCHn4fACvefH4VyTrhG0L0Le3qp5EScsUc8Xof4A3qpv+SaNeu
	JSoJpz90WjscpEXaAydj3azBFH1Mey0Q1xqehv9N6yeDrMCWdT1B66UU18XzQyK2
	t/BXe//WjZvzo5H1s1qlSdReVWr6KbzwA7fTXK3G0B+ZhMl+qvgAiZlcm95gdWXh
	WDBBkOgUQJWJ1cIo3zd4+Mk+nx/MC1tEJMqlfqrFsUaDRw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygd6cd8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 14 Apr 2025 11:37:22 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e91a184588so128962566d6.2
        for <iommu@lists.linux.dev>; Mon, 14 Apr 2025 04:37:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744630641; x=1745235441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+XZ5UGJ/cw2rjUWCkVkP2GZxzsxlJK/WCISXUsWDgk=;
        b=k5HaPD6fRUx1tq2E1LOyqeNbUd8V3bXsr3pkL0Zjq3LU++UxtRoRRdzYobDBEJ2xRi
         hmFUSWu/kX85o3TOkJOqpuivlI19DYKEQ08vG4viGHhnYTmFw4bK25NLZ0M5w/bGpdYx
         vCI/DaKk9MNzBjzi3WP+qr4LZ3XQsBY4hdak9Nhhd2I6p6El2OYa6rbtZT7Fqz+eGf6j
         mPRzbA8eXdpXTtVUGqItpUFi18NoPi8iEUAvlIvEbCXYS4xCOy3Nk+cBt63S/nM6zRxh
         9eyrF3nzDvf7+hvOITI9cWYmSJOh3PVqJT29IrR3A0AZo6TrWJGlzHrGdougrTifpfYJ
         p3aQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5GOfDPyUW2vRhw64AygikFb9gt77rMhZt3dY0jtmBDsHfITwmyjmCNC2w55mpuE0budN7jg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxduuP8rL4Y4t95fcphjwDmmc+whCpQJSgof9nRyNMvccSPYtb8
	LDNuwmXTc2ux1/26s23VrraBM96iPa+43wCMR+8FjtvQ/tz1slzibX7OKSuz+sFpoEV8zY30503
	B9jHU++loV0UgMTG7VdnJ82CLfou+fNeXCnM8K2iQDhb0Pa4MsnxSDA==
X-Gm-Gg: ASbGncs72f5v/qwpb/SKo7PLYvnqg07jiy9i8OFd2vKPty9nYyKNux3F9UESIFeSlWl
	EPgnECNMsJbYOLgUrUfmNRQhSD65hhVpp95T6EGFl+8SSiiTHz3b8RWPtO4QuLnyFi9SY50h57L
	RxftnSG6520BGWoHLl1CHmc4hN66XRwtiX3yIK//D7VJ7K5aFqg1ORkkR1NIDZNVSnBUu4In8ZI
	OztEcDFWBYFH5U52ngdVNe6mDB/OnXYkAlueBLM/i7RQcq/WyBF5SABR6+YjjiA2/WIFz0Wwt/X
	C8sQdVCaOYabccgRNaKFgxH9LPNdB+I+hr1OAieMytmOl8EWlFofqkx/dYelYDU9jp3pjqwi7jM
	=
X-Received: by 2002:a05:620a:4614:b0:7c5:4de8:bf65 with SMTP id af79cd13be357-7c7af11fe6dmr2323420785a.36.1744630640828;
        Mon, 14 Apr 2025 04:37:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbw+g6u8oZDQ91VXBKSLoF7oGbpWST7/9WsxZFJCG+ePEvjN0CGI7O5W9I4H6AJsXJ84jRzg==
X-Received: by 2002:a05:620a:4614:b0:7c5:4de8:bf65 with SMTP id af79cd13be357-7c7af11fe6dmr2323412585a.36.1744630640230;
        Mon, 14 Apr 2025 04:37:20 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d3d510b43sm1082671e87.201.2025.04.14.04.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 04:37:18 -0700 (PDT)
Date: Mon, 14 Apr 2025 14:37:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Bjorn Andersson <andersson@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v2 10/10] arm64: dts: qcom: sar2130p: add display nodes
Message-ID: <umhperyjdgiz4bo6grbxfhe44wiwoqb3w3qrzg62gf3ty66mjq@pddxfo3kkohv>
References: <20250314-sar2130p-display-v2-0-31fa4502a850@oss.qualcomm.com>
 <20250314-sar2130p-display-v2-10-31fa4502a850@oss.qualcomm.com>
 <c14dfd37-7d12-40c3-8281-fd0a7410813e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c14dfd37-7d12-40c3-8281-fd0a7410813e@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 71K-RWxEVk8kbIWewx-3YFtrsGtcwe05
X-Proofpoint-GUID: 71K-RWxEVk8kbIWewx-3YFtrsGtcwe05
X-Authority-Analysis: v=2.4 cv=ANaQCy7k c=1 sm=1 tr=0 ts=67fcf372 cx=c_pps a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=KKAkSRfTAAAA:8 a=Dsw0btoO4blozC8r0tUA:9 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_03,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=667 suspectscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504140084

On Mon, Apr 14, 2025 at 01:13:28PM +0200, Konrad Dybcio wrote:
> On 3/14/25 7:09 AM, Dmitry Baryshkov wrote:
> > From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > 
> > Add display controller, two DSI hosts, two DSI PHYs and a single DP
> > controller. Link DP to the QMP Combo PHY.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> 
> [...]
> 
> > +			mdss_mdp: display-controller@ae01000 {
> > +				compatible = "qcom,sar2130p-dpu";
> > +				reg = <0x0 0x0ae01000 0x0 0x8f000>,
> > +				      <0x0 0x0aeb0000 0x0 0x2008>;
> 
> size = 0x3000

Existing platforms (including SM8650) use 0x2008 here. Would you like to
change all the platforms and why?

> 
> [...]
> 
> > +
> > +			mdss_dp0: displayport-controller@ae90000 {
> > +				compatible = "qcom,sar2130p-dp",
> > +					     "qcom,sm8350-dp";
> > +				reg = <0x0 0xae90000 0x0 0x200>,
> > +				      <0x0 0xae90200 0x0 0x200>,
> > +				      <0x0 0xae90400 0x0 0xc00>,
> > +				      <0x0 0xae91000 0x0 0x400>,
> > +				      <0x0 0xae91400 0x0 0x400>;
> > +				interrupt-parent = <&mdss>;
> > +				interrupts = <12>;
> > +				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
> > +					 <&dispcc DISP_CC_MDSS_DPTX0_AUX_CLK>,
> > +					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK>,
> > +					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_INTF_CLK>,
> > +					 <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK>;
> > +				clock-names = "core_iface",
> > +					      "core_aux",
> > +					      "ctrl_link",
> > +					      "ctrl_link_iface",
> > +					      "stream_pixel";
> > +
> > +				assigned-clocks = <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK_SRC>,
> > +						  <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>;
> > +				assigned-clock-parents = <&usb_dp_qmpphy QMP_USB43DP_DP_LINK_CLK>,
> > +							 <&usb_dp_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
> > +
> > +				phys = <&usb_dp_qmpphy QMP_USB43DP_DP_PHY>;
> > +				phy-names = "dp";
> > +
> > +				#sound-dai-cells = <0>;
> > +
> > +				operating-points-v2 = <&dp_opp_table>;
> > +				power-domains = <&rpmhpd RPMHPD_MMCX>;
> > +
> > +				status = "disabled";
> > +
> > +				ports {
> > +					#address-cells = <1>;
> > +					#size-cells = <0>;
> > +
> > +					port@0 {
> > +						reg = <0>;
> > +
> > +						mdss_dp0_in: endpoint {
> > +							remote-endpoint = <&dpu_intf0_out>;
> > +						};
> > +					};
> > +
> > +					port@1 {
> > +						reg = <1>;
> > +
> > +						mdss_dp0_out: endpoint {
> > +							remote-endpoint = <&usb_dp_qmpphy_dp_in>;
> > +						};
> > +					};
> > +				};
> > +
> > +				dp_opp_table: opp-table {
> > +					compatible = "operating-points-v2";
> > +
> > +					opp-162000000 {
> > +						opp-hz = /bits/ 64 <162000000>;
> > +						required-opps = <&rpmhpd_opp_low_svs_d1>;
> > +					};
> 
> > +
> > +					opp-270000000 {
> > +						opp-hz = /bits/ 64 <270000000>;
> > +						required-opps = <&rpmhpd_opp_low_svs>;
> > +					};
> > +
> > +					opp-540000000 {
> > +						opp-hz = /bits/ 64 <540000000>;
> > +						required-opps = <&rpmhpd_opp_svs_l1>;
> > +					};
> Weirdly enough the 540 rate isn't in the clock plan for the pclk
> and so isn't 162

Nevertheless we need them for the DP to work.

> 
> > +
> > +					opp-810000000 {
> > +						opp-hz = /bits/ 64 <810000000>;
> > +						required-opps = <&rpmhpd_opp_nom>;
> > +					};
> > +				};
> > +			};
> 
> [...]
> 
> > +				assigned-clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK_SRC>,
> > +						  <&dispcc DISP_CC_MDSS_PCLK0_CLK_SRC>;
> > +				assigned-clock-parents = <&mdss_dsi0_phy 0>,
> > +							 <&mdss_dsi0_phy 1>;
> 
> Krzysztof recently introduced defines for these

Ack, I will update once we resolve two remaining points.

> 
> Konrad

-- 
With best wishes
Dmitry
