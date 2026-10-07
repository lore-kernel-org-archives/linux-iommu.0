Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61603546F9
	for <iommu@lists.linux.dev>; Wed,  7 Oct 2026 07:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791356600; cv=none; b=XIsfXD6rIUmoewPsmWN4LekbA4ErJ/DwoZ+OAxJMzns19cJN8Sh5eCWOxNTSxxpz+BO4aIHIvS/6XBnudAFrEYLuBI/EFVTarjOOuyWOi6djRTQ7x3tE8V5Cu4ZGkUmA9Wip4lzDiG2ZB+NYJvsbNBuJwWYhI3tCrhSzNC9ZhJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791356600; c=relaxed/simple;
	bh=ogEzu6UuBrOBMLU1YQ+/foOwKAGOPzGySwOnvVrCrBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9OzoUxTCtoi3VDGeQZlT0QxM+dsejeN1cxzn7eaVnA7SZZT7tk/09OkRMNPeqLYVSias6DUd1QU4eEpQuldUa5UWTUr1cIkH6IidJ96zwz0PHMYzzxAYTSXIYAnR6bsv1ut+8l0s+509KJC4q7gnzgCzje+85kRj7lAAdDicds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TVE1ICbm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ixAY20Jn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TVE1ICbm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ixAY20Jn"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6974U6OF2916052
	for <iommu@lists.linux.dev>; Wed, 7 Oct 2026 07:03:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=821v8tlX6UL8RPAzc5juUnjm
	9WDDhS722BB+xkV9YBs=; b=TVE1ICbmkkYZgbIAKI8aLQQJ2Lt4g0HPSHosjhhx
	azh1mwSx6toh4aavK/8l7SoSDOdXqJi+EripNJZkG/yjLm3Z4qX2HxNlSDATwWz4
	R6QMGM0dBxX43rz2SRex2ANNnwkUC8EVrpemw92PtQOWg476WwSPAtlun/4JS5cr
	xoax+OAdsjDaCyLtkszMq4f85bZXGqsvSgoolpNOvG1JJv+wB3i0Bu2kH0LN+kh7
	SfZZBBHD5dO04iS/+1OUwlKlq7QHyLDVVBmIZInV6uk+3bR1IKtdFlx86HwOREja
	Btvay3mRBjCCiudYaANZ5qG5uT9mxIN2LuoLYd1/RAJvZQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h54622xhh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 07 Oct 2026 07:03:19 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93a3f673221so983975885a.0
        for <iommu@lists.linux.dev>; Wed, 07 Oct 2026 00:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791356598; x=1791961398; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=821v8tlX6UL8RPAzc5juUnjm9WDDhS722BB+xkV9YBs=;
        b=ixAY20Jnchh/XM6aV48ldWMrWy1PN3qjVDhalWMCrkJYjkX0xRDRkaSgeGkcsbkPmr
         j6H3OahXEnJtZOG6cLff2q50iaFqFmCSmuKsLb85uRbuEIVdgFaBEP1TDOLs52kV1KmW
         kZOXt1+cf3zQBdgyBrs//TqxfgtntuQU0o/vzIiJtllvNFSYwEU/xS/6CoJRSyKXN/tu
         vsInCJpi3HGJHHyGisPtlT7E2pUwpma6D/jxKQKBIevLIzdwjP506Y8AtJDW3PcWzQAQ
         EMl6ZLjPY+VgH7Wb1uDVE2IjFHVuQA9aZYB5dqaeAWdCyhA+R5RTraBf2x+l97BXJkCg
         M/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791356598; x=1791961398;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=821v8tlX6UL8RPAzc5juUnjm9WDDhS722BB+xkV9YBs=;
        b=OI5NifuMsbmyXQjT/S2rk/bm5BXzAPy9kpYtclbzlLEbnEA9dd3VTo+idbx2nUscbr
         cwu3J5rbfhgYqu9AnFIVBCgrWizrEljqQy76Omx5MdmgYgAYwN6KGqIOn29LDbxVAN3D
         ejm6RGmkCk+d0X0T4F75oE99ZxiTqr+5buve75WHgWoXm3oPX+jErSl/9pfUDk3kRUvT
         OpVRtLxAIyWw190R/RFMW0/RYY1p0riF4VOfS8f50XHCkodWyf5/VujB7+sMAMl9uLRG
         JIpsbxVu5uvcTRoTOkZMF8rHLFwZnU4SpctQi135DsUNmr0sRglnuFLRFG+Sfn6GWdSF
         yoSg==
