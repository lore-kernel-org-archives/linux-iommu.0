Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34563BB9E2
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773416419; cv=none; b=mv2wbeEbnLo4zocV0oZC1MhqE9m7uDunxm0y2m0Bdi8RwYiniZFxe0eic5qBb0o09iVkumPBEVTj9bqXGmAmeOLEeDxZT88CaTrGqcU7Q1xx35RfnBPRBmi8HutT+vwqbga8Q24Lh3IwQy9HflQs//qMYLz/YE/IellT9nWPdy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773416419; c=relaxed/simple;
	bh=8eAD5+AQ3R7FtkZiFl6yFdLyBJ3YLRD/s9x1qQ8mMX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p75D/pEVIJYL76K/PKZXgzrIngP+W5i1m7v5cPC1/TRaHIu0ByWYu2YBCqRiGjMgd9Dh7i2+yG7d0B6cq0yIh9eOvzhiYU/dBUNMU2fal5aAymwJUTauxmNDyPRsvm+M6IKWVO1ucORVrKWe3AXhT3oeUJaPkA2j2DaYo2HBRWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mmvqELhc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YEPwCP9j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mmvqELhc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YEPwCP9j"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62DC02b54140725
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 15:40:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=J2vru/Svx1Am2Mr3sn19MOmu
	aJS0qSOIhqRt3IXkXko=; b=mmvqELhcgTujbz86e0tTmm/p6H4WSschqPila+J4
	er+KacyDtRhxABU04pZio/1qIDfQ1AOgvioT39IAvUacxqM8uIkYCoetLKwwHb6y
	TQOkp/pQ7I24jWirKzfHKpllH9O7kt+73BxdbGQUBJ7NxzcnsR0xZIuLZ72v5rih
	hLloiLHephoLyQjFXrAimDYtRhPNT8g4YCdMYQgaBEFxLM1HaXYWe5V2A0CZbpYF
	NqRBe8gK8/oJlY7KFTGygcOq+OFaSrag+sLqiX5sKKYZ+w000qViA4Xoa7/cNI6A
	mBQ8U+vmK0/Fgeykm0ND3PCfYpMn8puJNO/tZ0pLjNINxQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvbn2a76f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 15:40:11 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cd77e5e187so1276202985a.1
        for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 08:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773416411; x=1774021211; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J2vru/Svx1Am2Mr3sn19MOmuaJS0qSOIhqRt3IXkXko=;
        b=YEPwCP9jM3vJE5RDzsEZe1rO214rT3AVrPiYLEtKLXGjnC+7XJFUFGKmDVYlr7HJsI
         A5mgZvyn/7aSOPx+VRztiGUEDLcU4o821Uf6FR0IgsnMxyilHlVpXVcI9ZmYKtKIMUjg
         Ipq5RCdNsG8/kOA+O67iN+bMVHSOdyYRbQWkjVwPA06p/XSevrv6K1N5LOZldEF2yC/G
         J6K2BZhZ+tzyW70PA73BbLme/E0K8AP1/NBDp//pDossxYSWuymQxV4LKdOW3Tuq6d+C
         eeIEhcle+abGyDPVDF+3NchL5mgi9zGPOgtJJaM+MmIwssIBZJxtPG/Q+FqgrGxo+4Y0
         9CTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773416411; x=1774021211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2vru/Svx1Am2Mr3sn19MOmuaJS0qSOIhqRt3IXkXko=;
        b=pAwPuEhUJLHSB2DCHDYc1rAN2um6ZDjSR6SZkvrS6btHiVFGdVUnLAPpDzfRyK83HZ
         jP82jo+tLyED1vQkQc9tsh9DUXfroJb04qLtguU4Z/Xy9h1sX0CXm0V6UESatOgT5CET
         PEGk+aSA8V23Ep/1oSKNj/n1zMsYaE3FW2E36mC/PJJpxE7o3NcO5ii6oTL4SSRzf1aH
         U2aScJgRQtvPjECpXOVE0WszGHQd/zgXVz8YTzogwDfwL8fRGvQErfbxdLeW1loz1XkC
         5YUncm+4d+9hBi8yEGaEE4TKpFKBJANWPQjcSpbnAq+4eGnOcD6InxeGKV6BnQV7FyXg
         tnYA==
