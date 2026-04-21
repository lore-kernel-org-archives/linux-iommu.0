Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A4C3D1CB2
	for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 12:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776775977; cv=none; b=kYTT8FvnAxnQM3AB6JYMfFT3ZwWmO5/5pwkDa0DSdsJBNz33MglHM1L+bEYHSC+AvS+gOPw45c4uK15aZEvRPzkua5L2r4dZJzzWXi0sVDAvJCHAhgVuUJVnSXf+Fy10kwx7YU8MbfKVubsQxoUlz6KSRdUl6C7dNixMluGgw2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776775977; c=relaxed/simple;
	bh=HH1NNtZwFd250kpA7uXnvCLzi+RUfrTgM9xUyAAcOSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bEvxi4Od7ifWqYQSSq8We2Poz4K9z2YcJY+ywwdh2nyTgUKe6VrwqraCiDw/5i4ww/CKjJcCH89cS5CiSFPwpEimcKD1aoiyzfavPdFvYY3XDGAQv/g8U41s5CYXDEzEWGgdZ5+yBmC7JK8mha4/Jjr/F6dVrl0Vdp9v5U23vYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HGQrkjQW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b54meXZU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HGQrkjQW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b54meXZU"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63L9RSLL046227
	for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 12:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	irJi8OzHDR6ei5r/Ez62ynMGGPCuv+u/Q8dfmAXThhk=; b=HGQrkjQWlenfTVtX
	pCqIWiiEnA7cZUOjOC9uUwJQmuaKF5Jtgah8UKK007j442R00YN62efkAO80hpY9
	FdZp6fFQ0oRI3bsd36baxehwdOqJqBOvzh9NeNWXzThMhe2pVZFRzTq7DptE+uUi
	aYDD9hVfNbp1UpF5C+zC7IqKlkwxYEAheBbQ4qbeUW6D97wEbT3N1TwuqfVJA821
	l7UhC+3S7eA32E5CyAt/GAEHngk85T57Nlr5T/+bZjO8JEQa5zsyLeEWGcgmypYF
	cqYnpoZ+cv9D3iLcJTEz3QF6PnGnbxS6EMst/V/4/h6gxcGjUKQiC4bc+oIVzHsy
	VTkHVQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dp0y1syy7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 12:52:54 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50de6db1eabso10100621cf.0
        for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 05:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776775974; x=1777380774; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=irJi8OzHDR6ei5r/Ez62ynMGGPCuv+u/Q8dfmAXThhk=;
        b=b54meXZUYuHh+w1VU7O8+zGOv8ZarfDFPxUJP1bAqLoCaPyFjIvqNxESbh5KKBe8eA
         by1qaCw/Q1r3cscLYVsebeFJbifIRtj7h/B25TloBMrB1JyyI9J5ufSjkXXxL8cKiqYj
         cmBn7iTHQii9s7aTAkdXNl61Ozrmxi53i4ccYtuhqRgD8boGa4kK8EiXD6XCGscYbFV6
         key2GRPBIwtW7dzdqMjr4xoiwTK/9D01SWlBoRtOl+1yd8UOF0mVkLQ0S2KuFWJeQuqR
         70BVqPP6RadphHDlzW4psqYtZQaRnzXZmq+fuLwLvQnhvnIetdwIjiJNbMSuzyOSiHn9
         WssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776775974; x=1777380774;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=irJi8OzHDR6ei5r/Ez62ynMGGPCuv+u/Q8dfmAXThhk=;
        b=jt1xIddIiuZbVbG5d8d5SM9ct/IvaWRm7MnlN6rCm6JJRpUYIAWjQDTlXhS+LokXC3
         p2qE9+9yCQNWosdoj+Th1OLP9cDhSuExC3vc3l68ETfc+riULeKrdG8Q1vzRCvMORyPw
         8ZUxcNKguOFsQd3rgxwv+0LiF2KdO1LHcV5Hj//cpFBY9DtZLVneGMqXFz4UYrdo8OsB
         /H7T8BPAUYWim9ORnqzu4l0rQDIOXPrIxvGerl7rLukrFSxePgn99HqlYeY1ISt0dM3u
         7SYKkKfMjJH5YaU/hbFOHzCwwpZkO1/77QTlv132jXLQnqfgbyO3nDf+e55F0y03cTMY
         Dq1w==
X-Forwarded-Encrypted: i=1; AFNElJ+BUwxYzwUYX5ELgEqdFr71TM9Ml2KAdo6XKKeAMa0/cczRy5YBWn7segiyI/XMeKt6OWiLcw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJu52cb6FlGJzNGNEWiDznag2odlETwTTcjGp2GS/0Pz20aK1w
	DQJIGEtdYbZzCYTfA3rq+sHqZMBpjB7qqsYHlRp83Rd+ryi/bkkqjLSlsYtwYxzAA85u41B3/+k
	RRZQGJJtDJNTvj1iDxqMNCJljvmxICHorRV/0AoDFjIicQa9jUWJT0q3SOw==
