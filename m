Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B035426431
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 15:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787325538; cv=none; b=W6esCCk6UGgxsXi+2FZ+L3KKTKJscAPKyWXZkWBQzQyPSdsf37hVBVT/THJFPcuyqBKo8RJOlSDrkJTwmHVfV5kfHMzu0n4qOui6pXbD2kmiJVdaRlo5KOM8wGGT6DcgYrt5yJZiONdCLQb6v5HTM6nyrQQ0VBqfuc3gsFrf0Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787325538; c=relaxed/simple;
	bh=dX3WeSufIF2097ZpXwl+x3YsH/gbCNoAO7kx+fAcRnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9y9iPe3VB7KzuKcK9/5rPXfMCeX2TQR6pqH9RQZ8Z5rMERSbkEZL3q7dipBTQZw4+ZrtuV3Hrp4LmXUIJOlCPtoQUZK2QqSCjJ+N9z2t+mxlBintIuIdOxn7P4otQJfdpyogbw4D9aTY6w4KhS5K2HfMUW9wFOwwEcQwYceVAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RwjqUrnQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FrYha/LO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RwjqUrnQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FrYha/LO"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LCog122783837
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 15:18:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dX/zSjwf1mxvq4qpG3WDBnh6
	qmE58SGcbyhO+4DSQYo=; b=RwjqUrnQ/zSpRVcyGNE2iEgU1JMemav3ODErmA1b
	BjTI50UtlNlZWCy6bDlHTyh8FVQXs6f93FCbNXe77N4Vj4IUaHp/6/0je55qTrTt
	smAhAYo86lObVei53/KSChOVtgYcvKkOoQnrPR/eSYfbNGIWimG4yI+jzeHUbt1b
	ZhrAmSh0X7sNbSZgzMOsZHvI7LrVyjpLtk5NdvYmOqyyedrgqdjRvVdgWzeZoJn+
	47J8C6Li3MIasSZ+hP2lMXqAxC56F6Bqu0z4u9Pv9vdd49zw7ckw2lM/BA/CJPL0
	tMlM5wuKQUVJeuLXz8QwuoYbK7NL+NT6rxx42i36MbBgkA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6gdf26yb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 15:18:55 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-526da7e3c9dso11602021cf.1
        for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 08:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787325532; x=1787930332; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dX/zSjwf1mxvq4qpG3WDBnh6qmE58SGcbyhO+4DSQYo=;
        b=FrYha/LOK+O4ZGmm/ubVBt0YfilJCQvbTtFXRLk9DCYi1nb2hTDq6ayHLwBUXesWcy
         czYVyWREY2JvO+RupzawJuCkcd9otWmjZ7dCad3eIzx6hnh0hIKG05MjS6BKMYeW9SZQ
         YOG8DVD7I91TUtbgkSdulQ3Ow+GDT9I15lim+xegra3YAd9fYkXat+5qEviv49J1iYj2
         6aXWpi93E4b55wmrcZl2VqnBfTVyIJ+TYb0x7hqeY1z36bbYVaXyZw+j7W/d4Jx+nh/S
         rbkX3I92r+p8I9/iGo+0it7bShmLwxQUHck3OIVQsTCCHQcVRosrS1BRWJNXRG1rwuH6
         v25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787325532; x=1787930332;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dX/zSjwf1mxvq4qpG3WDBnh6qmE58SGcbyhO+4DSQYo=;
        b=sGt0zQbkRFQ1dCE3BFIbki4k16W7CLgNLeaQjkvVUrkD8nxlv4nS6oiNUeoFq60ayp
         ltaQttrA3LNwQk7+OzG262ySYtw956NqZzVEczP3cZOv42EiZjEKcv6MWXiONBee0Bn4
         llFV711lv8UkpOdfukrDcZRaWM5eCK9jmHSSrf9e94u2geTUAWkyLaEuhWGZPrloil5D
         rj9zObQqeNhz9/UEd/OTA/iWZgJrXpLSoN1BTqx3c4xB5eIC9gAztcsvRdNagC8iCiBo
         Rf886+ZafYHhPMumkGYswAHHxky0rzL4qHJ6kLvr5Hhr6HzzLx9UiPYetVqCkChfGLTu
         M1AQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro8ek9bBjTAXKIawz7n0szoR647OD90koKTcEDk3uQ5YkV8srbVn9NJ/L19OGbkqFEUxxo/Mw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzMyQ69TA2t9GlMNTitYK8L+/gGF+2uDl7QZliXVgCeZ4ImFXXD
	BkMF2Ed/z7oD9/L8kMyocZWwzybx6aYiexGdEBYLjSAALC6LWYvHpM72mZuraonXZH51V3u0cre
	3oOzt8VqTmN/YH34Oghc/SnmuhKEPmA+HoQvDRVZXhSk+25oDV8zWQLhTAQ==
