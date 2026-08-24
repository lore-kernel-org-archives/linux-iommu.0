Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4880F40BCDA
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 11:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787571078; cv=none; b=OXeQw51cqo9IS233W4pEJoDfp+jRccWZgyJMzhU2/lXDyd5kyynkCWRbnaIoPtHFvnbLwNiL8wa8+AKW/iEWP4nG42+4EYJEneBX2ozzYzRnt8uP+R2UiBJ5HK44oLmgFkEQFt3c9qDEEgSOLltG2DaVMe8ORc6R9+M8tBiPsXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787571078; c=relaxed/simple;
	bh=9o18Ss1HSCezKpijdpsSmTTtjPaVfKlkqkGQKrki1c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Du4proK+89NhG29qcLZN3oHBFcFHmDjavINMA7M6k0BzvpO8jc1sT305lNCTpWGNJ75AC1nGXC0p6AKgbqD7ogqee7n8U7GaAPH5j4jhR6fwJ0SQX6+UqZRTq193/ykhmbgm4jxC3d+8+OV2Egbb9tiIjY/KL1Uq9og94y/ZQLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gklqmwlf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e7133uJq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gklqmwlf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e7133uJq"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OBMVvo2372289
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 11:31:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=uhZFMUq0G82N6cZ0jr/Dp8Ye
	4zJGl9JW5FIR7tFFlKM=; b=Gklqmwlfj9AzCkg/arOvToonrhf0bYY/rB+R88JX
	3w6WMi/u3Bi+iyuC5Z/s1CKgJvg9H3owZXmIpgfVN2qfyWO/yTvkxz9y8/Qja3ym
	liXTh6B+i0GkURoYSqt1egIKbsIjuYTVA4S2GymUThJ8m5yB4V4SuJAyhCNKzcrk
	cKoJk6hOpg/1VjmtI3TJ5U8NRRZ/Lbjalee64MB+/jjtG4LUjwHDfXUTHqZcCyEF
	+6hdoRjcq2ZOLtDL/ZaxPCFkoeon0XzTv36UH2wNqls/gmvgz5j0gGi5ukR/L8Xw
	N0xB4JnHmryBkKdZPwEGkkxIvj2IL7soNYf8wZSDCl+4Ug==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8gdshbvu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 11:31:15 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-52d33c89a29so45230331cf.1
        for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 04:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787571075; x=1788175875; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uhZFMUq0G82N6cZ0jr/Dp8Ye4zJGl9JW5FIR7tFFlKM=;
        b=e7133uJqk514oAZ7JpGQitwOgEDXyUb/EKQ4NXQaq3UysIAV/CkXW/EkqJnIlnPahY
         cwMUV3Npi97OOGvMjkzm4op+gGlbx2Q3fvXrjHMWiSaP60p26igBOWLlxDj8IT4XjNh5
         5EZ7q3JrD7WSh4qV5KsY78XFhCwDmKKxbmdkUA6/CvO9k/Ym+lmSdGo2rBSSKRMCc5c+
         JjWOJ5zuB3Umo5VPHmtzWw20bzkeAmapLpTNQO060K4BTKR0vY6TWt3d6asHC3gQEZJd
         K4QzACGzkwilcn4W8le2VN+vZxEvwqlaTfL4W1iSgjDCuIziJ1nuCJdqIY9+L5JGNMS2
         CGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787571075; x=1788175875;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uhZFMUq0G82N6cZ0jr/Dp8Ye4zJGl9JW5FIR7tFFlKM=;
        b=BAt41IqAcGBokrknb1maHhXPbyCS40H5dF35P2xo7uX8W5ibHPBrJPlgHqyqbBExNj
         IPqP5sPyXgjnGpuAt7coou87JCGSje1n7uKqnYuk01kLqcmn3D04X/av43kg+Sa94hdd
         3NjHrPPr/6aK43ANTrkHcWNGsDeMAJQCI2KlYMAU5Mc1fhWkCb0uhLlRUCIBl84Zuu+s
         GKla8q/zU/VenBrkVHqSCNVcbFIOsHL0sr3XLWOsW5oDBESNyyvtdOeVXnpy01ff3xNo
         PEIGB4TPRNIvUNnC9xP+c8TGproh6iJ5mYpOmy49iFmuuerHYG8/vace/UqUOiKYjsza
         V52A==
X-Forwarded-Encrypted: i=1; AHgh+RpTttoQ5HpiMcYGp8HSTpDl/HuCt/g9FncaTnd7+zkIbUUmCI6oZO5ZuC2rlDvHBd007YSdHA==@lists.linux.dev
X-Gm-Message-State: AFuF++nVslnIJni0BG2kxA+7LUZf5obShS8qImTkTnDDbp4yuOkY2Hyf
	eeG/52Yob0zAKLAmd8PUkDXlPYG4/FkS0fmrVgBtAhlioE/yInb6R3WuxsIyv5ZpTQBaXsnyCuq
	C1tRvKRXcmFTW3/XIRcBGkr1A14fdSgXTSn7aBvzRDNM7mBrhl9XBR7d5cw==
