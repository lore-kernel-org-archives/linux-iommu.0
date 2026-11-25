Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795619195;
	b=erOG1sbJRFpaEz5dka0lmzwOvJZJZQ2zKkee0vHs3oKRrq22gWuj0BYQGySSkwTwAXHs
	 dLhIRp9volZqADlN4HX4FKtns4TpfUupT1h0BiOnMBl3aXHxtZvCzXaZXuHUiOh2ub3tn
	 pYyr5TUxtIraK6agpLyPzj67/AVUzx5LW+1cXUb2fIewSI0LSHejmA406BuwySxGD47gG
	 FpVm2ygAr7YnYTuuFCzO/ZchpNndZhYyQl7wtA2eIqFN5vAt/VK2EwXKkA4/nzLxEPJ5H
	 QyMwJtQlePCuhP72B3OCyq9kvuijWrkxOQh3coL67JRMnc/GHzWeeP22hzBwYbLBZ7w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619195;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=F8Fmq8LWA4bhtyNOLWl2S9LNOHs1l6eqA9F+R8NUX+A=;
	b=BdksT2MiSw0IwRGB+pFV8uKvsiMi4CQmcXVsHfVou+XjAuwwn9JDK6aRafXUyPayI/ur
	 sct19pa64P/YsyTmdjapJfDwT1RZUlhgRzPZb7JKjukr6cY1OXee/TLOlJ65wYdGjnRLB
	 CgkHeCXB+PBdtPmV5mPPZPXOpz1bFhouToXMpqQcD/sXd+8o3obJdbj5vWgxHCqk1uQdb
	 sUbwBjm7K21xfVr22oi/18z/PGBdlZT1ifyteqnZp5Msl96lVEHb6AlbcaYfJ0Qm85UlQ
	 f/y7ekb8D98KseH8u0QLL/GUQh4QBddmgN/fCfxxqZSFGXHXtFaCk8tS1yDRb39YgBA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Nzjcr1Jv;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=No3umAvZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCCD606A321
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 15:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDCCD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Nzjcr1Jv;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=No3umAvZ
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APEME9d2099771
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 15:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F8Fmq8LWA4bhtyNOLWl2S9LNOHs1l6eqA9F+R8NUX+A=; b=Nzjcr1JvAe8O3y2M
	nRk02gsmzckXBcRxfri+XHtkdUIEszeIzfFyQQgR/BocgtLFL+n+eCBxHRzQ6Yfq
	qFzg8RINXEMwOvBf0/oUkncHMiBTksHiHC9BqK7fPOJQt+fer1msKMHomuVFo02M
	HWlOZeJFWN/NORls8UyWol1U9y/9hHAW4fZgccoU7/Sbqi2bbTFG+4vjo+f4z3En
	x0PMMHwz77Py3aOkFJX8N0yFo4LC9oqXKJIiDzifeX/5Vv+KdoJ8lIpcubq7K9D4
	SMLEBhZdEr0PMudXVoqY9KyOzziQXsPFG/RnejlYfRIxAoE94rHnRlkzkztqvvLf
	0Vovvw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j61arg758-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 15:06:32 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cdb91e288d7so4574246a12.3
        for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 07:06:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795619191; cv=none;
        d=google.com; s=arc-20260327;
        b=mcPV3FyK6UIdbdXkTmK96vBG3ytBUDg6MSc7ftcSJw7Vo5k4/l2zUv4xI8B4UhUtlS
         bkkIVwd2DpWj3br46HobYYZxuM89lAHmbBwcNna7eOeeveww4qfsi6D8KVfEQI3GWLEZ
         m1Cy9U8Hq4JyXYT4KIdc/kPJsOMgYN0M/loGJDTYTNmHRb56alkqSXR01PmmvFsIhxZS
         kGSrxziRGMiJjKB/M0wMTPHcE4FA2DJ8BShzHn6hMz8AWWEYp7tJGX809YEqoVGabx66
         bAYMwucCkx8jWUNIVFHCPbe206yMM5M8qKj8L/3deRHpZdYuT/8846rEiiylZbcLLKlI
         qyRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F8Fmq8LWA4bhtyNOLWl2S9LNOHs1l6eqA9F+R8NUX+A=;
        fh=hBt8T2RXi5y+DMn6iKPMDOyVlmLXDiupfz0b4ujhUBA=;
        b=NQ1pKNCCo7SXfsGnm/UIkadCqDBqs9NfeHy+bkprqKWY7JeVwGU1p4Bf4IID9EBISB
         kFoshsNSV6VhhIgOKi5hEvOqQNPYj/4Q/4XMtn3LUrcL6PVySA6hyRNr1HvDPDSfIy4V
         BIkepQ6GMPjYItQ0BmCI/hZxZIbGdJo45xVXlW3AqcVvt7/zqt5kP1+0Q35PirPxDLhi
         PFGGEo2MLlbl8adoE66kiLFCpz7cX7nMhnwhuOKPrXduY0eEGZPPJrxcFOprzC+7nfcS
         qTUKJIPO0JgT5L2BM2/Nn3UvQ6u0B6gla8HwSeKeV/WXSSnP7/6YusIoZ5y+HZHl+AVr
         s6QQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795619191; x=1796223991; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F8Fmq8LWA4bhtyNOLWl2S9LNOHs1l6eqA9F+R8NUX+A=;
        b=No3umAvZPRdDgROa/sG5ZTDTITYZ5K0dQnAcOLbYwJ9pgCm0lLM6nPuMY19+3aQ4Xs
         llLngO2SF/huzMrZZ9YogI7OmQB1+hkXTVCAyhNes8T9H+39+Ta9RJB2hklg9c5aOUNH
         VKHlbQ/7wTT4JQoXkqfVRQcfSWZq7r6cg9CMq0DwHyxlaUVPkgnVjBwlac5oJdV9Ndet
         qiTqmXZpvkS4LkBvrZuAmf2+bNccu3qhGCW9xyvOzPHaCqn7Q0Q9c4g5hX4zg+GERDG5
         LTvdMCzHfssa5NSIZZhm7MADjb6uPYRMWVHlsYE4b0V168u5Ii7Dk38DgMMzT9XFpRUB
         yJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795619191; x=1796223991;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F8Fmq8LWA4bhtyNOLWl2S9LNOHs1l6eqA9F+R8NUX+A=;
        b=I8ikBHNoXrmYSpvI9tOF+j6t+sDrRmxrZ2yqAsSkqKHzOR2wyttguCsxepVqAeGABP
         ltKnU8UqPJ+5QReG4tGVNxvwVMpb/UL9INp0AyShZG9+Sq8S1pDPV6HgY0TOGEDEy3od
         qGGEW2odcqPGmuIRTKJbVC6JnLkjqTvx4QvcLGRTNUy1heafaLDBjT6pIzd7F/4uh8h4
         1Gkv5muuU4ZP00WepczKQZ7WvzpRVSktGHs4XFxPzY0i9ecsHBE+kY/FSzELPlXhuVL6
         c3MJ7sYEooHFernfLM8lHWRrWQcvMqxoT4roK0k1/HhfKKU0HsoNPzi5yYHgCfzkUvXQ
         /Xvw==
