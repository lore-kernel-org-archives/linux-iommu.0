Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793611132;
	b=Ykyu+vDOP8GHGOTWRdelrZqzYJmtBwlFqH+RSS81iNvS8qf+ITrdYKhlXOyNwXRfjFWP
	 MFfsC1ch4xIPHjzoY7MYSIseW5mw80RLzyn8uCGJGM4EydX19ujMBF5fk1HEK3tf5hcDg
	 bpOGZw92QON+lomvS4ScgdFEyCX7KsEGmkQK1ZOk02itxJx2mGRfjbnVxk1NjNr+Ee0T0
	 7fiQVcDLxIjlwtdr5cs5avs347N6BocyranKfUf5k0RPzpmeBzKgjvKn2PDqpOgoTRvpt
	 un97FSDZTVz6Buu1LwlkS4upIDfmLFK7u6WS/5b0IWMjHIiZq0W0n7jAYIJYHW17Mmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793611132;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:
	 X-Zmail-LocalSMTP:X-Zmail-RealSender:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-ZMAIL-USEORIGINALEMLTOOUTBOUND:Content-Transfer-Encoding:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=SK/0ybD1acRxS0a7WmJeR0B6lpPCQ/+wdEtNUSwnhtw=;
	b=uoB0uUy266b3Bhqr5BWTYDUhAJMR/NF1jd5WqbuIp0rBEY+4ACyr1iFgtEnatsYyyCNs
	 j7AWV2IPYVHn9nJdUJp8zSdzxjV9t/Y+wtR68IS009SsBDwBKD7NiCAvehCEPsLH3YLcO
	 enKrIS6XB4d/nO1G/dvqgzmMxkFH+vT/q/zKz+ZYtQKOh5kek5eRhZCFcBPB/2Ud4gZVj
	 y96YzilkB1oV1tnSduZKkh5NZurMmG90HgsKZ36eJtVXY7WpAZKj9LvPH4tDCeAWnKVnp
	 1yfo9h2Xzw2fajhIKqzfNP9zZrKPz2sxNi2b4ebaSsmeNPF/19qlZh3Xg8yQ1jlPZIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sanechips.com.cn;
	spf=pass smtp.mailfrom=sanechips.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F09606A326
	for <iommu@lists.linux.dev>; Mon,  2 Nov 2026 09:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45F09606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jJ5jh6ZLjz8Xrrl;
	Mon, 02 Nov 2026 17:18:48 +0800 (CST)
Received: from szxl2zmapp06.zte.com.cn ([10.1.32.108])
	by mse-fl2.zte.com.cn with SMTP id 6A29Ic4i018555;
	Mon, 2 Nov 2026 17:18:38 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
	by smtp (Zmail) with SMTP;
	Mon, 2 Nov 2026 17:18:40 +0800
X-Zmail-TransId: 3e816ae85560029-030da
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: gong.shuai@sanechips.com.cn
From: Gong Shuai <gong.shuai@sanechips.com.cn>
To: fangyu.yu@linux.alibaba.com
Cc: alex@ghiti.fr, andrew.jones@linux.dev, anup@brainfault.org,
        aou@eecs.berkeley.edu, atish.patra@linux.dev, baolu.lu@linux.intel.com,
        gong.shuai@sanechips.com.cn, guoren@kernel.org, iommu@lists.linux.dev,
        jgg@nvidia.com, jgg@ziepe.ca, joerg.roedel@amd.com, joro@8bytes.org,
        jroedel@suse.de, kevin.tian@intel.com, kvm-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        nutty.liu@hotmail.com, palmer@dabbelt.com, pjw@kernel.org,
        robin.murphy@arm.com, skhawaja@google.com, tanchi25@mails.ucas.ac.cn,
        tomasz.jeznach@linux.dev, vasant.hegde@amd.com, will@kernel.org,
        zong.li@sifive.com
