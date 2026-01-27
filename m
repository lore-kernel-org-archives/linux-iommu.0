Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8622020B810
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 15:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769529558; cv=none; b=Kv+1KlZBlQiIKAM81Vw78oKhHbY+ZgK/i3D59auAQED0XmkYWoUmMZpacAAUEI/EDnrLsh27QaCWkUwkN/L0oWSZSJYIlzbAFrwLozGScEpDaxnxB/EAbe2h/RwEGzSz6YgJgo6p5PZLmFGt/QC7CXschLkx2GAJxmO+DBsvwUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769529558; c=relaxed/simple;
	bh=Ngu3VwjipfjyeOkg/wN58ZP9Bqz3JtvjynHTVCKcoIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z2w4PehjiGllpCeNB8ugNZWUMup7EL32NkPdEs7xzb7yVydELivPFB56Rp+ADdexYVHS3899UwHBKm9Eh3kGtKRW8mdB3W7d+gYOO37+0B4PnNZPDLSmvszhibR4P8U4r8rTWfZ/+UEiqgEKxbc6POgcJJMmTKcVaNHMGHEj68g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gk9hIe7B; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Af0VCMvR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gk9hIe7B";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Af0VCMvR"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RAEI6o171550
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 15:59:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2gy/s9BG2zQ/KnIW0GWqdLLIYLmspXWnSVHp7uWLnDs=; b=gk9hIe7BCdpk4RAO
	0/3fS8FpAOz2lXD6Isi+ExiI91UuaE3gTRi+i++XZjiJuKBqf3Tpd732Q+yI7H4L
	tpRmXMUk6rVycqbm+OB/6e6X8cyfuazsHoHLbDxHSY8tJa03RwKTbJVku9FeSOui
	zBCGOy8oBiEoQPeKHeH3wFOxtoRtn+em44+jt/UeYxEFtTHceaB9xNfXhpBfVXj8
	WRvG000BaATfUqk6Sxt9405gw3yI7Aai8uE3zO8LUCexolZWSx1oJpdl21XtzN5y
	5gVv8yi/hGwywJ+gaU1iUXMSQFQo/zQAEtG9sbZgt2am7SEuOjJPuOa5JZgcb/8C
	//W7Pw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxf3a3fpn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 15:59:16 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a78c094ad6so59533555ad.1
        for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 07:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769529556; x=1770134356; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2gy/s9BG2zQ/KnIW0GWqdLLIYLmspXWnSVHp7uWLnDs=;
        b=Af0VCMvRkppfLQ3lDTFwE1hNL33RgyP0T2WJFITXvIVmcVHC7yJ/v+KURmBb03HDaO
         G2gFLLD2oc9tn2WYzETZlECh8boiG2TfHu7BmStlOhVHiACbpGj58Lg3oZ6nCBPgyvp9
         pT8TPVuYoSB/hg7el8VPjw64qW3T/Q7zHvFfSq60aCUJvybXxm4tcU91QefaxxdTEl8j
         cVZyC5xmxGeWCbGRSGTyQWsTqlVHdvAbp4XlTF7P1Lil5+kLk7CBHAyF6rXGqQih34nn
         d9Lpub+BNZtncKZowmgp7bpLg3BmF8pxtv1rVWmIIuT3vv9OsTftrq36zZM5dAOmHdgw
         VyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769529556; x=1770134356;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2gy/s9BG2zQ/KnIW0GWqdLLIYLmspXWnSVHp7uWLnDs=;
        b=Od95SvvoQfWj1Hg2vI4lr95t1F3VBLdOmdUPg51y230tFiAIw9m1RfKoUV44S5eNra
         XVZ0wkq7YmOEtsuQzzenuorf7LQfKjZZaFA371/QTrNhj6Z4zJU5sB4pZT8PhNNDrdq+
         vUSPOw6DjeCovD6EdEb5EyuRwuTJxDCTwfwShkY8nLErDzjGLj5n8up9wDLA0bhF/47p
         6pmAhYbpvAfFCdxAZFj3AUagOKx90Knl/g4mSbVrQay7eyC/B17v7LEMc3nmTrum+88U
         YkAVR6lB8bjB2QJBdgzMC4GTldKI1VssGcp1SdKil6J36AzsTDUw8AfYSzYMNJ2/Zran
         j2Jw==
