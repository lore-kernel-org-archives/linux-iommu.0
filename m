Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793011062;
	b=r5syXs08Ba7OdSp2EJ8UmsUTX0CwrDAIxt5clXiXxtviVauLdscNq8avNl2avjFp67DT
	 G+OyPZ963XDLuo3I1ErHDLqtiqxsSwRhUGOEUut35J4IrmKFLTqWMxS6rE4q/OuoB5+Pm
	 FoNDGGpbO2rgchXRU3sXS7c4FRhwdZczHDjuwwcLvuIWc/ldPKMFCWQ8CvuPS0+tNc4PA
	 rOTB6wS4fUUH0G6GJZ+ACfw3ftERpbh1flMWoEuPteDfi+9jT/OqYO7FnTIuG2WgS5sqV
	 3kioF8fuwizd9C9F3aD0AzXYrphHcaT+3zJ9pEorI4f+n9OW7pUkzhI6DVUU5+D4CJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793011062;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Gqjg8xNmhBbt2RfYvkv54a120ybeK1H1UlJE53Iy9OE=;
	b=4habHdU0kVTjWX6a1nYMwhNeLnPtGaWf0nWcVQiQiYHGtPI56IF1A4QOIrfMm5repKCw
	 5ozGO8xSOJyjTpbu8I0T70+KscBGt6xJSiQMAnL5H+p6xrut6S9JhgIIebRhLCHN2SkHV
	 gSqw4or9zfuaNMAO5qvgOqqL2lDvpVDMWDW3fTPCS2OcKwluTAb4mYQbsiHHUnWxjw6oT
	 YMZvvozP9lpJ1fAR6LbwB0OB3XNXKJdSKCZOgZWr9DycF3hYes4fQIPfQVNS/pO7HpXSj
	 4kMsWVK6El6Ohclt/mMZVCdrppn3Zzx7P8XTe8LjeiLO7jFIvqtU2FJRDnLlWDFaJJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TpZsGSX6;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iH7PmABt;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22187606A31E
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 10:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22187606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TpZsGSX6;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iH7PmABt
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QAPafr4067973
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 10:37:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Gqjg8xNmhBbt2RfYvkv54a120ybeK1H1UlJE53Iy9OE=; b=TpZsGSX6x4fCHbKw
	U8ef/568RxKDz0hovaxFvn9IInCc6pKY8/Sn3J7Cbt6yKqZr5KGpuZkWs9oe6j7k
	brO5+mOteKXKVH5HZzNaziob0mdnSna+I/c9Up4HcMbd6mprqlDkbSmUutdRWsP+
	eoa+c5k8kh9tObqrRBGOrjRsw4WJGbLPV4MsPhrjHrhfaDss//ip8gDbQn7ZD72+
	l+QQlPfcVAdnMvjQgAfLhDg7A6URh6DAhD0A+pYAdoljS0JxoEy4D2Wu7xtHHsL+
	cRCQRxsvNGOHaC8b82Ix7/gO/UBHgrG7XrIzmwzmfJPdUoxP39bSBmvh/XnrtdJ4
	32Agig==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj53q01e3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 10:37:41 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-90c4d46037eso8545016d6.1
        for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 03:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793011060; x=1793615860; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gqjg8xNmhBbt2RfYvkv54a120ybeK1H1UlJE53Iy9OE=;
        b=iH7PmABtvXI3KPWQ7Yky4ylMPR9mvgqGV5Acikoorz32FYsrFrS2XP14cPLxJQxrJP
         El73ww/QeXnoRbGfE8jp/RUNzRDQ9UiltHmPDfCcco3mrj53cf+6TNNwiqseCpRHzV85
         81aMPDbfCuOCCqTro5IBXJ38U9sLsb7YsdhLGgQjNLLUUGk1RnhphtAcn7EmklFLcQyd
         GjWyEyuFgbp5T6Alw2MZIfR3xezMlcnuIGkGI3BFtKEc6DdCD7gPC/+uw0fbp1/fesb2
         kIfa6TVfA/7MCk4pohRwKVnFNo6AEuz07/nDgLKhURcsWPcq2oofBf5oPnB4HqFFkoWf
         qtuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793011060; x=1793615860;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gqjg8xNmhBbt2RfYvkv54a120ybeK1H1UlJE53Iy9OE=;
        b=gW0Rn/yoembp+0AGYFAJcT9iu2ulPvc4BpwaSoT6lC/3KzOJi5NYRt6FsxqnkHR7NG
         7vjfDe+rItEHYCafSx2u1bML8kXRTPOrUTFzFUy4orzyNI4Yis1tY/4T7Wg/RpgVeEIP
         xqtvVBIr3tdiA8DAFcYTWr2zx8aXTte2xgU8s6p57uZej6I8DY5rzI7AGUXl49rY3w8y
         OJ3bvWh6VhyT6JS6owGX7jJkKL6lhOfNpsa5ftB5A9gl0kyog5JRTc40Dauk6OShnFip
         52GJtYN+BkGSWBfYOXiUiwec8/zX9UyNVsqZC2PqWwlOjKvGzB49TwZYf7UtxXb6CUm3
         7kuw==
