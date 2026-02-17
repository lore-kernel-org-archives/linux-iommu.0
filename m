Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA7C372B31
	for <iommu@lists.linux.dev>; Tue, 17 Feb 2026 18:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771353327; cv=none; b=a13YIxMweFQXlZagLNqojsd3XJyc6KhZkhXpW9PckoUoijiP3Xw1P7BVW5l/fwFVTiBrQh69SzhcvJ3NiL8LXOwyTk7doE5d04kO4POpVPdpqz/KGcJC+fhZGSaJQSqfRaLg6U6dOXoHCRd4DWYf7LFdrlCbtJFaNdkivTZfhew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771353327; c=relaxed/simple;
	bh=b96nWBBrMiohzTfpcBlNYGZvPJVElNYZ63gNBTfy7bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iO5Fu0Bk+eFBUYL+SBRVIiJceq2Kfnk5PlxbJ6vNVFrx4b5TBmg1r+J5DYNbuZJmnF3dt3jb3+vhTLun1OfEtOY60BQRJDpnuHlNAgtZaqDSPQGDIufsAUXGVqFB3y+IsFDHIVOwf2kyWiATOlgvlNQqU82KBm3fR0NSEc9rM+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YxmEvdoc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e6dZwWCa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YxmEvdoc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e6dZwWCa"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HBCvSU006270
	for <iommu@lists.linux.dev>; Tue, 17 Feb 2026 18:35:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fQ/ZdKhW7VMsbWZT49yCtlud
	XnrHTU2bpqIC7iOTAvE=; b=YxmEvdoce52rIZmFAt+u/PkswMfKPZDQz4XOmsov
	Z6dXVz8KrVivqWQvX374/Os+2ENn0DF2kivvKF5x19YXtZkAB6v3B7/4KwPR710k
	m463OORpEjN4DS0MsJ2kk1pQwMbyf+FpcBVOACPaTNLualQ4Fz/WwGi6v2iJt2ED
	v6mOjbY81TmxnZKZaQoIqn60Hv/oPmkNK3iIxahubsF7uJ1sT6tsJZnoJyY8GfdH
	5K6h4shHtECCOAkBxcftFsIj8/pRdVeLY7UvUnX6UnnBiM91GZCPR4wdLacvLmTH
	rAwpo/wVgruFZQW7gFmDJt85w6hHjTxI6Vh6j2FlQvpSCQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc5khbphf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 17 Feb 2026 18:35:24 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb403842b6so3061418585a.1
        for <iommu@lists.linux.dev>; Tue, 17 Feb 2026 10:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771353324; x=1771958124; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fQ/ZdKhW7VMsbWZT49yCtludXnrHTU2bpqIC7iOTAvE=;
        b=e6dZwWCauNTaXVuLhqEBKzoMGh+e9TFJRwpwr8BNABx2jaP3ClwIsa0t7h7XyywSjJ
         eF95V1aV5VaJAzdEChgaoKFL/ahVlr21kV5b/3ZlTwKerMNqeZ65339mkDaEbd4QavYl
         ZmcMnPmUxGYZTQxk8juUFrGHb09HURSUdus0Mo7Mlizin4WXHIEBTRK6KMI8mGMid6ih
         QcmkPTMLutDQ8Sj0zdAPW3eMd6fEOq8HtLiw8K0bWINmPTShTsM6JBMw0lok8UAHip0a
         8STMCckyYRsyV4aBjpAwgV5nAgwSlKWoHkgEeSqAGCm95Z5DBZ4SG2jWPlQM92APyMc6
         uT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771353324; x=1771958124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQ/ZdKhW7VMsbWZT49yCtludXnrHTU2bpqIC7iOTAvE=;
        b=g0QRZ3Omm0az7BSQFFKAf7k3vTvo4Y9DOI31qdiPzCwHjfbyuKnGYOE6jT4IYEO7sr
         Yo4c/mjug2LzWAveLhPCDf1ajR2By5MA+aCiDHFjmB/eUJ0aKgQ7rhYL8fy7uTYgfU/k
         jB0GW/SeUtgmrGOuOVBGHrnQV0ABkfxJbH2+rozpygxQg2F/S2SNy6UEribKxgVdeqb+
         S/J80oorw7fLH8yM2+T6LKAIL0fZKx2XCFD6IOFQm+qO36IfupVPwsTKJcrkzsgWaNya
         ENKgIpA65lxawo+AqSbMwkhWXk5nQ6u+akOTpjFZ5stioEGWRKSzJAzNjv1nhP1yNAB0
         w25Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBkOvFFM8c1zJ7WnzyKS42Y6Sr8ldLnbhoYIUGu/d+WnnaHfWTo5BBulq5u4X9SLh+VXbuqA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzTQ+s2PisJkXTuQ/ojUgn0Zxr80Mi3r1Z9nw3JD+m2w/FQ+4gT
	EjRd3o/uNaohC6YMJm6zAUqa5+y7JPQ3yCqShWYSDfDbMjHWr7kZ12fdUYClASIhvvOCZkj2msj
	jnm6Z1S3qJ/PwBBvxGumPpM13L2skB2BfCVhWNabZ4id8TIiTuTlpzGmG6g==