X-Forwarded-Encrypted: i=1; AJvYcCX9pelY0WLrXID6mIfcwsAVDS42L8pgpGrJl/ur4bpt2nV8shEv1az6h4rHc90rIOuGQWGuQQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5cq3YgLmjZh/piXLkBhhhmZAi4bPH4W8XP3yi/sF8xHkLc/pC
	wUc56JPR03TtOIGNWraohXaoih75osJhB8YPM74+ZeHKuhWQLEsVtb5F5yiuRUH1zeBrVbwgbzb
	kNZyqreyOeUPSUx+JdLcsY4vnNcKl3+eyOgFUGJNkUDtsFZaQZ5U5aJu/zw==
X-Gm-Gg: ATEYQzw+sUpUGSmRCeopGjx3w3esJBImKrAoTk8SJbCyfaFtnXyqU9agSBDNwlKojdT
	KJCo0Fp5j9w7GAtP9yMYAEE/xlgLlKfabE7qY3VTkHy/UhIW+tZYXhGghXL6dGwWwC27rZw7aCo
	4uSds9sGPa4wiCXSgn9l+1EqbxMqVIEVjjSgTy7FwlBErxw1sUt3BkkM4Tz2ciHoSS0J4WYbeqr
	jeJz6BnyjwEy4BgJU89vDGBFuw6EVnilv5CLCCQO32K5Eeh+TrN2xMDjC+hZj05IEC3gxPr1uMP
	RmPmQt+XHM75WOnsu0I4ywK1pYyTlp1pxVX3U+5uYQtND2WARYiQ+Ew+j6uKijQVJR7MIIa46Fe
	epJJgvh5kWOBM9gpVD8fEYq/FvNU5Rd1DQSm3Sg8KPg3FTwYfSnEh/aTBB/Sr3tulOywdpCLXoC
	IEckKrVMbO+E361yNS8OKKuA+l9fdUUA/trGg=
X-Received: by 2002:a05:620a:269a:b0:8c7:fdc:e87c with SMTP id af79cd13be357-8cdb5b247c7mr504831085a.51.1773416410651;
        Fri, 13 Mar 2026 08:40:10 -0700 (PDT)
X-Received: by 2002:a05:620a:269a:b0:8c7:fdc:e87c with SMTP id af79cd13be357-8cdb5b247c7mr504823285a.51.1773416410042;
        Fri, 13 Mar 2026 08:40:10 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a156377cdbsm1537814e87.92.2026.03.13.08.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 08:40:08 -0700 (PDT)
Date: Fri, 13 Mar 2026 17:40:07 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
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
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/7] media: dt-bindings: qcom-kaanapali-iris: Add
 kaanapali video codec binding
Message-ID: <5otifv465c7duslmogb5uzaxrh2k3u2ayiylcd6dnz3kc7win5@kltv3fxhtso4>
References: <20260313-kaanapali-iris-v3-0-9c0d1a67af4b@oss.qualcomm.com>
 <20260313-kaanapali-iris-v3-1-9c0d1a67af4b@oss.qualcomm.com>
 <hfuqu5uwjuh4ie55zwaqqbsflhf5yn55hnjva356nivoq46m2i@o5pkjnfrwycq>
 <62027e78-4b7a-4b94-a51a-13a9ae77b722@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62027e78-4b7a-4b94-a51a-13a9ae77b722@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: opJss7r1Yrf2chWclbF_xI5pJn9K5vof
X-Proofpoint-GUID: opJss7r1Yrf2chWclbF_xI5pJn9K5vof
X-Authority-Analysis: v=2.4 cv=ZKfaWH7b c=1 sm=1 tr=0 ts=69b42fdb cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Ni5EwOkUcNZy2ZnK61YA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDEyNSBTYWx0ZWRfX2jFSfT5f0eCv
 7JGNQ0+KUKBCLfQLn8/2wc1txiWevS7nqAdVqbYYV9foa69sftYy9m87YnEY2MVueT2DbjXZAmn
 oU/Qzg33Pv4BfvO7yS31xPB0bXMVjxN3nR4wrPk8q7bXJ27Ac0Ybuh7UI4LrqhNFXr6AkQf35AJ
 bLDYgwWwW78FN9w+CuQ2CJLboNNnMjDcHUW17eytHTY9Dj++G8wPgj50k6IaVZcqE89BSBssSy9
 3fHZ0TDf3ZjTRcOwZIgofH2FNWazB6D0v7jSE/6VXMuJvXb8I21oVYCQyid412mNUDgfVRlIvz1
 xKNtXLJXVxg+NaLuul0txv25HUJTKTUz5toFMezYHJ2i19kQztznkncwlNoKd15z7SFpma1jZFk
 D/sEj4eg0Uu6g1Zs9xefKx+TSTZaK7WyPAGuhatLUcU/UFw0amogAf7XJfD0dqrxHf9DTc5pz7L
 yvKMijKT1wCbtxNcwXQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130125

