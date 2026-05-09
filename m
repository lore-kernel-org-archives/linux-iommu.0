Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5B337CD33
	for <iommu@lists.linux.dev>; Sat,  9 May 2026 20:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778359156; cv=none; b=Q+kGKVm5ynaY5647hqpiWRSDwh4JeEqzksN7IE5/nxPJhniXuoso59Gc17Ssx77zgYbOGnsXCmCXA+POMsC81Rj8NQ5NoxY5gKK1XEjF6nIm8SiDkZtBhaYF//EWc7RJ4RA5VSTEsMdkmkezwH0es3Xcpm6TJwi5a4aEHcLQbqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778359156; c=relaxed/simple;
	bh=i0MNvUXGzLeYjaa8GHDf3B9ixTEyUiY0XHmi+V6kcfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzwzPZ4vJnkWaXVv2QbXSKDgZC6PJuuCDoKDEsq4FLvzEBqNDdylhK7VIgz+wKSyza4npomlTffB5JjZo9B4iYWo6C/BrPRkvRB6aT7QboG2ytWpYNpMQoPXNPe19UI9w36Ik8t3S1EO9i/3vKyjB6m3vpDCJGlDB8vpIw+7dRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DPPBDGcv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kMF44fQV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DPPBDGcv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kMF44fQV"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 649JAvm5867209
	for <iommu@lists.linux.dev>; Sat, 9 May 2026 20:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=8FERYh6VD5a4wdxa/Bnz7uhQ
	P4f/Pd7RYSvqE9Wu2OE=; b=DPPBDGcvwnv8ZYuPGm+6yjucliFISVowWVdRRxu7
	JMYipI+ZwiVn7QJFCWrqkiPLxoHTgD+zR9lgSMZ7A4M4RVubjKkRfF6ZwHCBkS0q
	nKsRiSjPF0hox9elKadYzZrsxRdBzKO5hIqyUVCv7iihilpHpktWG1xIZ/Hizu79
	LD3ZIWiJUKqlU7TEHWVck3p6uwO2RUuXSbeL8j4a4x5dh4CM85D8QU+mQoRRwich
	QDUgNn4+h7h+67vuEvtRq5IppJ5HNLbOx0LCYIkB3tk42UbbG6rcpZeAhIUqhjL/
	j/SSkHDrNXQ7HXxZa7ML1QQex1I7BiVRIslChXv3EjUrZQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1wa99mm1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sat, 09 May 2026 20:39:13 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2ef62078ee7so4062445eec.0
        for <iommu@lists.linux.dev>; Sat, 09 May 2026 13:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778359152; x=1778963952; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8FERYh6VD5a4wdxa/Bnz7uhQP4f/Pd7RYSvqE9Wu2OE=;
        b=kMF44fQVUygiP+Ep5ZgWH8eVISx99gqNPDr8TCLvq306JhPPoozxjVtzAx+K+m9FK6
         Jy7nFfKUiTqCrqKy1E+htk8H8PcXLZdvJyND1EXg09/uBi1jmByhVN4NYopcx/BCmsHO
         dY5ct9ePJdhHT4g+gtPhsH4xOeFqa25GO4RjZrarHV4MpBVsL+QagfJhZ9gXRcGEJvlo
         WRrQqOt1VdiNYfc7xqjftf2VIHLJAHrReAsohihBMquAS6qy67+CJpMXVoOxzx5hVk1U
         4WkOFVnJ9HvJfYd2FfPvpHTpBSjmsqc3gkq3/VfDMdY8sNZx2WIcPWuGe6g0c6tzIbuf
         JSFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778359152; x=1778963952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8FERYh6VD5a4wdxa/Bnz7uhQP4f/Pd7RYSvqE9Wu2OE=;
        b=de9ww63NnjxCzNtT2EpHm+fjVPv6/M9Ibf+L8Rf5K8nVEnez9omuG1brd8ieNWcXMi
         Y1OGwfW0QSYlaCisg0q8c2Db3gkhVaC4Jyjjn9iockGKL/FJrjsZxuCpUgA9zbF6tXfZ
         dYx2xaIFREEs1MGfVdhp7OrpEZ8qaZLDPBuy9gYYIWoOUi99xe0a3O137DbS19PEth31
         jCx/JkwhM24h3tpH+iSjKbiXY51VGqHoUOkmDWfX/2SLla/jTVnm9T7b7vP0i9GAJ2iX
         a5sqqt3UevbtPoCYSxFE31dCHq9W/NCZhEomWk4c1sLYYrPMN7FjkcaeaYLTYJMOja0k
         w2hg==
X-Forwarded-Encrypted: i=1; AFNElJ/CdEcZ0yeFEbvEewxe75LrVnP0Lo7xSJg5Y3MQwefE/Vw/h5yppf6rQK+TXohcvi7OgI7goA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwQi/TUCga250qR2bgWzvSHeoZb5tI6uTXKkt3oJ9WUC7mMPmgo
	vxDehThNSFFgOOBmVpBWBJ8jtazGM4oHgndrG978Try+6bU+J6jQcuUnqeC1ugC0t1FbNdhNyKx
	R0SNUnBe0WsQuvLDK/UcdxiLttQ2W+6YzvKuOX2ew//RA6rODdT/nsskXDQ==
