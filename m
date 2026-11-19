Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795094887;
	b=HoQKkVKg/rUm7uISxlJSg+55j3is3ArR6d04h2nO4zAVjFn4B5zXdd52MXBMkeX0Lw2V
	 aqXpgKs3NxugigvqG1kTeLNR+1pC6AeuK57OsL1Gp+Zv2Jjh00E6TEyQBxFrPl5mErXVN
	 +W88QAGdNGJH7W/9tA6pF4kTb+x7yS5SIwq1UmlQMetRHktEUPHWl6HkRHTtE6bFLFiou
	 PEEKlnY2+CEHsKlBBS/FYsoz/CsPgHB3mBwviHw/NKMhZfEhtQrLXopdSbuiVAzoEV+Pk
	 m0/fHuV41se3Duidiua4Q5ALWCjnIQGxRud633gJ53LqnTnFafewfJXGTUo0smP2PFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795094887;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:
	 X-Zmail-LocalSMTP:X-Zmail-RealSender:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-ZMAIL-USEORIGINALEMLTOOUTBOUND:Content-Transfer-Encoding:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=rQWvdNMaFe34tXuTWuwUVChXD/O05AF/rQwJk6Yds3Q=;
	b=bI+4Ss3ZPHeHADVzv2Bc25Cg4tAvPpV038oclZCBVm3uxbQ5Dusg48e3MHVhY+HzOhbQ
	 1ndXGTmaqK6Zo0L1Z/n2RCpCqh9xBXz7WI1MjIcCFPNXCAHD42alnTD1OEoSEOA2xMZgl
	 fsTr7e04+hIkT2ZuAeHOPcDAdqBgu4pM+/wMEVfi4Q2AiFJPAAn2G1mwwROKBDABy/llx
	 fWjr7YtHx1yMaFKCECchXuQu/WsC2AIvlpkmjhwJlHZ/5ZC7qO+uEryVTxuWNdt197Jxf
	 mgWJ9dMBlb5egOUUruLBTTInu5/9CIZ5NLiLHh1i3nk+7Yq8hxfHmpfVeXBKsh5IRgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sanechips.com.cn;
	spf=pass smtp.mailfrom=sanechips.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182C860A2600
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 13:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 182C860A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jVfRT6Tyxz4yjjC;
	Thu, 19 Nov 2026 21:28:05 +0800 (CST)
Received: from szxl2zmapp06.zte.com.cn ([10.1.32.108])
	by mse-fl1.zte.com.cn with SMTP id 6AJDRueG086425;
	Thu, 19 Nov 2026 21:27:56 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
	by smtp (Zmail) with SMTP;
	Thu, 19 Nov 2026 21:27:59 +0800
X-Zmail-TransId: 3e816afef95e02f-5654a
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: gong.shuai@sanechips.com.cn
From: Gong Shuai <gong.shuai@sanechips.com.cn>
To: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Tomasz Jeznach <tomasz.jeznach@linux.dev>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        Andrew Jones <andrew.jones@oss.qualcomm.com>,
        Fangyu Yu <fangyu.yu@linux.alibaba.com>,
        Tan Chi <tanchi25@mails.ucas.ac.cn>, Wu Fei <wu.fei9@sanechips.com.cn>,
        Zhao Qingye <zhao.qingye@sanechips.com.cn>,
        Gong Shuai <gong.shuai@sanechips.com.cn>
Subject: [RFC PATCH v3 09/10] iommu/riscv: Add riscv_iommu_attach_dev_nested
Date: Thu, 19 Nov 2026 21:27:43 +0800
Message-ID: <20261119132744.396426-10-gong.shuai@sanechips.com.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119132744.396426-1-gong.shuai@sanechips.com.cn>
References: <20261119132744.396426-1-gong.shuai@sanechips.com.cn>
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
X-MAIL:mse-fl1.zte.com.cn 6AJDRueG086425
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 19 Nov 2026 21:28:05 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AFEF965.001/4jVfRT6Tyxz4yjjC

From: Wu Fei <wu.fei9@sanechips.com.cn>

Attach a device to a nested domain by combining the guest provided
stage 1 context with the host-owned stage 2 context in the device
directory entry. This allows the physical IOMMU to translate device
DMA through both stages.