On Fri, Mar 13, 2026 at 08:46:52PM +0530, Vikash Garodia wrote:
> 
> On 3/13/2026 8:32 PM, Dmitry Baryshkov wrote:
> > On Fri, Mar 13, 2026 at 06:49:35PM +0530, Vikash Garodia wrote:
> > > Kaanapali SOC brings in the new generation of video IP i.e iris4. When
> > > compared to previous generation, iris3x, it has,
> > > - separate power domains for stream and pixel processing hardware blocks
> > >    (bse and vpp).
> > > - additional power domain for apv codec.
> > > - power domains for individual pipes (VPPx).
> > > - different clocks and reset lines.
> > > 
> > > This patch depends on
> > > https://github.com/devicetree-org/dt-schema/pull/184/changes/d341298d62805bc972dfba691da6b3b62aa3ff15
> > > 
> > > Nacked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> > > Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> > > ---
> > >   .../bindings/media/qcom,kaanapali-iris.yaml        | 254 +++++++++++++++++++++
> > >   include/dt-bindings/media/qcom,kaanapali-iris.h    |  18 ++
> > >   2 files changed, 272 insertions(+)
> > 
> > > +
> > > +    video-codec@2000000 {
> > > +        compatible = "qcom,kaanapali-iris";
> > > +        reg = <0x02000000 0xf0000>;
> > > +
> > > +        clocks = <&gcc_video_axi0_clk>,
> > > +                 <&video_cc_mvs0c_clk>,
> > > +                 <&video_cc_mvs0_clk>,
> > > +                 <&gcc_video_axi1_clk>,
> > > +                 <&video_cc_mvs0c_freerun_clk>,
> > > +                 <&video_cc_mvs0_freerun_clk>,
> > > +                 <&video_cc_mvs0b_clk>,
> > > +                 <&video_cc_mvs0_vpp0_clk>,
> > > +                 <&video_cc_mvs0_vpp1_clk>,
> > > +                 <&video_cc_mvs0a_clk>;
> > > +        clock-names = "iface",
> > > +                      "core",
> > > +                      "vcodec0_core",
> > > +                      "iface1",
> > > +                      "core_freerun",
> > > +                      "vcodec0_core_freerun",
> > > +                      "vcodec_bse",
> > > +                      "vcodec_vpp0",
> > > +                      "vcodec_vpp1",
> > > +                      "vcodec_apv";
> > > +
> > > +        dma-coherent;
> > > +
> > > +        interconnects = <&gem_noc_master_appss_proc &config_noc_slave_venus_cfg>,
> > > +                        <&mmss_noc_master_video_mvp &mc_virt_slave_ebi1>;
> > > +        interconnect-names = "cpu-cfg",
> > > +                             "video-mem";
> > > +
> > > +        interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
> > > +
> > > +        iommu-map = <IRIS_BITSTREAM &apps_smmu 0x1944 0x0 0x1>,
> > > +                    <IRIS_NON_PIXEL &apps_smmu 0x1940 0x0 0x1>,
> > > +                    <IRIS_NON_PIXEL &apps_smmu 0x1a20 0x0 0x1>,
> > 
> > It think we still haven't settled on letting iommu-map to have several
> > entries for a single function.
> 
> I have described the hardware aspects in the discussion [1], if there is any
> alternate way to handle this, we can discuss in the same discussion.

Yes. But how do you plan to merge this? You've split away the patches,
they don't seem to be listed as dependencies, etc.

> 
> [1] https://lore.kernel.org/all/21fda4d2-72e1-4e5b-aee0-a799886f53b7@oss.qualcomm.com/

-- 
With best wishes
Dmitry
