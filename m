Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528D737F8A4
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 08:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787732605; cv=none; b=Fgc8V6h8qs6cFpIEKke2MLPF157C38SRqEh/nu2YoTolTW0ln+5caOsbHB5ZbxeJWYS+eUAocMSwj5RkDuj+4fEk61GPVhBVnWN/M6YFjGKzMBykRK4hUpGZOgD9jPyFF1sI9dzaX8IQyfkDXVPSwh8anc1WIIbIa8eboSSGTAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787732605; c=relaxed/simple;
	bh=GGQklN1sekyHyo8RvJfV6jEA03Lhw8CxaSxqgMVsa+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9N2qU2A3k2lCEvb2eE0yvQosT6dUMzKVjC21Px6K0NLrhtATxKrDlHdh2lssgNOziQGxzOI+pmrA2gPANVtsuLu5MHp64+Mu6Etfv20UlE2eDvOutjOsPx5DCuuilS1+2Sdo93fWAPEvKgO9Kel3LnHCam/HvDK/WPazT49zWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=duSEU5yY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RbFDrfeY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="duSEU5yY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RbFDrfeY"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67Q6RpD03210628
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 08:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=B6S0XSb7Xjf9sBqDwusWxhpG
	sdWSY98+rflXE12tMiQ=; b=duSEU5yYq1Ls1/kNz3Oz9ZRQs/OU6F2+/jnkEWKv
	Y03UEjjTY4C1opCcM3e+HKk/XBHo30MFFbuyM66iQdBoL5ZeM8aj912lga80432B
	QtMICHa/V2ZCPxSh3H6dMPkaKxRwQdx+IKuCmKr2H9it9SqzL8J5zH/h8Uq1tg3W
	cJEhAyQ6lcGpJOXBzQRhtxs3h9hlKfcPLMtjw0nFQ2ASYY//MKYbwkGT6zbwEGwg
	RrWa452PhVhoemS43EE5y7DInP+XFTU76B8KhgSzU31t9gp8Ljs/WUt6IJ/9nhGf
	J3WYn8JYaIu3RocBAM2cF/+U7gLYlXbGPMFP7qJaCkWniQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9fgrawvx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 08:23:23 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-52d33c89a29so8657771cf.1
        for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 01:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787732602; x=1788337402; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B6S0XSb7Xjf9sBqDwusWxhpGsdWSY98+rflXE12tMiQ=;
        b=RbFDrfeYYBaRX4BGnlg8ufchWwNvScVNq2lNrCIPRBRCZzw4KEjIlZhSytUPvDbHez
         V6XAEdu3OvXRBNBFt1eCbMk6xZwpwEQOyB6BBO8pAqTqsTFiAQCmplVJxxfdxmsS5tm7
         c/2l4hPr9fEng+USdDLf4NVdjTV0arRLH/Yn2x22gp6lH7XzutyDquBRLlp0QRb8acOl
         aeMKkNOHwCMjWlzwydDItbhagPFJ41e/nrweKm5DHloJxkVn2zbzaMeDfXDuFlxmFKFp
         nr6OTtHe3waLFQKc5YPreOddbWg4yHAL9obAiJkui8koHP3/SMwsXR7bw6paseHgebrf
         3UfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787732602; x=1788337402;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B6S0XSb7Xjf9sBqDwusWxhpGsdWSY98+rflXE12tMiQ=;
        b=Xx+Iisq+ZvXfjHAMGDjkGyEAQQi3rsrTfFTf39uBtKOnMOQOBs0KVunIDFwc2dli2c
         ozr+4XLGSe3koRHqUT1ez2MJATpV9HCz3ovP+fObstltsbPJG5B3MGnMYoM7UT7WiAa8
         niLsIkp07k91B/Z1poGcCLYUkYlms0hwnDirnLjlsbKgJ6Ap9P0SaVY8XNyxbUhRlXkT
         GfpwKvs3Od6yfC5EuYd2lPhPkh1skBZRpz20eHA8juo3qSCRzWsaZdKeRrc3dCIKFYqE
         9uYqOvc4NGRILQ1CSkNsnoboiHqOtFEELSUBDD5VWUhP9e+IbpMsR0FudV/NM9JA1zJc
         ekOg==
