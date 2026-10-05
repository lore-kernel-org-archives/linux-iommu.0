Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C30B488207
	for <iommu@lists.linux.dev>; Mon,  5 Oct 2026 13:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791206794; cv=none; b=KKQP22FcXcq8ADJ/TxTwGYnIyol8clS44BZrpWQyEOWwNrYSkBjaiuJdp4JLsY2lH4fjR5PZP+I45lzapjyNPYKPXNHpk0zW4Ooyiyuf67Xvf5/VHhNVgtjTiY6NO3j8KjUiWy1B0t4+2LVI1MJrdhhhXeeomxi2uCzc/RLHj6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791206794; c=relaxed/simple;
	bh=ybpmuL2vYfyQDcAM/C2s5NUPCTLl2rgC9pKl9yGd0Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjQim5+VO6+muuCqD2IUex9XBi+8+XGbUnT5fBjU29rhp4cawwnVH6rHg8oimDCoqZiWd3G5clvBx3DP1UIPJckX6UTxo73sXuLQgMVhAV+02xbjwhV/XOE1JZ/kpZffmAiSD9MWNPNdbAQJQxeSrHxrRxf5u8NexaXU3bTL1SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ThrBDxLZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TQjmFb94; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ThrBDxLZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TQjmFb94"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695CFlMU1926097
	for <iommu@lists.linux.dev>; Mon, 5 Oct 2026 13:25:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=JDSp49czoELykwuV0c41NKt0
	WWebvsAlOsdvzWqmJjk=; b=ThrBDxLZbRBxo/UjtYhkuhkuLg0Uh4kM0MKwjJLf
	xm/A9+6Gtj4iAmBrvNZ7C0nl/fpvVgXJqgwb8Tih9OAI9Unr3xok853TLmZvk1fC
	RqC+UFkVNzFSL94sjL+hWvJ4/k0wvj0HnBa8wlqgfbGwwssvNzvT8q/swStZ5RGH
	yU5ldsDeaiGZ0xBgVxrB9KqrbRUZkaXea2FKoDQOZCEMcV6Tem68A+3hX1uZBV0n
	qwfdZPP76FWkVuzPoZri5/v2KatI3rplDHKULtnfzi9lwDiDWFBxi33+HcxezSju
	A3ld06RpJWAiKHwYzVeq/6c0LYPp2l4rVSuQmCeKgqeZSw==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com [74.125.224.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h3xgytbvd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 05 Oct 2026 13:25:31 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-67532014b2fso1934388d50.2
        for <iommu@lists.linux.dev>; Mon, 05 Oct 2026 06:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791206730; x=1791811530; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JDSp49czoELykwuV0c41NKt0WWebvsAlOsdvzWqmJjk=;
        b=TQjmFb94eXawASgcA08/biSixff1olUkVCbH0SMPTbYc2PNGAx5LbiIlHsHSKax6gg
         azrEYhuy3ic1gESs9mIoqDqNpG1F1oW2IGE/WgH8Wci+3NEJpEVs417v1JS/KQRCnelP
         wJa0MIVEKUlhTfvxxrIUNFWSL2qrxo24bGt2oVMTiJnvIHryAyKzMs9tHhbQDBVE+EN1
         vDdYSWfvu0/oBymvbwNjC0/8VodJdN/xYMgz655HuOuvevScUoY8IsfDzQ9ui7KSR+rc
         2ctUDuXW8qNO7KmijiFTaCCc0qrxCWzNdAxYzmbC9/LMgN5qvjmS34dgC1UuKygOrOst
         y2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791206730; x=1791811530;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JDSp49czoELykwuV0c41NKt0WWebvsAlOsdvzWqmJjk=;
        b=y7JUJmd4iJPvgUZTZKQazI7FJJUuw8YKzr42NKQTJk2J2JNF1RM1G4dT4Cl0UDNLJ0
         GoWA5MlC0PzPHh1ji2KpuqXkgOrFyT8IpR6ZXFqq+/17A6XV5Ca/4wJ4CYOUTAZwYYrk
         ekfF7APDjhM33ngrmC9YjgtTe9mlRKG2aDl73j0mK2e7O3aUzZ+h1KwiY7MKgeFe15m9
         SLUO43lHVFQoTFbpWBto40rPfSvVQDv0yTeNMNegEH2QRW+9/SMH3JPanl0F3TvfkwJZ
         Kx4ULC1gSwg9PdM5fLpxdyw4jila7/p+mWaf+p8h+vWt7xZ75XoFEl6DALOM77m7uBC9
         itTQ==
X-Gm-Message-State: AFq9FYLsu8JEnujoecoL2p/NsU/zdszd36kKKdxdaYgTRiXVWp7bHsmv
	tqZIh+4s9CuIdLMUi5XCOwvWN5yH+nzgnl/oJYWaPFdWiV6X5kMaIxRPXyOCTppWlsNk7yUkKaq
	9EVbXkWHb4j+wISIhqA1cOp2r5eGoaPEd2MDAJDahTNLEwsO4yEp5if1fk3qy5n+pRg==
X-Gm-Gg: AYBFou3zojM5I0JLxFG/goXlvXk9/+AA9WrJxMPVegISAtHKrzXCeu4UDOukb273+kT
	jLlrmpAfMCqySYg2YcjaDe+5XcJsHWp92k1RtbGnFaIrGLz0+g+LVZltJ7bPYWPShfN/sGSeQAf
	x6yarpJcymDyQRCL4ftSIXoOxRdpriFpbX9bkcnqtc+qdX2mbrK99cRO/afr6uUfz00gf02ZcID
	6N6U8YZ7nvCXngZqaLnn2C4WHH+hM8M1iQE0LY8MD6RF5QTXqWeHXJ+NAP3lNayxs3UgU5njVjh
	I9We88Uu07QXxo1h57jkPba5TmH4Up1rup3SdVa/hwowgkgXIkFZ1IgneaIsb0sjJvsc8NWgQLV
	krytWCeJOAsEJeLlY6IxAE1r9zKQ=
X-Received: by 2002:a53:db4c:0:b0:675:68f4:67cc with SMTP id 956f58d0204a3-677ac165dddmr3375787d50.80.1791206730501;
        Mon, 05 Oct 2026 06:25:30 -0700 (PDT)
X-Received: by 2002:a53:db4c:0:b0:675:68f4:67cc with SMTP id 956f58d0204a3-677ac165dddmr3375750d50.80.1791206728277;
        Mon, 05 Oct 2026 06:25:28 -0700 (PDT)
Received: from localhost (90-182-211-1.rcp.o2.cz. [90.182.211.1])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-677c1b4a383sm3109497d50.7.2026.10.05.06.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 06:25:27 -0700 (PDT)
Date: Mon, 5 Oct 2026 15:25:23 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: iommu@lists.linux.dev, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: tomasz.jeznach@linux.dev, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, tglx@kernel.org, anup@brainfault.org,
        atish.patra@linux.dev, fangyu.yu@linux.alibaba.com,
        zhangzhanpeng.jasper@bytedance.com, zong.li@sifive.com
Subject: Re: [RFC PATCH v3 01/14] iommu/riscv: Allocate MSI tables for
 second-stage domains
Message-ID: <dqo5xn7bz2wffbgolx76wryc7p7xsaygz2wrxhxvgnwekfpenu@tnu5uw4hauat>
References: <20260928143113.49838-1-andrew.jones@oss.qualcomm.com>
 <20260928143113.49838-2-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928143113.49838-2-andrew.jones@oss.qualcomm.com>
X-Proofpoint-GUID: 3bbDG5H9cCFt5eSEUrquSFzWmTcmjgFq
X-Proofpoint-ORIG-GUID: 3bbDG5H9cCFt5eSEUrquSFzWmTcmjgFq
X-Authority-Analysis: v=2.4 cv=A6b5rKWG c=1 sm=1 tr=0 ts=6ac3a54b cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=zRh97aRZNhiOMYVz81Er1w==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=WSAePdX2diYu_KTn0zcA:9 a=CjuIK1q_8ugA:10
 a=nd2WpGr1bMy9NW-iytEl:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA1MiBTYWx0ZWRfXzp7mwkFzLyAv
 gmFsGpLR/1h/LuTlu+oSvM5Me8vmVmOmPVdhribxfyG7fSGjMBQhSIkV6oy0/qqALLFqdXq7uhZ
 vXifWlKgBnxgn9Gzn6Q+n6Y6BKwtRndf9RFUyS5Vt22ITA+4v5F5BEqiqqRnlJhi/lSuis8+2+h
 gKIXZqNWUZXEMOXHCbSDrZ6isl7Pxuv3lo5HA37pkWs1Aj/xqS6saezu67fKRSzA1RUn1qVVzoM
 20hXdbUWoWsCTeP0koQsLz0Zi2pQ3VqFS1yd7hzmZJWIyUEdXHN6laa4L2uhToJwss+caup0wTW
 b9y0vPt4uM23+/Tpyk9e7uZwXK7GMCyuiBlNQxjMvFQKAC68VIzbTcRi+4iTPPwiiXx6Al1s3bT
 MD1LkadaQ8kQePvtO7z91u0Lc+0FauTLV5Jppi7mXDViwXPu12lAXveZEbMIEpnVrDUiWG8TFwU
 i+aUa6xEJJt0/Ok5Hxw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA1MiBTYWx0ZWRfXwB77S4ilp/ZV
 VqJVjIleDtHaHjZD+k9NWbYp2b81MkyPiPqN9mlP2px4eUis9tuDwNqQVKzc/J2dxWr2onBvV7S
 l6q8VYcCj6gybw8bII3G2AyOcYP0T+I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050052

On Mon, Sep 28, 2026 at 04:31:00PM +0200, Andrew Jones wrote:
> IRQ bypass maps guest IMSIC addresses through a flat-mode MSI page
> table owned by the second-stage domain. Allocate the table lazily
> during device attachment when the attaching IOMMU supports MSI_FLAT,
> and free it when the domain is destroyed.
> 
> The required capacity depends on hypervisor support and VMM policy.
> Expose the runtime-writable riscv_iommu.nr_msi_ptes parameter to set the
> MSI table capacity of new second-stage domains. It defaults to 512
> entries (8 KiB), and zero disables MSI table allocation for new domains.
> Existing domains retain the capacity selected when they were created.
> 
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> ---
>  drivers/iommu/riscv/iommu.c | 61 +++++++++++++++++++++++++++++++++++++
>  drivers/iommu/riscv/iommu.h |  7 +++++
>  2 files changed, 68 insertions(+)
> 
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index 0953aaf594cb..3bbb4d0d0a85 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -22,6 +22,8 @@
>  #include <linux/iopoll.h>
>  #include <linux/irqchip/riscv-imsic.h>
>  #include <linux/kernel.h>
> +#include <linux/moduleparam.h>
> +#include <linux/mutex.h>
>  #include <linux/pci.h>
>  #include <linux/generic_pt/iommu.h>
>  
> @@ -30,6 +32,16 @@
>  #include "iommu-bits.h"
>  #include "iommu.h"
>  
> +#undef MODULE_PARAM_PREFIX
> +#define MODULE_PARAM_PREFIX "riscv_iommu."
> +
> +#define RISCV_IOMMU_DEFAULT_NR_MSI_PTES	512
> +
> +/* A zero value disables guest MSI table allocation. */
> +static unsigned int riscv_iommu_nr_msi_ptes = RISCV_IOMMU_DEFAULT_NR_MSI_PTES;
> +module_param_named(nr_msi_ptes, riscv_iommu_nr_msi_ptes, uint, 0644);
> +MODULE_PARM_DESC(nr_msi_ptes, "Number of PTEs for new second-stage domains (default: 512)");

I never liked the need for this parameter. I think I have a way to remove
it, ensure table size supports (and no more than supports) the guest's
IMSIC topology, and moves ownership of the MSI table to the hypervisor
(which, since the MSI table is only needed for VM's, is likely the better
owner). I'll experiment with that idea for the next version.

Thanks,
drew