Subject: Re: [PATCH v6 09/10] iommu/riscv: Add dirty tracking support for second-stage domains
Date: Mon,  2 Nov 2026 17:18:23 +0800
Message-ID: <20261102091823.54287-1-gong.shuai@sanechips.com.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261031083014.15040-10-fangyu.yu@linux.alibaba.com>
References: <20261031083014.15040-10-fangyu.yu@linux.alibaba.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
Content-Transfer-Encoding: 8bit
X-MAIL:mse-fl2.zte.com.cn 6A29Ic4i018555
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Mon, 02 Nov 2026 17:18:48 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE85578.000/4jJ5jh6ZLjz8Xrrl

Hi Fangyu,

>From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>
>Add hardware dirty tracking support for second-stage (iohgatp) domains
>used in KVM VFIO device pass-through.
>
>The RISC-V IOMMU can automatically set the dirty bit in PTEs on write
>access when DC.tc.GADE is set and the hardware has AMO_HWAD capability.
>Wire this up to the iommufd dirty tracking interface:
>
>  - riscv_iommu_set_dirty_tracking(): Always enabled dirty tracking for
>    second-stage domain.
>
>  - riscv_iommu_dirty_ops: Exposes set_dirty_tracking and the generic
>    page-table read_and_clear_dirty via IOMMU_PT_DIRTY_OPS(riscv_64).
>
>  - domain_alloc_paging_flags: Assigns dirty_ops to second-stage domains
>    when AMO_HWAD is advertised in hardware capabilities.
>
>  - riscv_iommu_capable: Reports IOMMU_CAP_DIRTY_TRACKING when
>    AMO_HWAD is present.
>
>Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
>---
> drivers/iommu/riscv/iommu.c | 22 ++++++++++++++++++++++
> 1 file changed, 22 insertions(+)
>
>diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
>index fc7a80393833..9f572baeca74 100644
>--- a/drivers/iommu/riscv/iommu.c
>+++ b/drivers/iommu/riscv/iommu.c
>@@ -1377,6 +1377,21 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
> 	return 0;
> }
> 
>+static int riscv_iommu_set_dirty_tracking(struct iommu_domain *iommu_domain,
>+					  bool enable)
>+{
>+	/*
>+	 * Always enabled and the dirty bitmap is cleared prior to
>+	 * set_dirty_tracking().
>+	 */
>+	return 0;
>+}
>+
>+static const struct iommu_dirty_ops riscv_iommu_dirty_ops = {
>+	IOMMU_PT_DIRTY_OPS(riscv_64),
>+	.set_dirty_tracking = riscv_iommu_set_dirty_tracking,
>+};
>+
> static const struct iommu_domain_ops riscv_iommu_paging_domain_ops = {
> 	IOMMU_PT_DOMAIN_OPS(riscv_64),
> 	.attach_dev = riscv_iommu_attach_paging_domain,
>@@ -1439,6 +1454,9 @@ static int riscv_iommu_init_domain_s2(struct device *dev,
> 	if (domain->gscid < 0)
> 		return -ENOMEM;
> 
>+	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_AMO_HWAD)
>+		domain->domain.dirty_ops = &riscv_iommu_dirty_ops;

This sets dirty_ops based on whether the allocating device's IOMMU
supports AMO_HWAD. As I understand it, the domain/HWPT is not tied
to that IOMMU instance. A later attach may target a device behind
another instance without AMO_HWAD, and the attach can still succeed
with GADE disabled, potentially causing guest page faults.

Shouldn't we therefore revalidate AMO_HWAD cap for domains with
dirty_ops and reject this combination?

FYI, both AMD and Intel have attach-time dirty-tracking checks. See
drivers/iommu/intel/iommu.c:3195 and drivers/iommu/amd/iommu.c:3221.

Thanks,
Shuai

>+
> 	return 0;
> }
> 
>@@ -1559,9 +1577,13 @@ static struct iommu_group *riscv_iommu_device_group(struct device *dev)
> 
> static bool riscv_iommu_capable(struct device *dev, enum iommu_cap cap)
> {
>+	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
>+
> 	switch (cap) {
> 	case IOMMU_CAP_CACHE_COHERENCY:
> 		return dev_is_dma_coherent(dev);
>+	case IOMMU_CAP_DIRTY_TRACKING:
>+		return !!(iommu->caps & RISCV_IOMMU_CAPABILITIES_AMO_HWAD);
> 	default:
> 		return false;
> 	}
>-- 
>2.50.1