X-Forwarded-Encrypted: i=1; AL+hErFvvdDYK9ZloCTFJCbY+4j+p4zBCEF/zEP2djMj8pUyMxZd0myhvDbvUNGidr0PdlzFrp20Dg==@lists.linux.dev
X-Gm-Message-State: APuU4Z98LLF7w5lrLEQQu/+CFLOHpP9gHK9vmhWT8EcPr1+Ui/cIcaeJ
	hZVVyFEsW5fWpafU6a1m9pFdk/zoF4eyveEABK+TRTDP9MBWxwr5YvHqnubuLchOWd93ViwCLeg
	+VpiMf6KUJ6PGZzYIZcC0EHdtSij8aMnzulF5GhQ5yYQcDDwNOXELIB+gso9fngc4eZzY9J2Vzj
	PHLpQf1GPvRn0dtx4uWV/VPZQeHdOVmr94
X-Gm-Gg: AZFdTZembkh7ptprOtnpo/REG6d1+36Y2PMsWfmo12xsvJnrodMr3o708pKN3ijjiCa
	PlB3jxNE6Bg+5RprtmFxlu9AVLkUjmGBthbJX1f+V1ncT+IiCa0eT0sRELctxJq9kBk56uQtSDH
	eEUGo1Trbq3Gh8DHzcFiuA/K2zbpDxkFoGyWfXCwx+ykMKnUYHY01otdoB7A==
