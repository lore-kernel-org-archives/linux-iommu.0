Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA296436BE1
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 18:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362260; cv=none; b=RFguvm7eYVGgsnj0CdOpXdCfcbhNEvjfUvS8yy/jQC28WbreDSBJZmrGUhDsYnPdmU/w8qvpMahiT4kfWpE5Y89fcCDesGKR6TG2sD6vb7Cw93idot7teHJP8I6pFfywDF6BbZx7jTyx8hrhXMvHEO/rPesVcNfDoEgJHMolfbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362260; c=relaxed/simple;
	bh=kwPsWx3Lq+eORWtb/AZEuOV9MdYDT8Y8hkryWQSeGT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4Uh1UbVvW5qCahl/qTK6PMz9UOeek5hrEeXIJryBjCd8oszTJzlUhbo51zdzMjFrpEHeU1b6fhyUDe/8NBDxjTeeZ6OvqM5lLWXHnk2ej7Uf2Xg/Z+jhitax7+mMznMuUqG/ecGjqD50WTG3cwFRG0EIrtFQD/6z3DZ9gmygqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lNUbb/Ge; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AfDukYvH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lNUbb/Ge";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AfDukYvH"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FF7Ih990249
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 18:24:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=CcQRmc9BaCEAXdMMGYGlgduG
	dM0vGlhEkoGbgTNTQWU=; b=lNUbb/Ge+fiE6E3fUcv7Jw/FULk4oxkk1wkh3+Y1
	x/hKGfAgM3xzauwD1uGAU/9DjVbFIiTfu3EWo3Be3AtHEolg/IHDqmaEgMs/uO8z
	iSre4KhCH2Qyid8gtY7vz03VaPnXx4bUE4D4R8O2eWwsCfYdKJsYdv9MlzgM/YH7
	2/hFtwwscC4i/YOY6YuG6SrFlgFKOCCKALBi8TJwWjw1ViYpsqUv8u6FI5evO14v
	THkT6gWhTBU/oSiLH63A2g7h27vvFgZgUavkK30JEPuyfzwGJGIQn5cFZnp45Gqo
	4WOZLDOfUc1Df9rZpa4NJReR7OULlo06wc2b1/IvFQs4xw==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3gtbw4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 18:24:18 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5be072085c8so903963e0c.0
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 11:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783362258; x=1783967058; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CcQRmc9BaCEAXdMMGYGlgduGdM0vGlhEkoGbgTNTQWU=;
        b=AfDukYvHYJshPk38AtzVpMx4k5hn3e/u/JI51t8VFIYrafc0w0ZT5q37g4lyBRvJz+
         +lC0y3Vf9cqyc23znDEnBk7a6tHTBZzXPKgmV+p/fYzOZnWtWPk/VT2Vc1noMf0k8TYX
         EaFPwxsI1R/IkdtPtxbmVv0/cMCUJHy5I2tTE1Cbp8ir0lz61OayXMy+gX21rc/tviMV
         LaiIcoXxaKPhZnZnQSmcWikHkWG8vb98uK3Oc49Ew9B95w7xhUDWZ/18NBC3DnlIfBpz
         QliRvNPFJg/OMHC2yaKy4zMgR1BCt/XpxbQ0E3vrBSEJ6A8DvSvruAk/IeRC/x6v2g1U
         Mfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783362258; x=1783967058;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CcQRmc9BaCEAXdMMGYGlgduGdM0vGlhEkoGbgTNTQWU=;
        b=QTe1DmyCUPfMuGoP+Tl9hfQ7z+tBi1B77bBJSJG9WqOENDYkFiePe3ueYhnn+GiOCt
         BuCN1hXB7MoFHexu4G2Mzt/CNCku5LnEuFpj0bbvzIXpANPMdDVS3pq8H/Xa8SLn2NY+
         ot5q9Raav6cYK+56P9cqhkGowS28sE8zIzVoGgZ6iB2/HbVDcJoeBphZKaQyZfS2xPHa
         917tfZlalhH5OLK0fE6Hg8CZF0Sw7joOvndxSdeqAhwd4GnX6DJC3nXdt5tkufkGI7V8
         +xbZLVZVT3NRczZtq6xZoKKkpFw9puYj7IWYk/iuvsSGgKGUghPf0hZ4eCX/l5oLzstf
         RuEg==
X-Forwarded-Encrypted: i=1; AHgh+Rr8nn8qGTIqVbcrF5O+rBTKCk9LmIw6dJoo14H9gRbpvXWDvucFb5bh/YtcDbczB7v+EdmvyA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywh5T61PL+s21lRupiyncZolhFIJ3C1fBPPFolKjnVJsZZSnxRU
	NzLBA6nzQkfTELU89/WvQLOV1GaDcxX+voqp+O5aKAgGcF8dQ5MADYmefpOuKABh1EgLBDsQjfw
	cGYySPZ2Ppsk8Jb4EinxTzKRF9mNSgDwNjHcNLO5i6lwW060mTZPY8zg/cw==
