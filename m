Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504DA43F4B4
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 14:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785421869; cv=none; b=dUGxdjeyDKXCQxmhEj/m+eRUNsYd1Nk7WBR4AUCfumyqctbTfc1FeOkBZMQDJEMuZHizbPMV/eIzTAb6dUc8mL6N/i+UheZSyzrCgLn4WcFf3WwQR7MbQjaX00Hhx4GW3ocSyrf5tnMCrKNitzvVswcmBWGB3LcPGT6DRXmxC3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785421869; c=relaxed/simple;
	bh=XofIp02k4nBi4eiowNOYNf7H0Xpi6iQH0NOE8i7OsKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HiXD7hH3iM1Cv35Dp3LOkAt9/sEMh/+acFaW3rqXXUnVy+Af9StaSEDys0LRjT8y92XSvo1IAS9Nw0gX4bPhr020kHHQtVPWqa2KHtTS3K9XjHQs1qxuhvAh/ibIpchGThe2DlTqGLAoanylEvfK1SmQ+vWahUN1Dqg8h8vMBAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mgj3dnWs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OHKefGNg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mgj3dnWs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OHKefGNg"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UDDCYV715708
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 14:31:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=JCT3EPO7gLLjh/8pAuKmI/lG
	uSDERijqki/K1oJAcNU=; b=Mgj3dnWsw42JT8wCEe7gC0WI0m0wu9ltMTFEzBqx
	cAVV1sX1YGzCvyt5oYGWXMEOh57YBzudwbAbemMddwEkTyaU+JHpLkz34sqEyOQO
	3ejldVR3fxiH1F44uSYVnueLQKjWVCDjjRU/3Anjgn8LfomDsBUMM0KufS5LVam+
	ekbDM4DwSQHmoG591C2HZzjNu4hnWIgy9zW3JoSoQxLNpRUW1Cd5dzwv+nPLl+gn
	EHCiA5lIpNhiO1H739gFU1XJPBtX46AVIWbWBzORlC0Fe8aUvRX8c4LFu5zc25aT
	qd/m4Rg4r3aP76j3MdokIfVmGfte9HijtCo0fx4MIHkbow==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr6ucrg2w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 14:31:07 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c20762d21so27102641cf.0
        for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 07:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785421861; x=1786026661; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JCT3EPO7gLLjh/8pAuKmI/lGuSDERijqki/K1oJAcNU=;
        b=OHKefGNglYf9MW0POrRDdo3gqrIY3UuFPlBuWOQO40Vjc24q1IWqbmwhXZf/SVge9t
         Gd6aTyYOufDj3LLkgMEvWtV5tn/TTEI+jLYcKZNGSv3+Bfe56cEmk5Ak0nptWum9+jFD
         7u2UgR6DEwebWdtYubJcf2nxxuPPy97JIazILItc5w+iu+pkSkAssunWICFON63Wm0/O
         v52Zw0yGdHlxb5rF5o5d6CTXgjjHPmpLMgnhnWUEyQ1sp55OlPlFKighsI7lzCCcbcPA
         jNMChvbfRNyR2B83GU6HNaxc/xkIGTZHCE+p/m+QoS6WxpQtqMH+UN1m5faYnWheglzt
         dVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785421861; x=1786026661;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JCT3EPO7gLLjh/8pAuKmI/lGuSDERijqki/K1oJAcNU=;
        b=gT1jabbv5D2vohpiWLmFr3mkqX6CBu2/sBVQugtv9+eA23JxRbKrFsNIvKrh3AuSdm
         jHMa1K3euRbY5QvpHwP20t5TnbxH41TU/fZzYMfdFUzM0Db5Pnk7N5YoKepd0oosMUQ8
         LgrjKoZ+3hTA+eSX2TvxcXOmZXSXnMNDjf5isEWxm43Pa9797j/tE7cfRD9IUoGgu3BG
         nEx7+znf7AhF4T5qft7CPNUnm9HiGQFds4OsLkX2TZxc3edQOFfYhC+zvTN3PLPZIaPZ
         O6gjAnbflqbh01+GnL+vCENxXfcQgD8MHs2x5OHx7EZU1qeTmGugCkMnDD45ZGUGp13n
         /Tkg==
X-Forwarded-Encrypted: i=1; AHgh+RqeQr1XUVRsRpLxP/qA0CTPEKWaBkSzvQVkw6pa0TSyQpk/xg0wutE1ViBdVkKBxwaf4TYBPw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyq/MwY+vTyD7wthmKTTf8AQH3t3JO4uADm1g/1iKhQjy4TxGmI
	S7fVCBTISmDgyNhBWDUj2EhdBC7BF5FKrqmzl6SZHr0Hvzt3ZMIgyA1G+vurYc/54+8QpWist9V
	GrnJuim2Vqgi3fSTFe8ZSYUMdf3UQhK7qZTcTdH9MTYuSNL2BiAx8v286Aw==
