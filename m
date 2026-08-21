Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3817D49363F
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 17:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787332341; cv=none; b=VLPSHCPI0Fpzv1S322MLqfnyPm6NWmXt2JaGAfVLUwL6IesS/YRbsVhtiHjrLP4rW4MozP/22s6R9zttEsFy6iN0qaRgV2sFWzUMLQih47dCslYLGd9AofOCm1bV1mJ94rAweKwdE67gNasGxGj86xbaBOphhgMLGmb++uKj1ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787332341; c=relaxed/simple;
	bh=a5DNmTwnKv7Qr32U8s19WEinSu2DvzuznyP31kBj11s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahIejLgD8Ik/CpozPzGCNmWLxtkWbkUYDltuqTDNRjgYPmkH/Ymg32jov/osZ2AAkzcumgrHnKLmsn4Is59QUKBcdBbrswmJud8Qp+bg6RqJXEPizr889F6KE4D186DkrduBErvZBVPkHLKdA2rYrtD1Iw5pcoo6ReLTr1g8gLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P6eejvYb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fM/E3P1Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P6eejvYb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fM/E3P1Y"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LFmAFV3172871
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 17:12:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=iWroj1XK/89RuRQdeZH3447C
	p381kc7TI3fTsbTR3po=; b=P6eejvYb0PShyDlM7a6MJ+xMVcmavUQ5To440ums
	pzrXW4SgRJgNPmabCGeDejKextTrXYECh3dH+XGOWhvnQlzsbQZr3t7D4oN7rpMD
	U9EVxv5/ON6cAFX/Qqd/BJ2qjdj68AnKV3a58FPGYBt+njk4JZ7FUcqLszuOQnSX
	fMrLhDCSUEsIdCjXXkc/Ib9RtdA+qLwjOuvX81Mxloh9lSJZS6dUOtVJBnQZY1vl
	ZTaTOAxCebddaMzVclkPbAh5iZf7oZ+LHoFowvKdhyN0tsD2mj86pRxNXc50AmDn
	/Xc4J/Yv9lMyRrcZnaP6jFlVGYSrDJlqJ11ble168tlpWQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6gdf2p57-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 17:12:18 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-52de40127adso14458441cf.3
        for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 10:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787332338; x=1787937138; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iWroj1XK/89RuRQdeZH3447Cp381kc7TI3fTsbTR3po=;
        b=fM/E3P1YbRAHp1PSuD6+Q6fcf7UxehC6ULlVlB61hKOskzdGUZN0EVz1LN9pQKFruP
         IsNsDVOYLYSw6pABWn7KrJlVtWlqhkayPKiirungQkOinXWZ9z0v4jCN5s/EHRKijO/u
         3iHxJLXXRImvm5aH5RED7EqzbasTcmEzHMFVtEm717S6wllmFfvjvKwpc5zxbOeX0IyH
         /ARH/H1kSa87MbkMWTczi/KgJaUq0lDw2dGCawop55gOsU3lPVEep8Mrao7mvPXCzETL
         4CD3EOw1Qd8KDOaThFOUsqLuZGRRcaB8hEhuFQ9cW3nr2XFTyBiW9YAm+VxhEngpGmen
         aniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787332338; x=1787937138;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iWroj1XK/89RuRQdeZH3447Cp381kc7TI3fTsbTR3po=;
        b=Rq2QOzxeUydaWgsZsWg0E/0ZjkHIin5rfWWnbcOnlp6nT2DSufnhfvTBbVIFDyR9bR
         wcP65CHyjwG1comQ3L4rrIhZC7ALi/bls5ZuT1YLfvUA9MoRcDQhRgrpwITdHKLZPwVn
         a1ajohPwtpfWCt10SKwGdPgbIn+lNrFJfi8OIVgzbq3oGaf/H5pgXFtaJCB4O1CUmWa3
         OwAxdg5uinQCN/kqnqon4RWun7qq9Ocn5gdYoXbcOw/K3DlBATeae/9a6jkeEprizfPO
         t6qnCkGWLWmGEc9LqDp2vzDFhhDij9noUEQ4x5F9zB2dtzJGBDcBfFoOcX4E/cUhXoJT
         gGSQ==
X-Forwarded-Encrypted: i=1; AHgh+RqOfNz8QB0DHjo+Q+8pAY403oE7L9xxi5xl4Xkm1t7Fq1lz0uiFKyJsEOLDQZ8sOGHQoTkQhQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwUNNc2NBq9C+Ye1ujUXQaIaKaSPb8RgJ3FRVdiHdYcHcTairos
	cOyNwTHke4ky4Zh94n5UDIvCo78sevLPaNn3ds+dPtxkaqulkZHwg7iolwTgCCCchkvHv1sAUvu
	Q/4EJS/ZKUjaazRySmXderHgzNeFZqHp2BwNlzsZ709EPcJBHc2SV231nCA==
