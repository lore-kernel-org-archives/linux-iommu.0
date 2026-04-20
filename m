Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830CB38945C
	for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 08:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776674376; cv=none; b=vCS+LcbKKhQTs1nqVkwrZQPrs6eFoUMVkE4B6JERzrrEUTVWhV6muQiegrkdsEjCoMksrcu+yQXPgCn6vp/Gpzlx+7aLTmVNUOc/3X+JnOqTZhgLt/jTIS4DZNxstBwWGNxpm3rl/2MASQ6shJLZPn3XGPHjx9eloPiB/K2xJ10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776674376; c=relaxed/simple;
	bh=7wSzwoNZMzCJHuBdCIeuLiCtkB1WaZPcmwv+E1fV2nU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pnt0IZ1gZa37K6jgn+cpa3R5qG0E/KSejOiyTvekM9DBMcCjs7qZiGA4r5H7i8fbmyvSnR6jW+61haqHvGeZjx6l4aDDQEOlsn00DdkPB/swL2L1H5441cKuqhiCkZLPod0JaLhIK3ivr2QZitwz+SapueSrG2bEXr06pRPQZRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DIaQ0fm1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WHaymFWw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DIaQ0fm1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WHaymFWw"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K61rPs793289
	for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 08:39:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3gUC9FdPsZFnW0+2H5wUfCxQXwNXJYMQMdbbi9U6AaQ=; b=DIaQ0fm1s8IkX1SE
	6eKgQRpU+oqwvu9y3Jsht8GTzEW7JUoUBwVtOCaXLJ8ix9nyF99tOvrGUDm7QF8/
	7Fw+LJ8vzfc+S6qMx4M+QUgz0tHR2nrBqHPpzt/bwmNP47eeAFdYcfqKbmNJrcNJ
	yXm21uRKgCLxkoZjgfGhEInWuOgeOuHdAJJc0c6Dv479W2s9GDQ9Iy+7dIMcdEjZ
	LoEx0oCSete5DPuLfgK4Sv/YU1dsC+5N+X7PEVSDjsE3+Bv2u686Tk8PpBUf6nJL
	0VF+jRlfRRTQ3+HGwS4UbfpFkkUUsUTGclnBulk47/8EFW+GWJdPjiGNO3fwz3O1
	5Ui6fg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm2b752eq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 08:39:34 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82fa5ecd760so728532b3a.0
        for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 01:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776674373; x=1777279173; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3gUC9FdPsZFnW0+2H5wUfCxQXwNXJYMQMdbbi9U6AaQ=;
        b=WHaymFWwjtOQE6rqIClldqmLL0g3LFIpYjB/TnQUTcKtKqlYxSHMyukLIS0beiE17a
         HBC322VewOH9Tddfa6vcb91WWDs514KCJ6xrHs7g4J26/wCZmLMjnCRFcDN9KtT3u8yv
         i/19j9roSExMClQNQyJawPfg95hfuY3ameZmdp5NXNQisV3VoALMDj5cg6Rodm+kZxr0
         SbktT0zr6R6j5il4ia0SfG0P2UGYlG3/aernM4ztC1QYnCDiAWZElahP3Nglo/EZQCeT
         PWPveDLfW+EmdpEBXYLCJNhU7Fo1sBi4m/fo0c5JUTMugawcUtkWTYwwY/p7JHrKAqAE
         Jehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776674373; x=1777279173;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3gUC9FdPsZFnW0+2H5wUfCxQXwNXJYMQMdbbi9U6AaQ=;
        b=N56zi7bntN8336w6wX1M5GuO9/WPNe+XS4q6ue2CAPh3Fa1OH6Socl/5EWvmEiBV0X
         2Nu9qySUgO7ng5EKvZxxaxw/MPYMCAQknN+NfUBravloCXkJv6vv3s/u6LYgmt93ZY5M
         uyeskHjpATrpCqzBM8RAkaMSrh4wrAq90wMXzdOxAJWuzfoP5SgxEiAhXGAYWQAJgZUS
         PstH9D5sAwG1Fk764GsnaxeFS9hjhHoJ5HF7kfHP/plOGK3DbRmqcFC+FMzK5eqP3tM+
         x/gkajWHz6aJ1tue9n8kq52Ul0KacUX9suXpz1A5IvHGhSafR//J3i/WkWXBEawHgZUM
         Gpcw==
X-Forwarded-Encrypted: i=1; AFNElJ8Rh67dOO54nrENY6aE7YzJ4qy2xa8g+PCaoedTxUSClzhCM+P5KBgc9h6evM8xRSvVN7x9KA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx0FtThwsDI2us0R2pbYZLGDa/s9URrxBJk1aPbHlBnBHcmgz2g
	1SmhO4RfdVHc3dIv6+qZyFTtWxrRfvEVsrRKJzE150sgrblie707WV6cFkR0H/3/l8rsfZU7oxk
	uwn5YJJpof1G0qRAQhLE9X5HZfQppeLzkdJrKQcSlrGL4PT6n/Z2z0RqU4w==
