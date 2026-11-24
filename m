Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795504150;
	b=wF3XdG0ml+1eryV4I+XZcrDPZVz7uNRfJQ/vgHTIR6TOebm8d11Rk256xtHGFgLcOsG7
	 5MUQXaoX/qP/J65/8a6rg4by7z8oCig6zUsBw19bJxDJKHhk09KDZ6gTwhgR7bnP6jxLw
	 gpZGaOADh7hB8znA6L4u+hhUKz0CbPIFcTM3df9iHTZbHi+uq/8fCNLv0ZV9EOzzNvTsD
	 yfem9f8h4JZzGvdF7l4i6AnYTxTduvgdLz/WPb/JB3Tkmtw0WOi+avIRX+KWowb6qJVnL
	 Ums8bnZ7eruExFK/2oYhJ8rnZHgvqC3yDhJVBVjDF/+q8y92DcvktB2uxBBxRvQbR4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795504150;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=6m/b+6EX5RsyAmAEcClGX0keL9p9C/iJZdE5iiUnz7Q=;
	b=1uzQmfASeZUY6Ns0TREs8l2KDLfz3aUw4ywITg6svKoCMQi7M+Lle0c2BHKp5+8JZ1hp
	 NTGUtrOP0Y7yMhXZWm0dH5Vv9QoC5yrXI0QitP0xELp3zH5NNPpGoU3KHs3NZovmnfWUb
	 VjFLQINhb/aJJnjTenNFu9/UScbhLp+uBDzQDmv+bkeSelDiWm7GsDeWExmG/BTV7ka1P
	 M+3gqR4k4nALx9Nh086FHZRWRldKRvK3GqUIaIaDEKuhpMrNT4IU5lbd/++aPSkZbx30f
	 M5ZzyovdvxLskhAex1uRqge8ZkzuhSxQgfOlyLMRNxXGiHffaZoElKjQk1auKBPmVKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Es+jGl55;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N20mJjmz;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEA6606A326
	for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 07:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BEA6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Es+jGl55;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N20mJjmz
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO2kVKV2209788
	for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 07:09:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=6m/b+6EX5RsyAmAEcClGX0ke
	L9p9C/iJZdE5iiUnz7Q=; b=Es+jGl55u/Y+FucGIWCESP8ct6s3yNJ/zp/NNboH
	/sI0dDIgFmULXbq0SVrA/9vOUwXUqXiVJ9xz5iSPaCZR4f0btOjYplM9nzmqS5Jz
	JoXcfxLCyh3u/YqRu849pCTaBCzjLtN5qfOapRtDYw+VwlRic1NVXT8qSFq+AeeY
	FW/kZUAVB9To+OIR0fGF8DSo9w3aHa7wBVI8X44kolu9PS6V/LJI08DzOUGImLeC
	iL6GZlaAhLT7SMmVpkQi8cEvEUrm1bWgOF+FGhP06SfOc6Toco9UFd42Od+qmZWb
	D76cPA9Pq29B4lBJ3mwNjO9c91OKLc7IKqeRd2aWN0Bsaw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4yy11bgg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 07:09:08 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3869accaac2so2393143eec.1
        for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 23:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795504147; x=1796108947; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6m/b+6EX5RsyAmAEcClGX0keL9p9C/iJZdE5iiUnz7Q=;
        b=N20mJjmzjUqnSfSwDVvJhDRiUvpS4Wj2SJCntXDQWOdl3MDb+iIyPlvoWRpnSs4Jsm
         +/Rtloy5hchX3UsXmyONh1eZ+8NESO0+gpGjAz5Yhx/d8fr+F9AC34sFNfI0JoX7vbM6
         WbX65q3PtLoHYeaLjW6ToVVGhs/qG1PaEXM+vMp/Wgws/ZbaNxhxf0ajQsM9UnBJ468C
         gheR1iRZsUa/ZbQeglGKMi0FbYKAqdUlFFHPZOqZ0ab72gFdLObROg30H5kYv0GIwDwy
         qgIaJGN5bKVk/GrW9mngzu6WEULnGIxUcP4XG8TCInAVAiJnv89CPXui3Lu7jyqg8OUj
         F6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795504147; x=1796108947;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6m/b+6EX5RsyAmAEcClGX0keL9p9C/iJZdE5iiUnz7Q=;
        b=Ca62GAOTgeWxjCewJircxrJHLWHEZd0Pc8yiNuuTNm6Hrob6lR3GkoUEH41pwCl/2+
         +CbBWg8ODy/k2bDJvFCGEITcIETPAX3pkREGQkzXrGiyVfJ5c/04bU1n+8Ip6tz2sCqv
         G0ABXtGlTqm1HDEeaOfbf19yRO4EhuP0m5UZJQ0i4HJZf0q6gsdSR3d0C4X5OsVv5pbm
         HhFS0H004A2HF9iHBbWH0l2H1yI++LFsSSYMiVYIATtB0MxACOvCXCqesCF3FMooJkq3
         USx3hiRAiOIqcKaeuUE9WKe8RuFQ0+DYhjlxpCdzmxM8JlLc9s8D+wGvkoAt1c9VIc6u
         mb3g==
