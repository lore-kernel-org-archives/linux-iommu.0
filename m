Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA3A374187
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 14:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778681840; cv=none; b=tO9P2kAi9vLMSIEaLX5L3WqY34Y1J2RRhtR5ZCl5L1g8usUbA/2T+Q/pqAw7wd1ki0ayThhqx7Uk+nABgpHBGx+JX4EEofeJoW9ZK1jjT+f5pn6sGwo6c4f8Hst4W/KdypRYb2OTP9TTi+6XOHPL66hOpOgwgneHfsIiHI9IEXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778681840; c=relaxed/simple;
	bh=YeEmJtfOi3ruRtgyvbxnJAIRcn/yh4Hvqz3vDI5g6vI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/fJgMnPddRxLY0yPrVTBbbLU6305kpqp0MprKQMeAo3rZ3wpSJjwS6EkIwT2clJeo1aw2tAUaRwuWfNMTvkvEa1xA1cSAkhak9GbcFeM1kER9w8jDVsgK6Lpb5viT6VNFbAQBV90XE4jEUse9yn4ijezwBFrVSGA5V5Ms7oFYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZUsDcuy5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TXPoZFMI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZUsDcuy5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TXPoZFMI"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DA9mJl2339070
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 14:17:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=QtxV0KKT8L1h7QSyHNrHfjcD
	HL1rGc5XA2EQyHwr5js=; b=ZUsDcuy5NaFXCR6sq23leJdpmh73sJaL5l3my4li
	s9unSjEugOP9imXwVNVOxmDVwShddeMVfK44GMfL54LqBMjGzbk7K2a02VRnl3iH
	DYnZc6vpnHO8ZNSzXfKyLqHOHZaXu0ZoRsz9hSQZ+O69PajnKhYO1Jr3i28Tugvh
	Q9IabM5a0xLqacLJuMEm/Md5+dXBU8hyv5EbDlyDGeXBXuk0DI7j4PnzyRjVGpbz
	IUGl1HoCLM6tyeLRfTlW6tqjhEDTE+7AVnFNUkQX42oB/x55gSedmd7psxBFoea/
	GYwEqjCIhbqck0+TJGJXi9uqsAfvAGgb1BoKuq0AVQVmSA==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e49vxbu8k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 14:17:13 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-6961bdde2a1so13965279eaf.2
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 07:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778681833; x=1779286633; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QtxV0KKT8L1h7QSyHNrHfjcDHL1rGc5XA2EQyHwr5js=;
        b=TXPoZFMIoIrsUWprVzp/GQbn6Vpl2XkAV/HO5FBoqrIMRhza1TKxTwXx/1/+bbuJIU
         yt8u+Fwajk/up5CE/mM/CqchLwmV1H9paP+O+CppoORFNKjdpW+0JmqXLsuyoQ3+fruu
         aeDPaQTaVgmQuH+02KIH4Fg0PtTiZ8Ko3GwgnIrTLni23zzYt5M1snBTebfxvv1E7vjd
         +gk/Cq6wtivMR4S53T2UEDrDiSxd8I/Ez3Z9HaCkrJVB3ls2f5cwPkZ8VKho8Ilp4Urf
         Gy22xTYvmUB8oRE8q9fir5hpRaDIVL2/fkxcVYIoUNtX9gKwpwdouNWrCeuAKzB0i76J
         rN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778681833; x=1779286633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QtxV0KKT8L1h7QSyHNrHfjcDHL1rGc5XA2EQyHwr5js=;
        b=J2aCcKUTkGfw56V/MtDb45Bha0lnHCHzhvtHAcNsPtxL707GLn+9B/537Tl0SF3Kdp
         MPyOWifdt8xvTn/81pr/7YSMrS4lHn61SzXT4CGtKZi/enZ0ozOTOzMKk9P0fsaZSrBs
         n4akAExm3msZvk2Gz3RRP2kbU9HR625rhouIzIPBixG2ZwznoCzIcDwQB33T0S/UI11K
         l7w+r1AZzgMca6brOEzIkUhiZ+BMWAgcBk5fwpn/zt1KcPRtcBI53GgJH/mQWSP+MLXX
         xW5g0X8gLaBwNgyWXGwa4EShFUP27KT5XOD1VyUUM6AttEhSBAjKjWvW4w6VsCgP+aTR
         Pi4g==
