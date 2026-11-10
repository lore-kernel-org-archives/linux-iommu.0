Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794308097;
	b=N244VfoUTz8n130QbkF2MVHpcn2s/RIH00jxLQxCebS/QDvxZplzqAkIWIr7iAvnGS0q
	 0uf6JAKCoG0JGVl1zYJXp1D2PNTGnAXfOH2hEAe5E1uCwW3fs51jK645iM7R9hGlpvDSb
	 OOaUoTkTd66y0JNW/ffRZ2jFYhjG3MwQBmXW9MXQf4iT9wScMlJTrWwkRQ231kugdkvk6
	 vqnC+8LubdIGH4SVx8MGz94M6AVUEdpLy0qZ5OKBzPS05qHR21reN3yKOi/+8ELRKY7nx
	 YjZk+9MGIuf1CE8NnSIgWIt3Ejhnz77OqbsZGEnX2We0gd/4x/t6UhKdeSAOSIfa/8Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308097;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=/GvGp0ikRhYCrmCcfVEdjux6pBM8MsB+KXbne/7lAoM=;
	b=JTWZK//HXBRgJL0gfu2hvI0JWW1RuHzRrCbufCPGrrnexYRWn4/9XwL7s33WpV7byGIR
	 bu1rfeV3hPD2aUngLfyVYkg9Wj9ppyPo1u/yJpkpOvguEseTxAG7nTxAM5YWhRRAguBcR
	 jxVN+ljnWK/kGzjNCt2Spr8iRcYbxSL7BpHDmsI+LLvsqdSAZR5eQZrYeiPX1SBxjyv/5
	 nlcjJs9gKHDJ1rLqg6/HC63UnygyAeJvMcex6qzLpLuCSWbdteVnXvvocWFGdsYmkL9wN
	 3UN5wZKEMzmd1zbqBMsc/c13X5awDIojfea4+t1xk5fzygmgMUiEfjPIU1vjGodOZYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mUkDTENG;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IaHwYDG7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDF7606A31C
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 10:54:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FDF7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mUkDTENG;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IaHwYDG7
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA8ZBvq3849764
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 10:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/GvGp0ikRhYCrmCcfVEdjux6pBM8MsB+KXbne/7lAoM=; b=mUkDTENGYogoUsvm
	c5dhKSLCd9QM91OJxfv7P/41BMyzplzxuqEIQ4Jwfu5jYTWHF7U1Al+4NPkDOMmz
	iga3w6m/DQz9x05Hu9jEWUPSVj0DQ+pww6XjtaK4BOzQJUUQzeMDbkvSWP1xCfQb
	0cmmsd+uwojsqcaxuywdQYFC3RKSaQSJySWIjUGOp0+hQz/+wGFAqiNu1IAv2scU
	DT56nbSTh7LM7nsybPDfJ7QOz1+gsMP0gKCTjtD8FAsMH8DKtMf/47ypSaKhclJ6
	Ld69AdFzgun8lHVDOU8Z/NTQ4NFao5unLvq/FfX3ryDlH1sx3lKBGP4vLqhuDSO1
	JmnEcA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huyvwgfyk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 10:54:56 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b0e00d7cc2so1782159a91.1
        for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 02:54:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794308096; cv=none;
        d=google.com; s=arc-20260327;
        b=ASyaLWNBMdAeVAWAyGbSon/gdzQsZnQCOsjxLanZN+4w0ft12RPOt0LdO6VXx0NINh
         97qikSsn84tdT/nJU/rCvvbexQW1RDJM7IlquR+wy5sxo56yd70a4vjgv6h1HRZ+fuzN
         gHnBHIbr93GnIC3Gy2LHdGX0iRMfD2NbJX1n8RJCY6kRG0UpJHBLQuJfmIkve8uHBhus
         dX9xzJuqepL61fRpsLBubFRyS2RbwNEoSi3r9I7J2sqSlA4yoWwXe+ckOOiIqHgRGBQq
         0zuhsObeduZBjxQt1jWx7seZUxaX7wx9SAackKUerUCJ98CEO5GmJhaSDvBEdZIsGne3
         eHeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/GvGp0ikRhYCrmCcfVEdjux6pBM8MsB+KXbne/7lAoM=;
        fh=OJc7KdQDK4xbbDg2Adzmg1XkCho4CR74PptimAB4AOE=;
        b=MDUTKlD5JOPB8JEh+cTX1ntoabtSviOdlqvv+X/sz4DdG1XDAvjhC2jN521RHJIADc
         dCapbn9ZiSJoI9c3zWFWaDM+N9lOx/v8vsgldAYeTSxPD15oukFc7wGPvzldoPjUcTj5
         m7TR8Ovh5FhadVKxU0bWCagFuIOS3pmEPs4W0DqwqRF+VUSNQFQJX3Y+x6QvnTm3TQhd
         kEjZ49P8WXpYnqLhbFsPIP69GWxBEPl3zNFec0ul5Q6njdv7A4RRgB3yGOseegT4+LiJ
         HeTXJhAx3J+6KqbM/yOZT9SxUNMnL3xY1j4k/OB43/avdpl79iS9186W4g4sNgxG0j4O
         WlfA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794308096; x=1794912896; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/GvGp0ikRhYCrmCcfVEdjux6pBM8MsB+KXbne/7lAoM=;
        b=IaHwYDG7Q3f4LH5ftWgBHRO432MqZUiq7xXRsDsPSRomjh+lgmXzS/SCFuVexatLO1
         VfStD4vlV3Wp7FfjwGj+OAgecs3O6ExBVmL5D62WujaZLmrJR59L8ycwalxdik37e9VE
         YO17OwLW/y71W6PCvTNf5L9d648yubIGaqKtySwO7IT5hTcPwMDZu8jlxilU8F7Ap5F4
         GXE7LR6z4wN3VYm77fYC1dJCc05P0887snknN+nMoUqVI6KQq6BfqFsi5B9tIUIeEV/x
         GH5SE+LBGAh5RvWO4gabMukH6Sy85N4T+tvT0BaZGs10QJgVDMAjsiwTEapE9/Di6Q2c
         ICGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794308096; x=1794912896;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/GvGp0ikRhYCrmCcfVEdjux6pBM8MsB+KXbne/7lAoM=;
        b=spAuPVTRgt5bOpQpKUPSRiXu5tmf4DLGBvK3HiOFOQBghyap8z7eL9Vh0VH+3ifhk8
         0N0F/mITuX7QBvAiFWffDe0kLonhJ7A/TRAw5tlWr40TzIQzOlFO9EEjFVjIAgkf/11u
         7A+ooK78SsIxM5Q5wSzX1+/hMqoiRGh5R0zszZNMW17z7efrRdUS1JTyB6azFSFBtKDN
         UZpsGvXvZXjdD/wHZvXA3hYrxQvCKPgTMEWjHt9hGwrJUuSrEAIuB8pH/dcmqPiYpCRJ
         pSdkN4HJb3JYVPdofp7KuVYUxDjgGDZuW5j74Bxhp0PC/EDwFyindhx44GsORvvG3NQR
         W8mw==
