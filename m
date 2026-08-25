Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324322F1FED
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 16:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787674501; cv=none; b=YSOQKqQWfToRvKSKUPH/5CQ/yw/boPFPC7tAsuFvvqaCOzLqLlZujP/IKB4Y9fYZgY6sUDuk8/OFHebFD6dNf1mqrN8p3F/uA+dh8LhC9nUJtkze5gZDIODJB5pB14DLx2zdWF/CKo1mJR2vdIf8AUff8Zp+hUIOgcbmHOeCmHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787674501; c=relaxed/simple;
	bh=HCbA6nWMiQQcqBMpVOUMEKz0gl80sYCdGzK1hfQkG3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPM9wkWutTvegPr12DgGddTcyMCrAoqOwtgv3SJ5t1v9Rwf1YjzjBFk/ltSJ2ANNril9x1BgvM1mp1cKcJstZfN/3rZ//lW85yBoaPdVSkRH1bgQ1vHwZUOAsqJG2LCsRhOgyzsqy/jCimMTf6I3TgMdnL4jaGPjbuJ68uWLwQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YFveKJcQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iAxFrWV9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YFveKJcQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iAxFrWV9"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PEU1gV3248212
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 16:14:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=QpPCKnkowjV4zGekfA+MRvfy
	Y49uQf080rvS3Bt68KM=; b=YFveKJcQIpXLugm7dfLrfS/O3dcyba6727/ymst8
	gD2PbVa3OW/xZm/ZuHhcYs/0h9TTnBg8qxUNSOp54GiuT+3zF9Xp8BuNazqWiqoN
	WzWtjwYsmfWBeYG+Eu0/W4RsPqaDZG/8fHCFACbSrWQXHsHVOVKRscVniOZpV1FA
	69eyDBhvz9PcHRwV8pgXuq6morIvdqFHthNjO7zTt2NDTBqLhVBnsyHWsq9a4QYf
	APsz44u7B/qVgP6MnvNrcqqQCwuMiPSsndisLzp8RzauyQNzv7vjkYie71HKVztJ
	3v2Hod1DwQ+Na72oqSzwExB8Q2BoKJoZMH8aUcqrdXEcaw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9bnj8vx4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 16:14:59 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51bf321d786so40738211cf.1
        for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 09:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787674498; x=1788279298; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QpPCKnkowjV4zGekfA+MRvfyY49uQf080rvS3Bt68KM=;
        b=iAxFrWV9yoi09ayuuAFxqHoij5QWehHxwNEgpdYGyiSx95scq4rH5GtWtrw+D9KvC3
         h20AFPWWyXZLgYZkB30KG4KW/qdVChIDCPHvyCIyfWpdyua90ezzKRJps89k4Q6vwvC2
         ljaw20pEJP6XoFdeXRUnmMsPkezcONm5ZlYET6HwnouSPCXNJBLB5CkEMHCNAGEMEdzX
         N/gk7Y4eRCr73qJXErWt1Pdbm78dmvpYyR8ThHmESqZl6QXgFmqh1gBRDCWR1n52NExp
         XtCflXdvxrarImTmbZT8RsDeFiLouBeHzrDjrqQWFAeJ2CirIm1yR/OHgK8LhGn1GWBw
         gFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787674498; x=1788279298;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QpPCKnkowjV4zGekfA+MRvfyY49uQf080rvS3Bt68KM=;
        b=P0J2c7IG/tvM6LVjE3VuxRJEdBF2J9NptiswvmiCXpPv+GD+bgC451Wak8f8WSEXG7
         qDdY19+O/bST/SVmer17zTh654XJtrzMvw2Y2LofqZJZMcsA4VmFA6gv9E7ZW6qLmDKI
         PeTv2wUIcPSWnpODTYsHFmPsEMHB/bkbe2CvWFUAwdGGVnzMdABvHXby2YDCukmhEwLj
         ihCO0EU1qRcn3ZdxWtdvwCUepX3ZQ5Fu3/Ypkdv8fKGxP3sU/CLHNQmQ87lftRgcFhFH
         Zicv8LIlSom6RFm/QsrLEJe4WXtIv3BpgO+7LYobPqiJs9Q9gQXqvO/xkw76txI8FrXK
         5R4Q==
