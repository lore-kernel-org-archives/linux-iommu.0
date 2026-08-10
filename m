Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F21378D72
	for <iommu@lists.linux.dev>; Mon, 10 Aug 2026 08:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786349466; cv=none; b=PKVia0K9GIuqaHDro4qlpbG21twEJWhAKSbsah7BcWcrqsxpoP8uEcgR40vIuNDP1Z9WF1iJMZ3vat5mXCMmlZ+JnmqVaP9/oA5tB2ES8pVGwScqnetRYZl+gApoIa6N3FRm+XtPWeDdw7OD5Cme4EZFLCFcaYdJCyP/rS6bH/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786349466; c=relaxed/simple;
	bh=hzBoLZXf+K9gsJaGo+sOzfRnVzGmck/xLDCml35RDRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=McV+qKf74JwuTDUbKM7di7txsuRgqkNASnyNIkg91ZCLCpPHkqPXOfnz2/xHu8yaolYnR5Z5zazBE4zXftkfdAk3KTtiKuKM6rmbfYltn5Vlo+IVzcPFF7UK8TM0u5jEd40l27mhUxa06fC8uyAG0Z/X3EfzTqlqbA0cXAU+Ilk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NjuZraaz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WRnNrfNX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NjuZraaz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WRnNrfNX"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67A5HWqB1771397
	for <iommu@lists.linux.dev>; Mon, 10 Aug 2026 08:11:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=eqbNjpANnKORB8DYz+Oqi7OH
	vg9oMT+g0VlEk9fsnig=; b=NjuZraazaoi8VK076YKebQAanidnOtFf20cTAnUi
	KhsFRMKM3ugOWWGaVScAjnhwXwEcHn7Rc3JMwqyrApiB/kx2Nggui8JPFIN6yPwB
	N/5bY423M8gtTGdC85ZxfmlnejHXoly4kVKATWwiMuhW+DMw+sA2JA9Bq9ejr5gN
	stmnBpHYTjvF5CMkR1r2jZ+dsvwTKyFFoCAv/GubuKmKvTsUXRV/Jd9w8esOoHPi
	0j5Iv1d3H3TMOOqedkIZ6zyq77z8xIWphbEWOoh2V01PLCa0Qgvhu2fck7YXTx6E
	5/zQcT10hMIAWgnEdk6AP36WdvDzKtXXLEtzTJtvrmOfpw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fy19khfux-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 10 Aug 2026 08:11:03 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51bfe3fa93bso14554021cf.2
        for <iommu@lists.linux.dev>; Mon, 10 Aug 2026 01:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786349463; x=1786954263; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eqbNjpANnKORB8DYz+Oqi7OHvg9oMT+g0VlEk9fsnig=;
        b=WRnNrfNX/Z8lBugMf/jeGS1YRFrYFrZocmsxz9ZbwKZb6pm/jPQMUCI16oYaX5qgg5
         QC8C6gsu5AAmeSaZNsXQ0WsXn8CiLNmEyPNpDwQuFrcAofLY0/+payWZeeoGOyuncwjz
         wjIoh5zgyFRpmxMiiz0P5Jvn1G7ZGn78tcvJ3oUARBNv5Q3tGJOlhErBTwcMga1e36o0
         +OIdmLDjVQM2ML7PqULsy/PoI+YqwHKvLEJEOIkoY0kH2TR2fZyweBIxCzgjE3blhK3V
         kkZ1OcqyERHGVmh6EKO4lc6FvlxLmfLqwrLdWO24kPd+zb/iEwdylAMHm23h5msOn7oe
         vgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786349463; x=1786954263;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eqbNjpANnKORB8DYz+Oqi7OHvg9oMT+g0VlEk9fsnig=;
        b=EjkeI6LDmfPaMYzdrbPZ1WDgQdeHCLW5V+8ui45mxSDJyOlbKTarTQvOXy5IQEg3O8
         wm0qRmtnjIcVaGenoJaD2cjUy0HYbys9IrG2JvFt5IMS1zrM9ECfct2AcNJXlf/cZUPS
         8pEHEd0ujyFlaGaZf4e79yo5DgdqIkUl8OdBWiXGhwVXYL4j64Ul2HcEedPvB9KXbakj
         6eQUeth8nBdL/vnrexv8prs+DYBZTrwAVYuzf2lVA55gqggN1DQwMICGoKtHjq6IZbKm
         GyWz5htyu5/OqA1xcsMAFLklhZ4p5JwWELOzwyjwSF9PgtVIf5SX1QW96YT4txETjJ/5
         9LaA==
