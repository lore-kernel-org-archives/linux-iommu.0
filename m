Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817AC480954
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 11:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787310884; cv=none; b=GGKFEW1kVpqnLhvDA9IbX4I3VwRy7sVpP+Hmub0glv4dz7gR5/EcR5+9VmNiSocqOsIDz6CPSRxLNNTeOGOgGzX22d3Cxj0uIJpjfnRQlgC7eJBtg5PN3slump/cXFAQ5U4EAHyNm/rgjxjFEYK1cCbEXyrqUPx1btA/7C8KIDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787310884; c=relaxed/simple;
	bh=Pz7w6F0HTt3etRprcugYEwDiAkrMKcI4s1lQ7khDUjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVs7pxJfPJFsmkoVPjpFOGk7/eI//y20EEU40XYdlhnaeIbaj4h3tqoZWrZVZu+PTnXvSOW12FZjIRm6DSTRq5XY4vUww73p2qj2u7EoI+sQ/nz4MN67y0gDE5+ZWhdPEgGnGGMvUkLBl5OWq4kZHZGuCUFI4F7sNYszS3OhCmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UCo7WSoK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OUw+I87+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UCo7WSoK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OUw+I87+"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L9LhfK1983003
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 11:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=FvY/dx2tZJnq48L1ZcLITNUT
	qVoeCwSMCgjTMY/C3po=; b=UCo7WSoKr9K51ZPyMNNxv2BXQIcqJwaHbYv3mP10
	TT/2O0OhMWAvBOGyqHIypLUzujK5Beh+rIyk8PX/vSmrDR98IX2rwaNs1YwL92RH
	bpwuHt4VQ9OoPPYATMT5DXAgmamCj1Ay41m/GrZ+v2eTxFD5KE0QsLxwF4vQHlAo
	ttcLnjhqvO0mXF+DxYX5DGxPOC4YtTdyROdAknWvTSfx1KiWHNvb/PxdIxXEIAWN
	qRGNO0n+EOTspqP08WPr3eve0L+FoeNucjrJtdKft+rpUWyzPN+1gXgaU20WJ+AM
	m3D5IRuCMGFhgceIoeAJ9OiqnLxEI87UktZtJCG5wC2f1Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6cdsj0my-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 11:14:42 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c19493ac2so9088641cf.1
        for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 04:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787310882; x=1787915682; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FvY/dx2tZJnq48L1ZcLITNUTqVoeCwSMCgjTMY/C3po=;
        b=OUw+I87+4oCT7CBQkG+bpLQ+fNA/c/8FfncgfwmO6Ssn43c3nuj8SnPepyfl7JpuWS
         +hgv6U3QPRsPkvYfF3KaUKlFg9WBwFvJfqv41C3LpzEo5WHSL9VEYueV3ir8GQuIMk3w
         t7uIxoCTI6qH8CljA7vNh4ACsvev7VPggn77I9NfwNlMil0Zt2PTI94dvZSG3jvIJdgp
         qOgIpxicbJUs4PfldTnhmOh1khTOikD7pVOmYPn1IYC/NKDGZx3ekWIFPE6SjCD91teU
         V9X6gJHQwQW4liruqeh/yOTwn2V5Jr520hglvlTJxyMQIqUbMhWrNGp1elK/Co/gUMit
         KcTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787310882; x=1787915682;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FvY/dx2tZJnq48L1ZcLITNUTqVoeCwSMCgjTMY/C3po=;
        b=kVWEvbUbKph5nLRLcs/YQW/R9mcJl5b87z+T1uUAwQ+eUefE9oJk+TYuFRE/Qu/f1i
         /PJS+cCAMrKZJv6v8i7U3a8WH9ezxw91CnB4XPpVBYWONDBnAUSO7zSGigqSzXnw1ZaH
         hTp9ixenOhAOqiomKpSjTKXG0QthBbTM4HOZG2cWxw/29IxlhKel8BUGbkirAHVmduqA
         Hi4ioLudsbf31cxLj6VpktfG5ZnN4ycPE8fy/GwCVIVBhZYe0Is+g2zVidyUEZ7uGFlP
         aoWbWytaha2qmA+cU+RhhMfH9KTQVEd8UWI6cBATPsweQnSWs70Csg/drFMvx2t1pU7V
         EWww==
X-Forwarded-Encrypted: i=1; AHgh+Rp0mFZOs9fdc3xXYWc3b6KW+exd90hijjN1J/SCfikgqD33274vUsv83+RpUj/tmK00KBcoeg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy0Ij/jPx3O3CS4KT2ieItp3cMyjboXCj76XPyrti0y0zGChr9o
	RW6eOhnsr2007c4YqNr4Z9gQDzBnqdfATnd3E0aCB6KOztgszCZvi4iyjET70D0DfzidmpagdW7
	e44dh84ZSpqFQpF1c8KgKHj2iZxeq7IUfX/XnDc1KtQXm0ND+SrPMxLBAZg==