X-Forwarded-Encrypted: i=1; AHgh+RpKw+/4jCB8KxoaHOuW9h8j0ZFWdlLsk35SEn7e3MJ1HMc2QD8Qez+27cCI/RqESnH5KQY6Zg==@lists.linux.dev
X-Gm-Message-State: AFuF++naJ7YWEdIkFYRYx2mUfKP4wX3LZ/AEYNip62WzGkmoN4jw3LZm
	9I7JvK7Jv2GmnQ5lDH0ahkrhpzbIHUh0ONUngqIFj1T5J4DTs7G96QPE3f+8UTIUKYwtKW8NYpe
	xQ5nP8CzwjWREhkqSyugkHul7ISq64vzy3QAgfoSaI0MhxpcJWe2Cgcczdw==
X-Gm-Gg: AR+sD10Nn2RA/tP9okT+Esif1nSrhKHy37Ubs0cimT0A8jrc4l/3OSRDvRI3DZ7MIq+
	V1VKUfsz1MKgRwQr4Fsx3wu+om5MCASsULAlUoqa0J93yufTnNTAi2ZImrhIrxfu2zKuDBEjBK7
	7S/4QvcaDvtmn02NZM0FCB4MoA0fu2bhf7rXUjLPpR/nJ5v1WQUql/aIW4tGRdkPYsbUz6jMYTy
	RCf3I8wgBYbQtbXx5WU+meHh/d6TyjZGQRVN+/HoBHv4gTVtqcgPazrzT/fifHF3bcKOrFuULly
	fbzdKmmTt62XYux12UPHBMF4PlkrMjxod+oovR1kjCiaSkGh3BwMANX991t3Hf5dApwVa7dUuaX
	/9WAqa7xe
X-Received: by 2002:a05:622a:1924:b0:52d:cfb2:4f85 with SMTP id d75a77b69052e-52e4223567bmr52103361cf.4.1787732602572;
        Wed, 26 Aug 2026 01:23:22 -0700 (PDT)
X-Received: by 2002:a05:622a:1924:b0:52d:cfb2:4f85 with SMTP id d75a77b69052e-52e4223567bmr52103011cf.4.1787732602161;
        Wed, 26 Aug 2026 01:23:22 -0700 (PDT)