X-Forwarded-Encrypted: i=1; AHgh+RqjHgfhcQp0m5m50TBc2GBrdRIZv5/NVepMg60zfvFbBum8VJzPHaYy/ClGN+hWIgbZWouw1A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxqro0ZMHXMWNxJ/LGYAVslhizZL+SmaazdW+wncWqz9Wg7to5L
	q2HQ7Hfg7xcN+zoRzSKcaWOFTR35VNqP++xxKgYyYx4t9/sg76SAC+myk1ulehifqtGSJArBC1j
	x63Z/U+7o0s8tP4Esos1jHLC/1DbgLHsTQEAQkuZeW7lmGhdLCMwtzarE3g==
X-Gm-Gg: AR+sD12ls7JtMjicZTwCCIvQwbaMtXHtOfbkXuzcBrXy+MYKmo5UOUpnbgTboSCMMlp
	69oCRKKuqgc9KAOdG4EIch0fxjfK3O7GBn2z6r7dXjOSw6ts8BKUA74IegmBhPLA6kUzhK5CQki
	q335mBjW/+m34bGlAMpjGnjlh1b7tywvuk5SSGrbQRk4rNQ5V7e5iBatDh8RXJJVayimDesJhYV
	2J618l2NYUv2jXvnV8Bn4SrHjl6/wuAQuILZ+g1EYIy+CGK8dADqyXZzSeh2UtzBsUZQ9EMOHrI
	OfbfPa+2jLw0TWk+pEJ/JCyuYYOF0ft7kw9B+XMcHJpqCmQJWbVy2wwEkZbb0aLCzhBOAKagYBj
	WB1NKGgg2QbvmRi/+pZ1G81XT2hgzZEP/2jw0c/I=
X-Received: by 2002:a05:622a:1447:b0:527:43a:2f30 with SMTP id d75a77b69052e-52ce5f6013emr413945491cf.1.1786349462972;
        Mon, 10 Aug 2026 01:11:02 -0700 (PDT)
X-Received: by 2002:a05:622a:1447:b0:527:43a:2f30 with SMTP id d75a77b69052e-52ce5f6013emr413945051cf.1.1786349462559;
        Mon, 10 Aug 2026 01:11:02 -0700 (PDT)