X-Gm-Gg: AfdE7ckY8NZG333CUAuvNU8qi5ewwALd1hk/PhNLsH2oqZivLGiV9UT4kqwOy7RJIQD
	EmfzLs/IvIgns2YKlFUPKeOIGPNc66Ikvyf3Fe2aU6KTIPGoVhsoylWdGfcvk4GcEL1gXv0Kzjs
	W85MVsphD+4xNCKzV2hHgoUP21i1eF+k3LIHhWFSl+FAuVdRuB1MUuCFxSi15OsphsDBlaS4pgK
	IpzLwlgz0eBXiOuPdgWTZkXvxTJXKaZyMdZIXM2v1iCj9NMp3aoOd9fRaCGMPzGxJ8p0KnsGrig
	P1FggtgDMjfalIHV8LodjB2i7CK54f4kPCj+iudcoHhKkaZjwkGUTNwwEsuOgLOy6Jl5k/Bsqdb
	AdDr8qR+o1yQtN0Cn1E4zm0uOjKlwiJo/7R/bSnokr44BmXD5akkoo628M3n4IJO5FniiXzf9SW
	FrFE+BmizoEEmYkNIPIq40BovR
X-Received: by 2002:a05:6122:659a:b0:5bc:3dde:3364 with SMTP id 71dfb90a1353d-5be907c4ee5mr1028201e0c.7.1783362257733;
        Mon, 06 Jul 2026 11:24:17 -0700 (PDT)
X-Received: by 2002:a05:6122:659a:b0:5bc:3dde:3364 with SMTP id 71dfb90a1353d-5be907c4ee5mr1028192e0c.7.1783362257235;
        Mon, 06 Jul 2026 11:24:17 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed13bb768sm3082495e87.52.2026.07.06.11.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 11:24:14 -0700 (PDT)
Date: Mon, 6 Jul 2026 21:24:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Esteban Urrutia <esteuwu@proton.me>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH 2/8] arm64: dts: qcom: sm8450: Remove unneeded reserved
 memory nodes
Message-ID: <4g6y4q2udludhwmoqc34afwj5svra4a4j5bmpqza7h3av2oov7@6k5r7a4meruk>
References: <20260622-sm8450-qol-v1-0-37e2ee8df9da@proton.me>
 <20260622-sm8450-qol-v1-2-37e2ee8df9da@proton.me>
 <e1e492ab-884e-442b-8410-cc100c54fd5f@oss.qualcomm.com>
 <6123a923-21dd-4f69-9ac5-02165963027c@oss.qualcomm.com>
 <b3541802-3035-40ee-8327-a65bd5d2dfee@proton.me>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3541802-3035-40ee-8327-a65bd5d2dfee@proton.me>
X-Proofpoint-GUID: s8Kt9lZXu5Ef2UmoMW-v1gy9LPzyFenB
X-Proofpoint-ORIG-GUID: s8Kt9lZXu5Ef2UmoMW-v1gy9LPzyFenB
X-Authority-Analysis: v=2.4 cv=CPYamxrD c=1 sm=1 tr=0 ts=6a4bf2d2 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=NjmyTZ_Ky2fEOGBI-xMA:9
 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE4NSBTYWx0ZWRfX/C7IPgiHD0bS
 4if/2znttcKB7Ied/1VByo6O37dcOoeLGwDEu+D2ij4irwFauZA6F4OFJSAWgeS/Or4s5y2teuc
 gpQSsh9QmjK8ne0rp91n8FMotQZCiN6T2MZ2jRxISaYXkSVYuhujgLGSlH+v7xcIkFmN2qcsA1W
 WpOGEIB9bTfWxxLVG9p/EBKhgSTmfIdynJNf9fpLJd6eTTOc/Q+4cGHWT4mIY/sW9Anpl1/yH2X
 XZ51fhw74Rd4bNUEbVns08FKzfTRLp+xJw05tYT9OrDNReFmv41vSeKsC3lqC+a9n9p1IJna7B0
 y9rPzfpDmZJP+ewu2F+dHQxCwg1zLllwMTriAXVWBpJvEN9Txhic9aoZjCeesK9iXon0u4brrxB
 9HMAnfoRk7Ku6OcMAkI4t0G406MhR/lsNgezzrTbg9seTg1Nl3dY1a741E+9za7PXrlp2HMw6LC
 ccj74u7yKxAzDTY4eOg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE4NSBTYWx0ZWRfX9y5OciIu3CYQ
 DMZYp5J2ZXz1U+pPUOVA00YutjZZTk7aCdGydrRglXZyqGCwZpa85To/t+wJOAddLzGEAfj/6ak
 yc3jEAnfG5LegsRU00AuXNIKUQdrtRA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060185

On Wed, Jun 24, 2026 at 01:26:06PM +0000, Esteban Urrutia wrote:
> 
> 
> On 6/23/26 7:03 AM, Konrad Dybcio wrote:
> >> This is mentioned in the memory map description, but is not part
> >> of it.
> >>
> >> I booted up a 8450 HDK and it doesn't even have MTE, so it's
> >> probably valid
> > 
> > i.e. it doesn't report MTE to Linux. I don't know if it's Gunyah
> > trapping it.
> Then, should device trees delete these memory regions on a case-by-case
> basis, or be left as is?

Please verify that you can actually access those areas (boot with
memtest=1)


-- 
With best wishes
Dmitry
