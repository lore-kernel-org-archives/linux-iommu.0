Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793010029;
	b=Q9qARKeeVmUrgXQX/sziLxKAVUy8wTAN4E1hy78os0aOjDRezvmEgO8eO/CRR9RwxNqi
	 f2pm6tMAu2RN0M3brLZ8KdeghVFu8Ah368r5UGw7aHSQQcm9w0b6j78T7s/yFt42tjc1H
	 hzibXJpQjzk0QTRtmh85MwiU4edWnLSBENvD22+cDpba4s69lcU2h4bxisEScGB9Oa8L9
	 ajpwGpKPrEvIU9cLp77QQLFklkzvjfMCjyKMRskD6eLLJI58V1DCmiGHZL0PF+0s8o7f2
	 G6wxMvjkXOWWTvovyU6DsVIQbUchFjA/W4tOXa3cD5DTALlQ/qRmjh+wSDIsXhHlm4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793010029;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=7FDKcPmUfm8pKhwk0XQXsdGdq3ble75jjcxbCWLT98U=;
	b=tuklGflStgLDSIJjKlYF4bGTS7QlfZZ+p+HxuHj/Ihpy/3Gnz4Hx5WzOB9u8nZQTF/1R
	 GLs/xI5y5KDQgI/T6nJ679pF8/fy38G+7V91F392RT/fwYlPnBmFFeAx8knruU3SbruaW
	 6BWNrJyLLTPQa12jz5IWFxUrD1yQVZHADu0QX6KnUlRzVdtjN/NV1f56mQ/to04yM8CwS
	 UixDijcNTALJnlpAwDlBuGT7XUgTXzSLQMB2eiwv/jj/l5XtYUWyleUCdsZEFnCWwOpGB
	 I2bQGNrWYbvudAOeBTmJ/5EJvnVillG9zRHHHmv5TQlRUaXAnzfdxMX+Jt9hm84gCRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WBa5R6DO;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dTouMHAM;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58C560A2609
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 10:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E58C560A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WBa5R6DO;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dTouMHAM
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q9aRYw2560526
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 10:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7FDKcPmUfm8pKhwk0XQXsdGdq3ble75jjcxbCWLT98U=; b=WBa5R6DOTbjnjhg6
	oR+yaDocepQyyKbFvCO8gL6By+UFGT9Xohprkgdmh7jPeGBhZAFyjKNzaOkuOypT
	ygzkq3W3+P2AB2eBq0ri/8gOaObnxIJZbgBCgl7T4MBG7s6FV7bY0VSnSZwv4NF5
	binG9KB7KqKnNomvsStayo0oaocFxa7jCR/BVD064JVSxlhcVi8cKS7vvnu6EY4b
	GSN0Ee60XYevX2wC0LUHkZQfp40FkLpgI0o0Sc4KPoXwqP332NqnWvsKeTPSH/8/
	WX6l2wAtYXEdbplrkbwhypaNUQBMopXZofmInDGYDmvKKslYj1LcLb9bEiebykoC
	v9AuwA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4cp85jk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 10:20:17 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93dd3c3badbso716549585a.2
        for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 03:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793010017; x=1793614817; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7FDKcPmUfm8pKhwk0XQXsdGdq3ble75jjcxbCWLT98U=;
        b=dTouMHAMpDw6CD6HOW4sxj8+BXSdR6o2pJlxK/OW/1I++uqV7bjbYF7ZdVbot2fuXa
         UITH5bt7snuBEIlqOqCki4qUMoLB+fd2QqtCNDlEfb4B91BKD6vVMQz9CyvRtIkELo7Z
         fFC5YZYpps8E4lvVIUsr99fNJjkYY3OHTkkrUNiPfqMZHCT3407+tYVbsuLrVR4h2xQT
         0yQANXEVEtLjNaGivjGRKJ2E/t4+uhJTSXXcMcyb8FFQpBMl8+gzQ04KDNsmEJQLry5f
         T3aKTVWPUFxK2f22Yh9VPlNfHMbW2nSV+nzgV5zTkkiLxYxykZUiFDeJw9Y/8oAGOKls
         cQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793010017; x=1793614817;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7FDKcPmUfm8pKhwk0XQXsdGdq3ble75jjcxbCWLT98U=;
        b=lstkC5RmwwM2QYa4UyazrUBjrP1AGwXRRY+O7Np8SGQQsxzCPB5UR1oSKg+fGFxkRR
         vowPUpboaW+fdnMHYiqe1s28IGpclmVHJg7HfATns27o5Qio2hpt2WPmzLRKlTepLm6A
         jPAovvvnT9RQeiEGDcHXmcarpNi+DETVIwuhNlXQuPi6vXcTO2wfeKJNoEJ6+3vlfTtN
         glTHld08HPJWgJx2qBTOPe+tRwokR0T8DtLM47HihQ4lXTYcKeBGcfjPNhJwsWDZ9Djh
         NUgczvo+qe5JFj3XcdeQOGbtksjCmqQHGi5zzj98OnJEkLDI58mSOHWRQEmEWAazIDAX
         o4FA==
X-Forwarded-Encrypted: i=1; AKwUvBzgdU4gkEvtHs3YpTdm4f3qOAp239U9bV57o59owsjSUCSfsLMoaXmEYeEmQLTrmhMIhNcPog==@lists.linux.dev
X-Gm-Message-State: AFq9FYIpl9+gFllIfyfgCeMjEF8RxYbF9YdbIIwwp22jsoOW3qihVDDG
	CrCTVWRpxR+d5tY3Jmj9uRZmgxNaLLy3VUhGZj3ZuuQAUQjAAcUX8JWgRpcnyu8Y0EpQYUGEvn1
	l9rj8TCT/T12P3plFw2qW5fJFUa6x0CMT+rFGqlYSqmJLn/mra79D9AjsHw==
