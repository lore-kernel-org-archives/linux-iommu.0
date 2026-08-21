Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FB51EB5E3
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 14:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787322210; cv=none; b=rGrN/DaNK8EgU4eEf019JgSQsw0tVPvMt8ROlOH9aoudhX6KWWkcE4GHiD5/2+7PM/QFBo3FlGHPNzjp4dklU6CGwKJM1JO3tbZ4OiKEWGdiUwVHJ0c9rDF5HSarPvLken2sqFDGh7pxbUREeZIRaMWFPUtkULT8JCg1zS5+N3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787322210; c=relaxed/simple;
	bh=RCZ+eq4zZA3VPN4IbI8Cheork12hwxK71BRihYpU1jA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czABfmijpQLaeCLEPShujGr0zlg3enY8Tq3kpwZOmb1JRl1ReJV32pL5HR11lCOuCvF8baEL+6GyTAdR8a9lSQC0uOPdOw1+2ffE6MZ15KZgrsdLAGNihduKM3N2OF5WHt/nLNMcdQuVDHVzm6jYONv68awyzYIcJ6CnDQpWaJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eNmHpPL+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SRLJGo2/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eNmHpPL+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SRLJGo2/"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LCoMEO3489437
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 14:23:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aAjaC/eX97Qc62891l39Bqzx
	7m2BZLa4DWDzydgpsxg=; b=eNmHpPL+w7A9GNDiGNVj+XKJ+bMy5ITEt+9oMU/8
	69ywfuFRDIMju/pzphcM2O6jd+UmqSjSEUTtMH+EeWizoSJBEPRP1v/vunWt6YUA
	86s4KafCRdHh5xkRHy1oPVo0qNQp+iqFGQ2+vodk2qZ6/LXUrJt87UOZOD6Yb0M+
	pUBECBKBEVZd744x7tAB7z+YED5iSINFmlNxhwon5uWlhesfIxpomnIKJfzdwWd7
	Phl+unYXDEZQmowRqkqCQ++wakLGmW0dGGuuwukqIOmcog8lLRANQWcSP7BbZE4O
	alKpwJsGa9iJqrl+DJSA9y+0w2xOn0Dm52zshRzjagblQw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6fg9t4y3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 14:23:26 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51bf321d786so9939111cf.1
        for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 07:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787322205; x=1787927005; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aAjaC/eX97Qc62891l39Bqzx7m2BZLa4DWDzydgpsxg=;
        b=SRLJGo2/gWxYjs+5qPpNv0RHQAL/hvdb6n12cCmYLOgDoQffvT6DioJFhMszAR/ksK
         1aFRK2wEEfapgujvBz1QXd4afEh4q9bjY/63rGEU7+zj2zpWmkRsmwsLE6Wpf3uMxN9q
         qXwwfXhijsppbH3109sItOnp/YmGediN9hjPGdbZm3bysni94mrCgcEMuaSdI8tMsJsz
         XKuATfE3If5zLWdxnV+fHEA25BfKA7LBvj/q/9wttq/MRQFkSf7S1yTE2vQ5l4QrFoAR
         4mNjg5T8+sq8SFgwyztL+6tdDH+Lpt3c2ymQ7KM/eihLU0FABEUtb9zJFfgS4YRjzjhr
         5rrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787322205; x=1787927005;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aAjaC/eX97Qc62891l39Bqzx7m2BZLa4DWDzydgpsxg=;
        b=hdz8RTOPUvyuH5wC9gnF+7LPmXgDaQUdNtfk3AXyOp/Qg5KaQoq8fhCh7yCjnL4m+2
         L2fysKCQW6VPr4ILlOQvNaqJpeVFVgQeadBv0NBSw0Px/u7vHcN3sR5rmUEe1MmvjH3U
         Qgmy7dkJm1IkGZr9TOVIpDjzbXjLbkC9kocyEj9TM6O2yRIhfzWN5F+8aUAODwEnEpaB
         qMid1o1BFsGWaassvN3sEzUK2WnyKjfik06Eqvr3crwmr6KcWmP7SNxkALvrZBpZzAUH
         99gxkLcdlcRcvd4zHtRQDLjhA+vrhp2UUw1OJ02XS4OV7d1aZ6PZeSSISwrl8ztDQoMd
         z9UQ==
