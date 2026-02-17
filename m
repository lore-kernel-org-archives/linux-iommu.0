Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A130027B347
	for <iommu@lists.linux.dev>; Tue, 17 Feb 2026 16:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771344960; cv=none; b=qxZuhn/uXYTzTDic6Owo2/zZfMgp0E06cdL9uH28I3HCwbOUya2Vpu6prCzTzdZ+hxZ7OOmf6WCMiZA/dBWkkLkRukJQD1nMKjK91m8hz4/uceAWylKB+lkIcjBKbqRTEsDYdQExwlW+8KBTwD+UcvyTnpjsgUimoDN9SvpFt6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771344960; c=relaxed/simple;
	bh=HX0J+uoRNH2k8/RPp9EGYanY5BLz37kOfXHBhLzdSDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4G91kEMtCL644BI9kReej/Ggelu/lJgIeEQ6SzbJSKjGiAT0bCCzBRPnyUfcZKw2vlbSm/qPb5hfu0euh7TWKkPfRSthX+J+zD2155wq+THo0asnPOvXdqFGd03pYWsidwNjY4KPKzUiHGtXztAiFa4HnLufW/qxPqNF2oSHNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oTSWZ7N6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=STFDyB+Y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oTSWZ7N6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="STFDyB+Y"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HAliNw597248
	for <iommu@lists.linux.dev>; Tue, 17 Feb 2026 16:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7EaOk0UZuef/7ty3iD0mim+S
	VVJ5a6pNLO6sSAstrvk=; b=oTSWZ7N6hVFdOte5Mxy2tF0I5cRe2HGmgFJNm9rm
	3BhTr5otrNCswm3QHCwHPqG8IkgX1U22EdXRbSNpt5S8Yy1iQVx4LtUMNRDFcb7F
	ug2DhcGcBkwLm4RMimspKzOae7lflrylSM+DdjSUnDXQ+sXFptsl59exOh/qzgNB
	pfIIZtmeMHuciw+fDR9lgQlfgsnBq27q+e2gWyM9+WvtxH3x61r/35Yg+cM6Ct2+
	snj6FPWLGT/NuJR/H+2V2dzC5esuDQNOvWBpLdcwRj89LR9JlXeh9yxF6dOvwxMs
	YQ6du10pwwB4MA3OwPPQJNrwejazndrtbbRgQeyOH0gYOg==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cca362gwy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 17 Feb 2026 16:15:58 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5663065a31dso51670244e0c.1
        for <iommu@lists.linux.dev>; Tue, 17 Feb 2026 08:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771344958; x=1771949758; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7EaOk0UZuef/7ty3iD0mim+SVVJ5a6pNLO6sSAstrvk=;
        b=STFDyB+YSzuDeV5PqXOIf0KMxqNXrzWLngG8NRxV401PWUlV+ugfkBpQKCs/DqqpzU
         NJDxnKft/ylNtAa/6A3Rvr/i65bK4onYraj1HyzBnwXKCZjbaFYgT/TvtWioI9AahNz2
         AKC00Tobphp7yWovPid8gV9REx0pH6CNGK3B65r25G8wVxzEnnRxrX9SVc8joJX98tX0
         pvdiSJotWw12Lgr/dMELiOgUUKVgYTtuP6Asgr+P7hdKuE4BXFH1FbtOUBGT4yILt6Eh
         cuVWLGqTEEnUUonH6WtJm9t7opXV102kftKNuGmk8zGn7tEAVjfRC36w0j0/oLXcbuRX
         li+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771344958; x=1771949758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7EaOk0UZuef/7ty3iD0mim+SVVJ5a6pNLO6sSAstrvk=;
        b=YvfwBH0CRswWVsc3iAG4DfljvQfmkCJIok9FrMr3Q5NDqCdgiuoO2bMKSL+A3rQYUX
         TmrtuEsGTEN52UtY2exw+h15OIWk6MAQZw57Ou4+gmxwvKgqSLBieBI/y8IBhN5iwF8+
         ktnsKN8FZlgmMR1qc9VDhFAJpVh1147HWA3PEEZt7F9zp+2KlG011Kjt6Z6V5evgpUkx
         0jNeVQaRsvjSHSubDh4O+gTMEBZoSnUQYhcmEuvvpEfTQkU20DMO+Ss5B9tTLbw3vGUt
         szogs21Q6jgAbmDTXblyEudbNRZPCJR9Rsrl4HXZXzi8JPkI5n4nweDm2/CPeoYHp+DB
         wEzg==
