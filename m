Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951453C8C65
	for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 08:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787818429; cv=none; b=UN0ctjdbTWSTYcu+ve7XLFuU/F7DyQFLXNOSZm9E6fxajm8W6lqcoH5Rwa6gLYH2Ut2CtAFWW+10LaNX/gwV756vugATxgwP7tugV45WmwRlJn+Jt+V4Vu7hUu6Pc+EkvTfWisb1IxswLnnDlG40FBCABdmioZ0dsqN0Q6cqBSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787818429; c=relaxed/simple;
	bh=EcGvZsbnoCJNIDMssVScuqlTcYDHHVb5XgWdPanN+f8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PEitPBuEEvaDpjB+lBeD59+GyUednh6bclnKDzd/qq7U2jDx3to3w+Mm9cYkrrcIHy8mWf1ZkE3CaNixe+Hxj/xqPOkrVRPYwZ5p450uYqnj63Y2KvYGVMk99vuiKapjaCq7q3XmPkJpY3H8QXReC6oSj2A7Ov7dnhMBX6YC0vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YYph8g5C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WqX756tU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YYph8g5C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WqX756tU"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R6RFkd087957
	for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 08:13:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7knKTinTUheTHdWdoJsyJUaJ
	WeLVQNabqsJFNmIigFg=; b=YYph8g5CqAiSfeGRCz1flJeDtistSfU9QRPTF5dy
	7qIs6fqQVfW92VQgmfY1YAz9X7qLq6Zy9Bir7mIODQiPL5TS/LvuT+013XARXbJr
	P9+x0LkipEufx6hq7GwHY9ygSm7LRULUbCqzafEt2nBupVBmTDxvTno3OiMd2QNZ
	VrqqmgEOo6iIUMrOnaI/1lwr1U6ZigsYOJ/jvRHn2astdYx6c0WOydR+E0xs723S
	uTNQcyURSNmkaS/coCs+qiy76R7Qu9zaOc+4zwoxeYVjJ0mJXsBSS6JqHnlUV5qN
	erveudL4MLrtPrim5GnBylqhJtbFjo//kuWQRWD6sfWj6A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga8m5hrju-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 08:13:40 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-52fa5c5a4a6so5740911cf.0
        for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 01:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787818419; x=1788423219; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7knKTinTUheTHdWdoJsyJUaJWeLVQNabqsJFNmIigFg=;
        b=WqX756tUxmht/Bkft2NrG6KOdX6y76uzGqIXxs/4dwY76zWN7rms2fN2MUBp9LAm4O
         BpFClLT2x8HoJNQlo1JfSur2oDwyAFCs1pSDdHnZ75dHUEQ3uG1pP8ocSHY2qhOBSogn
         vsTky89eOkJwf2BsZXxs03bppuxtBwjoISfGvuLYt+ZSamxCyKjRIs4BhSoWFDwT7Gge
         eXo2yllMiFOPyclLymI1nSbuMfybjM2neYS9dMGSykZtt44Og+CTdQtwbME8wjBY+UKI
         KxAWnvNmNiw9tcSpXvZ01fTEs/zvhkuWmoKcvbb2HIaghTgSBeSVBC8xLfVu3n0h5ZP4
         Ubcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787818419; x=1788423219;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7knKTinTUheTHdWdoJsyJUaJWeLVQNabqsJFNmIigFg=;
        b=ja1HJdSeE+w3PCeY8CpS04fEO7pfFMpRdNpn85Wg0dLMlhqOa2ImObq7UAcOVhilDz
         CiJMQa/3DSYU2BGrnMHxi9KPG78asHJ6RdVHoen3GKKGbuVKP6AeNERblTn1NYpbKKJ+
         jcmeWsTPeY7CZchselYUTfqPsRDVoRT3OOxQLVHYuZQebTLeDy+Wi7M7BSwGUJEOnnnm
         5hvG6YNSRvLBpkt4X+JNXe0i36DITYoMw8O0Mi9X48biUgA1zn5bJAUo/imXI/Oy5JD1
         OjAAZtIFgtojEPHEsqV0Zpfprj4/W8JkeYOQgNNZHJXqTmqRZt7wo1MNzYhlywljllgL
         aNbg==
