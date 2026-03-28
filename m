Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B24334C05
	for <iommu@lists.linux.dev>; Sat, 28 Mar 2026 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774715017; cv=none; b=mQmrjwdpEH+Ukqe8Sn0OWcZK5E1EILDOvhp95MJaGXhigemE5D8XKZFGLyO5S4oeqtSIpvylRPFVVWLiOoNj2moNJG6JJs2HOhf9BpFhVj+NWk17liCWXaAoCQQkMReuDA8BZBOW+F5/+i70C2qgNzR0a0UW+NE9BN26GrQdQO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774715017; c=relaxed/simple;
	bh=bz10RpnRFl8RGnsm1XOADROPJLjuB2zjhcKJ61trS84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4/ycl/BOfQOrsXPMv1bx2i0olceXoSVWG7s784JDuYhaSG++lYVcWndb6UsonhB3t9mAjrFu9W3nZcKzHnCe5UXmyeDevY5ykrP89mxSD9hkxomETflUrPgTLmPBh0Ty0u4CGQtXxuAv28VfGdUjXShvu9LDA7NsbFL8pNFnYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IIR4Q1C9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aYxQ3JLJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IIR4Q1C9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aYxQ3JLJ"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62S3Z1uw349300
	for <iommu@lists.linux.dev>; Sat, 28 Mar 2026 16:23:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=RA4nBlWgztaz1cG6MHDMjX9F
	FkozFbtIx4EKomLp8tk=; b=IIR4Q1C9QbVxxc1LXIQj16QxFkq3qHVAkAP47ipW
	SK2uRVXFtOosAusTjE3EOiD19AfzCUSHv+B1L/12PARBXulOwUCPmPQ4P1hWkA2j
	cRUX1prM7ngj2faTfzeN6IMrbkO3mYeVAwrhNkXfgbSq3fb1bGYk5lk50YX3OoeF
	+u7CEOgdzcWO017cWJeWk4PgYNYwQIVweYuDDuBCsaYEIrPVqKeIZ6bv1wsvZUVi
	qgCmna8VMaCUrSuxgqHzBaWalaOVvJILrAntT8mmDBMrjrVhYEqBpcjMxXvmwj3h
	/neSBGMawj8zpU0CYrFBKfI/nwutoEC3+qmhS19QeiUmMA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d6771156b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sat, 28 Mar 2026 16:23:35 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2bdc1b30ac8so3950418eec.1
        for <iommu@lists.linux.dev>; Sat, 28 Mar 2026 09:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774715015; x=1775319815; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RA4nBlWgztaz1cG6MHDMjX9FFkozFbtIx4EKomLp8tk=;
        b=aYxQ3JLJZOB0+PxlOMReH+HHgabyKr9ot2tatdqaYlvB94DzdAFJC9Jfr+DTGBTEV6
         bdNOGEUgT2Jj5GcADBi01o0wbm+hxCTmCbE7rRbmYs9fYJAUdgudRMUJRLHSJXNCxemh
         QJTM1HL7t6yK1ZbJ8Suw9YoAWhJxRlMBsGwhcqWKy7ahPugWjSYsa35MKu7R+CMD/N3A
         TAJlJgepREtxOVEVE9wW7BIHntg+YjN72owVHrcQ+Es/TZgilyzMuBK45JRuXGZ2Ne64
         FuWdjF4pXlLKB32K7ISdXbN37g5vxZjVU4UuY+SxBRvm05d8IPITTk+SUb+tfe5yaiw3
         B1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774715015; x=1775319815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RA4nBlWgztaz1cG6MHDMjX9FFkozFbtIx4EKomLp8tk=;
        b=SKaddp+wumYiJZV/0eIkJwhkEM8mk1nAShh/MvHJceUm9M5WWs6Fsr4pa6K8xVvLxm
         AEkh+Fs0E+RRbER9Vab72oAFojVd5iWVI0/UieUxa2ATcK4N+YEOgAxFlyCaFdwYRUPD
         F2ecB1XIy4JOLJuafnKwZuXEJz6qZ4CFYaAbaQ6lzWEJLkX7kSe8w9qyKB1Rsxo2Q2IO
         H59WYF4EEHTQnF+wZLbiLSLkTRZOxRNTpT5qDF4A9aS0NtRytRjC80tzzXkGZiUI0tT0
         ey0A6f8RAByKR6NtJm82I+vGGLnN9psr3hEckTANo3lVlTrmcOqIdP8wyapMlCf8CaCT
         IGHw==
X-Forwarded-Encrypted: i=1; AJvYcCUDMA3n0tMNuLgWcaL0qrwMaOrOP7X5X2qqn3gow0MWoclVNUKHch/N4M65ML0Q+tzrp7xl/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxETms8fBDfUN+EEUrHPfWvJ6T2nCKqpB5QG0ABmuW0TL7cxMqz
	ly1Q7Lp0/LxREzSHRFI2BNgmSzoqgXzA8F+o85M6TdL83yKTC18nkqnqYwjWARQelPGsx2btSkC
	1pzXZfkLlqxhTCWUDteX3b93M1iCkaoQl50bI7fLkzccWy9E+JVpgkhS/0w==
