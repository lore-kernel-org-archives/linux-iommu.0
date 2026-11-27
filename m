Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795787928;
	b=mvCQhj/dsXBBlFsvrdBBXbdG9v9D5vvvTh6Gj4sVQye4XMVvpAvGbiuvZV5m1o1kTlMG
	 A59qkHFQUErcCuvWdOHsLhTkGQruEfa+AIjGg9ljEDgwqfVz5Z38PqVWYGoz2X/FC90Kq
	 0g9gqcYSvAcBOyLMarilxrRE1Xrxf6eavwkns1at4LrBS9+sUTLMjv8D+eOT30RfssmDA
	 qJII/yOBgB8Sylhuyvzjx3tdnSJ/SrzvCuN9P/wvJeOs2tcutHVN3v+OEmd/aP3TcV1Y6
	 YX7jEipvcxvws1Hy+vJJJF21hAkhX10uM1wwWQzje/D4sRnbHH1ToIiZZrzj/nedlIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787928;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=1v7qWyLIaLArgF+vLRv6x7RBzzWwcYRuKaCCg84dQ9A=;
	b=Ey2FVvARLPdIVfAPt1UdC1IJ+4Vkw1UWFFGtvrUJ+W83cvjeNQhapOSnNFmomPN076JJ
	 DLPWMr6jRFougvggA3KZwie3RX7HmlPk/fO3QqXRaXUGnw1SYi9lwMFGRGhu6MeuSKFVA
	 RMPBUjH56s9u6oGOsMXDtbqy68zGWiMq8+g2vyRNDGbOZ5qEperj0TaDtUn4hCnOlk+SU
	 F55p/PpL0ncsS6/aD3oI7TwrY0r5Nn4kG223o+dSfo3HNhTCGZRJ3Mes2HR5dc/xaxJTx
	 0crgIWWVd/W5yWHbzdZN7w5Oow9mwl9Td4ULOokgA0ycXWpJrTJ2DHxXOPJr3YIcFNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TOjcsKcu;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=O8s3oMt4;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C7D606A31C
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 13:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29C7D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TOjcsKcu;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=O8s3oMt4
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARDtwdB3309562
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 13:58:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1v7qWyLIaLArgF+vLRv6x7RBzzWwcYRuKaCCg84dQ9A=; b=TOjcsKcuDkQqhKEM
	pY+66B0jBD0y+w2WuxCnqNyxwYqmtuMoZrTl0cJPLd/mTTklLplbhyMHb4TC5Wtq
	Ji2Qk2dzyLEh2cMIRuDPdYHqZpE/N6fX61D4TPWfBAqekwTKIPscpXnW+mrJEX1g
	T67dFtRLf4IjNGcPXVhIvoHFM1MztDlxyVpCMHvcXvYw2hHwPLywFmqnznbL2nOM
	sz22SEUOUEnjiVdwNO2bgpnoMVFCLggMv5jNCcGehEEubP3PBl+8lUty7whgbc4y
	8od1uEnUK+wQdjbAqIyVdpYI0rzoM6UghTNlC4hv0RttWqdHeAoj6pqD+rHn22WG
	zHDzIQ==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6rf93tp6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 13:58:47 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5edc82ecc78so345988e0c.3
        for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 05:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795787926; x=1796392726; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1v7qWyLIaLArgF+vLRv6x7RBzzWwcYRuKaCCg84dQ9A=;
        b=O8s3oMt4bURO03RtUnuLnukcmwnltU1W8Zsr+SiX4mwjGXIIojQohVPNzkf/puneme
         IsyisPjvEFIZYSj4r0FIRUP05t1Mlgw+LATHM9uzg1XiJNRXyfWgbCWumdgHA/2jnZAS
         3EzrlD4wuj1akAva+tWQwySj4NeBdkYqpzKhcWY90qGSDfL5aAfZevuAXFTd64y6AAA/
         cyyAJ8VR62WTtnN73V92iUJgi/nL1x/GIO6f00N+HPr1BI/Cx+JXOXaUoTRILxXMQ2w7
         Gxhd2jE6AOe8J1pieqbz7ynMIA/TZXnze+tDaJglMSpWGR9VHFvi7HDTQQ5fHrkkDvtQ
         Fh2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795787926; x=1796392726;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1v7qWyLIaLArgF+vLRv6x7RBzzWwcYRuKaCCg84dQ9A=;
        b=h4wp21FiGLVSRECIYl2S6Y0NLDfFD9d1IefQ9lt1yWTXPY8IkgSV+MNvxs9d+xhr22
         wPaSXiaKU5K7thjArQD26bKjmer+MbOioetQOaICNM1BL+VqmUZyDIBXRoOVSBzVs7H9
         dvAA3n5v1xHopjxZ88t+uy2hEVR5Frd2kh1Qdk5rqfADkiKVw0OES+qkRi2cE2zXJAsG
         S188GmfZxXiCSNIVPi5v11LfzmfVcL1aA+kz3nRKrruRvgtIdu2T8T4THlJ4s7xZsAiJ
         52CjsZ3uiysZ1hr7SAv9Dg6QO5J4wjVcRv0/ZVl3uJ9pQPUI3gs144UQrj+zDl1L6hq9
         hq4Q==