X-Gm-Gg: AeBDies1pD0lixh4FwyHBSXoWng0NuTnJYHSwqziUQQmYR0JKYlu/bOlxnCJ3n1DfIv
	UOGof9YymN4v8wPItcJ8bo63j5KUb2CpLXale6etQBBb69TqB2fsmKEZyAvgFuBgtF9HD+rmELw
	lE7kVkZvI51rvzkarZCbenOT1vdgkXdDmYPoI0yP+zG8T0il6VxmyeBMbkBI7xlR2dmOGDtBqoP
	0XoEUSyAKGNWDbbF1dUVUvJA5tJnRUGPS4Jk6lQGSgeoMNafVOvo8indKiF/JHgkjKZntXeII4j
	PWTzEGjode46A8PCPzjwCnhxN/ONGhynBD2Of6LlT0x24UyYKpkA6bYUI9Y2rxji3WR49+NiPJk
	F2y6wSusOGOoE4+i14ir5C+9VET8Eq8NJlxwQE7ddfzkmw8JKRdgy5YieVyM=
X-Received: by 2002:a05:6a00:4308:b0:82f:3733:2f96 with SMTP id d2e1a72fcca58-82f8c82e853mr12493573b3a.8.1776674373553;
        Mon, 20 Apr 2026 01:39:33 -0700 (PDT)
X-Received: by 2002:a05:6a00:4308:b0:82f:3733:2f96 with SMTP id d2e1a72fcca58-82f8c82e853mr12493538b3a.8.1776674373070;
        Mon, 20 Apr 2026 01:39:33 -0700 (PDT)
Received: from [10.219.56.90] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9819e5sm10330642b3a.2.2026.04.20.01.39.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 01:39:32 -0700 (PDT)
Message-ID: <47f88890-2503-4d90-a31a-f9d065280e6c@oss.qualcomm.com>
Date: Mon, 20 Apr 2026 14:08:58 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Fix fastrpc compatible string in
 ACTLR client match table
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Dmitry Baryshkov <lumag@kernel.org>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, srinivas.kandagatla@oss.qualcomm.com
References: <20260408130825.3268733-1-bibek.patro@oss.qualcomm.com>
 <aeSly0N7IkXHYExB@QCOM-aGQu4IUr3Y>
Content-Language: en-US
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
In-Reply-To: <aeSly0N7IkXHYExB@QCOM-aGQu4IUr3Y>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KZridwYD c=1 sm=1 tr=0 ts=69e5e646 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Oj9lEc5NzW_9s0NItFIA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA4MiBTYWx0ZWRfX5ndl23evQ68+
 uPz7GpYfidHPgKLPCukKb+3VBWl0J/buPySrBRWImC34Jp0hHuCbQteLXwlentcbKJ0w94f70SL
 jsvWBryUO9sBXs5eSibgZXmzdvbyBgvd7NvM6Z/zxcR9CQJzgg3zNln48k43FJCV0lHQ5ZPj8LJ
 cajkHeLOy3HG3VwuonRLa+y+M1K9OWNCPcL7WK2gruupryBOZgpZGqyNC+2PUv6WqF51rB9n8Y7
 t5YSqNsUiHYUQ0Q5rALuycDaPcxwyMq3OQ5TAHeyd0Q9+5eykiGTSaBAvdffE6Zq7UznSLWq+aY
 wvU6DXHc9ny2RQr3QKCM3zxbJYoe7XkkcF2zIu5N7KC1GMRE51koa4EbHeCf8lvH6FmsSEwB1vc
 PSKOpH1U6gOYq3d6zGtaT9Ibs3kix5ZcaIMYozhWvt42pAH+Lm1Gt93rF8noKG0AS4UJJAdLILq
 te7cG7H2XLldCJsuwuw==
X-Proofpoint-GUID: ym7QOTsTUGnsfLVL2OOXoKtXLFQuP2Vc
X-Proofpoint-ORIG-GUID: ym7QOTsTUGnsfLVL2OOXoKtXLFQuP2Vc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 clxscore=1011 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200082



On 4/19/2026 3:22 PM, Shawn Guo wrote:
> On Wed, Apr 08, 2026 at 06:38:25PM +0530, bibek.patro@oss.qualcomm.com wrote:
>> From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> ...
>> Assisted-by: Anthropic:claude-4-6-sonnet
> 
> Nit - coding-assistants.rst suggests format:
> 
>    Assisted-by: AGENT_NAME:MODEL_VERSION
> 
> So I guess this might be better?
> 
>    Assisted-by: Claude:claude-4-6-sonnet
> 

Agreed. Thanks for pointing this out, Shawn.
I will update the Assisted-by tag to follow the recommendation in 
coding-assistants.rst.

Thanks & regards,
Bibek

> Shawn
> 
>> Fixes: 3e35c3e725de ("iommu/arm-smmu: Add ACTLR data and support for qcom_smmu_500")
>> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

