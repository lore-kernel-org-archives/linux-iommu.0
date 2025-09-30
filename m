Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF6135949
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 19:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759260052; cv=none; b=D8deC9fXNpRT3lWVIcBiSfWDBUwkmyi64vOXNp2roVcLIc/nIFuXNZxk4xnQk8Vgu9kE2zJfGsTzm/Q+ARtBJEHHwhCDUH+l3F7YSTDqWVAqpqGQgItfg2/A3YN81S+b1OqTN2euGIRZ4p4/CVm8TffzlZTwY8nyrY7KbDyoZlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759260052; c=relaxed/simple;
	bh=4tUw/b7NIJ5cITKTzV2ZIfg9qQkiXrTbCT2hGU5nEvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExajpXSp78kLrDguo5L2dCM3/5OOzK9XOVuDxorRYm8PAtvg/op/9wrPnp44H+YrwL0YP5ihXAaYgaCSM/kfG6papR46n46EIGlj6bDlsab6kujKM6sKok2XET6Bfhv6mL/9dK8gs5okJ/brcFgCGtNMtoCWLxqzAjkO7zx2Fe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QvqfauCo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QvqfauCo"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UBdqQx020364
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 19:20:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KVXK3wyj4xgxBO/QQE/5ijkihmvihUgMziMTP7OJVrk=; b=QvqfauCoLCsFHunX
	BW86ook4l0mDvdjjOiDOGqcsZnMBR0QjXPr5w0Fh1ir4MAaYUxNmE6N3CorKuHcS
	QKTAtV50kLvUayA/gTgxQnrycTPzg4KvRmimnmFUCiVKhAEQxjHx4tdZxfvES3RG
	oTFF1PIpdIK82Q9Z7I+5YFb272irfvWvirWb4OkSI+9/Ldi9J8ogcHCM3H6mbGyw
	K1vSOcf++D5HqneStj8qqQlRJKQLOQ18NF3asMJW1gRAIbj9R/P8vwxt2OBXCsX2
	UTiu3mKqXDwbiLQ+13xAqQqmcQTt/j7yeCJvE5wF2yAzDnBMZ6uXPiee71XLOU3w
	7VoiXQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6x5tbrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 19:20:50 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4d9ec6e592bso127208961cf.2
        for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 12:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759260049; x=1759864849;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KVXK3wyj4xgxBO/QQE/5ijkihmvihUgMziMTP7OJVrk=;
        b=cOyMEu+i3w7C862GdrFfQ9S3oDh7jJAhyx6yYbYyqvfY8R/OkUZULRD42OSi7vzcWx
         X5krqizy7Lrmmx7lfMIXbH1kosAo47w46K3aBfLQI2IV9Ma/Jr/3sAO94Zajooq3/i8A
         L+WyC10JfWOVS9ouKd9o7OLl6x1nc33yE0K/CX5sMLGcAcyJq6kOQIHPAwLPKctLUrjp
         6w7q2yrYVTAWZqe0NYf9dMAUp1UuFlA3pxMJkY7uNwFk3BT5G6kZ/Ca3KOzto1q/DRR1
         /yR4e/2IB8OVj2CzM6oXB4tD8l8tx9yAoPioEV3AFVfnFCuR/kNwRYCNaLWi8TViQtvH
         JcpA==
X-Forwarded-Encrypted: i=1; AJvYcCXN4HvVJVfiA7sNfPuDfbVZuuJybkJhBQQyHGdydrujhocS/PjZorLC5iagSUSfc24EeAEBCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQ6iSolRMYlIrbzDrLr68OWju57ytcUbGpzjIQdJp4flnw8PcH
	sUxUKOuF6hH8We6dNOcZGhPnzf+fpZZOXjWV3CzGkJ8t7FipHL9mcj0Gq0yXHSRApn/d5cTtrnJ
	I04RNTCsivMcqnq1I6sykSmPgFD8NoqHP8+y4Eon8DNPi4Y8w0TO4t7IgCw==
X-Gm-Gg: ASbGncsqF3k8ehr6jiZ3rhGSuGeiDYVjm9xhR77lQBgzHkaj663GeFde2ns/bxi9nhW
	hvaJzMNiDcIYelGkvCW/ZArzFTGCTpur37Ek0O0bwemGVtxeXpmIpd14fhEe/DF+XNmGzomY+wi
	MwbJeaNYLKpkdL7LB/+hRTPRWfB8kX6X809nvFZAmN9Z/zeQW3DU6KB0ScnEiKth9B0PYnhlrXG
	laVFDn1KkrhrR71H5iS0YPjS1y2SQYDdjd7puGE/On1yDgp4FoeBx9M77juTF8J5uBgXnEIxDxM
	GnxiV1fgbiTniRZfabBcP+TLntTGWcLK59BgYZkQ1eih1N+8abFvdEcBfe+QnJPo1RtC+zN75/7
	nbl8w21OgKOsIvhgmoEw+1fWuJyupKTW2lhCk0r76hsYFmVdCpn2DZYy+Ow==
