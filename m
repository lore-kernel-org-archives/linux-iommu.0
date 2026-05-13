Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC530407596
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 16:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778688214; cv=none; b=tLmQTC0/kO4nb3GEa7vlZTFtltiD7uJpVVv96PiTEQbuKn2qdf/pAMmBiIy7djNCtXaA4amFzDEIN/f9cN9nhCOgrw0Soo+ThxeoT9gXDGyHdYCWveZ7tjWXoLvMQ6ogwVG4LzMwDb0upZM+WvwjlqE5P6JIRwq5gCcfMWizXxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778688214; c=relaxed/simple;
	bh=IPussI9+XR+OMGoWSyITYw/AG1L9oEhc8WjN5WRKb/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4Gb+rQEiQYz3zK42HgI3cmoh4zk8SPjooTKHi9A+5XWJbB1P4IsoTmc81tV+URPI4x79/HVnnQaXdLQG7PAp9Nsr0K37ShSTEZG7V8xMRvnQ8O6InGLJXB3MW9Uy6jCQmKMxZSxdjigSTSGez8gxzGgt57ShNb27hWckFzQP6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SNHK1qX5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=khU7Nwki; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SNHK1qX5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="khU7Nwki"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DEgDUK2888326
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 16:03:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=JtsUbfOF0IzhkH+UeMM1imcj
	ZI06IeYaZqg2oXtq3YQ=; b=SNHK1qX52+A1cKbxDLIYcD3thn/E0c6hEG2/JZNX
	CaCdz4jNOMfBvY2z+0WwRX4bkR02rTNerNsb8VdoRhrn/duF7pzcnpT169ClgpbB
	lwD/VyzBbT6XxpwQQ7Terij4VXgTq9R6QNXJh/uwIk/HkH+0ISxEJQ0BIp+HVIcR
	yQF2YiXIB/A5irat9KM9qb5PjPduy3p/Ni5IoCeVM6QCVZ7O3smrN9gua4cdUWZE
	99vMcIWj5IxF9r3d4e9xK+w2QuFkYdvC/SR/e9eJ1oZG2re6AGwwhv4xRv9X5ray
	bfS05Z3OS6vHl7bF8QCVH5cUH7WumuKWil/FmD3o84P5ww==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4p4ghqst-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 16:03:32 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-69b76062cffso2124567eaf.1
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 09:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778688211; x=1779293011; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JtsUbfOF0IzhkH+UeMM1imcjZI06IeYaZqg2oXtq3YQ=;
        b=khU7NwkiNB+PwqPECk50Bb4OeLCeFY4sq3i3KxyHE0tMj9OoAPACaeaNiruqiie41A
         h5sE1qI1QywwOlf4C3Nt3fvzQ4mbI0NMKm8wwEHKkN4P6fsZE52zqsUVZad1D3Z43rJ5
         2Ag0kPyDJukXH0WzMjj3gUh/3Rj6ciyFRRRPFlfLChcEOYqx48OMYWRf+oHc6DeIDJmM
         nemGCQtfTtAfB+zEwbVR5Ideh3yDVTSx4g9Vm4p+3hoWghyi14jmd91R61VC+DzGZh36
         m9AbtLz61fmimnsI+bbBnubjOap8OeFuf+22kK9R2V/s8+U9o48ZrBE2qxPcVhGkgfnR
         DByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778688211; x=1779293011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JtsUbfOF0IzhkH+UeMM1imcjZI06IeYaZqg2oXtq3YQ=;
        b=fYZoMyi22XBVjQkoHLp6QjjIIpsIgaHR5yS1Y+pM0K7R1wgcHjDL/E00PDjE/1JA/e
         AY/RtN4qB+0jKKvGlif6aPNJJjXjkglsz79+kuL7P/gxdgPx9iqGCmehmsVnRvJXLbmd
         rGlPjA1+RCBoyJgsTHSjbsP6AlfWbgKQTa/HmWQRm2yzxfaqvxg0CnuiSohnfQD7smKg
         aWlsKWAYYYUgErGY4XooEPeMrSQvYhT0swrwqfR98R9Ep7aYz4emNa/ywB+bJRtpLu0G
         wXM/0ai8wvGe+j1DivenjdUgMUsUfA9TNR2SUoO2dTTb2uOfimY3sL0CA/YESarneNbz
         YyjQ==