X-Forwarded-Encrypted: i=1; AL+hErEHvA2vXHF4Aa077xQtCtHbTa83wyPPxciLLCxXqdjL52XIAYjOZBvAJvnSjv61Av431uMdFg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+nqQFVsWknHSCFxKLd3X/tCeFIevc0JYdfn3DOBEoEUHw7s7XG
	6q+ILDWFYNXOf5xF1CJX0osRDtvhDgrHQVTQCLp8oGV1q8Fza+6YWtODw5vZOoAnk1OrNQUJfqz
	MPUzQ7stATyY66LtyzO4tYeYKOC3szqRXIVYXEG6XeSRl959NugA5/r2sIFluUKypJuA5kt/f/m
	N2wQsAcHeTTuLI9UlmMafFi5JePeLGBCpd
X-Gm-Gg: AYBFou3bwJc2Wboua6P9gkfkyJxvDc6+g+Uq6BSk1tj1w8B21loSjq8h7o5KXZLj0Nx
	+HwZ78S3mAVth51nkfAoJTpu/wcRbOZFj6chBv/nuePLm2A623aFbqdKQ6pqso07496iHmY0cWN
	7BpHE3jAaeqpFo1lFhGHoNRhpZkrOZ/Z2f5k+/Ql5EDkMiuCxpjWCzbF/srw==
