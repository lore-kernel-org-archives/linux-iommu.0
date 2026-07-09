Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CE53BED70
	for <iommu@lists.linux.dev>; Thu,  9 Jul 2026 19:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783625950; cv=none; b=Ou2U+azjfdY9cB65uql/rBlBR30xG+RCz4KF+DuhPJoHOAzNszS1eVUK7VNiRov0rdj+LF/RA+DYoJgHiqx5QTxIo8PWnVMZHHI7Zl6sxq/8xk+A+i/hQ86+FrWMDgmMIhXtmCUO8DPKMF2tgW+OGKpsWR+q43Lif7MNBrH5bL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783625950; c=relaxed/simple;
	bh=QD9mJPs+t+9s56rb5xaB5rKMWigU4OS46sDGTzukNhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFqex0LkHMjWqRX7NpOsSyLAad6aY2gjowgPJdzA2MDvovBPLP/v9IaEj2huQKmgF91gqOZ1dMSIcKj3Yt7BblOslmvjlxWQkFxwBXPivgW5dQpR+mxbWfUM1Mkql4FBKHmgBfx073TIcHj4CKsVt7qBtRVdGsBN/l3Bu5Zdjt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f51JX49F; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cgi5CHC/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f51JX49F";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cgi5CHC/"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669HWuUV2514890
	for <iommu@lists.linux.dev>; Thu, 9 Jul 2026 19:39:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=lXtkLmMeqA5Txfu3sYVMsQEq
	969mvFVnJZMw0O2S5F4=; b=f51JX49FycsxSY94vb3shNav9rc4rU9buD/v8EbY
	gVT3Lzsu85teQtDP4CIdy4rdzXRUPg42PS7hEJP4b0FsK6YCzMl1q46AneSH5TZh
	KiTZVG/rQcrE/J44s0nXXL/PfqyCp9d9o8YRwns0vDcsmgnm0IaLH+DDznbFgCyr
	iU3M7WhK1e4+S6M6odp6pB0/bZCh0rGdAAEyA+rajwDiFSXUBTR/F8zsUQ4fyqgN
	Xd57d61SwMw2Xn/A3UrfTytP5EsFkWf1198r7R2i86Y97z6boIBCgQdzRf1jWfwY
	h3EwAl+O3tTATUnjedMXV0VdoK2YMibTyYBQkNrldiFmFQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa418m6qd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 09 Jul 2026 19:39:07 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-96939fcd33dso60238241.1
        for <iommu@lists.linux.dev>; Thu, 09 Jul 2026 12:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783625947; x=1784230747; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lXtkLmMeqA5Txfu3sYVMsQEq969mvFVnJZMw0O2S5F4=;
        b=cgi5CHC/lhshoyAg/+cNoNneiSKLYktvB6jR2KsA3AzrEyyJfSzLr1J4AHNJmWvrV6
         itchRijch3Gl+HMLyD10AqXF9ZJoPXoLk5GxAeo3ZVB2avDCaDQkMBE1GctMJXScMiNt
         bVQQHaJx4sTbRnXhY8jb/S1rvPNILyXLtY0Zbv8yGutxYsJg+eXjUZcud+ty7nlPluZ2
         lEZJYOakKTm86J9tiVLfHd9HWgWSAZPM81xTRyezD4ROUM6ATg7bT6loyjRf6aoWZWQh
         drKNOQEgYqjej+AbvL0Ajl/jdECo2Z1MBgkelJcCMhXoE/RB2G0ayoZOcKRBwEF1xy1g
         vdew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783625947; x=1784230747;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lXtkLmMeqA5Txfu3sYVMsQEq969mvFVnJZMw0O2S5F4=;
        b=cnFrFp8FWK9Mnk7jHv5MJth1i+1H7vwvXSixN1Q0DBfjTNBbG//r4mODWXNgciB0sK
         grApvw2fvv00WWcZVmwaxFj1PCeqT6yMdgoDB8Jgqc4OanT/+fzQP6tjk+tkWPZ1jtD5
         5ou9lf7YLHa+TlDAfrR6q8/d2hizMKrw+rFkFSUhuthleM2xjk2jhBmE/TMt8RByVl2B
         vDiqYXSgYqI4vtwCv4g0r/VSodSSVmXYSF+Eisjx2EB/4V790XQB/OJKClH7OkVR0sfC
         eypAEyx0mlW18MrJPa3Gfr/Ln3Z5wjX6ShdeSXv7+CTbgP+vOtuGq2TaOitZVAwZAX+L
         dtGQ==
