Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058693ECBE8
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779286802; cv=none; b=ti/4nWyFN3m6zW4k7q1ko5BkimXzllFV63Z0k4kpbjfvgnnG6g9cqJK8cJp9Jhb4cBnLB1ZugKixPco4oAH69Jgj1q+0vo91VPA+vdhtgtg3f2W427Zd3g8pv4AIA1lp5YVkvcNi4Q+XSTwvFUpZypbTcygwQqbTNijO6mooHUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779286802; c=relaxed/simple;
	bh=rCPGrnr1hJQU0fy5uz67DYTNGl7r43EjAnLT/MB66jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+ikaAEw82KrWX4oWbD7CskkL7vrBwDi2BRuS6jRefvSIJCWGrZrAlL0NOJnGvAd8hDlScx8JysFY0zs6UhFv6Nijjr7nG7/vqBa7VEaDHWqpzRzoEgUb6Pb4M42WT/75ewj7OFMb+oi7B4PsSAQytY0xPn+JPb3ng5R5frN5/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UgWvSvcc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AsHSj4i2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UgWvSvcc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AsHSj4i2"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KE6SoY118974
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 14:19:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=6tCnNFj4WCxpcwrHOfsYOWMW
	qwLTQRnnuiD3kfu4AiI=; b=UgWvSvccqLfXw468Tkb1E8z6KQ+1FXfgivcyie7X
	7mRZ4oCLQU1RX9AnUfRXMQrsZMMMiDgAVw1X6NOgmCry+U0AELq6l19HEamwzETn
	3gg5F6tydxeCV6hvpsj/COwqFRUSJoCNzxQgEaaPqYVTCLq71D0ajGtpX+OeeqOq
	HhG74oxpccO/ary6rB+UwoAHJ1Pv9dIY4ZuX+tp8HMgDtY3Uw6TQ0jS5nB2TzzkG
	CKUC9UbymTzuzqxqNWBHg38Fqm4K0lK+Im7H2LDH7Kr2h8eGe17dYPmROTcR/1AI
	lE7cFSgZTKqxEMB5bh3X9ggyJsBA9U7rpLT+t2G5L3890g==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ee881h9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 14:19:54 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-575597e1259so4163715e0c.1
        for <iommu@lists.linux.dev>; Wed, 20 May 2026 07:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779286793; x=1779891593; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6tCnNFj4WCxpcwrHOfsYOWMWqwLTQRnnuiD3kfu4AiI=;
        b=AsHSj4i2pRPMCGLkoVfJ1OwkzNR+8CLNfa1plQYXKesjmyVBvjid3JGQyw2PHa+UbB
         QXgAwLd7d4Jej2/qZpv3nOD2BY5h4AKj0nmhzxWtoWWQJ7J9obfukJEURkhfbBII26f6
         FVa4FyLtjj1tCSk9v2RAWowcf/3OIMKAQt6Hd28hQ7TR57iVUt8lhHO7zFNmon4UlFfA
         Hlei0KczlbnorAJifrkY/XF0jNzBSezPwisl6BStfqLmvjwltAFh0Wd7aAzfkwZTUSi+
         mBlqjKm9sUwYaNjhgYwmdaPkxjikuycyqRNLeczsvd0mmAxVVrHLVzn2hMPPnr+4QwQo
         x/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779286793; x=1779891593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6tCnNFj4WCxpcwrHOfsYOWMWqwLTQRnnuiD3kfu4AiI=;
        b=f/5KI/a6btoP3JIxkIPS6gwoCS/2V5Z11TtLAe6b0XXYzbIYTuW0Yxrz/iRvF9tyXz
         I5y/mzrruOrDYme0TtTYe3CQy57+oi8+cE7NMXyYu7g8yLk8GZtaVKU4wwnVWWWnKolU
         xy4tOrV60pK+vzyXxsLfjsTKqMA+AwkpYRRezwlMpmNR6kuFd+khD38L9nzAYwUOZzyL
         /wjLOQ/aUP7w5QrFrWW+WXxVsd14WkeJyrNXjsA7EHbLHFtKTiRCm6cDQVzzg51lsLq6
         IASoiDwjsDAqcUA5MBaJvHRuSuuhjcgilRP7f6GyvUOjAaazagIkqQoCgwujR1dpr9Xo
         0J4w==
X-Forwarded-Encrypted: i=1; AFNElJ9jgfoBSIaCnUzfF36NnyrlXquVfzMFUBDQZPAAnc0VlcWSzazStK91KMF72emRMlWXbQvyKA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwRm6ozTmRoYFdxVowmqwdUmtQMOe7TKSEZGHcV8C5Tk8zFubEH
	wUfxLzbX0m6llVK2+0WG67TKnr3Zdl+Hk2y4TdX3bbdte4y617PRClpptbKx91Aa/oWB3JaWPKz
	T6Rhzm4Og1GqAjoAFQgPWOPBKojHuP9Ys5gksnYwUTCV6bT1FDYUNdzwJVw==
