Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F371862A
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 16:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782232905; cv=none; b=pSr1iHHqSv2bIuquVrf5jTExBg5AlGSkCNl9TQe/v+4ghwGj5TbreKWivfQu7XTFCElp1xmZHIzTLpa/4UiLk1TbH4lDkZKlZmNKWq/pVCb5EYVjLiJE1BG2TV7XgbFBATL3qlW7qUHvHXTeBp0bj7+CLnBD3iya+U5iL6gcLDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782232905; c=relaxed/simple;
	bh=pbaXcc7KcC3MfBWTnd+mtc92az3cZ/ItzDNlzYanHDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D0vfGwsuM3MnCTFMgGrrzyqakLdpUhmBZypq/2bZny2lM4Agygsmib83qzWE/JbNLsuGRaTWEI5JNquGu+PYumUvP9OoIijmdL5+GB0YkInKmadlvwdM4lZHiQmY3eCO+EPcL2AG0qOO6MEvzp3ImkrLuhWPpoG/KeukhHRLkE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ABitfkkZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jqgs0AxO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ABitfkkZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jqgs0AxO"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBXbW11155214
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 16:41:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ey8VJPwrz6nsFUg0zcYFZgipjxqAi5SgWS8aYTsmB70=; b=ABitfkkZzRaL271H
	GuBYdjpHGP+N4tSr4kA1TET3ahrGfC8pLGfCYYKxtrd7og3WU36WSTPXZEtb+r++
	Gow7Osgf3rCVFrUhHZ/OS1FMSeulDiBzhmNMgzK0gpma3gGYuy0NWwUyZ4AM1W0N
	3JBElH0sw0/xQZaEcCJil10rNlfHyfJkm7JRNGqlnhlonoQJlucnqliBNjrEzTWg
	mnxkVS6vkIooCBEBizAZU4miw8ekbEJ7F9UiQlJdXaPdrgLODlZJFOtAXosTsO7g
	cJnnJYLc+v6SlSuvL4kP2vPcswGk5pdxHLh+o5XaQWrUl3UH6TLD0HtkQuvXLEHA
	lzuh0g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyr28sn44-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 16:41:43 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5176891d0a9so14164921cf.0
        for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 09:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782232902; x=1782837702; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ey8VJPwrz6nsFUg0zcYFZgipjxqAi5SgWS8aYTsmB70=;
        b=jqgs0AxOXOGe+yz3W/K40lstd7kemPUZi/HxtUyv4c9AvoZzjQxHDSOfYca7C+3l3V
         swkknhEkpeyLKR5QBJKwAY45lOhIMWnyK0B0BNxDRpjcAEQrEMmXXD3F3o/brYBGRcZE
         YZ4iBQVGZdt5oMdhc0S6qGGgA/y0VGcR6fz4wm5Q24u7pkZecUkjDGMqvpur0YoVV9/L
         HH/WgXrdcHE4PnpCW0B+98rBya+3iuKbk7/HmBZxtsPiI7nq7TtE9a6v9bSs9BPcaoa0
         AN5iphjlb9/S7rNGopgH6p8Vii1L2uWsYRc+7c4vCUS6i/nBQSFMPLoztM3isgsDoCwn
         p0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782232902; x=1782837702;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ey8VJPwrz6nsFUg0zcYFZgipjxqAi5SgWS8aYTsmB70=;
        b=r/gsnRy9lfL+/K3vi1YzxmiM6LBsch3f+je2dO1Cf8D0f/mTIpgCVEKLPISX0JO/Ho
         NJ6tvrcAkk/VYu8OVT5pD42ZuIFPXrVKzSeakuS1f29yMo/qkHQQu6F0iyeEGV75rh+5
         6SirAu1KbbgK5TEVCNpN3XnP2iRuZDOyxvuxq2AwK5SUr8dGIqJSp4sQMjSMJBuzn6Q5
         6+EebKNHrxGQDaQIcJ31lmuEuvCuKLy5WcrPImwh5NvVse0I60Bqr+tiscZA8TIXKzYV
         LyMTVmhMwkPTcVJkqDrUVoMTz8FRnJtSnn+PE0Ebed5gW/Hu0Rgnox5ZnH7LuAxBhGWv
         qHZQ==
X-Forwarded-Encrypted: i=1; AFNElJ+baJK0cdqESPJaEuU0C9ionv7+OgSO/YarKuMD7hyZ74hLC4hos5Hg2Y5OGwk7y5Lu3K6yIg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwaiTMzHgSALBeQOwZYf+BYBEQ/eaMr82zOZoO4gkaI2EYMRqMV
	WAZ20RnMJIODIJjhd4/14eNQogQ2thx/f5bnld9KESE37J1qMaUNuGpzC/zZMI83LxR4fqitItz
	0eeBjUCziVxhUIKD7x+nQtprv/wSdvvjF0l5F37kORuotTSasy0XJoqmVzg==