X-Forwarded-Encrypted: i=1; AL+hErFEd+fq1L7DrPD/KQbZBIM3E1pldmZOogOlCmKS5XjR1w/WYNQzhaku+5YuO+tHpsmyOPbmEQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+Ffz2MCjOglXFTGhrWoomrv/qq93y3Q3Wm5+AQONojY9DchcaS
	1sreOdHOZDc/sa8fci2eusqttH3/bxs84X8nuBezCw432cK6PPZLK8QGgE1E8H9vO6HtZHTWlfs
	3FIboMAZVFZRbiRwgfKPzk9guEz3oVQO7YiF72Nx3BOkWDULATbvPcTJWHg==
X-Gm-Gg: AZFdTZflrGN99pwdeCeDehqqRgk+AViCElhUIC4UHSVsHgMiIom0hbR2Lg5Vta37zTM
	c3XtI2gh703RHBtbCRqtf1qSWOZNeSC+RzFhooZQLIm8PiPxJMzWNsGy/QFkPScxlvbl5OnXnBk
	q8HxuIYbk2lvzbo4OvzLcJbLJzOnzamLRW+RqzRmTwH48zmr5b1iIx5+i766cWmXTLAVn6/bRdO
	BW/momgr52zN9N+nXlPhfEaFjTl4MK9mVSS3/A7n/V6JgDYUC5Y+KticqL27ljkgL1nWM+T2wXs
	S/3kR4yUXZ6uONy9asZmVvZLXRWKcAILpZ11qTI1es+qJh2pkfqXnDUp0LbAVZ5sn6cBtG8pFIi
	kneZEc5owxff3YsDMZsaeNMpkU5EZMPS32GIrUCKbCdND/1SRxvn6bENM3o2N7904P9ukuDEcOd
	ChfHBCD8UB/aSXK5xG7uZfhPA=
X-Received: by 2002:a05:7301:7187:b0:386:bd8:7abb with SMTP id 5a478bee46e88-3860bd889c6mr13390019eec.11.1795504146952;
        Mon, 23 Nov 2026 23:09:06 -0800 (PST)
X-Received: by 2002:a05:7301:7187:b0:386:bd8:7abb with SMTP id 5a478bee46e88-3860bd889c6mr13389985eec.11.1795504146344;
        Mon, 23 Nov 2026 23:09:06 -0800 (PST)
Received: from hu-petche-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386c7c62a91sm148263eec.17.2026.11.23.23.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 23:09:05 -0800 (PST)
Date: Mon, 23 Nov 2026 23:09:03 -0800
From: Peter Chen <peter.chen@oss.qualcomm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, Johan Hovold <johan@kernel.org>,
        Fenglin Wu <fenglin.wu@oss.qualcomm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Jack Pham <jack.pham@oss.qualcomm.com>,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: Re: [PATCH v2] iommu: Hold group references across bus_iommu_probe()
