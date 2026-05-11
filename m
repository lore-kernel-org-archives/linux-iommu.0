Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E68A3B8BDB
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 08:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778486804; cv=none; b=roqQxVFSxHccd2lRzqFgnJF1ZKayqgii3lXnybl1nLzR/s3aXyTM2wxxMQh64Xum70qRn6hTBBcdX0IM0El8ul/KC5DZl6nxo1/e7zOcKCZqAhDeqrlwK1s6jMvSyjj1e2FOXJiwvhXvlhbuGM7CNBszpf7kvsMealaXWvxcIMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778486804; c=relaxed/simple;
	bh=3Tz2OjDF5lCkQ7m1u9fa1A8Pfz/yv22mmCYTrI0gwfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJ4GLh4n/YqJciDJ9Dv+vw9zAg0S2FeO5m5c+DDGi7xYl4f6xii57WQ587/9wjPCYLedcTf9ppBZU0KmFta0DabiutB/fpj0ZMIbE7cFFwTR5T9QOWC7UHbzYO1CCJYmpZuPHY3Iw4PvFgpZxvzi0fVSYmYyhUtfRkspGoGpHOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PnB0Wwl+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jDGNEM6P; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PnB0Wwl+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jDGNEM6P"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B7Ab5C453885
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 08:06:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/6OY4QeYUbWXnau99ZtZcmYK
	nWqdx8LqgKBOO25F1fk=; b=PnB0Wwl+S8dEIo2K3MJIQLzRvgJEzIVOKb03bCU5
	4Xkkoa/rzeLu1KoO5+hCUeEtsgwglXUbRgQTG3MDQhMbKAMgdEjsnETaOy7Xl3Gs
	nCIa8WHRJ254UnzU8Dw1GVgdukuZg8kZ7KDt/74KXwXH7GoIVDCLScsMAwBTIyeJ
	tknK0JzBesKmT9dnw3oct21v9FoCURyydRx4VUQS+Gv2Zij737HBX54jaxAXc+uX
	PRiFVARo/c63CDp6dxLs21hfIgA4bMwCy8ShbO22cW/H0LBCqDztxjCqwUTyIfhO
	JNN+cKL7LZtrhKk16qNommZEJal0RAUA6OvmTfD5hn2MlA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3ag6g63d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 08:06:27 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-354c44bf176so4924683a91.0
        for <iommu@lists.linux.dev>; Mon, 11 May 2026 01:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778486787; x=1779091587; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/6OY4QeYUbWXnau99ZtZcmYKnWqdx8LqgKBOO25F1fk=;
        b=jDGNEM6PhnYPEvpOscMkN2PfLksqRtYjJjMk+tYyaXelUuSn+SK/mQpbER5nM1NM0U
         Cz9igWM5ehFE20t/no2u5e+pGesdoK1A050v82al/1BX/BUqdbm0VyeEou0zRp1gXLvI
         XUcx/gTNW3pHZlITx0tXDsQzS075KTWK0CKVb3voZPwS6GT+A5GKWkk0pn8EiNbKnpo7
         JMJPb8XpS4Zd+4DP+DzDOjK4XfF9oRXECiaaO9KG4xe4i74KTmx085XEnh2/kAivsLzf
         qA3W8mV4INpsyLz7F8xFBwaHMlLfgycfQ+L257Vnibb8pthon8JD6t25xyqPhAc1ARAC
         MArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778486787; x=1779091587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6OY4QeYUbWXnau99ZtZcmYKnWqdx8LqgKBOO25F1fk=;
        b=Mr8Rdig4+WLGSyTb/xaRp2/Zr46bTVL0IADKXJrVA8Kyl+jWUj60bx9XF30Hde0GEK
         +9ijJaa/T01R7FGjo8Rtp/m8VegayGlZ5XKm14a6rIhBJvLDamgN18xk4m3rJTmi0SgP
         xI5h7rT63C2wukeJ7D/l9CfJlQDOAWka9x6OHicbF5a0djF3LjTTqJ/B+zNljjMQ1C20
         ZzwRvnKDtzW0S6P/m3lZW5hmbGTOXlq8s/k55MuUUxO5XP9DcrfdxWf5yyXuMZClTspQ
         t+XiW5rm0BbrQ1TrB/QOogIpW92+Mp7v/1aQDU8xjAMMlXjWrmVNgrd/q17e0IaqS8Xo
         80yg==
X-Forwarded-Encrypted: i=1; AFNElJ84wS7UT56Jw4wZeMlVbEAExdTRqGUMTzQlHm916aOKacuwzp6E0+2WxJDMHYw8vdOuBskI3g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyEB6O82qtO3wTD6iY2VqnKqIhMkgUw8HhQSFsvgEIpdoeNt/VV
	Dy+My8WzzJdsPta7WMUzMaFKOa2J/tvxXyzUnx0MyeCZymnTCh/k4cgmXL8hT5dW2GqaYDVwCt4
	wJPfmAOTTJRMdT7uyN6gW8ClSNq/k3A1Z4DCdJMG5MAQCd3HkaNhgmHTb3A==
