Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6422C23EAB0
	for <iommu@lists.linux.dev>; Wed,  4 Feb 2026 01:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770167524; cv=none; b=fdEFvrZPuzRqvlq5NJQV2EKJR26XqKmRUxz8nrzEX8Rpa/FvS3YndZv0moD71a6Osvu6PsUd2n0bgFVCPpO9BXGJmOk0ZOY/cHQ4dKpRpoWtGfoBICJquAAocku0QyhqaLtXAEDs96s8Tz/HpcybJldwhstdIWCT9RhRA+HTdFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770167524; c=relaxed/simple;
	bh=m6Ixx8jioqtx/I5aFM0EU2IZnm5koObyL3qPDXS92M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eN4epleEQzHnRwSfUN42ZnaaNef3hvQVlNz8o3PlDne5IOLeYYYxRplSkph1/a4qeJbjosrIclTVlFio1xUrxPlEWchZ7Z5Jit5IttIu6+ZNEXoDw70r/loXxbPwPBxnh7+Mz1AxNhw8yxdarlapQO4s+xiEzYq3bkmGRqn4bao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JXt+vWrl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O3Z0ewZo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JXt+vWrl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O3Z0ewZo"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 613ImPw23824323
	for <iommu@lists.linux.dev>; Wed, 4 Feb 2026 01:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=gYan9t9ix9amGizYtC+O0jvQ
	3aoS4QZw/J14ZuX2GWs=; b=JXt+vWrllgsVFB48GTr+5nVWq9ncCnJmDZGFIIIw
	InrNswE4WMZbFTS/sbDFH/depjzBcsJgbs94bxF6V1otnSg1zVTPy24BgS3CpP6c
	JjGTUUxCUKz+mYHy1EVCyk2t0i2Px6Yf7txpZnRNgBPnA7k2Vc57aRrjiQF7BHLH
	CwDu84zkPX4XaPKT/XBUOZG3+hbakinbAFIcPseawKkvCljciQ3Fb4R9XZ3vhHUH
	oPJhkXtqC7h+WAIAzOU0YIKQ1c75lkgvE9cwtb9VjukEjxIxhpllNcTIuhTIyb5e
	5mlTTJLsh9tzkjKdCWFE8iA+ZCV0ZXlI7+9/OD/Gz2CGVw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c3g33jhmd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 04 Feb 2026 01:12:02 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c52d3be24cso973665685a.0
        for <iommu@lists.linux.dev>; Tue, 03 Feb 2026 17:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770167521; x=1770772321; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gYan9t9ix9amGizYtC+O0jvQ3aoS4QZw/J14ZuX2GWs=;
        b=O3Z0ewZoLEK66PD2sXDyt/dn//7nDoad9rFKl6s8NqSabQLIXGX34U7C/F/jZAtd5h
         O0uvpTep9Jxd5bzou/WoImGGFvSSWnbTBNbx6R6NDLzhab+HqLmc8HYwuGSWqDVWaisQ
         ZtAbvZ4QAXB3JI0WcolWJtgrFC2L/3kJas9vPuJE1C12I+4pCLMvikLpB4hpYIeGbAJ5
         hzl10kC43Xgj9ZFG1Vg2xquVBu326VFrmjDGDFhtDKcdEim5JTUa8/sPEFYuw/zY8v//
         4cs7cC1/SnGDw0xNilblN/gvqv56+2e1Pk/Kw6FHTDoOd09YbqzWSOsHaX6oVumqwYtR
         hbqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770167521; x=1770772321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gYan9t9ix9amGizYtC+O0jvQ3aoS4QZw/J14ZuX2GWs=;
        b=WTAQBMIxlY73pY6TRGhdaz5sZYt7Y4Bsf8ku91yULz/sLApSqkvzSYvZv3GNZj2rD6
         oTM4Nxdnk7iWG2apMgiOiVPZWZX3jRkEZTCc13X3M34Cu7+PKH+1PahW/gLeBJVwtUDY
         8o2+9IpQyXE6t51jWGht0cM/uhvJTIwYPD6maPUxTSNU6MmEnsd7SEdUph3pNrlurWl2
         9xMVpXEe2rgJleJ1EbILitjwhCh+lWgbUbpfvjg0fxevvVwmDq3mVfTwM6ybuoHjT/gr
         UJP7gHhZkInsTvsCsKbexe+63FxEP1fjL99mjtUfH671grlM+y3MYLvPCQBVsIqXWnLy
         8NyA==
X-Forwarded-Encrypted: i=1; AJvYcCVKwqCHQPWv74iUnqTU4dhUbnZ2pjAoJbKWkW62NQQ5b/SvGitwuEJJjUJpIQFnIyR1nHBcXw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzN10RmC7Qk49Lr17SKJCK4ZjyEGeZ0yCxEMHqCvxiUR4ipsG65
	1GpPDtZdFtFvk9k+WIGokkEhZUJJI3hZjKwnO2UdzUIIVG4Y67DRxiW8rLDjregebDIqar/zvEu
	dZbHNwUptlLWeoMZpKfEoVkXVNHyEQ5kzHjlgc7PhRhbdqEhQOPGq4j+/ww==