X-Forwarded-Encrypted: i=1; AL+hErGEGGCapvmTKfETQtd3u2ZZMybXFc0REsmYumcJahFIS44lkbF5IBcG19jeXcuZdjHTWSbtOQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9w7CYD/0Cj+sWTQqFk6xcOSCVGjPP9a80Eh7btDdDsTVhQsEzf
	3wYSBUshaQEPuoHHqagRjVWWonfdHxGwxqJIzXepXZm+IaTIpjI/yrwALK5NHBkpEWdRAHV0E8E
	CY/3wVhE2ehPfH+z3UydDj60N+F46Q6K27vWqkJR9vsxAx6BIgXGuaby8FQ==
X-Gm-Gg: AZFdTZeKbzo0jEhH4pN+Z/RpiZMp3ykrXMFTVYgndQRvPjehv2l8MYhUPEOepO2ecU6
	Mx6pfXkU9NX/UJ95sZToJ6NO8qZDO+rWT++D3Xlz18dcBHGFhcgHAAZA06GtYN/U0rBef5NVA5L
	HipGxMzNvZpNVdx0HnQdP2pFY/VM82oN5Z5lmFCa8NN95fJSyAyXb3iZ3JsUDZlh7DHTKC+k0OA
	aHZj2p/wU7gZScn3NOMC4eOVLV4egTgTx4vWHHcMoSmRSYPwmijI/SRYW1tuQZ1V6ymWh+0bFg5
	r+Ac3afDcZYLY56dzk16umE4dfqnhfmdQB+3YAAQWa9iysaM5p1g3w+AVnOe1wGlHcEH9U2PwbC
	Zsvvr7Dms82yUnGUz2DlPpbfzbL2GjNoGjNuPOMYp5Nd/Ng7J335H31sMOwVYvq1X8WmE5I4=
X-Received: by 2002:a05:6122:c2c2:10b0:5ec:b706:37e0 with SMTP id 71dfb90a1353d-5ee8ae3e277mr16434840e0c.1.1795787926279;
        Fri, 27 Nov 2026 05:58:46 -0800 (PST)
X-Received: by 2002:a05:6122:c2c2:10b0:5ec:b706:37e0 with SMTP id 71dfb90a1353d-5ee8ae3e277mr16434775e0c.1.1795787925770;
        Fri, 27 Nov 2026 05:58:45 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba37109b55sm10578803a12.32.2026.11.27.05.58.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 05:58:45 -0800 (PST)
Message-ID: <87280d80-9047-405b-8dcc-11276d34d2dd@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 14:58:40 +0100
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
Subject: Re: [PATCH v3 14/14] arm64: dts: qcom: Add Samsung Galaxy XR
To: Stanislav Aleksandrov <lightofmysoul@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>, Bean Huo <beanhuo@micron.com>,
        Stanley Jhu <stanleyjhu@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-usb@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-pm@vger.kernel.org
References: <20261125-halliday-dts-v3-0-5c8311c0b70b@gmail.com>
 <20261125-halliday-dts-v3-14-5c8311c0b70b@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261125-halliday-dts-v3-14-5c8311c0b70b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: -LwTvZGtCuz9llQ88xfCuC8djxrlITmQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1NSBTYWx0ZWRfX6FhtJgIipy/k
 iG+JvXV//kt4M+AqIm3A5ueZDpfyKqxSEEkZ+CLEOyIhJGAdOVTDzs9kx9l1CVjTf1cZK5Q9QQi
 ftrlDVOvZ7dFpvCOhoutQN7aGWmvBaXwm4qqjnfxGSfAfX6neKV3f5sOa/1I5ajWS3z/6s5YqhR
 D0jF71s3ExobbuoBOe6ysG+hsTWQJhqpc3YBLVzPjZYGUTDWun1B9gzAH0pcLT16dgIv7DzgC3v
 Yer4S4nQsmctzO5LmMZYkdortDOrOGKJPMtRnT/MQlx3DQyOKBk1wWdL4aygJ9Q/3vRyR4XCp0c
 HQJklEFvnzvmayTVE8l8Oh+SERn50WLsmkR3AvpS41Z6EMK+cZV8C+wsi4X21P2EnTRVHKid3Hq
 fNMtk+nqKsyulJY+w/ZSrOmHfkeK99TL7QMKh2Dwr9FRVyNVNItIsqwYS0L7AVLmAHO4KQsBpTI
 OF+acEwFrmzn4hnaXAQ==
X-Authority-Analysis: v=2.4 cv=cpkOAF4i c=1 sm=1 tr=0 ts=6b098c97 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=pIfNyjNAQl_vEFP8Sf4A:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1NSBTYWx0ZWRfX7ia/eK6hle5i
 682MSzbUGFZQIPylwWmnNSfMA+cAa2BCTDJBL10LfXKpPQsm8SFZa86npkLfo00Nqu0CC1MKB9U
 eNquelZCgID/grlT6kSHPeSwaW7PNJU=
X-Proofpoint-GUID: -LwTvZGtCuz9llQ88xfCuC8djxrlITmQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270055

On 11/25/26 4:43 AM, Stanislav Aleksandrov wrote:
> Add the device tree for the Samsung Galaxy XR headset, which is based on
> the Qualcomm Halliday SoC (SXR2250P).
> 
> Supported so far: the PMICs and their regulators, the power and volume
> down keys, USB in high-speed peripheral mode and UFS storage.
> 
> Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