X-Gm-Gg: AYBFou22qm2aZ5dRqMARo3MpRRrlgmwKyMRVR1iF7Cddk7umtbLXNsJjIsg0Te1rmK1
	Hr2LpWWAUEu9ux8+TvOleBxVqXieZA4EzpsxA9z/birJ7/s9ADs/fX8cbaDZibX7zj9J628DxHD
	7xU5xNEwsX3Zz0u1yFLDMUJHS3PwpjsxwO1bNpkVrjzabKy1qpPpKx0dLdVNCNQCCnP56jdFfrz
	tBe1XkeiHT9nNpF49pqbnUkybHxlbezUKxEfpHRYdm9HrzDw8W39aXWVOCUF52O0jbGSMJR8QHv
	QHU4DBcADl0agUaTIaR2PSZGlvvqtx2c394xhWEWs0HemfWSZRK2ODd50P0LTinMQhP/Kt9x9oW
	/luZIEJZ3lBbsr8h7VbVC49FVbI5bI8UDqs5L3VgBrF7hIQm2bbDW5Qljy6tuz177R+8MBJTCjv
	xIS6v2TNDx1K3n
X-Received: by 2002:a05:620a:4002:b0:93e:910c:5fbd with SMTP id af79cd13be357-940ef9a6dabmr876606185a.63.1793010017174;
        Mon, 26 Oct 2026 03:20:17 -0700 (PDT)
X-Received: by 2002:a05:620a:4002:b0:93e:910c:5fbd with SMTP id af79cd13be357-940ef9a6dabmr876600685a.63.1793010016682;
        Mon, 26 Oct 2026 03:20:16 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfb7a6ac6asm1437302e87.22.2026.10.26.03.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 03:20:15 -0700 (PDT)
Date: Mon, 26 Oct 2026 12:20:13 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Philipp Stanner <phasta@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        iommu@lists.linux.dev
Subject: Re: [PATCH 09/13] drm/msm/dcp: Register DCP display pipeline
Message-ID: <vd6e7jr4ciipj6ork5i36att6bamm4gpzxjdeqoqof3rdj2m4q@rtg7jop2bfwf>
References: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
 <20261015-jshekhar-drm-msm-dcp-v1-v1-9-48aad0fe4f72@oss.qualcomm.com>
 <64603812-672f-43ba-9c5b-783d666d0ac0@kernel.org>
 <c7bdcdf2-1fa4-42a5-a89f-689e688af5ae@oss.qualcomm.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7bdcdf2-1fa4-42a5-a89f-689e688af5ae@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0MSBTYWx0ZWRfXwBJn6AAS2s3N
 52ST7u2i2LFPbCNHxAk93yhC64B1JtwrP9V/z9ww1zCU3cu8jJDGB6kAEL451ZYGSxQtAWPJlh2
 1+rMyDByy1pqVzAWTJSdpauiOvKaC7Uia7z2bD3zqVcgUmlLU4zrNG/UDsETMVl1gFHA2t6p7kC
 PKaA6b1QZZeZdOTI73auCqtdP0uEjqL3PuzCelAcYtnNpGQNXa5rv2ZLf25eW4eobt4IyzYbdyN
 FVcDlvotNGZq01MiRRWGIRxur2mSXNcawDJm0bKGEX3sYBN4ZZdyfmaDoSxvGFz/fhFFRlUAkbi
 oXLhXqntebmba6iCdrvkQh78YfuGHIivpmPygm93N/m+bgoXGhMeprylp4dRb7VrZtbSIrdkKqG
 QmgiNIspG3l76wGBP30xP6onD8Qzjx8jtWosnFCIu56TATeQfu4ds6SuHymI6Ozk7EdRebKvm54
 INU582v8ASL4BayjYuA==
X-Proofpoint-GUID: BBKAoiufEb3JDT9vJMyzXZ2fWyXjuVwh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0MSBTYWx0ZWRfX7gwc/3D0P4Ho
 VjE3DigAMszDD3yMyn0ZvDhelZ1s7qaOWdieT6dD7b9wkN+RmNAU05Z7hmO2x8oWAmbZQ7EZl6C
 OyTN7sHh2U+4Uti8RomcYEk2116Htqg=
X-Proofpoint-ORIG-GUID: BBKAoiufEb3JDT9vJMyzXZ2fWyXjuVwh
X-Authority-Analysis: v=2.4 cv=TboDJhQh c=1 sm=1 tr=0 ts=6adf2961 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=XPLrJM8uNFvCFI0Cpc4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260041

On Fri, Oct 23, 2026 at 01:42:43PM +0530, Jayant Shekhar wrote:
> 
> On 21-10-2026 17:35, Krzysztof Kozlowski wrote:
> > On 15/10/2026 09:38, Jayant Shekhar wrote:
> > > The DCP firmware exposes display resources through capabilities rather than
> > > through host-visible display registers. The MSM DRM backend therefore needs
> > > to build its KMS objects from the firmware capabilities and device-tree
> > > display graph.
> > > 
> > > Complete DCP KMS registration, including power and IOMMU integration,
> > > capability handling, display-graph parsing, and creation of DRM planes,
> > > CRTCs, encoders, bridges, and connectors.
> > > 
> > > Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> > > Assisted-by: LLM
> > 
> > Your tag is the last one.
> 
> Sure, but I notice there are checkpatch errors, should we keep this or
> remove?

Read the docs?

> 
>   ● env: :3: WARNING: Non-standard signature: Assisted-by:
>   ● env: :3: ERROR: Unrecognized email address: 'LLM'
> 
> > Best regards,
> > Krzysztof

-- 
With best wishes
Dmitry
