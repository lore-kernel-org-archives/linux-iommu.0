Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DED29B79B
	for <iommu@lists.linux.dev>; Sat,  9 May 2026 19:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778356045; cv=none; b=E/6o1cMmIItsJ6thLp0PCKVh2QjAEU+7QvAkAzWzEp7zcuVSbPxvUjY2Ofv0yZFFUStycd8AGw79n9f5b2ej9ToEyimr+zkWmtClX1AJFR5UNwnbxW7bUxxQXPGZV835MMly3bc7plvqs2sOV8OoDvWgHYSQqX0DZCXmPhClGjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778356045; c=relaxed/simple;
	bh=3c2SrJzXoUX38lC5V2KMAhqUkm9AqEfM84QtxNOPsS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBjzutj1mJL3HFIDnA7bgqBZ36S2UCott3yPZHv7Rv6xojkOxVEUPfAV79I/R9Zx9NmJ0WSYETEJIXHwBhPPaGvtC8thF+s8ZGeEUd4chG2F3CSqQKBbLzXiIkoGKmaC/YII3ttQFB5ouLSi7w5SOyHs1Y1ZLuDPSDgHqLForew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bAoj5RNy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=duo9hczA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bAoj5RNy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="duo9hczA"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6493YfR92546303
	for <iommu@lists.linux.dev>; Sat, 9 May 2026 19:47:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=qcUTwwXxkf2HWH/ifvHwwRpD
	M+pCbfceyt9Fwp8UIyw=; b=bAoj5RNyGHa4cWHWyenxJXHVHnKtWzesCTayuO7M
	IVzJieBSR277L4lYLrx55bvW2R3WQVeBhrerTSYm+aidgleZhnMTRIueGlPy0/kM
	M96g2GTOK0qD9r41EFKljpYtmlsi8GaeG01auIbn3olnKQn1MiXx5iceWSoalnnT
	fwjyuZp4nExTvQzjuzWxWBAsno4xGCUwPd28HGTIpZQ6hr1GMfS5B3+EZsDkLA5d
	PWCs5UerpSpZjpX5uMbQKWvp+OJMCzp+UMVmIjpOZJZKSX0rEUUx99eU6x5j6w5z
	GZDUZOD3/uixF/vyq+w+CNJouPrUOANKsSIZvid/pxfO/A==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1w539mnj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sat, 09 May 2026 19:47:21 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-12dc1c0b7ccso4013673c88.1
        for <iommu@lists.linux.dev>; Sat, 09 May 2026 12:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778356041; x=1778960841; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qcUTwwXxkf2HWH/ifvHwwRpDM+pCbfceyt9Fwp8UIyw=;
        b=duo9hczAFD+ppfPR1lBnoLktQvqvfOtorIdKY9PtgEWgN2tPtDCuj78FCiSy7S2kxn
         8kxttgoQiWqD7lIdDAfYZreZWmoFggAyX58YKRkUOXKVuYwQjEVx0GDE8FpOjuxEsnk2
         TRvDT8+lbzIwSoJ8ZmnIrER7QhMx+9Y0F6A9xdp0waagePgIw84iBCZRETYHqA6+3sFX
         qy/UZYmfTfLYQNuj/OOczw7XPdDzmcioS8qHaSHVVXb12q8ZcQLPotvp6oh0KGizH/cB
         sXbgFIh8bl7019R7x2IxEI/9danYtt8NVrYkV681uy0sQdLSDkVH34YVFsgqt+f+u4kq
         83jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778356041; x=1778960841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qcUTwwXxkf2HWH/ifvHwwRpDM+pCbfceyt9Fwp8UIyw=;
        b=ZRkJkXLWhM//HVjAmozAxbrbpFLolbUP5DCO48vpFlBsMMDKxkBRZXNVMcgUt+PDTi
         yplkAUTooGdqZcYIbqh/qMGfx8HTCvjRbbQ7Z2i13t8rSUq44BfpI/cycqeNGMipmSRZ
         wV+9YLtz+8mb3N/UnAfhjBwwm67evqcgwZEbMKfM3YT4TyLiJRtq86rL8zdNWxeS6Be+
         s8W0mWbdc7cmx3+X6EspwQKYSi+Pywrqe+b8Ln5R1/mlmI2srx6sDsNE4PhkcFl8pscS
         i8rkcJBfg+NJGPLPLpfyWenexKHA4XaYbeAal7+7YugDN+C8hpxuEMClnUCD2WuqDjxR
         H7Yw==