X-Forwarded-Encrypted: i=1; AJvYcCV20FyIGdd1shNBu+M2xjnvvDtM9tBQBq9XuH2KQs00tnkQ8kwSiGiRm+NOExEE7g5FseU6aw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwhSzjUiNtzcWLCPQP7lldhO1Cn9thFFGKqPU+qmtjWUBVLWlmD
	WuzBsXik/KDpYRSm1TNxNqguzs2xvK0YwBpZ9651sOTTlroaLJIZB0CIuPsPs+aeY/jeka3+MzO
	4BtY5a9SdJmYErlJDQIAVK1TCm9rSAg162EvTa8Hiwa+deKVqW2cPZmv39Q==
X-Gm-Gg: AZuq6aKVanvkd4JEsQ4OyOK/UCXy+v3XzEWDZGBr32S90sz5ly3XWdA0XlC88vYkaW9
	L+rGU8NHKCgOkYbUdjO20Q5omf4sTfG32Bn7xLpK3AMIdq2MJtdfXwRJL04gpgYfLKIZkGKh6kO
	BB8u2MonRkRvvd7Nrte9iw9zhlWWkfiHnMGS6uEVBzeyqzgNT2fzYFtvutB4CBZaGpC5I9ou/pK
	AApLXrWCkoBx5w+VzwEn9bSp6r+l3qo9RB0g1O7vj12cYswvgZ2MM0mkOouAqUPbAzbr80J8A8y
	Lswt51e1X7CqrKs+1LCgGWnueqjQO/bUhDwAXaR7amfxNEHi54h7VlDiHGG6T/a2K+3RdLV/3tA
	bVLHiFZHLdM1TMPZ2iVTYGD+Kejkm0j+bVz+1hLWkvm88OWH6x5z8WJstAeBENjWZS5Gbqqy1P6
	9PSI/+XQfcKY4ZcPKhLItICEBKio1MYbir5ck=
X-Received: by 2002:a05:6122:1313:b0:567:2200:a6d6 with SMTP id 71dfb90a1353d-567cda4b676mr4349332e0c.7.1771344957690;
        Tue, 17 Feb 2026 08:15:57 -0800 (PST)
X-Received: by 2002:a05:6122:1313:b0:567:2200:a6d6 with SMTP id 71dfb90a1353d-567cda4b676mr4349214e0c.7.1771344955719;
        Tue, 17 Feb 2026 08:15:55 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e64cf63eesm3295556e87.18.2026.02.17.08.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 08:15:54 -0800 (PST)
Date: Tue, 17 Feb 2026 18:15:53 +0200
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
Subject: Re: [PATCH 1/7] media: dt-bindings: qcom-kaanapali-iris: Add
 kaanapali video codec binding
Message-ID: <logrdwafmqpfjoxyk7aqs3ahb2qhgqrtcxjkvtclxopkxqvrbh@q5zq46wxyrsq>
References: <20260126-kaanapali-iris-v1-0-e2646246bfc1@oss.qualcomm.com>
 <20260126-kaanapali-iris-v1-1-e2646246bfc1@oss.qualcomm.com>
 <r642meaclfme7thmb6spkna6xiuhbjuqw6x32jndjqhwqjtbbr@qkcziz3cyxb6>
 <b5ac0ab7-2540-4691-99b8-18d67ac63717@oss.qualcomm.com>
 <dhcsnc6y2r2bcjlc54ebo2hakc4tufub6f4oluqq6etjzdlas2@ggwzwoz24kjc>
 <5170c5df-e22e-46c0-9713-3c4e7bbdbf63@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5170c5df-e22e-46c0-9713-3c4e7bbdbf63@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDEzMiBTYWx0ZWRfX6H85rK1aMcPK
 SjxphnuUKZFavgcSQi6DQ2G2sMk6zC0RFv7SbggCdcOfbb4pWUU/y7AgF/8c7bOGdOXNRY4jW8J
 P73u1GrVoMmnoKaELpjdSa9/bKQrfrAiJOH7FgMgM7MEh4c0E7Tmo2TqiZNuhtLUkWxOaF50PtW
 G4mv8lBiO+7LD/RxHNMqky+6nOX6h5xuZQixiou88jS7JkCP2gHkM0JoGhJ6mfA0Ew6ikHxu9TC
 N+4UNvOs+TjYHivZsZfstPnE2bJF2W/s/1VS84WOF2nD3/1SRPds6cO917ACXxhLNKQJESDPR17
 7MmjuZSBF9Xwx3HrZT2DUvKqYy2bvIjOeBeVnM51MwgatZoQ+ZbsEyGi/EblI6RaHK5Nf2F2Mwf
 qj8lLdw7zXjBgu5FBZV/su3sMZjGd9DZsg88gxtOmT9NtKZFroJt75jFu2xRKTFqYEIHJtSn6sq
 NiFP5bbKEh7vPPjX03g==
