Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792742170;
	b=bkUqd6ovOPcIk/iXNOoV4Z4SXsLabWgEGcHXaNfBuLYtDlkBC5/1JOUvsoarS7gNWhOX
	 LaDJXxDh4lrtYeCybudVVnq+nNjff8j6WQj2A5lThL+Tni2RqQEYT2fgMYqgeYbTfI/Rz
	 gx+fRTL2oMBOUbK5c0mts17NROsYjUIU6M52ELgak+RHuIvMRlDVgIhwhP0Rc0wkcgwKx
	 A7HXskbB0gW4qt5EvoizJmKQN+tP7tumXpXYedRmzJWlkAki641i0pV8QlW6mmFF+J2cu
	 6S8SOCSqRKMzk7Tshn8ZKqs93TIAQKy/Df3gNeksZkkPPBsff87MJ/57v/W1qDqzyUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792742170;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=ibP1S88/mUmJq9sseTW7ujzwJfT8mpyLTPTI3FU924o=;
	b=N4iHxtdblkyIbK5z2QeZu1h+qURygU6IlzOt2n7zk62lUYYebZDHpeb0/MCSrYzhFqlF
	 ZeKY6FEHguH9tC4N50t1/aAvs7s6DOwqaEFv4wI3MA+vu0KnkJT49CDj3kXqJCYf3MllE
	 L85o6DXO0v6i0yAsmFOSzW7qoIa/iuQ0zVlFMgwVAMcIWcUOhogxjitzPCHSz6YkmPTg3
	 j8ErLL02dmomKU01BC5NCewA+eBFjS6181Pnld1dtapJ1buMWjHZ4/OCx+QHnPoQZzAXK
	 wzE17ssqEmg0GQRd5vH4ag+91mAW0EGIzBNOwpesN/OVn84Na1pOO2KAWTJGrscxKeg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ox97/XIh";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2306606A31B;
	Fri, 23 Oct 2026 07:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ox97/XIh
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792742169;
	b=YLPVWVhCEgU5k34ju3WEH10Md/WavndZc700Aa+lq6KE0QtcgdWslFqJm8xHJQAW6wla
	 XiGwPjJswy0wjafr0Nsqi+fBR5Y+dZaPJ58LB3eMF7b5FR0qRxY1zjr3ekDam7d/gF8+W
	 ZuQ23AwC7I+DMIpheoO5N26sMVVKtBLC2bVNIOt7BI/TqPef1XHK/4NSo59QKRX9cA/dZ
	 GtB1zx6tjVMw3NyZeMcpBZ/CScUQ3OCumISByuVQpZt7UfMJs0GtyQ85mi7z+oxlkZp3s
	 G2qLyt5KvgYvZ3zQAx7vJx7WI0Q6oOlki795AIDjXaQnu03mhZVoz0mZb1ZOC4ofNdA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792742169;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=ibP1S88/mUmJq9sseTW7ujzwJfT8mpyLTPTI3FU924o=;
	b=kFKaWUI2pn02afSlGbWoEOUptpxspZ3zQLASxt+Bjj3V9nCwWhzVdAlMd+lebsqBr/Ir
	 FNrNpYGtg+S4ILKPeDkpN2nVriEM7642/fIB2r/nPmZV24CPmZjQvweghV5xr716dqywS
	 j+oYhY5Oa0oKl39K+7jWwzu2D60uwOp/hsSQO2B3yPkeYRJUrRlRcJldHf2AtN7/CQSWt
	 sxyfRr/ZFZCIU9GCI1rGEABTm1xudrxA1MGtulc4LT3Og2WCYCthIbA8luupzHcZhMyAE
	 4zw+utUqZz7BjeSGNoRELMbMSt5VUFgaAyybPkeVJUZyu5/9TXOPNIoo5z1smsd6DXQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A63671F01825;
	Fri, 23 Oct 2026 07:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792742169;
	bh=ibP1S88/mUmJq9sseTW7ujzwJfT8mpyLTPTI3FU924o=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=ox97/XIhMrG1PMqDmkQCUXl7UU78zqynff9CPBLWo/qiMxvb86WccCB0ebxaAGn5H
	 U7NzU+S5LsmHOzLS+eHgyYbtN/iYIP/4ZinN8Xwt7oRGln3NQk8pP3mZ4tUj6izmTw
	 EcjreRhYc64A7co6x5UUujBJ42sHDPrzKj+qOGpyaY0wWCbsHUmuQlRPHcAS8yUD0S
	 vwGKqSSibhO9mxFV8/YdMsHYk9nREGs4Kb8Gjbx93v6luoaPDQRhPCXHwdngskSEjC
	 DIrotMpefWjxhM57ARbZGEEZLhPNxj9Q34ugyCZruF0rHBNNaRW9/nl3OBLL0R9DkZ
	 t8XnsG3FpUOzw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 037BF443FE;
	Fri, 23 Oct 2026 07:56:08 +0000 (UTC)