X-Forwarded-Encrypted: i=1; AFNElJ+CtOjpaihzOf7fATjei5g/LjeqM7u55ecdbl6PMukyKFAOTw5hstPCvJwpr5/pYc98D2L6UQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwhfRYUIAnKaqn+gKXU4ym6YVc9Hkl+ICyjS147H1fYK5Uz8BGS
	ux/U2zFlVpzFiFB92oxuFhWZapCX0SEPMroXHeYiLVEo0ZDnx2XEp2zI80AzQ2nRso0QadoidHJ
	NxZNr1IZ+Bg0AieGRcJTDPc9ocO+NlYNqSzmhvhNmrn/W+fCcquPqObjr+g==
X-Gm-Gg: Acq92OHpiRWANDvESlLOHEoTCKD9GUqco+bfRefjPRJKrndNN1fGrkkP6PgcAffyXzz
	r5b+N9bDWnevq+LWfjGlVqHjxTFgDJnFksD79X3HnkvsZZmyN5puVdspPmU5Tt14yAfb7uobQEU
	dcPOZkH7HoOdOHb1+Zgw8nAdNwYemt/xuKTVIDzjdp8tNkhU5YLy1IDaUbh9CDvvSaQKiXtN/CK
	WQXJbVNm1SbNevOvSL9NAX1PuiLlsSOEF9pk+0w0vSK8PGQtyRIrUursnshW6BbsuDjECo8iwrO
	qjw4b0WK6rdgAK6Z5A/oWGF0fd9MA49Do7SmDwIlBvUkUoNpZV6ODhna0d0rFTahQpx7QjFQXBp
	mwSbPqIMtelZ6/ch+FljPEfOXOn7nvj2+0k6cg2BQzQ==
X-Received: by 2002:a05:7022:618e:b0:12c:11d4:61dd with SMTP id a92af1059eb24-1323b0ad346mr5539111c88.18.1778356041162;
        Sat, 09 May 2026 12:47:21 -0700 (PDT)
X-Received: by 2002:a05:7022:618e:b0:12c:11d4:61dd with SMTP id a92af1059eb24-1323b0ad346mr5539100c88.18.1778356040555;
        Sat, 09 May 2026 12:47:20 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1327865a1a4sm7642342c88.10.2026.05.09.12.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 12:47:20 -0700 (PDT)
Date: Sat, 9 May 2026 14:47:18 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: fangyu.yu@linux.alibaba.com
Cc: anup@brainfault.org, iommu@lists.linux.dev, joro@8bytes.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, pjw@kernel.org, tjeznach@rivosinc.com,
        will@kernel.org
Subject: Re: [PATCH 1/2] iommu/riscv: Map IMSIC addresses for paging domains
Message-ID: <fhv3w4kmxd5kw26kdlj4uj7cgr5mhov7rytph6dedokdpe36d4@svjdhnilgnwe>
References: <20260508212339.381933-2-andrew.jones@oss.qualcomm.com>
 <20260509022113.53400-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260509022113.53400-1-fangyu.yu@linux.alibaba.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDIxMyBTYWx0ZWRfX6IA/zTe/Rs2T
 kRdjoR7nNuWhWKfdVRMwLz0wS4WCVhpwQPqg+MUuqv8VJIvo/WeV4Sui5Wj71S0yuuuFQJRK5Na
 7K+j16f/gAz1LUgE85ZH72FKdTUBcf3siNa0VhbDXKImKLjJNPOmP0ylSAMsDASYf2RumF7vHN4
 84gWUpJZ1YydjtFqgv4U6YEaBKZQzk01Y/d1t7n5eUdVnyJ2STSDXn6+GSHHHMh99PyabpMNl3o
 KNFew7BUcr7wtyF9fiBZSUa+0lQtpRdAUPwu9dPQikzQTLpNlqmbI4CBo9W8MEhEaz7NOcJu9vS
 mxgWTOmF2ZMgOSmt4C4zb+q127iIAHSw+UbOeGEzjIEjOa8rTp7sB8/fePDaCT7E17+RJA+gzm7
 1gYxRxF5ko5R3bjdZWd+Y0HNZQVA6HWB07ySHI/O/mjJKBKIsquV4Tr3cm04b+bD58nylpQJiPb
 BT6NB4E+E61kwQq4NcA==
X-Proofpoint-ORIG-GUID: d_on9Y8ZnqklGwl5milQkSFIO5OkYSgj
X-Authority-Analysis: v=2.4 cv=BYHoFLt2 c=1 sm=1 tr=0 ts=69ff8f49 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=SRrdq9N9AAAA:8 a=EUspDBNiAAAA:8 a=D_Gdn404MgaNtkQDlpwA:9 a=CjuIK1q_8ugA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: d_on9Y8ZnqklGwl5milQkSFIO5OkYSgj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_06,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605090213

