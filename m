Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C722735F5F0
	for <iommu@lists.linux.dev>; Sun, 26 Apr 2026 12:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777206274; cv=none; b=EI3MX8TiuxDyQl6vGiiKtWaP7bbaMA1mM7kE73TQoFYjgvKMy0rhXncKlAoLnQeHl1Dae/hBWzEnD75ftgE3O1rqa0dAm2ccYk1O42i7A2aaKF5Jn94QUBqXntiELtKx3daQ4tVbWnrKTADAGavfKdR81ZG7W67ECcEowxvEWMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777206274; c=relaxed/simple;
	bh=M8+16Tj1x6WZs0f2AbNxWFKqP3GGmOYuJQcsOgQ1kHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9rYIlZ4Cx5OiuWlWtZQ3CJk1Ve/W2WwPEdZnV5YJG9FY67ibBAIMUisM+lc15R7QWILIjw9u7pleRSj1lfwVTGsplaZmBqo7CRcYwcVxsK53pyBqUpjSosyhJAIqkOm2TKDfW/46tvjwxc42c4KdPshdJFrVM3kFCyieh+GW7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UBdSkHvT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=INcOAJg+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UBdSkHvT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="INcOAJg+"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63QAvXow233354
	for <iommu@lists.linux.dev>; Sun, 26 Apr 2026 12:24:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=xbAF95i14HhsfSGXuY/tMJx2
	G1OOoMWvPHHUcpNBgbM=; b=UBdSkHvT9cBi2Jo8+qaSxIm3tFuFv4IjHRt4Defp
	J1pcgUKQsRlyAI6J6Y71om7S8eqnhHQVTuFCkx7ptJ7QA27qU7S/VyQUp9UcWtnT
	Y2IgVf4CRsOsO2xc391JW3oeaeZ3NhFzKUZ3gYWSh8cI67CjqLoauKwTlSZzSf18
	2m0BOY5JtPHm6EupG3ecLOWTCkKtN3KB0P/tBimb3QzkU11Zsc3ALX+aPIo4cRcx
	nGQvgRP5s1+nh7TQd8F/p5FV+C+eWZm32aB7u1/uuve1j2Awgs0FBtC1Oh7DGAME
	Tr11On8xNfWYgPnHwc7pgX7y17VyheojbE6BvrM+zyD9QA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drnnf2sut-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 26 Apr 2026 12:24:30 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50ea1a7a5d0so162849331cf.3
        for <iommu@lists.linux.dev>; Sun, 26 Apr 2026 05:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777206270; x=1777811070; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xbAF95i14HhsfSGXuY/tMJx2G1OOoMWvPHHUcpNBgbM=;
        b=INcOAJg+pePhwDmGK1NZt6NXPUrLdr5g3242Meg0RtY7RYBSuizuaCmHb3LgH9qxh9
         lSkZf9sigqAC3z4bM13SPCWULW4Mr367x+DMVBpo6WRJtTHwfS0dPQn17vidiqLKndw/
         AZswl2erOcTXyaYf4n30PvF9Uon/ovfqInA3+GxQcxMFOASY06I1jy4lEs1uJ9ndExBO
         1lAsveT9HWL5kROFX0w1oQTVYd0/Qwn5heO2445E4qdSWraat9auA3U3vw74Lx2wuoZJ
         4YsiVyWar5L1IUHddeVaJzCP65ybwccXQiBpqsKXIxmOYZYSDnehC/CLKPNAlShsCcSk
         LnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777206270; x=1777811070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xbAF95i14HhsfSGXuY/tMJx2G1OOoMWvPHHUcpNBgbM=;
        b=eLFpzVQXYKf4ycWMDU6Dze00boPlEj9K+5Hoc0/asOle1+sT064tL/Zuc4u8VC9OTz
         JTIZezObT4haMVK1/+XtX86MdjiKXrZkJs6aTwjC+InLBEj27dFB+ZqTBiq7IOi7qLDM
         R+5b9ZjKA3eC1Y6sdmQ1SAzwYxAMjbo9HGaktxju29ENW/1DMljXFNqwtdkmTzZ6n3s8
         1SWHC3SsvkEQ6hefCSiSAup9O5uDQLfUe5W4VdhclwZyGNcW/xPnwmOAXLDJJE5pSN+l
         J+zAAyWvd/hIAEhM5ohS5/YtvPxLmPK7R4CEdunLW/L1TzOHtDJkn3pTqb2pCC/1JxR8
         HFbg==
X-Forwarded-Encrypted: i=1; AFNElJ/7oe/9HvQL4nZFQ4mHOHWtqUtuuu39JVrJc8bVnt9QEdAxDGV5YaJ3uC+CfK7IZGPxGrL1xQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx0hpZRu67/FBU1NQ79myp642jFVcn2kgnMjtRTAWNmJTJup3Xk
	oCIvoxXigaVLS6VseRNB2kgIhJ8ZTVQoXZSyFqeJXyXT6slWduNnY9Cg7LZR4NS/85zsPjdl+bQ
	l9VF20Qf+M4rxRQTOdqi7JhkzqNAu80OfhPzBtSPPwz9KWPU3mJRkT6/sBw==