X-Received: by 2002:a17:90a:e7d0:b0:3a8:5fd6:cb6 with SMTP id 98e67ed59e1d1-3b166a5fb0bmr2419102a91.0.1794308095847;
        Tue, 10 Nov 2026 02:54:55 -0800 (PST)
X-Received: by 2002:a17:90a:e7d0:b0:3a8:5fd6:cb6 with SMTP id
 98e67ed59e1d1-3b166a5fb0bmr2419092a91.0.1794308095395; Tue, 10 Nov 2026
 02:54:55 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261101082307.151957-1-gahing@gahingwoo.com> <6777074.j6PcuT4dK6@diego>
In-Reply-To: <6777074.j6PcuT4dK6@diego>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 11:54:43 +0100
X-Gm-Features: AclHuK_tfQs_KED6YGEFdDQzYeq154VOUvxzh1aCGwTqlSdSoloobK9cAe7e-pc
Message-ID: <CAPx+jO_gRtipR7iuh0D7G2Wi25GZoqFD1JHVbJNmhd1UyC3Bmg@mail.gmail.com>
Subject: Re: [PATCH v15 00/15] accel/rocket: RK3576 NPU (RKNN) enablement
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de,
        ogabbay@kernel.org, zhangqing@rock-chips.com, royalnet026@gmail.com,
        abel.vesa@oss.qualcomm.com, sebastian.reichel@collabora.com,
        sidong.yang@furiosa.ai, u.kleine-koenig@baylibre.com,
        chaoyi.chen@rock-chips.com, diederik@cknow-tech.com,
        alchark@flipper.net, leonard@lausen.nl, jeff.hugo@oss.qualcomm.com,
        rfoss@kernel.org, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, iommu@lists.linux.dev,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 9ybf61xJD_i08TUHKtQGDJ89M0y6EgCm
X-Proofpoint-ORIG-GUID: 9ybf61xJD_i08TUHKtQGDJ89M0y6EgCm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA0MyBTYWx0ZWRfX5AnqdYTVhzex
 q8dacKk8Y9ux1F6p2fxoXwMzlFNX8kYgRT5v1zM3DZ6zYsBGHBuf88xeUh5kLvFQCb8LfgfQRfS
 XCNI4356LVbu7JNWksO5gaIRlTqAg5M=
X-Authority-Analysis: v=2.4 cv=NNpAaE6g c=1 sm=1 tr=0 ts=6af2f800 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=HKy5YsogUvdA2KhsgGYA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA0MyBTYWx0ZWRfX4ajdTvc//PE3
 lGv7ZIfpZylaxHBqecDYavENsK3qv49nXl0prwr2yii8FRgMhGlZ59DCl46sVFAeOpjkwI2jlNE
 xKVamL2a0j8fYkoBwXIoTW5arG2A3aT5V6pwKX162p4pHvlQhPAwC+HVYp66IbB28lSQNPhUQqz
 6g3SxkJXLxGsuuJJym2fqmwsYASXaW55Gdv2PFoISy+aJL0IhPei/c18/H87B4wI/Ko22R/HmkF
 OIsGUH0Qlsx4rfVBQoTOg5RbBwDE6m6NxfjDhQfccE+G1KNNRINhGVG4yGzWGrcMo18bl0W7cwy
 zTZSdgpRkQi4C+Ddi3yj7zNdhbjn9Hh7wGhV1OdPTvi0woXDXIawAPuhioEzKNEig5NPv0rqoIf
 ltRV+C88J81G+A82/ggBJcBnYY83qGIiaqn8jcAH72fhFPonuabmFyxbVkYQfRUUeBvv4RKqUkW
 mUDcAo6z7kJ5MY79mRg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1011 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100043

On Tue, Nov 3, 2026 at 11:39=E2=80=AFPM Heiko St=C3=BCbner <heiko@sntech.de=
> wrote:
>
> Hi Ulf,
>
> Am Sonntag, 1. November 2026, 09:22:52 Mitteleurop=C3=A4ische Normalzeit =
schrieb Jiaxing Hu:
> > Ulf offered to take 7, 9 and 10.
>
> I've now looked at the patches in question and they do look good to go.
> So it would be nice, if you could pick those up, when you have a minute :=
-)
>
> Thanks a lot
> Heiko
>
>

Patch 7, 9 and 10 applied for next, thanks!

Kind regards
Uffe