X-Gm-Message-State: AFuF++k9ude9IiKDr/fItKrVmxqVdMSJpj8KenvwYqx2ANpI8iCAWHva
	CGoDCn/BlTMjV1b0kKsLxYxV/P5BSmndWp29vcLMYaRzqIWIoZ/t/3al19PD3lGxnic+MT9+9pt
	R6XfuLxS1tvL61oFXpReVTWBaC1jSn9mUkvNM0q8agugXORKvff5XPgv4a5o15xXTLw==
X-Gm-Gg: AR+sD12DjUK+VjMJhJKj9fl1GMGj733YR/KgsdW0I5f5QoIRlwLj8IHYTxq3MZXHqTR
	1BjcOkI5Dz+CCZim/LeX2cd/rsFcPAX+FvRoSS9wwptn5/dW/FmVM9uZgcdf39fDEj3MeCI+DNk
	P6kxtP4cHT1PuzvVH1cCYvC9AnfFjDof/CNdsrhcVyE0wa/aDn3bmp+h4ojhlrdguGcuNfTm1et
	VCnqczWjZICeIZiKZeny9DhOr/PCjJy8WCCFE/IV1mpYiW1yvh+jgE2uVZw1zlyBcEhW+eV9CBs
	vTyJQ7kQOJqL8ghGSvL2Mes89WboGtv9CXzBVkMVZPdpJ7IxquThF1b/qZGkhsQaAoNWlGm7d09
	CZ99wxSGM81L/0nARYjrpfctXVnY0O7HPoBI=
X-Received: by 2002:a05:622a:608a:b0:52d:99e8:46b7 with SMTP id d75a77b69052e-52e42323362mr147992131cf.22.1787818419439;
        Thu, 27 Aug 2026 01:13:39 -0700 (PDT)
X-Received: by 2002:a05:622a:608a:b0:52d:99e8:46b7 with SMTP id d75a77b69052e-52e42323362mr147991621cf.22.1787818418960;
        Thu, 27 Aug 2026 01:13:38 -0700 (PDT)