X-Received: by 2002:a05:6300:8095:b0:3dd:a196:69e4 with SMTP id adf61e73a8af0-4014d14d2d3mr16907589637.63.1795619191479;
        Wed, 25 Nov 2026 07:06:31 -0800 (PST)
X-Received: by 2002:a05:6300:8095:b0:3dd:a196:69e4 with SMTP id
 adf61e73a8af0-4014d14d2d3mr16907537637.63.1795619190966; Wed, 25 Nov 2026
 07:06:30 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261117173738.1073856-1-Frank.Li@oss.nxp.com>
In-Reply-To: <20261117173738.1073856-1-Frank.Li@oss.nxp.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 16:06:19 +0100
X-Gm-Features: Aa3M54qxdRmYOsZoBrTl4IfLXTc7pY51UNG7OdOGBQV2sjgdmvbFz8dtj3UY-KM
Message-ID: <CAPx+jO8oqBcGCSUReJJVMjsnQg+xCv_X8LhFVaGk0NDuOqmEiw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PM: runtime: fix stub pm_runtime_get_if_active()
 for !CONFIG_PM
To: Frank.Li@oss.nxp.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Alex Elder <elder@kernel.org>, Guan-Yu Lin <guanyulin@google.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrzej Kacprowski <Andrzej.Kacprowski@intel.com>,
        Maciej Falkowski <maciej.falkowski@linux.intel.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>, Will Deacon <will@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Connor Abbott <cwabbott0@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil+cisco@kernel.org>,
        Bingbu Cao <bingbu.cao@intel.com>,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev,
        Frank Li <Frank.Li@nxp.com>, Alex Elder <elder@riscstar.com>,
        Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
        Karol Wachowski <karol.wachowski@linux.intel.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        Matthew Brost <matthew.brost@intel.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        intel-xe@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: G0NzERq4gRMz3FkFYRfUiKr5QjMFKnUD
X-Authority-Analysis: v=2.4 cv=OIOyTiaB c=1 sm=1 tr=0 ts=6b06f978 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=8AirrxEcAAAA:8 a=ee_2aqc6AAAA:8 a=VwQbUJbxAAAA:8
 a=ag1SF4gXAAAA:8 a=QyXUC8HyAAAA:8 a=GFqr32JmAAAA:8 a=pGLkceISAAAA:8
 a=7CQSdrXTAAAA:8 a=tA7aZXjiAAAA:8 a=EUspDBNiAAAA:8 a=_jlGtV7tAAAA:8
 a=1XWaLZrsAAAA:8 a=e5mUnYsNAAAA:8 a=JfrnYn6hAAAA:8 a=f3U7k-wd2kzf4Rf19YkA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=ST-jHhOKWsTCqRlWije3:22
 a=VOpmJXOdbJOWo2YY3GeN:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=f02Ha7HRcztGgdyUxOxW:22
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=kIIFJ0VLUOy1gFZzwZHL:22 a=nlm17XC03S6CtCLSeiRr:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: G0NzERq4gRMz3FkFYRfUiKr5QjMFKnUD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA2MCBTYWx0ZWRfX+ve0Hz9yCi0d
 sKuO2zdxP74SoMQJ+kP2r9S1kggbsLHLZeaV2mb2HDP5m2N9Tmxj0LBQmfuOv/C4Ia2TodzKDGU
 ZusYNM+ts4Mg7ideQ6uu2fQgfvE22fE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA2MCBTYWx0ZWRfX/VDDc5EJn4aD
 Y6nsMJRHjIJ6s0JAaUbq+ifZb1qovPP53FuAkcmldejDtoR/HAN7cS/OWJAEP5PmneGk3DcRPT5
 o/Mw3TL4wS0xrIjaL7TWDK2jqL5VS8rpQnIrXb1Luj5GCRmqsXwiHa74TTDgJJ31Yw3K0ywOOAO
 jyvZNehwpc11O0x/fuKw9Jxn979l7XfnjlJO8vyG47fYQthNNG+U8qw1azwtxK1auTT1Jw5ZIdd
 jOVIjOjbZlh8tmSfiZ5XNE3lI90vRJhsgeOd3x7kYZBmo8R9+YWf/sq1bOmdvESv5c1cz2dF4Kb
 aUi3p+ZBaPVMo++sLW6VvljZDTWniXh9IFZadQFWWJSAZZADBZpE6N155XgAvWLnduWwiaWL0Z2
 BVVHVpT3XBluNMOt9yyE7z1ezn7fjq+ko85llV899mf/OvJMX0OL9TWwUKHo9ozQ2MXIRRNBu2O
 9Bs/uIzD0A0PO+C/RDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250060

