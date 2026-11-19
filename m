Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795094888;
	b=lj6ywZuaRDGBXCvAwBtCjLKXaqqooE0To2JpnIJChDe9eOXWVpkhqHWwPmILQBV6qWb2
	 So2ceNY8I23hSeCzk/YjMyGzQ8qfhOKCMph91NndOMuc+vgQHNng1zNx4v21NIDBvbyy6
	 W6LnjTic/JWaVkiSQCccYB3GxQvNBQDu4QyyRBqjZqdnr5ZApKO1nGKGO4Qy7QX+sqCTB
	 J46HS27RQ9CUREUdwf/P2wQPoLHyDj9MNOdD4NeCr5f7kjSb+tzv+Zy1VLHYkXv42zcGX
	 ct5gyZOIaPgL5/RcDo91LUrrmI0OHIaXRLLIjwKmhA4n6S0o+ifX7IQcz+ET8V9MLWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795094888;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:
	 X-Zmail-LocalSMTP:X-Zmail-RealSender:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-ZMAIL-USEORIGINALEMLTOOUTBOUND:Content-Transfer-Encoding:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=S1wsRggrARZweiDv9YftbPDoThnyJyFxdlO6MAgPKJo=;
	b=NtFfn/KZyVlB+lq9csUrGlL88JFAGJ1c9pbl/yoC5TujM6beIczoqHtOQ6omp+5Q5NzR
	 2yd+fvxU+TyIoVMhVgZmECvFjK3mU8iNnV66iRrTIRNPHHjfcy3Jf+k108ZXdA4SLQJCe
	 TtJQAoV5OtGE4K6v+wXUBNG5lb9YYKalHGX4p6twUeAMQWcVDT8E0X0m/IWOgfoULlA0r
	 I42NehBzhQOpYZHtPiaSRn2mxP8p8N5PsY2xdTKuOxfdqoiZnh58Lvyt1DKWnYgOFn4/t
	 2SAviXmKt/7Zd6ls1LBUCbi0LgfO1KH8D634ioG7X6uzhlJP95FeAPPrigfIv+ZvFBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sanechips.com.cn;
	spf=pass smtp.mailfrom=sanechips.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0887760A3813
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 13:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0887760A3813
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jVfRP4wMQz5BNS0;
	Thu, 19 Nov 2026 21:28:01 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
	by mse-fl1.zte.com.cn with SMTP id 6AJDRtDM086414;
	Thu, 19 Nov 2026 21:27:55 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
	by smtp (Zmail) with SMTP;
	Thu, 19 Nov 2026 21:27:58 +0800
X-Zmail-TransId: 3e816afef95e02f-56520
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
Subject: [RFC PATCH v3 08/10] iommu/riscv: Add riscv_iommu_hw_info
Date: Thu, 19 Nov 2026 21:27:42 +0800
Message-ID: <20261119132744.396426-9-gong.shuai@sanechips.com.cn>
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
X-MAIL:mse-fl1.zte.com.cn 6AJDRtDM086414
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 19 Nov 2026 21:28:01 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AFEF961.000/4jVfRP4wMQz5BNS0

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
index 4df4411be417..97d360318fe2 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1979,9 +1979,27 @@ static int riscv_viommu_init(struct iommufd_viommu *viommu,
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