X-Gm-Gg: AZuq6aKlcNflc4UXjAb2dIKYvNbmCIiGyvdlBFXVImtLR8dgA+Mb9e1s0cE9W4CHlpq
	LBiaKvnkA6UBx9vCBkkyniwnOcxZF88oRiqEVjRH4vwjlhT5VCyaGnHgJ5B9oWB5CIG+inSRAXv
	tyD7FQd2qtoQWdybPsB8CTgjmskd5UqELLTXAZil0iZWHuVivTM3HRQSVPQdtEq0j3ObYiF+oK5
	7pOsPPwiORDxjhWJWaONj3lPyuRzsXZsTosIpgBJyzTYpn6KRVcU9NOZerIsojvJSI6TEkKZGcs
	GKbIVenGMslGePSFYSNI0fhbhzUUOn1MeruQUmmoBGnNhfjDsDSat+u+bjBpSnLkz+iia9KE7Xa
	BvlvkLMuWqoFxYstxWpGEN7SKmKOC4Pz9Sd2oZ1UYt4uyBgYYHkN6GKI8oVlzJxNJZX6a284cbD
	z1Inz6dTeKoEDmEy9XQ+PTxVzuEly1HhbgN6M=
X-Received: by 2002:a05:620a:460e:b0:8cb:31d8:43a1 with SMTP id af79cd13be357-8cb42253ed2mr1810086785a.11.1771353323584;
        Tue, 17 Feb 2026 10:35:23 -0800 (PST)
X-Received: by 2002:a05:620a:460e:b0:8cb:31d8:43a1 with SMTP id af79cd13be357-8cb42253ed2mr1810078785a.11.1771353322928;
        Tue, 17 Feb 2026 10:35:22 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38706928d9esm39925311fa.42.2026.02.17.10.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 10:35:22 -0800 (PST)
Date: Tue, 17 Feb 2026 20:35:20 +0200
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
Message-ID: <xysdxwyb7nbynbanrn6j7ojgqnnb3ho5yljdiqm22vamlpaax5@ovy3xw7gtckx>
References: <20260126-kaanapali-iris-v1-0-e2646246bfc1@oss.qualcomm.com>
 <20260126-kaanapali-iris-v1-1-e2646246bfc1@oss.qualcomm.com>
 <r642meaclfme7thmb6spkna6xiuhbjuqw6x32jndjqhwqjtbbr@qkcziz3cyxb6>
 <b5ac0ab7-2540-4691-99b8-18d67ac63717@oss.qualcomm.com>
 <dhcsnc6y2r2bcjlc54ebo2hakc4tufub6f4oluqq6etjzdlas2@ggwzwoz24kjc>
 <5170c5df-e22e-46c0-9713-3c4e7bbdbf63@oss.qualcomm.com>
 <logrdwafmqpfjoxyk7aqs3ahb2qhgqrtcxjkvtclxopkxqvrbh@q5zq46wxyrsq>
 <ff6c4a6e-9478-46fe-b17c-5b4221f04b52@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff6c4a6e-9478-46fe-b17c-5b4221f04b52@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Coyys34D c=1 sm=1 tr=0 ts=6994b4ec cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=a0tnjT4OmPkcAwT1YvIA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: jozSlp13vWVn8V9Y2AQoY5UDWAXWtFGK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE1MSBTYWx0ZWRfX7wpMBOVku5uo
 moM4bv7cAOkDk1X1mzhD53YK8Sf0MuJFMCo4nItpiwxDKnT09RDsuCaMKX3kcavukDFnwCSU5zh
 BZZ7t70tGeMGX/VRMMZIFQsPWy9+WMbxzt3OdsCKHtyW4PnnTzmJQ/NdRiPZdPY0HHbU0jpW0CT
 1KKtqDxXHQQxSt9we6yB5tfG8RkDJQoT060k3tjYdL4lYUiyJ5yBq6oNhb2JRsvaQpWYPWRZ64o
 pePsC+Ggvi+CB6cXYY4DvWsG7Mmt+Q6cAVZQqSNqCheU0Eee/BjWPuKZcujg5GDFBNy6iS594f4
 WyxaSHHlmCtGViGreHC5L77Th84YPBqe68AsM6SxlF8ldeg47JGiLQDEOBmGzwJMX1LPE8lMNPV
 +syAPcKHlymWZ2SEuCiHBHA86KGJTEHfnZ2BzJ1rnkxx99wEUaa6+LhIBOFph38nq7/xTIda6FX
 5Rjdj2rbgiyZNfFWcBw==
X-Proofpoint-ORIG-GUID: jozSlp13vWVn8V9Y2AQoY5UDWAXWtFGK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_03,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170151

