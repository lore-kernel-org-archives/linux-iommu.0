Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794402246;
	b=UegwLzw93AFqYqavgOxAHLcjaPZef4z+ZvVHkEncrr2oEqW8xh1iZfaZTjEbkTjgh1nV
	 TE9QCDJNtudemmQ1mYheJMob76xJ6unA7czTx1x71JBzxRm91dDjxqAUyBuElvB03fPXv
	 cPckpw3koeO1O8lcHLy1fif1dK6kBiva8F708N9WLvdSjSZzUCczUdrMSRzBADMZmtKni
	 7O3ts76hZB9mdMyGdHH6E2HOgOweXVn1S4QLo64soqOoU/vz6q6y4cAH82Mlu6G7NOfUn
	 PjDSBLEs4rYKRh/nFgPOKXZ7xO/nYSd3Kw9E94ONCH/4cOqXpRDjIXzq0L04zVyp6Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794402246;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=hXFO6nUxnCW4XbKSEmI+WWHTtNiBaotTU8OUh9DkrJ4=;
	b=f7ZDX4HVllYvTwiYqwIjqworHbUJA3BxwLIKT9DnoKka2m/RzfhrqHFiP7tiNHKHqZbS
	 ByhvPEm3RUa74dF7txzcES+F0K6l2FOw0cAKaggKIMK8948uo+Z1//WBb5XKl0W5xVA+P
	 4MrNtlnWs4uJ5Np+4xVP0aBqLr6+xfmD/35QkSAOvyXmPqz7ns5ErucM0oZ/wk7DHHz6+
	 AAZG97xFRqSygqTFZTXAk7rUH05JD1Mmz7wnlSbfvGvtrUInxjlowhTXJroeRNfgH/z0k
	 +w6apgMgpZYlmzQEcJPIRr6QdKyEzTtqqpDl1clUEPip4gwDmIWSyRm5FR7DDYAeBaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZXQgzpip;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MQJyuIie;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1EA606A31C
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 13:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D1EA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZXQgzpip;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MQJyuIie
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABCZBOQ2288020
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 13:04:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hXFO6nUxnCW4XbKSEmI+WWHT
	tNiBaotTU8OUh9DkrJ4=; b=ZXQgzpip5uTvPSftHjwaOcUkWjomKAoZGLBjeYPm
	o1VQ1fRKMILYH+E2uFvWC/UqY3Yc/4Q4Cqy7cnrDFiv4EcuAgnTv3xA+bwMUFWPo
	TOKcHIcBcPBQwTeI6WiNqonqVAiFrS98rjxib8gIQlgalfftVkLQgbSl5+8L9hzN
	2ojK22wdT3LQwRit1G1MrsSzRYQ9WRi5bskOADsWRZ+IDlHaN2bK9DM4sO2KqbBD
	n6fexJdluRTZPVh/Q0Ax3hc2fl3bhyCm3VDwbPe0oGwC43BtkpXpu+dDgqGY0ShZ
	vKLCnaMizQ98DjuFwWT3CLzuTlwV6efLjINJtlAuzKZipw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvksm98uu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 13:04:05 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-999bc06bfd0so2216213241.3
        for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 05:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794402244; x=1795007044; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hXFO6nUxnCW4XbKSEmI+WWHTtNiBaotTU8OUh9DkrJ4=;
        b=MQJyuIieYoZ8WEM1lVUkYrb/nczSWyIpRxVB1g7LQ3MmV5yxjqgYZ+DsCAC9a3ufEK
         d+NUtGlXEU/1UypJkD7hLJE4+86sdIsB3SszauDX72+ZHa5+rBgSt+biuy6zCakcEgIC
         ibte0mCZP7ihSAFz34VfZowz9GxTQwGXzssGCoaDDqVRU0tVwMXfbl0/kw55hL/Rqj0r
         hYRRye6a/juv08OEd6vnakL5hbxMLhhmxxlQAnoenYSc2ULFjerEGffPMc+lIawMe1Bc
         jwcwbBRhBdbdfgJjfVYjSKQlulEWTpFHuqLyA98yswuqwJC4neHJWK94ZNxZUpFM9TId
         wgyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794402244; x=1795007044;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hXFO6nUxnCW4XbKSEmI+WWHTtNiBaotTU8OUh9DkrJ4=;
        b=IWOjJYU56SmQJ2cWuAMjPqnB6pOkAKFDyQcfUyQmt2VNFkTzxORn8u+LbYwtj03cKs
         imM2UVqM4ubMzGmsxDsnTDDDVMUdHuc/8IPNFlfGCkVidtdUioLmSzIIdhv+Hx6apl+q
         T4l0RmcWieFeWM37ntWcKzWBSSWW5tVxRzSRW2r683qzrIuRF0DlVW1d7B+Bis6s3CHY
         tiJ1ClD65a4GObrC7L8QloyiCtIeEbLp4an7EVEFQRhJhbwHzQDmHa1dDtO74xKRMBOX
         jnlPIT2HGybrUW3SRKj0Bzzve/9JMIDeUnTZn2bv5YmmFRFdTG9NGhkUarQcBFZRN18L
         1jFg==
X-Forwarded-Encrypted: i=1; AL+hErEHKnTKX1tlpsBt8GfR246ovqfH83OTMpwwBLInkqVjVfmMev3TGlqmu/s5oYi7nPoJ4IWgWQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9xj/qu1VdzuJV3dZq2A0rshTL8yuLL7CWn9QKZoGDlTBYcOEJf
	0JDNGX+6YAJRs0yhDlPuxFmLzmoIrZJ3nHaeDRyRLwrJ9q+7jdtPa24AKBAYt+l6tFZwPVu6b0g
	4E0OGBERShWhxc0ZIP46o70Bn1TN4BQl4kBGp9DVupNCGU9U3pr1kl3B+0Q==
