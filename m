Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793460800;
	b=jKtmSfCG7u6qfPsCgC6ZHalBlg52KKUD/UEgqH2ZkGyiW1NXdpqYRA+qvUd/hXF5kDL4
	 J6tv7MF6lYVBq4qdDpvFsUpPeWmCoXkhGNN7o9d6sci8pZYI3h05ffX4UMvRIjpB6rHjc
	 TK40Iavb63b48WwFFmBarkpgv+/0zt6dG0vzXTkn8Y8hhMAJuYYneaz9ikVf91IjPHfLF
	 Jcr0ZyEyPBxCYW9ikEk4/8dRShRPIx/zNay/I4uXfCljGONmMrKas61bzzDPQHUNo+YNs
	 83YIeli7ekR9VE0BQr85yK1ahF5uNt21CVU2B5vLOk53PJ9nbcNdfLg+BycAlROqLgw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793460800;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:Reply-To:From:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=+6KHp1DDQ2+j6W05RK3+UyPZGKExyceQhydv1qHVmKA=;
	b=f31p++hNlbb5fLIt4y/2EXl1uWpcAeFIN8BStxiwdOy4KsiPBdi3G1TouGoJFP/szPF3
	 nec34gzbKXkgab5wYCDWeDDVZWP2AL8uCDSsdRmhE984pxpi0iX7VQdYN4HBjg7grc76U
	 dyeMKWqjMLWyl1qt4eHvQdya2fHsd9vrKSs2CeN7mZzgjp6sIKAaQF23kKCnSbnPwvt+d
	 YXfAXMMLowXrczXSsdNhpnH1IwFYTxrnoHRPjnMYV+7g9LbZwaCREMiU5xwhZtL+i+bIr
	 C+VSYZQMnimrjvyiNPBgstPAO+PTjLVSTja3k9JCnx6BYWy6UngAQnxRuUsibkxuQdg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Rx5uTZEZ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YNG1v9c1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48A9606A31A
	for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 15:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B48A9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Rx5uTZEZ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YNG1v9c1
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69VD06281233127
	for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 15:33:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=+6KHp1DDQ2+j6W05RK3+UyPZGKExyceQhydv1qHVmKA=; b=Rx
	5uTZEZScz8k5imepm81GKYaWJzx92n6ZOlW7C1HaNVyfBqSFHxJDe6sIT05ZtUxR
	bQL1gebz5vqWtcHRGuH3/VmY2OxCKvax1EpXf+CZpIaPz2S2ZuSA5kurJeY1z4wi
	vYUOqRqiz7CC0E4uE8pmywnJzmaP8DOuPTbsJOtebPxLCdKWwkZU72HP9WvftqfE
	U9Jyp3JSdSXW4uKjjW7/FhH/vrqCUiSupnInBUETS4KkLQugBk08jLTGYvuKVSWr
	iouZ7hPZGyu/U3/XuYdId8OHlbssWu6r9lFwWrKNdSnmwtwdanYqLXjDx2/34fFi
	KG8z+RxJYNz1fjYDTEtA==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn9m997bc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 15:33:18 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4b2d1eb484aso2308045b6e.2
        for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 08:33:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793460798; cv=none;
        d=google.com; s=arc-20260327;
        b=bzAIjmolBz1VnPh7qKH/KZiEICSA/MStEbgGTYPn/2NYOHiKXQbEqheP8Yqqg3TfOG
         aIEZQ/OFVB+r4Y8HhX2LzzWD7wvH+jinA6wV47YfhBg2wk0EPD2ov/uI9SMHw2ywOGG4
         zAYFKzBXm9iovKQUbXXiXlIwVQBbYOzDSnnYL6Rg4cbil/HUDTb5YtwndDgRG7mNdne4
         /5fND01Y5b5od7TA4pqo18dw67SFKS2XmBDSW3XXdJ4i4pPPpZggcZDg3UYr8IGOFCJa
         2ncZdFtClkzvhaRBTxSsSaLyUoyHGQ6s8M1gs4UfD1jMEPaWpuBn/9Gu7eeMrROP0Jbp
         7T+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=+6KHp1DDQ2+j6W05RK3+UyPZGKExyceQhydv1qHVmKA=;
        fh=7luhhJMq0DhB41FVnLEIOZADmf7hUHus5PXl91n9hJE=;
        b=LWvqxFoTDG03YbQuUnksL0mUuSO8fjiXerk8S9mnWyJ3mfWng1iUE3FCz/paBpPrmJ
         Gi3byG8tRrEFdNwAVNSRQ3zuQcO3CzHGQTqV/NXMUUwM0vLsU5ZURQuv3aU/lB8iBj3e
         WiXJdBL5NQSODyORlnQpc/OySttxSE4L5WB0mciUvM9QU5q1/n79K0Jz+W7N12wGstBS
         ujAgUhsdCx9OdD/yi1JrJFrMft0YruUi6mFM9WQwcIqZ6vIVgiE7gYhBBc8lfJciDVZg
         /cJRa4zoATRVrVRnX+C9uBuuwB9HTfMJWmPMe+IYedd2vaO5Xph1GIjKnmT2aD8ZBv/T
         g9HA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793460798; x=1794065598; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+6KHp1DDQ2+j6W05RK3+UyPZGKExyceQhydv1qHVmKA=;
        b=YNG1v9c11HBJzMrNrThgnaVExxdxSuZopFOkP/ZIwE9HJZ8NbYBcitJAGz/o111n2F
         Okw35c0+1XbNCqL3LiQLkMTAlAR8XTQdaPGGd3wKuCuxIsgDFcD7FuXpGhL5W0oX1dSI
         HXRqStCz4TLVNzhzL0gG3ZxK1ZiloPu52i6z0JVux5LWqSAeuPQh1YDUXuezxNF6SU/f
         2iysV+GbIXfT62atYN4J8IfESQ/7EZ1eKPxMfy7+SRolmRe0N90xtV1WIHeRKviUkJvb
         4lq9h9eLmHS740IzVyIfI8TOf5it2j0xA5Sp6oReZJwsVYPvOhFiVAxM22fY58tcVhIQ
         4eBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793460798; x=1794065598;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+6KHp1DDQ2+j6W05RK3+UyPZGKExyceQhydv1qHVmKA=;
        b=TM7LSbZ4lp2vSMIVsdUPIoT4807n7CAU25l9Je4l4mthCZzzJtFOcAVbmvcbxIJDs+
         uZXh2bL/B5tOiGm7NM048uCDZxqXWrTrabulkT3fToHwxRiBa8ChkdtUqzOnqpIxi3Xj
         kdAG+jzmntKFKgUYUBNZLkLtwRexrgvx7OHs0LURqTUZLvaToxa8ji4ifQE5MB05imuX
         U2pgY3On1vbFKE0p2y43NEXWYMc2GZpPwpQ6FbAq4rtIT3T71bVzoIkS3trlHSWf/RO0
         TspDtE1b7nPiC2yibxT9AMDmeNdd5Iy89+CFqXBZ8TuOfOL11tcWVDVYq4Q5pxUOAmUW
         rzQA==
