Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AF647D947
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 13:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780578262; cv=none; b=h42QCVfUxbX02/ZR1GiYvPXMKPztfW+X3XJhw5IzN6rhwKokXFyDwrsKMQNH7itpO6SCq27iz2nm6IZOpnhkzIEx0na+HVf1VE1jIKKpmg2nTDoUuAgk9+Dys/Q0KMene0NhOMn64NFgtHVHGwTZNQBfPnokz2ezgeUWiwgPl00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780578262; c=relaxed/simple;
	bh=0Qgo0CRLvNENj48KGFAn4sGKVbbqGjtUkT4DIcxEHz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXns2mKzLNJuf1ORuZWeyD121Eg5emW5Yh8gGkCCdV0cS6gN7+tB4LaiGVGSIabRn6NpHk51Hv1/F0lnEiEgbGm+9LRIyItb6VWDXdatnYt2pLrWjRdzwgt207/2M1L7r8249WdhBRE58SkDKy3gx1IbIzrWG/XmYj4WQPpdZqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LYGFz4HC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dPPohOBp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LYGFz4HC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dPPohOBp"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654ANd7U1994324
	for <iommu@lists.linux.dev>; Thu, 4 Jun 2026 13:04:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kygRY4F7eJ1NPjqjo+XnXvVI
	c/zT6FpT96y6RC3eCRo=; b=LYGFz4HC6QJIf95dQ+rkttk6BETSr1NO4PX6j884
	i1GC+e+8AwfzwdeAFnf2A09YFRF5Bgzbwsf55VHhjnBa5/usR53MnALGKwOnRH9L
	1HvclKZU7w8ZrvhbG9z7m+8pwlX4iLH7dtBy3svAUX1e2tpKcZ6i6Fm5fNsyXBbT
	0XPdKKQ1p2KWuDbq3pCNfJhckX9oB2B1JUriTePpqGxX5x9sWAlCU+rLL2LOs++8
	IbWLSW5qiApcqzMWdAaaDaz3+P+OEHAtMIS0HO6E/zMarcZcPAa58BDMpV5yy8AQ
	z2GiLgjfgTA1D52q4ES+HSy34wcFSjKtSxJRkGKObv0sdQ==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejs8pusq5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 04 Jun 2026 13:04:20 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e6fd5f007eso1271948a34.1
        for <iommu@lists.linux.dev>; Thu, 04 Jun 2026 06:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780578259; x=1781183059; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kygRY4F7eJ1NPjqjo+XnXvVIc/zT6FpT96y6RC3eCRo=;
        b=dPPohOBp5VQi3uj7xQd66Im8vkfRaZjZm7I+4hVZsHBPkNo5pIhA1IJ4fJLIbNxADF
         eLBldKelSTxD4r3oqVcJuje/K4FRNYwe3CHJc+nwkjcy0KRbonR9YVVP1xcTmZvIfeMJ
         u0H7/A+RzShyN6uq4ZCG9LZTLEeFGql0qzemmCgZpZh2kQaq4/BStBlaHohmTb5N5uFo
         QBqZVlfc4L/6KGkH06JlHJAwPYkfknRDJMlaT2xDrcQkDtWjei4JbXbiCISI2hlStjRw
         ZtN34Qhbwci+j5Z1K30V0viu8EeB1nN8JKWUlYITdMrteCNXvB4ECvn8ppXsdy8Gum7Y
         MplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780578259; x=1781183059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kygRY4F7eJ1NPjqjo+XnXvVIc/zT6FpT96y6RC3eCRo=;
        b=G5RBB4Of/43z112Mctp/O2x+Wv6EjiMEKudMtr4dIBMLS9CLIKT24vuhlJht3Z3Yyx
         1T5I5rqjmtIp25IW1AwiRj0diNaOeUdPWSp7+cP97J63Efz5Bx4eaW3vVums3YS2ZTXA
         QcNn1Eptddw3LbGwJMRYo9TxnG00g+GYI+RawSw6gUL9e6PR638wq2Bxncvdh1895ji2
         PCyeUB47JhmFjdRZyEJr36+hnPBwU39ojap+JEzUR7nAMuE2RTkFdNyQDr4/NQibWVOJ
         7sx9IkBdTfVyJaDva8P7lu/5k7Lw52szid+7DWpsI6RYg37+8w6VgTUb+rKi7wDwQZea
         g2pQ==