X-Gm-Gg: AeBDiesFoODRdfajTTWSVBtUH5bz4Ezt+HvoPOPAXgXb5ukmQAgUDq2YwRYl1qg2+mM
	z056vzRjRbUmbKa5wUPiJ0G0opujKiiqZOzjKMngD307DC1yubnkzUqctkdV/sslDN6T+1PvM6v
	Bn7oOYKIEimK3fm40Ecan648TKKDyU/NTj9lz07ZctDDKsK7IkiExf3ufN775+M3+2ftZ/iK5GA
	lBgHzA///5f21HH/aBUY0GpS5NyPrVm/ljt/HZ7nsXYO/NHBoy6WAA74d4V4fJrtjSnxnFLx1nl
	iW7kwicdIX/eoM+vo+hToFeG98DU3UAiDR6KCZKmMZK/gjO1/njTISDUGa8JsGf7q0yFwMb5VHz
	8Z5VJHzcS6F3nVkrjK2UPHoQ07Py967E56OPsUAFQ7hU7uqVuPDFvMhRvxc4EcjtuTvMUb87tGz
	r7Q9TTLvsQEGZ6DQ==
X-Received: by 2002:ac8:5741:0:b0:50d:ec32:b84f with SMTP id d75a77b69052e-50e36c12a00mr165757421cf.3.1776775973942;
        Tue, 21 Apr 2026 05:52:53 -0700 (PDT)
X-Received: by 2002:ac8:5741:0:b0:50d:ec32:b84f with SMTP id d75a77b69052e-50e36c12a00mr165757131cf.3.1776775973511;
        Tue, 21 Apr 2026 05:52:53 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba451210e1bsm444593966b.3.2026.04.21.05.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 05:52:52 -0700 (PDT)
Message-ID: <023375c1-d2ce-472e-8a82-1cb013d31de7@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 14:52:48 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] ARM: dts: qcom: apq8064: Fix USB controller clocks
To: contact@alex-min.fr, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Guru Das Srinagesh
 <linux@gurudas.dev>,
        Linus Walleij <linusw@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        iommu@lists.linux.dev
References: <20260421-mainline-send-v1-sending-v1-0-bcb0857724de@alex-min.fr>
 <20260421-mainline-send-v1-sending-v1-6-bcb0857724de@alex-min.fr>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260421-mainline-send-v1-sending-v1-6-bcb0857724de@alex-min.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VNLtWdPX c=1 sm=1 tr=0 ts=69e77326 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=YCWiAI6G9GZrcvXlVdoA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDEyOCBTYWx0ZWRfXw4ilsfOwenbE
 Wz//iWv4+Ou5EtQnfkDCalb/fS6OISh2aW9xbdXl3pHJ604IsJfMPiUTk7LUULv6jd6ieknofOf
 PiGzAU12n11ouvxzXWqgR9ZfcHfylbudDYMzNpWMyqQNIn0d/iJ6vEN5+/kfm94z6lbuRmRltrI
 gwar8LR/VGRDVY/4F208lYDvBYA3807jHyADJE7x/zCA/Iq1APLLGTgbmAIp8DN/0j7Roerhzs7
 LQV+Mp/hLzooJksnSikU9H9GjfH7WluTKqkH8cbeeHz2RjWrNkp7JSM8EwEnwxgkRuP8BzSN+BN
 GHw1rF40DxzX36rIQlSOp+XuvF5dBow/Fejsg3poiyTWpBwLsgiaeWkr8TGh4Wp5s2Et16rEoea
 4JrCdUkuhdxdaCXXwa6+03Y3BQIrtkBnLfbdCC8zM8qELLHNDQEwOL0AL04I3md+SI1yIi4U7Z1
 ANtay/mU3fOlCaDdi1g==
X-Proofpoint-ORIG-GUID: IOmCGXVU2q5dA_ybXpXneMzuJ41VI9Gs
X-Proofpoint-GUID: IOmCGXVU2q5dA_ybXpXneMzuJ41VI9Gs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_02,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210128

On 4/21/26 11:45 AM, Alexandre MINETTE via B4 Relay wrote:
> From: Alexandre MINETTE <contact@alex-min.fr>
> 
> The APQ8064 HS USB controller nodes describe the transceiver clock as
> "core", but the ChipIdea MSM glue expects "core" to be the controller
> fabric clock and "fs" to be the transceiver clock.
> 
> This mismatch can leave the fabric clock disabled while the controller is
> accessed. Some boards may tolerate that if the clock is already enabled
> elsewhere, but it is not a correct description of the hardware.
> 
> Describe the RPM Daytona fabric clock as "core", the AHB clock as
> "iface", and the transceiver clock as "fs" for all APQ8064 HS USB
> controllers. Without this, USB does not probe reliably on Samsung Galaxy
> S4 because the fabric clock remains disabled.
> 
> Signed-off-by: Alexandre MINETTE <contact@alex-min.fr>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