X-Forwarded-Encrypted: i=1; AHgh+RrK/E/GLhyZBJqCKdfaXRMpU14vmF1ocfIQn1M/+hOBSWTVSad0h6w6bFdVyGOaAwNRhDP8Bg==@lists.linux.dev
X-Gm-Message-State: AFuF++mjuvOPdnK/BZQt8iXdDbcUMxtNs5nDbGIYrEwm4cfqr0a1eeR0
	dxWDQAqKYmfYT6HT4nzscOezwR+H18iYPenw3uxLGwmVA2O97I4NcYFNG1Q+hsu25E6sTwWtv/z
	rgNNWTXcLHqMV79Nf0g4UHXjlmwRQ2NoSbMjrXtkUTyU8f8tivZMgzXYw8g==
X-Gm-Gg: AR+sD11O0+ZiVxfCbnbWqwr5alqzLZ24WAFQAzyxUP3kEiYmxgpKUeBPiOtNFeuvhui
	trDm9c3QbZtxhV1kPrtKW5mXDCdhGsNgcbTxq7F9UFJ1+Ymjlwvh7OWBkqpfpGigATs50Q0XWH1
	no+6FWwn2/9xvwPpP8uwIYp9Npl7eRpctR7KBVQ3Zi4mVZcJ9SFMT78yTYavxqspIi92k3py7J+
	tQJEYK5WdQHX2xbA6VDkgrfLJwy31q27nGC7w1tS6Z02B0lQDh0gh3Hbim+TBchlVfp3BuelJNn
	GdVb9qFgFfuTN8R1ZzdVtHQ4eo49I8oD4ePa+pC/p8/K1xh/CtnRTBUYq4xPgAVuaFCTnkw+wrR
	9y4E3O97rDhZ9bzBGLYX6pgLuNGcHlUkO/TE=
X-Received: by 2002:a05:622a:2c5:b0:528:3d62:16c8 with SMTP id d75a77b69052e-52e2f1560f9mr82768291cf.31.1787674498328;
        Tue, 25 Aug 2026 09:14:58 -0700 (PDT)
X-Received: by 2002:a05:622a:2c5:b0:528:3d62:16c8 with SMTP id d75a77b69052e-52e2f1560f9mr82767541cf.31.1787674497799;
        Tue, 25 Aug 2026 09:14:57 -0700 (PDT)