X-Gm-Gg: AR+sD12kkmweGfVPC+qJRAXSyTUEHj6e0Ha5KDRvJKHFg2G6iWlni9TEVLraWDtaF1s
	lj4TD+P40/J7bovpJuD0jOicf3+ZHVZiFEiREj8Tvm9VyFyahRFGpGkxn1EUly4SLJP+F/H0LuN
	Zest4LFoXTnjqfS4+jqQujVf1B2KudV8PPK+pZH3f9lveDdKlf0RVE1ZI3Yo+7+dZSueoQaAzgb
	0VNvZp0rCUQbOnSsUROSbqY0ZxFB5StA5b2ODs/YNB2jN4Bc1lr8rrpwVH3k705V1zN4QY8OCAV
	qGZEiJlLJ6TCnI3FxSv2yPLQo0hlEm7FulUPaXWcfiKKJNgcWXYWn+68QWdQYH8V8mGgztzi+WY
	JsUNdJsLDDMS+Y8na3x5B8WziOJKgl8AIwr0=
X-Received: by 2002:a05:622a:5c14:b0:516:e0eb:d7d with SMTP id d75a77b69052e-52df59aa83cmr65609371cf.27.1787325532349;
        Fri, 21 Aug 2026 08:18:52 -0700 (PDT)
X-Received: by 2002:a05:622a:5c14:b0:516:e0eb:d7d with SMTP id d75a77b69052e-52df59aa83cmr65608701cf.27.1787325531786;
        Fri, 21 Aug 2026 08:18:51 -0700 (PDT)
