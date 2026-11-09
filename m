Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794230317;
	b=MNnjqU5aCJxN7zFS4HQf66baK7AEoEHgha2NLCh2mGuWROA6THc74am3xI2XjOnzsHfE
	 eeiS2def6F02cdTKtWNzn00uik1OgJNR6rkXlow7jJw12TZjmbqPzg+NlNYSsh0y/eZgm
	 bORl1sl4CG9L88lfdGPRynE9DWw73Lc3MLj8LFRVw4W4PlBY1N2XZpLowSh1GkL9brZB1
	 gb6QOIINsuqhw4FGSryXMH0aQHcYN/wWbRdnJlGycUzPD7FixkuI0CPwdjqDyahy5Vbjx
	 LZqczMfmHmUShdPXAJ1hBUudc2EKfXuOgEDc8tQ+xUGt5ymwgZii4FakoMVyRE7Heuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794230317;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=f9Ly0H2eD+VpB4ntoQnCNH5IaZ4AVMAVdM1dy+tGVBg=;
	b=Ryg857Dc8ffljRskiBCMQbDvhcoKxRnFW9kxJbqH86UdXACVMYc+Vg/QMFRrjA25sKBz
	 gxdIhFLL/8VDn33Cz54+SuVqN6wL+/xnWTklaCXyZYqCKxN16d0FfCD98N/CQGMLK1bft
	 /X41UZ6/I7bLjcyL/4ZwKXI99TO9M0rKGQOgpaULIZSNY+KluRR5fK3Gx4bUJdoMj6k30
	 Nt1vZNXepyt+n747MwgUzphMRubU0nXi9qInVn718u+O5ev1V+nrJQSkbYRvr8cwZ2FED
	 vZa03cwnp/wUg/2n7Lnd813/GwUBC1ahBazUwFzKjZA8jQqEUhRm+5Se/3egymXt65A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PD6hAaI0;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=X5HnS+no;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B3D606A338
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 13:18:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9B3D606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PD6hAaI0;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=X5HnS+no
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9DFDuu4025852
	for <iommu@lists.linux.dev>; Mon, 9 Nov 2026 13:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f9Ly0H2eD+VpB4ntoQnCNH5IaZ4AVMAVdM1dy+tGVBg=; b=PD6hAaI0nLrQm9uz
	XCzX7+Col9KxUfgrilTFUnFUvNpqmRvwYtuGFnEZiIuepCYs4LKA+ae1LDXy/3je
	OcN8+Gf44pc3um2q6ZOC8id8nsSyzQIouuJ5iIcVRvMZ/vbHRr3Fcycfcbon7yJ7
	jsHHjSh/gU/yRGykgvmJgCvMLCelJjghkpXI5rN6/DINd3q60Ov5SmYhxCwUeADb
	XBTD7zsQmIfmFMiFOU2nudE0Vg1mAoNrDeE+FcRM3/hfBW6qdVJQTzapG4g1lQ5l
	SQp/LKfJSGFaV2ucmVL87hPeYJIutMXOwHole6MZ3SIUd8vYXbv4oBas7W6UxLel
	vZ1E2g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hua5893xn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 13:18:35 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93cac495d99so6403985a.2
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 05:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794230315; x=1794835115; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f9Ly0H2eD+VpB4ntoQnCNH5IaZ4AVMAVdM1dy+tGVBg=;
        b=X5HnS+no9Y6cYa91rG4qdWeHTQMP+GFG2Z77G5AHbCmu5LPORK0CO35hbcw75r+mWh
         91LIDnCpjd+QHR+wnAgUgHRfe8Xktc0jhbeuxqKKRt/bOt6orU/zVc5U2q6Dh8uhOs34
         PCVsAQj8KrjsUqC8w2WiV0HqBNQzj4y691MJ13m9L2Ei/y2qaKO1yE00jigR0K4ttWpK
         jADBysm2Ppiq3uykL2j8IdXG5ifgQ8ouSJ7OOPC3Ok9/GUxfJz9nSW2E03oLvlWj2p1I
         jxei+K60o/Ku9Td0AEOLUFI9p1etuenMfNgxglw2Vy0rs92yrf7hggCOnGsslgQmNa0d
         ToBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794230315; x=1794835115;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f9Ly0H2eD+VpB4ntoQnCNH5IaZ4AVMAVdM1dy+tGVBg=;
        b=YhsHkSdeVsz0e0rOrJzoeF9hpUwcMw5wC8aSt/MSz5Xf8sjJ8ktg6/ppZ/U5HatORh
         DGR1IfsUFznMaX8uaTlA9/+VgANPtQEPHlRDNdHD0A/zOt1WUgHtbOU4lgSMrMHpdJBF
         QKdQRaYhSKKpP/vQpXwZU5SyV21A7dMT4XbxQFbQEX8BpobBaX5RJnhRq6gXgfPd6YO+
         P7BSJqHm28OrZRrugw0Jz2qcoe02SjQiCZaLmisGC9D0GVcBmQxdHZK0yoXoufUJkRVC
         0AjVccOPPArmDAIB32mTZSyGPGJb3ztVzU618S0m+0cCnan4J6tdLbHuedyWzTc9ZR76
         2+Ig==
