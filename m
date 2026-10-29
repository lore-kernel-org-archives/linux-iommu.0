Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793254321;
	b=5U+11mEKm0cSBleKTzXEnO5GDvqnq/H3p2+NP5xLW6OmR/RSUno41DVx+7DWdFIVfcNa
	 aCSq97+dzocgH9PRcR0LFFUxmk116LcmYrzS0HHkXfZcGi3CNe78pY+y+YzqiIcpfET8w
	 i1dI3br0tfPtxsNBPlhiKJI0g20zE1G98LSD2BUIq9+hD71EGMz4baazCIqUWrBqwH6S2
	 7eAHVJ0fDZ8m+WYgJZejBxCeEcdjcfbFEwhAo8/KuvVJoyNntPtdaQyUkubs0duAK6eBw
	 hWRIS5OpuW4daqKV0GiWCPJG9dhPW6eYqIdQMDc+NqydKUG1K8PC6VPoMSLVfyd5kzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793254321;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:
	 X-Zmail-LocalSMTP:X-Zmail-RealSender:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-ZMAIL-USEORIGINALEMLTOOUTBOUND:Content-Transfer-Encoding:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=zF/ZgoW7SM4KpPWZvgdoiWNpXWUAfyqBdr40/sCKlHI=;
	b=WA7hDgI0ggrI3Pet2UAUZDo4s1jFgMQeCZlCTmZXxKpSpbQjcsuJrQzyDH/HekRPl9Z3
	 t7+eS2XD0V6WzrO7O8m7oB5CZqca7YMgIrjKFViOFSMEMDyv191e8m9SMete/N8YRZlTF
	 r+htcKDtWD7HdsG2rJW1imsIoLNFuITWeZD98nEDlHz6/hP91QqCDI0x8N0bUxEsUsMRB
	 J1Ja1lEjB1mUid0J4kyink5sHO008tXuUpmA69MMZ9hzMoB1/rpbMCsL41ejGZ99jhOEM
	 OfxuKzUPYFMfFdqy8fgh/OeYPW92cz6xoskkiThaPuPOx/rCXpnVH/bcX9yqyi529hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sanechips.com.cn;
	spf=pass smtp.mailfrom=sanechips.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C3C60A2612
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 06:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9C3C60A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jFYlp3mjdz5PkGr;
	Thu, 29 Oct 2026 14:11:50 +0800 (CST)
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
	by mse-fl1.zte.com.cn with SMTP id 69T6BcK6003178;
	Thu, 29 Oct 2026 14:11:38 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
	by smtp (Zmail) with SMTP;
	Thu, 29 Oct 2026 14:11:40 +0800
X-Zmail-TransId: 3e816ae2e39b027-e7d7a
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
        Wu Fei <wu.fei9@sanechips.com.cn>,
        Zhao Qingye <zhao.qingye@sanechips.com.cn>,
        Gong Shuai <gong.shuai@sanechips.com.cn>,
        Gong Shuai <gsh517025@gmail.com>
Subject: [RFC PATCH v2 8/9] iommu/riscv: Add riscv_iommu_hw_info
Date: Thu, 29 Oct 2026 14:11:30 +0800
Message-ID: <20261029061131.584453-9-gong.shuai@sanechips.com.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029061131.584453-1-gong.shuai@sanechips.com.cn>
References: <20261029061131.584453-1-gong.shuai@sanechips.com.cn>
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
X-MAIL:mse-fl1.zte.com.cn 69T6BcK6003178
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 29 Oct 2026 14:11:50 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE2E3A6.000/4jFYlp3mjdz5PkGr

From: Wu Fei <wu.fei9@sanechips.com.cn>

Implement the hw_info op to return the physical IOMMU capabilities
register. This allows IOMMU_GET_HW_INFO to report the available host
features to a VMM.

Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>
Signed-off-by: Gong Shuai <gong.shuai@sanechips.com.cn>
---
 drivers/iommu/riscv/iommu.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 6bcf214016c3..44fab79110ac 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1940,9 +1940,27 @@ static int riscv_viommu_init(struct iommufd_viommu *viommu,
 	return 0;
 }
 
+static void *riscv_iommu_hw_info(struct device *dev, u32 *length,
+				 enum iommu_hw_info_type *type)
+{
+	struct iommu_hw_info_riscv *info;
+	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
+
+	info = kzalloc_obj(*info);
+	if (!info)
+		return ERR_PTR(-ENOMEM);
+
+	info->capabilities = iommu->caps;
+	*length = sizeof(*info);
+	*type = IOMMU_HW_INFO_TYPE_RISCV;
+
+	return info;
+}
+
 static const struct iommu_ops riscv_iommu_ops = {
 	.of_xlate = riscv_iommu_of_xlate,
 	.capable = riscv_iommu_capable,
+	.hw_info = riscv_iommu_hw_info,
 	.identity_domain = &riscv_iommu_identity_domain,
 	.blocked_domain = &riscv_iommu_blocking_domain,
 	.release_domain = &riscv_iommu_blocking_domain,
-- 
2.53.0