X-Gm-Gg: AZuq6aIVsa9+6VZXkKThgMFZLAuLw9QC+Cik2UOrhBGv2vjtB2uDAF6zQ38NvuT3zCW
	KAQuOi//stTccwLtBula2SZ1BYqLrMX7ZrF8K3ewF8KdG/bkdS77RdaO1UVDtYWON2Y4vH1pkNj
	Cfnofw9K9+4o9o0QodyevKSTKL6NW+zBSlpCDXzLdvLDAqScE/CGMY6aFLO0ELlZyq4KrIrLxxm
	2Idz0lj5H0h1B2mQM864okL4BTLjv1Q1pGcD4UxuBFCj+hsjvxshxxshcafJQ5LAtI21ijKgz1G
	y4s0WB0Iu0cXDna/+2gbCkB3ocZRgmDB9558xZEa0d2mGvpWT30zuyr99HWRw4TG8g8DJ/5o+C/
	4gvDHnl88Hqw3Okg6nG1+463OwlaX7JpZ35AoEXAhUf0JntbpBze+YYL7tvZQjlB+pWuNliPvXA
	zHePNZ1Ame8x0DI8pVkCaw/A0=
X-Received: by 2002:a05:620a:4047:b0:8c6:a85a:5204 with SMTP id af79cd13be357-8ca2fa75badmr210592885a.88.1770167521301;
        Tue, 03 Feb 2026 17:12:01 -0800 (PST)
X-Received: by 2002:a05:620a:4047:b0:8c6:a85a:5204 with SMTP id af79cd13be357-8ca2fa75badmr210588485a.88.1770167520743;
        Tue, 03 Feb 2026 17:12:00 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e38830f3fsm262105e87.99.2026.02.03.17.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 17:11:58 -0800 (PST)
Date: Wed, 4 Feb 2026 03:11:57 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
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
        iommu@lists.linux.dev,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Subject: Re: [PATCH 2/7] of: factor out of_map_id() code
Message-ID: <j6euiso3pcg7nvewscsfjkqyfl55ajxxybf2pib3622uontj2y@aqj4satyf7b7>
References: <20260126-kaanapali-iris-v1-0-e2646246bfc1@oss.qualcomm.com>
 <20260126-kaanapali-iris-v1-2-e2646246bfc1@oss.qualcomm.com>
 <47fbba15-6375-40fc-bd2c-8ebf2788837e@linaro.org>
 <7d1b5897-8f17-4213-b893-d99d96afef94@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d1b5897-8f17-4213-b893-d99d96afef94@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=afVsXBot c=1 sm=1 tr=0 ts=69829ce2 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=RddZqcDqejFcRhvv_uwA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: va5NALJ6ZuE_T4L_w6A0EDdTzIKT-LFM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDAwNiBTYWx0ZWRfXxlSZmjjb56Xu
 H6CPmkAHPGlsCmfKFC0siZ4xzFYnhAaaiycH+rLDdzS6laCPc2QcnrK7CZEALaZ32gQYgy18AdI
 DEllSbN22DF6xLp6CyOuyj2c11BEmLenbKVy4UqxNH3aRkVvbDQpY/eVm/J4Sqme10iS27hWKxo
 7hGxIAKP38qCZTL71mP9Y2M8E7YDgFODCZG/QmGvaS+imkBWx9x8CTn7UxcJ77wR7xspTIb4wiI
 riFxEHEKQc7YmqauM1dLaSsFlfk1njaiPg3MyUOrcIopxMCaWMLVx6YRrNefKShON3UZQFVrFtB
 H3xtyH9oERxpyFbtY0s1sn5FQRqzfagB81fFlZweailnlqfHGLkNC5/kgXHMlWbAiWgqKeH7eb/
 tXPD+jVZ49jePSU7CwT8tIs6OyKWb0svQ6SQrLeG3eije5bSwVM9mawK+cRLDXTkp9Iatenvg9H
 86USf2sqjCEr/sScEgQ==
X-Proofpoint-GUID: va5NALJ6ZuE_T4L_w6A0EDdTzIKT-LFM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_07,2026-02-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602040006

On Tue, Feb 03, 2026 at 03:43:58PM +0530, Vijayanand Jitta wrote:
> 
> 
> On 2/2/2026 8:22 PM, Bryan O'Donoghue wrote:
> > On 26/01/2026 12:25, Vikash Garodia wrote:
> >> From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
> > 
> > This commit message is confusing and inaccurate.
> > 
> > First up, you're not factoring _out_ of_map_id() - factor out of_map_id() means to remove of_map_id() - you are refactoring of_map_id().
> > 
> > Your patch title should be something like "refactor of_map_id() to prepare for mapping of multiple IDs to a single device"
> > 
> 
> Sure, will update the commit.
> 
> >> Linux interprets multiple mappings for the same input ID as a set of
> >> equivalent choices to pick one. There exists usecases where these set
> >> must be maintained in parallel, ex: on ARM, a dynamically created child
> >> device(s) is referencing multiple input id's in parent iommu-map.
> >>
> >> Factor out the code where multiple mappings needs to be maintained in
> >> parallel can be achieved through callback from this factored out code.
> > 
> > Which callback ? There is no ->function(pointer, here...); ?!
> > 
> > Just make some plain and straightforward statements about what you are doing and why. There's no need to resort to dissertation-speak.
> > 
> 
> The callback in introduced in patch 2 of this series. will update the commit descripition as suggested.

I think, the callback was NAKed already.


-- 
With best wishes
Dmitry
