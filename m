Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D957D375F85
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 23:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772582018; cv=none; b=AJhPz4GcmWlLAQV2vA6KBKFfb/ndihciH/tMmLnCJN6JBRXZtDE7xsmsrVTD94rBozsgiiIn3D29h3fWx79H1celcc1Rp8eyX5NuJwyVjQqpEDhNbE1Z077euVm7p4yVp2NqBtNyhVYQcM/mIaUEtmuUZZIRrrinI5x3yUR1TxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772582018; c=relaxed/simple;
	bh=mPTUW7+++I6V6Gkh87svMpd4/+jZKqbsn6FojcsInxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=joiZoAobJW0WrijKKngd4iQyNORSnFLwq2344EMo+2E7aVqtZT4Wplwx31xQPY6pfNhYMRQQ5OGGghbtCDw1GnI11PLxrGzqCuhJxa8wUhNKcvAQDwk+YIexm6AoajQo69fdfyWHT10KIZnSkfN/vTsLcppAthG56d/adpYJtFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NtUUexE4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jwb2kYYr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NtUUexE4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jwb2kYYr"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623H0V3Z3548595
	for <iommu@lists.linux.dev>; Tue, 3 Mar 2026 23:53:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=noxRLzHbqcCDZ6D5qPjWL1fr
	JAIlBz2av79smoXBpok=; b=NtUUexE4oSQgmcfAsSdQD/L9owS6vT+FFCvpawgp
	Ssg14qq0ryWbuXuRBywc8tfo5aNLDUYI0tzkUmvI2Yfi1zCbNXvpouSZ3dd1LLOH
	00X1IbcwPyMzqJKXEySol0oaVFdZoAvKLdLmcfSG+U7+GOerou8v+UGtbe9Bo2EM
	8b1ptVVD6joiP7C7yrlT4o4t8J2xnOIo52oFkktWsQ9z5I0xnYDzo3+XC+lpkLiX
	Q96Ry/JPkDKEAoKlEi63xeo+0sXZmMct2EIikXhXbwZWfRbrDBGPc8mm8ljWDvFk
	ZMk/TktSqLY7ghbJiTY4CIBIjekz0pSYb9pXBzRlzTQHMQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnvxfasam-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 03 Mar 2026 23:53:35 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-89a174bd442so22360746d6.2
        for <iommu@lists.linux.dev>; Tue, 03 Mar 2026 15:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772582014; x=1773186814; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=noxRLzHbqcCDZ6D5qPjWL1frJAIlBz2av79smoXBpok=;
        b=jwb2kYYriPun/GzH8TYDr80Ofne4CrbjPH7o2HIejyFJQrpSOZPNG8qtWtfn+TckZh
         FxiJi7fPzyxbBpQor9cKek59aqw4mKI3z+Cx7rkW5EVtL+UkVEM4yEWAY9/oEyqSTiTb
         vwhgd6sCkB22DqK1dnzHX/1GS226fLrObQsxjkVgWSNNN8/qG4n9Qky14GA4iIXvynqd
         0dX8i9TFAmC7+D6bIs1z0Ny2Gkn2sNm1TKXeaXj2eXCh7QpaZ6QZjp2VRByCSOkRAFud
         URwXJOO5KAMDxCVDQ2yJv0kcPmZwnlhQNdmY9TNShp1j5Y60PLGMw5+DtTggTazwz14t
         wH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772582014; x=1773186814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=noxRLzHbqcCDZ6D5qPjWL1frJAIlBz2av79smoXBpok=;
        b=ucxaXsFI2kDtHwMINjGIYnWDsrzK0TVeiEi5dv0z1WvYLKLgFt5oU9/lspvTeC00E6
         5qH0Jm/cy6rOwZD94AuiWnkcQAtTi0OFhHL+9episZbefL5HG1Ce47osfq1k+W1ovl29
         DePZ667OrKcLwLJap9tTWW2Eq0wTiRM3XF8ZVJ2CmRZmKu0uI6MofR3ppGqlkOAbW5mT
         y/jhqv6+61it8kZZP5KRMdcCofJdn4eTdEndSaa6njkTrdsGSjllONMfZyDjVbqvzhIu
         J109rD40C4E5yLmphykQJ+AG6zjx+69nOSZhZgILf6xn0yLlIb0vfQAlx902hkWq7+wo
         WJcg==
