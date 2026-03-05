Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FF9191F84
	for <iommu@lists.linux.dev>; Thu,  5 Mar 2026 03:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772681602; cv=none; b=JSatbppdMc2lLzg0VhPLQEPvVirXNpwH0fYvE+qaqjtOEEx2Sd6ZSlqMNrgOgKgrPaXsnDheVKh+zbv9dAVfnxwfc+4Iyxt6N8aifXAVTXRNYoETlPZKF/T5BXCCbGmeixb0S+Fj5w3/pN9yI75yv55JlrpEKiYg1PQmSV3x7qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772681602; c=relaxed/simple;
	bh=cIahUaIbGQDw0acEwfY4xZO7Ltd3QgQaB7V/iwAk9E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2tcMfqkgPSOMWlf3QAyMbIRoSplR7QIrjWGZV/BKwXV0IqwJ1+/3mzmCLWZct34KP6iVnWb3bXdLrXV1Qh0PHKd5qyBac4QThKm1+ZU3TJ8DyCIqjRdm7rgHzctZggC0tUMKaoydTVq1WPq2ES1waYYVoYLR1mbQQ61cK91coE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o38A+qH5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c5Zp2168; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o38A+qH5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c5Zp2168"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6251BqYt3482752
	for <iommu@lists.linux.dev>; Thu, 5 Mar 2026 03:33:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=PyP3Y+1F9PT+kk/ROvpwez7s
	vdDMe9wKcbVyRbqm7Uo=; b=o38A+qH5OcCfacTL9IKv4s9zDLMYtfPDGQ+juVUz
	HP6kn8EkQxT8deL0BOyAqCGwlpcXi+5R1qoJjXWWyvtDymKClwmy/oqfwtu0XIp/
	2hRdwOiY/n66waZKmPx+U71fQwhbbBHw50a2hB2b4BCQHG0xiIQ/qo61eBUSAqXJ
	WtHD6UJfKak7xyPeGIAuWN1ocIZ1Q33HuR8GnF8owl5ujroG/AeboTYxGZSrlscv
	q0tL4pC8nXz0LBGhEPzTBHM2sdxsXxuKVLMpH1+igZq9T920oco8MLORgSe0Xthm
	58yfLwGhsqMdlS+HsDFqK/Zv1wjOuYvgq0+DY1QETytilw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cps0whjgc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 05 Mar 2026 03:33:20 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c71655aa11so6622078785a.3
        for <iommu@lists.linux.dev>; Wed, 04 Mar 2026 19:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772681600; x=1773286400; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PyP3Y+1F9PT+kk/ROvpwez7svdDMe9wKcbVyRbqm7Uo=;
        b=c5Zp2168b5Cwj2RQq/BH8J2QI34eMOnEri7d4EfUpjScK7IjhN37c8kMWQFd06dK3j
         yNEoxpNncDPflMIF3TF7tLJGXG0zUvg9sjT8pA66bufN0LObvAtlqJhR5GuxNR0TWt04
         SjB8qtpCGTgXf2zpUaUPt3jyXDhSR4UmCe/XS8DMK7BhUl/IlCg7XgvmESM4pHXe7Ohp
         e1BlYqzprj4+O8hAvNb1blwyj/0H65e4JvnAMtnvKN+bNZcGvGI6nBBRiVSJ59rIQ9Ko
         nS4TNn5IkkvOoCf3rFv1yzyHggJe7EJjkOPPu/N8rzOUYxkOI7C40vNUwkVIYsy8Qhs7
         m7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772681600; x=1773286400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PyP3Y+1F9PT+kk/ROvpwez7svdDMe9wKcbVyRbqm7Uo=;
        b=mIFL33TkJqoVXj7hqSozf76aK/hQ+0GnjO/6vQGD5hkGReppChnzCdEgSIrwvxw+1g
         SV67AcvpnfdJU93u7dR8Q6ZZaskr8wU5iMH25uvTY5jpzOUBMOfnpljWcabMN9hdIjZz
         ybCwKGP6u8jWtuvN+Tuh1JAXgGqJq/ssnM0koVKnIUNGnPlr4UY3ZkkQblF+zRUUf63l
         tU5eU/j+gx/hMrtWKR0Q8sU200HetNPxRMddKqzKJsVhDOxBcSCiejJOP9xHa2/j95YD
         +UPAofMLZm0IQRl+x0gRF1iniSvTXWnfBVWzNenuQ/zbNKkjHwrP+LW1T+DDao6l0n4t
         yW7A==
