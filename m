Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADE83B42C7
	for <iommu@lists.linux.dev>; Sat,  3 Oct 2026 12:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791029021; cv=none; b=D7mruur12KCbh6dkVFxdCHsbKtg/VKYFgtT6AwP4KGkSjSGRVyCoA0NvtTAdhd5lkUyrWRxmnIMpsTNipN4rqyTtUc88nIlurACYGr75gVr7fEtNW8ZeaNlmnisneBhxc/IadKsTXU+OucjbVjJeSCRC8SpNa477KxuGTcgrXZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791029021; c=relaxed/simple;
	bh=ld0OrougPNfBp6Ry3148Z2Li9neJoj1Ak158VsVyVmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmypVxQd18KR8yPd4trnszQ6cAnlSMjLLfyzFiBydJBKt/xO6KCueIBquD0tV43/fxCptjkfcEyd3+bbObjJarczUh4nwt6cnTYjB264/N3O7S2F0suORnE3dm/RI44ZMPZg+RXgp5urb0j2OX3DdnLz5GJqUpoiXWiIHa4vzy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iaPbbMLi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GEvoj3uX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iaPbbMLi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GEvoj3uX"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 693AtrA03312916
	for <iommu@lists.linux.dev>; Sat, 3 Oct 2026 12:03:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ld0OrougPNfBp6Ry3148Z2Li
	9neJoj1Ak158VsVyVmo=; b=iaPbbMLi2rtDwRfy/OT6hy7GqUujdf404T8d/T9O
	sKhA14+aPKlNSOfIAqwoI9Gqe/qCTLjw6wpZxa4xs6HFlfDxQzBEX42km7tthw4Q
	GIU/WQkR1xGKW1jPoz/QxCZEoDAca/pBbLT2F/9RA4ZZT8gI1+6SWavNpYhubaOF
	KEvO4F+TPCjusBwwIroVCK1YeFKbVF5gKW0IfqNIUOQKCA+LnZXRAUNZswGfOxAo
	MG2bnrEScHPcrhNycWBdjGhCjF48ZJoNeU1wXl8VODbMLgQS/HNwfKFAe6BWhmQQ
	tS3EDMQk3WIr1adwX45D1p9BWFvjjHfz5KD21rtUI3WrNg==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2t36grnj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sat, 03 Oct 2026 12:03:38 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5c93c294214so109816e0c.0
        for <iommu@lists.linux.dev>; Sat, 03 Oct 2026 05:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791029018; x=1791633818; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ld0OrougPNfBp6Ry3148Z2Li9neJoj1Ak158VsVyVmo=;
        b=GEvoj3uXuOuUtnRIZG1GAAItn18+ezoal6EbRvB3Dm14/RIOGjyKoyWHD1dNZSzUZL
         aAXm3VBSPM+avc82NvJ8WEiP2yPxf5PXvfUPXraJzGnQJ1sMPPpNmHdbYzXE+FjXz3MQ
         L/1VEbXqba+JT4NWhu86Q4Z0H0ta1Y3qMg8G4Njb31IhJ68yOZKPiHe6535ezT9CwZGl
         /FTRgXmVkAbuP6UrjWvmxmWS1/Pw34FUJGH+777gpgB27nF6y+lyCwSrV7Suz2V2HS68
         lJe1r6Cyfy/wf6V3a2WhhZUmRX0Cypl5imjyufwRpU7QyuTDCRc+nqiA2DLCVQ7o3nCv
         X8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791029018; x=1791633818;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ld0OrougPNfBp6Ry3148Z2Li9neJoj1Ak158VsVyVmo=;
        b=SMkXdOrRWFakDRyklJ2jyAVNiUKlbu28BwL9uZh6NuZ7hkk/wtLNo23JMXhVenIIx6
         0SJdMjCTKFxMec8uxpZOtr7He3DNKhV/ghhwDU6gSpWvokZ/9yK4drf9CO/qIk/l7S2E
         i1QfF+H7r31zVB3tUi8QI46O5pbbUfXifoykWGlMJdq5jQsMoNJ9hEetqFw2v0lQbwNK
         RPNpN0hnY2/es1Uk9dDUKnYXxMkT8lrRtz4dr1GwS2v8JzyKqXl/hODBC0NSkpCTfyHt
         PZErQb9rBCC3Q19+tCv/0itlpyMzrEugpl6JT/1xBo7yYYz8UYepVPxvVDzCHX0vKfCp
         tg4g==