Message-ID: <awU4DyS7irT1a-nu@hu-petche-lv.qualcomm.com>
References: <20261112110747.1903321-1-peter.chen@oss.qualcomm.com>
 <179520803625.1164516.5819106673711321760.b4-review@b4>
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
In-Reply-To: <179520803625.1164516.5819106673711321760.b4-review@b4>
X-Proofpoint-ORIG-GUID: aGz4tHCA-SEwvPO-eGdgWSSzm1HzG6l5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAyOCBTYWx0ZWRfXytrkGUakVk/n
 4ZQed1naH0cx4pvHOUe/4rFgOtsDmh1DZvQl+n5S16cNtpVny79AfF/qwAj/jS5TtQr4pqOQknL
 nFY1FwLnChB/Hv/loWMiHsNf3WKlLAw=
X-Authority-Analysis: v=2.4 cv=JYspPkKV c=1 sm=1 tr=0 ts=6b053814 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=Es69j4hciQkVgYzS4lQA:9 a=CjuIK1q_8ugA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAyOCBTYWx0ZWRfX0WoAM+U+Iu6p
 WuE255VPBYFhvD6PfoCSqnqz2fJ77cbUbom+KbseTnJBiHuuUAUbHXrssuTbBgt6AVUeWDfE6rA
 1JrtZAZqct4U1u+ycfwdyeNa2RPWZuJLnT3LDBYW/bJYDum7smfVW59p3js4N65jxh4fFmJ18UL
 ko/ikaqU7BPu0/ayu1S/ryixMqKKXPQA+4lOr05QYjHvzw5rfeCLMD1ybT84b+zJDMR7KRCiQy+
 g7/IrrTXT6/8nLfoxDeeQpwfE7wlqTX/+rT8OwxE4WHY+iYKHx4uFb/nn87qFKYqzsyCevSvMIc
 sbOSbLZpny+X1a+Qxd7tTWmw2l1PicdEIhmrNrVyWzJtgDzSaBjFlU2zvhK9Nq2ZYuimu/4vMLN
 3e4rC96MWfvj71a4+kbv6Bjd0ArLjC+V2RBpvTCaU/ja0yjvHyxqAEGfqe5AupFHQ19Jw22dRl3
 iuCPpeCxntx3SlKRXuQ==
X-Proofpoint-GUID: aGz4tHCA-SEwvPO-eGdgWSSzm1HzG6l5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240028