X-Gm-Gg: Acq92OGwuRl+IkwwNRDUDHT0NdjNpt8OzIO9t2VCedl0fMQ9LFA3wy9UC7gky8rTO7v
	YtUynf2P7DNug2dbqw/grvBd1ukrnUoEdEoWhwah9G1I8W1X9zx5CqXX3MRZPzdAd5hU7kps3Ft
	EbMaFF2GJtUOECO0tOpOPdaXBGLHKE99iwfmMG8O9cRolC9SO+ilUqdO+jC28YZpVZwTfa8gfK5
	AytHv9Vwz+ggbUddDmIgq2hFEJr1pXwGdDRwP+LCDQ7QllHcpuyVjoT+oEX11yYVwK7xm4xKa2C
	OLdFPue61A3sOeByL4TGY03mWI4AxOQzbCTX2881NuRpIGGhrXKSCWpSmWIjmLfXphaonhBDNK2
	ewvomeG/N8sKN86w7h6nVEeTiSltqEnQ=
X-Received: by 2002:a05:7022:438f:b0:12d:b6de:8da7 with SMTP id a92af1059eb24-1317d893a55mr8179039c88.6.1778359152330;
        Sat, 09 May 2026 13:39:12 -0700 (PDT)
X-Received: by 2002:a05:7022:438f:b0:12d:b6de:8da7 with SMTP id a92af1059eb24-1317d893a55mr8179017c88.6.1778359151798;
        Sat, 09 May 2026 13:39:11 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13277bb2b14sm9696489c88.0.2026.05.09.13.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 13:39:11 -0700 (PDT)
Date: Sat, 9 May 2026 15:39:09 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Albert Ou <aou@eecs.berkeley.edu>,
        iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <pjw@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Tomasz Jeznach <tjeznach@rivosinc.com>, Will Deacon <will@kernel.org>,
        Fangyu Yu <fangyu.yu@linux.alibaba.com>, patches@lists.linux.dev
Subject: Re: [PATCH v2 0/8] Support non-leaf and range invalidation features
 in RISC-V
Message-ID: <rcxkvq5laonp6mofxmdawg7s5lgxrdy436ksbld22rngp5vrwp@guqmelktxveh>
References: <0-v2-b5156f657dc1+25f-iommu_riscv_inv_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v2-b5156f657dc1+25f-iommu_riscv_inv_jgg@nvidia.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDIyMiBTYWx0ZWRfXzjIqnddko941
 +KQV+8Bk07+4ZUU9h/95Ntb3pK3lLnicnFcKgHrZtQl+eNZH48Js7ZjO+raqIsKp0p5Br85DGuc
 h5bbNXRy5gincLXq/8vqqcacl/cwcbNmtmaf25qfsy/IYD0h3Ysz+XQr/KtnGBB7gY3yeyamjoK
 kXV2XGhFMyPmaCyp6Fjp54xc41CmZ05YB0HrSFYtxlLFoYL5u8r9gzyajjnYph2y8XYF+MwhsTP
 OIf4hQzGfnSyD7mFe9YPS/8Jxaw/IIKMFfTyOUPYsIClLfAzs7RDXNPz0jIrKpFCi2VIzMihYuW
 4N15lAoUTwGDIsQIYZ7aAGY+4ouBJH74Lsf6zzq+jcI2qe262wOM9njFUDIEpSW4NOIVR+8k0iA
 WJifP4DTMACfcHOibWlEfG7mN1Y2LBjwzj4Cfoj4NfVJyRWcGxBOHHIhX4B7dziOwL2sbdrWNIf
 7jTSVK4oaD2uFUuwrmA==
X-Authority-Analysis: v=2.4 cv=HO7z0Itv c=1 sm=1 tr=0 ts=69ff9b71 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=e4hL8whFHqtjNLFC1lYA:9
 a=CjuIK1q_8ugA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: KH0ZEkCjXQPafYlfN1iEURexgavAL0Nc
X-Proofpoint-ORIG-GUID: KH0ZEkCjXQPafYlfN1iEURexgavAL0Nc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_06,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605090222

On Fri, May 08, 2026 at 11:52:59AM -0300, Jason Gunthorpe wrote:
> This is part of the patch pile to get SMMUv3 moved to iommupt. From
> that perspective it introduces the PT_FEAT_DETAILED_GATHER which will
> be used by both RISC-V and SMMUv3 to generate optimized invalidation
> commands.
> 
> I don't have any RISC-V anything so this needs to be tested by someone who
> does.

I dangled some tokens in front of Claude to convince him to add the
support for NL and S to QEMU's IOMMU model along with some new trace[1].
Then I based this series on [2], along with some VFIO support, and mucked
around enough to generate trace which appears to prove things are working
correctly.

For the series,

Tested-by: Andrew Jones <andrew.jones@oss.qualcomm.com>

[1] https://gitlab.com/jones-drew/qemu/-/commits/riscv/iommu-nl-s
[2] https://lore.kernel.org/all/20260508212339.381933-1-andrew.jones@oss.qualcomm.com/
