Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164FB412270
	for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 12:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784204778; cv=none; b=nB26+5RH5bAvqiKJKC9c+P9308YhRs8BVrMSp3XQhiWwy8fTx1rfkroS0Enifva1UaNo6tV/PM+CowW+tpATn0DTAsgNl5P/eX2dXNsibtcomMiyeovFhQG84Mh6kjiiRY4yX5X9Dn6N+tPpYUUjxw2GXXoqdZ/YsarcSsk9nCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784204778; c=relaxed/simple;
	bh=FwgUuktWlKEDuO9hQ/D+uCsYBI78tLaDcu4N3uVEcwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5WSuychjxFX2nRUBVWuEO0i+AHJAycaZdYCLesmyvJ15IOqi5iUC7aofKFrt59skq/8IVaJ0vcywboJyVdHcG4mIaTCe8tL7dVLSu8EFIdte0Gq5ME1KN64NMgwMbFcj78wbM6EQ83JQLYPuIcTofz8fB7fIp/IIeu69nLP9rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WN9ZOkio; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KNhreo2k; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WN9ZOkio";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KNhreo2k"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GBiaue3747280
	for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 12:26:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=0IxISuJ62EXm85nVi30QXZSl
	UArQyp0zpe3atXf2f9w=; b=WN9ZOkioGzp+oOtdH2jEA9K4+lZUR26J9qJB0Rw8
	ayPzszB9RP58b01sjy1CNIlKQ+Peo4ehIvoSgOQ8tK9dbOa7wCl8lAJvXSXDf8g8
	fcAjQUrHT0RB/R1BQFyGWT4hrDMKMcCffZF1LjK5kD4Womdgh0qf9uJGQQvRPMOF
	iy/3C9G7s7/Wtng4OwsiBSjT2wZRXjObbslz4Gv2h/z1nXcyfgqnPkKuvQRwmrxE
	BxqQuHVUYq0loajXgLeHnZa2cQmF7kxXU9LaUW2fO6KwvYT163p60yqsfo5m9HTi
	EAF8wPXhkTeOjR2KN76qwh7PtML/BYpOfKZ0fioqzTr3FQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feq3pj43e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 12:26:14 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38dbe39ce62so668132a91.0
        for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 05:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784204774; x=1784809574; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0IxISuJ62EXm85nVi30QXZSlUArQyp0zpe3atXf2f9w=;
        b=KNhreo2kUTqwVmFbqujkymCZyuCpuNjbU2gtNigRnqLfB3pbANys9i9dWt/REAKS/x
         ax1oyW1N7bmMMiYwHM9Je1/+0ziBmO4ux3ar4jnFZXI9S3MiaXq9Dc7q8T+qs+0ij4gd
         SE1apdXjCm+XNLi+ToOf4bdnS65LV1dMXIrN64Gy2TxMa1g38usK8qAB8X9xKR07UEQ5
         Kpwz+P9RmgAQYUY7dAxBxoBRHj0LT6Q74n8iLCd9Uy32qqKCsiY99iDJDXEH64M7Iat7
         QC3+jGALxlO4QHBK8asrMN5IcqrRG804vTbnnkz00gqJOTv2qMU2IW3jaxQ/EZU1ApzW
         8ioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784204774; x=1784809574;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0IxISuJ62EXm85nVi30QXZSlUArQyp0zpe3atXf2f9w=;
        b=XOZS61z11Z2Shk3rqFAyEyx7masGdf59HoPNG55d1fZa7FGNpFHl9cm0ePo0LAHP1Q
         V0qAXi+DQ6Lwcbi+ChikS0klzQowJNHyjHA0Pl9UpiI3BdKH7OhIxSvIo9wLXyl9RbYX
         DTo0h9umvyupYKDUruuqWRtgKL7z3/1K2E14jpDBH9ZQNQq1OzljrEp9TgwtyiMwG/u1
         wzfuWcuHqXM6juoCpNr+v5Zw3I2sUDwHItwK4MDtGGZ6XVs8sjilSqE9j7MMzVvA5cE+
         2mhygNTTnFmC33BVib4jjUZ5NGlnp+AGpXd4Kn03gtaSzsvjyMZCvqfW7DpjpD9mBD1v
         9SZA==
X-Forwarded-Encrypted: i=1; AHgh+Rra/+ttiREx9PIqxnVi+YVV+5RhfoXtb9JUnNPeFZyNYx6+kgx/1yr7FM24hNjtQVzV36Q2iw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7UvPzngFXZUd51xRItgGbnDtHT1yauX/eyulLfXyHSeSREpXp
	Ds1b7KIS2LvtMjRas0RCZtlQ5zfhnLUOR92ITrbj5lVT6cBVmuIhLlLKgAnyguHbsFaqnJLICQZ
	x2r6q562grBnxPDGIhRepH29nNZDheXPbA2NUc2m4bvXjcIX5UnE+QRC7KQbIFORu4A==