X-Forwarded-Encrypted: i=1; AJvYcCXYYHCS7o7LEcmQ9fu619Nr6qixpb3zwBJq6tcCMjuFBF7Ojr+JWmjZO/ygBxMkql9u5Mwpyw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwDRM7gBS0+JUaIcv0cOTA7N7EHnLrLSEpkc2bXBb3wkZghp5nA
	6wrp7mivS8J2gnhVgDvlZgvAylBJ5//2pazmFpNRfr9ihOdDpNNL4gBHOse+C9BDuSTjHezVnJ7
	EK8U/aOP48N0Kzj6zwoAy+l9gU9DNHfecBlXy8I6dSJIL2HK+2f8bhmCEuA==
X-Gm-Gg: AZuq6aIApfcBaiOFWKTl5Pk/xYHARN1qK4Pjh7VoctMk/QjvR5EMYbAWfX47/q7iftk
	EvMSXYXUcyJp+SIyxOpyRdI6UfqGzULFiontIh87ohGs1YlQs8Lwm/NabY/glv+Bjmyhm48j1UR
	UrSX/aQ09kzet1SykDlINMz09EphjA7hEdyF2zicePh6V2Y4XCoOQtxBZ+7EIQUBNDZYaieo7YD
	Dm8+UDpsRzr6GoTDC1XzVhRMvqey6HThvvQvHI0YoE0zD7exV1vxlElZyXwnTbMo5zscQyOxGxd
	4yDziFmv30Gnr9MWYwq8ylCeL2snaqnuIDoSMt+RW8pIhz+Wh3nIU+iXSx1hkZm+9hubJ2gEcTS
	u7T4KpDpd1iPNgOE/KzedOrbxurwIQqIpAiOEjMh1LkQ=
X-Received: by 2002:a17:903:41cd:b0:2a0:945d:a195 with SMTP id d9443c01a7336-2a870dde6f2mr22124455ad.45.1769529555701;
        Tue, 27 Jan 2026 07:59:15 -0800 (PST)
X-Received: by 2002:a17:903:41cd:b0:2a0:945d:a195 with SMTP id d9443c01a7336-2a870dde6f2mr22124155ad.45.1769529555079;
        Tue, 27 Jan 2026 07:59:15 -0800 (PST)
Received: from [192.168.0.171] ([49.205.248.59])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802dcda23sm123139415ad.30.2026.01.27.07.59.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 07:59:14 -0800 (PST)
Message-ID: <01532d63-ca30-42a2-920b-bab65254c9c6@oss.qualcomm.com>
Date: Tue, 27 Jan 2026 21:29:06 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] media: iris: add support for kaanapali platform
To: Nicolas Dufresne <nicolas@ndufresne.ca>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Hans Verkuil <hverkuil+cisco@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>,
        Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