X-Forwarded-Encrypted: i=1; AKwUvBzfoQqStXJCoxxxJwVo2QpS34234glItuyss5dLsG0JBi3syjtBlL2GCkHysmz3Ibg5jsyCuA==@lists.linux.dev
X-Gm-Message-State: AFuF++kHzkkTj+cxRxW+CJjlvmYyFX7HPjDh4g3xW8QPIDpkjzwCBiYe
	Axh6EZS/ppty2FthSMaYaxa/1IwiFskKLOaexQ5Y4l9xKaVY5+mqKnqVLP+O5g9c0AwmpuIO1Wa
	sqvL4djE47o8wjgaehFW2Rm74a+bUpb1/XajsSeOBRzCR+ZAJtTZ8UG2XMA==
X-Gm-Gg: AYBFou0nlrSlTN9PwkMNE7lr2P4SJXmnNpCPoRJ21eBiiZRNjcCtsyG68VyRzbQ6sTm
	+U8sTSxDdF9FhJ10BQcVv+I7nuoG96SLl061fqGxes28TTejANC4AhDUYpn5vFOC36LRh2XWjGR
	3xn1LmLpWrERX8hxJRlWXbXeq48oGdnkAN3voAX6A9d24XdO+PgxDKXPBzr4+YRHiY0kUnHs66r
	79IVicAdgOaql/15d9n7p+4o2arMxMikdU3iajDDs0aRWFs9a09akxWo6MPsumZH9wDbB9kH2ju
	sk+QcxATZ98D/if1mz4s+yHeFlPqv7ET2O2yNmA0MkwraIDxw0sQHVOCkCKz0mIgo+4NXSNh0eS
	n6LryWcTizoFElO1hqX2oUrNA8fpOWO/5ogukGUXoca8n+ax57wvzVvpH/PwT5snY1rOqo4RSv3
	UQrbdLw71DqCTH
X-Received: by 2002:a05:620a:46a6:b0:93e:9807:9785 with SMTP id af79cd13be357-93e9b829e93mr263582485a.70.1791356597958;
        Wed, 07 Oct 2026 00:03:17 -0700 (PDT)
X-Received: by 2002:a05:620a:46a6:b0:93e:9807:9785 with SMTP id af79cd13be357-93e9b829e93mr263574285a.70.1791356597214;
        Wed, 07 Oct 2026 00:03:17 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bccfe9d3e2sm417662e87.58.2026.10.07.00.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 00:03:15 -0700 (PDT)
Date: Wed, 7 Oct 2026 10:03:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Muzaffer Kadir <muzafferkadir@mainlining.org>
Cc: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-pm@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v4 4/7] thermal: qcom: tsens: Add support for MSM8952
 tsens
Message-ID: <ze6klawno4rge2276cqwdiutvwbcnd7yby2l2x2gubwone36sg@zk3odztmoojw>
References: <20261006-msm8952-initial-support-v4-0-ecdcc1ac620c@mainlining.org>
 <20261006-msm8952-initial-support-v4-4-ecdcc1ac620c@mainlining.org>
 <suzsbvsdlfrfsnvaerphqdycaaaiu5inh5uw5wups4jmfozkbt@n4lsb5pfdhbw>
 <f0b58a7b-6257-4dc3-b0f3-eba76ecc774f@mainlining.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0b58a7b-6257-4dc3-b0f3-eba76ecc774f@mainlining.org>