On Tue, Feb 17, 2026 at 11:39:53PM +0530, Vikash Garodia wrote:
> 
> On 2/17/2026 9:45 PM, Dmitry Baryshkov wrote:
> > On Tue, Feb 17, 2026 at 09:04:52PM +0530, Vikash Garodia wrote:
> > > 
> > > On 2/17/2026 8:06 PM, Dmitry Baryshkov wrote:
> > > > On Tue, Feb 17, 2026 at 07:13:39PM +0530, Vikash Garodia wrote:
> > > > > 
> > > > > On 1/27/2026 8:39 PM, Dmitry Baryshkov wrote:
> > > > > > On Mon, Jan 26, 2026 at 05:55:44PM +0530, Vikash Garodia wrote:
> > > > > > > Kaanapali SOC brings in the new generation of video IP i.e iris4. When
> > > > > > > compared to previous generation, iris3x, it has,
> > > > > > > - separate power domains for stream and pixel processing hardware blocks
> > > > > > >      (bse and vpp).
> > > > > > > - additional power domain for apv codec.
> > > > > > > - power domains for individual pipes (VPPx).
> > > > > > > - different clocks and reset lines.
> > > > > > > 
> > > > > > > iommu-map include all the different stream-ids which can be possibly
> > > > > > > generated by vpu4 hardware.
> > > > > > 
> > > > > > It's not how it can be defined.
> > > > > 
> > > > > Do you mean to elaborate the different entries within iommu-map or to
> > > > > elaborate the different stream ids and how they are grouped into different
> > > > > functions ?
> > > > 
> > > > The comment was sent three weeks ago.
> > > 
> > > yeah, if you could still recollect, you can comment.
> > 
> > I think it was more about 'stream IDs for pixel, secure, no-pixel,
> > firmware, buffers, non-buffers and direct insight into the VPU memory'
> > (pure example, as you can guess).
> > 
> > > 
> > > > 
> > > > > 
> > > > > > 
> > > > > > > 
> > > > > > > Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> > > > > > > ---
> > > > > > >     .../bindings/media/qcom,kaanapali-iris.yaml        | 234 +++++++++++++++++++++
> > > > > > >     1 file changed, 234 insertions(+)
> > > > > > > 
> > > > > > > +
> > > > > > > +  iommu-map: true
> > > > > > 
> > > > > > This is totally underspecifified.
> > > > > 
> > > > > oneof would be a better approach describing the possible stream-ids.
> > > > 
> > > > oneOf of what? It is items with the definition of each item.
> > > 
> > > something like below,
> > > 
> > > properties:
> > >    iommu-map:
> > >      description: |
> > >        List of IOMMU stream IDs corresponding to hardware function IDs.
> > >        The number of entries depends on the SoC variant.
> > 
> > Do we again have a story of variable number of entries for the single
> > Kaanapali platform?
> 
> its for firmware stream-ID, which can be managed by kernel or Gunyah.
> Handling for it now would ensure we do not have to change the binding later
> when there is a need.

In my humble opionion the firmware stream-ID should be there, but let
the driver detect whether to use it or not.

Another approach might be:

iommu-map:
  items:
    - foo
    - bar
    - baz
    - ....
    - firmware
  # firmware might be handled by the TZ / hyp
  minItems: 8


> 
> > 
> > >      type: array
> > >      oneOf:
> > >        - minItems: 8
> > >          maxItems: 8
> > >          items:
> > >            type: integer
> > >            description: IOMMU stream IDs
> > > 
> > >        - minItems: 9
> > >          maxItems: 9
> > >          items:
> > >            type: integer
> > >            description: IOMMU stream IDs
> > > > 
> > > > > 
> > > > > > 
> > > > > > > +
> > > > > > > +  memory-region:
> > > > > > > +    maxItems: 1
> > > > > > > +
> > > > > > 
> > > > > > > +
> > > > > > > +        iommu-map = <0x100 &apps_smmu 0x1940 0x0 0x1>,
> > > > > > > +                    <0x100 &apps_smmu 0x1a20 0x0 0x1>,
> > > > > > > +                    <0x100 &apps_smmu 0x1944 0x0 0x1>,
> > > > > > > +                    <0x101 &apps_smmu 0x1943 0x0 0x1>,
> > > > > > > +                    <0x200 &apps_smmu 0x1941 0x0 0x1>,
> > > > > > > +                    <0x200 &apps_smmu 0x1a21 0x0 0x1>,
> > > > > > > +                    <0x201 &apps_smmu 0x1945 0x0 0x1>,
> > > > > > > +                    <0x202 &apps_smmu 0x1946 0x0 0x1>,
> > > > > > > +                    <0x300 &apps_smmu 0x1a22 0x0 0x1>;
> > > > > > 
> > > > > > #define the functions in the ABI, provide them in the bindings.
> > > > > 
> > > > > Ack. will introduce a new header at [1] and define these functions
> > > > > 
> > > > > [1] https://github.com/torvalds/linux/tree/master/include/dt-bindings/media
> > > > > 
> > > > > Regards,
> > > > > Vikash
> > > > > 
> > > > > > 
> > > > > > > +
> > > > > > 
> > > > > 
> > > > 
> > > 
> > 
> 

-- 
With best wishes
Dmitry