X-Gm-Gg: AeBDietMYune89lJApNmBieEa2V1bPVlOsvfXzqxlKAtDpMLAU/j13Jsq/dyK4eCp1S
	uAHgXNVDizuY3/t/Tuk+z7Q+l72QfNrDfOEpMnUCzJ9hW0XMGfUOSun++MB9Ck05vx2pF0YJTdP
	MGRvkuVNccy2ZHag28qIxuSjYVn/ZPhB42s+tr/i/X00MtCEwk2m4qQd2k60V6Tcbl5iJFj3iOc
	hCW1jgz2a1mkOI8RJhs/XJZm5aMy+ukh7Lr4NAzIixDV7UN+WhYxZ0nLGq2lppKrzMLD9gijYyW
	2D2DI8UhQwye+o8lj5D8ISBOZvQ5vCL5VT0njEmVHYoEhKCAaJg1/MUIS7gCoDfXTBYdlOE0TM6
	bYteDRGWUQTlzE5XJkJPIYMydz9WLDmTwxtMAfW5CygPm68i9k7u6PHp4ntL8tAwqo1OABX9GI+
	eMXQq8pkuC4v4oTB3OetDVQ8kjcWXOyRSo08feSO3KvJJnVQ==
X-Received: by 2002:a05:622a:5a05:b0:50d:72e4:6df9 with SMTP id d75a77b69052e-50e36c7395emr549145291cf.50.1777206270016;
        Sun, 26 Apr 2026 05:24:30 -0700 (PDT)
X-Received: by 2002:a05:622a:5a05:b0:50d:72e4:6df9 with SMTP id d75a77b69052e-50e36c7395emr549144771cf.50.1777206269618;
        Sun, 26 Apr 2026 05:24:29 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4187e7a3fsm7396347e87.59.2026.04.26.05.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 05:24:28 -0700 (PDT)
Date: Sun, 26 Apr 2026 15:24:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Thierry Reding <thierry.reding@kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 12/13] media: iris: Add platform data for glymur
Message-ID: <x5kuf3n4z4jn6qxkqshzzwofitz2wsh5ayjlpz24cm5weo4nqg@smtwh755sc3z>
References: <20260423-glymur-v2-0-0296bccb9f4e@oss.qualcomm.com>
 <20260423-glymur-v2-12-0296bccb9f4e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423-glymur-v2-12-0296bccb9f4e@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: yGg1MKIQ0HA3ZgzmAakDCzJHQphPFENu
X-Authority-Analysis: v=2.4 cv=Y5rIdBeN c=1 sm=1 tr=0 ts=69ee03fe cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=54w5cVOzKzMHq45Zt3UA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: yGg1MKIQ0HA3ZgzmAakDCzJHQphPFENu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI2MDEzNCBTYWx0ZWRfX7Yl6b2mBNJVf
 nFD/LpDXYVHuNTigvayZzRu1J/b9BmUAtmSUbhc6dTQqZLqppd/y/q94SFFnGhFritgDzz2nzKP
 tP/yj1KfHwTe9k+TOQV19eVzGOJigrGDdO1EoWHhI9+M0YV8z5Ji1XP9CyaMgwzLHv+4kkdR5bM
 q/9GQzpo0Pcwk0R6UD/rHM3ShHSNIFRjRvp3jPe2MJpiHU3DUiJL90rABdNZ1vIuw5GMn1xj/TF
 zr2NxIvVmO1UZdXrrMW+E42M0Gj5ohJzNYEs53GAqa51KFvtxV+8XmRbD9PwahT8Pn0r2ooM9uI
 9Pmlb2aBgheFyxmVy7NS4+Pr0zUOjqMwarffC99FSaZvpx9T4vtQHBqjYeub2wAVtg8mEURrJoJ
 2igsNadXgoYSAwz5iYQb3PGLTPiukJUGRxPP1iiPVEaNeQmQsVC56+Tu6bHCfCFv1z5fF+nXgin
 ZcDceZyvW5dpT93F+hw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-26_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604260134

On Thu, Apr 23, 2026 at 06:59:41PM +0530, Vishnu Reddy wrote:
> Add glymur platform data by reusing most of the SM8550 definitions.
> Move configuration that differs in a per-SoC platform specific data.

As a continuation to the previous patch. Compare your commit message to:

On the Glymur platform Iris core shares most of the properties with the
Iris core on the SM8550 platform. The major differences come from Glymur
using two cores, wile SM8550 had only one codec core inside Iris.  Add
glymur-specific platform data, reusing SM8550 definitions where it makes
sense.

Even for such small change it is much easier to first describe why you
are going to perform your changes in a certain way.

> 
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>

-- 
With best wishes
Dmitry