X-Forwarded-Encrypted: i=1; AKwUvBxGGEv4LRkIy5p6Rc48R2oefY4fBERAGthtteVqQO5erjVWrLkqe1NOmanOMcXM1iM+JbUSFw==@lists.linux.dev
X-Gm-Message-State: AFq9FYIGpt310ivYvCeuHJDpGP1hjWIo8kB2cq4JJvJ5xIPjKYC8ZQSm
	OpyUFxrsmFoNDrCUVLb21yczncv7HcsrZ5mPjsiEfxV99L6B6Rhiocs0lmE5YTJ8B9U65lv5MDH
	xskqo6/HDwtaunt+zn+EBW/R6iv9ntYOXn1pprBrfB6tXoTygiwBMVp1KYg==
X-Gm-Gg: AYBFou2xYA6P0wAxQJq6496ehv9f/eFXG7HS+0Kw/icqRyNFMdNHFI7ZV+BXYviYuKA
	AuCaZHjcODIjTeqDz6VCMZyFGCAj0h93wBlQZ4+Ng9+nvi6rutJicmNMqfKNRWuX7kBD9kfEbsn
	xbNO8iykkoIUNJhUmJsa6d8jZpPN+IcfVJubwL97B+K+WQWrSecWzTZt6RuNgvjQxSGE9cqcSxn
	sQg9YFpWDim2goJ7OsUysLWsNYFVyHhYfZ85fwozL3ThK60ZoTW/Q6hGu06ZbjoPzc1j938tAdm
	XdtQafGDBmQpkwBsHxkT8GRkpylqscoLx3IhmXcuTFtki1LCkRS30UGS2rE+4SL0VJ+6z/HwdtR
	Ln3n6wE1LKawUKgl6z80flg==
X-Received: by 2002:a05:620a:4e84:b0:93a:ec4:e5f2 with SMTP id af79cd13be357-940ef9710femr1130935985a.6.1793011060061;
        Mon, 26 Oct 2026 03:37:40 -0700 (PDT)
X-Received: by 2002:a05:620a:4e84:b0:93a:ec4:e5f2 with SMTP id af79cd13be357-940ef9710femr1130929785a.6.1793011059540;
        Mon, 26 Oct 2026 03:37:39 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4459924bdsm3389733a12.37.2026.10.26.03.37.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 03:37:38 -0700 (PDT)