X-Forwarded-Encrypted: i=1; AFNElJ/f9TPhqaKkHUhF9wbkLPP72iw2jVXm9zOShKzPnH13DIowPe/Jqtt5MmadPo6gnIT/fya93A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2HkEh5v/ZsIjrtqH39V8+eIp4lJGPRiZiSO1KbA5pUNOYlaIe
	s/rka+3OCViBBBSV4LaSs3AZNflLnxhXNF//zwhMs6wa1XFurtsK1GaFzUR3Us7IKludGGZVGv1
	UivXG8gxPb1lshecZ9cFHYY4mBhXAVt1glN/hrgOry3GM/LJvKkhozJmgTg==
X-Gm-Gg: Acq92OHoedMX45o9RcmUDQw6KP6O66f+3JWGkBWh2Cnsp3r7UF47RcUzw11yuOjoRAm
	vUa/1EEgUPzMyQHMgD8rfks/ZotSEZ3VKGk8l7C2N1v8lfmvEd6WBrGS4wB2iojcwBjLminEeH/
	6LGpTlAyxECsxo9KfDcvWYil5PdYfsdNOnhO1aSM9tcpzj7cYkSfpIC36pG24kYJoNf3N/m4riE
	TCMhTXyEM8qhuNEWDHZbDUueOj0RFmPTE57fwssmAZHxAcCsAFyx7x8sO8Hn9EXnqdcTTzTNyGI
	hjcJ48zfuH62YXsoX8WcOHm87DDVkrvqXUcGbdB4vaf25tyIuVmqHcvTHAxwMBdWpjdcXOmYVsM
	GV08jjewY8M9J8Vf9vT21lNEc2ouW6fnktTcTyvwdLRz4eUiljXyvMH9W49CQB/Oekg1XIvSLeg
	3OIojfYcVoAp+Q3ltTNifJ68NLVLgimO21RiQC2JcPpI9WVg==
X-Received: by 2002:a9d:5e0c:0:b0:7e6:441:cb4d with SMTP id 46e09a7af769-7e6f91ca449mr1449303a34.3.1780578257756;
        Thu, 04 Jun 2026 06:04:17 -0700 (PDT)
X-Received: by 2002:a9d:5e0c:0:b0:7e6:441:cb4d with SMTP id 46e09a7af769-7e6f91ca449mr1449240a34.3.1780578256962;
        Thu, 04 Jun 2026 06:04:16 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b907269sm1197378e87.34.2026.06.04.06.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:04:15 -0700 (PDT)
Date: Thu, 4 Jun 2026 16:04:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nabige Aala <nabige.aala@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/3] soc: qcom: ubwc: Add Shikra UBWC config
Message-ID: <nkzfcmzslcc4e2kp5fv2i2grb22ncf6ewd5pn57wy5tdth4zrt@ddrquhu4ijcd>
References: <20260604-shikra-display-v2-0-b3c1b2b67edc@oss.qualcomm.com>
 <20260604-shikra-display-v2-3-b3c1b2b67edc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604-shikra-display-v2-3-b3c1b2b67edc@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 1N46AtEH7Pe7qTREa-zWT2ctt8o8CyFn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDEyNyBTYWx0ZWRfXy9cDQg1GHhv2
 aO3/eRNJomfUeROb7KGGVLaNpa3zymfdIE+ifVpGlJ0ZqMwlgFibJK97Z9G4Fvz990ZE1BJ1c3x
 gBgJKirL6Tq54EVshkZiJWBw5oKgDV541PxY603j9IZPRVduDkURCcYUual/N8azk7dWtCplJDu
 FEic7XUDo7xwkDkCTjkSMZPhryZiZXi6U5BVEan8g38w14T/B2108dE4qGdEmMowAS9/Svvp760
 EGrlo18FMpkh0szsPFQRt8i+WhkgdPOrbWdvNZ/RdWjvrPGDXaeUVCAq84juvMJNu7MxeZ3qmO5
 W15iGCbvfMQ3AjvihxmIJAauYw+4I/KEGLCvvRSq8feZsyVfco1/8Iv3nRQAilBnvqsQBt1rMI9
 Wwcn6Ew1kH7xMg+RCEzocWxlPgG0wtKEZKeSEHZkkOX8/Yr9+sviCxHjTF/M9Rwnp+ns9f0Q8qM
 1qJevrxxpOjSk/gi4Lw==
X-Authority-Analysis: v=2.4 cv=E779Y6dl c=1 sm=1 tr=0 ts=6a2177d4 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=2Uxw_1zm03w2ut2Jle0A:9 a=CjuIK1q_8ugA:10 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-GUID: 1N46AtEH7Pe7qTREa-zWT2ctt8o8CyFn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040127

On Thu, Jun 04, 2026 at 06:00:49PM +0530, Nabige Aala wrote:
> Add UBWC configuration for the Shikra platform. Shikra shares the
> same hardware as QCM2290 (Agatti), so reuse qcm2290_data for the
> UBWC settings
> 
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  drivers/soc/qcom/ubwc_config.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