X-Received: by 2002:ac8:6906:0:b0:4d2:d413:1f3a with SMTP id d75a77b69052e-4e41e256b01mr10937161cf.64.1759260049470;
        Tue, 30 Sep 2025 12:20:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlv8GouDfLH9jxcZXz4sZ9qg6O7hSAY2xOrBu+sewtGI48yKBVhvRDPT2OTQMfLyqgcLMpDQ==
X-Received: by 2002:ac8:6906:0:b0:4d2:d413:1f3a with SMTP id d75a77b69052e-4e41e256b01mr10936801cf.64.1759260049035;
        Tue, 30 Sep 2025 12:20:49 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-583134310bfsm5244156e87.26.2025.09.30.12.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 12:20:48 -0700 (PDT)
Date: Tue, 30 Sep 2025 22:20:46 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <rob.clark@oss.qualcomm.com>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH 03/17] drm/msm/adreno: Common-ize PIPE definitions
Message-ID: <ftbecn7dlcp6pqtpfl5v7kv2kevz5m4yqcy7fg3atkdjabkt67@zqwwostqqfou>
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
 <20250930-kaana-gpu-support-v1-3-73530b0700ed@oss.qualcomm.com>
 <xsgnpvswvkyuxiviv4uyb6pxbpi646fut6dy54kpyfisqrxycz@tyfox3zdi26e>
 <CACSVV011=_szCPbdm6YA8aJjm76r_BZP9QFeOzcAGCvqUUTebg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSVV011=_szCPbdm6YA8aJjm76r_BZP9QFeOzcAGCvqUUTebg@mail.gmail.com>
X-Proofpoint-GUID: 4d22r2sxM2KSnjqrToOD4BmM7SkQNklZ
X-Proofpoint-ORIG-GUID: 4d22r2sxM2KSnjqrToOD4BmM7SkQNklZ
X-Authority-Analysis: v=2.4 cv=ZtPg6t7G c=1 sm=1 tr=0 ts=68dc2d92 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=IkzWstXsGuqL4x2q7pEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxOCBTYWx0ZWRfX1tCuOFi35XDg
 LhWjLpTzH7PtXfgqB/Id2aojSw0sP1TLcCERybLer/yQiLW+jqGqiVHNu/RK14r+KwkHiBvamIk
 hNQFvOumzbRE9Lq2NbsvwuTkUGwuURdIePJ8Xl5mfdgpQYP4UgDvuzoeq+5o06xlPcllwyUibjz
 GMjTWfgWtEro5twZiyGaXF8ATOrCKQI+V8CrEpPIjDjMyDj+eGoTkpdS9oFxC95IKiPPoZixkGE
 0tkHqO30D2hVwLDebk32neuM355TMWgvDJIEj4GEIVacKFhcXY3Efa169EpOJ4HrYk5W/xy6pvl
 avgk2keKzFsL6Ao22htVFLPmydu9FWXRBY561/Svg2rRdiLmArZded6uY0JRd/orV8fI28fDKyo
 mgV3txdWhUNAZwKnig4rxQ7RD+fh7Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270018

On Tue, Sep 30, 2025 at 12:25:55AM -0700, Rob Clark wrote:
> On Tue, Sep 30, 2025 at 12:05 AM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >
> > On Tue, Sep 30, 2025 at 11:18:08AM +0530, Akhil P Oommen wrote:
> > > PIPE enum definitions are backward compatible. So move its definition
> > > to adreno_common.xml.
> >
> > What do you mean here by 'backward compatible'. Are they going to be
> > used on a6xx? a5xx? If not, then why do we need to move them?
> 
> Newer gen's introduce pipe enums which do not exist on older gens, but
> the numeric values do not conflict.  Ie. each gen is a superset of the
> previous.

I see.

With the updated commit message:


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



> 
> BR,
> -R
> 
> > >
> > > Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> > > ---
> > >  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h        |  10 +-
> > >  .../gpu/drm/msm/adreno/adreno_gen7_0_0_snapshot.h  | 412 +++++++++---------
> > >  .../gpu/drm/msm/adreno/adreno_gen7_2_0_snapshot.h  | 324 +++++++--------
> > >  .../gpu/drm/msm/adreno/adreno_gen7_9_0_snapshot.h  | 462 ++++++++++-----------
> > >  drivers/gpu/drm/msm/registers/adreno/a6xx.xml      |   4 +-
> > >  .../gpu/drm/msm/registers/adreno/a7xx_enums.xml    |   7 -
> > >  .../gpu/drm/msm/registers/adreno/adreno_common.xml |  11 +
> > >  7 files changed, 617 insertions(+), 613 deletions(-)
> > >
> >
> > --
> > With best wishes
> > Dmitry

-- 
With best wishes
Dmitry