X-Gm-Gg: AR+sD13a3QV8FHJjpH/uD7pn1xJkDlI1VZBhwax5gPQRFLit5Lb/9LWiWnzsJDgBD22
	I8UYRFzJaQ3CQXlJDl76wt/hGNxlwb23Ph1P1NN/euxZeNjaflyx4Nd971fBTqWaa6u3Tia5pFV
	eSDptjgAsOR2Kv7Ew8iEl0RBlxLmQZpRSvZPLSwJyLZ1RaLapI/Xa3eWUFsy9wFyUvnoQzP+MAF
	GmmlCycODuJupi//3MA0GK2YEzoEBQo6K+3MRRV2FjBPX6OFNd0T7zH5jEjYe+lqxVfyq4prGxP
	ugqZO1oQRKH0ThSgcuST1Dfyn4/9zlhxJpPawGmDRi3CZY24qJKqMlUUvrixwb33ty9tnSBHe7x
	ICMdiXlhvgzXy6CP54dFWZQGX1bPpyFhP/S9vdhm2mu0/L64Rti80t7Kzc5A+o8Q4saTK41dvy/
	aTM/+0OPVMI+GVYQ==
X-Received: by 2002:ac8:5f07:0:b0:51c:7b12:1201 with SMTP id d75a77b69052e-52b386c7b4emr31713541cf.79.1785421861224;
        Thu, 30 Jul 2026 07:31:01 -0700 (PDT)
X-Received: by 2002:ac8:5f07:0:b0:51c:7b12:1201 with SMTP id d75a77b69052e-52b386c7b4emr31712241cf.79.1785421860267;
        Thu, 30 Jul 2026 07:31:00 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2db9c5196sm377549e87.56.2026.07.30.07.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 07:30:59 -0700 (PDT)
Date: Thu, 30 Jul 2026 17:30:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Joerg Roedel <jroedel@suse.de>, Russell King <linux@armlinux.org.uk>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Heiko Stuebner <heiko@sntech.de>, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/3] iommu/msm: track a context master per device and
 IOMMU
Message-ID: <ketiunovezpn76nxocpima27esjt66vve6tmqg3e4murz3yjga@pxl6kikpbk5l>
References: <20260730-fix-qcom-smmu-v1-0-b12fa067804e@oss.qualcomm.com>
 <20260730-fix-qcom-smmu-v1-1-b12fa067804e@oss.qualcomm.com>
 <c77db81f-9fb8-4803-8efb-078b8cf70fab@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c77db81f-9fb8-4803-8efb-078b8cf70fab@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDExMCBTYWx0ZWRfX9c8cjK/QJx3p
 tq5x1s1k020QX8VU5IG8iEIC/mf21VOqZO4Ujo048Lw7KzL1Aqnmq9mMjS8eyotJfQMRp+NqCTn
 xy5Po9NT8x1lqJIPSagx5872LmkSrg8=
X-Proofpoint-GUID: Zx0yjjl0WzXbQzaFsiTW1Dr_QejdyH0U
X-Proofpoint-ORIG-GUID: Zx0yjjl0WzXbQzaFsiTW1Dr_QejdyH0U
X-Authority-Analysis: v=2.4 cv=W6QIkxWk c=1 sm=1 tr=0 ts=6a6b602b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=6Z1frLYTuOUDIWW9GX8A:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDExMCBTYWx0ZWRfX/0fjuIu30wrB
 pYObFFImttAgmEeTCLZy6vNE1yYfwc9Asg5nmaVktR1k2oUhxlV0qSMAndpw9ASHyQEtOpeqlll
 WgkT8bWJlonqMJyWFM/8Kj+e62WAKf3rE8b1pOM1k2V4ABbNR8yeaHJ+qre/H2u9+IVj495sILR
 29EK5HgDdmRwUCG7j6B/rxbp9MXoMs5UwRgueZ67wIlRq9YJ8hJA7XsbPkiAO+NYNs2xC3rDCM7
 wFt/ZUgF6YJN4Wd9nEXoJD7eq+Tzg0iYRYa1DpFbvD+v0UYe0XRipHUV/qcgKQjjP0rRiuIQAne
 t3ZT2rnHcFIzyCvugrohLUE9Ng4lnDet67s9ZXVvmQTkB3YomU2nuNlnfnwjJpaGbdRT9qfemZB
 re976K2Lr6bEY6+AQyGBuMQMzJ7fcrLLsnuft8Fh6/kxgj6HaSXVYC8EXj/36hI5gf7m7SH6YV6
 wt33JQBREtSmTxN29sQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300110

On Thu, Jul 30, 2026 at 03:57:42PM +0200, Konrad Dybcio wrote:
> On 7/30/26 3:29 PM, Dmitry Baryshkov wrote:
> > insert_iommu_master() decided whether to allocate a struct
> > msm_iommu_ctx_dev by testing whether the IOMMU's ctx_list was empty,
> > caching the result in dev_iommu_priv, then unconditionally dereferenced
> > the master:
> 
> [...]
> 
> > -			dev_warn(dev, "Stream ID 0x%x repeated; ignoring\n",
> > -				 sid);
> > +			dev_dbg(dev, "Stream ID 0x%x repeated; ignoring\n",
> > +				sid);
> 
> Is this intentionally part of the patch?

It can be dropped, yes.

-- 
With best wishes
Dmitry