X-Forwarded-Encrypted: i=1; AHgh+RpZM0qYngFrAiKRnA1/YNGVGUefES9utbomXcKyhNlKK8sjdTwo7IqH5EK4JeakTyKFZlqBEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5YRKSn/LXKvG2nUgjyN91nIgN4ZVgU/USDsiFfgHpTDZk7IJv
	M9EqoNV4oOJkyUTv6ybt+aN/wDJshlYVBcASnj+al5p3RnsSpgyXwAW6VoNRsvjH5QX5LiH/VoW
	oVRBwN0iOc5XS+8pMj/tpN+rxKsLYprkOJQW1NKcWTaXlrNixrOHlM7flWw==
X-Gm-Gg: AR+sD13keVhIFn0n9Qtx75fbl/hGYr8Swv4PXby7dZyKRbiqbHHByZLrD2WCZInbYy/
	K7wK5qBAFVOEcirfJfuWxWjn3zXScl8PbCXqVg0yfnu7UmWYCp9iObqRSsjt6f2NY9xetmopNGs
	E7H5S0XZLq/DlqdK/iheL94mVDw1fikIM4O8uPzjJd25CIpKDay0PWUESdWTOFDcqnLL6aoScwG
	YzkRkrKw9KIDzn7NrQE07hDER+rbBaUQukvCxyiyq4oyDvzSOCLcC3HiTrppvygNqQ7ExR+2VbF
	QAPxoszFnqi0Ocgkr+7Q+1V1x2hrRAV3eh2hPXk7qRsM4NnNMg5Jq69H3+e9/RcvEGJfGmCD0ae
	kZPlWEqbjA0Ys6yFceLXVT7u8pVCOgwCu3zI=
X-Received: by 2002:a05:622a:a11:b0:52d:918b:92e2 with SMTP id d75a77b69052e-52df56f1740mr67349821cf.6.1787322204963;
        Fri, 21 Aug 2026 07:23:24 -0700 (PDT)
X-Received: by 2002:a05:622a:a11:b0:52d:918b:92e2 with SMTP id d75a77b69052e-52df56f1740mr67349071cf.6.1787322204377;
        Fri, 21 Aug 2026 07:23:24 -0700 (PDT)