X-Forwarded-Encrypted: i=1; AJvYcCWjQMKdwgXGpPGsPgrmr7M81TNFq0aSmZ9/8vL9hmsBAkc2oTTUS/tmzDhGfoYJJrEBNMzQWw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6Il717gz+AG7LwQjQLhhICaieXhwNaEk9MwCp/HtAUjFzhpV3
	7OlUK3IUDEWxmZdfmpk/E07V8pmS//uLOa+R+EyJOsAt+Y1m49gzXkrTc0AcZPTaygOW15il9+2
	6LGWykOw3ROg7uPOVxFlIJ9YZqSV+U5VrVobBiQIraFGCizUmu3J3KktftQ==
X-Gm-Gg: ATEYQzyeJLMfwVHPMwxuQu6ZhsLuTmzsW5WIX8kxmWWuv5bkbnNDLdBARPiLDbPrgyZ
	BhxnY9+mwk5K5vfseoJnVfVra1p0jHgWzvC+ZDGis3Lylw0JJ3cfxZHsm/PFqPF1J6/k7MDDoa4
	/XSJLb+sjUs4ma/fxHJBkpnMY+8yvhS50SzaEzgQTnoJA1YBbnzWjNKWF8txvdBhhCn0UAZVNnd
	/rJaxpU/DtIHfGbc3GyViQ9TjvCN9dz1jEefWs2+AvoQuC4l+O6ndGpv3ZBVGPJfHZ33i/IjOYp
	AKudIFAd4KkSlaJ+SKN3xl4a4UnBc1yfT5RE1/noKnNxo/eVNtHjwRhmK4IVX3bQMeK2SpZ3CmT
	rZfCWNOWvFfljPfIXiaruFrjPo4Dx74H8DN8wnSTgc5SvfBpBkNv1C6XDqNhsFrnKsP9M9XHVWF
	PfjVZzk45xAe8tyuiXVM1PA/fl8bS3AQAXIFw=
X-Received: by 2002:a05:620a:450f:b0:8c6:e8f6:2c7 with SMTP id af79cd13be357-8cd5af95983mr540352885a.38.1772681599590;
        Wed, 04 Mar 2026 19:33:19 -0800 (PST)
X-Received: by 2002:a05:620a:450f:b0:8c6:e8f6:2c7 with SMTP id af79cd13be357-8cd5af95983mr540351285a.38.1772681599071;
        Wed, 04 Mar 2026 19:33:19 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a123583e48sm1664755e87.18.2026.03.04.19.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 19:33:17 -0800 (PST)
Date: Thu, 5 Mar 2026 05:33:16 +0200
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
Message-ID: <vwvuwzmwqvskibwdobuapsr6rpsqmpknirco4y4jjcav27fiji@g2nwxdj5dodc>
References: <20260227-kaanapali-iris-v2-0-850043ac3933@oss.qualcomm.com>
 <20260227-kaanapali-iris-v2-1-850043ac3933@oss.qualcomm.com>
 <nen35eqhwbikt7jlpxn22hvur33chxibrbmzd6awo425i3mujf@f2cbncxpcatc>
 <635cc998-d530-42eb-95cf-99b0d5baab68@oss.qualcomm.com>
 <fjvug6snigssgheuduzjomzjq6apte2ggixqzjzziwcycee4l2@irh2mkholacy>
 <b0d04ced-8f3c-4bd5-a5b5-0b2f12aae25a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0d04ced-8f3c-4bd5-a5b5-0b2f12aae25a@oss.qualcomm.com>
X-Proofpoint-GUID: K5V5hcir_sQlKKoa9SlGx61VBHkMAiNj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDAyNSBTYWx0ZWRfXzJUE7P3nYVPk
 ISb0DEQSN9ApjbTOm0kH2mXhWf26pTA11zyyVrqKyXKYMwr3oh5gCunQZQBgPCvk60MdRUEO6r3
 FQUImyzsUxGCDAHIGFfKN0+q6QoXFZh6OCm7nsbd0q77ahXqOiZyj2tpWLxVUl3RkzQSFKIlceM
 VbPOhiqdBz2QlH4wJ0RPyRr0292nc4snm2xtTGaf3cnORHTmhnx4hNL2XBqlVZKr0ug77jDlyDk
 T9YxBogznz8bwvA9LyGWrGfa4RXIlCFXcCoh1eFKO8FJsjQ/6/Uz1gxwxYANLjGKc+4sLVs6xHo
 HpwJMRdtmJSZdAGWcnzR1sh5PFUXxVdcM43orJMBE6UfKFxQScyP2rdD7SAyCkcqVd67VVeGApL
 4qucN07vgKj4zUr6X4eiDnNTuxT50rlh7UWsu8CAX8gq9WcAEFyoqe3AVmR8WsvM1Opcbkt6Gr4
 0GXsHh6Sy2S8LDDv/rQ==