X-Forwarded-Encrypted: i=1; AHgh+RrBfdye7ZpYF7W5RpY8qXbNTeqs3Lk0t7J88AaGGVyvjGv7omod7zYql9q4cd3UsHX485e27A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwxZEaPvUUTafx8vJVUpoh84Hiq1e64D7y8QpPOOUM8DxJsmv+k
	CQkOEoVVfG1FJu7J1Cr4fNNxHhilgd6TAuulWc4UP5+dTHVZgjsDNTRzcDFikrTBZy7s05GNOVv
	icnCKKqr0LSJWhCLUjkBSbbeRIZuTMF9ZjWquS/hw4zqyxK7keqXNLzB1OA==
X-Gm-Gg: AfdE7cmCGfImRK88EpbAbr43Jc95GOWb8B9inZB3+M0boqLmmtKWUbk5055Jwb6DQky
	sifAysyBCe5oWkRsNzGahmYXDiKvZR/ykib5lifl5lVAxsEANXV/rCZHQnkWqZxhLvIQYiWRVTH
	RT7fL3RjHz1XFy1XepJgOIGl2nRr+M8LDUFpK7czOAlIKHC+Y0EDI8J9Ym6v6j7knb44MeMUqby
	UBIlyry3ZK1zTdGHqH5Woj0/eDk+ouE5MDUlQ98S1oT/tm6GKtE/7TJatLU6+lGqTcLmcwaEzuV
	AncpWTSnR+t7QkJIXKQK2+XCEgoJnGcP078+oUZlgJONv+PEDwM81H77VfCb5Q6Wsvnfvvuu9dC
	Fq7DHdsLva/plI7J077djhEGlHtMY3YUQRNbI8Hjjqmh6k7gJoFBtWctb6GYzfO8oyV0xlU95Oa
	O2yjURRMD46hM9zBCv1sXII6Zx
X-Received: by 2002:a05:6102:1490:b0:631:af51:7d8e with SMTP id ada2fe7eead31-744e00d15demr5013522137.17.1783625946441;
        Thu, 09 Jul 2026 12:39:06 -0700 (PDT)
X-Received: by 2002:a05:6102:1490:b0:631:af51:7d8e with SMTP id ada2fe7eead31-744e00d15demr5013479137.17.1783625945914;
        Thu, 09 Jul 2026 12:39:05 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39c84b13407sm5148981fa.12.2026.07.09.12.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 12:39:03 -0700 (PDT)
Date: Thu, 9 Jul 2026 22:39:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Anna Maniscalco <anna.maniscalco2000@gmail.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 03/13] drm/msm: look for lpac from dts
Message-ID: <wtun2cfukyzxlsfiz2izsejd33k4jpapwqa3uqih5drcsrkff5@e6llkke5dayw>
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
 <20260705-descriptive-name-lpac-upstream-v1-3-01d50c3e0c99@gmail.com>
 <rwohvfbsw2brpxrfg26egu5arwe6g7n2etelo33eegmu5cz65k@3syofuxzsjrc>
 <dc5aef2e-600e-4e97-b76b-dcc8bd72c709@gmail.com>
 <m4vwrqt6yyaawpvkyrqfzs3kbipbhygmtrhphuthl2gmjvkgyt@u2d3dnvl2phy>
 <54cb37bb-aaa5-4c5d-a563-acca4822dd35@oss.qualcomm.com>
 <t5gu6ciwmxdb2jghc44gtixdsbedkgy4yzke5sgawjrr2h362u@ahvhh3yfe6lx>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <t5gu6ciwmxdb2jghc44gtixdsbedkgy4yzke5sgawjrr2h362u@ahvhh3yfe6lx>