Message-ID: <7b95f254-ccb0-4ce3-9b35-c605cacdf74f@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:37:34 +0100
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
Subject: Re: [PATCH RFC 03/13] drm/msm: look for lpac from dts
To: Anna Maniscalco <anna.maniscalco2000@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
 <20260705-descriptive-name-lpac-upstream-v1-3-01d50c3e0c99@gmail.com>
 <rwohvfbsw2brpxrfg26egu5arwe6g7n2etelo33eegmu5cz65k@3syofuxzsjrc>
 <dc5aef2e-600e-4e97-b76b-dcc8bd72c709@gmail.com>
 <m4vwrqt6yyaawpvkyrqfzs3kbipbhygmtrhphuthl2gmjvkgyt@u2d3dnvl2phy>
 <54cb37bb-aaa5-4c5d-a563-acca4822dd35@oss.qualcomm.com>
 <t5gu6ciwmxdb2jghc44gtixdsbedkgy4yzke5sgawjrr2h362u@ahvhh3yfe6lx>
 <wtun2cfukyzxlsfiz2izsejd33k4jpapwqa3uqih5drcsrkff5@e6llkke5dayw>
 <1f6db59c-b7a9-41a1-8022-6713365fa09e@gmail.com>
 <fcb86c33-1893-47bb-80eb-20acd65f3805@oss.qualcomm.com>
 <o2zmplbtmoueumw3iqejfsdmucp5f66woa5hmw3vodbe66reab@syn2ashugzyg>
 <7d35f41a-c72b-4743-b8a4-0ba715be6756@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <7d35f41a-c72b-4743-b8a4-0ba715be6756@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0MiBTYWx0ZWRfX15NOqE3H+uBH
 sVr88+QHdir/EbAMdhNftbdMszKkXIPIZOJOCytZHvgNwuHA1y5L8bQNDyOkxKG5ustTorhUmaE
 0OnC3srnQ5VVXmQU62Q93ipeEQYbk2g=
X-Proofpoint-ORIG-GUID: r7_E3dzkEB2cdYo2uOJgqOi-DckdYZma
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0MiBTYWx0ZWRfX/j3GcIDbaYx3
 l/jTVHgAIhwpJOTPhoQSf4lvqs6vHHc1BMqJeRuzLFSZz//s1YsYdQOvV4LJXjQuKYbJHmM0Xke
 9h9K5Ljk18YtUOSZ2Rt8MMIJH02tqz0LBZRnn9k0WWwCEMx88tYT4LGwVNYn4zI2U7JScUhYBUM
 4IwsCJTI1EiqU2uK/Hx4WUp87pfn9Da8OhIEPWBH+GgX6fjJcKa8+eLAOta3h+AnPJva2xh5I7r
 IHXKeHjIvg8mIqB/usNxb6duq0iiBAZpudCmmLRdJaU3RasmrW1CPa0X82tW4E8WCKsMIgTR/8y
 jpXKxcWuDDjxQdv68Lq5pcM/kw4PPjFdthswdQ01SUvKMHatfIBR5P/ky6gSU4/rKz/to97L4lP
 hcMrrQ8YCbV9D3krzvt7wfMn9ORf6iLrDfxxZmEBFt391sqZklzgpa+KFiYoozqc06I43qaFkfY
 VAHxWwZ3PihBZEie5Nw==
X-Authority-Analysis: v=2.4 cv=D93SufRj c=1 sm=1 tr=0 ts=6adf2d75 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=vYu95guM48VmnKZvmccA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: r7_E3dzkEB2cdYo2uOJgqOi-DckdYZma
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260042

On 10/24/26 4:57 PM, Anna Maniscalco wrote:
> On 10/24/26 1:36 AM, Dmitry Baryshkov wrote:
>> On Fri, Oct 23, 2026 at 03:16:27AM +0530, Akhil P Oommen wrote:

[...]

>>>> One thing sashiko is pointing out is that new dt should work with hold kernel so, in general moving sid1 from there would break it since old kernels don't know how to handle them separately.
>> The rule is the opposite: new kernels must continue to work with the old
>> DTs. If the new DT breaks with the older kernel, just specify it in the
>> cover letter so that Bjorn doesn't merge DT changes before the driver
>> changes find the way into his tree.
> Ah ok thanks for clarifying that.
>>
>>> + Bjorn/Konrad
>>>
>>> Not sure how strict is the requirement for compatibility with older kernel version. An
>>> option in your case could be just do an override in the board dts file of the
>>> Steam Frame.
>> Anyway, would it be a problem? Does GPU normally use SID 1? Or is it
>> only used by the LPAC?
> It is a problem because, even if nothing touches the LPAC ring, it's firmware
> will still initialize and that will cause page faults if sid1 isn't setup.

We're slowly coming to terms with the fact that all of our multimedia
iommu setup was terribly wrong all the time. Venus/Iris recently had
a flurry of breaking changes. We have to follow suit.

Konrad