X-Forwarded-Encrypted: i=1; AFNElJ8Xg+NR5PQcz0LqBcpMO8GBqU47OOwpdHJ8IJDP8dZS4L/iPPH7qd2lKQInmfOfuPzc5yBleg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzJq42kGGXffdbqk9+Mg7jRdrou0ChDvgLzglX6iGCM0LZCD2UD
	ljVJeuefdn83czuQJRuYpMapL0iq8rvI4mvArw2miG/Wg4s8t3SnxRIyiPqSRqdxRF1SQXqFm8C
	f2qn4WREGN2bsdLyCCHPGz1+lWc5lvX5osV/8YGOEoYuut8GtwDmATeyTcQ==
X-Gm-Gg: Acq92OGUkkgCBXVWl37Er5rEKvsYOo/LN/gfB5ZkBgVtonJdMHEB4P0Ior5rHzyDExR
	x5Av5/sn4FIOL4F/yc+2MiepR8fHqhQc4pt6wi7eDjENERR2pkVdR03KAJJG5URkzWEOYobwIJq
	rmQO6inttsBM0qYVcNy/DBzLKbEAQ2f0j0XkOo0OM+o641+NE6+4wDihWjemvw13YcfJXQBqjJi
	29ft/MiHbvFoeAKqCRVuk+kz8pEzcJQLMzs6TeI6cx6DUtpHVqKUABg5zJ6eiFOgqF7nF1GdpHW
	9i6tJaEXNcYCV13uLeDlRQ7oecuUdiVpJH4FNjCa9S9Hk/neqvx0J0LI2P6aLvC8gEwV7FBO3oO
	ej913QZqDmMFyPo/Fv6CvZ+ovaINNKW8uamA82HgdyL17ll9k0trBuufChaBk4qh1vbv9Pjnszd
	wKT7bwKcxeFrM01uPwUnF9WQENmv8/yNO6qYU=
X-Received: by 2002:a05:6820:3082:b0:696:2430:3277 with SMTP id 006d021491bc7-69b7ab28ceamr1456193eaf.29.1778681832699;
        Wed, 13 May 2026 07:17:12 -0700 (PDT)
X-Received: by 2002:a05:6820:3082:b0:696:2430:3277 with SMTP id 006d021491bc7-69b7ab28ceamr1456137eaf.29.1778681832217;
        Wed, 13 May 2026 07:17:12 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f5f18e63sm40854351fa.5.2026.05.13.07.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 07:17:10 -0700 (PDT)
Date: Wed, 13 May 2026 17:17:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
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
Message-ID: <wequp7ogk2az3d7yzfxn7wwlr6k5ng2jwrg6anaidseteuwlev@v47yoo4j2gbz>
References: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
 <20260509-glymur-v5-12-7fbb340c5dbd@oss.qualcomm.com>
 <jfypqc5ise7uezog3lwmmrzddbsctir6ze24ma4vp4zgcuwjbf@4443jqib6nxw>
 <b6dc6b32-26ad-6f2e-dfd4-551e7fd0481e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6dc6b32-26ad-6f2e-dfd4-551e7fd0481e@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 1fgwYfkVZEHMfJcqwPn2c_ZYOSk3bGJA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE0NyBTYWx0ZWRfX7q1akJVJf0PL
 GgWum/tmY2fK/6qAxOuUXVS9hdza0Hhra6ddStnKhE5mxDVwlgmve0xmNbAdj7Cm9AlkCxVDxEA
 YJC9tNJ8DzaoNoV3CiZHYvcLJkxxCBa+ELuIDuRSbDSv7lcEuSG46/3pGPg45TTfeU+pMV3bY7C
 uvE9+MdeCYQmrwRfgsJAiX+2nfZDNoJsPap86qPnEi/TxtAM4E+8uF7D1PDnwx5daeQKQKJ5AVB
 yUArkKNA0XrtrAHaF5E60aiaqY6e3QGx5kW8xwAyalu1/B1EIoyWZxWMkpDysx7aBDWjacyTe3R
 S542Ct8Dyj1dM4jUzp9RQQXksehf7rFVxCPmNPDg/wX2Mg196JGy0J3Q6y6TvN3GufOPTVJjA3e
 DxjaxyvePyRpnMKyLlGdLPQwfQxHUZY45+ptqvWNQxv2VZixJ7W0V0W+nNomZisKbHeUOFf75sA
 97Kef9PUp2B0BrNqsdg==