X-Authority-Analysis: v=2.4 cv=UI3t2ify c=1 sm=1 tr=0 ts=6a4ff8db cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=9jRdOu3wAAAA:8 a=KUW68C9JwZgBSL_lDhwA:9 a=CjuIK1q_8ugA:10
 a=TD8TdBvy0hsOASGTdmB-:22 a=ZE6KLimJVUuLrTuGpvhn:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE5NSBTYWx0ZWRfX1uasM7TOb0xQ
 a4zjnHIqgoXsoewNvOIu0Qe2H6iZseuChh1oLMaXe216Xb+7iZcCo93415YESndXfSeFzGjQzLS
 SiLiyivrFZExdRob6x7uWmFm/bWvS9m5Vdc+d2dDNQnQcbFCtaiy3KaWt8PQOx1g2Guv+UfFlCU
 ifjxarBmiNgKSgFWdDmRlziMH3Lbuq9EOv//QgUwhlnlfGYaj9uap3jxUK7tQaU0bhfaVphPzZT
 y4tqMeaXoZ5HSfcFpwLpvzvhGBlScKAMqtByKCoD3qkUykyOY7ks9GPVdaes83TgxcGOqgin7sx
 fKAKz5PYuD8Lm6CfQKx8GHUBI/Z3ID969Qq7MwNwUbubue6LhOPNdPgqcEZGmRKeoIt+wV073nb
 6FmcW6rrKGmwTIn9oQVw0IKHMOZTWbRAdGaheyQQ+SlW89+aD7FbXGHNoJxpyda4VY37ckmNlQA
 kkn6hDoTxl86rHshb9A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE5NSBTYWx0ZWRfXz6vI+KGbxU7d
 0ZGGRBeGPaDPrGFan1XAVU2J8zKkH+uFdwNUU17YjDwyeVmAAYrIUkfkFW+ZM+cnMPeNmmInTiR
 gR6vBqpQBlAjcp7MUR2VNER4cCL7gBE=
X-Proofpoint-GUID: PU6rZg30i3zs7-0ME-VfmHjyMSFlRrqS
X-Proofpoint-ORIG-GUID: PU6rZg30i3zs7-0ME-VfmHjyMSFlRrqS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090195

On Thu, Jul 09, 2026 at 05:54:23PM +0300, Dmitry Baryshkov wrote:
> On Thu, Jul 09, 2026 at 07:12:39PM +0530, Akhil P Oommen wrote:
> > On 7/7/2026 10:09 PM, Dmitry Baryshkov wrote:
> > > On Tue, Jul 07, 2026 at 05:02:43PM +0200, Anna Maniscalco wrote:
> > >> On 7/6/26 5:04 PM, Dmitry Baryshkov wrote:
> > >>> On Sun, Jul 05, 2026 at 09:13:37PM +0200, Anna Maniscalco wrote:
> > >>>> In order to associate the SID used by LPAC to it's own domain and
> > >>>> context bank we need a separate node on the DTS.
> > >>> Can we use iommu-map instead of adding a new device using the same
> > >>> addresses? You provide zero explanations, but it seems like you are
> > >>> trying to separate a part of the GPU into a separate device, but it's
> > >>> unnecessary.
> > >>
> > >> What I was trying to say is that we need to map sid0 and sid1 to different
> > >> context banks.
> > >>
> > >> From what I recall, so long as we use the same dt node, the iommu drivert
> > >> provides no way of doing this.
> > >>
> > >> What kgsl does is having a node for the iommu and then subnodes for gfx lpac
> > >> and secure.
> > >>
> > >> The address on the lpac device doesn't really matter. I have very limted
> > >> knowledge of DTSs but I think we could just leave it out altogether?
> > > 
> > > I think, you were poined to the Glymur Iris patches. Another option is
> > > the QDA driver being submitted too. Both ot them use iommu-map to
> > > describe the same usecase - a set of SIDs which are used by the device
> > > but which should not be a part of the defaut set. With it in place you
> > > don't need to have separate qcom,lpac devices, no additional properties,
> > > etc. 
> > > 
> > > I'd recommend following the same approach.
> > 
> > iiuc, the conclusion in this recent thread is to use child nodes for a
> > similar case:
> > https://lore.kernel.org/all/20260618151745.GD231643@ziepe.ca/
> 
> Let me check internally.

After a brief discussion: it can be either, depending on what suites
better (and if you can persuade DMA / IOMMU maintainers to let one extra
bus or not).

-- 
With best wishes
Dmitry