Received: from localhost (ip-86-49-251-7.bb.vodafone.cz. [86.49.251.7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a9b43cesm24652066b.49.2026.08.25.09.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 09:14:56 -0700 (PDT)
Date: Tue, 25 Aug 2026 18:14:55 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
        anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com,
        fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v4 02/21] iommufd: Add iommufd_sw_map_msi()
Message-ID: <cxbneh42ui3gbkoqrsnoatxoec5exzbprfbgxcy4iekqmbceho@gouiwn5q5uzs>
References: <dug43layphru76sqleerwtryyerwa4a6n5s4xwrk4iyfru4o7m@al37eknignld>
 <20260821172015.GL244917@nvidia.com>
 <t2l77h22pz2jg5vsgoth6324u36szra3orgr2g2xo7olyuhzlb@53wnsyhz7aqr>
 <20260822140625.GM244917@nvidia.com>
 <r47pwpyoc4ynv57vtwer73dwikqkev5nfy7kqyba7sqzh5pryi@teiqr5a4cw4p>
 <20260824125204.GP244917@nvidia.com>
 <fp5myre5qaersxxshitgoupbzkx2zwo3rsz3q5jfdiarmtwknh@gmfhz3cxuc33>
 <20260824170417.GR244917@nvidia.com>
 <3gdj54zcs5dncgom3zlntyredyuh2xe5ueg7nd4pdrcksmnwfl@k3fyky4h6556>
 <20260825140334.GA3325090@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825140334.GA3325090@nvidia.com>
X-Proofpoint-GUID: g--0bAebcBdR94WCWjC7C0NbeQkBEYx1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDEzOCBTYWx0ZWRfX/K6gxNTkdkQp
 uZ7HnL+j8AahErosPXV2XNExx1OFCdlhhCUqZA44A5CbK7GpD9F/Vt1nTjcAX655YNNYildJVaq
 52NBTNtW5rAw0FbyZ9RVaoP14mFxN9WjRFwty7gvh8JGAO3e+gLSverLonMU1+gORXH/MkBC9TI
 zrqDLjsQA+xPGCX0+M3DiKGtAcA4uilesdRX6XeuYNnvezSlFwXo3UFRqyUjWqLSaj5sppxBLZO
 So9u1MWjpWhhSLNFlfy4t7aM/IXEdhyINGD4AL+333G8/UtlBsN0w374GTzoxj9cA91+uiNXqnh
 qPW7YulDXVAtLbjQn/5baQdRR2mAgRBP8zVlGuonKxYL9buxcwSPJXxbKkX4uZSvuy7VDBPF5cW
 fZZWx0Dz9nptOmHasOpIiwn/0ygzBBtIJhSqg5uUgQtwapGCu+H9BPztD1AcMmWHBG/FCEDyWM8
 7Wklgb0Qhw+Z2VI6jTw==
X-Authority-Analysis: v=2.4 cv=ZuHd7d7G c=1 sm=1 tr=0 ts=6a8dbf83 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=on9AXyaqQ0RhfYpiXjjEXA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=LqIzrL5QFeEt-TcFteMA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDEzOCBTYWx0ZWRfXxZ4OFq51jk3K
 ykVcaohfTpg8zmdOzKfcljG2vDAI3qz89sJDpUCVhcQySitQiuyYVEMUk/cdq8xR8Ajx7e25Hg4
 i0hdMX/uCJ+g1jN5a9fKCKm8s13BpJk=
X-Proofpoint-ORIG-GUID: g--0bAebcBdR94WCWjC7C0NbeQkBEYx1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250138

On Tue, Aug 25, 2026 at 11:03:34AM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 25, 2026 at 03:24:01PM +0200, Andrew Jones wrote:
> 
> > The irqdomains remain per-device. The MSI table belongs to the
> > corresponding S2 IOMMU domain and its configuration is bound to one VM's
> > IMSIC topology. The current prototype rejects irqbypass from another VM
> > once the table has an owner. The irqdomain does not sit on top of the
> > vIOMMUs. A vIOMMU links guest-controlled S1 domains to their S2 parent,
> > while the per-device irqdomain is the IRQ-side entry point for updating
> > that parent's MSI table.
> 
> Doesn't sound like the right design to me. Pretending it is not bound
> to the S2 just to make it global then blocking multi-VM is not a good
> place to start from.

The MSI table fields are part of the IOMMU device context, and the
device's irqdomain is how IRQ operations reach the IOMMU driver. The
table storage is owned by the S2 domain so all devices attached to that
domain use the same mappings. Sharing an S2 domain between VMs would
also share their DMA address space, so rejecting a different owner for
the MSI table is only a sanity check, not an expected limitation.

> 
> It needs a design where the guest remap is linked to the viommu so it
> can be per-vm, somehow.
> 
> > For the host remapping implemented by this series, each irqdomain is
> > per-device because it is inserted into the device's IRQ hierarchy and
> > provides MSI remapping through irq_compose_msi_msg().
> 
> And this is an entirely different thing, you don't need a domain just
> to call irq_compose_msi_msg()..

The IOMMU irqdomain does not merely call irq_compose_msi_msg(). It
implements that callback to perform host MSI remapping. Without this
layer, that remapping logic would have to be put in the IMSIC driver,
where it does not belong.

Thanks,
drew