X-Forwarded-Encrypted: i=1; AKwUvBxFBNwN+OKe33DTDtqdji8XfAMzZEtngTL1soxcaV5kaYvEvvBHzSBaEvNZhZBR+7q+qsu92Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ2dh0ChCYazetlxLjAETYFOFJ46BIM9py1UhE+lexM87sz87/Y
	IwG29OMg7p9XZNR9qSM1TPdR53ipbMFTgYCTw7bYDlYCnCIl19BLpIsRollT1sH2CVWDCQFWnCW
	QVgJC4Wa+6bTqQuCh+blsq7NibusXDE4PPzJpzSwKk0Lq0Jv2GKYnvHvAHw==
X-Gm-Gg: AYBFou1dzXB4uDwbOlipdzjNL9LaqMIHqN444lbmfj9mPYqLSfS2YU6IG/oRs1sG4RO
	ZSfTwWODJ+jPkQ+HQePnab5FrGFYwRvkVYQ57nHZe9dtbu12THkiHVQWMuHq5Ltxcw5NuelxhHw
	GncZKDgagwX9Ivds2KJNXfYQoXwf4U9OjNuCI4OMTZiOfxuR64Xhzr44Rl751T/PiWJzV3cJs71
	fcyXv9cdkH9SjlYQXpR7qXfn9Gv4b+p+04Yr2HH68NsfZ93/ZflvXtUxqkMdQx/t02z1VX1/CcT
	WSwrMsmG6aosanUMW6xF22iDSKQ114Yt2t5E5w5J0tTDxJr5mLh7JN1d/8vBPmuW7XKFORW9Yzp
	J3bpcQyL2Da/c8/jHfcrZ3zzBEzC9
X-Received: by 2002:a05:6102:6415:b0:7c1:75c5:c4c with SMTP id ada2fe7eead31-7c175c521afmr567416137.25.1791029017764;
        Sat, 03 Oct 2026 05:03:37 -0700 (PDT)
X-Received: by 2002:a05:6102:6415:b0:7c1:75c5:c4c with SMTP id ada2fe7eead31-7c175c521afmr567402137.25.1791029017224;
        Sat, 03 Oct 2026 05:03:37 -0700 (PDT)
Received: from localhost (109-81-9-204.rct.o2.cz. [109.81.9.204])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0394c937csm97187345e9.1.2026.10.03.05.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 05:03:36 -0700 (PDT)
Date: Sat, 3 Oct 2026 14:03:35 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
        anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com,
        fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v6 01/16] iommu/dma: Prepare MSI physical address lists