X-Forwarded-Encrypted: i=1; AJvYcCWYi66t0cOv+NNW1v/BQ/0Kn2tFFxdteeAsDqQUB5rBGmDyb2sOfHZ5rKSVpHLtbqJHLz1rAQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxb5ISE5v5tct3uTIsxiYj8NwhTijtyQdpFZGIUq4FatRWy4Rzu
	ItpMPUghh5C8keMurQnLvz4TkM/hyRAoyhc8umMuUQphNbOb5T5ja1LzI/sKxeiKsZHgz9Tg1eH
	xvDJB7EVDNwMFvj0ZIFbtPfqhuxDlzkvopOwCU6A3W/XEsycPdIEtZI5ooA==
X-Gm-Gg: ATEYQzzEfBjAUtDIzkVlL5dMV9TqyYDw3otxsa+r2hzg8iTt6Vj+ZHC21lKX6QdBbSS
	70I298BqJ72j+u3CgWidjQ3S9bbx8ZQuY3iRC6qh6Dz1GL+KbRqS9hfs/bJxMXTtEgUVWORwR+5
	l9ij0wvRuJ75j1925jdIxle5LPhiUI0ZXY2/DUlmhGPkYjePTbeyBzqEVlb5Y+/V0taJoKG1gHb
	7/hm+1M1BO0U69fZhrbzxtWBysAwwrajgDDre7N6yOLJ6SMUdLUTmHqPLWI8BAQInbfXtJxJf8b
	DsIvT+tiodL146aiM1MsSziaMexBT3+VDAb4jWeNwWwviu3wQR4VRtE4lCOuR1mWCaqoUHDE0G4
	DYK+BgECn/rcucooHjwj+8cRZbffBvatun+4VjT0lFMpl6CZABAr6cp9V6SNzM0bG2fegIU7Et0
	uBNjnuH0IBAo47zIBpRcigywC1FkXGBZeZz1A=
X-Received: by 2002:a05:620a:31a5:b0:8c6:a3ed:2f65 with SMTP id af79cd13be357-8cd5af18213mr29449185a.23.1772582013481;
        Tue, 03 Mar 2026 15:53:33 -0800 (PST)
X-Received: by 2002:a05:620a:31a5:b0:8c6:a3ed:2f65 with SMTP id af79cd13be357-8cd5af18213mr29445885a.23.1772582013040;
        Tue, 03 Mar 2026 15:53:33 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a12357d2a9sm884016e87.40.2026.03.03.15.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 15:53:31 -0800 (PST)
Date: Wed, 4 Mar 2026 01:53:30 +0200
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
Subject: Re: [PATCH v2 1/7] media: dt-bindings: qcom-kaanapali-iris: Add
 kaanapali video codec binding
Message-ID: <fjvug6snigssgheuduzjomzjq6apte2ggixqzjzziwcycee4l2@irh2mkholacy>
References: <20260227-kaanapali-iris-v2-0-850043ac3933@oss.qualcomm.com>
 <20260227-kaanapali-iris-v2-1-850043ac3933@oss.qualcomm.com>
 <nen35eqhwbikt7jlpxn22hvur33chxibrbmzd6awo425i3mujf@f2cbncxpcatc>
 <635cc998-d530-42eb-95cf-99b0d5baab68@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <635cc998-d530-42eb-95cf-99b0d5baab68@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE5NiBTYWx0ZWRfXxqPuTeGztd4F
 Mvevlko0L3Mig4vexLCYzRTJn0G+/LANMGXqkEXGNoqmPOeliZfDBRFaoskJaijlwk3r4NJM+Th
 h2LJPlAs8HoAq6zyDWwZeHD1OXtHopfZ9zyqhx4LDE3TQrrqpJQlKOVULEj/vZyRSYDHpQpz+La
 IZnLF1YCCRLm2uFP/ft73M13sEMpLnVqvF1PxyP9t2Pc3OGh2HaxxahHPwQbHJRZ3e0FArEmlFn
 f2K4ngEGKXp24ridvDVVRFSB4pfcqV0sQ9jNz6cAePdY/qxtn00Vk4//VeD/5IaWjzsnxZZxmCG
 Kc93WuusFVaKtdgiJMucNXdYaBowvQvRmPIm/63zohhqDeIt8ht/WpaN5CVF7aJ8DClWUMcl70v
 aio62/i1e0zxJ5SfRigxPYx099mB4ftXBl0jUe9k4lgne869FSf7GMDhmxqRckSxFDYHQ8NGESN
 m2W6baZg9rmwDB1X2yA==