X-Gm-Gg: AR+sD11o86qRE8viiyhFvc3kbtyYTBxf9b42iFo7KzpXjAFp/bQellc91fqbcyveYx1
	5XqXNiLeIYqXaUAQHVjHX/bwnj7ZiKPdJEfgHToS3T0dHxjElwyQ3YjdPhNIBaO2to/W5CV+8Jq
	+NsruBhUHaItS/KgsppWy2CDn7IezcI1dLPUTwCUwsTloLDosdxi/olohbA+n6ea2IuSZ9n1wwo
	wNRlRLsll2A9Y6IUgwo1wDg0UnO1/lTcjDZMp3F89zwhrxyEhNdVNIhM1+UnFHdWwgpd3i40F7H
	0+zSCOwFwWY8d/isNnxX/5abQ3R5A8JijEawT5K/9QNEHUViiGZ77yJ2O7IIQk8SCAwkYvr+hhX
	IKMqGNGR9gM5wqkNPjAslbM7/x1VB6vNVWz0=
X-Received: by 2002:ac8:5f52:0:b0:51c:a8:51cd with SMTP id d75a77b69052e-52df569457bmr68674351cf.1.1787332337844;
        Fri, 21 Aug 2026 10:12:17 -0700 (PDT)
X-Received: by 2002:ac8:5f52:0:b0:51c:a8:51cd with SMTP id d75a77b69052e-52df569457bmr68673121cf.1.1787332337130;
        Fri, 21 Aug 2026 10:12:17 -0700 (PDT)
