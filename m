Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9098F248F73
	for <iommu@lists.linux.dev>; Sun,  1 Mar 2026 08:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772354364; cv=none; b=VuF+7+338iWdXMHjkL7k/fmK9v71V7oCIdarN6xdlgCsBrZJpa+LrFtp0OU00SbrB/zLNnKkNbpivZVNfC57LX+Y8LspwGFvcj6YAoSVssoTXY7IqSmwsfrIOLv0MfwfU2f2FMm87ektK3Ne+m2qLnUBZmi71V0svKgnAAtTaV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772354364; c=relaxed/simple;
	bh=zfip4jl9zzk5AFPmAvKI5wH/XCqtql5B54pDXZTsokY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IC159db7MdRZG8PO9Q5IqNzY18klaGTk2b1hY4Kein3C5ShO+FyJMhdw//gStLUf4u+QuoVjiM2sxGZ2qD7peZO7nrTKEZjtURcFhfDgVMK4TVJ9vy1pwg/e7cVuxUjlJs64KnGwusVmXUVJpnOuuRLayFBxpL7JE50mc3+Mna8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KqY0dMgH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gj95xmBq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KqY0dMgH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gj95xmBq"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6217vngU1230077
	for <iommu@lists.linux.dev>; Sun, 1 Mar 2026 08:39:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6crGyc6/DZYlZsj2+/nyb5AdRS9qSP3ztuPyv5sagm8=; b=KqY0dMgH/Bn3mkm+
	PBpauWnaM2ESLO7phJq1gcq/xodtKqCs+1wxywNFtN9vWkwGNIWT8Vb/QHtBStTK
	Ruu27zBLrJeKtYQtt3Ad+9LlRznTNTnt/lkXiacAuzKUVDxpaLmoo8Vsczyh2EuS
	wKJZiXdhRc4WCtvKHGeDPT11jM/c1FvwSiuUQvfZLV69PiFq6U/tMYX1uaXc/+Tt
	mGPBBVCZ9X6kdtlXZQLqGhujccY11Ottb1eX3jhRHH59fsgYRVbbQXNDZqo+Ne/1
	EMA5Kril+API5KtgGR2nP7NLWo76HSubd1Y2ejMRzIhq4T2M+r8SG0XgM3TareTm
	MsJ/8A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ckshd2f7n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 01 Mar 2026 08:39:22 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-bce224720d8so1974934a12.1
        for <iommu@lists.linux.dev>; Sun, 01 Mar 2026 00:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772354362; x=1772959162; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6crGyc6/DZYlZsj2+/nyb5AdRS9qSP3ztuPyv5sagm8=;
        b=Gj95xmBq9hqOQIgIwEofGMJTcPtEbLoHyh9/ouYcM9SBzverqEoKx/xa1Q8l128O7Y
         tzhslCb6wVHPpcd2eUEK/4Ry1FMqCSHoMUqcOtcNz8m7Rtfgv2SvOaIqkxjIGVG0vnGQ
         iQvujwsHYGoQA8xEEg8Cvnel6SVl1HM4xiOPG2VDi3AG5I9GDfiy+EKyII4Qu2Ttv5Vl
         wPLrKVDDYm7EOq98YGs+6b8kX34NsLkTRZ9HxUJPc2eDr2q3/PfZzYSIN1n91D+5NuIL
         sxmsnXLo7Ai6Iag+HFzHQz+4/mjLGdc/1XqcmVGQcgd6SB96lCWSWGk3TSplX8f8Ny8m
         eaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772354362; x=1772959162;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6crGyc6/DZYlZsj2+/nyb5AdRS9qSP3ztuPyv5sagm8=;
        b=AbbFjTkh86UNEPL9fVvqzDj4iJskslVCPglgocnveelXzfEs8H1M8SIEYbUybuTMNe
         osJtegmY9g8Co7iwy4+aolAIUYx+FOakQ7vSgS+nrbo/agWnX+HPOs//Fp04wlokfbVq
         sdowPuI/X3HK/GYH8X7TwW8OaRUbZ/UsD7SPocGZ4yNLKRCbeqk1G8nBglOW3rEKbtp/
         GCHOkz30f5L1isUuFb6eAIRBRSM7xbF/qXnH5rRI26RsVmEU16P87H4ZujTZQU4kOlZV
         Ou3TsAgxpzVAtrqx8Z9ZLX5b6XMEcmAUEhd+sLqfZFRfoIx+eOqJuNV2tGwpZGqOcNO6
         Bd+A==
X-Gm-Message-State: AOJu0Yw//IB5zGGv3fmVt9N8RreZIcBUv7iOJdAjEcDiIFYguZQ3Jq0l
	fpXnQArv42jU6p8/Ojp2BLS9FcERoFLS+HO2FG1gd8WfrbOy56HNz2MZmWoR55o0S08rXOCq2zi
	4EpzrYC2nnLmutHjR1Umcr08UMifP059kZHPXRQbRISSa7yr3nOxM0n7Mng==
X-Gm-Gg: ATEYQzzPHV9btTUtHE/z6yy9XPu1Siv3ijZIOiVxBC+PP6vP6lX0vmvEgi1RqgwosId
	x34QJQlRc0JTQLZK4Uqwj73wIK4R9ISn333uGf+6EmQt7XRA9UC+4ebSdU/cLDhd3rZ1X63iGwm
	GlsT2R3YyqeO2uwQeFWphmT8fO9uoFlqwMvztxtUVB0GCMzYxzYSugM4X05aH6y/TnCVrQCKIb3
	69Q09B5mhJSJF+Hxb1S73N/v5cgTGMZoNmW8iZO0cYorJyX5ThbYN+Dq+WnSSaPGawtrUFjPAg5
	uzFf8eS8lgnnsfWn4ObSemwNknlZtw3J/YurG5up0YBbltiyfejimmFtORCjYGRViYTW7754EzK
	2XHkeYci5lj24x534oUOtqV+goBQ5M/QxVg85aDeeqF2WS4EL4UCfa/ge9pw=