X-Forwarded-Encrypted: i=1; AKwUvBwswKG9GF6fij7yRCcKHKlW+Tt+DCFFOJWR/lEXZWVD1sl5W5uCJHroMx9qPihvEsU80H8NMA==@lists.linux.dev
X-Gm-Message-State: AFq9FYKX/WYCmHkomZu2aqjFNOqSC2KWcvy7/s5u46mBglceb/fy+vdo
	/+GBZ4RyRPzcgVVpTDhMUCrN/sbbIZrJwXKS/znOAcPsfP9HQURUYisGglLxM077VaWJFGbiagt
	cD25IT5JI5XotM8yd8vMhssEahIt3KSKrfMJdEgweX2pQ5/BgPj6DvwUi2Qs53T3qI15Z2m3OV9
	FFTG6L8nvnzytB8fNzalyobHTc9U24Kv+1
X-Gm-Gg: AYBFou2rURpTbqI+8KMs0/A+nbKzpIG/cvAEMGIQtxkarLdqKPh7M8+40nwNp5u9hhw
	qRfx3+9JEQCqp3RECpba1f62zjwW7LYQE5hP1Q8k5cMvxfHq7BSeaVX157UTXAeyH9duBmDzJUH
	AKmg5vnQdbJWpMAplKbYtEO6OyDtyRnfvI+sOcuvfCAS/CAfVjvmN1xYgDmA==
X-Received: by 2002:a05:6808:30a6:b0:55b:f88d:919f with SMTP id 5614622812f47-5640de5c4eamr4534433b6e.53.1793460798013;
        Sat, 31 Oct 2026 08:33:18 -0700 (PDT)
X-Received: by 2002:a05:6808:30a6:b0:55b:f88d:919f with SMTP id
 5614622812f47-5640de5c4eamr4534414b6e.53.1793460797558; Sat, 31 Oct 2026
 08:33:17 -0700 (PDT)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261031-msm-smmu-identity-v1-0-a2a70580eebd@oss.qualcomm.com>