X-Gm-Gg: Acq92OGQIk6eLNcIyW/kznhL5fPEE1+95YYzuvkEU0dX/s1rTdh+soSDrcQhGGynG42
	/eccA8kUdkzhHIUIOSZt8V+vWVa055NrZvObWkynw6UiYyhrsBHwnG8NHoY6WZ8XwDtuVNatTl1
	yUSuE/SyaqWHAuG1+T4sGjfnjweaFKSZJOnVMODP340jSdSOrY7BtPfj/27ZCdvxbpWF5/dZN7C
	xVcXvgF2fJKWNZ/UjyvY0MRq75gxoF/8XX7Nl+TsBkjFGM4r6TKJ5XVCJhShGA8yG1ClUcsL9Ar
	N+bKkoggWQuyIiZ9ZD3fp7ovgMk0eKe0eLiv5IwhoSddJx4zDsCk4u2/RNrk4uI8jMnIu5GX8y7
	/Rmddn9T6LaONC7ESgWKqcTqGAhjqlySOu5UwO/hXOte1yJAp
X-Received: by 2002:a17:90b:224f:b0:35f:b69d:7292 with SMTP id 98e67ed59e1d1-365ac080dc9mr23365379a91.15.1778486786623;
        Mon, 11 May 2026 01:06:26 -0700 (PDT)
X-Received: by 2002:a17:90b:224f:b0:35f:b69d:7292 with SMTP id 98e67ed59e1d1-365ac080dc9mr23365320a91.15.1778486786006;
        Mon, 11 May 2026 01:06:26 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d683fb92sm6583882a91.12.2026.05.11.01.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 01:06:25 -0700 (PDT)
Date: Mon, 11 May 2026 13:36:16 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Trilok Soni <trilokkumar.soni@oss.qualcomm.com>
Cc: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 07/14] media: iris: Enable Secure PAS support with
 IOMMU managed by Linux
Message-ID: <20260511080616.6niytw6t5kitf7ug@hu-mojha-hyd.qualcomm.com>
References: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
 <20260509-glymur-v5-7-7fbb340c5dbd@oss.qualcomm.com>
 <4e132e7c-ffa0-4954-876b-67b53870e832@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e132e7c-ffa0-4954-876b-67b53870e832@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=fOsJG5ae c=1 sm=1 tr=0 ts=6a018e03 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=H2__nBlnFGDM6hqOEFYA:9 a=CjuIK1q_8ugA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDA4NyBTYWx0ZWRfX8xBqQZlnRKJv
 iXuXkqRkjeQO3+Xayp1yihyOAVUdDprq1wnB1XAUkJSi4Z3jbI30sGOuF7dYzw8QWk7jO4ZQCBU
 sQY1LmDuxqfAEilrbNGEw/sW4kPxhIfg7mBtcLe6kJuPFKw8cJ5PA+kOgFo8CvAgfO/Q4XFMn+5
 Burs7duPVUSujwCTibk2jGFZl7TUW7liPEdGvV+egD1izGIOMZMZ0hF31oWT5s82RKT62Xu4PQF
 lBxyZDTkzky/yAxGhcZeT7dub7OkvLZLZSjRtl2TPNQa9+BEOE9876Q/bHGY6IA+zLGdNi0pFzc
 f4q9nJJhO+Jri/nF3bv3AIPTE2etxnAQweTgNHlhx5oZerSG0BMl6ZQSalDMH6HuHfQuynbBquS
 UPLPxfANR7rrUkW+oY36QAEaXb2jPMClk08w2PAIDf1lmCDJTmEujl2afHYpcmE4NfEx/49Ui0k
 oKGBxWJ/jDJL7h0c1Bg==
X-Proofpoint-GUID: 6HjcJubI8wtz5au9YQXqGVJ1blOR0Ll6
X-Proofpoint-ORIG-GUID: 6HjcJubI8wtz5au9YQXqGVJ1blOR0Ll6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110087

On Fri, May 08, 2026 at 12:05:15PM -0700, Trilok Soni wrote:
> On 5/8/2026 11:59 AM, Vishnu Reddy wrote:
> > From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > 
> > Most Qualcomm platforms feature a proprietary hypervisor (such as Gunyah
> > or QHEE),
> 
> Gunyah has open-source version as well. Can we make it little less ambiguous? 

I doubt, Gunyah open versions handles PIL bring up sequence which only
done by QHEE module., Yes, we can just mention QHEE here to be precise..

> 
> ---Trilok Soni

-- 
-Mukesh Ojha