Received: from localhost (ip-86-49-251-7.bb.vodafone.cz. [86.49.251.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b915c6ccsm29704055e9.13.2026.08.21.07.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 07:23:23 -0700 (PDT)
Date: Fri, 21 Aug 2026 16:23:22 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
        anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com,
        fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v4 02/21] iommufd: Add iommufd_sw_map_msi()
Message-ID: <yikhefui2flgfffmtbpdxemjtto2ryfmkgtlgdtmr2ndgxrw3r@rcjz523m3sw5>
References: <20260820214150.545737-1-andrew.jones@oss.qualcomm.com>
 <20260820214150.545737-3-andrew.jones@oss.qualcomm.com>
 <20260820220908.GE244917@nvidia.com>
 <gr2h3ktgacozyo7rdggkxsg5mbdtzcnimaawd24c37hnf2tun3@hqivsenaq5wd>
 <20260821120204.GF244917@nvidia.com>
 <zygm4qm3fjv57nsgcectwikfa3cdnidxnhv55nxv4b6l2kllrs@dt36j4p3zhoa>
 <20260821140033.GH244917@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821140033.GH244917@nvidia.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDExMSBTYWx0ZWRfX6XhzuIlZhDQe
 kt5UGkvkXPX/uns0EhqAgegyiTLNL8xIF8kieXHuOtoQo3wUfLQaNPCrsSVQCj+DCLis7+XEhxW
 wGtikMzxoen2GrYz+92UK5tpyO5nYv/Aeh7AV3zRCV0J+KYH02zKdsjA7CH9zgTbQi0Bv5GQxuA
 NHKy8f4mMTdP66Qex2RnKf1U8smtiYWnjsPRotgyOZkeUmpj5UmMbMIRte8gh9aPWrNJQRSOfa1
 A8wh/bSbuqe7FZ4N9Z9ZxJ9B5dJ5outKI6K95ueL2NHRcawBpJ5D7jG5uwirN9mPRWY1WWmWFZ8
 GoVHLIOu7BW63q/LOvDKO/cKEp75zplb+ewHXk4FU1Sb4hVILOB2CGcaE5cc6np5iP0oKiTgNc0
 lO2BBFOdmSDAlQuvza2AoP2OHZ2CqEX8AaYU5AKb4+WcpBsrnfhES5a69RT1Toiq+SRPabmHIkP
 LqAIFgxPAqRRByjcLZQ==
X-Proofpoint-ORIG-GUID: KMq7fqDKMSQH7Tdjb9clWDHbPu8bevI-
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDExMSBTYWx0ZWRfXzXszAq4PUd1D
 l4ZoYgaL7HoI2XhP9lRmoVALdO+a2VwaKTFafgUm/eR0/0yGwmKvs7ttOhvqx1xRfgPTfdMYz4M
 HKi9S61qVFgRlE1WRvn7JsXk44bKaoc=
X-Authority-Analysis: v=2.4 cv=Av/eGu9P c=1 sm=1 tr=0 ts=6a885f5e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=on9AXyaqQ0RhfYpiXjjEXA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=JO-7leH7fczbGu3iEqoA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: KMq7fqDKMSQH7Tdjb9clWDHbPu8bevI-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210111

On Fri, Aug 21, 2026 at 11:00:33AM -0300, Jason Gunthorpe wrote:
> On Fri, Aug 21, 2026 at 03:47:17PM +0200, Andrew Jones wrote:
> > On Fri, Aug 21, 2026 at 09:02:04AM -0300, Jason Gunthorpe wrote:
> > > On Fri, Aug 21, 2026 at 01:07:03PM +0200, Andrew Jones wrote:
> > > 
> > > > > What I rather expected was for riscv to have a PA window that is very
> > > > > big and not just one page, eg adjust iommu_dma_prepare_msi() so you
> > > > > can pass in the entire PA space that you need for the affinity
> > > > > changes. Maybe this is a list of phys_addr_t ?
> > > > 
> > > > That's more or less what this series does. 
> > > 
> > > But it does it in a completely different way, and I'm struggling to
> > > see any justification for this.
> > > 
> > > Again, just pass your list of PAs to iommu_dma_prepare_msi() from the
> > > irq domain seems like the easiest and most ARM aligned thing.
> > > 
> > > When you need a new IOVA for an affinity change the PA's are already
> > > mapped a simple offset calculation is that is needed.
> > 
> > Ah, I see what I missed. The proposed batched API would guarantee a
> > contiguous IOVA range, so the descriptor could cache the IOVA base and
> > then the riscv IR compose-msi-msg could simply compute its target off
> > that base. That would indeed eliminate msi_iova[] and all its complexity.
> 
> Yeah, that is pretty simple like that
> 
> Then you just need to teach everything downstream to have a list of
> phys not a single phys and thats an easy to understand delta
> 
> > ARM calls iommu_dma_prepare_msi() from ITS since there is no SMMU
> > irqdomain and ITS owns the MSI target.
> 
> Right SMMU is not involved in interrupt translation
> 
> > This series adds a RISC-V IOMMU IR irqdomain to replace the IMSIC PA
> > with the corresponding IOVA, so the IR domain's alloc callback is
> > the right place to create the mappings through common
> > DMA-IOMMU/iommufd code.
> 
> But RISC-V IOMMU is also not involved in interrupt translation. Beyond
> it could remap the PAs which represent the CPUs, but you are not using
> it that way since it is statically setup.
> 
> So I'm not sure why the iommu gets an IR? Isn't it the same as ARM
> where the IMSIC itself just has a wack of PAs it needs to access so it
> calls iommu_dma_prepare_msi() to do it?

Right, this series is only remapping IMSIC PAs, not using the IOMMU MSI
table. The MSI table must be disabled when second-stage translation is
Bare, so it cannot be used for the host mappings here. It will be needed
for guest interrupt files (the irqbypass series I'm also working on),
where this IR irqdomain can then intercept irq_set_vcpu_affinity().
Also, keeping the MSI setup in this IR irqdomain avoids putting IOMMU
mapping knowledge in the IMSIC driver.

Thanks,
drew