References: <20260126-kaanapali-iris-v1-0-e2646246bfc1@oss.qualcomm.com>
 <lpgw6eodclsvfwgvtljfiorvjkpd5vd27yhxs7i3ijfibaqzuk@bak2lwbyh77f>
 <2d4632b2-916a-4eda-ad08-44af68461dc8@oss.qualcomm.com>
 <vv4stkmrrwdqmbnpv7pg5nd4immtqo5iplwbcia3oykycfmg2m@dsithotfy5ls>
 <df2d7dcc31c9a47752a1d58efdd7a416311e55ec.camel@ndufresne.ca>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <df2d7dcc31c9a47752a1d58efdd7a416311e55ec.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEzMCBTYWx0ZWRfX69pTIpj3SOmX
 u5RvyEye4AEpmADRt5ecq0XO8O4C5wfrhuSbq7QcnYYnGUBnPQEnxD4WiMq7vH6VthrFdKIhgap
 niCNwA7MTJNfuo3ApVKTjQdwJwPraSZ4fFJchcjp881me+zxlRk1fy0AvyD10kWMy38lj22Z0Ts
 UhK0gONQC8ExKyc9fu+/R4nYGP7YhJfh3eyoYcsw7wIuayOUjzxo3FxYStcYIDhFoLW+CnFDNFl
 kX0BwvgMxvTKgdjMWx5Ds36YQRyAUsESONkuS2MVovmT/gOvdP4ECU4JOdF/m+fyxxceOV0R8at
 pA7faschL6O7qljLx5V7f4w67uw+JNCkv0WjUbOVmuixL6zJL8N9GFxj2RSvg6WkhHJxk1D1d4E
 sE9S4V/Ur2zpx92cP3mkXimSjVe0nr1UibcBNczjxIREGnlBbc2dk1kdZmww6Ae+zSmMzn2eGiD
 osVDcYsyc0+PiFSGlCg==
X-Proofpoint-ORIG-GUID: nZUEAoO7PKHNSDOg1sCxe8SOo_EbeOMX
X-Proofpoint-GUID: nZUEAoO7PKHNSDOg1sCxe8SOo_EbeOMX
X-Authority-Analysis: v=2.4 cv=a6k9NESF c=1 sm=1 tr=0 ts=6978e0d4 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=4hJEjaH6g9CgPEswoao2AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=zQZbQbw0M5qWU-wOwpsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270130


On 1/27/2026 8:40 PM, Nicolas Dufresne wrote:
> Hi,
> 
> Le mardi 27 janvier 2026 à 13:52 +0200, Dmitry Baryshkov a écrit :
>> On Tue, Jan 27, 2026 at 04:56:34PM +0530, Vikash Garodia wrote:
>>
> 
> [..]
> 
>>
>>>   - 4 testcase failed due to unsupported resolution
>>
>> Can it be fixed?
> 
> Its nicer if you name the failing tests vectors. I can guess this is
> PICSIZE_{A,B,C,D}_Bossen_1 by experience, but not everyone will guess. HEVC
> level impose a limit on bandwidth, not on resolution. These files are either
> very large and small height or the opposite. One of these is just 4K in portrait
> mode (that is more concerning). Though, there is a V4L2 limitation for this
> aspect, since we advertise the resolutions by range. Most hardware is designed
> to support 4096x4096, in that casse that's what you should expose as limits.
> 
> Though, some hardware do have dynamic sizing capabilities (like RKVDEC HEVC), in
> this case there is not much you can do, you have to find the right trade of. But
> since you expose LEVELs, I think its fine to overshoot a little. Both
> constraints should ensure it works with valid streams.

I can list the failing test vectors for failing tests. In this case, its
PICSIZE_A_Bossen_1
PICSIZE_B_Bossen_1
WPP_D_ericsson_MAIN10_2
WPP_D_ericsson_MAIN_2

I have not explicitly gone through individual failures this time on 
kaanapali, as last time when these were analyzed for earlier platform 
(SM8550), the failed due to resolution lower than 96x96, which VPU does 
not support for kaanapali as well.

Do you think if fluster can query the supported frame sizes and 
accordingly, mark the ones testing outside that range as pass, if 
graceful error ?

>>
>>>   - 2 testcase failed due to CRC mismatch
> 
> These are clear example of "no one can guess".
> 

RAP_A_docomo_6
VPSSPSPPS_A_MainConcept_1

For "RAP.." test vector, it was discussed earlier [1] and the frames 
marked as VB2_BUF_STATE_ERROR should be dropped. GST is currently 
displaying the NULL content leading to CRC mismatch. Let me know if this 
can be taken up as a GST bug.