Received: from localhost (ip-86-49-241-13.bb.vodafone.cz. [86.49.241.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995e9f0230sm282367485e9.6.2026.08.10.01.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 01:11:01 -0700 (PDT)
Date: Mon, 10 Aug 2026 10:11:01 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, kevin.tian@intel.com,
        fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v3 07/19] iommu/riscv: Add IRQ domain for interrupt
 remapping
Message-ID: <mthnplgkvilxzjzoy7x7f54shoa4v4wwkbczfpld4avmsmnc3m@lqpthhcxviy3>
References: <20260807181713.228535-1-andrew.jones@oss.qualcomm.com>
 <20260807181713.228535-8-andrew.jones@oss.qualcomm.com>
 <875x1lekog.ffs@fw13>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875x1lekog.ffs@fw13>
X-Proofpoint-ORIG-GUID: eGxRIn00uQvmyuJyGCpo7asb41BcWT-n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDA2OSBTYWx0ZWRfX67ra/KRzC7F5
 HlXEAnPQ2XOHmO1jWAn4ypQj5g5qB5i5E7XmDS1rG2+lQWJR/ga9bzMcN/lxsNx35bq1ULK2C31
 C2ftGbtnkrGdxHIXpBjVASoknBnpLHyLc5o9QmWHGCNdv2UgEvd9xKfMOlNndaRjfRYhgnZnx3S
 IBqRj+Zlr1zm2q3pxnX/IrkyWxpsKlcSeeSHF7THvIy4tduAv9NZ3KIfG4Bik1NO40dVep4W/H2
 QPbPVqS4Tx8d1TtiHgWgK+NOymrMxNSuJv+SQJ8tSPmpMqJNXYGBZ8EFpe2hqonfB1lMX0ZugYG
 iRQR756+DGZXARb/80nShsecFyuwCJjN5Y5G+Za7CVMpgmHEfdgWkQfJ70XFpOu5RNLwp4bbQou
 xBF2T+FANbAVrh4uYBUwjMPFM7Sw3EiMEn5IXjTxlXLLMCU+C7jD0kItMoDlg3qm7n9XIr7CnNW
 tHkcdJOL1i1wbqYKrxw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDA2OSBTYWx0ZWRfX1V1GjHZw9gSD
 DvJ8nvm9uV/Q+fjVJkF4nDpPYsQVZeBbWQlXYJeXKxqD85XkOZRMMsj2f+NWnEHsnolGN7hIARs
 9yX98FG27J70Z3ypVYZ55yx4aC2zCG0=
X-Proofpoint-GUID: eGxRIn00uQvmyuJyGCpo7asb41BcWT-n
X-Authority-Analysis: v=2.4 cv=abxRWxot c=1 sm=1 tr=0 ts=6a798798 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=VPysOpcHbS0DNrM1Xqmyow==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=oqHPoYKHcLPAEeRuAR0A:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_01,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100069

On Fri, Aug 07, 2026 at 10:32:15PM +0200, Thomas Gleixner wrote:
> On Fri, Aug 07 2026 at 20:17, Andrew Jones wrote:
> > +static int riscv_iommu_ir_irq_domain_alloc_irqs(struct irq_domain *irqdomain,
> > +						unsigned int irq_base, unsigned int nr_irqs,
> > +						void *arg)
> > +{
> > +	struct irq_data *data;
> > +	int i, ret;
> > +
> > +	ret = irq_domain_alloc_irqs_parent(irqdomain, irq_base, nr_irqs, arg);
> > +	if (ret)
> > +		return ret;
> > +
> > +	for (i = 0; i < nr_irqs; i++) {
> 
> for (unsigned int i = 0; .....
> 
> nr_irqs is unsigned after all
> 
> The struct irq_data declaration want's to be inside the loop as that's
> the scope where it is used.

ack

> 
> > +		data = irq_domain_get_irq_data(irqdomain, irq_base + i);
> 
> 
> > +		data->chip = &riscv_iommu_ir_irq_chip;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct irq_domain_ops riscv_iommu_ir_irq_domain_ops = {
> > +	.alloc = riscv_iommu_ir_irq_domain_alloc_irqs,
> > +	.free = irq_domain_free_irqs_parent,
> 
> https://docs.kernel.org/process/maintainer-tip.html#struct-declarations-and-initializers

I'll align the member names.

> 
> > +};
> > +
> > +static const struct msi_parent_ops riscv_iommu_ir_msi_parent_ops = {
> > +	.prefix			= "IR-",
> > +	.supported_flags	= MSI_GENERIC_FLAGS_MASK |
> > +				  MSI_FLAG_PCI_MSIX,
> > +	.required_flags		= MSI_FLAG_USE_DEF_DOM_OPS |
> > +				  MSI_FLAG_USE_DEF_CHIP_OPS |
> > +				  MSI_FLAG_PCI_MSI_MASK_PARENT,
> > +	.chip_flags		= MSI_CHIP_FLAG_SET_ACK,
> > +	.init_dev_msi_info	= msi_parent_init_dev_msi_info,
> > +};
> > +
> > +struct irq_domain *riscv_iommu_ir_irq_domain_create(struct device *dev,
> > +						    struct riscv_iommu_info *info)
> 
> You have 100 characters, please use them.

I also like to use the full 100 and will even accept a checkpatch warning
for a few extra chars when splitting (IHMO) would be worse. In this case
if I left info on the same line we'd go to 102 but splitting on parameter
lists isn't too evil, so I'd probably leave this one split.

> 
> > +{
> > +	struct irq_domain *irqparent = dev_get_msi_domain(dev);
> > +	struct irq_domain *irqdomain;
> > +	struct fwnode_handle *fn;
> > +	char *fwname __free(kfree) = NULL;
> 
> https://docs.kernel.org/process/maintainer-tip.html#variable-declarations

I'll move fwname up so I don't spoil Christmas.

> 
> > +	if (!irqparent)
> > +		return NULL;
> > +
> > +	fwname = kasprintf(GFP_KERNEL, "IOMMU-IR-%s", dev_name(dev));
> > +	if (!fwname)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	fn = irq_domain_alloc_named_fwnode(fwname);
> > +	if (!fn)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	irqdomain = irq_domain_create_hierarchy(irqparent, 0, 0, fn,
> > +						&riscv_iommu_ir_irq_domain_ops,
> > +						info);
> 
> 100 chars.

I'll change it to

	irqdomain = irq_domain_create_hierarchy(irqparent, 0, 0, fn,
                                                &riscv_iommu_ir_irq_domain_ops, info);

> 
> > +	if (!irqdomain) {
> > +		irq_domain_free_fwnode(fn);
> > +		return ERR_PTR(-ENOMEM);
> > +	}
> > +
> > +	/*
> > +	 * The RISC-V IOMMU doesn't validate MSI data, so we can't set
> > +	 * IRQ_DOMAIN_FLAG_ISOLATED_MSI. This means VFIO requires
> > +	 * allow_unsafe_interrupts.
> 
> what is allow_unsafe_interrupts? A variable, a function a parameter or
> what?

I'll change this to:

The means VFIO requires its allow_unsafe_interrupts module parameter.

Thanks,
drew