Message-ID: <pph73bajtpgp3u5vb7xjqmbrz35zs2lw7fpkhobg5jdzbjw2vq@usg3jbbneskp>
References: <20260925151659.419512-1-andrew.jones@oss.qualcomm.com>
 <20260925151659.419512-2-andrew.jones@oss.qualcomm.com>
 <18c9b030-8dc6-4242-8e66-0448ee125d7d@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18c9b030-8dc6-4242-8e66-0448ee125d7d@arm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDA0NyBTYWx0ZWRfX0hB32BmDuHuT
 M/RJM+gA4eTg3xQq8MVXvsJ9d+L3zPXspjzK72gFDJg5QgJrzsODu9YmAzrHw3DqfdFNpbDotTk
 vTg/Rb72oWdr5iseBLGsFPfomaXTiiw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDA0NyBTYWx0ZWRfX54M00t8OblGH
 4309wqyeGkGmKeMkGVXTbr4wFfKKuw40t8XyquiMEwMVJpmgaFFEd8wwNVc99LhHqrAKUkOaHrX
 LmBExJrDwcHPHaVsabqmdPtkqh/sEhjQ2rAP/XMVy6nqQG2psjFOKqbXzNWYSK2cESzK91gdee5
 +Mg8DQ4XJsyG5hkDKJGLRXrQkJ0nZzplVlVb5ML4fj3VYuw0SUte3Yhab87gDdJz0tgOiT9WC3S
 QL3mAr+gqemRe9mL7IhPg9KpeDejUf89rRjp84rIbibhHOQfREEnmXMj/ykXLxhV6F7Oeeuffov
 QyvAaL8eTEPcObPfJmys2vWm9mEm9h9Hq7U1FGrWSfq0Mhx3pzicUUWsK2SosmM2qfGCXK9FgBb
 FNRT215WYkEwEpXFoSo7cAfoEBP7JylnQYC+UBgzYzhamtCg6J0d6gdTN6qvRJnEm130GeIT46D
 B6UFkDapYpelGBAw2cA==
X-Proofpoint-ORIG-GUID: nqrn5pe42XdtEAu20KgWb9RdrI-bX-kb
X-Authority-Analysis: v=2.4 cv=UpH2pOwB c=1 sm=1 tr=0 ts=6ac0ef1a cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=0bpig9kOJEczWR0iouTWkw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=PG2Lv3-wYJ-N5-kAUs0A:9 a=CjuIK1q_8ugA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-GUID: nqrn5pe42XdtEAu20KgWb9RdrI-bX-kb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-03_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610030047


Hi Robin,

On Fri, Oct 02, 2026 at 05:21:18PM +0100, Robin Murphy wrote:
> You already end up adding what is effectively a RISC-V-specific
> entrypoint, so you may as well just carry that all the way through to
> its own effectively RISC-V-specific implementation

The list API came out of the v4[1] discussion with Jason. Preparing the
targets as one contiguous IOVA range lets the MSI descriptor cache the
base and IMSIC compose the address as base + CPU offset. That got
rid of the separate domain-local lookup table and its lifetime handling,
which I think was a worthwhile improvement.

I'd like to keep that model. I'm open to splitting the implementation,
but most of the added code seems necessary to prepare multiple targets
together, regardless of whether the list is fixed.

> it should merely be a case of whether a) this is the first call for
> the given cookie so everything needs mapping, or b) it's not the
> first call, so everything must already be mapped and we can just
> return the IOVA.

For DMA-IOMMU, yes, remembering the base would let us drop the range
matching. We'd still need the contiguous IOVA allocation, mapping loop,
rollback on failure, and locking across the whole operation.

For iommufd, there are also separate things to track: whether the context
has allocated IOVAs for the set, whether a particular HWPT has those
mappings installed, and whether a group needs them installed when its
domain is replaced. Having one fixed list doesn't by itself remove
that bookkeeping.

The current IMSIC caller does always supply the same list. We could make
that a requirement, but we'd need to define its scope: per cookie for
DMA-IOMMU, and how it applies across groups and HWPTs for iommufd. The
current interface instead takes an ordered list and provides contiguous
IOVAs for it; the range matching makes reuse honor that contract.

> At very worst, a separate hook to just pre-populate msi_page_list
> with a regular page for each IMSIC address [...] could probably
> suffice without any other major structural changes

Is the main concern the range matching, or the shared mapping path
itself? Apart from lookup, both paths need much the same allocation,
mapping, locking, cleanup, and descriptor handling. Keeping those
separate seems likely to duplicate code, while factoring them into
shared helpers seems likely to bring us back towards a list-based
mapping helper.

We could handle lookup of existing mappings separately for the single-page
and list cases while sharing the allocation and mapping code. But I'm not
yet seeing a substantial overall simplification from requiring a fixed
list. Is there more bookkeeping you have in mind that could go away with
that restriction?

[1] https://lore.kernel.org/all/20260820214150.545737-3-andrew.jones@oss.qualcomm.com/

Thanks,
drew