X-Gm-Gg: Acq92OFjN7NFTHEz7QJCWxrvmRWcbCF9e6W8UBOpIozF4x8LsKMQubbEgnnZw5amfm2
	WHtNhd4Yz48GZd1lODzinUFfEqnY1EpLruFMHpyRhrlbOrkILUt1EhCewhrKGldBVYlEMDTIUIr
	XSdmXD/psjZD1a3r5RvDPHzBOV1DdI1cr/fegCOzDaw9T1QuuD8RnWOwN0v9WxnJbQDIjib4Qc+
	p60+eRfX3SnW+hgZDQDrGgR5KSzHcQ+m2nsBGaBBLQzjdanOjwVAaLvb2H+113gPt7o5G4Fd0cd
	+8PJNm4RQmJuZBWgidAgMZ9HCkxpBoCjnCFBMDWMp9+xg4FINwSvhuKcYBGuPmcng1Oxb7YR7se
	oOJbcPOt10dt0NlFjr2hYI9YfFmwYDWFXPsNDw/R9har/5ppaNJEXvS6nbSW9EYM0Ry5uwMqWTR
	gA1S3JTty0EvpEWpTkxrXTswCMCSy7/bRHDCU=
X-Received: by 2002:a05:6122:828e:b0:577:559a:3ef8 with SMTP id 71dfb90a1353d-577559a4a34mr8499317e0c.11.1779286793198;
        Wed, 20 May 2026 07:19:53 -0700 (PDT)
X-Received: by 2002:a05:6122:828e:b0:577:559a:3ef8 with SMTP id 71dfb90a1353d-577559a4a34mr8499265e0c.11.1779286792601;
        Wed, 20 May 2026 07:19:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a9164bc12asm4981844e87.42.2026.05.20.07.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 07:19:51 -0700 (PDT)
Date: Wed, 20 May 2026 17:19:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: ekansh.gupta@oss.qualcomm.com
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>, srini@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org,
        robin.clark@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH 05/15] iommu: Add QDA compute context bank bus to
 iommu_buses
Message-ID: <hhqbykyitoqjyekwn3tdv6ytzzg7hv27tqj5h26frxxoe2j3do@zzng2lmpfz2i>
References: <20260519-qda-series-v1-0-b2d984c297f8@oss.qualcomm.com>
 <20260519-qda-series-v1-5-b2d984c297f8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519-qda-series-v1-5-b2d984c297f8@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 0JDLI3dnljEuLuNoE9Vy1-Y6hzylu8OA
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a0dc30a cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=lBWuVeWgvPZisQjhOOYA:9 a=CjuIK1q_8ugA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEzOSBTYWx0ZWRfX5tsNiS9qbkR1
 YCry3twzA7f+9OYa7ariTxiqZFP2cjU8QookAWpOQfLi0yEOCtsRZvV7FhLgJ2nl99k8LqlOj2m
 ht17K+4SAFGBIL5g1TuA87nAZ4pXVBssiymTl1NmrwB3EYAk+nN/pdKT7N0PdXjUqodiS2OACom
 TCBeewjlzAqz94Dr13R2oTuNzEl9V0wj4cJtb6G+1Rt5bMwgbZiFiel8CVwPjm2+8htOJ4KSC9I
 P2cCCarK7ydWC+1ZxnGgg70A7Xj/KyiCbchjaUaTWwSgZ3/AlwRga0jixwePNVI0LmPjuVh1ke4
 Ik+NFHgD6cdG06UuBS5i0F+ntAyOL4FrhpaiE/PNtUudl7sr7TpB/JshxtmhlJfph/aZzXn/Y8E
 EuMS6i8SIwQ9+zE8zb0oG9zOXAPY16ckIIHvQhZp0zvI4ExlsICcPVFTCjlJ4E2HMFMyZJBe9vL
 XwrjF8sTFHeC/FRPWGA==
X-Proofpoint-GUID: 0JDLI3dnljEuLuNoE9Vy1-Y6hzylu8OA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200139

On Tue, May 19, 2026 at 11:45:55AM +0530, Ekansh Gupta via B4 Relay wrote:
> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> 
> Register the QDA compute context bank bus (qda-compute-cb) with the
> IOMMU subsystem by adding it to the iommu_buses[] array.
> 
> The QDA driver creates synthetic devices on this bus to represent
> IOMMU context banks (CBs). Each CB device needs its own IOMMU domain
> so that the DSP memory manager can enforce per-session address space
> isolation. Without this registration, the IOMMU subsystem does not
> probe CB devices for IOMMU groups and of_dma_configure() in the bus
> dma_configure callback has no IOMMU domain to attach to.
> 
> Assisted-by: Claude:claude-4-6-sonnet
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
>  drivers/iommu/iommu.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
