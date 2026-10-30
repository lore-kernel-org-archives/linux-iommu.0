Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793349343;
	b=SWNnAN15U3wUdzFOTm5JQCEY+W1f3tgIvojzU3cDRuJTKjM5fkFrFTNGpzOhALZXbE3W
	 EXsWP8kt/HnIC5XxiWYkrcVX4I+OdDU4imkDcVJhcPLmOkRkbd6nmIBnf1bDZZwOE3t64
	 K+kTitf9eSD1wpL908/P5KImlwcL5JQo/Wa8C0SwwXb6D7pu4ESG3KLOlMnhkWHgLxsT7
	 4udXyWkQUGI9q/QMNy5BHjeybKMFEEw8XBmLOMU+SeBXXLKPyYKx7a39S3uNqyOS/tzye
	 E6tLrMEJM2xBGHPg9QkTXgO9YTgOJn/0J84sQq0FwFI8XwHDNkc2PJOYYHDLwwAhijA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793349343;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=BJ0hT9AzGdYr5QX4etV6d2dPIaVRRzNFWlNbAyzQgZE=;
	b=u2X02f3cJaH0O0tNVdTQD45CptyKfW90keYJo0LNZhVIWb3neE5uo0zNYk+xYUHd5DRt
	 +iWsvzWb2kiSrPMhmGdVkZ+3Nw6SF7oauIJ1jhxojCSvn9YYtbyCn6Fr9AuDu5DKIl7Xk
	 q9kE2NjI4oT7SRteBhZRYDxCh3XkQa70SesBFwKg0ErZMZ9TT+sHAJbeG5JC9vXENQsTZ
	 iAdjn1imONCHUd7plFHUcvtGqx0ekLLTd7PIUYSrYvyXDzGQm+dxdSahtS6ItfwacZsZQ
	 wnxUpR5Yy5ekCw4z9FJiBgZOD/TzCxfBpMq7ULVRoNOZUwNsgtV3Bn0Trv5P5/AO+zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mLtXrypl;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="K/FQ3Eiv";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89E0606A331
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 08:35:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B89E0606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mLtXrypl;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=K/FQ3Eiv
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69U8FIKf2733206
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 08:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BJ0hT9AzGdYr5QX4etV6d2dPIaVRRzNFWlNbAyzQgZE=; b=mLtXryplGnXfHaLA
	tmlbdaxGFX25tKXAXCGF4UqGa8w5dlXHMM7JB4ie0etfTPDjxg6yk7/dfD/x1Dzm
	BKhqDdRokrMVx04iYqWr2pBijZXMvPLzB/e7m3zGdfrQehS7k29aZX/XEMCZ4QqX
	kE5SgeaXYu92h61JFBZkWJPOmegtnHNGTSWxJwP7R54oP/ZRP+j9xrFfBU70u5sX
	1MBbWKdbm8qgdJ+qI0hLI3GgpjUQWQTHg6sGgx5au5R2PVEVbeKZa+BuAYPkL1qb
	VVZN9+9vrNMWbiCDuzMMPULbbELRgyKVK6dfECks65MPcr25TokrC9f5V3WQ9At8
	gDAy1w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qj0u5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 08:35:41 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f1f1f2ecfso9930185a.3
        for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 01:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793349341; x=1793954141; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BJ0hT9AzGdYr5QX4etV6d2dPIaVRRzNFWlNbAyzQgZE=;
        b=K/FQ3EivtlHzwNNbbue6qO1+8qjYPG/jFsrDZATSHSuVqN8jbNV9OakkpgsImIJhAB
         wVCkzLG+uSUjL5VTFB5pTiTbSe+JiR/RTCVwM15tp8oMlkDwrZICSEoHT0q0aU5T7Kr7
         NNPB7G3YYyoMzWAzR6eFpep0jb4rGY3nLNCCshRLa6g15sevwPd5QmmZEVYBsAHnWpSd
         X9bh2miob2SZ0WiJIf4YWvr+9patg3lVEJ8w7xc6V+HN7hwMk6E0cbfmCAifBwKajlWS
         1NeSAJdgyhO+oqHWnYUekjdhm6UjyDQ6ZPPRPU8TvwZ4ra7N96ca+v5rsE0raB4o8Ypv
         WX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793349341; x=1793954141;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BJ0hT9AzGdYr5QX4etV6d2dPIaVRRzNFWlNbAyzQgZE=;
        b=fHo1UrdHNtMQ+uwpLBpGJwij07Tv/s3RtghaDa7UTUqI73oINhjl9b1+H0pYS8b0DV
         E1ZEiEb/uQ+DS5NowCRhmRsxkUFQF7nNB+3tfRkex/mpz0ye8h3eFPHZ6MdSZdKkPjns
         I3FQyVOPzr4SiZk1rKYMzLhEYjJLg3K1paqOmB71VxP1RXHRmmKyqB1qJjCulaCMwjqz
         KGtEt55TkMynoZWdqthqHtiff7IQUFA9ctyL+5OCn7Ro2QwCMG6hpjaU4KUe+vcaIY9k
         jPg6QAxtMxpiTsmseVArUGUmUNDJodrWocR9yu5xk7PylocupqCbA0BBl57+s6uo5seO
         Lzfg==