In-Reply-To: <20261031-msm-smmu-identity-v1-0-a2a70580eebd@oss.qualcomm.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Sat, 31 Oct 2026 08:33:06 -0700
X-Gm-Features: AclHuK9CSsE5d2RI7IGhCUXsadCiEmg1vr_YsLjfD1ZPNBmwTgEXoOH0UkuFoyw
Message-ID: <CACSVV02xa+emUMd7Dp1rDSwa0e3wpyQBcPeZg-bXPL4U3kzQvg@mail.gmail.com>
Subject: Re: [PATCH 0/3] iommu: qcom: Fix the MSM GPU and display with
 DMA-address based mappings
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: aaBZy_ume-sC5SNDzM3Olq_7tSiAY_t1
X-Proofpoint-GUID: aaBZy_ume-sC5SNDzM3Olq_7tSiAY_t1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA2MSBTYWx0ZWRfX/NZgZ5rm5To4
 A8/UIADEm3k7/5GwzDsuAeW9bkx6x/CEnseZlZy2Xn91Z/5VIL0aafuFgvQuaqG5sg9vFakHwVj
 Fi34mAx8YsNRFyr+cHUaxxi63pRy63EDpJ5xzjfPX5F8ndrRWh702Kh01k09Rv2fabPTHZja/MZ
 zrcfjfqL1mggvoEJSBCnxHmTEvbIgkM57btMIzAEidjUczxlRt2Hu4u0JfDYemBcugiuwxSBCRQ
 vLYC/NECfFUrkcG/7cJTncSMSiiMw9x26atImsq+vy/3QCGBjyHG2Rnkn89DcCIQl+esshmYAEO
 CkHhHD6b6J/fwe+Up9UML1Ol7ou2CL1pfAnAP+BgwQMwiYw7EXyI4AInac2sc9EHXMhs8tYVO6U
 pli+vSNGWgqLT3kV6x7VyXSzpvFHOC+u30MJc5cJv0s9Wi9upZQVKnRxUw3Ps5jHOek08x+9PP7
 vMAkM3Y7uZil9CjFkkA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA2MSBTYWx0ZWRfXzowSyurXQ/N2
 m8LLj5zDT3kY6tRO4gSCZZMdqX/1Uxa+WBsJPRDGpgXUGElwl2zRqs4dn2v0xY3p6+m+tE9Bz5Q
 O5OIhm7XIOOTfxC5edYk0zDFj7ZGPzc=
X-Authority-Analysis: v=2.4 cv=cfVHPXDM c=1 sm=1 tr=0 ts=6ae60a3e cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=QEYsvGaJyljY994YBNYA:9 a=QEXdDO2ut3YA:10 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610310061

On Fri, Oct 30, 2026 at 3:05=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> Rob's drm/msm series [1] writes the addresses dma_map_sgtable() returns
> for the DRM device into the GPU and display page tables, so they have to
> be physical addresses, i.e. the device must not use iommu-dma. On DPU
> platforms that holds, the DRM device has no iommus of its own. On MDP5
> platforms it is the MDP5 device, which ends up with iommu-dma: the GPU
> then fails to start on db410c and sda660 and resets db820c. The last
> two patches give it an identity default domain in qcom_iommu and
> arm-smmu-qcom.
>
> The first patch fixes qcom_iommu's flush_iotlb_all, which never
> invalidated the TLB. Nothing relies on it today, but the series above
> does, hence no Fixes tag.
>
> The patches are independent of [1] and a no-op for the current drm/msm,
> but have to land before it. Tested on top of [1] on db410c, db820c and
> IFC6560 with and without these patches, and on Open-Q 835 (DPU) as a
> control.

Thanks, this should mostly supersede my untested series[1], but I
think msm_iommu.c still needs the same treatment?  Hopefully just the
def_domain_type() part?

BR,
-R

[1] https://lore.kernel.org/all/20261029212344.346069-1-robin.clark@oss.qua=
lcomm.com/

>
> [1] https://lore.kernel.org/r/20261027230452.130031-1-robin.clark@oss.qua=
lcomm.com
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
> Dmitry Baryshkov (3):
>       iommu/qcom: Invalidate the TLB in flush_iotlb_all
>       iommu/qcom: Use identity default domains for the MSM GPU and displa=
y
>       iommu/arm-smmu-qcom: Use identity default domains for MDP5
>
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c |  7 ++++++-
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c    | 26 ++++++++++++++++++++++++=
--
>  2 files changed, 30 insertions(+), 3 deletions(-)
> ---
> base-commit: f1ac44c32cba88ad65dcecd4a279661d14e93651
> change-id: 20261030-msm-smmu-identity-6fda3323023b
>
> Best regards,
> --
> With best wishes
> Dmitry
>