X-Proofpoint-GUID: 1fgwYfkVZEHMfJcqwPn2c_ZYOSk3bGJA
X-Authority-Analysis: v=2.4 cv=A8Fc+aWG c=1 sm=1 tr=0 ts=6a0487e9 cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=4BxVqlV7uxTxpwANZs4A:9 a=CjuIK1q_8ugA:10 a=rBiNkAWo9uy_4UTK5NWh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130147

On Mon, May 11, 2026 at 09:45:01PM +0530, Vishnu Reddy wrote:
> 
> On 5/9/2026 2:35 AM, Dmitry Baryshkov wrote:
> > On Sat, May 09, 2026 at 12:30:01AM +0530, Vishnu Reddy wrote:
> >> On glymur platform, the iris core shares most properties with the
> >> iris core on the SM8550 platform. The major difference is that glymur
> >> integrates two codec cores (vcodec0 and vcodec1), while SM8550 has only
> >> one. Add glymur specific platform data, reusing SM8550 definitions
> >> wherever applicable.
> > This leave me in confusion. Having two cores, each with its own set of
> > clocks and pm domains, I'd have expected that each core scales
> > independently. I.e. if the load is pushed to the core0, it requires
> > core0 clocks to go higher (while core1 clocks can stay at the low freq).
> > Or, at least, the clocks would be set to the frequency corresponding to
> > the max of the workloads (if for some reason the cores should stay in
> > sync).
> >
> > However, I don't see it in the code. All clocks and all power domains
> > seem do be scaled using the common workload. If my assumptions were not
> > correct, please explain it in the commit message.
> 
> The OPP core logic sets the rpmhpd level and clock rate based on the OPP table
> defined in the DT node, where the clock frequency and power rail level are
> tightly coupled together. Since vcodec0 and vcodec1 share the same power rails,
> independently scaling one clock high while keeping the other low is not
> straightforward within this OPP framework.
> 
> Do you have any suggestion on how best to handle per core independent clock
> scaling within these constraints?

This would require more plumbing and driver changes, but:

	iris: video-codec@foo {
		compatible = "qcom,glymur-iris",
		clocks = <only-core-clocks>;
		resets = <only-core-resets>;

		/* or core@0 */
		codec@0 {
			clocks, resets, power-domains;
			operating-points-v2 = <&iris_opp_table>
		};

		/* or core@1 */
		codec@1 {
			clocks, resets, power-domains;
			operating-points-v2 = <&iris_opp_table>
		};

		iris_opp_table: opp-table {
			compatible = "operating-points-v2"
		};
	};

> 
> >> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> >> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> >> ---
> >>  drivers/media/platform/qcom/iris/Makefile          |  1 +
> >>  .../platform/qcom/iris/iris_platform_common.h      |  5 ++
> >>  .../media/platform/qcom/iris/iris_platform_gen2.c  | 99 ++++++++++++++++++++++
> >>  .../platform/qcom/iris/iris_platform_glymur.c      | 97 +++++++++++++++++++++
> >>  .../platform/qcom/iris/iris_platform_glymur.h      | 17 ++++
> >>  drivers/media/platform/qcom/iris/iris_probe.c      |  4 +
> >>  6 files changed, 223 insertions(+)
> >>

-- 
With best wishes
Dmitry