On 26-11-20 16:53:56, Jason Gunthorpe wrote:
> > [ ... 9 lines skipped ... ]
> > This is the "iommu_bus_notifier() being triggered during
> > bus_iommu_probe()" case that commit da33e87bd2bf ("iommu: Handle yet
> > another race around registration") left open. The sequence is:
> > 
> >   CPU0 (driver's of_platform_populate / of_platform_depopulate() path)
> >   CPU1 (arm_smmu_device_probe() -> iommu_device_register())
> > 
> >   CPU0                                CPU1
> >   of_platform_device_create(T)
> >                                       bus_iommu_probe()
> >                                         __iommu_probe_device(T)
> >                                           allocates group X,
> >                                           queues X on group_list
> >   platform_device_unregister(T)
> >     iommu_bus_notifier()
> >       __iommu_group_remove_device(T)
> >         iommu_group_put(X) -> kfree(X)
> >                                         list_del_init(&X->entry)
> >                                           <- use-after-free
> 
> This seems odd, like shouldn't something outside the iommu subsystem
> be serializing these two things? If some driver is calling
> of_platform_device_create() and racing it with
> platform_device_unregister() it is broken, IMHO.
> 
> Can you explain more how this arises in the first place?


Hi Jason,

Thanks for reviewing.

It is not one driver racing create against unregister. It is the usual
glue/core pattern: the parent populates the child, and if the child is
not bound (due to IOMMU is not ready at this case) yet, it depopulates
and retries later. That runs at the same time as an unrelated IOMMU
instance registering.

We hit it on a Qualcomm SoC (Android 6.18 kernel), with a DT like this:

	usb@a600000 {				/* glue */
		compatible = "qcom,...";
		...
		usb@a600000 {			/* dwc3 core */
			compatible = "snps,dwc3";
			iommus = <&apps_smmu 0x40 0x0>;
		};
	};

The glue driver does what upstream dwc3-imx8mp.c does in
dwc3_imx8mp_probe():

	of_platform_populate(node, NULL, NULL, dev);
	pdev = of_find_device_by_node(dwc3_np);
	dwc = platform_get_drvdata(pdev);
	if (!dwc) {
		/* core probe deferred, e.g. its SMMU is not there yet */
		ret = -EPROBE_DEFER;
		goto depopulate;	/* -> platform_device_unregister() */
	}

The dwc3 core probe defers because apps_smmu has not registered yet,
so the glue depopulates the child. Meanwhile the SMMU driver probes
from the deferred probe work and calls iommu_device_register():

  glue (kworker)                         SMMU probe (deferred_probe_work)
  --------------                         --------------------------------
  of_platform_populate()
    device_add(T)  /* dwc3 core */
    T's probe -> -EPROBE_DEFER
                                         iommu_device_register()
                                           bus_iommu_probe(platform)
                                             __iommu_probe_device(T)
                                               dma_configure replay finds
                                               the SMMU, allocates group G,
                                               adds G to group_list
  platform_get_drvdata(T) == NULL
  of_platform_depopulate()
    platform_device_unregister(T)
      BUS_NOTIFY_REMOVED_DEVICE
        iommu_release_device(T)
          last ref on G dropped, G freed
                                             list_for_each_entry_safe(G...)
                                               mutex_lock(&G->mutex) <- UAF

The two sides only share the platform bus. Neither driver knows about
the other, so I don't see a lock outside the IOMMU core that could
order them. The glue does not know the SMMU is in the middle of
registering, and the SMMU driver has no relationship to the USB
device. Device add/remove can happen at any time while
bus_for_each_dev() runs, and that is why the core has
iommu_bus_notifier(). Commit da33e87bd2bf already handles this
notifier running during bus_iommu_probe(). This patch closes the
remaining hole, where a group on the on-stack list loses its last
device and gets freed.

I will put this real-world scenario into the commit message for v3.

> 
> > @@ -1951,6 +1955,18 @@ static void iommu_group_do_probe_finalize(struct device *dev)
> >  		ops->probe_finalize(dev);
> >  }
> >  
> > +static void iommu_group_list_put(struct list_head *group_list)
> > +{
> > +	struct iommu_group *group, *next;
> > +
> > +	list_for_each_entry_safe(group, next, group_list, entry) {
> > +		mutex_lock(&group->mutex);
> > +		list_del_init(&group->entry);
> > +		mutex_unlock(&group->mutex);
> > +		iommu_group_put(group);
> 
> What is the mutex for? The group_list is a stack head so what are we
> protecting list del against?
> 

Yes, the list head is on the stack, but group->entry is in the
shared group. "Is group->entry empty" is the de-dup flag that
__iommu_probe_device() tests and sets under group->mutex:

	if (list_empty(&group->entry))
		list_add_tail(&group->entry, group_list);

bus_iommu_probe() can run concurrently for different IOMMU instances,
since only the per-device probe is serialised by
iommu_probe_device_lock. So the unlink and re-init is done under
group->mutex to make it atomic with respect to that check-and-add,
the same as the existing loop in bus_iommu_probe().

It is only on the error path, the cost is little, so I'd prefer to
keep it. If you think that concurrency can't happen in practice,
I'm fine dropping it in v3.

-- 

Thanks,
Peter Chen