[1] 
https://lore.kernel.org/linux-media/20250408-iris-dec-hevc-vp9-v1-0-acd258778bd6@quicinc.com/

>>
>> Which means an error in the testsuite or somewhere on our side?
> 
> The testsuite fully pass if you run using Franhofer reference decoder. This is
> logical since the MD5 has been generated with it.

Since the reference decoder in this is not generating buffers with zero 
filled data, its not complaining. In VPU case, even though buffers are 
of zero filled data, marking them as error, should get dropped, instead 
of considering it as a valid frame.

> 
>>
>>>   - 2 test fails due to session error (under debug)
>>>     - PICSIZE_C_Bossen_1
> 
> Hmm, see, I have no idea which fourth one could fail due to resolution, and that
> forth one is likely a bug on your side.
> 

This could pass on sm8550 and fails on kaanapali. This should be 
debugged from driver side.

>>>     - WPP_E_ericsson_MAIN_2
>>>
>>> VP9:
>>> 235/305 testcases passed while testing VP9-TEST-VECTORS with
>>>   GStreamer-VP9-V4L2-Gst1.0.
>>>   The failing test case:
>>>   - 64 testcases failed due to unsupported resolution
>>
>> Can it be fixed?
> 
> Check if you aren't mixing up constraints between display, coded and allocated
> resolutions. On most hardware, all 3 can differ. The OUTPUT queue should either
> not care at all, or use it to allow optimistic pre-allocation. But check that
> the low resolution constraints is not coming from the OUTPUT queue software.
> 
> VP9 coded resolution, it always at least 64x64.
> 
The failed list is same as the one published during sm8550 [1]. I see 
most of the test vectors are <= 64x64 and going as low as 08x08. Here as 
well if we can have a query for supported frame size, it should handle 
these cases.

[1] 
https://lore.kernel.org/linux-media/20250408-iris-dec-hevc-vp9-v1-0-acd258778bd6@quicinc.com/
>>
>>>   - 2 testcases failed due to unsupported format
>>
>> Hmm?
> 
> Clarify please, I suppose these are YUV444 (aka professional profiles).

vp91-2-04-yuv422.webm
vp91-2-04-yuv444.webm

> 
>>
>>>   - 1 testcase failed with CRC mismatch (fails with ref decoder as well)
>>
>> Could you please raise an issue against fluster?
> 
> Check your setup, it fully pass with reference here. The MD5 has been generated
> using the reference.
> 
>    ./fluster.py run -d libvpx-VP9 -ts  VP9-TEST-VECTORS
> 
> It also fully pass with the GStreamer wrapper, though it had been fixed in
> recent GStreamer versions (I'm testing with 1.26.10).
> 

I would let Dikshita comment on this. I am unable to find that 
discussion where it was failing in her setup with reference decoder as well.

>>
>>>   - 2 testcase failed due to unsupported resolution after sequence change
>>
>> Can it be fixed?
> 
> This one can't be fixed without adding an extension to the V4L2 Stateful Decoder
> spec, like we did for the stateless decoder spec. In order to handle inter-frame
> resolution changes (a resolution change on a non-keyframe), you have to notify
> userspace with the new resolution, give it a way to read back this solution,
> have CREATE_BUFS() support to allow allocating for that new resolution without
> going through streamoff (to avoid looking reference data), and finally, a way to
> remove buffers that are now too small (or too big if userspace wants to reduce
> the amount of RAM used) through the new DELETE_BUFS ioctl. You also have to
> track in your driver the reference buffer resolution/stride.
> 
> This is non-trivial with the existing stateful state-machine. You have to make
> sure userspace won't be confused between normal DRC and inter-frame DRC (dynamic
> resolution changes).
> 
> 
> [...]
> 
> regards,
> Nicolas

Regards,
Vikash
