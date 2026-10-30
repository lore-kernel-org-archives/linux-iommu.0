Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793363766;
	b=uLq8DzbBp0Vi7rU0S2QLE3CfXoZ6t/26pVSS1S2P+lQjofjidh/qJVFOedgLSoT1JAfY
	 vvFVbg9EaF8EkmCdeGgTTvZoxt0B6EnY5GOYA97sC23wVRqrkeNJQiSVVuy4rFrPWIwfJ
	 0ECuL2D0tFLxbhDwKnpKjlVJWsRORKcUfC7BMuRONjExse4LwC99cgKJDbLRpDXi74Z5c
	 sujrfkt6NIJKNtAbK4kp7zS6k/PUN62jivuSRHVRdemqMB+kgfeV0cZd0jd6vf9IwVXfb
	 ch2UFK3ZfYjt0XO4mXaCh7ttntLd28zvraW4We18kKZYoHpznXs5/CCEjKNMq1/l08w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793363766;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=PsdJ/sQncKvFnzsfbs3L9HOmsbbc8CaNjBNOtLmdTXU=;
	b=YOz2HmLLHE86CwWpzifZhNFdKdSQNCmBPpiSn3qrrXUxeeGSpWaSB5Fw4P6xk/kOlkG+
	 hptAQlXFtbuWp44QaftRtM99iQkAaRR1aMOdDYCs3M1mQV1o2ZtS7unQ3tg7oqmkMuswW
	 H5AhuhAUdi5ULeBFnM3vnsvabwHiSB7DaswwsLugIy4XHFHSTmdxRF3oM+07GY0kKxmmW
	 7RIcmI1d97cnKzdxwUnry5IYD2jpXEhLZcXEB4s0aj9EmRC25W9WJbOULiuSFqzJHAo9T
	 bq4+KqxSsR4vsVVDHIAzw1tzRUN600Fg48TUochb4jdMSWNhkPlAHI05kqX1Kbs+/rw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=e3IE4qwQ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IxQKhlqV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD20606A31F
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 12:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BD20606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=e3IE4qwQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IxQKhlqV
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UBG9bC3719625
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 12:36:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=PsdJ/sQncKvFnzsfbs3L9HOmsbbc8CaNjBNOtLmdTXU=; b=e3
	IE4qwQOFgqK0bbRwjOQxAeUpHNDVsU5XPnIuBzxao7roUq7aP0qACrqYYEVkp5zG
	5oBydsI7dWtfmDdsNKVJ/XGKezJ11vkTTn39WTOWlRHhWm7XQ8U9O2seE4HDrPBc
	DEv6nU5H26xRc2yeFh2BfA7Mcv8yOzRNBRQR5yYqnWo0kZHGUQ/+JkU7xqUL+5m4
	Aj9VCtCaFuyFrHEZbPmTrPz5nJsZ/plqhFvb+pccGa5pJYSRrMwK3UMt7cH1a3ZK
	zSnTShpr58u6PKFXAWaz8ZZf4tJUfxIYGD44MirKKJCFnHtvV2H8k5ZzNQZjtU04
	YYA6jaOZIxkcMdNblQsQ==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qu0mm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 12:36:05 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-46509ab0149so595027fac.2
        for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 05:36:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793363764; cv=none;
        d=google.com; s=arc-20260327;
        b=P7aTJgQTuLwuuN6k0aWpT/l/GIdwzTdOD10GrMC2b13YN/YDpdNfR4wTRTkqpKgs7W
         3MjT95cImUimF6bHXvbTFtohgCe/fxXjyjOFLPF3PyOQQhXuyGRmsG3aPpiwTFl+s2zG
         qwMlBRV6BGE9WwIXK1Hez1MnwrRibkgT2W9tYzbLtWZP0F/7uiJodubKFiPTrnnGEuWB
         yKIjxpakP6rVa/MCHU33Zp7vVoIbFROU6CaESX8WtuVc+DLN4y8U9+q774zb+pT1f5fF
         1vFMvbNuc9huIjy/oemAXpRLOXuxs6mnrroVYFWpwv+GKB05uUqUPw+hRPm/HvQR3R4G
         MHjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=PsdJ/sQncKvFnzsfbs3L9HOmsbbc8CaNjBNOtLmdTXU=;
        fh=WrQU1g8nezwzmD4WmN+uG/OXPVZDFV6nHVo1LoHPaXo=;
        b=EbXQWNMDy1mtFvzwrP3e7CMpPpWAwoI2Vm1bOLXJj+EeUK1g20SNugPOYzCiLvR/Rf
         bSgZwjscxvT2jOYPq44xXmdbRs+wBwLLyW21hhgfN+m17+GuL/4HnDWnnM7k8uL4bjRp
         6hv5WyKAZSmcPrbID1pb43xN970hZq8V4eXYbmK88jAqwFA0fFauKeOvQqk7Jh7yigcI
         glh743vVyD87fU9wxKwY8cePGZSrfs627xx+VasnDPPqeBFcTg6o70iqLwYqX2sKdCAz
         j+KG7HR55hDVDJd8Jo7z7YfIIbI7SzRtrGDFenOumjY51zRCTvpQinrLV/oThZdpaZkL
         NFVA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793363764; x=1793968564; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PsdJ/sQncKvFnzsfbs3L9HOmsbbc8CaNjBNOtLmdTXU=;
        b=IxQKhlqVkpkA1u6qtBNo6reK6Yvpv21rvIUwGgFV1XQJe2EnV/VL6sj7uSckvqnL6v
         zp5q9BADoyOoeYBEtu1isZzL7fcQI1A/fBxfSc+EYn1ncR9+lS/daAZ/7DHh5Si+Ck+q
         wq659/8j2te1aJQeb1CBOUOjB6gHs6UagtbfCHcrC8AvKNXT9bHBOQ8XgOz2lEaaIL3D
         zwr/nhRGLU6YNTUt6oC3Ky8YCrrHJeZYHs3R3zivmseU1MiX36bIzLBfq/QbhgIeLuqA
         FzCRWqCjy4SC9KDw2V1EtCy7CHSMsz3pns770NKr6Xd+k5wL7Ax3phksfxyCUEBAeZeK
         HlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793363764; x=1793968564;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PsdJ/sQncKvFnzsfbs3L9HOmsbbc8CaNjBNOtLmdTXU=;
        b=sIR5rpzjMuzHwNss9RYNEHfJt8KPWsoOPwPDseq7LxKvepYVfAkZUzZ3OayWlFlCNG
         ENHVijoJCuZYq1hNqOaskMOxxPPQSZBaczq9X3/E1A9GxGo+WW3/G6Wo9vQiRau+SlyF
         Rn2wkHG7pSsC+1QNSNtMJnegbJwKgLE5kfAbvu+8GAIRYEmwdxsWw4fkoIUgGgc4Hol8
         zli4qELTckbYftamE5etbuNVqY7FQOYY4LjqVhPjDDXVBN9Wdw5BMPE6J5jDKKK944w7
         tDrCmMV4Vr1/i+WtasmUGwdKNqCX1z/Ml6G0gP/26FUMOyZn4+RlBJZ7x/pn2KJT0ouP
         sfEg==