X-Gm-Message-State: APuU4Z+qdy18CR/Oj7Z6lE2XPOEs2Z3IhUcua6ZrFE+H2miPDLUO75Z6
	YsgGAuV6hpob142e+MMEcfqu94xxBpLd2MDh9PKgFkW76OB8yYqc4XuseTfbOU5OZ1JVgOo+mIm
	khqcZM1jqzJf3+TfqENgAigOGeJ9H5NEFKDAc1rlhxDwRsaVvf1eACQWIpg==
X-Gm-Gg: AYBFou0bJwU3dku6kFHx5X8L9AnC5lli/SCFNzmcctS3KiQBI6mteSHJJoNxOEizAyM
	AD2P8GFSOYroZljWIWb3qRI7vQN9x0dagE0ajwKJsJ8GVuqWyT8EBRbe8oYAPy0JTW7WpM6e+QK
	NZL7G53ItL+mE7aFWeYb/y+/m0B8W6WKGH2BLU8mqZ5vARJc01w+pfQ6R2RxZBcpG41cw0Bdb9o
	3aa7czpLRVtcZ75Z3WTvsukoe1VPXIlndCQdUEQaiWgMo8/rDjIKe+i18/Pp7qnwRB9Hz7cw1Lm
	LeopA3dWdbcrkiiOeOpYEKbY8k08KaDxvuZ54Auf8Iw9JZBVISsrtqcFe4SqxaNL/nML1DYgLxV
	rADALyHFGR2c+pV5xu96tLIgpqA5b9SsByczD1Iz9a6URkD4XVqI6raGJ9uZsGxMWp9Xjaw==
X-Received: by 2002:a05:620a:a90d:b0:945:c5b3:6356 with SMTP id af79cd13be357-94784143254mr685965385a.2.1794230314777;
        Mon, 09 Nov 2026 05:18:34 -0800 (PST)
X-Received: by 2002:a05:620a:a90d:b0:945:c5b3:6356 with SMTP id af79cd13be357-94784143254mr685958685a.2.1794230314176;
        Mon, 09 Nov 2026 05:18:34 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d69f93858sm167363866b.24.2026.11.09.05.18.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 05:18:33 -0800 (PST)
Message-ID: <1704850e-c461-4ba1-9a01-7fae3167bf5d@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 14:18:31 +0100
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
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Add SM8550 MDSS compatible
To: nacht@dxdmail.cc, Rob Clark <robin.clark@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261107-b4-smmu-sm8550-v1-1-777d0a41170b@dxdmail.cc>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261107-b4-smmu-sm8550-v1-1-777d0a41170b@dxdmail.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1MiBTYWx0ZWRfX9hVkoTOGx9j0
 grcHZtriKcuHoUkxtD/fsxZDsoBM4jQ+wMmeKUa1k6HHd0AyD5yuD9/XBgNO/CjHl+q1YEl6RWd
 OrSLP8w/wBXV0aJ3z3vYq23EZDc3Wl1r8S2K7NtDqv7ppC8Q8LARuTSIZWKaKqAkjZoyq60fCDH
 Ggn14O9bP3oV6EUkSlFW6NFh4MZxkNuv6LmVNThgMlFeuOv/Y4umqfZ5x4s7ovLKvdIVXoLbyXT
 8oUM3+s0J4y21HolbfzP5Ezt3J5m7LEJuogUM6dzudt7kPvdCo+qdciN382p3NbqnczjwaU5xnw
 rQcby5TsRkD+1C0CV+MmSBCj5qeJAQIXgjCMGTeLVjDkKxTJh6lRBqaXNQnp0BU1S8/rHyHVedj
 +F/VX2M+bigQc8kOvneBCVMyn3VYRv8i7eQiI6uZw1sUHCCm2jLmwF84nGphvzGhXeTZfnIqSFO
 fKlpALGJKfxHi4zKxKA==
X-Proofpoint-ORIG-GUID: m-I8MHxXtXBVS3oh5EFvvSxlWmCu57B7
X-Proofpoint-GUID: m-I8MHxXtXBVS3oh5EFvvSxlWmCu57B7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1MiBTYWx0ZWRfX4iVML/i1AdMp
 2IxnPOUpm/bOoYEY14XJi7zO+3T/Lxfkkima6QFjzM1wu/xCYsa/tAdCzw+SIsyoGniDKmRCa2j
 jIvsH6KmbkytAq2LJbDfHbndDMhsKBE=
X-Authority-Analysis: v=2.4 cv=C9V8WgP+ c=1 sm=1 tr=0 ts=6af1c82b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=UwK4q1c8QMLSmQHnhC8A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090052

On 11/7/26 9:00 PM, Nizat Mikayilli via B4 Relay wrote:
> From: Nizat Mikayilli <nacht@dxdmail.cc>
> 
> Add the SM8550 MDSS compatible to the clients list, as it also needs an
> identity domain at boot. Otherwise the scanout of the bootloader's
> splash screen causes unhandled context faults and the screen goes
> black.
> 
> Signed-off-by: Nizat Mikayilli <nacht@dxdmail.cc>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