X-Gm-Gg: ATEYQzz9JvieBmMLysXFygwawrHhLrmV7Lah2UNAjZuSFxE0ArnM3LNcd810MYs/joh
	zYprQhX13kEPGRscDCG2mdnB0u1mZ/Dd5VaWWEt0DYpTRmzH+yoRhNJ+Ss7W4VmOcsNkyD/l/+N
	s+He6ybMmYCgdgozqqDO+0Npky4fOTc7pmDTyOEHnTii7v92gZH4k+hs2fVtL/6aJGK+jpZBdz+
	LO1TEkn0p3bY2K3D38a+F3n/9fOrl6HJ5pCHLWA8u0pG2vujvmKCT+hynmHf3dhEVQPR2UVhg16
	iNAkSRbGcR1L+31654qUD5E8JSoaU17dF+qf70tqR927N5Olqea9HFIiBXXvXO/Cx6ixQTxehsB
	iV6szQWrTSwtytWRb/x/qt6on8I9oAFQ=
X-Received: by 2002:a05:7301:541a:b0:2c1:88ea:9c92 with SMTP id 5a478bee46e88-2c188eaa9a6mr2249396eec.8.1774715014871;
        Sat, 28 Mar 2026 09:23:34 -0700 (PDT)
X-Received: by 2002:a05:7301:541a:b0:2c1:88ea:9c92 with SMTP id 5a478bee46e88-2c188eaa9a6mr2249385eec.8.1774715014295;
        Sat, 28 Mar 2026 09:23:34 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c68b2ff2sm2374188eec.18.2026.03.28.09.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 09:23:33 -0700 (PDT)
Date: Sat, 28 Mar 2026 11:23:32 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Ethan Tidmore <ethantidmore06@gmail.com>,
        Tomasz Jeznach <tjeznach@rivosinc.com>, Will Deacon <will@kernel.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Robin Murphy <robin.murphy@arm.com>,
        Alexandre Ghiti <alex@ghiti.fr>, Yaxing Guo <guoyaxing@bosc.ac.cn>,
        iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/riscv: Fix signedness bug
Message-ID: <uhhd56nw64kofhkgkipzhofwhv6vqbh3lrklzyliyysmvxs4fw@nkhiijvf65q5>
References: <20260319182644.1082740-1-ethantidmore06@gmail.com>
 <gbresi4jgjmt3cydjftumy7f3afrk2ondap4mx6xfjmrtdnvsq@fpv4htqzdcvz>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gbresi4jgjmt3cydjftumy7f3afrk2ondap4mx6xfjmrtdnvsq@fpv4htqzdcvz>
X-Proofpoint-GUID: dNfz0LuCO11JaWDTVFpe1UH3VgwbFjAY
X-Authority-Analysis: v=2.4 cv=efYwvrEH c=1 sm=1 tr=0 ts=69c80087 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=HLK3u_a7HVCP4a0YeuQA:9 a=CjuIK1q_8ugA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: dNfz0LuCO11JaWDTVFpe1UH3VgwbFjAY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI4MDEyMCBTYWx0ZWRfX8cI1OrJc47vB
 PL3AnWxITkvbjG6eDkAdtufr6gqFPDn5ZIR3QU4A4HNMW4Ju11xTGNuP8XcOnvkHggwBLdAv8rO
 vJ0AEneeKjAE8zvPY0VCNK60kfYRrGRxkzxdHrfgkr+90jv4IInkEGZOia/l8mOQkOt1ORrhvi6
 rYcV2P7txESpfzVcJpylcHqmQJqOilBtlyVRH6auGGXIfR0RZcwmAb0HwI3zmDCOYYJ4nSFJ4Ls
 x5DOvEaBIeNSyu/Eg2gcDj5VWEiOnQHDCqV9EXcKB11sFQZbjO0Zl7jiE3EOYjzmshrv4lTVPrB
 dNgreg3t7ACAIZslX2ixramaSjSyz9ukMcuQEA3NCdesWJDVl1+5a9D/NiLO3VEEOATuYBdprVU
 cPZ7JaDDJ3UzP7IigfCYZPSKe+mko6DihuyVQbvxSEQ49gk8/cemBBkTDMAaQzSwlYnehHJFNYM
 E4NHIshbOPXzVVFEyVw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-28_02,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603280120

On Fri, Mar 27, 2026 at 09:35:05AM +0100, Joerg Roedel wrote:
> On Thu, Mar 19, 2026 at 01:26:44PM -0500, Ethan Tidmore wrote:
> >  drivers/iommu/riscv/iommu-platform.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> Applied, thanks.

There's a v2 of this patch with the fixes tag fixed

https://lore.kernel.org/all/20260326175738.750060-1-ethantidmore06@gmail.com/

Thanks,
drew