Received: from localhost (ip-86-49-251-7.bb.vodafone.cz. [86.49.251.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499ba31efadsm26839395e9.3.2026.08.21.08.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 08:18:50 -0700 (PDT)
Date: Fri, 21 Aug 2026 17:18:49 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
        anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com,
        fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v4 02/21] iommufd: Add iommufd_sw_map_msi()
Message-ID: <pzlzv2lzik4miqc5oejichltnyqabolyaezbkrufcl7nbttygm@7rdmkig3t56u>
References: <20260820214150.545737-1-andrew.jones@oss.qualcomm.com>
 <20260820214150.545737-3-andrew.jones@oss.qualcomm.com>
 <20260820220908.GE244917@nvidia.com>
 <gr2h3ktgacozyo7rdggkxsg5mbdtzcnimaawd24c37hnf2tun3@hqivsenaq5wd>
 <20260821120204.GF244917@nvidia.com>
 <zygm4qm3fjv57nsgcectwikfa3cdnidxnhv55nxv4b6l2kllrs@dt36j4p3zhoa>
 <20260821140033.GH244917@nvidia.com>
 <yikhefui2flgfffmtbpdxemjtto2ryfmkgtlgdtmr2ndgxrw3r@rcjz523m3sw5>
 <20260821143155.GI244917@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821143155.GI244917@nvidia.com>
X-Authority-Analysis: v=2.4 cv=CsqPtH4D c=1 sm=1 tr=0 ts=6a886c60 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=on9AXyaqQ0RhfYpiXjjEXA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=2SkywTcMJH5Hle4V2y0A:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDExOSBTYWx0ZWRfX2HM8PoK3S11t
 V38wUbP9sUIL8fmJcwaIgxP0imVdNiFvTjbSuE6BmyEr2OYZVTPvAhiKnthC7ZpGdkakZypnpNm
 YT/YXEgSu4MSsQ0nw04Fwm3p/fG2i/J/CI2kGCgUfCf9Ha0TWRhFbGLBp+30z7GSe0XwgNdWunk
 n2yHqQjix6p4IHirjp2GjM+e/L/B/pXIhsQMG91CTmmTnEYNQrmfXeQwWkM009pWcPEB7PFoLLX
 EiJ9BV8bCSNgKzFuhjrwkjEAy0AZee/PfSF3XRoo8IxilBjVqsfR8X8K+EYOFM5U++x2MmfXiLL
 ohOHARHS32e34LLDfpXYuuZOjL99uD40D4FvpDIfTGKXf+5U8Rqjs1kdshVFJdWHvHzNIwAuTnQ
 9lKtAgXHsn8F6yTJgAFKBP+nCgRmO5nqVaHfkjTz4RXBjvu439CnBu7mwrsTzt+84j1njdmruUV
 jVU7cbxQitBZRhysBAg==
X-Proofpoint-ORIG-GUID: -GzxFTYp9p5ArA89jvjxdaOs6sq1j9qI
X-Proofpoint-GUID: -GzxFTYp9p5ArA89jvjxdaOs6sq1j9qI
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDExOSBTYWx0ZWRfXyvIHSeETl6+j
 p0GAPE9bJfZIBWX7HT3kfzdRXMdstE3AsV134s1fSxczgp62OtOCgCObT1avOVAKElBPqVWPdwm
 X2O5jT0o7BxYXIOjIbtD7ZDsQFARsj8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210119

On Fri, Aug 21, 2026 at 11:31:55AM -0300, Jason Gunthorpe wrote:
> On Fri, Aug 21, 2026 at 04:23:22PM +0200, Andrew Jones wrote:
> > > But RISC-V IOMMU is also not involved in interrupt translation. Beyond
> > > it could remap the PAs which represent the CPUs, but you are not using
> > > it that way since it is statically setup.
> > > 
> > > So I'm not sure why the iommu gets an IR? Isn't it the same as ARM
> > > where the IMSIC itself just has a wack of PAs it needs to access so it
> > > calls iommu_dma_prepare_msi() to do it?
> > 
> > Right, this series is only remapping IMSIC PAs, not using the IOMMU MSI
> > table. The MSI table must be disabled when second-stage translation is
> > Bare, so it cannot be used for the host mappings here. It will be needed
> > for guest interrupt files (the irqbypass series I'm also working on),
> > where this IR irqdomain can then intercept irq_set_vcpu_affinity().
> > Also, keeping the MSI setup in this IR irqdomain avoids putting IOMMU
> > mapping knowledge in the IMSIC driver.
> 
> It's ok for the IMSIC driver to call iommu_dma_prepare_msi(), that's
> the architecutre of this at least.
> 
> Until you get to adding something more complicated, eg irqbypass, I'd
> suggest keeping this series simple.
> 
> I guess I would wonder why the IOMMU needs to be involved in changing
> the mapping down the road, why not just reprogram the MSI-X address?
>

For guest interrupts the MSI-X address is a guest IMSIC address.
Reprogramming it handles a guest reroute, but not vcpu migration (the
guest address stays the same while its host backing moves between
guest interrupt files and MRIFs). The IOMMU driver updates that mapping
through "the hypervisor to IOMMU driver interface", a.k.a. the IRQ
domain's irq_set_vcpu_affinity() callback. That mapping cannot be
prepared ahead of time because only the hypervisor knows the target,
and it may change later.

Since I know I'll need an IRQ domain in the IOMMU driver for
irq_set_vcpu_affinity(), I'd prefer to keep it in this series too.

Thanks,
drew
