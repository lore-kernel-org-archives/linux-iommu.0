Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7089E3FADFA
	for <iommu@lists.linux.dev>; Mon,  4 May 2026 19:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777924395; cv=none; b=j+Z9HwH2PMx47LmfqfJH+4LyJUqWNdpGSmnmyfSlcL2mD23ZZuPi9RH/GmScX7xLXq/5cfcrZZnZTW5PPSdmNi1Uv4epKkSAJbalhZOfvlPVnsC/KkSTr/ngvlSFp9hTLDqOt1s3fYLyf7s0C92oRaucN8P3gInqF9Bet362+4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777924395; c=relaxed/simple;
	bh=pAIjiQkn1wItV63dO057etiLfv8E6TPFM8iGvtvjxtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0z7el6y+ghrFjUNO96NrloAo0u8N7LgMN420Y3qV1ZI5nC1SAeAIHYXonjk65HVGdFuBDBfREyx2yr7mpxgAeAMdNqiNDrouWlzjcpPTennww0A+tIqdFDB7PgNjwpmzKDdSe2bSE6CP1gfmn/Uw1vXjibbq/W8M7Ok4YYD6Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=puq8KFDG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GDn12Lo2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="puq8KFDG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GDn12Lo2"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644JmoRF366522
	for <iommu@lists.linux.dev>; Mon, 4 May 2026 19:53:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ploYMy0AO9N2sXsyPdbZNrPHPfiBphdWIDBYxYTu3gs=; b=puq8KFDGz9s1l076
	9fXvFzlevSb59poqwX3Xls1uQG6DW+ISL7h3hkc/3hZ1kWmKGTyoV6qJCkQ454/H
	8BdaTU5vSoZed3aSBRiD1GtSqJSeJEPXm06SPmDlI6hcnl+MVMvgiX/MIxoDBPyE
	702HJV7wx3rT4otbew5lO5juRPdZIqP2zY2hgN2admZc+RW1r+nhojPZ+6X5Sq9a
	aQb0hRHpUhkBfqSjn3y5zRENpG6j+sIzjUFXBAVORKwljL1nuRLf/Yd3YN8KVFMQ
	d2n2c8YET6REnQeK1c+ZfBfRED4qxKk7MrqVMvkt5iIeV6is4gi9LBrXGo2cApxo
	0EJtyA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxvn6sey1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 04 May 2026 19:53:13 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso7897005eec.0
        for <iommu@lists.linux.dev>; Mon, 04 May 2026 12:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777924392; x=1778529192; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ploYMy0AO9N2sXsyPdbZNrPHPfiBphdWIDBYxYTu3gs=;
        b=GDn12Lo25RzM09pWigE3Q7NKEGYW6DryooP45fmizNzx9rx9Z9joAOH+y/W3UcHMfE
         dDdn27hCus2FTOaS0v/hIiZs3k5QSM9gfDNO3TgtMsW6IF5vWGj5y1b3K+0THHSuix1S
         hQI+r0+UZJcqFNHk9A2TeygvQZ5d9Hn4KJXoJAxX5XE3A61f6f0cMDBNbkaL0XoIWOCb
         vgLNGlqolXNYluiSwUxr3GqTp6Ln4tXtxxoRo5xQlwS20smoJBDEXPc/yCUU0mpKBtKy
         +gnUInMB2K7rF2eqGIXd/9fcVp9IzHOEhJQ6iJgJXoOXIWme/j8BH3hKx8Zx/PXHwwcR
         TXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777924392; x=1778529192;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ploYMy0AO9N2sXsyPdbZNrPHPfiBphdWIDBYxYTu3gs=;
        b=Bx8BZTYy7/I5WGd57TWRSZ/BjKp8LPmzuqrAYm97oKRhNujSz3AzJyja6YkG2cV7on
         xi4/iaWwj7cOXuqYTwpW+SfmwNX0CEVrW2cYragynotAprOvsA5iMGQl4I+adddt3/wl
         abozOMpLgKBDC1W4VTepsEv1+cAe7nnzzX7VtY/gUCKLchZ6kv/c+I8LSbTado586BxY
         o/dkCrMT3wDWaGAwo5gU9gqO1YJ7WEI9Tgd08EFOjtrObwLhZ8JhlgVdZxyoarVgqEN4
         QRB/84SNd7JmzuzrMOkausP2+FUBojlBVTtavkC9sbVzDZAx4OyYFpVd+lghN6PHxRY2
         mN/Q==