On Tue, Nov 17, 2026 at 6:37=E2=80=AFPM <Frank.Li@oss.nxp.com> wrote:
>
> From: Frank Li <Frank.Li@nxp.com>
>
> When CONFIG_PM is not enabled, should be treated as if runtime PM were
> enabled for the device and the runtime status is active.
>
> It's a subtle distinction but the previous behavior returned -EINVAL, whi=
ch
> means "runtime PM is disabled for the device"
>
> __pm_runtime_resume() returns 1 (called by pm_runtime_get()).
> pm_runtime_get_if_active() is the try-and-get version of pm_runtime_get()=
.
> stub pm_runtime_active() also returns true. So pm_runtime_get_if_active()
> should return the same value as the stub pm_runtime_get(), which is 1.
>
> Analysis of all callers and their behavior with old (-EINVAL) vs new (1):
>
> Pattern A: if (!pm_runtime_get_if_active(dev)) -- no impact
>   Both -EINVAL and 1 are non-zero, so !ret is false in both cases.
>   Callers: drivers/accel/ethosu/ethosu_perfmon.c,
>            drivers/gpu/drm/msm/adreno/a6xx_gmu.c,
>            drivers/gpu/drm/msm/msm_perfcntr.c,
>            drivers/gpu/drm/v3d/v3d_mmu.c,
>            drivers/gpu/drm/v3d/v3d_perfmon.c (x4),
>            drivers/media/i2c/gc08a3.c gc05a2.c og0ve1b.c ov6211.c,
>            drivers/media/i2c/ccs/ccs-core.c s5kjn1.c lm3560.c (x2),
>            drivers/media/i2c/s5k3m5.c thp7312.c imx283.c ov64a40.c,
>            drivers/media/pci/intel/ipu6/ipu6-buttress.c,
>            sound/hda/core/device.c
>
> Pattern B: if (!ret) after get -- no impact
>   Both -EINVAL and 1 are non-zero, !ret is false in both cases.
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c (comment says "allow access"
>     in kernels without CONFIG_PM), drivers/pci/pci.c
>
> Pattern C: ret > 0 / ret <=3D 0 / ret !=3D 1 checks -- FIXED
>   drivers/usb/core/offload.c: checks (!=3D 1), old -EINVAL caused
>     -EBUSY even with !CONFIG_PM. Fixed: now returns 1, proceeds.
>   drivers/accel/ivpu/ivpu_job.c: drm_WARN_ON(<=3D 0), old -EINVAL
>     spuriously triggered WARN. Fixed: 1 > 0, no warn.
>   drivers/gpu/drm/i915/intel_runtime_pm.c: checks (<=3D 0), old
>     -EINVAL triggered error path. Fixed: 1 > 0, correct path.
>   drivers/accel/ivpu/ivpu_sysfs.c: (> 0), old skipped freq read.
>     Fixed: proceeds correctly without CONFIG_PM.
>   drivers/gpu/drm/xe/xe_pm.c: wraps (> 0), all xe callers
>     (xe_bo.c, xe_shrinker.c, xe_vsec.c, xe_ggtt.c, xe_guc_ct.c,
>     xe_pxp.c) now correctly treat !CONFIG_PM as active.
>   drivers/net/ipa/ipa_smp2p.c: power_on =3D (> 0), now correctly true.
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c: (> 0), now correctly
>     executes stall register update.
>   drivers/staging/media/ipu7/ipu7-buttress.c: active (<=3D 0) early
>     return now skipped, correctly proceeds.
>
> Pattern D: explicit -EINVAL check
>   drivers/hwmon/prom21-xhci.c: checks (> 0) then (=3D=3D -EINVAL).
>     Old: took -EINVAL fallback. New: takes (> 0) fast path.
>     Both succeed when CONFIG_PM is disabled; functionally equivalent.
>   drivers/hwmon/eic7700-pvt.c: call is guarded by IS_ENABLED(CONFIG_PM),
>     stub is never reached. No impact.
>
> Fixes: c0ef3df8dbaef ("PM: runtime: Simplify pm_runtime_get_if_active() u=
sage")
> Fixes: bd3d245b0fef5 ("usb: core: use dedicated spinlock for offload stat=
e")
> Fixes: 7806bad76ac39 ("accel/ivpu: Prevent runtime suspend during context=
 abort work")
> Fixes: 1524c28b99527 ("accel/ivpu: Show NPU frequency in sysfs")
> Fixes: 46edb0a3eb16c ("drm/xe: Fix xe_pm_runtime_get_if_active return")
> Fixes: a71aeff3dd0a7 ("net: ipa: kill IPA clock reference count")
> Fixes: 70892277ca2db ("iommu/arm-smmu-qcom: Make set_stall work when the =
device is on")
> Fixes: 9ad65684b9285 ("media: staging/ipu7: Ignore interrupts when device=
 is suspended")
> Acked-by: Alex Elder <elder@riscstar.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Ulf Hansson <ulfh@kernel.org

Kind regards
Uffe

> ---
> Change in v3
> - fix drm/xe fixes tag hash (sashiko)
> - drop i915 fix tag because guard by CONFIG_PM (sashiko)
> - fix net ipa fixes tag hash (sashiko)
> - Add c0ef3df8dbae ("PM: runtime: Simplify pm_runtime_get_if_active() usa=
ge" (sashiko)
>
> Change in v2
> - add fixes tag for patten C.
> - add Alex Elder ack tags
> - change subject to fix stub pm_runtime_get_if_active()
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
> Cc: Karol Wachowski <karol.wachowski@linux.intel.com>
> Cc: Oded Gabbay <ogabbay@kernel.org>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: "Thomas Hellstrom" <thomas.hellstrom@linux.intel.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Alex Elder <elder@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: "Joerg Roedel" <joro@8bytes.org>
> Cc: Rob Clark <robin.clark@oss.qualcomm.com>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Guan-Yu Lin <guanyulin@google.com>
> Cc: Mathias Nyman <mathias.nyman@linux.intel.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-usb@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: intel-gfx@lists.freedesktop.org
> Cc: intel-xe@lists.freedesktop.org
> Cc: linux-hwmon@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: iommu@lists.linux.dev
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-media@vger.kernel.org
> Cc: linux-staging@lists.linux.dev
> Cc: netdev@vger.kernel.org
> Cc: imx@lists.linux.dev
> ---
>  include/linux/pm_runtime.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index 64921b10ac74f..de9e7518ecef2 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -280,7 +280,7 @@ static inline int pm_runtime_get_if_in_use(struct dev=
ice *dev)
>  }
>  static inline int pm_runtime_get_if_active(struct device *dev)
>  {
> -       return -EINVAL;
> +       return 1;
>  }
>  static inline int __pm_runtime_set_status(struct device *dev,
>                                             unsigned int status) { return=
 0; }
> --
> 2.43.0