Received: from localhost (ip-86-49-251-7.bb.vodafone.cz. [86.49.251.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b9ba2813sm23502605e9.4.2026.08.21.10.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 10:12:15 -0700 (PDT)
Date: Fri, 21 Aug 2026 19:12:15 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
        anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com,
        fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v4 02/21] iommufd: Add iommufd_sw_map_msi()
Message-ID: <dug43layphru76sqleerwtryyerwa4a6n5s4xwrk4iyfru4o7m@al37eknignld>
References: <20260820214150.545737-3-andrew.jones@oss.qualcomm.com>
 <20260820220908.GE244917@nvidia.com>
 <gr2h3ktgacozyo7rdggkxsg5mbdtzcnimaawd24c37hnf2tun3@hqivsenaq5wd>
 <20260821120204.GF244917@nvidia.com>
 <zygm4qm3fjv57nsgcectwikfa3cdnidxnhv55nxv4b6l2kllrs@dt36j4p3zhoa>
 <20260821140033.GH244917@nvidia.com>
 <yikhefui2flgfffmtbpdxemjtto2ryfmkgtlgdtmr2ndgxrw3r@rcjz523m3sw5>
 <20260821143155.GI244917@nvidia.com>
 <pzlzv2lzik4miqc5oejichltnyqabolyaezbkrufcl7nbttygm@7rdmkig3t56u>
 <20260821161256.GK244917@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821161256.GK244917@nvidia.com>
X-Authority-Analysis: v=2.4 cv=CsqPtH4D c=1 sm=1 tr=0 ts=6a8886f2 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=on9AXyaqQ0RhfYpiXjjEXA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=M3lcFmtXjUYoSr91DZcA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEzNSBTYWx0ZWRfXwb7U0pcAzXqY
 7R09AzeaHR0N0ueOYoq0w1yHDFv4wlNcOqrrjqjh49Xr7bSbDmbOBNBmca8DnRmEWRLN60AbI0d
 E4G9i5Yc6X4OBbeargWjINQCAZQCPsUi5AV/r8k5j48kJaBkMS7yAhDerU+01M27UDODCQkJ4OY
 skQ+MN8+XGP37DAbsvvVr8+C/RdBa1dZMKzjzcMXBAb9aaWnNjVTPNUPUzkq+BKdKTexrKM0RvH
 IqBAzkqFxfQSiaC2yb8gYvhEjZqNZzGZTditaa323qRBC2zB/GJVOdnh9ToeenQZ4PjUssyikmV
 MleYGmWBAFAt7tMytXF70czPm54qKCtJr0KVdsfzFg2tCG4tsuG50bhMed+2j39r/gIVpYl3ljQ
 ruR/h5qB8xRuJDxfNXSL1SqX+qDjMOaeiOcdH1IeHkppL08bO5L7Xz/QxFHkgr2sJR/jeQBjKRY
 6PBYnwOOjLBAJoLPahA==
X-Proofpoint-ORIG-GUID: vmoqjTlNiRU7XHZN0omGqJ1ISj9As10U
X-Proofpoint-GUID: vmoqjTlNiRU7XHZN0omGqJ1ISj9As10U
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEzNSBTYWx0ZWRfX+RtlSj4TNcOT
 k4zpRgkJ33FmpADor7QToLweLr/Iu4+O/NPBGUgp3a1pmUUrZW5Jd0VdYUfwqDXZng9ruNnWFN7
 V2Kt2zk/Wvi5s1T530K6bggWyjkAwbs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_05,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210135

On Fri, Aug 21, 2026 at 01:12:56PM -0300, Jason Gunthorpe wrote:
> On Fri, Aug 21, 2026 at 05:18:49PM +0200, Andrew Jones wrote:
> > On Fri, Aug 21, 2026 at 11:31:55AM -0300, Jason Gunthorpe wrote:
> > > On Fri, Aug 21, 2026 at 04:23:22PM +0200, Andrew Jones wrote:
> > > > > But RISC-V IOMMU is also not involved in interrupt translation. Beyond
> > > > > it could remap the PAs which represent the CPUs, but you are not using
> > > > > it that way since it is statically setup.
> > > > > 
> > > > > So I'm not sure why the iommu gets an IR? Isn't it the same as ARM
> > > > > where the IMSIC itself just has a wack of PAs it needs to access so it
> > > > > calls iommu_dma_prepare_msi() to do it?
> > > > 
> > > > Right, this series is only remapping IMSIC PAs, not using the IOMMU MSI
> > > > table. The MSI table must be disabled when second-stage translation is
> > > > Bare, so it cannot be used for the host mappings here. It will be needed
> > > > for guest interrupt files (the irqbypass series I'm also working on),
> > > > where this IR irqdomain can then intercept irq_set_vcpu_affinity().
> > > > Also, keeping the MSI setup in this IR irqdomain avoids putting IOMMU
> > > > mapping knowledge in the IMSIC driver.
> > > 
> > > It's ok for the IMSIC driver to call iommu_dma_prepare_msi(), that's
> > > the architecutre of this at least.
> > > 
> > > Until you get to adding something more complicated, eg irqbypass, I'd
> > > suggest keeping this series simple.
> > > 
> > > I guess I would wonder why the IOMMU needs to be involved in changing
> > > the mapping down the road, why not just reprogram the MSI-X address?
> > >
> > 
> > For guest interrupts the MSI-X address is a guest IMSIC address.
> > Reprogramming it handles a guest reroute, but not vcpu migration (the
> > guest address stays the same while its host backing moves between
> > guest interrupt files and MRIFs). 
> 
> Linux isn't prepared to have a guest controlled MSI-X addr,
> AFAIK. I've wanted this for a long time but we are not there..
> 
> Does riscv absolutely require this? I suppose you have a new problem
> where you don't know what affinity the guest is selecting when it
> provides a MSI-X addr as you don't know what physical IMSIC page is
> under its S1 IOVA?

The IOMMU MSI table operates after S1, so it matches the resulting IMSIC
GPA. With a vIOMMU, the guest may use any MSI IOVA that its S1 maps to
that GPA. With S1 Bare, the device uses the GPA directly. In either case
the hypervisor provides the guest IMSIC topology and the guest interrupt
file or MRIF target needed to program the MSI table (through the IRQ
domain).

> 
> > The IOMMU driver updates that mapping through "the hypervisor to
> > IOMMU driver interface", a.k.a. the IRQ domain's
> > irq_set_vcpu_affinity() callback. That mapping cannot be prepared
> > ahead of time because only the hypervisor knows the target, and it
> > may change later.
> 
> Nicolin has a series that worked toward making ARM work properly, it
> is not at all like this and it isn't done with remapping domains.

I'll look it up.

> 
> You want to preserve the guests physical MSI-X info directly and plub
> through the proper mapping so that the S1 -> S2 translation setup by
> the guest actually works right.
> 
> If you don't do that then you can just have Linux adjust the MSI-X
> addr like intel does and use the RMR trick from ARM to get the IMSIC
> pages into the S1 IOVA. Still no need for a remapping domain.
> 
> It's so complex, so I think you will have an easier time doing tiny
> small steps at a time..
>

Right, I have a working prototype where the hypervisor manages the MSI
table through the IOMMU driver's IR irqdomain with
irq_set_vcpu_affinity(). Splitting that into upstreamable steps is what
I'm working on now.

Thanks,
drew