X-Forwarded-Encrypted: i=1; AFNElJ+kpQBV1at5c0+aSHFZmNPeAndXScouD9svJM8icvQ33OqygTludB1FQyhsHHnVCgrRc4SeHg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzuY02HtqVbDGGHz9fFXQxEB8sO4GxZ9P+IDQ/6jLkKIu/u2lCW
	cJyl3y5GzbaB2UY2GA7M3uQ3d74hrsPfqRvj97j5hVIrqrePGxPF8UuhsXOUWZ8WqkmRs9mEZDK
	QwxMDNh3zCcJ3Rt4jufiaEWZ07rMesqFS2gLnJa1mAB6sWbGn8cKGj2FNow==
X-Gm-Gg: AeBDievfRyQDMgj0O+6bdtHUZ55Oo/xprXx0hKX3LpGyYQhUmoyi3bZ722SV2uD8T02
	Uzr7mF3O9JtTW7pbGpJ6riKLkC4rqwQ6k6I7SoG7m6HglIcIeL0S3KO2O4MP9iJ/i/R64FdDjdf
	KWYKsWk4w2RZ00+vWztgNmQCvwgvNZ5zr7wNpjqv7sGTJQkcnb7Z9O2ZjPB5MVIjluO4np1Sc2X
	YarsT2pkFHediA8k7QIyQXqPEbVAiX/ZeLWpbRbJMmLn+rtkTUahE8Thd1a06bhLmx2ParIl0Xm
	JFti9E3749yjMubwYrp+KSdxBSC/fm/RYGaHSZzcVPwbUhlX1U4kTZ43+C6pBHy/tq0S8LID/cK
	CTKNqvGZ1BjHnB7MRZ9yM0wmNEVhgPzhNCLfgoThw
X-Received: by 2002:a05:7301:678f:b0:2ed:27a3:eae3 with SMTP id 5a478bee46e88-2efba17a51fmr5429706eec.26.1777924392211;
        Mon, 04 May 2026 12:53:12 -0700 (PDT)
X-Received: by 2002:a05:7301:678f:b0:2ed:27a3:eae3 with SMTP id 5a478bee46e88-2efba17a51fmr5429683eec.26.1777924391681;
        Mon, 04 May 2026 12:53:11 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3b783a95sm17660932eec.22.2026.05.04.12.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 12:53:11 -0700 (PDT)
Date: Mon, 4 May 2026 14:53:09 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: fangyu.yu@linux.alibaba.com
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
        tjeznach@rivosinc.com, jgg@ziepe.ca, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, vasant.hegde@amd.com, anup@brainfault.org,
        atish.patra@linux.dev, skhawaja@google.com, jgg@nvidia.com,
        guoren@kernel.org, kvm@vger.kernel.org, iommu@lists.linux.dev,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/11] iommu/riscv: Add hardware dirty tracking for
 second-stage domains