X-Proofpoint-ORIG-GUID: mte6rjRL86SJLUzLAbYzBMMd2gBamrzU
X-Authority-Analysis: v=2.4 cv=S+HUAYsP c=1 sm=1 tr=0 ts=69a7747f cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=Ni5EwOkUcNZy2ZnK61YA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: mte6rjRL86SJLUzLAbYzBMMd2gBamrzU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030196

On Tue, Mar 03, 2026 at 11:43:40PM +0530, Vikash Garodia wrote:
> 
> 
> On 2/28/2026 1:22 AM, Dmitry Baryshkov wrote:
> > On Fri, Feb 27, 2026 at 07:41:17PM +0530, Vikash Garodia wrote:
> > > Kaanapali SOC brings in the new generation of video IP i.e iris4. When
> > > compared to previous generation, iris3x, it has,
> > > - separate power domains for stream and pixel processing hardware blocks
> > >    (bse and vpp).
> > > - additional power domain for apv codec.
> > > - power domains for individual pipes (VPPx).
> > > - different clocks and reset lines.
> > > 
> > > iommu-map include all the different stream-ids which can be possibly
> > > generated by vpu4 hardware as below,
> > > bitstream stream from vcodec
> > > non-pixel stream from vcodec
> > > non-pixel stream from tensilica
> > > pixel stream from vcodec
> > > secure bitstream stream from vcodec
> > > secure non-pixel stream from vcodec
> > > secure non-pixel stream from tensilica
> > > secure pixel stream from vcodec
> > > firmware stream from tensilica (might be handled by the TZ / hyp)
> > > 
> > > This patch is depend on the below dt-schema patch.
> > > Link: https://github.com/devicetree-org/dt-schema/pull/184/changes/d341298d62805bc972dfba691da6b3b62aa3ff15
> > > Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> > > ---
> > >   .../bindings/media/qcom,kaanapali-iris.yaml        | 261 +++++++++++++++++++++
> > >   include/dt-bindings/media/qcom,iris.h              |  18 ++
> > >   2 files changed, 279 insertions(+)
> > > 
> > > +
> > > +  iommu-map:
> > > +    description: |
> > > +        - bitstream stream from vcodec
> > > +        - non-pixel stream from vcodec
> > > +        - non-pixel stream from tensilica
> > > +        - pixel stream from vcodec
> > > +        - secure bitstream stream from vcodec
> > > +        - secure non-pixel stream from vcodec
> > > +        - secure non-pixel stream from tensilica
> > > +        - secure pixel stream from vcodec
> > > +        # firmware might be handled by the TZ / hyp
> > > +        - firmware stream from tensilica
> > 
> > Why are you providing description as a list rather than describing each
> > item separately? Then you wouldn't need maxItems.
> > 
> 
> rewrote them as below and dropped maxItems. Please review.
> 
> iommu-map:
>     $ref: /schemas/types.yaml#/definitions/uint32-matrix
>     items:
>       - description: bitstream stream from vcodec
>         items:
>           - description: Function ID
>           - description: Phandle to IOMMU
>           - description: IOMMU stream ID base
>           - description: IOMMU stream ID mask
>           - description: Number of stream IDs

I'm not a pro in the DT. Is the itemization of the first item reused for
the rest of the items?

>       - description: non-pixel stream from vcodec
>       - description: non-pixel stream from tensilica
>       - description: pixel stream from vcodec
>       - description: secure bitstream stream from vcodec
>       - description: secure non-pixel stream from vcodec
>       - description: secure non-pixel stream from tensilica
>       - description: secure pixel stream from vcodec
>       # firmware might be handled by the TZ / hyp
>       - description: firmware stream from tensilica
>     minItems: 8
> 
> > > +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > > +    items:
> > > +      $ref: '#/definitions/iommu-types'
> > > +      minItems: 5
> > > +    minItems: 8
> > > +    maxItems: 9
> > > +
> > 
> 
> Regards,
> Vikash

-- 
With best wishes
Dmitry