X-Authority-Analysis: v=2.4 cv=OYWVzxTY c=1 sm=1 tr=0 ts=69a8f980 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=n19I01RymS3B12SaILkA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: K5V5hcir_sQlKKoa9SlGx61VBHkMAiNj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_09,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050025

On Wed, Mar 04, 2026 at 08:32:53PM +0530, Vikash Garodia wrote:
> 
> 
> On 3/4/2026 5:23 AM, Dmitry Baryshkov wrote:
> > On Tue, Mar 03, 2026 at 11:43:40PM +0530, Vikash Garodia wrote:
> > > 
> > > 
> > > On 2/28/2026 1:22 AM, Dmitry Baryshkov wrote:
> > > > On Fri, Feb 27, 2026 at 07:41:17PM +0530, Vikash Garodia wrote:
> > > > > Kaanapali SOC brings in the new generation of video IP i.e iris4. When
> > > > > compared to previous generation, iris3x, it has,
> > > > > - separate power domains for stream and pixel processing hardware blocks
> > > > >     (bse and vpp).
> > > > > - additional power domain for apv codec.
> > > > > - power domains for individual pipes (VPPx).
> > > > > - different clocks and reset lines.
> > > > > 
> > > > > iommu-map include all the different stream-ids which can be possibly
> > > > > generated by vpu4 hardware as below,
> > > > > bitstream stream from vcodec
> > > > > non-pixel stream from vcodec
> > > > > non-pixel stream from tensilica
> > > > > pixel stream from vcodec
> > > > > secure bitstream stream from vcodec
> > > > > secure non-pixel stream from vcodec
> > > > > secure non-pixel stream from tensilica
> > > > > secure pixel stream from vcodec
> > > > > firmware stream from tensilica (might be handled by the TZ / hyp)
> > > > > 
> > > > > This patch is depend on the below dt-schema patch.
> > > > > Link: https://github.com/devicetree-org/dt-schema/pull/184/changes/d341298d62805bc972dfba691da6b3b62aa3ff15
> > > > > Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> > > > > ---
> > > > >    .../bindings/media/qcom,kaanapali-iris.yaml        | 261 +++++++++++++++++++++
> > > > >    include/dt-bindings/media/qcom,iris.h              |  18 ++
> > > > >    2 files changed, 279 insertions(+)
> > > > > 
> > > > > +
> > > > > +  iommu-map:
> > > > > +    description: |
> > > > > +        - bitstream stream from vcodec
> > > > > +        - non-pixel stream from vcodec
> > > > > +        - non-pixel stream from tensilica
> > > > > +        - pixel stream from vcodec
> > > > > +        - secure bitstream stream from vcodec
> > > > > +        - secure non-pixel stream from vcodec
> > > > > +        - secure non-pixel stream from tensilica
> > > > > +        - secure pixel stream from vcodec
> > > > > +        # firmware might be handled by the TZ / hyp
> > > > > +        - firmware stream from tensilica
> > > > 
> > > > Why are you providing description as a list rather than describing each
> > > > item separately? Then you wouldn't need maxItems.
> > > > 
> > > 
> > > rewrote them as below and dropped maxItems. Please review.
> > > 
> > > iommu-map:
> > >      $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > >      items:
> > >        - description: bitstream stream from vcodec
> > >          items:
> > >            - description: Function ID
> > >            - description: Phandle to IOMMU
> > >            - description: IOMMU stream ID base
> > >            - description: IOMMU stream ID mask
> > >            - description: Number of stream IDs
> > 
> > I'm not a pro in the DT. Is the itemization of the first item reused for
> > the rest of the items?
> 
> yes. As a trial, if i remove one of the itemization from above schema, then
> checker throws error saying 5x9 arguments in the example is *too long* as it
> tries to fit it as per schema i.e 4x9.

Ack, thanks for the test!

> 
> > 
> > >        - description: non-pixel stream from vcodec
> > >        - description: non-pixel stream from tensilica
> > >        - description: pixel stream from vcodec
> > >        - description: secure bitstream stream from vcodec
> > >        - description: secure non-pixel stream from vcodec
> > >        - description: secure non-pixel stream from tensilica
> > >        - description: secure pixel stream from vcodec
> > >        # firmware might be handled by the TZ / hyp
> > >        - description: firmware stream from tensilica
> > >      minItems: 8
> > > 
> > > > > +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > > > > +    items:
> > > > > +      $ref: '#/definitions/iommu-types'
> > > > > +      minItems: 5
> > > > > +    minItems: 8
> > > > > +    maxItems: 9
> > > > > +
> > > > 
> > > 
> > > Regards,
> > > Vikash
> > 
> 

-- 
With best wishes
Dmitry