Message-ID: <tdcd7276ffsfc6vh3expyfcajnfkowknbtkpyplb3xe3dcukj2@tnhi6jcwrfgn>
References: <20260428131359.34872-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260428131359.34872-1-fangyu.yu@linux.alibaba.com>
X-Proofpoint-ORIG-GUID: 1A0hnXWTLs-dXTUAp-kU70pwcxrTwndG
X-Authority-Analysis: v=2.4 cv=Z+vc2nRA c=1 sm=1 tr=0 ts=69f8f929 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=SRrdq9N9AAAA:8 a=O0cgCnXdde_TIKaFu4kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: 1A0hnXWTLs-dXTUAp-kU70pwcxrTwndG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE4MiBTYWx0ZWRfX76flCzEH8JsU
 iiouzpcY4hDwdrGc6tQ9HmsY/j/6I8tHlxj7NhrIIlEqXl/E90ShUbcNdzxoB1gKYG14q+JXbpd
 rnY6W5OHmW7zWXyLFkJ1Vp5oq7zh/IyIWMyRugSn4LhXtVsOYcTLG8KvSF4LC98m9DhDsFWuNGW
 +Vwkv69IDMqEoboib1G/JfsqmxwUzutf/qL4dL+iF8LVFOzGicWhzSiSiOUL01a+ur89qfBZbac
 h6wzgCDQa1pYxkstsnIPRd5qZY8B9xcKgnVjtijTB83AL2UQSDDW+Nox6tRHYmDnL8Nhl63gbJC
 99ZSL/91hmIXvWkxRTBWWBTUed9JKF1+1jt5bd+/eaYyL2vIXSkQh9hlfLg7AQG95LW/BnghO3n
 uI0E7HaKEDnuSxBHZWbI5lHjjJTSwj3vwFB7rhxb/7JIdnowoCKTBoQs+R8CJwF8o3OQfsypkLh
 kAV/K8GBUcolhNZsdIQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605040182

On Tue, Apr 28, 2026 at 09:13:48PM +0800, fangyu.yu@linux.alibaba.com wrote:
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> 
> The RISC-V IOMMU architecture defines an AMO_HWAD capability (Hardware
> Access/Dirty update) that allows the IOMMU to atomically set the A/D bits
> in second-stage PTEs on DMA access.  When DC.tc.GADE is asserted, the IOMMU
> autonomously sets D on the first write to a page mapped by an iohgatp
> domain.  This series wires that capability up to the iommufd dirty-tracking
> interface (IOMMU_HWPT_SET_DIRTY_TRACKING / IOMMU_HWPT_GET_DIRTY_BITMAP) and
> reports IOMMU_CAP_DIRTY_TRACKING.
> 
> Design notes
> ------------
> 
> * The feature is scoped to second-stage (iohgatp) domains only; these are
>   the domains created for KVM / VFIO device pass-through when userspace
>   allocates an HWPT with IOMMU_HWPT_ALLOC_NEST_PARENT or
>   IOMMU_HWPT_ALLOC_DIRTY_TRACKING.  First-stage (iosatp) domains are not
>   touched by this series.
> 
> * The page-table side plugs into the existing generic_pt dirty hook
>   framework (amdv1 / vtdss style).  RISC-V adds the three required PTE
>   ops – is_write_dirty / make_write_clean / make_write_dirty.
> 
> Testing
> -------
> 
> * Test on QEMU RISC-V, a virtio-net and an e1000e device was passed through
>   to an L2 guest via vfio-pci + iommufd.
> 
> * generic_pt KUnit: the existing test_dirty case now runs and passes for
>   the RISC-V 64-bit format.
> 
> Follow-up work
> --------------
> * Build a dedicated end-to-end test case that drives the full flow
>   (HWPT_ALLOC with DIRTY_TRACKING -> attach -> IOAS_MAP -> generate real
>   DMA -> SET_DIRTY_TRACKING -> GET_DIRTY_BITMAP -> verify bitmap against
>   expected IOVA footprint) so that the behaviour can be regression-tested
>   beyond the KUnit PTE-level coverage.
> 
> * If possible, rebase and retest on top of the updated "iommu irqbypass"
>   patchset.

Thanks for this series! I was starting to go down a similar road myself
in order to limit irqbypass to IOMMU_HWPT_ALLOC_NEST_PARENT domains since
I wasn't happy with other approaches, e.g. continuing to use s-stage, but
activating g-stage too with identity mappings since the MSI table can't be
activated otherwise. Or, simply using g-stage instead of s-stage in order
to get the MSI table enabled. In the end, I think the best is to require
nested for irqbypass and this series will provide a good base for that.

I'll rebase irqbypass on this series and test it out.

Thanks,
drew