X-Gm-Gg: AfdE7cmTndTLj5xQ2WOK5lDJsb8nQam54XdeCG0oZJiBPzJBLQNEPSiTtynASsgm3M3
	maCrLS7WR1Z5xyAhtoGIaDBaEE5qOI8Yrmy0Stxvs/U8VdX+ehgbEEDChLeK2nrurJIMppop8US
	3lYiOj15k7otibx0FEAew9wfqnqgXoLKqfPhgdY5yPud6fie7nUkfgBmrqcbZMI4Rdz4KkEDTdN
	BIO2gvPTt0XCgHFR4oY4b4ZX8zMdT5fkXy5dq43mRC1Ooq73xnb4Zbl9qVKIWyzxx68cvVm/KBb
	b5PVpN/2vYQBsSEfDphOj3vDt42XyohsnQeISH51WUKOiO/TjL+TiQLNNeSXn3oG6c35Zd+LzRN
	sVZX8li9F9wxHJDuEI2uBiijCdzk=
X-Received: by 2002:a17:90b:1345:b0:37e:1620:dabc with SMTP id 98e67ed59e1d1-38e3cfd30a6mr2342239a91.0.1784204773866;
        Thu, 16 Jul 2026 05:26:13 -0700 (PDT)
X-Received: by 2002:a17:90b:1345:b0:37e:1620:dabc with SMTP id 98e67ed59e1d1-38e3cfd30a6mr2342202a91.0.1784204773304;
        Thu, 16 Jul 2026 05:26:13 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e3a0d69sm12253893eec.0.2026.07.16.05.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 05:26:12 -0700 (PDT)
Date: Thu, 16 Jul 2026 17:56:06 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Weimin Xiong <xiongwm2026@163.com>
Cc: robin.clark@oss.qualcomm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] iommu/msm: unwind probe state on registration failure
Message-ID: <20260716122606.ybsdajd6qgomte3s@hu-mojha-hyd.qualcomm.com>
References: <20260716013229.91014-1-xiongwm2026@163.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716013229.91014-1-xiongwm2026@163.com>
X-Proofpoint-ORIG-GUID: u8UaPFYlFJSEnHvSTJeug87W_0kFMqdS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEyOCBTYWx0ZWRfX7HlQu0jAt369
 +09x8AaGDSYuxUVGOlNOh8UvLjxhpRW1S+KHrDumB5C1cmTh+heicjunElOqyAktaDTF5L/miAL
 8mD4otyiRmt0QyV7Rok252/MBjKbUXs=
X-Proofpoint-GUID: u8UaPFYlFJSEnHvSTJeug87W_0kFMqdS
X-Authority-Analysis: v=2.4 cv=PN8/P/qC c=1 sm=1 tr=0 ts=6a58cde6 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8 a=EUspDBNiAAAA:8 a=qwb6liyLOyoGEZliCEEA:9
 a=CjuIK1q_8ugA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEyOCBTYWx0ZWRfX5xgItGABCA6M
 ZGN6hbohGG8asES9sY8SyptKw+2H8lwjCXLKjRIa3uQY5fNbScz8/azdl8bBeCtqiXHXxrINNUU
 d0pfHEMfvXwSqB4WoVdRopw4RQQ8BM3mUPlS3TUDgLti0WvWYsylBBd07451n4oswzwLMGo8llx
 Jwb3c78LF1IAO6n0Id0X23+nM/XRHrY8ot2tcC3BLeN+ZWGEQttB+QIIoUJ/OsB/vqc8H2PcOAq
 DUlmZM4o/+I5UZ9MtfLcZAUEn3G3CczfG/xBRTheHZT3CqD6wrhV5tBFrW5I16J0laD4cADe4BD
 yrYWEvJN9dvbMNOhMIgedozMaZFzoWOiHghXOXblCIRZkTW2qunsz4i2+u0BatqwRkVxT5r/Ny4
 GW0NTiq+/61AOms+CEpvHP6Mvqee/SqHtj2H0HBd9EgX6+jAlKat7iHnYtq7OOjncSVnb2LjuQ/
 MfFpGn+7K7uHrRTI81w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160128

On Thu, Jul 16, 2026 at 09:32:29AM +0800, Weimin Xiong wrote:
> msm_iommu_probe() adds its devm-managed IOMMU object to
> qcom_iommu_devices before adding the IOMMU sysfs device and registering
> it with the IOMMU core.
> 
> If iommu_device_sysfs_add() fails, probe returns with the object still on
> qcom_iommu_devices. The driver core then releases the devm allocation,
> leaving a dangling list entry that later list walks may dereference.
> 
> If iommu_device_register() fails, the same dangling list entry remains
> and the sysfs device is left registered as well.
> 
> Unwind the sysfs device and global list entry in reverse setup order on
> the corresponding failure paths.
> 
> Fixes: 42df43b36163 ("iommu/msm: Make use of iommu_device_register interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Weimin Xiong <xiongwm2026@163.com>

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

-- 
-Mukesh Ojha