X-Forwarded-Encrypted: i=1; AKwUvByEs2gaEahMSmiK+zP8M+2w8aDq7bw9KzsjIU2dK+VVd1x2lWXrcjHIpSUcoICfCKpG6chU0w==@lists.linux.dev
X-Gm-Message-State: AFq9FYJJQgia2/14Kx2aLkMgeWgv6YqpWChxenkVkPaOfgsSk4gtEKbX
	CO+0cMmjPAmrK0vg8m4/OOQcgTp9QkiVhePnr/dR6BIpib3q7hJLq7t/uEgca+BFTjr36ZTZefu
	QFLiNWx7aHst9cf0Lx2PK6r04EagtQQi/0B9h10Fz618nUfBXp7pRxkoN9Q==
X-Gm-Gg: AYBFou2yBiBwPLCqBuKoEWiwkxFzOb9I1evpp6YFeJhSzomcdVuW9snGb4CXUmo/mjy
	XM1PxtLh2HMVGoeKliCP2TgIk9xMoI/8dXN+VohgJcoNroKtYRoKdhjlRJ+vMz40an4wRvStlj9
	v3KarbDe++N9HMJ+Eum9Siu1NVkDF5ICKpQ/Q6tmpO7Yms+ckaPMsQWxZo1q6TG9cLmRVgZf6QK
	hljU79B5KevCxDuYYmutgsDioil/WA1XZbI6T1SlcnddAdpQsyQ7m7/2J54vS0Pn8XvRM16d6tk
	tYcWK5ZdNymp/fLVMoXVJ2T2aOGSxQAGLzkaiq/TbuFZRuzpTXk6rtDMbp2+DviqQlFzxVM43c6
	VYMTTJgmRYbPhyFSBcZemBLBBMCYxHNApRhcVlihDfx7hNvpNtDinp0aFAViIEiKobRmLFxk=
X-Received: by 2002:a05:622b:4d:10b0:535:f9db:3b86 with SMTP id d75a77b69052e-542b687ae13mr24294181cf.3.1793349340705;
        Fri, 30 Oct 2026 01:35:40 -0700 (PDT)
X-Received: by 2002:a05:622b:4d:10b0:535:f9db:3b86 with SMTP id d75a77b69052e-542b687ae13mr24293851cf.3.1793349340133;
        Fri, 30 Oct 2026 01:35:40 -0700 (PDT)
Received: from [192.168.226.64] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabe4cf60sm39225666b.53.2026.10.30.01.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 01:35:39 -0700 (PDT)
Message-ID: <067b2a6f-9e16-4f8f-bec2-5ee2de10125e@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 09:35:37 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommu/qcom: Use identity domain for GPU and display
To: Rob Clark <robin.clark@oss.qualcomm.com>, iommu@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20261029212344.346069-1-robin.clark@oss.qualcomm.com>
 <20261029212344.346069-2-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261029212344.346069-2-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 2GgUewtuK1EVhRUvn2U5iE1aFAxvkXFS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAzNCBTYWx0ZWRfXyL6HEB01BeZ/
 iPatLs77v28UNRgdg6nZLkbajPd4UX0K+Gl3LJEIHuncu0rb8mGlrWp7MA9mnxkeSvToNjvks5o
 3vAqrDbnedz77dyaJz0WIyVAGIQgh5g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAzNCBTYWx0ZWRfX4NTpu+74Yh5Y
 gItkM1WOhIclzgBkOosnK+7Pwy/LMRnijJiO3bmI4FP3GtQpUK1MOvzBQXduhVIPwBIqJ3Sq6Fq
 UvKIPb4uHCzSn1sizv9TTMoOf7PAEyL9GOiOxielQ301VSuR6rnmnMVZMLsskDtAoFpyTZunky6
 A9C+wx++iRtNfEH0uob2ISU+f6shFC8HmGRcuCAyDMwnD7n4GDyxLOxVqEvXQKSzTj0IACVdWyv
 2/g0+GsUfCkoJqAdFKjZQKLs69kUMycv6zXkiC/uT+FsYo89U3y7GPeccXeuPbTtc5s4nKcdUlc
 2IUbhAC1Id8LidM1K3x/UlkcLi1SISXJm28bcOGfUgvhgWdnDCHnwmaDwJVc1a3YD4rwTjQ73Lo
 lBMYui0dIvzGB8h2gy4hQAgGhF5/oMMc1ZhwQl2a+yqJzcQ/NHZf3dB7aQcU1uAHKX7Hs9x4ZOK
 vHplxQraQFZIrh1lciA==
X-Proofpoint-ORIG-GUID: 2GgUewtuK1EVhRUvn2U5iE1aFAxvkXFS
X-Authority-Analysis: v=2.4 cv=TpVzFzXh c=1 sm=1 tr=0 ts=6ae456dd cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=nPYanoZRiyYWTCGofB4A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300034

On 10/29/26 10:23 PM, Rob Clark wrote:
> Similar to commit 0e764a01015d ("iommu/arm-smmu: Allow client devices to
> select direct mapping") for arm-smmu-qcom, match GPU and display compat
> strings to pick identity domain time.
> 
> The drm/msm driver attaches it's own domain, which it manages directly,
> so we don't want an iommu managed domain interfering.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---

fwiw I'm not sure we have any devices with this driver and mdp4
but anyway

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