X-Proofpoint-GUID: 5ugzzI4T1J9TKYHdEMAKGBOLyeuzYpS9
X-Authority-Analysis: v=2.4 cv=ZZiIpcVA c=1 sm=1 tr=0 ts=6ac5eeb7 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=Oh2cFVv5AAAA:8
 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8 a=FwduPMDodLxw-pZHfsYA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=7KeoIwV6GZqOttXkcoxL:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAyNyBTYWx0ZWRfX+NKBzv67jWaH
 3S50f/zBLURLpH0l0P8Xjl2MQXA+NVeqSCPRJkEcrOR0lDDd7eNoQcNSDDlpXUbS47Cf63Pdrtp
 veloRWeqfsrG5CkB5S7SIKvystxHJC0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAyNyBTYWx0ZWRfX+M1g3iGB5hA5
 FrRTMp2Z7du0p0XLiDKDszYhZ8bwHTTQoVNo1i+2ANUQAAB+jUGKXjX9Aj466k+wBiSk+Xoj1X7
 RYp6j560I8NKAXZukfpQKfUgiSdh7UkPtCUOAMdF3nQtq1CFgzgNMyRjaS1uKtLAqYeWI/YJHbG
 s8Vjpwfp7hUy9T3KzPozcbCJfF/+dq9ahDgcclzC5wNOvo+JjMMsfUyEZbQTsHdrL6PIZw5SdSR
 hMcexYtqqo9UHNYb11G0JyaX1hw4rvBM8Cy7PWJk5WjpN37UKEFF6jIPTNFwS+yivrZ5s7RXfXo
 UqgChJyG93tCTZ9Muw4viRP9r+ZWRHVvuShMhAGUjXBKWGmQCMabmxnLnOrcbPYYVfFbVWafDe0
 k0b02ECAmZdPS1F8+7JuSa6PTdAxxtDt783a4tBfo0NXhPALwH7MMgf+Nhhod1XjS01321s4lD6
 8aYVpHMAR8BbY9cQpjA==
X-Proofpoint-ORIG-GUID: 5ugzzI4T1J9TKYHdEMAKGBOLyeuzYpS9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070027

On Tue, Oct 06, 2026 at 04:49:12PM +0300, Muzaffer Kadir wrote:
> On Tue, 6 Oct 2026 16:19:04 +0300, Dmitry Baryshkov wrote:
> > On Tue, Oct 06, 2026 at 03:15:11PM +0300, Muzaffer Kadir via B4 Relay wrote:
> >> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> >>
> >> Add support for tsens v1 block that exists on MSM8952
> >> with 11 tsens sensors. Sensor Offsets and slope values
> >> are taken from downstream.
> >>
> >> Link: https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-wear-7.0.0_r0.3/drivers/thermal/msm-tsens.c#1621
> >> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> >> ---
> >>  drivers/thermal/qcom/tsens-v1.c | 44 +++++++++++++++++++++++++++++++++++++++++
> >>  drivers/thermal/qcom/tsens.c    |  3 +++
> >>  drivers/thermal/qcom/tsens.h    |  2 +-
> >>  3 files changed, 48 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
> >> index faa5d00788ca..f4201748ea29 100644
> >> --- a/drivers/thermal/qcom/tsens-v1.c
> >> +++ b/drivers/thermal/qcom/tsens-v1.c
> >> @@ -145,6 +145,37 @@ static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
> >>  	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
> >>  };
> >>  
> >> +static int __init init_8952(struct tsens_priv *priv)
> >> +{
> >> +	for (int i = 0; i < priv->num_sensors; ++i)
> >> +		priv->sensor[i].slope = 3200;
> > 
> > Where are these values coming from? The driver that you pointed out
> > reads them from the QFPROM (like other tsens platforms do).
> 
> Hi Dmitry,
> 
> Slope is coming from this:
> https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-wear-7.0.0_r0.3/arch/arm/boot/dts/qcom/msm8952.dtsi#550
> 
> calib_offset values are coming from these:
> https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-wear-7.0.0_r0.3/drivers/thermal/msm-tsens.c#1756
> https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-wear-7.0.0_r0.3/drivers/thermal/msm-tsens.c#1800
> 
> Should I drop them?

The slope you are setting matches the SLOPE_DEFAULT, so I guess it can
be removed.

With that in place:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