X-Gm-Gg: AYBFou1Alcw0f9eryhyzSuhcRh7AWMkjz3Me8Ms+Hsab92s6Wh8A+mArx6H/9j4M5/c
	vmZavPiRvqp+7mYYNTqG+LncVoanFyDM5wg7/5062spnNLtCxj76iWM1mHdvoT4eHwFPAc37LNk
	Yfmc8T20bcQai/puTK/yHcM/U/xdiNRmDS2Wc8LSJNrXUNBiuPqBspqvJEdivmMmlC//j96UDgQ
	1Sd/2TTkM/ku22316NvdKLlUUSPfxs61yJk+Ta/BSSL8Gb+OXVY31apwL85IcfJA8LzmeHqg3UT
	fMm0wRHdywYKoiSCkN3Q+EDFoBg0w+ZBP169MouMoABw2lrwpmHnnVQT0uYmRQP8/k4xjQ7stAP
	EeGDNUh8lCJxwqgGpzL5wckJQmq+E4HoR5WyMxrmC3OssUG5zOYcj2qIAeHhTQD1JZJPZtCnN3o
	MzxSsuzhGM+PKyYDV08LsNeNbr1y+IZa7Ug81MY+GxEHpY0sfd5pkh/IwwZdT27Q==
X-Received: by 2002:a05:6122:1d8b:b0:5e5:1be6:e12c with SMTP id 71dfb90a1353d-5ee1c490338mr604724e0c.21.1794402244042;
        Wed, 11 Nov 2026 05:04:04 -0800 (PST)
X-Received: by 2002:a05:6122:1d8b:b0:5e5:1be6:e12c with SMTP id 71dfb90a1353d-5ee1c490338mr604634e0c.21.1794402243470;
        Wed, 11 Nov 2026 05:04:03 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c157bb758esm944566e87.67.2026.11.11.05.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 05:04:01 -0800 (PST)
Date: Wed, 11 Nov 2026 15:03:59 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jpb@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>,
        Eric Auger <eric.auger@redhat.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Joerg Roedel <jroedel@suse.de>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Oza Pawandeep <quic_poza@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex@shazbot.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        devicetree@vger.kernel.org, kvm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH v7 3/5] iommu/of: Make OF_IOMMU depend on OF_ADDRESS
Message-ID: <yvkcq3zirv5tz2amfbk52a7smbsqs7jrzdisq3qxzw6xkoxklu@rplx3gvxhcoz>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
 <20261106-add_iommu_ranges-v7-3-5c0f72083e52@oss.qualcomm.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106-add_iommu_ranges-v7-3-5c0f72083e52@oss.qualcomm.com>
X-Proofpoint-GUID: rzM3iNtDaE0l-zzinlt3LPUn_dopcVr1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1MSBTYWx0ZWRfXwfdnHRmqgY+A
 ev0uhtQkRzSOwx8iOxNSUd9Y55b2SyiuTziCJYyvcHKNP5QR1gE2cPfjtqlbUs23jn6lzu5QXwp
 cxg3Fwo8TiK3849Zxl2kqmTayzJlPVK3ICcJ4a4lsl4lDkBcY6ryM/g9DBYflFQ8M0liwsu56q8
 a7auJEzRqDYnLGJHDi+nCzV7whW95yiEtRDu4bw9oVr1QTqvdA1ShS/jhOy965SdGbvWOOr4dvo
 BFqg3Nz/TxBh6zwvJ60zALrmOQb+8GwrjcB1fnzBhaiZBFY9yoMPn9/o/HioZ8YL6AD0cECds5D
 t5HCCbSl9VtKK1DHvh1fst0Pv0QwnKCxG73OZ/Vms0/8+zfDjiAYmjqD5M6ZIdPPZM3EZd+S+fp
 PogjtAXA2D31vGBE4fFqEWnTYq6zhfjFL+1gD33rm0qI6QScYeHsXPfruMq4xC4hk1iCPxxCKap
 trnbfKQBa2h3By0iA0w==
X-Proofpoint-ORIG-GUID: rzM3iNtDaE0l-zzinlt3LPUn_dopcVr1
X-Authority-Analysis: v=2.4 cv=O9isLx9W c=1 sm=1 tr=0 ts=6af467c5 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=icXyEQzqa7ihQCE8Zv4A:9 a=CjuIK1q_8ugA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1MSBTYWx0ZWRfX2bu/5Q637iVy
 3jRuRKUaCa6n0iDpXbELSKk0w3zKMSvTqxCKlU0kldjMcqzivRSZ9DB7FmMPh3m6K0UxE4vEgDP
 YTpuBdwzfzu8u0V04rX4L+SzJ8pWvlM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110051

On Fri, Nov 06, 2026 at 10:44:26PM +0530, Vikash Garodia wrote:
> The OF_IOMMU code relies on OF address parsing helpers, but the
> dependency on OF_ADDRESS is not expressed in Kconfig. As a result,
> of_iommu.c contains CONFIG_OF_ADDRESS guards and a __maybe_unused
> annotation to handle configurations where OF_ADDRESS is disabled.
> 
> Make OF_IOMMU depend on OF_ADDRESS and remove the now unnecessary
> preprocessor guards and __maybe_unused annotation.

Why? What's the problem that you are solving? Why is the current code
bad?

> 
> The only architecture supporting OF without OF_ADDRESS is SPARC, which
> does not use OF_IOMMU, so no functional change is intended.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>  drivers/iommu/Kconfig    | 2 +-
>  drivers/iommu/of_iommu.c | 4 +---
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 

-- 
With best wishes
Dmitry