X-Gm-Message-State: AFq9FYJUIF4TFKcaMKny+tQG2jxxDUQzu0JR4rwzJzfghUCRElz+ZyCz
	VcIAIbBlcuR40AU7tvYxx7lHDmGrjGHPwym96EuTDRsKxBueztLvMB0mbhvM62sffC7QvsaZAg0
	CH+uMs2IN3wj18rE6UvNhijjiGQGk5ypQksoyyLW9afnWa41lIcjCrGRsskyeYlwhVVVWBxRll9
	VCJahynseVQqr8g8gC3/T303B8wrkEpmUuqO6LqGTE
X-Gm-Gg: AYBFou1RTznbCJaNFn1jXFQD8gcQHQmjfUeRdB+FH+jiulsCI0GW77HXFCJtqh9qh+A
	pFLb5AyiX1mUK9nGTRxn8uYUdzTU0BCsxHMNwlmvl8VypViQRSfk3nN6JI48ICfCUYqXh6o37W6
	Uf4cmAK1BylODYaIx6mXxSqQbGwRZX+4RbcE12KhqBqjReSOpVNL8fAxve0w==
X-Received: by 2002:a05:6870:a104:b0:475:e066:7714 with SMTP id 586e51a60fabf-4a9076f5d71mr1257358fac.27.1793363764187;
        Fri, 30 Oct 2026 05:36:04 -0700 (PDT)