X-Gm-Gg: AfdE7clqB0t4tYYWDToqMV07GXHj8cP1rWzF8rh/Bff9A/FWmzh5NdWDAH281PX9w/T
	lk8ra8kyyzqP9Fjcnqx85GjKi4tdclxzanvd4HdRe7CeW4hkFuH3Pgm4Ij2Z5zrD45Z1axa4w2n
	6Qi2caPO21SP5khxULrMzYq4X3T3flB12axv9kEQve2lzGmoUU+Pb2rb4eT7gFBSTQlng3sgagW
	rMUq0f9E80ZE2l+g6Tg3m9FWXM/geVmGbjz66bLZkV9LCF0utvAjkulc9gi+UWBAxMjsD3i+vR7
	f82I5Na94Ta3UEHp/1knC6G0OfbFq2zEPAoSlu8UYF0DskIMZTfdlxCAOlZ2IcqBO9QgxBOWDb+
	Gh6sIXW2ZHQKRVvG/ubGCTx3Z/GwBot7J20w=
X-Received: by 2002:a05:622a:1652:b0:509:2a92:8088 with SMTP id d75a77b69052e-51a4f42cb19mr58800581cf.1.1782232902342;
        Tue, 23 Jun 2026 09:41:42 -0700 (PDT)
X-Received: by 2002:a05:622a:1652:b0:509:2a92:8088 with SMTP id d75a77b69052e-51a4f42cb19mr58800311cf.1.1782232901978;
        Tue, 23 Jun 2026 09:41:41 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697dba9c118sm1295449a12.5.2026.06.23.09.41.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 09:41:41 -0700 (PDT)
Message-ID: <969f78f6-dc10-45d6-8cdc-f4f65fee68aa@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 18:41:38 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] iommu/qcom: Document why sec_ptbl allocated flag
 needs no locking
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260623122034.1166295-1-mukesh.ojha@oss.qualcomm.com>
 <20260623122034.1166295-9-mukesh.ojha@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260623122034.1166295-9-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEzNyBTYWx0ZWRfXxdOKLiszsDiV
 5Uve329NPfxNP4Ak6BFflM4uB8Ygm4lVSuBoALIdZeqXCcfs6J14ix7jbqmX7YflfpH/jszppvN
 N6KjNURUyk/O0ImjxhhYYlm+pIP1vgM=
X-Authority-Analysis: v=2.4 cv=b4KCJNGx c=1 sm=1 tr=0 ts=6a3ab747 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=p1Q4quDVZRqoN1qXw5YA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 9lvD_0RtjmqJiudxSBKE2HlPhdV6yKBm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEzNyBTYWx0ZWRfX1ZA63hisX9Gh
 nwQkHRUaWv6nrXIfRoKQLJVCog/H5zPEiIyU3Up1+7DHGPsMqTSUSb39xUh5/qlDmFPpnjid0MO
 yT0aa8YJ57t0f6ToLgxD7eYHZzmT7Ic9pa/lptis1gDWPgqpQyA8dChyvfiHUcK/+RfLU9P+oUN
 PE4EIOhYjLuDADzHkyngYPZ0QoaEPOsvkESceTscJq2A4bby95hsi5AyNuxM3hZw0c8tdixcsXo
 QoYc7jfb5UrEXFEOqBt8B+rZgGYFvAIdDCkjA0DdY5o00pmC6IWdS9UCYrwn6XNZRVQ8W5jGc1b
 uANt4rInCld1XK/UIFBxB4Bh6MQXvyupYIE93mMWYzQC29TCYWgoloUPmlLIKGlZCSbJpuJGgse
 EPIH7SeTJgIbooDHrYo9J8ZtwUv8N7UfOkHGcWcO2CREAfBLeeRPyZCm793wHcqltkk8uJ1K04y
 kko8xGvGgduoRjwbntw==
X-Proofpoint-ORIG-GUID: 9lvD_0RtjmqJiudxSBKE2HlPhdV6yKBm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230137

On 6/23/26 2:20 PM, Mukesh Ojha wrote:
> qcom_iommu_sec_ptbl_init() uses a function-static bool to track whether
> the secure page table has been initialized, with no locking around it.
> 
> Only one IOMMU device per SoC has secure context banks (the others have
> only non-secure context banks), and platform devices probe serially since
> the driver does not set PROBE_PREFER_ASYNCHRONOUS. Concurrent calls to

This may be influenced by cmdline, so I'd rather not take it for granted

although I'm not sure how this plays out with the context bank device
always being a child of the IOMMU

Konrad