Received: from localhost (ip-86-49-251-7.bb.vodafone.cz. [86.49.251.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e27ab6d0sm7031965f8f.13.2026.08.27.01.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 01:13:38 -0700 (PDT)
Date: Thu, 27 Aug 2026 10:13:37 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: jgg@ziepe.ca, kevin.tian@intel.com, robin.murphy@arm.com, joro@8bytes.org,
        will@kernel.org
Subject: Re: [RFC PATCH v1 0/8] iommu: Add contiguous MSI mapping support
Message-ID: <wvwuvvhmhdoa5kbx3gqae7lrvrseubeg2hepc3xswwjad672xb@5n67tcvbkavm>
References: <20260826145302.449904-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826145302.449904-1-andrew.jones@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: jLWeiYiId76Vl4zqoVvLYUlBdeoubFLR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA2NyBTYWx0ZWRfX3cuuMjjZ7PVu
 k8GrepoY2PL3ujAoLf5if7l5KZtGMndtAWyM07hrKSc24re0jlLSwQ/wxVZ0JV96lqQ467JJE98
 fRXBz8tro8vocrOJvEAyJ0pYoeHkPr8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA2NyBTYWx0ZWRfXyyxCmgp3ukQB
 UUNqTcBWQWbtI984VEMLkV28qRUya0dBQhjBCUATZ1DhtcKxI4Xt0LuxoCGnZPrp9tYn1lYjmoQ
 U6MvHrhicOjLel23Z1QaaVVHHYWT1mTeQBiFG7MC5DTRNBwHDauHySNdNDOu0uhp8Sf9CV1N2EA
 ZfMUbEpTtP4J1+65bGuqtwA1iBUQRUHG3LdpsgvJLtJI5V1v9Ouyy/fPiuMeitiwDvzKiQTOS4F
 KOHFuZWLEq6IHuQfvP34XnEOkGqqUEydEw7wDavYXl4P3s0InGvPefFCVBn/I+Kl9HDl79pSXNW
 vrUQU0z9pxdmnRq9TjYEa0OmosNHTZxh3brYEPn74Tbam1Ny7/7SL5icIZ+Db9IdVDsj26WY+E2
 +LdTRslOXtJ1hJoHTQTmaJqtuClxcsCCKnZ7+pH5a0Pr+2YIjWP5L3jty3aUFxXBTbbhj/zne8k
 rlpJpAxn+D/NQmiVRqQ==
X-Proofpoint-GUID: jLWeiYiId76Vl4zqoVvLYUlBdeoubFLR
X-Authority-Analysis: v=2.4 cv=SomgLvO0 c=1 sm=1 tr=0 ts=6a8ff1b4 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=on9AXyaqQ0RhfYpiXjjEXA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=2znifY0NdIQrjKshjbUA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270067

On Wed, Aug 26, 2026 at 04:52:54PM +0200, Andrew Jones wrote:
> The RISC-V IOMMU MSI remapping series [1] needs to prepare mappings for
> every possible IMSIC target before MSI composition may occur in atomic
> context. The previous approach mapped each physical address separately
> and kept a driver-owned PA-to-IOVA lookup table.
> 
> Jason Gunthorpe suggested passing the complete list of physical
> addresses through the existing MSI preparation flow. This series
> implements that idea as iommu_dma_prepare_msi_list(), which maps the
> ordered list into one contiguous IOVA range and records its base and
> granule shift in the MSI descriptor. The interrupt-remapping driver can
> then derive the IOVA for each list entry without maintaining a separate
> IOVA array.
> 
> Both DMA-IOMMU and iommufd backends are extended to support these list
> mappings. The existing per-page mapping objects are retained, while
> the first object identifies the complete range so identical lists can
> reuse an existing mapping. iommufd allocates and installs a complete
> range atomically and grows its software-MSI bitmaps beyond their
> previous 64-entry limit.
> 
> This is being posted separately from the RISC-V MSI remapping work for
> early RFC review of the common DMA-IOMMU and iommufd interfaces. The
> RISC-V adaptation to iommu_dma_prepare_msi_list() is still in progress
> and will be posted later.
>

Applying this to riscv makes the MSI remapping surprisingly (to me) simple
and unintrusive (IMHO) to the IMSIC driver. Only the changes below were
needed.

I'll post this series along with the imsic and kconfig changes as v5 of
the riscv host msi remapping series without the RFC tag.

Thanks,
drew


diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 42f2278a702d..c7cda52b21eb 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -656,6 +656,7 @@ config RISCV_IMSIC
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_IRQ_MATRIX_ALLOCATOR
 	select GENERIC_MSI_IRQ
+	select IRQ_MSI_IOMMU
 	select IRQ_MSI_LIB
 
 config RISCV_RPMI_SYSMSI
diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
index 643c8e459611..72f595c0d320 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -10,6 +10,7 @@
 #include <linux/cpu.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/iommu.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
 #include <linux/irqdomain.h>
@@ -69,8 +70,10 @@ static void imsic_irq_ack(struct irq_data *d)
 	irq_move_irq(d);
 }
 
-static void imsic_irq_compose_vector_msg(struct imsic_vector *vec, struct msi_msg *msg)
+static void imsic_irq_compose_vector_msg(struct irq_data *d, struct imsic_vector *vec,
+					 struct msi_msg *msg)
 {
+	struct msi_desc *desc = irq_data_get_msi_desc(d);
 	phys_addr_t msi_addr;
 
 	if (WARN_ON(!vec))
@@ -79,6 +82,14 @@ static void imsic_irq_compose_vector_msg(struct imsic_vector *vec, struct msi_ms
 	if (WARN_ON(!imsic_cpu_page_phys(vec->cpu, 0, &msi_addr)))
 		return;
 
+	if (desc->iommu_msi_shift) {
+		const struct imsic_local_config *local;
+
+		local = per_cpu_ptr(imsic->global.local, vec->cpu);
+		msi_addr = (desc->iommu_msi_iova << desc->iommu_msi_shift) +
+			   local->smode_msi_pa_index * IMSIC_MMIO_PAGE_SZ;
+	}
+
 	msg->address_hi = upper_32_bits(msi_addr);
 	msg->address_lo = lower_32_bits(msi_addr);
 	msg->data = vec->local_id;
@@ -86,7 +97,7 @@ static void imsic_irq_compose_vector_msg(struct imsic_vector *vec, struct msi_ms
 
 static void imsic_irq_compose_msg(struct irq_data *d, struct msi_msg *msg)
 {
-	imsic_irq_compose_vector_msg(irq_data_get_irq_chip_data(d), msg);
+	imsic_irq_compose_vector_msg(d, irq_data_get_irq_chip_data(d), msg);
 }
 
 #ifdef CONFIG_SMP
@@ -94,7 +105,7 @@ static void imsic_msi_update_msg(struct irq_data *d, struct imsic_vector *vec)
 {
 	struct msi_msg msg = { };
 
-	imsic_irq_compose_vector_msg(vec, &msg);
+	imsic_irq_compose_vector_msg(d, vec, &msg);
 	irq_data_get_irq_chip(d)->irq_write_msi_msg(d, &msg);
 }
 
@@ -225,7 +236,9 @@ static struct irq_chip imsic_irq_base_chip = {
 static int imsic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 				  unsigned int nr_irqs, void *args)
 {
+	msi_alloc_info_t *info = args;
 	struct imsic_vector *vec;
+	int ret;
 
 	/* Multi-MSI is not supported yet. */
 	if (nr_irqs > 1)
@@ -235,6 +248,13 @@ static int imsic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	if (!vec)
 		return -ENOSPC;
 
+	ret = iommu_dma_prepare_msi_list(info->desc, imsic->smode_msi_pa,
+					 imsic->nr_smode_msi_pa, IMSIC_MMIO_PAGE_SZ);
+	if (ret) {
+		imsic_vector_free(vec);
+		return ret;
+	}
+
 	irq_domain_set_info(domain, virq, virq, &imsic_irq_base_chip, vec,
 			    handle_edge_irq, NULL, NULL);
 	irq_set_noprobe(virq);
diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
index b8d1bbbf42f7..082522081a2d 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -687,6 +687,32 @@ static int __init imsic_get_mmio_resource(struct fwnode_handle *fwnode,
 	return of_address_to_resource(to_of_node(fwnode), index, res);
 }
 
+static int __init imsic_init_smode_msi_pa(void)
+{
+	struct imsic_global_config *global = &imsic->global;
+	phys_addr_t *smode_msi_pa;
+	unsigned int cpu, index = 0;
+
+	smode_msi_pa = kcalloc(num_possible_cpus(), sizeof(*smode_msi_pa), GFP_KERNEL);
+	if (!smode_msi_pa)
+		return -ENOMEM;
+
+	for_each_possible_cpu(cpu) {
+		struct imsic_local_config *local = per_cpu_ptr(global->local, cpu);
+
+		if (!local->msi_pa)
+			continue;
+
+		local->smode_msi_pa_index = index;
+		smode_msi_pa[index] = local->msi_pa;
+		index++;
+	}
+
+	imsic->smode_msi_pa = smode_msi_pa;
+	imsic->nr_smode_msi_pa = index;
+	return 0;
+}
+
 static int __init imsic_parse_fwnode(struct fwnode_handle *fwnode,
 				     struct imsic_global_config *global,
 				     u32 *nr_parent_irqs,
@@ -937,6 +963,12 @@ int __init imsic_setup_state(struct fwnode_handle *fwnode, void *opaque)
 		goto out_local_cleanup;
 	}
 
+	rc = imsic_init_smode_msi_pa();
+	if (rc) {
+		pr_err("%pfwP: failed to initialize S-mode MSI addresses\n", fwnode);
+		goto out_local_cleanup;
+	}
+
 	/* Initialize matrix allocator */
 	rc = imsic_matrix_init();
 	if (rc) {
@@ -962,6 +994,7 @@ int __init imsic_setup_state(struct fwnode_handle *fwnode, void *opaque)
 out_free_local:
 	free_percpu(imsic->global.local);
 out_free_priv:
+	kfree(imsic->smode_msi_pa);
 	kfree(imsic);
 	imsic = NULL;
 	return rc;
diff --git a/drivers/irqchip/irq-riscv-imsic-state.h b/drivers/irqchip/irq-riscv-imsic-state.h
index c42ee180b305..7bc519340b12 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.h
+++ b/drivers/irqchip/irq-riscv-imsic-state.h
@@ -49,6 +49,8 @@ struct imsic_priv {
 
 	/* Global configuration common for all HARTs */
 	struct imsic_global_config		global;
+	phys_addr_t				*smode_msi_pa;
+	unsigned int				nr_smode_msi_pa;
 
 	/* Per-CPU state */
 	struct imsic_local_priv __percpu	*lpriv;
diff --git a/include/linux/irqchip/riscv-imsic.h b/include/linux/irqchip/riscv-imsic.h
index ce8fe1ead7a0..523022e0a144 100644
--- a/include/linux/irqchip/riscv-imsic.h
+++ b/include/linux/irqchip/riscv-imsic.h
@@ -40,6 +40,7 @@
 struct imsic_local_config {
 	phys_addr_t				msi_pa;
 	void __iomem				*msi_va;
+	unsigned int				smode_msi_pa_index;
 
 	/* Number of guest interrupt files per-HART */
 	u32					nr_guest_files;