X-Forwarded-Encrypted: i=1; AFNElJ85ch0+bs7a+UqCA+YY8UPR1evSDuyDhlXqTWMshvqSRhkHQm8Kl3sryuCNSnqXTPJnoHJVxA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+1G4CVlIJTATeUBwxiHYTNYW7Dg79jKWmwImkFzT6wveUbcuG
	Uo9n4EB/XV1rfTHVPj+qZrrFvk5kzlW9/GvM70xoKMO1+zjqY58Sjr0QJFTdsj4eijfpyQpLzLn
	bLN8Xy3o8XbkOyVZjepltbaL2luHE2e7B5ZdsvQJLYrMjO/SQyxrxuG/41g==
X-Gm-Gg: Acq92OF5Qlvzwv+cRTucFDktV0RjhY68F3yPcutHdfvGlqpznQ+Wp5tr9EDGEjrBnDh
	CgXqmE4KYFzA7hl0DucYx7D5QRqHt0Mjn4z/caibeJyOgfMuJCWPfW7r7GD5g2p7/kegSrBS2P+
	ShnAgZB/7KGsflORqWCl16210gZSKb3MqALGfiKXq369e+jOO5ID3lkh1PA+riyt+BIVsGH9qae
	sK/rrmK7dJxK+ZQ1d8qTxOdO8/sR7iL/OwxO6hBVoopRNd8W2HpyxA84jo5CaiQsqr7/4ABwvhW
	Riq1Zd4yLHXIJwVHZGIUbAHb4YP0K2W6Zu1LczSAZC/d3bZM/Q47/PlLEddtNlRfNdi00RvZ7L1
	mrrWtLrqZJfgRbfJXLp6zQFiNW8x1WrHkm3Z8sp4qDl0QES0X3vLDdiDNNMfpUH7wnU0sqhI2/J
	y/Ut20H1aAh9NAUndA8v7yLNNUp8cccf2dLps=
X-Received: by 2002:a05:6820:2201:b0:695:818c:e552 with SMTP id 006d021491bc7-69b78e471f9mr2369955eaf.55.1778688211004;
        Wed, 13 May 2026 09:03:31 -0700 (PDT)
X-Received: by 2002:a05:6820:2201:b0:695:818c:e552 with SMTP id 006d021491bc7-69b78e471f9mr2369843eaf.55.1778688210209;
        Wed, 13 May 2026 09:03:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393fa029671sm40620281fa.36.2026.05.13.09.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 09:03:28 -0700 (PDT)
Date: Wed, 13 May 2026 19:03:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
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
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 12/14] media: iris: Add platform data for glymur
Message-ID: <j5uphbr37xxv5fnmt63g2y2ulykeyovxq2ovw5dxikswrppcqh@vrwmxccsrbjw>
References: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
 <20260509-glymur-v5-12-7fbb340c5dbd@oss.qualcomm.com>
 <jfypqc5ise7uezog3lwmmrzddbsctir6ze24ma4vp4zgcuwjbf@4443jqib6nxw>
 <b6dc6b32-26ad-6f2e-dfd4-551e7fd0481e@oss.qualcomm.com>
 <wequp7ogk2az3d7yzfxn7wwlr6k5ng2jwrg6anaidseteuwlev@v47yoo4j2gbz>
 <ad875fcf-531a-49af-b58e-575185c12d77@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad875fcf-531a-49af-b58e-575185c12d77@oss.qualcomm.com>
X-Proofpoint-GUID: xfYn3acluxzm9-fXIUFXlTBrw5PmHBo3
X-Authority-Analysis: v=2.4 cv=DOS/JSNb c=1 sm=1 tr=0 ts=6a04a0d4 cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=0TAo7pVkoxE7DlbSlgkA:9 a=CjuIK1q_8ugA:10 a=rBiNkAWo9uy_4UTK5NWh:22
X-Proofpoint-ORIG-GUID: xfYn3acluxzm9-fXIUFXlTBrw5PmHBo3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE2MyBTYWx0ZWRfX9aP+OFkQoN92
 YtnwcgK+fyXu+hgxbO0F3IULc4ATLwG7zPoZjdgvLIhdOCjzNsiy9ZRJCAaHN+RgYZQj5KhDwMY
 vs3aSXCKxOWstl3jh2XhDeeyO7jrRs2MXo42fsRMxZDtvtDJSXahMOibv5I6C3UU1jevBjWHlZa
 MXqyjYjFplfXlFrjB0fwnXx06omDTNkZtqNnOxvbsbToJyXl2hQDJBhQMh9N2N124/JmmGhpz3/
 ANHa2Smux08HxktYo3LW+AFZgggE2saRXJWe/St80KFfwoLUqxQ7v3stDp+MvD2XWNjJnhoncMA
 QjNSeiMpMIC5cy6E01EBejYt7mJKlJh4wevdZqVVJzJYRqlE5Y2LOOe6IbOnqGCA94eNhLm3hnV
 Ofjzz27TrtBZCQKUUXdbsrtuM6rC3Wc5m0KaDM5nPCtT90nx2TUiSkb836ajIlASLBJb4Dfh2b4
 8wfU8t9V4JK/N6KkCWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130163