Received: from localhost ([193.165.40.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e27ab569sm1924300f8f.16.2026.08.26.01.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 01:23:21 -0700 (PDT)
Date: Wed, 26 Aug 2026 10:23:20 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
        anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com,
        fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v4 02/21] iommufd: Add iommufd_sw_map_msi()
Message-ID: <pzutriwhwe4whonj3veoo4hzxmq5tlmmyui5u6gt4bgl5wxxrg@qjsq2pvd7by3>
References: <r47pwpyoc4ynv57vtwer73dwikqkev5nfy7kqyba7sqzh5pryi@teiqr5a4cw4p>
 <20260824125204.GP244917@nvidia.com>
 <fp5myre5qaersxxshitgoupbzkx2zwo3rsz3q5jfdiarmtwknh@gmfhz3cxuc33>
 <20260824170417.GR244917@nvidia.com>
 <3gdj54zcs5dncgom3zlntyredyuh2xe5ueg7nd4pdrcksmnwfl@k3fyky4h6556>
 <20260825140334.GA3325090@nvidia.com>
 <cxbneh42ui3gbkoqrsnoatxoec5exzbprfbgxcy4iekqmbceho@gouiwn5q5uzs>
 <20260825165209.GB3325090@nvidia.com>
 <iltwtfmgnmofsroo7eqrvjx6yhqbptwutywq65mgm7adudz7pq@2mdg3dhvtoud>
 <20260825175901.GE3325090@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825175901.GE3325090@nvidia.com>
X-Proofpoint-GUID: qPZMBvFZvoUrqwUYiGpMAR8GOLXIaIbG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA2OCBTYWx0ZWRfX/YUDxQ43DVD/
 cYLs1BcEze3aF48hW0Rtns83pqCaitewwo9SXzC21wy2NaU9yekP2+5sTqEvGcPMVhUfdNRo+jQ
 NEZcdxE6PoBDLaLww4QTpXVynjSy0+zRu43FUOoSQD1QYfMlsLuEAbkpcIMMYhlAEWgV/j+LW70
 /SFr6FJ26jzbKoYAYjJ4tsQuVWvG0PXVzP5QkBHo7J9RDKPQFe0xp21eamqXOEUvs6A+iDMq3+l
 PjrNQf8JznuS7TdK6LBowiFYdZa2RNJxYPkMDVRVcNrrHxQQUZ1Uwcod25G3ADLpMIhaK5sf58d
 0rbJCUBmvIIec8RpAbrv8SW6LfxyubV4Zn0NtrGzgUTORELvlxcMQnbW7yUd3gdQ2ACrS/b16wl
 oC1SNYC6FId3paEWHJxsINYPWpqJUGJyxpVTheTfTCU+jDoNVccGzR35g8AK2Mb7zfJquBW5y4o
 NGxGq+j4/Em22bZtxrg==
X-Authority-Analysis: v=2.4 cv=d8LFDxjE c=1 sm=1 tr=0 ts=6a8ea27b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=CzrpMg+lqiTzknPDBj2tlw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=_zQ45S9eJeQoeudCiGEA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: qPZMBvFZvoUrqwUYiGpMAR8GOLXIaIbG
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA2OCBTYWx0ZWRfX85guNQxk4B/x
 Sgo8ZbOA621t6llMYcom/reTPFDGU1LSboe8CG8zHjp2QN1Q5G6AeZnZg3w8efnskhujA79lr7A
 j22PlqC4JAjE9a5GlssQJYiICEDNV3Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260068

On Tue, Aug 25, 2026 at 02:59:01PM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 25, 2026 at 07:38:50PM +0200, Andrew Jones wrote:
> 
> > The IRQ domain is per-device because it is part of the device's IRQ
> > hierarchy. It does not own the MSI table. It reaches the device's attached
> > IOMMU domain, which owns the mappings and MSI-table state. If a device is
> > behind parallel IOMMUs, the IOMMU domain implementation must program the
> > same mappings into all of them, just as it does for ordinary DMA.
> 
> The iommu driver should not be deeply involved in managing interrupts,
> its is wrong layering. Having the irq side present things it owns,
> like the physical page to iommu_dma_prepare_msi() or an entire
> remapping table, is much more reasonable, IMHO.
> 
> Even the x86 drivers with their mixed HW still put the irqdomain in
> charge of the msi related datastructures inside the iommu (including
> irqdomain directly editing device contexts!)

RISC-V uses the same basic model as x86 (an IOMMU-owned interrupt
remapping IRQ domain). x86 makes that domain per-IOMMU because its IRTE
resources belong to the IOMMU instance. RISC-V makes it per-device because
its callbacks operate on the device's attached IOMMU domain and preserve
that device's existing MSI parent. The IRQ callbacks provide the lifecycle
hooks, even though the mappings, MSI table, and device context all remain
IOMMU state.

> 
> > Right, the host does not use the MSI table. Host remapping replaces the
> > physical IMSIC address composed by the irqchip with an IOVA that the
> > device's ordinary paging domain maps back to that address.
> 
> That's what iommu_dma_prepare_msi() is for, it shouldn't be wrapped in
> an irqdomain.
>

As said, iommu_dma_prepare_msi() handles one fixed MSI target. RISC-V
has one target PA per IMSIC, so the proposed list API prepares them
together and guarantees contiguous IOVAs. The interrupt remapping IRQ
domain's compose callback selects the IOVA corresponding to the IMSIC PA
selected by its parent. That selection belongs in the IRQ hierarchy.

Thanks,
drew