The device is bonded to the stage 2 parent domain so that it shares
the parent's invalidation state.

Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>
Co-developed-by: Gong Shuai <gong.shuai@sanechips.com.cn>
Signed-off-by: Gong Shuai <gong.shuai@sanechips.com.cn>
---
 drivers/iommu/riscv/iommu.c | 83 +++++++++++++++++++++++++++++--------
 1 file changed, 66 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 97d360318fe2..e8d894f3e760 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -889,29 +889,36 @@ struct riscv_iommu_bond {
 	struct list_head list;
 	struct rcu_head rcu;
 	struct device *dev;
+	int gscid;
 };
 
 static int riscv_iommu_bond_link(struct riscv_iommu_domain *domain,
-				 struct device *dev)
+				 struct device *dev, int gscid)
 {
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
-	struct riscv_iommu_bond *bond;
-	struct list_head *bonds;
+	struct riscv_iommu_bond *bond, *pos;
+	struct list_head *bonds = &domain->bonds;
 
 	bond = kzalloc_obj(*bond);
 	if (!bond)
 		return -ENOMEM;
 	bond->dev = dev;
+	bond->gscid = gscid;
 
 	/*
 	 * List of devices attached to the domain is arranged based on
-	 * managed IOMMU device.
+	 * managed IOMMU device and GSCID.
 	 */
 
 	spin_lock(&domain->lock);
-	list_for_each(bonds, &domain->bonds)
-		if (dev_to_iommu(list_entry(bonds, struct riscv_iommu_bond, list)->dev) == iommu)
+	list_for_each_entry(pos, &domain->bonds, list) {
+		if (dev_to_iommu(pos->dev) != iommu)
+			continue;
+
+		bonds = &pos->list;
+		if (pos->gscid == bond->gscid)
 			break;
+	}
 	list_add_rcu(&bond->list, bonds);
 	spin_unlock(&domain->lock);
 
@@ -1076,12 +1083,13 @@ static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
 	struct riscv_iommu_device *iommu, *prev;
 	struct riscv_iommu_bond *bond;
 	struct riscv_iommu_tlbi tlbi;
+	int prev_gscid = -1;
 
 	riscv_iommu_tlbi_calc(&tlbi, gather);
 
 	/*
-	 * For each IOMMU linked with this protection domain (via bonds->dev),
-	 * an IOTLB invaliation command will be submitted and executed.
+	 * For each IOMMU and GSCID linked with this protection domain through
+	 * its bonds, an IOTLB invalidation command will be submitted and executed.
 	 *
 	 * Possbile race with domain attach flow is handled by sequencing
 	 * bond creation - riscv_iommu_bond_link(), and device directory
@@ -1091,9 +1099,9 @@ static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
 	 * --------------------------         --------------------------
 	 * update page table entries          add dev to the bond list
 	 * FENCE RW,RW                        FENCE RW,RW
-	 * For all IOMMUs: (can be empty)     Update FSC/PSCID
-	 *   FENCE IOW,IOW                      FENCE IOW,IOW
-	 *   IOTLB.INVAL                        IODIR.INVAL
+	 * For all IOMMU/GSCID pairs:         Update FSC/PSCID
+	 *   FENCE IOW,IOW                    FENCE IOW,IOW
+	 *   IOTLB.INVAL                      IODIR.INVAL
 	 *   IOFENCE.C
 	 *
 	 * If bond list is not updated with new device, directory context will
@@ -1111,15 +1119,16 @@ static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
 
 		/*
 		 * IOTLB invalidation request can be safely omitted if already sent
-		 * to the IOMMU for the same PSCID, and with domain->bonds list
-		 * arranged based on the device's IOMMU, it's sufficient to check
-		 * last device the invalidation was sent to.
+		 * to the IOMMU for the same GSCID. Since bonds are arranged by
+		 * IOMMU and GSCID, it is sufficient to check the previous bond.
 		 */
-		if (iommu == prev)
+		if (iommu == prev && bond->gscid == prev_gscid)
 			continue;
 
-		riscv_iommu_iotlb_inval_iommu(iommu, domain->pscid, domain->gscid, &tlbi);
+		riscv_iommu_iotlb_inval_iommu(iommu, domain->pscid, bond->gscid,
+					      &tlbi);
 		prev = iommu;
+		prev_gscid = bond->gscid;
 	}
 
 	prev = NULL;
@@ -1394,7 +1403,7 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 	dc.ta = FIELD_PREP(RISCV_IOMMU_DC_TA_PSCID, domain->pscid);
 	dc.tc |= RISCV_IOMMU_DC_TC_V;
 
-	if (riscv_iommu_bond_link(domain, dev))
+	if (riscv_iommu_bond_link(domain, dev, domain->gscid))
 		return -ENOMEM;
 
 	riscv_iommu_iodir_update(iommu, dev, &dc);
@@ -1710,12 +1719,52 @@ struct riscv_iommu_nested_domain {
 #define to_riscv_iommu_nested_domain(domain) \
 	container_of(domain, struct riscv_iommu_nested_domain, domain)
 
+static int riscv_iommu_attach_dev_nested(struct iommu_domain *domain,
+					 struct device *dev,
+					 struct iommu_domain *old_domain)
+{
+	struct riscv_iommu_nested_domain *nested_domain =
+		to_riscv_iommu_nested_domain(domain);
+	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
+	struct riscv_iommu_domain *s2_parent = nested_domain->viommu->s2_parent;
+	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
+	struct pt_iommu_riscv_64_hw_info pt_info;
+	struct riscv_iommu_dc dc = {0};
+
+	if (nested_domain->viommu->iommu != iommu)
+		return -EINVAL;
+
+	if (!s2_parent->nest_parent)
+		return -EINVAL;
+
+	pt_iommu_riscv_64_hw_info(&s2_parent->riscvpt, &pt_info);
+
+	dc.tc = nested_domain->tc;
+	dc.fsc = nested_domain->iosatp;
+
+	dc.iohgatp = FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_MODE, pt_info.iohgatp_mode) |
+		     FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_PPN, pt_info.ppn) |
+		     FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_GSCID,
+				nested_domain->viommu->gscid);
+	dc.ta = nested_domain->ta;
+
+	if (riscv_iommu_bond_link(s2_parent, dev, nested_domain->viommu->gscid))
+		return -ENOMEM;
+
+	riscv_iommu_iodir_update(iommu, dev, &dc);
+	riscv_iommu_bond_unlink(info->domain, dev);
+	info->domain = s2_parent;
+
+	return 0;
+}
+
 static void riscv_iommu_domain_nested_free(struct iommu_domain *domain)
 {
 	kfree(to_riscv_iommu_nested_domain(domain));
 }
 
 static const struct iommu_domain_ops riscv_iommu_nested_ops = {
+	.attach_dev = riscv_iommu_attach_dev_nested,
 	.free = riscv_iommu_domain_nested_free,
 };
 
-- 
2.53.0