On Wed, May 13, 2026 at 08:00:39PM +0530, Vikash Garodia wrote:
> 
> 
> On 5/13/2026 7:47 PM, Dmitry Baryshkov wrote:
> > On Mon, May 11, 2026 at 09:45:01PM +0530, Vishnu Reddy wrote:
> > > 
> > > On 5/9/2026 2:35 AM, Dmitry Baryshkov wrote:
> > > > On Sat, May 09, 2026 at 12:30:01AM +0530, Vishnu Reddy wrote:
> > > > > On glymur platform, the iris core shares most properties with the
> > > > > iris core on the SM8550 platform. The major difference is that glymur
> > > > > integrates two codec cores (vcodec0 and vcodec1), while SM8550 has only
> > > > > one. Add glymur specific platform data, reusing SM8550 definitions
> > > > > wherever applicable.
> > > > This leave me in confusion. Having two cores, each with its own set of
> > > > clocks and pm domains, I'd have expected that each core scales
> > > > independently. I.e. if the load is pushed to the core0, it requires
> > > > core0 clocks to go higher (while core1 clocks can stay at the low freq).
> > > > Or, at least, the clocks would be set to the frequency corresponding to
> > > > the max of the workloads (if for some reason the cores should stay in
> > > > sync).
> > > > 
> > > > However, I don't see it in the code. All clocks and all power domains
> > > > seem do be scaled using the common workload. If my assumptions were not
> > > > correct, please explain it in the commit message.
> > > 
> > > The OPP core logic sets the rpmhpd level and clock rate based on the OPP table
> > > defined in the DT node, where the clock frequency and power rail level are
> > > tightly coupled together. Since vcodec0 and vcodec1 share the same power rails,
> > > independently scaling one clock high while keeping the other low is not
> > > straightforward within this OPP framework.
> > > 
> > > Do you have any suggestion on how best to handle per core independent clock
> > > scaling within these constraints?
> > 
> > This would require more plumbing and driver changes, but:
> > 
> > 	iris: video-codec@foo {
> > 		compatible = "qcom,glymur-iris",
> > 		clocks = <only-core-clocks>;
> > 		resets = <only-core-resets>;
> > 
> > 		/* or core@0 */
> > 		codec@0 {
> > 			clocks, resets, power-domains;
> > 			operating-points-v2 = <&iris_opp_table>
> > 		};
> > 
> > 		/* or core@1 */
> > 		codec@1 {
> > 			clocks, resets, power-domains;
> > 			operating-points-v2 = <&iris_opp_table>
> > 		};
> > 
> > 		iris_opp_table: opp-table {
> > 			compatible = "operating-points-v2"
> > 		};
> > 	};
> > 
> 
> clock source "video_cc_mvs0_clk_src" is common for both the cores. It would
> not matter if core0 is scaled for a specific workload and core1 is scaled
> for different (let say lower), as the common PLL would always generate the
> higher of them.
> 
> Infact, going with the approach of exclusive scaling would be an issue here.
> The later core scaling command would bring down/up the corner for other
> core, and could lead to under/over-voting.

Are the dividers between mvs0_clk_src and the branch clocks really R/O
in the hardware? Can they be scaled to account for the different
workloads? The commit message should capture the details of the
interaction between cores:
- Can either of them be turned off, while retaining the other one
  running?
- Can either of them run at a different frequency than the other one?
- etc.

> > > 
> > > > > Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> > > > > Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> > > > > ---
> > > > >   drivers/media/platform/qcom/iris/Makefile          |  1 +
> > > > >   .../platform/qcom/iris/iris_platform_common.h      |  5 ++
> > > > >   .../media/platform/qcom/iris/iris_platform_gen2.c  | 99 ++++++++++++++++++++++
> > > > >   .../platform/qcom/iris/iris_platform_glymur.c      | 97 +++++++++++++++++++++
> > > > >   .../platform/qcom/iris/iris_platform_glymur.h      | 17 ++++
> > > > >   drivers/media/platform/qcom/iris/iris_probe.c      |  4 +
> > > > >   6 files changed, 223 insertions(+)
> > > > > 
> > 
> 

-- 
With best wishes
Dmitry