X-Received: by 2002:a05:6870:a104:b0:475:e066:7714 with SMTP id
 586e51a60fabf-4a9076f5d71mr1257338fac.27.1793363763749; Fri, 30 Oct 2026
 05:36:03 -0700 (PDT)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261029212344.346069-1-robin.clark@oss.qualcomm.com>
 <20261029212344.346069-2-robin.clark@oss.qualcomm.com> <067b2a6f-9e16-4f8f-bec2-5ee2de10125e@oss.qualcomm.com>
In-Reply-To: <067b2a6f-9e16-4f8f-bec2-5ee2de10125e@oss.qualcomm.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 05:35:52 -0700
X-Gm-Features: AclHuK_Kxv6J1o1Nk4jiUTeYgcQUlfsMkvo2Oyu2LlP58eHKHYlhfwHqpLn5bVY
Message-ID: <CACSVV00wrjhBHtKE6iJ=yvdPVaZ0RreJm27JQ9KaKy50-FSA1A@mail.gmail.com>
Subject: Re: [PATCH 1/2] iommu/qcom: Use identity domain for GPU and display
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: iommu@lists.linux.dev, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: urEQBfTNNhNd7qrCMg7boidsGJUM7oal
X-Proofpoint-ORIG-GUID: urEQBfTNNhNd7qrCMg7boidsGJUM7oal
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1MCBTYWx0ZWRfX85iTXTg1O6vP
 umhl5yfZkMEWm/fbO1EuQOO2jQleAUgtfNVVxhnlUC1WoJI2tWh8OW9PKtjctBQauVUG/ealNP5
 42oivLQLJvR58g9dxzHjZFdGWIiEkXpValylLOMjUParwgrrOT7s8zfs7Z758GuX2PAJP/1AEfi
 fk73YKAoRiWhz8nCCx8qaC2R0eX0Wzq5U+Jd5+VMOIA+09l/PkKuDGVr2nd+kcOKNeVPjeChm9D
 PeimwDETTEypmaME+dQhbDjf20Qbtumg9oYqb4inSznomejGunY/HkUo3nGZyUCSvmBbF17yT6w
 pQCMN1IS8pH/vIQy8jvbPEkBvBmhMo1uN3chzZuug0RP7z+M7b94reRSPEBSZH8iNtkIXWFWwep
 wiO67J7SA8mhnJHXy/m37z4UWl/t7ZwoXYdUTHf+F28mGY/RIGWaSLehA7XCS1Umu3U+/JxQhM5
 FYGaX1fU7FnmMzVe7yA==
X-Authority-Analysis: v=2.4 cv=dPgzC+Zb c=1 sm=1 tr=0 ts=6ae48f35 cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=RaxNTMYahNmlKwi_CG8A:9
 a=QEXdDO2ut3YA:10 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1MCBTYWx0ZWRfX48fyLA3qFyqR
 /eaEf70kdgC7D9U4aosnSkrfdGpfOYNC/saIo8IHAiwRiLZuqndj7hEqwivW1QVHqyDaEfwucIL
 0m0jnaW3Rr5JG15gjlbLXR3KFGKZyTE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300050

On Fri, Oct 30, 2026 at 1:35=E2=80=AFAM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 10/29/26 10:23 PM, Rob Clark wrote:
> > Similar to commit 0e764a01015d ("iommu/arm-smmu: Allow client devices t=
o
> > select direct mapping") for arm-smmu-qcom, match GPU and display compat
> > strings to pick identity domain time.
> >
> > The drm/msm driver attaches it's own domain, which it manages directly,
> > so we don't want an iommu managed domain interfering.
> >
> > Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > ---
>
> fwiw I'm not sure we have any devices with this driver and mdp4
> but anyway

probably true of arm-smmu-qcom as well ;-)

> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>
> Konrad