From: Ishu Brar via B4 Relay <devnull+patches.brar.si@kernel.org>
Subject: [PATCH v2 0/2] iommu/arm-smmu-qcom: Add SM7250 support
Date: Fri, 23 Oct 2026 13:24:30 +0530
Message-Id: <20261023-smmu-sm7250-v2-0-8bb881ce19f5@brar.si>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NzQ6CMBCEX4Xs2Zq2yJ8n38NwgHYrawKYLhAN6
 bvb4tXLJF8y880OjJ6Q4Zrt4HEjpnmKoE8ZmKGbHijIRgYtdamkKgWP4xqj0oUUTVFZJ7VtdJ1
 DXLw8Onoftnv7Y177J5olKVJjIF5m/znuNpV6/82bElKgUs7IvL4Y19163/kzE7QhhC/ZArMAt
 gAAAA==
X-Change-ID: 20261016-smmu-sm7250-957df02d9283
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Ishu Brar <patches@brar.si>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792742166; l=1770;
 i=patches@brar.si; h=from:subject:message-id;
 bh=sQLOhZMi8aZbIqVsMhAfiz8/FuPFV6+J4pw61zOCgdE=;
 b=9Q+sBnjBwBjboIPiR/Ad0kQ1lgiFss5sSPJvkLB0DOL5jYe8jhRpQHcODvee7s5/620vV8P02
 HensHpKQT9jAyR/kTvQ7J909qy2quEecxQBdUAYoSfbETXuXqmHdH3S
X-Developer-Key: i=patches@brar.si; a=ed25519;
 pk=Ds+E23E3ntzjPzuBDyVRkOouclcNI5k75R+N42yJtCk=
X-Endpoint-Received: by B4 Relay for patches@brar.si/default with
 auth_id=1189
X-Original-From: Ishu Brar <patches@brar.si>
Reply-To: patches@brar.si

This documents SMMUs of Qualcomm SM7250 (Snapdragon
765/765G/768G) and skips Adreno SMMU PRR setup on it.

As on SM8250, firmware resets device when PRR registers are
written, which happens as soon as GPU creates its first per-process
pagetable. Patch 1 adds the compatible to binding (apps SMMU and GPU
SMMU). Patch 2 excludes it from PRR callbacks.

Tested on OnePlus Nord (SM7250) with Vulkan on Adreno 620. The SoC
devicetree nodes are not part of this series.

Signed-off-by: Ishu Brar <patches@brar.si>
---
Changes in v2:
- Patch 1: also add qcom,sm7250-smmu-500 to the allOf block that
  requires the ahb/bus/iface clocks, so the GPU SMMU clocks are
  validated like on sm8250 (sashiko review, confirmed by Krzysztof).
- Patch 2: unchanged.
- Link to v1: https://patch.msgid.link/20261016-smmu-sm7250-v1-0-e11fc0384cfa@brar.si

To: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: iommu@lists.linux.dev
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org

---
Ishu Brar (2):
      dt-bindings: arm-smmu: Document SM7250 SMMU
      iommu/arm-smmu-qcom: Skip PRR setup on SM7250 GPU SMMU

 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 4 ++++
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c            | 1 +
 2 files changed, 5 insertions(+)
---
base-commit: 7b7429c28ac01c8a2952225a4b8a742eec7359c3
change-id: 20261016-smmu-sm7250-957df02d9283

Best regards,
--  
Ishu Brar <patches@brar.si>