X-Gm-Gg: AR+sD114IQo3xTY5uM173DTszfOP6xcg+hgLWuyRxcyuQbhfoid7UobW1as2SLT+5SO
	e94ZqfbKj5Fn3MuNHTura5ClcS3XdW8ekpTwnJ33X1vMkm7rK3ZjMbtlMF//23f0M6PS0KukQoy
	USb9aVPXO+HX4e6uLFFOlzGJQrGl0zZSbhfmQqGeT8bxyTTcakN0IDNFemgj6lbURkfZkcNhzhZ
	MUC4+b0SAC5NuQopFnl/p97iY3Z7z5FrDSlxFMJ6tJeJL1fXPXcyE80AFhKPzwiN/vGD6+iblI5
	6Ei9TzXgpmtKyDkZ3PxgoJoJMTJC2sJZpRb/OhlB1a7Gk7cwl6Kv6QkOzf3uBOHQIolyazVeDzI
	rkv4BQOwqepHnxVU=
X-Received: by 2002:a05:622a:4cc3:b0:51c:ae7:fa1d with SMTP id d75a77b69052e-52df56e10f9mr245520881cf.5.1787571075021;
        Mon, 24 Aug 2026 04:31:15 -0700 (PDT)
X-Received: by 2002:a05:622a:4cc3:b0:51c:ae7:fa1d with SMTP id d75a77b69052e-52df56e10f9mr245519981cf.5.1787571074499;
        Mon, 24 Aug 2026 04:31:14 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496738e7esm1342927066b.46.2026.08.24.04.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 04:31:13 -0700 (PDT)
Date: Mon, 24 Aug 2026 14:31:10 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, ulfh@kernel.org,
        p.zabel@pengutronix.de, ogabbay@kernel.org, zhangqing@rock-chips.com,
        royalnet026@gmail.com, u.kleine-koenig@baylibre.com,
        chaoyi.chen@rock-chips.com, diederik@cknow-tech.com,
        alchark@flipper.net, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, iommu@lists.linux.dev,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 08/13] pmdomain/rockchip: add optional per-domain
 power-on settle delay
Message-ID: <dn5vlrxg2vr64d56mqibriz5y7ebeqezkv6f2aqf5qd2gti6y2@ohdxvj5dnscc>
References: <f1805c2bce56c89d8ace35f67c665b24bab90965.1787568944.git.gahing@gahingwoo.com>
 <1b89eceeca92f7857d26c5d2097bea2bce10eb93.1787568944.git.gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b89eceeca92f7857d26c5d2097bea2bce10eb93.1787568944.git.gahing@gahingwoo.com>
X-Proofpoint-GUID: gEc6kTqCSTr3mg19KR7K8xevg1eaPlYD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5NiBTYWx0ZWRfX740yjJrmYYKb
 ghh1wJxln+36kzrM1WiRI641r0Z1oQyOJ5bItTacIVN/ju6eQH7DcDkmqBei60rxk8rdhbyHaht
 Crhza69pBLEWg/74c5ttiDOlBOHyzYt796BxUE3Lgr6tVWdm/3BZbP2Z5qono7DxMh17v06QGPd
 aQ6UqZATB0Ky7PVu3RoRYlhouXEltNP5bgMtMbC0ouCo5vwsSsfXudGVjwaWagWuylG8phBttlD
 8IFXGXzFpJn96ZoTF+jmMqzswjNhdiNfZraK/HshVECGrDOoEv4/b1xwGS4j3uNa3/QSs3QWtDE
 VVv+v7CwHbUCtQh9902Ck3im4gRi/PWEb4ST33I836koGF+Yd2pw0aF+rHDKHdxZ0N2RP8eoBG4
 3v/TmiEmdaLwY3h+RRd8fj5ZsOkspazm365BwjRU+eKBePPHVXxo0kXAFDscDpGtNiS3EuBJShm
 EVUPwdCHSnLEPSNTH6A==
X-Authority-Analysis: v=2.4 cv=Fqo1OWrq c=1 sm=1 tr=0 ts=6a8c2b83 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=wUpz7uCjLrEXi01cjX+DLw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=9GNsruGHAAAA:8 a=EUspDBNiAAAA:8 a=lG5QNMjPvMxfgh1q_X8A:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=gf-oSkQAjqHFJRp-GQfY:22
X-Proofpoint-ORIG-GUID: gEc6kTqCSTr3mg19KR7K8xevg1eaPlYD
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5NiBTYWx0ZWRfX+6cI1UK4Worl
 7HaFArQ5IG0CU6rRIhzgD0Oz46qqjRdGCWlFL8P+GhIwt3jgdR+puZDFu+Di4Pmowgdk3V9GIHI
 yXgJaVENaq1KHMW6kh9ed0wlwWZ3tKc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240096

On 26-08-24 23:08:57, Jiaxing Hu wrote:
> The RK3576 NPU domains need a short settle time after the idle request
> is released before the registers behind the domain answer. Without it
> the QoS writes that rockchip_pmu_restore_qos() issues land while the
> domain is still coming up, and the NPU throws an async SError on the
> first cold power-on.
> 
> Give rockchip_domain_info an optional delay_us and wait for it between
> releasing idle and restoring QoS. Rename DOMAIN_M_O_R_G to
> DOMAIN_M_O_R_G_W, since the suffixes name the fields the macro sets and
> this one now also carries a wakeup delay; RK3576 is its only user, so
> the old spelling is not kept around.
> 
> While the macro is being rewritten, give it the regulator argument that
> DOMAIN_M_O_R and DOMAIN_M_R already take. Without .need_regulator set,
> rockchip_pd_regulator_enable() returns early for every RK3576 domain, so
> a domain-supply in the device tree is never looked up and never enabled.
> Add a DOMAIN_RK3576_R spelling that passes true and use it for
> RK3576_PD_NPU, which is the one RK3576 domain with a rail of its own;
> every other domain passes false and is unchanged.
> 
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