X-Gm-Gg: AR+sD10C+y9xaP6+tv1JU2Z7s9pjUw7ldG5e4ERzvo6tRkkV3faF3FaIItpZVf97NXK
	DbOEqmSwz562HGi3zssuDqgKZrUHpRQm6qqkw8Tv5O628A71L9ZdXxZXLIrde0d3/W+uEWVr9xW
	Skz4v/Rn2YzC5OOLITSqqHa4V+quvuExIxBVi0coCpnZMyYw/eGWuUqnihKb/AWcr5vXO5RAfVg
	/ShPvy5i1tjeEkRgjtj1Y73G74XC5PyMG6o+Z4SBru2XY2PdcsBipBVzhSTOZfi8dEG0eEOOYjF
	pcDYnQxdP098BbJXisNwX1uDf+FrowVouR65blwrlM3UXlKUAhb+8VJPjFU+EKgB5fflsW8guPI
	q38+XLmsZUuM0SENhuNKI6twCVKM4h6CBBSI=
X-Received: by 2002:a05:622a:1b0d:b0:528:15e:d1d1 with SMTP id d75a77b69052e-52df57472c0mr47025111cf.16.1787310881673;
        Fri, 21 Aug 2026 04:14:41 -0700 (PDT)
X-Received: by 2002:a05:622a:1b0d:b0:528:15e:d1d1 with SMTP id d75a77b69052e-52df57472c0mr47024541cf.16.1787310881183;
        Fri, 21 Aug 2026 04:14:41 -0700 (PDT)
Received: from localhost (ip-86-49-251-7.bb.vodafone.cz. [86.49.251.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b9a89572sm17217655e9.0.2026.08.21.04.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 04:14:40 -0700 (PDT)
Date: Fri, 21 Aug 2026 13:14:39 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
        anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com,
        fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v4 13/21] iommu/riscv: Preserve MSI IOVA state across
 domain replacement
Message-ID: <wshoqx3xyz7f2jmhgbyzpkm4ppl64olswhw5u6dye7nmomkari@j2zg5ecuvsmg>
References: <20260820214150.545737-1-andrew.jones@oss.qualcomm.com>
 <20260820214150.545737-14-andrew.jones@oss.qualcomm.com>
 <20260820215204.GD244917@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820215204.GD244917@nvidia.com>
X-Proofpoint-ORIG-GUID: GIoArCstNbnGxdDN4qA7MdLbmP4siz8n
X-Proofpoint-GUID: GIoArCstNbnGxdDN4qA7MdLbmP4siz8n
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA4NCBTYWx0ZWRfX0EzERjcV1u63
 FWpp6RZ2TRyEHlYIpCPTobr7tHO37D1igFhkoTptlu+3l184ypbFZVB08VTSZyR6S02OtdWIvMj
 dMORxlprIIzuq5phx/cLvYGhDHnnOkE=
X-Authority-Analysis: v=2.4 cv=RN2D2Yi+ c=1 sm=1 tr=0 ts=6a883322 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=on9AXyaqQ0RhfYpiXjjEXA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=hoD8RvqBUdAnX7eObX0A:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA4NCBTYWx0ZWRfX48BeIcA+NHfa
 fe+qLPgrn+zgCqt7WTw/rlJ1Ew/CWYQUiq1J15lA7EO1khjwiUYsGaIUUdTOrWrp9NgE18cXQMi
 8oTjQzciWuHyc6TU5plhtQ3r6zkuAIN84p9xE3P9mWKFGxKpvEj9zBD38gmtUBxK+I8eywIpBk6
 uJE99UiR9+9R8r70SbZwqNVGcwzHEmr654PC3B3vR/nCHdUj1T/3wmO5ycOWwCoE9ONOOW0VO3W
 jZXtdEck8Eo/tGBLJv8LgT+Y8HiNaZ4frvvGeWLmvV6MMk6G9V6tBHOVxEeHdIltHk6B+YpR3qn
 BRykDwaIpQk98YmKDZw+HGXvXPtY6617Uu5rgZbT9zl+lTAuCtvMjSVtevjFkqZQ0F+AU6QfV0U
 NzM4dSvfaziokvNetRDb1OAhzF8NF1o1dKt8b75Bd4x6VdxUHKqXLdftnO41zeXGAMF7FHx0X7s
 Sgel8mFihbIEiRBomkw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210084

On Thu, Aug 20, 2026 at 06:52:04PM -0300, Jason Gunthorpe wrote:
> On Thu, Aug 20, 2026 at 11:41:42PM +0200, Andrew Jones wrote:
> > MSI IOVAs belong to a paging domain, but iommufd may replace a device's
> > domain while its interrupts remain allocated. Waiting for another IRQ
> > allocation to populate the new table would leave existing interrupts
> > without valid MSI IOVAs.
> 
> ???
> 
> iommufd is supposed to handle all of this itself, that is what commit
> 40f5175d0eb7 ("iommufd: Implement sw_msi support natively")
> 
> is doing?
> 
> The whole point of that commit was so drivers don't have to deal with
> this at all.
>

This driver relies on that support. iommufd installs all required MSI
mappings in the incoming HWPT before attach. The additional driver work
is to populate the PA-to-IOVA lookup table riscv needs in MSI composition
on IRQ affinity changes.

Thanks,
drew