X-Received: by 2002:a05:6a00:2e93:b0:81f:33a6:e9cd with SMTP id d2e1a72fcca58-8274da29064mr9831404b3a.57.1772354361914;
        Sun, 01 Mar 2026 00:39:21 -0800 (PST)
X-Received: by 2002:a05:6a00:2e93:b0:81f:33a6:e9cd with SMTP id d2e1a72fcca58-8274da29064mr9831380b3a.57.1772354361399;
        Sun, 01 Mar 2026 00:39:21 -0800 (PST)
Received: from [192.168.1.10] ([205.254.168.237])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a05e831sm10064950b3a.58.2026.03.01.00.39.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2026 00:39:21 -0800 (PST)
Message-ID: <3f7f28c5-ff0e-49e2-914f-55662d815a1b@oss.qualcomm.com>
Date: Sun, 1 Mar 2026 14:09:11 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND,v8 0/3] of: parsing of multi #{iommu,msi}-cells in maps
To: Bryan O'Donoghue <bod@kernel.org>, robin.murphy@arm.com, will@kernel.org,
        joro@8bytes.org, robh@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        konrad.dybcio@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com,
        conor+dt@kernel.org, krzk+dt@kernel.org,
        prakash.gupta@oss.qualcomm.com, vikash.garodia@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <aba8eaf1-eabd-4e27-9c2f-2cc8e4338a16@kernel.org>
Content-Language: en-US
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <aba8eaf1-eabd-4e27-9c2f-2cc8e4338a16@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAxMDA3NiBTYWx0ZWRfX0lUkN5F0ezTt
 fN1QjgGBAPk0xCfcHsTKfcGDch7xfLXb8RLPHDQXPylENvMTnavke8+3glp6aH+ZmlDtfKcFg0z
 kNFPodArbMwjrfqJLgzpMeKyTJEyqFDIIjRDDlZ30IUz4nwt5OF8wn0ogN7Cv5PFMnyDX0cxHSh
 Dp4cER7tFnpgxnc65Q74O9mw+NpI2Sn4+YC458tQWigbRKHHDVxMXVVtY3TCw3dUoxCVaCM25LR
 tbN3PQnIDPTgJyR2/RK/BzR/BERGRttY7RqEVyM1cDu78DTuA1U9YUsoThc07gE5SJB+60XWOUl
 PeiAx1/spvf7cbu/+vNhBk9jz/nS2iB9LJQb+EVoac9Mw2QTpRYXwpd2NdvuOmmD4k4wLhYxnDn
 wjNsOuhJvhWtzszQ0XRu0J0b38vTDRs9I5RDAivnh46hxLXLRrXdsPZmWn7rWsHcsMjSCx+AL/4
 DFI58L400jiV/nioBFg==
X-Proofpoint-ORIG-GUID: gznQZM1fplzcJRC8c7X7JmDxqUYCK2gB
X-Proofpoint-GUID: gznQZM1fplzcJRC8c7X7JmDxqUYCK2gB
X-Authority-Analysis: v=2.4 cv=COYnnBrD c=1 sm=1 tr=0 ts=69a3fb3a cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=56fQ7I5yWrzCfZD5swi9QQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8 a=tA7aZXjiAAAA:8
 a=zd2uoN0lAAAA:8 a=SwFUUU41-IDwLpOynWkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=kIIFJ0VLUOy1gFZzwZHL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-01_01,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 adultscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603010076



On 2/28/2026 3:59 AM, Bryan O'Donoghue wrote:
> 
> You're missing a significant number of maintainers.
> 
> https://lore.kernel.org/all/20260226074245.3098486-1-vijayanand.jitta@oss.qualcomm.com/
> 
> From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
> To: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
>     robh@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
>     konrad.dybcio@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com,
>     bod@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
>     prakash.gupta@oss.qualcomm.com, vikash.garodia@oss.qualcomm.com
> Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
>     devicetree@vger.kernel.org,
>     Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
> Subject: [RESEND,v8 0/3] of: parsing of multi #{iommu,msi}-cells in maps
> Date: Thu, 26 Feb 2026 13:12:42 +0530    [thread overview]
> Message-ID: <20260226074245.3098486-1-vijayanand.jitta@oss.qualcomm.com> (raw)
> 
> There's no point in resending since you aren't mailing the right list of people right now
> 
> deckard@sagittarius-a:~/Development/worktree/reviews/linux-next-reviews (linux-next-reviews) $ scripts/get_maintainer.pl 0001-of-Add-convenience-wrappers-for-of_map_id.patch
> Nipun Gupta <nipun.gupta@amd.com> (maintainer:AMD CDX BUS DRIVER)
> Nikhil Agarwal <nikhil.agarwal@amd.com> (maintainer:AMD CDX BUS DRIVER)
> 
> <snip>
> 
> Please run scripts/get_maintainer.pl on each of your patches and include the right set.
> 
> ---
> bod

Thanks for pointing this out.

I have sent v9 including all the relevant maintainers.

Thanks,
Vijay