On Sat, May 09, 2026 at 10:21:13AM +0800, fangyu.yu@linux.alibaba.com wrote:
> >When IOMMU_DMA is enabled, devices get paging domains and MSI writes
> >to IMSIC interrupt files must be handled correctly in the s-stage.
> >As the device always writes to the host physical IMSIC addresses,
> >which the IMSIC irqchip programs directly, install s-stage identity
> >mappings for the host IMSICs. But, use IOMMU_RESV_DIRECT_RELAXABLE
> >since the 1:1 mappings aren't required for device assignment.
> >
> >Loop over the cpus rather than imsic groups to handle asymmetric
> >configurations.
> >
> >Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> >---
> > drivers/iommu/riscv/iommu.c         | 34 +++++++++++++++++++++++++++++
> > include/linux/irqchip/riscv-imsic.h |  7 ++++++
> > 2 files changed, 41 insertions(+)
> >
> >diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> >index a31f50bbad35..3c6aa9d69f95 100644
> >--- a/drivers/iommu/riscv/iommu.c
> >+++ b/drivers/iommu/riscv/iommu.c
> >@@ -19,6 +19,7 @@
> > #include <linux/init.h>
> > #include <linux/iommu.h>
> > #include <linux/iopoll.h>
> >+#include <linux/irqchip/riscv-imsic.h>
> > #include <linux/kernel.h>
> > #include <linux/pci.h>
> > #include <linux/generic_pt/iommu.h>
> >@@ -1286,6 +1287,38 @@ static struct iommu_domain *riscv_iommu_alloc_paging_domain(struct device *dev)
> > 	return &domain->domain;
> > }
> >
> >+static void riscv_iommu_get_resv_regions(struct device *dev, struct list_head *head)
> >+{
> >+	const struct imsic_global_config *imsic_global;
> >+	unsigned int cpu;
> >+
> >+	if (!imsic_enabled())
> >+		return;
> >+
> >+	imsic_global = imsic_get_global_config();
> >+
> >+	for_each_possible_cpu(cpu) {
> >+		const struct imsic_local_config *local;
> >+		struct iommu_resv_region *reg;
> >+
> >+		local = per_cpu_ptr(imsic_global->local, cpu);
> >+		if (!local->msi_va)
> >+			continue;
> >+
> >+		/*
> >+		 * The device always writes to the host physical IMSIC address, so install
> >+		 * identity mappings directly. Use IOMMU_RESV_DIRECT_RELAXABLE instead of
> >+		 * IOMMU_RESV_DIRECT since these 1:1 mappings are not required for assigned
> >+		 * devices.
> >+		 */
> >+		reg = iommu_alloc_resv_region(local->msi_pa, IMSIC_MMIO_PAGE_SZ,
> >+					      IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO,
> >+					      IOMMU_RESV_DIRECT_RELAXABLE, GFP_KERNEL);
> >+		if (reg)
> >+			list_add_tail(&reg->list, head);
> >+	}
> >+}
> >+
> 
> Hi Andrew,
> 
> Thanks for picking this up -- enabling IOMMU_DMA on RISC-V has been
> along-standing gap, and handling the IMSIC MSI mapping is the missing
> piece that finally unblocks it.
> 
> One concern is that the current implementation emits one 4 KiB
> RESV_DIRECT_RELAXABLE region for each possible CPU. On platforms
> with hundreds of harts, this noticeably increases the cost of both
> .get_resv_regions() and the iommu_create_device_direct_mappings()
> walk.
> 
> Since interrupt files within one IMSIC group occupy a physically
> contiguous range, would it make sense to emit one region per IMSIC
> group covering the full group stride, aligned down/up to 2 MiB so
> the core can map it as a superpage? This would over-map some padding
> within the IMSIC PA window, but RESV_DIRECT_RELAXABLE keeps the
> padding out of assigned-device IOVA space, so it looks harmless.
> 

Hi Fangyu,

Thanks for pointing out this issue. We'll need to decide how much we
want to isolate the devices from VMs in order to address it, though,
because, if we do group mappings, then we'll also be exposing the guest
interrupt files to the devices.

I'll certainly send a v2 to do larger mappings when s-mode imsics are
contiguous (nr-guest-files = 0) and then we can consider creating a
way to opt-in to group mappings even when nr-guest-files != 0. How's
that sound?

Thanks,
drew