X-Authority-Analysis: v=2.4 cv=b+G/I9Gx c=1 sm=1 tr=0 ts=6994943e cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=rnrFY7iE3EE6iVj7r28A:9 a=CjuIK1q_8ugA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-GUID: 1wNWvdADkYA3j22jnBDJ0YsNmaQjIrz8
X-Proofpoint-ORIG-GUID: 1wNWvdADkYA3j22jnBDJ0YsNmaQjIrz8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_02,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602170132

On Tue, Feb 17, 2026 at 09:04:52PM +0530, Vikash Garodia wrote:
> 
> On 2/17/2026 8:06 PM, Dmitry Baryshkov wrote:
> > On Tue, Feb 17, 2026 at 07:13:39PM +0530, Vikash Garodia wrote:
> > > 
> > > On 1/27/2026 8:39 PM, Dmitry Baryshkov wrote:
> > > > On Mon, Jan 26, 2026 at 05:55:44PM +0530, Vikash Garodia wrote:
> > > > > Kaanapali SOC brings in the new generation of video IP i.e iris4. When
> > > > > compared to previous generation, iris3x, it has,
> > > > > - separate power domains for stream and pixel processing hardware blocks
> > > > >     (bse and vpp).
> > > > > - additional power domain for apv codec.
> > > > > - power domains for individual pipes (VPPx).
> > > > > - different clocks and reset lines.
> > > > > 
> > > > > iommu-map include all the different stream-ids which can be possibly
> > > > > generated by vpu4 hardware.
> > > > 
> > > > It's not how it can be defined.
> > > 
> > > Do you mean to elaborate the different entries within iommu-map or to
> > > elaborate the different stream ids and how they are grouped into different
> > > functions ?
> > 
> > The comment was sent three weeks ago.
> 
> yeah, if you could still recollect, you can comment.

I think it was more about 'stream IDs for pixel, secure, no-pixel,
firmware, buffers, non-buffers and direct insight into the VPU memory'
(pure example, as you can guess).

> 
> > 
> > > 
> > > > 
> > > > > 
> > > > > Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> > > > > ---
> > > > >    .../bindings/media/qcom,kaanapali-iris.yaml        | 234 +++++++++++++++++++++
> > > > >    1 file changed, 234 insertions(+)
> > > > > 
> > > > > +
> > > > > +  iommu-map: true
> > > > 
> > > > This is totally underspecifified.
> > > 
> > > oneof would be a better approach describing the possible stream-ids.
> > 
> > oneOf of what? It is items with the definition of each item.
> 
> something like below,
> 
> properties:
>   iommu-map:
>     description: |
>       List of IOMMU stream IDs corresponding to hardware function IDs.
>       The number of entries depends on the SoC variant.

Do we again have a story of variable number of entries for the single
Kaanapali platform?

>     type: array
>     oneOf:
>       - minItems: 8
>         maxItems: 8
>         items:
>           type: integer
>           description: IOMMU stream IDs
> 
>       - minItems: 9
>         maxItems: 9
>         items:
>           type: integer
>           description: IOMMU stream IDs
> > 
> > > 
> > > > 
> > > > > +
> > > > > +  memory-region:
> > > > > +    maxItems: 1
> > > > > +
> > > > 
> > > > > +
> > > > > +        iommu-map = <0x100 &apps_smmu 0x1940 0x0 0x1>,
> > > > > +                    <0x100 &apps_smmu 0x1a20 0x0 0x1>,
> > > > > +                    <0x100 &apps_smmu 0x1944 0x0 0x1>,
> > > > > +                    <0x101 &apps_smmu 0x1943 0x0 0x1>,
> > > > > +                    <0x200 &apps_smmu 0x1941 0x0 0x1>,
> > > > > +                    <0x200 &apps_smmu 0x1a21 0x0 0x1>,
> > > > > +                    <0x201 &apps_smmu 0x1945 0x0 0x1>,
> > > > > +                    <0x202 &apps_smmu 0x1946 0x0 0x1>,
> > > > > +                    <0x300 &apps_smmu 0x1a22 0x0 0x1>;
> > > > 
> > > > #define the functions in the ABI, provide them in the bindings.
> > > 
> > > Ack. will introduce a new header at [1] and define these functions
> > > 
> > > [1] https://github.com/torvalds/linux/tree/master/include/dt-bindings/media
> > > 
> > > Regards,
> > > Vikash
> > > 
> > > > 
> > > > > +
> > > > 
> > > 
> > 
> 

-- 
With best wishes
Dmitry
